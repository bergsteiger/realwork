unit k2Tags;
{* Описание идентификаторов стандартных тегов и типов. }

{ Библиотека "K-2"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: k2Tags - }
{ Начат: 05.05.1998 09:54 }
{ $Id: k2Tags.pas,v 1.203 2015/04/21 07:06:53 dinishev Exp $ }

// $Log: k2Tags.pas,v $
// Revision 1.203  2015/04/21 07:06:53  dinishev
// {Requestlink:596845383}
//
// Revision 1.202  2014/07/01 12:21:19  lulin
// - пытаемся собрать несобирающееся.
//
// Revision 1.201  2014/06/26 16:52:40  lulin
// - работаем над инфраструктурой заворачивания тегов в таски.
//
// Revision 1.200  2014/06/25 15:24:32  lulin
// - делаем регистрацию атрибутов в отдельном списке.
//
// Revision 1.199  2014/06/25 14:19:45  lulin
// - делаем регистрацию атрибутов в отдельном списке.
//
// Revision 1.198  2014/03/03 16:07:51  lulin
// - избавляемся от странностей.
//
// Revision 1.197  2013/10/22 16:21:05  lulin
// - реорганизуем таблицу тегов, чтобы избавится от "шаманства" и идентификаторами.
//
// Revision 1.196  2013/10/17 17:15:58  lulin
// - работа по избавлению от ненужного Enum.
//
// Revision 1.195  2013/10/17 15:52:42  lulin
// - работа по избавлению от ненужного Enum.
//
// Revision 1.194  2013/10/16 17:10:55  lulin
// - bug fix: не работало без персистентного идентификатора типа.
//
// Revision 1.193  2013/10/16 16:33:55  lulin
// {RequestLink:280859697}.
//
// Revision 1.192  2013/10/16 12:21:56  lulin
// {RequestLink:280859697}.
//
// Revision 1.191  2013/09/13 14:42:08  lulin
// - добавляем новый тип документа.
//
// Revision 1.190  2013/06/19 16:51:09  lulin
// {RequestLink:461701432}.
//
// Revision 1.189  2012/10/26 16:44:14  lulin
// - вычищаем поддержку ветки редактора.
//
// Revision 1.188  2012/05/24 13:52:09  lulin
// {RequestLink:360022952}
//
// Revision 1.187  2012/02/29 08:32:39  lulin
// {RequestLink:336664105}
//
// Revision 1.186  2012/01/30 13:18:35  lulin
// {RequestLink:332563400}
//
// Revision 1.185  2011/11/29 17:34:22  lulin
// {RequestLink:232098711}.
// - делим дерево редакций на группы.
//
// Revision 1.184  2011/11/15 18:31:13  lulin
// {RequestLink:232098711}
//
// Revision 1.183  2011/10/17 11:59:24  lulin
// {RequestLink:294258021}.
//
// Revision 1.182  2011/09/07 17:48:29  lulin
// {RequestLink:278837795}.
//
// Revision 1.181  2011/08/30 12:14:37  lulin
// {RequestLink:280859680}.
//
// Revision 1.180  2011/08/02 16:42:38  lulin
// {RequestLink:272663564}.
//
// Revision 1.179  2011/07/26 13:22:36  lulin
// {RequestLink:275780190}.
//
// Revision 1.178  2011/07/20 11:16:01  lulin
// {RequestLink:228688745}.
//
// Revision 1.177  2011/07/07 16:45:56  lulin
// {RequestLink:228688745}.
//
// Revision 1.176  2011/07/05 19:06:22  lulin
// {RequestLink:254944102}.
//
// Revision 1.175  2011/06/20 15:22:21  lulin
// {RequestLink:269083814}
//
// Revision 1.174  2011/05/23 15:33:31  lulin
// {RequestLink:266423791}.
//
// Revision 1.173  2011/03/02 18:29:15  lulin
// {RequestLink:254353230}.
//
// Revision 1.172  2011/02/22 13:57:42  lulin
// {RequestLink:182157315}.
//
// Revision 1.171  2010/11/24 11:12:24  lulin
// {RequestLink:238945411}.
//
// Revision 1.170  2010/11/18 12:20:59  lulin
// {RequestLink:242516109}.
//
// Revision 1.169  2010/09/03 12:04:59  dinishev
// [$234359474]
//
// Revision 1.168  2010/06/25 08:17:26  lulin
// {RequestLink:182452717}.
// - bug fix: не был определён тип ContentsElement.
//
// Revision 1.167  2010/03/25 10:57:38  lulin
// {RequestLink:199590272}.
//
// Revision 1.166  2010/03/18 15:37:53  lulin
// {RequestLink:197497243}.
// - заводим тег.
//
// Revision 1.165  2010/02/11 14:13:58  lulin
// {RequestLink:190679656}.
//
// Revision 1.164  2009/11/11 14:21:16  lulin
// - добавляем тег для определения формата таблиц.
//
// Revision 1.163  2009/08/20 10:36:51  lulin
// - "простому" документу заводим собственный тип параграфов.
//
// Revision 1.162  2009/07/15 16:24:30  lulin
// - убираем лишние проверки.
//
// Revision 1.161  2009/07/15 15:12:26  lulin
// - удалено ненужное свойство списков параграфов.
//
// Revision 1.160  2009/07/09 19:11:21  lulin
// {RequestLink:141264340}. №10.
//
// Revision 1.159  2009/06/09 16:19:34  lulin
// - делаем возможность сохранять признак попадания в оглавление.
//
// Revision 1.158  2009/06/09 15:41:06  lulin
// - выделяем специальные структурны элементы, служащие "маркерами" и подставляем их на месте реальных блоков.
//
// Revision 1.157  2009/04/22 14:21:42  lulin
// [$145097085].
//
// Revision 1.156  2009/03/27 15:38:05  lulin
// [$138549031].
//
// Revision 1.155  2009/03/04 13:33:12  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.154  2009/03/03 17:42:05  lulin
// - <K>: 137470629. Убран ненужный промежуточный модуль.
//
// Revision 1.153  2009/03/03 17:27:26  lulin
// - <K>: 137470629. Переносим константу запрещённоо типа.
//
// Revision 1.152  2009/03/03 16:47:27  lulin
// - движемся к полному определению идентификаторов тегов на модели.
//
// Revision 1.151  2009/02/16 11:38:29  lulin
// - <K>: 136271449.
//
// Revision 1.150  2009/01/12 13:35:08  lulin
// - <K>: 135594063.
//
// Revision 1.149  2009/01/12 11:22:09  lulin
// - <K>: 131793318. Даём записывать DPI.
//
// Revision 1.148  2008/09/09 13:02:25  lulin
// - добавлены теги для CaseCode.
//
// Revision 1.147  2008/07/16 12:16:43  lulin
// - добавил теги ExternalNextVerLink, InternalNextVerLink.
//
// Revision 1.146  2008/06/11 07:57:23  lulin
// - разделяем связи наследования и реализации.
//
// Revision 1.145  2008/06/10 19:38:31  lulin
// - генерируем функции для создания экземпляров тегов.
//
// Revision 1.144  2008/06/09 15:29:58  lulin
// - рисуем схему EVD на модели.
//
// Revision 1.143  2008/06/06 09:11:54  lulin
// - вычищен ненужный тип.
//
// Revision 1.142  2008/06/02 13:18:04  lulin
// - <K>: 89096952.
//
// Revision 1.141  2008/05/16 13:10:33  lulin
// - используем простейший документ для однострочных полей.
//
// Revision 1.140  2008/05/16 12:24:26  lulin
// - используем простой документ для мемо поля.
//
// Revision 1.139  2008/04/15 09:03:23  lulin
// - правим название директив - чтобы соответствовали смыслу.
//
// Revision 1.138  2008/04/15 08:25:46  dinishev
// Восстанавливаем старый редактор
//
// Revision 1.137  2008/02/22 11:33:11  dinishev
// Переделка виртуальной отрисовки таблиц
//
// Revision 1.136  2008/02/11 13:16:24  lulin
// - добавлен тег ViewKind.
//
// Revision 1.135  2007/12/05 12:35:08  lulin
// - вычищен условный код, составлявший разницу ветки и Head'а.
//
// Revision 1.134  2007/09/22 14:59:20  lulin
// - перегенерация, в связи с поддержкой объектов (формул) внутри текстовых параграфов.
//
// Revision 1.133  2007/09/20 14:06:24  lulin
// - добавлен тип сегментов с объектами.
//
// Revision 1.132  2007/09/03 14:31:01  lulin
// - добавлен параграф с данными во внешнем формате.
//
// Revision 1.131  2007/09/03 12:29:11  lulin
// - переименовываем тег.
//
// Revision 1.130  2007/09/03 10:46:49  lulin
// - уменьшаем число параметров.
//
// Revision 1.129  2007/08/31 15:34:35  lulin
// - cleanup.
//
// Revision 1.128  2007/08/31 13:37:23  lulin
// - уменьшаем значение тега.
//
// Revision 1.127  2007/08/29 13:06:52  lulin
// - выделены спецзначения тегов.
//
// Revision 1.126  2007/08/08 13:26:34  lulin
// - вычищен устаревший тег (<K>-15958640).
//
// Revision 1.125  2007/08/02 15:07:48  lulin
// - при загрузке и отрисовки картинки учитываем ее DPI.
//
// Revision 1.124  2007/06/25 12:19:40  narry
// - поддержка команды !SERVICEINFO
//
// Revision 1.123  2007/06/18 13:43:44  lulin
// - удален ненужный тег (<K>-13795539).
//
// Revision 1.122  2007/06/18 11:25:28  lulin
// - добавлен декоративный текстовый параграф (<K>-19333543).
//
// Revision 1.121  2007/06/08 09:17:21  lulin
// - хранение ноды по-умолчанию перенесено в тег (<K>-17335096).
//
// Revision 1.120  2007/06/06 07:11:01  lulin
// - картинке добавлено имя.
//
// Revision 1.119  2007/06/04 08:13:10  lulin
// - вычищен ненужный тег (<K>-15663142).
//
// Revision 1.118  2007/05/30 10:49:05  lulin
// - вычищаем признак модифицированности атрибута из утилитного класса, перекладываем его в тег (<K>-13239999).
//
// Revision 1.117  2007/05/29 13:04:01  lulin
// - добавлен тег для хранения доступных операций (<K>-13239724).
//
// Revision 1.116  2007/05/29 12:25:33  lulin
// - вычищено хранение признака модифицированности с утилитного класса (<K>-13795407).
// - вычищен ненужный тег (<K>-13795506).
//
// Revision 1.115  2007/05/29 07:15:38  lulin
// - атрибуту добавлен тег - "значение текста по-умолчанию" (<K>-13240502).
//
// Revision 1.114  2007/05/24 11:37:38  lulin
// - new behavior: в тегах возможна комплексная сортировка, пока не более 4-х полей. Адреса гиперссылок теперь проверяются на дубликаты.
//
// Revision 1.113  2007/05/24 09:35:52  lulin
// - bug fix: не падаем, если хотим получить несуществующее свойство.
//
// Revision 1.112  2007/05/24 09:24:21  lulin
// - по-другому идентифицируем комплексную сортировку.
//
// Revision 1.111  2007/03/16 14:47:29  lulin
// - cleanup.
//
// Revision 1.110  2006/12/12 08:58:30  lulin
// - cleanup.
//
// Revision 1.109  2006/12/11 12:25:10  lulin
// - cleanup.
//
// Revision 1.108  2006/11/03 12:09:31  lulin
// - удален код, связанный с частичной закрузкой документа.
//
// Revision 1.107  2006/11/03 11:00:44  lulin
// - объединил с веткой 6.4.
//
// Revision 1.106.2.3  2006/10/26 12:03:59  lulin
// - спрятаны ненужные теги.
//
// Revision 1.106.2.2  2006/10/26 11:48:22  oman
// - fix: Более правильный способ объявления k2_tiVisibleIndex
//
// Revision 1.106.2.1  2006/10/26 10:14:25  oman
// - fix: Для сохранения VisibleIndex в КЗ ползуем свое свойство, а не
//  гадим в k2_tiModelControl (cq23253)
//
// Revision 1.106  2006/09/18 07:43:44  oman
// - new: Новый атрибут k2_tiMaxTextLength - максимальная длина текста
//
// Revision 1.105  2006/09/11 13:55:34  oman
// - change: k2_tiContext заменен на k2_tiReqKind
//
// Revision 1.104  2006/09/04 08:25:29  lulin
// - добавлен альтернативный текст.
//
// Revision 1.103  2006/04/26 15:27:13  dinishev
// Задел, чтобы убрать заплатки
//
// Revision 1.102  2006/01/18 16:12:15  lulin
// - не регистрируем Listner'ов для типов без ID.
//
// Revision 1.101  2006/01/10 07:23:41  lulin
// - добавлены новые атрибуты документа для Вована.
//
// Revision 1.100  2005/12/02 11:30:55  lulin
// - выделен базовый тип атрибутов точки входа - k2_idNSRCTag.
//
// Revision 1.99  2005/09/22 10:19:42  dinishev
// Bug fix: Атрибут k2_tiNumList (вместо k2_tiDefaultValue) + значения по умолчанию
//
// Revision 1.98  2005/09/09 13:26:31  dinishev
// Новый тег k2_tiContext - для того, чтобы отличать контекстные поля.
//
// Revision 1.97  2005/09/07 09:02:05  dinishev
// update comments
//
// Revision 1.96  2005/09/05 10:55:02  dinishev
// Поддержка запрета множественного выбора реквизита
//
// Revision 1.95  2005/09/02 14:48:37  dinishev
// Поддержка новых тегов
//
// Revision 1.94  2005/08/23 16:25:18  lulin
// - bug fix: исправлена "резиновость" SBS.
//
// Revision 1.93  2005/08/23 15:41:54  lulin
// - задел на "резиновость" карточки запроса.
//
// Revision 1.92  2005/07/04 08:21:11  lulin
// - cleanup: спрятаны ненужные идентификаторы типов.
//
// Revision 1.91  2005/07/04 07:52:52  lulin
// - cleanup.
//
// Revision 1.90  2005/06/30 07:27:07  dinishev
// Новые константы для редактора.
//
// Revision 1.89  2005/06/27 11:11:24  lulin
// - new prop: AllChildrenCount.
//
// Revision 1.88  2005/03/22 15:45:30  lulin
// - убраны ненужные методы.
//
// Revision 1.87  2005/03/02 08:13:17  lulin
// - добавлены теги для поддержки xml-образных структур.
//
// Revision 1.86  2005/02/21 15:02:09  lulin
// - листьевым параграфам добавлен тег k2_tiContentsLevel.
//
// Revision 1.85  2005/02/15 09:17:57  lulin
// - константы для записываемых тегов перенесены в "правильное" место.
//
// Revision 1.84  2005/02/14 15:56:34  dinishev
// отказ от использования тега k2_tiInHeader
//
// Revision 1.83  2005/02/14 12:26:53  lulin
// - добавлены теги для аннотаций.
//
// Revision 1.82  2005/02/11 08:22:50  dinishev
// Новый тег скрипта для параграфа
//
// Revision 1.81  2005/01/24 16:45:41  dinishev
// Добавлена поддержка k2_idControlsBlock
//
// Revision 1.80  2005/01/20 12:16:17  lulin
// - new prop: IeeSub.InContents.
//
// Revision 1.79  2005/01/18 13:19:59  dinishev
// Отказ от тега IsMasked
//
// Revision 1.78  2005/01/17 16:47:18  dinishev
// пересортированы теги - доступные для изменения поставлены перед k2_tiChildren
//
// Revision 1.77  2005/01/12 14:50:33  dinishev
// Отрисовка true-колорных иконок. Кнопка со сменой состояний.
//
// Revision 1.76  2005/01/11 16:39:03  dinishev
// Обработка движения мыши над контролом.
//
// Revision 1.75  2004/12/24 15:29:35  dinishev
// Свойство IsValid для параграфа с маской
//
// Revision 1.74  2004/12/20 16:40:49  dinishev
// Свойство IsMasked для редактора
//
// Revision 1.73  2004/12/16 16:10:38  dinishev
// Номер картинки в ImageList, используемый при отрисовке кнопочных компонетов
//
// Revision 1.72  2004/12/01 14:50:36  dinishev
// Реакция на изменение параграфа, подправлено изменение состояния кнопки ComboBox'а.
//
// Revision 1.71  2004/11/30 17:50:21  dinishev
// Реализация выпадающего дерева для CombobBox'а. Некоторые исправления отображения.
//
// Revision 1.70  2004/11/16 16:09:00  dinishev
// Изменена прорисовка контролов, в том числе и для тем, включена поддержка свойств
// Enabled и Flat.
//
// Revision 1.69  2004/11/12 14:00:16  lulin
// - new prop: idControlPara.tiChecked.
//
// Revision 1.68  2004/11/11 17:35:26  lulin
// - new behavior: для блока с комментарием сделано нормальное сохранение и рисование человечков на полях.
//
// Revision 1.67  2004/11/03 16:19:21  lulin
// - cleanup: убраны ненужные идентификаторы типов.
//
// Revision 1.66  2004/11/03 13:05:59  lulin
// - new para: idCommentPara.
//
// Revision 1.65  2004/11/02 13:05:55  lulin
// - new para: k2_idControlPara.
//
// Revision 1.64  2004/06/04 13:48:21  law
// - проставлены числовые значения тегов.
//
// Revision 1.63  2004/06/04 13:03:59  law
// - new prop: idLeafPara.tiLoaded.
//
// Revision 1.62  2004/04/12 13:59:09  law
// - новый тип блоков "элемент словарной статьи".
//
// Revision 1.61  2004/04/12 13:29:32  law
// - new: добавлен тип документов "словарная статья", их свойство ShortName теперь представляется не строкой, а массивом строк.
//
// Revision 1.60  2004/04/12 09:02:45  law
// - new tag: k2_idDictEntry.
//
// Revision 1.59  2004/04/12 08:20:04  law
// - change: "оказалось" что у команды !Contents другой формат.
//
// Revision 1.58  2004/03/17 13:01:12  law
// - new type: k2_idDictItemEx.
// - change: источник опубликования теперь имеет тип k2_idDictItemEx.
//
// Revision 1.57  2004/01/29 13:06:47  law
// - new tags: k2_tiContentsLevelBackLink, k2_tiPages, k2_tiLinkComment.
//
// Revision 1.56  2003/12/08 14:04:53  law
// - new tag: k2_toContentsLevel.
//
// Revision 1.55  2003/11/28 14:38:32  law
// - new tag: k2_idTextPara._k2_tiExcludeSuper.
//
// Revision 1.54  2003/10/16 12:33:51  law
// - change: введены два мета-типа параграфа - LeafPara и StyledLeafPara - для наследования от них "листьевых" параграфов.
// - bug fix: при скрытии комментариев не скрывались картинки.
//
// Revision 1.53  2003/09/12 13:48:49  law
// no message
//
// Revision 1.52  2003/09/10 12:18:39  law
// - new type: idMark.
// - new const: ev_sbtMark.
//
// Revision 1.51  2003/09/09 14:56:23  law
// - new prop: Address.ShortName, Address.Revision.
//
// Revision 1.50  2003/09/01 15:44:44  law
// - new: добавлен тип _k2_idBookmark.
//
// Revision 1.49  2003/05/20 08:56:16  law
// - new tag: k2_tiAutoClasses.
//
// Revision 1.48  2003/05/14 13:17:14  law
// - change _format: текстовому параграфу добавлен массив позиций табуляции.
//
// Revision 1.47  2003/04/25 12:53:46  law
// - new behavior: документу сделан тег k2_tiMaxHyperlinkHandle - максимальное значение идентификатора ссылки в документе, на основании него теперь можно распределять новые номера ссылок.
//
// Revision 1.46  2003/03/12 13:36:28  law
// - new tag: k2_tiAlarms.
//
// Revision 1.45  2003/03/12 13:17:58  law
// - change: изменен формат обработки редакций документов.
//
// Revision 1.44  2003/01/23 10:24:06  law
// - change: расширены структуры для NSRC.
//
// Revision 1.43  2003/01/16 12:37:16  law
// - rename tags: k2_tiNextChanger -> k2_tiNextChangers, k2_tiPrevChanger -> k2_tiPrevChangers.
// - new struct: возможность хранения нескольких Changer'ов.
//
// Revision 1.42  2003/01/15 16:53:24  law
// - new tag: k2_tiBullet.
// - new behavior: начал поддержку маркированных списков.
//
// Revision 1.41  2003/01/15 13:27:01  law
// - new tags: добавлены новые теги для поддержки версионности.
//
// Revision 1.40  2002/12/19 13:59:23  law
// - change: f_Map -> k2_tiMap.
//
// Revision 1.39  2002/12/19 12:49:59  law
// - change: заменяем DeltaP на (k2_tiDeltaX, k2_tiDeltaY).
//
// Revision 1.38  2002/12/17 12:42:49  law
// - change: k2_idTableColumn переименовано в k2_idTableCell для большего соответстия смыслу тега.
//
// Revision 1.37  2002/12/15 13:38:08  law
// - new behaivor: вчерновую прикрутил рисование формул.
//
// Revision 1.36  2002/11/01 18:50:27  law
// - new para types: k2_idSBSRow, k2_idSBSCell.
//
// Revision 1.35  2002/10/02 13:30:14  law
// - new units: eeTags, _eeTypes.
//
// Revision 1.34  2002/09/02 08:26:51  law
// - new tag types: k2_idDictItem, k2_idItemFlag.
// - change tag type: k2_idDictRec -> k2_idDictItem для k2_tiClasses, k2_tiTypes, k2_tiKeyWords, k2_tiPrefix.
//
// Revision 1.33  2002/07/23 09:04:51  law
// - comments.
//
// Revision 1.32  2002/07/08 13:48:24  law
// no message
//
// Revision 1.31  2002/07/08 12:09:38  law
// - new const: k2_idTreePara.
//
// Revision 1.30  2002/02/12 09:12:50  law
// - comments.
//
// Revision 1.29  2002/02/05 10:16:09  law
// - bug fix: неправильная предельная ширина Preformatted-параграфов.
//
// Revision 1.28  2002/01/08 13:54:15  law
// - rename type: TevOrientation -> Tl3Orientation.
//
// Revision 1.27  2001/11/26 14:29:21  law
// - comments: исправлены.
//
// Revision 1.26  2001/11/26 12:17:02  law
// - new tag: k2_tiRelInternalHandle.
//
// Revision 1.25  2001/11/21 10:50:05  law
// - new tag: k2_tiAccGroups.
//
// Revision 1.24  2001/09/19 15:54:33  law
// - new tag ID: k2_tiCollapsed.
//
// Revision 1.23  2001/03/15 14:52:23  law
// - cleaning & coments.
//
// Revision 1.22  2001/02/23 13:44:26  law
// - к текстовому параграфу добавлено свойство AllowHyphen.
//
// Revision 1.21  2001/01/15 15:50:09  law
// - добавлено свойство k2_tiVerticalAligment - выравнивание по вертикали.
//
// Revision 1.20  2000/12/15 15:18:59  law
// - вставлены директивы Log.
//

