
(* Yacc parser template (TP Yacc V3.0), V1.2 6-17-91 AG *)

(* global definitions: *)

uses 
  l3Base, 
  l3LexLib, 
  l3YaccLib, 
  
  m4Search
  ;

const RusWord = 257;
const Number = 258;
const _Follow_ = 259;
const _AND_ = 260;
const _OR_ = 261;
const _NOT_ = 262;

type YYSType = record case Integer of
                 1 : ( yyString : String );
                 2 : ( yyTm4BaseExpression : Tm4BaseExpression );
               end(*YYSType*);

function yylex(aLex: Tl3Lex; var yylval : YYSType) : Integer; forward;

function yyparse(aYacc: Tl3Yacc) : Integer;

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
         writeln(yyv[yysp-1].yyTm4BaseExpression.Evaluate); 
         l3Free(yyv[yysp-1].yyTm4BaseExpression);
       end;
   4 : begin
         yyerrok; 
       end;
   5 : begin
         yyval.yyTm4BaseExpression := CreateBinaryOp(m4_soAnd, yyv[yysp-2].yyTm4BaseExpression, yyv[yysp-0].yyTm4BaseExpression); 
       end;
   6 : begin
         yyval.yyTm4BaseExpression := CreateBinaryOp(m4_soOr, yyv[yysp-2].yyTm4BaseExpression, yyv[yysp-0].yyTm4BaseExpression); 
       end;
   7 : begin
         yyval.yyTm4BaseExpression := CreateBinaryOp(m4_soAndNot, yyv[yysp-2].yyTm4BaseExpression, yyv[yysp-0].yyTm4BaseExpression); 
       end;
   8 : begin
         yyval.yyTm4BaseExpression := CreateBinaryOp(m4_soFollow, yyv[yysp-2].yyTm4BaseExpression, yyv[yysp-0].yyTm4BaseExpression); 
       end;
   9 : begin
         yyval.yyTm4BaseExpression := yyv[yysp-1].yyTm4BaseExpression;            
       end;
  10 : begin
         yyval.yyTm4BaseExpression := Tm4SimpleExpression.Create(yyv[yysp-0].yyString); 
       end;
  11 : begin
         yyval.yyTm4BaseExpression := Tm4SimpleExpression.Create(yyv[yysp-0].yyString); 
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

yynacts   = 37;
yyngotos  = 7;
yynstates = 20;
yynrules  = 11;

yya : array [1..yynacts] of YYARec = (
{ 0: }
  ( sym: 256; act: 2 ),
  ( sym: 0; act: -1 ),
  ( sym: 10; act: -1 ),
  ( sym: 40; act: -1 ),
  ( sym: 257; act: -1 ),
  ( sym: 258; act: -1 ),
{ 1: }
  ( sym: 0; act: 0 ),
  ( sym: 10; act: 4 ),
  ( sym: 40; act: 5 ),
  ( sym: 257; act: 6 ),
  ( sym: 258; act: 7 ),
{ 2: }
  ( sym: 10; act: 8 ),
{ 3: }
  ( sym: 10; act: 9 ),
  ( sym: 259; act: 10 ),
  ( sym: 260; act: 11 ),
  ( sym: 261; act: 12 ),
  ( sym: 262; act: 13 ),
{ 4: }
{ 5: }
  ( sym: 40; act: 5 ),
  ( sym: 257; act: 6 ),
  ( sym: 258; act: 7 ),
{ 6: }
{ 7: }
{ 8: }
{ 9: }
{ 10: }
  ( sym: 40; act: 5 ),
  ( sym: 257; act: 6 ),
  ( sym: 258; act: 7 ),
{ 11: }
  ( sym: 40; act: 5 ),
  ( sym: 257; act: 6 ),
  ( sym: 258; act: 7 ),
{ 12: }
  ( sym: 40; act: 5 ),
  ( sym: 257; act: 6 ),
  ( sym: 258; act: 7 ),
{ 13: }
  ( sym: 40; act: 5 ),
  ( sym: 257; act: 6 ),
  ( sym: 258; act: 7 ),
{ 14: }
  ( sym: 41; act: 19 ),
  ( sym: 259; act: 10 ),
  ( sym: 260; act: 11 ),
  ( sym: 261; act: 12 ),
  ( sym: 262; act: 13 )
{ 15: }
{ 16: }
{ 17: }
{ 18: }
{ 19: }
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
  ( sym: -2; act: 14 ),
{ 6: }
{ 7: }
{ 8: }
{ 9: }
{ 10: }
  ( sym: -2; act: 15 ),
{ 11: }
  ( sym: -2; act: 16 ),
{ 12: }
  ( sym: -2; act: 17 ),
{ 13: }
  ( sym: -2; act: 18 )
{ 14: }
{ 15: }
{ 16: }
{ 17: }
{ 18: }
{ 19: }
);

