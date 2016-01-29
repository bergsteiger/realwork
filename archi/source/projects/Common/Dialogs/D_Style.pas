unit D_Style;

{$Include l3Define.inc}

{ $Id: D_Style.pas,v 1.39 2015/04/28 15:05:16 lulin Exp $ }

interface

uses
 WinTypes, 
 WinProcs, 

 SysUtils,
 Classes,  
 Graphics, 
 Forms,
 Dialogs, 
 Controls, 
 Buttons,
 StdCtrls, 
 ExtCtrls,
 ImgList,
 ComCtrls, 
 
 TB97Ctls,  

 RXCtrls,  
 RxCombos,  

 vtSpin,
 vtlister, 
 vtStringLister,
 vtOutliner, 
 vtCtrls,

 l3Types,
 l3Forms,
 l3TreeInterfaces,
 
 k2Tags,

 OvcBase, 
 
 evConst,  
 evTypes,  
 evEditor, 
 evdTypes,
 evMemo,
 evInterface,
 evEditorWindow,  
 evButton,
 evStyleTableTools,
 evMultiSelectEditorWindow, 
 evCustomEditor, 
 evEditorWithOperations,
 evStyleInterfaceEx, 

 afwControl,
 afwInputControl, evCustomMemo, afwControlPrim, afwBaseControl, nevControl, vtColorBox,
  evCustomEditorWindowModelPart, evCustomEdit, elCustomEdit,
  elCustomButtonEdit, ctButtonEdit, ctAbstractEdit, AbstractDropDown, DropDownTree,
  EditableBox, FakeBox, evCustomEditorWindowPrim, evCustomEditorWindow,
  evCustomEditorModelPart 
 ;

type
  TStyleDesignDlg = class(Tl3Form, Il3NodeNotifyRecipient)
    OKBtn     : TBitBtn;
    HelpBtn   : TBitBtn;

    Label1: TLabel;
    Panel1: TPanel;
    StyleEdit: TEdit;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    lbFontName: TLabel;
    lbFontSize: TLabel;
    lbFontColor: TLabel;
    sbFontNameInherit: TSpeedButton;
    sbFontSizeInherit: TSpeedButton;
    sbFontColorInherit: TSpeedButton;
    sbFontBoldInherit: TSpeedButton;
    sbFontItalicInherit: TSpeedButton;
    sbFontUnderlineInherit: TSpeedButton;
    sbBackColorInherit: TSpeedButton;
    lbBackColor: TLabel;
    sbVisibleInherit: TSpeedButton;
    sbFontStrikeoutInherit: TSpeedButton;
    cbColor: TvtColorBox;
    FontSizeEdit: TvtSpinEdit;
    FontCombo: TComboBox;
    chbBold: TCheckBox;
    chbItalic: TCheckBox;
    chbUnderline: TCheckBox;
    cbBackColor: TvtColorBox;
    chbVisible: TCheckBox;
    chbStrikeout: TCheckBox;
    GroupBox3: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    MeasureLabel1: TLabel;
    MeasureLabel2: TLabel;
    MeasureLabel3: TLabel;
    sbLeftJstF: TSpeedButton;
    sbWideJstF: TSpeedButton;
    sbRightJstF: TSpeedButton;
    sbCenterJstF: TSpeedButton;
    sbParaJustInherit: TSpeedButton;
    sbParaLeftInherit: TSpeedButton;
    sbParaFirstInherit: TSpeedButton;
    sbParaWidthInherit: TSpeedButton;
    sbJustifyPreformatted: TSpeedButton;
    EditParaWidth: TvtSpinEdit;
    EditFirstLineMargin: TvtSpinEdit;
    EditLeftMargin: TvtSpinEdit;
    Bevel1: TBevel;
    ExamplePanel: TevMemo;
    StylesOutliner: TvtOutliner;
    GrpStyle: TRadioGroup;
    sbStyleTypeInherit: TButton;
    chbVisibleUser: TCheckBox;
    procedure FontSizeEditChange(Sender: TObject);
    procedure cbColorChange(Sender: TObject);
    procedure chbUnderlineClick(Sender: TObject);
    procedure chbBoldClick(Sender: TObject);
    procedure chbItalicClick(Sender: TObject);
    procedure FontComboChange(Sender: TObject);
    procedure GrpStyleClick(Sender: TObject);
    procedure sbJstFClick(Sender: TObject);
    procedure EditParaWidthChange(Sender: TObject);
    procedure EditFirstLineMarginChange(Sender: TObject);
    procedure EditLeftMarginChange(Sender: TObject);
    procedure sbInheritClick(Sender: TObject);
    procedure sbParaInheritClick(Sender: TObject);
    procedure chbVisibleClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure chbStrikeoutClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure StylesOutlinerCurrentChanged(Sender: TObject; aNewCurrent,
      aOldCurrent: Integer);
    function StylesOutlinerGetItemImage(Sender: TObject; Index: Integer;
      var aImages: TCustomImageList): Integer;
    procedure StylesOutlinerNodeMoveEnd(Sender: TObject;
      const CNode: Il3SimpleNode; aParentWasChange: Boolean);
    procedure StylesOutlinerGetItemColor(Sender: TObject; Index: Integer;
      var FG, BG: TColor);
    procedure chbVisibleUserClick(Sender: TObject);
  private
    f_Deleting: Boolean;
    RecurStop        : Integer;
    SetStyleInProgress : Boolean;
    f_StyleInterface  : TevStyleInterfaceEx;
    f_InheritanceBtns : array [Tk2FontParam] of TSpeedButton;
    f_Initializing: Boolean;
    f_NodeMoving: Boolean;
    function  pm_GetIndentType: TevIndentType;
    procedure pm_SetIndentType(Value: TevIndentType);
      {-}
    function GetCaption(const Sender: TObject): string;
      {* - Возвращает текст элемента. }
    procedure SetCaption(const Sender: TObject; aValue: TevInheritance);
      {* - Устанавливает текст элементу. }
    procedure ConvertChars(toChars: Bool);
    procedure SelectCurrentStyle;
    procedure SetStyleParam;
    procedure UpdateStyleType;
    property IndentType: TevIndentType
      read pm_GetindentType
      write pm_SetIndentType;
      {-}
    procedure Notify(aOperation : Integer; const aNode : Il3SimpleNode);
  public
    {$IfDef InsiderTest}
     g_AllowModal : Integer;
      {-}
    function ShowModal: integer;
      override;
      {-}
    {$IfDef l3HackedVCL}
    function NeedCancelModal: Boolean;
      override;
      {-}
    {$EndIf l3HackedVCL}
   {$EndIf InsiderTest}
    procedure SaveStyleParam(aStyleID: Integer = MaxInt; aParentName: string = '');
    constructor Create(AOwner: TComponent); //override;
    procedure Cleanup; override;
  end;

 procedure RunStyleEditor;

