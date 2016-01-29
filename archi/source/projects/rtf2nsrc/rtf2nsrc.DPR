program Rtf2nsrc;

uses
  Forms,
  Mainform in 'MAINFORM.PAS' {Form1};

{$R *.RES}

begin
  Application.CreateForm(TFileSrchForm, FileSrchForm);
  Application.Run;
end.
