{$IfNDef evCollapsedStylePainter_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evCollapsedStylePainter.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::Drawing Framework::evCollapsedStylePainter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define evCollapsedStylePainter_imp}
{$If defined(evNeedPainters)}
 _evCollapsedStylePainter_ = {mixin} class(_evCollapsedStylePainter_Parent_)
 protected
 // protected methods
   procedure DoDoDrawFrameText(aTop: Boolean;
     aSpace: Integer;
     aFirstIndent: Integer);
 end;//_evCollapsedStylePainter_
{$Else}

 _evCollapsedStylePainter_ = _evCollapsedStylePainter_Parent_;

{$IfEnd} //evNeedPainters

{$Else evCollapsedStylePainter_imp}

{$If defined(evNeedPainters)}

// start class _evCollapsedStylePainter_

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

{$IfEnd} //evNeedPainters

{$EndIf evCollapsedStylePainter_imp}
