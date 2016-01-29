unit NOT_FINISHED_l3RegEx;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Бабанин В.Б.
// Модуль: "w:/common/components/rtl/Garant/L3/NOT_FINISHED_l3RegEx.pas"
// Начат: 2004/03/25 15:04:22
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::L3::l3Misc::l3RegEx
//
// Поиск по регулярным выражениям. Описание смотри в конце модуля.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3Interfaces,
  l3_Base
  ;

type
 Tl3RegularSearch = class(Tl3_Base)
 end;//Tl3RegularSearch

 Tl3MatchPosition = record
   StartPos : Cardinal;
   EndPos : Cardinal;
   Length : Cardinal;
   LineNum : Cardinal;
 end;//Tl3MatchPosition

 Tl3OutputOption = (
   ooUnselected
 , ooModified
 , ooCountOnly
 );//Tl3OutputOption

 Tl3OutputOptions = set of Tl3OutputOption;

 Tl3Tokens = (
   tknNil
 , tknLitChar
 , tknCharClass
 , tknNegCharClass
 , tknClosure
 , tknMaybeOne
 , tknAnyChar
 , tknBegOfLine
 , tknEndOfLine
 , tknGroup
 , tknBegTag
 , tknEndTag
 , tknDitto
 , tknBegOfWord
 , tknEndOfWord
 );//Tl3Tokens

 TSetOfChar = set of AnsiChar;

 Tl3PatRecord = packed record
   Token : Tl3Tokens;
   PossibleChars : TSetOfChar;
   NextOK : Boolean;
 end;//Tl3PatRecord

 Pl3PatRecord = ^Tl3PatRecord;

 Tl3NodeHeap = class
 end;//Tl3NodeHeap

function ConvertStrToRegular(const S: AnsiString): AnsiString;
function L3CheckStrByPattern(const aPattern: AnsiString;
  const aString: Tl3WString): Boolean;

implementation

// unit methods

function ConvertStrToRegular(const S: AnsiString): AnsiString;
//#UC START# *483D7F570199_483D7D8C001A_var*
//#UC END# *483D7F570199_483D7D8C001A_var*
begin
//#UC START# *483D7F570199_483D7D8C001A_impl*
 !!! Needs to be implemented !!!
//#UC END# *483D7F570199_483D7D8C001A_impl*
end;//ConvertStrToRegular

function L3CheckStrByPattern(const aPattern: AnsiString;
  const aString: Tl3WString): Boolean;
//#UC START# *49EEEAF70182_483D7D8C001A_var*
//#UC END# *49EEEAF70182_483D7D8C001A_var*
begin
//#UC START# *49EEEAF70182_483D7D8C001A_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EEEAF70182_483D7D8C001A_impl*
end;//L3CheckStrByPattern

end.