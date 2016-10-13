unit D_TxSrch;

{$Include l3Define.inc}

interface

{$IFDEF ARCHI}
 {$INCLUDE ArchiDefine.inc}
{$ELSE}
 {$DEFINE NotArchiProject}
{$ENDIF ARCHI}

uses
  SysUtils, 
  WinTypes,
  WinProcs, 
  Messages, 
  Classes, 
  Graphics, 
  Controls,

  ImgList, 
  Menus,
  Forms, 
  Dialogs, 
  StdCtrls, 
  Buttons, 
  ExtCtrls,
  ComCtrls,
  
  vtDialogs, 
  vtCtrls, 
  vtForm,
  vtSpeedButton, 

  DT_Const,
  DT_Types,

  D_TxSrch_Types,

  evTypes,
  evEditorWindow,
  evCustomEditor,
  evSearch,
  evIntf,
  evInternalInterfaces,
  {$IfDef evNeedDisp}
  evDisp,
  {$EndIf evNeedDisp}

  nevBase,
  nevTools,
  nevNavigation,

  {$IFNDEF NotArchiProject}
  arSearch,
  SrchWin,
  {$ENDIF}

  l3Types,
  l3Interfaces,
  l3InterfacedComponent,

  TB97Ctls,
  tb97GraphicControl,

  BottomBtnDlg
  ;

type
  TDialogMode = (sdmList, sdmEditor);

  TTextSearchRec = record
   Operation : Byte; (*0 = none, 1 = Find, 2 = Replace*)
   Searcher  : TevBaseSearcher;
   Replacer  : TevBaseReplacer;
   SFlags    : TevSearchOptionSet;                               
  end;{TTextSearchRec}

  TTextSearchDlg = class(TvtForm, InevConfirm)
    ScopeGroup: TRadioGroup;
    OriginGroup: TRadioGroup;
    OptionGroupBox: TGroupBox;
    cbCaseSens: TCheckBox;
    cbWordOnly: TCheckBox;
    STextComboBox: TvtComboBox;
    RTextComboBox: TvtComboBox;
    Panel12: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    cbNormalize: TCheckBox;
    sbSrchSpecType: TvtSpeedButton;
    sbReplaceSpecType: TvtSpeedButton;
    cbRegular: TCheckBox;
    cbWholePara: TCheckBox;
    cbAnyTail: TCheckBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    mnuRegular: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    mnuSpecials: TPopupMenu;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N23: TMenuItem;
    btnSymbols: TvtSpeedButton;
    btnSymbolsR: TvtSpeedButton;
    mnuSymbolsR: TPopupMenu;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N30: TMenuItem;
    lblOptionsDisp: TLabel;
    btnCancel: TButton;
    btnFind: TButton;
    btnReplaceAll: TButton;
    btnReplace: TButton;
    btnMore: TBitBtn;
    ilOpenClose: TImageList;
    N31: TMenuItem;
    N32: TMenuItem;
    procedure sbSrchSpecTypeClick(Sender: TObject);
    procedure STextComboBoxDropDown(Sender: TObject);
    procedure cbRegularClick(Sender: TObject);
    procedure cbCaseSensClick(Sender: TObject);
    procedure cbAnyTailClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure cbNormalizeClick(Sender: TObject);
    procedure cbWordOnlyClick(Sender: TObject);
    procedure mnuSymbolsClick(Sender: TObject);
    procedure mnuRegularsClick(Sender: TObject);
    procedure btnSymbolsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnMoreClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure InputsChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnReplaceClick(Sender: TObject);
    procedure btnReplaceAllClick(Sender: TObject);
    procedure cbWholeParaClick(Sender: TObject);
    procedure ScopeGroupClick(Sender: TObject);
    procedure STextComboBoxChange(Sender: TObject);
  private
    FSymbolsMenu: TPopupMenu;
    FDialogMode: TDialogMode;
    FInputIsParsed: Boolean;
    FInReplaceLoop: Boolean;
    FReplaceResult: Integer;
    f_OldSelectNotify: TNotifyEvent;
    f_OwnerToClose: HWND;
    fIsOptionVisible : boolean; 
    function ConvertTextWildcards(var aStr: string; out NeedRegexp: Boolean; ForReplacer: Boolean = False): Boolean;
    procedure DisplayOptions;
    procedure UpdateFindFlag(aFlag: Byte);
    procedure ParseInput;
  protected
    FEditor   : TevCustomEditor;
    FSrchMode : Byte;
    SType     : TtsSrchType;
    RType     : TtsSrchType;

    fReplaceAllowTypes : TtsSrchTypeSet;

    LastSrchRec : TTextSearchRec;
    SubID       : TSubID;

    fHLinkID     : Integer;

    {$IFNDEF NotArchiProject}
    f_SrchWin  : TSearchWin;
    {$ENDIF}

    fTextReplacer              : TevTextReplacer;
    fTextSearcher              : TevBMTextSearcher;
    fStyleSearcher             : TevStyleSearcher;
    fStyleReplacer             : TevStyleReplacer;
    fNormalWordSearcher        : TevMorphologySearcher;
    fRegularExpressionSearcher : TevRegExpMultipartSearcher;
    {$IFNDEF NotArchiProject}
    fHLinkSearcher             : TarHyperlinkSearcher;
    fHLinkReplacer             : TarHyperLinkReplacer;
    {$ENDIF}
    fSubReplacer               : TevSubReplacer;
    fRegExpReplacer            : TevRegExpReplacer;

    {$IFNDEF NotArchiProject}
    function  HLinkReplacerHyperlinkReplace(aSender: TObject; const aHLink: IevHyperlink): Boolean;
    function  HLinkSearcherHyperlinkSearch(aSender: TObject; const aHLink: IevHyperlink): Boolean;
    {$ENDIF}
    function  SubReplacerGetSubHandle(Sender       : TObject;
                                      const aBlock : InevRange): Integer;
    function  SubReplacerReplaceConfirm(Sender       : TObject;
                                        const aBlock : InevRange): Shortint;
    {$IFNDEF NotArchiProject}
    procedure evntFinishReplace(Sender: TObject; ReplaceCount: Longint);
    {$ENDIF}

    procedure SetIsOptionVisible(aValue : boolean);
    procedure SetSrchMode(Value : Byte);
    function  DropListGetItemImageIndex(Sender : TObject; Index : Longint) : Integer;
    function  GetItemImageIndex(aST : TtsSrchType) : Integer;
    procedure LoadList(aListID : Byte; aSrchType : TtsSrchType);
    procedure SaveList(aListID : Byte; aSrchType : TtsSrchType);
    procedure ShowNotFoundMsg;
    procedure ShowBadRegExpMsg;
    procedure Find;
    procedure SetSrchSpecType(SR : Byte; ST : TtsSrchType);
    procedure DoSwitchPages;
    {$IFNDEF NotArchiProject}
    function  GetItemFromList(anIndex: Longint): Il3CString;
    procedure FindInList(StartIndex: Longint);
    {$ENDIF}
    procedure FindEntry;
    function DefaultCloseAction: TCloseAction; override;
      function CheckStamp(const aGUID: TGUID): Boolean;
        {-}

    class function CheckDialog: TTextSearchDlg;
      {-}
  public
    property SrchMode : Byte Read FSrchMode Write SetSrchMode;
    class function Execute(aMode : TSearchDialogInitMode; aSrchType, aReplType : TtsSrchType; aCurEditor : TevCustomEditor; aReplaceAllowTypes : TtsSrchTypeSet): Boolean; overload;
    class function Execute(aMode : TSearchDialogInitMode; CurEditor : TevCustomEditor; aReplaceAllowTypes : TtsSrchTypeSet): Boolean; overload;
    {$IFNDEF NotArchiProject}
    class function Execute(aSrchWin: TSearchWin) : Boolean; overload;
    class procedure FindNext(aSrchWin: TSearchWin); overload;
    procedure ReplaceReferences(aCurEditor : TevCustomEditor; aSearchHLDocID: TDocID; aReplaceHLDocID: TDocID);
    {$ENDIF}
    class procedure FindNext(CurEditor : TevCustomEditor); overload;

    class procedure FindStyle(aCurEditor : TevCustomEditor; aStyleHandle : Integer);

    constructor Create(AOwner: TComponent); override;
      {-}
    procedure Cleanup; override;
      {-}
      function Get_Progress: InevProgress;
        {-}
    function ReplaceConfirm(const aBlock         : InevRange;
                            aAlienReplaceConfirm : TevReplaceConfirmEvent): ShortInt;
      {* - запрос на замену. Возвращаемое значение см. TevReplaceConfirmEvent. }
    function DoReplaceConfirm(Sender       : TObject;
                              const aBlock : InevRange): ShortInt;
      {* - запрос на замену. Возвращаемое значение см. TevReplaceConfirmEvent. }
    function Get_View: InevView;
      {-}
    function DeleteFoundRgn: Bool;
      {-}
    procedure ReplUpdate;
      {-}
    procedure InevConfirm.Update = ReplUpdate;
      {-}
    class procedure HideFindContext;
    class procedure SwitchActiveEditor(aNewEditor: TevCustomEditor);
      {-}
    class procedure ClientFormClosed(aForm: TCustomForm);
    class function IsInReplaceLoop: Boolean;
    {$IFDEF InsiderTest}
    class procedure ClearFindWindow;
    {$ENDIF InsiderTest}
    property IsOptionVisible : boolean read fIsOptionVisible write SetIsOptionVisible;
  end;