implementation

{$IFDEF Archi}
{$INCLUDE ArchiDefine.inc}
{$ENDIF Archi}

uses
{$IFDEF Archi}
 Main,
 ResShop,
 HelpCnst,
{$ELSE}
 MainEditor,
{$IFDEF EverestLite}
 dmStdResLite,
{$ELSE}
 dmStdRes,
{$ENDIF EverestLite}
{$ENDIF Archi}

 vtStdRes,

 k2Base,
 k2Facade,

{$IFDEF InsiderTest}
 afwAnswer,
 seModalSupport,
{$ENDIF InsiderTest}

 l3Base,
 l3Units,
 l3Nodes,
 l3String,
 l3Tree_TLB,
 l3UnitsTools,
 l3BatchService,

 evDef,
 evDisp,
 {$IFDEF ARCHI_OLD_EVEREST}
 evFontInterface,
 {$ELSE}
 evFont,
 {$ENDIF ARCHI_OLD_EVEREST}
 evdStyles,
 evStyleInterface,
 evStandardActions,
 evEditorInterfaces,

 TextPara_Const,
 k2Bool_Const
 ;

{$R *.DFM}

const   
 cInheritance : array [TevInheritance] of Char = ('С', 'П', 'Р');
 cInheritanceHint : array [TevInheritance] of string =
                    ('Собственный параметр',
                     'Прозрачный',
                     'Наследуется от родительского стиля'); 
 cOwnChar = 'С';
 cTransparentChar = 'П';
 cParentChar = 'Р';
 cSystemFontName = 'System';
 cStyleHasChild = 'У этого стиля есть дети. Его нельзя удалять.';
 cSymbolsStr = 'символы';
{$IFNDEF Archi}
 picStylePara   = 22;
 picStyleInterv = 23;
{$ENDIF Archi} 


function Char2Inheritance(Ch: Char): TevInheritance;
var
 i : TevInheritance;
begin
 for i := Low(TevInheritance) to High(TevInheritance) do
 begin
  Result := i;
  if (cInheritance[i] = Ch) then Break;
 end;
end;

procedure sbSetParam(aButton: TButton; anInheritance: TevInheritance); overload;
begin
 with aButton do 
 begin
  Caption := cInheritance[anInheritance];
  ShowHint := False;
  Hint := cInheritanceHint[anInheritance];
  ShowHint := True;
 end;//with aButton
end;

procedure sbSetParam(aButton: TSpeedButton; anInheritance: TevInheritance); overload;
begin
 with aButton do 
 begin
  Caption := cInheritance[anInheritance];
  ShowHint := False;
  Hint := cInheritanceHint[anInheritance];
  ShowHint := True;
 end;//with aButton
end;

procedure RunStyleEditor;
begin
 with TStyleDesignDlg.Create(MainForm) do
  try
   if (ShowModal = mrOk) then
   begin
    SaveStyleParam;
    {$IFNDEF Archi}
    {$IFDEF evNeedEverestTxt}
    MainForm.EverestWriter.Binary := cbSaveBinary.Checked; 
    {$ENDIF evNeedEverestTxt}
    {$ENDIF Archi}
    f_StyleInterface.Save(MainForm.EverestWriter);
   end;{ShowModal = mrOk}
  except
   Free;
  end;{try..except}
end;

