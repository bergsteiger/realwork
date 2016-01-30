unit alcuDeliveryResultExecutor;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuDeliveryResultExecutor.pas"
// Стереотип: "SimpleClass"

{$Include alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuExecutorWithTaskList
 {$If NOT Defined(Nemesis)}
 , ncsMessageInterfaces
 {$IfEnd} // NOT Defined(Nemesis)
 , alcuDeliveryInterfaces
 {$If Defined(AppServerSide)}
 , alcuTaskList
 {$IfEnd} // Defined(AppServerSide)
;

type
 TalcuDeliveryResultExecutor = class(TalcuExecutorWithTaskList{$If NOT Defined(Nemesis)}
 , IncsExecutor
 {$IfEnd} // NOT Defined(Nemesis)
 )
  private
   f_Finisher: IalcuTaskFinisher;
  protected
   {$If NOT Defined(Nemesis)}
   procedure Execute(const aContext: TncsExecuteContext);
   {$IfEnd} // NOT Defined(Nemesis)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aTaskList: TalcuTaskList;
    const aFinisher: IalcuTaskFinisher); reintroduce;
   class function Make(aTaskList: TalcuTaskList;
    const aFinisher: IalcuTaskFinisher): IncsExecutor; reintroduce;
 end;//TalcuDeliveryResultExecutor
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 {$If Defined(AppServerSide)}
 , alcuTaskListBase
 {$IfEnd} // Defined(AppServerSide)
 {$If NOT Defined(Nemesis)}
 , ncsDeliveryResult
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csProcessTask
 {$IfEnd} // NOT Defined(Nemesis)
 , l3Base
 , evdNcsTypes
 , TypInfo
;

constructor TalcuDeliveryResultExecutor.Create(aTaskList: TalcuTaskList;
 const aFinisher: IalcuTaskFinisher);
//#UC START# *5475AFFB0169_54759BE1037A_var*
//#UC END# *5475AFFB0169_54759BE1037A_var*
begin
//#UC START# *5475AFFB0169_54759BE1037A_impl*
 inherited Create(aTaskList);
 f_FInisher := aFinisher;
//#UC END# *5475AFFB0169_54759BE1037A_impl*
end;//TalcuDeliveryResultExecutor.Create

class function TalcuDeliveryResultExecutor.Make(aTaskList: TalcuTaskList;
 const aFinisher: IalcuTaskFinisher): IncsExecutor;
var
 l_Inst : TalcuDeliveryResultExecutor;
begin
 l_Inst := Create(aTaskList, aFinisher);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TalcuDeliveryResultExecutor.Make

{$If NOT Defined(Nemesis)}
procedure TalcuDeliveryResultExecutor.Execute(const aContext: TncsExecuteContext);
//#UC START# *54607DDC0159_54759BE1037A_var*
var
 l_Message: TncsDeliveryResult;

 function DoProcess(anItem: TddProcessTask): Boolean;
 begin
  Result := False;
  if l_Message.ResultKind = ncs_rkFail then
   anItem.Error('Доставка завершилась ошибкой');
  if l_Message.ResultKind <> ncs_rkRetry then
   f_Finisher.TaskDone(anItem)
  else
   anItem.RequestDelivery;
 end;

//#UC END# *54607DDC0159_54759BE1037A_var*
begin
//#UC START# *54607DDC0159_54759BE1037A_impl*
 l_Message := aContext.rMessage as TncsDeliveryResult;
 if not TaskList.ForOneByIDF(L2AlcuTasksIteratorForOneByIDFAction(@DoProcess), l_Message.TaskID) then
  l3System.Msg2Log('Задача с идентификатором %s не найдена', [l_Message.TaskID]);
 l3System.Msg2Log('Результат передачи %s - %s', [l_Message.TaskID, GetEnumName(TypeInfo(TncsResultKind), Ord(l_Message.ResultKind))]);
 l3System.Msg2Log('Передача результатов завершена');
//#UC END# *54607DDC0159_54759BE1037A_impl*
end;//TalcuDeliveryResultExecutor.Execute
{$IfEnd} // NOT Defined(Nemesis)

procedure TalcuDeliveryResultExecutor.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_54759BE1037A_var*
//#UC END# *479731C50290_54759BE1037A_var*
begin
//#UC START# *479731C50290_54759BE1037A_impl*
 f_Finisher := nil;
 inherited;
//#UC END# *479731C50290_54759BE1037A_impl*
end;//TalcuDeliveryResultExecutor.Cleanup
{$IfEnd} // Defined(ServerTasks)

end.
