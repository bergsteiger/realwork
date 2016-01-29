unit TextCalcMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Mask, ToolEdit, ExtCtrls,
  k2Reader,
  k2PlTxRd,
  l3Base, l3Types,
  l3WindowsStorageFiler,
  evStatisticsFilter,
  ddDocTypeDetector,
  dt_Const;

type
  TMainForm = class(TForm)
    editStartFolder: TDirectoryEdit;
    Label1: TLabel;
    listSubFolders: TListBox;
    ProgressBar: TProgressBar;
    Label2: TLabel;
    comboFileType: TComboBox;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    editEverest: TLabeledEdit;
    editNSRC: TLabeledEdit;
    editSum: TLabeledEdit;
    editFiles: TLabeledEdit;
    Bevel1: TBevel;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure editStartFolderChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure listSubFoldersClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
   f_EvdSum, f_NsrSum, f_EvdFiles, f_NsrFiles: Int64;
   f_Filer: Tl3WindowsStorageFiler;
   f_Detector: TddDocTypeDetector;
   f_Filter: TevStatisticsFilter;
   f_Reader: Tk2CustomFileParser;
   procedure CalcFolder(const aFolder: String);
   procedure CalcOneFile(const aFileName: String; var aSum, aFiles: Int64);
   procedure ShowStatistic;
   procedure FileProgressProc(aState: Byte; aValue: Long; const aMsg: string);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}
Uses
 IniFiles,
 l3FileUtils, 
 evEvdReader, ddNSRC_r, DT_Types, l3Interfaces;

procedure TMainForm.Button2Click(Sender: TObject);
begin
 Close;
end;

procedure TMainForm.Button1Click(Sender: TObject);
var
 i: Integer;
 l_Mask: String;
begin
 Button1.Enabled:= False;
 Button2.Enabled:= False;
 Button3.Enabled:= False;
 Screen.Cursor:= crHourGlass;
 ProgressBar.Visible:= True;
 try
  { Подсчет объема файлов в выделенных папках }
  editEverest.Text:= '';
  editEverest.EditLabel.Caption:= 'Формат Эверест';
  editNSRC.Text:= '';
  editNSRC.EditLabel.Caption:= 'Формат NSRC';
  editSum.Text:= '';
  editFiles.Text:= '';
  f_EvdSum:= 0;
  f_NsrSum:= 0;
  f_EvdFiles:= 0;
  f_NsrFiles:= 0;
  f_Filer:= Tl3WindowsStorageFiler.Create(nil);
  try
   f_Filer.NeedProcessMessages:= True;
   f_Filer.Indicator.NeedProgressProc:= True;
   f_Filer.Indicator.OnProgressProc:= FileProgressProc;
   f_Detector:= TddDocTypeDetector.Create(nil);
   try
     f_Filter:= TevStatisticsFilter.Create(nil);
     try
      for i:= 0 to Pred(listSubFolders.Items.Count) do
      begin
       if listSubFolders.Selected[i] then
        CalcFolder(ConcatDirName(editStartFolder.Text, listSubFolders.Items.Strings[i]));
      end; // for i
     finally
      l3Free(f_Filter);
     end; // l_Filter
   finally
    l3Free(f_Detector);
   end; // l_Detector
  finally
   l3Free(f_Filer);
  end; // l_Filer
  ShowStatistic;
 finally
  ProgressBar.Visible:= False;
  Button1.Enabled:= True;
  Button2.Enabled:= True;
  Button3.Enabled:= True;
  Screen.Cursor:= crDefault;
 end; // try..finally
end;

procedure TMainForm.editStartFolderChange(Sender: TObject);
var
 l_SR: TSearchRec;
begin
 { Подгрузка подпапок выбранной папки }
 listSubFolders.Items.Clear;
 if FindFirst(ConcatDirName(editStartFolder.Text, '*.*'), faDirectory, l_sr) = 0 then
 try
  repeat
   if (l_SR.Attr and faDirectory = faDirectory) and (l_SR.Name[1] <> '.') then
    listSubFolders.Items.Add(l_SR.Name);
  until FindNext(l_SR) <> 0;
 finally
  FindClose(l_SR);
 end;
end;

procedure TMainForm.CalcFolder(const aFolder: String);
var
 l_EvdSize, l_NsrSize: Int64;
 l_EvdCount, l_NsrCount: Int64;
 l_SR: TSearchRec;
 l_File: TextFile;