constructor TStyleDesignDlg.Create(AOwner: TComponent);
begin
 f_Initializing := True;
 try
  f_StyleInterface := TevStyleInterfaceEx.Create;
  f_StyleInterface.SelectStyledObjectType(k2_typTextPara);
  inherited Create(AOwner);
  {$IFDEF Archi}
  StylesOutliner.Images := ArchiResources.CommonImageList;
  {$ELSE}
  StylesOutliner.Images := dmStandardRes.ilCommon;
  {$ENDIF Archi}

  f_InheritanceBtns[k2_tiSize] := sbFontSizeInherit;
  f_InheritanceBtns[k2_tiBold] := sbFontBoldInherit;
  f_InheritanceBtns[k2_tiItalic] := sbFontItalicInherit;
  f_InheritanceBtns[k2_tiUnderline] := sbFontUnderlineInherit;
  f_InheritanceBtns[k2_tiStrikeout] := sbFontStrikeoutInherit;
  f_InheritanceBtns[k2_tiName] := sbFontNameInherit;
  f_InheritanceBtns[k2_tiForeColor] := sbFontColorInherit;
  f_InheritanceBtns[k2_tiBackColor] := sbBackColorInherit;

  GetFontList(FontCombo.Items);
  try
   f_StyleInterface.Load(MainForm.EverestReader);
  except
  end;{try..except}

  with StylesOutliner do
  try
   CTree.CRootNode := f_StyleInterface.MakeStylesTreeRoot([]) as Il3RootNode;
   CTree.CRootNode.As_Il3ChangeNotifier.Subscribe(Il3NodeNotifyRecipient(Self));
   ExpandNodeOnDeep(CTree.RootNode);
  except
   CTree.RootNode := nil;
  end;{try..except}
  f_NodeMoving := False;
 finally
  f_Initializing := False;
 end;
end;

procedure TStyleDesignDlg.Cleanup;
begin
  inherited Cleanup;
  l3Free(f_StyleInterface);
end;

procedure TStyleDesignDlg.SaveStyleParam(aStyleID: Integer = MaxInt; aParentName: string = '');
begin
 if (StylesOutliner.Current >= 0) then
 begin
  if aStyleID <> MaxInt then
   f_StyleInterface.SelectStyle(aStyleID)
  else
   f_StyleInterface.SelectStyle((StylesOutliner.CurrentCNode as Il3HandleNode).Handle);

  f_StyleInterface.Changing;
  try
   f_StyleInterface.VisibleToUser := chbVisibleUser.Checked;

   if aParentName <> '' then
    f_StyleInterface.ParentName := aParentName;
   f_StyleInterface.Name := StyleEdit.Text;
   case Char2Inheritance(sbFontNameInherit.Caption[1]) of
    ev_iOwn : f_StyleInterface.Font.Name := ExamplePanel.Font.Name;
    ev_iTransparent : f_StyleInterface.Font.IsTransparent[k2_tiName] := true;
    ev_iParent : f_StyleInterface.Font.IsOwn[k2_tiName] := false;
   end;
   case Char2Inheritance(sbFontColorInherit.Caption[1]) of
    ev_iOwn : f_StyleInterface.Font.ForeColor := ExamplePanel.Font.Color;
    ev_iTransparent : f_StyleInterface.Font.IsTransparent[k2_tiForeColor] := true;
    ev_iParent : f_StyleInterface.Font.IsOwn[k2_tiForeColor] := false;
   end;
   case Char2Inheritance(sbBackColorInherit.Caption[1]) of
    ev_iOwn : f_StyleInterface.Font.BackColor := ExamplePanel.TextPara.Font.BackColor;
    ev_iTransparent : f_StyleInterface.Font.IsTransparent[k2_tiBackColor] := true;
    ev_iParent : f_StyleInterface.Font.IsOwn[k2_tiBackColor] := false;
   end;
   case Char2Inheritance(sbFontSizeInherit.Caption[1]) of
    ev_iOwn : f_StyleInterface.Font.Size := ExamplePanel.Font.Size;
    ev_iTransparent : f_StyleInterface.Font.IsTransparent[k2_tiSize] := true;
    ev_iParent : f_StyleInterface.Font.IsOwn[k2_tiSize] := false;
   end;
   case Char2Inheritance(sbFontBoldInherit.Caption[1]) of
    ev_iOwn : f_StyleInterface.Font.Bold := (chbBold.State = cbChecked);
    ev_iTransparent : f_StyleInterface.Font.IsTransparent[k2_tiBold] := true;
    ev_iParent : f_StyleInterface.Font.IsOwn[k2_tiBold] := false;
   end;
   case Char2Inheritance(sbFontItalicInherit.Caption[1]) of
    ev_iOwn : f_StyleInterface.Font.Italic := (chbItalic.State = cbChecked);
    ev_iTransparent : f_StyleInterface.Font.IsTransparent[k2_tiItalic] := true;
    ev_iParent : f_StyleInterface.Font.IsOwn[k2_tiItalic] := false;
   end;
   case Char2Inheritance(sbFontUnderlineInherit.Caption[1]) of
    ev_iOwn : f_StyleInterface.Font.Underline := (chbUnderline.State = cbChecked);
    ev_iTransparent : f_StyleInterface.Font.IsTransparent[k2_tiUnderline] := true;
    ev_iParent : f_StyleInterface.Font.IsOwn[k2_tiUnderline] := false;
   end;
   case Char2Inheritance(sbFontStrikeoutInherit.Caption[1]) of
    ev_iOwn : f_StyleInterface.Font.Strikeout := (chbStrikeout.State = cbChecked);
    ev_iTransparent : f_StyleInterface.Font.IsTransparent[k2_tiStrikeout] := true;
    ev_iParent : f_StyleInterface.Font.IsOwn[k2_tiStrikeout] := false;
   end;
   case Char2Inheritance(sbVisibleInherit.Caption[1]) of
    ev_iOwn : f_StyleInterface.Visible := (chbVisible.State = cbChecked);
    ev_iTransparent : f_StyleInterface.IsTransparent[k2_tiVisible] := true;
    ev_iParent : f_StyleInterface.IsOwn[k2_tiVisible] := false;
   end;

   case Char2Inheritance(sbStyleTypeInherit.Caption[1]) of
    ev_iOwn  :
     begin
      f_StyleInterface.IsOwn[k2_tiApply2Para] := True;
      f_StyleInterface.Apply2Para := (GrpStyle.ItemIndex = 0);
     end;
    ev_iParent : f_StyleInterface.IsOwn[k2_tiApply2Para] := false;
   end;

   if (Char2Inheritance(sbParaJustInherit.Caption[1]) = ev_iOwn) then
    f_StyleInterface.IndentType := Ord(IndentType);
   if sbJustifyPreformatted.Down then
   begin
    if (Char2Inheritance(sbParaLeftInherit.Caption[1]) = ev_iOwn) then
     f_StyleInterface.LeftIndent := evChar2Inch(EditLeftMargin.AsInteger);
    if (Char2Inheritance(sbParaFirstInherit.Caption[1]) = ev_iOwn) then
     f_StyleInterface.FirstIndent := evChar2Inch(EditFirstLineMargin.AsInteger);
    if (Char2Inheritance(sbParaWidthInherit.Caption[1]) = ev_iOwn) then
     f_StyleInterface.Width := evChar2Inch(EditParaWidth.AsInteger) + f_StyleInterface.LeftIndent;
   end
   else 
   begin
    if (Char2Inheritance(sbParaLeftInherit.Caption[1]) = ev_iOwn) then
     f_StyleInterface.LeftIndent := Round(EditLeftMargin.Value * evInchMul / evCmPerInch);
    if (Char2Inheritance(sbParaFirstInherit.Caption[1]) = ev_iOwn) then
     f_StyleInterface.FirstIndent := Round(EditFirstLineMargin.Value * evInchMul / evCmPerInch);
    if (Char2Inheritance(sbParaWidthInherit.Caption[1]) = ev_iOwn) then
     f_StyleInterface.Width := Round(EditParaWidth.Value * evInchMul / evCmPerInch) +
                                           f_StyleInterface.LeftIndent;
   end;
  finally
   f_StyleInterface.Changed;
  end;//try..finally
 end;{StyleList.Current >= 0}
