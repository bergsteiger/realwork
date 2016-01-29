unit m4DocumentAddress;
{* Адрес слова и список адресов. } 

{ Библиотека "M4"         }
{ Автор: Люлин А.В. ©     }
{ Модуль: m4DocumentAddress - }
{ Начат: 19.04.2002 12:49 }
{ $Id: m4DocumentAddress.pas,v 1.25 2015/09/21 12:31:06 lulin Exp $ }

// $Log: m4DocumentAddress.pas,v $
// Revision 1.25  2015/09/21 12:31:06  lulin
// {RequestLink:600945332}
//
// Revision 1.24  2015/09/21 12:25:13  lulin
// {RequestLink:600945332}
//
// Revision 1.23  2014/02/17 08:31:56  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.22  2014/02/14 16:59:34  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.21  2012/11/01 09:43:34  lulin
// - забыл точку с запятой.
//
// Revision 1.20  2012/11/01 07:46:03  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.19  2012/11/01 07:09:37  lulin
// - вычищаем мусор.
//
// Revision 1.18  2009/07/20 11:22:26  lulin
// - заставляем работать F1 после - {RequestLink:141264340}. №7, 32, 33.
//
// Revision 1.17  2009/03/19 16:28:32  lulin
// [$139443095].
//
// Revision 1.16  2008/03/21 14:09:35  lulin
// - cleanup.
//
// Revision 1.15  2008/02/21 18:37:25  lulin
// - вычищен ненужный параметр.
//
// Revision 1.14  2008/02/21 18:13:31  lulin
// - избавляемся от ненужных типов.
//
// Revision 1.13  2008/02/20 18:25:27  lulin
// - удалён ненужный тип.
//
// Revision 1.12  2008/02/19 14:59:01  lulin
// - переводим сортировку списков на новые, менее виртуальные, рельсы.
//
// Revision 1.11  2008/02/18 16:47:38  lulin
// - подчистил логику списков, связанную с сортированностью и добавлением элемента.
//
// Revision 1.10  2008/02/18 07:32:19  lulin
// - bug fix: не собирался архивариус.
//
// Revision 1.9  2008/02/05 09:58:17  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.8  2007/09/05 15:05:16  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.7  2007/08/27 16:28:22  lulin
// - убрано использование ненужных модулей.
//
// Revision 1.6  2006/04/25 08:50:10  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.5  2005/03/02 16:51:26  lulin
// - bug fix: не работал контекстный поиск в Архивариусе, т.к. неправильно освобождались объекты Tm4Address.
//
// Revision 1.4  2005/02/03 11:50:10  lulin
// - bug fix: Архивариус не компилировался.
//
// Revision 1.3  2005/01/24 11:43:29  lulin
// - new behavior: при освобождении заглушки очищаем указатель на нее.
//
// Revision 1.2  2004/12/23 08:40:46  lulin
// - вычищен ненужный модуль.
//
// Revision 1.1  2004/09/02 07:15:22  law
// - cleanup.
//
// Revision 1.12  2004/06/02 08:45:51  law
// - удален конструктор Tl3VList.MakePersistentSorted - пользуйтесь _Tl3ObjectRefList.MakeSorted.
//
// Revision 1.11  2004/05/27 14:32:21  law
// - new methods: _Tl3_CBase.IsCacheable, _NeedStoreInPool.
//
// Revision 1.10  2003/02/20 11:51:41  law
// - optimization: оптимизация выделения Tm4Address изменением стратегии кеша и менеджера памяти.
//
// Revision 1.9  2003/02/19 13:08:26  law
// - cleanup.
//
// Revision 1.8  2002/09/10 08:46:58  law
// - new behavior: подсветка всех слов входящих в выражение.
//
// Revision 1.7  2002/09/10 08:26:08  law
// - change: вместо Tm3DocumentAddress используем Im4Address.
//
// Revision 1.6  2002/09/10 07:07:16  law
// - new interface: Im4Address.
//

{$I m4Define.inc}

interface

uses
  l3Types,
  l3CacheableBase,
  l3SimpleMM,
  l3ObjectRefList,
  l3Base,

  m3DocumentAddress
  ;

