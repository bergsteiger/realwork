unit ddNSRC_w;

{ $Id: ddNSRC_w.pas,v 1.344 2016/08/11 11:37:45 lukyanets Exp $ }

// $Log: ddNSRC_w.pas,v $
// Revision 1.344  2016/08/11 11:37:45  lukyanets
// Вычищаем поддержку 133 версии
//
// Revision 1.343  2016/06/16 05:40:04  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.342  2016/03/16 13:56:23  voba
// -k:619568279
//
// Revision 1.341  2016/03/16 13:09:29  voba
// -k:619568279
//
// Revision 1.340  2016/03/16 11:00:30  voba
// -k:619568279
//
// Revision 1.339  2015/11/23 11:37:13  lukyanets
// Заготовки Renum
//
// Revision 1.338  2015/10/22 14:47:29  lulin
// - задаём ID документа снаружи.
//
// Revision 1.337  2015/10/21 14:16:18  lulin
// {RequestLink:605383118}.
//
// Revision 1.336  2015/10/02 10:31:32  voba
// - bf - большие UserID храним как отрицательные
//
// Revision 1.335  2015/09/29 13:58:04  voba
// -k:608012012
//
// Revision 1.334  2015/08/26 11:22:12  lulin
// {RequestLink:606129271}
//
// Revision 1.333  2015/07/02 11:41:28  lukyanets
// Описываем словари
//
// Revision 1.332  2015/07/02 07:36:05  lukyanets
// Описываем словари
//
// Revision 1.331  2015/02/04 14:15:26  dinishev
// {Requestlink:587628610}
//
// Revision 1.330  2015/01/19 18:39:40  lulin
// {RequestLink:580710025}
//
// Revision 1.329  2014/09/04 12:12:31  dinishev
// {Requestlink:564750095}. Перенес интерфейсы листнетов в ddTypes
//
// Revision 1.328  2014/09/04 11:02:00  dinishev
// {Requestlink:564750095}
//
// Revision 1.327  2014/08/29 12:24:47  lulin
// - вычищаем ненужную директиву.
//
// Revision 1.326  2014/04/25 15:58:50  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.325  2014/03/27 14:29:07  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.324  2014/03/20 14:18:40  voba
//  k:236721575 (Атрибуты в EVD)
//
// Revision 1.323  2014/03/20 05:18:40  dinishev
// Недокоммител.
//
// Revision 1.322  2014/03/03 16:07:52  lulin
// - избавляемся от странностей.
//
// Revision 1.321  2014/02/24 16:51:00  lulin
// - чистим код.
//
// Revision 1.320  2014/02/12 09:26:04  voba
// - k:503646158
//
// Revision 1.319  2014/02/06 12:20:57  dinishev
// {Requestlink:516178478}
//
// Revision 1.318  2013/12/27 04:41:32  dinishev
// Bug fix; не компилировалось.
//
// Revision 1.317  2013/12/26 15:14:18  dinishev
// {Requestlink:511186785}. Последний вариант.
//
// Revision 1.316  2013/12/25 09:31:35  dinishev
// Переформатирование.
//
// Revision 1.315  2013/12/17 13:44:00  dinishev
// {Requestlink:508453984}
//
// Revision 1.314  2013/12/13 10:06:15  dinishev
// {Requestlink:508822756}
//
// Revision 1.313  2013/12/13 07:33:02  dinishev
// Чистка кода.
//
// Revision 1.312  2013/11/20 15:21:35  voba
// - переход на 134 версию БД (bug fix)
//
// Revision 1.311  2013/10/21 17:31:11  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.310  2013/10/21 15:43:16  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.309  2013/10/21 10:31:05  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.308  2013/10/18 14:11:37  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.307  2013/07/12 14:54:19  voba
// -bug fix
//
// Revision 1.306  2013/07/11 13:40:17  voba
// - K:463114395
//
// Revision 1.305  2013/04/10 16:00:52  lulin
// - портируем.
//
// Revision 1.304  2013/04/05 12:04:30  lulin
// - портируем.
//
// Revision 1.303  2013/03/21 12:04:47  narry
// Команда !COMPARECONTENTS выливается перед командой !BLOCK (440434932)
//
// Revision 1.302  2013/03/06 06:54:51  dinishev
// Правки для тестов.
//
// Revision 1.301  2013/02/21 05:54:01  dinishev
// Bug fix: отвалились тесты в DailyTest
//
// Revision 1.300  2013/02/20 09:22:39  dinishev
// {Requestlink:431360596}
//
// Revision 1.299  2013/02/19 08:19:05  dinishev
// {Requestlink:338461122}. Проверка создания файла с картинкой.
//
// Revision 1.298  2013/01/28 12:48:40  narry
// Поправить экспорт_импорт что бы выливался !KIND вместо !PREFIX (425040214)
//
// Revision 1.297  2013/01/25 06:31:01  narry
// При экспорте !COMPARECONTENTS из шапки попадает в первый блок (425045125)
//
// Revision 1.296  2012/10/29 14:54:06  lulin
// - вычищаем поддержку ветки редактора.
//
// Revision 1.295  2012/08/22 10:51:20  voba
// - K: 387090743
//
// Revision 1.294  2012/07/26 14:33:35  voba
// - bug fix
//
// Revision 1.293  2012/07/10 10:03:14  narry
// Отчет о результатах экспорта (375424204)
//
// Revision 1.292  2012/06/27 07:19:24  narry
// Номер издания и комментарий выливались в неправильной кодировке
//
// Revision 1.291  2012/06/18 08:53:26  narry
// Выливалась ненужная команда !BLOCKDATA
//
// Revision 1.290  2012/06/07 10:52:22  narry
// Временное отключение использования команды DocType для стандартных типов документа
//
// Revision 1.289  2012/06/07 10:39:31  narry
// Новые пользовательские типы документов "Общая структура ААК" и "ААК - содержание" (365831611)
//
// Revision 1.288  2012/06/06 14:18:35  narry
// "Правые" и "левые" блоки для ААК (365831635)
//
// Revision 1.287  2012/05/21 13:34:40  narry
// Избавляемся от двойного преобразования атрибутов для справок
//
// Revision 1.286  2012/03/27 09:04:20  voba
// - k : 344753123
//
// Revision 1.285  2012/03/26 12:55:29  narry
// Выливаются лишние данные про картинки (Выливаются лишние данные про картинки)
//
// Revision 1.284  2012/01/31 06:37:10  narry
// Экспорт(импорт) !COMPARECONTENTS (332563861)
//
// Revision 1.283  2012/01/26 07:56:26  fireton
// - команда !*HANG (K 330696104)
//
// Revision 1.282  2011/12/21 14:45:08  fireton
// - новая команда !*INTERNET (К 321986367)
//
// Revision 1.281  2011/11/15 10:22:05  voba
// - bug fix
//
// Revision 1.280  2011/11/15 09:57:18  voba
// - k: http://mdp.garant.ru/pages/viewpage.action?pageId=177963133&focusedCommentId=297712659#comment-297712659
//
// Revision 1.279  2011/10/21 13:11:59  narry
// Накопившиеся изменения
//
// Revision 1.278  2011/10/19 06:44:33  narry
// Неправильная структура папок для ObjTopic (281529576)
//
// Revision 1.277  2011/10/05 10:56:36  voba
// - k : 281525254 Борьба с утечками
//
// Revision 1.275  2011/09/13 09:22:55  narry
// Ключи приклеивались к классам
//
// Revision 1.274  2011/09/08 06:33:39  narry
// Избавиться от склеивания Классов (282692606)
//
// Revision 1.273  2011/09/06 10:38:24  narry
// Строки в NSRCWriter (281525254)
//
// Revision 1.272  2011/08/30 09:13:39  narry
// Расширение для объектов в файлах объектных топиков (280006721)
//
// Revision 1.271  2011/08/10 12:37:13  narry
// Рефакторинг
//
// Revision 1.270  2011/07/06 11:30:10  narry
// AV если пустой поток объекта
//
// Revision 1.269  2011/04/14 07:54:28  narry
// Не добавлять Рисунок N (262636447)
//
// Revision 1.268  2011/04/11 10:25:01  narry
// Названия для ФАС (259885290)
//
// Revision 1.267  2011/04/08 05:33:04  narry
// К260442475. Экспорт пустого внешнего объекта
//
// Revision 1.266  2011/03/04 11:46:39  dinishev
// [$253662415]
//
// Revision 1.265  2011/02/08 14:35:52  narry
// К253662098. Не экспортируется объект, отличный от картинки
//
// Revision 1.264  2011/02/03 14:12:30  narry
// K251341845. Сохранение ссылок
//
// Revision 1.263  2011/01/28 13:48:20  voba
// Неправильный путь к файлу картинки
//
// Revision 1.262  2011/01/24 12:57:41  narry
// K239377663. Импорт(экспорт) FLASHTOPIC
//
// Revision 1.261  2011/01/14 12:46:26  lulin
// [$250088909].
// - выкинут мусор.
//
// Revision 1.260  2011/01/14 12:40:40  narry
// - Удаление записи Archicheck и связанных с ней модулей
//
// Revision 1.259  2011/01/14 07:32:23  narry
// K250086166.
//
// Revision 1.258  2011/01/13 13:08:31  narry
// K250086166.
//
// Revision 1.257  2011/01/13 12:53:54  narry
// K250086166.
//
// Revision 1.256  2010/12/23 12:37:58  narry
// 248194216. Экспорт изображений
//
// Revision 1.255  2010/11/22 15:41:49  narry
// К242844511. Пропадают BELONGS не только в редакциях
//
// Revision 1.254  2010/11/22 11:45:34  narry
// К242515990. Пропадают Belongs в редакциях
//
// Revision 1.253  2010/11/19 09:16:01  narry
// К242515990. Пропадают Belongs в редакциях
//
// Revision 1.252  2010/09/24 12:10:36  voba
// - k : 235046326
//
// Revision 1.251  2010/07/16 07:03:39  narry
// - K224789963
//
// Revision 1.250  2010/05/12 11:41:34  narry
// - заточки под конвертер
//
// Revision 1.249  2010/03/10 13:57:24  narry
// - не собиралось
//
// Revision 1.248  2010/02/24 18:22:44  lulin
// - избавляемся от ненужного и вредного параметра, доставшегося в наследство от ошибок молодости.
//
// Revision 1.247  2010/02/15 10:28:11  narry
// - поддержка команды !NOCOMPARE
//
// Revision 1.246  2010/02/11 14:40:34  lulin
// {RequestLink:190679656}.
// - чистка того, что не собиралось.
//
// Revision 1.245  2010/02/04 09:17:16  voba
// - отключили команду LANGUAGE
//
// Revision 1.244  2010/02/03 08:57:18  narry
// - обновление
//
// Revision 1.243  2010/01/22 19:14:55  lulin
// - убираем мусор.
//
// Revision 1.242  2010/01/22 19:10:30  lulin
// - в тестах тоже корректно пишем адреса гиперссылок.
//
// Revision 1.241  2009/12/07 13:35:25  narry
// - некорректное преобразование NSRC+ в NSRC
//
// Revision 1.240  2009/11/11 12:50:35  narry
// - обновление
//
// Revision 1.239  2009/09/22 11:52:36  narry
// - исправлена ошибка форматирования сложных названий
//
// Revision 1.238  2009/09/15 13:21:49  narry
// - поддержка команды !CASECODE
//
// Revision 1.237  2009/09/11 11:18:18  narry
// - промежуточное обновление
//
// Revision 1.236  2009/08/28 14:36:26  voba
// - убрал utFullFeatureDocTypesEx
//
// Revision 1.235  2009/08/24 10:46:41  narry
// - не выливались картинки
//
// Revision 1.234  2009/07/23 08:15:11  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.233  2009/07/22 11:27:31  narry
// - изменение доступа к DictServer
//
// Revision 1.232  2009/06/23 14:01:37  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.231  2009/06/23 09:01:39  narry
// - не собиралось
//
// Revision 1.230  2009/06/01 16:07:45  lulin
// [$148574348].
//
// Revision 1.229  2009/05/15 14:18:47  dinishev
// [$147490351]
//
// Revision 1.228  2009/03/31 09:02:55  fireton
// - импорт/экспорт атрибута "Комментарий к документу" [$121164344]
//
// Revision 1.227  2009/03/04 14:17:47  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.226  2009/02/20 13:27:54  fireton
// - команда !CHANGE (K 77235676)
// - 131 версия базы
//
// Revision 1.225  2009/01/16 15:46:08  narry
// - для !LANGUAGE выливался *
//
// Revision 1.224  2009/01/13 16:19:14  narry
// - татары
//
// Revision 1.223  2008/09/23 12:17:48  fireton
// - импорт/экспорт номера судебного дела
//
// Revision 1.222  2008/09/17 14:47:45  fireton
// - новая версия базы (130)
// - срочность документа
//
// Revision 1.221  2008/06/20 14:49:11  lulin
// - используем префиксы элементов.
//
// Revision 1.220  2008/06/10 14:02:19  narry
// - обновление
//
// Revision 1.219  2008/06/10 10:55:18  fireton
// - поддержка Flash-документов
//
// Revision 1.218  2008/06/06 11:16:43  voba
// - ишем !LOG в ObjTopic
//
// Revision 1.217  2008/05/23 16:04:45  lulin
// - <K>: 91848978.
//
// Revision 1.216  2008/05/08 14:04:08  fireton
// - перенос объектов в потоках из ветки
//
// Revision 1.215  2008/04/11 16:09:01  narry
// - ошибка добавления пустой строки в конец документа
//
// Revision 1.214  2008/04/04 14:51:30  narry
// - пропал перевод строки
//
// Revision 1.213  2008/03/21 17:30:41  narry
// - поддержка PNG для ObjTopic
//
// Revision 1.212  2008/03/21 14:09:22  lulin
// - cleanup.
//
// Revision 1.211  2008/03/13 14:44:57  narry
// - ARCHICHECK выливается только для документов
//
// Revision 1.210  2008/02/27 15:59:54  narry
// - переименовал условие
//
// Revision 1.209  2008/02/26 12:58:13  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.208  2008/02/26 12:30:57  lulin
// - боремся за чистоту арийской рассы.
//
// Revision 1.207  2008/02/20 17:22:59  lulin
// - упрощаем строки.
//
// Revision 1.206  2008/02/20 12:06:14  narry
// - поддержка команды !ARCHICHECK
//
// Revision 1.205  2008/02/19 14:58:49  lulin
// - переводим сортировку списков на новые, менее виртуальные, рельсы.
//
// Revision 1.204  2008/02/05 12:49:12  lulin
// - упрощаем базовые объекты.
//
// Revision 1.203  2008/02/05 09:58:00  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.202  2008/02/01 15:14:44  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.201  2008/01/30 09:16:53  narry
// - длинное название режется на строки только по пробелам
//
// Revision 1.200  2008/01/18 14:09:52  narry
// - импорт команды !SERVICEINFO для  NODOC
//
// Revision 1.199  2007/11/22 07:28:11  voba
// - enh. фильтруем _k2_idBookmark
//
// Revision 1.198  2007/09/14 13:26:17  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.197.4.1  2007/09/12 19:13:23  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.197  2007/09/03 15:21:06  fireton
// - k2_tiBitmap -> _k2_tiData
//
// Revision 1.196  2007/08/23 14:14:25  narry
// - ошибка разрезания длинного названия в случае длинной последовательности цифр в названии
//
// Revision 1.195  2007/08/14 19:31:52  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.194  2007/08/09 16:44:44  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.193  2007/08/09 11:19:17  lulin
// - cleanup.
//
// Revision 1.192  2007/06/25 12:18:48  narry
// - поддержка команды !SERVICEINFO
//
// Revision 1.191  2007/01/18 08:01:34  narry
// - ошибка в форматировании PUBLISHEDIN
//
// Revision 1.190  2007/01/10 14:52:46  voba
// - bug fix
//
// Revision 1.189  2007/01/10 14:33:50  narry
// - VINCLUDED для всех типов документа
//
// Revision 1.188  2006/12/11 14:52:32  voba
// - use utFullFeatureDocTypes
//
// Revision 1.187  2006/12/08 15:25:10  voba
// - use MakeDateIntervalStr
//
// Revision 1.186  2006/12/05 14:57:23  narry
// - поддержка команды !*LOG
//
// Revision 1.185  2006/12/05 13:49:02  voba
// - add !*Log record out
//
// Revision 1.184  2006/11/03 11:00:39  lulin
// - объединил с веткой 6.4.
//
// Revision 1.183.2.1  2006/10/26 11:24:17  lulin
// - избавляемся от лишних преобразований типов.
//
// Revision 1.183  2006/10/03 11:48:12  narry
// - поддержка команды IZM
//
// Revision 1.182  2006/08/03 13:44:57  narry
// - борьба с ненужным дефисом в ACTIVE
//
// Revision 1.181  2005/12/19 11:43:47  narry
// - новое: поддержка команды !*ANNOIMPORTANT
//
// Revision 1.180  2005/12/01 13:04:13  narry
// - обновление: новый аннокласс
//
// Revision 1.179  2005/11/10 13:38:11  narry
// - изменение: флажок необходимости записи о вычитке базируется на acIncluded
//
// Revision 1.178  2005/11/02 16:37:05  narry
// - исправление: неверный формат команды !ACTIVE
//
// Revision 1.177  2005/10/18 09:13:25  narry
// - исправление: неправильная дата интервала действия
//
// Revision 1.176  2005/09/16 11:23:57  narry
// - обновление: расширение команды PUBLISHEDIN
// - обновление: поправка команды BOOK
//
// Revision 1.175  2005/09/02 12:45:30  narry
// - new: запись дополнительных команд !*PUBLISHEDIN
//
// Revision 1.174  2005/03/28 14:39:01  narry
// - bug fix:
//
// Revision 1.173  2005/03/28 11:32:18  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.172  2005/03/22 14:05:53  narry
// - bug fix: AV
//
// Revision 1.171  2005/03/22 12:59:14  narry
// - bug fix: проглатывалась шапка документа
//
// Revision 1.170  2005/03/21 17:02:26  lulin
// - используем правильный тип описателя свойства.
//
// Revision 1.169  2005/03/21 10:04:55  lulin
// - new interface: _Ik2Type.
//
// Revision 1.168  2005/03/19 16:40:02  lulin
// - спрятаны ненужные методы.
//
// Revision 1.167  2005/03/17 16:37:58  lulin
// - bug fix: выливка в NSRC теперь учитывает возможность наличия вложенных документов.
//
// Revision 1.166  2005/03/15 12:16:12  lulin
// - remove method: k2TagO.
//
// Revision 1.165  2005/02/24 15:24:49  narry
// - update
//
// Revision 1.164  2005/02/18 17:40:08  step
// переименование: dlAnnoClass -> dlAnnoClasses
//
// Revision 1.163  2005/02/16 17:11:14  narry
// - update: поддержка Аннотаций
//
// Revision 1.162  2004/09/21 12:21:05  lulin
// - Release заменил на Cleanup.
//
// Revision 1.161  2004/09/14 15:58:03  lulin
// - удален модуль Str_Man - используйте вместо него - l3String.
//
// Revision 1.160  2004/09/01 13:36:55  narry
// - update
//
// Revision 1.159  2004/08/18 12:32:37  narry
// - bug fix: Edition считались документами
//
// Revision 1.158  2004/08/17 06:27:41  narry
// - update
//
// Revision 1.157  2004/07/28 14:16:03  narry
// - update: окончание реализации поддержки команды !NOTTM
//
// Revision 1.156  2004/07/23 14:59:53  narry
// - new: поддержка команды !NOTTM
//
// Revision 1.155  2004/06/30 11:32:24  law
// - rename proc: _k2Tag(TObject) -> k2TagO.
//
// Revision 1.154  2004/06/17 11:27:18  narry
// - bug fix: для источника ДСП выливалась команда !PUBLISHEDIN
//
// Revision 1.153  2004/06/08 06:31:30  narry
// - bug fix: первый документ в выборке выливался без шапки
//
// Revision 1.152  2004/06/04 09:28:47  narry
// - update: запись !CONTENTS  с нулем
// - update: различные типы objtopic
//
// Revision 1.151  2004/06/01 16:51:23  law
// - удален конструктор Tl3VList.MakePersistent - пользуйтесь _Tl3ObjectRefList.
//
// Revision 1.150  2004/05/18 13:36:43  narry
// - update: преобразовние кодовой страницы для словарных статей
// - bug fix: не выливался !BLOCK для пустых блоков
//
// Revision 1.149  2004/05/14 17:27:04  law
// - remove unit: evStrGen.
//
// Revision 1.148  2004/05/14 14:48:50  law
// - исправлены префиксы у констант.
//
// Revision 1.147  2004/05/14 14:08:53  law
// - change: TevVariant переименован в Tk2Variant и переехал в k2Types.
//
// Revision 1.146  2004/04/29 13:20:03  narry
// - new: поддержка команды !TERM
//
// Revision 1.145  2004/04/26 14:18:01  narry
// - bug fix: символ #13 в длинном имени документа разрывал имя на две строки, если имя было короче 73 символов
// - bug fix: в короткие имена документа, метки и блока попадал символ табуляции
//
// Revision 1.144  2004/04/16 12:56:03  narry
// - bug fix: команда !CONTENTS от документа попадала в первый блок
//
// Revision 1.143  2004/04/12 12:24:26  narry
// - update: поддержка нового формата !CONTENTS
//
// Revision 1.142  2004/04/12 08:20:00  law
// - change: "оказалось" что у команды !Contents другой формат.
//
// Revision 1.141  2004/04/05 12:07:02  narry
// - update: для VANONCED документов более не выливается !DOC
//
// Revision 1.140  2004/04/05 11:15:05  narry
// - update: подчистка артефактов использования предыдущей графической библиотеки
//
// Revision 1.139  2004/03/23 09:44:02  narry
// - update: подключение команды NOTSURE
//
// Revision 1.138  2004/03/17 13:31:41  narry
// - new: поддержка расширенного формата команды !PUBLISHEDIN
//
// Revision 1.137  2004/03/09 11:34:12  narry
// - new: поддержка команды !NOTSURE
//
// Revision 1.136  2004/03/05 15:04:46  narry
// - update: поддержка команды !CONTENTS
//
// Revision 1.135  2004/02/27 09:31:49  narry
// - bug fix: пустая дата экспортировалась как 01/01/1600 вместо пустой строки
//
// Revision 1.134  2004/02/10 15:28:08  narry
// - change: для NoDoc выливается команда !PUBLISHEDIN
//
// Revision 1.133  2004/02/03 15:51:00  narry
// - update
//
// Revision 1.132  2004/01/29 13:34:35  narry
// - update: поддержка нового формата команды !PUBLISHEDIN
//
// Revision 1.131  2003/12/11 16:26:34  law
// - cleanup: добавлено значение параметра по умолчанию.
//
// Revision 1.130  2003/12/09 09:30:42  narry
// - change: для типа документа utEdition выливается Name и ChDate
//
// Revision 1.129  2003/12/01 15:20:34  narry
// - cleanup
// - bug fix: Integer overflow при формировании номера блока глубокой вложенности
// -change: переименование пункта "Произвольно" в "Больше пяти уровней" и перенос его в конец списка
//
// Revision 1.128  2003/11/27 16:27:50  narry
// - cleanup
// - add: удаление конечных переводов строки в имени документа
//
// Revision 1.127  2003/11/26 14:26:17  narry
// - bug fix: пропуск !SUB для !NODOC приводил к нарушению структуры документов
//
// Revision 1.126  2003/11/21 12:12:24  narry
// - bug fix: для документов типа Edition выливались классы для меток и блоков
//
// Revision 1.125  2003/09/23 15:08:25  narry
// - new: !VINCLUDED для всех кроме справок
//
// Revision 1.124  2003/09/19 13:46:58  narry
// - change: сняты все ограничения с команды !VINCLUDED
//
// Revision 1.123  2003/08/22 09:09:04  narry
// - new: поддержка команды !CHDATE
//
// Revision 1.122  2003/08/21 12:14:26  voba
// - поправил перечислимый типTDNType
//
// Revision 1.121  2003/08/01 12:57:56  narry
// - заглушка
//
// Revision 1.120  2003/07/23 15:02:59  narry
// - bug fix: Range check при присвоении идентификатора источника вычитки
//
// Revision 1.119  2003/07/23 11:41:42  narry
// - bug fix: по неизвестной причине был закомментирован фрагмент кода, отвечающий за накопление информации о вычитке (!CHECK)
//
// Revision 1.118  2003/07/09 07:02:00  narry
// - bug fix: команда !CALENDAR выливалась вместе с !NODOC
//
// Revision 1.117.4.2  2003/07/09 06:59:06  narry
// - bug fix: команда !CALENDAR выливалась вместе с !NODOC
//
// Revision 1.117.4.1  2003/07/08 15:30:24  narry
// - bug fix: utCalendar вновь стал документом
//
// Revision 1.117  2003/04/25 12:08:19  narry
// - bug fix: неправильная логика определения трансляции интервала активности
//
// Revision 1.116  2003/04/19 12:30:37  law
// - new file: ddDefine.inc.
//
// Revision 1.115  2003/04/18 11:14:12  narry
// - change: !Priority выливается только для utNone и utDoc
//
// Revision 1.114  2003/04/16 07:15:04  narry
// - bug fix: для NoDoc не выливались префиксы и классы в шапке документа
//
// Revision 1.113  2003/04/11 12:05:22  narry
// - add: причисление типов Business, UserInfo и Calendar к лику NoDoc
//
// Revision 1.112  2003/04/10 13:17:37  narry
// - change: запрет добавления команды !ACTIVE без параметов
//
// Revision 1.111  2003/04/04 17:06:08  narry
// - update: подавление пробела при отсутствии комментария
//
// Revision 1.110  2003/03/17 15:53:43  narry
// - update
//
// Revision 1.109  2003/03/17 13:20:00  narry
// Новые команды версионности
//
// Revision 1.108  2003/03/14 09:55:35  narry
// - new: команды версионности. Компиляется, но не работает.
//
// Revision 1.107  2003/01/30 10:55:52  narry
// - udate
//
// Revision 1.106  2003/01/30 10:34:37  narry
// - new behavior: выливка SubID=0 для команд версионности
//
// Revision 1.105  2003/01/29 14:11:07  narry
// - update: условие компиляции для версионных комманд
//
// Revision 1.104  2003/01/27 16:40:37  narry
// - update: обработка двойных кавычек в командах VerXXXChanger
//
// Revision 1.103  2003/01/20 14:03:27  narry
// - update: поддержка версионности
//
// Revision 1.102  2003/01/16 14:51:22  narry
// - new behavior: поддержка версионности блоков
//
// Revision 1.101  2003/01/10 10:20:25  narry
// - new behavior: добавление команды !NODOC для !BUSINESS
//
// Revision 1.100  2002/12/24 13:01:59  law
// - change: объединил Int64_Seek c основной веткой.
//
// Revision 1.99.2.1  2002/12/24 11:56:42  law
// - new behavior: используем 64-битный Seek вместо 32-битного.
//
// Revision 1.99  2002/11/15 08:53:28  voba
// - bug fix: ошибка при выливке в анонс документа без дат
//
// Revision 1.98  2002/11/14 10:04:31  narry
// - bug fix: метод cut&paste в очредной раз доказал свою несостоятельность - не выливались Warnings для NODOC
//
// Revision 1.97  2002/11/01 08:04:00  narry
// - bug fix: в качестве минимальной даты всегда был 0
//
// Revision 1.96  2002/10/25 13:41:16  law
// - cleanup.
//
// Revision 1.95  2002/10/22 10:43:25  narry
// - update
//
// Revision 1.94  2002/10/18 10:55:22  narry
// - update: изменение специальной даты на 29/05/1997
//
// Revision 1.93  2002/10/18 09:34:26  narry
// - update: для сравнения с VAnonced вместо VIncluded берется минимальная Date
//
// Revision 1.92  2002/10/17 13:58:49  narry
// - new behavior: при экспорте анонсов проверка даты подключения на диапазон 45 дней
//
// Revision 1.91  2002/10/09 11:44:04  narry
// - new behavior: экспорт Warnings для NODOC
//
// Revision 1.90  2002/09/24 15:22:40  voba
// - rename unit: evTxtExp -> evTextFormatter.
//
// Revision 1.89  2002/09/18 08:06:12  voba
// - cleanup: удален параметр IsDefault.
//
// Revision 1.88  2002/09/05 12:00:24  narry
// - new behavior: support for k2_idDictItem
//
// Revision 1.87  2002/09/03 08:00:23  narry
// - new behavior: support for k2_idDictItem
//
// Revision 1.86  2002/07/30 15:58:16  narry
// - new behavior: поддержка Strikeout
//
// Revision 1.85  2002/07/12 09:30:03  narry
// - bug fix: не выливалась команда !MOJNOTREG
//
// Revision 1.84  2002/06/10 10:25:26  narry
// - new behavior: при выливке команды !CALENDAR к документу добавляется !DOC
//
// Revision 1.83  2002/04/02 13:46:19  narry
// - new behavior: поддержка команды !REFDOC
//
// Revision 1.82  2002/03/27 23:00:01  narry
// - update
//
// Revision 1.81  2002/02/28 15:08:00  narry
// - update
//
// Revision 1.80  2002/02/07 15:13:22  narry
// - update: выливка групп доступа для справок таких же, как у документов
//
// Revision 1.79  2002/02/01 11:47:21  narry
// - bug fix: не выливалась команда !MAIN
//
// Revision 1.78  2001/11/22 13:58:43  narry
// - update : начало реализации Групп доступа
//
// Revision 1.77  2001/10/26 07:10:44  narry
// - bug fix: нулями заменялись все пробелы в !PUBLISHEDIN
//
// Revision 1.76  2001/10/25 10:35:36  narry
// - new behavior: изменение формата даты !PUBLISHEDIN
//
// Revision 1.75  2001/09/04 12:48:24  voba
// - bug fix: не находилась функция MakeDir.
//
// Revision 1.74  2001/08/31 11:02:36  law
// - rename unit: MyUtil -> l3FileUtils.
//
// Revision 1.73  2001/08/29 15:36:27  law
// - cleanup: удалены ненужные зависимости от Orpheus и SysTools.
//
// Revision 1.72  2001/08/23 14:27:45  voba
// no message
//
// Revision 1.71  2001/05/29 07:43:18  narry
// Update - запрет выливки комментарие
//
// Revision 1.70  2001/05/28 16:06:05  narry
// Update - поддержка длинных комментарий
//
// Revision 1.69  2001/05/08 12:28:24  narry
// Bug fix - PRO, VINCLUDED и DOC
//
// Revision 1.68  2001/05/07 11:40:06  narry
// Update - дополнительная проверка на !DOC для "Проектов"
//
// Revision 1.67  2001/05/07 10:27:24  narry
// Update - Не выливается !VINCLUDED при !BELONGS = PRO
//
// Revision 1.66  2001/04/25 14:14:11  narry
// Update - удаление пробела при отсутствии даты при !PREAVTIVE
//
// Revision 1.65  2001/04/17 07:51:46  narry
// Bug Fix - выливка пустой даты для !PREACTIVE
//
// Revision 1.64  2001/03/15 12:13:20  narry
// Исправлено - выливка картинок для не OBJTOPIC
//
// Revision 1.63  2001/03/14 13:24:53  law
// - some cleaup and tuning.
//
// Revision 1.62  2001/01/24 14:51:30  narry
// Disable log message Start export...
//
// Revision 1.61  2000/12/21 10:13:39  narry
// Combine !VANONCED with !DOC
//
// Revision 1.60  2000/12/19 16:05:18  law
// - убраны ненужные директивы компиляции.
//
// Revision 1.59  2000/12/19 15:06:27  law
// - #13#10 -> cc_EOL.
//
// Revision 1.58  2000/12/15 17:26:36  voba
// Доточил под новый Шуриков Stream
//
// Revision 1.57  2000/12/15 15:29:54  law
// - вставлены директивы Log и Id.
//

