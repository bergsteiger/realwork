unit evLeafParaPainter;

// Модуль: "w:\common\components\gui\Garant\Everest\evLeafParaPainter.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

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
 _X_ = InevLeafPara;
 {$Include evLeafParaPainter.imp.pas}
 TevLeafParaPainter = class(_evLeafParaPainter_)
 end;//TevLeafParaPainter
{$IfEnd} // Defined(evNeedPainters)

implementation

{$If Defined(evNeedPainters)}
uses
 l3ImplUses
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

{$Include evLeafParaPainter.imp.pas}
{$IfEnd} // Defined(evNeedPainters)

end.
