unit l3SpellIntf;

{ Библиотека "L3 (Low Level Library)" }
{ Автор: Бабанин В.Б.                 }
{ Модуль: l3SpellIntf - контейнер для нескольких лингвистических модулей}
{ Начат: 01.04.2009 }
{ $Id: l3SpellIntf.pas,v 1.1 2016/02/15 16:07:49 voba Exp $ }

// $Log: l3SpellIntf.pas,v $
// Revision 1.1  2016/02/15 16:07:49  voba
// no message
//

interface
uses
 //SysUtils,
 //l3Base,
 l3Interfaces,
 l3SpellMisc;
 //l3InterfaceList;

type
 ISpeller = interface
  function CheckSpell(const aWord: UnicodeString): Boolean; overload;
  function CheckSpell(const aWord: AnsiString): Boolean; overload;
  function CheckSpell(const aWord: Tl3PCharLenPrim): Boolean; overload;

  procedure GetSuggestions(const aWord: UnicodeString; aAddFunc : TllAddUStrProc); overload;
  procedure GetSuggestions(const aWord: AnsiString; aAddFunc : TllAddStrProc); overload;
  procedure GetSuggestions(const aWord: Tl3PCharLenPrim; aAddFunc : TllAddStrProc); overload;
 end;

implementation
end.
