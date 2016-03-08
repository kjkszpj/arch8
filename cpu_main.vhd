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
    Port ( ab : inout  STD_LOGIC_VECTOR (15 downto 0);
           db : inout  STD_LOGIC_VECTOR (15 downto 0);
           cb : inout  STD_LOGIC_VECTOR (15 downto 0);
           co : in  STD_LOGIC_VECTOR (31 downto 0);
           ci : out  STD_LOGIC_VECTOR (31 downto 0);
			  clk : in  STD_LOGIC);
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
signal muxa			: STD_LOGIC;					---alub的??路选择器
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
signal run			: STD_LOGIC;
signal reset		: STD_LOGIC;
signal mpc_reset	: STD_LOGIC;
signal krix			: STD_LOGIC;
signal prix			: STD_LOGIC;
signal flag_set		: STD_LOGIC;
signal mux_cin		: STD_LOGIC_VECTOR (1 DOWNTO 0);

---clk
signal cpu_clk		: STD_LOGIC;					---CPU时钟
signal mclk			: STD_LOGIC;					---微程序时钟
signal mpc_clk		: STD_LOGIC;
signal mir_clk		: STD_LOGIC;
signal ir_clk		: STD_LOGIC;

---output or temperate signal
signal mrd			: STD_LOGIC;
signal mwr			: STD_LOGIC;
signal crd			: STD_LOGIC;
signal cwr			: STD_LOGIC;
signal cin			: STD_LOGIC;
signal cout			: STD_LOGIC;
signal cf			: STD_LOGIC;
signal zf			: STD_LOGIC;
signal nf			: STD_LOGIC;
signal adr_c		: STD_LOGIC;
signal io_query	: STD_LOGIC;
signal a				: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal act			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal alua			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal alub			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal alu_result	: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal tmp			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal ir			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal adrh			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal adrl			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal pch 			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal pcl 			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal ma			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal mb			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal m				: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal reg			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal ddb 			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal md			: STD_LOGIC_VECTOR (9 DOWNTO 0);
signal mpc			: STD_LOGIC_VECTOR (9 DOWNTO 0);
signal aab			: STD_LOGIC_VECTOR (15 DOWNTO 0);
signal pc			: STD_LOGIC_VECTOR (15 DOWNTO 0);
signal adr			: STD_LOGIC_VECTOR (15 DOWNTO 0);
signal sp			: STD_LOGIC_VECTOR (15 DOWNTO 0);
signal mc			: STD_LOGIC_VECTOR (15 DOWNTO 0);
signal mir			: STD_LOGIC_VECTOR (31 DOWNTO 0);

---IO related
signal ior 			: STD_LOGIC;
signal iow			: STD_LOGIC;

-----begin of program-----
begin
	---	ddb <= db(7 downto 0);
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
	imuxb:	mux_b port map(muxb, alu_result, pch, pcl, adrh, adrl, mb);
	imuxc:	mux_c port map(muxc, sp, adr, pc, mc);
	
	crd <= crdx or not mclk;			---在mclk高???绞笨赡芊⑸?	
	cwr <= cwrx or not mclk;
	mrd <= crd or ab(15);
	mwr <= cwr or ab(15) or not clk;
	
	---TODO, check
	ddb <= mb;
	
	---TODO, decode ir, check it
	md <= "000" & ir(7 downto 4) & "111";
	
	---mpc & mir
	impc: process (mpc_clk, mpc_reset)
	begin
		if (mpc_reset = '0') then mpc <= "0000000000";
		elsif (mpc_clk'event and mpc_clk = '1') then 
			if (mpc_load = '0') then mpc <= md;
			else mpc <= mpc + 1;
			end if;
		end if;
	end process;
	ci(9 downto 0) <= mpc;

	imir: process (mir_clk)
	begin
		if (mir_clk'event and mir_clk = '1') then
			mir <= co;
		end if;
	end process;
	
	---clock thing
	imclk: process (run, reset, clk, mclk)
	begin
		if (run = '0' or reset = '0') then mclk <= '0';
		elsif (clk'event and clk = '0') then mclk <= not mclk;
		end if;
	end process;
	mpc_clk <= not mclk and clk;
	mir_clk <= not mpc_clk;
	
	---reset signal
	pc_reset <= reset;
	sp_reset <= reset;
	mpc_reset <= reset;

	---pc_l
	ipc_load: process (pc_load, CF, ZF, NF)
	begin
		case pc_load is
			when "000" =>	pc_l <= '0';		---always load
			when "001" =>	pc_l <= not CF;		---JC
			when "010" =>	pc_l <= NF or ZF;	---JP
			when "011" =>	pc_l <= ZF;			---JNZ
			when "111" =>	pc_l <= '1';		---not load
			when others =>	pc_l <= '1';
		end case;
	end process;

	---flag
	icf: process (mclk)
	begin
		if mclk'event and mclk = '1' then 
			if flag_set = '0' then
				cf <= cout;
			end if;
		end if;
	end process;

	izf: process (mclk)
	begin
		if (mclk'event and mclk = '1') then 
			if (flag_set = '0') then
				zf <= not alu_result(7) and not alu_result(6) and not alu_result(5) and not alu_result(4) and not alu_result(3) and not alu_result(2) and not alu_result(1) and not alu_result(0);
			end if;
		end if;
	end process;

	inf: process (mclk)
	begin
		if (mclk'event and mclk = '1') then 
			if (flag_set = '0') then
				nf <= alu_result(7);
			end if;
		end if;
	end process;
	
	---cin logic
	icin: process (mux_cin, cf, adr_c)
	begin
		case mux_cin is
			when "00" =>	cin <= '0';
			when "01" =>	cin <= cf;
			when "10" =>	cin <= adr_c;
			when "11" =>	cin <= '1';
			when others =>	cin <= '0';
		end case;
	end process;

	iadr_c: process (mclk)
	begin
		if (mclk'event and mclk = '1') then
			adr_c <= cout;
		end if;
	end process;
	
	---io related, query about 0xC000 before io
	io_query <= not (ab(15) and ab(14)) or mrd;
	---warning, clk related?
	ior <= not ab(15) or not ab(0) or crd;
	iow <= not ab(15) or not ab(1) or cwr or not clk;
	
	---bus, ab, db, probably cb?
	ab <= mc;
	idb: process(io_query, krix, prix, ddb)
	begin
		if (io_query = '0') then
			db <= "00000000" & krix & "000000" & prix;
		else
			db <= "00000000" & ddb;
		end if;
	end process;
	
	---control signal list from mir
end Behavioral;
