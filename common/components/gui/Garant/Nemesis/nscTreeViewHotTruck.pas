unit nscTreeViewHotTruck;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscTreeViewHotTruck.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi For F1::Nemesis::Tree::TnscTreeViewHotTruck
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  Messages,
  nscTreeView,
  Classes,
  l3Interfaces,
  Graphics,
  vtLister,
  Controls {a}
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TOnAllowHotTruck = procedure (Sender: TObject;
  anIndex: Integer;
  var Allow: Boolean) of object;

 TnscTreeViewHotTruck = class(TnscTreeView)
 private
 // private fields
   f_OnAllowHotTruck : TOnAllowHotTruck;
    {* Поле для свойства OnAllowHotTruck}
   f_AllowTrucking : Boolean;
    {* Поле для свойства AllowTrucking}
   f_HotTruckIndex : Integer;
    {* Поле для свойства HotTruckIndex}
 private
 // private methods
   procedure SetHotTruckIndex(aValue: Integer);
   procedure UpdateTruckFromCursor;
     {* Сигнатура метода UpdateTruckFromCursor }
   procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
 protected
 // property methods
   procedure pm_SetAllowTrucking(aValue: Boolean);
 protected
 // overridden protected methods
   procedure DoOnGetItemStyle(aItemIndex: Integer;
      const aFont: Il3Font;
      var aTextBackColor: TColor;
      var aItemBackColor: TColor;
      var aVJustify: TvtVJustify;
      var aFocused: Boolean;
      var theImageVertOffset: Integer); override;
   procedure SetCursorForItem(anIndex: Integer); override;
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
 public
 // public properties
   property OnAllowHotTruck: TOnAllowHotTruck
     read f_OnAllowHotTruck
     write f_OnAllowHotTruck;
   property AllowTrucking: Boolean
     read f_AllowTrucking
     write pm_SetAllowTrucking;
   property HotTruckIndex: Integer
     read f_HotTruckIndex;
 end;//TnscTreeViewHotTruck
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  Windows
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}

// start class TnscTreeViewHotTruck

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

{$IfEnd} //Nemesis

initialization
{$If defined(Nemesis) AND not defined(NoScripts)}
// Регистрация TnscTreeViewHotTruck
 TtfwClassRef.Register(TnscTreeViewHotTruck);
{$IfEnd} //Nemesis AND not NoScripts

end.