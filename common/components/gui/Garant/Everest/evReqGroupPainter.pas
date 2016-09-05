unit evReqGroupPainter;

// Модуль: "w:\common\components\gui\Garant\Everest\evReqGroupPainter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevReqGroupPainter" MUID: (4D63C57601A4)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedPainters) AND Defined(evReqGroupNeedsRadio)}
uses
 l3IntfUses
 , evTablePainter
 , nevTools
 , nevRealTools
;

type
 TevReqGroupPainter = class(TevTablePainter)
  protected
   function DoDraw: Boolean; override;
    {* Собственно процедура рисования параграфа. Для перекрытия в потомках. }
   procedure AfterDrawChild(const aChild: InevPara;
    const aChildPainter: IevPainter;
    const aChildInfo: TnevShapeInfo); override;
 end;//TevReqGroupPainter
{$IfEnd} // Defined(evNeedPainters) AND Defined(evReqGroupNeedsRadio)

implementation

{$If Defined(evNeedPainters) AND Defined(evReqGroupNeedsRadio)}
uses
 l3ImplUses
 , l3Units
 , l3Interfaces
 , k2Tags
 , l3MinMax
 //#UC START# *4D63C57601A4impl_uses*
 //#UC END# *4D63C57601A4impl_uses*
;

function TevReqGroupPainter.DoDraw: Boolean;
 {* Собственно процедура рисования параграфа. Для перекрытия в потомках. }
//#UC START# *4804BC2401C2_4D63C57601A4_var*
//#UC END# *4804BC2401C2_4D63C57601A4_var*
begin
//#UC START# *4804BC2401C2_4D63C57601A4_impl*
 Result := inherited DoDraw;
//#UC END# *4804BC2401C2_4D63C57601A4_impl*
end;//TevReqGroupPainter.DoDraw

procedure TevReqGroupPainter.AfterDrawChild(const aChild: InevPara;
 const aChildPainter: IevPainter;
 const aChildInfo: TnevShapeInfo);
//#UC START# *4D63E3490015_4D63C57601A4_var*
const
 cDim = 10;
const
 lc_State: array [Boolean] of Tl3CheckBoxState = (l3_cbUnchecked, l3_cbChecked);
//#UC END# *4D63E3490015_4D63C57601A4_var*
begin
//#UC START# *4D63E3490015_4D63C57601A4_impl*
 PushWO;
 try
  inherited;
 finally
  PopWO;
 end;//try..finally
 if (aChild.PID = Max(0, (ParaX.ChildrenCount - 1) div 2)) then
 begin
  SmartCanvas.DrawCheckOrRadio(false,
                               l3SBounds(10,
                                         Area.rCanvas.LP2DP(l3PointY(aChildInfo.rMap.FI.Height)).Y div 2
                                         - cDim div 2 + 3,
                                         // ^ - это магия чисел
                                         cDim,
                                         cDim),
                               lc_State[ParaX.BoolA[k2_tiChecked]],
                               true{ParaX.BoolA[k2_tiChecked]},
                               false);
 end;//aChild.PID = Max..
 if not ParaX.BoolA[k2_tiChecked] then
 begin
  PushBC;
  try
   with Area.rCanvas do
   begin
    BackColor := ParaX.IntA[k2_tiBackColor];
    FillEmptyRect(Tl3Rect(aChildInfo.rMap.Bounds).AddPt(WindowOrg));
   end;//with Area.rCanvas
  finally
   PopBC;
  end;//try..finally
 end;//not ParaX.BoolA[k2_tiChecked]
//#UC END# *4D63E3490015_4D63C57601A4_impl*
end;//TevReqGroupPainter.AfterDrawChild
{$IfEnd} // Defined(evNeedPainters) AND Defined(evReqGroupNeedsRadio)

end.
