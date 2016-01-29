unit iwmain;

interface

{$DENYPACKAGEUNIT ON}

uses
  {$IFDEF Linux}QActnList,{$ELSE}ActnList,{$ENDIF}
  {$IFDEF Linux}QControls,{$ELSE}Controls,{$ENDIF}
  {$IFDEF Linux}QComCtrls,{$ELSE}ComCtrls,{$ENDIF}
  {$IFDEF Linux}QForms,{$ELSE}Forms,{$ENDIF}
  {$IFDEF Linux}QGraphics,{$ELSE}Graphics,{$ENDIF}
  {$IFDEF Linux}QStdCtrls,{$ELSE}StdCtrls,{$ENDIF}
  {$IFDEF Linux}QExtCtrls,{$ELSE}ExtCtrls,{$ENDIF}
  {$IFDEF Linux}QDialogs,{$ELSE}Dialogs,{$ENDIF}
  {$IFDEF Linux}QClipbrd,{$ELSE}Clipbrd,{$ENDIF}
  {$IFDEF Linux}Types,{$ELSE}Windows, Messages,{$ENDIF}
  Classes,
  IWHTTPServer, IWStandAloneServer,
  SysUtils, SyncObjs;

type
  TFormIWMain = class(TForm)
  protected
    FActionList: TActionList;
    FActionFile_ClearSessions: TAction;
    FActionFile_CopyURLToClipboard: TAction;
    FActionFile_ShowDebugInformation: TAction;
    FActionFile_Exit: TAction;
    FActionHelp_About: TAction;
    FActionRun_Execute: TAction;
    FActionRun_ExecuteIE: TAction;
    FActionRun_ExecuteDefault: TAction;
    FActionRun_ExecuteMozilla: TAction;
    FActionRun_ExecuteNS6: TAction;
    FActionRun_ExecuteOpera: TAction;
    FActionRun_Parameters: TAction;
    FActionRun_ExecuteSSL: TAction;
    FCreateWndCalled: Boolean;
    FMemoLog: TMemo;
    FStatusBar: TStatusBar;
    lablActiveSessions: TLabel;
    FStandaloneServer: TIWStandAloneServer;

    FOperaExecutable: String;
    FNS6Executable: String;
    FMozillaExecutable: String;
    FIEExecutable: String;
    //
    procedure AboutOnClick(ASender: TObject);
    procedure actnAboutOnExecute(ASender: TObject);
    procedure actnClearSessionsOnExecute(ASender: TObject);
    procedure actnCopyURLToClipboardOnExecute(ASender: TObject);
    procedure actnExitOnExecute(ASender: TObject);
    procedure actnExecuteDefaultExecute(ASender: TObject);
    procedure actnExecuteOpera(ASender: TObject);
    procedure actnExecuteMozilla(ASender: TObject);
    procedure actnExecuteNS6(ASender: TObject);
    procedure actnExecuteIE(ASender: TObject);
    procedure actnParametersOnExecute(ASender: TObject);
    procedure actnShowDebugInformationOnExecute(ASender: TObject);
    procedure actnTestOnExecute(ASender: TObject);
    procedure actnSetSSL(ASender: TObject);
    procedure SetActiveSessions;
    procedure OnCreateSession(ASender: TObject);
    procedure OnDestroySession(ASender: TObject);
    procedure ActionList1Update(Action: TBasicAction; var Handled: Boolean);
    procedure OnDebugLog(ASender: TObject; ALog: String);

    procedure InitializeToolbar(AToolBar: TToolBar);
    procedure UpdateBrowserSelectionAction;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Log(const AMsg: string);
  end;

var
  formIWMain: TformIWMain;

implementation

{$R IWMain.res}

uses
  {$IFDEF Linux}QMenus,{$ELSE}Menus,{$ENDIF}
  {$IFDEF Linux}QImgList,{$ELSE}ImgList,{$ENDIF}
  {$IFDEF Linux}IWJPeg,{$ELSE}JPeg,{$ENDIF}
  {$IFDEF Linux}Libc, Qt,{$ELSE}ShellAPI, Registry,{$ENDIF}
  IWApplication, IWGlobal, IWServerControllerBase, IWResourceStrings,
  InSync;

Type
  TUpdateSessions = class(TIdNotifyMethod)
  public
    class procedure UpdateSessions;
  end;

