unit tfwAxiomaticsResNameGetterList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , tfwAxiomaticsResNameGetter
;

type
 TtfwAxiomaticsResNameGetterList = class(_l3UnrefcountedList_)
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
 end;//TtfwAxiomaticsResNameGetterList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
