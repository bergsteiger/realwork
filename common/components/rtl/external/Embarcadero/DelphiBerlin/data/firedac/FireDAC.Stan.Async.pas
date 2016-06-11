{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{        FireDAC async execution implementation         }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.Stan.Async;

interface

implementation

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows, Winapi.Messages,
{$ENDIF}
  System.SysUtils, System.Classes, System.SyncObjs,
  FireDAC.Stan.Intf, FireDAC.Stan.Consts, FireDAC.Stan.Error, FireDAC.Stan.Factory, 
    FireDAC.Stan.Util,
  FireDAC.UI.Intf;

type
  TFDAsyncThread = class;
  TFDStanAsyncExecutor = class;

  TFDAsyncThread = class(TThread)
  private
    FRunThreadId: TThreadID;
    FEvent: TEvent;
    FExecutor: TFDStanAsyncExecutor;
  protected
    procedure Execute; override;
  public
    constructor Create(AExecutor: TFDStanAsyncExecutor);
    destructor Destroy; override;
    procedure WaitForLaunch;
  end;

  TFDStanAsyncExecutor = class(TFDObject, IFDStanAsyncExecutor)
  private
    FOperationIntf: IFDStanAsyncOperation;
    FHandlerIntf: IFDStanAsyncHandler;
    FAsyncDlg: IFDGUIxAsyncExecuteDialog;
    FWait: IFDGUIxWaitCursor;
    FTimeout: Cardinal;
    FState: TFDStanAsyncState;
    FMode: TFDStanAsyncMode;
    FThread: TFDAsyncThread;
    FException: Exception;
    FSilentMode: Boolean;
    procedure ExecuteOperation(AStoreException: Boolean);
    procedure Cleanup;
  protected
    // IFDStanAsyncExecutor
    function GetState: TFDStanAsyncState;
    function GetMode: TFDStanAsyncMode;
    function GetTimeout: Cardinal;
    function GetOperation: IFDStanAsyncOperation;
    function GetHandler: IFDStanAsyncHandler;
    procedure Setup(const AOperation: IFDStanAsyncOperation;
      const AMode: TFDStanAsyncMode; const ATimeout: Cardinal;
      const AHandler: IFDStanAsyncHandler; ASilentMode: Boolean);
    procedure Run;
    procedure AbortJob;
    procedure Launched;
  public
    destructor Destroy; override;
  end;

var
  FDStanActiveAsyncsWithUI: Integer;

{-------------------------------------------------------------------------------}
{ TFDAsyncThread                                                                }
{-------------------------------------------------------------------------------}
constructor TFDAsyncThread.Create(AExecutor: TFDStanAsyncExecutor);
begin
  inherited Create(True);
  FRunThreadId := TThread.CurrentThread.ThreadID;
  FExecutor := AExecutor;
  FExecutor._AddRef;
  FreeOnTerminate := True;
  FEvent := TEvent.Create(nil, False, False, '');
end;

{-------------------------------------------------------------------------------}
destructor TFDAsyncThread.Destroy;
begin
  FDFreeAndNil(FEvent);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
{$WARNINGS OFF}
procedure TFDAsyncThread.WaitForLaunch;
begin
  Resume;
  if FEvent <> nil then
    FEvent.WaitFor(1000);
end;
{$WARNINGS ON}

{-------------------------------------------------------------------------------}
procedure TFDAsyncThread.Execute;
begin
  try
    FExecutor.ExecuteOperation(True);
  finally
    FExecutor.Launched;
    FExecutor.FThread := nil;
    FExecutor._Release;
    Sleep(1);
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDStanAsyncExecutor                                                          }
{-------------------------------------------------------------------------------}
destructor TFDStanAsyncExecutor.Destroy;
begin
  Cleanup;
  FAsyncDlg := nil;
  FWait := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDStanAsyncExecutor.GetMode: TFDStanAsyncMode;
begin
  Result := FMode;
end;

{-------------------------------------------------------------------------------}
function TFDStanAsyncExecutor.GetState: TFDStanAsyncState;
begin
  Result := FState;
end;

{-------------------------------------------------------------------------------}
function TFDStanAsyncExecutor.GetTimeout: Cardinal;
begin
  Result := FTimeout;
