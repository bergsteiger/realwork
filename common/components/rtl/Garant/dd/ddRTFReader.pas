unit ddRTFReader;

// $Id: ddRTFReader.pas,v 1.255 2016/06/17 11:17:59 dinishev Exp $ 

// $Log: ddRTFReader.pas,v $
// Revision 1.255  2016/06/17 11:17:59  dinishev
// {Requestlink:624709249}. Тест.
//
// Revision 1.254  2016/06/14 12:21:26  dinishev
// {Requestlink:624074743}. Символ отрицания приводил к DOS-кодировке.
//
// Revision 1.253  2016/04/12 12:38:12  dinishev
// Убрал древний try except
//
// Revision 1.252  2016/04/06 13:17:33  dinishev
// {Requestlink:621056217}. Режем левые символы.
//
// Revision 1.251  2016/02/12 08:54:42  dinishev
// {Requestlink:617082437}
//
// Revision 1.250  2016/01/28 12:47:53  dinishev
// Bug fix: поотъезжали тесты.
//
// Revision 1.249  2016/01/28 12:09:00  dinishev
// {Requestlink:616562811}. Bookmark из RTF
//
// Revision 1.248  2016/01/28 10:51:25  dinishev
// {Requestlink:616562811}. Bookmark из RTF
//
// Revision 1.247  2015/12/09 07:29:14  dinishev
// Поправил по результатам тестов.
//
// Revision 1.246  2015/12/08 09:08:53  dinishev
// http://mdp.garant.ru/pages/viewpage.action?pageId=610504218&focusedCommentId=613289410#comment-613289410
//
// Revision 1.245  2015/12/04 05:36:57  dinishev
// Bug fix: вычистил экспериментальный мусор.
//
// Revision 1.244  2015/12/02 14:31:59  dinishev
// Правки для Можаева.
//
// Revision 1.243  2015/12/01 08:53:27  dinishev
// Установленный в ходе обработки параметр.
//
// Revision 1.242  2015/11/26 05:53:26  dinishev
// Reformat
//
// Revision 1.241  2015/11/24 07:16:24  dinishev
// Reformat
//
// Revision 1.240  2015/11/05 08:18:15  dinishev
// {Requestlink:610504218}
//
// Revision 1.239  2015/11/03 09:44:01  dinishev
// {Requestlink:610504218}
//
// Revision 1.238  2015/10/28 06:50:01  dinishev
// Bug fix: отъехали тесты.
//
// Revision 1.237  2015/10/27 11:57:26  dinishev
// {Requestlink:138969449}. Все равно пропускали текст.
//
// Revision 1.236  2015/10/20 11:18:23  dinishev
// {Requestlink:607275587}. Теряли сноски.
//
// Revision 1.235  2015/10/19 11:46:27  dinishev
// {Requestlink:607275587}. Зафиксировал рабочий вариант.
//
// Revision 1.234  2015/10/08 10:36:22  dinishev
// {Requestlink:588548123}. Прокидываю флаг до таблицы.
//
// Revision 1.233  2015/09/10 12:43:43  dinishev
// {Requestlink:606808862}
//
// Revision 1.232  2015/09/10 10:44:33  dinishev
// Reformat
//
// Revision 1.231  2015/09/10 10:42:49  dinishev
// Reformat
//
// Revision 1.230  2015/09/08 08:16:23  dinishev
// Выкинул какой-то древний, неработающий костыль.
//
// Revision 1.229  2015/09/08 07:52:41  dinishev
// {Requestlink:606634250}. Читаем картинки из \sv
//
// Revision 1.228  2015/09/08 07:30:18  dinishev
// {Requestlink:606634250}. Читаем картинки из \sv
//
// Revision 1.227  2015/09/01 13:51:39  dinishev
// {Requestlink:588577774}
//
// Revision 1.226  2015/08/28 10:46:48  dinishev
// {Requestlink:606138650}
//
// Revision 1.223  2015/08/28 09:27:42  dinishev
// {Requestlink:606138650}
//
// Revision 1.222  2015/08/28 08:34:25  dinishev
// Bug fix: закоммител лишнее.
//
// Revision 1.221  2015/08/27 14:55:54  dinishev
// {Requestlink:606138650}
//
// Revision 1.220  2015/08/27 14:53:09  dinishev
// {Requestlink:606138650}
//
// Revision 1.219  2015/08/17 08:15:50  dinishev
// {Requestlink:602009846}
//
// Revision 1.218  2015/07/08 09:03:56  dinishev
// {Requestlink:601462517}
//
// Revision 1.217  2015/07/07 15:01:19  dinishev
// {Requestlink:601462517}
//
// Revision 1.216  2015/07/01 12:06:29  dinishev
// {Requestlink:602703982}
//
// Revision 1.215  2015/06/23 15:13:15  dinishev
// Добавил Assert
//
// Revision 1.214  2015/06/23 15:11:49  dinishev
// Добавил Assert
//
// Revision 1.213  2015/06/23 14:54:25  dinishev
// Убрал неиспользуемые методы.
//
// Revision 1.212  2015/06/18 16:15:06  dinishev
// {Requestlink:602001112}. Не начинался список с буквенными индексами.
//
// Revision 1.211  2015/06/18 13:14:13  dinishev
// {Requestlink:602001112}. Поддержка принудительного начала списков.
//
// Revision 1.210  2015/06/15 10:14:31  dinishev
// {Requestlink:601456704}
//
// Revision 1.209  2015/06/08 12:16:46  dinishev
// {Requestlink:600945017}. Не читалась картинка.
//
// Revision 1.208  2015/05/18 13:46:55  dinishev
// {Requestlink:599800930}
//
// Revision 1.207  2015/03/18 06:46:41  dinishev
// Убрал внутренности чтения картинок из RTFReader'а.
//
// Revision 1.205  2015/03/12 07:02:40  dinishev
// {Requestlink:590745463}
//
// Revision 1.204  2015/02/18 11:24:37  dinishev
// {Requestlink:571653012}. Роза сдохла, хоть что-то зафиксирую.
//
// Revision 1.203  2015/02/17 14:12:26  dinishev
// {Requestlink:571653012}. Избавится от WriteText. + Close_rdsXXX
//
// Revision 1.202  2015/02/16 14:57:20  dinishev
// {Requestlink:571653012}. Избавится от WriteText (не закончил).
//
// Revision 1.201  2015/02/16 13:21:55  dinishev
// {Requestlink:571653012}
//
// Revision 1.200  2015/02/16 11:37:53  dinishev
// {Requestlink:571653012}
//
// Revision 1.199  2015/02/13 12:45:32  dinishev
// {Requestlink:571653012}
//
// Revision 1.198  2015/02/09 14:50:59  dinishev
// Флаг ReadWMFIfExists для чтения WMF картинок вместо PNG, если информация о них есть в nonshppict
//
// Revision 1.197  2015/02/09 09:12:34  dinishev
// Reformat
//
// Revision 1.195  2015/02/09 08:59:19  dinishev
// Чистка кода + выкинул неиспользуемый флаг.
//
// Revision 1.194  2015/01/29 08:09:14  dinishev
// Вычистил код под OnePass.
//
// Revision 1.193  2014/11/13 07:31:46  dinishev
// {Requestlink:573678077}
//
// Revision 1.192  2014/11/11 11:44:49  dinishev
// {Requestlink:571646843}. Пытаемся игнрорировать лишний текст.
//
// Revision 1.191  2014/11/10 10:55:34  dinishev
// {Requestlink:571646843}. Игнорируем текст из поля PAGE.
//
// Revision 1.190  2014/11/07 10:39:50  dinishev
// {Requestlink:570553101}
//
// Revision 1.189  2014/09/19 08:12:40  dinishev
// {Requestlink:565269737}
//
// Revision 1.188  2014/05/28 06:29:05  dinishev
// {Requestlink:537974930}
//
// Revision 1.187  2014/05/28 06:02:52  dinishev
// Reformat
//
// Revision 1.186  2014/05/26 09:36:36  dinishev
// Вычистил неиспользуемое.
//
// Revision 1.185  2014/05/21 12:14:30  dinishev
// {Requestlink:535902713}
//
// Revision 1.184  2014/04/28 10:01:46  dinishev
// {Requestlink:531981193}
//
// Revision 1.183  2014/04/17 11:22:12  dinishev
// {Requestlink:530279317}                                        
//
// Revision 1.182  2014/04/15 10:42:03  dinishev
// {Requestlink:528446913}
//
// Revision 1.181  2014/04/10 09:38:36  dinishev
// {Requestlink:526715670}. Ускорение для EMF-картинок. Можно будет потом развивать для других форматов, если понадобиться...
//
// Revision 1.180  2014/04/08 08:18:20  dinishev
// {Requestlink:526715670}
//
// Revision 1.179  2014/04/04 07:40:18  dinishev
// Bug fix: не собирался Арчи.
//
// Revision 1.178  2014/04/03 10:57:27  dinishev
// {Requestlink:526715670}. Bug fix: пропускали первый байт бинарного потока. :-(
//
// Revision 1.177  2014/04/03 10:35:36  dinishev
// {Requestlink:526715670}. Учимся читать формат картинки из RTF.
//
// Revision 1.176  2014/04/01 10:53:54  dinishev
// {Requestlink:523329879}
//
// Revision 1.175  2014/02/18 13:34:33  lulin
// - избавляемся от ненужного списка.
//
// Revision 1.174  2014/02/17 16:26:04  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.173  2014/02/14 15:33:53  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.172  2014/01/13 08:30:51  dinishev
// {Requestlink:510621098}. Финальные штрихи.
//
// Revision 1.171  2013/12/30 13:39:50  dinishev
// {Requestlink:508175715}. Вторая попытка - все-таки анализируем e-mail.
//
// Revision 1.170  2013/12/26 14:42:05  dinishev
// {Requestlink:508175715}
//
// Revision 1.169  2013/10/29 11:21:32  dinishev
// {Requestlink:496995054}
//
// Revision 1.168  2013/10/18 14:11:37  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.167  2013/10/16 09:23:06  dinishev
// {Requestlink:493324121}
//
// Revision 1.166  2013/09/17 08:43:12  dinishev
// {Requestlink:482752570}. Попытка бороться с лишними пробелами.
//
// Revision 1.165  2013/09/16 13:29:41  dinishev
// {Requestlink:482752570}
//
// Revision 1.164  2013/07/19 09:59:19  dinishev
// {Requestlink:466752604}. Нарисованы TdestNorm и его наследники на модели. Нарисован TddBreak на модели.
//
// Revision 1.163  2013/07/18 12:15:19  dinishev
// Вычищаем кучу неиспользованного кода.
//
// Revision 1.162  2013/07/18 11:49:31  dinishev
// {Requestlink:466752604}
//
// Revision 1.161  2013/07/18 10:23:13  dinishev
// Убираем бесполезный объект.
//
// Revision 1.160  2013/07/11 17:36:59  lulin
// - правим за Димой.
//
// Revision 1.159  2013/07/11 13:16:37  dinishev
// Вызываем raise для тестов.
//
// Revision 1.158  2013/07/10 13:21:01  dinishev
// Перенос части ddRTFdestination на модель.
//
// Revision 1.157  2013/07/10 11:48:02  dinishev
// Cleanup
//
// Revision 1.156  2013/07/10 11:40:58  dinishev
// Refactoring: Переносим ddRTFState на модель + убираем кишки TrtfStateStack из TddRTFReader
//
// Revision 1.155  2013/07/10 08:59:04  dinishev
// {Requestlink:449678171}
//
// Revision 1.154  2013/07/09 10:36:58  dinishev
// Cleanup
//
// Revision 1.153  2013/07/09 10:36:08  dinishev
// Cleanup
//
// Revision 1.152  2013/07/09 10:35:52  dinishev
// Cleanup
//
// Revision 1.151  2013/07/09 10:30:28  dinishev
// Cleanup
//
// Revision 1.150  2013/07/09 10:29:26  dinishev
// Cleanup
//
// Revision 1.149  2013/07/09 09:54:31  dinishev
// Cleanup
//
// Revision 1.148  2013/07/02 10:05:31  dinishev
// {Requestlink:466751465}
//
// Revision 1.147  2013/05/08 12:33:00  dinishev
// {Requestlink:453164226}
//
// Revision 1.146  2013/05/06 12:37:11  dinishev
// Откатываем костыли и "рефакторинг" - отъехало чтение таблиц.
//
// Revision 1.145  2013/04/11 16:46:28  lulin
// - отлаживаем под XE3.
//
// Revision 1.144  2013/04/05 12:04:30  lulin
// - портируем.
//
// Revision 1.143  2013/03/20 11:37:28  narry
// * не читались многоуровневые списки
//
// Revision 1.142  2013/03/15 08:42:45  fireton
// - не хотел читать документ без переоткрытия стрима
//
// Revision 1.141  2013/02/14 10:49:59  narry
// Чистка мусора
//
// Revision 1.140  2013/01/25 13:13:36  narry
// Не устанавливается шрифт по имени (424386600)
//
// Revision 1.139  2013/01/25 05:38:51  narry
// Заменять автонумерацию на фиксированную (407745210)
//
// Revision 1.138  2013/01/24 12:59:15  narry
// Заменять автонумерацию на фиксированную (407745210)
//
// Revision 1.137  2013/01/24 07:21:41  narry
// Не собиралось
//
// Revision 1.136  2013/01/24 06:05:25  narry
// Обновление
//
// Revision 1.135  2013/01/22 12:19:52  narry
// Рефакторинг RTFReader
//
// Revision 1.133  2012/11/09 08:52:29  narry
// Скрытый текст в исходных файлах (407750788)
//
// Revision 1.132  2012/09/28 10:40:39  narry
// Текст сноски оказывается выше самой сноски (397291894)
//
// Revision 1.131  2012/09/25 08:23:35  narry
// Сноски больше не нумеруются с 10000
//
// Revision 1.130  2012/08/28 11:02:29  narry
// Обновление
//
// Revision 1.129  2012/07/06 08:57:08  fireton
// - прогресс
//
// Revision 1.128  2012/06/26 13:56:16  narry
// Распознавание текста из фреймов
//
// Revision 1.127  2012/04/12 11:21:55  narry
// Обработка нестандартной подстветки
//
// Revision 1.126  2011/09/21 12:30:06  narry
// Пропадают куски текста при форматировании (285510478)
//
// Revision 1.125  2011/07/22 06:54:02  narry
// Напильник для корректного преобразование "татарских" rtf
//
// Revision 1.124  2011/05/18 17:46:03  lulin
// {RequestLink:266409354}.
//
// Revision 1.123  2011/04/15 12:41:27  narry
// Обрезать картинку (262636436)
//
// Revision 1.122  2011/02/11 08:25:53  narry
// K253666052. Добавить флаг EnablePictures
//
// Revision 1.121  2011/02/10 11:24:50  narry
// K253664417. Не проходит тест K235062061
//
// Revision 1.120  2011/02/09 11:34:21  narry
// К253657673. Чтение картинок из RTF
//
// Revision 1.119  2010/11/30 11:47:16  lulin
// {RequestLink:228688602}.
// - борьба с предупреждениями.
//
// Revision 1.118  2010/09/17 09:01:28  narry
// k235051685. Терялись символы из символьных полей
//
// Revision 1.117  2010/07/30 13:23:57  narry
// - чистка кода
//
// Revision 1.116  2010/02/24 18:16:27  lulin
// - избавляемся от ненужного и вредного параметра, доставшегося в наследство от ошибок молодости.
//
// Revision 1.115  2009/07/31 11:10:53  narry
// - изменение параметра рамок по умолчанию
//
// Revision 1.114  2009/07/23 13:42:39  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.113  2009/07/23 08:15:11  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.112  2009/06/24 10:58:27  narry
// - русско-японские RTF от OpenOffice
//
// Revision 1.111  2009/06/11 06:34:11  narry
// - игнорировалось значение полей
//
// Revision 1.110  2009/05/29 11:36:31  narry
// - вместо поднятия окна выкидываем ошибку в лог
//
// Revision 1.109  2009/03/04 13:33:06  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.108  2008/12/16 11:48:55  narry
// - татарская читалка
//
// Revision 1.107  2008/10/23 10:40:06  narry
// - очередной виток борьбы с русско-японскими текстами
//
// Revision 1.106  2008/10/20 07:52:45  narry
// - не накапливается картинка в режиме Lite
//
// Revision 1.105  2008/10/15 09:43:59  narry
// - преобразование русско-японского в русский
//
// Revision 1.104  2008/10/13 14:59:15  voba
// no message
//
// Revision 1.103  2008/10/13 12:39:27  narry
// - промежуточное обновление
//
// Revision 1.102  2008/10/03 13:58:42  narry
// - таблица без ячеек останавливала разбор RTF
//
// Revision 1.101  2008/06/20 14:49:11  lulin
// - используем префиксы элементов.
//
// Revision 1.100  2008/04/24 15:08:01  narry
// - все буллеты преобразуются в дефис
//
// Revision 1.99  2008/04/22 10:09:20  narry
// - текст некоторых полей пропадал
//
// Revision 1.98  2008/04/17 14:44:44  narry
// - сноски, списки, картинки
//
// Revision 1.97  2008/04/10 10:59:13  narry
// - импорт абзацных отступов для элементов списка
//
// Revision 1.96  2008/04/09 13:51:15  narry
// - рефакторинг
// - замена символов буллета на (*, о, #)
//
// Revision 1.95  2008/04/08 11:13:35  narry
// - нумерация меток в соответствии с ТЗ
//
// Revision 1.94  2008/04/08 10:35:28  narry
// - ссылки со сноски на текст сноски
//
// Revision 1.93  2008/03/21 14:09:22  lulin
// - cleanup.
//
// Revision 1.92  2008/03/14 11:36:55  narry
// - борьба с попаданием разрыва страницы внутрь абзаца
//
// Revision 1.91  2008/03/03 20:06:00  lulin
// - <K>: 85721135.
//
// Revision 1.90  2008/02/22 09:06:37  lulin
// - упрощаем наследование.
//
// Revision 1.89  2008/02/20 17:22:59  lulin
// - упрощаем строки.
//
// Revision 1.88  2008/02/14 09:40:33  lulin
// - удалён ненужный класс.
//
// Revision 1.87  2008/02/13 20:20:06  lulin
// - <TDN>: 73.
//
// Revision 1.86  2008/02/06 15:37:00  lulin
// - каждому базовому объекту по собственному модулю.
//
// Revision 1.85  2008/02/05 15:19:25  voba
// - bug fix
//
// Revision 1.84  2008/02/05 09:58:00  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.83  2008/02/01 15:14:44  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.82  2008/01/10 16:50:53  lulin
// - cleanup.
//
// Revision 1.81  2007/09/07 14:47:41  lulin
// - добавлено удаление последнего элемента списка.
//
// Revision 1.80  2007/08/14 19:31:52  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.79  2006/12/29 13:09:25  lulin
// - реализуем интерфейс расширенного списка строк.
//
// Revision 1.78  2006/11/25 14:36:22  lulin
// - cleanup.
//
// Revision 1.77  2006/05/10 06:03:00  oman
// - fix: не компилировалось. Несовпадение типов для TddTableCell.Add(TObject(...))
//
// Revision 1.76  2006/05/06 13:31:05  lulin
// - cleanup.
//
// Revision 1.75  2006/01/05 15:02:45  narry
// - новое: чтение объединенных по горизонтали ячеек (не совсем корректно)
//
// Revision 1.74  2005/07/18 06:43:51  mmorozov
// - warning fix;
//
// Revision 1.73  2005/05/06 08:40:11  fireton
// - вынес строчку в resourcestring (для того, чтобы профайлить можно было)
//
// Revision 1.72  2005/04/19 15:41:42  lulin
// - переходим на "правильный" ProcessMessages.
//
// Revision 1.71  2005/03/28 14:30:04  lulin
// - от класса генераторов переходим к интерфейсу.
//
// Revision 1.70  2004/09/21 12:21:05  lulin
// - Release заменил на Cleanup.
//
// Revision 1.69  2004/09/15 11:09:25  lulin
// - Tl3Stream переведен на "шаблон" l3Unknown.
//
// Revision 1.68  2004/06/01 16:51:23  law
// - удален конструктор Tl3VList.MakePersistent - пользуйтесь _Tl3ObjectRefList.
//
// Revision 1.67  2004/04/14 14:59:14  law
// - rename proc: ev_lPAnsiCharSetPresent -> l3CharSetPresent.
//
// Revision 1.66  2004/04/05 11:41:24  narry
// - cleanup
//
// Revision 1.65  2004/04/05 11:15:05  narry
// - update: подчистка артефактов использования предыдущей графической библиотеки
//
// Revision 1.64  2004/01/16 10:09:48  narry
// - update: пересортировка методов и свойств
//
// Revision 1.63  2003/05/15 11:45:13  narry
// - add: поддержка табуляций
//
// Revision 1.62  2003/05/13 13:42:15  narry
// no message
//
// Revision 1.61  2003/04/30 12:42:05  narry
// - add: константа rtfTwip
// - change: замена 1440 на rtfTwip
//
// Revision 1.60  2003/04/19 12:30:38  law
// - new file: ddDefine.inc.
//
// Revision 1.59  2003/01/08 11:14:52  narry
// - bug fix: текст в ячейках с нулевой шириной
//
// Revision 1.58  2002/11/14 12:47:42  narry
// - bug fix: одновременное выставление у ячейки флагов "Начало верт. объединения" и "продолжение верт. объединения" приводит к исчезновению текста ячейки - ошибка преобразователя формата Microsoft Word в RTF
//
// Revision 1.57  2002/09/09 13:52:19  narry
// - cleanup
//
// Revision 1.56  2002/08/02 08:33:43  narry
// - bug fix: выливались лишние символы из \field
//
// Revision 1.55  2002/08/01 10:26:09  narry
// - bug fix: обработка картинок и разрывов
//
// Revision 1.54  2002/07/30 15:58:16  narry
// - new behavior: поддержка Strikeout
//
// Revision 1.53  2002/07/03 09:00:57  narry
// - update, cleanup и new behavior
//
// Revision 1.52.2.1  2002/07/02 14:30:45  narry
// - alpha release
//
// Revision 1.52  2002/06/05 13:22:59  narry
// - update: начало реализации поддержки полей
//
// Revision 1.51  2002/04/23 08:02:59  narry
// - update
//
// Revision 1.50  2001/11/22 13:58:43  narry
// - update : начало реализации Групп доступа
//
// Revision 1.49  2001/10/15 08:21:26  narry
// - new behavior: добавление "." в начало сегмента, оформленного superscript
//
// Revision 1.48  2001/10/08 11:24:28  narry
// - bug fix: отсутствие проверки на Nil объекта перед вызовом его свойств
//
// Revision 1.47  2001/09/12 14:46:10  narry
// - bug fix: чтение сегментов в Lite режиме
//
// Revision 1.46  2001/08/29 07:01:06  law
// - split unit: l3Intf -> l3BaseStream, l3BaseDraw, l3InterfacedComponent.
//
// Revision 1.45  2001/06/27 13:30:10  narry
// -bug fix: при наличие в документе полей, после его закрытия оставались
//         неосвобожденные объекты
//
// Revision 1.44  2001/06/04 13:57:23  narry
// - bug fix - контроль закрытия таблицы приводил к вызову лишнего Finish
//
// Revision 1.43  2001/06/04 13:02:56  narry
// -bug fix - контроль закрытия таблицы по окончании документ
//
// Revision 1.42  2001/05/31 15:18:25  narry
// Update - отключено добавление рамки к таблице
//
// Revision 1.41  2001/05/31 11:49:16  narry
// Update - выливка рамки для таблицы
//
// Revision 1.40  2001/05/31 10:40:57  narry
// Update - присвоение рамки первой строки всей таблице
//
// Revision 1.39  2001/05/29 12:47:53  narry
// Update - контроль валидности стиля только по его имени
//
// Revision 1.38  2001/05/28 15:36:46  narry
// Update - чтение уникодного текст
//
// Revision 1.37  2001/05/16 10:49:00  narry
// Update - ошибка присвоения параметров раздел
//
// Revision 1.36  2001/05/10 14:20:49  narry
// Update - чтение параметров раздел
//
// Revision 1.35  2001/04/27 09:21:51  narry
// Update - обработка стилей Эверест
//
// Revision 1.34  2001/04/25 07:18:02  narry
// Update - очередная итерация по записи-чтению стилей Эверест в РТФ
//
// Revision 1.33  2001/04/12 12:58:49  narry
// Update - запись-чтение внутренних стилей в ртф
//
// Revision 1.32  2001/04/11 12:29:58  narry
// Update - восстановлено автоматическое проставление стилей при чтении из RTF
//
// Revision 1.31  2001/04/09 14:03:59  narry
// update - несколько расширена поддержка уникодного текста
// при чтении RTF-файлов. Одновременно с этим временно отключено
// автоматическое распознавание стилей
//
// Revision 1.30  2001/03/15 12:12:44  narry
// Исправлено чтение картинок из RTF в режиме Lite
//
// Revision 1.29  2001/02/27 09:01:57  narry
// Fix - add empty paragraph in table cell
//
// Revision 1.28  2001/01/29 07:55:10  narry
// fix - lost paragraphs on section (page) break
//
// Revision 1.27  2001/01/25 14:45:08  narry
// Add section break parameters
//
// Revision 1.26  2001/01/25 12:08:11  narry
// Fix   - possible lost text
// Add - simple read section break
//
// Revision 1.25  2001/01/25 09:08:06  narry
// Fix - wrong page width, lost character format
// Add - write page break
//
// Revision 1.24  2001/01/19 12:26:03  narry
// Fix trouble with broken documents
//
// Revision 1.23  2001/01/18 12:58:07  narry
// dead tables fix
//
// Revision 1.22  2001/01/17 14:26:15  narry
// Bug fix with tables - unnecesssary paragraphs and format
//
// Revision 1.21  2000/12/18 11:40:09  narry
// small bug fix with picture
//
// Revision 1.20  2000/12/15 15:29:55  law
// - вставлены директивы Log и Id.
//

