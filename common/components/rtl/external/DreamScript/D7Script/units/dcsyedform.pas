{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcSyEdForm;

interface
{$I dc.inc}
{$I dcsyntax.inc}
uses
  Windows, Messages, Graphics, dcSyntax, Forms, Dialogs, StdCtrls, Buttons,
  DCColorCombo, ExtCtrls, CheckLst, ComCtrls, Controls, Classes;

type
  TSyntaxEdForm = class(TForm)
    pnlButtons: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    btnLoad: TButton;
    btnSave: TButton;
    btnClear: TButton;
    pnlScheme: TPanel;
    lblSchemeName: TLabel;
    edtSchemeName: TEdit;
    btnAddBlock: TButton;
    btnRmvBlock: TButton;
    pgcBlockElems: TPageControl;
    tshIdents: TTabSheet;
    chxUseIdentifiers: TCheckBox;
    tshComments: TTabSheet;
    chxUseComments: TCheckBox;
    lbxDlmtrsSC: TCheckListBox;
    btnAddDlmtrSC: TButton;
    btnRmvDlmtrSC: TButton;
    lbxDlmtrsMC: TCheckListBox;
    btnAddDlmtrMC: TButton;
    btnRmvDlmtrMC: TButton;
    tshStrings: TTabSheet;
    chxUseStrings: TCheckBox;
    lbxDlmtrsSS: TCheckListBox;
    btnAddDlmtrSS: TButton;
    btnRmvDlmtrSS: TButton;
    tshNumbers: TTabSheet;
    chxUseNumbers: TCheckBox;
    chxPSNumbers: TCheckBox;
    lbxDlmtrsPSNum: TCheckListBox;
    btnAddDlmtrPSNum: TButton;
    btnRmvDlmtrPSNum: TButton;
    tshKeywords: TTabSheet;
    lblCurKWSets: TLabel;
    chxUseKeywords: TCheckBox;
    btnAddKWSet: TButton;
    btnRmvKWSet: TButton;
    lbxKeywords: TListBox;
    btnAddKW: TButton;
    btnRmvKW: TButton;
    btnLoadKW: TButton;
    btnSaveKW: TButton;
    chxUseCommentsSL: TCheckBox;
    chxUseCommentsML: TCheckBox;
    bvlKW: TBevel;
    lblKWSets: TLabel;
    lbxKWSets: TCheckListBox;
    btnStyleIdent: TButton;
    btnStyleIntNum: TButton;
    btnStyleFloatNum: TButton;
    lblIntNum: TLabel;
    lblFloatNum: TLabel;
    tshPopups: TTabSheet;
    pnlPopup1: TPanel;
    lblFontColor1: TLabel;
    cbxFontColor1: TDCColorCombo;
    lblFontStyles1: TLabel;
    chxBold1: TCheckBox;
    chxItalic1: TCheckBox;
    chxUnderline1: TCheckBox;
    chxStrikeout1: TCheckBox;
    bvlPopup1: TBevel;
    btnPopupOK1: TButton;
    btnPopupCancel1: TButton;
    pnlPopup2: TPanel;
    lblFontName2: TLabel;
    lblFontSize2: TLabel;
    lblFontColor2: TLabel;
    lblFontStyles2: TLabel;
    bvlPopup2: TBevel;
    cbxFontName2: TComboBox;
    cbxFontSize2: TComboBox;
    cbxFontColor2: TDCColorCombo;
    chxBold2: TCheckBox;
    chxItalic2: TCheckBox;
    chxUnderline2: TCheckBox;
    chxStrikeout2: TCheckBox;
    btnPopupOK2: TButton;
    btnPopupCancel2: TButton;
    lblDlmtr2: TLabel;
    edtDlmtr2: TEdit;
    pnlPopup3: TPanel;
    lblFontName3: TLabel;
    lblFontSize3: TLabel;
    lblFontColor3: TLabel;
    lblFontStyles3: TLabel;
    bvlPopup3: TBevel;
    lblLDlmtr3: TLabel;
    cbxFontName3: TComboBox;
    cbxFontSize3: TComboBox;
    cbxFontColor3: TDCColorCombo;
    chxBold3: TCheckBox;
    chxItalic3: TCheckBox;
    chxUnderline3: TCheckBox;
    chxStrikeout3: TCheckBox;
    btnPopupOK3: TButton;
    btnPopupCancel3: TButton;
    edtLDlmtr3: TEdit;
    lblRDlmtr3: TLabel;
    edtRDlmtr3: TEdit;
    btnEditDlmtrSC: TButton;
    btnEditDlmtrMC: TButton;
    btnEditDlmtrSS: TButton;
    btnEditDlmtrPSNum: TButton;
    btnEditKW: TButton;
    btnEditKWSet: TButton;
    pnlPopup4: TPanel;
    lblKeyword4: TLabel;
    edtKeyword4: TEdit;
    bvlPopup4: TBevel;
    btnPopupOK4: TButton;
    btnPopupCancel4: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    chxUseStringsSL: TCheckBox;
    chxUseStringsML: TCheckBox;
    lbxDlmtrsMS: TCheckListBox;
    btnAddDlmtrMS: TButton;
    btnRmvDlmtrMS: TButton;
    btnEditDlmtrMS: TButton;
    btnApply: TButton;
    chxUseDefFont2: TCheckBox;
    chxUseDefFont3: TCheckBox;
    rgpPSNumbers: TRadioGroup;
    tshCommon: TTabSheet;
    lblBlkDelimiters: TLabel;
    lbxBlkDlmtrs: TCheckListBox;
    btnAddBlkDlmtr: TButton;
    btnRmvBlkDlmtr: TButton;
    btnEditBlkDlmtr: TButton;
    pnlPopup5: TPanel;
    lblLDlmtr5: TLabel;
    bvlPopup5: TBevel;
    edtLDlmtr5: TEdit;
    btnPopupOK5: TButton;
    btnPopupCancel5: TButton;
    lblRDlmtr5: TLabel;
    edtRDlmtr5: TEdit;
    bvlCommon: TBevel;
    lblBlkOptions: TLabel;
    chxCaseSens: TCheckBox;
    chxDlmtrsArePart5: TCheckBox;
    chxUseMeta: TCheckBox;
    edtMetaSymbol: TEdit;
    btnEditBlock: TButton;
    chxPSNumOption: TCheckBox;
    btnCopyBlock: TButton;
    pnlPopup6: TPanel;
    bvlPopup6: TBevel;
    btnPopupOK6: TButton;
    btnPopupCancel6: TButton;
    lblPrompt6: TLabel;
    lbxCopyBlocks: TListBox;
    tshFullLine: TTabSheet;
    chxUseCommentsFL: TCheckBox;
    lbxDlmtrsFC: TCheckListBox;
    btnAddDlmtrFC: TButton;
    btnRmvDlmtrFC: TButton;
    btnEditDlmtrFC: TButton;
    lblStyleText: TLabel;
    btnStyleText: TButton;
    chxUseSymbols: TCheckBox;
    btnStyleSymbols: TButton;
    chxUseDirectives: TCheckBox;
    lblDrctvPrefix: TLabel;
    edtDrctvPrefix: TEdit;
    btnStyleDrctv: TButton;
    bvlFullLine: TBevel;
    rgpPSIdents: TRadioGroup;
    chxPSIdents: TCheckBox;
    lbxDlmtrsPSIdent: TCheckListBox;
    btnAddDlmtrPSIdent: TButton;
    btnRmvDlmtrPSIdent: TButton;
    btnEditDlmtrPSIdent: TButton;
    pnlPopup7: TPanel;
    lblLDlmtr7: TLabel;
    bvlPopup7: TBevel;
    edtLDlmtr7: TEdit;
    btnPopupOK7: TButton;
    btnPopupCancel7: TButton;
    lblRDlmtr7: TLabel;
    edtRDlmtr7: TEdit;
    lblHexNum: TLabel;
    btnStyleHexNum: TButton;
    chxMetaEscape: TCheckBox;
    chxMetaWrapLines: TCheckBox;
    bvlPopup1a: TBevel;
    bvlPopup2a: TBevel;
    chxUseDefBack2: TCheckBox;
    lblBackColor2: TLabel;
    cbxBackColor2: TDCColorCombo;
    bvlPopup3a: TBevel;
    chxUseDefBack3: TCheckBox;
    lblBackColor3: TLabel;
    cbxBackColor3: TDCColorCombo;
    pnlPopup8: TPanel;
    lblDlmtr8: TLabel;
    bvlPopup8: TBevel;
    edtDlmtr8: TEdit;
    btnPopupOK8: TButton;
    btnPopupCancel8: TButton;
    lblParent8: TLabel;
    trvBlocks8: TTreeView;
    trvBlocks6: TTreeView;
    lblParent6: TLabel;
    pgcSchemeElems: TPageControl;
    tshSchemeBlocks: TTabSheet;
    tshSchemeExts: TTabSheet;
    trvBlocks: TTreeView;
    lbxExts: TListBox;
    btnSaveAs: TButton;
    bbnFontColor1: TBitBtn;
    bbnFontColor2: TBitBtn;
    bbnBackColor2: TBitBtn;
    bbnFontColor3: TBitBtn;
    bbnBackColor3: TBitBtn;
    ColorDialog1: TColorDialog;
    btnFirstChar: TButton;
    btnOtherChar: TButton;
    lblFirstChar: TLabel;
    lblOtherChar: TLabel;
    cbxTextStyle1: TComboBox;
    lblTextStyle1: TLabel;
    bbnBackColor1: TBitBtn;
    cbxBackColor1: TDCColorCombo;
    lblBackColor1: TLabel;
    chxUseDefBack1: TCheckBox;
    cbxFontSize1: TComboBox;
    lblFontSize1: TLabel;
    cbxFontName1: TComboBox;
    lblFontName1: TLabel;
    chxUseDefFont1: TCheckBox;
    lblTextStyle2: TLabel;
    cbxTextStyle2: TComboBox;
    lblTextStyle3: TLabel;
    cbxTextStyle3: TComboBox;
    procedure chxUseMetaClick(Sender: TObject);
    procedure btnAddBlockClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnRmvBlockClick(Sender: TObject);
    procedure chxUseDirectivesClick(Sender: TObject);
    procedure chxUseIdentifiersClick(Sender: TObject);
    procedure chxUseSymbolsClick(Sender: TObject);
    procedure chxUseCommentsClick(Sender: TObject);
    procedure chxUseCommentsSLClick(Sender: TObject);
    procedure chxUseCommentsMLClick(Sender: TObject);
    procedure btnRmvDlmtrSCClick(Sender: TObject);
    procedure btnAddDlmtrSCClick(Sender: TObject);
    procedure chxUseStringsClick(Sender: TObject);
    procedure chxUseNumbersClick(Sender: TObject);
    procedure chxPSNumbersClick(Sender: TObject);
    procedure chxUseKeywordsClick(Sender: TObject);
    procedure edtSchemeNameExit(Sender: TObject);
    procedure chxCaseSensClick(Sender: TObject);
    procedure edtMetaSymbolExit(Sender: TObject);
    procedure edtDrctvPrefixExit(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure lbxDlmtrsSCKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbxDlmtrsMCKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbxDlmtrsSSKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbxDlmtrsPSNumKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbxKWSetsClick(Sender: TObject);
    procedure lbxKWSetsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbxKeywordsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnRmvDlmtrMCClick(Sender: TObject);
    procedure btnAddDlmtrMCClick(Sender: TObject);
    procedure btnRmvDlmtrSSClick(Sender: TObject);
    procedure btnAddDlmtrSSClick(Sender: TObject);
    procedure btnRmvDlmtrPSNumClick(Sender: TObject);
    procedure btnAddDlmtrPSNumClick(Sender: TObject);
    procedure btnRmvKWSetClick(Sender: TObject);
    procedure btnAddKWSetClick(Sender: TObject);
    procedure btnRmvKWClick(Sender: TObject);
    procedure btnAddKWClick(Sender: TObject);
    procedure btnSaveKWClick(Sender: TObject);
    procedure btnLoadKWClick(Sender: TObject);
    procedure btnStyleTextClick(Sender: TObject);
    procedure btnStyleIdentClick(Sender: TObject);
    procedure btnStyleSymbolsClick(Sender: TObject);
    procedure btnStyleDrctvClick(Sender: TObject);
    procedure btnStyleIntNumClick(Sender: TObject);
    procedure btnStyleFloatNumClick(Sender: TObject);
    procedure btnEditDlmtrSCClick(Sender: TObject);
    procedure btnEditDlmtrMCClick(Sender: TObject);
    procedure btnEditDlmtrSSClick(Sender: TObject);
    procedure btnEditDlmtrPSNumClick(Sender: TObject);
    procedure lbxDlmtrsSCClick(Sender: TObject);
    procedure lbxDlmtrsPSNumClick(Sender: TObject);
    procedure lbxDlmtrsMCClick(Sender: TObject);
    procedure lbxDlmtrsSSClick(Sender: TObject);
    procedure btnEditKWClick(Sender: TObject);
    procedure btnEditKWSetClick(Sender: TObject);
    procedure lbxKeywordsClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure lbxMeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure lbxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormDestroy(Sender: TObject);
    procedure lbxDlmtrsMSClick(Sender: TObject);
    procedure lbxDlmtrsMSKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAddDlmtrMSClick(Sender: TObject);
    procedure btnRmvDlmtrMSClick(Sender: TObject);
    procedure btnEditDlmtrMSClick(Sender: TObject);
    procedure chxUseStringsSLClick(Sender: TObject);
    procedure chxUseStringsMLClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure chxUseDefFont1Click(Sender: TObject);
    procedure chxUseDefFont2Click(Sender: TObject);
    procedure chxUseDefFont3Click(Sender: TObject);
    procedure rgpPSNumbersClick(Sender: TObject);
    procedure lbxKWSetsDblClick(Sender: TObject);
    procedure lbxKeywordsDblClick(Sender: TObject);
    procedure lbxDlmtrsPSNumDblClick(Sender: TObject);
    procedure lbxDlmtrsSSDblClick(Sender: TObject);
    procedure lbxDlmtrsMSDblClick(Sender: TObject);
    procedure lbxDlmtrsSCDblClick(Sender: TObject);
    procedure lbxDlmtrsMCDblClick(Sender: TObject);
    procedure lbxBlkDlmtrsClick(Sender: TObject);
    procedure lbxBlkDlmtrsDblClick(Sender: TObject);
    procedure lbxBlkDlmtrsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAddBlkDlmtrClick(Sender: TObject);
    procedure btnRmvBlkDlmtrClick(Sender: TObject);
    procedure btnEditBlkDlmtrClick(Sender: TObject);
    procedure btnEditBlockClick(Sender: TObject);
    procedure chxPSNumOptionClick(Sender: TObject);
    procedure btnCopyBlockClick(Sender: TObject);
    procedure lbxDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lbxDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure chxUseCommentsFLClick(Sender: TObject);
    procedure lbxDlmtrsFCClick(Sender: TObject);
    procedure lbxDlmtrsFCDblClick(Sender: TObject);
    procedure lbxDlmtrsFCKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAddDlmtrFCClick(Sender: TObject);
    procedure btnRmvDlmtrFCClick(Sender: TObject);
    procedure btnEditDlmtrFCClick(Sender: TObject);
    procedure rgpPSIdentsClick(Sender: TObject);
    procedure chxPSIdentsClick(Sender: TObject);
    procedure lbxDlmtrsPSIdentClick(Sender: TObject);
    procedure lbxDlmtrsPSIdentDblClick(Sender: TObject);
    procedure lbxDlmtrsPSIdentKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAddDlmtrPSIdentClick(Sender: TObject);
    procedure btnRmvDlmtrPSIdentClick(Sender: TObject);
    procedure btnEditDlmtrPSIdentClick(Sender: TObject);
    procedure btnStyleHexNumClick(Sender: TObject);
    procedure chxMetaEscapeClick(Sender: TObject);
    procedure chxMetaWrapLinesClick(Sender: TObject);
    procedure chxUseDefBack1Click(Sender: TObject);
    procedure chxUseDefBack2Click(Sender: TObject);
    procedure chxUseDefBack3Click(Sender: TObject);
    procedure lbxBlkDlmtrsClickCheck(Sender: TObject);
    procedure lbxDlmtrsSCClickCheck(Sender: TObject);
    procedure lbxDlmtrsMCClickCheck(Sender: TObject);
    procedure lbxDlmtrsFCClickCheck(Sender: TObject);
    procedure lbxDlmtrsSSClickCheck(Sender: TObject);
    procedure lbxDlmtrsMSClickCheck(Sender: TObject);
    procedure lbxDlmtrsPSNumClickCheck(Sender: TObject);
    procedure lbxDlmtrsPSIdentClickCheck(Sender: TObject);
    procedure lbxKWSetsClickCheck(Sender: TObject);
    procedure trvBlocksChange(Sender: TObject; Node: TTreeNode);
    procedure trvBlocksKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure trvBlocksDblClick(Sender: TObject);
    procedure trvBlocksDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure trvBlocksDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure pgcSchemeElemsChange(Sender: TObject);
    procedure lbxExtsClick(Sender: TObject);
    procedure lbxExtsDblClick(Sender: TObject);
    procedure lbxExtsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSaveAsClick(Sender: TObject);
    procedure bbnCustomColorClick(Sender: TObject);
    procedure btnCharSetClick(Sender: TObject);
  private
    FCollections: array[1..13] of TCollection; //pointers
    FPopupActive, FCheckIdents, ApplyWasClicked: Boolean;
    {$IFNDEF D4}
    FComboIndexes: array[0..2] of integer; //there are 3 combos on each PopupPanel
    {$ENDIF}
    FFileName: string;

    procedure LoadLocalizedCaptions;
    procedure UpdateBlocksTree(ATree: TTreeView);
    procedure CorrectBlockIndexes;
    function IsIdent(AString: string): Boolean;
    procedure GetDefaultFontAttr(var AName: string; var ASize: integer);
    procedure CreateNewScheme;
    procedure SetSyntaxScheme(AValue: TSyntaxScheme);
    procedure ChooseBlock(AID: integer);
    procedure SetCurBlock;
    procedure SetCurKWSet;

    procedure btnAddExtClick(Sender: TObject);
    procedure btnRmvExtClick(Sender: TObject);
    procedure btnEditExtClick(Sender: TObject);

    function CorrectFontID(AFontID: integer): integer;
    procedure VisualizeAttr(AControl: TControl; AFontID: integer);
    function GetTokenAttr(ATag, AIndex: integer): TAttrItem;
    procedure SetCurScheme;
    procedure CompactScheme;
    {$IFNDEF D4}
    procedure SaveComboIndexes(Ctrl: TWinControl);
    procedure RestoreComboIndexes(Ctrl: TWinControl);
    {$ENDIF}

    procedure AssignLineTokenList2ListBox(AListBox: TCheckListBox;
      ALineTokenList: TLineTokenList);
    procedure AssignBlockTokenList2ListBox(AListBox: TCheckListBox;
      ABlockTokenList: TBlockTokenList);
    procedure AssignDelimitersList2ListBox(AListBox: TCheckListBox;
      ADelimitersList: TDelimitersList);
    procedure AssignKeywordSetList2ListBox(AListBox: TCheckListBox;
      AKeywordSetList: TKeywordSetList);

    function PopupPanel(What, Where: TControl): Boolean;
    procedure PopupCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure WMNCActivate(var Message: TWMNCActivate); message WM_NCACTIVATE;
    function PopupFontStyle(Anchor: TControl; var AFontID: integer): Boolean;
    function PopupLineToken(Anchor: TControl; var ALineToken: TLineToken;
      const ALabel: string): Boolean;
    function PopupBlockToken(Anchor: TControl; var ABlockToken: TBlockToken;
      const ALabelL, ALabelR: string): Boolean;
    function PopupInputLine(Anchor: TControl; var AString: string;
      const ALabel: string): Boolean;
    function PopupInputPair(Anchor: TControl; var AStringL, AStringR: string;
      const ALabelL, ALabelR: string): Boolean;
    function PopupInputDlmtrs(Anchor: TControl; var ADelimiters: TDelimiters): Boolean;
    function PopupBlock(Anchor: TControl; var AString: string;
      var AParentID: integer; AID: integer): Boolean;
    procedure FillPopupForm(AFontID: integer; AComboName, AComboSize: TComboBox;
      AChxDefFont, AChxDefBack, AChxBold, AChxItalic, AChxUnderline,
      AChxStrikeOut: TCheckBox; AFontColorEdit, ABackColorEdit: TDCColorCombo;
      AComboCSet: TComboBox);

    procedure EnumTS(const Str: string);

    procedure UpdateUseMeta;
    procedure UpdateBlockDelimiters;
    procedure UpdateUseDirectives;
    procedure UpdateUseSymbols;
    procedure UpdateUseComments;
    procedure UpdateUseCommentsSL;
    procedure UpdateUseCommentsML;
    procedure UpdateUseCommentsFL;
    procedure UpdateUseStrings;
    procedure UpdateUseStringsSL;
    procedure UpdateUseStringsML;
    procedure UpdateUseNumbers;
    procedure UpdateUsePSNumbers;
    procedure UpdateUseIdentifiers;
    procedure UpdateUsePSIdents;
    procedure UpdateUseKeywords;
  protected
    FCurScheme, //instance
    FEditedScheme: TSyntaxScheme; //pointer
    FCurBlock: TSyntaxBlock; //pointer
    FCurKWSet: TKeywordSet; //pointer
  public
    property EditedScheme: TSyntaxScheme read FEditedScheme write SetSyntaxScheme;
  end;

var
  SyntaxEdForm: TSyntaxEdForm;

function EditSyntaxScheme(ASyntaxScheme: TSyntaxScheme): Boolean;

implementation

uses
  SysUtils, dcCommon, dcconsts, dcmemo;

{$R *.dfm}

const
  SExtScheme = 'sch'; //don't resource
  SExtKeywords = 'txt'; //don't resource

procedure TSyntaxEdForm.LoadLocalizedCaptions;
begin
  Caption := SSSETitle;
  lblSchemeName.Caption := SSchemeName;
  tshSchemeBlocks.Caption := SBlocks;
  tshSchemeExts.Caption := SExtensions;
  btnAddBlock.Caption := SAdd;
  btnRmvBlock.Caption := SRemove;
  btnEditBlock.Caption := SEdit;
  btnCopyBlock.Caption := SCopy;
  btnOK.Caption := SOkButton;
  btnCancel.Caption := SCancelButton;
  btnLoad.Caption := SLoad1;
  btnSave.Caption := SSave1;
  btnSaveAs.Caption := SSaveAs;
  btnClear.Caption := SClear0;
  btnApply.Caption := SApply0;
  tshCommon.Caption := SPageCommon;
  tshComments.Caption := SPageComments;
  tshFullLine.Caption := SPageFullLine;
  tshStrings.Caption := SPageStrings;
  tshNumbers.Caption := SPageNumbers;
  tshIdents.Caption := SPageIdents;
  tshKeywords.Caption := SPageKeywords;
  tshPopups.Caption := SPagePopups;
  lblBlkDelimiters.Caption := SBlkDelimiters;
  btnAddBlkDlmtr.Caption := SAdd1;
  btnRmvBlkDlmtr.Caption := SRemove1;
  btnEditBlkDlmtr.Caption := SEdit1;
  lblBlkOptions.Caption := SBlkOptions;
  chxCaseSens.Caption := SCaseSens;
  chxUseMeta.Caption := SUseMeta;
  chxMetaEscape.Caption := SMetaEscape;
  chxMetaWrapLines.Caption := SMetaWrapLines;
  lblStyleText.Caption := SStyleText;
  btnStyleText.Caption := SStyleButton;
  chxUseSymbols.Caption := SUseSymbols;
  btnStyleSymbols.Caption := SStyleButton;
  chxUseComments.Caption := SUseComments;
  chxUseCommentsSL.Caption := SUseCommentsSL;
  chxUseCommentsML.Caption := SUseCommentsML;
  btnAddDlmtrSC.Caption := SAdd1;
  btnRmvDlmtrSC.Caption := SRemove1;
  btnEditDlmtrSC.Caption := SEdit1;
  btnAddDlmtrMC.Caption := SAdd2;
  btnRmvDlmtrMC.Caption := SRemove2;
  btnEditDlmtrMC.Caption := SEdit2;
  chxUseCommentsFL.Caption := SUseCommentsFL;
  btnAddDlmtrFC.Caption := SAdd1;
  btnRmvDlmtrFC.Caption := SRemove1;
  btnEditDlmtrFC.Caption := SEdit1;
  chxUseDirectives.Caption := SUseDirectives;
  lblDrctvPrefix.Caption := SCaptionPrefix;
  btnStyleDrctv.Caption := SStyleButton;
  chxUseStrings.Caption := SUseStrings;
  chxUseStringsSL.Caption := SUseStringsSL;
  chxUseStringsML.Caption := SUseStringsML;
  btnAddDlmtrSS.Caption := SAdd1;
  btnRmvDlmtrSS.Caption := SRemove1;
  btnEditDlmtrSS.Caption := SEdit1;
  btnAddDlmtrMS.Caption := SAdd2;
  btnRmvDlmtrMS.Caption := SRemove2;
  btnEditDlmtrMS.Caption := SEdit2;
  chxUseNumbers.Caption := SUseNumbers;
  lblIntNum.Caption := SIntNum;
  btnStyleIntNum.Caption := SStyleButton;
  lblFloatNum.Caption := SFloatNum;
  btnStyleFloatNum.Caption := SStyleButton;
  lblHexNum.Caption := SHexNum;
  btnStyleHexNum.Caption := SStyleButton;
  rgpPSNumbers.Caption := SPSNumbers;
  rgpPSNumbers.Items[0] := SWithPrefix;
  rgpPSNumbers.Items[1] := SWithSuffix;
  rgpPSNumbers.Items[2] := SWithPS;
  btnAddDlmtrPSNum.Caption := SAdd2;
  btnRmvDlmtrPSNum.Caption := SRemove2;
  btnEditDlmtrPSNum.Caption := SEdit2;
  chxUseIdentifiers.Caption := SUseIdentifiers;
  lblFirstChar.Caption := SCaptionFirstChar;
  lblOtherChar.Caption := SCaptionOtherChar;
  btnStyleIdent.Caption := SStyleButton;
  rgpPSIdents.Caption := SPSNumbers; //?
  rgpPSIdents.Items[0] := SWithPrefix;
  rgpPSIdents.Items[1] := SWithSuffix;
  rgpPSIdents.Items[2] := SWithPS;
  btnAddDlmtrPSIdent.Caption := SAdd2;
  btnRmvDlmtrPSIdent.Caption := SRemove2;
  btnEditDlmtrPSIdent.Caption := SEdit2;
  chxUseKeywords.Caption := SUseKeywords;
  lblKWSets.Caption := SKWSets;
  lblCurKWSets.Caption := SCurKWSets;
  btnAddKWSet.Caption := SAdd1;
  btnRmvKWSet.Caption := SRemove1;
  btnEditKWSet.Caption := SEdit1;
  btnAddKW.Caption := SAdd2;
  btnRmvKW.Caption := SRemove2;
  btnEditKW.Caption := SEdit2;
  btnLoadKW.Caption := SLoad;
  btnSaveKW.Caption := SSave;
  lblTextStyle1.Caption := STextStyle;
  lblTextStyle2.Caption := STextStyle;
  lblTextStyle3.Caption := STextStyle;
  chxUseDefFont1.Caption := SUseDefFont;
  chxUseDefFont2.Caption := SUseDefFont;
  chxUseDefFont3.Caption := SUseDefFont;
  lblFontName1.Caption := SFontName;
  lblFontName2.Caption := SFontName;
  lblFontName3.Caption := SFontName;
  lblFontSize1.Caption := SFontSize;
  lblFontSize2.Caption := SFontSize;
  lblFontSize3.Caption := SFontSize;
  lblFontColor1.Caption := SFontColor;
  lblFontColor2.Caption := SFontColor;
  lblFontColor3.Caption := SFontColor;
  lblFontStyles1.Caption := SFontStyles;
  lblFontStyles2.Caption := SFontStyles;
  lblFontStyles3.Caption := SFontStyles;
  chxBold1.Caption := SBold;
  chxBold2.Caption := SBold;
  chxBold3.Caption := SBold;
  chxItalic1.Caption := SItalic;
  chxItalic2.Caption := SItalic;
  chxItalic3.Caption := SItalic;
  chxUnderline1.Caption := SUnderline;
  chxUnderline2.Caption := SUnderline;
  chxUnderline3.Caption := SUnderline;
  chxStrikeout1.Caption := SStrikeout;
  chxStrikeout2.Caption := SStrikeout;
  chxStrikeout3.Caption := SStrikeout;
  chxUseDefBack1.Caption := SUseDefBack;
  chxUseDefBack2.Caption := SUseDefBack;
  chxUseDefBack3.Caption := SUseDefBack;
  lblBackColor1.Caption := SBackColor;
  lblBackColor2.Caption := SBackColor;
  lblBackColor3.Caption := SBackColor;
  btnPopupOK1.Caption := SOkButton;
  btnPopupOK2.Caption := SOkButton;
  btnPopupOK3.Caption := SOkButton;
  btnPopupOK4.Caption := SOkButton;
  btnPopupOK5.Caption := SOkButton;
  btnPopupOK6.Caption := SOkButton;
  btnPopupOK7.Caption := SOkButton;
  btnPopupCancel1.Caption := SCancelButton;
  btnPopupCancel2.Caption := SCancelButton;
  btnPopupCancel3.Caption := SCancelButton;
  btnPopupCancel4.Caption := SCancelButton;
  btnPopupCancel5.Caption := SCancelButton;
  btnPopupCancel6.Caption := SCancelButton;
  btnPopupCancel7.Caption := SCancelButton;
  lblDlmtr2.Caption := SCaptionDelimiter;
  lblLDlmtr3.Caption := SCaptionLeftDlmtr;
  lblLDlmtr5.Caption := SCaptionLeftDlmtr;
  lblLDlmtr7.Caption := SCaptionLeftDlmtr;
  lblRDlmtr3.Caption := SCaptionRightDlmtr;
  lblRDlmtr5.Caption := SCaptionRightDlmtr;
  lblRDlmtr7.Caption := SCaptionRightDlmtr;
  lblKeyword4.Caption := SCaptionKeyword;
  chxDlmtrsArePart5.Caption := SArePartOfBlock;
  lblPrompt6.Caption := SSelectBlock;
  lblParent6.Caption := SCaptionParent;
  lblDlmtr8.Caption := SCaptionBlock;
  lblParent8.Caption := SCaptionParent;
end;

procedure TSyntaxEdForm.UpdateBlocksTree(ATree: TTreeView);
var
  i, j: integer;
  tn: TTreeNode;
  bl: TList;
begin
  with ATree.Items do
  begin
    BeginUpdate;
    try
      Clear;
      bl := TList.Create;
      try
        with FCurScheme do
        begin
          if SyntaxBlocks.Count > 0 then
            with SyntaxBlocks[0] do
              Add(nil, Name).Data := Pointer(ID);
          for i := 1 to Pred(SyntaxBlocks.Count) do
            bl.Add(SyntaxBlocks[i]);
          while (bl.Count > 0) do
            with TSyntaxBlock(bl.First) do
            begin
              if ParentID >= 0 then
              begin
                tn := nil;
                for j := 0 to Pred(Count) do
                  if Item[j].Data = Pointer(ParentID) then
                  begin
                    tn := Item[j];
                    break;
                  end;
                if Assigned(tn) then
                begin
                  AddChild(tn, Name).Data := Pointer(ID);
                  bl.Delete(0);
                end
                else
                  bl.Move(0, bl.Count - 1);
              end
              else
              begin //hanging block
                Add(nil, Name).Data := Pointer(ID);
                bl.Delete(0);
              end;
            end;
        end;
      finally
        bl.Free;
      end;
    finally
      EndUpdate;
    end;
  end;
  ATree.FullExpand;
end;

function TSyntaxEdForm.IsIdent(AString: string): Boolean;
begin
  //reserved for future
  Result := True;
end;

procedure TSyntaxEdForm.GetDefaultFontAttr(var AName: string; var ASize: integer);
begin
  with FEditedScheme do
    if Assigned(FEditedScheme) and Assigned(Parser) and
      Assigned(Parser.DefaultAttr.Font) then
    begin
      AName := Parser.DefaultAttr.Font.Name;
      ASize := Parser.DefaultAttr.Font.Size;
    end
    else
    begin
      AName := DefaultFontName;
      ASize := DefaultFontSize;
    end;
end;

procedure TSyntaxEdForm.CreateNewScheme;
begin
  if Assigned(FCurScheme) then
    FCurScheme.Free;
  FFileName := '';
  FCurScheme := TSyntaxScheme.Create;
end;

procedure TSyntaxEdForm.CompactScheme;
var
  i, j: integer;
  FIDSet: set of byte;
begin
  FIDSet := [];
  for i := 0 to Pred(FCurScheme.SyntaxBlocks.Count) do
    with FCurScheme.SyntaxBlocks[i] do
    begin
      UseMetaSymbol := UseMetaSymbol and (MetaSymbol <> #0);
      UseLineDirectives := UseLineDirectives and (LineDirectivePrefix <> '');
      UseSingleLineComments :=
        UseSingleLineComments and (SingleLineCommentDelimiters.Count > 0);
      UseMultiLineComments :=
        UseMultiLineComments and (MultiLineCommentDelimiters.Count > 0);
      UseFullLineComments :=
        UseFullLineComments and (FullLineCommentDelimiters.Count > 0);
      UseComments := UseComments and
        (UseSingleLineComments or UseMultiLineComments or UseFullLineComments);
      UseSingleLineStrings :=
        UseSingleLineStrings and (SingleLineStringDelimiters.Count > 0);
      UseMultiLineStrings :=
        UseMultiLineStrings and (MultiLineStringDelimiters.Count > 0);
      UseStrings := UseStrings and (UseSingleLineStrings or UseMultiLineStrings);
      UsePrefixedNumbers := UsePrefixedNumbers and (NumPrefixes.Count > 0);
      UseSuffixedNumbers := UseSuffixedNumbers and (NumSuffixes.Count > 0);
      UsePrefixedSuffixedNumbers := UsePrefixedSuffixedNumbers and
        (UsePSNumComposition or (NumPrefixesSuffixes.Count > 0));
      UsePrefixedIdentifiers := UsePrefixedIdentifiers and (IdentPrefixes.Count > 0);
      UseSuffixedIdentifiers := UseSuffixedIdentifiers and (IdentSuffixes.Count > 0);
      UsePrefixedSuffixedIdentifiers :=
        UsePrefixedSuffixedIdentifiers and (IdentPrefixesSuffixes.Count > 0);
      UseKeywords := UseKeywords and (KeywordSets.Count > 0);

      Include(FIDSet, FIText);
      Include(FIDSet, FIIdentifier);
      Include(FIDSet, FISymbol);
      Include(FIDSet, FIDirective);
      with SingleLineCommentDelimiters do
        for j := 0 to Pred(Count) do
          Include(FIDSet, Items[j].FontID);
      with MultiLineCommentDelimiters do
        for j := 0 to Pred(Count) do
          Include(FIDSet, Items[j].FontID);
      with FullLineCommentDelimiters do
        for j := 0 to Pred(Count) do
          Include(FIDSet, Items[j].FontID);
      with SingleLineStringDelimiters do
        for j := 0 to Pred(Count) do
          Include(FIDSet, Items[j].FontID);
      with MultiLineStringDelimiters do
        for j := 0 to Pred(Count) do
          Include(FIDSet, Items[j].FontID);
      Include(FIDSet, FIIntNum);
      Include(FIDSet, FIFloatNum);
      Include(FIDSet, FIHexNum);
      with NumPrefixes do
        for j := 0 to Pred(Count) do
          Include(FIDSet, Items[j].FontID);
      with NumSuffixes do
        for j := 0 to Pred(Count) do
          Include(FIDSet, Items[j].FontID);
      with NumPrefixesSuffixes do
        for j := 0 to Pred(Count) do
          Include(FIDSet, Items[j].FontID);
      //P-, S- & PS- identifiers doesn't use its own FontID
      with KeywordSets do
        for j := 0 to Pred(Count) do
          Include(FIDSet, Items[j].FontID);
    end;
  if FIDSet <> [] then
    with FCurScheme.FontTable do
      for i := Pred(Count) downto 0 do
        if not (Items[i].FontID in FIDSet) then
          Items[i].Free;
  CorrectBlockIndexes;
  SetCurBlock;
end;

procedure TSyntaxEdForm.SetSyntaxScheme(AValue: TSyntaxScheme);
begin
  FEditedScheme := AValue;
  CreateNewScheme;
  FCurScheme.Assign(FEditedScheme);
  SetCurScheme;
end;

procedure TSyntaxEdForm.CorrectBlockIndexes;
var
  i, j, aid: integer;
begin
  with trvBlocks.Items do
    for i := 0 to Count - 1 do
    begin
      aid := integer(Item[i].Data);
      with FCurScheme do
        for j := 0 to SyntaxBlocks.Count - 1 do
          with SyntaxBlocks[j] do
            if ID = aid then
              Index := i;
    end;
end;

procedure TSyntaxEdForm.SetCurScheme;
begin
  //fill elements with FCurScheme data
  with FCurScheme do
  begin
    edtSchemeName.Text := Name;
    {$IFDEF USEEXTENSIONS}
    lbxExts.Items.Assign(Extensions);
    {$ENDIF}
    UpdateBlocksTree(trvBlocks);
  end;
  CorrectBlockIndexes;
  ChooseBlock(0); //update whole PageControl
end;

procedure TSyntaxEdForm.ChooseBlock(AID: integer);
var
  i: integer;
begin
  with trvBlocks.Items do
    for i := 0 to Count - 1 do
      if integer(Item[i].Data) = AID then
      begin
        Item[i].Selected := True;
        break;
      end;
  trvBlocksChange(nil, nil);
end;

procedure TSyntaxEdForm.SetCurBlock;
begin
  with FCurBlock do
  begin
    FCollections[1] := SingleLineCommentDelimiters;
    FCollections[2] := MultiLineCommentDelimiters;
    FCollections[3] := SingleLineStringDelimiters;
    FCollections[4] := MultiLineStringDelimiters;
    FCollections[5] := NumPrefixes;
    FCollections[6] := NumSuffixes;
    FCollections[7] := NumPrefixesSuffixes;
    FCollections[8] := KeywordSets;
    FCollections[9] := BlockDelimiters;
    FCollections[10] := FullLineCommentDelimiters;
    FCollections[11] := IdentPrefixes;
    FCollections[12] := IdentSuffixes;
    FCollections[13] := IdentPrefixesSuffixes;
    AssignDelimitersList2ListBox(lbxBlkDlmtrs, BlockDelimiters);
    with trvBlocks do
      lblBlkDelimiters.Enabled := (Selected <> nil) and (Selected.AbsoluteIndex > 0);
    UpdateBlockDelimiters;

    chxCaseSens.Checked := CaseSensitive;
    chxUseMeta.Checked := UseMetaSymbol;
    edtMetaSymbol.Text := MetaSymbol;
    chxMetaEscape.Checked := UseMetaSymbol;
    chxMetaWrapLines.Checked := UseMetaToWrapLines;
    UpdateUseMeta;

    if chxUseSymbols.Checked xor UseSymbols then
      chxUseSymbols.Checked := UseSymbols
    else
      UpdateUseSymbols;

    edtDrctvPrefix.Text := LineDirectivePrefix;
    if chxUseDirectives.Checked xor UseLineDirectives then
      chxUseDirectives.Checked := UseLineDirectives
    else
      UpdateUseDirectives;

    AssignLineTokenList2ListBox(lbxDlmtrsSC, SingleLineCommentDelimiters);
    AssignBlockTokenList2ListBox(lbxDlmtrsMC, MultiLineCommentDelimiters);
    AssignLineTokenList2ListBox(lbxDlmtrsFC, FullLineCommentDelimiters);
    chxUseCommentsSL.Checked := UseSingleLineComments;
    chxUseCommentsML.Checked := UseMultiLineComments;
    chxUseCommentsFL.Checked := UseFullLineComments;
    if chxUseComments.Checked xor UseComments then
      chxUseComments.Checked := UseComments
    else
      UpdateUseComments;

    AssignBlockTokenList2ListBox(lbxDlmtrsSS, SingleLineStringDelimiters);
    AssignBlockTokenList2ListBox(lbxDlmtrsMS, MultiLineStringDelimiters);
    chxUseStringsSL.Checked := UseSingleLineStrings;
    chxUseStringsML.Checked := UseMultiLineStrings;
    if chxUseStrings.Checked xor UseStrings then
      chxUseStrings.Checked := UseStrings
    else
      UpdateUseStrings;

    if rgpPSNumbers.ItemIndex < 0 then
      rgpPSNumbers.ItemIndex := 0
    else
      rgpPSNumbersClick(nil);
    if chxUseNumbers.Checked xor UseNumbers then
      chxUseNumbers.Checked := UseNumbers
    else
      UpdateUseNumbers;

    if chxUseIdentifiers.Checked xor UseIdentifiers then
      chxUseIdentifiers.Checked := UseIdentifiers
    else
      UpdateUseIdentifiers;
    if rgpPSIdents.ItemIndex < 0 then
      rgpPSIdents.ItemIndex := 0
    else
      rgpPSIdentsClick(nil);

    AssignKeywordSetList2ListBox(lbxKWSets, KeywordSets);
    if chxUseKeywords.Checked xor UseKeywords then
      chxUseKeywords.Checked := UseKeywords
    else
      UpdateUseKeywords;
  end;
end;

procedure TSyntaxEdForm.chxUseMetaClick(Sender: TObject);
begin
  FCurBlock.UseMetaSymbol := chxUseMeta.Checked;
  UpdateUseMeta;
end;

procedure TSyntaxEdForm.btnAddBlockClick(Sender: TObject);
var
  s: string;
  pi, uid: integer;
begin
  s := '';
  pi := 0;
  FCheckIdents := False;
  try
    uid := FCurScheme.GetUniqueBlockID;
    if PopupBlock(TControl(Sender), s, pi, uid) then
      with TSyntaxBlock(FCurScheme.SyntaxBlocks.Add) do
      begin
        Name := s;
        ID := uid;
        ParentID := pi;
        UpdateBlocksTree(trvBlocks);
        ChooseBlock(ID);
      end;
  finally
    FCheckIdents := True;
  end;
end;

procedure TSyntaxEdForm.btnRmvBlockClick(Sender: TObject);
var
  i, pid, idx: integer;
  sob: set of byte;
begin
  if MessageDlg(SQueryRemoveBlock + ' ''' + trvBlocks.Selected.Text + '''?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    sob := [];
    with trvBlocks do
      for i := 0 to Items.Count - 1 do
        if Items[i].HasAsParent(Selected) then
          Include(sob, byte(Items[i].Data));
    idx := integer(trvBlocks.Selected.Data);
    pid := 0;
    with FCurScheme do
    begin
      for i := SyntaxBlocks.Count - 1 downto 0 do
      begin
        if SyntaxBlocks[i].ID in sob then
        begin
          SyntaxBlocks[i].Free;
          continue;
        end;
        if SyntaxBlocks[i].ID = idx then
        begin
          pid := SyntaxBlocks[i].ParentID;
          SyntaxBlocks[i].Free;
          break;
        end;
      end;
      UpdateBlocksTree(trvBlocks);
      ChooseBlock(pid);
    end;
  end;
end;

procedure TSyntaxEdForm.btnClearClick(Sender: TObject);
begin
  CreateNewScheme;
  SetCurScheme;
end;

procedure TSyntaxEdForm.EnumTS(const Str: string);
begin
  cbxTextStyle1.Items.Add(Str);
end;

procedure TSyntaxEdForm.FormCreate(Sender: TObject);

  procedure SetBtnBounds(AButton: TBitBtn);
  begin
    with TDCColorCombo(AButton.Tag) do
      AButton.SetBounds(Left + Width + 2, Top, 22, Height);
  end;

var
  i: integer;
begin
  {$IFDEF D4}
  BorderWidth := 4;
  {$ENDIF}
  LoadLocalizedCaptions;
  {$IFNDEF USEEXTENSIONS}
  with tshSchemeExts do
  begin
    TabVisible := False;
    Visible := False;
  end;
  {$ENDIF}

  FPopupActive := False;
  FCheckIdents := True;
  ApplyWasClicked := False;

  cbxFontName1.Items.Assign(Screen.Fonts);
  with cbxFontSize1.Items do
  begin
    BeginUpdate;
    for i := 0 to 15 do
      Add(IntToStr(StdFontSizes[i]));
    EndUpdate;
  end;
  cbxFontName2.Items.Assign(cbxFontName1.Items);
  cbxFontSize2.Items.Assign(cbxFontSize1.Items);
  cbxFontName3.Items.Assign(cbxFontName1.Items);
  cbxFontSize3.Items.Assign(cbxFontSize1.Items);
  cbxTextStyle1.Items.Add(''); //no global attr. item
  EnumTextStyles(EnumTS);
  cbxTextStyle2.Items.Assign(cbxTextStyle1.Items);
  cbxTextStyle3.Items.Assign(cbxTextStyle1.Items);

  bbnFontColor1.Tag := integer(cbxFontColor1);
  SetBtnBounds(bbnFontColor1);
  bbnBackColor1.Glyph.Assign(bbnFontColor1.Glyph);
  bbnBackColor1.Tag := integer(cbxBackColor1);
  SetBtnBounds(bbnBackColor1);
  bbnFontColor2.Glyph.Assign(bbnFontColor1.Glyph);
  bbnFontColor2.Tag := integer(cbxFontColor2);
  SetBtnBounds(bbnFontColor2);
  bbnBackColor2.Glyph.Assign(bbnFontColor1.Glyph);
  bbnBackColor2.Tag := integer(cbxBackColor2);
  SetBtnBounds(bbnBackColor2);
  bbnFontColor3.Glyph.Assign(bbnFontColor1.Glyph);
  bbnFontColor3.Tag := integer(cbxFontColor3);
  SetBtnBounds(bbnFontColor3);
  bbnBackColor3.Glyph.Assign(bbnFontColor1.Glyph);
  bbnBackColor3.Tag := integer(cbxBackColor3);
  SetBtnBounds(bbnBackColor3);

  pgcBlockElems.ActivePage := tshCommon;
  pgcSchemeElems.ActivePage := tshSchemeBlocks;

  CreateNewScheme;
  SetCurScheme;
end;

procedure TSyntaxEdForm.chxUseDirectivesClick(Sender: TObject);
begin
  FCurBlock.UseLineDirectives := chxUseDirectives.Checked;
  UpdateUseDirectives;
end;

procedure TSyntaxEdForm.chxUseIdentifiersClick(Sender: TObject);
begin
  FCurBlock.UseIdentifiers := chxUseIdentifiers.Checked;
  UpdateUseIdentifiers;
end;

procedure TSyntaxEdForm.chxUseSymbolsClick(Sender: TObject);
begin
  FCurBlock.UseSymbols := chxUseSymbols.Checked;
  UpdateUseSymbols;
end;

procedure TSyntaxEdForm.chxUseCommentsClick(Sender: TObject);
begin
  FCurBlock.UseComments := chxUseComments.Checked;
  UpdateUseComments;
end;

procedure TSyntaxEdForm.chxUseCommentsSLClick(Sender: TObject);
begin
  FCurBlock.UseSingleLineComments := chxUseCommentsSL.Checked;
  UpdateUseCommentsSL;
end;

procedure TSyntaxEdForm.chxUseCommentsMLClick(Sender: TObject);
begin
  FCurBlock.UseMultiLineComments := chxUseCommentsML.Checked;
  UpdateUseCommentsML;
end;

procedure TSyntaxEdForm.btnRmvDlmtrSCClick(Sender: TObject);
var
  i: integer;
begin
  with FCurBlock do
  begin
    i := lbxDlmtrsSC.ItemIndex;
    SingleLineCommentDelimiters.Items[i].Free;
    AssignLineTokenList2ListBox(lbxDlmtrsSC, SingleLineCommentDelimiters);
    if i >= lbxDlmtrsSC.Items.Count then
      i := Pred(lbxDlmtrsSC.Items.Count);
    lbxDlmtrsSC.ItemIndex := i;
    lbxDlmtrsSCClick(nil);
  end;
end;

procedure TSyntaxEdForm.btnAddDlmtrSCClick(Sender: TObject);
var
  lt: TLineToken;
begin
  lt := TLineToken.Create(nil);
  try
    if PopupLineToken(TControl(Sender), lt, SCaptionDelimiter) then
      with FCurBlock, TLineToken(SingleLineCommentDelimiters.Add) do
      begin
        Assign(lt);
        AssignLineTokenList2ListBox(lbxDlmtrsSC, SingleLineCommentDelimiters);
        lbxDlmtrsSC.ItemIndex := Index;
        lbxDlmtrsSCClick(nil);
      end;
  finally
    lt.Free;
  end;
end;

procedure TSyntaxEdForm.btnEditDlmtrSCClick(Sender: TObject);
var
  lt: TLineToken;
  i: integer;
begin
  with FCurBlock do
  begin
    lt := SingleLineCommentDelimiters[lbxDlmtrsSC.ItemIndex];
    if PopupLineToken(TControl(Sender), lt, SCaptionDelimiter) then
    begin
      i := lbxDlmtrsSC.ItemIndex;
      AssignLineTokenList2ListBox(lbxDlmtrsSC, SingleLineCommentDelimiters);
      lbxDlmtrsSC.ItemIndex := i;
      lbxDlmtrsSCClick(nil);
    end;
  end;
end;

procedure TSyntaxEdForm.AssignLineTokenList2ListBox(AListBox: TCheckListBox;
  ALineTokenList: TLineTokenList);
var
  i: integer;
begin
  with AListBox.Items do
  begin
    BeginUpdate;
    Clear;
    for i := 0 to Pred(ALineTokenList.Count) do
      AListBox.Checked[Add(ALineTokenList[i].LeftDelimiter)] :=
        ALineTokenList[i].UseToken;
    EndUpdate;
    if Count > 0 then
      AListBox.ItemIndex := 0;
  end;
end;

procedure TSyntaxEdForm.AssignBlockTokenList2ListBox(AListBox: TCheckListBox;
  ABlockTokenList: TBlockTokenList);
var
  i: integer;
begin
  with AListBox.Items do
  begin
    BeginUpdate;
    Clear;
    for i := 0 to Pred(ABlockTokenList.Count) do
      AListBox.Checked[Add(ABlockTokenList[i].LeftDelimiter + SAnd +
        ABlockTokenList[i].RightDelimiter)] := ABlockTokenList[i].UseToken;
    EndUpdate;
    if Count > 0 then
      AListBox.ItemIndex := 0;
  end;
end;

procedure TSyntaxEdForm.AssignDelimitersList2ListBox(AListBox: TCheckListBox;
  ADelimitersList: TDelimitersList);
var
  i: integer;
begin
  with AListBox.Items do
  begin
    BeginUpdate;
    Clear;
    for i := 0 to Pred(ADelimitersList.Count) do
      AListBox.Checked[Add(ADelimitersList[i].LeftDelimiter + SAnd +
        ADelimitersList[i].RightDelimiter)] := ADelimitersList[i].UseToken;
    EndUpdate;
    if Count > 0 then
      AListBox.ItemIndex := 0;
  end;
end;

procedure TSyntaxEdForm.AssignKeywordSetList2ListBox(AListBox: TCheckListBox;
  AKeywordSetList: TKeywordSetList);
var
  i: integer;
begin
  with AListBox.Items do
  begin
    BeginUpdate;
    Clear;
    for i := 0 to Pred(AKeywordSetList.Count) do
      AListBox.Checked[Add(AKeywordSetList[i].Name)] :=
        AKeywordSetList[i].UseToken;
    EndUpdate;
  end;
end;

procedure TSyntaxEdForm.chxUseStringsClick(Sender: TObject);
begin
  FCurBlock.UseStrings := chxUseStrings.Checked;
  UpdateUseStrings;
end;

procedure TSyntaxEdForm.chxUseNumbersClick(Sender: TObject);
begin
  FCurBlock.UseNumbers := chxUseNumbers.Checked;
  UpdateUseNumbers;
end;

procedure TSyntaxEdForm.chxPSNumbersClick(Sender: TObject);
begin
  case rgpPSNumbers.ItemIndex of
    0: FCurBlock.UsePrefixedNumbers := chxPSNumbers.Checked;
    1: FCurBlock.UseSuffixedNumbers := chxPSNumbers.Checked;
    2: FCurBlock.UsePrefixedSuffixedNumbers := chxPSNumbers.Checked;
  end;
  UpdateUsePSNumbers;
end;

procedure TSyntaxEdForm.chxUseKeywordsClick(Sender: TObject);
begin
  FCurBlock.UseKeywords := chxUseKeywords.Checked;
  UpdateUseKeywords;
end;

procedure TSyntaxEdForm.edtSchemeNameExit(Sender: TObject);
begin
  FCurScheme.Name := edtSchemeName.Text;
end;

procedure TSyntaxEdForm.chxCaseSensClick(Sender: TObject);
begin
  FCurBlock.CaseSensitive := chxCaseSens.Checked;
end;

procedure TSyntaxEdForm.edtMetaSymbolExit(Sender: TObject);
begin
  if edtMetaSymbol.Text <> '' then
    FCurBlock.MetaSymbol := edtMetaSymbol.Text[1]
  else
    FCurblock.MetaSymbol := #0;
end;

procedure TSyntaxEdForm.edtDrctvPrefixExit(Sender: TObject);
begin
  FCurBlock.LineDirectivePrefix := edtDrctvPrefix.Text;
end;

procedure TSyntaxEdForm.btnSaveClick(Sender: TObject);
begin
  if FFileName = '' then
    btnSaveAsClick(Sender)
  else
  try
    Screen.Cursor := crHourGlass;
    CompactScheme;
    FCurScheme.SaveToFile(FFileName);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TSyntaxEdForm.lbxDlmtrsSCKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_INSERT:
      btnAddDlmtrSCClick(Sender);
    VK_DELETE:
      if btnRmvDlmtrSC.Enabled then
        btnRmvDlmtrSCClick(nil);
    VK_RETURN:
      if btnEditDlmtrSC.Enabled then
        btnEditDlmtrSCClick(Sender);
  end;
  inherited;
end;

procedure TSyntaxEdForm.lbxDlmtrsMCKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_INSERT:
      btnAddDlmtrMCClick(Sender);
    VK_DELETE:
      if btnRmvDlmtrMC.Enabled then
        btnRmvDlmtrMCClick(nil);
    VK_RETURN:
      if btnEditDlmtrMC.Enabled then
        btnEditDlmtrMCClick(Sender);
  end;
  inherited;
end;

procedure TSyntaxEdForm.lbxDlmtrsSSKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_INSERT:
      btnAddDlmtrSSClick(Sender);
    VK_DELETE:
      if btnRmvDlmtrSS.Enabled then
        btnRmvDlmtrSSClick(nil);
    VK_RETURN:
      if btnEditDlmtrSS.Enabled then
        btnEditDlmtrSSClick(Sender);
  end;
  inherited;
end;

procedure TSyntaxEdForm.lbxDlmtrsPSNumKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT:
      btnAddDlmtrPSNumClick(Sender);
    VK_DELETE:
      if btnRmvDlmtrPSNum.Enabled then
        btnRmvDlmtrPSNumClick(nil);
    VK_RETURN:
      if btnEditDlmtrPSNum.Enabled then
        btnEditDlmtrPSNumClick(Sender);
  end;
  inherited;
end;

procedure TSyntaxEdForm.lbxKWSetsClick(Sender: TObject);
begin
  btnRmvKWSet.Enabled := lbxKWSets.Enabled and (lbxKWSets.ItemIndex >= 0);
  btnEditKWSet.Enabled := btnRmvKWSet.Enabled;
  lbxKeywords.Enabled := btnRmvKWSet.Enabled;
  with lbxKWSets do
    if ItemIndex >= 0 then
      FCurKWSet := FCurBlock.KeywordSets.Items[ItemIndex]
    else
      FCurKWSet := nil;
  SetCurKWSet;
  lbxKeywordsClick(nil);
end;

procedure TSyntaxEdForm.lbxKWSetsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_INSERT:
      btnAddKWSetClick(Sender);
    VK_DELETE:
      if btnRmvKWSet.Enabled then
        btnRmvKWSetClick(nil);
    VK_RETURN:
      if btnEditKWSet.Enabled then
        btnEditKWSetClick(Sender);
  end;
  inherited;
end;

procedure TSyntaxEdForm.lbxKeywordsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_INSERT:
      btnAddKWClick(Sender);
    VK_DELETE:
      if btnRmvKW.Enabled then
        btnRmvKWClick(nil);
    VK_RETURN:
      if btnEditKW.Enabled then
        btnEditKWClick(Sender);
  end;
  inherited;
end;

procedure TSyntaxEdForm.btnRmvDlmtrMCClick(Sender: TObject);
var
  i: integer;
begin
  with FCurBlock do
  begin
    i := lbxDlmtrsMC.ItemIndex;
    MultiLineCommentDelimiters.Items[i].Free;
    AssignBlockTokenList2ListBox(lbxDlmtrsMC, MultiLineCommentDelimiters);
    if i >= lbxDlmtrsMC.Items.Count then
      i := Pred(lbxDlmtrsMC.Items.Count);
    lbxDlmtrsMC.ItemIndex := i;
    lbxDlmtrsMCClick(nil);
  end;
end;

procedure TSyntaxEdForm.btnAddDlmtrMCClick(Sender: TObject);
var
  bt: TBlockToken;
begin
  bt := TBlockToken.Create(nil);
  try
    if PopupBlockToken(TControl(Sender), bt, SCaptionLeftDlmtr, SCaptionRightDlmtr) then
      with FCurBlock, TBlockToken(MultiLineCommentDelimiters.Add) do
      begin
        Assign(bt);
        AssignBlockTokenList2ListBox(lbxDlmtrsMC, MultiLineCommentDelimiters);
        lbxDlmtrsMC.ItemIndex := Index;
        lbxDlmtrsMCClick(nil);
      end;
  finally
    bt.Free;
  end;
end;

procedure TSyntaxEdForm.btnEditDlmtrMCClick(Sender: TObject);
var
  bt: TBlockToken;
  i: integer;
begin
  with FCurBlock do
  begin
    bt := MultiLineCommentDelimiters[lbxDlmtrsMC.ItemIndex];
    if PopupBlockToken(TControl(Sender), bt, SCaptionLeftDlmtr, SCaptionRightDlmtr) then
    begin
      i := lbxDlmtrsMC.ItemIndex;
      AssignBlockTokenList2ListBox(lbxDlmtrsMC, MultiLineCommentDelimiters);
      lbxDlmtrsMC.ItemIndex := i;
      lbxDlmtrsMCClick(nil);
    end;
  end;
end;

procedure TSyntaxEdForm.btnRmvDlmtrSSClick(Sender: TObject);
var
  i: integer;
begin
  with FCurBlock do
  begin
    i := lbxDlmtrsSS.ItemIndex;
    SingleLineStringDelimiters.Items[i].Free;
    AssignBlockTokenList2ListBox(lbxDlmtrsSS, SingleLineStringDelimiters);
    if i >= lbxDlmtrsSS.Items.Count then
      i := Pred(lbxDlmtrsSS.Items.Count);
    lbxDlmtrsSS.ItemIndex := i;
    lbxDlmtrsSSClick(nil);
  end;
end;

procedure TSyntaxEdForm.btnAddDlmtrSSClick(Sender: TObject);
var
  bt: TBlockToken;
begin
  bt := TBlockToken.Create(nil);
  try
    if PopupBlockToken(TControl(Sender), bt, SCaptionLeftDlmtr, SCaptionRightDlmtr) then
      with FCurBlock, TBlockToken(SingleLineStringDelimiters.Add) do
      begin
        Assign(bt);
        AssignBlockTokenList2ListBox(lbxDlmtrsSS, SingleLineStringDelimiters);
        lbxDlmtrsSS.ItemIndex := Index;
        lbxDlmtrsSSClick(nil);
      end;
  finally
    bt.Free;
  end;
end;

procedure TSyntaxEdForm.btnEditDlmtrSSClick(Sender: TObject);
var
  bt: TBlockToken;
  i: integer;
begin
  with FCurBlock do
  begin
    bt := SingleLineStringDelimiters[lbxDlmtrsSS.ItemIndex];
    if PopupBlockToken(TControl(Sender), bt, SCaptionLeftDlmtr, SCaptionRightDlmtr) then
    begin
      i := lbxDlmtrsSS.ItemIndex;
      AssignBlockTokenList2ListBox(lbxDlmtrsSS, SingleLineStringDelimiters);
      lbxDlmtrsSS.ItemIndex := i;
      lbxDlmtrsSSClick(nil);
    end;
  end;
end;

procedure TSyntaxEdForm.btnRmvDlmtrPSNumClick(Sender: TObject);
var
  i: integer;
begin
  with FCurBlock do
  begin
    i := lbxDlmtrsPSNum.ItemIndex;
    case rgpPSNumbers.ItemIndex of
      0:
        begin
          NumPrefixes.Items[i].Free;
          AssignLineTokenList2ListBox(lbxDlmtrsPSNum, NumPrefixes);
        end;
      1:
        begin
          NumSuffixes.Items[i].Free;
          AssignLineTokenList2ListBox(lbxDlmtrsPSNum, NumSuffixes);
        end;
      2:
        begin
          NumPrefixesSuffixes.Items[i].Free;
          AssignBlockTokenList2ListBox(lbxDlmtrsPSNum, NumPrefixesSuffixes);
        end;
    end;
    if i >= lbxDlmtrsPSNum.Items.Count then
      i := Pred(lbxDlmtrsPSNum.Items.Count);
    lbxDlmtrsPSNum.ItemIndex := i;
    lbxDlmtrsPSNumClick(nil);
  end;
end;

procedure TSyntaxEdForm.btnAddDlmtrPSNumClick(Sender: TObject);
var
  lt: TLineToken;
  ALabel, LD, RD: string;
begin
  LD := '';
  RD := '';
  with FCurBlock do
    if rgpPSNumbers.ItemIndex = 2 then
    begin
      if PopupInputPair(TControl(Sender), LD, RD, SCaptionPrefix, SCaptionSuffix) then
        with TBlockToken(NumPrefixesSuffixes.Add) do
        begin
          LeftDelimiter := LD;
          RightDelimiter := RD;
          FontID := -1;
          AssignBlockTokenList2ListBox(lbxDlmtrsPSNum, NumPrefixesSuffixes);
          lbxDlmtrsPSNum.ItemIndex := Index;
          lbxDlmtrsPSNumClick(nil);
        end;
    end
    else
    begin
      FCheckIdents := False;
      try
        if rgpPSNumbers.ItemIndex = 0 then
          ALabel := SCaptionPrefix
        else
          ALabel := SCaptionSuffix;
        if PopupInputLine(TControl(Sender), LD, ALabel) then
        begin
          if rgpPSNumbers.ItemIndex = 0 then
            lt := TLineToken(NumPrefixes.Add)
          else
            lt := TLineToken(NumSuffixes.Add);
          with lt do
          begin
            LeftDelimiter := LD;
            FontID := -1;
            if rgpPSNumbers.ItemIndex = 0 then
              AssignLineTokenList2ListBox(lbxDlmtrsPSNum, NumPrefixes)
            else
              AssignLineTokenList2ListBox(lbxDlmtrsPSNum, NumSuffixes);
            lbxDlmtrsPSNum.ItemIndex := Index;
            lbxDlmtrsPSNumClick(nil);
          end;
        end;
      finally
        FCheckIdents := True;
      end;
    end;
end;

procedure TSyntaxEdForm.btnEditDlmtrPSNumClick(Sender: TObject);
var
  i: integer;
  ALabel, LD, RD: string;
begin
  with FCurBlock do
    if rgpPSNumbers.ItemIndex = 2 then
    begin
      with NumPrefixesSuffixes[lbxDlmtrsPSNum.ItemIndex] do
      begin
        LD := LeftDelimiter;
        RD := RightDelimiter;
      end;
      if PopupInputPair(TControl(Sender), LD, RD, SCaptionPrefix, SCaptionSuffix) then
      begin
        with NumPrefixesSuffixes[lbxDlmtrsPSNum.ItemIndex] do
        begin
          LeftDelimiter := LD;
          RightDelimiter := RD;
        end;
        i := lbxDlmtrsPSNum.ItemIndex;
        AssignBlockTokenList2ListBox(lbxDlmtrsPSNum, NumPrefixesSuffixes);
        lbxDlmtrsPSNum.ItemIndex := i;
        lbxDlmtrsPSNumClick(nil);
      end;
    end
    else
    try
      FCheckIdents := False;
      if rgpPSNumbers.ItemIndex = 0 then
      begin
        ALabel := SCaptionPrefix;
        LD := NumPrefixes[lbxDlmtrsPSNum.ItemIndex].LeftDelimiter;
      end
      else
      begin
        ALabel := SCaptionSuffix;
        LD := NumSuffixes[lbxDlmtrsPSNum.ItemIndex].LeftDelimiter;
      end;
      if PopupInputLine(TControl(Sender), LD, ALabel) then
      begin
        i := lbxDlmtrsPSNum.ItemIndex;
        if rgpPSNumbers.ItemIndex = 0 then
        begin
          NumPrefixes[i].LeftDelimiter := LD;
          AssignLineTokenList2ListBox(lbxDlmtrsPSNum, NumPrefixes);
        end
        else
        begin
          NumSuffixes[i].LeftDelimiter := LD;
          AssignLineTokenList2ListBox(lbxDlmtrsPSNum, NumSuffixes);
        end;
        lbxDlmtrsPSNum.ItemIndex := i;
        lbxDlmtrsPSNumClick(nil);
      end;
    finally
      FCheckIdents := True;
    end;
end;

procedure TSyntaxEdForm.btnRmvKWSetClick(Sender: TObject);
var
  i: integer;
begin
  if MessageDlg(SQueryRemoveKWSet + ' ''' + lbxKWSets.Items[lbxKWSets.ItemIndex] + '''?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    with FCurBlock do
    begin
      i := lbxKWSets.ItemIndex;
      KeywordSets.Items[i].Free;
      AssignKeywordSetList2ListBox(lbxKWSets, KeywordSets);
      if i >= lbxKWSets.Items.Count then
        i := Pred(lbxKWSets.Items.Count);
      lbxKWSets.ItemIndex := i;
      lbxKWSetsClick(nil);
    end;
end;

procedure TSyntaxEdForm.btnAddKWSetClick(Sender: TObject);
var
  lt: TLineToken;
begin
  lt := TLineToken.Create(nil);
  try
    if PopupLineToken(TControl(Sender), lt, SCaptionSet) then
      with FCurBlock, TKeywordSet(KeywordSets.Add) do
      begin
        //impossible to use Assign
        Name := lt.LeftDelimiter;
        Keywords := '';
        FontID := lt.FontID;
        AssignKeywordSetList2ListBox(lbxKWSets, KeywordSets);
        lbxKWSets.ItemIndex := Index;
        lbxKWSetsClick(nil);
      end;
  finally
    lt.Free;
  end;
end;

procedure TSyntaxEdForm.btnEditKWSetClick(Sender: TObject);
var
  lt: TLineToken;
  ks: TKeywordSet;
  i: integer;
begin
  lt := TLineToken.Create(nil);
  with FCurBlock do
  try
    ks := KeywordSets.Items[lbxKWSets.ItemIndex];
    lt.LeftDelimiter := ks.Name;
    lt.FontID := ks.FontID;
    if PopupLineToken(TControl(Sender), lt, SCaptionSet) then
    begin
      ks.Name := lt.LeftDelimiter;
      ks.FontID := lt.FontID;
      i := lbxKWSets.ItemIndex;
      AssignKeywordSetList2ListBox(lbxKWSets, KeywordSets);
      lbxKWSets.ItemIndex := i;
      lbxKWSetsClick(nil);
    end;
  finally
    lt.Free;
  end;
end;

procedure TSyntaxEdForm.btnAddKWClick(Sender: TObject);
var
  s: string;
  Idx: integer;
begin
  s := '';
  if PopupInputLine(TControl(Sender), s, SCaptionKeyword) then
    with FCurKWSet, lbxKeywords do
    begin
      Items.BeginUpdate;
      for Idx := 0 to Pred(Items.Count) do
        Selected[Idx] := False;
      s := Trim(s);
      //empty keywords and duplicates not allowed
      if not ((s = '') or (Items.IndexOf(s) >= 0)) then
      begin
        Idx := Items.Add(s);
        FCurKWSet.Keywords := Items.CommaText;
        Selected[Idx] := True;
        ItemIndex := Idx;
      end
      else
        Selected[ItemIndex] := True;
      Items.EndUpdate;
      lbxKeywordsClick(nil);
    end;
end;

procedure TSyntaxEdForm.btnRmvKWClick(Sender: TObject);
var
  i, Idx: integer;
begin
  Idx := -1;
  with FCurKWSet, lbxKeywords do
  begin
    Items.BeginUpdate;
    for i := Pred(Items.Count) downto 0 do
      if Selected[i] then
      begin
        Items.Delete(i);
        Idx := i;
      end;
    Keywords := Items.CommaText;
    if Idx >= Items.Count then
      Idx := Pred(Items.Count);
    if Idx >= 0 then
      Selected[Idx] := True;
    ItemIndex := Idx;
    Items.EndUpdate;
    lbxKeywordsClick(nil);
  end;
end;

procedure TSyntaxEdForm.btnEditKWClick(Sender: TObject);
var
  s: string;
  Idx: integer;
begin
  s := lbxKeywords.Items[lbxKeywords.ItemIndex];
  if PopupInputLine(TControl(Sender), s, SCaptionKeyword) then
    with FCurKWSet, lbxKeywords do
    begin
      Items.BeginUpdate;
      s := Trim(s);
      //empty keywords and duplicates not allowed
      if not ((s = '') or (Items.IndexOf(s) >= 0)) then
      begin
        Items.Delete(ItemIndex);
        Idx := Items.Add(s);
        Keywords := Items.CommaText;
        if Idx >= 0 then
          Selected[Idx] := True;
        ItemIndex := Idx;
      end;
      Items.EndUpdate;
      lbxKeywordsClick(nil);
    end;
end;

procedure TSyntaxEdForm.btnSaveKWClick(Sender: TObject);
begin
  SaveDialog1.Filter := SFilterKeywords;
  SaveDialog1.DefaultExt := SExtKeywords;
  if SaveDialog1.Execute then
  try
    Screen.Cursor := crHourGlass;
    lbxKeywords.Items.SaveToFile(SaveDialog1.FileName);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TSyntaxEdForm.btnLoadKWClick(Sender: TObject);
var
  i: integer;
begin
  OpenDialog1.Filter := SFilterKeywords;
  OpenDialog1.DefaultExt := SExtKeywords;
  if OpenDialog1.Execute then
    with TStringList.Create do
    try
      Screen.Cursor := crHourGlass;
      Sorted := True;
      Duplicates := dupIgnore;
      LoadFromFile(OpenDialog1.FileName);
      CommaText := Text;

      for i := Pred(Count) downto 0 do //delete all non-identifiers
        if FCheckIdents and not IsIdent(Strings[i]) then
          Delete(i);

      FCurKWSet.Keywords := CommaText;
      lbxKWSetsClick(nil);
    finally
      Free;
      Screen.Cursor := crDefault;
    end;
end;

procedure TSyntaxEdForm.SetCurKWSet;
begin
  lbxKeywords.Items.Clear;
  if Assigned(FCurKWSet) then
    with FCurKWSet do
    begin
      VisualizeAttr(lbxKeywords, CorrectFontID(FontID));
      lbxKeywords.Items.CommaText := Keywords;
    end;
end;

procedure TSyntaxEdForm.btnStyleTextClick(Sender: TObject);
var
  i: integer;
begin
  i := FCurBlock.FIText;
  PopupFontStyle(TControl(Sender), i);
  FCurBlock.FIText := i;
end;

procedure Style2Checks(chxB, chxI, chxU, chxS: TCheckBox; Style: TFontStyles);
begin
  chxB.Checked := fsBold in Style;
  chxI.Checked := fsItalic in Style;
  chxU.Checked := fsUnderline in Style;
  chxS.Checked := fsStrikeout in Style;
end;

function Checks2Style(chxB, chxI, chxU, chxS: TCheckBox): TFontStyles;
begin
  Result := [];
  if chxB.Checked then
    Include(Result, fsBold);
  if chxI.Checked then
    Include(Result, fsItalic);
  if chxU.Checked then
    Include(Result, fsUnderline);
  if chxS.Checked then
    Include(Result, fsStrikeout);
end;

{$IFNDEF D4}

procedure TSyntaxEdForm.SaveComboIndexes(Ctrl: TWinControl);
var
  i, j: integer;
begin
  j := 0;
  with Ctrl do
    for i := 0 to ControlCount - 1 do
      if Controls[i] is TComboBox then
      begin
        FComboIndexes[j] := TComboBox(Controls[i]).ItemIndex;
        Inc(j);
      end;
end;

procedure TSyntaxEdForm.RestoreComboIndexes(Ctrl: TWinControl);
var
  i, j: integer;
begin
  j := 0;
  with Ctrl do
    for i := 0 to ControlCount - 1 do
      if Controls[i] is TComboBox then
      begin
        TComboBox(Controls[i]).ItemIndex := FComboIndexes[j];
        Inc(j);
      end;
end;
{$ENDIF}

function TSyntaxEdForm.PopupPanel(What, Where: TControl): Boolean;
var
  snai6, snai8: integer;

  procedure SaveData;
  begin
    if Assigned(trvBlocks6.Selected) then
      snai6 := trvBlocks6.Selected.AbsoluteIndex
    else
      snai6 := -1;
    if Assigned(trvBlocks8.Selected) then
      snai8 := trvBlocks8.Selected.AbsoluteIndex
    else
      snai8 := -1;
    {$IFNDEF D4}
    SaveComboIndexes(TWinControl(What));
    {$ENDIF}
  end;

  procedure RestoreData;
  begin
    {$IFNDEF D4}
    RestoreComboIndexes(TWinControl(What));
    {$ENDIF}
    if snai8 >= 0 then
      trvBlocks8.Selected := trvBlocks8.Items[snai8]
    else
      trvBlocks8.Selected := nil;
    if snai6 >= 0 then
      trvBlocks6.Selected := trvBlocks6.Items[snai6]
    else
      trvBlocks6.Selected := nil;
  end;

var
  PopupForm: TForm;
  Origin: TPoint;
  rcWork: TRect;
begin
  PopupForm := TForm.CreateNew(nil{$IFDEF CPB1}, 0{$ENDIF});
  with PopupForm do
  try
    Visible := False;
    Tag := What.Tag;
    BorderStyle := bsNone;
    AutoScroll := False;
    KeyPreview := True;
    OnCloseQuery := PopupCloseQuery;
    ClientWidth := What.Width;
    ClientHeight := What.Height;
    with Where do
      Origin := ClientToScreen(Point(Width - What.Width, Height));
    with Origin, rcWork do
    begin
      SystemParametersInfo(SPI_GETWORKAREA, 0, @rcWork, 0);
      if X < Left then X := Left;
      if Y < Top then Y := Top;
      if X > Right - Width then X := Right - Width;
      if Y > Bottom - Height then Y := Bottom - Height;
      SetBounds(X, Y, Width, Height);
    end;
    with What do
    begin
      Left := 0;
      Top := 0;
      SaveData;
      Parent := PopupForm;
      RestoreData;
    end;
    FPopupActive := True;
    Result := ShowModal = mrOK;
  finally
    FPopupActive := False;
    SaveData;
    What.Parent := tshPopups;
    RestoreData;
    Free;
  end;
end;

procedure TSyntaxEdForm.PopupCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  b1, b2, b3, b4: Boolean;
  i: integer;
  n: TTreeNode;
begin
  b1 := True;
  b2 := True;
  b3 := True;
  b4 := True;
  with TForm(Sender) do
    if ModalResult = mrOK then
      case Tag of
        1:
          begin
            b2 := chxUseDefFont1.Checked or (cbxFontSize1.ItemIndex >= 0);
            if not b2 then
              cbxFontSize1.SetFocus;
            b1 := chxUseDefFont1.Checked or (cbxFontName1.ItemIndex >= 0);
            if not b1 then
              cbxFontName1.SetFocus;
          end;
        2:
          begin
            b3 := chxUseDefFont2.Checked or (cbxFontSize2.ItemIndex >= 0);
            if not b3 then
              cbxFontSize2.SetFocus;
            b2 := chxUseDefFont2.Checked or (cbxFontName2.ItemIndex >= 0);
            if not b2 then
              cbxFontName2.SetFocus;
            b1 := Trim(edtDlmtr2.Text) <> '';
            if not b1 then
              edtDlmtr2.SetFocus;
          end;
        3:
          begin
            b4 := chxUseDefFont3.Checked or (cbxFontSize3.ItemIndex >= 0);
            if not b4 then
              cbxFontSize3.SetFocus;
            b3 := chxUseDefFont3.Checked or (cbxFontName3.ItemIndex >= 0);
            if not b3 then
              cbxFontName3.SetFocus;
            b2 := Trim(edtRDlmtr3.Text) <> '';
            if not b2 then
              edtRDlmtr3.SetFocus;
            b1 := Trim(edtLDlmtr3.Text) <> '';
            if not b1 then
              edtLDlmtr3.SetFocus;
          end;
        4:
          begin
            b1 := (Trim(edtKeyword4.Text) <> '') and
              (not FCheckIdents or IsIdent(edtKeyword4.Text));
            if not b1 then
              edtKeyword4.SetFocus;
          end;
        5:
          begin
            b2 := Trim(edtRDlmtr5.Text) <> '';
            if not b2 then
              edtRDlmtr5.SetFocus;
            b1 := Trim(edtLDlmtr5.Text) <> '';
            if not b1 then
              edtLDlmtr5.SetFocus;
          end;
        6:
          begin
            b2 := trvBlocks6.Selected <> nil;
            if not b2 then
              trvBlocks6.SetFocus;
            b1 := lbxCopyBlocks.ItemIndex >= 0;
            if not b1 then
              lbxCopyBlocks.SetFocus;
          end;
        7:
          begin
            b2 := Trim(edtRDlmtr7.Text) <> '';
            if not b2 then
              edtRDlmtr7.SetFocus;
            b1 := Trim(edtLDlmtr7.Text) <> '';
            if not b1 then
              edtLDlmtr7.SetFocus;
          end;
        8:
          with trvBlocks8 do
          begin
            b2 := (Selected <> nil) or not Enabled;
            if b2 then
            begin
              n := nil;
              with Items do
                for i := 0 to Count - 1 do
                  if integer(Item[i].Data) = Tag then
                  begin
                    n := Item[i];
                    break;
                  end;
              if Assigned(n) then
                b2 := (Selected <> n) and not Selected.HasAsParent(n);
            end;
            if not b2 then
              SetFocus;
            b1 := Trim(edtDlmtr8.Text) <> '';
            if not b1 then
              edtDlmtr8.SetFocus;
          end;
      end;
  CanClose := b1 and b2 and b3 and b4;
end;

procedure TSyntaxEdForm.WMNCActivate(var Message: TWMNCActivate);
begin
  if FPopupActive and Application.Active then
    Message.Active := True;
  inherited;
end;

function TSyntaxEdForm.PopupFontStyle(Anchor: TControl;
  var AFontID: integer): Boolean;
var
  fs: TFontStyles;
  fi: TAttrItem;
  n: string;
  s: integer;
begin
  FillPopupForm(CorrectFontID(AFontID), cbxFontName1, cbxFontSize1,
    chxUseDefFont1, chxUseDefBack1, chxBold1, chxItalic1, chxUnderline1,
    chxStrikeout1, cbxFontColor1, cbxBackColor1, cbxTextStyle1);
  Result := PopupPanel(pnlPopup1, Anchor);
  if Result then
  begin
    fs := Checks2Style(chxBold1, chxItalic1, chxUnderline1, chxStrikeout1);
    if AFontID < 0 then
    begin
      fi := TAttrItem(FCurScheme.FontTable.Add);
      fi.BlockID := FCurBlock.ID;
      AFontID := fi.FontID;
    end
    else
      fi := FCurScheme.FontTable.GetItemByID(AFontID);
    with fi do
    begin
      GetDefaultFontAttr(n, s);
      UseDefFont := chxUseDefFont1.Checked;
      if cbxFontName1.Text <> '' then
        Font.Name := cbxFontName1.Text
      else
        Font.Name := n;
      if cbxFontSize1.Text <> '' then
        Font.Size := StrToInt(cbxFontSize1.Text)
      else
        Font.Size := s;
      Font.Color := cbxFontColor1.SelectedColor;
      Font.Style := fs;
      UseDefBack := chxUseDefBack1.Checked;
      BackColor := cbxBackColor1.SelectedColor;
      GlobalAttrID := cbxTextStyle1.Text;
    end;
  end;
end;

function TSyntaxEdForm.PopupLineToken(Anchor: TControl;
  var ALineToken: TLineToken; const ALabel: string): Boolean;
var
  fs: TFontStyles;
  fi: TAttrItem;
  n: string;
  s: integer;
begin
  lblDlmtr2.Caption := ALabel;
  edtDlmtr2.Text := ALineToken.LeftDelimiter;
  FillPopupForm(CorrectFontID(ALineToken.FontID), cbxFontName2, cbxFontSize2,
    chxUseDefFont2, chxUseDefBack2, chxBold2, chxItalic2, chxUnderline2,
    chxStrikeout2, cbxFontColor2, cbxBackColor2, cbxTextStyle2);
  Result := PopupPanel(pnlPopup2, Anchor);
  if Result then
  begin
    ALineToken.LeftDelimiter := edtDlmtr2.Text;
    fs := Checks2Style(chxBold2, chxItalic2, chxUnderline2, chxStrikeout2);
    if ALineToken.FontID < 0 then
    begin
      fi := TAttrItem(FCurScheme.FontTable.Add);
      fi.BlockID := FCurBlock.ID;
      ALineToken.FontID := fi.FontID;
    end
    else
      fi := FCurScheme.FontTable.GetItemByID(ALineToken.FontID);
    with fi do
    begin
      GetDefaultFontAttr(n, s);
      UseDefFont := chxUseDefFont2.Checked;
      if cbxFontName2.Text <> '' then
        Font.Name := cbxFontName2.Text
      else
        Font.Name := n;
      if cbxFontSize2.Text <> '' then
        Font.Size := StrToInt(cbxFontSize2.Text)
      else
        Font.Size := s;
      Font.Color := cbxFontColor2.SelectedColor;
      Font.Style := fs;
      UseDefBack := chxUseDefBack2.Checked;
      BackColor := cbxBackColor2.SelectedColor;
      GlobalAttrID := cbxTextStyle2.Text;
    end;
  end;
end;

function TSyntaxEdForm.PopupBlockToken(Anchor: TControl;
  var ABlockToken: TBlockToken; const ALabelL, ALabelR: string): Boolean;
var
  fs: TFontStyles;
  fi: TAttrItem;
  n: string;
  s: integer;
begin
  lblLDlmtr3.Caption := ALabelL;
  lblRDlmtr3.Caption := ALabelR;
  edtLDlmtr3.Text := ABlockToken.LeftDelimiter;
  edtRDlmtr3.Text := ABlockToken.RightDelimiter;
  FillPopupForm(CorrectFontID(ABlockToken.FontID), cbxFontName3, cbxFontSize3,
    chxUseDefFont3, chxUseDefBack3, chxBold3, chxItalic3, chxUnderline3,
    chxStrikeout3, cbxFontColor3, cbxBackColor3, cbxTextStyle3);
  Result := PopupPanel(pnlPopup3, Anchor);
  if Result then
  begin
    ABlockToken.LeftDelimiter := edtLDlmtr3.Text;
    ABlockToken.RightDelimiter := edtRDlmtr3.Text;
    fs := Checks2Style(chxBold3, chxItalic3, chxUnderline3, chxStrikeout3);
    if ABlockToken.FontID < 0 then
    begin
      fi := TAttrItem(FCurScheme.FontTable.Add);
      fi.BlockID := FCurBlock.ID;
      ABlockToken.FontID := fi.FontID;
    end
    else
      fi := FCurScheme.FontTable.GetItemByID(ABlockToken.FontID);
    with fi do
    begin
      GetDefaultFontAttr(n, s);
      UseDefFont := chxUseDefFont3.Checked;
      if cbxFontName3.Text <> '' then
        Font.Name := cbxFontName3.Text
      else
        Font.Name := n;
      if cbxFontSize3.Text <> '' then
        Font.Size := StrToInt(cbxFontSize3.Text)
      else
        Font.Size := s;
      Font.Color := cbxFontColor3.SelectedColor;
      Font.Style := fs;
      UseDefBack := chxUseDefBack3.Checked;
      BackColor := cbxBackColor3.SelectedColor;
      GlobalAttrID := cbxTextStyle3.Text;
    end;
  end;
end;

function TSyntaxEdForm.PopupInputLine(Anchor: TControl;
  var AString: string; const ALabel: string): Boolean;
begin
  lblKeyword4.Caption := ALabel;
  edtKeyword4.Text := AString;
  Result := PopupPanel(pnlPopup4, Anchor);
  if Result then
    AString := edtKeyword4.Text;
end;

function TSyntaxEdForm.PopupInputPair(Anchor: TControl; var AStringL, AStringR: string;
  const ALabelL, ALabelR: string): Boolean;
begin
  lblLDlmtr7.Caption := ALabelL;
  lblRDlmtr7.Caption := ALabelR;
  edtLDlmtr7.Text := AStringL;
  edtRDlmtr7.Text := AStringR;
  Result := PopupPanel(pnlPopup7, Anchor);
  if Result then
  begin
    AStringL := edtLDlmtr7.Text;
    AStringR := edtRDlmtr7.Text;
  end;
end;

function TSyntaxEdForm.PopupInputDlmtrs(Anchor: TControl;
  var ADelimiters: TDelimiters): Boolean;
begin
  with ADelimiters do
  begin
    edtLDlmtr5.Text := LeftDelimiter;
    edtRDlmtr5.Text := RightDelimiter;
    chxDlmtrsArePart5.Checked := DelimitersArePartOfBlock;
    Result := PopupPanel(pnlPopup5, Anchor);
    if Result then
    begin
      LeftDelimiter := edtLDlmtr5.Text;
      RightDelimiter := edtRDlmtr5.Text;
      DelimitersArePartOfBlock := chxDlmtrsArePart5.Checked;
    end;
  end;
end;

function TSyntaxEdForm.PopupBlock(Anchor: TControl; var AString: string;
  var AParentID: integer; AID: integer): Boolean;
var
  i: integer;
begin
  edtDlmtr8.Text := AString;
  UpdateBlocksTree(trvBlocks8);
  with trvBlocks8 do
  begin
    Tag := AID; //Tag is a better place to save one integer :)
    Enabled := AParentID >= 0;
    with Items do
    begin
      for i := 0 to Count - 1 do
        if Item[i].Data = Pointer(AParentID) then
        begin
          Selected := Item[i];
          break;
        end;
    end;
    Result := PopupPanel(pnlPopup8, Anchor);
    if Result then
    begin
      AString := edtDlmtr8.Text;
      if Enabled then
        AParentID := integer(Selected.Data);
    end;
  end;
end;

procedure TSyntaxEdForm.FillPopupForm(AFontID: integer; AComboName, AComboSize: TComboBox;
  AChxDefFont, AChxDefBack, AChxBold, AChxItalic, AChxUnderline, AChxStrikeOut: TCheckBox;
  AFontColorEdit, ABackColorEdit: TDCColorCombo; AComboCSet: TComboBox);
begin
  if AFontID >= 0 then
    with FCurScheme.FontTable.GetItemByID(AFontID) do
    begin
      AChxDefFont.Checked := UseDefFont;
      AComboName.ItemIndex := AComboName.Items.IndexOf(Font.Name);
      AComboSize.ItemIndex := AComboSize.Items.IndexOf(IntToStr(Font.Size));
      AFontColorEdit.SelectedColor := Font.Color;
      Style2Checks(AChxBold, AChxItalic, AChxUnderline, AChxStrikeOut, Font.Style);
      AChxDefBack.Checked := UseDefBack;
      ABackColorEdit.SelectedColor := BackColor;
      AComboCSet.ItemIndex := AComboCSet.Items.IndexOf(GlobalAttrID);
    end
  else
  begin
    AChxDefFont.Checked := True;
    AComboName.ItemIndex := -1;
    AComboSize.ItemIndex := -1;
    AFontColorEdit.SelectedColor := clBlack;
    Style2Checks(AChxBold, AChxItalic, AChxUnderline, AChxStrikeOut, []);
    AChxDefBack.Checked := True;
    ABackColorEdit.SelectedColor := clWindow;
  end;
end;

type
  T_ListBox = class(TCustomListBox)
  end;

procedure TSyntaxEdForm.btnStyleIdentClick(Sender: TObject);
var
  i: integer;
begin
  i := FCurBlock.FIIdentifier;
  PopupFontStyle(TControl(Sender), i);
  FCurBlock.FIIdentifier := i;
  T_ListBox(lbxDlmtrsPSIdent).RecreateWnd;
end;

procedure TSyntaxEdForm.btnStyleSymbolsClick(Sender: TObject);
var
  i: integer;
begin
  i := FCurBlock.FISymbol;
  PopupFontStyle(TControl(Sender), i);
  FCurBlock.FISymbol := i;
end;

procedure TSyntaxEdForm.btnStyleDrctvClick(Sender: TObject);
var
  i: integer;
begin
  i := FCurBlock.FIDirective;
  PopupFontStyle(TControl(Sender), i);
  FCurBlock.FIDirective := i;
  VisualizeAttr(edtDrctvPrefix, i);
end;

procedure TSyntaxEdForm.btnStyleIntNumClick(Sender: TObject);
var
  i: integer;
begin
  i := FCurBlock.FIIntNum;
  PopupFontStyle(TControl(Sender), i);
  FCurBlock.FIIntNum := i;
  T_ListBox(lbxDlmtrsPSNum).RecreateWnd;
end;

procedure TSyntaxEdForm.btnStyleFloatNumClick(Sender: TObject);
var
  i: integer;
begin
  i := FCurBlock.FIFloatNum;
  PopupFontStyle(TControl(Sender), i);
  FCurBlock.FIFloatNum := i;
end;

procedure TSyntaxEdForm.lbxDlmtrsSCClick(Sender: TObject);
begin
  btnRmvDlmtrSC.Enabled := lbxDlmtrsSC.Enabled and (lbxDlmtrsSC.ItemIndex >= 0);
  btnEditDlmtrSC.Enabled := btnRmvDlmtrSC.Enabled;
end;

procedure TSyntaxEdForm.lbxDlmtrsPSNumClick(Sender: TObject);
begin
  btnRmvDlmtrPSNum.Enabled := lbxDlmtrsPSNum.Enabled and
    (lbxDlmtrsPSNum.ItemIndex >= 0);
  btnEditDlmtrPSNum.Enabled := btnRmvDlmtrPSNum.Enabled;
end;

procedure TSyntaxEdForm.lbxDlmtrsMCClick(Sender: TObject);
begin
  btnRmvDlmtrMC.Enabled := lbxDlmtrsMC.Enabled and (lbxDlmtrsMC.ItemIndex >= 0);
  btnEditDlmtrMC.Enabled := btnRmvDlmtrMC.Enabled;
end;

procedure TSyntaxEdForm.lbxDlmtrsSSClick(Sender: TObject);
begin
  btnRmvDlmtrSS.Enabled := lbxDlmtrsSS.Enabled and (lbxDlmtrsSS.ItemIndex >= 0);
  btnEditDlmtrSS.Enabled := btnRmvDlmtrSS.Enabled;
end;

procedure TSyntaxEdForm.lbxKeywordsClick(Sender: TObject);
begin
  with lbxKeywords do
  begin
    btnAddKW.Enabled := Enabled;
    btnLoadKW.Enabled := btnAddKW.Enabled;
    btnSaveKW.Enabled := btnAddKW.Enabled;
    btnRmvKW.Enabled := Enabled and (ItemIndex >= 0) and (SelCount > 0);
    btnEditKW.Enabled := Enabled and (SelCount = 1);
  end;
end;

procedure TSyntaxEdForm.btnLoadClick(Sender: TObject);
begin
  with OpenDialog1 do
  begin
    Filter := SFilterScheme;
    DefaultExt := SExtScheme;
    if Execute then
    try
      Screen.Cursor := crHourGlass;
      try
        FCurScheme.LoadFromFile(FileName);
        FFileName := FileName;
        SetCurScheme;
      except
      end;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TSyntaxEdForm.UpdateUseMeta;
begin
  edtMetaSymbol.Enabled := chxUseMeta.Checked;
  chxMetaEscape.Checked := chxUseMeta.Checked;
  chxMetaEscape.Enabled := edtMetaSymbol.Enabled;
  chxMetaWrapLines.Enabled := edtMetaSymbol.Enabled;
end;

procedure TSyntaxEdForm.UpdateBlockDelimiters;
begin
  lbxBlkDlmtrs.Enabled := lblBlkDelimiters.Enabled;
  btnAddBlkDlmtr.Enabled := lblBlkDelimiters.Enabled;
  lbxBlkDlmtrsClick(nil);
end;

procedure TSyntaxEdForm.UpdateUseDirectives;
begin
  VisualizeAttr(edtDrctvPrefix, FCurBlock.FIDirective);
  edtDrctvPrefix.Enabled := chxUseDirectives.Checked;
  lblDrctvPrefix.Enabled := edtDrctvPrefix.Enabled;
  btnStyleDrctv.Enabled := edtDrctvPrefix.Enabled;
end;

procedure TSyntaxEdForm.UpdateUseIdentifiers;
begin
  btnStyleIdent.Enabled := chxUseIdentifiers.Checked;
end;

procedure TSyntaxEdForm.UpdateUseSymbols;
begin
  btnStyleSymbols.Enabled := chxUseSymbols.Checked;
end;

procedure TSyntaxEdForm.UpdateUseComments;
begin
  chxUseCommentsSL.Enabled := chxUseComments.Checked;
  chxUseCommentsML.Enabled := chxUseCommentsSL.Enabled;
  chxUseCommentsFL.Enabled := chxUseCommentsSL.Enabled;
  UpdateUseCommentsSL;
  UpdateUseCommentsML;
  UpdateUseCommentsFL;
end;

procedure TSyntaxEdForm.UpdateUseCommentsSL;
begin
  lbxDlmtrsSC.Enabled := chxUseCommentsSL.Enabled and chxUseCommentsSL.Checked;
  btnAddDlmtrSC.Enabled := lbxDlmtrsSC.Enabled;
  lbxDlmtrsSCClick(nil);
end;

procedure TSyntaxEdForm.UpdateUseCommentsML;
begin
  lbxDlmtrsMC.Enabled := chxUseCommentsML.Enabled and chxUseCommentsML.Checked;
  btnAddDlmtrMC.Enabled := lbxDlmtrsMC.Enabled;
  lbxDlmtrsMCClick(nil);
end;

procedure TSyntaxEdForm.UpdateUseCommentsFL;
begin
  lbxDlmtrsFC.Enabled := chxUseCommentsFL.Enabled and chxUseCommentsFL.Checked;
  btnAddDlmtrFC.Enabled := lbxDlmtrsFC.Enabled;
  lbxDlmtrsFCClick(nil);
end;

procedure TSyntaxEdForm.UpdateUseStrings;
begin
  chxUseStringsSL.Enabled := chxUseStrings.Checked;
  chxUseStringsML.Enabled := chxUseStringsSL.Enabled;
  UpdateUseStringsSL;
  UpdateUseStringsML;
end;

procedure TSyntaxEdForm.UpdateUseNumbers;
begin
  chxPSNumbers.Enabled := chxUseNumbers.Checked;
  lblIntNum.Enabled := chxPSNumbers.Enabled;
  btnStyleIntNum.Enabled := chxPSNumbers.Enabled;
  lblFloatNum.Enabled := chxPSNumbers.Enabled;
  btnStyleFloatNum.Enabled := chxPSNumbers.Enabled;
  lblHexNum.Enabled := chxPSNumbers.Enabled;
  btnStyleHexNum.Enabled := chxPSNumbers.Enabled;
  rgpPSNumbers.Enabled := chxPSNumbers.Enabled;
  UpdateUsePSNumbers;
end;

procedure TSyntaxEdForm.UpdateUsePSNumbers;
begin
  chxPSNumOption.Enabled := chxPSNumbers.Enabled and chxPSNumbers.Checked;
  lbxDlmtrsPSNum.Enabled := chxPSNumOption.Enabled and
    ((rgpPSNumbers.ItemIndex <> 2) or not chxPSNumOption.Checked);
  btnAddDlmtrPSNum.Enabled := lbxDlmtrsPSNum.Enabled;
  lbxDlmtrsPSNumClick(nil);
end;

procedure TSyntaxEdForm.UpdateUsePSIdents;
begin
  lbxDlmtrsPSIdent.Enabled := chxPSIdents.Checked;
  btnAddDlmtrPSIdent.Enabled := lbxDlmtrsPSIdent.Enabled;
  lbxDlmtrsPSIdentClick(nil);
end;

procedure TSyntaxEdForm.UpdateUseKeywords;
begin
  lblKWSets.Enabled := chxUseKeywords.Checked;
  lbxKWSets.Enabled := lblKWSets.Enabled;
  btnAddKWSet.Enabled := lblKWSets.Enabled;
  lblCurKWSets.Enabled := lblKWSets.Enabled;
  lbxKeywords.Enabled := lblKWSets.Enabled;
  with lbxKWSets do
    if Items.Count > 0 then
      ItemIndex := 0;
  lbxKWSetsClick(nil);
end;

function TSyntaxEdForm.CorrectFontID(AFontID: integer): integer;
begin
  if AFontID < 0 then
    Result := FCurBlock.FIText
  else
    Result := AFontID;
end;

type
  T_Control = class(TControl)
  end;

procedure TSyntaxEdForm.VisualizeAttr(AControl: TControl; AFontID: integer);
var
  Attr: TAttrItem;
begin
  with T_Control(AControl) do
    if (AFontID >= 0) then
    begin
      Attr := FCurScheme.FontTable.GetItemByID(AFontID);
      Font.Assign(Attr.Font);
      Color := Attr.BackColor;
    end
    else
    begin
      ParentFont := True;
      Color := clWindow;
    end;
end;

function TSyntaxEdForm.GetTokenAttr(ATag, AIndex: integer): TAttrItem;
begin
  with FCurScheme.FontTable, FCurBlock do
    case ATag of
      1: Result := GetItemByID(SingleLineCommentDelimiters[AIndex].FontID);
      2: Result := GetItemByID(MultiLineCommentDelimiters[AIndex].FontID);
      3: Result := GetItemByID(SingleLineStringDelimiters[AIndex].FontID);
      4: Result := GetItemByID(MultiLineStringDelimiters[AIndex].FontID);
      5: Result := GetItemByID(FIIntNum);
      10: Result := GetItemByID(FullLineCommentDelimiters[AIndex].FontID);
      11: Result := GetItemByID(FIIdentifier);
      else
        Result := nil;
    end;
  if not Assigned(Result) and Assigned(FEditedScheme) and
    Assigned(FEditedScheme.Parser) then
  begin
    Result := FEditedScheme.Parser.DefaultAttr;
    Result.Font.Style := [];
  end;
end;

procedure TSyntaxEdForm.lbxMeasureItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
var
  AAttrItem: TAttrItem;
begin
  AAttrItem := GetTokenAttr(Control.Tag, Index);
  if Assigned(AAttrItem) and Assigned(AAttrItem.Font) then
    Height := GetMaxFontHeight(AAttrItem.Font);
end;

procedure TSyntaxEdForm.lbxDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Attr: TAttrItem;
begin
  with TCustomListBox(Control).Canvas do
  begin
    Attr := GetTokenAttr(Control.Tag, Index);
    with Attr.Font do
    begin
      Font.Name := Name;
      Font.Size := Size;
      Font.Style := Style;
      if State = [] then
        Font.Color := Color
      else if odDisabled in State then
        Font.Color := clGrayText;
    end;
    if not (odSelected in State) then
      Brush.Color := Attr.BackColor;
    FillRect(Rect);
    TextOut(Succ(Rect.Left), Rect.Top, TCustomListBox(Control).Items[Index]);
  end;
end;

procedure TSyntaxEdForm.FormDestroy(Sender: TObject);
begin
  if Assigned(FCurScheme) then
    FCurScheme.Free;
end;

procedure TSyntaxEdForm.lbxDlmtrsMSClick(Sender: TObject);
begin
  btnRmvDlmtrMS.Enabled := lbxDlmtrsMS.Enabled and (lbxDlmtrsMS.ItemIndex >= 0);
  btnEditDlmtrMS.Enabled := btnRmvDlmtrMS.Enabled;
end;

procedure TSyntaxEdForm.lbxDlmtrsMSKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_INSERT:
      btnAddDlmtrMSClick(Sender);
    VK_DELETE:
      if btnRmvDlmtrMS.Enabled then
        btnRmvDlmtrMSClick(nil);
    VK_RETURN:
      if btnEditDlmtrMS.Enabled then
        btnEditDlmtrMSClick(Sender);
  end;
  inherited;
end;

procedure TSyntaxEdForm.btnAddDlmtrMSClick(Sender: TObject);
var
  bt: TBlockToken;
begin
  bt := TBlockToken.Create(nil);
  try
    if PopupBlockToken(TControl(Sender), bt, SCaptionLeftDlmtr, SCaptionRightDlmtr) then
      with FCurBlock, TBlockToken(MultiLineStringDelimiters.Add) do
      begin
        Assign(bt);
        AssignBlockTokenList2ListBox(lbxDlmtrsMS, MultiLineStringDelimiters);
        lbxDlmtrsMS.ItemIndex := Index;
        lbxDlmtrsMSClick(nil);
      end;
  finally
    bt.Free;
  end;
end;

procedure TSyntaxEdForm.btnRmvDlmtrMSClick(Sender: TObject);
var
  i: integer;
begin
  with FCurBlock do
  begin
    i := lbxDlmtrsMS.ItemIndex;
    MultiLineStringDelimiters.Items[i].Free;
    AssignBlockTokenList2ListBox(lbxDlmtrsMS, MultiLineStringDelimiters);
    if i >= lbxDlmtrsMS.Items.Count then
      i := Pred(lbxDlmtrsMS.Items.Count);
    lbxDlmtrsMS.ItemIndex := i;
    lbxDlmtrsMSClick(nil);
  end;
end;

procedure TSyntaxEdForm.btnEditDlmtrMSClick(Sender: TObject);
var
  bt: TBlockToken;
  i: integer;
begin
  with FCurBlock do
  begin
    bt := MultiLineStringDelimiters[lbxDlmtrsMS.ItemIndex];
    if PopupBlockToken(TControl(Sender), bt, SCaptionLeftDlmtr, SCaptionRightDlmtr) then
    begin
      i := lbxDlmtrsMS.ItemIndex;
      AssignBlockTokenList2ListBox(lbxDlmtrsMS, MultiLineStringDelimiters);
      lbxDlmtrsMS.ItemIndex := i;
      lbxDlmtrsMSClick(nil);
    end;
  end;
end;

procedure TSyntaxEdForm.chxUseStringsSLClick(Sender: TObject);
begin
  FCurBlock.UseSingleLineStrings := chxUseStringsSL.Checked;
  UpdateUseStringsSL;
end;

procedure TSyntaxEdForm.chxUseStringsMLClick(Sender: TObject);
begin
  FCurBlock.UseMultiLineStrings := chxUseStringsML.Checked;
  UpdateUseStringsML;
end;

procedure TSyntaxEdForm.UpdateUseStringsSL;
begin
  lbxDlmtrsSS.Enabled := chxUseStringsSL.Enabled and chxUseStringsSL.Checked;
  btnAddDlmtrSS.Enabled := lbxDlmtrsSS.Enabled;
  lbxDlmtrsSSClick(nil);
end;

procedure TSyntaxEdForm.UpdateUseStringsML;
begin
  lbxDlmtrsMS.Enabled := chxUseStringsML.Enabled and chxUseStringsML.Checked;
  btnAddDlmtrMS.Enabled := lbxDlmtrsMS.Enabled;
  lbxDlmtrsMSClick(nil);
end;

procedure TSyntaxEdForm.btnApplyClick(Sender: TObject);
begin
  ApplyWasClicked := True;
  CompactScheme;
  FEditedScheme.Assign(FCurScheme);
end;

function EditSyntaxScheme(ASyntaxScheme: TSyntaxScheme): Boolean;
begin
  with TSyntaxEdForm.Create(nil) do
  try
    EditedScheme := ASyntaxScheme;
    Result := (ShowModal = mrOK) or ApplyWasClicked;
  finally
    Free;
  end;
end;

procedure TSyntaxEdForm.chxUseDefFont1Click(Sender: TObject);
begin
  lblFontName1.Enabled := not chxUseDefFont1.Checked;
  cbxFontName1.Enabled := lblFontName1.Enabled;
  lblFontSize1.Enabled := lblFontName1.Enabled;
  cbxFontSize1.Enabled := lblFontName1.Enabled;
end;

procedure TSyntaxEdForm.chxUseDefFont2Click(Sender: TObject);
begin
  lblFontName2.Enabled := not chxUseDefFont2.Checked;
  cbxFontName2.Enabled := lblFontName2.Enabled;
  lblFontSize2.Enabled := lblFontName2.Enabled;
  cbxFontSize2.Enabled := lblFontName2.Enabled;
end;

procedure TSyntaxEdForm.chxUseDefFont3Click(Sender: TObject);
begin
  lblFontName3.Enabled := not chxUseDefFont3.Checked;
  cbxFontName3.Enabled := lblFontName3.Enabled;
  lblFontSize3.Enabled := lblFontName3.Enabled;
  cbxFontSize3.Enabled := lblFontName3.Enabled;
end;

procedure TSyntaxEdForm.rgpPSNumbersClick(Sender: TObject);
begin
  with FCurBlock do
    case rgpPSNumbers.ItemIndex of
      0:
        begin
          AssignLineTokenList2ListBox(lbxDlmtrsPSNum, NumPrefixes);
          with chxPSNumbers do
          begin
            Caption := SWithPrefixes;
            Checked := UsePrefixedNumbers;
          end;
          chxPSNumOption.Visible := False;
        end;
      1:
        begin
          AssignLineTokenList2ListBox(lbxDlmtrsPSNum, NumSuffixes);
          with chxPSNumbers do
          begin
            Caption := SWithSuffixes;
            Checked := UseSuffixedNumbers;
          end;
          with chxPSNumOption do
          begin
            Visible := True;
            Caption := SMultiSuffixes;
            Checked := UseMultipleNumSuffixes;
          end;
        end;
      2:
        begin
          AssignBlockTokenList2ListBox(lbxDlmtrsPSNum, NumPrefixesSuffixes);
          with chxPSNumbers do
          begin
            Caption := SWithPSs;
            Checked := UsePrefixedSuffixedNumbers;
          end;
          with chxPSNumOption do
          begin
            Visible := True;
            Caption := SPSComposition;
            Checked := UsePSNumComposition;
          end;
        end;
    end;
  UpdateUsePSNumbers;
end;

procedure TSyntaxEdForm.lbxKWSetsDblClick(Sender: TObject);
begin
  if btnEditKWSet.Enabled then
    btnEditKWSetClick(Sender);
end;

procedure TSyntaxEdForm.lbxKeywordsDblClick(Sender: TObject);
begin
  if btnEditKW.Enabled then
    btnEditKWClick(Sender);
end;

procedure TSyntaxEdForm.lbxDlmtrsPSNumDblClick(Sender: TObject);
begin
  if btnEditDlmtrPSNum.Enabled then
    btnEditDlmtrPSNumClick(Sender);
end;

procedure TSyntaxEdForm.lbxDlmtrsSSDblClick(Sender: TObject);
begin
  if btnEditDlmtrSS.Enabled then
    btnEditDlmtrSSClick(Sender);
end;

procedure TSyntaxEdForm.lbxDlmtrsMSDblClick(Sender: TObject);
begin
  if btnEditDlmtrMS.Enabled then
    btnEditDlmtrMSClick(Sender);
end;

procedure TSyntaxEdForm.lbxDlmtrsSCDblClick(Sender: TObject);
begin
  if btnEditDlmtrSC.Enabled then
    btnEditDlmtrSCClick(Sender);
end;

procedure TSyntaxEdForm.lbxDlmtrsMCDblClick(Sender: TObject);
begin
  if btnEditDlmtrMC.Enabled then
    btnEditDlmtrMCClick(Sender);
end;

procedure TSyntaxEdForm.lbxBlkDlmtrsClick(Sender: TObject);
begin
  btnRmvBlkDlmtr.Enabled := lbxBlkDlmtrs.Enabled and (lbxBlkDlmtrs.ItemIndex >= 0);
  btnEditBlkDlmtr.Enabled := btnRmvBlkDlmtr.Enabled;
end;

procedure TSyntaxEdForm.lbxBlkDlmtrsDblClick(Sender: TObject);
begin
  if btnEditBlkDlmtr.Enabled then
    btnEditBlkDlmtrClick(Sender);
end;

procedure TSyntaxEdForm.lbxBlkDlmtrsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_INSERT:
      btnAddBlkDlmtrClick(Sender);
    VK_DELETE:
      if btnRmvBlkDlmtr.Enabled then
        btnRmvBlkDlmtrClick(nil);
    VK_RETURN:
      if btnEditBlkDlmtr.Enabled then
        btnEditBlkDlmtrClick(Sender);
  end;
  inherited;
end;

procedure TSyntaxEdForm.btnAddBlkDlmtrClick(Sender: TObject);
var
  dt: TDelimiters;
begin
  dt := TDelimiters.Create(nil);
  try
    if PopupInputDlmtrs(TControl(Sender), dt) then
      with FCurBlock, TDelimiters(BlockDelimiters.Add) do
      begin
        Assign(dt);
        AssignDelimitersList2ListBox(lbxBlkDlmtrs, BlockDelimiters);
        lbxBlkDlmtrs.ItemIndex := Index;
        lbxBlkDlmtrsClick(nil);
      end;
  finally
    dt.Free;
  end;
end;

procedure TSyntaxEdForm.btnRmvBlkDlmtrClick(Sender: TObject);
var
  i: integer;
begin
  with FCurBlock do
  begin
    i := lbxBlkDlmtrs.ItemIndex;
    BlockDelimiters.Items[i].Free;
    AssignDelimitersList2ListBox(lbxBlkDlmtrs, BlockDelimiters);
    if i >= lbxBlkDlmtrs.Items.Count then
      i := Pred(lbxBlkDlmtrs.Items.Count);
    lbxBlkDlmtrs.ItemIndex := i;
    lbxBlkDlmtrsClick(nil);
  end;
end;

procedure TSyntaxEdForm.btnEditBlkDlmtrClick(Sender: TObject);
var
  dt: TDelimiters;
  i: integer;
begin
  with FCurBlock do
  begin
    dt := BlockDelimiters[lbxBlkDlmtrs.ItemIndex];
    if PopupInputDlmtrs(TControl(Sender), dt) then
    begin
      i := lbxBlkDlmtrs.ItemIndex;
      AssignDelimitersList2ListBox(lbxBlkDlmtrs, BlockDelimiters);
      lbxBlkDlmtrs.ItemIndex := i;
      lbxBlkDlmtrsClick(nil);
    end;
  end;
end;

procedure TSyntaxEdForm.btnEditBlockClick(Sender: TObject);
var
  s: string;
  pi: integer;
begin
  with FCurBlock do
  begin
    s := Name;
    pi := ParentID;
    FCheckIdents := False;
    try
      if PopupBlock(TControl(Sender), s, pi, ID) then
      begin
        Name := s;
        ParentID := pi;
        UpdateBlocksTree(trvBlocks);
        ChooseBlock(ID);
      end;
    finally
      FCheckIdents := True;
    end;
  end;
end;

procedure TSyntaxEdForm.chxPSNumOptionClick(Sender: TObject);
begin
  case rgpPSNumbers.ItemIndex of
    0: ;
    1: FCurBlock.UseMultipleNumSuffixes := chxPSNumOption.Checked;
    2: FCurBlock.UsePSNumComposition := chxPSNumOption.Checked;
  end;
  UpdateUsePSNumbers;
end;

procedure TSyntaxEdForm.btnCopyBlockClick(Sender: TObject);
var
  CurID: integer;

  function CopyFontItem(fi: TAttrItem): integer;
  begin
    with TAttrItem(FCurScheme.FontTable.Add) do
    begin
      Result := FontID;
      BlockID := CurID;
      Font.Assign(fi.Font);
      UseDefFont := fi.UseDefFont;
    end;
  end;

var
  i: integer;
  s: string;
begin
  OpenDialog1.Filter := SFilterScheme;
  OpenDialog1.DefaultExt := SExtScheme;
  if OpenDialog1.Execute then
  try
    Screen.Cursor := crHourGlass;
    with TSyntaxScheme.Create do
    try
      try
        LoadFromFile(OpenDialog1.FileName);
        s := Name; //to avoid names ambiguity
        with lbxCopyBlocks do
        begin
          Clear;
          for i := 0 to Pred(SyntaxBlocks.Count) do
            Items.Add(SyntaxBlocks[i].Name);
        end;
        UpdateBlocksTree(trvBlocks6);
        if PopupPanel(pnlPopup6, btnCopyBlock) then
          with TSyntaxBlock(FCurScheme.SyntaxBlocks.Add) do
          begin
            Assign(SyntaxBlocks[lbxCopyBlocks.ItemIndex]);
            ID := FCurScheme.GetUniqueBlockID;
            CurID := ID;
            ParentID := integer(trvBlocks6.Selected.Data);
            Name := lbxCopyBlocks.Items[lbxCopyBlocks.ItemIndex];
            if Name = DefaultBlockName then
              Name := s;
            //FontItems are copied separately, FontIDs should be updated
            //!FontTable
            if FIText >= 0 then
              FIText := CopyFontItem(FontTable.GetItemByID(FIText));
            if FIIntNum >= 0 then
              FIIntNum := CopyFontItem(FontTable.GetItemByID(FIIntNum));
            if FIFloatNum >= 0 then
              FIFloatNum := CopyFontItem(FontTable.GetItemByID(FIFloatNum));
            if FIHexNum >= 0 then
              FIHexNum := CopyFontItem(FontTable.GetItemByID(FIHexNum));
            if FIDirective >= 0 then
              FIDirective := CopyFontItem(FontTable.GetItemByID(FIDirective));
            if FISymbol >= 0 then
              FISymbol := CopyFontItem(FontTable.GetItemByID(FISymbol));
            if FIIdentifier >= 0 then
              FIIdentifier := CopyFontItem(FontTable.GetItemByID(FIIdentifier));
            for i := 0 to Pred(SingleLineCommentDelimiters.Count) do
              with SingleLineCommentDelimiters[i] do
                if FontID >= 0 then
                  FontID := CopyFontItem(FontTable.GetItemByID(FontID));
            for i := 0 to Pred(MultiLineCommentDelimiters.Count) do
              with MultiLineCommentDelimiters[i] do
                if FontID >= 0 then
                  FontID := CopyFontItem(FontTable.GetItemByID(FontID));
            for i := 0 to Pred(FullLineCommentDelimiters.Count) do
              with FullLineCommentDelimiters[i] do
                if FontID >= 0 then
                  FontID := CopyFontItem(FontTable.GetItemByID(FontID));
            for i := 0 to Pred(SingleLineStringDelimiters.Count) do
              with SingleLineStringDelimiters[i] do
                if FontID >= 0 then
                  FontID := CopyFontItem(FontTable.GetItemByID(FontID));
            for i := 0 to Pred(MultiLineStringDelimiters.Count) do
              with MultiLineStringDelimiters[i] do
                if FontID >= 0 then
                  FontID := CopyFontItem(FontTable.GetItemByID(FontID));
            for i := 0 to Pred(NumPrefixes.Count) do
              with NumPrefixes[i] do
                if FontID >= 0 then
                  FontID := CopyFontItem(FontTable.GetItemByID(FontID));
            for i := 0 to Pred(NumSuffixes.Count) do
              with NumSuffixes[i] do
                if FontID >= 0 then
                  FontID := CopyFontItem(FontTable.GetItemByID(FontID));
            for i := 0 to Pred(NumPrefixesSuffixes.Count) do
              with NumPrefixesSuffixes[i] do
                if FontID >= 0 then
                  FontID := CopyFontItem(FontTable.GetItemByID(FontID));
            //P-, S- & PS- identifiers doesn't use its own FontID
            for i := 0 to Pred(KeywordSets.Count) do
              with KeywordSets[i] do
                if FontID >= 0 then
                  FontID := CopyFontItem(FontTable.GetItemByID(FontID));
            //!FontTable
            UpdateBlocksTree(trvBlocks);
            ChooseBlock(ID);
          end;
      except
      end;
    finally
      Free;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TSyntaxEdForm.lbxDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  Idx: integer;
begin
  if not (Source is TCustomListBox) then
    Accept := False
  else
    with TCustomListBox(Source) do
    begin
      Idx := ItemAtPos(Point(X, Y), True);
      Accept := (Sender = Source) and (Idx >= 0) and (Idx <> ItemIndex);
    end;
end;

procedure TSyntaxEdForm.lbxDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  Idx, ATag: integer;
begin
  if not (Source is TCustomListBox) then
    exit;
  with FCurBlock, TCustomListBox(Source) do
  begin
    Idx := ItemAtPos(Point(X, Y), True);
    ATag := Tag;
    if ATag = 5 then {P-, S- or PS-numbers?}
      ATag := ATag + rgpPSNumbers.ItemIndex;
    if ATag = 11 then {P-, S- or PS-identifiers?}
      ATag := ATag + rgpPSIdents.ItemIndex;
    FCollections[ATag].Items[ItemIndex].Index := Idx;
    case ATag of
      1, 5, 6, 10, 11, 12:
        AssignLineTokenList2ListBox(TCheckListBox(Source),
          TLineTokenList(FCollections[ATag]));
      2, 3, 4, 7, 13:
        AssignBlockTokenList2ListBox(TCheckListBox(Source),
          TBlockTokenList(FCollections[ATag]));
      8:
        AssignKeywordSetList2ListBox(TCheckListBox(Source),
          TKeywordSetList(FCollections[ATag]));
      9:
        AssignDelimitersList2ListBox(TCheckListBox(Source),
          TDelimitersList(FCollections[ATag]));
    end;
    ItemIndex := Idx;
  end;
end;

procedure TSyntaxEdForm.chxUseCommentsFLClick(Sender: TObject);
begin
  FCurBlock.UseFullLineComments := chxUseCommentsFL.Checked;
  UpdateUseCommentsFL;
end;

procedure TSyntaxEdForm.lbxDlmtrsFCClick(Sender: TObject);
begin
  btnRmvDlmtrFC.Enabled := lbxDlmtrsFC.Enabled and (lbxDlmtrsFC.ItemIndex >= 0);
  btnEditDlmtrFC.Enabled := btnRmvDlmtrFC.Enabled;
end;

procedure TSyntaxEdForm.lbxDlmtrsFCDblClick(Sender: TObject);
begin
  if btnEditDlmtrFC.Enabled then
    btnEditDlmtrFCClick(Sender);
end;

procedure TSyntaxEdForm.lbxDlmtrsFCKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_INSERT:
      btnAddDlmtrFCClick(Sender);
    VK_DELETE:
      if btnRmvDlmtrFC.Enabled then
        btnRmvDlmtrFCClick(nil);
    VK_RETURN:
      if btnEditDlmtrFC.Enabled then
        btnEditDlmtrFCClick(Sender);
  end;
  inherited;
end;

procedure TSyntaxEdForm.btnAddDlmtrFCClick(Sender: TObject);
var
  lt: TLineToken;
begin
  lt := TLineToken.Create(nil);
  try
    if PopupLineToken(TControl(Sender), lt, SCaptionDelimiter) then
      with FCurBlock, TLineToken(FullLineCommentDelimiters.Add) do
      begin
        Assign(lt);
        AssignLineTokenList2ListBox(lbxDlmtrsFC, FullLineCommentDelimiters);
        lbxDlmtrsFC.ItemIndex := Index;
        lbxDlmtrsFCClick(nil);
      end;
  finally
    lt.Free;
  end;
end;

procedure TSyntaxEdForm.btnRmvDlmtrFCClick(Sender: TObject);
var
  i: integer;
begin
  with FCurBlock do
  begin
    i := lbxDlmtrsFC.ItemIndex;
    FullLineCommentDelimiters.Items[i].Free;
    AssignLineTokenList2ListBox(lbxDlmtrsFC, FullLineCommentDelimiters);
    if i >= lbxDlmtrsFC.Items.Count then
      i := Pred(lbxDlmtrsFC.Items.Count);
    lbxDlmtrsFC.ItemIndex := i;
    lbxDlmtrsFCClick(nil);
  end;
end;

procedure TSyntaxEdForm.btnEditDlmtrFCClick(Sender: TObject);
var
  lt: TLineToken;
  i: integer;
begin
  with FCurBlock do
  begin
    lt := FullLineCommentDelimiters[lbxDlmtrsFC.ItemIndex];
    if PopupLineToken(TControl(Sender), lt, SCaptionDelimiter) then
    begin
      i := lbxDlmtrsFC.ItemIndex;
      AssignLineTokenList2ListBox(lbxDlmtrsFC, FullLineCommentDelimiters);
      lbxDlmtrsFC.ItemIndex := i;
      lbxDlmtrsFCClick(nil);
    end;
  end;
end;

procedure TSyntaxEdForm.rgpPSIdentsClick(Sender: TObject);
begin
  with FCurBlock do
    case rgpPSIdents.ItemIndex of
      0:
        begin
          AssignLineTokenList2ListBox(lbxDlmtrsPSIdent, IdentPrefixes);
          with chxPSIdents do
          begin
            Caption := SWithPrefixes;
            Checked := UsePrefixedIdentifiers;
          end;
        end;
      1:
        begin
          AssignLineTokenList2ListBox(lbxDlmtrsPSIdent, IdentSuffixes);
          with chxPSIdents do
          begin
            Caption := SWithSuffixes;
            Checked := UseSuffixedIdentifiers;
          end;
        end;
      2:
        begin
          AssignBlockTokenList2ListBox(lbxDlmtrsPSIdent, IdentPrefixesSuffixes);
          with chxPSIdents do
          begin
            Caption := SWithPSs;
            Checked := UsePrefixedSuffixedIdentifiers;
          end;
        end;
    end;
  UpdateUsePSIdents;
end;

procedure TSyntaxEdForm.chxPSIdentsClick(Sender: TObject);
begin
  case rgpPSIdents.ItemIndex of
    0: FCurBlock.UsePrefixedIdentifiers := chxPSIdents.Checked;
    1: FCurBlock.UseSuffixedIdentifiers := chxPSIdents.Checked;
    2: FCurBlock.UsePrefixedSuffixedIdentifiers := chxPSIdents.Checked;
  end;
  UpdateUsePSIdents;
end;

procedure TSyntaxEdForm.lbxDlmtrsPSIdentClick(Sender: TObject);
begin
  btnRmvDlmtrPSIdent.Enabled := lbxDlmtrsPSIdent.Enabled and
    (lbxDlmtrsPSIdent.ItemIndex >= 0);
  btnEditDlmtrPSIdent.Enabled := btnRmvDlmtrPSIdent.Enabled;
end;

procedure TSyntaxEdForm.lbxDlmtrsPSIdentDblClick(Sender: TObject);
begin
  if btnEditDlmtrPSIdent.Enabled then
    btnEditDlmtrPSIdentClick(Sender);
end;

procedure TSyntaxEdForm.lbxDlmtrsPSIdentKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT:
      btnAddDlmtrPSIdentClick(Sender);
    VK_DELETE:
      if btnRmvDlmtrPSIdent.Enabled then
        btnRmvDlmtrPSIdentClick(nil);
    VK_RETURN:
      if btnEditDlmtrPSIdent.Enabled then
        btnEditDlmtrPSIdentClick(Sender);
  end;
  inherited;
end;

procedure TSyntaxEdForm.btnAddDlmtrPSIdentClick(Sender: TObject);
var
  lt: TLineToken;
  ALabel, LD, RD: string;
begin
  LD := '';
  RD := '';
  with FCurBlock do
    if rgpPSIdents.ItemIndex = 2 then
    begin
      if PopupInputPair(TControl(Sender), LD, RD, SCaptionPrefix, SCaptionSuffix) then
        with TBlockToken(IdentPrefixesSuffixes.Add) do
        begin
          LeftDelimiter := LD;
          RightDelimiter := RD;
          FontID := -1;
          AssignBlockTokenList2ListBox(lbxDlmtrsPSIdent, IdentPrefixesSuffixes);
          lbxDlmtrsPSIdent.ItemIndex := Index;
          lbxDlmtrsPSIdentClick(nil);
        end;
    end
    else
    begin
      FCheckIdents := False;
      try
        if rgpPSIdents.ItemIndex = 0 then
          ALabel := SCaptionPrefix
        else
          ALabel := SCaptionSuffix;
        if PopupInputLine(TControl(Sender), LD, ALabel) then
        begin
          if rgpPSIdents.ItemIndex = 0 then
            lt := TLineToken(IdentPrefixes.Add)
          else
            lt := TLineToken(IdentSuffixes.Add);
          with lt do
          begin
            LeftDelimiter := LD;
            FontID := -1;
            if rgpPSIdents.ItemIndex = 0 then
              AssignLineTokenList2ListBox(lbxDlmtrsPSIdent, IdentPrefixes)
            else
              AssignLineTokenList2ListBox(lbxDlmtrsPSIdent, IdentSuffixes);
            lbxDlmtrsPSIdent.ItemIndex := Index;
            lbxDlmtrsPSIdentClick(nil);
          end;
        end;
      finally
        FCheckIdents := True;
      end;
    end;
end;

procedure TSyntaxEdForm.btnRmvDlmtrPSIdentClick(Sender: TObject);
var
  i: integer;
begin
  with FCurBlock do
  begin
    i := lbxDlmtrsPSIdent.ItemIndex;
    case rgpPSIdents.ItemIndex of
      0:
        begin
          IdentPrefixes.Items[i].Free;
          AssignLineTokenList2ListBox(lbxDlmtrsPSIdent, IdentPrefixes);
        end;
      1:
        begin
          IdentSuffixes.Items[i].Free;
          AssignLineTokenList2ListBox(lbxDlmtrsPSIdent, IdentSuffixes);
        end;
      2:
        begin
          IdentPrefixesSuffixes.Items[i].Free;
          AssignBlockTokenList2ListBox(lbxDlmtrsPSIdent, IdentPrefixesSuffixes);
        end;
    end;
    if i >= lbxDlmtrsPSIdent.Items.Count then
      i := Pred(lbxDlmtrsPSIdent.Items.Count);
    lbxDlmtrsPSIdent.ItemIndex := i;
    lbxDlmtrsPSIdentClick(nil);
  end;
end;

procedure TSyntaxEdForm.btnEditDlmtrPSIdentClick(Sender: TObject);
var
  i: integer;
  ALabel, LD, RD: string;
begin
  with FCurBlock do
    if rgpPSIdents.ItemIndex = 2 then
    begin
      with IdentPrefixesSuffixes[lbxDlmtrsPSIdent.ItemIndex] do
      begin
        LD := LeftDelimiter;
        RD := RightDelimiter;
      end;
      if PopupInputPair(TControl(Sender), LD, RD, SCaptionPrefix, SCaptionSuffix) then
      begin
        with IdentPrefixesSuffixes[lbxDlmtrsPSIdent.ItemIndex] do
        begin
          LeftDelimiter := LD;
          RightDelimiter := RD;
        end;
        i := lbxDlmtrsPSIdent.ItemIndex;
        AssignBlockTokenList2ListBox(lbxDlmtrsPSIdent, IdentPrefixesSuffixes);
        lbxDlmtrsPSIdent.ItemIndex := i;
        lbxDlmtrsPSIdentClick(nil);
      end;
    end
    else
    try
      FCheckIdents := False;
      if rgpPSIdents.ItemIndex = 0 then
      begin
        ALabel := SCaptionPrefix;
        LD := IdentPrefixes[lbxDlmtrsPSIdent.ItemIndex].LeftDelimiter;
      end
      else
      begin
        ALabel := SCaptionSuffix;
        LD := IdentSuffixes[lbxDlmtrsPSIdent.ItemIndex].LeftDelimiter;
      end;
      if PopupInputLine(TControl(Sender), LD, ALabel) then
      begin
        i := lbxDlmtrsPSIdent.ItemIndex;
        if rgpPSIdents.ItemIndex = 0 then
        begin
          IdentPrefixes[i].LeftDelimiter := LD;
          AssignLineTokenList2ListBox(lbxDlmtrsPSIdent, IdentPrefixes);
        end
        else
        begin
          IdentSuffixes[i].LeftDelimiter := LD;
          AssignLineTokenList2ListBox(lbxDlmtrsPSIdent, IdentSuffixes);
        end;
        lbxDlmtrsPSIdent.ItemIndex := i;
        lbxDlmtrsPSIdentClick(nil);
      end;
    finally
      FCheckIdents := True;
    end;
end;

procedure TSyntaxEdForm.btnStyleHexNumClick(Sender: TObject);
var
  i: integer;
begin
  i := FCurBlock.FIHexNum;
  PopupFontStyle(TControl(Sender), i);
  FCurBlock.FIHexNum := i;
end;

procedure TSyntaxEdForm.chxMetaEscapeClick(Sender: TObject);
begin
  chxMetaEscape.Checked := chxUseMeta.Checked;
end;

procedure TSyntaxEdForm.chxMetaWrapLinesClick(Sender: TObject);
begin
  FCurBlock.UseMetaToWrapLines := chxMetaWrapLines.Checked;
end;

procedure TSyntaxEdForm.chxUseDefBack1Click(Sender: TObject);
begin
  lblBackColor1.Enabled := not chxUseDefBack1.Checked;
  cbxBackColor1.Enabled := lblBackColor1.Enabled;
  bbnBackColor1.Enabled := lblBackColor1.Enabled;
end;

procedure TSyntaxEdForm.chxUseDefBack2Click(Sender: TObject);
begin
  lblBackColor2.Enabled := not chxUseDefBack2.Checked;
  cbxBackColor2.Enabled := lblBackColor2.Enabled;
  bbnBackColor2.Enabled := lblBackColor2.Enabled;
end;

procedure TSyntaxEdForm.chxUseDefBack3Click(Sender: TObject);
begin
  lblBackColor3.Enabled := not chxUseDefBack3.Checked;
  cbxBackColor3.Enabled := lblBackColor3.Enabled;
  bbnBackColor3.Enabled := lblBackColor3.Enabled;
end;

procedure TSyntaxEdForm.lbxBlkDlmtrsClickCheck(Sender: TObject);
begin
  with lbxBlkDlmtrs do
    FCurBlock.BlockDelimiters[ItemIndex].UseToken := Checked[ItemIndex];
end;

procedure TSyntaxEdForm.lbxDlmtrsSCClickCheck(Sender: TObject);
begin
  with lbxDlmtrsSC do
    FCurBlock.SingleLineCommentDelimiters[ItemIndex].UseToken := Checked[ItemIndex];
end;

procedure TSyntaxEdForm.lbxDlmtrsMCClickCheck(Sender: TObject);
begin
  with lbxDlmtrsMC do
    FCurBlock.MultiLineCommentDelimiters[ItemIndex].UseToken := Checked[ItemIndex];
end;

procedure TSyntaxEdForm.lbxDlmtrsFCClickCheck(Sender: TObject);
begin
  with lbxDlmtrsFC do
    FCurBlock.FullLineCommentDelimiters[ItemIndex].UseToken := Checked[ItemIndex];
end;

procedure TSyntaxEdForm.lbxDlmtrsSSClickCheck(Sender: TObject);
begin
  with lbxDlmtrsSS do
    FCurBlock.SingleLineStringDelimiters[ItemIndex].UseToken := Checked[ItemIndex];
end;

procedure TSyntaxEdForm.lbxDlmtrsMSClickCheck(Sender: TObject);
begin
  with lbxDlmtrsMS do
    FCurBlock.MultiLineStringDelimiters[ItemIndex].UseToken := Checked[ItemIndex];
end;

procedure TSyntaxEdForm.lbxDlmtrsPSNumClickCheck(Sender: TObject);
begin
  with FCurBlock, lbxDlmtrsPSNum do
    case rgpPSNumbers.ItemIndex of
      0: NumPrefixes[ItemIndex].UseToken := Checked[ItemIndex];
      1: NumSuffixes[ItemIndex].UseToken := Checked[ItemIndex];
      2: NumPrefixesSuffixes[ItemIndex].UseToken := Checked[ItemIndex];
    end;
end;

procedure TSyntaxEdForm.lbxDlmtrsPSIdentClickCheck(Sender: TObject);
begin
  with FCurBlock, lbxDlmtrsPSIdent do
    case rgpPSIdents.ItemIndex of
      0: IdentPrefixes[ItemIndex].UseToken := Checked[ItemIndex];
      1: IdentSuffixes[ItemIndex].UseToken := Checked[ItemIndex];
      2: IdentPrefixesSuffixes[ItemIndex].UseToken := Checked[ItemIndex];
    end;
end;

procedure TSyntaxEdForm.lbxKWSetsClickCheck(Sender: TObject);
begin
  with lbxKWSets do
    FCurBlock.KeywordSets[ItemIndex].UseToken := Checked[ItemIndex];
end;

procedure TSyntaxEdForm.trvBlocksChange(Sender: TObject; Node: TTreeNode);
var
  i, idx: integer;
begin
  with trvBlocks do
  begin
    //can't delete or rename Default Block (0th)
    btnRmvBlock.Enabled := (Selected <> nil) and (Selected.AbsoluteIndex > 0);
    btnEditBlock.Enabled := btnRmvBlock.Enabled;
    if Selected <> nil then
      idx := integer(Selected.Data)
    else
      idx := 0; //default block
  end;
  with FCurScheme do
    if idx >= 0 then
    begin
      for i := 0 to SyntaxBlocks.Count - 1 do
        if SyntaxBlocks[i].ID = idx then
        begin
          FCurBlock := SyntaxBlocks[i];
          break;
        end;
    end
    else
      FCurBlock := SyntaxBlocks[0];
  SetCurBlock;
end;

procedure TSyntaxEdForm.trvBlocksKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_INSERT:
      btnAddBlockClick(Sender);
    VK_DELETE:
      if btnRmvBlock.Enabled then
        btnRmvBlockClick(Sender);
    VK_RETURN:
      if btnEditBlock.Enabled then
        btnEditBlockClick(Sender);
  end;
  inherited;
end;

procedure TSyntaxEdForm.trvBlocksDblClick(Sender: TObject);
begin
  if btnEditBlock.Enabled then
    btnEditBlockClick(Sender);
end;

procedure TSyntaxEdForm.trvBlocksDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  i, aid, pid, ppid: integer;
begin
  with trvBlocks do
  begin
    aid := integer(Selected.Data);
    pid := integer(GetNodeAt(X, Y).Data);
    ppid := -1;
  end;
  with FCurScheme do
    if GetKeyState(VK_CONTROL) < 0 then
    begin
      for i := 0 to SyntaxBlocks.Count - 1 do
        with SyntaxBlocks[i] do
          if ID = aid then
          begin
            ParentID := pid;
            break;
          end;
    end
    else
    begin
      for i := 0 to SyntaxBlocks.Count - 1 do
        with SyntaxBlocks[i] do
          if ID = pid then
          begin
            pid := i; //pid store index of target block
            ppid := ParentID;
            break;
          end;
      for i := 0 to SyntaxBlocks.Count - 1 do
        with SyntaxBlocks[i] do
          if ID = aid then
          begin
            Index := pid;
            ParentId := ppid;
            break;
          end;
    end;
  UpdateBlocksTree(trvBlocks);
  CorrectBlockIndexes;
  ChooseBlock(aid);
end;

procedure TSyntaxEdForm.trvBlocksDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  n: TTreeNode;
begin
  with trvBlocks do
  begin
    n := GetNodeAt(X, Y);
    Accept := (Sender = Source) and (Selected <> Items[0]) and
      Assigned(n) and (n <> Selected) and not n.HasAsParent(Selected) and
      ((GetKeyState(VK_CONTROL) < 0) or (n <> Items[0]));
  end;
end;

procedure TSyntaxEdForm.btnAddExtClick(Sender: TObject);
{$IFDEF USEEXTENSIONS}
var
  s: string;
begin
  s := '';
  if PopupInputLine(TControl(Sender), s, SCaptionExt) then
    with lbxExts do
    begin
      ItemIndex := Items.Add(s);
      FCurScheme.Extensions.Assign(Items);
      lbxExtsClick(nil);
    end;
  {$ELSE}
begin
  {$ENDIF}
end;

procedure TSyntaxEdForm.btnRmvExtClick(Sender: TObject);
{$IFDEF USEEXTENSIONS}
var
  i: integer;
begin
  with lbxExts do
  begin
    i := ItemIndex;
    Items.Delete(ItemIndex);
    FCurScheme.Extensions.Assign(Items);
    if i >= Items.Count then
      i := Pred(Items.Count);
    ItemIndex := i;
    lbxExtsClick(nil);
  end;
  {$ELSE}
begin
  {$ENDIF}
end;

procedure TSyntaxEdForm.btnEditExtClick(Sender: TObject);
{$IFDEF USEEXTENSIONS}
var
  s: string;
begin
  with lbxExts do
  begin
    s := Items[ItemIndex];
    if PopupInputLine(TControl(Sender), s, SCaptionExt) then
    begin
      Items.Delete(ItemIndex);
      ItemIndex := Items.Add(s);
      FCurScheme.Extensions.Assign(Items);
      lbxExtsClick(nil);
    end;
  end;
  {$ELSE}
begin
  {$ENDIF}
end;

procedure TSyntaxEdForm.pgcSchemeElemsChange(Sender: TObject);
begin
  if pgcSchemeElems.ActivePage = tshSchemeBlocks then
  begin
    btnAddBlock.OnClick := btnAddBlockClick;
    btnRmvBlock.OnClick := btnRmvBlockClick;
    btnEditBlock.OnClick := btnEditBlockClick;
    trvBlocks.SetFocus;
    trvBlocksChange(nil, nil);
  end
  else
  begin
    btnAddBlock.OnClick := btnAddExtClick;
    btnRmvBlock.OnClick := btnRmvExtClick;
    btnEditBlock.OnClick := btnEditExtClick;
    lbxExts.SetFocus;
    lbxExtsClick(nil);
  end;
  btnCopyBlock.Enabled := pgcSchemeElems.ActivePage = tshSchemeBlocks;
end;

procedure TSyntaxEdForm.lbxExtsClick(Sender: TObject);
begin
  btnRmvBlock.Enabled := lbxExts.Enabled and (lbxExts.ItemIndex >= 0);
  btnEditBlock.Enabled := btnRmvBlock.Enabled;
end;

procedure TSyntaxEdForm.lbxExtsDblClick(Sender: TObject);
begin
  if btnEditBlock.Enabled then
    btnEditExtClick(Sender);
end;

procedure TSyntaxEdForm.lbxExtsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_INSERT:
      btnAddExtClick(Sender);
    VK_DELETE:
      if btnRmvBlock.Enabled then
        btnRmvExtClick(nil);
    VK_RETURN:
      if btnEditBlock.Enabled then
        btnEditExtClick(Sender);
  end;
  inherited;
end;

procedure TSyntaxEdForm.btnSaveAsClick(Sender: TObject);
begin
  with SaveDialog1 do
  begin
    Filter := SFilterScheme;
    DefaultExt := SExtScheme;
    if Execute then
    begin
      FFileName := FileName;
      btnSaveClick(Sender);
    end;
  end;
end;

procedure TSyntaxEdForm.bbnCustomColorClick(Sender: TObject);
begin
  with TDCColorCombo(TComponent(Sender).Tag), ColorDialog1 do
  begin
    Color := SelectedColor;
    if Execute then
      CustomColor := Color;
  end;
end;

procedure TSyntaxEdForm.btnCharSetClick(Sender: TObject);
var
  s: string;
begin
  with FCurBlock do
  begin
    if Sender = btnFirstChar then
      s := CharSetToString(FirstIdentChars) + SFirstCharAccent
    else
      s := CharSetToString(OtherIdentChars) + SOtherCharAccent;
    if PopupInputLine(TControl(Sender), s, SCaptionCharSet) then
      if Sender = btnFirstChar then
        FirstIdentChars := StringToCharSet(s)
      else
        OtherIdentChars := StringToCharSet(s);
  end;
end;

end.
