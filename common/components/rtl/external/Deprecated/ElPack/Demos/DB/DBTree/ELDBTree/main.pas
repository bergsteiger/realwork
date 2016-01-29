
unit main;

interface

uses
  Windows, Messages, SysUtils, {$ifdef VER150}Variants,{$endif}{$ifdef VER140}Variants,{$endif} Classes, Graphics, Controls, Forms,
  Dialogs, ElPgCtl, ElXPThemedControl, ElTree, ElDBTree, Grids, DBGrids,
  DB, ExtCtrls, DBTables, DBCtrls, ElStrUtils, StdCtrls, ImgList,
  ElDBTreeEditors, ElPanel, ElFlatCtl, ElSplit, ElPopBtn, ElToolbar,
  ElDBCtrls, ElHTMLLbl, ElDBLbl, ElStatBar, ElCLabel, ElLabel;

type
  TExample = class(TForm)
    ElPageControl1: TElPageControl;
    ElTabSheet1: TElTabSheet;
    ElTabSheet2: TElTabSheet;
    ElTabSheet3: TElTabSheet;
    BioQuery: TQuery;
    ElRelDataSource2: TElRelDataSource;
    DetailQuery: TQuery;
    DetailQuerySpeciesNo: TFloatField;
    DetailQueryCategory: TStringField;
    DetailQueryCommon_Name: TStringField;
    DetailQuerySpeciesName: TStringField;
    DetailQueryLengthcm: TFloatField;
    DetailQueryLength_In: TFloatField;
    DetailQueryNotes: TMemoField;
    DetailQueryGraphic: TGraphicField;
    Panel1: TPanel;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DBGrid2: TDBGrid;
    DBGrid1: TDBGrid;
    BioQuerycategory: TStringField;
    TableTree: TTable;
    ImageList1: TImageList;
    SelfReference: TElRelDataSource;
    DataSource3: TDataSource;
    Item: TTable;
    ItemOrderNo: TFloatField;
    ItemItemNo: TFloatField;
    ItemPartNo: TFloatField;
    ItemQty: TIntegerField;
    ItemDiscount: TFloatField;
    ItemPartsDesc: TStringField;
    Orders: TTable;
    OrdersOrderNo: TFloatField;
    OrdersCustNo: TFloatField;
    OrdersSaleDate: TDateTimeField;
    OrdersShipDate: TDateTimeField;
    OrdersEmpNo: TIntegerField;
    OrdersShipToContact: TStringField;
    OrdersShipToAddr1: TStringField;
    OrdersShipToAddr2: TStringField;
    OrdersShipToCity: TStringField;
    OrdersShipToState: TStringField;
    OrdersShipToZip: TStringField;
    OrdersShipToCountry: TStringField;
    OrdersShipToPhone: TStringField;
    OrdersShipVIA: TStringField;
    OrdersPO: TStringField;
    OrdersTerms: TStringField;
    OrdersPaymentMethod: TStringField;
    OrdersItemsTotal: TCurrencyField;
    OrdersTaxRate: TFloatField;
    OrdersFreight: TCurrencyField;
    OrdersAmountPaid: TCurrencyField;
    Customer: TTable;
    CustomerCustNo: TFloatField;
    CustomerCompany: TStringField;
    CustomerAddr1: TStringField;
    CustomerAddr2: TStringField;
    CustomerCity: TStringField;
    CustomerState: TStringField;
    CustomerZip: TStringField;
    CustomerCountry: TStringField;
    CustomerPhone: TStringField;
    CustomerFAX: TStringField;
    CustomerTaxRate: TFloatField;
    CustomerContact: TStringField;
    CustomerLastInvoiceDate: TDateTimeField;
    Parts: TTable;
    PartsPartNo: TFloatField;
    PartsVendorNo: TFloatField;
    PartsDescription: TStringField;
    PartsOnHand: TFloatField;
    PartsOnOrder: TFloatField;
    PartsCost: TCurrencyField;
    PartsListPrice: TCurrencyField;
    Panel7: TPanel;
    DataSource4: TDataSource;
    DataSource5: TDataSource;
    DataSource6: TDataSource;
    MasterDetail: TElRelDataSource;
    ElDBTree3: TElDBTree;
    ElDBTreeEdit1: TElDBTreeEdit;
    ElDBTreeDateTimePickerEdit1: TElDBTreeDateTimePickerEdit;
    ElDBTreeCurrencyEdit1: TElDBTreeCurrencyEdit;
    ElDBTreeFloatSpinEdit1: TElDBTreeFloatSpinEdit;
    TableTreeDIRNAME: TStringField;
    TableTreeDIRID: TFloatField;
    TableTreePARENTID: TFloatField;
    TableTreeIMAGEINDEX: TFloatField;
    TableTreeSELECTEDIN: TFloatField;
    TableTreeSTATEINDEX: TFloatField;
    Panel6: TElPanel;
    Panel9: TElPanel;
    ElSplitter1: TElSplitter;
    ElFlatMultiController1: TElFlatMultiController;
    ElSplitter2: TElSplitter;
    ElSplitter3: TElSplitter;
    ElPanel2: TElPanel;
    ElDBNavigator1: TElDBNavigator;
    ElDBNavButton1: TElDBNavButton;
    ElDBNavButton12: TElDBNavButton;
    ElDBNavButton13: TElDBNavButton;
    ElDBNavButton14: TElDBNavButton;
    ElDBNavButton15: TElDBNavButton;
    ElDBNavButton16: TElDBNavButton;
    ElDBNavButton17: TElDBNavButton;
    ElDBNavButton18: TElDBNavButton;
    ElDBNavButton19: TElDBNavButton;
    ElDBNavButton20: TElDBNavButton;
    ElDBLabel1: TElDBLabel;
    ElDBNavButton24: TElDBNavButton;
    ElDBNavButton25: TElDBNavButton;
    ElDBNavButton26: TElDBNavButton;
    ElPanel1: TElPanel;
    ElPanel3: TElPanel;
    ElSplitter4: TElSplitter;
    ElStatusBar1: TElStatusBar;
    ElPanel4: TElPanel;
    ElDBNavigator3: TElDBNavigator;
    ElDBNavButton27: TElDBNavButton;
    ElDBNavButton28: TElDBNavButton;
    ElDBNavButton29: TElDBNavButton;
    ElDBNavButton30: TElDBNavButton;
    ElDBNavButton31: TElDBNavButton;
    ElDBNavButton32: TElDBNavButton;
    ElDBNavButton33: TElDBNavButton;
    ElDBNavButton34: TElDBNavButton;
    ElDBNavButton35: TElDBNavButton;
    ElDBNavButton36: TElDBNavButton;
    ElDBNavButton37: TElDBNavButton;
    ElDBNavButton38: TElDBNavButton;
    ElDBNavButton39: TElDBNavButton;
    Label2: TLabel;
    ElPanel5: TElPanel;
    ElPanel6: TElPanel;
    ElDBTree1: TElDBTree;
    ElPanel7: TElPanel;
    ElPanel8: TElPanel;
    ElPanel9: TElPanel;
    ElDBTree2: TElDBTree;
    ElPanel10: TElPanel;
    ElPanel11: TElPanel;
    DBGrid4: TDBGrid;
    ElPanel12: TElPanel;
    ElPanel13: TElPanel;
    DBGrid7: TDBGrid;
    ElPanel14: TElPanel;
    ElPanel15: TElPanel;
    DBGrid5: TDBGrid;
    ElPanel16: TElPanel;
    ElPanel17: TElPanel;
    DBGrid3: TDBGrid;
    ElSplitter5: TElSplitter;
    Panel8: TElPanel;
    ElDBNavigator2: TElDBNavigator;
    ElDBNavButton2: TElDBNavButton;
    ElDBNavButton3: TElDBNavButton;
    ElDBNavButton4: TElDBNavButton;
    ElDBNavButton5: TElDBNavButton;
    ElDBNavButton6: TElDBNavButton;
    ElDBNavButton7: TElDBNavButton;
    ElDBNavButton8: TElDBNavButton;
    ElDBNavButton9: TElDBNavButton;
    ElDBNavButton10: TElDBNavButton;
    ElDBNavButton11: TElDBNavButton;
    ElDBNavButton21: TElDBNavButton;
    ElDBNavButton22: TElDBNavButton;
    ElDBNavButton23: TElDBNavButton;
    procedure ElDBTree1ShowLineHint(Sender: TObject; Item: TElTreeItem;
      Section: TElHeaderSection; var Text: TElFString;
      HintWindow: THintWindow; MousePos: TPoint; var DoShowHint: Boolean);
    procedure ElDBTree1ActivateLevel(Sender: TObject;
      Parent: TElDBTreeItem);
    procedure DBGrid1Enter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid7Enter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Example: TExample;
  ParamsCreated:Boolean;

