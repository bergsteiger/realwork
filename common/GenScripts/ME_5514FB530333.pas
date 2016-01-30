{$IfNDef evCollapsedStylePainter_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\evCollapsedStylePainter.imp.pas"
// Стереотип: "Impurity"

{$Define evCollapsedStylePainter_imp}

{$If Defined(evNeedPainters)}
 _evCollapsedStylePainter_ = class(_evCollapsedStylePainter_Parent_)
  protected
   procedure DoDoDrawFrameText(aTop: Boolean;
    aSpace: Integer;
    aFirstIndent: Integer);
 end;//_evCollapsedStylePainter_

{$Else Defined(evNeedPainters)}

_evCollapsedStylePainter_ = _evCollapsedStylePainter_Parent_;

{$IfEnd} // Defined(evNeedPainters)
{$Else evCollapsedStylePainter_imp}

{$IfNDef evCollapsedStylePainter_imp_impl}

{$Define evCollapsedStylePainter_imp_impl}

{$If Defined(evNeedPainters)}
procedure _evCollapsedStylePainter_.DoDoDrawFrameText(aTop: Boolean;
 aSpace: Integer;
 aFirstIndent: Integer);
//#UC START# *5514FC280243_5514FB530333_var*
var
 l_Style : Tl3Variant;
 l_Text  : Tl3PCharLen;
 l_Decor : Tl3Variant;
 l_DT    : TnevDecorType;
//#UC END# *5514FC280243_5514FB530333_var*
begin
//#UC START# *5514FC280243_5514FB530333_impl*
 if aTop then
  l_DT := nev_dtHeader
 else
  l_DT := nev_dtFooter;
 l_Decor := FormatInfo.DecorObj(l_DT);
 l_Style := ParaX.AsObject.Attr[k2_tiStyle];
 if l_Style.IsValid then
 begin
  l_Text := l_Style.PCharLenA[k2_tiShortName];
  if not l3IsNil(l_Text) then
   InternalDrawFrameText(l_Text, aTop, aSpace, l_DT, l_Decor, aFirstIndent)
  else
  if l_Decor.IsValid then
   InternalDrawFrameText(Tl3PCharLen(cc_EmptyStr), aTop, aSpace, l_DT, l_Decor, aFirstIndent)
 end;//l_Style.IsValid
//#UC END# *5514FC280243_5514FB530333_impl*
end;//_evCollapsedStylePainter_.DoDoDrawFrameText
{$IfEnd} // Defined(evNeedPainters)

{$EndIf evCollapsedStylePainter_imp_impl}

{$EndIf evCollapsedStylePainter_imp}

