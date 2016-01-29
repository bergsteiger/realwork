unit nscTasksPanel;

interface

uses
 l3IntfUses
 , vcmTasksPanel
 , vcmTaskPanelInterfaces
 , nscTasksPanelGroupDescList
 , afwInterfaces
 , vcmExternalInterfaces
;

type
 TnscTasksPanel = class(TvcmCustOpsNotifier, IvcmCustOps)
  {* Наполнение Панели Задач }
  procedure Create(const aBaseSettingId: TafwSettingId;
   const aGroups: TnscTasksPanelGroupDescArray);
  function Make(const aBaseSettingId: TafwSettingId;
   const aGroups: TnscTasksPanelGroupDescArray): IvcmCustOps;
  function AddRepGroup(const aGroup: IvcmCString): IvcmCustOpsRepGroup;
   {* добавить группу репозитория }
  procedure DeleteRepGroup(const aGroup: IvcmCustOpsRepGroup);
   {* удалить группу репозитория }
  function AddGroup(const aRepGroup: IvcmCustOpsRepGroup;
   aPosition: Integer): IvcmCustOpsGroup;
  procedure Refresh;
   {* полностью перечитать операции панели задач. Используется при
              переключении конфигурации }
  function RepGroupsOperations: IvcmCustOpsRepGroupsOperationsIterator;
   {* группы операций доступные для выбора в панели задач }
  function RepGroups: IvcmCustOpsRepGroupsIterator;
   {* репозиторий групп панели задач. При формирование панели задач
              пользователь может использовать уже созданные группы }
  function Groups: IvcmCustOpsGroupsIterator;
   {* группы панели задач }
  function BaseSettingId: TafwSettingId;
   {* базовый идентификатор настроек панели задач. Используется для
              записи данных связанных с панелью задач }
  function EnableSaveToSettings: Boolean;
   {* Разрешаем/запрещаем запись, делаем запись только в режиме редактирования ПЗ }
 end;//TnscTasksPanel
 
implementation

uses
 l3ImplUses
 , nscTasksPanelGroupsIterator
 , SysUtils
 , l3Base
;

end.