yyd : array [0..yynstates-1] of Integer = (
{ 0: } 0,
{ 1: } 0,
{ 2: } 0,
{ 3: } 0,
{ 4: } -2,
{ 5: } 0,
{ 6: } -10,
{ 7: } -11,
{ 8: } -4,
{ 9: } -3,
{ 10: } 0,
{ 11: } 0,
{ 12: } 0,
{ 13: } 0,
{ 14: } 0,
{ 15: } -8,
{ 16: } -5,
{ 17: } -6,
{ 18: } -7,
{ 19: } -9
);

yyal : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 7,
{ 2: } 12,
{ 3: } 13,
{ 4: } 18,
{ 5: } 18,
{ 6: } 21,
{ 7: } 21,
{ 8: } 21,
{ 9: } 21,
{ 10: } 21,
{ 11: } 24,
{ 12: } 27,
{ 13: } 30,
{ 14: } 33,
{ 15: } 38,
{ 16: } 38,
{ 17: } 38,
{ 18: } 38,
{ 19: } 38
);

yyah : array [0..yynstates-1] of Integer = (
{ 0: } 6,
{ 1: } 11,
{ 2: } 12,
{ 3: } 17,
{ 4: } 17,
{ 5: } 20,
{ 6: } 20,
{ 7: } 20,
{ 8: } 20,
{ 9: } 20,
{ 10: } 23,
{ 11: } 26,
{ 12: } 29,
{ 13: } 32,
{ 14: } 37,
{ 15: } 37,
{ 16: } 37,
{ 17: } 37,
{ 18: } 37,
{ 19: } 37
);

yygl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 2,
{ 2: } 3,
{ 3: } 3,
{ 4: } 3,
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
{ 18: } 8,
{ 19: } 8
);

yygh : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 2,
{ 2: } 2,
{ 3: } 2,
{ 4: } 2,
{ 5: } 3,
{ 6: } 3,
{ 7: } 3,
{ 8: } 3,
{ 9: } 3,
{ 10: } 4,
{ 11: } 5,
{ 12: } 6,
{ 13: } 7,
{ 14: } 7,
{ 15: } 7,
{ 16: } 7,
{ 17: } 7,
{ 18: } 7,
{ 19: } 7
);

yyr : array [1..yynrules] of YYRRec = (
{ 1: } ( len: 0; sym: -3 ),
{ 2: } ( len: 2; sym: -3 ),
{ 3: } ( len: 3; sym: -3 ),
{ 4: } ( len: 2; sym: -3 ),
{ 5: } ( len: 3; sym: -2 ),
{ 6: } ( len: 3; sym: -2 ),
{ 7: } ( len: 3; sym: -2 ),
{ 8: } ( len: 3; sym: -2 ),
{ 9: } ( len: 3; sym: -2 ),
{ 10: } ( len: 1; sym: -2 ),
{ 11: } ( len: 1; sym: -2 )
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