program LoadData;

{ $Id: LoadData.dpr,v 1.1 2004/07/23 13:05:23 step Exp $ }
// $Log: LoadData.dpr,v $
// Revision 1.1  2004/07/23 13:05:23  step
// утилита занесена в CVS
//

uses
  Forms,
  MainForm in 'MainForm.pas' {Main},
  DataLoader in 'DataLoader.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