type
  Tm4Address = class;

  Im4Address = interface(IUnknown)
    // property methods
      function  pm_GetAddress: Tm3DocumentAddress;
      procedure pm_SetAddress(aValue: Tm3DocumentAddress);
        {-}
    // public methods
      function  EQ(anAddress: Tm3DocumentAddress): Bool;
        {-}
      function  CaseCompare(const anAddress: Im4Address): Long;
        {-}
      function  LowCompare(const anAddress: Im4Address): Long;
        {-}
      function  CaseHighCompare(const anAddress: Im4Address): Long;
        {-}
      function  CaseLowCompare(const anAddress: Im4Address): Long;
        {-}
      procedure LinkAddress(const anAddress: Im4Address);
        {-}
      function  GetLinked: Im4Address;
        {-}
    // public properties
      property Address: Tm3DocumentAddress
        read pm_GetAddress
        {write pm_SetAddress};
        {-}
  end;//Im4Address

  Tm4Address = class(Tl3Base, Im4Address)
   {* Адрес слова. }
    private
    // internal fields
      f_Address : Tm3DocumentAddress;
      f_Linked  : Im4Address;
    protected
    // property methods
      function  pm_GetAddress: Tm3DocumentAddress;
      procedure pm_SetAddress(aValue: Tm3DocumentAddress);
        {-}
    protected
    // internal methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(const anAddress: Tm3DocumentAddress);
        reintroduce;
        {* - создает адрес. }
      class function Make(const anAddress: Tm3DocumentAddress): Im4Address;
        overload;
        {-}
      class function Make(const anAddress: Im4Address = nil): Im4Address;
        overload;
        {-}
      function  OCompare(anObject: Tl3Base): Long;
        override;
        {-}
      function  EQ(anAddress: Tm3DocumentAddress): Bool;
        {-}
      function  CaseCompare(const anAddress: Im4Address): Long;
        {-}
      function  LowCompare(const anAddress: Im4Address): Long;
        {-}
      function  CaseHighCompare(const anAddress: Im4Address): Long;
        {-}
      function  CaseLowCompare(const anAddress: Im4Address): Long;
        {-}
      procedure LinkAddress(const anAddress: Im4Address);
        {-}
      function  GetLinked: Im4Address;
        {-}
  end;//Tm4Address

  Tm4AddressAction = function(const anAddress: Tm3DocumentAddress): Bool;

  Tm4Addresses = class(Tl3ObjectRefList)
   {* Список адресов. }
    protected
    // property methods
      function  pm_GetAddress(anIndex: Long): Tm3DocumentAddress;
      procedure pm_SetAddress(anIndex: Long; const aValue: Tm3DocumentAddress);
        {-}
    public
    // public methods
      constructor Create;
        reintroduce;
        {* - создает список адресов. }
      function  CreateDocumentAddresses(aDocID: Long): Tm4Addresses;
        {* - создает список адресов для данного документа. }
      procedure Add(const anAddress: Tm3DocumentAddress);
        reintroduce;
        overload;
        {* - добавляет адрес в список. }
      procedure Add(const anAddress: Im4Address);
        overload;
        {* - добавляет адрес в список. }
      procedure IterateDocumentAddresses(aDocID: Long; anAction: Tm4AddressAction);
        {* - перебирает все адреса. }
      procedure IterateDocumentAddressesF(aDocID: Long; anAction: Tm4AddressAction);
        {* - перебирает все адреса и освобождает заглушку. }
    public
    // public properties
      property Address[anIndex: Long]: Tm3DocumentAddress
        read pm_GetAddress
        write pm_SetAddress;
        default;
        {* - адреса. }
  end;//Tm4Addresses
  Pm4Addresses = ^Tm4Addresses;

function  m4L2AA(Action: Pointer): Tm4AddressAction;
  {* - делает заглушку для локальной процедуры. }
procedure m4FreeAA(var Stub: Tm4AddressAction);
  {* - освобождает заглушку для локальной процедуры. }

var
 m4NullDocumentAddress : Im4Address = nil;

implementation

// start class Tm4Address

