unit l3ProcessingEnabledService;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Модуль: "w:/common/components/rtl/Garant/L3/l3ProcessingEnabledService.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Service::Class>> Shared Delphi Low Level::L3::l3Misc::Tl3ProcessingEnabledService
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3ProtoObject
  ;

(*
 Ml3ProcessingEnabledService = PureMixIn
  {* Контракт сервиса Tl3ProcessingEnabledService }
   function Enabled: Boolean;
 end;//Ml3ProcessingEnabledService
*)

type
 Il3ProcessingEnabledService = interface(IUnknown)
  {* Интерфейс сервиса Tl3ProcessingEnabledService }
   ['{8EE372F2-5B4D-4BC3-8E60-D2DD5148EE09}']
  // Ml3ProcessingEnabledService
   function Enabled: Boolean;
 end;//Il3ProcessingEnabledService

 Tl3ProcessingEnabledService = {final} class(Tl3ProtoObject)
 private
 // private fields
   f_Alien : Il3ProcessingEnabledService;
    {* Поле для свойства Alien}
 protected
 // property methods
   procedure pm_SetAlien(const aValue: Il3ProcessingEnabledService);
 public
 // realized methods
   function Enabled: Boolean;
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
   property Alien: Il3ProcessingEnabledService
     write pm_SetAlien;
     {* Внешняя реализация сервиса Il3ProcessingEnabledService }
 public
 // singleton factory method
   class function Instance: Tl3ProcessingEnabledService;
    {- возвращает экземпляр синглетона. }
 end;//Tl3ProcessingEnabledService

implementation

uses
  l3Base {a}
  ;


// start class Tl3ProcessingEnabledService

var g_Tl3ProcessingEnabledService : Tl3ProcessingEnabledService = nil;

procedure Tl3ProcessingEnabledServiceFree;
begin
 l3Free(g_Tl3ProcessingEnabledService);
end;

class function Tl3ProcessingEnabledService.Instance: Tl3ProcessingEnabledService;
begin
 if (g_Tl3ProcessingEnabledService = nil) then
 begin
  l3System.AddExitProc(Tl3ProcessingEnabledServiceFree);
  g_Tl3ProcessingEnabledService := Create;
 end;
 Result := g_Tl3ProcessingEnabledService;
end;


procedure Tl3ProcessingEnabledService.pm_SetAlien(const aValue: Il3ProcessingEnabledService);
 {-}
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3ProcessingEnabledService.pm_SetAlien

class function Tl3ProcessingEnabledService.Exists: Boolean;
 {-}
begin
 Result := g_Tl3ProcessingEnabledService <> nil;
end;//Tl3ProcessingEnabledService.Exists

function Tl3ProcessingEnabledService.Enabled: Boolean;
//#UC START# *ECCF31CF8A24_561CEB90011D_var*
//#UC END# *ECCF31CF8A24_561CEB90011D_var*
begin
//#UC START# *ECCF31CF8A24_561CEB90011D_impl*
 Result := Assigned(f_Alien) and f_Alien.Enabled;
//#UC END# *ECCF31CF8A24_561CEB90011D_impl*
end;//Tl3ProcessingEnabledService.Enabled

procedure Tl3ProcessingEnabledService.ClearFields;
 {-}
begin
 Alien := nil;
 inherited;
end;//Tl3ProcessingEnabledService.ClearFields

end.