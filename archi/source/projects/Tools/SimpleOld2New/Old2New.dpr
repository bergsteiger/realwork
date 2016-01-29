program Old2New;

{ $Id: Old2New.dpr,v 1.1 2004/10/05 16:19:32 step Exp $ }
// $Log: Old2New.dpr,v $
// Revision 1.1  2004/10/05 16:19:32  step
// занесено в CVS
//

uses
  Forms,
  Main in 'Main.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