{$If not defined(DesignTimeLibrary)}
class function Tm4Address.IsCacheable: Boolean; //override;
  {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
begin
 Result := true;
end;
{$IfEnd} //not DesignTimeLibrary

constructor Tm4Address.Create(const anAddress: Tm3DocumentAddress);
  //reintroduce;
  {-}
begin
 inherited Create;
 f_Address := anAddress;
end;

class function Tm4Address.Make(const anAddress: Tm3DocumentAddress): Im4Address;
  //overload;
  {-}
var
 l_Address : Tm4Address;
begin
 l_Address := Tm4Address.Create(anAddress);
 try
  Result := l_Address;
 finally
  l3Free(l_Address);
 end;//try..finally
end;

class function Tm4Address.Make(const anAddress: Im4Address = nil): Im4Address;
  //overload;
  {-}
begin
 if (anAddress = nil) then
  Result := Make(m3NullDocumentAddress)
 else
  Result := Make(anAddress.Address);
end;

procedure Tm4Address.Cleanup;
  //override;
  {-}
begin
 inherited;
 f_Linked := nil;
end;

function Tm4Address.pm_GetAddress: Tm3DocumentAddress;
  {-}
begin
 Result := f_Address;
end;

procedure Tm4Address.pm_SetAddress(aValue: Tm3DocumentAddress);
  {-}
begin
 f_Address := aValue;
end;

function Tm4Address.OCompare(anObject: Tl3Base): Long;
  //override;
  {-}
begin
     if (anObject Is Tm4Address) then
      Result := f_Address.Compare(Tm4Address(anObject).f_Address)
     else
      Result := inherited OCompare(anObject);
end;

function Tm4Address.EQ(anAddress: Tm3DocumentAddress): Bool;
  {-}
begin
 Result := f_Address.EQ(anAddress);
end;

function Tm4Address.CaseCompare(const anAddress: Im4Address): Long;
  {-}
begin
 if (anAddress = nil) then
  Result := 1
 else
  Result := f_Address.CaseCompare(anAddress.Address); 
end;

function Tm4Address.LowCompare(const anAddress: Im4Address): Long;
  {-}
begin
 if (anAddress = nil) then
  Result := 1
 else
  Result := f_Address.LowCompare(anAddress.Address); 
end;

function Tm4Address.CaseHighCompare(const anAddress: Im4Address): Long;
  {-}
begin
 if (anAddress = nil) then
  Result := 1
 else
  Result := f_Address.CaseHighCompare(anAddress.Address); 
end;

function Tm4Address.CaseLowCompare(const anAddress: Im4Address): Long;
  {-}
begin
 if (anAddress = nil) then
  Result := 1
 else
  Result := f_Address.CaseLowCompare(anAddress.Address);
end;

procedure Tm4Address.LinkAddress(const anAddress: Im4Address);
  {-}
var
 l_Linked : Im4Address;
 l_Next   : Im4Address;  
begin
 if (anAddress <> nil) then
 begin
  if (Im4Address(Self) = anAddress) then
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=600945332
   Exit;
  Assert(Im4Address(Self) <> anAddress);
  if (f_Linked = nil) then
   f_Linked := anAddress
  else
  begin
   l_Linked := Self;
   while true do
   begin
    l_Next := l_Linked.GetLinked;
    if (l_Next = nil) then
     break
    else
     l_Linked := l_Next;
   end;//while true
   l_Linked.LinkAddress(anAddress);
  end;//f_Linked = nil
 end;//anAddress <> nil
end;

function Tm4Address.GetLinked: Im4Address;
  {-}
begin
 Result := f_Linked;
end;

// start class Tm4Addresses

constructor Tm4Addresses.Create;
  //reintroduce;
  {-}
begin
 MakeSorted;
end;

function Tm4Addresses.CreateDocumentAddresses(aDocID: Long): Tm4Addresses;
  {-}

var
 l_DocumentAddresses : Tm4Addresses absolute Result;
 
 function DoAddress(const anAddress: Tm3DocumentAddress): Bool;
 begin
  Result := true;
  l_DocumentAddresses.Add(anAddress);
 end;

begin
 if (Self = nil) then
  Result := nil
 else begin
  Result := Tm4Addresses.Create;
  try
   IterateDocumentAddressesF(aDocID, m4L2AA(@DoAddress))
  except
   l3Free(Result);
   raise;
  end;//try..except
 end;//Self = nil
end;

procedure Tm4Addresses.Add(const anAddress: Tm3DocumentAddress);
  //reintroduce;
  {-}
var
 l_Address : Tm4Address;
begin
 l_Address := Tm4Address.Create(anAddress);
 try
  inherited Add(l_Address);
 finally
  l3Free(l_Address);
 end;//try..finally
end;

procedure Tm4Addresses.Add(const anAddress: Im4Address);
  //overload;
  {* - добавляет адрес в список. }
var
 l_Linked : Im4Address;
begin
 l_Linked := anAddress;
 while (l_Linked <> nil) do begin
  Add(l_Linked.Address);
  l_Linked := l_Linked.GetLinked;
 end;//while (l_Linked <> nil)
end;

procedure Tm4Addresses.IterateDocumentAddresses(aDocID: Long; anAction: Tm4AddressAction);
  {-}

 function DoAddress(anAddress: PObject; anIndex: Long): Bool;
 begin//DoAddress
  with Tm4Address(anAddress^) do
   if (aDocID = f_Address.rDocument) then
    Result := anAction(f_Address)
   else
    Result := true; 
 end;//DoAddress

begin
 IterateAllF(l3L2IA(@DoAddress));
end;

procedure Tm4Addresses.IterateDocumentAddressesF(aDocID: Long; anAction: Tm4AddressAction);
  {-}
begin
 try
  IterateDocumentAddresses(aDocId, anAction);
 finally
  m4FreeAA(anAction);
 end;//try..finally
end;

function Tm4Addresses.pm_GetAddress(anIndex: Long): Tm3DocumentAddress;
  {-}
begin
 Result := Tm4Address(inherited Items[anIndex]).f_Address;
end;

procedure Tm4Addresses.pm_SetAddress(anIndex: Long; const aValue: Tm3DocumentAddress);
  {-}
begin
 Tm4Address(inherited Items[anIndex]).f_Address := aValue
end;

function  m4L2AA(Action: Pointer): Tm4AddressAction;
  {* - делает заглушку для локальной процедуры. }
asm
          jmp  l3LocalStub
end;{asm}

procedure m4FreeAA(var Stub: Tm4AddressAction);
  {* - освобождает заглушку для локальной процедуры. }
asm
          jmp  l3FreeLocalStub
end;{asm}

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\m4\m4DocumentAddress.pas initialization enter'); {$EndIf}
 m4NullDocumentAddress := Tm4Address.Make;

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\m4\m4DocumentAddress.pas initialization leave'); {$EndIf}
finalization
 m4NullDocumentAddress := nil;

end.

