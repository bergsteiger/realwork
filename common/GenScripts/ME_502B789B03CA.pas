unit evTextInTableCorrector;

interface

uses
 l3IntfUses
 , k2TagFilter
 , k2Base
 , l3Variant
;

type
 TevTextInTableCorrector = class(Tk2TagFilter)
  {* �������� ������ "��������" �� ������ � ��������: ����� "�������", ������������� �������, ����� ������ ������. }
  function InCell: Boolean;
 end;//TevTextInTableCorrector
 
implementation

uses
 l3ImplUses
 , TableCell_Const
 , TextPara_Const
 , k2Tags
 , evdStyles
 , Document_Const
;

end.
