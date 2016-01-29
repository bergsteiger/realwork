
(* lexical analyzer template (TP Lex V3.0), V1.0 3-2-91 AG *)

(* global definitions: *)

  (* Lexical analyzer for the sample Yacc program in Expr.y. *)



function yylex(aLex: Tl3Lex; var yylval : YYSType) : Integer;

procedure yyaction ( yyruleno : Integer );
  (* local definitions: *)

begin
  (* actions: *)
 with aLex do 
  case yyruleno of
  1:
                 begin
                  yylval.yyShortString := yyText;
                  return(RusWord);
                 end;
  2:
                 begin
                  yylval.yyShortString := yyText;
                  return(Number);
                 end;                  

  3,
  4:
                            return(_AND_);
  5,
  6:
                            return(_OR_);
  7,
  8:
                            return(_NOT_);
  9,
  10:
                            return(_Follow_);

  11,
  12:
                            returnc(yytext[1]);
  end;
end(*yyaction*);

(* DFA table: *)

type YYTRec = record
                cc : set of Char;
                s  : Integer;
              end;

const

yynmarks   = 28;
yynmatches = 28;
yyntrans   = 57;
yynstates  = 29;

yyk : array [1..yynmarks] of Integer = (
  { 0: }
  10,
  { 1: }
  10,
  { 2: }
  1,
  11,
  { 3: }
  2,
  11,
  { 4: }
  10,
  11,
  { 5: }
  4,
  11,
  { 6: }
  6,
  11,
  { 7: }
  8,
  11,
  { 8: }
  9,
  11,
  { 9: }
  11,
  { 10: }
  12,
  { 11: }
  1,
  { 12: }
  2,
  { 13: }
  10,
  { 14: }
  { 15: }
  4,
  { 16: }
  6,
  { 17: }
  { 18: }
  8,
  { 19: }
  9,
  { 20: }
  3,
  { 21: }
  { 22: }
  { 23: }
  { 24: }
  { 25: }
  5,
  { 26: }
  { 27: }
  { 28: }
  7
);

yym : array [1..yynmatches] of Integer = (
{ 0: }
  10,
{ 1: }
  10,
{ 2: }
  1,
  11,
{ 3: }
  2,
  11,
{ 4: }
  10,
  11,
{ 5: }
  4,
  11,
{ 6: }
  6,
  11,
{ 7: }
  8,
  11,
{ 8: }
  9,
  11,
{ 9: }
  11,
{ 10: }
  12,
{ 11: }
  1,
{ 12: }
  2,
{ 13: }
  10,
{ 14: }
{ 15: }
  4,
{ 16: }
  6,
{ 17: }
{ 18: }
  8,
{ 19: }
  9,
{ 20: }
  3,
{ 21: }
{ 22: }
{ 23: }
{ 24: }
{ 25: }
  5,
{ 26: }
{ 27: }
{ 28: }
  7
);

