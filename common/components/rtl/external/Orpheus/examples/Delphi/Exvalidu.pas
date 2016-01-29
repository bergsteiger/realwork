unit Exvalidu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, OvcNf, OvcPb, OvcPf, OvcBase, OvcEf, OvcSf, StdCtrls,
  Buttons;

type
  TForm1 = class(TForm)
    OvcSimpleField1: TOvcSimpleField;
    DefaultController: TOvcController;
    OvcPictureField1: TOvcPictureField;
    OvcNumericField1: TOvcNumericField;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  if Form1.DefaultController.ValidateEntryFields = nil then
    Close;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

end.
