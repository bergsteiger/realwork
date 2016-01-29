unit csClientCommandsManager;

interface

uses
 csClient, csCommandsManager, CsDataPipe, csCommandsTypes,
 Menus;

type
 TcsClientCommandsManager = class(TcsCommandsManager)
 private
  f_CSClient: TcsClient;
//  function pm_GetCommandEnabled(Command: TcsCommands): Boolean;
  function pm_GetCustomCommands(Index: Integer): TcsCommand;
  function pm_GetCustomCommandsCount: Integer;
(*  procedure RequestParams(aCommand: TcsCommand);*)
 public
  procedure ExecuteCommand(Sender: TObject);
  procedure LoadCommands(aPipe: TcsDataPipe);
  procedure UpdateServerMenu(theServerMenu: TMenuItem);
//  property CommandEnabled[Command: TcsCommands]: Boolean read pm_GetCommandEnabled;
  property CSClient: TcsClient read f_CSClient write f_CSClient;
  property CustomCommands[Index: Integer]: TcsCommand read pm_GetCustomCommands;
  property CustomCommandsCount: Integer read pm_GetCustomCommandsCount;
 end;

implementation

uses
 ActnList, CsQueryTypes, l3Memory, SysUtils, csCommandsConst, Dialogs,
 StrUtils, l3Base, FileCtrl, csImport, csTaskTypes, ddFileIterator,
 daDataProvider, 
 l3ProtoObject
 ;

type
  TcsClientCommandsManagerHelper = class(Tl3ProtoObject)
    private
      CommandID : Integer;
      procedure ExecuteOnServer(aPipe: TcsDataPipe);
  end;//TcsClientCommandsManagerHelper

procedure TcsClientCommandsManagerHelper.ExecuteOnServer(aPipe: TcsDataPipe);
(*var
 l_Stream: TStream;*)
begin
 aPipe.WriteCardinal(GlobalDataProvider.UserID);
 //l_Stream:= Tl3MemoryStream.Create;
 //try
  //Save(l_Stream);
  //aPipe.Write(l_Stream);
 //finally
 // FreeAndNil(l_Stream);
 //end;
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
//  RequestParams(l_Command);
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
   //l_Command:= TcsCommand(l_Stream.ReadComponent(nil));
   l_Command:= TcsCommand.Create(l_Stream{, ExecuteCommand});
   try
    //l_Command.Load(l_Stream);
    //l_Command.OnExecute := ExecuteCommand;
    Add(l_Command);
   finally
    FreeAndNil(l_Command);
   end;//try..finally
  end; // for i
 finally
  FreeAndNil(l_Stream);
 end;
end;

(*function TcsClientCommandsManager.pm_GetCommandEnabled(Command: TcsCommands): Boolean;
var
 l_C: TcsCommand;
begin
 Result := CommandExists(Command, l_C);
end;*)

function TcsClientCommandsManager.pm_GetCustomCommands(Index: Integer): TcsCommand;
var
 i, l_Index: Integer;
begin
 Result := nil;
 l_Index:= -1;
 for i:= 0 to Pred(Count) do
  if Commands[i].CommandID > c_CommandBaseIndex then
  begin
   Inc(l_Index);
   if l_Index = Index then
    Result:= Commands[i];
  end;
end;

function TcsClientCommandsManager.pm_GetCustomCommandsCount: Integer;
var
 i: Integer;
begin
 Result := 0;
 for i:= 0 to Pred(Count) do
  if Commands[i].CommandID > c_CommandBaseIndex then
   Inc(Result);
end;

(*procedure TcsClientCommandsManager.RequestParams(aCommand: TcsCommand);
var
 l_Folder: String;
begin
 if aCommand.LinkTask <> nil then
 begin
  case aCommand.LinkTask.TaskType of
   cs_ttAACImport: // Запрашиваем папку с данными, забираем оттуда евдшники
    if SelectDirectory(l_Folder, [], 0) then
    begin
     with TddFileIterator.Make(l_Folder, '*.evd') do
     try
      TcsAACImport(aCommand.LinkTask).SourceFiles.Assign(FileList);
     finally
      Free;
     end;
    end;
  end;
 end;
end;*)

procedure TcsClientCommandsManager.UpdateServerMenu(theServerMenu: TMenuItem);
var
 i: Integer;
 l_MI: TMenuItem;
begin
 theServerMenu.Clear;
 theServerMenu.Visible:= CustomCommandsCount > 0;
 for i:= 0 to CustomCommandsCount-1 do
 begin
  l_MI:= TmenuItem.Create(theServerMenu);
  l_MI.Name:= 'ServerMenu'+ IntToStr(CustomCommands[i].CommandID);
  l_MI.Tag:= CustomCommands[i].CommandID;
  l_MI.Caption:= CustomCommands[i].Caption;
  //l_MI.OnClick:= CustomCommands[i].OnExecute;
  l_MI.OnClick:= ExecuteCommand;
  theServerMenu.Add(l_MI);
 end;
end;

end.
