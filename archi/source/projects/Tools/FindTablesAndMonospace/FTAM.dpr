program FTAM;

{ $Id: FTAM.dpr,v 1.1 2010/05/24 07:51:46 fireton Exp $ }

// $Log: FTAM.dpr,v $
// Revision 1.1  2010/05/24 07:51:46  fireton
// - initial commit
//
// Revision 1.1  2010/04/16 09:15:42  fireton
// - initial commit
//

uses
  evdSchema,
  Forms,
  Main in 'Main.pas' {MainForm}
  ;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
