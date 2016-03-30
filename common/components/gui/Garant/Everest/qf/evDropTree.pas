unit evDropTree;

// Модуль: "w:\common\components\gui\Garant\Everest\qf\evDropTree.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TevDropTree" MUID: (47D0211D0209)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , AbsSubTree
 , Classes
 , Messages
 , l3TreeInterfaces
 //#UC START# *47D0211D0209intf_uses*
 //#UC END# *47D0211D0209intf_uses*
;

type
 TChooseItem = procedure(Sender: TObject;
  const Value: Il3SimpleNode) of object;

 TCheckEvent = function: Boolean of object;

 //#UC START# *47D0211D0209ci*
 //#UC END# *47D0211D0209ci*
 //#UC START# *47D0211D0209cit*
 //#UC END# *47D0211D0209cit*
 TevDropTree = class(TAbsSubTree)
  private
   f_IsList: Boolean;
   f_IsInvert: Boolean;
   f_IsStartResize: Boolean;
   f_Width: Integer;
   f_OnEndResize: TNotifyEvent;
   f_OnNeedCloseTree: TNotifyEvent;
   f_OnStartResize: TNotifyEvent;
   f_OnOwnerAssigned: TCheckEvent;
   f_OnChooseItem: TChooseItem;
  private
   procedure WMExitSizeMove(var Message: TMessage); message WM_EXITSIZEMOVE;
   procedure WMEnterSizeMove(var Message: TMessage); message WM_ENTERSIZEMOVE;
   procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
   procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
  protected
   function IsSizeableTree: Boolean; override;
   function IsShowGripper: Boolean; override;
   function IsList: Boolean; override;
   function IsInvert: Boolean; override;
   function IsOwnerAssigned: Boolean; override;
   function GetWidth: Integer; override;
   {$If NOT Defined(NoVCL)}
   procedure WndProc(var Message: TMessage); override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure DoOnSelect(Index: LongInt;
    aValue: Integer); override;
  public
   procedure Init(anInvert: Boolean;
    anIsList: Boolean;
    aWidth: Integer);
  public
   property OnEndResize: TNotifyEvent
    read f_OnEndResize
    write f_OnEndResize;
   property OnNeedCloseTree: TNotifyEvent
    read f_OnNeedCloseTree
    write f_OnNeedCloseTree;
   property OnStartResize: TNotifyEvent
    read f_OnStartResize
    write f_OnStartResize;
   property OnOwnerAssigned: TCheckEvent
    read f_OnOwnerAssigned
    write f_OnOwnerAssigned;
   property OnChooseItem: TChooseItem
    read f_OnChooseItem
    write f_OnChooseItem;
 //#UC START# *47D0211D0209publ*
  property AllowWithoutCurrent;
  property IsShowLines;
  property Font;
 //#UC END# *47D0211D0209publ*
 end;//TevDropTree

implementation

uses
 l3ImplUses
 , Windows
 , l3ControlsTypes
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *47D0211D0209impl_uses*
 //#UC END# *47D0211D0209impl_uses*
;

procedure TevDropTree.Init(anInvert: Boolean;
 anIsList: Boolean;
 aWidth: Integer);
//#UC START# *5299A3A90164_47D0211D0209_var*
//#UC END# *5299A3A90164_47D0211D0209_var*
begin
//#UC START# *5299A3A90164_47D0211D0209_impl*
 f_IsInvert := anInvert;
 f_IsList := anIsList;
 f_Width := aWidth;
//#UC END# *5299A3A90164_47D0211D0209_impl*
end;//TevDropTree.Init

procedure TevDropTree.WMExitSizeMove(var Message: TMessage);
//#UC START# *5299A21B0029_47D0211D0209_var*
//#UC END# *5299A21B0029_47D0211D0209_var*
begin
//#UC START# *5299A21B0029_47D0211D0209_impl*
 f_IsStartResize := False;
 //К сожалению это событие просто не успевает сработать, но на всякий случай...
 inherited;
//#UC END# *5299A21B0029_47D0211D0209_impl*
end;//TevDropTree.WMExitSizeMove

procedure TevDropTree.WMEnterSizeMove(var Message: TMessage);
//#UC START# *5299A25802A0_47D0211D0209_var*
//#UC END# *5299A25802A0_47D0211D0209_var*
begin
//#UC START# *5299A25802A0_47D0211D0209_impl*
 inherited;
 f_IsStartResize := True;
 if Assigned(f_OnStartResize) then
  f_OnStartResize(Self);
//#UC END# *5299A25802A0_47D0211D0209_impl*
end;//TevDropTree.WMEnterSizeMove

procedure TevDropTree.WMActivate(var Message: TWMActivate);
//#UC START# *5299A27702BC_47D0211D0209_var*
//#UC END# *5299A27702BC_47D0211D0209_var*
begin
//#UC START# *5299A27702BC_47D0211D0209_impl*
 inherited;
 if (Message.Active = WA_ACTIVE) and f_IsStartResize then
 begin
  Parent.SetFocus;
  if Assigned(f_OnEndResize) then
   f_OnEndResize(Self);
  f_IsStartResize := False;
 end;
