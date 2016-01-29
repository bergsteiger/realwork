unit vcmAggregate;

interface

uses
 l3IntfUses
 , vcmBase
 , vcmInterfaces
 , vcmIEntityList
 , vcmExternalInterfaces
;

type
 TvcmAggregate = class(TvcmCacheableBase, IvcmAggregate)
  procedure Create(aGUID: PGUID);
  function Make(aGUID: PGUID): IvcmAggregate;
  procedure AddEntity(const anEntity: IvcmEntity);
   {* ��������� �������� � ��������� }
  procedure RemoveEntity(const anEntity: IvcmEntity);
   {* ������� �������� �� ��������� }
  function Operation(const anOp: TvcmOPID;
   const aParams: IvcmExecuteParams): IvcmExecuteParams; overload;
  function Operation(const anOp: TvcmOPID): IvcmExecuteParams; overload;
  function HasForm(const aName: TvcmFormID;
   theForm: PIvcmEntityForm): Boolean;
   {* ���������, ������������ �� ��������� ����� � ��������� }
  function GUID: TGUID;
  function Entity: IvcmEntity;
  function EntitiesCount: Integer;
 end;//TvcmAggregate
 
implementation

uses
 l3ImplUses
 , SysUtils
 , vcmUserControls
;

end.
