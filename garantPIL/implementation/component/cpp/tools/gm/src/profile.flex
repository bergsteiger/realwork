%option noyywrap
%option nounput

%x COMMENT
%x NAME
%x VALUE
%x SECTION

%{
#include <stdio.h>
#include <string.h>
#include <unistd.h>

extern int accept_section(const char *);
extern int accept_string(const char *, const char *);
extern int accept_int(int);
extern int accept_int_list(int *, int);
extern int accept_string_list()
static int on_value(char *);
static char *_entry_name_, *_section_name_, *_section_pre_name_;
static int _sn_ok_=0;
%}

%%
<INITIAL>[\t ]+
<INITIAL>[;#] BEGIN(COMMENT);
<INITIAL,COMMENT>\n BEGIN(INITIAL);
<COMMENT>.
<INITIAL>[[] BEGIN(SECTION);
<INITIAL>{ENAME} { BEGIN(ENTRY); strcpy(_entry_name_, yytext); }
<INITIAL>. BEGIN(COMMENT);
<SECTION>{ENAME} strcpy(_section_pre_name_, yytext);
<SECTION>[\t ]
<SECTION>[]] _sn_ok_=1;
<SECTION>\n {
		if(_sn_ok_) {
			strcpy(_section_name_, _section_pre_name_);
			accept_section(_section_name_);
			_sn_ok_=0;
		}
		BEGIN(INITIAL);
	}
<ENTRY>{ENAME} { strcpy(_entry_name_, yytext); BEGIN(VALUE); }
<ENTRY>[\t ] 
<ENTRY>. BEGIN(COMMENT);
<VALUE>{[\t ]*[=]+1[\t ]*}
<VALUE>\n {
		
		BEGIN(INITIAL);
	}
%%
