unit vtNFPngImgListEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, vtPngImgList, OvcBase, vtLister, TB97Ctls,
  vtCtrls, Buttons, vtSpeedButton, tb97GraphicControl, afwControl,
  afwInputControl, ExtCtrls, l3Interfaces, l3InternalInterfaces;

type
 TvtNFPngImageListEditForm = class(TForm)
    btn24: TvtSpeedButton;
    btn4: TvtSpeedButton;
    btn8: TvtSpeedButton;
    btnAdd: TButton;
    btnClose: TButton;
    btnDelete: TButton;
    btnShiftDown: TSpeedButton;
    btnShiftUp: TSpeedButton;
    dlgOpen: TOpenDialog;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lsImages: TvtLister;
    btnSave: TButton;
    btnSaveAll: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure btn24CustomGlyphDraw(Sender: TObject; const aCanvas: Il3Canvas;
      aRect: TRect; aState: TButtonState97);
    procedure btn4CustomGlyphDraw(Sender: TObject; const aCanvas: Il3Canvas;
      aRect: TRect; aState: TButtonState97);
    procedure btn8CustomGlyphDraw(Sender: TObject; const aCanvas: Il3Canvas;
      aRect: TRect; aState: TButtonState97);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnShiftDownClick(Sender: TObject);
    procedure btnShiftUpClick(Sender: TObject);
    procedure LoadImage(Sender: TObject);
    procedure lsImagesCurrentChanged(Sender: TObject; aNewCurrent,
      aOldCurrent: Integer);
    function lsImagesGetItemImageIndex(Sender: TObject;
      Index: Integer): Integer;
    procedure lsImagesGetStrItem(Sender: TObject; Index: Integer;
      var ItemString: Il3CString);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSaveAllClick(Sender: TObject);
 private
    FCurDir: string;
    FNewItem: Integer;
    FPngImgList: TvtNonFixedPngImageList;
    procedure CheckDeleteButton;
    procedure SetPngImgList(const Value: TvtNonFixedPngImageList);
 public
    constructor Create(AOwner: TComponent); override;
    property PngImgList: TvtNonFixedPngImageList read FPngImgList write SetPngImgList;
 end;

var
  vtPngImageListEditForm: TvtNFPngImageListEditForm;

implementation

uses FileCtrl, IniFiles, ImgList, l3Base, hyieutils, imageenio, hyiedefs, vtInterfaces;

{$R *.dfm}

resourcestring
 SImagelistIni = 'imagelist.ini';

const
 cSBpp  : array[bpp24..bpp4] of string = ('true', '256', '16');

constructor TvtNFPngImageListEditForm.Create(AOwner: TComponent);
begin
 inherited;
 FPngImgList := nil;
 FNewItem := -1;
 FCurDir := GetCurrentDir;
end;

procedure TvtNFPngImageListEditForm.btn24CustomGlyphDraw(Sender: TObject;
  const aCanvas: Il3Canvas; aRect: TRect; aState: TButtonState97);
begin
 FPngImgList.DrawGlyphSpecified(lsImages.Current, aCanvas, bpp24, aRect.Left, aRect.Top, True);
end;

procedure TvtNFPngImageListEditForm.btn4CustomGlyphDraw(Sender: TObject;
  const aCanvas: Il3Canvas; aRect: TRect; aState: TButtonState97);
begin
 FPngImgList.DrawGlyphSpecified(lsImages.Current, aCanvas, bpp4, aRect.Left, aRect.Top, True);
end;

procedure TvtNFPngImageListEditForm.btn8CustomGlyphDraw(Sender: TObject;
  const aCanvas: Il3Canvas; aRect: TRect; aState: TButtonState97);
begin
 FPngImgList.DrawGlyphSpecified(lsImages.Current, aCanvas, bpp8, aRect.Left, aRect.Top, True);
end;

procedure TvtNFPngImageListEditForm.btnAddClick(Sender: TObject);
var
 I: Integer;
 lJumpTo: Integer;
begin
 FPngImgList.AddItem;
 if (lsImages.Total > 1) and (lsImages.Current < lsImages.Total-1) then
 begin
  for I := FPngImgList.Count-1 downto lsImages.Current+2 do
   FPngImgList.Exchange(I, I-1);
  lJumpTo := lsImages.Current+1;
 end
 else
  lJumpTo := FPngImgList.Count-1;
 lsImages.Total := FPngImgList.Count;
 lsImages.Current := lJumpTo;
 FNewItem := lJumpTo;
 CheckDeleteButton;
