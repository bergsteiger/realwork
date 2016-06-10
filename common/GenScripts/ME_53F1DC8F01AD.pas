unit DropDownTree;

// Модуль: "w:\common\components\gui\Garant\VT\ComboTree\DropDownTree.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TDropDownTree" MUID: (53F1DC8F01AD)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , AbstractDropDown
 , l3ControlsTypes
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , l3TreeInterfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Messages
 , ctTypes
 , Types
 , Windows
 , nevTools
 , Classes
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , AbsSubTree
 //#UC START# *53F1DC8F01ADintf_uses*
 //#UC END# *53F1DC8F01ADintf_uses*
;

const
 CM_ARTFULBEHAVIOUR = WM_USER + 12345;

type
 TSubTree = class;

 TDropDownTreePrim = class(TAbstractDropDown)
  private
   f_Invert: Boolean;
   f_CalcDimensions: Boolean;
   f_Tree: TSubTree;
   f_AdjustDropDownPos: Boolean;
   f_SizeableTree: Boolean;
   f_ShowGripper: Boolean;
   f_OnGetItemImage: Tl3GetItemImage;
   f_MinVisibleDropCount: Integer;
   f_MaxVisibleDropCount: Integer;
   f_GrowDropTreeWidthByIcons: Boolean;
   f_KeepLastDropWidth: Boolean;
   f_DropHeight: Integer;
   f_DropWidth: Integer;
  private
   procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
   procedure WMLButtonUp(var Message: TWMLButtonDown); message WM_LBUTTONUP;
   procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
   procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
   procedure CMArtfulBehaviour(var Message: TMessage); message CM_ARTFULBEHAVIOUR;
  protected
   procedure pm_SetSizeableTree(aValue: Boolean);
   procedure pm_SetShowGripper(aValue: Boolean);
   procedure pm_SetOnGetItemImage(aValue: Tl3GetItemImage);
   function pm_GetShowRoot: Boolean;
   procedure pm_SetShowRoot(aValue: Boolean);
   function pm_GetShowIcons: Boolean;
   procedure pm_SetShowIcons(aValue: Boolean);
   function pm_GetTreeImages: TCustomImageList;
   procedure pm_SetTreeImages(aValue: TCustomImageList);
   function pm_GetCurrentNode: Il3SimpleNode; virtual;
   procedure pm_SetCurrentNode(const aValue: Il3SimpleNode); virtual;
   function pm_GetTreeStruct: Il3SimpleTree;
   procedure pm_SetTreeStruct(const aValue: Il3SimpleTree);
   function pm_GetIsList: Boolean; virtual;
   function pm_GetTree: TSubTree;
   procedure RecreateTreeIfNeeded(aValue: TComboStyle); virtual;
   function CreateSubTree: TSubTree; virtual;
   function CursorStored: Boolean;
   function EstimateTreeHeight(aMinSize: Integer;
    aMaxSize: Integer): Integer; virtual;
   function EstimateTreeWidth(aMaxSizeX: Integer;
    aSizeY: Integer): Integer; virtual;
   procedure CalcDropDimensions;
   procedure DropSessionSettings;
   function CalcGrowingWidth: Integer;
   procedure TreeChangedNotification; virtual;
   procedure ActionElementHandler(Sender: TObject;
    Index: LongInt);
   procedure ProcessTreeSelect(ChooseFromTree: Boolean;
    aTriggerSelect: Boolean); virtual;
   function GetItemImageHandler(Sender: TObject;
    anIndex: Integer;
    var aImages: TCustomImageList): Integer; virtual;
   function TreeImagesStored: Boolean;
    {* Функция определяющая, что свойство TreeImages сохраняется }
   function GetActiveSub: TWinControl; override;
   function GetTreeHandle: THandle; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetPaintSelection: InevRange; override;
   procedure pm_SetDropped(aValue: Boolean); override;
   procedure HideDropDown; override;
   {$If NOT Defined(NoVCM)}
   function IvcmState_LoadState(const aState: IUnknown;
    aStateType: TvcmStateType): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function IvcmState_SaveState(out aState: IUnknown;
    aStateType: TvcmStateType): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure CustomDoEnter; virtual;
   function InnerPoint(const aPoint: TPoint): Boolean; virtual;
   function IsInnerControl(aHandle: THandle): Boolean; virtual;
   constructor Create(AOwner: TComponent); override;
  protected
   property SizeableTree: Boolean
    read f_SizeableTree
    write pm_SetSizeableTree;
   property ShowGripper: Boolean
    read f_ShowGripper
    write pm_SetShowGripper;
   property ShowIcons: Boolean
    read pm_GetShowIcons
    write pm_SetShowIcons;
  public
   property AdjustDropDownPos: Boolean
    read f_AdjustDropDownPos
    write f_AdjustDropDownPos;
   property OnGetItemImage: Tl3GetItemImage
    read f_OnGetItemImage
    write pm_SetOnGetItemImage;
   property MinVisibleDropCount: Integer
    read f_MinVisibleDropCount
    write f_MinVisibleDropCount;
   property MaxVisibleDropCount: Integer
    read f_MaxVisibleDropCount
    write f_MaxVisibleDropCount;
   property GrowDropTreeWidthByIcons: Boolean
    read f_GrowDropTreeWidthByIcons
    write f_GrowDropTreeWidthByIcons;
   property KeepLastDropWidth: Boolean
    read f_KeepLastDropWidth
    write f_KeepLastDropWidth;
   property ShowRoot: Boolean
    read pm_GetShowRoot
    write pm_SetShowRoot;
   property DropHeight: Integer
    read f_DropHeight
    write f_DropHeight;
   property DropWidth: Integer
    read f_DropWidth
    write f_DropWidth;
   property TreeImages: TCustomImageList
    read pm_GetTreeImages
    write pm_SetTreeImages
    stored TreeImagesStored;
   property CurrentNode: Il3SimpleNode
    read pm_GetCurrentNode
    write pm_SetCurrentNode;
   property TreeStruct: Il3SimpleTree
    read pm_GetTreeStruct
    write pm_SetTreeStruct;
   property IsList: Boolean
    read pm_GetIsList;
   property Tree: TSubTree
    read pm_GetTree;
 end;//TDropDownTreePrim

 //#UC START# *53EDF0B0003Dci*
 //#UC END# *53EDF0B0003Dci*
 //#UC START# *53EDF0B0003Dcit*
 //#UC END# *53EDF0B0003Dcit*
 TSubTree = class(TAbsSubTree)
  protected
   f_SubOwner: TDropDownTreePrim;
  private
   procedure WMSetFocus(var Message: TMessage); message WM_SETFOCUS;
   procedure WMExitSizeMove(var Message: TMessage); message WM_EXITSIZEMOVE;
   procedure WMEnterSizeMove(var Message: TMessage); message WM_ENTERSIZEMOVE;
  protected
   function IsSizeableTree: Boolean; override;
   function IsShowGripper: Boolean; override;
   function IsList: Boolean; override;
   function IsInvert: Boolean; override;
   function IsOwnerAssigned: Boolean; override;
   function GetWidth: Integer; override;
   procedure DoChanged; override;
   function GetMinVisibleDropCount: Integer; override;
   function GetMaxVisibleDropCount: Integer; override;
  public
   constructor Create(aOwner: TDropDownTreePrim); reintroduce;
 //#UC START# *53EDF0B0003Dpubl*
   property AllowWithoutCurrent;
 //#UC END# *53EDF0B0003Dpubl*
 end;//TSubTree

 //#UC START# *53F1DC8F01ADci*
 //#UC END# *53F1DC8F01ADci*
 //#UC START# *53F1DC8F01ADcit*
 //#UC END# *53F1DC8F01ADcit*
 TDropDownTree = class(TDropDownTreePrim)
 //#UC START# *53F1DC8F01ADpubl*
 protected
  property SizeableTree default True;
  property ShowGripper default True;
 public
  property AdjustDropDownPos default False;
  property DropHeight default 0;
  property DropWidth default 0;
  property IsList default False;
  property ShowRoot default False;
 published
  property Cursor stored CursorStored;
  property OnGetItemImage;
  property OnChange;
 //#UC END# *53F1DC8F01ADpubl*
 end;//TDropDownTree

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MinMax
 , afwFacade
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3ListenersManager
 //#UC START# *53F1DC8F01ADimpl_uses*
 //#UC END# *53F1DC8F01ADimpl_uses*
