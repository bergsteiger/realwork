unit seModalSupport;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\seModalSupport.pas"
// Стереотип: "UtilityPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptingInterfaces
 , l3ModalService
 , l3ProtoObject
;

type
 TseModalService = {final} class(Tl3ProtoObject, Il3ModalService)
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   function HasModalWorker: Boolean;
   function ExecuteCurrentModalWorker(aModalExecute: TseModalExecute = se_meUsual): Boolean;
   class function Instance: TseModalService;
    {* Метод получения экземпляра синглетона TseModalService }
 end;//TseModalService

function seAddModalWorker(aWorker: TtfwWord;
 const aCtx: TtfwContext): Integer;
function seIsValidModalWorkersCount(aCount: Integer): Boolean;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , seModalWorkerList
 , seModalWorker
 , l3AFWExceptions
 , l3BatchService
 , l3MessagesService
 , SysUtils
 , l3Base
;

var g_TseModalService: TseModalService = nil;
 {* Экземпляр синглетона TseModalService }

procedure TseModalServiceFree;
 {* Метод освобождения экземпляра синглетона TseModalService }
begin
 l3Free(g_TseModalService);
end;//TseModalServiceFree

function seExecuteCurrentModalWorker(aModalExecute: TseModalExecute): Boolean;
//#UC START# *4FC754C20096_4FC7541C02BA_var*
var
 l_W : TseModalWorker;
//#UC END# *4FC754C20096_4FC7541C02BA_var*
begin
//#UC START# *4FC754C20096_4FC7541C02BA_impl*
 Result := false;
 if not Tl3BatchService.Instance.IsBatchMode then
  Exit;
 if TseModalWorkerList.Instance.Empty then
  Exit;
 Tl3MessagesService.Instance.ProcessMessages;
 l_W := TseModalWorkerList.Instance.Last;
 if (aModalExecute <> se_meInLoop) then
  TseModalWorkerList.Instance.Delete(Pred(TseModalWorkerList.Instance.Count));
 if (aModalExecute > se_meUsual) then
  l_W.rContext^.rEngine.PushBool(aModalExecute = se_meAfterLoop);
 l_W.rWord.DoIt(l_W.rContext^);
 Tl3MessagesService.Instance.ProcessMessages;
 Result := true;
//#UC END# *4FC754C20096_4FC7541C02BA_impl*
end;//seExecuteCurrentModalWorker

function seHasModalWorker: Boolean;
//#UC START# *4FC7749201E0_4FC7541C02BA_var*
//#UC END# *4FC7749201E0_4FC7541C02BA_var*
begin
//#UC START# *4FC7749201E0_4FC7541C02BA_impl*
 Result := not TseModalWorkerList.Instance.Empty;
//#UC END# *4FC7749201E0_4FC7541C02BA_impl*
end;//seHasModalWorker

function seAddModalWorker(aWorker: TtfwWord;
 const aCtx: TtfwContext): Integer;
//#UC START# *4FC7549A03B6_4FC7541C02BA_var*
//#UC END# *4FC7549A03B6_4FC7541C02BA_var*
begin
//#UC START# *4FC7549A03B6_4FC7541C02BA_impl*
 TseModalWorkerList.Instance.Add(TseModalWorker_C(aWorker, aCtx));
 Result := TseModalWorkerList.Instance.Count;
//#UC END# *4FC7549A03B6_4FC7541C02BA_impl*
end;//seAddModalWorker

function seIsValidModalWorkersCount(aCount: Integer): Boolean;
//#UC START# *5193915002D8_4FC7541C02BA_var*
//#UC END# *5193915002D8_4FC7541C02BA_var*
begin
//#UC START# *5193915002D8_4FC7541C02BA_impl*
 Result := (TseModalWorkerList.Instance.Count < aCount);
 // - проверяем, что предыдущий модальный код выполнися
 if not Result then
  TseModalWorkerList.Instance.Delete(Pred(TseModalWorkerList.Instance.Count));
  // - снимаем этот код со стека, если он не выполнился
//#UC END# *5193915002D8_4FC7541C02BA_impl*
end;//seIsValidModalWorkersCount

class function TseModalService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TseModalService <> nil;
end;//TseModalService.Exists

function TseModalService.HasModalWorker: Boolean;
//#UC START# *553F7345032E_553F737A02D6_var*
//#UC END# *553F7345032E_553F737A02D6_var*
begin
//#UC START# *553F7345032E_553F737A02D6_impl*
 Result := SeHasModalWorker;
//#UC END# *553F7345032E_553F737A02D6_impl*
end;//TseModalService.HasModalWorker

function TseModalService.ExecuteCurrentModalWorker(aModalExecute: TseModalExecute = se_meUsual): Boolean;
//#UC START# *553F8EA30300_553F737A02D6_var*
//#UC END# *553F8EA30300_553F737A02D6_var*
begin
//#UC START# *553F8EA30300_553F737A02D6_impl*
 Result := SeExecuteCurrentModalWorker(aModalExecute);
//#UC END# *553F8EA30300_553F737A02D6_impl*
end;//TseModalService.ExecuteCurrentModalWorker

class function TseModalService.Instance: TseModalService;
 {* Метод получения экземпляра синглетона TseModalService }
begin
 if (g_TseModalService = nil) then
 begin
  l3System.AddExitProc(TseModalServiceFree);
  g_TseModalService := Create;
 end;
 Result := g_TseModalService;
end;//TseModalService.Instance

initialization
 Tl3ModalService.Instance.Alien := TseModalService.Instance;
 {* Регистрация TseModalService }
{$IfEnd} // NOT Defined(NoScripts)

end.
