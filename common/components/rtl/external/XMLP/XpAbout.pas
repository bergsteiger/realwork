{*********************************************************}
{* FlashFiler: XPABOUT.PAS 2.50                          *}
{* Copyright (c) TurboPower Software Co 1996-2001        *}
{* All rights reserved.                                  *}
{*********************************************************}
{* XMLPartner: About box                                 *}
{*********************************************************}

{$I XpDefine.inc}

unit XpAbout;

interface

uses
{$IFDEF WIN32}
  Windows,
  forms,
  Messages,
  Graphics,
  Controls,
  Dialogs,
  StdCtrls,
  ExtCtrls,
{$ENDIF}
{$IFDEF LINUX}
  QStdCtrls,
  QExtCtrls,
  QForms,
  QGraphics,
  QControls,
{$ENDIF}
  Classes,
  SysUtils;

type
  TXpAboutBox = class(TForm)
    Bevel2: TBevel;
    Panel1: TPanel;
    Image1: TImage;
    ProgramName: TLabel;
    VersionNumber: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblTurboLink: TLabel;
    lblNewsGeneral: TLabel;
    Label7: TLabel;
    lblNewsSpecific: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    OKButton: TButton;
    Bevel3: TBevel;
    Label13: TLabel;
    Label14: TLabel;
    lblFreeUpdateCenter: TLabel;
    lblTurboPowerLive: TLabel;
    procedure OKButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure lblTurboLinkClick(Sender: TObject);
    procedure lblFreeUpdateCenterClick(Sender: TObject);
    procedure lblTurboPowerLiveClick(Sender: TObject);
    procedure lblTurboLinkMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lblNewsGeneralClick(Sender: TObject);
    procedure lblNewsSpecificClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    IsServer : boolean;
  end;

var
  XpAboutBox: TXpAboutBox;

implementation

{$R *.dfm}

uses
{$IFDEF WIN32}
  ShellAPI,
{$ENDIF}
{$IFDEF LINUX}
{$ENDIF}
   XpBase;

{$IFDEF WIN32}
resourcestring
  cBrowserError = 'Unable to start web browser. Make sure you have it properly setup on your system.';
{$ENDIF}

{$IFDEF LINUX}
{$ENDIF}

{===WWW Shell Routines===============================================}
procedure ShellToWWW;
  {-Shell out to TurboPower WWW site}
resourcestring
  EX_Error = 'Unable to start web browser. Make sure you have it properly setup on your system.';
begin
{$IFDEF WIN32}
  if ShellExecute(0, 'open', 'http://www.turbopower.com', '', '', SW_SHOWNORMAL) <= 32 then
    ShowMessage(EX_Error);
{$ENDIF}

{$IFDEF LINUX}
{$ENDIF}
end;
{====================================================================}
procedure TXpAboutBox.OKButtonClick(Sender : TObject);
begin
  Close;
end;

procedure TXpAboutBox.FormActivate(Sender: TObject);
begin
  ProgramName.Caption := XpProductName;
  VersionNumber.Caption := Format('Version %5.4f %s',
      [XpVersionNumber / 10000.0,
       XPReleaseString]);
end;

procedure TXpAboutBox.lblTurboLinkClick(Sender: TObject);
begin
  ShellToWWW;
end;

procedure TXpAboutBox.lblFreeUpdateCenterClick(Sender : TObject);
begin
{$IFDEF WIN32}
  if ShellExecute(0, 'open', 'http://www.turbopower.com/updates', '', '', SW_SHOWNORMAL) <= 32 then
    ShowMessage(cBrowserError);
{$ENDIF}
{$IFDEF LINUX}
{$ENDIF}
end;

procedure TXpAboutBox.lblTurboPowerLiveClick(Sender : TObject);
begin
{$IFDEF WIN32}
  if ShellExecute(0, 'open', 'http://www.turbopower.com/tpslive', '', '', SW_SHOWNORMAL) <= 32 then
    ShowMessage(cBrowserError);
{$ENDIF}
{$IFDEF LINUX}
{$ENDIF}
end;

procedure TXpAboutBox.lblTurboLinkMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
{$IFDEF WIN32}
  TLabel(Sender).Font.Style := [fsUnderline];
{$ENDIF}
{$IFDEF LINUX}
{$ENDIF}
end;

procedure TXpAboutBox.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  lblTurboLink.Font.Style := [];
  lblFreeUpdateCenter.Font.Style := [];
  lblTurboPowerLive.Font.Style := [];
  lblNewsGeneral.Font.Style := [];
  lblNewsSpecific.Font.Style := [];
end;

procedure TXpAboutBox.lblNewsGeneralClick(Sender: TObject);
begin
{$IFDEF WIN32}
  if ShellExecute(0, 'open', 'news://news.turbopower.com', '', '', SW_SHOWNORMAL) <= 32 then
    ShowMessage(cBrowserError);
{$ENDIF}
{$IFDEF LINUX}
{$ENDIF}
end;

procedure TXpAboutBox.lblNewsSpecificClick(Sender: TObject);
begin
{$IFDEF WIN32}
  if ShellExecute(0, 'open',
                  'news://news.turbopower.com/turbopower.public.support.xmlpartner',
                  '', '', SW_SHOWNORMAL) <= 32 then
    ShowMessage(cBrowserError);
{$ENDIF}
{$IFDEF LINUX}
{$ENDIF}
end;

end.