;

procedure TDropDownTreePrim.pm_SetSizeableTree(aValue: Boolean);
//#UC START# *53EDFEBC01FA_4831599C0300set_var*
//#UC END# *53EDFEBC01FA_4831599C0300set_var*
begin
//#UC START# *53EDFEBC01FA_4831599C0300set_impl*
 if (f_SizeableTree <> aValue) and (ComboStyle <> ct_cbEdit) then
 begin
  f_SizeableTree := aValue;
  Tree.RecreateTree;
 end;//FSizeableTree <> aValue
//#UC END# *53EDFEBC01FA_4831599C0300set_impl*
end;//TDropDownTreePrim.pm_SetSizeableTree

procedure TDropDownTreePrim.pm_SetShowGripper(aValue: Boolean);
//#UC START# *53EDFEE9025C_4831599C0300set_var*
//#UC END# *53EDFEE9025C_4831599C0300set_var*
begin
//#UC START# *53EDFEE9025C_4831599C0300set_impl*
 if (f_ShowGripper <> aValue) and (ComboStyle <> ct_cbEdit) then
 begin
  f_ShowGripper := aValue;
  Tree.RecreateTree;
 end;//FShowGripper <> aValue
//#UC END# *53EDFEE9025C_4831599C0300set_impl*
end;//TDropDownTreePrim.pm_SetShowGripper

procedure TDropDownTreePrim.pm_SetOnGetItemImage(aValue: Tl3GetItemImage);
//#UC START# *53EDFF4400C0_4831599C0300set_var*
//#UC END# *53EDFF4400C0_4831599C0300set_var*
begin
//#UC START# *53EDFF4400C0_4831599C0300set_impl*
 f_OnGetItemImage := aValue;
 ShowIcons := Assigned(aValue);
//#UC END# *53EDFF4400C0_4831599C0300set_impl*
end;//TDropDownTreePrim.pm_SetOnGetItemImage

function TDropDownTreePrim.pm_GetShowRoot: Boolean;
//#UC START# *53EE003E0191_4831599C0300get_var*
//#UC END# *53EE003E0191_4831599C0300get_var*
begin
//#UC START# *53EE003E0191_4831599C0300get_impl*
 if (ComboStyle <> ct_cbEdit) then
  Result := Tree.ShowRoot
 else
  Result := False;
//#UC END# *53EE003E0191_4831599C0300get_impl*
end;//TDropDownTreePrim.pm_GetShowRoot

procedure TDropDownTreePrim.pm_SetShowRoot(aValue: Boolean);
//#UC START# *53EE003E0191_4831599C0300set_var*
//#UC END# *53EE003E0191_4831599C0300set_var*
begin
//#UC START# *53EE003E0191_4831599C0300set_impl*
 if ComboStyle <> ct_cbEdit then
  Tree.ShowRoot := aValue;
//#UC END# *53EE003E0191_4831599C0300set_impl*
end;//TDropDownTreePrim.pm_SetShowRoot

function TDropDownTreePrim.pm_GetShowIcons: Boolean;
//#UC START# *53EE005F008B_4831599C0300get_var*
//#UC END# *53EE005F008B_4831599C0300get_var*
begin
//#UC START# *53EE005F008B_4831599C0300get_impl*
 if (ComboStyle <> ct_cbEdit) then
  Result := voShowIcons in Tree.ViewOptions
 else
  Result := False;