end;

function TStyleDesignDlg.pm_GetIndentType: TevIndentType;
begin
 if sbLeftJstF.Down then 
  Result := ev_itLeft
  else
   if sbRightJstF.Down then 
    Result := ev_itRight
   else
    if sbCenterJstF.Down then 
     Result := ev_itCenter
    else
     if sbWideJstF.Down then 
      Result := ev_itWidth
     else
      if sbJustifyPreformatted.Down then 
       Result := ev_itPreformatted
      else 
       Result := ev_itLeft;
end;

procedure TStyleDesignDlg.pm_SetIndentType(Value: TevIndentType);
  {-}
begin
 case Value of
  ev_itLeft   : sbLeftJstF.Down := True;
  ev_itRight  : sbRightJstF.Down := True;
  ev_itCenter : sbCenterJstF.Down := True;
  ev_itWidth  : sbWideJstF.Down := True;
  ev_itPreformatted : sbJustifyPreformatted.Down := True;
 end;
end;

procedure TStyleDesignDlg.SetStyleParam;
var
 i            : Tk2FontParam;
 l_IndentType : TevIndentType;
begin
 if not SetStyleInProgress then
 begin
  SetStyleInProgress := True;
  try
   // отображать стиль в списке используемый
   chbVisibleUser.Checked := f_StyleInterface.VisibleToUser;

   StyleEdit.Text := f_StyleInterface.Name;

   FontCombo.Text := f_StyleInterface.Font.Name;
   FontComboChange(nil); // Приходится вызывать явно...
   FontSizeEdit.AsInteger := f_StyleInterface.Font.Size;

   cbBackColor.Selected := f_StyleInterface.Font.BackColor;
   cbColorChange(cbBackColor); // Приходится вызывать явно...

   cbColor.Selected := f_StyleInterface.Font.ForeColor;
   cbColorChange(cbColor); // Приходится вызывать явно...

   Inc(RecurStop);
   try
    chbBold.Checked := f_StyleInterface.Font.Bold;
    chbItalic.Checked := f_StyleInterface.Font.Italic;
    chbUnderline.Checked := f_StyleInterface.Font.Underline;
    chbStrikeout.Checked := f_StyleInterface.Font.Strikeout;
    chbVisible.Checked := f_StyleInterface.Visible;
{$IFDEF ARCHI_OLD_EVEREST}
    evOperationDispatcher.SetOpIntegerData(ev_ccBold, Ord(chbBold.Checked));
    evOperationDispatcher.SetOpIntegerData(ev_ccItalic, Ord(chbItalic.Checked));
    evOperationDispatcher.SetOpIntegerData(ev_ccUnderline, Ord(chbUnderline.Checked));
    evOperationDispatcher.SetOpIntegerData(ev_ccStrikeout, Ord(chbStrikeout.Checked));
    evOperationDispatcher.SetOpIntegerData(ev_ccVisible, Ord(chbVisible.Checked));
{$ENDIF ARCHI_OLD_EVEREST}
   finally
    Dec(RecurStop);
   end;{try..finally}

   for i := Low(Tk2FontParam) to High(Tk2FontParam) do 
   begin
    if (f_InheritanceBtns[i] <> nil) then
    begin
     f_InheritanceBtns[i].Caption := cInheritance[f_StyleInterface.Font.Inheritance[Ord(i)]];
     f_InheritanceBtns[i].Hint := cInheritanceHint[f_StyleInterface.Font.Inheritance[Ord(i)]];
    end;
   end;{for i}

   l_IndentType := TevIndentType(f_StyleInterface.IndentType);
   IndentType := l_IndentType;
   ExamplePanel.TextPara.Formatting.HorizontalAligment := TedHorizontalAligment(Ord(l_IndentType) + 1);
   ExamplePanel.TextPara.Font.BackColor := cbBackColor.Selected;
{$IFDEF ARCHI_OLD_EVEREST}
   evOperationDispatcher.SetOpIntegerData(TevOperation(Ord(ev_ccJustifyLeft) + Ord(l_IndentType)), Ord(True));
{$ENDIF ARCHI_OLD_EVEREST}

   ConvertChars(False); // чтобы установить сантиметры в качестве единиц измерения

   // значения устанавливаются в сантиметрах
   EditLeftMargin.Value := f_StyleInterface.LeftIndent / evInchMul * evCmPerInch;
   EditFirstLineMargin.Value := f_StyleInterface.FirstIndent / evInchMul * evCmPerInch;
   EditParaWidth.Value :=
    (f_StyleInterface.Width - f_StyleInterface.LeftIndent) / evInchMul * evCmPerInch;

   // и конвертируются в символы, если это необходимо...
   if (IndentType = ev_itPreformatted) then
    ConvertChars(True);

   with sbParaJustInherit do
   begin
    Caption := cInheritance[f_StyleInterface.Inheritance[Ord(k2_tiJustification)]];
    Hint := cInheritanceHint[f_StyleInterface.Font.Inheritance[Ord(i)]];
   end;
   with sbParaLeftInherit do
   begin
    Caption := cInheritance[f_StyleInterface.Inheritance[Ord(k2_tiLeftIndent)]];
    Hint := cInheritanceHint[f_StyleInterface.Inheritance[Ord(k2_tiLeftIndent)]];
   end;
   with sbParaFirstInherit do
   begin
    Caption := cInheritance[f_StyleInterface.Inheritance[Ord(k2_tiFirstIndent)]];
    Hint := cInheritanceHint[f_StyleInterface.Inheritance[Ord(k2_tiFirstIndent)]];
   end;
   with sbParaWidthInherit do
   begin
    Caption := cInheritance[f_StyleInterface.Inheritance[Ord(k2_tiWidth)]];
    Hint := cInheritanceHint[f_StyleInterface.Inheritance[Ord(k2_tiWidth)]];
   end;
   with sbStyleTypeInherit do
   begin
    Caption := cInheritance[f_StyleInterface.Inheritance[Ord(k2_tiApply2Para)]];
    Hint := cInheritanceHint[f_StyleInterface.Inheritance[Ord(k2_tiApply2Para)]];
   end;
   with sbVisibleInherit do
   begin
    Caption := cInheritance[f_StyleInterface.Inheritance[Ord(k2_tiVisible)]];
    Hint := cInheritanceHint[f_StyleInterface.Inheritance[Ord(k2_tiVisible)]];
   end;

   if f_StyleInterface.Apply2Para then
    GrpStyle.ItemIndex := 0
   else
    GrpStyle.ItemIndex := 1;
   UpdateStyleType;

  finally
   SetStyleInProgress := False;
  end;{try..finally}
 end;{not SetStyleInProgress}
