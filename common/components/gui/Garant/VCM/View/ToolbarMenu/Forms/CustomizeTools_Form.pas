unit CustomizeTools_Form;

{ Библиотека "vcm"        }
{ Модуль: vcmCustomizeTools - }
{ Начат: 23.07.2003 21:04 }
{ $Id: CustomizeTools_Form.pas,v 1.33 2016/05/25 11:44:16 lulin Exp $ }

// $Log: CustomizeTools_Form.pas,v $
// Revision 1.33  2016/05/25 11:44:16  lulin
// - перегенерация.
//
// Revision 1.32  2015/07/09 09:54:17  kostitsin
// чтобы не мешалось.
//
// Revision 1.31  2015/07/09 09:48:59  kostitsin
// {requestlink: 127042272 } - грохнул ещё пачку _TvcmInterfaceList.
//
// Revision 1.30  2015/04/23 10:10:48  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=596627087&focusedCommentId=597929314#comment-597929314
//
// Revision 1.29  2015/04/13 14:11:32  lulin
// {RequestLink:595447330}
//
// Revision 1.28  2015/04/13 13:52:35  lulin
// {RequestLink:595447330}
//
// Revision 1.27  2015/04/13 13:04:42  lulin
// {RequestLink:595447330}
//
// Revision 1.26  2015/03/16 15:04:38  lulin
// - делаем стереотипы Service и ServiceImplementation.
//
// Revision 1.25  2014/08/19 11:47:58  kostitsin
// {requestlink: 562594400 }
//
// Revision 1.24  2014/08/19 11:27:38  kostitsin
// {requestlink: 562594400 }
//
// Revision 1.23  2013/12/13 17:10:06  kostitsin
// [$508169367]
//
// Revision 1.22  2013/08/08 14:37:12  morozov
// {RequestLink:476079389}
//
// Revision 1.21  2013/08/07 08:46:45  morozov
// {RequestLink:353438994}
//
// Revision 1.20  2013/08/05 12:21:57  morozov
// {RequestLink:471774446}
//
// Revision 1.19  2013/07/26 10:32:28  morozov
// {RequestLink: 471774401}
//
// Revision 1.18  2013/07/16 11:23:25  morozov
// {RequestLink:460277543}
//
// Revision 1.17  2013/05/29 16:13:15  lulin
// - портируем под XE4.
//
// Revision 1.16  2013/05/06 07:33:25  morozov
// {RequestLink:452380433}
//
// Revision 1.15  2013/04/29 12:24:45  morozov
// {RequestLink:452380433}
//
// Revision 1.14  2013/04/25 13:20:26  morozov
// {$RequestLink:363571639}
//
// Revision 1.13  2012/11/23 08:23:23  kostitsin
// чиню сборку
//
// Revision 1.12  2012/07/17 11:12:05  lulin
// {RequestLink:378541134}
//
// Revision 1.11  2012/07/11 18:24:46  lulin
// {RequestLink:237994598}
//
// Revision 1.10  2012/06/30 10:21:23  kostitsin
// [$371645804]
//
// Revision 1.9  2012/04/09 08:38:45  lulin
// {RequestLink:237994598}
// - думаем о VGScene.
//
// Revision 1.8  2012/04/04 08:56:53  lulin
// {RequestLink:237994598}
//
// Revision 1.7  2012/03/23 13:03:40  lulin
// - отпиливаем настройки.
//
// Revision 1.6  2012/03/22 06:40:03  lulin
// - чистим код от мусора.
//
// Revision 1.5  2011/06/28 19:18:20  lulin
// {RequestLink:254944102}.
//
// Revision 1.4  2011/06/28 17:52:28  lulin
// {RequestLink:254944102}.
//
// Revision 1.3  2011/06/23 17:01:29  lulin
// {RequestLink:254944102}.
//
// Revision 1.2  2011/05/19 12:20:08  lulin
// {RequestLink:266409354}.
//
// Revision 1.1  2010/09/13 16:00:47  lulin
// {RequestLink:235047275}.
//
// Revision 1.185  2010/03/11 15:13:41  lulin
// {RequestLink:196969151}.
// - избавляемся от ненужных зависимостей от VCM.
//
// Revision 1.184  2010/03/10 12:48:45  lulin
// {RequestLink:193826739}.
//
// Revision 1.183  2010/03/09 11:56:31  lulin
// {RequestLink:93261298}.
//
// Revision 1.182  2010/03/03 18:11:28  lulin
// {RequestLink:193826739}.
//
// Revision 1.181  2010/03/03 18:01:20  lulin
// {RequestLink:193826739}.
//
// Revision 1.180  2010/03/03 17:49:26  lulin
// {RequestLink:193826739}.
//
// Revision 1.179  2009/09/16 18:06:43  lulin
// {RequestLink:163061744}.
//
// Revision 1.178  2009/08/20 17:19:06  lulin
// {RequestLink:159360595}.
//
// Revision 1.177  2009/08/03 18:26:07  lulin
// - убираем заточки на предмет наличия иконок. Пусть УМ настраивает доступные.
//
// Revision 1.176  2009/06/25 12:57:40  lulin
// - вычищаем ненужный контекст.
//
// Revision 1.175  2009/02/20 15:19:08  lulin
// - <K>: 136941122.
//
// Revision 1.174  2009/02/12 17:09:18  lulin
// - <K>: 135604584. Выделен модуль с внутренними константами.
//
// Revision 1.173  2009/02/12 16:06:51  lulin
// - <K>: 135604584. Выделен модуль локализации.
//
// Revision 1.172  2009/02/12 12:26:42  lulin
// - <K>: 135604584. Выделен новый интерфейсный модуль.
//
// Revision 1.171  2008/10/13 12:41:04  oman
// - fix: Неправильно искали UserType (К-121148099)
//
// Revision 1.170  2008/09/03 09:59:30  mmorozov
// - new behaviour: в списке "быстрый вызов" показываем все визуальные операции формы, не читаем из настроек (<K> - 113180843);
//
// Revision 1.169  2008/07/31 09:36:07  oman
// - new: Разрешаем кнопку ок (K-96481354)
//
// Revision 1.168  2008/06/25 11:23:44  mmorozov
// - new: Оптимизация панелей инструментов ... Список форм при настройке доступных операций  (CQ: OIT5-28281);
//
// Revision 1.167  2008/06/25 09:24:06  mmorozov
// - new: Оптимизация панелей инструментов ---|> в списке доступных форм показываем только объединенные панели инструментов + рефакторинг + список форм проекта при редактировании доступных для выбора операций (CQ: OIT5-28281);
//
// Revision 1.166  2008/06/05 13:05:19  mmorozov
// Оптимизация панелей инструментов (CQ: OIT5-28281):
// - одинаковая настройка для объединенных панелей инструментов.
// - доступность операций в контекстном меню панели инструментов.
// - идентфикатор для формы включает не только имя типа но и имя формы.
//
// Revision 1.165  2008/06/04 10:51:15  mmorozov
// - new: возможность найстройки доступных для редактирования панели инструментов операций (CQ: OIT5-28281);
//
// Revision 1.164  2008/05/29 12:28:58  mmorozov
// - format code.
//
// Revision 1.163  2008/05/29 12:26:56  mmorozov
// - new: возможность определить от какого типа использовать панель инструментов (CQ: OIT5-28281).
//
// Revision 1.162  2008/03/24 15:46:15  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=87591840&focusedCommentId=87592645#comment-87592645
//
// Revision 1.161  2008/03/03 20:05:55  lulin
// - <K>: 85721135.
//
// Revision 1.160  2007/12/25 23:55:53  lulin
// - модуль l3Tree_TLB полностью перенесен на модель.
//
// Revision 1.159  2007/10/15 11:28:16  lulin
// - вычищено устаревшее свойство.
//
// Revision 1.158  2007/04/12 07:57:11  lulin
// - используем строки с кодировкой.
//
// Revision 1.157  2007/04/10 13:20:11  lulin
// - используем строки с кодировкой.
//
// Revision 1.156  2007/04/05 07:59:24  lulin
// - избавляемся от лишних преобразований строк при записи в настройки.
//
// Revision 1.155  2007/02/28 14:17:48  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.154  2007/02/12 16:40:31  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.153  2007/01/18 11:47:41  oman
// - new: Локализация библиотек - vcm (cq24078)
//
// Revision 1.152  2007/01/12 13:14:39  oman
// - fix: Вернул vcm_otMenuButtonCombo - разъехалось меню (cq24113)
//
// Revision 1.151  2007/01/05 14:14:53  lulin
// - убран лишний тип операции - ибо нечего типом задавать место расположения контрола.
//
// Revision 1.150  2007/01/05 13:53:16  lulin
// - убран лишний тип операции - ибо нечего типом задавать место расположения контрола.
//
// Revision 1.149  2007/01/05 13:33:00  lulin
// - cleanup.
//
// Revision 1.148  2006/12/29 13:58:00  lulin
// - используем собственную реализацию списка строк.
//
// Revision 1.147  2006/12/22 15:06:38  lulin
// - текст ноды - теперь структура с длиной и кодовой страницей.
//
// Revision 1.146  2006/12/20 09:47:24  lulin
// - bug fix: нельзя было начать DnD в "простых" деревьях.
//
// Revision 1.145  2006/12/19 12:43:57  lulin
// - передаем типизированные данные, а не абстрактные.
//
// Revision 1.144  2006/11/03 11:00:34  lulin
// - объединил с веткой 6.4.
//
// Revision 1.143.2.2  2006/10/19 07:41:31  lulin
// - выливаем текст о том, что показывать - картинку или картинку и текст.
//
// Revision 1.143.2.1  2006/10/18 08:00:34  lulin
// - заголовок для настроек приобрел общее название.
//
// Revision 1.143  2006/09/20 09:12:55  oman
// - fix: В окне настройки тулбаров Восстановить все не
//  восстанавливало глубину цвета (cq22660)
//
// Revision 1.142  2006/08/25 12:34:15  oman
// - new: Новый тип операции _vcm_otMenuButtonPopup - такой же как
//   _vcm_otButtonPopup, но умеет еще показываться в меню.
//
// Revision 1.141  2006/07/18 13:18:21  mmorozov
// - new: vcm_otButtomPopup включена в список операций, у которых можно показывать подпись (CQ: OIT500021668);
//
// Revision 1.140  2006/06/06 10:55:59  oman
// - fix: Проблемы с вычитыванием шорткатов при переключении конфигураций (cq17830)
//
// Revision 1.139  2006/06/02 12:36:09  oman
// - fix: В настройке тулбара при его смене могли хватать не видимый для пользователя
//
// Revision 1.138  2006/05/19 12:44:42  mmorozov
// - cleanup;
//
// Revision 1.137  2006/05/19 12:28:16  mmorozov
// - new: при первом открытии редактируемой панели может быть, например если диалог открываем из настроек конфигурации (CQ: OIT500020987);
//
// Revision 1.136  2006/04/20 08:49:32  mmorozov
// - new behaviour: разрешаем показ в списке панелей инструментов с одинаковыми названиями;
//
// Revision 1.135  2006/04/18 09:03:50  oman
// cleanup (убирание rCaption из vcmPathPair)
//
// Revision 1.134  2006/03/30 14:54:57  mmorozov
// - bugfix: всегда редактировался верхний toolbar формы, вне зависимости от того, на каком вызвали редактирование, теперь правильно (CQ: 20220);
//
// Revision 1.133  2006/03/07 13:27:02  mmorozov
// - bugfix: добавление суффиксов к операциям с одинаковыми названиями отваливалось (cq: 19902);
//
// Revision 1.132  2006/01/20 11:33:11  mmorozov
// 1. Нельзя было на панель инструментов положить неколько операций из разных сущностей с одинаковыми именами;
// 2. Если в панели инструментов встречаются операции с одинаковыми названиями, то им автоматически добавляется суффикс в виде названия сущности;
// 3. Появилась возможность указать, что контекстные операции сущности должны показываться в отдельном пункте меню;
// 3.
//
// Revision 1.131  2005/05/27 14:42:29  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.130  2005/04/19 15:41:37  lulin
// - переходим на "правильный" ProcessMessages.
//
// Revision 1.129  2005/04/12 09:20:46  fireton
// - bug fix: AV при вызове настройки тулбара
//
// Revision 1.128  2005/03/15 06:53:22  mmorozov
// new: protected property TCustomizeToolsForm.RestoreBtnVisible;
// new behaviour: не показываем кнопку "Восстанавить", т.к. она дублирует поведение кнопки "Отмена";
//
// Revision 1.127  2005/02/10 10:02:02  am
// bugfix: в ReleaseContainers не проверяли существование дерева
// bugfix: ExecutePrim не был рассчитан на открытие вне тулбара\дока
// bugfix: anEntity.OperationsDefIterator с некоторых пор стало возвращать nil - вставил проверку
//
// Revision 1.126  2005/01/31 12:45:51  am
// change: теперь настройку тулбаров можно вызвать только щёлкая на тулбар. Но в этой настройке множественный выбор тулбаров
//
// Revision 1.125  2005/01/15 12:40:49  fireton
// - bug fix: корректная работа кнопки "Восстановить"
//
// Revision 1.124  2004/12/28 12:05:21  am
// bugfix: цвет поля шортката при очистке
//
// Revision 1.123  2004/12/23 08:40:33  lulin
// - вычищен ненужный модуль.
//
// Revision 1.122  2004/12/17 14:27:32  demon
// - new behavior: метод DoDrop получил новый параметр var dwEffect: Longint, теперь его может поменять приемник (TargetObject)
//
// Revision 1.121  2004/12/17 13:16:35  demon
// - new behavior: изменена семантика методов CanBeginDrag и AfterDrag
//
// Revision 1.120  2004/12/17 09:10:18  am
// change: в Execute в качестве параметра-компонента можно передавать ni. Тогда форма откроется в режиме редактирования всех тулбаров.
//
// Revision 1.119  2004/11/18 16:29:57  lulin
// - отвязываем библиотеки от VCM без использования inc'ов.
//
// Revision 1.118  2004/11/05 14:04:54  am
// change: новый тип - _vcm_otMenuButtonCombo. Полностью такой же, как vcm_otButtonCombo, но умеет показывать себя в меню.
//
// Revision 1.117  2004/10/28 11:19:11  mmorozov
// new: method TCustomizeToolsForm.LoadGlyphSize;
// new: при "Восстановить все" восстанавливается размер иконок;
//
// Revision 1.116  2004/10/27 11:19:13  am
// change: добавил к показываемым типам _vcm_otButtonPopup
//
// Revision 1.115  2004/10/27 09:59:50  am
// change: разные списки операций для дерева шорткатов и дерева тулбаров
//
// Revision 1.114.2.2  2004/10/27 11:07:04  am
// change: добавил к показываемым типам _vcm_otButtonPopup
//
// Revision 1.114.2.1  2004/10/27 10:49:30  am
// change: разные списки операций для дерева шорткатов и дерева тулбаров
//
// Revision 1.115  2004/10/27 09:59:50  am
// change: разные списки операций для дерева шорткатов и дерева тулбаров
//
// Revision 1.114  2004/10/19 15:09:48  am
// bugfix: вместе с операциями без икон резались и vcm_otCombo-операции
//
// Revision 1.113  2004/10/18 12:50:20  voba
// - bug fix: numpad shortcuts
//
// Revision 1.112  2004/10/18 09:13:57  am
// bugfix: уничтожаем форму _vcmFree, а не Free(наследие того, что форма была не vcm'ная)
// change: не показываем операции без иконок (по просьбе Макса)
//
// Revision 1.111  2004/10/07 14:40:16  am
// change: переезд f_ActionShortCutChanged на _TvcmObjectList
//
// Revision 1.110  2004/10/07 12:44:33  mmorozov
// - используется vcmDispatcher.ReloadAllToolbars;
//
// Revision 1.109  2004/10/05 10:31:40  lulin
// - new behavior: превращаем "Документы" в "Правовой Навигатор". Т.е. берем _Caption не у контрола, а у операции (CQ OIT5-8927).
//
// Revision 1.108  2004/09/30 11:29:40  am
// change: по нажатию "Применить" дёргаем _ManualUpdateActions текущей формы
//
// Revision 1.107  2004/09/30 07:59:10  am
// change: при выборе "Восстановить всё" дёргаем _ManualUpdateActions
//
// Revision 1.106  2004/09/23 16:08:54  am
// change: добавил UpdateEnableFlags в пару мест
//
// Revision 1.105  2004/09/23 11:52:44  am
// change: теперь при _первой_ записи шорткатов в настройки дефолтным значением для них пропишутся шорткаты с формы
//
// Revision 1.104  2004/09/22 13:31:12  am
// bugfix: assert иногда при сбросе всех значений к дефолтным
//
// Revision 1.103  2004/09/17 10:33:04  am
// bugfix: AV при нажатии "восстановить всё"
//
// Revision 1.102  2004/09/15 13:58:03  lulin
// - new unit: vcmStringList.
//
// Revision 1.101  2004/09/14 09:11:14  fireton
// - bug fix: выводим описание (LongHint) для операций
//
// Revision 1.100  2004/09/13 14:42:31  am
// bugfix: упушенная при переносе на деревья проверка.
//
// Revision 1.99  2004/09/10 16:21:50  lulin
// - оптимизация - кешируем OpDef и передаем ссылку на OperationItem, а не на кучу параметров.
//
// Revision 1.98  2004/09/10 12:23:56  lulin
// - оптимизация - гораздо аккуратнее обращаемся с UserType'ами и VisibleOpCount. В итоге уменьшено количество различных вызовов.
//
// Revision 1.97  2004/09/10 11:33:14  fireton
// - bug fix: неправильно работал drag-n-drop в окне выбранных операций
// - bug fix: зацикливание при перетаскивании операции на саму себя
//
// Revision 1.96  2004/08/30 13:12:57  fireton
// - bug fix: корректный ресайз с large fonts
//
// Revision 1.95  2004/08/30 08:39:19  fireton
// - bug fix: при повторном изменении параметров тулбара вылетали по AV
//
// Revision 1.94  2004/08/27 08:15:25  am
// change: в случае редактирования одного тулбара тоже показываем _LongCaption в качестве названия
//
// Revision 1.93  2004/08/27 07:37:08  am
// change: для отображения usertype'а в списке берём _LongCaption
//
// Revision 1.92  2004/08/26 08:43:51  am
// change: юзертайпы с _VisibleToUser = False не присутствуют в списке
//
// Revision 1.91  2004/08/25 11:40:19  am
// bugfix: правка ошибок, сделанных при переводе на деревья
//
// Revision 1.90  2004/08/19 14:23:19  am
// change: частично вынес проверку видимости операции пользователю на OperationDef
// change: не показываем пользователю тулбары без операций
//
// Revision 1.89  2004/08/19 13:36:09  fireton
// - добавление выбора глубины цвета для иконок
//
// Revision 1.88  2004/08/17 13:15:20  mmorozov
// bugfix: открытие формы и нажатие кнопки Ok не приводит к сохранению toolbar-ов и shortcut-ов;
// new behaviour: состав toolbar-а сохраняется только если он был изменен;
// new behaviour: shortcut-ы сохраняются только если они редактировались и только у тех операций, которые редактировались;
//
// Revision 1.87  2004/08/11 14:30:00  law
// - new behavior: сделан вызов Help'а для пунктов меню.
//
// Revision 1.86  2004/08/11 10:28:24  fireton
// - добавлен выбор размера иконок
//
// Revision 1.85  2004/08/09 11:05:42  fireton
// - переделка под деревья
//
// Revision 1.83.2.5  2004/08/09 11:02:57  fireton
// - переделка под деревья завершена
//
// Revision 1.83.2.3  2004/08/06 14:06:03  fireton
// - промежуточное сохранение
//
// Revision 1.83.2.2  2004/08/06 11:57:26  fireton
// - fix: merge с root (shortcuts)
// - fix: TabOrder
//
// Revision 1.83.2.1  2004/08/05 08:54:02  fireton
// - change: переделка под TvtOutliner
//
// Revision 1.82  2004/06/25 07:20:54  am
// bugfix: AV при нажатии "Восстановить"
//
// Revision 1.81  2004/06/16 09:36:29  am
// change: _LoadShortcuts
//
// Revision 1.80  2004/06/04 07:57:27  nikitin75
// убрана коррекция для Large Fonts (т.к теперь в vcl);
// поправлена доступность кнопок
//
// Revision 1.79  2004/05/27 13:05:10  am
// new: ResetShortcutsToDefault
// bugfix: "Восстановить всё" откатывает шорткаты к их дефолтным значениям в настройках
//
// Revision 1.78  2004/05/25 12:19:07  am
// bugfix: AV (переводя форму на vcm-рельсы забыли Destroy)
// new: сохранение шорткатов
//
// Revision 1.77  2004/04/23 11:34:12  nikitin75
// для ввода ShortCut используем TeeShortCutEdit;
//
// Revision 1.76  2004/04/16 14:34:00  am
// change: для операций типа TextButton тоже доступна настройка значок\текст+значок
//
// Revision 1.75  2004/04/16 10:38:59  am
// bugfix: забыли поменять BeforeDestruction в Cleanup при переводе формы на vcm-рельсы
//
// Revision 1.74  2004/04/15 14:24:56  law
// - bug fix: TCustomizeToolsForm сделан наследником TvcmEntityForm (CQ OIT5-6447).
//
// Revision 1.73  2004/04/09 14:30:06  nikitin75
// fix: в список shorcut'ов попадали пустые строки
//
// Revision 1.72  2004/04/09 11:27:49  law
// - new class: _TvcmStringList.
//
// Revision 1.71  2004/04/08 14:54:56  am
// change: дизейблим возможность выбора значок\значок+текст для операций без икон.
//
// Revision 1.70  2004/04/07 12:10:27  am
// change: при нажатии "Восстановить всё" сбрасываемся к дефолтным настройкам
//
// Revision 1.69  2004/04/02 08:18:22  am
// change: проверка в ExecutePrim. Теперь не только тулбары и доки.
//
// Revision 1.68  2004/03/30 07:47:19  nikitin75
// fix: _caption операции берем не у контрола, а у OpDef;
//
// Revision 1.67  2004/03/27 13:21:18  am
// change: перенёс элементы на панель, выставил ей Visible - False (в рамках временной кастрации функциональности)
//
// Revision 1.66  2004/03/26 13:57:04  nikitin75
// syntax fix;
//
// Revision 1.65  2004/03/26 13:50:31  nikitin75
// visual fix;
//
// Revision 1.64  2004/03/26 11:29:48  am
// bugfix: рано уничтожались объекты-обёртки
//
// Revision 1.63  2004/03/26 10:54:36  am
// change: временно убрал комбобокс выбора положения тулбара (до разбирательств)
// new: лок доков на момент перезагрузки тулбаров
// new: поддержка кнопок с иконками и текстам
//
// Revision 1.62  2004/03/24 15:23:19  law
// - change: не даем изменять имя Toolbar'а, что все равно бессмыссленно.
//
// Revision 1.61  2004/03/24 14:16:49  law
// - bug fix: неправильно перенабирались несохраненные Toolbar'ы формы после настройки одного из них.
//
// Revision 1.60  2004/03/24 13:30:07  law
// - bug fix: неправильно определялся тип Toolbar'а (верхний, нижний, правый, левый).
//
// Revision 1.59  2004/03/11 15:07:09  nikitin75
// fix: убран лишний вызов UpdateShortCut;
//
// Revision 1.58  2004/03/11 14:50:56  nikitin75
// fix: count спрашивал после clear;
//
// Revision 1.57  2004/03/09 07:18:01  nikitin75
// + поддержка нескольких shortcut'ов для операции;
//
// Revision 1.56  2004/03/01 12:48:27  nikitin75
// fix: update shortcuts;
//
// Revision 1.55  2004/03/01 11:44:25  nikitin75
// + {$I vcmDefine.inc };
// + проверка/обеспечение уникальности shortcut'ов;
//
// Revision 1.54  2004/02/26 13:39:36  nikitin75
// + запрос на применение изменений;
//
// Revision 1.53  2004/02/26 12:09:27  nikitin75
// + присваиваем shortcut'ы в runtime;
//
// Revision 1.52  2004/02/25 13:17:18  nikitin75
// + OnShortCutEditChange;
//
// Revision 1.51  2004/02/25 11:55:03  nikitin75
// + shortcut inptu _box;
// + visual fix;
//
// Revision 1.50  2004/02/11 17:54:36  law
// - new behavior: возможность выбора Toolbar'а верхний/нижний etc.
//
// Revision 1.49  2004/02/11 15:04:26  law
// - bug fix: не поднимаем Exception если DockedTo нету.
//
// Revision 1.48  2004/02/11 14:27:57  law
// - change: задел на множественность Toolbar'ов.
//
// Revision 1.47  2004/02/11 12:56:25  law
// - new: кнопка btApply, которая применяет настройки, но не закрывает окно.
//
// Revision 1.46  2004/02/11 12:37:31  law
// - new behavior: не пересоздаем Toolbar при его сохраненнии.
//
// Revision 1.45  2004/02/11 12:18:41  law
// - new behavior: пересоздаем Toollbar'ы для всех заинтересованных форм.
//
// Revision 1.44  2004/02/10 19:05:28  law
// - cleanup.
//
// Revision 1.43  2004/02/10 19:00:13  law
// - new behavior: обрабатываем кнопку Restore.
//
// Revision 1.42  2004/02/10 18:45:01  law
// - new behavior: отслеживаем Enabled кнопки Apply.
//
// Revision 1.41  2004/02/10 18:09:45  law
// - bug fix: записываем Toolbar'ы той формы, которую выбрали из ComboBox.
//
// Revision 1.40  2004/02/10 17:45:11  law
// - new behavior: ищем экземпляр уже созданной формы и если не нашли, то только в этом случае создаем новую.
//
// Revision 1.39  2004/02/10 17:09:40  law
// - new: в нулевом приближении сделана настройка Toolbar'ов при выборе объекта из списка.
//
// Revision 1.38  2004/02/10 15:28:54  law
// - new prop: IvcmUserTypeDef.ID.
//
// Revision 1.37  2004/02/10 14:59:12  law
// - change: вместо пары UserType.Name/_Caption используем интерфейс IvcmUserTypeDef.
//
// Revision 1.36  2004/02/10 14:15:11  law
// - refectoring: разгреб метод ExecutePrim на месколько методов помельче.
//
// Revision 1.35  2004/02/10 12:59:52  law
// - change: IvcmUserTypesIterator теперь возвращает IvcmUserTypeDef.
//
// Revision 1.34  2004/02/09 14:15:49  law
// - change: вставлены скобки BeginUpdate/EndUpdate - что-то правда моргать меньше не стало.
//
// Revision 1.33  2004/02/06 12:13:47  law
// - new behavior: сохраняем/читаем необходимость наличия разделителя.
//
// Revision 1.32  2004/02/04 15:18:33  law
// - bug fix: берем компоненты по порядку их следования.
//
// Revision 1.31  2004/02/04 10:00:29  law
// - bug fix: восстановлена работоспособность формы - в *.pas не было ряда компонент, которые присутствуют в *.dfm.
//
// Revision 1.30  2004/01/23 09:09:38  nikitin75
// - cleanup;
//
// Revision 1.29  2004/01/16 12:00:46  am
// change: использование _TvcmToolbarDef.DeleteControls
//
// Revision 1.28  2004/01/15 15:07:27  law
// - bug fix: AV при настройке toobar'ов (виновато было появление кнопочки MoreButton) (CQ OIT5-5193).
//
// Revision 1.27  2003/08/01 09:59:51  law
// - new behavior: элементы переносятся по DblClick по спискам.
//
// Revision 1.26  2003/08/01 09:36:19  law
// - new behavior: при настройке toolbar'ов убраны лишние разделители.
//
// Revision 1.25  2003/07/31 15:43:58  law
// - new behavior: сделано сохранение позиций кнопок.
//
// Revision 1.24  2003/07/31 15:20:17  law
// - new behavior: сделано сохранение тех кнопок, которые не попадают в toolbar.
//
// Revision 1.23  2003/07/31 11:50:02  law
// - new behavior: сохранение настроек toolbar'а в базу (пока не работает GblAdapter).
//
// Revision 1.22  2003/07/28 12:27:16  law
// - new behavior: учитывае разделители при настройке Toolbar'ов.
//
// Revision 1.21  2003/07/28 11:42:28  law
// - new behavior: в форму настройки Toolbar'ов выводим список пользовательских типов объектов.
//
// Revision 1.20  2003/07/28 06:26:00  nikitin75
// + Drag-and-Drop;
//
// Revision 1.19  2003/07/25 16:24:06  law
// - new behavior: пооптимальнее выводится имя объекта.
//
// Revision 1.18  2003/07/25 14:45:46  nikitin75
// + поддержка LargeFonts;
//
// Revision 1.17  2003/07/25 14:12:29  law
// - new behavior: разрешено пользователю вставлять кнопки без иконок в toolbar.
//
// Revision 1.16  2003/07/25 13:50:12  law
// - new behavior: сделано закрытие по Esc.
// - new behavior: пооптимальнее выводится имя объекта.
//
// Revision 1.15  2003/07/25 13:39:28  law
// - new behavior: toolbar'ы обновляются после настройки.
//
// Revision 1.14  2003/07/25 12:59:28  nikitin75
// поддержка ModalResult;
//
// Revision 1.13  2003/07/25 12:40:57  nikitin75
// восстановил утраченное из 1.11;
//
// Revision 1.12  2003/07/25 12:26:51  nikitin75
// + теперь должны корректно поддердиваться LargeFont'ы;
//
// Revision 1.10  2003/07/25 11:41:46  law
// - new behavior: выводим название объекта, для которого настраиваем toolbar.
//
// Revision 1.9  2003/07/25 10:26:33  nikitin75
// + добавлена функциональность;
// - временно отключил MultiSelect;
//
// Revision 1.8  2003/07/25 10:13:54  law
// - cleanup: убрано записывание в поле Data индекса элемента.
// - new behavior: разрешено множественное выделение элементов.
//
// Revision 1.7  2003/07/25 10:07:08  law
// - new behavior: сделано вычитание списка выбранных из списка доступных.
//
// Revision 1.6  2003/07/24 16:04:13  law
// - new behavior: набираем список доступных операций.
//
// Revision 1.5  2003/07/24 14:16:58  law
// - change: опять убрал Anchors - частично заменил их на панели.
//
// Revision 1.4  2003/07/23 17:15:03  law
// - вставлены теги CVS.
//

