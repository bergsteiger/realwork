unit csClientCommandsManager;

interface

uses
 csClient, csCommandsManager, CsDataPipe, csCommandsTypes;

type
 TcsClientCommandsManager = class(TcsCommandsManager)
 private
  f_CSClient: TcsClient;
 public
  procedure ExecuteCommand(Sender: TObject); override;
  procedure LoadCommands(aPipe: TcsDataPipe);
  property CSClient: TcsClient read f_CSClient write f_CSClient;
 end;

implementation

uses
 ActnList, CsQueryTypes, l3Memory, SysUtils, csCommandsConst, Dialogs,
 StrUtils, l3Base, FileCtrl, csImport, csTaskTypes, ddFileIterator,
 daDataProvider, Menus,
 l3ProtoObject
 ;

type
  TcsClientCommandsManagerHelper = class(Tl3ProtoObject)
    private
      CommandID : Integer;
      procedure ExecuteOnServer(aPipe: TcsDataPipe);
  end;//TcsClientCommandsManagerHelper

procedure TcsClientCommandsManagerHelper.ExecuteOnServer(aPipe: TcsDataPipe);
begin
 aPipe.WriteCardinal(GlobalDataProvider.UserID);
 aPipe.WriteInteger(CommandID);
end;

procedure TcsClientCommandsManager.ExecuteCommand(Sender: TObject);
var
 l_Command: TcsCommand;
 l_Result: Boolean;
 l_Helper : TcsClientCommandsManagerHelper;
begin
 Assert(Sender Is TMenuItem);
 Assert(f_CSClient <> nil);
 if CommandExists(TMenuItem(Sender).Tag, l_Command) then
 begin
  l_Helper := TcsClientCommandsManagerHelper.Create;
  try
   l_Helper.CommandID := l_Command.CommandID;
   l_Result:= f_CSClient.Exec(qtExecuteCommand, l_Helper.ExecuteOnServer);
  finally
   FreeAndNil(l_Helper);
  end;//try..finally
  if l_Command.NeedRespond then
   MessageDlg(IfThen(l_Result, 'Команда отправлена на сервер', 'Не удалось передать команду'), mtInformation, [mbOk], 0);
 end;
end;

procedure TcsClientCommandsManager.LoadCommands(aPipe: TcsDataPipe);
var
 l_Stream: Tl3MemoryStream;
 l_Count, i: Integer;
 l_Command: TcsCommand;
begin
 ClearCommands;
 l_Stream:= Tl3MemoryStream.Create;
 try
  aPipe.ReadStream(l_Stream);
  l_Stream.Read(l_Count, SizeOf(l_Count));
  for i:= 0 to Pred(l_Count) do
  begin
   l_Command:= TcsCommand.Create(l_Stream);
   try
    Add(l_Command);
   finally
    FreeAndNil(l_Command);
   end;//try..finally
  end; // for i
 finally
  FreeAndNil(l_Stream);
 end;
end;

end.
