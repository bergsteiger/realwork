
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
uses 
  l3Base, 
  l3LexLib, 
  l3YaccLib, 
  
  m4Search
  ;

%}

%token <String> RusWord   /* constants */
%token <String> Number 
%token _Follow_
%token _AND_
%token _OR_
%token _NOT_

%type  <Tm4BaseExpression> expr      /* expressions */

%left _AND_ _OR_ _NOT_  _Follow_ /* operators */

%%

input   : /* empty */
        | input '\n'             { yyaccept; }
        | input expr '\n'        { writeln($2.Evaluate); 
                                   l3Free($2);}
        | error '\n'             { yyerrok; }
        ;

expr    :  expr _AND_ expr       { $$ := CreateBinaryOp(m4_soAnd, $1, $3); }
        |  expr _OR_  expr       { $$ := CreateBinaryOp(m4_soOr, $1, $3); }
        |  expr _NOT_ expr       { $$ := CreateBinaryOp(m4_soAndNot, $1, $3); }
        |  expr _Follow_ expr    { $$ := CreateBinaryOp(m4_soFollow, $1, $3); }
        |  '(' expr ')'          { $$ := $2;            }
        |  RusWord               { $$ := Tm4SimpleExpression.Create($1); }
        |  Number                { $$ := Tm4SimpleExpression.Create($1); }
        ;

%%

{$I sexprlex.pas}

var
 l_Yacc : Tl3Yacc;
begin
 l_Yacc := Tl3Yacc.Create;
 try
  if yyparse(l_Yacc)=0 then { done };
 finally
  l3Free(l_Yacc);
 end;//try..finally 
end.
