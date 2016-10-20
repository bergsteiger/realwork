unit vcmTasksPanel;
{* Панель задач. Является альтернативой панелей инструментов. }

// Библиотека : "vcm";
// Автор      : Морозов М.А.;
// Модуль     : vcmCustOps - Панель задач.
// Начат      : 22.02.2007                     
// Версия     : $Id: vcmTasksPanel.pas,v 1.120 2016/10/17 13:18:38 kostitsin Exp $

(*-------------------------------------------------------------------------------
  $Log: vcmTasksPanel.pas,v $
  Revision 1.120  2016/10/17 13:18:38  kostitsin
  {requestlink: 632194223 }

  Revision 1.119  2016/09/13 18:32:46  kostitsin
  {requestlink: 630194905 }

  Revision 1.118  2014/02/17 16:25:57  lulin
  - избавляемся от ошибок молодости.

  Revision 1.117  2014/02/14 16:27:09  lulin
  - избавляемся от ошибок молодости.

  Revision 1.116  2013/12/26 13:19:36  lulin
  {RequestLink:509706011}

  Revision 1.115  2012/11/23 08:23:37  kostitsin
  чиню сборку

  Revision 1.114  2012/11/22 11:53:06  kostitsin
  [$407738353]

  Revision 1.113  2012/11/02 17:00:45  kostitsin
  [$407747895]

  Revision 1.112  2012/11/02 08:28:00  lulin
  - правим за Мишей.

  Revision 1.111  2012/11/01 14:40:50  kostitsin
  [$407743861]

  Revision 1.110  2012/10/31 14:58:02  kostitsin
  переименовал методы Notify на двух интерфейсах

  Revision 1.109  2012/10/03 11:09:20  lulin
  {RequestLink:398275923}

  Revision 1.108  2012/06/01 10:03:57  lulin
  {RequestLink:269058296}

  Revision 1.107  2012/04/09 08:38:54  lulin
  {RequestLink:237994598}
  - думаем о VGScene.

  Revision 1.106  2012/03/02 14:20:14  gensnet
  http://mdp.garant.ru/pages/viewpage.action?pageId=289932821

  Revision 1.105  2012/03/02 09:42:10  gensnet
  http://mdp.garant.ru/pages/viewpage.action?pageId=342336964

  Revision 1.104  2011/05/19 12:20:44  lulin
  {RequestLink:266409354}.

  Revision 1.103  2011/03/15 17:03:28  lulin
  {RequestLink:228688510}.
  - чистим мусорок.

  Revision 1.102  2011/03/15 16:19:38  lulin
  {RequestLink:228688510}.
  [$255978845].
  [$255983129].
  - не даём таскать сплиттер у толкования без перевода.

  Revision 1.101  2011/03/15 13:50:42  lulin
  {RequestLink:228688510}.
  - №6.

  Revision 1.100  2011/01/17 19:28:59  lulin
  {RequestLink:248195582}.
  - в нулевом приближении встроил объекты оглавления в ПЗ.

  Revision 1.99  2009/12/11 16:45:03  lulin
  - удаляем устаревший шаблон.

  Revision 1.98  2009/12/11 16:25:21  lulin
  - убираем излишнюю общность.

  Revision 1.97  2009/12/11 15:56:07  lulin
  {RequestLink:172984520}.

  Revision 1.96  2009/12/11 14:14:40  lulin
  {RequestLink:172984520}.

  Revision 1.95  2009/09/02 11:48:53  lulin
  {RequestLink:159360578}. №20.

  Revision 1.94  2009/08/03 18:40:37  lulin
  - используем предусловия.

  Revision 1.93  2009/08/03 18:26:08  lulin
  - убираем заточки на предмет наличия иконок. Пусть УМ настраивает доступные.

  Revision 1.92  2009/07/30 16:43:14  lulin
  - думаем о генерации кусков StdRes.

  Revision 1.91  2009/07/30 16:19:55  lulin
  {RequestLink:129240934}. №4.

  Revision 1.90  2009/07/20 12:49:35  lulin
  - подготавливаемся к переносу изменений в ветку.

  Revision 1.89  2009/03/18 09:28:41  oman
  - fix: Возвращаем префикс-группу (К-139441026)

  Revision 1.88  2009/02/20 15:18:56  lulin
  - <K>: 136941122.

  Revision 1.87  2009/02/20 13:07:04  lulin
  - <K>: 136941122.

  Revision 1.86  2009/02/12 17:09:12  lulin
  - <K>: 135604584. Выделен модуль с внутренними константами.

  Revision 1.85  2009/02/12 13:33:56  lulin
  - <K>: 135604584. Выделен новый интерфейсный модуль.

  Revision 1.84  2009/01/22 08:55:33  lulin
  - <K>: 135605082.

  Revision 1.83  2009/01/22 08:25:47  lulin
  - <K>: 135605082.

  Revision 1.82  2008/12/12 19:19:23  lulin
  - <K>: 129762414.

  Revision 1.81  2008/11/11 14:29:10  lulin
  - <K>: 122662590.

  Revision 1.80  2008/09/03 10:02:42  mmorozov
  - rollback: предыдущий комит отменен, решили делать по другому (<K> - 113180843);

  Revision 1.79  2008/09/03 07:17:02  mmorozov
  - new behaviour: для выбора доступны визуальные операции без иконки (http://mdp.garant.ru/pages/viewpage.action?pageId=99647913&focusedCommentId=113180683#comment-113180683);

  Revision 1.78  2008/08/07 14:43:07  mmorozov
  - bugfix: игнорировались операции с одинаковыми позициями (K<106988046>);

  Revision 1.77  2008/07/22 07:47:54  mmorozov
  - bugfix: удаляем из списка с проверкой индекса.

  Revision 1.76  2008/07/09 12:36:57  lulin
  - чистка кода.

  Revision 1.75  2008/06/26 05:27:02  oman
  Не собирались

  Revision 1.74  2008/06/25 12:34:06  mmorozov
  - new: Оптимизация панелей инструментов ... Сортируем операции  (CQ: OIT5-28281);

  Revision 1.73  2008/06/25 09:24:10  mmorozov
  - new: Оптимизация панелей инструментов ---|> в списке доступных форм показываем только объединенные панели инструментов + рефакторинг + список форм проекта при редактировании доступных для выбора операций (CQ: OIT5-28281);

  Revision 1.72  2008/06/17 07:25:17  mmorozov
  - не собиралась библиотека.

  Revision 1.71  2008/06/05 13:05:23  mmorozov
  Оптимизация панелей инструментов (CQ: OIT5-28281):
  - одинаковая настройка для объединенных панелей инструментов.
  - доступность операций в контекстном меню панели инструментов.
  - идентфикатор для формы включает не только имя типа но и имя формы.

  Revision 1.70  2008/06/04 10:51:20  mmorozov
  - new: возможность найстройки доступных для редактирования панели инструментов операций (CQ: OIT5-28281);

  Revision 1.69  2008/03/20 09:48:17  lulin
  - cleanup.

  Revision 1.68  2008/02/07 14:44:27  lulin
  - класс _Tl3LongintList переехал в собственный модуль.

  Revision 1.67  2007/10/03 12:54:55  mmorozov
  - change comment;

  Revision 1.66  2007/09/17 12:04:52  mmorozov
  - new: в интерфейс слушаетеля разблокировки добавлено событие, для контроля ситуации когда переходные процессы уже закончились, но отрисовка визуалки ещё запрещена, используется в панели задач чтобы раньше времени не отрисовывались полосы прокрутки (в рамках CQ: OIT5-26623);

  Revision 1.65  2007/09/17 10:42:48  mmorozov
  New:
  - выделен интерфейс для получения уведомления о блокировке\разблокировки диспетчера форм на время выполенения операций модуля любым желающим (раньше только IvcmForm);
  - панель задач должна работать побыстрее, посколько перечитываем операции после добавления последней формы прецедента, а не каждой как это было раньше;
  - избавились от анимации в панели задач, при навигации между прецедентами;
  - почищен код;

  В рамках задачи CQ: OIT5-26623;

  Revision 1.64  2007/07/25 09:55:15  mmorozov
  - add comments;

  Revision 1.63  2007/07/12 09:29:06  mmorozov
  - bugfix: при формировании идентификатора формы, если тип формы неопрделен используем идентификатор формы (CQ: OIT5-25860, 25786), также смотри K<28508173>;

  Revision 1.62  2007/06/29 19:08:52  mmorozov
  - new behaviour: при удалении операции из панели задач сбрасываем имя операции в умолчательное;

  Revision 1.61  2007/06/26 10:13:50  mmorozov
  - new behaviour: в списке доступных операций отображаем названия по умолчанию для операций, при переносе доступной операции в панель задач ей присваивается пользовательское название, если установлено (CQ: OIT5-25764);

  Revision 1.60  2007/06/26 09:41:45  mmorozov
  - new behaviour: управление состоянием операции представления панели задач (CQ: OIT5-25474);

  Revision 1.59  2007/06/25 12:01:02  mmorozov
  - bugfix: при публикации операции на панель задач используем название IvcmOperationDef.Caption (заданное во время разработки) вместо Action.Caption, т.к. последнее может меняться в процессе использования (CQ: OIT5-25752);

  Revision 1.58  2007/06/20 06:52:19  mmorozov
  - change: переименована процедура;

  Revision 1.57  2007/06/19 13:13:19  mmorozov
  - bugfix: переставлялись группы/операции в следствии того, что использовались позиции по умолчанию для групп/операций; избавляемся от одинаковых позиций операций/групп, которые могут иметь место по причине первого открытия в прецеденте группы/операции для всех панелей задач добавленных в другом прецеденте (CQ: OIT5-25626);

  Revision 1.56  2007/06/18 13:49:01  mmorozov
  - new behaviour: при открытии нового прецедента сначала удаляем формы из панели задач потом регистрируем новые, алгоритм по которому выполнены измнения см. в К<18219426>;

  Revision 1.55  2007/06/18 11:16:37  mmorozov
  - new behaviour: в репозитории показываеются уже измененные пользовательские названия операций + к имени операции добавляется название сущности (CQ: OIT5-25697);
  - change: изменен путь сохранения названий операций формы, из пути удалена информация о форме (CQ: OIT5-25697);

  Revision 1.54  2007/06/13 08:59:10  mmorozov
  - bugfix: переставлялись позиции операций/групп (CQ: OIT5-25626);
  - change: операции/группы панели задач теперь хранятся в несортировнном виде, ответственность за сортировку ложится на плечи представления панели задач (редактор и представление);

  Revision 1.53  2007/06/09 09:49:22  mmorozov
  - change: метод переименован;
  - warning fix: неопределялось значение функции;

  Revision 1.52  2007/06/06 12:01:31  lulin
  - избавляемся от вредоносного параметра по-умолчанию (<K>-16352239).

  Revision 1.51  2007/06/05 16:19:00  mmorozov
  - change: comment;

  Revision 1.50  2007/06/05 16:14:42  mmorozov
  - new behavior: обновляем позиции операций при смене прецедента (в рамках работы над CQ: OIT5-25344);
  - new: выделен алгорим обновления позиций групп/операций;

  Revision 1.49  2007/06/05 14:48:45  mmorozov
  - change: comment;

  Revision 1.48  2007/06/05 14:11:29  mmorozov
  - bugfix: при смене текущего прецедента не перечитывались позиции групп (в рамках работы над CQ: OIT5-25344);

  Revision 1.47  2007/06/05 10:20:19  mmorozov
  - change: именам классов добавлен правильный префикс;

  Revision 1.46  2007/06/05 10:05:58  mmorozov
  - change: свойства и методы переименованы в соответствии с назначением;

  Revision 1.45  2007/06/04 12:42:47  mmorozov
  - new: свойство для получения группы по индексу;

  Revision 1.44  2007/06/04 12:21:51  mmorozov
  - change: выжимаем из метода суть, детали размещаем в локальных процедурах;

  Revision 1.43  2007/04/11 07:22:39  mmorozov
  - new: выделены методы для создания Action (BuildAction);

  Revision 1.42  2007/04/10 13:20:08  lulin
  - используем строки с кодировкой.

  Revision 1.41  2007/04/05 14:59:54  mmorozov
  - библиотека не собиралась;

  Revision 1.40  2007/04/05 13:42:28  mmorozov
  - new: удаляем операции групп репозитория, которые были удалены;

  Revision 1.39  2007/04/05 13:05:56  mmorozov
  - new: группы с операциями формы обозначаем "звездочкой";

  Revision 1.38  2007/04/05 10:37:35  mmorozov
  - new: возможность полного обновления панели задач;

  Revision 1.37  2007/04/05 09:49:02  mmorozov
  - new: обрамляем скобками обновления при удалении формы;

  Revision 1.36  2007/04/05 08:38:43  mmorozov
  - new: не перерисовываем и не перестраиваем панель задач, во время обновления операций;

  Revision 1.35  2007/04/05 07:59:23  lulin
  - избавляемся от лишних преобразований строк при записи в настройки.

  Revision 1.34  2007/04/05 06:18:46  oman
  Не собиралась библиотека

  Revision 1.33  2007/04/04 13:14:37  mmorozov
  - change: для работы с настройками используем типы и функции vcmSettings;

  Revision 1.32  2007/04/03 07:58:56  mmorozov
  - bugfix: освобождаем Action;

  Revision 1.31  2007/04/03 06:44:17  mmorozov
  - change: для обхода операций формы используем итераторы;

  Revision 1.30  2007/03/30 15:10:46  mmorozov
  - пишем покороче и попонятнее;

  Revision 1.29  2007/03/30 14:37:26  mmorozov
  - new: показываем выпадающее меню для combo операций;

  Revision 1.28  2007/03/29 12:58:39  mmorozov
  - new behaviour: используем имя формы при построении пути в настройки;

  Revision 1.27  2007/03/28 14:30:34  mmorozov
  - bugfix: при создании группы не устанавливалась позиция;

  Revision 1.26  2007/03/28 06:45:55  mmorozov
  - библиотека не собиралась;

  Revision 1.25  2007/03/27 14:00:24  mmorozov
  - new: сортировка операций\групп панели задач, реакция представления на изменение позиций групп\операций;

  Revision 1.24  2007/03/27 10:27:12  mmorozov
  - new: представление реагирует на изменение названий операций\групп, на изменение позиции операции;

  Revision 1.23  2007/03/27 07:51:54  mmorozov
  - change: чтение\запись позиций операций;

  Revision 1.22  2007/03/26 12:25:02  mmorozov
  - bugfix: проверяем перед использованием наличие у формы _CurUserTypeDef;

  Revision 1.21  2007/03/26 10:48:54  mmorozov
  - bugfix: результат не возвращался;

  Revision 1.20  2007/03/26 10:30:43  mmorozov
  - bugfix: правильно оформляем логические условия в директивах компиляции;

  Revision 1.19  2007/03/26 10:10:09  mmorozov
  - new: используем директиву vcmUseSettings;

  Revision 1.18  2007/03/23 12:56:13  mmorozov
  - в рамках работы над представлением панели задач, представление обновляет своё содержимое при изменении данных;

  Revision 1.17  2007/03/23 07:29:32  mmorozov
  - cleanup: неиспользуемый итератор операций;

  Revision 1.16  2007/03/22 08:39:15  mmorozov
  - new: при удалении всех операций из группы последняя тоже удаляется;

  Revision 1.15  2007/03/21 15:56:57  mmorozov
  - new: выделены общие интерфейсы\классы для элементов панели задач в редакторе и компоненте;
  - new: определение позиции группы в панели задач;

  Revision 1.14  2007/03/21 12:22:03  mmorozov
  - new: работа с признаком операции "Для всех панелей задач";

  Revision 1.13  2007/03/21 11:27:57  mmorozov
  - new: расставляем операции в соответствии с позицией;

  Revision 1.12  2007/03/20 15:27:09  mmorozov
  - new: изменение позиций операций\групп;

  Revision 1.11  2007/03/20 09:29:24  mmorozov
  - new: используем Caption операции панели задач, а не операции репозитория;

  Revision 1.10  2007/03/19 13:15:07  mmorozov
  - new: удаление операций (групп) из панели задач;

  Revision 1.9  2007/03/19 06:36:26  mmorozov
  - обновление состава операций панели задач при смене форм;

  Revision 1.8  2007/03/16 12:21:25  lulin
  - переводим на строки с кодировкой.

  Revision 1.7  2007/03/15 08:27:13  mmorozov
  - new: не показываем группу репозитория в редакторе, если она используется в панели задач;

  Revision 1.6  2007/03/15 07:08:59  mmorozov
  - в рамках работы над панелью задач;

  Revision 1.5  2007/03/14 06:53:28  mmorozov
  - new: у каждой главной формы свой компонент панели задач;

  Revision 1.4  2007/03/07 12:03:50  mmorozov
  - new: сохранение, загрузка, редактирования групп репозитория;

  Revision 1.3  2007/03/06 14:27:23  mmorozov
  - change: вместо Tl3PCharLen используем _Il3CString;

  Revision 1.2  2007/03/06 13:45:09  mmorozov
  - библиотека не компилировалась;

  Revision 1.1  2007/03/06 13:35:52  mmorozov
  - new: панель задач;

-------------------------------------------------------------------------------*)

interface

{$Include vcmDefine.inc}

uses
  ActnList,
  Classes,
  Controls,

  afwInterfaces,

  l3Types,
  l3Base,
  l3String,
  l3IID,
  l3LongintList,
  l3NotifyPtrList,
  l3Interfaces,
  l3CObjectRefList,
  l3ProtoObject,
  l3SimpleObject,

  vcmExternalInterfaces,
  vcmUserControls,
  vcmInterfaces,
  vcmBase,
  vcmSettings,

  vcmTaskPanelInterfaces
  ;

type
  TvcmCustOpsList = Tl3CObjectRefList;
  TvcmCustOpsGroupOp     = class;
  TvcmCustOpsGroup       = class;

   _l3Notifier_Parent_ = Tl3Base;
   {$Include l3Notifier.imp.pas}
   _Ancestor_ = _l3Notifier_;
  TvcmCustOpsNotifier = class(_Ancestor_)
  {* Класс с возможностью уведомления об изменениях. }
  protected
      procedure CallInterfaceNotify(aOperation: Integer; const aInterface: IvcmBase);
        {* - прошла операция. }
  end;//TvcmCustOpsNotifier

  TvcmCustOps = class(TvcmCustOpsNotifier,
                      IvcmCustOps,
                      IvcmCustOpsRepository,
                      IvcmLockListener)
  {* Панель задач. }
  private
  // fields
    f_Groups                : TvcmCustOpsList;
    f_RepGroups             : TvcmCustOpsList;
    f_RepGroupsOperations   : TvcmCustOpsList;
    f_CurrentUseCasePath    : TvcmPathPairs;
    f_ActionOwner           : TComponent;
    f_UpdatePositionByOrder : Boolean;
    f_EnableSaveToSettings  : Boolean;
    f_LastAddedForm         : IvcmEntityForm;
    f_Locked                : Integer;
    f_SettingsPath          : TvcmPathPair;
    f_RepGroupsPath         : TvcmPathPairs;
  protected
  // IvcmCustOps
    function pm_GetEnableSaveToSettings: boolean;
      {-}
    procedure pm_SetEnableSaveToSettings(aValue: boolean);
      {-}
    function pm_GetGroups: IvcmCustOpsGroupsIterator;
      {* - группы панели задач. }
    function pm_GetRepGroups: IvcmCustOpsRepGroupsIterator;
      {-}
    function pm_GetRepGroupsOperations: IvcmCustOpsRepGroupsOperationsIterator;
      {-}
    function pm_GetBaseSettingId: TafwSettingId;
      {* - базовый идентификатор настроек панели задач. Используется для
           записи данных связанных с панелью задач. }
    procedure AddModule(const aModule: IvcmModuleDef);
      {-}
    procedure AddForm(const aForm: IvcmEntityForm);
      {* - зарегистрировать форму. }
    procedure RemoveForm(const aForm: IvcmEntityForm);
      {-}
    function AddRepGroup(const aGroup: IvcmCString): IvcmCustOpsRepGroup;
      {* - добавить группу репозитория. }
    procedure DeleteRepGroup(const aGroup: IvcmCustOpsRepGroup);
      {* - удалить группу репозитория. }
    function AddGroup(const aRepGroup : IvcmCustOpsRepGroup;
                      aPosition : Integer): IvcmCustOpsGroup;
      overload;
      {-}
    procedure Refresh;
      {* - полностью перечитать операции панели задач. Используется при
           переключении конфигурации. }
  protected
  // IvcmLockListener
    procedure IvcmLockListener_Lock;
    procedure IvcmLockListener.Lock = IvcmLockListener_Lock;
        {* - отрисовка запрещена. }
    procedure IvcmLockListener_BeforeUnlock;
    procedure IvcmLockListener.BeforeUnlock = IvcmLockListener_BeforeUnlock;
      {* - переходные процессы уже завершились, но отрисовка ещё запрещена. }
    procedure IvcmLockListener_UnLock;
    procedure IvcmLockListener.UnLock = IvcmLockListener_UnLock;
        {* - отрисовка разрешена. }
  private
  // property methods
    function pm_GetIntGroups: TvcmCustOpsList;
      {-}
    function pm_GetIntRepGroups: TvcmCustOpsList;
      {-}
    function pm_GetIntRepGroupsOperations: TvcmCustOpsList;
      {-}
    function pm_GetActionOwner: TComponent;
      {* - собственник создаваемых Action. }
    function pm_GetGroup(const aIndex: Integer): TvcmCustOpsGroup;
      {-}
  private
  // methods
    procedure SaveRepGroups;
      {* - сохранить группы в настройки. }
    function FindRepGroup(const aGroupId: Integer): IvcmCustOpsRepGroup;
      {-}
    function FindGroup(const aGroupId: Integer): TvcmCustOpsGroup;
      {-}
    procedure MoveToGroup(const aGroupId : Integer;
                          const aOp      : TvcmCustOpsGroupOp);
      {* - переместить операцию в другую группу. }
    procedure AddGroup(const aRepGroup : IvcmCustOpsRepGroup;
                       out aGroup      : TvcmCustOpsGroup;
                       aPosition : Integer = -1);
      overload;
      {-}
    procedure BeforeUpdate;
      {-}
    procedure AfterUpdate;
      {-}
    procedure UpdateOperations;
      {-}
    procedure RemoveOperations(const anAll: Boolean = False);
      {* - удалить операции панели задач. }
  protected
  // methods
    function AnalyzeOpForCurrentUseCase: Boolean;
      virtual;
      {-}
    procedure Cleanup;
      override;
      {-}
    function MakeRepGroupId: Integer;
      {* - создать идентификатор для группы репозитория. }
  protected
  // properties
    property RepGroupsPath: TvcmPathPairs
      read f_RepGroupsPath
      write f_RepGroupsPath;
      {-}
    property SettingsPath: TvcmPathPair
      read f_SettingsPath;
      {* - базовый путь для записи в настройки. }
    property LastAddedForm: IvcmEntityForm
      read f_LastAddedForm
      write f_LastAddedForm;
      {* - последняя добавленна форма в представлении прецедента, нужна для
           формирования идентификатора прецедента. }
    property RepGroups: TvcmCustOpsList
      read pm_GetIntRepGroups;
      {-}
    property RepGroupsOperations: TvcmCustOpsList
      read pm_GetIntRepGroupsOperations;
      {-}
    property Groups: TvcmCustOpsList
      read pm_GetIntGroups;
      {-}
    property Group[const aIndex: Integer]: TvcmCustOpsGroup
      read pm_GetGroup;
      {-}
    property CurrentUseCasePath: TvcmPathPairs
      read f_CurrentUseCasePath;
      {* - идентификатор настройки, используемый для записи операций зависимых
           от текущей формы. }
    property ActionOwner: TComponent
      read pm_GetActionOwner;
      {* - собственник создаваемых Action. }
    property UpdatePositionByOrder: Boolean
      read f_UpdatePositionByOrder
      write f_UpdatePositionByOrder;
      {* - определяет необходимость обновить позиции операций/групп по текущей
           позиции. Это нужно для того, чтобы удалить повторяющиеся
           идентификаторы, когда операция/группа впервые открывается в данном
           прецеденте. }
    property EnableSaveToSettings: Boolean
      read pm_GetEnableSaveToSettings
      write pm_SetEnableSaveToSettings;
      {* - разрешаем/запрещаем запись, делаем запись только в режиме редактирования ПЗ.}
  public
  // methods
    constructor Create(const aSettingsPath: String);
      reintroduce;
      overload;
      {-}
    function As_Il3ChangeNotifier: Il3ChangeNotifier;
  end;//TvcmTaskPanel

  {----------------------------------------------------------------------------}
  { Types                                                                      }
  {----------------------------------------------------------------------------}
  TvcmCustOpsState = (
   {* Состояние объекта панели задач. }
    tp_sFree,
    tp_sUse
  );//TvcmCustOpsState
  {----------------------------------------------------------------------------}
  { Interfaces                                                                 }
  {----------------------------------------------------------------------------}
  IvcmIntState = interface(IUnknown)
   {* Состояние объекта. }
    ['{F5834727-02C7-423C-AF4E-5E10C30DD334}']
    // property methods
      function pm_GetState: TvcmCustOpsState;
      procedure pm_SetState(const aValue: TvcmCustOpsState);
        {-}
    // properties
      property State: TvcmCustOpsState
        read pm_GetState
        write pm_SetState;
        {-}
  end;//IvcmIntState
  IvcmIntRepOp = interface(IUnknown)
   {* Внутренний интерфейс операции репозитория. }
    ['{5BE879D5-6247-4469-A9D6-0F65B7E2CA85}']
    // property methods
      function pm_GetIsDefaultUserCaption: Boolean;
        {* - определяет была ли переименована операция для панели задач. }
    // public
      function CurrentUseCasePath: TvcmPathPairs;
        {-}
      function ForAllUseCasesPath: TvcmPathPairs;
        {-}
      function CaptionPath: TvcmPathPairs;
        {-}
    // properties
      property IsDefaultUserCaption: Boolean
        read pm_GetIsDefaultUserCaption;
        {* - определяет была ли переименована операция для панели задач. }
  end;//IvcmIntRepOp
  {----------------------------------------------------------------------------}
  { Classes                                                                    }
  {----------------------------------------------------------------------------}
  TvcmCustOpsRepGroupOps = class;

  TvcmCustOpsBaseIterator = class(TvcmBase)
  {* Базовый итератор элементов списка панели задач. }
  private
  // fields
    f_Index : Integer;
    f_List  : TvcmCustOpsList;
  protected
  // methods
    function DoNext: TObject;
      {-}
  public
  // methods
    constructor Create(const aList: TvcmCustOpsList);
      reintroduce;
      {-}
  end;//TvcmCustOpsBaseIterator

  TvcmCustOpsRepOpsIterator = class(TvcmCustOpsBaseIterator,
                                       IvcmCustOpsRepOperationsIterator)
  {* Итератор операций группы репозитория. }
  private
  // IvcmCustOpsRepOperationsIterator
    function Next: IvcmCustOpsRepOperation;
      {-}
  public
  // methods
    class function Make(const aList: TvcmCustOpsList): IvcmCustOpsRepOperationsIterator;
      {-}
  end;//TvcmCustOpsRepOpsIterator

  TvcmCustOpsRepGroupsOpsIterator = class(TvcmCustOpsBaseIterator,
                                             IvcmCustOpsRepGroupsOperationsIterator)
  {* Итератор групп репозитория. }
  private
  // IvcmCustOpsRepOperationsIterator
    function Next: IvcmCustOpsRepGroupOperations;
      {-}
  public
  // methods
    class function Make(const aList: TvcmCustOpsList): IvcmCustOpsRepGroupsOperationsIterator;
      {-}
  end;//TvcmCustOpsRepOpsIterator

  TvcmCustOpsGroupsIterator = class(TvcmCustOpsBaseIterator,
                                IvcmCustOpsGroupsIterator)
  {* Итератор групп панели задач. }
  private
  // IvcmCustOpsRepOperationsIterator
    function Next: IvcmCustOpsGroup;
      {-}
  public
  // methods
    class function Make(const aList: TvcmCustOpsList): IvcmCustOpsGroupsIterator;
      {-}
  end;//TvcmCustOpsGroupsIterator

  TvcmCustOpsGroupOpsIterator = class(TvcmCustOpsBaseIterator,
                                         IvcmCustOpsGroupOperationsIterator)
  {* Итератор операций групп панели задач. }
  private
  // IvcmCustOpsOperationsIterator
    function Next: IvcmCustOpsGroupOperation;
      {-}
  public
  // methods
    class function Make(const aList: TvcmCustOpsList): IvcmCustOpsGroupOperationsIterator;
      {-}
  end;//TvcmCustOpsGroupOpsIterator

  TvcmCustOpsBase = class(TvcmCustOpsNotifier)
  {* Базовый класс панели задач. }
  private
  // fields
    f_TasksPanel : TvcmCustOps;
  protected
  // properties
    property TasksPanel: TvcmCustOps
      read f_TasksPanel;
      {-}
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
  public
  // methods
    constructor Create(const aTasksPanel: TvcmCustOps);
      reintroduce;
      virtual;
      {-}
  end;//TvcmCustOpsBase

  TvcmCustOpsListItem = class(TvcmCustOpsBase)
  {* Базовый класс элемента списка панели задач. }
  private
  // fields
    f_List: TvcmCustOpsList;
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
  protected
  // properties
    property List: TvcmCustOpsList
      read f_List
      write f_List;
      {-}
  public
  // methods
    constructor Create(const aTasksPanel : TvcmCustOps;
                       const aList       : TvcmCustOpsList);
      reintroduce;
      virtual;
      {-}
    procedure Remove;
      virtual;
      {-}
  end;//TvcmCustOpsListItem

  TvcmCustOpsOp = class(TvcmCustOpsListItem,
                           IvcmCustOpsOperation)
  {* Операция панели задач. }
  private
  // fields
    f_Action: TCustomAction;
  protected
  // IvcmCustOpsOperations
    function pm_GetAction: TCustomAction;
      {-}
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
  protected
  // properties
    property Action: TCustomAction
      read f_Action;
      {-}
  public
  // methods
    constructor Create(const aTasksPanel : TvcmCustOps;
                       const aList       : TvcmCustOpsList;
                       const aAction     : TCustomAction);
      reintroduce;
      virtual;
      {-}
  end;//TvcmCustOpsOp

  TvcmCustOpsRepOp = class(TvcmCustOpsOp,
                              IvcmIntRepOp,
                              IvcmIntState,
                              IvcmCustOpsRepOperation)
  {* Операция репозитория. }
  private
  // fields
    f_RepGroup    : TvcmCustOpsRepGroupOps;
    f_State       : TvcmCustOpsState;
    f_OpDef       : IvcmOperationDef;
    f_UserCaption : IvcmCString;
  private
  // IvcmCustOpsRepOperation
    function pm_GetGroup: IvcmCustOpsRepGroupOperations;
      {* - группа репозитария к которой привязана операция. }
  protected
  // IvcmIntRepOp
    // property methods
      function pm_GetState: TvcmCustOpsState;
      procedure pm_SetState(const aValue: TvcmCustOpsState);
        {-}
      function pm_GetIsDefaultUserCaption: Boolean;
        {* - определяет была ли переименована операция для панели задач. }
      function pm_GetUserCaption: IvcmCString;
      procedure pm_SetUserCaption(const aValue: IvcmCString);
        {* - пользовательское название операции. Вычитывается из настроек, если
             в настройках название не определено, то используется название
             операции. }
      function pm_GetCaption: IvcmCString;
        virtual;
        {* - название используемое для отображения в репозитории. }
    // public methods
      function CurrentUseCasePath: TvcmPathPairs;
        virtual;
        {-}
      function ForAllUseCasesPath: TvcmPathPairs;
        virtual;
        {-}
      function CaptionPath: TvcmPathPairs;
        virtual;
        {-}
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
  protected
  // properties
    property State: TvcmCustOpsState
      read pm_GetState
      write pm_SetState;
      {-}
    property OpDef: IvcmOperationDef
      read f_OpDef
      write f_OpDef;
      {-}
    property UserCaption: IvcmCString
      read pm_GetUserCaption;
      {-}
  public
  // methods
    constructor Create(const aTasksPanel : TvcmCustOps;
                       const aRepGroup   : TvcmCustOpsRepGroupOps;
                       const aAction     : TCustomAction;
                       const aOpDef      : IvcmOperationDef);
      reintroduce;
      {-}
    procedure Remove;
      override;
      {-}
    function COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
      override;
      {-}
      function As_Il3ChangeNotifier: Il3ChangeNotifier;       
  end;//TvcmCustOpsRepOp

  TvcmCustOpsRepGroupOps = class(TvcmCustOpsListItem,
                                    IvcmCustOpsRepGroupOperations)
  {* Группа операций репозитория. }
  private
  // fields
    f_Operations: TvcmCustOpsList;
  protected
  // IvcmCustOpsRepGroupOperations
    function pm_GetOperations: IvcmCustOpsRepOperationsIterator;
      {-}
    function pm_GetCaption: IvcmCString;
      virtual;
      {-}
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
  protected
  // properties
    property Operations: TvcmCustOpsList
      read f_Operations;
      {-}
  public
  // methods
    constructor Create(const aTasksPanel : TvcmCustOps;
                       const aList       : TvcmCustOpsList);
      override;
      {-}
  end;//TvcmCustOpsGroupOperations

  TvcmCustOpsRepMoOps = class(TvcmCustOpsRepGroupOps)
  {* Группа операций репозитория, для модулей. }
  private
  // fields
    f_Module: IvcmModuleDef;
  private
  // methods
    procedure LoadOperations;
      {-}
  protected
  // property methods
    function pm_GetCaption: IvcmCString;
      override;
      {-}
  protected
  // methods
    property Module: IvcmModuleDef
      read f_Module;
      {-}
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
  public
  // methods
    constructor Create(const aTasksPanel : TvcmCustOps;
                       const aList       : TvcmCustOpsList;
                       const aModule     : IvcmModuleDef);
      reintroduce;
      {-}
  end;//TvcmCustOpsRepMoOps

  TvcmCustOpsRepEnOps = class(TvcmCustOpsRepGroupOps)
  {* Группа операций репозитория, для форм. }
  private
  // fields
    f_Form: IvcmEntityForm;
  protected
  // property methods
    function pm_GetCaption: IvcmCString;
      override;
      {-}
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
  protected
  // properties
    property Form: IvcmEntityForm
      read f_Form
      write f_Form;
      {-}
  public
  // methods
    constructor Create(const aTasksPanel : TvcmCustOps;
                       const aList       : TvcmCustOpsList;
                       const aForm       : IvcmEntityForm);
      reintroduce;
      {-}
  end;//TvcmCustOpsRepEnOps

  TvcmCustOpsRepMoOp = class(TvcmCustOpsRepOp)
  {* Операция репозитория, для операций модуля. }
  private
  // fields
    f_ModuleDef : IvcmModuleDef;
  protected
  // IvcmCustOpsRepOperation
    // property methods
      function pm_GetCaption: IvcmCString;
        override;
        {* - название используемое для отображения в репозитории. }
  protected
  // IvcmIntRepOp
    function CurrentUseCasePath: TvcmPathPairs;
      override;
      {-}
    function ForAllUseCasesPath: TvcmPathPairs;
      override;
      {-}
    function CaptionPath: TvcmPathPairs;
      override;
      {-}
  protected
  // property
    property ModuleDef: IvcmModuleDef
      read f_ModuleDef
      write f_ModuleDef;
      {-}
  public
  // methods
    constructor Create(const aTasksPanel : TvcmCustOps;
                       const aRepGroup   : TvcmCustOpsRepGroupOps;
                       const aModuleDef  : IvcmModuleDef;
                       const aOpDef      : IvcmOperationDef);
      reintroduce;
      {-}
    class function Make(const aTasksPanel : TvcmCustOps;
                        const aRepGroup   : TvcmCustOpsRepGroupOps;
                        const aModuleDef  : IvcmModuleDef;
                        const aOpDef      : IvcmOperationDef): IvcmCustOpsOperation;
      {-}
    function COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
      override;
      {-}
  end;//TvcmCustOpsRepMoOp

  TvcmCustOpsRepEnOp = class(TvcmCustOpsRepOp)
  {* Операция репозитория, для операций формы. }
  private
  // fields
    f_Form      : IvcmEntityForm;
    f_EntityDef : IvcmEntityDef;
  protected
  // IvcmCustOpsRepOperation
    // property methods
      function pm_GetCaption: IvcmCString;
        override;
        {* - название используемое для отображения в репозитории. }
  protected
  // IvcmIntRepOp
    function CurrentUseCasePath: TvcmPathPairs;
      override;
      {-}
    function ForAllUseCasesPath: TvcmPathPairs;
      override;
      {-}
    function CaptionPath: TvcmPathPairs;
      override;
      {-}
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
  protected
  // properties
    property Form: IvcmEntityForm
      read f_Form
      write f_Form;
      {-}
    property EntityDef: IvcmEntityDef
      read f_EntityDef;
      {-}
  public
  // methods
    constructor Create(const aTasksPanel : TvcmCustOps;
                       const aRepGroup   : TvcmCustOpsRepGroupOps;
                       const aForm       : IvcmEntityForm;
                       const aEntityDef  : IvcmEntityDef;
                       const aOpDef      : IvcmOperationDef);
      reintroduce;
      {-}
    class function Make(const aTasksPanel : TvcmCustOps;
                        const aRepGroup   : TvcmCustOpsRepGroupOps;
                        const aForm       : IvcmEntityForm;
                        const aEntityDef  : IvcmEntityDef;
                        const aOpDef      : IvcmOperationDef): IvcmCustOpsOperation;
      {-}
    function COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
      override;
      {-}
  end;//TvcmCustOpsRepEnOp

  TvcmCustOpsItem = class(TvcmCustOpsListItem,
                          IvcmCustOpsItem)
  {* Элемент панели задач, им может быть операция или группа. }
  protected
  // fields
    f_Position: Integer;
  protected
  // IvcmCustOpsItem
    function pm_GetPosition: Integer;
    procedure pm_SetPosition(aValue: Integer);
      virtual;
      abstract;
      {* - позиция группы. }
  protected
  // properties
    property Position: Integer
      read pm_GetPosition
      write pm_SetPosition;
      {* - позиция операции. }
  public
  // methods
    function OCompare(anObject: Tl3Base): Integer;
      override;
      {* функция сравнения объекта с другим объектом. }
    procedure LoadPosition;
      virtual;
      abstract;
      {* - прочитать позицию. }
  end;//TvcmCustOpsItem

  TvcmCustOpsGroup = class(TvcmCustOpsItem,
                           IvcmCustOpsGroup)
  {* Группа панели задач. }
  private
  // fields
    f_Operations : TvcmCustOpsList;
    f_RepGroup   : IvcmCustOpsRepGroup;
  protected
  // property methods
    function IvcmCustOpsGroup_pm_GetOperations: IvcmCustOpsGroupOperationsIterator;
    function IvcmCustOpsGroup.pm_GetOperations = IvcmCustOpsGroup_pm_GetOperations;
      {-}
    function pm_GetRepGroup: IvcmCustOpsRepGroup;
      {-}
    procedure pm_SetPosition(aValue: Integer);
      override;
      {* - позиция группы. }
    function pm_GetOperations: TvcmCustOpsList;
      {-}
   function Get_IsLinkToExistingControl: Boolean;
   function Get_Control: TWinControl;
  private
  // internal methods
    function MakePosParam(const aBasePath: TvcmPathPairs): TvcmPathPairs;
      {-}
    function AddOperation(const aRepOp      : IvcmCustOpsRepOperation;
                          aForAllUseCases : Boolean;
                          aPosition   : Integer;
                          const aCaption    : IvcmCString): IvcmCustOpsGroupOperation;
      overload;
      {* - добавить операцию в панель задач. }
    function AddOperation(const aOp: TvcmCustOpsGroupOp): IvcmCustOpsGroupOperation;
      overload;
      {-}
    procedure OperationDeleted(const aOperation: IvcmCustOpsGroupOperation);
      {-}
    procedure SavePosition;
      {-}
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
  protected
  // properites
    property Operations: TvcmCustOpsList
      read pm_GetOperations;
      {* - операции группы. }
    property RepGroup: IvcmCustOpsRepGroup
      read f_RepGroup
      write f_RepGroup;
      {-}
  public
  // methods
    constructor Create(const aTasksPanel : TvcmCustOps;
                       const aList       : TvcmCustOpsList;
                       const aRepGroup   : IvcmCustOpsRepGroup;
                       const aPosition   : Integer);
      reintroduce;
      {-}
    class function Make(const aTasksPanel : TvcmCustOps;
                        const aList       : TvcmCustOpsList;
                        const aRepGroup   : IvcmCustOpsRepGroup;
                        const aPosition   : Integer): IvcmCustOpsGroup;
      {-}
    procedure Remove;
      override;
      {-}
    procedure LoadPosition;
      override;
      {-}
      function As_Il3ChangeNotifier: Il3ChangeNotifier;  
  end;//TvcmCustOpsGroup

  TvcmCustOpsGroupOp = class(TvcmCustOpsItem,
                             Il3ItemNotifyRecipient,
                             IvcmCustOpsGroupOperation)
  {* Операции панели задач. }
  private
  // fields
    f_RepOp          : IvcmCustOpsRepOperation;
    f_ForAllUseCases : Boolean;
    f_Group          : TvcmCustOpsGroup;
    f_GroupId        : Integer;
  private
  // methods
    procedure SaveForAllUseCases;
      {-}
    procedure SavePosition;
      {-}
    procedure SaveGroupId;
      {-}
  private
  // Il3ItemNotifyRecipient
    procedure Notify(const aNotifier  : Il3ChangeNotifier;
                     aOperation       : Integer;
                     aIndex           : Integer);
      {* - прошла операция. }
  protected
  // IvcmCustOpsGroupOperation
    function pm_GetRepOp: IvcmCustOpsRepOperation;
      {-}
    function pm_GetForAllUseCases: Boolean;
    procedure pm_SetForAllUseCases(aValue: Boolean);
      {* - всегда показывать в панели при наличии операции. }
    procedure pm_SetPosition(aValue: Integer);
      override;
      {* - позиция операции. }
    function pm_GetCaption: IvcmCString;
    procedure pm_SetCaption(const aValue: IvcmCString);
      {* - название операции. }
    function pm_GetGroup: IvcmCustOpsGroup;
      {-}
    function pm_GetGroupId: Integer;
    procedure pm_SetGroupId(aValue: Integer);
      {-}
    function pm_GetIsDefaultCaption: Boolean;
      {* - определяет была ли переименована операция для панели задач. }
    procedure Delete;
      {* - удалить операцию из панели задач. }
  private
  // property methods
    function pm_GetIntRepOp: IvcmIntRepOp;
      {-}
    function pm_GetCurrentUseCasePosPath: TvcmPathPairs;
      {-}
    function pm_GetForAllUseCasesPosPath: TvcmPathPairs;
      {-}
    function pm_GetGroupIdPath: TvcmPathPairs;
      {-}
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
    procedure InitFields;
      override;
      {-}
  protected
  // properties
    property RepOp: IvcmCustOpsRepOperation
      read f_RepOp
      write f_RepOp;
      {-}
    property IntRepOp: IvcmIntRepOp
      read pm_GetIntRepOp;
      {-}
    property ForAllUseCases: Boolean
      read pm_GetForAllUseCases
      write pm_SetForAllUseCases;
      {* - всегда показывать в панели при наличии операции. }
    property Caption: IvcmCString
      read pm_GetCaption
      write pm_SetCaption;
      {-}
    property Group: TvcmCustOpsGroup
      read f_Group
      write f_Group;
      {-}
    property GroupId: Integer
      read pm_GetGroupId
      write pm_SetGroupId;
      {-}
    property CurrentUseCasePosPath: TvcmPathPairs
      read pm_GetCurrentUseCasePosPath;
      {-}
    property ForAllUseCasesPosPath: TvcmPathPairs
      read pm_GetForAllUseCasesPosPath;
      {-}
    property GroupIdPath: TvcmPathPairs
      read pm_GetGroupIdPath;
      {-}
  public
  // methods
    constructor Create(const aTasksPanel : TvcmCustOps;
                       const aGroup      : TvcmCustOpsGroup;
                       const aRepOp      : IvcmCustOpsRepOperation);
      reintroduce;
      overload;
      {-}
    constructor Create(const aTasksPanel     : TvcmCustOps;
                       const aGroup          : TvcmCustOpsGroup;
                       const aRepOp          : IvcmCustOpsRepOperation;
                       const aForAllUseCases : Boolean);
      reintroduce;
      overload;
      {* - конструктор используется при вычитывании операции из настроек. }
    constructor Create(const aTasksPanel     : TvcmCustOps;
                       const aGroup          : TvcmCustOpsGroup;
                       const aRepOp          : IvcmCustOpsRepOperation;
                       const aForAllUseCases : Boolean;
                       const aPosition       : Integer;
                       const aCaption        : IvcmCString;
                       const aGroupId        : Integer);
      reintroduce;
      overload;
      {* - конструктор используется при добавлении операции в панель задач. }
    procedure Remove;
      override;
      {-}
    procedure LoadPosition;
      override;
      {-}
      function As_Il3ChangeNotifier: Il3ChangeNotifier;
  end;//IvcmCustOpsGroup

  TvcmCustOpsRepGroup = class(TvcmCustOpsNotifier,
                                 IvcmIntState,
                                 IvcmCustOpsRepGroup)
  {* Группа репозитория доступная для выбора на панель задач. }
  private
  // fields
    f_Id         : Integer;
    f_Caption    : IvcmCString;
    f_State      : TvcmCustOpsState;
    f_TasksPanel : TvcmCustOps;
  private
  // ItpIntRepGroup
    function pm_GetState: TvcmCustOpsState;
    procedure pm_SetState(const aValue: TvcmCustOpsState);
      {-}
  private
  // IvcmCustOpsRepGroup
    function pm_GetCaption: IvcmCString;
    procedure pm_SetCaption(const aValue: IvcmCString);
      {* - название группы. }
    function pm_GetId: Integer;
      {* - идентификатор группы. }
  private
  // property methods
    function pm_GetPath: TvcmPathPairs;
      {-}
  private
  // fields
    property TasksPanel: TvcmCustOps
      read f_TasksPanel;
      {-}
    property Caption: IvcmCString
      read pm_GetCaption
      write pm_SetCaption;
      {* - название группы. }
    property Id: Integer
      read pm_GetId;
      {* - идентификатор группы. }
    property Path: TvcmPathPairs
      read pm_GetPath;
      {-}
    property State: TvcmCustOpsState
      read f_State;
      {-}
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
  public
  // methods
    constructor Create(const aTasksPanel : TvcmCustOps;
                       const aId         : Integer;
                       const aCaption    : IvcmCString);
      reintroduce;
      {-}
      function As_Il3ChangeNotifier: Il3ChangeNotifier;  
  end;//TvcmCustOpsRepGroup

  TvcmCustOpsRepGroupsIterator = class(TvcmCustOpsBaseIterator,
                                          IvcmCustOpsRepGroupsIterator)
  {* Итератор доступных для выбора групп на панель задач. }
  private
  // IvcmCustOpsRepGroupsIterator
     function Next: IvcmCustOpsRepGroup;
       {-}
  public
  // methods
    class function Make(const aList: TvcmCustOpsList): IvcmCustOpsRepGroupsIterator;
      {-}
  end;//TvcmCustOpsRepGroupsIterator

implementation

uses
  SysUtils,
  Forms,

  afwFacade,
  afwConsts,

  vcmEntityAction,
  vcmModuleAction,
  vcmEntityForm,
  vcmBaseEntities,
  vcmBaseEntitiesCollection,
  vcmBaseEntitiesCollectionItem,
  vcmBaseOperationsCollectionItem,
  vcmBaseCollectionItem,
  vcmBaseMenuManager,
  vcmMenuManager,
  vcmInternalConst,
  vcmDispatcher
  ;

const
  {----------------------------------------------------------------------------}
  { Settings                                                                   }
  {----------------------------------------------------------------------------}
  ctp_stModule          : TvcmPathPair = (rName: 'Module');
  ctp_stEntity          : TvcmPathPair = (rName: 'Entity');
  ctp_stCaption         : TvcmPathPair = (rName: 'Caption');
  ctp_stUse             : TvcmPathPair = (rName: 'Use');
  ctp_stGroup           : TvcmPathPair = (rName: 'Group');
  ctp_stGroupId         : TvcmPathPair = (rName: 'GroupId');
  ctp_stPosition        : TvcmPathPair = (rName: 'Position');
  ctp_RepGroupSeparator = ';';
  {----------------------------------------------------------------------------}
  { Notification                                                               }
  {----------------------------------------------------------------------------}
  ctp_RepOperationRemove = 0;

function vcmIsOpEnable(const anOp: IvcmOperationDef): Boolean;
begin
 with anOp do
  Result := (OperationType in vcmVisualOperations) and
            (*(not (OperationType in vcmOperationsWithIcon) or
              (anOp.ImageIndex <> -1)) and*)
            VisibleToUser;
end;//vcmIsOpEnable

procedure vcmSortPosition(const aList: TvcmCustOpsList);
 {* - функция с устойчивым алгоритмом сортировки, которая не переставляет
      элементы с одинаковой позицией местами. }
var
 l_Done  : Boolean;
 l_J     : Integer;
 l_Index : Integer;
begin
 if aList.Count > 0 then
  for l_J := 0 to Pred(aList.Count) do
  begin
   l_Done := True;
   for l_Index := Pred(aList.Count) downto Succ(l_J) do
   begin
    if TvcmCustOpsItem(aList.Items[l_Index - 1]).Position >
     TvcmCustOpsItem(aList.Items[l_Index]).Position then
    begin
     l_Done := False;
     aList.Exchange(l_Index - 1, l_Index);
    end;//if Supports(Column[0].Cell[l_Index]
   end;//for l_Index := 0 to Pred(Column[0].CellCount) do
   // Во время последнего цикла не было сделано ни одной перестановки, группы
   // отсортированы, выходим:
   if l_Done then
    Break;
  end;//for l_J := 0 to Pred(Column[0].CellCount) do
end;//vcmSortPosition

procedure vcmUpdatePositionsByOrder(const aList: TvcmCustOpsList);
 {* - обновляет позиции по порядку расположения. }
var
 l_Index: Integer;
begin
 vcmSortPosition(aList);
  // - операции хранятся несортированными перед установкой позиций сортируем;
 for l_Index := 0 to Pred(aList.Count) do
  TvcmCustOpsItem(aList.Items[l_Index]).Position := l_Index;
end;//vcmUpdatePositionsByOrder

procedure vcmUpdatePositions(const aList: TvcmCustOpsList);
 {* - обновляет позиции элементов списка. }
var
 l_Index: Integer;
begin
 // Обходим список и вычитываем позиции групп/операций для нового прецедента:
 for l_Index := 0 to Pred(aList.Count) do
  TvcmCustOpsItem(aList.Items[l_Index]).LoadPosition;
end;//vcmUpdatePositions

procedure vcmSetState(const aState : IUnknown;
                      const aValue : TvcmCustOpsState);
var
 l_State: IvcmIntState;
begin
 if Supports(aState, IvcmIntState, l_State) then
 try
  l_State.State := aValue;
 finally
  l_State := nil;
 end;//try..finally
end;//vcmSetState

function vcmMakeFormId(const aForm : IvcmEntityForm;
                       aNeedSupportOldSettings : Boolean
                       // http://mdp.garant.ru/pages/viewpage.action?pageId=398275923&focusedCommentId=398278907#comment-398278907
                       ): TvcmPathPairs;

 function lp_ExtractFormName: String;
 begin//lp_ExtractFormName
  if (aForm.VCLWinControl = nil) then
   Result := ''
  else
   Result := (aForm.VCLWinControl As TvcmEntityForm).FormID.rName;
 end;//lp_ExtractFormName

var
 l_UT: IvcmUserTypeDef;
begin
 Assert(aForm <> nil);
 with aForm do
 begin
  l_UT := CurUseToolbarOfUserType;
  if (l_UT <> nil) then
  begin
   if aNeedSupportOldSettings AND
      // http://mdp.garant.ru/pages/viewpage.action?pageId=398279038
      ((l_UT.ID = 0) OR (l_UT.ID = 1)) then
    Result := nil
   else 
    vcmCopyPath([vcmPathPair(lp_ExtractFormName),
                 vcmPathPair(l_UT.Name)],
                Result);
  end//l_UT <> nil
  else
   vcmCopyPath([vcmPathPair(lp_ExtractFormName)], Result);
 end;//with aForm
end;//vcmMakeFormId

function vcmFindGroup(const aList    : TvcmCustOpsList;
                      const aGroupId : Integer): TvcmCustOpsGroup;
  {-}
var
 l_Index: Integer;
begin
 Result := nil;
 for l_Index := 0 to Pred(aList.Count) do
  if (TvcmCustOpsGroup(aList.Items[l_Index]).RepGroup.Id = aGroupId) then
  begin
   Result := TvcmCustOpsGroup(aList.Items[l_Index]);
   Break;
  end;//if TvcmCustOpsGroup...
end;//vcmFindGroup

{$Include l3Notifier.imp.pas}

{ TvcmCustOps }

function TvcmCustOps.As_Il3ChangeNotifier: Il3ChangeNotifier;
begin
 Result := Self;
end;

constructor TvcmCustOps.Create(const aSettingsPath: String);
  //override;
  {-}
const
  ctp_stRepGroups: TvcmPathPair = (rName: 'RepGroups');
begin
 inherited Create;
 f_SettingsPath.rName := aSettingsPath;
  // - куда писать настройки;
 vcmCatPath(SettingsPath, ctp_stRepGroups, f_RepGroupsPath);
  // - куда читать\писать настройки;
 UpdatePositionByOrder := False;
 EnableSaveToSettings := False;
 if TvcmDispatcher.Exists then
  TvcmDispatcher.Instance.FormDispatcher.AddLockListener(IvcmLockListener(Self));
end;//Create

function TvcmCustOps.AnalyzeOpForCurrentUseCase: Boolean;
  //virtual;
  {-}
begin
 Result := True;
end;

procedure TvcmCustOps.Cleanup;
begin
 if TvcmDispatcher.Exists then
  TvcmDispatcher.Instance.FormDispatcher.RemoveLockListener(IvcmLockListener(Self));
 FreeAndNil(f_Groups);
 FreeAndNil(f_RepGroups);
 FreeAndNil(f_RepGroupsOperations);
 FreeAndNil(f_ActionOwner);
 inherited;
end;//Cleanup

function TvcmCustOps.pm_GetEnableSaveToSettings: boolean;
begin
 Result := f_EnableSaveToSettings;
end;

procedure TvcmCustOps.pm_SetEnableSaveToSettings(aValue: boolean);
begin
 f_EnableSaveToSettings := aValue;
end;

function TvcmCustOps.pm_GetGroups: IvcmCustOpsGroupsIterator;
begin
 Result := TvcmCustOpsGroupsIterator.Make(Groups);
end;//pm_GetIntGroups

function TvcmCustOps.pm_GetRepGroups: IvcmCustOpsRepGroupsIterator;
begin
 Result := TvcmCustOpsRepGroupsIterator.Make(RepGroups);
end;

function TvcmCustOps.pm_GetBaseSettingId: TafwSettingId;
  {* - базовый идентификатор настроек панели задач. Используется для
       записи данных связанных с панелью задач. }
begin
 Result := vcmArrayPathPairToString(f_CurrentUseCasePath);
end;//pm_GetBaseSettingId

function TvcmCustOps.pm_GetRepGroupsOperations: IvcmCustOpsRepGroupsOperationsIterator;
  {-}
begin
 Result := TvcmCustOpsRepGroupsOpsIterator.Make(RepGroupsOperations);
end;//pm_GetIntRepGroups

procedure TvcmCustOps.RemoveForm(const aForm: IvcmEntityForm);
  {-}
{$If Defined(vcmUseSettings)}

  procedure lp_RemoveChilds(const aForm: IvcmEntityForm);
  var
   l_Iterator  : IvcmEntityFormIterator;
   l_Container : IvcmContainer;
   l_ChildForm : IvcmEntityForm;
  begin
   if Supports(aForm, IvcmContainer, l_Container) then
   try
    l_Iterator := l_Container.EntityFormIterator;
    try
     l_ChildForm := l_Iterator.Next;
     while l_ChildForm <> nil do
     begin
      RemoveForm(l_ChildForm);
      l_ChildForm := l_Iterator.Next;
     end;//while l_ChildForm <> nil do
    finally
     l_Iterator := nil;
    end;//try..finally
   finally
    l_Container := nil;
   end;//if Supports(aForm, IvcmContainer, l_Container) then
  end;//lp_RemoveChilds

var
 l_Index   : Integer;
 l_OpIndex : Integer;
 l_Item    : TvcmCustOpsRepGroupOps;
{$IfEnd}
begin
{$If Defined(vcmUseSettings)}
 if UpdatePositionByOrder then
 begin
  vcmUpdatePositionsByOrder(Groups);
  for l_Index := 0 to Pred(Groups.Count) do
   vcmUpdatePositionsByOrder(Group[l_Index].Operations);
  UpdatePositionByOrder := False;
 end;//if UpdatePositionByOrder then
 lp_RemoveChilds(aForm);
 BeforeUpdate;
 try
  // Удалим операции формы из репозитория:
  for l_Index := Pred(RepGroupsOperations.Count) downto 0 do
  begin
   l_Item := TvcmCustOpsRepGroupOps(RepGroupsOperations.Items[l_Index]);
   if l_Item is TvcmCustOpsRepEnOps and (TvcmCustOpsRepEnOps(l_Item).Form = aForm) then
   begin
    for l_OpIndex := Pred(l_Item.Operations.Count) downto 0 do
     TvcmCustOpsListItem(l_Item.Operations.Items[l_OpIndex]).Remove;
    l_Item.Remove;
   end;//if l_Item is
  end;//for l_Index := Pred(RepGroupsOperations.Count) downto 0 do
 finally
  AfterUpdate;
 end;//try..finally
{$IfEnd}
end;//RemoveForm

procedure TvcmCustOps.AddForm(const aForm: IvcmEntityForm);
  {* - зарегистрировать форму. }
{$If Defined(vcmUseSettings)}

  procedure lp_AddForm;
  var
   l_RepGroupOps : TvcmCustOpsRepEnOps;
   l_Op          : TvcmCustOpsRepEnOp;
   l_EntityDef   : IvcmEntityDef;
   l_EnIterator  : IvcmEntitiesDefIterator;
   l_OpDef       : IvcmOperationDef;
   l_OpIterator  : IvcmOperationsDefIterator;
  begin
   l_RepGroupOps := TvcmCustOpsRepEnOps.Create(Self, RepGroupsOperations, aForm);
   try
    RepGroupsOperations.Add(l_RepGroupOps);
    // Сущности формы:
    l_EnIterator := (aForm.VCLWinControl As TvcmEntityForm).GetEntitiesDefIterator;
    try
     if l_EnIterator = nil then
      Exit;
     l_EntityDef := l_EnIterator.Next;
     while l_EntityDef <> nil do
     begin
      l_OpIterator := l_EntityDef.OperationsDefIterator;
      if (l_OpIterator <> nil) then
      try
       // Операции формы:
       l_OpDef := l_OpIterator.Next;
       while l_OpDef <> nil do
       begin
        // Добавим операцию:
        with l_OpDef do
         if ((aForm.CurUseToolbarOfUserType = nil) or
             not (aForm.CurUseToolbarOfUserType.ID in ExcludeUserTypes)) and
            vcmIsOpEnable(l_OpDef) then
         begin
          l_Op := TvcmCustOpsRepEnOp.Create(Self,
                                               l_RepGroupOps,
                                               aForm,
                                               l_EntityDef,
                                               l_OpDef);
          try
           l_RepGroupOps.Operations.Add(l_Op);
          finally
           FreeAndNil(l_Op);
          end;{try..finally}
         end;//if not (l_EntityOp.OperationType
        l_OpDef := l_OpIterator.Next;
       end;//while l_OpDef <> nil do
      finally
       l_OpIterator := nil;
      end;//try..finally
      l_EntityDef := l_EnIterator.Next;
     end;
    finally
     l_EnIterator := nil;
    end;//try..finally
   finally
    FreeAndNil(l_RepGroupOps);
   end;{try..finally}
  end;//lp_AddForm

 {$IfEnd}
begin
 {$If Defined(vcmUseSettings)}
 UpdatePositionByOrder := True;
  // - открывается новый прецедент, установим признак, который позволит обновить
  //   позиции групп/операций при закрытии этого прецедента;
 BeforeUpdate;
 try
  LastAddedForm := aForm;
  lp_AddForm;
 finally
  AfterUpdate;
 end;//try..finally
 {$IfEnd}
end;//AddForm

procedure TvcmCustOps.AddModule(const aModule: IvcmModuleDef);
  {-}
{$If Defined(vcmUseSettings)}
var
 l_Group: TvcmCustOpsRepGroupOps;
{$IfEnd}
begin
 {$If Defined(vcmUseSettings)}
 l_Group := TvcmCustOpsRepMoOps.Create(Self, RepGroupsOperations, aModule);
 try
  RepGroupsOperations.Add(l_Group);
 finally
  FreeAndNil(l_Group);
 end;{try..finally}
 {$IfEnd}
end;//RegisterModuleOperation

{ TvcmCustOpsBase }

procedure TvcmCustOpsBase.Cleanup;
begin
 f_TasksPanel := nil;
 inherited;
end;//Cleanup

constructor TvcmCustOpsBase.Create(const aTasksPanel: TvcmCustOps);
begin
 inherited Create;
 f_TasksPanel := aTasksPanel;
end;//Create

{ TvcmCustOpsItem }

function TvcmCustOpsItem.OCompare(anObject: Tl3Base): Integer;
begin
 if anObject is TvcmCustOpsItem then
  Result := Position - TvcmCustOpsItem(anObject).Position
 else
  Result := 0;
end;

function TvcmCustOpsItem.pm_GetPosition: Integer;
begin
 Result := f_Position;
end;//pm_GetPosition

{ TvcmCustOpsGroup }

procedure TvcmCustOpsGroup.Remove;
  //override;
  {-}
begin
 CallNotify(Ord(cvcm_tpGroupRemove), 0);
 inherited;
end;//Remove

procedure TvcmCustOpsGroup.Cleanup;
begin
 vcmSetState(RepGroup, tp_sFree);
 RepGroup := nil;
 FreeAndNil(f_Operations);
 inherited;
end;//Cleanup

constructor TvcmCustOpsGroup.Create(const aTasksPanel : TvcmCustOps;
                                       const aList       : TvcmCustOpsList;
                                       const aRepGroup   : IvcmCustOpsRepGroup;
                                       const aPosition   : Integer);
begin
 inherited Create(aTasksPanel, aList);
 Assert(aList <> nil);
 Assert(aRepGroup <> nil);
 RepGroup := aRepGroup;
 vcmSetState(RepGroup, tp_sUse);
 f_Position := -1;
 if aPosition = -1 then
  LoadPosition
 else
 begin
  f_Position := aPosition;
  // Пользователь создал новую группу, запишем позицию в настройки:
  SavePosition;
 end;//if aPosition <> -1 then
end;//Create

class function TvcmCustOpsGroup.Make(
  const aTasksPanel : TvcmCustOps;
  const aList       : TvcmCustOpsList;
  const aRepGroup   : IvcmCustOpsRepGroup;
  const aPosition   : Integer): IvcmCustOpsGroup;
var
 l_Class: TvcmCustOpsGroup;
begin
 l_Class := Create(aTasksPanel, aList, aRepGroup, aPosition);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;//Make

function TvcmCustOpsGroup.pm_GetOperations: TvcmCustOpsList;
  {-}
begin
 if f_Operations = nil then
  f_Operations := TvcmCustOpsList.MakeSorted(l3_dupAccept);
 Result := f_Operations;
end;//pm_GetOperations

function TvcmCustOpsGroup.Get_IsLinkToExistingControl: Boolean;
begin
 Result := false;
end;

function TvcmCustOpsGroup.Get_Control: TWinControl;
begin
 Result := nil;
end;

function TvcmCustOpsGroup.
  IvcmCustOpsGroup_pm_GetOperations: IvcmCustOpsGroupOperationsIterator;
begin
 Result := TvcmCustOpsGroupOpsIterator.Make(Operations);
end;//pm_GetOperations

function TvcmCustOpsGroup.MakePosParam(
  const aBasePath: TvcmPathPairs): TvcmPathPairs;
  {-}
begin
 vcmCatPath(aBasePath, [ctp_stGroup, vcmPathPair(IntToStr(RepGroup.Id)),
  ctp_stPosition], Result);
end;//MakePosParam

procedure TvcmCustOpsGroup.LoadPosition;
  {-}
var
 l_Path: TvcmPathPairs;
 l_Position : Integer;
begin
 l_Position := f_Position;
 // Прочитаем позицию зависящую от формы:
 vcmLoadIntParam(MakePosParam(TasksPanel.CurrentUseCasePath), f_Position, '',
  False, -1);
 // Прочитаем позицию группы для всех прецедентов:
 if f_Position = -1 then
 begin
  vcmCopyPath([TasksPanel.SettingsPath], l_Path);
  vcmLoadIntParam(MakePosParam(l_Path), f_Position, '', False, 0);
  // Запишем позицию для текущего прецедента:
  vcmSaveIntParam(MakePosParam(TasksPanel.CurrentUseCasePath), f_Position, 0, '');
 end;//if f_Position = -1 then
 if l_Position <> f_Position then
  CallNotify(Ord(cvcm_tpGroupPosChanged), 0);
end;//LoadPosition

function TvcmCustOpsGroup.As_Il3ChangeNotifier: Il3ChangeNotifier;
begin
 Result := Self;
end;

procedure TvcmCustOpsGroup.SavePosition;
  {-}
var
 l_Path: TvcmPathPairs;
begin
 if not TasksPanel.EnableSaveToSettings then Exit;

 // Позиция для текущего прецедента:
 vcmSaveIntParam(MakePosParam(TasksPanel.CurrentUseCasePath), f_Position, 0, '');
 // Позиция для всех прецедентов:
 vcmCopyPath([TasksPanel.SettingsPath], l_Path);
 vcmSaveIntParam(MakePosParam(l_Path), f_Position, 0, '');
end;//SavePosition

procedure TvcmCustOpsGroup.OperationDeleted(
  const aOperation: IvcmCustOpsGroupOperation);
  {-}
begin
 if Operations.Count = 0 then
  Remove;
end;//OperationDeleted

function TvcmCustOpsGroup.AddOperation(
  const aOp: TvcmCustOpsGroupOp): IvcmCustOpsGroupOperation;
  // overload;
  {-}
var
 l_Op: TvcmCustOpsGroupOp;
begin
 l_Op := aOp;
 try
  with l_Op do
  begin
   List := Operations;
   Group := Self;
  end;//with l_Op do
  Result := l_Op;
  Operations.Add(l_Op);
  CallInterfaceNotify(Ord(cvcm_tpOperationAdded), Result);
 finally
  FreeAndNil(l_Op);
 end;{try..finally}
end;//AddOperatioin

procedure TvcmCustOpsGroup.pm_SetPosition(aValue: Integer);
  {* - позиция группы. }
begin
 if f_Position <> aValue then
 begin
  f_Position := aValue;
  SavePosition;
  CallNotify(Ord(cvcm_tpGroupPosChanged), 0);
 end;//if f_Position <> aValue then
end;

function TvcmCustOpsGroup.AddOperation(const aRepOp      : IvcmCustOpsRepOperation;
                                          aForAllUseCases : Boolean;
                                          aPosition   : Integer;
                                          const aCaption    : IvcmCString): IvcmCustOpsGroupOperation;
  {* - добавить операцию в панель задач. }
begin
 Result := AddOperation(TvcmCustOpsGroupOp.Create(TasksPanel, Self, aRepOp,
  aForAllUseCases, aPosition, aCaption, RepGroup.Id));
end;

function TvcmCustOpsGroup.pm_GetRepGroup: IvcmCustOpsRepGroup;
begin
 Result := f_RepGroup;
end;//pm_GetRepGroup

{ TvcmCustOpsListItem }

procedure TvcmCustOpsListItem.Cleanup;
begin
 List := nil;
 inherited;
end;//Cleanup

constructor TvcmCustOpsListItem.Create(const aTasksPanel : TvcmCustOps;
                                          const aList       : TvcmCustOpsList);
begin
 inherited Create(aTasksPanel);
 List := aList;
end;//Create

procedure TvcmCustOpsListItem.Remove;
begin
 if List <> nil then
  List.Remove(Self);
end;//Remove

{ TvcmCustOpsOp }

procedure TvcmCustOpsOp.Cleanup;
  //override;
  {-}
begin
 if f_Action.Owner = TasksPanel.ActionOwner then
  FreeAndNil(f_Action);
 inherited;
end;//Cleanup

constructor TvcmCustOpsOp.Create(const aTasksPanel : TvcmCustOps;
                             const aList       : TvcmCustOpsList;
                             const aAction     : TCustomAction);
begin
 inherited Create(aTasksPanel, aList);
 f_Action := aAction;
end;//Create

function TvcmCustOpsOp.pm_GetAction: TCustomAction;
begin
 Result := f_Action;
end;//pm_GetAction

{ TvcmCustOpsRepMoOp }

constructor TvcmCustOpsRepMoOp.Create(
  const aTasksPanel : TvcmCustOps;
  const aRepGroup   : TvcmCustOpsRepGroupOps;
  const aModuleDef  : IvcmModuleDef;
  const aOpDef      : IvcmOperationDef);
begin
 Assert(g_MenuManager is TvcmCustomMenuManager);
 inherited Create(aTasksPanel, aRepGroup, TvcmCustomMenuManager(g_MenuManager).
  BuildAction(aModuleDef, aOpDef), aOpDef);
 ModuleDef := aModuleDef;
end;//Create

class function TvcmCustOpsRepMoOp.Make(
  const aTasksPanel : TvcmCustOps;
  const aRepGroup   : TvcmCustOpsRepGroupOps;
  const aModuleDef  : IvcmModuleDef;
  const aOpDef      : IvcmOperationDef): IvcmCustOpsOperation;
var
 l_Class: TvcmCustOpsRepMoOp;
begin
 l_Class := Create(aTasksPanel, aRepGroup, aModuleDef, aOpDef);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;//Make

function TvcmCustOpsRepMoOp.CurrentUseCasePath: TvcmPathPairs;
  // override;
  {-}
begin
 vcmCatPath(TasksPanel.CurrentUseCasePath, [ctp_stModule,
  vcmPathPair(ModuleDef.Name), vcmPathPair(OpDef.Name)], Result);
end;//CurrentUseCasePath

function TvcmCustOpsRepMoOp.ForAllUseCasesPath: TvcmPathPairs;
  // override;
  {-}
begin
 vcmCopyPath([TasksPanel.SettingsPath, ctp_stModule, vcmPathPair(ModuleDef.Name),
  vcmPathPair(OpDef.Name)], Result);
end;//ForAllUseCasesPath

function TvcmCustOpsRepMoOp.CaptionPath: TvcmPathPairs;
begin
 vcmCatPath(ForAllUseCasesPath, ctp_stCaption, Result);
end;//CaptionPath

function TvcmCustOpsRepMoOp.pm_GetCaption: IvcmCString;
begin
 Result := OpDef.Caption;
end;//pm_GetCaption

function TvcmCustOpsRepMoOp.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
begin
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail and IID.EQ(IvcmModuleDef) then
  begin
   Result.SetOK;
   IvcmModuleDef(Obj) := f_ModuleDef;
  end;
end;

{ TvcmCustOpsRepEnOp }

constructor TvcmCustOpsRepEnOp.Create(
  const aTasksPanel : TvcmCustOps;
  const aRepGroup   : TvcmCustOpsRepGroupOps;
  const aForm       : IvcmEntityForm;
  const aEntityDef  : IvcmEntityDef;
  const aOpDef      : IvcmOperationDef);
begin
 Assert(g_MenuManager is TvcmCustomMenuManager);
 inherited Create(aTasksPanel, aRepGroup, TvcmCustomMenuManager(g_MenuManager).
  BuildAction(aTasksPanel.ActionOwner, aForm.Entity, aEntityDef, aOpDef,
  [vcm_ooShowInChildToolbar]), aOpDef);
 Form := aForm;
 f_EntityDef := aEntityDef;
end;//Create

class function TvcmCustOpsRepEnOp.Make(
  const aTasksPanel : TvcmCustOps;
  const aRepGroup   : TvcmCustOpsRepGroupOps;
  const aForm       : IvcmEntityForm;
  const aEntityDef  : IvcmEntityDef;
  const aOpDef      : IvcmOperationDef): IvcmCustOpsOperation;
var
 l_Class: TvcmCustOpsRepEnOp;
begin
 l_Class := Create(aTasksPanel, aRepGroup, aForm, aEntityDef, aOpDef);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;//Make

function TvcmCustOpsRepEnOp.CurrentUseCasePath: TvcmPathPairs;
  //override;
  {-}
var
 l_Temp: TvcmPathPairs;
begin
 vcmCatPath(TasksPanel.CurrentUseCasePath,
            vcmMakeFormId(f_Form, true),
            l_Temp);
 vcmCatPath(l_Temp,
            [ctp_stEntity,
             vcmPathPair(EntityDef.Name),
             vcmPathPair(OpDef.Name)],
             Result);
end;//CurrentUseCasePath

function TvcmCustOpsRepEnOp.ForAllUseCasesPath: TvcmPathPairs;
  //override;
  {-}
var
 l_Temp: TvcmPathPairs;
begin
 vcmCatPath(TasksPanel.SettingsPath,
            vcmMakeFormId(f_Form, false),
            l_Temp);
 vcmCatPath(l_Temp,
            [ctp_stEntity,
             vcmPathPair(EntityDef.Name),
             vcmPathPair(OpDef.Name)],
             Result);
end;//ForAllUseCasesPath

procedure TvcmCustOpsRepEnOp.Cleanup;
begin
 Form := nil;
 f_EntityDef := nil;
 f_OpDef := nil;
 inherited;
end;//Cleanup

function TvcmCustOpsRepEnOp.CaptionPath: TvcmPathPairs;
begin
 vcmCatPath(TasksPanel.SettingsPath, [ctp_stEntity, vcmPathPair(EntityDef.Name),
  vcmPathPair(OpDef.Name)], Result);
end;//CaptionPath

function TvcmCustOpsRepEnOp.pm_GetCaption: IvcmCString;
begin
 Result := l3Cat([l3Cat(OpDef.Caption, ' ('), l3Cat(EntityDef.Caption, ')')]);
end;//pm_GetCaption

function TvcmCustOpsRepEnOp.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
begin
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail and IID.EQ(IvcmEntityDef) then
  begin
   Result.SetOK;
   IvcmEntityDef(Obj) := f_EntityDef;
  end;
end;

{ TvcmCustOpsBaseIterator }

constructor TvcmCustOpsBaseIterator.Create(const aList: TvcmCustOpsList);
begin
 inherited Create;
 f_List := aList;
 f_Index := -1;
end;//Create

function TvcmCustOpsBaseIterator.DoNext: TObject;
begin
 if (f_List.Count > 0) and (f_Index < Pred(f_List.Count)) then
 begin
  Inc(f_Index);
  Result := f_List.Items[f_Index];
 end
 else
  Result := nil;
end;//DoNext

{ TvcmCustOpsRepOpsIterator }

class function TvcmCustOpsRepOpsIterator.Make(
  const aList: TvcmCustOpsList): IvcmCustOpsRepOperationsIterator;
var
 l_Class: TvcmCustOpsRepOpsIterator;
begin
 l_Class := Create(aList);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;//Make

function TvcmCustOpsRepOpsIterator.Next: IvcmCustOpsRepOperation;
var
 l_Op: TvcmCustOpsRepOp;
begin
 l_Op := TvcmCustOpsRepOp(DoNext);
 while (l_Op <> nil) and (l_Op.State = tp_sUse) do
  l_Op := TvcmCustOpsRepOp(DoNext);
 Supports(l_Op, IvcmCustOpsRepOperation, Result);
end;//Next

{ TvcmCustOpsRepGroupsOpsIterator }

class function TvcmCustOpsRepGroupsOpsIterator.Make(
  const aList: TvcmCustOpsList): IvcmCustOpsRepGroupsOperationsIterator;
var
 l_Class: TvcmCustOpsRepGroupsOpsIterator;
begin
 l_Class := Create(aList);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;//Make

function TvcmCustOpsRepGroupsOpsIterator.Next: IvcmCustOpsRepGroupOperations;
var
 l_Group: TvcmCustOpsRepGroupOps;
begin
 l_Group := TvcmCustOpsRepGroupOps(DoNext);
 while (l_Group <> nil) and (l_Group.Operations.Count = 0) do
  l_Group := TvcmCustOpsRepGroupOps(DoNext);
 Supports(l_Group, IvcmCustOpsRepGroupOperations, Result);
end;//Next

{ TvcmCustOpsRepMoOps }

procedure TvcmCustOpsRepMoOps.Cleanup;
begin
 f_Module := nil;
 inherited;
end;//Cleanup

constructor TvcmCustOpsRepMoOps.Create(const aTasksPanel : TvcmCustOps;
                                   const aList       : TvcmCustOpsList;
                                   const aModule     : IvcmModuleDef);
begin
 inherited Create(aTasksPanel, aList);
 f_Module := aModule;
 LoadOperations;
end;//Create

procedure TvcmCustOpsRepMoOps.LoadOperations;
var
 l_RepOp    : TvcmCustOpsRepMoOp;
 l_OpDef    : IvcmOperationDef;
 l_Iterator : IvcmOperationsDefIterator;
begin
 l_Iterator := Module.OperationsDefIterator;
 if (l_Iterator <> nil) then
  try
   l_OpDef := l_Iterator.Next;
   while l_OpDef <> nil do
   begin
    if vcmIsOpEnable(l_OpDef) then
    begin
     l_RepOp := TvcmCustOpsRepMoOp.Create(TasksPanel, Self, Module, l_OpDef);
     try
      Operations.Add(l_RepOp);
     finally
      FreeAndNil(l_RepOp);
     end;{try..finally}
    end;//if l_OpDef.OperationType in vcmToolbarOpTypes then
    l_OpDef := l_Iterator.Next;
   end;//with f_ModuleDef.OperationsDefIterator do
  finally
   l_Iterator := nil;
  end;{try..finally}
end;//LoadOperations

function TvcmCustOpsRepMoOps.pm_GetCaption: IvcmCString;
begin
 Result := Module.Caption;
end;//pm_GetCaption

{ TvcmCustOpsRepEnOps }

constructor TvcmCustOpsRepEnOps.Create(const aTasksPanel : TvcmCustOps;
                                   const aList       : TvcmCustOpsList;
                                   const aForm       : IvcmEntityForm);
  //reintroduce;
  {-}
begin
 inherited Create(aTasksPanel, aList);
 Form := aForm;
end;//Create

function TvcmCustOpsRepEnOps.pm_GetCaption: IvcmCString;
const
 c_Prefix = '* ';
begin
 if f_Form.CurUseToolbarOfUserType <> nil then
  Result := l3CStr(c_Prefix + f_Form.CurUseToolbarOfUserType.SettingsCaption)
 else
  Result := l3Cat(c_Prefix, f_Form.Caption);
end;//pm_GetCaption

procedure TvcmCustOpsRepEnOps.Cleanup;
begin
 Form := nil;
 inherited;
end;//Cleanup

{ TvcmCustOpsRepOp }

constructor TvcmCustOpsRepOp.Create(const aTasksPanel : TvcmCustOps;
                                const aRepGroup   : TvcmCustOpsRepGroupOps;
                                const aAction     : TCustomAction;
                                const aOpDef      : IvcmOperationDef);
  //override;
  {-}
begin
 inherited Create(aTasksPanel, aRepGroup.Operations, aAction);
 f_RepGroup := aRepGroup;
 f_State := tp_sFree;
 OpDef := aOpDef;
end;//Create

function TvcmCustOpsRepOp.COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
  //override;
  {-}
begin
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail then
  if IID.EQ(IvcmOperationDef) then
  begin
   Result.SetOK;
   IvcmOperationDef(Obj) := OpDef;
  end;
end;

function TvcmCustOpsRepOp.As_Il3ChangeNotifier: Il3ChangeNotifier;
begin
 Result := Self;
end;

procedure TvcmCustOpsRepOp.Remove;
  //override;
  {-}
begin
 CallNotify(ctp_RepOperationRemove, 0);
 inherited;
end;//Remove

function TvcmCustOpsRepOp.pm_GetState: TvcmCustOpsState;
begin
 Result := f_State;
end;//pm_GetState

procedure TvcmCustOpsRepOp.pm_SetState(const aValue: TvcmCustOpsState);
begin
 f_State := aValue;
end;//pm_SetState

function TvcmCustOpsRepOp.CurrentUseCasePath: TvcmPathPairs;
  // virtual;
  {-}
begin
 SetLength(Result, 0);
end;//CurrentUseCase

function TvcmCustOpsRepOp.CaptionPath: TvcmPathPairs;
  // virtual;
  {-}
begin
 SetLength(Result, 0);
end;//CaptionPath

function TvcmCustOpsRepOp.ForAllUseCasesPath: TvcmPathPairs;
  // virtual;
  {-}
begin
 SetLength(Result, 0);
end;//ForAllUseCases

procedure TvcmCustOpsRepOp.Cleanup;
begin
 CallNotify(ctp_RepOperationRemove, 0);
 inherited;
end;//Cleanup

function TvcmCustOpsRepOp.pm_GetGroup: IvcmCustOpsRepGroupOperations;
begin
 Supports(f_RepGroup, IvcmCustOpsRepGroupOperations, Result);
end;

function TvcmCustOpsRepOp.pm_GetUserCaption: IvcmCString;
begin
 if f_UserCaption = nil then
 begin
  vcmLoadStrParam(CaptionPath, f_UserCaption, False, '');
  if l3IsNil(f_UserCaption) then
   f_UserCaption := OpDef.Caption;
 end;//if f_UserCaption = nil then
 Result := f_UserCaption;
end;//pm_GetUserCaption

procedure TvcmCustOpsRepOp.pm_SetUserCaption(const aValue: IvcmCString);
begin
 if not l3Same(f_UserCaption, aValue) then
 begin
  if l3IsNil(aValue) then
   f_UserCaption := OpDef.Caption
  else
   f_UserCaption := aValue;

  if TasksPanel.EnableSaveToSettings then
   vcmSaveStrParamS(CaptionPath, aValue, '');
 end;//if not l3Same(f_UserCaption, aValue) then
end;//pm_SetUserCaption

function TvcmCustOpsRepOp.pm_GetIsDefaultUserCaption: Boolean;
  {* - определяет была ли переименована операция для панели задач. }
begin
 Result := l3Same(UserCaption, OpDef.Caption);
end;//pm_GetIsDefaultUserCaption

function TvcmCustOpsRepOp.pm_GetCaption: IvcmCString;
begin
 Result := nil;
end;//pm_GetCaption

{ TvcmCustOpsGroupsIterator }

class function TvcmCustOpsGroupsIterator.Make(
  const aList: TvcmCustOpsList): IvcmCustOpsGroupsIterator;
var
 l_Class: TvcmCustOpsGroupsIterator;
begin
 l_Class := Create(aList);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;//Make

function TvcmCustOpsGroupsIterator.Next: IvcmCustOpsGroup;
begin
 Supports(DoNext, IvcmCustOpsGroup, Result);
end;//Next

{ TvcmCustOpsGroupOpsIterator }

class function TvcmCustOpsGroupOpsIterator.Make(
  const aList: TvcmCustOpsList): IvcmCustOpsGroupOperationsIterator;
var
 l_Class: TvcmCustOpsGroupOpsIterator;
begin
 l_Class := Create(aList);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;

function TvcmCustOpsGroupOpsIterator.Next: IvcmCustOpsGroupOperation;
begin
 Supports(DoNext, IvcmCustOpsGroupOperation, Result);
end;//Next

{ TvcmCustOpsRepGroupOps }

constructor TvcmCustOpsRepGroupOps.Create(const aTasksPanel : TvcmCustOps;
                                      const aList       : TvcmCustOpsList);
begin
 inherited;
 f_Operations := TvcmCustOpsList.Make;
end;

procedure TvcmCustOpsRepGroupOps.Cleanup;
begin
 FreeAndNil(f_Operations);
 inherited;
end;//Cleanup

function TvcmCustOpsRepGroupOps.pm_GetCaption: IvcmCString;
begin
 Result := TvcmWString.MakeI('');
end;//pm_GetCaption

function TvcmCustOpsRepGroupOps.pm_GetOperations: IvcmCustOpsRepOperationsIterator;
begin
 Result := TvcmCustOpsRepOpsIterator.Make(f_Operations);
end;//pm_GetOperations

{ TvcmCustOpsRepGroup }

procedure TvcmCustOpsRepGroup.Cleanup;
begin
 f_Caption := nil;
 inherited;
end;//Cleanup

constructor TvcmCustOpsRepGroup.Create(const aTasksPanel : TvcmCustOps;
                                          const aId         : Integer;
                                          const aCaption    : IvcmCString);
begin
 inherited Create;
 f_TasksPanel := aTasksPanel;
 f_Id := aId;
 // Создаётся новая группа, запишем название в настройки:
 if not l3IsNil(aCaption) then
  Caption := aCaption
 else
  // Группа уже существует прочитаем название:
  if l3IsNil(f_Caption) then
   vcmLoadStrParam(Path, f_Caption, False, '');
end;//Create

function TvcmCustOpsRepGroup.As_Il3ChangeNotifier: Il3ChangeNotifier;
begin
 Result := Self;
end;

function TvcmCustOpsRepGroup.pm_GetState: TvcmCustOpsState;
begin
 Result := f_State;
end;//pm_GetState

procedure TvcmCustOpsRepGroup.pm_SetState(const aValue: TvcmCustOpsState);
  {-}
begin
 f_State := aValue;
end;//pm_SetState

function TvcmCustOpsRepGroup.pm_GetCaption: IvcmCString;
begin
 Result := f_Caption;
end;//pm_GetCaption

function TvcmCustOpsRepGroup.pm_GetId: Integer;
begin
 Result := f_Id;
end;//pm_GetId

function TvcmCustOpsRepGroup.pm_GetPath: TvcmPathPairs;
var
 l_Path: TvcmPathPair;
begin
 l_Path := vcmPathPair(IntToStr(f_Id));
 vcmCatPath(TasksPanel.RepGroupsPath, l_Path, Result);
end;//pm_GetPath

procedure TvcmCustOpsRepGroup.pm_SetCaption(const aValue: IvcmCString);
begin
 if (f_Caption = nil) or (l3Compare(f_Caption.AsWStr, aValue.AsWStr) <> 0) then
 begin
  f_Caption := aValue;
  if TasksPanel.EnableSaveToSettings then
   vcmSaveStrParamS(Path, f_Caption, '');
  CallNotify(Ord(cvcm_tpGroupCaptionChanged), 0);
 end;//if l3Compare
end;//pm_SetCaption

{ TvcmCustOpsRepGroupsIterator }

class function TvcmCustOpsRepGroupsIterator.Make(
  const aList: TvcmCustOpsList): IvcmCustOpsRepGroupsIterator;
var
 l_Class: TvcmCustOpsRepGroupsIterator;
begin
 l_Class := Create(aList);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;//Make

function TvcmCustOpsRepGroupsIterator.Next: IvcmCustOpsRepGroup;
var
 l_Group: TvcmCustOpsRepGroup;
begin
 l_Group := TvcmCustOpsRepGroup(DoNext);
 while (l_Group <> nil) and (l_Group.State = tp_sUse) do
  l_Group := TvcmCustOpsRepGroup(DoNext);
 Result := l_Group;
end;//Next

{ TvcmCustOpsGroupOp }

constructor TvcmCustOpsGroupOp.Create(const aTasksPanel : TvcmCustOps;
                                  const aGroup      : TvcmCustOpsGroup;
                                  const aRepOp      : IvcmCustOpsRepOperation);
var
 l_List: TvcmCustOpsList;
begin
 // Пустая группа возможна когда создаётся операция, вычитываются настройки,
 // потом создаётся группа:
 if aGroup <> nil then
  l_List := aGroup.Operations
 else
  l_List := nil;
 inherited Create(aTasksPanel, l_List);
 f_Group := aGroup;
 f_RepOp := aRepOp;
 if (f_RepOp <> nil) then
  f_RepOp.As_Il3ChangeNotifier.Subscribe(Il3ItemNotifyRecipient(Self));
end;

constructor TvcmCustOpsGroupOp.Create(const aTasksPanel : TvcmCustOps;
                                         const aGroup      : TvcmCustOpsGroup;
                                         const aRepOp      : IvcmCustOpsRepOperation;
                                         const aForAllUseCases : Boolean);
  // reintroduce;
  // overload;
  {* - конструктор используется при вычитывании операции из настроек. }
begin
 Create(aTasksPanel, aGroup, aRepOp);
 f_ForAllUseCases := aForAllUseCases;
 f_Position := -1;
 with IntRepOp do
 begin
  LoadPosition;
  vcmLoadIntParam(GroupIdPath, f_GroupId, '');
 end;//with IntRepOp do
end;//Create

constructor TvcmCustOpsGroupOp.Create(const aTasksPanel     : TvcmCustOps;
                                         const aGroup          : TvcmCustOpsGroup;
                                         const aRepOp          : IvcmCustOpsRepOperation;
                                         const aForAllUseCases : Boolean;
                                         const aPosition       : Integer;
                                         const aCaption        : IvcmCString;
                                         const aGroupId        : Integer);
  // reintroduce;
  {-}
begin
 Create(aTasksPanel, aGroup, aRepOp);
 f_ForAllUseCases := aForAllUseCases;
 SaveForAllUseCases;
 f_Position := aPosition;
 SavePosition;
 RepOp.UserCaption := aCaption;
 f_GroupId := aGroupId;
 SaveGroupId;
end;//Create

procedure TvcmCustOpsGroupOp.Remove;
  //override;
  {-}
var
 l_Temp: TvcmCustOpsGroupOp;
begin
 Use;
 try
  inherited;
  CallNotify(Ord(cvcm_tpOperationRemove), 0);
  if Group <> nil then
   Group.OperationDeleted(Self);
 finally
  l_Temp := Self; 
  FreeAndNil(l_Temp);
 end;{try..finally}
end;//Remove

procedure TvcmCustOpsGroupOp.InitFields;
  //override;
  {-}
begin
 inherited;
 vcmSetState(RepOp, tp_sUse);
end;//InitFields

procedure TvcmCustOpsGroupOp.Cleanup;
begin
 vcmSetState(RepOp, tp_sFree);
 CallNotify(Ord(cvcm_tpOperationRemove), 0);
 if (f_RepOp <> nil) then
  f_RepOp.As_Il3ChangeNotifier.Unsubscribe(Il3ItemNotifyRecipient(Self));
 RepOp := nil;
 Group := nil;
 inherited;
end;//Cleanup

procedure TvcmCustOpsGroupOp.SaveForAllUseCases;
  {-}
var
 l_Path: TvcmPathPairs;
begin
 if not TasksPanel.EnableSaveToSettings then Exit;
 
 // Пишем в настройки:
 vcmCatPath(IntRepOp.ForAllUseCasesPath, ctp_stUse, l_Path);
 vcmSaveBoolParam(l_Path, ForAllUseCases, False, '');
 vcmCatPath(IntRepOp.CurrentUseCasePath, ctp_stUse, l_Path);
 vcmSaveBoolParam(l_Path, not ForAllUseCases, False, '');
end;//SaveForAllUseCases

procedure TvcmCustOpsGroupOp.LoadPosition;
  {-}
var
 l_Position: Integer;
begin
 l_Position := f_Position;
 // Для текущего прецедента:
 if not ForAllUseCases then
  vcmLoadIntParam(CurrentUseCasePosPath, f_Position, '', False, 0)
 else
 begin
  // Для текущего прецедента:
  vcmLoadIntParam(CurrentUseCasePosPath, f_Position, '', False, -1);
  // Для текущего позиция не установлена, прочитаем для всех прецедентов:
  if f_Position = -1 then
  begin
   vcmLoadIntParam(ForAllUseCasesPosPath, f_Position, '', False, 0);
   // Запишем для текущего прецедента:
   vcmSaveIntParam(CurrentUseCasePosPath, f_Position, 0, '');
  end;//if f_Position = -1 then
 end;//if ForAllUseCases then
 if l_Position <> f_Position then
  CallNotify(Ord(cvcm_tpOpPosChanged), 0);
end;//LoadPosition

function TvcmCustOpsGroupOp.As_Il3ChangeNotifier: Il3ChangeNotifier;
begin
 Result := Self;
end;

procedure TvcmCustOpsGroupOp.SaveGroupId;
  {-}
begin
 if not TasksPanel.EnableSaveToSettings then Exit;
 
 vcmSaveIntParam(GroupIdPath, GroupId, 0, '');
end;//SaveGroupId

procedure TvcmCustOpsGroupOp.SavePosition;
  {-}
begin
 if not TasksPanel.EnableSaveToSettings then Exit;
 
 vcmSaveIntParam(CurrentUseCasePosPath, f_Position, 0, '');
 if ForAllUseCases then
  vcmSaveIntParam(ForAllUseCasesPosPath, f_Position, 0, '');
end;//SavePosition

procedure TvcmCustOpsGroupOp.Notify(const aNotifier  : Il3ChangeNotifier;
                                aOperation       : Integer;
                                aIndex           : Integer);
  {* - прошла операция. }
begin
 if aOperation = ctp_RepOperationRemove then
 begin
  if (f_RepOp <> nil) then
   f_RepOp.As_Il3ChangeNotifier.Unsubscribe(Il3ItemNotifyRecipient(Self));
  Remove;
 end;//if aOperation = ctp_RepOperationRemove then
end;//Notify

function TvcmCustOpsGroupOp.pm_GetGroup: IvcmCustOpsGroup;
  {-}
begin
 Supports(f_Group, IvcmCustOpsGroup, Result);
end;//pm_GetGroup

function TvcmCustOpsGroupOp.pm_GetRepOp: IvcmCustOpsRepOperation;
begin
 Result := f_RepOp;
end;//pm_GetRepOp

function TvcmCustOpsGroupOp.pm_GetForAllUseCases: Boolean;
begin
 Result := f_ForAllUseCases;
end;//pm_GetForAllUseCases

procedure TvcmCustOpsGroupOp.pm_SetForAllUseCases(aValue: Boolean);
  {* - всегда показывать в панели при наличии операции. }
begin
 if f_ForAllUseCases <> aValue then
 begin
  f_ForAllUseCases := aValue;
  SaveForAllUseCases;
  // Значение флага влияет на путь, по которому вычитываются настройки, поэтому
  // запишем:
  SavePosition;
  SaveGroupId;
 end;//if f_ForAllUseCases <> aValue then
end;

function TvcmCustOpsGroupOp.pm_GetCaption: IvcmCString;
begin
 Result := RepOp.UserCaption;
end;//pm_GetCaption

procedure TvcmCustOpsGroupOp.Delete;
  {* - удалить операцию из панели задач. }
var
 l_Path: TvcmPathPairs;
begin
 // Пишем в настройки:
 if TasksPanel.EnableSaveToSettings then
 begin
   vcmCatPath(IntRepOp.ForAllUseCasesPath, ctp_stUse, l_Path);
   vcmSaveBoolParam(l_Path, False, False, '');
   vcmCatPath(IntRepOp.CurrentUseCasePath, ctp_stUse, l_Path);
   vcmSaveBoolParam(l_Path, False, False, '');
 end;

 RepOp.UserCaption := vcmCStr('');
 Remove;
end;//Delete

procedure TvcmCustOpsGroupOp.pm_SetCaption(const aValue: IvcmCString);
  {* - название операции. }
begin
 if not l3Same(RepOp.UserCaption, aValue) then
 begin
  RepOp.UserCaption := aValue;
  CallNotify(Ord(cvcm_tpOpCaptionChanged), 0);
 end;//if l3Compare
end;//pm_SetCaption

function TvcmCustOpsGroupOp.pm_GetIsDefaultCaption: Boolean;
  {* - определяет была ли переименована операция для панели задач. }
begin
 Result := IntRepOp.IsDefaultUserCaption;
end;//pm_GetIsDefaultCaption

function TvcmCustOpsGroupOp.pm_GetGroupId: Integer;
begin
 Result := f_GroupId;
end;//pm_GetGroupId

procedure TvcmCustOpsGroupOp.pm_SetGroupId(aValue: Integer);
begin
 if f_GroupId <> aValue then
 begin
  f_GroupId := aValue;
  TasksPanel.MoveToGroup(aValue, Self);
  SaveGroupId;
 end;//if f_GroupId <> aValue then
end;

procedure TvcmCustOpsGroupOp.pm_SetPosition(aValue: Integer);
  {* - позиция операции. }
begin
 if f_Position <> aValue then
 begin
  f_Position := aValue;
  SavePosition;
  CallNotify(Ord(cvcm_tpOpPosChanged), 0);
 end;//if f_Position <> aValue then
end;

function TvcmCustOpsGroupOp.pm_GetGroupIdPath: TvcmPathPairs;
  {-}
begin
 if ForAllUseCases then
  vcmCatPath(IntRepOp.ForAllUseCasesPath,
             ctp_stGroupId,
             Result)
 else
  vcmCatPath(IntRepOp.CurrentUseCasePath,
             ctp_stGroupId,
             Result)
end;//pm_GetGroupIdPath

function TvcmCustOpsGroupOp.pm_GetForAllUseCasesPosPath: TvcmPathPairs;
  {-}
begin
 vcmCatPath(IntRepOp.ForAllUseCasesPath, ctp_stPosition, Result);
end;//pm_GetForAllUseCasesPosPath

function TvcmCustOpsGroupOp.pm_GetCurrentUseCasePosPath: TvcmPathPairs;
  {-}
begin
 vcmCatPath(IntRepOp.CurrentUseCasePath, ctp_stPosition, Result);
end;//pm_GetCurrentUseCasePosPath

function TvcmCustOpsGroupOp.pm_GetIntRepOp: IvcmIntRepOp;
  {-}
begin
 Supports(RepOp, IvcmIntRepOp, Result);
end;//pm_GetIntRepOp

{ TvcmCustOps }

function TvcmCustOps.MakeRepGroupId: Integer;
var
 l_Index: Integer;
begin
 Result := 0;
 for l_Index := 0 to Pred(f_RepGroups.Count) do
  with TvcmCustOpsRepGroup(f_RepGroups.Items[l_Index]) do
   if Id > Result then
    Result := Id;
 Inc(Result);
end;//MakeRepGroupId

procedure TvcmCustOps.IvcmLockListener_Lock;
  {* - действия заблокированы. }
begin
 Inc(f_Locked);
 BeforeUpdate;
end;//IvcmLockListener_Lock

procedure TvcmCustOps.IvcmLockListener_BeforeUnlock;
  {* - переходные процессы уже завершились, но отрисовка ещё запрещена. }

 procedure lp_MakeCurrentUseCasePath;
 var
  l_Path: TvcmPathPairs;
 begin
  vcmGetFormPath(LastAddedForm.VCLWinControl, l_Path);
  vcmCatPath(SettingsPath, l_Path, f_CurrentUseCasePath);
 end;//lp_MakeCurrentUseCasePath

begin
 // Диспетчер может вызывать UnLock без вызова Lock, смотри
 // TvcmDispatcher.BackupLockStatus:
 if f_Locked = 0 then
  Exit;
 Dec(f_Locked);
 if (f_Locked = 0) and (LastAddedForm <> nil) then
 begin
  lp_MakeCurrentUseCasePath;
  LastAddedForm := nil;
  UpdateOperations;
 end;//if f_Locked = 0 then
 AfterUpdate;
end;//IvcmLockListener_UnLock

procedure TvcmCustOps.IvcmLockListener_UnLock;
  {* - действия разрешены. }
begin
end;//IvcmLockListener_UnLock

function TvcmCustOps.pm_GetIntGroups: TvcmCustOpsList;
begin
 if f_Groups = nil then
  f_Groups := TvcmCustOpsList.MakeSorted(l3_dupAccept);
 Result := f_Groups;
end;//pm_GetIntGroups

function TvcmCustOps.pm_GetIntRepGroups: TvcmCustOpsList;

 function lp_DoWord(const aStr : Tl3PCharLen;
                    IsLast     : Bool): Bool;
 var
  l_Group: TvcmCustOpsRepGroup;
 begin
  l_Group := TvcmCustOpsRepGroup.Create(Self, StrToInt(l3Str(aStr)),
   TvcmWString.MakeI(''));
  try
   f_RepGroups.Add(l_Group);
  finally
   FreeAndNil(l_Group);
  end;{try..finally}
  Result := True;
 end;//lp_DoWord

var
 l_Groups : IvcmCString;
begin
 if f_RepGroups = nil then
 begin
  f_RepGroups := TvcmCustOpsList.Make;
  vcmLoadStrParam(RepGroupsPath,
                  l_Groups,
                  False,
                  '');
  l3ParseWordsF(l_Groups.AsWStr, l3L2WA(@lp_DoWord));
 end;//if f_RepGroups then
 Result := f_RepGroups;
end;//pm_GetIntRepGroups

function TvcmCustOps.pm_GetGroup(const aIndex: Integer): TvcmCustOpsGroup;
begin
 Result := TvcmCustOpsGroup(Groups.Items[aIndex]);
end;//pm_GetGroup

function TvcmCustOps.pm_GetActionOwner: TComponent;
  {* - собственник создаваемых Action. }
begin
 if f_ActionOwner = nil then
  f_ActionOwner := TComponent.Create(nil);
 Result := f_ActionOwner;
end;//pm_GetActionOwner

function TvcmCustOps.pm_GetIntRepGroupsOperations: TvcmCustOpsList;
begin
 if f_RepGroupsOperations = nil then
  f_RepGroupsOperations := TvcmCustOpsList.Make;
 Result := f_RepGroupsOperations;
end;//pm_GetIntRepGroupsOperations

function TvcmCustOps.FindGroup(const aGroupId: Integer): TvcmCustOpsGroup;
  {-}
var
 l_Index: Integer;
begin
 for l_Index := 0 to Pred(Groups.Count) do
  if Group[l_Index].RepGroup.Id = aGroupId then
  begin
   Result := Group[l_Index];
   Exit;
  end;//if TvcmCustOpsGroup
 Result := nil;
end;//FindGroup

procedure TvcmCustOps.MoveToGroup(const aGroupId : Integer;
                                     const aOp      : TvcmCustOpsGroupOp);
  {* - переместить операцию в другую группу. }
var
 l_Group: TvcmCustOpsGroup;
begin
 aOp.Use;
 // Удалим из предыдущей группы:
 aOp.Remove;
 // Добавим в новую:
 l_Group := FindGroup(aGroupId);
 if l_Group = nil then
 begin
  AddGroup(FindRepGroup(aGroupId), -1);
  l_Group := FindGroup(aGroupId);
 end;//if l_Group = nil then
 l_Group.AddOperation(aOp);
end;//MoveToGroup

function TvcmCustOps.FindRepGroup(const aGroupId: Integer): IvcmCustOpsRepGroup;
  {-}
var
 l_Index: Integer;
begin
 Result := nil;
 for l_Index := 0 to Pred(RepGroups.Count) do
  if TvcmCustOpsRepGroup(RepGroups.Items[l_Index]).Id = aGroupId then
  begin
   Supports(RepGroups.Items[l_Index], IvcmCustOpsRepGroup, Result);
   Break;
  end;//if TvcmCustOpsRepGroup(
end;//FindRepGroup

procedure TvcmCustOps.SaveRepGroups;
  {* - сохранить группы в настройки. }
var
 l_Index : Integer;
 l_Value : String;
 l_Id    : String;
begin
 if not EnableSaveToSettings then Exit;
 
 for l_Index := 0 to Pred(f_RepGroups.Count) do
 begin
  l_Id := IntToStr(TvcmCustOpsRepGroup(f_RepGroups.Items[l_Index]).Id);
  if l_Value <> '' then
   l_Value := l_Value + ctp_RepGroupSeparator + l_Id
  else
   l_Value := l_Id;
 end;//for l_Index := 0 
 vcmSaveStrParamS(RepGroupsPath, vcmCStr(l_Value), '');
end;//SaveRepGroups

procedure TvcmCustOps.BeforeUpdate;
  {-}
begin
 CallNotify(Ord(cvcm_tpBeforeUpdate), 0);
end;//BeforeUpdate

procedure TvcmCustOps.AfterUpdate;
  {-}
begin
 CallNotify(Ord(cvcm_tpAfterUpdate), 0);
end;//AfterUpdate

procedure TvcmCustOps.RemoveOperations(const anAll: Boolean = False);
  {* - удалить операции панели задач. }
var
 l_GroupIndex : Integer;
 l_Op         : TvcmCustOpsGroupOp;
 l_Group      : TvcmCustOpsGroup;
 l_OpIndex    : Integer;
begin
 // Удалим операции панели задач привязанные к форме:
 for l_GroupIndex := Pred(Groups.Count) downto 0 do
 begin
  l_Group := Group[l_GroupIndex];
  for l_OpIndex := Pred(l_Group.Operations.Count) downto 0 do
  begin
   l_Op := TvcmCustOpsGroupOp(l_Group.Operations.Items[l_OpIndex]);
   // Добавлена новая форма, операция должна быть перечитана:
   if anAll or not l_Op.ForAllUseCases then
    l_Op.Remove;
  end;//for l_OpIndex := ...
 end;//for l_Index := Pred(Groups.Count) to 0 do
end;//RemoveOperations

procedure TvcmCustOps.UpdateOperations;
var
 l_RepOp : TvcmCustOpsRepOp;
 l_Op    : TvcmCustOpsGroupOp;

 function lp_IsForAllUseCase: Boolean;
  {* Операция показывается во всех прецедентах. }
 var
  l_Path: TvcmPathPairs;
 begin
  vcmCatPath(l_RepOp.ForAllUseCasesPath, ctp_stUse, l_Path);
  vcmLoadBoolParam(l_Path, Result, False, '');
 end;//lp_IsForAllUseCase

 function lp_IsForCurrentUseCase: Boolean;
  {* Операция показывается для текущего прецедента. }
 var
  l_Path: TvcmPathPairs;
 begin
  vcmCatPath(l_RepOp.CurrentUseCasePath, ctp_stUse, l_Path);
  vcmLoadBoolParam(l_Path, Result, False, '');
 end;//lp_IsForCurrentUseCase

 function lp_MakeOpIfNeeded: TvcmCustOpsGroupOp;
 begin
  Result := nil;
  if lp_IsForAllUseCase then
  begin
   Result := TvcmCustOpsGroupOp.Create(Self, nil, l_RepOp, True);
   Exit;
  end
  else
   // При использовании одной формы, идентификатор прецедента не используется:
   if AnalyzeOpForCurrentUseCase and lp_IsForCurrentUseCase then
    Result := TvcmCustOpsGroupOp.Create(Self, nil, l_RepOp, False)
   else
    Result := nil;
 end;//lp_MakeOpIfNeeded

 function lp_MakeGroup(const aOp: TvcmCustOpsGroupOp): TvcmCustOpsGroup;
  {* Создать группу для операции. }
 var
  l_RepGroupIntf: IvcmCustOpsRepGroup;
 begin
  // Найдем группу операции:
  Result := vcmFindGroup(Groups, l_Op.GroupId);
  if Result = nil then
  begin
   l_RepGroupIntf := FindRepGroup(l_Op.GroupId);
   try
    // Группа была удалена, удалим операцию, чтобы больше её не вычитывать:
    if l_RepGroupIntf = nil then
    begin
     l_Op.Delete;
     FreeAndNil(l_Op);
    end//if l_RepGroupIntf = nil then
    // Создадим группу панели задач:
    else
     AddGroup(l_RepGroupIntf, Result);
   finally
    l_RepGroupIntf := nil;
   end;//try..finally
  end;//if l_Group = nil then
 end;//lp_MakeGroup

var
 l_Group      : TvcmCustOpsGroup;
 l_GroupIndex : Integer;
 l_OpIndex    : Integer;
 l_RepGroup   : TvcmCustOpsRepGroupOps;
begin
 // Удалим операции привязанные к текущему прецеденту:
 RemoveOperations;
 // Открыли новый прецедент, поэтому обновим позиции:
 vcmUpdatePositions(Groups);
 for l_GroupIndex := 0 to Pred(Groups.Count) do
  vcmUpdatePositions(Group[l_GroupIndex].Operations);
 // Поместим операции на панель задач:
 for l_GroupIndex := 0 to Pred(RepGroupsOperations.Count) do
 begin
  l_RepGroup := TvcmCustOpsRepGroupOps(RepGroupsOperations.Items[l_GroupIndex]);
  for l_OpIndex := 0 to Pred(l_RepGroup.Operations.Count) do
  begin
   l_RepOp := TvcmCustOpsRepOp(l_RepGroup.Operations.Items[l_OpIndex]);
   // Операция не используется в панели задач:
   if l_RepOp.State <> tp_sUse then
   begin
    l_Op := lp_MakeOpIfNeeded;
    if l_Op <> nil then
    begin
     // Группа операции:
     l_Group := lp_MakeGroup(l_Op);
     // Добавить операцию в группу:
     if l_Group <> nil then
      l_Group.AddOperation(l_Op);
    end;//if l_Op <> nil then
   end;//if l_RepOp.State <> tp_sUse then
  end;//for l_OpIndex := 0...
 end;//for l_GroupIndex := 0 ...
end;//lp_UpdateOperations

procedure TvcmCustOps.AddGroup(const aRepGroup : IvcmCustOpsRepGroup;
                                  out aGroup      : TvcmCustOpsGroup;
                                  aPosition : Integer = -1);
      {-}
var
 l_Group : TvcmCustOpsGroup;
 l_Temp  : IvcmCustOpsGroup;
begin
 l_Group := TvcmCustOpsGroup.Create(Self, Groups, aRepGroup, aPosition);
 try
  Groups.Add(l_Group);
  aGroup := l_Group;
  if Supports(aGroup, IvcmCustOpsGroup, l_Temp) then
  try
   CallInterfaceNotify(Ord(cvcm_tpGroupAdded), l_Temp);
  finally
   l_Temp := nil;
  end;{try..finally}
 finally
  FreeAndNil(l_Group);
 end;{try..finally}
end;//AddGroup

procedure TvcmCustOps.Refresh;
  {* - полностью перечитать операции панели задач. Используется при
       переключении конфигурации. }
begin
 BeforeUpdate;
 try
  FreeAndNil(f_RepGroups);
   // - освободим группы репозитория, при первом обращении они будут перечитаны;
  RemoveOperations(True);
  UpdateOperations;
 finally
  AfterUpdate;
 end;//try..finally
end;//Refresh

function TvcmCustOps.AddGroup(const aRepGroup : IvcmCustOpsRepGroup;
                                 aPosition : Integer): IvcmCustOpsGroup;
  {-}
var
 l_Group: TvcmCustOpsGroup;
begin
 AddGroup(aRepGroup, l_Group, aPosition);
 Result := l_Group;
end;

procedure TvcmCustOps.DeleteRepGroup(const aGroup: IvcmCustOpsRepGroup);
  {* - удалить группу репозитория. }
var
 l_Index: Integer;
begin
 for l_Index := 0 to Pred(RepGroups.Count) do
  if TvcmCustOpsRepGroup(RepGroups.Items[l_Index]).Id = aGroup.Id then
  begin
   RepGroups.Delete(l_Index);
   SaveRepGroups;
   Break;
  end;//if TvcmCustOpsRepGroup
end;//DeleteRepGroup

function TvcmCustOps.AddRepGroup(const aGroup: IvcmCString): IvcmCustOpsRepGroup;
  {* - добавить группу репозитория. }
var
 l_Group: TvcmCustOpsRepGroup;
begin
 l_Group := TvcmCustOpsRepGroup.Create(Self, MakeRepGroupId, aGroup);
 try
  RepGroups.Add(l_Group);
  SaveRepGroups;
  Result := l_Group;
 finally
  FreeAndNil(l_Group);
 end;{try..finally}
end;//AddRepGroup

// start class TvcmCustOpsNotifier

procedure TvcmCustOpsNotifier.CallInterfaceNotify(aOperation : Integer; const aInterface : IvcmBase);
  {* - прошла операция. }
{$IfDef Nemesis}
var
 l_Index     : Integer;
 l_Recipient : IvcmTaskPanelNotifyRecipient;
 l_Item      : Il3Notify;
{$EndIf Nemesis} 
begin
 {$IfDef Nemesis}
 if (f_NotifiedObjList <> nil) then
  for l_Index := f_NotifiedObjList.Hi downto 0 do
  begin
   try // - зачем ??!!
    l_Item := f_NotifiedObjList[l_Index];
    if Supports(l_Item, IvcmTaskPanelNotifyRecipient, l_Recipient) and
       (l_Item = l_Recipient) then
     try
      l_Recipient.TaskPanelNotify(Il3ChangeNotifier(Self), TvcmTaskPanelOperation(aOperation), IvcmCustOpsItem(aInterface));
     finally
      l_Recipient := nil;
     end;//try..finally
   except
   end;//try..execpt
  end;//for l_Index
 {$EndIf Nemesis} 
end;

end.
