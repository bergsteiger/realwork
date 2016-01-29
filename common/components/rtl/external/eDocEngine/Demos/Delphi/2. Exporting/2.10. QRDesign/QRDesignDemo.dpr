program QRDesignDemo;

uses
  Forms,
  eDocProComponents in 'eDocProComponents.pas' {frmeDocProComponents},
  eDocQR2 in 'eDocQR2.pas' {frmQR2};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmQR2, frmQR2);
  Application.CreateForm(TfrmeDocProComponents, frmeDocProComponents);
  Application.Run;
end.
