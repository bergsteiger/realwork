program RichviewDemo;

uses
  Forms,
  eDocRichView in 'eDocRichView.pas' {frmRichView};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmRichView, frmRichView);
  Application.Run;
end.
