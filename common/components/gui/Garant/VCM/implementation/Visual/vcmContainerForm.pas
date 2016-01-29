unit vcmContainerForm;
{* Контейнер форм. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmContainerForm - }
{ Начат: 21.04.2003 19:05 }
{ $Id: vcmContainerForm.pas,v 1.118 2015/11/02 16:25:03 kostitsin Exp $ }

// $Log: vcmContainerForm.pas,v $
// Revision 1.118  2015/11/02 16:25:03  kostitsin
// {requestlink: 569239206 }
//
// Revision 1.117  2015/09/30 09:23:03  morozov
// {RequestLink: 607522449}
//
// Revision 1.116  2015/09/07 12:34:56  morozov
// {RequestLink: 606799643}
//
// Revision 1.115  2015/09/03 12:25:04  morozov
// {RequestLink: 606410551}
//
// Revision 1.114  2015/07/21 12:22:09  morozov
// {RequestLink: 603606111}
//
// Revision 1.113  2015/07/20 10:07:12  morozov
// {RequestLink: 578895365}
//
// Revision 1.112  2015/03/18 11:14:10  lulin
// - упорядочиваем генерацию зависимостей.
//
// Revision 1.111  2015/01/16 15:07:45  kostitsin
// {requestlink: 585429385 }
//
// Revision 1.110  2015/01/16 15:05:07  kostitsin
// {requestlink: 585429385 }
//
// Revision 1.109  2015/01/15 18:05:06  kostitsin
// {requestlink: 585429385 }
//
// Revision 1.108  2014/10/07 08:29:09  morozov
// {RequestLink: 566113866}
//
// Revision 1.107  2014/10/07 06:14:58  morozov
// {RequestLink: 566113866}
//
// Revision 1.106  2014/09/30 08:46:45  morozov
// {RequestLink: 565492823}
//
// Revision 1.105  2014/09/15 07:31:38  kostitsin
// {requestlink: 565004022 }
//
// Revision 1.104  2014/09/10 10:57:22  kostitsin
// {requestlink: 564997003 }
//
// Revision 1.103  2014/07/03 05:39:47  morozov
// {RequestLink: 340174500}
//
// Revision 1.102  2014/02/05 12:34:18  morozov
// {RequestLink: 370384532}
//
// Revision 1.101  2013/04/25 14:22:38  lulin
// - портируем.
//
// Revision 1.100  2012/09/10 14:44:40  lulin
// - так удобнее отлаживаться.
//
// Revision 1.99  2012/08/10 14:13:38  lulin
// {RequestLink:382420790}
//
// Revision 1.98  2012/08/06 17:26:06  lulin
// {RequestLink:380046115}
//
// Revision 1.97  2012/08/06 17:04:04  lulin
// {RequestLink:380046115}
//
// Revision 1.96  2012/04/16 14:15:41  lulin
// - чистка кода.
//
// Revision 1.95  2012/04/13 14:38:46  lulin
// {RequestLink:237994598}
//
// Revision 1.94  2012/04/09 08:39:12  lulin
// {RequestLink:237994598}
// - думаем о VGScene.
//
// Revision 1.93  2012/04/09 06:14:07  lulin
// {RequestLink:237994598}
//
// Revision 1.92  2012/04/05 19:44:28  lulin
// {RequestLink:237994598}
//
// Revision 1.91  2012/04/04 17:55:45  lulin
// {RequestLink:237994598}
// - разбираемся с упавшими тестами.
//
// Revision 1.90  2012/04/04 14:18:26  lulin
// {RequestLink:237994598}
// М. Морозов....
// - боремся с зонами и объединёнными тулбарами.
//
// Revision 1.89  2012/04/04 08:57:04  lulin
// {RequestLink:237994598}
//
// Revision 1.88  2012/03/27 17:59:31  lulin
// - выделяем общую часть.
//
// Revision 1.87  2012/02/01 16:20:29  lulin
// {RequestLink:332566005}
//
// Revision 1.86  2011/12/22 14:47:29  lulin
// {RequestLink:320745296}
//
// Revision 1.85  2011/06/20 13:46:04  lulin
// {RequestLink:269081712}.
//
// Revision 1.84  2011/04/15 14:50:09  lulin
// {RequestLink:228688732}.
// - делаем оснастку для возможности придания каждой медали своего баллона.
//
// Revision 1.83  2011/03/15 16:45:50  lulin
// {RequestLink:228688510}.
// - чистим мусорок.
//
// Revision 1.82  2011/03/15 16:19:41  lulin
// {RequestLink:228688510}.
// [$255978845].
// [$255983129].
// - не даём таскать сплиттер у толкования без перевода.
//
// Revision 1.81  2011/03/11 18:05:12  lulin
// {RequestLink:228688510}.
// - впихиваем БП в специально подготовленный контейнер.
//
// Revision 1.80  2010/09/17 11:34:48  oman
// - fix: {RequestLink:235047450}
//
// Revision 1.79  2009/10/14 18:39:54  lulin
// {RequestLink:166855347}.
//
// Revision 1.78  2009/10/13 10:04:56  lulin
// - правильнее показываем баннеры и БП.
//
// Revision 1.77  2009/10/07 12:11:42  lulin
// - для контролов, которые не попадают в dfm определяем зоны в коде.
//
// Revision 1.76  2009/10/01 15:59:32  lulin
// {RequestLink:159360578}. №47.
//
// Revision 1.75  2009/10/01 14:58:33  lulin
// - убираем сферического коня в вакууме.
//
// Revision 1.74  2009/09/30 15:23:02  lulin
// - убираем ненужное приведение ко вполне понятным интерфейсам.
//
// Revision 1.73  2009/09/25 12:09:16  lulin
// - выкидываем ненужное.
//
// Revision 1.72  2009/08/04 16:53:02  lulin
// - наконец-то дошли до вызова сравнения редакций, которое падает.
//
// Revision 1.71  2009/08/03 18:12:39  lulin
// - публикуем операции.
//
// Revision 1.70  2009/05/29 09:21:06  lulin
// [$148572354].
//
// Revision 1.69  2009/02/20 17:57:43  lulin
// - <K>: 136941122. Чистка кода.
//
// Revision 1.68  2009/02/20 15:19:08  lulin
// - <K>: 136941122.
//
// Revision 1.67  2009/02/20 13:07:08  lulin
// - <K>: 136941122.
//
// Revision 1.66  2009/02/12 18:06:15  lulin
// - <K>: 135604584. Переносим константы.
//
// Revision 1.65  2009/02/04 09:03:19  lulin
// - <K>: 135136020. Переносим из формы на модель.
//
// Revision 1.64  2009/01/30 13:51:37  lulin
// - чистка кода.
//
// Revision 1.63  2008/02/19 11:05:51  lulin
// - восстановил всякие экзотические поиски в списках объектов.
//
// Revision 1.62  2008/02/13 16:03:06  lulin
// - убраны излишне гибкие методы поиска.
//
// Revision 1.61  2008/01/26 08:35:37  mmorozov
// - new behaviour: если найден контейнер подходящий условиям поиска и поиск рекурсивный, то ищем в контейнере, если в контейнере ничего не найдено, то возвращаем контейнер (в рамках CQ: OIT5-10956);
//
// Revision 1.60  2007/06/20 07:29:38  mmorozov
// - fixed: compiler hint;
//
// Revision 1.59  2007/06/20 06:51:26  mmorozov
// - библиотека не компилировалась;
//
// Revision 1.58  2007/06/18 13:38:46  mmorozov
// - new behaviour: при открытии нового прецедента сначала удаляем формы из панели задач потом регистрируем новые, алгоритм по которому выполнены измнения см. в К<18219426>;
//
// Revision 1.57  2007/05/21 13:33:19  lulin
// - cleanup.
//
// Revision 1.56  2007/03/12 13:54:43  lulin
// - cleanup.
//
// Revision 1.55  2007/03/12 12:36:20  lulin
// - cleanup.
//
// Revision 1.54  2007/01/23 13:31:38  lulin
// - убран метод установки контейнера.
//
// Revision 1.53  2007/01/22 06:40:42  mmorozov
// - change: в стилей панелей инструментов используем интерфейс контейнера, а не класс;
//
// Revision 1.52  2007/01/19 11:53:22  lulin
// - данные переехали с общих параметров на более специализированные.
//
// Revision 1.51  2007/01/19 09:47:39  lulin
// - выделяем интерфейс параметров для создания формы.
//
// Revision 1.50  2007/01/18 13:13:46  lulin
// - разводим в стороны параметры для теста и для выполнения.
//
// Revision 1.49  2007/01/18 12:09:23  lulin
// - разводим в стороны параметры для теста и для выполнения.
//
// Revision 1.48  2006/12/27 14:44:57  mmorozov
// - change: механизм объединения панелей инструментов (CQ: OIT5-23903);
//
// Revision 1.47  2006/12/13 09:22:08  mmorozov
// - new: возможность указывать фиксированный размер для зон стыковки панелей инструментов формы, в рамках работы над CQ: OIT5-13323;
//
// Revision 1.46  2006/12/10 17:34:41  lulin
// - cleanup.
//
// Revision 1.45  2006/03/24 12:11:30  lulin
// - cleanup: не пишем пустые коллекции.
//
// Revision 1.44  2006/02/02 14:48:46  mmorozov
// new: вычисление модуля в котором зарегистрирована формы, по классу формы;
// change: убрано указание модуля при создании формы;
//
// Revision 1.43  2005/10/05 14:25:43  mmorozov
// new: у vcmEntityForm появился дополнительный идентификатор SubUserType;
//
// Revision 1.42  2005/10/04 10:06:11  mmorozov
// new: вложенная в контейнер форма уведомляет его о смене источника данных (событие на контейнере OnChildDataSourceChanged);
// new: на контейнере новое событие OnNeedUpdateTab (вызывается при вставке формы и смене _DataSource у вложенной формы);
//
// Revision 1.41  2005/08/25 10:24:12  lulin
// - new behavior: теперь в историю сохраняется _DataSource от формы.
//
// Revision 1.40  2004/11/16 14:52:32  mmorozov
// bugfix: перед установкой фокуса зоне проверяем CanFocus;
//
// Revision 1.39  2004/11/15 14:28:54  demon
// - new method: _IvcmContainer._SetFocusToZone(aZoneType: TvcmZoneType); устанавливает фокус в самую вложенную форму указанной зоны контейнера.
//
// Revision 1.38  2004/10/07 12:45:25  mmorozov
// new: method _TvcmContainerForm._RestoreControlSize;
//
// Revision 1.37  2004/10/05 11:54:33  mmorozov
// new: при определении маленьких иконок используем IvcmEntityForm._ZoneControl;
//
// Revision 1.36  2004/09/13 15:50:31  lulin
// - cleanup: выкинул лишний модуль из Toolbar 97.
// - bug fix: за Мишей - не компилировался VCM.
//
// Revision 1.35  2004/09/13 14:28:43  mmorozov
// new: type TvcmAfterRemoveFormEvent;
// new: proprety OnAfterRemoveForm;
//
// Revision 1.34  2004/09/11 12:46:38  lulin
// - bug fix: не компилировался VCM.
//
// Revision 1.33  2004/09/11 11:37:33  lulin
// - cleanup.
//
// Revision 1.32  2004/09/11 09:48:52  lulin
// - bug fix: оставалась закладка при переходе по истории.
//
// Revision 1.31  2004/09/10 16:55:59  mmorozov
// new: держим список форм контейнера и осуществляем поиск в методе _HasForm;
// new: methods RegForm, UnregForm, _RemoveForm;
//
// Revision 1.30  2004/09/10 12:23:56  lulin
// - оптимизация - гораздо аккуратнее обращаемся с UserType'ами и VisibleOpCount. В итоге уменьшено количество различных вызовов.
//
// Revision 1.29  2004/09/03 11:47:04  mmorozov
// new: method _TvcmContainerForm.IsSmallImages;
//
// Revision 1.28  2004/09/02 06:57:10  law
// - bug fix: при восстановлении формы из истории не учитывался GUID (точнее подменялся старый) и из-за этого не сохранялось состояние формы по операции Back (и соответственно не восстанавливалось по Forward) (CQ OIT5-8743).
//
// Revision 1.27  2004/07/21 13:50:05  am
// change: Create -> CreateNew (для возможности создания форм без ресурсов)
// bugfix: _HasForm
//
// Revision 1.26  2004/04/01 13:44:43  law
// - bug fix: поиск по истории при _MakeSingleChild не учитывал GUID формы (CQ OIT5-6957).
//
// Revision 1.25  2004/03/31 14:36:33  law
// - bug fix: при поиске форм в _MakeSingleChild не учитывали UserType.
//
// Revision 1.24  2004/03/19 15:03:23  mmorozov
// new: в метод _HasForm добавлен параметр (UserType : Integer = vcm_utAny);
//
// Revision 1.23  2004/01/30 17:14:43  law
// - new method version: _IvcmContainer._HasForm.
//
// Revision 1.22  2004/01/29 16:44:19  law
// - new method: _IvcmContainer._MakeSingleChild.
//
// Revision 1.21  2004/01/29 16:28:03  law
// - new method: _TvcmContainerForm._MakeSingleChild.
//
// Revision 1.20  2003/11/28 13:01:34  law
// - new behavior: опираемся на идентификаторы форм, а не на имена.
//
// Revision 1.19  2003/11/26 17:33:44  law
// - bug fix: учитвыаем, что Container не может быть = nil, а может быть _IsNull.
//
// Revision 1.18  2003/11/26 16:00:34  law
// - new method: _IvcmContainer._IsNull.
//
// Revision 1.17  2003/10/23 12:12:14  law
// - remove proc: EntityBroadcast, как ненужную и не совсем прозрачную.
//
// Revision 1.16  2003/10/20 10:51:33  migel
// - new: посылка операции сущности в режиме бродкаста.
//
// Revision 1.15  2003/09/04 10:27:36  law
// - new prop: IvcmEntityForm._MainCaption.
//
// Revision 1.14  2003/06/26 07:00:09  narry
// - update: продолжение документирования
//
// Revision 1.13  2003/06/23 15:03:24  law
// - change: свойство _IvcmContainer.GUID переехало в IvcmEntityForm.GUID - теперь каждая форма имеет свой идентификатор.
// - remove interface: IvcmGUIDSetter.
// - new param: конструктор _TvcmEntityForm.Make имее еще один параметр - aGUID - для восстановления идентификатора формы при операциях Back/Forward.
//
// Revision 1.12  2003/06/23 14:27:07  law
// - new behavior: теперь контейнер восстанавливает свой GUID при операциях Back/Forward.
//
// Revision 1.11  2003/06/23 13:12:21  law
// - new prop: _IvcmContainer.GUID.
//
// Revision 1.10  2003/06/17 11:42:50  narry
// - update: продолжение документирования
//
// Revision 1.9  2003/06/02 15:19:47  narry
// - update: продолжение документирования библиотеки
//
// Revision 1.8  2003/04/30 12:51:07  law
// - new event: _TvcmContainerForm.OnAfterInsertForm.
//
// Revision 1.7  2003/04/30 12:03:27  law
// - new event: _TvcmContainerForm._OnInsertForm.
//
// Revision 1.6  2003/04/23 14:54:33  law
// - new method: _IvcmContainer._HasForm.
//
// Revision 1.5  2003/04/22 14:03:01  law
// - new behavior: сделана обработка операций, описанных на основной форме.
//
// Revision 1.4  2003/04/21 16:16:04  law
// - new behavior: сделана вставка формы в контрол, связанный с зоной.
//
// Revision 1.3  2003/04/21 15:59:12  law
// - bug fix: надо было создавать зоны до вызова унаследованного конструктора.
//
// Revision 1.2  2003/04/21 15:51:07  law
// - new: реализуем описание зон докинга в _TvcmContainerForm - свойство Zones.
//
// Revision 1.1  2003/04/21 15:27:00  law
// - new interface: IvcmContainerForm.
//

