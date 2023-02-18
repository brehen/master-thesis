202211281955
Status: #idea

Tags: #IN5290 #hacking

# Get in touch with services

Example question:
> What is open-relay smtp and how to send an email with it?

Open-relay smtp is a smtp server that you can connect to without credentials. If one smtp server in a network is open-relay, then any email can be forged and used to spoof.

An attacker can connect to it, and send an email from it, to make it appear that the email was sent legitimately. 

---

`Where are we in the process of ethical hacking?`
- Mapped out general info about the target
- Gathered technical details
- Mapped target network
- Next step is to:
	- Find weakness
	- Exploit it

## Factory defaults

## Configuration errors
## Service specific attacks
- FTP
	- Anonymous login
	- Brute-forcing with hydra
	- Use exploits (exploit-db)
	- Buffer overflow
- SSH
	- Brute force
	- Using exploits
- SMTP
	- Open-relay access
		- If one of the clients smtp servers allows open-relay then any email can be written unseeingly
- DNS
	- Zone transfer
	- Domain enumeration
	- domain brute-forcing
	- 
- Web
- Binary Exploits
- ARP, Netbios, SMB
## Brute-forcing
Trying out multiple combinations
Either:
- Random
- Try out all combinations
- Use a list or dictionary

Brute-forcing tools: Hydra, ncrack and medusa

---
# references