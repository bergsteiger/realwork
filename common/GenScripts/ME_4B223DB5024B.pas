unit l3RecordWithEQList.imp;

interface

uses
 l3IntfUses
;

type
 _l3RecordWithEQList_ = class(_l3RecordListPrim_)
  {* ������ ������� � ��������� EQ }
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* ���������� �������� ������ }
 end;//_l3RecordWithEQList_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