{$Include k2Define.inc }

interface

uses
  k2Const
  ;

type
  Tk2TagID = (
    {* Параметры, идентифицирующие атрибуты объектов. }
    _k2_tiHandle,           {-идентификатор объекта (для ссылок, точек входа)} //0
    _k2_tiShortName,        {-короткое имя объекта } // 1
    _k2_tiExternalHandle,   {-внешний идентификатор объекта (для ссылок, точек входа)} // 2
    _k2_tiInternalHandle,   {-внутренний идентификатор объекта (для ссылок, точек входа)} // 3
    _k2_tiMDPPageID,        // - номер MDP топика {RequestLink:275780190} 4
    _k2_tiNameComment,      // 5
    _k2_tiName,             {-имя объекта } // 6

    { параметры для шрифта }
    _k2_tiPitch,            {-тип ширины символа (моноширинный или нет)} // 7
    _k2_tiSize,             {-высота шрифта} // 8
    _k2_tiBold,             {-жирный} // 9
    _k2_tiItalic,           {-курсив} // 10
    _k2_tiUnderline,        {-подчеркнутый} // 11
    _k2_tiStrikeout,        {-зачеркнутый}  // 12
    _k2_tiForeColor,        {-цвет текста (или линий)} // 13
    _k2_tiBackColor,        {-цвет фона} // 14
    _k2_tiIndex,            {-индекс - верхний или нижний} // 15
    _k2_tiCodePage,         {-кодовая страница} // 16
    _k2_tiFontParamRsr1,    // 17
    _k2_tiFontParamRsr2,    // 18
    _k2_tiFontParamRsr3,    // 19
    _k2_tiFontParamRsr4,    // 20

    { параметры оформления }
    _k2_tiFont,             {-шрифт объекта} // 21
    _k2_tiStyle,            {-стиль объекта} // 22
    _k2_tiVisible,          {-видимость}     // 23
    _k2_tiSegments,         {-отрезки оформления} // 24

    _k2_tiFrame,            {-рамка вокруг объекта} // 25

    { параметры рамок }
    _k2_tiFrameUp,          {-верхняя часть рамки} // 26
    _k2_tiFrameDown,        {-нижняя часть рамки}  // 27
    _k2_tiFrameLeft,        {-левая часть рамки}   // 28
    _k2_tiFrameRight,       {-правая часть рамки}  // 29

    { размеры и ориентация объекта }
    _k2_tiOrientation,      {-ориентация объекта}  // 30
    _k2_tiWidth,            {-ширина в дюймах}     // 31
    _k2_tiHeight,           {-высота в дюймах}     // 32
    _k2_tiFirstIndent,      {-отступ первой строки (от предка)} // 33
    _k2_tiLeftIndent,       {-левый отступ}        // 34
    _k2_tiJustification,    {-выравнивание}        // 35
    _k2_tiFixedHeight,      {-фиксированная высота ?} // 36
    _k2_tiPercentSign,      {-знак процента % - спецзначение для записи в EVD} // 37
    _k2_tiRightIndent,      {-правый отступ}          // 38
    _k2_tiFirstLineIndent,  {-отступ первой строки (от границы абзаца)} // 39
    _k2_tiSpaceBefore,      {-отступ сверху}          // 40
    _k2_tiSpaceAfter,       {-отступ снизу}           // 41
    _k2_tiCollapsed,        {-объект свернут}         // 42

    { структурированные параметры }
    _k2_tiParas,            {-параметры объекта а ля Style (от старой версии)} // 43
    _k2_tiSubs,             {-список точек входа (Sub'ов)} // 44
    _k2_tiIsActive,         // 45
    _k2_tiStrParamRsr2,     // 46
    _k2_tiStrParamRsr3,     // 47
    _k2_tiStrParamRsr4,     // 48
    _k2_tiCaseDocParticipants, // 49

    _k2_tiApply2Para,       {-применим ли стиль к параграфу} // 50
    _k2_tiStyleParamRsr1,   // 51
    _k2_tiIsChangeableFont, // Можно ли изменять шрифт стиля кнопками на тулбаре // 52
    _k2_tiVisibleToUser,    // Включать ли в таблицу стилей для пользователя // 53
    _k2_tiLineSpacing,      // - интерлиньяж // 54
    _k2_tiHeaderHasOwnSpace,// 55

    { параметры отрезков }
    _k2_tiStart,            {-начало отрезка} // 56
    _k2_tiFinish,           {-конец отрезка } // 57
    _k2_tiBaseLine,         // Базовая зиния // 58 http://mdp.garant.ru/pages/viewpage.action?pageId=336663777
    _k2_tiSegmentParamRsr2, // 59
    _k2_tiSegmentParamRsr3, // 60
    _k2_tiSegmentParamRsr4, // 61
    _k2_tiSegmentParamRsr5, // 62

    _k2_tiText,             {-текст} // 63
    _k2_tiOldChildren,      {-список дочерних объектов // 64
                              (для поддержки файлов evd вылитых ранее 07/12/1998)}
    _k2_tiIsPeriodic,       {http://mdp.garant.ru/pages/viewpage.action?pageId=242516109} // 65
    _k2_tiLineType,         {-тип линии} // 66
    _k2_tiLoaded,           // - загружен ли параграф целиком // 67

    {зарезервированные тэги для текстов}
    _k2_tiAlternateText,   // 68
    _k2_tiMaxTextLength,   {-масксимальная длина текста для ControlPara}// 69
    _k2_tiPrintFontSize,   // 70  http://mdp.garant.ru/pages/viewpage.action?pageId=199590272
    _k2_tiTextRsr4,        // 71
    _k2_tiTextRsr5,        // 72
    _k2_tiTextRsr6,        // 73
    _k2_tiTextRsr7,        // 74
    _k2_tiTextRsr8,        // 75
    _k2_tiTextRsr9,        // 76
    _k2_tiMaxSubID,        // 77 http://mdp.garant.ru/pages/viewpage.action?pageId=283608516&focusedCommentId=294257621#comment-294257621

    _k2_tiHasAnno,         // 78
    _k2_tiZoom,            // 79
    _k2_tiNoCompare,       // 80 // Документ не участвует в стравнении редакций
    _k2_tiOldNSRC,         // 81 // Писать в старом формате NSRC 
    _k2_tiLanguage,        // Язык http://mdp.garant.ru/pages/viewpage.action?pageId=135594063 // 82
    _k2_tiDPI,             // Разрешение // 83
    _k2_tiUrgency,         // Срочность  // 84
    _k2_tiFixedWidth,      // - фиксированная ширина ? // 85
    _k2_tiAllowHyphen,     // 86
    _k2_tiVerticalAligment, // 87

    {тэги для поддержки формата NSRC}
    _k2_tiGroups,           {-группы} // 88
    _k2_tiSources,          {-источники} // 89
    _k2_tiTypes,            {-типы}      // 90
    _k2_tiClasses,          {-классы}    // 91
    _k2_tiKeyWords,         {-ключевые слова} // 92
    _k2_tiWarnings,         {-предупреждения} // 93
    _k2_tiType,             {-тип объекта}    // 94
    _k2_tiUserType,         {-пользовательский тип объекта} // 95
    _k2_tiUser,             {-пользователь}   // 96
    _k2_tiDocID,            {-идентификатор документа} // 97
    _k2_tiSubID,            {-идентификатор Sub'а}     // 98
    _k2_tiNumber,           {-номер}                   // 99
    _k2_tiComment,          {-комментарий}             // 100

    _k2_tiNumANDDates,      // 101
    _k2_tiLogRecords,       // 102
    _k2_tiStages,           // 103
    _k2_tiChecks,           // 104
    _k2_tiSource,            {-источник} // 105
    _k2_tiSortDate,         // 106
    _k2_tiActiveIntervals,  // 107
    _k2_tiRelExternalHandle, // 108
    _k2_tiPriority,          // 109

    _k2_tiPublishedIn,       // 110
    _k2_tiPrefix,            // 111
    _k2_tiTerritory,         // 112
    _k2_tiAlarms,            // 113
    _k2_tiNorm,              // 114
    _k2_tiExternalPath,      // 115
    _k2_tiLinkedDocuments,   // 116

    {вспомогательные тэги}
    _k2_tiFlags,             {-флаги} // 117
    _k2_tiObject,            {-указатель на объект} // 118

    _k2_tiBitmap,            {-BMP-картинка} // 119
    _k2_tiPriceLevel,        {-ценовая категория} { NSRC } // 120
    _k2_tiURL,               {-URL}                        // 121
    _k2_tiHeaders,           {-верхние колонтитулы}        // 122
    _k2_tiFooters,           {-нижние колонтитулы}         // 123
    _k2_tiMergeStatus,       {-статус объединения ячеек}   // 124
    _k2_tiAccGroups,         // NSRC                       // 125
    _k2_tiRelInternalHandle, // NSRC - внутренний идентификатор справки // 126
    _k2_tiAutoClasses,       // 127
    _k2_tiWeight,            // 128
    _k2_tiInternalVerLink,   // 129
    _k2_tiExternalVerLink,   // 130
    _k2_tiAnnoClasses,       // 131
    _k2_tiBullet,           {- тип элемента списка} // 132
    _k2_tiTime,             // NSRC - время                    // 133
    _k2_tiTabStops,         // - позиции табуляции             // 134
    _k2_tiRevision,         // - ревизия                       // 135
    _k2_tiContentsLevel6,   // - уровень оглавления            // 136
    _k2_tiContentsLevel5,   //                                 // 137
    _k2_tiPages,            //                                 // 138
    _k2_tiLinkComment,      //                                 // 139
    _k2_tiPrivate,          //                                 // 140
    _k2_tiValue,            //                                 // 141
    _k2_tiEnabled,          // - доступность объекта           // 142
    _k2_tiValid,            // - корректность хранимых данных  // 143
    _k2_tiUpper,            // - мышь над кнопкой              // 144
    _k2_tiStateIndex,       // - номер картинки для текущего   // 145
                            //состояния                        
    _k2_tiFlat,             // - псевдотрехмерность            // 146
    _k2_tiImageIndex,       // - номер картинки в списке       // 147
    _k2_tiScript,           // - скрипт для исполнения         // 148
    _k2_tiCardType,         // - тип КЗ                        // 149
    _k2_tiReqID,            // - ID реквизита (для одинаковых строк) //150
    _k2_tiRequired,         // - обязательное значение //151                                
    _k2_tiNumList,          // - реквизит с номерами  //152
    _k2_tiInternalNextVerLink,  // - зарезервированно //153
    _k2_tiFilterType,       // - тип фильтрации аттрибута //154
    _k2_tiModelControl,     // - указатель на контрол из модели //155
    _k2_tiMulty,            // - реквизит допускает множественный выбор //156
    _k2_tiReqKind,          // - тип реквизита (TevReqKind)      //157
    _k2_tiSysLogRecords,    //                                 //158
    _k2_tiVersions,         //                                 //159
    _k2_tiExternalNextVerLink, {- зарезервировано}          // 160
    _k2_tiServiceInfo,       {- "Справочная информация" основного меню системы Гарант }  // 161
    _k2_tiInContents,         // - попал ли блок в оглавление // 162
    _k2_tiCompareContentsLevel, // http://mdp.garant.ru/pages/viewpage.action?pageId=332563400 // 163
    _k2_tiViewKind,         // 164
    _k2_tiLinkAddress,      // 165
    _k2_tiModified,         // 166
    _k2_tiEditableParts,    // 167
    _k2_tiVisibleToBlock,   // 168 // Стиль видимый для блока
    {==================================================================================}
    {          Тэги, добавленные ниже этого разделителя, не сохраняются                }
    {==================================================================================}
    _k2_tiChildren,         {-список дочерних объектов}        // 169
    _k2_tiFormatted,        {-сформатирован параграф или нет?} // 170
    _k2_tiLimitWidth,       // 171
    _k2_tiDeltaX,           {-смещение по оси X от родителя} // 172
    _k2_tiDeltaY,           {-смещение по оси Y от родителя} // 173
    _k2_tiMap,              {-карта форматирования параграфа} // 174
    _k2_tiMaxHyperlinkHandle, // - максимальный идентификатор гиперссылки // 175
    _k2_tiExcludeSuper,       // - сегменты, которые выкидываем из суперпозиции // 176
    _k2_tiLayerID,            // - идентификатор слоя // 177
    _k2_tiStateCount,         // - количество состояний // 178
    _k2_tiAllChildrenCount, // 179
    _k2_tiRubber,           // 180
    _k2_tiNodeVisibleIndex ,{-видимый индекс в дереве для КЗ - что в корне неправильно,
                             но пользовать для его сохранения k2_tiModelControl
                             еще хуже}// 181
    _k2_tiDefaultText,      // 182
    _k2_tiDefaultNode,      // 183
    _k2_tiOperations        // 184

  );//Tk2TagID

const
  { параметры, идентифицирующие объекты }
  k2_tiHandle         = Ord(_k2_tiHandle);
   {* - идентификатор объекта
     (для ссылок, точек входа e.g k2_idHyperlink, k2_idSub, IevHyperlink, IevSub). }
  k2_tiShortName      = Ord(_k2_tiShortName);
   {* - короткое имя объекта. }
  k2_tiExternalHandle = Ord(_k2_tiExternalHandle);
   {* - внешний идентификатор объекта
     (для блоков, документов e.g k2_idDocument, k2_idBlock, IevDocument, IevDocumentPart). }
  k2_tiInternalHandle = Ord(_k2_tiInternalHandle);
   {* - внутренний идентификатор объекта. }
  k2_tiMDPPageID      = Ord(_k2_tiMDPPageID);
   // - номер MDP топика {RequestLink:275780190}
  k2_tiName           = Ord(_k2_tiName);
   {* - имя объекта. }
  k2_tiURL            = Ord(_k2_tiURL);
   {* - путь к объекту. }
  k2_tiHeaders        = Ord(_k2_tiHeaders);
   {* - верхние колонтитулы. }
  k2_tiFooters        = Ord(_k2_tiFooters);
   {* - нижние колонтитулы. }
  k2_tiHeader        = Ord(_k2_tiHeaders);
   {* - верхний колонтитул. }
  k2_tiFooter        = Ord(_k2_tiFooters);
   {* - нижний колонтитул. }
  k2_tiMergeStatus    = Ord(_k2_tiMergeStatus);
   {* - статус объединения (ячеек). }

  { параметры для шрифта }
  k2_tiPitch          = Ord(_k2_tiPitch);
   {* - кернинг - тип ширины символа (моноширинный или нет). }
  k2_tiSize           = Ord(_k2_tiSize);
   {* - кегль - высота шрифта. }
  k2_tiBold           = Ord(_k2_tiBold);
   {* - жирный. }
  k2_tiItalic         = Ord(_k2_tiItalic);
   {* - курсив. }
  k2_tiUnderline      = Ord(_k2_tiUnderline);
   {* - подчеркнутый. }
  k2_tiStrikeout      = Ord(_k2_tiStrikeout);
   {* - зачеркнутый. }
  k2_tiForeColor      = Ord(_k2_tiForeColor);
   {* - цвет текста (или линий). }
  k2_tiBackColor      = Ord(_k2_tiBackColor);
   {* - цвет фона. }
  k2_tiIndex          = Ord(_k2_tiIndex);
   {* - индекс - верхний или нижний (см. Tl3FontIndex). }

  { параметры оформления }
  k2_tiFont           = Ord(_k2_tiFont);
   {* - шрифт объекта. }
  k2_tiStyle          = Ord(_k2_tiStyle);
   {* - стиль объекта. }
  k2_tiVisible        = Ord(_k2_tiVisible);
   {* - видимость. }
  k2_tiIsChangeableFont = Ord(_k2_tiIsChangeableFont);
   // Можно ли изменять шрифт стиля кнопками на тулбаре
  k2_tiVisibleToUser = Ord(_k2_tiVisibleToUser);
   // Включать ли в таблицу стилей для пользователя
  k2_tiSegments       = Ord(_k2_tiSegments);
   {* - отрезки оформления. }
  k2_tiVisibleToBlock = Ord(_k2_tiVisibleToBlock);  

  k2_tiFrame          = Ord(_k2_tiFrame);
   {* - рамка вокруг объекта. }

  { параметры рамок }
  k2_tiFrameUp        = Ord(_k2_tiFrameUp);
   {* - верхняя часть рамки. }
  k2_tiFrameDown      = Ord(_k2_tiFrameDown);
   {* - нижняя часть рамки. }
  k2_tiFrameLeft      = Ord(_k2_tiFrameLeft);
   {* - левая часть рамки. }
  k2_tiFrameRight     = Ord(_k2_tiFrameRight);
   {* - правая часть рамки. }

  { размеры и ориентация объекта }
  k2_tiOrientation    = Ord(_k2_tiOrientation);
   {* - ориентация объекта. }
  k2_tiLineSpacing = Ord(_k2_tiLineSpacing);
   {* - интерлиньяж. }
  k2_tiHeaderHasOwnSpace = Ord(_k2_tiHeaderHasOwnSpace);
  k2_tiWidth          = Ord(_k2_tiWidth);
   {* - ширина в дюймах. }
  k2_tiHeight         = Ord(_k2_tiHeight);
   {* - высота в дюймах. }
  k2_tiFirstIndent    = Ord(_k2_tiFirstIndent);
   {* - отступ первой строки. }
  k2_tiLeftIndent     = Ord(_k2_tiLeftIndent);
   {* - левый отступ. }
  k2_tiJustification  = Ord(_k2_tiJustification);
   {* - выравнивание. }
  k2_tiFixedWidth     = Ord(_k2_tiFixedWidth);
   {* - фиксированная ширина ?}
  k2_tiUrgency        = Ord(_k2_tiUrgency);
   {* - срочность. }
  k2_tiHasAnno        = Ord(_k2_tiHasAnno);
   {* - показывает наличие аннотации у документа. }
  k2_tiZoom           = Ord(_k2_tiZoom);
   {* - масштаб. }
  k2_tiNoCompare      = Ord(_k2_tiNoCompare);
   // Документ не участвует в стравнении редакций
  k2_tiOldNSRC        = Ord(_k2_tiOldNSRC);
  k2_tiLanguage       = Ord(_k2_tiLanguage);
   {* - язык. }
  k2_tiRightIndent    = Ord(_k2_tiRightIndent);
   {* - правый отступ. }
  k2_tiFirstLineIndent= Ord(_k2_tiFirstLineIndent);
   {* - отступ первой строки (от границы абзаца). }
  k2_tiSpaceBefore    = Ord(_k2_tiSpaceBefore);
   {* - отступ сверху. }
  k2_tiSpaceAfter     = Ord(_k2_tiSpaceAfter);
   {* - отступ снизу. }
  k2_tiCollapsed      = Ord(_k2_tiCollapsed);
   {* - объект свернут. }
  k2_tiCollapsable    = Ord(_k2_tiCollapsed);
   {* - объект может сворачиваться. }

  { структурированные параметры }
  k2_tiParas          = Ord(_k2_tiParas);
   {* - параметры объекта а ля Style (от старой версии). }
  k2_tiSubs           = Ord(_k2_tiSubs);
   {* - список точек входа (Sub'ов) (см. kd_idSub, IevSub). }
  k2_tiIsActive       = Ord(_k2_tiIsActive);

  k2_tiCaseDocParticipants = Ord(_k2_tiCaseDocParticipants);
   {* - участники судебного дела. } 
  k2_tiApply2Para     = Ord(_k2_tiApply2Para);
   {* - применим ли стиль к параграфу? }

  { параметры отрезков }
  k2_tiStart          = Ord(_k2_tiStart);
   {* - начало отрезка. }
  k2_tiFinish         = Ord(_k2_tiFinish);
   {* - конец отрезка. }
  k2_tiBaseLine       = Ord(_k2_tiBaseLine);
   {* - базовая линия. }

  k2_tiText           = Ord(_k2_tiText);
   {* - текст. }
  k2_tiAlternateText  = Ord(_k2_tiAlternateText);
   {-}
  k2_tiMaxTextLength = Ord(_k2_tiMaxTextLength);
   {-}
  k2_tiPrintFontSize = Ord(_k2_tiPrintFontSize);
   {-}
  k2_tiMaxSubID = Ord(_k2_tiMaxSubID);
   {-}
  k2_tiNodeVisibleIndex = ord(_k2_tiNodeVisibleIndex);
   {-}
  k2_tiDefaultText = Ord(_k2_tiDefaultText);
   {* - значение текста по-умолчанию. }
  k2_tiDefaultNode = Ord(_k2_tiDefaultNode);
   {* - значение узла по-умолчанию. }
  k2_tiModified = Ord(_k2_tiModified);
   {-}
  k2_tiEditableParts = Ord(_k2_tiEditableParts);
   {-}
  k2_tiOperations = Ord(_k2_tiOperations);
   {-}
  k2_tiDPI = Ord(_k2_tiDPI);
   {-}
  k2_tiViewKind = Ord(_k2_tiViewKind);
   {-}
  k2_tiLinkAddress = Ord(_k2_tiLinkAddress);
   {-}
  k2_tiChildren       = Ord(_k2_tiChildren);
   {* - список дочерних объектов. }
  k2_tiIsPeriodic     = Ord(_k2_tiIsPeriodic);
   {http://mdp.garant.ru/pages/viewpage.action?pageId=242516109}
  k2_tiLineType       = Ord(_k2_tiLineType);
   {* - тип линии. }
  k2_tiAllowHyphen   =  Ord(_k2_tiAllowHyphen);
   {* - можно ли переносить слова по слогам. }
  k2_tiVerticalAligment = Ord(_k2_tiVerticalAligment);
   {* - вертикальное выравнивание (см. TevVerticalAligment). }

  {тэги для поддержки формата NSRC}
  k2_tiNSRCStart      = Ord(_k2_tiGroups);        {-начало тегов NSRC}
  k2_tiGroups         = Ord(_k2_tiGroups);
   {* - группы. }
  k2_tiAccGroups      = Ord(_k2_tiAccGroups);
   {* - группы доступа. }
  k2_tiSources        = Ord(_k2_tiSources);
   {* - источники. }
  k2_tiTypes          = Ord(_k2_tiTypes);
   {* - типы. }
  k2_tiClasses        = Ord(_k2_tiClasses);
   {* - классы. }
  k2_tiAutoClasses    = Ord(_k2_tiAutoClasses);
   {* - авто-классы. }
  k2_tiAnnoClasses    = Ord(_k2_tiAnnoClasses);
   {* - классы для аннотации. }
  k2_tiWeight         = Ord(_k2_tiWeight);
   {* - вес. }
  k2_tiKeyWords       = Ord(_k2_tiKeyWords);
   {* - ключевые слова. }
  k2_tiWarnings       = Ord(_k2_tiWarnings);
   {* - предупреждения. }
  k2_tiType           = Ord(_k2_tiType);
   {* - тип объекта. }
  k2_tiUserType       = Ord(_k2_tiUserType);
   {* - пользовательский тип объекта. }
  k2_tiUser           = Ord(_k2_tiUser);
   {* - пользователь. }
  k2_tiDocID          = Ord(_k2_tiDocID);
   {* - идентификатор документа (см. TevAddress, IevDocument). }
  k2_tiSubID          = Ord(_k2_tiSubID);
   {* - идентификатор Sub'а (см TevAddress, IevSub). }
  k2_tiNumber         = Ord(_k2_tiNumber);
   {* - номер. }
  k2_tiComment        = Ord(_k2_tiComment);
   {* - комментарий. }
  k2_tiNameComment    = Ord(_k2_tiNameComment);
   {* - комментарий. }

  k2_tiNumANDDates    = Ord(_k2_tiNumANDDates);
   {* - даты/номера. }
  k2_tiLogRecords     = Ord(_k2_tiLogRecords);
   {* - журнал юридических изменений. }
  k2_tiSysLogRecords  = Ord(_k2_tiSysLogRecords);
   {* - журнал системных изменений. }
  k2_tiVersions       = Ord(_k2_tiVersions);
   {-}
  k2_tiStages         = Ord(_k2_tiStages);
   {* - этапы. }
  k2_tiChecks         = Ord(_k2_tiChecks);
   {* - вычитка. }
  k2_tiChecked        = Ord(_k2_tiChecks);
   {* - кнопка нажата/отпущена. }
  k2_tiEnabled        = Ord(_k2_tiEnabled);
   {* - доступность компонента. }
  k2_tiFlat        = Ord(_k2_tiFlat);
   {* - режим Flat. }
  k2_tiSource         = Ord(_k2_tiSource);
   {* - источник. }
  k2_tiImageIndex       = Ord(_k2_tiImageIndex);
   {* - индекс картинки для отображения. }
  k2_tiValid            = Ord(_k2_tiValid);
   {* - корректность хранимых данных. }
  k2_tiUpper        = Ord(_k2_tiUpper);
   {* - мышь над кнопкой. }
  k2_tiStateCount   = Ord(_k2_tiStateCount);
   {* - количество состояний. }
  k2_tiInContents   = Ord(_k2_tiInContents);
   {* - попал ли блок в оглавление. }
  k2_tiCardType     = Ord(_k2_tiCardType);
   {* - тип карточки запроса. }
  k2_tiReqID        = Ord(_k2_tiReqID);
   {* - ID реквизита для строк таблицы. }
  k2_tiNumList = Ord(_k2_tiNumList);
   {-}
  k2_tiRequired = Ord(_k2_tiRequired);
   {* - обязательное значение. }
  k2_tiFilterType = Ord(_k2_tiFilterType);
   {* - тип фильтрации атрибута. }
  k2_tiModelControl = Ord(_k2_tiModelControl);
   {* - указатель на тип модели. }
  k2_tiMulty = Ord(_k2_tiMulty);
   {* - возможность множественного выбора. }
  k2_tiReqKind = Ord(_k2_tiReqKind);
   {* - Тип реквизита. }

  k2_tiAllChildrenCount = Ord(_k2_tiAllChildrenCount);
   {-}
  k2_tiRubber = Ord(_k2_tiRubber);
   {-} 
  k2_tiStateIndex   = Ord(_k2_tiStateIndex);
   {* - номер картинки для текущего состояния. }
  k2_tiScript         = Ord(_k2_tiScript); 
   {* - скрипт для исполнения при реакции. }

  k2_tiSortDate       = Ord(_k2_tiSortDate);
   {* - дата сортировки. }
  k2_tiRelExternalHandle = Ord(_k2_tiRelExternalHandle);
   {* - внешний идентификатор справки. }
  k2_tiRelInternalHandle = Ord(_k2_tiRelInternalHandle);
   {* - внутренний идентификатор справки. }
  k2_tiActiveIntervals = Ord(_k2_tiActiveIntervals);
   {-}
  k2_tiAlarms          = Ord(_k2_tiAlarms);
   {-}
  k2_tiInternalVerLink = Ord(_k2_tiInternalVerLink);
   {-}
  k2_tiExternalVerLink = Ord(_k2_tiExternalVerLink);
   {-}
  k2_tiInternalNextVerLink = Ord(_k2_tiInternalNextVerLink);
   {-}
  k2_tiExternalNextVerLink = Ord(_k2_tiExternalNextVerLink);
   {-}
  k2_tiBullet         = Ord(_k2_tiBullet);
   {* - тип элемента списка. }
  k2_tiTime           = Ord(_k2_tiTime);
   {* NSRC - время. }
  k2_tiTabStops       = Ord(_k2_tiTabStops);
   {* - позиции табуляции. }
  k2_tiRevision       = Ord(_k2_tiRevision);
   {* - ревизия. }
  k2_tiContentsLevel6  = Ord(_k2_tiContentsLevel6);
   {* - уровень оглавления для 6.х. }
  k2_tiContentsLevel = k2_tiContentsLevel6;
   {* - уровень оглавления. }
  k2_tiCompareContentsLevel = Ord(_k2_tiCompareContentsLevel);
   // http://mdp.garant.ru/pages/viewpage.action?pageId=332563400 
  k2_tiContentsLevel5  = Ord(_k2_tiContentsLevel5);
   {* - уровень оглавления для 5.х. }
  k2_tiPages = Ord(_k2_tiPages);
   {-}
  k2_tiLinkComment = Ord(_k2_tiLinkComment);
   {-}
  k2_tiPrivate = Ord(_k2_tiPrivate);
   {-}
  k2_tiPriority       = Ord(_k2_tiPriority);
   {-}

  k2_tiPublishedIn    = Ord(_k2_tiPublishedIn);
   {* - источник публикации. }
  k2_tiPrefix         = Ord(_k2_tiPrefix);
   {* - префикс. }
  k2_tiTerritory      = Ord(_k2_tiTerritory);
   {* - территория. }
  k2_tiNorm           = Ord(_k2_tiNorm);
  k2_tiExternalPath   = Ord(_k2_tiExternalPath);
  k2_tiPriceLevel     = Ord(_k2_tiPriceLevel);
  k2_tiServiceInfo = Ord(_k2_tiServiceInfo);
   {* - ценовая категория. } { NSRC }
  k2_tiLinkedDocuments        = Ord(_k2_tiLinkedDocuments);
   {* - Связанные документы. }

  {вспомогательные тэги}
  k2_tiFlags          = Ord(_k2_tiFlags);
   {* - флаги. }
  k2_tiObject         = Ord(_k2_tiObject);
   {* - указатель на объект. }
  k2_tiData           = Ord(_k2_tiBitmap);
   {* - BMP-картинка. }
  k2_tiMaxHyperlinkHandle = Ord(_k2_tiMaxHyperlinkHandle);
   {* - максимальный идентификатор гиперссылки. }
  k2_tiLayerID        = Ord(_k2_tiLayerID);
   {* - идентификатор слоя. }
  k2_tiValue = Ord(_k2_tiValue);
   {* - значение "атомарного" ребенка. }
  k2_tiLast = Ord(High(Tk2TagID));
   {-}
  k2_tiComplexBase = High(Byte) + 1 {k2_tiLast + 1};
   {* - база для указания сложной сортировки. }

  k2_attrSelfID = k2_tiSelfID;
  k2_attrNative = k2_tiNative;

  k2_attrMask = k2_tiMask;

  k2_attrHandle = k2_tiHandle;
  k2_attrName = k2_tiName;
  k2_attrStyle = k2_tiStyle;
  k2_attrForeColor = k2_tiForeColor;
  k2_attrBold = k2_tiBold;
  k2_attrStrikeout = k2_tiStrikeout;
  k2_attrSize = k2_tiSize;
  k2_attrBackColor = k2_tiBackColor;
  k2_attrUnderline = k2_tiUnderline;
  k2_attrItalic = k2_tiItalic; 
  k2_attrFont = k2_tiFont; 

type
  Tk2FontParam = k2_tiName .. k2_tiIndex;

(*type
  Tk2TypeID = (
    _k2_idEmpty,          {-запрещенное значение} // 0
    _k2_idLong,           {-длинное целое}        // 1
    _k2_idEnum,           {-перечислимый тип}     // 2
    _k2_idBool,           {-Булевское значение}   // 3
    _k2_idColor,          {-цвет}                 // 4
    _k2_idString,         {-строка}               // 5
    _k2_idObject,         //_k2_idPitch,          {-тип ширины шрифта} // 6
    _k2_idJustification,  {-выравнивание}         // 7
    _k2_idRsr2,           //_k2_idOrientation,    {-ориентация} // 8
    _k2_idl3Base,         {-базовый тип библиотеки l3} // 9
    _k2_idTag,            {-базовый тип тэгов}    // 10
    _k2_idDocumentSub,    {-Sub документа}        // 11
    _k2_idSegment,        {-отрезок}              // 12
    _k2_idTextSegment,    {-отрезок текста}       // 13
    _k2_idHyperLink,      {-гипертекстовая ссылка}// 14
    _k2_idSub,            {-точка входа (Sub)}    // 15
    _k2_idList,           {-список}               // 16
    _k2_idSubLayer,       {-слой точек входа (Sub'ов)} // 17
    _k2_idDocSubLayer,    {-слой точек входа (Sub'ов) для документа} // 18
    _k2_idSegmentsLayer,  {-слой отрезков}        // 19
    _k2_idDocument,       {-документ}             // 20
    _k2_idPara,           {-базовый параграф}     // 21
    _k2_idTextPara,       {-текстовый параграф}   // 22
    _k2_idParaList,       {-список параграфов}    // 23
    _k2_idTable,          {-таблица}              // 24
    _k2_idSBS,            {-параграф Side By Side} // 25
    _k2_idTableRow,       {-строка таблицы}       // 26
    _k2_idTableColumn,    {-ячейка таблицы}       // 27
    _k2_idHandle,         {-идентификатор}        // 28
    _k2_idInch,           {-дюйм}                 // 29
    _k2_idOList,          {-список}               // 30
    _k2_idPosition,       {-позиция в тексте}     // 31
    _k2_idObjectWithHandle, {-объект с Handl'ом}    // 32
    _k2_idSgLHandle,      {-идентификатор слоя отрезков} // 33
    _k2_idSbLHandle,      {-идентификатор слоя точек входа (Sub'ов)} // 34
    _k2_idFontName,       {-имя шрифта}           // 35
    _k2_idFont,           {-шрифт}                       // 36
    _k2_idPercentSign,    {-знак процента % - спецзначение для записи в EVD}            // 37
    _k2_idStyle,          {-стиль}                // 38
    _k2_idTextStyle,      {-стиль текста}         // 39
    _k2_idFramePart,      {-часть рамки (верх, низ, право, лево)} // 40
    _k2_idFrame,          {-рамка}                // 41
    _k2_idRsr3,           {-параметры параграфа}  // 42
    _k2_idRsr4,           {-параметры текстового параграфа} // 43
    _k2_idReserved6,      //_k2_idMergeStatus,    {-статус объединения ячеек см. TevMergeStatus} // 44
    _k2_idReserved2,      {_k2_idSubs,     -список точек входа (Sub'ов)} // 45
    _k2_idNodeGroup,      // - группа нод // 46
    _k2_idCloak,          // Cloak - сворачивающаяся группа // 47 {_k2_idDocSubs   -список точек входа (Sub'ов) документа} // 47
    _k2_idDictEntryBlock, {- элемент словарной статьи. } // 48
    _k2_idDictEntry,      {- словарная статья. }         // 49
    _k2_idBlock,          {-блок параграфов}             // 50
    _k2_idObjectSegment,  {-контейнер для объекта}       // 51
    _k2_idSimpleDocumentTextPara, {-текстовый параграф в "простых документах"} // 52
    _k2_idTableTextPara,  {-текстовый параграф в таблице}// 53
    _k2_idAnnoTopic,                                     // 54

    _k2_idReqGroup,       {-группа реквизитов}           // 55
    {резервные типы для текстов}
    _k2_idTextRsr4,                                      // 56
    _k2_idTextRsr5,                                      // 57
    _k2_idTextRsr6,                                      // 58
    _k2_idTextRsr7,                                      // 59
    _k2_idTextRsr8,                                      // 60
    _k2_idTextRsr9,                                      // 61
    _k2_idTextRsr10,                                     // 62
    _k2_idTextRsr11,                                     // 63
    _k2_idTextRsr12,                                     // 64
    _k2_idTextRsr13,                                     // 65
    _k2_idTextRsr14,                                     // 66
    _k2_idTextRsr15,                                     // 67
    _k2_idTextRsr16,                                     // 68
    _k2_idTextRsr17,                                     // 69
    _k2_idTextRsr18,                                     // 70
    _k2_idTextRsr19,                                     // 71
    
    _k2_idDecorTextPara, // - текстовый параграф - оформление, не редактируется, не участвует в поиске // 72

    _k2_idDictItem,     {- "продвинутый" элемент словаря} // 73
    _k2_idDictRec,      {-элемент словаря}               // 74
    _k2_idDate,         {-дата}                          // 75
    _k2_idType,         {-тип объекта}                   // 76
    _k2_idAddress,      {-адрес объекта}                 // 77

    _k2_idLogRecord,                                     // 78
    _k2_idStagePrim,                                     // 79
    _k2_idStage,                                         // 80
    _k2_idCheck,        // 81
    _k2_idNumANDDate,   // 82

    _k2_idTinyDocument, {-простейший документ}           // 83
    _k2_idActiveInterval, // 84
    _k2_idAlarm,        // 85
    _k2_idAutoClass,    // 86

    _k2_idDictItemEx,   // 87
    _k2_idPIRec,        // 88
    _k2_idNSRCTag,      // 89
    _k2_idParticipant,  // 90
    _k2_idNSRCRsr0,     // 91

    _k2_idNSRCRsr1,     // 92
    _k2_idNSRCRsr2,     // 93
    _k2_idNSRCRsr3,     // 94
    _k2_idNSRCEnd,      // 95
    _k2_idRawData,      {-"сырые"-данные}           {96}
    _k2_idBitmapPara,   {-параграф с BMP-картинкой} {97}
    _k2_idIUnknown,     {-интерфейс}                {98}
    _k2_idHFParent,                                 {99}
    _k2_idHeader,       {-верхний колотутул}        {100}
    _k2_idFooter,       {-нижний колонтитул}        {101}
    _k2_idDivision,     {-раздел}                   {102}
    _k2_idPageBreak,    {-разрыв страницы}          {103}
    _k2_idSectionBreak, {-разрыв раздела}           {104}
    _k2_idSimpleDocument, {-"простой" документ}     {105}
    _k2_idPageProperties,{-параметры страницы}      {106}
    _k2_idTreePara,      {-дерево}                  {107}
    _k2_idSBSRow,        {-строка подписи}          {108}
    _k2_idSBSCell,       {-ячейка подписи}          {109}
    _k2_idFormula,       {-формула}                 {110}
    _k2_idBullet,        {-тип элемента списка}     {111}
    _k2_idLogRecordPrim,                            {112}
    _k2_idTime,          {-время}                   {113}
    _k2_idTabStop,       // - позиция табуляции      114
    _k2_idBookmark,      // - закладка               115
    _k2_idMark,          // - вспомогательный значок 116
    _k2_idLeafPara,      // - "листьевой" параграф   117
    _k2_idStyledLeafPara, // - "листьевой" параграф с оформлением 118
    _k2_idControlPara,   // - параграф представляющий собой контрол ввода 119
    _k2_idCommentPara,   // - блочный параграф с комментарием 120
    _k2_idControlsBlock, // - блочный параграф с контролами   121
    _k2_idXML,           // - XML-документ                    122
    _k2_idXMLTag,        // - XML-тег                         123
    _k2_idTagName,       // - имя тега                        124
    _k2_idAttr,          // - атрибут тега                    125
    _k2_idAttrName,      // - имя атрибута                    126
    _k2_idAttrValue,     // - значение атрибута               127
    _k2_idTagBody,       // - тело тега                       128
    _k2_idQueryCard,     // - окно запроса                    129
    _k2_idReqRow,        // - строка контролов (реквизит)     130
    _k2_idReqCell,       // - ячейка строки реквизита         131
    _k2_idExtDataPara,   // - параграф с данными во внешнем формате 132
    _k2_idContentsElement, // - элемент структуры документа   133
    _k2_idLeafParaDecorationsHolder, // контейнер декораций    134
    _k2_idAutoreferatDocument, // 135
    _k2_idVersion,             // 136
    _k2_idImageListBitmap,     // 137
    _k2_idDocumentQuery,       // 138
    _k2_idEditablePart         // 139
  );//Tk2TypeID*)

//  Tk2EffTypeID = Succ(Low(Tk2TypeID)) .. High(Tk2TypeID);
  Tk2EffTypeID = 1 .. 255;

//const   
  //k2_idString      = Ord(_k2_idString     );
  //k2_idString      = 5;
   {* - строка (см. Tl3CustomString, Tl3String). }
   
implementation

end.

