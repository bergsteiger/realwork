unit uMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ZipForge;

type
  TfmMain = class(TForm)
    bnStart: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Archiver: TZipForge;
    procedure bnStartClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.DFM}

procedure TfmMain.bnStartClick(Sender: TObject);
begin
 with Archiver do
    begin
        FileName := 'Archive\test.zip';
        CopyFile(pChar('Source\1.txt'),pChar('Source1\2.txt'),false);
        CopyFile(pChar('Source\uMain.pas'),pChar('Source1\2.pas'),false);
        CopyFile(pChar('Source\dummy.mp3'),pChar('Source1\dummy2.mp3'),false);
        CreateDir('Source1\33.txt');

        // Create a new archive file
        OpenArchive(fmCreate);

        // Let's encrypt all files
        Password := 'The password';

        // Set path to folder with some text files to BaseDir
        BaseDir := 'Source';

        // Do not compress MPEG3 files
        NoCompressionMasks.Text := '*.mp3';

        // Add all files and directories from Source excluding text files to the archive
        AddFiles('*.*',faAnyFile,'*.txt');

        // Set path to destination folder
        BaseDir := 'Dest';

        // Extract all files and directories from the archive to BaseDir
        // After extracting directory Dest should contain all files from folder
        // Source excluding *.mp3 and *.txt files
        ExtractFiles('*.*');

        // Use full path
        Options.StorePath := spFullPath;

        // Set path to destination folder
        BaseDir := 'Source1';

        // Move all text files from Source1 to the archive
        // After moving directory Source1 should not contain any text files
        MoveFiles('*.txt',faAnyFile-faDirectory);

        // Set path to current drive
        BaseDir := ExtractFileDrive(Application.ExeName);

        // Overwrite all files
        Options.OverwriteMode := omAlways;

        // Update all files excluding 1???.t* from Source1
        UpdateFiles(ExtractFilePath(Application.ExeName)+'\Source1\*.*',faAnyFile-faDirectory,'2???.t*');

        // Set temporary directory
        TempDir := 'Temp';

        // Test all files and directories in the archive
        try
          TestFiles('*.*');
        except
          MessageDlg('Errors occurred in the archive file',mtError,[mbOk],0);
        end;

        // Use full path
        Options.StorePath := spRelativePath;
        BaseDir := 'Dest1';

        // Extract all files to Dest1
        ExtractFiles('*.*');

        // Close the archive
        CloseArchive;
    end;
    ShowMessage('All files were added and extracted successfully.');
end;

procedure TfmMain.BitBtn2Click(Sender: TObject);
begin
 Close;
end;

end.
