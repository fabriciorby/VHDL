LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.all;
USE IEEE.NUMERIC_STD.ALL;


ENTITY binary_to_bcd IS
    PORT ( BINARY : IN  STD_LOGIC_VECTOR (11 DOWNTO 0);
           BCD_UNI : OUT  STD_LOGIC_VECTOR (3 DOWNTO 0);
           BCD_TEN : OUT  STD_LOGIC_VECTOR (3 DOWNTO 0);
           BCD_HUN : OUT  STD_LOGIC_VECTOR (3 DOWNTO 0);
           BCD_THO : OUT  STD_LOGIC_VECTOR (3 DOWNTO 0)
          );
END binary_to_bcd;

ARCHITECTURE funcionamento OF binary_to_bcd IS

BEGIN

PROCESS(BINARY)
  --VETOR BINARIO
  VARIABLE TEMP : STD_LOGIC_VECTOR (10 DOWNTO 0);
  
  VARIABLE AUX : STD_LOGIC_VECTOR (11 DOWNTO 0);

  --VETOR BCD
  VARIABLE BCD  : UNSIGNED (15 DOWNTO 0);

  -- BCD_THO = BCD(15 DOWNTO 12)
  -- BCD_HUN = BCD(11 DOWNTO 8)
  -- BCD_TEN = BCD(7 DOWNTO 4)
  -- UNITS   = BCD(3 DOWNTO 0)
  
  BEGIN
	
	IF BINARY(11) = '0' THEN
		TEMP := BINARY (10 DOWNTO 0);
	ELSE 
		AUX := (NOT BINARY) + '1';
		TEMP := AUX (10 DOWNTO 0);
	END IF;
  
    BCD := (OTHERS => '0');
    
    FOR i IN 0 TO 10 LOOP
    
      IF BCD(3 DOWNTO 0) > 4 THEN 
        BCD(3 DOWNTO 0) := BCD(3 DOWNTO 0) + 3;
      END IF;
      
      IF BCD(7 DOWNTO 4) > 4 THEN 
        BCD(7 DOWNTO 4) := BCD(7 DOWNTO 4) + 3;
      END IF;
    
      IF BCD(11 DOWNTO 8) > 4 THEN  
        BCD(11 DOWNTO 8) := BCD(11 DOWNTO 8) + 3;
      END IF;
    
      -- SHIFT LEFT
      BCD := BCD(14 DOWNTO 0) & TEMP(10);
      TEMP := TEMP(9 DOWNTO 0) & '0';
    
    END LOOP;
 
    BCD_UNI <= STD_LOGIC_VECTOR(BCD(3 DOWNTO 0));
    BCD_TEN <= STD_LOGIC_VECTOR(BCD(7 DOWNTO 4));
    BCD_HUN <= STD_LOGIC_VECTOR(BCD(11 DOWNTO 8));
    BCD_THO <= STD_LOGIC_VECTOR(BCD(15 DOWNTO 12));
  
  END PROCESS;            
  
END funcionamento;