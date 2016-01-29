unit evMultiSelectionText;

interface

uses
 l3IntfUses
 , evMultiSelectionDataFormatting
 , nevTools
 , l3Variant
 , l3Interfaces
 , nevBase
;

type
 TevMultiSelectionText = class(TevMultiSelectionDataFormatting, InevTextModify, InevText)
  function CanBeDeleted: Boolean;
  function Modify: InevTextModify;
  function InsertString(const aView: InevView;
   const aString: Il3CString;
   const anOp: InevOp;
   InsertMode: Boolean;
   aFlags: TnevInsertStringFlags): Boolean;
   {* вставляет строку. }
  function InsertStream(const aView: InevView;
   const aStream: IStream;
   aFormat: TnevFormat;
   const anOp: InevOp;
   aFlags: TevLoadFlags;
   aCodePage: Integer): Boolean;
  function DeleteString(const aView: InevView;
   Count: Integer;
   const anOp: InevOp;
   aFlags: TnevInsertStringFlags): Boolean;
   {* удаляет строку. }
  function DeleteChar(const aView: InevView;
   aDrawLines: Boolean;
   const anOp: InevOp): Boolean;
  function InsertBreak(const aView: InevView;
   aDrawLines: Boolean;
   const anOp: InevOp): Boolean;
  function DeleteCharToLeft(const aView: InevView;
   aDrawLines: Boolean;
   const anOp: InevOp): Boolean;
  function Split(const aView: InevView;
   aFlags: TnevInsertStringFlags;
   const anOp: InevOp): Il3TagRef;
  function JoinWith(const aView: InevView;
   aSecondPara: Tl3Variant;
   const anOp: InevOp;
   MoveSubs: Boolean): Integer;
  function JoinWithNext(const aView: InevView;
   const anOp: InevOp): Boolean;
  function GetText: InevText;
 end;//TevMultiSelectionText
 
implementation

uses
 l3ImplUses
 , k2Base
;

end.
