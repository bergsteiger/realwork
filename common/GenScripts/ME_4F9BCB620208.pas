unit Pl3MessageIDList;

interface

uses
 l3IntfUses
 , Pl3MessageIDListPrim
;

type
 TPl3MessageIDList = class(TPl3MessageIDListPrim)
  procedure CleanupItems;
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TPl3MessageIDList
 
implementation

uses
 l3ImplUses
;

end.
