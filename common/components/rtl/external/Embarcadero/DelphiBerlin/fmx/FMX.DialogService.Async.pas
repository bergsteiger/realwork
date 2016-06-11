{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.DialogService.Async;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.UITypes, FMX.Platform, FMX.Dialogs;

type
/// <summary>Helper class for Asynchronous message dialogs and input queries.</summary>
TDialogServiceAsync = class
  private
    class var FDialogService: IFMXDialogServiceAsync;
    class function DialogService: IFMXDialogServiceAsync;
  public
    /// <summary>Show a simple message box with an 'Ok' button to close it.</summary>
    class procedure ShowMessage(const AMessage: string); overload;
    class procedure ShowMessage(const AMessage: string; const ACloseDialogProc: TInputCloseDialogProc); overload;
    class procedure ShowMessage(const AMessage: string; const ACloseDialogEvent: TInputCloseDialogEvent;
      const AContext: TObject = nil); overload;

    /// <summary>Shows custom message dialog with specified buttons on it.</summary>
    class procedure MessageDialog(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
      const ADefaultButton: TMsgDlgBtn; const AHelpCtx: LongInt); overload;
    class procedure MessageDialog(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
      const ADefaultButton: TMsgDlgBtn; const AHelpCtx: LongInt; const ACloseDialogProc: TInputCloseDialogProc); overload;
    class procedure MessageDialog(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
      const ADefaultButton: TMsgDlgBtn; const AHelpCtx: LongInt; const ACloseDialogEvent: TInputCloseDialogEvent;
      const AContext: TObject = nil); overload;

    /// <summary>Shows an input message dialog with the specified promps and values on it. Values are modified within it.</summary>
    class procedure InputQuery(const ACaption: string; const APrompts: array of string; const AValues: array of string;
      const ACloseQueryProc: TInputCloseQueryProc); overload;
    /// <summary>Shows an input message dialog with the specified promps and values on it. Values are modified within it.</summary>
    class procedure InputQuery(const ACaption: string; const APrompts: array of string; const AValues: array of string;
      const ACloseQueryEvent: TInputCloseQueryWithResultEvent; const AContext: TObject = nil); overload;
end;

implementation

{ TDialogServiceAsync }

class function TDialogServiceAsync.DialogService: IFMXDialogServiceAsync;
begin
  if FDialogService = nil then
  begin
    TPlatformServices.Current.SupportsPlatformService(IFMXDialogServiceAsync, FDialogService);
    if FDialogService = nil then
      raise EUnsupportedPlatformService.Create(ClassName);
  end;
  Result := FDialogService;
end;

class procedure TDialogServiceAsync.ShowMessage(const AMessage: string);
begin
  if DialogService <> nil then
    DialogService.ShowMessageAsync(AMessage);
end;

class procedure TDialogServiceAsync.ShowMessage(const AMessage: string; const ACloseDialogProc: TInputCloseDialogProc);
begin
  if DialogService <> nil then
    DialogService.ShowMessageAsync(AMessage, ACloseDialogProc);
end;

class procedure TDialogServiceAsync.ShowMessage(const AMessage: string; const ACloseDialogEvent: TInputCloseDialogEvent;
  const AContext: TObject = nil);
begin
  if DialogService <> nil then
    DialogService.ShowMessageAsync(AMessage, ACloseDialogEvent, AContext);
end;

class procedure TDialogServiceAsync.MessageDialog(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const ADefaultButton: TMsgDlgBtn; const AHelpCtx: LongInt);
begin
  if DialogService <> nil then
    DialogService.MessageDialogAsync(AMessage, ADialogType, AButtons, ADefaultButton, AHelpCtx, nil);
end;

class procedure TDialogServiceAsync.MessageDialog(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const ADefaultButton: TMsgDlgBtn; const AHelpCtx: LongInt; const ACloseDialogProc: TInputCloseDialogProc);
begin
  if DialogService <> nil then
    DialogService.MessageDialogAsync(AMessage, ADialogType, AButtons, ADefaultButton, AHelpCtx, ACloseDialogProc);
end;

class procedure TDialogServiceAsync.MessageDialog(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const ADefaultButton: TMsgDlgBtn; const AHelpCtx: LongInt; const ACloseDialogEvent: TInputCloseDialogEvent;
  const AContext: TObject = nil);
begin
  if DialogService <> nil then
    DialogService.MessageDialogAsync(AMessage, ADialogType, AButtons, ADefaultButton, AHelpCtx, ACloseDialogEvent, AContext);
end;

class procedure TDialogServiceAsync.InputQuery(const ACaption: string; const APrompts: array of string; const AValues: array of string;
  const ACloseQueryProc: TInputCloseQueryProc);
begin
  if DialogService <> nil then
    DialogService.InputQueryAsync(ACaption, APrompts, AValues, ACloseQueryProc);
end;

class procedure TDialogServiceAsync.InputQuery(const ACaption: string; const APrompts: array of string; const AValues: array of string;
  const ACloseQueryEvent: TInputCloseQueryWithResultEvent; const AContext: TObject = nil);
begin
  if DialogService <> nil then
    DialogService.InputQueryAsync(ACaption, APrompts, AValues, ACloseQueryEvent, AContext);
end;

end.
