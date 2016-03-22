unit NOT_FINISHED_vcmBaseOperationsCollectionItem;

// ������: "w:\common\components\gui\Garant\VCM\implementation\Components\NOT_FINISHED_vcmBaseOperationsCollectionItem.pas"
// ���������: "SimpleClass"
// ������� ������: "TvcmBaseOperationsCollectionItem" MUID: (4D7A109601C2)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmExternalInterfaces
 , vcmInterfaces
 , vcmBase
 , vcmOperationParams
 , vcmUserControls
 , vcmBaseOperationStates
 , vcmActiveControlsCollection
 , Classes
 , vcmBaseOperationState
 , vcmAction
 {$If NOT Defined(NoVCL)}
 , ActnList
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If Defined(XE)}
 , Actions
 {$IfEnd} // Defined(XE)
;

const
 vcm_DefaultOperationOptions = [vcm_ooShowInMainToolbar, vcm_ooShowInChildToolbar, vcm_ooShowInContextMenu, vcm_ooShowInMainMenu, vcm_ooShowInChildMenu];
  {* ����� ���������� �� ��������� ��� ������� TvcmOperationsCollectionItem.Options }

type
 TvcmGetStateEvent = procedure(var State: TvcmOperationStateIndex) of object;

 TvcmContextTestEvent = TvcmTestEvent;
  {* ���������� � ������ �������� ����������� �������� �� ������������ ���� }

 TvcmContextExecuteEvent = TvcmExecuteEvent;
  {* ���������� ��� ���������� �������� �� ������������ ���� }

 TvcmHandleType = (
  vcm_htContext
  , vcm_htGlobal
  , vcm_htControl
 );//TvcmHandleType

 TvcmHandleTypes = set of TvcmHandleType;

 TvcmBaseOperationsCollectionItemPrim = class(TvcmOperationParams)
  private
   f_GroupID: Integer;
   f_Enabled: Boolean;
   f_VisibleToUser: Integer;
   f_OpDef: IvcmOperationDef;
   f_FormGetState: TvcmControlGetStateEvent;
   f_FormTest: TvcmControlTestEvent;
   f_FormExecute: TvcmControlExecuteEvent;
   f_OperationType: TvcmOperationType;
    {* ���� ��� �������� OperationType }
   f_ContextMenuWeight: Integer;
    {* ���� ��� �������� ContextMenuWeight }
   f_OperationID: Integer;
    {* ���� ��� �������� OperationID }
   f_AutoLock: Boolean;
    {* ���� ��� �������� AutoLock }
   f_AutoFocus: Boolean;
    {* ���� ��� �������� AutoFocus }
   f_LongProcess: Boolean;
    {* ���� ��� �������� LongProcess }
   f_States: TvcmBaseOperationStates;
    {* ���� ��� �������� States }
   f_State: TvcmOperationStateIndex;
    {* ���� ��� �������� State }
   f_Controls: TvcmActiveControlsCollection;
    {* ���� ��� �������� Controls }
   f_OnGetState: TvcmGetStateEvent;
    {* ���� ��� �������� OnGetState }
   f_OnTest: TvcmTestEvent;
    {* ���� ��� �������� OnTest }
   f_OnExecute: TvcmExecuteEvent;
    {* ���� ��� �������� OnExecute }
   f_OnContextTest: TvcmContextTestEvent;
    {* ���� ��� �������� OnContextTest }
   f_OnContextExecute: TvcmContextExecuteEvent;
    {* ���� ��� �������� OnContextExecute }
   f_IsCaptionUnique: Boolean;
    {* ���� ��� �������� IsCaptionUnique }
   f_SaveShortcut: TShortCut;
    {* ���� ��� �������� SaveShortcut }
   f_SaveSecondaryShortcuts: AnsiString;
    {* ���� ��� �������� SaveSecondaryShortcuts }
   f_IsDefault: Boolean;
    {* ���� ��� �������� IsDefault }
  protected
   f_Options: TvcmOperationOptions;
  protected
   function pm_GetOperationType: TvcmOperationType; virtual;
   procedure pm_SetOperationType(aValue: TvcmOperationType); virtual;
   function pm_GetOptions: TvcmOperationOptions; virtual;
   procedure pm_SetOptions(aValue: TvcmOperationOptions); virtual;
   function pm_GetContextMenuWeight: Integer;
   procedure pm_SetContextMenuWeight(aValue: Integer);
   function pm_GetStates: TvcmBaseOperationStates; virtual;
   procedure pm_SetStates(aValue: TvcmBaseOperationStates); virtual;
   procedure pm_SetState(const aValue: TvcmOperationStateIndex);
   function pm_GetIsDefault: Boolean; virtual;
   procedure pm_SetIsDefault(aValue: Boolean); virtual;
   function pm_GetVisibleToUser: Boolean;
   function pm_GetOperationDef: IvcmOperationDef;
   {$If NOT Defined(DesignTimeLibrary)}
   function pm_GetCategory: AnsiString; virtual;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   function pm_GetGroupID: Integer; virtual;
   procedure pm_SetGroupID(aValue: Integer); virtual;
   function pm_GetExcludeUserTypes: TvcmEffectiveUserTypes; virtual;
   procedure pm_SetExcludeUserTypes(aValue: TvcmEffectiveUserTypes); virtual;
   function pm_GetCurrentState: TvcmBaseOperationState;
   function pm_GetLinked: Boolean; virtual;
   procedure pm_SetLinked(aValue: Boolean); virtual;
   function GetDefaultOptions: TvcmOperationOptions; virtual;
   function GetGroupIDStored: Boolean; virtual;
   function GetOperationTypeStored: Boolean; virtual;
   function GetIsDefaultStored: Boolean; virtual;
   procedure OnSecondaryShortCutsChange(Sender: TObject);
   function IsHandledToControl: Boolean;
    {* �������� ������������ ����������� }
   function GetLinkedAction: TvcmAction;
    {* Action � �������� ��������� �������� }
   function ControllerCommand: Word;
    {* ������������� ��������-shortcut }
   function ParentID: Integer;
   function IsLinkedToModule: Boolean;
   class procedure ResetShortCutHandler(var aValue: TShortCut;
    aCommandID: Word = 0);
   procedure DoFormGetState(var State: TvcmOperationStateIndex);
   procedure DoFormTest(const aParams: IvcmTestParamsPrim);
   procedure DoFormExecute(const aParams: IvcmExecuteParams);
   procedure FakeControlTest(const aParams: IvcmTestParamsPrim);
   procedure ClearOp;
   procedure SetShortCuts(aShortCut: TShortCut;
    aSecondaryShortCuts: TShortCutList); virtual;
   class function StatesClass: RvcmBaseOperationStates; virtual;
   function OwnerUserType: TvcmEffectiveUserType;
    {* ���������� ���������������� ��� "�����" �� ������� ���������� �������� }
   function OperationTypeStored: Boolean;
    {* "������� ������������, ��� �������� OperationType �����������" }
   function IsDefaultStored: Boolean;
    {* "������� ������������, ��� �������� IsDefault �����������" }
   function GroupIDStored: Boolean;
    {* "������� ������������, ��� �������� GroupID �����������" }
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure BeforeAddToCache; override;
    {* �������, ���������� ����� ����������� ������� � ��� ���������� �������������. }
   procedure ClearFields; override;
   procedure ChangeName(const anOld: AnsiString;
    const aNew: AnsiString); override;
   procedure ChangeCaption(const anOld: AnsiString;
    const aNew: AnsiString); override;
  public
   function OwnerForm: TCustomForm;
    {* ���������� "�����" �� ������� ���������� �������� }
   {$If Defined(XE)}
   procedure ReplaceShortCuts(aShortCut: TShortCut;
    aSecondaryShortCuts: TCustomShortCutList); overload;
   {$IfEnd} // Defined(XE)
   {$If NOT Defined(XE)}
   procedure ReplaceShortCuts(aShortCut: TShortCut;
    aSecondaryShortCuts: TShortCutList); overload;
   {$IfEnd} // NOT Defined(XE)
   procedure StoreDesignTimeShortcuts;
   function SomePropStored: Boolean;
   procedure RemoveShortCut(aShortCut: TShortCut); virtual;
   procedure UnlinkControl(aControl: TComponent);
   function Handled(aTypes: TvcmHandleTypes): Boolean; virtual;
   procedure Operation(aControl: TComponent;
    const aTarget: IUnknown;
    aMode: TvcmOperationMode;
    const aParams: IvcmParams;
    aForce: Boolean);
    {* ���������� �������� }
   procedure PublishOp(aControl: TComponent;
    anExecute: TvcmControlExecuteEvent;
    aTest: TvcmControlTestEvent;
    aGetState: TvcmControlGetStateEvent); overload;
    {* ������������ �������� }
   procedure PublishOp(aControl: TComponent;
    anExecute: TvcmExecuteEvent;
    aTest: TvcmControlTestEvent;
    aGetState: TvcmControlGetStateEvent); overload;
    {* ������������ �������� }
   procedure Assign(Source: TPersistent); override;
   constructor Create(aCollection: TCollection); override;
   function MakeID(const aName: AnsiString): Integer; override;
   function GetID: Integer; override;
   function QueryInterface(const IID: TGUID;
    out Obj): HResult; override;
  public
   property OperationType: TvcmOperationType
    read pm_GetOperationType
    write pm_SetOperationType
    stored OperationTypeStored;
   property Options: TvcmOperationOptions
    read pm_GetOptions
    write pm_SetOptions;
   property ContextMenuWeight: Integer
    read pm_GetContextMenuWeight
    write pm_SetContextMenuWeight;
   property OperationID: Integer
    read f_OperationID;
   property AutoLock: Boolean
    read f_AutoLock
    write f_AutoLock;
   property AutoFocus: Boolean
    read f_AutoFocus
    write f_AutoFocus;
    {* ��������� ������ �� ���������� ��������.

���� AutoFocus = True, ����� ����������� ��������, ����� ��������� ����� ��� ��������, � ������� ������� ��� �������� }
   property LongProcess: Boolean
    read f_LongProcess
    write f_LongProcess;
    {* ���������� ���������� �������� �������� crHourGlass. ����� ������ ��� ���������� ���������� (vcm_otInternal) ��������, �.�. ��� ������ ����� Action � ��� ��������� �������� �������.

���� LongProcess = True, ����� ����������� �������� ������ ���������� �� crHourGlass, � ����� ���������� ������������ � ��������������� ���� }
   property States: TvcmBaseOperationStates
    read pm_GetStates
    write pm_SetStates;
   property State: TvcmOperationStateIndex
    read f_State
    write pm_SetState;
   property Controls: TvcmActiveControlsCollection
    read f_Controls;
   property OnGetState: TvcmGetStateEvent
    read f_OnGetState
    write f_OnGetState;
   property OnTest: TvcmTestEvent
    read f_OnTest
    write f_OnTest;
    {* ���������� ��� ����������� ��������� ��������.

������ ���������� ���������� ��� ����������� ����������� ��������. � ������� aParams ����� ������� ���������� ���������.

������ ���������   ���        ��������
-----------------  ---------  --------------------------------
vcm_opEnabled      Boolean    ����������� ���������� ��������
vcm_opVisible      Boolean    ��������� �������� � ���� � �� ������ ������������
vcm_opChecked      Boolean    �������� ��������
vcm_opLongHint     AnsiString     ����� ���������, ������������ � ��������� ������
vcm_opCaption      AnsiString     ��������� ������ ����

��� ���� �������� vcm_otCombo � aParams.Op.SubItems ����� ������� ������ �����, �������������� ������ ��������� ����������� ������. }
   property OnExecute: TvcmExecuteEvent
    read f_OnExecute
    write f_OnExecute;
    {* ���������� ��������. ���������� �� ���� ������� ����� ��� ������ ������������. }
   property OnContextTest: TvcmContextTestEvent
    read f_OnContextTest
    write f_OnContextTest;
    {* ���������� �� ������������ ����.
          
������ ���������� ���������� ��� ����������� ����������� ��������. � ������� aParams ����� ������� ���������� ���������.

������ ���������   ���        ��������
-----------------  ---------  --------------------------------
vcm_opEnabled      Boolean    ����������� ���������� ��������
vcm_opVisible      Boolean    ��������� �������� � ���� � �� ������ ������������
vcm_opChecked      Boolean    �������� ��������
vcm_opLongHint     AnsiString     ����� ���������, ������������ � ��������� ������
vcm_opCaption      AnsiString     ��������� ������ ����

��� ���� �������� vcm_otCombo � aParams.Op.SubItems ����� ������� ������ �����, �������������� ������ ��������� ����������� ������. }
   property OnContextExecute: TvcmContextExecuteEvent
    read f_OnContextExecute
    write f_OnContextExecute;
    {* ���������� ��������. ���������� �� ������������ ����. }
   property IsCaptionUnique: Boolean
    read f_IsCaptionUnique
    write f_IsCaptionUnique;
   property SaveShortcut: TShortCut
    read f_SaveShortcut;
   property SaveSecondaryShortcuts: AnsiString
    read f_SaveSecondaryShortcuts;
   property IsDefault: Boolean
    read pm_GetIsDefault
    write pm_SetIsDefault
    stored IsDefaultStored;
   property VisibleToUser: Boolean
    read pm_GetVisibleToUser;
   property OperationDef: IvcmOperationDef
    read pm_GetOperationDef;
    {* ��������� �������� }
   {$If NOT Defined(DesignTimeLibrary)}
   property Category: AnsiString
    read pm_GetCategory;
    {* ��������� ��������.
�������� �� ������ �������������� �����. ������������ ��� ����������� ��������. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   property GroupID: Integer
    read pm_GetGroupID
    write pm_SetGroupID
    stored GroupIDStored;
   property ExcludeUserTypes: TvcmEffectiveUserTypes
    read pm_GetExcludeUserTypes
    write pm_SetExcludeUserTypes;
   property CurrentState: TvcmBaseOperationState
    read pm_GetCurrentState;
   property Linked: Boolean
    read pm_GetLinked
    write pm_SetLinked;
 end;//TvcmBaseOperationsCollectionItemPrim

 //#UC START# *4D7A109601C2ci*
 //#UC END# *4D7A109601C2ci*
 //#UC START# *4D7A109601C2cit*
 //#UC END# *4D7A109601C2cit*
 TvcmBaseOperationsCollectionItem = class(TvcmBaseOperationsCollectionItemPrim)
 //#UC START# *4D7A109601C2publ*
 //#UC END# *4D7A109601C2publ*
 end;//TvcmBaseOperationsCollectionItem
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmInternalConst
 , vcmEntitiesCollectionItem
 , OvcCmd
 , OvcController
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
 , vcmModulesCollectionItem
 , vcmBaseEntitiesCollectionItem
 , vcmModuleDef
 , vcmOVCCommands
 , vcmModuleAction
 , vcmEntityAction
 , afwFacade
 , l3Types
 , vcmActiveControlsCollectionItem
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , TypInfo
 , vcmBaseOperationDef
 , vcmUtils
 , vcmRepositoryEx
 , vcmModule
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

function TvcmBaseOperationsCollectionItemPrim.pm_GetOperationType: TvcmOperationType;
//#UC START# *5620CEB201FB_5620CFFC0045get_var*
//#UC END# *5620CEB201FB_5620CFFC0045get_var*
begin
//#UC START# *5620CEB201FB_5620CFFC0045get_impl*
 Result := f_OperationType;
//#UC END# *5620CEB201FB_5620CFFC0045get_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_GetOperationType

procedure TvcmBaseOperationsCollectionItemPrim.pm_SetOperationType(aValue: TvcmOperationType);
//#UC START# *5620CEB201FB_5620CFFC0045set_var*
//#UC END# *5620CEB201FB_5620CFFC0045set_var*
begin
//#UC START# *5620CEB201FB_5620CFFC0045set_impl*
 f_OperationType := aValue;
//#UC END# *5620CEB201FB_5620CFFC0045set_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_SetOperationType

function TvcmBaseOperationsCollectionItemPrim.pm_GetOptions: TvcmOperationOptions;
//#UC START# *5620CF2802E3_5620CFFC0045get_var*
//#UC END# *5620CF2802E3_5620CFFC0045get_var*
begin
//#UC START# *5620CF2802E3_5620CFFC0045get_impl*
 if (f_Options = []) then
 begin
  Result := GetDefaultOptions;
  {$IfNDef DesignTimeLibrary}
  f_Options := Result;
  {$EndIf  DesignTimeLibrary}
 end//f_Options = []
 else
  Result := f_Options;
//#UC END# *5620CF2802E3_5620CFFC0045get_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_GetOptions

procedure TvcmBaseOperationsCollectionItemPrim.pm_SetOptions(aValue: TvcmOperationOptions);
//#UC START# *5620CF2802E3_5620CFFC0045set_var*
//#UC END# *5620CF2802E3_5620CFFC0045set_var*
begin
//#UC START# *5620CF2802E3_5620CFFC0045set_impl*
 if (Options <> aValue) then
 begin
  if (OperationType in vcm_HiddenOperations) then
   if (aValue <> []) then
    Exit;
  f_Options := aValue;
 end;//Options <> aValue
//#UC END# *5620CF2802E3_5620CFFC0045set_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_SetOptions

function TvcmBaseOperationsCollectionItemPrim.pm_GetContextMenuWeight: Integer;
//#UC START# *5620CF82017C_5620CFFC0045get_var*
//#UC END# *5620CF82017C_5620CFFC0045get_var*
begin
//#UC START# *5620CF82017C_5620CFFC0045get_impl*
 Result := f_ContextMenuWeight;
//#UC END# *5620CF82017C_5620CFFC0045get_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_GetContextMenuWeight

procedure TvcmBaseOperationsCollectionItemPrim.pm_SetContextMenuWeight(aValue: Integer);
//#UC START# *5620CF82017C_5620CFFC0045set_var*
//#UC END# *5620CF82017C_5620CFFC0045set_var*
begin
//#UC START# *5620CF82017C_5620CFFC0045set_impl*
 f_ContextMenuWeight := aValue;
//#UC END# *5620CF82017C_5620CFFC0045set_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_SetContextMenuWeight

function TvcmBaseOperationsCollectionItemPrim.pm_GetStates: TvcmBaseOperationStates;
//#UC START# *5620D26602B5_5620CFFC0045get_var*
//#UC END# *5620D26602B5_5620CFFC0045get_var*
begin
//#UC START# *5620D26602B5_5620CFFC0045get_impl*
 Result := f_States;
//#UC END# *5620D26602B5_5620CFFC0045get_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_GetStates

procedure TvcmBaseOperationsCollectionItemPrim.pm_SetStates(aValue: TvcmBaseOperationStates);
//#UC START# *5620D26602B5_5620CFFC0045set_var*
//#UC END# *5620D26602B5_5620CFFC0045set_var*
begin
//#UC START# *5620D26602B5_5620CFFC0045set_impl*
 States.Assign(aValue);
//#UC END# *5620D26602B5_5620CFFC0045set_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_SetStates

procedure TvcmBaseOperationsCollectionItemPrim.pm_SetState(const aValue: TvcmOperationStateIndex);
//#UC START# *5620D2A101D3_5620CFFC0045set_var*
//#UC END# *5620D2A101D3_5620CFFC0045set_var*
begin
//#UC START# *5620D2A101D3_5620CFFC0045set_impl*
 if (f_State.rID <> aValue.rID) then
 begin
  if (aValue.rID >= vcm_DefaultOperationState.rID) AND (aValue.rID < States.Count) then
  begin
   f_State := aValue;
  end;//aValue >= vcm_DefaultOperationState..
 end;//f_State <> aValue
//#UC END# *5620D2A101D3_5620CFFC0045set_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_SetState

function TvcmBaseOperationsCollectionItemPrim.pm_GetIsDefault: Boolean;
//#UC START# *5620D7470392_5620CFFC0045get_var*
//#UC END# *5620D7470392_5620CFFC0045get_var*
begin
//#UC START# *5620D7470392_5620CFFC0045get_impl*
 Result := f_IsDefault;
//#UC END# *5620D7470392_5620CFFC0045get_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_GetIsDefault

procedure TvcmBaseOperationsCollectionItemPrim.pm_SetIsDefault(aValue: Boolean);
//#UC START# *5620D7470392_5620CFFC0045set_var*
//#UC END# *5620D7470392_5620CFFC0045set_var*
begin
//#UC START# *5620D7470392_5620CFFC0045set_impl*
 f_IsDefault := aValue;
//#UC END# *5620D7470392_5620CFFC0045set_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_SetIsDefault

function TvcmBaseOperationsCollectionItemPrim.pm_GetVisibleToUser: Boolean;
//#UC START# *5620E01800F3_5620CFFC0045get_var*
//#UC END# *5620E01800F3_5620CFFC0045get_var*
begin
//#UC START# *5620E01800F3_5620CFFC0045get_impl*
 if f_VisibleToUser = -1 then
  if (Caption <> '') AND
     (OperationType in vcmToolbarOpTypes) then
   f_VisibleToUser := 1
  else
   f_VisibleToUser := 0;
 Result := f_VisibleToUser > 0;
//#UC END# *5620E01800F3_5620CFFC0045get_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_GetVisibleToUser

function TvcmBaseOperationsCollectionItemPrim.pm_GetOperationDef: IvcmOperationDef;
//#UC START# *5620E17102F2_5620CFFC0045get_var*
//#UC END# *5620E17102F2_5620CFFC0045get_var*
begin
//#UC START# *5620E17102F2_5620CFFC0045get_impl*
 if (Name = '') then
  // - ����� ���� - ������ �� �������� ������ ��������������� ���� ������� ������
  Result := nil
 else
 begin
  if (f_OpDef = nil) then
   f_OpDef := TvcmBaseOperationDef.Make(Self);
  Result := f_OpDef;
 end;//Name = ''
//#UC END# *5620E17102F2_5620CFFC0045get_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_GetOperationDef

{$If NOT Defined(DesignTimeLibrary)}
function TvcmBaseOperationsCollectionItemPrim.pm_GetCategory: AnsiString;
//#UC START# *5620E23201F0_5620CFFC0045get_var*
var
 l_Collection: TCollection;
 l_Owner: TPersistent;
//#UC END# *5620E23201F0_5620CFFC0045get_var*
begin
//#UC START# *5620E23201F0_5620CFFC0045get_impl*
 Result := '';
 l_Collection := Collection;
 if (l_Collection <> nil) then
 begin
  l_Owner := l_Collection.Owner;
  if (l_Owner <> nil) then
  begin
   if (GetPropInfo(l_Owner, 'Caption') <> nil) then
    Result := GetStrProp(l_Owner, 'Caption')
   else
   if (l_Owner Is TvcmCustomModuleDef) then
    Result := vcmStr(TvcmCustomModuleDef(l_Owner).ModuleDef.Caption);
  end;//l_Owner <> nil
 end;//l_Collection <> nil
//#UC END# *5620E23201F0_5620CFFC0045get_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_GetCategory
{$IfEnd} // NOT Defined(DesignTimeLibrary)

function TvcmBaseOperationsCollectionItemPrim.pm_GetGroupID: Integer;
//#UC START# *5620E28E0284_5620CFFC0045get_var*
//#UC END# *5620E28E0284_5620CFFC0045get_var*
begin
//#UC START# *5620E28E0284_5620CFFC0045get_impl*
 Result := f_GroupID;
//#UC END# *5620E28E0284_5620CFFC0045get_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_GetGroupID

procedure TvcmBaseOperationsCollectionItemPrim.pm_SetGroupID(aValue: Integer);
//#UC START# *5620E28E0284_5620CFFC0045set_var*
//#UC END# *5620E28E0284_5620CFFC0045set_var*
begin
//#UC START# *5620E28E0284_5620CFFC0045set_impl*
 f_GroupID := aValue;
//#UC END# *5620E28E0284_5620CFFC0045set_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_SetGroupID

function TvcmBaseOperationsCollectionItemPrim.pm_GetExcludeUserTypes: TvcmEffectiveUserTypes;
//#UC START# *5620E402012B_5620CFFC0045get_var*
//#UC END# *5620E402012B_5620CFFC0045get_var*
begin
//#UC START# *5620E402012B_5620CFFC0045get_impl*
 Result := [];
//#UC END# *5620E402012B_5620CFFC0045get_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_GetExcludeUserTypes

procedure TvcmBaseOperationsCollectionItemPrim.pm_SetExcludeUserTypes(aValue: TvcmEffectiveUserTypes);
//#UC START# *5620E402012B_5620CFFC0045set_var*
//#UC END# *5620E402012B_5620CFFC0045set_var*
begin
//#UC START# *5620E402012B_5620CFFC0045set_impl*
//#UC END# *5620E402012B_5620CFFC0045set_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_SetExcludeUserTypes

function TvcmBaseOperationsCollectionItemPrim.pm_GetCurrentState: TvcmBaseOperationState;
//#UC START# *5620E5640206_5620CFFC0045get_var*
//#UC END# *5620E5640206_5620CFFC0045get_var*
begin
//#UC START# *5620E5640206_5620CFFC0045get_impl*
 if (f_State.rID = vcm_DefaultOperationState.rID) then
  Result := nil
 else
  Result := TvcmBaseOperationState(States.Items[f_State.rID]);
//#UC END# *5620E5640206_5620CFFC0045get_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_GetCurrentState

function TvcmBaseOperationsCollectionItemPrim.pm_GetLinked: Boolean;
//#UC START# *5620E6F00105_5620CFFC0045get_var*
//#UC END# *5620E6F00105_5620CFFC0045get_var*
begin
//#UC START# *5620E6F00105_5620CFFC0045get_impl*
 Result := false;
//#UC END# *5620E6F00105_5620CFFC0045get_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_GetLinked

procedure TvcmBaseOperationsCollectionItemPrim.pm_SetLinked(aValue: Boolean);
//#UC START# *5620E6F00105_5620CFFC0045set_var*
//#UC END# *5620E6F00105_5620CFFC0045set_var*
begin
//#UC START# *5620E6F00105_5620CFFC0045set_impl*
//#UC END# *5620E6F00105_5620CFFC0045set_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_SetLinked

function TvcmBaseOperationsCollectionItemPrim.GetDefaultOptions: TvcmOperationOptions;
//#UC START# *5620E1270164_5620CFFC0045_var*
//#UC END# *5620E1270164_5620CFFC0045_var*
begin
//#UC START# *5620E1270164_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620E1270164_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.GetDefaultOptions

function TvcmBaseOperationsCollectionItemPrim.GetGroupIDStored: Boolean;
//#UC START# *5620E2C30048_5620CFFC0045_var*
//#UC END# *5620E2C30048_5620CFFC0045_var*
begin
//#UC START# *5620E2C30048_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620E2C30048_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.GetGroupIDStored

function TvcmBaseOperationsCollectionItemPrim.GetOperationTypeStored: Boolean;
//#UC START# *5620E36701EE_5620CFFC0045_var*
//#UC END# *5620E36701EE_5620CFFC0045_var*
begin
//#UC START# *5620E36701EE_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620E36701EE_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.GetOperationTypeStored

function TvcmBaseOperationsCollectionItemPrim.GetIsDefaultStored: Boolean;
//#UC START# *5620E5C101B2_5620CFFC0045_var*
//#UC END# *5620E5C101B2_5620CFFC0045_var*
begin
//#UC START# *5620E5C101B2_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620E5C101B2_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.GetIsDefaultStored

procedure TvcmBaseOperationsCollectionItemPrim.OnSecondaryShortCutsChange(Sender: TObject);
//#UC START# *5620E5FF00DA_5620CFFC0045_var*
//#UC END# *5620E5FF00DA_5620CFFC0045_var*
begin
//#UC START# *5620E5FF00DA_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620E5FF00DA_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.OnSecondaryShortCutsChange

function TvcmBaseOperationsCollectionItemPrim.IsHandledToControl: Boolean;
 {* �������� ������������ ����������� }
//#UC START# *5620E72703A2_5620CFFC0045_var*
//#UC END# *5620E72703A2_5620CFFC0045_var*
begin
//#UC START# *5620E72703A2_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620E72703A2_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.IsHandledToControl

function TvcmBaseOperationsCollectionItemPrim.GetLinkedAction: TvcmAction;
 {* Action � �������� ��������� �������� }
//#UC START# *5620E6910372_5620CFFC0045_var*
//#UC END# *5620E6910372_5620CFFC0045_var*
begin
//#UC START# *5620E6910372_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620E6910372_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.GetLinkedAction

function TvcmBaseOperationsCollectionItemPrim.ControllerCommand: Word;
 {* ������������� ��������-shortcut }
//#UC START# *5620E66E0367_5620CFFC0045_var*
//#UC END# *5620E66E0367_5620CFFC0045_var*
begin
//#UC START# *5620E66E0367_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620E66E0367_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.ControllerCommand

function TvcmBaseOperationsCollectionItemPrim.ParentID: Integer;
//#UC START# *5620E65A00D3_5620CFFC0045_var*
//#UC END# *5620E65A00D3_5620CFFC0045_var*
begin
//#UC START# *5620E65A00D3_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620E65A00D3_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.ParentID

function TvcmBaseOperationsCollectionItemPrim.IsLinkedToModule: Boolean;
//#UC START# *5620E643039B_5620CFFC0045_var*
//#UC END# *5620E643039B_5620CFFC0045_var*
begin
//#UC START# *5620E643039B_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620E643039B_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.IsLinkedToModule

class procedure TvcmBaseOperationsCollectionItemPrim.ResetShortCutHandler(var aValue: TShortCut;
 aCommandID: Word = 0);
//#UC START# *5620E6250019_5620CFFC0045_var*
//#UC END# *5620E6250019_5620CFFC0045_var*
begin
//#UC START# *5620E6250019_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620E6250019_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.ResetShortCutHandler

procedure TvcmBaseOperationsCollectionItemPrim.DoFormGetState(var State: TvcmOperationStateIndex);
//#UC START# *5620E7B10292_5620CFFC0045_var*
//#UC END# *5620E7B10292_5620CFFC0045_var*
begin
//#UC START# *5620E7B10292_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620E7B10292_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.DoFormGetState

procedure TvcmBaseOperationsCollectionItemPrim.DoFormTest(const aParams: IvcmTestParamsPrim);
//#UC START# *5620E7CC00CF_5620CFFC0045_var*
//#UC END# *5620E7CC00CF_5620CFFC0045_var*
begin
//#UC START# *5620E7CC00CF_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620E7CC00CF_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.DoFormTest

procedure TvcmBaseOperationsCollectionItemPrim.DoFormExecute(const aParams: IvcmExecuteParams);
//#UC START# *5620E7E70331_5620CFFC0045_var*
//#UC END# *5620E7E70331_5620CFFC0045_var*
begin
//#UC START# *5620E7E70331_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620E7E70331_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.DoFormExecute

procedure TvcmBaseOperationsCollectionItemPrim.FakeControlTest(const aParams: IvcmTestParamsPrim);
//#UC START# *5620E802035A_5620CFFC0045_var*
//#UC END# *5620E802035A_5620CFFC0045_var*
begin
//#UC START# *5620E802035A_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620E802035A_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.FakeControlTest

procedure TvcmBaseOperationsCollectionItemPrim.ClearOp;
//#UC START# *5620E8DC016C_5620CFFC0045_var*
//#UC END# *5620E8DC016C_5620CFFC0045_var*
begin
//#UC START# *5620E8DC016C_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620E8DC016C_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.ClearOp

procedure TvcmBaseOperationsCollectionItemPrim.SetShortCuts(aShortCut: TShortCut;
 aSecondaryShortCuts: TShortCutList);
//#UC START# *5620E8B900F5_5620CFFC0045_var*
//#UC END# *5620E8B900F5_5620CFFC0045_var*
begin
//#UC START# *5620E8B900F5_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620E8B900F5_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.SetShortCuts

class function TvcmBaseOperationsCollectionItemPrim.StatesClass: RvcmBaseOperationStates;
//#UC START# *5620E87503A8_5620CFFC0045_var*
//#UC END# *5620E87503A8_5620CFFC0045_var*
begin
//#UC START# *5620E87503A8_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620E87503A8_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.StatesClass

function TvcmBaseOperationsCollectionItemPrim.OwnerUserType: TvcmEffectiveUserType;
 {* ���������� ���������������� ��� "�����" �� ������� ���������� �������� }
//#UC START# *5620E8300061_5620CFFC0045_var*
//#UC END# *5620E8300061_5620CFFC0045_var*
begin
//#UC START# *5620E8300061_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620E8300061_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.OwnerUserType

function TvcmBaseOperationsCollectionItemPrim.OwnerForm: TCustomForm;
 {* ���������� "�����" �� ������� ���������� �������� }
//#UC START# *5620EED40232_5620CFFC0045_var*
//#UC END# *5620EED40232_5620CFFC0045_var*
begin
//#UC START# *5620EED40232_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620EED40232_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.OwnerForm

{$If Defined(XE)}
procedure TvcmBaseOperationsCollectionItemPrim.ReplaceShortCuts(aShortCut: TShortCut;
 aSecondaryShortCuts: TCustomShortCutList);
//#UC START# *5620EF040199_5620CFFC0045_var*
//#UC END# *5620EF040199_5620CFFC0045_var*
begin
//#UC START# *5620EF040199_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620EF040199_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.ReplaceShortCuts
{$IfEnd} // Defined(XE)

{$If NOT Defined(XE)}
procedure TvcmBaseOperationsCollectionItemPrim.ReplaceShortCuts(aShortCut: TShortCut;
 aSecondaryShortCuts: TShortCutList);
//#UC START# *5620EF9D02F1_5620CFFC0045_var*
//#UC END# *5620EF9D02F1_5620CFFC0045_var*
begin
//#UC START# *5620EF9D02F1_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620EF9D02F1_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.ReplaceShortCuts
{$IfEnd} // NOT Defined(XE)

procedure TvcmBaseOperationsCollectionItemPrim.StoreDesignTimeShortcuts;
//#UC START# *5620F0050158_5620CFFC0045_var*
//#UC END# *5620F0050158_5620CFFC0045_var*
begin
//#UC START# *5620F0050158_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620F0050158_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.StoreDesignTimeShortcuts

function TvcmBaseOperationsCollectionItemPrim.SomePropStored: Boolean;
//#UC START# *5620F09B013E_5620CFFC0045_var*
//#UC END# *5620F09B013E_5620CFFC0045_var*
begin
//#UC START# *5620F09B013E_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620F09B013E_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.SomePropStored

procedure TvcmBaseOperationsCollectionItemPrim.RemoveShortCut(aShortCut: TShortCut);
//#UC START# *5620F16701DD_5620CFFC0045_var*
//#UC END# *5620F16701DD_5620CFFC0045_var*
begin
//#UC START# *5620F16701DD_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620F16701DD_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.RemoveShortCut

procedure TvcmBaseOperationsCollectionItemPrim.UnlinkControl(aControl: TComponent);
//#UC START# *5620F28501E2_5620CFFC0045_var*
//#UC END# *5620F28501E2_5620CFFC0045_var*
begin
//#UC START# *5620F28501E2_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620F28501E2_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.UnlinkControl

function TvcmBaseOperationsCollectionItemPrim.Handled(aTypes: TvcmHandleTypes): Boolean;
//#UC START# *5620F2B50162_5620CFFC0045_var*
//#UC END# *5620F2B50162_5620CFFC0045_var*
begin
//#UC START# *5620F2B50162_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620F2B50162_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.Handled

procedure TvcmBaseOperationsCollectionItemPrim.Operation(aControl: TComponent;
 const aTarget: IUnknown;
 aMode: TvcmOperationMode;
 const aParams: IvcmParams;
 aForce: Boolean);
 {* ���������� �������� }
//#UC START# *5620F10C0381_5620CFFC0045_var*
//#UC END# *5620F10C0381_5620CFFC0045_var*
begin
//#UC START# *5620F10C0381_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620F10C0381_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.Operation

procedure TvcmBaseOperationsCollectionItemPrim.PublishOp(aControl: TComponent;
 anExecute: TvcmControlExecuteEvent;
 aTest: TvcmControlTestEvent;
 aGetState: TvcmControlGetStateEvent);
 {* ������������ �������� }
//#UC START# *5620F19403B6_5620CFFC0045_var*
//#UC END# *5620F19403B6_5620CFFC0045_var*
begin
//#UC START# *5620F19403B6_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620F19403B6_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.PublishOp

procedure TvcmBaseOperationsCollectionItemPrim.PublishOp(aControl: TComponent;
 anExecute: TvcmExecuteEvent;
 aTest: TvcmControlTestEvent;
 aGetState: TvcmControlGetStateEvent);
 {* ������������ �������� }
//#UC START# *5620F1DF01BF_5620CFFC0045_var*
//#UC END# *5620F1DF01BF_5620CFFC0045_var*
begin
//#UC START# *5620F1DF01BF_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5620F1DF01BF_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.PublishOp

function TvcmBaseOperationsCollectionItemPrim.OperationTypeStored: Boolean;
 {* "������� ������������, ��� �������� OperationType �����������" }
//#UC START# *7C0E36AF141A_5620CFFC0045_var*
//#UC END# *7C0E36AF141A_5620CFFC0045_var*
begin
//#UC START# *7C0E36AF141A_5620CFFC0045_impl*
 Result := GetOperationTypeStored;
//#UC END# *7C0E36AF141A_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.OperationTypeStored

function TvcmBaseOperationsCollectionItemPrim.IsDefaultStored: Boolean;
 {* "������� ������������, ��� �������� IsDefault �����������" }
//#UC START# *EBDB5C8A01C4_5620CFFC0045_var*
//#UC END# *EBDB5C8A01C4_5620CFFC0045_var*
begin
//#UC START# *EBDB5C8A01C4_5620CFFC0045_impl*
 Result := GetIsDefaultStored;
//#UC END# *EBDB5C8A01C4_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.IsDefaultStored

function TvcmBaseOperationsCollectionItemPrim.GroupIDStored: Boolean;
 {* "������� ������������, ��� �������� GroupID �����������" }
//#UC START# *C79988A52B31_5620CFFC0045_var*
//#UC END# *C79988A52B31_5620CFFC0045_var*
begin
//#UC START# *C79988A52B31_5620CFFC0045_impl*
 Result := GetGroupIDStored;
//#UC END# *C79988A52B31_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.GroupIDStored

procedure TvcmBaseOperationsCollectionItemPrim.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_5620CFFC0045_var*
//#UC END# *478CF34E02CE_5620CFFC0045_var*
begin
//#UC START# *478CF34E02CE_5620CFFC0045_impl*
 inherited;
 if (Source is TvcmBaseOperationsCollectionItem) then
 begin
  GroupID := TvcmBaseOperationsCollectionItem(Source).GroupID;
  OperationType := TvcmBaseOperationsCollectionItem(Source).OperationType;
  AutoLock := TvcmBaseOperationsCollectionItem(Source).AutoLock;
  ExcludeUserTypes := TvcmBaseOperationsCollectionItem(Source).ExcludeUserTypes;
  OnTest := TvcmBaseOperationsCollectionItem(Source).OnTest;
  OnExecute := TvcmBaseOperationsCollectionItem(Source).OnExecute;
  OnContextTest := TvcmBaseOperationsCollectionItem(Source).OnContextTest;
  OnContextExecute := TvcmBaseOperationsCollectionItem(Source).OnContextExecute;
  Options := TvcmBaseOperationsCollectionItem(Source).Options;
  IsDefault := TvcmBaseOperationsCollectionItem(Source).IsDefault;
 end;//TvcmBaseOperationsCollectionItem
//#UC END# *478CF34E02CE_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.Assign

procedure TvcmBaseOperationsCollectionItemPrim.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_5620CFFC0045_var*
//#UC END# *479731C50290_5620CFFC0045_var*
begin
//#UC START# *479731C50290_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.Cleanup

procedure TvcmBaseOperationsCollectionItemPrim.BeforeAddToCache;
 {* �������, ���������� ����� ����������� ������� � ��� ���������� �������������. }
//#UC START# *479F2B3302C1_5620CFFC0045_var*
//#UC END# *479F2B3302C1_5620CFFC0045_var*
begin
//#UC START# *479F2B3302C1_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *479F2B3302C1_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.BeforeAddToCache

constructor TvcmBaseOperationsCollectionItemPrim.Create(aCollection: TCollection);
//#UC START# *4D555CF50027_5620CFFC0045_var*
//#UC END# *4D555CF50027_5620CFFC0045_var*
begin
//#UC START# *4D555CF50027_5620CFFC0045_impl*
 inherited;
 //f_Controls := TvcmActiveControlsCollection.Create(Self);
 f_State := vcm_DefaultOperationState;
 f_States := StatesClass.Create(Self);
 f_Enabled := true;
 f_VisibleToUser := -1;
 f_IsCaptionUnique := True;
 SecondaryShortCuts.OnChange := OnSecondaryShortCutsChange;
 f_SaveShortcut := TShortcut(0);
 f_SaveSecondaryShortcuts := '';
 f_ContextMenuWeight := 0;
//#UC END# *4D555CF50027_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.Create

procedure TvcmBaseOperationsCollectionItemPrim.ClearFields;
begin
 Finalize(f_State);
 f_SaveSecondaryShortcuts := '';
 inherited;
end;//TvcmBaseOperationsCollectionItemPrim.ClearFields

procedure TvcmBaseOperationsCollectionItemPrim.ChangeName(const anOld: AnsiString;
 const aNew: AnsiString);
//#UC START# *55CCBA3C0190_5620CFFC0045_var*
//#UC END# *55CCBA3C0190_5620CFFC0045_var*
begin
//#UC START# *55CCBA3C0190_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *55CCBA3C0190_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.ChangeName

procedure TvcmBaseOperationsCollectionItemPrim.ChangeCaption(const anOld: AnsiString;
 const aNew: AnsiString);
//#UC START# *55CCBA8003C7_5620CFFC0045_var*
//#UC END# *55CCBA8003C7_5620CFFC0045_var*
begin
//#UC START# *55CCBA8003C7_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *55CCBA8003C7_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.ChangeCaption

function TvcmBaseOperationsCollectionItemPrim.MakeID(const aName: AnsiString): Integer;
//#UC START# *55CCBAAB00F4_5620CFFC0045_var*
//#UC END# *55CCBAAB00F4_5620CFFC0045_var*
begin
//#UC START# *55CCBAAB00F4_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *55CCBAAB00F4_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.MakeID

function TvcmBaseOperationsCollectionItemPrim.GetID: Integer;
//#UC START# *55CCBAC800F0_5620CFFC0045_var*
//#UC END# *55CCBAC800F0_5620CFFC0045_var*
begin
//#UC START# *55CCBAC800F0_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *55CCBAC800F0_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.GetID

function TvcmBaseOperationsCollectionItemPrim.QueryInterface(const IID: TGUID;
 out Obj): HResult;
//#UC START# *561145D802BB_5620CFFC0045_var*
//#UC END# *561145D802BB_5620CFFC0045_var*
begin
//#UC START# *561145D802BB_5620CFFC0045_impl*
 !!! Needs to be implemented !!!
//#UC END# *561145D802BB_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.QueryInterface

//#UC START# *4D7A109601C2impl*
//#UC END# *4D7A109601C2impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmBaseOperationsCollectionItemPrim);
 {* ����������� TvcmBaseOperationsCollectionItemPrim }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmBaseOperationsCollectionItem);
 {* ����������� TvcmBaseOperationsCollectionItem }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
