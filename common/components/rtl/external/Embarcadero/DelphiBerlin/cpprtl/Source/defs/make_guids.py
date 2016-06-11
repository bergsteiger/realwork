import os
import sys
import re
import subprocess
import hashlib

assert(len(sys.argv) >= 3)
output = sys.argv[1]
inputfiles = sys.argv[2:]

BUILDDIR = "build"
if not os.path.isdir(BUILDDIR):
    os.mkdir(BUILDDIR)

guidfiles = []
guid_re = re.compile("_(\S+) segment virtual");

for input in inputfiles:
    lines = iter(file(input))
    for line in lines:
        matches = guid_re.match(line)
        if matches:
            asm = []
            guid = matches.group(1)
            guid_hash = hashlib.sha1()
            guid_hash.update(guid)
            basename = os.path.join(BUILDDIR, "guid_" + guid_hash.hexdigest())
            guidfiles.append(basename)
            out = file(basename + ".nasm", "w")
            asm.append("global " + guid)
            asm.append("SECTION .text");
            asm.append(guid + ":");
            asm.append(lines.next())
            out.writelines("\n".join(asm))
            out.close()
            lines.next()

tlibrsp = file("guids.rsp", "w")
for guid in guidfiles:
    srcfile = guid + ".nasm"
    destfile = guid + ".o"
    subprocess.call(["nasm.exe", "-t", "-felf64", "-o", destfile, srcfile])
    print >>tlibrsp, destfile, " ",
tlibrsp.close()

if os.path.exists(output):
    os.remove(output)
subprocess.call(["tlib64.exe", "/A", output, "/u", "@guids.rsp"])

# for guid in guidfiles:
#     os.remove(guid + ".nasm")
#     os.remove(guid + ".o")