{$I ddDefine.inc }
{$DEFINE SaveTableProperty}

interface


Uses
  Classes,
  Graphics,

  k2TagGen,
  k2Interfaces,

  l3Base,
  l3Types,
  l3Memory,
  l3StringList,
  l3Interfaces,
  l3ObjectRefList,
  l3ProtoPersistentRefList,

  rtfListTable,
  
  RTFTypes,
  
  ddBase,
  ddBorder,
  destNorm,
  ddPicture,
  ddRTFState,
  ddLowLevelRTF,                                                
  ddRowProperty,
  ddRTFKeywords,
  ddDocumentAtom,
  ddRTFProperties,
  ddRTFDestination,
  ddCustomRTFReader,
  ddSectionProperty,
  ddDocumentProperty,
  ddCharacterProperty,
  ddParagraphProperty;

type
 TddRTFReader = class(TddCustomRTFReader)
 private
  f_Destinations  : array [TRDS] of TddRTFDestination;
  f_DocIsDone     : Bool;
  f_DOP           : TddDocumentProperty;
  f_ListTable     : TrtfListTable;
  f_SkipNextGroup : Boolean;
  f_States        : TrtfStateStack;
 private
  procedure ApplyToDOP(What: Tiprop; Value: Longint);
  function pm_GetSEP: TddSectionProperty;
  function pm_GetSkipGroup: Boolean;
  function pm_GetState: TddRTFState;
  procedure pm_SetSEP(const Value: TddSectionProperty);
  procedure StartSkipGroup;
  procedure StopSkipGroup;
  function CheckUnicodeChar(aParam: Long): Boolean;
  function CheckRTF: Boolean;
  procedure CheckPitureGroup(aNewRDS: TRDS);
 protected
  function GetdestNormClass: RdestNorm; virtual;
  procedure DoReadData; override;
  procedure PushState; override;
  procedure AddKeyword(aKeyword: TSYM; aHasParam: Boolean; aParam: Long; aText: Tl3String = nil);
      override;
  procedure AddText(aText: AnsiChar); overload;  override;
  procedure AddText(aText: Tl3String); overload;  override;
  procedure AddText(aText: Word); overload;  override;
  procedure ChangeDest(aNewRDS: TRDS);
  procedure Cleanup; override;
  procedure PopState; override;
  procedure ecPopRtfState;
  procedure ecPushRtfState;
  function GetBOP: TddBorder;
  function GeTChP: TddCharacterProperty;
  function GetDestination(aRDS: TRDS): TddRTFDestination;
  function GetRDS: TRDS;
      {-}
  procedure OpenStream; override;
  procedure ParseProperty(propType: TPropType; What: Tiprop; Value: Longint);
  procedure ParseSymbol(Symbol: Long; propType: TPropType);
  procedure SetBOP(Value: TddBorder);
  procedure SeTChP(Value: TddCharacterProperty);
  procedure SeTPaP(Value: TddParagraphProperty);
  procedure SetRDS(Value: TRDS);
  procedure SetTAP(Value: TddRowProperty);
  procedure TranslateKeyword(aKeyword: TSYM; aHasParam: Boolean; aParam: Long);
  procedure Write2Generator;
  property BOP : TddBorder
    read GetBOP write SetBOP;
  property CHP : TddCharacterProperty
    read GeTCHP write SeTChP;
  property Destination[aRDS: TRDS]: TddRTFDestination
    read GetDestination;
  property RDS: TRds
    read GetRDS write SetRDS;
  property SEP: TddSectionProperty read pm_GetSEP write pm_SetSEP;
 public
  procedure AddFooterHyperlink; override;
  procedure FootNoteSymbol; override;
  procedure BeforeClosePara(const aPara: TddDocumentAtom; var aNewStyle: Integer); override;
  constructor Create(aOwner: Tk2TagGeneratorOwner); override;
  function ColorByIndex(anIndex: Longint): TColor; override;
  function GetFonts(anID: Integer): TddFontEntry; override;
  function ListByID(aID: Integer; out aWasRestarted: Boolean): TrtfList; override;
  function StyleByNumber(aNumber: Integer): TddStyleEntry; override;
  procedure Read; override;
  property DOP: TddDocumentProperty read f_DOP write f_DOP;
  property SkipGroup: Boolean read pm_GetSkipGroup;
  property State: TddRTFState read pm_GetState;
 end;


