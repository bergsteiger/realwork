unit nevLeafParaAnchor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevLeafParaAnchor.pas"
// Начат: 12.04.2005 15:42
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Anchors::TnevLeafParaAnchor
//
// Якорь для листьевых параграфов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\new\nevDefine.inc}

interface

{$If defined(k2ForEditor)}
uses
  nevBase,
  nevTools,
  nevAnchor
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}
type
 TnevLeafParaAnchor = class(TnevAnchor, InevLeafPoint)
  {* Якорь для листьевых параграфов }
 protected
 // realized methods
   procedure InitPointByPt(const aView: InevView;
     const aPoint: TnevPoint;
     const aMap: InevMap);
 public
 // realized methods
   function PaintOffsetY(const aView: InevView;
     aMap: TnevFormatInfoPrim): Integer;
 protected
 // overridden protected methods
   function GetAsLeaf: InevLeafPoint; override;
   function GetPosition: TnevPosition; override;
 protected
 // protected methods
   function ObjMap(const aView: InevView): TnevFormatInfoPrim;
   function GetPaintOffsetY(const aView: InevView;
    aMap: TnevFormatInfoPrim): Integer; virtual;
 end;//TnevLeafParaAnchor
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}

// start class TnevLeafParaAnchor

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

{$IfEnd} //k2ForEditor

end.