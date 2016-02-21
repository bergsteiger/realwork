unit vcmApplication;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmApplication.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , Classes
 , vcmMainForm
 , vcmFormSetFactory
 , vcmModule
 , vcmExternalInterfaces
 , vcmBaseOperationState
 , l3StringIDEx
;

type
 RvcmApplication = class of TvcmApplication;

 TvcmApplication = class(TDataModule)
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   procedure PublishModule(aModule: RvcmModule;
    const aCap: AnsiString);
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   {$If NOT Defined(DesignTimeLibrary)}
   function PublishModuleOperation(aModule: RvcmModule;
    const aName: AnsiString;
    const aCap: AnsiString;
    aNoPrefix: Boolean = False): TvcmMOPID;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   {$If NOT Defined(DesignTimeLibrary)}
   function PublishOperation(const anEn: AnsiString;
    const anOp: AnsiString;
    const anEnCap: AnsiString;
    const anOpCap: AnsiString;
    aNoPrefix: Boolean = False): TvcmOPID;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   {$If NOT Defined(DesignTimeLibrary)}
   function PublishInternalOperation(const anEn: AnsiString;
    const anOp: AnsiString;
    const anEnCap: AnsiString;
    const anOpCap: AnsiString;
    aNoPrefix: Boolean = False): TvcmOPID;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   class procedure MakeResources; virtual;
   class procedure Runner(const aTitle: Tl3StringIDEx;
    const aHelpFile: AnsiString); virtual;
   class procedure BeforeApplicationRun; virtual;
   {$If NOT Defined(DesignTimeLibrary)}
   procedure RegisterFormSetFactories; virtual;
    {* Регистрирует фабрики сборок }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   {$If NOT Defined(DesignTimeLibrary)}
   procedure RegisterFormSetFactory(aFactory: RvcmFormSetFactory);
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   {$If NOT Defined(DesignTimeLibrary)}
   class function Instance: RvcmApplication;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   {$If NOT Defined(DesignTimeLibrary)}
   function PublishOperationState(const anEn: AnsiString;
    const anOp: AnsiString;
    const aState: AnsiString;
    aNoPrefix: Boolean = False): TvcmBaseOperationState;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   {$If NOT Defined(DesignTimeLibrary)}
   procedure SetOperationImageIndex(const anEn: AnsiString;
    const anOp: AnsiString;
    anImageIndex: Integer;
    aNoPrefix: Boolean = False);
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   class procedure Run(const aTitle: Tl3StringIDEx;
    const aHelpFile: AnsiString);
   {$If NOT Defined(DesignTimeLibrary)}
   class procedure RegisterModules(aMain: TvcmMainForm); virtual;
    {* Регистрирует модули приложения }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   constructor Create(AOwner: TComponent); override;
 end;//TvcmApplication
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmBaseMenuManager
 , vcmModulesCollection
 , vcmRepEntitiesCollection
 , l3ConstStrings
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , afwFacade
;

{$If NOT Defined(DesignTimeLibrary)}
var g_Instance: RvcmApplication = nil;
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$If NOT Defined(DesignTimeLibrary)}
class function TvcmApplication.Instance: RvcmApplication;
//#UC START# *4AB23A660050_4AB22E140136_var*
//#UC END# *4AB23A660050_4AB22E140136_var*
begin
//#UC START# *4AB23A660050_4AB22E140136_impl*
 Result := g_Instance;
//#UC END# *4AB23A660050_4AB22E140136_impl*
end;//TvcmApplication.Instance
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$If NOT Defined(DesignTimeLibrary)}
procedure TvcmApplication.PublishModule(aModule: RvcmModule;
 const aCap: AnsiString);
//#UC START# *4AB33E56019A_4AB22E140136_var*
//#UC END# *4AB33E56019A_4AB22E140136_var*
begin
//#UC START# *4AB33E56019A_4AB22E140136_impl*
 TvcmModulesCollection(g_MenuManager.Modules).PublishModule(aModule, aCap);