//#UC END# *5299A27702BC_47D0211D0209_impl*
end;//TevDropTree.WMActivate

procedure TevDropTree.WMLButtonDown(var Msg: TWMLButtonDown);
//#UC START# *5299A2B600AC_47D0211D0209_var*
var
 N: Integer;
 l_ItemPart: Byte;
 Pt: TPoint;
//#UC END# *5299A2B600AC_47D0211D0209_var*
begin
//#UC START# *5299A2B600AC_47D0211D0209_impl*
 inherited;
 Pt := SmallPointToPoint(Msg.Pos);
 HitTest(Pt, N, l_ItemPart, false);
 if (l_ItemPart = ihtText) or (l_ItemPart = ihtPickIcon) then
  if Assigned(f_OnChooseItem) then
   f_OnChooseItem(Self, GetCurrentNode);
//#UC END# *5299A2B600AC_47D0211D0209_impl*
end;//TevDropTree.WMLButtonDown

function TevDropTree.IsSizeableTree: Boolean;
//#UC START# *5298BEBA032D_47D0211D0209_var*
//#UC END# *5298BEBA032D_47D0211D0209_var*
begin
//#UC START# *5298BEBA032D_47D0211D0209_impl*
 Result := True;
//#UC END# *5298BEBA032D_47D0211D0209_impl*
end;//TevDropTree.IsSizeableTree

function TevDropTree.IsShowGripper: Boolean;
//#UC START# *5298BF130022_47D0211D0209_var*
//#UC END# *5298BF130022_47D0211D0209_var*
begin
//#UC START# *5298BF130022_47D0211D0209_impl*
 Result := True;
//#UC END# *5298BF130022_47D0211D0209_impl*
end;//TevDropTree.IsShowGripper

function TevDropTree.IsList: Boolean;
//#UC START# *5298BF4D00FE_47D0211D0209_var*
//#UC END# *5298BF4D00FE_47D0211D0209_var*
begin
//#UC START# *5298BF4D00FE_47D0211D0209_impl*
 Result := f_IsList;
//#UC END# *5298BF4D00FE_47D0211D0209_impl*
end;//TevDropTree.IsList

function TevDropTree.IsInvert: Boolean;
//#UC START# *5298BF8700B0_47D0211D0209_var*
//#UC END# *5298BF8700B0_47D0211D0209_var*
begin
//#UC START# *5298BF8700B0_47D0211D0209_impl*
 Result := f_IsInvert;
//#UC END# *5298BF8700B0_47D0211D0209_impl*
end;//TevDropTree.IsInvert

function TevDropTree.IsOwnerAssigned: Boolean;
//#UC START# *5298BFDF0035_47D0211D0209_var*
//#UC END# *5298BFDF0035_47D0211D0209_var*
begin
//#UC START# *5298BFDF0035_47D0211D0209_impl*
 Result := Assigned(f_OnOwnerAssigned) and f_OnOwnerAssigned;
//#UC END# *5298BFDF0035_47D0211D0209_impl*
end;//TevDropTree.IsOwnerAssigned

function TevDropTree.GetWidth: Integer;
//#UC START# *5298BFFA014B_47D0211D0209_var*
//#UC END# *5298BFFA014B_47D0211D0209_var*
begin
//#UC START# *5298BFFA014B_47D0211D0209_impl*
 Result := f_Width;
//#UC END# *5298BFFA014B_47D0211D0209_impl*
end;//TevDropTree.GetWidth

{$If NOT Defined(NoVCL)}
procedure TevDropTree.WndProc(var Message: TMessage);
//#UC START# *47E136A80191_47D0211D0209_var*
//#UC END# *47E136A80191_47D0211D0209_var*
begin
//#UC START# *47E136A80191_47D0211D0209_impl*
 if (Message.Msg = WM_RBUTTONDOWN) then
  if Assigned(f_OnNeedCloseTree) then
   f_OnNeedCloseTree(nil);
 inherited;
//#UC END# *47E136A80191_47D0211D0209_impl*
end;//TevDropTree.WndProc
{$IfEnd} // NOT Defined(NoVCL)

procedure TevDropTree.DoOnSelect(Index: LongInt;
 aValue: Integer);
//#UC START# *5152C85403DA_47D0211D0209_var*
//#UC END# *5152C85403DA_47D0211D0209_var*
begin
//#UC START# *5152C85403DA_47D0211D0209_impl*
 inherited DoOnSelect(Index, aValue);
 if ((Index < 0) or (Index >= Total)) or not Boolean(aValue) then
  Exit;
 if Assigned(OnSelectChanged) then
  OnSelectChanged(Self, Index, aValue);
//#UC END# *5152C85403DA_47D0211D0209_impl*
end;//TevDropTree.DoOnSelect

//#UC START# *47D0211D0209impl*
//#UC END# *47D0211D0209impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevDropTree);
 {* Регистрация TevDropTree }
{$IfEnd} // NOT Defined(NoScripts)

end.
