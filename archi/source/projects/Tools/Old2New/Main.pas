unit Main;

{ $Id: Main.pas,v 1.33 2009/09/17 11:44:17 lulin Exp $ }

// $Log: Main.pas,v $
// Revision 1.33  2009/09/17 11:44:17  lulin
// {RequestLink:163065542}.
//
// Revision 1.32  2007/06/09 12:55:36  lulin
// -bug fix: не собиралась утилита.
//
// Revision 1.31  2006/04/25 08:57:22  lulin
// - cleanup.
//
// Revision 1.30  2005/07/05 11:59:03  lulin
// - bug fix: не компилировалось.
//
// Revision 1.29  2005/05/27 14:44:39  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.28  2005/05/23 15:47:34  lulin
// - убрал надоевшую зависимость между библиотеками.
//
// Revision 1.27  2005/02/15 11:24:32  lulin
// - new build.
//
// Revision 1.26  2005/02/14 16:10:47  lulin
// - new build.
//
// Revision 1.25  2004/11/03 17:46:00  lulin
// - remove unit: m3OldBaseTools.
//
// Revision 1.24  2004/10/06 13:55:14  lulin
// - теперь метод Im3DB.Start имеет два ОБЯЗАТЕЛЬНЫХ параметра - режимы открытия частей. В результате этого заработала утилита, которая расставляет IndexID.
//
// Revision 1.23  2004/10/01 07:24:21  lulin
// - new behavior: сделана возможность в итераторе и обновлении игнорировать пустые файлы.
//
// Revision 1.22  2004/09/23 12:38:04  lulin
// - добавлен параметр.
//
// Revision 1.21  2004/09/23 12:19:30  lulin
// - сделана возможность сделать копию базы.
//
// Revision 1.20  2004/08/31 13:25:21  law
// - сделана возможность в процедуре Im3DB.CopyTo перезаписывать пустые.
//
// Revision 1.19  2004/08/31 12:56:24  voba
// - вкрутил новую галку позволяющую использовать как простой апдейтер нового хранилища
//
// Revision 1.18  2004/08/30 08:22:31  law
// - при копировании Info проверяем, что это первая верси.
//
// Revision 1.17  2004/08/24 14:45:56  law
// - new build.
//
// Revision 1.16  2004/08/24 11:43:08  law
// - изменен тип контрола.
//
// Revision 1.15  2004/08/24 07:58:12  law
// - new build.
//
// Revision 1.14  2004/08/23 16:21:44  law
// - используем метод Im3DB.CopyTo.
//
// Revision 1.13  2004/08/23 11:51:28  law
// - даны более вразумительне названия методам.
//
// Revision 1.12  2004/08/20 10:15:11  law
// - сделана возможность в утилите Old2New не перезаписывать существующие файлы, а также возможность Update'а базы перед переливкой.
//
// Revision 1.11  2004/08/17 15:01:36  law
// - new param: aSkipNotIndexed.
//
// Revision 1.10  2004/06/10 14:24:07  law
// - new behavior: сделана возможность переливать документы в блочную структуру.
//
// Revision 1.9  2004/05/13 13:11:23  law
// - new behavior: записываем информацию о максимальном и минимальном индексах документов.
//
// Revision 1.8  2004/05/13 12:07:14  law
// - new proc version: m3GetMain - ею и пользуемся в переливщике.
//
// Revision 1.7  2004/05/13 11:15:59  law
// - new build.
//
// Revision 1.6  2004/05/12 16:13:57  law
// - new behavior: сделана возможность записывать файлы в хранилище по два раза.
//
// Revision 1.5  2004/05/11 12:15:09  law
// - избавляемся от дублирования кода.
// - используем индексированное хранилище.
//
// Revision 1.4  2004/05/07 15:56:34  law
// - сделана обработка кнопок.
//
// Revision 1.3  2004/05/07 15:40:41  law
// - new build.
//
// Revision 1.2  2004/05/07 09:48:12  law
// - поправлены пути.
//
// Revision 1.1  2004/05/07 09:29:59  law
// - change: утилита Old2New переехала в каталог Tools.
//
// Revision 1.3  2002/03/01 10:10:04  law
// - new behavior: "тихая" обработка исключительных ситуаций.
//
// Revision 1.2  2002/02/20 13:30:44  law
// - cleanup.
//
// Revision 1.1  2002/01/16 15:42:06  law
// - new project: Old2New.
//

interface

uses
  Windows, ActiveX, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, OvcBase,  W95Meter, ExtCtrls, Buttons,
  vtSpin, l3Types, l3InterfacedComponent, m3DBInterfaces, Mask, ToolEdit,
  afwControl;