begin
 l_EvdSize:= 0; l_EvdCount:= 0;
 l_NsrSize:= 0; l_NsrCount:= 0;
 if comboFileType.ItemIndex in [0,2] then
 begin
  f_Reader:= TevEvdStorageReader.Create(nil);
  try
   f_Reader.Filer:= f_Filer;
   f_Reader.Generator:= f_Detector;
   f_Detector.Generator:= f_Filter;
   { Подсчет содержимого одной папки }
   if FindFirst(ConcatDirName(aFolder, '*.evd'), faAnyFile, l_SR) = 0 then
   try
    repeat
     if (l_SR.Name[1] <> '.') and (l_SR.attr and faDirectory <> faDirectory) then
     begin
      CalcOneFile(ConcatDirName(aFolder, l_SR.Name), l_EvdSize, l_EvdCount);
      Inc(f_EvdSum, l_EvdSize); Inc(f_EvdFiles, l_EvdCount);
      ShowStatistic;
     end;
    until FindNext(l_SR) <> 0;
   finally
    FindClose(l_SR);
   end; // FindFirst
  finally
   l3Free(f_Reader);
  end; // f_Reader

 end; // comboFileType.ItemIndex in [0,2]
 if comboFileType.ItemIndex in [1,2] then
 begin
  f_Reader:= TCustomNSRCReader.Create(nil);
  try
   f_Reader.Filer:= f_Filer;
   f_Reader.Generator:= f_Detector;
   f_Detector.Generator:= f_Filter;
   { Подсчет содержимого одной папки }
   if FindFirst(ConcatDirName(aFolder, '*.nsr'), faAnyFile, l_SR) = 0 then
   try
    repeat
     if (l_SR.Name[1] <> '.') and (l_SR.attr and faDirectory <> faDirectory) then
     begin
      CalcOneFile(ConcatDirName(aFolder, l_SR.Name), l_NSRSize, l_NSRCount);
      Inc(f_NSRSum, l_NSRSize); Inc(f_NSRFiles, l_NSRCount);
      ShowStatistic;
     end;
    until FindNext(l_SR) <> 0;
   finally
    FindClose(l_SR);
   end; // FindFirst
  finally
   l3Free(f_Reader);
  end; // f_Reader
  
 end; // comboFileType.ItemIndex in [0,2]

 AssignFile(l_file, ConcatDirName(aFolder, 'content.txt'));
 try
  Rewrite(l_File);
  writeln(l_File, Format('*.evd (%d штук) - %d', [f_EvdFiles, f_EvdSum]));
  writeln(l_File, Format('*.nsr (%d штук) - %d', [f_NsrFiles, f_NsrSum]));
  Writeln(l_File);
  writeln(l_File, Format('Сумма:        %d байт', [f_EvdSum+ f_NsrSum]));
  writeln(l_File, Format('Всего файлов: %d штук', [f_EvdFiles+ f_NsrFiles]));
 finally
  CloseFile(l_File);
 end;
end;

procedure TMainForm.CalcOneFile(const aFileName: String; var aSum, aFiles: Int64);
begin
 f_Filer.FileName:= aFileName;
 try
 f_Reader.Execute;
 except
  l3System.msg2Log(aFileName);
 end;
 if TDocType(f_Detector.DocType) in dtOnlyDocs then
 // Inc(aFiles);
  aFiles:= 1
 else
  aFiles:= 0;
 //Inc(aSum, f_Filter.CharCount+f_Filter.TableCharCount);
 aSum:= f_Filter.CharCount+f_Filter.TableCharCount;
 Application.ProcessMessages;
end;

procedure TMainForm.FileProgressProc(aState: Byte; aValue: Long; const aMsg:
    string);
begin
 with ProgressBar do
 begin
  case aState of
   piStart:
    begin
     Max:= aValue;
     Position:= 0;
    end;
   piCurrent:
    Position:= aValue;
   piEnd:
    Position:= Max;
  end; // aState
 end; // with ProgressBar;
end;


procedure TMainForm.FormCreate(Sender: TObject);
begin
 with TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini')) do
 try
  editStartFolder.Text:= ReadString('Preferences', 'StartFolder', '');
  comboFileType.ItemIndex:= ReadInteger('Preferences', 'FileType', 0);
 finally
  Free;
 end;
end;

procedure TMainForm.listSubFoldersClick(Sender: TObject);
begin
 Button1.Enabled:= listSubfolders.SelCount <> 0;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 CanClose:= True;
 with TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini')) do
 try
  WriteString('Preferences', 'StartFolder', editStartFolder.Text);
  WriteInteger('Preferences', 'FileType', comboFileType.ItemIndex);
 finally
  Free;
 end;
end;

procedure TMainForm.ShowStatistic;
begin
  editEverest.Text:= IntToStr(f_EvdSum);
  if f_EvdFiles > 0 then
   editEverest.EditLabel.Caption:= Format('Формат Эверест (%d)', [f_EvdFiles]);
  editNSRC.Text:= IntToStr(f_NSRSum);
  if f_NSRFiles > 0 then
   editNSRC.EditLabel.Caption:= Format('Формат NSRC (%d)', [f_NSRFiles]);
  editSum.Text:= IntToStr(f_EvdSum+f_NSRSum);
  editFiles.Text:= IntToStr(f_EvdFiles+f_NSRFiles);
  Application.ProcessMessages;
end;

end.
