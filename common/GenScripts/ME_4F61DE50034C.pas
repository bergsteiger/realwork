unit npControlsListPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , npControls
 , Controls
 , vtNavigator
;

type
 TnpControlsListPrim = class(_l3UncomparabeObjectRefList_)
  {* ������ ����������� �� �����, �� ������� ���� ����������� ����������. }
  function Find(aControl: TControl): TnpControls; overload;
   {* ����� ��������� � ������� ������ ��������� }
  function Find(aNavigator: TvtNavigatorPrim): TnpControls; overload;
   {* ����� Link }
  procedure AddControl(aNavigator: TvtNavigatorPrim;
   aControl: TControl);
   {* ����������� ��� �������� ��� ���������, ���� ��������� �� �����, �� ���� ��� � ������ � ��������� � ���� ���������. }
  procedure DeleteControl(aControl: TControl);
   {* ������� ��������� �� ������ (���������� ��� �����������) }
  procedure DockOnForm(aControl: TControl);
   {* ������������ ��������� � ���������� �� �����, �� �������� �� ��� ���������� }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
 end;//TnpControlsListPrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
