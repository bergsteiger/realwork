unit nsOpenUtils;

// $Id: nsOpenUtils.pas,v 1.68 2016/04/12 14:42:30 kostitsin Exp $

// $Log: nsOpenUtils.pas,v $
// Revision 1.68  2016/04/12 14:42:30  kostitsin
// {requestlink: 620672440 } - Поддержка букмарков в новостях ОМ
//
// Revision 1.67  2016/03/17 09:09:58  kostitsin
// {requestlink: 619725742 }
//
// Revision 1.66  2015/10/01 12:32:31  kostitsin
// {requestlink: 608609025 }
//
// Revision 1.65  2015/07/30 10:11:21  kostitsin
// {requestlink: 604032841 } - вынес логирование в отдельный пакет из помойки "data"
//
// Revision 1.64  2015/06/08 14:07:17  kostitsin
// {requestlink: 516542110 }
//
// Revision 1.63  2015/06/03 13:53:51  kostitsin
// {requestlink: 516542110 }
//
// Revision 1.62  2015/03/10 16:11:45  lulin
// - перетряхиваем слова.
//
// Revision 1.61  2015/03/10 09:26:06  kostitsin
// {requestlink: 588808889 }
//
// Revision 1.60  2014/10/09 09:47:10  morozov
// {RequestLink: 566792807}
//
// Revision 1.59  2014/10/07 08:28:52  morozov
// {RequestLink: 566113866}
//
// Revision 1.58  2014/10/07 06:15:43  morozov
// {RequestLink: 566113866}
//
// Revision 1.57  2014/07/28 11:00:40  morozov
// В режиме -notabs документы из списка открывались в новом окне
//
// Revision 1.56  2014/07/24 10:26:26  morozov
// {RequestLink: 340174500}
//
// Revision 1.55  2014/07/11 06:42:31  morozov
// {RequestLink: 340174500}
//
// Revision 1.54  2014/06/30 05:26:35  morozov
// {RequestLink: 340174500}
//
// Revision 1.53  2014/06/26 10:03:25  morozov
// {RequestLink: 340174500}
//
// Revision 1.52  2014/06/25 10:14:22  morozov
// {RequestLink: 340174500}
//
// Revision 1.51  2014/06/24 06:09:07  morozov
// {RequestLink: 340174500}
//
// Revision 1.50  2014/02/19 13:01:24  kostitsin
// {requestlink: 368378315 } - OpenQuery( xxx )
//
// Revision 1.49  2013/09/16 07:09:27  kostitsin
// [$239370589]
//
// Revision 1.48  2013/06/24 10:23:55  morozov
// {RequestLink:462553651}
//
// Revision 1.47  2013/06/21 13:41:44  morozov
// {RequestLink:461708253}
//
// Revision 1.46  2013/04/24 09:35:55  lulin
// - портируем.
//
// Revision 1.45  2013/04/04 07:11:51  morozov
// {RequestLink:435455869}
//
// Revision 1.44  2013/04/01 09:29:23  lulin
// [$446432945]
//
// Revision 1.43  2013/03/29 06:57:22  morozov
// {RequestLink:435455869} ликвидация copy&paste
//
// Revision 1.42  2013/03/19 07:02:21  morozov
// {RequestLink:435455869}
//
// Revision 1.41  2013/02/21 07:27:02  morozov
// - change: производим поск с коррекцией слов (K:430743656).
//
// Revision 1.40  2012/10/01 07:40:42  kostitsin
// [$397291566]
//
// Revision 1.39  2012/04/09 08:38:36  lulin
// {RequestLink:237994598}
// - думаем о VGScene.
//
// Revision 1.38  2012/03/22 14:15:03  lulin
// - в ОМ обрабатываем ссылки на скрипты.
//
// Revision 1.37  2011/11/25 14:18:43  gensnet
// http://mdp.garant.ru/pages/viewpage.action?pageId=294597372
//
// Revision 1.36  2011/09/22 11:46:29  lulin
// {RequestLink:286625857}.
//
// Revision 1.35  2011/09/16 18:14:59  lulin
// {RequestLink:278824896}.
//
// Revision 1.34  2011/09/16 16:01:55  lulin
// {RequestLink:278824896}.
//
// Revision 1.33  2011/09/16 11:03:29  lulin
// {RequestLink:278824896}.
//
// Revision 1.32  2011/06/27 13:54:04  lulin
// {RequestLink:254944102}.
//
// Revision 1.31  2011/06/23 15:30:00  lulin
// {RequestLink:254944102}.
//
// Revision 1.30  2011/01/24 13:02:52  demon
// - Интеграция: переделан способ получения информации об отсутствии документа (с использованием метода GetSelfMissingInfo)
//
// Revision 1.29  2011/01/24 06:41:01  demon
// - Интеграция: при переходе на отсутствующий документ открываем в фоне ОМ до сообщения об отсутствии
// (Запрос: http://mdp.garant.ru/pages/viewpage.action?pageId=251337033)
//
// Revision 1.28  2011/01/19 11:39:06  demon
// - при обработке ссылки из интеграции дополнительно проверяем наличие документа в базе
//
// Revision 1.27  2010/12/22 18:24:19  lulin
// {RequestLink:242845936}.
//
// Revision 1.26  2010/11/22 13:39:08  lulin
// [$242845500].
//
// Revision 1.25  2010/10/25 09:55:03  lulin
// {RequestLink:237502802}.
// Шаг №3.
//
// Revision 1.24  2010/10/13 08:20:56  oman
// - new: нотификация {RequestLink:235057812}
//
// Revision 1.23  2010/10/12 13:00:52  oman
// - new: deFilter {RequestLink:235057812}
//
// Revision 1.22  2010/06/22 11:46:22  oman
// - fix: {RequestLink:219122439}
//
// Revision 1.21  2010/03/22 15:44:17  lulin
// {RequestLink:198672893}.
// - упрощаем сигнатуры фабрик.
//
// Revision 1.20  2009/12/09 13:08:20  lulin
// {RequestLink:124453871}.
//
// Revision 1.19  2009/12/09 09:23:34  lulin
// - убиваем неиспользуемый класс.
//
// Revision 1.18  2009/12/08 14:39:01  lulin
// - переносим TdeFilter на модель.
//
// Revision 1.17  2009/12/07 19:06:13  lulin
// - удалил ненужный модуль.
//
// Revision 1.16  2009/11/24 09:33:08  oman
// - new: LE_OPEN_DOCUMENT_FROM_FOLDERS {RequestLink:121157219}
//
// Revision 1.15  2009/10/21 16:25:51  lulin
// - переносим на модель ноды оболочки.
//
// Revision 1.14  2009/10/16 13:27:06  oman
// - new: Переносим на модель {RequestLink:164596503}
//
// Revision 1.13  2009/10/15 09:23:41  oman
// - new: Чистим устаревшие методы доступа {RequestLink:122652464}
//
// Revision 1.12  2009/09/30 15:23:10  lulin
// - убираем ненужное приведение ко вполне понятным интерфейсам.
//
// Revision 1.11  2009/09/28 19:36:27  lulin
// - убираем из StdRes константы для операций модулей.
//
// Revision 1.10  2009/09/28 19:14:22  lulin
// - вычищаем ненужные возвращаемые параметры.
//
// Revision 1.9  2009/09/28 18:50:55  lulin
// - убираем лишние ручки для вызова операций.
//
// Revision 1.8  2009/09/28 16:16:01  lulin
// - вызов диалога сохранения объекта в папки переведён на фабрику.
//
// Revision 1.7  2009/09/23 10:42:27  lulin
// {RequestLink:164593943}.
//
// Revision 1.6  2009/09/22 17:39:57  lulin
// - модуль Поиск полностью перенесён на модель.
//
// Revision 1.5  2009/09/22 14:49:21  lulin
// - переносим модуль поиска на модель.
//
// Revision 1.4  2009/09/21 17:31:15  lulin
// - избавляемся от внутренних методов модуля, связанных с базовым поиском.
//
// Revision 1.3  2009/09/21 12:46:28  lulin
// - новостную ленту открываем через фабрику.
//
// Revision 1.2  2009/09/18 12:21:35  lulin
// - невоплощённое убиваем, ошмётки переносим на модель.
//
// Revision 1.1  2009/09/14 11:28:53  lulin
// - выводим пути и для незавершённых модулей.
//
// Revision 1.86  2009/09/09 09:39:20  lulin
// - используем фабрику рубрикатора.
//
// Revision 1.85  2009/09/07 17:54:09  lulin
// - переводим консультации на фабрики.
//
// Revision 1.84  2009/09/07 12:26:45  lulin
// - сделана фабрика для открытия списков.
//
// Revision 1.83  2009/09/04 17:08:17  lulin
// {RequestLink:128288497}.
//
// Revision 1.82  2009/09/03 18:48:56  lulin
// - реструктуризируем поиски и удаляем ненужное.
//
// Revision 1.81  2009/08/26 08:15:06  lulin
// - декорируем имена операций, чтобы можно было искать.
// - bug fix: не собирались мониторинги.
//
// Revision 1.80  2009/08/24 08:36:35  lulin
// - переносим системные операции на модель.
//
// Revision 1.79  2009/08/19 11:07:18  oman
// - new: Зачистка - {RequestLink:159355458}
//
// Revision 1.78  2009/08/19 08:50:59  oman
// - new: Журнальные закладки - {RequestLink:159355458}
//
// Revision 1.77  2009/08/11 13:43:18  oman
// - new: Учимся открывать - {RequestLink:159355458}
//
// Revision 1.76  2009/08/04 11:25:31  lulin
// [$159351827].
//
// Revision 1.75  2009/06/03 10:43:13  oman
// - new: Готовим проекты к отпилу - [$148014435]
//
// Revision 1.74  2009/03/19 12:11:08  oman
// - fix: Не падаем при открытии отсутствующего термина ТС (К-139441542)
//
// Revision 1.73  2009/02/20 10:08:28  lulin
// - чистка комментариев.
//
// Revision 1.72  2009/02/12 15:08:03  lulin
// - <K>: 135604584. Выделен новый интерфейсный модуль.
//
// Revision 1.71  2008/12/10 16:46:12  lulin
// - <K>: 128297578.
//
// Revision 1.70  2008/12/08 09:32:33  lulin
// - <K>: 128292941.
//
// Revision 1.69  2008/11/19 11:17:24  lulin
// - <K>: 122674202.
//
// Revision 1.68  2008/11/14 10:34:41  lulin
// - <K>: 122675356.
//
// Revision 1.67  2008/10/10 09:00:31  oman
// - fix: Требуем уникальности имени (К-121146270)
//
// Revision 1.66  2008/06/16 11:18:44  mmorozov
// new: открытие списков из меню Инфарм (CQ: OIT5-29316);
//
// Revision 1.65  2008/05/27 12:04:13  mmorozov
// - new: регистрация операций открытия препарата и фирмы производителя.
//
// Revision 1.64  2008/04/14 12:20:19  mmorozov
// - работа с моими документами из списка;
//
// Revision 1.63  2008/04/04 13:40:41  oman
// - new: Документ-препарат - Открываемся из папок (cq28562)
//
// Revision 1.62  2008/03/26 08:29:22  oman
// - fix: Для открытия документов пользуем deDocInfo (cq28711)
//
// Revision 1.61  2008/03/13 08:19:55  oman
// - new: Инфарм - поддержка в правовом навинаторе
//
// Revision 1.60  2008/03/12 07:51:34  oman
// - new: Заготовки для поиска лекарственного препарата (ПЛП)
//
// Revision 1.59  2008/01/10 07:23:10  oman
// Переход на новый адаптер
//
// Revision 1.58  2007/12/18 07:10:38  oman
// - fix: При открытии запросе не открываем два раза Entity
//
// Revision 1.56.2.2  2007/12/11 09:31:52  mmorozov
// - MERGE WITH HEAD;
//
// Revision 1.56.2.1  2007/11/21 15:07:41  oman
// Перепиливаем на новый адаптер
//
// Revision 1.57  2007/12/10 12:50:42  mmorozov
// - new: реализуем шаблон publisher\subscriber при редактировании настроек, замены настроек (переключения конфигураций), настройке панелей инструментов (в рамках CQ: OIT5-27823);
//
// Revision 1.56  2007/10/20 14:11:12  mmorozov
// - Рефакторинг работы с консультациями ввел недостающее для нормальной работы состояние bs_csPaymentRefusalOldFormat;
// - Изжил интерфейс (и реализацию) IdeConsultation, по сути частично дублировала _IbsConsultation;
// - cleanup;
//
// Revision 1.55  2007/10/16 09:34:33  oman
// - fix: Насильно разрешаем обзор изменений законодательства для
//  внутренней версии (cq27081)
//
// Revision 1.54  2007/09/04 07:32:23  oman
// - fix: Историю контекста меняем при собственно поиске (cq26586)
//
// Revision 1.53  2007/08/10 05:57:54  oman
// - fix: Убеждаемся, что в адаптер передается действительно PAnsiChar
//  (cq25680)
//
// Revision 1.52  2007/07/18 13:27:18  mmorozov
// - new: регистрирация события открытие докумнета из последних открытых (в рамках CQ: OIT5-25852);
//
// Revision 1.51  2007/07/17 13:26:42  mmorozov
// - new: изменены интерфейсы логирования событий (в рамках CQ: OIT5-25852);
//
// Revision 1.50  2007/05/23 10:40:17  oman
// - new: Новый тип запросов "Базовый поиск" (cq25374)
//
// Revision 1.49  2007/05/16 07:19:55  oman
// - fix: При выполнении запроса для интеграции сначала грузим его
//  в карточку, а только потом  выполняем (cq25332)
//
// Revision 1.48  2007/05/14 06:33:09  oman
// - fix: При обработке ссылки-запроса - выполняем поиск и
//  показываем результат (cq25314)
//
// Revision 1.47  2007/05/02 13:33:56  oman
// - fix: При интеграции списка запрашивали поддержку ненужного интерфейса
//
// Revision 1.46  2007/04/23 07:14:10  oman
// - new: Вычищаем старую ППР и старые фильтры - настройки (cq25125)
//
// Revision 1.45  2007/04/17 09:29:47  mmorozov
// - new: определены параметры поиска элементов дерева навигатора;
//
// Revision 1.44  2007/04/16 08:08:59  oman
// - new: Поддержка нового исключения EOldFormatConsultation (cq24956)
//
// Revision 1.43  2007/03/19 11:35:21  lulin
// - разделяем приведение к строке для форматирования и для исключения.
//
// Revision 1.42  2007/03/16 16:56:55  lulin
// - избавляемся от излишнего копирования и преобразования строк.
//
// Revision 1.41  2007/02/27 10:32:33  lulin
// - cleanup.
//
// Revision 1.40  2007/02/14 16:58:07  lulin
// - избавляемся от использования стандартных строк.
//
// Revision 1.39  2007/02/12 12:32:05  mmorozov
// - bugfix: пустая карточка при редактировании фильтра (CQ: OIT5-23895);
//
// Revision 1.38  2007/02/08 15:31:45  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.37  2007/02/08 12:39:45  mmorozov
// - change: обобщена и упрощена логика по работе с элементами дерева навигатора (CQ: OIT5-23939);
//
// Revision 1.36  2007/02/07 17:48:27  lulin
// - избавляемся от копирования строк при чтении из настроек.
//
// Revision 1.35  2007/02/05 09:40:03  lulin
// - две функции объединены в одну.
//
// Revision 1.34  2007/02/02 08:38:49  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.33  2007/01/31 14:36:25  mmorozov
// - MERGE WITH B_NEMESIS_6_4;
//
// Revision 1.29.4.1  2007/01/31 14:10:58  mmorozov
// - new: регистрируем события открытия\сохранения документа из папок (CQ: OIT5-23963);
//
// Revision 1.32  2007/01/20 18:36:25  lulin
// - вычищаем ненужное создание параметров.
//
// Revision 1.31  2007/01/20 15:56:04  lulin
// - избавляемся от приведения типов.
//
// Revision 1.30  2007/01/15 16:02:25  lulin
// - кнопка "Поиск" переведена на использование операций, связанных со строками.
//
// Revision 1.29  2006/07/04 08:43:21  oman
// - new beh: Обработка ошибок при открытии инеграционных линков (cq21517)
//
// Revision 1.28  2006/06/30 14:14:36  oman
// - new beh: В первом приближении прикрутил обработку линков для
//  интеграции (cq21517)
//
// Revision 1.27  2006/05/05 09:37:17  dinishev
// Bug fix: на комплекте без Прайма нельзя было выполнить ни одного запроса
//
// Revision 1.26  2006/05/03 09:39:30  mmorozov
// - new: открытие консультации из папок;
//
// Revision 1.25  2006/04/28 04:50:17  dinishev
// Сообщения о недоступности запроса при отсутсвии блока "Прайм"
//
// Revision 1.24  2006/04/17 10:54:27  mmorozov
// - изменения связанные с повлением формы оценка консультации;
// - некоторые типы переименованны;
//
// Revision 1.23  2006/04/07 08:25:12  mmorozov
// - приведение к общему знаменателю Поиска с правовой поддержкой, Запроса на консультацию, Консультации;
//
// Revision 1.22  2006/03/31 07:41:52  lulin
// - изменен тип параметров, подаваемый в Execte операции.
//
// Revision 1.21  2006/03/22 11:12:32  dinishev
// Bug fix: не сохраненный открывался запрос из дерева
//
// Revision 1.20  2006/03/20 13:05:40  mmorozov
// - new behaviour: фильтры в моих документах и во вкладке фильтры редактируются одинаково (модальные формы);
//
// Revision 1.19  2006/03/17 13:51:25  oman
// - change: Избавляемся от %s в сообщениях, которые приездают не с адаптера
//
// Revision 1.18  2006/03/07 10:35:06  mmorozov
// - warnings fix;
//
// Revision 1.17  2005/10/03 17:34:15  demon
// - new behavior: перевели реализацию на IEntityBase
//
// Revision 1.16  2005/09/13 10:18:08  demon
// - new behavior: восстановлена работоспособность перехода по ссылке на другой документ
//
// Revision 1.15  2005/08/31 11:06:22  demon
// - new behavior: открытие новых списков из папок
//
// Revision 1.14  2005/08/30 11:16:53  demon
// - new behavior: операция открытия докуента из папок стала передавать данные в новом формате.
//
// Revision 1.13  2005/08/29 16:10:26  demon
// - new behavior: Операция Open на ноде теперь возвращает IUnknown
//
// Revision 1.12  2005/08/22 15:36:30  mmorozov
// - add unit bsTypes;
//
// Revision 1.11  2005/04/07 15:17:27  mmorozov
// bugfix: открытие закладки;
//
// Revision 1.10  2005/04/07 14:38:27  cyberz
// new: procedure SafeOpenBookmark;
//
// Revision 1.9  2005/03/03 16:50:15  demon
// - new behavior: обработаны новые типы запросов
//
// Revision 1.8  2005/02/24 15:04:15  dinishev
// new: использование lgTypes.pas;
//
// Revision 1.7  2005/01/24 10:19:53  demon
// - new behavior: при открытии запроса типа "Фильтр 5.х" в конфигурации 6.х и снятом флаге "использовать как фильтр" - открываем КЗ ППР.
//
// Revision 1.6  2005/01/21 17:53:48  lulin
// - реализован метод lg._OpenQuery для Немезиса.
//
// Revision 1.5  2005/01/21 13:46:02  lulin
// - к пользовательским операциям модулей приписываем префикс user.
//
// Revision 1.4  2004/12/24 11:10:06  demon
// - new behavior: При клике на запрос в папках открывается КЗ, а не исполняется запрос
//
// Revision 1.3  2004/10/14 16:23:28  demon
// - new behavior: операции открытия елемента папок перенесены в nsOpenUtils
//
// Revision 1.2  2004/08/05 13:06:48  demon
// - cleanup: remove warnings and hints
//
// Revision 1.1  2004/07/14 16:04:28  demon
// - new _module: nsOpenUtils - операции для быстрого открытия документов, списков, запросов по _IBaseEntity
//