{$Include vcmDefine.inc }

interface

uses
  Classes,

  Controls,
  Forms,

  vcmUserControls,
  vcmExternalInterfaces,
  vcmInterfaces,
  vcmInternalInterfaces,

  vcmBase,
  vcmEntityForm,
  vcmZonesCollection,
  vcmZonesCollectionItem,

  vcmContainerFormModelPart,

  vcmFormSetRefList,
  vcmAggregateRefList
  ;

type
  TvcmInsertMode = (vcm_imAllow, vcm_imDisable, vcm_imToParent);
   { Summary
     Режим добавления формы.

     Description

     <TABLE>
     Значение         Описание
     ---------------  --------------------------------------------
     vcm_imAllow      Разрешение добавления формы в текущий
                       контейнер.
     vcm_imDisable    Запрет добавления формы в текущий контейнер
     vcm_imToParent   Перенаправление операции добавления формы в
                       форму- родитель
     </TABLE>                                                      }
  TvcmInsertFormEvent = procedure (const aForm : IvcmEntityForm;
                                   var aMode   : TvcmInsertMode) of object;
   { Parameters
     aForm :  Добавляемая форма
     aMode :  Режим добавления формы
     Description
     Тип события, вызываемого в момент добавления формы в
     контейнер.

     Позволяет управлять добавлением форм в контейнер. 
     <TABLE>
     Значение aMode   Описание
     ---------------  --------------------------------------
     vcm_imAllow      Форма вставляется в текущий контейнер
     vcm_imDisable    Форме отказано в добавлении
     vcm_imToParent   Форма перенаправляется в родительскую
                       форму
     </TABLE>                                                }
  TvcmAfterInsertFormEvent = procedure (const aForm : IvcmEntityForm) of object;
   { Вызывается после добавления формы в контейнер.
     
     Description
     Использование TOnAfterInsertFormEvent позволяет выполнить
     дополнительные действия, связанные с добавленем формы в
     контейнер.                                                }
  TvcmAfterRemoveFormEvent = procedure (const aForm : IvcmEntityForm) of Object;
    {* - обработчик уведомления об удалении формы. }
  TvcmOnNeedUpdateTab = procedure (aSender : TObject;
                                   const aForm   : IvcmEntityForm) of Object;
    {* - вызывается при необходимости обновить данные закладок PageControl-а. }
  TvcmContainerForm = class(TvcmContainerFormModelPart, IvcmContainer)
   {* Контейнер форм. }
    private
    // internal fields
      f_Zones                    : TvcmZonesCollection;
      f_OnInsertForm             : TvcmInsertFormEvent;
      f_OnAfterInsertForm        : TvcmAfterInsertFormEvent;
      f_OnAfterRemoveForm        : TvcmAfterRemoveFormEvent;
      f_Forms                    : TvcmInterfacePtrList;
      f_OnNeedUpdateTab          : TvcmOnNeedUpdateTab;
      f_FormSets                 : TvcmFormSetRefList;
      f_Aggregates               : TvcmAggregateRefList;
    private
    // interface methods
      // IvcmContainer
      function pm_GetEntityFormIterator: IvcmEntityFormIterator;
        {* - итератор форм контейнера. }
      function pm_GetFormSetIterator: IvcmFormSetIterator;
        {* - итератор сборок в контейнере. }
      function pm_GetAggregateIterator: IvcmAggregateIterator;
        {* - итератор аггрегаций в контейнере. }
      procedure InitFromPrevContainer(const aPrevContainer: IvcmContainer;
        aForClone: Boolean);
        {-}
    private
    // internal methods
      procedure DoAfterRemoveForm(const aForm : IvcmEntityForm);
        {* - триггер для вызова обработчика OnAfterRemoveForm. }
      procedure DoNeedUpdateTab(const aForm: IvcmEntityForm);
        {* - триггер для вызова обработчика OnNeedUpdateTab. }
      procedure InitZones;
        {-}
    protected
    // realized methods
      function NeedSetFocusToMainObjectFormOnRefresh: Boolean;
        {* Надо ли передвигать фокус в главную форму при изменении сборки }
      function GetNeedSetFocusToMainObjectFormOnRefresh: Boolean; virtual;
        {* Надо ли передвигать фокус в главную форму при изменении сборки }
      procedure SetTabCaption(const aTabCaption: IvcmCString); virtual;
        {-}
      procedure DoInitFromPrevContainer(const aPrevContainer: IvcmContainer;
       aForClone: Boolean); virtual;
        {-}
      procedure CheckFormSetAndAggregateList;
        {-}
    protected
    // protected methods
      procedure pm_SetZones(aValue: TvcmZonesCollection);
      function  ZonesStored: Boolean;
        {-}
      function  Get_MainCaption: IvcmCString;
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
      function GetInnerContainer: IvcmContainer;

      procedure SetFocusToMainObjectForm;
        {* - устанавливаем фокус в самую вложенную форму указанной зоны. }

      procedure ChildDataSourceChanged(const aChild : IvcmEntityForm;
                                       const anOld  : IvcmFormDataSource;
                                       const aNew   : IvcmFormDataSource); virtual;
        {* - вызывается при изменении источника данных вложенной формы. }
      function Get_AsForm: IvcmEntityForm;
      class function FormImplementationClass: TClass;
        override;
        {-}
      procedure NotifyDataSourceChanged(const anOld : IvcmFormDataSource;
                                        const aNew  : IvcmFormDataSource); override;
    public
    // public methods
      {$IfDef XE}
      constructor Create(anOwner: TComponent);
        override;
        { Создает форму. }
      {$EndIf XE}
      constructor CreateNew(anOwner: TComponent; anDummy: Integer = 0);
        override;
        { Создает форму. }
      procedure Loaded;
        override;
        {-}
      procedure RegForm(const aForm : IvcmEntityForm);
        {-}
      procedure UnregForm(const aForm : IvcmEntityForm);
        {-}
      function InsertForm(const aForm: IvcmEntityForm): Boolean;
        virtual;
        { Вставляет форму в контейнер.

          Returns
          Возвращает True, если добавление формы прошло успешно.

          Parameters
          aForm :  Форма, добавляемая в контейнер.               }
      function HasForm(aZoneType   : TvcmZoneType = vcm_ztAny;
                       aRecursive  : Boolean = true;
                       theForm     : PIvcmEntityForm = nil;
                       aUserType   : TvcmUserType = vcm_utAny;
                       aGUID       : PGUID = nil;
                       aSubUserType : TvcmUserType = vcm_utAny): Boolean;
        overload;
        {* - проверяет есть ли в контейнере такая форма. }
      function HasForm(const aName : TvcmFormID;
                       aZoneType   : TvcmZoneType = vcm_ztAny;
                       aRecursive  : Boolean = true;
                       theForm     : PIvcmEntityForm = nil;
                       aUserType   : TvcmUserType = vcm_utAny;
                       aGUID       : PGUID = nil;
                       aSubUserType : TvcmUserType = vcm_utAny): Boolean;
        overload;
        { Проверяет есть ли в контейнере форма с указанными
          параметрами.
          Returns:
          - True, если в контейнере есть форма с указанными параметрами.
          Parameters:
          - aName      :  Имя формы;
          - aZoneType  :  Зона докинга;
          - aRecursive :  Искать во вложенных формах;
          - theForm    :  Указатель на искомую форму; }
      function IsNull: Boolean;
        {-}
      procedure IvcmContainer_FormStyle(const aForm  : IvcmEntityForm;
                                        const aStyle : IvcmFormStyle);
      procedure IvcmContainer.FormStyle = IvcmContainer_FormStyle;
        {* - определить стиль формы зоны. }
      procedure RestoreControlSize; virtual;
        {* - восстанавливает размеры компонентов формы к первоначальным. }
      function DefineZone(aType : TvcmEffectiveZoneType; aControl : TComponent) : TvcmZonesCollectionItem;
        {-}
      function AcceptForm(const aForm : IvcmEntityForm;
                          aControl    : TComponent = nil): Boolean; virtual;
        {* - разрешает или запрещает придочивать форму руками. }
    public
    // public events
      property OnInsertForm : TvcmInsertFormEvent
        read f_OnInsertForm
        write f_OnInsertForm;
        { Description
          Вызывается в момент вставления дочерней формы. В зависимости
          от логики приложения можно управлять добавлением формы в
          контейнер.

          Summary
          Событие для вставки формы.                                   }
      property OnAfterInsertForm: TvcmAfterInsertFormEvent
        read f_OnAfterInsertForm
        write f_OnAfterInsertForm;
        { Вызывается после добавления дочерней формы в контейнер. }
      property OnAfterRemoveForm : TvcmAfterRemoveFormEvent
        read f_OnAfterRemoveForm
        write f_OnAfterRemoveForm;
        {* - Уведомление пользователя об удалении формы. }
      property OnNeedUpdateTab: TvcmOnNeedUpdateTab
        read f_OnNeedUpdateTab
        write f_OnNeedUpdateTab;
        {* - вызывается при необходимости обновить данные закладок PageControl-а. }
    published
    // published properties
      property Zones: TvcmZonesCollection
        read f_Zones
        write pm_SetZones
        stored ZonesStored;
        { Description
          Каждая зона докинга должна быть связана с визуальным
          элементом, поддерживающим операцию ManualDock. В зависисмости
          от поведения конкретного элемента вложение форм происходит
          по-разному. Элементы, сходные с TPanel могут содержать в себе
          только одну форму, попытка добавить вторую форму приведет к
          тому, что текущая вставленная форма будет уничтожена.
          Элементы, сходные с TPageControl могут содержать в себе
          несколько форм, каждая дополнительная форма создает новую
          закладку на элементе.
          
          Summary
          Список зон докинга.                                           }
  end;//TvcmContainerForm

  TvcmContainerFormImplementation = class(TvcmEntityFormImplementation)
    protected
      function  Get_AsContainer : IvcmContainer;
        override;
        {-}
  end;//TvcmContainerFormImplementation

