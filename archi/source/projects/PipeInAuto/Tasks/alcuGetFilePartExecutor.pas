unit alcuGetFilePartExecutor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuGetFilePartExecutor.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::ResultDelivery::TalcuGetFilePartExecutor
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
 TalcuGetFilePartExecutor = class(TalcuExecutorWithTaskList {$If not defined(Nemesis)}, IncsExecutor{$IfEnd} //not Nemesis
 )
 protected
 // realized methods
   {$If not defined(Nemesis)}
   procedure Execute(const aContext: TncsExecuteContext);
   {$IfEnd} //not Nemesis
 public
 // public methods
   class function Make(aTaskList: TalcuTaskList): IncsExecutor; reintroduce;
     {* Сигнатура фабрики TalcuGetFilePartExecutor.Make }
 end;//TalcuGetFilePartExecutor
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
  ncsGetFilePart
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  csProcessTask
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  ncsGetFilePartReply
  {$IfEnd} //not Nemesis
  ,
  l3Stream,
  l3Types
  {$If not defined(Nemesis)}
  ,
  csExport
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  ncsPushFilePart
  {$IfEnd} //not Nemesis
  ,
  Math
  {$If not defined(Nemesis)}
  ,
  ncsProfile
  {$IfEnd} //not Nemesis
  ,
  l3Base
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}

// start class TalcuGetFilePartExecutor

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
end;

{$If not defined(Nemesis)}
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
{$IfEnd} //not Nemesis

{$IfEnd} //ServerTasks

end.