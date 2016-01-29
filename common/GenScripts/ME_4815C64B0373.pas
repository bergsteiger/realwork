unit nevFormatInfoList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevFormatInfo
;

type
 TnevFormatInfoList = class(_l3UncomparabeObjectRefList_)
  procedure ClearReferencesToParentFormatInfo;
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TnevFormatInfoList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type
 TnevFormatInfoHack = class(TnevFormatInfo)
 end;//TnevFormatInfoHack
 
end.
