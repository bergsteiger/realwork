
#include "index.h"
#include "btiter.h"
#include "fltiter.h"

#include <cstdlib>


static	unsigned char	ToUpper ( const unsigned char ch )
{
	if ( ch >= static_cast<unsigned char>('a') && ch <= static_cast<unsigned char>('z') ) // GARANT_W343
		return ch + static_cast<unsigned char>('A') - static_cast<unsigned char>('a');
	if ( ch >= static_cast<unsigned char>('à') && ch <= static_cast<unsigned char>('ÿ') )
		return ch + static_cast<unsigned char>('À') - static_cast<unsigned char>('à');
	return ch;
}

static	int str_cmp(const char * s1, const char * s2)
{
	register const unsigned char *p1 = (const unsigned char*)s1;
	register const unsigned char *p2 = (const unsigned char*)s2;
	while( *p1 && *p2 )
	{
		unsigned char	c1 = ToUpper ( *p1 );
		unsigned char	c2 = ToUpper ( *p2 );

		if ( c1 != c2 )
			return c1 - c2;
			
		p1++; p2++;
	}

	if ( *p1 || *p2 )
		if ( *p1 ) return 1; else return -1;	
	else
		return 0;
}

static int pstrcmp(const void *p1, const void *p2)
{
#ifdef	IGNOREKEYCASE
	return str_cmp(*((char **)p1), *((char **)p2));
#else
	return strcmp(*((char **)p1), *((char **)p2));
#endif
}

static int pstrncmp(const void *p1, const void *p2)
{
#ifdef	IGNOREKEYCASE
	return StrNICmp(*((char **)p1), *((char **)p2), strlen(*((char **)p2)));
#else
	return strncmp(*((char **)p1), *((char **)p2), strlen(*((char **)p2)));
#endif
}

FilteredIterator::FilteredIterator(const BTree * pBTree, BTKEY key, char **pfilter, int fltsize)
		: BTIterator(pBTree, key) 
{
	m_pKeys=0;
	m_nKeyCount=0;
	SetFilter(pfilter, fltsize);
	if (!key) {
		while( !(End() || CheckCurrentKey()) )
			BTIterator::next(); 
	}
}

FilteredIterator::~FilteredIterator()
{
	if (m_pKeys) gk_free(m_pKeys);
}

void FilteredIterator::SetFilter(char **keys, int keycount)
{
	if (m_pKeys) {
		gk_free(m_pKeys);
		m_pKeys = 0;
		m_nKeyCount = 0;
	}
	if (!keys) return;
	m_pKeys = (char **)gk_malloc(keycount*sizeof(char *));
	memcpy(m_pKeys, keys, keycount*sizeof(char *));
	m_nKeyCount = keycount;
	if (m_pKeys && m_nKeyCount)
		qsort(m_pKeys, m_nKeyCount, sizeof(char *), pstrcmp);
}

int FilteredIterator::CheckCurrentKey(void)
{
	BTKEY key;

	key = Key();
	if (!key) return 1;
	return CheckKey(key);
}

int FilteredIterator::CheckKey(BTKEY key)
{
	int slen, offs, found;
	size_t len;
	char *strings, *p;
	Stream *str;
	Index *pind;

	if (!m_pKeys || !m_nKeyCount) return 1;

	found = 0;
	pind = (Index *)tree;
	str = pind->Index::OpenN(key, 1);
	if ( !str )
		return 0;
	len = (size_t)str->Length();
	strings = (char *)gk_malloc(len);
	str->Read(strings, len);
	pind->Close(str);
	for (offs=0, slen=0; (size_t)offs < len && !found; offs += slen) {
		p = strings+offs;
		if (!bsearch(&p, m_pKeys, m_nKeyCount, sizeof(char *), pstrncmp))
			slen = strlen(p) + 1;
		else found = 1;
	}
	gk_free(strings);
	return found;
}

void FilteredIterator::next(void)
{
	if ( End() ) return;
	do BTIterator::next();  
	while( !(End() || CheckCurrentKey()) );
}

void FilteredIterator::prev(void)
{
	do BTIterator::prev(); 
	while (!CheckCurrentKey());
}

int FilteredIterator::Set(BTKEY key)
{
	BTIterator::Set(key);
	while( !(End() || CheckCurrentKey()) )
		BTIterator::next(); 
	return 0;
}

