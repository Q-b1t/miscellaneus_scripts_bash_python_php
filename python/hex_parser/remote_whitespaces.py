if __name__ == '__main__':
    text_file = "hex_dump.txt"
    output_file = "hex_output.txt"
    with open(text_file,"r") as f:
        lines = f.readlines()
    f.close()
    text = ''.join([line for line in lines])
    text = text.replace("\n","")
    with open(output_file,"w") as o:
        o.write(text)
    o.close