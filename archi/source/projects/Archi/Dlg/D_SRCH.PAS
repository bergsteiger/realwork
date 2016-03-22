unit D_Srch;

{ $Id: D_SRCH.PAS,v 1.99 2015/12/25 12:44:37 voba Exp $ }

{$I l3Define.inc}

interface

uses BottomBtnDlg, F_AttrExplorer,
     Windows, SysUtils, Messages, Classes,
     Graphics, Forms, Controls, Buttons, Menus, Dialogs, vtDialogs,
     DragData, ObjList,
     StdCtrls, ExtCtrls, ComCtrls, Mask,
     OvcBase,  OvcNbk, TB97,
     l3Date,
     vtlister,  vtOutliner,
     l3Interfaces,
     l3DatLst, l3Tree, l3Tree_TLB, l3Nodes,
     ResShop, StrShop,
     DT_Const, DT_Types, DT_Link, DT_Dict, DT_Query, DT_Stage,
     l3Types,
     evTypes, evEditor, evMemo, evEditorWindow, OvcTCHdr, OvcTCmmn, OvcTCell,
     OvcTCStr, OvcTable, OvcTCCBx, OvcTCEdt,  TB97Ctls, ImgList,
     vtCombo, vtDateEdit, evMultiSelectEditorWindow,
     vtForm, vtCtrls, tb97GraphicControl, evCustomEditor,
     evEditorWithOperations, vtGroupBoxEx, vtGroupBox, afwControl,
     evCustomMemo, afwControlPrim, afwBaseControl, nevControl,
     vtLabel, vtCheckBox, eeCheckBox, evCustomEditorWindowPrim,
     evCustomEditorWindowModelPart, evCustomEditorModelPart,
     evCustomEditorWindow,
     DocIntf;

