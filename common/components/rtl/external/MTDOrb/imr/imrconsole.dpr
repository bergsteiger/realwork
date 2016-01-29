program imrconsole;

uses
  Forms,
  orb,
  imrconsolemain in 'imrconsolemain.pas' {fmMain},
  imradminutils in 'imradminutils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  dorb := ORB_Init(nil);
  try
    Application.Run;
  finally
    dorb._destroy;
  end; { try/finally }
end.
