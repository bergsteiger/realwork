unit l3PopupMenuHelper;

// Модуль: "w:\common\components\rtl\Garant\L3\l3PopupMenuHelper.pas"
// Стереотип: "Service"
// Элемент модели: "Tl3PopupMenuHelper" MUID: (550013770000)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

{$If NOT Defined(NoVCL)}
uses
 l3IntfUses
 , l3ProtoObject
 , Menus
 , Classes
 , Types
;

type
 Tl3PopupMenuHelperCallback = procedure(aMenu: TMenuItem) of object;

 (*
 Ml3PopupMenuHelper = interface
  {* Контракт сервиса Tl3PopupMenuHelper }
  function GetPopupMenu(aControl: TComponent;
   const aPoint: TPoint): TMenuItem;
  procedure GetPopupMenuForComponentInfo(aControl: TComponent;
   const aPoint: TPoint;
   aCallback: Tl3PopupMenuHelperCallback);
 end;//Ml3PopupMenuHelper
 *)

 Il3PopupMenuHelper = interface
  {* Интерфейс сервиса Tl3PopupMenuHelper }
  function GetPopupMenu(aControl: TComponent;
   const aPoint: TPoint): TMenuItem;
  procedure GetPopupMenuForComponentInfo(aControl: TComponent;
   const aPoint: TPoint;
   aCallback: Tl3PopupMenuHelperCallback);
 end;//Il3PopupMenuHelper

 Tl3PopupMenuHelper = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3PopupMenuHelper;
    {* Внешняя реализация сервиса Il3PopupMenuHelper }
  protected
   procedure pm_SetAlien(const aValue: Il3PopupMenuHelper);
   procedure ClearFields; override;
  public
   function GetPopupMenu(aControl: TComponent;
    const aPoint: TPoint): TMenuItem;
   procedure GetPopupMenuForComponentInfo(aControl: TComponent;
    const aPoint: TPoint;
    aCallback: Tl3PopupMenuHelperCallback);
   class function Instance: Tl3PopupMenuHelper;
    {* Метод получения экземпляра синглетона Tl3PopupMenuHelper }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: Il3PopupMenuHelper
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3PopupMenuHelper }
 end;//Tl3PopupMenuHelper
{$IfEnd} // NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Controls
 , SysUtils
 , l3Base
 //#UC START# *550013770000impl_uses*
 //#UC END# *550013770000impl_uses*
;

type
 TControlFriend = {abstract} class(TControl)
  {* Друг к классу TControl }
 end;//TControlFriend

var g_Tl3PopupMenuHelper: Tl3PopupMenuHelper = nil;
 {* Экземпляр синглетона Tl3PopupMenuHelper }

procedure Tl3PopupMenuHelperFree;
 {* Метод освобождения экземпляра синглетона Tl3PopupMenuHelper }
begin
 l3Free(g_Tl3PopupMenuHelper);
end;//Tl3PopupMenuHelperFree

procedure Tl3PopupMenuHelper.pm_SetAlien(const aValue: Il3PopupMenuHelper);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3PopupMenuHelper.pm_SetAlien

function Tl3PopupMenuHelper.GetPopupMenu(aControl: TComponent;
 const aPoint: TPoint): TMenuItem;
//#UC START# *5506BF830025_550013770000_var*
var
 l_M : TMenu;
//#UC END# *5506BF830025_550013770000_var*
begin
//#UC START# *5506BF830025_550013770000_impl*
 if (f_Alien = nil) then
 begin
  if (aControl Is TControl) then
  begin
   l_M := TControlFriend(aControl).PopupMenu;
   if (l_M = nil) then
    Result := nil
   else
    Result := l_M.Items;
  end//aControl Is TControl
  else
   Result := nil;
 end//f_Alien = nil
 else
  Result := f_Alien.GetPopupMenu(aControl, aPoint);
//#UC END# *5506BF830025_550013770000_impl*
end;//Tl3PopupMenuHelper.GetPopupMenu

procedure Tl3PopupMenuHelper.GetPopupMenuForComponentInfo(aControl: TComponent;
 const aPoint: TPoint;
 aCallback: Tl3PopupMenuHelperCallback);
//#UC START# *5506BFB302ED_550013770000_var*
//#UC END# *5506BFB302ED_550013770000_var*
begin
//#UC START# *5506BFB302ED_550013770000_impl*
 if Assigned(f_Alien) then
  f_Alien.GetPopupMenuForComponentInfo(aControl, aPoint, aCallback)
 else
  aCallback(Self.GetPopupMenu(aControl, aPoint));
//#UC END# *5506BFB302ED_550013770000_impl*
end;//Tl3PopupMenuHelper.GetPopupMenuForComponentInfo

class function Tl3PopupMenuHelper.Instance: Tl3PopupMenuHelper;
 {* Метод получения экземпляра синглетона Tl3PopupMenuHelper }
begin
 if (g_Tl3PopupMenuHelper = nil) then
 begin
  l3System.AddExitProc(Tl3PopupMenuHelperFree);
  g_Tl3PopupMenuHelper := Create;
 end;
 Result := g_Tl3PopupMenuHelper;
end;//Tl3PopupMenuHelper.Instance

class function Tl3PopupMenuHelper.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3PopupMenuHelper <> nil;
end;//Tl3PopupMenuHelper.Exists

procedure Tl3PopupMenuHelper.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3PopupMenuHelper.ClearFields
{$IfEnd} // NOT Defined(NoVCL)

end.
