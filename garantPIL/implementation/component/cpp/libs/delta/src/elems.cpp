/*
 * $Id: elems.cpp,v 2.18 2015/01/13 07:18:08 young Exp $
 */

#ifndef unix
        #include <io.h>
#endif 
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "deltadef.h"
#include "elems.h"
#include "check.h"
#include "Logger.h"

extern Logger logger;

static char g_fgetc_buf_thr [16] [ELEMS_MAX_WORD_LEN+1];

int fputi ( int i, FILE* F )
{
	return fwrite ( &i, sizeof i, 1, F );
}

int fgeti( int &i, FILE* F )
{
	return fread ( &i, sizeof i, 1, F );
}

int fgeti( int &i, char* &ptr)
{
	memcpy (&i, ptr, sizeof (i));
	ptr += sizeof (i);
	return i;
}

int fputl ( long l, FILE* F )
{
	return fwrite ( &l, sizeof l, 1, F );
}

int fgetl ( long &l, FILE* F )
{
	return fread ( &l, sizeof l, 1 ,F );
}

int Strlen(const char * Wr)
 {
	int mode=1, i=0;
	if(Wr[0]==' '||Wr[0]==10||Wr[0]==13)mode=0;
	while ( (!mode&&(Wr[i]==' '||Wr[i]==10||Wr[i]==13)) || (mode&&Wr[i]!=' '&&Wr[i]!=10&&Wr[i]!=13) )
		i++;
	return i;
 }

Word :: Word()
{
	m_thread = 0;
	Wr=0;
}

Word :: Word(int thread)
{
	m_thread = thread;
	Wr=0;
}

Word :: Word(Word &W)
{
	m_thread = W.m_thread;
	Fill(W.Wr);
}

Word :: ~Word()
{
	if ( Wr && CCr [m_thread] ) free ( (char*)Wr );
}

Word Word::operator =(Word W)
{
	m_thread = W.m_thread;
	Clear();
	Fill(W.Wr);
	return *this;
}

const char* Word::Fill(const char* c)
{
	if (CCr [m_thread]) {
		Wr = ( char* ) malloc ( Strlen(c)+1 );
		memcpy((char*)Wr,c,Strlen(c)+1);
	} else {
		Wr=c;
	}
	return Wr;
}

int CopyToMem(Word* W,char* M,unsigned MLen)
{
	unsigned int SPos=0;
	for(unsigned int i = 0; W[i].Wr; i++) {
		int WrLen=Strlen(W[i].Wr);
		if (SPos+WrLen > MLen) {
			logger.printf ( lt_fatal, "Copyed string from Word to mem more then allocated bufer\n" );
			exit ( EXIT_FAILURE );
		}
		memcpy(&M[SPos],W[i].Wr,WrLen);
		SPos+=WrLen;
		//if ( SPos<MLen && i < WLen-1
		if ( SPos<MLen && W[i+1].Wr
			&& W[i].Wr[0]!=' '
			&& W[i].Wr[0]!=10
			&& W[i].Wr[0]!=13
			&& W[i+1].Wr[0]!=' '
			&& W[i+1].Wr[0]!=10
			&& W[i+1].Wr[0]!=13 ) M[SPos++]=' ';
	}

	if (SPos+1 < MLen) {
		logger.printf("Copyed string from Word to mem has diff size then allocated bufer on %d",MLen-SPos-1);
		exit ( EXIT_FAILURE );
	}

	return 1;
}

int fgets(Word* dest, unsigned int n, FILE* fn)
{
	for (unsigned int i = 0; i < n; i++) 
		fgetc(*dest++,fn);  //!!!!!!!!
	return 1;
}

int fgets(Word* dest, unsigned int n, char* &ptr)
{
	for (unsigned int i = 0; i < n; i++)
		fgetc (*dest++,ptr);
	return 1;
}

int fputs ( Word* dest, unsigned n, FILE* fn )
{
	for (unsigned int i = 0; i < n; i++ ) 
		fputc ( *dest++ , fn );  //!!!!!!!!
	return 1;
}

int fputc(Word &W,FILE* F)
{
	int iWordLen = Strlen ( W.Wr );        // Add 17.10.97
	if ( iWordLen > ELEMS_MAX_WORD_LEN ) {
		logger.printf ( lt_fatal, "Elems.cpp : fputc - save word to long (%ld)\n", iWordLen );
		exit ( EXIT_FAILURE );
	}
                
	return fwrite ( W.Wr, iWordLen + 1, 1, F );     //!!!!!!!!!!!!
}

