unit alcuGetTaskDescriptionExecutor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuGetTaskDescriptionExecutor.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::ResultDelivery::TalcuGetTaskDescriptionExecutor
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
  alcuExecutorWithTaskList
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuGetTaskDescriptionExecutor = class(TalcuExecutorWithTaskList {$If not defined(Nemesis)}, IncsExecutor{$IfEnd} //not Nemesis
 )
 protected
 // realized methods
   {$If not defined(Nemesis)}
   procedure Execute(const aContext: TncsExecuteContext);
   {$IfEnd} //not Nemesis
 public
 // public methods
   class function Make(aTaskList: TalcuTaskList): IncsExecutor; reintroduce;
     {* Сигнатура фабрики TalcuGetTaskDescriptionExecutor.Make }
 end;//TalcuGetTaskDescriptionExecutor
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  SysUtils
  {$If not defined(Nemesis)}
  ,
  csProcessTask
  {$IfEnd} //not Nemesis
  
  {$If defined(AppServerSide) AND defined(ServerTasks)}
  ,
  alcuTaskListBase
  {$IfEnd} //AppServerSide AND ServerTasks
  
  {$If not defined(Nemesis)}
  ,
  ncsGetTaskDescription
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  ncsGetTaskDescriptionReply
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  csTaskTypes
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  csExport
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  ncsFileDesc
  {$IfEnd} //not Nemesis
  ,
  ddFileIterator,
  l3Stream,
  l3Types,
  l3CRCUtils,
  l3Base
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}

// start class TalcuGetTaskDescriptionExecutor

class function TalcuGetTaskDescriptionExecutor.Make(aTaskList: TalcuTaskList): IncsExecutor;
var
 l_Inst : TalcuGetTaskDescriptionExecutor;
begin
 l_Inst := Create(aTaskList);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

{$If not defined(Nemesis)}
procedure TalcuGetTaskDescriptionExecutor.Execute(const aContext: TncsExecuteContext);
//#UC START# *54607DDC0159_546B540E02D6_var*
var
 l_Reply: TncsGetTaskDescriptionReply;
 l_TaskID: AnsiString;

 function DoProcess(anItem: TddProcessTask): Boolean;
 var
  l_Task: TcsExport;
  l_FileIterator: TddFileIterator;
  l_Ptr: TddIterateProc;

  function DoProcessOneFile(const aFileName: AnsiString): Boolean;
  var
   l_FileDesc: TncsFileDesc;
   l_Stream: TStream;
  begin
   Result := True;
   l_FileDesc := TncsFileDesc.Create;
   try
    l_FileDesc.Name := ExtractRelativePath(l_Reply.RemoteFolder, aFileName);
    l_FileDesc.DateTime := FileAge(aFileName);
    l_Stream := Tl3FileStream.Create(aFileName, l3_fmRead);
    try
     l_FileDesc.Size := l_Stream.Size;
     l_FileDesc.CRC := l3CalcCRC32(l_Stream);
    finally
     FreeAndNil(l_Stream);
    end;
    l_Reply.FileDesc.Add(l_FileDesc.TaggedData);
   finally
    FreeAndNil(l_FileDesc);
   end;
  end;

 begin
  Result := False;
  l_Task := (anItem as TcsExport);
  l_Reply.RemoteFolder := IncludeTrailingPathDelimiter(l_Task.TaskFolder);
  l_Reply.LocalFolder := IncludeTrailingPathDelimiter(l_Task.ExportDirectory);
  l_Task.SetProgress(0, '');
  l_Task.RequestDelivering;
  l3System.Msg2Log('Передача пользователю результатов экспорта');
  l3System.Msg2Log('Задача от пользователя: %d', [l_Task.UserID]);
  l_FileIterator := TddFileIterator.Make(l_Reply.RemoteFolder, '*.*', nil, True);
  try
   l_Ptr := L2IterateFilesProc(@DoProcessOneFile);
   try
    l_FileIterator.IterateFiles(l_Ptr);
   finally
    FreeIterateFilesProc(l_Ptr);
   end;
  finally
   FreeANdNil(l_FileIterator);
  end;
 end;

//#UC END# *54607DDC0159_546B540E02D6_var*
begin
//#UC START# *54607DDC0159_546B540E02D6_impl*
 l_TaskID := (aContext.rMessage as TncsGetTaskDescription).TaskID;
 l_Reply := TncsGetTaskDescriptionReply.Create(aContext.rMessage);
 try
  TaskList.ForOneByIDF(L2AlcuTasksIteratorForOneByIDFAction(@DoProcess), l_TaskID);
  aContext.rTransporter.Send(l_Reply);
 finally
  FreeAndNil(l_Reply);
 end;
//#UC END# *54607DDC0159_546B540E02D6_impl*
end;//TalcuGetTaskDescriptionExecutor.Execute
{$IfEnd} //not Nemesis

{$IfEnd} //ServerTasks

end.