unit alcuGetFilePartExecutor;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuGetFilePartExecutor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuGetFilePartExecutor" MUID: (54759BFB02B4)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

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
 TalcuGetFilePartExecutor = class(TalcuExecutorWithTaskList{$If NOT Defined(Nemesis)}
 , IncsExecutor
 {$IfEnd} // NOT Defined(Nemesis)
 )
  protected
   {$If NOT Defined(Nemesis)}
   procedure Execute(const aContext: TncsExecuteContext);
   {$IfEnd} // NOT Defined(Nemesis)
  public
   class function Make(aTaskList: TalcuTaskList): IncsExecutor; reintroduce;
 end;//TalcuGetFilePartExecutor
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 {$If Defined(AppServerSide)}
 , alcuTaskListBase
 {$IfEnd} // Defined(AppServerSide)
 {$If NOT Defined(Nemesis)}
 , ncsGetFilePart
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csProcessTask
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsGetFilePartReply
 {$IfEnd} // NOT Defined(Nemesis)
 , l3Stream
 , Classes
 , l3Types
 , SysUtils
 {$If NOT Defined(Nemesis)}
 , csExport
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsPushFilePart
 {$IfEnd} // NOT Defined(Nemesis)
 , Math
 {$If NOT Defined(Nemesis)}
 , ncsProfile
 {$IfEnd} // NOT Defined(Nemesis)
 , l3Base
 //#UC START# *54759BFB02B4impl_uses*
 //#UC END# *54759BFB02B4impl_uses*
;

class function TalcuGetFilePartExecutor.Make(aTaskList: TalcuTaskList): IncsExecutor;
var
 l_Inst : TalcuGetFilePartExecutor;
begin
 l_Inst := Create(aTaskList);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TalcuGetFilePartExecutor.Make

{$If NOT Defined(Nemesis)}
procedure TalcuGetFilePartExecutor.Execute(const aContext: TncsExecuteContext);
//#UC START# *54607DDC0159_54759BFB02B4_var*
var
 l_Message: TncsGetFilePart;
 l_Reply: TncsGetFilePartReply;

 function DoProcess(anItem: TddProcessTask): Boolean;
 var
  l_Task: TcsExport;
  l_Stream: TStream;
  l_FileName: AnsiString;
  l_ToCopyCount: Int64;
  l_PushMessage: TncsPushFilePart;
 begin
  g_ReceivePartFile.Start;
  try
   Result := False;
   l_Task := anItem as TcsExport;
   l_FileName := IncludeTrailingPathDelimiter(l_Task.TaskFolder) + l_Message.FileName;
   if FileExists(l_FileName) then
   begin
    l_Stream := Tl3FileStream.Create(l_FileName, l3_fmRead);
    try
     if l_Stream.Size < (l_Message.Offset + l_Message.PartSize) then
     begin
      l3System.Msg2Log('Обшика доставки - запросили файл за его границами');
      Exit;
     end;
     if l_Message.PartSize < 0 then
     begin
      l3System.Msg2Log('Обшика доставки - запросили нулевой пакет данных');
      Exit;
     end;
     l_Stream.Seek(l_Message.Offset, soBeginning);
     l_ToCopyCount := l_Stream.Size - l_Message.Offset;
     while l_ToCopyCount > 0 do
     begin
      if not aContext.rTransporter.Processing then
      begin
       l3System.Msg2Log('Обшика доставки - обрыв связи');
       Exit;
      end;
      l_PushMessage := TncsPushFilePart.Create;
      try
       l_PushMessage.TaskID := l_Message.TaskID;
       l_PushMessage.FileName := l_Message.FileName;
       l_PushMessage.Offset := l_Stream.Position;
       l_PushMessage.PartSize := Min(l_Message.PartSize, l_ToCopyCount);
       g_WriteFile.Start;
       try
        l_PushMessage.Data.CopyFrom(l_Stream, l_PushMessage.PartSize);
       finally
        g_WriteFile.Stop;
       end; 
       aContext.rTransporter.Send(l_PushMessage);
       Dec(l_ToCopyCount, l_PushMessage.PartSize);
      finally
       FreeAndNil(l_PushMessage);
      end;
     end;
     l_Reply.IsSuccess := True;
    finally
     FreeAndNil(l_Stream);
    end;
   end;
  finally
   g_ReceivePartFile.Stop;
  end;
 end;

//#UC END# *54607DDC0159_54759BFB02B4_var*
begin
//#UC START# *54607DDC0159_54759BFB02B4_impl*
 l_Message := aContext.rMessage as TncsGetFilePart;
 l_Reply := TncsGetFilePartReply.Create(l_Message);
 try
  l_Reply.IsSuccess := False;
  if not TaskList.ForOneByIDF(L2AlcuTasksIteratorForOneByIDFAction(@DoProcess), l_Message.TaskID) then
   l3System.Msg2Log('Задача с идентификатором %s не найдена (запрос файла)', [l_Message.TaskID]);
  aContext.rTransporter.Send(l_Reply);
 finally
  FreeAndNil(l_Reply);
 end;
//#UC END# *54607DDC0159_54759BFB02B4_impl*
end;//TalcuGetFilePartExecutor.Execute
{$IfEnd} // NOT Defined(Nemesis)

{$IfEnd} // Defined(ServerTasks)
end.
