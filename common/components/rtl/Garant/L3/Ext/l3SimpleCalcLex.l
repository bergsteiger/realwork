
  (* Lexical analyzer for the sample Yacc program in Expr.y. *)

L				[A-Za-z]
D				[0-9]

%%

{D}+   begin
        yylval.yyInteger := StrToInt(yytext);
        return(NUM);
       end; 
{L}    begin
        return(ID)
       end;

" "    ;

.      |
\n     returnc(yytext[1]);
