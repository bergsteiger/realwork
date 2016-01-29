program Custord;

uses
  Forms,
  CustOrd1 in 'CUSTORD1.PAS' {frmCustomers},
  CustOrd2 in 'CUSTORD2.PAS' {frmOrders},
  Custord3 in 'CUSTORD3.PAS' {frmAbout},
  Ovccache in 'OVCCACHE.PAS';

{$R *.RES}

begin
  Application.Title := 'Customer/Order Table Example';
  Application.CreateForm(TfrmCustomers, frmCustomers);
  Application.Run;
end.
