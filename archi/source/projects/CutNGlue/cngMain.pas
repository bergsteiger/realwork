unit cngMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, XPMan, ComCtrls, Buttons, Placemnt, Mask, ToolEdit,
  ExtCtrls;

type
  TfrmMain = class(TForm)
    PageControl1: TPageControl;
    shGlue: TTabSheet;
    shCut: TTabSheet;
    XPManifest1: TXPManifest;
    lbFiles: TListBox;
    btnAdd: TBitBtn;
    OpenDialog: TOpenDialog;
    FormStorage1: TFormStorage;
    btnDelete: TBitBtn;
    btnUp: TSpeedButton;
    btnDown: TSpeedButton;
    btnClear: TBitBtn;
    btnGlueUp: TBitBtn;
    SaveDialog: TSaveDialog;
    edFileName: TFilenameEdit;
    Label1: TLabel;
    edRange: TEdit;
    Label2: TLabel;
    btnCutTIFF: TBitBtn;
    Panel1: TPanel;
    ProgressBar: TProgressBar;
    shBatchCut: TTabSheet;
    edDirFrom: TDirectoryEdit;
    edDirTo: TDirectoryEdit;
    cbGenerateGIF: TCheckBox;
    btnCutAll: TBitBtn;
    Label3: TLabel;
    Label4: TLabel;
    cbGenerateTIFF: TCheckBox;
    cbAutoNumber: TCheckBox;
    procedure btnAddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbFilesData(Control: TWinControl; Index: Integer;
      var Data: String);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnGlueUpClick(Sender: TObject);
    procedure edFileNameBeforeDialog(Sender: TObject; var Name: String;
      var Action: Boolean);
    procedure btnCutTIFFClick(Sender: TObject);
    procedure edFileNameAfterDialog(Sender: TObject; var Name: String;
      var Action: Boolean);
    procedure btnCutAllClick(Sender: TObject);
    procedure cbGenerateTIFFClick(Sender: TObject);
    procedure cbGenerateGIFClick(Sender: TObject);
    procedure cbAutoNumberClick(Sender: TObject);
  private
    { Private declarations }
    Files: TStringList;
  public
    procedure AddSeries(FileName: string);
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses ImageEnIO, TIFLZW, l3RangeManager, l3Base, ImageEnproc, hyiedefs, GIFLZW;

{$R *.dfm}

procedure TfrmMain.btnAddClick(Sender: TObject);
var
 I: Integer;
begin
 OpenDialog.Options := OpenDialog.Options + [ofAllowMultiSelect];
 if OpenDialog.Execute then
 begin
  if OpenDialog.Files.Count > 1 then
  begin
   for I := 0 to OpenDialog.Files.Count-1 do
    Files.Add(OpenDialog.Files[I]);
  end
  else
   AddSeries(OpenDialog.FileName);
  lbFiles.Count := Files.Count;
 end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
 Files := TStringList.Create;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
 Files.Free;
end;

procedure TfrmMain.lbFilesData(Control: TWinControl; Index: Integer;
  var Data: String);
begin
 Data := ExtractFileName(Files[Index]);
end;

procedure TfrmMain.btnDeleteClick(Sender: TObject);
var
 Temp: Integer;
begin
 if lbFiles.ItemIndex <> -1 then
 begin
  Temp := lbFiles.ItemIndex;
  Files.Delete(lbFiles.ItemIndex);
  lbFiles.Count := Files.Count;
  if Files.Count > 0 then
  begin
   if Temp < Files.Count then
    lbFiles.ItemIndex := Temp
   else
    lbFiles.ItemIndex := Files.Count-1;
  end;
 end;
end;

