
(* Yacc parser template (TP Yacc V3.0), V1.2 6-17-91 AG *)

(* global definitions: *)

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

const RusWord = 257;
const MaskRusWord = 258;
const Number = 259;
const Distance = 260;
const _Follow_ = 261;
const _AND_ = 262;
const _OR_ = 263;
const _NOT_ = 264;
const Mixed = 265;
const MaskMixed = 266;

function m4ParseSearchFormula(const aString: Tl3PCharLen): Tm4BaseExpression;
  {-}
  
implementation

uses
  SysUtils,
  
  l3Chars,
  l3Memory
  ;

type YYSType = record case Integer of
                 1 : ( yyInteger : Integer );
                 2 : ( yyShortString : ShortString );
                 3 : ( yyTm4BaseExpression : Tm4BaseExpression );
               end(*YYSType*);

function yylex(aLex: Tl3Lex; var yylval : YYSType) : Integer; forward;

function yyparse(aYacc: Tl3Yacc; out theResult: YYSType) : Integer;

var yystate, yysp, yyn : Integer;
    yys : array [1..yymaxdepth] of Integer;
    yyv : array [1..yymaxdepth] of YYSType;
    yyval : YYSType;
var yylval : YYSType;

procedure yyaction ( yyruleno : Integer );
  (* local definitions: *)
begin
  (* actions: *)
 with aYacc do 
  case yyruleno of
   1 : begin
       end;
   2 : begin
         yyaccept; 
       end;
   3 : begin
         l3Set(theResult.yyTm4BaseExpression, yyv[yysp-1].yyTm4BaseExpression); 
         l3Free(yyv[yysp-1].yyTm4BaseExpression);
       end;
   4 : begin
         l3Free(yyv[yysp-1].yyTm4BaseExpression); yyabort; 
       end;
   5 : begin
         yyval.yyTm4BaseExpression := CreateBinaryOp(m4_soAnd, yyv[yysp-3].yyTm4BaseExpression, yyv[yysp-0].yyTm4BaseExpression, yyv[yysp-1].yyInteger); 
       end;
   6 : begin
         yyval.yyTm4BaseExpression := CreateBinaryOp(m4_soFollow, yyv[yysp-3].yyTm4BaseExpression, yyv[yysp-0].yyTm4BaseExpression, yyv[yysp-1].yyInteger); 
       end;
   7 : begin
         yyval.yyTm4BaseExpression := CreateBinaryOp(m4_soAnd, yyv[yysp-2].yyTm4BaseExpression, yyv[yysp-0].yyTm4BaseExpression); 
       end;
   8 : begin
         yyval.yyTm4BaseExpression := CreateBinaryOp(m4_soOr, yyv[yysp-2].yyTm4BaseExpression, yyv[yysp-0].yyTm4BaseExpression); 
       end;
   9 : begin
         yyval.yyTm4BaseExpression := CreateBinaryOp(m4_soAndNot, yyv[yysp-2].yyTm4BaseExpression, yyv[yysp-0].yyTm4BaseExpression); 
       end;
  10 : begin
         yyval.yyTm4BaseExpression := CreateBinaryOp(m4_soFollow, yyv[yysp-2].yyTm4BaseExpression, yyv[yysp-0].yyTm4BaseExpression); 
       end;
  11 : begin
         yyval.yyTm4BaseExpression := yyv[yysp-1].yyTm4BaseExpression; 
       end;
  12 : begin
         yyval.yyTm4BaseExpression := Tm4WordExpression.Create(yyv[yysp-0].yyShortString); 
       end;
  13 : begin
         yyval.yyTm4BaseExpression := Tm4WordExpression.Create(yyv[yysp-0].yyShortString); 
       end;
  14 : begin
         yyval.yyTm4BaseExpression := Tm4WordExpression.Create(yyv[yysp-0].yyShortString); 
       end;
  15 : begin
         yyval.yyTm4BaseExpression := Tm4MaskExpression.Create(yyv[yysp-0].yyShortString); 
       end;
  16 : begin
         yyval.yyTm4BaseExpression := Tm4MaskExpression.Create(yyv[yysp-0].yyShortString); 
       end;
  end;
end(*yyaction*);

(* parse table: *)

type YYARec = record
                sym, act : Integer;
              end;
     YYRRec = record
                len, sym : Integer;
              end;

const

yynacts   = 106;
yyngotos  = 9;
yynstates = 26;
yynrules  = 16;

