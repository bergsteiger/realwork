unit evCommentParaDecorator;

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , l3Variant
;

type
 TevCheckStyle = (
  ev_cstNone
  , ev_cstTxtComment
  , ev_cstVerComment
 );//TevCheckStyle
 
 TevCommentParaDecorator = class(TevdLeafParaFilter)
  {* ������, ������������ ������������ ������� ������������� ����������. [$140285546] }
 end;//TevCommentParaDecorator
 
implementation

uses
 l3ImplUses
 , evdStyles
 , k2Tags
 , TextPara_Const
 , Graphics
 , nevInterfaces
;

end.
