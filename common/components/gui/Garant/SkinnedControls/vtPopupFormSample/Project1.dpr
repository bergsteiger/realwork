program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  vtLayeredForm in '..\..\VT\vtLayeredForm.pas',
  vtPopupForm in '..\..\VT\vtPopupForm.pas',
  vtReminder in '..\..\VT\vtReminder.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
