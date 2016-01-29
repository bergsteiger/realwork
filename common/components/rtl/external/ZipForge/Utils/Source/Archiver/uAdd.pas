{$I VER.INC}

//------------------------------------------------------------------------------
//Procedures for TO-Archive operations
//------------------------------------------------------------------------------

unit uAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls, Menus
  {$IFDEF ZF}
   ,ZipForge
  {$ENDIF}
  {$IFDEF ZF_int}
   //,FlexCompress
  {$ENDIF}
  {$IFDEF FC}
   ,FlexCompress
  {$ENDIF}
  ;
type
  TfrmAdd = class(TForm)
    PageControl1: TPageControl;
    General: TTabSheet;
    Comment: TTabSheet;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    cbArcName: TComboBox;
    btnBrowse: TButton;
    Label1: TLabel;
    rgComprAlg: TRadioGroup;
    cbComprLevel: TComboBox;
    Label2: TLabel;
    rgSpanMode: TRadioGroup;
    cbSpan: TCheckBox;
    gbArcOptions: TGroupBox;
    cbDelete: TCheckBox;
    cbSFX: TCheckBox;
    cbTestArc: TCheckBox;
    Label4: TLabel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Pass: TEdit;
    cbEncrypt: TComboBox;
    Label5: TLabel;
    SaveDialog1: TSaveDialog;
    Label6: TLabel;
    Pass2: TEdit;
    cbZip64: TComboBox;
    Label7: TLabel;
    reComment: TMemo;
    cbVolumeSize: TComboBox;
    Label8: TLabel;
    edCustomSize: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    procedure btnOKClick(Sender: TObject);
    procedure cbSpanClick(Sender: TObject);
    procedure PassChange(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbVolumeSizeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAdd: TfrmAdd;
const
  StubName='Stub.exe'; // SFXStub.exe - visual stub
                          // Stub.exe - console stub

implementation

{$R *.dfm}
uses arch1, uProgress;

//------------------------------------------------------------------------------
// Add files to archive with some options,e.g. SFX, spanning, compression level, etc.
//------------------------------------------------------------------------------
procedure TfrmAdd.btnOKClick(Sender: TObject);
var
 i:integer;
begin
  Archiver.FileMasks.Clear;
  if cbArcName.Text <> '' then  //if filename is empty
   Archiver.FileName := cbArcName.Text
  else
   begin
    MessageDlg('Specify the filename of archive', mtWarning, [mbOk], 0);
    cbArcName.SetFocus; //return focus
   end;
  Archiver.BaseDir := CurrentDir;

  if cbSFX.Checked and cbSpan.Checked // SFX + Spanning
   then
    Archiver.SFXStub := ExtractFilePath(Application.ExeName)+StubName;

  if (cbSpan.Checked) and not NewArc then //Spanning options
   begin
    Archiver.SpanningOptions.AdvancedNaming := false;
    case rgSpanMode.ItemIndex of
     0:Archiver.SpanningMode := smSplitting; //Splitting
     1:Archiver.SpanningMode := smSpanning;  //Spanning
    end;

     case cbVolumeSize.ItemIndex of //size of parts
      0:Archiver.SpanningOptions.VolumeSize := vsAutoDetect;
      1:Archiver.SpanningOptions.VolumeSize := vs1_44MB;
      2:Archiver.SpanningOptions.VolumeSize := vs100MB;
      3:Archiver.SpanningOptions.VolumeSize := vs200MB;
      4:Archiver.SpanningOptions.VolumeSize := vs250MB;
      5:Archiver.SpanningOptions.VolumeSize := vs600MB;
      6:Archiver.SpanningOptions.VolumeSize := vs650MB;
      7:Archiver.SpanningOptions.VolumeSize := vs700MB;
      8:Archiver.SpanningOptions.VolumeSize := vsCustom;
     end;
    if Archiver.SpanningOptions.VolumeSize = vsCustom then //custom size
     Archiver.SpanningOptions.CustomVolumeSize := strtoint(edCustomSize.Text)*1024;
   end;

{$IFDEF FC}
  case rgComprAlg.ItemIndex of  //Compression algorithms
   0:Archiver.CompressionAlgorithm := caBZIP;
   1:Archiver.CompressionAlgorithm := caPPM;
   2:Archiver.CompressionAlgorithm := caZLIB;
  end;

  if cbEncrypt.Enabled then //want to encrypt ?
   begin
    Archiver.Password := Pass2.Text;
    case cbEncrypt.ItemIndex of //Encryption algorithms
     0:Archiver.CryptoAlgorithm := caBlowfish;
     1:Archiver.CryptoAlgorithm := caDES_Single;
     2:Archiver.CryptoAlgorithm := caDES_Triple;
     3:Archiver.CryptoAlgorithm := caRijndael_128;
     4:Archiver.CryptoAlgorithm := caRijndael_256;
     5:Archiver.CryptoAlgorithm := caSquare;
     6:Archiver.CryptoAlgorithm := caTwofish_128;
     7:Archiver.CryptoAlgorithm := caTwofish_256;
    end;
   end;
{$ENDIF}

  case cbComprLevel.ItemIndex of //Choose Compression level
   0:Archiver.CompressionLevel := clNone;
   1:Archiver.CompressionLevel := clFastest;
   2:Archiver.CompressionLevel := clNormal;
   3:Archiver.CompressionLevel := clMax;
  end;

{$IFDEF ZF}
  if (Pass.Text=Pass2.Text) and (Pass.Text<>'') //Want to encrypt ?
   then Archiver.Password := Pass2.Text;
  case cbZip64.ItemIndex of  //Choose Zip64 mode
   0: Archiver.Zip64Mode := zmDisabled;
   1: Archiver.Zip64Mode := zmAuto;
   2: Archiver.Zip64Mode := zmAlways
  end;
{$ENDIF}

{$IFDEF ZF_int}
  if (Pass.Text=Pass2.Text) and (Pass.Text<>'') //Want to encrypt ?
   then Archiver.Password := Pass2.Text;
  case cbZip64.ItemIndex of  //Choose Zip64 mode
   0: Archiver.Zip64Mode := zmDisabled;
   1: Archiver.Zip64Mode := zmAuto;
   2: Archiver.Zip64Mode := zmAlways
  end;
{$ENDIF}

  if not Archiver.Exists then
   try
    Archiver.OpenArchive(fmCreate);//Create archive
    NewArc := false;
   except
    MessageDlg('Can''t create archive', mtError, [mbOk], 0)
   end
  else
   try
    Archiver.OpenArchive(fmOpenReadWrite); //Create archive
    NewArc := true;
   except
    MessageDlg('Can''t open archive', mtError, [mbOk], 0)
   end;

  Archiver.FileMasks.AddStrings(filelist); //Add items to filemasks
   if reComment.Lines.Strings[0] <> '' then //Add comment to archive
    for i := 0 to (reComment.Lines.Count-1) do
     begin
      Archiver.Comment := Archiver.Comment+reComment.Lines.Strings[i];
     end;
  frmProgress.Caption := 'Adding files...';
  if FileList.Count<>0 then
   if cbDelete.Checked //Delete files after archiving
    then Archiver.MoveFiles
     else Archiver.AddFiles;
  try
   Archiver.CloseArchive;
  except
   MessageDlg('Can''t close archive', mtError, [mbOk], 0)
  end;
  if (not cbSpan.Checked) and (cbSFX.Checked) then //if SFX and not spanning
   begin
    Archiver.SFXStub := ExtractFilePath(Application.ExeName)+StubName;
    try
     Archiver.MakeSFX(ChangeFileExt(ExtractFileName(Archiver.FileName),'.exe')); //Makes .EXE file
    except
     MessageDlg('Can''t make SFX archive', mtError, [mbOk], 0)
    end;
    DeleteFile(ExtractFileName(Archiver.FileName)); //Delete source archive
   end;
  if cbTestArc.Checked then //Want to test archive ?
   begin
    try
     Archiver.OpenArchive(fmOpenRead+fmShareDenyWrite);
    except
     MessageDlg('Can''t open archive', mtError, [mbOk], 0)
    end;
    try
     Archiver.TestFiles;
    except
     MessageDlg('The files is archived with errors', mtError, [mbOk], 0)
    end;
   end;
  try
   Archiver.CloseArchive;
  except
   MessageDlg('Can''t close archive', mtError, [mbOk], 0)
  end;
mainform.Updates(mainform.FileListBox1.Tag);
end; // TfrmAdd.btnOKClick

//------------------------------------------------------------------------------
// Enable/Disable Spanning Mode ComboBoxes
//------------------------------------------------------------------------------
procedure TfrmAdd.cbSpanClick(Sender: TObject);
begin
 if cbSpan.Checked then //Spanning ?
  begin
   rgSpanMode.Enabled := true;
   cbVolumeSize.Enabled := true
  end
 else
  begin
   rgSpanMode.Enabled := false;
   cbVolumeSize.Enabled := false;
  end;
end; // TfrmAdd.cbSpanClick

//------------------------------------------------------------------------------
// Enable/Disable Encryption Algorithms if Pass1=Pass2
//------------------------------------------------------------------------------
procedure TfrmAdd.PassChange(Sender: TObject);
begin
 {$IFDEF FC}
 if (Pass.Text=Pass2.Text) and (Pass.Text<>'')
  then cbEncrypt.Enabled := true
 else cbEncrypt.Enabled := false
 {$ENDIF}
end; // TfrmAdd.PassChange

//------------------------------------------------------------------------------
// Save archive dialog
//------------------------------------------------------------------------------
procedure TfrmAdd.btnBrowseClick(Sender: TObject);
begin
 if SaveDialog1.Execute then
  if NewArc then
   begin
    Archiver.FileName := SaveDialog1.FileName;
    Archiver.BaseDir := CurrentDir;
    try
     Archiver.OpenArchive(fmCreate); //Create archive
    except
     MessageDlg('Can''t create archive', mtError, [mbOk], 0)
    end;
    try
     Archiver.CloseArchive;
    except
     MessageDlg('Can''t close archive', mtError, [mbOk], 0)
    end;
   end
  else cbArcName.Text := SaveDialog1.FileName;
end; // TfrmAdd.btnBrowseClick

//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
procedure TfrmAdd.FormShow(Sender: TObject);
var i:integer;
begin

filelist.Clear;
//Add directories
for i := 0 to (MainForm.DirectoryListBox1.Items.Count - 1) do
 if MainForm.DirectoryListBox1.Selected[i] then
  filelist.Add(CurrentDir+'\'+MainForm.DirectoryListBox1.Items.Strings[i]);
//Add files
for i := 0 to (MainForm.FileListBox1.Items.Count - 1) do
 if MainForm.FileListBox1.Selected[i] then
  filelist.Add(CurrentDir+'\'+MainForm.FileListBox1.Items.Strings[i]);
end; // TfrmAdd.FormShow

//------------------------------------------------------------------------------
// Return Focus to the frmProgress if it's active
//------------------------------------------------------------------------------
procedure TfrmAdd.FormActivate(Sender: TObject);
begin
 if frmProgress.Visible then frmProgress.SetFocus
end;

//------------------------------------------------------------------------------
// Enable Custom Size , if Volume size is custom
//------------------------------------------------------------------------------
procedure TfrmAdd.cbVolumeSizeChange(Sender: TObject);
begin
 if cbVolumeSize.ItemIndex=8 then edCustomSize.Enabled := true
 else edCustomSize.Enabled := false;
end; // TfrmAdd.FormActivate

//------------------------------------------------------------------------------
// Some variables initialization
//------------------------------------------------------------------------------
procedure TfrmAdd.FormCreate(Sender: TObject);
begin
 cbSFX.Enabled := true;
 cbTestArc.Enabled := true;
 {$IFDEF FC}
 cbZip64.Visible := false;
 Label7.Visible := false;
 cbEncrypt.Visible := true;
 rgComprAlg.Visible := true;
 Label5.Visible := true;
 SaveDialog1.Filter := 'FlexCompress archives(*.fxc)|*.FXC';
 SaveDialog1.DefaultExt := 'fxc';
 cbArcName.Text := '';
 cbArcName.Text := 'Archive1.fxc';
 SaveDialog1.FilterIndex := 1;
 {$ENDIF}
 {$IFDEF ZF}
 cbEncrypt.Visible := false;
 rgComprAlg.Visible := false;
 Label5.Visible := false;
 cbZip64.Visible := true;
 Label7.Visible := true;
 SaveDialog1.Filter := 'ZipForge archives(*.zip)|*.ZIP';
 SaveDialog1.DefaultExt := 'zip';
 cbArcName.Text := '';
 cbArcName.Text := 'Archive1.zip';
 SaveDialog1.FilterIndex := 1;
 {$ENDIF}
 {$IFDEF ZF_int}
 cbEncrypt.Visible := false;
 rgComprAlg.Visible := false;
 Label5.Visible := false;
 cbZip64.Visible := true;
 Label7.Visible := true;
 SaveDialog1.Filter := 'ZipForge archives(*.zip)|*.ZIP';
 SaveDialog1.DefaultExt := 'zip';
 cbArcName.Text := '';
 cbArcName.Text := 'Archive1.zip';
 SaveDialog1.FilterIndex := 1;
 {$ENDIF}
end; // TfrmAdd.FormCreate

end.
