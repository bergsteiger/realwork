unit BaseSearch_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaseSearch/BaseSearch_Module.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormsPack::Class>> F1 Основные прецеденты::BaseSearch::View::BaseSearch$Module::BaseSearch
//
// Базовый поиск
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SearchUnit
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  BaseSearchInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmModule
  {$IfEnd} //not NoVCM
  ,
  PrimBaseSearchCard_Form,
  BaseSearchCard_Form,
  Common_FormDefinitions_Controls,
  NewBaseSearchForDFM_Form,
  PrimBaseSearchInterfaces,
  PrimBaseSearchContainer_Form,
  NewBaseSearch_Form,
  BaseSearchContainer_Form,
  vcmExternalInterfaces {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TBaseSearchModule = {formspack} class(TvcmModule)
  {* Базовый поиск }
 protected
  class procedure GetEntityForms(aList : TvcmClassList); override;
 public
 // public methods
   class procedure TryAnotherBaseSearch(const aContainer: IvcmContainer;
     const aProcessor: InsBaseSearchResultProcessor;
     TryFullList: Boolean = False);
   class procedure OpenBaseSearch(OpenKind: TnsBaseSearchOpenKind;
     const aQuery: IQuery);
   class function MakeBaseSearchWindow(const aContainer: IvcmContainer;
     const aData: InsBaseSearcherWindowData;
     aZoneType: TvcmZoneType): IvcmEntityForm;
   class procedure BaseSearchCheckFragmentsCount(const aContainer: IvcmContainer);
   class procedure CheckBaseSearchDataReady(const aContainer: IvcmContainer);
   class procedure BaseSearchCheckFindBack(const aContainer: IvcmContainer);
   class function MakeBaseSearchCard(const aContainer: IvcmContainer): IvcmEntityForm;
 end;//TBaseSearchModule
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils,
  Search_Strange_Controls,
  SearchLite_Strange_Controls,
  nsBaseSearchService,
  PrimSaveLoadOptionsForBaseSearch_slqtBaseSearch_UserType
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  vcmFormSetFactory {a},
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TBaseSearchModule

class procedure TBaseSearchModule.TryAnotherBaseSearch(const aContainer: IvcmContainer;
  const aProcessor: InsBaseSearchResultProcessor;
  TryFullList: Boolean = False);
var
 __WasEnter : Boolean;
//#UC START# *4AB79DF40349_4CC97D020011_var*
//#UC END# *4AB79DF40349_4CC97D020011_var*
var
 l_Processor : InsBaseSearchResultProcessor;
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AB79DF40349_4CC97D020011_impl*
 if (aProcessor <> nil) then
  l_Processor := aProcessor
 else
  Supports(CheckContainer(aContainer).NativeMainForm,
           InsBaseSearchQueryDataProcessor, l_Processor);
 if (l_Processor <> nil) then
  l_Processor.SearchResultEmpty(TryFullList);
//#UC END# *4AB79DF40349_4CC97D020011_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TBaseSearchModule.TryAnotherBaseSearch

class procedure TBaseSearchModule.OpenBaseSearch(OpenKind: TnsBaseSearchOpenKind;
  const aQuery: IQuery);
var
 __WasEnter : Boolean;
//#UC START# *4AB7881B00EA_4CC97D020011_var*
//#UC END# *4AB7881B00EA_4CC97D020011_var*
var
 l_Container : IvcmContainer;
 l_Processor : InsBaseSearchQueryDataProcessor;
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AB7881B00EA_4CC97D020011_impl*
 l_Container := CheckContainer(nil).NativeMainForm;

 TnsBaseSearchService.Instance.OpenBaseSearch(l_Container, OpenKind);

 if (aQuery <> nil) and
    Supports(l_Container, InsBaseSearchQueryDataProcessor, l_Processor) then
  l_Processor.SetDataFromQuery(aQuery);
//#UC END# *4AB7881B00EA_4CC97D020011_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TBaseSearchModule.OpenBaseSearch

class function TBaseSearchModule.MakeBaseSearchWindow(const aContainer: IvcmContainer;
  const aData: InsBaseSearcherWindowData;
  aZoneType: TvcmZoneType): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4AB793B903E6_4CC97D020011_var*
 l_Params: IvcmMakeParams;
//#UC END# *4AB793B903E6_4CC97D020011_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AB793B903E6_4CC97D020011_impl*
  l_Params := vcmCheckAggregate(vcmMakeParams(nil, CheckContainer(aContainer)));
  Result := TNewBaseSearchForm.MakeSingleChild(aData, l_Params.Container,
    l_Params.Aggregate,
    aZoneType);
//  Result := Ten_BaseSearch.MakeSingleChild(aData, CheckContainer(aContainer));
//#UC END# *4AB793B903E6_4CC97D020011_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TBaseSearchModule.MakeBaseSearchWindow

class procedure TBaseSearchModule.BaseSearchCheckFragmentsCount(const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AB79B8201F8_4CC97D020011_var*
//#UC END# *4AB79B8201F8_4CC97D020011_var*
var
 l_Processor : InsBaseSearchQueryDataProcessor;
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AB79B8201F8_4CC97D020011_impl*
 if Supports(CheckContainer(aContainer).NativeMainForm,
             InsBaseSearchQueryDataProcessor, l_Processor) then
  l_Processor.RequestCheckFragmentsCount;
//#UC END# *4AB79B8201F8_4CC97D020011_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TBaseSearchModule.BaseSearchCheckFragmentsCount

class procedure TBaseSearchModule.CheckBaseSearchDataReady(const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AB797E7001F_4CC97D020011_var*
//#UC END# *4AB797E7001F_4CC97D020011_var*
var
 l_Checker : InsBaseSearchDataReadyChecker;
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AB797E7001F_4CC97D020011_impl*
 if Supports(CheckContainer(aContainer).NativeMainForm,
             InsBaseSearchDataReadyChecker, l_Checker) then
  l_Checker.CheckLocalDataReady;
//#UC END# *4AB797E7001F_4CC97D020011_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TBaseSearchModule.CheckBaseSearchDataReady

class procedure TBaseSearchModule.BaseSearchCheckFindBack(const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AB7A5A500FB_4CC97D020011_var*
//#UC END# *4AB7A5A500FB_4CC97D020011_var*
var
 l_Processor : InsBaseSearchQueryDataProcessor;
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AB7A5A500FB_4CC97D020011_impl*
 if Supports(CheckContainer(aContainer).NativeMainForm,
             InsBaseSearchQueryDataProcessor, l_Processor) then
  l_Processor.RequestCheckFindBack;
//#UC END# *4AB7A5A500FB_4CC97D020011_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TBaseSearchModule.BaseSearchCheckFindBack

class function TBaseSearchModule.MakeBaseSearchCard(const aContainer: IvcmContainer): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4AB7A2E20096_4CC97D020011_var*
var
 l_Params: IvcmMakeParams;
 l_Container : IvcmContainer;
//#UC END# *4AB7A2E20096_4CC97D020011_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AB7A2E20096_4CC97D020011_impl*
  l_Params := vcmCheckAggregate(vcmMakeParams(nil, CheckContainer(aContainer)));
  l_Container := TBaseSearchContainerForm.MakeSingleChild(l_Params.Container,
                                                          l_Params,
                                                          vcm_ztParent,
                                                          slqtBaseSearch).AsContainer;

  Result := Ten_BaseSearchCard.Make(vcmMakeParams(l_Params.Aggregate,
                                                  l_Container,
                                                  l_Container.AsForm.VCLWinControl),
                                    vcm_ztParent);
//#UC END# *4AB7A2E20096_4CC97D020011_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TBaseSearchModule.MakeBaseSearchCard

class procedure TBaseSearchModule.GetEntityForms(aList : TvcmClassList);
begin
 inherited;
 aList.Add(Ten_BaseSearchCard);
 aList.Add(TNewBaseSearchForm);
 aList.Add(TBaseSearchContainerForm);
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Регистрация фабрики формы NewBaseSearch
 fm_NewBaseSearchForm.SetFactory(TNewBaseSearchForm.Make);
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация BaseSearch
 TtfwClassRef.Register(TBaseSearchModule);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.