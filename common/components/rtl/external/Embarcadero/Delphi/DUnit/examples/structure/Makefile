#$Id: Makefile,v 1.2 2013/05/24 13:30:08 lulin Exp $
ROOT=..\..

include $(ROOT)\Rules.mak

structure:
	$(DCC) -B diffunit\Project1.dpr 
	$(DCC) -B -DTESTING diffunit\Project1Test.dpr
	$(DCC) -B sameunit\Project1.dpr 
	$(DCC) -B -DTESTING sameunit\Project1Test.dpr

