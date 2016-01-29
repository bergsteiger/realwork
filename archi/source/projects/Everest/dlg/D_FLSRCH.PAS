unit D_FlSrch;

{ $Id: D_FLSRCH.PAS,v 1.34 2013/01/23 08:09:35 kostitsin Exp $ }

// $Log: D_FLSRCH.PAS,v $
// Revision 1.34  2013/01/23 08:09:35  kostitsin
// не собиралось
//
// Revision 1.33  2011/02/17 09:59:58  lulin
// {RequestLink:253659765}.
// - вычищаем мусорок.
//
// Revision 1.32  2009/07/16 09:16:30  lulin
// - bug fix: не собирался тестовый Эверест.
//
// Revision 1.31  2009/07/08 13:33:14  lulin
// - bug fix: не собирался тестовый Эверест в ветке.
//
// Revision 1.30  2009/07/08 11:26:32  lulin
// - bug fix: не собирался тестовый Эверест.
//
// Revision 1.29  2008/12/23 11:27:16  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.28  2008/05/20 10:52:05  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.27  2008/04/01 17:05:34  lulin
// - нарисовал контейнер документа на модели.
//
// Revision 1.26  2007/12/05 13:51:29  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.22.2.4  2007/09/11 09:09:19  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.22.2.3  2006/12/21 16:22:43  dinishev
// Bug fix: Everest в ветке не компилировался
//
// Revision 1.22.2.2  2006/02/08 16:11:07  lulin
// - cleanup.
//
// Revision 1.22.2.1  2006/02/08 14:25:11  lulin
// - собрал Everest в ветке.
//
// Revision 1.22  2005/10/06 09:37:21  lulin
// - базовый класс панелей переехал в более правильное место.
//
// Revision 1.21  2005/05/30 10:28:45  lulin
// - компонент "Заголовок" переехал в модуль с "правильным" названием.
//
// Revision 1.20  2005/05/27 14:44:27  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.19  2005/05/23 15:47:32  lulin
// - убрал надоевшую зависимость между библиотеками.
//
// Revision 1.18  2004/12/29 15:39:34  lulin
// - с TextSource убрана печать.
//
// Revision 1.17  2004/09/21 10:32:35  lulin
// - bug fix: не компилировалось.
//
// Revision 1.16  2004/04/23 16:11:30  law
// - new unit: evEdit.
//
// Revision 1.15  2004/03/31 16:25:13  law
// -  наведено подобие порядка с StringToPCharAlloc.
//
// Revision 1.14  2004/03/15 14:22:46  law
// - change: переделки в связи с изменением библиотек компонентов.
//
// Revision 1.13  2003/10/14 16:36:24  law
// - rename unit: evTxtSrc -> evTextSource.
//
// Revision 1.12  2003/10/13 15:06:41  law
// - rename unit: evEdWnd -> evEditorWindow.
//
// Revision 1.11  2003/05/20 11:35:42  law
// - rename class: TevCustomTextSourceFiler -> TevCustomTextSourceDocumentContainer.
// - rename prop: TevCustomTextSource.Filer -> TevCustomTextSource.DocumentContainer.
//
// Revision 1.10  2002/07/29 11:20:02  law
// - change: восстановил утерянные таблицы команд.
//
// Revision 1.9  2002/04/23 15:48:41  law
// - rename object instance: EverestReader -> Reader.
//
// Revision 1.8  2002/04/06 11:33:55  law
// - Delphi 6.0.
//
// Revision 1.7.2.4  2002/02/08 13:30:21  law
// - cleanup.
//
// Revision 1.7.2.3  2002/01/08 16:13:09  law
// - cleanup: убрано использование TevTextObjectParser.
//
// Revision 1.7.2.2  2002/01/08 09:24:40  law
// - rename class: TevDOSFiler -> Tl3Filer.
//
// Revision 1.7.2.1  2001/09/25 06:46:59  law
// - cleanup & new features.
//
// Revision 1.7  2001/09/14 09:43:13  law
// - change: Director -> vtDirector.
//
// Revision 1.6  2001/08/29 07:01:43  law
// - split unit: l3Intf -> l3BaseStream, l3BaseDraw, l3InterfacedComponent.
//
// Revision 1.5  2001/04/02 11:30:27  law
// - убраны ненужные AutoCreat формы.
//
// Revision 1.4  2001/03/15 17:23:08  law
// - Эверест 1.0.0.89.
//
// Revision 1.3  2000/12/15 16:22:06  law
// - вставлены директивы Log.
//

