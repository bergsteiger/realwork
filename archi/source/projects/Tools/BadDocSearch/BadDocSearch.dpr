program BadDocSearch;

{ $Id: BadDocSearch.dpr,v 1.1 2004/08/30 17:09:35 step Exp $ }
// $Log: BadDocSearch.dpr,v $
// Revision 1.1  2004/08/30 17:09:35  step
// �������� � CVS
//

uses
  Forms,
  Main in 'Main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '����� ������� ����������, ��������� � ���������, �� ������������� � ��';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