implementation

Uses
  SysUtils, Forms, 

  l3Math,
  l3Chars,
  l3String,
  l3StringEx,

  afwFacade,

  k2Tags,

  evConst,
  evSegLst,

  evdStyles,

  ddConst,

  destShp,
  destSkip,
  destList,
  destPicture,
  destlfolevel,
  destBookmark,
  destShapeTxt,
  destFootnote,
  destShapeRslt,
  destShapeInst,
  destListLevel,
  destFontTable,
  destLevelText,
  destListTable,
  destColorTable,
  destStyleSheet,
  destWord6Number,
  destListoverride,
  destWrite2Parent,
  destListOverrideTable,

 {$IFDEF InisiderTest}
 ddPicturePathListner,
 {$ENDIF InisiderTest}

  ddRTFConst

  {$IfNDef l3ConsoleApp},Dialogs{$ENDIF}
  , StrUtils, Windows,

  Document_Const,
  Table_Const,
  TextPara_Const,
  TypInfo,
  l3ObjectRefList1,
  Math,
  k2Prim,

  ddUtils,
  dd_rtfFields,
  ddTextParagraph,
  ddTextSegment;

const
 cnDefaultUC = 1;

resourcestring
 SRTFBadStruct = 'Нарушена структура файла';

constructor TddRTFReader.Create(aOwner: Tk2TagGeneratorOwner);
begin
 inherited;
 f_ListTable:= TrtfListTable.make;
 l3FillChar(f_Destinations, SizeOf(f_Destinations), 0);
 f_DOP := TddDocumentProperty.Create;
 f_States := TrtfStateStack.Make;
 f_States.Push(cnDefaultUC);
