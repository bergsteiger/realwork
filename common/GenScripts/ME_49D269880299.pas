unit nevParentPointHolder.imp;

interface

uses
 l3IntfUses
 , nevTools
;

type
 _nevParentPointHolder_ = class
  {* ���������� �����, ������� �������� }
  procedure SetParentPoint(const aValue: InevBasePoint);
  function Outer: InevBasePoint;
  function ParentPoint: InevBasePoint;
 end;//_nevParentPointHolder_
 
implementation

uses
 l3ImplUses
;

end.
