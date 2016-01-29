{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DTreeEdReg;

interface

procedure Register;

implementation
{$I dc.inc}
uses
  Classes, controls, comctrls,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  {$IFDEF D4}imglist,{$ENDIF}
  dcconsts, dcdtree, dcgen, dcimged, dtreeed, dcsystem;

type
  TDrawItemsEditor = class(TClassProperty)
  public
    function  GetAttributes : TPropertyAttributes; override;
    procedure Edit; override;
  end;

  TDrawTreeViewEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TDrawListViewEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TDrawTreeStateEdit = class(TTreeImageIndexEdit)
  public
    function  GetImage : TCustomImageList; override;
  end;

{---------TDrawItemsEditor-----------------------------------------}

function  TDrawItemsEditor.GetAttributes : TPropertyAttributes;
begin
  result := [paReadOnly,paDialog];
end;

{------------------------------------------------------------------}

procedure TDrawItemsEditor.Edit;
begin
  if GetComponent(0) is TCustomDCDrawTreeView then
    EditDrawTree(TCustomDCDrawTreeView(GetComponent(0)));
end;

{----TDrawTreeViewEditor--------------------------------------------}

procedure TDrawTreeViewEditor.ExecuteVerb(Index: Integer);
begin
  EditDrawTree(TCustomDCDrawTreeView(Component));
end;

{------------------------------------------------------------------}

function TDrawTreeViewEditor.GetVerb(Index: Integer): string;
begin
  result := SVerbItemsEditor;
end;

{------------------------------------------------------------------}

function TDrawTreeViewEditor.GetVerbCount: Integer;
begin
  result := 1;
end;

{----TDrawListViewEditor--------------------------------------------}

procedure TDrawListViewEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0 : CallPropertyEdit(Component, 'Columns'); // don't resource
    1 : CallPropertyEdit(Component, 'Items');   // don't resource
  end;
end;

{------------------------------------------------------------------}

function TDrawListViewEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0 : result := SVerbColumnsEditor;
    1 : result := SVerbItemsEditor;
  end;
end;

{------------------------------------------------------------------}

function TDrawListViewEditor.GetVerbCount: Integer;
begin
  result := 2;
end;

{----------TDrawTreeStateEdit-----------------------------------------}

function TDrawTreeStateEdit.GetImage : TCustomImageList;
var
  Tree : TCustomTreeView;
begin
  result := nil;
  Tree := GetTreeView;
  if Assigned(Tree) then
    result := TMTree(Tree).StateImages;
end;

{------------------------------------------------------------------}

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(TTreeNodes),TDCDrawTreeView, 'Items',TDrawItemsEditor);
  RegisterPropertyEditor(TypeInfo(TTreeNodes),TDCMSTreeView, 'Items',TDrawItemsEditor);
  RegisterComponentEditor(TDCDrawTreeView,TDrawTreeViewEditor);
  RegisterComponentEditor(TDCMSTreeView,TDrawTreeViewEditor);
  RegisterComponentEditor(TCustomDrawListView,TDrawListViewEditor);
  RegisterPropertyEditor(TypeInfo(integer),TDrawNode,'ImageIndex',TTreeImageIndexEdit);
  RegisterPropertyEditor(TypeInfo(integer),TDrawNode,'SelectedIndex',TTreeImageIndexEdit);
  RegisterPropertyEditor(TypeInfo(integer),TDrawNode,'StateIndex',TDrawTreeStateEdit);
end;

end.
