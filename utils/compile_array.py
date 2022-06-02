import sys

byte_file = open(sys.argv[1], 'rb').read()

output_str = "{"

for item in byte_file:
	output_str += str(hex(item))
	output_str += ", "

output_str = output_str[:-2]
output_str += "};"

print("\nNumber of bytes: {} \n".format(len(byte_file)))
print(output_str, "\n")
	