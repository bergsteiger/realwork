{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit Unit1;

interface
{$I dcprod.inc}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, dcdbctl, dcdbctlreg, StdCtrls, dcedit, Db, DBTables,dcgen, ComCtrls,
  dcpedit, dcsystem;
type
  TForm1 = class(TForm)
    tacust: TTable;
    tacustCustNo: TFloatField;
    tacustCompany: TStringField;
    tacustAddr1: TStringField;
    tacustAddr2: TStringField;
    tacustCity: TStringField;
    tacustState: TStringField;
    tacustZip: TStringField;
    tacustCountry: TStringField;
    tacustPhone: TStringField;
    tacustFAX: TStringField;
    tacustTaxRate: TFloatField;
    tacustContact: TStringField;
    tacustLastInvoiceDate: TDateTimeField;
    taorders: TTable;
    taordersOrderNo: TFloatField;
    taordersCustNo: TFloatField;
    taordersSaleDate: TDateTimeField;
    taordersShipDate: TDateTimeField;
    taordersEmpNo: TIntegerField;
    taordersShipVIA: TStringField;
    taordersTerms: TStringField;
    taordersPaymentMethod: TStringField;
    taordersItemsTotal: TCurrencyField;
    taordersTaxRate: TFloatField;
    taordersAmountPaid: TCurrencyField;
    dsorders: TDataSource;
    dscust: TDataSource;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label13: TLabel;
    Label14: TLabel;
    DataAwareMemo: TMemo;
    DCDBEdit1: TDCDBEdit;
    DCPropCheckBox7: TDCPropCheckBox;
    DCPropCheckBox8: TDCPropCheckBox;
    Button8: TButton;
    Button9: TButton;
    DCDBLookup1: TDCDBLookup;
    DCPropCheckBox5: TDCPropCheckBox;
    DCPropCheckBox4: TDCPropCheckBox;
    Button7: TButton;
    DCPropCheckBox6: TDCPropCheckBox;
    DBGrid1: TDBGrid;
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$IFDEF DREAMINSPECTOR}
uses
  glyphed;
{$ENDIF}

{$R *.DFM}

procedure TForm1.Button8Click(Sender: TObject);
begin
  CallPropertyEdit(DCDbEdit1.Button1,'Glyph');
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  CallPropertyEdit(DCDbEdit1.Button2,'Glyph');
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  CallPropertyEdit(DCDbLookup1.Button2,'Glyph');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  CorrectMemoText(DataAwareMemo);
end;



end.
