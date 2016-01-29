unit Main;

{ $Id: Main.pas,v 1.3 2009/08/07 09:48:14 lulin Exp $ }

// $Log: Main.pas,v $
// Revision 1.3  2009/08/07 09:48:14  lulin
// {RequestLink:159353531}. Добавляем задание даты.
//
// Revision 1.2  2009/08/07 09:28:10  lulin
// {RequestLink:159353531}.
//
// Revision 1.1  2009/08/07 06:31:40  lulin
// {RequestLink:159353531}.
//
// Revision 1.14  2005/07/05 12:01:28  lulin
// - автоизменения от Delphi.
//
// Revision 1.13  2005/05/27 14:44:42  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.12  2004/09/22 10:32:48  lulin
// - перевел на новые рельсы.
//
// Revision 1.11  2004/08/18 10:45:47  law
// - процедуры перебора файлов отвязанны от vtMeter.
//
// Revision 1.10  2004/08/17 15:01:39  law
// - new param: aSkipNotIndexed.
//
// Revision 1.9  2004/08/17 14:53:28  law
// - new param: aSkipNotIndexed.
//
// Revision 1.8  2004/08/17 14:44:39  law
// - new param: aBack.
//
// Revision 1.7  2004/06/02 14:47:36  law
// - rename method: Tk2BaseStackGenerator.Atom2String -> VariantAsString.
// - сделан фильтр для сбора информации о документах со строками в кодировке 1252.
//
// Revision 1.6  2004/05/14 15:35:20  law
// - remove unit: evTypesE.
//
// Revision 1.5  2004/05/11 12:15:09  law
// - избавляемся от дублирования кода.
// - используем индексированное хранилище.
//
// Revision 1.4  2004/05/11 10:37:48  law
// - сбор статистики по длинам файлов.
//
// Revision 1.3  2004/05/07 16:36:38  law
// - заготовка для сбора статистики по длинам файлов.
//
// Revision 1.2  2004/05/07 16:12:35  law
// - поправлены пути.
//
// Revision 1.1  2004/05/07 15:58:54  law
// - change: утилита FindErrors переехала в каталог Tools.
//
// Revision 1.10  2003/04/01 14:16:05  law
// no message
//
// Revision 1.9  2002/11/22 10:32:16  law
// - new behavior: возможность сбора информации о битых метках.
//
// Revision 1.8  2002/11/21 18:33:51  law
// - new feature: возможность сбора информации о ссылках.
//
// Revision 1.7  2002/11/21 17:26:09  law
// - new unit: m3OldBaseTools.
//
// Revision 1.6  2002/09/18 12:51:56  law
// no message
//
// Revision 1.5  2002/08/02 08:08:47  law
// no message
//
// Revision 1.4  2002/04/11 15:15:35  law
// - new unit: m3ErrorsFinder.
// - cleanup.
//
// Revision 1.2  2002/04/11 14:51:12  law
// - new unit: m4MorphTools.
//
// Revision 1.1  2002/04/11 14:42:30  law
// - new project: FindErrors.
//
// Revision 1.8  2002/04/11 14:15:05  law
// - new behavior: сделано возможность построения дельты.
//
// Revision 1.7  2002/04/03 12:16:20  law
// - new features: новые параметры индексации.
//
// Revision 1.6  2002/03/13 15:36:15  law
// - new project: IndexOldCon.
//
// Revision 1.5  2002/03/05 16:37:26  law
// - new behavior: сделана возможность индексации в обратном порядке.
//
// Revision 1.4  2002/03/01 10:08:33  law
// - some cosmetics.
//
// Revision 1.3  2002/02/21 15:58:41  law
// - optimization.
//
// Revision 1.2  2002/02/20 14:13:38  law
// - bug fix: неправильная функция сравнения адресов.
//
// Revision 1.1  2002/02/20 12:45:02  law
// - new units: первая реализация индексации документов.
//
// Revision 1.1  2002/01/16 15:42:06  law
// - new project: Old2New.
//

interface

