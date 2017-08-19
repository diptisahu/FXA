import sys

fi=open(sys.argv[1],"r")
fo=open(sys.argv[2],"w")

fo.write("library ieee;\n")
fo.write("use ieee.std_logic_1164.all;\n")
fo.write("package mem_package is\n")
fo.write("type arr is array (65535 downto 0) of std_logic_vector(7 downto 0);\n")
fo.write("constant MEM_INIT : arr:= (\n")

cnt=0
for line in fi:
    fo.write(str(cnt)+" => "+"\""+(line[8:16]).rstrip('\n')+"\",\n")
    cnt+=1
    fo.write(str(cnt)+" => "+"\""+(line[0:8]).rstrip('\n')+"\",\n")
    cnt+=1

# for i in range(cnt,65535):
    # fo.write("x\"0000\",\n")

#fo.write("x\"0000\"\n")
fo.write("others => (others => '0')")
fo.write(");\n")
fo.write("end package mem_package;\n")
