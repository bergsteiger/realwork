unit dtDictItemsPrim;

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , dtCustomDictItem
;

type
 TdtDictItemsPrim = class(_l3UncomparabeObjectRefList_)
  {* ������� ������ ��������� �������. }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
 end;//TdtDictItemsPrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
