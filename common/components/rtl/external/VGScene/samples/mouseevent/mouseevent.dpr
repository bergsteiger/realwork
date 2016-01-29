program mouseevent;

uses
  Forms,
  mousefrm in 'mousefrm.pas' {Form10};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm10, Form10);
  Application.Run;
end.
