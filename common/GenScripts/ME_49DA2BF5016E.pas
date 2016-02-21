unit evTextParaPainterPrim;
 {* ѕромежуточный класс, чтобы другие классы было проще на модель переносить }

// ћодуль: "w:\common\components\gui\Garant\Everest\evTextParaPainterPrim.pas"
// —тереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedPainters)}
uses
 l3IntfUses
 , nevTools
 , l3InternalInterfaces
 , l3Interfaces
 , nevRealTools
 , nevBase
 , l3Variant
 , l3Units
 , l3ProtoObject
;

type
 _X_ = InevTextPara;
 {$Include w:\common\components\gui\Garant\Everest\evLeafParaPainter.imp.pas}
 TevTextParaPainterPrim = class(_evLeafParaPainter_)
  {* ѕромежуточный класс, чтобы другие классы было проще на модель переносить }
 end;//TevTextParaPainterPrim
{$IfEnd} // Defined(evNeedPainters)

implementation

{$If Defined(evNeedPainters)}
uses
 l3ImplUses
 , evDefaultStylesFontSizes
 , k2Tags
 , evdTypes
 {$If Defined(evUseVisibleCursors)}
 , nevAfterEndPoint
 {$IfEnd} // Defined(evUseVisibleCursors)
 , Graphics
 , l3SmartCanvas
 , l3MinMax
 , l3Base
 , l3Tree
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
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

{$Include w:\common\components\gui\Garant\Everest\evLeafParaPainter.imp.pas}
{$IfEnd} // Defined(evNeedPainters)

end.