interface

// <no_string>

{$Include nsDefine.inc}

uses
  l3Interfaces,
  l3TreeInterfaces,

  vcmGUI,
  vcmInterfaces,

  bsTypes,

  eeInterfaces,

  BaseTreeSupportUnit,
  DocumentUnit,
  DynamicTreeUnit,
  MainMenuUnit
  ;

{$If not defined(Admin) AND not defined(Monitorings)}  
procedure OpenQuery(const aBaseEntity : IUnknown);
  {-}
{$IfEnd} //not Admin
{$If not defined(Admin) AND not defined(Monitorings)}
procedure OpenFolderElement(const aForm         : IvcmEntityForm;
                            const aNode         : Il3SimpleNode;
                            const aOpenKind     : TvcmMainFormOpenKind;
                            const aNeedSwitchTab: Boolean = True);
  {-}
procedure OpenJournalElement(const aForm       : IvcmEntityForm;
                             const aNode       : Il3SimpleNode;
                             const aOpenKind   : TvcmMainFormOpenKind;
                             const aNeedSwitchTab: Boolean = True); 
  {-}
{$IfEnd} //not Admin
{$If not defined(Admin) AND not defined(Monitorings)}
procedure OpenControllableElement(const aForm : IvcmEntityForm;
                                  const aNode : Il3SimpleNode;
                                  const aOpenKind   : TvcmMainFormOpenKind;
                                  const aNeedSwitchTab: Boolean = True); 
  {-}
{$IfEnd} //not Admin

