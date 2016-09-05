unit ncsTaskSendExecutorFactory;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsTaskSendExecutorFactory.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsTaskSendExecutorFactory" MUID: (5481B39101AF)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 , ncsMessageInterfaces
 , csProcessTask
 , ncsMessage
;

type
 TncsTaskSendExecutorFactory = class(Tl3ProtoObject, IncsMessageExecutorFactory)
  private
   f_Task: TddProcessTask;
  protected
   function MakeExecutor(aMessage: TncsMessage): IncsExecutor;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aTask: TddProcessTask); reintroduce;
   class function Make(aTask: TddProcessTask): IncsMessageExecutorFactory; reintroduce;
 end;//TncsTaskSendExecutorFactory
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
 , ncsGetPartialTaskDescription
 , ncsGetFilePart
 , ncsGetPartialTaskDescriptionExecutor
 , ncsGetFilePartExecutor
 //#UC START# *5481B39101AFimpl_uses*
 //#UC END# *5481B39101AFimpl_uses*
;

constructor TncsTaskSendExecutorFactory.Create(aTask: TddProcessTask);
//#UC START# *54B79D23037B_5481B39101AF_var*
//#UC END# *54B79D23037B_5481B39101AF_var*
begin
//#UC START# *54B79D23037B_5481B39101AF_impl*
 inherited Create;
 aTask.SetRefTo(f_Task);
//#UC END# *54B79D23037B_5481B39101AF_impl*
end;//TncsTaskSendExecutorFactory.Create

class function TncsTaskSendExecutorFactory.Make(aTask: TddProcessTask): IncsMessageExecutorFactory;
var
 l_Inst : TncsTaskSendExecutorFactory;
begin
 l_Inst := Create(aTask);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TncsTaskSendExecutorFactory.Make

function TncsTaskSendExecutorFactory.MakeExecutor(aMessage: TncsMessage): IncsExecutor;
//#UC START# *546082B801F3_5481B39101AF_var*
var
 l_FileName: String;
 l_BasePath: String;
//#UC END# *546082B801F3_5481B39101AF_var*
begin
//#UC START# *546082B801F3_5481B39101AF_impl*
 Result := nil;
 if (aMessage is TncsGetPartialTaskDescription) and (TncsGetPartialTaskDescription(aMessage).TaskID = f_Task.TaskID) and
  f_Task.ExpandTransferFileName(TncsGetPartialTaskDescription(aMessage).FileName, l_BasePath, l_FileName) then
   Result := TncsGetPartialTaskDescriptionExecutor.Make(l_BasePath, l_FileName)
 else
  if (aMessage is TncsGetFilePart) and (TncsGetFilePart(aMessage).TaskID = f_Task.TaskID) and
  f_Task.ExpandTransferFileName(TncsGetFilePart(aMessage).FileName, l_BasePath, l_FileName) then
   Result := TncsGetFilePartExecutor.Make(l_BasePath, l_FileName)
//#UC END# *546082B801F3_5481B39101AF_impl*
end;//TncsTaskSendExecutorFactory.MakeExecutor

procedure TncsTaskSendExecutorFactory.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5481B39101AF_var*
//#UC END# *479731C50290_5481B39101AF_var*
begin
//#UC START# *479731C50290_5481B39101AF_impl*
 FreeAndNil(f_Task);
 inherited;
//#UC END# *479731C50290_5481B39101AF_impl*
end;//TncsTaskSendExecutorFactory.Cleanup
{$IfEnd} // NOT Defined(Nemesis)

end.
