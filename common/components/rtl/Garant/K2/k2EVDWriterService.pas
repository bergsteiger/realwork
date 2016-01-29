unit k2EVDWriterService;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2EVDWriterService.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Service::Class>> Shared Delphi::K2::Readers::Tk2EVDWriterService
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2CustomFileGenerator,
  l3ProtoObject,
  l3Variant
  ;

(*
 Mk2EVDWriterService = PureMixIn
  {* Контракт сервиса Tk2EVDWriterService }
   function GetWriter: Tk2CustomFileGenerator;
   function MakeWriter(const aFileName: AnsiString): Ik2TagGenerator;
 end;//Mk2EVDWriterService
*)

type
 Ik2EVDWriterService = interface(IUnknown)
  {* Интерфейс сервиса Tk2EVDWriterService }
   ['{B93031D3-1115-441C-B788-BC5802B50265}']
  // Mk2EVDWriterService
   function GetWriter: Tk2CustomFileGenerator;
   function MakeWriter(const aFileName: AnsiString): Ik2TagGenerator;
 end;//Ik2EVDWriterService

 Tk2EVDWriterService = {final} class(Tl3ProtoObject)
 private
 // private fields
   f_Alien : Ik2EVDWriterService;
    {* Поле для свойства Alien}
 protected
 // property methods
   procedure pm_SetAlien(const aValue: Ik2EVDWriterService);
 public
 // realized methods
   function GetWriter: Tk2CustomFileGenerator;
   function MakeWriter(const aFileName: AnsiString): Ik2TagGenerator;
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
   property Alien: Ik2EVDWriterService
     write pm_SetAlien;
     {* Внешняя реализация сервиса Ik2EVDWriterService }
 public
 // singleton factory method
   class function Instance: Tk2EVDWriterService;
    {- возвращает экземпляр синглетона. }
 end;//Tk2EVDWriterService

implementation

uses
  l3Base {a}
  ;


// start class Tk2EVDWriterService

var g_Tk2EVDWriterService : Tk2EVDWriterService = nil;

procedure Tk2EVDWriterServiceFree;
begin
 l3Free(g_Tk2EVDWriterService);
end;

class function Tk2EVDWriterService.Instance: Tk2EVDWriterService;
begin
 if (g_Tk2EVDWriterService = nil) then
 begin
  l3System.AddExitProc(Tk2EVDWriterServiceFree);
  g_Tk2EVDWriterService := Create;
 end;
 Result := g_Tk2EVDWriterService;
end;


procedure Tk2EVDWriterService.pm_SetAlien(const aValue: Ik2EVDWriterService);
 {-}
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tk2EVDWriterService.pm_SetAlien

class function Tk2EVDWriterService.Exists: Boolean;
 {-}
begin
 Result := g_Tk2EVDWriterService <> nil;
end;//Tk2EVDWriterService.Exists

function Tk2EVDWriterService.GetWriter: Tk2CustomFileGenerator;
//#UC START# *26782C1B9519_555DCEA8017E_var*
//#UC END# *26782C1B9519_555DCEA8017E_var*
begin
//#UC START# *26782C1B9519_555DCEA8017E_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.GetWriter
 else
  Result := nil; 
//#UC END# *26782C1B9519_555DCEA8017E_impl*
end;//Tk2EVDWriterService.GetWriter

function Tk2EVDWriterService.MakeWriter(const aFileName: AnsiString): Ik2TagGenerator;
//#UC START# *F7BF6A35E2B1_555DCEA8017E_var*
//#UC END# *F7BF6A35E2B1_555DCEA8017E_var*
begin
//#UC START# *F7BF6A35E2B1_555DCEA8017E_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.MakeWriter(aFileName)
 else
  Result := nil; 
//#UC END# *F7BF6A35E2B1_555DCEA8017E_impl*
end;//Tk2EVDWriterService.MakeWriter

procedure Tk2EVDWriterService.ClearFields;
 {-}
begin
 Alien := nil;
 inherited;
end;//Tk2EVDWriterService.ClearFields

end.