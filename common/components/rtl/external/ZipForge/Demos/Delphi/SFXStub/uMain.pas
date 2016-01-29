unit uMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, FileCtrl, ZipForge;

type
  TForm1 = class(TForm)
    bnExtract: TBitBtn;
    bnExit: TBitBtn;
    edPath: TEdit;
    bnSelectDestPath: TButton;
    Label1: TLabel;
    cboverwrite: TCheckBox;
    Archiver: TZipForge;
    procedure bnExitClick(Sender: TObject);
    procedure bnSelectDestPathClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bnExtractClick(Sender: TObject);

    {$IFNDEF VER120}        // Delphi 4
      {$IFNDEF VER125}      // BCB 4
        {$IFNDEF VER130}    // Delphi 5
          {$IFNDEF VER135}  // BCB 5
            {$DEFINE UNICODE}
          {$ENDIF}
        {$ENDIF}
      {$ENDIF}
    {$ENDIF}

    {$IFDEF UNICODE}
    procedure ArchiverConfirmOverwrite(Sender: TObject;
      SourceFileName: WideString; var DestFileName: WideString;
      var Confirm: Boolean);
    {$ELSE}
    procedure ArchiverConfirmOverwrite(Sender: TObject;
      SourceFileName: String; var DestFileName: String;
      var Confirm: Boolean);
    {$ENDIF}

  private
    { Private declarations }
    bAll: Boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.bnExitClick(Sender: TObject);
begin
 Close;
 Application.Terminate;
end;

procedure TForm1.bnSelectDestPathClick(Sender: TObject);
var s: string;
begin
 if (SelectDirectory('Select destination folder ...','',s)) then
  edPath.Text := s;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 edPath.Text := ExtractFilePath(Application.Exename);
end;

procedure TForm1.bnExtractClick(Sender: TObject);
begin
 // overwrite all
 bAll := false;
 Archiver.Options.OverwriteMode := omPrompt;
 if (cboverwrite.Checked) then
  Archiver.Options.OverwriteMode := omAlways;
 Archiver.FileName := Application.ExeName;
 Archiver.BaseDir := edPath.Text;
 Archiver.OpenArchive(fmOpenRead + fmShareDenyNone);
 Archiver.ExtractFiles('*.*');
 Archiver.CloseArchive;
 Close;
 Application.Terminate;
end;

procedure TForm1.ArchiverConfirmOverwrite;
var res: Integer;
begin
 if (bAll) then
  begin
   Confirm := true;
   Exit;
  end;
 res := MessageDlg('Overwrite '+DestFileName+#13#10+'With file '+SourceFileName,
    mtConfirmation,[mbYes,mbNo,mbAll],0);
 if (res = mrAll) then
  bAll := true;
 if (res = mrYes) or (bAll) then
  Confirm := true
 else
  Confirm := false;
end;

end.
