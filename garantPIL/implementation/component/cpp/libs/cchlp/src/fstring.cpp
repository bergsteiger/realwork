/*
 * $Id: fstring.cpp,v 2.3 2006/08/10 17:22:42 cyberz Exp $
 */

#include "fstring.h"

static unsigned char trtbl[256];

void FString :: init_tr() 
{
	for( unsigned int i=0; i<sizeof(trtbl); i++){
		trtbl[i]=i;
	}

	trtbl[(unsigned char)'A'] = '€';
	trtbl[(unsigned char)'B'] = '‚';
	trtbl[(unsigned char)'C'] = '‘';
	trtbl[(unsigned char)'E'] = '…';
	trtbl[(unsigned char)'H'] = '';
	trtbl[(unsigned char)'I'] = '1';
	trtbl[(unsigned char)'K'] = 'Š';
	trtbl[(unsigned char)'M'] = 'Œ';
	trtbl[(unsigned char)'O'] = '0';
	trtbl[(unsigned char)'P'] = '';
	trtbl[(unsigned char)'T'] = '’';
	trtbl[(unsigned char)'X'] = '•';

	trtbl[(unsigned char)'‡'] = '3';
	trtbl[(unsigned char)'Ž'] = '0';
}
void FString :: cp866Code(char *p_, unsigned l)
{
     unsigned char *p = (unsigned char*)p_;

	for( ; l>0; l--){
		*p=trtbl[*p];
		p++;
	}
}
void FString :: cp866Up(char *p_)
{
     unsigned char *p = (unsigned char*)p_;
	while( *p ){
		if( *p >= 'a' && *p <= 'z' )
			*p = *p + 'A' - 'a';
		else if ( *p >= (unsigned char)' ' && *p <= (unsigned char)'¯' )
			*p = *p + (unsigned char)'€' - (unsigned char)' ';
		else if ( *p >= (unsigned char)'à' && *p <= (unsigned char)'ï' )
			*p =  *p + (unsigned char)'' - (unsigned char)'à';
		p++;
	}
}
void FString :: cp866Up(char *p_, unsigned l)
{
     unsigned char *p = (unsigned char*)p_;
	for( ; l>0; l--){
		if( *p >= 'a' && *p <= 'z' )
			*p = *p + 'A' - 'a';
		else if ( *p >= (unsigned char)' ' && *p <= (unsigned char)'¯' )
			*p = *p + (unsigned char)'€' - (unsigned char)' ';
		else if ( *p >= (unsigned char)'à' && *p <= (unsigned char)'ï' )
			*p =  *p + (unsigned char)'' - (unsigned char)'à';
		p++;
	}
}