end;

procedure TStyleDesignDlg.FontComboChange(Sender: TObject);
var
 Ind : Integer;
begin
 if FontCombo.Text = '' then
  sbFontNameInherit.Caption := cInheritance[ev_iTransparent]
 else 
 begin
  sbFontNameInherit.Caption := cInheritance[ev_iOwn];
  Ind := FontCombo.Items.IndexOf(FontCombo.Text);
  if Ind >= 0 then
   ExamplePanel.Font.Name := FontCombo.Text
  else
   ExamplePanel.Font.Name := cSystemFontName;
 end;
end;

procedure TStyleDesignDlg.FontSizeEditChange(Sender: TObject);
begin
 if (FontSizeEdit.AsInteger = 0) then
 begin
  ExamplePanel.Font.Size:=10;
  sbFontSizeInherit.Caption:= cInheritance[ev_iTransparent];
 end 
 else 
 begin
  ExamplePanel.Font.Size :=FontSizeEdit.AsInteger;
  sbFontSizeInherit.Caption := cInheritance[ev_iOwn];
 end;
end;

procedure TStyleDesignDlg.cbColorChange(Sender: TObject);
begin
 if (Sender = cbColor) then
 begin
  ExamplePanel.Font.Color := cbColor.Selected;
  sbFontColorInherit.Caption := cInheritance[ev_iOwn];
 end
 else
 begin
  ExamplePanel.TextPara.Font.BackColor := cbBackColor.Selected;
  ExamplePanel.TextPara.Font.BackColor := cbBackColor.Selected;
  sbBackColorInherit.Caption := cInheritance[ev_iOwn];
 end;
end;

procedure TStyleDesignDlg.chbBoldClick(Sender: TObject);
begin
 if RecurStop = 0 then
  sbFontBoldInherit.Caption := cInheritance[ev_iOwn];
 if chbBold.Checked then
  ExamplePanel.Font.Style := ExamplePanel.Font.Style + [fsBold]
 else
  ExamplePanel.Font.Style := ExamplePanel.Font.Style - [fsBold];
{$IFDEF ARCHI_OLD_EVEREST}
  evOperationDispatcher.SetOpIntegerData(ev_ccBold, Ord(chbBold.Checked));
{$ENDIF ARCHI_OLD_EVEREST}  
end;

