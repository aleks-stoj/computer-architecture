library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.pkg_riscv_sc.all;

entity main_decoder is 
  port(op             : in  STD_ULOGIC_VECTOR(6 downto 0); 
       ResultSrc      : out STD_ULOGIC_VECTOR(1 downto 0);
       MemWrite       : out STD_ULOGIC;
       Branch, ALUSrc : out STD_ULOGIC;
       RegWrite       : out STD_ULOGIC_VECTOR(1 downto 0); -- extended regwrite
       Jump           : out STD_ULOGIC;
       ImmSrc         : out STD_ULOGIC_VECTOR(IMM_SRC_SIZE-1 downto 0);
       ALUOp          : out STD_ULOGIC_VECTOR(1 downto 0));
end;

architecture bhv of main_decoder is
  signal controls: STD_ULOGIC_VECTOR(13 downto 0); -- extend to 13 bits
begin
  process(op) begin
    case op is
      --add aupic, jalr
      when "0000011" => controls <= "01000100100000"; -- lw
      when "0100011" => controls <= "00001110000000"; -- sw
      when "0110011" => controls <= "01---000001000"; -- R-type
      when "1100011" => controls <= "00010000010100"; -- beq
      when "0010011" => controls <= "01000100001000"; -- I-type ALU
      when "1101111" => controls <= "01011-0100--10"; -- jal
      when "1110011" => controls <= "00---00--00001"; -- ECALL
      when "0010111" => controls <= "01100100000000"; -- auipc
      when "1100111" => controls <= "01000101000010"; -- jalr
      when "0001011" => controls <= "11--0000001100"; -- CUSTOM INSTRUCTION
      when others    => controls <= "--------------"; -- not valid
    end case;
  end process;

  -- add ImmSrc(2)
  -- add RegWrite(1)
  (RegWrite(1), RegWrite(0), ImmSrc(2), ImmSrc(1), ImmSrc(0), ALUSrc, MemWrite, ResultSrc(1), ResultSrc(0), Branch, ALUOp(1), ALUOp(0), Jump, g_ecall) <= controls;
end;
