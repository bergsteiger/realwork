unit DictEntryWin;

{ $Id: DictEntryWin.pas,v 1.64 2015/04/03 07:50:48 voba Exp $ }

// $Log: DictEntryWin.pas,v $
// Revision 1.64  2015/04/03 07:50:48  voba
// - снес TDocumentData
//
// Revision 1.63  2015/03/13 12:00:08  voba
// - локальное автосохранение документов
//
// Revision 1.62  2015/01/14 13:43:21  voba
// - bug fix : маска прав неправильно считалась для AccGroup
//
// Revision 1.61  2014/04/03 13:13:01  voba
//  k:236721575 (Атрибуты в EVD)  Merge
//
// Revision 1.60.2.2  2013/10/25 09:10:17  voba
// - k:236721575 (Атрибуты в EVD)
//
// Revision 1.60.2.1  2013/07/19 09:14:40  voba
// - K:236721575 (Загрузка и запись атрибутов из тегов EVD)
//
// Revision 1.60  2013/04/04 09:19:39  fireton
// - логика простановки VANONCED
//
// Revision 1.59  2012/06/05 13:19:41  voba
// - убрал зоопарк инклюдов в опциями компиляции, оставил только ProjectDefine.inc
//
// Revision 1.58.2.1  2011/06/20 09:07:13  voba
// - k : 236721575
//
// Revision 1.58  2011/02/17 07:25:07  dinishev
// [$254351028]
//
// Revision 1.57  2011/01/21 16:16:48  dinishev
// [$185830965]
//
// Revision 1.56.2.3  2011/04/08 07:53:36  voba
// - k : 236721575
//
// Revision 1.56.2.2  2011/03/25 10:26:00  voba
// - k : 236721575
//
// Revision 1.56.2.1  2011/02/16 13:26:15  voba
// - k : 236721575
//
// Revision 1.56  2010/09/24 12:15:31  voba
// - k : 235046326
//
// Revision 1.55  2009/11/09 11:54:02  voba
// no message
//
// Revision 1.54  2009/06/02 18:06:56  lulin
// - компилируем Архивариус в ветке.
//
// Revision 1.53  2009/06/02 17:23:13  lulin
// - удалены ненужные интерфейсы и переопределения типов.
//
// Revision 1.52  2009/06/02 13:47:36  lulin
// [$148574526].
//
// Revision 1.51  2009/06/01 16:07:41  lulin
// [$148574348].
//
// Revision 1.50  2009/05/29 17:30:35  lulin
// [$142610853].
//
// Revision 1.49  2009/04/08 11:32:11  oman
// - new: В JumpTo подаем не состояние мыши а желаемое поведение - [$140287160]
//
// Revision 1.48  2009/01/19 14:22:09  dinishev
// CleanUp
//
// Revision 1.47  2008/10/13 13:37:00  dinishev
// <K> : 84640081
//
// Revision 1.46  2008/06/20 14:48:43  lulin
// - используем префиксы элементов.
//
// Revision 1.45  2008/06/18 13:18:53  dinishev
// Bug fix: зависали при открытии документа
//
// Revision 1.44  2008/06/18 11:53:54  dinishev
// По возможности вычищаем ARCHI_OLD_EVEREST
//
// Revision 1.43  2008/06/17 11:47:33  dinishev
// По возможности вычищаем ARCHI_OLD_EVEREST
//
// Revision 1.42  2008/05/28 11:22:56  voba
// no message
//
// Revision 1.41  2008/05/23 06:43:54  voba
// - bug fix
//
// Revision 1.40  2008/05/20 10:52:00  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.39  2008/04/16 12:55:55  lulin
// - синхронизируем список параметров.
//
// Revision 1.38  2008/04/16 11:17:04  lulin
// - синхронизируем список параметров.
//
// Revision 1.37  2008/04/16 11:10:14  lulin
// - синхронизируем список параметров.
//
// Revision 1.36  2008/04/15 08:31:38  dinishev
// Восстанавливаем старый редактор
//
// Revision 1.35  2007/12/03 09:58:07  dinishev
// Используем редактор из ветки
//
// Revision 1.34  2007/02/12 16:15:41  voba
// no message
//
// Revision 1.33  2006/12/07 11:27:43  voba
// - remove l3Control, l3InputControl;
//
// Revision 1.32  2005/11/28 13:45:23  voba
// no message
//
// Revision 1.31  2005/11/25 13:32:39  voba
// no message
//
// Revision 1.30  2005/08/09 15:22:52  voba
// no message
//
// Revision 1.29  2005/07/01 10:30:42  voba
// no message
//
// Revision 1.28  2005/05/30 10:55:54  lulin
// - new unit: vtGroupBoxEx.
//
// Revision 1.27  2005/05/27 14:44:16  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.26  2005/05/17 12:23:47  voba
// no message
//
// Revision 1.25  2005/04/19 16:07:33  voba
// no message
//
// Revision 1.24  2005/04/06 10:59:24  voba
// no message
//
// Revision 1.23  2005/03/24 12:29:27  voba
// no message
//
// Revision 1.22  2005/03/14 09:53:29  step
// в структуре TCardRec: замена PChar --> string
//
// Revision 1.21  2005/03/11 17:24:40  voba
// no message
//
// Revision 1.20  2005/03/10 16:48:49  step
// замена: DocData.FullCard^.Card^ --> DocData.Card^
//
// Revision 1.19  2005/02/18 14:30:30  voba
// - ынес DOCID и Family в новый класс DocInfo
//
// Revision 1.18  2005/02/14 16:35:50  lulin
// - в Архивариусе сделана возможность указать с каким потоком документа работать.
//
// Revision 1.17  2004/12/11 12:43:01  voba
// no message
//
// Revision 1.16  2004/12/09 10:09:49  voba
// no message
//
// Revision 1.15  2004/11/26 13:40:21  voba
// no message
//
// Revision 1.14  2004/11/25 09:27:59  lulin
// - прописаны пути.
// - поправлены ошибки - не компилировалось.
//
// Revision 1.13  2004/11/17 14:34:55  voba
// no message
//
// Revision 1.12  2004/10/11 14:42:17  voba
// no message
//
// Revision 1.11  2004/09/06 11:32:30  voba
// no message
//
// Revision 1.10  2004/08/02 13:12:27  voba
// no message
//
// Revision 1.9  2004/05/25 07:57:28  voba
// no message
//
// Revision 1.8  2004/05/14 15:35:17  law
// - remove unit: evTypesE.
//
// Revision 1.7  2004/05/14 13:28:05  voba
// no message
//
// Revision 1.6  2004/05/12 13:23:18  voba
// no message
//

