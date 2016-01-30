{$IfNDef nevSolidParaAnchorModify_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\nevSolidParaAnchorModify.imp.pas"
// Стереотип: "Impurity"

{$Define nevSolidParaAnchorModify_imp}

{$If Defined(evUseVisibleCursors)}
 _nevSolidParaAnchorModify_ = class(_nevSolidParaAnchorModify_Parent_)
  protected
   function GetY: Integer; virtual; abstract;
   procedure SetY(aValue: Integer); virtual; abstract;
   procedure DoBottom(const aView: InevView); override;
   function DoIncLinePrim(const aView: InevView;
    var theLine: Integer;
    aSmall: Boolean): Integer; override;
 end;//_nevSolidParaAnchorModify_

{$Else Defined(evUseVisibleCursors)}

_nevSolidParaAnchorModify_ = _nevSolidParaAnchorModify_Parent_;

{$IfEnd} // Defined(evUseVisibleCursors)
{$Else nevSolidParaAnchorModify_imp}

{$IfNDef nevSolidParaAnchorModify_imp_impl}

{$Define nevSolidParaAnchorModify_imp_impl}

{$If Defined(evUseVisibleCursors)}
procedure _nevSolidParaAnchorModify_.DoBottom(const aView: InevView);
//#UC START# *4B1CFD7B0332_4B1CFCE401D3_var*
var
 l_Map : TnevFormatInfoPrim;
//#UC END# *4B1CFD7B0332_4B1CFCE401D3_var*
begin
//#UC START# *4B1CFD7B0332_4B1CFCE401D3_impl*
 LockScroll;
 try
  l_Map := aView.FormatInfoByPoint(Self);
  if Assigned(l_Map) then
   // - посмотреть law, cq: oit500022191.
   SetY(l_Map.Height);
 finally
  UnlockScroll;
 end;//try..finally
//#UC END# *4B1CFD7B0332_4B1CFCE401D3_impl*
end;//_nevSolidParaAnchorModify_.DoBottom

function _nevSolidParaAnchorModify_.DoIncLinePrim(const aView: InevView;
 var theLine: Integer;
 aSmall: Boolean): Integer;
//#UC START# *4B1CFD9401A2_4B1CFCE401D3_var*
var
 l_D   : Integer;
 l_Y   : Integer;
 l_Map : TnevFormatInfoPrim;
//#UC END# *4B1CFD9401A2_4B1CFCE401D3_var*
begin
//#UC START# *4B1CFD9401A2_4B1CFCE401D3_impl*
 Result := 0;
 if (theLine = 0) OR not aSmall then
  Exit;
 LockScroll;
 try
  l_Y := GetY;
  l_D := nev.LineScrollDelta.Y;
  l_Map := aView.FormatInfoByPoint(Self);
  if Assigned(l_Map) then
  // - посмотреть law, cq: OIT500022191.
  begin
   SetY(Max(0, Min(GetY + theLine * l_D, l_Map.Height)));
   theLine := theLine - ((GetY - l_Y) div l_D);
   SignalScroll;
  end;
 finally
  UnlockScroll;
 end;//try..finally
//#UC END# *4B1CFD9401A2_4B1CFCE401D3_impl*
end;//_nevSolidParaAnchorModify_.DoIncLinePrim
{$IfEnd} // Defined(evUseVisibleCursors)

{$EndIf nevSolidParaAnchorModify_imp_impl}

{$EndIf nevSolidParaAnchorModify_imp}

