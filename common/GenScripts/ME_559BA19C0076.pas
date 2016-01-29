unit vcmHistoryService;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , vcmInterfaces
;

 (*
 MvcmHistoryService = interface
  {* Контракт сервиса TvcmHistoryService }
  function GetFormHistory(const aForm: IvcmEntityForm): IvcmHistory;
  procedure SaveFormState(const aForm: IvcmEntityForm);
  function GetContainerHistory(const aContainer: IvcmContainer): IvcmHistory;
  function IsInBF(const aForm: IvcmEntityForm): Boolean;
 end;//MvcmHistoryService
 *)
 
type
 IvcmHistoryService = interface
  {* Интерфейс сервиса TvcmHistoryService }
  function GetFormHistory(const aForm: IvcmEntityForm): IvcmHistory;
  procedure SaveFormState(const aForm: IvcmEntityForm);
  function GetContainerHistory(const aContainer: IvcmContainer): IvcmHistory;
  function IsInBF(const aForm: IvcmEntityForm): Boolean;
 end;//IvcmHistoryService
 
 TvcmHistoryService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
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