implementation

uses
  Windows,
  SysUtils,

  l3TabbedContainersDispatcher,

  vcmSettings,
  vcmForm, 
  vcmStyle,
  vcmInternalConst
  ;

type
  TvcmEntityFormIterator = class(TvcmBase,
                                 IvcmEntityFormIterator)
  {* Итератор форм контейнера. }
  private
  // fields
    f_Forms   : TvcmInterfacePtrList;
    f_Current : Integer;
  private
  // IvcmEntityFormIterator
    // public methods
      function Next: IvcmEntityForm;
        {-}
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
  public
  // methods
    constructor Create(const aForms: TvcmInterfacePtrList);
      reintroduce;
      {-}
    class function Make(const aForms: TvcmInterfacePtrList): IvcmEntityFormIterator;
      {-}
  end;//TvcmEntityFormIterator

  TvcmAggregateIterator = class(TvcmBase,
                                IvcmAggregateIterator)
  private
   f_List: TvcmAggregateRefList;
   f_Current: Integer;
  protected
   function Next: IvcmAggregate;
   procedure CleanUp; override;
  public
   constructor Create(aList: TvcmAggregateRefList);
   class function Make(aList: TvcmAggregateRefList): IvcmAggregateIterator;
  end;

  TvcmFormSetIterator = class(TvcmBase,
                                   IvcmFormSetIterator)
  private
   f_List: TvcmFormSetRefList;
   f_Current: Integer;
  protected
   function Next: IvcmFormSet;
   procedure CleanUp; override;
  public
   constructor Create(aList: TvcmFormSetRefList);
   class function Make(aList: TvcmFormSetRefList): IvcmFormSetIterator;
  end;