procedure nsSayAdapterObjectMissing(const aSayer : IvcmUserInteraction;
                                    const aNode  : INode); overload;
  { вывоит сообщение о не найденом объекте в зависимости от типа ноды }
procedure nsSayAdapterObjectMissing(const aSayer : IvcmUserInteraction;
                                    const aNode  : INodeBase); overload;
  { вывоит сообщение о не найденом объекте в зависимости от типа ноды }
{$If not defined(Admin) AND not defined(Monitorings)}
function nsIntergationOpenLink(const aLink: PAnsiChar; const aMainForm: IvcmContainer): Boolean;
  {-}
{$IfEnd} //not Admin
{$If not Defined(Admin) AND not Defined(Monitorings)}
procedure nsOpenNavigatorItem(const aNode       : INodeBase;
                              const aContainer  : IvcmContainer;
                              const aRootToKeep : INodeBase;
                              const aMenuSectionItemToKeep: ISectionItem);
  overload;
  {* - открыть элемент правового навигатора. }
procedure nsOpenNavigatorItem(const aNode      : Il3SimpleNode;
                              const aContainer : IvcmContainer);
  overload;
  {* - открыть элемент правового навигатора. }
procedure nsOpenNavigatorItem(const aSectionItem : ISectionItem;
                              const aContainer : IvcmContainer);
  overload;
{$IfEnd}
{$If not Defined(Admin) AND not Defined(Monitorings)}
procedure nsOpenListFromNode(const      aNode : INodeBase;
                             const aContainer : IvcmContainer;
                                    aOpenFrom : TbsListOpenFrom);
{$IfEnd}
function nsOpenNewWindowParams(const aCont: IvcmContainer): IvcmContainer;
  {-}
