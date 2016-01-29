#ifndef __HNODE__H__
#define __HNODE__H__

#include <stdio.h>

#define INS_OK		0x00
#define INS_CONT	0x01
#define INS_BRK		0x02
#define INS_EXST	0x04
#define INS_CASE	0x08
#define INS_DIFFN	0x10
#define FND_CHLD	0x20
#define FND_INT		0x40
#define FND_APS		0x80

typedef unsigned char HN_STATUS;

class HNode;


class HNodeProcessor
{
public:
	virtual void doit(HNode *) {};
};

class HNode
{
	int _takepath(char* buf);
	int name_offs;

public:
	HNode(unsigned char bNeedOffs = 0):base(0),level(-1),name(0),p(0),childs(0),lastn(0),n(0),bIsFinal(0) { name_offs = bNeedOffs?4:0; };
	~HNode()
	{
		if (lastn) delete[] childs;
		if (name) free(name);
	}

	int base;
	int n;
	int level;
	char * name;
	void * p;
	unsigned char bIsFinal;
	HNode * childs;
	HNode * parent;
	int lastn;

	HNode& operator=(const HNode& copy);
	HN_STATUS addNode(const char * path, HNode*& res, int& badbase, int abase = 0);
	HN_STATUS addNode(const char * path, HNode*& res);
	HN_STATUS findNode(const char * path, HNode*& res);

	void collapseSingleNodes();
	char * path();

	void process(HNodeProcessor * pr);
};

#endif