// start class TvcmContainerForm

{$IfDef XE}
constructor TvcmContainerForm.Create(anOwner: TComponent);
  //override;
  { Создает форму. }
begin
 f_FormSets   := TvcmFormSetRefList.Create;
 f_Aggregates := TvcmAggregateRefList.Create;
 f_Zones := TvcmZonesCollection.Create(Self);
 inherited;
end;
{$EndIf XE}

constructor TvcmContainerForm.CreateNew(anOwner: TComponent; anDummy: Integer);
  //override;
  {* - создает форму. }
begin
 {$IfDef XE}
 assert(false, 'По идее по новой идеологии XE - мы не должны придти сюда');
 {$Else  XE}
 f_FormSets   := TvcmFormSetRefList.Create;
 f_Aggregates := TvcmAggregateRefList.Create;
 f_Zones := TvcmZonesCollection.Create(Self);
 {$EndIf XE}
 inherited;
end;

procedure TvcmContainerForm.Cleanup;
begin
 vcmFree(f_Forms);
 FreeAndNil(f_Zones);
 FreeAndNil(f_FormSets);
 FreeAndNil(f_Aggregates);
 inherited;
end;

function TvcmContainerForm.pm_GetEntityFormIterator: IvcmEntityFormIterator;
  {* - итератор форм контейнера. }
