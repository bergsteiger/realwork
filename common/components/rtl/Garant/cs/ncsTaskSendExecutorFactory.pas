unit ncsTaskSendExecutorFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsTaskSendExecutorFactory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::TaskSend::TncsTaskSendExecutorFactory
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3ProtoObject,
  csProcessTask,
  ncsMessageInterfaces,
  ncsMessage
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsTaskSendExecutorFactory = class(Tl3ProtoObject, IncsMessageExecutorFactory)
 private
 // private fields
   f_Task : TddProcessTask;
 protected
 // realized methods
   function MakeExecutor(aMessage: TncsMessage): IncsExecutor;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(aTask: TddProcessTask); reintroduce;
   class function Make(aTask: TddProcessTask): IncsMessageExecutorFactory; reintroduce;
     {* Сигнатура фабрики TncsTaskSendExecutorFactory.Make }
 end;//TncsTaskSendExecutorFactory
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  SysUtils,
  ncsGetPartialTaskDescription,
  ncsGetFilePart,
  ncsGetPartialTaskDescriptionExecutor,
  ncsGetFilePartExecutor
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsTaskSendExecutorFactory

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
end;

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
//#UC START# *479731C50290_5481B39101AF_var*
//#UC END# *479731C50290_5481B39101AF_var*
begin
//#UC START# *479731C50290_5481B39101AF_impl*
 FreeAndNil(f_Task);
 inherited;
//#UC END# *479731C50290_5481B39101AF_impl*
end;//TncsTaskSendExecutorFactory.Cleanup

{$IfEnd} //not Nemesis

end.