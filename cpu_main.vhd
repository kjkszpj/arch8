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
           db : inout  STD_LOGIC_VECTOR (7 downto 0);
           co : in  STD_LOGIC_VECTOR (31 downto 0);
           ci : out  STD_LOGIC_VECTOR (31 downto 0);
			  sMUX : inout std_logic_vector(2 downto 0);
			  sMCLK : out STD_LOGIC;
			  sMRD : out STD_LOGIC;
			  sIOW : out STD_LOGIC;
			  sIOR : out STD_LOGIC;
			  sCTRL4 : out STD_LOGIC;
			  sCTRL3 : out STD_LOGIC;
			  sCTRL2 : out STD_LOGIC;
			  sCTRL1 : out STD_LOGIC;
			  sMWR : out STD_LOGIC;
			  sCLK : in STD_LOGIC;
			  --- sCLKG : in STD_LOGIC;
			  sRUN : in STD_LOGIC;
			  sRESET : in STD_LOGIC;
			  sPRIX : in STD_LOGIC;
			  sKRIX : in STD_LOGIC);
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
		 Port ( reset : in STD_LOGIC;
    		 		  clk : in  STD_LOGIC;
				  load : in  STD_LOGIC;
				  x : in  STD_LOGIC_VECTOR (7 downto 0);
				  r : inout  STD_LOGIC_VECTOR (7 downto 0));
	end component;			  
	component mux_a is
		 Port ( muxa : in  STD_LOGIC;
				  tmp : in  STD_LOGIC_VECTOR (7 downto 0);
				  a : in  STD_LOGIC_VECTOR (7 downto 0);
				  result_a : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	component mux_b is
		 Port ( muxb   : in  STD_LOGIC_VECTOR (2 downto 0);
    		 		  io_query : in STD_LOGIC;
				  alu : in  STD_LOGIC_VECTOR (7 downto 0);
				  pch : in  STD_LOGIC_VECTOR (7 downto 0);
				  pcl : in  STD_LOGIC_VECTOR (7 downto 0);
				  adrh : in  STD_LOGIC_VECTOR (7 downto 0);
				  adrl : in  STD_LOGIC_VECTOR (7 downto 0);
				  krix   : in STD_LOGIC;
				  prix   : in STD_LOGIC;
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
		 Port ( reset : in STD_LOGIC;
    		 		  mclk : in  STD_LOGIC;
				  db : in  STD_LOGIC_VECTOR (7 downto 0);
				  ab : in  STD_LOGIC_VECTOR (15 downto 0);
				  adrh_load : in  STD_LOGIC;
				  adrl_load : in  STD_LOGIC;
				  ahs : in  STD_LOGIC;
				  adrh : inout  STD_LOGIC_VECTOR (7 downto 0);
				  adrl : inout  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	component regs is
		 Port ( reset : in STD_LOGIC;
    		 		  reg_load : in  STD_LOGIC;
				  needj : in  STD_LOGIC;
				  mclk : in  STD_LOGIC;
				  i : in  STD_LOGIC_VECTOR (1 downto 0);
				  j : in  STD_LOGIC_VECTOR (1 downto 0);
				  db : in  STD_LOGIC_VECTOR (7 downto 0);
				  r : out  STD_LOGIC_VECTOR (7 downto 0);
				  r0 : inout  STD_LOGIC_VECTOR (7 downto 0);
				  r1 : inout  STD_LOGIC_VECTOR (7 downto 0);
				  r2 : inout  STD_LOGIC_VECTOR (7 downto 0);
				  r3 : inout  STD_LOGIC_VECTOR (7 downto 0));
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
--- signal act_load	: STD_LOGIC;
signal reg_load	: STD_LOGIC;
signal needj		: STD_LOGIC;					---寄存器组, 用ri还是rj
signal regi			: STD_LOGIC_VECTOR (1 downto 0);		---regi编号
signal regj			: STD_LOGIC_VECTOR (1 downto 0);		---regj编号
signal muxa			: STD_LOGIC;					---alub的2路选择器
signal alus			: STD_LOGIC_VECTOR (2 downto 0);		---alu function选择
signal ir_load		: STD_LOGIC;
signal ir_reset	: STD_LOGIC;
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
signal flag_set	: STD_LOGIC;
signal mux_cin		: STD_LOGIC_VECTOR (1 DOWNTO 0);

---clk
signal mclk		: STD_LOGIC;					---微程序时钟
signal mpck		: STD_LOGIC;
signal mick		: STD_LOGIC;

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
signal clk			: STD_LOGIC;
signal a				: STD_LOGIC_VECTOR (7 DOWNTO 0);
--- signal act			: STD_LOGIC_VECTOR (7 DOWNTO 0);
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
---signal m				: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal reg			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal r0 			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal r1 			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal r2 			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal r3 			: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal md			: STD_LOGIC_VECTOR (9 DOWNTO 0);
signal mpc			: STD_LOGIC_VECTOR (9 DOWNTO 0);
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
	ia:		reg_a port map(db, mclk, a_load, a_asr, a_clear, a);
	alua <= a;
	
	itmp:	reg1 port map(reset, mclk, tmp_load, db, tmp);
	iregs:	regs port map(reset, reg_load, needj, mclk, regi, regj, db, reg, r0, r1, r2, r3);
	imuxa:	mux_a port map(muxa, tmp, reg, ma);
	alub <= ma;
	
	ialu:	alu port map(alua, alub, cin, alus(2), alus(1 downto 0), alu_result, cout);
	iir:		reg1 port map(reset, mclk, ir_load, db, ir);
---	iir:		reg_a port map(db, mclk, ir_load, '1', ir_reset, ir);
	iadr:	reg_adr port map(reset, mclk, db, ab, adrh_load, adrl_load, ahs, adrh, adrl);
	ipc:		reg2 port map(mclk, pc_inc, '1', pc_l, pc_reset, ab, "0000000000000000", pc);
	isp:		reg2 port map(mclk, sp_inc, sp_dec, '1', sp_reset, "0000000000000000", "0111111111111111", sp);
	imuxb:	mux_b port map(muxb, io_query, alu_result, pch, pcl, adrh, adrl, krix, prix, mb);
	imuxc:	mux_c port map(muxc, sp, adr, pc, mc);
	
	---read write
	crd <= crdx or not mclk;			---在mclk高电平可以写入
	cwr <= cwrx or not mclk;
	mrd <= crd or ab(15);
	mwr <= cwr or ab(15) or not clk;	---在clk高电平
	ior <= not ab(15) or not ab(0) or crd;
	iow <= not ab(15) or not ab(1) or cwr or not clk;	---在clk第二周期高电平写入？

	---micro decode
	md <=	("000" & ir(7 downto 4) & "111") when ir(7 downto 4) <= "0101" else
			("000" & ir(5 downto 2) & "111") when ir(7) = '0' else
			("00" & ir(7 downto 3) & "111");
	
	---mpc & mir
	impc: process (mpck, mpc_reset)
	begin
		if (mpc_reset = '0') then mpc <= "0000000000";
		elsif (mpck'event and mpck = '1') then 
			if (mpc_load = '0') then mpc <= md;
			else mpc <= mpc + 1;
			end if;
		end if;
	end process;

	ci(9 downto 0) <= mpc;
	ci(15 downto 10) <= "000000";

	imir: process (mick, reset)
	begin
		if (reset = '0') then mir <= "00000000000000000000000000000000";
		elsif (mick'event and mick = '1') then
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
	mpck <= not mclk and clk;
	mick <= not mpck;
	
	---reset thing
	pc_reset <= reset;
	sp_reset <= reset;
	impc_reset: process (mclk, reset)
	begin
		if (reset = '0') then mpc_reset <= '0';
		elsif (mclk'event and mclk = '1') then mpc_reset <= run;
		end if;
	end process;

	---pc_l, '0' for load
	pc_l <= 	'0' 		when pc_load = "000" else 
				not CF 	when pc_load = "001" else
				NF or ZF	when pc_load = "010" else
				ZF 		when pc_load = "011" else
				'1';

	---flag
	icf: process (mclk)
	begin
		if mclk'event and mclk = '0' then 
			if flag_set = '0' then
				cf <= cout;
			end if;
		end if;
	end process;

	izf: process (mclk)
	begin
		if (mclk'event and mclk = '0') then 
			if (flag_set = '0') then
				if (alu_result = "00000000") then zf <= '1'; else zf <= '0';
				end if;
			end if;
		end if;
	end process;

	inf: process (mclk)
	begin
		if (mclk'event and mclk = '0') then 
			if (flag_set = '0') then
				nf <= alu_result(7);
			end if;
		end if;
	end process;
	
	---cin logic, 0 for no cin
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
		if (mclk'event and mclk = '0') then
			adr_c <= cout;									---always load, no control signal needed
		end if;
	end process;
	
	---io related, query about 0xC000 before IO
	io_query <= not (ab(15) and ab(14)) or crd;
	
	---bus, ab, db, probably cb?
	ab <= mc;
	db <= mb;
	
	---control bus
	clk <= sCLK;
	run <= sRUN;
	reset <= sRESET;
	prix <= sPRIX;
	krix <= sKRIX;
	sMWR <= mwr;
	sMRD <= mrd;
	sMCLK <= mclk;
	sIOW <= iow;
	sIOR <= ior;
	
	---internel name
	regi <= ir(1 downto 0);
	regj <= ir(3 downto 2);
	pch <= pc(15 downto 8);
	pcl <= pc(7 downto 0);
	adr <= adrh & adrl;
	
	---MUX, to watch signal at ci(16--31)	   imuxb:	mux_b port map(muxb, alu_result, pch, pcl, adrh, adrl, mb);
	ci(31 downto 24) <= 		pcl	when sMUX = "000" else
							pch	when sMUX = "001" else
							adrh	when sMUX = "010" else
							cf & zf & nf & "0" & pc_load & pc_l	when sMUX = "011" else
							r0	when sMUX = "100" else
							r2 when sMUX = "101" else
							mir(31 downto 24) when sMUX = "110" else
							mir(15 downto 8) when sMUX = "111" else
							"00000000";	
	ci(23 downto 16) <=			ir	when sMUX = "000" else
							pcl	when sMUX = "001" else
							adrl	when sMUX = "010" else
							mpc(7 downto 0)	when sMUX = "011" else
							r1	when sMUX = "100" else	 
							r3 when sMUX = "101" else
							mir(23 downto 16) when sMUX = "110" else
							mir(7 downto 0) when sMUX = "111" else
							"00000000";
								
	---control signal list from mir
	a_load <= mir(0);
	a_asr <= mir(1);
	a_clear <= mir(2) and reset;
	tmp_load <= mir(3);
	sCTRL1 <= mir(4);
	sCTRL2 <= mir(4);
	sCTRL3 <= mir(4);							
	sCTRL4 <= mir(4);
	needj <= mir(5);
	reg_load <= mir(6);
	muxa <= mir(7);
	alus(0) <= mir(8);
	alus(1) <= mir(9);
	alus(2) <= mir(10);
	mux_cin(0) <= mir(11);
	mux_cin(1) <= mir(12);
	flag_set <= mir(13);
	ir_load <= mir(14);
	adrh_load <= mir(15);
	adrl_load <= mir(16);
	ahs <= mir(17);
	muxc(0) <= mir(18);
	muxc(1) <= mir(19);
	pc_inc <= mir(20);
	sp_dec <= mir(21);
	sp_inc <= mir(22);
	pc_load(0) <= mir(23);
	pc_load(1) <= mir(24);
	pc_load(2) <= mir(25);
	mpc_load <= mir(26);
	crdx <= mir(27);
	cwrx <= mir(28);
	muxb(0) <= mir(29);
	muxb(1) <= mir(30);
	muxb(2) <= mir(31);
end Behavioral;