var
  g_TextSearchDlg : TTextSearchDlg;

implementation

uses
  StrUtils,

  l3String,
  l3Except,
  {$IFNDEF NotArchiProject}
  EditWin,
  DocIntf,
  {$ENDIF}
  l3Base, l3DatLst, l3Const,
  evConst, evEditor, evExcept,
  {$IFNDEF NotArchiProject}
  l3LongintList,
  evListBlock,
  {$EndIf NotArchiProject}
  D_TxSrch_Res,
  D_TxSrch_Intf,
  l3RegEx, vtlister,

  {$IFNDEF NotArchiProject}
  daTypes,

  DT_Doc,
  DT_Hyper,
  DT_Err,
  dt_LinkServ,
  {$EndIf  NotArchiProject}

  evFacadeSub,

  l3IniFile,
  IniShop,
  l3Chars,

  afwNavigation
  {$IFDEF InsiderTest}
  ,
  l3BatchService,
  l3ModalService
  {$ENDIF InsiderTest}
  ;

resourcestring
 SInvalidSpecialSymbol = 'Невозможно использовать такой спецсимвол: ';
 SBadRegExp = 'Регулярное выражение некорректно!';
 
const
 MaxNumofItemInHistory = 20;

 // количество поддерживаемых спецсимволов
 MaxSS = 10;
 // спецсимволы (значок после крышки ^)
 spsTab        = 't';
 spsAnySymbol  = '?';
 spsAnyDigit   = '#';
 spsAnyAlpha   = '$';
 spsReturn     = 'l';
 spsDash       = '=';
 spsMDash      = '+';
 spsNBSpace    = 's';
 spsLid        = '^';
 spsParagraph  = 'p';

 SpecialSymbols : array[1..MaxSS] of Char = (spsTab, spsAnySymbol, spsAnyDigit, spsAnyAlpha, spsReturn,
      spsDash, spsMDash, spsNBSpace, spsLid, spsParagraph);

{$R *.DFM}

constructor TTextSearchDlg.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);

 fTextReplacer              := TevTextReplacer.Create(Self);
 fTextSearcher              := TevBMTextSearcher.Create(Self);
 fStyleSearcher             := TevStyleSearcher.Create(Self);
 fStyleReplacer             := TevStyleReplacer.Create(Self);
 fNormalWordSearcher        := TevMorphologySearcher.Create(Self);
 fRegularExpressionSearcher := TevRegExpMultipartSearcher.Create(Self);
 fRegExpReplacer            := TevRegExpReplacer.Create(Self);

 {$IFNDEF NotArchiProject}
 fHLinkSearcher := TarHyperlinkSearcher.Create(Self);
 fHLinkSearcher.OnHyperlinkSearch := HLinkSearcherHyperlinkSearch;

 fHLinkReplacer := TarHyperLinkReplacer.Create(Self);
 fHLinkReplacer.OnHyperlinkReplace := HLinkReplacerHyperlinkReplace;
 fHLinkReplacer.OnFinishReplace  := evntFinishReplace;
 {$ENDIF}

 {$IFNDEF NotArchiProject}
 fSubReplacer := TarSubReplacer.Create(Self);
 fSubReplacer.OnFinishReplace  := evntFinishReplace;
 {$ELSE}
 fSubReplacer := TevSubReplacer.Create(Self);
 {$ENDIF}
 fSubReplacer.OnGetSubHandle   := SubReplacerGetSubHandle;
 fSubReplacer.OnReplaceConfirm := SubReplacerReplaceConfirm;

 LoadList(1, srtText);
 LoadList(2, srtText);
 UserConfig.Section     := TextSearchSectName;
 ScopeGroup  .ItemIndex := UserConfig.ReadParamIntDef ('ScopeGroup', 0);
 OriginGroup .ItemIndex := UserConfig.ReadParamIntDef ('OriginGroup', 0);

 cbCaseSens    .Checked := UserConfig.ReadParamBoolDef('cbCaseSens'  , False);
 cbWordOnly    .Checked := UserConfig.ReadParamBoolDef('cbWordOnly'  , False);
 cbNormalize   .Checked := UserConfig.ReadParamBoolDef('cbNormalize' , False);
 cbRegular     .Checked := UserConfig.ReadParamBoolDef('cbRegular'   , False);
 cbWholePara   .Checked := UserConfig.ReadParamBoolDef('cbWholePara' , False);
 cbAnyTail     .Checked := UserConfig.ReadParamBoolDef('cbAnyTail'   , False);

 sbSrchSpecType.Images := SrchRes.CommonImageList;
 sbReplaceSpecType.Images := SrchRes.CommonImageList;

 sbSrchSpecType.ImageIndex := GetItemImageIndex(srtText);
 sbReplaceSpecType.ImageIndex := GetItemImageIndex(srtText);

 LastSrchRec.Operation := 0;
 LastSrchRec.Searcher := fTextSearcher;
 LastSrchRec.Replacer := fTextReplacer;
 IsOptionVisible := true;
 DisplayOptions;
 FInReplaceLoop := False;
end;

procedure TTextSearchDlg.Cleanup;
begin
 if (g_TextSearchDlg = Self) then
 begin
  g_TextSearchDlg := nil;
  if not (csDestroying in Application.ComponentState) then
   l3System.Stack2Log('Убили TTextSearchDlg!');
 end;
 SaveList(1,SType);
 SaveList(2,RType);

 UserConfig.Section := TextSearchSectName;
 UserConfig.WriteParamInt('ScopeGroup' , ScopeGroup  .ItemIndex);
 UserConfig.WriteParamInt('OriginGroup', OriginGroup .ItemIndex);

 UserConfig.WriteParamBool('cbCaseSens'  , cbCaseSens  .Checked);
 UserConfig.WriteParamBool('cbWordOnly'  , cbWordOnly  .Checked);
 UserConfig.WriteParamBool('cbNormalize' , cbNormalize .Checked);
 UserConfig.WriteParamBool('cbRegular'   , cbRegular   .Checked);
 UserConfig.WriteParamBool('cbWholePara' , cbWholePara .Checked);
 UserConfig.WriteParamBool('cbAnyTail'   , cbAnyTail   .Checked);

 inherited;
end;

procedure TTextSearchDlg.LoadList(aListID : Byte; aSrchType : TtsSrchType);
begin
 if UserConfig <> nil then
 begin
  case aListID of
    1 :
     begin
      STextComboBox.Items.Clear;
      case aSrchType of
       srtText  :
        UserConfig.Section := FindSectName;
       {$IFNDEF NotArchiProject}
       srtHLink :
        UserConfig.Section := FindSectName+'_HLink';
       {$ENDIF}
       else //srtStyle, srtSub,
        Exit;
      end;
      UserConfig.ReadParamList(FindSectName, STextComboBox.Items);
     end;
    2 :
     begin
      RTextComboBox.Items.Clear;
      case aSrchType of
       srtText  :
        UserConfig.Section := ReplaceSectName;
       {$IFNDEF NotArchiProject}
        srtHLink :
         UserConfig.Section := ReplaceSectName+'_HLink';
       {$ENDIF}
       else //srtStyle, srtSub,
        Exit;
      end;
      UserConfig.ReadParamList(ReplaceSectName, RTextComboBox.Items);
     end;
   end;
  end;
