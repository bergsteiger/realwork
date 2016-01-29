unit eeEditorExport;

interface

uses
 l3IntfUses
 , eeEditorExportModelPart
 , eeInterfacesEx
 , evInternalInterfaces
 , vtScrollBar
 , nevTools
 , Classes
 , ActiveX
 , l3Interfaces
 , eeInterfaces
 , Controls
 , l3Variant
 , nevBase
 , l3IID
 , evCustomTextSource
 , nevGUIInterfaces
 , afwInterfaces
 , Types
 , Windows
 , evExcept
 , l3InternalInterfaces
 , evdTypes
;

type
 TeeMouseActionEvent = function(aSender: TObject;
  const aHotSpot: IeeHotSpot;
  aButton: TeeMouseButton;
  anAction: TeeMouseAction;
  Keys: TeeShiftState;
  aWasSelection: Boolean): Boolean of object;
 
 TeeEditorExport = class(TeeEditorExportModelPart, IeeDocumentEx, IevF1LikeEditor)
  function DontBreakInAACMode: Boolean;
  procedure SaveTo(const aStream: IStream;
   aFormat: Tl3ClipboardFormat;
   aSaveSelection: Boolean);
  function InUserComment: Boolean;
  function CanInsertParaOnMove: Boolean;
   {* Можно ли вставлять параграфы при движении курсора }
  function IsInReadOnlyPara(const aPara: InevPara;
   Delete: Boolean): Boolean;
   {* Находимся ли в параграфе, в котором запрещено редактирование }
  function GetBlockByCursor(const aCursor: InevBasePoint): IevDocumentPart;
  procedure InsertUserComment;
  function GetNearestSubByCursor(const aCursor: InevBasePoint): IeeSub;
  function GetNearestBlockByCursor(const aCursor: InevBasePoint): IevDocumentPart;
  procedure RaiseUserCommentsHidden;
  function MB2eeMB(aButton: TMouseButton): TeeMouseButton;
  function DocumentPart: IevDocumentPart;
  function DocumentPartEx: IevDocumentPart;
  function Sub: IevSub;
  function SubEx: IevSub;
  function Selection: InevSelection;
  function EntryPoint: Tl3Tag;
  function Processor: InevProcessor;
  function NewSub: IevSub;
  function NewSubEx: IevSub;
  function AsIeeDocumentEx: IeeDocumentEx;
 end;//TeeEditorExport
 
implementation

uses
 l3ImplUses
 , eeExceptions
 , LeafPara_Const
 , ContentsElement_Const
 , CommentPara_Const
 , LeafParaDecorationsHolder_Const
 , Document_Const
 , Table_Const
 , Block_Const
 , k2Tags
 , evCursorTools
 , evParaTools
 , evMsgCode
 , eeSub
 , evOp
 , nevFacade
 , l3Base
 , afwFacade
 , eeTextSourceExport
 , StdCtrls
 , l3MinMax
 , l3Units
 , SysUtils
 , TtfwClassRef_Proxy
;

end.
