program EverestHelper;

// $Id: EverestHelper.dpr,v 1.4 2004/01/06 15:11:59 law Exp $

// $Log: EverestHelper.dpr,v $
// Revision 1.4  2004/01/06 15:11:59  law
// - bug fix: корректно прописаны пути к библиотекам.
//
// Revision 1.3  2001/09/14 12:35:17  law
// - change: вставлены директивы CVS.
//

uses
  evttStd,
  Forms,
  main in 'main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  MainForm.Show;
  MainForm.ProcessFiles;
  Application.Terminate;
  Application.Run;
end.
