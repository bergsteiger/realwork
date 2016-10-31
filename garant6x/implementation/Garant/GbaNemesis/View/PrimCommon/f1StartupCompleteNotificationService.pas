unit f1StartupCompleteNotificationService;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\f1StartupCompleteNotificationService.pas"
// Стереотип: "Service"
// Элемент модели: "Tf1StartupCompleteNotificationService" MUID: (55B0CFA90241)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Mf1StartupCompleteNotificationService = interface
  {* Контракт сервиса Tf1StartupCompleteNotificationService }
  procedure Notify;
 end;//Mf1StartupCompleteNotificationService
 *)

type
 If1StartupCompleteNotificationService = interface
  {* Интерфейс сервиса Tf1StartupCompleteNotificationService }
  procedure Notify;
 end;//If1StartupCompleteNotificationService

 Tf1StartupCompleteNotificationService = {final} class(Tl3ProtoObject)
  private
   f_Alien: If1StartupCompleteNotificationService;
    {* Внешняя реализация сервиса If1StartupCompleteNotificationService }
  protected
   procedure pm_SetAlien(const aValue: If1StartupCompleteNotificationService);
   procedure ClearFields; override;
  public
   procedure Notify;
   class function Instance: Tf1StartupCompleteNotificationService;
    {* Метод получения экземпляра синглетона Tf1StartupCompleteNotificationService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: If1StartupCompleteNotificationService
    write pm_SetAlien;
    {* Внешняя реализация сервиса If1StartupCompleteNotificationService }
 end;//Tf1StartupCompleteNotificationService

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *55B0CFA90241impl_uses*
 //#UC END# *55B0CFA90241impl_uses*
;

var g_Tf1StartupCompleteNotificationService: Tf1StartupCompleteNotificationService = nil;
 {* Экземпляр синглетона Tf1StartupCompleteNotificationService }

procedure Tf1StartupCompleteNotificationServiceFree;
 {* Метод освобождения экземпляра синглетона Tf1StartupCompleteNotificationService }
begin
 l3Free(g_Tf1StartupCompleteNotificationService);
end;//Tf1StartupCompleteNotificationServiceFree

procedure Tf1StartupCompleteNotificationService.pm_SetAlien(const aValue: If1StartupCompleteNotificationService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tf1StartupCompleteNotificationService.pm_SetAlien

procedure Tf1StartupCompleteNotificationService.Notify;
//#UC START# *55B0DDC00044_55B0CFA90241_var*
//#UC END# *55B0DDC00044_55B0CFA90241_var*
begin
//#UC START# *55B0DDC00044_55B0CFA90241_impl*
 if Assigned(f_Alien) then
  f_Alien.Notify;
//#UC END# *55B0DDC00044_55B0CFA90241_impl*
end;//Tf1StartupCompleteNotificationService.Notify

class function Tf1StartupCompleteNotificationService.Instance: Tf1StartupCompleteNotificationService;
 {* Метод получения экземпляра синглетона Tf1StartupCompleteNotificationService }
begin
 if (g_Tf1StartupCompleteNotificationService = nil) then
 begin
  l3System.AddExitProc(Tf1StartupCompleteNotificationServiceFree);
  g_Tf1StartupCompleteNotificationService := Create;
 end;
 Result := g_Tf1StartupCompleteNotificationService;
end;//Tf1StartupCompleteNotificationService.Instance

class function Tf1StartupCompleteNotificationService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tf1StartupCompleteNotificationService <> nil;
end;//Tf1StartupCompleteNotificationService.Exists

procedure Tf1StartupCompleteNotificationService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tf1StartupCompleteNotificationService.ClearFields

end.