{$I ProjectDefine.inc}

interface

uses
  Windows, 
  Messages, 
  SysUtils, 
  Classes,
  Graphics, 
  Controls, 
  Forms, 
  Menus, 
  AdvMenus,
  Dialogs, 
  StdCtrls, 
  ExtCtrls, 
  ComCtrls,
  CustEditWin,
  
  l3Tree,

  evInternalInterfaces,
  evEditorInterfaces,
  evMenu,  
  evEditorWindow, 
  evMultiSelectEditorWindow, 
  evCustomEditor, 
  evEditor,
  evMemo, 
  evEdit,
  evEditorWithOperations, 
  evTextSource,
  evCustomTextSource,

  nevTools,
  nevNavigation,
  
  DT_Types, 
  DT_Const, 
  dt_AttrSchema,
  DT_Serv,

  DocIntf,

  TypeShop,

  F_AttrExplorer, 
  F_TextEditor,

  OvcBase, 

  vtGroupBoxEx,
  vtGroupBox, 
  vtCtrls, 
  vtForm,

  afwInterfaces,  
  afwControl, evCustomEdit, evCustomMemo, nevGUIInterfaces,

  afwNavigation, afwControlPrim, afwBaseControl, nevControl,
  evCustomEditorWindowPrim, evCustomEditorWindowModelPart,
  evCustomEditorModelPart, evCustomEditorWindow
  ;