end;

procedure TTextSearchDlg.SaveList(aListID : Byte; aSrchType : TtsSrchType);
begin
 if UserConfig <> nil then
 begin
  case aListID of
   1 :
    begin
     case aSrchType of
      srtText  :
        UserConfig.Section := FindSectName;
      {$IFNDEF NotArchiProject}
       srtHLink :
         UserConfig.Section := FindSectName + '_HLink';
      {$ENDIF}
      else //srtStyle, srtSub,
       Exit;
      end;
     UserConfig.WriteParamList(FindSectName, STextComboBox.Items, MaxNumofItemInHistory);
    end;
   2 :
    begin
     case aSrchType of
      srtText  :
       UserConfig.Section := ReplaceSectName;
      {$IFNDEF NotArchiProject}
       srtHLink :
        UserConfig.Section := ReplaceSectName+'_HLink';
      {$ENDIF}
      else //srtStyle, srtSub,
       Exit;
     end;
     UserConfig.WriteParamList(ReplaceSectName, RTextComboBox.Items, MaxNumofItemInHistory);
    end;
  end;
 end;
end;

function TranslateForAnyTail(const aSrchText : string; AlreadyRegexp: Boolean = False): string;
var
 lStrPos : Integer;
 lAddLog : Boolean;
begin
 Result := l3DeleteDoubleSpace(Trim(aSrchText));
 if not AlreadyRegexp then
  Result := ConvertStrToRegular(Result);
 lStrPos := Length(Result);
 lAddLog := True;
 while lStrPos > 0 do
  begin
   case Result[lStrPos] of
    '!' : begin
           System.Delete(Result, lStrPos, 1);
           lAddLog := False;
          end;
    ' ' : begin
           System.Delete(Result, lStrPos, 1);
           If not lAddLog then
            System.Insert('\s+', Result, lStrPos);
           lAddLog := True;
          end;
    else
     begin
      if lAddLog then 
       System.Insert('\w*' {'[[:alpha:]]*'}, Result, Succ(lStrPos));
      lAddLog := False;
     end;
   end;   
   Dec(lStrPos);
  end;
 Result := '>' + Result;
end;

class function TTextSearchDlg.CheckDialog: TTextSearchDlg;
  {-}
begin
 if (g_TextSearchDlg = nil) then
  g_TextSearchDlg := Create(Application);
 Result := g_TextSearchDlg;
end;

class function TTextSearchDlg.Execute(aMode : TSearchDialogInitMode; aSrchType, aReplType : TtsSrchType;
                                      aCurEditor : TevCustomEditor; aReplaceAllowTypes : TtsSrchTypeSet): Boolean;
begin
 with CheckDialog do
 begin
  fEditor := aCurEditor;
  fReplaceAllowTypes := aReplaceAllowTypes;

  SetSrchSpecType(0, aSrchType);
  SetSrchSpecType(1, aReplType);

  Result := Execute(aMode, aCurEditor, aReplaceAllowTypes);
 end;//CheckDialog
end;

class function TTextSearchDlg.Execute(aMode : TSearchDialogInitMode; CurEditor : TevCustomEditor; aReplaceAllowTypes : TtsSrchTypeSet): Boolean;
var
 l_Dialog : TTextSearchDlg;
 lSrchStr : string;
begin
 l_Dialog := CheckDialog;
 with l_Dialog do
 begin
  try
   fReplaceAllowTypes := aReplaceAllowTypes;

   if aMode <> sdiSearchOnly then
    SetSrchSpecType(1, RType);

   TabSheet2.TabVisible := aMode <> sdiSearchOnly;
   if aMode = sdiReplace then
    PageControl1.ActivePageIndex := 1
   else
    PageControl1.ActivePageIndex := 0;
   PageControl1Change(l_Dialog);
  except
  end;

  fEditor := CurEditor;
  sbSrchSpecType.Enabled := True;
  // Вставляет из текста слово на котором курсор стоит
  with fEditor.Range do
   if ContainsOneLeaf then
    lSrchStr := AsString
   else
    lSrchStr := '';

  if (lSrchStr = '') or (SType <> srtText) then
   STextComboBox.ItemIndex := 0
  else
  begin
   STextComboBox.ItemIndex := 0;
   //STextComboBox.ItemIndex := -1;
   STextComboBox.Text := lSrchStr;
  end;

  if (SrchMode = 1) then
  begin
   if LastSrchRec.Replacer <> nil then
    RTextComboBox.ItemIndex := 0
    //RTextComboBox.Text := LastSrchRec.Replacer.DefaultText
   else
    RTextComboBox.Text := '';
  end;

  ActiveControl := STextComboBox;
  STextComboBoxChange(nil);

  FDialogMode := sdmEditor;
  Show;
  Result := True;
  {$IFDEF InsiderTest}
   Tl3BatchService.Instance.ExecuteCurrentModalWorker(se_meInLoop);
  {$ENDIF InsiderTest}
 end;//with CheckDialog
end;

{$IFNDEF NotArchiProject}
class function TTextSearchDlg.Execute(aSrchWin: TSearchWin) : Boolean;
var
 lSrchStr : string;
begin
 with CheckDialog do
 begin
  sbSrchSpecType.Enabled:= False;
  SetSrchSpecType(0, srtText);
  f_SrchWin:= aSrchWin;

  lSrchStr := '';

  if (lSrchStr = '') then 
   STextComboBox.Text := LastSrchRec.Searcher.DefaultText
  else 
   STextComboBox.Text := lSrchStr;

  ActiveControl := STextComboBox;

 {=============}

  TabSheet2.TabVisible := False;
  FDialogMode := sdmList;
  Show;
  Result := True;
  {$IFDEF InsiderTest}
   Tl3BatchService.Instance.ExecuteCurrentModalWorker(se_meInLoop);
  {$ENDIF InsiderTest}
 end;//with CheckDialog
end;
{$ENDIF}

procedure TTextSearchDlg.DoSwitchPages;
begin
 with PageControl1 do
  begin
   RTextComboBox.Visible     := ActivePageIndex = 1;
   sbReplaceSpecType.Visible := ActivePageIndex = 1;
   btnSymbolsR.Visible       := ActivePageIndex = 1;
   btnReplace.Visible        := ActivePageIndex = 1;
   btnReplaceAll.Visible     := ActivePageIndex = 1;
   Label2.Visible            := ActivePageIndex = 1;
   cbWholePara .Visible      := (ActivePageIndex = 1) and (RType = srtStyle);
   btnFind.Default           := ActivePageIndex = 0;
   btnReplace.Default        := ActivePageIndex = 1;
  end;
end;

procedure TTextSearchDlg.PageControl1Change(Sender: TObject);
begin
 DoSwitchPages;
 with PageControl1 do
 begin
  fSrchMode := ActivePageIndex;
  ActiveControl := STextComboBox;
 end;
 InputsChange(nil);
end;

procedure TTextSearchDlg.SetSrchMode(Value : Byte);
begin
 fSrchMode := Value;
 PageControl1.ActivePageIndex := Value;
 DoSwitchPages;
end;

function  TTextSearchDlg.DropListGetItemImageIndex(Sender : TObject; Index : Longint) : Integer;
begin
 if Index < 0 then
  Result := -1
 else
  Result := GetItemImageIndex(TtsSrchType(TvtDStringlister(Sender).Items.DataInt[Index]));
end;

function  TTextSearchDlg.GetItemImageIndex(aST : TtsSrchType) : Integer;
begin
 case aST of
  srtText  : Result := picSrchText;
  srtStyle : Result := picSrchStyle;
  srtSub   : Result := picSrchAnchor;
  {$IFNDEF NotArchiProject}
   srtHLink : Result := picSrchHLink;
  {$ENDIF}
 end;
end;

procedure TTextSearchDlg.sbSrchSpecTypeClick(Sender: TObject);
var
 l_Type : TtsSrchType;
 l_Res  : Longint;
 lSTRes : TtsSrchType;
 SR     : Byte;
