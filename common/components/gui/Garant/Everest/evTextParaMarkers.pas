unit evTextParaMarkers;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evTextParaMarkers.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::Cursors::evTextParaMarkers
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
 TevTextParaRightIndentMarker = class(TevMarker)
 protected
 // overridden protected methods
   procedure SetClientValue(aValue: Integer;
     const aContext: InevOp); override;
   function DoGetClientValue: Integer; override;
   procedure DoSetValue(aValue: Integer;
     const Context: InevOp); override;
 end;//TevTextParaRightIndentMarker
{$IfEnd} //evUseVisibleCursors

implementation

{$If defined(evUseVisibleCursors)}
uses
  k2Tags,
  evConst,
  l3Units,
  evdTypes
  ;

// start class TevTextParaRightIndentMarker

procedure TevTextParaRightIndentMarker.SetClientValue(aValue: Integer;
  const aContext: InevOp);
//#UC START# *4E3A3F0D0388_4A3911D80203_var*
var
 l_OldValue : LongInt;
 l_Delta    : LongInt;
//#UC END# *4E3A3F0D0388_4A3911D80203_var*
begin
//#UC START# *4E3A3F0D0388_4A3911D80203_impl*
 l_OldValue := Self.ClientValue;
 if (l_OldValue <> aValue) then
 begin
  with Para do
  begin
   l_Delta := l_OldValue + IntA[k2_tiRightIndent] - aValue;
   IntW[k2_tiRightIndent, aContext] := l_Delta;
  end; // with Para do
 end; // l_OldValue <> aValue
//#UC END# *4E3A3F0D0388_4A3911D80203_impl*
end;//TevTextParaRightIndentMarker.SetClientValue

function TevTextParaRightIndentMarker.DoGetClientValue: Integer;
//#UC START# *4E3A4C4B03A0_4A3911D80203_var*
var
 l_FI : TnevFormatInfoPrim;
//#UC END# *4E3A4C4B03A0_4A3911D80203_var*
begin
//#UC START# *4E3A4C4B03A0_4A3911D80203_impl*
 with Para do
 begin
  if (IntA[k2_tiJustification] = Ord(ev_itPreformatted)) then
   Result := evShapeNil
  else
  begin
   l_FI := View.FormatInfoByPara(Para);
   if (l_FI <> nil) then
    Result := l_FI.Width
   else
    Result := 0;
  end;//IntA[k2_tiJustification] = Ord(ev_itPreformatted)
 end;//with Para
//#UC END# *4E3A4C4B03A0_4A3911D80203_impl*
end;//TevTextParaRightIndentMarker.DoGetClientValue

procedure TevTextParaRightIndentMarker.DoSetValue(aValue: Integer;
  const Context: InevOp);
//#UC START# *4ED31DEA0077_4A3911D80203_var*
//#UC END# *4ED31DEA0077_4A3911D80203_var*
begin
//#UC START# *4ED31DEA0077_4A3911D80203_impl*
 if (Self.Value <> aValue) then
 begin
  SetClientValue(View.FormatInfoByPara(ParaInst).ParentToClient(l3PointX(aValue)).X, Context);
  ParaInst.Invalidate([nev_spExtent]);
 end;//Self.Value <> aValue
//#UC END# *4ED31DEA0077_4A3911D80203_impl*
end;//TevTextParaRightIndentMarker.DoSetValue
{$IfEnd} //evUseVisibleCursors

end.