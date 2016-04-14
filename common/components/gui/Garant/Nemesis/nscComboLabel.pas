unit nscComboLabel;
 {* Метка с выпадающим списком }

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscComboLabel.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TnscComboLabel" MUID: (5704F8CA00C8)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , nscImageLabel
 , l3Interfaces
 , Classes
 , l3TreeInterfaces
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , AbsSubTree
 , Graphics
 , Messages
 , l3Region
 , vtLister
;

type
 _RegionableControl_Parent_ = TAbsSubTree;
 {$Include w:\common\components\gui\Garant\SkinnedControls\RegionableControl.imp.pas}
 TnscLabelSubTree = class(_RegionableControl_)
  private
   f_HighLightItem: Integer;
    {* Подсвеченный мышью элемент }
   f_HighlightColor: TColor;
   f_OnCloseup: TNotifyEvent;
  private
   procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
   procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
   procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
   procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
  protected
   procedure pm_SetHighLightItem(aValue: Integer);
   procedure CloseUp(anAccept: Boolean);
   procedure Invalidate;
    {* Запрос на перерисовку. }
   function IsSizeableTree: Boolean; override;
   function IsShowGripper: Boolean; override;
   function IsList: Boolean; override;
   function IsInvert: Boolean; override;
   function IsOwnerAssigned: Boolean; override;
   function GetWidth: Integer; override;
   {$If NOT Defined(NoVCL)}
   procedure CreateParams(var Params: TCreateParams); override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure TuneRegion(aRegion: Tl3Region); override;
   procedure DoOnGetItemStyle(aItemIndex: Integer;
    const aFont: Il3Font;
    var aTextBackColor: TColor;
    var aItemBackColor: TColor;
    var aVJustify: TvtVJustify;
    var aFocused: Boolean;
    var theImageVertOffset: Integer); override;
   function DoOnGetItemIndent: Integer; override;
    {* функция определяет добавляемое свободное место до иконки элемента.
Если отступ в обработчике будет определен как нулевой, то по
умолчанию отступ делается на ширину иконки, если таковые имеются. }
   function NeedDrawArrowSelection(aItemIndex: Integer): Boolean; override;
   procedure NCDraw(aDC: hDC); override;
  public
   constructor Create(AOwner: TComponent); override;
  protected
   property OnCloseup: TNotifyEvent
    read f_OnCloseup
    write f_OnCloseup;
  public
   property HighLightItem: Integer
    read f_HighLightItem
    write pm_SetHighLightItem;
    {* Подсвеченный мышью элемент }
   property HighlightColor: TColor
    read f_HighlightColor
    write f_HighlightColor;
 end;//TnscLabelSubTree

 TnscComboLabel = class(TnscImageLabel, Il3WndProcListener, Il3MouseListener)
  {* Метка с выпадающим списком }
  private
   f_Dropped: Boolean;
   f_OnChange: TNotifyEvent;
   f_Tree: TnscLabelSubTree;
   f_CurrentItem: Integer;
  private
   procedure DoChanged;
   procedure TreeActionElement(Sender: TObject;
    Index: LongInt);
   procedure UpdateCaption;
   procedure TreeCloseUp(Sender: TObject);
  protected
   function pm_GetTree: TnscLabelSubTree;
   function pm_GetTreeStruct: Il3SimpleTree;
   procedure pm_SetTreeStruct(const aValue: Il3SimpleTree);
   procedure pm_SetCurrentItem(aValue: Integer);
   procedure MouseListenerNotify(aMouseMessage: WPARAM;
    aHookStruct: PMouseHookStruct;
    var theResult: Tl3HookProcResult);
   procedure WndProcListenerNotify(Msg: PCWPStruct;
    var theResult: Tl3HookProcResult);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCL)}
   procedure MouseUp(Button: TMouseButton;
    Shift: TShiftState;
    X: Integer;
    Y: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   constructor Create(AOwner: TComponent); override;
  private
   property Tree: TnscLabelSubTree
    read pm_GetTree;
  public
   property Dropped: Boolean
    read f_Dropped;
   property OnChange: TNotifyEvent
    read f_OnChange
    write f_OnChange;
   property TreeStruct: Il3SimpleTree
    read pm_GetTreeStruct
    write pm_SetTreeStruct;
   property CurrentItem: Integer
    read f_CurrentItem
    write pm_SetCurrentItem;
 end;//TnscComboLabel
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , l3String
 , l3MinMax
 , l3ControlsTypes
 , l3Defaults
 , l3Drawer
 , l3Units
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3ListenersManager
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Themes
 {$IfEnd} // NOT Defined(NoVCL)
;

{$Include w:\common\components\gui\Garant\SkinnedControls\RegionableControl.imp.pas}

procedure TnscLabelSubTree.pm_SetHighLightItem(aValue: Integer);
//#UC START# *57062DEC03CF_5704FC1A0398set_var*
var
 l_HighLightItem: Integer;
//#UC END# *57062DEC03CF_5704FC1A0398set_var*
begin
//#UC START# *57062DEC03CF_5704FC1A0398set_impl*
 if (aValue <> f_HighLightItem) then
 begin
  l_HighLightItem := f_HighLightItem;
  f_HighLightItem := aValue;
  InvalidateItem(l_HighLightItem);
  if (f_HighLightItem >= 0) then
   InvalidateItem(f_HighLightItem);
 end;
//#UC END# *57062DEC03CF_5704FC1A0398set_impl*
end;//TnscLabelSubTree.pm_SetHighLightItem

procedure TnscLabelSubTree.CloseUp(anAccept: Boolean);
//#UC START# *57078A99008F_5704FC1A0398_var*
//#UC END# *57078A99008F_5704FC1A0398_var*
begin
//#UC START# *57078A99008F_5704FC1A0398_impl*
 SetWindowPos(Handle, HWND_TOPMOST, Left, Top, 0, 0, SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
 Visible := False;
 if Assigned(f_OnCloseUp) then
  f_OnCloseUp(Self);
//#UC END# *57078A99008F_5704FC1A0398_impl*
end;//TnscLabelSubTree.CloseUp

procedure TnscLabelSubTree.WMMouseMove(var Message: TWMMouseMove);
//#UC START# *57062ECE024D_5704FC1A0398_var*
var
 l_CurrentMousePos: TPoint;
//#UC END# *57062ECE024D_5704FC1A0398_var*
begin
//#UC START# *57062ECE024D_5704FC1A0398_impl*
 l_CurrentMousePos := Point(Message.xPos, Message.yPos);
 if IsMouseMoved(l_CurrentMousePos) then
  HighLightItem := ItemAtPos(l_CurrentMousePos, False);
//#UC END# *57062ECE024D_5704FC1A0398_impl*
end;//TnscLabelSubTree.WMMouseMove

procedure TnscLabelSubTree.CMMouseLeave(var Message: TMessage);
//#UC START# *570664D202D8_5704FC1A0398_var*
//#UC END# *570664D202D8_5704FC1A0398_var*
begin
//#UC START# *570664D202D8_5704FC1A0398_impl*
 HighLightItem := -1;
//#UC END# *570664D202D8_5704FC1A0398_impl*
end;//TnscLabelSubTree.CMMouseLeave

procedure TnscLabelSubTree.WMNCCalcSize(var Message: TWMNCCalcSize);
//#UC START# *570664F001CF_5704FC1A0398_var*
const
 cFrameWidth = 3;
//#UC END# *570664F001CF_5704FC1A0398_var*
begin
//#UC START# *570664F001CF_5704FC1A0398_impl*
 inherited;
 Inc(Message.CalcSize_Params.rgrc[0].Top, cFrameWidth);
 Dec(Message.CalcSize_Params.rgrc[0].Bottom, cFrameWidth + 2);
 Inc(Message.CalcSize_Params.rgrc[0].Left, cFrameWidth + 2);
 Dec(Message.CalcSize_Params.rgrc[0].Right, cFrameWidth);
//#UC END# *570664F001CF_5704FC1A0398_impl*
end;//TnscLabelSubTree.WMNCCalcSize

procedure TnscLabelSubTree.WMKillFocus(var Message: TWMKillFocus);
//#UC START# *57067C0302FD_5704FC1A0398_var*
//#UC END# *57067C0302FD_5704FC1A0398_var*
begin
//#UC START# *57067C0302FD_5704FC1A0398_impl*
 inherited;
 //CloseUp(False);
//#UC END# *57067C0302FD_5704FC1A0398_impl*
end;//TnscLabelSubTree.WMKillFocus

procedure TnscLabelSubTree.Invalidate;
 {* Запрос на перерисовку. }
//#UC START# *46A5AA4B003C_5704FC1A0398_var*
//#UC END# *46A5AA4B003C_5704FC1A0398_var*
begin
//#UC START# *46A5AA4B003C_5704FC1A0398_impl*
 inherited;
//#UC END# *46A5AA4B003C_5704FC1A0398_impl*
end;//TnscLabelSubTree.Invalidate

function TnscLabelSubTree.IsSizeableTree: Boolean;
//#UC START# *5298BEBA032D_5704FC1A0398_var*
//#UC END# *5298BEBA032D_5704FC1A0398_var*
begin
//#UC START# *5298BEBA032D_5704FC1A0398_impl*
 Result := False;
//#UC END# *5298BEBA032D_5704FC1A0398_impl*
end;//TnscLabelSubTree.IsSizeableTree

function TnscLabelSubTree.IsShowGripper: Boolean;
//#UC START# *5298BF130022_5704FC1A0398_var*
//#UC END# *5298BF130022_5704FC1A0398_var*
begin
//#UC START# *5298BF130022_5704FC1A0398_impl*
 Result := False;
//#UC END# *5298BF130022_5704FC1A0398_impl*
end;//TnscLabelSubTree.IsShowGripper

function TnscLabelSubTree.IsList: Boolean;
//#UC START# *5298BF4D00FE_5704FC1A0398_var*
//#UC END# *5298BF4D00FE_5704FC1A0398_var*
begin
//#UC START# *5298BF4D00FE_5704FC1A0398_impl*
 Result := False;
//#UC END# *5298BF4D00FE_5704FC1A0398_impl*
end;//TnscLabelSubTree.IsList

function TnscLabelSubTree.IsInvert: Boolean;
//#UC START# *5298BF8700B0_5704FC1A0398_var*
//#UC END# *5298BF8700B0_5704FC1A0398_var*
begin
//#UC START# *5298BF8700B0_5704FC1A0398_impl*
 Result := False;
//#UC END# *5298BF8700B0_5704FC1A0398_impl*
end;//TnscLabelSubTree.IsInvert

function TnscLabelSubTree.IsOwnerAssigned: Boolean;
//#UC START# *5298BFDF0035_5704FC1A0398_var*
//#UC END# *5298BFDF0035_5704FC1A0398_var*
begin
//#UC START# *5298BFDF0035_5704FC1A0398_impl*
 Result := Assigned(Owner);
//#UC END# *5298BFDF0035_5704FC1A0398_impl*
end;//TnscLabelSubTree.IsOwnerAssigned

function TnscLabelSubTree.GetWidth: Integer;
//#UC START# *5298BFFA014B_5704FC1A0398_var*
//#UC END# *5298BFFA014B_5704FC1A0398_var*
begin
//#UC START# *5298BFFA014B_5704FC1A0398_impl*
 if Assigned(Owner) and (Owner is TControl) then
  Result := TControl(Owner).Width
 else
  Result := 200;
//#UC END# *5298BFFA014B_5704FC1A0398_impl*
end;//TnscLabelSubTree.GetWidth

constructor TnscLabelSubTree.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_5704FC1A0398_var*
//#UC END# *47D1602000C6_5704FC1A0398_var*
begin
//#UC START# *47D1602000C6_5704FC1A0398_impl*
 inherited;
 ControlStyle := ControlStyle - [csCaptureMouse];
 Visible := False;
 BorderStyle := bsSingle;
 ActionElementMode := l3_amSingleClick;
 IsShowLines := False;

 ViewOptions := [voShowOpenChip, voShowInterRowSpace, voShowSelectAsArrow, voDoNotShowFocusRect];
 MultiStrokeItem := False;
 SelfDrawNodes := True;
 SelectColor.TextColor := clWhite;
 SelectColor.BackColor := $b87140;
 SelectNonFocusColor.TextColor := clWhite;
 SelectNonFocusColor.BackColor := $b87140;
 f_HighLightItem := -1;
 HighlightColor := $fac88c
//#UC END# *47D1602000C6_5704FC1A0398_impl*
end;//TnscLabelSubTree.Create

{$If NOT Defined(NoVCL)}
procedure TnscLabelSubTree.CreateParams(var Params: TCreateParams);
//#UC START# *48C7925A02E5_5704FC1A0398_var*
//#UC END# *48C7925A02E5_5704FC1A0398_var*
begin
//#UC START# *48C7925A02E5_5704FC1A0398_impl*
 inherited;
 Params.Style := Params.Style and not WS_BORDER;
//#UC END# *48C7925A02E5_5704FC1A0398_impl*
end;//TnscLabelSubTree.CreateParams
{$IfEnd} // NOT Defined(NoVCL)

procedure TnscLabelSubTree.TuneRegion(aRegion: Tl3Region);
//#UC START# *4CC847800383_5704FC1A0398_var*
const
 cRad = 26;
var
 l_R: Tl3Region;
//#UC END# *4CC847800383_5704FC1A0398_var*
begin
//#UC START# *4CC847800383_5704FC1A0398_impl*
 l_R := Tl3Region.Create;
 try
  l_R.Rgn := CreateRoundRectRgn(0, 0, Width + 1, Height + 1, cRad, cRad);
  aRegion.Combine(l_R, RGN_OR);
  aRegion.CombineRect(l3SRect(Width - cRad, 0, Width, Height), RGN_OR);
  aRegion.CombineRect(l3SRect(0, 0, Width, cRad), RGN_OR);
 finally
  FreeAndNil(l_R);
 end;//try..fianlly
//#UC END# *4CC847800383_5704FC1A0398_impl*
end;//TnscLabelSubTree.TuneRegion

procedure TnscLabelSubTree.DoOnGetItemStyle(aItemIndex: Integer;
 const aFont: Il3Font;
 var aTextBackColor: TColor;
 var aItemBackColor: TColor;
 var aVJustify: TvtVJustify;
 var aFocused: Boolean;
 var theImageVertOffset: Integer);
//#UC START# *508F825303E4_5704FC1A0398_var*
//#UC END# *508F825303E4_5704FC1A0398_var*
begin
//#UC START# *508F825303E4_5704FC1A0398_impl*
 inherited;
 aVJustify := vt_vjBottom;
 if (aItemIndex <> Current) then
 begin
  aFont.ForeColor := $030303;
  if (aItemIndex = f_HighlightItem) then
  begin
   aTextBackColor := f_HighlightColor;
   aItemBackColor := f_HighlightColor;
  end;
 end;
//#UC END# *508F825303E4_5704FC1A0398_impl*
end;//TnscLabelSubTree.DoOnGetItemStyle

function TnscLabelSubTree.DoOnGetItemIndent: Integer;
 {* функция определяет добавляемое свободное место до иконки элемента.
Если отступ в обработчике будет определен как нулевой, то по
умолчанию отступ делается на ширину иконки, если таковые имеются. }
//#UC START# *5151AF650239_5704FC1A0398_var*
//#UC END# *5151AF650239_5704FC1A0398_var*
begin
//#UC START# *5151AF650239_5704FC1A0398_impl*
 Result := 0;
//#UC END# *5151AF650239_5704FC1A0398_impl*
end;//TnscLabelSubTree.DoOnGetItemIndent

function TnscLabelSubTree.NeedDrawArrowSelection(aItemIndex: Integer): Boolean;
//#UC START# *5266253D035D_5704FC1A0398_var*
//#UC END# *5266253D035D_5704FC1A0398_var*
begin
//#UC START# *5266253D035D_5704FC1A0398_impl*
 Result := inherited NeedDrawArrowSelection(aItemIndex) or (aItemIndex = f_HighLightItem);
//#UC END# *5266253D035D_5704FC1A0398_impl*
end;//TnscLabelSubTree.NeedDrawArrowSelection

procedure TnscLabelSubTree.NCDraw(aDC: hDC);
//#UC START# *5298C02D03B3_5704FC1A0398_var*
const
 cFrameWidth = 3;
 cRad = 26;
var
 l_D: Tl3Drawer;
 l_Rgn: hRgn;
 l_FW: Integer;
//#UC END# *5298C02D03B3_5704FC1A0398_var*
begin
//#UC START# *5298C02D03B3_5704FC1A0398_impl*
 inherited;
 l_Rgn := CreateRectRgn(0,0,0,0);
 try
  GetWindowRgn(Self.Handle, l_Rgn);
  l_D := Tl3Drawer.Create(aDC);
  try
   l_FW := cFrameWidth + 3;
   l_D.FrameRegion(l_Rgn, l_FW, Self.Color);
   l_D.DrawArc(0 + l_FW - 1, Height - cRad - l_FW{ + 1}, cRad, cRad, 90, 90, l_FW + 1, Self.Color);
   l_FW := cFrameWidth - 1;
   l_D.FrameRegion(l_Rgn, l_FW, $d0ba9d);
   l_D.DrawArc(0 + l_FW - 1, Height - cRad - l_FW{ + 1}, cRad, cRad, 90, 90, l_FW + 1, $d0ba9d);
  finally
   FreeAndNil(l_D);
  end;//try..finally
 finally
  DeleteObject(l_Rgn);
 end;//try..finally
//#UC END# *5298C02D03B3_5704FC1A0398_impl*
end;//TnscLabelSubTree.NCDraw

function TnscComboLabel.pm_GetTree: TnscLabelSubTree;
//#UC START# *5704FCF60069_5704F8CA00C8get_var*
//#UC END# *5704FCF60069_5704F8CA00C8get_var*
begin
//#UC START# *5704FCF60069_5704F8CA00C8get_impl*
 if not Assigned(f_Tree) then
 begin
  f_Tree := TnscLabelSubTree.Create(Self);
  f_Tree.OnActionElement := TreeActionElement;
  f_Tree.OnCloseUp := TreeCloseUp;
 end;
 Result := f_Tree;
//#UC END# *5704FCF60069_5704F8CA00C8get_impl*
end;//TnscComboLabel.pm_GetTree

function TnscComboLabel.pm_GetTreeStruct: Il3SimpleTree;
//#UC START# *5704FDF001B3_5704F8CA00C8get_var*
//#UC END# *5704FDF001B3_5704F8CA00C8get_var*
begin
//#UC START# *5704FDF001B3_5704F8CA00C8get_impl*
 Result := Tree.TreeStruct;
//#UC END# *5704FDF001B3_5704F8CA00C8get_impl*
end;//TnscComboLabel.pm_GetTreeStruct

procedure TnscComboLabel.pm_SetTreeStruct(const aValue: Il3SimpleTree);
//#UC START# *5704FDF001B3_5704F8CA00C8set_var*
//#UC END# *5704FDF001B3_5704F8CA00C8set_var*
begin
//#UC START# *5704FDF001B3_5704F8CA00C8set_impl*
 Tree.TreeStruct := aValue;
//#UC END# *5704FDF001B3_5704F8CA00C8set_impl*
end;//TnscComboLabel.pm_SetTreeStruct

procedure TnscComboLabel.pm_SetCurrentItem(aValue: Integer);
//#UC START# *570685C4031F_5704F8CA00C8set_var*
//#UC END# *570685C4031F_5704F8CA00C8set_var*
begin
//#UC START# *570685C4031F_5704F8CA00C8set_impl*
 f_CurrentItem := aValue;
 DoChanged;
//#UC END# *570685C4031F_5704F8CA00C8set_impl*
end;//TnscComboLabel.pm_SetCurrentItem

procedure TnscComboLabel.DoChanged;
//#UC START# *5704F9AE00E5_5704F8CA00C8_var*
//#UC END# *5704F9AE00E5_5704F8CA00C8_var*
begin
//#UC START# *5704F9AE00E5_5704F8CA00C8_impl*
 UpdateCaption;
 if Assigned(f_OnChange) then
  f_OnChange(Self);
//#UC END# *5704F9AE00E5_5704F8CA00C8_impl*
end;//TnscComboLabel.DoChanged

procedure TnscComboLabel.TreeActionElement(Sender: TObject;
 Index: LongInt);
//#UC START# *5706819E0333_5704F8CA00C8_var*
//#UC END# *5706819E0333_5704F8CA00C8_var*
begin
//#UC START# *5706819E0333_5704F8CA00C8_impl*
 Tree.CloseUp(True);
 f_CurrentItem := Tree.Current;
 UpdateCaption;
 DoChanged;
//#UC END# *5706819E0333_5704F8CA00C8_impl*
end;//TnscComboLabel.TreeActionElement

procedure TnscComboLabel.UpdateCaption;
//#UC START# *570685E80050_5704F8CA00C8_var*
//#UC END# *570685E80050_5704F8CA00C8_var*
begin
//#UC START# *570685E80050_5704F8CA00C8_impl*
 if (f_CurrentItem >= 0) then
  Caption := l3Str(TreeStruct.Nodes[f_CurrentItem].Text)
 else
  Caption := '';
//#UC END# *570685E80050_5704F8CA00C8_impl*
end;//TnscComboLabel.UpdateCaption

procedure TnscComboLabel.TreeCloseUp(Sender: TObject);
//#UC START# *5707A0EB00B5_5704F8CA00C8_var*
//#UC END# *5707A0EB00B5_5704F8CA00C8_var*
begin
//#UC START# *5707A0EB00B5_5704F8CA00C8_impl*
 f_Dropped := False;
//#UC END# *5707A0EB00B5_5704F8CA00C8_impl*
end;//TnscComboLabel.TreeCloseUp

procedure TnscComboLabel.MouseListenerNotify(aMouseMessage: WPARAM;
 aHookStruct: PMouseHookStruct;
 var theResult: Tl3HookProcResult);
//#UC START# *4F79CEDF005A_5704F8CA00C8_var*
var
 l_Pt: TPoint;
 l_Handle: THandle;
//#UC END# *4F79CEDF005A_5704F8CA00C8_var*
begin
//#UC START# *4F79CEDF005A_5704F8CA00C8_impl*
 if Dropped then
  case aMouseMessage of
   WM_LBUTTONDOWN,
   WM_NCLBUTTONDOWN,
   WM_RBUTTONDOWN,
   WM_NCRBUTTONDOWN,
   WM_LBUTTONUP,
   WM_NCLBUTTONUP,
   WM_RBUTTONUP,
   WM_NCRBUTTONUP:
    begin
     l_Pt := aHookStruct^.Pt;
     l_Handle := WindowFromPoint(l_Pt);
     if (l_Handle <> Tree.Handle) then
      Tree.CloseUp(False);
    end;
  end;
//#UC END# *4F79CEDF005A_5704F8CA00C8_impl*
end;//TnscComboLabel.MouseListenerNotify

procedure TnscComboLabel.WndProcListenerNotify(Msg: PCWPStruct;
 var theResult: Tl3HookProcResult);
//#UC START# *4F79CF3400BB_5704F8CA00C8_var*
//#UC END# *4F79CF3400BB_5704F8CA00C8_var*
begin
//#UC START# *4F79CF3400BB_5704F8CA00C8_impl*
 if (Msg.message = WM_ACTIVATEAPP) then
  if not Boolean(Msg.WParam) then
   Tree.CloseUp(False);
//#UC END# *4F79CF3400BB_5704F8CA00C8_impl*
end;//TnscComboLabel.WndProcListenerNotify

procedure TnscComboLabel.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5704F8CA00C8_var*
//#UC END# *479731C50290_5704F8CA00C8_var*
begin
//#UC START# *479731C50290_5704F8CA00C8_impl*
 Tl3ListenersManager.RemoveWndProcListener(Self);
 Tl3ListenersManager.RemoveMouseListener(Self);
 inherited;
//#UC END# *479731C50290_5704F8CA00C8_impl*
end;//TnscComboLabel.Cleanup

constructor TnscComboLabel.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_5704F8CA00C8_var*
//#UC END# *47D1602000C6_5704F8CA00C8_var*
begin
//#UC START# *47D1602000C6_5704F8CA00C8_impl*
 inherited;
 Tl3ListenersManager.AddWndProcListener(Self);
 Tl3ListenersManager.AddMouseListener(Self);
//#UC END# *47D1602000C6_5704F8CA00C8_impl*
end;//TnscComboLabel.Create

{$If NOT Defined(NoVCL)}
procedure TnscComboLabel.MouseUp(Button: TMouseButton;
 Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *4E7896270076_5704F8CA00C8_var*
//#UC END# *4E7896270076_5704F8CA00C8_var*
begin
//#UC START# *4E7896270076_5704F8CA00C8_impl*
 inherited;
 f_Dropped := not f_Dropped;
 if not f_Dropped then
  Tree.CloseUp(False)
 else
 if Assigned(TreeStruct) and (TreeStruct.RootNode.ThisChildrenCount > 0) then
 begin
  Tree.Current := f_CurrentItem;
  Tree.ClientHeight := Tree.CalcFullHeight + 1;//Tree.GetBorderSize;
  Tree.Width := Max(Tree.CalcFullWidth + 30, Width);
  with ClientToScreen(Point(0, Height)) do
  begin
   Tree.Left := X;
   Tree.Top := Y;
  end;
  SetWindowPos(Tree.Handle, HWND_TOPMOST, Tree.Left, Tree.Top, 0, 0, SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
  Tree.Visible := True;
  SetFocus(Tree.Handle);
 end;
//#UC END# *4E7896270076_5704F8CA00C8_impl*
end;//TnscComboLabel.MouseUp
{$IfEnd} // NOT Defined(NoVCL)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscLabelSubTree);
 {* Регистрация TnscLabelSubTree }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscComboLabel);
 {* Регистрация TnscComboLabel }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