implementation

{$R *.dfm}

function WrapText(const Line, BreakStr: string; const BreakChars: TSysCharSet;
  MaxCol: Integer): string;
const
  QuoteChars = ['''', '"'];
var
  Col, Pos: Integer;
  LinePos, LineLen: Integer;
  BreakLen, BreakPos: Integer;
  QuoteChar, CurChar: Char;
  ExistingBreak: Boolean;
  L: Integer;
begin
  Col := 1;
  Pos := 1;
  LinePos := 1;
  BreakPos := 0;
  QuoteChar := ' ';
  ExistingBreak := False;
  LineLen := Length(Line);
  BreakLen := Length(BreakStr);
  Result := '';
  while Pos <= LineLen do
  begin
    CurChar := Line[Pos];
    if CurChar in LeadBytes then
    begin
      L := CharLength(Line, Pos) - 1;
      Inc(Pos, L);
      Inc(Col, L);
    end
    else
    begin
      if CurChar = BreakStr[1] then
      begin
        if QuoteChar = ' ' then
        begin
          ExistingBreak := CompareText(BreakStr, Copy(Line, Pos, BreakLen)) = 0;
          if ExistingBreak then
          begin
            Inc(Pos, BreakLen-1);
            BreakPos := Pos;
          end;
        end
      end
      else if CurChar in BreakChars then
      begin
        if QuoteChar = ' ' then BreakPos := Pos
      end
      else if CurChar in QuoteChars then
      begin
        if CurChar = QuoteChar then
          QuoteChar := ' '
        else if QuoteChar = ' ' then
          QuoteChar := CurChar;
      end;
    end;
    Inc(Pos);
    Inc(Col);
    if not (QuoteChar in QuoteChars) and (ExistingBreak or
      ((Col > MaxCol) and (BreakPos > LinePos))) then
    begin
      Col := Pos - BreakPos;
      Result := Result + Copy(Line, LinePos, BreakPos - LinePos + 1);
      if not (CurChar in QuoteChars) then
        while Pos <= LineLen do
        begin
          if Line[Pos] in BreakChars then
            Inc(Pos)
          else if Copy(Line, Pos, Length(sLineBreak)) = sLineBreak then
            Inc(Pos, Length(sLineBreak))
          else
            break;
        end;
      if not ExistingBreak and (Pos < LineLen) then
        Result := Result + BreakStr;
      Inc(BreakPos);
      LinePos := BreakPos;
      ExistingBreak := False;
    end;
  end;
  Result := Result + Copy(Line, LinePos, MaxInt);
end;

procedure TExample.ElDBTree1ShowLineHint(Sender: TObject;
  Item: TElTreeItem; Section: TElHeaderSection; var Text: TElFString;
  HintWindow: THintWindow; MousePos: TPoint; var DoShowHint: Boolean);
var
  s: string;
begin
  S := Text;
  s := WrapText(S, #13#10, [' ', #10, #9, '-'], 60);
  Text := S;
end;

procedure TExample.ElDBTree1ActivateLevel(Sender: TObject;
  Parent: TElDBTreeItem);
begin
  DetailQuery.Close;
  DetailQuery.Params[0].AsString :=  BioQueryCategory.AsString; //Table1Category.AsString;
  DetailQuery.Open;
end;

procedure TExample.DBGrid1Enter(Sender: TObject);
begin
  ElDBNavigator3.DataSource := TDBGrid(Sender).DataSource;
end;

procedure TExample.FormCreate(Sender: TObject);
begin
  ImageList1.ResourceLoad(rtBitmap, 'IMAGES', clSilver);
end;

procedure TExample.DBGrid7Enter(Sender: TObject);
begin
  ElDBNavigator2.DataSource := TDBGrid(Sender).DataSource;
end;

end.
