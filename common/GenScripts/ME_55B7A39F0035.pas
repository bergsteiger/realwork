unit tfwAxiomaticsResNameGetters;

interface

uses
 l3IntfUses
 , tfwAxiomaticsResNameGetterList
;

type
 TtfwAxiomaticsResNameGetters = class(TtfwAxiomaticsResNameGetterList)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TtfwAxiomaticsResNameGetters
 
implementation

uses
 l3ImplUses
;

end.
