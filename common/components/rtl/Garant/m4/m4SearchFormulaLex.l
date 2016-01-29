
  (* Lexical analyzer for the sample Yacc program in Expr.y. *)

%start stOperator

Digit                         [0-9]
MaskSymbol                    [\*\?]
Number                        {Digit}+
RusLetter                     [Ä-ü†-ÔÒ]
LatinLetter                   [A-Za-z]
Punct                         [\-\,\@\.\\\/]
RusWord                       {RusLetter}+
MixedLetter                   ({RusLetter}|{LatinLetter}|{Digit})
Mixed                         ({MixedLetter})+
MaskRusWord                   ({RusLetter}|{MaskSymbol})+
MaskMixed                     ({MixedLetter}|{MaskSymbol})+
SomeSpace                     " "+
AnySpace                      " "*
AND                           [à®]
OR                            [à®][ã´][à®]             
BUT                           [ç≠][éÆ]
NO                            [ç≠][Ö•]
ValidOperand                  {RusWord}|{Number}|{MaskRusWord}

%%

<stOperator>[èØSs]/{SomeSpace} begin
                                  yylval.yyInteger := m4InSentence;
                                  return(Distance);
                               end;
<stOperator>[Ä†Aa]/{SomeSpace} begin
                                  yylval.yyInteger := m4InPara;
                                  return(Distance);
                               end;
<stOperator>[Ñ§Dd]/{SomeSpace} begin
                                  yylval.yyInteger := m4InDocument;
                                  return(Distance);
                               end;
<stOperator>{Number}/{SomeSpace} begin
                                  yylval.yyInteger := StrToInt(yyText);
                                  return(Distance);
                                 end;
<stOperator>{AnySpace}           begin
                                  start(0);
                                 end;
{RusWord}                        begin
                                  start(0);
                                  yylval.yyShortString := yyText;
                                  return(RusWord);
                                 end;
{Number}                         begin
                                  start(0);
                                  yylval.yyShortString := yyText;
                                  return(Number);
                                 end;
{Mixed}                          begin
                                  start(0);
                                  yylval.yyShortString := yyText;
                                  return(Mixed);
                                 end;
{MaskRusWord}                    begin
                                  start(0);
                                  yylval.yyShortString := yyText;
                                  return(MaskRusWord);
                                 end;
{MaskMixed}                      begin
                                  start(0);
                                  yylval.yyShortString := yyText;
                                  return(MaskMixed);
                                 end;
{AnySpace}\&                     begin
                                  start(stOperator);
                                  return(_AND_);
                                 end;
{AnySpace}\:{AnySpace}           begin
                                  start(stOperator);
                                  return(_Follow_);
                                 end;
{SomeSpace}{AND}{SomeSpace}      begin
                                  start(0);
                                  return(_AND_);
                                 end;
{SomeSpace}{OR}{SomeSpace}       |
{AnySpace}\|{AnySpace}           begin
                                  start(0);
                                  return(_OR_);
                                 end;
{SomeSpace}{BUT}{SomeSpace}{NO}{SomeSpace} |
{AnySpace}\~{AnySpace}           begin
                                  start(0);
                                  return(_NOT_);
                                 end;
({AnySpace}\n{AnySpace})+/{ValidOperand} |
{AnySpace}                               |
{AnySpace}{Punct}{AnySpace}      begin
                                  start(0);
                                  return(_Follow_);
                                 end;
.                                |
\n                               begin
                                  start(0);
                                  returnc(yytext[1]);
                                 end;