unit nscTreeViewHotTruck;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscTreeViewHotTruck.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TnscTreeViewHotTruck" MUID: (4B60346A022E)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , nscTreeView
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Messages
 , Classes
 , l3Interfaces
 , Graphics
 , vtLister
;

type
 TOnAllowHotTruck = procedure(Sender: TObject;
  anIndex: Integer;
  var Allow: Boolean) of object;

 TnscTreeViewHotTruck = class(TnscTreeView)
  private
   f_OnAllowHotTruck: TOnAllowHotTruck;
   f_AllowTrucking: Boolean;
   f_HotTruckIndex: Integer;
  private
   procedure SetHotTruckIndex(aValue: Integer);
   procedure UpdateTruckFromCursor;
   procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
   procedure pm_SetAllowTrucking(aValue: Boolean);
   procedure DoOnGetItemStyle(aItemIndex: Integer;
    const aFont: Il3Font;
    var aTextBackColor: TColor;
    var aItemBackColor: TColor;
    var aVJustify: TvtVJustify;
    var aFocused: Boolean;
    var theImageVertOffset: Integer); override;
   procedure SetCursorForItem(anIndex: Integer); override;
  public
   constructor Create(AOwner: TComponent); override;
  public
   property OnAllowHotTruck: TOnAllowHotTruck
    read f_OnAllowHotTruck
    write f_OnAllowHotTruck;
   property AllowTrucking: Boolean
    read f_AllowTrucking
    write pm_SetAllowTrucking;
   property HotTruckIndex: Integer
    read f_HotTruckIndex;
 end;//TnscTreeViewHotTruck
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , Windows
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TnscTreeViewHotTruck.pm_SetAllowTrucking(aValue: Boolean);
//#UC START# *559BCE3F0233_4B60346A022Eset_var*
//#UC END# *559BCE3F0233_4B60346A022Eset_var*
begin
//#UC START# *559BCE3F0233_4B60346A022Eset_impl*
 if (f_AllowTrucking <> aValue) then
 begin
  f_AllowTrucking := aValue;
  if AllowTrucking then
   UpdateTruckFromCursor;
  Invalidate;
 end;
//#UC END# *559BCE3F0233_4B60346A022Eset_impl*
end;//TnscTreeViewHotTruck.pm_SetAllowTrucking

procedure TnscTreeViewHotTruck.SetHotTruckIndex(aValue: Integer);
//#UC START# *559BCE89021B_4B60346A022E_var*
var
 l_Old: Integer;
 l_Allow: Boolean;
//#UC END# *559BCE89021B_4B60346A022E_var*
begin
//#UC START# *559BCE89021B_4B60346A022E_impl*
 if (f_HotTruckIndex <> aValue) then
 begin
  l_Old := f_HotTruckIndex;
  if Assigned(f_OnAllowHotTruck) then
  begin
   l_Allow := True;
   f_OnAllowHotTruck(Self, aValue, l_Allow);
   if not l_Allow then
   begin
    aValue := -1;
    if aValue = f_HotTruckIndex then
     Exit;
   end;
  end;
  f_HotTruckIndex := aValue;
  if AllowTrucking then
  begin
   if l_Old <> -1 then
    InvalidateItem(l_Old);
   if HotTruckIndex <> -1 then
    InvalidateItem(HotTruckIndex);
  end;
 end;
//#UC END# *559BCE89021B_4B60346A022E_impl*
end;//TnscTreeViewHotTruck.SetHotTruckIndex

procedure TnscTreeViewHotTruck.UpdateTruckFromCursor;
//#UC START# *559BCE9C0001_4B60346A022E_var*
var
 l_Pos: TPoint;
//#UC END# *559BCE9C0001_4B60346A022E_var*
begin
//#UC START# *559BCE9C0001_4B60346A022E_impl*
 if AllowTrucking and HandleAllocated then
 begin
  GetCursorPos(l_Pos);
  SetHotTruckIndex(ItemAtPos(l_Pos, True));
 end;
//#UC END# *559BCE9C0001_4B60346A022E_impl*
end;//TnscTreeViewHotTruck.UpdateTruckFromCursor

procedure TnscTreeViewHotTruck.CMMouseLeave(var Message: TMessage);
//#UC START# *559BCEAE01E8_4B60346A022E_var*
//#UC END# *559BCEAE01E8_4B60346A022E_var*
begin
//#UC START# *559BCEAE01E8_4B60346A022E_impl*
 inherited;
 SetHotTruckIndex(-1);
//#UC END# *559BCEAE01E8_4B60346A022E_impl*
end;//TnscTreeViewHotTruck.CMMouseLeave

constructor TnscTreeViewHotTruck.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4B60346A022E_var*
//#UC END# *47D1602000C6_4B60346A022E_var*
begin
//#UC START# *47D1602000C6_4B60346A022E_impl*
 inherited Create(aOwner);
 f_HotTruckIndex := -1;
//#UC END# *47D1602000C6_4B60346A022E_impl*
end;//TnscTreeViewHotTruck.Create

procedure TnscTreeViewHotTruck.DoOnGetItemStyle(aItemIndex: Integer;
 const aFont: Il3Font;
 var aTextBackColor: TColor;
 var aItemBackColor: TColor;
 var aVJustify: TvtVJustify;
 var aFocused: Boolean;
 var theImageVertOffset: Integer);
//#UC START# *508F825303E4_4B60346A022E_var*
//#UC END# *508F825303E4_4B60346A022E_var*
begin
//#UC START# *508F825303E4_4B60346A022E_impl*
 inherited;
 if (HotTruckIndex = aItemIndex) and AllowTrucking then
  aFont.Underline := True;
//#UC END# *508F825303E4_4B60346A022E_impl*
end;//TnscTreeViewHotTruck.DoOnGetItemStyle

procedure TnscTreeViewHotTruck.SetCursorForItem(anIndex: Integer);
//#UC START# *5152C10E027B_4B60346A022E_var*
//#UC END# *5152C10E027B_4B60346A022E_var*
begin
//#UC START# *5152C10E027B_4B60346A022E_impl*
 inherited;
 SetHotTruckIndex(anIndex);
//#UC END# *5152C10E027B_4B60346A022E_impl*
end;//TnscTreeViewHotTruck.SetCursorForItem

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscTreeViewHotTruck);
 {* Регистрация TnscTreeViewHotTruck }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
