program Double2Single;

{ $Id: Double2Single.dpr,v 1.1 2011/02/25 09:51:42 narry Exp $ }

// $Log: Double2Single.dpr,v $
// Revision 1.1  2011/02/25 09:51:42  narry
// �254354365. ������� ����������� ������� ����������
//

uses
  evdSchema,
  Forms,
  Main in 'Main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '"����������". ����������� ������� ����������.';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
