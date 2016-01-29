/*
 *
 * Fast String implementation
 * The main goal is to avoid some stranges with GNU string
 *
 * $Id: fstring.h,v 2.4 2005/06/03 05:35:45 grigorio Exp $
 */

#ifndef _fstring_h
#define _fstring_h

#include <stdlib.h>
#include <string.h>


class FString
{

friend int fscmp(const FString &a, const FString &b);

public:
	FString(int doFree=1): pstr(0), len(0), bDoFree(doFree) { } ;
	FString(int doFree, char *str) // creat object without string duplicate
		: pstr(str), bDoFree(doFree) { 
		len = strlen(str);
	}; 
	FString(const char *str): bDoFree(0) {
		len = strlen(str);
		pstr = (char *)malloc(len+1);
		if( len ){
			memcpy(pstr,str,len);
			pstr[len]=0;
		}else
			pstr[0] = 0;
	};
	FString(const char *str, unsigned l) : bDoFree(0) {
		len = l;
		pstr = (char *)malloc(len+1);
		memcpy(pstr,str,l);
		pstr[l]=0;
	};
	const char *chars() const { return pstr; };
	unsigned length () const { return len; };
	int index(const char c) {
		if (!pstr) return 0;
		char *idx = strchr(pstr, c);
		if (idx) 
			return (idx-pstr);
		else 
			return 0;
	}
	void cp866Up() { cp866Up(pstr,len); };
	void cp866Code(){ cp866Up(pstr,len); cp866Code(pstr,len); };
	static void cp866Up(char *, unsigned );
	static void cp866Up(char * );
	static void cp866Code(char *, unsigned );
	~FString() {
		if(bDoFree && pstr) free(pstr);
	}
protected:
	char *pstr;
	unsigned len;
public:
	int  bDoFree;
	static void init_tr();
};

inline int fscmp(const FString &a, const FString &b)
{
	return strcmp(a.pstr, b.pstr);
}

inline int operator>(const FString& x, const FString& y)
{
	return fscmp(x, y) > 0;
}

inline int operator<(const FString& x, const FString& y)
{
	return fscmp(x, y) < 0;
}

inline int operator==(const FString& x, const FString& y)
{
	return fscmp(x, y) == 0;
}

inline int operator!=(const FString& x, const FString& y)
{
	return fscmp(x, y) != 0;
}

#endif
