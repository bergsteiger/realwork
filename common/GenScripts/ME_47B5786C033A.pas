unit l3RefList.imp;

interface

uses
 l3IntfUses
;

type
 _l3RefList_ = class(_l3StandardTypedList_)
  {* ������� ��� ������ ������. ������ ������� ���������� � ��������� �� �������� �����. }
 end;//_l3RefList_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