//#UC END# *4AB33E56019A_4AB22E140136_impl*
end;//TvcmApplication.PublishModule
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$If NOT Defined(DesignTimeLibrary)}
function TvcmApplication.PublishModuleOperation(aModule: RvcmModule;
 const aName: AnsiString;
 const aCap: AnsiString;
 aNoPrefix: Boolean = False): TvcmMOPID;
//#UC START# *4AB33E8201D8_4AB22E140136_var*
//#UC END# *4AB33E8201D8_4AB22E140136_var*
begin
//#UC START# *4AB33E8201D8_4AB22E140136_impl*
 Result := TvcmModulesCollection(g_MenuManager.Modules)
            .PublishModuleOperation(aModule, aName, aCap, aNoPrefix);
//#UC END# *4AB33E8201D8_4AB22E140136_impl*
end;//TvcmApplication.PublishModuleOperation
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$If NOT Defined(DesignTimeLibrary)}
function TvcmApplication.PublishOperation(const anEn: AnsiString;
 const anOp: AnsiString;
 const anEnCap: AnsiString;
 const anOpCap: AnsiString;
 aNoPrefix: Boolean = False): TvcmOPID;
//#UC START# *4AB33EF900E2_4AB22E140136_var*
//#UC END# *4AB33EF900E2_4AB22E140136_var*
begin
//#UC START# *4AB33EF900E2_4AB22E140136_impl*
 Result := TvcmRepEntitiesCollection(g_MenuManager.Entities)
            .PublishOperation(anEn, anOp, anEnCap, anOpCap, aNoPrefix);
//#UC END# *4AB33EF900E2_4AB22E140136_impl*
end;//TvcmApplication.PublishOperation
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$If NOT Defined(DesignTimeLibrary)}
function TvcmApplication.PublishInternalOperation(const anEn: AnsiString;
 const anOp: AnsiString;
 const anEnCap: AnsiString;
 const anOpCap: AnsiString;
 aNoPrefix: Boolean = False): TvcmOPID;
//#UC START# *4AB33F44024A_4AB22E140136_var*
//#UC END# *4AB33F44024A_4AB22E140136_var*
begin
//#UC START# *4AB33F44024A_4AB22E140136_impl*
 Result := TvcmRepEntitiesCollection(g_MenuManager.Entities)
            .PublishInternalOperation(anEn, anOp, anEnCap, anOpCap, aNoPrefix);
//#UC END# *4AB33F44024A_4AB22E140136_impl*
end;//TvcmApplication.PublishInternalOperation
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$If NOT Defined(DesignTimeLibrary)}
function TvcmApplication.PublishOperationState(const anEn: AnsiString;
 const anOp: AnsiString;
 const aState: AnsiString;
 aNoPrefix: Boolean = False): TvcmBaseOperationState;
//#UC START# *4C77C9C402B7_4AB22E140136_var*
//#UC END# *4C77C9C402B7_4AB22E140136_var*
begin
//#UC START# *4C77C9C402B7_4AB22E140136_impl*
 Result := TvcmRepEntitiesCollection(g_MenuManager.Entities)
            .PublishOperationState(anEn, anOp, aState, aNoPrefix);
//#UC END# *4C77C9C402B7_4AB22E140136_impl*
end;//TvcmApplication.PublishOperationState
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$If NOT Defined(DesignTimeLibrary)}
procedure TvcmApplication.SetOperationImageIndex(const anEn: AnsiString;
 const anOp: AnsiString;
 anImageIndex: Integer;
 aNoPrefix: Boolean = False);
//#UC START# *4EC4C83F01B4_4AB22E140136_var*
//#UC END# *4EC4C83F01B4_4AB22E140136_var*
begin
//#UC START# *4EC4C83F01B4_4AB22E140136_impl*
 TvcmRepEntitiesCollection(g_MenuManager.Entities)
            .SetOperationImageIndex(anEn, anOp, anImageIndex, aNoPrefix);
//#UC END# *4EC4C83F01B4_4AB22E140136_impl*
end;//TvcmApplication.SetOperationImageIndex
{$IfEnd} // NOT Defined(DesignTimeLibrary)

