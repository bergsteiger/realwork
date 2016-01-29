unit NOT_FINISHED_csProcessTask;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/NOT_FINISHED_csProcessTask.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::cs::Tasks::csProcessTask
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  dt_Types,
  ddProcessTaskPrim,
  csTaskResult
  ;

type
 TddProcessTask = class(TddProcessTaskPrim)
 private
 // private fields
   f_TaskResult : TcsTaskResult;
    {* Поле для свойства TaskResult}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 protected
 // protected methods
   procedure DoRun(const aContext: TddRunContext); virtual;
   procedure GetTaskResultClass : TcsClassResultClass; virtual;
     {* Сигнатура метода GetTaskResultClass : TcsClassResultClass }
 public
 // public methods
   procedure RegisterAbortProcessor (const aProcessor : IcsExternalTaskAbortProcessor);
     {* Сигнатура метода RegisterAbortProcessor (const aProcessor : IcsExternalTaskAbortProcessor) }
   procedure UnRegisterAbortProcessor (const aProcessor : IcsExternalTaskAbortProcessor);
     {* Сигнатура метода UnRegisterAbortProcessor (const aProcessor : IcsExternalTaskAbortProcessor) }
 public
 // public properties
   property TaskResult: TcsTaskResult
     read f_TaskResult;
 end;//TddProcessTask

 IcsExternalTaskAbortProcessor = interface(IUnknown)
   ['{40349F73-8FCB-46B2-B835-902D4DAB3F3E}']
   function ProcessAbort(const aTask: TddProcessTask): Boolean;
     {* Если успешно абортировала задачу вернет True. Тогда штатная обработка обключается }
 end;//IcsExternalTaskAbortProcessor

 IcsRunTaskServices = interface(IUnknown)
   ['{38851828-B75C-4B6B-8017-90CA9E1ADC3E}']
   procedure AddActiveTask(const aTask: TddProcessTask);
   procedure SendTextMessage(anUserID: TUserID;
    const aMessage: AnsiString);
 end;//IcsRunTaskServices

 IcsFileTransferServices = interface(IUnknown)
   ['{FB5B417E-E4BB-4834-A0BD-940697670FB9}']
   function TransferFile(const aTargetFolder: AnsiString;
    const aSourceFileName: AnsiString;
    const aTargetFileName: AnsiString): Boolean;
 end;//IcsFileTransferServices
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
// start class TddProcessTask

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
//#UC START# *479731C50290_52F8C2BF0110_var*
//#UC END# *479731C50290_52F8C2BF0110_var*
begin
//#UC START# *479731C50290_52F8C2BF0110_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_52F8C2BF0110_impl*
end;//TddProcessTask.Cleanup
{$IfEnd} //not Nemesis

end.