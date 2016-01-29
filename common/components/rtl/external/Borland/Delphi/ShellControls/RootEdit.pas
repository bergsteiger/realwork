{*********************************************************}
{                                                         }
{       Borland Delphi Visual Component Library           }
{                                                         }
{       Copyright (c) 1995, 2001-2002 Borland Corporation }
{                                                         }
{*********************************************************}
unit RootEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DesignIntf, DesignEditors, StdCtrls, ShellCtrls;

type
  TRootPathEditDlg = class(TForm)
    Button1: TButton;
    Button2: TButton;
    rbUseFolder: TRadioButton;
    GroupBox1: TGroupBox;
    cbFolderType: TComboBox;
    GroupBox2: TGroupBox;
    ePath: TEdit;
    rbUsePath: TRadioButton;
    OpenDialog1: TOpenDialog;
    btnBrowse: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure rbUseFolderClick(Sender: TObject);
    procedure rbUsePathClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
  private
    procedure UpdateState;
  public
  end;

  TRootProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  TRootEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): String; override;
    function GetVerbCount: Integer; override;
  end;

implementation

{$R *.dfm}

uses TypInfo, FileCtrl;

resourcestring
  SPickRootPath = 'Please select a root path';
  SEditRoot = 'E&dit Root';

const
  NTFolders = [rfCommonDesktopDirectory, rfCommonPrograms, rfCommonStartMenu,
               rfCommonStartup];

function PathIsCSIDL(Value: string): Boolean;
begin
  Result := GetEnumValue(TypeInfo(TRootFolder), Value) >= 0;
end;

function RootPathEditor(Value : string): string;
begin
  Result := Value;
  with TRootPathEditDlg.Create(Application) do
  try
    rbUseFolder.Checked := PathIsCSIDL(Result);
    rbUsePath.Checked := not rbUseFolder.Checked;
    if not PathIsCSIDL(Result) then
    begin
      cbFolderType.ItemIndex := 0;
      ePath.Text := Result;
    end
    else
      cbFolderType.ItemIndex := cbFolderType.Items.IndexOf(Result);

    UpdateState;
    ShowModal;
    if ModalResult = mrOK then
    begin
      if rbUsePath.Checked then
        Result := ePath.Text
      else
        Result := cbFolderType.Items[cbFolderType.ItemIndex];
    end;
  finally
    Free;
  end;
end;

procedure TRootProperty.Edit;
begin
  SetStrValue(RootPathEditor(GetStrValue));
end;

function TRootProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

procedure TRootPathEditDlg.FormCreate(Sender: TObject);
var
  FT: TRootFolder;
begin
  for FT := Low(TRootFolder) to High(TRootFolder) do
    if not ((Win32Platform = VER_PLATFORM_WIN32_WINDOWS) and (FT in NTFolders)) then
      cbFolderType.Items.Add(GetEnumName(TypeInfo(TRootFolder), Ord(FT)));
  cbFolderType.ItemIndex := 0;
end;

procedure TRootPathEditDlg.UpdateState;
begin
  cbFolderType.Enabled := rbUseFolder.Checked;
  ePath.Enabled := not rbUseFolder.Checked;
  btnBrowse.Enabled := ePath.Enabled;
end;

procedure TRootPathEditDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TRootPathEditDlg.Button2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
  Close;
end;

procedure TRootPathEditDlg.rbUseFolderClick(Sender: TObject);
begin
  rbUsePath.Checked := not rbUseFolder.Checked;
  UpdateState;
end;

procedure TRootPathEditDlg.rbUsePathClick(Sender: TObject);
begin
  rbUseFolder.Checked := not rbUsePath.Checked;
  UpdateState;
end;

procedure TRootPathEditDlg.Button1Click(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TRootPathEditDlg.btnBrowseClick(Sender: TObject);
var
  Path : widestring;
  Dir : string;
begin
  Path := ePath.Text;
  Dir := ePath.Text;
  if SelectDirectory( SPickRootPath, '', Dir ) then
    ePath.Text := Dir;
end;

{ TRootEditor }

procedure TRootEditor.ExecuteVerb(Index: Integer);

  procedure EditRoot;
  const
    SRoot = 'root';
  var
    Path : string;
  begin
    Path := RootPathEditor(GetPropValue(Component, SRoot, True));
    SetPropValue(Component, SRoot, Path);
    Designer.Modified;
  end;

begin

  case Index of
  0 : EditRoot;
  end;
end;

function TRootEditor.GetVerb(Index: Integer): String;
begin
  case Index of
  0 : Result := SEditRoot;
  end;
end;

function TRootEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

end.
