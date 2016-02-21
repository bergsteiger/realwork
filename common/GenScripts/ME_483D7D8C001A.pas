unit NOT_FINISHED_l3RegEx;
 {* Поиск по регулярным выражениям. Описание смотри в конце модуля. }

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3RegEx.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3_Base
;

type
 Pl3PatRecord = ^Tl3PatRecord;

 Tl3RegularSearch = class(Tl3_Base)
 end;//Tl3RegularSearch

 Tl3MatchPosition = record
  StartPos: Cardinal;
  EndPos: Cardinal;
  Length: Cardinal;
  LineNum: Cardinal;
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
  Token: Tl3Tokens;
  PossibleChars: TSetOfChar;
  NextOK: Boolean;
 end;//Tl3PatRecord

 Tl3NodeHeap = class
 end;//Tl3NodeHeap

function ConvertStrToRegular(const S: AnsiString): AnsiString;
function l3CheckStrByPattern(const aPattern: AnsiString;
 const aString: Tl3WString): Boolean;

implementation

uses
 l3ImplUses
;

function ConvertStrToRegular(const S: AnsiString): AnsiString;
//#UC START# *483D7F570199_483D7D8C001A_var*
//#UC END# *483D7F570199_483D7D8C001A_var*
begin
//#UC START# *483D7F570199_483D7D8C001A_impl*
 !!! Needs to be implemented !!!
//#UC END# *483D7F570199_483D7D8C001A_impl*
end;//ConvertStrToRegular

function l3CheckStrByPattern(const aPattern: AnsiString;
 const aString: Tl3WString): Boolean;
//#UC START# *49EEEAF70182_483D7D8C001A_var*
//#UC END# *49EEEAF70182_483D7D8C001A_var*
begin
//#UC START# *49EEEAF70182_483D7D8C001A_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EEEAF70182_483D7D8C001A_impl*
end;//l3CheckStrByPattern

end.
