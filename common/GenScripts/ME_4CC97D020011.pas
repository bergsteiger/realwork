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
 , PrimBaseSearchInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , BaseSearchInterfaces
 , SearchUnit
;

type
 TBaseSearchModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Базовый поиск }
  public
   procedure TryAnotherBaseSearch(const aContainer: IvcmContainer;
    const aProcessor: InsBaseSearchResultProcessor;
    TryFullList: Boolean = False);
   procedure OpenBaseSearch(OpenKind: TnsBaseSearchOpenKind;
    const aQuery: IQuery);
   procedure MakeBaseSearchWindow(const aContainer: IvcmContainer;
    const aData: InsBaseSearcherWindowData;
    aZoneType: TvcmZoneType);
   procedure BaseSearchCheckFragmentsCount(const aContainer: IvcmContainer);
   procedure CheckBaseSearchDataReady(const aContainer: IvcmContainer);
   procedure BaseSearchCheckFindBack(const aContainer: IvcmContainer);
   procedure MakeBaseSearchCard(const aContainer: IvcmContainer);
 end;//TBaseSearchModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , Search_Strange_Controls
 , SearchLite_Strange_Controls
 , nsBaseSearchService
 , PrimSaveLoadOptionsForBaseSearch_slqtBaseSearch_UserType
 , BaseSearchCard_Form
 , NewBaseSearch_Form
 , BaseSearchContainer_Form
;

{$If NOT Defined(NoVCM)}
procedure TBaseSearchModule.TryAnotherBaseSearch(const aContainer: IvcmContainer;
 const aProcessor: InsBaseSearchResultProcessor;
 TryFullList: Boolean = False);
var l_Processor: InsBaseSearchResultProcessor;
//#UC START# *4AB79DF40349_4CC97D020011_var*
//#UC END# *4AB79DF40349_4CC97D020011_var*
begin
//#UC START# *4AB79DF40349_4CC97D020011_impl*
 if (aProcessor <> nil) then
  l_Processor := aProcessor
 else
  Supports(CheckContainer(aContainer).NativeMainForm,
           InsBaseSearchQueryDataProcessor, l_Processor);
 if (l_Processor <> nil) then
  l_Processor.SearchResultEmpty(TryFullList);
//#UC END# *4AB79DF40349_4CC97D020011_impl*
end;//TBaseSearchModule.TryAnotherBaseSearch

procedure TBaseSearchModule.OpenBaseSearch(OpenKind: TnsBaseSearchOpenKind;
 const aQuery: IQuery);
var l_Container: IvcmContainer;
var l_Processor: InsBaseSearchQueryDataProcessor;
//#UC START# *4AB7881B00EA_4CC97D020011_var*
//#UC END# *4AB7881B00EA_4CC97D020011_var*
begin
//#UC START# *4AB7881B00EA_4CC97D020011_impl*
 l_Container := CheckContainer(nil).NativeMainForm;
 if Supports(l_Container, InsBaseSearchWindowOpener, l_Opener) then
  l_Opener.OpenWindow(OpenKind);
 if (aQuery <> nil) and
    Supports(l_Container, InsBaseSearchQueryDataProcessor, l_Processor) then
  l_Processor.SetDataFromQuery(aQuery);
//#UC END# *4AB7881B00EA_4CC97D020011_impl*
end;//TBaseSearchModule.OpenBaseSearch

procedure TBaseSearchModule.MakeBaseSearchWindow(const aContainer: IvcmContainer;
 const aData: InsBaseSearcherWindowData;
 aZoneType: TvcmZoneType);
//#UC START# *4AB793B903E6_4CC97D020011_var*
 l_Params: IvcmMakeParams;
//#UC END# *4AB793B903E6_4CC97D020011_var*
begin
//#UC START# *4AB793B903E6_4CC97D020011_impl*
  l_Params := vcmCheckAggregate(vcmMakeParams(nil, CheckContainer(aContainer)));
  Result := TNewBaseSearchForm.MakeSingleChild(aData, l_Params.Container,
    l_Params.Aggregate,
    aZoneType);
//  Result := Ten_BaseSearch.MakeSingleChild(aData, CheckContainer(aContainer));
//#UC END# *4AB793B903E6_4CC97D020011_impl*
end;//TBaseSearchModule.MakeBaseSearchWindow

procedure TBaseSearchModule.BaseSearchCheckFragmentsCount(const aContainer: IvcmContainer);
var l_Processor: InsBaseSearchQueryDataProcessor;
//#UC START# *4AB79B8201F8_4CC97D020011_var*
//#UC END# *4AB79B8201F8_4CC97D020011_var*
begin
//#UC START# *4AB79B8201F8_4CC97D020011_impl*
 if Supports(CheckContainer(aContainer).NativeMainForm,
             InsBaseSearchQueryDataProcessor, l_Processor) then
  l_Processor.RequestCheckFragmentsCount;
//#UC END# *4AB79B8201F8_4CC97D020011_impl*
end;//TBaseSearchModule.BaseSearchCheckFragmentsCount

procedure TBaseSearchModule.CheckBaseSearchDataReady(const aContainer: IvcmContainer);
var l_Checker: InsBaseSearchDataReadyChecker;
//#UC START# *4AB797E7001F_4CC97D020011_var*
//#UC END# *4AB797E7001F_4CC97D020011_var*
begin
//#UC START# *4AB797E7001F_4CC97D020011_impl*
 if Supports(CheckContainer(aContainer).NativeMainForm,
             InsBaseSearchDataReadyChecker, l_Checker) then
  l_Checker.CheckLocalDataReady;
//#UC END# *4AB797E7001F_4CC97D020011_impl*
end;//TBaseSearchModule.CheckBaseSearchDataReady

procedure TBaseSearchModule.BaseSearchCheckFindBack(const aContainer: IvcmContainer);
var l_Processor: InsBaseSearchQueryDataProcessor;
//#UC START# *4AB7A5A500FB_4CC97D020011_var*
//#UC END# *4AB7A5A500FB_4CC97D020011_var*
begin
//#UC START# *4AB7A5A500FB_4CC97D020011_impl*
 if Supports(CheckContainer(aContainer).NativeMainForm,
             InsBaseSearchQueryDataProcessor, l_Processor) then
  l_Processor.RequestCheckFindBack;
//#UC END# *4AB7A5A500FB_4CC97D020011_impl*
end;//TBaseSearchModule.BaseSearchCheckFindBack

procedure TBaseSearchModule.MakeBaseSearchCard(const aContainer: IvcmContainer);
//#UC START# *4AB7A2E20096_4CC97D020011_var*
var
 l_Params: IvcmMakeParams;
 l_Container : IvcmContainer;
//#UC END# *4AB7A2E20096_4CC97D020011_var*
begin
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
end;//TBaseSearchModule.MakeBaseSearchCard

initialization
 fm_NewBaseSearchForm.SetFactory(TNewBaseSearchForm.Make);
 {* Регистрация фабрики формы NewBaseSearch }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TBaseSearchModule);
 {* Регистрация BaseSearch }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
