unit l3YaccLib;
{* Объектная обертка к Yacc Library Unit for TP Yacc Version 3.0, 6-17-91 AG }

{ Библиотека "L3 (Low Level Library)" }
{ Автор: Люлин А.В. ©                 }
{ Модуль: l3YaccLib -                 }
{ Начат: 11.12.2001 17:44             }
{ $Id: l3YaccLib.pas,v 1.6 2011/05/18 12:09:36 lulin Exp $ }

// $Log: l3YaccLib.pas,v $
// Revision 1.6  2011/05/18 12:09:36  lulin
// {RequestLink:266409354}.
//
// Revision 1.5  2001/12/19 08:27:45  law
// - new behavior: сделана обработка ошибок в поисковых формулах.
//
// Revision 1.4  2001/12/14 16:39:18  law
// - new unit: m4SearchFormula.
//
// Revision 1.3  2001/12/14 14:18:07  law
// - new behavior: в первом приближении написана объектная обертка для Yacc и Lex.
//
// Revision 1.2  2001/12/11 15:36:51  law
// - change: продолжаем работу над обертками.
//
// Revision 1.1  2001/12/11 15:20:16  law
// - new units: начата работа над объектными обертками для Lex и Yacc.
//

{$Include l3Define.inc }

{$I-}

interface

uses
  Classes,
  l3Base,
  l3LexLib,
  l3ProtoObject
  ;

type
  Tl3Yacc = class(Tl3ProtoObject)
   {* Машина для граматического разбора. }
    private
    // property fields
      f_Lex : Tl3Lex;
    protected
    // property methods
      {$IfDef l3LexUseStdIn}
      function pm_GetLex: Tl3Lex;
        {-}
      {$EndIf l3LexUseStdIn}
    protected
    // internal methods
      procedure Release;
        override;
        {-}
    public
    //
      yychar   : Integer; {* current lookahead character }
      yynerrs  : Integer; {* current number of syntax errors reported by the
                             parser }
      yydebug  : Boolean; {* set to true to enable debugging output of parser }

      yyflag    : ( yyfnone, yyfaccept, yyfabort, yyferror );
        {* Flags used internally by the parser routine: }
      yyerrflag : Integer;

      procedure yyerror ( msg : String );
        {* error message printing routine used by the parser }

      procedure yyclearin;
        {* delete the current lookahead token }

      procedure yyaccept;
        {* trigger accept action of the parser; yyparse accepts returning 0, as if
           it reached end of input }

      procedure yyabort;
        {* like yyaccept, but causes parser to return with value 1, as if an
           unrecoverable syntax error had been encountered }

      procedure yyerrlab;
        {* causes error recovery to be started, as if a syntax error had been
           encountered }

      procedure yyerrok;
        {* when in error mode, resets the parser to its normal mode of
           operation }
    {$IfNDef l3LexUseStdIn}
    public
    // public methods
      constructor Create(aStream: TStream);
        reintroduce;
        {-}
    {$EndIf l3LexUseStdIn}
    public
    // public properties
      property Lex: Tl3Lex
        read
        {$IfDef l3LexUseStdIn}
        pm_GetLex
        {$Else  l3LexUseStdIn}
        f_Lex
        {$EndIf l3LexUseStdIn};
        {-}
  end;//Tl3Yacc

const yymaxdepth = 1024;
  {* default stack size of parser }

type YYSType = Integer;
  {* default value type, may be redefined in Yacc output file }

implementation

// start class Tl3Yacc

{$IfNDef l3LexUseStdIn}
constructor Tl3Yacc.Create(aStream: TStream);
  //reintroduce;
  {-}
begin
 inherited Create;
 f_Lex := Tl3Lex.Create(aStream);
end;
{$EndIf l3LexUseStdIn}

procedure Tl3Yacc.yyerror ( msg : String );
  begin
    {$IfDef Console}
     writeln(msg);
    {$EndIf Console}
  end{*yyerrmsg};

procedure Tl3Yacc.yyclearin;
  begin
    yychar := -1;
  end{*yyclearin};

procedure Tl3Yacc.yyaccept;
  begin
    yyflag := yyfaccept;
  end{*yyaccept};

procedure Tl3Yacc.yyabort;
  begin
    yyflag := yyfabort;
  end{*yyabort};

procedure Tl3Yacc.yyerrlab;
  begin
    yyflag := yyferror;
  end{*yyerrlab};

procedure Tl3Yacc.yyerrok;
  begin
    yyerrflag := 0;
  end{*yyerrork};

procedure Tl3Yacc.Release;
  //override;
  {-}
begin
 l3Free(f_Lex);
 inherited;
end;

{$IfDef l3LexUseStdIn}
function Tl3Yacc.pm_GetLex: Tl3Lex;
  {-}
begin
 if (f_Lex = nil) then f_Lex := Tl3Lex.Create;
 Result := f_Lex;
end;
{$EndIf l3LexUseStdIn}

end{*YaccLib}.
