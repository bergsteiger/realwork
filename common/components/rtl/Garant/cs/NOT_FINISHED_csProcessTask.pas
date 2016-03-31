unit NOT_FINISHED_csProcessTask;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csProcessTask.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "csProcessTask" MUID: (52F8C2AE0042)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ddProcessTaskPrim
 , csTaskResult
 , dt_Types
;

type
 TddProcessTask = class(TddProcessTaskPrim)
  private
   f_TaskResult: TcsTaskResult;
  protected
   procedure DoRun(const aContext: TddRunContext); virtual;
   procedure GetTaskResultClass : TcsClassResultClass; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure RegisterAbortProcessor (const aProcessor : IcsExternalTaskAbortProcessor);
   procedure UnRegisterAbortProcessor (const aProcessor : IcsExternalTaskAbortProcessor);
  public
   property TaskResult: TcsTaskResult
    read f_TaskResult;
 end;//TddProcessTask

 IcsExternalTaskAbortProcessor = interface
  ['{40349F73-8FCB-46B2-B835-902D4DAB3F3E}']
  function ProcessAbort(const aTask: TddProcessTask): Boolean;
   {* Если успешно абортировала задачу вернет True. Тогда штатная обработка обключается }
 end;//IcsExternalTaskAbortProcessor

 IcsRunTaskServices = interface
  ['{38851828-B75C-4B6B-8017-90CA9E1ADC3E}']
  procedure AddActiveTask(const aTask: TddProcessTask);
  procedure SendTextMessage(anUserID: TUserID;
   const aMessage: AnsiString);
 end;//IcsRunTaskServices

 IcsFileTransferServices = interface
  ['{FB5B417E-E4BB-4834-A0BD-940697670FB9}']
  function TransferFile(const aTargetFolder: AnsiString;
   const aSourceFileName: AnsiString;
   const aTargetFileName: AnsiString): Boolean;
 end;//IcsFileTransferServices
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;

procedure TddProcessTask.DoRun(const aContext: TddRunContext);
//#UC START# *53A2EEE90097_52F8C2BF0110_var*
//#UC END# *53A2EEE90097_52F8C2BF0110_var*
begin
//#UC START# *53A2EEE90097_52F8C2BF0110_impl*
 !!! Needs to be implemented !!!
//#UC END# *53A2EEE90097_52F8C2BF0110_impl*
end;//TddProcessTask.DoRun

procedure TddProcessTask.RegisterAbortProcessor (const aProcessor : IcsExternalTaskAbortProcessor);
//#UC START# *53CF5FC303D9_52F8C2BF0110_var*
//#UC END# *53CF5FC303D9_52F8C2BF0110_var*
begin
//#UC START# *53CF5FC303D9_52F8C2BF0110_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CF5FC303D9_52F8C2BF0110_impl*
end;//TddProcessTask.RegisterAbortProcessor (const aProcessor : IcsExternalTaskAbortProcessor)

procedure TddProcessTask.UnRegisterAbortProcessor (const aProcessor : IcsExternalTaskAbortProcessor);
//#UC START# *53CF5FE40219_52F8C2BF0110_var*
//#UC END# *53CF5FE40219_52F8C2BF0110_var*
begin
//#UC START# *53CF5FE40219_52F8C2BF0110_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CF5FE40219_52F8C2BF0110_impl*
end;//TddProcessTask.UnRegisterAbortProcessor (const aProcessor : IcsExternalTaskAbortProcessor)

procedure TddProcessTask.GetTaskResultClass : TcsClassResultClass;
//#UC START# *53E1CB0C03C9_52F8C2BF0110_var*
//#UC END# *53E1CB0C03C9_52F8C2BF0110_var*
begin
//#UC START# *53E1CB0C03C9_52F8C2BF0110_impl*
 !!! Needs to be implemented !!!
//#UC END# *53E1CB0C03C9_52F8C2BF0110_impl*
end;//TddProcessTask.GetTaskResultClass : TcsClassResultClass

procedure TddProcessTask.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_52F8C2BF0110_var*
//#UC END# *479731C50290_52F8C2BF0110_var*
begin
//#UC START# *479731C50290_52F8C2BF0110_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_52F8C2BF0110_impl*
end;//TddProcessTask.Cleanup
{$IfEnd} // NOT Defined(Nemesis)

end.
