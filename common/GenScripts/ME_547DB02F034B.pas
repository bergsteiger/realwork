unit evSubPanel;
 {* Панели меток }

// Модуль: "w:\common\components\gui\Garant\Everest\evSubPanel.pas"
// Стереотип: "GuiControl"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evDef
 , l3Types
 , afwInterfaces
 , l3Units
 , nevTools
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , l3ProtoPersistentWithHandle
 , evCustomFont
 , evTypes
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Classes
 , l3InterfacedComponent
 , l3ProtoPersistentWithHandleRefList
 , l3ObjectList
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

const
 DefColumn = Pred(High(Integer));
 DefSubPanelWidth = 5;
 def_Zoom = evDef.def_Zoom;

type
 PevSubPanelSub = ^TevSubPanelSub;

 PevSubPanelSubArray = ^TevSubPanelSubArray;

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
  private
   f_Handle: Tl3Handle;
   f_Descriptors: TevSubDescriptors;
   f_BitmapIndex: TImageIndex;
    {* Поле для свойства BitmapIndex }
   f_BlockBitmapIndex: TImageIndex;
    {* Поле для свойства BlockBitmapIndex }
   f_DocumentBitmapIndex: TImageIndex;
    {* Поле для свойства DocumentBitmapIndex }
   f_Font: TevCustomFont;
    {* Поле для свойства Font }
   f_DrawType: TevSubDrawType;
    {* Поле для свойства DrawType }
   f_NumberOffset: Byte;
    {* Поле для свойства NumberOffset }
   f_Visible: Boolean;
    {* Поле для свойства Visible }
   f_Offset: TevPixel;
    {* Поле для свойства Offset }
   f_Column: Integer;
    {* Поле для свойства Column }
   f_Cursor: TCursor;
    {* Поле для свойства Cursor }
   f_OnGetBitmapIndex: TevGetSubBitmapIndexEvent;
    {* Поле для свойства OnGetBitmapIndex }
   f_Images: TCustomImageList;
    {* Поле для свойства Images }
  protected
   function pm_GetFont: TevCustomFont;
   procedure pm_SetFont(aValue: TevCustomFont);
   procedure pm_SetVisible(aValue: Boolean);
   function pm_GetDescriptors: TevSubDescriptors;
   procedure CheckFont;
   procedure BuildColumns;
   function VisibleDef: Boolean; virtual;
   function FontStored: Boolean;
    {* "Функция определяющая, что свойство Font сохраняется" }
   function VisibleStored: Boolean;
    {* "Функция определяющая, что свойство Visible сохраняется" }
   function CursorStored: Boolean;
    {* "Функция определяющая, что свойство Cursor сохраняется" }
   function pm_GetHandle: Tl3Handle; override;
   procedure pm_SetHandle(aValue: Tl3Handle); override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetOwner: TPersistent; override;
  public
   constructor Create(anOwner: TevSubDescriptors); reintroduce;
   function CompareWith(anOther: Tl3ProtoPersistentWithHandle): Integer; override;
   procedure Assign(Source: TPersistent); override;
  protected
   property Descriptors: TevSubDescriptors
    read pm_GetDescriptors;
  public
   property BitmapIndex: TImageIndex
    read f_BitmapIndex
    write f_BitmapIndex;
    {* индекс иконки для отображения обычной метки }
   property BlockBitmapIndex: TImageIndex
    read f_BlockBitmapIndex
    write f_BlockBitmapIndex;
    {* индекс иконки для отображения метки блока }
   property DocumentBitmapIndex: TImageIndex
    read f_DocumentBitmapIndex
    write f_DocumentBitmapIndex;
    {* индекс иконки для отображения метки документа }
   property Font: TevCustomFont
    read pm_GetFont
    write pm_SetFont
    stored FontStored;
    {* шрифт для отображения метки }
   property DrawType: TevSubDrawType
    read f_DrawType
    write f_DrawType;
    {* тип отображения метки }
   property NumberOffset: Byte
    read f_NumberOffset
    write f_NumberOffset;
   property Visible: Boolean
    read f_Visible
    write pm_SetVisible
    stored VisibleStored;
   property Offset: TevPixel
    read f_Offset
    write f_Offset;
   property Column: Integer
    read f_Column
    write f_Column;
   property Cursor: TCursor
    read f_Cursor
    write f_Cursor
    stored CursorStored;
   property OnGetBitmapIndex: TevGetSubBitmapIndexEvent
    read f_OnGetBitmapIndex
    write f_OnGetBitmapIndex;
   property Images: TCustomImageList
    read f_Images
    write f_Images;
 end;//TevSubDescriptorPrim

 //#UC START# *547DB364031Fci*
 //#UC END# *547DB364031Fci*
 //#UC START# *547DB364031Fcit*
 //#UC END# *547DB364031Fcit*
 TevSubDescriptor = class(TevSubDescriptorPrim)
  {* Описание свойств отображения метки }
 //#UC START# *547DB364031Fpubl*
  published
 // published properties
   property Images;
   property BitmapIndex default -1;
   property BlockBitmapIndex default -1;
   property DocumentBitmapIndex default -1;
   property Font;
   property DrawType default ev_sdtNumber;
   property NumberOffset default 0;
   property Visible;
   property Offset;
   property Column default DefColumn;
   property Cursor;
   property Descriptors;
  published
   property OnGetBitmapIndex;
 //#UC END# *547DB364031Fpubl*
 end;//TevSubDescriptor

 TevSubLayerDescriptor = class;

 TevCustomSubDescriptors = class(Tl3InterfacedComponent)
  {* Набор описаний свойств отображения слоев меток }
  private
   f_SubDescriptors: Tl3ProtoPersistentWithHandleRefList;
   f_Width: Integer;
   f_InBuild: Boolean;
   f_Controls: Tl3ObjectList;
   f_Images: TCustomImageList;
    {* Поле для свойства Images }
   f_Cursor: TCursor;
    {* Поле для свойства Cursor }
   f_OnDefineBlockIndex: TevDefineBlockImageIndex;
    {* Поле для свойства OnDefineBlockIndex }
  protected
   procedure pm_SetImages(aValue: TCustomImageList);
   function pm_GetSubDescriptor(Index: Integer): TevSubDescriptor;
   procedure pm_SetSubDescriptor(Index: Integer;
    aValue: TevSubDescriptor);
   function pm_GetSubLayerDescriptor(Index: Integer): TevSubLayerDescriptor; virtual;
   procedure pm_SetSubLayerDescriptor(Index: Integer;
    aValue: TevSubLayerDescriptor); virtual;
   procedure PlaceControl(aControl: TControl);
   procedure PlaceControls;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure Loaded; override;
  public
   procedure BuildColumns;
   procedure LinkControl(aControl: TControl);
   procedure UnlinkControl(aControl: TControl);
   function DefineBitmapIndex(const aSub: IevDocumentPart;
    out aBitmapIndex: TImageIndex): Boolean;
  protected
   property SubDescriptor[Index: Integer]: TevSubDescriptor
    read pm_GetSubDescriptor
    write pm_SetSubDescriptor;
    default;
   property SubLayerDescriptor[Index: Integer]: TevSubLayerDescriptor
    read pm_GetSubLayerDescriptor
    write pm_SetSubLayerDescriptor;
  public
   property Images: TCustomImageList
    read f_Images
    write pm_SetImages;
   property Cursor: TCursor
    read f_Cursor
    write f_Cursor;
   property OnDefineBlockIndex: TevDefineBlockImageIndex
    read f_OnDefineBlockIndex
    write f_OnDefineBlockIndex;
 end;//TevCustomSubDescriptors

 //#UC START# *547DB8BC03D3ci*
 //#UC END# *547DB8BC03D3ci*
 //#UC START# *547DB8BC03D3cit*
 //#UC END# *547DB8BC03D3cit*
 TevSubDescriptors = class(TevCustomSubDescriptors)
  {* Набор описаний свойств отображения слоев меток }
 //#UC START# *547DB8BC03D3publ*
  published
   property SubsLayer: TevSubLayerDescriptor
     index ev_sbtSub
     read pm_GetSubLayerDescriptor
     write pm_SetSubLayerDescriptor;
     {* - свойства отображения слоя меток. }
   property MarkersLayer: TevSubLayerDescriptor
     index ev_sbtMarker
     read pm_GetSubLayerDescriptor
     write pm_SetSubLayerDescriptor;
     {* - свойства отображения слоя маркеров. }
   property BookmarksLayer: TevSubLayerDescriptor
     index ev_sbtBookmark
     read pm_GetSubLayerDescriptor
     write pm_SetSubLayerDescriptor;
     {* - свойства отображения слоя маркеров. }
   property MarksLayer: TevSubLayerDescriptor
     index ev_sbtMark
     read pm_GetSubLayerDescriptor
     write pm_SetSubLayerDescriptor;
     {* - свойства отображения слоя вспомогательных значков. }
   property Images;
   property Cursor;
 //#UC END# *547DB8BC03D3publ*
 end;//TevSubDescriptors

 //#UC START# *547DBA30028Eci*
 //#UC END# *547DBA30028Eci*
 //#UC START# *547DBA30028Ecit*
 //#UC END# *547DBA30028Ecit*
 TevSubLayerDescriptor = class(TevSubDescriptor)
  {* Описание свойств отображения слоя меток }
  protected
   function pm_GetFlags(Index: Integer): TevSubDescriptor;
   procedure pm_SetFlags(Index: Integer;
    aValue: TevSubDescriptor);
   function VisibleDef: Boolean; override;
  public
   property Flags[Index: Integer]: TevSubDescriptor
    read pm_GetFlags
    write pm_SetFlags;
 //#UC START# *547DBA30028Epubl*
  published
   property Flag0: TevSubDescriptor
    index 0
    read pm_GetFlags
    write pm_SetFlags;
   property Flag1: TevSubDescriptor
    index 1
    read pm_GetFlags
    write pm_SetFlags;
   property Flag2: TevSubDescriptor
    index 2
    read pm_GetFlags
    write pm_SetFlags;
   property Flag3: TevSubDescriptor
    index 3
    read pm_GetFlags
    write pm_SetFlags;
   property Flag4: TevSubDescriptor
    index 4
    read pm_GetFlags
    write pm_SetFlags;
   property Flag5: TevSubDescriptor
    index 5
    read pm_GetFlags
    write pm_SetFlags;
   property Flag6: TevSubDescriptor
    index 6
    read pm_GetFlags
    write pm_SetFlags;
   property Flag7: TevSubDescriptor
    index 7
    read pm_GetFlags
    write pm_SetFlags;
 //#UC END# *547DBA30028Epubl*
 end;//TevSubLayerDescriptor

 TevCustomSubPanel = class(TevCustomLinkedToolPanel, IevSubCache, IevSubFlagsSpy, IevZoomedLinkedToolWindow, IevSubPanel)
  {* Панель меток }
  private
   f_HintSub: TevSubPanelSub;
   f_Subs: TevSubPanelSubCollection;
   f_Zoom: SmallInt;
    {* Поле для свойства Zoom }
   f_OnClickSub: TevClickSubEvent;
    {* Поле для свойства OnClickSub }
   f_OnMenuSub: TevMenuSubEvent;
    {* Поле для свойства OnMenuSub }
   f_OnMouseOverSub: TevMouseOverSubEvent;
    {* Поле для свойства OnMouseOverSub }
   f_SubDescriptors: TevSubDescriptors;
    {* Поле для свойства SubDescriptors }
  private
   procedure WMLButtonDblClk(var Msg: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
   procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
   procedure WMRButtonDown(var Msg: TWMRButtonDown); message WM_RBUTTONDOWN;
   procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
   procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
  protected
   function pm_GetSubDescriptors: TevSubDescriptors;
   procedure pm_SetSubDescriptors(aValue: TevSubDescriptors);
   procedure DoOnClickSub(SubType: Tl3Handle;
    SubHandle: Tl3Handle;
    aKind: TafwClickKind); virtual;
   procedure DoOnMenuSub(const Pt: Tl3SPoint;
    const R: Tl3SRect;
    SubType: Tl3Handle;
    SubHandle: Tl3Handle); virtual;
   function DoOnMouseOverSub(const Pt: Tl3SPoint;
    const R: Tl3SRect;
    const aSub: IevSub;
    aLayer: Integer): Boolean; virtual;
   procedure DrawSub(const aCanvas: Il3Canvas;
    aSubDescr: TevSubDescriptor;
    aSub: TevSubPanelSub;
    aRealPaint: Boolean);
   procedure MakeSubRect(var R: Tl3Rect);
   procedure DrawSubs(const Canvas: Il3Canvas);
   function ScrollSub(SPS: TevSubPanelSub;
    const P: Tl3Point): Boolean; virtual;
   procedure AddSub(const CN: Il3Canvas;
    const aR: Tl3Rect;
    aSubType: Tl3Handle;
    const aSub: IevSub);
   function DeleteSubPrim(aSubType: Tl3Handle;
    aSubHandle: Tl3Handle): Boolean;
   function SubDescriptorsStored: Boolean;
    {* "Функция определяющая, что свойство SubDescriptors сохраняется" }
   procedure ClearSubs;
   procedure NotifySubDeleted(const aSub: IevSub);
   procedure NotifyFlagsChange(const aSub: IevSub);
    {* флаги метки изменились }
   function pm_GetZoom: SmallInt;
   procedure pm_SetZoom(aValue: SmallInt);
   procedure NeedDrawSub(const aR: Tl3Rect;
    const aSub: IevSub);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure Paint(const CN: Il3Canvas); override;
    {* процедура рисования внешнего вида управляющего элемента }
   procedure OrientationChanged; override;
  public
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
   {$If NOT Defined(NoScripts)}
   function GetSubPanelSubCollection: TevSubPanelSubCollection;
   {$IfEnd} // NOT Defined(NoScripts)
   constructor Create(AOwner: TComponent); override;
   procedure DoScroll(iD: Tl3Inch); override;
  public
   property Zoom: SmallInt
    read pm_GetZoom
    write pm_SetZoom;
   property OnClickSub: TevClickSubEvent
    read f_OnClickSub
    write f_OnClickSub;
   property OnMenuSub: TevMenuSubEvent
    read f_OnMenuSub
    write f_OnMenuSub;
   property OnMouseOverSub: TevMouseOverSubEvent
    read f_OnMouseOverSub
    write f_OnMouseOverSub;
   property SubDescriptors: TevSubDescriptors
    read pm_GetSubDescriptors
    write pm_SetSubDescriptors
    stored SubDescriptorsStored;
 end;//TevCustomSubPanel

 TevSubPlace = evdTypes.TevSubPlace;

 //#UC START# *547DB02F034Bci*
 //#UC END# *547DB02F034Bci*
 //#UC START# *547DB02F034Bcit*
 //#UC END# *547DB02F034Bcit*
 TevSubPanel = {final} class(TevCustomSubPanel)
  {* Панели меток }
 //#UC START# *547DB02F034Bpubl*
  published
   property Align;
   property Alignment;
   property BevelInner;
   property BevelOuter;
   property BevelWidth;
   property BorderWidth;
   property BorderStyle;
   property DragCursor;
   property DragMode;
   property Enabled;
   property Caption;
   property Color;
   property Ctl3D;
   property Font;
   property ParentColor;
   property ParentCtl3D;
   property ParentFont;
   property ParentShowHint;
   property PopupMenu;
   property ShowHint;
   property TabOrder;
   property TabStop;
   property Visible;
   property Width default DefSubPanelWidth;
   property OnClick;
   property OnDblClick;
   property OnDragDrop;
   property OnDragOver;
   property OnEndDrag;
   property OnEnter;
   property OnExit;
   property OnMouseDown;
   property OnMouseMove;
   property OnMouseUp;
   property OnResize;
  published
  // published properties
   property SubDescriptors;
   property Orientation default ev_orVertical;
   property OnClickSub;
   property OnMenuSub;
   property OnMouseOverSub;
 //#UC END# *547DB02F034Bpubl*
 end;//TevSubPanel

implementation

uses
 l3ImplUses
 , l3ProtoObjectWithHandle
 , evFont
 , l3Base
 , l3MinMax
 , l3ObjectWithHandleRefListPrim
 , nevFacade
 , l3String
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Bits
 , evConst
 , evSubPn
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , SubPanelWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , evSubPanelTools
 , Windows
;

type
 TevSubData = class(Tl3ProtoObjectWithHandle)
  private
   f_S: TevSubDescriptor;
   f_C: Integer;
  public
   function CompareWith(anOther: Tl3ProtoObjectWithHandle): Integer; override;
 end;//TevSubData

function TevSubDescriptorPrim.pm_GetFont: TevCustomFont;
//#UC START# *547DB5FE0149_547DB3E001A5get_var*
//#UC END# *547DB5FE0149_547DB3E001A5get_var*
begin
//#UC START# *547DB5FE0149_547DB3E001A5get_impl*
 CheckFont;
 Result := f_Font;
//#UC END# *547DB5FE0149_547DB3E001A5get_impl*
end;//TevSubDescriptorPrim.pm_GetFont

procedure TevSubDescriptorPrim.pm_SetFont(aValue: TevCustomFont);
//#UC START# *547DB5FE0149_547DB3E001A5set_var*
//#UC END# *547DB5FE0149_547DB3E001A5set_var*
begin
//#UC START# *547DB5FE0149_547DB3E001A5set_impl*
 if (f_Font <> aValue) then
 begin
  if (aValue = nil) then
   l3Free(f_Font)
  else
   Font.Assign(aValue);
 end;//f_Font <> aValue
//#UC END# *547DB5FE0149_547DB3E001A5set_impl*
end;//TevSubDescriptorPrim.pm_SetFont

procedure TevSubDescriptorPrim.pm_SetVisible(aValue: Boolean);
//#UC START# *547DB6950360_547DB3E001A5set_var*
//#UC END# *547DB6950360_547DB3E001A5set_var*
begin
//#UC START# *547DB6950360_547DB3E001A5set_impl*
 if (f_Visible <> aValue) then
 begin
  f_Visible := aValue;
  BuildColumns;
 end;//f_Visible <> aValue
//#UC END# *547DB6950360_547DB3E001A5set_impl*
end;//TevSubDescriptorPrim.pm_SetVisible

function TevSubDescriptorPrim.pm_GetDescriptors: TevSubDescriptors;
//#UC START# *54806C560320_547DB3E001A5get_var*
//#UC END# *54806C560320_547DB3E001A5get_var*
begin
//#UC START# *54806C560320_547DB3E001A5get_impl*
 Result := f_Descriptors;
//#UC END# *54806C560320_547DB3E001A5get_impl*
end;//TevSubDescriptorPrim.pm_GetDescriptors

procedure TevSubDescriptorPrim.CheckFont;
//#UC START# *547DB95F0282_547DB3E001A5_var*
//#UC END# *547DB95F0282_547DB3E001A5_var*
begin
//#UC START# *547DB95F0282_547DB3E001A5_impl*
 if (f_Font = nil) then
  f_Font := TevFont.Create;
//#UC END# *547DB95F0282_547DB3E001A5_impl*
end;//TevSubDescriptorPrim.CheckFont

procedure TevSubDescriptorPrim.BuildColumns;
//#UC START# *547DB98F012C_547DB3E001A5_var*
//#UC END# *547DB98F012C_547DB3E001A5_var*
begin
//#UC START# *547DB98F012C_547DB3E001A5_impl*
 if (f_Descriptors <> nil) then
  f_Descriptors.BuildColumns;
//#UC END# *547DB98F012C_547DB3E001A5_impl*
end;//TevSubDescriptorPrim.BuildColumns

function TevSubDescriptorPrim.VisibleDef: Boolean;
//#UC START# *547DB9B10138_547DB3E001A5_var*
//#UC END# *547DB9B10138_547DB3E001A5_var*
begin
//#UC START# *547DB9B10138_547DB3E001A5_impl*
 Result := False; 
//#UC END# *547DB9B10138_547DB3E001A5_impl*
end;//TevSubDescriptorPrim.VisibleDef

constructor TevSubDescriptorPrim.Create(anOwner: TevSubDescriptors);
//#UC START# *547DB9EC002E_547DB3E001A5_var*
//#UC END# *547DB9EC002E_547DB3E001A5_var*
begin
//#UC START# *547DB9EC002E_547DB3E001A5_impl*
 inherited Create;
 f_Descriptors := anOwner;
 CheckFont;
 f_BitmapIndex := -1;
 f_BlockBitmapIndex := -1;
 f_DocumentBitmapIndex := -1;
 f_Visible := VisibleDef;
 f_Column := DefColumn;
//#UC END# *547DB9EC002E_547DB3E001A5_impl*
end;//TevSubDescriptorPrim.Create

function TevSubDescriptorPrim.FontStored: Boolean;
 {* "Функция определяющая, что свойство Font сохраняется" }
//#UC START# *B2038F885A9E_547DB3E001A5_var*
//#UC END# *B2038F885A9E_547DB3E001A5_var*
begin
//#UC START# *B2038F885A9E_547DB3E001A5_impl*
 Result := (DrawType <> ev_sdtBitmap);
//#UC END# *B2038F885A9E_547DB3E001A5_impl*
end;//TevSubDescriptorPrim.FontStored

function TevSubDescriptorPrim.VisibleStored: Boolean;
 {* "Функция определяющая, что свойство Visible сохраняется" }
//#UC START# *64C973B9A48B_547DB3E001A5_var*
//#UC END# *64C973B9A48B_547DB3E001A5_var*
begin
//#UC START# *64C973B9A48B_547DB3E001A5_impl*
 Result := (f_Visible <> VisibleDef);
//#UC END# *64C973B9A48B_547DB3E001A5_impl*
end;//TevSubDescriptorPrim.VisibleStored

function TevSubDescriptorPrim.CursorStored: Boolean;
 {* "Функция определяющая, что свойство Cursor сохраняется" }
//#UC START# *D35547FF8400_547DB3E001A5_var*
//#UC END# *D35547FF8400_547DB3E001A5_var*
begin
//#UC START# *D35547FF8400_547DB3E001A5_impl*
 Result := (f_Cursor <> crDefault) and
           ((f_Descriptors = nil) or (f_Descriptors.Cursor <> f_Cursor));
//#UC END# *D35547FF8400_547DB3E001A5_impl*
end;//TevSubDescriptorPrim.CursorStored

function TevSubDescriptorPrim.pm_GetHandle: Tl3Handle;
//#UC START# *52FCC6CE00E2_547DB3E001A5get_var*
//#UC END# *52FCC6CE00E2_547DB3E001A5get_var*
begin
//#UC START# *52FCC6CE00E2_547DB3E001A5get_impl*
 Result := f_Handle;
//#UC END# *52FCC6CE00E2_547DB3E001A5get_impl*
end;//TevSubDescriptorPrim.pm_GetHandle

procedure TevSubDescriptorPrim.pm_SetHandle(aValue: Tl3Handle);
//#UC START# *52FCC6CE00E2_547DB3E001A5set_var*
//#UC END# *52FCC6CE00E2_547DB3E001A5set_var*
begin
//#UC START# *52FCC6CE00E2_547DB3E001A5set_impl*
 f_Handle := aValue;
//#UC END# *52FCC6CE00E2_547DB3E001A5set_impl*
end;//TevSubDescriptorPrim.pm_SetHandle

function TevSubDescriptorPrim.CompareWith(anOther: Tl3ProtoPersistentWithHandle): Integer;
//#UC START# *52FCC73E00CC_547DB3E001A5_var*
//#UC END# *52FCC73E00CC_547DB3E001A5_var*
begin
//#UC START# *52FCC73E00CC_547DB3E001A5_impl*
 if (anOther is TevSubDescriptor) then
  Result := Handle - TevSubDescriptor(anOther).Handle
 else
 begin
  Result := -1;
  Assert(False);
 end;//anObject is TevSubDescriptor
//#UC END# *52FCC73E00CC_547DB3E001A5_impl*
end;//TevSubDescriptorPrim.CompareWith

procedure TevSubDescriptorPrim.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_547DB3E001A5_var*
var
 SD: TevSubDescriptor absolute Source;
//#UC END# *478CF34E02CE_547DB3E001A5_var*
begin
//#UC START# *478CF34E02CE_547DB3E001A5_impl*
 if (Source is TevSubDescriptor) then
 begin
  BitmapIndex := SD.BitmapIndex;
  BlockBitmapIndex := SD.BlockBitmapIndex;
  Font := SD.Font;
  DrawType := SD.DrawType;
  NumberOffset := SD.NumberOffset;
  f_Visible := SD.Visible;
  Offset := SD.Offset;
  BuildColumns;
 end;//P is TevSubDescriptor
//#UC END# *478CF34E02CE_547DB3E001A5_impl*
end;//TevSubDescriptorPrim.Assign

procedure TevSubDescriptorPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_547DB3E001A5_var*
//#UC END# *479731C50290_547DB3E001A5_var*
begin
//#UC START# *479731C50290_547DB3E001A5_impl*
 l3Free(f_Font);
 inherited;
//#UC END# *479731C50290_547DB3E001A5_impl*
end;//TevSubDescriptorPrim.Cleanup

function TevSubDescriptorPrim.GetOwner: TPersistent;
//#UC START# *480DD1890221_547DB3E001A5_var*
//#UC END# *480DD1890221_547DB3E001A5_var*
begin
//#UC START# *480DD1890221_547DB3E001A5_impl*
 Result := f_Descriptors;
//#UC END# *480DD1890221_547DB3E001A5_impl*
end;//TevSubDescriptorPrim.GetOwner

//#UC START# *547DB364031Fimpl*
//#UC END# *547DB364031Fimpl*

function TevSubData.CompareWith(anOther: Tl3ProtoObjectWithHandle): Integer;
//#UC START# *52FCC10F0202_548045A700CD_var*
//#UC END# *52FCC10F0202_548045A700CD_var*
begin
//#UC START# *52FCC10F0202_548045A700CD_impl*
 if (anOther is TevSubData) then
  Result := (f_C - TevSubData(anOther).f_C)
 else
 begin
  Result := -1;
  Assert(False);
 end;
//#UC END# *52FCC10F0202_548045A700CD_impl*
end;//TevSubData.CompareWith

procedure TevCustomSubDescriptors.pm_SetImages(aValue: TCustomImageList);
//#UC START# *547DC10C03D0_547DC15100BCset_var*
//#UC END# *547DC10C03D0_547DC15100BCset_var*
begin
//#UC START# *547DC10C03D0_547DC15100BCset_impl*
 if (f_Images <> aValue) then
  f_Images := aValue;
//#UC END# *547DC10C03D0_547DC15100BCset_impl*
end;//TevCustomSubDescriptors.pm_SetImages

function TevCustomSubDescriptors.pm_GetSubDescriptor(Index: Integer): TevSubDescriptor;
//#UC START# *547DC1FA0083_547DC15100BCget_var*
var
 I: Integer;
 SD: TevSubDescriptor;
//#UC END# *547DC1FA0083_547DC15100BCget_var*
begin
//#UC START# *547DC1FA0083_547DC15100BCget_impl*
 Result := nil;
 if (f_SubDescriptors <> nil) and f_SubDescriptors.FindData(Index, I) then
   Result := TevSubDescriptor(f_SubDescriptors.Items[I]);
  if (Result = nil) then
  begin
   if (f_SubDescriptors = nil) then
    f_SubDescriptors := Tl3ProtoPersistentWithHandleRefList.MakeSorted;
   if (Index > 0) then
    SD := TevSubLayerDescriptor.Create(Self as TevSubDescriptors)
   else
    SD := TevSubDescriptor.Create(Self as TevSubDescriptors);
   try
    SD.Handle := Index;
    f_SubDescriptors.Add(SD);
   finally
    Result := SD.Free;
   end;//try..finally
  end; // if (Result = nil) then
//#UC END# *547DC1FA0083_547DC15100BCget_impl*
end;//TevCustomSubDescriptors.pm_GetSubDescriptor

procedure TevCustomSubDescriptors.pm_SetSubDescriptor(Index: Integer;
 aValue: TevSubDescriptor);
//#UC START# *547DC1FA0083_547DC15100BCset_var*
//#UC END# *547DC1FA0083_547DC15100BCset_var*
begin
//#UC START# *547DC1FA0083_547DC15100BCset_impl*
 if (aValue <> nil) then
  SubDescriptor[Index].Assign(aValue);
//#UC END# *547DC1FA0083_547DC15100BCset_impl*
end;//TevCustomSubDescriptors.pm_SetSubDescriptor

function TevCustomSubDescriptors.pm_GetSubLayerDescriptor(Index: Integer): TevSubLayerDescriptor;
//#UC START# *547DC309039E_547DC15100BCget_var*
//#UC END# *547DC309039E_547DC15100BCget_var*
begin
//#UC START# *547DC309039E_547DC15100BCget_impl*
 if (Index > 0) then
  Result := TevSubLayerDescriptor(SubDescriptor[Index])
 else
  Result := nil;
//#UC END# *547DC309039E_547DC15100BCget_impl*
end;//TevCustomSubDescriptors.pm_GetSubLayerDescriptor

procedure TevCustomSubDescriptors.pm_SetSubLayerDescriptor(Index: Integer;
 aValue: TevSubLayerDescriptor);
//#UC START# *547DC309039E_547DC15100BCset_var*
//#UC END# *547DC309039E_547DC15100BCset_var*
begin
//#UC START# *547DC309039E_547DC15100BCset_impl*
 SubDescriptor[Index] := aValue;
//#UC END# *547DC309039E_547DC15100BCset_impl*
end;//TevCustomSubDescriptors.pm_SetSubLayerDescriptor

procedure TevCustomSubDescriptors.PlaceControl(aControl: TControl);
//#UC START# *5480448A0305_547DC15100BC_var*
//#UC END# *5480448A0305_547DC15100BC_var*
begin
//#UC START# *5480448A0305_547DC15100BC_impl*
 with aControl do
 begin
  Width := Max(DefSubPanelWidth, f_Width);
  Invalidate;
 end;//with aControl
//#UC END# *5480448A0305_547DC15100BC_impl*
end;//TevCustomSubDescriptors.PlaceControl

procedure TevCustomSubDescriptors.PlaceControls;
//#UC START# *548044A10171_547DC15100BC_var*
var
 l_Index: Integer;  
//#UC END# *548044A10171_547DC15100BC_var*
begin
//#UC START# *548044A10171_547DC15100BC_impl*
 if (f_Controls <> nil) then
  with f_Controls do
   for l_Index := Lo to Hi do
    PlaceControl(TControl(Items[l_Index]));
//#UC END# *548044A10171_547DC15100BC_impl*
end;//TevCustomSubDescriptors.PlaceControls

procedure TevCustomSubDescriptors.BuildColumns;
//#UC START# *548044CC019F_547DC15100BC_var*
var
 l_OfsL: Tl3ObjectWithHandleRefListPrim;
 l_C: Integer;

 procedure DoSub(aSub: TevSubDescriptor);
 var
  l_SD: TevSubData;
 begin//DoSub
  if aSub.Visible then
  begin
   l_SD := TevSubData.Create;
   try
    l_SD.f_C := aSub.Column;
    if (l_SD.f_C = DefColumn) then
    begin
     l_SD.f_C := l_C;
     Dec(l_C);
    end;//l_SD.f_C = DefColumn
    l_SD.f_S := aSub;
    if (l_OfsL = nil) then
     l_OfsL := Tl3ObjectWithHandleRefListPrim.MakeSorted;
    l_OfsL.Add(l_SD);
   finally
    l3Free(l_SD);
   end;//try..finally
  end;//aSub.Visible
 end;//DoSub

var
 l_SL: TevSubLayerDescriptor;
 l_S: TevSubDescriptor;
 l_Index: Integer;
 l_F: Integer;
 l_Ofs: Integer;
 l_Images: TCustomImageList;
 l_IC: Il3InfoCanvas;
//#UC END# *548044CC019F_547DC15100BC_var*
begin
//#UC START# *548044CC019F_547DC15100BC_impl*
 if not (csLoading in ComponentState) then
 begin
  if not f_InBuild then
  begin
   f_InBuild := True;
   try
    l_OfsL := nil;
    try
     l_C := DefColumn;
     for l_Index := Ord(ev_sbtMark) downto Ord(ev_sbtSub) do
     begin
      l_SL := TevSubLayerDescriptor(SubDescriptor[l_Index]);
      if (l_SL <> nil) then
      begin
       for l_F := 7 downto 0 do
       begin
        l_S := l_SL.Flags[l_F];
        if (l_S <> nil) then
         DoSub(l_S);
       end;//for l_F
       DoSub(l_SL);
      end;//l_SL <> nil
     end;//for l_Index
     if (l_OfsL = nil) then
      f_Width := 0
     else
     begin
      l_Ofs := 3{0};
      with l_OfsL do
       for l_Index := Lo to Hi do
       begin
        l_S := TevSubData(Items[l_Index]).f_S;
        l_S.Offset := l_Ofs;
        Inc(l_Ofs, 1);
        case l_S.DrawType of
         ev_sdtBitmap:
         begin
          l_Images := l_S.Images;
          if (l_Images = nil) then
           l_Images := Images;
          if (l_Images <> nil) and
             ((l_S.BitmapIndex >= 0) or (l_S.BlockBitmapIndex >= 0) or
              Assigned(l_S.f_OnGetBitmapIndex)) then
          begin
           Inc(l_Ofs, l_Images.Width + 2);
           if (l_Images.Width >= 10) then
            Inc(l_Ofs);
          end;//l_Images <> nil
         end;//ev_sdtBitmap
         ev_sdtOwnerDraw :
          ;
         ev_sdtNumber:
         begin
          if (l_IC = nil) then
           l_IC := nev.CrtIC;
          l_IC.Font := l_S.Font;
          Inc(l_Ofs, 12 * l_IC.pxAverageCharWidth);
         end;//ev_sdtNumber
         else
         begin
          if (l_IC = nil) then
           l_IC := nev.CrtIC;
          l_IC.Font := l_S.Font;
          Inc(l_Ofs, l_IC.pxAverageCharWidth + 2);
         end;//else
        end;//case l_S.DrawType
       end;//for l_Index
      f_Width := l_Ofs;
     end;//l_OfsL <> nil
     PlaceControls;
    finally
     l3Free(l_OfsL);
    end;//try..finally
   finally
    f_InBuild := False;
   end;//try..finally
  end;//not f_InBuild
 end;//not (csLoading in ComponentState)
//#UC END# *548044CC019F_547DC15100BC_impl*
end;//TevCustomSubDescriptors.BuildColumns

procedure TevCustomSubDescriptors.LinkControl(aControl: TControl);
//#UC START# *548044DE033C_547DC15100BC_var*
//#UC END# *548044DE033C_547DC15100BC_var*
begin
//#UC START# *548044DE033C_547DC15100BC_impl*
 if (aControl <> nil) then
 begin
  if (f_Controls = nil) then
   f_Controls := Tl3ObjectList.Make;
  f_Controls.Add(aControl);
  PlaceControl(aControl);
 end;//aControl <> nil
//#UC END# *548044DE033C_547DC15100BC_impl*
end;//TevCustomSubDescriptors.LinkControl

procedure TevCustomSubDescriptors.UnlinkControl(aControl: TControl);
//#UC START# *548044EC0041_547DC15100BC_var*
//#UC END# *548044EC0041_547DC15100BC_var*
begin
//#UC START# *548044EC0041_547DC15100BC_impl*
 if (f_Controls <> nil) then
  f_Controls.Remove(aControl);
//#UC END# *548044EC0041_547DC15100BC_impl*
end;//TevCustomSubDescriptors.UnlinkControl

function TevCustomSubDescriptors.DefineBitmapIndex(const aSub: IevDocumentPart;
 out aBitmapIndex: TImageIndex): Boolean;
//#UC START# *5480450001FA_547DC15100BC_var*
//#UC END# *5480450001FA_547DC15100BC_var*
begin
//#UC START# *5480450001FA_547DC15100BC_impl*
 if Assigned(f_OnDefineBlockIndex) then
  f_OnDefineBlockIndex(Self, aSub, aBitmapIndex);
//#UC END# *5480450001FA_547DC15100BC_impl*
end;//TevCustomSubDescriptors.DefineBitmapIndex

procedure TevCustomSubDescriptors.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_547DC15100BC_var*
//#UC END# *479731C50290_547DC15100BC_var*
begin
//#UC START# *479731C50290_547DC15100BC_impl*
 l3Free(f_Controls);
 l3Free(f_SubDescriptors);
 inherited;
//#UC END# *479731C50290_547DC15100BC_impl*
end;//TevCustomSubDescriptors.Cleanup

procedure TevCustomSubDescriptors.Loaded;
//#UC START# *484516C00214_547DC15100BC_var*
//#UC END# *484516C00214_547DC15100BC_var*
begin
//#UC START# *484516C00214_547DC15100BC_impl*
 inherited;
 BuildColumns;
//#UC END# *484516C00214_547DC15100BC_impl*
end;//TevCustomSubDescriptors.Loaded

//#UC START# *547DB8BC03D3impl*
//#UC END# *547DB8BC03D3impl*

function TevSubLayerDescriptor.pm_GetFlags(Index: Integer): TevSubDescriptor;
//#UC START# *547DBA98011B_547DBA30028Eget_var*
//#UC END# *547DBA98011B_547DBA30028Eget_var*
begin
//#UC START# *547DBA98011B_547DBA30028Eget_impl*
 if (f_Descriptors = nil) then
  Result := nil
 else
  Result := f_Descriptors[-(Handle * 10 + Index)];
//#UC END# *547DBA98011B_547DBA30028Eget_impl*
end;//TevSubLayerDescriptor.pm_GetFlags

procedure TevSubLayerDescriptor.pm_SetFlags(Index: Integer;
 aValue: TevSubDescriptor);
//#UC START# *547DBA98011B_547DBA30028Eset_var*
//#UC END# *547DBA98011B_547DBA30028Eset_var*
begin
//#UC START# *547DBA98011B_547DBA30028Eset_impl*
 if (f_Descriptors <> nil) then
  f_Descriptors[-(Handle * 10 + Index)] := aValue;
//#UC END# *547DBA98011B_547DBA30028Eset_impl*
end;//TevSubLayerDescriptor.pm_SetFlags

function TevSubLayerDescriptor.VisibleDef: Boolean;
//#UC START# *547DB9B10138_547DBA30028E_var*
//#UC END# *547DB9B10138_547DBA30028E_var*
begin
//#UC START# *547DB9B10138_547DBA30028E_impl*
 Result := True;
//#UC END# *547DB9B10138_547DBA30028E_impl*
end;//TevSubLayerDescriptor.VisibleDef

//#UC START# *547DBA30028Eimpl*
//#UC END# *547DBA30028Eimpl*

function TevCustomSubPanel.pm_GetSubDescriptors: TevSubDescriptors;
//#UC START# *54806C0F00C7_547DC47400ECget_var*
//#UC END# *54806C0F00C7_547DC47400ECget_var*
begin
//#UC START# *54806C0F00C7_547DC47400ECget_impl*
 Result := f_SubDescriptors;
//#UC END# *54806C0F00C7_547DC47400ECget_impl*
end;//TevCustomSubPanel.pm_GetSubDescriptors

procedure TevCustomSubPanel.pm_SetSubDescriptors(aValue: TevSubDescriptors);
//#UC START# *54806C0F00C7_547DC47400ECset_var*
//#UC END# *54806C0F00C7_547DC47400ECset_var*
begin
//#UC START# *54806C0F00C7_547DC47400ECset_impl*
 if (f_SubDescriptors <> aValue) then
 begin
  if (f_SubDescriptors <> nil) then
   f_SubDescriptors.UnlinkControl(Self);
  l3Set(f_SubDescriptors, aValue);
  if (f_SubDescriptors <> nil) then
   f_SubDescriptors.LinkControl(Self);
 end;//f_SubDescriptors <> Value
//#UC END# *54806C0F00C7_547DC47400ECset_impl*
end;//TevCustomSubPanel.pm_SetSubDescriptors

procedure TevCustomSubPanel.DoOnClickSub(SubType: Tl3Handle;
 SubHandle: Tl3Handle;
 aKind: TafwClickKind);
//#UC START# *547DC9DE0050_547DC47400EC_var*
//#UC END# *547DC9DE0050_547DC47400EC_var*
begin
//#UC START# *547DC9DE0050_547DC47400EC_impl*
 if Assigned(f_OnClickSub) then
  OnClickSub(Self, SubType, SubHandle, aKind);
//#UC END# *547DC9DE0050_547DC47400EC_impl*
end;//TevCustomSubPanel.DoOnClickSub

procedure TevCustomSubPanel.DoOnMenuSub(const Pt: Tl3SPoint;
 const R: Tl3SRect;
 SubType: Tl3Handle;
 SubHandle: Tl3Handle);
//#UC START# *547DCA13008B_547DC47400EC_var*
//#UC END# *547DCA13008B_547DC47400EC_var*
begin
//#UC START# *547DCA13008B_547DC47400EC_impl*
 if Assigned(f_OnMenuSub) then
  OnMenuSub(Self, Pt, R, SubType, SubHandle);
//#UC END# *547DCA13008B_547DC47400EC_impl*
end;//TevCustomSubPanel.DoOnMenuSub

function TevCustomSubPanel.DoOnMouseOverSub(const Pt: Tl3SPoint;
 const R: Tl3SRect;
 const aSub: IevSub;
 aLayer: Integer): Boolean;
//#UC START# *547DCA6C01A9_547DC47400EC_var*
//#UC END# *547DCA6C01A9_547DC47400EC_var*
begin
//#UC START# *547DCA6C01A9_547DC47400EC_impl*
 if Assigned(f_OnMouseOverSub) then
  Result := OnMouseOverSub(Self, Pt, R, aSub, aLayer)
 else 
 begin
  Hint := IntToStr(aSub.ID) + '|' + l3PCharLen2String(aSub.Name);
  if (Hint = '') then
   CancelHint
  else
   ActivateHint;
  Result := True;
 end;
//#UC END# *547DCA6C01A9_547DC47400EC_impl*
end;//TevCustomSubPanel.DoOnMouseOverSub

procedure TevCustomSubPanel.DrawSub(const aCanvas: Il3Canvas;
 aSubDescr: TevSubDescriptor;
 aSub: TevSubPanelSub;
 aRealPaint: Boolean);
//#UC START# *547DCAF1011A_547DC47400EC_var*
var
 SDT: TevSubDrawType;
 l_BmpIndex: TImageIndex;
 l_R: Tl3Rect;
 H: Tl3Handle;
 Str: String;
 Ofs: TevPixel;
 l_Block: IevDocumentPart;
 l_Images: TCustomImageList;
//#UC END# *547DCAF1011A_547DC47400EC_var*
begin
//#UC START# *547DCAF1011A_547DC47400EC_impl*
 with aCanvas do
 begin
  Font := aSubDescr.Font;
  l_R := aSub.R;
  Ofs := DP2LP(PointX(aSubDescr.Offset)).X;
  Inc(l_R.R.Left, Ofs);
  Inc(l_R.R.Right, Ofs);
  H := aSub.Handle;
  SDT := aSubDescr.DrawType;
  case SDT of
   ev_sdtNumber, ev_sdtChar, ev_sdtCharNumber:
   begin
    Str := '?';
    case SDT of
     ev_sdtNumber: Str := IntToStr(H);
     ev_sdtCharNumber :
     begin
      H := aSubDescr.NumberOffset;
      if (H >= Low(Byte)) and (H <= High(Byte)) then
       Str := Char(H);
     end;//ev_sdtCharNumber
     ev_sdtChar:
     begin
      Inc(H, aSubDescr.NumberOffset);
      if (H >= Low(Byte)) and (H <= High(Byte)) then
       Str := Char(H);
     end;//ev_sdtChar
    end;//case SDT
    l_R.R.BottomRight := l_R.TopLeft.Add(StringOut(l_R.TopLeft, l3PCharLen(Str)));
   end;//ev_sdtNumber, ev_sdtChar..
   ev_sdtBitmap:
   begin
    l_Images := aSubDescr.Images;
    if (l_Images = nil) then
     l_Images := SubDescriptors.Images;
    if (l_Images <> nil) then
    begin
     with aSubDescr do
     begin
      l_BmpIndex := BitmapIndex;
      if (f_BlockBitmapIndex >= 0) then
      begin
       if Supports(aSub.RealSub, IevDocumentPart, l_Block) then
        try
         l_BmpIndex := f_BlockBitmapIndex;
         if aSubDescr = f_SubDescriptors.SubsLayer then
          f_SubDescriptors.DefineBitmapIndex(l_Block, l_BmpIndex);
        finally
         l_Block := nil;
        end;//try..finally
      end;// f_BlockBitmapIndex >= 0
      if (f_DocumentBitmapIndex >= 0) then
      begin
       if Supports(aSub.RealSub, IevDocument) then
        try
         l_BmpIndex := f_DocumentBitmapIndex;
        finally
         l_Block := nil;
        end;//try..finally
      end;// f_DocumentBitmapIndex >= 0
      if Assigned(f_OnGetBitmapIndex) then
       f_OnGetBitmapIndex(Self, Handle, H, l_BmpIndex, l_Images);
     end;//with aSubDescr
     if (l_BmpIndex >= 0) and (l_Images <> nil) then
     begin
      with l_Images do
      begin
       if aRealPaint then
        with LP2DP(l_R.TopLeft) do
         Draw(Canvas, P.X, P.Y, l_BmpIndex);
       l_R.R.BottomRight := l_R.TopLeft.Add(DP2LP(l3SPoint(Width, Height)));
      end;//with l_Images
     end;//l_BmpIndex >= 0
    end;//l_Images <> nil
   end;//ev_sdtBitmap
   ev_sdtOwnerDraw:
    Self.DoDrawSub(Self, aCanvas, l_R, aSubDescr.Handle, aSub);
  end;//case SDT
  aSub.DrawRect := l_R;
  if not aRealPaint then
   evInvalidateRect(Handle, l_R);
 end;//with aCanvas..
//#UC END# *547DCAF1011A_547DC47400EC_impl*
end;//TevCustomSubPanel.DrawSub

procedure TevCustomSubPanel.MakeSubRect(var R: Tl3Rect);
//#UC START# *547DCB0901C7_547DC47400EC_var*
var
 CR: Tl3SRect;
//#UC END# *547DCB0901C7_547DC47400EC_var*
begin
//#UC START# *547DCB0901C7_547DC47400EC_impl*
 CR.InitRect(ClientRect);
 case Orientation of
  ev_orHorizontal:
  begin
   with nev.CrtIC do
   begin
    Lock;
    try
     with R do
     begin
      Top := DP2LP(PointY(CR.Top)).Y;
      Bottom := DP2LP(PointY(CR.Bottom)).Y;
      Left := evPixelZoom(Zoom, Left);
      Right := evPixelZoom(Zoom, Right);
      {$IfNDef Nemesis}
      Inflate(DP2LP(PointY(-Succ(BevelWidth))));
      {$EndIf  Nemesis}
     end;//with R
    finally
     Unlock;
    end;//try..finally
   end;//with nev.CrtIC
  end;//ev_orHorizontal
  ev_orVertical:
  begin
   with nev.CrtIC do
   begin
    Lock;
    try
     with R do
     begin
      Left := DP2LP(PointX(CR.Left)).X;
      Right := DP2LP(PointX(CR.Right)).X;
      Top := evPixelZoom(Zoom, Top);
      Bottom := evPixelZoom(Zoom, Bottom);
      {$IfNDef Nemesis}
      Inflate(DP2LP(PointX(-Succ(BevelWidth))));
      {$EndIf  Nemesis}
     end;//with R
    finally
     Unlock;
    end;//try..finally
   end;//with nev.CrtIC
  end;//ev_orVertical
 end;//case Orientation..
//#UC END# *547DCB0901C7_547DC47400EC_impl*
end;//TevCustomSubPanel.MakeSubRect

procedure TevCustomSubPanel.DrawSubs(const Canvas: Il3Canvas);
//#UC START# *547DCB1D0037_547DC47400EC_var*
var
 CR: Tl3Rect;

 function DrawSubLayer(SA: PevSubPanelSubArray; Index: Integer): Boolean;
 var
  SD: TevSubDescriptor;

  function DrawSub(Sub: PevSubPanelSub; Index: Integer): Boolean; 
  begin
   if CR.IntersectsWith(Sub^.R) then
    Self.DrawSub(Canvas, SD, Sub^, True);
   Result := True;
  end;

 begin{DrawSubLayer}
  SD := SubDescriptors[SA^.Handle];
  if (SD <> nil) and SD.Visible then
   SA^.IterateAllF(l3L2IA(@DrawSub));
  Result := True;
 end;{DrawSubLayer}
//#UC END# *547DCB1D0037_547DC47400EC_var*
begin
//#UC START# *547DCB1D0037_547DC47400EC_impl*
 CR := Canvas.ClipRect;
 f_Subs.IterateAllF(l3L2IA(@DrawSubLayer));
//#UC END# *547DCB1D0037_547DC47400EC_impl*
end;//TevCustomSubPanel.DrawSubs

function TevCustomSubPanel.ScrollSub(SPS: TevSubPanelSub;
 const P: Tl3Point): Boolean;
//#UC START# *547DCB3903BF_547DC47400EC_var*
var
 l_R: Tl3Rect;
//#UC END# *547DCB3903BF_547DC47400EC_var*
begin
//#UC START# *547DCB3903BF_547DC47400EC_impl*
 Result := True;
 l_R := SPS.R;
 l_R.OffsetPt(P);
 with nev.CrtIC.LR2DR(l_R) do
 begin
  if ((R.Left < 0) and (R.Right < 0)) or
     ((R.Left > Width) and (R.Right > Width)) or
     ((R.Top < 0) and (R.Bottom < 0)) or
     ((R.Top > Height) and (R.Bottom > Height)) then
   Result := False
  else
   SPS.R := l_R;
 end;//with pR^
 l_R := SPS.DrawRect;
 l_R.OffsetPt(P);
 with nev.CrtIC.LR2DR(l_R) do
 begin
  if ((R.Left < 0) and (R.Right < 0)) or
     ((R.Left > Width) and (R.Right > Width)) or
     ((R.Top < 0) and (R.Bottom < 0)) or
     ((R.Top > Height) and (R.Bottom > Height)) then
   Result := False
  else
   SPS.DrawRect := l_R;
 end;//with pR^
//#UC END# *547DCB3903BF_547DC47400EC_impl*
end;//TevCustomSubPanel.ScrollSub

procedure TevCustomSubPanel.AddSub(const CN: Il3Canvas;
 const aR: Tl3Rect;
 aSubType: Tl3Handle;
 const aSub: IevSub);
//#UC START# *547DCC0002F9_547DC47400EC_var*
var
 SPS: TevSubPanelSub;
 OldR: Tl3Rect;
 OldDR: Tl3Rect;
 SD: TevSubDescriptor;
 SL: TevSubPanelSubArray;
 I: Integer;
 l_aR: Tl3Rect;
//#UC END# *547DCC0002F9_547DC47400EC_var*
begin
//#UC START# *547DCC0002F9_547DC47400EC_impl*
 if aSub.Exists then
 begin
  SD := SubDescriptors[aSubType];
  if (SD <> nil) then
  begin
   l_aR := aR;
   MakeSubRect(l_aR);
   if f_Subs.FindData(aSubType, I) then
   begin
    SL := f_Subs.Items[I];
    if SL.FindData(aSub.ID, I) then
     SPS := SL.Items[I]
    else
     SPS := nil;
   end//f_Subs.Find(aSubType, I)
   else
    SPS := nil; 
   l3FillChar(OldDR, SizeOf(OldDR), 0);
   if (SPS <> nil) then
   begin
    OldR := SPS.R;
    OldDR := SPS.DrawRect;
    if not OldR.EQ(l_aR) then
     SPS := nil;
   end;
   if (SPS = nil) then
   begin
    SPS := TevSubPanelSub.Create(aSub);
    try
     SPS.R := l_aR;
     f_Subs.CheckLayer(aSubType).Add(SPS);
     evInvalidateRect(Handle, OldDR);
     SD := SubDescriptors[aSubType];
     if (SD <> nil) and SD.Visible then
      DrawSub(CN, SD, SPS, False);
    finally
     l3Free(SPS);
    end;//try..finally
   end;//SPS = nil
  end;//SD <> nil
 end;//aSub.Exists
//#UC END# *547DCC0002F9_547DC47400EC_impl*
end;//TevCustomSubPanel.AddSub

function TevCustomSubPanel.DeleteSubPrim(aSubType: Tl3Handle;
 aSubHandle: Tl3Handle): Boolean;
//#UC START# *547DCC2401CC_547DC47400EC_var*
var
 SL: TevSubPanelSubArray;
 I: Integer;
//#UC END# *547DCC2401CC_547DC47400EC_var*
begin
//#UC START# *547DCC2401CC_547DC47400EC_impl*
 if f_Subs.FindData(aSubType, I) then
 begin
  SL := f_Subs.Items[I];
  if SL.FindData(aSubHandle, I) then
  begin
   if HandleAllocated then
    evInvalidateRect(Handle, SL.Items[I].R);
   SL.Delete(I);
   Result := True;
  end//SL.Find(aSubHandle, I)
  else
   Result := False;
 end//f_Subs.Find(aSubType, I)
 else
  Result := False;
//#UC END# *547DCC2401CC_547DC47400EC_impl*
end;//TevCustomSubPanel.DeleteSubPrim

function TevCustomSubPanel.SubOnPoint(const Pt: Tl3SPoint;
 out st: Tl3Handle): TevSubPanelSub;
//#UC START# *547DCC9501A5_547DC47400EC_var*
var
 Res: TevSubPanelSub absolute Result;

 function LayerOnPoint(SL: PevSubPanelSubArray; Index: Integer): Boolean;
 var
  Cont: Boolean absolute Result;

  function _SubOnPoint(Sub: PevSubPanelSub; Index: Integer): Boolean;
  begin{_SubOnPoint}
   if nev.CrtIC.LR2DR(Sub^.DrawRect).ContainsPt(Pt) then
   begin
    st := SL^.Handle;
    Res := Sub^;
    Result := False;
   end
   else
    Result := True;
   Cont := Result;
  end;{_SubOnPoint}
 begin{LayerOnPoint}
  Cont := True;
  SL^.IterateAllF(l3L2IA(@_SubOnPoint));
 end;{LayerOnPoint}
//#UC END# *547DCC9501A5_547DC47400EC_var*
begin
//#UC START# *547DCC9501A5_547DC47400EC_impl*
 Result := nil;
 f_Subs.IterateAllF(l3L2IA(@LayerOnPoint));
//#UC END# *547DCC9501A5_547DC47400EC_impl*
end;//TevCustomSubPanel.SubOnPoint

function TevCustomSubPanel.CheckSubOnPoint(aX: Integer;
 aY: Integer;
 out theSub: IevSub;
 out theFlag: Integer): Boolean;
//#UC START# *547DCCB901E2_547DC47400EC_var*
var
 l_Sub: TevSubPanelSub;
 l_LayerID: Tl3Handle;
//#UC END# *547DCCB901E2_547DC47400EC_var*
begin
//#UC START# *547DCCB901E2_547DC47400EC_impl*
 Result := False;
 l_Sub := SubOnPoint(l3SPoint(aX, aY), l_LayerID);
 if (l_Sub <> nil) then
 begin
  Result := True;
  if (l_LayerID < 0) then
  begin
   l_LayerID := -l_LayerID;
   theFlag := Succ(l_LayerID mod 10);
   l_LayerID := l_LayerID div 10;
  end
  else
   theFlag := 0;
  theSub := l_Sub.RealSub;
 end;//l_Sub <> nil
//#UC END# *547DCCB901E2_547DC47400EC_impl*
end;//TevCustomSubPanel.CheckSubOnPoint

function TevCustomSubPanel.CheckSubOnPoint(aX: Integer;
 aY: Integer;
 out theSub: IevSub): Boolean;
//#UC START# *547DCCFF02B3_547DC47400EC_var*
var
 l_Flag: Integer;
//#UC END# *547DCCFF02B3_547DC47400EC_var*
begin
//#UC START# *547DCCFF02B3_547DC47400EC_impl*
 Result := CheckSubOnPoint(aX, aY, theSub, l_Flag);
//#UC END# *547DCCFF02B3_547DC47400EC_impl*
end;//TevCustomSubPanel.CheckSubOnPoint

procedure TevCustomSubPanel.DeleteSub(aSubType: Tl3Handle;
 aSubHandle: Tl3Handle);
//#UC START# *547DCD45005F_547DC47400EC_var*
var
 I: Integer;
//#UC END# *547DCD45005F_547DC47400EC_var*
begin
//#UC START# *547DCD45005F_547DC47400EC_impl*
 if DeleteSubPrim(aSubType, aSubHandle) then
  for I := 0 to 7 do
   DeleteSubPrim(-(aSubType*10+I), aSubHandle);
//#UC END# *547DCD45005F_547DC47400EC_impl*
end;//TevCustomSubPanel.DeleteSub

{$If NOT Defined(NoScripts)}
function TevCustomSubPanel.GetSubPanelSubCollection: TevSubPanelSubCollection;
//#UC START# *547DCD6D028D_547DC47400EC_var*
//#UC END# *547DCD6D028D_547DC47400EC_var*
begin
//#UC START# *547DCD6D028D_547DC47400EC_impl*
 Result := f_Subs;
//#UC END# *547DCD6D028D_547DC47400EC_impl*
end;//TevCustomSubPanel.GetSubPanelSubCollection
{$IfEnd} // NOT Defined(NoScripts)

procedure TevCustomSubPanel.WMLButtonDblClk(var Msg: TWMLButtonDblClk);
//#UC START# *547DC93D03A0_547DC47400EC_var*
var
 st: Tl3Handle;
 SPS: TevSubPanelSub;
//#UC END# *547DC93D03A0_547DC47400EC_var*
begin
//#UC START# *547DC93D03A0_547DC47400EC_impl*
 if not (csDesigning in ComponentState) then
 begin
  with Msg do
   SPS := SubOnPoint(l3SPoint(XPos, YPos), st);
  if (SPS <> nil) then
   DoOnClickSub(st, SPS.Handle, afw_ckDouble)
  else
   inherited;
 end
 else
  inherited;
//#UC END# *547DC93D03A0_547DC47400EC_impl*
end;//TevCustomSubPanel.WMLButtonDblClk

procedure TevCustomSubPanel.WMLButtonUp(var Msg: TWMLButtonUp);
//#UC START# *547DC9530096_547DC47400EC_var*
var
 st: Tl3Handle;
 SPS: TevSubPanelSub;
//#UC END# *547DC9530096_547DC47400EC_var*
begin
//#UC START# *547DC9530096_547DC47400EC_impl*
 if not (csDesigning in ComponentState) then
 begin
  with Msg do
   SPS := SubOnPoint(l3SPoint(XPos, YPos), st);
  if (SPS <> nil) then
   DoOnClickSub(st, SPS.Handle, afw_ckSingle)
  else
   inherited;
 end
 else
  inherited;
//#UC END# *547DC9530096_547DC47400EC_impl*
end;//TevCustomSubPanel.WMLButtonUp

procedure TevCustomSubPanel.WMRButtonDown(var Msg: TWMRButtonDown);
//#UC START# *547DC96F0327_547DC47400EC_var*
var
 Pt: Tl3SPoint;
 CPt: Tl3SPoint;
 st: Tl3Handle;
 SPS: TevSubPanelSub;
//#UC END# *547DC96F0327_547DC47400EC_var*
begin
//#UC START# *547DC96F0327_547DC47400EC_impl*
 if not (csDesigning in ComponentState) then
 begin
  with Msg do
   Pt := l3SPoint(XPos, YPos);
  CPt := Pt;
  Pt.Convert(ClientToScreen);
  SPS := SubOnPoint(CPt, st);
  if (SPS <> nil) then
   DoOnMenuSub(Pt, nev.CrtIC.LR2DR(SPS.DrawRect), st, SPS.Handle)
  else
   inherited
 end
 else
  inherited;
//#UC END# *547DC96F0327_547DC47400EC_impl*
end;//TevCustomSubPanel.WMRButtonDown

procedure TevCustomSubPanel.WMNCHitTest(var Msg: TWMNCHitTest);
//#UC START# *547DC97D01D5_547DC47400EC_var*
var
 Pt: Tl3SPoint;
 CPt: Tl3SPoint;
 st: Tl3Handle;
 SPS: TevSubPanelSub;
//#UC END# *547DC97D01D5_547DC47400EC_var*
begin
//#UC START# *547DC97D01D5_547DC47400EC_impl*
 if not (csDesigning in ComponentState) then
 begin
  with Msg do
   Pt := l3SPoint(XPos, YPos);
  CPt := Pt;
  CPt.Convert(ScreenToClient);
  SPS := SubOnPoint(CPt, st);
  if (SPS <> nil) then
  begin
   if (SPS <> f_HintSub) then
   begin
    f_HintSub := SPS;
    DoOnMouseOverSub(Pt, nev.CrtIC.LR2DR(SPS.DrawRect), SPS.RealSub, st);
   end;//SPS <> f_HintSub..
  end//SPS <> nil
  else
  begin
   f_HintSub := nil;
   CancelHint;
  end;//SPS <> nil
 end;
 inherited;
//#UC END# *547DC97D01D5_547DC47400EC_impl*
end;//TevCustomSubPanel.WMNCHitTest

procedure TevCustomSubPanel.WMSetCursor(var Msg: TWMSetCursor);
//#UC START# *547DC9910354_547DC47400EC_var*
var
 Pt: Tl3SPoint;
 st: Tl3Handle;
 l_SubDescriptor: TevSubDescriptor;
 l_Cursor: TCursor;
//#UC END# *547DC9910354_547DC47400EC_var*
begin
//#UC START# *547DC9910354_547DC47400EC_impl*
 if not (csDesigning in ComponentState) and
  (Msg.HitTest = HTCLIENT) then 
 begin
  {get the mouse position in client coordinates}
  Pt.GetCursorPos;
  Pt.Convert(ScreenToClient);
  if (SubOnPoint(Pt, st) = nil) then
   inherited
  else
  begin
   l_SubDescriptor := SubDescriptors[st];
   if (l_SubDescriptor = nil) then
    l_Cursor := crDefault
   else
    l_Cursor := l_SubDescriptor.Cursor;
   if (l_Cursor = crDefault) then
    l_Cursor := SubDescriptors.Cursor;
   if (l_Cursor = crDefault) then
    inherited
   else
    SetCursor(Screen.Cursors[l_Cursor]);
  end;//SubOnPoint  
 end//not (csDesigning in ComponentState)
 else
  inherited;
//#UC END# *547DC9910354_547DC47400EC_impl*
end;//TevCustomSubPanel.WMSetCursor

function TevCustomSubPanel.SubDescriptorsStored: Boolean;
 {* "Функция определяющая, что свойство SubDescriptors сохраняется" }
//#UC START# *C5BCC928FE9C_547DC47400EC_var*
//#UC END# *C5BCC928FE9C_547DC47400EC_var*
begin
//#UC START# *C5BCC928FE9C_547DC47400EC_impl*
 Result := (f_SubDescriptors <> nil) and (f_SubDescriptors.Owner <> nil);
//#UC END# *C5BCC928FE9C_547DC47400EC_impl*
end;//TevCustomSubPanel.SubDescriptorsStored

procedure TevCustomSubPanel.ClearSubs;
//#UC START# *47C6B01A0301_547DC47400EC_var*
var
 I: Integer;
//#UC END# *47C6B01A0301_547DC47400EC_var*
begin
//#UC START# *47C6B01A0301_547DC47400EC_impl*
 if not f_Subs.Empty then
  for I := 0 to Pred(f_Subs.Count) do
   f_Subs.Items[I].Clear;
 Invalidate;
//#UC END# *47C6B01A0301_547DC47400EC_impl*
end;//TevCustomSubPanel.ClearSubs

procedure TevCustomSubPanel.NotifySubDeleted(const aSub: IevSub);
//#UC START# *47C6B0750334_547DC47400EC_var*
//#UC END# *47C6B0750334_547DC47400EC_var*
begin
//#UC START# *47C6B0750334_547DC47400EC_impl*
 DeleteSub(aSub.LayerID, aSub.ID);
 Invalidate;
//#UC END# *47C6B0750334_547DC47400EC_impl*
end;//TevCustomSubPanel.NotifySubDeleted

procedure TevCustomSubPanel.NotifyFlagsChange(const aSub: IevSub);
 {* флаги метки изменились }
//#UC START# *4A2627980257_547DC47400EC_var*
var
 SL: TevSubPanelSubArray;
 I, J: Integer;
 Sub: TevSubPanelSub;
 CN: Il3Canvas;
 l_Flags: Integer;
//#UC END# *4A2627980257_547DC47400EC_var*
begin
//#UC START# *4A2627980257_547DC47400EC_impl*
 if f_Subs.FindData(aSub.LayerID, I) then
 begin
  SL := f_Subs.Items[I];
  if SL.FindData(aSub.ID, I) then
  begin
   Sub := SL.Items[I];
   CN := Canvas;
   CN.BeginPaint;
   try
    CN.DrawEnabled := True;
    l_Flags := aSub.Flags;
    for J := 0 to 7 do
    begin
     if l3TestBit(l_Flags, J) then
      AddSub(CN, Sub.R, -(aSub.LayerID * 10 + J), (Sub as TevSubPanelSub).RealSub)
     else
      DeleteSubPrim(-(aSub.LayerID * 10 + J), aSub.ID);
    end;//for J
   finally
    CN.EndPaint;
   end;//try..finally
  end;//SL <> nil
 end;//f_Subs.Find
//#UC END# *4A2627980257_547DC47400EC_impl*
end;//TevCustomSubPanel.NotifyFlagsChange

function TevCustomSubPanel.pm_GetZoom: SmallInt;
//#UC START# *547CA1860092_547DC47400ECget_var*
//#UC END# *547CA1860092_547DC47400ECget_var*
begin
//#UC START# *547CA1860092_547DC47400ECget_impl*
 Result := f_Zoom;
//#UC END# *547CA1860092_547DC47400ECget_impl*
end;//TevCustomSubPanel.pm_GetZoom

procedure TevCustomSubPanel.pm_SetZoom(aValue: SmallInt);
//#UC START# *547CA1860092_547DC47400ECset_var*
//#UC END# *547CA1860092_547DC47400ECset_var*
begin
//#UC START# *547CA1860092_547DC47400ECset_impl*
 if (Zoom <> aValue) then
 begin
  f_Zoom := aValue;
  ClearSubs;
 end;
//#UC END# *547CA1860092_547DC47400ECset_impl*
end;//TevCustomSubPanel.pm_SetZoom

procedure TevCustomSubPanel.NeedDrawSub(const aR: Tl3Rect;
 const aSub: IevSub);
//#UC START# *547CA1CA0126_547DC47400EC_var*
var
 F: Integer;
 I: Byte;
 CN: Il3Canvas;
 l_Rect: Tl3SRect;
 l_SubIsVisible: Boolean;
//#UC END# *547CA1CA0126_547DC47400EC_var*
begin
//#UC START# *547CA1CA0126_547DC47400EC_impl*
 {$IFNDEF DesignTimeLibrary}
 if aSub.Exists {and aSub.IsVisibleOnSubPanel} then
 begin
  CN := Canvas;
  CN.BeginPaint;
  try
   CN.DrawEnabled := True;
   l_Rect.InitRect(ClientRect);
   {$IfNDef Nemesis}
   l_Rect.Inflate1(-Succ(BevelWidth));
   {$EndIf  Nemesis}
   with l_Rect do
    IntersectClipRect(CN.DC, Left, Top, Right, Bottom);
   AddSub(CN, aR, aSub.LayerID, aSub);
   F := aSub.Flags;
   l_SubIsVisible := aSub.IsVisibleOnSubPanel;
   if (F <> 0) then
    for I := 0 to 7 do
     if l3TestBit(F, I) then
      if (I = 0) or l_SubIsVisible then // 0 - колонка с номером блока/саба. Показываем всегда. 476366422
       AddSub(CN, aR, -(aSub.LayerID*10+I), aSub);
  finally
   CN.EndPaint;
  end;//try..finanlly
 end;//aSub.IsValid
 {$ENDIF DesignTimeLibrary}
//#UC END# *547CA1CA0126_547DC47400EC_impl*
end;//TevCustomSubPanel.NeedDrawSub

procedure TevCustomSubPanel.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_547DC47400EC_var*
//#UC END# *479731C50290_547DC47400EC_var*
begin
//#UC START# *479731C50290_547DC47400EC_impl*
 l3Free(f_Subs);
 SubDescriptors := nil;
 inherited;
//#UC END# *479731C50290_547DC47400EC_impl*
end;//TevCustomSubPanel.Cleanup

constructor TevCustomSubPanel.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_547DC47400EC_var*
//#UC END# *47D1602000C6_547DC47400EC_var*
begin
//#UC START# *47D1602000C6_547DC47400EC_impl*
 inherited;
 ControlStyle := ControlStyle - [csSetCaption, csAcceptsControls,csCaptureMouse];
 Orientation := ev_orVertical;
 f_Zoom := def_Zoom;
 f_Subs := TevSubPanelSubCollection.Create(Self);
 Width := DefSubPanelWidth;
//#UC END# *47D1602000C6_547DC47400EC_impl*
end;//TevCustomSubPanel.Create

procedure TevCustomSubPanel.Paint(const CN: Il3Canvas);
 {* процедура рисования внешнего вида управляющего элемента }
//#UC START# *48C6C044025E_547DC47400EC_var*
{$IfNDef Nemesis}
var
 lRect: TRect;
{$EndIf  Nemesis}
//#UC END# *48C6C044025E_547DC47400EC_var*
begin
//#UC START# *48C6C044025E_547DC47400EC_impl*
 with CN do
  FillRect(ClipRect);
 DrawSubs(CN);
 {$IfNDef Nemesis}
 lRect := GetClientRect;
 DrawFrame(CN, lRect);
 {$EndIf  Nemesis}
//#UC END# *48C6C044025E_547DC47400EC_impl*
end;//TevCustomSubPanel.Paint

procedure TevCustomSubPanel.OrientationChanged;
//#UC START# *547CB4C800EA_547DC47400EC_var*
//#UC END# *547CB4C800EA_547DC47400EC_var*
begin
//#UC START# *547CB4C800EA_547DC47400EC_impl*
 ClearSubs;
//#UC END# *547CB4C800EA_547DC47400EC_impl*
end;//TevCustomSubPanel.OrientationChanged

procedure TevCustomSubPanel.DoScroll(iD: Tl3Inch);
//#UC START# *547CC36E00D5_547DC47400EC_var*
var
 P: Tl3SPoint;
 CR: Tl3SRect;
 iP: Tl3Point;

 procedure ScrollSubs;

  function ScrollSubLayer(SA: PevSubPanelSubArray; Index: Integer): Boolean; 
  var
   I: Integer;
  begin{ScrollSubLayer}
   I := 0;
   while (I < SA^.Count) do
    if ScrollSub(SA^.Items[I], iP) then
     Inc(I)
    else
     SA^.Delete(I);
   Result := True;
  end;{ScrollSubLayer}

 begin{ScrollSubs}
  if (P.X <> 0) or (P.Y <> 0) then
  begin
   Windows.ScrollWindow(Handle, P.X, P.Y, @CR, @CR);
   f_Subs.IterateAllF(l3L2IA(@ScrollSubLayer));
   Update;
  end;{(P.X <> 0)..}
 end;{ScrollSubs}

var
 D: TevPixel;
 S: Boolean;
//#UC END# *547CC36E00D5_547DC47400EC_var*
begin
//#UC START# *547CC36E00D5_547DC47400EC_impl*
 iD  := evPixelZoom(Zoom, iD);
 D := nev.CrtIC.LP2DP(l3PointX(iD)).X;
 CR.InitRect(ClientRect);
 {$IfNDef Nemesis}
 CR.Inflate1(-Succ(BevelWidth));
 {$EndIf  Nemesis}
 S := True;
 P := Point0;
 iP := evPoint0;
 case Orientation of
  ev_orHorizontal:
   if (Abs(D) < (CR.R.Right - CR.R.Left)) then
   begin
    P.X := D;
    iP.X := iD;
   end
   else
    S := False;
  ev_orVertical:
   if (Abs(D) < (CR.R.Bottom - CR.R.Top)) then
   begin
    P.Y := D;
    iP.Y := iD;
   end
   else
    S := False;
 end;//case Orientation
 if S then
  ScrollSubs
 else
  ClearSubs;
//#UC END# *547CC36E00D5_547DC47400EC_impl*
end;//TevCustomSubPanel.DoScroll

//#UC START# *547DB02F034Bimpl*
//#UC END# *547DB02F034Bimpl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevSubDescriptor);
 {* Регистрация TevSubDescriptor }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevSubLayerDescriptor);
 {* Регистрация TevSubLayerDescriptor }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevCustomSubPanel);
 {* Регистрация TevCustomSubPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevSubPanel);
 {* Регистрация TevSubPanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
