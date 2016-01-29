unit nscNewInterfaces;

interface

uses
 l3IntfUses
 , l3Interfaces
 , vcmExternalInterfaces
;

type
 InscContextFilterState = interface
  {* ��������� ������������ ������� }
  function NeedRefilterTree: Boolean;
 end;//InscContextFilterState
 
 InscContextFilterListener = interface
  {* ��������� ������� ������������ ������� }
  procedure ContextCanBeChanged(aHandle: Integer;
   const aFilterName: Il3CString;
   const aState: InscContextFilterState);
   {* ������� ��������� ����� ���������. ������������ ��� ����� ������ ��
             ���� ����� � ����������� ���������� }
  procedure FilterRemoving(aHandle: Integer);
 end;//InscContextFilterListener
 
 InscPageControlNotification = interface
  {* ��� ����������� � �������� ���������� � ��������� }
  procedure TabActivate;
   {* C������ ��������� ������� }
 end;//InscPageControlNotification
 
 TnscToolTipKind = (
  nsc_ttkNone
  , nsc_ttkInformation
  , nsc_ttkWarning
  , nsc_ttkError
 );//TnscToolTipKind
 
 InscStatusBarItemDefsList = interface;
 
 InscStatusBarItemDef = interface
  procedure SubscribeOnNotification(const aServer: InscStatusBarItemDef);
 end;//InscStatusBarItemDef
 
 InscStatusBarItemDefsList = interface
  procedure Add(const aDef: InscStatusBarItemDef);
 end;//InscStatusBarItemDefsList
 
 InscStatusBarItemsProvider = interface
 end;//InscStatusBarItemsProvider
 
 InscStatusBarItemsVisualizer = interface
  procedure RegisterProvider(const aProvider: InscStatusBarItemsProvider);
  procedure UnregisterProvider(const aProvider: InscStatusBarItemsProvider);
 end;//InscStatusBarItemsVisualizer
 
 InscStatusBarOperationDef = interface(InscStatusBarItemDef)
 end;//InscStatusBarOperationDef
 
 TsbdSeparatorPos = (
  spLeft
  , spMiddle
  , spRight
 );//TsbdSeparatorPos
 
 InscStatusBarDelimiterDef = interface(InscStatusBarItemDef)
 end;//InscStatusBarDelimiterDef
 
 InscBaseSearchPromptNode = interface
  function OpenDocument: Boolean;
  function IsLinkOnDocument: Boolean;
 end;//InscBaseSearchPromptNode
 
implementation

uses
 l3ImplUses
;

end.