//#UC END# *53EE005F008B_4831599C0300get_impl*
end;//TDropDownTreePrim.pm_GetShowIcons

procedure TDropDownTreePrim.pm_SetShowIcons(aValue: Boolean);
//#UC START# *53EE005F008B_4831599C0300set_var*
//#UC END# *53EE005F008B_4831599C0300set_var*
begin
//#UC START# *53EE005F008B_4831599C0300set_impl*
 if (ComboStyle <> ct_cbEdit) then
 begin
  if aValue then
   Tree.ViewOptions := Tree.ViewOptions + [voShowIcons]
  else
   Tree.ViewOptions := Tree.ViewOptions - [voShowIcons];
 end;//ComboStyle <> ct_cbEdit
//#UC END# *53EE005F008B_4831599C0300set_impl*
end;//TDropDownTreePrim.pm_SetShowIcons

function TDropDownTreePrim.pm_GetTreeImages: TCustomImageList;
//#UC START# *53EE01CD00F4_4831599C0300get_var*
//#UC END# *53EE01CD00F4_4831599C0300get_var*
begin
//#UC START# *53EE01CD00F4_4831599C0300get_impl*
 if ComboStyle <> ct_cbEdit then
  Result := Tree.Images
 else
  Result := nil;
//#UC END# *53EE01CD00F4_4831599C0300get_impl*
end;//TDropDownTreePrim.pm_GetTreeImages

procedure TDropDownTreePrim.pm_SetTreeImages(aValue: TCustomImageList);
//#UC START# *53EE01CD00F4_4831599C0300set_var*
//#UC END# *53EE01CD00F4_4831599C0300set_var*
begin
//#UC START# *53EE01CD00F4_4831599C0300set_impl*
 if ComboStyle <> ct_cbEdit then
  Tree.Images := aValue
//#UC END# *53EE01CD00F4_4831599C0300set_impl*
end;//TDropDownTreePrim.pm_SetTreeImages

function TDropDownTreePrim.pm_GetCurrentNode: Il3SimpleNode;
//#UC START# *53EE02C3009D_4831599C0300get_var*
//#UC END# *53EE02C3009D_4831599C0300get_var*
begin
//#UC START# *53EE02C3009D_4831599C0300get_impl*
 if ComboStyle <> ct_cbEdit then
  Result := Tree.GetCurrentNode
 else
  Result := nil;
//#UC END# *53EE02C3009D_4831599C0300get_impl*
end;//TDropDownTreePrim.pm_GetCurrentNode

procedure TDropDownTreePrim.pm_SetCurrentNode(const aValue: Il3SimpleNode);
//#UC START# *53EE02C3009D_4831599C0300set_var*
//#UC END# *53EE02C3009D_4831599C0300set_var*
begin
//#UC START# *53EE02C3009D_4831599C0300set_impl*
//#UC END# *53EE02C3009D_4831599C0300set_impl*
end;//TDropDownTreePrim.pm_SetCurrentNode

function TDropDownTreePrim.pm_GetTreeStruct: Il3SimpleTree;
//#UC START# *53EE0968005D_4831599C0300get_var*
//#UC END# *53EE0968005D_4831599C0300get_var*
begin
//#UC START# *53EE0968005D_4831599C0300get_impl*
 Result := Tree.TreeStruct;
//#UC END# *53EE0968005D_4831599C0300get_impl*
end;//TDropDownTreePrim.pm_GetTreeStruct

procedure TDropDownTreePrim.pm_SetTreeStruct(const aValue: Il3SimpleTree);
//#UC START# *53EE0968005D_4831599C0300set_var*
//#UC END# *53EE0968005D_4831599C0300set_var*
begin
//#UC START# *53EE0968005D_4831599C0300set_impl*
 if (ComboStyle <> ct_cbEdit) then
  Tree.TreeStruct := aValue;
//#UC END# *53EE0968005D_4831599C0300set_impl*
end;//TDropDownTreePrim.pm_SetTreeStruct

function TDropDownTreePrim.pm_GetIsList: Boolean;
//#UC START# *53F1D483009C_4831599C0300get_var*
//#UC END# *53F1D483009C_4831599C0300get_var*
begin
//#UC START# *53F1D483009C_4831599C0300get_impl*
 Result := False;
//#UC END# *53F1D483009C_4831599C0300get_impl*
end;//TDropDownTreePrim.pm_GetIsList

function TDropDownTreePrim.pm_GetTree: TSubTree;
//#UC START# *53F2095303D0_4831599C0300get_var*
//#UC END# *53F2095303D0_4831599C0300get_var*
begin
//#UC START# *53F2095303D0_4831599C0300get_impl*
 if f_Tree = nil then
  RecreateTreeIfNeeded(ComboStyle);
 Result := f_Tree;
//#UC END# *53F2095303D0_4831599C0300get_impl*
end;//TDropDownTreePrim.pm_GetTree

procedure TDropDownTreePrim.RecreateTreeIfNeeded(aValue: TComboStyle);
//#UC START# *53EE012C0211_4831599C0300_var*
//#UC END# *53EE012C0211_4831599C0300_var*
begin
//#UC START# *53EE012C0211_4831599C0300_impl*
 FreeAndNil(f_Tree);
 if aValue <> ct_cbEdit then
  f_Tree := CreateSubTree;
//#UC END# *53EE012C0211_4831599C0300_impl*
end;//TDropDownTreePrim.RecreateTreeIfNeeded

function TDropDownTreePrim.CreateSubTree: TSubTree;
//#UC START# *53EE01540251_4831599C0300_var*
//#UC END# *53EE01540251_4831599C0300_var*
begin
//#UC START# *53EE01540251_4831599C0300_impl*
 Result := TSubTree.Create(Self);
//#UC END# *53EE01540251_4831599C0300_impl*
end;//TDropDownTreePrim.CreateSubTree

