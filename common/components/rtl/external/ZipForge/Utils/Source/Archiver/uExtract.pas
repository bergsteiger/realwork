{$I VER.INC}

//------------------------------------------------------------------------------
//Procedures for OUT-Archive operations
//------------------------------------------------------------------------------

unit uExtract;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls, ShellCtrls, FileCtrl
  {$IFDEF ZF}
   ,ZipForge
  {$ENDIF}
  {$IFDEF ZF_int}
   ,FlexCompress
  {$ENDIF}
  {$IFDEF FC}
   ,FlexCompress
  {$ENDIF}
  ;

type
  TfrmExtract = class(TForm)
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    rgOptions: TRadioGroup;
    Label1: TLabel;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    procedure btnOKClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExtract: TfrmExtract;

implementation

uses arch1, uProgress;
{$R *.dfm}

//------------------------------------------------------------------------------
// Eftract files with some options,e.g. Overwrite modes
//------------------------------------------------------------------------------
procedure TfrmExtract.btnOKClick(Sender: TObject);
var i:integer;
begin
 Archiver.BaseDir := DirectoryListBox1.Directory;
 Archiver.FileName := ArcName;
 case rgOptions.ItemIndex of //Select overwrite modes
  0: Archiver.Options.OverwriteMode := omAlways;  //Rewrite
  1: Archiver.Options.OverwriteMode := omIfNewer; //Update
  2: Archiver.Options.OverwriteMode := omPrompt;
  3: Archiver.Options.OverwriteMode := omNever;
 end;
 try
  Archiver.OpenArchive(fmOpenRead+fmShareDenyWrite);
 except
  MessageDlg('Can''t open archive', mtError, [mbOk], 0)
 end;
 Archiver.FileMasks.Clear;
 //Add extracted items
 for i:=0 to (MainForm.FileListBox1.Items.Count-1) do
  if MainForm.FileListBox1.Selected[i] then
   Archiver.FileMasks.Add(MainForm.FileListBox1.Items.Strings[i]);
 frmProgress.Caption := 'Extracting files...';
 try
  Archiver.ExtractFiles;
 except
  Archiver.ExtractCorruptedFiles:=true; //try to extract corrupted archive
  Archiver.ExtractFiles;
 end;
 try
  Archiver.CloseArchive;
 except
  MessageDlg('Can''t close archive', mtError, [mbOk], 0)
 end;
end; // TfrmExtract.btnOKClick

//------------------------------------------------------------------------------
// Return Focus to the frmProgress if it's active
//------------------------------------------------------------------------------
procedure TfrmExtract.FormActivate(Sender: TObject);
begin
 if frmProgress.Visible then frmProgress.SetFocus;
end; // TfrmExtract.FormActivate

end.
