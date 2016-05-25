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
 , Graphics
 , Messages
;

type
 TnscLabelSubTree = class
  private
   f_HighLightItem: Integer;
    {* Подсвеченный мышью элемент }
   f_HighlightColor: TColor;
   f_OnCloseup: TNotifyEvent;
  private
   procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
   procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
   procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
   procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
   procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
  protected
   procedure pm_SetHighLightItem(aValue: Integer);
   procedure CloseUp(anAccept: Boolean);
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

 TnscComboLabel = class(TnscImageLabel, Il3WndProcListener, Il3MouseListener, Il3MouseWheelListener)
  {* Метка с выпадающим списком }
  private
   f_FocusedControl: HWND;
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
   procedure MouseWheelListenerNotify(Msg: PMsg;
    var theResult: Tl3HookProcResult);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCL)}
   procedure MouseUp(Button: TMouseButton;
    Shift: TShiftState;
    X: Integer;
    Y: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure MouseDown(Button: TMouseButton;
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
 , l3Units
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3ListenersManager
 , SysUtils
 , l3InternalInterfaces
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

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

procedure TnscLabelSubTree.CNKeyDown(var Message: TWMKeyDown);
//#UC START# *57067C0302FD_5704FC1A0398_var*
//#UC END# *57067C0302FD_5704FC1A0398_var*
begin
//#UC START# *57067C0302FD_5704FC1A0398_impl*
 inherited;
 //CloseUp(False);
//#UC END# *57067C0302FD_5704FC1A0398_impl*
end;//TnscLabelSubTree.CNKeyDown

procedure TnscLabelSubTree.WMKillFocus(var Message: TWMKillFocus);
//#UC START# *5710FAC701BB_5704FC1A0398_var*
//#UC END# *5710FAC701BB_5704FC1A0398_var*
begin
//#UC START# *5710FAC701BB_5704FC1A0398_impl*
 if (Message.FocusedWnd <> Handle) then
  CloseUp(False);
 inherited;
//#UC END# *5710FAC701BB_5704FC1A0398_impl*
end;//TnscLabelSubTree.WMKillFocus

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

procedure TnscComboLabel.MouseWheelListenerNotify(Msg: PMsg;
 var theResult: Tl3HookProcResult);
//#UC START# *4F79D08A02C7_5704F8CA00C8_var*
//#UC END# *4F79D08A02C7_5704F8CA00C8_var*
begin
//#UC START# *4F79D08A02C7_5704F8CA00C8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F79D08A02C7_5704F8CA00C8_impl*
end;//TnscComboLabel.MouseWheelListenerNotify

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

{$If NOT Defined(NoVCL)}
procedure TnscComboLabel.MouseDown(Button: TMouseButton;
 Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *4F88473B03CD_5704F8CA00C8_var*
//#UC END# *4F88473B03CD_5704F8CA00C8_var*
begin
//#UC START# *4F88473B03CD_5704F8CA00C8_impl*
 inherited;
 f_FocusedControl := Windows.GetFocus;
//#UC END# *4F88473B03CD_5704F8CA00C8_impl*
end;//TnscComboLabel.MouseDown
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
