unit tfwStoredValues;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , tfwScriptingInterfaces
;

type
 TtfwStoredValues = class(Tl3ProtoDataContainer, ItfwStoredValues)
  procedure Create;
  function Make: ItfwStoredValues;
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* ���������� �������� ������ }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  procedure FreeItem(var aPlace: _ItemType_;
   aList: _l3Items_);
   {* ������� ������� ������ }
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
  procedure Restore(const aCtx: TtfwContext);
  function Grow: PtfwStoredValue;
 end;//TtfwStoredValues
 
implementation

uses
 l3ImplUses
 , kwCompiledVar
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
