program ToolbarComparator;

uses
  Forms,
  evdSchema,
  Main in 'Main.pas' {fmMain},
  tcInterfaces in 'tcInterfaces.pas',
  tcBuilder in 'tcBuilder.pas',
  tcItem in 'tcItem.pas',
  tcItemList in 'tcItemList.pas',
  tcOperation in 'tcOperation.pas',
  tcOperationsList in 'tcOperationsList.pas',
  tcToolBar in 'tcToolBar.pas',
  tcToolBarsList in 'tcToolBarsList.pas',
  tcDifference in 'tcDifference.pas',
  tcAddedToolBar in 'tcAddedToolBar.pas',
  tcChangedToolBar in 'tcChangedToolBar.pas',
  tcAddedToolBarsList in 'tcAddedToolBarsList.pas',
  tcChangedToolBarsList in 'tcChangedToolBarsList.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
