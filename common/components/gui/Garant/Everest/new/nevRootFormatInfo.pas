unit nevRootFormatInfo;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevRootFormatInfo.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevRootFormatInfo" MUID: (4815B8D801D8)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , nevDocumentFormatInfo
 , nevTools
 , nevBase
 , nevFormatPoolBase
 , l3Variant
;

type
 _nevDocumentContainerDecorationRules_Parent_ = TnevDocumentFormatInfo;
 {$Include w:\common\components\gui\Garant\Everest\nevDocumentContainerDecorationRules.imp.pas}
 TnevRootFormatInfo = class(_nevDocumentContainerDecorationRules_, InevViewMetrics)
  private
   f_IsWebStyle: Boolean;
   f_ShowDocumentParts: Boolean;
   f_ShowSpecial: Boolean;
   f_HiddenStyles: TnevStandardStyles;
   f_InfoCanvas: InevInfoCanvas;
   f_Extent: TnevPoint;
   f_ExcludeSuper: TevNormalSegLayerHandleSet;
   f_AACLike: TnevAACLikeMode;
   f_Pool: TnevFormatPoolBase;
   f_FormatCanvas: InevInfoCanvas;
   f_AllowRubberTables: TnevRubberTablesMode;
   f_NeedTotalRecalc: Boolean;
  protected
   function pm_GetLimitWidth: TnevInch;
   function pm_GetInfoCanvas: InevInfoCanvas;
   function pm_GetIsWebStyle: Boolean;
   function pm_GetShowDocumentParts: Boolean;
   function pm_GetShowSpecial: Boolean;
   function pm_GetHiddenStyles: TnevStandardStyles;
   function pm_GetExtent: TnevPoint;
   function Get_ExcludeSuper: TevNormalSegLayerHandleSet;
   function Get_FormatCanvas: InevInfoCanvas;
   function Get_AllowRubberTables: TnevRubberTablesMode;
   function IsTagCollapsed(aTag: Tl3Variant): Boolean;
   function Get_Data: InevObjectPrim;
   function Get_AACLike: TnevAACLikeMode;
   function NeedTotalRecalc: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function pm_GetlocSpacing: TnevRect; override;
   procedure ClearFields; override;
  public
   constructor Create(const aView: InevView;
    aPool: TnevFormatPoolBase); reintroduce;
   function Metrics: InevViewMetrics; override;
   function ViewArea: InevViewArea; override;
   function Container: InevObjectHolder; override;
 end;//TnevRootFormatInfo

implementation

uses
 l3ImplUses
 , nevFacade
 , l3PrinterIC
 , k2Tags
 {$If Defined(k2ForEditor)}
 , evDocumentPart
 {$IfEnd} // Defined(k2ForEditor)
 , l3Units
 , evTextStyle_Const
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
;

{$Include w:\common\components\gui\Garant\Everest\nevDocumentContainerDecorationRules.imp.pas}

constructor TnevRootFormatInfo.Create(const aView: InevView;
 aPool: TnevFormatPoolBase);
//#UC START# *4815CF1D0047_4815B8D801D8_var*
//#UC END# *4815CF1D0047_4815B8D801D8_var*
begin
//#UC START# *4815CF1D0047_4815B8D801D8_impl*
 LimitWidth := aView.Metrics.LimitWidth;
 inherited Create(nil, aPool.Obj);
 f_Pool := aPool;
 with aView.Metrics do
 begin
  f_IsWebStyle := IsWebStyle;
  f_AACLike := AACLike;
  f_AllowRubberTables := AllowRubberTables;
  f_ShowDocumentParts := ShowDocumentParts;
  f_ShowSpecial := ShowSpecial;
  f_HiddenStyles := HiddenStyles;
  f_ExcludeSuper := ExcludeSuper;
//  {$IFDEF Nemesis}
  if InfoCanvas.Printing then
   f_InfoCanvas := InfoCanvas
  else
   f_InfoCanvas := nil;
  if FormatCanvas.Printing then
   f_FormatCanvas := FormatCanvas
  else
   f_FormatCanvas := nil;
(*  {$ELSE}
   f_InfoCanvas := InfoCanvas;
 // УБРАНО! http://mdp.garant.ru/pages/viewpage.action?pageId=142610892
  {$ENDIF Nemesis}*)
  f_Extent := Extent;
  f_NeedTotalRecalc := NeedTotalRecalc;
 end;//with aView.Metrics
//#UC END# *4815CF1D0047_4815B8D801D8_impl*
end;//TnevRootFormatInfo.Create

function TnevRootFormatInfo.pm_GetLimitWidth: TnevInch;
//#UC START# *476BFB3C007A_4815B8D801D8get_var*
//#UC END# *476BFB3C007A_4815B8D801D8get_var*
begin
//#UC START# *476BFB3C007A_4815B8D801D8get_impl*
 Result := LimitWidth;
//#UC END# *476BFB3C007A_4815B8D801D8get_impl*
end;//TnevRootFormatInfo.pm_GetLimitWidth

