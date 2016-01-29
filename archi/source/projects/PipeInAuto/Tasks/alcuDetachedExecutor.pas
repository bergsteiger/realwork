unit alcuDetachedExecutor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuDetachedExecutor.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::TaskSend::TalcuDetachedExecutor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(ServerTasks)}
uses
  l3Base,
  l3ProtoObject
  {$If not defined(Nemesis)}
  ,
  ncsMessage
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  ncsMessageInterfaces
  {$IfEnd} //not Nemesis
  ,
  alcuDetachedExecutorPool
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuDetachedExecutorThread = {final} class(Tl3ThreadContainer)
 private
 // private fields
   f_Executor : IncsExecutor;
   f_Message : TncsMessage;
   f_Transporter : IncsTransporter;
 private
 // private methods
   procedure Prepare(const anExecutor: IncsExecutor;
    const aContext: TncsExecuteContext); virtual;
 protected
 // realized methods
   procedure DoExecute; override;
     {* основная процедура нити. Для перекрытия в потомках }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 end;//TalcuDetachedExecutorThread

 TalcuDetachedExecutor = class(Tl3ProtoObject {$If not defined(Nemesis)}, IncsExecutor{$IfEnd} //not Nemesis
 )
 private
 // private fields
   f_Executor : IncsExecutor;
   f_Pool : TalcuDetachedExecutorPool;
   f_Thread : TalcuDetachedExecutorThread;
 protected
 // realized methods
   {$If not defined(Nemesis)}
   procedure Execute(const aContext: TncsExecuteContext);
   {$IfEnd} //not Nemesis
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(aPool: TalcuDetachedExecutorPool;
     const anExecutor: IncsExecutor); reintroduce;
   class function Make(aPool: TalcuDetachedExecutorPool;
     const anExecutor: IncsExecutor): IncsExecutor; reintroduce;
     {* Сигнатура фабрики TalcuDetachedExecutor.Make }
 end;//TalcuDetachedExecutor
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  SysUtils
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}

// start class TalcuDetachedExecutor

constructor TalcuDetachedExecutor.Create(aPool: TalcuDetachedExecutorPool;
  const anExecutor: IncsExecutor);
//#UC START# *54BE25E40316_54BE24CC00D4_var*
//#UC END# *54BE25E40316_54BE24CC00D4_var*
begin
//#UC START# *54BE25E40316_54BE24CC00D4_impl*
 inherited Create;
 f_Pool := aPool; // Weak;
 f_Executor := anExecutor;
 f_Thread := TalcuDetachedExecutorThread.Create;
//#UC END# *54BE25E40316_54BE24CC00D4_impl*
end;//TalcuDetachedExecutor.Create

class function TalcuDetachedExecutor.Make(aPool: TalcuDetachedExecutorPool;
  const anExecutor: IncsExecutor): IncsExecutor;
var
 l_Inst : TalcuDetachedExecutor;
begin
 l_Inst := Create(aPool, anExecutor);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;
// start class TalcuDetachedExecutorThread

procedure TalcuDetachedExecutorThread.Prepare(const anExecutor: IncsExecutor;
  const aContext: TncsExecuteContext);
//#UC START# *54BF6414034B_54BE65DF001D_var*
//#UC END# *54BF6414034B_54BE65DF001D_var*
begin
//#UC START# *54BF6414034B_54BE65DF001D_impl*
 f_Executor := anExecutor;
 aContext.rMessage.SetRefTo(f_Message);
 f_Transporter := aContext.rTransporter;
//#UC END# *54BF6414034B_54BE65DF001D_impl*
end;//TalcuDetachedExecutorThread.Prepare

procedure TalcuDetachedExecutorThread.DoExecute;
//#UC START# *4911B69E037D_54BE65DF001D_var*
//#UC END# *4911B69E037D_54BE65DF001D_var*
begin
//#UC START# *4911B69E037D_54BE65DF001D_impl*
 f_Executor.Execute(TncsExecuteContext_C(f_Message, f_Transporter));
//#UC END# *4911B69E037D_54BE65DF001D_impl*
end;//TalcuDetachedExecutorThread.DoExecute

procedure TalcuDetachedExecutorThread.Cleanup;
//#UC START# *479731C50290_54BE65DF001D_var*
//#UC END# *479731C50290_54BE65DF001D_var*
begin
//#UC START# *479731C50290_54BE65DF001D_impl*
 f_Executor := nil;
 FreeAndNil(f_Message);
 f_Transporter := nil;
 inherited;
//#UC END# *479731C50290_54BE65DF001D_impl*
end;//TalcuDetachedExecutorThread.Cleanup

{$If not defined(Nemesis)}
procedure TalcuDetachedExecutor.Execute(const aContext: TncsExecuteContext);
//#UC START# *54607DDC0159_54BE24CC00D4_var*
//#UC END# *54607DDC0159_54BE24CC00D4_var*
begin
//#UC START# *54607DDC0159_54BE24CC00D4_impl*
 f_Thread.Prepare(f_Executor, aCOntext);
 f_Pool.Launch(f_Thread);
//#UC END# *54607DDC0159_54BE24CC00D4_impl*
end;//TalcuDetachedExecutor.Execute
{$IfEnd} //not Nemesis

procedure TalcuDetachedExecutor.Cleanup;
//#UC START# *479731C50290_54BE24CC00D4_var*
//#UC END# *479731C50290_54BE24CC00D4_var*
begin
//#UC START# *479731C50290_54BE24CC00D4_impl*
 f_Executor := nil;
 f_Pool := nil;
 FreeAndNil(f_Thread);
 inherited;
//#UC END# *479731C50290_54BE24CC00D4_impl*
end;//TalcuDetachedExecutor.Cleanup

{$IfEnd} //ServerTasks

end.