program VisualIORDumper;

uses
{$IFDEF LINUX}
  QForms,
{$ELSE}
  Forms,
{$ENDIF}
  VIORDmp in 'VIORDmp.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
