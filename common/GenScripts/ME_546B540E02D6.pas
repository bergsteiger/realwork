unit alcuGetTaskDescriptionExecutor;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuGetTaskDescriptionExecutor.pas"
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
 {$If Defined(AppServerSide)}
 , alcuTaskList
 {$IfEnd} // Defined(AppServerSide)
;

type
 TalcuGetTaskDescriptionExecutor = class(TalcuExecutorWithTaskList{$If NOT Defined(Nemesis)}
 , IncsExecutor
 {$IfEnd} // NOT Defined(Nemesis)
 )
  protected
   {$If NOT Defined(Nemesis)}
   procedure Execute(const aContext: TncsExecuteContext);
   {$IfEnd} // NOT Defined(Nemesis)
  public
   class function Make(aTaskList: TalcuTaskList): IncsExecutor; reintroduce;
 end;//TalcuGetTaskDescriptionExecutor
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , csProcessTask
 {$IfEnd} // NOT Defined(Nemesis)
 , SysUtils
 {$If Defined(AppServerSide)}
 , alcuTaskListBase
 {$IfEnd} // Defined(AppServerSide)
 {$If NOT Defined(Nemesis)}
 , ncsGetTaskDescription
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsGetTaskDescriptionReply
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csTaskTypes
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csExport
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsFileDesc
 {$IfEnd} // NOT Defined(Nemesis)
 , ddFileIterator
 , l3Stream
 , Classes
 , l3Types
 , l3CRCUtils
 , l3Base
;

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
end;//TalcuGetTaskDescriptionExecutor.Make

{$If NOT Defined(Nemesis)}
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
{$IfEnd} // NOT Defined(Nemesis)

{$IfEnd} // Defined(ServerTasks)
end.
