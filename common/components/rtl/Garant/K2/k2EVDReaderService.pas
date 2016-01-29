unit k2EVDReaderService;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2EVDReaderService.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Service::Class>> Shared Delphi::K2::Readers::Tk2EVDReaderService
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  l3Interfaces,
  k2CustomFileReader,
  l3ProtoObject,
  l3Variant
  ;

(*
 Mk2EVDReaderService = PureMixIn
  {* Контракт сервиса Tk2EVDReaderService }
   function GetReader: Tk2CustomFileReader;
   function MakeReader(const aFileName: AnsiString;
    const aFilter: Ik2TagGenerator): Il3Reader;
 end;//Mk2EVDReaderService
*)

type
 Ik2EVDReaderService = interface(IUnknown)
  {* Интерфейс сервиса Tk2EVDReaderService }
   ['{0D7649DC-496C-4118-A5C9-0D36658FB2DC}']
  // Mk2EVDReaderService
   function GetReader: Tk2CustomFileReader;
   function MakeReader(const aFileName: AnsiString;
    const aFilter: Ik2TagGenerator): Il3Reader;
 end;//Ik2EVDReaderService

 Tk2EVDReaderService = {final} class(Tl3ProtoObject)
 private
 // private fields
   f_Alien : Ik2EVDReaderService;
    {* Поле для свойства Alien}
 protected
 // property methods
   procedure pm_SetAlien(const aValue: Ik2EVDReaderService);
 public
 // realized methods
   function MakeReader(const aFileName: AnsiString;
     const aFilter: Ik2TagGenerator): Il3Reader;
   function GetReader: Tk2CustomFileReader;
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
   property Alien: Ik2EVDReaderService
     write pm_SetAlien;
     {* Внешняя реализация сервиса Ik2EVDReaderService }
 public
 // singleton factory method
   class function Instance: Tk2EVDReaderService;
    {- возвращает экземпляр синглетона. }
 end;//Tk2EVDReaderService

implementation

uses
  l3Base {a}
  ;


// start class Tk2EVDReaderService

var g_Tk2EVDReaderService : Tk2EVDReaderService = nil;

procedure Tk2EVDReaderServiceFree;
begin
 l3Free(g_Tk2EVDReaderService);
end;

class function Tk2EVDReaderService.Instance: Tk2EVDReaderService;
begin
 if (g_Tk2EVDReaderService = nil) then
 begin
  l3System.AddExitProc(Tk2EVDReaderServiceFree);
  g_Tk2EVDReaderService := Create;
 end;
 Result := g_Tk2EVDReaderService;
end;


procedure Tk2EVDReaderService.pm_SetAlien(const aValue: Ik2EVDReaderService);
 {-}
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tk2EVDReaderService.pm_SetAlien

class function Tk2EVDReaderService.Exists: Boolean;
 {-}
begin
 Result := g_Tk2EVDReaderService <> nil;
end;//Tk2EVDReaderService.Exists

function Tk2EVDReaderService.MakeReader(const aFileName: AnsiString;
  const aFilter: Ik2TagGenerator): Il3Reader;
//#UC START# *6A9002DE6C1A_555DB43B00BD_var*
//#UC END# *6A9002DE6C1A_555DB43B00BD_var*
begin
//#UC START# *6A9002DE6C1A_555DB43B00BD_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.MakeReader(aFileName, aFilter)
 else
  Result := nil; 
//#UC END# *6A9002DE6C1A_555DB43B00BD_impl*
end;//Tk2EVDReaderService.MakeReader

function Tk2EVDReaderService.GetReader: Tk2CustomFileReader;
//#UC START# *9F46A5A9DAF5_555DB43B00BD_var*
//#UC END# *9F46A5A9DAF5_555DB43B00BD_var*
begin
//#UC START# *9F46A5A9DAF5_555DB43B00BD_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.GetReader
 else
  Result := nil; 
//#UC END# *9F46A5A9DAF5_555DB43B00BD_impl*
end;//Tk2EVDReaderService.GetReader

procedure Tk2EVDReaderService.ClearFields;
 {-}
begin
 Alien := nil;
 inherited;
end;//Tk2EVDReaderService.ClearFields

end.