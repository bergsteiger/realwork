unit l3IDList;
 {*Лист идентификаторов с математикой (объединение, вычитание, пересечение)}

// Модуль: "w:\common\components\rtl\Garant\L3\l3IDList.pas"
//?? Стереотип: "SimpleClass"
//?? Элемент модели: "Tl3LongintList" MUID: (47BB29D40117)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3LongintList,
 l3Interfaces;

 type
  TID = longint;

  //!! Нужно объединить с функциональностью l3ListOperations.imp.pas

  Tl3IDList = class;

  Il3IDList = interface(Il3Base)
   ['{0A44CBB6-43E0-40AE-B373-F00B0BC89505}']

   function GetSelf : Tl3IDList;

   function Get_Count: Integer;
   function Get_Items(anIndex: Integer): Integer;
   function pm_GetEmpty: Boolean;
   //procedure Save(aStream: TStream);
   //procedure Load(aStream: TStream);
   procedure Clear;
   procedure Add(anItem : TID);
   procedure Delete(anItem: TID);
   function IndexOf(anItem: TID) : integer;

   procedure SubtractList(aList : Il3IDList);
    { - вычитание}
   procedure MergeList(aAddList : Il3IDList);
    { - добавление}
   procedure InvertList(aBaseList : Il3IDList);
    { - инверсия относительно aBaseList, т е list := aBaseList - list}
   procedure AndList(aList : Il3IDList);


   //function AsIntegerList: Tl3IntegerList;
   property Count: Integer
    read Get_Count;
   property Items[anIndex: Integer]: Integer
    read Get_Items; default;
   property Empty: Boolean
    read pm_GetEmpty;
  end;

 Tl3IDList = class(Tl3LongintList, Il3IDList)
  protected
   function Get_Count: Integer;
   function Get_Items(anIndex: Integer): Integer;
  public
   constructor Create;
   function GetSelf : Tl3IDList;

   procedure Add(anItem : TID);

   procedure Delete(anItem: TID);

   function IndexOf(anItem: TID) : integer;

   procedure SubtractList(aList : Il3IDList);
    { - вычитание}
   procedure MergeList(aAddList : Il3IDList);
    { - добавление}
   procedure InvertList(aBaseList : Il3IDList);
    { - инверсия относительно aBaseList, т е list := aBaseList - list}
   procedure AndList(aList : Il3IDList);
    { - пересечение}
  end;


 function l3MakeIDList : Il3IDList;
implementation

uses
 //l3LongintList, //l3CardinalList
 l3Base;

function l3MakeIDList : Il3IDList;
var
 lList : Tl3IDList;
begin
 lList := Tl3IDList.Create;
 Result := lList;
 l3Free(lList);
end;

constructor Tl3IDList.Create;
begin
 Inherited Create;
 Sorted := True;
end;

function Tl3IDList.GetSelf : Tl3IDList;
begin
 Result := Self;
end;

function Tl3IDList.Get_Count: Integer;
begin
 Result := Count;
 empty;
end;

function Tl3IDList.Get_Items(anIndex: Integer): Integer;
begin
 Result := Items[anIndex];
end;

procedure Tl3IDList.Add(anItem : TID);
begin
 inherited Add(anItem);
end;

procedure Tl3IDList.Delete(anItem: TID);
begin
 inherited Delete(anItem);
end;

function Tl3IDList.IndexOf(anItem: TID) : integer;
begin
 Result := inherited IndexOf(anItem);
end;

procedure Tl3IDList.SubtractList(aList : Il3IDList);
var
 I, J : Longint;
begin
 I := Pred(Count);
 J := Pred(aList.Count);
 while (I >= 0) and (J >= 0) do
 begin
  //DoCompareItems(I, aList[J]);
  if Items[I] = aList[J] then
  begin
   Delete(I);
   Dec(J);
   Dec(I);
  end
  else
   if Items[I] > aList[J] then
    Dec(I)
   else
    Dec(J);
 end;
end;

procedure Tl3IDList.AndList(aList : Il3IDList);
var
 I, J : Longint;
begin
 I := Pred(Count);
 J := Pred(aList.Count);
 while (I >= 0) and (J >= 0) do
 begin
  //DoCompareItems(I, aList[J]);
  if Items[I] = aList[J] then
  begin
   //Delete(I);
   Dec(J);
   Dec(I);
  end
  else
   if Items[I] > aList[J] then
   begin
    Delete(I);
    Dec(I);
   end
   else
    Dec(J);
 end;
end;

procedure Tl3IDList.MergeList(aAddList : Il3IDList);
var
 I   : Integer;
 lCnt : Integer;
begin
 lCnt := aAddList.Count;
 if (lCnt = 0) then Exit;

 Capacity := Count + lCnt;
 for i := 0 to Pred(lCnt) do
  Add(aAddList[I]);
end;

procedure Tl3IDList.InvertList(aBaseList : Il3IDList);
var
 lCopyList : Tl3IDList;
 I, J : Cardinal;
begin
 lCopyList := Tl3IDList.Create;
 try
  lCopyList.MergeList(Self);
  Clear;
  I := 0;
  J := 0;
  while (I < aBaseList.Count) and (J < lCopyList.Count) do
   if aBaseList[I] = lCopyList[J] then
   begin
    Inc(J);
    Inc(I);
   end
   else
    if aBaseList[I] > lCopyList[J] then
     Inc(J)
    else
    begin
     Add(aBaseList[I]); //прикрутить directinsert
     Inc(I);
    end;
 finally
  l3Free(lCopyList);
 end;
 //сливаем хвост
  while (I < aBaseList.Count) do
  begin
   Add(aBaseList[I]); //прикрутить directinsert
   Inc(I);
  end;
end;

end.
