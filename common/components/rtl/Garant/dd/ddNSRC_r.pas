//..........................................................................................................................................................................................................................................................
unit ddNSRC_r;

{
1). Переделать заливку пар CODE & DATE для создания связанных пар

25 февраля 2000 - расчленение процедуры Read
}
{ $Id: ddNSRC_r.pas,v 1.459 2016/04/13 08:32:30 dinishev Exp $ }
// $Log: ddNSRC_r.pas,v $
// Revision 1.459  2016/04/13 08:32:30  dinishev
// Доточил параметры парсера для NSRC.
//
// Revision 1.458  2015/10/15 11:32:36  lulin
// - при чтении из NSRC преобразуем формулы обратно в юникод.
//
// Revision 1.457  2015/10/14 17:12:48  lulin
// {RequestLink:608627000}
//
// Revision 1.456  2015/10/14 16:49:45  lulin
// {RequestLink:608627000}
//
// Revision 1.455  2015/10/14 16:48:27  lulin
// {RequestLink:608627000}
//
// Revision 1.454  2015/10/02 09:25:17  lukyanets
// Конфликт типов ID пользователя - знаковый vs беззнаковый
//
// Revision 1.453  2015/09/29 13:58:04  voba
// -k:608012012
//
// Revision 1.452  2015/08/27 15:40:54  lulin
// {RequestLink:605842696}
// - правильнее преобразуем рамки для которых есть соответствующий стиль.
//
// Revision 1.451  2015/08/27 15:24:55  lulin
// {RequestLink:605842696}
//
// Revision 1.450  2015/08/27 15:20:22  lulin
// {RequestLink:605842696}
//
// Revision 1.448  2015/08/27 15:05:52  lulin
// {RequestLink:605842696}
//
// Revision 1.447  2015/08/27 14:59:38  lulin
// {RequestLink:605842696}
//
// Revision 1.446  2015/08/27 13:57:55  lulin
// {RequestLink:605842696}
//
// Revision 1.444  2015/08/27 12:23:30  lulin
// {RequestLink:605842696}
//
// Revision 1.443  2015/08/27 12:07:18  lulin
// {RequestLink:605842696}
//
// Revision 1.442  2015/08/27 11:23:49  lulin
// {RequestLink:605842696}
//
// Revision 1.441  2015/08/27 11:09:06  lulin
// {RequestLink:605842696}
// - используем типизированный список сабов.
//
// Revision 1.440  2015/08/27 11:01:49  lulin
// {RequestLink:605842696}
// - вычищаем.
//
// Revision 1.439  2015/08/27 10:43:00  lulin
// {RequestLink:605842696}
// - наверное так правильнее.
//
// Revision 1.438  2015/08/27 10:35:50  lulin
// {RequestLink:605842696}
//
// Revision 1.437  2015/08/27 10:26:33  lulin
// {RequestLink:605842696}
//
// Revision 1.436  2015/08/27 10:19:26  lulin
// - выделяем TddNSRCSub в отдельный модуль.
//
// Revision 1.435  2015/08/27 10:00:17  lulin
// - вычищаем.
//
// Revision 1.434  2015/08/25 17:01:16  lulin
// {RequestLink:605842696}
//
// Revision 1.433  2015/08/25 16:49:34  lulin
// {RequestLink:605842696}
//
// Revision 1.432  2015/08/25 16:41:43  lulin
// {RequestLink:605842696}
//
// Revision 1.430  2015/08/25 16:25:04  lulin
// {RequestLink:605842696}
//
// Revision 1.429  2015/08/25 16:07:41  lulin
// {RequestLink:605842696}
//
// Revision 1.428  2015/08/25 15:55:18  lulin
// {RequestLink:605842696}
//
// Revision 1.427  2015/08/25 15:34:34  lulin
// {RequestLink:605842696}
//
// Revision 1.426  2015/08/25 15:25:52  lulin
// {RequestLink:605842696}
//
// Revision 1.425  2015/08/25 14:36:18  lulin
// {RequestLink:605842696}
//
// Revision 1.423  2015/08/25 13:44:04  lulin
// - так правильнее.
//
// Revision 1.422  2015/08/20 13:40:35  lulin
// - рефакторим.
//
// Revision 1.421  2015/08/19 18:38:40  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=604899511&focusedCommentId=605829699#comment-605829699
//
// Revision 1.420  2015/08/19 18:21:24  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=604899511&focusedCommentId=605829699#comment-605829699
//
// Revision 1.419  2015/08/19 15:00:33  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=604899511&focusedCommentId=605829699#comment-605829699
//
// Revision 1.418  2015/08/19 14:29:51  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=604899511&focusedCommentId=605829699#comment-605829699
//
// Revision 1.417  2015/08/19 13:51:12  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=604899511&focusedCommentId=605829699#comment-605829699
//
// Revision 1.416  2015/08/19 13:19:51  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=604899511&focusedCommentId=605829699#comment-605829699
//
// Revision 1.415  2015/08/18 13:31:23  lulin
// {RequestLink:604929290}
//
// Revision 1.414  2015/08/18 11:40:08  lulin
// {RequestLink:604929290}
//
// Revision 1.413  2015/08/17 17:49:50  lulin
// {RequestLink:604929290}
//
// Revision 1.411  2015/08/17 17:07:51  lulin
// {RequestLink:604929290}
//
// Revision 1.410  2015/08/17 17:05:18  lulin
// {RequestLink:604929290}
//
// Revision 1.409  2015/08/17 17:01:37  lulin
// {RequestLink:604929290}
//
// Revision 1.407  2015/08/17 16:50:32  lulin
// {RequestLink:604929290}
//
// Revision 1.406  2015/08/17 16:46:34  lulin
// {RequestLink:604929290}
//
// Revision 1.404  2015/08/17 15:32:06  lulin
// {RequestLink:604929290}
//
// Revision 1.403  2015/04/23 08:08:20  dinishev
// {Requestlink:596611797}
//
// Revision 1.402  2015/04/23 07:33:02  dinishev
// {Requestlink:596611797}
//
// Revision 1.401  2015/04/23 06:31:22  dinishev
// Reformat
//
// Revision 1.400  2015/04/23 04:21:55  dinishev
// Reformat
//
// Revision 1.399  2014/10/01 13:51:34  dinishev
// {Requestlink:565862557}
//
// Revision 1.398  2014/10/01 12:20:32  dinishev
// {Requestlink:565842263}
//
// Revision 1.397  2014/04/25 15:58:50  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.396  2014/04/10 11:59:56  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.395  2014/04/08 17:13:30  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.394  2014/04/03 17:10:42  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.393  2014/03/24 09:06:16  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.392  2014/03/18 17:40:29  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.391  2014/03/04 13:17:01  lulin
// - переводим идентификаторы Sub'ов и сегментов на нормальные Enum'ы.
//
// Revision 1.390  2014/02/24 16:51:00  lulin
// - чистим код.
//
// Revision 1.389  2014/02/24 13:59:45  lulin
// - вычищаем ненужное.
//
// Revision 1.388  2014/02/21 08:14:47  fireton
// - конец файла не определялся как конец строки и код зацикливался
//
// Revision 1.387  2014/02/14 15:33:53  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.386  2013/12/25 09:37:48  dinishev
// {Requestlink:508826885}. Если не заданы ширина, высота или DPI не передаем дальше нулевые значения. Не инициализируется EXE'к
//
// Revision 1.385  2013/12/24 12:07:33  dinishev
// {Requestlink:508826885}
//
// Revision 1.384  2013/10/28 10:07:58  lulin
// - готовимся к смене типа значения по-муоолчанию.
//
// Revision 1.383  2013/10/23 12:26:07  lulin
// - автоматически определяемые типы тоже генерируем с модели.
//
// Revision 1.382  2013/10/21 15:43:16  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.381  2013/10/21 10:31:05  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.380  2013/10/18 14:11:37  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.379  2013/10/01 09:24:46  fireton
// - неиспользуемая процедура (TranslateDNLawCase)
//
// Revision 1.378  2013/09/04 12:37:10  dinishev
// Cleanup
//
// Revision 1.377  2013/09/04 12:26:25  dinishev
// {Requestlink:481450949}
//
// Revision 1.376  2013/09/04 12:00:06  dinishev
// Заменил ';' на константу.
//
// Revision 1.375  2013/07/11 13:37:37  voba
// - K:463114391
//
// Revision 1.374  2013/05/22 11:53:19  dinishev
// {Requestlink:453178004}. Убираем левые отладочные сообщения из лога тестов.
//
// Revision 1.373  2013/04/11 16:46:28  lulin
// - отлаживаем под XE3.
//
// Revision 1.372  2013/04/09 12:30:20  narry
// Не компилировалось
//
// Revision 1.371  2013/04/05 12:04:29  lulin
// - портируем.
//
// Revision 1.370  2013/02/14 10:49:30  narry
// Новые параметры картинки - ширина и высота
//
// Revision 1.369  2013/01/28 13:07:23  narry
// Костыль для префиксов (425274414)
//
// Revision 1.368  2013/01/28 12:48:40  narry
// Поправить экспорт_импорт что бы выливался !KIND вместо !PREFIX (425040214)
//
// Revision 1.367  2012/12/11 12:31:03  narry
// Пропали пустые абзацы (415728258)
//
// Revision 1.366  2012/12/06 11:42:25  narry
// Создается лишний абзац (412987699)
//
// Revision 1.365  2012/10/18 09:36:41  narry
// Пустые строки после техкомментариев (404357586)
//
// Revision 1.364  2012/10/02 08:13:51  narry
// Не выводить предупреждение об отсутствии команды на месте комментария (397287206)
//
// Revision 1.363  2012/09/26 13:03:48  narry
// Не ругаемся на пустую строку
//
// Revision 1.362  2012/08/13 08:58:04  voba
// - bug fix
//
// Revision 1.361  2012/06/07 10:39:31  narry
// Новые пользовательские типы документов "Общая структура ААК" и "ААК - содержание" (365831611)
//
// Revision 1.360  2012/06/06 14:18:35  narry
// "Правые" и "левые" блоки для ААК (365831635)
//
// Revision 1.359  2012/03/30 08:28:09  narry
// Сохраняли номер картинки в неправильный параметр
//
// Revision 1.358  2012/03/29 13:57:38  narry
// Терялась картинка
//
// Revision 1.357  2012/03/29 13:30:40  narry
// Терялась картинка
//
// Revision 1.356  2012/03/28 14:19:12  narry
// Чтение DPI
//
// Revision 1.355  2012/02/27 06:39:31  lulin
// - bug fix.
//
// Revision 1.354  2012/02/16 14:04:13  narry
// Импорт информации о картинках в тексте (336663901)
//
// Revision 1.353  2012/02/16 13:54:51  narry
// Импорт информации о картинках в тексте (336663901)
//
// Revision 1.352  2012/01/31 06:37:10  narry
// Экспорт(импорт) !COMPARECONTENTS (332563861)
//
// Revision 1.351  2012/01/26 07:56:26  fireton
// - команда !*HANG (K 330696104)
//
// Revision 1.350  2011/12/21 14:45:07  fireton
// - новая команда !*INTERNET (К 321986367)
//
// Revision 1.349  2011/08/03 12:11:53  dinishev
// [$235058873]. Корректно читаем NSRC+
//
// Revision 1.348  2011/08/03 11:33:27  dinishev
// [$235058873]. Корректно читаем NSRC+
//
// Revision 1.347  2011/06/01 07:34:15  voba
// - k : 236721575
//
// Revision 1.346  2011/05/10 17:14:47  lulin
// {RequestLink:236719181}.
// №24.
//
// Revision 1.345  2010/10/22 13:10:14  narry
// K237503145 Чтение !ZOOM из NSRC приводит к ошибке
//
// Revision 1.344  2010/09/24 12:10:36  voba
// - k : 235046326
//
// Revision 1.343  2010/09/22 09:41:19  narry
// k235054362. Поддержка нумерованных стилей
//
// Revision 1.342  2010/09/22 08:54:22  narry
// k235054362. Поддержка нумерованных стилей
//
// Revision 1.341  2010/07/20 07:24:41  narry
// К127770683
//
// Revision 1.340  2010/05/28 06:58:40  narry
// - K216072906
//
// Revision 1.339  2010/05/26 13:09:17  narry
// - неправильно обрабатывались комментарии
//
// Revision 1.338  2010/05/26 08:29:59  narry
// - неправильно обрабатывались комментарии
//
// Revision 1.337  2010/05/20 05:16:10  narry
// - K214073721
//
// Revision 1.336  2010/05/11 12:30:02  narry
// - заточки под конвертер
//
// Revision 1.335  2010/05/07 08:35:49  narry
// - использование константы
//
// Revision 1.334  2010/05/07 07:03:59  narry
// - поддержка команды !LEFTINDENT
//
// Revision 1.332  2010/05/05 14:22:35  narry
// - обновление
//
// Revision 1.331  2010/04/30 14:11:29  narry
// - починка ошибок преобразования плюс->классик
//
// Revision 1.330  2010/04/15 11:41:30  narry
// - порядок присвоения стиля сегменту
//
// Revision 1.329  2010/04/15 08:10:16  narry
// - сохранение выравнивания стиля
// - упрощение процедуры WriteParagraph
//
// Revision 1.328  2010/04/06 12:23:27  narry
// - чистка кода
// - поддержка команды !ZOOM и нового параметра команды !STYLE
//
// Revision 1.327  2010/02/25 13:46:04  lulin
// - избавляемся от ненужного и вредного параметра, доставшегося в наследство от ошибок молодости.
//
// Revision 1.326  2010/02/24 18:22:44  lulin
// - избавляемся от ненужного и вредного параметра, доставшегося в наследство от ошибок молодости.
//
// Revision 1.325  2010/02/15 10:28:12  narry
// - поддержка команды !NOCOMPARE
//
// Revision 1.324  2010/02/12 09:41:37  narry
// - обнулялась левая половина подписи
//
// Revision 1.323  2010/02/11 14:27:08  narry
// - неправильно читался CASECODE
//
// Revision 1.322  2010/02/04 08:21:01  narry
// - не собиралось
//
// Revision 1.321  2010/02/04 07:58:25  narry
// - правильные параметры стиля "Нормальный аннотация" - J 0 73 5
//
// Revision 1.320  2010/02/04 07:39:51  narry
// - правильные параметры стиля "Нормальный справка" - L 1 72 1
//
// Revision 1.319  2010/01/26 08:22:13  narry
// - не склеивались заголовки
//
// Revision 1.318  2010/01/18 11:14:34  narry
// - открытие документа, если первая команда в файле !TABLE
//
// Revision 1.317  2010/01/11 11:40:49  voba
// - убрал замену #255 на #32
//
// Revision 1.316  2009/12/17 07:13:02  narry
// - ! в начале абзаца считается текстом
//
// Revision 1.315  2009/12/14 11:46:59  lulin
// - готовимся к возврату более простых строк.
//
// Revision 1.314  2009/12/07 13:35:24  narry
// - некорректное преобразование NSRC+ в NSRC
//
// Revision 1.313  2009/11/23 08:20:48  narry
// - Не преобразоывались вложенные таблицы из NSRC+
//
// Revision 1.312  2009/09/15 13:21:49  narry
// - поддержка команды !CASECODE
//
// Revision 1.311  2009/09/11 13:20:25  voba
// - не компилялось
//
// Revision 1.310  2009/07/29 08:00:25  narry
// - вывод ссобщений об ошибках не только в лог
// - вспомогательные типы
//
// Revision 1.309  2009/07/23 08:15:11  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.308  2009/07/22 11:15:06  narry
// - некорректное присваивание кодовой страницы
//
// Revision 1.307  2009/06/15 11:50:46  narry
// - иногда неправильно выставлялась кодировка имени блока
//
// Revision 1.306  2009/06/01 16:07:45  lulin
// [$148574348].
//
// Revision 1.305  2009/03/31 09:02:55  fireton
// - импорт/экспорт атрибута "Комментарий к документу" [$121164344]
//
// Revision 1.304  2009/03/23 08:30:18  lulin
// - не скрываем потенциальный dead-lock.
//
// Revision 1.303  2009/03/04 14:17:47  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.302  2009/02/26 12:25:07  lulin
// - <K>: 137465982. №1
//
// Revision 1.301  2009/02/20 13:27:54  fireton
// - команда !CHANGE (K 77235676)
// - 131 версия базы
//
// Revision 1.300  2009/01/23 15:57:04  narry
// - поддержка команды !LANGUAGE
//
// Revision 1.299  2009/01/14 14:06:51  narry
// - татары
//
// Revision 1.298  2009/01/13 16:19:14  narry
// - татары
//
// Revision 1.297  2008/10/24 06:47:45  narry
// - исправление NSRC+
//
// Revision 1.296  2008/10/23 12:10:20  narry
// - исправление NSRC+
//
// Revision 1.295  2008/10/23 11:28:28  narry
// - исправление NSRC+
//
// Revision 1.294  2008/10/21 12:47:54  narry
// - поддержка NSRC+
//
// Revision 1.293  2008/09/24 12:48:15  fireton
// - bugfix: устранение "приклеивания" STYLEA к STYLE C
// - bugfix: не удаляем двойные пробелы когда это не надо
//
// Revision 1.292  2008/09/23 12:17:48  fireton
// - импорт/экспорт номера судебного дела
//
// Revision 1.291  2008/09/22 13:25:29  narry
// - Поддержка команды !STYLEA
//
// Revision 1.290  2008/09/17 14:47:45  fireton
// - новая версия базы (130)
// - срочность документа
//
// Revision 1.289  2008/08/18 10:19:54  narry
// - восстановление удаления двойных пробелов
//
// Revision 1.288  2008/08/14 16:19:27  voba
// - опять заливаем Comment в PublishedIn
//
// Revision 1.286  2008/07/24 15:49:48  narry
// - улучшение алгоритма распознавания Заголовка приложения
//
// Revision 1.285  2008/07/02 12:21:31  fireton
// - удалил заглушки MXX с "extracted code"
//
// Revision 1.284  2008/06/20 14:49:11  lulin
// - используем префиксы элементов.
//
// Revision 1.283  2008/06/16 13:55:04  lulin
// - рисуем схему EVD на модели.
//
// Revision 1.282  2008/06/10 10:55:18  fireton
// - поддержка Flash-документов
//
// Revision 1.281  2008/06/06 12:01:48  fireton
// - bug fix: не прописывался тип документа при чтении документов-объектов
//
// Revision 1.280  2008/05/28 13:45:04  narry
// - генерировались паразитные сегменты в Заголовке Приложения
//
// Revision 1.279  2008/05/27 10:49:05  narry
// - чтение стиля "Заголовок приложения"
//
// Revision 1.278  2008/05/21 13:37:46  narry
// - проблема чтения формулы в конце строки
//
// Revision 1.277  2008/05/08 14:04:08  fireton
// - перенос объектов в потоках из ветки
//
// Revision 1.276  2008/05/07 06:07:44  voba
// - Refact. Убрал "magic number"
//
// Revision 1.275  2008/03/21 17:30:41  narry
// - поддержка PNG для ObjTopic
//
// Revision 1.274  2008/03/21 14:09:21  lulin
// - cleanup.
//
// Revision 1.273  2008/03/13 14:44:00  narry
// - включение CheckInt только перед чтением чисел
//
// Revision 1.272  2008/02/20 17:22:58  lulin
// - упрощаем строки.
//
// Revision 1.271  2008/02/14 17:30:32  lulin
// - cleanup.
//
// Revision 1.270  2008/02/14 09:40:33  lulin
// - удалён ненужный класс.
//
// Revision 1.269  2008/02/13 20:20:06  lulin
// - <TDN>: 73.
//
// Revision 1.268  2008/02/07 19:13:09  lulin
// - избавляемся от излишне универсальных методов базовых списков.
//
// Revision 1.267  2008/02/06 15:37:00  lulin
// - каждому базовому объекту по собственному модулю.
//
// Revision 1.266  2008/02/05 09:58:00  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.265  2008/02/01 15:14:44  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.264  2007/11/23 10:57:49  narry
// - ошибка иморта пустых абзацев
//
// Revision 1.263  2007/11/20 10:05:22  narry
// - первое приближение чтения формул из NSRC
//
// Revision 1.262  2007/11/02 10:48:34  narry
// - отключил CheckHex
//
// Revision 1.261  2007/09/14 13:26:17  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.260.2.1  2007/09/12 19:13:23  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.260  2007/09/06 09:37:43  lulin
// - переименовано свойство.
//
// Revision 1.259  2007/09/03 15:21:06  fireton
// - k2_tiBitmap -> _k2_tiData
//
// Revision 1.258  2007/08/29 17:35:14  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.257  2007/08/09 18:05:21  lulin
// - избавляемся от излишнего использования интерфейсов, т.к. переносимость может быть достигнута другими методами.
//
// Revision 1.256  2007/08/09 11:19:17  lulin
// - cleanup.
//
// Revision 1.255  2007/07/19 06:18:05  oman
// - fix: выпрямляем зависимости. Схема документа, теперь не зависит от Эвереста.
// (Не собиралась библиотека)
//
// Revision 1.254  2007/06/25 12:18:48  narry
// - поддержка команды !SERVICEINFO
//
// Revision 1.253  2007/04/25 09:30:55  fireton
// - Рефакторинг DT. Все типы переехали в DT_Types, а константы - в DT_Const
//
// Revision 1.252  2007/02/14 17:38:19  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.251  2007/01/18 08:01:13  narry
// - неправильно распознавались сегменты с пробелами в конце
//
// Revision 1.250  2007/01/10 14:33:09  narry
// - повышение информативности сообщения об ошибке
//
// Revision 1.249  2006/12/05 14:57:23  narry
// - поддержка команды !*LOG
//
// Revision 1.248  2006/10/03 11:48:12  narry
// - поддержка команды IZM
//
// Revision 1.247  2006/08/02 12:15:11  narry
// - незначительные исправления в собщении, выводимом в лог
//
// Revision 1.246  2006/07/25 07:44:05  narry
// - обновление
//
// Revision 1.245  2006/07/21 13:21:46  narry
// - борьба с ошибками формата команды CHECK
//
// Revision 1.244  2006/06/06 12:31:19  narry
// - исправление: "битый" ACTIVE останавливал дальнейший разбор
//
// Revision 1.243  2006/05/24 12:23:04  narry
// - исправление: ошибка чтения двойных дат
//
// Revision 1.242  2006/05/24 11:55:47  narry
// - исправление: некорректное чтение битых дат
// - исправление: теперь аннотациям не добавляется интервал действия
//
// Revision 1.241  2006/04/13 13:13:37  voba
// no message
//
// Revision 1.240  2006/02/22 09:20:50  narry
// - исправление: ошибки чтения !NOTSURE
//
// Revision 1.239  2005/12/19 11:43:47  narry
// - новое: поддержка команды !*ANNOIMPORTANT
//
// Revision 1.238  2005/10/18 09:13:24  narry
// - исправление: неправильная дата интервала действия
//
// Revision 1.237  2005/09/16 11:24:47  narry
// - обновлениеЖ поддержка команды BOOK
// - чистка кода
//
// Revision 1.236  2005/09/02 12:43:48  narry
// - new: чтение дополнительных команд !*ХХХХ
//
// Revision 1.235  2005/08/22 15:32:17  narry
// - bug fix: во время импорта "карточек" документов путались номера документов
//
// Revision 1.234  2005/07/14 15:51:34  narry
// - update: обработка ситуации, когда документ начинается с разрыва раздела
//
// Revision 1.233  2005/06/23 13:42:54  lulin
// - буфер документа переехал в папку K2.
//
// Revision 1.232  2005/05/24 14:50:06  lulin
// - готовим модуль evGraph к переезду в L3.
//
// Revision 1.231  2005/05/12 05:23:48  fireton
// - вынес строчки в resourcestring (для того, чтобы профайлить можно было)
//
// Revision 1.230  2005/05/04 13:42:33  narry
// - bug fix: служебные типы (Bussines и UserInfo) превращались в NoDoc
//
// Revision 1.229  2005/03/28 14:30:04  lulin
// - от класса генераторов переходим к интерфейсу.
//
// Revision 1.228  2005/03/28 11:32:17  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.227  2005/03/25 17:09:12  lulin
// - избавляемся от метода Tk2AtomW.sLong.
//
// Revision 1.226  2005/03/24 18:39:24  lulin
// - remove object: Tk2AtomR.
//
// Revision 1.225  2005/03/24 14:10:37  lulin
// - удалены ненужные методы.
//
// Revision 1.224  2005/03/22 12:59:55  narry
// - update
//
// Revision 1.223  2005/03/21 10:04:55  lulin
// - new interface: _Ik2Type.
//
// Revision 1.222  2005/03/19 16:40:02  lulin
// - спрятаны ненужные методы.
//
// Revision 1.221  2005/03/18 16:24:24  narry
// - update: замена прямого оформления аннотаций стилевым
//
// Revision 1.220  2005/03/18 16:11:27  lulin
// - remove method: Tk2AtomR.Write.
//
// Revision 1.219  2005/03/15 10:30:26  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.218  2005/03/02 16:28:19  narry
// - исправление: поддержка аннотаций
//
// Revision 1.217  2005/02/25 16:21:26  narry
// - update: поддержка Аннотаций
//
// Revision 1.216  2005/02/24 15:24:49  narry
// - update
//
// Revision 1.215  2005/02/18 11:51:46  narry
// - update: уточнение требований
//
// Revision 1.214  2005/02/16 17:11:14  narry
// - update: поддержка Аннотаций
//
// Revision 1.213  2004/11/30 13:32:36  narry
// - bug fix
//
// Revision 1.212  2004/11/04 15:15:29  narry
// - bug fix: чтение "недокументов"
//
// Revision 1.211  2004/09/21 12:21:05  lulin
// - Release заменил на Cleanup.
//
// Revision 1.210  2004/09/14 15:58:03  lulin
// - удален модуль Str_Man - используйте вместо него - l3String.
//
// Revision 1.209  2004/09/09 12:29:50  narry
// - cleanup
//
// Revision 1.208  2004/09/01 13:29:14  narry
// - bug fix: Не сбрасывался флаг f_IsDictEntry
//
// Revision 1.207  2004/08/30 13:22:23  narry
// - update
//
// Revision 1.206  2004/08/30 08:50:15  narry
// - bug fix: AV призагрузке документа без команды !TOPIC
//
// Revision 1.205  2004/07/28 14:16:03  narry
// - update: окончание реализации поддержки команды !NOTTM
//
// Revision 1.204  2004/07/23 14:59:53  narry
// - new: поддержка команды !NOTTM
//
// Revision 1.203  2004/07/21 13:47:58  narry
// - bug fix: неосвобожденные объекты
//
// Revision 1.202  2004/07/15 15:46:24  narry
// - bug fix: замена символа #255 на #32 в служебных строках
//
// Revision 1.201  2004/06/29 14:26:45  law
// - избавляемся от метода Tk2AtomR._Set.
//
// Revision 1.200  2004/06/01 16:51:23  law
// - удален конструктор Tl3VList.MakePersistent - пользуйтесь _Tl3ObjectRefList.
//
// Revision 1.199  2004/05/31 14:01:35  narry
// - bug fix: не добавлялась запись о интервале действия
//
// Revision 1.198  2004/05/18 13:38:22  narry
// - bug fix: AV при незакрытом пустом блоке
//
// Revision 1.197  2004/05/18 08:28:15  narry
// - update: корректное присвоение кодовой страницы терминам словарной статьи
//
// Revision 1.196  2004/05/14 17:27:04  law
// - remove unit: evStrGen.
//
// Revision 1.195  2004/05/14 15:17:01  law
// - remove unit: evTypesE.
//
// Revision 1.194  2004/05/07 12:27:17  narry
// - update: поддержка типа документа DictEntry
//
// Revision 1.193  2004/04/29 13:20:02  narry
// - new: поддержка команды !TERM
//
// Revision 1.192  2004/04/14 14:59:14  law
// - rename proc: ev_lPAnsiCharSetPresent -> l3CharSetPresent.
//
// Revision 1.191  2004/04/12 13:31:54  voba
// - buf fix: не импортировался значек параграфа
//
// Revision 1.190  2004/04/12 12:24:26  narry
// - update: поддержка нового формата !CONTENTS
//
// Revision 1.189  2004/04/12 08:19:57  law
// - change: "оказалось" что у команды !Contents другой формат.
//
// Revision 1.188  2004/04/05 11:14:00  narry
// - cleanup
//
// Revision 1.187  2004/03/26 13:24:33  narry
// - bug fix: перевод миллиметров в шурадюймы для размеров страницы
// - bug fix: игнорирование пересечения периода неуверенности
//
// Revision 1.186  2004/03/23 09:42:53  narry
// - update: диапазон дат у PUBLISHEDIN может отсутствовать
//
// Revision 1.185  2004/03/19 10:39:31  narry
// - cleanup: замена технологии "парашютистов" при проверке дат в !PUBLISHEDIN на контроль легальности дат
//
// Revision 1.184  2004/03/17 13:31:41  narry
// - new: поддержка расширенного формата команды !PUBLISHEDIN
//
// Revision 1.183  2004/03/16 15:20:51  law
// - new unit: evDocumentBuffer.
//
// Revision 1.182  2004/03/11 14:15:55  narry
// - new: поддержка команды !VANONCED
//
// Revision 1.181  2004/03/09 11:34:12  narry
// - new: поддержка команды !NOTSURE
//
// Revision 1.180  2004/03/05 15:04:46  narry
// - update: поддержка команды !CONTENTS
//
// Revision 1.179  2004/03/04 17:54:47  narry
// - new: поддержка команды !CONTENTS
//
// Revision 1.178  2004/02/09 15:26:36  narry
// - bug fix: пропадала вторая дата в связке Date1-Date2
//
// Revision 1.177  2004/02/03 15:51:00  narry
// - update
//
// Revision 1.176  2004/01/29 13:34:35  narry
// - update: поддержка нового формата команды !PUBLISHEDIN
//
// Revision 1.175  2004/01/29 10:36:46  narry
// - update
//
// Revision 1.174  2004/01/21 16:12:47  narry
// - cleanup
//
// Revision 1.173  2004/01/20 14:54:10  narry
// - cleanup
// - update: "заточка напильником" для чтения "неправильных" (без команды !TOPIC) nsr-файлов
//
// Revision 1.172  2003/12/09 14:14:56  narry
// - add: поддержка чтения нового стиля ev_saNotApplied
//
// Revision 1.171  2003/11/28 14:11:11  law
// - new unit: evSegmentsListConst.
//
// Revision 1.170  2003/11/13 11:29:43  narry
// - bug fix: неправильное форматирование команды !ACTIVE приводило к ошибке загрузки документа
//
// Revision 1.169  2003/09/26 14:05:38  narry
// - bug fix: комментарий сразу после команды !STYLE съедал следующие абзацы
//
// Revision 1.168  2003/08/22 09:05:12  narry
// - cleanup
// - new: поддержка команды !CHDATE
//
// Revision 1.167  2003/07/14 10:13:19  narry
// - bug fix: !ACTVIVE без конечной даты "съедала" следующую команду
// - bug fix: отсутствие конечной даты в !ACTIVE приводило к генерации отрицательной даты
// - update: добавление комментария в лог-файл при чтении отсутствующей даты.
//
// Revision 1.166  2003/06/04 11:55:16  narry
// no message
//
// Revision 1.165  2003/05/19 11:04:46  law
// - rename proc: evChar2Pixel -> evChar2Inch.
//
// Revision 1.164  2003/04/28 14:45:18  narry
// - bug fix: команда !ACTIVE без параметров генерила пустой абзац
//
// Revision 1.163  2003/04/25 12:09:55  narry
// - change: перенос класса TddTopicFilter из модуля ddNSRC_r в PipeDrm
//
// Revision 1.162  2003/04/19 12:30:37  law
// - new file: ddDefine.inc.
//
// Revision 1.161  2003/04/15 15:22:45  law
// - bug fix: не компилировался Эверест.
//
// Revision 1.160  2003/04/14 12:58:17  narry
// - add: формирование списка документов при импорте файлов Эверест
//
// Revision 1.159  2003/04/11 09:40:41  narry
// - add: для абзацев STYLE V пропускается первый сегмент (с оформлениме стиля)
//
// Revision 1.158  2003/04/04 17:04:41  narry
// - cleanup
//
// Revision 1.157  2003/03/31 09:56:32  narry
// - update: при отсутствии команды !ACTIVE в документ добавляется интервал minActiveDate-maxActiveDate
//
// Revision 1.156  2003/03/20 14:55:42  narry
// - update: изменение отображения диапазона дат в сообщении об ошибках
//
// Revision 1.155  2003/03/20 12:28:38  narry
// - new: контроль пересечения диапазонов ActiveInterval
//
// Revision 1.154  2003/03/17 13:20:00  narry
// Новые команды версионности
//
// Revision 1.153  2003/03/14 13:18:17  narry
// - remove dt_Active
//
// Revision 1.152  2003/03/14 09:55:35  narry
// - new: команды версионности. Компиляется, но не работает.
//
// Revision 1.151  2003/02/12 13:31:51  narry
// - bug fix: смещение ссылки при слиянии многострочных абзацев Заголовок 1
//
// Revision 1.150  2003/01/30 10:56:09  narry
// - cleanup
//
// Revision 1.149  2003/01/30 10:37:12  narry
// - new behavior: чтение SubID=0 для команд версионности
//
// Revision 1.148  2003/01/27 16:40:37  narry
// - update: обработка двойных кавычек в командах VerXXXChanger
//
// Revision 1.147  2003/01/21 14:43:47  narry
// - bug fix
//
// Revision 1.146  2003/01/20 14:03:27  narry
// - update: поддержка версионности
//
// Revision 1.145  2003/01/17 10:24:09  narry
// - update
//
// Revision 1.144  2003/01/16 14:51:22  narry
// - new behavior: поддержка версионности блоков
//
// Revision 1.143  2002/12/03 15:29:47  narry
// - bug fix: потеря метки у последней мультиссылки
//
// Revision 1.142  2002/10/27 21:00:09  narry
// - bug fix: попытка создать абзац комментария внутри текстового абзаца
//
// Revision 1.141  2002/10/24 13:54:25  narry
// - bug fix: при совпадении сегмента и ссылки сегмент теряется
//
// Revision 1.140  2002/10/22 10:41:54  narry
// - bug fix: Exception при добавлении записи об этапе несуществующего пользователя
//
// Revision 1.139  2002/10/16 11:16:19  narry
// - new behavior: для NODOC со STAGE 1 добавлется VINCLUDED
//
// Revision 1.138  2002/10/08 15:07:03  law
// - new directive: NotNeedGarDoc.
//
// Revision 1.137  2002/10/08 14:07:43  narry
// - bug fix: ошибка синтаксиса
//
// Revision 1.136  2002/10/08 13:56:21  narry
// - new behavior: возможность закрыть этап в Гардоке
//
// Revision 1.135  2002/10/07 11:23:44  narry
// - bug fix: "мультиссылка" создавала лишнюю ссылку на документ с номером метки
//
// Revision 1.134  2002/09/05 12:00:24  narry
// - new behavior: support for k2_idDictItem
//
// Revision 1.133  2002/09/03 08:00:23  narry
// - new behavior: support for k2_idDictItem
//
// Revision 1.132  2002/08/28 08:15:20  narry
// - bug fix
//
// Revision 1.131  2002/07/31 12:36:48  narry
// - bug fix: GPF при попытке обратиться к несуществующему списку меток
//
// Revision 1.130  2002/07/29 14:57:18  narry
// - update: вывод номера Sub для более точного позиционирования на ошибку
//
// Revision 1.129  2002/07/09 12:02:17  law
// - rename unit: evUnits -> l3Units.
//
// Revision 1.128  2002/07/05 08:46:26  narry
// - bug fix: пустая строка после команды STYLE приводит к чтению следующей строки без анализа на наличие в ней команд
//
// Revision 1.127  2002/07/03 09:00:57  narry
// - update, cleanup и new behavior
//
// Revision 1.126  2002/06/27 11:17:08  narry
// - new behavior: присвоения стиля NormalNote абзацам справки с оформлением J 1 73 1
//
// Revision 1.125  2002/06/13 08:34:47  narry
// - bug fix: символ оформления, окруженный пробелами приводил к потере сегмента
//
// Revision 1.124  2002/06/10 10:54:18  narry
// - new behavior: при чтении документа из пары команд !DOC и !CALENDAR остается только !CALENDAR
//
// Revision 1.123  2002/05/15 15:51:45  narry
// - bug fix: комментарий после SBS-абзаца разрушал SBS-абзац
//
// Revision 1.122  2002/05/15 11:58:07  narry
// - bug fix: пустой комментарий пропускался в текст документа
//
// Revision 1.121  2002/04/15 07:11:48  narry
// - update: подавление лишнего вывода в лог
//
// Revision 1.120  2002/04/02 13:46:19  narry
// - new behavior: поддержка команды !REFDOC
//
// Revision 1.119  2002/04/01 15:01:30  narry
// - bug fix: импорт "неправильной" даты окончания этапа при отсутствии таковой
//
// Revision 1.118  2002/03/27 23:00:58  narry
// - bug fix: пропадает текст абзаца, если внутри абзаца встречается комментарий
//
// Revision 1.117  2002/03/14 13:54:41  narry
// - bug fix: приведение сообщений об ошибках в _AnsiCodePage
//
// Revision 1.116  2002/03/12 13:06:16  narry
// - bug fix: комментарий в SUB перед пустым абзацем "съедал" следующую команду
//
// Revision 1.115  2002/02/21 09:53:03  narry
// - new behavior: при чтении комментариев пропускаем строку с % в первой позиции
//
// Revision 1.114  2002/02/07 15:12:10  narry
// - new behavior: группы и группы документов не читаются из файлов справок
//
// Revision 1.113  2002/02/07 10:01:30  narry
// - bug fix: комментарии в атрибутах метки
//
// Revision 1.112  2002/02/06 14:48:43  narry
// - bug fix: не заливались графические объекты
//
// Revision 1.111  2002/02/06 14:01:03  narry
// - bug fix: Номер метки равен нулю
//
// Revision 1.110  2002/02/01 11:51:06  narry
// - update: поддержка Групп Доступа, расширение диапазона Заголовок статьи, проверка на существование OBJPATH
//
// Revision 1.109  2001/12/14 15:24:50  law
// - new constructor: Tl3StringStream.Create.
//
// Revision 1.108  2001/12/13 09:33:29  narry
// - new behavior: комментарий, содержащий команду NSRC комментарием более не считается
//
// Revision 1.107  2001/11/30 14:46:05  narry
// - bug fix: пропуск аттрибутов метки при наличии комментария
//
// Revision 1.106  2001/11/28 14:42:34  narry
// - bug fix: стиль абзаца присваивался стилю сегмента размером с абзац
//
// Revision 1.105  2001/11/22 13:58:43  narry
// - update : начало реализации Групп доступа
//
// Revision 1.104  2001/11/08 08:37:42  narry
// - update: расширен список "неправильных" комментариев
//
// Revision 1.103  2001/11/02 10:26:06  narry
// - bug fix: убрана заплата, не позволявщая разбирать стиль "Заголовок статьи"
//
// Revision 1.102  2001/10/30 13:31:59  narry
// - update: игнорирование комментария !NOACTIVE
//
// Revision 1.101  2001/10/30 12:32:16  narry
// - bug fix and new behavior: отключение преобразования STYLE T в таблицу;
//             преобразование комментариев в абзацы текста со стилем "Технический комментарий"
//
// Revision 1.100  2001/09/28 07:11:28  narry
// - bug fix: были ошибки в курсоре для списка строк.
//
// Revision 1.99  2001/08/31 11:02:36  law
// - rename unit: MyUtil -> l3FileUtils.
//
// Revision 1.98  2001/08/29 15:36:26  law
// - cleanup: удалены ненужные зависимости от Orpheus и SysTools.
//
// Revision 1.97  2001/08/28 09:25:56  narry
// - update : изменение констант Демон
//
// Revision 1.96  2001/07/12 13:25:56  narry
// -bug fix: при выставленном флаге StrictFormat=False некорректно
//    обрабатывалось начало документ
//
// Revision 1.95  2001/06/27 12:22:43  narry
// -new behavior: заточка напильником заливки Style P - отсекаются
//                         концевые пробелы и не растягивается оформление
//                         на всю строку
//
// Revision 1.94  2001/06/07 15:38:04  narry
// - bug fix: ошибочное сообщение об ошибке при заливке OBJTOPIC
//               отсутствие сообщения о начале OBJTOPIC
//
// Revision 1.93  2001/06/04 09:13:54  narry
// - bug fix - разбор стиля Т
// - new behavior - накопление комментариев со всего документа
//                           и событие при выливке комментарие
//
// Revision 1.92  2001/05/30 09:11:18  law
// - new behavior: пытаемся централизовать обработку ошибок чтения документов.
//
// Revision 1.91  2001/05/22 11:51:08  narry
// Update - чтение разделов, сборка всех комментариев в одном месте, событие на начало топик
//
// Revision 1.90  2001/05/07 14:05:44  narry
// Update - изменение логики обработки сегменто
//
// Revision 1.89  2001/04/28 07:27:18  narry
// Bug fix - обработка символа #5 в сегментах
//
// Revision 1.88  2001/04/27 08:06:08  narry
// Update - обработка команды !DIVISION
//
// Revision 1.87  2001/03/28 15:20:33  narry
// Исправлено залитие пустого номера справки
//
// Revision 1.86  2001/03/02 11:54:20  narry
// Update
//
// Revision 1.85  2001/02/28 10:12:39  law
// - процедуры Write и WriteEx объединены в одну - Write.
//
// Revision 1.84  2001/02/27 17:10:53  law
// - убраны ненужные вызовы.
//
// Revision 1.83  2001/02/22 11:32:59  narry
// Bug fix - bad hyperlinks
//
// Revision 1.82  2001/02/06 13:03:48  narry
// Bug fix - SBS merging
//
// Revision 1.81  2001/02/01 09:06:10  narry
// Fix - codepage for SBS
// Add - message for empty address hyperlink
//
// Revision 1.80  2001/01/31 15:05:36  narry
// Add  - merge SBS paragraphs
//
// Revision 1.79  2001/01/29 07:14:58  narry
// Small but dangerous bug with format error messages
//
// Revision 1.78  2001/01/19 12:26:19  narry
// Fix bad segments
//
// Revision 1.77  2001/01/16 11:37:48  narry
// Small fix
//
// Revision 1.76  2000/12/15 15:29:54  law
// - вставлены директивы Log и Id.
//

