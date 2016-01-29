
(* Yacc parser template (TP Yacc V3.0), V1.2 6-17-91 AG *)

(* global definitions: *)

unit l3SimpleCalc;

{$I l3Define.inc}

interface

uses 
  l3Types,
  l3Base, 
  l3LexLib, 
  l3YaccLib
  ;

const NUM = 257;
const ID = 258;
const UMINUS = 259;
const ILLEGAL = 260;

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

type YYSType = record case Integer of
                 1 : ( yyInteger : Integer );
               end(*YYSType*);

function yylex(aLex: Tl3Lex; var yylval : YYSType) : Integer; forward;

function yyparse(aYacc         : Tl3Yacc; 
                 out theResult : YYSType) : Integer;

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
         theResult.yyInteger := yyv[yysp-1].yyInteger; 
       end;
   4 : begin
         yyabort; 
       end;
   5 : begin
         yyval.yyInteger := yyv[yysp-2].yyInteger + yyv[yysp-0].yyInteger; 
       end;
   6 : begin
         yyval.yyInteger := yyv[yysp-2].yyInteger - yyv[yysp-0].yyInteger; 
       end;
   7 : begin
         yyval.yyInteger := yyv[yysp-2].yyInteger * yyv[yysp-0].yyInteger; 
       end;
   8 : begin
         yyval.yyInteger := yyv[yysp-2].yyInteger div yyv[yysp-0].yyInteger; 
       end;
   9 : begin
         yyval.yyInteger := yyv[yysp-1].yyInteger; 
       end;
  10 : begin
         yyval.yyInteger := -yyv[yysp-0].yyInteger; 
       end;
  11 : begin
         yyval.yyInteger := yyv[yysp-0].yyInteger; 
       end;
  12 : begin
         yyval.yyInteger := (aYacc As Tl3SimpleYacc).ParamValue; 
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

yynacts   = 77;
yyngotos  = 8;
yynstates = 21;
yynrules  = 12;

yya : array [1..yynacts] of YYARec = (
{ 0: }
{ 1: }
  ( sym: 0; act: 0 ),
  ( sym: 10; act: 3 ),
  ( sym: 40; act: 4 ),
  ( sym: 45; act: 5 ),
  ( sym: 257; act: 6 ),
  ( sym: 258; act: 7 ),
{ 2: }
  ( sym: 10; act: 8 ),
  ( sym: 42; act: 9 ),
  ( sym: 43; act: 10 ),
  ( sym: 45; act: 11 ),
  ( sym: 47; act: 12 ),
  ( sym: 256; act: 13 ),
{ 3: }
{ 4: }
  ( sym: 40; act: 4 ),
  ( sym: 45; act: 5 ),
  ( sym: 257; act: 6 ),
  ( sym: 258; act: 7 ),
{ 5: }
  ( sym: 40; act: 4 ),
  ( sym: 45; act: 5 ),
  ( sym: 257; act: 6 ),
  ( sym: 258; act: 7 ),
{ 6: }
{ 7: }
{ 8: }
{ 9: }
  ( sym: 40; act: 4 ),
  ( sym: 45; act: 5 ),
  ( sym: 257; act: 6 ),
  ( sym: 258; act: 7 ),
{ 10: }
  ( sym: 40; act: 4 ),
  ( sym: 45; act: 5 ),
  ( sym: 257; act: 6 ),
  ( sym: 258; act: 7 ),
{ 11: }
  ( sym: 40; act: 4 ),
  ( sym: 45; act: 5 ),
  ( sym: 257; act: 6 ),
  ( sym: 258; act: 7 ),
{ 12: }
  ( sym: 40; act: 4 ),
  ( sym: 45; act: 5 ),
  ( sym: 257; act: 6 ),
  ( sym: 258; act: 7 ),
{ 13: }
{ 14: }
  ( sym: 41; act: 20 ),
  ( sym: 42; act: 9 ),
  ( sym: 43; act: 10 ),
  ( sym: 45; act: 11 ),
  ( sym: 47; act: 12 ),
  ( sym: 256; act: 13 ),
{ 15: }
  ( sym: 256; act: 13 ),
  ( sym: 10; act: -10 ),
  ( sym: 41; act: -10 ),
  ( sym: 42; act: -10 ),
  ( sym: 43; act: -10 ),
  ( sym: 45; act: -10 ),
  ( sym: 47; act: -10 ),
{ 16: }
  ( sym: 256; act: 13 ),
  ( sym: 10; act: -7 ),
  ( sym: 41; act: -7 ),
  ( sym: 42; act: -7 ),
  ( sym: 43; act: -7 ),
  ( sym: 45; act: -7 ),
  ( sym: 47; act: -7 ),
{ 17: }
  ( sym: 42; act: 9 ),
  ( sym: 47; act: 12 ),
  ( sym: 256; act: 13 ),
  ( sym: 10; act: -5 ),
  ( sym: 41; act: -5 ),
  ( sym: 43; act: -5 ),
  ( sym: 45; act: -5 ),
{ 18: }
  ( sym: 42; act: 9 ),
  ( sym: 47; act: 12 ),
  ( sym: 256; act: 13 ),
  ( sym: 10; act: -6 ),
  ( sym: 41; act: -6 ),
  ( sym: 43; act: -6 ),
  ( sym: 45; act: -6 ),
{ 19: }
  ( sym: 256; act: 13 ),
  ( sym: 10; act: -8 ),
  ( sym: 41; act: -8 ),
  ( sym: 42; act: -8 ),
  ( sym: 43; act: -8 ),
  ( sym: 45; act: -8 ),
  ( sym: 47; act: -8 )
{ 20: }
);

