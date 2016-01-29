unit evControlParaPainter;

interface

uses
 l3IntfUses
 , evTextParaPainterEx
 , nevBase
 , l3Units
 , evdTypes
 , l3Variant
;

type
 TevControlParaPainter = class(TevTextParaPainterEx)
  {* ���������� ��� ��������� ���������� ���� Control. }
  procedure DrawImgListComponent(const aEditRect: Tl3SRect;
   aType: TevControlType;
   aPartialDraw: Boolean;
   aBtnWidth: Integer);
   {* ������������ ����������� � �������� }
 end;//TevControlParaPainter
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3InternalInterfaces
 , evControlParaTools
 , evControlParaConst
 , nevTools
 , Graphics
 , l3Interfaces
 , l3MinMax
 , TableCell_Const
 , HyperLink_Const
 , l3String
 , l3Defaults
 , Types
;

end.
