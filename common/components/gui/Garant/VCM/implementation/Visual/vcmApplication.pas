unit vcmApplication;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmApplication.pas"
// Начат: 17.09.2009 16:40
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::Application::TvcmApplication
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmExternalInterfaces,
  Classes,
  vcmFormSetFactory,
  vcmMainForm,
  vcmModule,
  l3StringIDEx,
  vcmBaseOperationState
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 RvcmApplication = class of TvcmApplication;

 TvcmApplication = class(TDataModule)
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
 protected
 // protected methods
    {$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
   procedure PublishModule(aModule: RvcmModule;
     const aCap: AnsiString);
    {$IfEnd} //not DesignTimeLibrary AND not NoVCM
    {$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
   function PublishModuleOperation(aModule: RvcmModule;
     const aName: AnsiString;
     const aCap: AnsiString;
     aNoPrefix: Boolean = false): TvcmMOPID;
    {$IfEnd} //not DesignTimeLibrary AND not NoVCM
    {$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
   function PublishOperation(const anEn: AnsiString;
     const anOp: AnsiString;
     const anEnCap: AnsiString;
     const anOpCap: AnsiString;
     aNoPrefix: Boolean = false): TvcmOPID;
    {$IfEnd} //not DesignTimeLibrary AND not NoVCM
    {$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
   function PublishInternalOperation(const anEn: AnsiString;
     const anOp: AnsiString;
     const anEnCap: AnsiString;
     const anOpCap: AnsiString;
     aNoPrefix: Boolean = false): TvcmOPID;
    {$IfEnd} //not DesignTimeLibrary AND not NoVCM
   class procedure MakeResources; virtual;
   class procedure Runner(const aTitle: Tl3StringIDEx;
     const aHelpFile: AnsiString); virtual;
   class procedure BeforeApplicationRun; virtual;
   {$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
   procedure RegisterFormSetFactories; virtual;
     {* Регистрирует фабрики сборок }
   {$IfEnd} //not DesignTimeLibrary AND not NoVCM
   {$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
   procedure RegisterFormSetFactory(aFactory: RvcmFormSetFactory);
   {$IfEnd} //not DesignTimeLibrary AND not NoVCM
 public
 // public methods
    {$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
   class function Instance: RvcmApplication;
    {$IfEnd} //not DesignTimeLibrary AND not NoVCM
    {$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
   function PublishOperationState(const anEn: AnsiString;
     const anOp: AnsiString;
     const aState: AnsiString;
     aNoPrefix: Boolean = false): TvcmBaseOperationState;
     {* Публикует состояние операции }
    {$IfEnd} //not DesignTimeLibrary AND not NoVCM
    {$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
   procedure SetOperationImageIndex(const anEn: AnsiString;
     const anOp: AnsiString;
     anImageIndex: Integer;
     aNoPrefix: Boolean = false);
    {$IfEnd} //not DesignTimeLibrary AND not NoVCM
   class procedure Run(const aTitle: Tl3StringIDEx;
     const aHelpFile: AnsiString);
   {$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
   class procedure RegisterModules(aMain: TvcmMainForm); virtual;
     {* Регистрирует модули приложения }
   {$IfEnd} //not DesignTimeLibrary AND not NoVCM
 end;//TvcmApplication
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  vcmModulesCollection,
  vcmRepEntitiesCollection,
  l3ConstStrings
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  afwFacade,
  vcmBaseMenuManager
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

  {$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
var
   g_Instance : RvcmApplication = nil;
  {$IfEnd} //not DesignTimeLibrary AND not NoVCM

// start class TvcmApplication

{$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
class function TvcmApplication.Instance: RvcmApplication;
//#UC START# *4AB23A660050_4AB22E140136_var*
//#UC END# *4AB23A660050_4AB22E140136_var*
begin
//#UC START# *4AB23A660050_4AB22E140136_impl*
 Result := g_Instance;
//#UC END# *4AB23A660050_4AB22E140136_impl*
end;//TvcmApplication.Instance
{$IfEnd} //not DesignTimeLibrary AND not NoVCM

{$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
procedure TvcmApplication.PublishModule(aModule: RvcmModule;
  const aCap: AnsiString);
//#UC START# *4AB33E56019A_4AB22E140136_var*
//#UC END# *4AB33E56019A_4AB22E140136_var*
begin
//#UC START# *4AB33E56019A_4AB22E140136_impl*
 TvcmModulesCollection(g_MenuManager.Modules).PublishModule(aModule, aCap);
//#UC END# *4AB33E56019A_4AB22E140136_impl*
end;//TvcmApplication.PublishModule
{$IfEnd} //not DesignTimeLibrary AND not NoVCM

{$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
function TvcmApplication.PublishModuleOperation(aModule: RvcmModule;
  const aName: AnsiString;
  const aCap: AnsiString;
  aNoPrefix: Boolean = false): TvcmMOPID;
//#UC START# *4AB33E8201D8_4AB22E140136_var*
//#UC END# *4AB33E8201D8_4AB22E140136_var*
begin
//#UC START# *4AB33E8201D8_4AB22E140136_impl*
 Result := TvcmModulesCollection(g_MenuManager.Modules)
            .PublishModuleOperation(aModule, aName, aCap, aNoPrefix);
//#UC END# *4AB33E8201D8_4AB22E140136_impl*
end;//TvcmApplication.PublishModuleOperation
{$IfEnd} //not DesignTimeLibrary AND not NoVCM

{$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
function TvcmApplication.PublishOperation(const anEn: AnsiString;
  const anOp: AnsiString;
  const anEnCap: AnsiString;
  const anOpCap: AnsiString;
  aNoPrefix: Boolean = false): TvcmOPID;
//#UC START# *4AB33EF900E2_4AB22E140136_var*
//#UC END# *4AB33EF900E2_4AB22E140136_var*
begin
//#UC START# *4AB33EF900E2_4AB22E140136_impl*
 Result := TvcmRepEntitiesCollection(g_MenuManager.Entities)
            .PublishOperation(anEn, anOp, anEnCap, anOpCap, aNoPrefix);
//#UC END# *4AB33EF900E2_4AB22E140136_impl*
end;//TvcmApplication.PublishOperation
{$IfEnd} //not DesignTimeLibrary AND not NoVCM

{$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
function TvcmApplication.PublishInternalOperation(const anEn: AnsiString;
  const anOp: AnsiString;
  const anEnCap: AnsiString;
  const anOpCap: AnsiString;
  aNoPrefix: Boolean = false): TvcmOPID;
//#UC START# *4AB33F44024A_4AB22E140136_var*
//#UC END# *4AB33F44024A_4AB22E140136_var*
begin
//#UC START# *4AB33F44024A_4AB22E140136_impl*
 Result := TvcmRepEntitiesCollection(g_MenuManager.Entities)
            .PublishInternalOperation(anEn, anOp, anEnCap, anOpCap, aNoPrefix);
//#UC END# *4AB33F44024A_4AB22E140136_impl*
end;//TvcmApplication.PublishInternalOperation
{$IfEnd} //not DesignTimeLibrary AND not NoVCM

{$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
function TvcmApplication.PublishOperationState(const anEn: AnsiString;
  const anOp: AnsiString;
  const aState: AnsiString;
  aNoPrefix: Boolean = false): TvcmBaseOperationState;
//#UC START# *4C77C9C402B7_4AB22E140136_var*
//#UC END# *4C77C9C402B7_4AB22E140136_var*
begin
//#UC START# *4C77C9C402B7_4AB22E140136_impl*
 Result := TvcmRepEntitiesCollection(g_MenuManager.Entities)
            .PublishOperationState(anEn, anOp, aState, aNoPrefix);
//#UC END# *4C77C9C402B7_4AB22E140136_impl*
end;//TvcmApplication.PublishOperationState
{$IfEnd} //not DesignTimeLibrary AND not NoVCM

{$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
procedure TvcmApplication.SetOperationImageIndex(const anEn: AnsiString;
  const anOp: AnsiString;
  anImageIndex: Integer;
  aNoPrefix: Boolean = false);
//#UC START# *4EC4C83F01B4_4AB22E140136_var*
//#UC END# *4EC4C83F01B4_4AB22E140136_var*
begin
//#UC START# *4EC4C83F01B4_4AB22E140136_impl*
 TvcmRepEntitiesCollection(g_MenuManager.Entities)
            .SetOperationImageIndex(anEn, anOp, anImageIndex, aNoPrefix);
//#UC END# *4EC4C83F01B4_4AB22E140136_impl*
end;//TvcmApplication.SetOperationImageIndex
{$IfEnd} //not DesignTimeLibrary AND not NoVCM

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

{$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
class procedure TvcmApplication.RegisterModules(aMain: TvcmMainForm);
//#UC START# *4AB23CF803E5_4AB22E140136_var*
//#UC END# *4AB23CF803E5_4AB22E140136_var*
begin
//#UC START# *4AB23CF803E5_4AB22E140136_impl*
//#UC END# *4AB23CF803E5_4AB22E140136_impl*
end;//TvcmApplication.RegisterModules
{$IfEnd} //not DesignTimeLibrary AND not NoVCM

{$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
procedure TvcmApplication.RegisterFormSetFactories;
//#UC START# *4AB24E3703E3_4AB22E140136_var*
//#UC END# *4AB24E3703E3_4AB22E140136_var*
begin
//#UC START# *4AB24E3703E3_4AB22E140136_impl*
//#UC END# *4AB24E3703E3_4AB22E140136_impl*
end;//TvcmApplication.RegisterFormSetFactories
{$IfEnd} //not DesignTimeLibrary AND not NoVCM

{$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
procedure TvcmApplication.RegisterFormSetFactory(aFactory: RvcmFormSetFactory);
//#UC START# *4AB24E6E0127_4AB22E140136_var*
//#UC END# *4AB24E6E0127_4AB22E140136_var*
begin
//#UC START# *4AB24E6E0127_4AB22E140136_impl*
// if Assigned(g_MenuManager) then
//  g_MenuManager.RegisterFormSetFactory(aFactory);
//#UC END# *4AB24E6E0127_4AB22E140136_impl*
end;//TvcmApplication.RegisterFormSetFactory
{$IfEnd} //not DesignTimeLibrary AND not NoVCM

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

{$IfEnd} //not NoVCM

end.