uses
  Windows, ActiveX, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, OvcBase, l3Types,  W95Meter, ExtCtrls, Buttons,
  vtSpin, l3InterfacedComponent, m3DBInterfaces, Mask, ToolEdit, 
  afwControlPrim, afwBaseControl, afwControl, vtCombo, vtDateEdit;

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
    edBaseDir: TDirectoryEdit;
    pnStatus: TPanel;
    btStat: TSpeedButton;
    seMinNum: TvtSpinEdit;
    lbPercent: TLabel;
    btHideFileMeter: TSpeedButton;
    vtVersionDate: TvtDateEdit;
    procedure btCopyClick(Sender: TObject);
    procedure btStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btStatClick(Sender: TObject);
    procedure btHideFileMeterClick(Sender: TObject);
    procedure FilesMeterSetStr(const aStr: String);
  private
    { Private declarations }
    f_Stopped   : Bool;
    f_InProcess : Bool;
    f_NeedClose : Bool;
    f_DB        : Im3DB;
      function  pm_GetBaseDir: String;
      procedure pm_SetBaseDir(const aValue: String);
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
      procedure Yield(aSender: TObject);
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
  l3InternalInterfaces,
  l3Base,
  l3Filer,
  l3FileUtils,

  k2Types,
  k2Tags,
  k2TagGen,
  k2StackGenerator,

  m3DB,
  //m3ErrorsFinder,

  //evInfoFilter,

  evdReader,

  D_MEMUSG
  ;

// start class TevHyperlinkInfoFilter
(*
type
  TevHyperlinkInfoFilter = class(TevInfoFilter)
    public
    // public methods
      procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
        override;
        {-}
  end;//TevHyperlinkInfoFilter

procedure TevHyperlinkInfoFilter.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
  //override;
  {-}
begin
 if (AtomIndex = k2_tiHandle) AND CurrentType.InheritsFrom(k2_idHyperlink) then
  f_Filer.WriteLn(Format('%.10d %.10d', [DocID, VariantAsInteger(AtomIndex, Value)]));
end;

// start class TevSubInfoFilter

type
  TevSubInfoFilter = class(TevInfoFilterEx)
    public
    // public methods
      procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
        override;
        {-}
  end;//TevSubInfoFilter

procedure TevSubInfoFilter.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
  //override;
  {-}
var
 l_Handle : Long;
begin
 if not f_WasOut AND
    (AtomIndex = k2_tiHandle) AND
    CurrentType.InheritsFrom(k2_idSubLayer) then begin
  l_Handle := VariantAsInteger(AtomIndex, Value);
  if (l_Handle > k2_idList) then begin
   f_WasOut := true;
   f_Filer.WriteLn(Format('%.10d', [DocID]));
  end;//l_Handle > k2_idList
 end;//not f_WasOut
end;

// start class TevBlockInfoFilter

type
  TevBlockInfoFilter = class(TevInfoFilterEx)
    public
    // public methods
      procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
        override;
        {-}
  end;//TevSubInfoFilter

procedure TevBlockInfoFilter.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
  //override;
  {-}
var
 l_Handle : Long;
begin
 if not f_WasOut AND
    (AtomIndex = k2_tiHandle) AND
    CurrentType.InheritsFrom(k2_idBlock) then begin
  f_WasOut := true;
  f_Filer.WriteLn(Format('%.10d', [DocID]));
 end;//not f_WasOut
end;

// start class Tev1252InfoFilter

type
  Tev1252InfoFilter = class(TevInfoFilterEx)
    public
    // public methods
      procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
        override;
        {-}
  end;//Tev1252InfoFilter

procedure Tev1252InfoFilter.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
  //override;
  {-}
var
 l_String : Tl3CustomString;

begin
 if not f_WasOut AND
    (Value.Kind = k2_vkString) then
 begin
  l_String := VariantAsString(Value);
  try
   if not l_String.Empty AND (l_String.CodePage = 1252) then
   begin
    f_WasOut := true;
    f_Filer.WriteLn(Format('%.10d', [DocID]));
   end;//not l_String.Empty..
  finally
   l3Free(l_String);
  end;//try..finally
 end;//not f_WasOut
end;*)

// start class TMainForm

const
 //cBaseDir = 'N:\Bases\';
 cBaseDir = '\\ARCHI2\Archi\fullbase.archi\garant\';

procedure TMainForm.btCopyClick(Sender: TObject);
var
 l_Total : TDateTime;

 procedure DoIndex;

 var
  l_Filer : Tl3CustomFiler;

