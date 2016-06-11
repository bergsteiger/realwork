{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                FireDAC GUIx layer API                 }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.UI.Intf;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
  System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Error;

type
  IFDGUIxLoginDialog = interface;
  IFDGUIxTimer = interface;
  IFDGUIxWaitCursor = interface;
  IFDGUIxAsyncExecuteDialog = interface;
  IFDGUIxErrorDialog = interface;
  IFDGUIxScriptDialogInfoProvider = interface;
  IFDGUIxScriptDialog = interface;

  { --------------------------------------------------------------------------}
  { Login dialog                                                              }
  { --------------------------------------------------------------------------}
  TFDGUIxLoginAction = procedure of object;
  TFDGUIxLoginHistoryStorage = (hsRegistry, hsFile);
  TFDGUIxLoginDialogEvent = procedure (ASender: TObject; var AResult: Boolean) of object;

  IFDGUIxLoginDialog = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2200}']
    // private
    function GetConnectionDef: IFDStanConnectionDef;
    function GetOnHide: TNotifyEvent;
    function GetOnShow: TNotifyEvent;
    function GetCaption: String;
    function GetChangeExpiredPassword: Boolean;
    function GetHistoryEnabled: Boolean;
    function GetHistoryKey: String;
    function GetHistoryStorage: TFDGUIxLoginHistoryStorage;
    function GetHistoryWithPassword: Boolean;
    function GetLoginRetries: Integer;
    function GetOnChangePassword: TFDGUIxLoginDialogEvent;
    function GetOnLogin: TFDGUIxLoginDialogEvent;
    function GetVisibleItems: TStrings;
    procedure SetConnectionDef(const AValue: IFDStanConnectionDef);
    procedure SetOnHide(const AValue: TNotifyEvent);
    procedure SetOnShow(const AValue: TNotifyEvent);
    procedure SetCaption(const AValue: String);
    procedure SetChangeExpiredPassword(const AValue: Boolean);
    procedure SetHistoryEnabled(const AValue: Boolean);
    procedure SetHistoryKey(const AValue: String);
    procedure SetHistoryStorage(const AValue: TFDGUIxLoginHistoryStorage);
    procedure SetHistoryWithPassword(const AValue: Boolean);
    procedure SetLoginRetries(const AValue: Integer);
    procedure SetOnChangePassword(const AValue: TFDGUIxLoginDialogEvent);
    procedure SetOnLogin(const AValue: TFDGUIxLoginDialogEvent);
    procedure SetVisibleItems(const AValue: TStrings);
    // public
    procedure GetAllLoginParams;
    function Execute(AAction: TFDGUIxLoginAction = nil): Boolean;
    property ConnectionDef: IFDStanConnectionDef read GetConnectionDef write SetConnectionDef;
    property Caption: String read GetCaption write SetCaption;
    property HistoryEnabled: Boolean read GetHistoryEnabled write SetHistoryEnabled;
    property HistoryWithPassword: Boolean read GetHistoryWithPassword write SetHistoryWithPassword;
    property HistoryStorage: TFDGUIxLoginHistoryStorage read GetHistoryStorage write SetHistoryStorage;
    property HistoryKey: String read GetHistoryKey write SetHistoryKey;
    property VisibleItems: TStrings read GetVisibleItems write SetVisibleItems;
    property LoginRetries: Integer read GetLoginRetries write SetLoginRetries;
    property ChangeExpiredPassword: Boolean read GetChangeExpiredPassword write SetChangeExpiredPassword;
    property OnHide: TNotifyEvent read GetOnHide write SetOnHide;
    property OnShow: TNotifyEvent read GetOnShow write SetOnShow;
    property OnLogin: TFDGUIxLoginDialogEvent read GetOnLogin write SetOnLogin;
    property OnChangePassword: TFDGUIxLoginDialogEvent read GetOnChangePassword write SetOnChangePassword;
  end;

  { --------------------------------------------------------------------------}
  { Timer used in GUI                                                         }
  { --------------------------------------------------------------------------}
  IFDGUIxTimer = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2207}']
    // private
    function GetEnabled: Boolean;
    procedure SetEnabled(AValue: Boolean);
    // public
    procedure SetEvent(AProc: TNotifyEvent; ATimeout: LongWord);
    property Enabled: Boolean read GetEnabled write SetEnabled;
  end;

  { --------------------------------------------------------------------------}
  { "Wait, working ..."                                                       }
  { --------------------------------------------------------------------------}
  TFDGUIxScreenCursor = (gcrNone, gcrDefault, gcrHourGlass, gcrSQLWait, gcrAppWait);
  IFDGUIxWaitCursor = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2201}']
    // private
    function GetWaitCursor: TFDGUIxScreenCursor;
    procedure SetWaitCursor(const AValue: TFDGUIxScreenCursor);
    function GetOnShow: TNotifyEvent;
    procedure SetOnShow(const AValue: TNotifyEvent);
    function GetOnHide: TNotifyEvent;
    procedure SetOnHide(const AValue: TNotifyEvent);
    // public
    procedure StartWait;
    procedure StopWait;
    procedure PushWait;
    procedure PopWait;
    procedure ForceStopWait;
    property WaitCursor: TFDGUIxScreenCursor read GetWaitCursor write SetWaitCursor;
    property OnShow: TNotifyEvent read GetOnShow write SetOnShow;
    property OnHide: TNotifyEvent read GetOnHide write SetOnHide;
  end;

  { --------------------------------------------------------------------------}
  { Async execution dialog                                                    }
  { --------------------------------------------------------------------------}
  IFDGUIxAsyncExecuteDialog = interface (IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2202}']
    // private
    function GetOnShow: TNotifyEvent;
    procedure SetOnShow(const AValue: TNotifyEvent);
    function GetOnHide: TNotifyEvent;
    procedure SetOnHide(const AValue: TNotifyEvent);
    function GetCaption: String;
    procedure SetCaption(const AValue: String);
    function GetPrompt: String;
    procedure SetPrompt(const AValue: String);
    function GetShowDelay: Integer;
    procedure SetShowDelay(AValue: Integer);
    function GetHideDelay: Integer;
    procedure SetHideDelay(AValue: Integer);
    // public
    procedure Show(const AExecutor: IFDStanAsyncExecutor);
    procedure Hide;
{$IFDEF MSWINDOWS}
    function IsFormActive: Boolean;
    function IsFormMouseMessage(const AMsg: TMsg): Boolean;
{$ENDIF}
    property Caption: String read GetCaption write SetCaption;
    property Prompt: String read GetPrompt write SetPrompt;
    property ShowDelay: Integer read GetShowDelay write SetShowDelay;
    property HideDelay: Integer read GetHideDelay write SetHideDelay;
    property OnShow: TNotifyEvent read GetOnShow write SetOnShow;
    property OnHide: TNotifyEvent read GetOnHide write SetOnHide;
  end;

  { --------------------------------------------------------------------------}
  { Error dialog                                                              }
  { --------------------------------------------------------------------------}
  TFDGUIxErrorDialogEvent = procedure (ASender: TObject; AException: EFDDBEngineException) of object;
  IFDGUIxErrorDialog = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2203}']
    // private
    function GetOnShow: TFDGUIxErrorDialogEvent;
    procedure SetOnShow(const AValue: TFDGUIxErrorDialogEvent);
    function GetOnHide: TFDGUIxErrorDialogEvent;
    procedure SetOnHide(const AValue: TFDGUIxErrorDialogEvent);
    function GetCaption: String;
    procedure SetCaption(const AValue: String);
    function GetEnabled: Boolean;
    procedure SetEnabled(const AValue: Boolean);
    function GetStayOnTop: Boolean;
    procedure SetStayOnTop(const AValue: Boolean);
    // public
    procedure Execute(E: EFDDBEngineException);
    property Caption: String read GetCaption write SetCaption;
    property Enabled: Boolean read GetEnabled write SetEnabled;
    property StayOnTop: Boolean read GetStayOnTop write SetStayOnTop;
    property OnShow: TFDGUIxErrorDialogEvent read GetOnShow write SetOnShow;
    property OnHide: TFDGUIxErrorDialogEvent read GetOnHide write SetOnHide;
  end;

  { --------------------------------------------------------------------------}
  { Script dialog                                                             }
  { --------------------------------------------------------------------------}
  IFDGUIxScriptDialogInfoProvider = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2206}']
    // private
    function GetCallStack: TStrings;
    function GetTotalJobSize: Integer;
    function GetTotalJobDone: Integer;
    function GetTotalPct10Done: Integer;
    function GetTotalErrors: Integer;
    function GetIsRunning: Boolean;
    // public
    procedure RequestStop;
    property CallStack: TStrings read GetCallStack;
    property TotalJobSize: Integer read GetTotalJobSize;
    property TotalJobDone: Integer read GetTotalJobDone;
    property TotalPct10Done: Integer read GetTotalPct10Done;
    property TotalErrors: Integer read GetTotalErrors;
    property IsRunning: Boolean read GetIsRunning;
  end;

  TFDGUIxScriptProgressEvent = procedure (ASender, AInfoProvider: TObject) of object;
  TFDGUIxScriptOutputEvent = procedure (ASender: TObject; const AStr: String) of object;
  TFDGUIxScriptInputEvent = procedure (ASender: TObject; const APrompt: String;
    var AResult: String) of object;
  TFDGUIxScriptPauseEvent = procedure (ASender: TObject; const APrompt: String) of object;
  TFDGUIxScriptOptions = set of (ssCallstack, ssConsole, ssAutoHide);
  TFDScriptOutputKind = (soSeparator, soEcho, soScript, soInfo, soError, soConnect,
    soServerOutput, soUserOutput, soCommand, soMacro, soData, soParam);

  IFDGUIxScriptDialog = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2205}']
    // private
    function GetOnShow: TNotifyEvent;
    procedure SetOnShow(const AValue: TNotifyEvent);
    function GetOnHide: TNotifyEvent;
    procedure SetOnHide(const AValue: TNotifyEvent);
    function GetOnProgress: TFDGUIxScriptProgressEvent;
    procedure SetOnProgress(const AValue: TFDGUIxScriptProgressEvent);
    function GetOnOutput: TFDGUIxScriptOutputEvent;
    procedure SetOnOutput(const AValue: TFDGUIxScriptOutputEvent);
    function GetOnInput: TFDGUIxScriptInputEvent;
    procedure SetOnInput(const AValue: TFDGUIxScriptInputEvent);
    function GetOnPause: TFDGUIxScriptPauseEvent;
    procedure SetOnPause(const AValue: TFDGUIxScriptPauseEvent);
    function GetCaption: String;
    procedure SetCaption(const AValue: String);
    function GetOptions: TFDGUIxScriptOptions;
    procedure SetOptions(AValue: TFDGUIxScriptOptions);
    // public
    procedure Show;
    procedure Progress(const AInfoProvider: IFDGUIxScriptDialogInfoProvider);
    procedure Output(const AStr: String; AKind: TFDScriptOutputKind);
    procedure Input(const APrompt: String; var AResult: String);
    procedure Pause(const APrompt: String);
    procedure Hide;
    property Caption: String read GetCaption write SetCaption;
    property Options: TFDGUIxScriptOptions read GetOptions write SetOptions;
    property OnShow: TNotifyEvent read GetOnShow write SetOnShow;
    property OnHide: TNotifyEvent read GetOnHide write SetOnHide;
    property OnProgress: TFDGUIxScriptProgressEvent read GetOnProgress write SetOnProgress;
    property OnOutput: TFDGUIxScriptOutputEvent read GetOnOutput write SetOnOutput;
    property OnInput: TFDGUIxScriptInputEvent read GetOnInput write SetOnInput;
    property OnPause: TFDGUIxScriptPauseEvent read GetOnPause write SetOnPause;
  end;

var
  FFDGUIxSilentMode: Boolean;
  FFDGUIxProvider: String;

  function FDGUIxSilent: Boolean;

implementation

uses
  System.SysUtils,
  FireDAC.Stan.Consts, FireDAC.Stan.Util;

{-------------------------------------------------------------------------------}
function FDGUIxSilent: Boolean;
begin
  Result := FFDGUIxSilentMode or (TThread.CurrentThread.ThreadID <> MainThreadID);
end;

{-------------------------------------------------------------------------------}
initialization

  FFDGUIxSilentMode := {$IFDEF MSWINDOWS} IsConsole {$ELSE} False {$ENDIF};
{$IFDEF MSWINDOWS}
  if IsConsole then
    FFDGUIxProvider := C_FD_GUIxConsoleProvider
  else
{$ENDIF}
  if FDIsDesignTime then
    FFDGUIxProvider := C_FD_GUIxFormsProvider
  else if GetClass('TFmxObject') = nil then
{$IFDEF POSIX}
    FFDGUIxProvider := C_FD_GUIxConsoleProvider
{$ELSE}
    FFDGUIxProvider := C_FD_GUIxFormsProvider
{$ENDIF}
  else
    FFDGUIxProvider := C_FD_GUIxFMXProvider;

end.
