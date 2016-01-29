{*************************************************************}
{                                                             }
{       Borland Web Application Debugger                      }
{                                                             }
{   Copyright (c) 2001-2002 Borland Software Corporation      }
{                                                             }
{*************************************************************}

unit SvrMainForm;

interface

uses
{$IFDEF MSWINDOWS}
  Windows, Registry,
{$ENDIF}
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QActnList, QStdCtrls, SvrHTTPIndy, QMenus, IniFiles,
  QExtCtrls, QComCtrls,
  SvrLog, SvrLogFrame, SvrStatsFrame, QTypes, Qt;

type
  TWebAppDbgMainForm = class(TForm)
    pbToggle: TButton;
    ActionList1: TActionList;
    ToggleServerAction: TAction;
    MainMenu1: TMainMenu;
    PropertiesItem: TMenuItem;
    StartServer1: TMenuItem;
    StopServer1: TMenuItem;
    Properties1: TMenuItem;
    Exit1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    ExitAction: TAction;
    StopAction: TAction;
    StartAction: TAction;
    AboutAction: TAction;
    PropertiesAction: TAction;
    BrowseAction: TAction;
    PopupMenu1: TPopupMenu;
    Properties2: TMenuItem;
    StartServer2: TMenuItem;
    StopServer2: TMenuItem;
    Exit2: TMenuItem;
    Label2: TLabel;
    Home: TLabel;
    MainUpdateAction: TAction;
    ClearAction: TAction;
    Label1: TLabel;
    Port: TLabel;
    GroupBox1: TGroupBox;
    LogFrame: TLogFrame;
    ToggleLogAction: TAction;
    CheckBox1: TCheckBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    StatsFrame: TStatsFrame;
    procedure ToggleServerActionExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ToggleServerActionUpdate(Sender: TObject);
    procedure StopActionExecute(Sender: TObject);
    procedure StopActionUpdate(Sender: TObject);
    procedure StartActionExecute(Sender: TObject);
    procedure StartActionUpdate(Sender: TObject);
    procedure PropertiesActionExecute(Sender: TObject);
    procedure ExitActionExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure HomeClick(Sender: TObject);
    procedure HideActionExecute(Sender: TObject);
    procedure SysTray1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MainUpdateActionExecute(Sender: TObject);
    procedure MainUpdateActionUpdate(Sender: TObject);
    procedure ToggleLogActionExecute(Sender: TObject);
    procedure ToggleLogActionUpdate(Sender: TObject);
    procedure AboutActionExecute(Sender: TObject);
    procedure StatsFrameResetCountsActionExecute(Sender: TObject);
  private
    FBrowser: string;
    function GetUDPPort: Integer;
    function GetHelpPath: String;
    procedure SetUDPPort(const Value: Integer);
  protected
{$IFDEF LINUX}
    function EventFilter(Sender: QObjectH; Event: QEventH): Boolean; override;
{$ENDIF}
  private
    FShowAtStartup: Boolean;
    FActiveAtStartup: Boolean;
    FHideOnClose: Boolean;
    FWebServer: TCustomWebServer;
    FLogOn: Boolean;
    function GetSearchPath: string;
    function GetServerActive: Boolean;
    function GetServerPort: Integer;
    procedure SetSearchPath(const Value: string);
    procedure SetServerActive(const Value: Boolean);
    procedure SetServerPort(const Value: Integer);
    function GetDefaultURL: string;
    procedure SetDefaultURL(const Value: string);
    procedure Load(Reg: TCustomIniFile);
    procedure Save(Reg: TCustomIniFile);
    function GetTranslatedDefaultURL: string;
    procedure OnLog(Sender: TObject; Transaction: TTransactionLogEntry;
      var Release: Boolean);
    function GetLogMax: Integer;
    procedure SetLogMax(const Value: Integer);
    function GetLogDelete: Integer;
    procedure SetLogDelete(const Value: Integer);
    property ServerActive: Boolean read GetServerActive write SetServerActive;
    property ServerSearchPath: string read GetSearchPath write SetSearchPath;
    property ServerPort: Integer read GetServerPort write SetServerPort;
    property UDPPort: Integer read GetUDPPort write SetUDPPort;
    property Browser: string read FBrowser write FBrowser;
    property DefaultURL: string read GetDefaultURL write SetDefaultURL;
    property TranslatedDefaultURL: string read GetTranslatedDefaultURL;
    property LogMax: Integer read GetLogMax write SetLogMax;
    property LogDelete: Integer read GetLogDelete write SetLogDelete;
    property ShowAtStartup: Boolean read FShowAtStartup write FShowAtStartup;
    property ActiveAtStartup: Boolean read FActiveAtStartup write FActiveAtStartup;
    property HideOnClose: Boolean read FHideOnClose write FHideOnClose;
    property LogOn: Boolean read FLogOn write FLogOn;
  end;