end;

procedure TddRTFReader.PushState;
begin
 if not f_DocIsDone then
 begin
  ecPushRTFState;
  if f_SkipNextGroup then
  begin
   StartSkipGroup;
   f_SkipNextGroup:= False;
  end;
 end;
end;

procedure TddRTFReader.AddKeyword(aKeyword: TSYM; aHasParam: Boolean; aParam: Long; aText:
    Tl3String = nil);
begin
 if not f_DocIsDone then
 begin
  if (RDS = rdsSkip) then
   //  пропускаем всю группу
   StartSkipGroup
  else
   TranslateKeyword(aKeyword, aHasParam, aParam);
 end;
end;

procedure TddRTFReader.AddText(aText: AnsiChar);
begin
 if not SkipGroup then
 begin
  Destination[RDS].AddAnsiChar(aText, State);
  ReadHexData := RDS = rdsPicture;
 end; // if not SkipGroup then
end;

procedure TddRTFReader.AddText(aText: Tl3String);
begin
 if not SkipGroup then
 begin
  Destination[RDS].AddString(aText, State);
  ReadHexData := RDS = rdsPicture;
 end; // if not SkipGroup then
end;

procedure TddRTFReader.AddText(aText: Word);
begin
 if not SkipGroup then
  Destination[RDS].AddUnicodeChar(aText, State);