begin
 try
  if Sender = sbSrchSpecType then
   STextComboBox.SetFocus
  else
   RTextComboBox.SetFocus;
 except
 end;

 with TvtPopupList.Create(TComponent(Sender), TvtDStringLister) do
 try
  AdjustCorner := acBottomRight;
  Lister.Images := SrchRes.CommonImageList;
  Lister.OnGetItemImageIndex := DropListGetItemImageIndex;
  with (Lister as TvtDStringLister).Items do
  begin
   DataSize := SizeOf(TtsSrchType);
   for l_Type := Low(TtsSrchType) to High(TtsSrchType) do
   begin
   {$IFNDEF NotArchiProject}
    if (Sender = sbSrchSpecType) and
       (l_Type = srtSub) then
     Continue; // поиск по номеру Sub'a в Архивариусе не поддерживается

    if (Sender = sbReplaceSpecType) and
       (fReplaceAllowTypes <> []) and
       not (l_Type in fReplaceAllowTypes) then
     Continue; //фильтр по допустимым типам поисков

   {$ENDIF}
    AddStr(cSrchTypeNames[l_Type], @l_Type);
   end;
  end;
  if Sender = sbSrchSpecType then
   Lister.Current := Byte(SType)
  else
   Lister.Current := Byte(RType);

  l_Res := Execute;
  if l_Res < 0 then Exit;
  lSTRes := TtsSrchType((Lister as TvtDStringLister).Items.DataInt[l_Res]);
  if Sender = sbReplaceSpecType then
   SR := 1
  else
   SR := 0;
  SetSrchSpecType(SR, lSTRes);
 finally
  Free;
 end;
 InputsChange(nil);
end;

procedure TTextSearchDlg.SetSrchSpecType(SR : Byte; ST : TtsSrchType);

 procedure SetSrchOptionEnabled(Value : Boolean);
 begin
  cbCaseSens.Enabled := Value;
  cbWordOnly.Enabled := Value;
  cbNormalize.Enabled := Value;
  cbRegular.Enabled := Value;
  cbAnyTail.Enabled := Value;
  btnSymbols.Enabled := Value;
 end;

 procedure CorrectSTReplace;
 var
  lST : TtsSrchType;
 begin
  if (fReplaceAllowTypes <> []) and
     not (ST in fReplaceAllowTypes) then
  for lST := Low(TtsSrchType) to High(TtsSrchType) do
   if lST in fReplaceAllowTypes then
   begin
    ST := lST;
    Exit;
   end;
 end;

begin
 if SR = 0 then
 begin
  if SType = ST then Exit;
  SaveList(1,SType);
  //SNeedLoad := True;
  SType := ST;
  LoadList(1,SType);
  SetSrchOptionEnabled(SType = srtText);
  if (SType = srtText) or (SType = srtSub)
  {$IFNDEF NotArchiProject}
   or (SType = srtHLink)
  {$ENDIF}
   then
    begin
     STextComboBox.Style := csDropDown;
     STextComboBox.ItemIndex := 0;
    end
   else
    begin
     STextComboBox.Style := csDropDownList;
     STextComboBox.ItemIndex := -1;
    end;

  {$IFNDEF NotArchiProject}
  if (SType = srtHLink) then
   with TDocEditorWindow(GetParentForm(fEditor)) do
    fHLinkSearcher.CurrentDoc := DocAddr(DocFamily, DocID);
  {$ENDIF}

  sbSrchSpecType.ImageIndex := GetItemImageIndex(ST);
  //sbSrchSpecType.Glyph := GetDocBMP(GetItemImageIndex(ST));
 end
  else {Replace}
   begin
    CorrectSTReplace;
    if RType = ST then Exit;
    SaveList(2,RType);
    RType := ST;
    LoadList(2,RType);
    cbWholePara.Visible := (RType = srtStyle);
    btnSymbolsR.Enabled := (RType = srtText);
    case RType of
     srtText :  begin
                 RTextComboBox.Style := csDropDown;
                 RTextComboBox.ItemIndex := 0;
                end;

     srtStyle : begin
                 RTextComboBox.Style := csDropDownList;
                 RTextComboBox.ItemIndex  := -1;
                end;

     {$IFNDEF NotArchiProject}
     srtHLink : begin
                 RTextComboBox.Style := csDropDown;
                 RTextComboBox.ItemIndex := 0;

                  with TDocEditorWindow(GetParentForm(fEditor)) do
                   fHLinkReplacer.CurrentDoc := DocAddr(DocFamily, DocID);
                end;
     {$ENDIF}

      srtSub  : begin
                 RTextComboBox.Style := csDropDown;
                 RTextComboBox.Text  := ''; //SubReplacer.DefaultText;
                end;
    end;
    sbReplaceSpecType.ImageIndex := GetItemImageIndex(ST);
 end;
 DisplayOptions;
end;

procedure TTextSearchDlg.STextComboBoxDropDown(Sender: TObject);
begin
 if ((Sender = STextComboBox) and (SType = srtStyle)) or
    ((Sender = RTextComboBox) and (RType = srtStyle)) then
 begin
  if FEditor = nil then
   TComboBox(Sender).Items.Clear
  else
   TComboBox(Sender).Items.Assign(FEditor.TextPara.Style.Styles.Items);
 end;
end;

procedure TTextSearchDlg.ShowNotFoundMsg;
begin
 vtMessageDlg(l3CStr(LastSrchRec.Searcher.NotFoundMessage), mtWarning, [mbOK], 0 {HelpCtx});
end;

procedure TTextSearchDlg.Find;
begin
 try
  (FEditor As TevEditor).Find(LastSrchRec.Searcher, LastSrchRec.Replacer, LastSrchRec.SFlags);
 except
  on EevSearchFailed do ShowNotFoundMsg;
 end;{try..finally}
end;

class procedure TTextSearchDlg.FindNext(CurEditor : TevCustomEditor);
begin
 with CheckDialog do
 begin
  if (LastSrchRec.Operation >= 1) then
   begin
    FEditor := CurEditor;
    Exclude(LastSrchRec.SFlags, ev_soGlobal);
    Find;
   end;{LastSrchRec.Operation >= 1}
 end;//with CheckDialog
end;

{$IFNDEF NotArchiProject}
class procedure TTextSearchDlg.FindNext(aSrchWin: TSearchWin);
begin
 with CheckDialog do
 begin
  if (LastSrchRec.Operation >= 1) then
   begin
    f_SrchWin:= aSrchWin;
    Exclude(LastSrchRec.SFlags, ev_soGlobal);
    FindInList(f_SrchWin.DocList.SrchResultLister.Current+1);
   end;{LastSrchRec.Operation >= 1}
 end;//with CheckDialog
end;
{$ENDIF}

class procedure TTextSearchDlg.FindStyle(aCurEditor : TevCustomEditor; aStyleHandle : Integer);
begin
 with CheckDialog do
 begin
  fEditor := aCurEditor;

  fStyleSearcher.Layer := l3NilLong;

  LastSrchRec.Searcher := fStyleSearcher;
  LastSrchRec.Operation := 0;

  LastSrchRec.SFlags := [ev_soFind {, ev_soGlobal, ev_soSelText}];

  fStyleSearcher.Handle := aStyleHandle;

  Find;
 end;//with CheckDialog
end;

class procedure TTextSearchDlg.HideFindContext;
  {-}
begin
 if (g_TextSearchDlg <> nil) AND g_TextSearchDlg.Showing then
  g_TextSearchDlg.Close;
end;

{$IFNDEF NotArchiProject}
procedure TTextSearchDlg.ReplaceReferences(aCurEditor : TevCustomEditor; aSearchHLDocID: TDocID; aReplaceHLDocID: TDocID);
begin
 fEditor := aCurEditor;

 fHLinkSearcher.SearchAddr := DestHLinkRec(aSearchHLDocID, -1);
 LastSrchRec.Searcher := fHLinkSearcher;

 fHLinkReplacer.ReplaceAddr := DestHLinkRec(aReplaceHLDocID, -1);
 LastSrchRec.Replacer := fHLinkReplacer;

 LastSrchRec.SFlags := [ev_soGlobal, ev_soReplace, ev_soReplaceAll];

 LastSrchRec.Searcher.Options := LastSrchRec.SFlags;
 LastSrchRec.Replacer.Options := LastSrchRec.SFlags;

 try
  (FEditor As TevEditor).Find(LastSrchRec.Searcher, LastSrchRec.Replacer, LastSrchRec.SFlags);
 except
  on EevSearchFailed do;
 end;
