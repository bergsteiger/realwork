unit evDocumentMarkers;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evDocumentMarkers.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::ParaList Cursors::evDocumentMarkers
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evUseVisibleCursors)}
uses
  evMarker,
  nevBase
  ;

type
 TevDocumentRightMarginMarker = class(TevMarker)
 protected
 // overridden protected methods
   function DoGetValue: Integer; override;
   procedure DoSetValue(aValue: Integer;
     const Context: InevOp); override;
 end;//TevDocumentRightMarginMarker
{$IfEnd} //evUseVisibleCursors

implementation

{$If defined(evUseVisibleCursors)}
uses
  k2Tags,
  evConst
  ;

// start class TevDocumentRightMarginMarker

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
{$IfEnd} //evUseVisibleCursors

end.