interface

{$I evDefine.inc}

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Buttons, ExtCtrls, TextSrch, vtDirector, TB97, 
  StdCtrls, OvcNbk, vtHeader, Mask, OvcBase, vtLister, l3Types, l3Filer,
  evTextSource, evEditorWindow, W95Meter, 
  k2TagGen,
  {$IfDef Win32}
  TB97Ctls,
  {$EndIf Win32}
  evEvdRd, k2Reader,  evEditor, evMemo, evEdit,
  ToolEdit, k2StackGenerator, l3ProgressComponent, l3InterfacedComponent,
  evMultiSelectEditorWindow, evCustomEditor, evEditorWithOperations,
  tb97GraphicControl, vtPanel, evdReader, evEditorWindowTextSource,
  afwControl, afwInputControl, evCustomTextSource, nevControl,
  evCustomMemo, evCustomEdit, afwTextControlPrim, afwTextControl,
  afwControlPrim, afwBaseControl, evTextSourcePublished,
  evCustomEditorWindowModelPart,

  vtDateEdit, vtCombo, evCustomEditorWindowPrim, evCustomEditorModelPart
  ;

type
  TFileSrchForm = class(TForm)
    Panel1: TPanel;
    lstSrchResult: TvtDStringLister;
    pnlParam: TPanel;
    edtRootDirectory: TDirectoryEdit;
    ResListFooter: TvtHeader;
    nbkParam: TOvcNotebook;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EdIncFileMask: TevEdit;
    EdExcFileMask: TevEdit;
    FileAttrGroup: TGroupBox;
    ChkbxfileNormal: TCheckBox;
    Chkbxfilearchive: TCheckBox;
    Chkbxfilereadonly: TCheckBox;
    Chkbxfilehidden: TCheckBox;
    Chkbxfilesystem: TCheckBox;
    ChkbxfileVolume: TCheckBox;
    Chkbxfiledirectory: TCheckBox;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    LowDateEdit: TvtDateEdit;
    HiDateEdit: TvtDateEdit;
    ChkbxWithSubDir: TCheckBox;
    Label3: TLabel;
    EdDirMask: TevEdit;
    DirAttrGroup: TGroupBox;
    ChkbxdirNormal: TCheckBox;
    Chkbxdirarchive: TCheckBox;
    Chkbxdirreadonly: TCheckBox;
    Chkbxdirhidden: TCheckBox;
    Chkbxdirsystem: TCheckBox;
    AddGroup: TGroupBox;
    ChkbxOnlyDir: TCheckBox;
    TextLabel: TLabel;
    SrchStrEdit: TevEdit;
    TextCaseCkBox: TCheckBox;
    AnsiChkBox: TCheckBox;
    sbAdvSettings: TToolbarButton97;
    Panel3: TPanel;
    tbFindFile: TToolbarButton97;
    tbStopFind: TToolbarButton97;
    sbPrint: TToolbarButton97;
    DirNavigator: TvtDirNavigator;
    TextSearcher: TBMHFileSearch;
    sbContUp: TToolbarButton97;
    sbContDown: TToolbarButton97;
    DOSFiler: Tl3DOSFiler;
    TextSource: TevTextSource;
    Progress: TvtW95Meter;
    Reader: TevEvdReader;
    tbAnalizeFormat: TToolbarButton97;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbFindFileClick(Sender: TObject);
    procedure DirNavigatorFound(Sender: TObject);
    procedure TextSearcherFound(Sender: TObject);
    procedure tbStopFindClick(Sender: TObject);
    procedure sbAdvSettingsClick(Sender: TObject);
    procedure lstSrchResultCurrentChanged(Sender: TObject;
      NewCurrent: Longint;  aOldCurrent : Longint);
    procedure FormCreate(Sender: TObject);
    procedure sbPrintClick(Sender: TObject);
    procedure TextSourceProgressProc(aState: Byte; aValue: Longint; const aMsg: String);
    procedure ResListFooterSizing(Sender: TObject; ASection,
      AWidth: Integer);
  private
    TextSrchLog : Boolean;
    SaveActiveControl : TWinControl;
    Procedure InitDirNavigator;
    Procedure FileFound(FileName : TFileName);
    Procedure EnableBtn;
  public
    { Public declarations }
  end;

