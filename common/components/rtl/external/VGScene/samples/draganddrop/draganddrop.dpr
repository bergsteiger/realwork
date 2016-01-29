program draganddrop;

uses
  Forms,
  dragfrm in 'dragfrm.pas' {Form9};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm9, Form9);
  Application.Run;
end.
