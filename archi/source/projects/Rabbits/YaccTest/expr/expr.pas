
(* Yacc parser template (TP Yacc V3.0), V1.2 6-17-91 AG *)

(* global definitions: *)


uses YaccLib, LexLib;

var x : array [1..26] of Real;

const NUM = 257;
const ID = 258;
const UMINUS = 259;
const ILLEGAL = 260;

type YYSType = record case Integer of
                 1 : ( yyInteger : Integer );
                 2 : ( yyReal : Real );
               end(*YYSType*);

var yylval : YYSType;

function yylex : Integer; forward;

function yyparse : Integer;

var yystate, yysp, yyn : Integer;
    yys : array [1..yymaxdepth] of Integer;
    yyv : array [1..yymaxdepth] of YYSType;
    yyval : YYSType;

procedure yyaction ( yyruleno : Integer );
  (* local definitions: *)
begin
  (* actions: *)
  case yyruleno of
   1 : begin
       end;
   2 : begin
         yyaccept; 
       end;
   3 : begin
         writeln(yyv[yysp-1].yyReal:10:2); 
       end;
   4 : begin
         x[yyv[yysp-3].yyInteger] := yyv[yysp-1].yyReal; writeln(yyv[yysp-1].yyReal:10:2); 
       end;
   5 : begin
         yyerrok; 
       end;
   6 : begin
         yyval.yyReal := yyv[yysp-2].yyReal + yyv[yysp-0].yyReal; 
       end;
   7 : begin
         yyval.yyReal := yyv[yysp-2].yyReal - yyv[yysp-0].yyReal; 
       end;
   8 : begin
         yyval.yyReal := yyv[yysp-2].yyReal * yyv[yysp-0].yyReal; 
       end;
   9 : begin
         yyval.yyReal := yyv[yysp-2].yyReal / yyv[yysp-0].yyReal; 
       end;
  10 : begin
         yyval.yyReal := yyv[yysp-1].yyReal; 
       end;
  11 : begin
         yyval.yyReal := -yyv[yysp-0].yyReal; 
       end;
  12 : begin
         yyval.yyReal := yyv[yysp-0].yyReal; 
       end;
  13 : begin
         yyval.yyReal := x[yyv[yysp-0].yyInteger]; 
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

yynacts   = 75;
yyngotos  = 9;
yynstates = 26;
yynrules  = 13;

yya : array [1..yynacts] of YYARec = (
{ 0: }
  ( sym: 256; act: 2 ),
  ( sym: 0; act: -1 ),
  ( sym: 10; act: -1 ),
  ( sym: 40; act: -1 ),
  ( sym: 45; act: -1 ),
  ( sym: 257; act: -1 ),
  ( sym: 258; act: -1 ),
{ 1: }
  ( sym: 0; act: 0 ),
  ( sym: 10; act: 4 ),
  ( sym: 40; act: 5 ),
  ( sym: 45; act: 6 ),
  ( sym: 257; act: 7 ),
  ( sym: 258; act: 8 ),
{ 2: }
  ( sym: 10; act: 9 ),
{ 3: }
  ( sym: 10; act: 10 ),
  ( sym: 42; act: 11 ),
  ( sym: 43; act: 12 ),
  ( sym: 45; act: 13 ),
  ( sym: 47; act: 14 ),
{ 4: }
{ 5: }
  ( sym: 40; act: 5 ),
  ( sym: 45; act: 6 ),
  ( sym: 257; act: 7 ),
  ( sym: 258; act: 16 ),
{ 6: }
  ( sym: 40; act: 5 ),
  ( sym: 45; act: 6 ),
  ( sym: 257; act: 7 ),
  ( sym: 258; act: 16 ),
{ 7: }
{ 8: }
  ( sym: 61; act: 18 ),
  ( sym: 10; act: -13 ),
  ( sym: 42; act: -13 ),
  ( sym: 43; act: -13 ),
  ( sym: 45; act: -13 ),
  ( sym: 47; act: -13 ),
{ 9: }
{ 10: }
{ 11: }
  ( sym: 40; act: 5 ),
  ( sym: 45; act: 6 ),
  ( sym: 257; act: 7 ),
  ( sym: 258; act: 16 ),
{ 12: }
  ( sym: 40; act: 5 ),
  ( sym: 45; act: 6 ),
  ( sym: 257; act: 7 ),
  ( sym: 258; act: 16 ),
{ 13: }
  ( sym: 40; act: 5 ),
  ( sym: 45; act: 6 ),
  ( sym: 257; act: 7 ),
  ( sym: 258; act: 16 ),
{ 14: }
  ( sym: 40; act: 5 ),
  ( sym: 45; act: 6 ),
  ( sym: 257; act: 7 ),
  ( sym: 258; act: 16 ),
{ 15: }
  ( sym: 41; act: 23 ),
  ( sym: 42; act: 11 ),
  ( sym: 43; act: 12 ),
  ( sym: 45; act: 13 ),
  ( sym: 47; act: 14 ),
{ 16: }
{ 17: }
{ 18: }
  ( sym: 40; act: 5 ),
  ( sym: 45; act: 6 ),
  ( sym: 257; act: 7 ),
  ( sym: 258; act: 16 ),
{ 19: }
{ 20: }
  ( sym: 42; act: 11 ),
  ( sym: 47; act: 14 ),
  ( sym: 10; act: -6 ),
  ( sym: 41; act: -6 ),
  ( sym: 43; act: -6 ),
  ( sym: 45; act: -6 ),
{ 21: }
  ( sym: 42; act: 11 ),
  ( sym: 47; act: 14 ),
  ( sym: 10; act: -7 ),
  ( sym: 41; act: -7 ),
  ( sym: 43; act: -7 ),
  ( sym: 45; act: -7 ),
{ 22: }
{ 23: }
{ 24: }
  ( sym: 10; act: 25 ),
  ( sym: 42; act: 11 ),
  ( sym: 43; act: 12 ),
  ( sym: 45; act: 13 ),
  ( sym: 47; act: 14 )
{ 25: }
);