function FileSrchForm : TFileSrchForm;
  {-}

implementation

{$R *.DFM}

uses
  Printers,

  l3Interfaces,
  l3Base,
  l3String,
  l3Printer,

  k2Base,
  
  evTypes,
  evDocumentPreview,

  nevBase,
  nevTools
  ;

var
 l_FileSrchForm : TFileSrchForm = nil;

procedure TFileSrchForm.FormCreate(Sender: TObject);
 begin
  width:=nbkParam.width+11;
  If nbkParam.Visible
   then
    Begin
     pnlParam.Height := 31 + nbkParam.Height;
     sbAdvSettings.Glyph:=sbContUp.Glyph;
    end
   else
    Begin
     pnlParam.Height := 31;
     sbAdvSettings.Glyph:=sbContDown.Glyph;
    end;
  EnableBtn;
 end;

procedure TFileSrchForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if TextSource.CloseQuery(Handle) AND DOSFiler.CloseQuery(Handle) then
  Action := caHide
 else
  Action := caNone;
end;

Procedure TFileSrchForm.InitDirNavigator;
 Begin
  DirNavigator.IncludeFileFilter:=EdIncFileMask.Text;
  DirNavigator.ExcludeFileFilter:=EdExcFileMask.Text;
  DirNavigator.DirectoryFilter:=EdDirMask.text;

  DirNavigator.InitialDir := edtRootDirectory.Text;
  ResListFooter.Sections[2].Caption :=DirNavigator.Initialdir;

  If ChkbxFileNormal.Checked
   then DirNavigator.SrchFileAttr:=DirNavigator.SrchFileAttr+[foNormalFiles]
   else DirNavigator.SrchFileAttr:=DirNavigator.SrchFileAttr-[foNormalFiles];

  If ChkbxFileArchive.Checked
   then DirNavigator.SrchFileAttr:=DirNavigator.SrchFileAttr+[foArchiveFiles]
   else DirNavigator.SrchFileAttr:=DirNavigator.SrchFileAttr-[foArchiveFiles];

  If ChkbxFileReadonly.Checked
   then DirNavigator.SrchFileAttr:=DirNavigator.SrchFileAttr+[foReadOnlyFiles]
   else DirNavigator.SrchFileAttr:=DirNavigator.SrchFileAttr-[foReadOnlyFiles];

  If ChkbxFileHidden.Checked
   then DirNavigator.SrchFileAttr:=DirNavigator.SrchFileAttr+[foHiddenFiles]
   else DirNavigator.SrchFileAttr:=DirNavigator.SrchFileAttr-[foHiddenFiles];

  If ChkbxFileSystem.Checked
   then DirNavigator.SrchFileAttr:=DirNavigator.SrchFileAttr+[foSystemFiles]
   else DirNavigator.SrchFileAttr:=DirNavigator.SrchFileAttr-[foSystemFiles];

  If ChkbxFileVolume.Checked
   then DirNavigator.SrchFileAttr:=DirNavigator.SrchFileAttr+[foVolumeID]
   else DirNavigator.SrchFileAttr:=DirNavigator.SrchFileAttr-[foVolumeID];

  If ChkbxFileDirectory.Checked
   then DirNavigator.SrchFileAttr:=DirNavigator.SrchFileAttr+[foDirectory]
   else DirNavigator.SrchFileAttr:=DirNavigator.SrchFileAttr-[foDirectory];

  If ChkbxOnlyDir.Checked
   then DirNavigator.SrchFileAttr:=DirNavigator.SrchFileAttr+[foOnlyDir]
   else DirNavigator.SrchFileAttr:=DirNavigator.SrchFileAttr-[foOnlyDir];

  If ChkbxWithSubDir.Checked
   then DirNavigator.ExploreDirAttr:=DirNavigator.ExploreDirAttr+[foSubDir]
   else DirNavigator.ExploreDirAttr:=DirNavigator.ExploreDirAttr-[foSubDir];

  If ChkbxDirNormal.Checked
   then DirNavigator.ExploreDirAttr:=DirNavigator.ExploreDirAttr+[foNormalDir]
   else DirNavigator.ExploreDirAttr:=DirNavigator.ExploreDirAttr-[foNormalDir];

  If ChkbxDirArchive.Checked
   then DirNavigator.ExploreDirAttr:=DirNavigator.ExploreDirAttr+[foArchiveDir]
   else DirNavigator.ExploreDirAttr:=DirNavigator.ExploreDirAttr-[foArchiveDir];

  If ChkbxDirReadonly.Checked
   then DirNavigator.ExploreDirAttr:=DirNavigator.ExploreDirAttr+[foReadOnlyDir]
   else DirNavigator.ExploreDirAttr:=DirNavigator.ExploreDirAttr-[foReadOnlyDir];

  If ChkbxDirHidden.Checked
   then DirNavigator.ExploreDirAttr:=DirNavigator.ExploreDirAttr+[foHiddenDir]
   else DirNavigator.ExploreDirAttr:=DirNavigator.ExploreDirAttr-[foHiddenDir];

  If ChkbxDirSystem.Checked
   then DirNavigator.ExploreDirAttr:=DirNavigator.ExploreDirAttr+[foSystemDir]
   else DirNavigator.ExploreDirAttr:=DirNavigator.ExploreDirAttr-[foSystemDir];

  DirNavigator.LowDate:=LowDateEdit.Date;
  If HiDateEdit.Date <> 0
   then DirNavigator.HiDate:=HiDateEdit.Date+1
   else DirNavigator.HiDate:=0;
 end;