{$IFDEF LINUX}
  function PIDFileName: string;
  function PIDFromFile: Integer;
  procedure WritePIDFile;
  procedure DeletePIDFile;
{$ENDIF}

var
  WebAppDbgMainForm: TWebAppDbgMainForm;

implementation


uses SvrPropDlg, {$IFDEF MSWINDOWS} ShellAPI, WebAppDbgHelp, WinHelpViewer, {$ENDIF}
     SvrConst, WebAppDbgAbout, SockAppReg {$IFDEF LINUX}, Libc {$ENDIF};

{$R *.xfm}

procedure TWebAppDbgMainForm.ToggleServerActionExecute(Sender: TObject);
begin
  ServerActive := not ServerActive;
end;

{$IFDEF LINUX}
procedure SignalProc(SigNum: Integer); cdecl; forward;
{$ENDIF}

procedure TWebAppDbgMainForm.FormCreate(Sender: TObject);
var
  Reg: TCustomIniFile;
begin
{$IFDEF LINUX}
  signal(SIGUSR2, SignalProc);
{$ENDIF}
  HelpFile := GetHelpPath + sWebAppDebuggerHelpFile;
  Caption := sWebAppDebugger;
  Application.Title := sWebAppDebugger;
  Application.HelpFile := HelpFile;
  FWebServer := TCustomWebServer.Create(Self);
  FWebServer.OnLog := OnLog;
  FWebServer.Port := 8081;
  Browser := 'mozilla';  // Do not localize

  FWebServer.DefaultURL := 'ServerInfo.ServerInfo';    // Do not localize
{$IFDEF MSWINDOWS}
  FWebServer.SearchPath := '$(DELPHI)\source\webmidas;$(DELPHI)\demos\websnap\images'; // Do not localize
{$ENDIF}
  LogOn := True;
  ShowAtStartup := True;
  ActiveAtStartup := False;
  Reg := CreateRegistry(True);
  try
    Load(Reg);
  finally
    Reg.Free;
  end;
  FWebServer.RunningWebAppListener.Active := True;
  if ActiveAtStartup then
    FWebServer.Active := True;
end;

procedure TWebAppDbgMainForm.ToggleServerActionUpdate(Sender: TObject);
begin
  if ServerActive then
    (Sender as TAction).Caption := sStopServer
  else
    (Sender as TAction).Caption := sStartServer;
end;

procedure TWebAppDbgMainForm.StopActionExecute(Sender: TObject);
begin
  ServerActive := False;
end;

procedure TWebAppDbgMainForm.StopActionUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := ServerActive;
end;

procedure TWebAppDbgMainForm.StartActionExecute(Sender: TObject);
begin
  ServerActive := True;
end;

procedure TWebAppDbgMainForm.StartActionUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := not ServerActive;
end;

function TWebAppDbgMainForm.GetSearchPath: string;
begin
  Result := FWebServer.SearchPath;
end;

function TWebAppDbgMainForm.GetServerActive: Boolean;
begin
  Result := FWebServer.Active;
end;

function TWebAppDbgMainForm.GetServerPort: Integer;
begin
  Result := FWebServer.Port;
end;

procedure TWebAppDbgMainForm.SetSearchPath(const Value: string);
begin
  FWebServer.SearchPath := Value;
