unit csExportResultRequest;

interface

uses CsDataPipe, csProcessTask, csRequestTask;

type
 TcsExportResultRequest = class(TddRequestTask)
 private
  f_DestFolder: string;
  f_Success: Boolean;
 public
  constructor MakeFromTask(aTask: TddProcessTask);
  procedure SaveRequestToPipe(aPipe: TCsDataPipe); override;
  property DestFolder: string read f_DestFolder write f_DestFolder;
  property Success: Boolean read f_Success write f_Success;
 end;

implementation

constructor TcsExportResultRequest.MakeFromTask(aTask: TddProcessTask);
begin
 Assert(aTask <> nil);
 Create(aTask.UserID);
 AssignFrom(aTask);
end;

procedure TcsExportResultRequest.SaveRequestToPipe(aPipe: TCsDataPipe);
begin
 aPipe.WriteLn(TaskID);
 Success:= aPipe.ReadFolder(DestFolder);
end;

end.
