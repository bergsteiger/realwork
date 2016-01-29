{$I VER.INC}

//------------------------------------------------------------------------------
// Main program module
//------------------------------------------------------------------------------

unit arch1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ComCtrls, Menus, ActnList, ImgList, uAbout, StdCtrls,
  FileCtrl, ShellAPI, ExtCtrls, uAdd, uExtract, Buttons, uProgress
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
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    ActionList1: TActionList;
    AOpen: TAction;
    AClose: TAction;
    AAdd: TAction;
    AExtract: TAction;
    File1: TMenuItem;
    Actions1: TMenuItem;
    Help1: TMenuItem;
    Open1: TMenuItem;
    Close1: TMenuItem;
    Add1: TMenuItem;
    Extract1: TMenuItem;
    About1: TMenuItem;
    ImageList1: TImageList;
    Separator: TMenuItem;
    ACloseApp: TAction;
    Exit1: TMenuItem;
    AAbout: TAction;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    FileListBox1: TFileListBox;
    DirectoryListBox1: TDirectoryListBox;
    DriveComboBox1: TDriveComboBox;
    ToolBar1: TToolBar;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    AddMenu: TPopupMenu;
    Addfiles1: TMenuItem;
    mComment: TMemo;
    Extract2: TMenuItem;
    ToolButton1: TToolButton;
    ToolButton6: TToolButton;
    Label1: TEdit;
    AUpdate: TAction;
    Updatearchive1: TMenuItem;
    Updatearchive2: TMenuItem;
    ToolButton7: TToolButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ToolButton8: TToolButton;
    ANew: TAction;
    Createarchive1: TMenuItem;
    procedure ACloseAppExecute(Sender: TObject);
    procedure AAboutExecute(Sender: TObject);
    procedure FileListBox1DblClick(Sender: TObject);
    procedure AAddExecute(Sender: TObject);
    procedure AExtractExecute(Sender: TObject);
    procedure AOpenExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FileListBox1Change(Sender: TObject);
    procedure Updates(IsArc:Integer);
    procedure ShowArchiveContent(FileName1:string);
    procedure CreateAddInfoMemo;
    procedure ACloseExecute(Sender: TObject);
    {$IFDEF FC}
    procedure ArchiverFileProgress(Sender: TObject; FileName: WideString;
      Progress: Double; Operation: TFXCProcessOperation;
      ProgressPhase: TFXCProgressPhase; var Cancel: Boolean);
    procedure ArchiverOverallProgress(Sender: TObject; Progress: Double;
      Operation: TFXCProcessOperation; ProgressPhase: TFXCProgressPhase;
      var Cancel: Boolean);
    procedure ArchiverProcessFileFailure(Sender: TObject;
      FileName: WideString; Operation: TFXCProcessOperation; NativeError:	Integer;
      ErrorCode: Integer; ErrorMessage: WideString; var Action: TFXCAction);
    {$ENDIF}
    {$IFDEF ZF_int}
    procedure ArchiverFileProgress(Sender: TObject; FileName: WideString;
      Progress: Double; Operation: TFXCProcessOperation;
      ProgressPhase: TFXCProgressPhase; var Cancel: Boolean);
    procedure ArchiverOverallProgress(Sender: TObject; Progress: Double;
      Operation: TFXCProcessOperation; ProgressPhase: TFXCProgressPhase;
      var Cancel: Boolean);
    procedure ArchiverProcessFileFailure(Sender: TObject;
      FileName: WideString; Operation: TFXCProcessOperation; NativeError:	Integer;
      ErrorCode: Integer; ErrorMessage: WideString; var Action: TFXCAction);
    {$ENDIF}
    {$IFDEF ZF}
    procedure ArchiverFileProgress(Sender: TObject; FileName: TZFString;
      Progress: Double; Operation: TZFProcessOperation;
      ProgressPhase: TZFProgressPhase; var Cancel: Boolean);
    procedure ArchiverOverallProgress(Sender: TObject; Progress: Double;
      Operation: TZFProcessOperation; ProgressPhase: TZFProgressPhase;
      var Cancel: Boolean);
    procedure ArchiverProcessFileFailure(Sender: TObject;
      FileName: TZFString; Operation: TZFProcessOperation; NativeError:	Integer;
      ErrorCode: Integer; ErrorMessage: TZFString; var Action: TZFAction);
    {$ENDIF}
    procedure FormActivate(Sender: TObject);
    procedure AUpdateExecute(Sender: TObject);
    procedure DirectoryListBox1ContextPopup(Sender: TObject;
      MousePos: TPoint; var Handled: Boolean);
    procedure ANewExecute(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm:   TMainForm;
  {$IFDEF FC}
  Archiver:   TFlexCompress;
  {$ENDIF}
  {$IFDEF ZF}
  Archiver:   TZipForge;
  {$ENDIF}
  {$IFDEF ZF_int}
  Archiver:   TZipForge;
  {$ENDIF}
  FileList:   TStrings; //Simple list of files liable to compressing
  UpdList:    TStrings; //List of files liable to updating
  CurrentDir: String; //Store the path to current directory
  ArcName:    String;
  NewArc:       boolean;

implementation

{$R *.dfm}

//------------------------------------------------------------------------------
//Check type of file, and if it's archive type return true.
//------------------------------------------------------------------------------
function IsArcExt(filename:string):boolean;
begin

{$IFDEF FC}
Result := LowerCase(ExtractFileExt(filename))='.fxc';
{$ENDIF}

{$IFDEF ZF}
Result := LowerCase(ExtractFileExt(filename))='.zip';
{$ENDIF}

{$IFDEF ZF_int}
Result := LowerCase(ExtractFileExt(filename))='.zip';
{$ENDIF}

end; //IsArcExt

//------------------------------------------------------------------------------
//Moves Memo with information to FileListBox1 place
//------------------------------------------------------------------------------
procedure TMainForm.CreateAddInfoMemo;
begin
 with mComment do
  begin
   Top := 80;
   Left := 224;
   Width := 169;
   Height := 185;
  end;
end; // TMainForm.CreateAddInfoMemo

//------------------------------------------------------------------------------
//Update components
//------------------------------------------------------------------------------
procedure TMainForm.Updates;
begin
 if FileListBox1.Tag<>1 then
  begin
   DirectoryListBox1.Update;
   FileListBox1.Update;
   Label1.Text := FileListBox1.FileName;
  end
 else
  begin
   Label1.Text := '';
   if FileListBox1.Count<>0 then
    Label1.Text := ArcName+'/'+FileListBox1.Items[0] //Archive name+file
                                                    //name in archive
  end
end; // TMainForm.Updates

//------------------------------------------------------------------------------
//Opens and shows archive content
//------------------------------------------------------------------------------
procedure TMainForm.ShowArchiveContent;
var
{$IFDEF FC}
 arc:TFXCArchiveItem;
{$ENDIF}
{$IFDEF ZF_int}
 arc:TFXCArchiveItem;
{$ENDIF}
{$IFDEF ZF}
 arc:TZFArchiveItem;
{$ENDIF}
begin

 CreateAddInfoMemo; //Create info memo
 DriveComboBox1.Hide; //Hide DriveComboBox1
 Label4.Hide;
 DirectoryListBox1.Hide; //Hide DirectoryListBox1
 AClose.Enabled := true; //Enable Close Archive button
 ArcName := FileName1; //Store archive name in global variable
 Label3.Caption := 'Select file in archive:';
 Label2.Caption := 'Information:';

   Archiver.FileName := FileName1;
   Archiver.BaseDir := CurrentDir;
   Archiver.SpanningOptions.AdvancedNaming := False;
   try
   Archiver.OpenArchive(fmOpenRead+fmShareDenyWrite);
   except
    Archiver.OpenCorruptedArchives := true;//Try to open corrupted archive
    Archiver.OpenArchive(fmOpenRead+fmShareDenyWrite);
   end;

   FileListBox1.Left := 24; //Move FileListBox1

   // Show some archive information
   with mComment do
    begin
     Show;
     with Lines do
      begin
       Clear;
       Add('Archive name: ' + extractfilename(filename1));
       Add(' ');
       Add(inttostr(Archiver.FileCount) + ' files in archive');
       Add(' ');
       Add('Archive size: ' + inttostr(Round(Archiver.Size/1024)) + ' KB');
       Add(' ');
       Add('Comment: ');
       Add(Archiver.comment);
      end;
    end;

   FileListBox1.Items.Clear;
   //Add Items in archive to FileListBox1
   if (Archiver.FindFirst('*.*',arc,faAnyFile-faDirectory)) then
    repeat
     FileListBox1.Items.Add(arc.StoredPath+arc.FileName);
    until (not Archiver.FindNext(arc));
   if Archiver.FileCount<>0 then
    begin
     AExtract.Enabled := true; //Enable Extract button
     AUpdate.Enabled := true;  //Enable Update button
     ANew.Enabled := false;
     AAdd.Enabled := false;
    end
   else
    ANew.Enabled := false;
    AAdd.Enabled := false;
   try
    Archiver.CloseArchive;
   except
    MessageDlg('Can''t close archive', mtError, [mbOk], 0)
   end;

 Updates(FileListBox1.Tag);

end; // TMainForm.ShowArchiveContent

//------------------------------------------------------------------------------
//Close application
//------------------------------------------------------------------------------
procedure TMainForm.ACloseAppExecute(Sender: TObject);
begin
 Close;
end; // TMainForm.ACloseAppExecute

//------------------------------------------------------------------------------
//Show 'About' window
//------------------------------------------------------------------------------
procedure TMainForm.AAboutExecute(Sender: TObject);
begin
 AboutBox.ShowModal;
end; // TMainForm.AAboutExecute

//------------------------------------------------------------------------------
//Catch mouse clicks on FileListBox and opens files
//------------------------------------------------------------------------------
procedure TMainForm.FileListBox1DblClick(Sender: TObject);
begin
 if IsArcExt(FileListBox1.FileName) then      //if file is archive - show content
  if FileListBox1.Tag<>1 then
   begin
    FileListBox1.Tag:=1; //flag -1-archive is open, 0-archive is not open
    ShowArchiveContent(FileListBox1.FileName);
   end;
 //if not - run associated program
 if FileListBox1.Tag<>1 then
  ShellExecute(Handle,'Open',
              pchar(FileListBox1.FileName),nil,nil,SW_SHOWNORMAL);
end; // TMainForm.FileListBox1DblClick

//------------------------------------------------------------------------------
//Show 'Add files' window
//------------------------------------------------------------------------------
procedure TMainForm.AAddExecute(Sender: TObject);
begin
 NewArc := False;
 frmAdd.ShowModal;
end; // TMainForm.AAddExecute

//------------------------------------------------------------------------------
//Show 'Extract files' window
//------------------------------------------------------------------------------
procedure TMainForm.AExtractExecute(Sender: TObject);
var i:integer;
begin
 frmExtract.ShowModal;
 //Create list with selected items for extract
 for i:=0 to (FileListBox1.Items.Count-1) do
  FileListBox1.Selected[i]:=false;
end; // TMainForm.AExtractExecute

//------------------------------------------------------------------------------
//Open archive dialog
//------------------------------------------------------------------------------
procedure TMainForm.AOpenExecute(Sender: TObject);
begin
 if OpenDialog1.Execute then
  begin
   FileListBox1.Tag:=1;
   ShowArchiveContent(OpenDialog1.FileName);
  end;
end; // TMainForm.AOpenExecute

//------------------------------------------------------------------------------
//Some variables initialization
//------------------------------------------------------------------------------
procedure TMainForm.FormCreate(Sender: TObject);
begin
 FileList := TStringList.Create;
 UpdList := TStringList.Create;
 DirectoryListBox1.MultiSelect := true;
 CurrentDir := FileListBox1.Directory;
 Updates(FileListBox1.Tag);
 {$IFDEF FC}
 Archiver := TFlexCompress.Create(MainForm);
 MainForm.Caption := 'FlexCompress archiver';
 OpenDialog1.Filter := 'FlexCompress archives (*.fxc)|*.FXC|All Files (*.*)|*.*';
 {$ENDIF}
 {$IFDEF ZF}
 Archiver := TZipForge.Create(MainForm);
 MainForm.Caption := 'ZipForge archiver';
 OpenDialog1.Filter := 'ZipForge archives (*.zip)|*.ZIP|All Files (*.*)|*.*';
 {$ENDIF}
 {$IFDEF ZF_int}
 Archiver := TZipForge.Create(MainForm);
 MainForm.Caption := 'ZipForge archiver';
 OpenDialog1.Filter := 'ZipForge archives (*.zip)|*.ZIP|All Files (*.*)|*.*';
 {$ENDIF}
 Archiver.OnOverallProgress := ArchiverOverallProgress;
 Archiver.OnFileProgress := ArchiverFileProgress;
 Archiver.OnProcessFileFailure := ArchiverProcessFileFailure;
end; // TMainForm.FormCreate

//------------------------------------------------------------------------------
//Update path to file
//------------------------------------------------------------------------------
procedure TMainForm.FileListBox1Change(Sender: TObject);
begin
 CurrentDir := FileListBox1.Directory;
 Label1.Text := '';
if FileListBox1.Tag=1 then  // if archive is opened
  Label1.Text := ArcName+'/'+FileListBox1.Items[FileListBox1.ItemIndex]
else //no archive
 if FileListBox1.FileName='' then //Empty directory
  Label1.Text := DirectoryListBox1.Directory
 else
  Label1.Text := FileListBox1.FileName;
end; // TMainForm.FileListBox1Change

//------------------------------------------------------------------------------
//Closes opened archive
//------------------------------------------------------------------------------
procedure TMainForm.ACloseExecute(Sender: TObject);
begin
 FileListBox1.Left := 232;
 mComment.Hide;
 Label4.Show;
 DirectoryListBox1.Show;
 DriveComboBox1.Show;
 FileListBox1.Tag := 0;
 Updates(FileListBox1.Tag);
 AAdd.Enabled := true;
 AExtract.Enabled := false;
 AUpdate.Enabled := false;
 AClose.Enabled := false;
 ANew.Enabled := true;
 Label3.Caption := 'Select directory:';
 Label2.Caption := 'Select file:';
end; // TMainForm.ACloseExecute

{$IFDEF FC}

//------------------------------------------------------------------------------
//Show progress of compressing file
//------------------------------------------------------------------------------
procedure TMainForm.ArchiverFileProgress;
begin
 frmProgress.gFile.Progress := Round(Progress);
 frmProgress.lbFile.Caption := FileName;
 Cancel := frmProgress.bCancel;
 Application.ProcessMessages;
end; // TMainForm.ArchiverFileProgress

//------------------------------------------------------------------------------
//Show progress of compressing all files
//------------------------------------------------------------------------------
procedure TMainForm.ArchiverOverallProgress(Sender: TObject;
  Progress: Double; Operation: TFXCProcessOperation;
  ProgressPhase: TFXCProgressPhase; var Cancel: Boolean);
begin
 if (ProgressPhase = ppStart) then
  frmProgress.Show
 else
 if (ProgressPhase = ppEnd) then
  frmProgress.Hide;

 frmProgress.gOverall.Progress := Round(Progress);
 Cancel := frmProgress.bCancel;
 Application.ProcessMessages;
end; // TMainForm.ArchiverOverallProgress

//------------------------------------------------------------------------------
//Errors in operations with files
//------------------------------------------------------------------------------
procedure TMainForm.ArchiverProcessFileFailure(Sender: TObject;
  FileName: String; Operation: TFXCProcessOperation; NativeError:	Integer;
  ErrorCode: Integer; ErrorMessage: String; var Action: TFXCAction);
begin
 Action := fxaIgnore;
 MessageDlg('Native error: '+ inttostr(NativeError)+ #13#10 +
 ErrorMessage + #13#10 + filename, mtError, [mbOk], 0)
end;

{$ENDIF}

{$IFDEF ZF_int}

//------------------------------------------------------------------------------
//Show progress of compressing file
//------------------------------------------------------------------------------
procedure TMainForm.ArchiverFileProgress(Sender: TObject; FileName: String;
  Progress: Double; Operation: TFXCProcessOperation;
  ProgressPhase: TFXCProgressPhase; var Cancel: Boolean);
begin
 frmProgress.gFile.Progress := Round(Progress);
 frmProgress.lbFile.Caption := FileName;
 Cancel := frmProgress.bCancel;
 Application.ProcessMessages;
end; // TMainForm.ArchiverFileProgress

//------------------------------------------------------------------------------
//Show progress of compressing all files
//------------------------------------------------------------------------------
procedure TMainForm.ArchiverOverallProgress(Sender: TObject;
  Progress: Double; Operation: TFXCProcessOperation;
  ProgressPhase: TFXCProgressPhase; var Cancel: Boolean);
begin
 if (ProgressPhase = ppStart) then
  frmProgress.Show
 else
 if (ProgressPhase = ppEnd) then
  frmProgress.Hide;

 frmProgress.gOverall.Progress := Round(Progress);
 Cancel := frmProgress.bCancel;
 Application.ProcessMessages;
end; // TMainForm.ArchiverOverallProgress

//------------------------------------------------------------------------------
//Errors in operations with files
//------------------------------------------------------------------------------
procedure TMainForm.ArchiverProcessFileFailure(Sender: TObject;
  FileName: String; Operation: TFXCProcessOperation; NativeError:	Integer;
  ErrorCode: Integer; ErrorMessage: String; var Action: TFXCAction);
begin
 Action := fxaIgnore;
 MessageDlg('Native error: '+ inttostr(NativeError)+ #13#10 +
 ErrorMessage + #13#10 + filename, mtError, [mbOk], 0)
end;

{$ENDIF}

{$IFDEF ZF}

//------------------------------------------------------------------------------
//Show progress of compressing file
//------------------------------------------------------------------------------
procedure TMainForm.ArchiverFileProgress;
begin
 frmProgress.gFile.Progress := Round(Progress);
 frmProgress.lbFile.Caption := FileName;
 Cancel := frmProgress.bCancel;
 Application.ProcessMessages;
end; // TMainForm.ArchiverFileProgress

//------------------------------------------------------------------------------
//Show progress of compressing all files
//------------------------------------------------------------------------------
procedure TMainForm.ArchiverOverallProgress(Sender: TObject;
  Progress: Double; Operation: TZFProcessOperation;
  ProgressPhase: TZFProgressPhase; var Cancel: Boolean);
begin
 if (ProgressPhase = ppStart) then
  frmProgress.Show
 else
 if (ProgressPhase = ppEnd) then
  frmProgress.Hide;

 frmProgress.gOverall.Progress := Round(Progress);
 Cancel := frmProgress.bCancel;
 Application.ProcessMessages;
end; // TMainForm.ArchiverOverallProgress

//------------------------------------------------------------------------------
//Errors in operations with files
//------------------------------------------------------------------------------
procedure TMainForm.ArchiverProcessFileFailure;
begin
 Action := fxaIgnore;
 MessageDlg('Native error: '+ inttostr(NativeError)+ #13#10 +
 ErrorMessage + #13#10 + filename, mtError, [mbOk], 0)
end;

{$ENDIF}

//------------------------------------------------------------------------------
//Return Focus to the frmProgress if it's active
//------------------------------------------------------------------------------
procedure TMainForm.FormActivate(Sender: TObject);
begin
 if frmProgress.Visible then frmProgress.SetFocus;
end; // TMainForm.FormActivate

//------------------------------------------------------------------------------
//Update opened archive
//------------------------------------------------------------------------------
procedure TMainForm.AUpdateExecute(Sender: TObject);
var i:integer;
begin
 OpenDialog1.Options := [ofAllowMultiSelect]; //turn on multi-select
 if OpenDialog1.Execute then
  UpdList.AddStrings(OpenDialog1.Files); //add selected files to UpdList
   Archiver.FileMasks.Clear;
   Archiver.BaseDir := ExtractFilePath(UpdList.Strings[0]);
   for i:=0 to (OpenDialog1.Files.Count-1) do
    Archiver.FileMasks.Add(ExtractFileName(UpdList.Strings[i])); //add UpdList to FileMasks
   Archiver.FileName := ArcName;
   try
    Archiver.OpenArchive(fmOpenReadWrite);
   except
    MessageDlg('Can''t open archive', mtError, [mbOk], 0)
   end;
   Archiver.UpdateFiles; //Update archive
   try
    Archiver.CloseArchive;
   except
    MessageDlg('Can''t close archive', mtError, [mbOk], 0)
   end;
end; // TMainForm.AUpdateExecute

//------------------------------------------------------------------------------
//Select directory when PopupMenu is shown
//------------------------------------------------------------------------------
procedure TMainForm.DirectoryListBox1ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var
 exist:boolean;
 i:integer;
begin
 exist := True;
 for i := 0 to (DirectoryListBox1.Items.Count - 1) do
  if DirectoryListBox1.Selected[i] then
   DirectoryListBox1.Selected[i] := false;
 DirectoryListBox1.Selected[DirectoryListBox1.ItemAtPos(MousePos,exist)] := true;
end; // TMainForm.DirectoryListBox1ContextPopup

procedure TMainForm.ANewExecute(Sender: TObject);
begin
 NewArc := True;
 frmAdd.btnBrowseClick(nil);
end;

end.