end;

procedure TWebAppDbgMainForm.SetServerActive(const Value: Boolean);
begin
  FWebServer.Active := Value;
end;

procedure TWebAppDbgMainForm.SetServerPort(const Value: Integer);
begin
  if ServerActive and (Value <> FWebServer.Port) then
  begin
    FWebServer.Active := False;
    FWebServer.Port := Value;
    FWebServer.Active := True;
  end
  else
    FWebServer.Port := Value;
end;

function TWebAppDbgMainForm.GetHelpPath : String;
begin
  Result := '';
{$IFDEF MSWINDOWS}
  Result := WebAppDbgHelp.GetHelpPath;
{$ENDIF}
end;

procedure TWebAppDbgMainForm.SetUDPPort(const Value: Integer);
begin
  with FWebServer.RunningWebAppListener do
    if Active and (Value <> Port) then
    begin
      Active := False;
      Port := Value;
      Active := True;
    end
    else
      Port := Value;
end;

procedure TWebAppDbgMainForm.PropertiesActionExecute(Sender: TObject);
var
  Reg: TCustomIniFile;
begin
  with TDlgProperties.Create(Application) do
  try
    ServerPort := Self.ServerPort;
    ServerSearchPath := Self.ServerSearchPath;
    DefaultURL := Self.DefaultURL;
    LogMax := Self.LogMax;
    LogDelete := Self.LogDelete;
    ShowAtStartup := Self.ShowAtStartup;
    ActiveAtStartup := Self.ActiveAtStartup;
    HideOnClose := Self.HideOnClose;
    LogFrame := Self.LogFrame;
    UDPPort := Self.UDPPort;
    Browser := Self.Browser;

    if ShowModal = mrOk then
    begin
      Self.ServerPort := ServerPort;
      Self.ServerSearchPath := ServerSearchPath;
      Self.DefaultURL := DefaultURL;
      Self.LogMax := LogMax;
      Self.LogDelete := LogDelete;
      Self.ShowAtStartup := ShowAtStartup;
      Self.ActiveAtStartup := ActiveAtStartup;
      Self.HideOnClose := HideOnClose;
      Self.UDPPort := UDPPort;
      Self.Browser := Browser;
      UpdateColumns;
      Reg := CreateRegistry;
      try
        Save(Reg);
      finally
        Reg.Free;
      end;
    end;
  finally
    Free;
  end;
end;

procedure TWebAppDbgMainForm.ExitActionExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TWebAppDbgMainForm.FormDestroy(Sender: TObject);
var
  Reg: TCustomIniFile;
begin
  LogFrame.SynchColumnInfo;
  Reg := CreateRegistry;
  try
    Save(Reg);
  finally
    Reg.Free;
  end;
  FWebServer.Free;
end;
{$IFDEF LINUX}
const
  QEventType_ExecFailed = QEventType(Integer(QEventType_ClxUser) + $01);
  QEventType_Activate = QEventType(Integer(QEventType_ClxUser) + $02);

procedure SignalProc(SigNum: Integer); cdecl;
begin
  case SigNum of
    SIGUSR1:
    begin
      QApplication_postEvent(WebAppDbgMainForm.Handle, QCustomEvent_create(QEventType_ExecFailed, nil));
      QApplication_wakeUpGuiThread(Application.Handle);
    end;
    SIGUSR2:
    begin
      // User attempted to start another instance of the web app debugger.  Write the PID to a file
      // to confirm that an instance is already running.
      WritePIDFile;
      QApplication_postEvent(WebAppDbgMainForm.Handle, QCustomEvent_create(QEventType_Activate, nil));
      QApplication_wakeUpGuiThread(Application.Handle);
    end;
  end;
end;

