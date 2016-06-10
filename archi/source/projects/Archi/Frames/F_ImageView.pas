unit F_ImageView;
{ Фрейм для просмотра многостраничных TIFF }

{ $Id: F_ImageView.pas,v 1.24 2016/04/26 12:45:58 lukyanets Exp $ }

// $Log: F_ImageView.pas,v $
// Revision 1.24  2016/04/26 12:45:58  lukyanets
// Выключаем переключения текущего каталога
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.23  2014/11/14 08:49:11  fireton
// - определяем формат файла не по расширению
//
// Revision 1.22  2013/04/19 13:05:41  lulin
// - портируем.
//
// Revision 1.21  2012/08/20 06:00:50  fireton
// - bugfix: печатаем полноразмерную картинку (K 385976845)
//
// Revision 1.20  2012/08/07 08:51:49  fireton
// - оптимизация работы с миниатюрами и потребления памяти
//
// Revision 1.19  2012/07/27 10:08:45  fireton
// - прогресс-бар записи образа (K 380046317)
//
// Revision 1.18  2012/07/27 09:31:34  fireton
// - оптимизация записи образа на диск (K 255960139)
//
// Revision 1.17  2008/10/03 10:25:20  fireton
// - образом документа теперь может быть не только TIFF
//
// Revision 1.16  2007/05/24 17:18:49  voba
// - сообщения об ошибках по осмысленнее сделал
//
// Revision 1.15  2007/04/10 14:22:57  voba
// no message
//
// Revision 1.14  2006/12/24 14:13:44  lulin
// - текст ноды - теперь структура с длиной и кодовой страницей.
//
// Revision 1.13  2006/10/27 09:13:02  fireton
// - возможность записи граф. образа в файл
//
// Revision 1.12  2005/10/13 09:06:47  voba
// no message
//
// Revision 1.11  2004/08/17 15:16:13  fireton
// - bug fix: поднимаем членораздельный exception при неверном диапазоне страниц
//
// Revision 1.10  2004/03/04 14:18:05  voba
// no message
//
// Revision 1.9  2004/02/12 13:28:28  fireton
// no message
//
// Revision 1.8  2004/02/06 11:24:35  fireton
// - update: добавлен экспорт в GIF/TIF
//
// Revision 1.7  2004/02/06 09:19:01  fireton
// - update: добавлен метод Print - печать документа
//
// Revision 1.6  2004/02/04 07:47:00  fireton
// - bugfix: изменение показа количества страниц при LoadFileAdd
// - change: при LoadFileNew теперь по умолчанию устанавливается режим
//   просмотра "вся страница".
//
// Revision 1.5  2004/02/03 08:55:03  fireton
// - visual cleanup
// - строка ввода номера страницы
//
// Revision 1.4  2004/02/02 15:51:15  fireton
// - bugfix: D6 adjustment
//
// Revision 1.3  2004/02/02 09:45:43  fireton
// - bugfix: контроль загружаемого файла - поднимаем эксепшн если файл кривой
//
// Revision 1.2  2004/01/30 10:35:01  fireton
// - масса добавлений и исправлений, можно считать, что это первый релиз
//

interface

{$Include l3XE.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, 
  vtForm,
  imageenio, iemio, imageenview, ieview, iemview, l3RangeManager,
  ExtCtrls, StdCtrls, Mask, Buttons, l3InterfacedComponent, imageenproc;

type

 TExportGetFileNameFunc = function (PageNum, RealPageNum: Integer): string of object;

 TExpFileType = (eftTIF, eftGIF);

