unit vcmCommandIDsList;

interface

uses
 l3IntfUses
 , vcmCommandIDsListPrim
;

type
 TvcmCommandIDsList = class(TvcmCommandIDsListPrim)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TvcmCommandIDsList
 
implementation

uses
 l3ImplUses
;

end.
