unit tfwDebugService;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDebugService.pas"
// Стереотип: "Service"
// Элемент модели: "TtfwDebugService" MUID: (56F557030356)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3ProtoObject
 , tfwScriptingInterfaces
;

 (*
 MtfwDebugService = interface
  {* Контракт сервиса TtfwDebugService }
  function DebugScriptCaller: ItfwScriptCaller;
 end;//MtfwDebugService
 *)

type
 ItfwDebugService = interface
  {* Интерфейс сервиса TtfwDebugService }
  function DebugScriptCaller: ItfwScriptCaller;
 end;//ItfwDebugService

 TtfwDebugService = {final} class(Tl3ProtoObject)
  private
   f_Alien: ItfwDebugService;
    {* Внешняя реализация сервиса ItfwDebugService }
  protected
   procedure pm_SetAlien(const aValue: ItfwDebugService);
   procedure ClearFields; override;
  public
   function DebugScriptCaller: ItfwScriptCaller;
   class function Instance: TtfwDebugService;
    {* Метод получения экземпляра синглетона TtfwDebugService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: ItfwDebugService
    write pm_SetAlien;
    {* Внешняя реализация сервиса ItfwDebugService }
 end;//TtfwDebugService
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *56F557030356impl_uses*
 //#UC END# *56F557030356impl_uses*
;

var g_TtfwDebugService: TtfwDebugService = nil;
 {* Экземпляр синглетона TtfwDebugService }

procedure TtfwDebugServiceFree;
 {* Метод освобождения экземпляра синглетона TtfwDebugService }
begin
 l3Free(g_TtfwDebugService);
end;//TtfwDebugServiceFree

procedure TtfwDebugService.pm_SetAlien(const aValue: ItfwDebugService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TtfwDebugService.pm_SetAlien

function TtfwDebugService.DebugScriptCaller: ItfwScriptCaller;
//#UC START# *5DBF5C8E6606_56F557030356_var*
//#UC END# *5DBF5C8E6606_56F557030356_var*
begin
//#UC START# *5DBF5C8E6606_56F557030356_impl*
 if (f_Alien <> nil) then
  Result := DebugScriptCaller
 else
  Result := nil; 
//#UC END# *5DBF5C8E6606_56F557030356_impl*
end;//TtfwDebugService.DebugScriptCaller

class function TtfwDebugService.Instance: TtfwDebugService;
 {* Метод получения экземпляра синглетона TtfwDebugService }
begin
 if (g_TtfwDebugService = nil) then
 begin
  l3System.AddExitProc(TtfwDebugServiceFree);
  g_TtfwDebugService := Create;
 end;
 Result := g_TtfwDebugService;
end;//TtfwDebugService.Instance

class function TtfwDebugService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TtfwDebugService <> nil;
end;//TtfwDebugService.Exists

procedure TtfwDebugService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TtfwDebugService.ClearFields
{$IfEnd} // NOT Defined(NoScripts)

end.
