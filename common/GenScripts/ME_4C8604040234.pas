unit PrimSynchroViewOptions_Form;
 {* Синхронный просмотр }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimSynchroViewOptions_Form.pas"
// Стереотип: "VCMContainer"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimSynchroView_Form
 , Document_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , bsTypes
 , l3Interfaces
;

type
 TPrimSynchroViewOptionsForm = class(TPrimSynchroViewForm)
  {* Синхронный просмотр }
  protected
   procedure MakeUserCRListCaption(const aParams: IvcmTestParamsPrim;
    aId: TnsUserCRListId);
   {$If NOT Defined(NoVCM)}
   procedure PageActive; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PageInactive; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure ShowText; override;
   procedure Annotation; override;
   procedure ShowAttributes; override;
   procedure ShowRelated; override;
   procedure ShowUserCRList1; override;
   procedure ShowUserCRList2; override;
   procedure SimilarDocuments; override;
   {$If NOT Defined(NoVCM)}
   function DoGetTabInfo(out theCaption: Il3CString;
    out theItemIndex: Integer): Boolean; override;
    {* Информация о закладке, в которую вставляется форма. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimSynchroViewOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , afwFacade
 , Base_Operations_Strange_Controls
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
;

procedure TPrimSynchroViewOptionsForm.MakeUserCRListCaption(const aParams: IvcmTestParamsPrim;
 aId: TnsUserCRListId);
//#UC START# *4C860B4801E9_4C8604040234_var*
//#UC END# *4C860B4801E9_4C8604040234_var*
begin
//#UC START# *4C860B4801E9_4C8604040234_impl*
 with ViewArea.UserCRListInfo[aId] do
 begin
  case KindOfList of
   bs_ulUserCR:
    aParams.Op.Caption := ViewArea.UserCRListInfo[aId].Caption;
  end;//case ViewArea.UserCRListInfo[aId].KindOfList of
  case ListType of
   crtCorrespondents:
   begin
    aParams.Op.ImageIndex := StdRes.cCorrespondents;
    if KindOfList = bs_ulFullCR then
     aParams.Op.Caption := vcmCStr(vcmConstString(str_Correspondents));
   end;//crtCorrespondents
   crtRespondents:
   begin
    aParams.Op.ImageIndex := StdRes.cRespondents;
    if KindOfList = bs_ulFullCR then
     aParams.Op.Caption := vcmCStr(vcmConstString(str_Respondents));
   end;//crtRespondents
  end;//case ListType of
  aParams.Op.Hint:= aParams.Op.Caption;
 end;//with ViewArea.UserCRListInfo[aId] do
//#UC END# *4C860B4801E9_4C8604040234_impl*
end;//TPrimSynchroViewOptionsForm.MakeUserCRListCaption

procedure TPrimSynchroViewOptionsForm.ShowText;
//#UC START# *4C86050B01DB_4C8604040234_var*
//#UC END# *4C86050B01DB_4C8604040234_var*
begin
//#UC START# *4C86050B01DB_4C8604040234_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C86050B01DB_4C8604040234_impl*
end;//TPrimSynchroViewOptionsForm.ShowText

procedure TPrimSynchroViewOptionsForm.Annotation;
//#UC START# *4C860527005A_4C8604040234_var*
//#UC END# *4C860527005A_4C8604040234_var*
begin
//#UC START# *4C860527005A_4C8604040234_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C860527005A_4C8604040234_impl*
end;//TPrimSynchroViewOptionsForm.Annotation

procedure TPrimSynchroViewOptionsForm.ShowAttributes;
//#UC START# *4C8605460347_4C8604040234_var*
//#UC END# *4C8605460347_4C8604040234_var*
begin
//#UC START# *4C8605460347_4C8604040234_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8605460347_4C8604040234_impl*
end;//TPrimSynchroViewOptionsForm.ShowAttributes

procedure TPrimSynchroViewOptionsForm.ShowRelated;
//#UC START# *4C86056702CB_4C8604040234_var*
//#UC END# *4C86056702CB_4C8604040234_var*
begin
//#UC START# *4C86056702CB_4C8604040234_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C86056702CB_4C8604040234_impl*
end;//TPrimSynchroViewOptionsForm.ShowRelated

procedure TPrimSynchroViewOptionsForm.ShowUserCRList1;
//#UC START# *4C8605850067_4C8604040234_var*
//#UC END# *4C8605850067_4C8604040234_var*
begin
//#UC START# *4C8605850067_4C8604040234_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8605850067_4C8604040234_impl*
end;//TPrimSynchroViewOptionsForm.ShowUserCRList1

procedure TPrimSynchroViewOptionsForm.ShowUserCRList2;
//#UC START# *4C8605A2018B_4C8604040234_var*
//#UC END# *4C8605A2018B_4C8604040234_var*
begin
//#UC START# *4C8605A2018B_4C8604040234_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8605A2018B_4C8604040234_impl*
end;//TPrimSynchroViewOptionsForm.ShowUserCRList2

procedure TPrimSynchroViewOptionsForm.SimilarDocuments;
//#UC START# *4C8605BF03B0_4C8604040234_var*
//#UC END# *4C8605BF03B0_4C8604040234_var*
begin
//#UC START# *4C8605BF03B0_4C8604040234_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8605BF03B0_4C8604040234_impl*
end;//TPrimSynchroViewOptionsForm.SimilarDocuments

{$If NOT Defined(NoVCM)}
function TPrimSynchroViewOptionsForm.DoGetTabInfo(out theCaption: Il3CString;
 out theItemIndex: Integer): Boolean;
 {* Информация о закладке, в которую вставляется форма. Для перекрытия в потомках }
//#UC START# *4AC497FD00A2_4C8604040234_var*
//#UC END# *4AC497FD00A2_4C8604040234_var*
begin
//#UC START# *4AC497FD00A2_4C8604040234_impl*
 if (CurUserType <> nil) then
 begin
  Result := true;
  theCaption := CCaption;
  theItemIndex := CurUserType.ImageIndex;
 end//CurUserType <> nil
 else
  Result := false;
//#UC END# *4AC497FD00A2_4C8604040234_impl*
end;//TPrimSynchroViewOptionsForm.DoGetTabInfo
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimSynchroViewOptionsForm.PageActive;
//#UC START# *4C52E8030278_4C8604040234_var*
//#UC END# *4C52E8030278_4C8604040234_var*
begin
//#UC START# *4C52E8030278_4C8604040234_impl*
 op_List_SetCurrentVisible.Call(Aggregate);
//#UC END# *4C52E8030278_4C8604040234_impl*
end;//TPrimSynchroViewOptionsForm.PageActive
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimSynchroViewOptionsForm.PageInactive;
//#UC START# *4C52E81603A9_4C8604040234_var*
//#UC END# *4C52E81603A9_4C8604040234_var*
begin
//#UC START# *4C52E81603A9_4C8604040234_impl*
 // - ничего не делаем
//#UC END# *4C52E81603A9_4C8604040234_impl*
end;//TPrimSynchroViewOptionsForm.PageInactive
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimSynchroViewOptionsForm);
 {* Регистрация PrimSynchroViewOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
