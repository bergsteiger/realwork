%option noyywrap
%option nounput
%option prefix="st2p_"

%x COMMENT
%x PERROR
%x GETTYPES
%x GETSOURCE
%x GETPVALUES
%x GETTYPEDEFPVALUES


%{                   
	#include <stdio.h>
	#include <unistd.h>
	#include <string.h>
	#include "sttop.h"
	#include "gardefs.h"
	#include "gclog.h"
	static int cln;
	static int cC;
	static int wasError;
	#define YY_DECL int STtoP::lex()
%}

comment ^[#;].+
%%
<*>\r
<*>{comment} { if( backTo != COMMENT ) backTo=YYSTATE; BEGIN(COMMENT); }
<COMMENT>.+ ;
<COMMENT>\n cln++; gclog.setLN(cln); BEGIN(backTo);
<INITIAL>\t BEGIN(GETTYPES);
<GETTYPES>\t 
<GETTYPES>[^\t\r\n]+ {
						FString t(yytext, yyleng);
						if( types->contains(t) ){
							gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Тип ");
							gclog.printfCP(AdvLogger::CD_ALT, "'%s' ", t.chars());
							gclog.printfCP(AdvLogger::CD_KOI, "уже встречался (позиция %ld).\n",(*types)[t]);
						}else{
							nTypes++;
							(*types)[t] = nTypes;
							if (!(inf->topicTypes->contains( t )))
							{
								gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, 
									"Unknown TYPE in priority table: ");
								gclog.printfCP(AdvLogger::CD_ALT, "'%s'\n", t.chars());
							}
						}
					}
<GETTYPES>\n { 
				if( (wasError = endTypes()) != 0 ){
					yyterminate();
				}else{
					cln++;
					gclog.setLN(cln);
					BEGIN(GETSOURCE);
				}
			}
<GETSOURCE>[^\t\r\n]+ {
						if( beginSource() == 0 ){
							BEGIN(GETPVALUES);
						}else{
							backTo = GETSOURCE;
							BEGIN(COMMENT);
						}
					}
<GETPVALUES>[0-9]+ {
					 if( cC > nTypes ){
					 	if( cC == nTypes +1 ){
							// that's default value for the source
							if ((atoi(yytext))>0)
					 			(matrix[nSources])[0] = atoi(yytext);
							else
								gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"Invalid priority in column %d");
						}else{ 
					 		gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI,
								"Встречено больше значений, чем ожидалось, остаток проигнорирован.\n");
							backTo = GETSOURCE;
							BEGIN(COMMENT);
						}
					 }else{
					 	(matrix[nSources])[cC] = atoi(yytext);
					 }
					}
<GETPVALUES>\t cC++; if (cC != (nTypes+1)) (matrix[nSources])[cC] = DEFAULT_TOPIC_PRIORITY; else (matrix[nSources])[0] = DEFAULT_TOPIC_PRIORITY;
<GETPVALUES>\n cln++; gclog.setLN(cln); BEGIN(GETSOURCE);

<GETSOURCE>^\t  BEGIN(GETTYPEDEFPVALUES); cC=1;

<GETTYPEDEFPVALUES>\t cC++; if (cC <= nTypes) (matrix[0])[cC] = DEFAULT_TOPIC_PRIORITY;
<GETTYPEDEFPVALUES>\n cln++; gclog.setLN(cln); BEGIN(GETSOURCE);
<GETTYPEDEFPVALUES>[0-9]+ {
	if( cC > nTypes )
	{
		if( cC == nTypes +1 )
		{
			(matrix[0])[0] = atoi(yytext);
		}
		else
		{ 
			gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI,
				"Встречено больше значений, чем ожидалось, остаток проигнорирован.\n");
			backTo = GETSOURCE;
			BEGIN(COMMENT);
		}
	}
	else
	{
		(matrix[0])[cC] = atoi(yytext);
	}
}
<*>. 		{
				if( backTo != COMMENT ) backTo=YYSTATE;
				yymore(); BEGIN(PERROR); 
			}
<PERROR>.+ {
				gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "%d: Ошибка разбора около ");
				gclog.printfCP(AdvLogger::CD_ALT, "'%s'.\n", yytext);
			}
<PERROR>\n cln++; gclog.setLN(cln); BEGIN(backTo);
<INITIAL>\n cln++; gclog.setLN(cln);
%%

