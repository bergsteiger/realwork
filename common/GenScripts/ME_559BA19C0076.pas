unit vcmHistoryService;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , vcmInterfaces
;

 (*
 MvcmHistoryService = interface
  {* �������� ������� TvcmHistoryService }
  function GetFormHistory(const aForm: IvcmEntityForm): IvcmHistory;
  procedure SaveFormState(const aForm: IvcmEntityForm);
  function GetContainerHistory(const aContainer: IvcmContainer): IvcmHistory;
  function IsInBF(const aForm: IvcmEntityForm): Boolean;
 end;//MvcmHistoryService
 *)
 
type
 IvcmHistoryService = interface
  {* ��������� ������� TvcmHistoryService }
  function GetFormHistory(const aForm: IvcmEntityForm): IvcmHistory;
  procedure SaveFormState(const aForm: IvcmEntityForm);
  function GetContainerHistory(const aContainer: IvcmContainer): IvcmHistory;
  function IsInBF(const aForm: IvcmEntityForm): Boolean;
 end;//IvcmHistoryService
 
 TvcmHistoryService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  function GetContainerHistory(const aContainer: IvcmContainer): IvcmHistory;
  function GetFormHistory(const aForm: IvcmEntityForm): IvcmHistory;
  procedure SaveFormState(const aForm: IvcmEntityForm);
  function IsInBF(const aForm: IvcmEntityForm): Boolean;
 end;//TvcmHistoryService
 
implementation

uses
 l3ImplUses
 , afwFacade
 , vcmBase
;

end.
