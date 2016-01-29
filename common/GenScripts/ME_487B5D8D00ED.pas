unit evBlockCursor;

interface

uses
 l3IntfUses
 , evWindowCursor
 , nevTools
 , l3Variant
 , nevBase
 , l3Interfaces
 , l3IID
;

type
 TevBlockCursor = class(TevWindowCursor, InevTextModify, InevText, IevRange)
  {* Курсор с выделением. }
  procedure UpdateBlock;
  procedure AfterProcessCommand;
  function SetAtom(anIndex: Cardinal;
   pSource: Tl3Variant;
   const anOpPack: InevOp): Boolean;
  function ProcessCommand(aMsg: Integer;
   aCode: Cardinal;
   const anOp: InevOp;
   aCount: Integer): Boolean;
  function DeleteHyperlink(const anOpPack: InevOp): Boolean;
  function ChangeParam(const aMarker: IevMarker;
   aValue: Integer;
   const anOpPack: InevOp): Boolean;
  function SaveBlock(const aCheckCursor: InevBasePoint): InevLocation;
   {* получить копию текущего объекта выделения }
  function AddIndentMarker(aValue: Integer;
   const anOpPack: InevOp): Boolean;
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
  procedure AssignSel(const aView: InevView;
   const aSource: InevRange);
   {* присваивает одно выделение другому }
  function GetBlock: InevRange;
   {* получить текущий объект выделения }
  procedure SetToStart;
   {* установить выделение в начало }
  function Unselect(const aView: InevView): Boolean;
   {* снять выделение }
  procedure SetToFinish(aMoveUpInLines: Integer);
 end;//TevBlockCursor
 
implementation

uses
 l3ImplUses
 , k2Base
 , l3InterfacesMisc
 , SysUtils
 , evEditorInterfaces
 , evExcept
 , evRange
 , k2TagGen
 , l3Base
 , evDocumentPartGenerator
 , evMsgCode
 , nevNavigation
 , k2Tags
 , evOp
;

end.
