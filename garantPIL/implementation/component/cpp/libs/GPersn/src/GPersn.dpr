program GPersn;

uses
  Forms, Windows, GPrsnLib,
  GPersnBody in 'GPersnBody.pas' {TU_Demo};

{$R *.RES}
{$L pl_crypt}

begin
  Application.Initialize;
 try
  pl_InitCrypto(0);
 except
 end;
  Application.CreateForm(TTU_Demo, TU_Demo);
  Application.Run;
 try
  pl_DoneCrypto(0);
 except
 end;
end.
