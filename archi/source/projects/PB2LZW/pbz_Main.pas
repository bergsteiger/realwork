unit pbz_Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, XPMan, ComCtrls, ExtCtrls, imageenio;

type
  TForm1 = class(TForm)
    deSource: TDirectoryEdit;
    Label1: TLabel;
    XPManifest1: TXPManifest;
    Button1: TButton;
    ProgressPanel: TPanel;
    ProgressBar1: TProgressBar;
    DispLabel: TLabel;
    ImgIO: TImageEnIO;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
   procedure DoTheWork;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses
 StrUtils,

 hyiedefs,
 hyieutils,
 TIFLZW,
 TIFFilt;

{$R *.dfm}

procedure GetTIFFInfo(aFileName: string; aIOParams:TIOParamsVals; var aNumOfPages: Integer);
var
 l_FS: TFileStream;
 l_ProRec: TProgressRec;
 l_Alpha : TIEMask;
begin
 l_FS := TFileStream.Create(aFileName, fmOpenRead);
 try
  TIFFReadStream(nil, l_FS, aNumOfPages, aIOParams, l_ProRec, True, l_Alpha, False, False, False);
 finally
  FreeAndNil(l_FS);
 end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 DoTheWork;
end;

procedure TForm1.DoTheWork;
var
 l_SR: TSearchRec;
 l_Info: TIOParamsVals;
 l_PagesCount, l_PagesTotal: Integer;
 l_FileList: TStringList;
 X: Integer;
 l_Path: string;
 I: Integer;
 l_Filename: string;
 l_OutStream: TFileStream;
 l_OutFilename: string;
 J: Integer;
 l_Bitmap: TBitmap;
begin
 deSource.Enabled := False;
 Button1.Enabled  := False;
 ProgressPanel.Visible := True;
 try
  DispLabel.Caption := 'Подсчет количества TIFF-файлов';
  l_Path := IncludeTrailingPathDelimiter(deSource.Text);
  X := FindFirst(l_Path+'*.tif', faArchive, l_SR);
  if X = 0 then
  begin
   l_Info := TIOParamsVals.Create(nil);
   l_FileList := TStringList.Create;
   l_Bitmap := TBitmap.Create;
   ImgIO.AttachedBitmap := l_Bitmap;
   l_PagesTotal := 0;
   try
    while X = 0 do
    begin
     GetTIFFInfo(l_Path+l_SR.Name, l_Info, l_PagesCount);
     if l_Info.TIFF_Compression = ioTIFF_PACKBITS then
     begin
      l_FileList.Add(l_SR.Name);
      l_PagesTotal := l_PagesTotal + l_PagesCount;
     end;
     X := FindNext(l_SR);
    end;
    if l_PagesTotal > 0 then
    begin
     ProgressBar1.Max := l_PagesTotal;
     ProgressBar1.Position := 0;
     for I := 0 to Pred(l_FileList.Count) do
     begin
      DispLabel.Caption := 'Обрабатывается: '+l_FileList[I];
      DispLabel.Update;
      l_Filename := l_Path+l_FileList[I];
      l_OutFilename := l_Path + '$$LZW$$_' + l_FileList[I];
      l_PagesCount := EnumTIFFIm(l_Filename);
      l_OutStream := TFileStream.Create(l_OutFilename, fmCreate);
      try
       for J := 0 to Pred(l_PagesCount) do
       begin
        ImgIO.Params.TIFF_ImageIndex := J;
        ImgIO.LoadFromFileTIFF(l_Filename);
        ImgIO.Params.TIFF_Compression := ioTIFF_LZW;
        if J = 0 then
         ImgIO.SaveToStreamTIFF(l_OutStream)
        else
        begin
         l_OutStream.Seek(0, soFromBeginning);
         ImgIO.InsertToStreamTIFF(l_OutStream);
        end;
        ProgressBar1.StepIt;
        ProgressBar1.Update;
       end;
      finally
       l_OutStream.Free;
      end;
      if FileExists(l_OutFilename) then
      begin
       DeleteFile(l_Filename);
       RenameFile(l_OutFilename, l_Filename);
      end;
     end;
    end
    else
     MessageDlg('Все TIFF и так упакованы правильно', mtInformation, [mbOK], 0);
   finally
    l_FileList.Free;
    l_Info.Free;
    l_Bitmap.Free;
   end;
  end
  else
   MessageDlg('Ни один TIFF не найден', mtError, [mbOK], 0);
 finally
  deSource.Enabled := True;
  Button1.Enabled := True;
  ProgressPanel.Visible := False;
 end;
end;

end.