// This is here to avoid having to reference Menus/QMenus when ShortCut is called as it conflicts
// in the with statements with the ShortCut property
function MakeShortCut(AKey: Word; AShift: TShiftState): TShortCut;
begin
  Result := ShortCut(AKey, AShift);
end;

constructor TformIWMain.Create(AOwner: TComponent);
var
  LIcon: TIcon;
  LMainMenu: TMainMenu;
  LMenuItem: TMenuItem;
  LMenuItem1: TMenuItem;
  LMenuItemHead: TMenuItem;
  LPanel: TPanel;
  LStream: TResourceStream;
  LToolBar: TToolbar;

  {$IFDEF Linux}
    function ResourceLoad(AImageList: TCustomImageList; AResName: String;
      AMaskColor: TColor): Boolean;
    Var
      LBMP: TBitmap;
    begin
      LBMP := TBitmap.Create; try
        LBMP.LoadFromResourceName(GetModuleHandle(nil), AResName);
        AImageList.AddMasked(LBMP, AMaskColor);
      finally FreeAndNil(LBMP); end;
      result := true;
    end;
  {$ENDIF}
begin
  // DO NOT call inherited!
  CreateNew(AOwner);
  //
  Width := 500;
  Height := 300;
  if Length(Application.Title) > 0 then begin
    Caption := Application.Title + ' Server';
  end else begin
    Caption := 'Intraweb Server';
  end;
  Color := clBtnFace;
  Position := poDefaultPosOnly;
  // Set Icon
  LIcon := TIcon.Create; try
    LStream := TResourceStream.Create(GetModuleHandle(nil), 'IW_MAIN_ICON', RT_RCDATA); try
      LIcon.LoadFromStream(LStream);
    finally FreeAndNil(LStream); end;
    Application.Icon.Assign(LIcon);
  finally FreeAndNil(LIcon); end;

  // Construct Memo in order to be usefull for Log
  FMemoLog := TMemo.Create(Self);
  with FMemoLog do begin
    Parent := Self;
    Left := 169;
    Top := 41;
    Width := 232;
    Height := 223;
    Align := alClient;
    ReadOnly := True;
    ScrollBars := ssVertical;
    TabOrder := 0;
  end;

  // Constructor Standalone Server componenet
  FStandaloneServer := TIWStandAloneServer.Create(self, OnDebugLog);
  // Construct Actions
  FActionList := TActionList.Create(Self);
  FActionList.Images := TImageList.Create(Self);
  FActionList.OnUpdate := ActionList1Update;

  with FActionList.Images do begin
    // TODO: Does not work in Linux and will be removed from here after
    // Porting to Linux
    {$IFNDEF Linux}
    if (not ResourceLoad(rtBitmap, 'IW_MAIN_HTTP', clNone)) // 0
     or (not ResourceLoad(rtBitmap, 'IW_MAIN_HTTPS', clNone)) // 1
     or (not ResourceLoad(rtBitmap, 'IW_MAIN_PARAMS', clNone)) // 2
     or (not ResourceLoad(rtBitmap, 'IW_MAIN_DEBUG', clNone)) // 3
     or (not ResourceLoad(rtBitmap, 'IW_MAIN_COPY', clNone)) // 4
     or (not ResourceLoad(rtBitmap, 'IW_MAIN_CLEAN', clNone)) // 5
     or (not ResourceLoad(rtBitmap, 'IW_MAIN_ABOUT', clNone)) // 6
     or (not ResourceLoad(rtBitmap, 'IW_MAIN_IE', clNone)) // 7
     or (not ResourceLoad(rtBitmap, 'IW_MAIN_NS6', clNone)) // 8
     or (not ResourceLoad(rtBitmap, 'IW_MAIN_MOZILLA', clNone)) // 9
     or (not ResourceLoad(rtBitmap, 'IW_MAIN_OPERA', clNone)) // 10
     then begin
      raise Exception.Create(RSToolBarError);
    end;
    {$ELSE}
    if (not ResourceLoad(FActionList.Images, 'IW_MAIN_HTTP', clNone)) // 0
     or (not ResourceLoad(FActionList.Images, 'IW_MAIN_HTTPS', clNone)) // 1
     or (not ResourceLoad(FActionList.Images, 'IW_MAIN_PARAMS', clNone)) // 2
     or (not ResourceLoad(FActionList.Images, 'IW_MAIN_DEBUG', clNone)) // 3
     or (not ResourceLoad(FActionList.Images, 'IW_MAIN_COPY', clNone)) // 4
     or (not ResourceLoad(FActionList.Images, 'IW_MAIN_CLEAN', clNone)) // 5
     or (not ResourceLoad(FActionList.Images, 'IW_MAIN_ABOUT', clNone)) // 6
     then begin
      raise Exception.Create(RSToolBarError);
    end;
    {$ENDIF}
  end;
  // Clear Sessions
  FActionFile_ClearSessions := TAction.Create(Self);
  with FActionFile_ClearSessions do begin
    ActionList := FActionList;
    Caption := RSClearSessionsCaption;
    Hint := RSClearSessionsHint;
    ShortCut := MakeShortCut(Ord('K'), [ssCtrl]);
    ImageIndex := 5;
    OnExecute := actnClearSessionsOnExecute;
  end;
  // Copy URL to Clipboard
  FActionFile_CopyURLToClipboard := TAction.Create(Self);
  with FActionFile_CopyURLToClipboard do begin
    ActionList := FActionList;
    Caption := RSCopyClipboardCaption;
    Hint := RSCopyClipboardHint;
    ShortCut := MakeShortCut(Ord('C'), [ssCtrl]);
    ImageIndex := 4;
    OnExecute := actnCopyURLToClipboardOnExecute;
  end;
  // Show Debug Information
  FActionFile_ShowDebugInformation := TAction.Create(Self);
  with FActionFile_ShowDebugInformation do begin
    ActionList := FActionList;
    Caption := RSShowDebugInfoCaption;
    Hint := RSShowDebugInfoHint;
    ImageIndex := 3;
    OnExecute := actnShowDebugInformationOnExecute;
  end;
  // Exit
  FActionFile_Exit := TAction.Create(Self);
  with FActionFile_Exit do begin
    ActionList := FActionList;
    Caption := RSExitCaption;
    Hint := RSExitHint;
    OnExecute := actnExitOnExecute;
  end;
  // Execute
  FActionRun_Execute := TAction.Create(Self);
  with FActionRun_Execute do begin
    ActionList := FActionList;
    Caption := RSExecuteCaption;
    Hint := RSExecuteHint;
    case FStandaloneServer.RunIn of
      wbDefault: ImageIndex := 0;
      wbIE: ImageIndex := 7;
      wbNS6: ImageIndex := 8;
      wbMozilla: ImageIndex := 9;
      wbOpera: ImageIndex := 10;
    end;
    ShortCut := MakeShortCut({$IFDEF Linux}Key_F9{$ELSE}VK_F9{$ENDIF}, []);
    OnExecute := actnTestOnExecute;
  end;

  FActionRun_ExecuteDefault := TAction.Create(Self);
  with FActionRun_ExecuteDefault do begin
    ActionList := FActionList;
    Caption := RSExecuteDefaultCaption;
    Hint := RSExecuteDefaultHint;
    ImageIndex := 0;
    OnExecute := actnExecuteDefaultExecute;
  end;

  FActionRun_ExecuteIE := TAction.Create(Self);
  with FActionRun_ExecuteIE do begin
    ActionList := FActionList;
    Caption := RSExecuteIECaption;
    Hint := RSExecuteIEHint;
    ImageIndex := 7;
    ShortCut := MakeShortCut(Ord('E'), [ssCtrl]);
    Enabled := FStandaloneServer.TestForIE;
    OnExecute := actnExecuteIE;
  end;

  FActionRun_ExecuteMozilla := TAction.Create(Self);
  with FActionRun_ExecuteMozilla do begin
    ActionList := FActionList;
    Caption := RSExecuteMozillaCaption;
    Hint := RSExecuteMozillaHint;
    ImageIndex := 9;
    Enabled := FStandaloneServer.TestForMozilla;
    ShortCut := MakeShortCut(Ord('M'), [ssCtrl]);
    OnExecute := actnExecuteMozilla;
  end;

  FActionRun_ExecuteNS6 := TAction.Create(Self);
  with FActionRun_ExecuteNS6 do begin
    ActionList := FActionList;
    Caption := RSExecuteNS6Caption;
    Hint := RSExecuteNS6Hint;
    ImageIndex := 8;
    Enabled := FStandaloneServer.TestForNS6;
    ShortCut := MakeShortCut(Ord('N'), [ssCtrl]);
    OnExecute := actnExecuteNS6;
  end;

  FActionRun_ExecuteOpera := TAction.Create(Self);
  with FActionRun_ExecuteOpera do begin
    ActionList := FActionList;
    Caption := RSExecuteOperaCaption;
    Hint := RSExecuteOperaHint;
    ImageIndex := 10;
    ShortCut := MakeShortCut(Ord('O'), [ssCtrl]);
    Enabled := FStandaloneServer.TestForOpera;
    OnExecute := actnExecuteOpera;
  end;

  // Execute SSL
  FActionRun_ExecuteSSL := TAction.Create(Self);
  with FActionRun_ExecuteSSL do begin
    ActionList := FActionList;
    Caption := RSUseSSLCaption;
    Hint := RSUseSSLHint;
    ImageIndex := 1;
    ShortCut := MakeShortCut({$IFDEF Linux}Key_F9{$ELSE}VK_F9{$ENDIF}, [ssCtrl]);
    OnExecute := actnSetSSL;
    Enabled := GServerController.SSLPort <> 0;
  end;
  // Parameters
  FActionRun_Parameters := TAction.Create(Self);
  with FActionRun_Parameters do begin
    ActionList := FActionList;
    Caption := RSParamCaption;
    Hint := RSParamHint;
    ShortCut := MakeShortCut(Ord('P'), [ssCtrl]);
    ImageIndex := 2;
    OnExecute := actnParametersOnExecute;
  end;
  // About
  FActionHelp_About := TAction.Create(Self);
  with FActionHelp_About do begin
    ActionList := FActionList;
    Caption := RSAboutCaption;
    Hint := RSAboutHint;
    ImageIndex := 6;
    OnExecute := actnAboutOnExecute;
  end;
  // Construct Menu
  LMainMenu := TMainMenu.Create(Self);
  LMainMenu.Images := FActionList.Images;
  Menu := LMainMenu;
  //
  LMenuItemHead := TMenuItem.Create(Self);
  LMainMenu.Items.Add(LMenuItemHead);
  with LMenuItemHead do begin
    Caption := RSFileMenuCaption;
    // Clear Session
    LMenuItem := TMenuItem.Create(Self);
    LMenuItemHead.Add(LMenuItem);
    with LMenuItem do begin
      Action := FActionFile_ClearSessions;
    end;
    // Copy URL to Clipboard
    LMenuItem := TMenuItem.Create(Self);
    LMenuItemHead.Add(LMenuItem);
    with LMenuItem do begin
      Action := FActionFile_CopyURLToClipboard;
    end;
    // Show Debug Information
    LMenuItem := TMenuItem.Create(Self);
    LMenuItemHead.Add(LMenuItem);
    with LMenuItem do begin
      Action := FActionFile_ShowDebugInformation;
    end;
    // Seperator
    LMenuItem := TMenuItem.Create(Self);
    LMenuItemHead.Add(LMenuItem);
    with LMenuItem do begin
      Caption := '-';
    end;
    // Exit
    LMenuItem := TMenuItem.Create(Self);
    LMenuItemHead.Add(LMenuItem);
    with LMenuItem do begin
      Action := FActionFile_Exit;
    end;
  end;
  //
  LMenuItemHead := TMenuItem.Create(Self);
  LMainMenu.Items.Add(LMenuItemHead);
  with LMenuItemHead do begin
    Caption := RSRunMenuCaption;
    // Execute
    LMenuItem := TMenuItem.Create(Self);
    LMenuItemHead.Add(LMenuItem);
    with LMenuItem do begin
      Action := FActionRun_Execute;
    end;
    // Seperator
    LMenuItem := TMenuItem.Create(Self);
    LMenuItemHead.Add(LMenuItem);
    with LMenuItem do begin
      Caption := '-';
    end;
    // Select browser
    LMenuItem := TMenuItem.Create(Self);
    LMenuItemHead.Add(LMenuItem);
    with LMenuItem do begin
      Caption := RSSelectBrowserCaption;
    end;

    // Execute default browser
    LMenuItem1 := TMenuItem.Create(Self);
    LMenuItem.Add(LMenuItem1);
    with LMenuItem1 do begin
      Action := FActionRun_ExecuteDefault;
    end;
    // Execute via IE
    LMenuItem1 := TMenuItem.Create(Self);
    LMenuItem.Add(LMenuItem1);
    with LMenuItem1 do begin
      Action := FActionRun_ExecuteIE;
    end;
    // Execute via Mozilla
    LMenuItem1 := TMenuItem.Create(Self);
    LMenuItem.Add(LMenuItem1);
    with LMenuItem1 do begin
      Action := FActionRun_ExecuteMozilla;
    end;
    // Execute via Netscape 6
    LMenuItem1 := TMenuItem.Create(Self);
    LMenuItem.Add(LMenuItem1);
    with LMenuItem1 do begin
      Action := FActionRun_ExecuteNS6;
    end;
    // Execute via Opera
    LMenuItem1 := TMenuItem.Create(Self);
    LMenuItem.Add(LMenuItem1);
    with LMenuItem1 do begin
      Action := FActionRun_ExecuteOpera;
    end;

    // Seperator
    LMenuItem := TMenuItem.Create(Self);
    LMenuItemHead.Add(LMenuItem);
    with LMenuItem do begin
      Caption := '-';
    end;
    // Execute SSL
    LMenuItem := TMenuItem.Create(Self);
    LMenuItemHead.Add(LMenuItem);
    with LMenuItem do begin
      Action := FActionRun_ExecuteSSL;
    end;
    // Parameters
    LMenuItem := TMenuItem.Create(Self);
    LMenuItemHead.Add(LMenuItem);
    with LMenuItem do begin
      Action := FActionRun_Parameters;
    end;
  end;
  //
  LMenuItemHead := TMenuItem.Create(Self);
  LMainMenu.Items.Add(LMenuItemHead);
  with LMenuItemHead do begin
    Caption := RSHelpCaption;
    //
    LMenuItem := TMenuItem.Create(Self);
    LMenuItemHead.Add(LMenuItem);
    with LMenuItem do begin
      Action := FActionHelp_About;
    end;
  end;
  LPanel := TPanel.Create(Self);
  with LPanel do begin
    Parent := Self;
    Left := 0;
    Top := 41;
    Width := 169;
    Height := 223;
    Align := alLeft;
    TabOrder := 1;
    lablActiveSessions := TLabel.Create(Self);
    with lablActiveSessions do begin
      Parent := LPanel;
      AutoSize := True;
      Left := 8;
      Top := 10;
    end;
    SetActiveSessions;
  end;
  FStatusBar := TStatusBar.Create(Self);
  with FStatusBar do begin
    Parent := Self;
  end;
  // Construct Toolbar
  LToolbar := TToolbar.Create(Self);
  with LToolbar do begin
    Name := RSToolBarCaption;
    Parent := Self;
    Images := FActionList.Images;
    ShowHint := True;
    InitializeToolbar(LToolBar);
  end;
  //
  FStandaloneServer.OnNewSession := OnCreateSession;
  FStandaloneServer.OnCloseSession := OnDestroySession;
