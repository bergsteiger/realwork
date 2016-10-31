unit afwAnswer;
 {* Хак для диалогов для скриптов. }

// Модуль: "w:\common\components\rtl\Garant\L3\afwAnswer.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "afwAnswer" MUID: (4E03119F00B2)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3AFWExceptions
 , l3ProtoObject
 , l3BatchService
 , l3ProtoIntegerList
 , SysUtils
;

type
 EafwTryEnterModalState = El3TryEnterModalState;

 TafwBatchService = {final} class(Tl3ProtoObject, Il3BatchService)
  private
   f_BatchMode: Integer;
   f_WasDialog: Integer;
  public
   function IsBatchMode: Boolean;
   procedure EnterBatchMode;
   procedure LeaveBatchMode;
   procedure PushAnswer(aValue: Integer);
   function PopAnswer: Integer;
   procedure SignalWasDialog;
   function CheckWasDialog: Boolean;
   procedure ClearAnswers;
   class function Instance: TafwBatchService;
    {* Метод получения экземпляра синглетона TafwBatchService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TafwBatchService

 TafwAnswers = class(Tl3ProtoIntegerList)
  protected
   class function GetAnswer: Integer;
   class procedure SetAnswer(anAnswer: Integer);
  public
   class function Instance: TafwAnswers;
    {* Метод получения экземпляра синглетона TafwAnswers }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TafwAnswers

 EkwWaitBracketsBalance = class(Exception)
 end;//EkwWaitBracketsBalance
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TtfwTypeRegistrator_Proxy
 , l3Base
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *4E03119F00B2impl_uses*
 //#UC END# *4E03119F00B2impl_uses*
;

var g_TafwBatchService: TafwBatchService = nil;
 {* Экземпляр синглетона TafwBatchService }
var g_TafwAnswers: TafwAnswers = nil;
 {* Экземпляр синглетона TafwAnswers }

procedure TafwBatchServiceFree;
 {* Метод освобождения экземпляра синглетона TafwBatchService }
begin
 l3Free(g_TafwBatchService);
end;//TafwBatchServiceFree

procedure TafwAnswersFree;
 {* Метод освобождения экземпляра синглетона TafwAnswers }
begin
 l3Free(g_TafwAnswers);
end;//TafwAnswersFree

function TafwBatchService.IsBatchMode: Boolean;
//#UC START# *5507FDED0373_5507FE0A0095_var*
//#UC END# *5507FDED0373_5507FE0A0095_var*
begin
//#UC START# *5507FDED0373_5507FE0A0095_impl*
 Result := (f_BatchMode > 0);
//#UC END# *5507FDED0373_5507FE0A0095_impl*
end;//TafwBatchService.IsBatchMode

procedure TafwBatchService.EnterBatchMode;
//#UC START# *55099B480169_5507FE0A0095_var*
//#UC END# *55099B480169_5507FE0A0095_var*
begin
//#UC START# *55099B480169_5507FE0A0095_impl*
 Inc(f_BatchMode);
//#UC END# *55099B480169_5507FE0A0095_impl*
end;//TafwBatchService.EnterBatchMode

procedure TafwBatchService.LeaveBatchMode;
//#UC START# *55099B590257_5507FE0A0095_var*
//#UC END# *55099B590257_5507FE0A0095_var*
begin
//#UC START# *55099B590257_5507FE0A0095_impl*
 Dec(f_BatchMode);
//#UC END# *55099B590257_5507FE0A0095_impl*
end;//TafwBatchService.LeaveBatchMode

procedure TafwBatchService.PushAnswer(aValue: Integer);
//#UC START# *553F341100FE_5507FE0A0095_var*
//#UC END# *553F341100FE_5507FE0A0095_var*
begin
//#UC START# *553F341100FE_5507FE0A0095_impl*
 TafwAnswers.SetAnswer(aValue);
//#UC END# *553F341100FE_5507FE0A0095_impl*
end;//TafwBatchService.PushAnswer

function TafwBatchService.PopAnswer: Integer;
//#UC START# *553F3424010C_5507FE0A0095_var*
//#UC END# *553F3424010C_5507FE0A0095_var*
begin
//#UC START# *553F3424010C_5507FE0A0095_impl*
 Result := TafwAnswers.GetAnswer;
//#UC END# *553F3424010C_5507FE0A0095_impl*
end;//TafwBatchService.PopAnswer

procedure TafwBatchService.SignalWasDialog;
//#UC START# *553F428003A3_5507FE0A0095_var*
//#UC END# *553F428003A3_5507FE0A0095_var*
begin
//#UC START# *553F428003A3_5507FE0A0095_impl*
 Inc(f_WasDialog);
//#UC END# *553F428003A3_5507FE0A0095_impl*
end;//TafwBatchService.SignalWasDialog

function TafwBatchService.CheckWasDialog: Boolean;
//#UC START# *553F429502D1_5507FE0A0095_var*
//#UC END# *553F429502D1_5507FE0A0095_var*
begin
//#UC START# *553F429502D1_5507FE0A0095_impl*
 Result := (f_WasDialog > 0);
 Dec(f_WasDialog);
 if (f_WasDialog < 0) then
  raise EkwWaitBracketsBalance.Create('Ожидали диалоговое окно, но не появилось');
//#UC END# *553F429502D1_5507FE0A0095_impl*
end;//TafwBatchService.CheckWasDialog

procedure TafwBatchService.ClearAnswers;
//#UC START# *553F4C9802D8_5507FE0A0095_var*
//#UC END# *553F4C9802D8_5507FE0A0095_var*
begin
//#UC START# *553F4C9802D8_5507FE0A0095_impl*
 if TafwAnswers.Exists then
  TafwAnswers.Instance.Clear;
 f_WasDialog := 0; 
//#UC END# *553F4C9802D8_5507FE0A0095_impl*
end;//TafwBatchService.ClearAnswers

class function TafwBatchService.Instance: TafwBatchService;
 {* Метод получения экземпляра синглетона TafwBatchService }
begin
 if (g_TafwBatchService = nil) then
 begin
  l3System.AddExitProc(TafwBatchServiceFree);
  g_TafwBatchService := Create;
 end;
 Result := g_TafwBatchService;
end;//TafwBatchService.Instance

class function TafwBatchService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TafwBatchService <> nil;
end;//TafwBatchService.Exists

class function TafwAnswers.GetAnswer: Integer;
//#UC START# *4E0321910152_553E013F0125_var*
//#UC END# *4E0321910152_553E013F0125_var*
begin
//#UC START# *4E0321910152_553E013F0125_impl*
 {$IfNDef NoVCL}
 if Exists AND
    (Instance.Count > 0) AND
    (Instance.Last <> mrNone) then
 begin
  Result := Instance.Last;
  Instance.Delete(Instance.Hi);
  //Inc(g_WasWait);
  // - нельзя тут это делать
  // http://mdp.garant.ru/pages/viewpage.action?pageId=337513713
  // http://mdp.garant.ru/pages/viewpage.action?pageId=337513713&focusedCommentId=337514042#comment-337514042
 end // if Exists AND (Instance.Last <> mrNone) then
 else
  Result := mrNone;
 {$Else  NoVCL}
 Assert(false);
 {$EndIf NoVCL}
//#UC END# *4E0321910152_553E013F0125_impl*
end;//TafwAnswers.GetAnswer

class procedure TafwAnswers.SetAnswer(anAnswer: Integer);
//#UC START# *4E0312C70245_553E013F0125_var*
//#UC END# *4E0312C70245_553E013F0125_var*
begin
//#UC START# *4E0312C70245_553E013F0125_impl*
 Instance.Add(anAnswer);
//#UC END# *4E0312C70245_553E013F0125_impl*
end;//TafwAnswers.SetAnswer

class function TafwAnswers.Instance: TafwAnswers;
 {* Метод получения экземпляра синглетона TafwAnswers }
begin
 if (g_TafwAnswers = nil) then
 begin
  l3System.AddExitProc(TafwAnswersFree);
  g_TafwAnswers := Create;
 end;
 Result := g_TafwAnswers;
end;//TafwAnswers.Instance

class function TafwAnswers.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TafwAnswers <> nil;
end;//TafwAnswers.Exists

initialization
 TtfwTypeRegistrator.RegisterType(TypeInfo(EafwTryEnterModalState));
 {* Регистрация типа EafwTryEnterModalState }
 Tl3BatchService.Instance.Alien := TafwBatchService.Instance;
 {* Регистрация TafwBatchService }
 TtfwTypeRegistrator.RegisterType(TypeInfo(EkwWaitBracketsBalance));
 {* Регистрация типа EkwWaitBracketsBalance }
{$IfEnd} // NOT Defined(NoScripts)

end.
