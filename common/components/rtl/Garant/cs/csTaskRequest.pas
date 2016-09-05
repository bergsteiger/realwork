unit csTaskRequest;

interface

uses
  Classes,
  CsDataPipe,
  ddServerTask,
  csRequestTask,
  daTypes,
  csProcessTask,

  askRequest,
  ddTaskResultRequestPrim,
  ddGetTaskRequestPrim
  ;

type
(* TaskRequest = class(TddRequestTask)
 public
  procedure SetTaskID(aTaskID: String);
 end;//TaskRequest*)

 TddTaskResultRequest = class(TddTaskResultRequestPrim)
 private
  f_RequestTaskID: ShortString;
  f_TaskResult: TStream;
 protected
  procedure Cleanup; override;
 public
  constructor Create(aUserID: TdaUserID); override;
  constructor MakeFromTask(aTask: TddProcessTask);
  procedure SaveRequestToPipe(aPipe: TCsDataPipe); override;
  property TaskResult: TStream read f_TaskResult;
 end;//TddTaskResultRequest

 TddGetTaskRequest = class(TddGetTaskRequestPrim)
 private
  f_Task: TddTaskItem;
 protected
  procedure Cleanup; override;
 public
  constructor Create(aUserID: TdaUserID); override;
  procedure SaveRequestToPipe(aPipe: TCsDataPipe); override;
  property Task: TddTaskItem read f_Task;
 end;//TddTaskResultRequest


implementation

uses
  CsTaskTypes, l3Memory, l3TempMemoryStream, l3Base, SysUtils, StrUtils,
  DateUtils,

  daInterfaces
  ;

constructor TddTaskResultRequest.Create(aUserID: TdaUserID);
begin
  inherited;
  //TaskType := cs_ttTaskResult;
  f_TaskResult := Tl3TempMemoryStream.Create;
end;

constructor TddTaskResultRequest.MakeFromTask(aTask: TddProcessTask);
begin
 Create(0);
 if aTask <> nil then
  AssignFrom(aTask);
end;

procedure TddTaskResultRequest.Cleanup;
begin
 l3Free(f_TaskResult);
 inherited Cleanup;
end;

procedure TddTaskResultRequest.SaveRequestToPipe(aPipe: TCsDataPipe);
begin
 aPipe.WriteLn(TaskID);
 aPipe.ReadStream(f_TaskResult);
 f_TaskResult.Seek(0, 0);
end;

{
******************************** TddRequestTask ********************************
}
constructor TddGetTaskRequest.Create(aUserID: TdaUserID);
begin
 inherited;
 //TaskType := cs_ttGetTask;
end;

procedure TddGetTaskRequest.Cleanup;
begin
 l3Free(f_Task);
 inherited Cleanup;
end;

procedure TddGetTaskRequest.SaveRequestToPipe(aPipe: TCsDataPipe);
var
 i: Integer;
 l_Stream: TStream;
 l_Position : Int64;
begin
 //inherited;
 aPipe.WriteLn(TaskID);
 l_Stream := Tl3MemoryStream.Make;
 try
  aPipe.ReadStream(l_Stream);
  l_Stream.Seek(0, 0);
  FreeAndNil(f_Task);
  f_Task := TddTaskItem.MakeFrom(l_Stream, '', False);
  if (f_Task = nil) then
  begin
   // В принципе, можно создавать базового предка
   l_Stream.Seek(0, 0);
   f_Task := TddTaskItem.Create(usNotDefined{UserID});
   f_Task.LoadFrom(l_Stream, true);
  end;//f_Task = nil
  f_Task.TaskID := Self.TaskID;
 finally
  l3Free(l_Stream);
 end;
end;

(*procedure TaskRequest.SetTaskID(aTaskID: String);
var
 l_Day, l_Month, l_Sec, l_MSec: Word;
 l_Pos, l_PredPos: Integer;
begin
 // строка вида UserID-Day-Month-Second-Millicecond
 l_Pos := Pos('-', aTaskID);
 UserIDW := StrToIntDef(Copy(aTaskID, 1, Pred(l_Pos)), 0);
 l_PredPos := Succ(l_Pos);
 l_Pos := PosEx('-', aTaskID, l_PredPos);
 l_Day := StrToIntDef(Copy(aTaskID, l_PredPos, l_Pos-l_PredPos), 0);
 l_PredPos := Succ(l_Pos);
 l_Pos := PosEx('-', aTaskID, l_PredPos);
 l_Month := StrToIntDef(Copy(aTaskID, l_PredPos, l_Pos-l_PredPos), 0);
 l_PredPos := Succ(l_Pos);
 l_Pos := PosEx('-', aTaskID, l_PredPos);
 l_Sec := StrToIntDef(Copy(aTaskID, l_PredPos, l_Pos-l_PredPos), 0);
 l_PredPos := Succ(l_Pos);
 l_MSec := StrToIntDef(Copy(aTaskID, l_PredPos, Length(aTaskID)), 0);
 DateW := RecodeDate(Date, 2004, l_Month, l_Day);
 DateW := RecodeTime(Date, 0, 0, l_Sec, l_MSec);
end;*)


initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\cs\csTaskRequest.pas initialization enter'); {$EndIf}
 RegisterTaskClass(cs_ttGetTask, TddGetTaskRequest, 'запрос задания');
 RegisterTaskClass(cs_ttTaskResult, TddTaskResultRequest, 'запрос результата задания');
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\cs\csTaskRequest.pas initialization leave'); {$EndIf}
end.
