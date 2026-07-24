import numpy as np


code = 1

HLT = 0b1000000000000000
MI = 0b0100000000000000
RI = 0b0010000000000000
RO = 0b0001000000000000
IO = 0b0000100000000000
II = 0b0000010000000000
AI = 0b0000001000000000
AO = 0b0000000100000000
SUM_OUT = 0b0000000010000000
SU = 0b0000000001000000
BI = 0b0000000000100000
OI = 0b0000000000010000
CE = 0b0000000000001000
CO = 0b0000000000000100
J = 0b0000000000000010


SIGN_OFFSET = 1792
eeprom_data = [0] * (SIGN_OFFSET + 256)
def Display_28C16(code): 
    if (code == 0):
        # Define your hex values as a list of integers
        hex_values = [
            0x7E, 0x30, 0x6D, 0x79, 0x33, 0x5B, 0x5F, 0x70,
            0x7F, 0x7B, 0x77, 0x1F, 0x4E, 0x3D, 0x4F, 0x47
        ]

        for value in range(256):
            eeprom_data[value] = (hex_values[value % 10])

        for value in range(256):
            eeprom_data[value + 256] = (hex_values[(value // 10) % 10])

        for value in range(256):
            eeprom_data[value + 512] = (hex_values[(value // 100) % 10])

        for value in range(256):
            eeprom_data[value + 768] = (0)


        ONES_OFFSET = 1024
        TENS_OFFSET = 1280
        HUNDREDS_OFFSET = 1536

        # Fill two's complement tables (-128 to 127)
        for value in range(-128, 128):
            index = value & 0xFF  # convert signed value to 0–255
            # Ones place
            eeprom_data[ONES_OFFSET + index] = hex_values[abs(value) % 10]
            # Tens place
            eeprom_data[TENS_OFFSET + index] = hex_values[(abs(value) // 10) % 10]
            # Hundreds place
            eeprom_data[HUNDREDS_OFFSET + index] = hex_values[(abs(value) // 100) % 10]
            # Sign byte
            eeprom_data[SIGN_OFFSET + index] = 0x01 if value < 0 else 0x00

        return (eeprom_data)

EEPROM_Select = 1
def CPU_28C64 (code, EEPROM_Select):
    if code == 1:
        data = np.array([MI|CO, RO|II|CE, 0, 0, 0, 0, 0, 0,                     # 0000 - NOP
                        MI|CO, RO|II|CE, IO|MI, RO|AI, 0, 0, 0, 0,              # 0001 - LDA 
                        MI|CO, RO|II|CE, IO|MI, RO|BI, SUM_OUT|AI, 0, 0, 0,     # 0010 - ADD
                        MI|CO, RO|II|CE, IO|MI, RO|BI, SUM_OUT|AI|SU, 0, 0, 0,  # 0011 - SUB
                        MI|CO, RO|II|CE, IO|MI, AO|RI, 0, 0, 0, 0,              # 0100 - STA
                        MI|CO, RO|II|CE, IO|AI, 0, 0, 0, 0, 0,                  # 0101 - LDI
                        MI|CO, RO|II|CE, IO|J, 0, 0, 0, 0, 0,                   # 0110 - JMP
                        MI|CO, RO|II|CE, 0, 0, 0, 0, 0, 0,                      # 0111 - NOP
                        MI|CO, RO|II|CE, 0, 0, 0, 0, 0, 0,                      # 1000 - NOP            
                        MI|CO, RO|II|CE, 0, 0, 0, 0, 0, 0,                      # 1001 - NOP
                        MI|CO, RO|II|CE, 0, 0, 0, 0, 0, 0,                      # 1010 - NOP
                        MI|CO, RO|II|CE, 0, 0, 0, 0, 0, 0,                      # 1011 - NOP
                        MI|CO, RO|II|CE, 0, 0, 0, 0, 0, 0,                      # 1100 - NOP
                        MI|CO, RO|II|CE, 0, 0, 0, 0, 0, 0,                      # 1101 - NOP             
                        MI|CO, RO|II|CE, AO|OI, 0, 0, 0, 0, 0,                  # 1110 - OUT
                        MI|CO, RO|II|CE, HLT, 0, 0, 0, 0, 0,                    # 1111 - HLT                                                     
                        ], dtype = np.uint16) 
        
        if (EEPROM_Select == 0):
            for value in range(len(data)):
                index = value
                eeprom_data[index] = data[index] >> 8
        else:
            for value in range(len(data)):
                index = value
                eeprom_data[index] = data[index] >> 8
                eeprom_data[index + 128] = data[index] & 0xFF
        
        return eeprom_data

CPU_28C64(code, EEPROM_Select)
# Display_28C16(code)
# Convert to bytes and write to a binary file
with open("output.bin", "wb") as bin_file:
    bin_file.write(bytes(eeprom_data))

print("Binary file 'output.bin' created successfully.")