yyg : array [1..yyngotos] of YYARec = (
{ 0: }
  ( sym: -3; act: 1 ),
{ 1: }
  ( sym: -2; act: 3 ),
{ 2: }
{ 3: }
{ 4: }
{ 5: }
  ( sym: -2; act: 15 ),
{ 6: }
  ( sym: -2; act: 17 ),
{ 7: }
{ 8: }
{ 9: }
{ 10: }
{ 11: }
  ( sym: -2; act: 19 ),
{ 12: }
  ( sym: -2; act: 20 ),
{ 13: }
  ( sym: -2; act: 21 ),
{ 14: }
  ( sym: -2; act: 22 ),
{ 15: }
{ 16: }
{ 17: }
{ 18: }
  ( sym: -2; act: 24 )
{ 19: }
{ 20: }
{ 21: }
{ 22: }
{ 23: }
{ 24: }
{ 25: }
);

yyd : array [0..yynstates-1] of Integer = (
{ 0: } 0,
{ 1: } 0,
{ 2: } 0,
{ 3: } 0,
{ 4: } -2,
{ 5: } 0,
{ 6: } 0,
{ 7: } -12,
{ 8: } 0,
{ 9: } -5,
{ 10: } -3,
{ 11: } 0,
{ 12: } 0,
{ 13: } 0,
{ 14: } 0,
{ 15: } 0,
{ 16: } -13,
{ 17: } -11,
{ 18: } 0,
{ 19: } -8,
{ 20: } 0,
{ 21: } 0,
{ 22: } -9,
{ 23: } -10,
{ 24: } 0,
{ 25: } -4
);

yyal : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 8,
{ 2: } 14,
{ 3: } 15,
{ 4: } 20,
{ 5: } 20,
{ 6: } 24,
{ 7: } 28,
{ 8: } 28,
{ 9: } 34,
{ 10: } 34,
{ 11: } 34,
{ 12: } 38,
{ 13: } 42,
{ 14: } 46,
{ 15: } 50,
{ 16: } 55,
{ 17: } 55,
{ 18: } 55,
{ 19: } 59,
{ 20: } 59,
{ 21: } 65,
{ 22: } 71,
{ 23: } 71,
{ 24: } 71,
{ 25: } 76
);

yyah : array [0..yynstates-1] of Integer = (
{ 0: } 7,
{ 1: } 13,
{ 2: } 14,
{ 3: } 19,
{ 4: } 19,
{ 5: } 23,
{ 6: } 27,
{ 7: } 27,
{ 8: } 33,
{ 9: } 33,
{ 10: } 33,
{ 11: } 37,
{ 12: } 41,
{ 13: } 45,
{ 14: } 49,
{ 15: } 54,
{ 16: } 54,
{ 17: } 54,
{ 18: } 58,
{ 19: } 58,
{ 20: } 64,
{ 21: } 70,
{ 22: } 70,
{ 23: } 70,
{ 24: } 75,
{ 25: } 75
);

yygl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 2,
{ 2: } 3,
{ 3: } 3,
{ 4: } 3,
{ 5: } 3,
{ 6: } 4,
{ 7: } 5,
{ 8: } 5,
{ 9: } 5,
{ 10: } 5,
{ 11: } 5,
{ 12: } 6,
{ 13: } 7,
{ 14: } 8,
{ 15: } 9,
{ 16: } 9,
{ 17: } 9,
{ 18: } 9,
{ 19: } 10,
{ 20: } 10,
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
{ 4: } 2,
{ 5: } 3,
{ 6: } 4,
{ 7: } 4,
{ 8: } 4,
{ 9: } 4,
{ 10: } 4,
{ 11: } 5,
{ 12: } 6,
{ 13: } 7,
{ 14: } 8,
{ 15: } 8,
{ 16: } 8,
{ 17: } 8,
{ 18: } 9,
{ 19: } 9,
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
{ 4: } ( len: 5; sym: -3 ),
{ 5: } ( len: 2; sym: -3 ),
{ 6: } ( len: 3; sym: -2 ),
{ 7: } ( len: 3; sym: -2 ),
{ 8: } ( len: 3; sym: -2 ),
{ 9: } ( len: 3; sym: -2 ),
{ 10: } ( len: 3; sym: -2 ),
{ 11: } ( len: 2; sym: -2 ),
{ 12: } ( len: 1; sym: -2 ),
{ 13: } ( len: 1; sym: -2 )
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
      yychar := yylex; if yychar<0 then yychar := 0;
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

end(*yyparse*);


{$I exprlex.pas}

var i : Integer;

begin
  for i := 1 to 26 do x[i] := 0.0;
  if yyparse=0 then { done };
end.