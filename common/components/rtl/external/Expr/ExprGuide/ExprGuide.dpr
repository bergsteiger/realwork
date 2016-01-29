program ExprGuide;

uses
  Forms,
  EG in 'EG.pas' {FormGuide};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormGuide, FormGuide);
  Application.Run;
end.