 TfrmImgViewer = class(TvtFrame)
    Bevel1: TBevel;
    btnByWidth: TSpeedButton;
    btnPageNext: TSpeedButton;
    btnPagePrev: TSpeedButton;
    btnWholePage: TSpeedButton;
    btnZoomIn: TSpeedButton;
    btnZoomOut: TSpeedButton;
    cbPercent: TComboBox;
    edPageNum: TEdit;
    Label1: TLabel;
    PageView: TImageEnView;
    Panel1: TPanel;
    PrintDialog: TPrintDialog;
    Splitter1: TSplitter;
    ImgLoader: TImageEnIO;
    TumbView: TImageEnMView;
    Bevel2: TBevel;
    btnSaveImage: TSpeedButton;
    SaveDialog: TSaveDialog;
    TumbProc: TImageEnProc;
    procedure btnByWidthClick(Sender: TObject);
    procedure btnPageNextClick(Sender: TObject);
    procedure btnPagePrevClick(Sender: TObject);
    procedure btnWholePageClick(Sender: TObject);
    procedure btnZoomInClick(Sender: TObject);
    procedure btnZoomOutClick(Sender: TObject);
    procedure cbPercentKeyPress(Sender: TObject; var Key: Char);
    procedure cbPercentSelect(Sender: TObject);
    procedure edPageNumKeyPress(Sender: TObject; var Key: Char);
    procedure FrameResize(Sender: TObject);
    procedure PageViewViewChange(Sender: TObject; Change: Integer);
    procedure Splitter1CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure Splitter1Moved(Sender: TObject);
    procedure TumbViewBeforeImageDraw(Sender: TObject; idx, Left,
      Top: Integer; Canvas: TCanvas);
    procedure TumbViewImageSelect(Sender: TObject; idx: Integer);
    procedure btnSaveImageClick(Sender: TObject);
 private
    FOnExportGetFileName: TExportGetFileNameFunc;
    f_Bitmap: TBitmap;
    f_FileName: string;
    f_GradualLoad: Boolean;
    f_IsTIFF: Boolean;
    f_Range: string;
    RM: Tl3RangeManager;
    procedure AdjustPercentCB;
    procedure ExportToFile(FileType: TExpFileType);
    procedure LoadFileAdd(const AFileName: string; const ARange: string);
    procedure LoadTumbnail(TumbIdx, RMIdx: Integer);
    procedure NoGradualLoad;
    procedure RenumberPages;
    procedure UpdatePageNumEditText;
    procedure UpdatePageView;
 public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ClearAll;
    procedure ClearCurrent;
    procedure LoadFileNew(AFileName: string; ARange: string);
    function ParsePercent(const S: string; Default: Double): Double;
    procedure Print;
    procedure ResizeThumbnails;
    procedure SaveAllToSingleTIFF(const AFileName: string);
    property IsTIFF: Boolean read f_IsTIFF;
 published
    property OnExportGetFileName: TExportGetFileNameFunc read FOnExportGetFileName
        write FOnExportGetFileName;
 end;

implementation
{$R *.dfm}

uses
 l3Base, l3Except,
 StrShop, IniShop,
 TIFLZW, GIFLZW,
 hyiedefs,
 hyieutils, Printers,
 ddSimpleProgressDlg;


const
 ApproxTumbSize = 120;


constructor TfrmImgViewer.Create(AOwner: TComponent);
begin
 inherited;
 RM := Tl3RangeManager.Create;
 f_Bitmap := TBitmap.Create;
 f_GradualLoad := True;
 cbPercent.DropDownCount := cbPercent.Items.Count;
 FOnExportGetFileName := nil;
end;

destructor TfrmImgViewer.Destroy;
begin
 l3Free(RM);
 f_Bitmap.Free;
 inherited;
end;

procedure TfrmImgViewer.AdjustPercentCB;
var
 TC: Char;
begin
 if btnByWidth.Down then
 begin
  cbPercent.Text := 'по ширине';
  Exit;
 end;
 if btnWholePage.Down then
 begin
  cbPercent.Text := 'вся страница';
  Exit;
 end;