begin
 Result := TvcmEntityFormIterator.Make(f_Forms);
end;//pm_GetEntityFormIterator

function TvcmContainerForm.pm_GetFormSetIterator: IvcmFormSetIterator;
  {* - итератор сборок в контейнере. }
begin
 Result := TvcmFormSetIterator.Make(f_FormSets);
end;

function TvcmContainerForm.pm_GetAggregateIterator: IvcmAggregateIterator;
  {* - итератор аггрегаций в контейнере. }
begin
 Result := TvcmAggregateIterator.Make(f_Aggregates);
end;

procedure TvcmContainerForm.RegForm(const aForm : IvcmEntityForm);
var
 l_Index : Integer;
begin
 if (f_Forms = nil) then
  f_Forms := TvcmInterfacePtrList.Make;
 if not f_Forms.FindData(aForm, l_Index) then
  f_Forms.Add(aForm);
end;

procedure TvcmContainerForm.UnregForm(const aForm : IvcmEntityForm);
var
 lIndex : Integer;
begin
 if Assigned(f_Forms) and
  f_Forms.FindData(aForm, lIndex) then
 begin
  f_Forms.Remove(aForm);
  DoAfterRemoveForm(aForm);
 end;//Assigned(f_Forms)
end;

procedure TvcmContainerForm.DoNeedUpdateTab(const aForm: IvcmEntityForm);
  {* - триггер для вызова обработчика OnNeedUpdateTab. }
begin
 if Assigned(f_OnNeedUpdateTab) then
  f_OnNeedUpdateTab(Self, aForm);
end;