var
  LastBrowser: string;
{$ENDIF}
procedure TWebAppDbgMainForm.HomeClick(Sender: TObject);
{$IFDEF LINUX}
  // Modified version of SysUtils.FileSearch.  This version will not find
  // a directory.
  function FileSearch(const Name, DirList: string): string;
  var
    I, P, L: Integer;
    C: Char;
  begin
    Result := Name;
    P := 1;
    L := Length(DirList);
    while True do
    begin
      if FileExists(Result) and not DirectoryExists(Result) then Exit;  // Changed
      while (P <= L) and (DirList[P] = PathSep) do Inc(P);
      if P > L then Break;
      I := P;
      while (P <= L) and (DirList[P] <> PathSep) do
      begin
        if DirList[P] in LeadBytes then
          P := NextCharIndex(DirList, P)
        else
          Inc(P);
      end;
      Result := Copy(DirList, I, P - I);
      C := AnsiLastChar(Result)^;
      if (C <> DriveDelim) and (C <> PathDelim) then
        Result := Result + PathDelim;
      Result := Result + Name;
    end;
    Result := '';
  end;
const
  FailToken = '!!Fail!!';
  MaxToken = 256;
var
  PID: Integer;
  Argv: array of PChar;
  Sockets: TSocketArray;
  ParentPID: Integer;
  Env: array of PChar;
  P: PChar;
  LibPath: string;
  I, J: Integer;
  S: TStrings;
  Path: string;
{$ENDIF}
begin
  // Add browse code here
  if ServerActive then
    if TranslatedDefaultURL <> '' then
{$IFDEF MSWINDOWS}
      ShellExecute(0, // jmt.!!! Application.Handle,
        nil,
        PChar(TranslatedDefaultURL), nil, nil, SW_SHOWNOACTIVATE);
{$ENDIF}
{$IFDEF LINUX}
    begin
      LastBrowser := Browser;
      if Pos(PathSep, LastBrowser) = 0 then
      begin
        Path := getenv('PATH');
        LastBrowser := FileSearch(LastBrowser, Path);
        if LastBrowser = '' then
        begin
          ShowMessage(Format(sBrowserNotFound, [Browser]));
          Exit;
        end;
      end
      else if not FileExists(LastBrowser) then
      begin
        ShowMessage(Format(sBrowserNotFound, [Browser]));
        Exit;
      end;
      SetLength(Argv, 3);
      Argv[0] := PChar(LastBrowser);
      Argv[1] := PChar(TranslatedDefaultURL);
      Argv[2] := nil;
      // Remove path of mozilla widget from environment so that mozilla widget so's will
      // not interfere with newer versions of mozilla.
      P := System.envp^;
      I := 0;
      while P^ <> #0 do
      begin
        SetLength(Env, I + 1);
        if StrLComp(P, 'LD_LIBRARY_PATH=', Length('LD_LIBRARY_PATH=')) = 0 then
        begin
          S := TStringList.Create;
          try
            ExtractStrings([':'], [], @P[Length('LD_LIBRARY_PATH=')], S);
            S.Delimiter := ':';
            for J := S.Count - 1 downto 0 do
              if Pos('mozilla', S[J]) > 0 then
                S.Delete(J);
            LibPath := 'LD_LIBRARY_PATH=' + S.DelimitedText;
          finally
            S.Free;
          end;
          Env[I] := PChar(LibPath);
        end
        else
          Env[I] := P;
        P := P + StrLen(P) + 1;
        Inc(I);
      end;
      SetLength(Env, I+1);
      Env[I] := nil;
      ParentPID := getpid;
      FWebServer.GetOpenSockets(Sockets);
      signal(SIGUSR1, SignalProc);
      PID := fork;
      if PID = 0 then
      begin
        CloseOpenSockets(Sockets);
        if execve(PChar(Argv[0]), @Argv[0], @Env[0]) = -1 then
          kill(ParentPID, SIGUSR1);
        _exit(1);
      end;
    end;
{$ENDIF}
end;

function TWebAppDbgMainForm.GetDefaultURL: string;
begin
  Result := FWebServer.DefaultURL;
end;

procedure TWebAppDbgMainForm.SetDefaultURL(const Value: string);
begin
  FWebServer.DefaultURL := Value;
end;