{$I ddDefine.inc}
{$I dtDefine.inc}

{$DEFINE PublishedIn}
{.$DEFINE OnlyInherited}
{$DEFINE VersionCommands}
{$DEFINE Suffix}
{$DEFINE AccGroups}
{$DEFINE NotSure}

{.$Define NoObjTopic} // = не выливать объектные топики, используется в тестовых целях

interface

uses
  Classes,

  l3Types,
  l3Base,
  l3ObjectRefList,
  l3Date,
  l3StringList,

  k2Types,
  k2Interfaces,
  k2TagGen,
  k2Base,

  evdDOM,

  evNSRWrt,
  evNSRCPlusWriter,
  evInternalInterfaces,
  evGeneratorsInterfaces,

  daTypes,
  dt_Const, dt_Types, dt_AttrSchema
  , evdTypes, ddTypes;

type
  TddPIR = record
    ID         : Longint;
    Priv       : Boolean;
    Sour       : Tl3String;
    SDate      : TStDate;
    EDate      : TStDate;
    Number     : Tl3String;
    Comment    : Tl3String;
    Pages      : Tl3String;
    LinkComment: Tl3String;
  end;

  TSubRec = record
    ID: Longint;
    Name: Tl3String;
    f_Classes: Tl3StringList;
    RealName: Boolean;
    ViewKind: TevBlockViewKind;
    Style: Longint;
  end;

  TDictRec = record
    DictID: TdaDictionaryType;
    Handle: Longint;
    UserDict: Boolean;
    Name: Tl3String;
    ShortName: Tl3String;
  end;

  TStageRec = record
    SType: TStageType;
    BeginDate: TStDate;
    EndDate: TstDate;
    User: Longint;
  end;

  TDateNumRec = record
    rDNType: TDNType;
    rDate: TStDate;
    rNumber: Tl3String;
    rLinkDocID  : TDocID;
    rLinkSubID  : TSubID;
  end;

  TCheckRec = record
    Handle: Long;
    Date: TStDate;
    Sour    : Longint;
    CType: Byte;
    User: Longint;
    Comment: Tl3String;
  end;

  TLogRec = record
   rAction  : TLogActionType;
   rDate    : TStDate;
   rTime    : TStTime;
   rAuthor  : TdaUserID;
  end;

  TActiveIntervalRec = record
   RecType: Integer;
   Start,
   Finish: TStDate;
   Comment : AnsiString;
  end;

  TAlarmRec = record
   Start  : TstDate;
   Comment: AnsiString;
  end;

  TTopicInitEvent = procedure (Sender: TObject; TopicNo: Long) of object;
  TMsg2LogEvent   = procedure (Msg: AnsiString) of object;

  TddNSRCGenerator = class(TevNSRCPlusWriter, IevNSRCExport)
  private
    { Private declarations }
{ TODO -oNarry -cРазвитие : Добавить список ошибок экспорта}
    f_PathListner: IddSaveObjectPath;
    f_ErrorList: TStrings;
    f_PIR: TddPIR;
    f_SubRec: TSubRec;
    f_Block: TSubRec;
    f_DictRec: TDictRec;
    f_StageRec: TStageRec;
    f_DateNumRec: TDateNumRec;
    f_CheckRec: TCheckRec;
    f_LogRec: TLogRec;
    f_Doc2DocRec: TDoc2DocLinkRec;
    f_Belongs: Tl3String;
    f_AccGroups: Tl3String;
    f_Name: Tl3String;       { Полное имя }
    f_ShortName: Tl3String;  { Короткое имя }
    f_VanoncedStr: Tl3String;
    f_VanoncedStrL: Tl3String;
    f_TopicType : Long;            { Тип документа }
    f_UserType: TUserType;
    f_HasRel   : Boolean;
    f_isRelated: Boolean;          {  }
    f_DocIsStarted: Boolean;
    f_OnTopicInit: TTopicInitEvent;
    f_OnMsg2Log: TMsg2LogEvent;
    f_BelongsDone: Boolean;
    f_AccGroupsDone: Boolean;
    f_FileName: AnsiString;
    f_ExportDirectory: AnsiString;
    f_WorkVAnonced: Boolean;
    f_VAnoncedDateStr: AnsiString;
    f_VAnoncedDate: TStDate;
    f_MinDate: TstDate;
    VAnoncedWrited: Boolean;
    f_Readed: Boolean;
    f_ReadWrited: Boolean;
    f_RelNumber: Long;
    f_FirstPara: Boolean;
    f_ActiveInterval: TActiveIntervalRec;
    f_Alarm: TAlarmRec;
    FLevelCount6: Integer;
    FLevelCount5: Integer;
    f_BaseLine: Integer;
    f_CompareContents: Integer;
    f_DocumentType: Tk2Type;
    f_CurLang: TevdLanguage;
    f_DPI: Integer;
    f_PicNumber: Integer;
    f_NotFilterGroups: Boolean;
    f_OnError: TddErrorEvent;
    f_PictHandle: Integer;
    f_Stream: TStream;
    f_Verlink: Integer;
  private
    procedure AddActiveIntervalRec;
    procedure AddAlarmRec;
    procedure AddBelongs;
    procedure AddDoc2DocLink;
    procedure AddBlock;
    procedure AddCheckRec;
    procedure SetIsRelated(Value: Boolean);
    procedure AddContents;
    procedure AddCompareContents;
    procedure AddDateNumRec;
    procedure AddDictRec;
    procedure AddDocType;
    procedure AddLogRec;
    procedure AddNameComment(const aNameComment : Tl3PrimString);
    procedure AddPriceLevel(aPriceLevel: Integer);
    procedure AddPriority(aPriority: Integer);
    procedure AddPublInString;
    procedure AddRel;
    procedure AddRelated;
    procedure AddSortDate(aSortDate : integer);
    procedure AddStageRec;
    procedure AddSubRec;
    procedure AddTopic;
    procedure AddUrgency(aUrgency: Integer);
    procedure AddUserType;
    procedure AddVerLink;
    procedure ApplyToActiveInterval(AtomIndex: Long; const Value: Tk2Variant);
    procedure ApplyToAddress(AtomIndex: Long; const Value: Tk2Variant);
    procedure ApplyToAlarm(AtomIndex: Long; const Value: Tk2Variant);
    procedure ApplyToBitmapPara(AtomIndex: Long; const Value: Tk2Variant);
    procedure ApplyToBlock(AtomIndex: Long; const Value: Tk2Variant);
    procedure ApplyToCheck(AtomIndex: Long; const Value: Tk2Variant);
    procedure ApplyToDictRec(AtomIndex: Long; const Value: Tk2Variant);
    procedure ApplyToDocument(AtomIndex: Long; const Value: Tk2Variant);
    procedure ApplyToFirstPara(const Value: Tk2Variant);
    procedure ApplyToLog(AtomIndex: Long; const Value: Tk2Variant);
    procedure ApplyToNumAndDate(AtomIndex: Long; const Value: Tk2Variant);
    procedure ApplyToPublished(AtomIndex: Long; const Value: Tk2Variant);
    procedure ApplyToStage(AtomIndex: Long; const Value: Tk2Variant);
    procedure ApplyToString(const Value: Tk2Variant);
    procedure ApplyToSub(AtomIndex: Long; const Value: Tk2Variant);
    function CheckValueType(const Value: Tk2Variant; aTypeKind : Tk2VarKind): Boolean;
                           procedure ClearHeader(aTypeID: Tk2Type);
    procedure ClearPIR;
    function NotAnObject: Boolean;
    procedure OutCommand(const aCommand: AnsiString; aWithSpace: Boolean = True);
    procedure OutDate(SD: Integer);
    procedure OutInteger(aValue: Integer);
    procedure OutSpace;
    procedure OutStartCommand;
    procedure WriteAnnoClass;
    procedure WriteObjTopic;
    procedure WriteExtDataPara;
    procedure WriteObjPath;
  protected
    { Protected declarations }
    procedure SaveObjFileName(const aFileName: AnsiString); override;
    procedure CheckNeed2AddBlock; override;
    procedure CloseStructure(NeedUndo: Bool); override;
    {-вызывается на закрывающуюся скобку}
    procedure OpenStream; override;

    procedure Cleanup; override;
    procedure Error(const aDescription: AnsiString; aCategory: Integer = 0);
    procedure MakeDateStr(SD: Integer; var aDateStr: AnsiString);
    procedure WriteName(aName: Tl3CustomString);
    procedure SetExportDirectory(const aDirName: AnsiString);
    function NeedOutSub: Boolean; override;
     {-}
   procedure OutStyle4Cell; override;
     {-}
  protected
    property IsRelated: Boolean
      read f_IsRelated write SetIsRelated;
    property Readed: Boolean
      read f_Readed write f_Readed;
  public
    { Public declarations }
    constructor Create(aOwner: Tk2TagGeneratorOwner = nil); override;

    procedure StartChild(TypeID: Tl3Type); override;
      {-}                    
    procedure LinkPathListner(const aListner: IddSaveObjectPath);
    procedure UnLinkPathListner(const aListner: IddSaveObjectPath);
    procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
    procedure LS(const Fmt: AnsiString; Args: array of const); overload;
    procedure LS(const S: AnsiString); overload;
      {-}
    procedure StartTag(TagID: Long); override;
      {-}
    property ExportDirectory: AnsiString
      read f_ExportDirectory write f_ExportDirectory;

    property WorkVAnonced: Boolean
      read f_WorkVAnonced write f_WorkVAnonced;

   property OnError: TddErrorEvent read f_OnError write f_OnError;
   property First;
   property NotFilterGroups: Boolean read f_NotFilterGroups write f_NotFilterGroups;
  published
    { Published declarations }
   property OnTopicInit: TTopicInitEvent
    read f_OnTopicInit write f_OnTopicInit;
  end;

