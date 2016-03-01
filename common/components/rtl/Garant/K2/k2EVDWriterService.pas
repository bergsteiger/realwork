unit k2EVDWriterService;

// Модуль: "w:\common\components\rtl\Garant\K2\k2EVDWriterService.pas"
// Стереотип: "Service"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , k2CustomFileGenerator
 , l3Variant
;

 (*
 Mk2EVDWriterService = interface
  {* Контракт сервиса Tk2EVDWriterService }
  function GetWriter: Tk2CustomFileGenerator;
  function MakeWriter(const aFileName: AnsiString): Ik2TagGenerator;
 end;//Mk2EVDWriterService
 *)

type
 Ik2EVDWriterService = interface
  {* Интерфейс сервиса Tk2EVDWriterService }
  ['{B93031D3-1115-441C-B788-BC5802B50265}']
  function GetWriter: Tk2CustomFileGenerator;
  function MakeWriter(const aFileName: AnsiString): Ik2TagGenerator;
 end;//Ik2EVDWriterService

 Tk2EVDWriterService = {final} class(Tl3ProtoObject)
  private
   f_Alien: Ik2EVDWriterService;
    {* Поле для свойства Alien }
  protected
   procedure pm_SetAlien(const aValue: Ik2EVDWriterService);
   procedure ClearFields; override;
  public
   function GetWriter: Tk2CustomFileGenerator;
   function MakeWriter(const aFileName: AnsiString): Ik2TagGenerator;
   class function Instance: Tk2EVDWriterService;
    {* Метод получения экземпляра синглетона Tk2EVDWriterService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: Ik2EVDWriterService
    write pm_SetAlien;
    {* Внешняя реализация сервиса Ik2EVDWriterService }
 end;//Tk2EVDWriterService

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tk2EVDWriterService: Tk2EVDWriterService = nil;
 {* Экземпляр синглетона Tk2EVDWriterService }

procedure Tk2EVDWriterServiceFree;
 {* Метод освобождения экземпляра синглетона Tk2EVDWriterService }
begin
 l3Free(g_Tk2EVDWriterService);
end;//Tk2EVDWriterServiceFree

procedure Tk2EVDWriterService.pm_SetAlien(const aValue: Ik2EVDWriterService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tk2EVDWriterService.pm_SetAlien

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

class function Tk2EVDWriterService.Instance: Tk2EVDWriterService;
 {* Метод получения экземпляра синглетона Tk2EVDWriterService }
begin
 if (g_Tk2EVDWriterService = nil) then
 begin
  l3System.AddExitProc(Tk2EVDWriterServiceFree);
  g_Tk2EVDWriterService := Create;
 end;
 Result := g_Tk2EVDWriterService;
end;//Tk2EVDWriterService.Instance

class function Tk2EVDWriterService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tk2EVDWriterService <> nil;
end;//Tk2EVDWriterService.Exists

procedure Tk2EVDWriterService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tk2EVDWriterService.ClearFields

end.
