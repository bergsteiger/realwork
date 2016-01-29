{
//
// Components : IfcCollection
//
// Copyright (c) 1998 by Woll2Woll Software
//
}

unit fcCollection;

interface

{$i fcIfDef.pas}

uses Classes, Controls, Windows, ActiveX, SysUtils, Dialogs;

type
  TfcCollectionItem = class;
  TfcCollection = class;

  TfcSelectionMethod = procedure(Item: TfcCollectionItem) of object;

  TfcCollectionItem = class(TCollectionItem)
  private
    FPointerTag: Pointer;
    FSelectionMethod: TfcSelectionMethod;
    FTag: Integer;
    FOnRefreshDesign: TNotifyEvent;
  protected
    procedure SetSelectionMethod(Value: TfcSelectionMethod); virtual;
    procedure RefreshDesign; virtual;
  public
    function GetInstance(const PropertyName: string): TPersistent; virtual;
    procedure GotSelected; virtual;
    procedure SetButtonName(Sender: TObject);
    property PointerTag: Pointer read FPointerTag write FPointerTag;
    property SelectionMethod: TfcSelectionMethod read FSelectionMethod write SetSelectionMethod;
    property Tag: Integer read FTag write FTag;
    property OnRefreshDesign: TNotifyEvent read FOnRefreshDesign write FOnRefreshDesign;
  end;

  TfcCollection = class(TCollection)
  private
    FDesigner: TControl;
    function GetItems(Index: Integer): TfcCollectionItem;
  protected
    procedure SetDesigner(Value: TControl); virtual;
  public
    destructor Destroy; override;

    function AddItem: TfcCollectionItem; virtual;

    property Designer: TControl read FDesigner write SetDesigner;
    property Items[Index: Integer]: TfcCollectionItem read GetItems;
  end;

implementation

procedure TfcCollectionItem.RefreshDesign;
begin
   if Assigned(FOnRefreshDesign) then FOnRefreshDesign(self);
end;

function TfcCollectionItem.GetInstance(const PropertyName: string): TPersistent;
begin
  result := self;
end;

procedure TfcCollectionItem.GotSelected;
begin
end;

procedure TfcCollectionItem.SetSelectionMethod(Value: TfcSelectionMethod);
begin
end;

destructor TfcCollection.Destroy;
begin
  if Designer <> nil then Designer.Free;
  inherited;
end;

procedure TfcCollectionItem.SetButtonName(Sender: TObject);
begin
  with (Collection as TfcCollection) do
    if Designer <> nil then Designer.Update;
end;

function TfcCollection.AddItem: TfcCollectionItem;
begin
  result := Add as TfcCollectionItem;
end;

function TfcCollection.GetItems(Index: Integer): TfcCollectionItem;
begin
  result := TfcCollectionItem(inherited Items[Index]);
end;

procedure TfcCollection.SetDesigner(Value: TControl);
begin
  FDesigner := Value;
end;

end.
