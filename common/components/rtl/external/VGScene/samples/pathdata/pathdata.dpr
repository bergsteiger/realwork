program pathdata;

uses
  Forms,
  pathdatafrm in 'pathdatafrm.pas' {Form15};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm15, Form15);
  Application.Run;
end.