function TnevRootFormatInfo.pm_GetInfoCanvas: InevInfoCanvas;
//#UC START# *476BFBE10164_4815B8D801D8get_var*
//#UC END# *476BFBE10164_4815B8D801D8get_var*
begin
//#UC START# *476BFBE10164_4815B8D801D8get_impl*
 if (f_InfoCanvas = nil) then
  Result := nev.CrtIC
 else
  Result := f_InfoCanvas;
 Assert(Result <> nil);
//#UC END# *476BFBE10164_4815B8D801D8get_impl*
end;//TnevRootFormatInfo.pm_GetInfoCanvas

function TnevRootFormatInfo.pm_GetIsWebStyle: Boolean;
//#UC START# *476BFC120188_4815B8D801D8get_var*
//#UC END# *476BFC120188_4815B8D801D8get_var*
begin
//#UC START# *476BFC120188_4815B8D801D8get_impl*
 Result := f_IsWebStyle
//#UC END# *476BFC120188_4815B8D801D8get_impl*
end;//TnevRootFormatInfo.pm_GetIsWebStyle

function TnevRootFormatInfo.pm_GetShowDocumentParts: Boolean;
//#UC START# *476BFC2101FB_4815B8D801D8get_var*
//#UC END# *476BFC2101FB_4815B8D801D8get_var*
begin
//#UC START# *476BFC2101FB_4815B8D801D8get_impl*
 Result := f_ShowDocumentParts;
//#UC END# *476BFC2101FB_4815B8D801D8get_impl*
end;//TnevRootFormatInfo.pm_GetShowDocumentParts

function TnevRootFormatInfo.pm_GetShowSpecial: Boolean;
//#UC START# *476BFC34010B_4815B8D801D8get_var*
//#UC END# *476BFC34010B_4815B8D801D8get_var*
begin
//#UC START# *476BFC34010B_4815B8D801D8get_impl*
 Result := f_ShowSpecial;
//#UC END# *476BFC34010B_4815B8D801D8get_impl*
end;//TnevRootFormatInfo.pm_GetShowSpecial

function TnevRootFormatInfo.pm_GetHiddenStyles: TnevStandardStyles;
//#UC START# *476BFC420000_4815B8D801D8get_var*
//#UC END# *476BFC420000_4815B8D801D8get_var*
begin
//#UC START# *476BFC420000_4815B8D801D8get_impl*
 Result := f_HiddenStyles;
//#UC END# *476BFC420000_4815B8D801D8get_impl*
end;//TnevRootFormatInfo.pm_GetHiddenStyles

function TnevRootFormatInfo.pm_GetExtent: TnevPoint;
//#UC START# *486D2C6702FA_4815B8D801D8get_var*
//#UC END# *486D2C6702FA_4815B8D801D8get_var*
begin
//#UC START# *486D2C6702FA_4815B8D801D8get_impl*
 Result := f_Extent;
//#UC END# *486D2C6702FA_4815B8D801D8get_impl*
end;//TnevRootFormatInfo.pm_GetExtent

function TnevRootFormatInfo.Get_ExcludeSuper: TevNormalSegLayerHandleSet;
//#UC START# *4AEAE49B024D_4815B8D801D8get_var*
//#UC END# *4AEAE49B024D_4815B8D801D8get_var*
begin
//#UC START# *4AEAE49B024D_4815B8D801D8get_impl*
 Result := f_ExcludeSuper;
//#UC END# *4AEAE49B024D_4815B8D801D8get_impl*
end;//TnevRootFormatInfo.Get_ExcludeSuper

function TnevRootFormatInfo.Get_FormatCanvas: InevInfoCanvas;
//#UC START# *4B7E744702C0_4815B8D801D8get_var*
//#UC END# *4B7E744702C0_4815B8D801D8get_var*
begin
//#UC START# *4B7E744702C0_4815B8D801D8get_impl*
 if (f_FormatCanvas = nil) then
  Result := nev.CrtIC
 else
  Result := f_FormatCanvas;
 Assert(Result <> nil);
//#UC END# *4B7E744702C0_4815B8D801D8get_impl*
end;//TnevRootFormatInfo.Get_FormatCanvas

function TnevRootFormatInfo.Get_AllowRubberTables: TnevRubberTablesMode;
//#UC START# *4BED6E9300FD_4815B8D801D8get_var*
//#UC END# *4BED6E9300FD_4815B8D801D8get_var*
begin
//#UC START# *4BED6E9300FD_4815B8D801D8get_impl*
 Result := f_AllowRubberTables;
//#UC END# *4BED6E9300FD_4815B8D801D8get_impl*
end;//TnevRootFormatInfo.Get_AllowRubberTables

function TnevRootFormatInfo.IsTagCollapsed(aTag: Tl3Variant): Boolean;
//#UC START# *4D5A80DC029D_4815B8D801D8_var*
//#UC END# *4D5A80DC029D_4815B8D801D8_var*
begin
//#UC START# *4D5A80DC029D_4815B8D801D8_impl*
 Result := aTag.BoolA[k2_tiCollapsed];
 evCheckCollapsed(aTag, Result);
