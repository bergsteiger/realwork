unit csCommandsTypes;
{$I csDefine.inc}

interface

uses
 //l3Base,
 Classes,
 CsDataPipe,
 ddAppConfigTypes,
 ddServerTask,
 csProcessTask,
 l3SimpleObject
 ;

type
// TcsCommandRequirement = (cs_crAll, cs_crSystem, cs_crUserList, cs_crGroupList);
 TcsCommandExecuteEvent = procedure (aTask: TddTaskItem) of object;
 
 TcsCommand = class(Tl3SimpleObject)
 private
  f_Caption: AnsiString;
  f_CommandID: Integer;
  f_NeedRespond: Boolean;
  f_OnExecute: TcsCommandExecuteEvent{TNotifyEvent};
    f_RequireAdminRights: Boolean;
  function pm_GetCaption: AnsiString;
  function pm_GetCommandID: Integer;
  function pm_GetNeedRespond: Boolean;
  procedure pm_SetNeedRespond(const Value: Boolean);
 public
  constructor Create(aCommandID: Integer; const aCaption: AnsiString); overload;
  constructor Create(aCommandID: Integer; const aCaption: AnsiString; anOnExecute: TcsCommandExecuteEvent{TNotifyEvent}); overload;
  constructor Create(aStream: TStream{; anOnExecute: TcsCommandExecuteEvent}); overload;
  procedure Execute(aTask: TddTaskItem);
  procedure Load(aStream: TStream);
  procedure Save(aStream: TStream);
  property Caption: AnsiString read pm_GetCaption {write pm_SetCaption};
  property CommandID: Integer read pm_GetCommandID {write pm_SetCommandID};
  property NeedRespond: Boolean read pm_GetNeedRespond write pm_SetNeedRespond;
  property RequireAdminRights: Boolean read f_RequireAdminRights write f_RequireAdminRights;
  property OnExecute: TcsCommandExecuteEvent read f_OnExecute;
 end;

 TcsCommands = (acmdNone,
                  // служба
                  acmdStart, acmdStop, acmdPause, acmdContinue, acmdRestart,
                  // задания
                  acmdStopAndGoAll, acmdDeleteTask,
                  acmdConfig, acmdSendMessage,
                  acmdAutoLogoff, acmdLogMessages,

                  acmdCheckTables, acmdUpdateTables,

                  acmdLockBase, acmdUnlockBase,
                  acmdCompileDictionaries, acmdUpdateText, acmdDoEverydayUpdate,
                  acmdBuildTextIndex,

                  acmdCheckFreeSpace,
                  acmdCheckTexts,
                  acmdClearLocks,
                  acmdEmailNotify,
                  acmdFamilyBackup,
                  acmdFullBackup,
                  acmdGardocBridge,
                  acmdIsDeltaReady,
                  acmdLoadDelta,
                  acmdLoadEQ,
                  acmdLoadKW,
                  acmdMakeDelta,
                  acmdMakeLoadDelta,
                  acmdPauseTask,
                  acmdPreventiveUpdate,
                  acmdRefresh,
                  acmdRestoreFamily,
                  acmdRunTask,
                  acmdSetHighestPriority,
                  acmdSetHighPriority,
                  acmdSetLowestPriority,
                  acmdSetLowPriority,
                  acmdSetNormalPriority,
                  acmdStack2Log,
                  acmdStopNGoAnnoExport,
                  acmdStopNGoExport,
                  acmdStopNGoImport,
                  acmdSwitchToRealBase,
                  acmdSwitchToTempBase,
                  acmdUndoRestore,
                  acmdUpdateDictEntryIndex,
                  acmdUpdateHeaderIndex,
                  acmdUpdateIndex,
                  acmdUserInfo,
                  acmdWeeklyUpdate
                   );


implementation

uses
 SysUtils,
 ddStreamUtils,
 l3FileUtils
 ;

constructor TcsCommand.Create(aCommandID: Integer; const aCaption: AnsiString);
begin
 inherited Create;
 f_CommandID := aCommandID;
 f_Caption:= aCaption;
 f_NeedRespond:= False;
end;

constructor TcsCommand.Create(aCommandID: Integer; const aCaption: AnsiString; anOnExecute: TcsCommandExecuteEvent{TNotifyEvent});
begin
 Create(aCommandID, aCaption);
 f_OnExecute := anOnExecute;
end;

constructor TcsCommand.Create(aStream: TStream);
begin
 Create(0, '');
 Load(aStream);
end;

procedure TcsCommand.Execute(aTask: TddTaskItem);
begin
 if Assigned(f_OnExecute) then
  f_OnExecute(aTask);
end;

procedure TcsCommand.Load(aStream: TStream);
begin
 aStream.Read(f_CommandID, SizeOf(f_CommandID));
 ReadString(aStream, f_Caption);
 aStream.Read(f_NeedRespond, SizeOf(f_NeedRespond));
end;

function TcsCommand.pm_GetCaption: AnsiString;
begin
 Result:= f_Caption;
end;

function TcsCommand.pm_GetCommandID: Integer;
begin
 Result:= f_CommandID;
end;

function TcsCommand.pm_GetNeedRespond: Boolean;
begin
 Result := f_NeedRespond;
end;

procedure TcsCommand.pm_SetNeedRespond(const Value: Boolean);
begin
 f_NeedRespond := Value;
end;

procedure TcsCommand.Save(aStream: TStream);
begin
 aStream.Write(f_CommandID, SizeOf(f_CommandID));
 WriteString(aStream, f_Caption);
 aStream.Write(f_NeedRespond, SizeOf(f_NeedRespond));
end;

end.
