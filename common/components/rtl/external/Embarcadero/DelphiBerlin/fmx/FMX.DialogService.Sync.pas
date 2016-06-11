{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.DialogService.Sync;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.UITypes, FMX.Platform, FMX.Dialogs;

//NOTE: Android does not support Synchronous Dialogs.
type
/// <summary>Helper class for Synchronous message dialogs and input queries.</summary>
/// <remarks>Android does not support this.</remarks>
TDialogServiceSync = class
  private
    class var FDialogService: IFMXDialogServiceSync;
    class function DialogService: IFMXDialogServiceSync;
  public
    /// <summary>Show a simple message box with an 'Ok' button to close it.</summary>
    class procedure ShowMessage(const AMessage: string);

    /// <summary>Shows custom message dialog with specified buttons on it.</summary>
    class function MessageDialog(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
      const ADefaultButton: TMsgDlgBtn; const AHelpCtx: LongInt): Integer;

    /// <summary>Shows an input message dialog with the specified promps and values on it. Values are modified within it.</summary>
    class function InputQuery(const ACaption: string; const APrompts: array of string; var AValues: array of string): Boolean;
end;

implementation

{ TDialogServiceSync }
//NOTE: Android does not support Synchronous Dialogs.

class function TDialogServiceSync.DialogService: IFMXDialogServiceSync;
begin
  if FDialogService = nil then
  begin
    TPlatformServices.Current.SupportsPlatformService(IFMXDialogServiceSync, FDialogService);
    if FDialogService = nil then
      raise EUnsupportedPlatformService.Create(ClassName);
  end;
  Result := FDialogService;
end;

class procedure TDialogServiceSync.ShowMessage(const AMessage: string);
begin
  DialogService.ShowMessageSync(AMessage);
end;

class function TDialogServiceSync.MessageDialog(const AMessage: string; const ADialogType: TMsgDlgType;
  const AButtons: TMsgDlgButtons; const ADefaultButton: TMsgDlgBtn; const AHelpCtx: LongInt): Integer;
begin
  Result := DialogService.MessageDialogSync(AMessage, ADialogType, AButtons, ADefaultButton, AHelpCtx);
end;

class function TDialogServiceSync.InputQuery(const ACaption: string; const APrompts: array of string;
  var AValues: array of string): Boolean;
begin
  Result := DialogService.InputQuerySync(ACaption, APrompts, AValues);
end;

end.