end;

procedure TvtNFPngImageListEditForm.btnDeleteClick(Sender: TObject);
begin
 FPngImgList.Delete(lsImages.Current);
 lsImages.Total := FPngImgList.Count;
 CheckDeleteButton;
end;

procedure TvtNFPngImageListEditForm.btnShiftDownClick(Sender: TObject);
begin
 FPngImgList.Exchange(lsImages.Current, lsImages.Current+1);
 lsImages.Current := lsImages.Current+1;
 lsImages.Invalidate;
 FNewItem := -1;
end;

procedure TvtNFPngImageListEditForm.btnShiftUpClick(Sender: TObject);
begin
 FPngImgList.Exchange(lsImages.Current, lsImages.Current-1);
 lsImages.Current := lsImages.Current-1;
 lsImages.Invalidate;
 FNewItem := -1;
end;

procedure TvtNFPngImageListEditForm.CheckDeleteButton;
begin
 btnDelete.Enabled := (FPngImgList <> nil) and (FPngImgList.Count > 0);
 btn24.Enabled := btnDelete.Enabled;
 btn8.Enabled := btnDelete.Enabled;
 btn4.Enabled := btnDelete.Enabled;
end;

procedure TvtNFPngImageListEditForm.LoadImage(Sender: TObject);
var
 I: Integer;
 Idx: Integer;

 function IsSameColor(C1, C2: TRGB): Boolean;
 begin
  Result := (C1.b = C2.b) and (C1.g = C2.g) and (C1.r = C2.r);
 end;

 procedure LoadOneImage(Index: Integer; aBpp: TvtPILBpp; const aFileName: string);
 type
  TlColCounRec = record
   Color: TRGB;
   Count: Integer;
  end;
 var
  lBpp: TvtPILBpp;
  I, J: Integer;
  IO: TImageEnIO;
  lBMP: TIEBitmap;
  lTmpCol: array[1..4] of TlColCounRec;
  TransColor: TRGB;

  procedure AddColorToList(aColor: TRGB);
  var
   I: Integer;
  begin
   for I := 1 to 4 do
    if IsSameColor(lTmpCol[I].Color, aColor) then
    begin
     Inc(lTmpCol[I].Count);
     Break;
    end
    else
     if lTmpCol[I].Count = 0 then
     begin
      lTmpCol[I].Color := aColor;
      Inc(lTmpCol[I].Count);
      Break;
     end;
  end;

  function FrequentColor: TRGB;
  var
   lMaxCount: Integer;
   I, TargetIdx: Integer;
  begin
   lMaxCount := 0;
   TargetIdx := High(TargetIdx);
   // - чтобы компилятор не выебывался
   for I := 1 to 4 do
   begin
    if lMaxCount < lTmpCol[I].Count then
    begin
     lMaxCount := lTmpCol[I].Count;
     TargetIdx := I;
    end
   end;
   Result := lTmpCol[TargetIdx].Color;
  end;

  function IsAnyTransparentPix(aBM: TIEBitmap): Boolean;
  var
   J: Integer;
   I: Integer;
  begin
   Result := False;
   if aBM.HasAlphaChannel then
    for I := 0 to aBM.Width-1 do
     for J := 0 to aBM.Height-1 do
      if aBM.Alpha[I,J] < 255 then
      begin
       Result := True;
       Exit;
      end;
  end;

 begin
  lBMP := TIEBitmap.Create;
  IO := TImageEnIO.Create(nil);
  try
   IO.AttachedIEBitmap := lBMP;
   IO.LoadFromFile(aFileName);
   if not IsAnyTransparentPix(lBMP) then
   begin
    l3FillChar(lTmpCol, SizeOf(lTmpCol), 0);
    AddColorToList(lBMP.Pixels[0,0]);
    AddColorToList(lBMP.Pixels[lBMP.Width-1,0]);
    AddColorToList(lBMP.Pixels[0,lBMP.Height-1]);
    AddColorToList(lBMP.Pixels[lBMP.Width-1,lBMP.Height-1]);
    TransColor := FrequentColor;
    for I := 0 to lBMP.Width-1 do
     for J := 0 to lBMP.Height-1 do
      if IsSameColor(lBMP.Pixels[I,J], TransColor) then
       lBMP.Alpha[I,J] := 0;
   end;
   FPngImgList.AddImage(Index, aBpp, lBMP);
   if Index = FNewItem then
   begin
    for lBpp := bpp24 to bpp4 do
     if lBpp <> aBpp then
      FPngImgList.AddImage(Index, lBpp, lBMP);
    FNewItem := -1;
   end;
  finally
   IO.Free;
   lBMP.Free;
  end;
 end;

 begin
 if dlgOpen.Execute then
 begin
  Idx := lsImages.Current;
  TStringList(dlgOpen.Files).Sort;
  for I := Idx to Idx+dlgOpen.Files.Count-1 do
  begin
   if I >= FPngImgList.Count then
   begin
    FPngImgList.AddItem;
    FNewItem := FPngImgList.Count-1;
   end;
   if Sender = btn24 then
    LoadOneImage(I, bpp24, dlgOpen.Files[I-Idx]);
   if Sender = btn8 then
    LoadOneImage(I, bpp8, dlgOpen.Files[I-Idx]);
   if Sender = btn4 then
    LoadOneImage(I, bpp4, dlgOpen.Files[I-Idx]);
  end;
  lsImages.Total := FPngImgList.Count;
  lsImages.Invalidate;
  Invalidate;
 end;
