unit nevTableRowRenderInfoEx;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevTableRowRenderInfoEx.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , nevTableRowRenderInfo
 , nevFormatInfo
 , nevBase
;

type
 TnevTableRowRenderInfoEx = class(TnevTableRowRenderInfo)
  public
   class function CreateInst(const aChild: InevObjectPrim;
    aParent: TnevFormatInfo;
    const aMetrics: InevViewMetrics): TnevFormatInfo; override;
 end;//TnevTableRowRenderInfoEx

implementation

uses
 l3ImplUses
 , nevRubberCellsRenderInfo
 , nevZoomedRubberCellsRenderInfo
 , nevZoomedCellsRenderInfo
 , k2Tags
 , SBS_Const
 , CommentPara_Const
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
;

class function TnevTableRowRenderInfoEx.CreateInst(const aChild: InevObjectPrim;
 aParent: TnevFormatInfo;
 const aMetrics: InevViewMetrics): TnevFormatInfo;
//#UC START# *4E706B7C00A6_4E706C6003DD_var*
var
 l_Zoom  : Integer;
//#UC END# *4E706B7C00A6_4E706C6003DD_var*
begin
//#UC START# *4E706B7C00A6_4E706C6003DD_impl*
 if {$IfDef Nemesis}
    (aMetrics.IsWebStyle AND aParent.InPara(k2_typCommentPara)) OR
    {$EndIf Nemesis}
    aChild.AsObject.Owner.IsKindOf(k2_typSBS)
    then
  Result := TnevRubberCellsRenderInfo.Create(aParent, aChild)
 else
 if aMetrics.IsWebStyle AND
    (aMetrics.AllowRubberTables = nev_rtmZoom) then
  Result := TnevZoomedRubberCellsRenderInfo.Create(aParent, aChild)
 else
 if aMetrics.IsWebStyle AND
    (aMetrics.AllowRubberTables = nev_rtmFitToWindow) then
  Result := TnevRubberCellsRenderInfo.Create(aParent, aChild)
 else
 begin
  l_Zoom := aParent.Obj.AsObject.IntA[k2_tiZoom];
  if (l_Zoom > 0) AND (l_Zoom < 100) then
   Result := TnevZoomedCellsRenderInfo.Create(aParent, aChild)
  else
  {$If not Defined(EverestLite) AND not Defined(Archi) AND not Defined(Nemesis)}
  if aMetrics.IsWebStyle then
   Result := TnevRubberCellsRenderInfo.Create(aParent, aChild)
  else
  {$IfEnd}
   Result := TnevTableRowRenderInfo.Create(aParent, aChild);
 end;//aMetrics.IsWebStyle aMetrics.AllowRubberTables
//#UC END# *4E706B7C00A6_4E706C6003DD_impl*
end;//TnevTableRowRenderInfoEx.CreateInst

end.
