
  (* Lexical analyzer for the sample Yacc program in Expr.y. *)

Digit                         [0-9]
Number                        {Digit}+
RusLetter                     [Ä-ü†-Ô]
RusWord                       {RusLetter}+
SomeSpace                     " "+
AnySpace                      " "*
AND                           [à®]
OR                            [à®][ã´][à®]             
BUT                           [ç≠][éÆ]
NO                            [ç≠][Ö•]

%%

{RusWord}        begin
                  yylval.yyShortString := yyText;
                  return(RusWord);
                 end;
{Number}         begin
                  yylval.yyShortString := yyText;
                  return(Number);
                 end;                  

{SomeSpace}{AND}{SomeSpace} |
{AnySpace}\&{AnySpace}      return(_AND_);
{SomeSpace}{OR}{SomeSpace}  |
{AnySpace}\|{AnySpace}      return(_OR_);
{SomeSpace}{BUT}{SomeSpace}{NO}{SomeSpace} |
{AnySpace}\~{AnySpace}      return(_NOT_);
{AnySpace}\:{AnySpace}      |
{AnySpace}                  return(_Follow_);

.                           |
\n                          returnc(yytext[1]);