function nsOpenNewWindowTabbed(const aCont: IvcmContainer;
 aOpenKind: TvcmMainFormOpenKind = vcm_okInNewWindow;
 aNeedSwitchTab: Boolean = True): IvcmContainer;
  {-}

implementation

uses
  SysUtils,

  l3Chars,
  l3String,
  l3Base,

  afwFacade,

  DataAdapter,

  vcmBase,
  vcmForm,
  vcmMainForm,
  {$If not Defined(Admin) AND not Defined(Monitorings) }
  vcmTabbedContainerFormDispatcher,
  {$IfEnd}
  bsUtils,
  {$If not (defined(Monitorings) or defined(Admin))}
  bsConsultation,
  LoggingUnit,
  nsLogEvent,
  deDocInfo,
  {$IfEnd not (defined(Monitorings) or defined(Admin))}

  StdRes,

  IOUnit,
  BaseTypesUnit,
  ConsultingUnit,
  DynamicDocListUnit,
  FiltersUnit,
  FoldersUnit,
  IntegrationProjectUnit,
  SearchUnit,
  UnderControlUnit,
  UserJournalUnit,

  nsConst,
  nsTypes,
  nsQueryUtils,
  nsUtils,
  nsNodes,
  nsStartupSupport,

  nsNewCachableNode,
  nsNewCachableNodeThatNeedKeepRoot,
  deFilter,

  bsTypesNew,

  vcmMessagesSupport,

  bsDocumentMissingMessage,
  bsHyperLinkProcessorPrim,

  ExternalObjectUnit,

  PrimBaseSearchInterfaces,

  vcmExternalInterfaces,

  nsQuery,
  afwInterfaces,
  vcmStringList,
  BaseSearchInterfaces,
  nsQueryInterfaces,
  LoggingWrapperInterfaces,
  l3SimpleObject,
  nsLogManager,
  nsLogEventData
  {$If not defined(Admin) AND not defined(Monitorings)}
  ,
  nsBaseSearcher
  {$IfEnd}
  {$If not defined(Admin)}
  ,
  nsContextHistory
  {$IfEnd}
  {$If not defined(Admin)}
  ,
  ContextHistoryInterfaces
  {$IfEnd}
  ;

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsOpenDocumentFromFoldersEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(const aDoc: IDocument; aPara: Longword);
 end;//TnsOpenDocumentFromFoldersEvent