end;

procedure TddRTFReader.ApplyToDOP(What: Tiprop; Value: Longint);
var
 l_State: TddRTFState;
begin
 with DOP do
 begin
  case What of
   iproPAnsiCharSet: CharSet:= TrtfCharacterSet(Value);
   ipropCodePage: CodePage:= Value;
   ipropWidth: xaPage:= Value;
   ipropHeight: YaPage:= Value;
   ipropLeft: xaLeft:= Value;
   ipropRight: xaRight:= Value;
   ipropTop: yaTop:= Value;
   ipropBottom: yaBottom:= Value;
   ipropDefLang: Deflang:= Value;
   ipropDefFont: DefFont:= Value;
   ipropDefTab: DefTab:= Value;
   ipropUC: begin
             l_State := State;
             Assert(l_State <> nil);
             l_State.UC := Value;
            end;
  end;
 end;
end;

procedure TddRTFReader.ChangeDest(aNewRDS: TRDS);
begin
 Status := ecOk;

 if SkipGroup then
  if (aNewRDS <> rdsSkip) then
   StopSkipGroup
  else
   if (aNewRDS = rdsSkip) then
    StartSkipGroup;
 CheckPitureGroup(aNewRDS);
 if ((RDS = rdsStyleSheet) and (aNewRDS = rdsSkip)) then
  StopSkipGroup
 else
  RDS := aNewRDS;