 TC := {$IfDef XE}FormatSettings.{$EndIf}DecimalSeparator;
 {$IfDef XE}FormatSettings.{$EndIf}DecimalSeparator := '.';
 cbPercent.Text := Format('%.4g%%',[PageView.Zoom]);
 {$IfDef XE}FormatSettings.{$EndIf}DecimalSeparator := TC;
end;

procedure TfrmImgViewer.btnByWidthClick(Sender: TObject);
begin
 cbPercent.ItemIndex := cbPercent.Items.Count-2;
 cbPercentSelect(nil);
end;

procedure TfrmImgViewer.btnPageNextClick(Sender: TObject);
begin
 TumbView.SelectSeek(iskDown);
end;

procedure TfrmImgViewer.btnPagePrevClick(Sender: TObject);
begin
 TumbView.SelectSeek(iskUp);
end;

procedure TfrmImgViewer.btnWholePageClick(Sender: TObject);
begin
 cbPercent.ItemIndex := cbPercent.Items.Count-1;
 cbPercentSelect(nil);
end;

procedure TfrmImgViewer.btnZoomInClick(Sender: TObject);
begin
 PageView.Zoom := (Round(PageView.Zoom) div 5)*5 + 5;
 cbPercent.ItemIndex := -1;
 AdjustPercentCB;
end;

procedure TfrmImgViewer.btnZoomOutClick(Sender: TObject);
begin
 PageView.Zoom := (Round(PageView.Zoom) div 5)*5 - 5;
 cbPercent.ItemIndex := -1;
 AdjustPercentCB;
end;

procedure TfrmImgViewer.cbPercentKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  PageView.Zoom := ParsePercent(cbPercent.Text, PageView.Zoom);
end;

procedure TfrmImgViewer.cbPercentSelect(Sender: TObject);
begin
 if cbPercent.ItemIndex = cbPercent.Items.Count-2 then
 begin
  PageView.FitToWidth;
  Exit;
 end;
 if cbPercent.ItemIndex = cbPercent.Items.Count-1 then
 begin
  PageView.Fit;
  Exit;
 end;
 PageView.Zoom := ParsePercent(cbPercent.Text, PageView.Zoom);
end;

procedure TfrmImgViewer.ClearAll;
begin
 TumbView.Clear;
 with PageView.IEBitmap do
 begin
  Height := 1;
  Width := 1;
  PixelFormat := ie24RGB;
  Canvas.Brush.Color := PageView.Background;
  Canvas.FillRect(Rect(0,0,113,113));
 end;
 PageView.UpdateNoPaint;
 PageView.Invalidate;

