unit frmProp;
                     
interface

uses
  Forms, StdCtrls, ElSpin, ElFlatCtl, ElBtnCtl, ElCheckCtl,
  ElBtnEdit, ElNameEdits, ElXPThemedControl, ElEdits, Controls, Classes;

type
  TPropForm = class(TForm)
    Label1: TLabel;
    HostLabel: TLabel;
    OkBtn: TButton;
    CancelBtn: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    IntervalSpin: TElSpinEdit;
    TimeOutSpin: TElSpinEdit;
    LogCountSpin: TElSpinEdit;
    GridCB: TElCheckBox;
    RepCB: TElCheckBox;
    LogNameEdit: TElFileNameEdit;
    procedure RepCBClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PropForm: TPropForm;

implementation

{$R *.DFM}

procedure TPropForm.RepCBClick(Sender: TObject);
var b : boolean;
begin
  b := RepCB.Checked;
  LogNameEdit.ReadOnly := not b;
  LogNameEdit.Enabled := b;
  LogCountSpin.Enabled := b;
end;

end.
