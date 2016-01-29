program inherit_cl;

uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  Forms,
  main in 'main.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