procedure TFileSrchForm.DirNavigatorFound(Sender: TObject);
 begin
  If ResListFooter.Sections[2].Caption <> DirNavigator.FoundFileName
   then ResListFooter.Sections[2].Caption := DirNavigator.FoundFileName;
  If TextSrchLog
   then
    Begin
     TextSearcher.FileName:=DirNavigator.FoundFileName;
     TextSearcher.ExecuteSearch;
    end
   else
    FileFound(DirNavigator.FoundFileName);
 end;

procedure TFileSrchForm.TextSearcherFound(Sender: TObject);
 begin
  FileFound(TextSearcher.FileName);
 end;

Procedure TFileSrchForm.FileFound(FileName : TFileName);
 Begin
  lstSrchResult.Items.AddPCharLen(l3PCharLen(FileName));
  ResListFooter.Sections[0].Caption:=Format('%d', [lstSrchResult.Total]);
  ResListFooter.RePaint;
  {Application.ProcessMessages;}
 end;

Procedure TFileSrchForm.EnableBtn;
 Begin
  sbPrint.Enabled:=lstSrchResult.Total > 0;
 end;

procedure TFileSrchForm.tbFindFileClick(Sender: TObject);

  procedure DisableCtrl(DisLog : Boolean);
   Begin
    tbFindFile       .Enabled  := Not DisLog;
    tbStopFind       .Enabled  := DisLog;
    edtRootDirectory .Enabled  := Not DisLog;
    FileAttrGroup    .Enabled  := Not DisLog;
    DirAttrGroup     .Enabled  := Not DisLog;
    AddGroup         .Enabled  := Not DisLog;
    EdIncFileMask    .ReadOnly := DisLog;
    EdExcFileMask    .ReadOnly := DisLog;
    EdDirMask        .ReadOnly := DisLog;

   end;

  Begin
   InitDirNavigator;

   If SrchStrEdit.Text<>''
    then
     Begin
      TextSearcher.SearchString:=SrchStrEdit.Text;
      TextSearcher.OEMText:=Not AnsiChkBox.Checked;
      TextSearcher.IgnoreCase:=Not TextCaseCkBox.Checked;
      TextSrchLog:=True;
     end
    else TextSrchLog:=false;

   {If SrchLog=New then } lstSrchResult.Items.Clear;
   ResListFooter.Sections[0].Caption:=DirNavigator.Initialdir;

   DisableCtrl(True);

   SaveActiveControl:=ActiveControl;
   ActiveControl:=lstSrchResult;

   DirNavigator.Execute;
   DisableCtrl(False);
   ActiveControl:=SaveActiveControl;
   ResListFooter.Sections[2].Caption:='';
   lstSrchResult.vlbSelectAllItems;
   EnableBtn;
 end;

procedure TFileSrchForm.tbStopFindClick(Sender: TObject);
begin
 DirNavigator.Stop;
 TextSource.CloseQuery(0);
 DOSFiler.CloseQuery(0);
end;

procedure TFileSrchForm.sbAdvSettingsClick(Sender: TObject);
 begin
  nbkParam.Visible := Not nbkParam.Visible;
  With pnlParam do
   If nbkParam.Visible
    then
     Begin
      Height := 31 + nbkParam.Height;
      sbAdvSettings.Glyph:=sbContUp.Glyph;
     end
    else
     Begin
      Height := 31;
      sbAdvSettings.Glyph:=sbContDown.Glyph;
     end;
 end;

