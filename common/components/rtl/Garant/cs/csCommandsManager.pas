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
 l3ProtoObject
 ;

type
 TcsCommandsManager = class(Tl3ProtoObject)
 private
  f_Commands: Tl3ProtoObjectRefList;
  f_CS: TCriticalSection;
  f_OnExecuteServerCommand: TNotifyEvent;
  function pm_GetCommands(Index: Integer): TcsCommand;
  function pm_GetCount: Integer;
 protected
  procedure Acquire;
  procedure Add(aCommand: TcsCommand);
  procedure Cleanup; override;
  procedure Leave;
 public
  constructor Create;
  procedure ClearCommands;
//  function CommandExists(aID: TcsCommands; out theCommand: TcsCommand): Boolean; overload;
  function CommandExists(aID: Integer; out theCommand: TcsCommand): Boolean; //overload;
  property Commands[Index: Integer]: TcsCommand read pm_GetCommands;
  property Count: Integer read pm_GetCount;
  property OnExecuteServerCommand: TNotifyEvent read f_OnExecuteServerCommand write f_OnExecuteServerCommand;
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
// FreeAndNil(aCommand);
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

(*function TcsCommandsManager.CommandExists(aID: TcsCommands; out theCommand: TcsCommand): Boolean;
begin
 Result := CommandExists(Ord(aID), theCommand);
end;*)

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

end.
