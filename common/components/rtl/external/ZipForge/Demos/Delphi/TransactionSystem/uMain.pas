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

        // Create a new archive file
        OpenArchive(fmCreate);

        // Start a transaction
        BeginUpdate;

        // Set path to folder with some HTML files to BaseDir
        BaseDir := 'Source';

        // Add all files from Source folder to the archive
        try
          AddFiles('*.*');
        except

          // If errors occurs rollback transaction. All modifications will be cancelled.
          CancelUpdate;

          // Close archive and exit current procedure
          CloseArchive;
          ShowMessage('Error adding all files');
          Exit;
        end;

        // Set path to folder with some HTML files to BaseDir
        BaseDir := 'Source1\';

        // Add all HTML files from Source1 folder to the archive
        try
          AddFiles('*.htm*');
        except

          // If errors occurs rollback transaction. All modifications will be cancelled.
          CancelUpdate;

          // Close archive and exit current procedure
          CloseArchive;
          ShowMessage('Error adding html files');
          Exit;
        end;

        // Commit a transaction. All modifications will be saved.
        EndUpdate;

        // Set path to destination folder
        BaseDir := 'Dest';

        // Extract all files
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