function TDropDownTreePrim.CursorStored: Boolean;
//#UC START# *53EE08DF03BA_4831599C0300_var*
//#UC END# *53EE08DF03BA_4831599C0300_var*
begin
//#UC START# *53EE08DF03BA_4831599C0300_impl*
 Result := (Cursor <> crIBeam);
//#UC END# *53EE08DF03BA_4831599C0300_impl*
end;//TDropDownTreePrim.CursorStored

function TDropDownTreePrim.EstimateTreeHeight(aMinSize: Integer;
 aMaxSize: Integer): Integer;
//#UC START# *53EE09AA0268_4831599C0300_var*
//#UC END# *53EE09AA0268_4831599C0300_var*
begin
//#UC START# *53EE09AA0268_4831599C0300_impl*
 Result := 100;
//#UC END# *53EE09AA0268_4831599C0300_impl*
end;//TDropDownTreePrim.EstimateTreeHeight

function TDropDownTreePrim.EstimateTreeWidth(aMaxSizeX: Integer;
 aSizeY: Integer): Integer;
//#UC START# *53EE09D70249_4831599C0300_var*
//#UC END# *53EE09D70249_4831599C0300_var*
begin
//#UC START# *53EE09D70249_4831599C0300_impl*
 Result := Width;
//#UC END# *53EE09D70249_4831599C0300_impl*
end;//TDropDownTreePrim.EstimateTreeWidth

procedure TDropDownTreePrim.CalcDropDimensions;
//#UC START# *53EE0A060099_4831599C0300_var*
var
 l_Point: TPoint;
 l_MaxWidth: integer;
//#UC END# *53EE0A060099_4831599C0300_var*
begin
//#UC START# *53EE0A060099_4831599C0300_impl*
 l_Point := ClientToScreen(Point(0, 0));

 if (Screen.DesktopLeft + Screen.DesktopWidth) > (l_Point.X + Width) then
  l_MaxWidth := Screen.DesktopLeft + Screen.DesktopWidth - l_Point.X
 else
  l_MaxWidth := -1;

 if f_CalcDimensions then
 begin
  if (f_DropHeight=0) then begin
   f_DropHeight := EstimateTreeHeight(Tree.GetMinSizeY, Tree.GetMaxSizeY);
   Inc(f_DropHeight, Tree.getBorderSize);
  end;
  if not f_KeepLastDropWidth then
   f_DropWidth := EstimateTreeWidth(l_MaxWidth, f_DropHeight);
  f_KeepLastDropWidth := False;
  f_CalcDimensions := False;
 end;

 if f_DropWidth > l_MaxWidth then
  f_DropWidth := l_MaxWidth;
{  if f_DropWidth < Width then
  f_DropWidth := Width; }
//#UC END# *53EE0A060099_4831599C0300_impl*
end;//TDropDownTreePrim.CalcDropDimensions

procedure TDropDownTreePrim.DropSessionSettings;
//#UC START# *53EE0A11020D_4831599C0300_var*
//#UC END# *53EE0A11020D_4831599C0300_var*
begin
//#UC START# *53EE0A11020D_4831599C0300_impl*
 f_CalcDimensions := True;
//#UC END# *53EE0A11020D_4831599C0300_impl*
end;//TDropDownTreePrim.DropSessionSettings

function TDropDownTreePrim.CalcGrowingWidth: Integer;
//#UC START# *53EE0A28005A_4831599C0300_var*
var
 DR: TRect;
//#UC END# *53EE0A28005A_4831599C0300_var*
begin
//#UC START# *53EE0A28005A_4831599C0300_impl*
 if Tree.Current > -1 then
 begin
  DR := Tree.GetDrawRect(Tree.Current);
  Result := Tree.GetItemTextIndent(Tree.Current, DR.Bottom - DR.Top);
 end
 else
 if Tree.Total > 0 then
 begin
  DR := Tree.GetDrawRect(Tree.TopIndex);
  Result := Tree.GetItemTextIndent(Tree.TopIndex, DR.Bottom - DR.Top);
 end
 else
  Result := 0;
//#UC END# *53EE0A28005A_4831599C0300_impl*
end;//TDropDownTreePrim.CalcGrowingWidth

procedure TDropDownTreePrim.TreeChangedNotification;
//#UC START# *53EE0A3D023F_4831599C0300_var*
//#UC END# *53EE0A3D023F_4831599C0300_var*
begin
//#UC START# *53EE0A3D023F_4831599C0300_impl*
//#UC END# *53EE0A3D023F_4831599C0300_impl*
end;//TDropDownTreePrim.TreeChangedNotification

procedure TDropDownTreePrim.ActionElementHandler(Sender: TObject;
 Index: LongInt);
//#UC START# *53EE0A5601CD_4831599C0300_var*
//#UC END# *53EE0A5601CD_4831599C0300_var*
begin
//#UC START# *53EE0A5601CD_4831599C0300_impl*
 Dropped := False;
//     afw.ProcessMessages; нельзя :(
 afw.BeginOp;
 try
  ProcessTreeSelect(True, True);
 finally
  afw.EndOp;
 end;
//#UC END# *53EE0A5601CD_4831599C0300_impl*
end;//TDropDownTreePrim.ActionElementHandler

procedure TDropDownTreePrim.ProcessTreeSelect(ChooseFromTree: Boolean;
 aTriggerSelect: Boolean);
//#UC START# *53EE0A730393_4831599C0300_var*
//#UC END# *53EE0A730393_4831599C0300_var*
begin
//#UC START# *53EE0A730393_4831599C0300_impl*
//#UC END# *53EE0A730393_4831599C0300_impl*
end;//TDropDownTreePrim.ProcessTreeSelect

function TDropDownTreePrim.GetItemImageHandler(Sender: TObject;
 anIndex: Integer;
 var aImages: TCustomImageList): Integer;
//#UC START# *53EE0AD700F8_4831599C0300_var*
//#UC END# *53EE0AD700F8_4831599C0300_var*
begin
//#UC START# *53EE0AD700F8_4831599C0300_impl*
 Result := -1;
 if Assigned(f_OnGetItemImage) then
  Result := f_OnGetItemImage(Self, anIndex, aImages);
