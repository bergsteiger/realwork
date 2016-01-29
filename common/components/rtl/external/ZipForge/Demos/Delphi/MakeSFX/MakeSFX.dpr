program MakeSFX;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {fmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