{$I ddDefine.inc}
{$I dtDefine.inc}

{.$DEFINE StyleCount}
{.DEFINE LAWless}
{.$DEFINE DebugBreak}
{$DEFINE ddLog}
{.$DEFINE AutoTable}
{.$DEFINE WithoutCache}
{$DEFINE AllComments}
{.$DEFINE KSE}
{.$DEFINE AdjustPref}
{$Define AccGroups}

interface
{ TODO -oДудко -cУлучшение : Нужно провести рефагторинг - слишком уж все запутано. }

uses
  SysUtils,
  Classes,

  l3Base,
  l3Types,
  l3Parser,
  l3Date,
  l3StringList,

  k2Interfaces,
  k2Base,
  k2TagGen,
  k2Reader,
  k2DocumentBuffer,

  evdDOM,

  ddBase,
  ddTypes,
  ddSegmentScanner,
  ddNSRCConst,

  dt_Types,
  dt_AttrSchema,

  evdTypes,
  segObjectList,
  segHyperLinkList,
  segSegList,

  ddNSRCSub,
  ddNSRCSubList,

  ddTk2TypeList,
  ddDoc2DocLinkRecList
  ;

type
  TddDateNumRec = record
    Date: Longint;
    Number: Tl3String;
  end;//TddDateNumRec

  TddLanguageArray = array[TevdLanguage] of Tl3String;

  TCustomNSRCReader = class(Tk2CustomFileParser)
  private
    {$IFNDEF WithoutCache}
    f_Header: Tk2DocumentBuffer;
    {$ENDIF}
    f_OnAddSize: TAddSizeEvent;
    f_Warning: Boolean;
    f_Text: Tl3String;
    f_TokenReaded: Boolean;
    FTypes: TddTk2TypeList;
(*    FEmptyParaCount : Longint;*)
    IsGraphic: Boolean;
    BlockCount: Longint;
    {$IFDEF LAWless}
    f_Line: Tl3String;
    {$ENDIF}
    BlockNo: Longint;
    f_TopicNo: Longint;
    f_Left,
    f_Right: Tl3String;
    f_Step2: Boolean;
    f_WorkDir: AnsiString;
    f_GraphicObj: Boolean;
    f_LineParser : Tl3CustomParser;
    f_CodePage: Long;
    { Пара для заполнения Дата-Номер }
    f_DateNums : array[TDNType] of TddDateNumRec;
    f_DateNumsWritten: Boolean;
    f_DocHeaderWritten: Boolean;
    f_EnableComment: Boolean;
    f_Comment: Tl3String;
    f_NeedBlockName: Boolean;
    f_PictureDir: AnsiString;
    f_Block: TddNSRCSub;
    f_SBSWrite: Boolean;
    f_Abort: Boolean;
    f_SpecialBase: Boolean;
    f_IsAnno: Boolean;
    f_IsBody : Boolean;
    f_IsRel: Boolean;
    {$IFDEF AccGroups}
    f_AccGroups: Tl3String;
    {$ENDIF}
    f_CellCount: Integer;
    f_AnsiCodePage: Integer;
    f_OnError : TddErrorEvent;
    f_CommentWrite: TddCommentWriteEvent;
    f_DocStarted: Boolean;
    f_IsAdditional: Boolean;
    f_IsCalendar: Boolean;
    f_NeedVIncluded: Boolean;
    f_StageIncludedDate: Longint;
    f_Termins: TddLanguageArray;
    f_IsDictEntry: Boolean;
    f_LinkedDocs: TddDoc2DocLinkRecList;
    f_NotFilterGroups: Boolean;
    f_ObjPath: AnsiString;
    f_RowCount: Integer;
    f_Scanner: TddSegmentScanner;
    f_Status: Integer;
    f_TableCount: Integer;
    f_TableType: Integer;
    f_UserType: TUserType;
    f_AbortLoading: Boolean;
    f_EmptyParagraph: Integer;
    f_StrictFormat: Boolean;
    f_FirstStep: Boolean;
    f_OnlyClasses: Boolean;
    f_Subs: TddNSRCSubList;
    procedure CheckPara(aIsDecor: Boolean = False);
    procedure SetDate(Index: TDNType; Value: Longint);
    procedure SetNumber(Index: TDNType; Value: Tl3String);
    function GetDate(Index: TDNType): Longint;
    function GetNumber(Index: TDNType): Tl3String;
    procedure SetEnableComment(Value: Boolean);
    procedure HeaderAddBoolAtom(Index: Long; Value: Boolean);
    procedure HeaderAddIntegerAtom(Index: Long; Value: Long);
    procedure HeaderAddStringAtom(Index: Long; Value: Tl3String); overload;
    procedure HeaderAddStringAtom(Index: Long; const Value: AnsiString); overload;
    procedure HeaderStartChild(TypeID: Tk2Type);
    procedure HeaderStartTag(TagID: Long);
    procedure HeaderFinish;
    procedure AddAlarm(const aDate: Longint; const aComment: AnsiString);
    procedure AddActiveInterval(const aStart, aFinish: Longint; const aComment:
        AnsiString; NotSure: Boolean = False);
    procedure ClearParams;
    procedure CollectName(const aKeyword: AnsiString);
    function GetInteger(aDefault: Integer = 0): Integer;
    function IsTable: Boolean;
    function ReadDate(DateNeeded: Boolean): ShortString;
    function ReadTime(TimeNeeded: Boolean): ShortString;
    function ReadDateInt(const aDescriptor: AnsiString): Longint;
    function ReadInt: Integer;
    function ReadAddress: dt_Types.TRefAddress;
    procedure ReadText(Convert: Boolean);
    function ReadTimeInt(const aDescriptor: AnsiString): Longint;
    function _ValidDate(const aDateStr: AnsiString): Boolean;
    function _ValidTime(const aTimeStr: AnsiString): Boolean;
    procedure AddAlignBySeparator(aOffset: Integer);
    procedure Try2ReadComment(aSigleCheck: Boolean);
     {* - Попытка обобщить чтение комментариев. }
  protected
    procedure CheckAddionalSymbol;
    {-------------}
    procedure Prepare2Load;
    procedure TranslateStyle(aIsDecor: Boolean = False);
    procedure TranslateSub;
    procedure TranslateName;
    procedure TranslateSource;
    procedure TranslateType;
    procedure TranslateKeywords;
    procedure TranslateBelongs;
    procedure TranslateWarning;
    procedure TranslateClassAndSuffix;
    procedure TranslateDOC;
    procedure TranslateNoDoc;
    procedure TranslateCalendar;
    procedure TranslateRevision;
    procedure TranslateBusiness;
    procedure TranslateUserInfo;
    procedure TranslateDate;
    procedure TranslateRDate;
    procedure TranslateGDDate;
    procedure TranslateSFDate;
    procedure TranslateChDate;
    procedure TranslateSFCode;
    procedure TranslateGDCode;
    procedure TranslateRCode;
    procedure TranslateCode;
    procedure TranslateAddCode;
    procedure TranslateVIncluded;
    procedure TranslateVChanged;
    procedure TranslateVAbolished;
    procedure TranslateVLControl;
    procedure TranslateVAnonced;
    procedure TranslateRelated;
    procedure TranslateBlock;
    procedure TranslateBlockEnd;
    procedure TranslatePriority;
    procedure TranslateSortDate;
    procedure TranslateNoActive;
    procedure TranslateRel;
    procedure TranslateStage;
    procedure TranslateCheck;
    procedure TranslatePublishedIn;
    procedure TranslatePrefix;
    procedure TranslateTerritory;
    procedure TranslateNorm;
    procedure TranslatePreActive;
    procedure TranslateMOJNotReg;
    procedure TranslateObjType;
    procedure TranslateObjPath;
    procedure TranslatePriceLevel;
    procedure TranslateTable;
    procedure TranslateComment;
    procedure TranslateDivision;
    procedure TranslateMain;
    procedure TranslateRefDoc;
    procedure TranslateVerLink;
    procedure TranslateEdition;
    procedure TranslateActive(NotSure: Boolean = False);
    procedure TranslateAlarm;
    procedure TranslateContents;
    procedure TranslateTerm;
    procedure TranslateNotTM;
    procedure TranslateAnnoClasses(const aPrefix: AnsiString);
    procedure TranslateAnnoDate;
    procedure TranslateAnnoName;
(*    procedure TranslateAnyDate(aAtomIndex: Long; const aMessage: AnsiString);*)
    procedure TranslateBook;
    procedure TranslateLog;
    procedure TranslateServiceInfo;
    procedure TranslateIzm;
    procedure TranslateUrgency;
    //procedure TranslateDNLawCase;
    procedure TranslateNameComment;
    {-------------------------}
    function GetCurrentType: Tk2Type;
    procedure SetCurrentType(value: Tk2Type);
    procedure FlushObjectStream;
    procedure FinishCurrentType;
    procedure WriteParagraph(aJustifyChar: AnsiChar; aLeftIndent, aRightIndent, aFirstIndent, aFontHeight:
        Integer; aText: Tl3String; var aSubs: TddNSRCSubList; aTrim: Boolean; aCheckGraph: Boolean =
        True);
    procedure WriteSBSPara(const aText: Tl3String; var Subs: TddNSRCSubList);
    procedure WriteEmptyParagraph(var aSubs:  TddNSRCSubList);
    procedure WriteDateNum(Index: TDNType);
    procedure CheckDateNums;
    {$IFNDEF WithoutCache}
    procedure CheckDocHeader;
    procedure CheckDocumentEnd;
    {$ENDIF}
    procedure WriteBlock;
    procedure Cleanup; override;
    procedure CollectSubAttributes(aSub: TddNSRCSub);
    procedure FinalizeDocument;
    procedure OutErrorLog(const aMsg: AnsiString);
    procedure ScanForSegment(aText: Tl3String; aTrim: Boolean; var SegList: TsegSegList; var Links: TsegHyperLinkList;
        var Objects: TsegObjectList; aC: AnsiChar);

    procedure OutLeftText(const Sender: Ik2TagGenerator);
    procedure OutRightText(const Sender: Ik2TagGenerator);
    procedure StartDocument(TagID: Tk2Type; aDocType: TDocType = dtText);
    procedure TranslateCell;
    procedure TranslateCellEnd;
    procedure TranslateChange;
    procedure TranslateLanguage;
    procedure TranslateRow;
    procedure TranslateRowEnd;
    procedure TranslateCaseCode;
    procedure TranslateTableEnd;
    procedure WorkupToken;
    function IsValidToken: Boolean;
    procedure TranslateCompareContents;
    procedure TranslateNOCOMPARE;
    procedure TranslateLeftIndent;
    procedure TranslateInternet;
    procedure TranslateHang;
    procedure TranslateDocType;
    procedure TranslateKind;
    procedure TranslateZoom;
    property DN_Date[Index: TDNType]: Longint
      read GetDate write SetDate;
    property DN_Number[Index: TDNType]: Tl3String
      read GetNumber write SetNumber;
    property EnableComment: Boolean
      read f_EnableComment write SetEnableComment;
    property NeedBlockName: Boolean
      read f_NeedBlockName write f_NeedBlockName;
    function  NeedConvertFolmulasToUnicode: Boolean; override;  
  public
    constructor Create(aOwner: Tk2TagGeneratorOwner); override;
    procedure Read; override;

    property SpecialBase: Boolean
      read f_SpecialBase write f_SpecialBase;
    property StrictFormat: Boolean
      read f_StrictFormat write f_StrictFormat;
    property OnlyClasses : Boolean
      read f_OnlyClasses write f_OnlyClasses;

    property AbortLoading : Boolean
      read f_AbortLoading;
    property AnsiCodePage: Integer read f_AnsiCodePage write f_AnsiCodePage;
    property StopLoading : Boolean
      read f_Abort write f_Abort;
    property CurrentType: Tk2Type
      read GetCurrentType write SetCurrentType;
    property StepNumberTwo: Boolean
      read f_Step2 write f_Step2;
    property WorkDir: AnsiString
      read f_WorkDir write f_WorkDir;
    property CodePage: Long
      read f_CodePage write f_CodePage;
    property DocHeaderWritten: Boolean read f_DocHeaderWritten write f_DocHeaderWritten;
    property DocStarted: Boolean read f_DocStarted write f_DocStarted;
    property PictureDir: AnsiString
      read f_PictureDir write f_PictureDir;

    property FirstStep: Boolean
     read f_FirstStep
     write f_FirstStep;
    property NotFilterGroups: Boolean read f_NotFilterGroups write f_NotFilterGroups;
    property TokenReaded: Boolean read f_TokenReaded write f_TokenReaded;
    property TopicNo: Longint read f_TopicNo write f_TopicNo;
    property Warning: Boolean read f_Warning write f_Warning;
    property OnAddSize: TAddSizeEvent
      read f_OnAddSize write f_OnAddSize;
    property OnError : TddErrorEvent
      read f_OnError write f_OnError;
    property OnCommentWrite: TddCommentWriteEvent
      read f_CommentWrite write f_CommentWrite;
  end;//TCustomNSRCReader

