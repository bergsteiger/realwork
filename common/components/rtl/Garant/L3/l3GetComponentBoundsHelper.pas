unit l3GetComponentBoundsHelper;

// Модуль: "w:\common\components\rtl\Garant\L3\l3GetComponentBoundsHelper.pas"
// Стереотип: "Service"
// Элемент модели: "Tl3GetComponentBoundsHelper" MUID: (5522D7A90252)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

{$If NOT Defined(NoVCL)}
uses
 l3IntfUses
 , l3ProtoObject
 , Types
 , Classes
;

 (*
 Ml3GetComponentBoundsHelper = interface
  {* Контракт сервиса Tl3GetComponentBoundsHelper }
  function GetBounds(aComponent: TComponent): TRect;
 end;//Ml3GetComponentBoundsHelper
 *)

type
 Il3GetComponentBoundsHelper = interface
  {* Интерфейс сервиса Tl3GetComponentBoundsHelper }
  function GetBounds(aComponent: TComponent): TRect;
 end;//Il3GetComponentBoundsHelper

 Tl3GetComponentBoundsHelper = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3GetComponentBoundsHelper;
    {* Внешняя реализация сервиса Il3GetComponentBoundsHelper }
  protected
   procedure pm_SetAlien(const aValue: Il3GetComponentBoundsHelper);
   procedure ClearFields; override;
  public
   function GetBounds(aComponent: TComponent): TRect;
   class function Instance: Tl3GetComponentBoundsHelper;
    {* Метод получения экземпляра синглетона Tl3GetComponentBoundsHelper }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: Il3GetComponentBoundsHelper
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3GetComponentBoundsHelper }
 end;//Tl3GetComponentBoundsHelper
{$IfEnd} // NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Controls
 , SysUtils
 , l3Base
 //#UC START# *5522D7A90252impl_uses*
 //#UC END# *5522D7A90252impl_uses*
;

var g_Tl3GetComponentBoundsHelper: Tl3GetComponentBoundsHelper = nil;
 {* Экземпляр синглетона Tl3GetComponentBoundsHelper }

procedure Tl3GetComponentBoundsHelperFree;
 {* Метод освобождения экземпляра синглетона Tl3GetComponentBoundsHelper }
begin
 l3Free(g_Tl3GetComponentBoundsHelper);
end;//Tl3GetComponentBoundsHelperFree

procedure Tl3GetComponentBoundsHelper.pm_SetAlien(const aValue: Il3GetComponentBoundsHelper);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3GetComponentBoundsHelper.pm_SetAlien

function Tl3GetComponentBoundsHelper.GetBounds(aComponent: TComponent): TRect;
//#UC START# *5522D7D800FE_5522D7A90252_var*
var
 C, P: TControl;
const
 c_EmptyRect: TRect = (Left: 0; Top: 0; Right: 0; Bottom: 0);
//#UC END# *5522D7D800FE_5522D7A90252_var*
begin
//#UC START# *5522D7D800FE_5522D7A90252_impl*
 if Assigned(f_Alien)
  then Result := f_Alien.GetBounds(aComponent)
  else Result := c_EmptyRect;

 if EqualRect(Result, c_EmptyRect) then
  if (aComponent is TControl) then
  begin
   C := TControl(aComponent);
   P := C.Parent;
   if not Assigned(P)
    then Result := C.BoundsRect
    else Result := Rect(P.ClientToScreen(C.BoundsRect.TopLeft), P.ClientToScreen(C.BoundsRect.BottomRight));                
  end;
//#UC END# *5522D7D800FE_5522D7A90252_impl*
end;//Tl3GetComponentBoundsHelper.GetBounds

class function Tl3GetComponentBoundsHelper.Instance: Tl3GetComponentBoundsHelper;
 {* Метод получения экземпляра синглетона Tl3GetComponentBoundsHelper }
begin
 if (g_Tl3GetComponentBoundsHelper = nil) then
 begin
  l3System.AddExitProc(Tl3GetComponentBoundsHelperFree);
  g_Tl3GetComponentBoundsHelper := Create;
 end;
 Result := g_Tl3GetComponentBoundsHelper;
end;//Tl3GetComponentBoundsHelper.Instance

class function Tl3GetComponentBoundsHelper.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3GetComponentBoundsHelper <> nil;
end;//Tl3GetComponentBoundsHelper.Exists

procedure Tl3GetComponentBoundsHelper.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3GetComponentBoundsHelper.ClearFields
{$IfEnd} // NOT Defined(NoVCL)

end.
