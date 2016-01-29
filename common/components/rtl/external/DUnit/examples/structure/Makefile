#$Id: Makefile,v 1.1 2009/03/11 15:17:42 lulin Exp $
ROOT=..\..

include $(ROOT)\Rules.mak

structure:
	$(DCC) -B diffunit\Project1.dpr 
	$(DCC) -B -DTESTING diffunit\Project1Test.dpr
	$(DCC) -B sameunit\Project1.dpr 
	$(DCC) -B -DTESTING sameunit\Project1Test.dpr

