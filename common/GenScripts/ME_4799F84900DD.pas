unit l3ScreenIC;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ScreenIC.pas"
// Стереотип: "UtilityPack"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3InternalInterfaces
 , l3ProtoObject
 , l3ScreenService
;

type
 Tl3ScreenServiceDef = {final} class(Tl3ProtoObject, Il3ScreenService)
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   function IC: Il3InfoCanvas;
   class function Instance: Tl3ScreenServiceDef;
    {* Метод получения экземпляра синглетона Tl3ScreenServiceDef }
 end;//Tl3ScreenServiceDef

function l3CrtIC: Il3InfoCanvas;

implementation

uses
 l3ImplUses
 , l3Canvas
 , l3Base
 , SysUtils
;

var g_Tl3ScreenServiceDef: Tl3ScreenServiceDef = nil;
 {* Экземпляр синглетона Tl3ScreenServiceDef }
var f_CrtIC: Pointer = nil;

procedure Tl3ScreenServiceDefFree;
 {* Метод освобождения экземпляра синглетона Tl3ScreenServiceDef }
begin
 l3Free(g_Tl3ScreenServiceDef);
end;//Tl3ScreenServiceDefFree

procedure FreeInfoCanvas;
//#UC START# *4799F8A402EA_4799F84900DD_var*
//#UC END# *4799F8A402EA_4799F84900DD_var*
begin
//#UC START# *4799F8A402EA_4799F84900DD_impl*
 Il3InfoCanvas(f_CrtIC) := nil;
//#UC END# *4799F8A402EA_4799F84900DD_impl*
end;//FreeInfoCanvas

function l3CrtIC: Il3InfoCanvas;
//#UC START# *4799F86A0356_4799F84900DD_var*
//#UC END# *4799F86A0356_4799F84900DD_var*
begin
//#UC START# *4799F86A0356_4799F84900DD_impl*
 if (f_CrtIC = nil) then
 begin
  Il3InfoCanvas(f_CrtIC) := Tl3Canvas.MakeForScreen;
  l3System.AddExitProc(FreeInfoCanvas);
 end;//f_CrtIC = nil
 Result := Il3InfoCanvas(f_CrtIC);
//#UC END# *4799F86A0356_4799F84900DD_impl*
end;//l3CrtIC

class function Tl3ScreenServiceDef.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3ScreenServiceDef <> nil;
end;//Tl3ScreenServiceDef.Exists

function Tl3ScreenServiceDef.IC: Il3InfoCanvas;
//#UC START# *88066E5D0414_556EE661021E_var*
//#UC END# *88066E5D0414_556EE661021E_var*
begin
//#UC START# *88066E5D0414_556EE661021E_impl*
 Result := l3CrtIC;
//#UC END# *88066E5D0414_556EE661021E_impl*
end;//Tl3ScreenServiceDef.IC

class function Tl3ScreenServiceDef.Instance: Tl3ScreenServiceDef;
 {* Метод получения экземпляра синглетона Tl3ScreenServiceDef }
begin
 if (g_Tl3ScreenServiceDef = nil) then
 begin
  l3System.AddExitProc(Tl3ScreenServiceDefFree);
  g_Tl3ScreenServiceDef := Create;
 end;
 Result := g_Tl3ScreenServiceDef;
end;//Tl3ScreenServiceDef.Instance

initialization
 Tl3ScreenService.Instance.Alien := Tl3ScreenServiceDef.Instance;
 {* Регистрация Tl3ScreenServiceDef }

end.
