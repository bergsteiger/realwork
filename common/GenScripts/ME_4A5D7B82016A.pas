unit nevTableRowAnchor;

interface

uses
 l3IntfUses
 , nevParaListAnchor
 , nevTools
 , nevBase
 , nevParaListAnchorModifyTypes
;

type
 TnevTableRowAnchor = class(TnevParaListAnchor)
  {* ����� ��� ������ ������� }
  procedure CheckBaseLine(const aView: InevView);
   {* ���������, ����� ������� ����� ���� ���������������� }
 end;//TnevTableRowAnchor
 
implementation

uses
 l3ImplUses
 , nevFacade
 , k2Tags
 , evdTypes
 , nevAfterEndPoint
;

end.
