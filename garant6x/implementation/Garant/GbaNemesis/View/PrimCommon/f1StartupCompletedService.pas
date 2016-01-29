unit f1StartupCompletedService;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimCommon/f1StartupCompletedService.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Service::Class>> F1 Базовые определения предметной области::F1 Application Template::View::PrimCommon::Tf1StartupCompletedService
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  l3ProtoObject
  ;

(*
 Mf1StartupCompletedService = PureMixIn
  {* Контракт сервиса Tf1StartupCompletedService }
   procedure StartupComplete;
 end;//Mf1StartupCompletedService
*)

type
 If1StartupCompletedService = interface(IUnknown)
  {* Интерфейс сервиса Tf1StartupCompletedService }
   ['{FAEEA483-9C56-4BF2-93C7-FD7927F8D287}']
  // Mf1StartupCompletedService
   procedure StartupComplete;
 end;//If1StartupCompletedService

 Tf1StartupCompletedService = {final} class(Tl3ProtoObject)
 private
 // private fields
   f_Alien : If1StartupCompletedService;
    {* Поле для свойства Alien}
 protected
 // property methods
   procedure pm_SetAlien(const aValue: If1StartupCompletedService);
 public
 // realized methods
   procedure StartupComplete;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // public properties
   property Alien: If1StartupCompletedService
     write pm_SetAlien;
     {* Внешняя реализация сервиса If1StartupCompletedService }
 public
 // singleton factory method
   class function Instance: Tf1StartupCompletedService;
    {- возвращает экземпляр синглетона. }
 end;//Tf1StartupCompletedService

implementation

uses
  l3Base {a}
  ;


// start class Tf1StartupCompletedService

var g_Tf1StartupCompletedService : Tf1StartupCompletedService = nil;

procedure Tf1StartupCompletedServiceFree;
begin
 l3Free(g_Tf1StartupCompletedService);
end;

class function Tf1StartupCompletedService.Instance: Tf1StartupCompletedService;
begin
 if (g_Tf1StartupCompletedService = nil) then
 begin
  l3System.AddExitProc(Tf1StartupCompletedServiceFree);
  g_Tf1StartupCompletedService := Create;
 end;
 Result := g_Tf1StartupCompletedService;
end;


procedure Tf1StartupCompletedService.pm_SetAlien(const aValue: If1StartupCompletedService);
 {-}
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tf1StartupCompletedService.pm_SetAlien

class function Tf1StartupCompletedService.Exists: Boolean;
 {-}
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

procedure Tf1StartupCompletedService.ClearFields;
 {-}
begin
 Alien := nil;
 inherited;
end;//Tf1StartupCompletedService.ClearFields

end.