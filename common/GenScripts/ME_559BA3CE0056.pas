unit vcmTabsHistoryService;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , vcmHistoryService
 , vcmInterfaces
;

type
 TvcmTabsHistoryService = class(Tl3ProtoObject, IvcmHistoryService)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function GetContainerHistory(const aContainer: IvcmContainer): IvcmHistory;
  function GetFormHistory(const aForm: IvcmEntityForm): IvcmHistory;
  procedure SaveFormState(const aForm: IvcmEntityForm);
  function IsInBF(const aForm: IvcmEntityForm): Boolean;
 end;//TvcmTabsHistoryService
 
implementation

uses
 l3ImplUses
 , l3TabbedContainersDispatcher
 , Forms
 , SysUtils
 , vcmBase
 , vcmFormSetHistory
;

end.