type
  TDictEntryWindow = class(TCustomEditorWindow)
    Panel2: TPanel;
    DocTextEditor: TTextEditorWin;
    ClipbrdPopUpMenu: TLinkPopUpMenu;
    piCut: TMenuItem;
    piCopy: TMenuItem;
    piPaste: TMenuItem;
    piAddToClipboard: TevMenuItem;
    N4: TMenuItem;
    nbkDocPages: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    MainAttrExplorer: TAttrExplorer;
    MainMenu: TMainMenu;
    miText: TMenuItem;
    miSave: TMenuItem;
    miSaveAs: TMenuItem;
    miSelectAll: TMenuItem;
    miUndo: TMenuItem;
    miRedo: TMenuItem;
    miSplitLine: TMenuItem;
    miCut: TMenuItem;
    miCopy: TMenuItem;
    miPaste: TMenuItem;
    miAddToClipboard: TMenuItem;
    miPasteFromFile: TMenuItem;
    miPasteSpecial: TMenuItem;
    miStyle: TMenuItem;
    miUserColorSegment: TMenuItem;
    miUserMonoWidth: TMenuItem;
    miJustLeft: TMenuItem;
    miJustCenter: TMenuItem;
    miJustRight: TMenuItem;
    miJustWide: TMenuItem;
    miSetTextInvisible: TMenuItem;
    miSetTextVisible: TMenuItem;
    miHyperText: TMenuItem;
    mi_SetSub: TMenuItem;
    mi_RemoveSub: TMenuItem;
    miSetReference: TMenuItem;
    miSetReferenceDirect: TMenuItem;
    mi_RemoveReference: TMenuItem;
    miGoByRef: TMenuItem;
    miSearch: TMenuItem;
    miFind: TMenuItem;
    miReplace: TMenuItem;
    miSrchAgain: TMenuItem;
    miFindDictEntryBySelect: TMenuItem;
    miGotoNextOccur: TMenuItem;
    GroupBox1: TvtGroupBoxEx;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtShortName2: TevEdit;
    edtShortName3: TevEdit;
    edtShortName1: TevEdit;
    edtShortName4: TevEdit;
    edtShortName5: TevEdit;
    edtShortName6: TevEdit;
    vtGroupBoxEx1: TvtGroupBoxEx;
    HyperTextPopupMenu: TLinkPopUpMenu;
    pmSetReference: TMenuItem;
    pmRemoveReference: TMenuItem;
    N6: TMenuItem;
    piFindDictEntryBySelect: TMenuItem;
    N7: TMenuItem;

    procedure GetAttrTreeListOnSub(aSub : Integer; aDictSet : TdtAttributeSet; aTreeSel : TTreeSelector = tsAll); override;
    procedure miSaveClick(Sender: TObject);
    procedure miSaveAsClick(Sender: TObject);
    procedure miSelectAllClick(Sender: TObject);
    procedure miSetReferenceClick(Sender: TObject);
    procedure mi_RemoveReferenceClick(Sender: TObject);
    procedure miGoByRefClick(Sender: TObject);
    procedure miFindClick(Sender: TObject);
    procedure miReplaceClick(Sender: TObject);
    procedure miSrchAgainClick(Sender: TObject);
    procedure piFindDictEntryBySelectClick(Sender: TObject);
    procedure DocTextEditorDocEditorStyleChange(Sender: TObject;  const Style: IedStyle);
    function DocTextEditorDocEditorJumpTo(Sender: TObject;
      const anEffects : TafwJumpToEffects; const aMoniker: IevMoniker): Boolean;
  private
    procedure evntCursorInReference(aSender : TTextEditorWin; const aHyperlink : IevHyperlink);
    procedure evntGetHotspotInfo(Sender : TObject;
                                 const aHotSpot : IevHotSpot;
                                 const aKeys    : TafwCursorState;
                                 var theInfo : TafwCursorInfo);
  protected
    function GetCurEditor : TevCustomEditor; override;
    function IsNeedSaveDocument: Boolean; override;
    function TextSourcesCloseQuery: Boolean; override;
    procedure TuneDocument(aDocument : TarDocument); override;
    procedure SetCaption; override;
    procedure evntFinishInsertFromFile(Sender : TObject); override;
    procedure DocumentSourceAllowGotoSub(Sender: TObject; const aPoint : IevDocumentPoint); override;
    function  IsDocParamChange(aClose : Boolean = True): Boolean; override;
    procedure DocumentMakeTextSource(aSender: TObject; out theTextSource: TevCustomTextSource); virtual;
  public
    constructor Create(AOwner: TComponent; aDocument : TarDocument = nil);
    procedure LoadDoc; override;
    procedure LoadDocEx(aNewDoc : Boolean);
    procedure SaveDocument(aClose : Boolean = True); override;
    procedure GoToSub(aGoToSubID : Integer = 0; aDocID : TDocID = 0); virtual;
    procedure SetSpeedButton(Enabled : Boolean); override;
    function IsCutPasteEnable: Boolean; virtual;
  end;