end;
{$ENDIF}

procedure TTextSearchDlg.cbRegularClick(Sender: TObject);
begin
 if cbRegular.Checked then
 begin
  cbNormalize.Checked := False;
  cbWordOnly.Checked := False;
  cbAnyTail.Checked := False;
  FSymbolsMenu := mnuRegular;
 end
 else
  FSymbolsMenu := mnuSpecials;
 InputsChange(nil);
 DisplayOptions;
end;

procedure TTextSearchDlg.cbWordOnlyClick(Sender: TObject);
begin
 if cbWordOnly.Checked then
 begin
  cbNormalize.Checked := False;
  cbAnyTail.Checked := False;
  cbRegular.Checked := False;
 end;
 InputsChange(nil);
 DisplayOptions;
end;

procedure TTextSearchDlg.cbNormalizeClick(Sender: TObject);
begin
 if cbNormalize.Checked then
 begin
   cbCaseSens.Checked := False;
   cbWordOnly.Checked := False;
   cbAnyTail.Checked := False;
   cbRegular.Checked := False;
 end;
 InputsChange(nil);
 DisplayOptions;
end;

procedure TTextSearchDlg.cbAnyTailClick(Sender: TObject);
begin
 if cbAnyTail.Checked then
 begin
  cbNormalize.Checked := False;
  cbWordOnly.Checked := False;
  cbRegular.Checked := False;
 end;
 InputsChange(nil);
 DisplayOptions;
end;

procedure TTextSearchDlg.cbCaseSensClick(Sender: TObject);
begin
 if cbCaseSens.Checked then
  cbNormalize.Checked := False;
 InputsChange(nil);
 DisplayOptions;
end;

{$IFNDEF NotArchiProject}
procedure TTextSearchDlg.evntFinishReplace(Sender: TObject; ReplaceCount: Longint);
var
 Frm : TCustomForm;
begin
 Frm := GetParentForm(FEditor);
 If Frm is TDocEditorWindow
  then TDocEditorWindow(Frm).evntFinishReplace(Sender, ReplaceCount);
end;
{$ENDIF}

function TTextSearchDlg.SubReplacerReplaceConfirm(Sender       : TObject;
                                                  const aBlock : InevRange): Shortint;
var
 l_Form : TCustomForm;
 l_Search: ISearchDlgOperations;
begin
 Result := 0;
 l_Form := GetParentForm(FEditor);
 if Supports(l_Form, ISearchDlgOperations, l_Search) then
 try
  Result := l_Search.SubReplaceFunc(aBlock, LastSrchRec.Replacer.Text, True{aWithConfirm});
 finally
  l_Search := nil;
 end;
end;

function TTextSearchDlg.SubReplacerGetSubHandle(Sender       : TObject;
                                                const aBlock : InevRange): Integer;
var
 l_Form   : TCustomForm;
 l_Search : ISearchDlgOperations;
begin
 Result := 0; //Шуре id не давать!! Ставлю сам
 if (ev_soConfirm in LastSrchRec.Replacer.Options) then Exit;
 l_Form := GetParentForm(FEditor);
 if Supports(l_Form, ISearchDlgOperations, l_Search) then
 try
  l_Search.SubReplaceFunc(aBlock, LastSrchRec.Replacer.Text, False{aWithConfirm});
 finally
  l_Search := nil;
 end;
end;

{$IFNDEF NotArchiProject}
function TTextSearchDlg.HLinkSearcherHyperlinkSearch(aSender: TObject; const aHLink: IevHyperlink): Boolean;
var
 lCurAddr : TevAddress;
 I        : Integer;
 lWrongHlinkList : Tl3LongintList;
begin
 Result := False;
 if (aHLink.AddressList.Count = 0) then Exit;

 if (aSender as TarHyperLinkSearcher).SearchAddr.Doc = Pred(MaxInt) //поиск "битых" ссылок
  then
   begin
    lWrongHlinkList := TDocEditorWindow(GetParentForm(fEditor)).CurDocument.GetWrongHlinkList;
    If (lWrongHlinkList = nil) or (lWrongHlinkList.Count = 0) then Exit;
    for I := 0 to Pred(lWrongHlinkList.Count) do
     If aHLink.ID = lWrongHlinkList.Items[I] then
      begin
       Result := True;
       Exit;
      end;
   end
  else
   if (aSender as TarHyperLinkSearcher).SearchAddr.Doc = MaxInt //поиск по HLinkID
    then
     Result := aHLink.ID = (aSender as TarHyperLinkSearcher).SearchAddr.Sub
    else
     for I := 0 to Pred(aHLink.AddressList.Count) do
      begin
       lCurAddr := aHLink.AddressList[I];
       If (((aSender as TarHyperLinkSearcher).SearchAddr.Doc = lCurAddr{$IfDef XE4}.rTafwAddress{$EndIf}.DocID) or
            ((aSender as TarHyperLinkSearcher).SearchAddr.Doc < 0)) and
          (((aSender as TarHyperLinkSearcher).SearchAddr.Sub = lCurAddr{$IfDef XE4}.rTafwAddress{$EndIf}.SubID) or
            ((aSender as TarHyperLinkSearcher).SearchAddr.Sub < 0))
        then
         begin
          Result := True;
          Break;
         end;
      end;
end;

function TTextSearchDlg.HLinkReplacerHyperlinkReplace(aSender: TObject;
                                           const aHLink: IevHyperlink): Boolean;
var
 lCurAddr : TevAddress;
 lSrchAddr : TDestHLinkRec;
 lNewAddr : TevAddress;
 //SL          : Tl3StringDataList;
 I        : Integer;
 lDocID   : TDocID;
 lDocFamily : TdaFamilyID;
 lSaveReadOnly : boolean;
