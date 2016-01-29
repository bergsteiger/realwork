unit dd_rtfFields;

interface

uses
 l3IntfUses
 , ddRTFdestination
 , ddRTFState
 , RTFtypes
 , l3Base
 , l3StringList
 , ddCustomRTFReader
 , destNorm
;

type
 TddValueType = (
  dd_vtEmpty
  , dd_vtAddData
  , dd_vtFull
  , dd_vtFormula
 );//TddValueType
 
 TddSkipText = (
  dd_stNone
  , dd_stCheckNextSymbol
  , dd_stSkip
 );//TddSkipText
 
 TdestFormFieldItem = class(TddRTFDestination)
  procedure Close(aState: TddRTFState;
   aNewDest: TddRTFDestination);
  procedure WriteText(aRDS: TRDS;
   aText: Tl3String;
   aState: TddRTFState);
 end;//TdestFormFieldItem
 
 TdestFormField = class(TddRTFDestination)
  procedure AddItem(const aItem: AnsiString);
  function GetFormResult: AnsiString;
  procedure Close(aState: TddRTFState;
   aNewDest: TddRTFDestination);
  procedure WriteText(aRDS: TRDS;
   aText: Tl3String;
   aState: TddRTFState);
 end;//TdestFormField
 
 TddCheckFontType = (
  dd_cfNone
  , dd_cfWaitName
  , dd_cfTry2Convert
  , dd_cfApply
 );//TddCheckFontType
 
 TdestFieldInstruction = class(TddRTFDestination)
  procedure Instruction2Result;
  function CheckFieldType(aText: Tl3String): Boolean;
  procedure Close(aState: TddRTFState;
   aNewDest: TddRTFDestination);
  procedure WriteText(aRDS: TRDS;
   aText: Tl3String;
   aState: TddRTFState);
 end;//TdestFieldInstruction
 
 TdestFieldResult = class(TdestNorm)
  procedure AppendData(aFieldDest: TddRTFDestination);
  function Valid: Boolean;
 end;//TdestFieldResult
 
 TdestField = class(TddRTFDestination)
  procedure Close(aState: TddRTFState;
   aNewDest: TddRTFDestination);
  procedure WriteText(aRDS: TRDS;
   aText: Tl3String;
   aState: TddRTFState);
 end;//TdestField
 
implementation

uses
 l3ImplUses
 , Math
 , StrUtils
 , SysUtils
 , l3Chars
 , l3Types
 , l3String
 , l3Const
 , l3Interfaces
 , ddTextParagraph
;

end.