implementation

Uses
  Forms, Math, Dialogs, SysUtils, DateUtils, StrUtils,
  l3Chars, l3Stream, l3FileUtils, l3String, l3Bits, l3BaseStream,
  l3DateSt,
  {$IfDef nsTest}
  l3Except,
  {$EndIf nsTest}

  daInterfaces,

  {$IF Defined(InsiderTest) and Defined(EverestLite)}
  KTestRunner,
  {$IFEND}

  evdStyles,

  k2Tags,

  ddNSRCConst, ddConst,
  imageenio,
  l3DatLst,
  PIRec_Const,
  Document_Const,
  TextPara_Const,
  TableCell_Const,
  ActiveInterval_Const,
  Alarm_Const,
  Address_Const,
  Sub_Const,
  DocumentSub_Const,
  Bookmark_Const,
  Block_Const,
  AnnoTopic_Const,
  DictEntry_Const,
  BitmapPara_Const,
  LogRecord_Const,
  DictItem_Const,
  ExtDataPara_Const,
  k2String_Const,
  DictRec_Const,
  Stage_Const,
  NumAndDate_Const,
  Check_Const,
  l3TempMemoryStream
  , evNSRCConst, k2StackGenerator;

{.$DEFINE EditionDoc}

const
  MaxLineLen = 73;
  NoDocsEx = [utNoDoc, utBusiness, utUserInfo, utWEBReference];
  {$IFNDEF EditionDoc}
  NoDocs = [utNoDoc, utBusiness, utUserInfo, utWEBReference, utEdition];
  Docs = utDocTypesHasDoc;
  {$ELSE}
  NoDocs = [utNoDoc, utBusiness, utUserInfo, utWEBReference];
  Docs = utDocTypesHasDoc + [utEdition];
  {$ENDIF}
  DocsEx = Docs + [utEdition];
  ObjDocs = [dtObject];

resourcestring
 VAnoncedStr = 'ЮРИДИЧЕСКАЯ ОБРАБОТКА ДОКУМЕНТА НЕ ОКОНЧЕНА';
 VAnoncedStrL = ' Юридическая обработка документа не окончена';

constructor TddNSRCGenerator.Create(aOwner: Tk2TagGeneratorOwner = nil);
begin
  inherited;
  {$IFNDEF OnlyInherited}
  f_DocIsStarted:= False;
  IsRelated:= False;
  f_WorkVAnonced:= False;
  f_ShortName:= Tl3String.Create;
  f_Name:= Tl3String.Create;
  //f_NameComment:= Tl3String.Create;
  f_Belongs:= Tl3String.Create;
  f_AccGroups:= Tl3String.Create;
  f_FirstPara:= True;
  f_VanoncedDate:= IncDate(CurrentDate, Ord(Saturday) - Ord(DayOfWeek(CurrentDate))+1, 0, 0);
  MakeDateStr(f_VanoncedDate, f_VanoncedDateStr);

  f_VanoncedStrL:= Tl3String.Create;
  f_VanoncedStrL.AsString:= VanoncedStrL;
  f_VanoncedStr:= Tl3String.Create;
  f_VanoncedStr.AsString:= VanoncedStr;


  f_ErrorList:= TStringList.Create;
  f_NotFilterGroups:= False;
  with f_PIR do
  begin
    Sour   := Tl3String.Create;
    Comment:= Tl3String.Create;
    Number:= Tl3String.Create;
    Pages:= Tl3String.Create;
    LinkComment:= Tl3String.Create;
    Priv:= False;
  end;

  with f_SubRec do
  begin
    Name:= Tl3String.Create;
    f_Classes:= Tl3StringList.Make;

  end;

  with f_Block do
  begin
    Name:= Tl3String.Create;
    f_Classes:= Tl3StringList.Make;
    Style:= -1;
    ViewKind:= ev_bvkNone;
  end;


  with f_DictRec do
  begin
    Name:= Tl3String.Create;
    ShortName:= Tl3String.Create;
  end;

  with f_DateNumRec do
  begin
    rNumber:= Tl3String.Create;
  end;

  with f_CheckRec do
    Comment:= Tl3String.Create;
  //f_Stream := Tl3TempMemoryStream.Create;
 //SetLength(f_String, 4096);
 //f_String:= '';

 {$ENDIF OnlyInherited}
end;

procedure TddNSRCGenerator.Cleanup;
begin
 {$IFNDEF OnlyInherited}
  f_PathListner := nil;
  FreeAndNil(f_Stream);
  //FreeAndNil(f_NameComment);
  l3Free(f_ShortName);
  l3Free(f_Name);
  l3Free(f_Belongs);
  l3Free(f_AccGroups);
  l3Free(f_VanoncedStrL);
  l3Free(f_VanoncedStr);

  with f_PIR do
  begin
   L3Free(Sour);
   l3Free(Comment);
   l3Free(Number);
   l3Free(Pages);
   l3Free(LinkComment);
  end;

  with f_SubRec do
  begin
    l3Free(Name);
    l3Free(f_Classes);
  end;

  with f_Block do
  begin
    l3Free(Name);
    l3Free(f_Classes);
  end;


  with f_DictRec do
  begin
    l3Free(Name);
    l3Free(ShortName);
  end;

  with f_DateNumRec do
  begin
    l3Free(rNumber);
  end;

  with f_CheckRec do
    l3Free(Comment);
  l3Free(f_ErrorList);
 {$ENDIF OnlyInherited}
  inherited;
