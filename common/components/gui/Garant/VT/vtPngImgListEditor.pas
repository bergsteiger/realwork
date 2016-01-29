unit vtPngImgListEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, vtPngImgList, OvcBase, vtLister, TB97Ctls,
  vtCtrls, Buttons, vtSpeedButton, tb97GraphicControl, afwControl,
  afwInputControl, ExtCtrls, l3Interfaces, l3InternalInterfaces,
  vtInterfaces
  ;

type
 TvtPngImageListEditForm = class(TForm)
    dlgOpen: TOpenDialog;
    pnlBottom: TPanel;
    pnlRight: TPanel;
    pnlClient: TPanel;
    btnShiftUp: TSpeedButton;
    btnShiftDown: TSpeedButton;
    btnSaveAll: TButton;
    btnSave: TButton;
    btnDelete: TButton;
    btnCorrect: TSpeedButton;
    btnAdd: TButton;
    btn32_8: TvtSpeedButton;
    btn32_4: TvtSpeedButton;
    btn32_24: TvtSpeedButton;
    btn16_8: TvtSpeedButton;
    btn16_4: TvtSpeedButton;
    btn16_24: TvtSpeedButton;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    btnClose: TButton;
    lsImages: TvtLister;
    btnLoad: TButton;
    Bevel1: TBevel;
    btn24_8: TvtSpeedButton;
    btn24_4: TvtSpeedButton;
    btn24_24: TvtSpeedButton;
    Label6: TLabel;
    btnCopySizedImg: TButton;
    procedure btn16_24CustomGlyphDraw(Sender: TObject; const aCanvas: Il3Canvas;
      aRect: TRect; aState: TButtonState97);
    procedure btn16_4CustomGlyphDraw(Sender: TObject; const aCanvas: Il3Canvas;
      aRect: TRect; aState: TButtonState97);
    procedure btn16_8CustomGlyphDraw(Sender: TObject; const aCanvas: Il3Canvas;
      aRect: TRect; aState: TButtonState97);
    procedure btn32_24CustomGlyphDraw(Sender: TObject; const aCanvas: Il3Canvas;
      aRect: TRect; aState: TButtonState97);
    procedure btn32_4CustomGlyphDraw(Sender: TObject; const aCanvas: Il3Canvas;
      aRect: TRect; aState: TButtonState97);
    procedure btn32_8CustomGlyphDraw(Sender: TObject; const aCanvas: Il3Canvas;
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
    procedure btnCorrectClick(Sender: TObject);
    procedure btnSaveAllClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btn24_24CustomGlyphDraw(Sender: TObject;
      const aCanvas: Il3Canvas; aRect: TRect; aState: TButtonState97);
    procedure btn24_8CustomGlyphDraw(Sender: TObject;
      const aCanvas: Il3Canvas; aRect: TRect; aState: TButtonState97);
    procedure btn24_4CustomGlyphDraw(Sender: TObject;
      const aCanvas: Il3Canvas; aRect: TRect; aState: TButtonState97);
    procedure btnCopySizedImgClick(Sender: TObject);
 private
    FCurDir: string;
    FNewItem: Integer;
    FPngImgList: TvtPngImageList;
    procedure CheckDeleteButton;
    procedure InvalidateButtons;
    procedure SetPngImgList(Value: TvtPngImageList);
    procedure RebuildDesignTimeList(Sender: TObject; var Action: TCloseAction);
    procedure LoadOneImage(Index: Integer; aSize: TvtPILSize; aBpp: TvtPILBpp; const aFileName: string);
 public
    constructor Create(AOwner: TComponent); override;
    property PngImgList: TvtPngImageList read FPngImgList write SetPngImgList;
 end;

var
  vtPngImageListEditForm: TvtPngImageListEditForm;

implementation

uses FileCtrl, IniFiles, ImgList, l3Base, hyieutils, imageenio, hyiedefs,
 vtPILSizedImgCopyDlg,
 vtPngImgListUtils
 ;

resourcestring
 SImagelistIni = 'imagelist.ini';

{$R *.dfm}

const
 cSSize : array[ps16x16..ps24x24] of string = ('16x16', '32x32', '24x24');
 cSBpp  : array[bpp24..bpp4] of string = ('true', '256', '16');

constructor TvtPngImageListEditForm.Create(AOwner: TComponent);
begin
 inherited;
 FPngImgList := nil;
 FNewItem := -1;
 FCurDir := GetCurrentDir;
 OnClose := RebuildDesignTimeList;
end;

procedure TvtPngImageListEditForm.btn16_24CustomGlyphDraw(Sender: TObject;
  const aCanvas: Il3Canvas; aRect: TRect; aState: TButtonState97);
begin
 FPngImgList.DrawGlyphSpecified(lsImages.Current, aCanvas, ps16x16, bpp24, aRect.Left, aRect.Top, True);
end;

procedure TvtPngImageListEditForm.btn16_4CustomGlyphDraw(Sender: TObject;
  const aCanvas: Il3Canvas; aRect: TRect; aState: TButtonState97);
begin
 FPngImgList.DrawGlyphSpecified(lsImages.Current, aCanvas, ps16x16, bpp4, aRect.Left, aRect.Top, True);
end;

procedure TvtPngImageListEditForm.btn16_8CustomGlyphDraw(Sender: TObject;
  const aCanvas: Il3Canvas; aRect: TRect; aState: TButtonState97);
begin
 FPngImgList.DrawGlyphSpecified(lsImages.Current, aCanvas, ps16x16, bpp8, aRect.Left, aRect.Top, True);
end;

procedure TvtPngImageListEditForm.btn32_24CustomGlyphDraw(Sender: TObject;
  const aCanvas: Il3Canvas; aRect: TRect; aState: TButtonState97);
begin
 FPngImgList.DrawGlyphSpecified(lsImages.Current, aCanvas, ps32x32, bpp24, aRect.Left, aRect.Top, True);
end;

procedure TvtPngImageListEditForm.btn32_4CustomGlyphDraw(Sender: TObject;
  const aCanvas: Il3Canvas; aRect: TRect; aState: TButtonState97);
begin
 FPngImgList.DrawGlyphSpecified(lsImages.Current, aCanvas, ps32x32, bpp4, aRect.Left, aRect.Top, True);
end;

procedure TvtPngImageListEditForm.btn32_8CustomGlyphDraw(Sender: TObject;
  const aCanvas: Il3Canvas; aRect: TRect; aState: TButtonState97);
begin
 FPngImgList.DrawGlyphSpecified(lsImages.Current, aCanvas, ps32x32, bpp8, aRect.Left, aRect.Top, True);
end;

procedure TvtPngImageListEditForm.btnAddClick(Sender: TObject);
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

procedure TvtPngImageListEditForm.btnDeleteClick(Sender: TObject);
begin
 FPngImgList.Delete(lsImages.Current);
 lsImages.Total := FPngImgList.Count;
 CheckDeleteButton;
end;

procedure TvtPngImageListEditForm.btnShiftDownClick(Sender: TObject);
begin
 FPngImgList.Exchange(lsImages.Current, lsImages.Current+1);
 lsImages.Current := lsImages.Current+1;
 lsImages.Invalidate;
 FNewItem := -1;
end;

procedure TvtPngImageListEditForm.btnShiftUpClick(Sender: TObject);
begin
 FPngImgList.Exchange(lsImages.Current, lsImages.Current-1);
 lsImages.Current := lsImages.Current-1;
 lsImages.Invalidate;
 FNewItem := -1;
end;

procedure TvtPngImageListEditForm.CheckDeleteButton;
begin
 btnDelete.Enabled := (FPngImgList <> nil) and (FPngImgList.Count > 0);
 btn16_24.Enabled := btnDelete.Enabled and (ps16x16 in FPngImgList.AvailableSizes);
 btn16_8.Enabled := btnDelete.Enabled and (ps16x16 in FPngImgList.AvailableSizes);
 btn16_4.Enabled := btnDelete.Enabled and (ps16x16 in FPngImgList.AvailableSizes);
 btn32_24.Enabled := btnDelete.Enabled and (ps32x32 in FPngImgList.AvailableSizes);
 btn32_8.Enabled := btnDelete.Enabled and (ps32x32 in FPngImgList.AvailableSizes);
 btn32_4.Enabled := btnDelete.Enabled and (ps32x32 in FPngImgList.AvailableSizes);
end;

procedure TvtPngImageListEditForm.LoadOneImage(Index: Integer; aSize: TvtPILSize; aBpp: TvtPILBpp; const aFileName: string);
type
 TlColCounRec = record
  Color: TRGB;
  Count: Integer;
 end;
var
 lBpp: TvtPILBpp;
 lSize: TvtPILSize;
 I, J: Integer;
 IO: TImageEnIO;
 lBMP, lBMP2: TIEBitmap;
 lTmpCol: array[1..4] of TlColCounRec;
 TransColor: TRGB;

 function IsSameColor(C1, C2: TRGB): Boolean;
 begin
  Result := (C1.b = C2.b) and (C1.g = C2.g) and (C1.r = C2.r);
 end;

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
  TargetIdx := High(TargetIdx);
  // - чтобы компилятор не выебывался
  lMaxCount := 0;
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
  FPngImgList.AddImage(Index, aSize, aBpp, lBMP);

  if Index = FNewItem then
  begin
   for lBpp := Low(TvtPILBpp) to High(TvtPILBpp) do
    if lBpp <> aBpp then
     FPngImgList.AddImage(Index, aSize, lBpp, lBMP);

   for lSize := Low(TvtPILSize) to High(TvtPILSize) do
    if lSize <> aSize then
    begin
     lBMP2 := TIEBitmap.Create;
     try
      with lBMP2 do
      begin
       Width := PILSize[lSize];
       Height := PILSize[lSize];
       PixelFormat := ie24RGB;
       Alpha[0,0] := 255;
      end;
      lBMP.StretchRectTo(lBMP2, 0, 0, PILSize[lSize], PILSize[lSize], 0, 0,
          lBMP.Width, lBMP.Height, rfBicubic, 255);
      for lBpp := Low(TvtPILBpp) to High(TvtPILBpp) do
       FPngImgList.AddImage(Index, lSize, lBpp, lBMP2);
     finally
      lBMP2.Free;
     end; {try..finally}
    end;
   FNewItem := -1;
   InvalidateButtons;
  end;
 finally
  IO.Free;
  lBMP.Free;
 end;
end;

procedure TvtPngImageListEditForm.LoadImage(Sender: TObject);
var
 I: Integer;
 Idx: Integer;

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
   if Sender = btn16_24 then
    LoadOneImage(I, ps16x16, bpp24, dlgOpen.Files[I-Idx]);
   if Sender = btn24_24 then
    LoadOneImage(I, ps24x24, bpp24, dlgOpen.Files[I-Idx]);
   if Sender = btn32_24 then
    LoadOneImage(I, ps32x32, bpp24, dlgOpen.Files[I-Idx]);
   if Sender = btn16_8 then
    LoadOneImage(I, ps16x16, bpp8, dlgOpen.Files[I-Idx]);
   if Sender = btn24_8 then
    LoadOneImage(I, ps24x24, bpp8, dlgOpen.Files[I-Idx]);
   if Sender = btn32_8 then
    LoadOneImage(I, ps32x32, bpp8, dlgOpen.Files[I-Idx]);
   if Sender = btn16_4 then
    LoadOneImage(I, ps16x16, bpp4, dlgOpen.Files[I-Idx]);
   if Sender = btn24_4 then
    LoadOneImage(I, ps24x24, bpp4, dlgOpen.Files[I-Idx]);
   if Sender = btn32_4 then
    LoadOneImage(I, ps32x32, bpp4, dlgOpen.Files[I-Idx]);
  end;
  lsImages.Total := FPngImgList.Count;
  lsImages.FullRedraw;
  Invalidate;
 end;
end;


procedure TvtPngImageListEditForm.lsImagesCurrentChanged(Sender: TObject;
  aNewCurrent, aOldCurrent: Integer);
begin
 InvalidateButtons;
 btnShiftUp.Enabled := lsImages.Current > 0;
 btnShiftDown.Enabled := lsImages.Current < FPngImgList.Count-1; 
end;

function TvtPngImageListEditForm.lsImagesGetItemImageIndex(Sender: TObject;
  Index: Integer): Integer;
begin
 Result := Index;
end;

procedure TvtPngImageListEditForm.lsImagesGetStrItem(Sender: TObject;
  Index: Integer; var ItemString: Il3CString);
begin
 ItemString := l3CStr(IntToStr(Index));
end;

procedure TvtPngImageListEditForm.SetPngImgList(Value: TvtPngImageList);
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

procedure TvtPngImageListEditForm.btnSaveClick(Sender: TObject);
var
 l_Size: TvtPILSize;
 l_Bpp : TvtPILBpp;
 l_FName: string;
begin
 if SelectDirectory('Выберите папку','',FCurDir) then
 begin
  for l_Size := Low(TvtPILSize) to High(TvtPILSize) do
   if l_Size in FPngImgList.AvailableSizes then
    for l_Bpp := Low(TvtPILBpp) to High(TvtPILBpp) do
    begin
     l_FName := Format('%.4d_%s_%s.png', [lsImages.Current, cSSize[l_Size], cSBpp[l_Bpp]]);
     FPngImgList.SaveImage(IncludeTrailingPathDelimiter(FCurDir)+l_FName,
       lsImages.Current, l_Size, l_Bpp);
    end;
 end;
end;

procedure TvtPngImageListEditForm.btnCorrectClick(Sender: TObject);
begin
 FPngImgList.RepairSizes;
 lsImages.Total := FPngImgList.Count;
end;

procedure TvtPngImageListEditForm.RebuildDesignTimeList(Sender: TObject; var Action: TCloseAction);
begin
 {$IFDEF DesignTimeLibrary}
// FPngImgList.RebuildForDesignTime;
 {$ENDIF}
end;

procedure TvtPngImageListEditForm.btnSaveAllClick(Sender: TObject);
var
 l_Size: TvtPILSize;
 l_Bpp : TvtPILBpp;
 l_FName: string;
 I : Integer;
 l_Script: TIniFile;
 l_SAvailSizes: string;
begin
 if SelectDirectory(FCurDir, [sdAllowCreate, sdPerformCreate, sdPrompt], 0) then
 begin
  Screen.Cursor := crHourGlass;
  try
   FCurDir := IncludeTrailingPathDelimiter(FCurDir);
   if FileExists(FCurDir+SImagelistIni) then
    DeleteFile(FCurDir+SImagelistIni);
   l_Script := TIniFile.Create(FCurDir+SImagelistIni);
   try
    l_SAvailSizes := '';
 
    for l_Size := Low(TvtPILSize) to High(TvtPILSize) do
    begin
     if l_Size in FPngImgList.AvailableSizes then
     begin
      if l_SAvailSizes <> '' then
       l_SAvailSizes := l_SAvailSizes + ', ';
      l_SAvailSizes := l_SAvailSizes + cSSize[l_Size];
     end;
    end;
    l_Script.WriteString('Settings', 'Sizes', l_SAvailSizes);
    l_Script.WriteInteger('Settings', 'Count', lsImages.Total);
    for l_Size := Low(TvtPILSize) to High(TvtPILSize) do
     if l_Size in FPngImgList.AvailableSizes then
      for I := 0 to Pred(lsImages.Total) do
       for l_Bpp := Low(TvtPILBpp) to High(TvtPILBpp) do
       begin
        l_FName := Format('%.4d_%s_%s.png', [I, cSSize[l_Size], cSBpp[l_Bpp]]);
        FPngImgList.SaveImage(FCurDir+l_FName,
          I, l_Size, l_Bpp);
        l_Script.WriteString(Format('Image%d',[I]), Format('%s_%s', [cSSize[l_Size], cSBpp[l_Bpp]]), l_FName);
       end;
   finally
    l3Free(l_Script);
   end;
  finally
   Screen.Cursor := crDefault;
  end;
 end;
end;

procedure TvtPngImageListEditForm.btnLoadClick(Sender: TObject);
var
 l_Script: TIniFile;
 l_Count : Integer;
 l_AvSizesStr: string;
 l_AvSizes: TvtPILSizes;
 I: Integer;
 l_Section: string;
 l_Size: TvtPILSize;
 l_Bpp: TvtPILBpp;
 l_FileKey: string;
 l_FileName: string;
begin
 if SelectDirectory('Выберите папку','',FCurDir) then
 begin
  FCurDir := IncludeTrailingPathDelimiter(FCurDir);
  if FileExists(FCurDir+SImagelistIni) then
  begin
   if MessageDlg('Все изображения из image list будут удалены и будут загружены изображения согласно описанию в '+
      SImagelistIni + '.'#13#10'Это действительно то, что вы хотите?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
    Screen.Cursor := crHourGlass;
    try
     l_Script := TIniFile.Create(FCurDir+SImagelistIni);
     try
      l_Count := l_Script.ReadInteger('Settings', 'Count', 0);
      if l_Count > 0 then
      begin
       l_AvSizesStr := l_Script.ReadString('Settings', 'Sizes', '');
       l_AvSizes := [];
       if Pos('16x16', l_AvSizesStr) > 0 then
        l_AvSizes := [ps16x16];
       if Pos('32x32', l_AvSizesStr) > 0 then
        l_AvSizes := l_AvSizes + [ps32x32];
       if Pos('24x24', l_AvSizesStr) > 0 then
        l_AvSizes := l_AvSizes + [ps24x24];
       if l_AvSizes <> [] then
       begin
        FPngImgList.Clear;
        FPngImgList.AvailableSizes := l_AvSizes;
        try
         for I := 0 to Pred(l_Count) do
         begin
          l_Section := Format('Image%d', [I]);
          FPngImgList.AddItem;
          for l_Size := Low(TvtPILSize) to High(TvtPILSize) do
           if l_Size in FPngImgList.AvailableSizes then
            for l_Bpp := Low(TvtPILBpp) to High(TvtPILBpp) do
            begin
             l_FileKey := Format('%s_%s', [cSSize[l_Size], cSBpp[l_Bpp]]);
             l_FileName := l_Script.ReadString(l_Section, l_FileKey, '');
             if l_FileName <> '' then
             begin
              if FileExists(FCurDir+l_FileName) then
              begin
               LoadOneImage(I, l_Size, l_Bpp, FCurDir+l_FileName);
              end
              else
              begin
               Screen.Cursor := crDefault;
               try
                if MessageDlg(Format('Ошибка: файл %s не найден (изображение с индексом %d, разрешением "%s" и цветностью "%s")',
                   [l_FileName, I, cSSize[l_Size], cSBpp[l_Bpp]]), mtError, [mbOK, mbAbort], 0) = mrAbort then
                    Exit;
               finally
                Screen.Cursor := crHourGlass;
               end;
              end;
             end
             else
             begin
              Screen.Cursor := crDefault;
              try
               if MessageDlg(Format('Ошибка: в %s не найдено изображение с индексом %d, разрешением "%s" и цветностью "%s"',
                   [SImagelistIni, I, cSSize[l_Size], cSBpp[l_Bpp]]), mtError, [mbOK, mbAbort], 0) = mrAbort then
                    Exit;
              finally
               Screen.Cursor := crHourGlass;
              end;
             end;
            end;
         end;
        finally
         lsImages.Total := FPngImgList.Count;
         CheckDeleteButton;
        end;
       end
       else
        MessageDlg('Ошибка в '+SImagelistIni+' - не определены разрешения изображений!', mtError, [mbOK], 0);
      end
      else
       MessageDlg('Ошибка в '+SImagelistIni+' - не определено количество изображений!', mtError, [mbOK], 0);
     finally
      l3Free(l_Script);
     end;
    finally
     Screen.Cursor := crDefault;
    end;
   end;
   MessageDlg('Пакетная загрузка изображений завершена', mtInformation, [mbOK], 0);
  end
  else
   MessageDlg(SImagelistIni+' не найден в выбранной папке', mtError, [mbOK], 0);
 end;
end;

procedure TvtPngImageListEditForm.btn24_24CustomGlyphDraw(Sender: TObject;
  const aCanvas: Il3Canvas; aRect: TRect; aState: TButtonState97);
begin
 FPngImgList.DrawGlyphSpecified(lsImages.Current, aCanvas, ps24x24, bpp24, aRect.Left, aRect.Top, True);
end;

procedure TvtPngImageListEditForm.btn24_8CustomGlyphDraw(Sender: TObject;
  const aCanvas: Il3Canvas; aRect: TRect; aState: TButtonState97);
begin
 FPngImgList.DrawGlyphSpecified(lsImages.Current, aCanvas, ps24x24, bpp8, aRect.Left, aRect.Top, True);
end;

procedure TvtPngImageListEditForm.btn24_4CustomGlyphDraw(Sender: TObject;
  const aCanvas: Il3Canvas; aRect: TRect; aState: TButtonState97);
begin
 FPngImgList.DrawGlyphSpecified(lsImages.Current, aCanvas, ps24x24, bpp4, aRect.Left, aRect.Top, True);
end;

procedure TvtPngImageListEditForm.InvalidateButtons;
begin
 btn16_24.Invalidate;
 btn16_8.Invalidate;
 btn16_4.Invalidate;
 btn24_24.Invalidate;
 btn24_8.Invalidate;
 btn24_4.Invalidate;
 btn32_24.Invalidate;
 btn32_8.Invalidate;
 btn32_4.Invalidate;
end;

procedure TvtPngImageListEditForm.btnCopySizedImgClick(Sender: TObject);
var
 l_Dlg: TvtPILCopySizedDlg;
begin
 l_Dlg := TvtPILCopySizedDlg.Create(Self);
 try
  if l_Dlg.ShowModal = mrOK then
  begin
   FPngImgList.CopySizeToSize(l_Dlg.SizeFrom, l_Dlg.SizeTo);
   InvalidateButtons;
  end;
 finally
  l3Free(l_Dlg);
 end;
end;

end.