yya : array [1..yynacts] of YYARec = (
{ 0: }
{ 1: }
  ( sym: 0; act: 0 ),
  ( sym: 10; act: 3 ),
  ( sym: 40; act: 4 ),
  ( sym: 257; act: 5 ),
  ( sym: 258; act: 6 ),
  ( sym: 259; act: 7 ),
  ( sym: 265; act: 8 ),
  ( sym: 266; act: 9 ),
{ 2: }
  ( sym: 10; act: 10 ),
  ( sym: 256; act: 11 ),
  ( sym: 261; act: 12 ),
  ( sym: 262; act: 13 ),
  ( sym: 263; act: 14 ),
  ( sym: 264; act: 15 ),
{ 3: }
{ 4: }
  ( sym: 40; act: 4 ),
  ( sym: 257; act: 5 ),
  ( sym: 258; act: 6 ),
  ( sym: 259; act: 7 ),
  ( sym: 265; act: 8 ),
  ( sym: 266; act: 9 ),
{ 5: }
{ 6: }
{ 7: }
{ 8: }
{ 9: }
{ 10: }
{ 11: }
{ 12: }
  ( sym: 40; act: 4 ),
  ( sym: 257; act: 5 ),
  ( sym: 258; act: 6 ),
  ( sym: 259; act: 7 ),
  ( sym: 260; act: 18 ),
  ( sym: 265; act: 8 ),
  ( sym: 266; act: 9 ),
{ 13: }
  ( sym: 40; act: 4 ),
  ( sym: 257; act: 5 ),
  ( sym: 258; act: 6 ),
  ( sym: 259; act: 7 ),
  ( sym: 260; act: 20 ),
  ( sym: 265; act: 8 ),
  ( sym: 266; act: 9 ),
{ 14: }
  ( sym: 40; act: 4 ),
  ( sym: 257; act: 5 ),
  ( sym: 258; act: 6 ),
  ( sym: 259; act: 7 ),
  ( sym: 265; act: 8 ),
  ( sym: 266; act: 9 ),
{ 15: }
  ( sym: 40; act: 4 ),
  ( sym: 257; act: 5 ),
  ( sym: 258; act: 6 ),
  ( sym: 259; act: 7 ),
  ( sym: 265; act: 8 ),
  ( sym: 266; act: 9 ),
{ 16: }
  ( sym: 41; act: 23 ),
  ( sym: 256; act: 11 ),
  ( sym: 261; act: 12 ),
  ( sym: 262; act: 13 ),
  ( sym: 263; act: 14 ),
  ( sym: 264; act: 15 ),
{ 17: }
  ( sym: 256; act: 11 ),
  ( sym: 10; act: -10 ),
  ( sym: 41; act: -10 ),
  ( sym: 261; act: -10 ),
  ( sym: 262; act: -10 ),
  ( sym: 263; act: -10 ),
  ( sym: 264; act: -10 ),
{ 18: }
  ( sym: 40; act: 4 ),
  ( sym: 257; act: 5 ),
  ( sym: 258; act: 6 ),
  ( sym: 259; act: 7 ),
  ( sym: 265; act: 8 ),
  ( sym: 266; act: 9 ),
{ 19: }
  ( sym: 256; act: 11 ),
  ( sym: 10; act: -7 ),
  ( sym: 41; act: -7 ),
  ( sym: 261; act: -7 ),
  ( sym: 262; act: -7 ),
  ( sym: 263; act: -7 ),
  ( sym: 264; act: -7 ),
{ 20: }
  ( sym: 40; act: 4 ),
  ( sym: 257; act: 5 ),
  ( sym: 258; act: 6 ),
  ( sym: 259; act: 7 ),
  ( sym: 265; act: 8 ),
  ( sym: 266; act: 9 ),
{ 21: }
  ( sym: 256; act: 11 ),
  ( sym: 10; act: -8 ),
  ( sym: 41; act: -8 ),
  ( sym: 261; act: -8 ),
  ( sym: 262; act: -8 ),
  ( sym: 263; act: -8 ),
  ( sym: 264; act: -8 ),
{ 22: }
  ( sym: 256; act: 11 ),
  ( sym: 10; act: -9 ),
  ( sym: 41; act: -9 ),
  ( sym: 261; act: -9 ),
  ( sym: 262; act: -9 ),
  ( sym: 263; act: -9 ),
  ( sym: 264; act: -9 ),
{ 23: }
{ 24: }
  ( sym: 256; act: 11 ),
  ( sym: 261; act: 12 ),
  ( sym: 262; act: 13 ),
  ( sym: 263; act: 14 ),
  ( sym: 264; act: 15 ),
  ( sym: 10; act: -6 ),
  ( sym: 41; act: -6 ),
{ 25: }
  ( sym: 256; act: 11 ),
  ( sym: 261; act: 12 ),
  ( sym: 262; act: 13 ),
  ( sym: 263; act: 14 ),
  ( sym: 264; act: 15 ),
  ( sym: 10; act: -5 ),
  ( sym: 41; act: -5 )
);

