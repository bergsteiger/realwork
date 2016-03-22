unit D_SrchIncludeDoc3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BOTTOMBTNDLG, StdCtrls, Buttons, ExtCtrls, Mask, vtCombo, vtDateEdit,
  OvcBase,  vtlister, vtOutliner, afwControl, afwInputControl,

  DT_Types, dt_AttrSchema,
  ActnList, XPStyleActnCtrls, ActnMan, afwControlPrim,
  afwBaseControl;

type
  TSearchDocForExportDlg = class(TBottomBtnDlg)
    Label1: TLabel;
    lblLinkedFromDate: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    edtLowDate: TvtDateEdit;
    edtHighDate: TvtDateEdit;
    edtLinkedFromDate: TvtDateEdit;
    otlAttrFilter: TvtOutliner;
    cbxNewDoc: TCheckBox;
    cbxChangedDoc: TCheckBox;
    cbxAttrFilter: TCheckBox;
    lblLinkedToDate: TLabel;
    edtLinkedToDate: TvtDateEdit;
    btnSettings: TBitBtn;
    procedure cbxAttrFilterClick(Sender: TObject);
    procedure otlAttrFilterSelectChanged(Sender: TObject; Index: Integer;
      var SelectedState: Integer);
    procedure btnSettingsClick(Sender: TObject);
    procedure edtNewDateChange(Sender: TObject);
    procedure edtIzmDateChange(Sender: TObject);
  private
    f_AttrToSearch: TdtAttribute;
    f_LinkedDateAsRange: Boolean;
    procedure pm_SetAttrToSearch(const Value: TdtAttribute);
    procedure pm_SetLinkedDateAsRange(const Value: Boolean);
    { Private declarations }
    procedure SetLinkedDatesAsRange(aRangedDate: Boolean);
  public
    function Execute : boolean; override;
    property AttrToSearch: TdtAttribute read f_AttrToSearch write pm_SetAttrToSearch;
    property LinkedDateAsRange: Boolean read f_LinkedDateAsRange write pm_SetLinkedDateAsRange;
  end;

implementation
{$R *.DFM}
 Uses
  l3Base,
  l3Date, l3Tree, l3Nodes, l3TreeInterfaces, l3Tree_TLB,
  daTypes,
  daSchemeConsts,
  dt_const, dt_Dict,
  l3IniFile, IniShop,
  Main, d_SearchSettings, BtnDlg;

type /// Для поддержки старых запомненных параметров поиска
 TSearchParameters = (stDate,
                      stNumber,
                      stActiveStatus,
                      stSources,
                      stTypes,
                      stGroups,
                      stClasses,
                      stPrefixes,
                      stTerritories,
                      stNorms,
                      stWarnings,
                      stKeyWords,
                      stStages,
                      stAccGroups,
                      stText,
                      stAnnoClasses,
                      stServiceInfo,
                      stPublisheds,
                      stCorSources,
                      stUrgency);

 function TSearchDocForExportDlg.Execute : boolean;
 var
  lCurNode  : Il3Node;
  l_AttrToSrch: TdtAttribute;

  function WriteIterFunc(var aValue : Integer) : Boolean;
  begin
   lCurNode := otlAttrFilter.CTree.GetNextSelect(lCurNode);
   Result := lCurNode = Nil;
   If Not Result then aValue := (lCurNode as Il3HandleNode).Handle;
  end;

  procedure ReadIterFunc(aValue : Integer);
  begin
   lCurNode := otlAttrFilter.CTree.FindNodeByParam(otlAttrFilter.CTree.CRootNode, aValue, 0);
   otlAttrFilter.CTree.SelectedNode[lCurNode] := True;
  end;

 begin

  UserConfig.Section := 'RequestOnExport';

  edtLowDate.Date  := UserConfig.ReadParamDateDef('SearchDocForExportLowDate', NullDate);
  edtHighDate.Date := UserConfig.ReadParamDateDef('SearchDocForExportHighDate', NullDate);

  SetLinkedDatesAsRange(UserConfig.ReadParamBoolDef('SearchDocRangedLinkedDate', False));

  l_AttrToSrch := TdtAttribute(UserConfig.ReadParamIntDef('SearchDocSearchParam', Ord(atAccGroups)));

  // Поддержка старого формата настроек диалога
  if not (l_AttrToSrch in [atAccGroups, atBases]) then
  begin
   l_AttrToSrch := atAccGroups;
   UserConfig.WriteParamInt('SearchDocSearchParam', Ord(l_AttrToSrch));
  end;

  AttrToSearch := l_AttrToSrch;

  UserConfig.ReadParamArrayF('Bases', MakeRAIStub(@ReadIterFunc));

  Result := ShowModal = mrOK;

  If Result then
  Try
   UserConfig.Section := 'RequestOnExport';
   lCurNode := Nil;
   UserConfig.WriteParamArrayF('Bases', MakeWAIStub(@WriteIterFunc));
   UserConfig.WriteParamDate('SearchDocForExportLowDate', edtLowDate.Date);
   UserConfig.WriteParamDate('SearchDocForExportHighDate', edtHighDate.Date);
  except
    On E : Exception do Application.ShowException(E);
  end;
 end;

