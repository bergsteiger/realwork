{*******************************************************}
{                                                       }
{       Borland Delphi Test Server                      }
{                                                       }
{   Copyright (c) 2001 Borland Software Corporation     }
{                                                       }
{*******************************************************}
unit SvrPropDlg;

interface

uses
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QComCtrls, SvrLogFrame, SvrLogColSettingsFrame;

type
  TDlgProperties = class(TForm)
    OkButton: TButton;
    CancelButton: TButton;
    PageControl1: TPageControl;
    TabConnection: TTabSheet;
    TabLog: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cbPort: TEdit;
    GroupBox2: TGroupBox;
    LogColSettingsFrame: TLogColSettingsFrame;
    GroupBox6: TGroupBox;
    edLogMax: TEdit;
    Label4: TLabel;
    edLogDelete: TEdit;
    Label5: TLabel;
    cbActiveAtStartup: TCheckBox;
    edDefault: TEdit;
    edPath: TEdit;
    Button1: TButton;
    Label6: TLabel;
    cbUDPPort: TEdit;
    Label7: TLabel;
    edBrowser: TEdit;
    procedure NumericKeyPress(Sender: TObject; var Key: AnsiChar);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function GetServerPath: string;
    function GetServerPort: Integer;
    procedure SetServerPath(const Value: string);
    procedure SetServerPort(const Value: Integer);
    function GetDefaultURL: string;
    procedure SetDefaultURL(const Value: string);
    function GetLogMax: Integer;
    procedure SetLogMax(const Value: Integer);
    function GetLogDelete: Integer;
    procedure SetLogDelete(const Value: Integer);
    function GetActiveAtStartup: Boolean;
    procedure SetActiveAtStartup(const Value: Boolean);
    procedure SetLogFrame(const Value: TLogFrame);
    function GetUDPPort: Integer;
    procedure SetUDPPort(Value: Integer);
    function GetBrowser: string;
    procedure SetBrowser(const Value: string);
  public
    procedure UpdateColumns;
    property ServerSearchPath: string read GetServerPath write SetServerPath;
    property ServerPort: Integer read GetServerPort write SetServerPort;
    property DefaultURL: string read GetDefaultURL write SetDefaultURL;
    property UDPPort: Integer read GetUDPPort write SetUDPPort;
    property LogMax: Integer read GetLogMax write SetLogMax;
    property LogDelete: Integer read GetLogDelete write SetLogDelete;
    property ActiveAtStartup: Boolean read GetActiveAtStartup write SetActiveAtStartup;
    property LogFrame: TLogFrame write SetLogFrame;
    property Browser: string read GetBrowser write SetBrowser;
  end;

var
  DlgProperties: TDlgProperties;

implementation

{$R *.xfm}

{ TDlgProperties }

function TDlgProperties.GetDefaultURL: string;
begin
  Result := edDefault.Text;
end;

function TDlgProperties.GetServerPath: string;
begin
  Result := edPath.Text;
end;

function TDlgProperties.GetServerPort: Integer;
begin
  Result := StrToInt(cbPort.Text);
end;

procedure TDlgProperties.SetDefaultURL(const Value: string);
begin
  edDefault.Text := Value;
end;

procedure TDlgProperties.SetServerPath(const Value: string);
begin
  edPath.Text := Value;
end;

procedure TDlgProperties.SetServerPort(const Value: Integer);
begin
  cbPort.Text := IntToStr(Value);
end;

procedure TDlgProperties.NumericKeyPress(Sender: TObject; var Key: AnsiChar);
begin
  if Key in [#32..#255] then
    if not (Key in ['0'..'9']) then
    begin
      Beep;
      Key := #0;
    end;
end;

function TDlgProperties.GetLogMax: Integer;
begin
  Result := StrToInt(edLogMax.Text);
end;

procedure TDlgProperties.SetLogMax(const Value: Integer);
begin
  edLogMax.Text := IntToStr(Value);
end;

function TDlgProperties.GetActiveAtStartup: Boolean;
begin
  Result := cbActiveAtStartup.Checked;
end;

procedure TDlgProperties.SetActiveAtStartup(const Value: Boolean);
begin
  cbActiveAtStartup.Checked := Value;
end;

procedure TDlgProperties.SetLogFrame(const Value: TLogFrame);
begin
  LogColSettingsFrame.LogFrame := Value;
end;

procedure TDlgProperties.UpdateColumns;
begin
  LogColSettingsFrame.UpdateColumns;
end;

function TDlgProperties.GetLogDelete: Integer;
begin
  Result := StrToInt(edLogDelete.Text);
end;

procedure TDlgProperties.SetLogDelete(const Value: Integer);
begin
  edLogDelete.Text := IntToStr(Value);
end;

procedure TDlgProperties.Button1Click(Sender: TObject);
begin
{$IFDEF MSWINDOWS}
  Application.InvokeHelp;
{$ENDIF}
end;

function TDlgProperties.GetUDPPort: Integer;
begin
  Result := StrToInt(cbUDPPort.Text);
end;

procedure TDlgProperties.SetUDPPort(Value: Integer);
begin
  cbUDPPort.Text := IntToStr(Value);
end;

function TDlgProperties.GetBrowser: string;
begin
  Result := edBrowser.Text;
end;

procedure TDlgProperties.SetBrowser(const Value: string);
begin
  edBrowser.Text := Value;
end;

procedure TDlgProperties.FormCreate(Sender: TObject);
begin
{$IFDEF MSWINDOWS}
  // Can choose browser under Linux.  Under windows we use ShellExecute to
  // launch default browser.
  edBrowser.Visible := False;
  Label7.Visible := False;
{$ENDIF}
  HelpType := htContext;
  HelpContext:= 4310;
end;

end.