begin
 Result := False;

 with TDocEditorWindow(GetParentForm(fEditor)) do
 begin
  lDocID     := DocID;
  lDocFamily := DocFamily;
 end;

 lSaveReadOnly := fEditor.ReadOnly;
 try
  fEditor.ReadOnly := False;

  if Not aHLink.Exists or (aHLink.AddressList.Count = 0) or
     not (LastSrchRec.Searcher is TarHyperLinkSearcher)  or
     ((aSender as TarHyperLinkReplacer).ReplaceAddr.Doc = MaxInt) then //поиск по HLinkID
  begin
   if ((aSender as TarHyperLinkReplacer).ReplaceAddr.Doc < 0) then
    lNewAddr{$IfDef XE4}.rTafwAddress{$EndIf}.DocID := lDocID
   else
    lNewAddr{$IfDef XE4}.rTafwAddress{$EndIf}.DocID := (aSender as TarHyperLinkReplacer).ReplaceAddr.Doc;

   if ((aSender as TarHyperLinkReplacer).ReplaceAddr.Sub < 0) then
    lNewAddr{$IfDef XE4}.rTafwAddress{$EndIf}.SubID := 0
   else
    lNewAddr{$IfDef XE4}.rTafwAddress{$EndIf}.SubID := (aSender as TarHyperLinkReplacer).ReplaceAddr.Sub;


   if not LinkServer(lDocFamily).SubTbl.CheckHyperLink(lNewAddr{$IfDef XE4}.rTafwAddress{$EndIf}.DocID, lNewAddr{$IfDef XE4}.rTafwAddress{$EndIf}.SubID) {Проверка на валидность lNewAddr} then
   begin
    vtMessageDlg(l3Fmt(sidNotValidHyperAddress,[lNewAddr{$IfDef XE4}.rTafwAddress{$EndIf}.DocID, lNewAddr{$IfDef XE4}.rTafwAddress{$EndIf}.SubID]), mtError);
    Exit;
   end;

   if not aHLink.Exists then aHLink.Insert;
   aHLink.AddressList.Add(lNewAddr);
  end
  else //поиск по адресу
  begin
   I := 0;
   While I < aHLink.AddressList.Count do
   begin
    lCurAddr := aHLink.AddressList[I];

    lSrchAddr := (LastSrchRec.Searcher as TarHyperLinkSearcher).SearchAddr;

    if ((lSrchAddr.Doc = lCurAddr{$IfDef XE4}.rTafwAddress{$EndIf}.DocID) or (lSrchAddr.Doc < 0)) and
       ((lSrchAddr.Sub = lCurAddr{$IfDef XE4}.rTafwAddress{$EndIf}.SubID) or (lSrchAddr.Sub < 0)) then
    begin
     if (lSrchAddr.Doc < 0) then
      lNewAddr{$IfDef XE4}.rTafwAddress{$EndIf}.DocID := lCurAddr{$IfDef XE4}.rTafwAddress{$EndIf}.DocID
     else
      lNewAddr{$IfDef XE4}.rTafwAddress{$EndIf}.DocID := (aSender as TarHyperLinkReplacer).ReplaceAddr.Doc;

     if (lSrchAddr.Sub < 0) then
      lNewAddr{$IfDef XE4}.rTafwAddress{$EndIf}.SubID := lCurAddr{$IfDef XE4}.rTafwAddress{$EndIf}.SubID
     else
      lNewAddr{$IfDef XE4}.rTafwAddress{$EndIf}.SubID := (aSender as TarHyperLinkReplacer).ReplaceAddr.Sub;

     if not ((aSender as TarHyperLinkReplacer).AbsentDoc or
            LinkServer(lDocFamily).SubTbl.CheckHyperLink(lNewAddr{$IfDef XE4}.rTafwAddress{$EndIf}.DocID, lNewAddr{$IfDef XE4}.rTafwAddress{$EndIf}.SubID)) then
     {Проверка на валидность lNewAddr}
     begin
      vtMessageDlg(l3Fmt(sidNotValidHyperAddress,[lNewAddr{$IfDef XE4}.rTafwAddress{$EndIf}.DocID, lNewAddr{$IfDef XE4}.rTafwAddress{$EndIf}.SubID]), mtError);
      Inc(I);
      Continue;
     end;

     try
      aHLink.AddressList[I] := lNewAddr;
     except
      on E : El3DuplicateItem do
      begin
       if vtMessageDlg(l3Fmt(sidDoubletHyperAddress +^M+ sidQstDelDoublet,[lNewAddr{$IfDef XE4}.rTafwAddress{$EndIf}.DocID, lNewAddr{$IfDef XE4}.rTafwAddress{$EndIf}.SubID]),
          mtConfirmation, [mbYes, mbNo]) = mrYes then
        aHLink.AddressList.Delete(lCurAddr);
      end;
      on E : Exception do
       vtMessageDlg(E);
     end;
    end;
    Inc(I);
   end;
  end;
 finally
  fEditor.ReadOnly := lSaveReadOnly;
 end;

end;

procedure TTextSearchDlg.FindInList(StartIndex: Longint);
var
  l_Pos: Longint;
begin
  try
    l_Pos:= evSearchList(GetItemFromList,
                      f_SrchWin.DocList.SrchResultLister.Total,
                      LastSrchRec.Searcher,
                      StartIndex + 1);
    f_SrchWin.DocList.SrchResultLister.Current:= l_Pos - 1;
  except
    on EevSearchFailed do ;
  end;
end;

function TTextSearchDlg.GetItemFromList(anIndex: Longint): Il3CString;
begin
  f_SrchWin.DocList.GetStrItem(anIndex, Result);
end;

{$ENDIF}

procedure TTextSearchDlg.mnuSymbolsClick(Sender: TObject);
var
 lItem: Integer;
 S,L: Integer;
 Combo: TvtComboBox;
begin
  if TMenuItem(Sender).GetParentMenu = mnuSymbolsR then
   Combo := RTextComboBox
  else
   Combo := STextComboBox;
  S := Combo.SelStart;
  L := Combo.SelLength;
  ActiveControl := Combo;
  Combo.SelStart := S;
  Combo.SelLength := L;
  lItem := TMenuItem(Sender).Tag;
  if lItem in [1..MaxSS] then
   Combo.SelText := '^'+SpecialSymbols[lItem];
end;

procedure TTextSearchDlg.mnuRegularsClick(Sender: TObject);
var
 lItem: Integer;
 S,L: Integer;       
begin
  S := STextComboBox.SelStart;
  L := STextComboBox.SelLength;
  ActiveControl := STextComboBox;
  STextComboBox.SelStart := S;
  STextComboBox.SelLength := L;
  lItem := TMenuItem(Sender).Tag;
  case lItem of
   1: STextComboBox.SelText := '.';
   2: STextComboBox.SelText := '?';
   3: STextComboBox.SelText := '[-]';
   4: STextComboBox.SelText := '[^-]';
   5: STextComboBox.SelText := '^';
   6: STextComboBox.SelText := '$';
   7: STextComboBox.SelText := '()';
   8: STextComboBox.SelText := '+';
   9: STextComboBox.SelText := '*';
   10: STextComboBox.SelText := '\t';
   11: STextComboBox.SelText := '\l';
   12: STextComboBox.SelText := '\w';
   13: STextComboBox.SelText := '\_';
   14: STextComboBox.SelText := '\d';
   15: STextComboBox.SelText := '>';
   16: STextComboBox.SelText := '<';
  end;
end;

procedure TTextSearchDlg.btnSymbolsClick(Sender: TObject);
var
 P: TPoint;
begin
 P.X := 0;
 P.Y := btnSymbols.Top + btnSymbols.Height;
 P := btnSymbols.ClientToScreen(P);
 if Sender = btnSymbolsR then
  mnuSymbolsR.Popup(P.X, P.Y)
 else
  FSymbolsMenu.Popup(P.X, P.Y);
end;

function TTextSearchDlg.ConvertTextWildcards(var aStr: string; out NeedRegexp: Boolean; ForReplacer: Boolean = False):
    Boolean;
var
 lIdx: Integer;
 SRegexp: string;

 procedure ReplaceSubstr(var AStr: string; Start, Length: Integer; Substr: string);
 begin
  if NeedRegexp then
  begin
   SRegexp := SRegexp + ConvertStrToRegular(System.Copy(AStr, 1, Start-1))+Substr;
   Delete(AStr, 1, Start+Length-1);
   lIdx := 1;
  end
  else
  begin
   Delete(AStr, Start, Length);
   Insert(Substr, AStr, Start);
   Inc(lIdx, System.Length(Substr));
  end;
 end;

