unit uMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ElACtrls, ElDBLookupCtrls, ExtCtrls, DBCtrls, DB,
  DBTables, Grids, DBGrids, ElPanel, ElSplit, ElXPThemedControl, ElEdits,
  ElCombos, ElDBWideLookupControls, Buttons, ComCtrls, ElListBox, ElBtnCtl,
  {$ifdef VER150}Variants,{$endif}{$ifdef VER140}Variants,{$endif} ElCheckCtl, ElPopBtn, ElBtnEdit;

type
  TfrmMain = class(TForm)
    PC: TPageControl;
    tsComboBoxes: TTabSheet;
    tsListBoxes: TTabSheet;
    Panel1: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Panel2: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ElDBLookupComboBox1: TElDBLookupComboBox;
    ElWideDBLookupComboBox1: TElWideDBLookupComboBox;
    DBLookupComboBox1: TDBLookupComboBox;
    DBGrid2: TDBGrid;
    ElSplitter1: TElSplitter;
    Panel3: TPanel;
    Label2: TLabel;
    DBGrid3: TDBGrid;
    dbNavLookup: TDBNavigator;
    db: TDatabase;
    t_orders: TTable;
    t_customers_lookup: TTable;
    s_orders: TDataSource;
    s_customers_lookup: TDataSource;
    s_customers: TDataSource;
    t_customers: TTable;
    Panel4: TPanel;
    Label8: TLabel;
    DBGrid4: TDBGrid;
    DBNavigator2: TDBNavigator;
    Panel5: TPanel;
    Label10: TLabel;
    Panel6: TPanel;
    Label9: TLabel;
    DBGrid5: TDBGrid;
    DBNavigator3: TDBNavigator;
    ElSplitter2: TElSplitter;
    PCL: TPageControl;
    tsLB_STD: TTabSheet;
    ts_LB_Str: TTabSheet;
    st_LB_W: TTabSheet;
    ElDBLookupListBox1: TElDBLookupListBox;
    ElWideDBLookupListBox1: TElWideDBLookupListBox;
    DBLookupListBox1: TDBLookupListBox;
    Panel7: TPanel;
    cbLookupFiltered: TElCheckBox;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    ElPopupButton1: TElPopupButton;
    Splitter3: TSplitter;
    Panel8: TPanel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure dbNavLookupClick(Sender: TObject; Button: TNavigateBtn);
    procedure ElDBLookupListBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ElAdvancedListBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbLookupFilteredClick(Sender: TObject);
    procedure t_customers_lookupAfterOpen(DataSet: TDataSet);
    procedure ElPopupButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  t_orders.Open;
  t_customers.Open;
  t_customers_lookup.Open;
end;

procedure TfrmMain.dbNavLookupClick(Sender: TObject; Button: TNavigateBtn);
begin
   if Button = nbRefresh then
     begin
       t_customers_lookup.Close;
       t_customers_lookup.Open;
       Abort;
     end;
end;

procedure TfrmMain.ElDBLookupListBox1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
//
end;

procedure TfrmMain.ElAdvancedListBox1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
//
end;

procedure TfrmMain.cbLookupFilteredClick(Sender: TObject);
begin
   t_customers_lookup.Filtered := cbLookupFiltered.Checked;
end;

procedure TfrmMain.t_customers_lookupAfterOpen(DataSet: TDataSet);
begin
   cbLookupFiltered.Checked := t_customers_lookup.Filtered;
end;

procedure TfrmMain.ElPopupButton1Click(Sender: TObject);
begin
   t_customers_lookup.Active := not t_customers_lookup.Active;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
   ElDBLookupListBox1.HorizontalScroll := not ElDBLookupListBox1.HorizontalScroll;
end;

end.
