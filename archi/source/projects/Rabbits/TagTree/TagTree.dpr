program TagTree;

uses
  Forms,
  D_MemUsg in '..\..\Everest\dlg\D_MEMUSG.PAS' {MemoryUsageDlg},
  Main in 'Main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
