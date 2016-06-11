{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit FMX.DialogService;

interface

{$SCOPEDENUMS ON}

uses
  System.UITypes, FMX.Dialogs;

type
  /// <summary>Service for managing platform differences in behaviours when showing dialogs. It has a PreferredMode that
  /// can have three values:
  /// Platform  Sync methods for Desktop OS's (Windows and OSX) and ASync for Mobile (Android adn IOS)
  /// Sync      Sync methods are preferred. Used when available (All but Android)
  /// Async     Async methods are preferred. Used when available (All platforms)
  /// </summary>
  TDialogService = class
  public type
    TPreferredMode = (Platform, Async, Sync);

  strict private
    class var FPreferredMode: TPreferredMode;
    class var FInSyncMode: Boolean;
    class procedure SetPreferredMode(const PreferredMode: TPreferredMode); static;

  public
    class constructor ClassCreate;

    /// <summary>Show a simple message box with an 'Ok' button to close it.</summary>
    class procedure ShowMessage(const AMessage: string); overload;
    class procedure ShowMessage(const AMessage: string; const ACloseDialogProc: TInputCloseDialogProc); overload;
    class procedure ShowMessage(const AMessage: string; const ACloseDialogEvent: TInputCloseDialogEvent;
      const AContext: TObject = nil); overload;

    /// <summary>Shows custom message dialog with specified buttons on it.</summary>
    class procedure MessageDialog(const AMessage: string; const ADialogType: TMsgDlgType;
      const AButtons: TMsgDlgButtons; const ADefaultButton: TMsgDlgBtn; const AHelpCtx: LongInt;
      const ACloseDialogProc: TInputCloseDialogProc); overload;
    class procedure MessageDialog(const AMessage: string; const ADialogType: TMsgDlgType;
      const AButtons: TMsgDlgButtons; const ADefaultButton: TMsgDlgBtn; const AHelpCtx: LongInt;
      const ACloseDialogEvent: TInputCloseDialogEvent; const AContext: TObject = nil); overload;

    /// <summary>Shows an input message dialog with the specified prompts and values in it.
    /// Values are returned in the callback.</summary>
    class procedure InputQuery(const ACaption: string; const APrompts: array of string; const AValues: array of string;
      const ACloseQueryProc: TInputCloseQueryProc); overload;
    /// <summary>Shows an input message dialog with the specified prompts and values in it.
    /// Values are returned in the callback.</summary>
    class procedure InputQuery(const ACaption: string; const APrompts: array of string; const AValues: array of string;
      const ACloseQueryEvent: TInputCloseQueryWithResultEvent; const AContext: TObject = nil); overload;

    /// <summary>Sets the default presentation mode for dialogs.</summary>
    class property PreferredMode: TPreferredMode read FPreferredMode write SetPreferredMode;
  end;

implementation

uses
  System.Generics.Collections, FMX.Platform;

{REGION 'TDialogServiceImpl'}
type
  TDialogServiceImpl = class
  public
    class function DialogServiceAsync: IFMXDialogServiceAsync; inline;
    class function DialogServiceSync: IFMXDialogServiceSync; inline;
  end;


class function TDialogServiceImpl.DialogServiceAsync: IFMXDialogServiceAsync;
begin
  TPlatformServices.Current.SupportsPlatformService(IFMXDialogServiceAsync, Result);
end;

class function TDialogServiceImpl.DialogServiceSync: IFMXDialogServiceSync;
begin
  TPlatformServices.Current.SupportsPlatformService(IFMXDialogServiceSync, Result);
end;

{ENDREGION 'TDialogServiceImpl'}

{REGION 'TDialogService'}

class constructor TDialogService.ClassCreate;
begin
  SetPreferredMode(TPreferredMode.Platform);
end;

class procedure TDialogService.SetPreferredMode(const PreferredMode: TPreferredMode);
begin
  FPreferredMode := PreferredMode;
  case FPreferredMode of
    TPreferredMode.Platform:
      {$IF DEFINED(ANDROID) or DEFINED(IOS)}
      FInSyncMode := False;
      {$ELSE}
      FInSyncMode := True;
      {$ENDIF}
    TPreferredMode.Async:
      FInSyncMode := False;
    TPreferredMode.Sync:
      {$IF DEFINED(ANDROID)}
      FInSyncMode := False;
      {$ELSE}
      FInSyncMode := True;
      {$ENDIF}
  end;
end;

class procedure TDialogService.ShowMessage(const AMessage: string);
begin
  if FInSyncMode and  (TDialogServiceImpl.DialogServiceSync <> nil) then
    TDialogServiceImpl.DialogServiceSync.ShowMessageSync(AMessage)
  else if TDialogServiceImpl.DialogServiceAsync <> nil then
    TDialogServiceImpl.DialogServiceAsync.ShowMessageAsync(AMessage);
end;

class procedure TDialogService.ShowMessage(const AMessage: string; const ACloseDialogProc: TInputCloseDialogProc);
begin
  if FInSyncMode and  (TDialogServiceImpl.DialogServiceSync <> nil) then
  begin
    TDialogServiceImpl.DialogServiceSync.ShowMessageSync(AMessage);
    if Assigned(ACloseDialogProc) then
      ACloseDialogProc(mrOk);
  end
  else if TDialogServiceImpl.DialogServiceAsync <> nil then
    TDialogServiceImpl.DialogServiceAsync.ShowMessageAsync(AMessage, ACloseDialogProc);
end;

class procedure TDialogService.ShowMessage(const AMessage: string; const ACloseDialogEvent: TInputCloseDialogEvent;
  const AContext: TObject = nil);
begin
  if FInSyncMode and  (TDialogServiceImpl.DialogServiceSync <> nil) then
  begin
    TDialogServiceImpl.DialogServiceSync.ShowMessageSync(AMessage);
    if Assigned(ACloseDialogEvent) then
      ACloseDialogEvent(AContext, mrOk);
  end
  else if TDialogServiceImpl.DialogServiceAsync <> nil then
    TDialogServiceImpl.DialogServiceAsync.ShowMessageAsync(AMessage, ACloseDialogEvent, AContext);
end;

class procedure TDialogService.MessageDialog(const AMessage: string; const ADialogType: TMsgDlgType;
  const AButtons: TMsgDlgButtons; const ADefaultButton: TMsgDlgBtn; const AHelpCtx: LongInt;
  const ACloseDialogProc: TInputCloseDialogProc);
var
  LModalResult: TModalResult;
begin
  if FInSyncMode and  (TDialogServiceImpl.DialogServiceSync <> nil) then
  begin
    LModalResult := TDialogServiceImpl.DialogServiceSync.MessageDialogSync(AMessage, ADialogType, AButtons,
      ADefaultButton, AHelpCtx);
    if Assigned(ACloseDialogProc) then
      ACloseDialogProc(LModalResult);
  end
  else if TDialogServiceImpl.DialogServiceAsync <> nil then
    TDialogServiceImpl.DialogServiceAsync.MessageDialogAsync(AMessage, ADialogType, AButtons, ADefaultButton, AHelpCtx,
      ACloseDialogProc);
end;

class procedure TDialogService.MessageDialog(const AMessage: string; const ADialogType: TMsgDlgType;
  const AButtons: TMsgDlgButtons; const ADefaultButton: TMsgDlgBtn; const AHelpCtx: LongInt;
  const ACloseDialogEvent: TInputCloseDialogEvent; const AContext: TObject = nil);
var
  LModalResult: TModalResult;
begin
  if FInSyncMode and  (TDialogServiceImpl.DialogServiceSync <> nil) then
  begin
    LModalResult := TDialogServiceImpl.DialogServiceSync.MessageDialogSync(AMessage, ADialogType, AButtons,
      ADefaultButton, AHelpCtx);
    if Assigned(ACloseDialogEvent) then
      ACloseDialogEvent(AContext, LModalResult);
  end
  else if TDialogServiceImpl.DialogServiceAsync <> nil then
    TDialogServiceImpl.DialogServiceAsync.MessageDialogAsync(AMessage, ADialogType, AButtons, ADefaultButton, AHelpCtx,
      ACloseDialogEvent, AContext);
end;

class procedure TDialogService.InputQuery(const ACaption: string; const APrompts: array of string;
  const AValues: array of string; const ACloseQueryProc: TInputCloseQueryProc);
var
  LResult: Boolean;
  LValues: array of string;
begin
  if FInSyncMode and  (TDialogServiceImpl.DialogServiceSync <> nil) then
  begin
    SetLength(LValues, Length(AValues));
    TArray.Copy<String>(AValues, LValues, Length(AValues));
    LResult := TDialogServiceImpl.DialogServiceSync.InputQuerySync(ACaption, APrompts, LValues);
    if Assigned(ACloseQueryProc) then
      if LResult then
        ACloseQueryProc(mrOk, LValues)
      else
        ACloseQueryProc(mrCancel, AValues);
  end
  else if TDialogServiceImpl.DialogServiceAsync <> nil then
      TDialogServiceImpl.DialogServiceAsync.InputQueryAsync(ACaption, APrompts, AValues, ACloseQueryProc);
end;

class procedure TDialogService.InputQuery(const ACaption: string; const APrompts: array of string;
  const AValues: array of string; const ACloseQueryEvent: TInputCloseQueryWithResultEvent;
  const AContext: TObject);
var
  LResult: Boolean;
  LValues: array of string;
begin
  if FInSyncMode and  (TDialogServiceImpl.DialogServiceSync <> nil) then
  begin
    SetLength(LValues, Length(AValues));
    TArray.Copy<String>(AValues, LValues, Length(AValues));
    LResult := TDialogServiceImpl.DialogServiceSync.InputQuerySync(ACaption, APrompts, LValues);
    if Assigned(ACloseQueryEvent) then
      if LResult then
        ACloseQueryEvent(AContext, mrOk, LValues)
      else
        ACloseQueryEvent(AContext, mrCancel, AValues);
  end
  else if TDialogServiceImpl.DialogServiceAsync <> nil then
      TDialogServiceImpl.DialogServiceAsync.InputQueryAsync(ACaption, APrompts, AValues, ACloseQueryEvent, AContext);
end;

end.