end;

function TddNSRCGenerator.NotAnObject: Boolean;
begin
 Result := not (TDocType(f_TopicType) in ObjDocs);
end;

procedure TddNSRCGenerator.ClearPIR;
begin
  with f_PIR do
  begin
   Priv:= False;
   Sour.Clear;
   Comment.Clear;
   Pages.Clear;
   LinkComment.Clear;
  end;
end;

procedure TddNSRCGenerator.SetIsRelated(Value: Boolean);
begin
  f_IsRelated:= Value;
  if f_IsRelated then
  begin
    f_UserType:= utNoDoc;
  end;
end;

procedure TddNSRCGenerator.OpenStream;
begin
 inherited;
 {$IFNDEF OnlyInherited}
 f_ErrorList.Clear;
 {$ENDIF OnlyInherited}
end;

procedure TddNSRCGenerator.StartChild(TypeID: Tl3Type);
const
 cAnonceStyleParam = ' L 1 72 1';
 cAnonceDefDateStr = '29/05/1997';
var
  l_TT     : Tk2Type;
  S      : Tl3string;
  l_Type : Tk2Type;
begin
  {$IFDEF OnlyInherited}
  inherited
  {$ELSE}
  l_TT:= CurrentType;
  if TypeID = k2_typPIRec then
    ClearPIR;
  l_Type := Tk2Type(TypeID);
  if l_Type.IsKindOf(k2_typDocument) then
  begin
   if (TopType[1] <> nil) then
   // - учитываем вложенные документы
   begin
    inherited;
    Exit;
   end;//TopType[1] <> nil
   ClearHeader(Tk2Type(TypeID));
  end; // (TypeID = k2_idDocument) or (TypeID = k2_idDictEntry)

  if (not (l_TT = nil)) and l_TT.IsKindOf(k2_typDocument)
      and not f_DocIsStarted then
    AddTopic;

  if (FLevelCount6 > -1) {and (TypeID <> k2_idBlock)} and (f_Block.ID = 0) then
  begin
   AddContents;
   AddCompareContents;
  end; 

  if l_Type.IsKindOf(k2_typTextPara) then
  begin
   if WorkVAnonced and not VAnoncedWrited then
   begin
    VanoncedWrited:= True;
    if IsRelated then
    begin
     OutEOL;
     OutCommand(kwdStyle);
     OutString(cAnonceStyleParam);
     OutEOL;
     SetOutCodePage(f_VanoncedStrL, CodePage);
     OutString(f_VanoncedStrL);
     OutEOL;
    end
    else
    begin
     OutCommand(kwdVAnonced);
     if (Abs(f_MinDate - f_VanoncedDate) > 45) then
      OutString(cAnonceDefDateStr)
     else
      OutShortString(f_VAnoncedDateStr);
    end;
   end;

   if Readed then
    f_RelNumber:= 0;

   CheckNeed2AddBlock;
  end;
  inherited;
  l_TT:= CurrentType;
  if l_TT.IsKindOf(k2_typActiveInterval) and (TopObject[1].isProp) then
    l3FillChar(f_ActiveInterval, SizeOf(TActiveIntervalRec), 0)
   else
  if l_TT.IsKindOf(k2_typAlarm) and (TopObject[1].isProp) then
    l3FillChar(f_Alarm, SizeOf(TAlarmRec), 0)
  else
  if l_TT.IsKindOf(k2_typAddress) and TopObject[1].IsProp and
     (TopObject[1].AsProp.TagIndex = k2_tiLinkedDocuments) then
    l3FillChar(f_Doc2DocRec, SizeOf(TDoc2DocLinkRec), 0){
  else
  Begin
   if (f_DictRec.DictID = da_dlBases) and (TopObject[1].IsProp) and
      (TopObject[1].AsProp.TagIndex <> k2_tiGroups) and not f_BelongsDone then
    AddBelongs;
  end};
   {$IFDEF AccGroups}
   if (f_DictRec.DictID = da_dlAccGroups) and (TopObject[1].IsProp) and
    (TopObject[1].AsProp.TagIndex <> k2_tiAccGroups) and
     not f_AccGroupsDone then
    begin
     if f_AccGroups.Ch[0] = '\' then
       f_AccGroups.Delete(0,1);
     //LS(Format('!%s %s', [kwdMain, f_AccGroups.AsString]));
     OutCommand(kwdMain);
     OutString(f_AccGroups);
     f_DictRec.DictID:= da_dlNone;
     f_AccGroupsDone:= True;
    end;
    {$ENDIF}
   if (l_TT.IsKindOf(k2_typSub) and
      Not l_TT.IsKindOf(k2_typDocumentSub) and
      not l_TT.IsKindOf(k2_typBookmark)) then
    begin
      if f_DocIsStarted then
      begin
       if (f_SubRec.ID > 0) and NeedOutSub then
        AddSubRec
      end;
    end
   else
   If (l_TT.IsKindOf(k2_typBlock)) then{ and
      Not TT.IsKindOf(k2_typDocumentSub))}
    Begin
       If (f_Block.ID > 0) then
        AddBlock
    end
   else
    If l_TT.IsKindOf(k2_typDictItem) and // Было DictRec
       (TopObject[1].isProp) then
     Begin
      case TopObject[1].AsProp.TagIndex of
        k2_tiGroups: begin
                       if f_DictRec.DictID <> da_dlBases then
                       begin
                         f_Belongs.Clear;
                         f_DictRec.DictID:=da_dlBases;
                       end;
                     end;
        k2_tiSources: f_DictRec.DictID := da_dlSources;
        k2_tiTypes : f_DictRec.DictID := da_dlTypes;
        k2_tiClasses : f_DictRec.DictID := da_dlClasses;
        k2_tiKeyWords: f_DictRec.DictID := da_dlKeywords;
        k2_tiWarnings : f_DictRec.DictID := da_dlWarnings;
        k2_tiPrefix: f_DictRec.DictID := da_dlPrefixes;
        k2_tiTerritory: f_DictRec.DictID := da_dlTerritories;
        k2_tiNorm : f_DictRec.DictID := da_dlNorms;
        k2_tiAnnoClasses : f_DictRec.DictID := da_dlAnnoClasses;
        {$IFDEF AccGroups}
        k2_tiAccGroups:
                      begin
                       if f_DictRec.DictID <> da_dlAccGroups then
                       begin
                         f_AccGroups.Clear;
                         f_DictRec.DictID:=da_dlAccGroups;
                       end;
                      end;
         {$ENDIF}
        k2_tiServiceInfo : f_DictRec.DictID := da_dlServiceInfo;
      end;
   end;
   if TypeID = k2_typBlock then
     if (f_Block.ID > 0) then
        AddBlock;
  {$ENDIF}
end;

procedure TddNSRCGenerator.AddTopic;
//var
//  S  : Tl3String;
begin
 OutHeader;
 if not f_DocIsStarted then
 begin
  f_DocIsStarted:= True;
  SetOutCodePage(f_ShortName, CodePage);
  //SetOutCodePage(f_NameComment, CodePage);
  l3Replace(f_ShortName.AsPCharLen, [cc_Tab, cc_SoftEnter, cc_HardEnter], cc_HardSpace);

  AddDocType;
  AddUserType;

  if not IsRelated and ((f_UserType = utEdition) or (f_UserType = utNoDoc) or not (f_UserType in NoDocs)) then
   WriteName(f_Name);
  AddRel;

  // дополнительные поля
  //AddVerLink;
  AddRelated;

  if not IsRelated and Assigned(f_OnTopicInit) then
   f_OnTopicInit(Self, f_Handle);
 end;
 f_PicNumber:= 0;
 f_ShortName.Clear;
 f_Name.Clear;
end;

procedure TddNSRCGenerator.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
var
 TT: Tk2Type;
begin
 {$IFDEF OnlyInherited}
 inherited
 {$ELSE}
 TT:= CurrentType;
 if TT.IsKindOf(k2_typTextPara) and f_FirstPara and (AtomIndex = k2_tiStyle) then
   ApplyToFirstPara(Value);
 if not ((AtomIndex = k2_tiShortName) and TT.IsKindOf(k2_typDocument)) then
  inherited AddAtomEx(AtomIndex, Value);

 if TT.IsKindOf(k2_typBlock) then
 // http://mdp.garant.ru/pages/viewpage.action?pageId=606129271
 begin
  if AtomIndex = k2_tiContentsLevel6 then
   FLevelCount6:= Value.AsInteger
  else
  if AtomIndex = k2_tiContentsLevel5 then
   FLevelCount5:= Value.AsInteger
  else
  if AtomIndex = k2_tiCompareContentsLevel then
  begin
   f_CompareContents:= Value.AsInteger;
   if TT.IsKindOf(k2_typDocument) then
    AddCompareContents;
  end;//AtomIndex = k2_tiCompareContentsLevel
 end;//TT.IsKindOf(k2_typBlock)

 If TT.IsKindOf(k2_typDocument) then {заполнение элементарных полей документа}
  ApplyToDocument(AtomIndex, Value)
 else { Document }
 if TT.IsKindOf(k2_typBlock) then
  ApplyToBlock(AtomIndex, Value)
 else
 if (TT.IsKindOf(k2_typBitmapPara) or TT.IsKindOf(k2_typExtDataPara)){ and (not NotAnObject)} then
  ApplyToBitmapPara(AtomIndex, Value)
 else
 if TT.IsKindOf(k2_typSub, [k2_typDocumentSub]) then  {заполнение записи: точка входа (Sub)}
  ApplyToSub(AtomIndex, Value)
 else
 if (AtomIndex = k2_tiValue) and TT.IsKindOf(k2_typString) then
 ApplyToString(Value)
 else
 if TT.IsKindOf(k2_typActiveInterval) then
  ApplyToActiveInterval(AtomIndex, Value)
 else
 if TT.IsKindOf(k2_typAlarm) then
  ApplyToAlarm(AtomIndex, Value)
 else
 if TT.IsKindOf(k2_typAddress) and TopObject[1].IsProp and (TopObject[1].AsProp.TagIndex = k2_tiLinkedDocuments) then
  ApplyToAddress(AtomIndex, Value)
 else
 if TT.IsKindOf(k2_typDictRec) then {заполнение записи: элемент словаря}
  ApplyToDictRec(AtomIndex, Value)
 else
 if TT.IsKindOf(k2_typStage) then {заполнение записи: этап обработки}
  ApplyToStage(AtomIndex, Value)
 else
 if TT.IsKindOf(k2_typNumAndDate) then {заполнение записи: дата.номер}
  ApplyToNumAndDate(AtomIndex, Value)
 else
 if TT.IsKindOf(k2_typAddress) and
    TopObject[0].IsProp and (TopObject[0].AsProp.TagIndex = k2_tiLinkAddress) and
    TopObject[2].IsProp and (TopObject[2].AsProp.TagIndex = k2_tiNumAndDates) then
  ApplyToNumAndDate(AtomIndex, Value)
 else
 if TT.IsKindOf(k2_typCheck) then {заполнение записи: элемент вычитки}
  ApplyToCheck(AtomIndex, Value)
 else
 if TT.IsKindOf(k2_typPIRec) then {заполнение записи: элемент публикации}
  ApplyToPublished(AtomIndex, Value)
 else
 if TT.IsKindOf(k2_typLogRecord) then {заполнение записи: элемент журнала}
  ApplyToLog(AtomIndex, Value)
 {$ENDIF}
end;

procedure TddNSRCGenerator.StartTag(TagID: Long);
var
  TT: Tk2Type;
begin
  {$IFDEF OnlyInherited}
  inherited
  {$ELSE}
  inherited StartTag(TagID);

  TT:= CurrentType;
  If TT.IsKindOf(k2_typDictRec) and
    (TopObject[0].isProp) then
  Begin
    If (TopObject[0].AsProp.TagIndex = k2_tiSource) then
      f_DictRec.DictID:=da_dlCorSources;
    If (TopObject[0].AsProp.TagIndex = k2_tiUser) then
      f_DictRec.UserDict:=True;
  end;
  if TT.IsKindOf(k2_typString) then
   f_CurLang:= Low(TevdLanguage);
  {$ENDIF}
end;


procedure TddNSRCGenerator.CloseStructure(NeedUndo: Bool);
var
  TT: Tk2Type;
begin
 {$IFDEF OnlyInherited}
 inherited
 {$ELSE}

 try
  TT:= CurrentType;
  begin
   if TT.IsKindOf(k2_typDocument) then
   begin
    if TopType[1] <> nil then
    // - учитываем вложенные документы
     Exit;
    {$IFNDEF NsrPlusNsr}
    LS(';');
    {$ENDIF}
    f_Handle:= 0;
    f_UserType:= utNone;
    if not f_HasRel then
    begin
     f_BelongsDone:= True;
     f_Belongs.Clear;
     f_AccGroupsDone:= True;
     f_AccGroups.Clear;
    end;
    f_HasRel:= False;
    f_FirstPara:= True;
   end { k2_idDocument }
   else
   if TT.IsKindOf(k2_typBitmapPara) then
   {$ifNDef NoObjTopic}
    if NotAnObject then
     WriteObjTopic
    else
     WriteObjPath
   {$EndIf NoObjTopic}
   else
   if TT.IsKindOf(k2_typExtDataPara) then
   {$ifNDef NoObjTopic}
    WriteExtDataPara
   {$EndIf NoObjTopic} 
   else
   if TT.IsKindOf(k2_typBlock) then
   begin
    CheckNeed2AddBlock;
    //LS(Format('!%s', [kwdBLOCKEND]));
    OutCommand(kwdBLOCKEND, False);
    ClearCurPara;//ClearPrevPara;
   end
   else

   if TT.IsKindOf(k2_typSub) and
      Not TopType[0].IsKindOf(k2_typDocumentSub) and
      not TopType[0].IsKindOf(k2_typBookmark) then
   begin
    if (f_SubRec.ID > 0) and NeedOutSub then
     AddSubRec;
   end { k2_idSub }
   else
   if TopObject[0].IsProp and (TopObject[0].AsProp.TagIndex = k2_tiGroups) then
    AddBelongs
   else
   if TT.IsKindOf(k2_typDictRec) then
   begin
    if (f_SubRec.ID = 0) and (f_Block.ID = 0) then
     AddDictRec
    else
    begin
     with f_DictRec do
     begin
      Name.CleAR;
      ShortName.Clear;
     end;
    end;
   end
   else
   if TT.IsKindOf(k2_typStage) then
    AddStageRec
   else

   if TT.IsKindOf(k2_typNumAndDate) then
    AddDateNumRec
   else

   if TT.IsKindOf(k2_typCheck) then
    AddCheckRec
   else

   if TT.IsKindOf(k2_typPIRec) then
    AddPublInString
   else

   if TT.IsKindOf(k2_typLogRecord) then
    AddLogRec
   else

   if TT.IsKindOf(k2_typAddress) and TopObject[1].IsProp and
      (TopObject[1].AsProp.TagIndex = k2_tiLinkedDocuments) then
    AddDoc2DocLink
   {$IFDEF VersionCommands}
   else

   if TT.IsKindOf(k2_typActiveInterval) then
    AddActiveIntervalRec
   else

   if TT.IsKindOf(k2_typAlarm) then
    AddAlarmRec
   {$ENDIF}
  end { If (fCurDocID > 0) }
 finally
  Inherited CloseStructure(NeedUndo);
 end;
 {$ENDIF}
end;

procedure TddNSRCGenerator.AddActiveIntervalRec;
var
 lKwd : ShortString;