implementation

{$R *.dfm}

uses
 m3DBInterfaces,
 l3Types,
 l3Base, l3Chars, l3String,
 VConst, vtClipSpy, vtMenus,
 Com_Cnst,
 Dt_IndexSupport,
 evTypes, evdStyles,
 D_TxSrch,
 IDocSpc,
 DocAttrIntf, DocAttrToolsIntf,
 evFacadeSub,
 evFacadeGUI,
 evFacadTextSource,
 IniShop, Main,

 evdDOM
 ;

constructor TDictEntryWindow.Create(AOwner: TComponent; aDocument : TarDocument = nil);
begin
 Inherited;
 DocTextEditor.OnCursorInReference := evntCursorInReference;
 DocTextEditor.OnMakeTextSource := DocumentMakeTextSource;
 DocTextEditor.DocEditor.Zoom := IniRec.Zoom;
 DocTextEditor.DocEditor.Canvas.DrawSpecial := IniRec.ShowSpecSymbol;
 DocTextEditor.DocEditor.OnGetHotspotInfo := evntGetHotspotInfo;

 DocTextEditor.DocEditor.WebStyle := IniRec.ShowWebStyle;
 evSetShowDocumentParts(DocTextEditor.DocEditor, nil, True);
 //MainAttrExplorer.AttrSet := GlMainAttrSetForDictEntry;
 //MainAttrExplorer.SetTreeListReadOnly(True, [aidDocIDs]);
end;

procedure TDictEntryWindow.LoadDoc;
begin
 LoadDocEx(False);
end;

procedure TDictEntryWindow.DocumentMakeTextSource(aSender: TObject; out theTextSource: TevCustomTextSource);
begin
 inherited;
 theTextSource.Processor.DefaultStyle := ev_saDictEntry;
end;

procedure TDictEntryWindow.LoadDocEx(aNewDoc : Boolean);
var
 lDictEntry : IevdDictEntry;
 I : Integer;
 lID : Integer;
 lDocAttribute : IDictAttributeTool;
