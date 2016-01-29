unit vcmUserControls;

interface

uses
 l3IntfUses
 , vcmExternalInterfaces
 , Classes
 , ActnList
;

type
 IvcmBaseObjectDef = interface(IvcmBase)
 end;//IvcmBaseObjectDef
 
 IvcmUserFriendlyControl = interface(IvcmBaseObjectDef)
  {* ������� ��������� ��� �������� ������� ����������� ��� ������������ }
 end;//IvcmUserFriendlyControl
 
 IvcmIdentifiedUserFriendlyControl = interface(IvcmUserFriendlyControl)
  {* ������� ��������� ��� �������� ������� ����������� ��� ������������ � ������������� }
 end;//IvcmIdentifiedUserFriendlyControl
 
 TvcmOperationOption = (
  {* ����� ���������� �������� � ���� � �� ������ ������������. }
  vcm_ooShowInMainToolbar
   {* �������� ����� �������� �� ������
                                  ������������ ������� ����� }
  , vcm_ooShowInChildToolbar
   {* �������� ����� �������� �� ������
                                  ������������ ����� �������� }
  , vcm_ooShowInContextMenu
   {* �������� ����� �������� � ����������� ���� }
  , vcm_ooShowInMainMenu
   {* �������� ����� �������� � ������� ����
                                  ������� �����. }
  , vcm_ooShowInChildMenu
   {* �������� ����� �������� � ���� �����
                                  �������� }
 );//TvcmOperationOption
 
 TvcmOperationMode = (
  {* ����� ���������� ��������. }
  vcm_omTest
   {* ����� �������� ����������� �������� }
  , vcm_omExecute
   {* ����� ����������������� �����������
                      �������� }
  , vcm_omAggregateExecute
 );//TvcmOperationMode
 
 TvcmOperationCallType = (
  vcm_octShortCut
  , vcm_octMainMenu
  , vcm_octContextMenu
  , vcm_octToolbar
 );//TvcmOperationCallType
 
 // TvcmUserType
 
 TvcmUserTypes = set of TvcmUserType;
 
 TvcmOperationOptions = set of TvcmOperationOption;
 
 IvcmOperationDef = interface(IvcmIdentifiedUserFriendlyControl)
  {* �������� �������� }
 end;//IvcmOperationDef
 
 TvcmToolBarPos = (
  vcm_tbpTop
  , vcm_tbpBottom
  , vcm_tbpLeft
  , vcm_tbpRight
  , vcm_tbpNone
 );//TvcmToolBarPos
 
 TvcmToolBarPoses = set of TvcmToolBarPos;
 
 // TvcmEffectiveToolBarPos
 
 TvcmEffectiveToolBarPoses = set of TvcmEffectiveToolBarPos;
 
 IvcmOperationsDefIterator = interface
  {* �������� �������� �������� }
 end;//IvcmOperationsDefIterator
 
 IvcmOperationalIdentifiedUserFriendlyControl = interface(IvcmIdentifiedUserFriendlyControl)
  {* ������� ��������� ��� �������� ������� ����������� ��� ������������ � �������� }
 end;//IvcmOperationalIdentifiedUserFriendlyControl
 
implementation

uses
 l3ImplUses
;

end.