type
  TMainForm = class(TForm)
    btCopy: TButton;
    FileMeter: TvtW95Meter;
    FilesMeter: TvtW95Meter;
    lbFile: TLabel;
    lbFiles: TLabel;
    OvcController: TOvcController;
    lbNum: TLabel;
    btStop: TButton;
    pnStatus: TPanel;
    btStat: TSpeedButton;
    seMinNum: TvtSpinEdit;
    lbPercent: TLabel;
    edBaseDir: TDirectoryEdit;
    GroupBox1: TGroupBox;
    cbDouble: TCheckBox;
    cbBlocks: TCheckBox;
    cbIntoVersion: TCheckBox;
    cbOldToNew: TCheckBox;
    rgRewrite: TRadioGroup;
    gbMakeCopy: TGroupBox;
    cbMakeCopy: TCheckBox;
    cbFromOld: TCheckBox;
    cbToOld: TCheckBox;
    cbModified: TCheckBox;
    cbNotEmpty: TCheckBox;
    gbUpdate: TGroupBox;
    cbUpdate: TCheckBox;
    cbNotUpdateEmpty: TCheckBox;
    procedure btCopyClick(Sender: TObject);
    procedure btStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btStatClick(Sender: TObject);
    procedure FilesMeterSetStr(const aStr: String);
  private
    { Private declarations }
    f_Stopped   : Bool;
    f_InProcess : Bool;
    f_NeedClose : Bool;
    f_DB        : Im3DB;
    f_DBOld     : Im3DB;
    function  pm_GetBaseDir: String;
    procedure pm_SetBaseDir(const aValue: String);
      {-}
    procedure Yield(aSender: TObject);
      {-}
    procedure FilesProcessed(aCurrentID: Long);
      {-}
    procedure FilesProcessedEx(aCurrentID : Long;
                               aMaxID     : Long;
                               aTime      : TDateTime);
      {-}
    procedure DoBeforeIndexLoad(aSender: TObject);
      {-}
    procedure DoBeforeSort(aSender: TObject);
      {-}
  public
    { Public declarations }
    property BaseDir: String
      read pm_GetBaseDir
      write pm_SetBaseDir;
      {-}
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  l3Base,
  l3MinMax,
  l3Filer,
  l3FileUtils,
  l3WindowsStorageFiler,
  l3String,
  l3ExceptionsLog,

  m2COMLib,

  m3Const,
  m3StorageInterfaces,
  m3StorageTools,
  m3StgMgr,
  m3BackupTools,
  m3DB,

  evEvdRd,
  evEvdWriter,

  D_MemUsg
  ;

const
 cBaseDir = 'N:\Bases\';

procedure TMainForm.btCopyClick(Sender: TObject);
const
 cFileName = 'bserv001';
 cFileNameCopy = 'bserv001c';
var
 l_Total   : TDateTime;

 procedure DoIt;

 var
  l_NewBase : Im3IndexedStorage;
  l_Summary : IStream;
  l_Summ    : Tm3BaseSummary;
  l_Reader  : TevEvdReader;
  l_Writer  : TevCustomEvdStorageWriter;