end;

procedure TformIWMain.actnClearSessionsOnExecute(ASender: TObject);
begin
  FStandaloneServer.ClearSessions;
end;

procedure TformIWMain.SetActiveSessions;
begin
  lablActiveSessions.Caption := RSLogActiveSessions + IntToStr(FStandaloneServer.ActiveSessions);
end;

procedure TformIWMain.actnExitOnExecute(ASender: TObject);
begin
  Close;
end;

procedure TformIWMain.actnAboutOnExecute(ASender: TObject);
var
  LLabel: TLabel;
  LVerLabel: TLabel;
  LImage: TImage;
  LForm: TForm;
  LStream: TStream;
begin
  LForm := TForm.Create(Application); try
    with LForm do begin
      Position := poScreenCenter;
      {$IFDEF Linux}
      BorderStyle := fbsNone;
      {$ELSE}
      BorderStyle := bsNone;
      {$ENDIF}
      VertScrollBar.Visible := false;
      HorzScrollBar.Visible := false;
      Caption := 'About IntraWeb';
    end;
    LImage := TImage.Create(LForm);
    with LImage do begin
      Parent := LForm;
      Name := 'LImage';
      Left := 0;
      Top := 0;
      AutoSize := True;
      LStream := TResourceStream.Create(GetModuleHandle(nil), 'IW_SPLASH_ABOUT', RT_RCDATA); try
        {$IFDEF Linux}
        LImage.Picture.LoadFromStream(LStream);
        {$ELSE}
        LImage.Picture.Graphic := TJPEGImage.Create;
        LImage.Picture.Graphic.LoadFromStream(LStream);
        {$ENDIF}
      finally FreeAndNil(LStream); end;
      Align := alClient;
      OnClick := AboutOnClick;
    end;

    LLabel := TLabel.Create(LForm);
    with LLabel do begin
      Parent := LForm;
      AutoSize := True;
      Name := 'LLabel';
      Left := 145;
      Top := 135;
      Caption := 'Version ' + GVersion;
      Transparent := True;
      OnClick := AboutOnClick;
    end;
    LVerLabel := TLabel.Create(LForm);
    with LVerLabel do begin
      Parent := LForm;
      AutoSize := true;
      Name := 'LVerLable';
      Font.Size := 90;
      Font.Color := $00D47B31;
      Font.Style := [fsBold];
      Font.Name := 'Times New Roman';
      Caption := Copy(GVersion, 1, 1);
      OnClick := AboutOnClick;
      Left := 20;
      Top := 100;
      Transparent := True;
    end;
    LForm.Width := LImage.Width;
    LForm.Height := LImage.Height;

    LForm.ShowModal;
  finally FreeAndNil(LForm) end;
