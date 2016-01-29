program Fileview;

uses
  Forms,
  Filview1 in 'FILVIEW1.PAS' {ViewForm},
  Filview3 in 'FILVIEW3.PAS' {FindDlg},
  Filview2 in 'FILVIEW2.PAS' {FileAbout};

{$R *.RES}

begin
  Application.CreateForm(TViewForm, ViewForm);
  Application.CreateForm(TFindDlg, FindDlg);
  Application.CreateForm(TFileAbout, FileAbout);
  Application.Run;
end.