type
  TDocSearchDlg = class(TBottomBtnDlg)
    IntervalPopupMenu: TPopupMenu;
    piIntervalTogether: TMenuItem;
    piInterval: TMenuItem;
    piIntervalExpr: TMenuItem;
    piIntervalPara: TMenuItem;
    piInterval2: TMenuItem;
    piInterval3: TMenuItem;
    piInterval4: TMenuItem;
    piInterval5: TMenuItem;
    piIntervalDoc: TMenuItem;
    chStage: TOvcTCColHead;
    tcStageName: TOvcTCString;
    tcCondition: TOvcTCComboBox;

    nbkSearchWhat: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    tblStage: TOvcTable;
    Panel12: TPanel;
    gbxStageStatus: TvtGroupBoxEx;
    cbxStageInc: TvtCheckBox;
    cbxStageUnInc: TvtCheckBox;
    ImageList1: TImageList;
    TextSrchMemo: TevMemo;
    Panel4: TPanel;
    sbANDSign: TToolbarButton97;
    sbORSign: TToolbarButton97;
    sbANDNOTSign: TToolbarButton97;
    sbFLWSign: TToolbarButton97;
    sbBrackets: TToolbarButton97;
    sbANDSignInterval: TToolbarButton97;
    sbFLWSignInterval: TToolbarButton97;
    sbAsteriskSign: TToolbarButton97;
    sbQuestSign: TToolbarButton97;
    Panel9: TPanel;
    cbxSrchInNameOnly: TvtCheckBox;
    pnlTxt: TPanel;
    Label2: TvtLabel;
    lblTxt2: TvtLabel;
    lblTxt3: TvtLabel;
    lblTxt4: TvtLabel;
    edtTxt1: TEdit;
    edtTxt2: TEdit;
    edtTxt3: TEdit;
    edtTxt4: TEdit;
    cbxSrchInNameOnly2: TvtCheckBox;
    Panel3: TPanel;
    StatusBox: TvtGroupBoxEx;
    CheckBox1: TvtCheckBox;
    CheckBox2: TvtCheckBox;
    GroupBox1: TGroupBox;
    cbNumber: TComboBox;
    SearchAttrExplorer: TAttrExplorer;
    cbxNewOnly: TvtCheckBox;
    gbStageDates: TGroupBox;
    Label3: TvtLabel;
    Label5: TvtLabel;
    edtStageDateBegin: TvtDateEdit;
    edtStageDateEnd: TvtDateEdit;
    ParamsPanel: TPanel;
    cbxWithEquals: TvtCheckBox;
    cbDocType: TComboBox;
    Label6: TvtLabel;
    Label7: TvtLabel;
    Label4: TvtLabel;
    Label1: TvtLabel;
    LowDateEdit: TvtDateEdit;
    HighDateEdit: TvtDateEdit;
    Label8: TvtLabel;
    grpTags: TGroupBox;
    cbInternet: TCheckBox;
    cbHang: TCheckBox;
    grpUrgency: TvtGroupBox;
    cbUrgency: TComboBox;
    procedure EditChange(Sender: TObject);
    procedure StatusCheckBoxClick(Sender: TObject);
    procedure DocTypeListSelect(Sender: TObject; Index: Longint;  Var Selected: Boolean);
    procedure cbDocTypeChange(Sender: TObject);
    procedure cbNumberDropDown(Sender: TObject);
    procedure cbxSrchInNameOnlyClick(Sender: TObject);
    procedure sbANDSignClick(Sender: TObject);
    procedure sbORSignClick(Sender: TObject);
    procedure sbANDNOTSignClick(Sender: TObject);
    procedure sbFLWSignClick(Sender: TObject);
    procedure sbBracketsClick(Sender: TObject);
    procedure piItervalClick(Sender: TObject);
    procedure sbANDSignIntervalClick(Sender: TObject);
    procedure sbFLWSignIntervalClick(Sender: TObject);
    procedure sbAsteriskSignClick(Sender: TObject);
    procedure sbQuestSignClick(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure cbxNewOnlyClick(Sender: TObject);
    procedure HighDateEditEnter(Sender: TObject);
    procedure tblStageGetCellData(Sender: TObject; RowNum: Longint;
      ColNum: Integer; var Data: Pointer; Purpose: TOvcCellDataPurpose);
    procedure tblStageDoneEdit(Sender: TObject; RowNum: Longint;
      ColNum: Integer);
    procedure cbStageUnplugOnlyClick(Sender: TObject);
    procedure tblStageExit(Sender: TObject);
    procedure edtTxt1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure nbkSearchWhatChanging(Sender: TObject; var AllowChange: Boolean);
    procedure cbxWithEqualsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

   private
    fQuery         : TdtQuery;

    f_IsSpecification : Boolean;

    InsOperation   : AnsiChar;
    fDestSrchWin    : TForm;

    SearchDescriptor : AnsiString;
    tmpInd           : Longint;
    aBeginStage,
    aEndStage,
    aNotEndStage,
    aNotBeginStage   : TStageSet;

    fFamily : TFamilyID;
    fDocument     : TarDocumentWithAttr;
    f_AlienQuery: TdtQuery;

    procedure AddToAlien(aQuery: TdtQuery);
    function TSAddBrackets(Sender: TObject;
                           var B : PAnsiChar;
                           var L : Long;
                           var CharSet : Smallint;
                           Data : Pointer): Boolean;

    function  MakeSearchQuery : TdtQuery;

    //function GetSrchServ : TSrchServer;
    //procedure SetSrchServ(Value : TSrchServer);

    function GetQuery : TdtQuery;
    procedure SetQuery(aValue : TdtQuery);

    procedure SetFamily(Value : TFamilyID);

    procedure WMDropAccept(var Message: TMessage); message wm_DropAccept;

    procedure SetPagesModifyIcon;
    procedure SetPageModifyIcon(aPage : Integer);

  public
    NewSearchWinName : AnsiString;
    constructor CreateParam(AOwner : TComponent; AFamily : TFamilyID);
    procedure Cleanup; override;
    procedure LoadDlgState;
    function Execute(var aQuery : TdtQuery;
                     var aDestSrchWin : TForm;
                         aIsSpecification: Boolean = False): Boolean; reintroduce;


    //property Query  : TdtQuery read GetQuery write SetQuery;
    property Family : TFamilyID read fFamily write SetFamily;
    
  end;

implementation

{$R *.DFM}

uses
  D_SchRes,

  l3Base,
  l3String,
  l3LongintList,
  l3TreeSupport,
  l3TreeInterfaces,

{$IFDEF InsiderTest}
 afwAnswer,
{$ENDIF InsiderTest}

  l3IniFile,
  l3BatchService,

  DocAttrIntf,
  DocAttrUtils,
  DocAttrToolsIntf,

  IniShop,
  HelpCnst,
  Main,
  evFacadTextSource,
  dt_AttrSchema,
  DT_Doc,
  DT_SrchQueries,
  DT_IndexSupport,
  arAttrNodes
  ;

const
 piAttr  = 0;
 piAttr2 = 1;
 piText  = 2;
 piSpec  = 3;

 cUrgencyDesc: array [0..cMaxUrgency] of AnsiString = ('обычная срочность','срочные документы','в версию');

function TransAttributeToValueList(aList : IListDocAttribute; aValueList : Tl3LongintList): Tl3LongintList;
 {- Translate List Of Selected Items to List of Values, return aValueList}
var
 I       : Integer;
begin
 Result := aValueList;
 aValueList.Clear;
 for I := 0 to Pred(aList.Count) do
  aValueList.Add(aList.Handle[I]);
end;

procedure TransValueListToAttribute(aValueList : Tl3LongintList; aList : IDictAttributeTool);
{- Translate List Of Selected Items to List of Values, return aValueList}
var
 I       : Integer;
begin
 aList.DeleteAll;
 for I := 0 to Pred(aValueList.Count) do
  aList.AddRec(aValueList.Items[I]);
end;

constructor TDocSearchDlg.CreateParam(AOwner : TComponent; aFamily : TFamilyID);
Begin
 Create(AOwner);
 Screen.Cursor:=crHourGlass;
 try
  nbkSearchWhat.ActivePageIndex := 0;

  fDocument := TQueryDataDocument.Create(aFamily);
  fDocument.CreateNewText;
  SearchAttrExplorer.Document := fDocument;

  //SearchAttrExplorer.AttrManager.AttrOperateMode := aomSearch;
  SearchAttrExplorer.AttrSet := GlSearchAttrSet - HiddenAttr;
  Family := aFamily;

  GetDNTypeList(cbDocType.Items);
  //LoadStringList(cbDocType.Items, NumOfDNStr, sidFirstDataNumRec);
  cbDocType.Items[0]:='Все типы';
  cbDocType.ItemIndex := IniRec.PrefDNType;
  cbxNewOnly.Checked := IniRec.NewSrchOnly;

  if Not IniRec.GarantStyleQuery then
  begin
   pnlTxt.Visible := False;
   Panel3.Align := alClient;
   //Height := Height - pnlTxt.Height;
  end;

  tblStage.RowLimit := Ord(High(TStageType));
 finally
  Screen.Cursor := Cursor;
 end;
end;

procedure TDocSearchDlg.AddToAlien(aQuery: TdtQuery);
begin
 if f_AlienQuery = nil then
  f_AlienQuery := TdtAndQuery.Create;
 TdtAndQuery(f_AlienQuery).AddQuery(aQuery.Use); 
end;

procedure TDocSearchDlg.Cleanup;
Begin
 l3Free(fQuery);
 l3Free(f_AlienQuery);
 l3Free(fDocument);
 Inherited;
end;

//function TDocSearchDlg.GetSrchServ : TSrchServer;
//begin
//end;

//procedure TDocSearchDlg.SetSrchServ(Value : TSrchServer);
//begin
//end;

procedure TDocSearchDlg.SetFamily(Value : TFamilyID);
begin
 If fFamily = Value then Exit;
 fFamily := Value;
 SearchAttrExplorer.Family := fFamily;
 //SearchAttrExplorer.AttrManager.DocFamily := fFamily;
end;

function TDocSearchDlg.GetQuery : TdtQuery;
begin
 Result := fQuery;
end;

procedure TDocSearchDlg.SetQuery(aValue : TdtQuery);
begin
 l3Set(fQuery, aValue);
end;

function TDocSearchDlg.Execute(var aQuery : TdtQuery; var aDestSrchWin : TForm; aIsSpecification: Boolean) : Boolean;
Begin
 UserConfig.Section := PrefSectName;
 UserConfig.ReadFormPlace(SrchDlgFormPlaceName, Self);

 SetQuery(aQuery);
 LoadDlgState;

 if f_AlienQuery <> nil then
  if vtMessageDlg(l3CStr('Выборка содержит неизменяемые параметры. Продолжить?'),
                  mtWarning, [mbYes, mbNo]) = mrNo then
  begin
   Result := False;
   Exit;
  end;

 f_IsSpecification := aIsSpecification;
 cbxNewOnly.Enabled := not aIsSpecification;

 Result := ShowModal = mrOk;

 if Result then
 begin
  aDestSrchWin := fDestSrchWin;
  l3Set(aQuery, fQuery);
 end; 
end;

function TDocSearchDlg.MakeSearchQuery : TdtQuery;
Var
 I, Cnt        : Longint;
 lTextFormula  : AnsiString;
 lQuery        : TdtQuery;
 lAllQuery     : TdtAndQuery;

function TranslateForAnyTail(aSrchText : AnsiString) : AnsiString;
 var
  lStrPos : Integer;
  lAddLog : Boolean;
  lWSize  : Integer;
 begin
  Result := l3DeleteDoubleSpace(Trim(aSrchText)); //+' ';
  lStrPos := Length(Result);
  lAddLog := True;
  While lStrPos > 0 do
   begin
    Case Result[lStrPos] of
     '!' : begin
            System.Delete(Result, lStrPos, 1);
            lAddLog := False;
           end;
     ' ' : lAddLog := True
     else
      begin
       If lAddLog then
        begin
         lWSize := 0;
         While lWSize <= 3 {mgDicLst.LHashSize} do
          If ((lStrPos - lWSize) > 0) and (Result[lStrPos - lWSize] <> ' ')
           then Inc(lWSize)
           else Break;

         If lWSize > 3 then System.Insert('*', Result, Succ(lStrPos));
        end;
       lAddLog := False;
      end;
    end;

    Dec(lStrPos);

   end;
  //Result := TrimRSpace(Result);
 end;

procedure AddToTextFormula(S : AnsiString);
 var
  lTextSize : Longint;
 begin
  if S = '' then Exit;
  //lTextSize := l3StrLen(lTextFormula);
  S := '('+TranslateForAnyTail(S)+')';
  if lTextFormula = '' then
   lTextFormula := S
  else
   lTextFormula := lTextFormula + ' & ' + S;
 end;

//function IterHandler(CurNode : Il3Node) : Boolean; far;
procedure IterHandler(CurNode : Il3Node); far;
var
 lAttrList   : IListDocAttribute;
 lDictIDList : Tl3LongintList;
 lQuery      : TdtQuery;
begin
 lAttrList := CurNode as IListDocAttribute;
 with lAttrList do
  If Count > 0 then
  begin
   lDictIDList := Tl3LongintList.Make;
   try
    TransAttributeToValueList(lAttrList, lDictIDList);
    lQuery := TdtDictQuery.Create(AttrID2DLType(AttrID), lDictIDList, cbxWithEquals.Checked, True {aWithSubTree});
    lAllQuery.AddQueryF(lQuery);

    If SearchDescriptor <> '' then SearchDescriptor := SearchDescriptor + ', ';
    SearchDescriptor := SearchDescriptor + AttrListToDescriptorString(lAttrList, ' и ');
   finally
    l3Free(lDictIDList);
   end;
   Modified := False;
  end;
end;

var
 //l_Text : Tl3PCharLen;
 lActiveStatus : TActiveStatusSet;
 lUrgency : integer;

const
 lIndexType : array[Boolean] of TIndexType = (itText, itHeading);

begin
  lAllQuery := TdtAndQuery.Create;

  try
   SearchDescriptor := '';

   if (cbNumber.Text <> '') or not LowDateEdit.IsEmpty or not HighDateEdit.IsEmpty then
   begin
    lQuery := TdtDateNumQuery.Create(StDateToDemon(LowDateEdit.StDate),
                                     StDateToDemon(HighDateEdit.StDate),
                                     cbNumber.Text,
                                     TDNType(cbDocType.ItemIndex));
    lAllQuery.AddQueryF(lQuery);
   end;

   if cbNumber.Text <> '' then
   begin
     If SearchDescriptor <> '' then SearchDescriptor:=SearchDescriptor+', ';
     SearchDescriptor := SearchDescriptor + '№ ' + cbNumber.Text;
   end;

   if (LowDateEdit.Date <> NullDate) or (HighDateEdit.Date <> NullDate) then
   begin
    if SearchDescriptor <> '' then SearchDescriptor:=SearchDescriptor+', ';
     SearchDescriptor:=SearchDescriptor + 'дата ';
    if LowDateEdit.Date <> NullDate then
    begin
     SearchDescriptor := SearchDescriptor + 'c ' + LowDateEdit.Text;
     If HighDateEdit.Date <> NullDate then
      SearchDescriptor := SearchDescriptor + ' ';
    end;
    if HighDateEdit.Date <> NullDate then
     SearchDescriptor := SearchDescriptor + 'по ' + HighDateEdit.Text;
   end;

   if (cbUrgency.ItemIndex > 0) then
   begin
    lUrgency := cbUrgency.ItemIndex - 1;
    lQuery := TdtMainAttrQuery.Create(fUrgency_fld, lUrgency);
    lAllQuery.AddQueryF(lQuery);

    if SearchDescriptor <> '' then SearchDescriptor := SearchDescriptor+', ';
    SearchDescriptor := SearchDescriptor + cUrgencyDesc[cbUrgency.ItemIndex - 1];
   end;

   if (cbInternet.State <> cbGrayed) then
   begin
    lQuery := TdtStatusMaskQuery.Create(dstatInternet);
    if cbInternet.State = cbUnchecked then
     SQNot(lQuery);
    lAllQuery.AddQueryF(lQuery);
   end;

   if (cbHang.State <> cbGrayed) then
   begin
    lQuery := TdtStatusMaskQuery.Create(dstatHang);
    if cbHang.State = cbUnchecked then
     SQNot(lQuery);
    lAllQuery.AddQueryF(lQuery);
   end;

   if (TextSrchMemo.Buffer.SLen > 0) or (Length(edtTxt1.Text) > 0) then
   begin
    edtTxt1.Tag := 0;
    cbxSrchInNameOnly.Tag := 0;
    //l_Text) := TextSrchMemo.Buffer;
    lTextFormula := '';
    if TextSrchMemo.TextLen > 0 then
     lTextFormula := l3Str(TextSrchMemo.Buffer);

    if (Length(edtTxt1.Text) > 0) or (Length(edtTxt2.Text) > 0) or
       (Length(edtTxt3.Text) > 0) or (Length(edtTxt4.Text) > 0) then
    begin
     if Length(lTextFormula) > 0 then lTextFormula := '('+lTextFormula+')';
     AddToTextFormula(edtTxt1.Text);
     AddToTextFormula(edtTxt2.Text);
     AddToTextFormula(edtTxt3.Text);
     AddToTextFormula(edtTxt4.Text);
    end;

    lQuery := TdtTextQuery.Create(lTextFormula, lIndexType[cbxSrchInNameOnly.Checked]);
    lAllQuery.AddQueryF(lQuery);

    if SearchDescriptor <> '' then SearchDescriptor := SearchDescriptor+', ';
    SearchDescriptor := SearchDescriptor + lTextFormula;
   end;

   if StatusBox.GroupCheckData in [1,2] then
   begin
    Case StatusBox.GroupCheckData of
     1 :
      begin
       lActiveStatus := [asActive];
       SearchDescriptor := SearchDescriptor + ' Действующие';
      end;
     2 :
      begin
       lActiveStatus := [asNoActive,asPreActive];
       SearchDescriptor := SearchDescriptor + ' Недействующие';
      end;
    end;

    lQuery := TdtActiveQuery.Create(lActiveStatus, cBlankDate);
    lAllQuery.AddQueryF(lQuery);
   end;

   SearchAttrExplorer.otlAttributes.IterateF(Tl3NodeAction(l3L2FA(@IterHandler)), imOneLevel);

   if (aBeginStage <> []) or (aEndStage <> []) or (aNotEndStage <> []) or (aNotBeginStage <> []) or
      (edtStageDateBegin.Date <> NullDate) or (edtStageDateEnd.Date <> NullDate) then
   begin
    lQuery := TdtComplexStageQuery.Create(
               StDateToDemon(edtStageDateBegin.StDate), StDateToDemon(edtStageDateEnd.StDate),
               aBeginStage, aEndStage, aNotEndStage, aNotBeginStage, gbxStageStatus.GroupCheckData);
    lAllQuery.AddQueryF(lQuery);
    SearchDescriptor := SearchDescriptor + 'Поиск по стадиям';
   end;

   if f_AlienQuery <> nil then
    lAllQuery.AddQuery(f_AlienQuery);

  except
   l3Free(lAllQuery);
   raise;
  end;

  if lAllQuery.QueryList.Count = 0 then
  begin
   l3Free(lAllQuery);
   Result := TdtAllDocsQuery.Create;
  end
  else
   Result := lAllQuery;
end;

procedure TDocSearchDlg.LoadDlgState;
var
 lQuery : TdtQuery;
 lAttrNode : Il3Node;
 I : Integer;
begin
 if fQuery = nil then Exit;

 l3Free(f_AlienQuery);
 if not (fQuery is TdtAndQuery) then
  f_AlienQuery := fQuery.Use
 else
  with TdtAndQuery(fQuery).QueryList do
   for I := 0 to pred(Count) do
   begin
    lQuery := TdtQuery(Items[I]);

   {TdtDictQuery}
    if lQuery is TdtDictQuery then
    begin
     lAttrNode := SearchAttrExplorer.FindAttrNode(DLType2AttrID(TdtDictQuery(lQuery).DictType));
     if lAttrNode = nil then Continue;

     TransValueListToAttribute(TdtDictQuery(lQuery).DictIDList, (lAttrNode as IarAttributeContainer).Attribute as IDictAttributeTool);
     if TdtDictQuery(lQuery).WithEquals then
      cbxWithEquals.Checked := True;
    end
    else
   {TdttextQuery}
    if lQuery is TdttextQuery then
    begin
     TextSrchMemo.Buffer := l3PCharLen(TdttextQuery(lQuery).TextFormula);
     cbxSrchInNameOnly.Checked  := TdttextQuery(lQuery).IndexType = itHeading;
     cbxSrchInNameOnly2.Checked := cbxSrchInNameOnly.Checked;
    end
    else
   {TdtDateNumQuery}
    if lQuery is TdtDateNumQuery then
    begin
     cbNumber.Text := TdtDateNumQuery(lQuery).NumberMask;
     LowDateEdit.StDate  := DemonToStDate(TdtDateNumQuery(lQuery).FromDate);
     HighDateEdit.StDate := DemonToStDate(TdtDateNumQuery(lQuery).ToDate);
     cbDocType.ItemIndex := Integer(TdtDateNumQuery(lQuery).DNType);
    end
    else
   {TdtActiveQuery}
    if lQuery is TdtActiveQuery then
    begin
     if TdtActiveQuery(lQuery).Status = [asActive] then
      StatusBox.GroupCheckData := 1
     else
      if (TdtActiveQuery(lQuery).Status * [asNoActive, asPreActive]) <> [] then
       StatusBox.GroupCheckData := 2
      else
       StatusBox.GroupCheckData := 3;
    end
    else
   {TdtStageQuery}
    if lQuery is TdtComplexStageQuery then
    with TdtComplexStageQuery(lQuery) do
    begin
     aBeginStage  := BeginStage;
     aEndStage    := EndStage;
     aNotEndStage := NotEndStage;
     aNotBeginStage := NotBeginStage;

     gbxStageStatus.GroupCheckData := DocFlag;

     edtStageDateBegin.StDate := DemonToStDate(BeginDate);
     edtStageDateEnd.StDate   := DemonToStDate(EndDate);
    end
    else
    if (lQuery is TdtMainAttrQuery) and (TdtMainAttrQuery(lQuery).Field = fUrgency_fld) then
     cbUrgency.ItemIndex := TdtMainAttrQuery(lQuery).Value + 1
    else
     AddToAlien(lQuery); 
   end;

end;

{*************************}

procedure TDocSearchDlg.EditChange(Sender: TObject);
begin
 TComponent(Sender).Tag:=1;
end;

procedure TDocSearchDlg.HighDateEditEnter(Sender: TObject);
begin
 If (HighDateEdit.Date = NullDate) and (LowDateEdit.Date <> NullDate)
  then HighDateEdit.Date := LowDateEdit.Date;
end;

procedure TDocSearchDlg.StatusCheckBoxClick(Sender: TObject);
begin
 StatusBox.Tag:=1;
end;

procedure TDocSearchDlg.DocTypeListSelect(Sender: TObject; Index: Longint; Var Selected: Boolean);
begin
 TComponent(Sender).Tag:=1;
end;

procedure TDocSearchDlg.cbDocTypeChange(Sender: TObject);
begin
 TComponent(Sender).Tag:=1;
 If Sender = cbDocType then cbNumber.Items.Clear;
 IniRec.PrefDNType := cbDocType.ItemIndex;
end;

procedure TDocSearchDlg.cbxSrchInNameOnlyClick(Sender: TObject);
begin
 If Sender = cbxSrchInNameOnly
  then
   begin
    cbxSrchInNameOnly2.Checked := cbxSrchInNameOnly.Checked;
    If cbxSrchInNameOnly.Tag = 0
     then cbxSrchInNameOnly.Tag := 1
     else cbxSrchInNameOnly.Tag := 0;
   end
  else cbxSrchInNameOnly.Checked  := cbxSrchInNameOnly2.Checked;
end;

procedure TDocSearchDlg.SetPagesModifyIcon;
var
 I : Integer;
begin
 for I :=  piAttr to piSpec do
  SetPageModifyIcon(I);
end;

procedure TDocSearchDlg.SetPageModifyIcon(aPage : Integer);
var
 lCurPageModified : Boolean;
begin
 Case aPage of
  piAttr  : lCurPageModified := (cbNumber.Text <> '') or
                                (LowDateEdit.Date <> NullDate) or
                                (HighDateEdit.Date <> NullDate) or
                                (StatusBox.GroupCheckData <> 3);

  piAttr2 : lCurPageModified := Not SearchAttrExplorer.IsEmpty;
  piText  : lCurPageModified := TextSrchMemo.TextLen <> 0;
  piSpec  : lCurPageModified := (tblStage.Tag = 1) or (gbxStageStatus.Tag = 1) or
                                (edtStageDateBegin.Date <> NullDate) or
                                (edtStageDateEnd.Date <> NullDate);

  else
   lCurPageModified := False;
 end;

 If lCurPageModified
  then nbkSearchWhat.Pages[aPage].ImageIndex := 0
  else nbkSearchWhat.Pages[aPage].ImageIndex := -1;
end;

procedure TDocSearchDlg.nbkSearchWhatChanging(Sender: TObject; var AllowChange: Boolean);
var
 ErrPos : Word;
 CurPageModified : Boolean;
Begin
 SetPageModifyIcon(nbkSearchWhat.ActivePageIndex);

 If (nbkSearchWhat.ActivePageIndex = piText) and (TextSrchMemo.Buffer.S[0]<>#0)
  then
   Begin
    Try
     {SearchSCheck(TextSrchMemo.Buffer,ErrPos);}
    except
     AllowChange:=False;
     ActiveControl:=TextSrchMemo;
     Raise
    end;
   end;
end;

procedure TDocSearchDlg.cbNumberDropDown(Sender: TObject);
begin
 if cbNumber.Items.Count = 0 then
 begin
  Screen.Cursor:=crHourGlass;
  try
   DictServer(Family).GetNumberList(TDNType(cbDocType.ItemIndex),cbNumber.Items);
  finally
   Screen.Cursor:=crDefault;
  end;
 end;
end;

procedure TDocSearchDlg.sbANDSignClick(Sender: TObject);
begin
 TextSrchMemo.InsertBuf(l3PCharLen(' & '));
end;

procedure TDocSearchDlg.sbORSignClick(Sender: TObject);
begin
 TextSrchMemo.InsertBuf(l3PCharLen(' | '));
end;

procedure TDocSearchDlg.sbANDNOTSignClick(Sender: TObject);
begin
 TextSrchMemo.InsertBuf(l3PCharLen(' ~ '));
end;

procedure TDocSearchDlg.sbFLWSignClick(Sender: TObject);
begin
 TextSrchMemo.InsertBuf(l3PCharLen(' : '));
end;

Type
 PPChar = ^PAnsiChar;

function TDocSearchDlg.TSAddBrackets(Sender: TObject;
                                    Var B : PAnsiChar;
                                    Var L : Long;
                                    Var CharSet : SmallInt;
                                    Data : Pointer): Bool;
 var
  P : PAnsiChar;
 Begin
  Result := true;
  P := l3StrAlloc(L+2);
  StrLCopy(P+1, B, L);
  P[0]:='(';
  P[L+1]:=')';
  L:=L+2;
  PPChar(Data)^:=P;
  B:=P;
 end;

procedure TDocSearchDlg.sbBracketsClick(Sender: TObject);
var
 P : PAnsiChar;
begin
 if TextSrchMemo.HasSelection then
 begin
  TextSrchMemo.TextBufConvert(TSAddBrackets, @P);
  l3StrDispose(P);
 end
 else
  TextSrchMemo.InsertBuf(l3PCharLen(' ()'));
end;

procedure TDocSearchDlg.piItervalClick(Sender: TObject);
Var
 S : AnsiString;
begin
 Case TComponent(Sender).Tag of
  0   : S:='Д';
  255 : S:='А';
  254 : S:='П';
  else  S:=IntToStr(TComponent(Sender).Tag);
 end;

 S:=' '+InsOperation+S+' ';
 TextSrchMemo.InsertBuf(l3PCharLen(S));
end;

procedure TDocSearchDlg.sbANDSignIntervalClick(Sender: TObject);
begin
 InsOperation:='&';
end;

procedure TDocSearchDlg.sbFLWSignIntervalClick(Sender: TObject);
begin
 InsOperation:=':';
end;

procedure TDocSearchDlg.sbAsteriskSignClick(Sender: TObject);
begin
 TextSrchMemo.InsertBuf(l3PCharLen('*'));
end;

procedure TDocSearchDlg.sbQuestSignClick(Sender: TObject);
begin
 TextSrchMemo.InsertBuf(l3PCharLen('?'));
end;

Type
PPointer = ^Pointer;

procedure TDocSearchDlg.OKClick(Sender: TObject);
var
 l_Answer  : Integer;
 ErrPos    : Word;
 lAllQuery : TdtQuery;
begin
 If (nbkSearchWhat.ActivePageIndex = piText) and
    (TextSrchMemo.Buffer.S[0]<>#0) then
   try
    {SearchSCheck(TextSrchMemo.Buffer,ErrPos);}
   except
    {nbkSearchPages.PageIndex:=3;}
    ActiveControl:=TextSrchMemo;
    ModalResult:=mrNone;
    Raise
   end;

 try

  lAllQuery := MakeSearchQuery;
  try
   Application.ProcessMessages;
   Screen.Cursor := crHourGlass;
   try
    if lAllQuery.FoundList.Count > 0 then
     SetQuery(lAllQuery)
    else
    begin
     Screen.Cursor := crDefault;
     vtMessageDlg(l3CStr('Документов удовлетворяющих запросу не найдено.'), mtWarning, [mbCancel], 0);
     Self.ModalResult := mrNone;
     Exit;
    end;
   finally
    Screen.Cursor := crDefault;
   end;
  finally
   l3Free(lAllQuery);
  end;


 except
  on E : Exception do
  begin
   Application.ShowException(E);
   nbkSearchWhat.ActivePageIndex := piText;
   ActiveControl:=TextSrchMemo;
   ModalResult:=mrNone;
   Exit;
  end;
 end;

 if SearchDescriptor = '' then SearchDescriptor := 'Все документы';

 if cbxNewOnly.Checked or f_IsSpecification then
 begin
  fDestSrchWin := Nil;
  NewSearchWinName := SearchDescriptor;
 end
 else
  With TSearchResultDlg.Create(Self) do
   try
    ResultLabel.Caption:=Format(ResultLabel.Caption,[fQuery.FoundList.Count]);
    SrchWinList.Items.DataSize:=4;
    DefaultNameForZeroItem := SearchDescriptor;
    {If SearchDescriptor <> ''
     then SrchWinList.Items.Add(StringToPChar(SearchDescriptor))
     else}
    SrchWinList.Items.Add(l3StrNew('Новая выборка'));

    MainForm.GetChildFormList(SrchWinList.Items, [wtSrchWin], False);
    {$IFDEF InsiderTest}
    if Tl3BatchService.Instance.IsBatchMode then
    begin
     l_Answer := Tl3BatchService.Instance.PopAnswer;
     if l_Answer <> mrNone then
     begin
      Show;
      Tl3BatchService.Instance.SignalWasDialog;
     end // if l_Answer <> mrNone then
     else
      l_Answer := ShowModal;
    end // if g_BatchMode then
    else
    {$ENDIF InsiderTest}
     l_Answer := ShowModal;
    case l_Answer of
     mrOk     : Begin
                 fDestSrchWin := PPointer(SrchWinList.Items.Data[SrchWinList.Current])^;
                 NewSearchWinName := edtSrchWinName.Text;
                end;
     mrCancel : Self.ModalResult := mrNone;
    {mrRetry  : Self.ModalResult := mrNone;}
    end;
   finally
    Free;
   end;
end;

procedure TDocSearchDlg.cbxNewOnlyClick(Sender: TObject);
begin
IniRec.NewSrchOnly := cbxNewOnly.Checked;
end;

procedure TDocSearchDlg.tblStageGetCellData(Sender: TObject;
 RowNum: Longint; ColNum: Integer; var Data: Pointer;
 Purpose: TOvcCellDataPurpose);
var
 lStageID : TStageType;
Begin
 If (RowNum = 0) then Exit;
 lStageID := cStagesStringUserOrder[RowNum].rStageId;
 Case ColNum of
  0 : Begin
       Data := @cStagesStringUserOrder[RowNum].rName;
      end;

  1 : Begin
       If lStageID in aNotBeginStage
        then tmpInd := 1
        else
         If lStageID in aBeginStage
          then tmpInd := 2
          else
           If lStageID in aNotEndStage
            then tmpInd := 3
            else
             If lStageID in aEndStage
              then tmpInd := 4
              else tmpInd := 0;
       Data := @tmpInd;
      end;
 end;
end;

procedure TDocSearchDlg.tblStageDoneEdit(Sender: TObject; RowNum: Longint; ColNum: Integer);
var
 lStageID : TStageType;
Begin
 If ColNum <> 1 then Exit;
 lStageID := cStagesStringUserOrder[RowNum].rStageId;

 Exclude(aBeginStage,    lStageID);
 Exclude(aEndStage,      lStageID);
 Exclude(aNotEndStage,   lStageID);
 Exclude(aNotBeginStage, lStageID);

 Case tmpInd of
  0 : ;
  1 : Include(aNotBeginStage, lStageID);
  2 : Include(aBeginStage,    lStageID);
  3 : Include(aNotEndStage,   lStageID);
  4 : Include(aEndStage,      lStageID);
 end;
 tblStage.Tag := 1;
end;

procedure TDocSearchDlg.cbStageUnplugOnlyClick(Sender: TObject);
begin
If gbxStageStatus.Tag = 0
 then gbxStageStatus.Tag := 1
 else gbxStageStatus.Tag := 0;
end;

procedure TDocSearchDlg.tblStageExit(Sender: TObject);
begin
tblStage.StopEditingState(true);
end;

procedure TDocSearchDlg.edtTxt1Change(Sender: TObject);
begin
 edtTxt1.Tag := 1;
end;

procedure TDocSearchDlg.FormCreate(Sender: TObject);
var
 I: Integer;
begin
 with nbkSearchWhat do
  begin
   Pages[piAttr].HelpContext  := hcSearchAttr;
   Pages[piAttr2].HelpContext := hcSearchClass;
   Pages[piText].HelpContext := hcSearchText;
   Pages[piSpec].HelpContext := hcSearchSpec;
  end;
 //SearchAttrExplorer.ExpMode := emSearch;
 //SearchAttrExplorer.AttrManager.AttrOperateMode := aomSearch;
 for I := 0 to cMaxUrgency do
  cbUrgency.Items.Add(cUrgencyCaption[I]);
end;


procedure TDocSearchDlg.WMDropAccept(var Message: TMessage);
var
 lCount : Integer;
begin
 If ((TDragDataSupport.Instance.DragDataType = Ord(ddDragObj)) or
    (TDragDataSupport.Instance.DragDataType = Ord(ddDictItem))) and
    (TControl(Message.lParam) = SearchAttrExplorer.otlAttributes) then
  begin
   lCount := 0;

   SearchAttrExplorer.DDSupportDropAcceptHandler(lCount);

   If lCount = 0 then
    vtMessageDlg(l3CStr(@sidNotCompatibleData), mtError)
   else
   begin
    vtMessageDlg(l3Fmt(sidDocsAdded,[lCount]),mtInformation);
    Message.Result:=1;
   end;
  end;
end;

procedure TDocSearchDlg.cbxWithEqualsClick(Sender: TObject);

 procedure IterHandler(CurNode : Il3Node); far;
 begin
  with CurNode as IListDocAttribute do
   if AttrID2DLType(AttrID) in c_DictWithEquals then
    Modified := True;
 end;

begin
 SearchAttrExplorer.otlAttributes.IterateF(Tl3NodeAction(l3L2FA(@IterHandler)), imOneLevel);
end;

procedure TDocSearchDlg.FormShow(Sender: TObject);
begin
 inherited;
 evSetTextParaLimit(TextSrchMemo.TextSource, 1);
end;

procedure TDocSearchDlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 inherited;
 UserConfig.Section := PrefSectName;
 UserConfig.WriteFormPlace(SrchDlgFormPlaceName, Self);
end;

end.