end;

procedure TformIWMain.actnParametersOnExecute(ASender: TObject);
var
  s: string;
begin
  s := FStandaloneServer.Params;
  if InputQuery(RSUseParamQueryTitle, RSUseParamQueryPrompt, s) then begin
    FStandaloneServer.Params := s;
  end;
end;

procedure TformIWMain.actnCopyURLToClipboardOnExecute(ASender: TObject);
begin
  FStandaloneServer.CopyStartURLToClipboard;
end;

procedure TFormIWMain.AboutOnClick(ASender: TObject);
begin
  TForm(TImage(ASender).Owner).ModalResult := mrOk;
end;

procedure TFormIWMain.Log(const AMsg: string);
begin
  FMemoLog.Lines.Add(AMsg);
end;

procedure TFormIWMain.OnCreateSession(ASender: TObject);
begin
  TUpdateSessions.UpdateSessions;
end;

procedure TFormIWMain.OnDestroySession(ASender: TObject);
begin
  TUpdateSessions.UpdateSessions;
end;

destructor TFormIWMain.Destroy;
begin
  GSessions.OnCreateSession := nil;
  GSessions.OnDestroySession := nil;
  inherited;
end;

procedure TFormIWMain.InitializeToolbar(AToolBar: TToolBar);
begin
{$IFNDEF Linux}
  with TToolButton.Create(AToolBar.Owner) do begin
    Action := formIWMain.FActionHelp_About;
    Parent := AToolBar;
  end;
  with TToolButton.Create(AToolBar.Owner) do begin
    Parent := AToolBar;
    Style := tbsSeparator;
    Width := 4;
  end;
  with TToolButton.Create(AToolBar.Owner) do begin
    Action := formIWMain.FActionFile_ShowDebugInformation;
    Parent := AToolBar;
  end;
  with TToolButton.Create(AToolBar.Owner) do begin
    Action := formIWMain.FActionRun_Parameters;
    Parent := AToolBar;
  end;
  with TToolButton.Create(AToolBar.Owner) do begin
    Action := formIWMain.FActionFile_ClearSessions;
    Parent := AToolBar;
  end;
  with TToolButton.Create(AToolBar.Owner) do begin
    Parent := AToolBar;
    Style := tbsSeparator;
    Width := 4;
  end;
  with TToolButton.Create(AToolBar.Owner) do begin
    Action := formIWMain.FActionFile_CopyURLToClipboard;
    Parent := AToolBar;
  end;
  with TToolButton.Create(AToolBar.Owner) do begin
    Action := formIWMain.FActionRun_ExecuteSSL;
    Parent := AToolBar;
  end;
  with TToolButton.Create(AToolBar.Owner) do begin
    Action := formIWMain.FActionRun_Execute;
    Parent := AToolBar;
  end;
{$ENDIF}
{$IFDEF Linux}
  with TToolButton.Create(AToolBar.Owner) do begin
    Action := formIWMain.FActionRun_Execute;
    Parent := AToolBar;
  end;
  with TToolButton.Create(AToolBar.Owner) do begin
    Action := formIWMain.FActionRun_ExecuteSSL;
    Parent := AToolBar;
  end;
  with TToolButton.Create(AToolBar.Owner) do begin
    Action := formIWMain.FActionFile_CopyURLToClipboard;
    Parent := AToolBar;
  end;
  with TToolButton.Create(AToolBar.Owner) do begin
    Parent := AToolBar;
    Style := tbsSeparator;
    Width := 4;
  end;
  with TToolButton.Create(AToolBar.Owner) do begin
    Action := formIWMain.FActionFile_ClearSessions;
    Parent := AToolBar;
  end;
  with TToolButton.Create(AToolBar.Owner) do begin
    Action := formIWMain.FActionRun_Parameters;
    Parent := AToolBar;
  end;
  with TToolButton.Create(AToolBar.Owner) do begin
    Action := formIWMain.FActionFile_ShowDebugInformation;
    Parent := AToolBar;
  end;
  with TToolButton.Create(AToolBar.Owner) do begin
    Parent := AToolBar;
    Style := tbsSeparator;
    Width := 4;
  end;
  with TToolButton.Create(AToolBar.Owner) do begin
    Action := formIWMain.FActionHelp_About;
    Parent := AToolBar;
  end;
{$ENDIF}
end;

