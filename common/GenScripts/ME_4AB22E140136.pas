unit vcmApplication;

interface

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
  function Instance: RvcmApplication;
  procedure PublishModule(aModule: RvcmModule;
   const aCap: AnsiString);
  function PublishModuleOperation(aModule: RvcmModule;
   const aName: AnsiString;
   const aCap: AnsiString;
   aNoPrefix: Boolean): TvcmMOPID;
  function PublishOperation(const anEn: AnsiString;
   const anOp: AnsiString;
   const anEnCap: AnsiString;
   const anOpCap: AnsiString;
   aNoPrefix: Boolean): TvcmOPID;
  function PublishInternalOperation(const anEn: AnsiString;
   const anOp: AnsiString;
   const anEnCap: AnsiString;
   const anOpCap: AnsiString;
   aNoPrefix: Boolean): TvcmOPID;
  function PublishOperationState(const anEn: AnsiString;
   const anOp: AnsiString;
   const aState: AnsiString;
   aNoPrefix: Boolean): TvcmBaseOperationState;
  procedure SetOperationImageIndex(const anEn: AnsiString;
   const anOp: AnsiString;
   anImageIndex: Integer;
   aNoPrefix: Boolean);
  procedure MakeResources;
  procedure Run(const aTitle: Tl3StringIDEx;
   const aHelpFile: AnsiString);
  procedure Runner(const aTitle: Tl3StringIDEx;
   const aHelpFile: AnsiString);
  procedure BeforeApplicationRun;
  procedure RegisterModules(aMain: TvcmMainForm);
   {* Регистрирует модули приложения }
  procedure RegisterFormSetFactories;
   {* Регистрирует фабрики сборок }
  procedure RegisterFormSetFactory(aFactory: RvcmFormSetFactory);
 end;//TvcmApplication
 
implementation

uses
 l3ImplUses
 , vcmBaseMenuManager
 , vcmModulesCollection
 , vcmRepEntitiesCollection
 , l3ConstStrings
 , Forms
 , afwFacade
;

end.
