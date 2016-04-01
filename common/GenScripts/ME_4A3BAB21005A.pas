unit nevSolidParaAnchor;
 {* якорь листьевого параграфа не имеющего делени€ на строки }

// ћодуль: "w:\common\components\gui\Garant\Everest\new\nevSolidParaAnchor.pas"
// —тереотип: "SimpleClass"
// Ёлемент модели: "TnevSolidParaAnchor" MUID: (4A3BAB21005A)

{$Include w:\common\components\gui\Garant\Everest\new\nevDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevLeafParaAnchor
 , nevBase
 , nevTools
;

type
 _nevSolidParaAnchorModify_Parent_ = TnevLeafParaAnchor;
 {$Include w:\common\components\gui\Garant\Everest\nevSolidParaAnchorModify.imp.pas}
 TnevSolidParaAnchor = class(_nevSolidParaAnchorModify_)
  {* якорь листьевого параграфа не имеющего делени€ на строки }
  private
   f_Y: Integer;
  protected
   function GetAtStart: Boolean; override;
   function GetAtEnd(const aView: InevView): Boolean; override;
   function GetVertPosition(const aView: InevView;
    aMap: TnevFormatInfoPrim): TnevParaIndex; override;
   {$If Defined(evUseVisibleCursors)}
   function GetY: Integer; override;
   {$IfEnd} // Defined(evUseVisibleCursors)
   {$If Defined(evUseVisibleCursors)}
   procedure SetY(aValue: Integer); override;
   {$IfEnd} // Defined(evUseVisibleCursors)
   procedure Cleanup; override;
    {* ‘ункци€ очистки полей объекта. }
   function GetPaintOffsetY(const aView: InevView;
    aMap: TnevFormatInfoPrim): Integer; override;
   {$If Defined(evUseVisibleCursors)}
   function DoDiff(const aView: InevView;
    const aPoint: InevBasePoint;
    aMap: TnevFormatInfoPrim): Integer; override;
   {$IfEnd} // Defined(evUseVisibleCursors)
   procedure DoAssignPoint(const aView: InevView;
    const aPoint: InevBasePoint); override;
 end;//TnevSolidParaAnchor
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevFacade
 , LeafParaDecorationsHolder_Const
 , l3MinMax
;

{$Include w:\common\components\gui\Garant\Everest\nevSolidParaAnchorModify.imp.pas}

function TnevSolidParaAnchor.GetAtStart: Boolean;
//#UC START# *4A3B707700C9_4A3BAB21005A_var*
//#UC END# *4A3B707700C9_4A3BAB21005A_var*
begin
//#UC START# *4A3B707700C9_4A3BAB21005A_impl*
 Result := (f_Y <= 0);
//#UC END# *4A3B707700C9_4A3BAB21005A_impl*
end;//TnevSolidParaAnchor.GetAtStart

function TnevSolidParaAnchor.GetAtEnd(const aView: InevView): Boolean;
//#UC START# *4A3B708900C4_4A3BAB21005A_var*
var
 l_Map : TnevFormatInfoPrim;
//#UC END# *4A3B708900C4_4A3BAB21005A_var*
begin
//#UC START# *4A3B708900C4_4A3BAB21005A_impl*
 l_Map := ObjMap(aView);
 if l_Map <> nil then
  Result := (f_Y >= l_Map.Height - nev.LineScrollDelta.Y)
 else
  Result := False; 
//#UC END# *4A3B708900C4_4A3BAB21005A_impl*
end;//TnevSolidParaAnchor.GetAtEnd

function TnevSolidParaAnchor.GetVertPosition(const aView: InevView;
 aMap: TnevFormatInfoPrim): TnevParaIndex;
//#UC START# *4A3B7F2E01CE_4A3BAB21005A_var*
//#UC END# *4A3B7F2E01CE_4A3BAB21005A_var*
begin
//#UC START# *4A3B7F2E01CE_4A3BAB21005A_impl*
 Result := f_Y div nev.LineScrollDelta.Y;
//#UC END# *4A3B7F2E01CE_4A3BAB21005A_impl*
end;//TnevSolidParaAnchor.GetVertPosition

{$If Defined(evUseVisibleCursors)}
function TnevSolidParaAnchor.GetY: Integer;
//#UC START# *4B1D0E1A0256_4A3BAB21005A_var*
//#UC END# *4B1D0E1A0256_4A3BAB21005A_var*
begin
//#UC START# *4B1D0E1A0256_4A3BAB21005A_impl*
 Result := f_Y;
//#UC END# *4B1D0E1A0256_4A3BAB21005A_impl*
end;//TnevSolidParaAnchor.GetY
{$IfEnd} // Defined(evUseVisibleCursors)

{$If Defined(evUseVisibleCursors)}
procedure TnevSolidParaAnchor.SetY(aValue: Integer);
//#UC START# *4B1D0E3A00F7_4A3BAB21005A_var*
//#UC END# *4B1D0E3A00F7_4A3BAB21005A_var*
begin
//#UC START# *4B1D0E3A00F7_4A3BAB21005A_impl*
 f_Y := aValue;
//#UC END# *4B1D0E3A00F7_4A3BAB21005A_impl*
end;//TnevSolidParaAnchor.SetY
{$IfEnd} // Defined(evUseVisibleCursors)

procedure TnevSolidParaAnchor.Cleanup;
 {* ‘ункци€ очистки полей объекта. }
//#UC START# *479731C50290_4A3BAB21005A_var*
//#UC END# *479731C50290_4A3BAB21005A_var*
begin
//#UC START# *479731C50290_4A3BAB21005A_impl*
 f_Y := 0;
 inherited;
//#UC END# *479731C50290_4A3BAB21005A_impl*
end;//TnevSolidParaAnchor.Cleanup

function TnevSolidParaAnchor.GetPaintOffsetY(const aView: InevView;
 aMap: TnevFormatInfoPrim): Integer;
//#UC START# *4A3BA80002E5_4A3BAB21005A_var*
//#UC END# *4A3BA80002E5_4A3BAB21005A_var*
begin
//#UC START# *4A3BA80002E5_4A3BAB21005A_impl*
 Result := f_Y;
//#UC END# *4A3BA80002E5_4A3BAB21005A_impl*
end;//TnevSolidParaAnchor.GetPaintOffsetY

{$If Defined(evUseVisibleCursors)}
function TnevSolidParaAnchor.DoDiff(const aView: InevView;
 const aPoint: InevBasePoint;
 aMap: TnevFormatInfoPrim): Integer;
//#UC START# *4AA785540310_4A3BAB21005A_var*
//#UC END# *4AA785540310_4A3BAB21005A_var*
begin
//#UC START# *4AA785540310_4A3BAB21005A_impl*
 Result := inherited DoDiff(aView, aPoint, aMap);
 if (Result <> 0) and aPoint.AtEnd(aView) and GetAtEnd(aView) then // http://mdp.garant.ru/pages/viewpage.action?pageId=382406560
  Result := 0;
//#UC END# *4AA785540310_4A3BAB21005A_impl*
end;//TnevSolidParaAnchor.DoDiff
{$IfEnd} // Defined(evUseVisibleCursors)

procedure TnevSolidParaAnchor.DoAssignPoint(const aView: InevView;
 const aPoint: InevBasePoint);
//#UC START# *4B1D0220010E_4A3BAB21005A_var*
//#UC END# *4B1D0220010E_4A3BAB21005A_var*
begin
//#UC START# *4B1D0220010E_4A3BAB21005A_impl*
 inherited;
 if (aPoint <> nil) then
 begin
  if not (aPoint.AsObject.IsKindOf(k2_typLeafParaDecorationsHolder) and (aPoint.Obj.ChildrenCount = 1)) then
   f_Y := aPoint.AsLeaf.PaintOffsetY(aView, ObjMap(aView));
  SignalScroll;
 end;//aPoint <> nil
//#UC END# *4B1D0220010E_4A3BAB21005A_impl*
end;//TnevSolidParaAnchor.DoAssignPoint
{$IfEnd} // Defined(k2ForEditor)

end.
