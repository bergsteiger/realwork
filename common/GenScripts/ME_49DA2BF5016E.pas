unit evTextParaPainterPrim;

interface

uses
 l3IntfUses
 , nevTools
;

type
 TevTextParaPainterPrim = class(_evLeafParaPainter_)
  {* Промежуточный класс, чтобы другие классы было проще на модель переносить }
 end;//TevTextParaPainterPrim
 
implementation

uses
 l3ImplUses
 , evDefaultStylesFontSizes
 , l3Units
 , k2Tags
 , evdTypes
 , nevAfterEndPoint
 , l3InternalInterfaces
 , Graphics
 , l3SmartCanvas
 , l3MinMax
 , l3Base
 , l3Tree
 , evParaTools
 , TableCell_Const
 , DocumentSub_Const
 , Mark_Const
 , LeafPara_Const
 , CommentPara_Const
 , Block_Const
 , TextPara_Const
 , k2Base
 , SysUtils
 , Table_Const
 , Windows
;

end.
