unit alcuDocTransferRequestExecutor;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuDocTransferRequestExecutor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuDocTransferRequestExecutor" MUID: (57D2A6A70025)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuExecutorWithIncomingTaskList
 {$If NOT Defined(Nemesis)}
 , ncsMessageInterfaces
 {$IfEnd} // NOT Defined(Nemesis)
 , alcuImmidiateRequestInterfaces
 {$If NOT Defined(Nemesis)}
 , ddServerTaskList
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuDocTransferRequestExecutor = class(TalcuExecutorWithIncomingTaskList{$If NOT Defined(Nemesis)}
 , IncsExecutor
 {$IfEnd} // NOT Defined(Nemesis)
 )
  private
   f_RequestImmidiateProcessProc: TalcuSpeedupRequestProc;
  protected
   procedure SpeedupRequest;
   procedure DoExecute(const aContext: TncsExecuteContext); virtual; abstract;
   {$If NOT Defined(Nemesis)}
   procedure Execute(const aContext: TncsExecuteContext);
   {$IfEnd} // NOT Defined(Nemesis)
  public
   constructor Create(aList: TddServerTaskList;
    aProc: TalcuSpeedupRequestProc); reintroduce;
   class function Make(aList: TddServerTaskList;
    aProc: TalcuSpeedupRequestProc): IncsExecutor; reintroduce;
 end;//TalcuDocTransferRequestExecutor
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 //#UC START# *57D2A6A70025impl_uses*
 //#UC END# *57D2A6A70025impl_uses*
;

constructor TalcuDocTransferRequestExecutor.Create(aList: TddServerTaskList;
 aProc: TalcuSpeedupRequestProc);
//#UC START# *57C00BDA02BA_57D2A6A70025_var*
//#UC END# *57C00BDA02BA_57D2A6A70025_var*
begin
//#UC START# *57C00BDA02BA_57D2A6A70025_impl*
 inherited Create(aList);
 f_RequestImmidiateProcessProc := aProc;
//#UC END# *57C00BDA02BA_57D2A6A70025_impl*
end;//TalcuDocTransferRequestExecutor.Create

class function TalcuDocTransferRequestExecutor.Make(aList: TddServerTaskList;
 aProc: TalcuSpeedupRequestProc): IncsExecutor;
var
 l_Inst : TalcuDocTransferRequestExecutor;
begin
 l_Inst := Create(aList, aProc);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TalcuDocTransferRequestExecutor.Make

procedure TalcuDocTransferRequestExecutor.SpeedupRequest;
//#UC START# *57D2A73303CC_57D2A6A70025_var*
//#UC END# *57D2A73303CC_57D2A6A70025_var*
begin
//#UC START# *57D2A73303CC_57D2A6A70025_impl*
 if Assigned(f_RequestImmidiateProcessProc) then
  f_RequestImmidiateProcessProc;
//#UC END# *57D2A73303CC_57D2A6A70025_impl*
end;//TalcuDocTransferRequestExecutor.SpeedupRequest

{$If NOT Defined(Nemesis)}
procedure TalcuDocTransferRequestExecutor.Execute(const aContext: TncsExecuteContext);
//#UC START# *54607DDC0159_57D2A6A70025_var*
//#UC END# *54607DDC0159_57D2A6A70025_var*
begin
//#UC START# *54607DDC0159_57D2A6A70025_impl*
 DoExecute(aContext);
//#UC END# *54607DDC0159_57D2A6A70025_impl*
end;//TalcuDocTransferRequestExecutor.Execute
{$IfEnd} // NOT Defined(Nemesis)

{$IfEnd} // Defined(ServerTasks)
end.
