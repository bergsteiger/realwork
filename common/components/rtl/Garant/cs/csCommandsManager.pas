unit csCommandsManager;

interface

{$Include l3XE.inc}

uses
 csCommandsConst,
 IdGlobal,
 l3ObjectRefList, ActnList, Classes, CsDataPipe, ddAppConfigTypes, l3Base, 
 csCommandsTypes,
 l3ProtoObjectRefList,
 SyncObjs,
 l3ProtoObject, Menus
 ;

type
 TcsCommandsManager = class(Tl3ProtoObject)
 private
  f_Commands: Tl3ProtoObjectRefList;
  f_CS: TCriticalSection;
  function pm_GetCommands(Index: Integer): TcsCommand;
  function pm_GetCount: Integer;
  function pm_GetCustomCommands(Index: Integer): TcsCommand;
  function pm_GetCustomCommandsCount: Integer;
 protected
  procedure Acquire;
  procedure Add(aCommand: TcsCommand);
  procedure Cleanup; override;
  procedure Leave;
 public
  constructor Create;
  procedure ClearCommands;
  procedure UpdateServerMenu(theServerMenu: TMenuItem);
  procedure ExecuteCommand(Sender: TObject); virtual; abstract;
  function CommandExists(aID: Integer; out theCommand: TcsCommand): Boolean;
  property Commands[Index: Integer]: TcsCommand read pm_GetCommands;
  property Count: Integer read pm_GetCount;
  property CustomCommands[Index: Integer]: TcsCommand read pm_GetCustomCommands;
  property CustomCommandsCount: Integer read pm_GetCustomCommandsCount;
 end;

implementation

uses
  SysUtils;

constructor TcsCommandsManager.Create;
begin
 inherited;
 f_Commands:= Tl3ProtoObjectRefList.Make;
 f_CS:= TCriticalSection.Create;
end;

procedure TcsCommandsManager.Acquire;
begin
 f_CS.Acquire;
end;

procedure TcsCommandsManager.Add(aCommand: TcsCommand);
begin
 f_Commands.Add(aCommand);
end;

procedure TcsCommandsManager.Cleanup;
begin
 l3Free(f_Commands);
 l3Free(f_CS);
 inherited;
end;

procedure TcsCommandsManager.ClearCommands;
begin
 f_Commands.Clear;
end;

function TcsCommandsManager.CommandExists(aID: Integer; out theCommand: TcsCommand): Boolean;
var
 i: Integer;
begin
 Result := False;
 theCommand:= nil;
 i:= 0;
 while not Result and (i <= f_Commands.Hi) do
 begin
  if TcsCommand(f_Commands.Items[i]).CommandID = aID then
  begin
   Result:= True;
   theCommand:= TcsCommand(f_Commands.Items[i]);
  end
  else
   Inc(i);
 end;
end;

procedure TcsCommandsManager.Leave;
begin
 f_CS.Leave;
end;

function TcsCommandsManager.pm_GetCommands(Index: Integer): TcsCommand;
begin
 Result := f_Commands[index] as TcsCommand;
end;

function TcsCommandsManager.pm_GetCount: Integer;
begin
 Result := f_Commands.Count;
end;

function TcsCommandsManager.pm_GetCustomCommands(
  Index: Integer): TcsCommand;
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

function TcsCommandsManager.pm_GetCustomCommandsCount: Integer;
var
 i: Integer;
begin
 Result := 0;
 for i:= 0 to Pred(Count) do
  if Commands[i].CommandID > c_CommandBaseIndex then
   Inc(Result);
end;

procedure TcsCommandsManager.UpdateServerMenu(theServerMenu: TMenuItem);
var
 i: Integer;
 l_MI: TMenuItem;
 l_Command: TcsCommand;
begin
 theServerMenu.Clear;
 for i:= 0 to CustomCommandsCount-1 do
 begin
  l_MI:= TmenuItem.Create(theServerMenu);
  l_Command := CustomCommands[i];
  l_MI.Name:= 'ServerMenu'+ IntToStr(l_Command.CommandID);
  l_MI.Tag:= l_Command.CommandID;
  l_MI.Caption:= l_Command.Caption;
  l_MI.OnClick:= ExecuteCommand;
  theServerMenu.Add(l_MI);
 end;
 theServerMenu.Visible:= theServerMenu.Count > 0;
end;

end.
