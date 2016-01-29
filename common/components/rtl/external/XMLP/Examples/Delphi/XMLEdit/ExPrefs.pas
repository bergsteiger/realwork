{*********************************************************}
{* XMLPartner: ExPrefs.PAS 2.56                          *}
{* Copyright (c) TurboPower Software Co 2002             *}
{* All rights reserved.                                  *}
{*********************************************************}
{* XMLPartner: XML Editor Preferences Window             *}
{*********************************************************}
unit ExPrefs;

interface

uses
{$IFDEF WIN32}
  Windows,
  Messages,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ComCtrls,
  StdCtrls,
{$ENDIF}
{$IFDEF LINUX}
  QForms,
  QStdCtrls,
  QComCtrls,
  QControls,
{$ENDIF}
  SysUtils,
  Classes,
  INIFiles;

type
  TPrefsForm = class(TForm)
    OkBtn: TButton;
    CancelBtn: TButton;
    PageControl1: TPageControl;
    GeneralTab: TTabSheet;
    NormalizeCheckBox: TCheckBox;
    FormattedCheckBox: TCheckBox;
    btnXMLDefault: TButton;
    btnXSLDefault: TButton;
    BackupCheckBox: TCheckBox;
    TextWinCheckBox: TCheckBox;
    AppWinCheckBox: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
    procedure btnXMLDefaultClick(Sender: TObject);
    procedure btnXSLDefaultClick(Sender: TObject);
  private
    { Private declarations }
    FINIFile : TINIFile;
  public
    { Public declarations }
    property INIFile : TINIFile read FINIFile write FINIFile;
  end;

var
  PrefsForm: TPrefsForm;

implementation

{$IFDEF WIN32}
uses
  registry;
{$ENDIF}

{$R *.dfm}

const
  csAppSection = 'Application';
  csPrefSection = 'Preferences';
  csFormatted = 'Formatted';
  csNormalize = 'Normalize';
  csSaveBackup = 'SaveBackup';
  csSaveTextWinPos = 'SaveTextWinPos';
  csSaveAppWinPos = 'SaveAppWinPos';

procedure TPrefsForm.FormShow(Sender: TObject);
begin
{$IFDEF LINUX}
  btnXMLDefault.Visible := false;
  btnXSLDefault.Visible := false;
{$ENDIF}
  if assigned(FINIFile) then
    with FINIFile do begin
      FormattedCheckBox.Checked := ReadBool(csPrefSection, csFormatted, True);
      NormalizeCheckBox.Checked := ReadBool(csPrefSection, csNormalize, True);
      BackupCheckBox.Checked    := ReadBool(csPrefSection, csSaveBackup, True);
      TextWinCheckBox.Checked   := ReadBool(csPrefSection, csSaveTextWinPos, True);
      AppWinCheckBox.Checked    := ReadBool(csPrefSection, csSaveAppWinPos, True);
    end;
end;

procedure TPrefsForm.OkBtnClick(Sender: TObject);
begin
  if assigned(FINIFile) then
    with FINIFile do begin
      WriteBool(csPrefSection, csFormatted, FormattedCheckBox.Checked);
      WriteBool(csPrefSection, csNormalize, NormalizeCheckBox.Checked);
      WriteBool(csPrefSection, csSaveBackup, BackupCheckBox.Checked);
      WriteBool(csPrefSection, csSaveTextWinPos, TextWinCheckBox.Checked);
      WriteBool(csPrefSection, csSaveAppWinPos, AppWinCheckBox.Checked);
    end;
end;

procedure TPrefsForm.btnXMLDefaultClick(Sender: TObject);
begin
{$IFDEF WIN32}
  with TRegistry.Create do
    try
      RootKey := HKEY_CLASSES_ROOT;
      OpenKey('\.xml', true);
      WriteString('', 'xmlfile');
      WriteString('Content Type', 'text/plain');
      OpenKey('\xmlfile', true);
      WriteString('', 'XML Document');
      OpenKey('\xmlfile\DefaultIcon', true);
      WriteString('', Application.EXEName);
      OpenKey('\xmlfile\shell\edit\command', true);
      WriteString('', Application.EXEName + ' "%1"');
      OpenKey('\xmlfile\shell\open\command', true);
      WriteString('', Application.EXEName + ' "%1"');
    finally
      Free;
    end;
{$ENDIF}
end;

procedure TPrefsForm.btnXSLDefaultClick(Sender: TObject);
begin
{$IFDEF WIN32}
  with TRegistry.Create do
    try
      RootKey := HKEY_CLASSES_ROOT;
      OpenKey('\.xsl', true);
      WriteString('', 'xslfile');
      WriteString('Content Type', 'text/plain');
      OpenKey('\xslfile', true);
      WriteString('', 'XML Document');
      OpenKey('\xslfile\DefaultIcon', true);
      WriteString('', Application.EXEName);
      OpenKey('\xslfile\shell\edit\command', true);
      WriteString('', Application.EXEName + ' "%1"');
      OpenKey('\xslfile\shell\open\command', true);
      WriteString('', Application.EXEName + ' "%1"');
    finally
      Free;
    end;
{$ENDIF}
end;

end.