class procedure TvcmApplication.MakeResources;
//#UC START# *4F6AF5F00058_4AB22E140136_var*
//#UC END# *4F6AF5F00058_4AB22E140136_var*
begin
//#UC START# *4F6AF5F00058_4AB22E140136_impl*
 assert(false);
//#UC END# *4F6AF5F00058_4AB22E140136_impl*
end;//TvcmApplication.MakeResources

class procedure TvcmApplication.Run(const aTitle: Tl3StringIDEx;
 const aHelpFile: AnsiString);
//#UC START# *4F79A8E60206_4AB22E140136_var*
//#UC END# *4F79A8E60206_4AB22E140136_var*
begin
//#UC START# *4F79A8E60206_4AB22E140136_impl*
 afw.Application.ApplyActiveLanguage(Tl3ConstStrings.Instance);
 Runner(aTitle, aHelpFile);
//#UC END# *4F79A8E60206_4AB22E140136_impl*
end;//TvcmApplication.Run

class procedure TvcmApplication.Runner(const aTitle: Tl3StringIDEx;
 const aHelpFile: AnsiString);
//#UC START# *4F6AF5860291_4AB22E140136_var*
//#UC END# *4F6AF5860291_4AB22E140136_var*
begin
//#UC START# *4F6AF5860291_4AB22E140136_impl*
 assert(false);
//#UC END# *4F6AF5860291_4AB22E140136_impl*
end;//TvcmApplication.Runner

class procedure TvcmApplication.BeforeApplicationRun;
//#UC START# *52F2269B0373_4AB22E140136_var*
//#UC END# *52F2269B0373_4AB22E140136_var*
begin
//#UC START# *52F2269B0373_4AB22E140136_impl*
 // - ничего не делаем
//#UC END# *52F2269B0373_4AB22E140136_impl*
end;//TvcmApplication.BeforeApplicationRun

{$If NOT Defined(DesignTimeLibrary)}
class procedure TvcmApplication.RegisterModules(aMain: TvcmMainForm);
 {* Регистрирует модули приложения }
//#UC START# *4AB23CF803E5_4AB22E140136_var*
//#UC END# *4AB23CF803E5_4AB22E140136_var*
begin
//#UC START# *4AB23CF803E5_4AB22E140136_impl*
//#UC END# *4AB23CF803E5_4AB22E140136_impl*
end;//TvcmApplication.RegisterModules
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$If NOT Defined(DesignTimeLibrary)}
procedure TvcmApplication.RegisterFormSetFactories;
 {* Регистрирует фабрики сборок }
//#UC START# *4AB24E3703E3_4AB22E140136_var*
//#UC END# *4AB24E3703E3_4AB22E140136_var*
begin
//#UC START# *4AB24E3703E3_4AB22E140136_impl*
//#UC END# *4AB24E3703E3_4AB22E140136_impl*
end;//TvcmApplication.RegisterFormSetFactories
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$If NOT Defined(DesignTimeLibrary)}
procedure TvcmApplication.RegisterFormSetFactory(aFactory: RvcmFormSetFactory);
//#UC START# *4AB24E6E0127_4AB22E140136_var*
//#UC END# *4AB24E6E0127_4AB22E140136_var*
begin
//#UC START# *4AB24E6E0127_4AB22E140136_impl*
// if Assigned(g_MenuManager) then
//  g_MenuManager.RegisterFormSetFactory(aFactory);
//#UC END# *4AB24E6E0127_4AB22E140136_impl*
end;//TvcmApplication.RegisterFormSetFactory
{$IfEnd} // NOT Defined(DesignTimeLibrary)

constructor TvcmApplication.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4AB22E140136_var*
//#UC END# *47D1602000C6_4AB22E140136_var*
begin
//#UC START# *47D1602000C6_4AB22E140136_impl*
 inherited;
 {$If not defined(DesignTimeLibrary)}
 Assert(g_Instance = nil);
 g_Instance := RvcmApplication(ClassType);
 RegisterFormSetFactories;
 {$IfEnd} //not DesignTimeLibrary
//#UC END# *47D1602000C6_4AB22E140136_impl*
end;//TvcmApplication.Create
{$IfEnd} // NOT Defined(NoVCM)

end.