{$Include vcmDefine.inc }

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  Buttons,
  ComCtrls,
  ImgList,
  ActnList,

  l3Interfaces,
  l3TreeInterfaces,

  vtOutliner,
  vtOutlinerWithDragDrop,

  l3Tree_TLB,

  vcmInterfaces,

  vcmAction,
  vcmBaseMenuManager,
  vcmEntityForm,
  vcmBase,
  vcmControllers,

  eeShortCutEdit, vtLabel,

  PrimCustomizeTools_Form,
  vtCheckBox,
  vtRadioButton,
  ElPgCtl,
  nscPageControl,
  vtButton,
  vtComboBoxQS, eeCheckBox, afwTextControlPrim, afwTextControl,
  afwCustomCommonTextControlPrim, afwCustomCommonTextControl,
  afwCustomCommonControlPrim, afwCustomCommonControl, ElXPThemedControl,
  eeButton, afwControlPrim, afwBaseControl, afwControl,
  nevControl, evCustomEditorWindowPrim, evCustomEditorWindow,
  evCustomEditorWindowModelPart, evMultiSelectEditorWindow,
  evCustomEditorModelPart, evCustomEditor, evEditorWithOperations,
  evCustomMemo, evCustomEdit, elCustomEdit, elCustomButtonEdit,
  ctButtonEdit, ctAbstractEdit, AbstractDropDown, DropDownTree, EditableBox, FakeBox,
  OvcBase,
  vcmToolbarMenuRes,
  vcmMenuManager,
  vcmUserTypeDescr
  ;