procedure TStyleDesignDlg.chbItalicClick(Sender: TObject);
begin
 if RecurStop = 0 then
  sbFontItalicInherit.Caption := cInheritance[ev_iOwn];
 if chbItalic.Checked then
  ExamplePanel.Font.Style:=ExamplePanel.Font.Style + [fsItalic]
 else
  ExamplePanel.Font.Style:=ExamplePanel.Font.Style - [fsItalic];
{$IFDEF ARCHI_OLD_EVEREST}
 evOperationDispatcher.SetOpIntegerData(ev_ccItalic, Ord(chbItalic.Checked));
{$ENDIF ARCHI_OLD_EVEREST}
end;

procedure TStyleDesignDlg.chbUnderlineClick(Sender: TObject);
begin
 if (RecurStop = 0) then
  sbFontUnderlineInherit.Caption:= cInheritance[ev_iOwn];
 if chbUnderline.Checked then
  ExamplePanel.Font.Style := ExamplePanel.Font.Style + [fsUnderline]
 else
  ExamplePanel.Font.Style := ExamplePanel.Font.Style - [fsUnderline];
{$IFDEF ARCHI_OLD_EVEREST}
 evOperationDispatcher.SetOpIntegerData(ev_ccUnderline, Ord(chbUnderline.Checked));
{$ENDIF ARCHI_OLD_EVEREST}
end;

procedure TStyleDesignDlg.GrpStyleClick(Sender: TObject);
begin
 if GrpStyle.Tag < 0 then
  Exit;
 GrpStyle.Tag := -1;
 try
  sbStyleTypeInherit.Caption := cInheritance[ev_iOwn];
  UpdateStyleType;
 finally
  GrpStyle.Tag := 0;
 end;
end;

procedure TStyleDesignDlg.ConvertChars(toChars: Bool);
begin
 Inc(RecurStop);
 try
  if toChars then 
  begin
   MeasureLabel1.Caption := cSymbolsStr;
   if MeasureLabel2.Caption = MeasureLabel1.Caption then Exit;
   MeasureLabel2.Caption := MeasureLabel1.Caption;
   MeasureLabel3.Caption := MeasureLabel1.Caption;

   EditLeftMargin.Value      := evInch2Char(Round(EditLeftMargin.Value / evCmPerInch * evInchMul));
   EditFirstLineMargin.Value := evInch2Char(Round(EditFirstLineMargin.Value / evCmPerInch * evInchMul));
   EditParaWidth.Value        := evInch2Char(Round(EditParaWidth.Value / evCmPerInch * evInchMul));

   EditLeftMargin.Decimal := 0;
   EditFirstLineMargin.Decimal := 0;
   EditParaWidth.Decimal := 0;

   EditLeftMargin.Increment := 1;
   EditFirstLineMargin.Increment := 1;
   EditParaWidth.Increment := 1;
  end 
  else 
  begin
   MeasureLabel1.Caption := 'см';
   if MeasureLabel2.Caption = MeasureLabel1.Caption then
    Exit;
   MeasureLabel2.Caption := MeasureLabel1.Caption;
   MeasureLabel3.Caption := MeasureLabel1.Caption;

   EditLeftMargin.Value      := evChar2Inch(EditLeftMargin.AsInteger) / evInchMul * evCmPerInch;
   EditFirstLineMargin.Value := evChar2Inch(EditFirstLineMargin.AsInteger) / evInchMul * evCmPerInch;
   EditParaWidth.Value        := evChar2Inch(EditParaWidth.AsInteger) / evInchMul * evCmPerInch;

   EditLeftMargin.Decimal := 2;
   EditFirstLineMargin.Decimal := 2;
   EditParaWidth.Decimal := 2;

   EditLeftMargin.Increment := 0.1;
   EditFirstLineMargin.Increment := 0.1;
   EditParaWidth.Increment := 0.1;
  end;
 finally
  Dec(RecurStop);
 end;
end;

procedure TStyleDesignDlg.sbJstFClick(Sender: TObject);
var
 l_IndentType : TevIndentType;
begin
 l_IndentType := TevIndentType(IndentType);
 {$IFDEF ARCHI_OLD_EVEREST}!
 evOperationDispatcher.SetOpIntegerData(TevOperation(Ord(ev_ccJustifyLeft) + Ord(l_IndentType)), Ord(True));
 {$ENDIF ARCHI_OLD_EVEREST}
 sbParaJustInherit.Caption := cInheritance[ev_iOwn];
 ConvertChars(sbJustifyPreformatted.Down);
 ExamplePanel.TextPara.Formatting.HorizontalAligment := TedHorizontalAligment(Succ(Ord(l_IndentType)));
end;

procedure TStyleDesignDlg.EditParaWidthChange(Sender: TObject);
begin
 if RecurStop = 0 then
  sbParaWidthInherit.Caption := cInheritance[ev_iOwn];
end;

procedure TStyleDesignDlg.EditFirstLineMarginChange(Sender: TObject);
begin
 if RecurStop = 0 then 
  sbParaFirstInherit.Caption := cInheritance[ev_iOwn];
end;

procedure TStyleDesignDlg.EditLeftMarginChange(Sender: TObject);
begin
 if RecurStop = 0 then
  sbParaLeftInherit.Caption := cInheritance[ev_iOwn];
