unit l3RegEx;

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3_Base
;

type
 Tl3RegularSearch = class(Tl3_Base)
 end;//Tl3RegularSearch
 
 Tl3MatchPosition = record
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
 
 Tl3PatRecord = record
 end;//Tl3PatRecord
 
 Pl3PatRecord = ^Tl3PatRecord;
 
 Tl3NodeHeap = class
 end;//Tl3NodeHeap
 
implementation

uses
 l3ImplUses
;

end.
