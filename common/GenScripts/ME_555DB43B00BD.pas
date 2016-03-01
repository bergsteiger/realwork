unit k2EVDReaderService;

// Модуль: "w:\common\components\rtl\Garant\K2\k2EVDReaderService.pas"
// Стереотип: "Service"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , k2CustomFileReader
 , l3Interfaces
 , l3Variant
;

 (*
 Mk2EVDReaderService = interface
  {* Контракт сервиса Tk2EVDReaderService }
  function GetReader: Tk2CustomFileReader;
  function MakeReader(const aFileName: AnsiString;
   const aFilter: Ik2TagGenerator): Il3Reader;
 end;//Mk2EVDReaderService
 *)

type
 Ik2EVDReaderService = interface
  {* Интерфейс сервиса Tk2EVDReaderService }
  ['{0D7649DC-496C-4118-A5C9-0D36658FB2DC}']
  function GetReader: Tk2CustomFileReader;
  function MakeReader(const aFileName: AnsiString;
   const aFilter: Ik2TagGenerator): Il3Reader;
 end;//Ik2EVDReaderService

 Tk2EVDReaderService = {final} class(Tl3ProtoObject)
  private
   f_Alien: Ik2EVDReaderService;
    {* Поле для свойства Alien }
  protected
   procedure pm_SetAlien(const aValue: Ik2EVDReaderService);
   procedure ClearFields; override;
  public
   function MakeReader(const aFileName: AnsiString;
    const aFilter: Ik2TagGenerator): Il3Reader;
   function GetReader: Tk2CustomFileReader;
   class function Instance: Tk2EVDReaderService;
    {* Метод получения экземпляра синглетона Tk2EVDReaderService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: Ik2EVDReaderService
    write pm_SetAlien;
    {* Внешняя реализация сервиса Ik2EVDReaderService }
 end;//Tk2EVDReaderService

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tk2EVDReaderService: Tk2EVDReaderService = nil;
 {* Экземпляр синглетона Tk2EVDReaderService }

procedure Tk2EVDReaderServiceFree;
 {* Метод освобождения экземпляра синглетона Tk2EVDReaderService }
begin
 l3Free(g_Tk2EVDReaderService);
end;//Tk2EVDReaderServiceFree

procedure Tk2EVDReaderService.pm_SetAlien(const aValue: Ik2EVDReaderService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tk2EVDReaderService.pm_SetAlien

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

class function Tk2EVDReaderService.Instance: Tk2EVDReaderService;
 {* Метод получения экземпляра синглетона Tk2EVDReaderService }
begin
 if (g_Tk2EVDReaderService = nil) then
 begin
  l3System.AddExitProc(Tk2EVDReaderServiceFree);
  g_Tk2EVDReaderService := Create;
 end;
 Result := g_Tk2EVDReaderService;
end;//Tk2EVDReaderService.Instance

class function Tk2EVDReaderService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tk2EVDReaderService <> nil;
end;//Tk2EVDReaderService.Exists

procedure Tk2EVDReaderService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tk2EVDReaderService.ClearFields

end.