end;

procedure TStyleDesignDlg.sbInheritClick(Sender: TObject);
var
 l_Caption: string;
begin
 if RecurStop > 0 then Exit;
 Inc(RecurStop);
 SelectCurrentStyle;
 try
  l_Caption := GetCaption(Sender);
  case l_Caption[1] of
   cOwnChar :
    if f_StyleInterface.IsDefault then
     SetCaption(Sender, ev_iTransparent)
    else
     SetCaption(Sender, ev_iParent);
   cParentChar :
    SetCaption(Sender, ev_iTransparent);
   cTransparentChar :
    SetCaption(Sender, ev_iOwn);
  end;
  SaveStyleParam;
  SetStyleParam;
 finally
  Dec(RecurStop);
 end;
end;

procedure TStyleDesignDlg.sbParaInheritClick(Sender: TObject);
var
 l_Caption: string;
begin
 if RecurStop > 0 then Exit;
 Inc(RecurStop);
 try
  l_Caption := GetCaption(Sender);
  case l_Caption[1] of
   cOwnChar : SetCaption(Sender, ev_iParent);
   cParentChar : SetCaption(Sender, ev_iOwn);
  end;
  SelectCurrentStyle;
  SaveStyleParam;
  SetStyleParam;
 finally
  Dec(RecurStop);
 end;
end;
 
procedure TStyleDesignDlg.chbVisibleClick(Sender: TObject);
begin
 if (RecurStop = 0) then sbVisibleInherit.Caption:= cInheritance[ev_iOwn];

 {$IFDEF ARCHI_OLD_EVEREST}
 if chbVisible.Checked then
  ExamplePanel.Color := cbBackColor.Selected
 else
  ExamplePanel.Color := def_InvisibleColor;
 evOperationDispatcher.SetOpIntegerData(ev_ccVisible, Ord(chbVisible.Checked));
 {$ELSE}
 with ExamplePanel do
  Document.Para[0].Range.Formatting.Modify(View).SetAtom(View, k2_tiVisible, k2_typBool.MakeTag(Ord(chbVisible.Checked)).AsObject, nil);
 {$ENDIF ARCHI_OLD_EVEREST}
end;

procedure TStyleDesignDlg.FormDeactivate(Sender: TObject);
begin
 evOperationDispatcher.ExcludeOperations(evJustifyCommands);
 evOperationDispatcher.ExcludeOperations(evFontCommands);
 evOperationDispatcher.ExcludeOperations([ev_ccInsert, ev_ccDelete]);
end;

procedure TStyleDesignDlg.FormActivate(Sender: TObject);
begin
 evOperationDispatcher.IncludeOperations(evFontCommands);
 evOperationDispatcher.IncludeOperations([ev_ccInsert, ev_ccDelete]);
end;

procedure TStyleDesignDlg.chbStrikeoutClick(Sender: TObject);
begin
 if (RecurStop = 0) then
  sbFontStrikeoutInherit.Caption:= cInheritance[ev_iOwn];
 if chbStrikeout.Checked then
  ExamplePanel.Font.Style := ExamplePanel.Font.Style + [fsStrikeout]
 else
  ExamplePanel.Font.Style := ExamplePanel.Font.Style - [fsStrikeout];
 {$IFDEF ARCHI_OLD_EVEREST}
 evOperationDispatcher.SetOpIntegerData(ev_ccStrikeout, Ord(chbStrikeout.Checked));
 {$ENDIF ARCHI_OLD_EVEREST}
end;

procedure TStyleDesignDlg.FormCreate(Sender: TObject);
begin
{$IFDEF Archi}
 HelpContext := hcStyleDesigner;
{$ENDIF Archi}
 f_Deleting := False;
 {$IfDef InsiderTest}
 g_AllowModal := 0;
 {$EndIf InsiderTest}
end;

procedure TStyleDesignDlg.HelpBtnClick(Sender: TObject);
begin
 Application.HelpContext(HelpContext);
end;

procedure TStyleDesignDlg.Notify(aOperation : Integer; const aNode : Il3SimpleNode);
begin
 case aOperation of
  ntMoveBegin: f_NodeMoving := True;
  //ntMoveEnd  : f_NodeMoving := False;
 end;
end;

procedure TStyleDesignDlg.SelectCurrentStyle;
var
 l_Node: Il3HandleNode;
begin
 if Supports(StylesOutliner.CurrentCNode, Il3HandleNode, l_Node) then
  f_StyleInterface.SelectStyle(l_Node.Handle);
end;

procedure TStyleDesignDlg.StylesOutlinerCurrentChanged(Sender: TObject;
  aNewCurrent, aOldCurrent: Integer);
var
 l_Node: Il3HandleNode;
begin
 if (not f_Initializing) and (not f_Deleting) and (not f_NodeMoving) then
 begin
  if Supports(StylesOutliner.GetNode(aOldCurrent), Il3HandleNode, l_Node) then
  begin
   SaveStyleParam(l_Node.Handle);
   (StylesOutliner.GetNode(aOldCurrent) as Il3Node).Text := l3PCharLen(f_StyleInterface.Name);
  end;
 end;
 if Supports(StylesOutliner.GetNode(aNewCurrent), Il3HandleNode, l_Node) then
 begin
  f_StyleInterface.SelectStyle(l_Node.Handle);
  SetStyleParam;
 end;
end;

