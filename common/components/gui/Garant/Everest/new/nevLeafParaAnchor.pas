unit nevLeafParaAnchor;
 {* якорь дл€ листьевых параграфов }

// ћодуль: "w:\common\components\gui\Garant\Everest\new\nevLeafParaAnchor.pas"
// —тереотип: "SimpleClass"
// Ёлемент модели: "TnevLeafParaAnchor" MUID: (4A3B9AD60266)

{$Include w:\common\components\gui\Garant\Everest\new\nevDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevAnchor
 , nevTools
 , nevBase
;

type
 TnevLeafParaAnchor = class(TnevAnchor, InevLeafPoint)
  {* якорь дл€ листьевых параграфов }
  protected
   function ObjMap(const aView: InevView): TnevFormatInfoPrim;
   function GetPaintOffsetY(const aView: InevView;
    aMap: TnevFormatInfoPrim): Integer; virtual;
   procedure InitPointByPt(const aView: InevView;
    const aPoint: TnevPoint;
    const aMap: InevMap);
   function GetAsLeaf: InevLeafPoint; override;
   function GetPosition: TnevPosition; override;
  public
   function PaintOffsetY(const aView: InevView;
    aMap: TnevFormatInfoPrim): Integer;
 end;//TnevLeafParaAnchor
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 //#UC START# *4A3B9AD60266impl_uses*
 //#UC END# *4A3B9AD60266impl_uses*
;

function TnevLeafParaAnchor.ObjMap(const aView: InevView): TnevFormatInfoPrim;
//#UC START# *4A3B9B3B0161_4A3B9AD60266_var*
//#UC END# *4A3B9B3B0161_4A3B9AD60266_var*
begin
//#UC START# *4A3B9B3B0161_4A3B9AD60266_impl*
 if (aView <> nil) then
  Result := aView.FormatInfoByPara(ParaX)
 else
(* if (Para.Shape.View <> nil) then
  Result := Para.Shape.View._MapByPoint(Obj.Point)
 else*)
  Result := nil;
//#UC END# *4A3B9B3B0161_4A3B9AD60266_impl*
end;//TnevLeafParaAnchor.ObjMap

function TnevLeafParaAnchor.GetPaintOffsetY(const aView: InevView;
 aMap: TnevFormatInfoPrim): Integer;
//#UC START# *4A3BA80002E5_4A3B9AD60266_var*
//#UC END# *4A3BA80002E5_4A3B9AD60266_var*
begin
//#UC START# *4A3BA80002E5_4A3B9AD60266_impl*
 Result := 0;
//#UC END# *4A3BA80002E5_4A3B9AD60266_impl*
end;//TnevLeafParaAnchor.GetPaintOffsetY

procedure TnevLeafParaAnchor.InitPointByPt(const aView: InevView;
 const aPoint: TnevPoint;
 const aMap: InevMap);
//#UC START# *47FB320102A6_4A3B9AD60266_var*
//#UC END# *47FB320102A6_4A3B9AD60266_var*
begin
//#UC START# *47FB320102A6_4A3B9AD60266_impl*
 Assert(false);
//#UC END# *47FB320102A6_4A3B9AD60266_impl*
end;//TnevLeafParaAnchor.InitPointByPt

function TnevLeafParaAnchor.PaintOffsetY(const aView: InevView;
 aMap: TnevFormatInfoPrim): Integer;
//#UC START# *4A5CDCAC0230_4A3B9AD60266_var*
//#UC END# *4A5CDCAC0230_4A3B9AD60266_var*
begin
//#UC START# *4A5CDCAC0230_4A3B9AD60266_impl*
 Result := GetPaintOffsetY(aView, aMap);
//#UC END# *4A5CDCAC0230_4A3B9AD60266_impl*
end;//TnevLeafParaAnchor.PaintOffsetY

function TnevLeafParaAnchor.GetAsLeaf: InevLeafPoint;
//#UC START# *4A3B7E35010E_4A3B9AD60266_var*
//#UC END# *4A3B7E35010E_4A3B9AD60266_var*
begin
//#UC START# *4A3B7E35010E_4A3B9AD60266_impl*
 Result := Self;
//#UC END# *4A3B7E35010E_4A3B9AD60266_impl*
end;//TnevLeafParaAnchor.GetAsLeaf

function TnevLeafParaAnchor.GetPosition: TnevPosition;
//#UC START# *4A3B7E540378_4A3B9AD60266_var*
//#UC END# *4A3B7E540378_4A3B9AD60266_var*
begin
//#UC START# *4A3B7E540378_4A3B9AD60266_impl*
 Result := 0;
//#UC END# *4A3B7E540378_4A3B9AD60266_impl*
end;//TnevLeafParaAnchor.GetPosition
{$IfEnd} // Defined(k2ForEditor)

end.
