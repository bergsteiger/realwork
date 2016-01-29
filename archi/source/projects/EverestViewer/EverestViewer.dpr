program EverestViewer;

// $Id: EverestViewer.dpr,v 1.6 2002/07/26 16:02:09 law Exp $

// $Log: EverestViewer.dpr,v $
// Revision 1.6  2002/07/26 16:02:09  law
// - new: добавлено оглавление и кнопки открытия уровней.
//
// Revision 1.5  2001/09/14 12:51:23  law
// - new behavior: добавлена возможность показы структуры документа и работа с дополнительными форматами.
//
// Revision 1.4  2001/09/14 12:35:12  law
// - change: вставлены директивы CVS.
//

uses
  evExtActionsRes,
  evReadOnlyExtActions,
  evExtFormat,
  Forms,
  Main in 'Main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
