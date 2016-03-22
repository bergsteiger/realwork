program pgmigrate;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  Migrator in 'Migrator.pas',
  Base_CFG in '..\..\Common\Base_CFG.pas',
  Com_Cnst in '..\..\Archi\CM\COM_CNST.PAS',
  ResShop in '..\..\Archi\CM\ResShop.pas' {ArchiResources: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
