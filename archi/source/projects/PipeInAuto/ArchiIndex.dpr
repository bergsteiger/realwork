program ArchiIndex;

uses
  evdSchema,
  Forms,
  IndexForm in 'IndexForm.pas' {ArchiIndexForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '���������� ���� "�����������"';
  Application.CreateForm(TArchiIndexForm, ArchiIndexForm);
  Application.Run;
end.
