unit alcuServerFilesDeliverer;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuServerFilesDeliverer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuServerFilesDeliverer" MUID: (5811BB7F013F)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 {$If NOT Defined(Nemesis)}
 , ncsServerFilesDeliverer
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(AppServerSide)}
 , alcuTaskList
 {$IfEnd} // Defined(AppServerSide)
 , alcuDeliveryInterfaces
 {$If NOT Defined(Nemesis)}
 , CsDataPipe
 {$IfEnd} // NOT Defined(Nemesis)
 , Classes
 , evdNcsTypes
;

type
 TalcuServerFilesDeliverer = class({$If NOT Defined(Nemesis)}
 TncsServerFilesDeliverer
 {$IfEnd} // NOT Defined(Nemesis)
 )
  private
   f_TasksList: TalcuTaskList;
   f_Finisher: IalcuTaskFinisher;
  protected
   {$If NOT Defined(Nemesis)}
   procedure FillTasksList(aList: TStringList); override;
   {$IfEnd} // NOT Defined(Nemesis)
   {$If NOT Defined(Nemesis)}
   procedure DoSetDeliveryResult(const aTaskID: AnsiString;
    aResult: TncsResultKind); override;
   {$IfEnd} // NOT Defined(Nemesis)
   {$If NOT Defined(Nemesis)}
   procedure DoCorrectTargetFolder(const aTaskID: AnsiString;
    const aNewFolder: AnsiString); override;
   {$IfEnd} // NOT Defined(Nemesis)
   {$If NOT Defined(Nemesis)}
   procedure DoSendFilesList(const aTaskID: AnsiString;
    out theTargetFolder: AnsiString;
    aFilesList: TStringList;
    out theTotalSize: Int64); override;
   {$IfEnd} // NOT Defined(Nemesis)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aPipe: TCsDataPipe;
    aTasksList: TalcuTaskList;
    const aFinisher: IalcuTaskFinisher); reintroduce;
 end;//TalcuServerFilesDeliverer
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , SysUtils
 {$If NOT Defined(Nemesis)}
 , csProcessTask
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(AppServerSide)}
 , alcuTaskListBase
 {$IfEnd} // Defined(AppServerSide)
 {$If NOT Defined(Nemesis)}
 , csTaskTypes
 {$IfEnd} // NOT Defined(Nemesis)
 , l3Base
 {$If NOT Defined(Nemesis)}
 , csExport
 {$IfEnd} // NOT Defined(Nemesis)
 , TypInfo
 //#UC START# *5811BB7F013Fimpl_uses*
 //#UC END# *5811BB7F013Fimpl_uses*
;

{$If NOT Defined(Nemesis)}
constructor TalcuServerFilesDeliverer.Create(aPipe: TCsDataPipe;
 aTasksList: TalcuTaskList;
 const aFinisher: IalcuTaskFinisher);
//#UC START# *5811FA310130_5811BB7F013F_var*
//#UC END# *5811FA310130_5811BB7F013F_var*
begin
//#UC START# *5811FA310130_5811BB7F013F_impl*
 inherited Create(aPipe);
 aTasksList.SetRefTo(f_TasksList);
 f_Finisher := aFinisher;
//#UC END# *5811FA310130_5811BB7F013F_impl*
end;//TalcuServerFilesDeliverer.Create

procedure TalcuServerFilesDeliverer.FillTasksList(aList: TStringList);
//#UC START# *5811F1350098_5811BB7F013F_var*

 function DoIt(anItem: TddProcessTask): Boolean;
 begin
  Result := true;
  if (anItem.Status = cs_tsReadyToDelivery) and (anItem.UserID = DataPipe.ClientID) then
   aList.Add(anItem.TaskID);
 end;

//#UC END# *5811F1350098_5811BB7F013F_var*
begin
//#UC START# *5811F1350098_5811BB7F013F_impl*
 aList.Clear;
 f_TasksList.ForEachF(L2AlcuTasksIteratorForEachFAction(@DoIt));
//#UC END# *5811F1350098_5811BB7F013F_impl*
end;//TalcuServerFilesDeliverer.FillTasksList

procedure TalcuServerFilesDeliverer.DoSetDeliveryResult(const aTaskID: AnsiString;
 aResult: TncsResultKind);
//#UC START# *58133D420395_5811BB7F013F_var*

 function DoProcess(anItem: TddProcessTask): Boolean;
 begin
  Result := False;
  if aResult = ncs_rkFail then
   anItem.Error('Доставка завершилась ошибкой');
  if aResult <> ncs_rkRetry then
   f_Finisher.TaskDone(anItem)
  else
   anItem.RequestDelivery;
 end;

//#UC END# *58133D420395_5811BB7F013F_var*
begin
//#UC START# *58133D420395_5811BB7F013F_impl*
 if not f_TasksList.ForOneByIDF(L2AlcuTasksIteratorForOneByIDFAction(@DoProcess), aTaskID) then
  l3System.Msg2Log('Задача с идентификатором %s не найдена (результат передачи)', [aTaskID]);
 l3System.Msg2Log('Результат передачи %s - %s', [aTaskID, GetEnumName(TypeInfo(TncsResultKind), Ord(aResult))]);
 l3System.Msg2Log('Передача результатов завершена');
//#UC END# *58133D420395_5811BB7F013F_impl*
end;//TalcuServerFilesDeliverer.DoSetDeliveryResult

procedure TalcuServerFilesDeliverer.DoCorrectTargetFolder(const aTaskID: AnsiString;
 const aNewFolder: AnsiString);
//#UC START# *58133D520215_5811BB7F013F_var*

 function DoProcess(anItem: TddProcessTask): Boolean;
 var
  l_Task: TcsExport;
 begin
  Result := False;
  l_Task := anItem as TcsExport;
  l_Task.ExportDirectory := aNewFolder;
  l_Task.Description := l_Task.DefaultDescription;
 end;

//#UC END# *58133D520215_5811BB7F013F_var*
begin
//#UC START# *58133D520215_5811BB7F013F_impl*
 if not f_TasksList.ForOneByIDF(L2AlcuTasksIteratorForOneByIDFAction(@DoProcess), aTaskID) then
  l3System.Msg2Log('Задача с идентификатором ' + aTaskID + ' не найдена');
 l3System.Msg2Log('Скорректирован каталог доставки');
//#UC END# *58133D520215_5811BB7F013F_impl*
end;//TalcuServerFilesDeliverer.DoCorrectTargetFolder

procedure TalcuServerFilesDeliverer.DoSendFilesList(const aTaskID: AnsiString;
 out theTargetFolder: AnsiString;
 aFilesList: TStringList;
 out theTotalSize: Int64);
//#UC START# *581740EB03A8_5811BB7F013F_var*
//#UC END# *581740EB03A8_5811BB7F013F_var*
begin
//#UC START# *581740EB03A8_5811BB7F013F_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *581740EB03A8_5811BB7F013F_impl*
end;//TalcuServerFilesDeliverer.DoSendFilesList

procedure TalcuServerFilesDeliverer.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5811BB7F013F_var*
//#UC END# *479731C50290_5811BB7F013F_var*
begin
//#UC START# *479731C50290_5811BB7F013F_impl*
 FreeAndNil(f_TasksList);
 f_Finisher := nil;
 inherited;
//#UC END# *479731C50290_5811BB7F013F_impl*
end;//TalcuServerFilesDeliverer.Cleanup
{$IfEnd} // NOT Defined(Nemesis)

{$IfEnd} // Defined(ServerTasks)
end.
