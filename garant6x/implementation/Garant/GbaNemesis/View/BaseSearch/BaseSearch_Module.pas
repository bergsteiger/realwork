unit BaseSearch_Module;
 {* Базовый поиск }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\BaseSearch_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "BaseSearch" MUID: (4CC97D020011)
// Имя типа: "TBaseSearchModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TBaseSearchModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Базовый поиск }
  protected
   {$If NOT Defined(NoVCM)}
   class procedure GetEntityForms(aList: TvcmClassList); override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TBaseSearchModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmModuleContractImplementation
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_F1Services_Contracts
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , BaseSearchInterfaces
 , SearchUnit
 , PrimBaseSearchInterfaces
 , SysUtils
 , nsBaseSearchService
 , SearchLite_Strange_Controls
 , Search_Strange_Controls
 , PrimSaveLoadOptionsForBaseSearch_slqtBaseSearch_UserType
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Base
 , BaseSearchCard_Form
 , NewBaseSearch_Form
 , BaseSearchContainer_Form
 , Common_FormDefinitions_Controls
 //#UC START# *4CC97D020011impl_uses*
 //#UC END# *4CC97D020011impl_uses*
;

{$If NOT Defined(NoVCM)}
type
 TBaseSearchServiceImpl = {final} class(TvcmModuleContractImplementation, IBaseSearchService)
  public
   procedure BaseSearchCheckFindBack(const aContainer: IvcmContainer);
   procedure BaseSearchCheckFragmentsCount(const aContainer: IvcmContainer);
   procedure CheckBaseSearchDataReady(const aContainer: IvcmContainer);
   procedure OpenBaseSearch(OpenKind: TnsBaseSearchOpenKind;
    const aQuery: IQuery);
   procedure TryAnotherBaseSearch(const aContainer: IvcmContainer;
    const aProcessor: InsBaseSearchResultProcessor;
    TryFullList: Boolean = False);
   function MakeBaseSearchCard(const aContainer: IvcmContainer): IvcmEntityForm;
   function MakeBaseSearchWindow(const aContainer: IvcmContainer;
    const aData: InsBaseSearcherWindowData;
    aZoneType: TvcmZoneType): IvcmEntityForm;
   class function Instance: TBaseSearchServiceImpl;
    {* Метод получения экземпляра синглетона TBaseSearchServiceImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TBaseSearchServiceImpl

var g_TBaseSearchServiceImpl: TBaseSearchServiceImpl = nil;
 {* Экземпляр синглетона TBaseSearchServiceImpl }

procedure TBaseSearchServiceImplFree;
 {* Метод освобождения экземпляра синглетона TBaseSearchServiceImpl }
begin
 l3Free(g_TBaseSearchServiceImpl);
end;//TBaseSearchServiceImplFree

procedure TBaseSearchServiceImpl.BaseSearchCheckFindBack(const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AB7A5A500FB_4CC97D020011_var*
var
 l_Processor : InsBaseSearchQueryDataProcessor;
//#UC END# *4AB7A5A500FB_4CC97D020011_var*
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
end;//TBaseSearchServiceImpl.BaseSearchCheckFindBack

procedure TBaseSearchServiceImpl.BaseSearchCheckFragmentsCount(const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AB79B8201F8_4CC97D020011_var*
var
 l_Processor : InsBaseSearchQueryDataProcessor;
//#UC END# *4AB79B8201F8_4CC97D020011_var*
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
end;//TBaseSearchServiceImpl.BaseSearchCheckFragmentsCount

procedure TBaseSearchServiceImpl.CheckBaseSearchDataReady(const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AB797E7001F_4CC97D020011_var*
var
 l_Checker : InsBaseSearchDataReadyChecker;
//#UC END# *4AB797E7001F_4CC97D020011_var*
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
end;//TBaseSearchServiceImpl.CheckBaseSearchDataReady

procedure TBaseSearchServiceImpl.OpenBaseSearch(OpenKind: TnsBaseSearchOpenKind;
 const aQuery: IQuery);
var
 __WasEnter : Boolean;
//#UC START# *4AB7881B00EA_4CC97D020011_var*
var
 l_Container : IvcmContainer;
 l_Processor : InsBaseSearchQueryDataProcessor;
//#UC END# *4AB7881B00EA_4CC97D020011_var*
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
end;//TBaseSearchServiceImpl.OpenBaseSearch

procedure TBaseSearchServiceImpl.TryAnotherBaseSearch(const aContainer: IvcmContainer;
 const aProcessor: InsBaseSearchResultProcessor;
 TryFullList: Boolean = False);
var
 __WasEnter : Boolean;
//#UC START# *4AB79DF40349_4CC97D020011_var*
var
 l_Processor : InsBaseSearchResultProcessor;
//#UC END# *4AB79DF40349_4CC97D020011_var*
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
end;//TBaseSearchServiceImpl.TryAnotherBaseSearch

function TBaseSearchServiceImpl.MakeBaseSearchCard(const aContainer: IvcmContainer): IvcmEntityForm;
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
end;//TBaseSearchServiceImpl.MakeBaseSearchCard

function TBaseSearchServiceImpl.MakeBaseSearchWindow(const aContainer: IvcmContainer;
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
end;//TBaseSearchServiceImpl.MakeBaseSearchWindow

class function TBaseSearchServiceImpl.Instance: TBaseSearchServiceImpl;
 {* Метод получения экземпляра синглетона TBaseSearchServiceImpl }
begin
 if (g_TBaseSearchServiceImpl = nil) then
 begin
  l3System.AddExitProc(TBaseSearchServiceImplFree);
  g_TBaseSearchServiceImpl := Create;
 end;
 Result := g_TBaseSearchServiceImpl;
end;//TBaseSearchServiceImpl.Instance

class function TBaseSearchServiceImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TBaseSearchServiceImpl <> nil;
end;//TBaseSearchServiceImpl.Exists

class procedure TBaseSearchModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(Ten_BaseSearchCard);
 aList.Add(TNewBaseSearchForm);
 aList.Add(TBaseSearchContainerForm);
end;//TBaseSearchModule.GetEntityForms

initialization
 TBaseSearchService.Instance.Alien := TBaseSearchServiceImpl.Instance;
 {* Регистрация TBaseSearchServiceImpl }
 fm_NewBaseSearchForm.SetFactory(TNewBaseSearchForm.Make);
 {* Регистрация фабрики формы NewBaseSearch }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TBaseSearchModule);
 {* Регистрация BaseSearch }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