begin
 {$IFDEF NotSure}
 if f_ActiveInterval.RecType > 0 then
  lKwd := kwdNotSure
 else
 {$ENDIF}
  lKwd := kwdActive;
 if l3IsOem(CodePage) then
  f_ActiveInterval.Comment:= l3ANSI2OEM(f_ActiveInterval.Comment);
 if (f_ActiveInterval.Start = maxActiveDate) and
    (f_ActiveInterval.Finish = maxActiveDate) then
  begin
   if NotAnObject and not (f_UserType in NoDocsEx) then
   begin
    OutCommand(kwdPreactive, False);
    if f_ActiveInterval.Comment <> '' then
     //LS(Format('!%s %s', [kwdPreactive, f_ActiveInterval.Comment]))
    begin
     OutString(' ');
     OutString(f_ActiveInterval.Comment);
    end
    //else
    // LS(Format('!%s', [kwdPreactive]))
   end
  end
 else
 if (f_ActiveInterval.Start = minActiveDate) and
    (f_ActiveInterval.Finish = minActiveDate) then
 begin
  if NotAnObject and not (f_UserType in NoDocsEx) then
   //LS(Format('!%s', [kwdNoActive]))
  begin
   OutCommand(kwdNoActive, False);
  end
 end
 else
 if (f_ActiveInterval.Start = minActiveDate) and
    (f_ActiveInterval.Finish > minActiveDate) and
    (f_ActiveInterval.Finish < maxActiveDate) then
 begin
  if NotAnObject and not (f_UserType in NoDocsEx) then
  begin
   OutCommand(kwdNoActive);
   OutDate(Succ(f_ActiveInterval.Finish));
  end
 end
 else
 if ((f_ActiveInterval.Start = minActiveDate) and (f_ActiveInterval.Finish = maxActiveDate)) or
    {!!!} ((f_ActiveInterval.Start = maxActiveDate) and (f_ActiveInterval.Finish = minActiveDate)) then
  begin
   if f_ActiveInterval.Comment <> '' then
    //LS(Format('!%s %s', [l_kwd, f_ActiveInterval.Comment]))
   begin
    OutCommand(lKwd);
    OutString(f_ActiveInterval.Comment);
   end
  end
 else
 if (f_ActiveInterval.Start > minActiveDate) and
    (f_ActiveInterval.Finish = maxActiveDate) then
 begin
  OutCommand(lKwd);
  OutDate(f_ActiveInterval.Start);
  OutSpace;
  OutString(f_ActiveInterval.Comment);
 end
 else
 begin
  OutCommand(lKwd);
  OutDate(f_ActiveInterval.Start);
  if f_ActiveInterval.Finish > 1 then
  begin
   OutString('-');
   OutDate(f_ActiveInterval.Finish);
  end;
  OutSpace;
  OutString(f_ActiveInterval.Comment);
 end
end;

procedure TddNSRCGenerator.AddAlarmRec;
begin
 begin
  OutCommand(kwdAlarm);
  OutDate(f_Alarm.Start);
  if f_Alarm.Comment <> '' then
  begin
   OutSpace;
   OutString('"');
   if l3IsOem(CodePage) then
    f_Alarm.Comment:= l3ANSI2OEM(f_Alarm.Comment);
   OutString(f_Alarm.Comment);
   OutString('"');
  end; // f_Alarm.Comment <> ''
 end;
end;

procedure TddNSRCGenerator.AddDoc2DocLink;
begin
 OutCommand(kwdChange);
 OutInteger(f_Doc2DocRec.rLinkedDocID);
 OutSpace;
 OutInteger(f_Doc2DocRec.rLinkType);
 l3FillChar(f_Doc2DocRec, SizeOf(f_Doc2DocRec));
end;


procedure TddNSRCGenerator.AddPublInString;
{$IFDEF PublishedIn}
var
 D1, M1, Y1,
 D2, M2, Y2 : Integer;
 S, DateSt: AnsiString;
 i: Integer;
begin
 //if (f_UserType in NoDocs) then Exit;

 //if not f_PIR.priv then
  with f_PIR do
  begin
   SetoutCodePage(Sour, CodePage);
   SetoutCodePage(Comment, CodePage);
   SetoutCodePage(LinkComment, CodePage);
   SetOutCodePage(Number, Codepage);
   if Sour.Ch[0] = '@' then
   begin
    //S:= Format('!*%s %s|%s|%s', [kwdPUBLISHEDIN, Sour.AsString, Number.AsString, LinkComment.AsString])
    OutCommand('*'+kwdPUBLISHEDIN);
    OutString(Sour);
    OutString('|');
    OutString(Number);
    OutString('|');
    OutString(LinkComment);
   end
   else // Sour.Ch[0] = '@'
   begin
    DateSt := MakeDateIntervalStr(SDate, EDate, '/');
    //S := Format('!%s %s|%s|%s|%s', [kwdPUBLISHEDIN, Sour.AsString, DateSt,
    //                                Number.AsString, Comment.AsString]);

    //if not LinkComment.Empty or not Pages.Empty then
    // S := S + Format('|%s|%s', [Pages.AsString, LinkComment.AsString]);
    //if f_PIR.priv then
    // System.Insert('*', S, 2);
    if f_PIR.priv then
     OutCommand('*'+kwdPUBLISHEDIN)
    else
     OutCommand(kwdPUBLISHEDIN);
    OutString(Sour);
    OutString('|');
    OutString(DateSt);
    OutString('|');
    OutString(Number);
    OutString('|');
    OutString(Comment);
    if not LinkComment.Empty or not Pages.Empty then
    begin
     OutString('|');
     OutString(Pages);
     OutString('|');
     OutString(LinkComment);
    end; // not LinkComment.Empty or not Pages.Empty
   end;

   //LS(S);
  end; // with f_PIR
 with f_PIR do
 begin
  Priv:= False;
  Sour.Clear;
  SDate:= 0;
  EDate:= 0;
  Number.Clear;
  Comment.Clear;
  Pages.Clear;
  LinkComment.Clear;
 end; // with f_PIR
end;
{$ELSE}
begin
end;
{$ENDIF}

procedure TddNSRCGenerator.LS(const Fmt: AnsiString; Args: array of const);
begin
 LS(Format(Fmt, Args));
end;

procedure TddNSRCGenerator.AddDictRec;
begin
 if NotAnObject and not (f_UserType in NoDocs) then
  with f_DictRec do
  begin
   if not Name.Empty then
   begin
    SetOutCodePage(Name, CodePage);
    case DictID of
      da_dlSources: //LS(Format('!%s %s', [kwdSource, Name.AsString]));
        OutCommand(kwdSource);
      da_dlTypes: //LS(Format('!%s %s', [kwdType, Name.AsString]));
        OutCommand(kwdType);
      da_dlClasses:
         if not Name.Empty then
         begin
           {$IFDEF Suffix}
           if (Name.Ch[1] = 'г') and (Name.Ch[2] ='д') and (Name.Ch[3] = 'д') then
           begin
             Name.Delete(0, 9);
             //LS(Format('!%s %s', [kwdSuffix, Name.AsString]))
             OutCommand(kwdSuffix);
           end
           else
           {$ENDIF}
           //  LS(Format('!%s %s', [kwdClass, Name.asString]));
            OutCommand(kwdClass);
         end;
      da_dlPrefixes: //LS(Format('!%s %s',[kwdPrefix, Name.AsString]));
       OutCommand(kwdKind);
      da_dlTerritories: //LS(Format('!%s %s',[kwdTerritory, Name.AsString]));
        OutCommand(kwdTerritory);
      da_dlNorms: //LS(Format('!%s %s',[kwdNorm, Name.AsString]));
       OutCommand(kwdNorm);
      da_dlServiceInfo : // LS(Format('!%s %s',[kwdServiceInfo, Name.AsString]));
       OutCommand(kwdServiceInfo);
    end; { case }
    if DictID in [da_dlSources, da_dlTypes, da_dlClasses, da_dlPrefixes, da_dlTerritories, da_dlNorms, da_dlServiceInfo] then
     OutString(Name);
   end; // not
   case DictID of
    da_dlAnnoClasses : WriteAnnoClass;
    da_dlWarnings: //LS(Format('!%s %d', [kwdWarning, Handle]));
     begin
      OutCommand(kwdWarning);
      OutInteger(Handle);
     end;
    da_dlCorSources:
      Begin
        If (f_DictRec.Handle<>0) and
           TopType[1].IsKindOf(k2_typCheck) then
              f_CheckRec.Sour:= f_DictRec.Handle;
       end;
    da_dlNorms: DictID:= da_dlNone;
    else
      if UserDict then
      Begin
       If Handle <> 0 then
       Begin
        If TopType[1].IsKindOf(k2_typCheck) then
         f_CheckRec.User:= Handle;

        If TopType[1].IsKindOf(k2_typStage) then
         f_StageRec.User:= Handle;

        If TopType[1].IsKindOf(k2_typLogRecord) then
         f_LogRec.rAuthor := TdaUserID(Handle);
       end;
     end
   end;
  end { with }
 else
 // Добавлено 9 октября 2002 года по прямому указанию БВ
 if (f_DictRec.DictID in [da_dlWarnings, da_dlServiceInfo]) and (f_UserType in NoDocs) then
  if (f_DictRec.DictID = da_dlWarnings) then
  //LS(Format('!%s %d', [kwdWarning, f_DictRec.Handle]))
  begin
   OutCommand(kwdWarning);
   OutInteger(f_DictRec.Handle);
  end
 else
  if (f_DictRec.DictID = da_dlServiceInfo) and not f_DictRec.Name.Empty then
   //LS(Format('!%s %s',[kwdServiceInfo, f_DictRec.Name.AsString]));
  begin
   OutCommand(kwdServiceInfo);
   OutString(f_DictRec.Name);
  end;
 with f_DictRec do
 begin
  Name.Clear;
  if (DictID <> da_dlBases) and (DictID <> da_dlAccGroups) then
   DictID:= da_dlNone;
  ShortName.Clear;
 end;
end;

procedure TddNSRCGenerator.AddDateNumRec;
begin
 if NotAnObject and
  (not (f_UserType in NoDocs) or
   ((f_UserType = utEdition) and (f_DateNumRec.rDNType = dnChangerDate)))then
  with f_DateNumRec do
  begin
    SetOutCodepage(rNumber, CodePage);
    case rDNType of
      dnDoc: ;
      dnPublish,
      dnAddNum:
       begin
        if rDate > 1 then
        begin
         OutCommand(kwdDate);
         OutDate(rDate);
         f_MinDate:= Min(f_MinDate, rDate);
        end;
        if not rNumber.Empty then
        begin
         // LS(Format('!%s %s', [kwdCode, Number.AsString]));
         if rDNType = dnPublish then
          OutCommand(kwdCode)
         else
          OutCommand(kwdAddCode);

         OutString(rNumber);
        end;
       end; // dnPublish

       {dnAddNum:
       begin
        if not rNumber.Empty then
        begin
         OutCommand(kwdAddCode);
         OutString(rNumber);
        end;
       end; }

      dnMU :
       begin
         if rDate > 1 then
         begin
          OutCommand(kwdRDate);
          OutDate(rDate);
         end;
         if not rNumber.Empty then
          // LS(Format('!%s %s', [kwdRCode, Number.AsString]));
         begin
          OutCommand(kwdRCode);
          OutString(rNumber);
         end;
         if (rDate = 0) and rNumber.Empty then
          OutCommand(kwdMOJNotReg, False);
       end;
      dnGD : begin
              if rDate > 1 then
              begin
               OutCommand(kwdGDDate);
               OutDate(rDate);
              end;

               if not rNumber.Empty then
               begin
                OutCommand(kwdGDCode);
                OutString(rNumber);
               end;
             end;
      dnSf : begin
              if rDate > 1 then
              begin
               OutCommand(kwdSFDate);
               OutDate(rDate);
              end;
              if not rNumber.Empty then
              begin
               OutCommand(kwdSFCode);
               OutString(rNumber);
              end;
             end;
      dnChangerDate:
       if rDate > 1 then
       begin
        OutCommand(kwdChDate);
        OutDate(rDate);

        if rLinkDocId <> 0 then
        begin
         OutSpace;
         OutInteger(rLinkDocId);
         if rLinkSubId <> 0 then
         begin
          OutString('.');
          OutInteger(rLinkSubId);
         end;
        end;
       end;
      dnLawCaseNum:
       if not rNumber.Empty then
       begin
        OutCommand(kwdCaseCode);
        OutString(rNumber);
       end;
    end;
  end;
  with f_DateNumRec do
  begin
    rDNType:= dnDoc;
    rDate:= 0;
    rNumber.Clear;
    rLinkDocId := 0;
    rLinkSubId := 0;
  end;
end;

procedure TddNSRCGenerator.AddStageRec;
begin
 with f_StageRec do
 begin
  OutCommand(kwdStage);
  OutInteger(Long(SType));
  OutSpace;
  OutInteger(User);
  OutSpace;
  OutDate(BeginDate);
  OutSpace;
  OutDate(EndDate);
  if SType in [stRead{, stDone}] then
    Readed := True;
 end;
 l3FillChar(f_StageRec, SizeOf(f_StageRec), 0);
end;

procedure TddNSRCGenerator.AddLogRec;
var
 l_Cmd: ShortString;
begin
  // Выливаем VINCLUDED для всех типов документов с 10.01.2007
  if (f_LOgRec.rAction <> acIncluded) and (f_UserType in NoDocs) then Exit;

  with f_LogRec do
  begin
   if rAction in [acRevision, acIncluded, acChanged, acAbolished, acLControl, acAnonced, acAnnoDate] then
   begin
    {$IFNDEF InsiderTest}
    case rAction of
      acRevision  : l_Cmd:= kwdRevision;
      acIncluded  : begin
                     if not IsRelated then
                      l_Cmd:= kwdVIncluded;
                     Readed := True;
                    end;
      acChanged   : l_Cmd:= kwdVChanged;
      acAbolished : l_Cmd:= kwdVAbolished;
      acLControl  : l_Cmd:= kwdVLControl;
      acAnonced   : l_Cmd:= kwdVAnonced;
      acAnnoDate  : l_Cmd:= kwdAnnoDate
    end; // case
    OutCommand(l_Cmd);
    OutDate(rDate);
    {$ENDIF InsiderTest}
    //*Log
   end
   else
   begin
    {$IFNDEF InsiderTest}
    OutCommand('*'+kwdLog);
    OutInteger(Byte(rAction));
    OutSpace;
    OutDate(rDate);
    OutSpace;
    OutString(l3TimeToStr(rTime, 'hh:mm'));
    OutSpace;
    OutInteger(Integer(rAuthor));
    {$ENDIF InsiderTest}
   end;
  end;
  l3FillChar(f_LogRec, SizeOf(f_LogRec), 0);
end;

procedure TddNSRCGenerator.AddCheckRec;
begin
{   Date: TStDate;
    CType: Byte;
    User: Longint;
    Comment: AnsiString;
    Sour    : Longint;
}
  with f_CheckRec do
  begin
   if f_TopicType <> Byte(dtObject) then
   begin
    SetOutCodePage(Comment, Codepage);
    OutCommand(kwdCheck);
    OutDate(Date);
    OutSpace;
    OutInteger(Sour);
    OutSpace;
    OutInteger(CType);
    OutSpace;
    OutInteger(User);
    OutSpace;
    OutString(Comment);
   end;
   Comment.Clear;
  end;
end;

procedure TddNSRCGenerator.AddSubRec;
var
  i: Integer;
  S: Tl3String;
  C: Char;
