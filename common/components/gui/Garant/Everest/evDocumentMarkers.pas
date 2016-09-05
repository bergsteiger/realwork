unit evDocumentMarkers;

// Модуль: "w:\common\components\gui\Garant\Everest\evDocumentMarkers.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evDocumentMarkers" MUID: (4A4C8FC00259)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evMarker
 , nevBase
;

type
 TevDocumentRightMarginMarker = class(TevMarker)
  protected
   function DoGetValue: Integer; override;
   procedure DoSetValue(aValue: Integer;
    const Context: InevOp); override;
 end;//TevDocumentRightMarginMarker
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , k2Tags
 , evConst
 //#UC START# *4A4C8FC00259impl_uses*
 //#UC END# *4A4C8FC00259impl_uses*
;

function TevDocumentRightMarginMarker.DoGetValue: Integer;
//#UC START# *4ECF8E2C007D_4A4C8FD901F5_var*
//#UC END# *4ECF8E2C007D_4A4C8FD901F5_var*
begin
//#UC START# *4ECF8E2C007D_4A4C8FD901F5_impl*
 Result := 0;
 Inc(Result, Para.AsObject.IntA[k2_tiWidth]);
 Dec(Result, Para.AsObject.IntA[k2_tiRightIndent]);
//#UC END# *4ECF8E2C007D_4A4C8FD901F5_impl*
end;//TevDocumentRightMarginMarker.DoGetValue

procedure TevDocumentRightMarginMarker.DoSetValue(aValue: Integer;
 const Context: InevOp);
//#UC START# *4ED31DEA0077_4A4C8FD901F5_var*
var
 l_OldValue : Integer;
//#UC END# *4ED31DEA0077_4A4C8FD901F5_var*
begin
//#UC START# *4ED31DEA0077_4A4C8FD901F5_impl*
 l_OldValue := Self.Value;
 if (l_OldValue <> Value) then begin
  with Para do
   if (Value <= IntA[k2_tiWidth]) AND
      (Value >= IntA[k2_tiLeftIndent] + 2 * evInchMul) then
    IntW[k2_tiRightIndent, Context] := IntA[k2_tiRightIndent] - (Value - l_OldValue);
 end;{l_OldValue <> Value}
//#UC END# *4ED31DEA0077_4A4C8FD901F5_impl*
end;//TevDocumentRightMarginMarker.DoSetValue
{$IfEnd} // Defined(evUseVisibleCursors)

end.
