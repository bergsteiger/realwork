unit Main;

{ $Id: MAIN.PAS,v 1.136 2016/10/21 07:40:03 lukyanets Exp $ }

{$I arDefine.inc }

interface

{Load StyleTable}

uses
     daTypes,
     daInterfaces,
     Windows, SysUtils,
     Classes, Graphics, Forms, Controls, Menus,
     StdCtrls, Dialogs, Buttons, Messages, ExtCtrls,
     ActnList, StdActns, ComCtrls,
     AdvMenus, ddSpell,  JwaPbt,

     DT_Const, DT_Types, dt_AttrSchema, DT_Query, DT_SrchQueries, Dt_Hyper,
     VConst, TypeShop, ImgList, nevTools,

     BackPnl, DocStack, DragData,

     ObjExWin, CustEditWin,

     OvcBase, ovcCmd,

     vtSpin, vtDialogs, vtMenus, l3ClipboardSpy,
     vtlister, vtOutliner, vtCtrls,
     RXCtrls, RXCombos,

     l3Date,  l3Interfaces, l3Types,
     l3DatLst, l3RecList, l3Filer, l3Forms,
     l3ProgressComponent, l3InternalInterfaces, l3InterfacedComponent,

     k2Base, k2Tags, k2TagGen, k2FileGenerator, k2Reader, k2StackGenerator,

     TB97, TB97Tlbr, TB97Ctls, tb97Control, tb97GraphicControl,

     dxBar, dxBarExtItems,
     evSubPn, evEvdRd,
     evIntf, evTextSource, evAction, evButton, evdReader, evdWriter,

     arTypes, DocIntf,

     afwControl, afwCustomCommonControl, afwInterfaces,
     afwApplication, vtStatusBar, afwControlPrim, afwBaseControl,
     afwCustomCommonControlPrim, vtColorBox, nevControl, evEditorWindow,
     evMultiSelectEditorWindow, evCustomEditor, evEditorWithOperations,
     evCustomMemo, evCustomEdit,
     ctButtonEdit, ctAbstractEdit, AbstractDropDown, DropDownTree, EditableBox, FakeBox,
     elCustomButtonEdit, elCustomEdit,
     evCustomEditorWindowModelPart, evCustomEditorWindowPrim
     // - это надо, чтобы подключить "стандартную" реализацию AFW
     , LOGO, evCustomEditorModelPart, evCustomEditorWindow,
     arTemplateProcessor, evSubPanel;

type
 TWinType = (wtUnknown, wtSrchWin, wtDocWin);
 TWinTypeSet = Set of TWinType;

 TarGetQueryFunc = function(aDateBounds : Tl3DateBounds): TdtQuery;

 TNewDocParams = record
  rDocType     : TDocType;
  rDocKind     : Integer;
  rDocName     : AnsiString;
  rAnalyseFile : TFileName;
  rDocAddr     : TDocAddr;
  rAnalyseLog  : Boolean;
 end;

  TMainForm = class(Tl3Form, IafwUserQuery, IdaLongProcessSubscriber, Il3ClipListner)
    acDelAllHyperLinks               : TAction;
    acCascade                        : TAction;
    acChangeClassifier               : TAction;
    acCloseActChildWin               : TAction;
    acDocImport                      : TAction;
    acDocOnStageStat                 : TAction;
    acExit                           : TAction;

    acFindDoc                        : TAction;
    acFindDocNext                    : TAction;
    acFindAbolished                  : TAction;
    acFindByJournal                  : TAction;
    acFindByStageInfo                : TAction;
    acFindIncludedPeriod             : TAction;
    acFindMisprints                  : TAction;
    acFindNewKeys                    : TAction;
    acHideObjectExplorer             : TAction;
    acMacroInsertDocChanges          : TAction;
    acLineup                         : TAction;
    acDelWarnings                    : TAction;
    acLoadClassDelta                 : TAction;
    acLoadClassLinkPack              : TAction;
    acLoadDocExtracts                : TAction;
    acLoadStyleSheet                 : TAction;
    acMakeClassifierCopy             : TAction;
    acMinimizeAll                    : TAction;
    acNewDocExtracts                 : TAction;
    acNewDocument                    : TAction;
    acOpenByNumber                   : TAction;
    acSaveAsStyleSheet               : TAction;
    acSaveDocExtracts                : TAction;
    acSaveLaying                     : TAction;
    acSetSpecialBase                 : TAction;
    acSettings                       : TAction;
    acShowObjectExplorer             : TAction;
    acStyleSheetEditor               : TAction;
    acTile                           : TAction;
    acToolbars                       : TAction;
    acUndoBuffer                     : TAction;
    acWindowsList                    : TAction;
    acAdd2Clipbrd                    : TevAction;
    acCopy                           : TAction;
    acCut                            : TAction;
    acDeleteColumn                   : TevAction;
    acDeleteRow                      : TevAction;
    acHSplit                         : TevAction;
    acInsertColumn                   : TevAction;
    acInsertRow                      : TevAction;
    acInsertTable                    : TevAction;
    acMergeCells                     : TevAction;
    acMergeCellsHorz                 : TevAction;
    acMergeCellsVert                 : TevAction;
    acMergeTables                    : TevAction;
    acPaste                          : TAction;
    acSpecialPaste                   : TevAction;
    acSplitCells                     : TevAction;
    acSplitTable                     : TevAction;
    acVSplit                         : TevAction;

    acMsgCopy                        : TvtStdMsgAction;
    acMsgCut                         : TvtStdMsgAction;
    acMsgPaste                       : TvtStdMsgAction;
    GeneralActionList: TActionList;
    ActionList2                      : TActionList;
    MainActionList                   : TActionList;
    ColorComboBox: TvtColorBox;
    LeftDock                         : TDock97;
    TopDock                          : TDock97;

    btBottom                         : TevButton;
    btTop                            : TevButton;
    btVCenter                        : TevButton;
    sbListToDocSet: TevButton;
    sbDelete                         : TevButton;
    sbDictDesign                     : TevButton;
    sbDictDesignTransformToDivision  : TevButton;
    sbDictDesignUndo                 : TevButton;
    sbDocStackList                   : TevButton;
    sbEdit                           : TevButton;
    sbLoadDocs                       : TevButton;
    sbRemoveItem                     : TevButton;
    sbRunEditor                      : TevButton;
    sbRunViewer                      : TevButton;
    sbSaveToFile                     : TevButton;
    sbShowClassTree                  : TevButton;
    sbShowKWTree                     : TevButton;
    sbShowSub                        : TevButton;
    sbSort                           : TevButton;
    sbStyleTable                     : TevButton;
    StyleFiler                       : TevDOSFiler;
    SubDescriptors                   : TevSubDescriptors;
    EverestWriter                    : TevdNativeWriter;
    EverestReader                    : TevEvdReader;
    FontComboBox                     : TFontComboBox;
    FontSizeComboBox                 : TFontSizeComboBox;
    ilOffice                         : TImageList;
    MainMenu                         : TMainMenu;
    MDIBackground                    : TMDIBackground;
    miUtils                          : TMenuItem;
    miToolbar                        : TMenuItem;
    StyleOpenDialog                  : TOpenDialog;
    DefaultController                : TOvcController;
    BottomDockPanel                  : TPanel;
    LeftDockPanel                    : TPanel;
    SysPanel                         : TPanel;
    pmExplorer                       : TPopupMenu;
    pmToolbar                        : TPopupMenu;
    PrintDialog                      : TPrintDialog;
    StyleSaveAsDialog                : TSaveDialog;
    StyleComboBox                    : TSpeedBarComboBox;
    StatusBar: TvtStatusBar;
    AtribToolbar                     : TToolbar97;
    DictToolbar                      : TToolbar97;
    FormatToolbar                    : TToolbar97;
    MainToolbar                      : TToolbar97;
    SearchToolbar                    : TToolbar97;
    StyleToolbar                     : TToolbar97;
    tbVerticalAligment               : TToolbar97;
    TextEditorToolbar                : TToolbar97;
    sbInsertTable: TToolbarButton97;
    ToolbarSep971                    : TToolbarSep97;
    ToolbarSep9710                   : TToolbarSep97;
    ToolbarSep9711                   : TToolbarSep97;
    ToolbarSep9712                   : TToolbarSep97;
    ToolbarSep9713                   : TToolbarSep97;
    ToolbarSep9714                   : TToolbarSep97;
    ToolbarSep9716                   : TToolbarSep97;
    ToolbarSep9718                   : TToolbarSep97;
    ToolbarSep972                    : TToolbarSep97;
    ToolbarSep973                    : TToolbarSep97;
    ToolbarSep974                    : TToolbarSep97;
    ToolbarSep975                    : TToolbarSep97;
    ToolbarSep976                    : TToolbarSep97;
    ToolbarSep977                    : TToolbarSep97;
    ToolbarSep978                    : TToolbarSep97;
    ToolbarSep979                    : TToolbarSep97;
    seZoom                           : TvtSpinEdit;
    HSplitter                        : TvtSplitter;
    VSplitter                        : TvtSplitter;
    acDocStackPrev: TAction;
    acDocStackNext: TAction;
    acShowSub: TAction;
    acRunEditor: TAction;
    acRunViewer: TAction;
    acRemoveFromDocSet: TAction;
    acDictDesign: TAction;
    acDictAdd: TAction;
    acDictEdit: TAction;
    acDictDelete: TAction;
    acDictSaveToFile: TAction;
    acDictSort: TAction;
    acDictUndo: TAction;
    acDictTransformToDivision: TAction;
    ToolbarButton971: TToolbarButton97;
    ToolbarButton972: TToolbarButton97;
    acHelpAbout: TAction;
    acHelp: TAction;
    acSave: TAction;
    acPrint: TAction;
    acUndo: TevAction;
    acRedo: TevAction;
    acShowSpecSymbol: TAction;
    acShowDocumentParts: TAction;
    acWebStyle: TAction;
    acFind: TAction;
    acFindNext: TAction;
    acGotoNextOccur: TAction;
    acGotoPrevOccur: TAction;
    acSpellChecker: TAction;
    acDrawLines: TevAction;
    acJustifyLeft: TevAction;
    acJustifyCenter: TevAction;
    acJustifyRight: TevAction;
    acJustifyPreformatted: TevAction;
    acJustifyWidth: TevAction;
    acBold: TevAction;
    acItalic: TevAction;
    acUnderline: TevAction;
    acHidingText: TevAction;
    acVAlignTop: TevAction;
    acVAlignCenter: TevAction;
    acVAlignBottom: TevAction;
    acMacroMakeDocEdition: TAction;
    miMacroMakeDocEdition: TMenuItem;
    miDel_0_FromRenum: TMenuItem;
    miFindAlarm: TMenuItem;
    miTaskQueryStatus: TMenuItem;
    N4: TMenuItem;
    acMacroReplaceFutureEditionToCurrent: TAction;
    N5: TMenuItem;
    acFindNewImageSource: TAction;
    N6: TMenuItem;
    acFindAnonced: TAction;
    N7: TMenuItem;
    acFindAlarm: TAction;
    acDeleteCell: TAction;
    acDeleteTable: TAction;
    acAutoCompleteProps: TAction;
    iAutoCompleteProps: TMenuItem;
    miInternalDelDoc: TMenuItem;
    acPrintAll: TAction;
    evButton1: TevButton;
    acShowSelect: TAction;
    sbShowSelect: TevButton;
    acFindByJurOperation: TAction;
    N8: TMenuItem;
    acAnno_CloseDay: TAction;
    miAnno_CloseDay: TMenuItem;
    acAnnoImportFromRTF: TAction;
    N9: TMenuItem;
    menuDicts: TMenuItem;
    DictActList: TActionList;
    acLoadDeltaKW: TAction;
    DictLine: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    acCommMonitor: TAction;
    N14: TMenuItem;
    acExportDictionary: TAction;
    miDelWarnings: TMenuItem;
    acAttrCopy: TAction;
    N15: TMenuItem;
    SubDescriptors1: TevSubDescriptors;
    N16: TMenuItem;
    FlashTimer: TTimer;
    acSaveDocExtractsAs: TAction;
    N17: TMenuItem;
    miSetPrefix: TMenuItem;
    acDoAutoclassify: TAction;
    N18: TMenuItem;
    acChangeLinkAddress: TAction;
    N19: TMenuItem;
    acShowDeferDeleletedItems: TAction;
    N20: TMenuItem;
    acAlignWithSeparator: TevAction;
    sbAlignWithSeparator: TevButton;
    acCloseAll: TAction;
    miWindowCloseAll: TMenuItem;
    acFindByDocLink: TAction;
    N21: TMenuItem;
    acLoadDictModify: TAction;
    N22: TMenuItem;
    acFindNoCompare: TAction;
    N23: TMenuItem;
    acFindWillBeActive: TAction;
    N24: TMenuItem;
    acCorrectMissPrints: TAction;
    N25: TMenuItem;
    acFindActBorder: TAction;
    N26: TMenuItem;
    miChangeDocReport: TMenuItem;
    N27: TMenuItem;
    miServerMenu: TMenuItem;
    actAACImport: TAction;
    N28: TMenuItem;
    miUncorrectREL: TMenuItem;
    acFindByCloneInPubIn: TAction;
    N29: TMenuItem;
    miTestDebug: TMenuItem;
    acDeliveryProfile: TAction;
    N30: TMenuItem;
    acSuperscript: TevAction;
    acSubscript: TevAction;
    ToolbarSep9715: TToolbarSep97;
    sbSupScript: TevButton;
    sbSuperScript: TevButton;
    procedure FormCreate(Sender: TObject);
    procedure WindowCascadeItemClick(Sender: TObject);
    procedure UpdateMenuItems(Sender: TObject);
    procedure WindowTileItemClick(Sender: TObject);
    procedure WindowArrangeItemClick(Sender: TObject);
    procedure acOpenNewDocClick(Sender: TObject);
    procedure acExitClick(Sender: TObject);
    procedure WindowMinimizeItemClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure acFindDocsClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure acHelpAboutClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure acShowSubClick(Sender: TObject);
    procedure acRunEditorClick(Sender: TObject);
    procedure acRemoveItemClick(Sender: TObject);
    procedure acSaveClick(Sender: TObject);
    procedure acPrintClick(Sender: TObject);
    procedure acCutClick(Sender: TObject);
    procedure acCopyClick(Sender: TObject);
    procedure acPasteClick(Sender: TObject);
    procedure acFindClick(Sender: TObject);
    procedure acFindNextClick(Sender: TObject);
    procedure StyleComboBoxChange(Sender: TObject);
    procedure StyleComboBoxDropDown(Sender: TObject);
    procedure FontComboBoxChange(Sender: TObject);
    procedure FontSizeComboBoxChange(Sender: TObject);
    procedure ColorComboBoxChange(Sender: TObject);
    procedure seZoomExit(Sender: TObject);
    procedure seZoomKeyPress(Sender: TObject; var Key: Char);
    procedure sbShowClassTreeClick(Sender: TObject);
    procedure sbListToDocSetClick(Sender: TObject);
    procedure sbShowKWTreeClick(Sender: TObject);
    procedure ClipBoardSpyChange(Sender: TObject);
    procedure acRunViewerClick(Sender: TObject);

    procedure CreateToolbarMenus;
    procedure miViewPanelsClick(Sender: TObject);
    procedure ToolbarVisibleChanged(Sender: TObject);

    procedure acAddClick(Sender: TObject);
    procedure acEditClick(Sender: TObject);
    procedure acDeleteClick(Sender: TObject);
    procedure acSortClick(Sender: TObject);
    procedure acSaveToFileClick(Sender: TObject);
    procedure acLoadDocExtactsClick(Sender: TObject);
    procedure acSaveDocExtractsClick(Sender: TObject);
    procedure sbDocStackListClick(Sender: TObject);
    procedure acGotoNextOccurClick(Sender: TObject);
    procedure piShowExplorerClick(Sender: TObject);
    procedure piHideExplorerClick(Sender: TObject);
    procedure acStyleSheetEditorClick(Sender: TObject);
    procedure acLoadStyleSheetClick(Sender: TObject);
    procedure acSaveAsStyleSheetClick(Sender: TObject);
    procedure acSaveLayingClick(Sender: TObject);
    procedure acFindAbolishedClick(Sender: TObject);
    procedure acSpellCheckerClick(Sender: TObject);
    procedure acGotoPrevOccurClick(Sender: TObject);
    procedure acOpenByNumberClick(Sender: TObject);
    procedure acHelpClick(Sender: TObject);
    procedure acFindByJournalClick(Sender: TObject);
    procedure acFindByStageInfoClick(Sender: TObject);
    procedure acSettingsClick(Sender: TObject);
    procedure seZoomBottomClick(Sender: TObject);
    procedure seZoomTopClick(Sender: TObject);
    procedure acDictDesignClick(Sender: TObject);
    procedure LeftDockPanelDockDrop(Sender: TObject; Source: TDragDockObject;
                                    X, Y: Integer);
    procedure LeftDockPanelDockOver(Sender: TObject; Source: TDragDockObject;
                                    X, Y: Integer; State: TDragState;
                                    var Accept: Boolean);
    procedure LeftDockPanelGetSiteInfo(Sender: TObject; DockClient: TControl;
                                       var InfluenceRect: TRect;
                                       MousePos: TPoint; var CanDock: Boolean);
    procedure LeftDockPanelUnDock(Sender: TObject; Client: TControl;
                                  NewTarget: TWinControl; var Allow: Boolean);
    procedure BottomDockPanelDockOver(Sender: TObject; Source: TDragDockObject;
                                      X, Y: Integer; State: TDragState;
                                      var Accept: Boolean);
    procedure LeftDockPanelResize(Sender: TObject);
    procedure BottomDockPanelResize(Sender: TObject);
    procedure acDocImportClick(Sender: TObject);
    procedure acMacroInsertDocChangesClick(Sender: TObject);
    procedure acDelAllHyperLinksClick(Sender: TObject);
    procedure acSetSpecBaseClick(Sender: TObject);
    procedure acFindIncludedPeriodClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FindByLogAction(const aQueryCaption : AnsiString;
                              const aResultWinCaption : AnsiString;
                              aLogAction : TLogActionType;
                              aUserID : TdaUserID;
                              aUserGr : Boolean);
    procedure acFindKWClick(Sender: TObject);
    procedure acDocOnStageStatClick(Sender: TObject);
    procedure acApplayClassDeltaClick(Sender: TObject);
    procedure acApplayClassBatchofLinkClick(Sender: TObject);
    procedure acShowSpecSymbolClick(Sender: TObject);
    procedure acCloseActChildWinExecute(Sender: TObject);
    procedure acReplaceClassFromProjectClick(Sender: TObject);
    procedure miMakeClassProjectClick(Sender: TObject);
    procedure acDictUndoClick(Sender: TObject);
    procedure acDelWarningsClick(Sender: TObject);
    procedure acFindMisprintsClick(Sender: TObject);
    procedure acWinListClick(Sender: TObject);
    procedure acWebStyleClick(Sender: TObject);
    procedure acShowDocumentPartsClick(Sender: TObject);
    procedure acDictTransformToDivisionClick(Sender: TObject);
    procedure acUndoBufferClick(Sender: TObject);
    procedure acNewDocSetExtactsClick(Sender: TObject);
    procedure dxiFindDocsDropDown(AControl: TdxBarButtonControl; X, Y: Integer; ByMouse: Boolean);
    procedure acDocStackPrevClick(Sender: TObject);
    procedure acDocStackNextClick(Sender: TObject);
    procedure dxiDocStackPrevDropDown(AControl: TdxBarButtonControl; X, Y: Integer; ByMouse: Boolean);
    procedure acFindDocNextExecute(Sender: TObject);
    procedure acMacroMakeDocEditionExecute(Sender: TObject);
    procedure miDel_0_FromRenumClick(Sender: TObject);
    procedure miTaskQueryStatusClick(Sender: TObject);
    procedure dxseZoomButtonClick(Sender: TdxBarSpinEdit;
      Button: TdxBarSpinEditButton);
    procedure dxseZoomCurChange(Sender: TObject);
    procedure dxseZoomExit(Sender: TObject);
    procedure dxseZoomKeyPress(Sender: TObject; var Key: Char);
    procedure acMacroReplaceFutureEditionToCurrentExecute(Sender: TObject);
    procedure acFindNewImageSourceExecute(Sender: TObject);
    procedure acFindAnoncedExecute(Sender: TObject);
    procedure acFindAlarmExecute(Sender: TObject);
    procedure acDeleteCellExecute(Sender: TObject);
    procedure acDeleteTableExecute(Sender: TObject);
    procedure acAutoCompletePropsExecute(Sender: TObject);
    procedure miInternalDelDocClick(Sender: TObject);
    procedure acPrintAllExecute(Sender: TObject);
    procedure acShowSelectExecute(Sender: TObject);
    procedure acFindByJurOperationExecute(Sender: TObject);
    procedure acAnno_CloseDayExecute(Sender: TObject);
    procedure acAnnoImportFromRTFExecute(Sender: TObject);
    procedure acLoadDeltaKWExecute(Sender: TObject);
    procedure acCommMonitorExecute(Sender: TObject);
    procedure acExportDictionaryExecute(Sender: TObject);
    procedure acAttrCopyExecute(Sender: TObject);
    procedure StatusBarDblClick(Sender: TObject);
    procedure FlashTimerTimer(Sender: TObject);
    procedure StatusBarPanels2HintText(StatusBar: TvtCustomStatusBar;
      Panel: TvtStatusPanel; var Hint: string);
    procedure acSaveDocExtractsAsExecute(Sender: TObject);
    procedure miSetPrefixClick(Sender: TObject);
    procedure acDoAutoclassifyExecute(Sender: TObject);
    procedure acChangeLinkAddressExecute(Sender: TObject);
    procedure acShowDeferDeleletedItemsExecute(Sender: TObject);
    procedure acCloseAllExecute(Sender: TObject);
    procedure acCorrectMissPrintsExecute(Sender: TObject);
    procedure acFindByDocLinkExecute(Sender: TObject);
    procedure acLoadDictModifyExecute(Sender: TObject);
    procedure acFindNoCompareExecute(Sender: TObject);
    procedure acFindWillBeActiveExecute(Sender: TObject);
    procedure acFindActBorderExecute(Sender: TObject);
    procedure acFindByCloneInPubInExecute(Sender: TObject);
    procedure actAACImportExecute(Sender: TObject);
    procedure miChangeDocReportClick(Sender: TObject);
    procedure miTestDebugClick(Sender: TObject);
    procedure miUncorrectRELClick(Sender: TObject);
    procedure acDeliveryProfileExecute(Sender: TObject);
  private
    f_CForm: TForm;
    fFirstShow        : boolean;
    fCurrentChild     : TForm;
    DocStackList      : TDocStack;
    fBeginIdleDT      : TStDateTimeRec;
    fHTLongProcessMsg : TvtCurtainMsg;
    f_MsgTooltip: AnsiString;
    f_TotalServervalue: Integer;
    fIn_RunTextEditor : boolean;

    procedure acDictionaryExecute(Sender: TObject);
    procedure SetCurrentChild(Value : TForm);
    procedure OnShowHint(Sender: TObject);
    Procedure BeginTblUpdate;
    procedure BuildDictionarySubMenu;
    procedure CorrectLogoImage(aLogoForm: TLogoDlg);
    procedure EndTblUpdate;
    procedure SetSpeedButton;
    procedure DocStackCurrentChange(NewCurrent : LongInt);
    procedure wmDropAccept(var Message: TMessage); message wm_DropAccept;
    procedure wmDelDoc(var Message: TMessage); message wm_DelDoc;
    procedure wmRefreshDocs(var Message: TMessage); message wm_RefreshDocs;
    procedure wmLogoff(var Message: TMessage); message wm_Logoff;
    procedure wmShowChangeDictWarn(var Message: TMessage); message WM_SHOWCHANGEDICTWARN;
    procedure wmShowMessage(var Message: TMessage); message WM_SHOWMESSAGE;
    procedure vmMDIChildActivate(var Message: TMessage); message vm_MDIChildActivate;

    procedure SaveStyleTblTo(STFileName : AnsiString);
    procedure LoadStyleTblFrom(STFileName : AnsiString);
    procedure IdleHandler(Sender: TObject; var Done: Boolean);
    procedure FirstIdleHandler(Sender: TObject; var Done: Boolean);
    procedure MessageHandler(var Msg: TMsg; var Handled: Boolean);

    function  DropListGetItemImageIndex(Sender : TObject; Index : Longint) : Integer;
    procedure HideSplashForm;
    procedure LoadDocsPopUpGetItemFont(Sender: TObject; Index: Integer; const aFont: Il3Font);
    procedure LoadDocsPopUpGetGetStrItem(Sender : TObject; Index : LongInt; var ItemString : Il3CString);
    procedure OpenNewDocSet;

    procedure ServerProgressProc(aState: Byte; aValue: Long; const aMsg : AnsiString = '');
    procedure ShowSplashForm(aMode: Integer);

    procedure VersionDateChangedHandler(aNewDate, aNextDate: TDateTime);
    procedure AnouncedDateChangedHandler(aNewDate: TDateTime);
    procedure WMQueryEndSession(var Message: TWMQueryEndSession); message WM_QUERYENDSESSION;
    procedure WMPowerBroadcast(var Message: TMessage); message WM_POWERBROADCAST;
    procedure DoOnServerStatusChanged(aIsOnline: Boolean);
    procedure DoCorrectExportFolder(var aFolder: AnsiString; var aResult: Boolean);
    procedure DoGetBlockIndex(Sender      : TObject;
                              const aSub  : IevDocumentPart;
                              var anIndex : TImageIndex);
    procedure CheckLocalSavedDocs;
  protected
    fOldClientProc: TFarProc;
    fClientInstance: TFarProc;

    procedure NewClientWndProc(var Message: TMessage);
    procedure CreateWnd; override;
    procedure MoveDocStack(aNext : Boolean);

    // interface methods
      // IafwUserQuery
      function Ask(const aQuery: AnsiString): Boolean;
    procedure FindOnDateIntervalAndShow(const aQueryCaption : AnsiString; const aResultWinCaption : AnsiString; aGetQueryFunc :
        TarGetQueryFunc);
    procedure WMEndSession(var Message: TWMEndSession); message WM_ENDSESSION;
        {* - задает вопрос пользователю и получает ответ. }
  protected
    // IdaLongProcessSubscriber
   function DoLongProcessNotify(aState: TdaProcessState): Boolean;
   // IvtCLipListner
   procedure Change;
  public
    FreezeFontCombo  : Boolean;
    OEWin            : TObjectExplorerWin;
    SpellDictionary  : TddSpellDictionary;
    SilentClose      : Boolean;
    {$IFDEF InsiderTest}
    procedure ClearHistory;
    {$ENDIF InsiderTest}
    procedure CheckCurrChild(aForm: TForm);
    function CheckServer(aQuietly: Boolean = False): Boolean;
    procedure CreateNewDocumentFromFile(const aParams: TNewDocParams);
    procedure LayMsg(const aMsg: AnsiString; aType: TMsgDlgType; aButtons: TMsgDlgButtons; aHelpCtx: Longint=0);
    procedure OutToStatusBar(const aMsg : AnsiString; aPriority : Integer = 0);

    procedure ShowCorrespondentsForList(aSrchWin : TForm);
    procedure ShowRespondentsForList(aSrchWin : TForm);
    function IsEditorInFocus(aControl: TControl) : Boolean;
    function FindTextEditor(aDocFam : TdaFamilyID; aDocID : Longint) : TCustomEditorWindow;

    procedure AddDocumentToStack(aWindow: TCustomEditorWindow);

    function RunTextEditor(aDocFam : TdaFamilyID; aDocID : Longint;
                                  ROnly : Boolean;
                                  aDocJumpData : TDocJumpRec;
                                  IsJump : boolean = False;
                                  IsExternalDocID : boolean = false) : TForm; overload;

    function RunTextEditor(aDocFam : TdaFamilyID; aDocID : Longint;
                           ROnly : Boolean = False;
                           OpenFromHistory : boolean = False;
                           IsExternalDocID : boolean = false) : TForm; overload;

    function  GetChildForm(WinType : TWinType; Var StartChild : Integer) : TForm;
    procedure SetDictEditorEnable(aDict : TdaDictionaryType; Enable : boolean);

    procedure GetChildFormList(ChildFormList : Tl3StringDataList;
                            WinTypeSet : TWinTypeSet; WithWinClass : Boolean);
    procedure ShowDockPanel(APanel: TPanel; MakeVisible: Boolean; Client: TControl);
    procedure ShowExplorer(aShow : Boolean);

    procedure OpenDocByNumber(aDocID: TDocID; aSubID: TDocID; aRenum: Boolean);

    procedure PrepareStack;
    procedure ServerMessages(aCount: Integer; const aLastMsg: AnsiString);


    property  CurrentChild : TForm Read FCurrentChild; {Write SetCurrentChild;}
  end;

