unit l3ScriptService;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\l3ScriptService.pas"
// Стереотип: "Service"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3ScriptService = interface
  {* Контракт сервиса Tl3ScriptService }
  procedure EnterScript;
  procedure LeaveScript;
 end;//Ml3ScriptService
 *)

type
 Il3ScriptService = interface
  {* Интерфейс сервиса Tl3ScriptService }
  ['{79BCFA6B-F105-4BC6-93DB-DE19B787DEE3}']
  procedure EnterScript;
  procedure LeaveScript;
 end;//Il3ScriptService

 Tl3ScriptService = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3ScriptService;
    {* Поле для свойства Alien }
  protected
   procedure pm_SetAlien(const aValue: Il3ScriptService);
   procedure ClearFields; override;
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   procedure EnterScript;
   procedure LeaveScript;
   class function Instance: Tl3ScriptService;
    {* Метод получения экземпляра синглетона Tl3ScriptService }
  public
   property Alien: Il3ScriptService
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3ScriptService }
 end;//Tl3ScriptService
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tl3ScriptService: Tl3ScriptService = nil;
 {* Экземпляр синглетона Tl3ScriptService }

procedure Tl3ScriptServiceFree;
 {* Метод освобождения экземпляра синглетона Tl3ScriptService }
begin
 l3Free(g_Tl3ScriptService);
end;//Tl3ScriptServiceFree

procedure Tl3ScriptService.pm_SetAlien(const aValue: Il3ScriptService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3ScriptService.pm_SetAlien

class function Tl3ScriptService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3ScriptService <> nil;
end;//Tl3ScriptService.Exists

procedure Tl3ScriptService.EnterScript;
//#UC START# *97F121633B1B_5509AA5400EA_var*
//#UC END# *97F121633B1B_5509AA5400EA_var*
begin
//#UC START# *97F121633B1B_5509AA5400EA_impl*
 if (f_Alien <> nil) then
  f_Alien.EnterScript;
//#UC END# *97F121633B1B_5509AA5400EA_impl*
end;//Tl3ScriptService.EnterScript

procedure Tl3ScriptService.LeaveScript;
//#UC START# *BA3808340B4E_5509AA5400EA_var*
//#UC END# *BA3808340B4E_5509AA5400EA_var*
begin
//#UC START# *BA3808340B4E_5509AA5400EA_impl*
 if (f_Alien <> nil) then
  f_Alien.LeaveScript;
//#UC END# *BA3808340B4E_5509AA5400EA_impl*
end;//Tl3ScriptService.LeaveScript

class function Tl3ScriptService.Instance: Tl3ScriptService;
 {* Метод получения экземпляра синглетона Tl3ScriptService }
begin
 if (g_Tl3ScriptService = nil) then
 begin
  l3System.AddExitProc(Tl3ScriptServiceFree);
  g_Tl3ScriptService := Create;
 end;
 Result := g_Tl3ScriptService;
end;//Tl3ScriptService.Instance

procedure Tl3ScriptService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3ScriptService.ClearFields
{$IfEnd} // NOT Defined(NoScripts)

end.
