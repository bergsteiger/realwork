unit evdHeaderHyperlinkAdder;

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , l3Variant
;

type
 TevdHeaderHyperlinkAdder = class(TevdLeafParaFilter)
  {* ������, ��������������� ������ �� ��������� ��������� }
  procedure OutBlockNames(aLeaf: Tl3Variant);
   {* ������� ����� ������, � ������� ������ ������ �������� }
 end;//TevdHeaderHyperlinkAdder
 
implementation

uses
 l3ImplUses
 , SegmentsLayer_Const
 , PageBreak_Const
 , Address_Const
 , HyperLink_Const
 , k2Tags
 , Document_Const
 , DecorTextPara_Const
 , evdTypes
;

end.