//#UC END# *53EE0AD700F8_4831599C0300_impl*
end;//TDropDownTreePrim.GetItemImageHandler

procedure TDropDownTreePrim.CustomDoEnter;
//#UC START# *53F1DB47024C_4831599C0300_var*
//#UC END# *53F1DB47024C_4831599C0300_var*
begin
//#UC START# *53F1DB47024C_4831599C0300_impl*
//#UC END# *53F1DB47024C_4831599C0300_impl*
end;//TDropDownTreePrim.CustomDoEnter

function TDropDownTreePrim.InnerPoint(const aPoint: TPoint): Boolean;
//#UC START# *53F1DB6200C6_4831599C0300_var*
var
 l_Rect: TRect;
//#UC END# *53F1DB6200C6_4831599C0300_var*
begin
//#UC START# *53F1DB6200C6_4831599C0300_impl*
 Result := True;
 GetWindowRect(Handle, l_Rect);
 if PtInRect(l_Rect, aPoint) then
  Exit;
 GetWindowRect(Tree.Handle, l_Rect);
 if PtInRect(l_Rect, aPoint) then
  Exit;
 Result := False;
//#UC END# *53F1DB6200C6_4831599C0300_impl*
end;//TDropDownTreePrim.InnerPoint

function TDropDownTreePrim.IsInnerControl(aHandle: THandle): Boolean;
//#UC START# *53F1DB7F0036_4831599C0300_var*
//#UC END# *53F1DB7F0036_4831599C0300_var*
begin
//#UC START# *53F1DB7F0036_4831599C0300_impl*
 Result := (aHandle = Handle) or (aHandle = Tree.Handle);
//#UC END# *53F1DB7F0036_4831599C0300_impl*
end;//TDropDownTreePrim.IsInnerControl

procedure TDropDownTreePrim.WMLButtonDown(var Message: TWMLButtonDown);
//#UC START# *53EE177B02C6_4831599C0300_var*
//#UC END# *53EE177B02C6_4831599C0300_var*
begin
//#UC START# *53EE177B02C6_4831599C0300_impl*
 if (ComboStyle in ReadOnlyComboStyles) then
 begin
  SendCancelMode(Self);
  if csClickEvents in ControlStyle then
   ControlState := ControlState + [csClicked];
  if not (csNoStdEvents in ControlStyle) then
   with Message do
    MouseDown(mbLeft, KeysToShiftState(Keys), XPos, YPos);
  TriggerDropCloseEvent(not Dropped);
  Dropped := not Dropped;
  SendMessage(Handle, EM_SETSEL, -1, -1);
 end//ComboStyle in ReadOnlyComboStyles
 else
  inherited;
//#UC END# *53EE177B02C6_4831599C0300_impl*
end;//TDropDownTreePrim.WMLButtonDown

procedure TDropDownTreePrim.WMLButtonUp(var Message: TWMLButtonDown);
//#UC START# *53EE183B0353_4831599C0300_var*
//#UC END# *53EE183B0353_4831599C0300_var*
begin
//#UC START# *53EE183B0353_4831599C0300_impl*
 if (ComboStyle in ReadOnlyComboStyles) then
 begin
  with Message do
   MouseUp(mbLeft, KeysToShiftState(Keys), XPos, YPos);
  SendMessage(Handle, EM_SETSEL, -1, -1);
 end//ComboStyle in ReadOnlyComboStyles
 else
  inherited;
//#UC END# *53EE183B0353_4831599C0300_impl*
end;//TDropDownTreePrim.WMLButtonUp

procedure TDropDownTreePrim.WMKillFocus(var Message: TWMKillFocus);
//#UC START# *53EE188E031B_4831599C0300_var*
//#UC END# *53EE188E031B_4831599C0300_var*
begin
//#UC START# *53EE188E031B_4831599C0300_impl*
 if not (csDestroying in ComponentState) and
   ((ComboStyle = ct_cbEdit) or
   ((Message.FocusedWnd<>Tree.Handle) and
   (Message.FocusedWnd<>Self.Handle))) then 
  inherited;
//#UC END# *53EE188E031B_4831599C0300_impl*
end;//TDropDownTreePrim.WMKillFocus

procedure TDropDownTreePrim.WMSetFocus(var Message: TWMSetFocus);
//#UC START# *53EE191B004A_4831599C0300_var*
//#UC END# *53EE191B004A_4831599C0300_var*
begin
//#UC START# *53EE191B004A_4831599C0300_impl*
  // Tree.WMSetFocus вызывает SetFocus этого объекта
  if (ComboStyle = ct_cbEdit) or
     ((Message.FocusedWnd<>Tree.Handle) and (Message.FocusedWnd<>Handle)) and
     not (cmFocusing in CurrentMode) then
   CustomDoEnter;
  inherited;
//#UC END# *53EE191B004A_4831599C0300_impl*
end;//TDropDownTreePrim.WMSetFocus

procedure TDropDownTreePrim.CMArtfulBehaviour(var Message: TMessage);
//#UC START# *53EE192E02CD_4831599C0300_var*
var
 N: Integer;
 lItemPart : Byte;
 Pt: TPoint;
//#UC END# *53EE192E02CD_4831599C0300_var*
begin
//#UC START# *53EE192E02CD_4831599C0300_impl*
 if not Assigned(Tree) then
  Exit;
 Pt := Point(Message.wParam, Message.lParam);
 Tree.HitTest(Pt, N, lItemPart, False);
 if (lItemPart in [ihtText, ihtIcon, ihtPickIcon, ihtOpenChip]) then
 begin
  Dropped := False;
  afw.ProcessMessages;
  ProcessTreeSelect(True, True);
 end;//lItemPart=ihtText
//#UC END# *53EE192E02CD_4831599C0300_impl*
end;//TDropDownTreePrim.CMArtfulBehaviour

