program acrobat;

uses
  Forms,
  Unit8 in 'Unit8.pas' {Form8};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm8, Form8);
  Application.Run;
end.
