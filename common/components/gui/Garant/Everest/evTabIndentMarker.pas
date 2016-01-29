unit evTabIndentMarker;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Инишев Д.А.
// Модуль: "w:/common/components/gui/Garant/Everest/evTabIndentMarker.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Cursors::TevTabIndentMarker
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
  l3Interfaces,
  nevTools,
  evMarker,
  l3Variant,
  nevBase
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}
type
 _RoundMarkerValue_Parent_ = TevMarker;
 {$Include ..\Everest\RoundMarkerValue.imp.pas}
 TevTabIndentMarker = class(_RoundMarkerValue_)
 private
 // private fields
   f_FirstTabStop : Tl3Variant;
 private
 // private methods
   function CheckDecimapSeparatorType: Boolean;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure SetClientValue(aValue: Integer;
     const aContext: InevOp); override;
   procedure TagChanged(aNew: Tl3Variant); override;
   function DoGetClientValue: Integer; override;
 public
 // overridden public methods
   procedure SetTagQT(aTag: Tl3Variant); override;
 public
 // public methods
   constructor Create(const aView: InevView;
     aPara: Tl3Variant;
     aTabStopsHolder: Tl3Variant;
     const aHint: Il3CString); reintroduce;
 end;//TevTabIndentMarker
{$IfEnd} //evUseVisibleCursors

implementation

{$If defined(evUseVisibleCursors)}
uses
  k2Base
  {$If defined(k2ForEditor)}
  ,
  evAlignBySeparatorUtils
  {$IfEnd} //k2ForEditor
  ,
  k2Tags,
  SysUtils
  {$If defined(k2ForEditor)}
  ,
  evTableCellUtils
  {$IfEnd} //k2ForEditor
  
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}

{$Include ..\Everest\RoundMarkerValue.imp.pas}

// start class TevTabIndentMarker

function TevTabIndentMarker.CheckDecimapSeparatorType: Boolean;
//#UC START# *4E3A3E3802A5_4A390E9702B9_var*
//#UC END# *4E3A3E3802A5_4A390E9702B9_var*
begin
//#UC START# *4E3A3E3802A5_4A390E9702B9_impl*
 Result := Tl3TabStopStyle(f_FirstTabStop.IntA[k2_tiType]) = l3_tssDecimal
//#UC END# *4E3A3E3802A5_4A390E9702B9_impl*
end;//TevTabIndentMarker.CheckDecimapSeparatorType

constructor TevTabIndentMarker.Create(const aView: InevView;
  aPara: Tl3Variant;
  aTabStopsHolder: Tl3Variant;
  const aHint: Il3CString);
//#UC START# *4E3A3E650335_4A390E9702B9_var*
//#UC END# *4E3A3E650335_4A390E9702B9_var*
begin
//#UC START# *4E3A3E650335_4A390E9702B9_impl*
 aTabStopsHolder.SetRef(f_FirstTabStop);
 inherited Create(aView, aPara, k2_tiStart, ev_pmsTabIndent, aHint);
 HitType := Tk2Prop(Tk2Type(f_FirstTabStop.TagType).Prop[k2_tiStart]);
//#UC END# *4E3A3E650335_4A390E9702B9_impl*
end;//TevTabIndentMarker.Create

procedure TevTabIndentMarker.Cleanup;
//#UC START# *479731C50290_4A390E9702B9_var*
//#UC END# *479731C50290_4A390E9702B9_var*
begin
//#UC START# *479731C50290_4A390E9702B9_impl*
 FreeAndNil(f_FirstTabStop);
 inherited;
//#UC END# *479731C50290_4A390E9702B9_impl*
end;//TevTabIndentMarker.Cleanup

procedure TevTabIndentMarker.SetTagQT(aTag: Tl3Variant);
//#UC START# *49E75FA4010C_4A390E9702B9_var*
var
 l_TabStops: Tl3Variant;
//#UC END# *49E75FA4010C_4A390E9702B9_var*
begin
//#UC START# *49E75FA4010C_4A390E9702B9_impl*
 inherited SetTagQT(aTag);
 if aTag <> nil then
 begin
  l_TabStops := aTag.Attr[k2_tiTabStops];
  l_TabStops.Child[0].SetRef(f_FirstTabStop);
  HitType := Tk2Prop(Tk2Type(f_FirstTabStop.TagType).Prop[k2_tiStart]);
 end; // if aTag <> nil then
//#UC END# *49E75FA4010C_4A390E9702B9_impl*
end;//TevTabIndentMarker.SetTagQT

procedure TevTabIndentMarker.SetClientValue(aValue: Integer;
  const aContext: InevOp);
//#UC START# *4E3A3F0D0388_4A390E9702B9_var*
var
 l_Delta : Integer;
 l_Width : Integer;
 l_Offset: Integer;
//#UC END# *4E3A3F0D0388_4A390E9702B9_var*
begin
//#UC START# *4E3A3F0D0388_4A390E9702B9_impl*
 if CheckDecimapSeparatorType then
 begin
  //CheckProcessor(aContext);
  l_Width := ParaInst.OwnerTag.IntA[k2_tiWidth];
  if (aValue > 0) and (aValue < l_Width) then
  begin
   l_Offset := ClientValue;
   l_Delta := CalcDelta(aValue, ClientValue);
   Inc(l_Offset, l_Delta);
   f_FirstTabStop.IntW[k2_tiStart, aContext] := l_Offset;
   aContext.MarkModified(f_FirstTabStop);
   ParaInst.Invalidate([nev_spExtent]);
  end;//if (aValue > 0) and (aValue < l_Width) then
 end;//if CheckDecimapSeparatorType then
//#UC END# *4E3A3F0D0388_4A390E9702B9_impl*
end;//TevTabIndentMarker.SetClientValue

procedure TevTabIndentMarker.TagChanged(aNew: Tl3Variant);
//#UC START# *4E3A40FC010F_4A390E9702B9_var*
var
 l_TabStop : Tl3Variant;
//#UC END# *4E3A40FC010F_4A390E9702B9_var*
begin
//#UC START# *4E3A40FC010F_4A390E9702B9_impl*
 inherited;
 if (aNew <> nil) then
 begin
  if (HitType <> nil) then
   HitType := Tk2Prop(Tk2Type(f_FirstTabStop.TagType).Prop[k2_tiStart]);
  if evGetDecimalTabIndentTag(aNew, l_TabStop) then
   l_TabStop.SetRef(f_FirstTabStop);
 end;//aNew <> nil
//#UC END# *4E3A40FC010F_4A390E9702B9_impl*
end;//TevTabIndentMarker.TagChanged

function TevTabIndentMarker.DoGetClientValue: Integer;
//#UC START# *4E3A4C4B03A0_4A390E9702B9_var*
//#UC END# *4E3A4C4B03A0_4A390E9702B9_var*
begin
//#UC START# *4E3A4C4B03A0_4A390E9702B9_impl*
 Result := f_FirstTabStop.IntA[k2_tiStart]
//#UC END# *4E3A4C4B03A0_4A390E9702B9_impl*
end;//TevTabIndentMarker.DoGetClientValue

{$IfEnd} //evUseVisibleCursors

end.