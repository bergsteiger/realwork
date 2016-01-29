
/* Sample Yacc grammar for a simple desktop calculator; derived from a
   grammar in Aho et al: Compilers. Principles, Techniques and Tools (Sect.
   4.9).

   Lexical analyzer is in Lex program ExprLex.l.

   To compile parser and lexical analyzer, issue the following commands:

     yacc expr
     lex  exprlex
     tpc  expr

   Description: This program reads simple arithmetic expressions, constructed
   with real constants, operators +, -, *, /, unary - and parentheses
   (operators have their usual precedence, unary minus is highest), from
   standard input (one per line) and prints the result on standard output.
   Variables are denoted by a single letter (no distinction between upper and
   lowercase letters); they are assigned values through an assignment of the
   form <var>=<expr>.
   The program is terminated by entering an empty line. */

%{
unit l3SimpleCalc;

{$I l3Define.inc}

interface

uses 
  l3Types,
  l3Base, 
  l3LexLib, 
  l3YaccLib
  ;

%}

%token <Integer> NUM    /* constants */
%token <Integer> ID     /* variables */
%type  <Integer> expr	/* expressions */

%left '+' '-'      	/* operators */
%left '*' '/'
%right UMINUS

%token ILLEGAL 		/* illegal token */

%{
type
  Tl3SimpleYacc = class(Tl3Yacc)
    public
    // public fields
      ParamValue : Integer;
  end;//Tl3SimpleYacc

function l3Calc(const aString: Tl3PCharLen; X : Integer): Integer;
  {-}
  
implementation

uses
  SysUtils,
  
  l3Chars,
  l3Memory
  ;
%}
%%

input   : /* empty */
        | input '\n'             { yyaccept; }
        | input expr '\n'        { theResult.yyInteger := $2; }
        ;

expr    :  expr error            { yyabort; }
        |  expr '+' expr         { $$ := $1 + $3; }
        |  expr '-' expr         { $$ := $1 - $3; }
	|  expr '*' expr	 { $$ := $1 * $3; }
	|  expr '/' expr	 { $$ := $1 div $3; }
	|  '(' expr ')'		 { $$ := $2; }
	|  '-' expr              { $$ := -$2; }
           %prec UMINUS
	|  NUM                   { $$ := $1; }
        |  ID                    { $$ := (aYacc As Tl3SimpleYacc).ParamValue; }
        ;

%%

{$I l3SimpleCalclex.pas}

function l3Calc(const aString: Tl3PCharLen; X : Integer): Integer;
  {-}
var
 l_Yacc   : Tl3SimpleYacc;
 l_Stream : Tl3StringStream;
 l_Result : YYSType;
begin
 l_Stream := Tl3StringStream.Create(aString);
 try
  l_Stream._String.CodePage := CP_OEM;
  l_Yacc := Tl3SimpleYacc.Create(l_Stream);
  try
   l_Yacc.ParamValue := X;
   if yyparse(l_Yacc, l_Result)=0 then 
    Result := l_Result.yyInteger
   else
    raise Exception.Create('Syntax Error');
  finally
   l3Free(l_Yacc);
  end;//try..finally 
 finally
  l3Free(l_Stream);
 end;//try..finally
end;

end.