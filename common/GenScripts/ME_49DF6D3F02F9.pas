unit evSolidParaCursor;

// Модуль: "w:\common\components\gui\Garant\Everest\evSolidParaCursor.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evLeafParaCursor
 , nevBase
 , nevTools
;

type
 _nevSolidParaAnchorModify_Parent_ = TevLeafParaCursor;
 {$Include w:\common\components\gui\Garant\Everest\nevSolidParaAnchorModify.imp.pas}
 TevSolidParaCursor = class(_nevSolidParaAnchorModify_)
  private
   f_Y: Integer;
  protected
   function GetY: Integer; override;
   procedure SetY(aValue: Integer); override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoAssignPoint(const aView: InevView;
    const aPoint: InevBasePoint); override;
   function GetPaintOffsetY(const aView: InevView;
    aMap: TnevFormatInfoPrim): Integer; override;
   procedure DoInitPointByPt(const aView: InevView;
    const aPoint: TnevPoint;
    const aMap: InevMap); override;
   function GetAtEnd(const aView: InevView): Boolean; override;
   function GetVertPosition(const aView: InevView;
    aMap: TnevFormatInfoPrim): TnevParaIndex; override;
   function DoDiff(const aView: InevView;
    const aPoint: InevBasePoint;
    aMap: TnevFormatInfoPrim): Integer; override;
  public
   procedure DoSetEntryPointPrim(Value: Integer;
    const Context: IevCursorContext = nil); override;
 end;//TevSolidParaCursor
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , nevFacade
 , evCursorConst
 , l3MinMax
;

{$Include w:\common\components\gui\Garant\Everest\nevSolidParaAnchorModify.imp.pas}

function TevSolidParaCursor.GetY: Integer;
//#UC START# *4B1D0E1A0256_49DF6D3F02F9_var*
//#UC END# *4B1D0E1A0256_49DF6D3F02F9_var*
begin
//#UC START# *4B1D0E1A0256_49DF6D3F02F9_impl*
 Result := f_Y;
//#UC END# *4B1D0E1A0256_49DF6D3F02F9_impl*
end;//TevSolidParaCursor.GetY

procedure TevSolidParaCursor.SetY(aValue: Integer);
//#UC START# *4B1D0E3A00F7_49DF6D3F02F9_var*
//#UC END# *4B1D0E3A00F7_49DF6D3F02F9_var*
begin
//#UC START# *4B1D0E3A00F7_49DF6D3F02F9_impl*
 f_Y := aValue;
//#UC END# *4B1D0E3A00F7_49DF6D3F02F9_impl*
end;//TevSolidParaCursor.SetY

procedure TevSolidParaCursor.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_49DF6D3F02F9_var*
//#UC END# *479731C50290_49DF6D3F02F9_var*
begin
//#UC START# *479731C50290_49DF6D3F02F9_impl*
 f_Y := 0;
 inherited;
//#UC END# *479731C50290_49DF6D3F02F9_impl*
end;//TevSolidParaCursor.Cleanup

procedure TevSolidParaCursor.DoAssignPoint(const aView: InevView;
 const aPoint: InevBasePoint);
//#UC START# *49DE3CD8004F_49DF6D3F02F9_var*
//#UC END# *49DE3CD8004F_49DF6D3F02F9_var*
begin
//#UC START# *49DE3CD8004F_49DF6D3F02F9_impl*
 inherited;
 if (aPoint <> nil) then
  f_Y := aPoint.AsLeaf.PaintOffsetY(aView, ObjMap(aView));
//#UC END# *49DE3CD8004F_49DF6D3F02F9_impl*
end;//TevSolidParaCursor.DoAssignPoint

function TevSolidParaCursor.GetPaintOffsetY(const aView: InevView;
 aMap: TnevFormatInfoPrim): Integer;
//#UC START# *49DF6F2F0190_49DF6D3F02F9_var*
//#UC END# *49DF6F2F0190_49DF6D3F02F9_var*
begin
//#UC START# *49DF6F2F0190_49DF6D3F02F9_impl*
 Result := f_Y;
//#UC END# *49DF6F2F0190_49DF6D3F02F9_impl*
end;//TevSolidParaCursor.GetPaintOffsetY

procedure TevSolidParaCursor.DoInitPointByPt(const aView: InevView;
 const aPoint: TnevPoint;
 const aMap: InevMap);
//#UC START# *49DF703901BA_49DF6D3F02F9_var*
//#UC END# *49DF703901BA_49DF6D3F02F9_var*
begin
//#UC START# *49DF703901BA_49DF6D3F02F9_impl*
 inherited;
 f_Y := aPoint.Y - aMap.Bounds.Top;
//#UC END# *49DF703901BA_49DF6D3F02F9_impl*
end;//TevSolidParaCursor.DoInitPointByPt

procedure TevSolidParaCursor.DoSetEntryPointPrim(Value: Integer;
 const Context: IevCursorContext = nil);
//#UC START# *49E2F8F80062_49DF6D3F02F9_var*
//#UC END# *49E2F8F80062_49DF6D3F02F9_var*
begin
//#UC START# *49E2F8F80062_49DF6D3F02F9_impl*
 if (Value = ev_cpBottom) then
  Value := ev_cpAtEnd;
 inherited DoSetEntryPointPrim(Value, Context);
//#UC END# *49E2F8F80062_49DF6D3F02F9_impl*
end;//TevSolidParaCursor.DoSetEntryPointPrim

function TevSolidParaCursor.GetAtEnd(const aView: InevView): Boolean;
//#UC START# *49E34DFB0259_49DF6D3F02F9_var*
var
 l_Map : TnevFormatInfoPrim;
//#UC END# *49E34DFB0259_49DF6D3F02F9_var*
begin
//#UC START# *49E34DFB0259_49DF6D3F02F9_impl*
 if (Position = ev_cpAtEnd) then
  Result := true
 else
 begin
  l_Map := ObjMap(aView);
  Result := (l_Map <> nil) and (f_Y >= l_Map.Height - nev.LineScrollDelta.Y);
 end;//Position = ev_cpAtEnd
//#UC END# *49E34DFB0259_49DF6D3F02F9_impl*
end;//TevSolidParaCursor.GetAtEnd

function TevSolidParaCursor.GetVertPosition(const aView: InevView;
 aMap: TnevFormatInfoPrim): TnevParaIndex;
//#UC START# *49E34EDF0207_49DF6D3F02F9_var*
//#UC END# *49E34EDF0207_49DF6D3F02F9_var*
begin
//#UC START# *49E34EDF0207_49DF6D3F02F9_impl*
 Result := f_Y div nev.LineScrollDelta.Y;
//#UC END# *49E34EDF0207_49DF6D3F02F9_impl*
end;//TevSolidParaCursor.GetVertPosition

function TevSolidParaCursor.DoDiff(const aView: InevView;
 const aPoint: InevBasePoint;
 aMap: TnevFormatInfoPrim): Integer;
//#UC START# *4AA785540310_49DF6D3F02F9_var*
//#UC END# *4AA785540310_49DF6D3F02F9_var*
begin
//#UC START# *4AA785540310_49DF6D3F02F9_impl*
 Result := inherited DoDiff(aView, aPoint, aMap);
 if (Result <> 0) and aPoint.AtEnd(aView) and GetAtEnd(aView) then // http://mdp.garant.ru/pages/viewpage.action?pageId=382406560
  Result := 0;
//#UC END# *4AA785540310_49DF6D3F02F9_impl*
end;//TevSolidParaCursor.DoDiff
{$IfEnd} // Defined(evUseVisibleCursors)

end.