yyg : array [1..yyngotos] of YYARec = (
{ 0: }
  ( sym: -3; act: 1 ),
{ 1: }
  ( sym: -2; act: 2 ),
{ 2: }
{ 3: }
{ 4: }
  ( sym: -2; act: 14 ),
{ 5: }
  ( sym: -2; act: 15 ),
{ 6: }
{ 7: }
{ 8: }
{ 9: }
  ( sym: -2; act: 16 ),
{ 10: }
  ( sym: -2; act: 17 ),
{ 11: }
  ( sym: -2; act: 18 ),
{ 12: }
  ( sym: -2; act: 19 )
{ 13: }
{ 14: }
{ 15: }
{ 16: }
{ 17: }
{ 18: }
{ 19: }
{ 20: }
);

yyd : array [0..yynstates-1] of Integer = (
{ 0: } -1,
{ 1: } 0,
{ 2: } 0,
{ 3: } -2,
{ 4: } 0,
{ 5: } 0,
{ 6: } -11,
{ 7: } -12,
{ 8: } -3,
{ 9: } 0,
{ 10: } 0,
{ 11: } 0,
{ 12: } 0,
{ 13: } -4,
{ 14: } 0,
{ 15: } 0,
{ 16: } 0,
{ 17: } 0,
{ 18: } 0,
{ 19: } 0,
{ 20: } -9
);

yyal : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 1,
{ 2: } 7,
{ 3: } 13,
{ 4: } 13,
{ 5: } 17,
{ 6: } 21,
{ 7: } 21,
{ 8: } 21,
{ 9: } 21,
{ 10: } 25,
{ 11: } 29,
{ 12: } 33,
{ 13: } 37,
{ 14: } 37,
{ 15: } 43,
{ 16: } 50,
{ 17: } 57,
{ 18: } 64,
{ 19: } 71,
{ 20: } 78
);

yyah : array [0..yynstates-1] of Integer = (
{ 0: } 0,
{ 1: } 6,
{ 2: } 12,
{ 3: } 12,
{ 4: } 16,
{ 5: } 20,
{ 6: } 20,
{ 7: } 20,
{ 8: } 20,
{ 9: } 24,
{ 10: } 28,
{ 11: } 32,
{ 12: } 36,
{ 13: } 36,
{ 14: } 42,
{ 15: } 49,
{ 16: } 56,
{ 17: } 63,
{ 18: } 70,
{ 19: } 77,
{ 20: } 77
);

yygl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 2,
{ 2: } 3,
{ 3: } 3,
{ 4: } 3,
{ 5: } 4,
{ 6: } 5,
{ 7: } 5,
{ 8: } 5,
{ 9: } 5,
{ 10: } 6,
{ 11: } 7,
{ 12: } 8,
{ 13: } 9,
{ 14: } 9,
{ 15: } 9,
{ 16: } 9,
{ 17: } 9,
{ 18: } 9,
{ 19: } 9,
{ 20: } 9
);

yygh : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 2,
{ 2: } 2,
{ 3: } 2,
{ 4: } 3,
{ 5: } 4,
{ 6: } 4,
{ 7: } 4,
{ 8: } 4,
{ 9: } 5,
{ 10: } 6,
{ 11: } 7,
{ 12: } 8,
{ 13: } 8,
{ 14: } 8,
{ 15: } 8,
{ 16: } 8,
{ 17: } 8,
{ 18: } 8,
{ 19: } 8,
{ 20: } 8
);

yyr : array [1..yynrules] of YYRRec = (
{ 1: } ( len: 0; sym: -3 ),
{ 2: } ( len: 2; sym: -3 ),
{ 3: } ( len: 3; sym: -3 ),
{ 4: } ( len: 2; sym: -2 ),
{ 5: } ( len: 3; sym: -2 ),
{ 6: } ( len: 3; sym: -2 ),
{ 7: } ( len: 3; sym: -2 ),
{ 8: } ( len: 3; sym: -2 ),
{ 9: } ( len: 3; sym: -2 ),
{ 10: } ( len: 2; sym: -2 ),
{ 11: } ( len: 1; sym: -2 ),
{ 12: } ( len: 1; sym: -2 )
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