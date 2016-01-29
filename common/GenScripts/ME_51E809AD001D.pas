unit InterfaceRefList.imp;

interface

uses
 l3IntfUses
;

type
 _InterfaceRefList_ = class(_InterfaceList_)
  {* ������ ������ �� ����������. ������� ������ ���������� }
  procedure FreeItem(var thePlace: _ItemType_);
  procedure FillItem(var thePlace: _ItemType_;
   const aFrom: _ItemType_);
 end;//_InterfaceRefList_
 
implementation

uses
 l3ImplUses
 , RTLConsts
 , l3MemorySizeUtils
;

end.
