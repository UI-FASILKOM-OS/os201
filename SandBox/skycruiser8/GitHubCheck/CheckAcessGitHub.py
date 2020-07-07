#!/usr/bin/env python3
"""
CheckAccessGitHub.py
==============================================================================
Author: Rafi Muhammad Daffa (skycruiser8)

INFO:
Scrapes GitHub Member Access to get users who have access to the repository.
(Now only supports 6 pages named "#", "0", "1", "2", "3", and "4"

VERSION:
v1 (2020-05-13 11:04 UTC+7) - Use more HTML files in loop
v0 (2020-03-31 12:50 UTC+7) - Initial Commit

This is free software :)
"""
out = open("GitHub-Admission-OS201.txt","w",encoding="cp850")
prelude = ("="*79)+"\n"
prelude += "HOW TO READ:\n"
prelude += "<GitHub Username> <Status>\n"
prelude += "Status = 0 --> Sudah daftar, belum diaccept. Cek email!\n"
prelude += "Status = 1 --> Sudah daftar dan sudah diaccept.\n"
prelude += ("="*79)+"\n"
out.write(prelude)
for i in ["#", "0", "1", "2", "3", "4"]:
    data = ""
    with open(f"{i}.html","r",encoding="cp850") as fd:
        data = fd.read()
        count = 0
        idx = 0
        result = ""
        while data.find('alt="@',idx) != -1:
            start = data.find('alt="@',idx)
            end = data.find('">',start)
            uname = data[start+6:end]
            check_status = data.find(f"Awaiting {uname}")
            if check_status != -1:
                status = 0
            else:
                status = 1
            if count >= 1:
                result+=f"{uname:25} {status}\n"
            count += 1
            idx = end
        out.write(result)
out.close()

# EOF
