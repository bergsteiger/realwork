unit l3ModalService;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ModalService.pas"
// Стереотип: "Service"
// Элемент модели: "Tl3ModalService" MUID: (553F71BE03E0)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

type
 TseModalExecute = (
  se_meUsual
  , se_meInLoop
  , se_meAfterLoop
 );//TseModalExecute

 (*
 Ml3ModalService = interface
  function HasModalWorker: Boolean;
  function ExecuteCurrentModalWorker(aModalExecute: TseModalExecute = se_meUsual): Boolean;
 end;//Ml3ModalService
 *)

 Il3ModalService = interface
  {* Интерфейс сервиса Tl3ModalService }
  ['{138EC31E-59DE-4996-A7C2-234E73119E5C}']
  function HasModalWorker: Boolean;
  function ExecuteCurrentModalWorker(aModalExecute: TseModalExecute = se_meUsual): Boolean;
 end;//Il3ModalService

 Tl3ModalService = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3ModalService;
    {* Внешняя реализация сервиса Il3ModalService }
  protected
   procedure pm_SetAlien(const aValue: Il3ModalService);
   procedure ClearFields; override;
  public
   function HasModalWorker: Boolean;
   function ExecuteCurrentModalWorker(aModalExecute: TseModalExecute = se_meUsual): Boolean;
   class function Instance: Tl3ModalService;
    {* Метод получения экземпляра синглетона Tl3ModalService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: Il3ModalService
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3ModalService }
 end;//Tl3ModalService

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tl3ModalService: Tl3ModalService = nil;
 {* Экземпляр синглетона Tl3ModalService }

procedure Tl3ModalServiceFree;
 {* Метод освобождения экземпляра синглетона Tl3ModalService }
begin
 l3Free(g_Tl3ModalService);
end;//Tl3ModalServiceFree

procedure Tl3ModalService.pm_SetAlien(const aValue: Il3ModalService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3ModalService.pm_SetAlien

function Tl3ModalService.HasModalWorker: Boolean;
//#UC START# *553F7345032E_553F71BE03E0_var*
//#UC END# *553F7345032E_553F71BE03E0_var*
begin
//#UC START# *553F7345032E_553F71BE03E0_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.HasModalWorker
 else
  Result := false; 
//#UC END# *553F7345032E_553F71BE03E0_impl*
end;//Tl3ModalService.HasModalWorker

function Tl3ModalService.ExecuteCurrentModalWorker(aModalExecute: TseModalExecute = se_meUsual): Boolean;
//#UC START# *553F8EA30300_553F71BE03E0_var*
//#UC END# *553F8EA30300_553F71BE03E0_var*
begin
//#UC START# *553F8EA30300_553F71BE03E0_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.ExecuteCurrentModalWorker(aModalExecute)
 else
  Result := false; 
//#UC END# *553F8EA30300_553F71BE03E0_impl*
end;//Tl3ModalService.ExecuteCurrentModalWorker

class function Tl3ModalService.Instance: Tl3ModalService;
 {* Метод получения экземпляра синглетона Tl3ModalService }
begin
 if (g_Tl3ModalService = nil) then
 begin
  l3System.AddExitProc(Tl3ModalServiceFree);
  g_Tl3ModalService := Create;
 end;
 Result := g_Tl3ModalService;
end;//Tl3ModalService.Instance

class function Tl3ModalService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3ModalService <> nil;
end;//Tl3ModalService.Exists

procedure Tl3ModalService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3ModalService.ClearFields

end.
