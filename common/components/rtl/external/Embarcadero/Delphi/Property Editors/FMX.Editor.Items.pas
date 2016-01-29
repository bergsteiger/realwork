{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Editor.Items;

interface

uses
  DesignEditors, DesignMenus, DesignIntf,
  Classes, Vcl.Menus,
  FMX.Types, FmxDsnConst, FMX.Design.Items;

const
  EDITOR_OPEN_DESIGNER = 0;
  EDITOR_CREATE_ITEM = 1;

type

{ TItemsEditor }

  /// <summary>
  ///   Items Editor Base Classes for controls, which haves list of items.
  ///   It allows to create list of member of different classes.
  /// </summary>
  TItemsEditor = class(TComponentEditor)
  protected
    FAllowChild: Boolean;
    FItemsClasses: array of TItemClassDesc;
    procedure DoCreateItem(Sender: TObject); virtual;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure PrepareItem(Index: Integer; const AItem: IMenuItem); override;
    procedure Edit; override;
  end;

{ TMenuEditor }

  TMenuEditor = class(TItemsEditor)
  public
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
  end;

{ TListBoxEditor }

  TListBoxEditor = class(TItemsEditor)
  public
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
  end;

{ TTreeViewEditor }

  TTreeViewEditor = class(TItemsEditor)
  public
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
  end;

{ THeaderEditor }

  THeaderEditor = class(TItemsEditor)
  public
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
  end;

{ TTabControlEditor }

  TTabControlEditor = class(TItemsEditor)
  public
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
  end;

{ TGridEditor }

  TGridEditor = class(TItemsEditor)
  public
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
  end;

{ TStringGridEditor }

  TStringGridEditor = class(TItemsEditor)
  public
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
  end;

{ TEditEditor }

  TEditEditor = class(TItemsEditor)
  public
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
  end;

implementation

uses
  System.SysUtils, FMX.Forms, FMX.TreeView, FMX.Header, FMX.Grid,
  FMX.ListBox, FMX.TabControl, FMX.Menus, FMX.Design.Style, Vcl.Controls,
  Windows, FMX.Platform.Win, FMX.Design.Lang, ActnEdit, FMX.ActnList, DsnConst,
  FMX.Controls, FMX.Edit;

{$REGION 'TItemsEditor'}

procedure TItemsEditor.DoCreateItem(Sender: TObject);
var
  MenuItem: VCL.Menus.TMenuItem;
  Item: TFmxObject;
  IndexOfItemClass: Integer;
begin
  if Sender is VCL.Menus.TMenuItem then
  begin
    MenuItem := Sender as VCL.Menus.TMenuItem;
    if Component is TFmxObject then
    begin
      IndexOfItemClass := MenuItem.Tag;
      Item := FItemsClasses[IndexOfItemClass].ItemClass.Create(Designer.GetRoot);
      Item.Parent := TFmxObject(Component);
      Item.Name := Designer.UniqueName(Item.ClassName);
      Designer.SelectComponent(Item);
    end;
  end;
end;

procedure TItemsEditor.Edit;
begin
  ExecuteVerb(0);
end;

procedure TItemsEditor.ExecuteVerb(Index: Integer);
var
  Container: IItemsContainer;
begin
  if Index = EDITOR_OPEN_DESIGNER then
  begin
    if Assigned(DesignItemsForm) then
      FreeAndNil(DesignItemsForm);

    DesignItemsForm := TDesignItemsForm.Create(Application);

    if Supports(Component, IItemsContainer, Container) then
    begin
      DesignItemsForm.btnAddChild.Visible := FAllowChild;
      DesignItemsForm.Designer := Designer;
      DesignItemsForm.SetItemClasses(Container, FItemsClasses);
      DesignItemsForm.Show;
    end;
  end;
end;

function TItemsEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    EDITOR_CREATE_ITEM: Result := SNewItem;
  else
    Result := SItemsEditor;
  end;
end;

function TItemsEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

procedure TItemsEditor.PrepareItem(Index: Integer; const AItem: IMenuItem);
var
  I: Integer;
  MenuItem: IMenuItem;
begin
  inherited PrepareItem(Index, AItem);
  if Index = EDITOR_CREATE_ITEM then
  begin
    for I := 0 to High(FItemsClasses) do
    begin
      MenuItem := AItem.AddItem(FItemsClasses[I].ItemClass.ClassName, 0, False, True, DoCreateItem );
      MenuItem.Tag := I;
      MenuItem := nil;
    end;
  end;
end;

{$ENDREGION}

{$REGION 'TMenuEditor'}

constructor TMenuEditor.Create(AComponent: TComponent; ADesigner: IDesigner);
begin
  inherited Create(AComponent, ADesigner);
  FAllowChild := true;
  SetLength(FItemsClasses, 1);
  FItemsClasses[0] := TItemClassDesc.Create(FMX.Menus.TMenuItem, True);
end;

{$ENDREGION}

{$REGION 'TListBoxEditor'}

constructor TListBoxEditor.Create(AComponent: TComponent; ADesigner: IDesigner);
begin
  inherited Create(AComponent, ADesigner);
  FAllowChild := false;
  SetLength(FItemsClasses, 6);
  FItemsClasses[0] := TItemClassDesc.Create(TListBoxItem);
  FItemsClasses[1] := TItemClassDesc.Create(TMetropolisUIListBoxItem);
  FItemsClasses[2] := TItemClassDesc.Create(TListBoxHeader, False, True);
  FItemsClasses[3] := TItemClassDesc.Create(TSearchBox, False, True);
  FItemsClasses[4] := TItemClassDesc.Create(TListBoxGroupHeader);
  FItemsClasses[5] := TItemClassDesc.Create(TListBoxGroupFooter);
end;

{$ENDREGION}

{$REGION 'TTreeViewEditor'}

constructor TTreeViewEditor.Create(AComponent: TComponent; ADesigner: IDesigner);
begin
  inherited Create(AComponent, ADesigner);
  FAllowChild := true;
  SetLength(FItemsClasses, 1);
  FItemsClasses[0] := TItemClassDesc.Create(TTreeViewItem, True);
end;

{$ENDREGION}

{$REGION 'THeaderEditor'}

constructor THeaderEditor.Create(AComponent: TComponent; ADesigner: IDesigner);
begin
  inherited Create(AComponent, ADesigner);
  FAllowChild := false;
  SetLength(FItemsClasses, 1);
  FItemsClasses[0] := TItemClassDesc.Create(THeaderItem);
end;

{$ENDREGION}

{$REGION 'TTabControlEditor'}

constructor TTabControlEditor.Create(AComponent: TComponent; ADesigner: IDesigner);
begin
  inherited Create(AComponent, ADesigner);
  FAllowChild := false;
  SetLength(FItemsClasses, 1);
  FItemsClasses[0] := TItemClassDesc.Create(TTabItem);
end;

{$ENDREGION}

{$REGION 'TGridEditor'}

constructor TGridEditor.Create(AComponent: TComponent; ADesigner: IDesigner);
begin
  inherited Create(AComponent, ADesigner);
  FAllowChild := False;
  SetLength(FItemsClasses, 6);
  FItemsClasses[0] := TItemClassDesc.Create(TColumn);
  FItemsClasses[1] := TItemClassDesc.Create(TCheckColumn);
  FItemsClasses[2] := TItemClassDesc.Create(TStringColumn);
  FItemsClasses[3] := TItemClassDesc.Create(TProgressColumn);
  FItemsClasses[4] := TItemClassDesc.Create(TPopupColumn);
  FItemsClasses[5] := TItemClassDesc.Create(TImageColumn);
end;

{$ENDREGION}

{$REGION 'TStringGridEditor'}

constructor TStringGridEditor.Create(AComponent: TComponent; ADesigner: IDesigner);
begin
  inherited Create(AComponent, ADesigner);
  FAllowChild := False;
  SetLength(FItemsClasses, 1);
  FItemsClasses[0] := TItemClassDesc.Create(TStringColumn);
end;

{$ENDREGION}

{$REGION 'TEditEditor'}

constructor TEditEditor.Create(AComponent: TComponent; ADesigner: IDesigner);
begin
  inherited Create(AComponent, ADesigner);
  FAllowChild := False;
  SetLength(FItemsClasses, 6);
  FItemsClasses[0] := TItemClassDesc.Create(TEditButton);
  FItemsClasses[1] := TItemClassDesc.Create(TClearEditButton);
  FItemsClasses[2] := TItemClassDesc.Create(TPasswordEditButton);
  FItemsClasses[3] := TItemClassDesc.Create(TSearchEditButton);
  FItemsClasses[4] := TItemClassDesc.Create(TEllipsesEditButton);
  FItemsClasses[5] := TItemClassDesc.Create(TDropDownEditButton);
end;

{$ENDREGION}

end.
