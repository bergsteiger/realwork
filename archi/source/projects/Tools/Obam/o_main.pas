unit o_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Mask, ToolEdit, XPMan, l3Types;

type
  TMainForm = class(TForm)
    feSource: TFilenameEdit;
    Label1: TLabel;
    Label2: TLabel;
    edTopicStartNum: TEdit;
    btnStart: TButton;
    ProgressBar: TProgressBar;
    XPManifest1: TXPManifest;
    procedure btnStartClick(Sender: TObject);
  private
    procedure ProgressProc(aState: Byte; aValue: Long; const aMsg : String);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
uses
 ObamReader,
 ddNSRC_w,
 evSimpleTextPainter,
 evEmptyTableEliminator,
 l3Filer,
 k2Reader,
 k2TagGen,
 evTextFormatter;

{$R *.dfm}

procedure TMainForm.btnStartClick(Sender: TObject);
var
 l_Reader : TObamReader;
 l_Writer : TddNSRCGenerator;
 l_Formatter: Tk2TagGenerator;
 l_WFiler : Tl3DOSFiler;
 l_TopicStart: Integer;
begin
 if FileExists(feSource.FileName) then
 begin
  l_TopicStart := StrToIntDef(edTopicStartNum.Text, 0);
  if l_TopicStart > 0 then
  begin
   ProgressBar.Visible:= True;
   l_Reader := TObamReader.Make(feSource.FileName);
   try
    l_Reader.OnProgress:= ProgressProc;
    l_Reader.TopicNo := l_TopicStart;
    l_Reader.DocPath := ExtractFileDir(feSource.FileName);
    l_Writer := TddNSRCGenerator.Create;
    l_WFiler := Tl3DOSFiler.Make(ChangeFileExt(feSource.FileName, '.nsr'), l3_fmWrite);
    try
     l_Writer.Filer := l_WFiler;

     l_Formatter := TevSimpleTextPainter.Create;
     try
      TevSimpleTextPainter(l_Formatter).Generator := l_Writer;
      try
       TevEmptyTableEliminator.SetTo(l_Formatter);
       l_Reader.Generator := l_Formatter;
       l_Reader.Start;
       try
        l_Reader.Execute;
       finally
        l_Reader.Finish;
       end;
      finally
       FreeAndNil(l_Formatter);
      end;
     finally
      FreeAndNil(l_WFiler);
     end;
    finally
     FreeAndNil(l_Writer);
    end;
    if l_Reader.ErrorCount = 0 then
     MessageDlg('Обработка завершена', mtInformation, [mbOK], 0)
    else
     MessageDlg(Format('Обработка завершена c %d ошибками. Подробности смотрите в логе.',
                [l_Reader.ErrorCount]), mtWarning, [mbOK], 0);
   finally
    FreeAndNil(l_Reader);
   end;
   ProgressBar.Visible:= False;
  end
  else
   MessageDlg('Неверно задан начальный номер топика!', mtError, [mbOK], 0);
 end
 else
  MessageDlg('Файл реестра не найден!', mtError, [mbOK], 0);
end;

procedure TMainForm.ProgressProc(aState: Byte; aValue: Long; const aMsg : String);
begin
 case aState of
  0:
   begin
    ProgressBar.Position:= 0;
    ProgressBar.Max:= aValue;
   end;
  1: ProgressBar.Position:= aValue;
  2: ProgressBar.Position:= ProgressBar.Max;
 end;
end;

end.