var
  MainForm: TMainForm;

  function CheckRunCondition : Boolean;
  procedure GlobalInit;
  procedure GlobalDone; far;

  procedure evntReaderErrorHandler(Reader: TReader; const Message: AnsiString; var Handled: Boolean);

  function PromptUserPassword(var aLogin, aPassword: AnsiString): Boolean;
implementation

{$R *.DFM}

uses
     daDataProvider,
     daSchemeConsts,
     HT_Const,
     dtIntf, DT_Sab, DT_SabHelp, DT_Record,
     dt_ATbl,
     dt_Lock,
     DT_Doc, DT_Serv, DT_Err, dt_Renum,
     DT_Dict, DT_Link, DT_LinkServ, DT_Stage, DT_Mail, DT_Acces,
     dt_Log, DT_AskList,
     DtSupport, //StrSpecUtil,
     dt_DictModifier,
     dt_DictExport,
     l3Stream,
     l3DateSt,
     vtForm,
     l3IniFile,
     Com_Cnst,
     StrShop, IniShop, ResShop,
     evOp, evAutoComplete,
     l3Chars, l3Languages,
     l3String, l3BMSearch,
     l3FileUtils,
     l3ExceptionsLog,
     l3Nodes,
     l3NodesModelPart,
     l3ClipSpyService, 
     m3DBInterfaces,
     afwFacade,
     k2Facade,
     evDisp,
     evdStyles, evInternalInterfaces, evEditorInterfaces, evdTypes,

     D_Pass, D_Srch, d_GetNewDocParam, D_GetNum, D_DateIn,
     D_HndDoc, D_Config,
     D_IntEdit, d_StrEdit, d_FileEdit,
     d_AttrCopyEdit,
     D_DocByStageInfo,
     d_SrchIncludeDoc, d_SrchIncludeDoc3, d_SrchByAction, d_SrchByJurOperation,
     d_SrchByDocLink,
     d_AutoCompleteCfg,
     d_DateEdit, d_DeltaKWFileEdit,
     D_TxSrch, D_Style,
     D_FindAlarm,
     d_DeliveryProvile,
     DictMetaForm, TreeDWin, InsDWin,
     DeferDeleletedItemsWin,

     evExcept,
     m2XltLib,
     HelpCnst,
     //DocIntf,
     imageenio,
     ArchiUserRequestManager,
     csDeliveryProfileTask,
     ddAutoImportClient,
     ClosingWin,
     WinList,
     SrchWin, Editwin, DictEntryWin,
     l3Base, l3MinMax,
     dt_IndexSupport, UsersMacro,

     DictsSup,
     l3TreeSupport,
     BaseSupport,
     evStandardActions,
     evStyleInterfaceEx,
     MissTypesList,
     evStyleTableTools, evOpProc,
     VersionSupport,
     D_Undo,
     evCursorTools,
     D_DeltaKWLoad,
     CSClient, csErrors,
     D_TextMessages,
     d_HyperlinkAddrChange,
     AddrSup,
     evCommonTypes,
     evFacadeCursor,


     l3IDList,
     l3LongintList,

     DT_DocImages,
     Dt_Free,
     archiHtInit,
     ddClientBaseEngine,

     {$IFDEF InsiderTest}
     KTestRunner,
     TestForm4Scripts,
     {$ENDIF InsiderTest}

     BitmapPara_Const,
     Block_Const,
     TextPara_Const,
     vtVerInf,
     D_LogRequest,
     PrevInst,
     JwaWinBase, JwaWinNT,
     Base_CFG,
     csUserRequestManager,
     dd_lcRelatedSearcher,
     SavedQuery,
     vtDebug,
     D_CorrectExportFolder,
     arSpeller, ddBaseEngine;

resourcestring
 sidStyleFileName = 'Style.evs';

const
 sbiServerStatus = 0;
 sbiText         = 1;
 sbiMsgLog       = 2;
 sbiMail         = 3;
 sbiGauge        = 4;

 imiServerOff    = 261;
 imiServerOn     = 262;


var
 DisabledDict : set of TdaDictionaryType = [];
 CSC : TCSClient = nil;

function GetDictSetString(DictSet : TDLTypeSet; Var Cnt : Byte) : AnsiString;
var
 I       : TdaDictionaryType;
 {TmpDate : Word;}
begin
 Result := '';
 Cnt := 0;
 for I := Low(TdaDictionaryType) to High(TdaDictionaryType) do
  if I in DictSet then
  begin
   Inc(Cnt);
   If Result > '' then AppendStr(Result, ', ');
   AppendStr(Result, '"'+GetDictName(I)+'"');
  end;
end;

procedure evntReaderErrorHandler(Reader: TReader; const Message: AnsiString; var Handled: Boolean);
begin
 l3System.Msg2Log(Message);
 Handled := True;
end;

function PromptUserPassword(var aLogin, aPassword: AnsiString): Boolean;
begin
 UserPassName:= aLogin;
 UserPassword:= aPassword;
 Result:= GetPassword;
 if Result then
 begin
  aLogin:= UserPassName;
  aPassword:= UserPassword;
 end;
end;

function CheckRunCondition : Boolean;
var
 l_IniPathStr  : AnsiString;
 l_StartKey    : Boolean;
 J             : Integer;
 lStr          : AnsiString;
 lNeedCheckPrevInst : Boolean;
begin
 Result := True;
 l_IniPathStr := '';
 l_StartKey   := false;
 lNeedCheckPrevInst := true;

 for J := 1 to ParamCount do
 begin
  lStr := ParamStr(J);
  If (Length(lStr) >= 2) and (lStr[1] = '/') then
   case lStr[2] of
    'q', 'Q' :
      l_StartKey := true;
    'i', 'I' :
      l_IniPathStr := copy(lStr,4,255);
    'd', 'D' :
      lNeedCheckPrevInst := false;
   end;
 end; // for j

 InitStationConfig(l_IniPathStr);

 if not l_StartKey then
 begin
  StationConfig.Section := 'Preferences';
  l_StartKey := not StationConfig.ReadParamBoolDef('ExeUpdate', true);
 end; // not l_StartKey

 if not l_StartKey then
 begin
  vtMessageDlg(l3CStr('Программа обновления приложения не активирована.'^M+
               'Для запуска программы "Архивариус" используйте arun.exe.') , mtError);
  Result := False;
  Exit;
 end; // not l_StartKey


 if lNeedCheckPrevInst and GoToPrevinst then
 begin
  Result := False;
  Exit;
 end;

{$IFNDEF InsiderTest}
 l3System.Msg2Log('Run Archi client ' + BaseSupport.GetProjectConfigStr(True));
{$ENDIF InsiderTest}

end;

procedure GlobalInit;
 var
  Ok            : Boolean;
  I             : Integer;
  ServerCfgPath : AnsiString;
  lLockMsg      : AnsiString;

  l_LogPathStr  : AnsiString;
  lImageStoragePath : ShortString;
  lServerName   : AnsiString;
  lServerPort   : Integer;
  lStationName  : TStationName;
  lDocFolder    : AnsiString;
  l_BiLingualGroup: Integer;
  lMsgLevel     : Integer;
  lAutoSaveDir  : AnsiString;
  