begin
 MainAttrExplorer.AttrSet := GlMainAttrSetForDictEntry;
 MainAttrExplorer.SetTreeListReadOnly(True, [atRenum]);
 
 if aNewDoc then
 begin
  Document.MakeNew(dtDictEntry);

  repeat
   try
    Document.UserDocID := GlobalHtServer.FreeTbl[DocFamily].GetFree(NameDictExternalNumber);
    Break;
   except
    on EAssignError do;
   end;
  until False;

  Document.CreateNewText;

  lDocAttribute := (Document.AttrManager.GetDocAttribute(atBases) as IDictAttributeTool);
  if lDocAttribute <> nil then
  begin
   lID := 170;
   lDocAttribute.AddRec(lID);
  end;

  lDocAttribute := (Document.AttrManager.GetDocAttribute(atAccGroups) as IDictAttributeTool);
  if lDocAttribute <> nil then
  begin
   lID := 47;
   lDocAttribute.AddRec(lID);
  end;

  MainAttrExplorer.GetAttrTreeListOnSub(0);
  SetCaption;
  IsNewDoc := True;
 end
 else
 begin
  Document.LoadText;
  MainAttrExplorer.GetAttrTreeListOnSub(0);

  if Supports(Document.TextSource, IevdDictEntry, lDictEntry) then
   try
    for I := 0 to 5 do
     with FindComponent(Format('edtShortName%d', [Succ(I)])) as TevEdit do
     begin
      Buffer := lDictEntry.ShortName[TevdLanguage(I)];
      if i = 0 then DocName := l3GetStrPas(Buffer.S);
     end;
   finally
    lDictEntry := nil;
   end;
 end;
end;

procedure TDictEntryWindow.TuneDocument(aDocument : TarDocument);
begin
 inherited;
 MainAttrExplorer.Document := Document;
end;

function TDictEntryWindow.IsDocParamChange(aClose : Boolean = True): Boolean;
var
 I : Integer;
begin
 Result := inherited IsDocParamChange(aClose);
 if Result then Exit;

 for I := 0 to 5 do
  with FindComponent(Format('edtShortName%d', [Succ(I)])) as TevEdit do
   if Modified then
   begin
    Result := True;
    Exit;
   end;
end;

procedure TDictEntryWindow.SaveDocument(aClose : Boolean = True);
var
 lDictEntry : IevdDictEntry;
 I : Integer;
 lStr : Tl3String;
 lEdit : TevEdit;
begin
 StopAutoSave;
 try
  Screen.Cursor := crHourGlass;
  try
   if Supports(Document.TextSource, IevdDictEntry, lDictEntry) then
    try
     for I := 0 to 5 do // по языкам
     begin
      lEdit := FindComponent(Format('edtShortName%d', [Succ(I)])) as TevEdit;
      if lEdit.Modified then
      begin
       lDictEntry.ShortName[TevdLanguage(I)] := Tl3PCharLen(lEdit.Buffer);
       if i = 0 then
       begin
        with Document do
        begin
         lStr := Tl3String.Make(lEdit.Buffer);
         try
          lStr.CodePage := CP_ANSI;
          lStr.TrimAll;
          ShortName := lStr.AsWStr;

          if not aClose then
           DocName := l3Str(ShortName);
         finally
          l3Free(lStr);
         end;
         Document.AddLog(acAttrWork);
        end;
       end;
      end;
     end;
    finally
     lDictEntry := nil;
    end;

   if IsNewDoc or Document.IsModified([m3_dsMain]) then
   begin
    try
     Document.Save(True);
     //Document.TextSource.SaveText;
     //Document.DocData.SetTextChangedFlag;

     if (DocID <> 0) then
      Document.AddLog(acTextWork);
    except
     on E : Exception do Application.ShowException(E);
    end;
   end;


   //Document.SaveDocData;

   IsNewDoc := False;
  finally
   Screen.Cursor := crDefault;
  end;
 finally
  StartAutoSave;
 end;
end;

function TDictEntryWindow.GetCurEditor: TevCustomEditor;
begin
 Result := DocTextEditor.DocEditor;
end;

function TDictEntryWindow.IsNeedSaveDocument: boolean;
begin
 Result := not ReadOnly and (Document.TextSource.Modified or IsNewDoc or IsDocParamChange);
end;

function TDictEntryWindow.TextSourcesCloseQuery: boolean;
begin
 Result := Document.TextSource.CloseQuery(Handle);
end;

procedure TDictEntryWindow.GoToSub(aGoToSubID : Integer = 0; aDocID : TDocID = 0);
begin
 evSubSelect(DocTextEditor.DocEditor, aGoToSubID);
end;

