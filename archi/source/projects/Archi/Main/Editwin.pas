unit Editwin;

{ $Id: Editwin.pas,v 1.175 2015/10/06 13:54:29 voba Exp $ }

{$I arDefine.inc}

{$Define DEBUGOUT2}

interface

uses
 SysUtils,
 Windows,
 TypeShop,
 Messages,
 Classes,
 Graphics,
 Printers,
 Controls,
 ImgList,
 vtForm, VConst,
 Menus, ActnList, Forms, Dialogs, StdCtrls, ExtCtrls, Buttons,
 OvcBase, OvcData, OvcDT, OvcNbk,
 OvcEF, OvcTCDT, OvcTable,
 OvcTCGly, OvcTCBmp, OvcTCBox, OvcTCHdr, OvcTCEdt, OvcTCmmn, OvcTCell, OvcTCStr,
 l3Date, l3DateSt, StDateSt,
 evTableConverter,
 F_AttrExplorer, F_TextEditor, F_ImageView,
 Main, {D_EdMkTb,} D_EdMSub, {D_KeyW,}
 HT_Const,
 DT_Const, DT_Types, DT_Err, DT_Jour, DT_Serv, Dt_Doc, DT_Link,
 D_TxSrch_Intf, D_TxSrch_Types,
 DT_Dict, {DT_DTree,} {DT_Lock,} DT_Log, DT_Hyper, DT_Stage, DT_User,
 Com_Cnst,
 l3Base, l3DatLst, DragData,
 vtLister, vtOutliner, Mask, {ToolEdit,} Tabs,
 vtMenus,
 vtCombo, vtDateEdit,
 RXCtrls, vtCtrls, AdvMenus, W95Meter, vtSpin,
 evConst, evTypes, evdStyles, evRuler, evTextSource,
 evMemo, evCustomEditor, evEditor, evEditorWindow,
 evSubPn, l3Filer,
 evSearch,
 evIntf, evTextFormatter, k2TagGen,
 k2Interfaces, k2Tags,
 evMenu,  l3Units,
 DocAttrIntf, DocAttrToolsIntf,
 DocIntf, l3Types, evToolPanel, evLinkedToolPanel,
 l3Tree, l3Nodes, l3Interfaces, l3TreeInterfaces, l3Tree_TLB,
 dt_AttrSchema, //DictsSup,
 k2Reader, evdWriter, evEvdRd, evTxtRd,
 evInternalInterfaces,
 evEditorInterfaces, evEditorInterfacesMisc, l3InternalInterfaces,
 l3ProgressComponent, l3InterfacedComponent,
 m3DBInterfaces,
 //m4FoundSelector,
 k2StackGenerator, D_Undo, evMultiSelectEditorWindow,
 ComCtrls, vtStatusBar,
 CustEditWin, ieview, imageenview,
 evEditorWithOperations, afwControl,
 afwInterfaces, afwInputControl,
 vtComboTree, evEdit, nevTools,
 l3LongintList, evCustomEdit, evCustomTextSource,
 evCustomMemo, ElXPThemedControl1, 
 AbstractDropDown, DropDownTree,
 vtShockwaveEx,
 evCommonTypes, evdTypes, arCommonTypes,
 elCustomEdit, elCustomButtonEdit, ctAbstractEdit, ctButtonEdit,
  EditableBox, FakeBox, afwControlPrim, afwBaseControl, nevControl,
  evdInterfaces,
  F_MiscDocImgView,

 nevBase,
 nevGUIInterfaces,
 nevNavigation,

 arDocumentContainerWithContentsTree,

 afwNavigation, evCustomEditorWindowModelPart, evCustomEditorWindowPrim,
  evCustomEditorModelPart, l3WinControlCanvas, evCustomEditorWindow,
  OvcTCCBx;                             

const
 piName     = 0;
 piAttr     = 1;
 piText     = 2;
 piPicture  = 3;
 piSprv     = 4;
 piAnno     = 5;
 piClass    = 6;
 piSrcImage = 7;
 piSub      = 8;
 piResp     = 9;
 piCoresp   = 10;
 piVersion  = 11;
 piJourn    = 12;
 piMax      = piJourn;

type
  TGroupData  = Record
                 FullName      : AnsiString;
                 //ShortName     : AnsiString;
                 ActDate       : TStDate;   ActDateSetted  : Boolean;
                 ExpDate       : TStDate;   ExpDateSetted  : Boolean;
                 Status        : Integer;   StatusSetted   : Integer;
                 UserType      : TUserType; UserTypeSetted : Boolean;
                 rPriority     : Word
                end;

  TPageLoadArray  = Array[0..piMax] of Boolean;

  TValue = record
            case byte of
             0 : (AsString : ShortString);
             1 : (AsDate   : Longint);
             2 : (AsCBS    : TCheckBoxState);
             3 : (AsComboBoxData : TCellComboBoxInfo);
           end;

  TDocEditorWindow = class(TCustomEditorWindow, ISearchDlgOperations)
   acAutoComplete            : TAction;
   acCLDelete                : TAction;
   acDelAllBlocks            : TAction;
   acDelSub                  : TAction;
   acFindGeneralRepeatSearch : TAction;
   acFindGeneralReplace      : TAction;
   acFindGeneralSearch       : TAction;
   acFindInFragment          : TAction;
   acGetCorespondentsForBlock: TAction;
   acInsCreateStructure      : TAction;
   acInsPageBreak            : TAction;
   acInsSection              : TAction;
   acInsSignature            : TAction;
   acJurCommentStyleSearch   : TAction;
   acLinkDelete              : TAction;
    acLinkFollow: TAction;
   acLinkSet                 : TAction;
   acLinkSetManually         : TAction;
   acPageAttr                : TAction;
   acPageClass               : TAction;
   acPageCoresp              : TAction;
   acPageJourn               : TAction;
   acPageJurJournal          : TAction;
   acPageName                : TAction;
   acPagePublished           : TAction;
   acPageResp                : TAction;
   acPageSprv                : TAction;
   acPageStage               : TAction;
   acPageAnno                : TAction;
   acPageText                : TAction;
   acPageVersions            : TAction;
   acPMAnnoSetClass          : TAction;
   acPMAttrDelete            : TAction;
   acPMAttrEdit              : TAction;
   acPMAttrSave              : TAction;
   acPMAttrShowOwners        : TAction;
   acPMBTreeDelete           : TAction;
   acPMCorrDelete            : TAction;
   acPMJournalDelete         : TAction;
   acPMMainSplitWindow       : TAction;
   acPMMainSwapPanels        : TAction;
   acPMPicStretch            : TAction;
   acPMSectionA1             : TAction;
   acPMSectionA2             : TAction;
   acPMSectionA3             : TAction;
   acPMSectionA4             : TAction;
   acPMSectionLandscape      : TAction;
   acPMSectionPortrait       : TAction;
   acPMSubAncorDelete        : TAction;
   acPMSubAncorEdit          : TAction;
   acPMSubAncorLinkExtObject : TAction;
   acPMSubAncorSave          : TAction;
   acPMSubAncorSetClass      : TAction;
   acPMSubAncorSetKey        : TAction;
   acPMSubAncorSetPrefix     : TAction;
   acPMSubAncorSetTOC        : TAction;
   acPMSubAncorSetType       : TAction;
   acPMSubAncorSync          : TAction;
   acPMSubDelete             : TAction;
   acPMSubEditName           : TAction;
   acPMSubPanelAutoClasses   : TAction;
   acPMSubPanelClasses       : TAction;
   acPMSubPanelExtObjects    : TAction;
   acPMSubPanelKeys          : TAction;
   acPMSubPanelLabelNum      : TAction;
   acPMSubPanelNameType      : TAction;
   acPMSubPanelTOC           : TAction;
   acPMSubPanelTypes         : TAction;
   acPMTextDocInfo           : TAction;
   acPMTextFindInterpretation: TAction;
   acPMTextInsertText        : TAction;
   acPMTextJumpToPara        : TAction;
   acPMTextJumpToSub         : TAction;
   acPMTextSetClass          : TAction;
   acPMTextSetKey            : TAction;
   acPMTextSetPrefix         : TAction;
   acPMTextSetType           : TAction;
   acPrevVersion             : TAction;
   acPrevVersion1            : TMenuItem;
   acRefReplace              : TAction;
   acRefSearch               : TAction;
   acReplaceHRefDocForBlockCorrespondents: TAction;
   acSetBlock                : TAction;
   acSetFullEditionStage     : TAction;
   acSetIncludedStage        : TAction;
   acSetReferenceBegin       : TAction;
   acSetReferenceEnd         : TAction;
   acSetSharpReference       : TAction;
   acSetSub                  : TAction;
   acStyleArticleHeader      : TAction;
   acStyleColorSegment: TAction;
   acStyleComment: TAction;
   acStyleExpired: TAction;
   acStyleHeader1: TAction;
   acStyleLeftAdjusted: TAction;
   acStyleLinkContinue: TAction;
   acStyleMonospace: TAction;
   acStyleNoEffectYet: TAction;
   acStyleNormal: TAction;
   acStyleNormalOEM: TAction;
   acStyleVersionInfo: TAction;
   acSubNameCorrect: TAction;
   acTblAdjustCellsBoundaries: TAction;
   acTblAdjustNumberCell: TAction;
   acTblBoundaries: TAction;
   acTblFromText: TAction;
   acTblSetCellWidth: TAction;
   acTextCopy: TAction;
   acTextCut: TAction;
   acTextMarkAsNonPrintable: TAction;
   acTextMarkAsPrintable: TAction;
   acTextPaste: TAction;
   acTextPasteFromFile: TAction;
   acTextReplace: TAction;
   acTextSave: TAction;
   acTextSaveAs: TAction;
   acTextSearch: TAction;
   acTextSelectAll: TAction;
   ActionList1: TActionList;
   acToolsAnalyseHeader: TAction;
   acToolsAnnounce: TAction;
   acToolsCnvANSI2OEM: TAction;
   acToolsCnvDate2Text: TAction;
   acToolsCnvEngCharset: TAction;
   acToolsCnvInvertCase: TAction;
   acToolsCnvLowerCase: TAction;
   acToolsCnvMergePara: TAction;
   acToolsCnvOEM2ANSI: TAction;
   acToolsCnvRusCharset: TAction;
   acToolsCnvUpperCase: TAction;
   acToolsDeleteAnno: TAction;
   acToolsDeleteReference: TAction;
   acToolsDocExpired: TAction;
   acToolsFindTNVED: TAction;
   acToolsLinkAnno: TAction;
   acToolsMakeOldEdition: TAction;
   acToolsMakeOtherEdition: TAction;
   acToolsOpenAllEditions: TAction;
   acToolsRegistrationDeclined: TAction;
   acToolsSubmitJurChanges: TAction;
   acToolsUncontrol: TAction;
   acVersionInfoStyleSearch: TAction;

   AnnoPopUpMenu: TLinkPopUpMenu;
   AnnoTextEditor: TTextEditorWin;
   ANSI2OEM                : TMenuItem;
   Cancel                  : TBitBtn;
   cbClassSubs             : TvtComboTree;
   cbCorSources            : TComboBox;
   cbUserType              : TComboBox;
   cbxChargeFree           : TCheckBox;
   cbxHasAnno              : TCheckBox;
   cbxIncDone              : TCheckBox;
   cbxNotTM                : TCheckBox;
   cbxPriorityType         : TCheckBox;
   ChildDocFooter          : TvtStatusBar;
   ChildDocOutliner        : TvtOutliner;
   chStage                 : TOvcTCColHead;
   ClassAnchorImage        : TImage;
   ClassSubsPanel          : TPanel;
   ClipbrdPopUpMenu        : TLinkPopUpMenu;
   DocTextEditor           : TTextEditorWin;
   edtAnnoName             : TevEdit;
   edtDocID                : TvtSpinEdit;
   edtObjectFilePath: TVEdit;
   edtPriorityID           : TvtSpinEdit;
   edtSprDocID             : TvtSpinEdit;
   ExpDatePanel            : TPanel;
   FullNameMEdit           : TevMemo;
   Help                    : TBitBtn;
   ieView: TImageEnView;
   Label1                  : TLabel;
   Label2                  : TLabel;
   Label4                  : TLabel;
   Label6                  : TLabel;
   Label8                  : TLabel;
   lblInternalID           : TLabel;
    lstVersion: TvtIStrListLister;
   MainAttrExplorer        : TAttrExplorer;
   MainPopupMenu           : TPopupMenu;
   MenuItem12              : TMenuItem;
   MenuItem4: TMenuItem;
   mi_RemoveReference      : TMenuItem;
   mi_RemoveSub            : TMenuItem;
   mi_SetSub               : TMenuItem;
   miA1: TMenuItem;
   miA2: TMenuItem;
   miA3: TMenuItem;
   miA4: TMenuItem;
   miAddToClipboard        : TevMenuItem;
   miAnaliseParam          : TMenuItem;
   miCellsMerge: TMenuItem;
   miCellSplit: TMenuItem;
   miCopy                  : TMenuItem;
   miCreateStructure: TMenuItem;
   miCut                   : TMenuItem;
   miDate2Text             : TMenuItem;
   miDelAllBlocks: TMenuItem;
   miDelAnno: TMenuItem;
   miDelCorrepItem: TMenuItem;
   miDelDocClass           : TMenuItem;
   miDeleteCell: TMenuItem;
   miDeleteTable: TMenuItem;
   miDelJournalRec: TMenuItem;
   miDelSpravka: TMenuItem;
   miDelSubItem            : TMenuItem;
   miDocInfo               : TMenuItem;
   miEditClassTree         : TMenuItem;
   miEngReg                : TMenuItem;
   miFind                  : TMenuItem;
   miFindTNVED             : TMenuItem;
   miGoByRef: TMenuItem;
   miGotoNextOccur: TMenuItem;
   miHSplitWindow          : TMenuItem;
   miHyperText             : TMenuItem;
   miInsertClassToObjList  : TMenuItem;
   miInsertDictText        : TMenuItem;
   miInsertMenu: TMenuItem;
   miInsertSbSPara         : TMenuItem;
   miInvReg                : TMenuItem;
   miJumpByPara: TMenuItem;
   miJumpToSub: TMenuItem;
   miJustCenter            : TevMenuItem;
   miJustLeft              : TevMenuItem;
   miJustRight             : TevMenuItem;
   miJustWide              : TevMenuItem;
   miLandscape: TMenuItem;
   miLowReg                : TMenuItem;
   miMergeCellsHorz: TMenuItem;
   miMergeCellsVert: TMenuItem;
   miOEM2ANSI              : TMenuItem;
   miOpenAllRevisions: TMenuItem;
   miPageBreak: TMenuItem;
   miParaMerge             : TMenuItem;
   miParseSelectTextAndSearch: TMenuItem;
   miPaste                 : TMenuItem;
   miPasteFromFile: TMenuItem;
   miPasteSpecial          : TevMenuItem;
   miPortrait: TMenuItem;
   miRedo                  : TevMenuItem;
   miReplace               : TMenuItem;
   miRusReg                : TMenuItem;
   miSave                  : TMenuItem;
   miSaveAs                : TMenuItem;
   miSearch                : TMenuItem;
   miSection: TMenuItem;
   miSelectAll             : TMenuItem;
   miService               : TMenuItem;
   miSetAnnoClass: TMenuItem;
   miSetAnnoDate: TMenuItem;
   miSetAnonced: TMenuItem;
   miSetBlock              : TMenuItem;
   miSetCellWidth: TMenuItem;
   miSetClass              : TMenuItem;
   miSetClassOnSub         : TMenuItem;
   miSetKeyType            : TMenuItem;
   miSetKeyWord            : TMenuItem;
   miSetKWOnSub            : TMenuItem;
   miSetMOJNotReg: TMenuItem;
   miSetPrefix             : TMenuItem;
   miSetPrefixOnSub        : TMenuItem;
   miSetReference          : TMenuItem;
   miSetReferenceDirect: TMenuItem;
   miSetSub: TMenuItem;
   miSetTextInvisible      : TMenuItem;
   miSetTextVisible        : TMenuItem;
   miSetTypeOnSub          : TMenuItem;
   miSetVChanged           : TMenuItem;
   miSetVLControl          : TMenuItem;
   miSplit21: TMenuItem;
   miSplitLine1            : TMenuItem;
   miSplitLine3            : TMenuItem;
   miSrchAgain             : TMenuItem;
   miStretchPicture        : TMenuItem;
   miStyle: TMenuItem;
   miSubNameCorrect: TMenuItem;
   miSubNameEdit           : TMenuItem;
   miSubSinchronize        : TMenuItem;
   miSwapPanel             : TMenuItem;
   miTable                 : TMenuItem;
   miTblAjustCellBorder: TMenuItem;
   miTblAjustColumnWidth: TMenuItem;
   miTblBorder: TMenuItem;
   miTblCreate: TMenuItem;
   miTblDelCol             : TMenuItem;
   miTblDelStr             : TMenuItem;
   miTblFromText           : TMenuItem;
   miTblInsCol             : TMenuItem;
   miTblInsStr: TMenuItem;
   miTblMergeTables: TMenuItem;
   miTblSplitTable: TMenuItem;
   miText                  : TMenuItem;
   miTranformText          : TMenuItem;
   miUndo                  : TevMenuItem;
   miUpReg                 : TMenuItem;
   miUrOpMakeFullEdition: TMenuItem;
   miUrOpMakeOldEdition: TMenuItem;
   miUrOpSetAbolished      : TMenuItem;
   miUserColorSegment: TMenuItem;
   miUserMonoWidth: TMenuItem;
   miUserStyle0: TMenuItem;
   miUserStyle10: TMenuItem;
   miUserStyle11: TMenuItem;
   miUserStyle3: TMenuItem;
   miUserStyle4: TMenuItem;
   miUserStyle5: TMenuItem;
   miUserStyle6: TMenuItem;
   miUserStyle7: TMenuItem;
   miUserStyle8: TMenuItem;
   miUserStyle9: TMenuItem;
   N8: TMenuItem;
   ModalButtonPanel        : TPanel;
   nbkDocPages: TOvcNotebook;
   nbkJournals             : TOvcNotebook;
   OK                      : TBitBtn;
   otlBlocks               : TvtOutliner;
   Panel1                  : TPanel;
   Panel2                  : TPanel;
   Panel3                  : TPanel;
   Panel7                  : TPanel;
   ParentDocFooter: TvtStatusBar;
   ParentDocList           : TvtLister;
   piAddToClipboard        : TevMenuItem;
   piCopy                  : TMenuItem;
   piCut                   : TMenuItem;
   piFindDictEntryBySelect: TMenuItem;
   piInsertSubToObjList    : TMenuItem;
   piParseSelectTextAndSearch: TMenuItem;
   piPaste                 : TMenuItem;
   piRemoveSub             : TMenuItem;
   piSetContents: TMenuItem;
   piSetExternalObjOnSub   : TMenuItem;
   piSetReference          : TMenuItem;
   piShowClasses           : TMenuItem;
   piShowDocTypes          : TMenuItem;
   piShowKWords            : TMenuItem;
   piShowNameType          : TMenuItem;
   piShowOwnerSubOnClass   : TMenuItem;
   piShowRTF               : TMenuItem;
   piShowSubNumber: TMenuItem;
   piSubNameEdit           : TMenuItem;
   pmBlockTree             : TPopupMenu;
   pmCrrespList: TPopupMenu;
   pmDelBlock              : TMenuItem;
   pmJournal: TLinkPopUpMenu;
   pmPicture               : TLinkPopUpMenu;
   pmSection: TPopupMenu;
   pmSubAnchor             : TLinkPopUpMenu;
   pmSubList               : TLinkPopUpMenu;
   pnlHasFutureEditionWarning: TPanel;
   pnlIncludedWarn         : TPanel;
   pnlIncludeWarning: TPanel;
   PriznPopUpMenu          : TLinkPopUpMenu;
   sbCloseCorespondentsForBlock: TSpeedButton;
   ShortNameEdit           : TevEdit;
   SNPanel                 : TPanel;
   Splitter1               : TvtSplitter;
   SprTextEditor: TTextEditorWin;
   StyleSearcher           : TevStyleSearcher;
   SubAttrExplorer         : TAttrExplorer;
   SubDocFooter: TvtStatusBar;
   SubList                 : TvtDStringlister;
   SubPanelPopUpMenu       : TLinkPopUpMenu;
   tblJurJournal: TvtIStrListLister;
   tblOrdJournal: TvtIStrListLister;
   tblStage                : TOvcTable;
   tcStageBegin            : TOvcTCCheckBox;
   tcStageCheckTime: TOvcTCDate;
    tcStageCheckUser: TOvcTCComboBox;
   tcStageEnd              : TOvcTCCheckBox;
   tcStageName             : TOvcTCString;
   TextEditMenu            : TMainMenu;
   TextPopupMenu           : TLinkPopUpMenu;
   VersionFooter: TvtStatusBar;
   WarnCorespForBlockPanel : TPanel;
   WarnPanel               : TPanel;
   WinSplitLine            : TvtSplitter;
   acStyleTehComment: TAction;
   btnAllSabs: TSpeedButton;
   acInsFormula: TAction;
   miInsertFormula: TMenuItem;
   acPMSubAncorDelExtObject: TAction;
   N20: TMenuItem;
   Panel4: TPanel;
   btnExportObj: TSpeedButton;
   btnReplaceObj: TSpeedButton;
   dlgOpenObjectFile: TOpenDialog;
   dlgSaveObjectFile: TSaveDialog;
   miUserStyle12: TMenuItem;
   acStyleApendixHeader: TAction;
   pnlObject: TPanel;
   N21: TMenuItem;
   miAlignWithSeparator: TMenuItem;
   Label3: TLabel;
   cbUrgency: TComboBox;
   pnlUrgent: TPanel;
   acLinkSave: TAction;
   pmHyperlink: TPopupMenu;
   N26: TMenuItem;
   N29: TMenuItem;
   N31: TMenuItem;
   acLinkDeleteContext: TAction;
   acLinkFollowContext: TAction;
   pnlDocImageContainer: TPanel;
    Label7: TLabel;
    CommentEdit: TevEdit;
    acSetFrame: TAction;
    acDelFrame: TAction;
    N37: TMenuItem;
    N38: TMenuItem;
    N39: TMenuItem;
    acFindTable: TAction;
    N40: TMenuItem;
    N32: TMenuItem;
    acOldNSRC: TAction;
    miOldNSRC: TMenuItem;
    mipOldNSRC: TMenuItem;
    N33: TMenuItem;
    cbxNoCompare: TCheckBox;
    acRememberWidths: TAction;
    acApplyWidths: TAction;
    N41: TMenuItem;
    N42: TMenuItem;
    N43: TMenuItem;
    acMonoEnlarge: TAction;
    acMonoShrink: TAction;
    acToolsSetSections: TAction;
    N44: TMenuItem;
    acTranslate2Text: TAction;
    pmTranslate2Text: TMenuItem;
    acToolsCnvLowerCaseWithFirst: TAction;
    N45: TMenuItem;
    Label5: TLabel;
    acToolsAutolink: TAction;
    N46: TMenuItem;
    cbxInternet: TCheckBox;
    cbxHang: TCheckBox;
    pnlHang: TPanel;
    Panel8: TPanel;
    acPMSubCopyAddr: TAction;
    N47: TMenuItem;
    N48: TMenuItem;
    acInsTemplate: TAction;
    acInsTemplateEdit: TAction;
    N49: TMenuItem;
    N50: TMenuItem;
    RelSubPanelPopupMenu: TLinkPopUpMenu;
    piRelShowSubNumber: TMenuItem;
    N52: TMenuItem;
    acPMRelSubPanelSubNum: TAction;
    acSaveLocal: TAction;

   procedure FormClose(Sender: TObject; var Action: TCloseAction);
   procedure FormDestroy(Sender: TObject);
   procedure SetDocName(const aValue : AnsiString); override;
   function  Cut   : Boolean; override;
   function  Copy  : Boolean; override;
   function  Paste : Boolean; override;
   function  Print : Boolean; override;
   procedure AddtoClipboard;
   procedure acSetSubClick(Sender: TObject);
   procedure acDelSubExecute(Sender: TObject);

   procedure SNPanelResize(Sender: TObject);
   procedure ShowClassEditor(aAttrID : TdtAttribute);
   function  ParentDocListGetItemImageIndex(Sender: TObject; Index: Integer): Integer;
   procedure ParentDocListActionElement(Sender: TObject; Index : Longint);
   procedure ParentDocListCurrentChanged(Sender: TObject; aNewCurrent: Longint; aOldCurrent: Longint);

   procedure ChildDocOutlinerCurrentChanged(Sender: TObject; aNewCurrent: Longint; aOldCurrent: Longint);
   function  ChildDocOutlinerGetItemImage(Sender: TObject; Index: Integer;var aImages : TCustomImageList): Integer;
   procedure ChildDocOutlinerActionElement(Sender: TObject;Index : Longint);

   procedure lstVersionCurrentChanged(Sender: TObject; aNewCurrent: Longint; aOldCurrent: Longint);
   procedure lstVersionActionElement(Sender: TObject; Index : Longint);
   function  lstVersionGetItemImageIndex(Sender: TObject; Index: Integer): Integer;

   procedure SubListActionElement(Sender: TObject; Index : Longint);
   procedure SubListCurrentChanged(Sender: TObject; aNewCurrent: Longint; aOldCurrent: Longint);
   function  SubListGetItemImageIndex(Sender: TObject; Index: Integer): Integer;
   procedure ListToDocSetBtnClick(Sender: TObject);
   procedure ChkBxClick(Sender: TObject);

   procedure evntEditorParaChange(Sender: TObject; const TextPara: IedTextParagraph);
   procedure evntEditorFontChange(Sender: TObject; const Font: Il3Font);
   procedure evntEditorStyleChange(Sender: TObject; const Style: IedStyle);
   procedure FontComboBoxChange(Sender: TObject);
   //procedure StyleComboBoxChange(Sender: TObject);
   procedure FontSizeComboBoxChange(Sender: TObject);
   procedure ColorComboBoxChange(Sender: TObject);
   procedure sbUndoClick(Sender: TObject);
   procedure sbRedoClick(Sender: TObject);
   procedure cbClassSubsChange(Sender: TObject);
   procedure cbClassSubsExit(Sender: TObject);

   function  GetCurrentParaSubID : Tl3Handle;

   procedure GetAttrTreeListOnSub(aSubID : TSubID; aDictSet : TdtAttributeSet;
                                  aTreeSel : TTreeSelector = tsAll{;
                                  aStopNotify : Boolean = True}); override;

   procedure RefreshAttr(aSubID : TSubID;
                         aDictSet : TdtAttributeSet;
                         aTreeSel : TTreeSelector = tsAll); override;

   procedure SetReadOnlyAttrInTree(aReadOnlyDictSet : TdtAttributeSet);

   procedure seZoomUpDownClick(Sender: TObject);
   procedure seZoomKeyPress(Sender: TObject; var Key: Char);
   procedure seZoomExit(Sender: TObject);
   procedure DocEditorZoomChange(Sender: TObject);
   procedure sbShowSpecSymbolClick(Sender: TObject);
   //procedure sbPreviewModeClick(Sender: TObject);
   procedure sbWebStyleClick(Sender: TObject);

   procedure sbShowDocumentPartsClick(Sender: TObject);
   procedure EditorCanRedoChange(Sender: TObject);
   procedure EditorCanUndoChange(Sender: TObject);
   procedure nbkDocPagesPageChange(Sender: TObject; Index: Integer; var AllowChange: Boolean);
   procedure LoadPage(Index: Integer; Param : Longint = 0);
   procedure nbkDocPagesPageChanged(Sender: TObject; Index: Integer);
   procedure SubShowPanelClickSub(Sender: TObject; SubType, SubHandle: Integer; aKind: TafwClickKind);

   //procedure DocumentSourceGetSubFlagsIterator(Sender: TObject; aLayer: Longint; const aSubList: InevSubList);
   procedure ShowSubMaskClick(Sender: TObject);
   procedure ShowRelSubMaskClick(Sender: TObject);
   procedure ShortNameEditChange(Sender: TObject);
   procedure tblStageGetCellData(Sender: TObject; RowNum: Longint;
                                 ColNum: Integer; var Data: Pointer; Purpose: TOvcCellDataPurpose);
   procedure nbkJournalsPageChange(Sender: TObject; Index: Integer; var AllowChange: Boolean);
   procedure edtDocIDChange(Sender: TObject);
   procedure edtDocIDExit(Sender: TObject);
   procedure SetUserDocID(aUserDocID : Integer);
   procedure RunSpellChecker;
   procedure Panel5Resize(Sender: TObject);
   procedure edtPriorityIDChange(Sender: TObject);
   procedure cbxPriorityTypeClick(Sender: TObject);
   procedure cbUserTypeChange(Sender: TObject);
   function  otlBlocksGetItemImage(Sender: TObject; Index: Integer;var aImages : TCustomImageList): Integer;
   procedure otlBlocksActionElement(Sender: TObject; Index: Longint);
   procedure cbxIncDoneClick(Sender: TObject);
   procedure SubShowPanelMenuSub(Sender: TObject; const Pt: Tl3_SPoint; const R: Tl3_SRect; SubType, SubHandle: Integer);
   procedure edtObjectFilePathExit(Sender: TObject);
   procedure tblStageDoneEdit(Sender: TObject; RowNum: Longint; ColNum: Integer);
   procedure tblStageBeginEdit(Sender: TObject; RowNum: Longint; ColNum: Integer; var AllowIt: Boolean);
   procedure tblStageGetCellAttributes(Sender: TObject; RowNum: Longint; ColNum: Integer; var CellAttr: TOvcCellAttributes);
   procedure edtSprDocIDExit(Sender: TObject);
   procedure otlAttributesGetItemFont(Sender: TObject; Index: Integer; const aFont: Il3Font);
   procedure PriznPopUpMenuPopup(Sender: TObject);
   procedure otlBlocksResize(Sender: TObject);
   procedure otlAttributesActionElement(Sender: TObject;Index: Integer);
   function  otlPublishedInGetItemImage(Sender: TObject; Index: Integer;var aImages : TCustomImageList): Integer;
   function  SubShowPanelMouseOverSub(Sender: TObject; const Pt: Tl3_SPoint; const R: Tl3_SRect; const aSub: IevSub; SubType: Integer): Boolean;
   procedure TextSourceGetControlItemImg(aSender : TObject; const aControl : TnevControlInfo; out theImageInfo : TnevControlImageInfo);
   procedure DocTextSourceChangeModified(Sender: TObject);
   procedure SprTextSourceChangeModified(Sender: TObject);
   function  DocTextEditorDocEditorMouseAction(const aHotSpot: IevHotSpot; aButton: Tl3MouseButton; anAction: Tl3MouseAction; Keys: TShiftState; var NeedAsyncLoop : Boolean): Boolean;
   procedure miUserSetStyle(Sender: TObject);
   procedure FullNameMEditExit(Sender: TObject);
   procedure FullNameMEditTextSourceBruttoCharCountChange(Sender: TObject);
   procedure miGotoNextOccurClick(Sender: TObject);
   procedure acGoToPageExecute(Sender: TObject);
   procedure acSetReferenceEndExecute(Sender: TObject);
   procedure acSetIncludedStageExecute(Sender: TObject);
   procedure acTextSearchExecute(Sender: TObject);
   procedure acTextReplaceExecute(Sender: TObject);
   procedure acRefSearchExecute(Sender: TObject);
   procedure acRefReplaceExecute(Sender: TObject);
   procedure acPrevVersionExecute(Sender: TObject);
   procedure acSetBlockExecute(Sender: TObject);
   procedure acDelAllBlocksExecute(Sender: TObject);
   procedure acJurCommentStyleSearchExecute(Sender: TObject);
   procedure acVersionInfoStyleSearchExecute(Sender: TObject);
   procedure ParentDocListGetStrItem(Sender: TObject; Index: Integer; var ItemString: Il3CString);
   procedure acSetFullEditionStageExecute(Sender: TObject);
   procedure lstVersionGetItemFont(Sender: TObject; Index: Integer; const aFont: Il3Font);
   procedure acSetSharpReferenceExecute(Sender: TObject);
   procedure acGetCorespondentsForBlockExecute(Sender: TObject);
   procedure acReplaceHRefDocForBlockCorrespondentsExecute(Sender: TObject);
   procedure sbCloseCorespondentsForBlockClick(Sender: TObject);
   procedure cbCorSourcesChange(Sender: TObject);
   procedure LoadTbCorSourcesChange(Sender: TObject);
   procedure tblJournalGetStrItem(Sender: TObject; Index: Integer; var ItemString: Il3CString);
   procedure otlBlocksGetItemFont(Sender: TObject; Index: Integer; const aFont: Il3Font);
   function evntDocEditorJumpTo(Sender: TObject; const anEffects : TafwJumpToEffects; const aMoniker: IevMoniker): Boolean;
   procedure acSubNameCorrectExecute(Sender: TObject);
   procedure acAutoCompleteExecute(Sender: TObject);
   procedure acTextSaveExecute(Sender: TObject);
   procedure acTextSaveAsExecute(Sender: TObject);
   procedure acTextSelectAllExecute(Sender: TObject);
   procedure acTextCutExecute(Sender: TObject);
   procedure acTextCopyExecute(Sender: TObject);
   procedure acTextPasteExecute(Sender: TObject);
   procedure acTextPasteFromFileExecute(Sender: TObject);
   procedure acTextMarkAsNonPrintableExecute(Sender: TObject);
   procedure acTextMarkAsPrintableExecute(Sender: TObject);
   procedure acInsSignatureExecute(Sender: TObject);
   procedure acInsSectionExecute(Sender: TObject);
   procedure acInsPageBreakExecute(Sender: TObject);
   procedure acInsCreateStructureExecute(Sender: TObject);
   procedure acTblBoundariesExecute(Sender: TObject);
   procedure acTblFromTextExecute(Sender: TObject);
   procedure acTblAdjustCellsBoundariesExecute(Sender: TObject);
   procedure acTblAdjustNumberCellExecute(Sender: TObject);
   procedure acTblSetCellWidthExecute(Sender: TObject);
   procedure acLinkSetExecute(Sender: TObject);
   procedure acLinkSetManuallyExecute(Sender: TObject);
   procedure acLinkDeleteExecute(Sender: TObject);
   procedure acLinkFollowExecute(Sender: TObject);
   procedure acFindGeneralSearchExecute(Sender: TObject);
   procedure acFindGeneralReplaceExecute(Sender: TObject);
   procedure acFindGeneralRepeatSearchExecute(Sender: TObject);
   procedure acFindInFragmentExecute(Sender: TObject);
   procedure acToolsCnvUpperCaseExecute(Sender: TObject);
   procedure acToolsCnvLowerCaseExecute(Sender: TObject);
   procedure acToolsCnvInvertCaseExecute(Sender: TObject);
   procedure acToolsCnvRusCharsetExecute(Sender: TObject);
   procedure acToolsCnvEngCharsetExecute(Sender: TObject);
   procedure acToolsCnvOEM2ANSIExecute(Sender: TObject);
   procedure acToolsCnvANSI2OEMExecute(Sender: TObject);
   procedure acToolsCnvDate2TextExecute(Sender: TObject);
   procedure acToolsCnvMergeParaExecute(Sender: TObject);
   procedure acToolsAnalyseHeaderExecute(Sender: TObject);
   procedure acToolsFindTNVEDExecute(Sender: TObject);
   procedure acToolsSubmitJurChangesExecute(Sender: TObject);
   procedure acToolsUncontrolExecute(Sender: TObject);
   procedure acToolsAnnounceExecute(Sender: TObject);
   procedure acToolsRegistrationDeclinedExecute(Sender: TObject);
   procedure acToolsLinkAnnoExecute(Sender: TObject);
   procedure acToolsDocExpiredExecute(Sender: TObject);
   procedure acToolsMakeOldEditionExecute(Sender: TObject);
   procedure acToolsMakeOtherEditionExecute(Sender: TObject);
   procedure acToolsOpenAllEditionsExecute(Sender: TObject);
   procedure acToolsDeleteReferenceExecute(Sender: TObject);
   procedure acToolsDeleteAnnoExecute(Sender: TObject);
   procedure acPMCorrDeleteExecute(Sender: TObject);
   procedure acPMBTreeDeleteExecute(Sender: TObject);
   procedure acPMSubAncorDeleteExecute(Sender: TObject);
   procedure acPMSubAncorSaveExecute(Sender: TObject);
   procedure acPMSubAncorEditExecute(Sender: TObject);
   procedure acPMSubAncorSyncExecute(Sender: TObject);
   procedure acPMSubAncorSetClassExecute(Sender: TObject);
   procedure acPMSubAncorSetPrefixExecute(Sender: TObject);
   procedure acPMSubAncorSetKeyExecute(Sender: TObject);
   procedure acPMSubAncorSetTypeExecute(Sender: TObject);
   procedure acPMSubAncorSetTOCExecute(Sender: TObject);
   procedure acPMSubAncorLinkExtObjectExecute(Sender: TObject);
   procedure acPMTextSetLabelExecute(Sender: TObject);
   procedure acPMTextSetClassExecute(Sender: TObject);
   procedure acPMTextSetPrefixExecute(Sender: TObject);
   procedure acPMTextSetKeyExecute(Sender: TObject);
   procedure acPMTextSetTypeExecute(Sender: TObject);
   procedure acPMTextInsertTextExecute(Sender: TObject);
   procedure acPMTextFindInterpretationExecute(Sender: TObject);
   procedure acPMTextJumpToSubExecute(Sender: TObject);
   procedure acPMTextJumpToParaExecute(Sender: TObject);
   procedure acPMTextDocInfoExecute(Sender: TObject);
   procedure acPMAnnoSetClassExecute(Sender: TObject);
   procedure acPMMainSplitWindowExecute(Sender: TObject);
   procedure acPMMainSwapPanelsExecute(Sender: TObject);
   procedure acPMSubEditNameExecute(Sender: TObject);
   procedure acPMSubDeleteExecute(Sender: TObject);
   procedure acPMSectionPortraitExecute(Sender: TObject);
   procedure acPMSectionLandscapeExecute(Sender: TObject);
   procedure acPMSectionA4Execute(Sender: TObject);
   procedure acPMSectionA3Execute(Sender: TObject);
   procedure acPMSectionA2Execute(Sender: TObject);
   procedure acPMSectionA1Execute(Sender: TObject);
   procedure acPMAttrEditExecute(Sender: TObject);
   procedure acPMAttrSaveExecute(Sender: TObject);
   procedure acPMAttrDeleteExecute(Sender: TObject);
   procedure acPMAttrShowOwnersExecute(Sender: TObject);
   procedure acPMJournalDeleteExecute(Sender: TObject);
   procedure acPMPicStretchExecute(Sender: TObject);
   procedure ClassSubsPanelResize(Sender: TObject);
   procedure btnAllSabsClick(Sender: TObject);
   procedure acInsFormulaExecute(Sender: TObject);
   procedure FormShow(Sender: TObject);
   procedure acPMSubAncorDelExtObjectExecute(Sender: TObject);
   procedure Panel1Resize(Sender: TObject);
   procedure btnReplaceObjClick(Sender: TObject);
   procedure btnExportObjClick(Sender: TObject);
   procedure pnlObjectResize(Sender: TObject);
   procedure FormCreate(Sender: TObject);
   procedure cbUrgencyChange(Sender: TObject);
   procedure acLinkSaveExecute(Sender: TObject);
   procedure acLinkDeleteContextExecute(Sender: TObject);
   procedure acLinkFollowContextExecute(Sender: TObject);
   procedure pnlDocImageContainerResize(Sender: TObject);
   procedure edtAnnoNameTextSourceBruttoCharCountChange(Sender: TObject);
   procedure acSetFrameExecute(Sender: TObject);
   procedure acDelFrameExecute(Sender: TObject);
   procedure acFindTableExecute(Sender: TObject);
   procedure acOldNSRCExecute(Sender: TObject);
   procedure acOldNSRCUpdate(Sender: TObject);
   procedure acRememberWidthsExecute(Sender: TObject);
   procedure acApplyWidthsExecute(Sender: TObject);
   procedure acRememberWidthsUpdate(Sender: TObject);
   procedure acApplyWidthsUpdate(Sender: TObject);
   procedure acMonoShrinkExecute(Sender: TObject);
   procedure acMonoEnlargeExecute(Sender: TObject);
   procedure acSetSubUpdate(Sender: TObject);
   procedure acToolsAutolinkExecute(Sender: TObject);
   procedure acToolsSetSectionsExecute(Sender: TObject);
   procedure acTranslate2TextExecute(Sender: TObject);
   procedure acTranslate2TextUpdate(Sender: TObject);
   procedure acToolsCnvLowerCaseWithFirstExecute(Sender: TObject);
   procedure cbxHangClick(Sender: TObject);
   procedure acPMSubCopyAddrExecute(Sender: TObject);
   procedure acInsTemplateEditExecute(Sender: TObject);
   procedure acInsTemplateExecute(Sender: TObject);
    procedure tblJurJournalGetItemColor(Sender: TObject; Index: Integer;
      var FG, BG: TColor);
    procedure tblOrdJournalGetItemColor(Sender: TObject; Index: Integer;
      var FG, BG: TColor);
    procedure acSaveLocalExecute(Sender: TObject);
  private
   fStructInit       : Boolean;
   fSettingParamMode : Boolean;  //Указывает, что выполняется SetDocParam
   fParamSetted      : Boolean;  //предотвращает повторный вызов SetDocParam

   fDocClass        : TDocType;
   tmpValue         : TValue;
   SplitLog         : Boolean;

   fPaperUser       : TDictID;
   fPaperPlace      : AnsiString;
   JrnlList         : Tl3DataList;

   PrevDblEnter      : Boolean;
   CopyNametoSpr     : Boolean;
   fSubOnPopUp       : Longint;
   fSubShowMask      : Longint;
   fRelSubShowMask   : Longint;
   fCurrentTarget    : IUnknown;

   fSelectedSubList: Tl3LongintList;
   f_FlashView       : TvtShockwaveFlashEx;
   f_IsJurStageClosed: Boolean;
   f_TreeWasInit     : Boolean;

    // работа с образами документа
   f_TempImgFilename : AnsiString; // имя временного файла
   f_PicImageViewer  : TfrmImgViewer; // фрейм для показа образа-картинки
   f_MiscImageViewer : TfrmMiscDocImgView; // фрейм для показа образа-НЕкартинки
   f_SkipSubPanelClick: Boolean;
   f_CanStylizeBlocks: Boolean;

   function CheckEditor: Boolean;

   procedure CleanupTempImgFile;

   procedure CheckUrgencyDisp;
   procedure CheckHangDisp;
   procedure SetEditorReadOnly(Value : Boolean);
   function EditClassOnSub(aSub : TSubID; aDict : TdtAttribute; aNode : Il3HandleNode): Boolean;

   procedure LoadExtText(ExtFileName : TFileName; FilterIndex : Integer);
   {$IFDEF InsiderTest}
   public
   {$ENDIF InsiderTest}
   procedure SaveExtText(ExtFileName : TFileName; FormatIndex : Integer);
   {$IFDEF InsiderTest}
   private
   {$ENDIF InsiderTest}
   //procedure SaveText(aFullSave : Boolean = True);
   //procedure SaveSpr(aFullSave  : Boolean = True);

   function  cnvLo2Up   (Sender : TObject; B: PansiChar; L: Long; CharSet: Long) : Boolean;
   function  cnvUp2Lo   (Sender : TObject; B: PansiChar; L: Long; CharSet: Long) : Boolean;
   function  cnvLoUpSwap(Sender : TObject; B: PansiChar; L: Long; CharSet: Long) : Boolean;
   function  cnvRus2Eng (Sender : TObject; B: PansiChar; L: Long; CharSet: Long) : Boolean;
   function  cnvEng2Rus (Sender : TObject; B: PansiChar; L: Long; CharSet: Long) : Boolean;
   function  cnvOEM2ANSI(Sender : TObject; B: PansiChar; L: Long; CharSet: Long) : Boolean;
   function  cnvANSI2OEM(Sender : TObject; B: PansiChar; L: Long; CharSet: Long) : Boolean;
   function  cnvUp2LoWithFirst(Sender : TObject; B: PansiChar; L: Long; CharSet: Long) : Boolean;
   procedure WMDropAccept(var Message: TMessage); message wm_DropAccept;
   procedure WMClipChange(var Message: TMessage); message wm_WinClipChange;
   procedure LoadDictLinkPrim(Page : Byte; SubID : LongInt; SubItem : LongInt);
   procedure ShowOwnerSubList(aDictType : TdtAttribute; aItemID   : Longint);
   procedure SplitWindow(CurPageIndex, SecondPageIndex : Integer);
  
   //procedure ReBuildSubFlags;
   procedure CustomizePages(aNoSwapPage : Boolean = false);
   procedure CustomSubPanel(aShowMask : Longint; aIsForRel: Boolean = False);

   function  GetSprDocument : TSprDocument;
   function  GetSprID       : TDocID;
   function  GetCurDocument : TarCustomDocument; override;
   function  GetCurEditor   : TevCustomEditor; override;
   function  SetSubPrim(aSubType     : TSubType;
                        aAutoMode    : Boolean = False;
                        aWithConfirm : Boolean = True;
                        const aBlock : IevCommonDataObject = nil;
                        const aSubNumFormula : AnsiString = '') : ShortInt;
{$IFDEF nsTest}
  public
{$ENDIF nsTest}
   procedure SetContentsSub(aBlockID : Integer);
{$IFDEF nsTest}
  private
{$ENDIF nsTest}
   procedure SetRtfPropOnSub(aBlockID : Integer);
   procedure SetActiveControlOnPage(Index: Integer);

   procedure evntGetHotspotInfo(Sender         : TObject;
                                const aHotSpot : IevHotSpot;
                                const aKeys    : TafwCursorState;
                                var theInfo    : TafwCursorInfo);
   {* - Событие для получения информации о HotSpot'е. }
   procedure evntCursorInReference(aSender : TTextEditorWin; const aHyperlink : IevHyperlink);
   procedure GetSubListFromSelect(aSubList: Tl3LongintList);
   function  IsNeedSaveSpr : Boolean;
   function IsObjChanged: Boolean;
   procedure JumpToSubNode(aNode: Il3Node);
   procedure pm_SetTempImgFilename(const Value: AnsiString);
   procedure SyncStretch;
   procedure VisualizeObject;
   procedure CheckDocImage;
   procedure CheckForCourtCase;
   procedure CheckForNOTTM(aAttribute: IDocAttribute);
   function TemplateInputValueHandler(const aName: AnsiString; out theResult: AnsiString): Boolean;
  protected
   procedure AcquireCurDocParams; override;
   function GetTextDocumentView: InevView; override;
   procedure RefreshJurJorunal;
   procedure TuneDocument(aDocument : TarDocument); override;
   //procedure TuneTextSource(const aTextSource: TevCustomTextSource);

   procedure DocumentTextSourceTune(aSender: TObject); override;
   procedure SprTextSourceTune(aSender: TObject);
   procedure AnnoTextSourceTune(aSender: TObject);

   procedure DocumentTextEditorMakeTextSource(aSender: TObject; out theTextSource: TevCustomTextSource);
   procedure SprTextEditorMakeTextSource(aSender: TObject; out theTextSource: TevCustomTextSource);
   procedure AnnoTextEditorMakeTextSource(aSender: TObject; out theTextSource: TevCustomTextSource);

   function  MayAutoSave: Boolean; override;
   function  IsNeedSaveDocument : Boolean; override;
   function  TextSourcesCloseQuery : Boolean; override;
   function  CloseQuery: Boolean; override;
   procedure ReturnFocusToForm; override;

   //procedure DocumentSourceGetReader(Sender: TObject; Format: TevFormat; var Reader: TevFileReader); override;
   //procedure AnnoDocumentSourceGetReader(Sender: TObject; Format : TevFormat; var Reader : TevFileReader);
   //procedure DocumentSourceGetWriter(Sender: TObject; Format : TevFormat; var Writer : Tk2TagGenerator); override;

   procedure evntFinishInsertFromFile(Sender : TObject); override;
   function  evntDocTextSave(aPart: Tm3DocPartSelector; aFullSave: Boolean) : boolean; override;

   procedure DocumentSourceAllowGotoSub(Sender: TObject; const aPoint : IevDocumentPoint); override;
   procedure SprDocumentSourceAllowGotoSub(Sender: TObject; const aPoint : IevDocumentPoint);
   procedure JumpTo; override;
   procedure evntChangeDocAttribute(const aSender: IDocAttribute);
   function GetAllowReplaceTypes : TtsSrchTypeSet; override;

   procedure SetPicViewer;
   procedure SetMiscViewer;

   procedure AutoHLinker(aClearLinks: Boolean);
   procedure SaveDocParam;

   procedure MakeSpravka;
  public
   AlonePageIndex   : Integer;
   OldPageIndex     : Integer;
   PageLoad         : TPageLoadArray;
   UndoBrowser      : TUndoContentsForm;

   procedure SubNameEdit(aSubID: TSubID);
   procedure VisibleChanging; override;
   procedure SetShowSelect; override;
   procedure SetDocParam;
   function  IsDocParamChange(aFullCheck : Boolean = True) : Boolean; override;
   procedure LoadText;
   procedure GenerateSpr;
   procedure LoadSpr;
   procedure LoadAnno;
   {$Ifndef evNotUseTreePara}
   procedure LoadSubsInfo;
  {$EndIf evNotUseTreePara}
   procedure PrintAll; override;
   procedure GoToSub(aGoToSubID : Integer; aDocID : TDocID = 0); override;
   procedure RemoveSub(SubNum  : Tl3Handle; Item : Longint);
   procedure SyncWithSub(SyncPage : Integer; SubID : LongInt; SubItem : LongInt);
   procedure SetReadOnlyMask(aLockMask : Longint); override;
   procedure SetSpeedButton(Enabled : Boolean); override;
   function  IsCutPasteEnable : Boolean;
   procedure SaveDocument(aFullSave : Boolean = True); override;
   procedure CheckRequiredFields;

   procedure LoadDocEx(aNewDoc : Boolean;
                      aDocClass   : TDocType;
                      aSrcFile    : TFileName;
                      aAnalizeLog : Boolean;
                      aDocAddr : TDocAddr;
                      aDocName : AnsiString = '');
   procedure LoadDoc; override;
   procedure LoadNewDoc(aDocClass : TDocType; aSrcFile : TFileName; aAnalizeLog : Boolean; aDocAddr : TDocAddr; const aDocName : AnsiString = '');
   procedure LoadNewEmptyTextDocEx(aDocName : AnsiString; aDocAddr : TDocAddr; aDocType : TUserType = utNone);

   function  Execute : Boolean; override;
   function  ExecuteGroupMode(ADMode : TOperActionType) : Boolean;

   procedure GetGroupData(var GData : TGroupData);
   procedure sbGotoNextOccurClick(Sender: TObject);
   procedure sbGotoPrevOccurClick(Sender: TObject);
   procedure SaveStateToIni;
   procedure AfterHyperTextAction(haType : THyperTextActionSet; aSubFlagRebuild : Boolean = False); override;
   function  SubReplaceFunc(const aBlock   : InevRange;
                            aSubNumFormula : AnsiString;
                            aWithConfirm   : Boolean) : ShortInt;
   procedure evntFinishReplace(Sender: TObject; ReplaceCount: Longint);

   procedure SynchroFullNameWithSpr;
   procedure CheckShowWarnPanel;
   procedure CheckShowFutureEditionWarnPanel;

   //procedure UrOpMakeOldEdition(aOldEditionUserID : Integer);
   function IsMyDocID(aDocID : TDocID): Boolean; override;
   function NormDocID(aDocID : TDocID) : TDocID; override;
   constructor Create(AOwner: TComponent; aDocument : TarDocument = nil); reintroduce;

   property SprDocID  : TDocID read GetSprID;
   property TempImgFilename: AnsiString read f_TempImgFilename write pm_SetTempImgFilename;
  end;

{See also acGoToPageExecute}

implementation

{$R *.DFM}
{$R EDITOR.RES}

uses
 l3Variant,

 Clipbrd,
 StrUtils,
 ObjExpl,

 ResShop,
 StrShop,
 IniShop,
 DocAttrUtils,

 SrchWin,
 ObjExWin,
 ObjList,
 InsDWin,

 evCommonRes,

 D_ProcD,
 d_DateEdit,
 D_FileEdit,
 d_SubList,
 //D_PublIn2,
 D_SrcChk,
 D_PaperWhere,
 D_DateNumberEditor,
 D_IntEdit,
 d_ReplCorresp,
 //D_DocAddr,
 d_OldEdition,
 D_TxSrch,
 d_ExternalObject,
 D_GetContents,
 D_MacroSubNameProp,
 D_GetNum,
 D_TemplateEditor,

 DSubView,
 ShowMes,
 IDocSpc,
 vtLogFile,
 m2XLTLib,
 mgLngObj,

 l3PrimString,
 l3String,
 l3Languages,
 l3IniFile,
 l3Bits,
 l3FileUtils,
 l3InterfacesMisc,
 l3Clipboard,

 l3Chars,
 l3MinMax,
 l3SimpleCalc,
 l3Canvas,
 l3Memory,
 l3Stream,
 l3LingLib,
 l3InterfacedString,
 l3BatchService,

 k2Base,
 k2Types,
 k2Const,
 k2InternalInterfaces,
 k2InPlaceGenerator,
 vtUtils,

 evdStylesRes,

 evCommonUtils,
 evCopyTableCellWidth,

 evdDOM,
 evRange,
 evExcept,
 evCursorTools,
 evOP,
 evMsgCode,
 evTableTools,
 evOpProc,
 evDocumentPart,
 evAutoComplete,
 evContentsUtils,
 evBlocksEliminator,
 evTagsListFilter,
 evPictureReader,
 evContentTable,
 evAutoBlock,
 evPrevVersion,
 evEditorWindowTextSource,
 evBitmapReader,
 evStandardActions,
 evMenuMisc,
 evParaTools,
 evDisp,
 evGeneratorsInterfaces,
 evStubs,
 evTableSearch,
 evdReader,
 evSubPanelSub,
 evGraphicFileSupport,
 evdHyperlinkEliminator,
 evdParaStylePainter,

 evWikiReader,
 evdCustomHyperlinkCorrector,

 arContentsTreeWaiter,

 evContentsTree,
 nevConfirm,
 arMacroReplacer,

 arSearch,

 Readers,
 Writers,

 vtClipSpy,
 vtDialogs,

 BrdDlg,
 GardocBridge,

 m4DocumentAddress,

 ddDocumentCopy,

 daDataProvider,
 daTypes,

 Dt_ATbl,
 Dt_Active,
 DT_CFltr,
 DTSupport,
 Dt_IndexSupport,
 DT_DocImages,
 DT_ImgContainer,
 dt_DictTypes,
 dt_LinkServ,
 dt_Renum,

 nevFacade,

 {$IFDEF InsiderTest}
 afwAnswer,
 seModalSupport,
{$ENDIF InsiderTest}

 D_PicSizeEdit,
 BtnDlg,
 evFacadeSub,
 evFacadTextSource,
 evFacadeSelection,
 evFacadeGUI,
 evFacadeCursor,
 evFacadeUtils,
 OleCtrls,
 arDocObject,
 arTextUtils,
 arIZM,
 arConst,
 ImageEnIO,

 Base_CFG,
 l3LongintListPrim,

 TextPara_Const,
 ObjectSegment_Const,
 Formula_Const,
 BitmapPara_Const,
 Document_Const,
 Block_Const,
 LeafPara_Const,

 evdFrame_Const,

 ddRTFReader,
 ddSectionRepair, ddSectionWithSub2Para,
 ddAutoLinkFilter, ddAutolinkServer,
 vtDebug,
 ddImageHandleInsert,

 D_Spell, DocumentRes,

 UsersMacro,
 arTemplateProcessor
 ;

var
 GroupModeDisable : set of Byte = [piText, piSprv, piAnno, piPicture, piSub, piClass, piSrcImage, piResp, piCoresp, piVersion{,piJourn}];

const
 TextModeHidePage: set of Byte = [piPicture];
 TextCardModeHidePage: set of Byte = [piText, piSprv, piAnno, piSub, piClass, piPicture, piResp];
 GraphModeHidePage: set of Byte = [piSprv, piAnno, piClass, piSrcImage, piSub, piResp, piVersion];

 sCanStylizeBlocks = 'CanStylizeBlocks';

const
 ewSubPnlColonWidth = 17;
 ewSubPnlColonWidthNumber = 30;

 nfContens = $8000;

{TDocEditorWindow}

constructor TDocEditorWindow.Create(AOwner: TComponent; aDocument: TarDocument = nil);
var
 I : Integer;
begin
 inherited Create(AOwner, aDocument);

 nbkDocPages.Visible := False;
 Caption := '';
 with DocTextEditor do
  VisibleElements := VisibleElements + [eveSubPanel] - [eveVRuller];
 nbkDocPages.AutoTabSize := True;
 AlonePageIndex := -1;

 fSubShowMask := IniRec.SubShowMask;

 with SubPanelPopUpMenu do
  for I := 0 to Pred(Items.Count) do
   with (Items[I] as TMenuItem) do
    if (Action <> nil) then
     with (Action as TAction) do
      Checked := l3TestBit(fSubShowMask, Tag);

 CustomSubPanel(fSubShowMask);

 SubAttrExplorer.SubsComboBox := cbClassSubs;

 DocTextEditor.OnCursorInReference := evntCursorInReference;
 SprTextEditor.OnCursorInReference := evntCursorInReference;
 AnnoTextEditor.OnCursorInReference := evntCursorInReference;

 SprTextEditor.SubShowPanel.SubDescriptors := MainForm.SubDescriptors1;
 AnnoTextEditor.SubShowPanel.SubDescriptors := MainForm.SubDescriptors1;

 fRelSubShowMask := IniRec.RelSubShowMask;

 with RelSubPanelPopupMenu do
  for I := 0 to Pred(Items.Count) do
   with (Items[I] as TMenuItem) do
    if (Action <> nil) then
     with (Action as TAction) do
      Checked := l3TestBit(fRelSubShowMask, Tag);

 CustomSubPanel(fRelSubShowMask, True);

 sbShowSpecSymbolClick(Self);
 sbWebStyleClick(Self);

 DocTextEditor.OnTextSourceTune := DocumentTextSourceTune;
 SprTextEditor.OnTextSourceTune := SprTextSourceTune;
 AnnoTextEditor.OnTextSourceTune := AnnoTextSourceTune;

 DocTextEditor.OnMakeTextSource := DocumentTextEditorMakeTextSource;
 SprTextEditor.OnMakeTextSource := SprTextEditorMakeTextSource;
 AnnoTextEditor.OnMakeTextSource := AnnoTextEditorMakeTextSource;

 DocTextEditor.DocEditor.OnGetHotspotInfo := evntGetHotspotInfo;
 SprTextEditor.DocEditor.OnGetHotspotInfo := evntGetHotspotInfo;
 AnnoTextEditor.DocEditor.OnGetHotspotInfo := evntGetHotspotInfo;

 ChildDocOutliner.Images := ArchiResources.CommonImageList;
 ParentDocList.Images := ArchiResources.CommonImageList;

 otlBlocks.Images := ArchiResources.CommonImageList;
 //otlBlocks.Width := 0;

 ChildDocOutliner.UseStyleTable := True;
 ParentDocList   .UseStyleTable := True;
 SubList         .UseStyleTable := True;
 lstVersion      .UseStyleTable := True;
 tblJurJournal   .UseStyleTable := True;
 tblOrdJournal   .UseStyleTable := True;
 otlBlocks       .UseStyleTable := True;

 FullNameMedit.KeepAllFormatting := False;
 EvSetPlainTextFlag(FullNameMedit, False);

 ShortNameEdit.KeepAllFormatting := False;
 ShortNameEdit.PlainText := False;

 edtAnnoName.KeepAllFormatting := False;
 edtAnnoName.PlainText := False;
 evSetBruttoCharLimit(edtAnnoName.TextSource, cUserFullNameSize + 2);

 CommentEdit.KeepAllFormatting := False;
 CommentEdit.PlainText := False;

 evSetBruttoCharLimit(CommentEdit.TextSource, cDocCommentSize + 2);

 UserManager.GetFiltredUserList(tcStageCheckUser.Items, True {aOnlyActive});
end;

procedure TDocEditorWindow.CheckUrgencyDisp;
begin
 pnlUrgent.Visible := (cbUrgency.ItemIndex > 0) and (not cbxIncDone.Checked);
end;

procedure TDocEditorWindow.TextSourceGetControlItemImg(aSender          : TObject;
                                                       const aControl   : TnevControlInfo;
                                                       out theImageInfo : TnevControlImageInfo);
begin
 if (aControl.rControl <> nil) then
 begin
  if not aControl.rControl.IsKindOf(k2_typBlock) and not aControl.rControl.IsKindOf(k2_typTextPara) then
  begin
   theImageInfo.rImageList := vtMakeImageListWrapper(nsDocumentRes.CommentsImageList);
   if aControl.rControl.IsKindOf(k2_typBitmapPara) then
   begin
    if (aControl.rFormatInfo <> nil) AND
       (aControl.rFormatInfo.ParentInfo <> nil) AND
       (aControl.rFormatInfo.ParentInfo.ParentInfo <> nil) then
    begin
     if DocTextEditor.DocEditor.View.Metrics.IsTagCollapsed(aControl.rFormatInfo.ParentInfo.ParentInfo.Obj.AsObject) then
      theImageInfo.rFirstIndex := 3
     else
      theImageInfo.rFirstIndex := 2;
    end;//aControl.rTool <> nil
   end//aControl.rControl.IsKindOf(k2_typBitmap)
  end; // if not aControl.rControl.IsKindOf(k2_typBlock) then
 end;
end;

procedure TDocEditorWindow.DocumentTextSourceTune(aSender: TObject);
begin
 Inherited;
 DocTextEditor.DocEditor.TextSource.DocumentContainer.LinkWaiter(TarContentsTreeWaiter.Make(DocTextEditor.DocEditor));
 DocTextEditor.DocEditor.TextSource.OnGetControlItemImg := TextSourceGetControlItemImg;
end;

procedure TDocEditorWindow.SprTextSourceTune(aSender: TObject);
var
 lTextSource : TevCustomTextSource;
begin
 if not Document.HasSpravka then Exit;
 lTextSource := Document.Spravka.TextSource;
 if lTextSource = nil then Exit;
 //lTextSource.OnGetReader := DocumentSourceGetReader;
 //lTextSource.OnGetWriter := DocumentSourceGetWriter;
end;

procedure TDocEditorWindow.AnnoTextSourceTune(aSender: TObject);
var
 lTextSource : TevCustomTextSource;
begin
 lTextSource := Document.AnnoTextSource;
 //lTextSource.OnGetReader := AnnoDocumentSourceGetReader;
 //lTextSource.OnGetWriter := DocumentSourceGetWriter;
 lTextSource.Processor.DefaultStyle := ev_saNormalAnno;
end;

procedure TDocEditorWindow.DocumentTextEditorMakeTextSource(aSender: TObject; out theTextSource: TevCustomTextSource);
begin
 theTextSource := Document.TextSource;
end;

procedure TDocEditorWindow.SprTextEditorMakeTextSource(aSender: TObject; out theTextSource: TevCustomTextSource);
begin
 if not Document.IsPossibleSpr then Exit;
 MakeSpravka;
 theTextSource := Document.Spravka.TextSource;
end;

procedure TDocEditorWindow.AnnoTextEditorMakeTextSource(aSender: TObject; out theTextSource: TevCustomTextSource);
begin
 theTextSource := Document.AnnoTextSource;
end;

procedure TDocEditorWindow.TuneDocument(aDocument: TarDocument);
begin
 inherited;
 if MainAttrExplorer <> nil then
 begin
  MainAttrExplorer.Document := Document;
  if SubAttrExplorer <> nil then
   SubAttrExplorer.Document := Document;
  Document.OnChangeDocAttribute := evntChangeDocAttribute;
 end; // if MainAttrExplorer <> nil then
end;

function TDocEditorWindow.GetSprDocument: TSprDocument;
begin
 Result := Document.Spravka;
end;

procedure TDocEditorWindow.SaveStateToIni;
begin
 IniRec.RecordFill := True;
 IniRec.Page := nbkDocPages.PageIndex;
 IniRec.AlonePage := AlonePageIndex;
 IniRec.Width := Width;
 IniRec.Height := Height;
 IniRec.Maximize := WindowState = wsMaximized;
 if AlonePageIndex > -1 then
  IniRec.AlonePageHeight := TOvcNotebookPage(nbkDocPages.PageList[AlonePageIndex]).Height;
end;

function TDocEditorWindow.IsCutPasteEnable: Boolean;
begin
 Result := not ReadOnly and (CheckEditor or (nbkDocPages.PageIndex = piPicture));
end;

procedure TDocEditorWindow.WMClipChange(var Message: TMessage);
var
 l_Enable : Boolean;
begin
 l_Enable := not ReadOnly and ( not ClipboardIsEmpty) and IsCutPasteEnable;
 MainForm.acPaste.Enabled := l_Enable;
 acTextPaste.Enabled := l_Enable;
 evOperationDispatcher.OperationEnabled[ev_ccSpecialPaste] := l_Enable;
 piPaste.Enabled := l_Enable;
end;

function TDocEditorWindow.MayAutoSave: Boolean;
begin
 Result := inherited MayAutoSave and not fGroupMode;
end;

procedure TDocEditorWindow.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if FModalMode then
 begin
  Action := caNone;
  ModalResult := mrCancel;
 end
 else
  Action := caFree;
 TSpellCheckDlg.CloseSpellCheck;
end;

function TDocEditorWindow.GetSprID: TDocID;
begin
 Result := Document.GetSprDocID;
end;

function TDocEditorWindow.GetCurEditor: TevCustomEditor;
begin
 if ActiveControl is TevCustomEditor then
  Result := TevCustomEditor(ActiveControl)
 else
  if (nbkDocPages.PageIndex = piSprv) then
   Result := SprTextEditor.DocEditor
  else 
   if (nbkDocPages.PageIndex = piAnno) then
    Result := AnnoTextEditor.DocEditor
 else
  Result := DocTextEditor.DocEditor;
end;

type
 TOvcNotebookPageHack = class(TOvcNotebookPage);

procedure TDocEditorWindow.ReturnFocusToForm;
var
 lActCtrl : TWinControl;
begin
 lActCtrl := ActiveControl;
 if lActCtrl is TovcNotebookPage then
  // найти первый элемент на странице
  lActCtrl := TOvcNotebookPageHack(lActCtrl).FindNextControl(nil, True, True, False);
 if lActCtrl = nil then
  lActCtrl := ActiveControl;
 if lActCtrl <> nil then
  lActCtrl.SetFocus;
end;

function TDocEditorWindow.GetCurDocument: TarCustomDocument;
begin
 if CurEditor = SprTextEditor.DocEditor then
  Result := Document.Spravka
 else
  Result := Document;
end;

procedure TDocEditorWindow.CustomizePages(aNoSwapPage: Boolean = False);
begin
 if IniRec.RecordFill then
 begin
  If not nbkDocPages.PagesVisible[IniRec.Page] then
   aNoSwapPage := True;
  if not aNoSwapPage then
  try
   nbkDocPages.PageIndex := IniRec.Page;
  except
   aNoSwapPage := True;
  end;
  if IniRec.Maximize then
   WindowState := wsMaximized
  else
  begin
   Width := IniRec.Width;
   Height := IniRec.Height;
  end;

  Application.ProcessMessages;
  if fLoadStopLog then Exit;

  if not aNoSwapPage then
   if IniRec.AlonePage > -1 then
   begin
    SplitWindow(IniRec.Page, IniRec.AlonePage);
    TOvcNotebookPage(nbkDocPages.PageList[AlonePageIndex]).Height := IniRec.AlonePageHeight;
   end;
  //RecreateWnd;
 end;

 if fLoadStopLog then Exit;
 otlBlocks.Width := IniRec.BlockExplorerWidth;
 otlBlocks.OnResize := otlBlocksResize; // в disigntime нельзя т к прутся поразитные вызовы при загрузке формы

 nbkDocPages.Visible := True;
 SetActiveControlOnPage(nbkDocPages.PageIndex);
end;

procedure TDocEditorWindow.otlBlocksResize(Sender: TObject);
begin
 IniRec.BlockExplorerWidth := otlBlocks.Width;
end;

procedure TDocEditorWindow.GoToSub(aGoToSubID: Integer; aDocID: TDocID = 0);
begin
 if aGoToSubID < 0 then
  Exit;
 try
  if (aDocID = DocID) or (aDocID = 0) then
  begin
   if fDocClass <> Dt_Types.dtText then
    nbkDocPages.PageIndex := piPicture
   else
   begin
    nbkDocPages.PageIndex := piText;
    with DocTextEditor.DocEditor do
     evGetSubList(TextSource).Sub[aGoToSubID].Select(Selection);
   end;
  end
  else
  begin
   nbkDocPages.PageIndex := piSprv;
   with SprTextEditor.DocEditor do
    evGetSubList(TextSource).Sub[aGoToSubID].Select(Selection);
  end
 except
 end;
end;

type
 THackWinControl = class(TWinControl);

procedure TDocEditorWindow.LoadDocEx(aNewDoc: Boolean; aDocClass : TDocType; aSrcFile : TFileName;
                                     aAnalizeLog : Boolean; aDocAddr: TDocAddr; aDocName : AnsiString = '');
var
 I : Integer;
 lNoSwapPage : Boolean;

 lPack : InevOp;
 lStrPos : Integer;
 l_StagesTool : IStageDocAttributeTool;
 {$IfDef DEBUGOUT2}
  lTimer : Cardinal;
 {$EndIf}

begin
 l3System.Msg2Log('LoadDoc #%d', [Document.DocID]);
 {$IfDef DEBUGOUT2}
  lTimer := dbgStartTimeCounter;
 {$EndIf}

 lNoSwapPage := False;
 StopAutoSave;
 try
  if not aNewDoc then
   aAnalizeLog := False;

  IsNewDoc := aNewDoc;
  fDocClass := aDocClass;

  if aDocClass = Dt_Types.dtText then
  begin
   Label1.Visible := false;
   ShortNameEdit.Visible := false;
   SNPanel.Height := 60;

   if Document.IsPossibleText then
   begin
    for I := 0 to nbkDocPages.Pages.Count do
     if I in TextModeHidePage then
      nbkDocPages.PagesVisible[I] := False;
   end
   else
   begin
    for I := 0 to nbkDocPages.Pages.Count do
     if I in TextCardModeHidePage then
      nbkDocPages.PagesVisible[I] := False;
   end;

   if IsNewDoc then
    Document.MakeNew(aDocClass, aSrcFile)
   else
   begin
    LoadText;
    LoadSpr;
   end;

   Lock;

   if fLoadStopLog then Exit;

   LoadPage(nbkDocPages.PageIndex);

   MainAttrExplorer.AttrSet := GlMainAttrSet - HiddenAttr;
   SubAttrExplorer.AttrSet := GlSubAttrSet - HiddenAttr;

   LoadPage(nbkDocPages.PageIndex);

   DocTextEditor.DocEditor.Zoom := IniRec.Zoom;
   AnnoTextEditor.DocEditor.Zoom := IniRec.Zoom;
   SprTextEditor.DocEditor.Zoom := IniRec.Zoom;

   if Document.IsPossibleText then
    if DocJumpData.DocJumpType = djSub then
    begin
     if DocJumpData.DocPointAddr.Doc <> Document.GetSprDocID then
     begin
      nbkDocPages.PageIndex := piText;
      nbkDocPages.PagesEnabled[piSprv] := False;
     end
     else
     begin
      nbkDocPages.PageIndex := piSprv;
      nbkDocPages.PagesEnabled[piText] := False;
      lNoSwapPage := True;
     end;
    end;

   if fLoadStopLog then Exit;

   CustomizePages(lNoSwapPage);
   if fLoadStopLog then Exit;

   LoadPage(piJourn);
   if fLoadStopLog then Exit;
   SetDocParam;
   if fLoadStopLog then Exit;

   LoadPage(piSub);
   //LoadPage(piJourn);
   if fLoadStopLog then Exit;

   CheckDocImage;

  if Document.IsPossibleText then
   if IsNewDoc then
   begin
    //LoadExtText(aSrcFile, -1);
    //if fLoadStopLog then Exit;
    Document.TextSource.Modified := True;
    f_IsJurStageClosed := False;
   end
   else
   begin
    nbkDocPages.PagesEnabled[piText] := True;

    if (DocJumpData.DocJumpType = djSub) and (DocJumpData.DocPointAddr.Doc = SprDocID) then
    begin
     if Document.IsPossibleSpr and (SprDocID > 0) then
     begin
      nbkDocPages.PagesEnabled[piSprv] := True;
      nbkDocPages.PageIndex := piSprv;
      //LoadSpr;
     end;
     nbkDocPages.PagesEnabled[piText] := True;
     //LoadText;
    end
    else
    begin
     nbkDocPages.PagesEnabled[piText] := True;
     //LoadText;
     if fLoadStopLog then Exit;
     nbkDocPages.PagesEnabled[piSprv] := Document.IsPossibleSpr and (SprDocID > 0);
     //LoadSpr;
    end;
    if fLoadStopLog then Exit;

    l_StagesTool := (Document.AttrManager.GetDocAttribute(atStages) as IStageDocAttributeTool);
    f_IsJurStageClosed := l_StagesTool.CheckStageClosed(stUrObr);
   end;

   if fLoadStopLog then Exit;

   CheckShowWarnPanel;
   CheckShowFutureEditionWarnPanel;

   if AlonePageIndex > -1 then
    LoadPage(AlonePageIndex);
   ActiveChanged;

   InitAutoSave;

   fStructInit := True;
   if MainForm.ActiveMDIChild = Self then
    SetSpeedButton(Enabled);

   if fLoadStopLog then Exit;

   if DocJumpData.JumpOnLoad then
    sbGotoNextOccurClick(Self);

   if Length(aDocName) > 0 then // Заголовок написали вручную
   begin
    Screen.Cursor := crHourGlass;
    try
     with IDocSpecial.Create(Self) do
     try
      AnalyseTextForParam(aDocName);
     finally
      Free;
     end;

    // Вставляем aDocName в текст
     lStrPos := l3CharSetPresentEx(PansiChar(aDocName), Length(aDocName),
                                   [cc_DoubleQuote, cc_LDoubleQuote, cc_LTDoubleQuote]);
     if (lStrPos > 0) and
         (aDocName[lStrPos] = cc_HardSpace) then
      aDocName[lStrPos] := cc_SoftEnter;

     with DocTextEditor.DocEditor do
     begin
      lPack := StartOp(ev_ocUser + 101);
      try
       //ReadOnly := False;
       GotoTop;
       InsertBuf(l3PCharLen(aDocName));
       TextPara.Style.ID := ev_saTxtHeader1;
       InsertBuf(l3PCharLen(#13#10#13#10));
      finally
       lPack := nil;
      end;
     end;
     // - Вставляем aDocName в текст
    finally
     Screen.Cursor := Cursor;
    end;
   end
   else // Заголовок из текста
   if aAnalizeLog then
   begin
    Screen.Cursor := crHourGlass;
    try
     DocTextEditor.DocEditor.GoToTop;
     with DocTextEditor.DocEditor do
     begin
      while (CurText.SLen = 0) and MoveLeafCursor(ev_ocParaDown, True) do
      ;

      if (CurText.SLen <> 0) then
       with IDocSpecial.Create(Self) do
        try
         AnalyseTextForParam;
        finally
         Free;
        end;
     end;
    finally
     Screen.Cursor := Cursor;
    end;
   end;
  end
  else  //if aDocClass = Dt_Const.dtText
  if aDocClass in [Dt_Types.dtObject, Dt_Types.dtFlash] then
  begin
   vtVisibleAndEnabled(miText, False);
   vtVisibleAndEnabled(miTable, False);
   vtVisibleAndEnabled(acSetFrame, False);
   vtVisibleAndEnabled(acDelFrame, False);
   vtVisibleAndEnabled(miInsertMenu, False);
   vtVisibleAndEnabled(miHyperText, False);
   vtVisibleAndEnabled(miSearch, False);
   vtVisibleAndEnabled(miService, False);
   vtVisibleAndEnabled(acTranslate2Text, True);
   vtVisibleAndEnabled(pmTranslate2Text, True);

   Label1.Visible := True;
   ShortNameEdit.Visible := True;
   SNPanel.Height := 115;

   //MainAttrExplorer.AttrSet := GlMainAttrSetForObject - HiddenAttr;
   CustomizePages;

   nbkDocPages.PageIndex := piPicture;
   for I := 0 to nbkDocPages.Pages.Count do
    if I in GraphModeHidePage then
     nbkDocPages.PagesVisible[I] := False;

   nbkDocPages.Visible := True;

   if aDocClass = dtObject then
   begin
    acPMPicStretch.Checked := True;
    ieView.AutoFit := True;
    nbkDocPages.PagesVisible[piText] := False; // для флеша текст не скрываем, только для картинок/объекта
   end
   else
   begin
    l3Free(ieView);
    f_FlashView := TvtShockwaveFlashEx.Create(Self);
    pnlObject.InsertControl(f_FlashView);
    with f_FlashView do
    begin
     Align := alClient;
     Perform(CM_RECREATEWND,0,0);
    end;
   end;

   if IsNewDoc then
   begin
    Document.MakeNew(aDocClass, aSrcFile);
    if aDocClass = dtObject then
     ieView.Tag := 1
    else
     f_FlashView.Tag := 1;
   end
   else
   begin
    Document.LoadText;
   end;

   Lock;

   edtObjectFilePath.Text := Document.ObjAccess.FilePath;
   SetDocParam;
   MainAttrExplorer.AttrSet := GlMainAttrSetForObject - HiddenAttr;
   fStructInit := True;
   VisualizeObject;
  end;

  if IsNewDoc then
   try
    if aDocAddr.DocID > 0 then
     SetUserDocID(aDocAddr.DocID);
   except
    on E: Exception do
     Application.ShowException(E);
   end;
  //VisualizeObject;
 finally
  StartAutoSave;
 end;

 //debug
 if IniRec.DebugInfo then
 begin
  cbxHasAnno.Visible := True;
  cbxHasAnno.Checked := Document.HasAnno;
 end;

{$IfDef DEBUGOUT2}
 dbgAppendToLogLN(format('TDocEditorWindow.LoadDocEx %s',[dbgFinishTimeCounter(lTimer)]));
{$EndIf}
end;

// эта хня используется только в UsersMacro.Macros_UrOpMakeOldEdition
procedure TDocEditorWindow.LoadNewEmptyTextDocEx(aDocName: AnsiString; aDocAddr: TDocAddr;
                                                 aDocType: TUserType = utNone);
var
 I : Integer;
 Pack : InevOp;
 //lEditRec : TFullCardEditRec;
 lStrPos : Integer;
begin
 IsNewDoc := True;
 fDocClass := Dt_Types.dtText;

 Document.MakeNew(fDocClass);
 Document.UserType := aDocType;

 MainAttrExplorer.AttrSet := GlMainAttrSet - HiddenAttr;
 SubAttrExplorer.AttrSet := GlSubAttrSet - HiddenAttr;

 for I := 0 to nbkDocPages.Pages.Count do
  if I in TextModeHidePage then
   nbkDocPages.PagesVisible[I] := False;

 //if aNoCustomize then
 //begin
  nbkDocPages.PageIndex := piText;
  nbkDocPages.Visible := True;
  otlBlocks.Width := IniRec.BlockExplorerWidth;
 //end
 // else
 // CustomizePages;

 LoadPage(nbkDocPages.PageIndex);
 //SetActiveControlOnPage(nbkDocPages.PageIndex);

 DocTextEditor.DocEditor.Zoom := IniRec.Zoom;
 AnnoTextEditor.DocEditor.Zoom := IniRec.Zoom;
 SprTextEditor.DocEditor.Zoom := IniRec.Zoom;

 if fLoadStopLog then Exit;

 SetDocParam;

 if fLoadStopLog then Exit;

 LoadPage(piSub);
 LoadPage(piJourn);

 If fLoadStopLog then Exit;

 ActiveChanged;

 InitAutoSave;
 fStructInit := True;

 if MainForm.ActiveMDIChild = Self then
  SetSpeedButton(Enabled);

 try
  if aDocAddr.DocID > 0 then
   SetUserDocID(aDocAddr.DocID);
 except
  on E: Exception do
   Application.ShowException(E);
 end;
end;

procedure TDocEditorWindow.LoadDoc;
var
 lDocAddr : TDocAddr;
begin
 LoadDocEx(False {aNewDoc}, Document.DocClass, '' {aSrcFile}, False {aAnalizeLog}, lDocAddr);
end;

procedure TDocEditorWindow.LoadNewDoc(aDocClass: TDocType; aSrcFile: TFileName;
                                      aAnalizeLog: Boolean; aDocAddr: TDocAddr; const aDocName : AnsiString = '');
begin
 LoadDocEx(True {aNewDoc}, aDocClass, aSrcFile, aAnalizeLog, aDocAddr, aDocName);
end;

procedure TDocEditorWindow.SetEditorReadOnly(Value: Boolean);
begin
 if Application.Terminated then
  Exit;
 {miText}
 miUndo.Enabled := not Value;
 miRedo.Enabled := not Value;

 acTextCut.Enabled := not Value;
 {miCopy      .Enabled      := Not Value;}
 acTextPaste.Enabled := not Value;
 miStyle.Enabled := not Value;

 evOperationDispatcher.OperationEnabled[ev_ccSpecialPaste] := not Value;
 evOperationDispatcher.OperationEnabled[ev_ccJustifyLeft] := not Value;
 evOperationDispatcher.OperationEnabled[ev_ccJustifyCenter] := not Value;
 evOperationDispatcher.OperationEnabled[ev_ccJustifyRight] := not Value;
 evOperationDispatcher.OperationEnabled[ev_ccJustifyWidth] := not Value;
 evOperationDispatcher.OperationEnabled[ev_ccJustifyPreformatted] := not Value;

 acOldNSRC.Enabled := not Value;
 acTranslate2Text.Enabled := False;
 acTextPasteFromFile.Enabled := not Value;

 //miJustCenter      .Enabled := Not Value;
 //miJustRight       .Enabled := Not Value;
 //miJustLeft        .Enabled := Not Value;
 //miJustWide        .Enabled := Not Value;

 acTextMarkAsNonPrintable.Enabled := not Value;
 acTextMarkAsPrintable.Enabled := not Value;

 {miSearch   .Enabled      := Not Value;}
 {miFind      .Enabled      := Not Value;}
 acFindGeneralReplace.Enabled := not Value;
 {miSrchAgain .Enabled      := Not Value;}
 acTextReplace.Enabled := not Value;
 acRefReplace.Enabled := not Value;

 miInsertMenu.Enabled := not Value;

 miTable.Enabled := not Value;
 acSetFrame.Enabled := not Value;
 acDelFrame.Enabled := not Value;

 if Value then
 begin
  miTblDelCol.Enabled := False;
  miTblInsCol.Enabled := False;
  miTblDelStr.Enabled := False;
  miTblInsStr.Enabled := False;
 end; // if Value then
 miTblFromText.Enabled := not Value;
 miTblCreate.Enabled := not Value;
 miOldNSRC.Enabled := not Value;

 miService.Enabled := not Value;
end;

procedure TDocEditorWindow.SetSpeedButton(Enabled: Boolean);
var
 lEditEnabled        : Boolean;
 lEditandMemoEnabled : Boolean;
 lFullEditEnabled    : Boolean;
 lSubEditEnabled     : Boolean;
 lBlockEditEnabled   : Boolean;
 lIsAnnoEditor       : Boolean;
 lTestRes            : Boolean;
 lCurRO              : Boolean;
 lCurRO2             : Boolean;
begin
 if Application.Terminated then
  Exit;
 if not fStructInit then
  Exit;
 if (ActiveControl = nil) then
  Exit;

 Enabled := Enabled and not (csDestroying in ComponentState);

 lIsAnnoEditor  := Enabled and (ActiveControl = AnnoTextEditor.DocEditor);

 lFullEditEnabled := Enabled and
                     ((l3TestMask(Document.LockMask, acgText) and
                     ((ActiveControl = DocTextEditor.DocEditor) or
                      (ActiveControl = SprTextEditor.DocEditor))) or
                     (l3TestMask(Document.LockMask, acgAnno) and
                     (ActiveControl = AnnoTextEditor.DocEditor)));

 lEditEnabled := Enabled and CheckEditor;

 MainForm.acSpellChecker.Enabled := lEditEnabled;
 //MainForm.sbGotoNextFindWord.Enabled := lEditEnabled and (ReadOnly or Assigned(FindSubList));
 MainForm.acGotoNextOccur.Enabled := Enabled and not DocJumpData.JumpOnce;
 MainForm.acGotoPrevOccur.Enabled := {EditEnabled and ReadOnly} False;

 {Clipboard}
 lEditEnabled := Enabled and IsCutPasteEnable;

 MainForm.acCut.Enabled := lEditEnabled and not ReadOnly;
 piCut.Enabled := lEditEnabled and not ReadOnly;

 MainForm.acCopy.Enabled := lEditEnabled;

 MainForm.acPaste.Enabled := lEditEnabled and not ReadOnly and not ClipboardIsEmpty;

 piPaste.Enabled := lEditEnabled and not ReadOnly and not ClipboardIsEmpty;

 //WMClipChange(var Message: TMessage);

 {Editor}
 {Text & Spravka}
 lCurRO := not Enabled or not lFullEditEnabled or ReadOnly;

 lEditEnabled := (Enabled and (ActiveControl is TevEditor));
 lEditandMemoEnabled := (Enabled and ((ActiveControl is TevEditor) or
  (ActiveControl = FullNameMEdit)));
 {EditandMemoEnabled := (Enabled and (ActiveControl is TevCustomEditor));}

 //MainForm.sbAddToClipboard   .Enabled := EditEnabled;
 MainForm.acSave.Enabled := Enabled and not ReadOnly;
 MainForm.acPrint.Enabled := Enabled and ((ActiveControl is TevEditor) or (nbkDocPages.PageIndex = piSrcImage));
 //MainForm.acSpellChecker.Enabled := lEditandMemoEnabled and not lCurRO;
 MainForm.acFind.Enabled := lEditEnabled;
 MainForm.acDrawLines.Enabled := Enabled and not lCurRO;
 MainForm.acFindNext.Enabled := lEditEnabled;
 MainForm.acShowSpecSymbol.Enabled := Enabled {EditandMemoEnabled} {and not lCurRO};
 //MainForm.acPreviewMode.Enabled := Enabled;
 MainForm.acWebStyle.Enabled := Enabled;
 MainForm.acShowSelect.Enabled := Enabled;
 MainForm.acShowDocumentParts.Enabled := Enabled;

 acGetCorespondentsForBlock.Enabled := lEditEnabled;
 acReplaceHRefDocForBlockCorrespondents.Enabled := lEditEnabled;

 MainForm.acRedo.Enabled := lEditandMemoEnabled and not lCurRO and
  (ActiveControl as TevCustomEditor).CanRedo;
 MainForm.acUndo.Enabled := lEditandMemoEnabled and not lCurRO and
  (ActiveControl as TevCustomEditor).CanUndo;

 {MainForm.FormatToolbar   .Visible := True;}
 MainForm.acBold.Enabled := lEditEnabled and not lCurRO;
 MainForm.acItalic.Enabled := lEditEnabled and not lCurRO;
 MainForm.acUnderline.Enabled := lEditEnabled and not lCurRO;
 MainForm.acJustifyWidth.Enabled := lEditEnabled and not lCurRO;
 MainForm.acJustifyRight.Enabled := lEditEnabled and not lCurRO;
 MainForm.acJustifyLeft.Enabled := lEditEnabled and not lCurRO;
 MainForm.acJustifyCenter.Enabled := lEditEnabled and not lCurRO;
 MainForm.acJustifyPreformatted.Enabled := lEditEnabled and not lCurRO;

 MainForm.acHidingText.Enabled := lEditEnabled and not lCurRO;

 MainForm.StyleComboBox.Enabled := lEditEnabled and not lCurRO;
 MainForm.FontComboBox.Enabled := lEditEnabled and not lCurRO;
 MainForm.FontSizeComboBox.Enabled := lEditEnabled and not lCurRO;
 MainForm.ColorComboBox.Enabled := lEditEnabled and not lCurRO;

 //MainForm.dxBarComboStyle.ReadOnly := not (lEditEnabled and not lCurRO);
 //MainForm.dxBarComboFontName.ReadOnly := not (lEditEnabled and not lCurRO);
 //MainForm.dxBarComboColor.ReadOnly := not (lEditEnabled and not lCurRO);
 //MainForm.dxBarComboFontSize.ReadOnly := not (lEditEnabled and not lCurRO);

 MainForm.seZoom.Enabled := lEditEnabled;
 //MainForm.dxseZoom.Enabled := lEditEnabled;

 vtVisibleAndEnabled(miText, lEditEnabled);
 vtVisibleAndEnabled(miTable, lEditEnabled);
 vtVisibleAndEnabled(acSetFrame, lEditEnabled);
 vtVisibleAndEnabled(acDelFrame, lEditEnabled);
 vtVisibleAndEnabled(acTranslate2Text, True);
 vtVisibleAndEnabled(pmTranslate2Text, True);

 vtVisibleAndEnabled(miInsertMenu, lEditEnabled);

 //vtVisibleAndEnabled(mi_SetSub, lEditEnabled);
 //vtVisibleAndEnabled(mi_RemoveSub, lEditEnabled);
 vtVisibleAndEnabled(miSetReference, lEditEnabled);


 lSubEditEnabled := Enabled and
                    ((l3TestMask(Document.LockMask, acgSub) and
                    ((ActiveControl = DocTextEditor.DocEditor) or
                     (ActiveControl = SprTextEditor.DocEditor))));
 lCurRO2 := not Enabled or not lSubEditEnabled or ReadOnly;

 vtVisibleAndEnabled(acSetSub, lEditEnabled and not lIsAnnoEditor and not lCurRO2);
 vtVisibleAndEnabled(acDelSub, lEditEnabled and not lIsAnnoEditor and not lCurRO2);

 vtVisibleAndEnabled(acPMSubDelete, (lEditEnabled and not lIsAnnoEditor and not lCurRO2) or ((ActiveControl = SubList) and not ReadOnly));
 vtVisibleAndEnabled(acPMSubEditName, (lEditEnabled and not lIsAnnoEditor and not lCurRO2) or ((ActiveControl = SubList) and not ReadOnly));

 lBlockEditEnabled := Enabled and
                      ((l3TestMask(Document.LockMask, acgBlock) and
                      ((ActiveControl = DocTextEditor.DocEditor) or
                      (ActiveControl = SprTextEditor.DocEditor))));

 lCurRO2 := not Enabled or not lBlockEditEnabled or ReadOnly;

 vtVisibleAndEnabled(acDelAllBlocks, lEditEnabled and not lIsAnnoEditor and not lCurRO2);


 acTextReplace.Enabled := lEditEnabled;
 acRefReplace.Enabled := lEditEnabled;
 acSetReferenceBegin.Enabled := lEditEnabled;
 //acSetReferenceEnd.Enabled := lEditEnabled;

 //TvtMenuItem(miSetReferenceDirect).vtVisibleAndEnabled := lEditEnabled;
 vtVisibleAndEnabled(mi_RemoveReference, lEditEnabled);

 //TvtMenuItem(miHyperText).vtVisibleAndEnabled := lEditEnabled;

 vtVisibleAndEnabled(miSearch, lEditEnabled);

 vtVisibleAndEnabled(miTranformText, lEditandMemoEnabled);
 vtVisibleAndEnabled(miAnaliseParam, lEditEnabled);
 vtVisibleAndEnabled(miFindTNVED, lEditEnabled);
 vtVisibleAndEnabled(miSetVChanged, Enabled and not ReadOnly);
 vtVisibleAndEnabled(miSetVLControl, Enabled and not ReadOnly);
 vtVisibleAndEnabled(miUrOpSetAbolished, Enabled and not ReadOnly);
 vtVisibleAndEnabled(miSetMOJNotReg, Enabled and not ReadOnly);

 if lEditandMemoEnabled then
  with ActiveControl as TevCustomEditor do
  begin
   MainForm.FreezeFontCombo := True;
   try
    MainForm.acShowSpecSymbol.Checked := Canvas.DrawSpecial;
   finally
    MainForm.FreezeFontCombo := False;
   end;
  end;

 if lEditEnabled then
  with ActiveControl as TevEditor do
  begin
   MainForm.acShowSpecSymbol.Checked := Canvas.DrawSpecial;
   //MainForm.acPreviewMode      .Checked := TextSource.DocumentContainer.Preview;
   MainForm.acWebStyle.Checked := WebStyle;
   MainForm.acShowSelect.Checked := evNeedExcludeWords(ActiveControl as TevEditor);
   MainForm.acShowDocumentParts.Checked := evGetShowDocumentParts(ActiveControl as TevEditor);

   {seZoomExit(CurEditor);}

   MainForm.seZoom.AsInteger := Canvas.Zoom;
   //MainForm.dxseZoom.Value := Canvas.Zoom;
  end;

 MainForm.sbShowClassTree.Enabled := (Enabled and ((ActiveControl = SubAttrExplorer.otlAttributes) or (ActiveControl = cbClassSubs) or (ActiveControl = DocTextEditor.DocEditor))) and not ReadOnly and ((Document.LockMask and acgClass) <> 0);
 MainForm.sbShowKWTree.Enabled := (Enabled and ((ActiveControl = SubAttrExplorer.otlAttributes) or (ActiveControl = cbClassSubs) or (ActiveControl = DocTextEditor.DocEditor))) and not ReadOnly and ((Document.LockMask and acgKeyWord) <> 0);

 MainForm.sbListToDocSet.Enabled := (Enabled and
  ((ActiveControl = ParentDocList) or
   (ActiveControl = ChildDocOutliner) or
   (ActiveControl = lstVersion)));

 MainForm.acPrintAll.Enabled := (Enabled and
  ({(ActiveControl = ParentDocList) or
   (ActiveControl = ChildDocOutliner) or}
   (ActiveControl = lstVersion)));

 if ReadOnly then
  tblStage.Access := otxReadOnly
 else
  tblStage.Access := otxNormal;

 if not FGroupMode and Enabled then
  SetReadOnlyMask(Document.LockMask);
end;

procedure TDocEditorWindow.SetReadOnlyMask(aLockMask: Longint);
var
 CurRO : Boolean;
 //lHyperlinkCurRO : Boolean;
 lDocIsText : Boolean;
 lAttrIDSet : TdtAttributeSet;

begin
 if Application.Terminated then
  Exit;

 {Attributes}
 CurRO := not l3TestMask(aLockMask, acgNameAttr);
 FullNameMEdit.ReadOnly := CurRO;
 ShortNameEdit.ReadOnly := CurRO;
 CommentEdit.ReadOnly := CurRO;
 vtVisibleAndEnabled(miSetKeyType, not CurRO);

 //edtExpiredDate.ReadOnly  := CurRO or (DocServ.DocType <> Dt_Const.tText);
 //edtActivatedDate.ReadOnly := CurRO or (DocServ.DocType <> Dt_Const.tText);

 lDocIsText := fGroupMode or (Document.DocClass = Dt_Types.dtText);

 //edtExpiredDate.ReadOnly  := CurRO or not lDocIsText;
 //edtActivatedDate.ReadOnly := CurRO or not lDocIsText;

 cbxChargeFree.Enabled := not CurRO and lDocIsText;
 cbxNotTM.Enabled := not CurRO and lDocIsText;
 cbxNoCompare.Enabled := not CurRO and lDocIsText;
 cbxInternet.Enabled := not CurRO and lDocIsText;
 cbxHang.Enabled := not CurRO and lDocIsText;

 cbUserType.Enabled := not CurRO and lDocIsText;
 edtDocID.ReadOnly := CurRO;
 edtSprDocID.ReadOnly:= CurRO or not lDocIsText;
 cbUrgency.Enabled := not CurRO and lDocIsText;

 //edtExpiredDate.ReadOnly  := CurRO or not lDocIsText;
 //edtActivatedDate.ReadOnly:= CurRO or not lDocIsText;
 //cbxExpired.Enabled       := Not CurRO and lDocIsText;
 //cbxActivated.Enabled     := Not CurRO and lDocIsText;

 vtVisibleAndEnabled(acPMSubAncorSetType, not CurRO);
 //piCut.Enabled            := Not CurRO;
 //piPaste.Enabled          := Not CurRO;

 //SetTreeListFlags(nfReadOnly, CurRO, cAllAttrIDSet);
 if CurRO then
  lAttrIDSet := CdtAllAttributes
 else
  lAttrIDSet := [];

 {Text & Spravka}
 CurRO := not l3TestMask(aLockMask, acgText);
 DocTextEditor.ReadOnly := CurRO;
 //AnnoTextEditor.ReadOnly := CurRO;
 if Document.IsPossibleSpr and Document.HasSpravka then
  SprTextEditor.ReadOnly := CurRO;
 //vtVisibleAndEnabled(miInsertDictText, not CurRO);
 //SetEditorReadOnly(CurRO);

 vtVisibleAndEnabled(acSetSharpReference, not CurRO);

 {Anno}
 if nbkDocPages.PagesVisible[piAnno] then
 begin
  CurRO := not l3TestMask(aLockMask, acgAnno);
  //SetTreeListFlags(nfReadOnly, CurRO, [aidAnnoClasses]);
  if CurRO then
   lAttrIDSet := lAttrIDSet + GlAnnoDictSet
  else
   lAttrIDSet := lAttrIDSet - GlAnnoDictSet;

  AnnoTextEditor.ReadOnly := CurRO;
  edtAnnoName.ReadOnly := CurRO;
  vtVisibleAndEnabled(miSetAnnoDate, not CurRO);
  vtVisibleAndEnabled(miSetAnnoClass, not CurRO);
  vtVisibleAndEnabled(miDelAnno, not CurRO);
 end;

 {Text & Spravka OR Anno}
 CurRO := not (l3TestMask(aLockMask, acgText) or l3TestMask(aLockMask, acgAnno));
 SetEditorReadOnly(CurRO);
 vtVisibleAndEnabled(miInsertDictText, not CurRO);

 {Hyperlink}
 CurRO := not l3TestMask(aLockMask, acgHyperLink);
 //lHyperlinkCurRO := CurRO;

 vtVisibleAndEnabled(piSetReference, not CurRO);
 vtVisibleAndEnabled(miSetReference, not CurRO);
 acSetReferenceBegin.Enabled := not CurRO;
 vtVisibleAndEnabled(acLinkDelete, not CurRO);
 vtVisibleAndEnabled(acLinkDeleteContext, not CurRO);
 vtVisibleAndEnabled(acReplaceHRefDocForBlockCorrespondents, not CurRO);
 //acSetSharpReference.Enabled := Not CurRO;
 vtVisibleAndEnabled(acLinkSet, not CurRO);
 vtVisibleAndEnabled(acLinkSetManually, not CurRO);

 {Block}
 CurRO := not l3TestMask(aLockMask, acgBlock);

 vtVisibleAndEnabled(acSetBlock, not CurRO);
 vtVisibleAndEnabled(acDelAllBlocks, not CurRO);
 acPMBTreeDelete.Enabled := not CurRO;

 acInsCreateStructure.Enabled := not CurRO;
 //vtVisibleAndEnabled(acPMSubAncorLinkExtObject, not CurRO); //первая группа подключает

 {Sub}
 CurRO := not l3TestMask(aLockMask, acgSub);
 acSubNameCorrect.Enabled := not CurRO;
 vtVisibleAndEnabled(acPMSubAncorSetTOC, not CurRO);

 //vtVisibleAndEnabled(miSetSub, not CurRO);
 //vtVisibleAndEnabled(mi_SetSub, not CurRO);
 //vtVisibleAndEnabled(mi_RemoveSub, not CurRO);
 //acSetSub.Enabled := not CurRO;
 piSubNameEdit.Enabled := not CurRO;

 //acSetReferenceEnd              .Enabled := Not CurRO;
 //vtVisibleAndEnabled(miSetReferenceDirect, Not CurRO);
 //vtVisibleAndEnabled(miHyperText, Not CurRO);

 N8.Visible := (aLockMask and (acgSub or acgBlock or acgHyperLink)) <> 0;

 {KeyWord}
 CurRO := not l3TestMask(aLockMask, acgKeyWord);
 {MainForm.sbShowKWTree.Enabled := Not CurRO;}
 //SetTreeListFlags(nfReadOnly, CurRO, [aidKeyWords]);
 if CurRO then
  lAttrIDSet := lAttrIDSet + GlKWDictSet
 else
  lAttrIDSet := lAttrIDSet - GlKWDictSet;

 vtVisibleAndEnabled(miSetKeyWord, not CurRO);
 vtVisibleAndEnabled(miSetKWOnSub, not CurRO);
 {miAddKeyFromDoc.Enabled:=False;}

 {Class}
 CurRO := not l3TestMask(aLockMask, acgClass);
 {MainForm.sbShowClassTree.Enabled := Not CurRO;}
 //SetTreeListFlags(nfReadOnly, CurRO, [aidClasses, aidPrefixes, aidTerritories, aidNorms]);
 //SetTreeListFlags(nfReadOnly, True, [aidAutoClasses]);
 if CurRO then
  lAttrIDSet := lAttrIDSet + GlClassDictSet
 else
  lAttrIDSet := lAttrIDSet - GlClassDictSet;

 //vtVisibleAndEnabled(miEditClassTree, Not CurRO;
 //vtVisibleAndEnabled(miDelDocClass,   Not CurRO;

 vtVisibleAndEnabled(acPMTextSetClass, not CurRO);
 vtVisibleAndEnabled(acPMTextSetPrefix, not CurRO);
 vtVisibleAndEnabled(acPMSubAncorSetClass, not CurRO);
 vtVisibleAndEnabled(acPMSubAncorSetPrefix, not CurRO);

 {Group}
 CurRO := not l3TestMask(aLockMask, acgAccGroup);
 //SetTreeListFlags(nfReadOnly, CurRO, GlDocGroupSet);
 if CurRO then
  lAttrIDSet := lAttrIDSet + GlDocGroupSet
 else
  lAttrIDSet := lAttrIDSet - GlDocGroupSet;

 //DocGroupList.ReadOnly := CurRO;

 {Jur Operation}
 CurRO := not l3TestMask(aLockMask, acgJurOp);

 vtVisibleAndEnabled(miSetVLControl, not CurRO);
 vtVisibleAndEnabled(miSetVChanged, not CurRO);
 vtVisibleAndEnabled(miUrOpSetAbolished, not CurRO);
 vtVisibleAndEnabled(miSetMOJNotReg, not CurRO);
 vtVisibleAndEnabled(miDelJournalRec, l3TestPartMask(aLockMask, acgJurOp or acgAnno));

 vtVisibleAndEnabled(miUrOpMakeFullEdition, not CurRO);
 vtVisibleAndEnabled(miUrOpMakeOldEdition, not CurRO);
 vtVisibleAndEnabled(acSetIncludedStage, not CurRO);

 //vtVisibleAndEnabled(acLinkSetManually, not CurRO and not lHyperlinkCurRO);

 //SetTreeListFlags(nfReadOnly, CurRO, [aidVerLink, aidActiveIntervals, aidAlarm]);
 if CurRO then
  lAttrIDSet := lAttrIDSet + GlDocJurSet
 else
  lAttrIDSet := lAttrIDSet - GlDocJurSet;


 cbxIncDone.Enabled := not CurRO;

 edtPriorityID.Enabled   := not CurRO and (Document.UserType <> utEdition);
 cbxPriorityType.Enabled := edtPriorityID.Enabled;
 //cbxActivated.Enabled       := CurRO;
 //edtActivatedDate.Enabled   := CurRO;
 //cbxExpired.Enabled         := CurRO;
 //edtExpiredDate.Enabled     := CurRO;


 {Published}
 CurRO := not l3TestMask(aLockMask, acgPublished);
 if CurRO then
  lAttrIDSet := lAttrIDSet + GlDocPublSet
 else
  lAttrIDSet := lAttrIDSet - GlDocPublSet;

 {All}
 SetReadOnlyAttrInTree(lAttrIDSet);
 //SetTreeListFlags(nfReadOnly, lAttrIDSet);
end;

procedure TDocEditorWindow.SetReadOnlyAttrInTree(aReadOnlyDictSet : TdtAttributeSet);
//procedure TDocEditorWindow.SetTreeListFlags1(aFlags: Integer; aSetted: Boolean; aDictSet: TdtAttributeSet);
{ - выставление флагов для поддеревьев}
const
 cMode: array [Boolean] of Tl3SetBitType = (sbDeselect, sbSelect);
var
 lCurTree : Il3Tree;
 
 function IterHandler(CurNode: Il3Node): Boolean; far;
 begin
  with (CurNode as Il3HandleNode) do
   lCurTree.SetFlagMask(CurNode, nfReadOnly, cMode[(TdtAttribute(Handle) in aReadOnlyDictSet)]);
 end;

begin
 try
  Screen.Cursor := crHourGlass;
  lCurTree := MainAttrExplorer.otlAttributes.CTree;
  MainAttrExplorer.otlAttributes.IterateF(Tl3NodeAction(l3L2FA( @IterHandler)), imOneLevel);
  lCurTree := SubAttrExplorer.otlAttributes.CTree;
  SubAttrExplorer.otlAttributes.IterateF(Tl3NodeAction(l3L2FA( @IterHandler)), imOneLevel);
 finally
  Screen.Cursor := crDefault;
 end;
end;

function TDocEditorWindow.Execute: Boolean;
var
 F : TForm;
 I : Integer;

 function lp_CheckModalInScript: Boolean;
 begin
  Result := False;
  {$IFDEF InsiderTest}
  if Tl3BatchService.Instance.IsBatchMode then
  begin
   if Tl3BatchService.Instance.HasModalWorker then
    if Tl3BatchService.Instance.ExecuteCurrentModalWorker then
    begin
     if (ModalResult = 0) then
      Result := True;
    end//seExecuteCurrentModalWorker
    else
    begin
     Result := True;
   end;//seExecuteCurrentModalWorker
  end;
  {$ENDIF InsiderTest}
 end;

begin
 for I := 0 to Pred(MainForm.MDIChildCount) do
 begin
  F := MainForm.MDIChildren[I];
  if F <> Self then
   MainForm.MDIChildren[I].Enabled := False;
 end;
 FModalMode := True;
 //MainForm.sbShowWarning.Enabled := False;
 ModalResult := 0;
 repeat
  Application.HandleMessage;
  if Application.Terminated then
   ModalResult := mrCancel;
  if lp_CheckModalInScript then Break; 
 until ModalResult <> 0;
 ModalButtonPanel.Free;
 Result := ModalResult = mrOk;
 FModalMode := False;

 for I := 0 to Pred(MainForm.MDIChildCount) do
  MainForm.MDIChildren[I].Enabled := True;
end;

function TDocEditorWindow.ExecuteGroupMode(ADMode: TOperActionType): Boolean;
var
 I : Integer;
 lAttrSet : TdtAttributeSet;
begin
 fGroupMode := True;

 Document.MakeNew(dtGroupOp);

 SetReadOnlyMask(Longint($FFFFFFFF));

 ModalButtonPanel.Visible := True;

 nbkDocPages.PageIndex := piAttr;

 edtDocID.Enabled := False;
 edtSprDocID.Enabled := False;
 cbUserType.Enabled := False;
 cbUrgency.Enabled := False;
 //edtPriorityID.Enabled := False;
 cbxPriorityType.Enabled := False;

 case ADMode of
  atAdd:
  begin
   Exclude(GroupModeDisable, piName);
   Exclude(GroupModeDisable, piJourn);
   lAttrSet := GlMainAttrSetForGroupAdd - HiddenAttr;
  end;

  DT_Types.atDelete:
  begin
   Include(GroupModeDisable, piName);
   Include(GroupModeDisable, piJourn);
   lAttrSet := GlMainAttrSetForGroupDel - HiddenAttr;
  end;
 end;

 for I := 0 to nbkDocPages.Pages.Count do
  if I in GroupModeDisable then
   nbkDocPages.PagesVisible[I] := False;

 if ADMode = DT_Types.atDelete then
  nbkJournals.PagesVisible[1] := False;
 for I := 2 to Pred(nbkJournals.Pages.Count) do
  nbkJournals.PagesVisible[I] := False;

 MainAttrExplorer.AttrManager.AttrOperateMode := aomGroupEdit;
 MainAttrExplorer.AttrSet := lAttrSet;

 nbkDocPages.Visible := True;

 tblStage.RowLimit := Ord(High(TStageType));

 cbxChargeFree.AllowGrayed := True;
 cbxNotTM     .AllowGrayed := True;
 cbxNoCompare .AllowGrayed := True;
 cbxInternet  .AllowGrayed := True;
 cbxHang      .AllowGrayed := True;
 cbxChargeFree.State := cbGrayed;
 cbxNotTM     .State := cbGrayed;
 cbxNoCompare .State := cbGrayed;
 cbxInternet  .State := cbGrayed;
 cbxHang      .State := cbGrayed;

 fStructInit := True;

 Result := Execute;
 {FormStyle:=fsNormal;}
 Hide;
 SaveDocParam;
end;

procedure TDocEditorWindow.VisibleChanging;
begin
 if not fGroupMode then
  inherited VisibleChanging;
end;

procedure TDocEditorWindow.GetGroupData(var GData: TGroupData);
var
 I : Longint;
 lStatus : Integer;
begin
 l3FillChar(GData, SizeOf(TGroupData));

 with GData do
 begin
  if FullNameMEdit.Buffer.SLen > 0 then
   FullName := l3GetStrPas(FullNameMEdit.Buffer.S);
  //ShortName := l3GetStrPas(ShortNameEdit.Buffer.S);

  //StatusSetted := (cbxChargeFree.Tag = 1) or (cbxNotTM.Tag = 1) or (cbxNoCompare.Tag = 1);

  lStatus := 0;
  StatusSetted := 0;

  if cbxChargeFree.State <> cbGrayed then
  begin
   l3SetMask(StatusSetted, dstatChargeFree);
   if cbxChargeFree.State = cbChecked then
    l3SetMask(lStatus, dstatChargeFree);
  end;

  if cbxNotTM.State <> cbGrayed then
  begin
   l3SetMask(StatusSetted, dstatNotTM);
   if cbxNotTM.State = cbChecked then
    l3SetMask(lStatus, dstatNotTM);
  end;

  if cbxNoCompare.State <> cbGrayed then
  begin
   l3SetMask(StatusSetted, dstatNoCompare);
   if cbxNoCompare.State = cbChecked then
    l3SetMask(lStatus, dstatNoCompare);
  end;

  if cbxInternet.State <> cbGrayed then
  begin
   l3SetMask(StatusSetted, dstatInternet);
   if cbxInternet.State = cbChecked then
    l3SetMask(lStatus, dstatInternet);
  end;

  if cbxHang.State <> cbGrayed then
  begin
   l3SetMask(StatusSetted, dstatHang);
   if cbxHang.State = cbChecked then
    l3SetMask(lStatus, dstatHang);
  end;

  Status := lStatus;

  UserTypeSetted := cbUserType.Tag = 1;
  if UserTypeSetted then
   UserType := TUserType(cbUserType.ItemIndex);

  if edtPriorityID.Modified then
   rPriority := edtPriorityID.AsInteger
  else
   rPriority := 0;
 end;
end;

function TDocEditorWindow.IsNeedSaveDocument: Boolean;
begin
 Result := not ReadOnly and Document.DataWasLoaded and (
  (ShortNameEdit.Modified) or (Document.IsModified) or (edtAnnoName.Modified) or
  (CommentEdit.TextSource.Modified) or
  ((Document.HasSpravka and (Document.Spravka.HasTextSource) and (Document.Spravka.IsModified)) or
  (IsNewDoc and Document.IsPossibleSpr) or IsObjChanged) or IsDocParamChange);
end;

function TDocEditorWindow.TextSourcesCloseQuery: Boolean;
begin
 Result := (Document.TextSource = nil) or Document.TextSource.CloseQuery(Handle) and
  ( not Document.HasSpravka or not (Document.Spravka.HasTextSource) or
  //not Document.Spravka.TextSource.HasDocument or
  Document.Spravka.TextSource.CloseQuery(Handle));
end;

function TDocEditorWindow.CloseQuery: Boolean;
begin

 if TSpellCheckDlg.IsSpellCheckInProgress then
 begin
  Result := False;
  TSpellCheckDlg.InterruptSpellCheck(Handle);
  Exit; // окно проверки орфографии позаботится о закрытии окна редактора
 end;

 if TTextSearchDlg.IsInReplaceLoop then
 begin
  Result := False;
  TTextSearchDlg.HideFindContext;
  TTextSearchDlg.ClientFormClosed(Self);
  Exit; // окно поиска и замены позаботится о закрытии окна редактора
 end;

 tblStage.StopEditingState(True);

 if fGroupMode then
  Result := True
 else
  Result := inherited CloseQuery;

 if Result then
  fLoadStopLog := True;

 l3System.Msg2Log('CloseDoc #%d', [Document.DocID]);
end;

procedure TDocEditorWindow.FormDestroy(Sender: TObject);
begin
 l3Free(UndoBrowser);
 fCurrentTarget := nil;
 //MainForm.OEWin.DelFromExplorer(eotDocument, Longint(Self));
 ModalResult := mrOk;
 //l3Free(JrnlList);
 l3Free(fSelectedSubList);
 CleanupTempImgFile;
end;

procedure TDocEditorWindow.SetDocName(const aValue : AnsiString);
begin
 Inherited SetDocName(TrunkDocName(aValue));
end;

function TDocEditorWindow.CheckEditor: Boolean;
begin
 Result := (ActiveControl is TevEditor) or
  (ActiveControl is TevEdit) or
  (ActiveControl is TevMemo) or
  (ActiveControl is TOvcBaseEntryField);
end;

procedure TDocEditorWindow.CheckRequiredFields;
var
 l_CheckTypeBlock: IarCheckLeftOrRightBlock;
begin
 with Document do
 begin
  if (fDocClass in [Dt_Types.dtObject, Dt_Types.dtFlash]) then
   if (Document.AttrManager.GetDocAttribute(atStages) as IStageDocAttributeTool).CheckStageClosed(stEdit) and
   (Document.ShortName.SLen = 0) then
    raise ERequiredFieldsEmpty.CreateFmt(sidNonDefProp, [scShortName]);

   if (ShortNameEdit.TextLen > cShortNameSize) then
    raise ERequiredFieldsEmpty.CreateFmt(sidOverSizeProp, [scShortName]);

  if (FullNameMEdit.TextLen > cUserFullNameSize) then
   raise ERequiredFieldsEmpty.CreateFmt(sidOverSizeProp, [scFullName]);

  if (Document.UserDocID <= 0) then
   raise ERequiredFieldsEmpty.CreateFmt(sidNonDefProp, [scDocID]);

  if Document.HasSpravka and (Document.Spravka.UserDocID <= 0) then
   raise ERequiredFieldsEmpty.CreateFmt(sidNonDefProp, [scSprID]);
 
  if (UserType in [utAAK_Cont, utAAK_Doc]) then
   if Supports(TextSource.DocumentContainer, IarCheckLeftOrRightBlock, l_CheckTypeBlock) then
    try
     if not l_CheckTypeBlock.HasAACBlock(True) then
      raise ERequiredFieldsEmpty.CreateFmt(sidAACLeftBlockNotPresent, []);
     if not l_CheckTypeBlock.HasAACBlock(False) then
      raise ERequiredFieldsEmpty.CreateFmt(sidAACRightBlockNotPresent, []);
    finally
     l_CheckTypeBlock := nil;
    end;
 end;
end;

function  TDocEditorWindow.evntDocTextSave(aPart: Tm3DocPartSelector; aFullSave: Boolean) : Boolean;
var
 lStr : AnsiString;
begin
 Result := inherited evntDocTextSave(aPart, aFullSave);
 if not Result then Exit;

 if (aPart = m3_dsMain) then
 begin
  //проверка номеров топиков для встроенных картинок
  try
   CheckExternalHandlesInBitmapParagraphs(Document.TextSource.Document.AsObject);
  except
   on EHTErrors do
   begin
    vtMessageDlg(l3CStr('Не удаётся назначить ID для изображения! Обратитесь в службу поддержки.'), mtError);
    Result := false;
   end;
  end;

  //запись на диск допю копии для набивальщиков
  try
   if Length(IniRec.DocOnDiskDir) > 0 then
   begin
    try
     lStr := ConcatDirName(IniRec.DocOnDiskDir, format('%d.evd', [Document.UserDocID]));
     Document.TextSource.SaveTextToFile(lStr, ftEverest);
    finally
     lStr := ConcatDirName(IniRec.DocOnDiskDir, format('%d.txt', [Document.UserDocID]));
     Document.TextSource.SaveTextToFile(lStr, ftOEMText);
    end;
   end;
  except
   on E: Exception do
    begin
     Application.ShowException(E);
     l3System.Exception2Log(E);
    end;
  end;
 end;
end;

procedure TDocEditorWindow.SaveDocParam;
 var
  CCInd, PIInd : Integer;
  lSK : Integer;
  lStatus : Integer;
  lStatusMask : Integer;

 begin
  tblStage.StopEditingState(True);
  with Document do
  begin
   lStatus := 0;
   lStatusMask := 0;

   if cbxChargeFree.State <> cbGrayed then
   begin
    l3SetMask(lStatusMask, dstatChargeFree);
    if cbxChargeFree.State = cbChecked then
     l3SetMask(lStatus, dstatChargeFree);
   end;

   if cbxNotTM.State <> cbGrayed then
   begin
    l3SetMask(lStatusMask, dstatNotTM);
    if cbxNotTM.State = cbChecked then
     l3SetMask(lStatus, dstatNotTM);
   end;

   if cbxNoCompare.State <> cbGrayed then
   begin
    l3SetMask(lStatusMask, dstatNoCompare);
    if cbxNoCompare.State = cbChecked then
     l3SetMask(lStatus, dstatNoCompare);
   end;

   if cbxInternet.State <> cbGrayed then
   begin
    l3SetMask(lStatusMask, dstatInternet);
    if cbxInternet.State = cbChecked then
     l3SetMask(lStatus, dstatInternet);
   end;

   if cbxHang.State <> cbGrayed then
   begin
    l3SetMask(lStatusMask, dstatHang);
    if cbxHang.State = cbChecked then
     l3SetMask(lStatus, dstatHang);
   end;

   Status := lStatus;
   if fGroupMode then
    StatusMask := lStatusMask;

   if cbUserType.ItemIndex >= 0 then
    UserType := TUserType(cbUserType.ItemIndex);
   if cbUrgency.ItemIndex >= 0 then
    Urgency  := cbUrgency.ItemIndex;

   SetPriority(edtPriorityID.AsInteger, cbxPriorityType.Checked);

   //Priority := edtPriorityID.AsInteger;
   //PriorFlag := cbxPriorityType.Checked;

   ShortName := l3PCharLen(l3DeleteDoubleSpace(l3CStr(ShortNameEdit.Buffer)));

   Name := FullNameMEdit.Buffer;

   DocComment := CommentEdit.Buffer;
  end; //with Document do

  if edtAnnoName.Modified {.Tag = 1} then
  begin
   Document.AnnoName := Tl3PCharLen(edtAnnoName.Buffer);
   edtAnnoName.Modified := false;
  end;

  if (ShortNameEdit.TextLen <= cShortNameSize) then
   ShortNameEdit.Modified := False;

  if (FullNameMEdit.TextLen <= cFullNameSize) then
   FullNameMEdit.TextSource.Modified := False;

  if (CommentEdit.TextLen <= cFullNameSize) then
   CommentEdit.TextSource.Modified := False;

  cbxChargeFree.Tag := 0;
  cbxNotTM.Tag := 0;
  cbxNoCompare.Tag := 0;
  cbxInternet.Tag := 0;
  cbxHang.Tag := 0;

  cbUserType.Tag := 0;
  cbUrgency.Tag := 0;
  edtPriorityID.Modified := False;
 end;

procedure TDocEditorWindow.SaveDocument(aFullSave: Boolean = True);
var
 l_StagesTool : IStageDocAttributeTool;

{$IfDef DocSaveTrace}
const
 cBoolStr : array [boolean] of AnsiString = ('False', 'True');
{$EndIf}

begin
 {$IfDef DocSaveTrace}
  l3System.Msg2Log('SaveDoc: DocID=%d, Full=%s', [Document.DocID, cBoolStr[aFullSave]]);
 {$EndIf}

 // Принудительная запись редактируемых данных
  if ActiveControl <> nil then
   ActiveControl.Perform(CM_Exit, 0, 0);

 StopAutoSave;
 try
  Screen.Cursor := crHourGlass;

  { <K 87195812>
  if IsNewDoc and aFullSave then // новый документ и НЕ автосохранение
   CheckForCourtCase;
  }

  // если был закрыт этап "Начальная юробработка", то проверить на принадлежность
   // к изменяющим документам и проставить нужный usertype (K 77758589)
   l_StagesTool := (Document.AttrManager.GetDocAttribute(atStages) as IStageDocAttributeTool);
   if (not f_IsJurStageClosed) and (l_StagesTool.CheckStageClosed(stUrObr)) then
    if GetIZMChecker.CheckoutForIZM(Document.DocID) then
     cbUserType.ItemIndex := Integer(utIZM);

  try
   SaveDocParam; //перекладываем параметры шапки из контролов в EVD

   if aFullSave and not l3System.Keyboard.Key[VK_SHIFT].Down then //для отладки проблем с пользовательскими номерами
    CheckRequiredFields;


   if aFullSave and Document.HasSpravka and
      not Document.IsPossibleSpr and
      (IsNewDoc or (vtMessageDlg(l3CStr(@sidDelWrongSprAsk), mtWarning, [mbYes, mbNo]) = mrYes)) then
     Document.DeleteSpr;

   if IsNeedSaveSpr or IsNewDoc or Document.IsModified or IsObjChanged then
    Document.Save(aFullSave);

   if aFullSave then // при автосохранении флажок IsNewDoc не сбрасываем
    IsNewDoc := False;

   Windows.SendMessage(Application.MainForm.Handle, wm_RefreshDocs, 0, 0);

  finally
   Screen.Cursor := crDefault;
  end;
 finally
  StartAutoSave;
 end;
end;

function TDocEditorWindow.SetSubPrim(aSubType     : TSubType;
                                     aAutoMode    : Boolean = False;
                                     aWithConfirm : Boolean = True;
                                     const aBlock : IevCommonDataObject = nil;
                                     const aSubNumFormula: AnsiString = ''): ShortInt;
var
 l_Change  : Boolean;
 l_SubParam: TevSetSubParam;
begin
 try
  StopAutoSave;
  try
   l_SubParam.rEditor := CurEditor;
   l_SubParam.rSubType := aSubType;
   l_SubParam.rCodePage := GlobalDataProvider.BaseLanguage[DocFamily].AnsiCodePage;
   l_SubParam.rAutoMode := aAutoMode;
   l_SubParam.rWithConfirm := aWithConfirm;
   l_SubParam.rSubNumFormula := aSubNumFormula;
   l_SubParam.rUserType := Document.UserType;
   l_SubParam.rCanStylizeBlocks := f_CanStylizeBlocks;
   Result := evSetSubPrim(l_SubParam, l_Change, aBlock);
   if l_Change then
   begin
    Document.AddLog(acTextWork);
    AfterHyperTextAction(haSub);  //??
   end;
  finally
   StartAutoSave(False);
  end;{try..finally}
 except
  on E : EHtErrors do
   if E.ErrorValue = HT_ERR_KEY_DOUBLET then
    vtMessageDlg(str_sidNonUniqSubNumber.AsCStr, mtError)
   else
    raise;
 end;
end;

procedure TDocEditorWindow.SubNameEdit(aSubID: TSubID);
var
 l_Param  : TevSubEditParam;
 l_Change : Boolean;
begin
 LoadPage(piSub);
 l_Param.rEditor := CurEditor;
 l_Param.rSubID := aSubID;
 l_Param.rUserType := Document.UserType;
 l_Param.rCanStylizeBlocks := f_CanStylizeBlocks;
 l_Param.rIsDocEditor := CurEditor = DocTextEditor.DocEditor;
 l_Param.rSubList := SubList;
 l_Param.rFamilyID := DocFamily;
 l_Param.rDocID := CurDocument.DocID;
 evSubNameEdit(l_Param, l_Change);
 if l_Change then
  Document.AddLog(acHLWork);
 if l_Param.rIsDocEditor then
  DocTextEditor.SubShowPanel.Refresh;
end;

procedure TDocEditorWindow.acSetSubClick(Sender: TObject);
begin
 SetSubPrim(stSub);
end;

procedure TDocEditorWindow.acDelAllBlocksExecute(Sender: TObject);
var
 lSaveReadOnly : Boolean;
begin
 if vtMessageDlg(l3CStr(@sidQstDelAllBlocks), mtConfirmation, [mbYes, mbNo]) <> mrYes then Exit;

 lSaveReadOnly := DocTextEditor.DocEditor.ReadOnly;
 try
  DocTextEditor.DocEditor.ReadOnly := False;
  evFacadeSub.EvDeleteAllDocumentParts(CurEditor);
 finally
  DocTextEditor.DocEditor.ReadOnly := lSaveReadOnly;
 end;
end;

procedure TDocEditorWindow.acSetBlockExecute(Sender: TObject);
begin
 SetSubPrim(stBlock);
end;

function TDocEditorWindow.SubReplaceFunc(const aBlock   : InevRange;
                                         aSubNumFormula : AnsiString;
                                         aWithConfirm   : Boolean): ShortInt;
begin
 Result := SetSubPrim(stSub, True {aAutoMode}, aWithConfirm, aBlock.Data, aSubNumFormula);
end;

procedure TDocEditorWindow.evntFinishReplace(Sender: TObject; ReplaceCount: Longint);
begin
 if Sender is TevSubReplacer then
  AfterHyperTextAction(haSub)
 else
 if Sender is TevCustomHyperLinkReplacer then
  AfterHyperTextAction(haReference);
end;

procedure TDocEditorWindow.AfterHyperTextAction(haType: THyperTextActionSet;
 aSubFlagRebuild: Boolean = False);
var
 SL : Tl3StringDataList;
 tPage : Longint;

begin
 Document.AddLog(acHLWork);

 if (haType = haSub) then
 begin
  if CurEditor = DocTextEditor.DocEditor then
  begin
   SL := SubList.Items;
   LinkServer(DocFamily).SubTbl.GetDocSub(DocID, SL);
   SubList.Items := SL;

   {if aSubFlagRebuild then
    ReBuildSubFlags;}

   if PageLoad[piClass] then
   begin
    PageLoad[piClass] := False;
    if (AlonePageIndex = piClass) or
     (nbkDocPages.PageIndex = piClass) then
     LoadPage(piClass, -1);
   end;
  end;
 end;
end;

procedure TDocEditorWindow.acDelSubExecute(Sender: TObject);
begin
 RemoveSub( -1, -1);
end;

procedure TDocEditorWindow.RemoveSub(SubNum: Tl3Handle; Item: Longint);
var
 l_Sub : IevSub;
 lBlock : IevDocumentPart;
 lSaveReadOnly : Boolean;
 lPack : InevOp;  
 l_CheckTypeBlock: IarCheckLeftOrRightBlock;
begin
 StopAutoSave;
 try
  if (SubNum = -1) then
  begin
   if not l3IOk(evMostInnerCursor(CurEditor).QueryInterface(IevSub, l_Sub)) then
    Exit;
   SubNum := l_Sub.ID;
  end
 else 
  l_Sub := evGetSubList(CurEditor.TextSource).Sub[SubNum];
  if SubNum <= 0 then
   Exit;
  lBlock := evGetSubList(CurEditor.TextSource).Block[SubNum];

  if (lBlock <> nil) and (lBlock.Exists) then
  begin
   if ((lBlock.Flags and sfRTFImage) > 0) and
    (vtMessageDlg(l3CStr(@sidBlockAttrWillLost),
    mtConfirmation, [mbYes, mbNo], 0, mbNo) <> mrYes) then
     Exit;
   with lBlock do
   begin
    lSaveReadOnly := CurEditor.ReadOnly;
    try
     CurEditor.ReadOnly := False;
     lPack := CurEditor.StartOp(ev_ocUser + 100);
     try
      if evDeleteSub(CurEditor, lBlock) then
       SetTo(Cursor.AsObject);
      //if Supports(CurEditor.TextSource.DocumentContainer, IarCheckLeftOrRightBlock, l_CheckTypeBlock) then
      // l_CheckTypeBlock.ClearSubID(SubNum);
     finally
      lPack := nil; {FinishOp;}
     end;
    finally
     CurEditor.ReadOnly := lSaveReadOnly;
    end;
    Exit;
   end;{with Block}
  end;

  if LinkServer(DocFamily).HLinkTbl.CheckHLinkOnSub(CurDocument.DocID, SubNum) and
   (vtMessageDlg(l3CStr(@sidLinkedSubDelQst), mtConfirmation, [mbYes, mbNo]) <> mrYes) then
   Exit;

  Screen.Cursor := crHourGlass;
  try
   lSaveReadOnly := CurEditor.ReadOnly;
   try
    CurEditor.ReadOnly := False;
    evDeleteSub(CurEditor, l_Sub);
   finally
    CurEditor.ReadOnly := lSaveReadOnly;
   end;
   if CurEditor <> DocTextEditor.DocEditor then
    Exit;
   if Item = -1 then
    Item := SubList.Items.IndexOfData(SubNum, SizeOf(TSubID), 0);
   if Item >= 0 then
   begin
    SubList.Items.Delete(Item);
    if PageLoad[piClass] then
    begin
     if SubNum = SubAttrExplorer.CurSub then
      SubAttrExplorer.CurSub := 0;
    end;
   end;
  finally
   Screen.Cursor := crDefault;
  end;
 finally
  StartAutoSave(False);
 end;{try..finally}
end;

procedure TDocEditorWindow.PrintAll;

procedure AssignDocsListOflstVersion(aDocsList : TDocsList);
var
 lDocAddr : TDocAddr;
 I        : Longint;
begin
 for I := 0 to Pred(lstVersion.Total) do
 begin
  lDocAddr.FamID := DocFamily;
  lDocAddr.DocID := (Document.AttrManager.GetDocAttribute(atVersions) as IListDocAttribute).Handle[I];
  aDocsList.AddAddrToList(lDocAddr);
 end;
end;

var
 lDocsList : TDocsList;

begin
 if (Self.ActiveControl = ParentDocList) then
 begin
  //
 end
 else
 if (Self.ActiveControl = ChildDocOutliner) then
 begin
  //
 end
 else
 if (Self.ActiveControl = lstVersion) then
 begin
  lDocsList := TDocsList.Create;
  try
   AssignDocsListOflstVersion(lDocsList);
   if lDocsList.Count > 0 then ProcessDocs(lDocsList, daPrint);
  finally
   l3Free(lDocsList);
  end;
 end;

end;

procedure TDocEditorWindow.ListToDocSetBtnClick(Sender: TObject);
var
 l_ExtDocId: Integer;
begin
 with TSearchWin.Create(MainForm) do
 begin
  Family := DocFamily;
  l_ExtDocId := Document.UserDocID;

  if (Self.ActiveControl = ParentDocList) then
  begin
   ShowDocSet(Document.CorespondentsList.Docs);
   SrchName := Format('Корреспонденты документа N %d', [l_ExtDocId]);
  end
  else
   if (Self.ActiveControl = ChildDocOutliner) then
  begin
   ShowDocSet(Document.RespondentsList.Docs);
   SrchName := Format('Респонденты документа N %d', [l_ExtDocId]);
  end
   else
    if (Self.ActiveControl = lstVersion) then
  begin
   ShowDocSet((Document.AttrManager.GetDocAttribute(atVersions) as IVersionListAttributeTool).MakeDocSab);
   SrchName := Format('Редакции документа N %d', [l_ExtDocId]);
  end;
 end;
end;

procedure TDocEditorWindow.WMDropAccept(var Message: TMessage);
var
 Pt : Tl3SPoint;
 St : Tl3Handle;
 Sub : TevSubPanelSub;
 //CCRec      : TItemCountRec;
 CSub : Longint;
 I : Longint;
 DDRefAddr : TRefAddr;
 HLId : Tl3Handle;
 HL : IevHyperlink;
 AL : IevAddressList;
 lMainAttrTree : Boolean;
 lAttrExplorer : TAttrExplorer;
 lGetRefCnt : Integer;
 l_Tag: Il3TagRef;

 function lGetRefAddrFunc(var aCurRefAddr : TGlobalCoordinateRec) : Boolean;
 var
  ItData : PansiChar;
 begin
  Result := False;
  with TArchiObjectList(TDragDataSupport.Instance.DragData) do
  while (lGetRefCnt < Count) do
  begin
   ItData := Data[lGetRefCnt];
   Inc(lGetRefCnt);
   if (TDragDataType(ItData[0]) = ddBackHyperLink) then
   begin
    aCurRefAddr := PGlobalCoordinateRec(ItData + 1)^;
    Result := True;
    Exit;
   end;
  end;
 end;

var
 l_Editor: TevCustomEditor;
begin
 {ddBackHyperLink}
 if TDragDataSupport.Instance.DragDataType = Ord(ddBackHyperLink) then
 begin
  DDRefAddr.Family := DocFamily;

  if TControl(Message.lParam) is TevCustomEditor then
  begin
   l_Editor := TevCustomEditor(Message.lParam);
   with l_Editor do
   begin
    with Selection do
    begin
     evSaveBlock(l_Editor, DDRefAddr.Block, Mouse);
     try
      lGetRefCnt := 0;
      SetReferenceListF(DDRefAddr.Block, TGetRefAddrFunc(l3LocalStub(@lGetRefAddrFunc)));
     finally
      evFreeBlock(DDRefAddr.Block);
     end;{try..finally}
    end;{with Selection}
   end;{with (TControl(Message.lParam)..}
   TDragDataSupport.Instance.AnswerData := Nil;
   Message.Result := 1;
  end;
  Exit;
 end;

 {ddHyperLink}
 if TDragDataSupport.Instance.DragDataType = Ord(ddHyperLink) then
 begin
  TDragDataSupport.Instance.AnswerData := @DDHLink;
  DDHLink.Family := DocFamily;
  DDHLink.Doc := CurDocument.DocID;

  if TControl(Message.lParam) = SubList then
  begin
   I := SubList.MousePointToIndex;
   if I < 0 then
    Exit;
   Message.Result := 1;
   DDHLink.Sub := SubList.Items.DataInt[I];
   Exit;
  end;

  if TControl(Message.lParam) = otlBlocks then
  begin
   I := otlBlocks.MousePointToIndex;
   if I < 0 then Exit;

   if l3IOk(otlBlocks.CTree.CNodes[I].QueryInterface(Il3TagRef, l_Tag)) then
   try
    DDHLink.Sub := l_Tag.AsObject.IntA[k2_tiHandle];
    Message.Result := 1;
   finally
    l_Tag := nil;
   end;{try..finally};
   Exit;
  end;

  if (TControl(Message.lParam) = nbkDocPages) then
  begin
   I := nbkDocPages.MousePointToIndex;
   case I of
    piText :
     DDHLink.Doc := DocID;
    piSprv :
     DDHLink.Doc := SprDocID
   else
    Exit;
   end; //case

   Message.Result := 1;
   DDHLink.Sub := 0;
   Exit;
  end;

  if (TControl(Message.lParam) = ieView) then
  begin
   Message.Result := 1;
   DDHLink.Sub := 0;
   Exit;
  end;

  Message.Result := 1;

  if TControl(Message.lParam) is TevSubPanel then {SubShowPanel}
  begin
   f_SkipSubPanelClick := True;
   if TevSubPanel(Message.lParam) = SprTextEditor.SubShowPanel then
    DDHLink.Doc := Document.Spravka.DocID;
   with TevSubPanel(Message.lParam) do
   begin
    Pt.GetCursorPos;
    Pt.Convert(ScreenToClient);
    Sub := SubOnPoint(Pt, St);
    if (Sub <> nil) and (St = Ord(ev_sbtSub)) then
    begin
     DDHLink.Sub := Sub.Handle;
     Exit;
    end;
   end;
  end;
  Message.Result := 0;
  TDragDataSupport.Instance.AnswerData := Nil;
 end
 {ddDragObj ddDictItem ddDNDictItem}
 else
 if (TDragDataSupport.Instance.DragDataType = Ord(ddDragObj)) or
    (TDragDataSupport.Instance.DragDataType = Ord(ddDictItem)) then
 begin
  //CCRec.Current := 0;
  //CCRec.Count   := 0;
  I := 0;
  if TControl(Message.lParam) is TvtOutliner then
  begin
   lMainAttrTree := TControl(Message.lParam) = MainAttrExplorer.otlAttributes;
   if lMainAttrTree then
    lAttrExplorer := MainAttrExplorer
   else
    lAttrExplorer := SubAttrExplorer;
   lAttrExplorer.DDSupportDropAcceptHandler(I {CCRec.Count});
  end;

  if I = 0 {CCRec.Count = 0} then
   vtMessageDlg(l3CStr(@sidNotCompatibleData), mtError)
  else
   Message.Result := 1;
 end;
end;

procedure TDocEditorWindow.acSetReferenceEndExecute(Sender: TObject);
begin
 if not (TDragDataSupport.Instance.DragState in cnActiveState) or (TDragDataSupport.Instance.DragDataType <> Ord(ddHyperLink)) then
  Exit;

 TDragDataSupport.Instance.AnswerData := @DDHLink;
 DDHLink.Family := DocFamily;
 DDHLink.Doc := CurDocument.DocID;
 DDHLink.Sub := GetCurrentParaSubID;
 if DDHLink.Sub < 0 then
  Exit;

 TDragDataSupport.Instance.AnswerData := @DDHLink;
 TDragDataSupport.Instance.DoDrop;
end;

procedure TDocEditorWindow.GetAttrTreeListOnSub(aSubID : TSubID; aDictSet: TdtAttributeSet;
                                                aTreeSel: TTreeSelector{; aStopNotify: Boolean});
begin
 try
  Screen.Cursor := crHourGlass;

  if (aTreeSel in [tsAll, tsAttr]) then
   MainAttrExplorer.GetAttrTreeListOnSub(aSubID, aDictSet{, aStopNotify});

  if (aTreeSel in [tsAll, tsSubAttr]) then
   SubAttrExplorer.GetAttrTreeListOnSub(aSubID, aDictSet{, aStopNotify});

 finally
  Screen.Cursor := crDefault;
 end;
end;

procedure TDocEditorWindow.RefreshAttr(aSubID : TSubID; aDictSet : TdtAttributeSet;
                                       aTreeSel : TTreeSelector = tsAll);
begin
 try
  Screen.Cursor := crHourGlass;

  if (aTreeSel in [tsAll, tsAttr]) then
   MainAttrExplorer.RefreshAttr(aDictSet);

  if (aTreeSel in [tsAll, tsSubAttr]) and (SubAttrExplorer.CurSub = aSubID) then
   SubAttrExplorer.RefreshAttr(aDictSet);

 finally
  Screen.Cursor := crDefault;
 end;
end;

procedure TDocEditorWindow.LoadPage(Index: Integer; Param: Longint = 0);
var
 SL : Tl3StringDataList;
 NeedPageLoad : Boolean;
 AllowChange : Boolean;
 //TCur         : TTree;

 function GetDocDone : Boolean;
 begin
  Result := (Document.AttrManager.GetDocAttribute(atJurLogRecords) as ILogDocAttributeTool).HasDocThisLogRec(acIncluded);
 end;

 function FindSub(const Intf: Il3SimpleNode): Boolean;
 begin
  Result := (Intf as Il3HandleNode).Handle = Param;
 end;

begin
 if (PageLoad[Index] or FGroupMode) then
  exit;
 PageLoad[Index] := True;
 case Index of
  piName,
  piAttr:
  begin
   PageLoad[Index] := False;
   SetDocParam;
   PageLoad[Index] := True;
  end;

  piText: ;
  piSprv:
  begin
   if SprTextEditor.DocEditor.HasTextSource and
      not SprTextEditor.DocEditor.TextSource.Document.IsValid then
    LoadSpr
   else
    PageLoad[Index] := False;
  end;

  piAnno :
  begin
   LoadAnno;
  end;

  piClass:
  begin
   Screen.Cursor := crHourGlass;
   try
    
    if Param = -1 then
     Param := SubAttrExplorer.CurSub;

    with cbClassSubs do
    begin
     CurrentNode := TreeStruct.SimpleIterateF(l3L2SNA(@FindSub));
     if CurrentNode = nil then
      Param := 0;
     TreeStruct.ChangeExpand(TreeStruct.RootNode.Child, sbSelect); // первый уровень дерева всегда раскрыт
    end;
    
    SubAttrExplorer.CurSub := Param;

    //!!GetAttrTreeListOnSub(SubAttrExplorer.CurSub, SubAttrExplorer.AttrSet);
   finally
    Screen.Cursor := crDefault;
   end;
  end;

  piSrcImage:
  begin
   LoadTbCorSourcesChange(Self);
   cbCorSources.ItemIndex := 0;
   cbCorSourcesChange(Self);
  end;

  piSub:
  begin
   Screen.Cursor := crHourGlass;
   try
    SL := SubList.Items;
    LinkServer(DocFamily).SubTbl.GetDocSub(DocID, SL);
   finally
    Screen.Cursor := crDefault;
   end;
  end;

  piResp:
  begin
   Screen.Cursor := crHourGlass;
   try
    LinkServer(DocFamily).HLinkTbl.GetChildList(CurDocument.DocID, ChildDocOutliner.CTree, Document.RespondentsList);
   finally
    Screen.Cursor := crDefault;
   end;
  end;

  piCoresp:
  begin
   Screen.Cursor := crHourGlass;
   try
    ParentDocList.Total := Document.CorespondentsList.Count;
    PageLoad[Index] := False;
   finally
    Screen.Cursor := crDefault;
   end;
  end;

  piVersion:
  begin
   Screen.Cursor := crHourGlass;
   try
    lstVersion.Items := (Document.AttrManager.GetDocAttribute(atVersions) as Il3ViewStringList);
   finally
    Screen.Cursor := crDefault;
   end;
  end;

  piJourn:
  begin
   //if JrnlList = nil then
   // JrnlList := Tl3DataList.CreateSize(SizeOf(TDisplayLogRec));

   tblStage.RowLimit := Ord(High(TStageType));
   //UserManager.GetFiltredUserList(tcStageCheckUser.Items);

   if fGroupMode then
   begin
    tblStage.Columns.Hidden[3] := True;
    tblStage.Columns.Hidden[4] := True;
   end;

   fStructInit := False;
   try
    cbxIncDone.Checked := GetDocDone;
   finally
    fStructInit := True;
   end;

   PageLoad[Index] := False;
   nbkJournalsPageChange(Self, 0, AllowChange);
   PageLoad[Index] := True;
  end;
 end;
end;

procedure TDocEditorWindow.nbkDocPagesPageChange(Sender: TObject; Index: Integer; var AllowChange: Boolean);
var
 CPage : TOvcNotebookPage;
begin
 if FGroupMode and (Index in GroupModeDisable) then
 begin
  AllowChange := False;
  Exit;
 end;
 LoadPage(Index, -1);
 OldPageIndex := -1;
 if Index = AlonePageIndex then
 begin
  CPage := TOvcNotebookPage(nbkDocPages.PageList[AlonePageIndex]);
  CPage.Visible := False;
  CPage.Parent := nbkDocPages;
  CPage.Align := alNone;
  OldPageIndex := nbkDocPages.PageIndex;
  AlonePageIndex := OldPageIndex;
 end;
 TTextSearchDlg.HideFindContext;
 TSpellCheckDlg.CloseSpellCheck;
 //If Index = piAttr then FormResize(Self);
end;

procedure TDocEditorWindow.nbkDocPagesPageChanged(Sender: TObject; Index: Integer);
var
 CPage : TOvcNotebookPage;
begin
  {If Index = piSprv
   then fEditor := SprEditor
   else fEditor := DocEditor;}

 if OldPageIndex > -1 then
 begin
  CPage := TOvcNotebookPage(nbkDocPages.PageList[OldPageIndex]);
  CPage.Parent := Self;
  CPage.Align := alBottom;
  CPage.Height := Height div 2;
  CPage.Visible := True;

  //WinSplitLine.ControlSecond:=CPage;
  WinSplitLine.Align := alTop;
  WinSplitLine.Visible := False;
  WinSplitLine.Align := alBottom;
  WinSplitLine.SplitControl := CPage;
  WinSplitLine.Visible := True;
  AlonePageIndex := OldPageIndex;
 end;

 SetActiveControlOnPage(Index);
 TTextSearchDlg.SwitchActiveEditor(CurEditor);
 TSpellCheckDlg.CheckEditor(CurEditor);
end;

procedure TDocEditorWindow.SetActiveControlOnPage(Index: Integer);
begin
 case Index of
  piText:
   with DocTextEditor.DocEditor do
    if CanFocus then
     SetFocus;
  piSprv:
   with SprTextEditor.DocEditor do
    if CanFocus then
     SetFocus;
  else
   THackWinControl(nbkDocPages.PageList[Index]).SelectFirst;
 end;

end;

procedure TDocEditorWindow.SetDocParam;
//var
// tUserDocID : Longint;
begin
 if fParamSetted then
  Exit;

 {$IfDef DebugRelease}
 if IniRec.DebugInfo then
  MainForm.OutToStatusBar('SetDocParam');
 {$EndIf}

 if fLoadStopLog then Exit;

 fSettingParamMode := True;
 try
  if PageLoad[piName] then
   Exit;
  PageLoad[piName] := True;
  PageLoad[piAttr] := True;

  cbxChargeFree.Checked := l3TestMask(Document.Status, dstatChargeFree);
  cbxNotTM.Checked := l3TestMask(Document.Status, dstatNotTM);
  cbxNoCompare.Checked := l3TestMask(Document.Status, dstatNoCompare);
  cbxInternet.Checked := l3TestMask(Document.Status, dstatInternet);
  cbxHang.Checked := l3TestMask(Document.Status, dstatHang);
  CheckHangDisp;

  cbUserType.ItemIndex := Byte(Document.UserType);
  cbUserTypeChange(Self);

  cbUrgency.ItemIndex := Byte(Document.Urgency);
  CheckUrgencyDisp;

  cbxChargeFree.Tag := 0;
  cbxNotTM.Tag := 0;
  cbxInternet.Tag := 0;
  cbxHang.Tag := 0;
  cbxNoCompare.Tag := 0;
  cbUserType.Tag := 0;
  cbUrgency.Tag := 0;

  edtPriorityID.AsInteger := Document.Priority;
  cbxPriorityType.Checked := Document.PriorFlag;
  edtPriorityID.Modified := False;

  edtDocID.AsInteger := Document.UserDocID;
  if Document.Spravka <> nil then
   edtSprDocID.AsInteger := Document.Spravka.UserDocID
  else
   edtSprDocID.AsInteger := 0;


  lblInternalID.Caption := Format(sidDocNumberFmt, [DocID, SprDocID]);

  {if SprDocID > 0 then
  begin
   tUserDocID := SprDocID;
   tUserDocID := LinkServer(DocFamily).Renum.GetExtDocID(tUserDocID);
   edtSprDocID.AsInteger := tUserDocID;
  end;}
  if fLoadStopLog then Exit;
  GetAttrTreeListOnSub(0, MainAttrExplorer.AttrSet, tsAll{, not fStructInit {aStopNotify});

  if fLoadStopLog then Exit;
  evGetUndoBuffer(FullNameMEdit.TextSource).Disabled := True;
  try

  FullNameMEdit.Buffer := Document.Name;

  FullNameMEdit.Modified := False;
  finally
   evGetUndoBuffer(FullNameMEdit.TextSource).Disabled := False;
  end;

  ShortNameEdit.Buffer := Document.ShortName;
  ShortNameEdit.Modified := False;

  CommentEdit.Buffer := Document.DocComment;
  CommentEdit.Modified := False;
 finally
  fSettingParamMode := False;
 end;
 fParamSetted := True;
end;

function TDocEditorWindow.IsDocParamChange(aFullCheck: Boolean = True): Boolean;
begin
 tblStage.StopEditingState(True);
 Result := IsNewDoc;
 Result := Result or
   ((fDocClass in [Dt_Types.dtObject, Dt_Types.dtFlash]) and (ShortNameEdit.Modified and (aFullCheck or (ShortNameEdit.TextLen <= cShortNameSize)))) or
   (CommentEdit.Modified and
   (aFullCheck or (CommentEdit.TextLen <= cDocCommentSize))) or
   (FullNameMEdit.TextSource.Modified and
   (aFullCheck or (FullNameMEdit.TextLen <= cFullNameSize))) or

   (cbxChargeFree.Tag = 1) or
   (cbxNotTM.Tag = 1) or
   (cbxNoCompare.Tag = 1) or
   (cbxInternet.Tag = 1) or
   (cbxHang.Tag = 1) or

   (cbUserType.Tag = 1) or
   (cbUrgency.Tag = 1) or
   edtPriorityID.Modified;
 Result := Result or Document.IsModified;
end;

procedure TDocEditorWindow.ChildDocOutlinerActionElement(Sender: TObject; Index: Longint);
var
 L : Byte;
 NDocID : Longint;
 NGOSub : TSubID;
 Node : Il3Node;
begin
 Node := ChildDocOutliner.GetNode(Index) as Il3Node;
 L := ChildDocOutliner.TreeStruct.GetLevel(Node);
 case L of
  1:
  begin
   NDocID := (Node as Il3HandleNode).Handle;
   NGOSub := 0;
  end;
  2:
  begin
   NDocID := (Node.ParentNode as Il3HandleNode).Handle;
   NGOSub := (Node as Il3HandleNode).Handle;
  end;
 end;
 ShowDoc(NDocID, NGOSub);
end;

procedure TDocEditorWindow.SplitWindow(CurPageIndex, SecondPageIndex: Integer);
var
 CPage,
 OldCPage : TOvcNotebookPage;
begin
 OldCPage := Nil;
 if SplitLog and
  ((nbkDocPages.PageIndex = CurPageIndex) or
  (nbkDocPages.PageIndex = SecondPageIndex)) and
  ((AlonePageIndex = CurPageIndex) or
  (AlonePageIndex = SecondPageIndex)) and
  (WinSplitLine.SplitControl.Height <> 0) then
  Exit;

 if AlonePageIndex = CurPageIndex then
  nbkDocPages.PageIndex := SecondPageIndex
 else
 begin
  if SplitLog then
   OldCPage := TOvcNotebookPage(nbkDocPages.PageList[AlonePageIndex]);
  AlonePageIndex := SecondPageIndex;
  CPage := TOvcNotebookPage(nbkDocPages.PageList[AlonePageIndex]);
  if OldCPage = CPage then
   OldCPage := Nil;

  CPage.Parent := Self;
  CPage.Align := alBottom;
  if OldCPage <> Nil then
   CPage.Height := OldCPage.Height
  else CPage.Height := Height div 2;
  CPage.Visible := True;

  if OldCPage <> Nil then
  begin
   OldCPage.Visible := False;
   OldCPage.Parent := nbkDocPages;
   OldCPage.Align := alNone;
  end;

  WinSplitLine.Align := alTop;
  WinSplitLine.SplitControl := CPage;
  WinSplitLine.Visible := True;
  WinSplitLine.Align := alBottom;
  WinSplitLine.Height := 4;
 end;
 SplitLog := True;
 acPMMainSplitWindow.Checked := SplitLog;
 acPMMainSwapPanels.Enabled := SplitLog;
end;

function TDocEditorWindow.EditClassOnSub(aSub : TSubID; aDict : TdtAttribute; aNode : Il3HandleNode): Boolean;
begin
 Result := False;
 if not FGroupMode and (aSub = AllSubs) then
 begin
  vtMessageDlg(l3CStr(@sidNoSubSelected), mtError, [mbYes]);
  Exit;
 end;

 if (aDict in MainAttrExplorer.AttrSet) and (aSub = 0) then
  Result := MainAttrExplorer.EditDictItem(aDict, aNode, aSub)
 else
  if aDict in SubAttrExplorer.AttrSet then
  begin
   Result := SubAttrExplorer.EditDictItem(aDict, aNode, aSub);
   if Result then
   begin
    CurEditor.View.Control.SetFlag(ev_uwfRegion);
    CurEditor.Invalidate;
   end;
  end;
end;

function TDocEditorWindow.GetCurrentParaSubID: Tl3Handle;
var
 SL : Tl3StringDataList;
 lSubID : Tl3Handle;

 procedure lLoadSubList(const aSL: Tl3StringDataList);
 var
  lSub : IevSub;
  lBC : TnevBaseCursor;
  lCurSubID : Tl3Handle;
 begin
  aSL.NeedAllocStr := True;
  lBC := evMostInnerCursor(CurEditor);

  if l3IOk(lBC.QueryInterface(IevSub, lSub)) and (lSub.Exists) then
   repeat
    lCurSubID := lSub.ID;
    aSL.Add(PansiChar(Format('[Метка %d] %s', [lSub.ID, AnsiString(lSub.Name.S)])), @lCurSubID);
    lSub := lSub.Next;
   until lSub = nil;

  repeat
   lBC := lBC.ParentPoint;

   if (lBC = nil) or not lBC.AsObject.IsValid or (lBC.VertPosition(CurEditor.View, nil) > 1) then
    Break;

   if l3IOk(lBC.QueryInterface(IevSub, lSub)) then
    try
     lCurSubID := lSub.ID;
     aSL.InsertData(0, PansiChar(Format('[Блок %d] %s', [lSub.ID, AnsiString(lSub.Name.S)])), PansiChar( @lCurSubID));
    finally
     lSub := nil;
    end;{try..finally}
  until False;

 end;

begin
 Result := -1;
 SL := Tl3StringDataList.CreateSize(SizeOf(Longint));
 try
  lLoadSubList(SL);
  if SL.Count <= 0 then
   Exit
  else if SL.Count = 1 then
   Result := SL.DataInt[0]
  else
  begin
   with TSubListDlg.Create(self) do
    try
     (Lister as TvtDStringLister).Items := SL;
     if Execute(lSubID) then
      Result := lSubID;
    finally
     Free;
    end;
  end;
 finally
  l3Free(SL);
 end;
end;

procedure TDocEditorWindow.ShowClassEditor(aAttrID: TdtAttribute);
var
 l_Sub    : IevSub;
 l_NewSub : IevSub;
 l_SubID  : Tl3Handle;
 lCNode   : Il3Node;
 lPNode   : Il3Node;
 lBC : TnevBaseCursor;
begin
 if ActiveControl is TevEditor then
 begin
  lBC := evMostInnerCursor(CurEditor);

  {Попытка найти блок}
  repeat
   if l3IOk(lBC.QueryInterface(IevSub, l_Sub)) then
    try
     l_SubID := l_Sub.ID;
     if (l_SubID >= 0) then
      Break;
    finally
     l_Sub := nil;
    end;{try..finally}
   lBC := lBC.ParentPoint;
  until (lBC = nil) or (lBC.VertPosition(CurEditor.View, nil) > 1);

  if (l_SubID < 0) and (not acSetSub.Enabled) then
  begin
   vtMessageDlg(l3CStr(@sidReadOnlyText), mtError);
   Exit;
  end;

  if l_SubID < 0 then
  begin
   acSetSubClick(Self);
   if not Supports(CurEditor.Selection.Cursor.MostInner, IevSub, l_NewSub) then
    Exit;
   l_SubID := l_NewSub.ID;
   if l_SubID < 0 then
    Exit;
   SyncWithSub(piText, l_SubID, -1);
  end;

  ///aAttrIDe := aidClasses;
  // при нажатии на кнопку в редакторе надо получить lDLType
  lCNode := nil;
 end
 else
 begin
  lCNode := SubAttrExplorer.otlAttributes.CurrentCNode;

  lPNode := lCNode;
  if (lPNode.ParentNode as Il3HandleNode).Handle <> 0 then
   lPNode := lPNode.ParentNode;

  if TvtOutliner(ActiveControl).CTree.TestFlagMask(lPNode, nfReadOnly) then
   Exit;

  aAttrID := TdtAttribute((lPNode as Il3HandleNode).Handle);
  l_SubID := SubAttrExplorer.CurSub;
 end;

 EditClassOnSub(l_SubID, aAttrID, lCNode as Il3HandleNode);
end;

{
function TDocEditorWindow.evntOnAttrItemAction(aAttrID : TdtAttribute; aNode : Il3HandleNode; aReadOnly : boolean; aSub : Longint) : Boolean;
begin
 Result := False;
 If aAttrID = aidAutoClasses then
 begin
  Result := True;

  aNode.Handle
 end;
end;
}

procedure TDocEditorWindow.otlAttributesActionElement(Sender: TObject; Index: Integer);
var
 lDLType : TdtAttribute;
 lCNode : Il3Node;
 lPNode : Il3Node;
 lCurSub : Integer;

begin
 if (ActiveControl is TvtOutliner) then
 begin
  lCNode := TvtOutliner(ActiveControl).CurrentCNode;
  lPNode := lCNode;
  if (lPNode.ParentNode as Il3HandleNode).Handle <> 0 then
   lPNode := lPNode.ParentNode;

  lDLType := TdtAttribute((lPNode as Il3HandleNode).Handle);

  if TvtOutliner(ActiveControl).CTree.TestFlagMask(lPNode, nfReadOnly) then
   Exit;

  if ActiveControl = MainAttrExplorer.otlAttributes then
   lCurSub := 0
  else
   lCurSub := SubAttrExplorer.CurSub;

  EditClassOnSub(lCurSub, lDLType, lCNode as Il3HandleNode);
 end;
end;

{!!Sub}
{procedure TDocEditorWindow.DocumentSourceGetSubFlagsIterator(Sender: TObject;
 aLayer: Longint; const aSubList: InevSubList);
begin
 if (aLayer = Ord(ev_sbtSub)) then
  LinkServer(DocFamily).GetSubFlags(DocID, aSubList);
end;

procedure TDocEditorWindow.ReBuildSubFlags;
begin
 DocumentSourceGetSubFlagsIterator(Self, Ord(ev_sbtSub), evGetSubList(DocTextEditor.DocEditor.TextSource));
end;
}
procedure TDocEditorWindow.LoadDictLinkPrim(Page: Byte; SubID: LongInt; SubItem: LongInt);
begin
 case Page of
  piClass:
  begin
   SubAttrExplorer.CurSub := SubID;
   LoadPage(piClass, SubID);
   //GetAttrTreeListOnSub(SubAttrExplorer.CurSub, SubAttrExplorer.AttrSet);
  end;
 end;
end;

procedure TDocEditorWindow.SyncWithSub(SyncPage: Integer; SubID: LongInt; SubItem: LongInt);

 function GetAnotherViewPanel: Integer;
 begin
  if AlonePageIndex = SyncPage then
   Result := nbkDocPages.PageIndex
  else
   Result := AlonePageIndex;
 end;

var
 l_Node: Il3Node;

begin
 if GetAnotherViewPanel = -1 then
  Exit;
 case GetAnotherViewPanel of
  piText:
   begin
    with DocTextEditor.DocEditor do
     evGetSubList(TextSource).Sub[SubID].Select(Selection);
    l_Node := l3FindNodeByHandle(otlBlocks.CTree.RootNode as Il3Node, SubID);
    otlBlocks.GotoOnNode(l_Node);
   end;
  piClass:
   LoadDictLinkPrim(piClass, SubID, SubItem);
 end;
end;

procedure TDocEditorWindow.SubListActionElement(Sender: TObject; Index: Longint);
begin
 LoadPage(piSub);
 SyncWithSub(piSub, SubList.Items.DataInt[Index], Index);
end;

function TDocEditorWindow.SubShowPanelMouseOverSub(Sender: TObject;
 const Pt: Tl3_SPoint; const R: Tl3_SRect; const aSub: IevSub; SubType: Integer): Boolean;
var
 lBlock : IevDocumentPart;

const
 lBackLinkStr: array[False..True] of AnsiString = ('', ', обратная ссылка');

begin
 try
  with (Sender as TControl) do
  begin
   case SubType of -(10 + sfbitExpName):
     Hint := l3PCharLen2String(aSub.Name) + '|'; -(10 + sfbitContents):
    begin
     lBlock := evGetSubList(CurEditor.TextSource).Block[aSub.ID];
     if lBlock <> nil then
      with lBlock.ContentsRec do
      begin
       if rLevel6 <> Pred(High(Long)) then
        Hint := Format('Оглавление: вложенность - %d', [rLevel6])
       else
        Hint := '';
       if rCompareContentsLevel > 0 then
        if Hint <> '' then
         Hint := Format('%s'#13#10' вложенность сравнения - %d', [Hint, rCompareContentsLevel])
        else
         Hint := Format('Оглавление: вложенность сравнения - %d', [rCompareContentsLevel]);
      end;
    end; -(10 + sfbitRTFImage):
    begin
     lBlock := evGetSubList(CurEditor.TextSource).Block[aSub.ID];
     if lBlock <> nil then
      Hint := 'ObjTopic ' + IntToStr(lBlock.ExternalHandle) + '|'
     else
      Hint := '?|';
    end
    else Hint := IntToStr(aSub.ID) + '|'
   end;
   ShowHint := True;
   Result := True;
  end;
 except
  Result := False;
 end;
end;

 (*
  sfbitSubNumber = 0;
  sfbitExpName   = 1;
  sfbitKeyWords  = 2;
  sfbitTreeNodes = 3;
  sfbitAutoClass = 4;
  sfbitDocType   = 5;
  sfbitRTFImage  = 7;
 *)

procedure TDocEditorWindow.SubShowPanelClickSub(Sender: TObject; SubType, SubHandle: Integer; aKind: TafwClickKind);
const
 cAttrTypeArray: array[ -(10 + sfbitDocType) .. -(10 + sfbitKeyWords)] of TdtAttribute =
  (atTypes, atNothing {not used}, atClasses, atKeyWords);
begin
 if f_SkipSubPanelClick then
 begin
  f_SkipSubPanelClick := False;
  Exit;
 end;

 if aKind <> afw_ckDouble then
  Exit;

 if Sender = DocTextEditor.SubShowPanel then
  DocTextEditor.DocEditor.SetFocus
 else if Sender = SprTextEditor.SubShowPanel then
  SprTextEditor.DocEditor.SetFocus;

 case SubType of
  1:
   if SubHandle > 0 then
    SubNameEdit(SubHandle);
  -(10 + sfbitExpName) .. -(10 + sfbitSubNumber):
   if SubHandle > 0 then
    SubNameEdit(SubHandle);
  -(10 + sfbitDocType) .. -(10 + sfbitKeyWords):
   begin
    SplitWindow(piText, piClass);
    Application.ProcessMessages;
    SyncWithSub(piText, SubHandle, -1);
    SubAttrExplorer.GotoOnAttrNode(cAttrTypeArray[SubType]);
   end;
  -(10 + sfbitContents):
   SetContentsSub(SubHandle);
  -(10 + sfbitRTFImage):
   SetRtfPropOnSub(SubHandle);
 end;
end;

procedure TDocEditorWindow.SubShowPanelMenuSub(Sender: TObject;
 const Pt: Tl3SPoint;
 const R: Tl3SRect;
 SubType,
 SubHandle: Integer);
var
 lCurEd : TevEditor;
 lIsBlock : Boolean;
 lEditAvail : Boolean;
 l_Block: IevDocumentPart;
begin
 if Sender = DocTextEditor.SubShowPanel then
  lCurEd := DocTextEditor.DocEditor
 else if Sender = SprTextEditor.SubShowPanel then
  lCurEd := SprTextEditor.DocEditor;

 l_Block  := evGetSubList(lCurEd.TextSource).Block[SubHandle];
 lIsBlock := l_Block <> nil;
 lCurEd.SetFocus;
 fSubOnPopUp := SubHandle;
 //If SubHandle = 0 then piRemoveSub.Enabled := False;

 if SubType = 1 then
 begin
  lEditAvail := (SubHandle > 0) {не начало документа} and
   (lIsBlock and ((Document.LockMask and acgBlock) <> 0)) or
   ( not lIsBlock and ((Document.LockMask and acgSub) <> 0));

  vtVisibleAndEnabled(piSubNameEdit, lEditAvail);
  vtVisibleAndEnabled(piRemoveSub, lEditAvail);

  acPMSubAncorLinkExtObject.Visible := lEditAvail and lIsBlock and (l_Block.ExternalHandle = -1);
  acPMSubAncorLinkExtObject.Enabled := lEditAvail and (SubHandle > 0) and lIsBlock;

  acPMSubAncorDelExtObject.Visible := lEditAvail and lIsBlock and (l_Block.ExternalHandle > 0);
  acPMSubAncorDelExtObject.Enabled := lEditAvail and (SubHandle > 0) and lIsBlock;
  //vtVisibleAndEnabled(acPMSubAncorLinkExtObject, not CurRO);

  SendCancelMode(nil);
  //If Sender is TControl
  pmSubAnchor.PopupComponent := TControl(Sender);
  pmSubAnchor.PrimaryPopUpMenu := TevSubPanel(Sender).PopupMenu;
  pmSubAnchor.Popup(Pt.P.X, Pt.P.Y);
 end;
end;

procedure TDocEditorWindow.cbClassSubsChange(Sender: TObject);
var
 Ind : Longint;
 NewSub : Longint;
begin
 if cbClassSubs.CurrentNode = nil then Exit;
 if (cbClassSubs.Text = nil) or (cbClassSubs.Text.AsWStr.SLen = 0) then
  NewSub := 0 {AllSubs}
 else
  NewSub := (cbClassSubs.CurrentNode as Il3HandleNode).Handle;

 //If SubAttrExplorer.CurSub = NewSub then Exit;

 //SubAttrExplorer.CurSub := NewSub;
 Screen.Cursor := crHourGlass;
 try
  SubAttrExplorer.CurSub := NewSub;
  SyncWithSub(piClass, SubAttrExplorer.CurSub, -1 {Index});
  ///GetAttrTreeListOnSub(SubAttrExplorer.CurSub, SubAttrExplorer.AttrSet);
 finally
  Screen.Cursor := crDefault;
 end;                                           
end;

procedure TDocEditorWindow.cbClassSubsExit(Sender: TObject);
var
 Ind : Longint;
begin
 Ind := cbClassSubs.Items.IndexOf(cbClassSubs.Text);
 if Ind < 0 then
  cbClassSubs.Text := l3CStr('');
end;

procedure TDocEditorWindow.DocumentSourceAllowGotoSub(Sender: TObject; const aPoint : IevDocumentPoint);
begin
 aPoint.Select(DocTextEditor.DocEditor.Selection);
end;

procedure TDocEditorWindow.SprDocumentSourceAllowGotoSub(Sender: TObject; const aPoint : IevDocumentPoint);
begin
 aPoint.Select(SprTextEditor.DocEditor.Selection);
end;

procedure TDocEditorWindow.EditorCanRedoChange(Sender: TObject);
begin

 if (MainForm.ActiveMDIChild = Self) and (ActiveControl is TevCustomEditor) then
  MainForm.acRedo.Enabled := TevCustomEditor(ActiveControl).CanRedo;
end;

procedure TDocEditorWindow.EditorCanUndoChange(Sender: TObject);
begin
 if (MainForm.ActiveMDIChild = Self) and (ActiveControl is TevCustomEditor) then
  MainForm.acUndo.Enabled := TevCustomEditor(ActiveControl).CanUndo;
end;

procedure TDocEditorWindow.sbGotoNextOccurClick(Sender: TObject);
begin
 JumpTo;
end;          

procedure TDocEditorWindow.JumpTo;
var
 l_Cursor, l_InCursor: TnevBaseCursor;
 l_Block     : IevDocumentPart;
 lResultNode : Il3Node;
 I           : Integer;

 function IterHandler(CurNode: Il3Node): Boolean; far;
 var
  l_Tag : Il3TagRef;
 begin
  if l3IOk(CurNode.QueryInterface(Il3TagRef, l_Tag)) then
   try
    Result := DocJumpData.FindSubList.FindData(l_Tag.AsObject.IntA[k2_tiHandle], I)
   finally
    l_Tag := nil;
   end{try..finally}
  else
   Result := False;
  //If Result then lResultNode :=CurNode
 end;

var
 l_Tag      : Il3TagRef;
 l_Searcher : TevBaseSearcher;
 lSOOpt     : TevSearchOptionSetEx;
 lFirstTime : Boolean;
 l_Para     : InevObject;
begin
 lSOOpt := [ev_soFind];

 lFirstTime := DocJumpData.JumpOnLoad;
 if DocJumpData.JumpOnLoad then
 begin
  lSOOpt := lSOOpt + [ev_soGlobal];
  fDocJumpData.JumpOnLoad := False;
 end;

 case DocJumpData.DocJumpType of
  djFoundWord:
  begin
   StyleSearcher.Handle := ev_saFoundWords;
   StyleSearcher.Layer := Ord(ev_slFoundWords);
   StyleSearcher.SearchPlace := ev_spAll;
   try
    CurEditor.Find(StyleSearcher, nil, lSOOpt);
   except
    on EevSearchFailed do
     vtMessageDlg(l3CStr(@sidFindEnd), mtWarning);
   end;
  end;

  djReferences:
  begin
   l_Searcher := TarMultiHyperlinkSearcher.Create(self);
   try
    with TarMultiHyperlinkSearcher(l_Searcher) do
    begin
     HLDocID := DocJumpData.DocAddrList.rDocID;
     HLSubIDList := DocJumpData.DocAddrList.rSubIDList;
    end;
    try
     CurEditor.Find(l_Searcher, nil, lSOOpt);
    except
     on EevSearchFailed do
      vtMessageDlg(l3CStr(@sidFindEnd), mtWarning);
    end;
   finally
    l3Free(l_Searcher);
   end;
  end;

  djSubList:
  begin
   if lFirstTime then
    lResultNode := otlBlocks.CTree.CRootNode.IterateF(l3L2NA(@IterHandler),
     imCheckResult, nil)
   else
    lResultNode := otlBlocks.CTree.CRootNode.IterateF(l3L2NA(@IterHandler),
     imNoSubRoot or imCheckResult, otlBlocks.CurrentCNode);

   if lResultNode <> nil then
   begin
    if l3IOk(lResultNode.QueryInterface(Il3TagRef, l_Tag)) then
     try
      with DocTextEditor.DocEditor do
       evGetSubList(TextSource).Sub[l_Tag.AsObject.IntA[k2_tiHandle]].Select(Selection);
      otlBlocks.GotoOnNode(lResultNode);
     finally
      l_Tag := nil;
     end;{try..finally}
   end
   else
    vtMessageDlg(l3CStr(@sidNoFindAnother), mtWarning);
  end;

  djTextSearch:
  begin
   l_Searcher := TevRegularExpressionSearcher.Create(self);
   try
    l_Searcher.Text := DocJumpData.SearchString;
    try
     CurEditor.Find(l_Searcher, nil, lSOOpt);
    except
     on EevSearchFailed do
      vtMessageDlg(l3CStr(@sidFindEnd), mtWarning);
    end;
   finally
    l3Free(l_Searcher);
   end;
  end;

  djBlockRef:
  begin
   if Assigned(DocJumpData.Positions) then
   begin
    l_Block := Document.TextSource.DocumentContainer.SubList.Block[DocJumpData.AnchorID];
    l_Block.Select(CurEditor.Selection);
    if not l_Block.Para.QT(InevObject, l_Para) then
     Assert(false);
    l_InCursor := l_Para.MakePoint;
    for I := 0 to DocJumpData.Positions.Count - 1 do
    begin
     l_InCursor.PositionW := DocJumpData.Positions[I];
     if l_InCursor.Inner <> nil then
      l_InCursor := l_InCursor.Inner;
    end;//for I := 0 to
    InevSelection(CurEditor.Selection).SelectPoint(l_InCursor, False);
   end;//if Assigned(DocJumpData.Positions) then
  end;//djBlockRef
 end;//case DocJumpData.DocJumpType of
end;

procedure TDocEditorWindow.sbGotoPrevOccurClick(Sender: TObject);
begin
 StyleSearcher.Handle := ev_saFoundWords;
 try
  CurEditor.Find(StyleSearcher, nil, [ev_soFind, ev_soBackward])
 except
  on EevSearchFailed do
   vtMessageDlg(l3CStr(@sidFindEnd), mtWarning);
 end;
end;

procedure TDocEditorWindow.CustomSubPanel(aShowMask : Longint; aIsForRel: Boolean = False);
var
 I : Byte;
 l_SLD: TevSubLayerDescriptor;
begin
 if not aIsForRel then
  l_SLD := (MainForm.SubDescriptors.SubsLayer as TevSubLayerDescriptor)
 else
  l_SLD := (MainForm.SubDescriptors1.SubsLayer as TevSubLayerDescriptor);
 with l_SLD do
  for I := 0 to 7 do
   with Flags[I] do
    Visible := l3TestBit(aShowMask, I);
end;

procedure TDocEditorWindow.ShowSubMaskClick(Sender: TObject);
begin
 with (Sender as TAction) do
 begin
  l3InvertBit(fSubShowMask, Tag);
  Checked := l3TestBit(fSubShowMask, Tag);
 end; 
 IniRec.SubShowMask := fSubShowMask;
 CustomSubPanel(fSubShowMask);
end;

procedure TDocEditorWindow.ShowRelSubMaskClick(Sender: TObject);
begin
 with (Sender as TAction) do
 begin
  l3InvertBit(fRelSubShowMask, Tag);
  Checked := l3TestBit(fRelSubShowMask, Tag);
 end;
 IniRec.RelSubShowMask := fRelSubShowMask;
 CustomSubPanel(fRelSubShowMask, True);
end;

procedure TDocEditorWindow.CheckShowFutureEditionWarnPanel;
begin
 pnlHasFutureEditionWarning.Visible := Document.GetPrevVerDocID > 0;
end;

procedure TDocEditorWindow.CheckShowWarnPanel;

 function GetDapasonStr: AnsiString;
 var
  lSDate : TstDate;
  lEDate : TstDate;
  lReason : Tl3Tag;

 begin
  Result := '';
  if (Document.AttrManager.GetDocAttribute(atActiveIntervals) as IActiveIntervalsAttributeTool).
                  GetDiapasonData(lSDate, lEDate, lReason) then
  begin
   Result := GenDateDiapasonString(MakeDateBounds(lSDate, lEDate));
   if Length(Result) > 0 then
    Result := Format(' (интервал действия:%s)', [Result]);

    //lStr := l3Str(aReason);

    if not lReason.IsNull then
     Result := Result + l3Str(l3Fmt(' формулировка : %s', [lReason.AsString]));
   end
   else
    Result := '';
 end;

begin
 if Document.UserType = utEdition then
 begin
  WarnPanel.Caption := '  Недействующая редакция' + GetDapasonStr;
  WarnPanel.Color := clMaroon;
  WarnPanel.Visible := True;
 end
 else
 if Document.IsActive then
  WarnPanel.Visible := False
 else
 begin
  WarnPanel.Caption := '  Документ не действует' + GetDapasonStr;
  WarnPanel.Color := clPurple;
  WarnPanel.Visible := True;
 end;
end;

procedure TDocEditorWindow.edtDocIDChange(Sender: TObject);
begin
 if Sender is TComponent  and not fSettingParamMode then
  TComponent(Sender).Tag := 1;
end;

function TDocEditorWindow.IsNeedSaveSpr: Boolean;
begin
 Result := Document.IsPossibleSpr and
  ((IsNewDoc and nbkDocPages.PagesEnabled[piSprv] {это типа проверка, что справку не удалили руками}) or
  ((SprDocID > 0) and SprTextEditor.IsTextModified));
end;

procedure TDocEditorWindow.MakeSpravka;
begin
 if not Document.IsPossibleSpr then
  raise ESprForbidden.Create(sidSprForbidden);
 with Document do
  if Spravka = nil then
   MakeSpravka;

 nbkDocPages.PagesEnabled[piSprv] := True;
 lblInternalID.Caption := Format(sidDocNumberFmt, [DocID, SprDocID]);
end;

procedure TDocEditorWindow.SetUserDocID(aUserDocID: Integer);
begin
 Document.UserDocID := aUserDocID;
 //then
 // Document.AddLog(acAttrWork);

 edtDocID.AsInteger := aUserDocID;
 edtDocID.Tag := 0;

 if IsNeedSaveSpr and (edtSprDocID.AsInteger <= 0) then
 begin
  {!!}
  try
   MakeSpravka;
   if GlobalHtServer.ExtDocIDsFromRange then
    edtSprDocID.AsInteger := GlobalDataProvider.GetFreeExtDocID(DocFamily)
   else
    edtSprDocID.AsInteger := DocumentServer(DocFamily).GetRelImportNum(edtDocID.AsInteger);
   //lCurCtrl := edtSprDocID;
   try
    Document.Spravka.UserDocID := edtSprDocID.AsInteger;

   except
    on E : EAssignError do
    begin
     edtSprDocID.Clear;
     raise;
    end;
   end;
  except
   on E : ESprForbidden do
   begin
    edtSprDocID.AsInteger := 0;
    raise;
   end;
  end;

  edtSprDocID.Tag := 0;
 end;
 SetCaption;
end;

procedure TDocEditorWindow.edtDocIDExit(Sender: TObject);
var
 lCurCtrl : TvtSpinEdit;
begin
 if (TComponent(Sender).Tag = 1) then
  if (edtDocID.AsInteger <= 0) then
  begin
   edtDocID.AsInteger := Document.UserDocID;
   TComponent(Sender).Tag := 0;
  end
  else
  begin
   lCurCtrl := edtDocID;
   try
    SetUserDocID(edtDocID.AsInteger);
   except
    On E: EAssignError do
    begin
     try
      ActiveControl := lCurCtrl;
     except end;
     MainForm.LayMsg(E.Message, mtError, [mbOK], 0 {HelpCtx});
    end
    //else raise;
   end;
  end;
end;

procedure TDocEditorWindow.edtSprDocIDExit(Sender: TObject);
var
 lSprRealDocID : Longint;
 lRelFlag : Boolean;

 procedure RevertSprNumber;
 begin
  if Document.HasSpravka then
   edtSprDocID.AsInteger := Document.Spravka.UserDocID
  else edtSprDocID.AsInteger := 0;
  TComponent(Sender).Tag := 0;
 end;

begin
 if (TComponent(Sender).Tag = 1) then
 begin
  if (edtSprDocID.AsInteger <= 0) then
   RevertSprNumber
  else
  begin
   try
    // если это чужая справка
    lSprRealDocID := LinkServer(DocFamily).Renum.ConvertToRealNumber(edtSprDocID.AsInteger);
    if Document.HasSpravka and (Document.Spravka.DocID = lSprRealDocID) then Exit;
    if DocumentServer(DocFamily).CheckDoc(lSprRealDocID, True, lRelFlag) and lRelFlag then
    begin
     if (vtMessageDlg(l3CStr(@sidAlienSpr), mtWarning, [mbYes, mbNo]) = mrYes) then
      Document.SetAlienSpr(edtSprDocID.AsInteger)
     else
      RevertSprNumber;
    end
    else
    begin
     try
      MakeSpravka;
      Document.Spravka.UserDocID := edtSprDocID.AsInteger;
      Document.AddLog(acAttrWork);
     except
      on E : ESprForbidden do
      begin
       edtSprDocID.AsInteger := 0;
       raise;
      end;
     end;
    end;
    TComponent(Sender).Tag := 0;
   except
    On E: EAssignError do
    begin
     try
      ActiveControl := edtSprDocID;
     except
     end;
     MainForm.LayMsg(E.Message, mtError, [mbOK], 0 {HelpCtx});
    end;

   end;
  end;
 end;
end;

procedure TDocEditorWindow.FullNameMEditTextSourceBruttoCharCountChange(Sender: TObject);
begin
 if FullNameMEdit.TextLen > cUserFullNameSize then
  FullNameMEdit.Color := clAqua
 else
  FullNameMEdit.Color := clWindow;
 SetDocName(FullNameMEdit.Text);
end;

procedure TDocEditorWindow.ShortNameEditChange(Sender: TObject);
begin
 if ShortNameEdit.TextLen > cShortNameSize then
  ShortNameEdit.Color := clAqua
 else
  ShortNameEdit.Color := clWindow;
end;

procedure TDocEditorWindow.SynchroFullNameWithSpr;
var
 lPack : InevOp;

begin
 //if not SprEditor.TextSource.HasDocument then Exit;
 if not (Document.HasSpravka and Document.Spravka.TextSource.HasDocument) then
  Exit;

 with SprTextEditor.DocEditor do
 begin
  lPack := StartOp(ev_ocUser + 100);
  try
   GotoTop;
   while (CurText.SLen = 0) and MoveLeafCursor(ev_ocParaDown, True) do ;
   Select(ev_stPara);
   Range.Delete;
   InsertBuf(FullNameMEdit.Buffer);
   InsertBuf(cc_EOLStr);
  finally
   lPack := nil; {FinishOp;}
  end;
 end;
end;

procedure TDocEditorWindow.FullNameMEditExit(Sender: TObject);
begin
 if IniRec.SychroNameWSpr and FullNameMEdit.Modified then
  SynchroFullNameWithSpr;
end;

procedure TDocEditorWindow.ShowOwnerSubList(aDictType: TdtAttribute; aItemID: Longint);
var
 aSub : Longint {TSubID};
begin
 with TViewSubDlg.Create(Self) do
  try
   LinkServer(DocFamily).SubTbl.GetDocSubOnDictItem(CurDocument.DocID, AttrID2DLType(aDictType), aItemID, lstSub.Items);
   if Execute(aSub) then
    SyncWithSub(piClass {CPage}, aSub, -1 {Index});
  finally
   Free;
  end;
end;

procedure TDocEditorWindow.tblStageGetCellData(Sender: TObject;
 RowNum: Longint; ColNum: Integer; var Data: Pointer;
 Purpose: TOvcCellDataPurpose);
var
 //lStageRec     : PStageFullRec;
 ltmpLoginName : ShortString;
 ltmpActFlag   : Byte;
 lStagesAttr   : IListDocAttribute;
 lStageType    : Byte;
 lIndex        : Integer;
 lSDate        : TstDate;
 lEDate        : TstDate;
 lAuthor       : Integer;
 (*function GetStageRec(aStageType : Byte): PStageFullRec;
 var
  lIndex : Integer;
  lStagesAttr   : IListDocAttribute;
 begin
  lStagesAttr := (Document.AttrManager.GetDocAttribute(atStages) as IListDocAttribute);
  lIndex := lStagesAttr.GetIndexByHandle(aStageType);
  if lIndex >= 0 then
   Result := PStageFullRec(lStagesAttr.Data[lIndex])
  else
   Result := nil;
 end;
  *)

begin
 if (RowNum = 0) then
  Exit;
 Data := @tmpValue;
 tmpValue.AsString := '';
 if Purpose = cdpForSave then
  Exit;

 lStageType := ord(cStagesStringUserOrder[RowNum].rStageId);

 with (Document.AttrManager.GetDocAttribute(atStages) as IStageDocAttributeTool) do
 begin
  lIndex := GetIndexByHandle(lStageType);
  case ColNum of
   0:
   begin
    if lIndex < 0 then
     lSDate := BlankDate
    else
     lSDate := GetStartDate(lIndex);

    if lSDate = BlankDate then
     tmpValue.AsCBS := cbUnChecked
    else
     if lSDate > 1 then
      tmpValue.AsCBS := cbGrayed
     else
      tmpValue.AsCBS := cbChecked
   end;

   1:
   begin
    if lIndex < 0 then
     lEDate := BlankDate
    else
     lEDate := GetEndDate(lIndex);

     if lEDate = BlankDate then
     tmpValue.AsCBS := cbUnChecked
    else
     if lEDate > 1 then
      tmpValue.AsCBS := cbGrayed
     else
      tmpValue.AsCBS := cbChecked
   end;

   2:
   begin
    Data := @cStagesStringUserOrder[RowNum].rName;
    //Data := @StageStringConst[TStageType(lStageType)];
   end;

   3:
   begin
    if (lIndex >= 0) then
    begin
     lEDate := GetEndDate(lIndex);
     if lEDate = BlankDate then
      tmpValue.AsDate := DemonToStDate(GetStartDate(lIndex))
     else
      tmpValue.AsDate := DemonToStDate(lEDate);
    end
    else
     tmpValue.AsDate := BadDate;

    if tmpValue.AsDate = 1 then
     tmpValue.AsDate := BadDate;
   end;

  4:
   begin
    tmpValue.AsComboBoxData.Index := -1;
    tmpValue.AsComboBoxData.St := '';
    if (lIndex >= 0) then
    begin
     lAuthor := GetAuthor(lIndex);

     if (lAuthor > 0) then
     begin
      tmpValue.AsComboBoxData.Index := tcStageCheckUser.Items.IndexOfObject(TObject(lAuthor));
      if tmpValue.AsComboBoxData.Index = -1 then
       tmpValue.AsComboBoxData.St := UserManager.GetUserDisplayName(lAuthor);
     end;
    end;
   end;
  end; //case ColNum of
 end; //with (Document.AttrManager.GetDocAttribute(atStages) as IStageDocAttributeTool) do
end;

procedure TDocEditorWindow.tblStageBeginEdit(Sender: TObject; RowNum: Longint;
 ColNum: Integer; var AllowIt: Boolean);

 function lStageEditEnable(aStageType : TStageType; aDateKind : Byte): Boolean;
 var
  lIndex      : Integer;
  lStagesAttr : IListDocAttribute;
 begin
  with (Document.AttrManager.GetDocAttribute(atStages) as IStageDocAttributeTool) do
  begin
   Result := CheckEditEnable(aStageType, aDateKind);
   (*
   lIndex := GetIndexByHandle(aStageType);
   Result := CheckEditEnable(aStageType : TStageType; aDateKind : Byte) : Boolean;
   if lIndex >= 0 then
   begin
    Result := not (((aDateType = 0) and (GetStartDate(lIndex) <= 1)) or
                   ((aDateType = 1) and (GetEndDate(lIndex) <= 1)));
   end
   else
    Result := False;
   *)
  end;
 end;

begin
 AllowIt := (RowNum > 0) and l3TestBit(dsStagesAccessMask, ord(cStagesStringUserOrder[RowNum].rStageId)-2) and
            lStageEditEnable(cStagesStringUserOrder[RowNum].rStageId,
                            Min(ColNum, 1) {возможность изменения имени пользователя (ColNum = 4) смотрим по закрытости этапа});
end;

procedure TDocEditorWindow.tblStageGetCellAttributes(Sender: TObject;
                            RowNum: Longint; ColNum: Integer;
                            var CellAttr: TOvcCellAttributes);
var
 lAllowIt : Boolean;
begin
 tblStageBeginEdit(Self, RowNum, ColNum, lAllowIt);
 //if not lAllowIt then
 // CellAttr.caColor := clInactiveBorder;
 //CellAttr.caFontHiColor :=clRed;//
 //CellAttr.caFontColor := clWindowText;
end;

procedure TDocEditorWindow.tblStageDoneEdit(Sender: TObject; RowNum: Longint; ColNum: Integer);
var
 lStagesAttr   : IListDocAttribute;
 lStageType    : TStageType;
 lIndex : Integer;

begin
 if PrevDblEnter then
  Exit;
 try
  PrevDblEnter := True;
  lStageType   := cStagesStringUserOrder[RowNum].rStageId; //TStageType(RowNum + 1);

  with (Document.AttrManager.GetDocAttribute(atStages) as IStageDocAttributeTool) do
  begin
   lIndex := MakeStage(lStageType);
  try
   if (ColNum = 4) and (tmpValue.AsComboBoxData.Index >= 0) then
    SetAuthor(lIndex,Integer(tcStageCheckUser.Items.Objects[tmpValue.AsComboBoxData.Index]))
   else
   if tmpValue.AsCBS = cbChecked then
    case ColNum of
     0:
       begin
        SetStartDate(lIndex, 1);
       end;
      1:
       begin
        if GetStartDate(lIndex) = BlankDate then
         SetStartDate(lIndex, 1);
        SetEndDate(lIndex, 1);
        tblStage.InvalidateCell(RowNum, 0);
       end;
     end //case ColNum of
    else
     case ColNum of
      0:
       begin
       if GetStartDate(lIndex) > 0 then
      begin
        SetStartDate(lIndex, BlankDate);
        SetEndDate(lIndex, BlankDate);
        tblStage.InvalidateCell(RowNum, 1);
      end;
     end;
     1:
     begin
       if GetEndDate(lIndex) > 0 then
        SetEndDate(lIndex, BlankDate);
     end;
    end; //case ColNum of

    if (GetStartDate(lIndex) <> 0) and (GetAuthor(lIndex) = 0) then
     SetAuthor(lIndex, GlobalDataProvider.UserID);

  except
   On E: EHtErrors do
   begin
    if E.ErrorValue = ecAccessDenied then
    begin
     vtMessageDlg(l3CStr(@sidEWOpenOtherUser), mtWarning);
     end
     else raise;
    end
    else raise;
   end;
  end;
 finally
  PrevDblEnter := False;
 end;
end;

procedure TDocEditorWindow.nbkJournalsPageChange(Sender: TObject;
 Index: Integer; var AllowChange: Boolean);
var
 SL : Tl3StringDataList;
 NN : Il3Node;
 I : Integer;
 lStr : AnsiString;
begin
 case Index of
  {Состояние}
  { 0 : begin
        If PageLoad[piJourn] then Exit;
       end;}

  {Этапы}
  {
  1:
  }
 {Юридический}
  2:
  begin
    tblJurJournal.Items := (Document.AttrManager.GetDocAttribute(atJurLogRecords) as Il3ViewStringList);
    //tblJurJournal.Total := (Document.AttrManager.GetDocAttribute(atJurLogRecords) as IListDocAttribute).Count;
   if not ReadOnly and l3TestPartMask(document.LockMask, acgJurOp or acgAnno) then
    tblJurJournal.PopupMenu := pmJournal
  else
    tblJurJournal.PopupMenu := nil;
  end;

  {Системный}
  3:
  begin
   tblOrdJournal.Items := (Document.AttrManager.GetDocAttribute(atOrdLogRecords) as Il3ViewStringList);
   if not ReadOnly and GlobalDataProvider.AdminRights then
    tblOrdJournal.PopupMenu := pmJournal
   else
    tblOrdJournal.PopupMenu := nil;
  end;
 end;
end;

procedure TDocEditorWindow.RefreshJurJorunal;
var
 lAllowChange: Boolean;
begin
 if nbkJournals.PageIndex = 3 {Юридический} then
  nbkJournalsPageChange(Self, 3, lAllowChange);
end;

procedure TDocEditorWindow.RunSpellChecker;
begin
 TSpellCheckDlg.Execute(CurEditor, MainForm.SpellDictionary);
end;

procedure TDocEditorWindow.Panel5Resize(Sender: TObject);
begin
 TWinControl(Sender).Controls[0].Width := TControl(Sender).Width - 10;
end;

procedure TDocEditorWindow.edtPriorityIDChange(Sender: TObject);
begin
 if fSettingParamMode then
  Exit;
 cbxPriorityType.Checked := True;
end;

procedure TDocEditorWindow.cbxPriorityTypeClick(Sender: TObject);
begin
 if fSettingParamMode then
  Exit;
 if not cbxPriorityType.Checked then
 begin
  fSettingParamMode := True;
  try
   edtPriorityID.AsInteger := LinkServer(DocFamily).GetPriority(DocID);
  finally
   fSettingParamMode := False;
  end;
 end;
 edtPriorityID.Modified := True;
end;

procedure TDocEditorWindow.cbUserTypeChange(Sender: TObject);
begin
  if fSettingParamMode then
  Exit;
 cbUserType.Tag := 1;
 //if IsNewDoc then
 // nbkDocPages.PagesEnabled[piSprv] := Document.IsPossibleSpr;

 Document.UserType := TUserType(cbUserType.ItemIndex);
 if not nbkDocPages.PagesEnabled[piSprv] and (Document.IsPossibleSpr and (SprDocID > 0)) then
 begin
  nbkDocPages.PagesEnabled[piSprv] := True;
  LoadSpr;
 end;

 nbkDocPages.PagesVisible[piAnno] := (Document.DocClass = Dt_Types.dtText) and
                                     (TUserType(cbUserType.ItemIndex) in utDocTypesHasAnno);

 CheckShowWarnPanel;
end;

function TDocEditorWindow.otlBlocksGetItemImage(Sender: TObject; Index: Integer; var aImages: TCustomImageList): Integer;
var
 l_Node : Il3Node;
 l_Tag  : Il3TagRef;
begin
 aImages := ArchiResources.CommonImageList;
 Result := -1;
 if Index = 0 then
  Result := picText
 else
 begin
  l_Node := otlBlocks.CTree.CNodes[Index];
  if l3IOk(l_Node.QueryInterface(Il3TagRef, l_Tag)) then
   try
    with l_Tag.AsObject do
     if IsKindOf(k2_typDocument) then
      Result := picText
     else
      if IsKindOf(k2_typBlock) then
       if l_Tag.AsObject.Attr[k2_tiViewKind].IsValid then
       begin
        if l_Tag.AsObject.IntA[k2_tiViewKind] = Ord(ev_bvkLeft) then
         Result := picLeftBlock
        else
         if l_Tag.AsObject.IntA[k2_tiViewKind] = Ord(ev_bvkRight) then
          Result := picRightBlock
         else
          Result := picAnchorBlock;
       end
       else
        Result := picAnchorBlock
      else
       Result := picAnchor;
   finally
    l_Tag := nil;
   end;{try..finally}
 end;
end;

procedure TDocEditorWindow.otlBlocksGetItemFont(Sender: TObject; Index: Integer; const aFont: Il3Font);
begin
 if l3TestMask(otlBlocks.CTree.CNodes[Index].Flags, nfContens) then
  if otlBlocks.Selected[Index] and otlBlocks.Focused then
   aFont.ForeColor := clAqua
  else
   aFont.ForeColor := clBlue;
end;

procedure TDocEditorWindow.otlBlocksActionElement(Sender: TObject; Index: Longint);
var
 l_Node    : Il3Node;
 //l_Tag : _Ik2Tag;
begin
 l_Node := otlBlocks.CTree.CNodes[Index];
 JumpToSubNode(l_Node);
 SyncWithSub(piText, (l_Node as Il3HandleNode).Handle, -1);
end;

procedure TDocEditorWindow.cbxIncDoneClick(Sender: TObject);
begin
 pnlIncludeWarning.Visible := cbxIncDone.Checked;
 CheckUrgencyDisp;
 if cbxIncDone.Checked then
 begin
  cbxIncDone.Caption := sidEWDocPlugged;

  if fStructInit then
    (Document.AttrManager.GetDocAttribute(atJurLogRecords) as ILogDocAttributeTool)
        .AddAction(acIncluded, DateTimeToStDate(IniRec.NextVersionDate));
 end
 else
 begin
  cbxIncDone.Caption := sidEWDocUnplugged;
  if fStructInit then
    (Document.AttrManager.GetDocAttribute(atJurLogRecords) as ILogDocAttributeTool)
        .DelAction(acIncluded)
 end;
end;    

(*
function TDocEditorWindow.CheckSubNumberInText(var aSubID : TSubID) : Boolean;
begin
 Result := True;
 with CurDocument.TextSource do
 begin
  if Sub[aSubID].Exists then
   ASubID := NewSub.ID;
 end;
end;
*)

(*

Type
 TFilterClass = class of Tk2TagGenerator;


procedure TDocEditorWindow.DocumentSourceGetReader(Sender: TObject; Format: TevFormat; var Reader: TevFileReader);
var
 lSaveGen : Ik2TagGenerator;

 function lpFindFilterByType(aGen: Ik2TagGenerator; aFilterType : TFilterClass) : Tk2TagGenerator;
 var
  l_Wrap : Il3ObjectWrap;

 begin
  while aGen <> nil do
   if Supports(aGen, Il3ObjectWrap, l_Wrap) and
      l_Wrap.GetObject.InheritsFrom(aFilterType) then
   begin
    Result := Tk2TagGenerator(l_Wrap.GetObject);
    break;
   end
   else
    aGen := aGen.NextGenerator;
 end;

 var
   lFilter : Tk2TagGenerator;
begin
 inherited;

 if Reader <> nil then
 begin
  if Reader is TddRTFReader then
   with TddRTFReader(Reader) do
   begin
    LiteVersion := True;
    EnablePictures := True;
   end;

  lFilter := lpFindFilterByType(Reader.Generator, TGetClipboardLightFilter);

  if lFilter <> nil then
   with TGetClipboardLightFilter(lFilter) do
   begin
    if CurDocument <> nil then
     OnGetNewHandleID := CurDocument.TextSource.evntGetNewHandleID;

    ExpandedFormat := (CurEditor = DocTextEditor.DocEditor) and
                       (Document.UserType in utFullFeatureDocTypes) or
                       ((Document.UserType = utEdition) and Document.IsFutureVersion); //вставлять субатрибуты
     //if (CurEditor = SprTextEditor.DocEditor) then
     // TargetDocID := SprDocID;
   end;

  lSaveGen := Reader.Generator;
  try
   TarObject_PasteFilter.SetTo(lSaveGen);
   Reader.Generator := lSaveGen;
  finally
   lSaveGen := nil;
  end;
 end;
end;

procedure TDocEditorWindow.AnnoDocumentSourceGetReader(Sender: TObject; Format : TevFormat; var Reader : TevFileReader);
 // работает при вcтавке текста в документ
var
 lSaveGen : Ik2TagGenerator;
begin
 DocumentSourceGetReader(Sender, Format, Reader);
 lSaveGen := Reader.Generator;
 try
  TevTagsListFilter.SetTo(TevTagsListFilter.MakeAttrList(k2_typLeafPara, [k2_tiSubs]), lSaveGen);
  TevBlocksEliminator.SetTo(lSaveGen);

  Reader.Generator := lSaveGen;
 finally
  lSaveGen := nil;
 end;
end;

*)

procedure TDocEditorWindow.PriznPopUpMenuPopup(Sender: TObject);
begin
 piShowOwnerSubOnClass.Visible := ActiveControl = SubAttrExplorer.otlAttributes;
end;

procedure TDocEditorWindow.SetContentsSub(aBlockID: Integer);
var
 l_Block    : IevDocumentPart;
 l_Contents : Integer;
 l_Tree     : Il3Tree;
 l_CompareContents: Integer;
begin
 l_Block := evGetSubList(CurEditor.TextSource).Block[aBlockID];
 if l_Block = nil then
  Exit;
 try
  l_Contents := EvGetContentLevel(l_Block.ContentsRec.rLevel6, aBlockID = 0);
  l_CompareContents := l_Block.ContentsRec.rCompareContentsLevel;

  if RequestContents(l_Contents, l_CompareContents, Self) then
  begin
   if l_Contents < 0 then
    l_Contents := Pred(High(Long));
   l_Block.ContentsRec := TevContentsRec_C(l_Contents, l_CompareContents);
   if (l_Contents < Pred(High(Long))) or (l_CompareContents > 0) then
    l_Block.Flags := l_Block.Flags or sfContents
   else
   begin
    l_Block.Flags := l_Block.Flags and not sfContents;
    (DocTextEditor.DocEditor.VSubPanel as IevSubCache).NotifySubDeleted(l_Block);
    DocTextEditor.DocEditor.Invalidate;
   end;
  end;
 finally
  l_Block := nil;
 end;
end;

procedure TDocEditorWindow.SetRtfPropOnSub(aBlockID: Integer);
var
 lBlock   : IevDocumentPart;
 lTopicID : Integer;
 lObjType : Integer;
 l_IsNew  : Boolean;
begin
 lBlock := evGetSubList(CurEditor.TextSource).Block[aBlockID];
 if lBlock = nil then
  Exit;
 try
  lTopicID := lBlock.ExternalHandle;
  l_IsNew := (lTopicID = -1);
  lObjType := lBlock.ObjType;
  if RequestExternalObject(lTopicID, lObjType) then
  begin
   if GlobalHtServer.ExtDocIDsFromRange then
   begin
    if l_IsNew then
     lBlock.ExternalHandle := GlobalDataProvider.GetFreeExtDocID(DocFamily)
   end
   else
   begin
    if lTopicID = 0 then lTopicID := -1;
    lBlock.ExternalHandle := lTopicID;
   end;

   if lTopicID = -1 then //удаляем
   begin
    lBlock.ObjType := 0;
    lBlock.Flags := lBlock.Flags and not sfRTFImage;
   end
   else
   begin
    lBlock.ObjType := lObjType;
    lBlock.Flags := lBlock.Flags or sfRTFImage;
   end;
  end;
 finally
  lBlock := nil;
 end;
end;

procedure TDocEditorWindow.acPMSubAncorDelExtObjectExecute(Sender: TObject);
var
 lBlock : IevDocumentPart;
begin
 lBlock := evGetSubList(CurEditor.TextSource).Block[fSubOnPopUp];

 if lBlock = nil then
  Exit;

 if vtMessageDlg(l3CStr('Вы действительно хотите удалить внешний объект?'), mtWarning, [mbYes, mbNo]) = mrYes then
 begin
  lBlock.ExternalHandle := -1;
  lBlock.ObjType := 0;
  lBlock.Flags := lBlock.Flags and not sfRTFImage;
 end;
end;


procedure TDocEditorWindow.evntCursorInReference(aSender: TTextEditorWin; const aHyperLink: IevHyperlink);
begin
 aSender.FooterPanel.Panels[2].Text := GetReferenceHintString(aHyperLink);
end;

procedure TDocEditorWindow.edtObjectFilePathExit(Sender: TObject);
begin
 Document.ObjAccess.FilePath := edtObjectFilePath.Text;
end;

procedure TDocEditorWindow.SNPanelResize(Sender: TObject);
begin
 ShortNameEdit.Width := SNPanel.Width - 12;
 CommentEdit.Width := SNPanel.Width - 12;
end;

procedure TDocEditorWindow.ChildDocOutlinerCurrentChanged(Sender: TObject; aNewCurrent: Longint; aOldCurrent: Longint);
begin
 ChildDocFooter.Panels[0].Text := Format(scFmtFuterCounter, [Succ(aNewCurrent), ChildDocOutliner.Total]);
end;

procedure TDocEditorWindow.ParentDocListCurrentChanged(Sender: TObject; aNewCurrent: Longint; aOldCurrent: Longint);
begin
 if ParentDocList.Total > 0 then
 begin
  ParentDocFooter.Panels[0].Text := Format(scFmtFuterCounter, [Succ(aNewCurrent), ParentDocList.Total]);
  ParentDocFooter.Panels[1].Text := Format(scFmtFuterID, [LinkServer(DocFamily).Renum.GetExtDocID(Document.CorespondentsList.GetDoc(aNewCurrent).ID)]);
 end
 else
 begin
  ParentDocFooter.Panels[0].Text := '';
  ParentDocFooter.Panels[1].Text := '';
 end;
end;

procedure TDocEditorWindow.ParentDocListActionElement(Sender: TObject; Index: Longint);
var
 NDocID : Longint;
 lEdForm : TCustomEditorWindow;
 lDocAddrList : TDocAddrList;
begin
 NDocID := Document.CorespondentsList.GetDoc(Index).ID;
 //ParentDocList.Items.DataInt[Index];
 //fSelectedSubList: Tl3LongintList;
 lDocAddrList := MakeDocAddrList(0, DocID, fSelectedSubList.Use);
 lEdForm := ShowDoc(NDocID, MakeDocJumpData(djReferences, lDocAddrList, True));
 {if (lEdForm is TDocEditorWindow) then
  TDocEditorWindow(lEdForm).sbGotoNextOccurClick(Self);}
end;

function TDocEditorWindow.ParentDocListGetItemImageIndex(Sender: TObject; Index: Integer): Integer;
begin
 if (Index < 0) then
  Result := picText
 else
  Result := GetDocumentImageIndex(Document.CorespondentsList.GetDoc(Index));
end;

procedure TDocEditorWindow.ParentDocListGetStrItem(Sender: TObject; Index: Integer; var ItemString: Il3CString);
begin
 with Document.CorespondentsList.GetDoc(Index) do
  ItemString := l3ArrayToCString(Name, SizeOf(Name), GlobalDataProvider.BaseLanguage[DocFamily].AnsiCodePage);
end;

procedure TDocEditorWindow.lstVersionCurrentChanged(Sender: TObject; aNewCurrent: Longint; aOldCurrent: Longint);
var
 lID : TDocID;
begin
 VersionFooter.Panels[0].Text := Format(scFmtFuterCounter, [Succ(aNewCurrent), lstVersion.Total]);
 lID := (Document.AttrManager.GetDocAttribute(atVersions) as IListDocAttribute).Handle[aNewCurrent];
 VersionFooter.Panels[1].Text := Format(scFmtFuterID2, [lID, LinkServer(DocFamily).Renum.GetExtDocID(lID)]);
end;

procedure TDocEditorWindow.lstVersionActionElement(Sender: TObject; Index: Longint);
begin
 MainForm.RunTextEditor(DocFamily, (Document.AttrManager.GetDocAttribute(atVersions) as IListDocAttribute).Handle[Index]);
end;

function TDocEditorWindow.lstVersionGetItemImageIndex(Sender: TObject; Index: Integer): Integer;
begin
 if (Index < 0) then
  Result := picText
 else
  Result := (Document.AttrManager.GetDocAttribute(atVersions) as IVersionListAttributeTool).GetIconIndex(Index);
end;

procedure TDocEditorWindow.lstVersionGetItemFont(Sender: TObject; Index: Integer; const aFont: Il3Font);
begin
 if (Document.AttrManager.GetDocAttribute(atVersions) as IListDocAttribute).Handle[Index] = DocID then
  aFont.Style := aFont.Style + [fsBold];
end;

procedure TDocEditorWindow.ChkBxClick(Sender: TObject);
begin
 if TComponent(Sender).Tag = 0 then
  TComponent(Sender).Tag := 1
 else
  TComponent(Sender).Tag := 0;
end;

procedure TDocEditorWindow.otlAttributesGetItemFont(Sender: TObject; Index: Integer; const aFont: Il3Font);
begin
 MainAttrExplorer.otlAttributesGetItemFont(Sender, Index, aFont);
end;

function TDocEditorWindow.otlPublishedInGetItemImage(Sender: TObject; Index: Integer; var aImages: TCustomImageList): Integer;
begin
 Result := MainAttrExplorer.otlAttributesGetItemImage(Sender, Index, aImages);
end;

function TDocEditorWindow.SubListGetItemImageIndex(Sender: TObject; Index: Integer): Integer;
begin
 Result := picAnchor;
end;

procedure TDocEditorWindow.SubListCurrentChanged(Sender: TObject; aNewCurrent: Longint; aOldCurrent: Longint);
begin
 if SubList.Total > 0 then
 begin
  SubDocFooter.Panels[0].Text := Format(scFmtFuterCounter, [Succ(aNewCurrent), SubList.Total]);
  SubDocFooter.Panels[1].Text := Format(' SubID=%d', [SubList.Items.DataInt[aNewCurrent]]);
 end
 else
 begin
  SubDocFooter.Panels[0].Text := '';
  SubDocFooter.Panels[1].Text := '';
 end;
end;

function TDocEditorWindow.ChildDocOutlinerGetItemImage(Sender: TObject; Index: Integer; var aImages: TCustomImageList): Integer;
var
 CNode : Il3Node;
begin
 CNode := ChildDocOutliner.GetNode(Index) as Il3Node;
 case ChildDocOutliner.TreeStruct.GetLevel(CNode) of
  1:
  begin
   if CNode.MaybeChild then
    Result := picTextAnc
   else
    Result := picText;
  end;

  2:
   Result := picAnchor;
 end;
end;

{**DocBase interface}
procedure TDocEditorWindow.LoadText;
var
 l_SelObj : Tm4Addresses;
 l_Searcher : TevBaseSearcher;
begin
 //vtMessageDlg('LoadText');
 {$IfDef DebugRelease}
 if IniRec.DebugInfo then
 begin
  MainForm.OutToStatusBar('LoadText');
  if fLoadStopLog then  Exit;
 end;
 {$EndIf}                            

 evSetExcludeWords(DocTextEditor.DocEditor, IniRec.ShowFoundWordLighting);
 {FFileBase:=DocBaseManager[DocFamily];}
 if (DocJumpData.DocJumpType <> djFoundWord) or
  (DocJumpData.TextSrchBuf = nil) then
  l_SelObj := nil
 else
  l_SelObj := Tm4Addresses(DocJumpData.TextSrchBuf).CreateDocumentAddresses(DocID);

 try

  //try
   DocTextEditor.DocEditor.TextSource := Document.TextSource;
   //TuneTextSource(Document.TextSource);

   if (DocJumpData.DocJumpType = djSub) and (DocJumpData.DocPointAddr.Doc = Document.DocID) then
    Document.LoadText(m3_dsMain, Ord(ev_sbtSub), DocJumpData.DocPointAddr.Sub, l_SelObj)
   else
    if DocJumpData.DocJumpType = djReferences then
    begin
     fDocJumpData.JumpOnLoad := False;
     l_Searcher := TarMultiHyperlinkSearcher.Create(self);
     try
      with TarMultiHyperlinkSearcher(l_Searcher) do
      begin
       HLDocID := DocJumpData.DocAddrList.rDocID;
       HLSubIDList := DocJumpData.DocAddrList.rSubIDList;
      end;
      Document.LoadText(m3_dsMain, ev_sbtBySearcher, 0, l_SelObj, l_Searcher);
     finally
      l3Free(l_Searcher);
     end;
    end
    else
     Document.LoadText(m3_dsMain, Ord(ev_sbtNone), 0, l_SelObj);

  // - если док не загрузился, сделаем пустой
  if not Document.TextSource.Document.IsValid then
   Document.CreateNewText;
 finally
  l3Free(l_SelObj);
 end;

 {!!Sub}// это набивка атрибутов прям в текст, см TAttrExplorer.GetAttrTreeListOnSub
 {$Ifndef evNotUseTreePara}
 if IniRec.DebugInfo then
  LoadSubsInfo;
 {$EndIf}
end;

{$Ifndef evNotUseTreePara}

!!Tl3DataListContainerNode теперь не применяется см arAttrNodes

procedure TDocEditorWindow.LoadSubsInfo;

 procedure AddStruct(const aTree: Il3Tree; aSubID: TSubID; aAttrSet: TdtAttributeSet);

  procedure AddSubTreeList(aDictType: Integer);
  var
   SL : Tl3StringDataList;
   NN : Il3Node;
  begin
   //If aTree <> nil then
   with aTree do
   begin
    NN := MakeNode(PansiChar(GetAttrName(aDictType)), Tl3DataListContainerNode);
    with Tl3DataListContainerNode((NN as Il3NodeWrap).GetSelf) do
    begin
     SL := Tl3StringDataList.Create;
     try
      Items := SL;
      Items.DataSize := 4;
     finally
      l3Free(SL);
     end;

     try
      InsertNode(RootNode, NN);
     except
      InsertNode(RootNode, NN);
     end;

     with (NN as Il3HandleNode) do
      Handle := aDictType;

     //набивка значениями
     LinkServer.Family := DocFamily;
     Changing;
     try
      LinkServer.GetTreeList(AttrID2DLType(aDictType), DocID, aSubID, Items);
     finally
      Changed;
     end;

     ChangeExpand(NN, sbSelect, True);
    end;
   end;
  end;

 var
  I : Integer;
 begin
  if aTree = nil then
   exit;

  for I := Low(TdtAttributeArray) to High(TdtAttributeArray) do
   if AttrIDOrder[I] in aAttrSet then
    AddSubTreeList(AttrIDOrder[I]);
  aTree.ShowRoot := True;
 end;

 function DoSub(const aSub: IevSub): Boolean;
 begin
  Result := True;
  //With ASub.Tree{.RootNode} do
  begin
   AddStruct(aSub.Tree, aSub.ID, [atTypes, atClasses, atPrefixes, atKeyWords]);
  end;
 end;

begin
 (DocTextEditor.TextSource as InevSubList).IterateF(evL2SubA( @DoSub));
end;
{$EndIf}

procedure TDocEditorWindow.acSubNameCorrectExecute(Sender: TObject);
 var
  lChangeCount : Integer;
  lSubNamePrefix1 : Il3CString;
  lSubNamePrefix2 : Il3CString;
  lSubNamePrefix3 : Il3CString;
  lSubNamePrefix4 : Il3CString;
  lNeedHeaderCorr : Boolean;
  lParamGetted    : Boolean;


  procedure GetParam;
  begin
   if not lParamGetted then
   begin
    GetSubNamePropDlg(lSubNamePrefix1, lSubNamePrefix2, lSubNamePrefix3, lSubNamePrefix4, lNeedHeaderCorr);
    lParamGetted := True;
   end;
  end;

  function lStrPrefix(aChoice : Byte) : Il3CString;
  begin
   GetParam;
   case aChoice of
    1 : Result := lSubNamePrefix1;
    2 : Result := lSubNamePrefix2;
    3 : Result := lSubNamePrefix3;
    4 : Result := lSubNamePrefix4;
    //5 : Result := 'Счет';
   end;
  end;

  function CalcPrefixIndex(const aNameStr : Il3CString) : Integer;
  begin
   Result := l3CountOfChar('.', l3Str(aNameStr)) + 1;
  end;

  function lNeedHeaderCorrect : Boolean;
  begin
   GetParam;
   Result := lNeedHeaderCorr;
  end;   

 function DoSub(const aSub: IevSub): Boolean;

  function GetRelevantPara : InevObject;
  var
   l_Para   : InevObject;
   l_Obj    : InevObject;
   lDocPart : IevDocumentPart;
  begin//GetRelevantParaText
   if Supports(aSub, IevDocumentPart, lDocPart) then
   try
    if not lDocPart.Para.QT(InevObject, l_Obj) then
     Assert(false);
    if evSearchPara(l_Obj,
                    TevInvertSearcher.Make(TevStylesSearcher.Make([ev_saTxtComment, ev_saVersionInfo], Ord(ev_slView), ev_spPara),
                                           TevInvertSearcher.Make(TevEmptyTextSearcher.Make)),
                    l_Para,
                    true) then
     Result := l_Para
    else
     Result := nev.NullPara;
   finally
    lDocPart := nil;
   end
   else
    aSub.LeafPara.QT(InevObject, Result);
  end;//GetRelevantParaText

 var
  l_Para   : InevObject;
  l_Param  : TevSubEditParamEX;
  lNameStr : Il3CString;
  l_Refresh: Boolean;
 begin
  Result := True;
  if not aSub.Exists then Exit;

  l_Para := GetRelevantPara;
  if not l_Para.IsValid then Exit;

  if (l_Para.Attr[k2_tiStyle].AsLong = ev_saTxtHeader1) then
  begin
   if lNeedHeaderCorrect then
    lNameStr := l3Trim(l3DeleteDoubleSpace(l3CStr(l3ReplaceNonReadable(l_Para.StrA[k2_tiText]))))
   else
    Exit;
  end
  else
  if evGetParaTextByMask(l_Para, '^\s*(\c|\d)\d*\)', lNameStr) then    // "1)" "a1)"
  begin
   lNameStr := l3Trim(lNameStr);
   lNameStr := l3Fmt('%s %s', [lStrPrefix(4), l3Copy(lNameStr, 0, lNameStr.AsWStr.SLen - 1)]);
  end
  else
  if evGetParaTextByMask(l_Para, '^\s*\d([\d\.]*\d)?', lNameStr) then  // "4.5"
   lNameStr := l3Fmt('%s %s', [lStrPrefix(CalcPrefixIndex(lNameStr)), l3Trim(lNameStr)])
  else
  if evGetParaTextByMask(l_Para, '^\s*Статья\s\d([\d\.]*\d)?', lNameStr) then
  begin
   if (l_Para.Attr[k2_tiStyle].AsLong <> ev_saArticleHeader) then
    lNameStr := l3Trim(lNameStr)
   else
    lNameStr := l3CStr(l_Para.StrA[k2_tiText]);
  end
  else
   Exit;

  if l3Compare(l3Str(lNameStr), l3PCharLen2String(aSub.Name), l3_siCaseUnsensitive) <> 0 then
  begin
   l_Param.rEditor := CurEditor;
   l_Param.rSubID := -1;
   l_Param.rSubName := l3PCharLen(lNameStr);
   l_Param.rStyleID := 0;
   l_Param.rViewKind := -1;
   l_Param.rIsDocEditor := CurEditor = DocTextEditor.DocEditor;
   l_Param.rSubList := SubList;
   l_Param.rFamilyID := DocFamily;
   l_Param.rDocID := CurDocument.DocID;
   evEditSubPrim(l_Param, aSub, l_Refresh, nil);
   Inc(lChangeCount);
  end;
end;

var
 lPack : InevOp;     
begin
 if vtMessageDlg(l3Fmt(sidOperationConfirm, [sidOp_SubNameCorrect]), mtConfirmation, [mbYes, mbNo]) <> mrYes then Exit;
 lParamGetted := False;
 lChangeCount := 0;
 GlobalDataProvider.Journal.StartCaching;
 try
  LinkServer(DocFamily).SubTbl.Table.StartCaching([roInsert, roDelete, roUpdate], ltNoLocks{ltTable}{ltCachedRecords});
  try
   lPack := CurEditor.StartOp(ev_ocUser + 100);
   try
    evGetSubList(DocTextEditor.TextSource).IterateF(evL2SubA(@DoSub), nil, l3CStr('Исправление имен меток'));
   finally
    lPack := nil;
   end;
  finally
   Screen.Cursor := crHourGlass;
   try
    LinkServer(DocFamily).SubTbl.Table.StopCaching;
   finally
    Screen.Cursor := Cursor;
   end;
  end;
 finally
  GlobalDataProvider.Journal.StopCaching;
 end;
 //if lChangeCount > 0 then
 vtMessageDlg(l3Fmt('Выполнено %d замен(ы).', [lChangeCount]));
end;

procedure TDocEditorWindow.LoadExtText(ExtFileName: TFileName; FilterIndex: Integer);
begin
 Screen.Cursor := crHourGlass;
 try
  Document.TextSource.LoadTextFromFile(ExtFileName, FilterIndex);
 finally
  Screen.Cursor := crDefault;
 end;
end;

procedure TDocEditorWindow.SaveExtText(ExtFileName: TFileName; FormatIndex: Integer);
begin
 if CurEditor = SprTextEditor.DocEditor then
  Document.Spravka.TextSource.SaveTextToFile(ExtFileName, FormatIndex)
 else
  if (nbkDocPages.PageIndex = piAnno) then
   Document.AnnoTextSource.SaveTextToFile(ExtFileName, FormatIndex)
  else
   Document.TextSource.SaveTextToFile(ExtFileName, FormatIndex);
end;

procedure TDocEditorWindow.GenerateSpr;
var
 G : TevGenerator;
 lTypeDocAttr : IListDocAttribute;
 l_TextSource : TarTextOfDocument;
 lIs1stCaps   : Boolean;
 lSt : AnsiString;

 procedure StripLastLevel(var aStr : AnsiString);
 var
  lPos : Cardinal;
  lSumPos : Cardinal;
 begin
  lSumPos := 0;
  while true do
  begin
   lPos := PosEx(#13, lSt, Succ(lSumPos));
   if lPos = 0 then break;
   lSumPos := lPos;
  end;
  if lSumPos > 0 then
  begin
   aStr := System.Copy(aStr, Succ(lSumPos), Length(aStr));
   aStr := Trim(aStr);
  end;
 end;

begin
 lSt := '';
 lTypeDocAttr := Document.AttrManager.GetDocAttribute(atTypes) as IListDocAttribute;
 if lTypeDocAttr.Count > 0 then
 begin
   lSt := l3Str(lTypeDocAttr.ViewString[0]);
   StripLastLevel(lSt);

  l3MakeLowerCase(PansiChar(lSt), Length(lSt));
  if (CompareStr('закон', lSt) = 0) or
     (CompareStr('федеральный закон', lSt) = 0) or
     (CompareStr('соглашение', lSt) = 0) or
     (CompareStr('указ', lSt) = 0) then
   l3MakeUpperCase(PansiChar(lSt), 1);

  lSt := mlmaRusDeclensionStr(lSt, rdRodit);
 end;

 l_TextSource := Document.Spravka.TextSource;
 with l_TextSource do
 begin
  if not ReadOnly or IsNewDoc then
  begin
   G := evGetNewTextGenerator(l_TextSource);
   try
    G.Start;
    try
     G.StartChild(k2_typDocument);
     try
      G.StartChild(k2_typTextPara);
      G.Finish;
      G.StartChild(k2_typTextPara);
      try
       G.AddStringAtom(k2_tiText, FullNameMEdit.Buffer);
      finally
       G.Finish;
      end;{try..finally}
      G.StartChild(k2_typTextPara);
      G.Finish;
      G.StartChild(k2_typTextPara);
      try
       G.AddStringAtom(k2_tiText, Format(sidMacroDocNotPublish, [lSt]));
      finally
       G.Finish;
      end;{try..finally}
      G.StartChild(k2_typTextPara);
      G.Finish;
     finally
      G.Finish;
     end;{try..finally}
    finally
     G.Finish;
    end;{try..finally}
   finally
    evFreeGenerator(G);
   end;{try..finally}
  end;
  Modified := True;
 end
end;

procedure TDocEditorWindow.LoadSpr;
var
 lJumpSub : TSubID;

begin
  {$IfDef DebugRelease}
 if IniRec.DebugInfo then
 begin
  MainForm.OutToStatusBar('LoadSpr');
  if fLoadStopLog then  Exit;
 end;
  {$EndIf}

 if Document.IsPossibleSpr then
 begin
  if Document.HasSpravka then
   evSetExcludeWords(SprTextEditor.DocEditor, IniRec.ShowFoundWordLighting);

  if IsNewDoc and not SprTextEditor.DocEditor.Modified then
   GenerateSpr
  else if (SprDocID > 0) then
  begin
   fSettingParamMode := True;
   try
    if (DocJumpData.DocJumpType = djSub) and (DocJumpData.DocPointAddr.Doc = Document.GetSprDocID) then
     lJumpSub := DocJumpData.DocPointAddr.Sub
    else
     lJumpSub := 0;

    Document.Spravka.LoadText(m3_dsMain, Ord(ev_sbtSub), lJumpSub);
   except
    if not fLoadStopLog and (vtMessageDlg(l3CStr(@sidSprLoadError), mtWarning, [mbYes, mbNo]) = mrYes) then
    begin
     GenerateSpr;
     Document.Spravka.TextSource.Modified := True;
    end;
   end;
   fSettingParamMode := False;
  end;
 end;
end;

procedure TDocEditorWindow.LoadAnno;
var
 lSaveSettingParamMode : Boolean;
begin
 lSaveSettingParamMode := fSettingParamMode;
 fSettingParamMode := True;
 try
  Document.LoadText(m3_dsAnno);
  edtAnnoName.Buffer := Document.AnnoName;
 finally
  fSettingParamMode := lSaveSettingParamMode;
 end;
end;

procedure TDocEditorWindow.edtAnnoNameTextSourceBruttoCharCountChange(Sender: TObject);
begin
 if edtAnnoName.TextLen > cUserFullNameSize then
  edtAnnoName.Color := clAqua
 else
  edtAnnoName.Color := clWindow;
end;

//procedure TDocEditorWindow.edtAnnoNameTextSourceTevEdit_edtAnnoNameChangeModified(Sender: TObject);
//begin
// if not fSettingParamMode then
//  edtAnnoName.Tag := 1;
//end;

{**Find-Replace Proc}
function  TDocEditorWindow.GetAllowReplaceTypes : TtsSrchTypeSet;
begin
 Result := [];
 if ((l3TestMask(Document.LockMask, acgText) and
    ((ActiveControl = DocTextEditor.DocEditor) or
     (ActiveControl = SprTextEditor.DocEditor))) or
    (l3TestMask(Document.LockMask, acgAnno) and
    (ActiveControl = AnnoTextEditor.DocEditor))) then
  Result := Result + [srtText, srtStyle];

 if (ActiveControl = DocTextEditor.DocEditor) or
    (ActiveControl = SprTextEditor.DocEditor) then
 begin
  if l3TestMask(Document.LockMask, acgSub) then
   Result := Result + [srtSub];

  if l3TestMask(Document.LockMask, acgHyperLink) then
   Result := Result + [srtHLink];
 end;
end;

procedure TDocEditorWindow.acTextSearchExecute(Sender: TObject);
begin
 TTextSearchDlg.Execute(sdiSearch, srtText, srtText, CurEditor, GetAllowReplaceTypes);
end;

procedure TDocEditorWindow.acTextReplaceExecute(Sender: TObject);
var
 lAllowReplaceTypes: TtsSrchTypeSet;
begin
 lAllowReplaceTypes := GetAllowReplaceTypes;
 if srtText in lAllowReplaceTypes then
  TTextSearchDlg.Execute(sdiReplace, srtText, srtText, CurEditor, lAllowReplaceTypes);
end;

procedure TDocEditorWindow.acRefSearchExecute(Sender: TObject);
begin

 TTextSearchDlg.Execute(sdiSearch, srtHLink, srtHLink, CurEditor, GetAllowReplaceTypes);
end;

procedure TDocEditorWindow.acRefReplaceExecute(Sender: TObject);
var
 lAllowReplaceTypes: TtsSrchTypeSet;
begin
 lAllowReplaceTypes := GetAllowReplaceTypes;
 if srtHLink in lAllowReplaceTypes then
  TTextSearchDlg.Execute(sdiReplace, srtHLink, srtHLink, CurEditor, lAllowReplaceTypes);
end;

procedure TDocEditorWindow.acFindGeneralSearchExecute(Sender: TObject);
var
 lAllowReplaceTypes: TtsSrchTypeSet;
begin
 lAllowReplaceTypes := GetAllowReplaceTypes;
 TTextSearchDlg.Execute(cSearchMode_Search[lAllowReplaceTypes <> []], CurEditor, lAllowReplaceTypes);
end;

procedure TDocEditorWindow.acFindGeneralReplaceExecute(Sender: TObject);
var
 lAllowReplaceTypes: TtsSrchTypeSet;
begin
 lAllowReplaceTypes := GetAllowReplaceTypes;
 if lAllowReplaceTypes <> [] then
  TTextSearchDlg.Execute(sdiReplace, CurEditor, lAllowReplaceTypes);
end;

procedure TDocEditorWindow.acFindGeneralRepeatSearchExecute(Sender: TObject);
begin
 TTextSearchDlg.FindNext(CurEditor);
end;

procedure TDocEditorWindow.acJurCommentStyleSearchExecute(Sender: TObject);
begin
 TTextSearchDlg.FindStyle(CurEditor, ev_saTxtComment);
end;

procedure TDocEditorWindow.acVersionInfoStyleSearchExecute(Sender: TObject);
begin
 TTextSearchDlg.FindStyle(CurEditor, ev_saVersionInfo);
end;

{** Other}

function TDocEditorWindow.Copy: Boolean;
var
 lControl : TObject;
begin
 Result := True;
 lControl := ActiveControl;

 if (nbkDocPages.PageIndex = piPicture) and
    (lControl <> edtObjectFilePath) and
    (fDocClass <> dtFlash) then
  lControl := ieView
 else
  if lControl = nil then
   Exit;

 l3System.Send(lControl, WM_COPY, 0, 0);
end;

procedure TDocEditorWindow.AddtoClipboard;
begin
 if (ActiveControl is TevCustomEditor) then
  TevCustomEditor(ActiveControl).AddToclipboard;
end;

function TDocEditorWindow.Cut: Boolean;
var
 lControl : TObject;
begin
 Result := True;
 lControl := ActiveControl;
 if (nbkDocPages.PageIndex = piPicture) and
    (lControl <> edtObjectFilePath) and
    (fDocClass <> dtFlash) then
  lControl := ieView
 else
  if lControl = nil then
   Exit;

 l3System.Send(lControl, WM_CUT, 0, 0);
 if lControl = ieView then
 begin
  Document.TextSource.Modified := True;
  if Document.TextSource.Document.ChildrenCount > 0 then
   Document.TextSource.Document.Child[0].AttrW[k2_tiData, nil] := nil;
 end;
end;

(*
function TDocEditorWindow.Paste: Boolean;
var
 lControl : TObject;
begin
 Result := True;
 case nbkDocPages.PageIndex of
  piPicture:
  if fDocClass <> dtFlash then
  begin
   Document.ObjAccess.PasteFromClipboard;
   VisualizeObject;
  end;
  else
  begin
   lControl := ActiveControl;
   l3System.Send(lControl, WM_PASTE, 0, 0);
  end;
 end;

end;
*)

function TDocEditorWindow.Paste: Boolean;
var
 lControl : TObject;
 l_BitmapHandle : THandle;
 l_BitmapReader : TevBitmapHandleReader;
 l_Bitmap       : Il3Bitmap;
 //l_Cursor       : TnevCursor;
 l_Point : IUnknown;
 l_Para         : InevObject;
 lPictureName   : AnsiString;

// l_Stream       : Tl3ClipboardStream;
 l_G : Tk2InPlaceGenerator;
begin
 Result := True;

 (*if nbkDocPages.PageIndex = piPicture then
 begin
  if fDocClass <> dtFlash then
  begin
   l_Stream := Tl3ClipboardStream.Create(l3_fmRead, cf_Bitmap);
   Document.ObjAccess.DataStream := l_Stream as IStream;
   VisualizeObject;
  end
 end
 else
  l3System.Send(lControl, WM_PASTE, 0, 0);*)

 case nbkDocPages.PageIndex of
  piPicture:
  if fDocClass <> dtFlash then
  begin
//   Document.ObjAccess.DataStream := l_Stream as IStream;

   if IsClipboardFormatAvailable(cf_Bitmap) and
    OpenClipboard(Handle) then
   begin
    try
     l_BitmapHandle := GetClipboardData(cf_Bitmap);
     l_BitmapReader := TevBitmapHandleReader.Make(l_BitmapHandle);
     try
      //l_BitmapReader.Bitmap := l_BitmapHandle;
      //lPictureName := Document.ObjAccess.FilePath;
      with Document.TextSource do
      begin
       if (Document.ChildrenCount > 0) then
        l_G := Tk2InPlaceGenerator.Make(Document.Child[0])
       else
       begin
        l_G := nil;
       end;//Document.ChildrenCount > 0
       try
        if (l_G <> nil) then
        begin
//         l_BitmapReader.Generator := l_G;
         l_BitmapReader.NeedOpenDocument := false;
         l_Point := l_G;
        end//l_G <> nil
        else
        begin
         if not Document.QT(InevObject, l_Para) then
          Assert(false);
         l_Point := l_Para.MakePoint;
        end;//l_G <> nil
        DocumentContainer.TagWriter.WriteTagEx(nil, l_BitmapReader, l_Point);
        Modified := True;
       finally
        l3Free(l_G);
       end;//try..finally

(*       if Document.ChildrenCount > 0 then
        Document.DeleteChild(0);
       if not Document.QT(InevObject, l_Para) then
        Assert(false);
       l_Cursor := l_Para.MakePoint;
       DocumentContainer.TagWriter.WriteTagEx(nil, l_BitmapReader, l_Cursor);
       Modified := True;*)
      end;{with Document.TextSource}
      //Document.ObjAccess.FilePath := lPictureName;
     finally
      l3Free(l_BitmapReader);
     end;{try..finally}
    finally
     CloseClipboard;
    end;{try..finally}

    VisualizeObject;
    (*
    if Supports(Document.TextSource.Document.Child[0].Attr[k2_tiObject], Il3Bitmap, l_Bitmap) then
     try
      l_Bitmap.AssignTo(ieView.Bitmap);
     finally
      l_Bitmap := nil;
     end;//try..finally
//    ieView.Bitmap.Assign(
//     (Document.TextSource.Document.Child[0].rAtom(k2_tiObject).AsObject as Tl3BitmapContainer).Bitmap);

    ieView.Update;
    Exit;*)
   end;{IsClipboardFormatAvailable(cf_Bitmap)..}
  end;
  else
  begin
   lControl := ActiveControl;
   l3System.Send(lControl, WM_PASTE, 0, 0);
  end;
 end;

end;

{##Spravka}

function TDocEditorWindow.cnvLo2Up(Sender: TObject; B: PansiChar; L: Long; CharSet: Long): Boolean;
begin
 if (CharSet = CP_OEM) or (CharSet = CP_OEMLite) then
  m2XLTConvertBuff(B, L, Cm2XLTOEM2Upper)
 else m2XLTConvertBuff(B, L, Cm2XLTANSI2Upper);
 Result := True;
end;

function TDocEditorWindow.cnvUp2Lo(Sender: TObject; B: PansiChar; L: Long; CharSet: Long): Boolean;
begin
 if (CharSet = CP_OEM) or (CharSet = CP_OEMLite) then
  m2XLTConvertBuff(B, L, Cm2XLTOEM2Lower)
 else m2XLTConvertBuff(B, L, Cm2XLTANSI2Lower);
 Result := True;
end;

function TDocEditorWindow.cnvUp2LoWithFirst(Sender : TObject; B: PansiChar; L: Long; CharSet: Long) : Boolean;
var
 I: Integer;
begin
 cnvUp2Lo(Sender, B, L, Charset);
 I := 0;
 while (I < L) and l3IsWhiteSpace(B[I]) do
  Inc(I);
 if I < L then
  l3MakeUpperCase(@B[I], 1, CharSet);
 Result := True; 
end;

function TDocEditorWindow.cnvLoUpSwap(Sender: TObject; B: PansiChar; L: Long; CharSet: Long): Boolean;
begin
 if (CharSet = CP_OEM) or (CharSet = CP_OEMLite) then
  m2XLTConvertBuff(B, L, Cm2XLTOEM2SWAP)
 else m2XLTConvertBuff(B, L, Cm2XLTANSI2SWAP);
 Result := True;
end;

function TDocEditorWindow.cnvRus2Eng(Sender: TObject; B: PansiChar; L: Long; CharSet: Long): Boolean;
begin
 if (CharSet = CP_OEM) or (CharSet = CP_OEMLite) then
  m2XLTConvertBuff(B, L, Cm2XLTOEMRus2Eng)
 else m2XLTConvertBuff(B, L, Cm2XLTANSIRus2Eng);
 Result := True;
end;

function TDocEditorWindow.cnvEng2Rus(Sender: TObject; B: PansiChar; L: Long; CharSet: Long): Boolean;
begin
 if (CharSet = CP_OEM) or (CharSet = CP_OEMLite) then
  m2XLTConvertBuff(B, L, Cm2XLTOEMEng2Rus)
 else
  m2XLTConvertBuff(B, L, Cm2XLTANSIEng2Rus);
 Result := True;
end;

function TDocEditorWindow.cnvOEM2ANSI(Sender: TObject; B: PansiChar; L: Long; CharSet: Long): Boolean;
begin
 m2XLTConvertBuff(B, L, Cm2XLTOEM2ANSI);
 Result := True;
end;

function TDocEditorWindow.cnvANSI2OEM(Sender: TObject; B: PansiChar; L: Long; CharSet: Long): Boolean;
begin
 m2XLTConvertBuff(B, L, Cm2XLTANSI2OEM);
 Result := True;
end;

function TDocEditorWindow.Print: Boolean;
var
 l_MacroReplacer : Il3HAFMacroReplacer;
 l_CurEditor     : TevEditor;
 l_CurDocument   : TarCustomDocument;
begin
 Result := True;
 if nbkDocPages.PageIndex = piSrcImage then
 begin
  f_PicImageViewer.Print;
  Exit;
 end;

 if CurEditor = SprTextEditor.DocEditor then
 begin
  l_CurDocument := Document.Spravka;
  l_CurEditor := SprTextEditor.DocEditor;
 end
 else
 begin
  l_CurDocument := Document;
  l_CurEditor := DocTextEditor.DocEditor;
 end;

  l_MacroReplacer := TarMacroReplacer.Make(nil, l_CurDocument, l_CurEditor.HasSelection);
  l_CurEditor.CustomPrint(l_MacroReplacer);
end;

(*
procedure TDocEditorWindow.sbPreviewModeClick(Sender: TObject);
begin
 DocTextEditor.DocEditor.WebStyle := not IniRec.ShowPreview;
 if (SprTextEditor.DocEditor.TextSource <> nil) then
  SprTextEditor.DocEditor.WebStyle  := not IniRec.ShowPreview;
end;
*)

procedure TDocEditorWindow.sbShowSpecSymbolClick(Sender: TObject);
begin
 DocTextEditor.DocEditor.Canvas.DrawSpecial := MainForm.acShowSpecSymbol.Checked;
 SprTextEditor.DocEditor.Canvas.DrawSpecial := MainForm.acShowSpecSymbol.Checked;
 AnnoTextEditor.DocEditor.Canvas.DrawSpecial := MainForm.acShowSpecSymbol.Checked;
 FullNameMEdit.Canvas.DrawSpecial := MainForm.acShowSpecSymbol.Checked;
end;

procedure TDocEditorWindow.sbWebStyleClick(Sender: TObject);
begin
 DocTextEditor.DocEditor.WebStyle := IniRec.ShowWebStyle;
 SprTextEditor.DocEditor.WebStyle := IniRec.ShowWebStyle;
 AnnoTextEditor.DocEditor.WebStyle := IniRec.ShowWebStyle;
end;

procedure TDocEditorWindow.sbShowDocumentPartsClick(Sender: TObject);
begin 
 evSetShowDocumentParts(DocTextEditor.DocEditor, nil, IniRec.ShowDocumentParts);
 evSetShowDocumentParts(SprTextEditor.DocEditor, nil, IniRec.ShowDocumentParts);
end;

procedure TDocEditorWindow.sbUndoClick(Sender: TObject);
begin
 CurEditor.TextSource.Processor.Undo;
end;

procedure TDocEditorWindow.sbRedoClick(Sender: TObject);
begin
 CurEditor.TextSource.Processor.Redo;
end;

{procedure TDocEditorWindow.sbBoldClick(Sender: TObject);
begin
 CurEditor.TextPara.Font.Bold := MainForm.acBold.Checked;
end;

procedure TDocEditorWindow.sbItalicClick(Sender: TObject);
begin
 CurEditor.TextPara.Font.Italic := MainForm.acItalic.Checked
end;

procedure TDocEditorWindow.sbUnderlineClick(Sender: TObject);
begin
 CurEditor.TextPara.Font.Underline := MainForm.acUnderline.Checked;
end;
}
{procedure TDocEditorWindow.sbHidingTextClick(Sender: TObject);
begin
 CurEditor.TextPara.Formatting.Visible := Not MainForm.sbHidingText.Down;
 //CurEditor.SetVisibleEx(Not MainForm.sbHidingText.Down);
end;
}
{procedure TDocEditorWindow.sbLeftJstFClick(Sender: TObject);
begin
 CurEditor.TextPara.Formatting.HorizontalAligment := ed_halLeft;
end;

procedure TDocEditorWindow.sbCenterJstFClick(Sender: TObject);
begin
 CurEditor.TextPara.Formatting.HorizontalAligment := ed_halCenter;
end;

procedure TDocEditorWindow.sbRightJstFClick(Sender: TObject);
begin
 CurEditor.TextPara.Formatting.HorizontalAligment := ed_halRight
end;

procedure TDocEditorWindow.sbWideJstFClick(Sender: TObject);
begin
 CurEditor.TextPara.Formatting.HorizontalAligment := ed_halJustify;
end;

procedure TDocEditorWindow.sbPreformJstFClick(Sender: TObject);
begin
 CurEditor.TextPara.Formatting.HorizontalAligment := ed_halPreformatted;
end;
}

{Format panel}

procedure TDocEditorWindow.FontComboBoxChange(Sender: TObject);
begin
 if not MainForm.FreezeFontCombo then
 begin
  //if Sender = MainForm.FontComboBox then
  //begin
   MainForm.FontSizeComboBox.FontName := MainForm.FontComboBox.FontName;
   CurEditor.TextPara.Font.Name := MainForm.FontComboBox.FontName;
  //end
  //else
  //begin
  // CurEditor.TextPara.Font.Name := MainForm.dxBarComboFontName.Text;
  //end;
 end;
end;

procedure TDocEditorWindow.ColorComboBoxChange(Sender: TObject);
var
 l_Obj: InevObject;
begin
 if not MainForm.FreezeFontCombo then
 begin
  CurEditor.TextPara.Font.ForeColor := MainForm.ColorComboBox.Selected;
  if CurEditor.CurPara.QT(InevObject, l_Obj) then
   l_Obj.Invalidate([]);
 end; // if not MainForm.FreezeFontCombo then
end;

procedure TDocEditorWindow.FontSizeComboBoxChange(Sender: TObject);
begin
 if not MainForm.FreezeFontCombo then
  try
   CurEditor.TextPara.Font.Size := StrToInt(MainForm.FontSizeComboBox.Text);
  except
   try
    MainForm.FontSizeComboBox.FontSize := CurEditor.TextPara.Font.Size;
   except
    on Ek2ParamNotDefined do
     MainForm.FontSizeComboBox.FontSize := 0;
   end;{try..except}
   {EditorWindowFontChange(CurEditor.CurFont);}
  end;
end;

procedure TDocEditorWindow.miUserSetStyle(Sender: TObject);
begin
 if CurEditor.ReadOnly then Exit;
 case TComponent(Sender).Tag of
  1:  CurEditor.TextPara.Style.ID := ev_saColorSelection; {-Цветовое выделение}
  2:  CurEditor.TextPara.Style.ID := ev_saANSIDOS;        {-Моноширинный}
  3:  CurEditor.TextPara.Style.ID := CurEditor.TextSource.Processor.DefaultStyle; {ev_saTxtNormalANSI}  {-Нормальный}
  4:  CurEditor.TextPara.Style.ID := ev_saTxtNormalOEM;   {-Нормальный (OEM)}
  5:  CurEditor.TextPara.Style.ID := ev_saTxtHeader1;     {-Заголовок 1}
  6:  CurEditor.TextPara.Style.ID := ev_saArticleHeader;  {-Заголовок статьи}
  7:  evSetExpiredStyle(CurEditor, ev_saTxtOutOfDate);                 {-Утратил силу}
  8:  CurEditor.TextPara.Style.ID := ev_saTxtComment;     {-Комментарий}
  9:  CurEditor.TextPara.Style.ID := ev_saHyperLinkCont;  {-Продолжение ссылки}
  0:  CurEditor.TextPara.Style.ID := ev_saToLeft;         {-Прижатый влево}
  10: CurEditor.TextPara.Style.ID := ev_saVersionInfo;   {-Информация о версии}
  11: evSetExpiredStyle(CurEditor, ev_saNotApplied);                  {-Не вступил в силу}
  12: CurEditor.TextPara.Style.ID := ev_saTechComment;   {-Тех. коментарий}
  13: CurEditor.TextPara.Style.ID := ev_saEnclosureHeader;   {-Заголовок приложения}    


  //CurEditor.TextPara.Style.ID :=ev_saNormalTable;    {-Нормальный для таблиц}
 end;
end;

procedure TDocEditorWindow.seZoomUpDownClick(Sender: TObject);
var
 lZoom : Integer;
begin
 //if Sender = MainForm.seZoom then                                   
 lZoom := MainForm.seZoom.AsInteger;
 //else
 // lZoom := MainForm.dxseZoom.IntCurValue;

 DocTextEditor.DocEditor.Zoom := lZoom;
 AnnoTextEditor.DocEditor.Zoom := lZoom;
 SprTextEditor.DocEditor.Zoom := lZoom;
 IniRec.Zoom := lZoom;
end;

procedure TDocEditorWindow.seZoomKeyPress(Sender: TObject; var Key: Char);
var
 lZoom : Integer;
begin
 //if Sender = MainForm.seZoom then
  lZoom := MainForm.seZoom.AsInteger;
 //else
 // lZoom := MainForm.dxseZoom.IntCurValue;

 case Byte(Key) of
  vk_RETURN:
  begin
   DocTextEditor.DocEditor.Zoom := lZoom;
   AnnoTextEditor.DocEditor.Zoom := lZoom;
   SprTextEditor.DocEditor.Zoom := lZoom;
   IniRec.Zoom := lZoom;
  end;
  vk_Escape,
  vk_Tab:
   MainForm.seZoom.AsInteger := lZoom;
  else Exit;
 end;

 ReturnFocusToForm;
end;

procedure TDocEditorWindow.seZoomExit(Sender: TObject);
begin
 MainForm.seZoom.AsInteger := CurEditor.Zoom;
 //MainForm.dxseZoom.IntValue := CurEditor.Canvas.Zoom;
end;

procedure TDocEditorWindow.DocEditorZoomChange(Sender: TObject);
begin
 MainForm.seZoom.AsInteger := Tl3Canvas(Sender).Zoom;
end;

(*procedure TDocEditorWindow.StyleComboBoxDropDown(Sender: TObject);
begin
 if Sender = MainForm.StyleComboBox then
  MainForm.StyleComboBox.Items.Assign(CurEditor.TextPara.Style.Styles.Items)
 else
  MainForm.dxBarComboStyle.Items.Assign(CurEditor.TextPara.Style.Styles.Items);
end;
*)

procedure TDocEditorWindow.evntEditorStyleChange(Sender: TObject; const Style: IedStyle);
begin
 EditorStyleChange(Style);
end;

procedure TDocEditorWindow.evntEditorParaChange(Sender: TObject; const TextPara: IedTextParagraph);
begin
 if (csDestroying in ComponentState) then Exit;
 if Sender = CurEditor then
  try
   case TextPara.Formatting.HorizontalAligment of
    ed_halLeft: MainForm.acJustifyLeft.Checked := True;
    ed_halRight: MainForm.acJustifyRight.Checked := True;
    ed_halCenter: MainForm.acJustifyCenter.Checked := True;
    ed_halJustify: MainForm.acJustifyWidth.Checked := True;
    ed_halPreformatted: MainForm.acJustifyPreformatted.Checked := True;
   end;{Case IT}
  except
   on Ek2ParamNotDefined do
    MainForm.acJustifyWidth.Checked := True;
  end;{try..except}

 try
  MainForm.acHidingText.Checked := not TextPara.Formatting.Visible;
 except
  on Ek2ParamNotDefined do
   MainForm.acHidingText.Checked := False;
 end;{try..except}

end;

procedure TDocEditorWindow.evntEditorFontChange(Sender: TObject; const Font: Il3Font);
begin
 MainForm.FreezeFontCombo := True;
 try
  try
   MainForm.acBold.Checked := Font.Bold;
  except
   on Ek2ParamNotDefined do
    MainForm.acBold.Checked := True;
  end;{try..except}

  try
   MainForm.acItalic.Checked := Font.Italic;
  except
   on Ek2ParamNotDefined do
    MainForm.acItalic.Checked := True;
  end;{try..except}

  try
   MainForm.acUnderline.Checked := Font.Underline;
  except
   on Ek2ParamNotDefined do
    MainForm.acUnderline.Checked := True;
  end;{try..except}

  try
   MainForm.FontComboBox.FontName := Font.Name;
  except
   on Ek2ParamNotDefined do
    MainForm.FontComboBox.FontName := '';
  end;{try..except}

  try
   MainForm.ColorComboBox.Selected := Font.ForeColor;
  except
   on Ek2ParamNotDefined do
    MainForm.ColorComboBox.Selected := -1;
  end;{try..except}

  try
   MainForm.FontSizeComboBox.FontSize := Font.Size;
  except
   on Ek2ParamNotDefined do
    MainForm.FontSizeComboBox.FontSize := 0;
  end;{try..except}

 finally
  MainForm.FreezeFontCombo := False;
 end;
end;

procedure TDocEditorWindow.DocTextSourceChangeModified(Sender: TObject);
begin
 DocTextEditor.TextSourceChangeModified(Sender);
end;

procedure TDocEditorWindow.SprTextSourceChangeModified(Sender: TObject);
begin
 SprTextEditor.TextSourceChangeModified(Sender);
end;

function TDocEditorWindow.DocTextEditorDocEditorMouseAction(
 const aHotSpot: IevHotSpot; aButton: Tl3MouseButton;
 anAction: Tl3MouseAction; Keys: TShiftState;
 var NeedAsyncLoop: Boolean): Boolean;
var
 l_Section   : IevdSection;
 l_Hyperlink : IevHyperlink;
begin
 if (aButton = ev_mbLeft) and (anAction = ev_maDouble) then
 begin
  Result := evEditFormula(aHotSpot, DocTextEditor.DocEditor, NeedAsyncLoop);
  if not Result then
   Result := evEditPicture(aHotSpot, DocTextEditor.DocEditor, NeedAsyncLoop);
 end // if (aButton = ev_mbLeft) and (anAction = ev_maDouble) then
 else
 if (aButton = ev_mbRight) and (anAction = ev_maUp) then
 begin
  if l3IOk(aHotSpot.QueryInterface(IevdSection, l_Section)) then
   try
    if (l_Section.Orientation = ev_poPortrait) then
     miPortrait.Checked := True
    else miLandscape.Checked := True;

    case l_Section.PaperSize of
     evd_psA4: miA4.Checked := True;
     evd_psA3: miA3.Checked := True;
     evd_psA2: miA2.Checked := True;
     evd_psA1: miA1.Checked := True;
    end;

    fCurrentTarget := l_Section;
    evPopupMenu(pmSection);
    Result := True;
   finally
    l_Section := nil;
   end{try..finally}
  else
   if l3IOk(aHotSpot.QueryInterface(IevHyperlink, l_Hyperlink)) then
   begin
    fCurrentTarget := l_Hyperlink;
    evPopupMenu(pmHyperlink);
    Result := True;
   end
  else
   Result := False;
 end
 else
  Result := False;
end;

procedure TDocEditorWindow.miGotoNextOccurClick(Sender: TObject);
begin
 sbGotoNextOccurClick(Sender);
end;

procedure TDocEditorWindow.acGoToPageExecute(Sender: TObject);
const
 cJrnlPageNum = 12;
var
 lPageNum,
 lPageNumJrn : Integer;
begin
 lPageNum := TAction(Sender).Tag;

 if lPageNum = 2 then
 begin
  if fDocClass <> Dt_Types.dtText then
   Inc(lPageNum);
 end
 else
  if lPageNum in [cJrnlPageNum..cJrnlPageNum + 2] then
  begin
   try
    lPageNumJrn := lPageNum - cJrnlPageNum;
    if lPageNumJrn = 2 then
     lPageNumJrn := 3;
    nbkJournals.PageIndex := lPageNumJrn;
   except
   end;
   lPageNum := cJrnlPageNum;
  end;

 try
  nbkDocPages.PageIndex := lPageNum;
 except
 end;
end;

procedure TDocEditorWindow.acSetIncludedStageExecute(Sender: TObject);
begin
 if not cbxIncDone.Enabled then Exit;
 if not cbxIncDone.Checked then
  cbxIncDone.Checked := True;
 (Document.AttrManager.GetDocAttribute(atStages) as IStageDocAttributeTool).CloseStage(stFinUrObr);
end;

procedure TDocEditorWindow.acSetFullEditionStageExecute(Sender: TObject);
begin
 if l3TestBit(dsStagesAccessMask, Ord(stFullEdition) - 2) then
  (Document.AttrManager.GetDocAttribute(atStages) as IStageDocAttributeTool).CloseStage(stFullEdition);
end;

procedure TDocEditorWindow.evntGetHotspotInfo(Sender: TObject;
                                              const aHotSpot: IevHotSpot;
                                              const aKeys    : TafwCursorState;
                                              var theInfo: TafwCursorInfo);
var
 l_Tag: Tl3Variant;
begin
 theInfo.rHint := l3CStr(GetReferenceHintString(aHotSpot, l3Str(theInfo.rHint)));
 if evIsFormula(aHotSpot, l_Tag) or evIsPicture(aHotSpot, l_Tag) then
  theInfo.rCursor := ev_csHandPoint;
end;

procedure TDocEditorWindow.acPrevVersionExecute(Sender: TObject);
begin
 //CurHLServ.HLinkTbl.DelDocHLink(DocID);
 { TODO -oВованыч -cРазвитие : Тут нужно передавать либо документ, либо справку в зависимости от того, какая закладка активна }
 ReplaceVersionInEditor(GetCurDocument, m3_dsMain, MainForm.SubDescriptors1);
end;

resourcestring
 rsUserOldEditNamePrefix = 'Извлечения из ';

procedure TDocEditorWindow.acSetSharpReferenceExecute(Sender: TObject);
var
 l_Block : TnevLocation;
 lHLinkAddr : TGlobalCoordinateRec;
 lPack : InevOp;
begin
 with CurEditor do
 begin
  //lPack := StartOp(ev_ocUser + 101);
  try
   // insert #
   InsertBuf(l3PCharLen('# '));

   // покрас комментарием
   MoveLeafCursor(ev_ocCharLeft);
   MoveLeafCursor(ev_ocCharLeft);
   Select(ev_stChar);
   
   CurEditor.TextPara.Style.ID := ev_saTxtComment;

   // ссылка на топик 3000000
   evSaveBlock(CurEditor, l_Block);
   try
    lHLinkAddr.Family := DocFamily;
    lHLinkAddr.Doc := 3000000;
    lHLinkAddr.Sub := 0;

    if (LinkServer(DocFamily).Renum.ConvertToRealNumber(lHLinkAddr.Doc) = -1) and
       (vtMessageDlg(l3Fmt(sidNoDocPresent + ' ' + sidSetRefConfirm,
       [lHLinkAddr.Doc]), mtWarning, [mbYes, mbNo]) <> mrYes) then
     Exit;

    LinkServer(DocFamily).Renum.GetRNumber(lHLinkAddr.Doc);

    SetReferencePrim(l_Block, lHLinkAddr{, CurDocument.HLServer});
   finally
    evFreeBlock(l_Block);
   end;
   evUnselect(CurEditor);
  finally
   lPack := nil;
  end;
 end;
end;

procedure TDocEditorWindow.GetSubListFromSelect(aSubList: Tl3LongintList);

 function DoSub(const aSub: IevSub): Boolean;
 begin
  Result := True;
  aSubList.Add(aSub.ID);
 end;

begin
 aSubList.Clear;
 with CurEditor do
  evGetSubList(TextSource).IterateF(evL2SubA(@DoSub), Selection);
end;

(*
// собирает метки с текущего параграфа
// никогда не использовалась, но может пригодиться

procedure TDocEditorWindow.GetSubListFromSelect(aSubList: Tl3LongintList);

 function DoSub(const aSub: IevSub): Boolean;
 begin
  Result := True;
  aSubList.Add(aSub.ID);
 end;

var
 l_Block : TevBlock;

begin
 aSubList.Clear;

 with CurEditor do
 begin
  CurPara.MakeInterface(ev_iidBlock, l_Block);
  try
   l_Block.Init;
   TextSource.IterateF(evL2SubA(@DoSub), l_Block);
  finally
   l3Free(l_Block);
  end;//try..finally
 end;//with CurEditor
end;
*)

procedure TDocEditorWindow.acGetCorespondentsForBlockExecute(Sender: TObject);
begin
 if CurEditor.Selection.Collapsed then
  Exit;

 if fSelectedSubList = nil then
  fSelectedSubList := Tl3LongintList.Create;

 GetSubListFromSelect(fSelectedSubList);

 if fSelectedSubList.Count = 0 then
  Exit;

 Screen.Cursor := crHourGlass;
 try
  Document.RefreshCorespondentsList(fSelectedSubList);
  ParentDocList.Total := Document.CorespondentsList.Count;
  WarnCorespForBlockPanel.Visible := True;
 finally
  Screen.Cursor := crDefault;
 end;
 nbkDocPages.PageIndex := piCoresp;
 //SplitWindow(piText, piCoresp);
end;

procedure TDocEditorWindow.sbCloseCorespondentsForBlockClick(Sender: TObject);
begin
 Screen.Cursor := crHourGlass;
 try
  Document.RefreshCorespondentsList(nil);
  l3Free(fSelectedSubList);
  ParentDocList.Total := Document.CorespondentsList.Count;
  WarnCorespForBlockPanel.Visible := False;
 finally
  Screen.Cursor := crDefault;
 end;
end;

procedure TDocEditorWindow.acReplaceHRefDocForBlockCorrespondentsExecute(Sender: TObject);
var
 lSubList : Tl3LongintList;

 lHandleSub : TSubID;
 lNewDocID, lNewDocRealID : TDocID;
 lNewSubID : TSubID;

begin
  lNewDocID := cUndefDocID;
  lNewSubID := cUndefSubID;

  if not RequestReplaceCorrespData(lHandleSub, lNewDocID, lNewSubID, Self) then
   Exit;

  lNewDocRealID := LinkServer(DocFamily).Renum.ConvertToRealNumber(lNewDocID);
  if lNewDocRealID <= 0 then
  begin
   vtMessageDlg(l3Fmt(sidNoDocPresent, [lNewDocID]), mtError);
   Exit;
  end;

  Screen.Cursor := crHourGlass;
  try
   if lHandleSub >= 0 then
   begin
    lSubList := Tl3LongintList.Create;
    try
     lSubList.Add(lHandleSub);
     CurDocument.DocServer.ChangeDestDoc(DocID, lNewDocRealID, lNewSubID, lSubList);
    finally
     l3Free(lSubList);
    end;
   end
   else
   if (ActiveControl is TevEditor) then
   begin
    lSubList := Tl3LongintList.Create;
    try
     if CurEditor.Selection.Collapsed then
      Exit;
     GetSubListFromSelect(lSubList);
     if lSubList.Count = 0 then
      Exit;

     CurDocument.DocServer.ChangeDestDoc(DocID, lNewDocRealID, lNewSubID, lSubList);
    finally
     l3Free(lSubList);
    end;
   end
   else
   if fSelectedSubList <> nil then
   begin
    if fSelectedSubList.Count > 0 then
     CurDocument.DocServer.ChangeDestDoc(DocID, lNewDocRealID, lNewSubID, fSelectedSubList, Document.CorespondentsList.CurSab);
   end
   else
    CurDocument.DocServer.ChangeDestDoc(DocID, lNewDocRealID, lNewSubID, nil, Document.CorespondentsList.CurSab);
  finally
   Screen.Cursor := crDefault;
  end;

  vtMessageDlg(l3Fmt(sidProcessDoneFmt, ['замены ссылок']), mtInformation);
end;

procedure TDocEditorWindow.cbCorSourcesChange(Sender: TObject);
var
 lImgFile : AnsiString;
 l_Pages : AnsiString;
 lRec : PPublishDataRec;
 l_IC : TdtImgContainerFile;
 l_TmpName: AnsiString;
 lIndex : Integer;
begin
 if cbCorSources.Items.Count <= 0 then
  Exit;
 with Document.AttrManager.GetDocAttribute(atPublisheds) as IPublishedDocAttributeTool do
 begin
  lIndex := Integer(cbCorSources.Items.Objects[cbCorSources.ItemIndex]);
  lImgFile := GetImagePath(lIndex);
  l_Pages := GetImagePageStr(lIndex);
 end;

 if IsTIFF(lImgFile) then
 begin
  SetPicViewer;
  f_PicImageViewer.LoadFileNew(lImgFile, l_Pages);
 end
 else
 begin
  l_IC := TdtImgContainerFile.Create(lImgFile);
  try
   l_TmpName := l3GetTempFileName('DI');
   TempImgFilename := l_IC.UnwrapFile(l_TmpName);
   if l_TmpName <> TempImgFilename then // на всякий случай проверим...
    DeleteFileA(PansiChar(l_TmpName)); // прибиваем созданный виндой файл (наш уже с другим расширением)
  finally
   l3Free(l_IC);
  end;
  if IsKnownFormat(TempImgFilename) then
  begin
   SetPicViewer;
   f_PicImageViewer.LoadFileNew(TempImgFilename, l_Pages);
  end
  else
  begin
   // показываем некартиночные образы
   SetMiscViewer;
   f_MiscImageViewer.OpenFile(TempImgFilename);
  end;
 end;
end;

procedure TDocEditorWindow.LoadTbCorSourcesChange(Sender: TObject);
var
 I : Integer;
 lAttrIntf : IDocAttribute;
begin
 lAttrIntf := Document.AttrManager.GetDocAttribute(atPublisheds);

 with (lAttrIntf as IPublishedDocAttributeTool) do
 begin
  cbCorSources.Items.Clear;
  if Count > 0 then
   for I := 0 to Pred(Count) do
    if IsImageExists(I) then
     cbCorSources.Items.AddObject(l3Str(ViewString[I]), Pointer(I));
 end;
end;

procedure TDocEditorWindow.tblJournalGetStrItem(Sender: TObject; Index: Integer; var ItemString: Il3CString);
var
 lDNRec : PDisplayLogRec;
 lAttr : TdtAttribute;
begin
 if Sender = tblOrdJournal then
  lAttr := atOrdLogRecords
 else
  lAttr := atJurLogRecords;
 with (Document.AttrManager.GetDocAttribute(lAttr) as IListDocAttribute) do
  ItemString := l3CStr(ViewString[Index]);
end;

function TDocEditorWindow.IsMyDocID(aDocID: TDocID): Boolean;
begin
 Result := (aDocID = DocID) or (aDocID = SprDocID);
end;

function TDocEditorWindow.NormDocID(aDocID : TDocID) : TDocID;
begin
 if aDocID = 0 then
  Result := GetCurDocument.DocID
 else
  Result := aDocID;
end;

procedure TDocEditorWindow.evntFinishInsertFromFile(Sender: TObject);
begin
 inherited;

 //refresh Attributes
 MainAttrExplorer.RefreshAttr;
end;

function TDocEditorWindow.evntDocEditorJumpTo(Sender: TObject;
  const anEffects : TafwJumpToEffects; const aMoniker: IevMoniker): Boolean;
begin
 Result := DocEditorJumpTo(aMoniker);
end;

procedure TDocEditorWindow.acAutoCompleteExecute(Sender: TObject);
begin
 if ActiveControl = DocTextEditor.DocEditor then
  AutoComplete.Apply(DocTextEditor.DocEditor);
end;

procedure TDocEditorWindow.acTextSaveExecute(Sender: TObject);
begin
 Save;
end;

procedure TDocEditorWindow.acSaveLocalExecute(Sender: TObject);
begin
 SaveDocument(False);
end;

procedure TDocEditorWindow.acTextSaveAsExecute(Sender: TObject);
var
 lFileName : AnsiString;
 lFInd : Integer;
begin
 lFInd := 1;
 if vtExecuteSaveDialog(lFileName, lFInd, sidTextOutDlgFilter) then
  SaveExtText(lFileName, lFInd);
end;

procedure TDocEditorWindow.acTextSelectAllExecute(Sender: TObject);
begin
 CurEditor.Select(ev_stDocument);
end;

procedure TDocEditorWindow.acTextCutExecute(Sender: TObject);
begin
 l3System.Send(vtGetFocusedForm, vm_Cut, 0, 0);
end;

procedure TDocEditorWindow.acTextCopyExecute(Sender: TObject);
begin
 l3System.Send(vtGetFocusedForm, vm_Copy, 0, 0);
end;

procedure TDocEditorWindow.acTextPasteExecute(Sender: TObject);
begin
 l3System.Send(vtGetFocusedForm, vm_Paste, 0, 0);
end;

procedure TDocEditorWindow.acTextPasteFromFileExecute(Sender: TObject);
var
 lFileName : TFileName;
 l_Filter  : AnsiString;
begin
 l_Filter := 'Все файлы (*.*)|*.*|Эверест (*.evd)|*.evd|Текст (*.txt)|*.txt|RichText (*.rtf)|*.rtf|Исходники NSRC (*.nsr)|*.nsr';
 l_Filter := evAddSupportedGraphicsFilters(l_Filter);
 if RequestFileName(lFileName, Self, 'Вставить из файла', 'Имя файла', l_Filter) then
 begin
  CurDocument.TextSource.LoadTextFromFile(lFileName, -1, CurEditor.Selection.Cursor);
 end;
end;

procedure TDocEditorWindow.acTextMarkAsNonPrintableExecute(Sender: TObject);
begin
 CurEditor.SetVisibleEx(False);
end;

procedure TDocEditorWindow.acTextMarkAsPrintableExecute(Sender: TObject);
begin
 CurEditor.SetVisibleEx(True);
end;

procedure TDocEditorWindow.acInsSignatureExecute(Sender: TObject);
begin
 CurEditor.InsertSBSPara;
end;

procedure TDocEditorWindow.acInsSectionExecute(Sender: TObject);
begin
 CurEditor.InsertPageBreak(True {Section});
end;

procedure TDocEditorWindow.acInsPageBreakExecute(Sender: TObject);
begin
 CurEditor.InsertPageBreak;
end;

procedure TDocEditorWindow.acInsCreateStructureExecute(Sender: TObject);
var
 lSaveReadOnly : Boolean;
begin
 lSaveReadOnly := DocTextEditor.DocEditor.ReadOnly;
 try
  DocTextEditor.DocEditor.ReadOnly := False;
  CreateBlockStructure(DocTextEditor.DocEditor, DocFamily, DocID);
 finally
  DocTextEditor.DocEditor.ReadOnly := lSaveReadOnly;
 end;
end;

procedure TDocEditorWindow.acTblBoundariesExecute(Sender: TObject);
begin
 with TBorderDlg.Create(Self) do
 try
  Execute(Cureditor.Range);
 finally
  Free;
 end;
end;

procedure TDocEditorWindow.acTblFromTextExecute(Sender: TObject);
begin
 ConvertText2Table(CurEditor);
end;

procedure TDocEditorWindow.acTblAdjustCellsBoundariesExecute(
  Sender: TObject);
begin
 evAlignCellsBoundary(CurEditor);
end;

procedure TDocEditorWindow.acTblAdjustNumberCellExecute(Sender: TObject);
begin
 evTableFixNSRCWidth(CurEditor.Range);
end;

procedure TDocEditorWindow.acTblSetCellWidthExecute(Sender: TObject);
var
 lCellWidth : Integer;
begin
 lCellWidth := 0;
 if RequestIntegerValue(lCellWidth, Self, 'Задание ширины ячеек', 'Ширина ячеек(в символах)') then
  evTableFixNSRCWidth(CurEditor.Range, lCellWidth);
end;

procedure TDocEditorWindow.acLinkSetExecute(Sender: TObject);
begin
 InitSetReference;
end;

procedure TDocEditorWindow.acLinkSetManuallyExecute(Sender: TObject);
var
 lBlock : TnevLocation;
 lHLinkAddr : TGlobalCoordinateRec;
 l_Ext: Boolean;

begin
 evSaveBlock(CurEditor, lBlock);
 try
  lHLinkAddr.Family := DocFamily;

  if not GetIDNumber(lHLinkAddr.Doc, lHLinkAddr.Sub, l_Ext, 'Адрес гиперссылки', 0) then
   Exit;
  if not l_Ext then
   lHLinkAddr.Doc := LinkServer(DocFamily).Renum.GetExtDocID(lHLinkAddr.Doc);

  if (LinkServer(DocFamily).Renum.ConvertToRealNumber(lHLinkAddr.Doc) = -1) and
     (vtMessageDlg(l3Fmt(sidNoDocPresent + ' ' + sidSetRefConfirm,
     [lHLinkAddr.Doc]), mtWarning, [mbYes, mbNo]) <> mrYes) then
   Exit;

  LinkServer(DocFamily).Renum.GetRNumber(lHLinkAddr.Doc);

  //lHLinkAddr.Doc := 1251479;
  //lHLinkAddr.Sub := 0;
  //см TCustomEditorWindow.SetReferenceListF

  SetReferencePrim(lBlock, lHLinkAddr);
 finally
  evFreeBlock(lBlock);
 end;
end;

procedure TDocEditorWindow.acLinkDeleteExecute(Sender: TObject);
begin
 RemoveReference;
end;

procedure TDocEditorWindow.acLinkFollowExecute(Sender: TObject);
begin
 GoByRefClick;
end;

procedure TDocEditorWindow.acFindInFragmentExecute(Sender: TObject);
begin
 with IDocSpecial.Create(Self) do
  try
   ParseSelectTextAndSearch;
   //SearchBySelectText;
  finally
   Free;
  end;
end;

procedure TDocEditorWindow.acToolsCnvUpperCaseExecute(Sender: TObject);
begin
 if not evCursorInSel(CurEditor) then
  Exit;
 CurEditor.TextConvert(cnvLo2Up);
end;

procedure TDocEditorWindow.acToolsCnvLowerCaseExecute(Sender: TObject);
begin
 if not evCursorInSel(CurEditor) then
  Exit;
 CurEditor.TextConvert(cnvUp2Lo);
end;

procedure TDocEditorWindow.acToolsCnvInvertCaseExecute(Sender: TObject);
begin
 if not evCursorInSel(CurEditor) then
  Exit;
 CurEditor.TextConvert(cnvLoUpSwap);
end;

procedure TDocEditorWindow.acToolsCnvRusCharsetExecute(Sender: TObject);
begin
 if not evCursorInSel(CurEditor) then
  Exit;
 CurEditor.TextConvert(cnvEng2Rus);
end;

procedure TDocEditorWindow.acToolsCnvEngCharsetExecute(Sender: TObject);
begin
 if not evCursorInSel(CurEditor) then
  Exit;
 CurEditor.TextConvert(cnvRus2Eng);
end;

procedure TDocEditorWindow.acToolsCnvOEM2ANSIExecute(Sender: TObject);
begin
 if not evCursorInSel(CurEditor) then
  Exit;
 CurEditor.TextConvert(cnvOEM2ANSI);
end;

procedure TDocEditorWindow.acToolsCnvANSI2OEMExecute(Sender: TObject);
begin
 if not evCursorInSel(CurEditor) then
  Exit;
 CurEditor.TextConvert(cnvANSI2OEM);
end;

procedure TDocEditorWindow.acToolsCnvDate2TextExecute(Sender: TObject);
var
 Buff : array[0..30] of Byte;
begin
 with IDocSpecial.Create(Self) do
  try
   if not evCursorInSel(CurEditor) then
    Exit;
   CurEditor.TextBufConvert(cnvDate2Text, @Buff);
  finally
   Free;
  end;
end;

procedure TDocEditorWindow.acToolsCnvMergeParaExecute(Sender: TObject);
begin
 Screen.Cursor := crHourGlass;
 try
  CurEditor.Block2Para;
 finally
  Screen.Cursor := crDefault;
 end;
end;

procedure TDocEditorWindow.acToolsAnalyseHeaderExecute(Sender: TObject);
begin
 with IDocSpecial.Create(Self) do
 try
  AnalyseTextForParam;
 finally
  Free;
 end;
end;

procedure TDocEditorWindow.acToolsFindTNVEDExecute(Sender: TObject);
begin
 with IDocSpecial.Create(Self) do
  try
   FindTNVED;
  finally
   Free;
  end;
end;

procedure TDocEditorWindow.acToolsSubmitJurChangesExecute(Sender: TObject);
begin
 with IDocSpecial.Create(Self) do
 try
  SetVChanged;
 finally
  Free;
 end;
end;

procedure TDocEditorWindow.acToolsUncontrolExecute(Sender: TObject);
begin
 with IDocSpecial.Create(Self) do
  try
   SetVLControl;
  finally
   Free;
  end;
end;

procedure TDocEditorWindow.acToolsAnnounceExecute(Sender: TObject);
begin
 with IDocSpecial.Create(Self) do
  try
   SetAnonced;
  finally
   Free;
  end;
end;

procedure TDocEditorWindow.acToolsRegistrationDeclinedExecute(
  Sender: TObject);
begin
 if vtMessageDlg(l3Fmt(sidQstRunSetMOJNotReg, [TAction(Sender).Caption]), mtConfirmation, [mbYes, mbNo]) = mrYes then
 with IDocSpecial.Create(Self) do
  try
   SetMoJNotReg;
  finally
   Free;
  end;
end;

procedure TDocEditorWindow.acToolsLinkAnnoExecute(Sender: TObject);
var
 lDate : TstDate;
begin
 lDate := DateTimeToStDate(IniRec.AnnoDate);
 if RequestDate(lDate, Self, 'Подключение аннотации', 'Дата') then
  (Document.AttrManager.GetDocAttribute(atJurLogRecords) as ILogDocAttributeTool).AddLogRecOnce(acAnnoDate, lDate, lDate);
end;

procedure TDocEditorWindow.acToolsDocExpiredExecute(Sender: TObject);
begin
 with IDocSpecial.Create(Self) do
  try
   SetAbolished;
  finally
   Free;
  end;
end;

procedure TDocEditorWindow.acToolsMakeOldEditionExecute(Sender: TObject);
var
 lOldEdID : Integer;
begin
 if (Document.AttrManager.GetDocAttribute(atVerLink) as IIntegerDocAttribute).Value > 0 then
 begin
  vtMessageDlg(l3Fmt('Документ #%d имеет полнотекстовую редакцию. Построение кусочной редакции недопустимо!', [DocID]),
   mtWarning);
  exit;
 end;

 lOldEdID := 0;
 if RequestIntegerValue(lOldEdID, Self,
  'Старая редакция', 'ID старой редакции') then
  Macros_UrOpMakeOldEdition(Document, lOldEdID);
end;

procedure TDocEditorWindow.acToolsMakeOtherEditionExecute(Sender: TObject);
var
 lDocID : TDocID;
 lEdWin : TDocEditorWindow;
 lEdWin2 : TDocEditorWindow;
 lOldEdUserID : TDocID;
 lIsOldEdition : Boolean;
 lSaveVerLink : TDocID;

begin
 lOldEdUserID := 0;
 if not GetOldEditionData(lOldEdUserID, lIsOldEdition) then
  Exit;

 if lOldEdUserID <= 0 then
  Exit;

 if lIsOldEdition then
  Document.MakeDocCopy(lOldEdUserID, askMakeOldEdition)
 else
  Document.MakeDocCopy(lOldEdUserID, askMakeNextEdition);

 lDocID := LinkServer(DocFamily).Renum.ConvertToRealNumber(lOldEdUserID);
 if lDocID <= 0 then
  raise Exception.Create(Format(sidDocLoadFault, [sidMakeCopyFault]));

 lEdWin := TDocEditorWindow(MainForm.RunTextEditor(DocFamily, lDocID));

 if lIsOldEdition then
 begin
  lSaveVerLink := (Document.AttrManager.GetDocAttribute(atVerLink) as IIntegerDocAttribute).Value;
  (Document.AttrManager.GetDocAttribute(atVerLink) as IIntegerDocAttribute).Value := lOldEdUserID;
  if lSaveVerLink > 0 then
   (lEdWin.Document.AttrManager.GetDocAttribute(atVerLink) as IIntegerDocAttribute).Value := lSaveVerLink;
 end
 else
 begin
  lSaveVerLink := Document.GetPrevVerDocID;
  (lEdWin.Document.AttrManager.GetDocAttribute(atVerLink) as IIntegerDocAttribute).Value := Document.UserDocID;
  if lSaveVerLink > 0 then
  begin
   lEdWin2 := TDocEditorWindow(MainForm.RunTextEditor(DocFamily, lSaveVerLink));
   (lEdWin2.Document.AttrManager.GetDocAttribute(atVerLink) as IIntegerDocAttribute).Value := lEdWin.Document.UserDocID;
   lEdWin2.Save;
   lEdWin2.Close;

   // хакерство, нужно через атрибуты
   //DocumentServer(CurrentFamily).FileTbl.SetVerLink(lSaveVerLink, lEdWin.DocID);
  end;
 end;
end;

procedure TDocEditorWindow.acToolsOpenAllEditionsExecute(Sender: TObject);
var
 I : Longint;
begin
 for I := 0 to Pred(lstVersion.Total) do
  MainForm.RunTextEditor(DocFamily, (Document.AttrManager.GetDocAttribute(atVersions) as IListDocAttribute).Handle[I]);
end;

procedure TDocEditorWindow.acToolsDeleteReferenceExecute(Sender: TObject);
begin
 if vtMessageDlg(l3Fmt(sidSomeDelAsk, ['справку']), mtConfirmation,
  [mbYes, mbNo], 0, mbNo, mbNo) = mrYes then
 begin
  if nbkDocPages.PageIndex = piSprv then
   nbkDocPages.PageIndex := piText;

  nbkDocPages.PagesEnabled[piSprv] := False;

  edtSprDocID.AsInteger := -1;
  edtSprDocID.Enabled := False;
  Document.DeleteSpr;
 end;
end;

procedure TDocEditorWindow.acToolsDeleteAnnoExecute(Sender: TObject);
begin
 if vtMessageDlg(l3Fmt(sidSomeDelAsk, ['аннотацию']), mtConfirmation,
  [mbYes, mbNo], 0, mbNo, mbNo) = mrYes then
 begin
  if nbkDocPages.PageIndex = piAnno then
   nbkDocPages.PageIndex := piText;

  Document.DeleteAnno;

  edtAnnoName.Text := '';
  //edtAnnoName.Tag := 0;
  edtAnnoName.Modified := false;
  RefreshJurJorunal;
 end;
end;

procedure TDocEditorWindow.acPMCorrDeleteExecute(Sender: TObject);
begin
 if ParentDocList.Current > -1 then
 begin
  Document.CorespondentsList.DelDoc(ParentDocList.Current);
  ParentDocList.Total := Document.CorespondentsList.Count;
 end; // if ParentDocList.Current > -1 then
end;

procedure TDocEditorWindow.acPMBTreeDeleteExecute(Sender: TObject);
var
 l_Sub : IevSub;
begin
 if l3IOk(otlBlocks.GetCurrentNode.QueryInterface(IevSub, l_Sub)) then
  try
   fSubOnPopUp := l_Sub.ID;
   acPMSubAncorDelete.Execute;
  finally
   l_Sub := nil;
  end;{try..finally}
end;

procedure TDocEditorWindow.acPMSubAncorDeleteExecute(Sender: TObject);
begin
 if fSubOnPopUp = 0 then
  Exit;
 RemoveSub(fSubOnPopUp, -1);
end;

procedure TDocEditorWindow.acPMSubAncorSaveExecute(Sender: TObject);
var
 ItSubRec : TGlobalCoordinateRec;
begin
 with ItSubRec do
 begin
  Family := DocFamily;
  if CurEditor = DocTextEditor.DocEditor then
   Doc := DocID
  else Doc := Document.Spravka.DocID;
  Sub := fSubOnPopUp;
  ArchiObjectList.AddObjRec('', ddBackHyperLink, @ItSubRec);
 end;
end;

procedure TDocEditorWindow.acPMSubCopyAddrExecute(Sender: TObject);
var
 lDoc : TDocID;
 lSub : TSubID;
 lStr : AnsiString;
begin
 if CurEditor = DocTextEditor.DocEditor then
  lDoc := Document.UserDocID
 else lDoc := Document.Spravka.UserDocID;
 lSub := fSubOnPopUp;

 { Так Бушуева просила
 if lSub = 0 then
  lStr := format('%d', [lDoc])
 else}
  lStr := format('%d.%d', [lDoc, lSub]);

 Clipboard.AsText := lStr;
end;

procedure TDocEditorWindow.acPMSubAncorEditExecute(Sender: TObject);
begin
 if fSubOnPopUp = 0 then
  Exit;
 SubNameEdit(fSubOnPopUp);
end;

procedure TDocEditorWindow.acPMSubAncorSyncExecute(Sender: TObject);
begin
 SubShowPanelClickSub(Sender, -(10 + sfbitKeyWords), fSubOnPopUp, afw_ckDouble);
end;

procedure TDocEditorWindow.acPMSubAncorSetClassExecute(Sender: TObject);
begin
 EditClassOnSub(fSubOnPopUp, atClasses, nil);
end;

procedure TDocEditorWindow.acPMSubAncorSetPrefixExecute(Sender: TObject);
begin
 EditClassOnSub(fSubOnPopUp, atPrefixes, nil);
end;

procedure TDocEditorWindow.acPMSubAncorSetKeyExecute(Sender: TObject);
begin
 EditClassOnSub(fSubOnPopUp, atKeyWords, nil);
end;

procedure TDocEditorWindow.acPMSubAncorSetTypeExecute(Sender: TObject);
begin
 EditClassOnSub(fSubOnPopUp, atTypes, nil);
end;

procedure TDocEditorWindow.acPMSubAncorSetTOCExecute(Sender: TObject);
begin
 SetContentsSub(fSubOnPopUp);
end;

procedure TDocEditorWindow.acPMSubAncorLinkExtObjectExecute(
  Sender: TObject);
begin
 SetRtfPropOnSub(fSubOnPopUp);
end;

procedure TDocEditorWindow.acPMTextSetLabelExecute(Sender: TObject);
begin
 SetSubPrim(stSub);
end;

procedure TDocEditorWindow.acPMTextSetClassExecute(Sender: TObject);
begin
 ShowClassEditor(atClasses);
end;

procedure TDocEditorWindow.acPMTextSetPrefixExecute(Sender: TObject);
begin
 ShowClassEditor(atPrefixes);
end;

procedure TDocEditorWindow.acPMTextSetKeyExecute(Sender: TObject);
begin
 ShowClassEditor(atKeyWords);
end;

procedure TDocEditorWindow.acPMTextSetTypeExecute(Sender: TObject);
begin
 ShowClassEditor(atTypes);
end;

procedure TDocEditorWindow.acPMTextInsertTextExecute(Sender: TObject);
var
 G               : TevGenerator;
 l_InPlaceCursor : TnevCursor;
 l_Block         : InevTagSelection;
 l_Cursor        : TnevCursor;
 InsText         : AnsiString;
 l_Pack          : InevOp;
 Gj              : IevJoinGenerator;
 CN              : Il3Node;
 lTreeDO         : IevTreeDataObject;
 lFilter         : TGetClipboardLightFilter;
begin
 if GetInsTextNode(CN) then
  with CurEditor do
  begin
   Application.ProcessMessages;
   l_Pack := CurEditor.StartOp;
   try
    l_InPlaceCursor := evCloneCursor(CurEditor);
    try
     if Supports(CN, IevTreeDataObject, lTreeDO) then
     begin
      try
       G := evGetNewTextGenerator(CurEditor);
       try
        if Supports(G, IevJoinGenerator, Gj) then
         Gj.NeedJoin := True;
        try
         lFilter := TGetClipboardLightFilter.Create;
         try
          lFilter.Family := DocFamily;
          lFilter.ExpandedFormat := False; //вставлять субатрибуты
          //if CurEditor = SprTextEditor.DocEditor then
          // lFilter.TargetDocID := SprDocID
          //else
          // lFilter.TargetDocID := DocID;

          lFilter.OnGetNewHandleID := CurDocument.TextSource.evntGetNewHandleID;
          //lFilter.OnGetReader := DocumentSourceGetReader;
          lFilter.Generator := G;
           G := lFilter;

          G.Start;
          G.StartChild(k2_typDocument);
          lTreeDO.Store(G, k2_tiVoid, 0);
          G.Finish;
          G.Finish;
          finally
           l3Free(lFilter);
          end;//try..finally
        finally
         Gj := nil;
        end;
       finally
        evFreeGenerator(G);
       end;
      finally
       lTreeDO := nil;
      end;
     end
     else 
      InsertBuf(CN.Text);
     l_Block := evGetMostInnerRange(CurEditor);
     if l_Block <> nil then
      try
       l_Cursor := evCloneCursor(CurEditor);
       try
        evSelectPoint(CurEditor, l_InPlaceCursor);
        try
         l_Block.SearchReplace(TevBMTextSearcher.Make('|'), TevTextReplacer.Make(''),
                  TnevConfirm.Make, evMostInnerCursor(CurEditor), l_Pack, False);
        except
         on EevSearchFailed do
          evSelectPoint(CurEditor, l_Cursor);
        end;//try..except
       finally
        evFreeCursor(l_Cursor);
       end;//try..finally
      finally
       l_Block := nil;
      end; {try..finally}
    finally
     evFreeCursor(l_InPlaceCursor);
    end; {try..finally}
   finally
    l_Pack := nil;
   end;//try..finally
  end;
end;

procedure TDocEditorWindow.acPMTextFindInterpretationExecute(
  Sender: TObject);
begin
 with IDocSpecial.Create(Self) do
  try
   SearchBySelectText(itDictEntry);
  finally
   Free;
  end;
end;

procedure TDocEditorWindow.acPMTextJumpToSubExecute(Sender: TObject);
var
 lDocID : Integer;
begin
 with TIntegerEditDlg.Create(Self) do
  try
   Caption := 'Перейти на метку';
   LabelText := 'Номер метки';
   Value := IniRec.SrchSubID;
   if Execute then
   begin
    if CurEditor = SprTextEditor.DocEditor then
     lDocID := SprDocID
    else
     lDocID := DocID;

    GoToSub(Value, lDocID);
    IniRec.SrchSubID := Value;
   end;
  finally
   Free;
  end;
end;


procedure TDocEditorWindow.acPMTextJumpToParaExecute(Sender: TObject);
var
 I : Integer;
 lPack : InevOp;
begin
 with TIntegerEditDlg.Create(Self) do
  try
   Caption := 'Сместиться по параграфам';
   LabelText := 'Количество параграфов';

   if Execute then
   begin
    lPack := CurEditor.StartOp(ev_ocUser + 100);
    try
     for I := 1 to Value do
      CurEditor.MoveLeafCursor(ev_ocParaDown);
    finally
     lPack := nil; {FinishOp;}
    end;
   end;
   //If Execute then GoToSub(Value, True);
  finally
   Free;
  end;
end;

procedure TDocEditorWindow.acPMTextDocInfoExecute(Sender: TObject);
begin
 with IDocSpecial.Create(Self) do
  try
   ShowDocInfo;
  finally
   Free;
  end;
end;

procedure TDocEditorWindow.acPMAnnoSetClassExecute(Sender: TObject);
begin
 EditClassOnSub(0, atAnnoClasses, nil);
end;

procedure TDocEditorWindow.acPMMainSplitWindowExecute(Sender: TObject);
var
 CPage : TOvcNotebookPage;
begin
 SplitLog := not SplitLog;
 acPMMainSplitWindow.Checked := SplitLog;
 acPMMainSwapPanels.Enabled := SplitLog;

 if SplitLog then
 begin
  AlonePageIndex := nbkDocPages.PageIndex;
  CPage := TOvcNotebookPage(nbkDocPages.PageList[AlonePageIndex]);

  if nbkDocPages.PageIndex = 0 then
   nbkDocPages.PageIndex := 1
  else nbkDocPages.PageIndex := 0;

  CPage.Parent := Self;
  CPage.Align := alBottom;
  CPage.Height := Height div 2;
  CPage.Visible := True;

  WinSplitLine.Align := alTop;
  WinSplitLine.Align := alBottom;
  WinSplitLine.Height := 4;
  WinSplitLine.SplitControl := CPage;
  WinSplitLine.Visible := True;
 end
 else
 begin
  WinSplitLine.Align := alBottom;
  WinSplitLine.Visible := False;
  CPage := TOvcNotebookPage(nbkDocPages.PageList[AlonePageIndex]);
  CPage.Visible := False;
  CPage.Parent := nbkDocPages;
  CPage.Align := alNone;
  AlonePageIndex := -1;
 end;
end;

procedure TDocEditorWindow.acPMMainSwapPanelsExecute(Sender: TObject);
var
 CPage : TOvcNotebookPage;
 OldAlonePageIndex : Integer;
begin
 if AlonePageIndex = -1 then
  Exit;

 CPage := TOvcNotebookPage(nbkDocPages.PageList[AlonePageIndex]);
 CPage.Visible := False;
 CPage.Parent := nbkDocPages;
 CPage.Align := alNone;

 OldAlonePageIndex := AlonePageIndex;
 AlonePageIndex := nbkDocPages.PageIndex;

 if (Sender <> Self) then
  nbkDocPages.PageIndex := OldAlonePageIndex;

 CPage := TOvcNotebookPage(nbkDocPages.PageList[AlonePageIndex]);
 CPage.Parent := Self;
 CPage.Align := alBottom;
 CPage.Height := Height div 2;
 CPage.Visible := True;

 //WinSplitLine.ControlSecond:=CPage;
 WinSplitLine.Align := alTop;
 WinSplitLine.Visible := False;
 WinSplitLine.Align := alBottom;
 WinSplitLine.SplitControl := CPage;
 WinSplitLine.Visible := True;
end;

procedure TDocEditorWindow.acPMSubEditNameExecute(Sender: TObject);
begin
 if SubList.Total = 0 then
  Exit;
 SubNameEdit(SubList.Items.DataInt[SubList.Current]);
end;

procedure TDocEditorWindow.acPMSubDeleteExecute(Sender: TObject);
begin
 if (SubList.Total = 0) or (SubList.Current < 0) then
  Exit;
 //fEditor := DocEditor;
 RemoveSub(SubList.Items.DataInt[SubList.Current], SubList.Current);
end;

procedure TDocEditorWindow.acPMSectionPortraitExecute(Sender: TObject);
begin
 if (fCurrentTarget <> nil) then
 begin
  IevdSection(fCurrentTarget).Orientation := ev_poPortrait;
  fCurrentTarget := nil;
 end;
end;

procedure TDocEditorWindow.acPMSectionLandscapeExecute(Sender: TObject);
begin
 if (fCurrentTarget <> nil) then
 begin
  IevdSection(fCurrentTarget).Orientation := ev_poLandscape;
  fCurrentTarget := nil;
 end;
end;

procedure TDocEditorWindow.acPMSectionA4Execute(Sender: TObject);
begin
 if (fCurrentTarget <> nil) then
 begin
  IevdSection(fCurrentTarget).PaperSize := evd_psA4;
  fCurrentTarget := nil;
 end;
end;

procedure TDocEditorWindow.acPMSectionA3Execute(Sender: TObject);
begin
 if (fCurrentTarget <> nil) then
 begin
  IevdSection(fCurrentTarget).PaperSize := evd_psA3;
  fCurrentTarget := nil;
 end;
end;

procedure TDocEditorWindow.acPMSectionA2Execute(Sender: TObject);
begin
 if (fCurrentTarget <> nil) then
 begin
  IevdSection(fCurrentTarget).PaperSize := evd_psA2;
  fCurrentTarget := nil;
 end;
end;

procedure TDocEditorWindow.acPMSectionA1Execute(Sender: TObject);
begin
 if (fCurrentTarget <> nil) then
 begin
  IevdSection(fCurrentTarget).PaperSize := evd_psA1;
  fCurrentTarget := nil;
 end;
end;

procedure TDocEditorWindow.acPMAttrEditExecute(Sender: TObject);
begin
 otlAttributesActionElement(Sender, -1 {current});
end;

procedure TDocEditorWindow.acPMAttrSaveExecute(Sender: TObject);
var
 ItDataRec : TDictItemAddr;

 function IterHandler(const CurNode: Il3Node): Boolean; far;
 var
  lCurAttrID  : TdtAttribute;
  lItemIndex  : Integer;
 begin
  //TarAttributeContainerNode((CurNode as Il3NodeWrap).GetSelf)
  with (CurNode as Il3HandleNode) do
   if TvtOutliner(ActiveControl).CTree.IsSelect(CurNode) then
   begin
    if ((CurNode.ParentNode as Il3HandleNode).Handle = 0) then Exit; //root
    with (CurNode.ParentNode as IListDocAttribute) do
    begin
     lItemIndex := Tl3ListItemNode((CurNode as Il3NodeWrap).GetSelf).ListItem;
     with ItDataRec do
     begin
      FamID := DocFamily;
      DictID := (CurNode.ParentNode as Il3HandleNode).Handle;
      ItemID := Handle[lItemIndex];
      ItemTag := Pointer(Child[lItemIndex].AsRef);
      IUnknown(ItemTag)._AddRef;
      ArchiObjectList.AddObjRec(ViewString[lItemIndex].S, ddDictItem, @ItDataRec, 0 {DataSize});
     end;
    end;
   end;
 end;

begin
 if (ActiveControl is TvtOutliner) then
  TvtOutliner(ActiveControl).IterateF(Tl3NodeAction(l3L2FA(@IterHandler)), 0);
end;

procedure TDocEditorWindow.acPMAttrDeleteExecute(Sender: TObject);
begin
 if not (ActiveControl is TvtOutliner) then exit;
 if ActiveControl = MainAttrExplorer.otlAttributes then
  MainAttrExplorer.miDelDocAttrClick(Self)
 else
  SubAttrExplorer.miDelDocAttrClick(Self);
end;

procedure TDocEditorWindow.acPMAttrShowOwnersExecute(Sender: TObject);
var
 lCN : Il3Node;
begin
 lCN := SubAttrExplorer.otlAttributes.GetCurrentNode As Il3Node;
 with (lCN as Il3HandleNode) do
  if ((lCN.ParentNode as Il3HandleNode).Handle <> 0) then
   ShowOwnerSubList(TdtAttribute((lCN.ParentNode as Il3HandleNode).Handle), Handle);
end;

procedure TDocEditorWindow.acPMJournalDeleteExecute(Sender: TObject);
var
 lJrnlKind : TdtAttribute;
 lIndex : Integer;
 lLogTool : ILogDocAttributeTool;
 lAllow : boolean;
begin
 if ActiveControl = tblJurJournal then
 begin
  lJrnlKind := atJurLogRecords;
  lIndex := tblJurJournal.Current;
 end
 else
  if ActiveControl = tblOrdJournal then
  begin
   lJrnlKind := atOrdLogRecords;
   lIndex := tblOrdJournal.Current;
  end
  else
   Exit;

 if lIndex < 0 then Exit;


 lLogTool := (Document.AttrManager.GetDocAttribute(lJrnlKind) as ILogDocAttributeTool);
 lAllow := lLogTool.IsAnnoAction(lIndex);
 lAllow := (lAllow and l3TestMask(Document.LockMask, acgAnno)) or
           (not lAllow and l3TestMask(Document.LockMask, acgJurOp));

 if not lAllow then
 begin
  vtMessageDlg(l3CStr('Вам запрещено удалять такие операции.'), mtError);
  Exit;
 end;

 if vtMessageDlg(l3CStr('Вы действительно хотите удалить Лог-запись?'), mtWarning, [mbYes, mbNo]) = mrYes then
 begin
  {$IfDef DelLogTrace}
  l3System.Msg2Log('Delete Journal: DocID=%d, DocEditorWindow.acPMJournalDeleteExecute', [DocID]);
  {$EndIf}
  lLogTool.Delete(lIndex);
 end;
end;

procedure TDocEditorWindow.acPMPicStretchExecute(Sender: TObject);
begin
 acPMPicStretch.Checked := not acPMPicStretch.Checked;
 SyncStretch;
end;

procedure TDocEditorWindow.CheckForNOTTM(aAttribute: IDocAttribute);
var
 l_IsDelayed: Boolean;
  begin
 l_IsDelayed := (aAttribute as IActiveIntervalsAttributeTool).IsDelayed;
 if l_IsDelayed and (not cbxNotTM.Checked) then
  cbxNotTM.Checked := True;
 if (not l_IsDelayed) and cbxNotTM.Checked then
  cbxNotTM.Checked := False;
end;

procedure TDocEditorWindow.evntChangeDocAttribute(const aSender: IDocAttribute);
var
 lMask : Byte;
 lSubID : TSubID;
begin
 if csDestroying in ComponentState then
  Exit;

 if fGroupMode then
  Exit;

 case aSender.AttrID of
  atPublisheds :
   begin
    PageLoad[piSrcImage] := False;
    CheckDocImage;
   end;

  atActiveIntervals :
   begin
    CheckShowWarnPanel;
    CheckForNOTTM(aSender);
   end;

  atAccGroups :
   begin
    Relock;
    if MainForm.ActiveMDIChild = Self then
     SetSpeedButton(Enabled);
   end;
  (*
  atKeyWords,
  atClasses,
  atTypes:
   if Document.IsPossibleText then
   begin
    case aSender.AttrID of
     atKeyWords: lMask := sfKeyWords;
     atClasses: lMask := sfTreeNodes;
     atTypes: lMask := sfDocType;
     else  exit;
    end; //case aAttrID of

    lSubID := (aSender as IDocAttributeManager).SubID;
    if lSubID = AllSubs then
     ReBuildSubFlags
    else
    begin
     if not fStructInit then Exit;
     with evGetSubList(DocTextEditor.DocEditor.TextSource).Sub[lSubID] do
      if aSender.IsEmpty then
       Flags := Flags and not lMask
      else
       Flags := Flags or lMask;
    end;
   end;
   *)
 end; //case aSender.aAttrID of
end;

procedure TDocEditorWindow.JumpToSubNode(aNode: Il3Node);
var
 l_Sub: IevSub;
begin
 if l3IOk(aNode.QueryInterface(IevSub, l_Sub)) then
  try
   with DocTextEditor.DocEditor do
   begin
    l_Sub.Select(Selection);
    SetFocus;
   end;
  finally
   l_Sub := nil;
  end;{try..finally};
end;

procedure TDocEditorWindow.ClassSubsPanelResize(Sender: TObject);
begin
 btnAllSabs.Left := ClassSubsPanel.ClientWidth - btnAllSabs.Width - 3;
 cbClassSubs.Width := btnAllSabs.Left - cbClassSubs.Left - 3;
end;

procedure TDocEditorWindow.btnAllSabsClick(Sender: TObject);
begin
 SubAttrExplorer.CurSub := -1;
 cbClassSubs.ItemIndex := -1;
end;

procedure TDocEditorWindow.Panel1Resize(Sender: TObject);
begin
 edtObjectFilePath.Width := Panel1.Width - Panel4.Width - 12;
 Panel4.Left := edtObjectFilePath.Left + edtObjectFilePath.Width + 2;
end;

procedure TDocEditorWindow.btnReplaceObjClick(Sender: TObject);
var
 l_Filename: AnsiString;
begin
 if dlgOpenObjectFile.Execute then
 begin
  l_Filename := ExtractFileName(dlgOpenObjectFile.FileName);
  edtObjectFilePath.Text := l_Filename;
  Document.ObjAccess.FilePath := l_Filename;
  Document.ObjAccess.LoadFromFile(dlgOpenObjectFile.FileName);
  VisualizeObject;
 end;
end;

procedure TDocEditorWindow.VisualizeObject;
var
 l_IStream: IStream;
 l_Stream: TStream;
begin
 if fDocClass = dtObject then
 begin
  //if Document.ObjAccess.Bitmap = nil then
  //begin
  // ieView.Bitmap.Assign(nil);
  // ieView.Enabled := False;
  // Exit;
  //end;

  Document.ObjAccess.BitmapAssignTo(ieView.IEBitmap);
  ieView.Enabled := Document.ObjAccess.ObjType = dotImage;
  if Document.ObjAccess.ObjType = dotImage then
  begin
   SyncStretch;
  end
  else
  with ieView do
  begin
   AutoFit := False;
   Zoom := 100;
  end;
 end
 else
 begin
  if (Document.ObjAccess.DataStream <> nil){ and (Document.ObjAccess.DataStream.Size > 0)} then
  begin
   l3IStream2Stream(Document.ObjAccess.DataStream, l_Stream);
   try
    f_FlashView.LoadMovieFromStream(l_Stream);
   finally
    l3Free(l_Stream);
   end;
  end;
 end;
end;

procedure TDocEditorWindow.btnExportObjClick(Sender: TObject);
begin
 dlgSaveObjectFile.FileName := Document.ObjAccess.FilePath;
 if dlgSaveObjectFile.Execute then
 begin
  Document.ObjAccess.ExportToFile(dlgSaveObjectFile.Filename);
 end;
end;

procedure TDocEditorWindow.SyncStretch;
begin
 with ieView do
  if miStretchPicture.Checked then
  begin
   AutoFit := True;
   Update;
  end
  else
  begin
   AutoFit := False;
   Zoom := 100;
  end;
end;

procedure TDocEditorWindow.acInsFormulaExecute(Sender: TObject);
begin
 evInsertFormula(CurEditor);
end;

procedure TDocEditorWindow.FormShow(Sender: TObject);
begin
 evSetTextParaLimit(FullNameMEdit.TextSource, 1);
 {$IFNDEF InsiderTest}
 UserConfig.Section := 'PREFERENCES';
 acToolsAutolink.Visible := UserConfig.ReadParamBoolDef(sEnableAutolinkParam, False);
 {$ENDIF InsiderTest}
 f_CanStylizeBlocks := True; //UserConfig.ReadParamBoolDef(sCanStylizeBlocks, False);
end;

function TDocEditorWindow.IsObjChanged: Boolean;
begin
 case fDocClass of
  dtObject: Result := (ieView.Tag = 1);
  dtFlash : Result := (f_FlashView.Tag = 1);
 else
  Result := False;
 end;
end;

procedure TDocEditorWindow.pnlObjectResize(Sender: TObject);
begin
 if fDocClass = dtFlash then
  f_FlashView.Perform(CM_RECREATEWND,0,0);
end;

procedure TDocEditorWindow.FormCreate(Sender: TObject);
var
 I: Integer;
begin
 // DocTextEditor.DocEditor.NeedSpace4SpecialDraw := True;             
 cbClassSubs.ShowFullPath := False;
 for I := 0 to cMaxUrgency do
  cbUrgency.Items.Add(cUrgencyCaption[I]);
end;

procedure TDocEditorWindow.cbUrgencyChange(Sender: TObject);
begin
 cbUrgency.Tag := 1;
 CheckUrgencyDisp;
end;

procedure TDocEditorWindow.pm_SetTempImgFilename(const Value: AnsiString);
begin
 if f_TempImgFilename <> Value then
 begin
  CleanupTempImgFile;
  f_TempImgFilename := Value;
 end;
end;

procedure TDocEditorWindow.CleanupTempImgFile;
begin
 if FileExists(f_TempImgFilename) then
  DeleteFileA(PansiChar(f_TempImgFilename));
end;

procedure TDocEditorWindow.acLinkSaveExecute(Sender: TObject);
var
 l_AddresList : IevAddressList;
 lGCRec : TGlobalCoordinateRec;
 i : Integer;
begin
 if (fCurrentTarget <> nil) then
 begin
  if l3IOk(IevHyperlink(fCurrentTarget).QueryInterface(IevAddressList, l_AddresList)) then
  for I := 0 to pred(l_AddresList.Count) do
   with l_AddresList[I]{$IfDef XE4}.rTafwAddress{$EndIf} do
   begin
    lGCRec.Family := DocFamily;
    lGCRec.Doc := DocID;
    lGCRec.Sub := SubID;
    ArchiObjectList.AddObjRec('', ddBackHyperLink, @lGCRec);
   end;
  fCurrentTarget := nil;
 end;
end;

procedure TDocEditorWindow.acLinkDeleteContextExecute(Sender: TObject);
begin
 if (fCurrentTarget <> nil) then
  RemoveReference(nil, IevHyperlink(fCurrentTarget));
end;

procedure TDocEditorWindow.acLinkFollowContextExecute(Sender: TObject);
begin
 if (fCurrentTarget <> nil) then
  GoByRefClick(IevHyperlink(fCurrentTarget));
end;

procedure TDocEditorWindow.pnlDocImageContainerResize(Sender: TObject);
begin
 cbCorSources.Width := TPanel(Sender).Width - cbCorSources.Left - 6;
end;

procedure TDocEditorWindow.SetPicViewer;
begin
 if f_PicImageViewer = nil then
 begin
  l3Free(f_MiscImageViewer);
  f_PicImageViewer := TfrmImgViewer.Create(nil);
  f_PicImageViewer.Parent := pnlDocImageContainer;
  with f_PicImageViewer do
  begin
   Align := alClient;
  end;
  cbCorSources.BringToFront;
 end;
end;

procedure TDocEditorWindow.SetMiscViewer;
begin
 if f_MiscImageViewer = nil then
 begin
  l3Free(f_PicImageViewer);
  f_MiscImageViewer := TfrmMiscDocImgView.Create(nil);
  f_MiscImageViewer.Parent := pnlDocImageContainer;
  with f_MiscImageViewer do
  begin
   Align := alClient;
  end;
  cbCorSources.BringToFront;
 end;
end;

procedure TDocEditorWindow.CheckDocImage;
begin
 with (Document.AttrManager.GetDocAttribute(atPublisheds) as IListDocAttribute) do
  nbkDocPages.PagesEnabled[piSrcImage] := Count > 0;
end;

procedure TDocEditorWindow.CheckForCourtCase;
var
 l_Attr     : IListDocAttribute;
 l_CourtList: Tl3LongintList;
 l_CheckList: Tl3LongintList;
 I,J        : Integer;
 l_Node     : Il3Node;
 l_Found    : Boolean;
 l_Searcher : TevRegularExpressionSearcher;
 l_Op       : TevSearchOptionSet;
 l_NumStr   : AnsiString;
 l_Tags     : IevTaggedSearcher;
 //l_DNRec    : TDNAttrRec;

 function AddHandleToCheckList(const Intf: Il3Node): Boolean;
 var
  l_HN: Il3HandleNode;
 begin
  if Supports(Intf, Il3HandleNode, l_HN) then
   l_CheckList.Add(l_HN.Handle);
 end;

begin
 if DocTextEditor.DocEditor.Selection = nil then // если текст пустой, то делать там нечего
  Exit;
 // строим список ID атрибута, которые надо проверять
 l_CourtList := BaseConfig.MagicNumbersList['CourtCases', 'Sources'];
 try
  l_CheckList := Tl3LongintList.Make;
  try
   for I := 0 to Pred(l_CourtList.Count) do
   begin
    l_Node := l3FindNodeByHandle(DictServer(CurrentFamily).DictRootNode[da_dlSources], l_CourtList[I]);
    if l_Node <> nil then
    begin
     l_CheckList.Add(l_CourtList[I]);
     l3IterateSubTreeF(l_Node, l3L2NA(@AddHandleToCheckList));
    end;
   end;
   if Supports(Document.Attribute[atSources], IListDocAttribute, l_Attr) then
   begin
    // проверяем, не попадают ли источники в нужные
    l_Found := False;
    for I := 0 to Pred(l_Attr.Count) do
    begin
     if l_Found then
      Break;
     for J := 0 to Pred(l_CheckList.Count) do
     begin
      if l_Found then
       Break;
      l_Found := l_Attr.Handle[I] = l_CheckList[J];
     end;
    end;

    if l_Found then // если найден, то
    begin
     // ищем номер судебного дела
     l_Op := [ev_soGlobal, ev_soUseInternalCursor, ev_soNoSelection];
     l_Searcher := TevRegularExpressionSearcher.Create;
     try
      Supports(l_Searcher, IevTaggedSearcher, l_Tags);
      l_Searcher.Text := 'дел\c+\s+N\s+{А[\d\c_\-\(\)\/]+}';
      DocTextEditor.DocEditor.Find(l_Searcher, nil, l_Op);

      if l_Tags.GetTagCount > 0 then
      begin
       //l_NumStr := l_Tags.GetTag(0);
       // добавим найденный номер как номер судебного дела в атрибуты
       (Document.Attribute[atDateNums] as IDateNumDocAttributeTool).AddRec(dnLawCaseNum, 0, l3PCharLen(l_Tags.GetTag(0)));
       {  then
       begin
        l_DNRec.rType := dnLawCaseNum;
        l3StringToArray(l_DNRec.rNum, cDNNumberLen, l_NumStr);
        //l_DNRec.rLDocID := 264; // ????? <K 87195812>
        l_Attr.Add(Pointer(@l_DNRec));
       end;}
      end;
     finally
      l3Free(l_Searcher);
     end;
    end;

   end;
  finally
   l3Free(l_CheckList);
  end;
 finally
  l3Free(l_CourtList);
 end;
end;

procedure TDocEditorWindow.acSetFrameExecute(Sender: TObject);
begin
 if CurEditor = nil then exit;
 if CurEditor.HasSelection then
 begin
  CurEditor.Find(TevTableTextSearcher.Make, TevTableCellFrameReplacer.Make(evd_fvSolid), [ev_soGlobal, ev_soSelText, ev_soUseInternalCursor, ev_soReplace, ev_soReplaceAll]);
  CurEditor.Modified := True;
 end
 else
  vtMessageDlg(str_sidNoTextSelection.AsCStr, mtError);
end;

procedure TDocEditorWindow.acDelFrameExecute(Sender: TObject);
begin
 if CurEditor = nil then exit;
 if CurEditor.HasSelection then
 begin
  CurEditor.Find(TevTableTextSearcher.Make, TevTableCellFrameReplacer.Make(evd_fvEmpty), [ev_soGlobal, ev_soSelText, ev_soUseInternalCursor, ev_soReplace, ev_soReplaceAll]);
  CurEditor.Modified := True;
 end
 else
  vtMessageDlg(str_sidNoTextSelection.AsCStr, mtError);
end;

procedure TDocEditorWindow.acFindTableExecute(Sender: TObject);
begin
 if CurEditor = nil then Exit;
 try
  CurEditor.Find(TevFirstTableCellSearcher.Make, nil, []);
  CurEditor.DeleteFoundRgn;
 except
  on EevSearchFailed do
   vtMessageDlg(str_sidTableNotFound.AsCStr, mtInformation);
 end;
end;

procedure TDocEditorWindow.SetShowSelect;
begin
 evSetExcludeWords(DocTextEditor.DocEditor, IniRec.ShowFoundWordLighting);
 if Document.HasSpravka then
  evSetExcludeWords(SprTextEditor.DocEditor, IniRec.ShowFoundWordLighting);
end;

procedure TDocEditorWindow.acOldNSRCExecute(Sender: TObject);
begin
 if CurEditor = nil then Exit;
 CurEditor.SetOldNSRCFlag;
end;

procedure TDocEditorWindow.acOldNSRCUpdate(Sender: TObject);
var
 l_Range : IedRange;
 l_Table : IedTable;
begin
 l_Range := CurEditor.Range;
 if l_Range <> nil then
 begin
  l_Table := l_Range.Table;
  if l_Table <> nil then
  begin
   acOldNSRC.Enabled := True;
   acOldNSRC.Checked := l_Table.OldNSRC;
  end
  else
   acOldNSRC.Enabled := CurEditor.HasSelection;
 end; // if l_Range <> nil then
end;

procedure TDocEditorWindow.acRememberWidthsExecute(Sender: TObject);
begin
 evCopyWidthOfCells(CurEditor);
end;

procedure TDocEditorWindow.acApplyWidthsExecute(Sender: TObject);
begin
 evApplyWidthOfCells(CurEditor);
end;

procedure TDocEditorWindow.acRememberWidthsUpdate(Sender: TObject);
var
 l_Range : IedRange;
 l_Table : IedTable;
begin
 l_Range := CurEditor.Range;
 if l_Range <> nil then
 begin
  l_Table := l_Range.Table;
  acRememberWidths.Enabled := l_Table <> nil;
 end; // if l_Range <> nil then
end;

procedure TDocEditorWindow.acApplyWidthsUpdate(Sender: TObject);
var
 l_Range : IedRange;
 l_Table : IedTable;
begin
 l_Range := CurEditor.Range;
 if l_Range <> nil then
 begin
  l_Table := l_Range.Table;
  acApplyWidths.Enabled := l_Table <> nil;
  if acApplyWidths.Enabled then
   acApplyWidths.Enabled := TevCopyTableCellWidth.Instance.CanApply;
 end; // if l_Range <> nil then
end;

procedure TDocEditorWindow.acMonoShrinkExecute(Sender: TObject);

 function IterFunc(const aLeafParagraph: IedLeafParagraph): Boolean;
 var
  l_Size: Integer;
 begin
  Result := true;
  l_Size := aLeafParagraph.PrintFontSize;
  if l_Size > 5 then
   aLeafParagraph.PrintFontSize := l_Size - 1;
 end;

begin
 if (CurEditor <> nil) then
  with CurEditor do
   Range.IterateLeafParagraphsF(L2IedRangeIterateLeafParagraphsAction(@IterFunc), TextSource);
end;

procedure TDocEditorWindow.acMonoEnlargeExecute(Sender: TObject);

 function IterFunc(const aLeafParagraph: IedLeafParagraph): Boolean;
 begin
  Result := true;
  aLeafParagraph.PrintFontSize := aLeafParagraph.PrintFontSize + 1;
 end;

begin
 if (CurEditor <> nil) then
  with CurEditor do
   Range.IterateLeafParagraphsF(L2IedRangeIterateLeafParagraphsAction(@IterFunc), TextSource);
end;

procedure TDocEditorWindow.acToolsSetSectionsExecute(Sender: TObject);
var
 l_Pack: InevOp;
 l_Filt: Tk2TagGenerator;
begin
 if (CurEditor <> nil) then
 begin
  l_Filt := TddSectionRepairFilter.Create;
  try
   TddSectionWithSub2ParaFilter.setTo(l_Filt);
   l_Pack := CurEditor.StartOp(ev_ocUser+111);
   try
    fGetOnlyText := True;
    try
     EvRangeInsertFrom(CurEditor, l_Filt);
    finally
     fGetOnlyText := False;
    end;
    CurEditor.Modified := True;
   finally
    l_Pack := nil;
   end;
  finally
   FreeAndNil(l_Filt);
  end;
 end;
end;


procedure TDocEditorWindow.AutoHLinker(aClearLinks: Boolean);
var
 l_Pack: InevOp;
 l_Filt: TddAutoLinkFilter;
 l_Elim: TevdHyperlinkEliminator;
 l_Doc : TarDocument;
 l_DNTool: IDateNumDocAttributeTool;
 l_Date: TStDate;
 l_Casecode: Il3CString;
 l_SaveGen: Ik2TagGenerator;
begin
 if (CurEditor <> nil) then
 begin
  Screen.Cursor := crHourGlass;
  try
   l_Filt := GetAutoLinkFilter.Use;
   try
    l_Filt.UseInternalNumForLink(True);
    l_SaveGen := l_Filt.Generator; // поскольку мы пользуемся только фильтром, который уже может быть в трубе,
    l_Filt.Generator := nil;       // то надо сохранить генератор фильтра и восстановить его после
    l_Doc := GetCurDocument as TarDocument;
    l_Filt.SetDocID(l_Doc.UserDocID);
    l_DNTool := l_Doc.Attribute[atDateNums] as IDateNumDocAttributeTool;
    l_Date := l_DNTool.GetMinPublishDate;
    if l_Date > 0 then
     l_Filt.SetDocDate(l_Date);
    l_Casecode := l_DNTool.GetCasecode;
    if l_Casecode <> nil then
     l_Filt.SetCasecode(l_Casecode);
    l_Elim := TevdHyperlinkEliminator.Create;
    try
     l_Elim.Generator := l_Filt;
     l_Pack := CurEditor.StartOp(ev_ocUser+111);
     try
      fGetOnlyText := True;
      try
       try
        if aClearLinks then
         EvRangeInsertFrom(CurEditor, l_Elim)
        else
         EvRangeInsertFrom(CurEditor, l_Filt);
       finally
        CleanupAutolinkServer;
       end;
      finally
       fGetOnlyText := False;
      end;
      CurEditor.Modified := True;
     finally
      l_Pack := nil;
     end;
    finally
     FreeAndNil(l_Elim);
    end;
   finally
    l_Filt.Generator := l_SaveGen;
    FreeAndNil(l_Filt);
   end;
  finally
   Screen.Cursor := crDefault;
  end;
 end;
end;

procedure TDocEditorWindow.acTranslate2TextExecute(Sender: TObject);
var
 l_Range : IedRange;
 l_Table : IedTable;
begin
 l_Range := CurEditor.Range;
 if l_Range <> nil then
 begin
  l_Table := l_Range.Table;
  if l_Table <> nil then
   l_Table.Cells.Translate2Text;
 end; // if l_Range <> nil then
end;

procedure TDocEditorWindow.acToolsAutolinkExecute(Sender: TObject);
var
 l_Answer: Integer;
begin
 l_Answer := vtMessageDlg(l3CStr('Перед расстановкой, удалить существующие ссылки в документах?'), mtConfirmation, [mbYes, mbNo, mbCancel], 0, mbNo);
 if l_Answer = mrCancel then
  Exit;
 AutoHLinker(l_Answer = mrYes);
end;

procedure TDocEditorWindow.acTranslate2TextUpdate(Sender: TObject);
begin
 acTranslate2Text.Enabled := (CurEditor <> nil) and (CurEditor.Range <> nil) and (CurEditor.Range.Table <> nil);
end;

procedure TDocEditorWindow.acToolsCnvLowerCaseWithFirstExecute(Sender: TObject);
begin
 if not evCursorInSel(CurEditor) then
  Exit;
 CurEditor.TextConvert(cnvUp2LoWithFirst);
end;

procedure TDocEditorWindow.cbxHangClick(Sender: TObject);
begin
 if cbxHang.Tag = 0 then
  cbxHang.Tag := 1
 else
  cbxHang.Tag := 0;
 CheckHangDisp;
end;

procedure TDocEditorWindow.CheckHangDisp;
begin
 pnlHang.Visible := cbxHang.Checked;
end;

procedure TDocEditorWindow.acSetSubUpdate(Sender: TObject);
var
 l_BC: InevCommonPoint;
 l_Sub : IevSub;
 l_Enabled: Boolean;
begin
 l_BC := evMostInnerFromBlock(nil, CurEditor);
 l_Enabled := Supports(l_BC, IevSub, l_Sub);
 if l_Enabled then
  l_Enabled := l_Sub.ID < 0;
 acSetSub.Enabled := acSetSub.Visible and l_Enabled;
end;

function TDocEditorWindow.GetTextDocumentView: InevView;
begin
 Result := DocTextEditor.DocEditor.View;
end;

procedure TDocEditorWindow.acInsTemplateEditExecute(Sender: TObject);
var
 l_Dlg: TTemplateEditor;
 l_TS: TarTemplateStorage;
begin
 Application.CreateForm(TTemplateEditor, l_Dlg);
 try
  l_TS := GetTemplateStorage;
  l_Dlg.memTemplateText.Text := l_TS.Template;
  if l_Dlg.ShowModal = mrOk then
  begin
   l_TS.Template := Trim(l_Dlg.memTemplateText.Text);
  end;
 finally
  FreeAndNil(l_Dlg);
 end;
end;

procedure TDocEditorWindow.acInsTemplateExecute(Sender: TObject);
var
 l_MS: Tl3ConstMemoryStream;
 l_G : Tk2TagGenerator;
 l_Pack : InevOp;
 l_Text : AnsiString;
 l_Cursor: InevBasePoint;
 l_TP   : TarTemplateProcessor;
 l_TS   : TarTemplateStorage;
begin
 l_TS := GetTemplateStorage;
 if l_TS.Template <> '' then
 begin
  try
   l_TP := TarTemplateProcessor.Create(CurEditor.CurPara, l_TS.TemplateData);
   try
    l_TP.OnGetInteractiveValue := TemplateInputValueHandler;
    l_Text := l_TP.Process(l_TS.Template);
   finally
    FreeAndNil(l_TP);
   end;
   if l_Text <> '' then
   begin
     l_MS := Tl3ConstMemoryStream.Create(@l_Text[1], Length(l_Text));
     try
      l_Pack := CurEditor.StartOp(ev_msgInsertPara);
      try
       CurEditor.Range.Delete(ev_cmAll); // Удалять здесь!!! В следующей строке запоминается позиция текущего курсора. См. http://mdp.garant.ru/pages/viewpage.action?pageId=541120216
       l_G := nil;
       try
        TevdCustomHyperlinkCorrector.SetTo(l_G, LinkServer(CurrentFamily).Renum);
        TevdParaStylePainter.SetTo(l_G, ev_saVersionInfo);
        TevWikiReader.SetTo(l_G);
        TevWikiReader(l_G).Filer.Stream := l_MS;
        l_Cursor := CurEditor.Selection.Cursor.ClonePoint(CurEditor.View);
        try
         l_G.Link(CurEditor.TextSource.GetGenerator(CurEditor.View, CurEditor.Selection));
         TevWikiReader(l_G).Execute;
         l_Cursor.MostInner.Obj.Invalidate([nev_spExtent]);
        finally
         l_Cursor := nil;
        end;
      finally
       FreeAndNil(l_G);
      end;
     finally
      l_Pack := nil;
     end;
     finally
      FreeAndNil(l_MS);
     end;
   end;
  except
   on EarAbortTemplate do ; // гасим исключение прерывания вставки шаблона
  end;
 end;
end;

procedure TDocEditorWindow.AcquireCurDocParams;
var
 l_Rec: TarTemplateDataRec;
 l_TS : TarTemplateStorage;
begin
 inherited;
 l_TS := GetTemplateStorage;
 l_Rec := l_TS.TemplateData;
 l_Rec.rRelID := LinkServer(CurrentFamily).Renum.GetExtDocID(SprDocID);
 l_TS.TemplateData := l_Rec;
end;

function TDocEditorWindow.TemplateInputValueHandler(const aName: AnsiString; out theResult: AnsiString): Boolean;
begin
 Result := vtInputQuery('Введите значение', aName, theResult);
end;

procedure TDocEditorWindow.tblJurJournalGetItemColor(Sender: TObject;
  Index: Integer; var FG, BG: TColor);
begin
 if (Document.AttrManager.GetDocAttribute(atJurLogRecords) as ILogDocAttributeTool).IsAnnoAction(Index) then
  BG := $FDEDE2; //$E2EDFD; //clSkyBlue; // = TColor($F0CAA6);
end;

procedure TDocEditorWindow.tblOrdJournalGetItemColor(Sender: TObject;
  Index: Integer; var FG, BG: TColor);
begin
 if (Document.AttrManager.GetDocAttribute(atOrdLogRecords) as ILogDocAttributeTool).IsAnnoAction(Index) then
  BG :=  $FDEDE2;//clSkyBlue; // = TColor($F0CAA6);
end;

end.

