unit nevZoomedCellsRenderInfo;
 {* Информация о форматировании для масштабированных ячее }

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevZoomedCellsRenderInfo.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevZoomedCellsRenderInfo" MUID: (4BA24BC5012E)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , nevTableRowRenderInfo
 , nevFormatInfo
;

type
 TnevZoomedCellsRenderInfo = class(TnevTableRowRenderInfo)
  {* Информация о форматировании для масштабированных ячее }
  protected
   function ChildWidth(aChild: TnevFormatInfo): Integer; override;
   function GetZoomForChild(aChild: TnevFormatInfo): Integer; override;
 end;//TnevZoomedCellsRenderInfo

implementation

uses
 l3ImplUses
 , l3Math
 , k2Tags
;

function TnevZoomedCellsRenderInfo.ChildWidth(aChild: TnevFormatInfo): Integer;
//#UC START# *4820985D0238_4BA24BC5012E_var*
//#UC END# *4820985D0238_4BA24BC5012E_var*
begin
//#UC START# *4820985D0238_4BA24BC5012E_impl*
 Result := l3MulDiv(aChild.Obj.AsObject.IntA[k2_tiWidth], Obj.AsObject.Owner.IntA[k2_tiZoom], 100);
//#UC END# *4820985D0238_4BA24BC5012E_impl*
end;//TnevZoomedCellsRenderInfo.ChildWidth

function TnevZoomedCellsRenderInfo.GetZoomForChild(aChild: TnevFormatInfo): Integer;
//#UC START# *4BFD5AB10227_4BA24BC5012E_var*
//#UC END# *4BFD5AB10227_4BA24BC5012E_var*
begin
//#UC START# *4BFD5AB10227_4BA24BC5012E_impl*
 Result := Obj.AsObject.Owner.IntA[k2_tiZoom];
//#UC END# *4BFD5AB10227_4BA24BC5012E_impl*
end;//TnevZoomedCellsRenderInfo.GetZoomForChild

end.
