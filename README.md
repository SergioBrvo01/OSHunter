# OSHunter
OSHunter is a lightweight Bash script designed to detect the operating system of a remote host by analyzing TTL (Time-To-Live) values from ICMP ping responses. It identifies whether a target system runs Windows, Linux, or macOS based on characteristic TTL ranges, providing quick reconnaissance for network administrators and security researchers.

## 🛠 Installation
```bash
git clone https://github.com/SergioBrvo01/OSHunter.git
cd OSHunter
chmod +x oshunter.sh
```

## Example Output
**Interactive:**
```bash
./oshunter.sh
IP Address (or 'q' to quit): 192.168.1.1
Detecting OS for 192.168.1.1...
[*] Detected TTL: 64
[+] Target OS: Linux or macOS
```

**Arguments:**
```bash
./oshunter.sh 192.168.1.30
Detecting OS for 192.168.1.30...
[*] Detected TTL: 64
[+] Target OS: Linux or macOS
```
