unit tb97List;

{ Библиотека "Toolbar 97" }
{ Автор: Люлин А.В. ©     }
{ Модуль: tb97List -      }
{ Начат: 13.09.2004 20:00 }
{ $Id: tb97List.pas,v 1.20 2008/02/22 16:57:39 lulin Exp $ }

// $Log: tb97List.pas,v $
// Revision 1.20  2008/02/22 16:57:39  lulin
// - упорядочиваем примеси.
//
// Revision 1.19  2008/02/22 15:33:41  lulin
// - избавляемся от виртуальности.
//
// Revision 1.18  2008/02/19 16:45:38  lulin
// - используем типизацию элементов.
//
// Revision 1.17  2008/02/19 11:05:53  lulin
// - восстановил всякие экзотические поиски в списках объектов.
//
// Revision 1.16  2008/02/07 08:37:56  lulin
// - каждому базовому объекту по собственному модулю.
//
// Revision 1.15  2008/02/06 09:30:47  lulin
// - базовые списки объектов выделяем в отдельные файлы.
//
// Revision 1.14  2008/01/31 18:53:40  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.13  2008/01/31 16:15:53  lulin
// - cleanup.
//
// Revision 1.12  2007/09/07 15:52:39  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.11  2007/09/07 12:53:14  lulin
// - удален ненужный параметр.
//
// Revision 1.10  2006/04/24 12:58:38  lulin
// - выпиливаем из списков общую функциональность.
//
// Revision 1.9  2005/04/28 15:04:01  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.8.14.1  2005/04/26 14:30:46  lulin
// - ускоряем l3Free и l3Use.
//
// Revision 1.8  2004/10/21 16:07:52  lulin
// - попытка восстановить ПРАВИЛЬНУЮ функциональность. Пока закомментировано - т.к. с этим почему-то проявляется ошибка с пропаданием ActionLink'ов у контролов.
//
// Revision 1.7  2004/10/21 15:24:52  fireton
// - bug fix: отключаем кеширование для кнопок, т.к. оно пока глючит
//
// Revision 1.6  2004/10/20 10:40:47  lulin
// - new behavior: увеличиваем частоту использования пула объектов.
//
// Revision 1.5  2004/09/22 12:09:43  mmorozov
// new: интерфейс Itb97Control;
// new: оптимизация работы списка;
//
// Revision 1.4  2004/09/22 07:50:57  lulin
// - оптимизация - методу Ttb97ControlsList.IndexOf придана память о последнем найденном элементе.
//
// Revision 1.3  2004/09/22 07:16:48  lulin
// - new class: Ttb97ControlsList.
//
// Revision 1.2  2004/09/14 08:03:12  lulin
// - списки сделаны кешируемыми.
//
// Revision 1.1  2004/09/13 16:26:26  lulin
// - new unit: tb97List.
// - перевел Toolbar 97 на Ttb97List.
//

{$I TB97Ver.inc}

interface

uses
  Classes,
  SysUtils,
  Controls

  ,
  l3Base,
  l3CObjectList,
  l3DataPtrList
  ;

type
  Ttb97List = class(Tl3DataPtrList)
    protected
    // internal methods
      class function IsCacheable: Boolean;
        override;
        {-}
  end;//Ttb97List

  Itb97Control = interface(IUnknown)
  ['{A9FD6273-22CE-4CFF-B1C3-BF1C0D889A4B}']
  {* - интерфейс компонента toolbar-а. }
  // private methods
    procedure pm_SetIndex(const Value : Integer);
      {-}
    function pm_GetIndex : Integer;
      {-}
  // public properties
    property Index : Integer
      read pm_GetIndex
      write pm_SetIndex;
      {* - индекс элемента в списке компонентов toolbar-а. }
  end;//Itb97Control

  Ttb97ControlsList = class(Tl3CObjectList)
    private
    // internal fields
      f_FoundItem  : TObject;
      f_FoundIndex : Integer;
    private
    // internal methods
      procedure ReindexControls(const aStartPos : Integer = 0);
        {* - переиндексирует идентификаторы компонентов. }
      procedure ChangeIndex(const aItem  : Integer);
        overload;
        {-}
      procedure ChangeIndex(const aItem  : Integer;
                            const aValue : Integer);
        overload;
        {* - установить индекс объекту, если он поддерживает интерфейс
             Itb97Control. }
    protected
    // property methods
      function  pm_GetItem(Index: LongInt): TControl;
        {-}
      procedure pm_SetItem(Index: LongInt; Item: TControl);
        {-}
      procedure DirectInsert(Index: Integer; const Item: TObject);
        override;
        {-}
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      procedure DoDelete(Index: Integer);
        override;
        {-}
      procedure Swap(var I1: TObject; var I2: TObject);
        override;
        {-}
      function  IndexOf(const Item: TObject): LongInt;
        override;
        {-}
    public
    // public properties
      property Items[Index: LongInt]: TControl
        read pm_GetItem
        write pm_SetItem;
        default;
        {* - элементы списка. }
  end;//Ttb97ControlsList