{ TnsOpenDocumentFromFoldersEvent }

class procedure TnsOpenDocumentFromFoldersEvent.Log(const aDoc: IDocument; aPara: Longword);
var
 l_Data: InsLogEventData;
begin
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 l_Data.AddString(''); //пустые скобки для несуществующего саба/блока. http://mdp.garant.ru/pages/viewpage.action?pageId=516542110&focusedCommentId=600944909#comment-600944909
 l_Data.AddULong(aPara);
 GetLogger.AddEvent(LE_OPEN_DOCUMENT_FROM_FOLDERS, l_Data);
end;

procedure OpenQuery(const aBaseEntity : IUnknown);
  // overload;
  {-}
var
 l_Query : IQuery;
begin
 if Supports(aBaseEntity, IQuery, l_Query) then
  try
   case l_Query.GetType of
    QT_KEYWORD :
     TdmStdRes.OpenQuery(lg_qtKeyWord, l_Query, nil);
    //QT_OLD_ATTRIBUTE,
    QT_ATTRIBUTE :
     TdmStdRes.OpenQuery(lg_qtAttribute, l_Query, nil);
(*    QT_OLD_FILTER :
     TdmStdRes.OpenQuery(lg_qtAttribute, l_Query);*)
    QT_PUBLISHED_SOURCE :
     TdmStdRes.OpenQuery(lg_qtPublishedSource, l_Query, nil);
    QT_COMMENTS:
     nsSearch(aBaseEntity As IQuery);
    QT_REVIEW:
     if not defDataAdapter.LegislationReviewAvailable then
      vcmSay(err_QueryCannotBeExecuted)
     else
      TdmStdRes.OpenQuery(lg_qtLegislationReview, l_Query, nil);
    QT_CONSULT:
     Assert(false);
    QT_MAIL_LIST:
     Exit;
    QT_BASE_SEARCH:
     TdmStdRes.OpenQuery(lg_qtBaseSearch, l_Query, nil);
    QT_PHARM_SEARCH:
     TdmStdRes.OpenQuery(lg_qtInpharmSearch, l_Query, nil);
    else
     Assert(false); 
   end;//case l_Query.GetType
  finally
   l_Query := nil;
  end;//try..finally
end;
{$IfEnd} //not Admin

procedure nsSayAdapterObjectMissing(const aSayer : IvcmUserInteraction;
                                    const aNode  : INode);
var
 l_Text : Il3CString;
begin
 l_Text := nsGetCaption(aNode);
 case TFoldersItemType(aNode.GetObjectType) of
  FIT_LIST:
   aSayer.Say(inf_SavedListMissing, [l_Text]);
  FIT_QUERY:
//~~~!!!~~~
{   if (aNode.GetFlags and NF_FILTER = NF_FILTER) then
    aSayer.Say(inf_FilterMissing <<<<, [l_Text])
   else}
    aSayer.Say(inf_SavedQueryMissed, [l_Text]);
  FIT_BOOKMARK,
  FIT_PHARM_BOOKMARK:
   aSayer.Say(inf_BookmarkedDocumentMissing, [l_Text]);
 end;//case TFoldersItemType(aNode.GetObjectType)
end;

procedure nsSayAdapterObjectMissing(const aSayer : IvcmUserInteraction;
                                    const aNode  : INodeBase);
var
 l_Text : Il3CString;
begin
 l_Text := nsGetCaption(aNode);
 case TJournalObjectType(aNode.GetType) of
  JOT_QUERY:
   aSayer.Say(inf_SavedQueryMissed, [l_Text]);
  JOT_BOOKMARK:
   aSayer.Say(inf_BookmarkedDocumentMissing, [l_Text]);
 end;//case TFoldersItemType(aNode.GetObjectType)
end;

{$If not defined(Admin) AND not defined(Monitorings)}
procedure OpenFolderElement(const aForm       : IvcmEntityForm;
                            const aNode       : Il3SimpleNode;
                            const aOpenKind   : TvcmMainFormOpenKind;
                            const aNeedSwitchTab: Boolean = True);
var
 l_AdapterNode: INode;
 l_Cont: IvcmContainer;
 l_Query: IQuery;
 l_BaseEntity: IUnknown;
 l_Document: IDocument;
 l_Bookmark: IBookmark;
begin
 if Supports(aNode, INode, l_AdapterNode) then
 try
  try
   l_AdapterNode.Open(l_BaseEntity);
  except
   on ECanNotFindData do
   begin
    nsSayAdapterObjectMissing(aForm as IvcmUserInteraction, l_AdapterNode);
    Exit;
   end;//on ECanNotFindData do
  end;{try..except}
  try
   l_Cont := nsOpenNewWindowTabbed(aForm.NativeMainForm, aOpenKind, aNeedSwitchTab);
   case TFoldersItemType(l_AdapterNode.GetObjectType) of
     FIT_LIST, FIT_PHARM_LIST:
      nsOpenList(l_BaseEntity As IDynList, l_Cont);
     FIT_QUERY:
       { По просьбе директора открывается КЗ, а не сразу исполняется запрос }
        OpenQuery(l_BaseEntity);
     FIT_BOOKMARK:
     begin
      try
       l_Document := TdmStdres.OpenEntityAsDocument(l_BaseEntity, l_Cont);
       if (l_Document <> nil) and
          (l_Document.GetDocType in [DT_DOCUMENT,
                                     DT_ACTUAL_ANALYTICS,
                                     DT_ACTUAL_ANALYTICS_CONTENTS] ) then
       begin
        if not Supports(l_BaseEntity, IBookmark, l_Bookmark) then
         Assert(False);
        TnsOpenDocumentFromFoldersEvent.Log(l_Document, l_Bookmark.GetParagraph);
       end;
      except
       on ETryOpenMissingDocument do
       begin
        nsSayAdapterObjectMissing(aForm as IvcmUserInteraction, l_AdapterNode);
        Exit;
       end;//on ETryOpenMissingDocument do
      end;//try..except
     end;//FIT_BOOKMARK
     FIT_PHARM_BOOKMARK:
      TdmStdres.OpenEntityAsDocument(l_BaseEntity, l_Cont);
     FIT_CONSULTATION:
      {$If not (defined(Monitorings) or defined(Admin))}
      TdmStdRes.OpenEntityAsConsultation(l_BaseEntity, l_Cont);
      {$Else   Monitorings}
      Assert(false);
      {$IfEnd not (defined(Monitorings) or defined(Admin))}
     FIT_OLD_HISTORY:
      g_Dispatcher.ModuleOperation(TdmStdRes.mod_opcode_WorkJournal_OpenJournal);
   end;//case TFoldersItemType(l_AdapterNode.GetObjectType) of
  finally
   l_BaseEntity := nil;
  end;{try..finally}
 finally
  l_AdapterNode := nil;
 end;{try..finally}