begin
  if f_DocIsStarted then
  begin
   if NotAnObject{ and not (f_UserType in NoDocs) }then
   { 26.11.2003  - для всех типов выливается  }
   begin
    (*
    for i:= 0 to Pred(f_SubRec.Name.Len) do
    begin
      if f_SubRec.Name.Ch[i] = #10 then f_SubRec.Name.Ch[i]:= #32;
      if f_SubRec.Name.Ch[i] = #9 then f_SubRec.Name.Ch[i]:= #32;
    end; // for i
    OutString(Format(' %s', [f_SubRec.Name.AsString]));
    *)
    l3Replace(f_SubRec.Name.AsWStr, [#9, #10], #32);
    OutSpace;
    OutString(f_SubRec.Name);
    if not (f_UserType in NoDocs) then
      for i:=0 to Pred(f_SubRec.f_Classes.Count) do
      begin
        S:= Tl3String(f_SubRec.f_Classes.Items[i]);
        SetoutCodePage(S, CodePage);
        (*C:= S.Ch[0];
        S.Delete(0, 1);
        case C of
          #1: LS(Format('!%s %s', [kwdClass, S.AsString]));
          #2: LS(Format('!%s %s', [kwdPrefix, S.AsString]));
          #3: LS(Format('!%s %s', [kwdType, S.AsString]));
          //#4: LS(Format('!%s %s', [kwdKeywords, S.AsString]));
          #5: LS(Format('!%s %s', [kwdServiceInfo, S.AsString]));
        end;
        *)
        case S.First of
          #1: OutCommand(kwdClass);
          #2: OutCommand(kwdPrefix);
          #3: OutCommand(kwdType);
          #5: OutCommand(kwdServiceInfo);
        else
         continue 
        end;
        S.Delete(0, 1);
        OutString(S);
      end;
   end;
  end;
  f_SubRec.Name.Clear;
  f_SubRec.ID:= 0;
  f_SubRec.f_Classes.Clear;
end;

procedure TddNSRCGenerator.AddBlock;
var
  i: Integer;
  S: Tl3String;
  C: Char;
begin
  if f_DocIsStarted then
  begin
    l3Replace(f_Block.Name.AsWStr, [#9, #10], #32);
    OutCommand(kwdBlock);
    OutInteger(f_Block.ID);
    OutSpace;
    OutString(f_Block.Name);
                                                           
    if (f_Block.ViewKind <> ev_bvkNone) or (f_Block.Style <> -1) then
    begin
     OutCommand(kwdBlockData);
     if f_Block.ViewKind <> ev_bvkNone then
     begin
      if f_Block.ViewKind = ev_bvkLeft then
       OutString('Location=LEFT')
      else
       OutString('Location=RIGHT');
      OutSpace;
     end;
     if f_Block.Style <> -1 then //Проверять с транспарент и выставлять его же
     begin
      OutString('Style=');
      OutInteger(Abs(f_Block.Style));
     end;
    end; // (f_Block.ViewKind <> ev_bvkNone) or (f_Block.Style <> -1)

    ClearCurPara;//ClearPrevPara;
    f_Block.Name.Clear;
    f_Block.ID:= 0;
    f_Block.Style:= -1;
    f_Block.ViewKind:= ev_bvkNone;

    if NotAnObject and not (f_UserType in NoDocs) then
      for i:=0 to Pred(f_Block.f_Classes.Count) do
      begin
        S:= Tl3String(f_Block.f_Classes.Items[i]);
        SetOutCodepage(S, CodePage);
        case S.First of
          #1: OutCommand(kwdClass);
          #2: OutCommand(kwdPrefix);
          #3: OutCommand(kwdType);
          #5: OutCommand(kwdServiceInfo);
        else
         continue
        end;
        S.Delete(0, 1);
        OutString(S);
      end; // for i
    f_Block.f_Classes.Clear;
    AddContents;
    AddCompareContents;
  end;
end;

procedure TddNSRCGenerator.SetExportDirectory(const aDirName: AnsiString);
begin
 f_ExportDirectory := aDirName;
end;

procedure TddNSRCGenerator.WriteName(aName: Tl3CustomString);
var
 l_Kwd : AnsiString;
 lBeginPos : Integer;
 lEndPos   : Integer;
begin
{ TODO : Фигня какая-то, а не метод.... }
  if aName.Empty then
    exit;
  if f_DocumentType = k2_typAnnoTopic then
   l_Kwd := kwdAnnoName
  else
   l_Kwd := kwdName;

  l3Replace(aName.St, cc_NonReadable + [cc_Tab, cc_SoftSpace], cc_HardSpace, aName.Len);

  SetoutCodePage(aName, CodePage);
  aName.TrimEOL;

  lBeginPos := 0;
  lEndPos := Pred(MaxLineLen);

  While lBeginPos < aName.Len do
  begin
   if aName.Ch[lBeginPos] = ' ' then
   begin
    Inc(lBeginPos);
    Continue;
   end;

   lEndPos := lBeginPos + Pred(MaxLineLen);

   if lEndPos >= aName.Len then
    lEndPos := Pred(aName.Len)
   else
    while true do
     if aName.Ch[Succ(lEndPos)] = ' ' then
     // режем только по пробелам, т к склеивают всегда через пробел
     //if (aName.Ch[Succ(lEndPos)] in [' ', '(']) or
     //  (aName.Ch[lEndPos] in ['.', ',']) then
      Break
     else
     begin
      Dec(lEndPos);
      if lEndPos = lBeginPos then // Не нашли разделителя в строке. Порежем насильно по MaxLineLen
      begin
       lEndPos := lBeginPos + Pred(MaxLineLen);
       Break;
      end;
     end;

   OutCommand(l_kwd);
   WriteBuf(aName.St + lBeginPos, lEndPos - lBeginPos + 1);

   lBeginPos := Succ(lEndPos);
  end;
end;

procedure TddNSRCGenerator.AddContents;
begin
 if FLevelCount6 > -1 then
 begin
  OutCommand(kwdContents);
  OutInteger(FLevelCount6);
  OutSpace; //!!
  if FLevelCount5 > -1 then
  begin
   //OutSpace;
   OutInteger(FLevelCount5);
  end;
 end;
 FLevelCount6:= -1;
 FLevelCount5:= -1;
end;

procedure TddNSRCGenerator.WriteAnnoClass;
var
 l_Kwd : AnsiString;
begin
 with f_DictRec do
 begin
  if not Name.Empty then
  begin
   setOutCodePage(Name, cp_ANSI);
   if AnsiStartsText(class_AnnoUser, Name.AsString) then
   begin
    l_Kwd := kwdAnnoUser;
    Name.Delete(0, Length(class_AnnoUser));
   end
   else
   if AnsiStartsText(class_AnnoOrganization, Name.AsString) then
   begin
    l_Kwd := kwdAnnoOrganization;
    Name.Delete(0, Length(class_AnnoOrganization));
   end
   else
   if AnsiStartsText(class_AnnoTax, Name.AsString) then
   begin
    l_Kwd := kwdAnnoTax;
    Name.Delete(0, Length(class_AnnoTax));
   end
   else
   if AnsiStartsText(class_AnnoInterest, Name.AsString) then
   begin
    l_Kwd := kwdAnnoInterest;
    Name.Delete(0, Length(class_AnnoInterest));
   end
   else
   if AnsiStartsText(class_AnnoKind, Name.AsString) then
   begin
    l_Kwd := kwdAnnoKind;
    Name.Delete(0, Length(class_AnnoKind));
   end
   else
   if AnsiStartsText(class_AnnoSignificant, Name.AsString) then
   begin
    l_Kwd := kwdAnnoSignificant;
    Name.Delete(0, Length(class_AnnoSignificant));
   end
   else
   if AnsiStartsText(class_AnnoImportant, Name.AsString) then
   begin
    l_Kwd := '*' + kwdAnnoImportant;
    Name.Delete(0, Length(class_AnnoImportant));
   end
   else
    l_kwd := 'ANNOCLASS';
   SetOutCodepage(Name, CodePage);
   //LS(Format('!%s %s', [l_kwd, Name.asString]));
   OutCommand(l_kwd);
   OutString(Name);
  end; // not Name.Empty
 end; // with
end;

procedure TddNSRCGenerator.CheckNeed2AddBlock;
begin
 if f_Block.ID > 0 then
  AddBlock;
end;

procedure TddNSRCGenerator.AddBelongs;
begin
 if not f_Belongs.Empty then
 begin
  if f_Belongs.First = '\' then
   f_Belongs.Delete(0,1);
  //LS('!%s %s', [kwdBelongs, f_Belongs.AsString]);
  OutCommand(kwdBelongs);
  OutString(f_Belongs);
 end;
 f_BelongsDone:= True;
end;

procedure TddNSRCGenerator.AddCompareContents;
begin
 if f_CompareContents > -1 then
 begin
  OutCommand(kwdCompareContents);
  if f_CompareContents > 0 then
   OutInteger(f_CompareContents);
 end;
 f_CompareContents:= -1;
end;

procedure TddNSRCGenerator.AddDocType;
var
 S: Tl3String;
begin
 case f_TopicType of
  Byte(dtObject):
   begin
    //LS(Format('!%s %d %s', [kwdOBJTOPIC, f_Handle, f_ShortName.AsString]));
    OutCommand(kwdOBJTOPIC);
    OutInteger(f_Handle);
    OutSpace;
    OutString(f_ShortName);
    f_FileName:= '';
   end;
  Byte(dtFlash):
   begin
    //LS(Format('!%s %d %s', [kwdFLASHTOPIC, f_Handle, f_ShortName.AsString]));
    OutCommand(kwdFLASHTOPIC);
    OutInteger(f_Handle);
    OutSpace;
    OutString(f_ShortName);
    f_FileName:= '';
   end;
  else
   begin
    if f_Handle > 0 then
    begin
     if WorkVAnonced and not IsRelated then
     begin
       OutCommand(kwdTopic);
       OutInteger(f_Handle);
       OutSpace;
       SetOutCodePage(f_VanoncedStr, CodePage);
      OutString(f_VanoncedStr);
       OutEOL;
       OutString(';');
       OutString(f_ShortName);
       OutCommand(kwdWarning);
       OutInteger(9);
     end // WorkVAnonced and not IsRelated
     else
     begin
      if f_DocumentType = k2_typDocument then
      begin
       OutCommand(kwdTopic);
       OutInteger(f_Handle);
       OutSpace;
       OutString(f_ShortName);
      end
      else
      if f_DocumentType = k2_typAnnoTopic then
      begin
       OutCommand(kwdAnnoTopic);
       OutInteger(f_Handle);
       OutSpace;
       OutString(f_ShortName);
      end
     end;
    end; // f_Handle > 0
   end; // else
 end; // case;
end;

procedure TddNSRCGenerator.AddNameComment(const aNameComment : Tl3PrimString);
begin
 if {f_DocIsStarted and } not aNameComment.Empty then
 begin
  OutCommand('*'+kwdNameComment);
  SetOutCodePage(Tl3CustomString(aNameComment), CodePage);
  OutString(aNameComment);
 end; // f_DocIsStarted and not f_NameComment.Empty
end;

procedure TddNSRCGenerator.AddPriceLevel(aPriceLevel: Integer);
begin
 if aPriceLevel = 0 then Exit;
 if {f_DocIsStarted and} NotAnObject and not (f_UserType in NoDocs) then
 begin
  if l3TestMask(aPriceLevel, dstatChargeFree) then
  begin
   //LS(Format('!%s %s', [kwdPriceLevel, prclvl_nFree]));
   OutCommand(kwdPriceLevel);
   OutString(prclvl_nFree);
  end;
  if l3TestMask(aPriceLevel, dstatNotTM) then
   //LS(Format('!%s', [kwdNotTM]));
   OutCommand(kwdNotTM, False);
  if l3TestMask(aPriceLevel, dstatNoCompare) then
   //LS(Format('!*%s', [kwdNoCompare]));
   OutCommand('*'+kwdNoCompare, False);
  if l3TestMask(aPriceLevel, dstatInternet) then
   OutCommand('*'+kwdInternet, False);
  if l3TestMask(aPriceLevel, dstatHang) then
   OutCommand('*'+kwdHang, False);
 end;
end;

procedure TddNSRCGenerator.AddPriority(aPriority : integer);
begin
 if (aPriority > 0) and NotAnObject and (f_UserType in Docs) then
 begin
  //LS(Format('!%s %d', [kwdPriority, f_Priority]));
  OutCommand(kwdPriority);
  OutInteger(aPriority);
 end; // f_DocIsStarted and (f_Priority <> -1) and NotAnObject and (f_UserType in Docs)
end;

procedure TddNSRCGenerator.AddRel;
begin
 if IsRelated then
 begin
  //LS(Format('!%s', [kwdREL]));
  OutCommand(kwdREL, False);
  (*
  try
   if not NotFilterGroups and not f_Belongs.Empty then
    AddBelongs;
   if not f_AccGroups.Empty then
   begin
    if f_AccGroups.Ch[0] = '\' then
     f_AccGroups.Delete(0,1);
    //LS(Format('!%s %s', [kwdMain, f_AccGroups.AsString]));
    OutCommand(kwdMain);
    OutString(f_AccGroups);
   end; // f_AccGroups
  except
   msg2log('Проблема выливки принадлежности документа к базам');
  end; // try..except
  *)
 end; // IsRelated;
end;

procedure TddNSRCGenerator.AddRelated;
begin
 If f_DocIsStarted and (f_RelNumber <> 0) and NotAnObject then
 begin
  //LS(Format('!%s %d', [kwdRelated, f_RelNumber]));
  OutCommand(kwdRelated);
  OutInteger(f_RelNumber);
 end;
end;

procedure TddNSRCGenerator.AddSortDate(aSortDate : integer);
begin
 If {f_DocIsStarted and} (aSortDate <> 0) and NotAnObject and not (f_UserType in NoDocs) then
 begin
  OutCommand(kwdSortDate);
  OutDate(aSortDate);
 end;
end;

procedure TddNSRCGenerator.AddUrgency(aUrgency: Integer);
begin
 if {f_DocIsStarted and} (aUrgency > 0) then
 begin
  OutCommand('*'+kwdUrgency);
  OutInteger(aUrgency);
 end;
end;

procedure TddNSRCGenerator.AddUserType;
begin
 if NotAnObject then
 begin
  if f_DocumentType = k2_typDictEntry then
   f_UserType:= utDoc;
  {$IFDEF DocType}
  OutCommand(kwdDocType);
  case f_UserType of
   utDoc         :
    if f_Handle > 0 then
     OutString(kwdDOC);
   utNoDoc       :
     OutString(kwdNODOC);
   utCalendar    :
    begin
     OutString(kwdDOC);
     OutCommand(kwdCALENDAR);
    end;
   utBusiness    :
    begin
     OutString(kwdNODOC);
     OutCommand(kwdBUSINESS);
    end;
   utUserInfo    :
    begin
     OutString(kwdNODOC);
     OutCommand(kwdUSERINFO);
    end;
   utWEBReference:
     OutString(kwdRefDOC);
   utEdition     :
     OutString(kwdEdition);
   utBook :
     OutString(kwdBook);
   utIzm:
     OutString(kwdIzm);
   utDossier:
    begin
     OutString(kwdDOC);
     OutCommand(kwdCaseDoc);
    end;
   utAAK_Cont:
    begin
     OutString('AAKCONTENT');
    end;
   utAAK_Doc:
    begin
     OutString('AAKTEXT');
    end;
  end; // case
  {$ELSE}
  case f_UserType of
   utDoc         :
    if f_Handle > 0 then
     OutCommand(kwdDOC, False);
   utNoDoc       :
     OutCommand(kwdNODOC, False);
   utCalendar    :
    begin
     OutCommand(kwdDOC, False);
     OutCommand(kwdCALENDAR, False);
    end;
   utBusiness    :
    begin
     OutCommand(kwdNODOC, False);
     OutCommand(kwdBUSINESS, False);
    end;
   utUserInfo    :
    begin
     OutCommand(kwdNODOC, False);
     OutCommand(kwdUSERINFO, False);
    end;
   utWEBReference:
     OutCommand(kwdRefDOC, False);
   utEdition     :
     OutCommand(kwdEdition, False);
   utBook :
     OutCommand(kwdBook, False);
   utIzm:
     OutCommand(kwdIzm, False);
   utDossier:
    begin
     OutCommand(kwdDOC, False);
     OutCommand(kwdCaseDoc, False);
    end;
   utAAK_Cont:
    begin
     OutCommand(kwdDocType);
     OutString('AAKCONTENT');
    end;
   utAAK_Doc:
    begin
     OutCommand(kwdDocType);
     OutString('AAKTEXT');
    end;
  end; // case
  {$ENDIF}
 end; // f_TopicType <> Byte(dtObject);
end;

procedure TddNSRCGenerator.AddVerLink;
begin
 if {f_DocIsStarted and} (f_Verlink <> -1) then
 begin
  //LS(Format('!%s %d', [kwdVerLink, f_Verlink]));
  OutCommand(kwdVerLink);
  OutInteger(f_Verlink);
 end;
end;

procedure TddNSRCGenerator.WriteObjTopic;
const
 carInTable: array [Boolean] of AnsiString = ('!STYLE J 0 73 5', '!STYLE J 0 73 0');
var
 l_St: ShortString;
 l_PictFileName: AnsiString;
 l_Topic: AnsiString;
 l_EndTextPos  : Long;
 l_FormulaText : AnsiString;
 C             : Char;
 ID            : Long;
 l_EP          : AnsiString;
 l_EH          : Integer;
 l_DPI         : Integer;
 l_Stream      : Tl3Stream;
 l_OutStream   : Tl3NamedFileStream;
 l_Path        : AnsiString;
 l_Pos         : Int64;
 l_BL          : Integer;
 l_ExportDir   : AnsiString;
 {$IFDEF evUseEvdStyleOnly}
 l_SemiColon   : Boolean;
 {$ENDIF evUseEvdStyleOnly}
begin
 {$IFDEF evUseEvdStyleOnly}
 if f_CurParaParas.Style.StyleID = ev_saEmpty then
  f_CurParaParas.Style.StyleID := -ev_saTxtNormalANSI;
 OutTextStyle(False, CP_ANSI, l_SemiColon);
 {$ELSE}
 LS(carInTable[TopType[1].IsKindOf(k2_typTableCell)]);
 {$ENDIF evUseEvdStyleOnly}
 if (f_Stream <> nil) and (f_Stream.Size > 0) then
 try
  l_PictFileName:= ExtractFileName(f_FileName);
  if l_PictFileName = '' then
   l_PictFileName:= Format('%d.png', [f_PictHandle])
  else
   l_PictFileName:= ChangeFileExt(l_PictFileName, '.png');
  l_Topic:= IfThen(f_Handle = cUndefDocID, 'unknown', IntToStr(f_Handle));
  l_St:= Format('pic:%s;topic:%d;res:%d',
                 [ConcatDirName(l_Topic, l_PictFileName),
                 f_PictHandle, f_DPI]);
  LS(ev_NSRCFormula + l_St + ev_NSRCFormula);

  {$IF Defined(InsiderTest) and Defined(EverestLite)}
  l_ExportDir := GetAppTestSetPath;
  {$ELSE}
  l_ExportDir := ExportDirectory;
  {$IFEND}
  l_PictFileName:= Lowercase(ConcatDirName(ConcatDirName(l_ExportDir, l_Topic), l_PictFileName));
  ForceDirectories(ExtractFilePath(l_PictFileName));
  try
   with TImageEnIO.Create(nil) do
   try
    f_Stream.Seek(0, 0);
    LoadFromStream(f_Stream);
    Params.Dpi:= 72; // <- Возможно, есть глобальная константа
    SaveToFilePNG(l_PictFileName);
   finally
    Free;
   end;
  except
   {$IfDef nsTest}
    raise El3BadPictureFormat.Create('Не удалось создать файл-картинку');
   {$Else  nsTest}
    Error('Не удалось создать файл-картинку');
   {$EndIf nsTest}
  end;
 finally
  FreeAndNil(f_Stream);
 end // f_Stream <> nil
 else
  Error('Отсутствуют данные для внешнего объекта');
end;

procedure TddNSRCGenerator.ApplyToActiveInterval(AtomIndex: Long; const Value: Tk2Variant);
begin
 if (AtomIndex = k2_tiType) and (Value.Kind = k2_vkInteger) then
  f_ActiveInterval.RecType:= Value.AsInteger
 else
 if (AtomIndex = k2_tiStart) and (Value.Kind = k2_vkInteger) then
  f_ActiveInterval.Start:= Value.AsInteger
 else
 if (AtomIndex = k2_tiFinish) and (Value.Kind = k2_vkInteger) then
  f_ActiveInterval.Finish:= Value.AsInteger
 else
 if (AtomIndex = k2_tiComment) and (Value.Kind = k2_vkString) then
  f_ActiveInterval.Comment:= '"'+Value.AsString.AsString+'"';
end;

procedure TddNSRCGenerator.ApplyToAddress(AtomIndex: Long; const Value: Tk2Variant);
begin
 if (AtomIndex = k2_tiDocID) and (Value.Kind = k2_vkInteger) then
  f_Doc2DocRec.rLinkedDocID := Value.AsInteger
 else
 if (AtomIndex = k2_tiType) and (Value.Kind = k2_vkInteger) then
  f_Doc2DocRec.rLinkType := Value.AsInteger;
end;

procedure TddNSRCGenerator.ApplyToAlarm(AtomIndex: Long; const Value: Tk2Variant);
begin
 if (AtomIndex = k2_tiStart) and (Value.Kind = k2_vkInteger) then
  f_Alarm.Start:= Value.AsInteger
 else
 if (AtomIndex = k2_tiComment) and (Value.Kind = k2_vkString) then
  f_Alarm.Comment:= Value.AsString.AsString;
end;

procedure TddNSRCGenerator.ApplyToBitmapPara(AtomIndex: Long; const Value: Tk2Variant);
begin
{$ifNDef NoObjTopic}
       //l_Stream := Attr[_k2_tiData].AsObject As Tl3Stream;
       //l_Path := ExtractFilePath(Filer.Identifier); ?
       //l_EP := StrA[k2_tiExternalPath];
       //l_EH := IntA[k2_tiExternalHandle];
       //l_DPI := IntA[k2_tiDPI];
       //l_BL := aStyledObject.IntA[k2_tiBaseLine];
       //if l_EP = '' then
       // l_EP := IntToStr(l_EH);

 case AtomIndex of
  k2_tiExternalPath :  if (Value.Kind = k2_vkString) then
                        f_FileName:= AnsiReplaceStr(Value.AsString.AsString, '/', '\');
  k2_tiExternalHandle: f_PictHandle:= Value.AsInteger;
  k2_tiData: if (Value.Kind = k2_vkStream) then
   begin
    {$ifNDef NoObjTopic}
    if Value.AsStream is Tl3SubStream then
    begin
     // Tl3SubStream не умеет делать seek на начало, потому что под ним лежит пакованный поток, который не не умеет делать seek на любое место
     // поэтому сразу копируем его в Tl3TempMemoryStream
     Value.AsStream.Seek(0, soBeginning);
     f_Stream:= Tl3TempMemoryStream.Create;
     f_Stream.CopyFrom(Value.AsStream, Value.AsStream.Size);
    end
    else
    begin
     l3Set(f_Stream, Value.AsStream);
     if f_Stream <> nil then
      f_Stream.Seek(0, soBeginning);
    end;
    {$EndIf}
   end;
  k2_tiDPI: f_DPI:= Value.AsInteger;
  k2_tiBaseLine: f_BaseLine:= Value.AsInteger;
 end;
{$ENDIF}
end;

procedure TddNSRCGenerator.ApplyToBlock(AtomIndex: Long; const Value: Tk2Variant);
begin
 case AtomIndex of
  k2_tiHandle: if (Value.Kind = k2_vkInteger) then
                f_Block.ID:= Value.AsInteger;
  k2_tiShortName: if (Value.Kind = k2_vkString) then
   begin
     //OutString(' ');
     setOutCodePage((Value.AsString As Tl3CustomString), Codepage);
     //OutString(Value.AsString);
     f_Block.Name.Assign(Value.AsString)
   end;
  k2_tiStyle: f_Block.Style:= Value.AsInteger;
  k2_tiViewKind: f_Block.ViewKind:= TevBlockViewKind(Value.AsInteger);
 end;
end;

procedure TddNSRCGenerator.ApplyToCheck(AtomIndex: Long; const Value: Tk2Variant);
begin
 (*  интересно, почему это отключено? Поди, из-за это ноль и выливается...*)
  if (AtomIndex = k2_tiSource) and (Value.Kind = k2_vkInteger) then
    f_CheckRec.Sour:= Value.AsInteger
  else
  If (AtomIndex = k2_tiStart) then
   If (Value.Kind=k2_vkInteger) then
    f_CheckRec.Date:=TStDate(Value.AsInteger)
   else
    ConvertErrorEx(Value.Kind)
  else
   If (AtomIndex = k2_tiType) then
    If (Value.Kind=k2_vkInteger) then
     f_CheckRec.CType:=Byte(Value.AsInteger)
    else
     ConvertErrorEx(Value.Kind)
   else
    If (AtomIndex = k2_tiComment) then
     If (Value.Kind=k2_vkString) then
     begin
      //Value.AsString.CharSet:= l3_csOEM;
      f_CheckRec.Comment.Assign(Value.AsString)
     end
     else
      ConvertErrorEx(Value.Kind);
end;

procedure TddNSRCGenerator.ApplyToDictRec(AtomIndex: Long; const Value: Tk2Variant);
var
 S: Tl3String;
begin
 if (AtomIndex = k2_tiPrivate) and (Value.Kind = k2_vkInteger) then
        f_PIR.Priv:= LongBool(Value.AsInteger)
       else
 If (AtomIndex = k2_tiHandle) then
  If (Value.Kind=k2_vkInteger) then
  begin
   if f_DictRec.UserDict then
   begin
     f_CheckRec.User:= Value.AsInteger;
     f_StageRec.User:= Value.AsInteger;
   end;
   f_DictRec.Handle:= Value.AsInteger
  end
  else
   ConvertErrorEx(Value.Kind)
 else
  If (AtomIndex = k2_tiName) then
   If (Value.Kind=k2_vkString) then
   begin
     if f_SubRec.ID > 0 then
     begin
       S:= Tl3String.Create;
       try
         //S.CharSet:= l3_csOEM;
         if TopObject[1].IsProp then
         case TopObject[1].AsProp.TagIndex of
           k2_tiClasses: S.AsString:= #1;
           k2_tiPrefix: S.AsString:= #2;
           k2_tiTypes: S.AsString:= #3;
           k2_tiKeywords: S.AsString:= #4;
           k2_tiServiceInfo: S.AsString:= #5;
         end;
         S.JoinWith(Value.AsString);
         f_SubRec.f_Classes.Add(S);
       finally
         l3Free(S);
       end;
     end
     else
     if f_Block.ID > 0 then
     begin
       S:= Tl3String.Create;
       try
         //S.CharSet:= l3_csOEM;
         if TopObject[1].IsProp then
         case TopObject[1].AsProp.TagIndex of
           k2_tiClasses: S.AsString:= #1;
           k2_tiPrefix: S.AsString:= #2;
           k2_tiTypes: S.AsString:= #3;
           k2_tiKeywords: S.AsString:= #4;
           k2_tiServiceInfo: S.AsString:= #5;
         end;
         S.JoinWith(Value.AsString);
         f_Block.f_Classes.Add(S);
       finally
         l3Free(S);
       end;
     end;
     f_PIR.Sour.Assign(Value.AsString);
     f_DictRec.Name.Assign(Value.AsString);
   end
   else
    ConvertErrorEx(Value.Kind)
  else
   If (AtomIndex = k2_tiShortName) then
    If (Value.Kind=k2_vkString) then
    begin
     if (f_DictRec.DictID = da_dlBases) then
     begin
      if (Value.AsString.AsString <> 'KSE') then
      begin
       f_BelongsDone:= False;
       f_Belongs.Append('\');
       {
       if Value.AsString.AsString = 'PRO' then
         f_NotVIncluded:= True;
       }
       f_Belongs.JoinWith(Value.AsString);
      end
     end
     {$IFDEF AccGroups}
     else
     if (f_DictRec.DictID = da_dlAccGroups) then
     begin
       f_AccGroupsDone:= False;
       f_AccGroups.Append('\');
       f_AccGroups.JoinWith(Value.AsString);
     end
     {$ENDIF}
     else
       f_DictRec.ShortName.Assign(Value.AsString);
    end
    else
     ConvertErrorEx(Value.Kind);
end;

procedure TddNSRCGenerator.ApplyToDocument(AtomIndex: Long; const Value: Tk2Variant);
begin
 if (TopType[1] <> nil) then
 // - учитываем вложенные документы
  Exit;
  case AtomIndex of
   k2_tiExternalHandle:
    Begin
      If (Value.Kind=k2_vkInteger) then
        f_Handle := Value.AsInteger
      else
        ConvertErrorEx(Value.Kind);
    end;
   k2_tiInternalHandle:
    Begin
      If (Value.Kind=k2_vkInteger) then
        InternalHandle := Value.AsInteger
      else
        ConvertErrorEx(Value.Kind);
    end;
   k2_tiType:
    begin
     If (Value.Kind=k2_vkInteger) then
     Begin
       f_TopicType:= Value.AsInteger;
       If (Byte(Value.AsInteger) = Byte(dtRelText)) then
        IsRelated:= True
       else
        f_Belongs.Clear;
     end
     else
        ConvertErrorEx(Value.Kind)
    end; {AtomIndex = k2_tiType}
   k2_tiShortName:
    begin
      If (Value.Kind=k2_vkString) then
      begin
        if f_ShortName.Empty then
        begin
         {f_ShortName:= Tl3CustomString.Create(nil);}
         f_ShortName.Assign(Value.AsString);
         //f_ShortName.CharSet:= l3_csOEM;
        end; {f_ShortName.Empty}
      end {(Value.Kind=k2_vkString)}
      else
         ConvertErrorEx(Value.Kind)
    end;
   k2_tiName:
    begin
      If (Value.Kind=k2_vkString) then
      begin
        f_Name.Assign(Value.AsString);
      end {Value.Kind=k2_vkString}
      else
        ConvertErrorEx(Value.Kind)
    end; {AtomIndex = k2_tiName}
   k2_tiUserType:
    begin
      If (Value.Kind=k2_vkInteger) then
      begin
        f_UserType:= TUserType(Value.AsInteger);
        f_Belongs.Clear;
      end {Value.Kind=k2_vkInteger}
      else
        ConvertErrorEx(Value.Kind)
    end;
   k2_tiSortDate:
    begin
     If (Value.Kind=k2_vkInteger) then
     begin
      AddSortDate(Value.AsInteger);
     end
     else
      ConvertErrorEx(Value.Kind)
    end;
   k2_tiExternalVerLink:
    if (Value.Kind = k2_vkInteger) then
    begin
     f_VerLink:= Value.AsInteger;
     AddVerlink;
    end;
   k2_tiPriority:
    begin
     if Value.Kind = k2_vkInteger then
     begin
      AddPriority(Value.AsInteger);
     end
     else
      ConvertErrorEx(Value.Kind)
    end;
   k2_tiRelExternalHandle:
    begin
     If (Value.Kind=k2_vkInteger) then
     begin
      f_HasRel:= False;//True;
      f_RelNumber:= Value.AsInteger;
      AddRelated;
     end
     else
      ConvertErrorEx(Value.Kind);
    end;
   k2_tiPriceLevel:
    begin
     if (Value.Kind = k2_vkInteger) then
     begin
      AddPriceLevel(Value.AsInteger);
     end
    end;
   k2_tiUrgency:
    begin
     if (Value.Kind = k2_vkInteger) then
     begin
      AddUrgency(Value.AsInteger);
     end
    end;
   k2_tiNameComment:
    begin
     if (Value.Kind = k2_vkString) then
     begin
      //f_NameComment.Assign(Value.AsString);
      AddNameComment(Value.AsString);
     end;
    end;
  end;
end;

procedure TddNSRCGenerator.ApplyToFirstPara(const Value: Tk2Variant);
var
 S: Tl3String;
begin
 if Value.AsInteger <> ev_saTxtHeader1 then
 begin
   f_FirstPara:= False;
   if WorkVAnonced {and not IsRelated} and not Readed and not f_ReadWrited then
    if not IsRelated or (f_Handle = f_RelNumber)then
    begin
      //LS('');
      OutEOL;
      S:= Tl3String.Create;
      try
        S.AsString:= 'Документ не прошел корректорскую вычитку по официальному источнику';
        setOutCodePage(S, CodePage);
        //LS(Format('!%s J 0 73 5', [kwdStyle]));
        OutCommand(kwdStyle);
        OutString('J 0 73 5');
        //LS(Format('     '#5#3'%s'#3#5, [S.AsString]));
        OutEOL;
        OutString('     '#5#3);
        OutString(S);
        OutString(#3#5);
        f_ReadWrited:= True;
      finally
        l3Free(S);
      end;
    end;
 end;
end;

procedure TddNSRCGenerator.ApplyToLog(AtomIndex: Long; const Value: Tk2Variant);
begin
 case AtomIndex of
  k2_tiType :
   if CheckValueType(Value, k2_vkInteger) then
    f_LogRec.rAction := TLogActionType(Value.AsInteger);
  k2_tiStart :
   if CheckValueType(Value, k2_vkInteger) then
    f_LogRec.rDate := TStDate(Value.AsInteger);
  k2_tiTime :
   if CheckValueType(Value, k2_vkInteger) then
    f_LogRec.rTime := TStTime(Value.AsInteger);
 end;
end;

procedure TddNSRCGenerator.ApplyToNumAndDate(AtomIndex: Long; const Value: Tk2Variant);
begin
 case AtomIndex of
  k2_tiType:
   If (Value.Kind = k2_vkInteger) then
    f_DateNumRec.rDNType:=TDNType(Value.AsInteger)
   else
    ConvertErrorEx(Value.Kind);

  k2_tiStart:
   If (Value.Kind = k2_vkInteger) then
    f_DateNumRec.rDate:=TStDate(Value.AsInteger)
   else
    ConvertErrorEx(Value.Kind);

  k2_tiNumber:
   If (Value.Kind = k2_vkString) then
    f_DateNumRec.rNumber.Assign(Value.AsString)
   else
    ConvertErrorEx(Value.Kind);

  k2_tiDocID:
   if CheckValueType(Value, k2_vkInteger) then
    f_DateNumRec.rLinkDocID := Value.AsInteger;

  k2_tiSubID:
   if CheckValueType(Value, k2_vkInteger) then
    f_DateNumRec.rLinkSubID := Value.AsInteger;

  {k2_tiComment:
       If (Value.Kind=k2_vkString) then
        f_DateNumRec.rComment.Assign(Value.AsString)
       else
        ConvertErrorEx(Value.Kind);}
 end // case AtomIndex;
end;

procedure TddNSRCGenerator.ApplyToPublished(AtomIndex: Long; const Value: Tk2Variant);
begin
 case AtomIndex of
  k2_tiName:
    begin
     if (Value.Kind=k2_vkString) then
      f_PIR.Sour.Assign(Value.AsString)
     else
      ConvertErrorEx(Value.Kind)
    end;
  k2_tiStart:
   begin
    If (Value.Kind=k2_vkInteger) then
     f_PIR.SDate:=TStDate(Value.AsInteger)
    else
     ConvertErrorEx(Value.Kind)
   end;
  k2_tiFinish:
   begin
    if (Value.Kind=k2_vkInteger) then
     f_PIR.EDate:=TStDate(Value.AsInteger)
    else
     ConvertErrorEx(Value.Kind)
   end;
  k2_tiNumber:
   begin
    if (Value.Kind=k2_vkString) then
     f_PIR.Number.Assign(Value.AsString)
    else
     ConvertErrorEx(Value.Kind)
   end;
  k2_tiComment:
   begin
    if (Value.Kind=k2_vkString) then
     f_PIR.Comment.Assign(Value.AsString)
    else
     ConvertErrorEx(Value.Kind);
   end;
  k2_tiPages:
   begin
    if (Value.Kind = k2_vkString) then
     f_PIR.Pages.Assign(Value.AsString)
    else
     ConvertErrorEx(Value.Kind);
   end;
  k2_tiLinkComment:
   begin
    if (Value.Kind = k2_vkString) then
     f_PIR.LinkComment.Assign(Value.AsString)
    else
     ConvertErrorEx(Value.Kind);
   end;
 end; // case;
end;

procedure TddNSRCGenerator.ApplyToStage(AtomIndex: Long; const Value: Tk2Variant);
begin
 If (AtomIndex = k2_tiType) then
  If (Value.Kind=k2_vkInteger) then
   f_StageRec.SType:= TStageType(Value.AsInteger)
  else
   ConvertErrorEx(Value.Kind)
 else
  If (AtomIndex = k2_tiStart) then
   If (Value.Kind=k2_vkInteger) then
    f_StageRec.BeginDate:=TStDate(Value.AsInteger)
   else
    ConvertErrorEx(Value.Kind)
  else
   If (AtomIndex = k2_tiFinish) then
    If (Value.Kind=k2_vkInteger) then
     f_StageRec.EndDate:=TStDate(Value.AsInteger)
    else
     ConvertErrorEx(Value.Kind);
end;

procedure TddNSRCGenerator.ApplyToString(const Value: Tk2Variant);
var
 l_CodePage: Integer;
begin
 if f_CurLang = evd_lgRussian then
  setOutCodepage(Value.AsString As Tl3CustomString, Codepage){cp_OEM - ????}
 else
 if f_CurLang = evd_lgEnglish then
 begin
  l_CodePage:= Filer.CodePage;
  Filer.CodePage:= Value.AsString.AsWStr.SCodePage
 end;
 //LS(Format('!%s %d %s', [kwdTerm, Succ(Ord(f_CurLang)), Value.AsString.AsString]));
 OutCommand(kwdTerm);
 OutInteger(Succ(Ord(f_CurLang)));
 OutSpace;
 OutString(Value.AsString);
 if f_CurLang = evd_lgEnglish then
  Filer.CodePage:= l_CodePage;
 if f_curLang < High(TevdLanguage) then
  Inc(f_CurLang);
end;

procedure TddNSRCGenerator.ApplyToSub(AtomIndex: Long; const Value: Tk2Variant);
begin
 If (AtomIndex = k2_tiHandle) then
  If (Value.Kind=k2_vkInteger) then
   f_SubRec.ID:= Value.AsInteger
  else
   ConvertErrorEx(Value.Kind)
 else
  If (AtomIndex = k2_tiShortName) then
   If (Value.Kind=k2_vkString) then
    Begin
   //  Value.AsString.CharSet:= l3_csOEM;
     f_SubRec.Name.Assign(Value.AsString);
     SetOutCodePage(f_SubRec.Name, CodePage);
     f_SubRec.RealName:=True;
    end
   else
    ConvertErrorEx(Value.Kind);
end;

function TddNSRCGenerator.CheckValueType(const Value: Tk2Variant; aTypeKind : Tk2VarKind): Boolean;
begin
 Result := (Value.Kind = aTypeKind);
 if not Result then
  ConvertErrorEx(Value.Kind);
end;

procedure TddNSRCGenerator.ClearHeader(aTypeID: Tk2Type);
begin
 f_Handle:= cUndefDocID;
 f_IsRelated:= False;
 f_DocIsStarted:= False;
 f_TopicType:= Byte(dtText);
 f_UserType:= utNone;
 VanoncedWrited:= False;
 f_ReadWrited:= False;
 f_MinDate:= f_VanoncedDate;
 Readed:= False;
 f_CurLang:= Low(TevdLanguage);
 f_DocumentType := aTypeID;
 fLevelCount5:= -1;
 FLevelCount6:= -1;
 //f_SortDate:= 0;
 f_Verlink:= -1;
 f_RelNumber:= 0;
 //f_NameComment.Clear;
 f_CompareContents:= -1;
 //f_Language:= 0;
end;

procedure TddNSRCGenerator.Error(const aDescription: AnsiString; aCategory: Integer = 0);
begin
 if Assigned(f_OnError) then f_OnError(aDescription, aCategory);
end;

procedure TddNSRCGenerator.WriteExtDataPara;
var
 l_Stream: TStream;
 St, l_ObjPath, l_PictFileName: AnsiString;
 f: Long;
begin
 if (f_Stream = nil) then
  Error('Пустой поток данных')
 else
 begin
  if (f_FileName = '') and (f_Stream <> nil) then
  begin
   f:= FindStreamFormat(f_Stream);
   l_PictFileName:= Format('%d%s', [f_Handle, PictExt[f]]);
   f_Stream.Seek(0, soBeginning);
  end // f_FileName = ''
  else
   l_PictFileName:= f_FileName;
  if ExtractFilePath(l_PictFileName) = '' then
   l_ObjPath:= ConcatDirname(IntToStr(f_Handle), l_PictFileName)
  else
   l_ObjPath:= l_PictFileName;
  l_PictFileName:= Lowercase(ConcatDirName(ExportDirectory, l_ObjPath));
  ForceDirectories(ExtractFilePath(l_PictFileName));
  l_Stream := Tl3FileStream.Create(l_PictFileName, l3_fmWrite);
  try
   f_Stream.Seek(0, soBeginning);
   l_Stream.CopyFrom(f_Stream, l_Stream.Size);
  finally
   FreeAndNil(l_Stream);
  end;
  FreeAndNil(f_Stream);
  {$IFDEF nsTest}
  SaveObjFileName(l_PictFileName); // Имя запоминаем, только если все прошло хорошо.
  {$ENDIF nsTest}
  St:= ExtractFileExt(l_ObjPath);
  Delete(St, 1, 1);
  St:= UpperCase(AnsiReplaceText(St, 'bmp', 'pic'));
  //LS(Format('!%s %s', [kwdObjType, St]));
  OutCommand(kwdObjType);
  OutString(St);
  //LS(Format('!%s %s', [kwdObjPath, l_ObjPath]));
  OutCommand(kwdObjPath);
  OutString(l_ObjPath);
 end;
end;

procedure TddNSRCGenerator.LS(const S: AnsiString);
begin
  if not f_DocIsStarted then
    AddTopic;
  OutEOL;
  OutString(S);
end;

procedure TddNSRCGenerator.MakeDateStr(SD: Integer; var aDateStr: AnsiString);
const
 cFmtStr {: array of byte} = '%2.2d/%2.2d/%d';
var
  D, M, Y: Integer;
begin
 if SD <= 1{MinDate} then
  aDateStr := ''
 else
 begin
  stDateToDMY(SD, D, M, Y);
  aDateStr := Format(cFmtStr, [D, M, Y]);
 end;
end;

(*var
  s: ShortString;
  D, M, Y: Integer;
begin
  if SD > 1{MinDate} then
  begin
   stDateToDMY(SD, D, M, Y);

   S:= Format('%2d/%2d/%d', [D, M, Y]);
   while Pos(' ', S) <> 0 do
     S[Pos(' ', S)]:= '0';
  end
  else
    S:= '';
  Result:= S;
end;
*)

procedure TddNSRCGenerator.OutDate(SD: Integer);
var
 S: AnsiString;
begin
 MakeDateStr(SD, S);
 if (Length(S) > 0) then
  WriteBuf(PAnsiChar(@S[1]), Length(S));
end;

procedure TddNSRCGenerator.OutCommand(const aCommand: AnsiString; aWithSpace: Boolean = True);
begin
 if not f_DocIsStarted then
  AddTopic;   //это писец

 OutStartCommand;
 OutString(aCommand);
 if aWithSpace then
  OutSpace;
end;

procedure TddNSRCGenerator.OutInteger(aValue: Integer);
begin
 OutString(IntToStr(aValue));
end;

procedure TddNSRCGenerator.OutSpace;
begin
 OutString(' ');
end;

procedure TddNSRCGenerator.OutStartCommand;
begin
 OutEOL;
 OutString('!');
end;

procedure TddNSRCGenerator.WriteObjPath;
var
 l_Stream: TStream;
 St: AnsiString;
 f: Long;
 l_PictFileName, l_ObjPath: AnsiString;
begin
 if f_Stream <> nil then
 begin
  f:= FindStreamFormat(f_Stream);
  l_PictFileName:= ExtractFileName(f_FileName);
  if l_PictFileName = '' then
   l_PictFileName:= Format('%d%s', [f_PictHandle, PictExt[f]]);;
  //if ExtractFilePath(f_FileName) = '' then
  // l_ObjPath:= ConcatDirname(IntToStr(f_Handle), l_PictFileName) // <- f_Handle - это номер ObjTopic :(
  //else
  if ExtractFilePath(f_FileName) <> '' then
   l_ObjPath:= ConcatDirName(ExtractFilePath(f_FileName), l_PictFileName)
  else
   l_ObjPath:= l_PictFileName;
  l_ObjPath:= Lowercase(l_ObjPath);
  l_PictFileName:= Lowercase(ConcatDirName(ExportDirectory, l_ObjPath));
  ForceDirectories(ExtractFilePath(l_PictFileName));
  St:= ExtractFileExt(l_PictFileName);
  Delete(St, 1, 1);
  St:= UpperCase(AnsiReplaceText(St, 'bmp', 'pic'));
  //LS('!%s %s', [kwdObjType, St]);
  //LS('!%s %s', [kwdObjPath, l_ObjPath]);
  OutCommand(kwdObjType);
  OutString(St);
  OutCommand(kwdObjPath);
  OutString(l_ObjPath);
  // Собственно данные
  l_Stream := Tl3FileStream.Create(l_PictFileName, l3_fmWrite);
  try
   f_Stream.Seek(0, 0);
   l_Stream.CopyFrom(f_Stream, f_Stream.Size);
  finally
   FreeAndNil(l_Stream);
  end;
  FreeAndNil(f_Stream);
 end
 else
  Error('Отсутствует объект');
end;

function TddNSRCGenerator.NeedOutSub: Boolean; 
begin
 Result := inherited NeedOutSub;
 if GetCellOpened then
  Result := False;
end;

procedure TddNSRCGenerator.OutStyle4Cell;
begin
 if (f_SubRec.ID > 0) then
 begin
  OutSubInt(f_SubRec.ID);
  AddSubRec;
  OutEOL;
 end; // if (f_SubRec.ID > 0) then
end;

procedure TddNSRCGenerator.LinkPathListner(const aListner: IddSaveObjectPath);
begin
 f_PathListner := aListner;
end;

procedure TddNSRCGenerator.UnLinkPathListner(const aListner: IddSaveObjectPath);
begin
 f_PathListner := nil;
end;

procedure TddNSRCGenerator.SaveObjFileName(const aFileName: AnsiString);
begin
 if f_PathListner <> nil then
  f_PathListner.SaveObjectPath(aFileName);
end;

end.