int fgetc(Word &W,FILE* F)
 {
	char	*g_fgetc_buf = g_fgetc_buf_thr [W.m_thread];
	int mode=1;
	g_fgetc_buf[0]=fgetc(F);
	if ( g_fgetc_buf[0]==' ' || g_fgetc_buf[0]==10 || g_fgetc_buf[0]==13 ) mode=0;
	int i=0;

	while ( (!mode&&( g_fgetc_buf[i]==' ' || g_fgetc_buf[i]==10 || g_fgetc_buf[i]==13 ) || (mode&&g_fgetc_buf[i]!=' ' && g_fgetc_buf[i]!=10 && g_fgetc_buf[i]!=13)) ) {
		i++;
		g_fgetc_buf[i]=fgetc(F);
	}
        
	W.Fill(g_fgetc_buf);        
        
	return 1;
 }

int fgetc(Word &W,char* &ptr)
{
	char *g_fgetc_buf = g_fgetc_buf_thr [W.m_thread];
	int mode=1;
	g_fgetc_buf[0] = *ptr; ptr++;
	if ( g_fgetc_buf[0]==' ' || g_fgetc_buf[0]==10 || g_fgetc_buf[0]==13 ) mode=0;
	int i=0;

	while ( (!mode&&( g_fgetc_buf[i]==' ' || g_fgetc_buf[i]==10 || g_fgetc_buf[i]==13 ) || (mode&&g_fgetc_buf[i]!=' ' && g_fgetc_buf[i]!=10 && g_fgetc_buf[i]!=13)) ) {
		i++;
		g_fgetc_buf[i] = *ptr;
		ptr++;
	}
        
	W.Fill(g_fgetc_buf);        
        
	return 1;
}


int Word::operator ==(Word &W)
{
	if ( !W.Wr ) return 0;
        
	unsigned short usiWrLen = Strlen ( Wr );

	if ( usiWrLen != Strlen ( W.Wr ) ) return 0;

	return !memcmp ( Wr, W.Wr, usiWrLen );
}

Word* CreatWordFromMem(const char * buf,unsigned len, int thread, char *P_BUF)
{
	int wCount = 0;
	int curr;
	int mode = ( buf[0]==' ' || buf[0]==10 || buf[0]==13 ); // 0 - text
	unsigned int i;

	if ( len ) wCount++;
                                                                                                                        // 1 - ' ',10,13
	for (i = 0; i < len; i++ ) {
		curr = ( buf[i]==' ' || buf[i]==10 || buf[i]==13 );
		if ( mode && !curr || !mode && curr ) {
			if ( i<len-1
				&& buf[i]==' '
				&& buf[i+1]!=' '
				&& buf[i+1]!=13
				&& buf[i+1]!=10 )
					wCount++;
			else {
				wCount++;
				mode = !mode;
			}
		}
	}

	wCount++;   /*NEW*/
	Word* W = new Word[wCount];  //NEW
	for (int t = 0; t < wCount; t++)
		W [t].m_thread = thread;

	int wrPos=0, wLast = wCount-2;
	wCount=0;

	mode = ( buf[0]==' ' || buf[0]==10 || buf[0]==13 );

	if(len) {
		if (wCount == wLast ) {
			unsigned t = len-wrPos;
			if ( t >= BUF_SIZE ) {
				logger.printf ( lt_fatal, "Word : Last Word longer than BUF_SIZE\n" );
				exit ( EXIT_FAILURE );
			}
			memcpy(P_BUF, &buf[wrPos], t);
			if (!mode) P_BUF[t] = ' ';
				else P_BUF[t] = 'Z';
			W[wCount].Wr = P_BUF;
		} else {
			W[wCount].Fill(buf);
		}
		wCount++;
	}

	for ( i=0; wCount<wLast+1; i++ ) {
		curr = ( buf[i]==' ' || buf[i]==10 || buf[i]==13 );
		if ( mode && !curr || !mode && curr ) {
			if ( i<len-1
				&& buf[i]==' '
				&& buf[i+1]!=' '
				&& buf[i+1]!=13
				&& buf[i+1]!=10 ) {
				wrPos = i+1;
			} else {
				wrPos = i;
				mode = !mode;
			}

			if (wCount == wLast ) {
				unsigned t = len-wrPos;
				if ( t >= BUF_SIZE ) {
					logger.printf ( lt_fatal, "Word : Last Word longer than BUF_SIZE\n" );
					exit ( EXIT_FAILURE );
				}
				memcpy(P_BUF,&buf[wrPos],t);
				if ( !mode ) P_BUF[t]=' ';
					else P_BUF[t]='Z';
				W[wCount].Wr=P_BUF;
			} else
				W[wCount].Fill(&buf[wrPos]);

			wCount++;
		}
	}

	W[wCount].Wr=0;
	return W;
}