end;

procedure OpenJournalElement(const aForm       : IvcmEntityForm;
                             const aNode       : Il3SimpleNode;
                             const aOpenKind   : TvcmMainFormOpenKind;
                             const aNeedSwitchTab: Boolean = True);
var
 l_AdapterNode: INodeBase;
 l_Cont: IvcmContainer;
 l_Query: IQuery;
 l_BaseEntity: IUnknown;
 l_Document: IDocument;
 l_JBookmark: IJournalBookmark;
begin
 if Supports(aNode, INodeBase, l_AdapterNode) then
 try
  try
   l_AdapterNode.GetEntity(l_BaseEntity);
  except
   on ECanNotFindData do
   begin
    nsSayAdapterObjectMissing(aForm as IvcmUserInteraction, l_AdapterNode);
    Exit;
   end;//on ECanNotFindData do
  end;{try..except}
  try
   l_Cont := nsOpenNewWindowTabbed(aForm.NativeMainForm, aOpenKind, aNeedSwitchTab);
   case TJournalObjectType(l_AdapterNode.GetType) of
     JOT_QUERY:
       { По просьбе директора открывается КЗ, а не сразу исполняется запрос}
          OpenQuery(l_BaseEntity);
     JOT_BOOKMARK:
     begin
      try
       l_Document := TdmStdres.OpenEntityAsDocument(l_BaseEntity, l_Cont);
       if (l_Document <> nil) and (l_Document.GetDocType = DT_DOCUMENT) then
       begin
        if not Supports(l_BaseEntity, IJournalBookmark, l_JBookmark) then
         Assert(False);
        TnsOpenDocumentFromFoldersEvent.Log(l_Document, l_JBookmark.GetParaId);
       end;
      except
       on ETryOpenMissingDocument do
       begin
        nsSayAdapterObjectMissing(aForm as IvcmUserInteraction, l_AdapterNode);
        Exit;
       end;//on ETryOpenMissingDocument do
      end;//try..except
     end;//JOT_BOOKMARK
   end;//case TJournalObjectType(l_AdapterNode.GetType) of
  finally
   l_BaseEntity := nil;
  end;{try..finally}
 finally
  l_AdapterNode := nil;
 end;{try..finally}
end;//OpenJournalElement

{$IfEnd} //not Admin

{$If not defined(Admin) AND not defined(Monitorings)}
procedure OpenControllableElement(const aForm : IvcmEntityForm;
                                  const aNode : Il3SimpleNode;
                                  const aOpenKind   : TvcmMainFormOpenKind;
                                  const aNeedSwitchTab: Boolean = True);
var
 l_Controllable : IControllable;
 l_BaseEntity   : IUnknown;
 l_Cont         : IvcmContainer;
begin
 if Supports(aNode, IControllable, l_Controllable) then
  try
   try
    l_Controllable.Open(l_BaseEntity);
   except
    on ECanNotFindData do
     begin
      case TControlledItemType(l_Controllable.GetType) of
       CIT_DOCUMENT : (aForm as IvcmUserInteraction).Say(inf_DocumentMissingInf, [l3CStr(aNode)]);
       CIT_LIST     : (aForm as IvcmUserInteraction).Say(inf_ListMissing, [l3CStr(aNode)]);
       CIT_QUERY    : (aForm as IvcmUserInteraction).Say(inf_QueryMissing, [l3CStr(aNode)]);
      end;
      Exit;
     end;
   end;
   try
    l_Cont := nsOpenNewWindowTabbed(aForm.NativeMainForm, aOpenKind, aNeedSwitchTab);
    case TControlledItemType(l_Controllable.GetType) of
     CIT_DOCUMENT:
      TdmStdres.OpenEntityAsDocument(l_BaseEntity, l_Cont);
     CIT_LIST:
      nsOpenList(l_BaseEntity As IDynList, l_Cont);
     CIT_QUERY:
      if (l_Cont = nil) then
       nsSearch(l_BaseEntity As IQuery, nil, nil, aForm.NativeMainForm)
      else
       nsSearch(l_BaseEntity As IQuery, nil, nil, l_Cont.NativeMainForm);
    end;//case TControlledItemType(l_Controllable.GetType)
   finally
    l_BaseEntity := nil;
   end;//try..finally
  finally
   l_Controllable := nil;
  end;//try..finally
end;

{$IfEnd} //not Admin

{$If not Defined(Admin) AND not Defined(Monitorings)}
procedure nsOpenNavigatorItem(const aNode      : Il3SimpleNode;
                              const aContainer : IvcmContainer);
  {* - открыть элемент правового навигатора. }
var
 l_Node : INodeBase;
 l_Item : ISectionItem;
begin
 if Supports(aNode, INodeBase, l_Node) then
 try
  nsOpenNavigatorItem(l_Node, aContainer, l_Node, nil);
 finally
  l_Node := nil;
 end//try..finally
 else
 if Supports(aNode, ISectionItem, l_Item) then
 try
  nsOpenNavigatorItem(l_Item, aContainer);
 finally
  l_Item := nil;
 end;//try..finally
end;//nsOpenNavigatorItem

procedure nsOpenNavigatorItem(const aSectionItem : ISectionItem;
                              const aContainer : IvcmContainer);
var
 l_Ent : IUnknown;
 l_Q : IQuery;
 l_D : IDocument;
 l_N : INodeBase;
 l_S : IString;
 l_L : IDynList;
 l_C : INodeBase;
 l_S1 : Il3CString;
 l_EL : IExternalLink;
 l_Proc : TbsHyperLinkProcessorPrim;
 l_Bookmark: IBookmark; 
