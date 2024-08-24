import sys  
  
file_name = sys.argv[1]  

with open(file_name, 'r') as f:
    copy_file_name = 'config.mem'
    with open(copy_file_name, 'w') as cf:
        for line in f:
            if line[0:2] == '0x':
                for line_index in range(2, len(line)):
                    if line[line_index] != ',':
                         cf.write(line[line_index])
                    elif line[line_index + 1] == '0' and line[line_index + 2] == 'x':
                            line_index += 3
                            for i in range (2):
                                cf.write(line[line_index])
                                line_index += 1
                            cf.write('\n')
                            break