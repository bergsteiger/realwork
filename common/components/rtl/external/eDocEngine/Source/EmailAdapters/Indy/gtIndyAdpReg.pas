unit gtIndyAdpReg;

interface

uses
  Classes, gtIndyAdapter;

procedure Register;

implementation

{$R gtIndyAdpReg.DCR}

procedure Register;
begin
  RegisterComponents('eDocEngine Additional', [TgtIndyAdapter]);
end;

end.