begin
 Result := False;
 NeedRegexp := False;
 SRegexp := '';
 lIdx := Pos('^', aStr);
 while lIdx > 0 do
 begin
  if lIdx = Length(aStr) then //последний символ "крышка" так ее и оставим
   Break               
  else
  case aStr[lIdx+1] of
   spsTab: ReplaceSubstr(aStr, lIdx, 2, cc_Tab);
   spsAnySymbol:
    if ForReplacer then
     Exit
    else
    begin
     NeedRegExp := True;
     ReplaceSubstr(aStr, lIdx, 2, '.');
    end;
   spsAnyDigit:
    if ForReplacer then
     Exit
    else
    begin
     NeedRegExp := True;
     ReplaceSubstr(aStr, lIdx, 2, '\d');
    end;
   spsAnyAlpha:
    if ForReplacer then
     Exit
    else
    begin
     NeedRegExp := True;
     ReplaceSubstr(aStr, lIdx, 2, '[A-Za-zА-Яа-я]');
    end;
   spsReturn: ReplaceSubstr(aStr, lIdx, 2, cc_SoftEnter);
   spsDash: ReplaceSubstr(aStr, lIdx, 2, #$96);
   spsMDash: ReplaceSubstr(aStr, lIdx, 2, #$97);
   spsNBSpace: ReplaceSubstr(aStr, lIdx, 2, cc_SoftSpace);
   spsLid: ReplaceSubstr(aStr, lIdx, 2, '^');
   spsParagraph:
    if ForReplacer then
     ReplaceSubstr(aStr, lIdx, 2, #13#10)
    else
    begin
     NeedRegExp := True;
     ReplaceSubstr(aStr, lIdx, 2, '$');
    end;
  // после "крышки" не спецсимвол, так и оставим, смысл заремленного ниже куска мне не понятен (В.)
  //else
   // после "крышки" не спецсимвол, так и оставим
   //aStr := '^'+aStr[lIdx+1];
   //Exit;
  end;
  lIdx := Pos('^', aStr);
   //lIdx := PosEx('^', aStr, lIdx+1);
 end;
 if NeedRegexp then
  aStr := SRegexp + ConvertStrToRegular(aStr);
 Result := True;
end;

procedure TTextSearchDlg.FormCreate(Sender: TObject);
begin
 FSymbolsMenu := mnuSpecials;
 lblOptionsDisp.Caption := '';
 IsOptionVisible := false;
end;

procedure TTextSearchDlg.btnMoreClick(Sender: TObject);
begin
 IsOptionVisible := not IsOptionVisible;
end;

procedure TTextSearchDlg.FormHide(Sender: TObject);
begin
 if FDialogMode = sdmList then
  TabSheet2.TabVisible := True;
 InputsChange(nil);
end;

procedure TTextSearchDlg.ParseInput;
var
 l_TextToSearch   : string;
 l_IsWeNeedRegexp : Boolean;

 function lp_InitSeacher4TextFind: Boolean;
 begin
  Result := True;
  if cbNormalize.Checked then
   LastSrchRec.Searcher := fNormalWordSearcher
  else
   if cbRegular.Checked then
    LastSrchRec.Searcher := fRegularExpressionSearcher
   else
   begin
    try
     if not ConvertTextWildcards(l_TextToSearch, l_IsWeNeedRegexp) then
      raise Exception.Create(SInvalidSpecialSymbol + l_TextToSearch);
     if l_IsWeNeedRegexp or cbAnyTail.Checked then
      LastSrchRec.Searcher := fRegularExpressionSearcher
     else
      LastSrchRec.Searcher := fTextSearcher;
    except
     on E : Exception do
     begin
      vtMessageDlg(E);
      ModalResult := mrNone;
      ActiveControl := STextComboBox;
      Result := False;
     end;
    end;
   end;
 end;

 function lp_InitTextProp: Boolean;
 begin
  Result := True;
  try
   if cbAnyTail.Checked and (SType = srtText) then
    LastSrchRec.Searcher.Text := TranslateForAnyTail(l_TextToSearch, l_IsWeNeedRegexp)
   else
    LastSrchRec.Searcher.Text := l_TextToSearch;
  except
   on E : Exception do
    begin
     if not (E is El3NoLoggedException) then
      vtMessageDlg(E);
     ModalResult := mrNone;
     ActiveControl := STextComboBox;
     Result := False;
    end;
  end;
 end;

var
 l_SubID : Integer;
begin
 if (STextComboBox.Text = '') then
 begin
  ModalResult := mrNone;
  ActiveControl := STextComboBox;
  Exit;
 end;

 l_TextToSearch := STextComboBox.Text;

 case SType of
  srtText : begin
             if not lp_InitSeacher4TextFind then Exit;
             if not lp_InitTextProp then Exit;
             STextComboBox.AddToHistory;
            end;
  srtStyle: begin
             fStyleSearcher.Layer := l3NilLong;
             LastSrchRec.Searcher := fStyleSearcher;
             if not lp_InitTextProp then Exit;
            end;{srtStyle}

{$IFNDEF NotArchiProject}
  srtHLink: begin
             LastSrchRec.Searcher := fHLinkSearcher;
             if not lp_InitTextProp then Exit;
             STextComboBox.AddToHistory;
            end;{srtHLink}
{$ENDIF}
  srtSub: begin
           LastSrchRec.Searcher := nil;
           l_SubID := StrToInt(STextComboBox.Text);
           with (FEditor as TevEditor) do
            with evGetSubList(TextSource).Sub[l_SubID] do
             if Exists then
              Select(Selection)
             else
              MessageDlg(Format('Метка %d не найдена.', [l_SubID]), mtWarning, [mbOK], 0);
           Exit;
          end;//srtSub
 end;{case SType}

 UpdateFindFlag(SrchMode);
 FInputIsParsed := True;
end;

procedure TTextSearchDlg.FindEntry;
var
 lRCEvent : TevReplaceConfirmEvent;
 lDefRCEvent : TevReplaceConfirmEvent;
begin
 if not FInputIsParsed then
  Exit;
 if Assigned(LastSrchRec.Replacer) then
 begin
  lRCEvent := LastSrchRec.Replacer.OnReplaceConfirm;
  lDefRCEvent := DoReplaceConfirm;
  if Assigned(LastSrchRec.Replacer.OnReplaceConfirm) and
     (TMethod(lRCEvent).Code <> TMethod(lDefRCEvent).Code) then
   Hide
  else
   LastSrchRec.Replacer.OnReplaceConfirm := DoReplaceConfirm;
 end;

 IsOptionVisible := false; // схлопываем настройки

 if not FInReplaceLoop then
 begin
  case FDialogMode of
   sdmEditor:
    begin
     try
      FEditor.Find(LastSrchRec.Searcher, LastSrchRec.Replacer, LastSrchRec.SFlags);
      if Assigned(FEditor) then
       FEditor.AdjustForm2Found(Self);
      {$IFDEF InsiderTest}
       Tl3BatchService.Instance.ExecuteCurrentModalWorker(se_meAfterLoop);
      {$ENDIF InsiderTest}                                                
      if Assigned(LastSrchRec.Replacer) and (f_OwnerToClose <> 0) then
       PostMessage(f_OwnerToClose, WM_CLOSE, 0, 0);
     except
      on EevSearchFailed do ShowNotFoundMsg;
      on El3RegExError do ShowBadRegExpMsg;
     end;{try..finally}
     Exclude(LastSrchRec.SFlags, ev_soGlobal);
    end;
   {$IFNDEF NotArchiProject} // поиск в списках - только в Арчи
    sdmList:
     begin
      Assert(SType = srtText, '?? SType <> srtText :(');
      if OriginGroup.ItemIndex = 1 then
       FindInList(f_SrchWin.DocList.SrchResultLister.Current + 1)
      else
       FindInList(0);
      OriginGroup.ItemIndex := 1;
     end;
   {$ENDIF}
  end;
 end
 else
  FReplaceResult := mrNo;
end;

procedure TTextSearchDlg.btnFindClick(Sender: TObject);
begin
 if FInReplaceLoop then
  FReplaceResult := mrNo
 else
 begin
  if not FInputIsParsed then
   ParseInput;
  FindEntry;
 end;
end;

procedure TTextSearchDlg.InputsChange(Sender: TObject);
begin
 FInputIsParsed := False;
 FReplaceResult := mrCancel;
end;

procedure TTextSearchDlg.FormShow(Sender: TObject);
begin
 FInputIsParsed := False;
end;

procedure TTextSearchDlg.btnCancelClick(Sender: TObject);
begin
 Close;
end;

function TTextSearchDlg.Get_View: InevView;
begin
 Result := FEditor.View;
end;

function TTextSearchDlg.DeleteFoundRgn: Bool;
begin
 Result := FEditor.DeleteFoundRgn;
end;

function TTextSearchDlg.Get_Progress: InevProgress;
  {-}
begin
 Result := FEditor.TextSource;
end;

function TTextSearchDlg.ReplaceConfirm(const aBlock         : InevRange;
                                       aAlienReplaceConfirm : TevReplaceConfirmEvent): ShortInt;
begin
 if Assigned(aAlienReplaceConfirm) then
  Result := (FEditor as TevEditor).SetFoundBlock(aBlock, aAlienReplaceConfirm)
 else
  Result := (FEditor as TevEditor).SetFoundBlock(aBlock, DoReplaceConfirm);
end;

function TTextSearchDlg.DoReplaceConfirm(Sender       : TObject;
                                         const aBlock : InevRange): ShortInt;
  {* - запрос на замену. Возвращаемое значение см. TevReplaceConfirmEvent. }
begin
 (FEditor as TevEditor).AdjustForm2Found(Self);
 fInReplaceLoop := True;
 Result := mrNone;
 try
  fReplaceResult := mrNone;
  while FReplaceResult = mrNone do
  begin
   {$IFDEF InsiderTest}
    if not Tl3BatchService.Instance.ExecuteCurrentModalWorker(se_meInLoop) then
     FReplaceResult := mrNone;
   {$ENDIF InsiderTest}
   Application.ProcessMessages;
  end; // while FReplaceResult = mrNone do
  Result := FReplaceResult;
 finally
  FInReplaceLoop := False;
 end;
end;

procedure TTextSearchDlg.ReplUpdate;
begin
 FEditor.Update;
end;

procedure TTextSearchDlg.btnReplaceClick(Sender: TObject);
begin
 if FInReplaceLoop then
  FReplaceResult := mrYes
 else
 begin
  ParseInput;
  FindEntry;
 end;
end;

procedure TTextSearchDlg.btnReplaceAllClick(Sender: TObject);
begin
 if FInReplaceLoop then
  FReplaceResult := mrAll
 else
 begin
  ParseInput;
  Exclude(LastSrchRec.SFlags, ev_soConfirm);
  FindEntry;
  Include(LastSrchRec.SFlags, ev_soConfirm);
 end;
end;

procedure TTextSearchDlg.DisplayOptions;
var
 S: string;

 procedure AddStringToS(AddStr: string);
 begin
  if S <> '' then
   S := S + ', '
  else
   AddStr[1] := AnsiUpperCase(AddStr[1])[1];
  S := S + AddStr;
 end;

 procedure AddOption(CB: TCheckBox; OptionString: string);
 begin
  if CB.Visible and CB.Checked then
   AddStringToS(OptionString);
 end;

begin
 S := '';
 if ScopeGroup.ItemIndex = 1 then
  AddStringToS('выделенный фрагмент');
 AddOption(cbCaseSens, 'с учетом регистра');
 AddOption(cbWordOnly, 'слова целиком');
 AddOption(cbNormalize, 'словоформы');
 AddOption(cbAnyTail, 'любые окончания');
 AddOption(cbRegular, 'регулярные выражения');
 AddOption(cbWholePara, 'ко всему параграфу');
 lblOptionsDisp.Caption := S;
end;

procedure TTextSearchDlg.cbWholeParaClick(Sender: TObject);
begin
 InputsChange(nil);
 DisplayOptions;
end;

procedure TTextSearchDlg.SetIsOptionVisible(aValue : boolean);
var
 BM: TBitmap;
begin
 if IsOptionVisible = aValue then Exit;
 fIsOptionVisible := aValue;

 if IsOptionVisible then
 begin
  Height := 362;
  BM := TBitmap.Create;
  ilOpenClose.GetBitmap(0, BM);
  btnMore.Glyph := BM;
  OptionGroupBox.Visible := True;
  ScopeGroup.Visible := True;
  OriginGroup.Visible := True;
 end
 else
 begin
  Height := 177;
  BM := TBitmap.Create;
  ilOpenClose.GetBitmap(1, BM);
  btnMore.Glyph := BM;
  OptionGroupBox.Visible := False;
  ScopeGroup.Visible := False;
  OriginGroup.Visible := False;
 end;
end;

procedure TTextSearchDlg.ScopeGroupClick(Sender: TObject);
begin
 InputsChange(nil);
 DisplayOptions;
end;

procedure TTextSearchDlg.STextComboBoxChange(Sender: TObject);
var
 lEnableButtons: Boolean;
begin
 InputsChange(nil);
 lEnableButtons := STextComboBox.Text <> '';

 btnFind.Enabled := lEnableButtons;
 btnReplaceAll.Enabled := lEnableButtons;
 btnReplace.Enabled := lEnableButtons;
end;

function TTextSearchDlg.DefaultCloseAction: TCloseAction;
begin
 Result := caHide;
end;

function TTextSearchDlg.CheckStamp(const aGUID: TGUID): Boolean;
  {-}
begin
 if l3SystemDown then
  Result := False
 else
  Result := IsEqualGUID(l3System.GetStamp, aGUID);
end;

procedure TTextSearchDlg.ShowBadRegExpMsg;
begin
 vtMessageDlg(l3CStr(@SBadRegExp), mtError, [mbOK], 0 {HelpCtx});
end;

class procedure TTextSearchDlg.ClientFormClosed(aForm: TCustomForm);
begin
 if not Assigned(g_TextSearchDlg) then
  Exit;
 with g_TextSearchDlg do
  if (fEditor <> nil) and (GetParentForm(fEditor) = aForm) then
  begin
   fEditor := nil;
   f_OwnerToClose := aForm.Handle;
  end;
end;

{$IFDEF InsiderTest}
class procedure TTextSearchDlg.ClearFindWindow;
begin
 if Assigned(g_TextSearchDlg) then
  FreeAndNil(g_TextSearchDlg);
end;
{$ENDIF InsiderTest}

class procedure TTextSearchDlg.SwitchActiveEditor(aNewEditor: TevCustomEditor);
begin
 if not Assigned(g_TextSearchDlg) then
  Exit;
 with g_TextSearchDlg do
 begin
  try
   if aNewEditor = FEditor then
    Exit;
   Close;
  except
   l3System.Stack2Log('Какая-то хрень с g_TextSearchDlg.FEditor');
  end;
  fDialogMode := sdmEditor;
  fEditor := aNewEditor;
  if aNewEditor = nil then
   Exit;
 end;
end;

class function TTextSearchDlg.IsInReplaceLoop: Boolean;
begin
 Result := (g_TextSearchDlg <> nil) and g_TextSearchDlg.FInReplaceLoop;
end;

procedure TTextSearchDlg.UpdateFindFlag(aFlag: Byte);
var
 l_Form          : TCustomForm;
 l_TempBool      : Boolean;
 l_TextToReplace : string;
begin
 if (aFlag = 1) then
 begin
  case RType of
   srtText  : begin
               if (SType = srtText) and cbRegular.Checked then
                LastSrchRec.Replacer := fRegExpReplacer
               else
                LastSrchRec.Replacer := fTextReplacer;
               RTextComboBox.AddToHistory;
              end;
   srtStyle : begin
               LastSrchRec.Replacer := fStyleReplacer;
               fStyleReplacer.WholePara := cbWholePara.Checked;
              end;{srtStyle}
   srtSub   : LastSrchRec.Replacer := fSubReplacer;
   {$IFNDEF NotArchiProject}
    srtHLink : begin
                LastSrchRec.Replacer := fHLinkReplacer;
                l_Form := GetParentForm(fEditor);
                if l_Form is TDocEditorWindow then
                 fHLinkReplacer.EnableAbsentDoc := TDocEditorWindow(l_Form).miSetReferenceDirect.Enabled;
                RTextComboBox.AddToHistory;
               end;
   {$ENDIF}
  end;{case RType}
  try
   if RType = srtText then
   begin
    l_TextToReplace := RTextComboBox.Text;
    if not ConvertTextWildcards(l_TextToReplace, l_TempBool, True) then
     raise Exception.Create(SInvalidSpecialSymbol + l_TextToReplace);
    LastSrchRec.Replacer.Text := l_TextToReplace;
   end
   else
    LastSrchRec.Replacer.Text := RTextComboBox.Text;
  except
   on E : Exception do
   begin
    if not (E is El3NoLoggedException) then
     vtMessageDlg(E);
    ModalResult := mrNone;
    ActiveControl := RTextComboBox;
    Exit;
   end;
  end; 
 end
 else
  LastSrchRec.Replacer := nil;

 LastSrchRec.SFlags := [];                         

 if cbCaseSens.Checked then
  Include(LastSrchRec.SFlags, ev_soMatchCase);
 if cbWordOnly.Checked then
  Include(LastSrchRec.SFlags, ev_soWholeWord);
 if ScopeGroup.ItemIndex = 1 then
  Include(LastSrchRec.SFlags, ev_soSelText);

 if (aFlag = 1) then
 begin
  Include(LastSrchRec.SFlags, ev_soConfirm);
  Include(LastSrchRec.SFlags, ev_soReplaceAll);
 end 
 else
  Include(LastSrchRec.SFlags, ev_soFind);

 case OriginGroup.ItemIndex of
  0 : Include(LastSrchRec.SFlags, ev_soGlobal);
  2 : Include(LastSrchRec.SFlags, ev_soBackward);
 end;{case OriginGroup.ItemIndex}

 LastSrchRec.Searcher.Options := LastSrchRec.SFlags;
 if (aFlag = 1) then
  LastSrchRec.Replacer.Options := LastSrchRec.SFlags;
 LastSrchRec.Operation := aFlag + 1;
end;

end.