const
  chrStartToken  = '!';
  AllWhiteSpace  = [#0..#32]-[#1..#7,#9..#11,#13..#31];
  PrefWhiteSpace = [#0..#31]-[#1..#7,#9..#11,#13..#31];

  NsrcBadDate = 0;

  stageIncluded = 1;

implementation

uses
  Windows,

  StrUtils,

  ComObj,

  imageenio,

  m0DTFlib,

  l3Variant,

  l3Chars,
  l3MinMax,
  l3Math,
  l3String,
  l3Memory,
  l3Bits,
  l3Stream,
  l3Filer,
  l3FileUtils,
  l3UnitsTools,
  l3Interfaces,

  DT_Const,

  evConst,
  evTypes,
  evSectionPara,
  evNSRCConst,

  k2BaseTypes,
  k2Tags,

  evDef,
  evdStyles,
  evSBStm,

  l3PrimString,
  Math,

  TabStop_Const, 
  Table_Const,
  TableRow_Const,
  TableCell_Const,
  SBS_Const,
  SBSCell_Const,
  Document_Const,
  DecorTextPara_Const,
  TextPara_Const,
  SegmentsLayer_Const,
  TextSegment_Const,
  Hyperlink_Const,
  Address_Const,
  ObjectSegment_Const,
  Formula_Const,
  SubLayer_Const,
  Sub_Const,
  SBSRow_Const,
  DictItem_Const,
  BitmapPara_Const,
  ExtDataPara_Const,
  NumAndDate_Const,
  PIRec_Const,
  Check_Const,
  Stage_Const,
  Block_Const,
  LogRecord_Const,
  PageBreak_Const,
  SectionBreak_Const,
  AnnoTopic_Const,
  DictEntry_Const,
  k2String_Const,
  ActiveInterval_Const,
  Alarm_Const,
  l3_String,
  evStyleInterface,

  evdNativeReader,
  ddNSRCSegments,
  
  k2Empty_Const,
  evdFrame_Const
  ;

type
 TddTableParts = (tpTable, tpRow, tpCell);

function TableTypes(aType: Integer; aPart: TddTableParts): Tk2Type;
begin//TableTypes
 Case aType of
  0 :
  begin
   Case aPart of
    tpTable:
     Result := k2_typTable;
    tpRow:
     Result := k2_typTableRow;
    tpCell:
     Result := k2_typTableCell;
    else
    begin
     Result := nil;
     Assert(false);
    end;//else
   end;//Case aPart
  end;//0
  1 :
  begin
   Case aPart of
    tpTable:
     Result := k2_typSBS;
    tpRow:
     Result := k2_typSBSRow;
    tpCell:
     Result := k2_typSBSCell;
    else
    begin
     Result := nil;
     Assert(false);
    end;//else
   end;//Case aPart
  end;//1
  else
  begin
   Result := nil;
   Assert(false);
  end;//else
 end;//Case aType
end;//TableTypes

resourcestring
 SNSCError_FormattingDate = 'Ошибка при формировании даты для !PUBLISHEDIN %s';
 SNSCError_ObsoleteFormat = 'TOPIC %d > Устаревший формат команды PUBLISHEDIN';
 SNSCError_WrongBlockNumber = 'TOPIC# %d > Неправильный номер блока %s';
 //SNSCError_LinkBadFormat = 'CRITICAL ERROR Topic#%d Ошибочный формат ссылки';
 //SNSCError_ShiftConvert = 'TOPIC# %d > Ошибка пребразования смещения ссылки "%s"';
 //SNSCError_AdressConvert = 'TOPIC# %d > Ошибка пребразования адреса ссылки "%s"';
 //SNSCError_NoLinkAddress = 'TOPIC# %d > Отсутствие адреса ссылки в абзаце <<%s>>';
 SNSCError_UnclosedLink = 'TOPIC# %d > Незакрытая ссылка в абзаце <<%s>>';
 SNSCError_UnclosedLinkSub = 'TOPIC# %d (SUB# %d %s)> Незакрытая ссылка в абзаце <<%s>>';
 SWarnHeader   = 'Добавление параметров документа после начала текста';
 SDeadComment  = '!NOACTIVE';
 SDeadComment2 = 'main';
 SDeadComment3 = 'check';
 SBadDate = 'error';
 SErrorDate = 'TOPIC# %d > Неправильная дата %s "%s"';

procedure SmartSplit(FullText: Tl3String; const LeftText, RightText: Tl3String);
var
 i, j: longint;
 l_Text: Tl3String;
begin
 j:= 0;
 l_Text:= Tl3String.Make(FullText.Codepage);
 try
  for j:= 0 to FullText.Len-1 do
  begin
   if FullText.Ch[j] <> #10 then
    l_Text.AsString:= l_Text.AsString + FullText.Ch[j];
   if (j = Pred(FullText.Len)) or (FullText.Ch[j] = #10) then
   begin
    i:= 0;
    while (i < l_Text.Len) and not (l_Text.Ch[i] in ['|',#9]) do
     Inc(i);

    if l_Text.Ch[i] in ['|', #9] then
    begin
     if not RightText.Empty then
      RightText.Append(#10);

     RightText.Append(l3PCharLen(l_Text.St+i+1, l_Text.Len-i-1, l_Text.CodePage));

     if not LeftText.Empty then
      LeftText.Append(#10);

     LeftText.Append(l3PCharLen(l_Text.St, i, l_Text.CodePage));
     TddSegmentScanner.SmartTrim(LeftText); TddSegmentScanner.SmartTrim(RightText);
     if (LeftText.Ch[0] < #32) and (RightText.Ch[0] <> LeftText.Ch[0]) and (LeftText.Ch[0] <> #4) then
     begin
      i:= 0;
      while (LeftText.Ch[i] < #32) and (i < LeftText.Len) do
      begin
       RightText.Insert(LeftText.Ch[i], i);
       Inc(i);
      end; // (LeftText.Ch[i] < #32) and (i < LeftText.Len)
      i:= RightText.len-1;
      while (RightText.Ch[i] < #32) and (i >= 0) do
      begin
       LeftText.Insert(RightText.Ch[i], LeftText.Len);
       Dec(i);
      end; // (RightText.Ch[i] < #32) and (i >= 0)
     end; // (LeftText.Ch[0] < #32) and (RightText.Ch[0] <> LeftText.Ch[0]) and (LeftText.Ch[0] <> #4)
     l_Text.Clear;
    end; // l_Text.Ch[i] in ['|', #9]
   end; //if (j = Pred(FullText.Len)) or (FullText.Ch[j] = #10)
  end; // for j
 finally
  l3Free(l_Text);
 end;
end;

function TCustomNSRCReader.NeedConvertFolmulasToUnicode: Boolean;
begin
 Result := true;
end;

procedure TCustomNSRCReader.SetEnableComment(Value: Boolean);
begin
  if Value then
  begin
    f_EnableComment:= Value;
    Parser.LineComment:= '';
  end
  else
  begin
    f_EnableComment:= Value;
    Parser.LineComment:= cc_SemiColon;
  end;
end;

procedure TCustomNSRCReader.ScanForSegment(aText: Tl3String; aTrim: Boolean;
    var SegList: TsegSegList; var Links: TsegHyperLinkList; var Objects: TsegObjectList; aC: AnsiChar);
var
 i: Integer;
begin
 if l3Starts('!!', aText.AsWStr) then
 // Костыль для http://mdp.garant.ru/pages/viewpage.action?pageId=608627000
  aText.Delete(0, 1);
 f_Scanner.Scan(aTExt, aTrim, aC);
 SegList:= f_Scanner.Segments;
 Links:= f_Scanner.Hyperlinks;
 Objects:= f_Scanner.Objects;
 for i:=0 to Pred(f_Scanner.Errors.Count) do
 begin
  if not f_Subs.Empty then
   OutErrorLog(Format(SNSCError_UnclosedLinkSub,
           [TopicNo,
            f_Subs.Items[f_Subs.Hi].ID,
            f_Subs.Items[f_Subs.Hi].Name.AsString,
            f_Scanner.Errors.Strings[i]]))
  else
   OutErrorLog(Format(SNSCError_UnclosedLink,
           [TopicNo, f_Scanner.Errors.Strings[i]]));
 end;
end; { ScanForSegment }

constructor TCustomNSRCReader.Create(aOwner: Tk2TagGeneratorOwner);
var
  i: TDNType;
  l: TevdLanguage;
begin
  inherited Create(aOwner);
  Parser.OpenComment := '';
  Parser.CloseComment := '';
  Parser.CheckFloat:= False;
  parser.CheckHex := False;
  Parser.CheckInt := False;
  FTypes := TddTk2TypeList.Create;
  f_CodePage:= cp_OEMLite;
  f_StrictFormat:= True;
  f_SpecialBase:= False;
  f_step2:= False;
  f_WorkDir:= '';
  for l:= Low(TevdLanguage) to High(TevdLanguage) do
   f_Termins[l]:= Tl3String.Create;

  for i:= Low(TDNType) to High(TDNType) do
  begin
    f_DateNums[i].Date:= nsrcBadDate;
    f_DateNums[i].Number:= Tl3String.Create;
  end;
  f_DateNumsWritten:= False;

  Parser.LineComment:= cc_SemiColon;

  f_LineParser := Tl3CustomParser.Create;
  with f_LineParser do
  begin
     CheckKeyWords := false;
     CheckFloat := false;
     LineComment  := '';
     OpenComment  := '';
     CloseComment := '';
  end;
  {$IFNDEF WithoutCache}
  f_Header:= Tk2DocumentBuffer.Create;
  {$ENDIF}
  f_FirstStep:= False;
  f_OnlyClasses:= False;
  f_Comment:= Tl3String.Create;
  {$IFDEF AccGroups}
  f_AccGroups:= Tl3String.Create;
  {$ENDIF}
 f_Scanner:= TddSegmentScanner.Create;
 f_LinkedDocs := TddDoc2DocLinkRecList.Create;
 f_NotFilterGroups:= False;
end;

procedure TCustomNSRCReader.Cleanup;
var
 i: TDNType;
 l: TevdLanguage;
begin
 l3Free(f_Scanner);
 l3Free(f_LinkedDocs);
 {$IFDEF AccGroups}
 l3Free(f_AccGroups);
 {$ENDIF}
 l3Free(f_Comment);
 l3Free(f_LineParser);
 L3Free(FTypes);
 {$IFDEF LAWless}
 l3Free(f_Line);
 {$ENDIF}
 for i:= Low(TDNType) to High(TDNType) do
 begin
  l3Free(f_DateNums[i].Number);
 end;
 for l:= Low(TevdLanguage) to High(TevdLanguage) do
   l3Free(f_Termins[l]);                  
 l3Free(f_Text);
 {$IFNDEF WithoutCache}
 l3Free(f_Header);
 {$ENDIF}
 inherited;
end;

function IfThen(aCond: Boolean; aA, aB: Tk2Type): Tk2Type; overload;
begin
 if aCond then
  Result := aA
 else
  Result := aB; 
end;

procedure TCustomNSRCReader.CheckPara(aIsDecor: Boolean = False);
var
 l_ParaType: Tk2Type;
begin
  if ((CurrentType <> k2_typEmpty) or not StrictFormat) and not FirstStep then
  begin
    if f_SBSWrite then Exit;
    
    if (f_Block <> nil) then
    begin
     f_Block.MakeName(f_Text);
     f_Block.Name.CodePage:= AnsiCodePage;
     WriteBlock;
     l3Free(f_Block);
    end;
    
    l_ParaType:= IfThen(aIsDecor, k2_typDecorTextPara, k2_typTextPara);
    if CurrentType <> l_ParaType then
    begin
      {$IFNDEF WithoutCache}
      CheckDocHeader;
      {$ENDIF}
      CurrentType:= l_ParaType;
    end;
  end;
end;

function TCustomNSRCReader.GetCurrentType: Tk2Type;
begin
  if FTypes.Count > 0 then
    Result:= FTypes.Items[Pred(FTypes.Count)]
  else
    Result:= k2_typEmpty;
end;

procedure TCustomNSRCReader.SetCurrentType(Value: Tk2Type);
var
 //C      : TChildID;
 l_Type : Tk2Type;
begin
  l_Type := Value;
  if not f_DocStarted and not l_Type.IsKindOf(k2_typDocument) then
  begin
    f_DocStarted:= True;
    CurrentType:= k2_typDocument;
  end
  else
  if l_Type.IsKindOf(k2_typDocument) then
   f_DocStarted:= True;

(*  C:= TChildID.Create;
  try
    C.ID:= Value;*)
    FTypes.Add(Value);
    if f_DocHeaderWritten then
     Generator.StartChild(Value)
    else
     HeaderStartChild(Value);
(*  finally
    l3Free(C);
  end;*)
end;

procedure TCustomNSRCReader.FinishCurrentType;
begin
 try
  FTypes.Delete(Pred(FTypes.Count));
  if f_DocHeaderWritten then
   Generator.Finish
  else
   HeaderFinish;
 except
  on E: EOleSysError do
  begin
   l3System.Exception2Log(E);
   OutErrorLog('CRITICAL ERROR: Неожиданное завершение документа');
   f_AbortLoading:= True;
   if (E.ErrorCode = STG_E_LOCKVIOLATION) then
    raise;
  end;//E: EOleSysError
  on E: Exception do
  begin
   l3System.Exception2Log(E);
   OutErrorLog('CRITICAL ERROR: Неожиданное завершение документа');
   f_AbortLoading:= True;
  end;//on E: Exception
 end;
end;

procedure TCustomNSRCReader.WriteEmptyParagraph(var aSubs:  TddNSRCSubList);
begin
  {$IFNDEF WithoutCache}
  CheckDocHeader;
  {$ENDIF}
  if f_Block <> nil then
  begin
    f_Block.Name.CodePage:= AnsiCodePage;
    WriteBlock;
    l3Free(f_Block);
  end;
 if (f_TableCount = 0) or (f_CellCount > 0) then
 begin
  CheckPara;
  if CurrentType = k2_typTextPara then
  begin
    if (aSubs <> nil) then
    begin
      WriteParagraph('P', 0, 73, 0, 12, nil, aSubs, False);
    end;
    FinishCurrentType;
  end
 end; 
end;

procedure TCustomNSRCReader.OutLeftText;
begin
 f_Left.Codepage:= AnsiCodePage;
 Sender.AddStringAtom(k2_tiText, f_Left.AsWStr);
end;

procedure TCustomNSRCReader.OutRightText;
begin
 f_Right.Codepage:= AnsiCodepage;
 Sender.AddStringAtom(k2_tiText, f_Right.AsWStr);
end;

procedure TCustomNSRCReader.WriteSBSPara(const aText: Tl3String; var Subs: TddNSRCSubList);
begin
(*  while FEmptyParaCount > 0 do
  begin
    Dec(FEmptyParaCount);
    CurrentType:= k2_typTextPara;
    FinishCurrentType;
  end;*)
 f_Left := Tl3String.Make(CodePage);
 try
  f_Right := Tl3String.Make(CodePage);
  try
   f_Subs:= Subs;
   SmartSplit(aText, f_Left, f_Right);

   if f_Block <> nil then
   begin
     f_Block.MakeName(aText);
     f_Block.Name.CodePage:= AnsiCodePage;
     WriteBlock;
     l3Free(f_Block);
   end;
   f_SBSWrite:= True;
   OutSBSEx(Generator, OutLeftText, OutRightText);
  finally
   l3Free(f_Right);
  end;
 finally
  f_SBSWrite:= False;
  l3Free(f_Left);
 end;
 Subs:= nil;
end;


procedure TCustomNSRCReader.WriteParagraph(aJustifyChar: AnsiChar; aLeftIndent, aRightIndent,
    aFirstIndent, aFontHeight: Integer; aText: Tl3String; var aSubs: TddNSRCSubList; aTrim:
    Boolean; aCheckGraph: Boolean = True);

 procedure lp_OutError(const aMessage: AnsiString);
 var
  l_SaveCodePage: Integer;
 begin
  l_SaveCodePage:= aText.CodePage;
  aText.CodePage:= AnsiCodePage;
  OutErrorLog(Format('Документ #%d, абзац "%s", ошибка обработки %s', [TopicNo, aText.AsString, aMessage]));
  aText.CodePage:= l_SaveCodePage;
 end;

 procedure lp_WriteSubs;
 var
  i: Integer;
  l_Sub: TddNSRCSub;
 begin
  if aSubs <> nil then
  try
   Generator.StartTag(k2_tiSubs);
   try
     Generator.StartChild(k2_typSubLayer);
     try
       Generator.AddIntegerAtom(k2_tiHandle, Ord(ev_sbtSub));

       for i:= 0 to Pred(aSubs.Count) do
       begin
        l_Sub:= aSubs.Items[i];

        Generator.StartChild(k2_typSub);
        try

         Generator.AddIntegerAtom(k2_tiHandle, l_Sub.ID);
         l_Sub.MakeName(aText);
         if not l_Sub.Name.Empty then
         begin
           if l_Sub.LegalName then
             Generator.AddStringAtom(k2_tiShortName, l_Sub.Name.AsWStr)
           else
             Generator.AddStringAtom(k2_tiName, l_Sub.Name.AsWStr)
         end; // if not l_Sub.Name.Empty

         if l_Sub.Generator.StreamOpened then
         begin
          l_Sub.Generator.Finish;
          if (Tk2DocumentBuffer(l_Sub.Generator).Root <> nil) AND
             Tk2DocumentBuffer(l_Sub.Generator).Root.IsValid then
          begin
           l_Sub.Generator.Finish;
           Tk2DocumentBuffer(l_Sub.Generator).Root.WriteTag(Generator, l3_spfAll, [k2_tiSubs]);
          end;
          Tk2DocumentBuffer(l_Sub.Generator).Root:= nil;
         end; // l_Sub.Generator.StreamOpened

        finally
         Generator.Finish;
        end; // idSub

       end; // for i

     finally
       Generator.Finish;
     end; // idSubLayer
   finally
     Generator.Finish;
   end; // tiSubs
   l3Free(aSubs);
  except
   lp_OutError('меток')
  end;
 end;

 procedure lp_WriteLinks(aLinks: TsegHyperLinkList);
 var
  i, j: Integer;
  l_HL: TsegHyperlink;
 begin//lp_WriteLinks
   if (aLinks <> nil) and (aLinks.Count > 0) then
   begin
     Generator.StartTag(k2_tiSegments);
     try
       Generator.StartChild(k2_typSegmentsLayer);
       try
         Generator.AddIntegerAtom(k2_tiHandle, Ord(ev_slHyperlinks));

         for i:= 0 to Pred(aLinks.Count) do
         begin
          Generator.StartChild(k2_typHyperlink);
          try
           l_HL:= aLinks.Items[i];
           Generator.AddIntegerAtom(k2_tiStart, l_HL.Start);
           Generator.AddIntegerAtom(k2_tiFinish, Min(l_HL.Finish, aText.Len));
           for j:= 0 to Pred(l_HL.Targets.Count) do
           begin
             Generator.StartChild(k2_typAddress);
             try
              Generator.AddIntegerAtom(k2_tiDocID, l_HL.Targets.Items[j].DocID);
              if l_HL.Targets.Items[j].SubID > -1 then
                Generator.AddIntegerAtom(k2_tiSubID, l_HL.Targets.Items[j].SubID);
             finally
              Generator.Finish;
             end; // idAddress
           end;
          finally
           {l3Free(HL);}
           Generator.Finish;
          end; // idHyperlink
         end; // for i
       finally
         Generator.Finish;
       end; // idSegmentsLayer
     finally
      Generator.Finish;
     end;
   end; // (Links <> nil) and (Links.Count > 0)
 end;//lp_WriteLinks

 procedure lp_WriteObjects(aObjects: TsegObjectList);

  procedure lp_OutputFormula(const aFormulaText: AnsiString);
  begin//lp_OutputFormula
   Generator.StartChild(k2_typFormula);
   try
    Generator.AddStringAtom(k2_tiText, aFormulaText);
   finally
    Generator.Finish;
   end; // idAddress
  end;//lp_OutputFormula

  var
   l_LayerStarted : Integer;

  procedure CloseLayer;
  begin//CloseLayer
   if (l_LayerStarted >= 0) then
   begin
    l_LayerStarted := -1;
    Generator.Finish;
   end;//not l_LayerStarted
  end;//CloseLayer

  procedure OpenLayer(aLayer: Integer);
  begin//OpenLayer
   if (l_LayerStarted >= 0) then
    if (l_LayerStarted <> aLayer) then
     CloseLayer;
   if (l_LayerStarted < 0) then
   begin
    l_LayerStarted := aLayer;
    Generator.StartChild(k2_typSegmentsLayer);
    Generator.AddIntegerAtom(k2_tiHandle, l_LayerStarted);
   end;//l_LayerStarted = nil
  end;//OpenLayer

 var
  i: Integer;
  l_Formula: TsegFormula;
  l_Picture: TsegPicture;
  l_Decor : TsegDecorSegment;
  l_IO: TImageEnIO;
  tmp_Stream : Tl3FileStream;
 begin//lp_WriteObjects
   if (aObjects <> nil) and (aObjects.Count > 0) then
   begin
     Generator.StartTag(k2_tiSegments);
     try
       l_LayerStarted := -1;
       try
         for i:= 0 to Pred(aObjects.Count) do
         begin
          //Generator.StartChild(k2_typObjectSegment);
          try
           if aObjects.Items[i] is TsegFormula then
           begin
            OpenLayer(Ord(ev_slObjects));
            Generator.StartChild(k2_typObjectSegment);
            try
             l_Formula := TsegFormula(aObjects.Items[i]);
             Generator.AddIntegerAtom(k2_tiStart, l_Formula.Start);
             Generator.AddIntegerAtom(k2_tiFinish, l_Formula.Start);
             lp_OutputFormula(l_Formula.Text);
            finally
             Generator.Finish;
            end;//try..finally
           end // aObjects.Items[i] is TsegFormula then
           else
           if aObjects.Items[i] is TsegPicture then
           begin
            OpenLayer(Ord(ev_slObjects));
            Generator.StartChild(k2_typObjectSegment);
            try
             l_Picture := TsegPicture(aObjects.Items[i]);
             Generator.AddIntegerAtom(k2_tiStart, l_Picture.Start);
             Generator.AddIntegerAtom(k2_tiFinish, l_Picture.Start);
             if not IsFullPath(l_Picture.FileName) then
              l_Picture.FileName := ConcatDirName(PictureDir, l_Picture.FileName);
             if FileExists(l_Picture.FileName) then
              try
               tmp_Stream := Tl3FileStream.Create(l_Picture.FileName, l3_fmRead);
               try
                Generator.StartChild(k2_typBitmapPara);
                try
                 Generator.AddStringAtom(k2_tiExternalPath, ExtractFileName(l_Picture.FileName));
                 Generator.AddStreamAtom(k2_tiData, tmp_Stream);
                 Generator.AddIntegerAtom(k2_tiExternalHandle, l_Picture.DocID);
                 Generator.AddIntegerAtom(k2_tiBaseLine, l_Picture.BaseLineOffset);
                 if l_Picture.DPI <> 0 then
                  Generator.AddIntegerAtom(k2_tiDPI, l_Picture.DPI);
                 if l_Picture.Height <> 0 then
                  Generator.AddIntegerAtom(k2_tiHeight, l_Picture.Height);
                 if l_Picture.Width <> 0 then
                  Generator.AddIntegerAtom(k2_tiWidth, l_Picture.Width);
                finally
                 Generator.Finish;
                end;
               finally
                l3Free(tmp_Stream);
               end;
              except
               on E: EFOpenError do
               begin
                {$IF Defined(Everestlite) or Defined(Archi)}
                lp_OutputFormula(Format('String(Ошибка загрузки файла картинки: %s)', [l_Picture.FileName]));
                {$IFEND}
                Parser.Str2Log(E.Message);
               end;
              end
             else
             begin
              {$IF Defined(Everestlite) or Defined(Archi)}
              lp_OutputFormula(Format('String(Ошибка загрузки файла картинки: %s)', [l_Picture.FileName]));
              {$IFEND}
              OutErrorLog('Отсутствует файл, указанный в сегменте-картинке ' + l_Picture.FileName);
             end;
            finally
             Generator.Finish;
            end;
           end// aObjects.Items[i] is TsegPicture then
(*           else
           if aObjects.Items[i] is TsegDecorSegment then
           begin
            OpenLayer(Ord(ev_slView));
            TddSegmentScanner.SaveDecor(TsegDecorSegment(aObjects.Items[i]), Generator);
           end//aObjects.Items[i] is TsegDecorSegment*)
           else
            Assert(false, 'Неизвестный тип сегмента');
          finally
           //Generator.Finish;
          end;
         end; // for i
       finally
         CloseLayer;
       end; // idSegmentsLayer
     finally
       Generator.Finish;
     end;
   end; //(Objects <> nil) and (Objects.Count > 0) 
 end;//lp_WriteObjects

 procedure lp_WriteSegments(aSegs: TsegSegList);
 var
  i : Integer;
 begin//lp_WriteSegments
  if (aSegs <> nil) and (aSegs.Count > 0) then
  begin
   Generator.StartTag(k2_tiSegments);
   try
    Generator.StartChild(k2_typSegmentsLayer);
    try
     Generator.AddIntegerAtom(k2_tiHandle, Ord(ev_slView));
     for i:= 0 to Pred(aSegs.Count) do
      aSegs.Items[i].SaveToGenerator(aText, Generator);
    finally
     Generator.Finish;
    end;//try..finally
   finally
    Generator.Finish;
   end;//try..finally
  end; //(Segs <> nil) and (Segs.Count > 0)
 end;//lp_WriteSegments

 function lp_ValidStyle(aStyle: Long; aJustify: TevIndentType): Boolean;
 begin
  with TevStyleInterface.Make(k2_typTextPara, aStyle) do
  try
   Result:= (evInch2Char(FirstIndent) = aFirstIndent) and
            (evInch2Char(LeftIndent) = aLeftIndent) and
            (evInch2Char(RightIndent) = aRightIndent) and
            (IndentType = ord(aJustify));
  finally
   Free;
  end;
 end;
var
  Segs : TsegSegList;
  Links : TsegHyperLinkList;
  Objects : TsegObjectList;
  l_Seg: TsegSeg;
  F: TsegFormula;
  i,j: Integer;
  l_Styled: Boolean;
  St: ShortString;
  l_Justify: TevIndentType;
  l_Style: Integer;
  l_Offset: Integer;
begin
 case aJustifyChar of
  'L': l_Justify:= ev_itLeft;
  'R': l_Justify:= ev_itRight;
  'C': l_Justify:= ev_itCenter;
  'P': l_Justify:= ev_itPreformatted;
  'D': begin
        l_Offset := aLeftIndent;
        aLeftIndent := 0;
        l_Justify:= ev_itWidth;
       end;
 else
  l_Justify:= ev_itWidth;
 end;
 l_Style:= IfThen(IsTable, ev_saNormalTable, ev_saTxtNormalANSI);

 {Разбираемся с кодировкой}
 if aCheckGraph and (aText <> nil) and (l_Justify = ev_itPreformatted) then
 begin
   if l3CharSetPresent(aText.st, aText.Len, cc_Graph_Criteria) then
   begin
     IsGraphic:= True;
     aTrim:= False;
     Generator.AddIntegerAtom(k2_tiStyle, ev_saTxtNormalOEM);
   end
   else
   begin
     Generator.AddIntegerAtom(k2_tiStyle, ev_saANSIDOS);
     IsGraphic:= False;
   end;
 end
 else
   IsGraphic:= False;

(*  while FEmptyParaCount > 0 do
  begin
    Dec(FEmptyParaCount);
    CurrentType:= k2_typTextPara;
    FinishCurrentType;
  end;*)
  l_Styled:= False;
  {$IFDEF DebugBreak}
  if (aLeftIndent = aRightIndent) and (aLeftIndent = aFirstIndent) then
    OutErrorLog(Format('TOPIC# %d > Нет места под текст абзаца', [TopicNo]));
  {$ENDIF}
  Segs:= nil;
  Links:= nil;
  if aText <> nil then
  begin
    if not IsGraphic then
      aText.CodePage:= AnsiCodePage;
    l3Replace(aText.AsWStr, [ev_NSRCSoftEnter], cc_SoftEnter);
    {$IFNDEF NsrPlusnsr}
    if ATrim and not IsGraphic then
    begin
      aText.RTrim;
      aText.DeleteDoubleSpace;
      aText.LTrim;
    end;
    {$ENDIF}

    if aFontHeight <> Tk2Prop(k2_typTextPara.Prop[k2_tiPrintFontSize]).DefaultValue then
     Generator.AddIntegerAtom(k2_tiPrintFontSize, aFontHeight);

    ScanForSegment(aText,  aTrim(*{$IFNDEF NsrPlusNsr}aTrim{$ELSE}False{$ENDIF}*), Segs, Links, Objects, aJustifyChar);

    if aJustifyChar = '#' then
    begin
     l_Styled:= True;
     Generator.AddIntegerAtom(k2_tiStyle, -aLeftIndent);
    end
    else
    begin
     if (not IsTable) and (not Segs.Empty and TsegSeg(Segs.First).ColorSelection) and lp_ValidStyle(ev_saTxtHeader1, l_Justify) then
     begin
       Generator.AddIntegerAtom(k2_tiStyle, ev_saTxtHeader1);
       TsegSeg(Segs.First).ColorSelection:= False;
       l_Styled:= True;
     end
     else
     if IsTable and lp_ValidStyle(ev_saNormalSBSLeft, l_Justify) then
     begin
      Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalSBSLeft);
      l_Styled:= True;
     end
     else
     if (not IsTable) and lp_ValidStyle(ev_saToLeft, l_Justify) then
     begin
      Generator.AddIntegerAtom(k2_tiStyle, ev_saToLeft);
      l_Styled:= True;
     end
     else
     if IsTable and lp_ValidStyle(ev_saNormalSBSRight, l_Justify) then
     begin
      Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalSBSRight);
      l_Styled:= True;
     end
     else
     if f_IsRel and lp_ValidStyle(ev_saNormalNote, l_Justify) then
     begin
      Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalNote);
      l_Styled:= True;
     end
     else
     if IsTable and lp_ValidStyle(ev_saNormalTable, l_Justify) then
     begin
      Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalTable);
      l_Styled:= True;
     end
     else
     if f_IsAnno and lp_ValidStyle(ev_saNormalAnno, l_Justify) then
     begin
      Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalAnno);
      l_Styled:= True;
     end
     else
     if (aJustifyChar = 'V') then
     begin
      Generator.AddIntegerAtom(k2_tiStyle, ev_saVersionInfo);
      l_Styled:= True;
      if not Segs.Empty then
      begin
       TsegSeg(Segs.First).Comment:= False;
       TsegSeg(Segs.First).Hidden:= False;
      end;
     end
     else
     if lp_ValidStyle(ev_saDictEntry, l_Justify) then
     begin
      Generator.AddIntegerAtom(k2_tiStyle, ev_saDictEntry);
      l_Styled:= True;
     end
     else
     if (not Segs.Empty and TsegSeg(Segs.First).ColorSelection) and
        (l_Justify = ev_itRight) and (aLeftIndent = 0) and (aRightIndent = 73) and (aFirstIndent in [0, 5]) then
     begin
      Generator.AddIntegerAtom(k2_tiStyle, ev_saEnclosureHeader);
      TsegSeg(Segs.First).ColorSelection:= False;
      l_Styled:= True;
     end;
     if (l_Justify = ev_itPreformatted) then
     begin
      aText.RTrim;
     end; //aJustifyChar = 'P'
    end;

   {.$IFNDEF NsrPlusNsr}
   if (Segs <> nil) and (Segs.Count > 0) then
   begin
     l_Seg:= TsegSeg(Segs.First);
     if (l_Seg.Start = 1) and (l_Seg.Finish >= aText.Len) then
     begin
       { Рассмотреть логику присвоения стиля всему абзацу, учитывая, что
         в сегменте может быть несколько различных оформлений }
       if l_Seg.Comment and lp_ValidStyle(ev_saTxtComment, l_Justify) then
       begin
        if aJustifyChar <> 'V' then
         Generator.AddIntegerAtom(k2_tiStyle, ev_saTxtComment);
        l_Seg.Comment:= False;
        l_Styled:= True;
        if not l_Seg.Hidden then
         Generator.AddBoolAtom(k2_tiVisible, True);
       end; // l_Seg.Comment
       if l_Seg.Hidden then
       begin
        if aJustifyChar <> 'V' then
         Generator.AddBoolAtom(k2_tiVisible, False);
        l_Seg.Hidden:= False;
       end; // l_Seg.Hidden
       if not (l_Seg.HLContinue or l_Seg.OutOfDate or l_Seg.ColorSelection or l_Seg.Comment or l_Seg.NotApplied) and
              ((l_Seg.Start = 1) and (l_Seg.Finish >= aText.Len)) then
        Segs.Delete(0);
     end;
   end; // (Segs <> nil) and (Segs.Count > 0)
   {.$ENDIF}
   lp_WriteSubs;
   lp_WriteSegments(Segs);
   lp_WriteLinks(Links);
   lp_WriteObjects(Objects);
  end; // aText <> nil
  if not l_Styled then
  begin
   if l_Justify = ev_itWidth then
   begin
    (*
    if (aLeftIndent = 0) and (aRightIndent = 73) and (aFirstIndent = 5) then
     l_Styled:= True
    else
    *)
    if lp_ValidStyle(ev_saArticleHeader, l_Justify) then
    begin
     Generator.AddIntegerAtom(k2_tiStyle, ev_saArticleHeader);
     l_Styled:= True;
    end
    else
     Generator.AddIntegerAtom(k2_tiJustification, Ord(l_Justify))
   end
   else
   if l_Justify = ev_itPreformatted then
    l_Styled:= True
   else
    Generator.AddIntegerAtom(k2_tiJustification, Ord(l_Justify));
  end;
  if not l_Styled and (aJustifyChar <> 'V') then
  begin
   try
    Generator.AddIntegerAtom(k2_tiStyle, l_Style); // Стиль по умолчанию
    Generator.AddIntegerAtom(k2_tiLeftIndent, evChar2Inch(aLeftIndent));
    Generator.AddIntegerAtom(k2_tiRightIndent, evChar2Inch(aRightIndent));
    Generator.AddIntegerAtom(k2_tiFirstIndent, evChar2Inch(aFirstIndent));
    Generator.AddIntegerAtom(k2_tiWidth, evChar2Inch(aRightIndent));
   except
    lp_OutError('текста');
   end;
  end; // not l_Styled and (aJustifyChar <> 'V')
  if aText <> nil then
   Generator.AddStringAtom(k2_tiText, aText.AsWStr);
  if aJustifyChar = 'D' then
   AddAlignBySeparator(evChar2Inch(l_Offset)); 
end;

procedure TCustomNSRCReader.CollectSubAttributes(aSub: TddNSRCSub);
var
 l_Type     : Long;
 l_SpecChar : AnsiChar;
begin
 Try2ReadComment(False);
 if Parser.TokenChar = #0 then Exit;

  if Parser.TokenChar = chrStartToken then
   Parser.NextTokenSp;
  while Parser.TokenSymbolIs(kwdCLASS) or Parser.TokenSymbolIs(kwdPREFIX) or Parser.TokenSymbolIs(kwdKIND)
     or Parser.TokenSymbolIs(kwdTYPE) or Parser.TokenSymbolIs(kwdSUBKW)
     or Parser.TokenSymbolIs(kwdCLASS_4X) or Parser.TokenSymbolIs(kwdCONTENTS)
     or Parser.TokenSymbolIs(kwdServiceInfo) or Parser.TokenSymbolIs(kwdBlockData) do
   begin
    if Parser.TokenSymbolIs(kwdBlockData) then
    begin
     // Style=55 Location=Left
     while not (Parser.TokenType in [l3_ttEOL, l3_ttEOF]) do
     begin
      l_SpecChar:= #10;
      Parser.NextTokenSP;
      if AnsiSameText(Parser.TokenString, 'Style') then
      begin
       Parser.NextTokenSP; // пропускаем =
       aSub.Style:= ReadInt;
      end
      else
      if AnsiSameText(Parser.TokenString, 'Location') then
      begin
       Parser.NextTokenSP; // пропускаем =
       Parser.NextTokenSp;
       if AnsiSameText(Parser.TokenString, 'Left') then
        aSub.ViewKind:= ev_bvkLeft
       else
       if AnsiSameText(Parser.TokenString, 'Right') then
        aSub.ViewKind:= ev_bvkRight;
      end;
     end;
    end
    else
    if Parser.TokenSymbolIs(kwdCLASS) then
    begin
     l_SpecChar:= #1;
     l_Type:= k2_tiClasses;
    end
    else
    if Parser.TokenSymbolIs(kwdPREFIX) or Parser.TokenSymbolIs(kwdKIND) then
    begin
     l_Type:= k2_tiPrefix;
     l_SpecChar:= #2;
    end
    else
    if Parser.TokenSymbolIs(kwdTYPE) then
    begin
     l_Type:= k2_tiTypes;
     l_SpecChar:= #3;
    end
    else
    if Parser.TokenSymbolIs(kwdSUBKW) then
    begin
     l_Type:= k2_tiKeywords;
     l_SpecChar:= #4;
    end
    else
    if Parser.TokenSymbolIs(kwdServiceInfo) then
    begin
     l_Type:= k2_tiServiceInfo;
     l_SpecChar:= #5;
    end
    else
    if Parser.TokenSymbolIs(kwdCONTENTS) then
    begin
     TranslateContents;
     l_SpecChar:= #10;
    end
    else
      l_SpecChar:= #0;
    if l_SpecChar = #0 then
      Filer.Readln
    else
    if l_SpecChar <> #10 then
    begin
     ReadText(True);
     try
      // Здесь забабахиваем все во внутренний буфер
      aSub.Generator.StartTag(l_Type);
      try
       aSub.Generator.StartChild(k2_typDictItem);
       try
        f_Text.LTrim;
        aSub.Generator.AddStringAtom(k2_tiName, f_Text.AsWStr);
       finally
        aSub.Generator.Finish;
       end; { DictItem }
      finally
       aSub.Generator.Finish;
      end; { Classes, Prefix, Types }
     finally
      l3Free(f_Text);
     end;
    end;
    if Parser.TokenChar <> chrStartToken then
     Parser.NextTokenSp;

    while Parser.TokenType = l3_ttEOL do
    begin
     if aSub.IsBlock then
     begin
      aSub.Generator.StartChild(k2_typTextPara);
      aSub.Generator.Finish;
     end
     else
      WriteEmptyParagraph(f_Subs);
     Parser.NextTokenSp;
    end;

    Try2ReadComment(False);

    if Parser.TokenChar = chrStartToken then
    begin
      Parser.NextTokenSp;
    end
    else
    begin
     if Parser.TokenString <> '' then
      OutErrorLog(Format('Внимание! Документ #%d, после метки %d > Ожидался "!", а встретился "%s"',
                 [TopicNo, aSub.ID, Parser.TokenString]));
      TokenReaded:= False;
      exit;
    end;
   end; // while
  TokenReaded:= True;
end;

procedure TCustomNSRCReader.TranslateSub;
    { Помимо собственно команды f_Sub необходимо обрабатывать и накапливать
    следующие команды : CLASS, PREFIX, KEYWORD, TYPE }

var
  l_Sub: TddNSRCSub;
  l_SpecChar: AnsiChar;
begin
  {$IFNDEF WithoutCache}
  CheckDocHeader;
  {$ENDIF}
  CheckDateNums;
  l_Sub:= TddNSRCSub.MakeSub(AnsiCodePage);
  try
    //Parser.NextTokenSp;
    l_Sub.ID:= GetInteger;
    l_Sub.Name.Append(Filer.ReadLn);
    l_Sub.Name.Trim;
    l_Sub.Name.CodePage:= AnsiCodePage;
    if f_Subs = nil then
      f_Subs:= TddNSRCSubList.Create;

    if l_Sub.ID > 0 then
     f_Subs.Add(l_Sub)
    else
     OutErrorLog(Format('TOPIC #%d > Неправильный номер !SUB (%d)', [TopicNo, l_Sub.ID]));

    Parser.NextTokenSp;

    if Parser.TokenType = l3_ttEOL then
    begin
      WriteEmptyParagraph(f_Subs);
    {Inc(FEmptyParaCount);}

      Parser.NextTokenSp;
    end
    else
      CollectSubAttributes(l_Sub);
    finally
    l3Free(l_Sub);
  end;
end;

procedure TCustomNSRCReader.ReadText(Convert: Boolean);
begin
 if f_Text = nil then
  f_Text := Tl3String.Create
 else
  f_Text.Clear;
 f_Text.CodePage := CodePage;
 f_Text.Append(Filer.ReadLn);
 if Convert then
  f_Text.CodePage := ANSICodePage;
 f_Text.Trim;
end;

procedure TCustomNSRCReader.TranslateStyle(aIsDecor: Boolean = False);

  procedure lp_WorkWithText(aJustify: AnsiChar; aLeft, aRight, aFirst, aFontHeight: Integer; var aText:
      Tl3String);
  begin
    IsGraphic:= False;
    if (aJustify <> 'P') then
    begin
      if not aText.Empty then
        aText.Append(cc_HardSpace);
      Parser.WhiteSpace:= AllWhiteSpace;
    end
    else
      Parser.WhiteSpace:= PrefWhiteSpace;

    if Parser.TokenType <> l3_ttEOL then
    begin
      aText.JoinWith(Parser.TokenLongString);
      aText.Append(Filer.ReadLn);
    end;

    if (aJustify = 'P') then
     try
       CheckPara(aIsDecor);
       WriteParagraph(aJustify, aLeft, aRight, aFirst, aFontHeight, aText, f_Subs, False, True);
     finally
       FinishCurrentType;
       FreeAndNil(aText);
       aText:= Tl3String.Make(Codepage);
     end;
  end; {WorkWithText}

  procedure lp_ReadStyleParams(var aC: AnsiChar; var aL, aR, aF, aCP, aFontHeight: Integer);
  var
   l_S: AnsiString;
  begin
   Parser.WhiteSpace:= AllWhiteSpace;
    Parser.NextTokenSp;
    l_S:= Parser.TokenString;
    aC:= l_S[1];
    aL:= GetInteger;
    if aC <> '#' then
    begin
     aR:= cDefParaWidth-GetInteger;
     aF:= GetInteger;
    end; // aC <> '#'
    aCP:= CodePage;
    aFontHeight:= Tk2Prop(k2_typTextPara.Prop[k2_tiPrintFontSize]).DefaultValue;
    while not (Parser.TokenType in [l3_ttEOL, l3_ttEOF]) do
    begin
     Parser.NextTokenSp;
     l_S:= Parser.TokenString;
     if AnsiStartsText('H', l_S) then
      aFontHeight:= StrToIntdef(Copy(l_S, 2, maxInt), aFontHeight)
     else
     if AnsiSameText(l_S, 'CP_TatarOEM') then
       aCP:= CP_TatarOEM
      else
       aCP:= CodePage;
    end; // Parser.TokenType <> l3_ttEOL
  end; {lp_ReadStyleParams}

  function lp_WorkupComments(aJustify: AnsiChar; aLeft, aRight, aFirst, aFontHeight: Integer; var aText: Tl3String): Boolean;
  begin
   // Комментарий
   Result:= False;
   if not aText.Empty then
    if aJustify <> 'P' then
    begin
     if aJustify = 'S' then
      WriteSBSPara(aText, f_Subs)
     else
     begin
      CheckPara(aIsDecor);
      try
       WriteParagraph(aJustify, aLeft, aRight, aFirst, aFontHeight, aText, f_Subs, True);
       Result:= True;
      finally
       FinishCurrentType;
      end; // try..finally
     end; // S[1] = 'S'
    end; // S[1] <> 'P'
   TranslateComment;
  end;

  procedure lp_WritePara(aJustify: AnsiChar; aLeft, aRight, aFirst, aFontHeight: Integer; var aText: Tl3String);
  begin
   if aJustify <> 'P' then
   begin
     if aJustify = 'S' then
       WriteSBSPara(aText, f_Subs)
     else
     begin
      CheckPara(aIsDecor);
      try
       WriteParagraph(aJustify, aLeft, aRight, aFirst, aFontHeight, aText, f_Subs, True);
      finally
       FinishCurrentType;
       FreeAndNil(atext);
      end;
     end
   end; // S[1] <> 'P'
  end; // lp_WritePara;
  
var
 St: AnsiString;
 tL, tR, tF, tCP, tFS,
 l_Left, l_Right, l_First, l_CodePage, l_FontHeight: Integer;
 l_Justify, l_tJustify: AnsiChar;
 l_Written: Boolean;
 l_MergeText: Tl3String;
 l_MergePara: Boolean;
 l_Text: Tl3String;
begin { TranslateStyle }
  EnableComment:= True;
  l_Written:= False;
  f_IsBody:= True;
  lp_ReadStyleParams(l_Justify, l_Left, l_Right, l_First, l_CodePage, l_FontHeight);
  begin
    if l_Justify <> 'S' then
     CheckPara(aIsDecor);
    { Проверяем не Side-By-Side ли это. Если нет, то открываем абзац }
    if l_Justify in ['P', 'T'] then
    begin
      Parser.WhiteSpace:= PrefWhiteSpace;
      l_Justify:= 'P';
    end
    else
      Parser.WhiteSpace:= AllWhiteSpace;

    { С данного момента все параметры оформления  закончились, пошел сплошной
      текст }
    l_Text:= Tl3String.Make(l_CodePage);
    repeat
      TokenReaded:= False;
      Parser.WhiteSpace:= Parser.WhiteSpace{$IFDEF NsrPlusNsr} - [#32]{$ENDIF}; {!!! NsrcPlus2Nsr}
      Parser.NextTokenSp;
      if Parser.TokenType = l3_ttEOF then
        break { Как минимум закончился текущий абзац }
      else
      if (Parser.TokenType = l3_ttEOL) then
      begin
        if l_Justify <> 'P' then
        begin
         if (l_Justify = '#') and (l_Text.LTrimLen = 0) then
          Parser.NextTokenSp;
         break
        end
        else
        begin
          WriteEmptyParagraph(f_Subs);
          //Parser.WhiteSpace:= AllWhiteSpace;
          continue;
        end;
      end;

      if Parser.TokenChar = cc_SemiColon then
      begin
       l_Written := lp_WorkupComments(l_Justify, l_Left, l_Right, l_First, l_FontHeight, l_Text);
       FreeAndNil(l_Text);
       l_Text := Tl3String.Make(l_CodePage);       
      end
      else
      if Parser.TokenChar = chrStartToken then
      begin { Выдвигаем предположение, что далее тоже абзац }
       Parser.NextTokenSp;
       if IsValidToken then
       begin
        TokenReaded:= True;
        if Parser.TokenSymbolIs(kwdSTYLE) and (not (l_Justify in ['P', 'T'])) then
        begin
          TokenReaded:= False;

          { необходимо проверить совпадение форматирования в случае
            объединенныых абзацев и, в случае несовпадения, расквитаться
            с накопленным текстом }
          lp_ReadStyleParams(l_tJustify, tL, tR, tF, tCP, tFS);
          {$IFDEF NsrPlusNsr}
          l_MergePara:= False;
          {$ELSE}
          l_MergePara:= ((l_tJustify in ['C', 'R']) and (l_Justify = l_tJustify) and (l_Text.First = ev_NSRCColorSelection) and
                      (tL = l_Left) and (tR = l_Right) and (tF = l_First)) or ((l_Justify = l_tJustify) and (l_Justify = 'S'));
          {$ENDIF}
          if l_tJustify in ['P', 'T'] then
          begin
            l_tJustify:= 'P';
            Parser.WhiteSpace:= PrefWhiteSpace
          end
          else
            Parser.WhiteSpace:= AllWhiteSpace;

          if l_MergePara then
          begin
            { читаем следующую строку на предмет поиска оформления}
            Parser.NextTokenSp;
            if Parser.TokenType <> l3_ttEOL then
            begin
             l_MergeText:= Tl3String.Make(Parser.TokenLongString);
             try
               l_MergeText.Append(Filer.ReadLn);
               if (l_MergeText.Ch[0] <> ev_NSRCColorSelection) and (l_tJustify <> 'S') then
               begin
                 CheckPara(aIsDecor);
                 try
                   WriteParagraph(l_Justify, l_Left, l_Right, l_First, l_FontHeight, l_Text, f_Subs, True);
                 finally
                   FinishCurrentType;
                   FreeAndNil(l_Text);
                 end;
                 l_Text:= Tl3String.Make(tCP);
                 l_Justify:= l_tJustify;
                 l_Left:= tL;
                 l_Right:= tR;
                 l_First:= tF;
                 l_FontHeight:= tFS;
               end
               else
               begin
                if l_Text.First = ev_NSRCColorSelection then
                begin
                 l_Text.Delete(Pred(l_text.Len), 1);
                 l_MergeText.Delete(0, 1)
                end;
                l_Text.Append(cc_SoftEnter);
               end;
               l_Text.JoinWith(l_MergeText);
             finally
               l3Free(l_MergeText);
             end; // MergeText
            end
            else
             l_Text.Append(cc_SoftEnter);
          end
          else
          begin
           if not l_Written then
           begin
            if l_Justify = 'S' then
              WriteSBSPara(l_Text, f_Subs)
            else // S[1] = 'S'
            begin
              CheckPara(aIsDecor);
              try
               WriteParagraph(l_Justify, l_Left, l_Right, l_First, l_FontHeight, l_Text, f_Subs, True);
              finally
               //!!! FreeAndNil(l_Text);
               FinishCurrentType;
              end;
            end; // S[1] <> 'S'
            aIsDecor:= False;
            l3Free(l_Text);
            l_Text:= Tl3String.Make(tCP);
           end; // not l_Written
           l_Justify:= l_tJustify;
           l_Left:= tL;
           l_Right:= tR;
           l_First:= tF;
           l_FontHeight:= tFS;
           l_Written:= False;
          end;

          Continue;
        end
        else
        if Parser.TokenSymbolIs(kwdSTYLE) and (l_Justify = 'P') then
        begin
          Parser.WhiteSpace:= AllWhiteSpace;
          TokenReaded:= False;
          lp_ReadStyleParams(l_tJustify, tL, tR, tF, tCP, tFS);
          l_Text.CodePage:= tCP;
          if l_tJustify in ['P', 'T'] then
          begin
            l_tJustify:= 'P';
            Parser.WhiteSpace:= PrefWhiteSpace
          end
          else
          begin
           Parser.WhiteSpace:= AllWhiteSpace;
           l_Justify:= l_tJustify;
           l_Left:= tL;
           l_Right:= tR;
           l_First:= tF;
           l_FontHeight:= tFS;
          end;
          Parser.NextTokenSp;
          if (PArser.TokenType = l3_ttEOL) then
          begin
            l_Justify:= 'P';
            Parser.WhiteSpace:= PrefWhiteSpace
          end;
          if Parser.TokenChar <> chrStartToken then
            lp_WorkWithText(l_Justify, l_Left, l_Right, l_First, l_FontHeight, l_Text)
          else
          begin
            Parser.NextTokenSp;
            TokenReaded:= True;
            break;
          end;
        end
        else { not STYLE }
        begin
          if (PArser.TokenType = l3_ttEOL) then
          begin
            l_Justify:= 'P';
            Parser.WhiteSpace:= PrefWhiteSpace
          end;
          break;
        end;
       end
       else
        l_Text.Append(chrStartToken);
      end
      else
      begin
        { Далее просто обрабатываем текст }
        lp_WorkWithText(l_Justify, l_Left, l_Right, l_First, l_FontHeight, l_Text);
      end;
    until False;
    if not l_Written then
    begin
     if l_Justify <> 'P' then
     begin
       if l_Justify = 'S' then
         WriteSBSPara(l_Text, f_Subs)
       else
       begin
         CheckPara(aIsDecor);
         WriteParagraph(l_Justify, l_Left, l_Right, l_First, l_FontHeight, l_Text, f_Subs, True);
         FinishCurrentType;
       end
     end // S[1] <> 'P'
     else
     if CurrentType = k2_typTextPara then
      FinishCurrentType;
    end; // not l_Written
    l3Free(l_Text);
  end;
  Parser.WhiteSpace:= AllWhiteSpace;
end; { TranslateStyle }


(*procedure TCustomNSRCReader.HeaderAddStreamAtom(Index: Long; Value: TStream);
begin
  {$IFDEF WithoutCache}
  Generator.AddStreamAtom(Index, Value);
  {$ELSE}
  if f_DocHeaderWritten or FirstStep then
  begin
    {$IFNDEF nsTest}
    if Warning and f_DocHeaderWritten then
     OutErrorLog(Format('TOPIC #%d %s (Stream Atom)', [TopicNo, SWarnHeader]));
    {$ENDIF nsTest}
    Generator.AddStreamAtom(Index, Value)
  end
  else
  begin
    if not f_StrictFormat and not f_DocStarted then
    begin
      Prepare2Load;
      f_DocStarted:= True;
      CurrentType:= k2_idDocument;
    end;
    f_Header.AddStreamAtom(Index, Value);
  end;
  {$ENDIF}
end;*)

procedure TCustomNSRCReader.HeaderAddIntegerAtom(Index: Long; Value: Long);
begin
  {$IFDEF WithoutCache}
  Generator.AddIntegerAtom(Index, Value);
  {$ELSE}
  if f_DocHeaderWritten or FirstStep then
  begin
    {$IFNDEF nsTest}
    if Warning and f_DocHeaderWritten then
     OutErrorLog(Format('TOPIC #%d %s Integer Atom %d = %d',
                  [TopicNo, SWarnHeader, Index, Value]));
    {$ENDIF nsTest}
    Generator.AddIntegerAtom(Index, Value)
  end
  else
  begin
    if not f_StrictFormat and not f_DocStarted then
    begin
      Prepare2Load;
      f_DocStarted:= True;
      CurrentType:= k2_typDocument;
    end;
    f_Header.AddIntegerAtom(Index, Value);
  end;
  {$ENDIF}
end;

procedure TCustomNSRCReader.HeaderAddStringAtom(Index: Long; Value: Tl3String);
begin
  {$IFDEF WithoutCache}
  Generator.AddStringAtom(Index, Value);
  {$ELSE}
  if f_DocHeaderWritten or FirstStep then
  begin
    {$IFNDEF nsTest}
    if Warning and f_DocHeaderWritten then
      OutErrorLog(Format('TOPIC #%d %s String Atom %d = %s',
                [TopicNo, SWarnHeader, Index, Value.AsString]));
    {$ENDIF nsTest}            
    Generator.AddStringAtom(Index, Value.AsWStr);
  end
  else
  begin
    if not f_StrictFormat and not f_DocStarted then
    begin
      Prepare2Load;
      f_DocStarted:= True;
      CurrentType:= k2_typDocument;
    end;

    f_Header.AddStringAtom(Index, Value.AsWStr);
  end;
  {$ENDIF}
end;

procedure TCustomNSRCReader.HeaderAddStringAtom(Index: Long; const Value: AnsiString);
begin
  {$IFDEF WithoutCache}
  Generator.AddStringAtom(Index, Value);
  {$ELSE}
  if f_DocHeaderWritten or FirstStep then
  begin
    {$IFNDEF nsTest}
    if Warning and f_DocHeaderWritten then
     OutErrorLog(Format('TOPIC #%d %s String Atom %d = %s',
                   [TopicNo, SWarnHeader, Index, Value]));
    {$ENDIF nsTest}               
    Generator.AddStringAtom(Index, Value);
  end
  else
  begin
    if not f_StrictFormat and not f_DocStarted then
    begin
      Prepare2Load;
      f_DocStarted:= True;
      CurrentType:= k2_typDocument;
    end;

    f_Header.AddStringAtom(Index, Value);
  end;
  {$ENDIF}
end;

procedure TCustomNSRCReader.HeaderStartChild(TypeID: Tk2Type);
begin
  {$IFDEF WithoutCache}
  Generator.StartChild(TypeID);
  {$ELSE}
  if f_DocHeaderWritten or FirstStep then
  begin
    //if Warning then OutErrorLog(warnHeader);
    Generator.StartChild(TypeID)
  end
  else
  begin

    if not f_StrictFormat and not f_DocStarted then
    begin
      Prepare2Load;
      f_DocStarted:= True;
      CurrentType:= k2_typDocument;
    end;
    f_Header.StartChild(TypeID);
  end;
  {$ENDIF}
end;

procedure TCustomNSRCReader.HeaderStartTag(TagID: Long);
begin
  {$IFDEF WithoutCache}
  Generator.StartTag(TagID);
  {$ELSE}
  if f_DocHeaderWritten or FirstStep then
  begin
    //if Warning then OutErrorLog(warnHeader);
    Generator.StartTag(TagID)
  end
  else
  begin

    if not f_StrictFormat and not f_DocStarted then
    begin
      Prepare2Load;
      f_DocStarted:= True;
      CurrentType:= k2_typDocument;
    end;
    f_Header.StartTag(TagID);
  end;
  {$ENDIF}
end;

procedure TCustomNSRCReader.HeaderFinish;
begin
  {$IFDEF WithoutCache}
  Generator.Finish;
  {$ELSE}
  if f_DocHeaderWritten or FirstStep then
    Generator.Finish
  else
    f_Header.Finish;
  {$ENDIF}
end;

procedure TCustomNSRCReader.TranslateName;
begin
  CollectName(kwdNAME);
end;

procedure TCustomNSRCReader.TranslateSource;
begin
  ReadText(True);
  HeaderStartTag(k2_tiSources);
  try
    HeaderStartChild(k2_typDictItem);
    try
     HeaderAddStringAtom(k2_tiName, f_Text);
    finally
     HeaderFinish;
    end;
  finally
   HeaderFinish;
   l3Free(f_Text);
  end;
end;

procedure TCustomNSRCReader.TranslateType;
begin
 ReadText(True);
 if not f_IsBody then
 begin
  HeaderStartTag(k2_tiTypes);
  try
    HeaderStartChild(k2_typDictItem);
    try
     HeaderAddStringAtom(k2_tiName, f_Text);
    finally
     HeaderFinish;
    end;
  finally
   HeaderFinish;
  end;
 end // if not f_IsBody
 else
 if f_Block <> nil then
 begin
  f_Block.Generator.StartTag(k2_tiTypes);
  try
    f_Block.Generator.StartChild(k2_typDictItem);
    try
     f_Block.Generator.AddStringAtom(k2_tiName, f_Text.AsWStr);
    finally
     f_Block.Generator.Finish;
    end;
  finally
   f_Block.Generator.Finish;
  end;
 end;
 l3Free(f_Text);
end;

procedure TCustomNSRCReader.TranslateBelongs;
var
 tmpS: AnsiString;
 i: Integer;
begin
 ReadText(True);
 try
  HeaderStartTag(k2_tiGroups);
  try
   if SpecialBase then
   begin
    HeaderStartChild(k2_typDictItem);
    try
     HeaderAddStringAtom(k2_tiShortName, 'KSE');
    finally
     HeaderFinish;
    end;
   end;
    tmpS:= f_Text.AsString;
    repeat
      HeaderStartChild(k2_typDictItem);
      try
       i:= Pos('\', tmpS);
       if i = 0 then
         i:= Length(tmpS)+1;
       HeaderAddStringAtom(k2_tiShortName, Copy(tmpS, 1, i-1));
      finally
       HeaderFinish;
      end;
      Delete(tmpS, 1, i);
    until tmpS = '';
  finally
    HeaderFinish;
  end;
 finally
  l3Free(f_Text);
 end;
end;

procedure TCustomNSRCReader.TranslateKeywords;
begin
  ReadText(True);
  HeaderStartTag(k2_tiKeywords);
  try
    HeaderStartChild(k2_typDictItem);
    try
     HeaderAddStringAtom(k2_tiName, f_Text);
    finally
     HeaderFinish;
    end;
  finally
    HeaderFinish;
    l3Free(f_Text);
  end;
end;

procedure TCustomNSRCReader.TranslateWarning;
begin
  HeaderStartTag(k2_tiWarnings);
  try
    HeaderStartChild(k2_typDictItem);
    try
     HeaderAddIntegerAtom(k2_tiHandle, GetInteger);
    finally
     HeaderFinish;
    end;
  finally
    HeaderFinish;
  end;
  Filer.ReadLn;
end;

procedure TCustomNSRCReader.TranslateClassAndSuffix;
begin
 f_Text := Tl3String.Create;
 try
  if Parser.TokenSymbolIs(kwdSUFFIX) then
   f_Text.AsString:= 'Суффиксы\';
  f_Text.CodePage:= cp_OEMLite;
  f_Text.Append(l3Trim(Filer.ReadLn));
  f_Text.CodePage:= AnsiCodePage;
  if not f_IsBody then
  begin
   HeaderStartTag(k2_tiClasses);
   try
     HeaderStartChild(k2_typDictItem);
     try
      f_Text.Trim;
      HeaderAddStringAtom(k2_tiName, f_Text);
     finally
      HeaderFinish;
     end;
   finally
     HeaderFinish;
   end;
  end
  else
  if f_Block <> nil then
  begin
   f_Block.Generator.StartTag(k2_tiClasses);
   try
     f_Block.Generator.StartChild(k2_typDictItem);
     try
      f_Block.Generator.AddStringAtom(k2_tiName, f_Text.AsWStr);
     finally
      f_Block.Generator.Finish;
     end;
   finally
    f_Block.Generator.Finish;
   end;
  end; // if not f_IsBody
 finally
  l3Free(f_Text);
 end; 
end;

procedure TCustomNSRCReader.TranslateDOC;
begin
 if f_UserType = Dt_Types.utNone then
  HeaderAddIntegerAtom(k2_tiUserType, Ord(utDoc));
 Filer.ReadLn;
end;

procedure TCustomNSRCReader.TranslateCalendar;
begin
 HeaderAddIntegerAtom(k2_tiUserType, Ord(utCalendar));
 Filer.ReadLn;
 f_UserType:= utCalendar;
end;

procedure TCustomNSRCReader.TranslateTable;
begin
  // !TABLE [type]
  //          `----  0 (по-умолчанию) - обычная таблица, 1 - SBS
  {$IFNDEF WithoutCache}
  CheckDocHeader;
  {$ENDIF}
  CheckDateNums;
  // Заглушка
  if (f_Block <> nil) then
  begin
   f_Block.MakeName(f_Text);
   f_Block.Name.CodePage:= AnsiCodePage;
   WriteBlock;
   l3Free(f_Block);
  end;


  f_TableType:= GetInteger(0);
  CurrentType:= TableTypes(f_TableType, tpTable);
  Inc(f_TableCount);

  if Parser.TokenType = l3_ttEOL then
   Parser.NextTokenSp
  else
   Filer.ReadLn;
end;

procedure TCustomNSRCReader.TranslatePriceLevel;
begin
 ReadText(False);
 try
  f_Text.Trim;
  f_Text.MakeUpper;
  if f_Text.AsString = prclvl_nFree then
   l3SetMask(f_Status, dstatChargeFree);
 finally
  l3Free(f_Text);
 end;
end;

procedure TCustomNSRCReader.TranslateObjType;
begin
 Filer.ReadLn;
 // Игнорируется при чтении в соответствии с новой концепцией Объектов
end;

procedure TCustomNSRCReader.TranslateObjPath;
begin
 ReadText(False);
 try
  f_ObjPath := f_Text.AsString;
 finally
  l3Free(f_Text);
 end;
end;

procedure TCustomNSRCReader.FlushObjectStream;
var
 l_FileName: AnsiString;
 tmp_Stream: TStream;
begin
 if f_ObjPath = '' then
  Exit;

 try
  if not IsFullPath(f_ObjPath) then
   l_FileName := ConcatDirName(PictureDir, f_ObjPath)
  else
   l_FileName := f_ObjPath;

   if FileExists(l_FileName) then
   try
    tmp_Stream := Tl3FileStream.Create(l_FileName, l3_fmRead);
    try
     if FindStreamFormat(tmp_Stream) <> ioUnknown then
      Generator.StartChild(k2_typBitmapPara)
     else
      Generator.StartChild(k2_typExtDataPara);
     try
      Generator.AddStringAtom(k2_tiExternalPath, f_ObjPath);
      Generator.AddStreamAtom(k2_tiData, tmp_Stream);
      if Assigned(f_OnAddSize) then
       f_OnAddSize(tmp_Stream.Size);
     finally
      Generator.Finish;
     end;
    finally
     l3Free(tmp_Stream);
    end;
   except
    on E: EFOpenError do
     Parser.Str2Log(E.Message);
   end
   else
   begin
    OutErrorLog('Отсутствует файл, указанный в OBJPATH '+l_FileName);
   end;
  finally
   f_ObjPath := '';
  end;
end;

procedure TCustomNSRCReader.TranslateMOJNotReg;
begin
  Filer.ReadLn;
  HeaderStartTag(k2_tiNumAndDates);
  try
    HeaderStartChild(k2_typNumAndDate);
    try
     HeaderAddIntegerAtom(k2_tiType, Ord(dnMU));
    finally
     HeaderFinish;
    end;
  finally
    HeaderFinish;
  end;
end;

procedure TCustomNSRCReader.TranslatePreActive;
var
  tmpS: AnsiString;
begin
 ReadText(True);
 try
  tmpS:= f_Text.AsString;
  if (tmpS <> '') and (tmpS[1] <> '"') then
  try
   AddAlarm(StDateToDemon(DateTimeToStDate(m0dtfStrToDate(tmpS))), '');
   tmpS:= '';
  except
   on E: Exception do
         OutErrorLog(Format(SErrorDate, [TopicNo, '!Alarm', tmpS]));
  end // try..except
  else
  begin
   Delete(tmpS, 1, 1);
   Delete(tmpS, Length(tmpS), 1);
  end;
  AddActiveInterval(maxActiveDate, maxActiveDate, tmpS);
 finally
  l3Free(f_Text);
 end; // try..finally
end;

procedure TCustomNSRCReader.TranslateNorm;
begin
 ReadText(True);
 try
  HeaderStartTag(k2_tiNorm);
  try
    HeaderStartChild(k2_typDictItem);
    try
      f_Text.Trim;
      HeaderAddStringAtom(k2_tiName, f_Text);
    finally
      HeaderFinish;
    end;
  finally
    HeaderFinish;
  end;
 finally
  l3Free(f_Text);
 end;
end;

procedure TCustomNSRCReader.TranslateTerritory;
begin
 ReadText(True);
 try
  HeaderStartTag(k2_tiTerritory);
  try
    HeaderStartChild(k2_typDictItem);
    try
      f_Text.Trim;
      HeaderAddStringAtom(k2_tiName, f_Text);
    finally
      HeaderFinish;
    end;
  finally
    HeaderFinish;
  end;
 finally
  l3Free(f_Text);
 end;
end;

procedure TCustomNSRCReader.TranslatePrefix;
begin
 { TODO -oДудко Дмитрий : Вставить сюда костыль для преобразования оставшихся Prefix }
 ReadText(True);
 try
  if AnsiSameText(f_Text.AsString, 'Формы документов') or AnsiSameText(f_Text.AsString, 'Документы ОАО "Газпром"') then
  begin
   if not f_IsBody then
   begin
    HeaderStartTag(k2_tiPrefix);
    try
      HeaderStartChild(k2_typDictItem);
      try
        f_Text.Trim;
        HeaderAddStringAtom(k2_tiName, f_Text);
      finally
        HeaderFinish;
      end;
    finally
      HeaderFinish;
    end;
   end
   else
   if f_Block <> nil then
   begin
    f_Block.Generator.StartTag(k2_tiPrefix);
    try
      f_Block.Generator.StartChild(k2_typDictItem);
      try
       f_Block.Generator.AddStringAtom(k2_tiName, f_Text.AsWStr);
      finally
       f_Block.Generator.Finish;
      end;
    finally
     f_Block.Generator.Finish;
    end;
   end;
  end; // AnsiSameText(text.AsString, 'Формы документов') or AnsiSameText(Text.AsString, 'Документы ОАО "Газпром"') then
 finally
  FreeAndNil(f_Text);
 end;
end;

procedure TCustomNSRCReader.TranslatePublishedIn;
var
  i,J, k: Integer;
  S, tmpSS: AnsiString;
  D: TStDate;
  Pubs: Tl3StringList;
begin            
 Pubs:= Tl3StringList.Make;
 try
  while Parser.TokenSymbolIs(kwdPUBLISHEDIN) do
  begin
   ReadText(True);
   try
    Pubs.Add(f_Text);
   finally
    l3Free(f_Text);
   end;
   Parser.NextTokenSp;
   if Parser.TokenChar = chrStartToken then
   begin
    TokenReaded:= True;
    Parser.NextTokenSp;
   end;
  end; { while PUBLISHIN }
  HeaderStartTag(k2_tiPublishedIn);
  try
   for j:= 0 to Pred(Pubs.Count) do
   begin
    f_Text := Tl3String(Pubs.Items[j]);
    i := 0;
    S := '';
    while (f_Text.Ch[i] <> '|') and (i < f_Text.Len) do
    begin
     S := S + f_Text.Ch[i];
     Inc(i);
    end; {while}
    if i = f_Text.Len then
    begin
    { Теоретически здесь можно попробовать разобрать старый формат }
     if not StepNumberTwo then
      OutErrorLog(Format(SNSCError_ObsoleteFormat,
                         [TopicNo]));
      Continue;
    end; // i = Text.Len
    HeaderStartChild(k2_typPIRec);
    try
     HeaderStartTag(k2_tiSource);
     try
      if (S[1] = '@') and (Length(S) > 1) then
      begin
       Delete(S, 1, 1);
       HeaderAddBoolAtom(k2_tiPrivate, True);
      end; // (S[1] = '@') and (Length(S) > 1)
      HeaderAddStringAtom(k2_tiName, S);
     finally
      HeaderFinish;
     end; { Source }
     if S = '@' then
     begin
      //  короткий вариант записи - может быть только Number и LinkComment
      // !PUBLISHEDIN @|[Number]|[Comment2]|
      S:= '';
      Inc(i);
      while (f_Text.Ch[i] <> '|') and (i < f_Text.Len) do
      begin
       S:= S + f_Text.Ch[i];
       Inc(i);
      end;{ while }
      if S <> '' then
       HeaderAddStringAtom(k2_tiNumber, S);
      Inc(i);
      f_Text.Delete(0, i);
      if not f_Text.Empty then
       HeaderAddStringAtom(k2_tiLinkComment, f_Text);
     end
     else // Полный формат записи
     // !PUBLISHEDIN этал. класс\этал. класс\..|Date1[-Date2]|[Number]|[Comment1][|Pages[|Comment2]]
     begin
      S := '';
      Inc(i);
      while (f_Text.Ch[i] <> '|') and (i < f_Text.Len) do
      begin
       S := S + f_Text.Ch[i];
       Inc(i);
      end;{ while }
      { Если дата битая (только месяц и год или только год), нужно
        сформировать вторую дату самому }
      if S <> '' then
      begin
       if Pos('-', S) = 0 then
       begin
        { Анализируем на корректность даты }
        if m0IsValidStrDate(S) then
        begin
         D := StDateToDemon(DateTimeToStDate(m0dtfStrToDate((S))));
         HeaderAddIntegerAtom(k2_tiStart, D);
         HeaderAddIntegerAtom(k2_tiFinish, D);
        end
        else
        begin
        { Некорректная дата }
         if Pos('/', S) = 0 then { только год }
         begin
          try
           D := StDateToDemon(DateTimeToStDate(m0dtfStrToDate(('01/01/'+ S))));
           HeaderAddIntegerAtom(k2_tiStart, D);
           D := StDateToDemon(DateTimeToStDate(m0dtfStrToDate(('31/12/'+ S))));
           HeaderAddIntegerAtom(k2_tiFinish, D);
          except
           l3System.Msg2Log(SNSCError_FormattingDate, [S]);
          end; // try..except
         end
         else { год и месяц }
         try
          D := StDateToDemon(DateTimeToStDate(m0dtfStrToDate(('01/'+ S))));
          HeaderAddIntegerAtom(k2_tiStart, D);
          k := DaysInMonth(StrToInt(System.Copy(S, 1, Pos('/', S)-1)),
                           StrToInt(System.Copy(S, Pos('/', S)+1, 4)));
          D := StDateToDemon(DateTimeToStDate(m0dtfStrToDate((IntToStr(k)+'/'+ S))));
          HeaderAddIntegerAtom(k2_tiFinish, D);
         except
          l3System.Msg2Log(SNSCError_FormattingDate, [S]);
         end; // try..except
        end; { test of date }
       end { Одна дата }
       else
       begin{ две даты}
        tmpSS := Copy(S, 1, Pos('-', S) - 1);
        System.Delete(S, 1, Pos('-', S));
        if m0IsValidStrDate(tmpSS) then
        begin
         D := StDateToDemon(DateTimeToStDate(m0dtfStrToDate(tmpSS)));
         HeaderAddIntegerAtom(k2_tiStart, D);
        end; // m0IsValidStrDate(tmpSS)
        if m0IsValidStrDate(S) then
        begin
         D := StDateToDemon(DateTimeToStDate(m0dtfStrToDate(S)));
         HeaderAddIntegerAtom(k2_tiFinish, D);
        end; // m0IsValidStrDate(S)
       end;
      end; // S <> '' 
      { Номер издания }
      S:= '';
      Inc(i);
      while (f_Text.Ch[i] <> '|') and (i < f_Text.Len) do
      begin
       S := S + f_Text.Ch[i];
       Inc(i);
      end;{ while}
      if S <> '' then
       HeaderAddStringAtom(k2_tiNumber, S);
      { Первый комментарий }
      S := '';
      Inc(i);
      while (f_Text.Ch[i] <> '|') and (i < f_Text.Len) do
      begin
       S:= S + f_Text.Ch[i];
       Inc(i);
      end;{ while}
      HeaderAddStringAtom(k2_tiComment, S);
      { Номера страниц }
      S := '';
      Inc(i);
      while (f_Text.Ch[i] <> '|') and (i < f_Text.Len) do
      begin
       S := S + f_Text.Ch[i];
       Inc(i);                          
      end;{ while}
      if S <> '' then
       HeaderAddStringAtom(k2_tiPages, S);
      { Второй комментарий }
      Inc(i);
      f_Text.Delete(0, i);
      if not f_Text.Empty then
       HeaderAddStringAtom(k2_tiLinkComment, f_Text);
     end;
    finally
     HeaderFinish;
    end; { PIRec }
   end;
  finally
   l3Free(Pubs);
   HeaderFinish;
   f_Text := nil;
  end;
 except
 end { publishedin }
end;

procedure TCustomNSRCReader.TranslateCheck;
var
 tmpS, tmpSS: AnsiString;
 l_Date: Longint;
 l_Source: Integer;
 l_User: TUserID;
 l_Type : Integer;
 len: Integer;
begin
 {!CHECK <date> <> dt_Dict

 }
 ReadText(True);
 try
  tmpS := f_Text.AsString; {<-  Здесь лежит много всякой информации }
  Len := 0;
  tmpss := Copy(tmpS, 1, Pos(' ', tmpS)-1);
  try
   l_Date := StDateToDemon(DateTimeToStDate(m0dtfStrToDate(tmpSs)));
  except
   on E: Exception do
   begin
    OutErrorLog(Format('TOPIC# %d > Неправильная дата CHECK %s', [TopicNo, tmpSS]));
    exit;
   end; // on E
  end; // try..finally
  System.Delete(tmpS, 1, Pos(' ', tmpS));
  Inc(Len, Length(tmpSs)+1);
  tmpss := Copy(tmpS, 1, Pos(' ', tmpS) - 1);
  System.Delete(tmpS, 1, Pos(' ', tmpS));
  Inc(Len, Length(tmpSs)+1);
  try
   l_Source := StrToInt(tmpSS)
  except
   on E: Exception do
   begin
    OutErrorLog(Format('TOPIC# %d > Неправильная тип источника CHECK %s', [TopicNo, tmpSS]));
    Exit;
   end;
  end;
  tmpss := Copy(tmpS, 1, Pos(' ', tmpS) - 1);
  System.Delete(tmpS, 1, Pos(' ', tmpS));
  Inc(Len, Length(tmpSs)+1);
  try
   l_Type := StrToInt(tmpSS);
  except
   on E: Exception do
   begin
    OutErrorLog(Format('TOPIC# %d > Неправильный тип CHECK %s', [TopicNo, tmpSS]));
    Exit;
   end;
  end;
  if Pos(' ', tmpS) = 0 then
   tmpSS := tmpS
  else
  begin
   tmpss := Copy(tmpS, 1, Pos(' ', tmpS) - 1);
   System.Delete(tmpS, 1, Pos(' ', tmpS));
  end;
  Inc(Len, Length(tmpSs) + 1);
  try
   l_User := strToInt64(tmpSS);
  except
   on E: Exception do
   begin
    OutErrorLog(Format('TOPIC# %d > Неправильный пользователь CHECK %s', [TopicNo, tmpSS]));
    Exit;
   end;
  end;

  HeaderStartTag(k2_tiChecks);
  try
   HeaderStartChild(k2_typCheck);
   try
    HeaderAddIntegerAtom(k2_tiStart, l_Date);
    HeaderAddIntegerAtom(k2_tiSource, l_Source);
    HeaderAddIntegerAtom(k2_tiType, l_Type);
    HeaderStartTag(k2_tiUser);
    try
     HeaderAddIntegerAtom(k2_tiHandle, Integer(l_User));
    finally
     HeaderFinish;
    end;
    f_Text.Delete(0, Len);
    if not f_Text.Empty then
     HeaderAddStringAtom(k2_tiComment, f_Text);
   finally
    HeaderFinish;
   end;
  finally
   HeaderFinish;
  end;
 finally
  l3Free(f_Text);
 end;
end;

procedure TCustomNSRCReader.TranslateStage;
var
  tmpS, tmpSS, StartDate: AnsiString;
  NumStage, IDUser: Long;
  DemonStartDate, DemonFinishDate: Long;
  l_pos: Integer;
begin
 NumStage:= GetInteger;
 IDUser:= GetInteger;

 ReadText(True);
 try
  tmpS := f_Text.AsString;
 finally
  l3Free(f_Text);
 end;

 l_pos := Pos(' ', tmpS);
 if l_pos = 0 then
  l_pos := Length(tmpS);
 tmpSS := Copy(tmpS, 1, l_pos);
 Delete(tmpS, 1, l_pos);

 StartDate := tmpSS;
 try
  DemonStartDate := StDateToDemon(DateTimeToStDate(m0dtfStrToDate((StartDate))));
 except
  on E: EConvertError do
  begin
   OutErrorLog(Format('TOPIC# %d > Неправильная дата начала STAGE %s', [TopicNo, tmpSS]));
   Exit;
  end;
 end; // try..except

 if tmpS <> '' then
 begin
  tmpSS:= Copy(tmpS, Pos(' ', tmpS)+1, 255);
  if tmpSS <> '' then
  try
   DemonFinishDate:= StDateToDemon(DateTimeToStDate(m0dtfStrToDate((tmpSS))));
  except
   on E: EConvertError do
   begin
    OutErrorLog(Format('TOPIC# %d > Неправильная дата окончания STAGE %s',
                [TopicNo, tmpSS]));
    Exit;
   end; // on E: EConvertError
  end // try..except
  else
  if IDUSer = 1 then
  try
   DemonFinishDate:= StDateToDemon(DateTimeToStDate(m0dtfStrToDate((StartDate))));
  except
   on E: Exception do
   begin
    OutErrorLog(Format('TOPIC# %d > Неправильная дата окончания STAGE %s',
                [TopicNo, tmpSS]));
    Exit;
  end; // on E: Exception
 end; // try..except
 end // tmpS <> ''
 else
  DemonFinishDate := 1;

 HeaderStartTag(k2_tiStages);
 try
  HeaderStartChild(k2_typStage);
  try
   HeaderAddIntegerAtom(k2_tiType, NumStage);
   HeaderStartTag(k2_tiUser);
   try
    HeaderAddIntegerAtom(k2_tiHandle, IDUser);
   finally
    HeaderFinish;
   end; // try..finally
   HeaderAddIntegerAtom(k2_tiStart,  DemonStartDate);
   if DemonFinishDate > 1 then
    HeaderAddIntegerAtom(k2_tiFinish, DemonFinishDate);
  finally
   HeaderFinish;
  end; // try..finally
 finally
  HeaderFinish;
 end; // try..finally
 if (NumStage = stageIncluded) and (DemonFinishDate > 1) then
 begin
  f_NeedVIncluded := True;
  f_StageIncludedDate := DemonFinishDate;
 end; // (NumStage = stageIncluded) and (DemonFinishDate > 1)
end;

procedure TCustomNSRCReader.TranslateNoActive;
var
 tmpS: AnsiString;
 lDate: Longint;
begin
 ReadText(True);
 try
  tmpS:= f_Text.AsString;
  try
   if tmpS <> '' then
    lDate := Pred(StDateToDemon(DateTimeToStDate(m0dtfStrToDate(tmpS))))
   else
    lDate := minActiveDate;
   AddActiveInterval(minActiveDate, lDate, '');
  except
   on E: Exception do
    OutErrorLog(Format(SErrorDate, [TopicNo, 'NOACTIVE', tmpS]));
  end; //try..except
 finally
  l3Free(f_Text);
 end; // try..fibally
end;

procedure TCustomNSRCReader.TranslateRel;
begin
 f_IsRel:= True;
 HeaderAddIntegerAtom(k2_tiType, Ord(dtRelText));
 Filer.ReadLn;
end;

procedure TCustomNSRCReader.TranslateSortDate;
begin
 HeaderAddIntegerAtom(k2_tiSortDate, ReadDateInt('SortDate'));
end;

procedure TCustomNSRCReader.TranslatePriority;
begin
 HeaderAddIntegerAtom(k2_tiPriority, GetInteger);
 Filer.ReadLn;
end;

procedure TCustomNSRCReader.WriteBlock;
var
  J: Integer;
  T: Tl3String;
begin
  Generator.StartChild(k2_typBlock);
  try
    Generator.AddIntegerAtom(k2_tiHandle, f_Block.ID);
    if not f_Block.Name.Empty then
    begin
      if f_Block.LegalName then
        Generator.AddStringAtom(k2_tiShortName, f_Block.Name.AsWStr)
      else
        Generator.AddStringAtom(k2_tiName, f_Block.Name.AsWStr)
    end
    else
    begin
      f_Block.Name.AsString:= Format('Блок №%d', [f_Block.ID]);
      Generator.AddStringAtom(k2_tiName, f_Block.Name.AsWStr)
    end;

    if f_Block.Style <> -1 then
     Generator.AddIntegerAtom(k2_tiStyle, -f_Block.Style);

    if f_Block.ViewKind <> ev_bvkNone then
     Generator.AddIntegerAtom(k2_tiViewKind, Ord(f_Block.ViewKind));

    if f_Block.Generator.StreamOpened then
    begin
     f_Block.Generator.Finish;
     if (Tk2DocumentBuffer(f_Block.Generator).Root <> nil) AND
        Tk2DocumentBuffer(f_Block.Generator).Root.IsValid then
     begin
      f_Block.Generator.Finish;
      Tk2DocumentBuffer(f_Block.Generator).Root.WriteTag(Generator, l3_spfAll, [k2_tiSubs]);
     end;
     Tk2DocumentBuffer(f_Block.Generator).Root:= nil;
    end;
  finally
    l3Free(f_Block);
  end;
end;

procedure TCustomNSRCReader.TranslateBlockEnd;
begin
 if f_Block <> nil then WriteBlock;

 ReadText(True);
 l3Free(f_Text);
 if BlockCount > 0 then
 begin
   Generator.Finish;
  Dec(BlockCount);
  BlockNo:= -1;
 end;
end;

procedure TCustomNSRCReader.TranslateBlock;
var
  S: AnsiString;
  i: Integer;
begin
 if (CurrentType = k2_typEmpty) and not StrictFormat then
  CurrentType:= k2_typDocument;

  {$IFNDEF WithoutCache}
  CheckDocHeader;
  {$ENDIF}
  CheckDateNums;
  if f_Block <> nil then
    WriteBlock;

  f_Block:= TddNSRCSub.MakeBlock(AnsiCodePage);

  Inc(BlockCount);
  ReadText(True);
  try
   if not f_Text.Empty then
   begin
    f_Text.DeleteDoubleSpace;
    S := '';
    i := 0;
    while (f_Text.Ch[i] <> ' ') and (i < f_Text.Len) do
    begin
     S := S + f_Text.Ch[i];
     Inc(i);
    end;
    try
     BlockNo:= StrToInt(S);
     f_Block.ID:= BlockNo;
    except
      on E: Exception do
         OutErrorLog(Format(SNSCError_WrongBlockNumber,
         [TopicNo, S]));
    end;
    f_Text.Delete(0, i+1);
    f_Block.Name.JoinWith(f_Text);
   end;
  finally
   l3Free(f_Text);
  end;
  Parser.NextTokenSp;
  if Parser.TokenType = l3_ttEOL then
   WriteBlock
  else
   CollectSubAttributes(f_Block);
end;

procedure TCustomNSRCReader.TranslateRelated;
var
  l_RelHandle: Longint;
begin
 l_RelHandle:= GetInteger;
 if l_RelHandle <> 0 then
  if l_RelHandle <> TopicNo then
   HeaderAddIntegerAtom(k2_tiRelExternalHandle, l_RelHandle)
  else
   OutErrorLog(Format('TOPIC #%d: в качестве справки ссылается на себя, как на справку', [TopicNo]))
 else
  OutErrorLog(Format('TOPIC #%d: Отсутствие номера справки', [TopicNo]));
 Filer.ReadLn;
end;

procedure TCustomNSRCReader.TranslateVLControl;
var
  tmpS: AnsiString;
begin
 HeaderStartTag(k2_tiLogRecords);
 try
  HeaderStartChild(k2_typLogRecord);
  try
   HeaderAddIntegerAtom(k2_tiType, Ord(acLControl));
   ReadText(True);
   tmpS := f_Text.AsString;
   try
    HeaderAddIntegerAtom(k2_tiStart,
                         StDateToDemon(DateTimeToStDate(m0dtfStrToDate({NormalizeDate}(tmpS))))); { date }
   except
    on E: Exception do
     OutErrorLog(Format('TOPIC# %d > Неправильная дата VLCONTROL %s', [TopicNo, tmpS]));
   end;
  finally
   HeaderFinish;
   l3Free(f_Text);
  end;
 finally
  HeaderFinish;
 end;
end;

procedure TCustomNSRCReader.TranslateVAnonced;
var
  tmpS: AnsiString;
begin
 HeaderStartTag(k2_tiLogRecords);
 try
  HeaderStartChild(k2_typLogRecord);
  try
   HeaderAddIntegerAtom(k2_tiType, Ord(acAnonced));
   ReadText(True);
   tmpS:= f_Text.AsString;
   try
    HeaderAddIntegerAtom(k2_tiStart,
                         StDateToDemon(DateTimeToStDate(m0dtfStrToDate(tmpS)))); { date }
   except
    on E: Exception do
     OutErrorLog(Format('TOPIC# %d > Неправильная дата VANONCED %s', [TopicNo, tmpS]));
   end;
  finally
   HeaderFinish;
   l3Free(f_Text);
  end;
 finally
  HeaderFinish;
 end;
end;

procedure TCustomNSRCReader.TranslateVAbolished;
var
  tmpS: AnsiString;
begin
  HeaderStartTag(k2_tiLogRecords);
  try
    HeaderStartChild(k2_typLogRecord);
    try
      HeaderAddIntegerAtom(k2_tiType, Ord(acAbolished));
      ReadText(True);
      tmpS := f_Text.AsString;
      try
        HeaderAddIntegerAtom(k2_tiStart,
                               StDateToDemon(DateTimeToStDate(m0dtfStrToDate({NormalizeDate}(tmpS)))));
      except
        on E: Exception do
           OutErrorLog(Format('TOPIC# %d > Неправильная дата VABOLISHED %s',
           [TopicNo, tmpS]));
      end;
    finally
     HeaderFinish;
     l3Free(f_Text);
    end;
  finally
    HeaderFinish;
  end;
end;

procedure TCustomNSRCReader.TranslateVChanged;
var
  tmpS: AnsiString;
begin
  HeaderStartTag(k2_tiLogRecords);
  try
    HeaderStartChild(k2_typLogRecord);
    try
      HeaderAddIntegerAtom(k2_tiType, Ord(acChanged));
      ReadText(True);
      tmpS := f_Text.AsString;
      try
        HeaderAddIntegerAtom(k2_tiStart,
                               StDateToDemon(DateTimeToStDate(m0dtfStrToDate({NormalizeDate}(tmpS)))));
      except
                 on E: Exception do
                    OutErrorLog(Format('TOPIC# %d > Неправильная дата VCHANGED %s',
                    [TopicNo, tmpS]));
      end;
    finally
     HeaderFinish;
     l3Free(f_Text);
    end;
  finally
    HeaderFinish;
  end;
end;

procedure TCustomNSRCReader.TranslateVIncluded;
var
 tmpS: AnsiString;
begin
 HeaderStartTag(k2_tiLogRecords);
 try
  HeaderStartChild(k2_typLogRecord);
  try
   HeaderAddIntegerAtom(k2_tiType, Ord(acIncluded));
   ReadText(True);
   { Text содержит строковое представление даты }
   tmpS := f_Text.AsString;
   l3Free(f_Text);
   try
    HeaderAddIntegerAtom(k2_tiStart,
                         StDateToDemon(DateTimeToStDate(m0dtfStrToDate(tmpS))));
   except
    on E: Exception do
     OutErrorLog(Format('TOPIC# %d > Неправильная дата VINCLUDED %s',
                        [TopicNo, tmpS]));
   end;
  finally
   HeaderFinish;
  end;
 finally
  HeaderFinish;
 end;
end;

procedure TCustomNSRCReader.TranslateCode;
begin
  ReadText(True);
  try
   DN_Number[dnPublish]:= f_Text;
  finally
   l3Free(f_Text);
  end;
end;

procedure TCustomNSRCReader.TranslateAddCode;
begin
  ReadText(True);
  try
   DN_Number[dnAddNum]:= f_Text;
  finally
   l3Free(f_Text);
  end;
end;

procedure TCustomNSRCReader.TranslateRCode;
begin
  ReadText(True);
  try
    DN_Number[dnMU] := f_Text;
  finally
    l3Free(f_Text);
  end;
end;

procedure TCustomNSRCReader.TranslateGDCode;
begin
  ReadText(True);
  try
    DN_Number[dnGD] := f_Text;
  finally
    l3Free(f_Text);
  end;
end;

procedure TCustomNSRCReader.TranslateSFCode;
begin
  ReadText(True);
  try
    DN_Number[dnSF]:= f_Text;
  finally
    l3Free(f_Text);
  end;
end;

procedure TCustomNSRCReader.TranslateSFDate;
var
  tmpS: AnsiString;
begin
 ReadText(True);
 tmpS := f_Text.AsString;
 l3Free(f_Text);
 try
  Dn_Date[dnSF]:= StDateToDemon(DateTimeToStDate(m0DTFStrToDate(tmpS)))
 except
  on E: Exception do
    OutErrorLog(Format('TOPIC# %d > Неправильная дата SFDATE %s',
                    [TopicNo, tmpS]));
 end;
end;

procedure TCustomNSRCReader.TranslateChDate;
var
 lDate : Longint;
 lRefAddr : TRefAddress;
begin
 lDate := ReadDateInt('ChDate');
 lRefAddr := ReadAddress;

 if (lDate = nsrcBadDate) then Exit;

 Warning:= False;
 if not f_DateNumsWritten then
 begin
  HeaderStartTag(k2_tiNumAndDates);
  try
   HeaderStartChild(k2_typNumAndDate);
   try
    HeaderAddIntegerAtom(k2_tiType, ord(dnChangerDate));
    HeaderAddIntegerAtom(k2_tiStart, lDate);


    if lRefAddr.rDocID > 0 then
    begin
     HeaderStartTag(k2_tiLinkAddress);
     try
      HeaderAddIntegerAtom(k2_tiDocID, lRefAddr.rDocID);
     {$ifDef DBVer134}
      if lRefAddr.rSubID > 0 then
       HeaderAddIntegerAtom(k2_tiSubID, lRefAddr.rSubID);
     {$endif}
     finally
      HeaderFinish;
     end;
    end;
   finally
    HeaderFinish;
   end;
  finally
   HeaderFinish;
  end;
  Warning:= True;
 end;
end;

procedure TCustomNSRCReader.TranslateGDDate;
begin
 Dn_Date[dnGD]:= ReadDateInt('GdDate');
 Filer.ReadLn;
end;

procedure TCustomNSRCReader.TranslateRDate;
begin
  Dn_Date[dnMU]:= ReadDateInt('RDate');
  Filer.ReadLn;
end;

procedure TCustomNSRCReader.TranslateDate;
begin
  Dn_Date[dnPublish]:= ReadDateInt('Date');
  Filer.ReadLn;
end;

procedure TCustomNSRCReader.TranslateUserInfo;
begin
 f_UserType := utUserInfo;
  HeaderAddIntegerAtom(k2_tiUserType, Ord(utUserInfo));
  Filer.ReadLn;
end;

procedure TCustomNSRCReader.TranslateBusiness;
begin
 f_UserType := utBusiness;
  HeaderAddIntegerAtom(k2_tiUserType, Ord(utBusiness));
  Filer.ReadLn;
end;

procedure TCustomNSRCReader.TranslateRevision;
begin
  Filer.ReadLn;
end;

procedure TCustomNSRCReader.TranslateNoDoc;
begin
 if f_UserType = Dt_Types.utNone then
  HeaderAddIntegerAtom(k2_tiUserType, Ord(utNoDoc));
 Filer.ReadLn;
end;

procedure TCustomNSRCReader.TranslateComment;
var
 l_IsPara: Boolean;
begin
 ReadText(True);
 try
  f_Text.DeleteDoubleSpace;

  {$IFDEF AllComments}
    if f_DocHeaderWritten then
     if (not f_Text.Empty)
       and (System.Pos(UpperCase(SDeadComment), UpperCase(f_Text.AsString)) <> 1)
       and (System.Pos(UpperCase(SDeadComment2), UpperCase(f_Text.AsString)) <> 1)
       and (System.Pos(UpperCase(SDeadComment3), UpperCase(f_Text.AsString)) <> 1)
       and (f_Text.First <> chrStartToken)
       and (f_Text.First <> '%') then
    begin
     if CurrentType = k2_typTextPara then
     begin
      l_IsPara:= True;
      FinishCurrentType;
     end
     else
      l_isPara:= False;
     if (f_TableCount = 0) or (f_CellCount > 0) then
     begin
      CheckPara;
      try
       Generator.AddIntegerAtom(k2_tiStyle, ev_saTechComment);
       Generator.AddStringAtom(k2_tiText, f_Text.AsWStr);
      finally
       FinishCurrentType;
      end;
     end;
     if l_IsPara then
      CurrentType:= k2_typTextPara;
    end;

    if not f_Comment.Empty then
      f_Comment.Append(cc_SoftEnter);
    f_Comment.JoinWith(f_Text);
  {$ELSE}
  try
   HeaderAddStringAtom(k2_tiComment, f_Text);
  finally
   EnableComment:= False;
  end;
  {$ENDIF}
 finally
  FreeAndNil(f_Text);
 end;
end;

procedure TCustomNSRCReader.TranslateMain;
begin
  {$IFDEF AccGroups}
  f_AccGroups.Clear;
  f_AccGroups.Append(l3Trim(Filer.Readln));
  {$ENDIF}
end;

procedure TCustomNSRCReader.TranslateRefDoc;
begin
 f_UserType := utWEBReference;
 HeaderAddIntegerAtom(k2_tiUserType, Ord(utWEBReference));
 Filer.Readln;
end;

procedure TCustomNSRCReader.TranslateDivision;
var
  l_Orientation: Integer;
  l_Height: Longint;
  l_Width : Longint;
  l_Index : TevdPaperSize;
begin
 {$IFNDEF WithoutCache}
 CheckDocHeader;
 {$ENDIF}
 CheckDateNums;
  ReadText(True);
  try
    if f_Text.Empty then
    begin { Разрыв страницы }
      Generator.StartChild(k2_typPageBreak);
      Generator.Finish;
    end
    else
    begin { Разрыв раздела }
      //Анализируем параметры команды
      l_Orientation:= -1;
      l_Height:= -1;
      l_Width:= -1;

      if f_Text.Ch[0] = 'P' then
        l_Orientation:=  Ord(ev_poPortrait)
      else
      if f_Text.Ch[0] = 'L' then
        l_Orientation:= Ord(ev_poLandscape)
      else
        OutErrorLog(Format('TOPIC# %d > Неправильная ориентация страницы %s', [TopicNo, f_Text.Ch[0]]));
      f_Text.Delete(0, 2);

      if not f_Text.Empty then
      begin
        if f_Text.Ch[0] = 'A' then
        begin { Расшифровка стандартных размеров }

         case f_Text.Ch[1] of
           '0': l_Index:= evd_psA0;  // 84   x 118.8
           '1': l_Index:= evd_psA1;  // 59.4 x 84
           '2': l_Index:= evd_psA2;  // 42   x 59.4
           '3': l_Index:= evd_psA3;  // 29.7 x 42
           '4': l_Index:= evd_psA4;  // 21   x 29.7
           '5': l_Index:= evd_psA5;  // 14.8 x 21
         end;
         try
           if l_Index <> evd_psA4 then
           begin
             l_Width:= l3Cm2Inch(evPageSizes[l_Index].X);
             l_Height:= l3Cm2Inch(evPageSizes[l_Index].Y);
           end;
         except
           OutErrorLog(Format('TOPIC# %d > Неправильный формат бумаги %s', [TopicNo, f_Text.AsString]));
         end;
        end
        else
        if f_Text.Ch[0] = '"' then
        begin { Расшифровка нестандартных размеров }
        end
        else
          OutErrorLog(Format('TOPIC# %d > Неправильный размер бумаги %s', [TopicNo, f_Text.AsString]));
      end;

      if (l_Orientation <> -1) then
      begin
        Generator.StartChild(k2_typSectionBreak);
        try
          Generator.StartTag(k2_tiParas);
          try
            Generator.AddIntegerAtom(k2_tiOrientation, l_Orientation);

            if l_Width <> -1 then
            begin
              Generator.AddIntegerAtom(k2_tiHeight, l_Height);
              Generator.AddIntegerAtom(k2_tiWidth, l_Width);
            end;
          finally
            Generator.Finish;
          end;
        finally
          Generator.Finish;
        end;
      end;
    end;
  finally
    l3Free(f_Text);
  end;
end;

procedure TCustomNSRCReader.TranslateVerLink;
var
 l_DocID: Long;
begin
 { !VERLINK DocID }
 l_DocID:= GetInteger;
 Filer.Readln;
 HeaderAddIntegerAtom(k2_tiExternalVerLink, l_DocID);
end;

procedure TCustomNSRCReader.Prepare2Load;
var
 l: TevdLanguage;
begin
{ TODO -oДудко Дмитрий -cРазвитие : Нужно предусмотреть повторное использование объектов вместо их пересоздания }
//  FEmptyParaCount:= 0;
  BlockCount:= 0;
  EnableComment:= False;
  NeedBlockName:= False;
  f_SBSWrite:= False;
  f_DOCStarted:= False;
  fTypes.Clear;
  f_IsBody:= False;
  f_IsRel:= False;
  f_IsCalendar:= False;
  f_NeedVIncluded:= False;
  f_Status:= 0;
  for l:= Low(TevdLanguage) to High(TevdLanguage) do
   f_Termins[l].Clear;
  f_IsDictEntry:= False;
  {$IFNDEF WithoutCache}
  f_Header.Root:= nil;
  f_Header.Start;
  {$ENDIF}
  f_DocHeaderWritten:= False;
  f_DateNumsWritten:= False;
end;

procedure TCustomNSRCReader.Read;
(*var
  S: AnsiString;*)
begin { read }
 Filer.CodePage:= f_CodePage;
 f_AbortLoading:= False;
 StopLoading:= False;
 Warning:= True;
 f_EmptyParagraph:= 0;
 Parser.WhiteSpace:= AllWhiteSpace;
 if f_PictureDir = '' then
  f_PictureDir:= f_WorkDir;
 f_DocStarted:= False;
 try
  TokenReaded:= False;
  Parser.NextTokenSp;
  while (not Filer.EOF) and (not f_AbortLoading) do
  begin
   if StopLoading then
     break;
   WorkupToken;
  end; { while Filer.EOF }

  CheckDocumentEnd;
  FinalizeDocument;
 except
  l3Free(f_Text);
  f_AbortLoading:= True;
  raise;
 end;
end;

procedure TCustomNSRCReader.CheckDateNums;
var
  i: TDNType;
begin
  if not f_DateNumsWritten and (f_DocHeaderWritten) then
  try
    for i:= Low(TDNType) to High(TDNType) do
      WriteDateNum(i);
  finally
    f_DateNumsWritten:= True;
  end;
end;

{$IFNDEF WithoutCache}
procedure TCustomNSRCReader.CheckDocHeader;
var
  l_Status: Integer;
 l_S: ShortString;
 l_Rel, l_NeedActiveInterval: Boolean;
 l_Min, l_Max: Longint;
 l: TevdLanguage;

 function _MakeDate(aDate: Longint): ShortString;
 var
  D, M, Y: Integer;
 begin
  if aDate = minActiveDate then
   Result:= '...'
  else
  if aDate = maxActiveDate then
   Result:= '...'
  else
  begin
   stDateToDMY(aDate, D, M, Y);
   Result:= Format('%2d/%2d/%d', [D, M, Y]);
   while Pos(' ', Result) <> 0 do
    Result[Pos(' ', Result)]:= '0';
  end;
 end;

 function AICheck(Data: Tl3Variant; Index: Long): Boolean;
 var
  SD1, SD2, FD1, FD2: ShortString;
 begin
  if  not (Data.Attr[k2_tiType].IsValid and (Data.IntA[k2_tiType] > 0)) then
  begin
   if (Data.IntA[k2_tiStart] < l_Max) then
   begin
    SD1:= _MakeDate(l_Min);
    FD1:= _MakeDate(l_Max);
    SD2:= _MakeDate(Data.IntA[k2_tiStart]);
    FD2:= _MakeDate(Data.IntA[k2_tiFinish]);
    OutErrorLog(Format('TOPIC #%d:Пересекаются диапазоны дат (!Active, !NoActive или !PreActive) "%s-%s" и "%s-%s"',
                       [TopicNo, SD1, FD1, SD2, FD2]));
   end;
   l_Min:= Data.IntA[k2_tiStart];
   l_Max:= Data.IntA[k2_tiFinish];
  end // not (Data._rAtom(k2_tiType).IsValid and (Data._rAtom(k2_tiType).AsLong > 0))
  else
  if Data.Attr[k2_tiType].IsValid then
   l_NeedActiveInterval:= True;
  Result:= True;
 end;

 procedure OutLinkedDocs;
 var
  I: Integer;
 begin
  Generator.StartTag(k2_tiLinkedDocuments);
  try
   for I := 0 to Pred(f_LinkedDocs.Count) do
   begin
    Generator.StartChild(k2_typAddress);
    try
     with f_LinkedDocs.ItemSlot(I)^ do
     begin
      Generator.AddIntegerAtom(k2_tiType, rLinkType);
      Generator.AddIntegerAtom(k2_tiDocID, rLinkedDocID);
     end;
    finally
     Generator.Finish;
    end;
   end;
  finally
   Generator.Finish;
  end;
 end;
var
 i: Integer;
begin
 if f_DocStarted and not f_DocHeaderWritten then
 try
  if f_Header.StreamOpened then
  begin
   f_Header.Finish;
   if (f_Header.Root <> nil) AND f_Header.Root.IsValid then
   begin
    f_Header.Finish;
    l_Rel:= False;
    if not NotFilterGroups and (not f_Header.Root.Attr[k2_tiType].IsNull) and
       (f_Header.Root.IntA[k2_tiType] = ord(dtRelText)) then
    begin
     l_Rel:= True;
     if (not f_Header.Root.Attr[k2_tiGroups].IsNull) then
      f_Header.Root.AttrW[k2_tiGroups, nil] := nil;
    end;
    if f_IsDictEntry then
    begin
     if not f_Header.Root.Attr[k2_tiUserType].IsNull then
      f_Header.Root.AttrW[k2_tiUserType, nil] := nil;
     if not f_Header.Root.Attr[k2_tiName].IsNull then
      f_Header.Root.AttrW[k2_tiName, nil] := nil;
     if f_Header.Root.Attr[k2_tiAccGroups].IsNull then
      f_AccGroups.AsString:= 'EXPDICT';
    end;
    { TODO -oNarry -cРазвитие : Убрать отсюда процедуру добавления и проверки интервалов действия }
    // Проверить ActiveIntervals на пересечения

    if not f_Header.Root.Attr[k2_tiActiveIntervals].IsNull then
    begin
     l_NeedActiveInterval:= False;
     l_Min:= maxActiveDate;
     l_Max:= minActiveDate;
     f_Header.Root.Attr[k2_tiActiveIntervals].IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@AICheck));
     l_NeedActiveInterval:= l_NeedActiveInterval and (f_Header.Root.Attr[k2_tiActiveIntervals].ChildrenCount = 1);
    end
    else
     l_NeedActiveInterval:= True;
    if f_IsDictEntry then
     Generator.StartChild(k2_typDictEntry)
    else
     Generator.StartChild(f_Header.Root.TagType);
    f_Header.Root.WriteTag(Generator, l3_spfAll, [k2_tiSubs]);
    if f_IsDictEntry then
    begin
     Generator.AddStringAtom(k2_tiName, f_Termins[evd_lgRussian].AsWStr);
     Generator.AddIntegerAtom(k2_tiType, Ord(dtDictEntry));
     Generator.StartTag(k2_tiShortName);
     try
      for l:= Low(TevdLanguage) to High(TevdLanguage) do
      begin
       Generator.StartChild(k2_typString);
       try
        Generator.AddStringAtom(k2_tiValue, f_Termins[l].AsWStr);
       finally
        Generator.Finish;
       end; // try..finally
      end;
     finally
      Generator.Finish;
     end;
    end;
   end;{f_Header.Root.IsValid}
  end;{f_Header.StreamOpened}

  if l_NeedActiveInterval and not f_Header.Root.IsKindOf(k2_typAnnotopic) then
  begin
   Generator.StartTag(k2_tiActiveIntervals);
   try
    Generator.StartChild(k2_typActiveInterval);
    try
     Generator.AddIntegerAtom(k2_tiStart, minActiveDate);
     Generator.AddIntegerAtom(k2_tiFinish, maxActiveDate);
    finally
     Generator.Finish;
    end;
   finally
    Generator.Finish;
   end;

  end;

  if f_NeedVIncluded and not f_Header.Root.Attr[k2_tiUserType].IsNull and
     (f_Header.Root.IntA[k2_tiUserType] = ord(utNoDoc))then
  begin
   Generator.StartTag(k2_tiLogRecords);
   try
    Generator.StartChild(k2_typLogRecord);
    try
     Generator.AddIntegerAtom(k2_tiType, Ord(acIncluded));
     Generator.AddIntegerAtom(k2_tiStart, f_StageIncludedDate);
    finally
     Generator.Finish;
    end; // k2_idLogRecord
   finally
    Generator.Finish;
   end; // k2_tiLogRecords
  end; // if
  { Комбинируем PrceLevel и NotTM }
  { DONE -oNarry -cРазвитие : Пропустить Belongs и Main для справки }

  if f_Status > 0 then
   Generator.AddIntegerAtom(k2_tiPriceLevel, f_Status);
  {$IFDEF AccGroups}

  if not f_LinkedDocs.Empty then
   OutLinkedDocs;

  if not l_Rel and not f_AccGroups.Empty then
  begin
   Generator.StartTag(k2_tiAccGroups);
   try
    l_S:= f_AccGroups.AsString;
    repeat
     Generator.StartChild(k2_typDictItem);
     try
      i:= Pos('\', l_S);
      if i = 0 then
       i:= Length(l_S)+1;
      Generator.AddStringAtom(k2_tiShortName, Copy(l_S, 1, i-1));
     finally
      Generator.Finish;
     end;
     Delete(l_S, 1, i);
    until l_S = '';
   finally
     Generator.Finish;
   end;
  end; // not AccGroup.Empty
  {$ENDIF}
 finally
  f_Header.Root:= nil;
  f_DocHeaderWritten:= True;
 end
 else
 begin
  f_DocHeaderWritten:= True;
 end;
end;
{$ENDIF}

procedure TCustomNSRCReader.WriteDateNum(Index: TDNType);
begin
  if (DN_Date[Index] <> nsrcBadDate) or not DN_Number[Index].Empty then
  begin
   Warning:= False;
   if not f_DateNumsWritten then
   begin
    HeaderStartTag(k2_tiNumAndDates);
    try
      HeaderStartChild(k2_typNumAndDate);
      try
       HeaderAddIntegerAtom(k2_tiType, ord(Index));
       if DN_Date[Index] <> nsrcBadDate then
         HeaderAddIntegerAtom(k2_tiStart, DN_Date[Index]);
       if not DN_Number[Index].Empty then
         HeaderAddStringAtom(k2_tiNumber, DN_Number[Index]);
      finally
       HeaderFinish;
      end;
    finally
      HeaderFinish;
    end;
   end;
   f_DateNums[Index].Date:= nsrcBadDate;
   f_DateNums[Index].Number.Clear;
   Warning:= True;
  end;
end;

procedure TCustomNSRCReader.SetDate(Index: TDNType; Value: Longint);
begin
  if DN_Date[Index] <> nsrcBadDate then
    WriteDateNum(Index);
  f_DateNums[Index].Date:= Value;
  if not DN_Number[Index].Empty then
    WriteDateNum(Index);
end;

procedure TCustomNSRCReader.SetNumber(Index: TDNType; Value: Tl3String);
begin
  if not DN_Number[Index].Empty then
    WriteDateNum(Index);
  f_DateNums[Index].Number.Assign(Value);
  if DN_Date[Index] <> nsrcBadDate then
    WriteDateNum(Index);
end;

function TCustomNSRCReader.GetDate(Index: TDNType): Longint;
begin
  Result:= f_DateNums[Index].Date;
end;

function TCustomNSRCReader.GetNumber(Index: TDNType): Tl3String;
begin
  Result:= f_DateNums[Index].Number;
end;

procedure TCustomNSRCReader.OutErrorLog(const aMsg: AnsiString);
begin
 Msg2Log(aMsg);
 if Assigned(f_OnError) then
  f_OnError(aMsg);
end;

procedure TCustomNSRCReader.AddActiveInterval(const aStart, aFinish: Longint; 
    const aComment: AnsiString; NotSure: Boolean = False);
begin
 HeaderStartTag(k2_tiActiveIntervals);
 try
  HeaderStartChild(k2_typActiveInterval);
  try
   if NotSure then
    HeaderAddIntegerAtom(k2_tiType, 1);
   HeaderAddIntegerAtom(k2_tiStart, aStart);
   HeaderAddIntegerAtom(k2_tiFinish, aFinish);
   if aComment <> '' then
    HeaderAddStringAtom(k2_tiComment, aComment);
  finally
   HeaderFinish;
  end;
 finally
  HeaderFinish;
 end;
end;

procedure TCustomNSRCReader.AddAlarm(const aDate: Integer;
  const aComment: AnsiString);
begin
 HeaderStartTag(k2_tiAlarms);
 try
  HeaderStartChild(k2_typAlarm);
  try
   HeaderAddIntegerAtom(k2_tiStart, aDate);
   if aComment <> '' then
    HeaderAddStringAtom(k2_tiComment, aComment);
  finally
   HeaderFinish;
  end;
 finally
  HeaderFinish;
 end;
end;

procedure TCustomNSRCReader.CheckAddionalSymbol;
begin
 { Проверка не является ли данная команда дополнительной }
 if Parser.TokenChar = '*' then
 begin
  f_IsAdditional := True;
  Parser.NextTokenChar;
 end
 else
  f_IsAdditional := False;
end;

(*procedure TCustomNSRCReader.TranslateAnyDate(aAtomIndex: Long; const aMessage:
    AnsiString);
var
 l_Date: Longint;
begin
 l_Date := ReadDateInt(aMessage);
 if l_Date <> nsrcBadDate then
  HeaderAddIntegerAtom(aAtomIndex, l_Date);
end;*)

procedure TCustomNSRCReader.CheckDocumentEnd;
var
 l_Type : Tk2Type;
begin
  l_Type := nil;
  if CurrentType <> k2_typEmpty then
   l_Type := CurrentType;
  while (CurrentType <> k2_typEmpty) and not l_Type.IsKindOf(k2_typDocument) do
  begin
    OutErrorLog(Format('TOPIC# %d > Незакрытая скобка %d', [TopicNo, CurrentType.ID]));
    FinishCurrentType;
    if CurrentType <> k2_typEmpty then
     l_Type := CurrentType;
  end; // (CurrentType > -1) and (CurrentType <> k2_idDocument)
  if f_Subs <> nil then
    WriteEmptyParagraph(f_Subs);

  if (Parser.TokenType = l3_ttEOL) then
    WriteEmptyParagraph(f_Subs);
  while (BlockCount > 0) do
  begin
   if (f_Block = nil) then
    Generator.Finish
   else
    WriteBlock;
   Dec(BlockCount);
   OutErrorLog(Format('TOPIC# %d > Незакрытый блок', [TopicNo, Parser.SourceLine]));
  end; // (BlockCount > 0)
end;

procedure TCustomNSRCReader.ClearParams;
begin
  l3Free(f_Text);//:= nil;
  l3Free(f_Subs); //:= nil;
  l3Free(f_Block);//:= nil;
  f_Comment.Clear;
  f_LinkedDocs.Clear;
  {$IFDEF AccGroups}
  f_AccGroups.Clear;
  {$ENDIF};
end;

procedure TCustomNSRCReader.CollectName(const aKeyword: AnsiString);
begin
 try
  while Parser.TokenSymbolIs(aKeyword) do
  begin
   if f_Text = nil then
    ReadText(False)
   else // Text = nil
   begin
    f_Text.Append(cc_HardSpace);
    f_Text.Append(Filer.ReadLn);
   end; // Text <> nil
   Parser.NextTokenSp;
   if (Parser.TokenChar = chrStartToken) then
   begin
     Parser.NextTokenSp;
   end; // (Parser.TokenChar = chrStartToken)
  end; // Parser.TokenSymbolIs(aKeyword)
  f_Text.CodePage:= AnsiCodePage;
  f_Text.Trim;
  f_Text.DeleteDoubleSpace;
  HeaderAddStringAtom(k2_tiName, f_Text);
 finally
  l3Free(f_Text);
 end;
 TokenReaded:= True;
end;

procedure TCustomNSRCReader.FinalizeDocument;
var
 l_Type : Tk2Type;
begin
 if CurrentType <> k2_typEmpty then
 begin
  l_Type := CurrentType;
  if l_Type.IsKindOf(k2_typDocument) then
  begin
    {$IFNDEF WithoutCache}
    CheckDocHeader;
    {$ENDIF}
    CheckDateNums;
    {$IFDEF AllComments}
    if not f_Comment.Empty then
    begin
      if Assigned(f_CommentWrite) then
        f_CommentWrite(TopicNo, f_Comment);
    end;
    {$ELSE}
      Generator.AddStringAtom(k2_tiComment, f_Comment);
    {$ENDIF}
    FlushObjectStream;
    FinishCurrentType;
    {exit; { <<<<<< debug }
  end;
 end;
end;

function TCustomNSRCReader.GetInteger(aDefault: Integer = 0): Integer;
begin
 Result:= aDefault;
 with Parser do
 begin
  if not (TokenType in [l3_ttEOL, l3_ttEOF]) then
  begin
   CheckInt := True;
   NextTokenSp;
   if TokenType = l3_ttInteger then
    Result := TokenInt;
   CheckInt:= False;
  end; 
 end;
end;

procedure TCustomNSRCReader.TranslateActive(NotSure: Boolean = False);
var
 l_S: ShortString;
 lDate1, lDate2: Longint;
 lComment: AnsiString;
 l_ReadComment: Boolean;
begin
 {!ACTIVE [Date1[-Date2]]["Comment"]}
 l_S:= ReadDate(False);
 if l_S <> SBadDate then
 begin
  { если даты нет, строка будет либо пустой, либо содержать кавычку }
  if (l_S = '') or (l_S[1] = '"') then
  begin
   l_ReadComment:= l_S <> '';
   lDate1:= minActiveDate;
   lDate2:= maxActiveDate;
  end
  else
  if _ValidDate(l_S) then
  begin
   lDate1:= StDateToDemon(DateTimeToStDate(m0DTFStrToDate(l_S)));
   l_S:= ReadDate(False);
   if l_S = '-' then
   begin
    lDate2:= ReadDateInt(IfThen(NotSure, '!NOTSURE (Finish)', '!ACTIVE (Finish)'));
    if lDate2 = -1 then
     lDate2:= maxActiveDate;
    l_S:= '';
   end
   else
    lDate2:= MaxActiveDate;
   l_ReadComment:= True;
  end
  else
  begin
   OutErrorLog(Format(SErrorDate, [TopicNo, '!ACTIVE', l_S]));
   exit;
  end;
  if Parser.TokenType <> l3_ttEOL then
  begin
   ReadText(True);
   try
    lComment:= l_S + f_Text.AsString;
    if (Length(lComment) > 0) and (lComment[1]='"') and (lComment[Length(lComment)]='"') then
    begin
     Delete(lComment, 1, 1);
     Delete(lComment, Length(lComment), 1);
    end
    else
     lComment:= '';
   finally
    l3Free(f_Text);
   end;
  end
  else
  begin
   lComment:= '';
   Parser.NextToken;
  end;
  AddActiveInterval(lDate1, lDate2, lComment, NotSure);
 end
 else
  OutErrorLog(Format(SErrorDate, [TopicNo, '!ACTIVE', l_S]));
end;

procedure TCustomNSRCReader.TranslateAlarm;
var
 l_Date: Longint;
 i: Integer;
begin
 {!ALARM Date ["Comment"]}
 l_Date:= ReadDateInt('!ALARM');
 ReadText(True);
 try
  f_Text.TrimAll;
  if (f_Text.First = '"') and (f_Text.Last = '"') then
  begin
   f_Text.Delete(0, 1);
   f_Text.Delete(Pred(f_Text.Len), 1);
  end; // (f_Text.First = '"') and (f_Text.Last = '"')
  if l_Date <> -1 then
   AddAlarm(l_Date, f_Text.AsString);
 finally
  l3Free(f_Text);
 end; // try..finally
end;

procedure TCustomNSRCReader.TranslateEdition;
begin
 HeaderAddIntegerAtom(k2_tiUserType, Ord(utEdition));
 Filer.ReadLn;
end;

function TCustomNSRCReader.ReadDate(DateNeeded: Boolean): ShortString;
var
 l_WordChars,
 l_WhiteSpace : TCharSet;
 l_CheckInt: Boolean;
 l_Date: TDateTime;
begin
 l_WordChars:= Parser.WordChars;
 l_WhiteSpace:= Parser.WhiteSpace;
 l_CheckInt:= Parser.CheckInt;
 Parser.WordChars:= ['0'..'9','/'];
 Parser.WhiteSpace:= [' '];
 Parser.CheckInt:= False;
 Parser.NextTokenSP;
 Result:= Parser.TokenString;
 if not _ValidDate(Result) and DateNeeded then
  Result := SBadDate;
 Parser.WordChars:= l_WordChars;
 Parser.WhiteSpace:= l_WhiteSpace;
 Parser.CheckInt:= l_CheckInt;
end;

function TCustomNSRCReader.ReadDateInt(const aDescriptor: AnsiString): Longint;
var
 l_S: ShortString;
begin
 l_S:= ReadDate(True);
 if l_S <> SBadDate then
  Result:= StDateToDemon(DateTimeToStDate(m0DTFStrToDate(l_S)))
 else
 begin
  OutErrorLog(Format(SErrorDate, [TopicNo, aDescriptor, l_S]));
  Result:= NsrcBadDate;
 end;
end;

procedure TCustomNSRCReader.TranslateContents;
var
 l_N6, l_N5: Integer;
begin
// !CONTENTS [N6 [N5]]
//            |   `- уровней в пятерке
//            `----- уровней в шестерке(по умолчанию - 2)
 l_N6:= 2;
 l_N5:= 0;
 Parser.CheckInt:= True;
 Parser.NextTokenSp;
 if Parser.TokenType <> l3_ttEOL then
 begin
  l_N6:= Parser.TokenInt;
  Parser.NextTokenSp;
  if Parser.TokenType <> l3_ttEOL then
  begin
   l_N5:= Parser.TokenInt;
   Parser.NextTokenSp;
  end;
 end;
 Parser.CheckInt:= False;
 Parser.NextTokenSp;
 //Filer.Readln;
 if f_Block <> nil then
 begin
  f_Block.Generator.AddIntegerAtom(k2_tiContentsLevel6, l_N6);
  f_Block.Generator.AddIntegerAtom(k2_tiContentsLevel5, l_N5);
 end
 else
 begin
  HeaderAddIntegerAtom(k2_tiContentsLevel6, l_N6);
  HeaderAddIntegerAtom(k2_tiContentsLevel5, l_N5);
 end;
end;

procedure TCustomNSRCReader.HeaderAddBoolAtom(Index: Long; Value: Boolean);
begin
  {$IFDEF WithoutCache}
  Generator.AddBoolAtom(Index, Value);
  {$ELSE}
  if f_DocHeaderWritten or FirstStep then
  begin
    {$IFNDEF nsTest}
    if Warning and f_DocHeaderWritten then
     OutErrorLog(Format('TOPIC #%d %s Boolean Atom %d = %s',
                  [TopicNo, SWarnHeader, Index, BoolToStr(Value, True)]));
    {$ENDIF nsTest}
    Generator.AddBoolAtom(Index, Value)
  end
  else
  begin
    if not f_StrictFormat and not f_DocStarted then
    begin
      Prepare2Load;
      f_DocStarted:= True;
      CurrentType:= k2_typDocument;
    end;
    f_Header.AddBoolAtom(Index, Value);
  end;
  {$ENDIF}

end;

function TCustomNSRCReader.IsTable: Boolean;
begin
 Result := f_TableCount > 0;
end;

function TCustomNSRCReader.ReadInt: Integer;
begin
 Parser.CheckInt:= True;
 try
  Parser.NextTokenSp;
  if Parser.TokenType <> l3_ttEOL then
   Result:= Parser.TokenInt
  else
   Result:= -1;
 finally
  Parser.CheckInt:= False;
 end;
end;

function TCustomNSRCReader.ReadTimeInt(const aDescriptor: AnsiString): Longint;
var
 l_S: ShortString;
begin
 l_S:= ReadTime(True);
 if l_S <> SBadDate then
  Result:= DateTimeToStTime(m0DTFStrToTime(l_S))
 else
 begin
  OutErrorLog(Format(SErrorDate, [TopicNo, aDescriptor, l_S]));
  Result:= NsrcBadDate;
 end;
end;

function TCustomNSRCReader.ReadTime(TimeNeeded: Boolean): ShortString;
var
 l_WordChars,
 l_WhiteSpace : TCharSet;
 l_CheckInt: Boolean;
 l_Date: TDateTime;
begin
 l_WordChars:= Parser.WordChars;
 l_WhiteSpace:= Parser.WhiteSpace;
 l_CheckInt:= Parser.CheckInt;
 Parser.WordChars:= ['0'..'9',':'];
 Parser.WhiteSpace:= [' '];
 Parser.CheckInt:= False;
 Parser.NextTokenSP;
 Result:= Parser.TokenString;
 if not _ValidTime(Result) and TimeNeeded then
  Result := SBadDate;
 Parser.WordChars:= l_WordChars;
 Parser.WhiteSpace:= l_WhiteSpace;
 Parser.CheckInt:= l_CheckInt;
end;

function TCustomNSRCReader.ReadAddress: TRefAddress;
var
 l_WordChars,
 l_WhiteSpace : TCharSet;
 l_CheckInt: Boolean;
 lValue : Integer;
 lStr : ShortString;
begin
 Result.rDocID := 0;
 {$ifDef DBVer134}
 Result.rSubID := 0;
 {$endif}
 l_WordChars:= Parser.WordChars;
 l_WhiteSpace:= Parser.WhiteSpace;
 l_CheckInt:= Parser.CheckInt;
 Parser.WordChars:= ['0'..'9'];
 Parser.WhiteSpace:= [];
 Parser.CheckInt:= True;
 Parser.NextTokenSP;
 if (Parser.TokenType = l3_ttSingleChar) and (Parser.TokenChar = ' ') then
  Parser.NextTokenSP;

 if Parser.TokenType = l3_ttInteger then
  Result.rDocID := Parser.TokenInt;

 Parser.NextTokenSP;
 if (Parser.TokenType = l3_ttSingleChar) and (Parser.TokenChar = '.') then
 begin
  Parser.NextTokenSP;
 {$ifDef DBVer134}
  if Parser.TokenType = l3_ttInteger then
   Result.rSubID := Parser.TokenInt;
 {$endif}
 end;

 Parser.WordChars:= l_WordChars;
 Parser.WhiteSpace:= l_WhiteSpace;
 Parser.CheckInt:= l_CheckInt;
end;

procedure TCustomNSRCReader.StartDocument(TagID: Tk2Type; aDocType: TDocType = dtText);
begin
  f_IsDictEntry:= False;
  if f_Subs <> nil then
    WriteEmptyParagraph(f_Subs);

  CheckDocumentEnd;
  FinalizeDocument;
  ClearParams;
  Prepare2Load;
  f_UserType := Dt_Types.utNone;
  CurrentType:= TagID;
  f_DocStarted:= True;
  TopicNo:= GetInteger;

  HeaderAddIntegerAtom(k2_tiExternalHandle, TopicNo);
  ReadText(True);
  try
   {$IFNDEF NsrcPlusNsr}
   f_Text.DeleteDoubleSpace;
   {$ENDIF}
   f_IsAnno := TagID = k2_typAnnoTopic;
   if TagID <> k2_typAnnoTopic then
    HeaderAddStringAtom(k2_tiShortName, f_Text);
  finally
   l3Free(f_Text);
  end;
  BlockCount:= 0;
  EnableComment:= True;
  if aDocType <> dtText then
   HeaderAddIntegerAtom(k2_tiType, Ord(aDocType));
end;

procedure TCustomNSRCReader.TranslateAnnoClasses(const aPrefix: AnsiString);
begin
 // Категория пользователя
 ReadText(True);
 try
  if not f_IsBody then
  begin
   HeaderStartTag(k2_tiAnnoClasses);
   try
     HeaderStartChild(k2_typDictItem);
     try
      f_Text.Trim;
      HeaderAddStringAtom(k2_tiName, aPrefix + f_Text.AsString);
     finally
      HeaderFinish;
     end;
   finally
     HeaderFinish;
   end;
  end; // if not f_IsBody
 finally
  l3Free(f_Text);
 end;
end;

procedure TCustomNSRCReader.TranslateAnnoDate;
var
 tmpS: AnsiString;
begin
 HeaderStartTag(k2_tiLogRecords);
 try
  HeaderStartChild(k2_typLogRecord);
  try
   HeaderAddIntegerAtom(k2_tiType, Ord(acAnnoDate));
   ReadText(True);
   { Text содержит строковое представление даты }
   tmpS := f_Text.AsString;
   l3Free(f_Text);
   try
    HeaderAddIntegerAtom(k2_tiStart,
                         StDateToDemon(DateTimeToStDate(m0dtfStrToDate(tmpS))));
   except
    on E: Exception do
     OutErrorLog(Format('TOPIC# %d > Неправильная дата AnnoDate %s', [TopicNo, tmpS]));
   end;
  finally
   HeaderFinish;
  end;
 finally
  HeaderFinish;
 end;
end;

procedure TCustomNSRCReader.TranslateAnnoName;
begin
 CollectName(kwdAnnoNAME);
end;

procedure TCustomNSRCReader.TranslateBook;
begin
 f_UserType := utBook;
 HeaderAddIntegerAtom(k2_tiUserType, Ord(utBook));
 Filer.ReadLn;
end;

procedure TCustomNSRCReader.TranslateCell;
var
 l_Borders: AnsiString;
 l_B, l_Merge, l_VAlign: Integer;
 procedure _WriteFrame(aBorder: Integer);
 begin
   Generator.StartTag(aBorder);
   Generator.Finish;
 end;
begin
// l3System.Msg2log('!CELL');
 (* !CELL <ширина> [ <рамки> [ <признак объединения> [ <вертикальное выравнивание>] ] ]
  Параметры и атрибуты команды
<ширина> - число, ширина ячейки
<рамки> - четыре символа: правая граница - левая - верх - низ (1- присутствует, 0 отсутствует,
          если параметр отсутствует, принимаем равным 1111 (все рамки)
<признак объединения> - число, если отсутствует то 0 (нет объединения)
 *)
 if f_RowCount > 0 then
 begin
  Generator.StartChild(TableTypes(f_TableType, tpCell));
  Inc(f_CellCount);
  Generator.AddIntegerAtom(k2_tiWidth, GetInteger);
  l_VAlign:= 0;
  l_Borders:= Format('%.4d', [GetInteger(1111)]);
  if (l_Borders = '1111') then
   Generator.AddIntegerAtom(k2_tiFrame, evd_fvSolid)
  else
  if (l_Borders = '0001') then
   Generator.AddIntegerAtom(k2_tiFrame, evd_fvDown)
  else
  begin
   Generator.StartTag(k2_tiFrame);
   try
    if l_Borders[1] ='1' then
     _WriteFrame(k2_tiFrameRight);
    if l_Borders[2] ='1' then
     _WriteFrame(k2_tiFrameLeft);
    if l_Borders[3] ='1' then
     _WriteFrame(k2_tiFrameUp);
    if l_Borders[4] ='1' then
     _WriteFrame(k2_tiFrameDown);
   finally
    Generator.Finish;
   end;//try..finally
  end;//l_Borders = '1111'
  if Parser.TokenType <> l3_ttEOL then
  begin
   //Parser.NextTokenSp;
   l_Merge:= GetInteger(0);
   if l_Merge <> 0 then
    Generator.AddIntegerAtom(k2_tiMergeStatus, l_Merge);
   if Parser.TokenType <> l3_ttEOL then
    l_VAlign:= GetInteger(0);
    Generator.AddIntegerAtom(k2_tiVerticalAligment, l_VAlign);
  end; // Parser.TokenType <> l3_ttEOL
 end
 else
  Msg2Log('!CELL без !ROW');
 if Parser.TokenType = l3_ttEOL then
  Parser.NextTokenSp
 else
  Filer.ReadLn;
end;

procedure TCustomNSRCReader.TranslateCellEnd;
begin
// l3System.Msg2log('!CELLEND');
 if f_CellCount > 0 then
 begin
  Dec(f_CellCount);
  Generator.Finish();
 end
 else
  msg2Log('!CELLEND без !CELL');
 Filer.ReadLn;
end;

procedure TCustomNSRCReader.TranslateChange;
var
 l_Rec: TDoc2DocLinkRec;
begin
 l3FillChar(l_Rec, SizeOf(l_Rec));
 l_Rec.rLinkedDocID := GetInteger;
 l_Rec.rLinkType    := GetInteger;
 f_LinkedDocs.Add(l_Rec);
 Filer.ReadLn;
end;

(*
procedure TCustomNSRCReader.TranslateDNLawCase;
var
 l_Number: AnsiString;
 l_LDocID: TDocID;
begin
 Parser.CheckInt := True;
 try
  Parser.NextTokenSp;
 finally
  Parser.CheckInt := False;
 end;

 if Parser.TokenType <> l3_ttEOL then
 begin
  l_LDocID := Parser.TokenInt;
  ReadText(True);
  if Text.Len > 0 then
  begin
   l_Number := Text.AsString;
   HeaderStartTag(k2_tiNumAndDates);
   try
    HeaderStartChild(k2_idNumAndDate);
    try
     HeaderAddIntegerAtom(k2_tiType, ord(dnLawCaseNum));
     HeaderAddStringAtom(k2_tiNumber, l_Number);
     HeaderAddIntegerAtom(k2_tiDocID, l_LDocID);
    finally
     HeaderFinish;
    end;
   finally
     HeaderFinish;
   end;
  end;
 end;

end;

*)

procedure TCustomNSRCReader.TranslateServiceInfo;
begin
 ReadText(True);
 try
  if not f_IsBody then
  begin
   HeaderStartTag(k2_tiServiceInfo);
   try
      HeaderStartChild(k2_typDictItem);
      try
       f_Text.Trim;
       HeaderAddStringAtom(k2_tiName, f_Text);
      finally
       HeaderFinish;
      end;
    finally
      HeaderFinish;
    end;
   end
   else
   if f_Block <> nil then
   begin
    f_Block.Generator.StartTag(k2_tiServiceInfo);
    try
      f_Block.Generator.StartChild(k2_typDictItem);
      try
       f_Block.Generator.AddStringAtom(k2_tiName, f_Text.AsWStr);
      finally
       f_Block.Generator.Finish;
      end;
    finally
     f_Block.Generator.Finish;
   end;
  end; // if not f_IsBody
 finally
  l3Free(f_Text);
 end;
end;

procedure TCustomNSRCReader.TranslateIzm;
begin
 f_UserType := utIzm;
 HeaderAddIntegerAtom(k2_tiUserType, Ord(f_UserType));
 Filer.ReadLn;
end;

procedure TCustomNSRCReader.TranslateLog;
var
 l_Stage: Integer;
 l_Date: TstDate;
 l_Time: TstTime;
 l_User: Integer;
begin
 { !*LOG 1 10/08/2004 02:44 18
         ^     ^        ^   ^
         |     |        |   `- номер пользователя
         |     |        `----- время
         |     `-------------- дата
         `-------------------- этап
 }
 l_Stage := GetInteger;
 l_Date:= ReadDateInt('!LOG');
 l_Time:= ReadTimeInt('!LOG');
 l_User:= GetInteger;
 Filer.ReadLn;
 HeaderStartTag(k2_tiLogRecords);
 try
  HeaderStartChild(k2_typLogRecord);
  try
   HeaderAddIntegerAtom(k2_tiType, l_Stage);
   HeaderAddIntegerAtom(k2_tiStart, l_Date);
   HeaderAddIntegerAtom(k2_tiTime, l_Time);
   HeaderStartTag(k2_tiUser);
   try
    HeaderAddIntegerAtom(k2_tiHandle, l_User);
   finally
    HeaderFinish;
   end;
  finally
   HeaderFinish;
  end;
 finally
  HeaderFinish;
 end;
end;

procedure TCustomNSRCReader.TranslateNotTM;
begin
 Filer.Readln;
 l3SetMask(f_Status, dstatNotTM);
end;

procedure TCustomNSRCReader.TranslateLanguage;
var
 l_Lang : Integer;
begin
 l_Lang := ReadInt;
 if (l_Lang > -1) then
  HeaderAddIntegerAtom(k2_tiLanguage, l_Lang);
end;

procedure TCustomNSRCReader.TranslateNameComment;
begin
 ReadText(True);
 HeaderAddStringAtom(k2_tiNameComment, f_Text);
end;

procedure TCustomNSRCReader.TranslateRow;
begin
//l3System.Msg2log('!ROW');
 if f_TableCount > 0 then
 begin
  //if f_CellCount = 0 then // А вложенные таблицы?
  begin
   Generator.StartChild(TableTypes(f_TableType, tpRow));
   Inc(f_RowCount);
  end
  //else
  // Msg2Log('!ROW в !CELL');
 end
 else
  Msg2Log('!ROW без !TABLE');
 Filer.ReadLn;
end;

procedure TCustomNSRCReader.TranslateRowEnd;
begin
//l3System.Msg2log('!ROWEND');
 if f_RowCount > 0 then
 begin
  Generator.Finish();
  Dec(f_RowCount);
 end
 else
  Msg2Log('!ROWEND без !ROW');
 Filer.ReadLn;
end;

procedure TCustomNSRCReader.TranslateCaseCode;
begin
  ReadText(True);
  try
    DN_Number[dnLawCaseNum]:= f_Text;
  finally
    l3Free(f_Text);
  end;
end;

procedure TCustomNSRCReader.TranslateTableEnd;
begin
 if f_TableCount > 0 then
 begin
  FinishCurrentType;
  Dec(f_TableCount);
 end
 else
  msg2Log('!TableEnd без !Table');
 Filer.ReadLn; 
end;

procedure TCustomNSRCReader.TranslateTerm;
var
 l_ID: Integer;
 l_CodePage: Integer;
begin
{ !TERM N Termin
        ^ ^
        | `- термин
        `--- идентификатор языка
}
 f_IsDictEntry:= True;
 Parser.CheckInt:= True;
 Parser.NextTokenSp;
 Parser.CheckInt:= False;
 if Parser.TokenType <> l3_ttEOL then
 begin
  l_ID:= Parser.TokenInt;
  try
   l_CodePage:= Filer.CodePage;
   if TevdLanguage(Pred(l_ID)) > evd_lgEnglish then
    Filer.CodePage:= CP_WesternWin;
   f_Termins[TevdLanguage(Pred(l_ID))].Append(Filer.ReadLn);
   f_Termins[TevdLanguage(Pred(l_ID))].Trim;
   Filer.CodePage:= l_CodePage;
  except
   on E: Exception do
   begin
    Msg2Log('Ошибка чтения термина статьи');
    l3System.Exception2Log(E);
   end; // on E
  end; // try..except
 end; // Parser.TokenType <> l3_ttEOL
end;

procedure TCustomNSRCReader.TranslateUrgency;
begin
 HeaderAddIntegerAtom(k2_tiUrgency, GetInteger);
 Filer.ReadLn;
end;

procedure TCustomNSRCReader.WorkupToken;
var
 S: AnsiString;
begin
  if not TokenReaded then
  begin
    Try2ReadComment(False);
    Parser.NextTokenSp;
  end // not TokenReaded
  else
    TokenReaded:= False;

  if not Filer.EOF then
  begin
   CheckAddionalSymbol;
   if not Parser.TokenSymbolIs(kwdStyle) then f_EmptyParagraph:= 0;
   if Parser.TokenSymbolIs(kwdTOPIC) or
      Parser.TokenSymbolIs(kwdObjTOPIC) or
      Parser.TokenSymbolIs(kwdFlashTOPIC) or
      Parser.TokenSymbolIs(kwdAnnoTOPIC) then { начало документа }
   begin
     if Parser.TokenSymbolIs(kwdAnnoTOPIC) then
      StartDocument(k2_typAnnoTopic)
     else
      if Parser.TokenSymbolIs(kwdObjTOPIC) then
       StartDocument(k2_typDocument, dtObject)
      else
       if Parser.TokenSymbolIs(kwdFlashTopic) then
        StartDocument(k2_typDocument, dtFlash)
       else
        StartDocument(k2_typDocument);
   end
   else
  if not FirstStep then
  begin
   if f_DocStarted or not StrictFormat then
   begin
    if (Parser.TokenType = l3_ttSingleChar) and (Parser.TokenChar = cc_SemiColon) then
     Try2ReadComment(True)
    else
    begin
     if Parser.TokenSymbolIs(kwdSTYLE) or
        Parser.TokenSymbolIs(kwdSTYLEA) then { Начался новый параграф }
     begin
      {$IFNDEF WithoutCache}
      CheckDocHeader;
      {$ENDIF}
      CheckDateNums;
      while f_EmptyParagraph > 0 do
      begin
        WriteEmptyParagraph(f_Subs);
        Dec(f_EmptyParagraph);
      end;
      TranslateStyle(Parser.TokenSymbolIs(kwdSTYLEA));
     end { STYLE }
     else
     if Parser.TokenSymbolIs(kwdSUB) then
      TranslateSub
     else
     if Parser.TokenSymbolIs(kwdNAME) then
       TranslateName
     else
     if Parser.TokenSymbolIs(kwdSOURCE) then
       TranslateSource
     else
     if Parser.TokenSymbolIs(kwdTYPE) then
       TranslateType
     else
     if Parser.TokenSymbolIs(kwdKEYWORDS) then
       TranslateKeywords
     else
     if Parser.TokenSymbolIs(kwdBELONGS) then
       TranslateBelongs
     else
     if Parser.TokenSymbolIs(kwdWARNING) then
       TranslateWarning
     else
     if Parser.TokenSymbolIs(kwdCLASS) {$IFDEF EnableSuffix}or Parser.TokenSymbolIs(kwdSUFFIX) {$ENDIF}then
       TranslateClassAndSuffix
     else
     if Parser.TokenSymbolIs(kwdDOC) then
       TranslateDOC
     else
     if Parser.TokenSymbolIs(kwdNODOC) then
       TranslateNoDoc
     else
     if Parser.TokenSymbolIs(kwdCALENDAR) then
       TranslateCalendar
     else
     if Parser.TokenSymbolIs(kwdBUSINESS) then
       TranslateBusiness
     else
     if Parser.TokenSymbolIs(kwdUSERINFO) then
       TranslateUserInfo
     else
     if Parser.TokenSymbolIs(kwdDATE) then
       TranslateDate
     else
     if Parser.TokenSymbolIs(kwdRDATE) then
       TranslateRDate
     else
     if Parser.TokenSymbolIs(kwdGDDATE) then
       TranslateGDDate
     else
     if Parser.TokenSymbolIs(kwdSFDATE) then
       TranslateSFDate
     else
     if Parser.TokenSymbolIs(kwdCHDATE) then
       TranslateCHDate
     else
     if Parser.TokenSymbolIs(kwdSFCODE) then
       TranslateSFCode
     else
     if Parser.TokenSymbolIs(kwdGDCODE) then
       TranslateGDCode
     else
     if Parser.TokenSymbolIs(kwdRCODE) then
       TranslateRCode
     else
     if Parser.TokenSymbolIs(kwdCasecode) then
       TranslateCaseCode
     else
     if Parser.TokenSymbolIs(kwdAddCODE) then
       TranslateAddCode
     else
     if Parser.TokenSymbolIs(kwdCODE) then
       TranslateCode
     else
     if Parser.TokenSymbolIs(kwdVINCLUDED) then
       TranslateVIncluded
     else
     if Parser.TokenSymbolIs(kwdVANONCED) then
       TranslateVAnonced
     else
     if Parser.TokenSymbolIs(kwdVCHANGED) then
       TranslateVChanged
     else
     if Parser.TokenSymbolIs(kwdVABOLISHED) then
       TranslateVAbolished
     else
     if Parser.TokenSymbolIs(kwdVLCONTROL) then
       TranslateVLControl
     else
     if Parser.TokenSymbolIs(kwdRELATED) then
       TranslateRelated
     else
     if Parser.TokenSymbolIs(kwdBLOCK) then
      TranslateBlock
     else
     if Parser.TokenSymbolIs(kwdBLOCKEND) then
       TranslateBlockEnd
     else
     if Parser.TokenSymbolIs(kwdPRIORITY) then
       TranslatePriority
     else
     if Parser.TokenSymbolIs(kwdSORTDATE) then
       TranslateSortDate
     else
     if Parser.TokenSymbolIs(kwdNOACTIVE) then {!!!}
       TranslateNoActive
     else
     if Parser.TokenSymbolIs(kwdREL) then
       TranslateRel
     else
     if Parser.TokenSymbolIs(kwdSTAGE) then
       TranslateStage
     else
     if Parser.TokenSymbolIs(kwdCHECK) then
       TranslateCheck
     else
     {<-= Update 4.08 =->}
     if Parser.TokenSymbolIs(kwdPUBLISHEDIN) then
       TranslatePublishedIn
     else
     if Parser.TokenSymbolIs(kwdPREFIX) then
       TranslatePrefix
     else
     if Parser.TokenSymbolIs(kwdTERRITORY) then
       TranslateTerritory
     else
     if Parser.TokenSymbolIs(kwdNORM) then
       TranslateNorm
     else
     if Parser.TokenSymbolIs(kwdPREACTIVE) then
       TranslatePreActive
     else
     if Parser.TokenSymbolIs(kwdMOJNOTREG) then
       TranslateMOJNotReg
     else if Parser.TokenSymbolIs(kwdOBJPATH) then
       TranslateObjPath
     else
     if Parser.TokenSymbolIs(kwdOBJTYPE) then
       TranslateObjType
     else
     if Parser.TokenSymbolIs(kwdPRICELEVEL) then
       TranslatePriceLevel
     else
     if Parser.TokenSymbolIs(kwdTABLE) then
       TranslateTable
     else
     if Parser.TokenSymbolIs(kwdTABLEEND) then
       TranslateTableEnd
     else
     if Parser.TokenSymbolIs(kwdROW) then
       TranslateRow
     else
     if Parser.TokenSymbolIs(kwdROWEND) then
       TranslateRowEnd
     else
     if Parser.TokenSymbolIs(kwdCELL) then
       TranslateCell
     else
     if Parser.TokenSymbolIs(kwdCELLEND) then
       TranslateCellEnd
     else
     if Parser.TokenSymbolIs(kwdRevision) then
       TranslateRevision
     else
     if Parser.TokenSymbolIs(kwdDivision) then
       TranslateDivision
     else
     if Parser.TokenSymbolIs(kwdRefDoc) then
       TranslateRefDoc
     else
     if Parser.TokenSymbolIs(kwdMain) then
       TranslateMain
     else
     { Поддержка версионности блоков 12.03.2003 }
     if Parser.TokenSymbolIs(kwdVerLink) then
       TranslateVerLink
     else
     if Parser.TokenSymbolIs(kwdUrgency) then
       TranslateUrgency
     else
     if Parser.TokenSymbolIs(kwdNameComment) then
       TranslateNameComment
     else
     if Parser.TokenSymbolIs(kwdActive) then
       TranslateActive
     else
     if Parser.TokenSymbolIs(kwdNotSure) then
       TranslateActive(True)
     else
     if Parser.TokenSymbolIs(kwdEdition) then
       TranslateEdition
     else
     if Parser.TokenSymbolIs(kwdAlarm) then
       TranslateAlarm
     else
     if Parser.TokenSymbolIs(kwdContents) then
       TranslateContents
     else
     if Parser.TokenSymbolIs(kwdCompareContents) then
       TranslateCompareContents
     else
     if Parser.TokenSymbolIs(kwdTerm) then
      TranslateTerm
     else
     if Parser.TokenSymbolIs(kwdNotTM) then
      TranslateNotTM
     else
     if Parser.TokenSymbolIs(kwdInternet) then
      TranslateInternet
     else
     if Parser.TokenSymbolIs(kwdHang) then
      TranslateHang
     else
     if Parser.TokenSymbolIs(kwdAnnoName) then
      TranslateAnnoName
     else
     if Parser.TokenSymbolIs(kwdAnnoUser) then
      TranslateAnnoClasses(class_AnnoUser)
     else
     if Parser.TokenSymbolIs(kwdAnnoOrganization) then
      TranslateAnnoClasses(class_AnnoOrganization)
     else
     if Parser.TokenSymbolIs(kwdAnnoTax) then
      TranslateAnnoClasses(class_AnnoTax)
     else
     if Parser.TokenSymbolIs(kwdAnnoInterest) then
      TranslateAnnoClasses(class_AnnoInterest)
     else
     if Parser.TokenSymbolIs(kwdAnnoKind) then
      TranslateAnnoClasses(class_AnnoKind)
     else
     if Parser.TokenSymbolIs(kwdAnnoImportant) then
      TranslateAnnoClasses(class_AnnoImportant)
     else
     if Parser.TokenSymbolIs(kwdAnnoSignificant) then
      TranslateAnnoClasses(class_AnnoSignificant)
     else
     if Parser.TokenSymbolIs(kwdAnnoDate) then
      TranslateAnnoDate
     else
     if Parser.TokenSymbolIs(kwdBook) then
      TranslateBook
     else
     if Parser.TokenSymbolIs(kwdIzm) then
      TranslateIzm
     else
     if Parser.TokenSymbolIs(kwdLog) then
      TranslateLog
     else
     if Parser.TokenSymbolIs(kwdServiceInfo) then
      TranslateServiceInfo
     else
     if Parser.TokenSymbolIs(kwdArchiCheck) then
      Filer.ReadLn
     else
     if Parser.TokenSymbolIs(kwdLanguage) then
      TranslateLanguage
     else
     if Parser.TokenSymbolIs(kwdChange) then
      TranslateChange
     else
     if Parser.TokenSymbolIs(kwdNoCompare) then
      TranslateNoCompare
     else
     if Parser.TokenSymbolIs(kwdZoom) then
      TranslateZoom
     else
     if Parser.TokenSymbolIs(kwdLeftIndent) then
      TranslateLeftIndent
     else
     if Parser.TokenSymbolIs(kwdDocType) then
      TranslateDocType
     else
     if Parser.TokenSymbolIs(kwdKind) then
      TranslateKind
     else
     begin
       S:= Parser.TokenString;
       if Length(S) > 1 then
          Msg2Log(Format('WARNING: Topic #%d > Неизвестная команда !%s.', [TopicNo, S]));
       Filer.ReadLn;
     end;
    end
   end
   else
   begin
     OutErrorLog(Format('CRITICAL ERROR: Документ не начался, команда !%s пропущена',
                [Parser.TokenString]));
     Filer.Readln;
   end;
 end
 else
  Filer.Readln;
  end; { if Parser.TokenChar <> chrStartToken };
end;

function TCustomNSRCReader.IsValidToken: Boolean;
begin
 Result:= Parser.TokenSymbolIs(kwdTOPIC) or
          Parser.TokenSymbolIs(kwdObjTOPIC) or
          Parser.TokenSymbolIs(kwdFlashTOPIC) or
          Parser.TokenSymbolIs(kwdAnnoTOPIC) or
          Parser.TokenSymbolIs(kwdSTYLE) or
          Parser.TokenSymbolIs(kwdSTYLEA) or
          Parser.TokenSymbolIs(kwdSUB) or
          Parser.TokenSymbolIs(kwdNAME) or
          Parser.TokenSymbolIs(kwdSOURCE) or
          Parser.TokenSymbolIs(kwdTYPE) or
          Parser.TokenSymbolIs(kwdKEYWORDS) or
          Parser.TokenSymbolIs(kwdBELONGS) or
          Parser.TokenSymbolIs(kwdWARNING) or
          Parser.TokenSymbolIs(kwdCLASS) or
          {$IFDEF EnableSuffix}Parser.TokenSymbolIs(kwdSUFFIX) or{$ENDIF}
          Parser.TokenSymbolIs(kwdDOC) or
          Parser.TokenSymbolIs(kwdNODOC) or
          Parser.TokenSymbolIs(kwdCALENDAR) or
          Parser.TokenSymbolIs(kwdBUSINESS) or
          Parser.TokenSymbolIs(kwdUSERINFO) or
          Parser.TokenSymbolIs(kwdDATE) or
          Parser.TokenSymbolIs(kwdRDATE) or
          Parser.TokenSymbolIs(kwdGDDATE) or
          Parser.TokenSymbolIs(kwdSFDATE) or
          Parser.TokenSymbolIs(kwdCHDATE) or
          Parser.TokenSymbolIs(kwdSFCODE) or
          Parser.TokenSymbolIs(kwdGDCODE) or
          Parser.TokenSymbolIs(kwdRCODE) or
          Parser.TokenSymbolIs(kwdCasecode) or
          Parser.TokenSymbolIs(kwdCODE) or
          Parser.TokenSymbolIs(kwdVINCLUDED) or
          Parser.TokenSymbolIs(kwdVANONCED) or
          Parser.TokenSymbolIs(kwdVCHANGED) or
          Parser.TokenSymbolIs(kwdVABOLISHED) or
          Parser.TokenSymbolIs(kwdVLCONTROL) or
          Parser.TokenSymbolIs(kwdRELATED) or
          Parser.TokenSymbolIs(kwdBLOCK) or
          Parser.TokenSymbolIs(kwdBLOCKEND) or
          Parser.TokenSymbolIs(kwdPRIORITY) or
          Parser.TokenSymbolIs(kwdSORTDATE) or
          Parser.TokenSymbolIs(kwdNOACTIVE) or {!!!}
          Parser.TokenSymbolIs(kwdREL) or
          Parser.TokenSymbolIs(kwdSTAGE) or
          Parser.TokenSymbolIs(kwdCHECK) or
          Parser.TokenSymbolIs(kwdPUBLISHEDIN) or
          Parser.TokenSymbolIs(kwdPREFIX) or
          Parser.TokenSymbolIs(kwdTERRITORY) or
          Parser.TokenSymbolIs(kwdNORM) or
          Parser.TokenSymbolIs(kwdPREACTIVE) or
          Parser.TokenSymbolIs(kwdMOJNOTREG) or
          Parser.TokenSymbolIs(kwdOBJPATH) or
          Parser.TokenSymbolIs(kwdOBJTYPE) or
          Parser.TokenSymbolIs(kwdPRICELEVEL) or
          Parser.TokenSymbolIs(kwdTABLE) or
          Parser.TokenSymbolIs(kwdTABLEEND) or
          Parser.TokenSymbolIs(kwdROW) or
          Parser.TokenSymbolIs(kwdROWEND) or
          Parser.TokenSymbolIs(kwdCELL) or
          Parser.TokenSymbolIs(kwdCELLEND) or
          Parser.TokenSymbolIs(kwdRevision) or
          Parser.TokenSymbolIs(kwdDivision) or
          Parser.TokenSymbolIs(kwdRefDoc) or
          Parser.TokenSymbolIs(kwdMain) or
          Parser.TokenSymbolIs(kwdVerLink) or
          Parser.TokenSymbolIs(kwdUrgency) or
          Parser.TokenSymbolIs(kwdNameComment) or
          Parser.TokenSymbolIs(kwdActive) or
          Parser.TokenSymbolIs(kwdNotSure) or
          Parser.TokenSymbolIs(kwdEdition) or
          Parser.TokenSymbolIs(kwdAlarm) or
          Parser.TokenSymbolIs(kwdContents) or
          Parser.TokenSymbolIs(kwdTerm) or
          Parser.TokenSymbolIs(kwdNotTM) or
          Parser.TokenSymbolIs(kwdAnnoName) or
          Parser.TokenSymbolIs(kwdAnnoUser) or
          Parser.TokenSymbolIs(kwdAnnoOrganization) or
          Parser.TokenSymbolIs(kwdAnnoTax) or
          Parser.TokenSymbolIs(kwdAnnoInterest) or
          Parser.TokenSymbolIs(kwdAnnoKind) or
          Parser.TokenSymbolIs(kwdAnnoImportant) or
          Parser.TokenSymbolIs(kwdAnnoSignificant) or
          Parser.TokenSymbolIs(kwdAnnoDate) or
          Parser.TokenSymbolIs(kwdBook) or
          Parser.TokenSymbolIs(kwdIzm) or
          Parser.TokenSymbolIs(kwdLog) or
          Parser.TokenSymbolIs(kwdServiceInfo) or
          Parser.TokenSymbolIs(kwdArchiCheck) or
          Parser.TokenSymbolIs(kwdLanguage) or
          Parser.TokenSymbolIs(kwdChange) or
          Parser.TokenSymbolIs(kwdCaseCODE) or
          Parser.TokenSymbolIs(kwdNOCompare) or
          Parser.TokenSymbolIs(kwdZoom) or
          Parser.TokenSymbolIs(kwdLeftIndent) or
          Parser.TokenSymbolIs(kwdKind);
end;

procedure TCustomNSRCReader.TranslateNOCOMPARE;
begin
 Filer.Readln;
 l3SetMask(f_Status, dstatNoCompare);
end;

procedure TCustomNSRCReader.TranslateLeftIndent;
begin
 Generator.AddIntegerAtom(k2_tiLeftIndent, GetInteger);
 Filer.ReadLn;
end;

procedure TCustomNSRCReader.TranslateZoom;
var
 l_Zoom: Integer;
begin
 l_Zoom:= GetInteger;
 Filer.ReadLn;
 if (f_TableCount > 0) and (l_Zoom <> Tk2Prop(k2_typTable.Prop[k2_tiZoom]).DefaultValue) then
  Generator.AddIntegerAtom(k2_tiZoom, l_Zoom);
end;

function TCustomNSRCReader._ValidDate(const aDateStr: AnsiString): Boolean;
var
 l_Date: TDateTime;
begin
 Result := False;
 if (adateStr <> '') and not (aDateStr[1] in ['"', '-']) then
 try
  l_Date:= m0DTFStrToDate(aDateStr);
  Result := True;
 except
  Result := False;
 end;
end;

function TCustomNSRCReader._ValidTime(const aTimeStr: AnsiString): Boolean;
var
 l_Time: TDateTime;
begin
 Result := False;
 if (aTimeStr <> '') then
 try
  l_Time:= m0DTFStrToTime(aTimeStr);
  Result := True;
 except
  Result := False;
 end;
end;

procedure TCustomNSRCReader.AddAlignBySeparator(aOffset: Integer);
begin
 Generator.StartTag(k2_tiTabStops);
 try
  Generator.StartDefaultChild;
  try
   Generator.AddIntegerAtom(k2_tiType, Ord(l3_tssDecimal));
   Generator.AddIntegerAtom(k2_tiStart, aOffset);
  finally
   Generator.Finish;
  end;
 finally
  Generator.Finish;
 end;
end;

procedure TCustomNSRCReader.TranslateCompareContents;
var
 l_N: Integer;
begin
// !COMPARECONTENTS [N]
//                   `- уровней в пятерке
 l_N:= 0;
 Parser.CheckInt:= True;
 Parser.NextTokenSp;
 if Parser.TokenType <> l3_ttEOL then
  l_N:= Parser.TokenInt;
 Parser.CheckInt:= False;
 Parser.NextTokenSp;
 if f_Block <> nil then
  f_Block.Generator.AddIntegerAtom(k2_tiCompareContentsLevel, l_N)
 else
  HeaderAddIntegerAtom(k2_tiCompareContentsLevel, l_N);
end;

procedure TCustomNSRCReader.TranslateInternet;
begin
 Filer.Readln;
 l3SetMask(f_Status, dstatInternet);
end;

procedure TCustomNSRCReader.TranslateHang;
begin
 Filer.Readln;
 l3SetMask(f_Status, dstatHang);
end;

procedure TCustomNSRCReader.TranslateDocType;
begin
 //!DOCTYPE <Type> BOOK, EDITION, DOC, IZM, NODOC, REL, ААКCONTENT, ААКTEXT
 ReadText(True);
 try
  if l3Same(f_Text.AsWStr, 'BOOK', True) then
   f_UserType:= utBook
  else
  if l3Same(f_Text.AsWStr, 'EDITION', True) then
   f_UserType:= utEdition
  else
  if l3Same(f_Text.AsWStr, 'DOC', True) then
   f_UserType:= utDoc
  else
  if l3Same(f_Text.AsWStr, 'IZM', True) then
   f_UserType:= utIzm
  else
  if l3Same(f_Text.AsWStr, 'NODOC', True) then
   f_UserType:= utNoDoc
  else
  if l3Same(f_Text.AsWStr, 'REL', True) then
  begin
   f_IsRel:= True;
   HeaderAddIntegerAtom(k2_tiType, Ord(dtRelText));
  end
  else
  if l3Same(f_Text.AsWStr, 'AAKCONTENT', True) then
   f_UserType:= utAAK_Cont
  else
  if l3Same(f_Text.AsWStr, 'AAKTEXT', True) then
   f_UserType:= utAAK_Doc;
  if not f_IsRel then
   HeaderAddIntegerAtom(k2_tiUserType, Ord(f_UserType));
 finally
  l3Free(f_Text);
 end;
end;

procedure TCustomNSRCReader.TranslateKind;
begin
 ReadText(True);
 try
  if not f_IsBody then
  begin
   HeaderStartTag(k2_tiPrefix);
   try
     HeaderStartChild(k2_typDictItem);
     try
       f_Text.Trim;
       HeaderAddStringAtom(k2_tiName, f_Text);
     finally
       HeaderFinish;
     end;
   finally
     HeaderFinish;
   end;
  end
  else
  if f_Block <> nil then
  begin
   f_Block.Generator.StartTag(k2_tiPrefix);
   try
     f_Block.Generator.StartChild(k2_typDictItem);
     try
      f_Block.Generator.AddStringAtom(k2_tiName, f_Text.AsWStr);
     finally
      f_Block.Generator.Finish;
     end;
   finally
    f_Block.Generator.Finish;
   end;
  end;
 finally
  l3Free(f_Text);
 end;
end;

procedure TCustomNSRCReader.Try2ReadComment(aSigleCheck: Boolean);
begin
 while (Parser.TokenChar <> chrStartToken) and not Filer.EOF do
 begin
  if Parser.TokenChar = cc_SemiColon then
   TranslateComment;
  if (Parser.TokenType = l3_ttEOL) then
  begin
   if f_DocHeaderWritten then
    WriteEmptyParagraph(f_Subs)
   else
    Inc(f_EmptyParagraph);
  end; // (Parser.TokenType = l3_ttEOL)
  Parser.NextTokenSp;
  if aSigleCheck then Break;
 end; // while (Parser.TokenChar <> chrStartToken) and not Filer.EOF
end;

end.