end;

{-------------------------------------------------------------------------------}
function TFDStanAsyncExecutor.GetOperation: IFDStanAsyncOperation;
begin
  Result := FOperationIntf;
end;

{-------------------------------------------------------------------------------}
function TFDStanAsyncExecutor.GetHandler: IFDStanAsyncHandler;
begin
  Result := FHandlerIntf;
end;

{-------------------------------------------------------------------------------}
procedure TFDStanAsyncExecutor.ExecuteOperation(AStoreException: Boolean);
var
  eMode: TFDStanAsyncMode;
begin
  eMode := FMode;
  try
    try
      try
        FState := asExecuting;
        FOperationIntf.Execute;
      except
        on E: Exception do begin
          if FState in [asInactive, asExecuting] then
            if (E is EFDDBEngineException) and (EFDDBEngineException(E).Kind = ekCmdAborted) then
              FState := asAborted
            else
              FState := asFailed;
          if AStoreException then
            FException := AcquireExceptionObject()
          else
            raise;
        end;
      end;
      if FState in [asInactive, asExecuting] then
        FState := asFinished;
    finally
      if eMode = amAsync then
        if (FHandlerIntf <> nil) and AStoreException then
          FHandlerIntf.HandleFinished(nil, FState, FException);
    end;
  finally
    if eMode = amAsync then begin
      Cleanup;
      _Release;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDStanAsyncExecutor.Setup(const AOperation: IFDStanAsyncOperation;
  const AMode: TFDStanAsyncMode; const ATimeout: Cardinal;
  const AHandler: IFDStanAsyncHandler; ASilentMode: Boolean);
begin
  try
    ASSERT(AOperation <> nil);
    FOperationIntf := AOperation;
    FHandlerIntf := AHandler;
    FTimeout := ATimeout;
    FMode := AMode;
    FState := asInactive;
    FSilentMode := ASilentMode;
    if FMode in [amNonBlocking, amCancelDialog] then
      if FDGUIxSilent() then
        FMode := amBlocking
      else if FDStanActiveAsyncsWithUI > 0 then
        FDException(Self, [S_FD_LStan], er_FD_StanCantNonblocking, [])
      else begin
        if FAsyncDlg = nil then
          FDCreateInterface(IFDGUIxAsyncExecuteDialog, FAsyncDlg);
        Inc(FDStanActiveAsyncsWithUI);
      end;
    if not FSilentMode and (FMode <> amAsync) then
      if FWait = nil then
        FDCreateInterface(IFDGUIxWaitCursor, FWait);
  except
    Cleanup;
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDStanAsyncExecutor.Cleanup;
begin
  FHandlerIntf := nil;
  if (FOperationIntf <> nil) and (FMode in [amNonBlocking, amCancelDialog]) then
    Dec(FDStanActiveAsyncsWithUI);
  FOperationIntf := nil;
  FDFreeAndNil(FException);
end;

