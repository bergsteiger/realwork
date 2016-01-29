program styles;

uses
  Forms,
  stylesfrm in 'stylesfrm.pas' {frmStyles};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmStyles, frmStyles);
  Application.Run;
end.
