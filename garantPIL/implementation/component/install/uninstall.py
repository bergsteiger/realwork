#  -*- coding: windows-1251 -*-
import sys, os, string

dirs = []
try:
    f = open("uninstall.ini")
    dirs = f.readlines()
    f.close()
except: pass

for d in dirs:
    d = string.strip(d)

    if (os.path.isfile(d)):
        try:
            os.remove(d)
            d = os.path.dirname(d)
        except: pass

    try:
        os.rmdir(d)
    except: pass
        