procedure TDictEntryWindow.SetCaption;
var
 lStr : string;
begin
  lStr := 'Словарная статья';
  if IniRec.ShowIDinCaption then lStr := lStr + ' [%d]';
  lStr := Format(lStr, [Document.UserDocID]);
  if Length(DocName) > 0 then
   lStr := lStr + ' ' + DocName;
  Caption := lStr;
end;

procedure TDictEntryWindow.GetAttrTreeListOnSub(aSub : Integer; aDictSet : TdtAttributeSet; aTreeSel : TTreeSelector = tsAll);
 begin
  try
   Screen.Cursor:=crHourGlass;

   {If (aTreeSel in [tsAll, tsAttr])
    then MainAttrExplorer.GetAttrTreeListOnSub(aSub, aDictSet, aTree, aStopNotify);

   If (aTreeSel in [tsAll, tsSubAttr])
    then SubAttrExplorer.GetAttrTreeListOnSub(aSub, aDictSet, aTree, aStopNotify);
   }
  finally
   Screen.Cursor:=crDefault;
  end;
 end;

procedure TDictEntryWindow.evntFinishInsertFromFile(Sender : TObject);
begin
 Inherited;
  //refresh Attributes
 //GetAttrTreeListOnSub(0, MainAttrExplorer.AttrSet, nil, tsAll, not fStructInit {aStopNotify});
end;

procedure TDictEntryWindow.DocumentSourceAllowGotoSub(Sender: TObject; const aPoint : IevDocumentPoint);
begin
 //with DocTextEditor.DocEditor do TextSource.SubEx[SubHandle, SubType].Select(Selection);
 aPoint.Select(DocTextEditor.DocEditor.Selection);
end;

