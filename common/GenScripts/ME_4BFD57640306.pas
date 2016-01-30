unit nevZoomedRubberCellsRenderInfo;
 {* Резиновая таблица (строка) с изменяемым размером шрифта }

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevZoomedRubberCellsRenderInfo.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , nevRubberCellsRenderInfo
 , nevFormatInfo
;

type
 TnevZoomedRubberCellsRenderInfo = class(TnevRubberCellsRenderInfo)
  {* Резиновая таблица (строка) с изменяемым размером шрифта }
  protected
   function GetZoomForChild(aChild: TnevFormatInfo): Integer; override;
   procedure ValidateNewChildWidth(anOldWidth: Integer;
    var theNewWidth: Integer); override;
 end;//TnevZoomedRubberCellsRenderInfo

implementation

uses
 l3ImplUses
 , k2Tags
 , l3Math
 , nevBase
 , l3MinMax
;

function TnevZoomedRubberCellsRenderInfo.GetZoomForChild(aChild: TnevFormatInfo): Integer;
//#UC START# *4BFD5AB10227_4BFD57640306_var*
var
 l_Obj  : InevObjectPrim;
 l_Width: Integer;
//#UC END# *4BFD5AB10227_4BFD57640306_var*
begin
//#UC START# *4BFD5AB10227_4BFD57640306_impl*
 l_Obj := aChild.Obj;
 l_Width := l_Obj.AsObject.IntA[k2_tiWidth];
 if (l_Width = 0) then
  Result := 100
 else
  Result := l3MulDiv(Widthes[l_Obj.PID], 100, l_Width);
//#UC END# *4BFD5AB10227_4BFD57640306_impl*
end;//TnevZoomedRubberCellsRenderInfo.GetZoomForChild

procedure TnevZoomedRubberCellsRenderInfo.ValidateNewChildWidth(anOldWidth: Integer;
 var theNewWidth: Integer);
//#UC START# *4BFD6763012A_4BFD57640306_var*
//#UC END# *4BFD6763012A_4BFD57640306_var*
begin
//#UC START# *4BFD6763012A_4BFD57640306_impl*
 inherited;
 if (theNewWidth > anOldWidth) then
  theNewWidth := anOldWidth
 else
  theNewWidth := Max(theNewWidth, l3MulDiv(anOldWidth, 60, 100));
//#UC END# *4BFD6763012A_4BFD57640306_impl*
end;//TnevZoomedRubberCellsRenderInfo.ValidateNewChildWidth

end.
