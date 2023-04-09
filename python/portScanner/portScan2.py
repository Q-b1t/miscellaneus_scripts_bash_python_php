import socket
import termcolor

def scan(targets, ports):
    print(f"[->] STARTING SCAN FOR {targets}")
    for port in range(1,ports):
        scanPort(targets,port)

def scanPort(ipAddress,port):
    # try to intiate the socker object in a scan 
    try:
        s = socket.socket(socket.AF_INET,socket.SOCK_STREAM) # tco socket
        s.connect((ipAddress,port))
        print(termcolor.colored(f"[+] Connected to {port} in {ipAddress}","green"))
        s.close() # close connection
    except:
        print(termcolor.colored(f"[-] Port {port} is closed","red"))


if __name__ == "__main__":
    targets = input("[*] Enter Targets To Scan (plit them by \",\"):")
    ports = int(input("[*] Enter How Many Ports You Want To Scan:"))
    if ',' in targets:
        print("[*] Scanning Multiple Targets")
        for ipAddress in targets.split(","):
            scan(ipAddress,ports)
    else:
        scan(targets,ports)