procedure TDictEntryWindow.SetSpeedButton(Enabled : Boolean);
 var
  EditEnabled : Boolean;
  EditandMemoEnabled : Boolean;
  lTestRes : Boolean;
  lCurRO : Boolean;
 begin
  If Application.Terminated then Exit;
  //If not fStructInit then Exit;

  EditEnabled := Enabled and
                 ((Document.LockMask and acgText) <> 0) and
                 (ActiveControl is TevCustomEditorWindow);

  MainForm.acSpellChecker.Enabled := EditEnabled;
  //MainForm.sbGotoNextFindWord.Enabled := EditEnabled and (ReadOnly or Assigned(FindSubList));
  MainForm.acGotoNextOccur.Enabled := EditEnabled and (DocJumpData.DocJumpType <> djNone);
  MainForm.acGotoPrevOccur.Enabled := {EditEnabled and ReadOnly} False;

  {Clipboard}
  EditEnabled := Enabled and IsCutPasteEnable;

  MainForm.acCut   .Enabled := EditEnabled and not ReadOnly;
  MainForm.acCopy  .Enabled := EditEnabled;
  MainForm.acPaste .Enabled := EditEnabled and not ReadOnly and
                               not ClipboardIsEmpty;

  {Editor}
 {Text & Spravka}
  lCurRO := Not Enabled or ((Document.LockMask and acgText) = 0) or ReadOnly;

  EditEnabled := (Enabled and (ActiveControl is TevEditor));
  EditandMemoEnabled := (Enabled and ((ActiveControl is TevCustomEditor)));

  //MainForm.sbAddToClipboard   .Enabled := EditEnabled;
  MainForm.acSave             .Enabled := Enabled and not ReadOnly;
  MainForm.acPrint            .Enabled := EditEnabled;
  MainForm.acSpellChecker     .Enabled := EditandMemoEnabled and not lCurRO;
  MainForm.acFind             .Enabled := EditEnabled;
  MainForm.acDrawLines        .Enabled := Enabled and not lCurRO;
  MainForm.acFindNext         .Enabled := EditEnabled;
  MainForm.acShowSpecSymbol   .Enabled := Enabled {EditandMemoEnabled} and not lCurRO;
  //MainForm.acPreviewMode      .Enabled := Enabled;
  MainForm.acWebStyle         .Enabled := Enabled;
  //MainForm.acShowDocumentParts.Enabled := Enabled;

  //acGetCorespondentsForBlock            .Enabled := EditEnabled;
  //acReplaceHRefDocForBlockCorrespondents.Enabled := EditEnabled;

  MainForm.acRedo          .Enabled := EditandMemoEnabled and not lCurRO and
                                       (ActiveControl as TevCustomEditor).CanRedo;
  MainForm.acUndo          .Enabled := EditandMemoEnabled and not lCurRO and
                                       (ActiveControl as TevCustomEditor).CanUndo;

  {MainForm.FormatToolbar   .Visible := True;}
  MainForm.acBold          .Enabled := EditEnabled and not lCurRO;
  MainForm.acItalic        .Enabled := EditEnabled and not lCurRO;
  MainForm.acUnderline     .Enabled := EditEnabled and not lCurRO;
  MainForm.acJustifyWidth  .Enabled := EditEnabled and not lCurRO;
  MainForm.acJustifyRight  .Enabled := EditEnabled and not lCurRO;
  MainForm.acJustifyLeft   .Enabled := EditEnabled and not lCurRO;
  MainForm.acJustifyCenter .Enabled := EditEnabled and not lCurRO;
  MainForm.acJustifyPreformatted.Enabled := EditEnabled and not lCurRO;

  MainForm.acHidingText    .Enabled := EditEnabled and not lCurRO;

  MainForm.StyleComboBox   .Enabled := EditEnabled and not lCurRO;
  //MainForm.FontComboBox    .Enabled := EditEnabled and not lCurRO;
  MainForm.FontSizeComboBox.Enabled := EditEnabled and not lCurRO;

  //MainForm.ColorComboBox   .Enabled := EditEnabled and not lCurRO;

  //MainForm.dxBarComboStyle    .ReadOnly := Not(EditEnabled and not lCurRO);
  //MainForm.dxBarComboFontName .ReadOnly := Not(EditEnabled and not lCurRO);
  //MainForm.dxBarComboColor    .ReadOnly := Not(EditEnabled and not lCurRO);
  //MainForm.dxBarComboFontSize .ReadOnly := Not(EditEnabled and not lCurRO);

  MainForm.seZoom          .Enabled := EditEnabled;
  //MainForm.dxseZoom        .Enabled := EditEnabled;

  //!vtVisibleAndEnabled(miText,         EditEnabled);
  //vtVisibleAndEnabled(miTable,        EditEnabled);
  //vtVisibleAndEnabled(miInsertMenu,   EditEnabled);
  //vtVisibleAndEnabled(mi_SetSub,      EditEnabled);
  //vtVisibleAndEnabled(mi_RemoveSub,   EditEnabled);
  //!vtVisibleAndEnabled(miSetReference, EditEnabled);

  //!acSetSub                   .Enabled := EditEnabled;
  //!acTextReplace              .Enabled := EditEnabled;
  //!acRefReplace               .Enabled := EditEnabled;
  //!acSetReferenceBegin        .Enabled := EditEnabled;
  //acSetReferenceEnd          .Enabled := EditEnabled;

  //TvtMenuItem(miSetReferenceDirect) .vtVisibleAndEnabled := EditEnabled;
  //!vtVisibleAndEnabled(mi_RemoveReference, EditEnabled);

  //TvtMenuItem(miHyperText)    .vtVisibleAndEnabled := EditEnabled;

  //!vtVisibleAndEnabled(miSearch, EditEnabled);

  //!vtVisibleAndEnabled(miTranformText, EditandMemoEnabled);
  //vtVisibleAndEnabled(miAnaliseParam, EditEnabled);
  //vtVisibleAndEnabled(miFindTNVED,    EditEnabled);
  //vtVisibleAndEnabled(miSetVChanged,  Enabled and not ReadOnly);
  //vtVisibleAndEnabled(miSetVLControl, Enabled and not ReadOnly);
  //vtVisibleAndEnabled(miUrOpSetAbolished, Enabled and not ReadOnly);
  //vtVisibleAndEnabled(miSetMOJNotReg, Enabled and not ReadOnly);

  If EditandMemoEnabled then
   With ActiveControl as TevCustomEditor do
    begin
     MainForm.FreezeFontCombo := true;
     try
      MainForm.acShowSpecSymbol.Checked := Canvas.DrawSpecial;
     finally
      MainForm.FreezeFontCombo := False;
     end;
    end;

  If EditEnabled then
   With ActiveControl as TevEditor do
    begin
      MainForm.acShowSpecSymbol   .Checked := Canvas.DrawSpecial;
      //MainForm.acPreviewMode      .Checked := TextSource.DocumentContainer.Preview;
      MainForm.acWebStyle         .Checked := WebStyle;
      MainForm.acShowDocumentParts.Checked := evGetShowDocumentParts(ActiveControl as TevEditor);


      //!EditorFontChange(CurEditor, TextPara.Font);
      //!EditorParaChange(CurEditor, TextPara);
      //1EditorStyleChange(CurEditor, TextPara.Style);

      {seZoomExit(CurEditor);}

      MainForm.seZoom.AsInteger   := Canvas.Zoom;
      //MainForm.dxseZoom.Value := Canvas.Zoom;
    end;

  //If Not FGroupMode and Enabled then SetReadOnlyMask(Document.LockMask);
 end;