(*  function DoFiler(aFiler: Tl3CustomFiler): Bool;

  var
   l_OldStream  : IStream;

   procedure DoWrite(aHandle: Integer);
   var
    l_NewStream  : IStream;
    l_Read       : Int64;
    l_Written    : Int64;
    l_DocStorage : Im3IndexedStorage;
    l_Filer      : Tl3CustomWindowsStorageFiler;
   begin//DoWrite
    if not (rgRewrite.ItemIndex = 2) then
    begin
     l_NewStream := m3GetMain(l_NewBase, aHandle, m3_dsMain, m3_saRead);
     if (l_NewStream <> nil) then
     begin
      l_NewStream := nil;
      Exit;
     end;//l_NewStream <> nil
    end;//not cbRewrite.Checked
    if (l_Reader = nil) then
     l_NewStream := m3GetMain(l_NewBase, aHandle, m3_dsMain, m3_saReadWrite)
    else
     l_NewStream := m3GetMain(l_NewBase, aHandle, m3_dsMain, m3_saCreate);
    try
     l_OldStream.Seek(0, STREAM_SEEK_SET, l_Read);
     if (l_Reader = nil) then
     begin
      l_OldStream.CopyTo(l_NewStream, High(Int64), l_Read, l_Written);
     end
     else
     begin
      l_Reader.Filer.COMStream := l_OldStream;
      try
       m3COMSafeOpenStorage(l_NewBase, aHandle, m3_saReadWrite, true, l_DocStorage);
       try
        l_Filer := Tl3CustomWindowsStorageFiler.Create;
        try
         l_Filer.Mode := l3_fmWrite;
         l_Filer.Storage := l_DocStorage;
         l_Writer.Filer := l_Filer;
         try
          l_Writer.Filer.COMStream := l_NewStream;
          try
           l_Reader.Execute;
          finally
           l_Writer.Filer.COMStream := nil;
          end;//try..finally
         finally
          l_Writer.Filer := nil;
         end;//try..finally
        finally
         l3Free(l_Filer);
        end;//try..finally 
       finally
        l_DocStorage := nil;
       end;//try..finally
      finally
       l_Reader.Filer.COMStream := nil;
      end;//try..finally
     end;//l_Reader = nil
     if (aHandle > l_Summ.rMax) then
     begin
      l_Summ.rMax := aHandle;
      l_Summary.Seek(Int64(@(Pm3BaseSummary(nil).rMax)), STREAM_SEEK_SET, l_Read);
      l_Summary.Write(@l_Summ.rMax, SizeOf(l_Summ.rMax), @l_Written);
     end;//aHandle > l_Max
     if (aHandle < l_Summ.rMin) then
     begin
      l_Summ.rMin := aHandle;
      l_Summary.Seek(Int64(@(Pm3BaseSummary(nil).rMin)), STREAM_SEEK_SET, l_Read);
      l_Summary.Write(@l_Summ.rMin, SizeOf(l_Summ.rMax), @l_Written);
     end;//aHandle > l_Max
    finally
     l_NewStream := nil;
    end;//try..finally
   end;//DoWrite

  begin//DoFiler
   Result := true;
   if Supports(aFiler, IStream, l_OldStream) then
    try
     DoWrite(aFiler.Handle);
     if cbDouble.Checked then
      DoWrite(aFiler.Handle + 700000);
    finally
     l_OldStream := nil;
    end;//try..finally
  end;//DoFiler*)

 var
  l_Name    : String;
  l_Elapsed : TDateTime;
  l_Read    : Integer;
  l_Mode    : Tm3DBCopyMode;
 begin//DoIt
  f_DB := Tm3DB.Make(ConcatDirName(BaseDir, cFileName),
                     //cbMakeCopy.Checked AND cbFromOld.Checked,
                     Yield,
                     FileMeter.ProgressProc_ev,
                     FilesMeter.ProgressProc_ev,
                     FilesProcessed,
                     FilesProcessedEx);
  try
   f_DB.Start(m3_saReadWrite{, m3_saReadWrite});
   try
    if cbUpdate.Checked then
     f_DB.Update(cbNotUpdateEmpty.Checked);
    if f_DB.Stopped then
     Exit;
    if cbMakeCopy.Checked then
    begin
     f_DBOld := Tm3DB.Make(ConcatDirName(BaseDir, cFileNameCopy),
                           //cbToOld.Checked,
                           Yield,
                           FileMeter.ProgressProc_ev,
                           FilesMeter.ProgressProc_ev,
                           FilesProcessed,
                           FilesProcessedEx);
     try
      if cbModified.Checked then
       f_DB.ModifiedFiles(cbNotEmpty.Checked).CopyTo(f_DBOld{, false})
      else
       f_DB.AllFiles.CopyTo(f_DBOld{, false});
      Exit;
     finally
      f_DBOld := nil;
     end;//try..finally
    end;//cbMakeCopy.Checked
    if not cbOldToNew.Checked then
     Exit;
    if not cbBlocks.Checked then
    begin
     f_DBOld := Tm3DB.Make(ConcatDirName(BaseDir, cFileName),
                           //true,
                           Yield,
                           FileMeter.ProgressProc_ev,
                           FilesMeter.ProgressProc_ev,
                           FilesProcessed,
                           FilesProcessedEx);
     try
      Case rgRewrite.ItemIndex of
       0 : l_Mode := m3_cmRewrite;
       1 : l_Mode := m3_cmRewriteEmpty;
       else
        l_Mode := m3_cmNotRewrite;
      end;//Case rgRewrite.ItemIndex
      f_DBOld.AllFiles.CopyTo(f_DB, {not cbIntoVersion.Checked, }l_Mode);
      Exit;
     finally
      f_DBOld := nil;
     end;//try..finally
    end;//not cbBlocks.Checked
   finally
    f_DB.Finish;
    l_Total := l_Total + f_DB.LastElapsed;
   end;//try..finally
  finally
   f_DB := nil;
  end;//try..finally
(*  l_NewBase := Tm3FullModeStorageManager.MakeInterface(ConcatDirName(BaseDir, cFileName + '.stg'));
  try
   l_Summary := m3GetBaseSummary(l_NewBase, m3_saReadWrite);
   try
    if (l_Summary.Read(@l_Summ, SizeOf(l_Summ), @l_Read) <> S_Ok) OR
       (l_Read <> SizeOf(l_Summ)) then
    begin
     FillChar(l_Summ, SizeOf(l_Summ), 0);
     l_Summ.rMin := High(l_Summ.rMin);
    end;//l_Summary.Read..
    l_Name := ConcatDirName(BaseDir, cFileName);
    if cbBlocks.Checked then
    begin
     l_Reader := TevEvdReader.Create;
     l_Writer := TevCustomEvdStorageWriter.Create;
     l_Writer.Plain := false;
     l_Writer.Binary := true;
     l_Reader.Generator := l_Writer;
    end
    else
    begin
     l_Reader := nil;
     l_Writer := nil;
    end;//cbBlocks.Checked
    try
     seMinNum.AsInteger := m3IterateDocumentsF(l_Name,
                                               l3L2FilerAction(@DoFiler),
                                               FileMeter.ProgressProc_ev,
                                               FilesMeter.ProgressProc_ev,
                                               @f_Stopped,
                                               DoBeforeIndexLoad,
                                               DoBeforeSort,
                                               FilesProcessed,
                                               FilesProcessedEx,
                                               seMinNum.AsInteger,
                                               false,
                                               false,
                                               false,
                                               @l_Elapsed);
    finally
     l3Free(l_Reader);
     l3Free(l_Writer);
    end;//try..finally
    l_Total := l_Total + l_Elapsed;
   finally
    l_Summary := nil;
   end;//try..finally
  finally
   l_NewBase := nil;
  end;//try..finally*)
 end;//DoIt

begin
 btCopy.Enabled := false;
 try
  btStop.Enabled := true;
  f_Stopped := false;
  f_InProcess := true;
  l_Total := 0;
  try
   DoIt;
   if f_Stopped then
    pnStatus.Caption := 'Копирование прервано пользователем ' + TimeToStr(l_Total)
   else
    pnStatus.Caption := 'Копирование завершено ' + TimeToStr(l_Total);
  finally
   f_InProcess := false;
  end;//try..finally
  if f_NeedClose then Close;
 finally
  btStop.Enabled := false;
  btCopy.Enabled := true;
 end;//try..finally
end;

procedure TMainForm.btStopClick(Sender: TObject);
begin
 if (f_DB <> nil) then
  f_DB.Stop;
 if (f_DBOld <> nil) then
  f_DBOld.Stop;
 f_Stopped := true;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 BaseDir := cBaseDir;
end;

function TMainForm.pm_GetBaseDir: String;
  {-}
begin
 Result := edBaseDir.Text;
end;

procedure TMainForm.pm_SetBaseDir(const aValue: String);
  {-}
begin
 edBaseDir.Text := aValue;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 if f_InProcess then begin
  if (MessageDlg('Вы хотите прервать заливку?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
   f_NeedClose := true;
   if (f_DB <> nil) then
    f_DB.Stop;
   if (f_DBOld <> nil) then
    f_DBOld.Stop;
   f_Stopped := true;
  end;
  CanClose := false;
 end;//f_InProcess
end;

procedure TMainForm.btStatClick(Sender: TObject);
begin
 MemoryUsageDlg.ShowModal;
end;

procedure TMainForm.Yield(aSender: TObject);
  {-}
begin
 Application.ProcessMessages;
end;

procedure TMainForm.FilesProcessed(aCurrentID: Long);
  {-}
begin
 with l3System do
  pnStatus.Caption := Format('local: %d global: %d objects: %d/%d',
                             [LocalMemUsed, GlobalMemUsed, ObjectCount, ObjectMemUsed]);
end;

procedure TMainForm.FilesProcessedEx(aCurrentID : Long;
                                     aMaxID     : Long;
                                     aTime      : TDateTime);
  {-}
begin
 lbPercent.Caption := IntToStr(FilesMeter.Percent) +
                               '% ' +
                               TimeToStr(aTime);
 if (FilesMeter.Percent > 0) then
  lbPercent.Caption := lbPercent.Caption +
                       ' расчетное время ' + TimeToStr((aTime) * 100 / FilesMeter.Percent);
end;

procedure TMainForm.DoBeforeIndexLoad(aSender: TObject);
  {-}
begin
 pnStatus.Caption := 'Идет копирование';
end;

procedure TMainForm.DoBeforeSort(aSender: TObject);
  {-}
begin
 pnStatus.Caption := 'Копирование завершено';
end;

procedure TMainForm.FilesMeterSetStr(const aStr: String);
begin
 lbNum.Caption := aStr;
end;

end.