procedure TvcmContainerForm.DoAfterRemoveForm(const aForm : IvcmEntityForm);
begin
 CheckFormSetAndAggregateList;
 if Assigned(f_OnAfterRemoveForm) then
  f_OnAfterRemoveForm(aForm);
end;

procedure TvcmContainerForm.NotifyDataSourceChanged(const anOld : IvcmFormDataSource;
                                                    const aNew  : IvcmFormDataSource);
begin
 inherited;
 DoNeedUpdateTab(Self.As_IvcmEntityForm);
end;

function TvcmContainerForm.InsertForm(const aForm: IvcmEntityForm): Boolean;
  {* - вставляет форму в контейнер. }
var
 l_Container : IvcmContainer;
 l_Mode      : TvcmInsertMode;
begin
 if Assigned(f_OnInsertForm) then begin
  Result := false;
  l_Mode := vcm_imAllow;
  f_OnInsertForm(aForm, l_Mode);
  Case l_Mode of
   vcm_imAllow    : Result := Zones.InsertForm(aForm);
   vcm_imDisable  : Exit;
   vcm_imToParent : ;
  end;//Case l_Mode
 end else
  Result := Zones.InsertForm(aForm);
 if not Result then begin
  l_Container := Container;
  if not l_Container.IsNull then
   Result := l_Container.InsertForm(aForm);
 end;//not Result
 if Result then
 begin
  AfterInsertForm(aForm);
  CheckFormSetAndAggregateList;  
 end;
 if Result AND Assigned(f_OnAfterInsertForm) then
  f_OnAfterInsertForm(aForm);
 if Result then
  DoNeedUpdateTab(aForm);
end;

function TvcmContainerForm.HasForm(aZoneType    : TvcmZoneType = vcm_ztAny;
                                   aRecursive   : Boolean = true;
                                   theForm      : PIvcmEntityForm = nil;
                                   aUserType    : TvcmUserType = vcm_utAny;
                                   aGUID        : PGUID = nil;
                                   aSubUserType : TvcmUserType = vcm_utAny): Boolean;
  //overload;
  {* - проверяет есть ли в контейнере такая форма. }
begin
 Result := HasForm(fm_Any, aZoneType, aRecursive, theForm, aUserType, aGUID,
  aSubUserType);
end;

function TvcmContainerForm.HasForm(const aName  : TvcmFormID;
                                   aZoneType    : TvcmZoneType = vcm_ztAny;
                                   aRecursive   : Boolean = true;
                                   theForm      : PIvcmEntityForm = nil;
                                   aUserType    : TvcmUserType = vcm_utAny;
                                   aGUID        : PGUID = nil;
                                   aSubUserType : TvcmUserType = vcm_utAny): Boolean;
  {* - проверяет есть ли в контейнере такая форма. }
var
 l_Index     : Integer;
 l_Container : IvcmContainer;

 function lp_FindInContainer(const aForm: IvcmEntityForm): Boolean;
 begin
  if Supports(aForm, IvcmContainer, l_Container) then
  try
   Result := l_Container.HasForm(aName,
                                 aZoneType,
                                 aRecursive,
                                 theForm,
                                 aUserType,
                                 aGUID,
                                 aSubUserType);
  finally
   l_Container := nil;
  end//try..finally
  else
   Result := False;
 end;//lp_FindInContainer

(*var
 l_PF : TCustomForm; *)
begin
 Result := false;
 if (f_Forms <> nil) then
 begin
  // Поищем в списке форм контейнера:
  for l_Index := 0 to Pred(f_Forms.Count) do
   with IvcmEntityForm(f_Forms.Items[l_Index]) do
   begin
    if not InClose then
     if (
         (aZoneType = vcm_ztAny) OR
         (aZoneType = ZoneType) OR
         ((aZoneType = vcm_ztMainObjectForm) AND IsMainObjectForm) OR
         ((aZoneType = vcm_ztForFocus) AND (VCLWinControl As TvcmEntityForm).NeedSetMyFocus)
        ) then
      if ((aName.rName = '') OR SameName(aName)) then
       if ((aUserType = vcm_utAny) OR
                  ((VCLWinControl As TvcmEntityForm).UserType = aUserType)) then
        if ((aSubUserType = vcm_utAny) OR
                   ((VCLWinControl As TvcmEntityForm).SubUserType = aSubUserType)) then
         Result := ((aGUID = nil) OR IsEqualGUID(GUID, aGUID^));