 edPageNum.Text := '0';
 edPageNum.Enabled := False;
 btnPageNext.Enabled := False;
 btnPagePrev.Enabled := False;
 btnZoomIn.Enabled := False;
 btnZoomOut.Enabled := False;
 btnSaveImage.Enabled := False;
 btnByWidth.Enabled := False;
 btnWholePage.Enabled := False;
 cbPercent.Enabled := False;
 f_GradualLoad := True;
end;

procedure TfrmImgViewer.ClearCurrent;
begin
 if TumbView.ImageCount = 1 then
  ClearAll
 else
 begin
  NoGradualLoad;
  TumbView.DeleteImage(TumbView.SelectedImage);
  TumbView.SelectedImage := TumbView.SelectedImage;
  RenumberPages;
  TumbView.Update;
 end;
end;

procedure TfrmImgViewer.edPageNumKeyPress(Sender: TObject; var Key: Char);
var
 lPage: Integer;
 TempStr: string;
 I : Integer;
begin
 if not (Key in [#8, #13, '0'..'9']) then
 begin
  Key := #0;
  Exit;
 end;
 if Key = #13 then
 begin
  try
   I := 1;
   while (I <= Length(edPageNum.Text)) and (edPageNum.Text[I] in [#9,' ']) do
    Inc(I);
   TempStr := '';
   while (I <= Length(edPageNum.Text)) and (edPageNum.Text[I] in ['0'..'9']) do
   begin
    TempStr := TempStr+edPageNum.Text[I];
    Inc(I);
   end;
   lPage := StrToInt(TempStr)-1;
  except
   MessageBeep(MB_ICONEXCLAMATION);
   lPage := TumbView.SelectedImage;
  end;
  if lPage > TumbView.ImageCount-1 then
   lPage := TumbView.ImageCount-1;
  TumbView.SelectedImage := lPage;
  //edPageNum.Text := IntToStr(lPage+1);
  UpdatePageNumEditText;
  with TumbView do
   ViewY := lPage*(ThumbHeight+VertBorder);
 end;
end;

procedure TfrmImgViewer.FrameResize(Sender: TObject);
begin
 UpdatePageView;
end;

procedure TfrmImgViewer.LoadFileAdd(const AFileName: string; const ARange: string);
var
 I, Idx: Integer;
 l_NumOfImages: Integer;
 l_Ext : string;
begin
 l_Ext := LowerCase(ExtractFileExt(aFileName));
 f_IsTIFF := (l_Ext = '.tif') or (l_Ext = '.tiff');
 if f_IsTIFF then
  l_NumOfImages := EnumTIFFIm(AFileName)
 else
  l_NumOfImages := 1;
 if l_NumOfImages = 0 then
  raise El3NoLoggedException.CreateFmt(sidTIFFFormatErr,[AFileName]);
 if TumbView.ImageCount > 0 then
  NoGradualLoad;
 f_FileName := AFileName;
 f_Range := ARange;
 if f_Range = '' then
  f_Range := '1-'+IntTostr(l_NumOfImages);
 if RM.CheckSource(f_Range) <> 0 then
  raise El3NoLoggedException.CreateFmt(sidDefDiapasonErr,[f_Range, AFileName]);
 RM.SrcString := f_Range;
 RM.Confine(1, l_NumOfImages);
 if RM.Count = 0 then
  raise El3NoLoggedException.CreateFmt(sidWrongPageDiapason, [AFileName]);
 TumbView.ThumbnailResampleFilter := rfFastLinear;
 ImgLoader.AttachedBitmap := f_Bitmap;
 TumbProc.AttachedBitmap := f_Bitmap;
 for I := 1 to RM.Count do
 begin
  Idx := TumbView.AppendImage;
  if (not f_GradualLoad) then 
   LoadTumbnail(Idx,I)
 end;
 RenumberPages;
 ResizeThumbnails;
 UpdatePageNumEditText;
 edPageNum.Enabled := True;
 btnZoomIn.Enabled := True;
 btnZoomOut.Enabled := True;
 btnSaveImage.Enabled := True;
 btnByWidth.Enabled := True;
 btnWholePage.Enabled := True;
 TumbView.OnImageSelect := TumbViewImageSelect;
 TumbView.SelectedImage := 0;
 cbPercent.Enabled := True;
 AdjustPercentCB;
end;

procedure TfrmImgViewer.LoadFileNew(AFileName: string; ARange: string);
begin
 ClearAll;
 LoadFileAdd(AFileName, ARange);
 btnWholePage.Click;
end;

procedure TfrmImgViewer.LoadTumbnail(TumbIdx, RMIdx: Integer);
begin
 Screen.Cursor := crHourGlass;
 try
  if f_IsTIFF then
   ImgLoader.Params.TIFF_ImageIndex := RM[RMIdx]-1;
  ImgLoader.LoadFromFileFormat{TIFF}(f_FileName, ioUnknown);
  TumbProc.Resample(TumbView.ThumbWidth, TumbView.ThumbHeight, rfLanczos3);
  TumbView.SetImageEx(TumbIdx, f_Bitmap);
 finally
  Screen.Cursor := crDefault;
 end;
end;

procedure TfrmImgViewer.NoGradualLoad;
var
 I: Integer;
begin
 if not f_GradualLoad then
  Exit;
 for I := 0 to TumbView.ImageCount-1 do
  if TumbView.ImageWidth[I] = 0 then
   LoadTumbnail(I, I+1);
 f_GradualLoad := False;
end;

procedure TfrmImgViewer.PageViewViewChange(Sender: TObject;
  Change: Integer);
begin
 if cbPercent.ItemIndex < cbPercent.Items.Count-2 then
  AdjustPercentCB;
end;

function TfrmImgViewer.ParsePercent(const S: string; Default: Double): Double;
var
 X: Integer;
 STmp: string;
begin
 STmp := S;
 X := Pos('%',STmp);
 while X <> 0 do
 begin
  Delete(STmp, X, 1);
  X := Pos('%',STmp);
 end;
 try
  Result := StrToFloat(STmp);
 except
  Result := Default;
  MessageDlg('Ошибка в написании числа!', mtError, [mbOK], 0);
 end;
end;

procedure TfrmImgViewer.Print;
var
 I: Integer;
 PFrom, PTo: Integer;
begin
 with PrintDialog do
 begin
  MaxPage := RM.Count;
  PrintRange := prAllPages;
  Copies := 1;
  if Execute then
  begin
   case PrintRange of
    prAllPages:
     begin
      PFrom := 0;
      PTo := RM.Count-1;
     end;
    prSelection:
     begin
      PFrom := TumbView.SelectedImage;
      PTo := PFrom;
     end;
    prPageNums:
     begin
      PFrom := FromPage-1;
      PTo := ToPage-1;
     end;
   end; // case
   Printer.BeginDoc;
   try
    for I := PFrom to PTo do
    begin
     ImgLoader.Params.TIFF_ImageIndex := RM[I+1] - 1;
     ImgLoader.LoadFromFileFormat(f_FileName, ioUnknown);
     ImgLoader.PrintImage(Printer.Canvas, 0.2, 0.2, 0.2, 0.2);
     if I <> PTo then
      Printer.NewPage;
    end;
   finally
    Printer.EndDoc;
   end;
  end;
 end;
end;

procedure TfrmImgViewer.RenumberPages;
var
 I: Integer;
begin
 for I := 0 to TumbView.ImageCount-1 do
  TumbView.ImageBottomText[I].Caption := IntToStr(I+1);
end;

procedure TfrmImgViewer.ResizeThumbnails;
var
 I: Integer;
 l_Bmp: TBitmap;
begin
 with TumbView do
 begin
  l_Bmp := TBitmap.Create;
  try
   for I := 0 to ImageCount-1 do
    SetImage(I, l_Bmp);
  finally
   FreeAndNil(l_Bmp);
  end;

  Screen.Cursor := crHourGlass;
  try
   if f_IsTIFF then
    ImgLoader.Params.TIFF_ImageIndex := RM[1]-1;
   ImgLoader.LoadFromFileFormat(f_FileName, ioUnknown);
   ThumbWidth := ClientWidth - 35;
   ThumbHeight := Round(f_Bitmap.Height * (ThumbWidth/f_Bitmap.Width));
  finally
   Screen.Cursor := crDefault;
  end;
 end;
end;

procedure TfrmImgViewer.SaveAllToSingleTIFF(const AFileName: string);
var
 I: Integer;
 l_Dlg: TddSimpleProgressDialog;
 l_PercentDone: Integer;
begin
 l_Dlg := TddSimpleProgressDialog.Create(nil);
 try
  l_Dlg.Caption := 'Запись графического образа документа';
  l_Dlg.Show;
  l_Dlg.Update;
  for I := 1 to RM.Count do
  begin
   ImgLoader.Params.TIFF_ImageIndex := RM[I] - 1;
   ImgLoader.LoadFromFileFormat(f_FileName, ioUnknown);
   ImgLoader.Params.TIFF_Compression := ioTIFF_G4FAX;
   ImgLoader.Params.TIFF_ImageIndex := I-1;
   if I > 1 then
    ImgLoader.InsertToFileTIFF(AFileName)
   else
    ImgLoader.SaveToFileTIFF(AFileName);
   l_PercentDone := Round(I/RM.Count*100);
   l_Dlg.UpdateProc(Self, l_PercentDone);
  end;
 finally
  FreeAndNil(l_Dlg);
 end;
end;

procedure TfrmImgViewer.Splitter1CanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
 if NewSize < 100 then
  NewSize := 100;
end;

procedure TfrmImgViewer.Splitter1Moved(Sender: TObject);
begin
 ResizeThumbnails;
 UpdatePageView;
end;

procedure TfrmImgViewer.TumbViewBeforeImageDraw(Sender: TObject; idx, Left,
  Top: Integer; Canvas: TCanvas);
begin
 if TumbView.ImageWidth[Idx] = 0 then
  LoadTumbnail(Idx, Idx+1);
end;

procedure TfrmImgViewer.TumbViewImageSelect(Sender: TObject; idx: Integer);
begin
 if f_IsTIFF then
  ImgLoader.Params.TIFF_ImageIndex := RM[idx+1]-1;
 ImgLoader.LoadFromFileFormat(f_FileName, ioUnknown);
 PageView.IEBitmap.Assign(f_Bitmap);
 PageView.UpdateNoPaint;
 if btnByWidth.Down then
  PageView.FitToWidth
 else
  if btnWholePage.Down then
   PageView.Fit
  else
   PageView.Update;
 UpdatePageNumEditText;
 btnPagePrev.Enabled := idx > 0;
 btnPageNext.Enabled := idx < RM.Count-1;
 UpdatePageView;
end;

procedure TfrmImgViewer.UpdatePageNumEditText;
begin
 edPageNum.Text := IntToStr(TumbView.SelectedImage+1)+' из '+IntToStr(RM.Count);
end;

procedure TfrmImgViewer.UpdatePageView;
begin
 if TumbView.ImageCount <> 0 then
 begin
  if cbPercent.ItemIndex = cbPercent.Items.Count-2 then
   PageView.FitToWidth;
  if cbPercent.ItemIndex = cbPercent.Items.Count-1 then
   PageView.Fit;
 end;
end;

procedure TfrmImgViewer.ExportToFile(FileType: TExpFileType);
var
 NewH: Integer;
 NewW: Integer;
 I: Integer;
 sFileName: string;
 IO: TImageEnIO;
 Proc: TImageEnProc;
 BMP: TBitmap;
begin
 if not Assigned(FOnExportGetFileName) then
  raise Exception.Create('TfrmImgViewer: Не определен ExportGetFileName');
 NoGradualLoad;
 IO := TImageEnIO.Create(nil);
 if FileType = eftGIF then
  Proc := TImageEnProc.Create(nil);
 BMP := TBitmap.Create;
 try
  for I := 0 to Pred(RM.Count) do
  begin
   sFileName := FOnExportGetFileName(I+1, RM[I+1]);
   BMP.Assign(TumbView.GetBitmap(I));
   TumbView.ReleaseBitmap(I);
   IO.Bitmap := BMP;
   case FileType of
    eftTIF:
     begin
      sFileName := sFileName+'.tif';
      IO.Params.TIFF_Compression := ioTIFF_G4FAX;
      IO.SaveToFileTIFF(sFileName);
     end;
    eftGIF:
     begin
      sFileName := sFileName+'.gif';
      Proc.AttachedBitmap := IO.Bitmap;
      if IO.Bitmap.Width <= 950 then
       NewW := IO.Bitmap.Width
      else
       NewW := 950;
      if NewW <> IO.Bitmap.Width then
      begin
       NewH := Round(IO.Bitmap.Height * (NewW/IO.Bitmap.Width));
       Proc.Resample(NewW, NewH, rfBicubic);
      end;
      IO.Params.GIF_Interlaced := False;
      IO.Params.BitsPerSample := 3;
      IO.Params.SamplesPerPixel := 1;
      IO.SaveToFileGIF(sFileName);
     end;
   end;
  end;
 finally
  IO.Free;
  if FileType = eftGIF then
   Proc.Free;
  BMP.Free;
 end;
end;

procedure TfrmImgViewer.btnSaveImageClick(Sender: TObject);
begin
 if IniRec.ExecuteSaveDialog(SaveDialog) then
  SaveAllToSingleTIFF(SaveDialog.FileName);
end;

initialization
 DefTIFF_LZWDECOMPFUNC:=TIFFLZWDecompress;
 DefTIFF_LZWCOMPFUNC:=TIFFLZWCompress;
 DefGIF_LZWDECOMPFUNC:= GIFLZWDecompress;
 DefGIF_LZWCOMPFUNC:= GIFLZWCompress;
end.
