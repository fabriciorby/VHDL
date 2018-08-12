LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY maquinaMoore2 IS
	PORT ( 
		CLOCK	: IN  BIT;
		RESET	: IN  BIT;
		W		: IN  BIT;
		Z		: BUFFER BIT
	);

END maquinaMoore2;

ARCHITECTURE funcionamento OF maquinaMoore2 IS

	TYPE STATE_TYPE IS (A, B, C, D, E);
	
	SIGNAL y : STATE_TYPE;
		
	BEGIN
		
		PROCESS (RESET, CLOCK)
				
		BEGIN
								
			IF RESET = '0' THEN
				y <= A;
			ELSIF (CLOCK'EVENT AND CLOCK = '1') THEN
				CASE y IS
					WHEN A =>
						IF w = '0' THEN Y <= A;
						ELSE y <= B;
						END IF;
					WHEN B =>
						IF w = '0' THEN y <= A;
						ELSE y <= C;
						END IF;
					WHEN C =>
						IF w = '0' THEN y <= D;
						ELSE y <= C;
						END IF;
					WHEN D =>
						IF w = '0' THEN y <= A;
						ELSE y <= E;
						END IF;
					WHEN E =>
						IF w = '0' THEN y <= C;
						ELSE y <= A;
						END IF;
				END CASE;
			END IF;
		END PROCESS;
		
		z <= '1' WHEN y = E ELSE '0';
	
END funcionamento;