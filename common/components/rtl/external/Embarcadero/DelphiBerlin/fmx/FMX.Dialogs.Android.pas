{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Dialogs.Android;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.Generics.Collections, System.UITypes,
  Androidapi.JNIBridge, Androidapi.JNI.Embarcadero, Androidapi.Jni.JavaTypes,
  FMX.Dialogs;

type
  TFMXDialogListener = class;
  TFMXDialogListenerParentList = class(TList<TFmxDialogListener>)
  end;
  TFMXDialogListener = class(TJavaLocal, JFMXDialogListener)
  private
    [Weak] FParentList: TFMXDialogListenerParentList;
    FValues: array of string;
    FDefaultValues: array of string;
    FModalResult: TModalResult;
    FInputCloseQueryProc: TInputCloseQueryProc;
    FCallerThread: TThread;
    procedure DoDialogClosed;
    procedure SetParentList(const AList: TFMXDialogListenerParentList);
  public
    constructor Create(const AInputCloseQueryProc: TInputCloseQueryProc);
    procedure onDialogClosed(modalResult: Integer; values: TJavaObjectArray<JString>); cdecl;
    property ParentList: TFMXDialogListenerParentList read FParentList write SetParentList;
  end;


implementation

uses
  System.SysUtils, System.IOUtils, System.Math,
  Androidapi.Jni, Androidapi.Helpers,
  FMX.Platform.Android, FMX.Helpers.Android,
  FMX.Platform, FMX.Consts, FMX.Forms;

type
  TFMXDialogService = class(TInterfacedObject, IFMXDialogServiceAsync)
  public const
    MsgCaptions: array [TMsgDlgType] of string = (SMsgDlgWarning, SMsgDlgError, SMsgDlgInformation, SMsgDlgConfirm, '');
  strict private
    constructor Create;
    class var FCurrent: TFMXDialogService;
    class function GetCurrent: TFMXDialogService; static;
  private
    FAlertListeners: TFMXDialogListenerParentList;

    { IFMXDialogServiceAsync }
    /// <summary>Show a simple message box with an 'Ok' button to close it.</summary>
    procedure ShowMessageAsync(const AMessage: string); overload;
    /// <summary>Show a simple message box with an 'Ok' button to close it.</summary>
    procedure ShowMessageAsync(const AMessage: string; const ACloseDialogProc: TInputCloseDialogProc); overload;
    /// <summary>Show a simple message box with an 'Ok' button to close it.</summary>
    procedure ShowMessageAsync(const AMessage: string; const ACloseQueryEvent: TInputCloseDialogEvent;
      const AContext: TObject = nil); overload;

    /// <summary>Shows custom message dialog with specified buttons on it.</summary>
    procedure MessageDialogAsync(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
      const ADefaultButton: TMsgDlgBtn; const AHelpCtx: LongInt; const ACloseDialogProc: TInputCloseDialogProc); overload;
    /// <summary>Shows custom message dialog with specified buttons on it.</summary>
    procedure MessageDialogAsync(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
      const ADefaultButton: TMsgDlgBtn; const AHelpCtx: LongInt; const ACloseDialogEvent: TInputCloseDialogEvent;
      const AContext: TObject = nil); overload;

    /// <summary>Shows an input message dialog with the specified promps and values on it. </summary>
    procedure InputQueryAsync(const ACaption: string; const APrompts: array of string; const ADefaultValues: array of string;
      const ACloseQueryProc: TInputCloseQueryProc); overload;
    /// <summary>Shows an input message dialog with the specified promps and values on it. </summary>
    procedure InputQueryAsync(const ACaption: string; const APrompts: array of string; const ADefaultValues: array of string;
      const ACloseQueryEvent: TInputCloseQueryWithResultEvent; const AContext: TObject = nil); overload;

  public
    destructor Destroy; override;
    class destructor UnInitialize;
    class property Current: TFMXDialogService read GetCurrent;
  end;


{ TFMXDialogListener }

constructor TFMXDialogListener.Create(const AInputCloseQueryProc: TInputCloseQueryProc);
begin
  inherited Create;
  FInputCloseQueryProc := AInputCloseQueryProc;
  FCallerThread := TThread.Current;
end;

procedure TFMXDialogListener.DoDialogClosed;
begin
  FInputCloseQueryProc(FModalResult, FValues);
  if FParentList <> nil then
    FParentList.Remove(Self);
end;

procedure TFMXDialogListener.onDialogClosed(modalResult: Integer;
  values: TJavaObjectArray<JString>);
var
  I: Integer;
begin
  FModalResult := modalResult;
  if values <> nil then
  begin
    SetLength(FValues, values.Length);
    for I := 0 to values.Length - 1 do
    begin
        if FModalResult = mrOk then
          FValues[I] := JStringToString(values.Items[I])
        else
          FValues[I] := FDefaultValues[I];
    end
  end;
  TThread.Queue(FCallerThread, DoDialogClosed);
end;

procedure TFMXDialogListener.SetParentList(const AList: TFMXDialogListenerParentList);
begin
  FParentList := AList;
  if FParentList <> nil then
    FParentList.Add(Self);
end;

{ TFMXDialogService }

constructor TFMXDialogService.Create;
begin
  inherited;
  FAlertListeners := TFMXDialogListenerParentList.Create;
end;

destructor TFMXDialogService.Destroy;
begin
  FAlertListeners.Free;
  inherited;
end;

class function TFMXDialogService.GetCurrent: TFMXDialogService;
begin
  if FCurrent = nil then
    FCurrent := TFMXDialogService.Create;
  Result := FCurrent;
end;

class destructor TFMXDialogService.UnInitialize;
begin
  FCurrent.DisposeOf;
  FCurrent := nil;
end;

{ IFMXDialogServiceAsync }

procedure TFMXDialogService.ShowMessageAsync(const AMessage: string);
begin
  MessageDialogAsync(AMessage, TMsgDlgType.mtCustom, [TMsgDlgBtn.mbOk], TMsgDlgBtn.mbOk, 0, nil);
end;

procedure TFMXDialogService.ShowMessageAsync(const AMessage: string; const ACloseDialogProc: TInputCloseDialogProc);
begin
  MessageDialogAsync(AMessage, TMsgDlgType.mtCustom, [TMsgDlgBtn.mbOk], TMsgDlgBtn.mbOk, 0, ACloseDialogProc);
end;

procedure TFMXDialogService.ShowMessageAsync(const AMessage: string; const ACloseQueryEvent: TInputCloseDialogEvent;
      const AContext: TObject);
begin
  MessageDialogAsync(AMessage, TMsgDlgType.mtCustom, [TMsgDlgBtn.mbOk], TMsgDlgBtn.mbOk, 0, ACloseQueryEvent, AContext);
end;

procedure TFMXDialogService.MessageDialogAsync(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const ADefaultButton: TMsgDlgBtn; const AHelpCtx: LongInt; const ACloseDialogProc: TInputCloseDialogProc);
var
  DialogFactory: JFMXDialogFactory;
  DialogListener: TFMXDialogListener;
  AlertDialog: JFMXStandardDialog;
  PosButton, NegButton, NeutralButton: Integer;
  B: TMsgDlgBtn;
  ButtonIndex: Integer;
  ButtonsCount: Integer;
  LCaptions: TJavaObjectArray<JString>;
  I: TMsgDlgBtn;
begin
  MessageDialogCheckInUIThread;
  ButtonsCount := 0;
  ButtonIndex := 0;
  PosButton := -1;
  NegButton := -1;
  NeutralButton := -1;

  for I := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
    if I in AButtons then
      Inc(ButtonsCount);
  ButtonsCount := Min(ButtonsCount, 3);

  LCaptions := TJavaObjectArray<JString>.Create(ButtonsCount);

  for B in AButtons do
  begin
    if ButtonIndex < ButtonsCount then
    begin
      LCaptions.Items[ButtonIndex] := StringToJString(ButtonCaptions[B]);
      case ButtonIndex of
        0: PosButton := ModalResults[B];
        1: NegButton := ModalResults[B];
        2: NeutralButton := ModalResults[B];
      end;
    end;
    Inc(ButtonIndex);
  end;

  DialogFactory := TJFMXDialogFactory.JavaClass.getFactory;
  if DialogFactory <> nil then
  begin
    CallInUIThread(
      procedure
      begin
        AlertDialog := DialogFactory.createMessageDialog(MainActivity, GetNativeTheme, StringToJString(AMessage),
          Ord(ADialogType), LCaptions, PosButton, NegButton, NeutralButton);

        if AlertDialog <> nil then
        begin
          if Assigned(ACloseDialogProc) then
          begin
            DialogListener := TFMXDialogListener.Create(
              procedure (const AResult: TModalResult; const AValues: array of string)
              begin
                ACloseDialogProc(AResult);
              end);
            DialogListener.ParentList := FAlertListeners;
            AlertDialog.setListener(DialogListener);
          end;
          AlertDialog.show;
        end;
      end);
  end;
end;

procedure TFMXDialogService.MessageDialogAsync(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: TMsgDlgButtons;
  const ADefaultButton: TMsgDlgBtn; const AHelpCtx: LongInt; const ACloseDialogEvent: TInputCloseDialogEvent;
  const AContext: TObject);
begin
  MessageDialogAsync(AMessage, ADialogType, AButtons, ADefaultButton, AHelpCtx,
      procedure (const AResult: TModalResult)
      begin
        if Assigned(ACloseDialogEvent) then
          AcloseDialogEvent(AContext, AResult);
      end);
end;

procedure TFMXDialogService.InputQueryAsync(const ACaption: string; const APrompts: array of string;
  const ADefaultValues: array of string; const ACloseQueryProc: TInputCloseQueryProc);
var
  QueryDialog: JFMXStandardDialog;
  DialogListener: TFMXDialogListener;
  DialogFactory: JFMXDialogFactory;
  JavaPrompts: TJavaObjectArray<JString>;
  JavaDefaultValues: TJavaObjectArray<JString>;
  LCaptions: TJavaObjectArray<JString>;
  LDefaultValues: array of string;
  I: Integer;
begin
  MessageDialogCheckInUIThread;
  if Length(ADefaultValues) < Length(APrompts) then
    raise EInvalidOperation.Create(SPromptArrayTooShort);
  if Length(APrompts) = 0 then
    raise EInvalidOperation.Create(SPromptArrayEmpty);

  JavaPrompts := TJavaObjectArray<JString>.Create(Length(APrompts));
  JavaDefaultValues := TJavaObjectArray<JString>.Create(Length(ADefaultValues));
  for I := 0 to Length(APrompts) - 1 do
    JavaPrompts[I] := StringToJString(APrompts[I]);
  for I := 0 to Length(ADefaultValues) - 1 do
    JavaDefaultValues[I] := StringToJString(ADefaultValues[I]);
  LCaptions := TJavaObjectArray<JString>.Create(2);
  LCaptions.Items[0] := StringToJString(ButtonCaptions[TMsgDlgBtn.mbOK]);
  LCaptions.Items[1] := StringToJString(ButtonCaptions[TMsgDlgBtn.mbCancel]);

  SetLength(LDefaultValues, Length(ADefaultValues));
  TArray.Copy<string>(ADefaultValues, LDefaultValues, Length(ADefaultValues));

  DialogFactory := TJFMXDialogFactory.JavaClass.getFactory;
  if DialogFactory <> nil then
  begin
    CallInUIThread(
      procedure
        begin
          QueryDialog := DialogFactory.createInputQueryDialog(MainActivity, GetNativeTheme, StringToJString(ACaption),
            JavaPrompts, JavaDefaultValues, LCaptions);
          if QueryDialog <> nil then
          begin
            if Assigned(ACloseQueryProc) then
            begin
              DialogListener := TFMXDialogListener.Create(ACloseQueryProc);
              I := DialogListener.FRefCount;
              DialogListener.ParentList := FAlertListeners;
              I := DialogListener.FRefCount;
              SetLength(DialogListener.FDefaultValues, Length(LDefaultValues));
              TArray.Copy<string>(LDefaultValues, DialogListener.FDefaultValues, Length(LDefaultValues));
              QueryDialog.setListener(DialogListener);
            end;
            QueryDialog.show;
          end;
        end);
  end;
end;

procedure TFMXDialogService.InputQueryAsync(const ACaption: string; const APrompts: array of string;
  const ADefaultValues: array of string; const ACloseQueryEvent: TInputCloseQueryWithResultEvent;
  const AContext: TObject);
begin
  InputQueryAsync(ACaption, APrompts, ADefaultValues,
    procedure(const AResult: TModalResult; const AValues: array of string)
      begin
        if Assigned(ACloseQueryEvent) then
          ACloseQueryEvent(AContext, AResult, AValues);
      end
    );
end;

initialization
  TPlatformServices.Current.AddPlatformService(IFMXDialogServiceAsync, TFMXDialogService.Current);
end.
