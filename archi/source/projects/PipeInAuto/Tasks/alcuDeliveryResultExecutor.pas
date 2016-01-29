unit alcuDeliveryResultExecutor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuDeliveryResultExecutor.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::ResultDelivery::TalcuDeliveryResultExecutor
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
  Classes
  {$If defined(AppServerSide) AND defined(ServerTasks)}
  ,
  alcuTaskList
  {$IfEnd} //AppServerSide AND ServerTasks
  
  {$If not defined(Nemesis)}
  ,
  ncsMessageInterfaces
  {$IfEnd} //not Nemesis
  ,
  alcuExecutorWithTaskList,
  alcuDeliveryInterfaces
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuDeliveryResultExecutor = class(TalcuExecutorWithTaskList {$If not defined(Nemesis)}, IncsExecutor{$IfEnd} //not Nemesis
 )
 private
 // private fields
   f_Finisher : IalcuTaskFinisher;
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
   constructor Create(aTaskList: TalcuTaskList;
     const aFinisher: IalcuTaskFinisher); reintroduce;
   class function Make(aTaskList: TalcuTaskList;
     const aFinisher: IalcuTaskFinisher): IncsExecutor; reintroduce;
     {* Сигнатура фабрики TalcuDeliveryResultExecutor.Make }
 end;//TalcuDeliveryResultExecutor
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  SysUtils
  {$If defined(AppServerSide) AND defined(ServerTasks)}
  ,
  alcuTaskListBase
  {$IfEnd} //AppServerSide AND ServerTasks
  
  {$If not defined(Nemesis)}
  ,
  ncsDeliveryResult
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  csProcessTask
  {$IfEnd} //not Nemesis
  ,
  l3Base,
  evdNcsTypes,
  TypInfo
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}

// start class TalcuDeliveryResultExecutor

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
end;

{$If not defined(Nemesis)}
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
{$IfEnd} //not Nemesis

procedure TalcuDeliveryResultExecutor.Cleanup;
//#UC START# *479731C50290_54759BE1037A_var*
//#UC END# *479731C50290_54759BE1037A_var*
begin
//#UC START# *479731C50290_54759BE1037A_impl*
 f_Finisher := nil;
 inherited;
//#UC END# *479731C50290_54759BE1037A_impl*
end;//TalcuDeliveryResultExecutor.Cleanup

{$IfEnd} //ServerTasks

end.