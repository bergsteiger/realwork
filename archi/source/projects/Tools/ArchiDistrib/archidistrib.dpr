program archidistrib;

uses
  Forms,
  adMain in 'adMain.pas' {MainForm},
  adItemEdit in 'adItemEdit.pas' {adItemEditDlg},
  adErrorBox in 'adErrorBox.pas' {ErrorBox},
  adArchiveList in 'adArchiveList.pas' {ArchiveList};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
