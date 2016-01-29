program Textedit;

uses
  Forms,
  Txtedit1 in 'TXTEDIT1.PAS' {EditForm},
  Txtedit2 in 'TXTEDIT2.PAS' {EditAbout},
  Txtedit3 in 'TXTEDIT3.PAS' {FindDlg},
  Txtedit4 in 'Txtedit4.pas' {ReplDlg};

{$R *.RES}

begin
  Application.CreateForm(TEditForm, EditForm);
  Application.CreateForm(TEditAbout, EditAbout);
  Application.CreateForm(TFindDlg, FindDlg);
  Application.CreateForm(TReplDlg, ReplDlg);
  Application.Run;
end.
