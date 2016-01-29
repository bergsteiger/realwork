unit nsWindowsListPrim;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Tree_TLB
 , l3Interfaces
 , OfficeLikeAppInterfaces
 , vcmInterfaces
 , vcmEntityForm
 , l3TabbedContainersDispatcher
 , l3Core
;

type
 TnsUniqueName = class(Tl3ProtoObject)
  {* ����� ����������� �������� ���������� ����� � ������ ��������� ���������� � ����� ������������� ���� �������� �������� ����������. �������� �����, ����� (1), ����� (2) � �.� }
  function MakeName(const aName: Il3CString): Il3CString;
   {* ���������� ���������� ��� }
  procedure Create;
 end;//TnsUniqueName
 
 TnsWindowsListPrim = class(Tl3ProtoObject)
  {* ����� ����������� ������� ���� }
  function CheckLength(const aName: Il3CString): Il3CString;
   {* ��������� �� ������� �� ������ ����� �� ���������� ������� � ������������ ��� ������������� }
  function FindNode(const aForm: IvcmEntityForm): Il3Node;
   {* ���������� Il3Node ��� ����� aForm }
  procedure Remove(const aForm: IvcmEntityForm);
   {* ������� ����� �� ������ }
  procedure Reload;
   {* ������������� ������ }
  function nsGetWindowCaption(aForm: TvcmEntityForm): Il3CString;
   {* �������� ������� �������� ������ ���������� � ������� ��������, � ������ _caption ����� ����������� � Parent ���� ������� ����� }
  procedure ContainersChanged(aNotification: Tl3TabbedContainerNotificationType);
 end;//TnsWindowsListPrim
 
implementation

uses
 l3ImplUses
 , vcmMainForm
 , vcmTabbedContainerFormDispatcher
 , vcmStringList
 , l3String
 , l3NodesModelPart
 , SysUtils
 , vcmBase
 , nsWindowNode
 , l3Chars
;

end.