end;

procedure TddRTFReader.Cleanup;
var
 i: TRDS;
begin
 for i:= Low(TRDS) to High(TRDS) do
  FreeAndNil(f_Destinations[i]);
 FreeAndNil(f_DOP);
 FreeAndNil(f_States);
 FreeAndNil(f_ListTable);
 NextFootnoteNumber := 0;
 inherited;
end;

procedure TddRTFReader.PopState;
begin
 if not f_DocIsDone then
  ecPopRTFState;
end;

function TddRTFReader.ColorByIndex(anIndex: Longint): TColor;
begin
 Result:= TdestColorTable(Destination[rdsColorTable]).ColorByIndex(anIndex);
end;

procedure TddRTFReader.ecPopRtfState;
{ Закончилась текущая группа, выпихиваем предыдущее состояние из стека }
var
 l_State   : TddRTFState;
 l_OldRDS  : TRDS;
 l_NewRDS  : TRDS;
 l_OldDest : TddRTFDestination;
 l_NewDest : TddRTFDestination;
begin
 l_OldRDS:= RDS;
 l_OldDest:= Destination[l_OldRDS];
 l_State := f_States.PeekPrev;
 if l_State = nil then
  l_NewRDS := rdsNone
 else
  l_NewRDS := l_State.RDS;
 l_NewDest := Destination[l_NewRDS];
 l_OldDest.Close(State, l_NewDest);
 if l_OldDest is TdestNorm then
  TdestNorm(l_OldDest).AfterClose(l_NewDest, State, CHP);
  { Переключение на новый RDS }
 f_States.Pop;
 if (l_OldRDS = rdsNorm) and (RDS = rdsNone) then {  Последняя закрывающая скобка - далее в файле лежит мусор }
  f_DocIsDone := True;
 ReadHexData := RDS = rdsPicture;
 SkipHexData := ReadHexData and (LiteVersion and not EnablePictures);
end;

procedure TddRTFReader.ecPushRtfState;
  { Началась новая группа, запихиваем текущее состояние в стек }
begin
 f_States.Push(cnDefaultUC);

 if (RDS = rdsStyleSheet) then
  TdestStyleSheet(Destination[rdsStyleSheet]).AddStyle;
 ReadHexData := RDS = rdsPicture;
 SkipHexData := ReadHexData and (LiteVersion and not EnablePictures);
end;

function TddRTFReader.GetBOP: TddBorder;
begin
 Result := State.BOP;
end;

function TddRTFReader.GeTChP: TddCharacterProperty;
begin
 Result := State.CHP;
end;

function TddRTFReader.GetDestination(aRDS: TRDS): TddRTFDestination;
var
 l_Shp      : TdestShp;
 l_Dest     : TddRTFDestination;
 l_ShpInst  : TdestShapeInst;
 l_DestField: TdestField;
