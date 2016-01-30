{$IfNDef HyperlinkProcessorForDocumentCompare_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\HyperlinkProcessorForDocumentCompare.imp.pas"
// Стереотип: "VCMForm"

{$Define HyperlinkProcessorForDocumentCompare_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _HyperlinkProcessorForDocumentCompare_ = {abstract} class(_HyperlinkProcessorForDocumentCompare_Parent_)
  private
   procedure DoGetNonHyperlinkInfo(Sender: TObject;
    const aKeys: TafwCursorState;
    var theInfo: TafwCursorInfo);
    {* Возвращает информацию о стиле сравнения }
  protected
   procedure GetNonHyperlinkInfo(Sender: TObject;
    const aHotSpot: IevHotSpot;
    const aKeys: TafwCursorState;
    var theInfo: TafwCursorInfo); override;
    {* Возвращает информацию о курсоре НЕ НАД ССЫЛКОЙ }
 end;//_HyperlinkProcessorForDocumentCompare_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_HyperlinkProcessorForDocumentCompare_ = _HyperlinkProcessorForDocumentCompare_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else HyperlinkProcessorForDocumentCompare_imp}

{$IfNDef HyperlinkProcessorForDocumentCompare_imp_impl}

{$Define HyperlinkProcessorForDocumentCompare_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
procedure _HyperlinkProcessorForDocumentCompare_.DoGetNonHyperlinkInfo(Sender: TObject;
 const aKeys: TafwCursorState;
 var theInfo: TafwCursorInfo);
 {* Возвращает информацию о стиле сравнения }
//#UC START# *4A8912820378_4E9C33A802C8_var*
//#UC END# *4A8912820378_4E9C33A802C8_var*
begin
//#UC START# *4A8912820378_4E9C33A802C8_impl*
 if (Sender As TevCustomEditorWindow).GetPtPoint(aKeys.rPoint, l_Point) then
  with l_Point.MostInner, Obj^ do
   if AsObject.IsKindOf(k2_typStyledLeafPara) then
   begin
    l_Tag := evSegments_GetSegmentOnPos(AsObject.Attr[k2_tiSegments], ev_slDiff, Position, l_Pos);
    if l_Tag.IsValid then
    begin
     with theInfo do
     begin
      //rCursor := ev_csHelp;
      rHint := l3CStr(l_Tag.PCharLenA[k2_tiStyle]);
      l3Split(rHint, '.', l_P, l_S);
      if not l3IsNil(l_S) then
       rHint := l_S;
      if afw.Application.IsInternal then
       rHint := l3Cat(rHint, ' ParaID = ' + IntToStr(AsObject.IntA[k2_tiHandle]));
     end;//with theInfo
    end//l_Tag.IsValid
    else
    begin
     if afw.Application.IsInternal then
      with theInfo do
       rHint := l3Cat(rHint, ' ParaID = ' + IntToStr(AsObject.IntA[k2_tiHandle]));
    end;//l_Tag.IsValid
   end;//IsKindOf(k2_typStyledLeafPara)
//#UC END# *4A8912820378_4E9C33A802C8_impl*
end;//_HyperlinkProcessorForDocumentCompare_.DoGetNonHyperlinkInfo

procedure _HyperlinkProcessorForDocumentCompare_.GetNonHyperlinkInfo(Sender: TObject;
 const aHotSpot: IevHotSpot;
 const aKeys: TafwCursorState;
 var theInfo: TafwCursorInfo);
 {* Возвращает информацию о курсоре НЕ НАД ССЫЛКОЙ }
//#UC START# *4A890E81030B_4E9C33A802C8_var*
//#UC END# *4A890E81030B_4E9C33A802C8_var*
begin
//#UC START# *4A890E81030B_4E9C33A802C8_impl*
 DoGetNonHyperlinkInfo(Sender, aKeys, theInfo);
//#UC END# *4A890E81030B_4E9C33A802C8_impl*
end;//_HyperlinkProcessorForDocumentCompare_.GetNonHyperlinkInfo
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf HyperlinkProcessorForDocumentCompare_imp_impl}

{$EndIf HyperlinkProcessorForDocumentCompare_imp}

