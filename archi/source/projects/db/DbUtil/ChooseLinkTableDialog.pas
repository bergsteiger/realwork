unit ChooseLinkTableDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, vtSpin, dt_Types, dt_AttrSchema;

type
  TChooseLinkTableDlg = class(TForm)
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    vtSpinEdit1: TvtSpinEdit;
    vtSpinEdit2: TvtSpinEdit;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
  private
    { Private declarations }
  public
    function Execute(out theTable: TFamTbls; out theOldValue, theNewValue: Integer): Boolean;
    { Public declarations }
  end;

var
  Form1: TChooseLinkTableDlg;

implementation

uses dt_Const, daTypes;

{$R *.dfm}

function TChooseLinkTableDlg.Execute(out theTable: TFamTbls; out theOldValue, theNewValue: Integer): Boolean;
var
 l_Index: TdaDictionaryType;
begin
 for l_Index := Low(cDLPassports) to High(cDLPassports) do
  ComboBox1.Items.Add(cDLPassports[l_Index].rName);
 Result := ShowModal = mrOk;
 if Result then
 begin
  theTable:= cDLPassports[TdaDictionaryType(ComboBox1.ItemIndex + Ord(Low(cDLPassports)))].rLink;
  theOldValue:= vtSpinEdit1.AsInteger;
  theNewValue:= vtSpinEdit2.AsInteger;
 end;
end;

end.
