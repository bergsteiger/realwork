program TestNSRCSPY;

{$I nsrcspy.inc}

uses
  Forms,
  evdSchema,
  MainForm in 'MainForm.pas' {SpyForm};

{$R *.RES}

begin
  {$IFDEF OneInit}
  GlobalInit;
  {$ENDIF}
  Application.Title := 'Test NSRC Spy';
  Application.CreateForm(TSpyForm, SpyForm);
  Application.Run;
end.
