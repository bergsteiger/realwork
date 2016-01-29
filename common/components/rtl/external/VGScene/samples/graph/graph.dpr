program graph;

uses
  Forms,
  graphfrm in 'graphfrm.pas' {Form14};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm14, Form14);
  Application.Run;
end.
