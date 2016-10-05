unit alcuMultiOperationExecutor;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuMultiOperationExecutor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuMultiOperationExecutor" MUID: (57EE6E97018D)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuDocTransferRequestExecutor
 {$If NOT Defined(Nemesis)}
 , ncsMessageInterfaces
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuMultiOperationExecutor = class(TalcuDocTransferRequestExecutor)
  protected
   procedure DoExecute(const aContext: TncsExecuteContext); override;
 end;//TalcuMultiOperationExecutor
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , l3StopWatch
 , l3Base
 , l3Types
 {$If NOT Defined(Nemesis)}
 , csMultiOperation
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csMultiOperationReply
 {$IfEnd} // NOT Defined(Nemesis)
 , SysUtils
 , daInterfaces
 //#UC START# *57EE6E97018Dimpl_uses*
 //#UC END# *57EE6E97018Dimpl_uses*
;

procedure TalcuMultiOperationExecutor.DoExecute(const aContext: TncsExecuteContext);
//#UC START# *57D2A771002F_57EE6E97018D_var*
//#UC END# *57D2A771002F_57EE6E97018D_var*
begin
//#UC START# *57D2A771002F_57EE6E97018D_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *57D2A771002F_57EE6E97018D_impl*
end;//TalcuMultiOperationExecutor.DoExecute
{$IfEnd} // Defined(ServerTasks)

end.
