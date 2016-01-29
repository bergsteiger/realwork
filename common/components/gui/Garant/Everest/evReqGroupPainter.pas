unit evReqGroupPainter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evReqGroupPainter.pas"
// Начат: 22.02.2011 21:17
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParaList Painters::TevReqGroupPainter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evNeedPainters) AND defined(evReqGroupNeedsRadio)}
uses
  evTablePainter,
  nevTools,
  nevRealTools
  ;
{$IfEnd} //evNeedPainters AND evReqGroupNeedsRadio

{$If defined(evNeedPainters) AND defined(evReqGroupNeedsRadio)}
type
 TevReqGroupPainter = class(TevTablePainter)
 protected
 // overridden protected methods
   function DoDraw: Boolean; override;
     {* Собственно процедура рисования параграфа. Для перекрытия в потомках. }
   procedure AfterDrawChild(const aChild: InevPara;
     const aChildPainter: IevPainter;
     const aChildInfo: TnevShapeInfo); override;
 end;//TevReqGroupPainter
{$IfEnd} //evNeedPainters AND evReqGroupNeedsRadio

implementation

{$If defined(evNeedPainters) AND defined(evReqGroupNeedsRadio)}
uses
  l3Units,
  l3Interfaces,
  k2Tags,
  l3MinMax
  ;
{$IfEnd} //evNeedPainters AND evReqGroupNeedsRadio

{$If defined(evNeedPainters) AND defined(evReqGroupNeedsRadio)}

// start class TevReqGroupPainter

function TevReqGroupPainter.DoDraw: Boolean;
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

{$IfEnd} //evNeedPainters AND evReqGroupNeedsRadio

end.