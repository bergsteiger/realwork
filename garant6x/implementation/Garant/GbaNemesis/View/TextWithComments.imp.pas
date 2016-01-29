{$IfNDef TextWithComments_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/TextWithComments.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Base Operations::View::Base Forms::TextWithComments
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define TextWithComments_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _TextWithComments_ = {abstract form} class(_TextWithComments_Parent_)
 protected
 // property methods
   function pm_GetTextWithComments: TevCustomEditorWindow; virtual; abstract;
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 protected
 // protected methods
   procedure TextSourceGetControlItemImg(aSender: TObject;
     const aControl: TnevControlInfo;
     out theImageInfo: TnevControlImageInfo);
     {* Возвращает иконку для контрола (комментария) }
 protected
 // protected properties
   property TextWithComments: TevCustomEditorWindow
     read pm_GetTextWithComments;
     {* Текст, содержащий комментарии }
 end;//_TextWithComments_
{$Else}

 _TextWithComments_ = _TextWithComments_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else TextWithComments_imp}

{$If not defined(Admin) AND not defined(Monitorings)}

// start class _TextWithComments_

procedure _TextWithComments_.TextSourceGetControlItemImg(aSender: TObject;
  const aControl: TnevControlInfo;
  out theImageInfo: TnevControlImageInfo);
//#UC START# *4A8AACD503DC_4A8AACAE0356_var*
//#UC END# *4A8AACD503DC_4A8AACAE0356_var*
begin
//#UC START# *4A8AACD503DC_4A8AACAE0356_impl*
 if (aControl.rControl <> nil) then
 begin
  theImageInfo.rImageList := vtMakeImageListWrapper(nsDocumentRes.CommentsImageList);
  if aControl.rControl.AsObject.IsKindOf(k2_typBitmapPara) then
  begin
   if (aControl.rFormatInfo <> nil) AND
      (aControl.rFormatInfo.ParentInfo <> nil) AND
      (aControl.rFormatInfo.ParentInfo.ParentInfo <> nil) then
   begin
    if aControl.rMetrics.IsTagCollapsed(aControl.rFormatInfo.ParentInfo.ParentInfo.Obj.AsObject) then
     theImageInfo.rFirstIndex := 3
    else
     theImageInfo.rFirstIndex := 2;
   end;//aControl.rFormatInfo <> nil
  end//aControl.rControl.IsKindOf(k2_typBitmap)
  else
   Case aControl.rControl.AsObject.IntA[k2_tiStyle] of
    ev_saTxtComment:
     theImageInfo.rFirstIndex := 0;
 (*   ev_saVersionInfo:
    begin
     theImageInfo.rImageList := vtMakeImageListWrapper(nsDocumentRes.DocumentItemsImageList);
     theImageInfo.rFirstIndex := 23{1};
     {$IfDef evNeedCollapsedVersionComments}
     if not aControl.QT(InevPara, l_Para) then
      Assert(false);
     if TextWithComments.View.IsObjectCollapsed[l_Para] then
      theImageInfo.rLastIndex := 3
     else
      theImageInfo.rLastIndex := 2;
     {$EndIf evNeedCollapsedVersionComments}
    end;//ev_saVersionInfo*)
    // - http://mdp.garant.ru/pages/viewpage.action?pageId=269085052
    ev_saChangesInfo:
    begin
     theImageInfo.rImageList := vtMakeImageListWrapper(dmStdRes.SmallImageList);
     theImageInfo.rFirstIndex := 206;
(*     theImageInfo.rImageList := vtMakeImageListWrapper(nsDocumentRes.DocumentItemsImageList);
     theImageInfo.rFirstIndex := 23;*)
     //theImageInfo.rFirstIndex := 1;
     theImageInfo.rLeftIndent := aControl.rControl.AsObject.IntA[k2_tiFirstIndent] div 2;
    end;//ev_saChangesInfo
    else
    begin
     theImageInfo.rImageList := nil;
     theImageInfo.rFirstIndex := -1;
    end;
   end;//Case aControl.rControl.IntA[k2_tiStyle]
 end;//aControl.rControl <> nil
//#UC END# *4A8AACD503DC_4A8AACAE0356_impl*
end;//_TextWithComments_.TextSourceGetControlItemImg

{$If not defined(NoVCM)}
procedure _TextWithComments_.InitControls;
//#UC START# *4A8E8F2E0195_4A8AACAE0356_var*
//#UC END# *4A8E8F2E0195_4A8AACAE0356_var*
begin
//#UC START# *4A8E8F2E0195_4A8AACAE0356_impl*
 inherited;
 with TextWithComments do
 begin
  TextSource.OnGetControlItemImg := Self.TextSourceGetControlItemImg;
 end;//with TextWithComments
//#UC END# *4A8E8F2E0195_4A8AACAE0356_impl*
end;//_TextWithComments_.InitControls
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

{$EndIf TextWithComments_imp}