//#UC END# *4D5A80DC029D_4815B8D801D8_impl*
end;//TnevRootFormatInfo.IsTagCollapsed

function TnevRootFormatInfo.Get_Data: InevObjectPrim;
//#UC START# *4E5E285C0166_4815B8D801D8get_var*
//#UC END# *4E5E285C0166_4815B8D801D8get_var*
begin
//#UC START# *4E5E285C0166_4815B8D801D8get_impl*
 Result := Obj;
//#UC END# *4E5E285C0166_4815B8D801D8get_impl*
end;//TnevRootFormatInfo.Get_Data

function TnevRootFormatInfo.Get_AACLike: TnevAACLikeMode;
//#UC START# *501F96A80050_4815B8D801D8get_var*
//#UC END# *501F96A80050_4815B8D801D8get_var*
begin
//#UC START# *501F96A80050_4815B8D801D8get_impl*
 Result := f_AACLike;
//#UC END# *501F96A80050_4815B8D801D8get_impl*
end;//TnevRootFormatInfo.Get_AACLike

function TnevRootFormatInfo.NeedTotalRecalc: Boolean;
//#UC START# *565F03C80029_4815B8D801D8_var*
//#UC END# *565F03C80029_4815B8D801D8_var*
begin
//#UC START# *565F03C80029_4815B8D801D8_impl*
 Result := f_NeedTotalRecalc;
//#UC END# *565F03C80029_4815B8D801D8_impl*
end;//TnevRootFormatInfo.NeedTotalRecalc

procedure TnevRootFormatInfo.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4815B8D801D8_var*
//#UC END# *479731C50290_4815B8D801D8_var*
begin
//#UC START# *479731C50290_4815B8D801D8_impl*
 f_InfoCanvas := nil;
 f_Pool := nil;
 inherited;
//#UC END# *479731C50290_4815B8D801D8_impl*
end;//TnevRootFormatInfo.Cleanup

function TnevRootFormatInfo.Metrics: InevViewMetrics;
//#UC START# *481733EB00F5_4815B8D801D8_var*
//#UC END# *481733EB00F5_4815B8D801D8_var*
begin
//#UC START# *481733EB00F5_4815B8D801D8_impl*
 Result := Self;
//#UC END# *481733EB00F5_4815B8D801D8_impl*
end;//TnevRootFormatInfo.Metrics

function TnevRootFormatInfo.ViewArea: InevViewArea;
//#UC START# *481740670066_4815B8D801D8_var*
//#UC END# *481740670066_4815B8D801D8_var*
begin
//#UC START# *481740670066_4815B8D801D8_impl*
 Result := f_Pool.Container.ViewArea; 
//#UC END# *481740670066_4815B8D801D8_impl*
end;//TnevRootFormatInfo.ViewArea

function TnevRootFormatInfo.Container: InevObjectHolder;
//#UC START# *481742AB0349_4815B8D801D8_var*
//#UC END# *481742AB0349_4815B8D801D8_var*
begin
//#UC START# *481742AB0349_4815B8D801D8_impl*
 Result := f_Pool.Container;
//#UC END# *481742AB0349_4815B8D801D8_impl*
end;//TnevRootFormatInfo.Container

function TnevRootFormatInfo.pm_GetlocSpacing: TnevRect;
//#UC START# *4E5F3D1102B8_4815B8D801D8get_var*
{$IfDef Nemesis}
(*var
 l_IC  : InevInfoCanvas;*)
{$EndIf Nemesis}
//#UC END# *4E5F3D1102B8_4815B8D801D8get_var*
begin
//#UC START# *4E5F3D1102B8_4815B8D801D8get_impl*
 Result := inherited pm_GetLocSpacing;
 if {Metrics.}f_ShowDocumentParts then
  Tl3Rect(Result).TopLeft := Tl3Rect(Result).TopLeft.Add(l3PointY(evDocumentPartMargin));
 if {Metrics.}f_IsWebStyle then
  Result.Right := 0;
 {$IfDef Nemesis}
 if (f_InfoCanvas <> nil) then
 // ! - специально не pm_GetInfoCanvas
  Result := f_InfoCanvas.AdjustMarginsByPrintableArea(Result);
(* l_IC := f_InfoCanvas{Metrics.InfoCanvas};
 if (l_IC <> nil) then
  Result := l_IC.AdjustMarginsByPrintableArea(Result);*)
 {$EndIf}
//#UC END# *4E5F3D1102B8_4815B8D801D8get_impl*
end;//TnevRootFormatInfo.pm_GetlocSpacing

procedure TnevRootFormatInfo.ClearFields;
begin
 f_InfoCanvas := nil;
 f_FormatCanvas := nil;
 inherited;
end;//TnevRootFormatInfo.ClearFields

end.