(*  function DoSizes(aFiler: Tl3CustomFiler): Boolean;
  begin//DoSizes
   Result := true;
   l_Filer.WriteLn(Format('%d %d', [aFiler.Handle, aFiler.Size]));
  end;//DoSizes

  function DoEmpty(aFiler: Tl3CustomFiler): Boolean;
  begin//DoEmpty
   Result := true;
   if (aFiler.Size = 0) then
    l_Filer.WriteLn(Format('%d', [aFiler.Handle]));
  end;//DoEmpty*)

 var
  l_Name    : String;
  l_Filter  : Tk2TagGenerator;
 begin//DoIndex
  l_Name := ConcatDirName(BaseDir, 'bserv001');
  f_DB := Tm3DB.Make(l_Name,
                     Yield,
                     FileMeter.ProgressProc_ev,
                     FilesMeter.ProgressProc_ev,
                     FilesProcessed,
                     FilesProcessedEx);
  try
   l_Filter := nil;
   try
(*    if rbErrors.Checked then
    begin
     l_Filter := Tm3ErrorsFinder.Create;
     Tm3ErrorsFinder(l_Filter).UseDict := cbDict.Checked;
     if cbHyphen.Checked then
      Tm3ErrorsFinder(l_Filter).Flags := [m3_efHyphen]
     else if not cbAlternate.Checked then
      Tm3ErrorsFinder(l_Filter).Flags := Tm3ErrorsFinder(l_Filter).Flags - [m3_efAlternate]
     else
      Tm3ErrorsFinder(l_Filter).Flags := Tm3ErrorsFinder(l_Filter).Flags{ - [m3_efHyphen]};
    end//rbErrors.Checked
    else if rbHyperlinks.Checked then begin
     l_Filter  := TevHyperlinkInfoFilter.Create('hyperlink.log');
    end else if rbSubs.Checked then begin
     l_Filter  := TevSubInfoFilter.Create('sub.log');
    end//rbSubs.Checked
    else
    if rbBlocks.Checked then
    begin
     l_Filter  := TevBlockInfoFilter.Create('block.log');
    end//rbBlocks.Checked
    else
    if rbSize.Checked then
    begin
     l_Filer  := Tl3DOSFiler.Make('sizes.log', l3_fmWrite);
     try
      l_Filer.Open;
      try
       f_DB.AllFiles.IterateF(l3L2FilerAction(@DoSizes));
       Exit;
      finally
       l_Filer.Close;
      end;//try..finally
     finally
      l3Free(l_Filer);
     end;//try..finally
    end//rbSize.Checked
    else
    if rbEmpty.Checked then
    begin
     l_Filer  := Tl3DOSFiler.Make('empty.log', l3_fmWrite);
     try
      l_Filer.Open;
      try
       f_DB.AllFiles.IterateF(l3L2FilerAction(@DoEmpty));
       Exit;
      finally
       l_Filer.Close;
      end;//try..finally
     finally
      l3Free(l_Filer);
     end;//try..finally
    end//rbEmpty.Checked
    else
    if rb1252.Checked then
    begin
     l_Filter  := Tev1252InfoFilter.Create;
    end;//rb1252.Checked*)
    f_DB.AllFiles.Iterate(l_Filter,
                          [Low(Tm3DocPartSelector)..High(Tm3DocPartSelector)]
                          - [m3_dsInfo, m3_dsObject]);
   finally
    l3Free(l_Filter);
   end;//try..finally
   l_Total := l_Total + f_DB.LastElapsed;
  finally
   f_DB := nil;
  end;//try..finally
 end;//DoIndex

begin
 g_OldFramesDate := vtVersionDate.Date;
 g_AllowRaiseAbort := true;
 f_Stopped := false;
 f_InProcess := true;
 btCopy.Enabled := false;
 btStop.Enabled := true;
 try
  l_Total := 0;
  try
   DoIndex;
   if f_Stopped then
    pnStatus.Caption := 'Поиск ошибок прерван пользователем ' + TimeToStr(l_Total)
   else
    pnStatus.Caption := 'Поиск ошибок завершен ' + TimeToStr(l_Total);
  finally
   f_InProcess := false;
  end;//try..finally
 finally
  btCopy.Enabled := true;
  btStop.Enabled := false;
 end;//try..finally
 if f_NeedClose then Close;
end;

procedure TMainForm.btStopClick(Sender: TObject);
begin
 f_Stopped := true;
 if (f_DB <> nil) then
  f_DB.Stop;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 BaseDir := cBaseDir;
 vtVersionDate.Date := g_OldFramesDate;
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
  if (MessageDlg('Вы хотите прервать поиск ошибок?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
   f_NeedClose := true;
   f_Stopped := true;
   if (f_DB <> nil) then
    f_DB.Stop;
  end;
  CanClose := false;
 end;//f_InProcess
end;

procedure TMainForm.btStatClick(Sender: TObject);
begin
 MemoryUsageDlg.ShowModal;
end;

procedure TMainForm.btHideFileMeterClick(Sender: TObject);
begin
 FileMeter.Visible := not btHideFileMeter.Down;
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
 pnStatus.Caption := 'Идет сбор ошибок';
end;

procedure TMainForm.DoBeforeSort(aSender: TObject);
  {-}
begin
 pnStatus.Caption := 'Сбор ошибок завершен';
end;
  
procedure TMainForm.Yield(aSender: TObject);
  {-}
begin
 Application.ProcessMessages;
end;

procedure TMainForm.FilesMeterSetStr(const aStr: String);
begin
 lbNum.Caption := aStr;
end;

end.
