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
   procedure PushAnswer(aValue: Integer);
   function CheckWasDialog: Boolean;
   procedure SignalWasDialog;
   procedure ClearAnswers;
   procedure EnterBatchMode;
   function IsBatchMode: Boolean;
   function PopAnswer: Integer;
   procedure LeaveBatchMode;
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
 , l3Base
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
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

procedure TafwBatchService.PushAnswer(aValue: Integer);
//#UC START# *194C97B8A2DF_5507FE0A0095_var*
//#UC END# *194C97B8A2DF_5507FE0A0095_var*
begin
//#UC START# *194C97B8A2DF_5507FE0A0095_impl*
 TafwAnswers.SetAnswer(aValue);
//#UC END# *194C97B8A2DF_5507FE0A0095_impl*
end;//TafwBatchService.PushAnswer

function TafwBatchService.CheckWasDialog: Boolean;
//#UC START# *217998C234EE_5507FE0A0095_var*
//#UC END# *217998C234EE_5507FE0A0095_var*
begin
//#UC START# *217998C234EE_5507FE0A0095_impl*
 Result := (f_WasDialog > 0);
 Dec(f_WasDialog);
 if (f_WasDialog < 0) then
  raise EkwWaitBracketsBalance.Create('Ожидали диалоговое окно, но не появилось');
//#UC END# *217998C234EE_5507FE0A0095_impl*
end;//TafwBatchService.CheckWasDialog

procedure TafwBatchService.SignalWasDialog;
//#UC START# *23858A465AF6_5507FE0A0095_var*
//#UC END# *23858A465AF6_5507FE0A0095_var*
begin
//#UC START# *23858A465AF6_5507FE0A0095_impl*
 Inc(f_WasDialog);
//#UC END# *23858A465AF6_5507FE0A0095_impl*
end;//TafwBatchService.SignalWasDialog

procedure TafwBatchService.ClearAnswers;
//#UC START# *37CC2CF2A1FF_5507FE0A0095_var*
//#UC END# *37CC2CF2A1FF_5507FE0A0095_var*
begin
//#UC START# *37CC2CF2A1FF_5507FE0A0095_impl*
 if TafwAnswers.Exists then
  TafwAnswers.Instance.Clear;
 f_WasDialog := 0; 
//#UC END# *37CC2CF2A1FF_5507FE0A0095_impl*
end;//TafwBatchService.ClearAnswers

procedure TafwBatchService.EnterBatchMode;
//#UC START# *3E2DB431FD1A_5507FE0A0095_var*
//#UC END# *3E2DB431FD1A_5507FE0A0095_var*
begin
//#UC START# *3E2DB431FD1A_5507FE0A0095_impl*
 Inc(f_BatchMode);
//#UC END# *3E2DB431FD1A_5507FE0A0095_impl*
end;//TafwBatchService.EnterBatchMode

function TafwBatchService.IsBatchMode: Boolean;
//#UC START# *8A081B195E08_5507FE0A0095_var*
//#UC END# *8A081B195E08_5507FE0A0095_var*
begin
//#UC START# *8A081B195E08_5507FE0A0095_impl*
 Result := (f_BatchMode > 0);
//#UC END# *8A081B195E08_5507FE0A0095_impl*
end;//TafwBatchService.IsBatchMode

function TafwBatchService.PopAnswer: Integer;
//#UC START# *FE26372CAD8B_5507FE0A0095_var*
//#UC END# *FE26372CAD8B_5507FE0A0095_var*
begin
//#UC START# *FE26372CAD8B_5507FE0A0095_impl*
 Result := TafwAnswers.GetAnswer;
//#UC END# *FE26372CAD8B_5507FE0A0095_impl*
end;//TafwBatchService.PopAnswer

procedure TafwBatchService.LeaveBatchMode;
//#UC START# *FE46A80B1DA3_5507FE0A0095_var*
//#UC END# *FE46A80B1DA3_5507FE0A0095_var*
begin
//#UC START# *FE46A80B1DA3_5507FE0A0095_impl*
 Dec(f_BatchMode);
//#UC END# *FE46A80B1DA3_5507FE0A0095_impl*
end;//TafwBatchService.LeaveBatchMode

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
 Tl3BatchService.Instance.Alien := TafwBatchService.Instance;
 {* Регистрация TafwBatchService }
{$IfEnd} // NOT Defined(NoScripts)

end.
