unit vcmTaskPanelInterfaces;
 {* ���������� ��� ��������� "������ �����" }

// ������: "w:\common\components\gui\Garant\VCM\vcmTaskPanelInterfaces.pas"
// ���������: "Interfaces"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmInterfaces
 {$If NOT Defined(NoVCL)}
 , ActnList
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Interfaces
 , vcmExternalInterfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , afwInterfaces
;

type
 IvcmBase = vcmInterfaces.IvcmBase;

 IvcmCustOpsItem = interface(IvcmBase)
  {* ������� ������ ����� }
  ['{56FD909E-7A46-4B87-95BD-C4665936F003}']
  function pm_GetPosition: Integer;
  procedure pm_SetPosition(aValue: Integer);
  property Position: Integer
   read pm_GetPosition
   write pm_SetPosition;
   {* ������� ������ }
 end;//IvcmCustOpsItem

 IvcmCustOpsOperation = interface(IvcmBase)
  {* �������� ������ ����� }
  ['{8CD16C4E-DF54-42AB-B126-5D70990F2486}']
  function pm_GetAction: TCustomAction;
  property Action: TCustomAction
   read pm_GetAction;
 end;//IvcmCustOpsOperation

 IvcmCustOpsRepGroup = interface(IvcmBase)
  ['{2C68A810-1BA3-4BD0-B1B6-CE85EF94F232}']
  function pm_GetId: Integer;
  function pm_GetCaption: IvcmCString;
  procedure pm_SetCaption(const aValue: IvcmCString);
  function As_Il3ChangeNotifier: Il3ChangeNotifier;
   {* ����� ���������� ������ ���������� � Il3ChangeNotifier }
  property Id: Integer
   read pm_GetId;
   {* ������������� ������ }
  property Caption: IvcmCString
   read pm_GetCaption
   write pm_SetCaption;
   {* �������� ������ }
 end;//IvcmCustOpsRepGroup

 IvcmCustOpsRepGroupOperations = interface;

 IvcmCustOpsRepOperation = interface(IvcmCustOpsOperation)
  {* �������� ����������� ������ ����� }
  ['{44463149-8063-468F-871D-3BA37B9822A0}']
  function pm_GetGroup: IvcmCustOpsRepGroupOperations;
  function pm_GetCaption: IvcmCString;
  function pm_GetUserCaption: IvcmCString;
  procedure pm_SetUserCaption(const aValue: IvcmCString);
  function As_Il3ChangeNotifier: Il3ChangeNotifier;
   {* ����� ���������� ������ ���������� � Il3ChangeNotifier }
  property Group: IvcmCustOpsRepGroupOperations
   read pm_GetGroup;
   {* ������ ����������� � ������� ��������� �������� }
  property Caption: IvcmCString
   read pm_GetCaption;
   {* �������� ������������ ��� ����������� � ����������� }
  property UserCaption: IvcmCString
   read pm_GetUserCaption
   write pm_SetUserCaption;
   {* ���������������� �������� ��������. ������������ �� ��������, ����
             � ���������� �������� �� ����������, �� ������������ ��������
             �������� }
 end;//IvcmCustOpsRepOperation

 IvcmCustOpsRepOperationsIterator = interface;

 IvcmCustOpsRepGroupOperations = interface(IvcmBase)
  {* ��������� ��� ������ ������ �������� }
  ['{4A9EFCF7-628E-4FD8-A957-5C209C73A51E}']
  function pm_GetOperations: IvcmCustOpsRepOperationsIterator;
  function pm_GetCaption: IvcmCString;
  property Operations: IvcmCustOpsRepOperationsIterator
   read pm_GetOperations;
  property Caption: IvcmCString
   read pm_GetCaption;
 end;//IvcmCustOpsRepGroupOperations

 IvcmCustOpsRepOperationsIterator = interface(IvcmBase)
  ['{1D6A46A0-95B8-437F-8841-18A0F178F522}']
  function Next: IvcmCustOpsRepOperation;
 end;//IvcmCustOpsRepOperationsIterator

 IvcmCustOpsGroupOperation = interface;

 IvcmCustOpsGroupOperationsIterator = interface(IvcmBase)
  ['{F8641F87-ABC9-41BA-88D9-DBD1BCA6929D}']
  function Next: IvcmCustOpsGroupOperation;
 end;//IvcmCustOpsGroupOperationsIterator

 IvcmCustOpsGroup = interface(IvcmCustOpsItem)
  {* ������ ������ ����� }
  ['{20AB3710-368D-46ED-9DBD-11E91295D283}']
  function pm_GetOperations: IvcmCustOpsGroupOperationsIterator;
  function pm_GetRepGroup: IvcmCustOpsRepGroup;
  function Get_IsLinkToExistingControl: Boolean;
  function Get_Control: TWinControl;
  function AddOperation(const aRepOp: IvcmCustOpsRepOperation;
   aForAllUseCases: Boolean;
   aPosition: Integer;
   const aCaption: IvcmCString): IvcmCustOpsGroupOperation;
   {* �������� �������� � ������ ����� }
  function As_Il3ChangeNotifier: Il3ChangeNotifier;
   {* ����� ���������� ������ ���������� � Il3ChangeNotifier }
  property Operations: IvcmCustOpsGroupOperationsIterator
   read pm_GetOperations;
  property RepGroup: IvcmCustOpsRepGroup
   read pm_GetRepGroup;
  property IsLinkToExistingControl: Boolean
   read Get_IsLinkToExistingControl;
   {* �������� �� ������ ������� �� ������������ ������� }
  property Control: TWinControl
   read Get_Control;
 end;//IvcmCustOpsGroup

 IvcmCustOpsRepGroupsIterator = interface(IvcmBase)
  {* �������� ��������� ��� ������ ����� }
  ['{79CE7472-FEC0-41E9-8592-83A7F14085CC}']
  function Next: IvcmCustOpsRepGroup;
 end;//IvcmCustOpsRepGroupsIterator

 IvcmCustOpsGroupOperation = interface(IvcmCustOpsItem)
  {* �������� ������ ����� }
  ['{5211675E-9243-4C15-A5E7-CD120F79E96B}']
  function pm_GetForAllUseCases: Boolean;
  procedure pm_SetForAllUseCases(aValue: Boolean);
  function pm_GetGroupId: Integer;
  procedure pm_SetGroupId(aValue: Integer);
  function pm_GetIsDefaultCaption: Boolean;
  function pm_GetCaption: IvcmCString;
  procedure pm_SetCaption(const aValue: IvcmCString);
  function pm_GetRepOp: IvcmCustOpsRepOperation;
  function pm_GetGroup: IvcmCustOpsGroup;
  procedure Delete;
   {* ������� �������� �� ������ ����� }
  function As_Il3ChangeNotifier: Il3ChangeNotifier;
   {* ����� ���������� ������ ���������� � Il3ChangeNotifier }
  property ForAllUseCases: Boolean
   read pm_GetForAllUseCases
   write pm_SetForAllUseCases;
   {* ������ ���������� � ������ ��� ������� �������� }
  property GroupId: Integer
   read pm_GetGroupId
   write pm_SetGroupId;
  property IsDefaultCaption: Boolean
   read pm_GetIsDefaultCaption;
   {* ���������� ���� �� ������������� �������� ��� ������ ����� }
  property Caption: IvcmCString
   read pm_GetCaption
   write pm_SetCaption;
  property RepOp: IvcmCustOpsRepOperation
   read pm_GetRepOp;
  property Group: IvcmCustOpsGroup
   read pm_GetGroup;
 end;//IvcmCustOpsGroupOperation

 IvcmCustOpsGroupsIterator = interface(IvcmBase)
  ['{92CE1BEA-AC70-49CC-A7B3-F4F0624B5C6D}']
  function Next: IvcmCustOpsGroup;
 end;//IvcmCustOpsGroupsIterator

 IvcmCustOpsRepGroupsOperationsIterator = interface(IvcmBase)
  {* �������� ����� ��������� �������� }
  ['{B1EE3B82-0816-485D-93A5-4D32F7A12697}']
  function Next: IvcmCustOpsRepGroupOperations;
 end;//IvcmCustOpsRepGroupsOperationsIterator

 IvcmCustOps = interface(IvcmBase)
  {* ������ ����� ��� ������ � ����� ��������� }
  ['{908DF1BA-5F0A-4BB9-B7C9-3B2BE6B87E93}']
  function pm_GetBaseSettingId: TafwSettingId;
  function pm_GetRepGroupsOperations: IvcmCustOpsRepGroupsOperationsIterator;
  function pm_GetRepGroups: IvcmCustOpsRepGroupsIterator;
  function pm_GetGroups: IvcmCustOpsGroupsIterator;
  function pm_GetEnableSaveToSettings: Boolean;
  procedure pm_SetEnableSaveToSettings(aValue: Boolean);
  function AddRepGroup(const aGroup: IvcmCString): IvcmCustOpsRepGroup;
   {* �������� ������ ����������� }
  procedure DeleteRepGroup(const aGroup: IvcmCustOpsRepGroup);
   {* ������� ������ ����������� }
  function AddGroup(const aRepGroup: IvcmCustOpsRepGroup;
   aPosition: Integer): IvcmCustOpsGroup;
  procedure Refresh;
   {* ��������� ���������� �������� ������ �����. ������������ ���
              ������������ ������������ }
  function As_Il3ChangeNotifier: Il3ChangeNotifier;
   {* ����� ���������� ������ ���������� � Il3ChangeNotifier }
  property BaseSettingId: TafwSettingId
   read pm_GetBaseSettingId;
   {* ������� ������������� �������� ������ �����. ������������ ���
              ������ ������ ��������� � ������� ����� }
  property RepGroupsOperations: IvcmCustOpsRepGroupsOperationsIterator
   read pm_GetRepGroupsOperations;
   {* ������ �������� ��������� ��� ������ � ������ ����� }
  property RepGroups: IvcmCustOpsRepGroupsIterator
   read pm_GetRepGroups;
   {* ����������� ����� ������ �����. ��� ������������ ������ �����
              ������������ ����� ������������ ��� ��������� ������ }
  property Groups: IvcmCustOpsGroupsIterator
   read pm_GetGroups;
   {* ������ ������ ����� }
  property EnableSaveToSettings: Boolean
   read pm_GetEnableSaveToSettings
   write pm_SetEnableSaveToSettings;
   {* ���������/��������� ������, ������ ������ ������ � ������ �������������� �� }
 end;//IvcmCustOps

 IvcmCustAvailableToolbarOps = interface(IvcmCustOps)
  {* ��������� ��������� ��� ������ �������� }
  ['{7C9BF0BD-5C30-46AA-B93E-0D9E6B6B53A9}']
  function pm_GetForm: IvcmEntityForm;
  property Form: IvcmEntityForm
   read pm_GetForm;
   {* ������������� ����� }
 end;//IvcmCustAvailableToolbarOps

 IvcmMainForm = interface(IvcmBase)
  {* �������� ����� }
  ['{11B54167-2B27-46A7-8D30-0529B1A2CDFF}']
  function pm_GetHistory: IvcmHistory;
  function pm_GetTasksPanel: IvcmCustOps;
  procedure AddFormToTasksPanel(const aEntityForm: IvcmEntityForm);
  procedure RemoveFormFromTasksPanel(const aEntityForm: IvcmEntityForm);
  property History: IvcmHistory
   read pm_GetHistory;
  property TasksPanel: IvcmCustOps
   read pm_GetTasksPanel;
 end;//IvcmMainForm

 IvcmCustOpsRepository = interface(IvcmBase)
  {* ������ ����� ��� ���������� �������� ���������� ��������� }
  ['{F2006978-4DCD-4F97-B3A9-5D796E7E214B}']
  procedure AddModule(const aModule: IvcmModuleDef);
   {* ���������������� �������� ������ }
  procedure AddForm(const aForm: IvcmEntityForm);
   {* ���������������� ����� }
  procedure RemoveForm(const aForm: IvcmEntityForm);
   {* ������� ����� }
 end;//IvcmCustOpsRepository

 TvcmTaskPanelOperation = (
  cvcm_tpOperationRemove
  , cvcm_tpOpPosChanged
  , cvcm_tpOpCaptionChanged
  , cvcm_tpGroupRemove
  , cvcm_tpOperationAdded
  , cvcm_tpGroupAdded
  , cvcm_tpGroupCaptionChanged
  , cvcm_tpGroupPosChanged
  , cvcm_tpBeforeUpdate
  , cvcm_tpAfterUpdate
 );//TvcmTaskPanelOperation

 IvcmTaskPanelNotifyRecipient = interface(Il3Notify)
  {* ��������� ��� ��������� ����������� �� ��������. }
  ['{4DD3FE7D-D6D0-4D92-845E-10BBD39C46EE}']
  procedure TaskPanelNotify(const aNotifier: Il3ChangeNotifier;
   aOperation: TvcmTaskPanelOperation;
   const aInterface: IvcmCustOpsItem);
   {* ������ ��������. }
 end;//IvcmTaskPanelNotifyRecipient
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
