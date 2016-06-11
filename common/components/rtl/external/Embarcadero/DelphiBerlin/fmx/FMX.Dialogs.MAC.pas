{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Dialogs.Mac;

interface

{$SCOPEDENUMS ON}

implementation

uses
  System.TypInfo, System.Classes, System.Generics.Collections, System.UITypes, System.SysUtils, System.IOUtils,
  System.Math, Macapi.Foundation, Macapi.CocoaTypes, Macapi.ObjectiveC, Macapi.Helpers, FMX.Helpers.Mac,
  Macapi.ObjCRuntime, Macapi.AppKit, Macapi.Dispatch,
  FMX.Platform, FMX.Platform.Mac, FMX.Dialogs, FMX.Types, FMX.Controls, FMX.Forms, FMX.Consts, FMX.DialogHelper;

type

  {TFMXDialogService}

  TFMXDialogService = class(TInterfacedObject, IFMXDialogServiceSync, IFMXDialogServiceAsync)
  public const
    MsgCaptions: array [TMsgDlgType] of string = (SMsgDlgWarning, SMsgDlgError, SMsgDlgInformation, SMsgDlgConfirm, '');
  strict private
    class var FCurrent: TFMXDialogService;
    NSApp: NSApplication;
    FAlertCount: Integer;
    class function GetCurrent: TFMXDialogService; static;
    function HookObserverCallback(CancelIdle: Boolean; Mask: NSUInteger = NSAnyEventMask): Boolean;
    class function ClosePopupForms: Boolean;
    class function PrepareClosePopups(const SaveForm: TCommonCustomForm): Boolean;
  private
    { IFMXDialogServiceSync }
    /// <summary>Show a simple message box with an 'Ok' button to close it.</summary>
    procedure ShowMessageSync(const AMessage: string);
    /// <summary>Shows custom message dialog with specified buttons on it.</summary>
    function MessageDialogSync(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
      const ADefaultButton: TMsgDlgBtn; const AHelpCtx: LongInt): Integer;
    /// <summary>Shows an input message dialog with the specified prompts and values on it. Values are modified within it.</summary>
    function InputQuerySync(const ACaption: string; const APrompts: array of string; var AValues: array of string): Boolean;

    { IFMXDialogServiceAsync }
    /// <summary>Show a simple message box with an 'Ok' button to close it.</summary>
    procedure ShowMessageAsync(const AMessage: string); overload;
    /// <summary>Show a simple message box with an 'Ok' button to close it.</summary>
    procedure ShowMessageAsync(const AMessage: string; const ACloseDialogProc: TInputCloseDialogProc); overload;
    /// <summary>Show a simple message box with an 'Ok' button to close it.</summary>
    procedure ShowMessageAsync(const AMessage: string; const ACloseDialogEvent: TInputCloseDialogEvent;
      const AContext: TObject = nil); overload;

    /// <summary>Shows custom message dialog with specified buttons on it.</summary>
    procedure MessageDialogAsync(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
      const ADefaultButton: TMsgDlgBtn; const AHelpCtx: LongInt; const ACloseDialogProc: TInputCloseDialogProc); overload;
    /// <summary>Shows custom message dialog with specified buttons on it.</summary>
    procedure MessageDialogAsync(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
      const ADefaultButton: TMsgDlgBtn; const AHelpCtx: LongInt; const ACloseDialogEvent: TInputCloseDialogEvent;
      const AContext: TObject = nil); overload;

    /// <summary>Shows an input message dialog with the specified prompts and values on it. Values are modified within it.</summary>
    procedure InputQueryAsync(const ACaption: string; const APrompts: array of string; const ADefaultValues: array of string;
      const ACloseQueryProc: TInputCloseQueryProc); overload;
    /// <summary>Shows an input message dialog with the specified prompts and values on it. Values are modified within it.</summary>
    procedure InputQueryAsync(const ACaption: string; const APrompts: array of string; const ADefaultValues: array of string;
      const ACloseQueryEvent: TInputCloseQueryWithResultEvent; const AContext: TObject = nil); overload;
  public
    constructor Create;
    class property Current: TFMXDialogService read GetCurrent;
  end;

{$REGION 'TFMXDialogService }

constructor TFMXDialogService.Create;
begin
  NSApp := TNSApplication.Wrap(TNSApplication.OCClass.sharedApplication);
end;

class function TFMXDialogService.ClosePopupForms: Boolean;
begin
  Result := False;
  if Screen <> nil then
    try
      Result := Screen.ClosePopupForms;
    except
      HandleException(Screen);
    end;
end;

class function TFMXDialogService.PrepareClosePopups(const SaveForm: TCommonCustomForm): Boolean;
begin
  Result := False;
  if Screen <> nil then
    try
      Result := Screen.PrepareClosePopups(SaveForm);
    except
      HandleException(Screen);
    end;
end;

function TFMXDialogService.HookObserverCallback(CancelIdle: Boolean; Mask: NSUInteger = NSAnyEventMask): Boolean;
begin
  Result := PlatformHookObserverCallback(CancelIdle, Mask);
end;

{ IFMXDialogService }

class function TFMXDialogService.GetCurrent: TFMXDialogService;
begin
  if FCurrent = nil then
    FCurrent := TFMXDialogService.Create;
  Result := FCurrent;
end;

{ IFMXDialogServiceSync }

procedure TFMXDialogService.ShowMessageSync(const AMessage: string);
begin
  MessageDialogSync(AMessage, TMsgDlgType.mtCustom, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, 0);
end;

function TFMXDialogService.MessageDialogSync(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const ADefaultButton: TMsgDlgBtn; const AHelpCtx: LongInt): Integer;
var
  Alert: NSAlert;
  Delegate: TFMXAlertDelegate;
  Session: NSModalSession;
  NSWin: NSWindow;
  S: SEL;
  ActiveForm: TCommonCustomForm;
  R: Integer;
  AutoReleasePool: NSAutoreleasePool;

  procedure AddButtons(IsDefault: Boolean);
  var
    B: TMsgDlgBtn;
    procedure AddBtn(B: TMsgDlgBtn);
    begin
      SetLength(Delegate.Results, Length(Delegate.Results) + 1);
      Delegate.Results[High(Delegate.Results)] := ModalResults[B];
      Alert.addButtonWithTitle(StrToNSStr(ButtonCaptions[B]));
    end;
  begin
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if (B in AButtons) and (IsDefault xor (B <> ADefaultButton)) then
        AddBtn(B);
    if (not IsDefault) and (Length(Delegate.Results) = 0) then
      AddBtn(ADefaultButton);
  end;
begin
  MessageDialogCheckInUIThread;
  ActiveForm := nil;
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    Delegate := TFMXAlertDelegate.Create;
    try
      Delegate.Modal := True;

      if Screen <> nil then
      begin
        PrepareClosePopups(nil);
        ClosePopupForms;
        ActiveForm := Screen.ActiveForm;
        if (ActiveForm <> nil) and (ActiveForm.Visible) and (ActiveForm.Handle <> nil) and
          not (ActiveForm.Owner is TPopup) then
        begin
          NSWin := WindowHandleToPlatform(ActiveForm.Handle).Wnd;
          if NSWin <> nil then
            NSWin.retain;
        end;
      end;

      S := sel_getUid('alertDidEndSelector:returnCode:contextInfo:');
      Alert := TNSAlert.Create;
      Alert.setInformativeText(StrToNSStr(AMessage));
      Alert.setMessageText(StrToNSStr(MsgTitles[ADialogType]));
      if ADialogType = TMsgDlgType.mtWarning then
        Alert.setAlertStyle(NSWarningAlertStyle)
      else if ADialogType = TMsgDlgType.mtError then
        Alert.setAlertStyle(NSCriticalAlertStyle)
      else
        Alert.setAlertStyle(NSInformationalAlertStyle);

      AddButtons(True);
      AddButtons(False);

      if NSWin <> nil then
      begin
        Alert.beginSheetModalForWindow(NSWin, Delegate.GetObjectID, S, nil);
        if TFmxFormState.Modal in ActiveForm.FormState then
          Session := nil
        else
          Session := NSApp.beginModalSessionForWindow(NSWin);
        Inc(FAlertCount);
        try
          while Delegate.Modal do
          begin
            if Session <> nil then
              NSApp.runModalSession(Session);
            HookObserverCallback(False);
          end;
        finally
          Dec(FAlertCount);
          if Session <> nil then
            NSApp.endModalSession(Session);
        end;
        Result := Delegate.Result;
      end
      else
      begin
        R := Alert.runModal - NSAlertFirstButtonReturn;
        if (R >= 0) and (R < Length(Delegate.Results)) then
          Result := Delegate.Results[R]
        else
          Result := mrCancel;
      end;
    finally
      Delegate.Free;
      if NSWin <> nil then
        NSWin.release;
      if (ActiveForm <> nil) and (FAlertCount = 0) then
        ActiveForm.Activate;
    end;
  finally
    AutoReleasePool.release;
  end;
end;

function TFMXDialogService.InputQuerySync(const ACaption: string; const APrompts: array of string; var AValues: array of string): Boolean;
const
  InputWidth = 400;
  InputHeight = 24;
  VerticalSpacing = 60;
  PromptRelativePosition = 36;

  function CreatePrompt(const YPos: Single; const Prompt: string; out Password: Boolean): NSTextField;
  begin
    Result := TNSTextField.Wrap(TNSTextField.Alloc.initWithFrame(MakeNSRect(0, YPos, InputWidth, InputHeight)));
    Result.setDrawsBackground(False);
    Result.setEditable(False);
    Result.setSelectable(False);
    Result.setBordered(False);
    Result.setBackgroundColor(TNSColor.Wrap(TNSColor.OCClass.clearColor));
    Password := (Prompt.Length > 0) and (Prompt.Chars[0] < #32);
    Result.setStringValue(StrToNSStr(Prompt.Substring(IfThen(Password, 1, 0))));
  end;

  function CreateInput(const YPos: Single; const InitialValue: string; const Password: Boolean): NSTextField;
  begin
    if Password then
      Result := TNSSecureTextField.Wrap(TNSSecureTextField.Alloc.initWithFrame(MakeNSRect(0, YPos, InputWidth,
        InputHeight)))
    else
      Result := TNSTextField.Wrap(TNSTextField.Alloc.initWithFrame(MakeNSRect(0, YPos, InputWidth, InputHeight)));
    Result.setStringValue(StrToNSStr(InitialValue));
  end;

var
  Alert: NSAlert;
  Delegate: TFMXAlertDelegate;
  Session: NSModalSession;
  NSWin: NSWindow;
  S: SEL;
  View: NSView;
  Inputs: array of NSTextField;
  I: Integer;
  ActiveForm: TCommonCustomForm;
  AutoReleasePool: NSAutoreleasePool;
  Password: Boolean;
begin
  MessageDialogCheckInUIThread;
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    Result := False;
    if (Length(AValues) > 0) and (Length(APrompts) > 0) then
    begin
      ActiveForm := nil;
      Delegate := TFMXAlertDelegate.Create;
      try
        Delegate.Modal := True;
        SetLength(Delegate.Results, 2);
        Delegate.Results[0] := ModalResults[TMsgDlgBtn.mbOK];
        Delegate.Results[1] := ModalResults[TMsgDlgBtn.mbCancel];

        if Screen <> nil then
        begin
          ActiveForm := Screen.ActiveForm;
          if (ActiveForm <> nil) and (ActiveForm.Visible) and (ActiveForm.Handle <> nil) and
            not (ActiveForm.Owner is TPopup) then
          begin
            NSWin := WindowHandleToPlatform(ActiveForm.Handle).Wnd;
            if NSWin <> nil then
              NSWin.retain;
          end;
        end;

        S := sel_getUid('alertDidEndSelector:returnCode:contextInfo:');
        Alert := TNSAlert.Wrap(TNSAlert.Alloc.init);
        Alert.setMessageText(StrToNSStr(ACaption));

        Alert.addButtonWithTitle(StrToNSStr(ButtonCaptions[TMsgDlgBtn.mbOK]));
        Alert.addButtonWithTitle(StrToNSStr(ButtonCaptions[TMsgDlgBtn.mbCancel]));

        View := TNSView.Wrap(TNSView.Alloc.initWithFrame(MakeNSRect(0, 0, InputWidth, Length(AValues) * VerticalSpacing)));

        SetLength(Inputs, Length(AValues));
        for I := 0 to High(Inputs) do
        begin
          View.addSubview(CreatePrompt(View.frame.size.height - I * VerticalSpacing - PromptRelativePosition,
            APrompts[I], Password));
          Inputs[I] := CreateInput(View.frame.size.height - I * VerticalSpacing - VerticalSpacing, AValues[I], Password);
          View.addSubview(Inputs[I]);
        end;

        Alert.setAccessoryView(View);

        if NSWin <> nil then
        begin
          Alert.beginSheetModalForWindow(NSWin, Delegate.GetObjectID, S, nil);
          if TFmxFormState.Modal in ActiveForm.FormState then
            Session := nil
          else
            Session := NSApp.beginModalSessionForWindow(NSWin);
          Inc(FAlertCount);
          try
            while Delegate.Modal do
            begin
              if Session <> nil then
                NSApp.runModalSession(Session);
              HookObserverCallback(False);
            end;
          finally
            Dec(FAlertCount);
            if Session <> nil then
              NSApp.endModalSession(Session);
          end;
          Result := Delegate.Result = mrOk;
        end
        else
          Result := Alert.runModal = NSAlertFirstButtonReturn;
        if Result then
          for I := 0 to High(Inputs) do
            AValues[I] := NSStrToStr(Inputs[I].stringValue);
      finally
        if NSWin <> nil then
          NSWin.release;
        if (ActiveForm <> nil) and (FAlertCount = 0) then
          ActiveForm.Activate;
      end;
    end;
  finally
    AutoReleasePool.release;
  end;
end;

{ IFMXDialogServiceAsync }

procedure TFMXDialogService.ShowMessageAsync(const AMessage: string);
var
  LProc: TInputCloseDialogProc;
begin
  LProc := nil;
  ShowMessageAsync(AMessage, LProc);
end;

procedure TFMXDialogService.ShowMessageAsync(const AMessage: string; const ACloseDialogProc: TInputCloseDialogProc);
begin
  MessageDialogCheckInUIThread;
  TDialogHelper.ShowMessage(AMessage, ACloseDialogProc, False);
end;

procedure TFMXDialogService.ShowMessageAsync(const AMessage: string; const ACloseDialogEvent: TInputCloseDialogEvent;
  const AContext: TObject);
begin
  ShowMessageAsync(AMessage,
    procedure(const AResult: TModalResult)
    begin
      if Assigned(ACloseDialogEvent) then
        ACloseDialogEvent(AContext, AResult);
    end);
end;

procedure TFMXDialogService.MessageDialogAsync(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const ADefaultButton: TMsgDlgBtn; const AHelpCtx: LongInt; const ACloseDialogProc: TInputCloseDialogProc);
begin
  MessageDialogCheckInUIThread;
  TDialogHelper.MessageDialog(AMessage, ADialogType, AButtons, ADefaultButton, AHelpCtx, ACloseDialogProc, False);
end;

procedure TFMXDialogService.MessageDialogAsync(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const ADefaultButton: TMsgDlgBtn; const AHelpCtx: LongInt; const ACloseDialogEvent: TInputCloseDialogEvent;
  const AContext: TObject);
begin
  MessageDialogAsync(AMessage, ADialogType, AButtons, ADefaultButton, AHelpCtx,
    procedure(const AResult: TModalResult)
    begin
      if Assigned(ACloseDialogEvent) then
        ACloseDialogEvent(AContext, AResult);
    end);
end;

procedure TFMXDialogService.InputQueryAsync(const ACaption: string; const APrompts: array of string;
  const ADefaultValues: array of string; const ACloseQueryProc: TInputCloseQueryProc);
begin
  MessageDialogCheckInUIThread;
  TDialogHelper.InputQuery(ACaption, APrompts, ADefaultValues, ACloseQueryProc, False);
end;

procedure TFMXDialogService.InputQueryAsync(const ACaption: string; const APrompts: array of string;
  const ADefaultValues: array of string; const ACloseQueryEvent: TInputCloseQueryWithResultEvent; const AContext: TObject);
begin
  InputQueryAsync(ACaption, APrompts, ADefaultValues,
    procedure(const AResult: TModalResult; const AValues: array of string)
    begin
      if Assigned(ACloseQueryEvent) then
        ACloseQueryEvent(AContext, AResult, AValues);
    end);
end;

{$ENDREGION}

initialization
  TPlatformServices.Current.AddPlatformService(IFMXDialogServiceSync, TFMXDialogService.Current);
  TPlatformServices.Current.AddPlatformService(IFMXDialogServiceAsync, TFMXDialogService.Current);
end.
