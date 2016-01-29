unit LiteSearch_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/LiteSearch_Module.pas"
// Начат: 04.09.2009 14:23
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormsPack::Class>> F1 Базовые определения предметной области::SearchLite::View::LiteSearch::LiteSearch
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  l3Interfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  SearchInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
  {$If defined(Nemesis)}
  ,
  nscContextFilter
  {$IfEnd} //Nemesis
  ,
  nsTypes,
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel,
  TreeAttributeSelect_Form,
  AttributeSelect_Form,
  SelectedAttributes_Form
  {$If defined(Nemesis)}
  ,
  nscTreeViewHotTruck
  {$IfEnd} //Nemesis
  ,
  PrimTreeAttributeSelectOptions_Form,
  PrimSelectedAttributesOptions_Form,
  PrimAttributeSelectOptions_Form,
  SearchLite_FormDefinitions_Controls
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  tfwControlString
  {$IfEnd} //not NoScripts
  ,
  nscTreeViewWithAdapterDragDrop
  {$If not defined(NoScripts)}
  ,
  tfwPropertyLike
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  TreeAttributeSelectKeywordsPack
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  AttributeSelectKeywordsPack
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  SelectedAttributesKeywordsPack
  {$IfEnd} //not NoScripts
  ,
  vcmExternalInterfaces {a},
  vcmModule {a},
  vcmBase {a}
  ;

type
 TLiteSearchModule = {formspack} class(TvcmModule)
 protected
  class procedure GetEntityForms(aList : TvcmClassList); override;
 public
 // public methods
   class function MakeTreeAttributeSelect(const aParams: IvcmMakeParams;
     aZoneType: TvcmZoneType;
     aRecursive: Boolean;
     aUserType: TvcmUserType): IvcmEntityForm;
   class function MakeAttributeSelect(const aParams: IvcmMakeParams;
     aZoneType: TvcmZoneType;
     aRecursive: Boolean;
     aUserType: TvcmUserType): IvcmEntityForm;
   class function MakeSelectedAttributes(const aParams: IvcmMakeParams;
     aZoneType: TvcmZoneType;
     aRecursive: Boolean): IvcmEntityForm;
   class function OpenTreeSelection(const aTag: Il3CString;
     anAdditionalFilter: TnsFilterType;
     const aFormData: IdsTreeAttributeSelect): Integer;
 end;//TLiteSearchModule

implementation

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3String,
  SearchLite_Strange_Controls,
  PrimAttributeSelect_utAttributeSelect_UserType
  {$If not defined(NoScripts)}
  ,
  tfwScriptingTypes
  {$IfEnd} //not NoScripts
  ,
  TypInfo,
  SysUtils
  {$If not defined(NoScripts)}
  ,
  tfwTypeRegistrator
  {$IfEnd} //not NoScripts
  ,
  l3Base {a},
  StdRes {a},
  vcmFormSetFactory {a}
  ;

// start class TLiteSearchModule

class function TLiteSearchModule.MakeTreeAttributeSelect(const aParams: IvcmMakeParams;
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
 Result := TTreeAttributeSelectForm.MakeSingleChild(aParams.Container,
                                             aParams,
                                             aZoneType,
                                             aUserType);
//#UC END# *4AAF48F502E7_4AA0EA76017F_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TLiteSearchModule.MakeTreeAttributeSelect

class function TLiteSearchModule.MakeAttributeSelect(const aParams: IvcmMakeParams;
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
end;//TLiteSearchModule.MakeAttributeSelect

class function TLiteSearchModule.MakeSelectedAttributes(const aParams: IvcmMakeParams;
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
end;//TLiteSearchModule.MakeSelectedAttributes

class function TLiteSearchModule.OpenTreeSelection(const aTag: Il3CString;
  anAdditionalFilter: TnsFilterType;
  const aFormData: IdsTreeAttributeSelect): Integer;
var
 __WasEnter : Boolean;
//#UC START# *4AAF590401AC_4AA0EA76017F_var*
//#UC END# *4AAF590401AC_4AA0EA76017F_var*
var
 l_Params : IvcmMakeParams;
 l_Container : IvcmEntityForm;
 l_Form : IvcmEntityForm;
 l_FilterType : TnsFilterType;
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
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TLiteSearchModule.OpenTreeSelection

class procedure TLiteSearchModule.GetEntityForms(aList : TvcmClassList);
begin
 inherited;
 aList.Add(TefTreeAttributeSelect);
 aList.Add(TcfAttributeSelect);
 aList.Add(TenSelectedAttributes);
end;

end.