FILE_A = "hi.txt"
FILE_B = "bye.txt"

with open(FILE_A,"r") as in_file:
    my_in = in_file.read().upper()


with open(FILE_B,"w") as out_file:
    out_file.write(my_in)