procedure TDictEntryWindow.miSaveClick(Sender: TObject);
begin
 SaveDocument(False);
end;

procedure TDictEntryWindow.miSaveAsClick(Sender: TObject);
begin
//
end;

procedure TDictEntryWindow.miSelectAllClick(Sender: TObject);
begin
 CurEditor.Select(ev_stDocument);
end;

procedure TDictEntryWindow.miSetReferenceClick(Sender: TObject);
begin
 InitSetReference;
end;

procedure TDictEntryWindow.mi_RemoveReferenceClick(Sender: TObject);
begin
 RemoveReference;
end;

procedure TDictEntryWindow.miGoByRefClick(Sender: TObject);
begin
 GoByRefClick;
end;

procedure TDictEntryWindow.miFindClick(Sender: TObject);
begin
 Find;
end;

procedure TDictEntryWindow.miReplaceClick(Sender: TObject);
begin
 Replace;
end;

procedure TDictEntryWindow.miSrchAgainClick(Sender: TObject);
begin
 FindNext;
end;

procedure TDictEntryWindow.piFindDictEntryBySelectClick(Sender: TObject);
begin
 With IDocSpecial.Create(Self) do
  Try
   SearchBySelectText(itDictEntry);
  finally
   Free;
  end;
end;

procedure TDictEntryWindow.evntCursorInReference(aSender : TTextEditorWin; const aHyperLink : IevHyperlink);
begin
 aSender.FooterPanel.Panels[2].Text := GetReferenceHintString(aHyperLink);
end;

procedure TDictEntryWindow.evntGetHotspotInfo(Sender         : TObject;
                                           const aHotSpot : IevHotSpot;
                                              const aKeys    : TafwCursorState;
                                           var theInfo    : TafwCursorInfo);
begin
 theInfo.rHint := l3CStr(GetReferenceHintString(aHotSpot, l3Str(theInfo.rHint)));
end;

function TDictEntryWindow.IsCutPasteEnable: Boolean;
begin
 Result := not ReadOnly and
           (ActiveControl is TevCustomEditorWindow);
end;

procedure TDictEntryWindow.DocTextEditorDocEditorStyleChange(Sender: TObject; const Style: IedStyle);
begin
 EditorStyleChange(Style);
end;

function TDictEntryWindow.DocTextEditorDocEditorJumpTo(Sender: TObject;
  const anEffects : TafwJumpToEffects; const aMoniker: IevMoniker): Boolean;
begin
 DocEditorJumpTo(aMoniker);
end;

end.
