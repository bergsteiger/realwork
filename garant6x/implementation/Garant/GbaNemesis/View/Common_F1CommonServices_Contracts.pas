unit Common_F1CommonServices_Contracts;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common_F1CommonServices_Contracts.pas"
// ���������: "VCMContracts"
// ������� ������: "F1CommonServices" MUID: (579F7F680321)

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
  {* �������� ������� TDocumentOpenService }
  procedure OpenDocument(const aDocInfo: IdeDocInfo;
   const aContainer: IvcmContainer);
 end;//MDocumentOpenService
 *)

type
 IDocumentOpenService = interface
  {* ��������� ������� TDocumentOpenService }
  procedure OpenDocument(const aDocInfo: IdeDocInfo;
   const aContainer: IvcmContainer);
 end;//IDocumentOpenService

 TDocumentOpenService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IDocumentOpenService;
    {* ������� ���������� ������� IDocumentOpenService }
  protected
   procedure pm_SetAlien(const aValue: IDocumentOpenService);
   procedure ClearFields; override;
  public
   procedure OpenDocument(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
   class function Instance: TDocumentOpenService;
    {* ����� ��������� ���������� ���������� TDocumentOpenService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IDocumentOpenService
    write pm_SetAlien;
    {* ������� ���������� ������� IDocumentOpenService }
 end;//TDocumentOpenService

 (*
 MListOpenService = interface
  {* �������� ������� TListOpenService }
  procedure OpenList(const aList: IdeList;
   const aContainer: IvcmContainer);
 end;//MListOpenService
 *)

 IListOpenService = interface
  {* ��������� ������� TListOpenService }
  procedure OpenList(const aList: IdeList;
   const aContainer: IvcmContainer);
 end;//IListOpenService

 TListOpenService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IListOpenService;
    {* ������� ���������� ������� IListOpenService }
  protected
   procedure pm_SetAlien(const aValue: IListOpenService);
   procedure ClearFields; override;
  public
   procedure OpenList(const aList: IdeList;
    const aContainer: IvcmContainer);
   class function Instance: TListOpenService;
    {* ����� ��������� ���������� ���������� TListOpenService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IListOpenService
    write pm_SetAlien;
    {* ������� ���������� ������� IListOpenService }
 end;//TListOpenService

 (*
 MControlledObjectService = interface
  {* �������� ������� TControlledObjectService }
  procedure AddControlledObject(const aData: IControllable);
  procedure DeleteControlledObject(const aData: IControllable);
 end;//MControlledObjectService
 *)

 IControlledObjectService = interface
  {* ��������� ������� TControlledObjectService }
  procedure AddControlledObject(const aData: IControllable);
  procedure DeleteControlledObject(const aData: IControllable);
 end;//IControlledObjectService

 TControlledObjectService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IControlledObjectService;
    {* ������� ���������� ������� IControlledObjectService }
  protected
   procedure pm_SetAlien(const aValue: IControlledObjectService);
   procedure ClearFields; override;
  public
   procedure AddControlledObject(const aData: IControllable);
   procedure DeleteControlledObject(const aData: IControllable);
   class function Instance: TControlledObjectService;
    {* ����� ��������� ���������� ���������� TControlledObjectService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IControlledObjectService
    write pm_SetAlien;
    {* ������� ���������� ������� IControlledObjectService }
 end;//TControlledObjectService

 (*
 MRubricatorOpenService = interface
  {* �������� ������� TRubricatorOpenService }
  procedure OpenRubricator(const aNode: Il3SimpleNode;
   const aRootToKeep: INodeBase;
   const aMenuSectionItemToKeep: ISectionItem;
   aNeedsSheet: Boolean;
   const anAggregate: IvcmAggregate;
   const aContainer: IvcmContainer);
 end;//MRubricatorOpenService
 *)

 IRubricatorOpenService = interface
  {* ��������� ������� TRubricatorOpenService }
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
    {* ������� ���������� ������� IRubricatorOpenService }
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
    {* ����� ��������� ���������� ���������� TRubricatorOpenService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IRubricatorOpenService
    write pm_SetAlien;
    {* ������� ���������� ������� IRubricatorOpenService }
 end;//TRubricatorOpenService

 (*
 MMainMenuOpenService = interface
  {* �������� ������� TMainMenuOpenService }
  procedure OpenMainMenuIfNeeded(const aContainer: IvcmContainer);
 end;//MMainMenuOpenService
 *)

 IMainMenuOpenService = interface
  {* ��������� ������� TMainMenuOpenService }
  procedure OpenMainMenuIfNeeded(const aContainer: IvcmContainer);
 end;//IMainMenuOpenService

 TMainMenuOpenService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IMainMenuOpenService;
    {* ������� ���������� ������� IMainMenuOpenService }
  protected
   procedure pm_SetAlien(const aValue: IMainMenuOpenService);
   procedure ClearFields; override;
  public
   procedure OpenMainMenuIfNeeded(const aContainer: IvcmContainer);
   class function Instance: TMainMenuOpenService;
    {* ����� ��������� ���������� ���������� TMainMenuOpenService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IMainMenuOpenService
    write pm_SetAlien;
    {* ������� ���������� ������� IMainMenuOpenService }
 end;//TMainMenuOpenService

 (*
 MCommonService = interface
  {* �������� ������� TCommonService }
  procedure About;
   {* ������� ������ "� ���������" }
  procedure AddDocumentToControl(const aDocument: IDocument);
   {* ��������� �������� �� �������� }
  procedure AddToControl(const aControllable: IControllable);
   {* ��������� ������ �� �������� }
  procedure ApplicationActivate;
  procedure CloseNavigator(const aContainer: IvcmContainer);
  procedure CloseTasksPanel(const aContainer: IvcmContainer);
  procedure DeleteDocumentFromControl(const aDocument: IDocument);
   {* ����� �������� � �������� }
  procedure DeleteFromControl(const aControllable: IControllable);
   {* ����� ������ � �������� }
  procedure FromPrinterSettings(const aPrinter: Il3Printer);
   {* ������� ��������� �� �������� }
  function GetCurEditionDate(const aDocument: IDocument): AdapterDate;
  procedure GetNavigator(const anAggregate: IvcmAggregate;
   const aContainer: IvcmContainer);
   {* ���� (�������) }
  function IsCurEditionActual(const aState: IDocumentState): Boolean; overload;
  function IsCurEditionActual(const aDocument: IDocument): Boolean; overload;
  function IsUnderControl(const aDoc: IDocument): Boolean;
   {* ��������� �� �������� �� �������� }
  procedure OpenNewDocs(const aContainer: IvcmContainer);
  procedure OpenRubricatorOnStart(const aContainer: IvcmContainer);
  procedure OpenTasksPanel(const aContainer: IvcmContainer);
  procedure ToPrinterSettings(const aPrinter: Il3Printer);
   {* �������� ��������� � ������� }
  function MakeProgressIndicator(const aProgress: InsProgressIndicator;
   const aCaption: Il3CString;
   aMaxCount: Integer): IvcmEntityForm;
  function OpenTurnOffTimeMachine(const anIntf: InsTurnOffTimeMachine): IvcmEntityForm;
 end;//MCommonService
 *)

 ICommonService = interface
  {* ��������� ������� TCommonService }
  procedure About;
   {* ������� ������ "� ���������" }
  procedure AddDocumentToControl(const aDocument: IDocument);
   {* ��������� �������� �� �������� }
  procedure AddToControl(const aControllable: IControllable);
   {* ��������� ������ �� �������� }
  procedure ApplicationActivate;
  procedure CloseNavigator(const aContainer: IvcmContainer);
  procedure CloseTasksPanel(const aContainer: IvcmContainer);
  procedure DeleteDocumentFromControl(const aDocument: IDocument);
   {* ����� �������� � �������� }
  procedure DeleteFromControl(const aControllable: IControllable);
   {* ����� ������ � �������� }
  procedure FromPrinterSettings(const aPrinter: Il3Printer);
   {* ������� ��������� �� �������� }
  function GetCurEditionDate(const aDocument: IDocument): AdapterDate;
  procedure GetNavigator(const anAggregate: IvcmAggregate;
   const aContainer: IvcmContainer);
   {* ���� (�������) }
  function IsCurEditionActual(const aState: IDocumentState): Boolean; overload;
  function IsCurEditionActual(const aDocument: IDocument): Boolean; overload;
  function IsUnderControl(const aDoc: IDocument): Boolean;
   {* ��������� �� �������� �� �������� }
  procedure OpenNewDocs(const aContainer: IvcmContainer);
  procedure OpenRubricatorOnStart(const aContainer: IvcmContainer);
  procedure OpenTasksPanel(const aContainer: IvcmContainer);
  procedure ToPrinterSettings(const aPrinter: Il3Printer);
   {* �������� ��������� � ������� }
  function MakeProgressIndicator(const aProgress: InsProgressIndicator;
   const aCaption: Il3CString;
   aMaxCount: Integer): IvcmEntityForm;
  function OpenTurnOffTimeMachine(const anIntf: InsTurnOffTimeMachine): IvcmEntityForm;
 end;//ICommonService

 TCommonService = {final} class(Tl3ProtoObject)
  private
   f_Alien: ICommonService;
    {* ������� ���������� ������� ICommonService }
  protected
   procedure pm_SetAlien(const aValue: ICommonService);
   procedure ClearFields; override;
  public
   procedure About;
    {* ������� ������ "� ���������" }
   procedure AddDocumentToControl(const aDocument: IDocument);
    {* ��������� �������� �� �������� }
   procedure AddToControl(const aControllable: IControllable);
    {* ��������� ������ �� �������� }
   procedure ApplicationActivate;
   procedure CloseNavigator(const aContainer: IvcmContainer);
   procedure CloseTasksPanel(const aContainer: IvcmContainer);
   procedure DeleteDocumentFromControl(const aDocument: IDocument);
    {* ����� �������� � �������� }
   procedure DeleteFromControl(const aControllable: IControllable);
    {* ����� ������ � �������� }
   procedure FromPrinterSettings(const aPrinter: Il3Printer);
    {* ������� ��������� �� �������� }
   function GetCurEditionDate(const aDocument: IDocument): AdapterDate;
   procedure GetNavigator(const anAggregate: IvcmAggregate;
    const aContainer: IvcmContainer);
    {* ���� (�������) }
   function IsCurEditionActual(const aState: IDocumentState): Boolean; overload;
   function IsCurEditionActual(const aDocument: IDocument): Boolean; overload;
   function IsUnderControl(const aDoc: IDocument): Boolean;
    {* ��������� �� �������� �� �������� }
   procedure OpenNewDocs(const aContainer: IvcmContainer);
   procedure OpenRubricatorOnStart(const aContainer: IvcmContainer);
   procedure OpenTasksPanel(const aContainer: IvcmContainer);
   procedure ToPrinterSettings(const aPrinter: Il3Printer);
    {* �������� ��������� � ������� }
   function MakeProgressIndicator(const aProgress: InsProgressIndicator;
    const aCaption: Il3CString;
    aMaxCount: Integer): IvcmEntityForm;
   function OpenTurnOffTimeMachine(const anIntf: InsTurnOffTimeMachine): IvcmEntityForm;
   class function Instance: TCommonService;
    {* ����� ��������� ���������� ���������� TCommonService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: ICommonService
    write pm_SetAlien;
    {* ������� ���������� ������� ICommonService }
 end;//TCommonService

 (*
 MInpharmOperations = interface
  {* �������� ������� TInpharmOperations }
 end;//MInpharmOperations
 *)

 IInpharmOperations = interface
  {* ��������� ������� TInpharmOperations }
 end;//IInpharmOperations

 TInpharmOperations = {final} class(Tl3ProtoObject)
  private
   f_Alien: IInpharmOperations;
    {* ������� ���������� ������� IInpharmOperations }
  protected
   procedure pm_SetAlien(const aValue: IInpharmOperations);
   procedure ClearFields; override;
  public
   class function Instance: TInpharmOperations;
    {* ����� ��������� ���������� ���������� TInpharmOperations }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IInpharmOperations
    write pm_SetAlien;
    {* ������� ���������� ������� IInpharmOperations }
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
 {* ��������� ���������� TDocumentOpenService }
var g_TListOpenService: TListOpenService = nil;
 {* ��������� ���������� TListOpenService }
var g_TControlledObjectService: TControlledObjectService = nil;
 {* ��������� ���������� TControlledObjectService }
var g_TRubricatorOpenService: TRubricatorOpenService = nil;
 {* ��������� ���������� TRubricatorOpenService }
var g_TMainMenuOpenService: TMainMenuOpenService = nil;
 {* ��������� ���������� TMainMenuOpenService }
var g_TCommonService: TCommonService = nil;
 {* ��������� ���������� TCommonService }
var g_TInpharmOperations: TInpharmOperations = nil;
 {* ��������� ���������� TInpharmOperations }

procedure TDocumentOpenServiceFree;
 {* ����� ������������ ���������� ���������� TDocumentOpenService }
begin
 l3Free(g_TDocumentOpenService);
end;//TDocumentOpenServiceFree

procedure TListOpenServiceFree;
 {* ����� ������������ ���������� ���������� TListOpenService }
begin
 l3Free(g_TListOpenService);
end;//TListOpenServiceFree

procedure TControlledObjectServiceFree;
 {* ����� ������������ ���������� ���������� TControlledObjectService }
begin
 l3Free(g_TControlledObjectService);
end;//TControlledObjectServiceFree

procedure TRubricatorOpenServiceFree;
 {* ����� ������������ ���������� ���������� TRubricatorOpenService }
begin
 l3Free(g_TRubricatorOpenService);
end;//TRubricatorOpenServiceFree

procedure TMainMenuOpenServiceFree;
 {* ����� ������������ ���������� ���������� TMainMenuOpenService }
begin
 l3Free(g_TMainMenuOpenService);
end;//TMainMenuOpenServiceFree

procedure TCommonServiceFree;
 {* ����� ������������ ���������� ���������� TCommonService }
begin
 l3Free(g_TCommonService);
end;//TCommonServiceFree

procedure TInpharmOperationsFree;
 {* ����� ������������ ���������� ���������� TInpharmOperations }
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
 {* ����� ��������� ���������� ���������� TDocumentOpenService }
begin
 if (g_TDocumentOpenService = nil) then
 begin
  l3System.AddExitProc(TDocumentOpenServiceFree);
  g_TDocumentOpenService := Create;
 end;
 Result := g_TDocumentOpenService;
end;//TDocumentOpenService.Instance

class function TDocumentOpenService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
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
 {* ����� ��������� ���������� ���������� TListOpenService }
begin
 if (g_TListOpenService = nil) then
 begin
  l3System.AddExitProc(TListOpenServiceFree);
  g_TListOpenService := Create;
 end;
 Result := g_TListOpenService;
end;//TListOpenService.Instance

class function TListOpenService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
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
 {* ����� ��������� ���������� ���������� TControlledObjectService }
begin
 if (g_TControlledObjectService = nil) then
 begin
  l3System.AddExitProc(TControlledObjectServiceFree);
  g_TControlledObjectService := Create;
 end;
 Result := g_TControlledObjectService;
end;//TControlledObjectService.Instance

class function TControlledObjectService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
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
 {* ����� ��������� ���������� ���������� TRubricatorOpenService }
begin
 if (g_TRubricatorOpenService = nil) then
 begin
  l3System.AddExitProc(TRubricatorOpenServiceFree);
  g_TRubricatorOpenService := Create;
 end;
 Result := g_TRubricatorOpenService;
end;//TRubricatorOpenService.Instance

class function TRubricatorOpenService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
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
 {* ����� ��������� ���������� ���������� TMainMenuOpenService }
begin
 if (g_TMainMenuOpenService = nil) then
 begin
  l3System.AddExitProc(TMainMenuOpenServiceFree);
  g_TMainMenuOpenService := Create;
 end;
 Result := g_TMainMenuOpenService;
end;//TMainMenuOpenService.Instance

class function TMainMenuOpenService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
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
 {* ������� ������ "� ���������" }
begin
 if (f_Alien <> nil) then
  f_Alien.About;
end;//TCommonService.About

procedure TCommonService.AddDocumentToControl(const aDocument: IDocument);
 {* ��������� �������� �� �������� }
begin
 if (f_Alien <> nil) then
  f_Alien.AddDocumentToControl(aDocument);
end;//TCommonService.AddDocumentToControl

procedure TCommonService.AddToControl(const aControllable: IControllable);
 {* ��������� ������ �� �������� }
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
 {* ����� �������� � �������� }
begin
 if (f_Alien <> nil) then
  f_Alien.DeleteDocumentFromControl(aDocument);
end;//TCommonService.DeleteDocumentFromControl

procedure TCommonService.DeleteFromControl(const aControllable: IControllable);
 {* ����� ������ � �������� }
begin
 if (f_Alien <> nil) then
  f_Alien.DeleteFromControl(aControllable);
end;//TCommonService.DeleteFromControl

procedure TCommonService.FromPrinterSettings(const aPrinter: Il3Printer);
 {* ������� ��������� �� �������� }
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
 {* ���� (�������) }
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
 {* ��������� �� �������� �� �������� }
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
 {* �������� ��������� � ������� }
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
 {* ����� ��������� ���������� ���������� TCommonService }
begin
 if (g_TCommonService = nil) then
 begin
  l3System.AddExitProc(TCommonServiceFree);
  g_TCommonService := Create;
 end;
 Result := g_TCommonService;
end;//TCommonService.Instance

class function TCommonService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
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
 {* ����� ��������� ���������� ���������� TInpharmOperations }
begin
 if (g_TInpharmOperations = nil) then
 begin
  l3System.AddExitProc(TInpharmOperationsFree);
  g_TInpharmOperations := Create;
 end;
 Result := g_TInpharmOperations;
end;//TInpharmOperations.Instance

class function TInpharmOperations.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
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