yyt : array [1..yyntrans] of YYTrec = (
{ 0: }
  ( cc: [ #1..#9,#11..#31,'!'..'%',''''..'/',';'..'{',
            '}',#127,#240..#255 ]; s: 9),
  ( cc: [ #10 ]; s: 10),
  ( cc: [ ' ' ]; s: 4),
  ( cc: [ '&' ]; s: 5),
  ( cc: [ '0'..'9' ]; s: 3),
  ( cc: [ ':' ]; s: 8),
  ( cc: [ '|' ]; s: 6),
  ( cc: [ '~' ]; s: 7),
  ( cc: [ #128..#239 ]; s: 2),
{ 1: }
  ( cc: [ #1..#9,#11..#31,'!'..'%',''''..'/',';'..'{',
            '}',#127,#240..#255 ]; s: 9),
  ( cc: [ #10 ]; s: 10),
  ( cc: [ ' ' ]; s: 4),
  ( cc: [ '&' ]; s: 5),
  ( cc: [ '0'..'9' ]; s: 3),
  ( cc: [ ':' ]; s: 8),
  ( cc: [ '|' ]; s: 6),
  ( cc: [ '~' ]; s: 7),
  ( cc: [ #128..#239 ]; s: 2),
{ 2: }
  ( cc: [ #128..#239 ]; s: 11),
{ 3: }
  ( cc: [ '0'..'9' ]; s: 12),
{ 4: }
  ( cc: [ ' ' ]; s: 13),
  ( cc: [ '&' ]; s: 15),
  ( cc: [ ':' ]; s: 19),
  ( cc: [ '|' ]; s: 16),
  ( cc: [ '~' ]; s: 18),
  ( cc: [ #136,#168 ]; s: 14),
  ( cc: [ #141,#173 ]; s: 17),
{ 5: }
  ( cc: [ ' ' ]; s: 15),
{ 6: }
  ( cc: [ ' ' ]; s: 16),
{ 7: }
  ( cc: [ ' ' ]; s: 18),
{ 8: }
  ( cc: [ ' ' ]; s: 19),
{ 9: }
{ 10: }
{ 11: }
  ( cc: [ #128..#239 ]; s: 11),
{ 12: }
  ( cc: [ '0'..'9' ]; s: 12),
{ 13: }
  ( cc: [ ' ' ]; s: 13),
  ( cc: [ '&' ]; s: 15),
  ( cc: [ ':' ]; s: 19),
  ( cc: [ '|' ]; s: 16),
  ( cc: [ '~' ]; s: 18),
  ( cc: [ #136,#168 ]; s: 14),
  ( cc: [ #141,#173 ]; s: 17),
{ 14: }
  ( cc: [ ' ' ]; s: 20),
  ( cc: [ #139,#171 ]; s: 21),
{ 15: }
  ( cc: [ ' ' ]; s: 15),
{ 16: }
  ( cc: [ ' ' ]; s: 16),
{ 17: }
  ( cc: [ #142,#174 ]; s: 22),
{ 18: }
  ( cc: [ ' ' ]; s: 18),
{ 19: }
  ( cc: [ ' ' ]; s: 19),
{ 20: }
  ( cc: [ ' ' ]; s: 20),
{ 21: }
  ( cc: [ #136,#168 ]; s: 23),
{ 22: }
  ( cc: [ ' ' ]; s: 24),
{ 23: }
  ( cc: [ ' ' ]; s: 25),
{ 24: }
  ( cc: [ ' ' ]; s: 24),
  ( cc: [ #141,#173 ]; s: 26),
{ 25: }
  ( cc: [ ' ' ]; s: 25),
{ 26: }
  ( cc: [ #133,#165 ]; s: 27),
{ 27: }
  ( cc: [ ' ' ]; s: 28),
{ 28: }
  ( cc: [ ' ' ]; s: 28)
);

yykl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 2,
{ 2: } 3,
{ 3: } 5,
{ 4: } 7,
{ 5: } 9,
{ 6: } 11,
{ 7: } 13,
{ 8: } 15,
{ 9: } 17,
{ 10: } 18,
{ 11: } 19,
{ 12: } 20,
{ 13: } 21,
{ 14: } 22,
{ 15: } 22,
{ 16: } 23,
{ 17: } 24,
{ 18: } 24,
{ 19: } 25,
{ 20: } 26,
{ 21: } 27,
{ 22: } 27,
{ 23: } 27,
{ 24: } 27,
{ 25: } 27,
{ 26: } 28,
{ 27: } 28,
{ 28: } 28
);

yykh : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 2,
{ 2: } 4,
{ 3: } 6,
{ 4: } 8,
{ 5: } 10,
{ 6: } 12,
{ 7: } 14,
{ 8: } 16,
{ 9: } 17,
{ 10: } 18,
{ 11: } 19,
{ 12: } 20,
{ 13: } 21,
{ 14: } 21,
{ 15: } 22,
{ 16: } 23,
{ 17: } 23,
{ 18: } 24,
{ 19: } 25,
{ 20: } 26,
{ 21: } 26,
{ 22: } 26,
{ 23: } 26,
{ 24: } 26,
{ 25: } 27,
{ 26: } 27,
{ 27: } 27,
{ 28: } 28
);

yyml : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 2,
{ 2: } 3,
{ 3: } 5,
{ 4: } 7,
{ 5: } 9,
{ 6: } 11,
{ 7: } 13,
{ 8: } 15,
{ 9: } 17,
{ 10: } 18,
{ 11: } 19,
{ 12: } 20,
{ 13: } 21,
{ 14: } 22,
{ 15: } 22,
{ 16: } 23,
{ 17: } 24,
{ 18: } 24,
{ 19: } 25,
{ 20: } 26,
{ 21: } 27,
{ 22: } 27,
{ 23: } 27,
{ 24: } 27,
{ 25: } 27,
{ 26: } 28,
{ 27: } 28,
{ 28: } 28
);

yymh : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 2,
{ 2: } 4,
{ 3: } 6,
{ 4: } 8,
{ 5: } 10,
{ 6: } 12,
{ 7: } 14,
{ 8: } 16,
{ 9: } 17,
{ 10: } 18,
{ 11: } 19,
{ 12: } 20,
{ 13: } 21,
{ 14: } 21,
{ 15: } 22,
{ 16: } 23,
{ 17: } 23,
{ 18: } 24,
{ 19: } 25,
{ 20: } 26,
{ 21: } 26,
{ 22: } 26,
{ 23: } 26,
{ 24: } 26,
{ 25: } 27,
{ 26: } 27,
{ 27: } 27,
{ 28: } 28
);

yytl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 10,
{ 2: } 19,
{ 3: } 20,
{ 4: } 21,
{ 5: } 28,
{ 6: } 29,
{ 7: } 30,
{ 8: } 31,
{ 9: } 32,
{ 10: } 32,
{ 11: } 32,
{ 12: } 33,
{ 13: } 34,
{ 14: } 41,
{ 15: } 43,
{ 16: } 44,
{ 17: } 45,
{ 18: } 46,
{ 19: } 47,
{ 20: } 48,
{ 21: } 49,
{ 22: } 50,
{ 23: } 51,
{ 24: } 52,
{ 25: } 54,
{ 26: } 55,
{ 27: } 56,
{ 28: } 57
);

yyth : array [0..yynstates-1] of Integer = (
{ 0: } 9,
{ 1: } 18,
{ 2: } 19,
{ 3: } 20,
{ 4: } 27,
{ 5: } 28,
{ 6: } 29,
{ 7: } 30,
{ 8: } 31,
{ 9: } 31,
{ 10: } 31,
{ 11: } 32,
{ 12: } 33,
{ 13: } 40,
{ 14: } 42,
{ 15: } 43,
{ 16: } 44,
{ 17: } 45,
{ 18: } 46,
{ 19: } 47,
{ 20: } 48,
{ 21: } 49,
{ 22: } 50,
{ 23: } 51,
{ 24: } 53,
{ 25: } 54,
{ 26: } 55,
{ 27: } 56,
{ 28: } 57
);


var yyn : Integer;

begin
 with aLex do begin

  repeat

   (* initialize: *)

   yynew;

   repeat

    (* mark positions and matches: *)

    for yyn := yykl[yystate] to     yykh[yystate] do yymark(yyk[yyn]);
    for yyn := yymh[yystate] downto yyml[yystate] do yymatch(yym[yyn]);

    if yytl[yystate]>yyth[yystate] then break; (* dead state *)

    (* get next character: *)

    yyscan;

    (* determine action: *)

    yyn := yytl[yystate];
    while (yyn<=yyth[yystate]) and not (yyactchar in yyt[yyn].cc) do inc(yyn);
    if yyn>yyth[yystate] then break;
      (* no transition on yyactchar in this state *)

    (* switch to new state: *)

    yystate := yyt[yyn].s;

   until false;

   repeat
   (* execute action: *)

   if yyfind(yyrule) then
     begin
       yyaction(yyrule);
       if yyreject then continue;
     end
   else if not yydefault and yywrap then
     begin
       yyclear;
       return(0);
     end;
    break;
   until false;
   
  until yydone;

  yylex := yyretval;

 end;//with aLex
 
end(*yylex*);

