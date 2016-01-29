program extbl10;

uses
  Forms,
  Extbl10u in 'Extbl10u.pas' {Form1};

{$R *.RES}
{$IFDEF WIN32}
{$R EXTBL10.R32}
{$ELSE}
{$R EXTBL10.R16}
{$ENDIF}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
