{$I OVC.INC}

unit ExMove1;

interface

uses
  Controls, Classes, Forms, Dialogs, SysUtils, StdCtrls,
  OvcBase, OvcNbk, OvcEf, OvcSf, OvcNf, OvcPb, OvcPf,
  OvcAe, OvcMeter, OvcSc;

{$IFNDEF MoveableComponents}
  *** This example requires "MoveableComponents" to be defined in the ***
  *** OVC.INC file.                                                   ***
{$ENDIF}

type
  TForm1 = class(TForm)
    OvcSimpleField1: TOvcSimpleField;
    OvcPictureField1: TOvcPictureField;
    OvcNumericField1: TOvcNumericField;
    OvcSimpleArrayEditor1: TOvcSimpleArrayEditor;
    Button1: TButton;
    OvcSimpleField2: TOvcSimpleField;
    OvcController1: TOvcController;
    OvcMeter1: TOvcMeter;
    OvcSpinner1: TOvcSpinner;
    OvcNotebook1: TOvcNotebook;
    OvcSimpleField3: TOvcSimpleField;
    procedure Button1Click(Sender: TObject);
    procedure ControlMove(Sender: TObject);
  private
    { Private declarations }
    HoldCaption : string;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
  with OvcController1 do begin
    AllowMove := not AllowMove;
    OnControlMove := ControlMove;
    if AllowMove then begin
      HoldCaption := Caption;
      Button1.Caption := 'Disable Move';
    end else begin
      Caption := HoldCaption;
      Button1.Caption := 'Enable Move';

      {*** would probably save the position of the components here ***}

    end;
  end;
end;

procedure TForm1.ControlMove(Sender : TObject);
var
  C : TCustomControl;
begin
  C := Sender as TCustomControl;
  Caption := Format(HoldCaption + ' - %s (%d:%d)', [C.Name, C.Left, C.Top]);
end;

end.
