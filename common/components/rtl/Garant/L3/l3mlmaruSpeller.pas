unit l3mlmaruSpeller;

{ Библиотека "L3 (Low Level Library)" }
{ Автор: Бабанин В.Б.                 }
{ Модуль: l3Speller - контейнер для нескольких лингвистических модулей}
{ Начат: 01.04.2009 }
{ $Id: l3mlmaruSpeller.pas,v 1.1 2016/02/15 16:07:49 voba Exp $ }

// $Log: l3mlmaruSpeller.pas,v $
// Revision 1.1  2016/02/15 16:07:49  voba
// no message
//

interface
uses
 SysUtils,
 l3Base,
 l3Interfaces,
 l3SpellMisc,
 l3SpellIntf;

type
 Tl3mlmaruSpeller = class(Tl3Base, ISpeller)
 protected
  procedure Cleanup; override;
 public
  constructor Create; reintroduce;

  function CheckSpell(const aWord: UnicodeString): Boolean; overload;
  function CheckSpell(const aWord: AnsiString): Boolean; overload;
  function CheckSpell(const aWord: Tl3PCharLenPrim): Boolean; overload;

  procedure GetSuggestions(const aWord: UnicodeString; aAddFunc : TllAddUStrProc); overload;
  procedure GetSuggestions(const aWord: AnsiString; aAddFunc : TllAddStrProc); overload;
  procedure GetSuggestions(const aWord: Tl3PCharLenPrim; aAddFunc : TllAddStrProc); overload;

 end;

implementation
 uses
  l3LingLib;

 constructor Tl3mlmaruSpeller.Create;
 begin
  inherited;
 end;

 procedure Tl3mlmaruSpeller.Cleanup;
 begin
  inherited;
 end;

 function Tl3mlmaruSpeller.CheckSpell(const aWord: UnicodeString): Boolean;
 begin
  assert(false, 'Не реализовно Tl3mlmaruSpeller.CheckSpell for UnicodeString');
 end;

 function Tl3mlmaruSpeller.CheckSpell(const aWord: AnsiString): Boolean;
 begin
  Result := mlmaruCheckWord(PAnsiChar(aWord), maStopAfterFirst) = 1;
 end;

 function Tl3mlmaruSpeller.CheckSpell(const aWord: Tl3PCharLenPrim): Boolean;
 begin
  Result := mlmaruCheckWord(aWord, maStopAfterFirst) = 1;
 end;

  procedure Tl3mlmaruSpeller.GetSuggestions(const aWord: UnicodeString; aAddFunc : TllAddUStrProc);
 begin
  assert(false, 'Не реализовно Tl3mlmaruSpeller.GetSuggestions for UnicodeString');
 end;

 procedure Tl3mlmaruSpeller.GetSuggestions(const aWord: AnsiString; aAddFunc : TllAddStrProc);
 begin
  mlmaSpellCheck(PAnsiChar(aWord), Length(aWord), aAddFunc);
 end;

 procedure Tl3mlmaruSpeller.GetSuggestions(const aWord: Tl3PCharLenPrim; aAddFunc : TllAddStrProc);
 begin
  mlmaSpellCheck(aWord.S, aWord.SLen, aAddFunc);
 end;

end.
