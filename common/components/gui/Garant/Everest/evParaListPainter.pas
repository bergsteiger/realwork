unit evParaListPainter;
 {* Рисователь списка параграфов }

// Модуль: "w:\common\components\gui\Garant\Everest\evParaListPainter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevParaListPainter" MUID: (49DB5FEF01D8)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedPainters)}
uses
 l3IntfUses
 , nevTools
 , nevRealTools
 , l3Interfaces
 , l3InternalInterfaces
 , nevBase
 , l3Variant
 , l3Units
 , l3ProtoObject
;

 {$Define ParaPainter_IsParaListPainter}

type
 _X_ = InevParaList;
 {$Include w:\common\components\gui\Garant\Everest\evParaListPainter.imp.pas}
 TevParaListPainter = class(_evParaListPainter_)
  {* Рисователь списка параграфов }
 end;//TevParaListPainter
{$IfEnd} // Defined(evNeedPainters)

implementation

{$If Defined(evNeedPainters)}
uses
 l3ImplUses
 , k2Tags
 , l3VirtualCanvas
 , nevVirtualDrawView
 , evParaDrawTools
 {$If Defined(evUseVisibleCursors)}
 , nevAfterEndPoint
 {$IfEnd} // Defined(evUseVisibleCursors)
 , l3MinMax
 , nevFacade
 , l3Const
 , Graphics
 , l3SmartCanvas
 , l3Base
 , l3Tree
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
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
 //#UC START# *49DB5FEF01D8impl_uses*
 //#UC END# *49DB5FEF01D8impl_uses*
;

{$Include w:\common\components\gui\Garant\Everest\evParaListPainter.imp.pas}
{$IfEnd} // Defined(evNeedPainters)

end.
