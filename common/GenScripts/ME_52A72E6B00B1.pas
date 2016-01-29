unit vcmBaseEntitiesCollection;

interface

uses
 l3IntfUses
 , vcmBaseCollection
 , vcmExternalInterfaces
 , vcmBaseEntitiesCollectionItem
 , vcmBase
 , vcmBaseOperationsCollectionItem
 , vcmEntitiesDefList
 , Classes
 , vcmBaseCollectionItem
;

type
 TvcmBaseEntitiesCollection = class(TvcmBaseCollection, IvcmOperationsPublisher)
  function PublishFormEntity(const anEntity: TvcmString;
   aGetTarget: TvcmGetTargetEvent): TvcmBaseEntitiesCollectionItem;
   {* ������������ �������� }
  procedure GroupItemsInContextMenu(const anEntity: TvcmString);
  procedure ToolbarAtBottom(const anEntity: TvcmString);
  procedure ContextMenuWeight(const anEntity: TvcmString;
   aWeight: Integer); overload;
   {* ���������� ��� �������� � ����������� ���� }
  procedure ContextMenuWeight(const anEntity: TvcmString;
   const anOperation: TvcmString;
   aWeight: Integer;
   aNoPrefix: Boolean); overload;
   {* ���������� ��� �������� � ����������� ���� }
  procedure PublishOpWithResult(const anEntity: TvcmString;
   const anOperation: TvcmString;
   anExecute: TvcmExecuteEvent;
   aTest: TvcmControlTestEvent;
   aGetState: TvcmControlGetStateEvent;
   aNoPrefix: Boolean);
   {* ������������ �������� }
  function GetOperationByName(const anEntity: TvcmString;
   const anOperation: TvcmString;
   aNoPrefix: Boolean): TvcmBaseOperationsCollectionItem;
  procedure ShowInContextMenu(const anEntity: TvcmString;
   const anOperation: TvcmString;
   aValue: Boolean;
   aNoPrefix: Boolean);
  procedure ShowInToolbar(const anEntity: TvcmString;
   const anOperation: TvcmString;
   aValue: Boolean;
   aNoPrefix: Boolean);
  function CheckEntityForControl(const anEntity: TvcmString): TvcmBaseEntitiesCollectionItem;
  procedure GetEntitiesDef(aList: TvcmEntitiesDefList);
   {* ���������� ������ ���������� ��������� }
  procedure LinkControl(aControl: TComponent);
  procedure UnlinkControl(aControl: TComponent);
  procedure RegisterInRep;
  function IsItemCaptionUnique(aItem: TvcmBaseCollectionItem): Boolean;
   {* ����� �������� �� �������� }
  procedure PublishEntity(const anEntity: TvcmString;
   aGetTarget: TvcmControlGetTargetEvent);
   {* ������������ ��������. }
 end;//TvcmBaseEntitiesCollection
 
implementation

uses
 l3ImplUses
 , vcmInterfaces
 , vcmUserControls
 , vcmEntities
 , SysUtils
 , TtfwClassRef_Proxy
;

end.