{-------------------------------------------------------------------------------}
procedure TFDStanAsyncExecutor.Run;
var
  oEx: Exception;
{$IFDEF MSWINDOWS}
  H: THandle;
  dwRes, dwWakeMask: LongWord;
  rMsg: TMsg;
{$ENDIF}
{$IFDEF POSIX}
  iStartTime: Cardinal;
{$ENDIF}
begin
  ASSERT(FState = asInactive);
  // If command execution fails with error, and DBMS disconnects command (eg
  // PostgreSQL), then Unprepare releases last reference to TFDStanAsyncExecutor.
  // As result FHandlerIntf.HandleFinished raises AV. So, just around execution
  // into AddRef / _Release.
  _AddRef;
  if (FWait <> nil) and not FSilentMode and (FMode <> amAsync) then
    FWait.StartWait;
  try
    try
      if (FMode = amBlocking) and (FTimeout = $FFFFFFFF) then
        ExecuteOperation(False)
      else begin
                                                            
        FThread := TFDAsyncThread.Create(Self);
{$IFDEF MSWINDOWS}
        H := FThread.Handle;
{$ENDIF}
        FThread.WaitForLaunch;
        if FMode = amAsync then
          Exit;
        if FThread <> nil then
          try
            if FMode <> amBlocking then begin
              if FMode = amCancelDialog then
                FAsyncDlg.Show(Self);
{$IFDEF MSWINDOWS}
              dwWakeMask := QS_ALLINPUT;
            end
            else
              // Here was QS_POSTMESSAGE, but that may lead to AV. Because WM_PAINT
              // is handling too and GUI is not ready when a dataset is inactive.
              dwWakeMask := 0;
{$ENDIF}
{$IFDEF POSIX}
            end;
{$ENDIF}
            try
{$IFDEF MSWINDOWS}
              while FThread <> nil do begin
                dwRes := MsgWaitForMultipleObjects(1, H, False, FTimeout, dwWakeMask);
                case dwRes of
                WAIT_FAILED, // most probably - already terminated
                WAIT_OBJECT_0:
                  Break;
                WAIT_OBJECT_0 + 1:
                  while (FThread <> nil) and PeekMessage(rMsg, 0, 0, 0, PM_REMOVE) do
                    if rMsg.Message = WM_QUIT then begin
                      AbortJob;
                      Halt(Byte(rMsg.WParam));
                    end
                    else if (FMode = amNonBlocking) or not (
                        (rMsg.message >= WM_KEYDOWN) and (rMsg.message <= WM_DEADCHAR) and
                          ((FAsyncDlg = nil) or not FAsyncDlg.IsFormActive) or
                        (rMsg.message >= WM_MOUSEFIRST) and (rMsg.message <= WM_MOUSELAST) and
                          ((FAsyncDlg = nil) or not FAsyncDlg.IsFormMouseMessage(rMsg)) or
                        (rMsg.message >= WM_SYSKEYDOWN) and (rMsg.message <= WM_SYSDEADCHAR)
                       ) then begin
                      TranslateMessage(rMsg);
                      DispatchMessage(rMsg);
                    end;
                WAIT_TIMEOUT:
                  begin
                    AbortJob;
                    FState := asExpired;
                    Break;
                  end;
                end;
              end;
{$ENDIF}
{$IFDEF POSIX}
              iStartTime := TThread.GetTickCount;
              while (FThread <> nil) and not FThread.Finished and
                    not FDTimeout(iStartTime, FTimeout) do begin
                                                                      
                                        
                Sleep(1);
              end;
              if (FThread <> nil) and not FThread.Finished then begin
                AbortJob;
                FState := asExpired;
              end;
{$ENDIF}
            finally
              if FMode <> amBlocking then
                if FMode = amCancelDialog then
                  FAsyncDlg.Hide;
            end;
            if (FException <> nil) and not (
                (FException is EFDDBEngineException) and
                (EFDDBEngineException(FException).Kind = ekCmdAborted) and
                (FState in [asAborted, asExpired])
               ) then begin
              FState := asFailed;
              oEx := FException;
              FException := nil;
              raise oEx;
            end
            else if FState = asExpired then
              FDException(Self, [S_FD_LStan], er_FD_StanTimeout, [])
            else if FState = asAborted then
              Abort;
          except
            if FState in [asInactive, asExecuting] then
              FState := asFailed;
            raise;
          end;
        if FState in [asInactive, asExecuting] then
          FState := asFinished;
      end;
    finally
      if FMode <> amAsync then begin
        if (FWait <> nil) and not FSilentMode then
          FWait.StopWait;
        if FHandlerIntf <> nil then
          FHandlerIntf.HandleFinished(nil, FState, FException);
      end;
    end;
  finally
    if FMode <> amAsync then begin
      Cleanup;
      _Release;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDStanAsyncExecutor.AbortJob;
begin
  FState := asAborted;
  if FThread <> nil then
    FThread.Terminate;
  if FOperationIntf <> nil then
    FOperationIntf.AbortJob;
end;

{-------------------------------------------------------------------------------}
procedure TFDStanAsyncExecutor.Launched;
begin
  if FThread <> nil then
    FThread.FEvent.SetEvent;
end;

{-------------------------------------------------------------------------------}
var
  oFact: TFDFactory;

initialization
  FDStanActiveAsyncsWithUI := 0;
  oFact := TFDMultyInstanceFactory.Create(TFDStanAsyncExecutor, IFDStanAsyncExecutor);

finalization
  FDReleaseFactory(oFact);

end.
