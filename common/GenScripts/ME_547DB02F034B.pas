unit evSubPanel;

interface

uses
 l3IntfUses
 , evDef
 , l3Types
 , afwInterfaces
 , l3Units
 , nevTools
 , ImgList
 , l3ProtoPersistentWithHandle
 , evCustomFont
 , evTypes
 , Controls
 , Classes
 , l3InterfacedComponent
 , l3ProtoPersistentWithHandleRefList
 , l3ObjectList
 , l3ProtoObjectWithHandle
 , evSubPanelSub
 , evLinkedToolPanel
 , evInternalInterfaces
 , evVisualInterfaces
 , evSubPanelSubCollection
 , Messages
 , l3InternalInterfaces
 , l3Interfaces
 , evSubPanelSubArray
 , evdTypes
;

type
 TevSubDrawType = (
  {* Тип отображения метки }
  ev_sdtNumber
  , ev_sdtChar
  , ev_sdtCharNumber
  , ev_sdtBitmap
  , ev_sdtOwnerDraw
 );//TevSubDrawType
 
 TevClickSubEvent = procedure(Sender: TObject;
  SubType: Tl3Handle;
  SubHandle: Tl3Handle;
  aKind: TafwClickKind) of object;
 
 TevMouseOverSubEvent = function(Sender: TObject;
  const Pt: Tl3SPoint;
  const R: Tl3SRect;
  const aSub: IevSub;
  aLayer: Integer): Boolean of object;
 
 TevMenuSubEvent = procedure(Sender: TObject;
  const Pt: Tl3SPoint;
  const R: Tl3SRect;
  SubType: Tl3Handle;
  SubHandle: Tl3Handle) of object;
 
 TevGetSubBitmapIndexEvent = procedure(Sender: TObject;
  aSubType: Integer;
  aSubHandle: Integer;
  var Bitmap: TImageIndex;
  var Images: TCustomImageList) of object;
 
 TevDefineBlockImageIndex = procedure(Sender: TObject;
  const aSub: IevDocumentPart;
  var anIndex: TImageIndex) of object;
 
 TevSubDescriptors = class;
 
 TevSubDescriptorPrim = class(Tl3ProtoPersistentWithHandle)
  procedure CheckFont;
  procedure BuildColumns;
  function VisibleDef: Boolean;
  procedure Create(anOwner: TevSubDescriptors);
  function FontStored: Boolean;
   {* "Функция определяющая, что свойство Font сохраняется" }
  function VisibleStored: Boolean;
   {* "Функция определяющая, что свойство Visible сохраняется" }
  function CursorStored: Boolean;
   {* "Функция определяющая, что свойство Cursor сохраняется" }
  function Handle: Tl3Handle;
  function CompareWith(anOther: Tl3ProtoPersistentWithHandle): Integer;
 end;//TevSubDescriptorPrim
 
 TevSubDescriptor = class(TevSubDescriptorPrim)
  {* Описание свойств отображения метки }
 end;//TevSubDescriptor
 
 TevSubLayerDescriptor = class;
 
 TevCustomSubDescriptors = class(Tl3InterfacedComponent)
  {* Набор описаний свойств отображения слоев меток }
  procedure PlaceControl(aControl: TControl);
  procedure PlaceControls;
  procedure BuildColumns;
  procedure LinkControl(aControl: TControl);
  procedure UnlinkControl(aControl: TControl);
  function DefineBitmapIndex(const aSub: IevDocumentPart;
   out aBitmapIndex: TImageIndex): Boolean;
 end;//TevCustomSubDescriptors
 
 TevSubDescriptors = class(TevCustomSubDescriptors)
  {* Набор описаний свойств отображения слоев меток }
 end;//TevSubDescriptors
 
 PevSubPanelSub = ^TevSubPanelSub;
 
 TevSubLayerDescriptor = class(TevSubDescriptor)
  {* Описание свойств отображения слоя меток }
 end;//TevSubLayerDescriptor
 
 TevCustomSubPanel = class(TevCustomLinkedToolPanel, IevSubCache, IevSubFlagsSpy, IevZoomedLinkedToolWindow, IevSubPanel)
  {* Панель меток }
  procedure DoOnClickSub(SubType: Tl3Handle;
   SubHandle: Tl3Handle;
   aKind: TafwClickKind);
  procedure DoOnMenuSub(const Pt: Tl3SPoint;
   const R: Tl3SRect;
   SubType: Tl3Handle;
   SubHandle: Tl3Handle);
  function DoOnMouseOverSub(const Pt: Tl3SPoint;
   const R: Tl3SRect;
   const aSub: IevSub;
   aLayer: Integer): Boolean;
  procedure DrawSub(const aCanvas: Il3Canvas;
   aSubDescr: TevSubDescriptor;
   aSub: TevSubPanelSub;
   aRealPaint: Boolean);
  procedure MakeSubRect(var R: Tl3Rect);
  procedure DrawSubs(const Canvas: Il3Canvas);
  function ScrollSub(SPS: TevSubPanelSub;
   const P: Tl3Point): Boolean;
  procedure AddSub(const CN: Il3Canvas;
   const aR: Tl3Rect;
   aSubType: Tl3Handle;
   const aSub: IevSub);
  function DeleteSubPrim(aSubType: Tl3Handle;
   aSubHandle: Tl3Handle): Boolean;
  function SubOnPoint(const Pt: Tl3SPoint;
   out st: Tl3Handle): TevSubPanelSub;
  function CheckSubOnPoint(aX: Integer;
   aY: Integer;
   out theSub: IevSub;
   out theFlag: Integer): Boolean; overload;
  function CheckSubOnPoint(aX: Integer;
   aY: Integer;
   out theSub: IevSub): Boolean; overload;
  procedure DeleteSub(aSubType: Tl3Handle;
   aSubHandle: Tl3Handle);
  function GetSubPanelSubCollection: TevSubPanelSubCollection;
  procedure WMLButtonDblClk(var Msg: TWMLButtonDblClk);
  procedure WMLButtonUp(var Msg: TWMLButtonUp);
  procedure WMRButtonDown(var Msg: TWMRButtonDown);
  procedure WMNCHitTest(var Msg: TWMNCHitTest);
  procedure WMSetCursor(var Msg: TWMSetCursor);
  function SubDescriptorsStored: Boolean;
   {* "Функция определяющая, что свойство SubDescriptors сохраняется" }
  procedure ClearSubs;
  procedure NotifySubDeleted(const aSub: IevSub);
  procedure NotifyFlagsChange(const aSub: IevSub);
   {* флаги метки изменились }
  function Zoom: SmallInt;
  procedure NeedDrawSub(const aR: Tl3Rect;
   const aSub: IevSub);
 end;//TevCustomSubPanel
 
 PevSubPanelSubArray = ^TevSubPanelSubArray;
 
 TevSubPlace = evdTypes.TevSubPlace;
 
 TevSubPanel = class(TevCustomSubPanel)
  {* Панели меток }
 end;//TevSubPanel
 
implementation

uses
 l3ImplUses
 , evFont
 , l3Base
 , l3MinMax
 , l3ObjectWithHandleRefListPrim
 , nevFacade
 , l3String
 , SysUtils
 , Forms
 , l3Bits
 , evConst
 , evSubPn
 , TtfwClassRef_Proxy
 , SubPanelWordsPack
 , evSubPanelTools
 , Windows
;

type
 TevSubData = class(Tl3ProtoObjectWithHandle)
  function CompareWith(anOther: Tl3ProtoObjectWithHandle): Integer;
 end;//TevSubData
 
end.
