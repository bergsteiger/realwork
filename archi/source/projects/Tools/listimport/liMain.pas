unit liMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, ComCtrls, l3Types;

type
  TMainForm = class(TForm)
    feFilename: TFilenameEdit;
    Label1: TLabel;
    ProgressBar: TProgressBar;
    btnStart: TButton;
    procedure feFilenameChange(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
  private
    procedure OnProgressProc(aState: Byte; aValue: Long; const aMsg : String = '');
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
uses
 l3Base,
 l3Interfaces,
 liEngine;


{$R *.dfm}

procedure TMainForm.feFilenameChange(Sender: TObject);
begin
 btnStart.Enabled := FileExists(feFilename.FileName);
end;

procedure TMainForm.btnStartClick(Sender: TObject);
var
 l_LI: TListImporter;
begin
 l_LI := TListImporter.Create(feFilename.FileName);
 try
  l_LI.OnProgress := OnProgressProc;
  l_LI.Process;
 finally
  l3Free(l_LI);
  btnStart.Enabled := True;
 end;
end;

procedure TMainForm.OnProgressProc(aState: Byte; aValue: Long; const aMsg : String = '');
begin
 case aState of
  piStart:
   begin
    btnStart.Enabled := False;
    ProgressBar.Max := aValue;
    ProgressBar.Position := 0;
   end;
  piCurrent:
   begin
    ProgressBar.Position := aValue;
   end;
  piEnd:
   begin
    ProgressBar.Position := ProgressBar.Max;
    feFilenameChange(nil);
   end;
 end;
 Application.ProcessMessages;
end;

end.
