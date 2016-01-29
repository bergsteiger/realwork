// clTreeNode.h
/*
#ifdef __GO32__
	#include <_String.h>
#else
	#include <String.h>
#endif
*/
#include "fstring.h"

class clTreeNodeSplaySet;
//class ostream;

struct clTreeNode {
	FString name;
	clTreeNodeSplaySet *items;
	int level;
	int id;
	int pid;
	int children;
	int dchildren;
	unsigned dlen;
/*
	inline friend ostream& operator <<(ostream& s, const struct clTreeNode& a)
	{
		s << "(" << a.name << "," << a.id << "," << a.pid << ")";
		return (s);
	}
*/
};
