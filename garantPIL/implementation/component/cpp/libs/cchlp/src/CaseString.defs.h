#ifndef __CaseString_defs_h__
#define __CaseString_defs_h__

#include "osdep.h"

#include "FString.FString.SplayMap.h"
#include "FString.long.SplayMap.h"
#include "FString.caddr_t.SplayMap.h"
#include "FString.SplaySet.h"

static int str_n_case_cmp(const char * s1, const char * s2, int length);
static int str_case_cmp(const char * s1, const char * s2);

int str_case_cmp(const char * s1, const char * s2)
{
    register const unsigned char *p1 = (const unsigned char*)s1;
    register const unsigned char *p2 = (const unsigned char*)s2;
	while( *p1 && *p2 )
	{
		if (*p1 == 240 && *p2 == 241) {
			p1++,p2++;
			continue;
		}
		if( *p1 >= 97 && *p1 <= 122 &&  *p2 >= 97 && *p2 <= 122)
		{
			if (*p1 != *p2)
				return (*p1 - *p2);
		}
		else if( *p1 >= 97 && *p1 <= 122 &&  *p2 >= 65 && *p2 <= 90)
		{
			if (*p1 != (*p2 + 32))
				return (*p1 - (*p2+32));
		}
		else if( *p1 >= 65 && *p1 <= 90 &&  *p2 >= 97 && *p2 <= 122)
		{
			if (*p1 != (*p2 - 32))
				return (*p1 - (*p2-32));
		}
		else if( *p1 >= 90 && *p1 <= 65 &&  *p2 >= 65 && *p2 <= 90)
		{
			if (*p1 != *p2)
				return (*p1 - *p2);
		}


		else if( *p1 >= 160 && *p1 <= 175 && *p2 >= 160 && *p2 <= 175)
		{
			if (*p1 != *p2)
				return (*p1 - *p2);
		}
		else if( *p1 >= 160 && *p1 <= 175 && *p2 >= 128 && *p2 <= 159)
		{
			if (*p1 != (*p2 + 32))
				return (*p1 - (*p2+32));
		}


		else if( *p1 >= 224 && *p1 <= 239 && *p2 >= 224 && *p2 <= 239)
		{
			if (*p1 != *p2)
				return (*p1 - *p2);
		}
		else if( *p1 >= 224 && *p1 <= 239 && *p2 >= 128 && *p2 <= 159)
		{
			if (*p1 != (*p2 + 80))
				return (*p1 - (*p2+80));
		}


		else if( *p1 >= 128 && *p1 <= 143 && (*p2 >= 160 && *p2 <= 175 || *p2 >= 224 && *p2 <= 239))
		{
			if (*p1 != (*p2 - 32))
				return (*p1 - (*p2-32));
		}
		else if( *p1 >= 128 && *p1 <= 143 && *p2 >= 128 && *p2 <= 143)
		{
			if (*p1 != *p2)
				return (*p1 - *p2);
		}
		else if( *p1 >= 144 && *p1 <= 159 && (*p2 >= 160 && *p2 <= 175 || *p2 >= 224 && *p2 <= 239))
		{
			if (*p1 != (*p2 - 80))
				return (*p1 - (*p2-80));
		}
		else if( *p1 >= 144 && *p1 <= 159 && *p2 >= 144 && *p2 <= 159)
		{
			if (*p1 != *p2)
				return (*p1 - *p2);
		}
		else 
		{
			if (*p1 != *p2)	return (*p1 - *p2);
		}
		p1++; p2++;
	}
	return (*p1 - *p2);
}

int str_n_case_cmp(const char * s1, const char * s2, int length)
{
    register const unsigned char *p1 = (const unsigned char*)s1;
    register const unsigned char *p2 = (const unsigned char*)s2;
        register int i;
	for ( i = 0; i < length && *p1 && *p2; i++, p1++, p2++)
	{
		if( *p1 >= 97 && *p1 <= 122 )
		{
			if (*p1 != *p2 && *p1 != (*p2 + 32))
				return (*p2 - *p1);
		}
		else if( *p1 >= 65 && *p1 <= 90 )
		{
			if (*p1 != *p2 && *p1 != (*p2 - 32))
				return (*p2 - *p1);
		}
		else if( *p1 >= 160 && *p1 <= 175 )
		{
			if (*p1 != *p2 && *p1 != (*p2 + 32))
				return (*p2 - *p1);
		}
		else if( *p1 >= 224 && *p1 <= 239 )
		{
			if (*p1 != *p2 && *p1 != (*p2 + 80))
				return (*p2 - *p1);
		}
		else if( *p1 >= 128 && *p1 <= 143 )
		{
			if (*p1 != *p2 && *p1 != (*p2 - 32))
				return (*p2 - *p1);
		}
		else if( *p1 >= 144 && *p1 <= 159 )
		{
			if (*p1 != *p2 && *p1 != (*p2 - 80))
				return (*p2 - *p1);
		}
		else 
		{
			if (*p1 != *p2)	return (*p2 - *p1);
		}
	}
	if (i == length) return 0;
	return (*p2 - *p1);
}

class CaseStringCaseStringSplayMap : public FStringFStringSplayMap
{
protected:
	
	virtual int KeyCompare(FString& key1,FString& key2)
	{
		return str_case_cmp(key1.chars(),key2.chars());
	}
	
public:
	CaseStringCaseStringSplayMap(FString& dflt):FStringFStringSplayMap(dflt) {};
    CaseStringCaseStringSplayMap(FStringFStringSplayMap& a):FStringFStringSplayMap(a) {};
};

class CaseStringlongSplayMap : public FStringlongSplayMap
{
protected:
	
	virtual int KeyCompare(FString& key1,FString& key2)
	{
		return str_case_cmp(key1.chars(),key2.chars());
	}
	
public:
	CaseStringlongSplayMap(long dflt):FStringlongSplayMap(dflt) {};
    CaseStringlongSplayMap(FStringlongSplayMap& a):FStringlongSplayMap(a) {};
};

class CaseStringcaddr_tSplayMap : public FStringcaddr_tSplayMap
{
protected:
	
	virtual int KeyCompare(FString& key1,FString& key2)
	{
		return str_case_cmp(key1.chars(),key2.chars());
	}
	
public:
	CaseStringcaddr_tSplayMap(caddr_t dflt):FStringcaddr_tSplayMap(dflt) {};
    CaseStringcaddr_tSplayMap(FStringcaddr_tSplayMap& a):FStringcaddr_tSplayMap(a) {};
};

class CaseStringSplaySet : public FStringSplaySet
{
protected:
	
	virtual int KeyCompare(FString& key1,FString& key2)
	{
		return str_case_cmp(key1.chars(),key2.chars());
	}
	
public:
    CaseStringSplaySet() {};
    CaseStringSplaySet(FStringSplaySet& a):FStringSplaySet(a) {};
};

#endif
