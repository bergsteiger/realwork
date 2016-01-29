{$I DFS.INC}

unit DFSStatusBarReg;

interface

uses
  {$IFDEF DFS_NO_DSGNINTF}
  DesignIntf,
  DesignEditors;
  {$ELSE}
  DesgnIntf;
  {$ENDIF}

type
  TdfsStatusBarEditor = class(TDefaultEditor)
  protected
    {$IFDEF DFS_IPROPERTY}
    procedure RunPropertyEditor(const Prop: IProperty);
    {$ELSE}
    procedure RunPropertyEditor(Prop: TPropertyEditor);
    {$ENDIF}
  public
    procedure ExecuteVerb(Index : Integer); override;
    function GetVerb(Index : Integer): string; override;
    function GetVerbCount : Integer; override;
    procedure Edit; override;
  end;

procedure Register;

implementation

uses
  Dialogs, Windows, DFSStatusBar, DFSAbout, Classes, SysUtils, TypInfo;

procedure Register;
begin
  RegisterComponents('DFS', [TdfsStatusBar]);
  RegisterPropertyEditor(TypeInfo(string), TdfsStatusBar, 'Version',
     TdfsVersionProperty);
  { We have to replace the panels editor that's registered for TStatusBar with
    our own because otherwise it would edit the TStatusBar.Panels property,
    which is of the type TStatusPanels.  We don't want that because it doesn't
    know about our new stuff in TdfsStatusPanel. }
  RegisterComponentEditor(TdfsStatusBar, TdfsStatusBarEditor);
end;


{ TdfsStatusBarEditor }

procedure TdfsStatusBarEditor.Edit;
var
  {$IFDEF DFS_DESIGNERSELECTIONS}
  Components: IDesignerSelections;
  {$ELSE}
  {$IFDEF DFS_COMPILER_5_UP}
  Components: TDesignerSelectionList;
  {$ELSE}
  Components: TComponentList;
  {$ENDIF}
  {$ENDIF}
begin
  {$IFDEF DFS_DESIGNERSELECTIONS}
  Components := CreateSelectionList;
  {$ELSE}
  {$IFDEF DFS_COMPILER_5_UP}
  Components := TDesignerSelectionList.Create;
  {$ELSE}
  Components := TComponentList.Create;
  {$ENDIF}
  {$ENDIF}
  try
  	Components.Add(Component);
  	GetComponentProperties(Components, [tkClass], Designer, RunPropertyEditor);
  finally
    {$IFNDEF DFS_DESIGNERSELECTIONS}
  	Components.Free;
    {$ENDIF}
  end;
end;

procedure TdfsStatusBarEditor.RunPropertyEditor(
{$IFDEF DFS_IPROPERTY}
  const Prop: IProperty
{$ELSE}
  Prop: TPropertyEditor
{$ENDIF}
);
begin
  if UpperCase(Prop.GetName) = 'PANELS' then
    Prop.Edit;
end;

procedure TdfsStatusBarEditor.ExecuteVerb(Index: Integer);
begin
  if Index <> 0 then Exit; { We only have one verb, so exit if this ain't it }
  Edit;  { Invoke the Edit function the same as if double click had happened }
end;


function TdfsStatusBarEditor.GetVerb(Index: Integer): string;
begin
  Result := '&Panels Editor...';  { Menu item caption for context menu }
end;

function TdfsStatusBarEditor.GetVerbCount: Integer;
begin
  Result := 1; // Just add one menu item.
end;


end.