begin
 Result:= f_Destinations[aRDS];
 if Result = nil then
 begin
  case aRDS of
   rdsFalt  : l_Dest:= TdestWrite2Parent.Create(Self, GetDestination(rdsFontTable));
   rdsPanose: l_Dest:= TdestWrite2Parent.Create(Self, GetDestination(rdsFontTable));
   rdsFontTable: l_Dest:= TdestFontTable.Create(Self);
   rdsStyleSheet: l_Dest:= TdestStyleSheet.Create(Self);
   rdsFootnote: l_Dest:= TdestFootnote.Create(Self);
   rdsShpInst: begin
                l_Dest := TdestShapeInst.Create(Self);
                l_Shp := TdestShp(f_Destinations[rdsShp]);
                if l_Shp = nil then // {Requestlink:573678077}. Если Shp не был создан, то не факт, что нам такой Shp нужен. Например, может быть начата shpgrp...
                 l_Shp := TdestShp(f_Destinations[rdsShpGrp]);
                l_Shp.ShapeInst := TdestShapeInst(l_Dest);
               end;
   rdsShp : begin
             l_Dest := TdestShp.Create(Self);
             TdestShp(l_Dest).Norm := Destination[rdsNorm] as TdestNorm;
             l_ShpInst := TdestShapeInst(f_Destinations[rdsShpInst]);
             if l_ShpInst <> nil then
              TdestShp(l_Dest).ShapeInst := l_ShpInst;
            end;
   rdsShpGrp : begin
             l_Dest := TdestShp.Create(Self);
             TdestShp(l_Dest).Norm := Destination[rdsNorm] as TdestNorm;
            end;
   rdsShpTxt : begin
                l_Dest := TdestShapeTxt.Create(Self);
                l_Shp := TdestShp(f_Destinations[rdsShp]);
                Assert(l_Shp <> nil);
                l_Shp.ShapeTxt := TdestShapeTxt(l_Dest);
               end;
   rdsShpRslt : begin
                l_Dest := TdestShapeRslt.Create(Self);
                l_Shp := TdestShp(f_Destinations[rdsShp]);
                if l_Shp <> nil then
                 l_Shp.ShapeRslt := TdestShapeRslt(l_Dest);
                l_Shp := TdestShp(f_Destinations[rdsShpGrp]);
                if l_Shp <> nil then
                 l_Shp.ShapeRslt := TdestShapeRslt(l_Dest);
               end;
   rdsBookmarkStart: if ReadURL then // Закладки читаем только при чтении URL'ов.
                      l_Dest := TdestBookmark.Create(Self)
                     else
                      l_Dest := TdestSkip.Create(Self); 
   rdsNorm: l_Dest := GetdestNormClass.Create(Self);
   rdsColorTable: l_Dest := TdestColorTable.Create(Self);
   rdsPicture: l_Dest := TdestPicture.Create(Self);
   rdsListTable: l_Dest := TdestListTable.Create(Self);
   rdsList: l_Dest := TdestList.Create(Self);
   rdsListLevel: l_Dest := TdestListLevel.Create(Self);
   rdsLevelText: l_Dest := TdestLevelText.Create(Self);
   rdsListOverride: l_Dest := TdestListoverride.Create(Self);
   rdsLFOlevel: l_Dest := Tdestlfolevel.Create(Self, TdestListoverride(GetDestination(rdsListOverride)));
   rdslistoverridetable: l_Dest := TdestListOverrideTable.Create(Self, TdestListTable(GetDestination(rdsListTable)));
   rdsField: l_Dest := TdestField.Create(Self);
   rdsFieldInstruction: begin
                         l_Dest := TdestFieldInstruction.Create(Self);
                         l_DestField := GetDestination(rdsField) as TdestField;
                         l_DestField.FielsInsruction := l_Dest as TdestFieldInstruction;
                        end;
   rdsFieldResult: begin
                    l_Dest := TdestFieldResult.Create(Self);
                    l_DestField := GetDestination(rdsField) as TdestField;
                    l_DestField.FieldResult := l_Dest as TdestFieldResult;
                   end;
   rdsFormField: begin
                  l_Dest := TdestFormField.Create(Self);
                  l_DestField := GetDestination(rdsField) as TdestField;
                  l_DestField.FormField := l_Dest as TdestFormField;
                 end;
   rdsFormFieldItem: l_Dest := TdestFormFieldItem.Create(Self);
   rdsOldParaNumbering: l_Dest := TdestWord6Number.Create(Self);
  else
   l_Dest := TdestSkip.Create(Self);
  end; //case RDS
  l_Dest.RDS:= aRDS;
  f_Destinations[aRDS] := l_Dest;
  Result:= l_Dest;
 end; // Result = nil
end;

function TddRTFReader.GetRDS: TRDS;
begin
 Assert(State <> nil, 'Нет открытых тегов!');
 Result := State.RDS;
end;

function TddRTFReader.ListByID(aID: Integer; out aWasRestarted: Boolean): TrtfList;
begin
 //Сюда приходит номер в ListOverrideTale, по нему нужно получить реальный номер списка
 Result := TdestListOverrideTable(Destination[rdsListOverrideTable]).LS2List(aID, aWasRestarted);
end;

procedure TddRTFReader.OpenStream;
  {override;}
  {-}
begin
 inherited;
 f_DocIsDone:= False;
end;

procedure TddRTFReader.ParseProperty(propType: TPropType; What: Tiprop; Value: Longint);
begin
 { Всякие разные свойства }
 if propType = propDop then
  ApplyToDOP(What, Value)
 else
  Destination[RDS].ApplyProperty(propType, What, Value, State);
 if (propType = propPict) and (What = ipropSkipPicture) then
  SkipPicture := True;
end;

procedure TddRTFReader.ParseSymbol(Symbol: Long; propType: TPropType);
begin
 if (Symbol = Ord(rdsSkipGroup)) then
  //  пропускаем всю группу
  StartSkipGroup
 else
  Destination[RDS].ParseSymbol(Symbol, propType, State);
end;

function TddRTFReader.GetFonts(anID: Integer): TddFontEntry;
begin
 Result:= TdestFontTable(Destination[rdsFontTable]).FontByNumber(anID);
end;

function TddRTFReader.pm_GetSEP: TddSectionProperty;
begin
 // TODO -cMM: TddRTFReader.pm_GetSEP default body inserted
 Result := nil;
end;

function TddRTFReader.pm_GetSkipGroup: Boolean;
begin
 Result := State.SkipGroup or f_DocIsDone;
end;

function TddRTFReader.pm_GetState: TddRTFState;
begin
 Result := f_States.Peek;
end;

procedure TddRTFReader.pm_SetSEP(const Value: TddSectionProperty);
begin
 // TODO -cMM: TddRTFReader.pm_SetSEP default body inserted
end;

procedure TddRTFReader.Read;

 procedure lp_Write2Log;
 begin
 {$IFDEF Write2Log}
  l3System.Str2Log(Format('Error reading RTF with code: %d', [Ord(Status)]));
 {$ENDIF}
 end;

var
 l_Index: TRDS;
begin
 RDS := rdsNone;
 for l_Index := Low(TRDS) to High(TRDS) do
  FreeAndNil(f_Destinations[l_Index]);
 NextFootnoteNumber := 0;
 f_DocIsDone := False;
 inherited;
 if Status = ecOk then
  Write2Generator
 else
  if Status = ecEndOfFile then
   if CheckRTF then
    Write2Generator
   else
    lp_Write2Log
  else
   lp_Write2Log;
