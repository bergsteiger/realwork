unit uMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ZipForge;

type
  TfmMain = class(TForm)
    bnStart: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    ListView: TListView;
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
var   ArchiveItem: TZFArchiveItem;
      ListItem: 	 TListItem;
      FileDate:    Integer;
begin
 ListView.Items.Clear;
 with Archiver do
    begin
        FileName := 'Archive\test.zip';

        // Open existing archive file
        OpenArchive(fmOpenRead);

        // Search text files stored inside the archive
        if (FindFirst('*.*',ArchiveItem,faAnyFile-faDirectory)) then
           repeat
    	      // Add file name
    	      ListItem := ListView.Items.Add;
    	      ListItem.Caption := ArchiveItem.FileName;

    	      // Add modification date
            FileDate := ArchiveItem.LastModFileDate shl 16 +
                        ArchiveItem.LastModFileTime;
    	      ListItem.SubItems.Add(DateToStr(
    	            FileDateToDateTime(FileDate)));

    	      // Add file size
    	      ListItem.SubItems.Add(IntToStr(ArchiveItem.UncompressedSize));

    	      // Add compression rate
    	      ListItem.SubItems.Add(Format('%f',[ArchiveItem.CompressionRate])+' %');

    	      // Add compressed file size
    	      ListItem.SubItems.Add(IntToStr(ArchiveItem.CompressedSize));

    	      // Add file path
    	      ListItem.SubItems.Add(ArchiveItem.StoredPath);
            until (not FindNext(ArchiveItem));

            // Close the archive
            CloseArchive;
    end;
end;

procedure TfmMain.BitBtn2Click(Sender: TObject);
begin
 Close;
end;

end.
