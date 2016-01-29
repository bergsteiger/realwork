
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
unit m4SearchFormula;

{$I l3Define.inc}

interface

uses 
  l3Types,
  l3Base, 
  l3LexLib, 
  l3YaccLib, 
  
  m4SearchConst,
  m4Search
  ;

%}

%token <ShortString> RusWord   /* constants */
%token <ShortString> MaskRusWord
%token <ShortString> Number 
%token <Integer> Distance
%token _Follow_
%token _AND_
%token _OR_
%token _NOT_
%token <ShortString> Mixed
%token <ShortString> MaskMixed

%type  <Tm4BaseExpression> expr      /* expressions */

%left _AND_ _OR_ _NOT_  _Follow_ /* operators */
%{
function m4ParseSearchFormula(const aString: Tl3PCharLen): Tm4BaseExpression;
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
        | input expr '\n'        { l3Set(theResult.yyTm4BaseExpression, $2); 
                                   l3Free($2);}
        ;

expr    :  expr error            { l3Free($1); yyabort; }
        |  expr _AND_ Distance expr    { $$ := CreateBinaryOp(m4_soAnd, $1, $4, $3); }
        |  expr _Follow_ Distance expr { $$ := CreateBinaryOp(m4_soFollow, $1, $4, $3); }
        |  expr _AND_ expr       { $$ := CreateBinaryOp(m4_soAnd, $1, $3); }
        |  expr _OR_  expr       { $$ := CreateBinaryOp(m4_soOr, $1, $3); }
        |  expr _NOT_ expr       { $$ := CreateBinaryOp(m4_soAndNot, $1, $3); }
        |  expr _Follow_ expr    { $$ := CreateBinaryOp(m4_soFollow, $1, $3); }
        |  '(' expr ')'          { $$ := $2; }
        |  RusWord               { $$ := Tm4WordExpression.Create($1); }
        |  Number                { $$ := Tm4WordExpression.Create($1); }
        |  Mixed                 { $$ := Tm4WordExpression.Create($1); }
        |  MaskRusWord           { $$ := Tm4MaskExpression.Create($1); }
        |  MaskMixed             { $$ := Tm4MaskExpression.Create($1); }
        ;

%%

{$I m4SearchFormulaLex.pas}

function m4ParseSearchFormula(const aString: Tl3PCharLen): Tm4BaseExpression;
  {-}
var
 l_Yacc   : Tl3Yacc;
 l_Stream : Tl3StringStream;
 l_Result : YYSType;
begin
 l_Stream := Tl3StringStream.Create(aString);
 try
  l_Stream._String.CodePage := CP_OEM;
  l_Yacc := Tl3Yacc.Create(l_Stream);
  try
   if yyparse(l_Yacc, l_Result)=0 then 
    Result := l_Result.yyTm4BaseExpression
   else
    Result := nil;
  finally
   l3Free(l_Yacc);
  end;//try..finally 
 finally
  l3Free(l_Stream);
 end;//try..finally
end;
 
end.