int STtoP :: endTypes()
{
	if( types->length() && types->length() == nTypes ){
		maxSources = 200;
		matrix = (int**) realloc(matrix, sizeof(int*)*maxSources);
		nSources = 0;
		matrix[0] = (int*) malloc(sizeof(int)*(nTypes+1));
		(matrix[0])[0] = DEFAULT_TOPIC_PRIORITY;
		for( int i=1; i<=nTypes; i++ )
			(matrix[0])[i] = DEFAULT_TOPIC_PRIORITY;
		return 0;
	}
	return 1;
}
int STtoP :: beginSource()
{
	FString t(yytext, yyleng);
	if( sources->contains(t) ){
		gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Тип ");
		gclog.printfCP(AdvLogger::CD_ALT, "'%s' ", t.chars());
		gclog.printfCP(AdvLogger::CD_KOI, "уже встречался (позиция %ld).\n",(*sources)[t]);
		return 1;
	}
	if (!(inf->sourcesInfo->sm->contains(t)))
	{
		gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, 
			"Unknown SOURCE in priority table: ");
		gclog.printfCP(AdvLogger::CD_ALT, "'%s'\n", t.chars());
		return 1;
	}
	nSources ++;
	(*sources)[t] = nSources;
	if( nSources >= maxSources ){
		maxSources += 200;
		matrix = (int**) realloc(matrix, sizeof(int*)*maxSources);
	}
	matrix[nSources] = (int*)malloc(sizeof(int)*(nTypes+1));
	for( int i=0; i<=nTypes; i++ )
		(matrix[nSources])[i] = DEFAULT_TOPIC_PRIORITY;
	
	cC = 0;
	
	return 0;
}
void STtoP :: readST2P(FILE *f )
{
	cln = 1;
	yyin = f;
	lex();

	if ((matrix[0])[0] == DEFAULT_TOPIC_PRIORITY)
	{
		gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_KOI, "Priority for default SOURCE:TYPE not defined\n");
		exit(1);
	}
	for (int idx1=0; idx1 <= nSources; idx1++)
		for (int idx2=0; idx2 <= nTypes; idx2++)
		{
			if ((matrix[idx1])[idx2] == DEFAULT_TOPIC_PRIORITY)
				(matrix[idx1])[idx2] = (matrix[0])[0];
		}
}
STtoP::STtoP(const char *fn,ThreadCompileInfo* _inf )
{
	types = new CaseStringlongSplayMap(0);
	sources = new CaseStringlongSplayMap(0);
	nTypes = 0;
	status = 1;
	matrix = NULL;
	inf = _inf;
	if( fn ){
		FILE *f = fopen(fn,"r");
		if( f ){
			gclog.setFileName(fn);
			readST2P(f);
			fclose(f);
			status =0;
		} else {
			gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN, "мЕ ЛНЦС НРЙПШРЭ ТЮИК %s\n", fn);
		}
	}
}

STtoP::~STtoP()
{
	/* FIXME 
	 * no real destructor!
	 */
}

int STtoP::getp( CaseStringSplaySet * srcs, CaseStringSplaySet * tps)
{
	if( status )
		return DEFAULT_TOPIC_PRIORITY;

	int rv = DEFAULT_TOPIC_PRIORITY;

	if( tps->length() ) {
		if( srcs->length() ){
			for( Pix tp_i = tps->first();tp_i;tps->next(tp_i) ) {
				FString ts = (*tps)(tp_i);
				int col = 0;
				if( types->contains(ts) ) 
					col = (*types)[ts];
				else
					col = 0;
				for( Pix src_i = srcs->first(); src_i; srcs->next(src_i) ){
					FString ss = (*srcs)(src_i);
					int row;
					if( sources->contains(ss) )
						row = (*sources)[ss];
					else
						row = 0;
					int n = (matrix[row])[col];
					if( n < rv ) rv = n;
				}
			}
		}else{
			//only types here
			for( Pix tp_i = tps->first();tp_i;tps->next(tp_i) ) {
				FString ts = (*tps)(tp_i);
				int n;
				if( ! types->contains(ts) )
				{
					n = (matrix[0])[0];
				}
				else
				{
					int col = (*types)[ts];
					n = (matrix[0])[col];
				}
				if( n < rv ) rv = n;
			}
		}
	}else{
		if( srcs->length() ){
			for( Pix src_i = srcs->first();src_i;srcs->next(src_i) ) {
				FString s = (*srcs)(src_i);
				int n;
				if( ! sources->contains(s) )
				{
					n = (matrix[0])[0];
				}
				else
				{
					int row = (*sources)[s];
					n = (matrix[row])[0];
				}
				if( n < rv ) rv = n;
			}
		}else{
			rv = matrix[0][0];
		}
	}

	return rv;
}