end;

procedure TddRTFReader.SetBOP(Value: TddBorder);
begin
  State.BOP:= Value;
end;

procedure TddRTFReader.SetChP(Value: TddCharacterProperty);
begin
 State.CHP:= Value;
end;

procedure TddRTFReader.SetPAP(Value: TddPAragraphProperty);
begin
  State.PAP:= Value;
end;

procedure TddRTFReader.SetRDS(Value: TRDS);
begin
 State.RDS:= Value;
end;

procedure TddRTFReader.SetTAP(Value: TddRowProperty);
begin
 State.TAP:= Value;
end;

procedure TddRTFReader.StartSkipGroup;
begin
 State.SkipGroup:= True;
end;

procedure TddRTFReader.StopSkipGroup;
begin
 State.SkipGroup:= False;
end;

function TddRTFReader.StyleByNumber(aNumber: Integer): TddStyleEntry;
begin
 Result := TdestStyleSheet(Destination[rdsStyleSheet]).StyleByNumber(aNumber);
end;

procedure TddRTFReader.TranslateKeyword(aKeyword: TSYM; aHasParam: Boolean; aParam: Long);
var
 l_RDS        : TRDS;
 l_Dest       : TddRTFDestination;
 l_Enable     : Boolean;
 l_UnicodeSymb: Word;
begin
 if not f_DocIsDone then
 begin
  l_Dest := Destination[RDS];
  if not SkipNext then
  begin
   if (aKeyword.StringID <> valu_Hex) and (aKeyword.StringID <> valu_u) then
    l_Dest.FlushBuffer(State);
   case aKeyword.Kwd of
     kwdFlag: begin
               if aKeyword.propType = propPict then
                ParseProperty(aKeyword.propType, aKeyword.What, aKeyword.Value)
               else
                ParseProperty(aKeyword.propType, aKeyword.What, aKeyword.Value);
              end;
     kwdDest: begin
               l_RDS := TRDS(aKeyword.Value);
               ChangeDest(l_RDS);
              end;
     kwdSymb: ParseSymbol(aKeyword.Value, aKeyword.propType);
     kwdTogg: begin
                l_Enable:= (not aHasParam) or (aHasParam and (aParam <> 0));
                ParseProperty(aKeyword.propType, aKeyword.What, Ord(l_Enable));
              end;{kwdTogg}
     kwdValu:
       begin
         if aKeyword.StringID = valu_Hex then
           AddText(AnsiChar(aParam))
         else
         if aKeyword.StringID = valu_u then
         begin
          l_UnicodeSymb := Word(SmallInt(aParam)); // Отрицательные значения преобразуем в положительные...
          if not CheckUnicodeChar(l_UnicodeSymb) then
           AddText(l_UnicodeSymb);
          SkipChars(State.UC);
         end // if aKeyword.StringID = valu_u then
         else
         begin
          if (aKeyword.StringID = valu_cs) and SkipGroup then // http://mdp.garant.ru/pages/viewpage.action?pageId=138969449
           if RDS <> rdsStyleSheet then
            StopSkipGroup;
          ParseProperty(aKeyword.propType, aKeyword.What, aParam);
         end;
       end;
   end; { case }
  end
  else
   DecSkipCount;
 end;
end;

procedure TddRTFReader.Write2Generator;
var
 l_Dest: TdestNorm;
begin
 Generator.StartChild(k2_typDocument);
 try
   { Неплохо было бы вылить какие-нибудь параметры документа - размер бумаги,
     информацию и тд. и тп. }
    { TODO : Восстановить (перенести в TdestNorm) }
  if not LiteVersion then
  begin
   Generator.AddIntegerAtom(k2_tiWidth, l3MulDiv(DOP.xaPage, evInchMul, rtfTwip));
   Generator.AddIntegerAtom(k2_tiLeftIndent, l3MulDiv(DOP.xaLeft, evInchMul, rtfTwip));
   Generator.AddIntegerAtom(k2_tiRightIndent, l3MulDiv(DOP.xaRight, evInchMul, rtfTwip));
   // Нужно вылить таблицу стилей?
  end;

  l_Dest := TdestNorm(Destination[rdsNorm]);
  if l_Dest <> nil then
  begin
   l_Dest.CheckBeforeWrite(State);
   l_Dest.Write(Generator);
  end; // if l_Dest <> nil then

  l_Dest := TdestNorm(Destination[rdsFootnote]);
  if (l_Dest <> nil) and (l_Dest.GetParagraphsCount > 0) then
   l_Dest.Write(Generator);
 finally
  Generator.Finish;
 end;
end;

function TddRTFReader.CheckUnicodeChar(aParam: Long): Boolean;
var
 l_Char: AnsiChar;
begin
 l_Char := ddUnicode2Char(aParam);
 Result := l_Char <> #0;
 if Result then
  AddText(l_Char);
end;

procedure TddRTFReader.BeforeClosePara(const aPara: TddDocumentAtom; var aNewStyle: Integer);
begin
 // Здесь можно добавить предобработку параграфа...
end;

procedure TddRTFReader.DoReadData;
begin
 if Destination[RDS].ReadData then
  ReadHexData := False;
end;

function TddRTFReader.CheckRTF: Boolean;
var
 l_LastAtom: TddDocumentAtom;
begin
 l_LastAtom := TdestNorm(Destination[rdsNorm]).LastAtom;
 Result := l_LastAtom <> nil;
 if Result then
  Result := l_LastAtom.Closed;
end;

procedure TddRTFReader.CheckPitureGroup(aNewRDS: TRDS);
begin
 if (RDS = rdsSV) and (aNewRDS = rdsPicture) then // http://mdp.garant.ru/pages/viewpage.action?pageId=606634250
 begin
  f_States.PeekPrev.RDS := rdsShpRslt;
  GetDestination(rdsShpRslt);
 end; // if (RDS = rdsSV) and (aNewRDS = rdsPicture) then
end;

procedure TddRTFReader.AddFooterHyperlink;
begin
 TdestNorm(Destination[rdsNorm]).AddFooterHyperlink(State);
end;

procedure TddRTFReader.FootNoteSymbol;
begin
 TdestFootnote(Destination[rdsFootnote]).FootNoteSymbol;
end;

function TddRTFReader.GetdestNormClass: RdestNorm;
begin
 Result := TdestNorm;
end;

end.

