unit VCMCustomization_Customization_Contracts;

// ������: "w:\common\components\gui\Garant\VCM\View\VCMCustomization_Customization_Contracts.pas"
// ���������: "VCMContracts"
// ������� ������: "Customization" MUID: (578E02C50241)

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmTaskPanelInterfaces
 , l3ProtoObject
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
 , vcmExternalInterfaces
;

 (*
 MTaskPanelService = interface
  {* �������� ������� TTaskPanelService }
  procedure CustomizePanel(const aPanel: IvcmCustOps);
   {* ��������� ������ ����������� }
  function TasksPanelPopupMenu: TPopupMenu;
 end;//MTaskPanelService
 *)

type
 ITaskPanelService = interface
  {* ��������� ������� TTaskPanelService }
  procedure CustomizePanel(const aPanel: IvcmCustOps);
   {* ��������� ������ ����������� }
  function TasksPanelPopupMenu: TPopupMenu;
 end;//ITaskPanelService

 TTaskPanelService = {final} class(Tl3ProtoObject)
  private
   f_Alien: ITaskPanelService;
    {* ������� ���������� ������� ITaskPanelService }
  protected
   procedure pm_SetAlien(const aValue: ITaskPanelService);
   procedure ClearFields; override;
  public
   procedure CustomizePanel(const aPanel: IvcmCustOps);
    {* ��������� ������ ����������� }
   function TasksPanelPopupMenu: TPopupMenu;
   class function Instance: TTaskPanelService;
    {* ����� ��������� ���������� ���������� TTaskPanelService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: ITaskPanelService
    write pm_SetAlien;
    {* ������� ���������� ������� ITaskPanelService }
 end;//TTaskPanelService

 (*
 MToolbarMenuService = interface
  {* �������� ������� TToolbarMenuService }
 end;//MToolbarMenuService
 *)

 IToolbarMenuService = interface
  {* ��������� ������� TToolbarMenuService }
 end;//IToolbarMenuService

 TToolbarMenuService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IToolbarMenuService;
    {* ������� ���������� ������� IToolbarMenuService }
  protected
   procedure pm_SetAlien(const aValue: IToolbarMenuService);
   procedure ClearFields; override;
  public
   class function Instance: TToolbarMenuService;
    {* ����� ��������� ���������� ���������� TToolbarMenuService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IToolbarMenuService
    write pm_SetAlien;
    {* ������� ���������� ������� IToolbarMenuService }
 end;//TToolbarMenuService

var mod_opcode_TaskPanelService_Customize: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_ToolbarMenuService_AvailableOperations: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_ToolbarMenuService_Customize: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_ToolbarMenuService_Fasten: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_ToolbarMenuService_IconsSize: TvcmMOPID = (rMoID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmOperationsForRegister
 , vcmOperationStatesForRegister
 , SysUtils
 , l3Base
 , vcmBase
;

var g_TTaskPanelService: TTaskPanelService = nil;
 {* ��������� ���������� TTaskPanelService }
var g_TToolbarMenuService: TToolbarMenuService = nil;
 {* ��������� ���������� TToolbarMenuService }

procedure TTaskPanelServiceFree;
 {* ����� ������������ ���������� ���������� TTaskPanelService }
begin
 l3Free(g_TTaskPanelService);
end;//TTaskPanelServiceFree

procedure TToolbarMenuServiceFree;
 {* ����� ������������ ���������� ���������� TToolbarMenuService }
begin
 l3Free(g_TToolbarMenuService);
end;//TToolbarMenuServiceFree

procedure TTaskPanelService.pm_SetAlien(const aValue: ITaskPanelService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TTaskPanelService.pm_SetAlien

procedure TTaskPanelService.CustomizePanel(const aPanel: IvcmCustOps);
 {* ��������� ������ ����������� }
begin
 if (f_Alien <> nil) then
  f_Alien.CustomizePanel(aPanel);
end;//TTaskPanelService.CustomizePanel

function TTaskPanelService.TasksPanelPopupMenu: TPopupMenu;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.TasksPanelPopupMenu
 else
 begin
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TTaskPanelService.TasksPanelPopupMenu

class function TTaskPanelService.Instance: TTaskPanelService;
 {* ����� ��������� ���������� ���������� TTaskPanelService }
begin
 if (g_TTaskPanelService = nil) then
 begin
  l3System.AddExitProc(TTaskPanelServiceFree);
  g_TTaskPanelService := Create;
 end;
 Result := g_TTaskPanelService;
end;//TTaskPanelService.Instance

class function TTaskPanelService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TTaskPanelService <> nil;
end;//TTaskPanelService.Exists

procedure TTaskPanelService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TTaskPanelService.ClearFields

procedure TToolbarMenuService.pm_SetAlien(const aValue: IToolbarMenuService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TToolbarMenuService.pm_SetAlien

class function TToolbarMenuService.Instance: TToolbarMenuService;
 {* ����� ��������� ���������� ���������� TToolbarMenuService }
begin
 if (g_TToolbarMenuService = nil) then
 begin
  l3System.AddExitProc(TToolbarMenuServiceFree);
  g_TToolbarMenuService := Create;
 end;
 Result := g_TToolbarMenuService;
end;//TToolbarMenuService.Instance

class function TToolbarMenuService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TToolbarMenuService <> nil;
end;//TToolbarMenuService.Exists

procedure TToolbarMenuService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TToolbarMenuService.ClearFields

initialization
{$IfEnd} // NOT Defined(NoVCM)

end.
