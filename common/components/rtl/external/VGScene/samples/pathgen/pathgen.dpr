program pathgen;

uses
  Forms,
  pathgenfrm in 'pathgenfrm.pas' {Form16};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm16, Form16);
  Application.Run;
end.
