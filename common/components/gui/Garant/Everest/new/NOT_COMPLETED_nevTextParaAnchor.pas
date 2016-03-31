unit NOT_COMPLETED_nevTextParaAnchor;

// Модуль: "w:\common\components\gui\Garant\Everest\new\NOT_COMPLETED_nevTextParaAnchor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevTextParaAnchor" MUID: (4A3F37440382)

{$Include w:\common\components\gui\Garant\Everest\new\nevDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevLeafParaAnchor
 , nevBase
 , nevTools
 , l3Variant
;

type
 _nevTextParaTool_Parent_ = TnevLeafParaAnchor;
 {$Include w:\common\components\gui\Garant\Everest\new\nevTextParaTool.imp.pas}
 _nevTextParaViewBounds_Parent_ = _nevTextParaTool_;
 {$Include w:\common\components\gui\Garant\Everest\nevTextParaViewBounds.imp.pas}
 _nevTextParaAnchorModify_Parent_ = _nevTextParaViewBounds_;
 {$Include w:\common\components\gui\Garant\Everest\nevTextParaAnchorModify.imp.pas}
 TnevTextParaAnchor = class(_nevTextParaAnchorModify_)
  private
   f_Line: Integer;
  protected
   function GetAtStart: Boolean; override;
   function GetAtEnd(const aView: InevView): Boolean; override;
   function GetVertPosition(const aView: InevView;
    aMap: TnevFormatInfoPrim): TnevParaIndex; override;
   {$If Defined(evUseVisibleCursors)}
   procedure SetLinePrim(aValue: Integer;
    aMap: TnevFormatInfoPrim); override;
   {$IfEnd} // Defined(evUseVisibleCursors)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetPaintOffsetY(const aView: InevView;
    aMap: TnevFormatInfoPrim): Integer; override;
   procedure DoAssignPoint(const aView: InevView;
    const aPoint: InevBasePoint); override;
 end;//TnevTextParaAnchor
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , l3MinMax
 , evTextParaTools
 , SysUtils
 , l3Types
;

{$If not Declared(_X_)}type _X_ = InevPara;{$IfEnd}

{$If Defined(evUseVisibleCursors)}
function GetLC(aSelf: _nevTextParaViewBounds_;
 aMap: TnevFormatInfoPrim): TnevLineCoord;
 {* Возвращает текущую строку }
//#UC START# *4A5CD65C01D4_4A3F37440382_var*
//#UC END# *4A5CD65C01D4_4A3F37440382_var*
begin
//#UC START# *4A5CD65C01D4_4A3F37440382_impl*
 Result.rLine := TnevTextParaAnchor(aSelf).f_Line;
 Result.rOfs := 0;
//#UC END# *4A5CD65C01D4_4A3F37440382_impl*
end;//GetLC
{$IfEnd} // Defined(evUseVisibleCursors)

type _Instance_R_ = TnevTextParaAnchor;

{$Include w:\common\components\gui\Garant\Everest\new\nevTextParaTool.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\nevTextParaViewBounds.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\nevTextParaAnchorModify.imp.pas}

function TnevTextParaAnchor.GetAtStart: Boolean;
//#UC START# *4A3B707700C9_4A3F37440382_var*
//#UC END# *4A3B707700C9_4A3F37440382_var*
begin
//#UC START# *4A3B707700C9_4A3F37440382_impl*
 Result := (f_Line <= 0);
//#UC END# *4A3B707700C9_4A3F37440382_impl*
end;//TnevTextParaAnchor.GetAtStart

function TnevTextParaAnchor.GetAtEnd(const aView: InevView): Boolean;
//#UC START# *4A3B708900C4_4A3F37440382_var*
//#UC END# *4A3B708900C4_4A3F37440382_var*
begin
//#UC START# *4A3B708900C4_4A3F37440382_impl*
 Result := (f_Line >= Pred(evTextParaLineCount(ObjMap(aView))));
//#UC END# *4A3B708900C4_4A3F37440382_impl*
end;//TnevTextParaAnchor.GetAtEnd

function TnevTextParaAnchor.GetVertPosition(const aView: InevView;
 aMap: TnevFormatInfoPrim): TnevParaIndex;
//#UC START# *4A3B7F2E01CE_4A3F37440382_var*
//#UC END# *4A3B7F2E01CE_4A3F37440382_var*
begin
//#UC START# *4A3B7F2E01CE_4A3F37440382_impl*
 Result := f_Line;
//#UC END# *4A3B7F2E01CE_4A3F37440382_impl*
end;//TnevTextParaAnchor.GetVertPosition

{$If Defined(evUseVisibleCursors)}
procedure TnevTextParaAnchor.SetLinePrim(aValue: Integer;
 aMap: TnevFormatInfoPrim);
//#UC START# *4B1D11DC00AD_4A3F37440382_var*
//#UC END# *4B1D11DC00AD_4A3F37440382_var*
begin
//#UC START# *4B1D11DC00AD_4A3F37440382_impl*
 f_Line := aValue;
//#UC END# *4B1D11DC00AD_4A3F37440382_impl*
end;//TnevTextParaAnchor.SetLinePrim
{$IfEnd} // Defined(evUseVisibleCursors)

procedure TnevTextParaAnchor.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A3F37440382_var*
//#UC END# *479731C50290_4A3F37440382_var*
begin
//#UC START# *479731C50290_4A3F37440382_impl*
 f_Line := 0;
 inherited;
//#UC END# *479731C50290_4A3F37440382_impl*
end;//TnevTextParaAnchor.Cleanup

function TnevTextParaAnchor.GetPaintOffsetY(const aView: InevView;
 aMap: TnevFormatInfoPrim): Integer;
//#UC START# *4A3BA80002E5_4A3F37440382_var*
//#UC END# *4A3BA80002E5_4A3F37440382_var*
begin
//#UC START# *4A3BA80002E5_4A3F37440382_impl*
 if (aMap = nil) then
 // http://mdp.garant.ru/pages/viewpage.action?pageId=294598808
  Result := 0
 else
 if aMap.IsHidden(false, false) then
  Result := 0
 else
  Result := evTextParaGetDeltaByLine(aMap, ParaX, VertPosition(aView, aMap));
//#UC END# *4A3BA80002E5_4A3F37440382_impl*
end;//TnevTextParaAnchor.GetPaintOffsetY

procedure TnevTextParaAnchor.DoAssignPoint(const aView: InevView;
 const aPoint: InevBasePoint);
//#UC START# *4B1D0220010E_4A3F37440382_var*
//#UC END# *4B1D0220010E_4A3F37440382_var*
begin
//#UC START# *4B1D0220010E_4A3F37440382_impl*
 inherited;
 if (aPoint <> nil) then
 begin
  f_Line := aPoint.VertPosition(aView, nil);
  SignalScroll;
 end;//aPoint <> nil
//#UC END# *4B1D0220010E_4A3F37440382_impl*
end;//TnevTextParaAnchor.DoAssignPoint
{$IfEnd} // Defined(k2ForEditor)

end.