end;


procedure TvtNFPngImageListEditForm.lsImagesCurrentChanged(Sender: TObject;
  aNewCurrent, aOldCurrent: Integer);
begin
 btn24.Invalidate;
 btn8.Invalidate;
 btn4.Invalidate;
 btnShiftUp.Enabled := lsImages.Current > 0;
 btnShiftDown.Enabled := lsImages.Current < FPngImgList.Count-1; 
end;

function TvtNFPngImageListEditForm.lsImagesGetItemImageIndex(Sender: TObject;
  Index: Integer): Integer;
begin
 Result := Index;
end;

procedure TvtNFPngImageListEditForm.lsImagesGetStrItem(Sender: TObject;
  Index: Integer; var ItemString: Il3CString);
begin
 ItemString := l3CStr(IntToStr(Index));
end;

procedure TvtNFPngImageListEditForm.SetPngImgList(const Value: TvtNonFixedPngImageList);
begin
 if FPngImgList <> Value then
 begin
  FPngImgList := Value;
  lsImages.Images := FPngImgList;
  lsImages.Total := FPngImgList.Count;
  Caption := FPngImgList.Name;
  CheckDeleteButton;
 end;
end;

procedure TvtNFPngImageListEditForm.btnSaveClick(Sender: TObject);
var
 l_Bpp : TvtPILBpp;
 l_FName: string;
begin
 if SelectDirectory('Выберите папку','',FCurDir) then
 begin
  for l_Bpp := bpp24 to bpp4 do
  begin
   l_FName := Format('%.4d_%s.png', [lsImages.Current, cSBpp[l_Bpp]]);
   FPngImgList.SaveImage(IncludeTrailingPathDelimiter(FCurDir)+l_FName,
     lsImages.Current, l_Bpp);
  end;
 end;
end;

procedure TvtNFPngImageListEditForm.btnSaveAllClick(Sender: TObject);
var
 l_Bpp : TvtPILBpp;
 l_FName: string;
 I : Integer;
 l_Script: TIniFile;
begin
 if SelectDirectory('Выберите папку','',FCurDir) then
 begin
  FCurDir := IncludeTrailingPathDelimiter(FCurDir);
  if FileExists(FCurDir+SImagelistIni) then
   DeleteFile(FCurDir+SImagelistIni);
  l_Script := TIniFile.Create(FCurDir+SImagelistIni);
  try
   l_Script.WriteInteger('Settings', 'Count', lsImages.Total);
   for I := 0 to Pred(lsImages.Total) do
    for l_Bpp := bpp24 to bpp4 do
    begin
     l_FName := Format('%.4d_%s.png', [I, cSBpp[l_Bpp]]);
     FPngImgList.SaveImage(FCurDir+l_FName, I, l_Bpp);
     l_Script.WriteString(Format('Image%d',[I]), Format('%s', [cSBpp[l_Bpp]]), l_FName);
    end;
  finally
   l3Free(l_Script);
  end;
 end;
end;

end.