procedure TFormIWMain.actnShowDebugInformationOnExecute(ASender: TObject);
begin
  FStandaloneServer.DebugLog := not FStandaloneServer.DebugLog;
end;

procedure TFormIWMain.actnExecuteDefaultExecute(ASender: TObject);
begin
  FStandaloneServer.RunIn := wbDefault;
  UpdateBrowserSelectionAction;
end;

procedure TFormIWMain.actnExecuteIE(ASender: TObject);
begin
  FStandaloneServer.RunIn := wbIE;
  UpdateBrowserSelectionAction;
end;

procedure TFormIWMain.actnExecuteMozilla(ASender: TObject);
begin
  FStandaloneServer.RunIn := wbMozilla;
  UpdateBrowserSelectionAction;
end;

procedure TFormIWMain.actnExecuteNS6(ASender: TObject);
begin
  FStandaloneServer.RunIn := wbNS6;
  UpdateBrowserSelectionAction;
end;

procedure TFormIWMain.actnExecuteOpera(ASender: TObject);
begin
  FStandaloneServer.RunIn := wbOpera;
  UpdateBrowserSelectionAction;
end;

procedure TFormIWMain.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  FActionFile_ShowDebugInformation.Checked := FStandaloneServer.DebugLog;
  FActionRun_ExecuteSSL.Checked := FStandaloneServer.RunSSL;