begin
 // http://mdp.garant.ru/pages/viewpage.action?pageId=294597372
 try
  aSectionItem.Open(l_Ent);
 except
  on ENoEntity do
   exit;
 end;{try..except}

 Assert(l_Ent <> nil);
 try
  if Supports(l_Ent, IQuery, l_Q) then
   OpenQuery(l_Q)
  else
  if Supports(l_Ent, IDocument, l_D) then
   TdmStdres.OpenEntityAsDocument(l_D, aContainer)
  else
  if Supports(l_Ent, IString, l_S) then
  begin
   l_S1 := nsCStr(l_S);
   if l3Same('AT_NEWS_LINE', l_S1, true) then
    TdmStdRes.OpenNewsLine(False)
   else
   if l3Starts('AT_PUBLISH_SOURCE', l3PCharLen(l_S1), true) then
    TdmStdRes.OpenTaxesPublishSearch(l_S1)
   else
    Assert(false, 'Не доделано');
  end//Supports(l_Ent, IString, l_S)
  else
  if Supports(l_Ent, IDynList, l_L) then
   nsOpenList(l_L, aContainer, wdAlwaysOpen)
  else
  if Supports(l_Ent, INodeBase, l_N) then
  begin
   try
    if (l_N.GetChildCount = 1) then
    begin
     l_N.GetFirstChild(l_C);
     Assert(l_C <> nil);
     nsOpenNavigatorItem(l_C, aContainer, l_N, aSectionItem);
    end//l_N.GetChildCount = 1
    else
     nsOpenNavigatorItem(l_N, aContainer, l_N, aSectionItem);
   finally
    l_N := nil;
   end;//try..finally
  end//Supports(l_Ent, INodeBase, l_N)
  else
  if Supports(l_Ent, IExternalLink, l_EL) then
  begin
   l_Proc := TbsHyperLinkProcessorPrim.Create;
   try
    l_Proc.OpenURL(l_EL);
   finally
    FreeAndNil(l_Proc);
   end;//try..finally
  end//Supports(l_Ent, IExternalLink, l_E)
  else
  if Supports(l_Ent, IBookmark, l_Bookmark) then
   TdmStdRes.OpenEntityAsDocument(l_Ent, aContainer)
  else
   Assert(false);
 finally
  l_Ent := nil;
 end;//try..finally
end;
{$IfEnd}

{$If not Defined(Admin) AND not Defined(Monitorings)}
procedure nsOpenListFromNode(const      aNode : INodeBase;
                             const aContainer : IvcmContainer;
                                    aOpenFrom : TbsListOpenFrom);
var
 l_DynList    : IDynList;
 l_EntityBase : IEntityBase;
begin
 try
  aNode.GetEntity(l_EntityBase);
 except
  on ENoEntity do
  begin
   defDataAdapter.ShowMessageWithDealerInfo(war_EmtryListEntity);
   exit;
  end;
 end;{try..except}
 if Supports(l_EntityBase, IDynList, l_DynList) then
 try
  nsOpenList(l_DynList,
             aContainer,
             wdAlwaysOpen,
             True,
             aOpenFrom);
 finally
  l_DynList := nil;
 end;//if Supports(l_EntityBase, IDynList, l_DynList) then
end;//nsOpenListFromNode
{$IfEnd}

{$If not Defined(Admin) AND not Defined(Monitorings)}
procedure nsOpenNavigatorItem(const aNode      : INodeBase;
                              const aContainer : IvcmContainer;
                              const aRootToKeep : INodeBase;
                              const aMenuSectionItemToKeep: ISectionItem);
  overload;
  {* - открыть элемент правового навигатора. }

 procedure lp_OpenDocument;
 var
  l_Document   : IDocument;
  l_EntityBase : IEntityBase;
 begin
  try
   aNode.GetEntity(l_EntityBase);
  except
   on ENoEntity do
    exit;
  end;{try..except}
  if Supports(l_EntityBase, IDocument, l_Document) then
  try
   {$If not defined(Admin) AND not defined(Monitorings)}
   TdmStdRes.OpenDocument(TdeDocInfo.Make(l_Document), nil);
   {$Else}
   Assert(false);
   {$IfEnd}
  finally
   l_Document := nil;
  end;{try..finally}
 end;//lp_OpenDocument

 procedure lp_OpenRubricator;
 var
  l_RubrNode: INodeBase;
 begin
  aNode.GetUnfilteredNode(l_RubrNode);
  if (l_RubrNode <> nil) then
   TdmStdRes.OpenRubricator(TnsNewCachableNodeThatNeedKeepRoot.Make(l_RubrNode, aRootToKeep),
                            aRootToKeep,
                            aMenuSectionItemToKeep,
                            afw.Settings.LoadBoolean(pi_Sheets_MainMenu,
                                       dv_Sheets_MainMenu),
                            nil, nil);
 end;//lp_OpenRubricator

begin
 if aNode <> nil then
 begin
  case TNavigatorMenuItemType(aNode.GetType) of
   // Поиск по ситуации.
   NM_SITUATION_SEARCH:
    TdmStdRes.OpenQuery(lg_qtKeyWord, nil, nil);
   // Поиск по атрибутам.
   NM_ATTRIBUTE_SEARCH:
    TdmStdRes.OpenQuery(lg_qtAttribute, nil, nil);
   // Поиск по источнику опубликования.
   NM_PUBLISH_SOURCE_SEARCH:
    TdmStdRes.OpenQuery(lg_qtPublishedSource, nil, nil);
   NM_SEARCH_WITH_LAW_SUPPORT:
    Assert(false);
   NM_LAW_SUPPORT:
    TdmStdRes.OpenQuery(lg_qtSendConsultation, nil, nil);
   // Толковый словарь.
   NM_EXPLANATORY_DICTIONARY:
    g_Dispatcher.ModuleOperation(TdmStdRes.mod_opcode_Diction_OpenDict);
   NM_DOCUMENT:
    lp_OpenDocument;
   // Информация о комплекте
   NM_COMPLECT_INFO:
    g_Dispatcher.ModuleOperation(TdmStdRes.mod_opcode_Common_ComplectInfo);
   // Список конфигураций
   NM_CONFIGURATION_LIST:
    g_Dispatcher.ModuleOperation(TdmStdRes.mod_opcode_Settings_OpenConfList);
   // Обзор законодательства
   NM_REVIEW:
    TdmStdRes.OpenQuery(lg_qtLegislationReview, nil, nil);
   // Моя новостная лента
   NM_NEWS_LINE:
    TdmStdRes.OpenNewsLine(False);
   NM_PHARM_SEARCH:
    TdmStdRes.OpenQuery(lg_qtInpharmSearch, nil, nil);
   NM_PHARM_LEK:
    g_Dispatcher.ModuleOperation(TdmStdRes.mod_opcode_Inpharm_DrugList);
   NM_PHARM_FIRMS:
    g_Dispatcher.ModuleOperation(TdmStdRes.mod_opcode_Inpharm_MedicFirms);
   NM_PHARM_DICT:
    g_Dispatcher.ModuleOperation(TdmStdRes.mod_opcode_Inpharm_MedicDiction);
   else
    // Открываем рубрикатор:
    if aNode.HasChildren then
     lp_OpenRubricator
    // Если детей нет, значит это список, открываем список:
    else
     nsOpenListFromNode(aNode, aContainer, lofRubricator);
  end;//case TNavigatorMenuItemType(aNode.GetType) of
 end;//if Supports(aNode, INodeBase, aNode) then