procedure TFileSrchForm.lstSrchResultCurrentChanged(Sender: TObject; NewCurrent: Longint;  aOldCurrent : Longint);
var
 CC : Long;
 OEMCount  : Long;
 ANSICount : Long;
begin
 if (lstSrchResult.Total > 0) then begin
  if tbAnalizeFormat.Down then begin
   DOSFiler.FileName := l3GetStrPas(lstSrchResult.Items.Strings[NewCurrent]);
   DOSFiler.Analize(OEMCount, ANSICount);
   ResListFooter.Sections[2].Caption := Format('%d : %d', [OEMCount, ANSICount]);
  end;{tbAnalizeFormat.Down}
  CC := Succ(NewCurrent);
 end else
  CC := 0;
 ResListFooter.Sections[0].Caption := Format('%d из %d', [CC, lstSrchResult.Total]);
end;

procedure TFileSrchForm.sbPrintClick(Sender: TObject);
 Var
  I   : Longint;
  P   : Tl3Printer;
 begin
  sbPrint.Enabled := false;
  tbStopFind.Enabled := true;
  try
   With lstSrchResult.Items do
    Begin
     If SelectCount = 0 then Exit;
     P := Tl3Printer.Create;
     try
      For I:=0 to Pred(Count) do
       Begin
        If lstSrchResult.Selected[I] then
         Begin
          (**)
          ResListFooter.Sections[2].Caption := l3GetStrPas(Strings[I]);
          DOSFiler.FileName := ResListFooter.Sections[2].Caption;
          P.Title := Application.Title + ': ' + DOSFiler.FileName;
          try
           TextSource.Load(Reader);
           if not TextSource.Document.IsValid then
            break
           else
            with TevDocumentPreview.Make(TextSource.Document, evDefaultPreviewCacheKey) do
            begin
             Printer := P;
             Print;
            end;//with TevDocumentPreview.Make(k2Tag(TextSource.DocumentContainer.Document))
           lstSrchResult.Selected[I] := false;
          finally
           TextSource.DocumentContainer := nil;
          end;{try..finally}
         end;
        if (SelectCount = 0) then Exit;
       end;
     finally
      l3Free(P);
     end;{try..finally}
    end;
  finally
   tbStopFind.Enabled := false;
   sbPrint.Enabled := true;
  end;{try..finally}
 end;

procedure TFileSrchForm.TextSourceProgressProc(aState: Byte; aValue: Longint; const aMsg: String);
begin
 Case aState of
  piStart: begin
   Progress.MaxNumber := aValue;
   Progress.CurNumber := 0;
   Progress.Visible := true;
   ResListFooter.Sections[0].Caption := '';
   ResListFooter.Sections[1].Caption := aMsg;
  end;
  piCurrent:
   Progress.CurNumber := aValue;
  piEnd: begin
   Progress.Visible := false;
   Progress.MaxNumber := 0;
   ResListFooter.Sections[1].Caption := '';
  end;
 end;
end;

procedure TFileSrchForm.ResListFooterSizing(Sender: TObject; ASection,
  AWidth: Integer);
 Var
  C : TControl;
  Delta : Integer absolute AWidth;
 begin
  if Delta=0 then Exit;
  C:=nil;

  Case ASection of
    0 : C := ResListFooter;
{    1 : C:= Progress;
    2 : C := pnMemory;
    3 : C:=ColorComboBox;
    4 : C:=FormatSpeedBar;}
  end;

  If Assigned(C) then C.Width := C.Width + Delta;

(*  For I := Succ(ASection) to Pred(StatusLine.Sections.Count) do {MoveSection}
   Begin
    Case I of
     0 : ;
     1 : Progress.Left := Progress.Left + Delta;
     2 : pnMemory.Left := pnMemory.Left + Delta;
{     3 : ColorComboBox.Left:=ColorComboBox.Left+Delta;
     4 : FormatSpeedBar.Left:=FormatSpeedBar.Left+Delta;}
    end;
   end;*)
 end;

function FileSrchForm : TFileSrchForm;
  {-}
begin
 if (l_FileSrchForm = nil) then
  l_FileSrchForm := TFileSrchForm.Create(Application);
 Result := l_FileSrchForm; 
end;

end.
