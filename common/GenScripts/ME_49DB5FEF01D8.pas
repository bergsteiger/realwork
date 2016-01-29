unit evParaListPainter;

interface

uses
 l3IntfUses
 , nevTools
;

 {$Define ParaPainter_IsParaListPainter}
 
type
 TevParaListPainter = class(_evParaListPainter_)
  {* Рисователь списка параграфов }
 end;//TevParaListPainter
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3InternalInterfaces
 , l3VirtualCanvas
 , nevVirtualDrawView
 , l3Units
 , evParaDrawTools
 , nevAfterEndPoint
 , l3MinMax
 , nevFacade
 , l3Const
 , Graphics
 , l3SmartCanvas
 , l3Base
 , l3Tree
 , evParaTools
 , evdTypes
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