function TDropDownTreePrim.TreeImagesStored: Boolean;
 {* Функция определяющая, что свойство TreeImages сохраняется }
//#UC START# *53EE01CD00F4Stored_4831599C0300_var*
//#UC END# *53EE01CD00F4Stored_4831599C0300_var*
begin
//#UC START# *53EE01CD00F4Stored_4831599C0300_impl*
 if ComboStyle <> ct_cbEdit then
  Result := Tree.ImagesStored
 else
  Result := False;
//#UC END# *53EE01CD00F4Stored_4831599C0300_impl*
end;//TDropDownTreePrim.TreeImagesStored

function TDropDownTreePrim.GetActiveSub: TWinControl;
//#UC START# *53EDCF91019F_4831599C0300_var*
//#UC END# *53EDCF91019F_4831599C0300_var*
begin
//#UC START# *53EDCF91019F_4831599C0300_impl*
 Result := Tree;
//#UC END# *53EDCF91019F_4831599C0300_impl*
end;//TDropDownTreePrim.GetActiveSub

function TDropDownTreePrim.GetTreeHandle: THandle;
//#UC START# *573F0DAA02BB_4831599C0300_var*
//#UC END# *573F0DAA02BB_4831599C0300_var*
begin
//#UC START# *573F0DAA02BB_4831599C0300_impl*
 if Assigned(Tree) and Tree.HandleAllocated then
  Result := Tree.Handle
 else
  Result := 0;
//#UC END# *573F0DAA02BB_4831599C0300_impl*
end;//TDropDownTreePrim.GetTreeHandle

procedure TDropDownTreePrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4831599C0300_var*
//#UC END# *479731C50290_4831599C0300_var*
begin
//#UC START# *479731C50290_4831599C0300_impl*
 FreeAndNil(f_Tree);
 inherited;
//#UC END# *479731C50290_4831599C0300_impl*
end;//TDropDownTreePrim.Cleanup

constructor TDropDownTreePrim.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4831599C0300_var*
//#UC END# *47D1602000C6_4831599C0300_var*
begin
//#UC START# *47D1602000C6_4831599C0300_impl*
 inherited Create(AOwner);
 Cursor := crIBeam;
 f_Invert := False;

 f_DropHeight := 0;
 f_DropWidth := 0;
 f_SizeableTree := True;
 f_ShowGripper := True;
 ReadOnly := False;
 f_CalcDimensions := True;
//#UC END# *47D1602000C6_4831599C0300_impl*
end;//TDropDownTreePrim.Create

function TDropDownTreePrim.GetPaintSelection: InevRange;
//#UC START# *482BFC2E0363_4831599C0300_var*
var
 l_S, l_F: InevBasePoint;  
//#UC END# *482BFC2E0363_4831599C0300_var*
begin
//#UC START# *482BFC2E0363_4831599C0300_impl*
 if not Enabled or ((ComboStyle = ct_cbDropDownList) and not Focused) then
  Result := nil
 else
 begin
  Result := inherited GetPaintSelection;
  if (Result <> nil) and Result.Solid(View) then
  begin
   Result.GetBorderPoints(l_S, l_F);
   if (l_F <> nil) and (l_F.MostInner <> nil) then
    l_F.MostInner.SetAtEnd(View, False);
  end;//(Result <> nil) AND Result.Solid(View)
 end;//not Enabled..
//#UC END# *482BFC2E0363_4831599C0300_impl*
end;//TDropDownTreePrim.GetPaintSelection

procedure TDropDownTreePrim.pm_SetDropped(aValue: Boolean);
//#UC START# *53ECD12B0045_4831599C0300set_var*
var
 P, P1: TPoint;
 PF: TCustomForm;
 l_Delta: Integer;
 l_MonitorRect: TRect;
 l_DropWidth: Integer;
