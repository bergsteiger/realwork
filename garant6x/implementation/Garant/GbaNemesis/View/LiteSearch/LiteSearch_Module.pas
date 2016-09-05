unit LiteSearch_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\LiteSearch_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "LiteSearch" MUID: (4AA0EA76017F)
// Имя типа: "TLiteSearchModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TLiteSearchModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   {$If NOT Defined(NoVCM)}
   class procedure GetEntityForms(aList: TvcmClassList); override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TLiteSearchModule

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmModuleContractImplementation
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchLite_Services
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , nsTypes
 , SearchInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchLite_Strange_Controls
 , PrimAttributeSelect_utAttributeSelect_UserType
 , SysUtils
 , l3Base
 , TreeAttributeSelect_Form
 , AttributeSelect_Form
 , SelectedAttributes_Form
 , SearchLite_FormDefinitions_Controls
 //#UC START# *4AA0EA76017Fimpl_uses*
 //#UC END# *4AA0EA76017Fimpl_uses*
;

{$If NOT Defined(NoVCM)}
type
 TLiteSearchServiceImpl = {final} class(TvcmModuleContractImplementation, ILiteSearchService)
  public
   function OpenTreeSelection(const aTag: Il3CString;
    anAdditionalFilter: TnsFilterType;
    const aFormData: IdsTreeAttributeSelect): Integer;
   function MakeAttributeSelect(const aParams: IvcmMakeParams;
    aZoneType: TvcmZoneType;
    aRecursive: Boolean;
    aUserType: TvcmUserType): IvcmEntityForm;
   function MakeSelectedAttributes(const aParams: IvcmMakeParams;
    aZoneType: TvcmZoneType;
    aRecursive: Boolean): IvcmEntityForm;
   function MakeTreeAttributeSelect(const aParams: IvcmMakeParams;
    aZoneType: TvcmZoneType;
    aRecursive: Boolean;
    aUserType: TvcmUserType): IvcmEntityForm;
   class function Instance: TLiteSearchServiceImpl;
    {* Метод получения экземпляра синглетона TLiteSearchServiceImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TLiteSearchServiceImpl

var g_TLiteSearchServiceImpl: TLiteSearchServiceImpl = nil;
 {* Экземпляр синглетона TLiteSearchServiceImpl }

procedure TLiteSearchServiceImplFree;
 {* Метод освобождения экземпляра синглетона TLiteSearchServiceImpl }
begin
 l3Free(g_TLiteSearchServiceImpl);
end;//TLiteSearchServiceImplFree

function TLiteSearchServiceImpl.OpenTreeSelection(const aTag: Il3CString;
 anAdditionalFilter: TnsFilterType;
 const aFormData: IdsTreeAttributeSelect): Integer;
var
 __WasEnter : Boolean;
//#UC START# *4AAF590401AC_4AA0EA76017F_var*
var
 l_Params : IvcmMakeParams;
 l_Container : IvcmEntityForm;
 l_Form : IvcmEntityForm;
 l_FilterType : TnsFilterType;
//#UC END# *4AAF590401AC_4AA0EA76017F_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AAF590401AC_4AA0EA76017F_impl*
 vcmDispatcher.FormDispatcher.Lock;
 try
  l_Params := vcmCheckAggregate(vcmMakeParams);

  l_Container := TcfAttributeSelect.Make(l_Params, vcm_ztManualModal,
                                         TvcmUserType(utAttributeSelect));
  l_Params := vcmMakeParams(l_Params.Aggregate,
                        l_Container.AsContainer,
                        l_Params.Owner);
  l_Form := TefTreeAttributeSelect.Make(l_Params);
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
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TLiteSearchServiceImpl.OpenTreeSelection

function TLiteSearchServiceImpl.MakeAttributeSelect(const aParams: IvcmMakeParams;
 aZoneType: TvcmZoneType;
 aRecursive: Boolean;
 aUserType: TvcmUserType): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4AAF4FC80387_4AA0EA76017F_var*
//#UC END# *4AAF4FC80387_4AA0EA76017F_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AAF4FC80387_4AA0EA76017F_impl*
 Assert(aRecursive);
 Result := TcfAttributeSelect.MakeSingleChild(aParams.Container,
                                             aParams,
                                             aZoneType,
                                             aUserType);
//#UC END# *4AAF4FC80387_4AA0EA76017F_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TLiteSearchServiceImpl.MakeAttributeSelect

function TLiteSearchServiceImpl.MakeSelectedAttributes(const aParams: IvcmMakeParams;
 aZoneType: TvcmZoneType;
 aRecursive: Boolean): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4AAF52280022_4AA0EA76017F_var*
//#UC END# *4AAF52280022_4AA0EA76017F_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AAF52280022_4AA0EA76017F_impl*
 Assert(aRecursive);
 Result := TenSelectedAttributes.MakeSingleChild(aParams.Container,
                                             aParams,
                                             aZoneType,
                                             0);
//#UC END# *4AAF52280022_4AA0EA76017F_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TLiteSearchServiceImpl.MakeSelectedAttributes

function TLiteSearchServiceImpl.MakeTreeAttributeSelect(const aParams: IvcmMakeParams;
 aZoneType: TvcmZoneType;
 aRecursive: Boolean;
 aUserType: TvcmUserType): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4AAF48F502E7_4AA0EA76017F_var*
//#UC END# *4AAF48F502E7_4AA0EA76017F_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AAF48F502E7_4AA0EA76017F_impl*
 Assert(aRecursive);
 Result := TefTreeAttributeSelect.MakeSingleChild(aParams.Container,
                                             aParams,
                                             aZoneType,
                                             aUserType);
//#UC END# *4AAF48F502E7_4AA0EA76017F_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TLiteSearchServiceImpl.MakeTreeAttributeSelect

class function TLiteSearchServiceImpl.Instance: TLiteSearchServiceImpl;
 {* Метод получения экземпляра синглетона TLiteSearchServiceImpl }
begin
 if (g_TLiteSearchServiceImpl = nil) then
 begin
  l3System.AddExitProc(TLiteSearchServiceImplFree);
  g_TLiteSearchServiceImpl := Create;
 end;
 Result := g_TLiteSearchServiceImpl;
end;//TLiteSearchServiceImpl.Instance

class function TLiteSearchServiceImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TLiteSearchServiceImpl <> nil;
end;//TLiteSearchServiceImpl.Exists

class procedure TLiteSearchModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(TefTreeAttributeSelect);
 aList.Add(TcfAttributeSelect);
 aList.Add(TenSelectedAttributes);
end;//TLiteSearchModule.GetEntityForms

initialization
 TLiteSearchService.Instance.Alien := TLiteSearchServiceImpl.Instance;
 {* Регистрация TLiteSearchServiceImpl }
{$IfEnd} // NOT Defined(NoVCM)

end.
