 //==============================================================================
 // Product name: ZipForge
 // Copyright ComponentAce, 2003
 //==============================================================================

{$I ZFVer.inc}


{$DEFINE ZF_VERSION}

unit ZFReg;

interface

uses Classes,
 {$IFDEF D6H}
  DesignIntf, DesignEditors
 {$ELSE}
  DSGNINTF
 {$ENDIF} ;

type

  // file open dialog - for selecting archive file
  TZFArchiveFileName = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end; // TZFArchiveFileName

  // file open dialog - for selecting SFX stub
  TZFSFXFileName = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end; // TZFSFXFileName

  // folder open dialog - for selecting paths
  TZFDirectory = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end; //TZFDirectory


procedure Register; // register

implementation

uses Forms, Dialogs, ZipForge, ZFFolderDialog;

////////////////////////////////////////////////////////////////////////////////

//   TZFArchiveFileName

////////////////////////////////////////////////////////////////////////////////

 //------------------------------------------------------------------------------
 // file name editor (extension is subtracted from name)
 //------------------------------------------------------------------------------
procedure TZFArchiveFileName.Edit;
var
  td: TOpenDialog;
  s:  string;
begin
  td := TOpenDialog.Create(Application);
  td.Options := [ofFileMustExist];

{$IFDEF ZF_VERSION}
  td.Filter := 'ZIP files (*.zip)|*.ZIP';
{$ENDIF}
  if (td.Execute) then
  begin
    s := td.FileName;
    SetStrValue(s);
  end;
  td.Free;
end; // TZFArchiveFileName.Edit


 //------------------------------------------------------------------------------
 // file name editor's attributes (paDialog - for ... button in design mode)
 //------------------------------------------------------------------------------
function TZFArchiveFileName.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paRevertable];
end; //TZFArchiveFileName.GetAttributes


////////////////////////////////////////////////////////////////////////////////

//   TZFSFXFileName

////////////////////////////////////////////////////////////////////////////////

 //------------------------------------------------------------------------------
 // file name editor (extension is subtracted from name)
 //------------------------------------------------------------------------------
procedure TZFSFXFileName.Edit;
var
  td: TOpenDialog;
  s:  string;
begin
  td := TOpenDialog.Create(Application);
  td.Options := [ofFileMustExist];
  td.Filter := 'Executable files (*.exe)|*.EXE';
  if (td.Execute) then
  begin
    s := td.FileName;
    SetStrValue(s);
  end;
  td.Free;
end; // TZFSFXFileName.Edit


 //------------------------------------------------------------------------------
 // file name editor's attributes (paDialog - for ... button in design mode)
 //------------------------------------------------------------------------------
function TZFSFXFileName.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paRevertable];
end; //TZFSFXFileName.GetAttributes


////////////////////////////////////////////////////////////////////////////////

//   TZFZIPDirectory

////////////////////////////////////////////////////////////////////////////////

 //------------------------------------------------------------------------------
 // path property editor
 //------------------------------------------------------------------------------
procedure TZFDirectory.Edit;
var
  fb: TPBFolderDialog;
begin
  fb := TPBFolderDialog.Create(Application);
  fb.Flags := [ShowPath];
  // fb.BrowseFlags := [bfDirsOnly];
  fb.Folder := GetStrValue;
  if (fb.Execute) then
    SetStrValue(fb.Folder);
  fb.Free;
end; // TZFDirectory.Edit


 //------------------------------------------------------------------------------
 // file name editor's attributes (paDialog - for ... button in design mode)
 //------------------------------------------------------------------------------
function TZFDirectory.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paRevertable];
end; //TZFDirectory.GetAttributes


procedure Register;
begin

{$IFDEF ZF_VERSION}
  RegisterComponents('ComponentAce Compression', [TZipForge]);
{$ENDIF}
  RegisterPropertyEditor(TypeInfo(string), TZFBaseArchiver, 'FileName',
    TZFArchiveFileName);
  RegisterPropertyEditor(TypeInfo(string), TZFBaseArchiver, 'SFXStub',
    TZFSFXFileName);
  RegisterPropertyEditor(TypeInfo(string), TZFBaseArchiver, 'BaseDir',
    TZFDirectory);
  RegisterPropertyEditor(TypeInfo(string), TZFBaseArchiver, 'TempDir',
    TZFDirectory);
end;

end.