const
  sPort = 'Port';
  sPath = 'Path';
  sDefaultURL = 'DefaultURL';
  sLogMax = 'LogMax';
  sLogDelete = 'LogDelete';
  sShowAtStartup = 'ShowAtStartup';
  sActiveAtStartup = 'ActiveAtStartup';
  sColumns = 'Columns';
  sHideOnClose = 'HideOnClose';
  sLogOn = 'LogOn';
  sLeft = 'Left';
  sTop = 'Top';
  sWidth = 'Width';
  sHeight = 'Height';
  sWindowState = 'WindowState';
  sBrowser = 'Browser';

procedure TWebAppDbgMainForm.Save(Reg: TCustomIniFile);
begin
  Reg.WriteInteger('', sPort, ServerPort);
  Reg.WriteString('', sPath, ServerSearchPath);
  Reg.WriteString('', sDefaultURL, DefaultURL);
  Reg.WriteInteger('', sLogMax, LogMax);
  Reg.WriteInteger('', sLogDelete, LogDelete);
  Reg.WriteBool('', sShowAtStartup, ShowAtStartup);
  Reg.WriteBool('', sActiveAtStartup, ActiveAtStartup);
  Reg.WriteBool('', sHideOnClose, HideOnClose);
  Reg.WriteBool('', sLogOn, LogOn);
  Reg.WriteInteger('', sWindowState, Integer(Self.WindowState));
  Reg.WriteInteger('', sUDPPort, UDPPort);
  Reg.WriteString('', sBrowser, Browser);
  if WindowState = wsNormal then
  begin
    Reg.WriteInteger('', sLeft, Self.Left);
    Reg.WriteInteger('', sTop, Self.Top);
    Reg.WriteInteger('', sWidth, Self.Width);
    Reg.WriteInteger('', sHeight, Self.Height);
  end;
  LogFrame.Save(Reg, sColumns);
  Reg.UpdateFile;
end;

procedure TWebAppDbgMainForm.Load(Reg: TCustomIniFile);
begin
  ServerPort := Reg.ReadInteger('', sPort, ServerPort);
  ServerSearchPath := Reg.ReadString('', sPath, ServerSearchPath);
  DefaultURL := Reg.ReadString('', sDefaultURL, DefaultURL);
  LogMax := Reg.ReadInteger('', sLogMax, LogMax);
  LogDelete := Reg.ReadInteger('', sLogDelete, LogDelete);
  ShowAtStartup := Reg.ReadBool('', sShowAtStartup, ShowAtStartup);
  ActiveAtStartup := Reg.ReadBool('', sActiveAtStartup, ActiveAtStartup);
  HideOnClose := Reg.ReadBool('', sHideOnClose, HideOnClose);
  LogOn := Reg.ReadBool('', sLogOn, LogOn);
  UDPPort := Reg.ReadInteger('', sUDPPort, UDPPort);
  Browser := Reg.ReadString('', sBrowser, Browser);
  if Reg.ValueExists('', sLeft) then
  begin
    Position := poDesigned;
    Self.Left := Reg.ReadInteger('', sLeft, Self.Left);
    Self.Top := Reg.ReadInteger('', sTop, Self.Top);
    Self.Width := Reg.ReadInteger('', sWidth, Self.Width);
    Self.Height := Reg.ReadInteger('', sHeight, Self.Height);
    Self.WindowState := TWindowState(Reg.ReadInteger('', sWindowState, Integer(Self.WindowState)));
  end;
  LogFrame.Load(Reg, sColumns);
end;

procedure TWebAppDbgMainForm.HideActionExecute(Sender: TObject);
begin
  Visible := False;
end;

procedure TWebAppDbgMainForm.SysTray1DblClick(Sender: TObject);
begin
  Visible := not Visible;
end;

procedure TWebAppDbgMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure TWebAppDbgMainForm.MainUpdateActionExecute(Sender: TObject);
begin
//
end;

