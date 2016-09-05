unit NOT_FINISHED_evSegLst;
 {* Объекты для работы со слоями сегментов. }

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evSegLst.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evSegLst" MUID: (47F2499F0049)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , l3Variant
 , nevBase
;

procedure evSegments_GetSegmentOnPos;
procedure evSegments_AddSegment(aPara: Tl3Tag;
 aSegments: Tl3Tag;
 LayerHandle: Integer;
 Seg: Tl3Tag;
 const Container: InevOp = nil);
 {* добавляет отрезок выделения. }
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 //#UC START# *47F2499F0049impl_uses*
 //#UC END# *47F2499F0049impl_uses*
;

procedure evSegments_GetSegmentOnPos;
//#UC START# *55CB15DB03A7_47F2499F0049_var*
//#UC END# *55CB15DB03A7_47F2499F0049_var*
begin
//#UC START# *55CB15DB03A7_47F2499F0049_impl*
 !!! Needs to be implemented !!!
//#UC END# *55CB15DB03A7_47F2499F0049_impl*
end;//evSegments_GetSegmentOnPos

procedure evSegments_AddSegment(aPara: Tl3Tag;
 aSegments: Tl3Tag;
 LayerHandle: Integer;
 Seg: Tl3Tag;
 const Container: InevOp = nil);
 {* добавляет отрезок выделения. }
//#UC START# *47F249E30352_47F2499F0049_var*
//#UC END# *47F249E30352_47F2499F0049_var*
begin
//#UC START# *47F249E30352_47F2499F0049_impl*
 !!! Needs to be implemented !!!
//#UC END# *47F249E30352_47F2499F0049_impl*
end;//evSegments_AddSegment
{$IfEnd} // Defined(k2ForEditor)

end.
