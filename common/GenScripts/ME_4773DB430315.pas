unit l3ObjectCache;

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , l3ProtoDataContainer
;

type
 Tl3ObjectCache = class(_l3UncomparabeObjectRefList_)
  {* ��� ��������. }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
 end;//Tl3ObjectCache
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