procedure TWebAppDbgMainForm.MainUpdateActionUpdate(Sender: TObject);
begin
  if (TranslatedDefaultURL <> '') then
    Home.Caption := TranslatedDefaultURL
  else
    Home.Caption := sNoDefaultURL;
  if ServerActive and (TranslatedDefaultURL <> '') then
  begin
    Home.Font.Color := clHighlight;
    Home.Font.Style := [fsUnderline];
    Home.Cursor := crHandPoint;
  end
  else
  begin
    Home.Font.Color := clWindowText;
    Home.Font.Style := [];
    Home.Cursor := crDefault;
  end;
  Port.Caption := IntToStr(ServerPort);
end;

function TWebAppDbgMainForm.GetTranslatedDefaultURL: string;
begin
  Result := FWebServer.TranslatedDefaultURL;
end;

procedure TWebAppDbgMainForm.OnLog(Sender: TObject; Transaction: TTransactionLogEntry;
  var Release: Boolean);
begin
  StatsFrame.LogStatistics(Transaction);
  if LogOn then
  begin
    LogFrame.Add(Transaction);
    Release := False;
  end
  else
    Release := True;
end;

function TWebAppDbgMainForm.GetLogMax: Integer;
begin
  Result := LogFrame.LogMax;
end;

procedure TWebAppDbgMainForm.SetLogMax(const Value: Integer);
begin
  LogFrame.LogMax := Value;
end;

function TWebAppDbgMainForm.GetLogDelete: Integer;
begin
  Result := LogFrame.LogDelete;
end;

procedure TWebAppDbgMainForm.SetLogDelete(const Value: Integer);
begin
  LogFrame.LogDelete := Value;
end;

procedure TWebAppDbgMainForm.ToggleLogActionExecute(Sender: TObject);
begin
  FLogOn := CheckBox1.Checked;
end;

procedure TWebAppDbgMainForm.ToggleLogActionUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked := FLogOn;
end;

procedure TWebAppDbgMainForm.AboutActionExecute(Sender: TObject);
begin
  ShowAboutBox;
end;

function TWebAppDbgMainForm.GetUDPPort: Integer;
begin
  Result := FWebServer.RunningWebAppListener.Port;
end;

{$IFDEF LINUX }
function TWebAppDbgMainForm.EventFilter(Sender: QObjectH;
  Event: QEventH): Boolean;
var
  EventType: QEventType;
begin
  EventType := QEvent_type(Event);
  case EventType of
    QEventType_ExecFailed:
      ShowMessage(Format(sBrowserExecFailed, [LastBrowser]));
    QEventType_Activate:
    begin
      // User attempted to start another instance of the web app debugger
      QWidget_showNormal(Self.Handle);
      QWidget_setActiveWindow(Self.Handle);
      BringToFront;
    end;
  end;
  Result := inherited EventFilter(Sender, Event);
end;
{$ENDIF}

{$IFDEF LINUX}
function PIDFileName: string;
const
  sPIDFile = 'webappdbgpid.txt';
begin
  __mkdir(PChar(getenv('HOME') + '/.borland'), S_IRWXU or S_IRWXG or S_IRWXO);
  result := getenv('HOME') + '/.borland/wappappdbg.lck';
end;

function PIDFromFile: Integer;
var
  PIDFile: string;
  S: TStream;
begin
  Result := 0;
  PIDFile := PIDFileName;
  if FileExists(PIDFile) then
  begin
    S := TFileStream.Create(PIDFile, 0);
    try
      S.Read(Result, sizeof(Integer));
    finally
      S.Free;
    end;
  end;
end;

procedure WritePIDFile;
var
  PID: Integer;
  S: TStream;
begin
  S := TFileStream.Create(PIDFileName, fmCreate);
  try
    PID := getpid;
    S.Write(PID, sizeof(Integer))
  finally
    S.Free;
  end;
end;

procedure DeletePIDFile;
var
  PIDFile: string;
begin
  PIDFile := PIDFileName;
  if FileExists(PIDFile) then
    DeleteFile(PIDFile);
end;
{$ENDIF}

procedure TWebAppDbgMainForm.StatsFrameResetCountsActionExecute(
  Sender: TObject);
begin
  StatsFrame.ResetCountsActionExecute(Sender);
  if StatsFrame.Button1.Focused then
    pbToggle.SetFocus;
end;

end.
