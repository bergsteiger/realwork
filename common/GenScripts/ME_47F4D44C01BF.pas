unit evLocationBase;

interface

uses
 l3IntfUses
 , k2TagPointer
 , nevTools
 , l3Variant
 , nevBase
 , l3Core
 , l3Interfaces
;

type
 TevLocationBase = class(Tk2TagPointer, InevTextModify, InevLocation, InevDataFormatting, InevDataFormattingModify, IevDocumentPoint)
  {* Базовый объект для диапазонов в документе (курсоров и блоков) }
  function TagWriter: InevTagWriter;
  function DoJoinWith(const aView: InevView;
   aSecondPara: Tl3Variant;
   const anOp: InevOp;
   MoveSubs: Boolean): Integer;
  function DoSplit(const aView: InevView;
   aFlags: TnevInsertStringFlags;
   const anOp: InevOp): Il3TagRef;
  function DoJoinWithNext(const aView: InevView;
   const anOp: InevOp): Boolean;
  function GetRange: InevRange;
  function GetAsPoint: InevBasePoint;
  function GetCanBeDeleted: Boolean;
  function DoGetBlockLength: Integer;
  function DoDeleteCharToLeft(const aView: InevView;
   aDrawLines: Boolean;
   const anOp: InevOp): Boolean;
  function DoGetStyle(Stop: PInteger): Tl3Variant;
  function DoChangeParam(const aView: InevView;
   const aMarker: IevMarker;
   aValue: Integer;
   const anOp: InevOp): Boolean;
  function DoGetFont(const aView: InevView;
   aMap: TnevFormatInfoPrim;
   Stop: PInteger): InevFontPrim;
  function DoDeleteHyperlink(const anOpPack: InevOp): Boolean;
  function DoInsertBreak(const aView: InevView;
   aDrawLines: Boolean;
   const anOp: InevOp): Boolean;
  function DoAddIndentMarker(const aView: InevView;
   aValue: Integer;
   const anOpPack: InevOp): Boolean;
  function DoDeleteIndentMarker(const aView: InevView;
   const anOpPack: InevOp): Boolean;
  function DoInsertString(const aView: InevView;
   const aString: Il3CString;
   const anOp: InevOp;
   InsertMode: Boolean;
   aFlags: TnevInsertStringFlags): Boolean;
  function DoDeleteString(const aView: InevView;
   aCount: Integer;
   const anOp: InevOp;
   aFlags: TnevInsertStringFlags): Boolean;
  function DoSetAtom(const aView: InevView;
   anIndex: Cardinal;
   pSource: Tl3Variant;
   const anOp: InevOp): Boolean;
  function DoDeleteChar(const aView: InevView;
   aDrawLines: Boolean;
   const anOp: InevOp): Boolean;
  function GetInevDataFormattingModify(const aView: InevView): InevDataFormattingModify;
  function GetText: InevText;
  function DoInsertStream(const aView: InevView;
   const aStream: IStream;
   aFormat: TnevFormat;
   const anOp: InevOp;
   aFlags: TevLoadFlags;
   aCodePage: Integer): Boolean;
  function DoDeleteSegments(const anOpPack: InevOp): Boolean;
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
  function Range: InevRange;
  function Formatting: InevDataFormatting;
  function GetFont(const aView: InevView;
   aMap: TnevFormatInfoPrim;
   Stop: PInteger): InevFontPrim;
  function GetStyle(Stop: PInteger): Tl3Variant;
  function Modify(const aView: InevView): InevDataFormattingModify;
  function SetAtom(const aView: InevView;
   anIndex: Cardinal;
   aValue: Tl3Variant;
   const anOp: InevOp): Boolean;
  function ChangeParam(const aView: InevView;
   const aMarker: IevMarker;
   aValue: Integer;
   const anOp: InevOp): Boolean;
  function DeleteHyperlink(const anOp: InevOp): Boolean;
  function DeleteSegments(const anOp: InevOp): Boolean;
   {* удаляет сегменты. }
  function Select(const Selection: InevSelection): Boolean;
   {* перемещает Selection на данную метку. }
  function AddIndentMarker(const aView: InevView;
   aValue: Integer;
   const anOpPack: InevOp): Boolean;
  function DeleteIndentMarker(const aView: InevView;
   const anOpPack: InevOp): Boolean;
  function Obj: PInevObject;
  function Text: InevText;
  function AsPoint: InevBasePoint;
 end;//TevLocationBase
 
implementation

uses
 l3ImplUses
 , evExcept
 , SysUtils
 , nevPersistentDocumentContainer
;

end.