end;

procedure TFormIWMain.actnTestOnExecute(ASender: TObject);
begin
  FStandaloneServer.Run;
end;

procedure TFormIWMain.OnDebugLog(ASender: TObject; ALog: String);
begin
  Log(ALog);
end;

{ TUpdateSessions }

class procedure TUpdateSessions.UpdateSessions;
begin
  with Create(formIWMain.SetActiveSessions) do
    Notify;
end;

procedure TFormIWMain.UpdateBrowserSelectionAction;
Var
  LSelected: TAction;
begin
  LSelected := FActionRun_ExecuteDefault;
  FActionRun_ExecuteDefault.Checked := false;
  FActionRun_ExecuteIE.Checked := false;
  FActionRun_ExecuteMozilla.Checked := false;
  FActionRun_ExecuteNS6.Checked := false;
  FActionRun_ExecuteOpera.Checked := false;
  case FStandaloneServer.RunIn of
    wbDefault: LSelected := FActionRun_ExecuteDefault;
    wbIE: LSelected := FActionRun_ExecuteIE;
    wbNS6: LSelected := FActionRun_ExecuteNS6;
    wbMozilla: LSelected := FActionRun_ExecuteMozilla;
    wbOpera: LSelected := FActionRun_ExecuteOpera;
  end;
  LSelected.Checked := true;
  FActionRun_Execute.ImageIndex := LSelected.ImageIndex;
end;

procedure TFormIWMain.actnSetSSL(ASender: TObject);
begin
  FStandaloneServer.RunSSL := not FActionRun_ExecuteSSL.Checked;
end;

end.
