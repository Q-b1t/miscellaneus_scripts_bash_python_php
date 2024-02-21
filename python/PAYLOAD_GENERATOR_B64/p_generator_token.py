import string
import base64



if __name__ == "__main__":
    OUTPUT_FILE = "payload.txt"
    alphabet = string.ascii_lowercase 
    prefix = "admin-03:23:07-"
    permutations = list()
    for i in range(len(alphabet)):
        for j in range(len(alphabet)):
            for k in range(len(alphabet)):
                permutations.append(f"{prefix}{alphabet[i]}{alphabet[j]}{alphabet[k]}")

    permutations = [f"{base64.b64encode(perm.encode()).decode()}\n" for perm in permutations]

    with open(OUTPUT_FILE,"w") as f:
        f.writelines(permutations)    
    f.close()
                  