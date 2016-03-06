----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:41:34 03/05/2016 
-- Design Name: 
-- Module Name:    cpu_main - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cpu_main is
    Port ( ab : inout  STD_LOGIC_VECTOR (31 downto 0);
           db : inout  STD_LOGIC_VECTOR (31 downto 0);
           cb : inout  STD_LOGIC_VECTOR (31 downto 0);
           co : out  STD_LOGIC_VECTOR (31 downto 0);
           ci : in  STD_LOGIC_VECTOR (31 downto 0));
end cpu_main;

architecture Behavioral of cpu_main is
---组件
	component reg_a is
		 Port ( db : in  STD_LOGIC_VECTOR (7 downto 0);
				  mclk : in  STD_LOGIC;
				  a_load : in  STD_LOGIC;
				  asr : in  STD_LOGIC;
				  a_clear : in  STD_LOGIC;
				  a : inout  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	component reg1 is
		 Port ( clk : in  STD_LOGIC;
				  load : in  STD_LOGIC;
				  x : in  STD_LOGIC_VECTOR (7 downto 0);
				  r : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;			  
	component mux_a is
		 Port ( muxa : in  STD_LOGIC;
				  tmp : in  STD_LOGIC_VECTOR (7 downto 0);
				  a : in  STD_LOGIC_VECTOR (7 downto 0);
				  result_a : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	component mux_b is
		 Port ( muxb : in  STD_LOGIC_VECTOR (2 downto 0);
				  alu : in  STD_LOGIC_VECTOR (7 downto 0);
				  pch : in  STD_LOGIC_VECTOR (7 downto 0);
				  pcl : in  STD_LOGIC_VECTOR (7 downto 0);
				  adrh : in  STD_LOGIC_VECTOR (7 downto 0);
				  adrl : in  STD_LOGIC_VECTOR (7 downto 0);
				  db : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	component mux_c is
		 Port ( muxc : in  STD_LOGIC_VECTOR (1 downto 0);
				  sp : in  STD_LOGIC_VECTOR (15 downto 0);
				  adr : in  STD_LOGIC_VECTOR (15 downto 0);
				  pc : in  STD_LOGIC_VECTOR (15 downto 0);
				  ab : out  STD_LOGIC_VECTOR (15 downto 0));
	end component;
	component reg2 is
		 Port ( clk : in  STD_LOGIC;
				  inc : in  STD_LOGIC;
				  dec : in  STD_LOGIC;
				  load : in  STD_LOGIC;
				  reset : in  STD_LOGIC;
				  x : in  STD_LOGIC_VECTOR (15 downto 0);
				  y : in  STD_LOGIC_VECTOR (15 downto 0);
				  r : inout  STD_LOGIC_VECTOR (15 downto 0));
	end component;
	component reg_adr is
		 Port ( mclk : in  STD_LOGIC;
				  db : in  STD_LOGIC_VECTOR (7 downto 0);
				  adrh_load : in  STD_LOGIC;
				  adrl_load : in  STD_LOGIC;
				  ahs : in  STD_LOGIC;
				  adrh : inout  STD_LOGIC_VECTOR (7 downto 0);
				  adrl : inout  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	component regs is
		 Port ( reg_load : in  STD_LOGIC;
				  needj : in  STD_LOGIC;
				  mclk : in  STD_LOGIC;
				  i : in  STD_LOGIC_VECTOR (1 downto 0);
				  j : in  STD_LOGIC_VECTOR (1 downto 0);
				  db : in  STD_LOGIC_VECTOR (7 downto 0);
				  r : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	component alu is
		 Port ( a : in  STD_LOGIC_VECTOR (7 downto 0);
				  b : in  STD_LOGIC_VECTOR (7 downto 0);
				  cin : in  STD_LOGIC;
				  m : in  STD_LOGIC;
				  s : in  STD_LOGIC_VECTOR (1 downto 0);
				  result : out  STD_LOGIC_VECTOR (7 downto 0);
				  cout : out  STD_LOGIC);
	end component;


---control signal
signal a_load		: STD_LOGIC;
signal a_asr		: STD_LOGIC;					---算术右移信号
signal a_clear		: STD_LOGIC;					---to clear a as 0
signal tmp_load	: STD_LOGIC;
signal act_load	: STD_LOGIC;
signal reg_load	: STD_LOGIC;
signal needj		: STD_LOGIC;					---寄存器组, 用ri还是rj
signal regi			: STD_LOGIC_VECTOR (1 downto 0);		---regi编号
signal regj			: STD_LOGIC_VECTOR (1 downto 0);		---regj编号
signal muxa			: STD_LOGIC;					---alub的多路选择器
signal alus			: STD_LOGIC_VECTOR (2 downto 0);		---alu function选择
---TODO, signal CY
signal ir_load		: STD_LOGIC;
signal adrh_load	: STD_LOGIC;
signal adrl_load	: STD_LOGIC;
signal ahs			: STD_LOGIC;					---在adrh里面填0x7E, for @Aj
signal muxc			: STD_LOGIC_VECTOR (1 downto 0);		---地址总线ab输入的多路选择器
signal pc_inc		: STD_LOGIC;					---pc+1信号
signal pc_reset	: STD_LOGIC;					---pc = 0信号
signal pc_l			: STD_LOGIC;					---pc load信号
signal pc_load		: STD_LOGIC_VECTOR (2 downto 0);		---pc load输入选择
signal mpc_load	: STD_LOGIC;					---mpc load
signal crdx			: STD_LOGIC;					---读存储器(memory, keyboard, printer, device status)
signal cwrx			: STD_LOGIC;					---写存储器
signal sp_inc		: STD_LOGIC;
signal sp_dec		: STD_LOGIC;
signal sp_reset	: STD_LOGIC;
signal muxb			: STD_LOGIC_VECTOR (2 DOWNTO 0);		---数据总线db输入的多路选择器

---clk
signal cpu_clk		: STD_LOGIC;					---CPU时钟
signal mclk			: STD_LOGIC;					---微程序时钟
signal mpc_clk		: STD_LOGIC;
signal ir_clk		: STD_LOGIC;

---output or temperate signal
signal mrd			: STD_LOGIC;
signal mwr			: STD_LOGIC;
signal cin			: STD_LOGIC;
signal cout			: STD_LOGIC;
signal cf			: STD_LOGIC;
signal zf			: STD_LOGIC;
signal nf			: STD_LOGIC;
signal a				: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal act			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal alua			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal alub			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal alu_result	: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal tmp			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal ir			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal adrh			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal adrl			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal ma			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal mb			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal m				: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal reg			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal ddb 			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal aab			: STD_LOGIC_VECTOR (15 DOWNTO 0);
signal pc			: STD_LOGIC_VECTOR (15 DOWNTO 0);
signal adr			: STD_LOGIC_VECTOR (15 DOWNTO 0);
signal sp			: STD_LOGIC_VECTOR (15 DOWNTO 0);
signal mc			: STD_LOGIC_VECTOR (15 DOWNTO 0);

-----begin of program-----
begin
	ddb <= db(7 downto 0);
	ia:		reg_a port map(ddb, mclk, a_load, a_asr, a_clear, a);
	iact:		reg1 port map(mclk, act_load, a, act);
	alua <= act;
	
	itmp:		reg1 port map(mclk, tmp_load, ddb, tmp);
	iregs:	regs port map(reg_load, needj, mclk, regi, regj, ddb, reg);
	imuxa:	mux_a port map(muxa, tmp, reg, ma);
	alub <= ma;
	
	ialu:		alu port map(alua, alub, cin, alus(2), alus(1 downto 0), alu_result, cout);
	
	iir:		reg1 port map(ir_clk, ir_load, ddb, ir);
	
	iadr:		reg_adr port map(mclk, ddb, adrh_load, adrl_load, ahs, adrh, adrl);
	ipc:		reg2 port map(mclk, pc_inc, '1', pc_l, pc_reset, aab, "0000000000000000", pc);
	isp:		reg2 port map(mclk, sp_inc, sp_dec, '1', sp_reset, "0000000000000000", "0111111111111111", sp);
	imuxc:	mux_c port map(muxc, sp, adr, pc, mc);
	---combine db together
	---care about flag
	---mpc, mir thing
	---clock thing
end Behavioral;
