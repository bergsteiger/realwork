unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, OvcBase,  evEditorWindow,
  evMultiSelectEditorWindow, evCustomEditor, evEditorWithOperations,
  evTunedEditor, evEditor, l3InterfacedComponent, l3ProgressComponent,
  evTextSource, evEditorWindowTextSource,
  afwControl, vtPanel;

type
  TMainForm = class(TForm)
    Toolbar: TvtPanel;
    Footer: TvtPanel;
    evEditor1: TevEditor;
    TextSource: TevTextSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

end.
