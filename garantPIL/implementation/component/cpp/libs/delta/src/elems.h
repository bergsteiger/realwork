/*
 * $Id: elems.h,v 2.14 2015/01/13 07:18:08 young Exp $
 */


#include <cstdio> // GARANT_GCC
#include <cstdlib>

#ifndef __ELEMS_H
#define __ELEMS_H

#define ELEMS_MAX_WORD_LEN MAX_PARA_LEN

extern int CCr [16];

class Word
{
public:
	const char* Wr;
	int m_thread;

	Word();
	Word(int thread);
	Word(Word &W);
	~Word();
	const char* operator =(char* c){ Clear();return Fill(c);}
	Word operator =(Word W);
	int operator ==(Word &W);
	friend int fgets(Word* dest,unsigned n,FILE* fn);
	friend int fgets(Word* dest,unsigned n,char* &ptr);
	friend int fputs ( Word* dest, unsigned n, FILE* fn );
	friend int fputc(Word &W,FILE* F);
	friend int fgetc(Word &W,FILE* F);
	friend int fgetc(Word &W,char* &ptr);
	friend Word* CreatWordFromMem(const char * buf,unsigned len, int thread, char*);
	friend int CopyToMem(Word* W,char* M,unsigned MLen);
	friend unsigned strlenE(Word* W);

public:
	inline void Clear() {
		if ( Wr && CCr [m_thread] ) delete (char*)Wr;
		Wr = 0;
	}
	const char* Fill(const char* c);
 };

Word* CreatWordFromMem(const char * buf,unsigned len, int thread); // GARANT_GCC410

int fputl(long l,FILE* F);
int fgetl(long &l,FILE* F);
int fputi(int l,FILE* F);
int fgeti(int &l,FILE* F);
int fgeti(int &l,char* &ptr);

#endif
