unit nevSelection;

interface

uses
 l3IntfUses
 , evBlockCursor
 , nevTools
 , evTypes
 , l3Variant
;

type
 TnevSelection = class(TevBlockCursor)
  {* ������ � ����������. ��� ��������� �������������. }
  procedure DeleteFoundBlockBeforeSearch;
  procedure Select(aTarget: TevSelectTarget;
   const aCursor: InevPoint;
   Start: Boolean);
   {* �������� ����� ��������� (�������� ������� �����, ������, �������� etc) }
 end;//TnevSelection
 
implementation

uses
 l3ImplUses
 , l3InterfacesMisc
 , evMsgCode
 , evSelectConst
;

end.