procedure TSearchDocForExportDlg.cbxAttrFilterClick(Sender: TObject);
begin
 if not cbxAttrFilter.Checked then
  otlAttrFilter.vlbDeselectAllItems;
end;

procedure TSearchDocForExportDlg.otlAttrFilterSelectChanged(Sender: TObject;
  Index: Integer; var SelectedState: Integer);
begin
 cbxAttrFilter.Checked := otlAttrFilter.SelectedCount > 0;
end;

procedure TSearchDocForExportDlg.pm_SetLinkedDateAsRange(const Value: Boolean);
begin
 if f_LinkedDateAsRange <> Value then
  SetLinkedDatesAsRange(Value);
end;

procedure TSearchDocForExportDlg.pm_SetAttrToSearch(const Value: TdtAttribute);
var
 l_Dict: TdaDictionaryType;
 lNode : Il3Node;
 I     : Integer;
begin
 if f_AttrToSearch <> Value then
 begin
  Assert(Value in [atBases, atAccGroups], 'Неверный словарь в диалоге поиска!');
  f_AttrToSearch := Value;
  l_Dict := AttrID2DLType(Value);
  otlAttrFilter.vlbDeselectAllItems;
  otlAttrFilter.CTree.RootNode := DictServer(CurrentFamily).DictRootNode[l_Dict];
  cbxAttrFilter.Caption := cDLPassports[l_Dict].rName;
  if f_AttrToSearch = atAccGroups then
   with otlAttrFilter.CTree do
   begin
    // это спец. ноды из словаря ACCGroups, которые не следует показывать пользователю
    for I :=1 to 4 do
    begin
     lNode := l3FindNodeByHandle(CRootNode, I);
     NodeFlags[lNode] := NodeFlags[lNode] or nfHidden;
    end;
   end;
 end;
end;

procedure TSearchDocForExportDlg.SetLinkedDatesAsRange(aRangedDate: Boolean);
begin
 lblLinkedToDate.Visible := aRangedDate;
 edtLinkedToDate.Visible := aRangedDate;
 if aRangedDate then
 begin
  lblLinkedFromDate.Caption := 'с';
  edtLinkedFromDate.Date := NullDate;
  edtLinkedToDate.Date := NullDate;
 end
 else
 begin
  lblLinkedFromDate.Caption := 'от';
  edtLinkedFromDate.Date := IniRec.NextVersionDate;
 end;
 f_LinkedDateAsRange := aRangedDate;
end;

procedure TSearchDocForExportDlg.btnSettingsClick(Sender: TObject);
var
 l_Dlg: TSearchSettingsDlg;
begin
 l_Dlg := TSearchSettingsDlg.Create(Self);
 try
  l_Dlg.RangedLinkDate := LinkedDateAsRange;
  l_Dlg.FilterDict := AttrToSearch;
  if l_Dlg.Execute then
  begin
   LinkedDateAsRange := l_Dlg.RangedLinkDate;
   AttrToSearch := l_Dlg.FilterDict;
   UserConfig.Section := 'RequestOnExport';
   UserConfig.WriteParamBool('SearchDocRangedLinkedDate', LinkedDateAsRange);
   UserConfig.WriteParamInt('SearchDocSearchParam', Ord(f_AttrToSearch));
  end;
 finally
  l3Free(l_Dlg);
 end;
end;

procedure TSearchDocForExportDlg.edtNewDateChange(Sender: TObject);
begin
 inherited;
 if not TvtDateEdit(Sender).IsEmpty then
  cbxNewDoc.Checked := True;
end;

procedure TSearchDocForExportDlg.edtIzmDateChange(Sender: TObject);
begin
  inherited;
  if not TvtDateEdit(Sender).IsEmpty then
  cbxChangedDoc.Checked := True;
end;

end.