//#UC END# *53ECD12B0045_4831599C0300set_var*
begin
//#UC START# *53ECD12B0045_4831599C0300set_impl*
 if (Dropped <> aValue) and (ComboStyle <> ct_cbEdit) then
 begin
  inherited;
  if (aValue = True) and (not Focused) and (not Tree.Focused) and
     not (cmButtonClick in CurrentMode) then
   Exit;

  if aValue then
  begin
   CalcDropDimensions;

   Tree.Height := f_DropHeight;
   if f_DropWidth < Width then
    Tree.Width := Width
   else
    Tree.Width := f_DropWidth;

   P := Point(Left, Top + Height);
   P := Parent.ClientToScreen(P);

   if GrowDropTreeWidthByIcons then
   begin
    l_Delta := CalcGrowingWidth;
    l_MonitorRect := Screen.MonitorFromPoint(P).WorkareaRect;
    Dec(P.X, l_Delta);

    l_DropWidth := Tree.Width;
    if l_DropWidth < Width + 2 * l_Delta then
     l_DropWidth := Width + 2 * l_Delta;
    if (P.X + l_DropWidth) > l_MonitorRect.Right then
     Dec(l_DropWidth, (P.X + l_DropWidth) - l_MonitorRect.Right);

    Tree.Width := l_DropWidth;
   end;//GrowDropTreeWidthByIcons

   f_IgnoreFocus := True;
   try
    if (P.Y + Tree.Height > Screen.Height) and
       ((Screen.Height - P.Y) < ClientToScreen(Point(Left, Top)).Y) then
    begin
     if f_Invert <> True then begin
       f_Invert := True;
       Tree.RecreateTree;
     end;
     P.Y := P.Y - Tree.Height - Height;
    end//P.Y + Tree.Height > Screen.Height..
    else
    if (f_Invert <> False) then
    begin
     f_Invert := False;
     Tree.RecreateTree;
    end;//f_Invert <> False
    if AdjustDropDownPos then
    begin
      PF := GetParentForm(Self);
      P1 := Point(0, PF.ClientHeight);
      P1 := PF.ClientToScreen(P1);
      if (P.Y + Tree.Height > P1.y) then
      begin
       P1 := Point(0, 0);
       P1 := PF.ClientToScreen(P1);
       if (P.Y - Height - Tree.Height >= P1.y) then
         P.Y := P.Y - Height - Tree.Height;
      end;//Y + Tree.Height > P1.y
    end;//AdjustDropDownPos
    f_IgnoreDrop := True;
    try
     SetWindowPos(Tree.Handle,
                  HWND_TOPMOST, P.x, P.y, 0, 0,
                  SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
     Tree.Visible := True;
     SetFocus;
    finally
     f_IgnoreDrop := False;
    end;//try..finally
   finally
    f_IgnoreFocus := False;
   end;//try..finally
  end//aValue
  else
  begin
   f_IgnoreDrop := True;
   try
    f_DropHeight := Tree.Height;
    f_IgnoreFocus := True;

    HideDropDown;

    f_IgnoreFocus := False;
   finally
    f_IgnoreDrop := False;
   end;//try..finally
  end;//aValue
 end//Dropped <> aValue
 else
 inherited;
//#UC END# *53ECD12B0045_4831599C0300set_impl*
end;//TDropDownTreePrim.pm_SetDropped

procedure TDropDownTreePrim.HideDropDown;
//#UC START# *53EDCFAF00AA_4831599C0300_var*
//#UC END# *53EDCFAF00AA_4831599C0300_var*
begin
//#UC START# *53EDCFAF00AA_4831599C0300_impl*
 inherited;
 if Assigned(Tree) and Tree.HandleAllocated then
 begin
  if Tree.Visible then
   Tree.Visible := False;
  SetWindowPos(Tree.Handle,
               HWND_NOTOPMOST,
               0, 0, 0, 0,
               SWP_NOMOVE or SWP_NOSIZE or SWP_HIDEWINDOW or SWP_NOACTIVATE);
 end;//Assigned(Tree)
 if Dropped then
  Dropped := False;
//#UC END# *53EDCFAF00AA_4831599C0300_impl*
end;//TDropDownTreePrim.HideDropDown

{$If NOT Defined(NoVCM)}
function TDropDownTreePrim.IvcmState_LoadState(const aState: IUnknown;
 aStateType: TvcmStateType): Boolean;
//#UC START# *54084F6B01FD_4831599C0300_var*
var
 l_State: IvcmState;
//#UC END# *54084F6B01FD_4831599C0300_var*
begin
//#UC START# *54084F6B01FD_4831599C0300_impl*
 // Безуспешная борьба с http://mdp.garant.ru/pages/viewpage.action?pageId=185828256
 if Supports(f_Tree, IvcmState, l_State) then
  // Supports никогда на самом деле не отработает ибо TSubTree не наследник TeeTreeViewExport
  Result := l_State.LoadState(aState, aStateType)
 else
  Result := False;
 //Result := inherited IvcmState_LoadState(aState, aStateType);
//#UC END# *54084F6B01FD_4831599C0300_impl*
end;//TDropDownTreePrim.IvcmState_LoadState
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TDropDownTreePrim.IvcmState_SaveState(out aState: IUnknown;
 aStateType: TvcmStateType): Boolean;
//#UC START# *54084FBC0018_4831599C0300_var*
var
 l_State: IvcmState;
//#UC END# *54084FBC0018_4831599C0300_var*
begin
//#UC START# *54084FBC0018_4831599C0300_impl*
 // Безуспешная борьба с http://mdp.garant.ru/pages/viewpage.action?pageId=185828256
 if Supports(f_Tree, IvcmState, l_State) then
  // Supports никогда на самом деле не отработает ибо TSubTree не наследник TeeTreeViewExport
  Result := (f_Tree as IvcmState).SaveState(aState, aStateType)
 else
  Result := False;
 //Result := inherited IvcmState_SaveState(aState, aStateType);
 // !! Если будешь здесь копаться, то читай и TAbstractDropDown.IvcmState_SaveState
//#UC END# *54084FBC0018_4831599C0300_impl*
end;//TDropDownTreePrim.IvcmState_SaveState
{$IfEnd} // NOT Defined(NoVCM)

constructor TSubTree.Create(aOwner: TDropDownTreePrim);
//#UC START# *53EDF2910311_53EDF0B0003D_var*
//#UC END# *53EDF2910311_53EDF0B0003D_var*
begin
//#UC START# *53EDF2910311_53EDF0B0003D_impl*
 inherited Create(nil);
 f_SubOwner := aOwner;
//#UC END# *53EDF2910311_53EDF0B0003D_impl*
end;//TSubTree.Create

procedure TSubTree.WMSetFocus(var Message: TMessage);
//#UC START# *53EDF23800FE_53EDF0B0003D_var*
  function IsTopForm: boolean;
  var
   l_Control: TControl;
  begin//IsTopForm
   Result := False;
   l_Control := f_SubOwner;
   while l_Control <> nil do
   begin
     if (l_Control is TForm) and
        ((l_Control as TForm).FormStyle = fsStayOnTop) then
     begin
       Result := True;
       Break;
     end;
     l_Control := l_Control.Parent;
   end;
  end;//IsTopForm
//#UC END# *53EDF23800FE_53EDF0B0003D_var*
begin
//#UC START# *53EDF23800FE_53EDF0B0003D_impl*
 f_SubOwner.CurrentMode := f_SubOwner.CurrentMode + [cmFocusing];
 if IsTopForm then
 begin
  Windows.SetFocus(Message.wParam);
  // иначе на OnTop формах окно уплывает на задний план
  SetWindowPos(Handle, HWND_TOPMOST, Left, Top, 0, 0, SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW );
 end
 else
  Windows.SetFocus(Message.wParam);
 f_SubOwner.CurrentMode := f_SubOwner.CurrentMode-[cmFocusing];
//#UC END# *53EDF23800FE_53EDF0B0003D_impl*
end;//TSubTree.WMSetFocus

procedure TSubTree.WMExitSizeMove(var Message: TMessage);
//#UC START# *53EDF25D0045_53EDF0B0003D_var*
//#UC END# *53EDF25D0045_53EDF0B0003D_var*
begin
//#UC START# *53EDF25D0045_53EDF0B0003D_impl*
 f_SubOwner.CurrentMode := f_SubOwner.CurrentMode + [cmFocusing];
// Windows.SetFocus(f_SubOwner.Handle);
// вроде лишнее.
 f_SubOwner.CurrentMode := f_SubOwner.CurrentMode - [cmFocusing];
 f_SubOwner.f_IgnoreFocus := False;
 f_SubOwner.DropWidth := Width;
 inherited;
//#UC END# *53EDF25D0045_53EDF0B0003D_impl*
end;//TSubTree.WMExitSizeMove

procedure TSubTree.WMEnterSizeMove(var Message: TMessage);
//#UC START# *53EDF26C0050_53EDF0B0003D_var*
//#UC END# *53EDF26C0050_53EDF0B0003D_var*
begin
//#UC START# *53EDF26C0050_53EDF0B0003D_impl*
 inherited;
 f_SubOwner.f_IgnoreFocus := True;
//#UC END# *53EDF26C0050_53EDF0B0003D_impl*
end;//TSubTree.WMEnterSizeMove

function TSubTree.IsSizeableTree: Boolean;
//#UC START# *5298BEBA032D_53EDF0B0003D_var*
//#UC END# *5298BEBA032D_53EDF0B0003D_var*
begin
//#UC START# *5298BEBA032D_53EDF0B0003D_impl*
 Result := f_SubOwner.SizeableTree;
//#UC END# *5298BEBA032D_53EDF0B0003D_impl*
end;//TSubTree.IsSizeableTree

function TSubTree.IsShowGripper: Boolean;
//#UC START# *5298BF130022_53EDF0B0003D_var*
//#UC END# *5298BF130022_53EDF0B0003D_var*
begin
//#UC START# *5298BF130022_53EDF0B0003D_impl*
 Result := f_SubOwner.ShowGripper;
//#UC END# *5298BF130022_53EDF0B0003D_impl*
end;//TSubTree.IsShowGripper

function TSubTree.IsList: Boolean;
//#UC START# *5298BF4D00FE_53EDF0B0003D_var*
//#UC END# *5298BF4D00FE_53EDF0B0003D_var*
begin
//#UC START# *5298BF4D00FE_53EDF0B0003D_impl*
 Result := f_SubOwner.IsList;
//#UC END# *5298BF4D00FE_53EDF0B0003D_impl*
end;//TSubTree.IsList

function TSubTree.IsInvert: Boolean;
//#UC START# *5298BF8700B0_53EDF0B0003D_var*
//#UC END# *5298BF8700B0_53EDF0B0003D_var*
begin
//#UC START# *5298BF8700B0_53EDF0B0003D_impl*
 Result := f_SubOwner.f_Invert;
//#UC END# *5298BF8700B0_53EDF0B0003D_impl*
end;//TSubTree.IsInvert

function TSubTree.IsOwnerAssigned: Boolean;
//#UC START# *5298BFDF0035_53EDF0B0003D_var*
//#UC END# *5298BFDF0035_53EDF0B0003D_var*
begin
//#UC START# *5298BFDF0035_53EDF0B0003D_impl*
 Result := Assigned(f_SubOwner);
//#UC END# *5298BFDF0035_53EDF0B0003D_impl*
end;//TSubTree.IsOwnerAssigned

function TSubTree.GetWidth: Integer;
//#UC START# *5298BFFA014B_53EDF0B0003D_var*
//#UC END# *5298BFFA014B_53EDF0B0003D_var*
begin
//#UC START# *5298BFFA014B_53EDF0B0003D_impl*
 Result := f_SubOwner.Width;
//#UC END# *5298BFFA014B_53EDF0B0003D_impl*
end;//TSubTree.GetWidth

procedure TSubTree.DoChanged;
//#UC START# *48BD5F8303C4_53EDF0B0003D_var*
//#UC END# *48BD5F8303C4_53EDF0B0003D_var*
begin
//#UC START# *48BD5F8303C4_53EDF0B0003D_impl*
 inherited DoChanged;
 if Assigned(f_SubOwner) then
  f_SubOwner.TreeChangedNotification;
//#UC END# *48BD5F8303C4_53EDF0B0003D_impl*
end;//TSubTree.DoChanged

function TSubTree.GetMinVisibleDropCount: Integer;
//#UC START# *5298C0580167_53EDF0B0003D_var*
//#UC END# *5298C0580167_53EDF0B0003D_var*
begin
//#UC START# *5298C0580167_53EDF0B0003D_impl*
 Result := Min(f_SubOwner.MaxVisibleDropCount, f_SubOwner.MinVisibleDropCount);
//#UC END# *5298C0580167_53EDF0B0003D_impl*
end;//TSubTree.GetMinVisibleDropCount

function TSubTree.GetMaxVisibleDropCount: Integer;
//#UC START# *5298C0CD00F1_53EDF0B0003D_var*
//#UC END# *5298C0CD00F1_53EDF0B0003D_var*
begin
//#UC START# *5298C0CD00F1_53EDF0B0003D_impl*
 Result := Max(f_SubOwner.MaxVisibleDropCount, f_SubOwner.MinVisibleDropCount);
//#UC END# *5298C0CD00F1_53EDF0B0003D_impl*
end;//TSubTree.GetMaxVisibleDropCount

//#UC START# *53EDF0B0003Dimpl*
//#UC END# *53EDF0B0003Dimpl*

//#UC START# *53F1DC8F01ADimpl*
//#UC END# *53F1DC8F01ADimpl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TDropDownTreePrim);
 {* Регистрация TDropDownTreePrim }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TSubTree);
 {* Регистрация TSubTree }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TDropDownTree);
 {* Регистрация TDropDownTree }
{$IfEnd} // NOT Defined(NoScripts)

end.
