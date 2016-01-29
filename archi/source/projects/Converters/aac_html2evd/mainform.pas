unit mainform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ddCmdLineUtils, dd_lcHtmlDocReader, l3Filer, EvdWriter,
  evNestedDocumentEliminator;

type
  TAACMakerForm = class(TForm)
    ProgressBar1: TProgressBar;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    f_Filer: TevDOSFiler;
    f_Nested: TevNestedDocumentEliminator;
    f_Options: TddCmdLine;
    f_reader: TlcHTMLDocReader;
    f_Writer: TevdNativeWriter;
    { Private declarations }
  protected
    procedure AazIdle(Sender: TObject; var Done: Boolean);
    procedure ConvertFolder;
    procedure UpdateProgress;
  public
    { Public declarations }
  end;

 TOptions = class(TddCmdLine)
 private
  f_DestFolder: string;
  f_SrcFolder: string;
 protected
  procedure Init; override;
 public
  property DestFolder: string read f_DestFolder write f_DestFolder;
  property SrcFolder: string read f_SrcFolder write f_SrcFolder;
 end;

var
  AACMakerForm: TAACMakerForm;

implementation

uses l3FileUtils, ddFileIterator, l3base;

{$R *.dfm}

procedure TAACMakerForm.AazIdle(Sender: TObject; var Done: Boolean);
begin
 application.OnIdle:= nil;
 try
  ConvertFolder;
 except
  on E: Exception do
  begin
   l3System.Exception2Log(E);
   MessageDlg(E.Message, mtError, [mbOk], 0);
  end
 end;
 Close;
end;

procedure TAACMakerForm.ConvertFolder;
var
  sr: TSearchRec;
begin
 if FindFirst(ConcatDirName(TOptions(f_Options).SrcFolder, '*.*'), faDirectory, sr) = 0 then
 begin
  repeat
   if (SR.Name[1] <> '.') and (SR.Attr and faDirectory = faDirectory) then
   begin
    f_Filer.FileName:= ConcatDirName(TOptions(f_Options).DestFolder, SR.Name) + '.evd';
    f_reader.Execute(ConcatDirName(TOptions(f_Options).SrcFolder, SR.Name));
    UpdateProgress;
   end;
  until FindNext(sr) <> 0;
  FindClose(sr);
 end;
end;

procedure TAACMakerForm.FormDestroy(Sender: TObject);
begin
 FreeAndNil(f_Nested);
 FreeAndNil(f_Filer);
 FreeAndNil(f_Writer);
 FreeAndNil(f_Options);
 FreeAndNil(f_Reader);
end;

procedure TAACMakerForm.FormCreate(Sender: TObject);
begin
 f_Options:= TOptions.Create;
 f_reader:= TlcHTMLDocReader.Create;
 f_Reader.SourceFileName:= ExtractFilePath(Application.ExeName)+'Source.csv';
 f_Writer := TevdNativeWriter.Create();
 f_Filer := TevDOSFiler.Create();
 f_Writer.Filer:= f_Filer;
 f_Nested := TevNestedDocumentEliminator.Create();
 f_Nested.Generator:= f_Writer;
 f_Reader.Generator:= f_Nested;
 Application.OnIdle:= AazIdle;
end;

procedure TAACMakerForm.UpdateProgress;
begin
 if ProgressBar1.Position = 100 then
  ProgressBar1.Position := 0;
 ProgressBar1.Position := ProgressBar1.Position + 10;
end;

procedure TOptions.Init;
begin
 AddDir('-Src','Root folder', f_SrcFolder);
 AddString('-Dest', 'Destination folder', f_DestFolder);
 inherited;
end;

end.
