import sys

if len(sys.argv) != 2:
    print "Error: must supply name of DLL"
    sys.exit(1)

dllname = sys.argv[1]
b = file(dllname+".eio", "rb").read()
n = b.replace("__CPPdebugHook", "_XCPPdebugHook")
file(dllname+"exp.o", "wb").write(n)
