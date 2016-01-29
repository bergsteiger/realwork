unit nevNavigation;

interface

uses
 l3IntfUses
 , l3Types
 , nevTools
 , afwNavigation
 , evdTypes
 , l3Variant
;

type
 IevAddressList = interface
  {* Список адресов }
  function Add(const anAddress: TevAddress): Integer;
   {* Добавляет еще один адрес }
  procedure Delete(const anAddress: TevAddress);
   {* Удаляет адрес }
  procedure Modify(const anOldAddress: TevAddress;
   const aNewAddress: TevAddress);
   {* Модифицирует адрес }
  procedure Clear;
   {* Очищает список адресов }
 end;//IevAddressList
 
 IevAddressHolder = interface
 end;//IevAddressHolder
 
 IevHyperlink = interface
  {* Гипертекстовая ссылка }
  function Exists: Boolean;
   {* Проверяет существует ли данная ссылка }
  procedure Insert;
   {* Вставляет новую ссылку }
  procedure Delete;
   {* Удаляет гипертекстовую ссылку }
  function GetHyperlink: Tl3Tag;
 end;//IevHyperlink
 
implementation

uses
 l3ImplUses
;

end.
