%option noyywrap
%option nounput
%option prefix="gcom_"

%x COMMENT
%x BERROR
%x HASP
%x RNAME
%x ENAME
%x MAXWEIGHT

%{
#include "gardefs.h"
#include "garcomp.h"
#include "gclog.h"
#include "complect.h"

static int cln;
static ThreadCompileInfo *inf;
static void getline(char *text, int leng, char* str);
extern "C" {
static int sortBaseWeightCmp(const void *w1, const void *w2);
}

%}

comment ^[#;].*
whitespace [ \t\r]

%%
<*>\r
<INITIAL>{comment} BEGIN(COMMENT);
<COMMENT>.+ ;
<COMMENT>\n cln++; gclog.setLN(cln); BEGIN(INITIAL);
<INITIAL>{whitespace}
<INITIAL>\n cln++; gclog.setLN(cln);
<INITIAL>[0-9]+ { 
		inf->weightsTable[inf->wtCount].min = atoi(yytext); 
		BEGIN(MAXWEIGHT); 
	}
<MAXWEIGHT>{whitespace}
<MAXWEIGHT>[0-9]+ {
		inf->weightsTable[inf->wtCount].max = atoi(yytext);
		if (!inf->weightsTable[inf->wtCount].max) {
			gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
				"Максимальный вес комплекта не может равняться 0\n");
		}
		BEGIN(HASP);
	}
<HASP>{whitespace}
<HASP>[a-zA-Z]+ {
			if (yyleng > HASP_NAME_SIZE) {
				inf->weightsTable[inf->wtCount].haspName[0] = 0;
			} else {
				strncpy(inf->weightsTable[inf->wtCount].haspName, 
						yytext, yyleng);
			}
			BEGIN(RNAME);
		}
<RNAME>{whitespace}
<RNAME>\|[^\|]+\| { 
			getline(yytext, yyleng, inf->weightsTable[inf->wtCount].name); 
			BEGIN(ENAME); 
		}
<ENAME>{whitespace}
<ENAME>\|[^\|]+\| { 
			getline(yytext, yyleng, inf->weightsTable[inf->wtCount].nameEng); 
			inf->wtCount++;
			BEGIN(INITIAL); 
		}
<ENAME>\n {
			gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI, 
				"Отсутствует английское название для комплекта.\n");
			strcpy(inf->weightsTable[inf->wtCount].name, 
				inf->weightsTable[inf->wtCount].nameEng);
			cln++;
			gclog.setLN(cln);
			inf->wtCount++;
			BEGIN(INITIAL);
		}
<*>.      yymore(); BEGIN(BERROR);
<BERROR>.+ {
		gclog.setLN(cln);
		gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
			"Ошибка формата около ");
		gclog.printfCP(AdvLogger::CD_ALT, "'%s'\n", yytext );
	}
<BERROR>\n cln++; gclog.setLN(cln); BEGIN(INITIAL);

%%
void getline(char *text, int leng, char* str)
{
	if (leng > BASE_NAME_SIZE) {
		str[0] = 0;
		return;
	}
	strncpy(str, text+1, leng-2);
}


int sortBaseWeightCmp(const void *w1, const void *w2)
{
	return ((BaseWeight *)w1)->min > ((BaseWeight *)w2)->min ? 1 :
			((BaseWeight *)w1)->min < ((BaseWeight *)w2)->min ? -1 : 0;
}


int readWeightsTable(const char * fn, ThreadCompileInfo *info)
{
	inf = info;
	inf->wtCount = 0;
	yyin = fopen(fn, "r");
	if (!yyin) {
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
			"Ошибка открытия файла описания комплектов (%s)\n", fn);
		return 1;
	}
	gclog.setFileName(fn);
	cln = 1;
	gclog.setLN(1);
	yylex();
	fclose(yyin);
	if( !inf->wtCount ){
		gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
			"Таблица весов пуста\n");
	} else {
		qsort(inf->weightsTable, inf->wtCount, sizeof(BaseWeight), 
				sortBaseWeightCmp);
		for(int i=1; i<(int)inf->wtCount; i++) {
			if(inf->weightsTable[i-1].max >= inf->weightsTable[i].min) {
				gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
					"Таблица весов содержит некорректные (пересекающиеся) диапазоны весов для:");
				gclog.printfCP(AdvLogger::CD_ALT, "\n%s\n%s\n",
					inf->weightsTable[i-1].name, inf->weightsTable[i].name);
				gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
					"Из таблицы будет удалена база (комплект) :\n");
				gclog.printfCP(AdvLogger::CD_ALT, "%s\n", inf->weightsTable[i].name);
				if(i<(int)inf->wtCount-1)
					memmove(inf->weightsTable+i, inf->weightsTable+i+1, 
						(inf->wtCount-1-i)*sizeof(BaseWeight));
				inf->wtCount--;
			}
		}
	}

	return 0;
}