type
  IActionNode = interface(Il3Node)
  ['{7FAB2D53-7109-415F-8A1D-EEB6255D5C5A}']
  // private methods
   function GetAction: TBasicAction;
     {-}
   procedure SetAction(anAction: TBasicAction);
     {-}
   function GetImageIndex: Integer;
     {-}
   procedure SetImageIndex(anIndex: Integer);
     {-}
   function GetIconText: Boolean;
     {-}
   procedure SetIconText(anIconText: Boolean);
     {-}
   procedure SetOldShortcut(anShortcut: Longint);
     {-}
   function GetOldShortcut: Longint;
     {-}
   function GetOldSecShortcuts: TShortcutList;
     {-}  
  // public properties
    property Action : TBasicAction
      read GetAction
      write SetAction;
      {-}
    property ImageIndex : Integer
      read GetImageIndex
      write SetImageIndex;
      {-}
    property IconText : Boolean
      read GetIconText
      write SetIconText;
      {-}
    property OldShortCut : Longint
      read GetOldShortcut
      write SetOldShortcut;
      {-}
    property OldSecShortcuts : TShortcutList
      read GetOldSecShortcuts;
      {-}
  end;

  TvcmEntityFormRef = TPrimCustomizeToolsForm;

  TCustomizeToolsForm = class(TvcmEntityFormRef)
    MultipleTopPanel: TPanel;
    SingleTopPanel: TPanel;
    lbObject: TvtLabel;
    cbObject: TvtComboBoxQS;
    ResetToDefaultButton: TvtButton;
    btOk: TvtButton;
    btCancel: TvtButton;
    edToolbars: TEdit;
    btApply: TvtButton;
    ConfirmSavaLabel: TvtLabel;
    PageControl: TnscPageControl;
    ToolBarsTabSheet: TElTabSheet;
    pnToolbar: TPanel;
    lbToolbar: TvtLabel;
    cbToolBar: TvtComboBoxQS;
    btAdd: TvtButton;
    CenterPanel: TPanel;
    AvailableOperationsLabel: TvtLabel;
    SelectedOperationsLabel: TvtLabel;
    RemoveBitBtn: TBitBtn;
    AddBitBtn: TBitBtn;
    WhotShowRadioGroup: TGroupBox;
    DownBitBtn: TBitBtn;
    UpBitBtn: TBitBtn;
    ShortCutsTabSheet: TElTabSheet;
    AllOperationsLabel: TvtLabel;
    lwShortCuts: TListView;
    ShortCutLabel: TvtLabel;
    ShortCutEdit: TeeShortCutEdit;
    RemoveButton: TvtButton;
    AddButton: TvtButton;
    DescriptionLabel: TvtLabel;
    DescriptionContentLabel: TvtLabel;
    pnToolbarProps: TPanel;
    chkShowMisplaced: TvtCheckBox;
    IconSizeLabel: TvtLabel;
    IconSizeComboBox: TvtComboBoxQS;
    ResetAllToDefaultButton: TvtButton;
    ClearShortcutButton: TvtButton;
    MiscTabSheet: TElTabSheet;
    Bevel1: TBevel;
    Label2: TvtLabel;
    cbIcon: TvtRadioButton;
    cbTextAndIcon: TvtRadioButton;
    rbGlyphSizeAuto: TvtRadioButton;
    rbGlyphSizeSmall: TvtRadioButton;
    rbGlyphSizeMedium: TvtRadioButton;
    rbGlyphSizeLarge: TvtRadioButton;
    rbGlyphColorAuto: TvtRadioButton;
    rbGlyphColor16: TvtRadioButton;
    rbGlyphColor256: TvtRadioButton;
    rbGlyphColorFull: TvtRadioButton;
    gbGlyphSize: TGroupBox;
    gbGlyphColor: TGroupBox;
    procedure AddBitBtnClick(Sender: TObject);
    procedure RemoveBitBtnClick(Sender: TObject);
    procedure UpBitBtnClick(Sender: TObject);
    procedure DownBitBtnClick(Sender: TObject);
    procedure f_AvailableOperationsDblClick(Sender: TObject; Index : Longint);
    procedure f_SelectedOperationsDblClick(Sender: TObject; Index : Longint);
    procedure cbObjectChange(Sender: TObject);
    procedure ResetToDefaultButtonClick(Sender: TObject);
    procedure btApplyClick(Sender: TObject);
    procedure cbToolBarChange(Sender: TObject);
    procedure ShortCutEditChange(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure lwShortCutsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure RemoveButtonClick(Sender: TObject);
    procedure WhotShowRadioGroupClick(Sender: TObject);
    procedure ResetAllToDefaultButtonClick(Sender: TObject);
    procedure ClearShortcutButtonClick(Sender: TObject);
    procedure vcmEntityFormResize(Sender: TObject);
    procedure rgGlyphSizeClick(Sender: TObject);
    procedure rgGlyphColorClick(Sender: TObject);
    procedure vcmEntityFormRefCreate(Sender: TObject);
  private
    f_UserTypeDescrList: TvcmUserTypeDescrList;
    f_AllOperationsList: TvtOutliner;
    f_AvailableOperationsList: TvtOutlinerWithDragDrop;
  // internal fields
    f_Form                   : TvcmEntityForm;
    f_Toolbar                : TComponent;
    f_IsNeedDefineToolbar    : Boolean;
      {* - при первом открытии формы ей передается toolbar на котором вызвали
           настройку, чтобы сохранить его как текущий установим флаг, чтобы в
           ShowUserType не переопределяли toolbar, а использовали текущий. }
    f_NeedFreeForm           : Boolean;
    f_UserType               : IvcmUserTypeDef;
    f_MenuManager            : TvcmBaseMenuManager;
    f_ManualUpdate           : Boolean;
    f_SelectedOperationsList : TvtOutlinerWithDragDrop;
    f_Modified               : Boolean;
    f_ActionShortCutChanged  : TvcmObjectList;
    f_IgnoreModifications    : Boolean;
    f_ToolbarChanged         : Boolean;
    f_IsFillingObjects       : Boolean;
    f_IsFillingToolbar       : Boolean;
  private
  // internal methods
    procedure AddChangedShortCut(aAction : TvcmAction);
      {* - добавляется в список f_ActionShortCutChanged Action, которая изменилось. }
  private
  // property methods
    function  pm_GetModified : Boolean;
      {-}
    procedure pm_SetModified(aValue: Boolean);
      {-}
    function  pm_GetRestoreBtnVisible : Boolean;
      {-}
    procedure pm_SetRestoreBtnVsible(const aValue : Boolean);
      {-}
  private
  // internal methods
    procedure UpdateEnableFlags;
      {-}
    procedure UpdateShortCutItemState;
      {-}
    procedure TuneBoxes;
      {-}
    procedure FillObjects(aMenuManager     : TvcmBaseMenuManager;
                          const aUserType  : IvcmUserTypeDef = nil);
      {-}
    function ExecutePrim(aMenuManager : TvcmBaseMenuManager;
                          aToolbar     : TComponent): Boolean;
      {-}
    procedure SetForm(aForm         : TvcmEntityForm;
                      aToolbar      : TComponent;
                      aNeedFreeForm : Boolean);
      {-}
    procedure FillSelected;
      {-}
    procedure FillAvalailable;
      {-}
    procedure FillAll;
      {-}
    procedure ReloadData;
      {-}
    procedure LoadGlyphSize;
      {-}
    procedure LoadGlyphColordepth;
      {-}
    procedure FillOperations(aTarget : TvtCustomOutliner;
                             aAvalailableOnly: Boolean;
                             aResetShortcuts: boolean;
                             aFillShortcuts: boolean);
      {-}
    procedure SaveToolbars;
      {-}
    procedure MoveSelected(aTo, aFrom : TvtCustomOutliner);
      {-}
    procedure MoveSelectedA(aList : TvtCustomOutliner; aMoveUp : Boolean);
      {-}
    function  AddShortCut(const aAction : IActionNode;
                          aShortCut     : TShortCut;
                          aAskOnly      : Boolean = False) : Boolean;
      {-}
    procedure AllOperationsChange(Sender : TObject; aNewCurrent : Longint;  aOldCurrent : Longint);
      {-}
    procedure UpdateShortCut(const aActionNode : IActionNode);
      {-}
    procedure OpListChange(Sender : TObject; aNewCurrent : Longint;  aOldCurrent : Longint);
      {-}
    function GetListImage(Sender : TObject; Index : Longint; var aImages : TCustomImageList): Integer;
      {-}
    procedure OperationsBeginDrag(const aNode   : Il3SimpleNode;
                                  var aOkEffect : Longint);
      {-}
    function SelectedDragAcceptData(const aData : IDataObject): Boolean;
      {-}
    function AvailableDragAcceptData(const aData : IDataObject): Boolean;
      {-}
    function Drop2AvailOperations(const aData  : Il3SimpleNode;
                                  aWantMenu    : Boolean;
                                  var dwEffect : Longint): Boolean;
      {-}
    function Drop2SelectedOperations(const aData  : Il3SimpleNode;
                                     aWantMenu    : Boolean;
                                     var dwEffect : Longint): Boolean;
      {-}
    function GetCheckedGlyphSize: TvcmGlyphSize;
      {-}
    function GetCheckedColorDepth: TvcmGlyphColorDepth;
      {-}
    function GetSelectedUserType: IvcmUserTypeDef;
      {-}
  protected
  // protected methods
    procedure Cleanup;
      override;
      {-}
    procedure ShowUserType(const aUserType     : IvcmUserTypeDef;
                           const aForceSetForm : Boolean = False);
  protected
  // internal properties
    property Modified: Boolean
      read pm_GetModified
      write pm_SetModified;
      {-}
    property RestoreBtnVisible : Boolean
      read pm_GetRestoreBtnVisible
      write pm_SetRestoreBtnVsible;
      {* - управляет видимостью кнопки "Восстановить". }
  public
    { Public declarations }
    constructor Create(anOwner: TComponent);
      override;
      {* - создает форму. }
    class function Execute(aMenuManager : TvcmBaseMenuManager;
                            aDock        : TComponent): Boolean;
      {-}
  end;//TCustomizeToolsForm

implementation

uses
  StrUtils,
  Menus,

  OvcCmd,
  OvcData,

  l3Base,
  l3Types,
  l3Nodes,
  l3ControlsTypes,
  l3String,

  afwFacade,

  vtLister,

  vcmUserControls,
  vcmTasksPanel,
  vcmExternalInterfaces,
  vcmStringList,
  vcmUtils,
  vcmCustomizeUtils,
  vcmCustomizeAvailableToolbarOps,

  vcmBaseCollectionItem,
  vcmUserTypesCollectionItem,
  vcmBaseEntitiesCollectionItem,
  vcmBaseOperationsCollectionItem,
  vcmModulesCollectionItem,

  vcmForm,
  vcmMainForm,

  vcmEntityAction,
  vcmModuleAction,
  vcmOperationAction,

  vcmMenus,

  vcmSettings,
  vcmTaskPanelInterfaces,

  vcmInternalConst,
  vcmOVCCommands,
  l3StringIDEx,

  vcmCustomizeToolsRes,
  vcmMessagesSupport,

  vcmContainerForm,
  vcmToolbar,

  l3MessageID,
  l3Const
  ;

////////////////////////////////////////////////////////////////////////////////
const
 cCompSpace = 10;
   {* - расстояние между компонентами следующими друг за другом. }
////////////////////////////////////////////////////////////////////////////////

{$R *.dfm}

resourcestring
 qrRestoreAllDefault = 'Вы действительно хотите восстановить позиции и набор операций всех панелей инструментов системы по умолчанию?';

const
 cIconTextTypes = [
   vcm_otButton,
   vcm_otCheck,
   vcm_otMenuButtonCombo,
   vcm_otButtonCombo,
   vcm_otTextButton,
   vcm_otButtonPopup];

 cShortcutTypes = [
   vcm_otButton,
   vcm_otCheck,
   vcm_otMenuButtonCombo,
   vcm_otButtonCombo,
   vcm_otTextButton,
   vcm_otButtonPopup];

const
 cSeparator = '- Разделитель -';

type
 TActionNode = class(Tl3UsualNode, IActionNode)
 private
  f_Action          : TBasicAction;
  f_IconText        : boolean;
  f_ImageIndex      : Integer;
  f_OldShortcut     : Longint;
  f_OldSecShortcuts : TShortcutList;
 private
 // interface IActionNode
  function GetAction : TBasicAction;
    {-}
  function GetIconText : Boolean;
    {-}
  function GetImageIndex : Integer;
    {-}
  procedure SetAction(anAction : TBasicAction);
    {-}
  procedure SetIconText(anIconText : Boolean);
    {-}
  procedure SetImageIndex(anIndex : Integer);
    {-}
  procedure SetOldShortcut(anShortcut: Longint);
    {-}
  function GetOldShortcut: Longint;
    {-}
  function GetOldSecShortcuts: TShortcutList;
    {-}
 protected
 // protected methods
   procedure Cleanup;
     override;
     {-}
 public
  class function Make(anOp     : IvcmOperationDef;
                      anAction : TBasicAction) : IActionNode;
    overload;
    {-}
  class function Make(anAction       : TBasicAction;
                      const aCaption : Il3CString;
                      aImageIndex    : Integer) : IActionNode;
    overload;
    {-}
 end;//TActionNode

function ActionIsNil(const aData : IActionNode): boolean;
begin
 Result := aData.GetAction = nil;
end;

function ExtractAction(const aData : IActionNode): TvcmAction;
begin
 Result := nil;
 if Assigned(aData) and Assigned(aData.Action) then
  Result := TvcmAction(aData.Action);
end;

function ExtractIconText(aData: IActionNode): boolean;
begin
 Result := aData.GetIconText;
end;

procedure ReleaseContainers(aList : TvtCustomOutliner);
begin
 if (aList.CTree <> nil) and (aList.CTree.RootNode <> nil) then
  aList.CTree.CRootNode.ReleaseChilds;
end;

procedure TActionNode.Cleanup;
begin
 inherited;
 if f_OldSecShortcuts <> nil then
  FreeAndNil(f_OldSecShortcuts);
end;

function TActionNode.GetAction: TBasicAction;
begin
 Result := f_Action;
end;

function TActionNode.GetIconText: Boolean;
begin
 Result := f_IconText;
end;

function TActionNode.GetImageIndex: Integer;
begin
 Result := f_ImageIndex;
end;

class function TActionNode.Make(anOp: IvcmOperationDef; anAction : TBasicAction): IActionNode;
var
 lNode: TActionNode;
begin
 lNode := Create;
 with lNode do
 begin
  f_Action := anAction;
  f_IconText := false;
  if anOp <> nil then
  begin
   if not anOp.IsCaptionUnique and (anAction is TvcmEntityAction) then
    Text := l3PCharLen(vcmMakeCaption(TvcmEntityAction(anAction).EntityDef, anOp))
   else
    Text := l3PCharLen(anOp.Caption);
   f_ImageIndex := anOp.ImageIndex;
  end
  else
   f_ImageIndex := -1;
  f_OldShortcut := anOp.Shortcut;
  if (anOp.SecondaryShortCuts <> nil) and
     (anOp.SecondaryShortCuts.Count > 0) then
  begin
   f_OldSecShortcuts := TShortcutList.Create;
   f_OldSecShortcuts.Assign(anOp.SecondaryShortCuts);
  end
  else
   f_OldSecShortcuts := nil;
 end;
 Result := lNode;
 l3Free(lNode);
end;

function TActionNode.GetOldSecShortcuts: TShortcutList;
begin
 if f_OldSecShortcuts = nil then
  f_OldSecShortcuts := TShortcutList.Create; 
 Result := f_OldSecShortcuts;
end;

function TActionNode.GetOldShortcut: Longint;
begin
 Result := f_OldShortcut;
end;

procedure TActionNode.SetOldShortcut(anShortcut: Integer);
begin
 f_OldShortcut := anShortcut;
end;

class function TActionNode.Make(anAction       : TBasicAction;
                                const aCaption : Il3CString;
                                aImageIndex    : Integer): IActionNode;
var
 lNode: TActionNode;
begin
 lNode := Create;
 with lNode do
 begin
  f_Action := anAction;
  f_IconText := false;
  f_ImageIndex := aImageIndex;
  if (aCaption <> nil) then
   Text := aCaption.AsWStr;
  f_OldSecShortcuts := nil;
  f_OldShortcut := TShortcut(0);  
  if anAction is TCustomAction then
  begin
   f_OldShortcut := TCustomAction(anAction).Shortcut;
   if (TCustomAction(anAction).SecondaryShortCuts <> nil) and
      (TCustomAction(anAction).SecondaryShortCuts.Count > 0) then
   begin
    f_OldSecShortcuts := TShortcutList.Create;
    f_OldSecShortcuts.Assign(TCustomAction(anAction).SecondaryShortCuts);
   end;
  end;
 end;
 Result := lNode;
 l3Free(lNode);
end;

procedure TActionNode.SetAction(anAction: TBasicAction);
begin
 f_Action := anAction;
end;

procedure TActionNode.SetIconText(anIconText: Boolean);
begin
 f_IconText := anIconText;
end;

procedure TActionNode.SetImageIndex(anIndex: Integer);
begin
 f_ImageIndex := anIndex;
end;

procedure CopyItemFields(aTo, aFrom : TActionNode);
begin
 if ((aTo = nil) or (aFrom = nil)) then
  exit;
 aTo.Text := aFrom.Text;
 aTo.f_Action := aFrom.f_Action;
end;

// start class TCustomizeToolsForm

procedure TCustomizeToolsForm.AddChangedShortCut(aAction : TvcmAction);
begin
 if Assigned(aAction) and
   (f_ActionShortCutChanged.IndexOf(aAction) = -1) then
  f_ActionShortCutChanged.Add(aAction);
end;

procedure TCustomizeToolsForm.MoveSelected(aTo, aFrom : TvtCustomOutliner);
var
 l_IsSeparator: Boolean;
 l_DoAdd: Boolean;
 l_Origin, l_Separator : IActionNode;
begin
 if ((aTo = nil) or (aFrom = nil)) then
  exit;
 l_Origin := aFrom.CurrentCNode as IActionNode;
 if (l_Origin = nil) then
  exit;
 //
 l_DoAdd := aFrom = f_AvailableOperationsList;
 // l_DoAdd = добавляем или удаляем кнопки на тулбар/c тулбара

 l_IsSeparator := ActionIsNil(l_Origin);

 if l_IsSeparator then
 begin
  if l_DoAdd then
  begin
   l_Separator := TActionNode.Make(nil, str_vcmSeparator.AsCStr, -1);
   if (aTo.CurrentCNode = nil) or
      aTo.CurrentCNode.IsLast then
    aTo.CTree.InsertNode(aTo.CTree.CRootNode, l_Separator)
   else
    aTo.CTree.InsertNodeBefore(aTo.CurrentCNode.NextNode, l_Separator);
   aTo.Current := aTo.CTree.GetIndex(l_Separator);
  end
  else
   l_Origin.Remove;
 end
 else
 begin
  l_Origin.Remove;
  if (aTo.CurrentCNode = nil) or
     aTo.CurrentCNode.IsLast then
   aTo.CTree.InsertNode(aTo.CTree.CRootNode, l_Origin)
  else
   aTo.CTree.InsertNodeBefore(aTo.CurrentCNode.NextNode, l_Origin);
  aTo.Current := aTo.CTree.GetIndex(l_Origin);
 end;
 f_ToolbarChanged := True;
 Modified := true;
end;

procedure TCustomizeToolsForm.MoveSelectedA(aList : TvtCustomOutliner; aMoveUp : Boolean);
var
 lActionNode : IActionNode;
begin
 if aMoveUp then
  aList.CTree.MoveNode(aList.CurrentCNode, dUp)
 else
  aList.CTree.MoveNode(aList.CurrentCNode, dDown);
 if Supports(aList.CurrentCNode, IActionNode, lActionNode) then
 try
  f_ToolbarChanged := True;
 finally
  lActionNode := nil;
 end;
 Modified := true;
end;

function TCustomizeToolsForm.AddShortCut(const aAction : IActionNode;
                                            aShortCut     : TShortCut;
                                            aAskOnly      : Boolean) : Boolean;
  {-}
var
 i            : Integer;
 l_Key        : Word;
 l_Shift      : TShiftState;
 l_ByteShift  : Byte;
 l_CommandID  : Word;
 l_Action     : TvcmAction;
 l_Controller : TOvcController;

 function l_IsCommandHere(aRoot: Il3Node): Boolean;
 var
  l_Found  : Boolean;

  function FindCommandIterator(const aNode: Il3Node): Boolean;
  var
   l_Action : TvcmAction;
   l_ID     : Word;
  begin
   Result := False;
   l_Action := ExtractAction(aNode as IActionNode);
   if not Assigned(l_Action) then
     Exit;
   if l_Action is TvcmEntityAction then
    with l_Action as TvcmEntityAction do
     l_ID := vcmCommandID(EntityID, false, OperationID)
   else
   if l_Action is TvcmModuleAction then
    with l_Action as TvcmModuleAction do
     l_ID := vcmCommandID(ModuleID, true, OperationID)
   else
    Exit;
   if l_ID = l_CommandID then
   begin
    Result :=  True;
    l_Found := True;
   end;
  end;

 begin
  l_Found := False;
  aRoot.IterateF(l3L2NA(@FindCommandIterator), imCheckResult);
  Result := l_Found;
 end;

 function l_CanAssign(aRoot: Il3Node): Boolean;
 var
  l_Can: Boolean;

  function CheckIterator(const aNode: Il3Node): Boolean;
  var
   j        : Integer;
   l_Action : TvcmAction;
  begin
   Result := False;
   l_Action := ExtractAction(aNode as IActionNode);
   if Assigned(l_Action) then
   begin
    if l_Action.ShortCut = aShortCut then //and (l_Action <> aAction)
    begin
     Result := True;
     l_Can := False;
     Exit;
    end;
    with l_Action.SecondaryShortCuts do
     for j := 0 to Count - 1 do
      if ShortCuts[j] = aShortCut then
      begin
       Result := True;
       l_Can := False;
       Exit;
      end;
   end;
  end;

 begin
  l_Can := True;
  aRoot.IterateF(l3L2NA(@CheckIterator), imCheckResult);
  Result := l_Can;
 end;

begin
 Result := true;
 if aShortCut <> 0 then
 begin
  //shortcut уже используется?
  ShortCutToKey(aShortCut, l_Key, l_Shift);
  l_ByteShift := vcmByteShift(l_Shift);
  l_CommandID := 0;
  l_Controller := GetDefController;
  if Assigned(l_Controller) then
   with l_Controller.EntryCommands do
    if GetCommandTableIndex(c_vcmTableName) >= 0 then
     with l_Controller.EntryCommands.GetCommandTable(c_vcmTableName) do
      for i := 0 to Count - 1 do
       with Commands[i] do
        if (Key1 = l_Key) and (SS1 = l_ByteShift) then
        begin
         l_CommandID := Cmd;
         Result := false;//да
         Break;
        end;
  if (not Result) and
     (l_IsCommandHere(f_AvailableOperationsList.CTree.CRootNode) or
      l_IsCommandHere(f_SelectedOperationsList.CTree.CRootNode)) then
   //используемый shortcut в группе которую правим?
   Result := true;
  if Result then
   //осталось проверить ТОЛЬКО группу которую правим
   Result := l_CanAssign(f_AvailableOperationsList.CTree.CRootNode) and
             l_CanAssign(f_SelectedOperationsList.CTree.CRootNode);
 end;
 l_Action := ExtractAction(aAction);
 if Result and (not aAskOnly) then
 begin
  if l_Action.ShortCut <> 0 then
   l_Action.SecondaryShortCuts.Add(ShortCutToTextExt(aShortCut))
  else
   l_Action.ShortCut := aShortCut;
  (* добавим в список измененных *)
  AddChangedShortCut(l_Action);
 end;
end;

procedure TCustomizeToolsForm.UpdateShortCut(const aActionNode : IActionNode);
var
 l_ContItem, l_Item : TvcmBaseCollectionItem;
 l_OperationID      : TvcmControlID;
 l_Action           : TvcmAction;
begin
 l_ContItem := nil;
 l_OperationID := 0;
 l_Action := ExtractAction(aActionNode);
 if Assigned(l_Action) and Assigned(g_MenuManager) and Assigned(g_MenuManager.Entities) then
 begin
  if l_Action is TvcmEntityAction then
   with l_Action as TvcmEntityAction do
   begin
    l_ContItem := g_MenuManager.Entities.FindItemByID(EntityID);
    l_OperationID := OperationID;
   end
  else
  if l_Action is TvcmModuleAction then
   with l_Action as TvcmModuleAction do
   begin
    l_ContItem := g_MenuManager.Modules.FindItemByID(ModuleID);
    l_OperationID := OperationID;
   end;

  if Assigned(l_ContItem) and (l_ContItem is TvcmBaseEntitiesCollectionItem) then
   with l_ContItem as TvcmBaseEntitiesCollectionItem do
   begin
    l_Item := Operations.FindItemByID(l_OperationID);
    if Assigned(l_Item) and (l_Item is TvcmBaseOperationsCollectionItem) then
     with l_Item as TvcmBaseOperationsCollectionItem do
     begin
      ReplaceShortCuts(l_Action.ShortCut, l_Action.SecondaryShortCuts);
      vcmSaveShortcut(l_ContItem.Name, l_Item.Name,
                      l_Action.ShortCut, vcmCStr(l_Action.SecondaryShortCuts.Text),
                      aActionNode.OldShortcut,
                      aActionNode.OldSecShortcuts.Text);
     end;
   end;
 end;
end;

type
  THackWinControl = class(TWinControl);


constructor TCustomizeToolsForm.Create(anOwner: TComponent);
  //override;
  {* - создает форму. }
begin
 ZoneType := vcm_ztManualModal;
 inherited;
 f_AvailableOperationsList := TvtOutlinerWithDragDrop.Create(Self);
 with f_AvailableOperationsList do
 begin
  Parent := CenterPanel;
  Left := AvailableOperationsLabel.Left;
  Top := AvailableOperationsLabel.Top + AvailableOperationsLabel.Height+4;
  Width := AddBitBtn.Left - 4 - Left;
  Height := CenterPanel.Height - Top - 4;
  Anchors := [akLeft, akTop, akBottom];
  TabOrder := 0;
  ViewOptions := [voShowIcons];
  VJustify := vt_vjCenter;
  DragAndDropSupported := True;
  OnGetItemImage := GetListImage;
  OnActionElement := f_AvailableOperationsDblClick;
  OnCanBeginDrag := OperationsBeginDrag;
  OnCanAcceptData := AvailableDragAcceptData;
  OnDoDrop := Drop2AvailOperations;
 end;
 f_SelectedOperationsList := TvtOutlinerWithDragDrop.Create(Self);
 with f_SelectedOperationsList do
 begin
  Parent := CenterPanel;
  Width := f_AvailableOperationsList.Width;
  Height := f_AvailableOperationsList.Height;
  Left := SelectedOperationsLabel.Left;
  Top := f_AvailableOperationsList.Top;
  Anchors := [akLeft, akTop, akBottom];
  TabOrder := 3;
  ViewOptions := [voShowIcons];
  VJustify := vt_vjCenter;
  DragAndDropSupported := True;
  OnCurrentChanged := OpListChange;
  OnGetItemImage := GetListImage;
  OnActionElement := f_SelectedOperationsDblClick;
  OnCanBeginDrag := OperationsBeginDrag;
  OnCanAcceptData := SelectedDragAcceptData;
  OnDoDrop := Drop2SelectedOperations;
 end;
 f_AllOperationsList := TvtOutliner.Create(Self);
 with f_AllOperationsList do
 begin
  Parent := ShortCutsTabSheet;
  Width := 241;
  Height := 199;
  Left := AllOperationsLabel.Left;
  Top := AllOperationsLabel.Top+AllOperationsLabel.Height + 4;
  Width := ShortCutEdit.Left - Left - 10;
  Height := ShortCutsTabSheet.Height - Top - 4;
  Anchors := [akLeft, akRight, akTop, akBottom];
  TabOrder := 0;
  ViewOptions := [voShowIcons];
  VJustify := vt_vjCenter;
  OnGetItemImage := GetListImage;
  OnCurrentChanged := AllOperationsChange;
 end;
 vcmEntityFormResize(nil); // размещаем все на форме правильно
 (* Disabled *)
 btApply.Enabled := False;
 (* Список измененных *)
 f_ActionShortCutChanged := TvcmObjectList.Create;
 (* Игнорирование модификаций отключено *)
 f_IgnoreModifications := False;
 (* Кнопка "Восстановить" не видима *)
 RestoreBtnVisible := False;
end;

class function TCustomizeToolsForm.Execute(aMenuManager : TvcmBaseMenuManager;
                                               aDock        : TComponent): Boolean;
  {-}
var
 l_Form: TCustomizeToolsForm;
begin
 l_Form := Create(g_Dispatcher.FormDispatcher.CurrentMainForm.VCLWinControl);
 with l_Form do
  try
   f_ManualUpdate := true;
   Result := ExecutePrim(aMenuManager, aDock);
  finally
   vcmFree(l_Form);
  end;//try..finally
end;

procedure TCustomizeToolsForm.TuneBoxes;
  {-}
begin
 f_SelectedOperationsList.Images := vcmGetActionList.Images;
 ReleaseContainers(f_SelectedOperationsList);
 f_AvailableOperationsList.Images := vcmGetActionList.Images;
 ReleaseContainers(f_AvailableOperationsList);
 f_AllOperationsList.Images := vcmGetActionList.Images;
 ReleaseContainers(f_AllOperationsList);
end;

procedure TCustomizeToolsForm.FillObjects(aMenuManager    : TvcmBaseMenuManager;
                                             const aUserType : IvcmUserTypeDef);
  {-}
var
 l_FormList: TStringList;
 l_ItemIndex: Integer;
 l_AddedItemIndex: Integer;
 l_Index: Integer;
 l_UserTypeCaption: String;
 l_UTDescr: TvcmUserTypeDescr;
begin
 f_MenuManager := aMenuManager;
 f_UserTypeDescrList := vcmFormCustomize.GetUserTypeDescrList(aUserType, l_ItemIndex);

 f_IsFillingObjects := True;
 l_FormList := TStringList.Create;
 l_FormList.Duplicates := dupAccept;
 l_FormList.Sorted := True;
 try
  for l_Index := 0 to f_UserTypeDescrList.Count - 1 do
  begin
   l_UTDescr := f_UserTypeDescrList.Items[l_Index];
   l_UserTypeCaption := vcmFormCustomize.MakeUserTypeCaption(l_UTDescr.SettingsCaption,
    l_UTDescr.FormClass, nil, l_UTDescr.IsCustomizationInternal);
   l_FormList.AddObject(l_UserTypeCaption, TObject(l_Index));
  end;
  for l_Index := 0 to l_FormList.Count - 1 do
  begin
   l_AddedItemIndex := cbObject.Items.AddObject(l_FormList.Strings[l_Index],
    l_FormList.Objects[l_Index]);
   if (Integer(l_FormList.Objects[l_Index]) = l_ItemIndex) then
    cbObject.ItemIndex := l_AddedItemIndex;
  end;
 finally
  FreeAndNil(l_FormList);
  f_IsFillingObjects := False;
 end;
 //http://mdp.garant.ru/pages/viewpage.action?pageId=476079389
 UpdateEnableFlags;
end;

const
  cToolbar : array [TvcmEffectiveToolBarPos] of String =
   ('Верхняя', 'Нижняя', 'Левая', 'Правая');

procedure TCustomizeToolsForm.SetForm(aForm         : TvcmEntityForm;
                                         aToolbar      : TComponent;
                                         aNeedFreeForm : Boolean);
  {-}
var
 l_Pos   : TvcmEffectiveToolBarPos;
 //l_Poses : TvcmToolbarPoses;
 //l_Dock  : TvcmDockDef;
begin
 if (aForm <> nil) then
  Assert(aForm.CurUseToolbarOfUserType <> nil);
 if (aForm <> f_Form) then
 begin
  if f_NeedFreeForm AND (f_Form <> nil) then
  begin
   f_Form.SafeClose;
   f_Form := nil;
  end;//f_NeedFreeForm
  f_NeedFreeForm := aNeedFreeForm;
  f_Form := aForm;
  if (f_Form = nil) then
  begin
   f_UserType := nil;
   f_Toolbar := nil;
  end
  else
  begin
   f_UserType := f_Form.CurUseToolbarOfUserType;
   cbObject.Text := l3CStr(vcmFormCustomize.MakeUserTypeCaption(f_UserType.SettingsCaption,
    f_UserType.FormClass, aToolBar, TvcmUserTypeInfo.IsCustomizationInternal(f_UserType)));
   f_IsFillingToolbar := True;
   cbToolBar.Items.Clear;
   //l_Poses := f_Form.Toolbars;
   for l_Pos := Low(TvcmEffectiveToolBarPos) to High(TvcmEffectiveToolBarPos) do
    //if (l_Pos in l_Poses) then
     cbToolBar.Items.Add(ToolbarPosMap[l_Pos].AsStr);
   f_IsFillingToolbar := False;
  end;//f_Form = nil
 end//aForm <> f_Form
 else
 begin
  Assert(f_NeedFreeForm = aNeedFreeForm);
  if (f_Toolbar = aToolbar) then
   Exit;
 end;//aForm <> f_Form

 f_Toolbar := aToolbar;
 if (f_Toolbar <> nil) then
 begin
  with cbToolBar do
  begin
   ItemIndex := Items.IndexOf(ToolbarPosMap[TvcmToolbarDef(f_Toolbar).Pos].AsStr);
   Enabled := (Items.Count > 1);
  end;//with cbToolBar
  FillSelected;
  FillAvalailable;
  FillAll;
  UpdateEnableFlags;
  Modified := False;
 end;//f_Toolbar <> nil
end;

procedure TCustomizeToolsForm.FillSelected;

 procedure DoSelectedToolbar(aToolbar : TvcmToolbarDef);
 var
  l_Node     : IActionNode;
  l_Index    : Integer;
  l_Control  : TControl;
  l_ActionEx : TvcmActiveEntityActionEx;
  l_ActionOp : TvcmOperationAction;
 begin//DoSelectedToolbar
  l_ActionEx := nil;
  with aToolbar do
   for l_Index := 0 to Pred(OrderedControlsCount) do
   begin
    l_Control := OrderedControls[l_Index];
    if not (l_Control Is TvcmSeparatorDef) AND (l_Control.Action = nil) then
     continue;
    with f_SelectedOperationsList.CTree.CRootNode do
    begin
     if (l_Control Is TvcmSeparatorDef) then
      InsertChild(TActionNode.Make(nil, str_vcmSeparator.AsCStr, -1))
     else
     begin
      // (Action = nil) - проверили выше
      if (l_Control.Action Is TvcmActiveEntityActionEx) then
      begin
       l_ActionEx := TvcmActiveEntityActionEx(l_Control.Action);
       l_Node := InsertChild(TActionNode.Make(l_ActionEx.OpDef,
           TvcmEntityAction.Make(l_ActionEx.EntityDef,
                                     l_ActionEx.OpDef))) as IActionNode;
      end
      else
      begin
       l_Node := InsertChild(TActionNode.Make(l_Control.Action,
                 l3CStr(THackWinControl(l_Control).Caption),
                 (l_Control.Action As TCustomAction).ImageIndex)) as IActionNode;
      end;
      if l_Control.Action is TvcmOperationAction then
      begin
       l_ActionOp := l_Control.Action as TvcmOperationAction;
       if Assigned(l_ActionEx) then
        with l_ActionEx{TvcmEntityAction(l_Control.Action)} do
         l_Node.Text := l3PCharLen(vcmMakeCaption(EntityDef, OpDef))
       else
        l_Node.Text := l3PCharLen(l_ActionOp.OpDef.Caption);
       // - этим заклинанием превращаем "Документы" в "Правовой Навигатор".
       if (l_ActionOp.OpDef.OperationType in cIconTextTypes) and
          (l_Control is TvcmToolButtonDef) and
          (TvcmToolButtonDef(l_Control).IsIconText) then
        l_Node.SetIconText(True);
      end;
     end;//l_Control Is TvcmSeparatorDef
    end;//with
    // Не зануляли все вот это - в результате раскосячивались условия в теле цикла,
    // потому что в переменных оставались значения с прошлой итерации. 
    // Поэтому зануляем переменные после выполнения тела цикла.
    // http://mdp.garant.ru/pages/viewpage.action?pageId=353438994
    l_ActionEx := nil;
    l_ActionOp := nil;
   end;//for l_Index
 end;//DoSelectedToolbar

var
 l_Index : Integer;
begin//FillSelected
 ReleaseContainers(f_SelectedOperationsList);
 //lwSelectedOperations.Items.Clear;
 if (f_Toolbar Is TvcmDockDef) then
 begin
  with TvcmDockDef(f_Toolbar) do
   for l_Index := 0 to Pred(ControlCount) do
    DoSelectedToolbar(Controls[l_Index] As TvcmToolbarDef);
 end//f_Toolbar Is TvcmDockDef
 else if (f_Toolbar Is TvcmToolbarDef) then
  DoSelectedToolbar(TvcmToolbarDef(f_Toolbar));
 Modified := false;
end;//FillSelected

procedure TCustomizeToolsForm.FillAvalailable;
  {-}
begin
 FillOperations(f_AvailableOperationsList, true, false, false);
end;

procedure TCustomizeToolsForm.LoadGlyphSize;
var
 l_GlyphSize: TvcmGlyphSize;
 l_IgnoreModifications: boolean;
begin
 l_IgnoreModifications := f_IgnoreModifications;
 f_IgnoreModifications := True;
 try
  l_GlyphSize := (f_MenuManager as TvcmCustomMenuManager).GlyphSize;
  rbGlyphSizeAuto.Checked   := (l_GlyphSize = vcm_gsAutomatic);
  rbGlyphSizeSmall.Checked  := (l_GlyphSize = vcm_gs16x16);
  rbGlyphSizeMedium.Checked := (l_GlyphSize = vcm_gs24x24);
  rbGlyphSizeLarge.Checked  := (l_GlyphSize = vcm_gs32x32);
 finally
  f_IgnoreModifications := l_IgnoreModifications;
 end;
end;

procedure TCustomizeToolsForm.FillAll;
  {-}
begin
 f_IgnoreModifications := True;
 try
  FillOperations(f_AllOperationsList, false, true, true);
  LoadGlyphSize;
  LoadGlyphColordepth;
 finally
  f_IgnoreModifications := False;
 end; {try..finally}
end;

procedure TCustomizeToolsForm.FillOperations(aTarget : TvtCustomOutliner;
                                                aAvalailableOnly: Boolean;
                                                aResetShortcuts: boolean;
                                                aFillShortcuts: boolean);

  function RegetOp(const aCont: IUnknown; const aOp: IvcmOperationDef): TvcmBaseOperationsCollectionItem;
  Var
   l_Item: TvcmBaseCollectionItem;
   l_Entity: IvcmEntityDef;
   l_Module: IvcmModuleDef;
  begin
   Result := nil;
   if Supports(aCont, IvcmEntityDef, l_Entity) then
   begin
    l_Item := g_MenuManager.Entities.FindItemByID(l_Entity.ID);
    if l_Item is TvcmBaseEntitiesCollectionItem then
     with l_Item as TvcmBaseEntitiesCollectionItem do      
      Result := Operations.FindItemById(aOp.ID) as TvcmBaseOperationsCollectionItem;
   end;
   if Supports(aCont, IvcmModuleDef, l_Module) then
   begin
    l_Item := g_MenuManager.Modules.FindItemByID(l_Module.ID);
    if l_Item is TvcmModulesCollectionItem then
     with l_Item as TvcmModulesCollectionItem do      
      Result := Operations.FindItemById(aOp.ID) as TvcmBaseOperationsCollectionItem;
   end;
  end;

  procedure GetShortcuts(aAction: TvcmAction; const aCont: IUnknown;
                         const anOp: IvcmOperationDef);
  Var
   l_Item : TvcmBaseOperationsCollectionItem;
  begin
   l_Item := RegetOp(aCont, anOp);
   aAction.ShortCut := l_Item.ShortCut;
   aAction.SecondaryShortCuts.Assign(l_Item.SecondaryShortCuts);
  end;

 procedure AddAvalailable(const anOp : IvcmOperationDef;
                          anAction   : TvcmAction);

  function IsSelected(anAction: TvcmAction): Boolean;
  var
   l_Found: Boolean;

   function IteratorHandle(const aNode: Il3Node): Boolean;
   var
    lN: IActionNode;
   begin
    lN := aNode as IActionNode;
    Result := not ActionIsNil(lN) and ExtractAction(lN).EQ(anAction);
    l_Found := Result;
   end;

  begin//IsSelected
   l_Found := False;
   if aAvalailableOnly then
    f_SelectedOperationsList.CTree.CRootNode.IterateF(l3L2NA(@IteratorHandle), imCheckResult);
   Result := l_Found;
  end;//IsSelected

 begin//AddAvalailable
  if not IsSelected(anAction) then
    aTarget.CTree.CRootNode.InsertChild(TActionNode.Make(anOp, anAction) as Il3Node);
 end;//AddAvalailable

 function lp_IsOpEnable(const anOp : IvcmOperationDef): Boolean;
 begin
  // Операции без иконок не показываются в списке доступных, но показываются в
  // списке горячих клавишь:
  Result := anOp.VisibleToUser and
   ((aFillShortcuts and (anOp.OperationType in cShortcutTypes)) or
    (not aFillShortcuts and (anOp.OperationType in vcmVisualOperations)(* and
     (not (anOp.OperationType in vcmOperationsWithIcon) or (anOp.ImageIndex <> -1))*)
     ));
 end;

 function lp_ModuleOp(const aModule : IvcmModuleDef;
                      const anOp    : IvcmOperationDef): Boolean;
 var
  l_Action : TvcmAction;
 begin//DoOperation
  if (anOp <> nil) then
  begin
   Result := true;
   l_Action := TvcmModuleAction.Make(aModule, anOp);
   if aResetShortcuts then
    GetShortcuts(l_Action, aModule, anOp);
   if lp_IsOpEnable(anOp) then
    AddAvalailable(anOp, l_Action);
  end
  else
   Result := false;
 end;//DoOperation

 function lp_EntityOp(const anEntity : IvcmEntityDef;
                      const anOp     : IvcmOperationDef): Boolean;
 Var
  l_Action : TvcmAction;
 begin//DoOperation
  if (anOp <> nil) then
  begin
   Result := true;
   if not (f_Form.UserType in anOp.ExcludeUserTypes) and lp_IsOpEnable(anOp) then
   begin
    l_Action := TvcmEntityAction.Make(anEntity, anOp);
    if aResetShortcuts then
     GetShortcuts(l_Action, anEntity, anOp);
    AddAvalailable(anOp, l_Action);
   end;
  end
  else
   Result := false;
 end;//DoOperation

 function lp_AddTasksPanelGroupOp(const aOp: IvcmCustOpsGroupOperation): Boolean;
 var
  l_OpDef     : IvcmOperationDef;
  l_ModuleDef : IvcmModuleDef;
  l_EntityDef : IvcmEntityDef;
 begin
  Result := aOp <> nil;
  if Result then
   if Supports(aOp.RepOp, IvcmOperationDef, l_OpDef) then
   begin
    if Supports(aOp.RepOp, IvcmModuleDef, l_ModuleDef) then
     lp_ModuleOp(l_ModuleDef, l_OpDef)
    else
     if Supports(aOp.RepOp, IvcmEntityDef, l_EntityDef) then
      lp_EntityOp(l_EntityDef, l_OpDef)
     else
      Assert(False);
   end
   else
    Assert(False);
 end;

 function lp_AddTasksPanelGroupOps(const aGroup: IvcmCustOpsGroup): Boolean;
 var
  l_Op: IvcmCustOpsGroupOperation;
 begin
  Result := aGroup <> nil;
  if Result then
   with aGroup.Operations do
    while lp_AddTasksPanelGroupOp(Next) do ;
 end;

 procedure lp_AddTasksPanelGroups;
 var
  l_TasksPanel : IvcmCustOps;
  l_Form       : IvcmEntityForm;
 begin
  if Supports(f_Form, IvcmEntityForm, l_Form) then
  try
   l_TasksPanel := TvcmCustAvailableToolbarOps.Make(l_Form);
   try
    with l_TasksPanel.Groups do
     while lp_AddTasksPanelGroupOps(Next) do ;
   finally
    l_TasksPanel := nil;
   end;
  finally
   l_Form := nil;
  end
  else
   Assert(False);
 end;

 procedure lp_AddFromForm;

  procedure DoModules;

   procedure DoModule(const aModule : IvcmModuleDef);
   var
    l_Operations : IvcmOperationsDefIterator;
   begin//DoModule
    l_Operations := aModule.OperationsDefIterator;
    if Assigned(l_Operations) then
     while lp_ModuleOp(aModule, l_Operations.Next) do ;
   end;//DoModule

  var
   l_Index : Integer;
  begin//DoModules
   with g_Dispatcher do
    for l_Index := 0 to Pred(ModulesCount) do
     DoModule(Module[l_Index].ModuleDef);
  end;//DoModules

  function DoEntity(const anEntity: IvcmEntityDef): Boolean;
  var
   l_Operations : IvcmOperationsDefIterator;
  begin//DoEntity
   if (anEntity <> nil) then
   begin
    Result := true;
    l_Operations := anEntity.OperationsDefIterator;
    if l_Operations <> nil then
     while lp_EntityOp(anEntity, l_Operations.Next) do ;
   end
   else
    Result := false;
  end;//DoEntity

 var
  l_Entities: IvcmEntitiesDefIterator;
 begin
  if (f_Form Is TvcmMainForm) then
   DoModules;
  l_Entities := f_Form.GetEntitiesDefIterator;
  if (l_Entities <> nil) then
   while DoEntity(l_Entities.Next) do ;
 end;

begin//FillOperations
 if Assigned(aTarget) then
 begin
  ReleaseContainers(aTarget);
  //aTarget.Items.Clear;
  if aAvalailableOnly then
   aTarget.CTree.CRootNode.InsertChild(TActionNode.
    Make(nil, str_vcmSeparator.AsCStr, -1) as Il3Node);
  if aFillShortcuts then
   lp_AddFromForm
  else
   lp_AddTasksPanelGroups;
 end;//if Assigned(aTarget) then
end;//FillOperations

procedure TCustomizeToolsForm.SaveToolbars;
var
 l_DockName: string;
  {-}

 procedure FillToolbar(aForm           : TvcmEntityForm;
                       aToolbar        : TvcmToolbarDef;
                       const aUserType : IvcmUserTypeDef);
 var
  l_Index : Integer;
  l_Sep   : Boolean;

  function IsActionShortCutChanged(aAction : IActionNode) : Boolean;
  begin
   Result := Assigned(aAction) and Assigned(aAction.Action) and
    (f_ActionShortCutChanged.IndexOf(ExtractAction(aAction)) <> -1);
  end;

  procedure SaveActionIterator(const aNode: Il3Node);
  var
   l_Action     : TvcmAction;
   l_ActionNode : IActionNode;
  begin
   if Supports(aNode, IActionNode, l_ActionNode) then
   try
    (* сохраняем только если изменили, или если это разделитель *)
    l_Action := ExtractAction(l_ActionNode);
    if f_ToolbarChanged then
     vcmSaveToolbarAction(aUserType.Name,
                          aToolbar.Name,
                          l_Action,
                          False);
    if IsActionShortCutChanged(l_ActionNode) then
     UpdateShortCut(l_ActionNode);
   finally
    l_ActionNode := nil;
   end;//if Supports(aNode, IActionNode, l_ActionNode) then
  end;

  procedure SaveSelectedActionIterator(const aNode: Il3Node);
  var
   l_Action : TvcmAction;
   l_ActionNode : IActionNode;
  begin
   if Supports(aNode, IActionNode, l_ActionNode) then
   try
    l_Action := ExtractAction(l_ActionNode);
    if f_ToolbarChanged then
     vcmSaveToolbarAction(aUserType.Name,
                          aToolbar.Name,
                          l_Action,
                          true,
                          l_Index,
                          l_Sep,
                          ExtractIconText(aNode as IActionNode));
    if IsActionShortCutChanged(l_ActionNode) then
     UpdateShortCut(l_ActionNode);
    if (l_Action = nil) then
     l_Sep := true
    else
     l_Sep := false;
    Inc(l_Index);
   finally
    l_ActionNode := nil;
   end;//if Supports(aNode, IActionNode, l_ActionNode) then
  end;

 begin//FillToolbar
  f_AvailableOperationsList.CTree.CRootNode.IterateF(l3L2NA(@SaveActionIterator));
  f_AllOperationsList.CTree.CRootNode.IterateF(l3L2NA(@SaveActionIterator));
  l_Sep := false;
  l_Index := 0;
  f_SelectedOperationsList.CTree.CRootNode.IterateF(l3L2NA(@SaveSelectedActionIterator));
 end;//FillToolbar

 procedure lp_UpdateFormsUseCurrentToolbar;
  // В результате объединения панелей инструментов, после применения настройки
  // необходимо обновлять связанные формы:

   procedure lp_ApplyChanges(const aForm: IvcmEntityForm);
   begin
    if (aForm.VCLWinControl As TvcmEntityForm).FormID.EQ(f_Form.FormID) and
      (aForm.CurUseToolbarOfUserType.ID = f_Form.CurUseToolbarOfUserType.ID) then
     with (aForm.VCLWinControl As TvcmEntityForm) do
     begin
      ReloadToolbars;
      ManualUpdateActions;
     end;//with (aForm.VCLWinControl As TvcmEntityForm)
   end;

 var
  l_Index : Integer;
  l_Form  : IvcmEntityForm;
 begin
  // Главные формы:
  if Supports(f_Form, IvcmMainForm) then
  begin
   for l_Index := 0 to Pred(Dispatcher.FormDispatcher.MainFormsCount) do
    if Supports(Dispatcher.FormDispatcher.
      MainForm[l_Index], IvcmEntityForm, l_Form) then
     lp_ApplyChanges(l_Form);
  end
  // Формы:
  else
   for l_Index := 0 to Pred(Dispatcher.EntitiesCount) do
    if Supports(Dispatcher.Entity[l_Index], IvcmEntityForm, l_Form) then
     lp_ApplyChanges(l_Form);
 end;

begin//SaveToolbars
 if Modified then
 begin
  g_MenuManager.BeginOp;
  try
   (* Сохраним shortcut-ы и состав toolbar-ов *)
   if (f_ActionShortCutChanged.Count > 0) or f_ToolbarChanged then
    FillToolbar(f_Form, f_Toolbar As TvcmToolbarDef, f_UserType);
   (* Размер иконок *)
   TvcmToolbarGlyphService.Instance.SetGlyphSize(GetCheckedGlyphSize);
   (* Глубина цвета иконок *)
   TvcmToolbarGlyphService.Instance.SetGlyphColorDepth(GetCheckedColorDepth);
   (* Создадим заново toolbar-ы *)
   if f_ToolbarChanged then
   begin
    l_DockName := f_Toolbar.Name;
    lp_UpdateFormsUseCurrentToolbar;
     // - обновим формы использующие ту же самую панель инструментов;
    f_Toolbar := f_Form.FindComponent(l_DockName);
   end;//if f_ToolbarChanged then
   (* Сбросим флаги *)
   f_ActionShortCutChanged.Clear;
   Modified := false;
  finally
   g_MenuManager.EndOp;
  end;//try..finally
 end;//if Modified then
end;//SaveToolbars

function TCustomizeToolsForm.ExecutePrim(aMenuManager : TvcmBaseMenuManager;
                                             aToolbar     : TComponent): Boolean;
  {-}
var
 l_Form : TvcmEntityForm;
begin
 Result := False;
 if (aMenuManager Is TvcmCustomMenuManager) then
 begin
  if (aToolbar <> nil) and not (aToolbar is TvcmDockDef) then
  begin
   while (aToolbar <> nil) and not (aToolbar is TvcmToolbarDef) do
    aToolbar := TControl(aToolbar).Parent;

   if aToolbar = nil then
    exit;
   // раньше была именно такая логика. не знаю, бывают ли сейчас такие случаи
  end;

  Assert(TvcmCustomMenuManager(aMenuManager).OneToolbarPerForm,
         '- проверка бредовая, просто я пока не понимаю как грузить несколько Toolbar''ов');

  pnToolbar.Visible := false;
  ResetAllToDefaultButton.Visible := true;
  // Редактируемая панель инструментов может быть не определена когда диалог
  // вызывается из настроек конфигурации, не с помощью выпадающего меню панели
  // "Настройка...":
  f_IsNeedDefineToolbar := True;
  if (aToolbar <> nil) and (aToolbar is TvcmToolbarDef) then
  begin
   f_Toolbar := aToolbar;
   f_IsNeedDefineToolbar := False;
   l_Form := TvcmEntityForm(aToolbar.Owner);
   FillObjects(aMenuManager, l_Form.CurUseToolbarOfUserType);
  end
  else
   FillObjects(aMenuManager);
  TuneBoxes;
  if cbObject.Items.Count > 0 then
  begin
   Modified := false;
   cbObjectChange(cbObject);
  end;

  Result := ShowModal = mrOk;
  if Result then
   SaveToolbars;
 end;
end;

procedure TCustomizeToolsForm.AddBitBtnClick(Sender: TObject);
begin
 MoveSelected(f_SelectedOperationsList, f_AvailableOperationsList);
end;

procedure TCustomizeToolsForm.RemoveBitBtnClick(Sender: TObject);
begin
 MoveSelected(f_AvailableOperationsList, f_SelectedOperationsList);
end;

procedure TCustomizeToolsForm.UpBitBtnClick(Sender: TObject);
begin
 MoveSelectedA(f_SelectedOperationsList, true);
 UpdateEnableFlags;
end;

procedure TCustomizeToolsForm.DownBitBtnClick(Sender: TObject);
begin
 MoveSelectedA(f_SelectedOperationsList, false);
 UpdateEnableFlags;
end;

function TCustomizeToolsForm.pm_GetModified: Boolean;
  {-}
begin
 Result := f_Modified;
end;

function TCustomizeToolsForm.pm_GetRestoreBtnVisible : Boolean;
{-}
begin
 Result := ResetToDefaultButton.Visible;
end;

procedure TCustomizeToolsForm.pm_SetRestoreBtnVsible(const aValue : Boolean);
{-}
begin
 ResetToDefaultButton.Visible := aValue;
 // Кнока "Восстановить все" после кнопки "Восстановить"
 if aValue then
  ResetAllToDefaultButton.Left := ResetToDefaultButton.Left +
   ResetToDefaultButton.Width
 // Кнока "Восстановить все" на месте кнопки "Восстановить"
 else
  ResetAllToDefaultButton.Left := ResetToDefaultButton.Left;
end;

procedure TCustomizeToolsForm.pm_SetModified(aValue: Boolean);
  {-}
begin
 f_Modified := aValue;
 if (ResetToDefaultButton.Enabled <> aValue) then
  ResetToDefaultButton.Enabled := aValue;
 if (btApply.Enabled <> aValue) then
  btApply.Enabled := aValue;
end;

procedure TCustomizeToolsForm.UpdateEnableFlags;
var
 l_Node   : IActionNode;
 l_Action : TvcmOperationAction;
begin
 f_ManualUpdate := false;
 try
  l_Node := (f_AllOperationsList.CurrentCNode as IActionNode);
  AddBitBtn.Enabled := (l_Node <> nil);
 //
  l_Node := (f_SelectedOperationsList.CurrentCNode as IActionNode);
  if (l_Node = nil) then
  begin
   RemoveBitBtn.Enabled := false;
   UpBitBtn.Enabled := false;
   DownBitBtn.Enabled := false;
   WhotShowRadioGroup.Enabled := false;
  end
  else
  begin
   RemoveBitBtn.Enabled := true;
   if ActionIsNil(l_Node) or not (ExtractAction(l_Node) is TvcmOperationAction) then
   begin
    cbIcon.Checked := true;
    WhotShowRadioGroup.Enabled := false
   end
   else
   begin
    l_Action := ExtractAction(l_Node) as TvcmOperationAction;
    WhotShowRadioGroup.Enabled := (l_Action.OpDef.OperationType in cIconTextTypes) and
                                   (l_Action.OpDef.ImageIndex <> -1);
    if l_Action.OpDef.OperationType in cIconTextTypes then
    begin
     if ExtractIconText(l_Node) then
      cbTextAndIcon.Checked := true
     else
      cbIcon.Checked := true;
    end
    else
     cbIcon.Checked := true;
   end;
   UpBitBtn.Enabled := not l_Node.IsFirst;
   DownBitBtn.Enabled := not l_Node.IsLast;
  end;
 finally
  f_ManualUpdate := true;
 end;
end;


procedure TCustomizeToolsForm.f_AvailableOperationsDblClick(Sender: TObject; Index : Longint);
begin
 MoveSelected(f_SelectedOperationsList, f_AvailableOperationsList);
end;

procedure TCustomizeToolsForm.f_SelectedOperationsDblClick(Sender: TObject; Index : Longint);
begin
 MoveSelected(f_AvailableOperationsList, f_SelectedOperationsList);
end;

procedure TCustomizeToolsForm.cbObjectChange(Sender: TObject);
begin
 // vtComboBoxQS вызывает событие OnChange при заполнении списка,
 // из-за чего возникает ошибка
 if f_IsFillingObjects then
  Exit;
 if Modified then
 begin
  if vcmShowMessageDlg(Tl3Message_C(l3CStr(ConfirmSavaLabel.Caption),
                                    'TCustomizeToolsForm.cbObjectChange',
                                    mtConfirmation,
                                    [mbYes, mbNo])) = mrYes then
   SaveToolbars;
 end;//Modified
 // http://mdp.garant.ru/pages/viewpage.action?pageId=460277543
 ShowUserType(GetSelectedUserType);
 FillAvalailable;
 FillSelected;
 //http://mdp.garant.ru/pages/viewpage.action?pageId=476079389
 UpdateEnableFlags;
end;

procedure TCustomizeToolsForm.ReloadData;
var
 l_UserType: IvcmUserTypeDef;
begin
 cbObjectChange(Self);
 // http://mdp.garant.ru/pages/viewpage.action?pageId=460277543
 l_UserType := GetSelectedUserType;
 Assert(l_UserType <> nil);
 f_IsNeedDefineToolbar := true;
 ShowUserType(l_UserType, True);
end;

procedure TCustomizeToolsForm.ResetToDefaultButtonClick(
  Sender: TObject);
begin
 ReloadData;
end;

procedure TCustomizeToolsForm.btApplyClick(Sender: TObject);
begin
 SaveToolbars;
end;

procedure TCustomizeToolsForm.cbToolBarChange(Sender: TObject);
var
 l_Pos : TvcmEffectiveToolBarPos;
begin
 if f_IsFillingToolBar then
  Exit;
 for l_Pos := Low(TvcmEffectiveToolBarPos) to High(TvcmEffectiveToolBarPos) do
 begin
  if l3Same(ToolbarPosMap[l_Pos].AsCStr, cbToolbar.Text, true) then
  begin
   SetForm(f_Form,
           (f_MenuManager As TvcmCustomMenuManager).BuildToolbar(f_Form, l_Pos),
           f_NeedFreeForm);
   break;
  end;//ANSISame(ToolbarPosMap[l_Pos].AsCStr, cbToolbar.Text
 end;//for l_Pos
end;

procedure TCustomizeToolsForm.ShortCutEditChange(Sender: TObject);
var
 l_Node   : IActionNode;
 l_Result : Boolean;
begin
 ShortCutEdit.Brush.Color := clWindow;
 l_Result := false;
 l_Node := (f_AllOperationsList.CurrentCNode as IActionNode);
 if (ShortCutEdit.ShortCut <> 0) and Assigned(l_Node) and not ActionIsNil(l_Node) then
  if AddShortCut(l_Node, ShortCutEdit.ShortCut, true) then
   l_Result := true
  else
   ShortCutEdit.Brush.Color := clRed;
 AddButton.Enabled := l_Result;
 ClearShortcutButton.Enabled := ShortCutEdit.Text <> '';
end;

procedure TCustomizeToolsForm.AllOperationsChange(Sender : TObject; aNewCurrent : Longint;  aOldCurrent : Longint);
begin
 UpdateShortCutItemState;
end;

procedure TCustomizeToolsForm.AddButtonClick(Sender: TObject);
var
 l_Node : IActionNode;
begin
 l_Node := f_AllOperationsList.CurrentCNode as IActionNode;
 if (ShortCutEdit.ShortCut <> 0) and Assigned(l_Node) and not ActionIsNil(l_Node) then
 begin
  AddShortCut(l_Node, ShortCutEdit.ShortCut);
  AddChangedShortCut(ExtractAction(l_Node));
  UpdateShortCutItemState;
  Modified := true;
 end;
end;

procedure TCustomizeToolsForm.UpdateShortCutItemState;
var
 i        : Integer;
 l_Node   : IActionNode;
 l_Action : TvcmAction;
begin
 l_Action := nil;
 AddButton.Enabled := false;
 ClearShortcutButton.Enabled := false;
 RemoveButton.Enabled := false;
 ShortCutEdit.Brush.Color := clWindow;
 lwShortCuts.Clear;
 ShortCutEdit.ShortCut := TShortCut(0);
 l_Node := f_AllOperationsList.CurrentCNode as IActionNode;
 if Assigned(l_Node) then
  if not ActionIsNil(l_Node) then
   l_Action := ExtractAction(l_Node);
 if Assigned(l_Action) then
 begin
  ShortCutEdit.Enabled := true;
  DescriptionContentLabel.CCaption := TvcmOperationAction(l_Action).OpDef.LongHint;
  if l_Action.ShortCut <> 0 then
   lwShortCuts.Items.Add.Caption := ShortCutToTextExt(l_Action.ShortCut);
  for i := 0 to l_Action.SecondaryShortCuts.Count - 1 do
   lwShortCuts.Items.Add.Caption := ShortCutToTextExt(l_Action.SecondaryShortCuts.ShortCuts[i]);
 end
 else
 begin
  ShortCutEdit.Enabled := false;
  DescriptionContentLabel.Caption := '';
 end;
end;

procedure TCustomizeToolsForm.lwShortCutsChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
 if Assigned(lwShortCuts.Selected) then
  RemoveButton.Enabled := true
 else
  RemoveButton.Enabled := false;
end;

procedure TCustomizeToolsForm.RemoveButtonClick(Sender: TObject);
var
 i         : Integer;
 l_Node    : IActionNode;
 l_Action  : TvcmAction;
 l_SortCut : TShortCut;
begin
 l_Action := nil;
 l_SortCut := 0;
 if Assigned(lwShortCuts.Selected) then
  l_SortCut := TextToShortCut(lwShortCuts.Selected.Caption);
 if l_SortCut <> 0 then
 begin
  l_Node := f_AllOperationsList.CurrentCNode as IActionNode;
  if Assigned(l_Node) and not ActionIsNil(l_Node) then
    l_Action := ExtractAction(l_Node);
 end;
 if Assigned(l_Action) then
 begin
  with l_Action do
  begin
   if l_SortCut = ShortCut then
   begin
    if SecondaryShortCuts.Count > 0 then
    begin
     l_SortCut := SecondaryShortCuts.ShortCuts[0];
     SecondaryShortCuts.Delete(0);
     ShortCut := l_SortCut;
    end
    else
     ShortCut := 0;
   end
   else
    for i := 0 to SecondaryShortCuts.Count - 1 do
     if SecondaryShortCuts.ShortCuts[i] = l_SortCut then
     begin
      SecondaryShortCuts.Delete(i);
      break;
     end;
  end;
  UpdateShortCutItemState;
  AddChangedShortCut(l_Action);
  Modified := true;
 end;
end;

procedure TCustomizeToolsForm.WhotShowRadioGroupClick(Sender: TObject);
Var
 l_Node : IActionNode;
begin
 l_Node := f_SelectedOperationsList.CurrentCNode as IActionNode;
 if f_ManualUpdate and Assigned(l_Node) then
 begin
  if l_Node.GetIconText <> (cbTextAndIcon.Checked) then
  begin
   l_Node.SetIconText(cbTextAndIcon.Checked);
   Modified := true;
   f_ToolbarChanged := true;
  end;
 end;
end;

procedure TCustomizeToolsForm.Cleanup;
begin
 inherited;
 vcmFree(f_UserTypeDescrList);
 vcmFree(f_ActionShortCutChanged);
 ReleaseContainers(f_SelectedOperationsList);
 ReleaseContainers(f_AvailableOperationsList);
 ReleaseContainers(f_AllOperationsList);
 SetForm(nil, nil, false);
end;

procedure TCustomizeToolsForm.ResetAllToDefaultButtonClick(Sender: TObject);
Var
 l_OldCursor    : TCursor;
 l_Index        : integer;
 l_NeedFreeForm : boolean;
 l_Form         : TvcmEntityForm;
 l_Pos          : TvcmEffectiveToolBarPos;
 l_Toolbar      : TvcmToolbarDef;
begin
 if (vcmShowMessageDlg(Tl3Message_C(str_vcmAskResoreToolbar,
                                    mtConfirmation,
                                    [mbYes, mbNo])) <> mrYes) then
  exit;

 afw.ProcessMessages;
 l_OldCursor := Screen.Cursor;
 Screen.Cursor := crHourGlass;
 f_MenuManager.BeginOp;
 try
  (* Восстановим размер иконок *)
  TvcmCustomMenuManager(g_MenuManager).RestoreGlyphSize;
  LoadGlyphSize;
  TvcmCustomMenuManager(g_MenuManager).RestoreGlyphColordepth;
  LoadGlyphColordepth;
  with (f_MenuManager As TvcmCustomMenuManager).UserTypes do
   for l_Index := 0 to Hi do
    with Items[l_Index] do
    begin
     l_Form := vcmFormCustomize.MakeVirtualForm(Items[l_Index], l_NeedFreeForm);
     for l_Pos := Low(TvcmEffectiveToolBarPos) to High(TvcmEffectiveToolBarPos) do
     begin
      l_Toolbar := (f_MenuManager As TvcmCustomMenuManager).BuildToolbar(l_Form as TvcmEntityForm, l_Pos);
      if l_Toolbar <> nil then
       vcmCleanToolbar(Name, l_Toolbar.Name);
     end;
     if l_NeedFreeForm then
      l_Form.SafeClose;
    end;//with Items[l_Index]

  vcmDispatcher.ReloadAllToolbars;

  g_MenuManager.LoadShortcuts(true);

  Modified := false;
  ReloadData;
 finally
  Screen.Cursor := l_OldCursor;
  f_MenuManager.EndOp;
 end;
end;

procedure TCustomizeToolsForm.ShowUserType(const aUserType     : IvcmUserTypeDef;
                                              const aForceSetForm : Boolean);
Var
 l_VForm        : TvcmEntityForm;
 l_Toolbar      : TComponent;
 l_Pos          : TvcmEffectiveToolBarPos;
 l_NeedFreeForm : Boolean;
begin
 if aForceSetForm or (f_Form = nil) OR not f_Form.InheritsFrom(aUserType.FormClass) OR
    (f_Form.CurUseToolbarOfUserType.ID <> aUserType.ID) then
 begin
  Assert(aUserType.FormClass.InheritsFrom(TvcmEntityForm));
  l_NeedFreeForm := false;
  l_VForm := vcmFormCustomize.MakeVirtualForm(aUserType, l_NeedFreeForm);
  try
   // Нужно определить toolbar
   if f_IsNeedDefineToolbar then
   begin
    for l_Pos := Low(TvcmEffectiveToolBarPos) to High(TvcmEffectiveToolBarPos) do
    begin
     l_Toolbar := (f_MenuManager As TvcmCustomMenuManager).BuildToolbar(l_VForm, l_Pos);
     if (l_Toolbar <> nil) then
      break;
    end//for l_Pos
   end//if f_IsNeedDefineToolbar then
   // При первом открытии toolbar передается для редактирования, используем его
   else
   begin
    l_Toolbar := f_Toolbar;
    f_IsNeedDefineToolbar := True;
   end;//if f_IsNeedDefineToolbar then
   Assert(l_Toolbar <> nil);
   if aForceSetForm then
    l_NeedFreeForm := f_NeedFreeForm;
   SetForm(l_VForm, l_Toolbar, l_NeedFreeForm);
  except
   if l_NeedFreeForm then
    l_VForm.SafeClose;
   raise;
  end;//try..except
 end;//f_Form = nil..
end;

procedure TCustomizeToolsForm.ClearShortcutButtonClick(Sender: TObject);
begin
 ShortCutEdit.Text := '';
 ShortCutEdit.Brush.Color := clWindow; 
end;

function TCustomizeToolsForm.GetListImage(Sender : TObject; Index : Longint; var aImages : TCustomImageList):
    Integer;
var
 l_Node: IActionNode;
begin
 l_Node := TvtCustomOutliner(Sender).GetNode(Index) as IActionNode;
 Result := l_Node.GetImageIndex;
 if Result = -1 then
  Result := vtItemWithHollowImage;
end;

procedure TCustomizeToolsForm.OperationsBeginDrag(const aNode: Il3SimpleNode; var aOkEffect: Longint);
begin
 //
end;

function TCustomizeToolsForm.SelectedDragAcceptData(const aData: IDataObject): Boolean;
begin
 Result := True;
end;

procedure TCustomizeToolsForm.OpListChange(Sender : TObject; aNewCurrent : Longint;  aOldCurrent : Longint);
begin
 UpdateEnableFlags;
end;

function TCustomizeToolsForm.AvailableDragAcceptData(const aData: IDataObject): Boolean;
var
 lNode: Il3Node;
begin
 Result := False;
 if Supports(aData, Il3Node, lNode) then
  Result := (lNode.ParentNode as Il3RootNode) = f_SelectedOperationsList.CTree.CRootNode;
end;

function TCustomizeToolsForm.Drop2AvailOperations(const aData  : Il3SimpleNode;
                                                     aWantMenu    : Boolean;
                                                     var dwEffect : Longint): Boolean;
var
 lNode: Il3Node;
 lActNode: IActionNode;
begin
 Result := True;
 if Supports(aData, Il3Node, lNode) and Supports(lNode, IActionNode, lActNode) then
 begin
  lActNode.Remove;
  if lActNode.GetAction <> nil then
   with f_AvailableOperationsList do
   begin
    CTree.CRootNode.InsertChildBefore(GetNode(HighLighted) as Il3Node, lNode);
    Current := CTree.GetIndex(lNode);
   end;
  f_ToolbarChanged := True;
  Modified := true;
 end;
end;

function TCustomizeToolsForm.Drop2SelectedOperations(const aData  : Il3SimpleNode;
                                                        aWantMenu    : Boolean;
                                                        var dwEffect : Longint): Boolean;
var
 lFromSelected: Boolean;
 lDropToNode: Il3Node;
 lNode: Il3Node;
 lActNode: IActionNode;
begin
 Result := True;
 with f_SelectedOperationsList do
 if Supports(aData, Il3Node, lNode) and Supports(lNode, IActionNode, lActNode) then
 begin
  with f_SelectedOperationsList do
  begin
   lDropToNode := GetNode(HighLighted) as Il3Node;
   lFromSelected := lActNode.ParentNode = CTree.CRootNode;
  end;
  if lDropToNode = lNode then
   Exit;
  if (lActNode.GetAction <> nil) or (lFromSelected) then
   lActNode.Remove
  else
   lActNode := TActionNode.Make(nil, str_vcmSeparator.AsCStr, -1);
  with f_SelectedOperationsList do
  begin
   CTree.CRootNode.InsertChildBefore(lDropToNode, lActNode);
   Current := CTree.GetIndex(lActNode);
  end;
  f_ToolbarChanged := True;
  Modified := true;
 end;
end;

procedure TCustomizeToolsForm.vcmEntityFormResize(Sender: TObject);
var
 l_GroupWidth,
 l_GroupOffset,
 l_GroupHeight : Integer;
begin
 //l_GroupHeight := WhotShowRadioGroup.Top - UpBitBtn.Top + WhotShowRadioGroup.Height;
 //l_GroupOffset := (f_SelectedOperationsList.Height - l_GroupHeight) div 2;
 //l_GroupOffset := (f_SelectedOperationsList.Top + l_GroupOffset) - UpBitBtn.Top;
 //UpBitBtn.Top := UpBitBtn.Top + l_GroupOffset;
 //DownBitBtn.Top := DownBitBtn.Top + l_GroupOffset;
 //WhotShowRadioGroup.Top := WhotShowRadioGroup.Top + l_GroupOffset;
//
 if (f_SelectedOperationsList <> nil) then
 begin
  l_GroupHeight := RemoveBitBtn.Top - AddBitBtn.Top + RemoveBitBtn.Height;
  l_GroupOffset := (f_SelectedOperationsList.Height - l_GroupHeight) div 2;
  l_GroupOffset := (f_SelectedOperationsList.Top + l_GroupOffset) - AddBitBtn.Top - 35;
  AddBitBtn.Top := AddBitBtn.Top + l_GroupOffset;
  RemoveBitBtn.Top := RemoveBitBtn.Top + l_GroupOffset;
  UpBitBtn.Top := AddBitBtn.Top;
  DownBitBtn.Top := RemoveBitBtn.Top;
 end;
//
 if (f_AvailableOperationsList <> nil) then
 begin
  l_GroupWidth := (WhotShowRadioGroup.Left - f_AvailableOperationsList.Left*4 - AddBitBtn.Width) div 2;
  f_AvailableOperationsList.Width := l_GroupWidth;
  AddBitBtn.Left := f_AvailableOperationsList.Left*2 + l_GroupWidth;
  RemoveBitBtn.Left := AddBitBtn.Left;
  f_SelectedOperationsList.Left := AddBitBtn.Left + AddBitBtn.Width + f_AvailableOperationsList.Left;
  f_SelectedOperationsList.Width := l_GroupWidth;
  SelectedOperationsLabel.Left := f_SelectedOperationsList.Left +
   (AvailableOperationsLabel.Left - f_AvailableOperationsList.Left)
 end;
 //AddBitBtn.Left := f_AvailableOperationsList.Left+f_AvailableOperationsList.Width + 4;
 //RemoveBitBtn.Left := AddBitBtn.Left; 
end;

procedure TCustomizeToolsForm.rgGlyphSizeClick(Sender: TObject);
begin
 if not f_IgnoreModifications then
  Modified := True;
end;

procedure TCustomizeToolsForm.rgGlyphColorClick(Sender: TObject);
begin
 if not f_IgnoreModifications then
  Modified := True;
end;

procedure TCustomizeToolsForm.LoadGlyphColordepth;
var
 l_GlyphColorDepth : TvcmGlyphColorDepth;
begin
 l_GlyphColorDepth := TvcmToolbarGlyphService.Instance.GetGlyphColordepth;

 rbGlyphColorAuto.Checked := (l_GlyphColorDepth = vcm_gcAuto);
 rbGlyphColor16.Checked   := (l_GlyphColorDepth = vcm_gc16);
 rbGlyphColor256.Checked  := (l_GlyphColorDepth = vcm_gc256);
 rbGlyphColorFull.Checked := (l_GlyphColorDepth = vcm_gcTrueColor);
end;

procedure TCustomizeToolsForm.vcmEntityFormRefCreate(Sender: TObject);
begin
 IconSizeComboBox.Visible := False;
 IconSizeComboBox.Text := l3CStr('крупный');
end;

function TCustomizeToolsForm.GetCheckedColorDepth: TvcmGlyphColorDepth;
begin
 if rbGlyphColorAuto.Checked then
  Result := vcm_gcAuto
 else
 if rbGlyphColor16.Checked then
  Result := vcm_gc16
 else
 if rbGlyphColor256.Checked then
  Result := vcm_gc256
 else
 if rbGlyphColorFull.Checked then
  Result := vcm_gcTrueColor
 else
  Result := vcm_gcAuto;
end;

function TCustomizeToolsForm.GetSelectedUserType: IvcmUserTypeDef;
// http://mdp.garant.ru/pages/viewpage.action?pageId=460277543
const
 c_DividerDash = ' - ';
var
 l_UserTypeName: Il3CString;
 l_DashPos: Integer;
 l_UserTypeDescrIndex: Integer;
begin
 l_UserTypeDescrIndex := Integer(cbObject.Items[cbObject.ItemIndex].LinkedObject);
 l_UserTypeName := l3CStr(f_UserTypeDescrList.Items[l_UserTypeDescrIndex].SettingsCaption);
 Result := vcmFormCustomize.FindUserTypeByCaption(l3Str(l_UserTypeName),
  f_UserTypeDescrList.Items[l_UserTypeDescrIndex].FormClass);
end;

function TCustomizeToolsForm.GetCheckedGlyphSize: TvcmGlyphSize;
begin
 if rbGlyphSizeAuto.Checked then
  Result := vcm_gsAutomatic
 else
 if rbGlyphSizeSmall.Checked then
  Result := vcm_gs16x16
 else
 if rbGlyphSizeMedium.Checked then
  Result := vcm_gs24x24
 else
 if rbGlyphSizeLarge.Checked then
  Result := vcm_gs32x32
 else
  Result := vcm_gsAutomatic;
end;

end.