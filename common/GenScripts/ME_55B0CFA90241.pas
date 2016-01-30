unit f1StartupCompletedService;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\f1StartupCompletedService.pas"
// Стереотип: "Service"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Mf1StartupCompletedService = interface
  {* Контракт сервиса Tf1StartupCompletedService }
  procedure StartupComplete;
 end;//Mf1StartupCompletedService
 *)

type
 If1StartupCompletedService = interface
  {* Интерфейс сервиса Tf1StartupCompletedService }
  ['{FAEEA483-9C56-4BF2-93C7-FD7927F8D287}']
  procedure StartupComplete;
 end;//If1StartupCompletedService

 Tf1StartupCompletedService = {final} class(Tl3ProtoObject)
  private
   f_Alien: If1StartupCompletedService;
    {* Поле для свойства Alien }
  protected
   procedure pm_SetAlien(const aValue: If1StartupCompletedService);
   procedure ClearFields; override;
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   procedure StartupComplete;
   class function Instance: Tf1StartupCompletedService;
    {* Метод получения экземпляра синглетона Tf1StartupCompletedService }
  public
   property Alien: If1StartupCompletedService
    write pm_SetAlien;
    {* Внешняя реализация сервиса If1StartupCompletedService }
 end;//Tf1StartupCompletedService

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tf1StartupCompletedService: Tf1StartupCompletedService = nil;
 {* Экземпляр синглетона Tf1StartupCompletedService }

procedure Tf1StartupCompletedServiceFree;
 {* Метод освобождения экземпляра синглетона Tf1StartupCompletedService }
begin
 l3Free(g_Tf1StartupCompletedService);
end;//Tf1StartupCompletedServiceFree

procedure Tf1StartupCompletedService.pm_SetAlien(const aValue: If1StartupCompletedService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tf1StartupCompletedService.pm_SetAlien

class function Tf1StartupCompletedService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tf1StartupCompletedService <> nil;
end;//Tf1StartupCompletedService.Exists

procedure Tf1StartupCompletedService.StartupComplete;
//#UC START# *2627E933260B_55B0CFA90241_var*
//#UC END# *2627E933260B_55B0CFA90241_var*
begin
//#UC START# *2627E933260B_55B0CFA90241_impl*
 if Assigned(f_Alien) then
  f_Alien.StartupComplete;
//#UC END# *2627E933260B_55B0CFA90241_impl*
end;//Tf1StartupCompletedService.StartupComplete

class function Tf1StartupCompletedService.Instance: Tf1StartupCompletedService;
 {* Метод получения экземпляра синглетона Tf1StartupCompletedService }
begin
 if (g_Tf1StartupCompletedService = nil) then
 begin
  l3System.AddExitProc(Tf1StartupCompletedServiceFree);
  g_Tf1StartupCompletedService := Create;
 end;
 Result := g_Tf1StartupCompletedService;
end;//Tf1StartupCompletedService.Instance

procedure Tf1StartupCompletedService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tf1StartupCompletedService.ClearFields

end.
