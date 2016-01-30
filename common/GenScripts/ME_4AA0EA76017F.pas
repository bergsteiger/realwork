unit LiteSearch_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\LiteSearch_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , nsTypes
 , l3Interfaces
 , SearchInterfaces
 , PrimTreeAttributeSelectOptions_Form
 , SearchLite_FormDefinitions_Controls
 , PrimAttributeSelectOptions_Form
 , PrimSelectedAttributesOptions_Form
;

type
 TefTreeAttributeSelect = {final} class(TPrimTreeAttributeSelectOptionsForm, TreeAttributeSelectFormDef)
  {* Выбор значений древовидного атрибута }
 end;//TefTreeAttributeSelect

 TcfAttributeSelect = {final} class(TPrimAttributeSelectOptionsForm, AttributeSelectFormDef)
 end;//TcfAttributeSelect

 TenSelectedAttributes = {final} class(TPrimSelectedAttributesOptionsForm, SelectedAttributesFormDef)
 end;//TenSelectedAttributes

 TLiteSearchModule = class
  public
   procedure MakeTreeAttributeSelect(const aParams: IvcmMakeParams;
    aZoneType: TvcmZoneType;
    aRecursive: Boolean;
    aUserType: TvcmUserType);
   procedure MakeAttributeSelect(const aParams: IvcmMakeParams;
    aZoneType: TvcmZoneType;
    aRecursive: Boolean;
    aUserType: TvcmUserType);
   procedure MakeSelectedAttributes(const aParams: IvcmMakeParams;
    aZoneType: TvcmZoneType;
    aRecursive: Boolean);
   function OpenTreeSelection(const aTag: Il3CString;
    anAdditionalFilter: TnsFilterType;
    const aFormData: IdsTreeAttributeSelect): Integer;
 end;//TLiteSearchModule

implementation

uses
 l3ImplUses
 , SearchLite_Strange_Controls
 , PrimAttributeSelect_utAttributeSelect_UserType
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TreeAttributeSelectKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , l3String
 {$If NOT Defined(NoScripts)}
 , AttributeSelectKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , SelectedAttributesKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TLiteSearchModule.MakeTreeAttributeSelect(const aParams: IvcmMakeParams;
 aZoneType: TvcmZoneType;
 aRecursive: Boolean;
 aUserType: TvcmUserType);
//#UC START# *4AAF48F502E7_4AA0EA76017F_var*
//#UC END# *4AAF48F502E7_4AA0EA76017F_var*
begin
//#UC START# *4AAF48F502E7_4AA0EA76017F_impl*
 Assert(aRecursive);
 Result := TTreeAttributeSelectForm.MakeSingleChild(aParams.Container,
                                             aParams,
                                             aZoneType,
                                             aUserType);
//#UC END# *4AAF48F502E7_4AA0EA76017F_impl*
end;//TLiteSearchModule.MakeTreeAttributeSelect

procedure TLiteSearchModule.MakeAttributeSelect(const aParams: IvcmMakeParams;
 aZoneType: TvcmZoneType;
 aRecursive: Boolean;
 aUserType: TvcmUserType);
//#UC START# *4AAF4FC80387_4AA0EA76017F_var*
//#UC END# *4AAF4FC80387_4AA0EA76017F_var*
begin
//#UC START# *4AAF4FC80387_4AA0EA76017F_impl*
 Assert(aRecursive);
 Result := TcfAttributeSelect.MakeSingleChild(aParams.Container,
                                             aParams,
                                             aZoneType,
                                             aUserType);
//#UC END# *4AAF4FC80387_4AA0EA76017F_impl*
end;//TLiteSearchModule.MakeAttributeSelect

procedure TLiteSearchModule.MakeSelectedAttributes(const aParams: IvcmMakeParams;
 aZoneType: TvcmZoneType;
 aRecursive: Boolean);
//#UC START# *4AAF52280022_4AA0EA76017F_var*
//#UC END# *4AAF52280022_4AA0EA76017F_var*
begin
//#UC START# *4AAF52280022_4AA0EA76017F_impl*
 Assert(aRecursive);
 Result := TenSelectedAttributes.MakeSingleChild(aParams.Container,
                                             aParams,
                                             aZoneType,
                                             0);
//#UC END# *4AAF52280022_4AA0EA76017F_impl*
end;//TLiteSearchModule.MakeSelectedAttributes

function TLiteSearchModule.OpenTreeSelection(const aTag: Il3CString;
 anAdditionalFilter: TnsFilterType;
 const aFormData: IdsTreeAttributeSelect): Integer;
//#UC START# *4AAF590401AC_4AA0EA76017F_var*
//#UC END# *4AAF590401AC_4AA0EA76017F_var*
begin
//#UC START# *4AAF590401AC_4AA0EA76017F_impl*
 vcmDispatcher.FormDispatcher.Lock;
 try
  l_Params := vcmCheckAggregate(vcmMakeParams);

  l_Container := TcfAttributeSelect.Make(l_Params, vcm_ztManualModal,
                                         TvcmUserType(utAttributeSelect));
  l_Params := vcmMakeParams(l_Params.Aggregate,
                        l_Container.AsContainer,
                        l_Params.Owner);
  l_Form := TTreeAttributeSelectForm.Make(l_Params);
  l_FilterType := anAdditionalFilter;
  {$IfDef Admin}
  Assert(l_FilterType = ns_ftNone);
  l_FilterType := ns_ftInpharm;
  l_Form.DataSource := aFormData;
  {$Else  Admin}
  Assert(aFormData = nil);
  {$EndIf Admin}
  TenSelectedAttributes.Make(l_Params);

  Assert(l_Params.Aggregate <> nil);

  op_AttributeTree_SetRoot.Call(l_Params.Aggregate, aTag);

  Op_Context_SyncContextParams.Call(l_Params.Aggregate, l_FilterType);

 finally
  vcmDispatcher.FormDispatcher.UnLock;
 end;//try..finally

 Result := l_Container.ShowModal;

 // 15.09.2004 fireton
 // Убрано, т.к. порождало проблемы возврата фокуса при выходе из модального
 // состояния. И вообще.
 // afw.ProcessMessages;

 l_Container := nil;
//#UC END# *4AAF590401AC_4AA0EA76017F_impl*
end;//TLiteSearchModule.OpenTreeSelection

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefTreeAttributeSelect);
 {* Регистрация TreeAttributeSelect }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efTreeAttributeSelect.SetFactory(TefTreeAttributeSelect.Make);
 {* Регистрация фабрики формы TreeAttributeSelect }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TcfAttributeSelect);
 {* Регистрация AttributeSelect }
{$IfEnd} // NOT Defined(NoScripts)
 fm_cfAttributeSelect.SetFactory(TcfAttributeSelect.Make);
 {* Регистрация фабрики формы AttributeSelect }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TenSelectedAttributes);
 {* Регистрация SelectedAttributes }
{$IfEnd} // NOT Defined(NoScripts)
 fm_enSelectedAttributes.SetFactory(TenSelectedAttributes.Make);
 {* Регистрация фабрики формы SelectedAttributes }

end.