function TStyleDesignDlg.StylesOutlinerGetItemImage(Sender: TObject;
  Index: Integer; var aImages: TCustomImageList): Integer;
var
 l_Node: Il3HandleNode;
begin
 if Supports(StylesOutliner.TreeStruct.Nodes[Index], Il3HandleNode, l_Node) then
 begin
  if (Index = -1) or f_StyleInterface.SelectStyle(l_Node.Handle).BoolA[k2_tiApply2Para] then
   Result := picStylePara
  else
   Result := picStyleInterv;
 end
 else
  Result := -1;
end;

procedure TStyleDesignDlg.UpdateStyleType;
var
 l_Enabled : Boolean;
 l_Color   : TColor;
begin
 l_Enabled := (GrpStyle.ItemIndex = 0);
 EditParaWidth.Enabled := l_Enabled;
 EditLeftMargin.Enabled := l_Enabled;
 EditFirstLineMargin.Enabled := l_Enabled;
 sbLeftJstF.Enabled := l_Enabled;
 sbRightJstF.Enabled := l_Enabled;
 sbCenterJstF.Enabled := l_Enabled;
 sbWideJstF.Enabled := l_Enabled;
 sbJustifyPreformatted.Enabled := l_Enabled;

 if l_Enabled then 
 begin
  l_Color := clWindow;
  evOperationDispatcher.IncludeOperations(evJustifyCommands);
 end 
 else 
 begin
  l_Color := clBtnFace;
  evOperationDispatcher.ExcludeOperations(evJustifyCommands);
 end;

 SelectCurrentStyle;
 l_Enabled := l_Enabled and f_StyleInterface.ParentInterface.Apply2Para;

 sbParaJustInherit.Visible := l_Enabled;
 sbParaLeftInherit.Visible := l_Enabled;
 sbParaFirstInherit.Visible := l_Enabled;
 sbParaWidthInherit.Visible := l_Enabled;

 EditParaWidth.Color := l_Color;
 EditLeftMargin.Color := l_Color;
 EditFirstLineMargin.Color := l_Color;

 if not SetStyleInProgress then 
 begin
  SaveStyleParam;
  SetStyleParam;
  StylesOutliner.Invalidate;
 end;{not SetStyleInProgress};
end;

procedure TStyleDesignDlg.StylesOutlinerNodeMoveEnd(Sender: TObject;
  const CNode: Il3SimpleNode; aParentWasChange: Boolean);
begin
 try
  if aParentWasChange then
   SaveStyleParam(MaxInt, l3PCharLen2String(StylesOutliner.CurrentCNode.ParentNode.Text));
   SetStyleParam;
 finally
  f_NodeMoving := False;
 end;
end;

function TStyleDesignDlg.GetCaption(const Sender: TObject): string;
begin
 if Sender is TSpeedButton then 
  Result := (Sender as TSpeedButton).Caption
 else 
  if Sender is TButton then 
   Result := (Sender as TButton).Caption
  else 
   Assert(False, 'Другие элеметы не поддерживаются!'); 
end;

procedure TStyleDesignDlg.SetCaption(const Sender: TObject; aValue: TevInheritance);
begin
 if Sender is TSpeedButton then
  with (Sender as TSpeedButton) do
  begin
   Caption := cInheritance[aValue];
   Hint := cInheritanceHint[aValue];
  end
 else
  if Sender is TButton then
   with (Sender as TButton) do
   begin
    Caption := cInheritance[aValue];
    Hint := cInheritanceHint[aValue];
   end
  else
   Assert(False, 'Другие элеметы не поддерживаются!');
end;

procedure TStyleDesignDlg.StylesOutlinerGetItemColor(Sender: TObject;
  Index: Integer; var FG, BG: TColor);
var
 l_Node: Il3HandleNode;
begin
 if Supports(StylesOutliner.GetNode(index), Il3HandleNode, l_Node) then
 begin
  f_StyleInterface.SelectStyle(l_Node.Handle);
  if not f_StyleInterface.VisibleToUser then FG := clSilver;
 end;
end;

procedure TStyleDesignDlg.chbVisibleUserClick(Sender: TObject);
begin
 UpdateStyleType;
end;

{$IfDef InsiderTest}
{$IfDef l3HackedVCL}
function TStyleDesignDlg.NeedCancelModal: Boolean;
begin
 Result := False;
 {$IfDef InsiderTest}
 if Tl3BatchService.Instance.IsBatchMode then
 begin
  if Tl3BatchService.Instance.ExecuteCurrentModalWorker then
  begin
   if (ModalResult = 0) then
   begin
    Result := true;
    Exit;
   end;//ModalResult = 0
  end//seExecuteCurrentModalWorker
  else
  begin
   Result := true;
  end;//seExecuteCurrentModalWorker
 end;//g_BatchMode
 {$EndIf InsiderTest}
end;
{$EndIf l3HackedVCL}

function TStyleDesignDlg.ShowModal: integer;
begin
 {$IfDef InsiderTest}
 Assert(g_AllowModal >= 0);
 if Tl3BatchService.Instance.IsBatchMode then
  if (g_AllowModal <= 0) then
   if (Application.MainForm <> nil) then
    if not Tl3BatchService.Instance.HasModalWorker then
     raise EafwTryEnterModalState.Create('Здесь надо обрабатывать модальность формы');
 {$EndIf InsiderTest}
 Result := inherited ShowModal;
end;
{$ENDIF InsiderTest}

end.