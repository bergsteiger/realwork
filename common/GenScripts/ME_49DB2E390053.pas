unit evCommentParaPainter;

interface

uses
 l3IntfUses
 , evDocumentPartPainter
 , l3Variant
 , l3Interfaces
 , nevBase
;

type
 TevCommentParaPainter = class(TevDocumentPartPainter)
  {* ���������� ���������� IevPainter ��� ����� � ������������� }
 end;//TevCommentParaPainter
 
implementation

uses
 l3ImplUses
 , evDocumentPart
 , TextPara_Const
 , evdStyles
 , k2Tags
 , k2Base
 , Graphics
 , l3Units
 , l3MinMax
 , l3String
 , nevInterfaces
;

end.