yyg : array [1..yyngotos] of YYARec = (
{ 0: }
  ( sym: -3; act: 1 ),
{ 1: }
  ( sym: -2; act: 2 ),
{ 2: }
{ 3: }
{ 4: }
  ( sym: -2; act: 16 ),
{ 5: }
{ 6: }
{ 7: }
{ 8: }
{ 9: }
{ 10: }
{ 11: }
{ 12: }
  ( sym: -2; act: 17 ),
{ 13: }
  ( sym: -2; act: 19 ),
{ 14: }
  ( sym: -2; act: 21 ),
{ 15: }
  ( sym: -2; act: 22 ),
{ 16: }
{ 17: }
{ 18: }
  ( sym: -2; act: 24 ),
{ 19: }
{ 20: }
  ( sym: -2; act: 25 )
{ 21: }
{ 22: }
{ 23: }
{ 24: }
{ 25: }
);

yyd : array [0..yynstates-1] of Integer = (
{ 0: } -1,
{ 1: } 0,
{ 2: } 0,
{ 3: } -2,
{ 4: } 0,
{ 5: } -12,
{ 6: } -15,
{ 7: } -13,
{ 8: } -14,
{ 9: } -16,
{ 10: } -3,
{ 11: } -4,
{ 12: } 0,
{ 13: } 0,
{ 14: } 0,
{ 15: } 0,
{ 16: } 0,
{ 17: } 0,
{ 18: } 0,
{ 19: } 0,
{ 20: } 0,
{ 21: } 0,
{ 22: } 0,
{ 23: } -11,
{ 24: } 0,
{ 25: } 0
);

yyal : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 1,
{ 2: } 9,
{ 3: } 15,
{ 4: } 15,
{ 5: } 21,
{ 6: } 21,
{ 7: } 21,
{ 8: } 21,
{ 9: } 21,
{ 10: } 21,
{ 11: } 21,
{ 12: } 21,
{ 13: } 28,
{ 14: } 35,
{ 15: } 41,
{ 16: } 47,
{ 17: } 53,
{ 18: } 60,
{ 19: } 66,
{ 20: } 73,
{ 21: } 79,
{ 22: } 86,
{ 23: } 93,
{ 24: } 93,
{ 25: } 100
);

yyah : array [0..yynstates-1] of Integer = (
{ 0: } 0,
{ 1: } 8,
{ 2: } 14,
{ 3: } 14,
{ 4: } 20,
{ 5: } 20,
{ 6: } 20,
{ 7: } 20,
{ 8: } 20,
{ 9: } 20,
{ 10: } 20,
{ 11: } 20,
{ 12: } 27,
{ 13: } 34,
{ 14: } 40,
{ 15: } 46,
{ 16: } 52,
{ 17: } 59,
{ 18: } 65,
{ 19: } 72,
{ 20: } 78,
{ 21: } 85,
{ 22: } 92,
{ 23: } 92,
{ 24: } 99,
{ 25: } 106
);

yygl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 2,
{ 2: } 3,
{ 3: } 3,
{ 4: } 3,
{ 5: } 4,
{ 6: } 4,
{ 7: } 4,
{ 8: } 4,
{ 9: } 4,
{ 10: } 4,
{ 11: } 4,
{ 12: } 4,
{ 13: } 5,
{ 14: } 6,
{ 15: } 7,
{ 16: } 8,
{ 17: } 8,
{ 18: } 8,
{ 19: } 9,
{ 20: } 9,
{ 21: } 10,
{ 22: } 10,
{ 23: } 10,
{ 24: } 10,
{ 25: } 10
);

yygh : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 2,
{ 2: } 2,
{ 3: } 2,
{ 4: } 3,
{ 5: } 3,
{ 6: } 3,
{ 7: } 3,
{ 8: } 3,
{ 9: } 3,
{ 10: } 3,
{ 11: } 3,
{ 12: } 4,
{ 13: } 5,
{ 14: } 6,
{ 15: } 7,
{ 16: } 7,
{ 17: } 7,
{ 18: } 8,
{ 19: } 8,
{ 20: } 9,
{ 21: } 9,
{ 22: } 9,
{ 23: } 9,
{ 24: } 9,
{ 25: } 9
);

