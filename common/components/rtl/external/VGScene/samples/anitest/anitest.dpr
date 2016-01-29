program anitest;

uses
  Forms,
  anitestfrm in 'anitestfrm.pas' {Form19};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm19, Form19);
  Application.Run;
end.
