unit evLeafParaPainter.imp;

interface

uses
 l3IntfUses
;

type
 _evLeafParaPainter_ = class(_evLeafParaPainterPrim_)
  {* Рисователь листьевых параграфов. }
  function DoDraw: Boolean;
 end;//_evLeafParaPainter_
 
implementation

uses
 l3ImplUses
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
