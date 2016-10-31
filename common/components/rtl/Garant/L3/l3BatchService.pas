unit l3BatchService;

// Модуль: "w:\common\components\rtl\Garant\L3\l3BatchService.pas"
// Стереотип: "Service"
// Элемент модели: "Tl3BatchService" MUID: (5507FDD203E1)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3ModalService
 {$If NOT Defined(NoScripts)}
 , l3ScriptService
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 Tl3BatchScriptService = {final} class(Tl3ProtoObject{$If NOT Defined(NoScripts)}
 , Il3ScriptService
 {$IfEnd} // NOT Defined(NoScripts)
 )
  public
   {$If NOT Defined(NoScripts)}
   procedure EnterScript;
   {$IfEnd} // NOT Defined(NoScripts)
   {$If NOT Defined(NoScripts)}
   procedure LeaveScript;
   {$IfEnd} // NOT Defined(NoScripts)
   class function Instance: Tl3BatchScriptService;
    {* Метод получения экземпляра синглетона Tl3BatchScriptService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tl3BatchScriptService

 (*
 Ml3BatchService = interface
  {* Контракт сервиса Tl3BatchService }
  function IsBatchMode: Boolean;
  procedure EnterBatchMode;
  procedure LeaveBatchMode;
  procedure PushAnswer(aValue: Integer);
  function PopAnswer: Integer;
  procedure SignalWasDialog;
  function CheckWasDialog: Boolean;
  procedure ClearAnswers;
 end;//Ml3BatchService
 *)

 Il3BatchService = interface
  {* Интерфейс сервиса Tl3BatchService }
  function IsBatchMode: Boolean;
  procedure EnterBatchMode;
  procedure LeaveBatchMode;
  procedure PushAnswer(aValue: Integer);
  function PopAnswer: Integer;
  procedure SignalWasDialog;
  function CheckWasDialog: Boolean;
  procedure ClearAnswers;
 end;//Il3BatchService

 Tl3BatchService = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3BatchService;
    {* Внешняя реализация сервиса Il3BatchService }
  protected
   procedure pm_SetAlien(const aValue: Il3BatchService);
   procedure ClearFields; override;
  public
   function HasModalWorker: Boolean;
   function ExecuteCurrentModalWorker(aModalExecute: TseModalExecute = se_meUsual): Boolean;
   function IsBatchMode: Boolean;
   procedure EnterBatchMode;
   procedure LeaveBatchMode;
   procedure PushAnswer(aValue: Integer);
   function PopAnswer: Integer;
   procedure SignalWasDialog;
   function CheckWasDialog: Boolean;
   procedure ClearAnswers;
   class function Instance: Tl3BatchService;
    {* Метод получения экземпляра синглетона Tl3BatchService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: Il3BatchService
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3BatchService }
 end;//Tl3BatchService

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , afwAnswer
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , SysUtils
 , l3Base
 //#UC START# *5507FDD203E1impl_uses*
 //#UC END# *5507FDD203E1impl_uses*
;

var g_Tl3BatchScriptService: Tl3BatchScriptService = nil;
 {* Экземпляр синглетона Tl3BatchScriptService }
var g_Tl3BatchService: Tl3BatchService = nil;
 {* Экземпляр синглетона Tl3BatchService }

procedure Tl3BatchScriptServiceFree;
 {* Метод освобождения экземпляра синглетона Tl3BatchScriptService }
begin
 l3Free(g_Tl3BatchScriptService);
end;//Tl3BatchScriptServiceFree

procedure Tl3BatchServiceFree;
 {* Метод освобождения экземпляра синглетона Tl3BatchService }
begin
 l3Free(g_Tl3BatchService);
end;//Tl3BatchServiceFree

{$If NOT Defined(NoScripts)}
procedure Tl3BatchScriptService.EnterScript;
//#UC START# *5509AA71018F_5509AAAC0313_var*
//#UC END# *5509AA71018F_5509AAAC0313_var*
begin
//#UC START# *5509AA71018F_5509AAAC0313_impl*
 Tl3BatchService.Instance.EnterBatchMode;
//#UC END# *5509AA71018F_5509AAAC0313_impl*
end;//Tl3BatchScriptService.EnterScript
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
procedure Tl3BatchScriptService.LeaveScript;
//#UC START# *5509AA7D0270_5509AAAC0313_var*
//#UC END# *5509AA7D0270_5509AAAC0313_var*
begin
//#UC START# *5509AA7D0270_5509AAAC0313_impl*
 Tl3BatchService.Instance.LeaveBatchMode;
//#UC END# *5509AA7D0270_5509AAAC0313_impl*
end;//Tl3BatchScriptService.LeaveScript
{$IfEnd} // NOT Defined(NoScripts)

class function Tl3BatchScriptService.Instance: Tl3BatchScriptService;
 {* Метод получения экземпляра синглетона Tl3BatchScriptService }
begin
 if (g_Tl3BatchScriptService = nil) then
 begin
  l3System.AddExitProc(Tl3BatchScriptServiceFree);
  g_Tl3BatchScriptService := Create;
 end;
 Result := g_Tl3BatchScriptService;
end;//Tl3BatchScriptService.Instance

class function Tl3BatchScriptService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3BatchScriptService <> nil;
end;//Tl3BatchScriptService.Exists

procedure Tl3BatchService.pm_SetAlien(const aValue: Il3BatchService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3BatchService.pm_SetAlien

function Tl3BatchService.HasModalWorker: Boolean;
//#UC START# *553F7345032E_5507FDD203E1_var*
//#UC END# *553F7345032E_5507FDD203E1_var*
begin
//#UC START# *553F7345032E_5507FDD203E1_impl*
 Result := Tl3ModalService.Instance.HasModalWorker;
//#UC END# *553F7345032E_5507FDD203E1_impl*
end;//Tl3BatchService.HasModalWorker

function Tl3BatchService.ExecuteCurrentModalWorker(aModalExecute: TseModalExecute = se_meUsual): Boolean;
//#UC START# *553F8EA30300_5507FDD203E1_var*
//#UC END# *553F8EA30300_5507FDD203E1_var*
begin
//#UC START# *553F8EA30300_5507FDD203E1_impl*
 Result := Tl3ModalService.Instance.ExecuteCurrentModalWorker(aModalExecute);
//#UC END# *553F8EA30300_5507FDD203E1_impl*
end;//Tl3BatchService.ExecuteCurrentModalWorker

function Tl3BatchService.IsBatchMode: Boolean;
//#UC START# *5507FDED0373_5507FDD203E1_var*
//#UC END# *5507FDED0373_5507FDD203E1_var*
begin
//#UC START# *5507FDED0373_5507FDD203E1_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.IsBatchMode
 else
  Result := false; 
//#UC END# *5507FDED0373_5507FDD203E1_impl*
end;//Tl3BatchService.IsBatchMode

procedure Tl3BatchService.EnterBatchMode;
//#UC START# *55099B480169_5507FDD203E1_var*
//#UC END# *55099B480169_5507FDD203E1_var*
begin
//#UC START# *55099B480169_5507FDD203E1_impl*
 if (f_Alien <> nil) then
  f_Alien.EnterBatchMode;
//#UC END# *55099B480169_5507FDD203E1_impl*
end;//Tl3BatchService.EnterBatchMode

procedure Tl3BatchService.LeaveBatchMode;
//#UC START# *55099B590257_5507FDD203E1_var*
//#UC END# *55099B590257_5507FDD203E1_var*
begin
//#UC START# *55099B590257_5507FDD203E1_impl*
 if (f_Alien <> nil) then
  f_Alien.LeaveBatchMode;
//#UC END# *55099B590257_5507FDD203E1_impl*
end;//Tl3BatchService.LeaveBatchMode

procedure Tl3BatchService.PushAnswer(aValue: Integer);
//#UC START# *553F341100FE_5507FDD203E1_var*
//#UC END# *553F341100FE_5507FDD203E1_var*
begin
//#UC START# *553F341100FE_5507FDD203E1_impl*
 if (f_Alien <> nil) then
  f_Alien.PushAnswer(aValue);
//#UC END# *553F341100FE_5507FDD203E1_impl*
end;//Tl3BatchService.PushAnswer

function Tl3BatchService.PopAnswer: Integer;
//#UC START# *553F3424010C_5507FDD203E1_var*
//#UC END# *553F3424010C_5507FDD203E1_var*
begin
//#UC START# *553F3424010C_5507FDD203E1_impl*
 {$IfNDef NoVCL}
 if (f_Alien <> nil) then
  Result := f_Alien.PopAnswer
 else
  Result := mrNone;
 {$Else  NoVCL}
 Assert(false);
 {$EndIf NoVCL}
//#UC END# *553F3424010C_5507FDD203E1_impl*
end;//Tl3BatchService.PopAnswer

procedure Tl3BatchService.SignalWasDialog;
//#UC START# *553F428003A3_5507FDD203E1_var*
//#UC END# *553F428003A3_5507FDD203E1_var*
begin
//#UC START# *553F428003A3_5507FDD203E1_impl*
 if (f_Alien <> nil) then
  f_Alien.SignalWasDialog;
//#UC END# *553F428003A3_5507FDD203E1_impl*
end;//Tl3BatchService.SignalWasDialog

function Tl3BatchService.CheckWasDialog: Boolean;
//#UC START# *553F429502D1_5507FDD203E1_var*
//#UC END# *553F429502D1_5507FDD203E1_var*
begin
//#UC START# *553F429502D1_5507FDD203E1_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.CheckWasDialog
 else
  Result := false; 
//#UC END# *553F429502D1_5507FDD203E1_impl*
end;//Tl3BatchService.CheckWasDialog

procedure Tl3BatchService.ClearAnswers;
//#UC START# *553F4C9802D8_5507FDD203E1_var*
//#UC END# *553F4C9802D8_5507FDD203E1_var*
begin
//#UC START# *553F4C9802D8_5507FDD203E1_impl*
 if (f_Alien <> nil) then
  f_Alien.ClearAnswers;
//#UC END# *553F4C9802D8_5507FDD203E1_impl*
end;//Tl3BatchService.ClearAnswers

class function Tl3BatchService.Instance: Tl3BatchService;
 {* Метод получения экземпляра синглетона Tl3BatchService }
begin
 if (g_Tl3BatchService = nil) then
 begin
  l3System.AddExitProc(Tl3BatchServiceFree);
  g_Tl3BatchService := Create;
 end;
 Result := g_Tl3BatchService;
end;//Tl3BatchService.Instance

class function Tl3BatchService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3BatchService <> nil;
end;//Tl3BatchService.Exists

procedure Tl3BatchService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3BatchService.ClearFields

initialization
{$If NOT Defined(NoScripts)}
 Tl3ScriptService.Instance.Alien := Tl3BatchScriptService.Instance;
{$IfEnd} // NOT Defined(NoScripts)
 {* Регистрация Tl3BatchScriptService }

end.
