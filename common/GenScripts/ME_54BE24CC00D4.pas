unit alcuDetachedExecutor;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuDetachedExecutor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuDetachedExecutor" MUID: (54BE24CC00D4)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , l3ProtoObject
 {$If NOT Defined(Nemesis)}
 , ncsMessageInterfaces
 {$IfEnd} // NOT Defined(Nemesis)
 , alcuDetachedExecutorPool
 , l3Base
 {$If NOT Defined(Nemesis)}
 , ncsMessage
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuDetachedExecutorThread = {final} class(Tl3ThreadContainer)
  private
   f_Executor: IncsExecutor;
   f_Message: TncsMessage;
   f_Transporter: IncsTransporter;
  private
   procedure Prepare(const anExecutor: IncsExecutor;
    const aContext: TncsExecuteContext); virtual;
  protected
   procedure DoExecute; override;
    {* основная процедура нити. Для перекрытия в потомках }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
 end;//TalcuDetachedExecutorThread

 TalcuDetachedExecutor = class(Tl3ProtoObject{$If NOT Defined(Nemesis)}
 , IncsExecutor
 {$IfEnd} // NOT Defined(Nemesis)
 )
  private
   f_Executor: IncsExecutor;
   f_Pool: TalcuDetachedExecutorPool;
   f_Thread: TalcuDetachedExecutorThread;
  protected
   {$If NOT Defined(Nemesis)}
   procedure Execute(const aContext: TncsExecuteContext);
   {$IfEnd} // NOT Defined(Nemesis)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aPool: TalcuDetachedExecutorPool;
    const anExecutor: IncsExecutor); reintroduce;
   class function Make(aPool: TalcuDetachedExecutorPool;
    const anExecutor: IncsExecutor): IncsExecutor; reintroduce;
 end;//TalcuDetachedExecutor
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , SysUtils
;

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
 {* основная процедура нити. Для перекрытия в потомках }
//#UC START# *4911B69E037D_54BE65DF001D_var*
//#UC END# *4911B69E037D_54BE65DF001D_var*
begin
//#UC START# *4911B69E037D_54BE65DF001D_impl*
 f_Executor.Execute(TncsExecuteContext_C(f_Message, f_Transporter));
//#UC END# *4911B69E037D_54BE65DF001D_impl*
end;//TalcuDetachedExecutorThread.DoExecute

procedure TalcuDetachedExecutorThread.Cleanup;
 {* Функция очистки полей объекта. }
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
end;//TalcuDetachedExecutor.Make

{$If NOT Defined(Nemesis)}
procedure TalcuDetachedExecutor.Execute(const aContext: TncsExecuteContext);
//#UC START# *54607DDC0159_54BE24CC00D4_var*
//#UC END# *54607DDC0159_54BE24CC00D4_var*
begin
//#UC START# *54607DDC0159_54BE24CC00D4_impl*
 f_Thread.Prepare(f_Executor, aCOntext);
 f_Pool.Launch(f_Thread);
//#UC END# *54607DDC0159_54BE24CC00D4_impl*
end;//TalcuDetachedExecutor.Execute
{$IfEnd} // NOT Defined(Nemesis)

procedure TalcuDetachedExecutor.Cleanup;
 {* Функция очистки полей объекта. }
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
{$IfEnd} // Defined(ServerTasks)

end.
