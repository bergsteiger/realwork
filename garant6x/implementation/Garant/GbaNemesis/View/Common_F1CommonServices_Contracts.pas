unit Common_F1CommonServices_Contracts;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common_F1CommonServices_Contracts.pas"
// Стереотип: "VCMContracts"
// Элемент модели: "F1CommonServices" MUID: (579F7F680321)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUnit
 , DynamicTreeUnit
 , UnderControlUnit
 , l3Interfaces
 , l3TreeInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchInterfaces
 , PresentationInterfaces
 , AdapterFacade
 , PrimPrimListInterfaces
 , DocumentInterfaces
 , MainMenuUnit
 , l3PrinterInterfaces
 , l3ProtoObject
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

 (*
 MDocumentOpenService = interface
  {* Контракт сервиса TDocumentOpenService }
  procedure OpenDocument(const aDocInfo: IdeDocInfo;
   const aContainer: IvcmContainer);
 end;//MDocumentOpenService
 *)

type
 IDocumentOpenService = interface
  {* Интерфейс сервиса TDocumentOpenService }
  procedure OpenDocument(const aDocInfo: IdeDocInfo;
   const aContainer: IvcmContainer);
 end;//IDocumentOpenService

 TDocumentOpenService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IDocumentOpenService;
    {* Внешняя реализация сервиса IDocumentOpenService }
  protected
   procedure pm_SetAlien(const aValue: IDocumentOpenService);
   procedure ClearFields; override;
  public
   procedure OpenDocument(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
   class function Instance: TDocumentOpenService;
    {* Метод получения экземпляра синглетона TDocumentOpenService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: IDocumentOpenService
    write pm_SetAlien;
    {* Внешняя реализация сервиса IDocumentOpenService }
 end;//TDocumentOpenService

 (*
 MListOpenService = interface
  {* Контракт сервиса TListOpenService }
  procedure OpenList(const aList: IdeList;
   const aContainer: IvcmContainer);
 end;//MListOpenService
 *)

 IListOpenService = interface
  {* Интерфейс сервиса TListOpenService }
  procedure OpenList(const aList: IdeList;
   const aContainer: IvcmContainer);
 end;//IListOpenService

 TListOpenService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IListOpenService;
    {* Внешняя реализация сервиса IListOpenService }
  protected
   procedure pm_SetAlien(const aValue: IListOpenService);
   procedure ClearFields; override;
  public
   procedure OpenList(const aList: IdeList;
    const aContainer: IvcmContainer);
   class function Instance: TListOpenService;
    {* Метод получения экземпляра синглетона TListOpenService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: IListOpenService
    write pm_SetAlien;
    {* Внешняя реализация сервиса IListOpenService }
 end;//TListOpenService

 (*
 MControlledObjectService = interface
  {* Контракт сервиса TControlledObjectService }
  procedure AddControlledObject(const aData: IControllable);
  procedure DeleteControlledObject(const aData: IControllable);
 end;//MControlledObjectService
 *)

 IControlledObjectService = interface
  {* Интерфейс сервиса TControlledObjectService }
  procedure AddControlledObject(const aData: IControllable);
  procedure DeleteControlledObject(const aData: IControllable);
 end;//IControlledObjectService

 TControlledObjectService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IControlledObjectService;
    {* Внешняя реализация сервиса IControlledObjectService }
  protected
   procedure pm_SetAlien(const aValue: IControlledObjectService);
   procedure ClearFields; override;
  public
   procedure AddControlledObject(const aData: IControllable);
   procedure DeleteControlledObject(const aData: IControllable);
   class function Instance: TControlledObjectService;
    {* Метод получения экземпляра синглетона TControlledObjectService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: IControlledObjectService
    write pm_SetAlien;
    {* Внешняя реализация сервиса IControlledObjectService }
 end;//TControlledObjectService

 (*
 MRubricatorOpenService = interface
  {* Контракт сервиса TRubricatorOpenService }
  procedure OpenRubricator(const aNode: Il3SimpleNode;
   const aRootToKeep: INodeBase;
   const aMenuSectionItemToKeep: ISectionItem;
   aNeedsSheet: Boolean;
   const anAggregate: IvcmAggregate;
   const aContainer: IvcmContainer);
 end;//MRubricatorOpenService
 *)

 IRubricatorOpenService = interface
  {* Интерфейс сервиса TRubricatorOpenService }
  procedure OpenRubricator(const aNode: Il3SimpleNode;
   const aRootToKeep: INodeBase;
   const aMenuSectionItemToKeep: ISectionItem;
   aNeedsSheet: Boolean;
   const anAggregate: IvcmAggregate;
   const aContainer: IvcmContainer);
 end;//IRubricatorOpenService

 TRubricatorOpenService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IRubricatorOpenService;
    {* Внешняя реализация сервиса IRubricatorOpenService }
  protected
   procedure pm_SetAlien(const aValue: IRubricatorOpenService);
   procedure ClearFields; override;
  public
   procedure OpenRubricator(const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem;
    aNeedsSheet: Boolean;
    const anAggregate: IvcmAggregate;
    const aContainer: IvcmContainer);
   class function Instance: TRubricatorOpenService;
    {* Метод получения экземпляра синглетона TRubricatorOpenService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: IRubricatorOpenService
    write pm_SetAlien;
    {* Внешняя реализация сервиса IRubricatorOpenService }
 end;//TRubricatorOpenService

 (*
 MMainMenuOpenService = interface
  {* Контракт сервиса TMainMenuOpenService }
  procedure OpenMainMenuIfNeeded(const aContainer: IvcmContainer);
 end;//MMainMenuOpenService
 *)

 IMainMenuOpenService = interface
  {* Интерфейс сервиса TMainMenuOpenService }
  procedure OpenMainMenuIfNeeded(const aContainer: IvcmContainer);
 end;//IMainMenuOpenService

 TMainMenuOpenService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IMainMenuOpenService;
    {* Внешняя реализация сервиса IMainMenuOpenService }
  protected
   procedure pm_SetAlien(const aValue: IMainMenuOpenService);
   procedure ClearFields; override;
  public
   procedure OpenMainMenuIfNeeded(const aContainer: IvcmContainer);
   class function Instance: TMainMenuOpenService;
    {* Метод получения экземпляра синглетона TMainMenuOpenService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: IMainMenuOpenService
    write pm_SetAlien;
    {* Внешняя реализация сервиса IMainMenuOpenService }
 end;//TMainMenuOpenService

 (*
 MCommonService = interface
  {* Контракт сервиса TCommonService }
  procedure About;
   {* Выводит диалог "О программе" }
  procedure AddDocumentToControl(const aDocument: IDocument);
   {* Поставить документ на контроль }
  procedure AddToControl(const aControllable: IControllable);
   {* Поставить объект на контроль }
  procedure ApplicationActivate;
  procedure CloseNavigator(const aContainer: IvcmContainer);
  procedure CloseTasksPanel(const aContainer: IvcmContainer);
  procedure DeleteDocumentFromControl(const aDocument: IDocument);
   {* Снять документ с контроля }
  procedure DeleteFromControl(const aControllable: IControllable);
   {* Снять объект с контроля }
  procedure FromPrinterSettings(const aPrinter: Il3Printer);
   {* Считать настройки из принтера }
  function GetCurEditionDate(const aDocument: IDocument): AdapterDate;
  procedure GetNavigator(const anAggregate: IvcmAggregate;
   const aContainer: IvcmContainer);
   {* Меню (вкладка) }
  function IsCurEditionActual(const aState: IDocumentState): Boolean; overload;
  function IsCurEditionActual(const aDocument: IDocument): Boolean; overload;
  function IsUnderControl(const aDoc: IDocument): Boolean;
   {* Находится ли документ на контроле }
  procedure OpenNewDocs(const aContainer: IvcmContainer);
  procedure OpenRubricatorOnStart(const aContainer: IvcmContainer);
  procedure OpenTasksPanel(const aContainer: IvcmContainer);
  procedure ToPrinterSettings(const aPrinter: Il3Printer);
   {* Записать настройки в принтер }
  function MakeProgressIndicator(const aProgress: InsProgressIndicator;
   const aCaption: Il3CString;
   aMaxCount: Integer): IvcmEntityForm;
  function OpenTurnOffTimeMachine(const anIntf: InsTurnOffTimeMachine): IvcmEntityForm;
 end;//MCommonService
 *)

 ICommonService = interface
  {* Интерфейс сервиса TCommonService }
  procedure About;
   {* Выводит диалог "О программе" }
  procedure AddDocumentToControl(const aDocument: IDocument);
   {* Поставить документ на контроль }
  procedure AddToControl(const aControllable: IControllable);
   {* Поставить объект на контроль }
  procedure ApplicationActivate;
  procedure CloseNavigator(const aContainer: IvcmContainer);
  procedure CloseTasksPanel(const aContainer: IvcmContainer);
  procedure DeleteDocumentFromControl(const aDocument: IDocument);
   {* Снять документ с контроля }
  procedure DeleteFromControl(const aControllable: IControllable);
   {* Снять объект с контроля }
  procedure FromPrinterSettings(const aPrinter: Il3Printer);
   {* Считать настройки из принтера }
  function GetCurEditionDate(const aDocument: IDocument): AdapterDate;
  procedure GetNavigator(const anAggregate: IvcmAggregate;
   const aContainer: IvcmContainer);
   {* Меню (вкладка) }
  function IsCurEditionActual(const aState: IDocumentState): Boolean; overload;
  function IsCurEditionActual(const aDocument: IDocument): Boolean; overload;
  function IsUnderControl(const aDoc: IDocument): Boolean;
   {* Находится ли документ на контроле }
  procedure OpenNewDocs(const aContainer: IvcmContainer);
  procedure OpenRubricatorOnStart(const aContainer: IvcmContainer);
  procedure OpenTasksPanel(const aContainer: IvcmContainer);
  procedure ToPrinterSettings(const aPrinter: Il3Printer);
   {* Записать настройки в принтер }
  function MakeProgressIndicator(const aProgress: InsProgressIndicator;
   const aCaption: Il3CString;
   aMaxCount: Integer): IvcmEntityForm;
  function OpenTurnOffTimeMachine(const anIntf: InsTurnOffTimeMachine): IvcmEntityForm;
 end;//ICommonService

 TCommonService = {final} class(Tl3ProtoObject)
  private
   f_Alien: ICommonService;
    {* Внешняя реализация сервиса ICommonService }
  protected
   procedure pm_SetAlien(const aValue: ICommonService);
   procedure ClearFields; override;
  public
   procedure About;
    {* Выводит диалог "О программе" }
   procedure AddDocumentToControl(const aDocument: IDocument);
    {* Поставить документ на контроль }
   procedure AddToControl(const aControllable: IControllable);
    {* Поставить объект на контроль }
   procedure ApplicationActivate;
   procedure CloseNavigator(const aContainer: IvcmContainer);
   procedure CloseTasksPanel(const aContainer: IvcmContainer);
   procedure DeleteDocumentFromControl(const aDocument: IDocument);
    {* Снять документ с контроля }
   procedure DeleteFromControl(const aControllable: IControllable);
    {* Снять объект с контроля }
   procedure FromPrinterSettings(const aPrinter: Il3Printer);
    {* Считать настройки из принтера }
   function GetCurEditionDate(const aDocument: IDocument): AdapterDate;
   procedure GetNavigator(const anAggregate: IvcmAggregate;
    const aContainer: IvcmContainer);
    {* Меню (вкладка) }
   function IsCurEditionActual(const aState: IDocumentState): Boolean; overload;
   function IsCurEditionActual(const aDocument: IDocument): Boolean; overload;
   function IsUnderControl(const aDoc: IDocument): Boolean;
    {* Находится ли документ на контроле }
   procedure OpenNewDocs(const aContainer: IvcmContainer);
   procedure OpenRubricatorOnStart(const aContainer: IvcmContainer);
   procedure OpenTasksPanel(const aContainer: IvcmContainer);
   procedure ToPrinterSettings(const aPrinter: Il3Printer);
    {* Записать настройки в принтер }
   function MakeProgressIndicator(const aProgress: InsProgressIndicator;
    const aCaption: Il3CString;
    aMaxCount: Integer): IvcmEntityForm;
   function OpenTurnOffTimeMachine(const anIntf: InsTurnOffTimeMachine): IvcmEntityForm;
   class function Instance: TCommonService;
    {* Метод получения экземпляра синглетона TCommonService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: ICommonService
    write pm_SetAlien;
    {* Внешняя реализация сервиса ICommonService }
 end;//TCommonService

 (*
 MInpharmOperations = interface
  {* Контракт сервиса TInpharmOperations }
 end;//MInpharmOperations
 *)

 IInpharmOperations = interface
  {* Интерфейс сервиса TInpharmOperations }
 end;//IInpharmOperations

 TInpharmOperations = {final} class(Tl3ProtoObject)
  private
   f_Alien: IInpharmOperations;
    {* Внешняя реализация сервиса IInpharmOperations }
  protected
   procedure pm_SetAlien(const aValue: IInpharmOperations);
   procedure ClearFields; override;
  public
   class function Instance: TInpharmOperations;
    {* Метод получения экземпляра синглетона TInpharmOperations }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: IInpharmOperations
    write pm_SetAlien;
    {* Внешняя реализация сервиса IInpharmOperations }
 end;//TInpharmOperations

var mod_opcode_CommonService_ComplectInfo: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_CommonService_LetterToDevelopers: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_CommonService_OpenInformation: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_CommonService_OpenIntranet: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_CommonService_OpenMainMenuByButton: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_CommonService_OpenMainMenuNew: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_CommonService_OpenRubricator: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_CommonService_PageSetup: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_CommonService_ShowEULA: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_CommonService_TasksPanel: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_CommonService_get_navigator: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_InpharmOperations_DrugList: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_InpharmOperations_MedicDiction: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_InpharmOperations_MedicFirms: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_InpharmOperations_MedicMainMenu: TvcmMOPID = (rMoID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationStatesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , l3Base
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
;

var g_TDocumentOpenService: TDocumentOpenService = nil;
 {* Экземпляр синглетона TDocumentOpenService }
var g_TListOpenService: TListOpenService = nil;
 {* Экземпляр синглетона TListOpenService }
var g_TControlledObjectService: TControlledObjectService = nil;
 {* Экземпляр синглетона TControlledObjectService }
var g_TRubricatorOpenService: TRubricatorOpenService = nil;
 {* Экземпляр синглетона TRubricatorOpenService }
var g_TMainMenuOpenService: TMainMenuOpenService = nil;
 {* Экземпляр синглетона TMainMenuOpenService }
var g_TCommonService: TCommonService = nil;
 {* Экземпляр синглетона TCommonService }
var g_TInpharmOperations: TInpharmOperations = nil;
 {* Экземпляр синглетона TInpharmOperations }

procedure TDocumentOpenServiceFree;
 {* Метод освобождения экземпляра синглетона TDocumentOpenService }
begin
 l3Free(g_TDocumentOpenService);
end;//TDocumentOpenServiceFree

procedure TListOpenServiceFree;
 {* Метод освобождения экземпляра синглетона TListOpenService }
begin
 l3Free(g_TListOpenService);
end;//TListOpenServiceFree

procedure TControlledObjectServiceFree;
 {* Метод освобождения экземпляра синглетона TControlledObjectService }
begin
 l3Free(g_TControlledObjectService);
end;//TControlledObjectServiceFree

procedure TRubricatorOpenServiceFree;
 {* Метод освобождения экземпляра синглетона TRubricatorOpenService }
begin
 l3Free(g_TRubricatorOpenService);
end;//TRubricatorOpenServiceFree

procedure TMainMenuOpenServiceFree;
 {* Метод освобождения экземпляра синглетона TMainMenuOpenService }
begin
 l3Free(g_TMainMenuOpenService);
end;//TMainMenuOpenServiceFree

procedure TCommonServiceFree;
 {* Метод освобождения экземпляра синглетона TCommonService }
begin
 l3Free(g_TCommonService);
end;//TCommonServiceFree

procedure TInpharmOperationsFree;
 {* Метод освобождения экземпляра синглетона TInpharmOperations }
begin
 l3Free(g_TInpharmOperations);
end;//TInpharmOperationsFree

procedure TDocumentOpenService.pm_SetAlien(const aValue: IDocumentOpenService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TDocumentOpenService.pm_SetAlien

procedure TDocumentOpenService.OpenDocument(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.OpenDocument(aDocInfo, aContainer);
end;//TDocumentOpenService.OpenDocument

class function TDocumentOpenService.Instance: TDocumentOpenService;
 {* Метод получения экземпляра синглетона TDocumentOpenService }
begin
 if (g_TDocumentOpenService = nil) then
 begin
  l3System.AddExitProc(TDocumentOpenServiceFree);
  g_TDocumentOpenService := Create;
 end;
 Result := g_TDocumentOpenService;
end;//TDocumentOpenService.Instance

class function TDocumentOpenService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TDocumentOpenService <> nil;
end;//TDocumentOpenService.Exists

procedure TDocumentOpenService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TDocumentOpenService.ClearFields

procedure TListOpenService.pm_SetAlien(const aValue: IListOpenService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TListOpenService.pm_SetAlien

procedure TListOpenService.OpenList(const aList: IdeList;
 const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.OpenList(aList, aContainer);
end;//TListOpenService.OpenList

class function TListOpenService.Instance: TListOpenService;
 {* Метод получения экземпляра синглетона TListOpenService }
begin
 if (g_TListOpenService = nil) then
 begin
  l3System.AddExitProc(TListOpenServiceFree);
  g_TListOpenService := Create;
 end;
 Result := g_TListOpenService;
end;//TListOpenService.Instance

class function TListOpenService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TListOpenService <> nil;
end;//TListOpenService.Exists

procedure TListOpenService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TListOpenService.ClearFields

procedure TControlledObjectService.pm_SetAlien(const aValue: IControlledObjectService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TControlledObjectService.pm_SetAlien

procedure TControlledObjectService.AddControlledObject(const aData: IControllable);
begin
 if (f_Alien <> nil) then
  f_Alien.AddControlledObject(aData);
end;//TControlledObjectService.AddControlledObject

procedure TControlledObjectService.DeleteControlledObject(const aData: IControllable);
begin
 if (f_Alien <> nil) then
  f_Alien.DeleteControlledObject(aData);
end;//TControlledObjectService.DeleteControlledObject

class function TControlledObjectService.Instance: TControlledObjectService;
 {* Метод получения экземпляра синглетона TControlledObjectService }
begin
 if (g_TControlledObjectService = nil) then
 begin
  l3System.AddExitProc(TControlledObjectServiceFree);
  g_TControlledObjectService := Create;
 end;
 Result := g_TControlledObjectService;
end;//TControlledObjectService.Instance

class function TControlledObjectService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TControlledObjectService <> nil;
end;//TControlledObjectService.Exists

procedure TControlledObjectService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TControlledObjectService.ClearFields

procedure TRubricatorOpenService.pm_SetAlien(const aValue: IRubricatorOpenService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TRubricatorOpenService.pm_SetAlien

procedure TRubricatorOpenService.OpenRubricator(const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem;
 aNeedsSheet: Boolean;
 const anAggregate: IvcmAggregate;
 const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.OpenRubricator(aNode, aRootToKeep, aMenuSectionItemToKeep, aNeedsSheet, anAggregate, aContainer);
end;//TRubricatorOpenService.OpenRubricator

class function TRubricatorOpenService.Instance: TRubricatorOpenService;
 {* Метод получения экземпляра синглетона TRubricatorOpenService }
begin
 if (g_TRubricatorOpenService = nil) then
 begin
  l3System.AddExitProc(TRubricatorOpenServiceFree);
  g_TRubricatorOpenService := Create;
 end;
 Result := g_TRubricatorOpenService;
end;//TRubricatorOpenService.Instance

class function TRubricatorOpenService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TRubricatorOpenService <> nil;
end;//TRubricatorOpenService.Exists

procedure TRubricatorOpenService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TRubricatorOpenService.ClearFields

procedure TMainMenuOpenService.pm_SetAlien(const aValue: IMainMenuOpenService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TMainMenuOpenService.pm_SetAlien

procedure TMainMenuOpenService.OpenMainMenuIfNeeded(const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.OpenMainMenuIfNeeded(aContainer);
end;//TMainMenuOpenService.OpenMainMenuIfNeeded

class function TMainMenuOpenService.Instance: TMainMenuOpenService;
 {* Метод получения экземпляра синглетона TMainMenuOpenService }
begin
 if (g_TMainMenuOpenService = nil) then
 begin
  l3System.AddExitProc(TMainMenuOpenServiceFree);
  g_TMainMenuOpenService := Create;
 end;
 Result := g_TMainMenuOpenService;
end;//TMainMenuOpenService.Instance

class function TMainMenuOpenService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TMainMenuOpenService <> nil;
end;//TMainMenuOpenService.Exists

procedure TMainMenuOpenService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TMainMenuOpenService.ClearFields

procedure TCommonService.pm_SetAlien(const aValue: ICommonService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TCommonService.pm_SetAlien

procedure TCommonService.About;
 {* Выводит диалог "О программе" }
begin
 if (f_Alien <> nil) then
  f_Alien.About;
end;//TCommonService.About

procedure TCommonService.AddDocumentToControl(const aDocument: IDocument);
 {* Поставить документ на контроль }
begin
 if (f_Alien <> nil) then
  f_Alien.AddDocumentToControl(aDocument);
end;//TCommonService.AddDocumentToControl

procedure TCommonService.AddToControl(const aControllable: IControllable);
 {* Поставить объект на контроль }
begin
 if (f_Alien <> nil) then
  f_Alien.AddToControl(aControllable);
end;//TCommonService.AddToControl

procedure TCommonService.ApplicationActivate;
begin
 if (f_Alien <> nil) then
  f_Alien.ApplicationActivate;
end;//TCommonService.ApplicationActivate

procedure TCommonService.CloseNavigator(const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.CloseNavigator(aContainer);
end;//TCommonService.CloseNavigator

procedure TCommonService.CloseTasksPanel(const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.CloseTasksPanel(aContainer);
end;//TCommonService.CloseTasksPanel

procedure TCommonService.DeleteDocumentFromControl(const aDocument: IDocument);
 {* Снять документ с контроля }
begin
 if (f_Alien <> nil) then
  f_Alien.DeleteDocumentFromControl(aDocument);
end;//TCommonService.DeleteDocumentFromControl

procedure TCommonService.DeleteFromControl(const aControllable: IControllable);
 {* Снять объект с контроля }
begin
 if (f_Alien <> nil) then
  f_Alien.DeleteFromControl(aControllable);
end;//TCommonService.DeleteFromControl

procedure TCommonService.FromPrinterSettings(const aPrinter: Il3Printer);
 {* Считать настройки из принтера }
begin
 if (f_Alien <> nil) then
  f_Alien.FromPrinterSettings(aPrinter);
end;//TCommonService.FromPrinterSettings

function TCommonService.GetCurEditionDate(const aDocument: IDocument): AdapterDate;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.GetCurEditionDate(aDocument)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TCommonService.GetCurEditionDate

procedure TCommonService.GetNavigator(const anAggregate: IvcmAggregate;
 const aContainer: IvcmContainer);
 {* Меню (вкладка) }
begin
 if (f_Alien <> nil) then
  f_Alien.GetNavigator(anAggregate, aContainer);
end;//TCommonService.GetNavigator

function TCommonService.IsCurEditionActual(const aState: IDocumentState): Boolean;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.IsCurEditionActual(aState)
 else
 begin
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TCommonService.IsCurEditionActual

function TCommonService.IsCurEditionActual(const aDocument: IDocument): Boolean;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.IsCurEditionActual(aDocument)
 else
 begin
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TCommonService.IsCurEditionActual

function TCommonService.IsUnderControl(const aDoc: IDocument): Boolean;
 {* Находится ли документ на контроле }
begin
 if (f_Alien <> nil) then
  Result := f_Alien.IsUnderControl(aDoc)
 else
 begin
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TCommonService.IsUnderControl

procedure TCommonService.OpenNewDocs(const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.OpenNewDocs(aContainer);
end;//TCommonService.OpenNewDocs

procedure TCommonService.OpenRubricatorOnStart(const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.OpenRubricatorOnStart(aContainer);
end;//TCommonService.OpenRubricatorOnStart

procedure TCommonService.OpenTasksPanel(const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.OpenTasksPanel(aContainer);
end;//TCommonService.OpenTasksPanel

procedure TCommonService.ToPrinterSettings(const aPrinter: Il3Printer);
 {* Записать настройки в принтер }
begin
 if (f_Alien <> nil) then
  f_Alien.ToPrinterSettings(aPrinter);
end;//TCommonService.ToPrinterSettings

function TCommonService.MakeProgressIndicator(const aProgress: InsProgressIndicator;
 const aCaption: Il3CString;
 aMaxCount: Integer): IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.MakeProgressIndicator(aProgress, aCaption, aMaxCount)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TCommonService.MakeProgressIndicator

function TCommonService.OpenTurnOffTimeMachine(const anIntf: InsTurnOffTimeMachine): IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.OpenTurnOffTimeMachine(anIntf)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TCommonService.OpenTurnOffTimeMachine

class function TCommonService.Instance: TCommonService;
 {* Метод получения экземпляра синглетона TCommonService }
begin
 if (g_TCommonService = nil) then
 begin
  l3System.AddExitProc(TCommonServiceFree);
  g_TCommonService := Create;
 end;
 Result := g_TCommonService;
end;//TCommonService.Instance

class function TCommonService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TCommonService <> nil;
end;//TCommonService.Exists

procedure TCommonService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TCommonService.ClearFields

procedure TInpharmOperations.pm_SetAlien(const aValue: IInpharmOperations);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TInpharmOperations.pm_SetAlien

class function TInpharmOperations.Instance: TInpharmOperations;
 {* Метод получения экземпляра синглетона TInpharmOperations }
begin
 if (g_TInpharmOperations = nil) then
 begin
  l3System.AddExitProc(TInpharmOperationsFree);
  g_TInpharmOperations := Create;
 end;
 Result := g_TInpharmOperations;
end;//TInpharmOperations.Instance

class function TInpharmOperations.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TInpharmOperations <> nil;
end;//TInpharmOperations.Exists

procedure TInpharmOperations.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TInpharmOperations.ClearFields

initialization
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
