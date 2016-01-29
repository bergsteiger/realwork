program Textview;

uses
  Forms,
  Txtview1 in 'TXTVIEW1.PAS' {ViewForm},
  Txtview2 in 'TXTVIEW2.PAS' {ViewAbout},
  Txtview3 in 'TXTVIEW3.PAS' {FindDlg};

{$R *.RES}

begin
  Application.Title := 'Text View';
  Application.CreateForm(TViewForm, ViewForm);
  Application.CreateForm(TViewAbout, ViewAbout);
  Application.CreateForm(TFindDlg, FindDlg);
  Application.Run;
end.