yyr : array [1..yynrules] of YYRRec = (
{ 1: } ( len: 0; sym: -3 ),
{ 2: } ( len: 2; sym: -3 ),
{ 3: } ( len: 3; sym: -3 ),
{ 4: } ( len: 2; sym: -2 ),
{ 5: } ( len: 4; sym: -2 ),
{ 6: } ( len: 4; sym: -2 ),
{ 7: } ( len: 3; sym: -2 ),
{ 8: } ( len: 3; sym: -2 ),
{ 9: } ( len: 3; sym: -2 ),
{ 10: } ( len: 3; sym: -2 ),
{ 11: } ( len: 3; sym: -2 ),
{ 12: } ( len: 1; sym: -2 ),
{ 13: } ( len: 1; sym: -2 ),
{ 14: } ( len: 1; sym: -2 ),
{ 15: } ( len: 1; sym: -2 ),
{ 16: } ( len: 1; sym: -2 )
);


const _error = 256; (* error token *)

function yyact(state, sym : Integer; var act : Integer) : Boolean;
  (* search action table *)
  var k : Integer;
  begin
    k := yyal[state];
    while (k<=yyah[state]) and (yya[k].sym<>sym) do inc(k);
    if k>yyah[state] then
      yyact := false
    else
      begin
        act := yya[k].act;
        yyact := true;
      end;
  end(*yyact*);

function yygoto(state, sym : Integer; var nstate : Integer) : Boolean;
  (* search goto table *)
  var k : Integer;
  begin
    k := yygl[state];
    while (k<=yygh[state]) and (yyg[k].sym<>sym) do inc(k);
    if k>yygh[state] then
      yygoto := false
    else
      begin
        nstate := yyg[k].act;
        yygoto := true;
      end;
  end(*yygoto*);

label parse, next, error, errlab, shift, reduce, accept, abort;

begin(*yyparse*)
 l3FillChar(theResult, SizeOf(theResult), 0);
 with aYacc do begin
  (* initialize: *)

  yystate := 0; yychar := -1; yynerrs := 0; yyerrflag := 0; yysp := 0;

{$ifdef yydebug}
  yydebug := true;
{$else}
  yydebug := false;
{$endif}

parse:

  (* push state and value: *)

  inc(yysp);
  if yysp>yymaxdepth then
    begin
      yyerror('yyparse stack overflow');
      goto abort;
    end;
  yys[yysp] := yystate; yyv[yysp] := yyval;

next:

  if (yyd[yystate]=0) and (yychar=-1) then
    (* get next symbol *)
    begin
      yychar := yylex(aYacc.Lex, yylval); if yychar<0 then yychar := 0;
    end;

  if yydebug then writeln('state ', yystate, ', char ', yychar);

  (* determine parse action: *)

  yyn := yyd[yystate];
  if yyn<>0 then goto reduce; (* simple state *)

  (* no default action; search parse table *)

  if not yyact(yystate, yychar, yyn) then goto error
  else if yyn>0 then                      goto shift
  else if yyn<0 then                      goto reduce
  else                                    goto accept;

error:

  (* error; start error recovery: *)

  if yyerrflag=0 then yyerror('syntax error');

errlab:

  if yyerrflag=0 then inc(yynerrs);     (* new error *)

  if yyerrflag<=2 then                  (* incomplete recovery; try again *)
    begin
      yyerrflag := 3;
      (* uncover a state with shift action on error token *)
      while (yysp>0) and not ( yyact(yys[yysp], _error, yyn) and
                               (yyn>0) ) do
        begin
          if yydebug then
            if yysp>1 then
              writeln('error recovery pops state ', yys[yysp], ', uncovers ',
                      yys[yysp-1])
            else
              writeln('error recovery fails ... abort');
          dec(yysp);
        end;
      if yysp=0 then goto abort; (* parser has fallen from stack; abort *)
      yystate := yyn;            (* simulate shift on error *)
      goto parse;
    end
  else                                  (* no shift yet; discard symbol *)
    begin
      if yydebug then writeln('error recovery discards char ', yychar);
      if yychar=0 then goto abort; (* end of input; abort *)
      yychar := -1; goto next;     (* clear lookahead char and try again *)
    end;

shift:

  (* go to new state, clear lookahead character: *)

  yystate := yyn; yychar := -1; yyval := yylval;
  if yyerrflag>0 then dec(yyerrflag);

  goto parse;

reduce:

  (* execute action, pop rule from stack, and go to next state: *)

  if yydebug then writeln('reduce ', -yyn);

  yyflag := yyfnone; yyaction(-yyn);
  dec(yysp, yyr[-yyn].len);
  if yygoto(yys[yysp], yyr[-yyn].sym, yyn) then yystate := yyn;

  (* handle action calls to yyaccept, yyabort and yyerror: *)

  case yyflag of
    yyfaccept : goto accept;
    yyfabort  : goto abort;
    yyferror  : goto errlab;
  end;

  goto parse;

accept:

  yyparse := 0; exit;

abort:

  yyparse := 1; exit;
  
 end;//with aYacc
end(*yyparse*);


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