procedure TfrmMain.btnClearClick(Sender: TObject);
begin
 if MessageDlg('Очистить список файлов?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
 begin
  Files.Clear;
  lbFiles.Count := 0;
 end;
end;

procedure TfrmMain.btnUpClick(Sender: TObject);
begin
 if (lbFiles.ItemIndex > 0) then
 begin
  Files.Exchange(lbFiles.ItemIndex, lbFiles.ItemIndex-1);
  lbFiles.ItemIndex := lbFiles.ItemIndex-1;
 end;
end;

procedure TfrmMain.btnDownClick(Sender: TObject);
begin
 if (lbFiles.ItemIndex < Files.Count-1) then
 begin
  Files.Exchange(lbFiles.ItemIndex, lbFiles.ItemIndex+1);
  lbFiles.ItemIndex := lbFiles.ItemIndex+1;
 end;
end;

procedure TfrmMain.btnGlueUpClick(Sender: TObject);
var
 I, J, Idx: Integer;
 IO: TImageEnIO;
 BMP: TBitmap;
 Num: Integer;
begin
 if Files.Count < 2 then
 begin
  MessageDlg('Склеивать нечего.', mtError, [mbOk], 0);
  Exit;
 end;
 
 if SaveDialog.Execute then
 begin
  IO := TImageEnIO.Create(Self);
  PageControl1.Enabled := False;
  Cursor := crHourGlass;
  ProgressBar.Position := 0;
  ProgressBar.Visible := True;
  try
   BMP := TBitmap.Create;
   try
    IO.AttachedBitmap := BMP;
    IO.Params.TIFF_LZWDecompFunc := TIFFLZWDecompress;
    IO.Params.TIFF_LZWCompFunc := TIFFLZWCompress;
    Idx := 0;
    ProgressBar.Max := Files.Count;
    for I := 0 to Files.Count-1 do
    begin
     ProgressBar.Position := I+1;
     ProgressBar.Update;
     Application.ProcessMessages;
     Num := EnumTIFFIm(Files[I]);
     if Num > 1 then
      if MessageDlg('Файл '+ExtractFileName(Files[I])+' содержит больше одной страницы.'#10#13'Вы уверены, что хотите приклеить многостраничный TIFF?',
          mtConfirmation, [mbYes,mbNo],0) = mrNo then Continue;
     for J := 0 to Num-1 do
     begin
      IO.Params.TIFF_ImageIndex := J;
      IO.LoadFromFileTIFF(Files[I]);
      IO.Params.TIFF_ImageIndex := Idx;
      IO.Params.TIFF_Compression := ioTIFF_G4FAX;
      if Idx = 0 then
       IO.SaveToFileTIFF(SaveDialog.FileName)
      else
       IO.InsertToFileTIFF(SaveDialog.FileName);
      Inc(Idx);
     end;
    end;
   finally
    BMP.Free;
   end;
  finally
   IO.Free;
   PageControl1.Enabled := True;
   Cursor := crDefault;
   ProgressBar.Visible := False;
  end;
 end;
end;

procedure TfrmMain.AddSeries(FileName: string);
var
 FNNew: string;
 Dir, Ext, FNBase, SNum, FNEnd: string;
 Num, PadWidth: Integer;

 function IsAnyNumbersExistsInFileName(FN: string): Boolean;
 var
  I: Integer;
 begin
  Result := False;
  for I := 1 to Length(FN) do
   if FN[I] in ['0'..'9'] then
   begin
    Result := True;
    Break;
   end;
 end;


begin
 FNBase := ChangeFileExt(ExtractFileName(FileName), '');
 if IsAnyNumbersExistsInFileName(FNBase) and (MessageDlg(
   'Возможно, существует серия файлов, представляющих собой'#10#13' последовательные страницы. Попытаться добавить серию?',
   mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
 begin
  Dir := ExtractFilePath(FileName);
  Ext := ExtractFileExt(FileName);
  SNum := '';
  FNEnd := '';

  while (Length(FNBase) > 0) and not (FNBase[Length(FNBase)] in ['0'..'9']) do
  begin
   FNEnd := FNBase[Length(FNBase)]+FNEnd;
   SetLength(FNBase, Length(FNBase)-1);
  end;

  while (Length(FNBase) > 0) and (FNBase[Length(FNBase)] in ['0'..'9']) do
  begin
   SNum := FNBase[Length(FNBase)]+SNum;
   SetLength(FNBase, Length(FNBase)-1);
  end;

  Num := StrToInt(SNum);
  if (SNum[1] = '0') then
   PadWidth := Length(SNum)
  else
   PadWidth := 0;

  FNNew := Dir+FNBase+Format('%.'+IntToStr(PadWidth)+'d', [Num])+FNEnd+Ext;
  while FileExists(FNNew) do
  begin
   if FileExists(FNNew) then
    Files.Add(FNNew);
   Inc(Num);
   FNNew := Dir+FNBase+Format('%.'+IntToStr(PadWidth)+'d', [Num])+FNEnd+Ext;
  end;
 end
 else
  Files.Add(FileName);
end;

procedure TfrmMain.edFileNameBeforeDialog(Sender: TObject;
  var Name: String; var Action: Boolean);
begin
  edFileName.InitialDir := OpenDialog.InitialDir;
end;

procedure TfrmMain.btnCutTIFFClick(Sender: TObject);
var
 I: Integer;
 IO: TImageEnIO;
 RM: Tl3RangeManager;
 Num, X : Integer;
 FNSrc,FNShort, FNDir, FNExt : string;
 bmp: TBitmap;
begin
 FNSrc := edFileName.FileName;
 FNShort := ExtractFileName(FNSrc);
 if not FileExists(FNSrc) then
 begin
  MessageDlg('Файл '+FNShort+' не существует!', mtError, [mbOk], 0);
  Exit;
 end;

 Num := EnumTIFFIm(FNSrc);

 if Num = 0 then
  MessageDlg('Файл '+FNShort+' не является правильным TIFF файлом!',mtError, [mbOK], 0);
 if Num = 1 then
  MessageDlg('В файле '+FNShort+' всего одна страница. Резать в нем нечего.',mtError, [mbOK], 0);
 if Num < 2 then
  Exit;

 if SaveDialog.Execute then
 begin
  FNShort := ChangeFileExt(ExtractFileName(SaveDialog.FileName), '');
  FNDir := ExtractFilePath(SaveDialog.FileName);
  FNExt := ExtractFileExt(SaveDialog.FileName);

  RM := Tl3RangeManager.Create;
  PageControl1.Enabled := False;
  ProgressBar.Position := 0;
  ProgressBar.Visible := True;
  Cursor := crHourGlass;
  try
   X := RM.CheckSource(edRange.Text);
   if X <> 0 then
   begin
    edRange.Color := $DEDEFF;
    FocusControl(edRange);
    edRange.SelStart := X-1;
    edRange.SelLength := 1;
    Exit;
   end;
   IO := TImageEnIO.Create(Self);
   try
    bmp := TBitmap.Create;
    try
     IO.AttachedBitmap := bmp;
     IO.Params.TIFF_LZWDecompFunc := TIFFLZWDecompress;
     IO.Params.TIFF_LZWCompFunc := TIFFLZWCompress;
     RM.SrcString := edRange.Text;
     RM.Confine(1, Num);
     ProgressBar.Max := RM.Count;
     for I := 1 to RM.Count do
     begin
      ProgressBar.Position := I;
      ProgressBar.Update;
      Application.ProcessMessages;
      IO.Params.TIFF_ImageIndex := RM[I]-1;
      IO.LoadFromFileTIFF(FNSrc);
      IO.Params.TIFF_Compression := ioTIFF_G4FAX;
      IO.SaveToFileTIFF(FNDir+FNShort+'('+Format('%.3d',[I])+')'+FNExt);
     end;
    finally
     bmp.Free;
    end;
   finally
    IO.Free;
   end;
  finally
   Cursor := crDefault;
   ProgressBar.Visible := False;
   PageControl1.Enabled := True;
   l3Free(RM);
  end;
 end;
end;

procedure TfrmMain.edFileNameAfterDialog(Sender: TObject; var Name: String;
  var Action: Boolean);
var
 Num: Integer;
begin
 Num := EnumTIFFIm(Name);
 if Num > 1 then
  edRange.Text := '1-'+IntToStr(Num)
 else
  edRange.Text := '';
 if Num = 0 then
  MessageDlg('Файл '+ExtractFileName(Name)+' не является правильным TIFF файлом!',mtWarning, [mbOK], 0);
 if Num = 1 then
  MessageDlg('В файле '+ExtractFileName(Name)+' всего одна страница. Резать в нем нечего.',mtInformation, [mbOK], 0);
end;

procedure TfrmMain.btnCutAllClick(Sender: TObject);
var
 FNFrom: string;
 l_Height: Integer;
 l_Width: Integer;
 sTargetFN: string;
 Num: Integer;
 I, J, K: Integer;
 SR: TSearchRec;
 IO: TImageEnIO;
 IP: TImageEnProc;
 bm : TBitmap;
begin
 // Проверка возможностей экспорта
 if (not DirectoryExists(edDirFrom.Text)) then
 begin
  MessageDlg('Исходная директория не существует!',mtError, [mbOK], 0);
  Exit;
 end;

 if (not DirectoryExists(edDirTo.Text)) then
 begin
  if MessageDlg('Директория для выливки не существует! Создать?',mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
   if not ForceDirectories(edDirTo.Text) then
   begin
    MessageDlg('Не удалось создать директорию'#13#10+edDirTo.Text, mtError, [mbOK], 0);
    Exit;
   end;
  end
  else
   Exit;
 end;

 // Загружаем список файлов для экспорта
 Files.Clear;
 if FindFirst(IncludeTrailingBackslash(edDirFrom.Text)+'*.tif', faAnyFile and not (faDirectory or faVolumeID), SR) <> 0 then
 begin
  MessageDlg('Нет ни одного tif-файла в исходной директории!',mtError, [mbOK], 0);
  Exit;
 end;
 repeat
  Files.Add(SR.Name);
 until FindNext(SR) <> 0;
 FindClose(SR);

 // Начинаем экспортить
 IO := TImageEnIO.Create(nil);
 try
  PageControl1.Enabled := False;
  ProgressBar.Max := Files.Count;
  ProgressBar.Position := 0;
  ProgressBar.Visible := True;
  IP := TImageEnProc.Create(nil);
  try
   bm := TBitmap.Create;
   try
    IO.Params.TIFF_LZWDecompFunc := TIFFLZWDecompress;
    IO.Params.TIFF_LZWCompFunc := TIFFLZWCompress;
    IO.Params.GIF_LZWCompFunc := GIFLZWCompress;
    IO.Params.GIF_LZWDecompFunc := GIFLZWDecompress;
    IO.AttachedBitmap := bm;
    for I := 1 to Files.Count do
    begin
     ProgressBar.StepIt;
     FNFrom := IncludeTrailingBackslash(edDirFrom.Text)+Files[I-1];
     Num := EnumTIFFIm(FNFrom);
     for J := 1 to Num do
     begin
      IO.Params.TIFF_ImageIndex := J-1;
      IO.LoadFromFileTIFF(FNFrom);
      sTargetFN := IncludeTrailingBackslash(edDirTo.Text) + ChangeFileExt(Files[I-1], '');
      if cbAutoNumber.Checked then
       sTargetFN := sTargetFN + '_' + IntToStr(J);
      if cbGenerateTIFF.Checked then
      begin
       IO.Params.TIFF_Compression := ioTIFF_G4FAX;
       IO.SaveToFileTIFF(sTargetFN +'.tif');
      end;
      if cbGenerateGIF.Checked then
      begin
       IP.AttachedBitmap := IO.Bitmap;
       l_Width := Round(IO.Bitmap.Width * 0.32);
       l_Height := Round(IO.Bitmap.Height * 0.32);
       IP.Resample(l_Width, l_Height, rfLanczos3);
       IO.Params.GIF_Interlaced := false;
       IO.Params.BitsPerSample := 2;
       IO.Params.SamplesPerPixel := 1;
       IO.SaveToFileGIF(sTargetFN +'.gif');
      end;
     end;
    end; // for I := 1 to Files.Count
   finally
    bm.Free;
   end; {try..finally}
  finally
    ProgressBar.Visible := False;
    PageControl1.Enabled := True;
    IP.Free;
  end; {try..finally}
 finally
   IO.Free;
 end; {try..finally}

end;

procedure TfrmMain.cbGenerateTIFFClick(Sender: TObject);
begin
 if (not cbGenerateTIFF.Checked) and (not cbGenerateGIF.Checked) then
  cbGenerateGIF.Checked := True;
end;

procedure TfrmMain.cbGenerateGIFClick(Sender: TObject);
begin
 if (not cbGenerateTIFF.Checked) and (not cbGenerateGIF.Checked) then
  cbGenerateTIFF.Checked := True;
end;

procedure TfrmMain.cbAutoNumberClick(Sender: TObject);
begin
 if not cbAutoNumber.Checked then
  if MessageDlg('Внимание: если при резке встретится многостраничный TIFF,'#13+
     'то некоторые страницы могут быть утеряны!'#13'Вы уверены, что хотите отменить автонумерацию?', mtWarning,
        [mbYes, mbNo], 0) = mrNo then
   cbAutoNumber.Checked := True;
end;

end.
