unit nevZoomedRubberCellsRenderInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevZoomedRubberCellsRenderInfo.pas"
// Начат: 26.05.2010 21:18
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Rendering::TnevZoomedRubberCellsRenderInfo
//
// Резиновая таблица (строка) с изменяемым размером шрифта
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevRubberCellsRenderInfo,
  nevFormatInfo
  ;

type
 TnevZoomedRubberCellsRenderInfo = class(TnevRubberCellsRenderInfo)
  {* Резиновая таблица (строка) с изменяемым размером шрифта }
 protected
 // overridden protected methods
   function GetZoomForChild(aChild: TnevFormatInfo): Integer; override;
   procedure ValidateNewChildWidth(anOldWidth: Integer;
    var theNewWidth: Integer); override;
 end;//TnevZoomedRubberCellsRenderInfo

implementation

uses
  k2Tags,
  l3Math,
  nevBase,
  l3MinMax
  ;

// start class TnevZoomedRubberCellsRenderInfo

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