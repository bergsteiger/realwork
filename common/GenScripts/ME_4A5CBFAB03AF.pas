unit l3Changing.imp;

interface

uses
 l3IntfUses
 , l3PureMixIns
;

type
 _l3Changing_ = class
  {* ������ � ������������ �� ��������� ��������� }
  procedure DoChanged;
  procedure DoChanging;
  procedure Changing;
   {* ����������� � ������ ��������� ��������� �������. ��� ���������� � ������������� � ��������. }
  procedure Changed;
   {* ����������� � ���������� ��������� ��������� �������. ��� ���������� � ������������� � ��������. }
 end;//_l3Changing_
 
implementation

uses
 l3ImplUses
;

end.
