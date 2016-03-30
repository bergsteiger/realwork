unit evTabIndentMarker;

// Модуль: "w:\common\components\gui\Garant\Everest\evTabIndentMarker.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevTabIndentMarker" MUID: (4A390E9702B9)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evMarker
 , l3Variant
 , nevTools
 , l3Interfaces
 , nevBase
;

type
 _RoundMarkerValue_Parent_ = TevMarker;
 {$Include w:\common\components\gui\Garant\Everest\RoundMarkerValue.imp.pas}
 TevTabIndentMarker = class(_RoundMarkerValue_)
  private
   f_FirstTabStop: Tl3Variant;
  private
   function CheckDecimapSeparatorType: Boolean;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure SetClientValue(aValue: Integer;
    const aContext: InevOp); override;
   procedure TagChanged(aNew: Tl3Variant); override;
   function DoGetClientValue: Integer; override;
  public
   constructor Create(const aView: InevView;
    aPara: Tl3Variant;
    aTabStopsHolder: Tl3Variant;
    const aHint: Il3CString); reintroduce;
   procedure SetTagQT(aTag: Tl3Variant); override;
 end;//TevTabIndentMarker
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , k2Base
 {$If Defined(k2ForEditor)}
 , evAlignBySeparatorUtils
 {$IfEnd} // Defined(k2ForEditor)
 , k2Tags
 , SysUtils
 {$If Defined(k2ForEditor)}
 , evTableCellUtils
 {$IfEnd} // Defined(k2ForEditor)
;

{$Include w:\common\components\gui\Garant\Everest\RoundMarkerValue.imp.pas}

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
 {* Функция очистки полей объекта. }
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
{$IfEnd} // Defined(evUseVisibleCursors)

end.
