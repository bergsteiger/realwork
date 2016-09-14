﻿{$IfNDef TmsItemsHolder_uses_intf}
// Объект содержащий список других объектов

// interface

{$Define TmsItemsHolder_uses_intf}

// uses
 Generics.Collections,
 Data.DBXJSONReflect,
 System.Rtti

{$Else TmsItemsHolder_uses_intf}

{$IfNDef TmsItemsHolder_intf}
// http://programmingmindstream.blogspot.ru/2014/12/generic-2.html

{$Define TmsItemsHolder_intf}

 TmsRttiFieldLambda = reference to procedure (aField: TRttiField);

 TmsItemsList = TList<TmsItem>;
 TmsItemsListEnumerator = TEnumerator<TmsItem>;

 TmsItemsHolder = class abstract(TmsItemsHolderParent)
 private
  [JSONMarshalled(True)]
  f_Items : TmsItemsList;
  function pm_GetItems: TmsItemsList;
  procedure pm_SetItems(aValue: TmsItemsList);
  class procedure RegisterItemsLike(aLambda: TmsRttiFieldLambda);
 protected
  function ItemsCount: Integer;
 private
  property _Items: TmsItemsList read pm_GetItems write pm_SetItems;
 protected
  procedure ItemAdded(const anItem: TmsItem); virtual;
  function FirstItem: TmsItem;
 public
  constructor Create;
  procedure Cleanup; override;
  procedure Assign(anOther : TmsItemsHolder);
  class procedure RegisterInMarshal(aMarshal: TJSONMarshal);
  class procedure RegisterInUnMarshal(aMarshal: TJSONUnMarshal);
  function GetEnumerator: TmsItemsListEnumerator;
  function IndexOf(const anItem: TmsItem): Integer;
  procedure Add(const anItem: TmsItem);
 end;//TmsItemsHolder

{$Else TmsItemsHolder_intf}

// implementation

{$IfNDef TmsItemsHolder_uses_impl}

// uses
  System.TypInfo,
  msGarbageCollector

{$Define TmsItemsHolder_uses_impl}

{$Else TmsItemsHolder_uses_impl}

// TmsItemsHolder

constructor TmsItemsHolder.Create;
begin
 inherited;
 Assert(f_Items = nil);
 f_Items := TmsItemsList.Create;
end;

procedure TmsItemsHolder.Cleanup;
begin
 FreeAndNil(f_Items);
 inherited;
end;

function TmsItemsHolder.pm_GetItems: TmsItemsList;
begin
 if (f_Items = nil) then
  f_Items := TmsItemsList.Create;
 Result := f_Items;
end;

procedure TmsItemsHolder.pm_SetItems(aValue: TmsItemsList);
var
 l_Item : TmsItem;
begin
 if (f_Items <> nil) then
  f_Items.Clear;
 if (aValue <> nil) then
  for l_Item in aValue do
  begin
   if (f_Items = nil) then
    f_Items := TmsItemsList.Create;
   Self.Add(l_Item);
  end;//for l_Shape in aValue
end;

procedure TmsItemsHolder.Assign(anOther : TmsItemsHolder);
begin
 Self._Items := anOther._Items;
end;

class procedure TmsItemsHolder.RegisterItemsLike(aLambda: TmsRttiFieldLambda);
var
 l_Field : TRttiField;
begin
 for l_Field in TRttiContext.Create.GetType(Self).GetFields do
  if (l_Field.Visibility = mvPrivate) then
   if (l_Field.Name = 'f_Items') then
   begin
    aLambda(l_Field);
    Exit;
   end;//l_Field.Name = 'f_Items'
 Assert(false, 'Не найдено поля для Items');
end;

class procedure TmsItemsHolder.RegisterInMarshal(aMarshal: TJSONMarshal);
begin
 RegisterItemsLike(
  procedure (aField: TRttiField)
  var
   l_FieldName : String;
  begin
   l_FieldName := aField.Name;
   aMarshal.RegisterConverter(Self, l_FieldName,
    function (Data: TObject; Field: String): TListOfObjects
    var
     l_Item: TmsItem;
     l_Index: Integer;
    begin
     Assert(Field = l_FieldName);
     if ((Data As TmsItemsHolder).ItemsCount <= 0) then
     begin
      Result := nil;
      Exit;
     end;//Data As TmsItemsHolder).ItemsCount <= 0
     SetLength(Result, (Data As TmsItemsHolder).ItemsCount);
     l_Index := 0;
     for l_Item in (Data As TmsItemsHolder) do
     begin
      Result[l_Index] := l_Item.toObject;
      Inc(l_Index);
     end;//for l_Item
    end
   );//aMarshal.RegisterConverter
  end
 );//RegisterItemsLike
 aMarshal.RegisterJSONMarshalled(Self, 'FRefCount', false);
end;

class procedure TmsItemsHolder.RegisterInUnMarshal(aMarshal: TJSONUnMarshal);
begin
 RegisterItemsLike(
  procedure (aField: TRttiField)
  var
   l_FieldName : String;
  begin
   l_FieldName := aField.Name;
   aMarshal.RegisterReverter(Self, l_FieldName,
    procedure (Data: TObject; Field: String; Args: TListOfObjects)
    var
     l_Object: TObject;
     l_Holder : TmsItemsHolder;
     l_ItemI : TmsItem;
     l_C : Integer;
    begin
     Assert(Field = l_FieldName);
     l_Holder := Data As TmsItemsHolder;
     Assert(l_Holder <> nil);

     l_C := l_Holder._AddRef;
     Assert(l_C > 0);
     try
      for l_Object in Args do
      begin
       if Supports(l_Object, TmsItem, l_ItemI) then
        try
         l_Holder.Add(l_ItemI);
        finally
         l_ItemI := nil;
        end
       else
        raise Exception.Create(l_Object.ClassName + ' не поддерживает нужный интерфейс');
      end//for l_Object
     finally
      if (l_C = 1) then
       TmsGarbageCollector.Instance.Add(l_Holder);
      l_Holder._Release;
     end;//try..finally
    end
   );//aMarshal.RegisterReverter
  end
 );//RegisterItemsLike
end;

function TmsItemsHolder.GetEnumerator: TmsItemsListEnumerator;
begin
 Result := f_Items.GetEnumerator;
end;

function TmsItemsHolder.IndexOf(const anItem: TmsItem): Integer;
begin
 Result := _Items.IndexOf(anItem);
end;

function TmsItemsHolder.ItemsCount: Integer;
begin
 Result := _Items.Count;
end;

procedure TmsItemsHolder.ItemAdded(const anItem: TmsItem);
begin
end;

procedure TmsItemsHolder.Add(const anItem: TmsItem);
begin
 _Items.Add(anItem);
 ItemAdded(anItem);
end;

function TmsItemsHolder.FirstItem: TmsItem;
begin
 Result := _Items.First;
end;

{$EndIf TmsItemsHolder_uses_impl}

{$EndIf TmsItemsHolder_intf}
{$EndIf TmsItemsHolder_uses_intf}
