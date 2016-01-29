unit nscTasksPanel;

interface

uses
 l3IntfUses
 , vcmTasksPanel
 , vcmTaskPanelInterfaces
 , nscTasksPanelGroupDescList
 , afwInterfaces
 , vcmExternalInterfaces
;

type
 TnscTasksPanel = class(TvcmCustOpsNotifier, IvcmCustOps)
  {* ���������� ������ ����� }
  procedure Create(const aBaseSettingId: TafwSettingId;
   const aGroups: TnscTasksPanelGroupDescArray);
  function Make(const aBaseSettingId: TafwSettingId;
   const aGroups: TnscTasksPanelGroupDescArray): IvcmCustOps;
  function AddRepGroup(const aGroup: IvcmCString): IvcmCustOpsRepGroup;
   {* �������� ������ ����������� }
  procedure DeleteRepGroup(const aGroup: IvcmCustOpsRepGroup);
   {* ������� ������ ����������� }
  function AddGroup(const aRepGroup: IvcmCustOpsRepGroup;
   aPosition: Integer): IvcmCustOpsGroup;
  procedure Refresh;
   {* ��������� ���������� �������� ������ �����. ������������ ���
              ������������ ������������ }
  function RepGroupsOperations: IvcmCustOpsRepGroupsOperationsIterator;
   {* ������ �������� ��������� ��� ������ � ������ ����� }
  function RepGroups: IvcmCustOpsRepGroupsIterator;
   {* ����������� ����� ������ �����. ��� ������������ ������ �����
              ������������ ����� ������������ ��� ��������� ������ }
  function Groups: IvcmCustOpsGroupsIterator;
   {* ������ ������ ����� }
  function BaseSettingId: TafwSettingId;
   {* ������� ������������� �������� ������ �����. ������������ ���
              ������ ������ ��������� � ������� ����� }
  function EnableSaveToSettings: Boolean;
   {* ���������/��������� ������, ������ ������ ������ � ������ �������������� �� }
 end;//TnscTasksPanel
 
implementation

uses
 l3ImplUses
 , nscTasksPanelGroupsIterator
 , SysUtils
 , l3Base
;

end.
