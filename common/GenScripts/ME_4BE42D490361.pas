unit l3CheckStamp.imp;

interface

uses
 l3IntfUses
 , l3PureMixIns
;

type
 _l3CheckStamp_ = class
  function CheckStamp(const aGUID: TGUID): Boolean;
   {* ��������� ����� ���������� ����������. �������� ��� ����, ����� ������, ��� ���������� ���� "������". }
 end;//_l3CheckStamp_
 
implementation

uses
 l3ImplUses
;

end.
