unit l3PopupMenuHelper;

// Модуль: "w:\common\components\rtl\Garant\L3\l3PopupMenuHelper.pas"
// Стереотип: "Service"

{$Include l3Define.inc}

interface

{$If NOT Defined(NoVCL)}
uses
 l3IntfUses
 , l3ProtoObject
 , Menus
 , Classes
 , Types
 , Controls
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
  ['{0FC02FC0-1297-4100-A3A7-8D342CAD75B2}']
  function GetPopupMenu(aControl: TComponent;
   const aPoint: TPoint): TMenuItem;
  procedure GetPopupMenuForComponentInfo(aControl: TComponent;
   const aPoint: TPoint;
   aCallback: Tl3PopupMenuHelperCallback);
 end;//Il3PopupMenuHelper

 Tl3PopupMenuHelper = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3PopupMenuHelper;
    {* Поле для свойства Alien }
  protected
   procedure pm_SetAlien(const aValue: Il3PopupMenuHelper);
   procedure ClearFields; override;
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   function GetPopupMenu(aControl: TComponent;
    const aPoint: TPoint): TMenuItem;
   procedure GetPopupMenuForComponentInfo(aControl: TComponent;
    const aPoint: TPoint;
    aCallback: Tl3PopupMenuHelperCallback);
   class function Instance: Tl3PopupMenuHelper;
    {* Метод получения экземпляра синглетона Tl3PopupMenuHelper }
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
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , l3MemUtils
 , l3Interlocked
;

type
 TControlFriend = {abstract} class(TControl)
  {* Друг для TControl }
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

class function Tl3PopupMenuHelper.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3PopupMenuHelper <> nil;
end;//Tl3PopupMenuHelper.Exists

function Tl3PopupMenuHelper.GetPopupMenu(aControl: TComponent;
 const aPoint: TPoint): TMenuItem;
//#UC START# *1FF8AE53688A_550013770000_var*
var
 l_M : TMenu;
//#UC END# *1FF8AE53688A_550013770000_var*
begin
//#UC START# *1FF8AE53688A_550013770000_impl*
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
//#UC END# *1FF8AE53688A_550013770000_impl*
end;//Tl3PopupMenuHelper.GetPopupMenu

procedure Tl3PopupMenuHelper.GetPopupMenuForComponentInfo(aControl: TComponent;
 const aPoint: TPoint;
 aCallback: Tl3PopupMenuHelperCallback);
//#UC START# *E1C719B751DC_550013770000_var*
//#UC END# *E1C719B751DC_550013770000_var*
begin
//#UC START# *E1C719B751DC_550013770000_impl*
 if Assigned(f_Alien) then
  f_Alien.GetPopupMenuForComponentInfo(aControl, aPoint, aCallback)
 else
  aCallback(Self.GetPopupMenu(aControl, aPoint));
//#UC END# *E1C719B751DC_550013770000_impl*
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

procedure Tl3PopupMenuHelper.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3PopupMenuHelper.ClearFields
{$IfEnd} // NOT Defined(NoVCL)

end.
