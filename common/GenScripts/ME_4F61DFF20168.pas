unit npNavigatorListPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , vtNavigator
;

type
 TnpNavigatorListPrim = class(_l3ObjectPtrList_)
  {* ������ ����������� ��������� � ����������. ������ ������������ ��� �������� ��������� }
  procedure Reg(aNavigator: TvtNavigatorPrim);
   {* ���������������� ��������� }
  procedure UnReg(aNavigator: TvtNavigatorPrim);
   {* ���������������� ��������� }
 end;//TnpNavigatorListPrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