procedure tb97Free(var anObject);
  { Освобождает память, выделенную под объект. }

implementation

// start class Ttb97List

procedure tb97Free(var anObject);
  { Освобождает память, выделенную под объект. }
begin
 FreeAndNil(anObject);
end;

class function Ttb97List.IsCacheable: Boolean;
  //override;
  {-}
begin
 Result := true;
end;

// start class Ttb97ControlsList

procedure Ttb97ControlsList.Cleanup;
  //override;
  {-}
begin
 f_FoundItem := nil;
 f_FoundIndex := -1;
 inherited;
end;

function Ttb97ControlsList.pm_GetItem(Index: LongInt): TControl;
  {-}
begin
 Result := TControl(inherited Items[Index]);
end;

procedure Ttb97ControlsList.pm_SetItem(Index: LongInt; Item: TControl);
  {-}
begin
 inherited Items[Index] := Pointer(Item);
end;

procedure Ttb97ControlsList.ReindexControls(const aStartPos : Integer = 0);
var
 lIndex : Integer;
begin
 for lIndex := aStartPos to Pred(Count) do
  ChangeIndex(lIndex);
end;

procedure Ttb97ControlsList.DirectInsert(Index: Integer; const Item: TObject);
  //override;
  {-}
begin
 f_FoundItem := Pointer(Item);
 f_FoundIndex := Index;
 inherited;
 (* Установим новый индекс *)
 ChangeIndex(Index);
 (* Переиндексируем *)
 if Index <> Pred(Count) then
  ReindexControls(Succ(Index));
end;

procedure Ttb97ControlsList.DoDelete(Index: Integer);
  //override;
  {-}
begin
 if (Index = f_FoundIndex) then
 begin
  f_FoundItem := nil;
  f_FoundIndex := -1;
 end//Index <= f_FoundIndex
 else
 if (Index < f_FoundIndex) then
  Dec(f_FoundIndex);
 ChangeIndex(Index, -1);
 inherited;
 ReindexControls(Index);
end;

procedure Ttb97ControlsList.ChangeIndex(const aItem  : Integer);
begin
 ChangeIndex(aItem, aItem);
end;

procedure Ttb97ControlsList.ChangeIndex(const aItem  : Integer;
                                        const aValue : Integer);
var
 lControl : Itb97Control;
begin
 if Supports(Items[aItem], Itb97Control, lControl) then
 try
  lControl.Index := aValue;
 finally
  lControl := nil;
 end;
end;

procedure Ttb97ControlsList.Swap(var I1: TObject; var I2: TObject);
  //override;
  {-}
var
 C1 : Itb97Control;
 C2 : Itb97Control;
 X  : Integer;
begin
 f_FoundIndex := -1;
 inherited;
 Supports(I1, Itb97Control, C1);
 Supports(I2, Itb97Control, C2);
 if (C1 = nil) AND (C2 = nil) then
  Exit;
 if (C1 <> nil) AND (C2 <> nil) then
 begin
  X := C1.Index;
  C1.Index := C2.Index;
  C2.Index := X;
 end//C1 <> nil
 else
 begin
  if (C1 <> nil) then
   C1.Index := -1;
  if (C2 <> nil) then
   C2.Index := -1;
 end;//C1 <> nil
end;

function Ttb97ControlsList.IndexOf(const Item: TObject): LongInt;
  //override;
  {-}
var
 lControl : Itb97Control;
begin
 if (f_FoundIndex > 0) AND (f_FoundItem = Item) then
  Result := f_FoundIndex
 else
 begin
  if Supports(Item, Itb97Control, lControl) then
   try
    Result := lControl.Index;
    if (Result >= 0) then
     Exit;
   finally
    lControl := nil;
   end;//try..finally
  Result := inherited IndexOf(Item);
  f_FoundItem := Item;
  f_FoundIndex := Result;
 end;//f_FoundItem = Item
end;

end.