begin
 AddExitProc(GlobalDone);
  {$IFDEF InsiderTest}
  if InitArchiBaseEngine({$IFDEF ItsVoba}PromptUserPassword,{$ENDIF} True) then
  {$ELSE}
  if InitArchiBaseEngine({$IFDEF ItsVoba}PromptUserPassword{$ENDIF}) then
  {$ENDIF InsiderTest}
  begin
   {$IFNDEF MonoUser}
    ArchiRequestManager.CheckLocalTime;
   {$ENDIF}

    l3System.Msg2Log('LOGIN as %s', [dsGetCurrentUserName]);

    if GlobalDataProvider.BaseName <> '' then
     Application.Title := Format('АРХИВАРИУС [%s]', [GlobalDataProvider.BaseName]);
    //IniRec.SetIniRecord;
    //IniRec.MultiLingual := True;
    if BaseConfig <> nil then
    begin
     l_BiLingualGroup := BaseConfig.MagicNumber['MagicNumbers', 'BilingualGroupID'];
     if l_BiLingualGroup >= 0 then
      IniRec.MultiLingual := GlobalDataProvider.UserManager.IsMemberOfGroup(l_BiLingualGroup, GlobalDataProvider.UserID)
     else
      IniRec.MultiLingual := False;
    end
    else
     IniRec.MultiLingual := False;
    DictServer(CurrentFamily).BiLingual := IniRec.MultiLingual;

    IniRec.PathToLogFile := l_LogPathStr;
    IniRec.PathToDeletedFileList := ConcatDirName(ExtractDirName(l_LogPathStr),'Deleted.lst');

    StationConfig.Section := PrefSectName;
    IniRec.DebugInfo := StationConfig.ReadParamBoolDef('DebugInfo2', False);

    if StationConfig.ReadParamString('AutoSaveDir', lAutoSaveDir) then
     IniRec.PathToLocalSaveDir := lAutoSaveDir
    else
     IniRec.PathToLocalSaveDir := ConcatDirName(ExtractFilePath(Application.ExeName), 'DocSave\');

    if not StationConfig.ReadParamInt('MsgLevel', lMsgLevel) then
     lMsgLevel := StationConfig.ReadParamIntDef('MsgLevelCommon', l3_msgAll);
    l3System.MessageLevel := lMsgLevel;

    l3System.ShowObjectsWindow := IniRec.DebugInfo;
    g_dtQueryList.LoadAsksList;
  end
  else
   Abort;

 InitSpeller;
end;

procedure GlobalDone;
begin
 ReleaseSpeller;
 SaveIniRec;
 DoneArchiBaseEngine;
 DoneConfigs;
end;

procedure TMainForm.FormCreate(Sender: TObject);
 var
  I             : TdaDictionaryType;
  WallPaperFile : TFileName;
  l_Dict        : TdaDictionaryType;
  l_Logo        : TLogoDlg;
  lShowSplash   : boolean;
 begin
  StationConfig.Section := 'Preferences';
  lShowSplash := StationConfig.ReadParamBoolDef('SplashScreen', true);

  if lShowSplash then
   l_Logo:= TLogoDlg.Create(nil);
  try
   if lShowSplash then
   begin
    CorrectLogoImage(l_Logo);
    l_Logo.Show;
   end;
   Application.ProcessMessages;
   ArchiRequestManager.OnTextMessage := ServerMessages;
   ArchiRequestManager.OnProgressProc:= ServerProgressProc;
   ArchiRequestManager.OnVersionDateChanged := VersionDateChangedHandler;
   ArchiRequestManager.OnAnouncedDateChanged := AnouncedDateChangedHandler;
   ArchiRequestManager.OnServerStatusChanged := DoOnServerStatusChanged;
   ArchiRequestManager.OnCorrectExportFolder := DoCorrectExportFolder;
   DoOnServerStatusChanged(ArchiRequestManager.ServerOnline);
   SubDescriptors.OnDefineBlockIndex := DoGetBlockIndex;
   // Если версия уже была, надо запросить с сервера новую дату
   // (или вычислить, если работаем без сервера)
   if g_BaseEngine.ServiceParams.StandAlone then
   begin
    if IniRec.NextVersionDate <= SysUtils.Date then
    begin
     IniRec.NextVersionDate := vtGetNearestDayOfWeek(Saturday, false);

     if (SysUtils.DayOfWeek(SysUtils.Date) = 6 {Friday}) and
        (IniRec.NextVersionDate = SysUtils.Date + 1) then
      IniRec.NextVersionDate := IniRec.NextVersionDate + 7;
    end;

    if IniRec.AnouncedDate < SysUtils.Date then
     IniRec.AnouncedDate := SysUtils.Date;
   end
   else
   begin
    // если дата версии определялась пользователем и истекла, то
    // переходим в режим получения даты версии от сервера
    if (not IniRec.NVDFromServer) and (IniRec.NextVersionDate <= SysUtils.Date) then
     IniRec.NVDFromServer := True;
    { дата версии автоматически приедет с сервера, её не надо запрашивать }
   end;
   ArchiRequestManager.GetDictChangeFileName;

   if (afw.Application <> nil) then
    afw.Application.UserQuery := Self;
   Caption := Application.Title;

   Application.HelpFile := ExpandFileName('Archi.hlp');

   StationConfig.Section := PrefSectName;
{$IFDEF AQTIME_PROFILE}
   miUtils.Visible := True;
{$ELSE AQTIME_PROFILE}
   miUtils.Visible := StationConfig.ReadParamBoolDef('Admin',false) and GlobalDataProvider.AdminRights;
{$ENDIF AQTIME_PROFILE}
   acAnno_CloseDay.Enabled := GlobalDataProvider.AdminRights;
   acDoAutoclassify.Enabled:= GlobalDataProvider.AdminRights;
   vtVisibleAndEnabled(acAnnoImportFromRTF, AccessServer.TestRightsMaskForDocGroup(CurrentFamily, agIncludedGroup, acgAnno));

   //AttrIDOrder : TAttrIDArray
   for I := Low(TdaDictionaryType) to High(TdaDictionaryType) do
    if I in EditableDict then
     SetDictEditorEnable(I, GlobalDataProvider.AdminRights);

   (*
   for l_Dict := Succ(Low(TdaDictionaryType)) to High(TdaDictionaryType) do
    if IsDictClass(l_Dict) then
     DictServer.DictRootNode[l_Dict];
   *)
   IniLoadToolbarPositions (Self,GlobalDataProvider.CurHomePath+'User.ini','');
   Application.OnHint := OnShowHint;
   {FooterPanel.Visible:=False;}
   {UserConfig.Section:='Windows';
   If UserConfig.ReadParamBoolDef('MaxOnStart',False)
    then WindowState:=wsMaximized;
    IniShop}
   BuildDictionarySubMenu;

   StationConfig.Section:='Desktop';
   WallPaperFile:=StationConfig.ReadParamStrDef('WallPaper','');

   If FileExists(WallPaperFile) then
   Try
    //SpeedPanel.WallPaper.LoadFromFile(WallPaperFile);
    MDIBackground.WallPaper.LoadFromFile(WallPaperFile);
    MDIBackground.SetBackground;
   except
   end;

   If IniRec.MaxOnStart
    then WindowState:=wsMaximized;
   Repaint;
   //Application.ProcessMessages;

   {f_SpellChecker := TSpellChecker.Create;}

   SpellDictionary := TddSpellDictionary.Create(Self);

   SpellDictionary.FileName := ConcatDirName(GlobalDataProvider.CurHomePath, 'Spell.dct');

   {Load StyleTable}
   Try
    if not FileExists(IniRec.StyleTbl) then
    begin
     IniRec.StyleTbl := ConcatDirName(GlobalDataProvider.CurHomePath, sidStyleFileName);
     if not FileExists(IniRec.StyleTbl) then
      IniRec.StyleTbl := ConcatDirName(GlobalHtServer.FamilyTbl.FamilyPath(MainTblsFamily), sidStyleFileName)
    end;

    if FileExists(IniRec.StyleTbl) then
    begin
     StyleFiler.FileName := IniRec.StyleTbl;
     LoadStyleTblFrom(StyleFiler.FileName);
    end
    else
     StyleFiler.FileName := '';
   except
   end;

   StationConfig.Section := PrefSectName;

   DocStackList := TDocStack.Create;
   DocStackList.OnCurrentChanged := DocStackCurrentChange;

   //If IniRec.MaxOnStart
   // then WindowState:=wsMaximized;

   OEWin := TObjectExplorerWin.Create(Self);
   OEWin.ManualDock(LeftDockPanel, nil, alClient);
   ShowDockPanel(LeftDockPanel, True, OEWin);
   ShowExplorer(IniRec.ExplorerShow);

   LeftDockPanel  .OnResize  := LeftDockPanelResize;
   BottomDockPanel.OnResize  := BottomDockPanelResize;

   VSplitter.SaveSize := IniRec.ExplorerWidth;
   HSplitter.SaveSize := IniRec.ExplorerWidth;

   Screen.OnActiveFormChange := UpdateMenuItems;

   CreateToolbarMenus;

   {for i := 0 to miToolbar.Count - 1 do
    with miToolbar.Items[i] do
     pmToolbar.Items.Add(NewItem(Caption, ShortCut, Checked,
                                 Enabled, OnClick, HelpContext,
                                 Name + 'Popup'));}


   Application.OnIdle := FirstIdleHandler;
   fBeginIdleDT := CurrentDateTime;
   Application.OnMessage := MessageHandler;

   GlobalDataProvider.SubscribeLongProcess(Self);
   if StationConfig.ReadParamBoolDef('ClipNotify',True) then
    if Tl3ClipSpyService.Exists then
     Tl3ClipSpyService.Instance.Subscribe(Self);

   {$IFDEF InsiderTest}
   acShowSpecSymbol.Checked := False;
   acShowDocumentParts.Checked := False;
   acWebStyle.Checked := False;
   {$ELSE}
   acShowSpecSymbol   .Checked := IniRec.ShowSpecSymbol;
   //acPreviewMode      .Checked := IniRec.ShowPreview;
   acShowDocumentParts.Checked := IniRec.ShowDocumentParts;
   acWebStyle         .Checked := IniRec.ShowWebStyle;
   {$ENDIF InsiderTest}
   acShowSelect       .Checked := IniRec.ShowFoundWordLighting;
   actAACImport.Visible:= bfAAC in g_BaseEngine.BaseFlags;
   AutoComplete := TevAutoComplete.Create(ConcatDirName(GlobalDataProvider.CurHomePath, 'acomplete.ini'));
   acDeliveryProfile.Visible:= g_BaseEngine.IsDeveloper;
  finally
   l3Free(l_Logo);
  end;
  cDefCodePage := GlobalDataProvider.BaseLanguage[CurrentFamily].AnsiCodePage;

  fFirstShow := True;
 end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
 if fFirstShow then
 begin
  OEWin.LoadStruct;
  CheckLocalSavedDocs;
 end;

 fFirstShow := false;

 InvalidateRect(ClientHandle, nil, True);
 {$IFDEF InsiderTest}
 if not IsWritingToK then
  GetTestForm.ToFront;
 {$ENDIF InsiderTest}
end;


procedure TMainForm.CheckLocalSavedDocs;

var
 lHasInSaveDir : Il3IDList;
 lNeedOpen : Il3IDList;

 function DoFile(const aFileName: string): Boolean;
 var
  S : TPathStr;
  lPos : integer;
  lDocID : TDocID;
 begin//DoFile
  Result := true;
  S := ExtractFileName(aFileName);
  lPos := Pos('.', S);
  if lPos > 0 then
  SetLength(S, Pred(lPos));

  //if Pos('_bkp', S) <> 0 then Exit;

  try
   lDocID := Strtoint(S);
   lHasInSaveDir.Add(lDocID);
  except
  end;

  {if LockServer.HasMyLock(CurrentFamily, lDocID) then
   RunTextEditor(CurrentFamily, lDocID)
  else
   DeleteLocalCopy(aFileName);}

 end;//DoFile

var
 l_FPStub    : Pointer;
 I : Integer;
begin
 lHasInSaveDir := l3MakeIDList;
 lNeedOpen := l3MakeIDList;
 l_FPStub := l3LocalStub(@DoFile);
 try
  ProcessFilesWithMask(IniRec.PathToLocalSaveDir, '*.sav'{cMask}, TFileProcessingFunc(l_FPStub));
 finally
  l3FreeLocalStub(l_FPStub);
 end;

 LockServer.CheckMyLock(CurrentFamily, lHasInSaveDir, lNeedOpen);

 for I := 0 to Pred(lHasInSaveDir.Count) do
  DeleteLocalCopy(lHasInSaveDir[I]);

 for I := 0 to Pred(lNeedOpen.Count) do
  RunTextEditor(CurrentFamily, lNeedOpen[I]);
end;

procedure TMainForm.FirstIdleHandler(Sender: TObject; var Done: Boolean);
 begin
  If Application.MainForm <> nil then
   begin
    Application.OnIdle := IdleHandler;
    try
     ArchiRequestManager.RequestNextVersionDate;
     ArchiRequestManager.RequestResultsDelivery(True);
    except
     On E : Exception do l3System.Exception2Log(E);
    end;
   end;
  IdleHandler(Sender, Done);
 end;

procedure TMainForm.IdleHandler(Sender: TObject; var Done: Boolean);
 var
  I : Integer;
 begin
  for I := 0 to Pred(MDIChildCount) do
   MDIChildren[I].Perform(wm_IdleMsg,0,0);
  ArchiRequestManager.ProcessNotifyList;
 end;

procedure TMainForm.MessageHandler(var Msg: TMsg; var Handled: Boolean);
 var
  lDT : TStDateTimeRec;
  Days : Longint;
  Secs : Longint;
 begin
  with Msg do
   if (((Message >= WM_KEYFIRST) and (Message <= WM_KEYLAST)) or
      ((Message >= WM_MOUSEFIRST) and (Message <= WM_MOUSELAST) and (Message <> wm_MouseMove))) then
   begin
    lDT := CurrentDateTime;
    DateTimeDiff(lDT, fBeginIdleDT, Days, Secs);
    If (Days > 0) or (Secs >= 5 * 60) then GlobalDataProvider.Journal.LogPause(Secs);
    fBeginIdleDT := lDT;
   end;

  if (g_TextSearchDlg <> nil) and (g_TextSearchDlg.Visible) then
   with Msg do
    if (Message >= WM_KEYDOWN) and (wParam = VK_ESCAPE) then
    begin
     g_TextSearchDlg.Close;
     Handled := True;
    end;
   //  Handled := SendMessage(g_TextSearchDlg.Handle, CN_BASE + Message, WParam, LParam) <> 0;
   //  Handled := g_TextSearchDlg.Perform(CN_BASE + Message, wParam, lParam) <> 0;
 end;

Type
 PMsgWndRec = ^TMsgWndRec;
 TMsgWndRec = record
               rMsg     : AnsiString;
               rType    : TMsgDlgType;
               rButtons : TMsgDlgButtons;
               rHelpCtx : Longint;
              end;

procedure TMainForm.OutToStatusBar(const aMsg : AnsiString; aPriority : Integer = 0);
 begin
  StatusBar.Panels[sbiText].Text := aMsg;
  StatusBar.Perform(WM_PAINT, 0, 0);
  //Application.ProcessMessages;
 end;

procedure TMainForm.LayMsg(const aMsg: AnsiString; aType: TMsgDlgType; aButtons: TMsgDlgButtons; aHelpCtx: Longint=0);
 var
  lMRec : PMsgWndRec;
 begin
  New(lMRec);
  With lMRec^ do
   begin
    rMsg     := aMsg;
    rType    := aType;
    rButtons := aButtons;
    rHelpCtx := aHelpCtx;
   end;
  PostMessage(Handle, wm_User + 12, 0, LParam(lMRec));
 end;

procedure TMainForm.WMShowMessage(var Message: TMessage);
 begin
  Try
   With PMsgWndRec(Message.lParam)^ do
    Message.Result := vtMessageDlg(l3CStr(rMsg), rType, rButtons, rHelpCtx);
  finally
   Dispose(PMsgWndRec(Message.lParam));
  end;
 end;

procedure TMainForm.WMShowChangeDictWarn(var Message: TMessage);
 var
  ChangeDicts   : TDLTypeSet;
  Cnt           : Byte;
  MStr          : AnsiString;
 begin
  ChangeDicts := DictServer(CurrentFamily).GetDictsChanges(IniRec.LastExitDateTime);
  If ChangeDicts <> [] then
   begin
    MStr := GetDictSetString(ChangeDicts, Cnt);
    If Cnt = 1
     then vtMessageDlg(l3CStr('Словарь ' +MStr+ ' изменился.'), mtInformation)
     else vtMessageDlg(l3CStr('Словари ' +MStr+ ' изменились.'), mtInformation);
   end;
 end;

procedure TMainForm.vmMDIChildActivate(var Message: TMessage);
 begin
  SetCurrentChild(TForm(Message.wParam));
 end;

procedure TMainForm.NewClientWndProc(var Message: TMessage);
 var
  lFC : TWinControl;

 begin
  with Message do
   begin
    Case  Msg of
     WM_KillFocus  :
      begin
       lFC := FindControl(hWnd(wParam));
       If (lFC is TForm) and (TForm(lFC).FormStyle = fsMDIChild) then
       begin
        If csDestroying in (lFC.ComponentState) then
         SetCurrentChild(Nil)
        else
         SetCurrentChild(TForm(lFC));
       end;
      end;

     WM_MDIDestroy :
      begin
       If (fCurrentChild <> Nil) and (fCurrentChild.Handle = wParam) then
        SetCurrentChild(Nil);
      end;
    end;
    Result := CallWindowProc(FOldClientProc, ClientHandle, Msg, wParam, lParam);
   end;
 end;

procedure TMainForm.CreateWnd;
 begin
  inherited CreateWnd;
  if not (csDesigning in ComponentState) then
   if FormStyle = fsMDIForm then
   begin
    FClientInstance := MakeObjectInstance(NewClientWndProc);
    FOldClientProc := Pointer(GetWindowLong(ClientHandle, GWL_WNDPROC));
    SetWindowLong(ClientHandle, GWL_WNDPROC, Longint(FClientInstance));
   end;
 end;

procedure TMainForm.BeginTblUpdate;
 begin
  SysPanel.Align   := alClient;
  SysPanel.Visible := True;
 end;

procedure TMainForm.EndTblUpdate;
 begin
  SysPanel.Visible := False;
 end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 {$IFDEF InsiderTest}
  CanClose := True;
 {$ELSE}
 {$IfDef DebugRelease}
 If IniRec.DebugInfo then
  CanClose := True
 else
 {$EndIf}
 If SilentClose then
  CanClose := True
 else
  CanClose := (vtMessageDlg(l3CStr('Может останетесь?'), mtConfirmation, [mbYes, mbNo], 0, mbYes, mbYes) = mrNo);
 {$ENDIF InsiderTest}
 If CanClose then
  CanClose := (l3System.CheckClipboard <> IDCancel);

 If CanClose then
 begin
  IniSaveToolbarPositions(Self, GlobalDataProvider.CurHomePath+'User.ini', '');
 end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 ShowSplashForm(2);
 try
  TDragDataSupport.Instance.Stop(False);
  Application.OnMessage := nil;
  Application.OnIdle := nil;
  Screen.OnActiveFormChange := nil;
  SpellDictionary.Save;
  l3Free(SpellDictionary);
  IniRec.MaxOnStart    := WindowState = wsMaximized;
 finally
  HideSplashForm;
 end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
 GlobalDataProvider.UnSubscribeLongProcess(Self);
 if Tl3ClipSpyService.Exists then
  Tl3ClipSpyService.Instance.Unsubscribe(Self);
 SpellDictionary.Save;
 l3Free(SpellDictionary);
 l3Free(AutoComplete);
 IniRec.MaxOnStart := WindowState = wsMaximized;

 if (afw.Application <> nil) AND
    (afw.Application.UserQuery = IafwUserQuery(Self)) then
  afw.Application.UserQuery := nil;
 //UserManager.SendUserLogOffMess;
 l3Free(DocStackList);
 ArchiRequestManager.OnTextMessage := nil;
 ArchiRequestManager.OnProgressProc:= nil;
 ArchiRequestManager.OnVersionDateChanged := nil;
 ArchiRequestManager.OnAnouncedDateChanged := nil;
 ArchiRequestManager.OnServerStatusChanged := nil;
 ArchiRequestManager.OnCorrectExportFolder := nil;
end;

procedure TMainForm.OnShowHint(Sender: TObject);
begin
  OutToStatusBar(Application.Hint);
end;

procedure TMainForm.acExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.WindowCascadeItemClick(Sender: TObject);
begin
  Cascade;
end;

procedure TMainForm.WindowTileItemClick(Sender: TObject);
begin
  Tile;
end;

procedure TMainForm.WindowArrangeItemClick(Sender: TObject);
begin
  ArrangeIcons;
end;

procedure TMainForm.WindowMinimizeItemClick(Sender: TObject);
 var
  I: Integer;
 begin
  { Must be done backwards through the MDIChildren array }
  for I := Pred(MDIChildCount) downto 0 do
    MDIChildren[I].WindowState := wsMinimized;
 end;

procedure TMainForm.acCloseAllExecute(Sender: TObject);
 var
  I: Integer;
 begin
  { Must be done backwards through the MDIChildren array }
  for I := Pred(MDIChildCount) downto 0 do
    MDIChildren[I].Close;
 end;

procedure TMainForm.acWinListClick(Sender: TObject);
begin
 RunSwitchWindow;
end;

procedure TMainForm.UpdateMenuItems(Sender: TObject);
 begin
  {FileCloseItem.Enabled := MDIChildCount > 0;
  FileSaveAsItem.Enabled := MDIChildCount > 0;
  CutItem.Enabled := MDIChildCount > 0;
  CopyItem.Enabled := MDIChildCount > 0;
  PasteItem.Enabled := MDIChildCount > 0;
  }
  {SaveBtn.Enabled := MDIChildCount > 0;}
  {CutBtn.Enabled := MDIChildCount > 0;
  CopyBtn.Enabled := MDIChildCount > 0;
  PasteBtn.Enabled := MDIChildCount > 0;
  }
  acCascade     .Enabled := MDIChildCount > 0;
  acTile        .Enabled := MDIChildCount > 0;
  acLineup      .Enabled := MDIChildCount > 0;
  acMinimizeAll .Enabled := MDIChildCount > 0;
  acCloseAll    .Enabled := MDIChildCount > 0;
  SetSpeedButton;
 end;

function TMainForm.IsEditorInFocus(aControl: TControl) : Boolean;
var
 lForm : TForm;
 lFocusControl: TWinControl;
begin
 Result := False;

 (*
 lFocusControl := FindControl(GetFocus);

 Result := lFocusControl = aControl;
 if Result then Exit;

 lForm := TForm(afw.GetParentForm(lFocusControl));
 if lForm is TObjectExplorerWin then Exit;
 *)

 lForm := TForm(afw.GetParentForm(aControl));
 if (lForm.FormStyle = fsMDIChild) and
    (MainForm.ActiveMDIChild = lForm) and
    (lForm.ActiveControl = aControl) then
  Result := True;

end;

procedure TMainForm.SetSpeedButton;
begin
  //sbLoadDocs.Enabled:=AsksList.Count > 0;
end;

procedure TMainForm.SetCurrentChild(Value : TForm);
begin
 if (([{csFreeNotification,} csDestroying] * ComponentState) <> []) then
 begin
  FCurrentChild := Value;
  Exit;
 end; // if (([csFreeNotification, csDestroying] * ComponentState) <> []) then
 try
  l3System.Send(FCurrentChild, vm_WinSetBtn, 0, 0);
 except
 end;
 FCurrentChild := Value;
 l3System.Send(FCurrentChild, vm_WinSetBtn, 1, 0);
end;

function TMainForm.FindTextEditor(aDocFam : TdaFamilyID; aDocID : Longint) : TCustomEditorWindow;
var
 I : Integer;
begin
 for I := 0 to Pred(MDIChildCount) do
  if (MDIChildren[I] is TCustomEditorWindow) then
  begin
   Result := MDIChildren[I] as TCustomEditorWindow;
   if (Result.DocFamily = aDocFam) and
      (Result.IsMyDocID(aDocID)) then
   Exit;
  end;
 Result := nil;
end;

procedure TMainForm.AddDocumentToStack(aWindow: TCustomEditorWindow);
var
 l_DocWin      : TDocEditorWindow;
 l_AnchorID    : LongInt;
 l_Positions   : Tl3LongintList;
 l_CaretCursor : TnevBaseCursor;
 l_CurBlock    : TnevBaseCursor;
begin
 l_DocWin := (aWindow as TDocEditorWindow);
 if (l_DocWin.CurEditor <> nil) and ( l_DocWin.CurEditor.Selection <> nil) then
  l_CaretCursor := l_DocWin.CurEditor.Selection.Cursor
 else
  l_CaretCursor :=  nil;
 if Assigned(l_CaretCursor) then
 begin
  evInPara(l_CaretCursor, k2_typBlock, l_CurBlock);
  l_AnchorID := l_CurBlock.Obj.IntA[k2_tiHandle];
  l_Positions := Tl3LongintList.Create;
  l_Positions.Add(l_CurBlock.Position);
  while (l_CaretCursor <> l_CurBlock) do
  begin
   l_CurBlock := evGetChildCursor(l_DocWin.CurEditor, l_CurBlock);
   if l_CurBlock = nil then
    Break;
   l_Positions.Add(l_CurBlock.Position);
  end;
  l_CaretCursor := nil;
 end
 else
  l_Positions := nil;

 DocStackList.AddDoc(l3Str(l_DocWin.Document.ShortName), l_DocWin.DocFamily,
      l_DocWin.DocID, l_AnchorID, l_Positions);
end;

function TMainForm.RunTextEditor(aDocFam : TdaFamilyID; aDocID : Longint;
                                  ROnly : Boolean = False;
                                  OpenFromHistory : Boolean = False;
                                  IsExternalDocID : Boolean = false) : TForm;
begin
 Result := RunTextEditor(aDocFam, aDocID, ROnly, EmptyDocJumpRec, OpenFromHistory, IsExternalDocID);
end;

function TMainForm.RunTextEditor(aDocFam : TdaFamilyID; aDocID : Longint;
                                  ROnly : Boolean;
                                  aDocJumpData : TDocJumpRec;
                                  IsJump : boolean = False;
                                  IsExternalDocID : Boolean = false) : TForm;
 var

  EdWin      : TCustomEditorWindow;

  FindWinLog : Boolean;

  SaveActWin : TForm;
  SaveActEnb : Boolean;

  lDocument  : TarDocument;
  //{*}lTimer : Cardinal;

begin
 Result := Nil;
 if fIn_RunTextEditor then Exit; // успевают иногда второй раз запустить на загрузку тот же док.
 fIn_RunTextEditor := True;
 try
 //{*}lTimer := dbgStartTimeCounter;

  if IsExternalDocID then
   aDocID := LinkServer(aDocFam).Renum.ConvertToRealNumber(aDocID);

  (*If WriteToStack then DocStackList.AddDoc(DocName, DocFam, DocID, 0{AddrID});*)

  if not IsValidDocID(aDocID) then Exit;

  Result := Nil;
  {$IfDef DebugRelease}
  If IniRec.DebugInfo then OutToStatusBar('Begin');
  {$EndIf}

  SaveActWin:=ActiveMDIChild;

  EdWin := FindTextEditor(aDocFam, aDocID);
  FindWinLog := EdWin <> nil;

  {$IfDef DebugRelease}
  If IniRec.DebugInfo then OutToStatusBar('FindWin Pass');
  {$EndIf}

  try
   if Not FindWinLog then
   begin
    EdWin := Nil;

    lDocument := TarDocument.CreateParam(aDocFam, aDocID);
     //{*} dbgAppendToLogLN(format('TMainForm.RunTextEditor TarDocument.CreateParam %s',[dbgFinishTimeCounter(lTimer)]));
    try
     if lDocument.DocClass = dtDictEntry then
      EdWin := TDictEntryWindow.Create(Self, lDocument)
     else
      EdWin := TDocEditorWindow.Create(Self, lDocument);
     try
      //{*} dbgAppendToLogLN(format('TMainForm.RunTextEditor TDocEditorWindow.Create %s',[dbgFinishTimeCounter(lTimer)]));

      //EdWin.DocFamily := aDocFam;
      //EdWin.DocID := aDocID;

      {$IfDef DebugRelease}
      if IniRec.DebugInfo then OutToStatusBar('DocID pass');
      {$EndIf}

      //{*} dbgAppendToLogLN(format('TMainForm.RunTextEditor OutToStatusBar %s',[dbgFinishTimeCounter(lTimer)]));


      EdWin.ReadOnly := ROnly;

      //If Not ROnly then EdWin.Lock;
     //{*} dbgAppendToLogLN(format('TMainForm.RunTextEditor EdWin.Lock %s',[dbgFinishTimeCounter(lTimer)]));

      {$IfDef DebugRelease}
      If IniRec.DebugInfo then OutToStatusBar('LockDoc pass');
      {$EndIf}

      //EdWin.EditingFile := SrcFileName;

      EdWin.DocJumpData := aDocJumpData;

      Application.ProcessMessages;
      {$IfDef DebugRelease}
      If IniRec.DebugInfo then OutToStatusBar('LoadDoc Begin');
      {$EndIf}

      If csDestroying in EdWin.Componentstate then  //успели Close нажать ;)
       raise EDocLoadBreak.Create('');

      EdWin.LoadDoc;
     //{*} dbgAppendToLogLN(format('TMainForm.RunTextEditor EdWin.LoadDoc #%d %s',[aDocID, dbgFinishTimeCounter(lTimer)]));

      If csDestroying in EdWin.Componentstate then  //успели Close нажать ;)
       raise EDocLoadBreak.Create('');

      if IsJump then
      begin
       DocStackList.PrepareForPair;
       AddDocumentToStack(SaveActWin as TCustomEditorWindow);
       AddDocumentToStack(EdWin);
      end;

      {$IfDef DebugRelease}
      If IniRec.DebugInfo then OutToStatusBar('');
      {$EndIf}
     except
      FreeAndNil(EdWin);
      raise;
     end;
    finally
     l3Free(lDocument);
    end;
   end
   else //if Not FindWinLog then
   begin
    if IsJump then
    begin
     AddDocumentToStack(SaveActWin as TCustomEditorWindow);
     DocStackList.PrepareForPair;
    end;
    SendMessage(ClientHandle, WM_MDIActivate, WParam(EdWin.Handle), 0);

    if (aDocJumpData.DocJumpType = djSub) {aDocJumpData GoSub >= 0} then
     with aDocJumpData.DocPointAddr do
      EdWin.GoToSub(Sub, Doc)
    else
     EdWin.DocJumpData := aDocJumpData;

    SaveActEnb := EdWin.Enabled;
    EdWin.Enabled := True;
    //PostMessage(ClientHandle, WM_MDIActivate, WParam(EdWin.Handle), 0);
    If (EdWin.WindowState = wsMinimized) then
     EdWin.WindowState := wsNormal;

    if IsJump then
     AddDocumentToStack(EdWin);
   end;
   Result := EdWin;
  except
   on EAbort do;
   on EDocLoadBreak do;
   else Raise;
  end;
  //{*} dbgAppendToLogLN(format('TMainForm.RunTextEditor %s',[dbgFinishTimeCounter(lTimer)]));
 finally
  fIn_RunTextEditor := false;
 end;
end;

procedure TMainForm.acOpenNewDocClick(Sender: TObject);
var
 l_AnalyseLog  : Boolean;
 //l_AnalyseFile : TFileName;

 l_Params    : TNewDocParams;
 //lDocType    : TDocType;
 //lDocName    : AnsiString;
 //lDocAddr    : TDocAddr;
 //lDocKind    : Integer;
begin
 try
  with TNewDocParam.Create(Self) do
  try
   //запилим Flash
   cbDocKind.Items.Delete(dkFlash);

   if not Execute then Exit;

   l_Params.rDocKind := cbDocKind.ItemIndex;

   l_Params.rAnalyseFile := l3StripDoubleQuotes(Trim(FileEdit.Text));
   l_Params.rAnalyseLog  := AnalizeChkBox.Checked;

   case l_Params.rDocKind of
    dkObject: l_Params.rDocType := DT_Types.dtObject;
    dkFlash : l_Params.rDocType := DT_Types.dtFlash;
   else
    l_Params.rDocType := Dt_Types.dtText;
   end;

   l_Params.rDocName := edtDocName.Text;
   l_Params.rDocAddr.FamID := CurrentFamily;

   if GlobalHtServer.ExtDocIDsFromRange then
    l_Params.rDocAddr.DocID :=  GlobalDataProvider.GetFreeExtDocID(CurrentFamily)
   else
    l_Params.rDocAddr.DocID := edtDocID.AsInteger;
  finally
   Free;
  end;

  CreateNewDocumentFromFile(l_Params);
 except
  on E: EHtErrors do
   if E.ErrorValue = ecFreeTblErr then
    vtMessageDlg(l3CStr('Нет свободных номеров документов.'^M+
                 'Обратитесь к администратору Архивариуса.'), mtError)
   else
    raise;
 end;
end;

procedure TMainForm.GetChildFormList(ChildFormList : Tl3StringDataList;
                         WinTypeSet : TWinTypeSet; WithWinClass : Boolean);
 var
  I          : Integer;
  MDIChild   : TForm;
  CurWinType : TWinType;

 function GetFormType(F : TForm) : TWinType;
  begin
   If F is TSearchWin then
    Result:= wtSrchWin
   else
    If F is TSearchWin then
     Result:= wtDocWin
    else
     Result:= wtUnknown;
  end;

 function GetWinName : AnsiString;
  begin
   If WithWinClass
    then Result := MDIChild.Caption
    else
     Case CurWinType of
      wtSrchWin : Result := TSearchWin(MDIChild).SrchName;
      wtDocWin  :;
      wtUnknown :;
     end;
  end;
 begin
  {ChildFormList.Clear;}
  If MDIChildCount  = 0 then Exit;
  for I := 0 to Pred(MDIChildCount) do
  begin
   MDIChild := MDIChildren[I];
   CurWinType := GetFormType(MDIChild);
   If CurWinType in WinTypeSet then
    ChildFormList.AddStr(GetWinName, @MDIChild);
  end;
 end;

Function TMainForm.GetChildForm(WinType : TWinType; Var StartChild : Integer) : TForm;
 var
  I: Integer;
 begin
  Result:=Nil;
  If StartChild >= MDIChildCount then Exit;
  for I := StartChild to Pred(MDIChildCount) do
   Case WinType of
    wtSrchWin : If MDIChildren[I] is TSearchWin
                 then
                  Begin
                   Result:=MDIChildren[I];
                   StartChild:=I;
                   Break;
                  end;

    wtDocWin  : If MDIChildren[I] is TCustomEditorWindow //TDocEditorWindow
                 then
                  Begin
                   Result := MDIChildren[I];
                   StartChild := I;
                   Break;
                  end;
   end;
end;

procedure TMainForm.OpenNewDocSet;
var
 SW             : TSearchWin;
 lSearchWinName : AnsiString;
begin
 lSearchWinName := '';
 If RequestStringValue(lSearchWinName, Self, 'НОВАЯ ВЫБОРКА', 'Имя выборки') then
 begin
  SW := TSearchWin.Create(Self);
  SW.Family := CurrentFamily;
  SW.SrchName := lSearchWinName;
 end;
end;

procedure TMainForm.acFindDocsClick(Sender: TObject);
 var
  SW : TSearchWin;
  lQuery : TdtQuery;
 begin
  If GetKeyState(VK_CONTROL) and $8000 <> 0 then
   OpenNewDocSet
  else
  begin
   lQuery := nil;
   With TDocSearchDlg.CreateParam(Self, CurrentFamily) do
    try
     if Execute(lQuery, TForm(SW)) then
      try
       if SW = Nil then
       begin
        SW := TSearchWin.Create(Self);
        SW.Family := CurrentFamily;
        SW.DocList.Query := lQuery;
        SW.SrchName := NewSearchWinName;
       end
       else
        SW.MergeWithAnotherDocSet(lQuery, l3_boOr);
      finally
       l3Free(lQuery);
      end;
    finally
     Free;
    end;
  end;
 end;

procedure TMainForm.acFindDocNextExecute(Sender: TObject);
begin
 TSearchWin(FCurrentChild).actSpecifySet.Execute;
end;

procedure TMainForm.acFindAbolishedClick(Sender: TObject);
 //var
 // aSrchServ : TSrchServer;
 begin
  (*
  aSrchServ := TSrchServer.Create;
  Try
   aSrchServ.Family := CurrentFamily;

   Try
    Screen.Cursor:=crHourGlass;
    //aSrchServ.SearchNewNoActive;
   finally
    Screen.Cursor:=crDefault;
   end;

   If aSrchServ.SrchCount > 0 then
   With TSearchWin.Create(Self) do
   begin
    Family := CurrentFamily;
    SrchServ := aSrchServ;
    SrchName := 'Документы, которые скоро утратят силу';
   end
   else
    vtMessageDlg('На этой неделе ни один документ не прекратит действие.');
  finally
   l3Free(aSrchServ);
  end;
  *)
 end;

procedure TMainForm.acFindByJournalClick(Sender: TObject);
var
 l_Q   : TdtQuery;
begin
 with TFindByJournalDlg.Create(Self) do
 try
  if ShowModal = mrOK then
  begin
   l_Q := nil;
   try
    Screen.Cursor:=crHourGlass;
    try
     case gbxType.GroupCheckData of
      1  : l_Q := SQNewDocsFromLog(StDateToDemon(DateTimeToStDate(LowDateEdit.Date)),
                                   StDateToDemon(DateTimeToStDate(HighDateEdit.Date)),
                                   gbxStageStatus.GroupCheckData,
                                   TdaUserID(cbUser.Items.Objects[cbUser.ItemIndex]));

      2  : l_Q := SQChangedDocsFromLog(StDateToDemon(DateTimeToStDate(LowDateEdit.Date)),
                                       StDateToDemon(DateTimeToStDate(HighDateEdit.Date)),
                                       gbxStageStatus.GroupCheckData,
                                       TdaUserID(cbUser.Items.Objects[cbUser.ItemIndex]));
      else
      begin
       l_Q := TdtSimpleLogQuery.Create(StDateToDemon(DateTimeToStDate(LowDateEdit.Date)),
                                       StDateToDemon(DateTimeToStDate(HighDateEdit.Date)),
                                       TdaUserID(cbUser.Items.Objects[cbUser.ItemIndex]));
       SQAndDoneQuery(l_Q, gbxStageStatus.GroupCheckData);
      end;
     end;
     l_Q.DoQuery;
    finally
     Screen.Cursor:=crDefault;
    end;

    if not l_Q.IsEmpty then
    with TSearchWin.Create(Self) do
    begin
     Family := CurrentFamily;
     DocList.Query := l_Q;
     SrchName := 'Созданные за период';
    end
    else
     vtMessageDlg(l3CStr(@sidNoSuchDoc));
   finally
    l3Free(l_Q);
   end;
  end;
 finally
  Free;
 end;
end;

procedure TMainForm.acFindIncludedPeriodClick(Sender: TObject);
var
 lFromDate       : TStDate;
 lToDate       : TStDate;

 l_Q    : TdtQuery;
 l_Or   : TdtQuery;
 l_IncQ : TdtQuery; // Подключенные (результирующий)
 l_IDList : Tl3LongintList;
 l_LoDate: Integer;
 l_HiDate: Integer;
 l_AccGrQ: TdtQuery;
 l_ChQ   : TdtQuery; // Измененные (результирующий)
begin
 with TSearchDocForExportDlg.Create(Self) do
 try
  if Execute then
  begin
   l_AccGrQ := nil;
   try
    Screen.Cursor := crHourGlass;
    try
     lFromDate := DateTimeToStDate(edtLinkedFromDate.Date);
     if LinkedDateAsRange then
      lToDate := DateTimeToStDate(edtLinkedToDate.Date)
     else
      lToDate := lFromDate;
     l_Q := TdtLogByActionQuery.Create(acIncluded, StDateToDemon(lFromDate), StDateToDemon(lToDate));
     try
      if otlAttrFilter.SelectedCount > 0 then  //если фильтрации по группам нет, то и учитывать их не будем
      begin
       // Ищем все документы из групп пользователей (или групп документов), заказанных пользователем
       l_IncQ := TdtAndQuery.Create;
       TdtAndQuery(l_IncQ).AddQueryF(l_Q);
       l_IDList := Tl3LongintList.Make;
       try
        GetListFromTree(otlAttrFilter.CTree, l_IDList);
        l_AccGrQ := TdtDictQuery.Create(AttrID2DLType(AttrToSearch), l_IDList, False, False);
       finally
        l3Free(l_IDList);
       end;
       TdtAndQuery(l_IncQ).AddQuery(l_AccGrQ);
      end
      else
       l_IncQ := l_Q.Use;
     finally
      l3Free(l_Q);
     end;
    finally
     Screen.Cursor := crDefault;
    end;

    if cbxNewDoc.Checked then
    begin
     if not l_IncQ.IsEmpty then
      with TSearchWin.Create(Self) do
      begin
       Family := CurrentFamily;
       DocList.Query := l_IncQ;
       SrchName := 'Подключенные ' + DateToStr(edtLinkedFromDate.Date);
      end
      else
       vtMessageDlg(l3CStr(@sidNoSuchDoc));
    end;

    // Измененные
    if cbxChangedDoc.Checked then
    begin
     Screen.Cursor:=crHourGlass;
     try
      l_LoDate := StDateToDemon(DateTimeToStDate(edtLowDate.Date));
      l_HiDate := StDateToDemon(DateTimeToStDate(edtHighDate.Date));

      l_Q := TdtSimpleLogQuery.Create(l_LoDate, l_HiDate, 0, false, acfNone); // все операции по системному журналу в диапазоне

      l_ChQ := TdtAndQuery.Create;
      try
       TdtAndQuery(l_ChQ).AddQueryF(l_Q);

       l_Q := SQDocOnDoneState(cDone);
       TdtAndQuery(l_ChQ).AddQueryF(l_Q);

       if l_AccGrQ <> nil then // если поиск по группам определен
        TdtAndQuery(l_ChQ).AddQueryF(l_AccGrQ); // то фильтруем по ним

       // вычитаем подключенные на этой неделе
       if not l_IncQ.IsEmpty then
       begin
        SQNot(l_IncQ);
        TdtAndQuery(l_ChQ).AddQueryF(l_IncQ);
       end;

       if not l_ChQ.IsEmpty then
       with TSearchWin.Create(Self) do
       begin
        Family := CurrentFamily;
        DocList.Query := l_ChQ;

        SrchName := 'Измененные '+ DateToStr(NormDate(edtLowDate.Date, Now)) + ' - ' +
                                   DateToStr(NormDate(edtHighDate.Date, Now));
       end
       else
        vtMessageDlg(l3CStr(@sidNoSuchDoc));
      finally
       l3Free(l_ChQ);
      end;

     finally
      Screen.Cursor:=crDefault;
     end;
    end; //if cbxChangedDoc.Checked then

   finally
    l3Free(l_IncQ);
    l3Free(l_AccGrQ);
   end;
  end; //if Execute then
 finally
  Free;
 end;
end;

function TMainForm.Ask(const aQuery: AnsiString): Boolean;
  {* - задает вопрос пользователю и получает ответ. }
begin
 Result := (vtMessageDlg(l3CStr(aQuery), mtConfirmation, [mbYes, mbNo]) = mrYes);
end;

procedure TMainForm.FindByLogAction(const aQueryCaption : AnsiString;
                                    const aResultWinCaption : AnsiString;
                                    aLogAction : TLogActionType;
                                    aUserID : TdaUserID;
                                    aUserGr : Boolean);

 function lCreateQueryFunc(aDateBounds : Tl3DateBounds): TdtQuery;
 begin
  with aDateBounds do
   Result := TdtLogByActionQuery.Create(aLogAction, Low, High, aUserID, aUserGr);
 end;

begin
 FindOnDateIntervalAndShow(aQueryCaption, aResultWinCaption,
   TarGetQueryFunc(l3LocalStub(@lCreateQueryFunc)));
end;

procedure TMainForm.acFindKWClick(Sender: TObject);
begin
 FindByLogAction('Поиск документов с новыми ключами',
                 'Новые ключи %s',
                 acKWWork {TLogActionType},
                 0 {Группа KW},
                 True {Ищем по группам});
end;

procedure TMainForm.acFindNewImageSourceExecute(Sender: TObject);
begin
(*
FindByLogAction('Внимание! Технический поиск! Сообщите разработчикам',
                 'Внимание! Технический поиск! Сообщите разработчикам',
                 acKWWork,
                 126 {Скопина},
                 False);
*)

 FindByLogAction('Поиск документов с измененными граф. образами',
                 'Документы с измененными граф. образами %s',
                 acPublInWork {TLogActionType},
                 0 {любая группа},
                 True {не используется});
end;

procedure TMainForm.acFindAnoncedExecute(Sender: TObject);

 function lCreateQueryFunc(aDateBounds : Tl3DateBounds): TdtQuery; far;
 var
  l_AndQuery : TdtAndQuery;
  l_NotQuery : TdtNOTQuery;
  l_LogQuery : TdtQuery;
 begin
  l_AndQuery := TdtAndQuery.Create;
  try
   with aDateBounds do
    l_LogQuery := TdtLogByActionQuery.Create(acAnonced, Low, High);
   try
    l_AndQuery.AddQuery(l_LogQuery);
   finally
     l3Free(l_LogQuery);
   end;

   l_NotQuery := TdtNOTQuery.Create;
   try
    l_LogQuery := TdtLogByActionQuery.Create(acIncluded, 0, 0);
    try
     l_NotQuery.SubQuery := l_LogQuery;
    finally
     l3Free(l_LogQuery);
    end;
    l_AndQuery.AddQuery(l_NotQuery);
   finally
    l3Free(l_NotQuery);
   end;
  except
   l3Free(l_AndQuery);
   raise;
  end;
  Result := l_AndQuery;
 end;

begin
 FindOnDateIntervalAndShow('Поиск анонсированных документов',
                           'Анонсированные документы %s',
                           TarGetQueryFunc(l3LocalStub(@lCreateQueryFunc)));
end;

procedure TMainForm.acFindAlarmExecute(Sender: TObject);
var
 l_Q     : TdtQuery;
 lStart  : TstDate;
 lFinish : TstDate;
 lText   : AnsiString;
begin
 if GetAlarmFindData(lStart, lFinish, lText) then
 begin
  try
   try
    Screen.Cursor := crHourGlass;
    l_Q := TdtAlarmQuery.Create(lStart, lFinish, lText);
    l_Q.DoQuery;
   finally
    Screen.Cursor:=crDefault;
   end;

   if not l_Q.IsEmpty then
    with TSearchWin.Create(Self) do
    begin
     Family := CurrentFamily;
     DocList.Query := l_Q;
     SrchName := 'Документы с напоминаниями';
    end
    else
     vtMessageDlg(l3CStr(@sidNoSuchDoc));
  finally
   l3Free(l_Q);
  end;
 end;
end;

procedure TMainForm.acFindByStageInfoClick(Sender: TObject);
var
 l_Q: TdtQuery;
begin
 with THandlingDocDlg.Create(Self) do
 try
  If ShowModal = mrOK then
  begin
   try
    try
     Screen.Cursor:=crHourGlass;
     l_Q := TdtStageQuery.Create(StDateToDemon(DateTimeToStDate(edtLowDate.Date)),
                                 StDateToDemon(DateTimeToStDate(edtHighDate.Date)),
                                 TStageType(cbStage.Items.Objects[cbStage.ItemIndex]),
                                 TStageFlag(cbStageType.ItemIndex),
                                 TdaUserID(cbUser.Items.Objects[cbUser.ItemIndex]));
     l_Q.DoQuery;
    finally
     Screen.Cursor:=crDefault;
    end;

    if not l_Q.IsEmpty then
     with TSearchWin.Create(Self) do
     begin
      Family := CurrentFamily;
      DocList.Query := l_Q;
      SrchName := 'Документы в обработке';
     end
    else
     vtMessageDlg(l3CStr(@sidNoSuchDoc));
   finally
    l3Free(l_Q);
   end;
  end;
 finally
  Free;
 end;
end;

procedure TMainForm.acFindByJurOperationExecute(Sender: TObject);
var
 l_Q: TdtQuery;
begin
 with TSrchByJurOperationDlg.Create(Self) do
 try
  If ShowModal = mrOK then
  begin
   try
    try
     Screen.Cursor:=crHourGlass;
     l_Q := SQLogByActionsQuery(StDateToDemon(DateTimeToStDate(edtLowDate.Date)),
                                StDateToDemon(DateTimeToStDate(edtHighDate.Date)),
                                GetOperationSet,
                                TdaUserID(cbUser.Items.Objects[cbUser.ItemIndex]));
     l_Q.DoQuery;
    finally
     Screen.Cursor:=crDefault;
    end;

    If not l_Q.IsEmpty then
     with TSearchWin.Create(Self) do
     Begin
      Family := CurrentFamily;
      DocList.Query := l_Q;
      SrchName := Format('Поиск по журналам %s', [MakeDateBoundsStr(edtLowDate.StDate, edtHighDate.StDate)]);
     end
    else
     vtMessageDlg(l3CStr(@sidNoSuchDoc));
   finally
    l3Free(l_Q);
   end;
  end;
 finally
  Free;
 end;
end;

procedure TMainForm.LoadDocsPopUpGetItemFont(Sender: TObject; Index: Integer; const aFont: Il3Font);
begin
 If Index = 0 then
  aFont.Style := aFont.Style + [fsBold];
end;

procedure TMainForm.LoadDocsPopUpGetGetStrItem(Sender : TObject; Index : LongInt; var ItemString : Il3CString);
const
  cNewDocSet = '*Пустая выборка*';
begin
 If Index = 0 then
  ItemString := l3CStr(cNewDocSet)
 else
  ItemString := l3CStr(TSavedQuery(g_dtQueryList.Items[Pred(Index)]).Name)
end;

procedure TMainForm.acLoadDocExtactsClick(Sender: TObject);
 var
  Res : Longint;
 begin
  Res := -1;

  With TvtPopupList.Create(sbLoadDocs, TvtLister) do {TControl(Sender) вместо sbLoadDocs нельзя, т.к. может из меню вызываться}
   try
    with (Lister as TvtLister) do
    begin
     UseStyleTable := True;
     OnGetStrItem := LoadDocsPopUpGetGetStrItem;
     OnGetItemFont := LoadDocsPopUpGetItemFont;
     Total := g_dtQueryList.Count + 1;

     //Items := g_dtQueryList;
     //Items.NeedDisposeStr := false;
     //Items.Assign(QueryList);
     //Items.InsertData(0, cNewDocSet, 0);
     //OnGetItemFont := LoadDocsPopUpGetItemFont;
    end;
    Res := Execute;
   finally
    Free;
   end;

  Application.ProcessMessages;
  If Res < 0 then Exit;

  If Res = 0 then
   OpenNewDocSet
  else
   With TSearchWin.Create(Self) do
   begin
    Family := CurrentFamily;
    Application.ProcessMessages;
    LoadDocSet(TSavedQuery(g_dtQueryList.Items[Pred(Res)]));
   end;
 end;

procedure TMainForm.acSaveDocExtractsClick(Sender: TObject);
 begin
  If (FCurrentChild is TSearchWin) then
   TSearchWin(FCurrentChild).acSaveDocSet.Execute;
 end;

procedure TMainForm.MoveDocStack(aNext : Boolean);
var
 l_NewIndex: Integer;
 l_Item : TDocStackItem;
begin
 if DocStackList.Count = 0 then
  Exit;
 if aNext then
 begin
  if DocStackList.CurrentItem mod 2 <> 0 then
   l_NewIndex := DocStackList.CurrentItem + 2
  else
   l_NewIndex := DocStackList.CurrentItem + 1;
 end
 else
 begin
  if DocStackList.CurrentItem mod 2 <> 0 then
   l_NewIndex := DocStackList.CurrentItem - 1
  else
   l_NewIndex := DocStackList.CurrentItem - 2;
 end;
 // подстраховка
 If not aNext then
  l_NewIndex:=Max(l_NewIndex,0)
 else
  l_NewIndex:=Min(l_NewIndex,DocStackList.Count-1);

 l_Item := DocStackList.DocRec[l_NewIndex];
 RunTextEditor(l_Item.DocFam, l_Item.DocID, False {ROnly},
     MakeBlockRefJumpData(l_Item.AnchorID, l_Item.Positions));
 DocStackList.CurrentItem := l_NewIndex;
end;

procedure TMainForm.sbDocStackListClick(Sender: TObject);
 var
  Res   : Longint;
  DSRec : TDocStackItem;
 begin
  Res := -1;
  If DocStackList.Count = 0 then Exit;
  With TvtPopupList.Create(TControl(Sender), TvtDStringLister) do
   try
    //Lister.Items.ItemType := l3_itString;
    DocStackList.FillStringList((Lister as TvtDStringLister).Items);
    //Lister.Items.HostDataList := DocStackList; //TOFIX
    Lister.Current := DocStackList.CurrentItem;
    Res := Execute;
   finally
    Free;
   end;
   If Res >= 0 then
    begin
     DSRec := DocStackList.DocRec[Res];
     RunTextEditor(DSRec.DocFam, DSRec.DocID, 
                   False {ROnly}, False);
    end;
 end;

procedure TMainForm.acDocStackPrevClick(Sender: TObject);
begin
 MoveDocStack(False);
end;

procedure TMainForm.acDocStackNextClick(Sender: TObject);
begin
 MoveDocStack(True);
end;

procedure TMainForm.DocStackCurrentChange(NewCurrent : LongInt);
begin
 if DocStackList.Count = 0 then
 begin
  acDocStackPrev.Enabled := False;
  acDocStackNext.Enabled := False;
  sbDocStackList.Enabled := False;
 end
 else
 begin
  acDocStackNext.Enabled := NewCurrent < Pred(DocStackList.Count);
  // True, т к  Prev связана с List, хотя поремленное правильнее - переправил взад (fireton)
  acDocStackPrev.Enabled := NewCurrent > 0;
  sbDocStackList.Enabled := True;
 end;
end;

procedure TMainForm.acHelpAboutClick(Sender: TObject);
var
 l_Logo: TLogoDlg;
begin
 //DocumentServer.CheckDocPriorityEx(True, ServerProgressProc);
 //SilentClose := True;
 //Close;
 //exit;

 l_Logo:= TLogoDlg.Create(Nil);
 try
  CorrectLogoImage(l_Logo);
  l_Logo.ShowModal;
 finally
  FreeAndNil(l_logo);
 end;
end;

procedure TMainForm.acShowSubClick(Sender: TObject);
begin
 TSearchWin(FCurrentChild).ShowSubBtnClick(Sender);
end;

procedure TMainForm.acRunEditorClick(Sender: TObject);
begin
 TSearchWin(FCurrentChild).actOpenDocument.Execute;
end;

procedure TMainForm.acRunViewerClick(Sender: TObject);
begin
 TSearchWin(FCurrentChild).RunViewerBtnClick(Sender);
end;

procedure TMainForm.acRemoveItemClick(Sender: TObject);
begin
 TSearchWin(FCurrentChild).DocList.acRemoveItemExecute(Sender);
end;

{Editor}
procedure TMainForm.acSaveClick(Sender: TObject);
begin
 l3System.Send(FCurrentChild, vm_Save, 0, 0);
end;

procedure TMainForm.acPrintClick(Sender: TObject);
begin
 l3System.Send(FCurrentChild, vm_Print, 0, 0);
end;

procedure TMainForm.acCutClick(Sender: TObject);
begin
 l3System.Send(vtGetFocusedForm, vm_Cut, 0, 0);
end;

procedure TMainForm.acCopyClick(Sender: TObject);
begin
 l3System.Send(vtGetFocusedForm, vm_Copy, 0, 0);
end;

procedure TMainForm.acPasteClick(Sender: TObject);
begin
 l3System.Send(vtGetFocusedForm, vm_Paste, 0, 0);
end;

procedure TMainForm.acPrintAllExecute(Sender: TObject);
begin
 if (FCurrentChild <> nil) then
  if (FCurrentChild is TCustomEditorWindow) then
   TCustomEditorWindow(FCurrentChild).PrintAll
  else
   TSearchWin(FCurrentChild).DocList.acPrintAllExecute(Sender);
end;

procedure TMainForm.acFindClick(Sender: TObject);
begin
 if (FCurrentChild <> nil) then
  if (FCurrentChild is TCustomEditorWindow) then
   TCustomEditorWindow(FCurrentChild).Find_or_Replace
  else
   TSearchWin(FCurrentChild).FindButtonClick(Sender);
end;

procedure TMainForm.acFindNextClick(Sender: TObject);
begin
 if (FCurrentChild <> nil) then
  if (FCurrentChild is TCustomEditorWindow) then
   TCustomEditorWindow(FCurrentChild).FindNext
  else
   TSearchWin(FCurrentChild).FindAgainButtonClick(Sender);
end;

procedure TMainForm.StyleComboBoxChange(Sender: TObject);
begin
 if (FCurrentChild <> nil) and (FCurrentChild is TCustomEditorWindow) then
  TCustomEditorWindow(FCurrentChild).StyleComboBoxChange(Sender);
end;

procedure TMainForm.StyleComboBoxDropDown(Sender: TObject);
begin
 if (FCurrentChild <> nil) and (FCurrentChild is TCustomEditorWindow) then
  TCustomEditorWindow(FCurrentChild).StyleComboBoxDropDown(Sender);
end;

procedure TMainForm.FontComboBoxChange(Sender: TObject);
begin
 If (FCurrentChild <> nil) and (FCurrentChild is TDocEditorWindow) then
  TDocEditorWindow(FCurrentChild).FontComboBoxChange(Sender);
end;

procedure TMainForm.FontSizeComboBoxChange(Sender: TObject);           
begin
 if (FCurrentChild <> nil) and (FCurrentChild is TDocEditorWindow) then
  TDocEditorWindow(FCurrentChild).FontSizeComboBoxChange(Sender);
end;

procedure TMainForm.ColorComboBoxChange(Sender: TObject);
begin
 if (FCurrentChild <> nil) and (FCurrentChild is TDocEditorWindow) then
  TDocEditorWindow(FCurrentChild).ColorComboBoxChange(Sender);
end;

procedure TMainForm.seZoomExit(Sender: TObject);
begin
 if FCurrentChild is TDocEditorWindow then
  TDocEditorWindow(FCurrentChild).seZoomExit(Sender);
end;

procedure TMainForm.seZoomBottomClick(Sender: TObject);
begin
 if (FCurrentChild is TDocEditorWindow) then
  TDocEditorWindow(FCurrentChild).seZoomUpDownClick(Sender);
end;

procedure TMainForm.seZoomTopClick(Sender: TObject);
begin
 if (FCurrentChild is TDocEditorWindow) then
  TDocEditorWindow(FCurrentChild).seZoomUpDownClick(Sender);
end;

procedure TMainForm.seZoomKeyPress(Sender: TObject; var Key: Char);
begin
 if (FCurrentChild is TDocEditorWindow) then
  TDocEditorWindow(FCurrentChild).seZoomKeyPress(Sender, Key);
end;

procedure TMainForm.dxseZoomButtonClick(Sender: TdxBarSpinEdit; Button: TdxBarSpinEditButton);
begin
 if (FCurrentChild is TDocEditorWindow) then
  TDocEditorWindow(FCurrentChild).seZoomUpDownClick(Sender);
end;

procedure TMainForm.dxseZoomCurChange(Sender: TObject);
begin
//
end;

procedure TMainForm.dxseZoomExit(Sender: TObject);
begin
 If FCurrentChild is TDocEditorWindow then
  TDocEditorWindow(FCurrentChild).seZoomExit(Sender);
end;

procedure TMainForm.dxseZoomKeyPress(Sender: TObject; var Key: Char);
begin
 TDocEditorWindow(FCurrentChild).seZoomKeyPress(Sender, Key);
end;

procedure TMainForm.acShowSpecSymbolClick(Sender: TObject);
 begin
  IniRec.ShowSpecSymbol := acShowSpecSymbol.Checked;
  If FCurrentChild is TDocEditorWindow then
   TDocEditorWindow(FCurrentChild).sbShowSpecSymbolClick(Sender);
 end;

procedure TMainForm.acWebStyleClick(Sender: TObject);
begin
 IniRec.ShowWebStyle := acWebStyle.Checked;
 if FCurrentChild is TDocEditorWindow then
  TDocEditorWindow(FCurrentChild).sbWebStyleClick(Sender);
end;

procedure TMainForm.acShowSelectExecute(Sender: TObject);
begin
 IniRec.ShowFoundWordLighting := acShowSelect.Checked;
 if FCurrentChild is TCustomEditorWindow then
  TCustomEditorWindow(FCurrentChild).SetShowSelect;
end;

procedure TMainForm.acShowDocumentPartsClick(Sender: TObject);
begin
 IniRec.ShowDocumentParts := acShowDocumentParts.Checked;
 if FCurrentChild is TDocEditorWindow then
  TDocEditorWindow(FCurrentChild).sbShowDocumentPartsClick(Sender);
end;

procedure TMainForm.sbShowClassTreeClick(Sender: TObject);
begin
 if FCurrentChild is TDocEditorWindow then
  TDocEditorWindow(FCurrentChild).ShowClassEditor(atClasses);
end;

procedure TMainForm.sbShowKWTreeClick(Sender: TObject);
begin
 if FCurrentChild is TDocEditorWindow then
  TDocEditorWindow(FCurrentChild).ShowClassEditor(atKeyWords);
end;

procedure TMainForm.sbListToDocSetClick(Sender: TObject);
begin
 if FCurrentChild is TDocEditorWindow then
  TDocEditorWindow(FCurrentChild).ListToDocSetBtnClick(Sender);
end;

procedure TMainForm.acGotoNextOccurClick(Sender: TObject);
begin
 if FCurrentChild is TDocEditorWindow then
  TDocEditorWindow(FCurrentChild).sbGotoNextOccurClick(Sender);
end;

procedure TMainForm.acGotoPrevOccurClick(Sender: TObject);
begin
 {
 if FCurrentChild is TDocEditorWindow then
  TDocEditorWindow(FCurrentChild).sbGotoPrevOccurClick(Sender);}
end;

procedure TMainForm.ClipBoardSpyChange(Sender: TObject);
begin
 if (fCurrentChild <> nil) and fCurrentChild.HandleAllocated then
  PostMessage(fCurrentChild.Handle, wm_WinClipChange, 0, 0);
  //l3System.Send(fCurrentChild, wm_WinClipChange, 0, 0);
end;

procedure TMainForm.SetDictEditorEnable(aDict : TdaDictionaryType; Enable : boolean);
begin
 if Enabled then
  DisabledDict := DisabledDict - [aDict]
 else
  DisabledDict := DisabledDict + [aDict];
end;

procedure TMainForm.acAddClick(Sender: TObject);
begin
 FCurrentChild.Perform(wm_WinAddClick,0,0);
end;

procedure TMainForm.acEditClick(Sender: TObject);
begin
 FCurrentChild.Perform(wm_WinEditClick,0,0);
end;

procedure TMainForm.acDeleteClick(Sender: TObject);
begin
 FCurrentChild.Perform(wm_WinDelClick,0,0);
end;

procedure TMainForm.acSaveToFileClick(Sender: TObject);
begin
 if FCurrentChild is TDictMetaForm then
  TDictMetaForm(FCurrentChild).sbSaveToFile(Sender);
end;

procedure TMainForm.acSortClick(Sender: TObject);
begin
 if FCurrentChild is TDictMetaForm then
  TDictMetaForm(FCurrentChild).SortLevel;
end;

procedure TMainForm.acDictUndoClick(Sender: TObject);
begin
 if FCurrentChild is TTreeDesignerForm then
  TTreeDesignerForm(FCurrentChild).UndoEdit;
end;

procedure TMainForm.acDictTransformToDivisionClick(Sender: TObject);
begin
 if FCurrentChild is TTreeDesignerForm  then
  TTreeDesignerForm(FCurrentChild).acTransformToDivisionClick(Sender);
end;

procedure TMainForm.ShowExplorer(aShow : Boolean);
begin
 If aShow then
 begin
  If LeftDockPanel.Width = 0 then
   LeftDockPanel.Width := IniRec.ExplorerWidth;
  OEWin.ManualDock(LeftDockPanel {Host}, nil, alClient {DockType});
 end
 else
 begin
  LeftDockPanel.Width := 0;
 end;

 //OEWin.ManualDock(LeftDockPanel {Host}, nil, alClient {DockType});
 //ShowDockPanel(LeftDockPanel, aShow, OEWin);

 vtVisibleAndEnabled(acShowObjectExplorer, not aShow);
 vtVisibleAndEnabled(acHideObjectExplorer, aShow);
end;

procedure TMainForm.piShowExplorerClick(Sender: TObject);
begin
 ShowExplorer(True);
end;

procedure TMainForm.piHideExplorerClick(Sender: TObject);
begin
 ShowExplorer(False);
end;

procedure TMainForm.WMDropAccept(var Message: TMessage);
begin
 OEWin.WMDropAccept(Message);
end;

procedure TMainForm.WMDelDoc(var Message: TMessage);
begin
 OEWin.DelFromExplorer(eotMRUDocument, Message.LParam);
end;

procedure TMainForm.WMLogoff(var Message: TMessage);
begin
 SilentClose := True;
 Close;
end;

procedure TMainForm.acStyleSheetEditorClick(Sender: TObject);
begin
 With TStyleDesignDlg.Create(Self) do
  Try
   //btLoad.Visible := False;
   If ShowModal = mrOk then
   begin
    SaveStyleParam;
    Try
     If Not FileExists(IniRec.StyleTbl) or
        (IniRec.StyleTbl = ConcatDirName(GlobalHtServer.FamilyTbl.FamilyPath(MainTblsFamily), sidStyleFileName)) then
      IniRec.StyleTbl := ConcatDirName(GlobalDataProvider.CurHomePath, sidStyleFileName);
     StyleFiler.FileName:=IniRec.StyleTbl;
     SaveStyleTblTo(IniRec.StyleTbl);
    except
     acSaveAsStyleSheetClick(Self);
    end;
   end;
  finally
   Release;
  end;
end;

procedure TMainForm.acLoadStyleSheetClick(Sender: TObject);
begin
 StyleOpenDialog.InitialDir := GlobalDataProvider.CurHomePath;
 If StyleOpenDialog.Execute then
 begin
  If FileExists(IniRec.StyleTbl) then
  begin
   LoadStyleTblFrom(StyleOpenDialog.FileName);
   IniRec.StyleTbl := StyleOpenDialog.FileName;
  end;
 end;
end;

procedure TMainForm.acSaveAsStyleSheetClick(Sender: TObject);
begin
 StyleSaveAsDialog.InitialDir := GlobalDataProvider.CurHomePath;
  If StyleSaveAsDialog.Execute then
  begin
   IniRec.StyleTbl := StyleSaveAsDialog.FileName;
   SaveStyleTblTo(IniRec.StyleTbl);
  end;
end;

procedure TMainForm.SaveStyleTblTo(STFileName : AnsiString);
var
 StyleInterface : TevStyleInterfaceEx;
begin
 StyleInterface := TevStyleInterfaceEx.Create;
 try
  StyleInterface.SelectStyledObjectType(k2_typTextPara);
  try
   StyleFiler.FileName := STFileName;
   StyleInterface.Save(EverestWriter);
  except
   on EFOpenError do ;
  end;{try..except}
 finally
  l3Free(StyleInterface);
 end;{try..finally}
end;

procedure TMainForm.LoadStyleTblFrom(STFileName : AnsiString);
var
 StyleInterface  : TevStyleInterfaceEx;
begin
 StyleInterface := TevStyleInterfaceEx.Create;
 try
  StyleInterface.SelectStyledObjectType(k2_typTextPara);
  try
   StyleFiler.FileName := STFileName;
   StyleInterface.Load(EverestReader);
  except
   on EFOpenError do ;
  end;{try..except}
 finally
  l3Free(StyleInterface);
 end;{try..finally}
end;

procedure TMainForm.acSaveLayingClick(Sender: TObject);
begin
 if (FCurrentChild is TDocEditorWindow) then
  TDocEditorWindow(FCurrentChild).SaveStateToIni;
end;

procedure TMainForm.acSpellCheckerClick(Sender: TObject);
begin
 if (FCurrentChild is TDocEditorWindow) then
  TDocEditorWindow(FCurrentChild).RunSpellChecker;
end;

procedure TMainForm.CreateToolbarMenus;
var
 l_MenuItem : TMenuItem;
 l_Index    : Long;
 l_Comp     : TComponent;
begin
 for l_Index := 0 to Pred(ComponentCount) do
 begin
  l_Comp := Components[l_Index];
  if (l_Comp Is TToolbar97) then
  begin
   TToolbar97(l_Comp).OnVisibleChanged := ToolbarVisibleChanged;
   l_MenuItem := TMenuItem.Create(miToolbar);
   with l_MenuItem do
   begin
    Caption := TToolbar97(l_Comp).Caption;
    Checked := TToolbar97(l_Comp).Visible;
    AutoCheck := true;
    Tag := Integer(l_Comp);
    OnClick := miViewPanelsClick;
   end;//with l_MenuItem

   miToolbar.Add(l_MenuItem);
  end;//l_Comp Is TToolbar97
 end;//for l_Index

 for l_Index := 0 to miToolbar.Count - 1 do
  with miToolbar.Items[l_Index] do
  begin
   l_MenuItem := NewItem(Caption, ShortCut, Checked,
                               Enabled, OnClick, HelpContext,
                               Name + 'Popup');
   l_MenuItem.AutoCheck := true;
   l_MenuItem.Tag := Tag;
   //l_MenuItem.OnClick := OnClick;
   pmToolbar.Items.Add(l_MenuItem);

  end;
end;

procedure TMainForm.miViewPanelsClick(Sender: TObject);
  {-}
begin
 with (Sender As TMenuItem) do begin
  TToolbar97(Tag).Visible := Checked;
 end;//with (Sender As TevMenuItem)
end;

procedure TMainForm.ToolbarVisibleChanged(Sender: TObject);
var
 l_Index : Long;
begin
 for l_Index := 0 to Pred(miToolbar.Count) do
  with miToolbar[l_Index] do
   if (Tag = Long(Sender)) then
   begin
    Checked := (Sender As TToolbar97).Visible;
    System.break;
   end;//Tag = Long(Sender)

 for l_Index := 0 to Pred(pmToolbar.Items.Count) do
  with pmToolbar.Items[l_Index] do
   if (Tag = Long(Sender)) then
   begin
    Checked := (Sender As TToolbar97).Visible;
    System.break;
   end;//Tag = Long(Sender)
end;

procedure TMainForm.acOpenByNumberClick(Sender: TObject);
var
 l_DocID   : TDocID;
 l_Sub     : TSubID;
 l_Renum   : Boolean;
begin
 if GetIDNumber(l_DocID, l_Sub, l_Renum, 'Открыть по номеру', hcAddDoc) then
  OpenDocByNumber(l_DocID, l_Sub, l_Renum);
end;

procedure TMainForm.acHelpClick(Sender: TObject);
begin
 Application.HelpContext(0);
end;

procedure TMainForm.acSettingsClick(Sender: TObject);
var
 i        : Integer;
 l_CfgDlg : TConfigDlg;
 l_OldNVDFromServer: Boolean;
begin
 l_CfgDlg := TConfigDlg.Create(Self);
 try
  l_OldNVDFromServer := IniRec.NVDFromServer;
  if l_CfgDlg.Execute then
  begin
   for i := 0 to Pred(MDIChildCount) do
    if MDIChildren[i] is TDocEditorWindow then
     (MDIChildren[i] as TDocEditorWindow).DocTextEditor.UpdateHRuler;
   if (not g_BaseEngine.ServiceParams.StandAlone) and (not l_OldNVDFromServer) and (IniRec.NVDFromServer) then
    ArchiRequestManager.RequestNextVersionDate;  
  end;
 finally
  l_CfgDlg.Free;
 end;
end;

function  TMainForm.DropListGetItemImageIndex(Sender : TObject; Index : Longint) : Integer;
begin
 Result := DictsSup.GetDictImageIndex(TdaDictionaryType((Sender as TvtDStringlister).Items.DataInt[Index]));
end;

procedure TMainForm.acDictDesignClick(Sender: TObject);
var
 Res    : Longint;
 lID    : TdaDictionaryType;
 l_DictForm : TForm;

 function lGetDictForm(aDictID : TdaDictionaryType) : TForm;
  var
   I: Integer;
   lFrm : TForm;
  begin
   Result := nil;
   for I := Pred(MDIChildCount) downto 0 do
    begin
     lFrm := MDIChildren[I];
     if (lFrm is TDictMetaForm) and (TDictMetaForm(lFrm).DictID = aDictID) then
     begin
      Result := lFrm;
      Exit;
     end;
    end;
  end;

 begin
  with TvtPopupList.Create(sbDictDesign,TvtDStringLister) do
   try
    with (Lister as TvtDStringLister).Items do
    begin
     DataSize := 4;
     NeedAllocStr := True;
     Changing;
     try
      for lID := Low(TdaDictionaryType) to High(TdaDictionaryType) do
      begin
       if (lID in EditableDict) and not (lID in DisabledDict) then
        Add(PAnsiChar(GetDictName(lID)), @lID);
      end;
     finally
      Changed;
     end;
    end;
    Lister.Images := ArchiResources.CommonImageList;
    Lister.OnGetItemImageIndex := DropListGetItemImageIndex;

    Res := Execute;
    if Res < 0 then Exit;
    lID := TdaDictionaryType((Lister as TvtDStringLister).Items.DataInt[Res]);
   finally
    Free;
   end;

  l_DictForm := lGetDictForm(lID);
  if l_DictForm <> nil then
  begin
   PostMessage(ClientHandle, WM_MDIActivate, WParam(l_DictForm.Handle), 0);
   Exit;
  end;

  if lID = da_dlTextInsert then
   TInsertTextDictForm.Create(Self, dmEdit)
  else
   TTreeDesignerForm.Create(Self, CurrentFamily, lID, dmEdit);
 end;

procedure TMainForm.LeftDockPanelDockDrop(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer);
begin
  //OnDockDrop gets called AFTER the client has actually docked,
  //so we check for DockClientCount = 1 before making the dock panel visible.
  if (Sender as TPanel).DockClientCount = 1 then
    ShowDockPanel(Sender as TPanel, True, nil);
  (Sender as TPanel).DockManager.ResetBounds(True);
  //Make DockManager repaints it's clients.
end;

procedure TMainForm.LeftDockPanelDockOver(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
var
  ARect: TRect;
begin
  Accept := Source.Control is TObjectExplorerWin;
  if Accept then
  begin
    //Modify the DockRect to preview dock area.
    ARect.TopLeft := LeftDockPanel.ClientToScreen(Point(0, 0));
    ARect.BottomRight := LeftDockPanel.ClientToScreen(
      Point(Self.ClientWidth div 3, LeftDockPanel.Height));
    Source.DockRect := ARect;
  end;
end;

procedure TMainForm.BottomDockPanelDockOver(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
var
  ARect: TRect;
begin
  Accept := Source.Control is TObjectExplorerWin;
  if Accept then
  begin
    //Modify the DockRect to preview dock area.
    ARect.TopLeft := BottomDockPanel.ClientToScreen(
      Point(0, -Self.ClientHeight div 3));
    ARect.BottomRight := BottomDockPanel.ClientToScreen(
      Point(BottomDockPanel.Width, BottomDockPanel.Height));
    Source.DockRect := ARect;
  end;
end;

procedure TMainForm.LeftDockPanelGetSiteInfo(Sender: TObject;
  DockClient: TControl; var InfluenceRect: TRect; MousePos: TPoint;
  var CanDock: Boolean);
begin
  //if CanDock is true, the panel will not automatically draw the preview rect.
  CanDock := DockClient is TObjectExplorerWin;

end;

procedure TMainForm.LeftDockPanelUnDock(Sender: TObject; Client: TControl;
  NewTarget: TWinControl; var Allow: Boolean);
begin
  //OnUnDock gets called BEFORE the client is undocked, in order to optionally
  //disallow the undock. DockClientCount is never 0 when called from this event.
  if (Sender as TPanel).DockClientCount = 1 then
    ShowDockPanel(Sender as TPanel, False, nil);
end;

procedure TMainForm.ShowDockPanel(APanel: TPanel; MakeVisible: Boolean; Client: TControl);
begin
  //Client - the docked client to show if we are re-showing the panel.
  //Client is ignored if hiding the panel.

  //Since docking to a non-visible docksite isn't allowed, instead of setting
  //Visible for the panels we set the width to zero. The default InfluenceRect
  //for a control extends a few pixels beyond it's boundaries, so it is possible
  //to dock to zero width controls.

  //Don't try to hide a panel which has visible dock clients.

  if not MakeVisible and (APanel.VisibleDockClientCount > 1) then Exit;

  if APanel = LeftDockPanel then
   begin
    VSplitter.Visible := MakeVisible;
    VSplitter.SplitControl := APanel;
   end
   else
   begin
    HSplitter.Visible := MakeVisible;
    HSplitter.SplitControl := APanel;
   end;

  //IniRec.ExplorerShow  := MakeVisible;

  if MakeVisible
   then
    if APanel = LeftDockPanel
     then
      begin
       APanel.Width := IniRec.ExplorerWidth; //ClientWidth div 3;
       VSplitter.Left := APanel.Width + VSplitter.Width;
      end
     else
      begin
       APanel.Height := IniRec.ExplorerWidth;//ClientHeight div 3;
       HSplitter.Top := ClientHeight - APanel.Height - HSplitter.Width;
      end
   else
    if APanel = LeftDockPanel
     then
      begin
       //if APanel.Width > 0 then IniRec.ExplorerWidth := APanel.Width;
       APanel.Width := 0;
      end
     else
      begin
       //if APanel.Height > 0 then IniRec.ExplorerWidth := APanel.Height;
       APanel.Height := 0;
      end;

  if MakeVisible and (Client <> nil) then Client.Show;
end;

procedure TMainForm.LeftDockPanelResize(Sender: TObject);
begin
 if LeftDockPanel.Width > 0 then IniRec.ExplorerWidth := LeftDockPanel.Width;
 IniRec.ExplorerShow := LeftDockPanel.Width > 0;
end;

procedure TMainForm.BottomDockPanelResize(Sender: TObject);
begin
 if BottomDockPanel.Height > 0 then IniRec.ExplorerWidth := BottomDockPanel.Height;
 IniRec.ExplorerShow := BottomDockPanel.Height > 0;
end;

procedure TMainForm.acDocImportClick(Sender: TObject);
var
 lAbsJourOperationRights : Boolean;
begin
 if not CheckServer then
  Exit;
 if not CreateImportTask(ar_ikDoc, AccessServer.TestRightsMaskForDocGroup(CurrentFamily,agIncludedGroup,acgJurOp)) then
 begin
  ShowMessage('Не удалось отправить задачу на сервер.');
 end;
end;

procedure TMainForm.acAnnoImportFromRTFExecute(Sender: TObject);
begin
 if not CheckServer then
  Exit;
 if not CreateImportTask(ar_ikAnnotation, True) then
 begin
  ShowMessage('Не удалось отправить задачу на сервер.');
 end;
end;

procedure TMainForm.acMacroInsertDocChangesClick(Sender: TObject);
begin
 Macros_InsertDocChanges;
end;

procedure TMainForm.acMacroMakeDocEditionExecute(Sender: TObject);
begin
 Macros_MakeChangeDoc;
end;

procedure TMainForm.acMacroReplaceFutureEditionToCurrentExecute(Sender: TObject);
begin
 Macros_ReplaceFutureEditionToCurrent;
end;

procedure TMainForm.acDelAllHyperLinksClick(Sender: TObject);
begin
 if FCurrentChild is TSearchWin then
  TSearchWin(FCurrentChild).DeleteAllHyperLinks;
end;

procedure TMainForm.acSetSpecBaseClick(Sender: TObject);
begin
 if FCurrentChild is TSearchWin then
  TSearchWin(FCurrentChild).SpecialAction;
end;

procedure TMainForm.miSetPrefixClick(Sender: TObject);
begin
 if FCurrentChild is TSearchWin then
  TSearchWin(FCurrentChild).SetDictLinks(da_dlPrefixes);
end;

procedure TMainForm.acDocOnStageStatClick(Sender: TObject);
var
 I : Integer;
begin
 with TDocByStageInfoDlg.Create(self) do
  if Execute(CurrentFamily) then
  begin
   for I := 0 to Pred(InfoLister.Items.Count) do
    if (not TdtQuery(InfoLister.Items.DataInt[I]).IsEmpty) and
       (InfoLister.Selected[I]) then
     With TSearchWin.Create(Self) do
     begin
      Family := CurrentFamily;
      DocList.Query := TdtQuery(InfoLister.Items.DataInt[I]);
      SrchName := Format('Документы на стадии "%s"',
                         [StageNameByID(dbsStatStageSeq[Pred(SizeOf(dbsStatStageSeq)) - I])]);
                         //StageStringConst[dbsStatStageSeq[Pred(SizeOf(dbsStatStageSeq)) - I]]]);
     end;
  end;
end;

procedure TMainForm.acApplayClassDeltaClick(Sender: TObject);
var
 l_FileName : TFileName;
begin
 if RequestFileName(l_FileName, Self, 'Файл - дельта', 'Укажите файл - дельту'^M'для классификатора') then
 begin
  ApplyClassDeltaFile(CurrentFamily, l_FileName);
  vtMessageDlg(l3CStr('Словарь Классов обновлен.'), mtInformation);
 end;
end;

procedure TMainForm.acApplayClassBatchofLinkClick(Sender: TObject);
var
 l_FileName : TFileName;
begin
 if RequestFileName(l_FileName, Self, 'Файл с линками', 'Укажите файл - пачку линков'^M'для классификатора') then
 begin
  ApplyClassBatchFile(CurrentFamily, l_FileName);
  vtMessageDlg(l3CStr('Линки Классов обновлены.'), mtInformation);
 end;
end;

procedure TMainForm.acCloseActChildWinExecute(Sender: TObject);
begin
 if ActiveMDIChild <> nil then ActiveMDIChild.Close;
end;

procedure TMainForm.acReplaceClassFromProjectClick(Sender: TObject);
begin
 Assert(False, 'Deprecated dlNewClasses');
(* DictServer(CurrentFamily).Family := CurrentFamily;
 DictServer(CurrentFamily).CopyFromJournaledDict(dlNewClasses,da_dlClasses);
 vtMessageDlg(l3CStr(@sidProcessDone), mtInformation);*)
end;

procedure TMainForm.miMakeClassProjectClick(Sender: TObject);
begin
 Assert(False, 'Deprecated dlNewClasses');
(* DictServer(CurrentFamily).Family := CurrentFamily;
 DictServer(CurrentFamily).CopyToJournaledDict(da_dlNewClasses,da_dlClasses);
 vtMessageDlg(l3CStr(@sidProcessDone), mtInformation);*)
end;

procedure TMainForm.acDelWarningsClick(Sender: TObject);
begin
 with TSrchByActionDlg.Create(Self, 'Удаление Предупреждений') do
  try
   if Execute then
   begin
    LinkServer(CurrentFamily).Alarms.DelAlarmsinDiapason(edtLowDate.StDate, edtHighDate.StDate);

    // vtMessageDlg(sidNoSuchDoc);
   end;
  finally
   Free;
  end;
end;

procedure TMainForm.miDel_0_FromRenumClick(Sender: TObject);
var
 lDocID : TDocID;
 lRelFlag : Boolean;
begin
 LinkServer(CurrentFamily).Renum.DelAllLinkItems(0);
 lDocID := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(lDocID);
 if lDocID > 0 then
  if not DocumentServer(CurrentFamily).CheckDoc(lDocID, True, lRelFlag) then
   LinkServer(CurrentFamily).Renum.DelAllLinkItems(lDocID)
  else
   ShowMessage(format('Пожалуйста проверьте внешний номер у документа с внутренним номером %d', [lDocID]));
end;

procedure TMainForm.miInternalDelDocClick(Sender: TObject);
var
 LockHandle : TJLHandle;
 lDocID     : Longint;
 lRenum     : Boolean;
 lSaveNum   : Longint;
begin
 if not GetIDNumber(lDocID, lRenum, 'Удалить документ', hcAddDoc) then Exit;
 lSaveNum := lDocID;
 if lRenum then
 begin
  lDocID := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(lDocID);
  if lDocID = -1 then raise Exception.CreateFmt(sidNoDocPresent,[lSaveNum]);
 end;

 LockHandle := LockServer.FullLockDoc(CurrentFamily, lDocID);
 try
  if LockHandle = -1 then
   raise Exception.Create(sidDocLockDeny)
  else
  begin
   try
    Screen.Cursor := crHourGlass;
    DocumentServer.DelDoc(lDocID);
    //Result := True;
   finally
    Screen.Cursor:=crDefault;
   end;
  end;
 finally
  LockServer.UnLockDoc(CurrentFamily, LockHandle);
 end;
end;

procedure TMainForm.acFindMisprintsClick(Sender: TObject);
begin
 with TMissTypesListForm.Create(Self) do; // Show;
end;

procedure TMainForm.acUndoBufferClick(Sender: TObject);
begin
 if (FCurrentChild is TDocEditorWindow) then
  with TDocEditorWindow(FCurrentChild) do
  begin
   if (UndoBrowser = nil) then
    UndoBrowser := TUndoContentsForm.Make(FCurrentChild,
                      DocTextEditor.DocEditor.TextSource.Processor);
   UndoBrowser.Show;
  end;//TDocEditorWindow(FCurrentChild)
end;

procedure TMainForm.acNewDocSetExtactsClick(Sender: TObject);
begin
 OpenNewDocSet;
end;

procedure TMainForm.dxiFindDocsDropDown(AControl: TdxBarButtonControl; X, Y: Integer; ByMouse: Boolean);
const
 cNewDocSet = '*Пустая выборка*';
var
 l_Res : Longint;
 lDDComp : TvtPopupList;
begin
(* l_Res := -1;
 with TvtPopupList.Create(Self, TvtDStringLister, Point(X,Y)) do {TControl(Sender) вместо sbLoadDocs нельзя, т.к. может из меню вызываться}
  try
   with Lister as TvtDStringLister do
   begin
    Items.NeedDisposeStr := False;
    Items.Assign(AsksList);
    Items.InsertData(0, cNewDocSet, 0);
    OnGetItemFont := LoadDocsPopUpGetItemFont;
   end;
   l_Res := Execute;
  finally
   Free;
  end;
 Application.ProcessMessages;
 if l_Res < 0 then Exit;

 if l_Res = 0 then
  OpenNewDocSet
 else
  with TSearchWin.Create(Self) do
  begin
   Family := CurrentFamily;
   LoadDocSet(AsksList.DataInt[Pred(l_Res)]);
  end;
  *)
end;

procedure TMainForm.dxiDocStackPrevDropDown(AControl: TdxBarButtonControl; X, Y: Integer; ByMouse: Boolean);
var
 l_Res : Longint;
 DSRec : TDocStackItem;
begin
 l_Res := -1;
 If DocStackList.Count = 0 then Exit;
 with TvtPopupList.Create(Self, TvtDStringLister, Point(X,Y)) do
  try
   DocStackList.FillStringList((Lister as TvtDStringLister).Items);
   //Lister.Items.HostDataList := DocStackList; TOFIX
   Lister.Current := DocStackList.CurrentItem;
   l_Res := Execute;
  finally
   Free;
  end;
  if l_Res >= 0 then
  begin
   DSRec := DocStackList.DocRec[l_Res];
   RunTextEditor(DSRec.DocFam, DSRec.DocID,
                 False {ROnly}, False);
  end;
end;

procedure TMainForm.miTaskQueryStatusClick(Sender: TObject);
begin
 if not CheckServer then
  Exit;
 // Тут посылается запрос, в ответ приезжает очередь, обновление в другом месте
 if ArchiRequestManager.GetLine then
  ArchiRequestManager.ShowTaskList
 else
  ShowMessage('Не удалось получить информацию об очереди заданий.');
end;

procedure TMainForm.acDeleteCellExecute(Sender: TObject);
var
 l_Table: IedTable;
begin
 if (FCurrentChild <> Nil) then
  if (FCurrentChild is TCustomEditorWindow) then
  begin
   l_Table := TCustomEditorWindow(FCurrentChild).CurEditor.Range.Table;
   if l_Table <> nil then
    if l_Table.Cell <> nil then
     l_Table.Cell.Delete(nil);
  end; // (FCurrentChild is TCustomEditorWindow)
end;

procedure TMainForm.acDeleteTableExecute(Sender: TObject);
var
 l_Table: IedTable;
begin
 if (FCurrentChild <> Nil) then
  if (FCurrentChild is TCustomEditorWindow) then
  begin
   l_Table := TCustomEditorWindow(FCurrentChild).CurEditor.Range.Table;
   if l_Table <> nil then
    l_Table.Delete;
  end; // (FCurrentChild is TCustomEditorWindow)
end;

procedure TMainForm.acAutoCompletePropsExecute(Sender: TObject);
begin
 with TAutoCompleteCfgDlg.Create(Self) do
  ShowModal;
end;

procedure TMainForm.WMRefreshDocs(var Message: TMessage);
var
 I : Longint;
begin
 for I := 0 to Pred(MDIChildCount) do
  if (MDIChildren[I] is TSearchWin) then
   TSearchWin(MDIChildren[I]).DocList.RefreshQueryResults;
end;

procedure TMainForm.acAnno_CloseDayExecute(Sender: TObject);
begin
 if ArchiRequestManager.SendAnnotationExportTask then
  ShowMessage('Аннотации отправлены пользователям')
 else
  ShowMessage('Не удалось отправить аннотации пользователям');
end;

procedure TMainForm.BuildDictionarySubMenu;
var
 i: integer;
 lID : TdaDictionaryType;
 l_Action : TAction;
 l_Item, l_ToolsMenu : TMenuItem;
 l_IsAdmin : Boolean;
 l_Index : Integer;
begin
 l_IsAdmin := GlobalDataProvider.AdminRights;
 acLoadDeltaKW.Enabled := l_IsAdmin;
 acMakeClassifierCopy.Enabled := False and l_IsAdmin;
 acChangeClassifier.Enabled := False and l_IsAdmin;
 l_Index := 0;
 for lID := Low(TdaDictionaryType) to High(TdaDictionaryType) do
 begin
  //lID := AttrIDOrder[I];
  if (lID in EditableDict) and not (lID in DisabledDict) then
  begin
   // Создать действие
   l_Action := TAction.Create(DictActList);
   l_Action.ActionList := DictActList;
   l_Action.Caption := GetDictName(lID);
   l_Action.Tag := Ord(lID);
   l_Action.OnExecute := acDictionaryExecute;
   l_Action.ImageIndex := DictsSup.GetDictImageIndex(lID);
   // Создать элемент меню
   l_Item := TMenuItem.Create(Self);
   menuDicts.Insert(l_Index, l_Item);
   Inc(l_Index);
   // Связать действие и элемент меню
   l_Item.Action := l_Action;
  end; // (Byte(lID) in EditableDict) and not (Byte(lID) in DisabledDict)
 end; // for I
end;

procedure TMainForm.acDictionaryExecute(Sender: TObject);
var
  l_DictForm : TForm;

 function lGetDictForm(aDictID : TdaDictionaryType) : TForm;
  var
   I: Integer;
   lFrm : TForm;
  begin
   Result := nil;
   for I := Pred(MDIChildCount) downto 0 do
    begin
     lFrm := MDIChildren[I];
     If (lFrm is TDictMetaForm) and (TDictMetaForm(lFrm).DictID = aDictID) then
     begin
      Result := lFrm;
      Exit;
     end;
    end;
  end;
begin
 l_DictForm := lGetDictForm(TdaDictionaryType((Sender as TAction).Tag));
 if l_DictForm <> nil then
 begin
  PostMessage(ClientHandle, WM_MDIActivate, WParam(l_DictForm.Handle), 0);
  Exit;
 end;

 if TdaDictionaryType((Sender as TAction).Tag) = da_dlTextInsert then
  TInsertTextDictForm.Create(Self, dmEdit)
 else
  TTreeDesignerForm.Create(Self, CurrentFamily, TdaDictionaryType((Sender as TAction).Tag), dmEdit);
end;

procedure TMainForm.acLoadDeltaKWExecute(Sender: TObject);
var
 l_Delta, l_Kill: AnsiString;
begin
 if RequestDeltaKWFileNames(Self, l_Delta, l_Kill) then
  TDeltaKWDialog.Create(Application).Execute(l_Delta, l_Kill);
end;

procedure TMainForm.acCommMonitorExecute(Sender: TObject);
begin
 ArchiRequestManager.Write2Log := not ArchiRequestManager.Write2Log;
 if ArchiRequestManager.Write2Log then
  StatusBar.Panels[sbiMsgLog].Text := 'MSGLOG'
 else
  StatusBar.Panels[sbiMsgLog].Text := ''
end;

procedure TMainForm.PrepareStack;
begin
 DocStackList.PrepareForPair;
end;

procedure TMainForm.acExportDictionaryExecute(Sender: TObject);
var
 l_FileName : TFileName;
begin
 if RequestFileName(l_FileName, Self, 'Экспорт словарей', 'Укажите каталог') then
 begin
  ExportAllDictionary(DictServer(CurrentFamily), l_FileName);
 end;
end;

procedure TMainForm.acAttrCopyExecute(Sender: TObject);
var
 lDonorDocID,
 lAcceptorDocID,
 SaveNum : Integer;
begin
 lDonorDocID    := 0;
 lAcceptorDocID := 0;

 if not RequestAttrCopyData(lDonorDocID, lAcceptorDocID, Self, 'Копирование классов') then Exit;

 SaveNum := lDonorDocID;
 lDonorDocID := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(lDonorDocID);
 If lDonorDocID = -1 then raise Exception.CreateFmt(sidNoDocPresent,[SaveNum]);
 SaveNum := lAcceptorDocID;
 lAcceptorDocID := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(lAcceptorDocID);
 If lAcceptorDocID = -1 then raise Exception.CreateFmt(sidNoDocPresent,[SaveNum]);

 LinkServer(CurrentFamily).CopyLinks(atClasses, lnkDocIDFld, lDonorDocID, lAcceptorDocID);
end;

procedure TMainForm.ServerMessages(aCount: Integer; const aLastMsg: AnsiString);
begin
 if aCount > 1 then
  f_MsgTooltip := Format('"%s"'#13#10'(еще сообщений: %d)', [aLastMsg, aCount-1])
 else
  f_MsgTooltip := Format('"%s"', [aLastMsg]);
end;

procedure TMainForm.StatusBarDblClick(Sender: TObject);
var
 l_MsgDlg: TdlgTextMessages;
begin
 if ArchiRequestManager.TextMessages.Count > 0 then
 begin
  l_MsgDlg := TdlgTextMessages.Create(Self);
  try
   f_MsgTooltip := '';
   l_MsgDlg.Lister.Images := ilOffice;
   ArchiRequestManager.OnTextMessage := l_MsgDlg.IncomingMessages;
   l_MsgDlg.ShowModal;
  finally
   l3Free(l_MsgDlg);
   ArchiRequestManager.TextMessages.Clear;
   ArchiRequestManager.OnTextMessage := ServerMessages;
  end;
 end;
end;

procedure TMainForm.FlashTimerTimer(Sender: TObject);

 procedure ClearImg;
 begin
  with StatusBar.Panels[sbiMail].Glyph.Bitmap do
  begin
   Width := 0;
   Height := 0;
  end;
 end;

begin
 if Assigned(StatusBar) then
 begin
  if f_MsgTooltip <> '' then
  begin
   if StatusBar.Panels[sbiMail].Glyph.Bitmap.Empty then
    ilOffice.GetBitmap(2, StatusBar.Panels[sbiMail].Glyph.Bitmap)
   else
    ClearImg;
   StatusBar.Invalidate;
  end
  else
   if not StatusBar.Panels[sbiMail].Glyph.Bitmap.Empty then
   begin
    ClearImg;
    StatusBar.Invalidate;
   end;
 end;
end;

procedure TMainForm.ServerProgressProc(aState: Byte; aValue: Long; const aMsg : AnsiString = '');
begin
 try
  case aState of
   0: begin
       StatusBar.Panels[sbiGauge].Text := aMsg;
       StatusBar.Panels[sbiGauge].PanelType:= sptGauge;
       f_TotalServervalue:= aValue;
       StatusBar.Panels[sbiGauge].GaugeAttrs.Position := 0;
       StatusBar.Panels[sbiGauge].Text := aMsg;
      end;
   1: if aValue <> 0 then
       StatusBar.Panels[sbiGauge].GaugeAttrs.Position := MulDiv(aValue, 100, f_TotalServerValue);
   2: begin
       StatusBar.Panels[sbiGauge].PanelType:= sptNormal;
       StatusBar.Panels[sbiGauge].Text := '';
      end;
  end;
 except
  On E : Exception do
  begin
   l3System.Msg2Log('Ошибка в TMainForm.ServerProgressProc: aState= %d, f_TotalServerValue= %d, aValue= %d', [aState, f_TotalServerValue, aValue]);
   l3System.Exception2Log(E);
  end;
 end;
end;

procedure TMainForm.StatusBarPanels2HintText(StatusBar: TvtCustomStatusBar; Panel: TvtStatusPanel; var Hint: string);
begin
 Hint := f_MsgTooltip;
end;

procedure TMainForm.acSaveDocExtractsAsExecute(Sender: TObject);
begin
 if (FCurrentChild is TSearchWin) then
  TSearchWin(FCurrentChild).acSaveDocSetAs.Execute;
end;

procedure TMainForm.acDoAutoclassifyExecute(Sender: TObject);
begin
 if ArchiRequestManager.SendAutoclassifyTask then
  ShowMessage('Автоклассификация началась')
 else
  ShowMessage('Не удалось начать автоклассификацию');
end;

procedure TMainForm.acChangeLinkAddressExecute(Sender: TObject);
var
 l_OldDestDoc : TDocID;
 l_OldDestSub : TSubID;
 l_NewDestDoc : TDocID;
 l_NewDestSub : TSubID;
{ lSab : ISab;
 lDate : TstDate;
 lAction : TLogActionType;}

begin
 {lSab := MakeSab(GlobalHTServer.LogBook[CurrentFamily]);
 lDate := DMYtoStDate(13, 09, 2008);
 lSab.Select(lgDate_Key, lDate);
 lAction := acIncluded;
 lSab.SubSelect(lgAction_Key, lAction);
 ShowMessage(Format('Нашел %d', [lSab.Count]));

 lSab.DeleteFromTable;
 Exit;
}
 with TChangeHLAddrDlg.Create(Self) do
 try
  if ShowModal = mrOK then
  begin
   StrToDocAddr(edtAddrFrom.Text, l_OldDestDoc, l_OldDestSub);
   StrToDocAddr(edtAddrTo.Text, l_NewDestDoc, l_NewDestSub);

   with LinkServer(CurrentFamily).Renum do
   begin
    GetRNumber(l_OldDestDoc);
    GetRNumber(l_NewDestDoc);
   end;

   DocumentServer(CurrentFamily).ChangeHLAddr(l_OldDestDoc, l_OldDestSub, l_NewDestDoc, l_NewDestSub);
  end;
 finally
  Free;
 end;
end;

procedure TMainForm.acCorrectMissPrintsExecute(Sender: TObject);
begin
 if not CheckServer then
  Exit;
 if not ArchiRequestManager.SendSpellCorrecttask then
 begin
  ShowMessage('Не удалось отправить задачу на сервер.');
 end;
end;

procedure TMainForm.acShowDeferDeleletedItemsExecute(Sender: TObject);
begin
 RunDeferDeltemsWin;
end;

procedure TMainForm.HideSplashForm;
begin
 f_CForm.Free;
end;

procedure TMainForm.ShowSplashForm(aMode: Integer);
begin
 f_CForm := TClosingForm.Create(nil, aMode);
 f_CForm.Show;
 Application.ProcessMessages;
end;

procedure TMainForm.FindOnDateIntervalAndShow(const aQueryCaption : AnsiString; const aResultWinCaption : AnsiString;
    aGetQueryFunc : TarGetQueryFunc);
var
 l_Query : TdtQuery;
 lDate   : TStDate;
begin
 try
  with TSrchByActionDlg.Create(Self, aQueryCaption) do
  try
   if Execute then
   begin
    l_Query := nil;
    try
     if Assigned(aGetQueryFunc) then
     begin
      Screen.Cursor := crHourGlass;
      try
       l_Query := aGetQueryFunc(MakeDemonDateBounds(edtLowDate.StDate, edtHighDate.StDate));
       if l_Query = nil then
        raise EAssignError.Create('Не назначена Query (TMainForm.FindOnDateIntervalAndShow)');
       l_Query.DoQuery;
      finally
       Screen.Cursor := crDefault;
      end;

      if l_Query.FoundList.Count > 0 then
       with TSearchWin.Create(Self) do
       begin
        Family := CurrentFamily;
        DocList.Query := l_Query;
        SrchName := Format(aResultWinCaption, [MakeDateBoundsStr(edtLowDate.StDate, edtHighDate.StDate)]);
       end
      else
       vtMessageDlg(l3CStr(@sidNoSuchDoc));
     end;
    finally
     l3Free(l_Query);
    end;
   end;
  finally
   Free;
  end;
 finally
  l3FreeFA(Tl3FreeAction(aGetQueryFunc));
 end;
end;

procedure TMainForm.VersionDateChangedHandler(aNewDate, aNextDate: TDateTime);
begin
 if IniRec.NVDFromServer then
 begin
  IniRec.NextVersionDate := DateOf(aNewDate);
  IniRec.SecondVersionDate:= DateOf(aNextDate); 
 end;
end;

procedure TMainForm.acFindByDocLinkExecute(Sender: TObject);
var
 l_Q : TdtQuery;
begin
 with TSearchByDocLinkDlg.Create(nil) do
 try
  if ShowModal = mrOK then
  begin
   l_Q := TdtDocLinkQuery.Create(SearchType, LinkType);
   try
    if not l_Q.IsEmpty then
    with TSearchWin.Create(Self) do
    begin
     Family := CurrentFamily;
     DocList.Query := l_Q;
     case SearchType of
      stFindMasters: SrchName := 'Документы, изменяющие другие документы';
      stFindSlaves : SrchName := 'Документы, изменяемые другими документами';
     end;
    end
    else
     vtMessageDlg(l3CStr(@sidNoSuchDoc));
   finally
    l3Free(l_Q);
   end;
  end;
 finally
  Free;
 end;
end;

procedure TMainForm.ShowCorrespondentsForList(aSrchWin : TForm);
var
 l_Q : TdtCorrespQuery;
begin
 {TSearchWin}
 l_Q := TdtCorrespQuery.Create;
 try
  l_Q.SubQuery := (aSrchWin as TSearchWin).DocList.Query;
  if not l_Q.IsEmpty then
  with TSearchWin.Create(Self) do
  begin
   Family := CurrentFamily;
   DocList.Query := l_Q;
   SrchName := Format('Корреспонденты к "%s"', [aSrchWin.Caption]);
  end
  else
   vtMessageDlg(l3CStr(@sidNoSuchDoc));
 finally
  l3Free(l_Q);
 end;
end;

procedure TMainForm.ShowRespondentsForList(aSrchWin : TForm);
var
 l_Q : TdtRespQuery;
begin
 {TSearchWin}
 l_Q := TdtRespQuery.Create;
 try
  l_Q.SubQuery := (aSrchWin as TSearchWin).DocList.Query;
  if not l_Q.IsEmpty then
  with TSearchWin.Create(Self) do
  begin
   Family := CurrentFamily;
   DocList.Query := l_Q;
   SrchName := Format('Респонденты к "%s"', [aSrchWin.Caption]);
  end
  else
   vtMessageDlg(l3CStr(@sidNoSuchDoc));
 finally
  l3Free(l_Q);
 end;
end;

procedure TMainForm.acLoadDictModifyExecute(Sender: TObject);
var
 l_FileName : TFileName;
begin
  if RequestFileName(l_FileName, Self, 'Файл-обновление словаря', 'Укажите файл-обновление словаря','Обновление словаря(*.dm)|*.dm;Все файлы (*.*)|*.*') then
 begin
  gApplyDictModifyFile(l_FileName);
  vtMessageDlg(l3CStr('Словарь обновлен.'), mtInformation);
 end;
end;

procedure TMainForm.acFindNoCompareExecute(Sender: TObject);
var
 l_Q : TdtQuery;
 lValue : Integer;
begin
 lValue := dstatNoCompare;
 l_Q := TdtMainAttrQuery.Create(fStatus_Fld, lValue, True{IsMask});
 try
  if not l_Q.IsEmpty then
   with TSearchWin.Create(Self) do
   begin
    Family := CurrentFamily;
    DocList.Query := l_Q;
    SrchName := 'Документы, исключенные из сравнения редакций';
   end
  else
   vtMessageDlg(l3CStr(@sidNoSuchDoc));
 finally
  l3Free(l_Q);
 end;
end;

procedure TMainForm.CorrectLogoImage(aLogoForm: TLogoDlg);
begin
 ArchiRequestManager.CorrectLogoImage(aLogoForm.ImageForm.Picture);
end;

procedure TMainForm.acFindWillBeActiveExecute(Sender: TObject);
var
 l_Q   : TdtQuery;
begin
 l_Q := nil;
 try
  Screen.Cursor := crHourGlass;
  try
   l_Q := TdtWillBeActiveQuery.Create;
   l_Q.DoQuery;
  finally
   Screen.Cursor := crDefault;
  end;
  if not l_Q.IsEmpty then
  with TSearchWin.Create(Self) do
  begin
   Family := CurrentFamily;
   DocList.Query := l_Q;
   SrchName := 'Будут действовать';
  end
  else
   vtMessageDlg(l3CStr(@sidNoSuchDoc));
 finally
  FreeAndNil(l_Q);
 end;
end;

procedure TMainForm.acFindActBorderExecute(Sender: TObject);

 function lGetQueryFunc(aDateBounds : Tl3DateBounds): TdtQuery;
 begin
  with aDateBounds do
   Result := TdtActiveBorderQuery.Create(Low, High);
 end;

begin
 FindOnDateIntervalAndShow('Поиск по границе диапазона действия',
                           'Диапазон действия %s',
                           TarGetQueryFunc(l3LocalStub(@lGetQueryFunc)));
end;

procedure TMainForm.acFindByCloneInPubInExecute(Sender: TObject);
var
 l_Q : TdtQuery;
begin
 l_Q := TdtPubInFlagsQuery.Create(pinfClone);
 try
  if not l_Q.IsEmpty then
   with TSearchWin.Create(Self) do
   begin
    Family := CurrentFamily;
    DocList.Query := l_Q;
    SrchName := 'Документы с пометкой "клон" в источниках опубликования';
   end
  else
   vtMessageDlg(l3CStr(@sidNoSuchDoc));
 finally
  l3Free(l_Q);
 end;
end;

procedure TMainForm.actAACImportExecute(Sender: TObject);
begin
 if not CheckServer then
  Exit;
 if not CreateImportTask(ar_ikAAC, False) then
 begin
  ShowMessage('Не удалось отправить задачу на сервер.');
 end;
end;

procedure TMainForm.AnouncedDateChangedHandler(aNewDate: TDateTime);
begin
 IniRec.AnouncedDate := aNewDate;
end;

procedure TMainForm.miChangeDocReportClick(Sender: TObject);
var
 //lCurDocID : TDocID;
 lTextStream : Tl3TextStream;
 lTextFiler  : Tl3CustomFiler;

 type
  PRec = ^TRec;
  TRec = record
   rDocID  : TDocID;
   rAction : TLogActionType;
  end;

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 begin
  Result := True;
  with lTextFiler, PRec(aItemPtr)^ do
  begin
   Write(IntToStr(rDocID));
   Write(';');
   WriteLN(GetLogJrnlName(rAction));
  end;
 end;

var
 lValueFiller : IValueSetFiller;
 lJoinSab : IJoinSab;
 lRenum : ISab;
 lSab : ISab;
 lSabF : ISab;
 lSabLog : ISab;
 lStartDate, lEndDate : TStDate;
 lFileName : TFileName;

 lAction : TLogActionType;
 lRAProcStub : TdtRecAccessProc;
 lCnt : Integer;
 lBasesDictID : TDictID;
begin
 if not GetLogRequestData(lStartDate, lEndDate,  lFileName) then
  Exit;


 try
  Screen.Cursor:=crHourGlass;
  //лог-записи по заказанным типам
  lSabLog := MakeSab(LinkServer(CurrentFamily)[atLogRecords]);

  lValueFiller := lSabLog.MakeValueSetFiller(lgAction_Key, lSab);
  try
   with lValueFiller do
   begin
    lAction := acAttrWork;
    AddValue(lAction);
    lAction := acTextWork;
    AddValue(lAction);
    lAction := acHLWork;
    AddValue(lAction);
    lAction := acKWWork;
    AddValue(lAction);
    lAction := acClassWork;
    AddValue(lAction);
    lAction := acPublInWork;
    AddValue(lAction);
   end;
  finally
   lValueFiller := nil;
  end;

  lSabLog.RecordsByKey;

  //фильтр по диапазону дат (lStartDate, lEndDate)
  //lStartDate := l3Date.DMYtoStDate(9, 6, 2010);
  //lEndDate := l3Date.DMYtoStDate(16, 6, 2010);
  lSabLog.SubSelect(lgDate_Key, lStartDate, lEndDate);

  // получили DocID для Belongs = ENG
  lBasesDictID := 15;
  lSab := MakeSab(LinkServer(CurrentFamily)[atBases]);
  lSab.Select(lnkDictIDFld, lBasesDictID);
  lSab.ValuesOfKey(lnkDocIDFld);

  // трансфер в Log
  lSab.TransferToPhoto(lgDocID_Key, LinkServer(CurrentFamily)[atLogRecords]);

  // Записей тут миллионы, lSab.RecordsByKey работает медленно, поэтому сфильтруем сразу на найденные в lSabLog
  lSabF := MakeSabCopy(lSabLog);
  lSabF.ValuesOfKey(lgDocID_Key);
  lSab.AndSab(lSabF);

  lSab.RecordsByKey;

  // фильтрация по acIncluded
  lAction := acIncluded;
  lSab.SubSelect(lgAction_Key, lAction);
  if lSab.IsEmpty then Exit;

  lSab.ValuesOfKey(lgDocID_Key);
  lSab.RecordsByKey;

  lSabLog.AndSab(lSab);

  lSabLog.Distinct([lgDocID_Key, lgAction_Key]);

  lRenum := MakeSab(LinkServer(CurrentFamily).Renum);
  lRenum.SelectAll;

  lJoinSab := MakeJoinSab(lSabLog, lgDocID_Key,
                          lRenum,  rnRealID_fld);

  lJoinSab.SortJoin([JFRec(lRenum.Table,  rnImportID_fld),
                     JFRec(lSabLog.Table, lgAction_Key)]);



  //if vtExecuteSaveDialog(l_FileName, sidLSTDlgFilter) then
  //begin
  //lFileName := 'd:\eng.out';
  lTextStream := Tl3TextStream.Create(lFileName, l3_fmWrite);
  try
   lTextFiler := Tl3CustomFiler.Create;
   lTextFiler.Stream := lTextStream;
   try
    lRAProcStub := L2RecAccessProc(@lRecAccessProc);
    try
     lJoinSab.IterateJoinRecords(lRAProcStub, [JFRec(lRenum.Table,  rnImportID_fld),
                                               JFRec(lSabLog.Table, lgAction_Key)]);
    finally
     FreeRecAccessProc(lRAProcStub);
    end;
   finally
   l3Free(lTextFiler);
  end;
  finally
   l3Free(lTextStream);
  end;
 finally
  Screen.Cursor:=crDefault;
 end;
end;

procedure TMainForm.OpenDocByNumber(aDocID, aSubID: TDocID;
  aRenum: Boolean);
var
 l_SaveNum : TDocID;
 l_RelFlag : Boolean;
 l_DocAddr : TDocPointAddr;
//{*}lTimer : Cardinal;
begin
 //{*}dbgAppendToLogLN('*');
 //{*}lTimer := dbgStartTimeCounter;
 l_SaveNum := aDocID;
 try
  if aRenum then
   aDocID := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(aDocID);
   //{*} dbgAppendToLogLN(format('TMainForm.OpenDocByNumber  ConvertToRealNumber %s',[dbgFinishTimeCounter(lTimer)]));

  if not IsValidDocID(aDocID) then raise Exception.CreateFmt(sidNoDocPresent, [l_SaveNum]);
  //{*} dbgAppendToLogLN(format('TMainForm.OpenDocByNumber  IsValidDocID %s',[dbgFinishTimeCounter(lTimer)]));

  if not DocumentServer(CurrentFamily).CheckDoc(aDocID, True, l_RelFlag) then
   raise Exception.CreateFmt(sidNoDocPresent,[aDocID]);
  //{*} dbgAppendToLogLN(format('TMainForm.OpenDocByNumber  CheckDoc %s',[dbgFinishTimeCounter(lTimer)]));

  l_DocAddr := MakeDocPointAddr(CurrentFamily, aDocID, aSubID);
  RunTextEditor(CurrentFamily, aDocID, False {ROnly}, MakeDocJumpData(djSub, l_DocAddr, True));
 except
  on E: EHtErrors do
  begin
   l3System.Exception2Log(E);
 {$IFDEF InsiderTest}
  raise Exception.CreateFmt(sidDocLoadFault, [l_SaveNum, E.Message]);
 {$ELSE}
   vtMessageDlg(l3Fmt(sidDocLoadFault, [l_SaveNum, E.Message]), mtError);
 {$ENDIF InsiderTest}
  end;
  on E : Exception do
 {$IFDEF InsiderTest}
  raise Exception.CreateFmt(sidDocLoadFault, [l_SaveNum, E.Message]);
 {$ELSE}
   vtMessageDlg(l3Fmt(sidDocLoadFault, [l_SaveNum, E.Message]), mtError);
 {$ENDIF InsiderTest}
 end;
//{*} dbgAppendToLogLN(format('TMainForm.OpenDocByNumber %s',[dbgFinishTimeCounter(lTimer)]));
end;

procedure TMainForm.CreateNewDocumentFromFile(const aParams: TNewDocParams);
var
 l_EdWin: TCustomEditorWindow;
begin
 {$IFDEF InsiderTest}
 acShowSpecSymbol.Checked := False;
 acShowDocumentParts.Checked := False;
 acWebStyle.Checked := False;
 {$ENDIF InsiderTest}
 with aParams do
  case rDocKind of
   dkText,
   dkObject,
   dkFlash :
   begin
    l_EdWin := TDocEditorWindow.Create(Self);
    try
     try
      l_EdWin.DocFamily := CurrentFamily;
      Application.ProcessMessages;
      TDocEditorWindow(l_EdWin).LoadNewDoc(rDocType, rAnalyseFile, rAnalyseLog, rDocAddr, rDocName);
      l_EdWin.Lock;
     except
      l_EdWin.SilentClose;
      raise;
     end;
    except
     on E : EOSError do
      if E.ErrorCode = ERROR_SHARING_VIOLATION then
       Application.ShowException(E)
      else
       raise;
    end;
   end;
   dkDictEntry :
    begin
     l_EdWin := TDictEntryWindow.Create(Self);
     try
      try
       l_EdWin.DocFamily := CurrentFamily;
       Application.ProcessMessages;
       TDictEntryWindow(l_EdWin).LoadDocEx(True);
       l_EdWin.Lock;
      except
       l_EdWin.SilentClose;
       raise;
      end;
     except
      on E : EOSError do
       if E.ErrorCode = ERROR_SHARING_VIOLATION then
        Application.ShowException(E)
       else
        raise;
     end;
   end;
  end; // case l_Params.rDocKind of
end;

procedure TMainForm.WMEndSession(var Message: TWMEndSession);
begin
 //if Message.EndSession then
 begin
  SilentClose:= True;
  Close;
 end;
end;

procedure TMainForm.WMQueryEndSession(var Message: TWMQueryEndSession);
begin
 SilentClose:= True;
 Message.Result:= 1;
end;

procedure TMainForm.WMPowerBroadcast(var Message: TMessage);
begin
 if Message.WParam = PBT_APMSUSPEND then
 begin
  SetThreadExecutionState(ES_CONTINUOUS or ES_SYSTEM_REQUIRED);
  try
   SilentClose := True;
   Close;
  finally
   SetThreadExecutionState(ES_CONTINUOUS);
  end;
 end;
end;

procedure TMainForm.miUncorrectRELClick(Sender: TObject);
var
 lSab       : ISAB;
 lValue     : Integer;
 l_FileName : TFileName;
begin
 lSab := MakeAllRecords(DocumentServer(CurrentFamily).FileTbl);
 lSab.SelectAll;
 lSab.ValuesOfKey(fId_Fld);

 lSab.TransferToPhoto(rnRealID_fld, LinkServer(CurrentFamily).Renum);
 lSab.ValuesOfKey(rnImportID_fld);

 if RequestFileName(l_FileName, Self, 'Сохранить как', 'Укажите файл - список номеров') then
  OutValueSab2File(lSab, l_FileName);
end;

(* orig
procedure TMainForm.miUncorrectRELClick(Sender: TObject);
var
 lSab       : ISAB;
 lValue     : Integer;
 l_FileName : TFileName;
begin
 lSab := MakeAllRecords(DocumentServer(CurrentFamily).FileTbl);
 lSab.SelectAll;
 lSab.ValuesOfKey(fRelated_fld);
 lSab.TransferToPhoto(fId_Fld);
 lSab.RecordsByKey;
 lSab.ValuesOfKey(fId_Fld);

 //--  дальше вычисление "документы у которых справки-документы"
 //lSab.TransferToPhoto(fRelated_fld);
 //lSab.RecordsByKey;
 //lSab.ValuesOfKey(fId_Fld);

 if RequestFileName(l_FileName, Self, 'Сохранить как', 'Укажите файл - список номеров') then
  OutSab2File(lSab, l_FileName);
end;
*)
procedure TMainForm.DoOnServerStatusChanged(aIsOnline: Boolean);
var
 I: Integer;
 l_Num: Integer;
begin
 miServerMenu.Enabled := aIsOnline;
 miTaskQueryStatus.Enabled := aIsOnline;
 acDocImport.Enabled := aIsOnline;
 acAnnoImportFromRTF.Enabled := aIsOnline;
 actAACImport.Enabled := aIsOnline;
 acDeliveryProfile.Enabled := aIsOnline;
// acCorrectMissPrints.Enabled := aIsOnline;

 acCorrectMissPrints.Enabled := False;
 acCorrectMissPrints.Visible := False;

 if aIsOnline then
 begin
  ArchiRequestManager.FillServerMenu(miServerMenu);
  ilOffice.GetBitmap(imiServerOn, StatusBar.Panels[sbiServerStatus].Glyph.Bitmap);
  StatusBar.Panels[sbiServerStatus].Hint := 'Сервер доступен';
  l3System.Msg2Log('СВЯЗЬ ВОССТАНОВЛЕНА');
 end
 else
 begin
  ilOffice.GetBitmap(imiServerOff, StatusBar.Panels[sbiServerStatus].Glyph.Bitmap);
  StatusBar.Panels[sbiServerStatus].Hint := 'Сервер недоступен';
  l3System.Msg2Log('СВЯЗЬ ОБОРВАНА');
 end;
 StatusBar.Invalidate;
 l_Num := MDIChildCount;
 for I := 0 to l_Num - 1 do
  SendMessage(MDIChildren[I].Handle, WM_SERVERSTATUSCHANGED, 0, 0);
end;

procedure TMainForm.DoGetBlockIndex(Sender      : TObject;
                                    const aSub  : IevDocumentPart;
                                    var anIndex : TImageIndex);
begin
 if (anIndex = picAnchorBlock) then // K507413204
  case aSub.GetViewKind of
   ev_bvkLeft: anIndex := picLeftBlock;
   ev_bvkRight: anIndex := picRightBlock;
   else
    anIndex := picAnchorBlock;
  end;
end;

function TMainForm.CheckServer(aQuietly: Boolean = False): Boolean;
begin
 ArchiRequestManager.KeepAlive(True);
 Result := ArchiRequestManager.ServerOnline;
 if (not Result) and (not aQuietly) then
  vtMessageDlg(l3CStr('Сервер недоступен'), mtError);
end;

procedure TMainForm.miTestDebugClick(Sender: TObject);
var
 l_IDList: ISab;
 l_Q   : TdtQuery;
 l_Date: TDateTime;
begin
 l_Date := StrToDate('16.08.2013');
 Screen.Cursor := crHourGlass;
 try
  l_IDList := FindRelated(l_Date, l_Date, 65);
 finally
  Screen.Cursor := crDefault;
 end;

 l_Q := TdtIDListQuery.CreateFrom(l_IDList);
 try
  if not l_Q.IsEmpty then
  with TSearchWin.Create(Self) do
  begin
   Family := CurrentFamily;
   DocList.Query := l_Q;
   SrchName := 'Отладка';
  end
  else
   vtMessageDlg(l3CStr(@sidNoSuchDoc));
 finally
  FreeAndNil(l_Q);
 end;

{
  Screen.Cursor := crHourGlass;
  try
   l_Q := TdtWillBeActiveQuery.Create;
   l_Q.DoQuery;
  finally
   Screen.Cursor := crDefault;
  end;
  if not l_Q.IsEmpty then
  with TSearchWin.Create(Self) do
  begin
   Family := CurrentFamily;
   DocList.Query := l_Q;
   SrchName := 'Будут действовать';
  end
  else
   vtMessageDlg(l3CStr(@sidNoSuchDoc));
 finally
  FreeAndNil(l_Q);
 end;
 }
end;

{$IFDEF InsiderTest}
procedure TMainForm.ClearHistory;
begin
 DocStackList.Clear;
 DocStackCurrentChange(-1);
end;
{$ENDIF InsiderTest}


procedure TMainForm.DoCorrectExportFolder(var aFolder: AnsiString;
  var aResult: Boolean);
var
 l_Dialog: TTCorrectExportFolder;
begin
 l_Dialog := TTCorrectExportFolder.Create(nil);
 try
  aResult := l_Dialog.Execute(aFolder);
 finally
  FreeAndNil(l_Dialog);
 end;
end;

function TMainForm.DoLongProcessNotify(aState: TdaProcessState): Boolean;
begin
 Case aState of
  da_psStart   : begin
               Result := False;
               If fHTLongProcessMsg <> nil then Exit;
               fHTLongProcessMsg := vtShowCurtainMessage(l3CStr('ПОТЕРПИТЕ!'^M'Длительная операция.'), mtInformation, [mbCancel]);
               //Application.ProcessMessages;
              end;

  da_psCurrent : begin
               Result := False; //True;
               Application.ProcessMessages;
               If fHTLongProcessMsg <> nil
                then Result := vtGetCurtainMessageModalResult(fHTLongProcessMsg) <> mrNone;
              end;

  da_psEnd     : begin
               Result := False;
               vtCloseCurtainMessage(fHTLongProcessMsg);
               fHTLongProcessMsg := nil;
              end;
 end;
end;

procedure TMainForm.Change;
begin
 if (fCurrentChild <> nil) and fCurrentChild.HandleAllocated then
  PostMessage(fCurrentChild.Handle, wm_WinClipChange, 0, 0);
end;

procedure TMainForm.CheckCurrChild(aForm: TForm);
begin
 if fCurrentChild = aForm then
  fCurrentChild := nil;
end;

procedure TMainForm.acDeliveryProfileExecute(Sender: TObject);
var
 l_Task: TcsDeliveryProfileTask;
 l_Dlg: TDeliveryProvileDlg;
begin
 l_Dlg := TDeliveryProvileDlg.Create(nil);
 try
  if l_Dlg.Execute then
  begin
   l_Task := TcsDeliveryProfileTask.Create(g_BaseEngine.DataProvider.UserID);
   try
    l_Task.SourceFolder := l_Dlg.SourceFolder;
    l_Task.TargetFolder := l_Dlg.TargetFolder;
    ArchiRequestManager.SendTask(l_Task);
   finally
    FreeAndNil(l_Task);
   end;
  end;
 finally
  FreeAndNil(l_Dlg);
 end;
end;

end.