end;//nsOpenNavigatorItem
{$IfEnd}

{$If not defined(Admin) AND not defined(Monitorings)}
function nsIntergationOpenLink(const aLink: PAnsiChar; const aMainForm: IvcmContainer): Boolean;
var
 l_Type: TIntegrationType;
 l_Obj: IUnknown;
 l_ListEntryInfo: IListEntryInfo;
 l_List: IDynList;
 l_Query: IQuery;
 l_Document: IDocument;
 l_MI: IMissingInfo;
 l_BaseSearcher: InsBaseSearcher;
 l_Processor: InsBaseSearchQueryDataProcessor;
 l_ContextProvider: InsBaseSearchContextProvider;
 l_QueryContext: Il3CString;
 l_CorrectedContext: Il3CString;
begin
 Result := False;
 l_Type := DefDataAdapter.Integration.GetObjectByXml(nsAStr(aLink), l_Obj);
 case l_Type of
  IT_LISTENTRYINFO:
   if Supports(l_Obj, IListEntryInfo, l_ListEntryInfo) then
   begin
    l_ListEntryInfo.GetDoc(l_Document);
    try
     if l_Document.IsAlive then
      TdmStdRes.OpenDocument(bsDocInfoMake(l_ListEntryInfo), aMainForm)
     else
     begin
      l_Document.GetSelfMissingInfo(l_MI);
      TdmStdRes.OpenMainMenuIfNeeded(aMainForm);
      TbsDocumentMissingMessage.Show(True, l_MI);
     end;//l_Document.IsAlive
    finally
     l_Document := nil;
    end;//try..finally
    Result := True;
   end;//Supports(l_Obj, IListEntryInfo, l_ListEntryInfo)
  IT_LIST:
   if Supports(l_Obj, IDynList, l_List) then
   begin
    nsOpenList(l_List, aMainForm);
    Result := True;
   end;//Supports(l_Obj, IDynList, l_List)
  IT_QUERY:
   if Supports(l_Obj, IQuery, l_Query) then
   begin
    TnsStartupSupport.Instance.TryActivateMainForm;
    if (l_Query.GetType = QT_BASE_SEARCH) then // K430743656, K435455869
    begin
     LoadContextNew(l_Query, nsCStr(AT_TEXT_BODY), l_QueryContext);
     l_BaseSearcher := TnsBaseSearcher.Make(aMainForm, nsGetContextHistory(ns_chkDocument));
     try
      if (Supports(l_BaseSearcher, InsBaseSearchQueryDataProcessor, l_Processor)) then
       l_Processor.SetDataFromQuery(l_Query);
      if (Supports(l_BaseSearcher, InsBaseSearchContextProvider, l_ContextProvider)) then
      begin
       l_ContextProvider.RepairMistakes;

       // http://mdp.garant.ru/pages/viewpage.action?pageId=461708253,
       // http://mdp.garant.ru/pages/viewpage.action?pageId=462553651
       if l3IsNil(l_ContextProvider.Context) then
        raise ETryToFindEmptyContext.Create('');

       l_CorrectedContext := l_ContextProvider.Context;
       if not l3Same(l_QueryContext, l_CorrectedContext) then
        SaveContextNew(l_Query, nsCStr(AT_TEXT_BODY), l_CorrectedContext, True);
      end;
     finally
      l_QueryContext := nil;
      l_CorrectedContext := nil;
      l_ContextProvider := nil;
      l_Processor := nil;
      l_BaseSearcher := nil;
     end;
    end;
    OpenQuery(l_Query);
    nsSearch(l_Query, nil, nil, aMainForm);
    Result := True;
   end;//Supports(l_Obj, IQuery, l_Query)
 end;//case l_Type
end;
{$IfEnd} //not Admin

function nsOpenNewWindowParams(const aCont: IvcmContainer): IvcmContainer;
  {-}
begin
 Result := (aCont.AsForm.VCLWinControl As TvcmMainForm).MakeClone;
end;

function nsOpenNewWindowTabbed(const aCont: IvcmContainer;
 aOpenKind: TvcmMainFormOpenKind = vcm_okInNewWindow;
 aNeedSwitchTab: Boolean = True): IvcmContainer;
var
 l_Cont: IvcmContainer;
 l_ContainerMaker: IvcmContainerMaker;
begin
 {$If not Defined(Admin) AND not Defined(Monitorings)}
 Assert(aCont <> nil);
 if TvcmTabbedContainerFormDispatcher.Instance.NeedUseTabs then
 begin
  if Supports(aCont, IvcmContainerMaker, l_ContainerMaker) then
   try
    Result := TvcmTabbedContainerFormDispatcher.Instance.MakeAndPlaceVCMContainer(l_ContainerMaker,
     aCont, aOpenKind, aNeedSwitchTab);
   finally
    l_ContainerMaker := nil;
   end
  else
   Assert(False);
 end
 else
 begin
  if (aOpenKind in [vcm_okInNewWindow, vcm_okInNewTab]) then
   Result := nsOpenNewWindowParams(aCont)
  else
   Result := aCont;
 end;
 {$Else}
 Result := nsOpenNewWindowParams(aCont);
 {$IfEnd}//not Defined(Admin)
end;



end.
