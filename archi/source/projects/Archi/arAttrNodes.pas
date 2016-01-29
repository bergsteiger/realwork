unit arAttrNodes;
{* Рализации ноды - контейнера атрибута документа. }

{ Автор: Бабанин В.Б.}
{ Начат: 23.11.2005 }
{ $Id: arAttrNodes.pas,v 1.14 2015/02/02 14:16:02 kostitsin Exp $ }

interface

uses
 l3Interfaces, l3InternalInterfaces,
 l3Nodes, l3Tree_TLB,
 l3IID,
 l3TreeInterfaces,
 DocAttrIntf;

type
 IarAttributeContainer = interface(Il3Base)
  ['{390309BF-525B-4183-9082-3087BF95FA61}']
  function GetAttribute: IListDocAttribute;
  procedure SetAttribute(aValue: IListDocAttribute);
  property Attribute: IListDocAttribute read GetAttribute write SetAttribute;
 end;

 TarAttributeContainerNode = class(Tl3CustomListContainerNode, {Il3Node, Il3HandleNode, Il3ItemNotifyRecipient, }IarAttributeContainer)
 protected
  fAttribute: IListDocAttribute;

  //function GetItems: Il3HandledStringList;

  function GetAttribute: IListDocAttribute;
  procedure SetAttribute(aValue: IListDocAttribute);

  function GetItemsCount: Integer; override;

  procedure ListChanged(Sender: TObject);
  procedure ListChanging(Sender: TObject);

  procedure DeleteChildItem(aIndex: Integer;
                            const aDelete: Il3Node); override;

  procedure MoveChildItemPrim(aCurIndex, aNewIndex : Integer); override;

  function pm_GetStrings(aIndex: Integer): Tl3WString; override;
  procedure pm_SetStrings(aIndex: Integer; const Value: Tl3WString); override;

  function pm_GetItemParam(aIndex: Integer): Integer; override;
  procedure pm_SetItemParam(aIndex: Integer; aValue: Integer); override;

  function pm_GetItemFlag(aIndex: Integer): Integer; override;
  procedure pm_SetItemFlag(aIndex: Integer; aValue: Integer); override;

  procedure Cleanup; override;

  function MakeChildNode: Tl3ListItemNode; override;

  procedure ListNotify(const aNotifier : Il3ChangeNotifier;
                             aOperation      : Integer;
                             aIndex          : Integer);

  procedure ItemNotify(const aNotifier : Il3ChangeNotifier;
                       aOperation      : Integer;
                       aIndex          : Integer); override;
//  procedure Il3ItemNotifyRecipient.Notify = ListNotify;

  //property Items: Il3HandledStringList read GetItems;

 public
  function COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult; override;

  procedure DoReleaseChilds; override;
  property Attribute: IListDocAttribute read GetAttribute write SetAttribute;
 end;//Tl3ListContainerNode

implementation
uses
 l3Types,
 l3String,
 l3InterfacesMisc;

{Tl3ListContainerNode}

procedure TarAttributeContainerNode.Cleanup;
begin
 Attribute := nil;
 inherited;
end;

function TarAttributeContainerNode.COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
begin
 if IID.SomeOf([IListDocAttribute]) then
  Result := Tl3HResult_C(l3QueryInterface(Attribute, IID, Obj))
 else
  Result := inherited COMQueryInterface(IID, Obj);
end;

procedure TarAttributeContainerNode.DeleteChildItem(aIndex: Integer; const aDelete: Il3Node);
begin
 Attribute.Delete(aIndex);
 //Inherited DeleteChildItem(aIndex,anOpProc, aDelete);  посылает Notify об удалении, который итак приходит от листа
end;

function TarAttributeContainerNode.pm_GetItemFlag(aIndex: Integer): Integer;
begin
 Result := 0; //PChar(Items.Strings[aIndex]);
end;

function TarAttributeContainerNode.pm_GetItemParam(aIndex: Integer): Integer;
begin
 Result := Integer(Attribute.Handle[aIndex]);
end;

function TarAttributeContainerNode.GetAttribute: IListDocAttribute;
begin
 Result := fAttribute;
end;

function TarAttributeContainerNode.GetItemsCount: Integer;
begin
 if Attribute <> nil then
  Result := Attribute.Count
 else
  Result := 0;
end;

function TarAttributeContainerNode.pm_GetStrings(aIndex: Integer): Tl3WString;
begin
 Result := Attribute.ViewString[aIndex];
end;

procedure TarAttributeContainerNode.ListChanged(Sender: TObject);
begin
 Changed;
end;

procedure TarAttributeContainerNode.ListChanging(Sender: TObject);
begin
 Changing;
end;

procedure TarAttributeContainerNode.ListNotify(const aNotifier : Il3ChangeNotifier; aOperation : Integer; aIndex : Integer);
begin
 AllChildrenCount := GetItemsCount;
 case aOperation of
  ntClear       : Il3Node(Self).Notify(ntChildClear, Self);
  ntChildClear,
  ntChildInsert : Il3Node(Self).Notify(aOperation, Self);
 else
  Il3Node(Self).Notify(aOperation, GetChildByNumber(aIndex));
 end;
end;

procedure TarAttributeContainerNode.ItemNotify(const aNotifier : Il3ChangeNotifier;
                     aOperation      : Integer;
                     aIndex          : Integer);
begin
 ListNotify(aNotifier, aOperation, aIndex);
 //inherited;
end;

function TarAttributeContainerNode.MakeChildNode: Tl3ListItemNode;
begin
 Result := Tl3ListItemNode.Create;
end;

procedure TarAttributeContainerNode.MoveChildItemPrim(aCurIndex, aNewIndex : Integer);
begin
 //Items.Move(aCurIndex, aNewIndex);
end;

procedure TarAttributeContainerNode.DoReleaseChilds;
begin
 Changing;
 try
  Il3Node(Self).Notify(ntChildClear, Self);
  Attribute := nil;
 finally
  Changed;
 end;
end;

procedure TarAttributeContainerNode.pm_SetItemFlag(aIndex: Integer; aValue: Integer);
begin
 {Items.Strings[aIndex] := GetStrPas(Value);}
end;

procedure TarAttributeContainerNode.pm_SetItemParam(aIndex: Integer; aValue: Integer);
begin
 //Attribute.Handle[aIndex] := aValue;
end;

procedure TarAttributeContainerNode.SetAttribute(aValue: IListDocAttribute);
begin
 if fAttribute = aValue then
  Exit;

 Changing;
 try
  if fAttribute <> nil then
  begin
   Il3Node(Self).Notify(ntChildClear, Self);
   with (fAttribute as Il3ChangeNotifier) do
   begin
    Unsubscribe(Self as Il3ItemNotifyRecipient);
    Unsubscribe(Self as Il3ChangeRecipient);
   end;
  end;

  fAttribute := aValue;

  if fAttribute <> nil then
  begin
   with (fAttribute as Il3ChangeNotifier) do
   begin
    Subscribe(Self as Il3ItemNotifyRecipient);
    Subscribe(Self as Il3ChangeRecipient);
   end;
   IncAllChildrenCount(fAttribute.Count - ChildCount);
   Il3Node(Self).Notify(ntChildInsert, Self);
  end;
 finally
  Changed;
 end;
end;

procedure TarAttributeContainerNode.pm_SetStrings(aIndex: Integer; const Value: Tl3WString);
begin
 Attribute.ViewString[aIndex] := Tl3PCharLen(Value);
end;


end.