(*    if Result then
    begin
     l_PF := GetParentForm(IvcmEntityForm(f_Forms.Items[l_Index]).VCLForm);
     if (l_PF <> nil) then
      if (l_PF <> IvcmEntityForm(f_Forms.Items[l_Index]).VCLForm) then
       if not l_PF.Visible then
       // http://mdp.garant.ru/pages/viewpage.action?pageId=269081712
       // - чтобы не находить спрятанные баллоны
        Result := false;
    end;//Result*)
// - нельзя так делать, все макароны нафиг разваливаются
    // Форму нашли, выходим:
    if Result then
    begin
     if not (aRecursive and lp_FindInContainer(IvcmEntityForm(f_Forms.
       Items[l_Index]))) and (theForm <> nil) then
      theForm^ := IvcmEntityForm(f_Forms.Items[l_Index]);
     Exit;
    end;//if Result then
   end;//with IvcmEntityForm(f_Forms.Items[lIndex])
  // Форма не найдена поищем рекурсивно:
  if aRecursive then
   for l_Index := 0 to Pred(f_Forms.Count) do
   begin
    Result := lp_FindInContainer(IvcmEntityForm(f_Forms.Items[l_Index]));
    if Result then
     Break;
   end;//for l_Index := 0 to Pred(f_Forms.Count) do
 end;//f_Forms <> nil   
end;//HasForm

procedure TvcmContainerForm.RestoreControlSize;
{* - восстанавливает размеры компонентов формы к первоначальным. }
begin
 (* Восстановим информацию в Design-Time *)
 f_Zones.RestoreControlSize;
 (* Прочитаем из настроек *)
 vcmLoadFormControls(Self);
end;

function TvcmContainerForm.DefineZone(aType : TvcmEffectiveZoneType; aControl : TComponent): TvcmZonesCollectionItem;
  {-}
begin
 Assert(aControl <> nil);
 with Zones do
 begin
  Result := FindZone(aControl);
  if (Result = nil) then
  begin
   Result := TvcmZonesCollectionItem(Add);
   with Result do
   begin
    ZoneType := aType;
    Control := aControl;
   end;//with TvcmZonesCollectionItem
  end;//Result = nil
 end;//with Zones
end;

procedure TvcmContainerForm.IvcmContainer_FormStyle(const aForm  : IvcmEntityForm;
                                                    const aStyle : IvcmFormStyle);
var
 l_Zone        : TvcmZonesCollectionItem;
 l_ZoneControl : TControl;
 l_Form        : IvcmEntityForm;
 l_Container   : IvcmContainer;
begin
 // Найдем компонент зоны, родитель компонента должен быть Self:
 l_ZoneControl := aForm.ZoneControl;
 // Найдем зону:
 if Assigned(l_ZoneControl) then
 begin
  l_Zone := Zones.FindZone(l_ZoneControl);
  if Assigned(l_Zone) then
   aStyle.Merge(l_Zone.FormStyle);
  l_Container := Container;
  try
   if not l_Container.IsNull and Supports(Self, IvcmEntityForm, l_Form) then
   try
    l_Container.FormStyle(l_Form, aStyle);
   finally
    l_Form := nil;
   end;{try..finally}
  finally
   l_Container := nil;
  end;{try..finally}
 end;//if Assigned(l_ZoneControl) then
end;//FormStyle

function TvcmContainerForm.IsNull: Boolean;
  {-}
begin
 Result := (f_Form = nil);
end;

procedure TvcmContainerForm.InitZones;

 procedure lp_DefineContainer(const aStyle: TvcmToolbarStyle);
 var
  l_Form: IvcmEntityForm;
 begin
  if (aStyle.MergeWithContainer = vcm_bTrue) and
    Supports(Self, IvcmEntityForm, l_Form) then
  try
   aStyle.Container := l_Form;
  finally
   l_Form := nil;
  end;{try..finally}
 end;//lp_DefineContainer

var
 l_Index: Integer;
begin
 for l_Index := 0 to Pred(Zones.Count) do
  with Zones.Items[l_Index].FormStyle.Toolbars do
  begin
   lp_DefineContainer(Left);
   lp_DefineContainer(Top);
   lp_DefineContainer(Right);
   lp_DefineContainer(Bottom);
  end;//with Zones.Items[l_Index].FormStyle do
end;//InitZones

procedure TvcmContainerForm.pm_SetZones(aValue: TvcmZonesCollection);
  {-}
begin
 f_Zones.Assign(aValue);
end;//pm_SetZones

function TvcmContainerForm.ZonesStored: Boolean;
  {-}
begin
 Result := (f_Zones <> nil) AND (f_Zones.Count > 0);
end;

function TvcmContainerForm.Get_MainCaption: IvcmCString;
  //override;
  {-}
(*const
 cZoneType = _vcm_ztParent;*)
var
 l_Form : IvcmEntityForm;
begin
 Result := inherited Get_MainCaption;
 if {(ZoneType = cZoneType)}
    IsMainObjectForm AND not vcmIsNil(Result) then
  Exit;
 //if HasForm(fm_Any, cZoneType, false, @l_Form) then
 if HasForm(fm_Any, vcm_ztMainObjectForm, false, @l_Form) then
  Result := l_Form.MainCaption;
end;

procedure TvcmContainerForm.ChildDataSourceChanged(const aChild : IvcmEntityForm;
                                                   const anOld  : IvcmFormDataSource;
                                                   const aNew   : IvcmFormDataSource);
  {* - вызывается при изменении источника данных вложенной формы. }
begin
 // Источник данных у формы измененился, возможно нужно обновить закладки
 DoNeedUpdateTab(aChild);
 // Передаем контейнеру вверх
 Container.ChildDataSourceChanged(aChild, anOld, aNew);
end;

function TvcmContainerForm.Get_AsForm: IvcmEntityForm;
begin
 Result := Self.As_IvcmEntityForm;
end;

class function TvcmContainerForm.FormImplementationClass: TClass;
  //override;
  {-}
begin
 Result := TvcmContainerFormImplementation;
end;

function TvcmContainerForm.NeedSetFocusToMainObjectFormOnRefresh: Boolean;
  {* Надо ли передвигать фокус в главную форму при изменении сборки }
begin
 Result := GetNeedSetFocusToMainObjectFormOnRefresh;
end;

function TvcmContainerForm.GetNeedSetFocusToMainObjectFormOnRefresh: Boolean;
  {* Надо ли передвигать фокус в главную форму при изменении сборки }
var
 l_Container: IvcmContainer;
begin
 l_Container := GetInnerContainer;
 Result := Assigned(l_Container) and l_Container.NeedSetFocusToMainObjectFormOnRefresh;
end;

procedure TvcmContainerForm.SetTabCaption(const aTabCaption: IvcmCString);
begin
 if (not Container.IsNull) then
  Container.SetTabCaption(aTabCaption);
end;

procedure TvcmContainerForm.InitFromPrevContainer(const aPrevContainer: IvcmContainer;
 aForClone: Boolean);
begin
 Assert(aPrevContainer <> nil);
 if (not aPrevContainer.IsNull) and
    (aPrevContainer.AsForm.VCLWinControl <> Self) then
  DoInitFromPrevContainer(aPrevContainer, aForClone);
end;

procedure TvcmContainerForm.DoInitFromPrevContainer(const aPrevContainer: IvcmContainer; aForClone: Boolean);
begin
 // Ничего не делаем
end;

procedure TvcmContainerForm.CheckFormSetAndAggregateList;

 procedure lp_CheckForm(const aForm: IvcmEntityForm);
 var
  l_FormSet: IvcmFormSet;
  l_Aggregate: IvcmAggregate;
 begin
  l_FormSet := nil;
  l_Aggregate := nil;

  f_FormSets.Clear;
  f_Aggregates.Clear;

  Supports(aForm.Aggregate, IvcmFormSet, l_FormSet);
  if (l_FormSet = nil) then
   l_FormSet := aForm.FormSet;

  if (l_FormSet = nil) then
  begin
   l_Aggregate := aForm.Aggregate;
   if (f_Aggregates.IndexOf(l_Aggregate) = -1) then
    f_Aggregates.Add(l_Aggregate);
  end
  else
  begin
   if (f_FormSets.IndexOf(l_FormSet) = -1) then
    f_FormSets.Add(l_FormSet);
  end; 
 end;

var
 l_Iter: IvcmEntityFormIterator;
 l_Form: IvcmEntityForm;
begin
 if Tl3TabbedContainersDispatcher.Instance.NeedUseTabs then
 begin
  l_Iter := pm_GetEntityFormIterator;
  l_Form := l_Iter.Next;
  while (l_Form <> nil) do
  begin
   lp_CheckForm(l_Form);
   l_Form := l_Iter.Next;
  end;
 end;
end;

function TvcmContainerForm.GetInnerContainer: IvcmContainer;
var
 l_Container: IvcmContainer;
 l_CurrEntityForm: IvcmEntityForm;
begin
 if HasForm(fm_Any, vcm_ztForFocus, False, @l_CurrEntityForm) then
 try
  Supports(l_CurrEntityForm, IvcmContainer, Result);
 finally
  l_CurrEntityForm := nil;
 end else
  Result := nil;
end;

procedure TvcmContainerForm.SetFocusToMainObjectForm;
 function lp_IsFocusInsideTheControl(aControl: TWinControl): Boolean;
 var
  l_C: TWinControl;
 begin
  l_C := FindControl(GetFocus);
  while Assigned(l_C) do
  begin
   if l_C = aControl then
   begin
    Result := True;
    Exit;
   end;
   l_C := l_C.Parent;
  end;
  Result := False;
 end;

var
 l_Container: IvcmContainer;
 l_CurrEntityForm: IvcmEntityForm;
 l_InnerEntityForm: IvcmEntityForm;
 l_F: TWinControl;
begin
 if HasForm(fm_Any, vcm_ztForFocus, False, @l_CurrEntityForm) then
 try
  while Supports(l_CurrEntityForm, IvcmContainer, l_Container) do
  try
   if l_Container.HasForm(fm_Any, vcm_ztForFocus, False, @l_InnerEntityForm) then
   try
    l_CurrEntityForm := l_InnerEntityForm;
   finally
    l_InnerEntityForm := nil;
   end//try..finally
   else
    Break;
  finally
   l_Container := nil;
  end;//try..finally
  l_F := l_CurrEntityForm.VCLWinControl;
  if not lp_IsFocusInsideTheControl(l_F) then {если фокус на контроле внутри формы, то не надо его переставлять}
   if (l_F is TForm) and
      (TForm(l_F).ActiveControl <> nil) and
      TForm(l_F).ActiveControl.CanFocus then
    TForm(l_F).ActiveControl.SetFocus
   else
   if l_F.CanFocus then
    l_F.SetFocus;
 finally
  l_CurrEntityForm := nil;
 end;//try..finally
end;

procedure TvcmContainerForm.Loaded;
var
 l_ZC : Integer;
begin
 Assert(Zones <> nil);
 l_ZC := Zones.Count;
 InitZones;
 inherited;
 if (l_ZC <> Zones.Count) then
 // - зоны добавились в результате MakeControls
  InitZones;
end;//Loaded

{ TvcmEntityFormIterator }

procedure TvcmEntityFormIterator.Cleanup;
begin
 f_Forms := nil;
 inherited;
end;//Cleanup

constructor TvcmEntityFormIterator.Create(const aForms: TvcmInterfacePtrList);
begin
 inherited Create;
 f_Forms := aForms;
 f_Current := 0;
end;//Create

class function TvcmEntityFormIterator.Make(
  const aForms: TvcmInterfacePtrList): IvcmEntityFormIterator;
var
 l_Class: TvcmEntityFormIterator;
begin
 l_Class := Create(aForms);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;//Make

function TvcmEntityFormIterator.Next: IvcmEntityForm;
begin
 if (f_Forms = nil) then
  Result := nil
 else
 if f_Current < f_Forms.Count then
 begin
  Result := IvcmEntityForm(f_Forms.Items[f_Current]);
  Inc(f_Current);
 end//if f_Current < f_Forms.Count then
 else
  Result := nil;
end;//Next

function TvcmAggregateIterator.Next: IvcmAggregate;
begin
 if f_Current < f_List.Count then
 begin
  Result := f_List.Items[f_Current];
  Inc(f_Current);
 end
 else
  Result := nil;
end;

procedure TvcmAggregateIterator.CleanUp;
begin
 inherited;
end;

constructor TvcmAggregateIterator.Create(aList: TvcmAggregateRefList);
begin
 inherited Create;
 f_List := aList;
end;

class function TvcmAggregateIterator.Make(aList: TvcmAggregateRefList): IvcmAggregateIterator;
var
 l_Class: TvcmAggregateIterator;
begin
 l_Class := Create(aList);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;
end;

function TvcmFormSetIterator.Next: IvcmFormSet;
begin
 if f_Current < f_List.Count then
 begin
  Result := f_List.Items[f_Current];
  Inc(f_Current);
 end
 else
  Result := nil;
end;

procedure TvcmFormSetIterator.CleanUp;
begin
 inherited;
end;

constructor TvcmFormSetIterator.Create(aList: TvcmFormSetRefList);
begin
 inherited Create;
 f_List := aList;
end;

class function TvcmFormSetIterator.Make(aList: TvcmFormSetRefList): IvcmFormSetIterator;
var
 l_Class: TvcmFormSetIterator;
begin
 l_Class := Create(aList);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;
end;

function TvcmContainerFormImplementation.Get_AsContainer : IvcmContainer;
  //override;
  {-}
begin
 Result := TvcmContainerForm(Control)
end;

function TvcmContainerForm.AcceptForm(const aForm: IvcmEntityForm;
 aControl: TComponent): Boolean;
 //virtual;
 {* - разрешает или запрещает придочивать форму руками. }
begin
 //http://mdp.garant.ru/pages/viewpage.action?pageId=370384532
 Result := True;
end;


end.

