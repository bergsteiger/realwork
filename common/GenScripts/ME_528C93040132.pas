unit vcmBaseTypes;

interface

uses
 l3IntfUses
 , l3Types
;

type
 TvcmFormID = object
 end;//TvcmFormID
 
 TvcmZoneType = (
  vcm_ztAny
  , vcm_ztMain
  , vcm_ztNavigator
  , vcm_ztParent
  , vcm_ztChild
  , vcm_ztReminder
  , vcm_ztFloating
  , vcm_ztModal
  , vcm_ztManualModal
  , vcm_ztForToolbarsInfo
  , vcm_ztSimpleFloat
  , vcm_ztMainObjectForm
  , vcm_ztForFocus
 );//TvcmZoneType
 
 TvcmNeedMakeDS = (
  {* ������������ ��� ������������ ������������� �������� ��� }
  vcm_nmForce
   {* ��������� �� ������ �� �� ��� }
  , vcm_nmNo
   {* ������ ���������, �������� ������, ��� ����� ���� ������� ������������� � ��� ���������� ������ �� ��������� �� ����� }
  , vcm_nmYes
   {* ��������� ��������� }
 );//TvcmNeedMakeDS
 
 TvcmIteratorAction = Tl3IteratorAction;
 
implementation

uses
 l3ImplUses
;

end.
