unit evTableCellPainter;

interface

uses
 l3IntfUses
 , nevTools
 , nevRealTools
 , l3Variant
 , l3Interfaces
 , nevBase
;

type
 TevTableCellPainter = class(_evParaListPainter_)
  {* –еализаци€ интерфейса IevPainter дл€ €чеек }
  function GetTablePainter: IevTablePainter;
 end;//TevTableCellPainter
 
implementation

uses
 l3ImplUses
 , k2Tags
 , evdTypes
 , SysUtils
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
 , TableCell_Const
 , DocumentSub_Const
 , Mark_Const
 , LeafPara_Const
 , CommentPara_Const
 , Block_Const
 , TextPara_Const
 , k2Base
 , Table_Const
 , Windows
;

end.
