#include "osdep.h"
#include <string.h>
#include <strings.h>
#include "CaseString.defs.h"
#include "hnode.h"

HNode& HNode::operator=(const HNode& copy)
{
	base = copy.base;
	level = copy.level;
	n = copy.n;
	name_offs = copy.name_offs;
	
	if (name) free(name);
	name = strdup(copy.name);
	parent = copy.parent;
	
	if (lastn) delete[] childs;
	childs = 0; lastn = 0;
	if (copy.lastn)
	{
		childs = new HNode[lastn = copy.lastn];
		for (int i=0; i<lastn; i++)
		{
			childs[i] = copy.childs[i];
			childs[i].parent = this;
		}
	}
	if (copy.p) p = copy.p;
	return *this;
}

HN_STATUS HNode::addNode(const char * path, HNode*& res, int& badbase, int abase)
{
	int i;
	const char * p = strchr(path,'\\');

	int len = p?p-path:strlen(path);

	for( i=0; i<lastn; i++)
	{
		HNode *t = & (childs[i]);
		if( (int)strlen(t->name) == len-name_offs && str_n_case_cmp( t->name, path+name_offs, len-name_offs ) == 0 )
		{
			HN_STATUS STAT = 0;
			if (strncmp( t->name, path+name_offs, len-name_offs ) != 0) {
				badbase = t->base;
				STAT |= INS_CASE;
			}
			if (atoi(path) != t->n) {
				badbase = t->base;
				STAT |= INS_DIFFN;
			}
			if (t->lastn)
			{
				if (p) return (STAT | (t->addNode(p+1, res, badbase, abase)));
				res = t;
				return (STAT | INS_BRK);
			}
			else
			{
				if (p) return (STAT | INS_CONT | (t->addNode(p+1, res, badbase, abase)));
				res = t;
				return (STAT | INS_EXST | INS_OK);
			}
		}
	}

	HNode *nchild = new HNode[lastn + 1];

	for( i = 0; i < lastn; i++ )
		nchild[i] = childs[i];

	HNode * newch = &(nchild[lastn]);
	newch->name = (char*)malloc(len-name_offs+1);
	memcpy(newch->name, path+name_offs, len-name_offs);
	newch->name[len-name_offs] = 0;
	newch->level = level+1;
	newch->n = atoi(path);
	newch->name_offs = name_offs;
	newch->base = abase;
	newch->parent = this;

	if( childs ) delete[] childs;
	childs = nchild;
	lastn++;

	if (p) return newch->addNode(p+1, res, badbase, abase);

	res = newch;
	bIsFinal = 1;
	return INS_OK;
}

HN_STATUS HNode::addNode(const char * path, HNode*& res)
{
	int i;
	const char * p = strchr(path,'\\');

	int len = p?p-path:strlen(path);

	for( i=0; i<lastn; i++)
	{
		HNode *t = & (childs[i]);
		if( (int)strlen(t->name) == len-name_offs && str_n_case_cmp( t->name, path+name_offs, len-name_offs ) == 0 )
		{
			HN_STATUS STAT = 0;
			if (strncmp( t->name, path+name_offs, len-name_offs ) != 0)
				STAT |= INS_CASE;
			if (atoi(path) != t->n)
				STAT |= INS_DIFFN;
			if (t->lastn)
			{
				if (p) return (STAT | (t->addNode(p+1, res)));
				res = t;
				return (STAT | INS_BRK);
			}
			else
			{
				if (p) return (STAT | INS_CONT | (t->addNode(p+1, res)));
				res = t;
				return (STAT | INS_EXST | INS_OK);
			}
		}
	}

	HNode *nchild = new HNode[lastn + 1];

	for( i = 0; i < lastn; i++ )
		nchild[i] = childs[i];

	HNode * newch = &(nchild[lastn]);
	newch->name = (char*)malloc(len-name_offs+1);
	memcpy(newch->name, path+name_offs, len-name_offs);
	newch->name[len-name_offs] = 0;
	newch->level = level+1;
	newch->n = atoi(path);
	newch->name_offs = name_offs;
	newch->base=0;

	newch->parent = this;

	if( childs ) delete[] childs;
	childs = nchild;
	lastn++;

	if (p) return newch->addNode(p+1, res);

	res = newch;
	bIsFinal = 1;
	return INS_OK;
}

HN_STATUS HNode::findNode(const char * path, HNode*& res)
{
	int i;
	const char * p = strchr(path,'\\');
	
	int len = p?p-path:strlen(path);
	
	for( i=0; i<lastn; i++)
	{
		HNode *t = & (childs[i]);
		if( (int)strlen(t->name) == len-name_offs && str_n_case_cmp( t->name, path+name_offs, len-name_offs ) == 0 )
		{
			if (p) return t->findNode(p+1, res);
			res = t;
			if (t->lastn)	return FND_INT;
			else		return FND_CHLD;
		}
	}
	
	return FND_APS;
}

int HNode::_takepath(char* buf)
{
	int pos = 0;
	if (parent->name)
	{
		pos = parent->_takepath(buf);
		buf[pos] = '\\'; pos++;
	}
	if (name_offs)
		sprintf(buf+pos, "%.3ld=%s",n, name);
	else
		sprintf(buf+pos, "%s",name);
	return pos+strlen(name)+name_offs;
}

char * HNode::path()
{
	char buf[4096];
	_takepath(buf);
	return strdup(buf);
}

void HNode::collapseSingleNodes()
{
	for( int i =0; i<lastn; i++ )
	{
		childs[i].collapseSingleNodes();
	}
	if( lastn == 1 && level >= 0)
	{
		HNode save;
		if (childs[0].lastn == 0)
		{
			p = childs[0].p;
			lastn = 0;
			delete[] childs;
			childs = 0;
			return;
		}
		
		HNode * newchs = new HNode[childs->lastn];
		for (int j=0; j<childs->lastn; j++)
		{
			newchs[j] = childs->childs[j];
			newchs[j].parent = this;
		}
		lastn = childs->lastn;
		delete[] childs;
		childs = newchs;
	}
}

void HNode::process(HNodeProcessor * pr)
{
	pr->doit(this);
	for (int i = 0; i < lastn; i++)
	{
		HNode *t = & (childs[i]);
		t->process(pr);
	}
}
