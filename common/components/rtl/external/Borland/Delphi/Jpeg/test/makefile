DCCADDLSWTS =	$(DCCADDLSWTS) -U$(JPG) -O$(JPG)\obj
DPRFILES =	testproj.dpr

default:	testproj.exec

makedir:
	$(NOP)

integration:
	$(MAKE) $(MAKESWTS) $(MAKEDEFS) -DMAKEDEFS="$(MAKEDEFS)" -DTARGET=integration -f $(MAKEFILENAME) default

debug:
	$(MAKE) $(MAKESWTS) -DDEBUG $(MAKEDEFS) -DMAKEDEFS="-DDEBUG $(MAKEDEFS)" -DTARGET=debug -f $(MAKEFILENAME) default
	
clean:		$(DPRCLEANFILES)
		$(DEFAULT_CLEAN)
