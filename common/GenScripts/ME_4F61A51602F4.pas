unit vtNavigatorFormList;

interface

uses
 l3IntfUses
 , vtNavigatorFormListPrim
;

type
 TvtNavigatorFormList = class(TvtNavigatorFormListPrim)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TvtNavigatorFormList
 
implementation

uses
 l3ImplUses
;

end.
