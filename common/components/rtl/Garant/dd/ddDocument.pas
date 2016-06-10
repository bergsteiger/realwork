//..........................................................................................................................................................................................................................................................
unit ddDocument;

{ Базовый класс для сохранения в различные форматы }

// $Id: ddDocument.pas,v 1.319 2016/05/24 12:22:57 dinishev Exp $

// $Log: ddDocument.pas,v $
// Revision 1.319  2016/05/24 12:22:57  dinishev
// Рамки во вложенных таблицах неправильно определялись.
//
// Revision 1.318  2016/05/20 08:42:59  dinishev
// Переименовал TddRowType в TddTableType.
//
// Revision 1.317  2016/05/20 06:41:51  dinishev
// Лишние поля.
//
// Revision 1.316  2016/05/06 11:51:02  dinishev
// {Requestlink:617082437}. Накопилось...
//
// Revision 1.315  2016/03/24 12:05:47  dinishev
// Cleanup
//
// Revision 1.314  2016/02/16 09:24:19  dinishev
// {Requestlink:617777252}
//
// Revision 1.313  2016/02/12 11:41:44  dinishev
// Reformat
//
// Revision 1.312  2016/02/11 14:25:55  dinishev
// {Requestlink:617312775}
//
// Revision 1.311  2016/01/27 13:47:10  dinishev
// Разборки с отъехавшими HTML-тестами после правок.
//
// Revision 1.310  2016/01/26 10:51:36  dinishev
// Лечим AV.
//
// Revision 1.309  2016/01/19 10:36:29  dinishev
// {Requestlink:615706665}. Не поддерживалось больше одного уровня вложенности таблиц.
//
// Revision 1.308  2016/01/15 11:52:48  dinishev
// {Requestlink:615706665}. Не учитывали, что ячейка может быть еще и не начата.
//
// Revision 1.307  2015/10/21 14:02:13  voba
// -bf : Дими Инишев поправил выливку в HTML
//
// Revision 1.306  2015/09/17 10:03:23  dinishev
// {Requestlink:606817234}
//
// Revision 1.305  2015/09/04 12:46:02  dinishev
// {Requestlink:606436730}
//
// Revision 1.304  2015/09/04 10:37:57  dinishev
// Reformat
//
// Revision 1.303  2015/08/28 08:14:47  dinishev
// {Requestlink:606129464}
//
// Revision 1.302  2015/08/04 11:51:59  dinishev
// Bug fix: посеял инициализацию поля.
//
// Revision 1.301  2015/08/04 11:34:01  dinishev
// Bug fix: AV при экспорте.
//
// Revision 1.300  2015/08/04 11:29:21  dinishev
// {Requestlink:602505046}. Вложенные отступы.
//
// Revision 1.299  2015/08/04 10:14:49  dinishev
// {Requestlink:602505046}. Отступы.
//
// Revision 1.298  2015/08/04 09:25:15  dinishev
// Reformat
//
// Revision 1.297  2015/08/04 09:22:04  dinishev
// Reformat
//
// Revision 1.296  2015/08/03 16:16:53  dinishev
// {Requestlink:602505046}. Отступы.
//
// Revision 1.295  2015/07/31 15:27:21  dinishev
// {Requestlink:602505046}. Реагируем на свернутость блока при выливке.
//
// Revision 1.294  2015/07/31 11:10:13  dinishev
// {Requestlink:602505046}. Экспорт стиля.
//
// Revision 1.293  2015/06/30 13:31:25  dinishev
// {Requestlink:602704271}
//
// Revision 1.292  2015/06/05 14:33:36  dinishev
// Убрал константу.
//
// Revision 1.291  2015/06/05 09:14:36  dinishev
// {Requestlink:600653825}
//
// Revision 1.290  2015/05/15 11:32:41  dinishev
// Cleanup
//
// Revision 1.289  2015/05/07 14:22:20  dinishev
// {Requestlink:598615356}
//
// Revision 1.288  2015/03/25 10:54:03  dinishev
// {Requestlink:592251812}
//
// Revision 1.287  2015/02/24 14:55:30  dinishev
// {Requestlink:589529446}. Правки по результатам тестов.
//
// Revision 1.286  2015/02/24 14:07:28  dinishev
// {Requestlink:589529446}
//
// Revision 1.285  2015/02/13 12:45:32  dinishev
// {Requestlink:571653012}
//
// Revision 1.284  2015/02/10 13:21:10  dinishev
// {Requestlink:588037744}
//
// Revision 1.283  2014/12/29 11:15:54  dinishev
// {Requestlink:585940757}
//
// Revision 1.282  2014/09/26 11:28:58  dinishev
// {Requestlink:565502288}
//
// Revision 1.281  2014/09/15 09:55:54  dinishev
// {Requestlink:565008971}
//
// Revision 1.280  2014/07/15 12:29:53  dinishev
// {Requestlink:553919980}. Правим кривизну в LibreOffice.
//
// Revision 1.279  2014/07/15 06:03:40  dinishev
// {Requestlink:553919980}. Прячем невидимые линии для LibreOffice, на сколько это возможно.
//
// Revision 1.278  2014/07/14 06:10:39  dinishev
// Reformat
//
// Revision 1.276  2014/07/11 13:48:26  dinishev
// Reformat
//
// Revision 1.275  2014/07/11 13:46:13  dinishev
// Reformat
//
// Revision 1.274  2014/07/11 13:44:00  dinishev
// Reformat
//
// Revision 1.273  2014/07/11 13:19:29  dinishev
// Reformat
//
// Revision 1.272  2014/07/11 11:01:38  dinishev
// {Requestlink:553914086}. Правка по горячим следам - получались испорченные rtf.
//
// Revision 1.271  2014/07/08 09:11:45  dinishev
// {Requestlink:552601541}
//
// Revision 1.270  2014/07/02 12:01:30  dinishev
// {Requestlink:390585479}. Общие отступы для одинаковых стилей, правильное оформление стиля 'Формула'
//
// Revision 1.269  2014/07/02 06:40:05  dinishev
// {Requestlink:390585479}
//
// Revision 1.268  2014/07/01 13:22:50  dinishev
// {Requestlink:390585479}
//
// Revision 1.267  2014/07/01 05:30:37  dinishev
// {Requestlink:390585479}
//
// Revision 1.266  2014/06/25 14:19:48  lulin
// - делаем регистрацию атрибутов в отдельном списке.
//
// Revision 1.265  2014/06/24 14:53:37  lulin
// - делаем регистрацию атрибутов в отдельном списке.
//
// Revision 1.264  2014/04/25 07:46:26  dinishev
// Чистка кода.
//
// Revision 1.263  2014/04/24 14:07:29  dinishev
// {Requestlink:529957499}
//
// Revision 1.262  2014/04/24 13:17:05  dinishev
// {Requestlink:529957499}
//
// Revision 1.261  2014/04/22 10:56:19  lulin
// - прячем ненужный метод.
//
// Revision 1.260  2014/04/21 11:18:00  dinishev
// {Requestlink:530819607}
//
// Revision 1.259  2014/04/11 16:48:26  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.258  2014/04/08 17:13:30  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.257  2014/04/03 17:10:42  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.256  2014/03/27 14:20:10  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.255  2014/02/18 13:34:33  lulin
// - избавляемся от ненужного списка.
//
// Revision 1.254  2014/02/17 08:40:36  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.253  2014/02/14 15:33:53  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.252  2014/01/22 09:44:45  dinishev
// {Requestlink:512248597}. Теперь стиль тоже может получить рамку.
//
// Revision 1.251  2014/01/14 07:19:08  dinishev
// {Requestlink:509090464}
//
// Revision 1.250  2014/01/13 08:30:51  dinishev
// {Requestlink:510621098}. Финальные штрихи.
//
// Revision 1.249  2014/01/13 06:18:15  dinishev
// {Requestlink:510621098}. Перенос на модель.
//
// Revision 1.248  2014/01/10 11:14:36  dinishev
// {Requestlink:510621098}. Перенес TddCellProperty на модель.
//
// Revision 1.247  2013/12/25 15:10:39  lulin
// {RequestLink:509706011}
// - перетрясаем модель.
//
// Revision 1.246  2013/12/25 13:07:49  dinishev
// Отказ от _Tl3CBase и _Tl3ProtoPersistent
//
// Revision 1.245  2013/11/20 12:09:05  dinishev
// TddDocumentAtom перевел на более "простого" предка.
//
// Revision 1.244  2013/11/11 17:28:47  lulin
// - вычищаем ненужное.
//
// Revision 1.243  2013/10/28 10:07:58  lulin
// - готовимся к смене типа значения по-муоолчанию.
//
// Revision 1.242  2013/10/24 11:03:16  dinishev
// {Requestlink:483394869}
//
// Revision 1.241  2013/10/23 12:26:07  lulin
// - автоматически определяемые типы тоже генерируем с модели.
//
// Revision 1.240  2013/10/21 17:31:11  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.239  2013/10/21 15:43:16  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.238  2013/10/21 10:31:05  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.237  2013/10/18 14:11:37  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.236  2013/10/16 09:23:06  dinishev
// {Requestlink:493324121}
//
// Revision 1.235  2013/10/15 07:54:53  dinishev
// {Requestlink:482741433}. Финальные аккорды.
//
// Revision 1.234  2013/09/24 07:23:48  dinishev
// {Requestlink:484806284}
//
// Revision 1.233  2013/08/29 11:27:10  dinishev
// {Requestlink:480819960}
//
// Revision 1.232  2013/08/26 09:37:34  dinishev
// {Requestlink:479402974}
//
// Revision 1.231  2013/07/31 10:28:07  dinishev
// {Requestlink:474593822}
//
// Revision 1.230  2013/07/29 09:14:23  dinishev
// Bug fix; Испортил TddDocumentGenerator при правках TddDocument - там своя логика. :-(
//
// Revision 1.229  2013/07/25 09:53:16  dinishev
// {Requestlink:460279011}
//
// Revision 1.228  2013/07/22 12:49:15  dinishev
// {Requestlink:471770650}
//
// Revision 1.227  2013/07/19 13:55:41  dinishev
// {Requestlink:466752604}. Теперь текстовый параграф сам умеет проверять и выливать номер.
//
// Revision 1.226  2013/07/18 12:46:32  dinishev
// Вычищаем кучу неиспользованного кода.
//
// Revision 1.225  2013/07/16 11:11:17  dinishev
// {Requestlink:422512540}. Вычистил отстаки костылей.
//
// Revision 1.224  2013/07/15 09:06:40  dinishev
// {Requestlink:422512540}
//
// Revision 1.223  2013/07/12 12:59:52  dinishev
// {Requestlink:422512540}
//
// Revision 1.222  2013/07/12 12:34:13  dinishev
// {Requestlink:422512540}
//
// Revision 1.221  2013/07/12 06:37:05  dinishev
// Cleanup
//
// Revision 1.220  2013/07/11 10:38:31  dinishev
// Удаляем неработающий код.
//
// Revision 1.219  2013/05/22 11:17:40  dinishev
// {Requestlink:453178004}. Учим HTMLReader читать вложенные таблицы. Вроде получилось.
//
// Revision 1.218  2013/05/15 11:52:15  dinishev
// {Requestlink:453164226}. Пытаемся учитывать уровень параграфа.
//
// Revision 1.217  2013/05/14 11:13:19  dinishev
// {Requestlink:453164226}. Потихоньку переносим логику работы с таблицей из TdestNorm - не место ей там в TddTable.
//
// Revision 1.216  2013/05/06 12:37:11  dinishev
// Откатываем костыли и "рефакторинг" - отъехало чтение таблиц.
//
// Revision 1.215  2013/05/06 08:08:55  dinishev          
// Убрал еще одно свойство.
//
// Revision 1.214  2013/04/11 16:46:27  lulin
// - отлаживаем под XE3.
//
// Revision 1.213  2013/03/04 13:03:14  narry
// Уменьшается шрифт текста при экспорте в HTML (429695536)
//
// Revision 1.212  2013/02/27 08:34:43  narry
// Проблемы с кодировкой при открытии наших rtf на IPad (430746304)
//
// Revision 1.211  2013/02/15 05:56:54  narry
// Проблемы с кодировкой при открытии наших rtf на IPad (430746304)
//
// Revision 1.210  2013/01/25 13:13:36  narry
// Не устанавливается шрифт по имени (424386600)
//
// Revision 1.209  2013/01/24 06:55:32  narry
// Поддержка нумерованных абзацев (пока не работает)
//
// Revision 1.208  2013/01/22 12:19:52  narry
// Рефакторинг RTFReader
//
// Revision 1.206  2012/10/29 13:29:07  lulin
// - вычищаем поддержку ветки редактора.
//
// Revision 1.205  2012/08/15 09:13:41  narry
// Преформатированный текст экспортируется в Word 12 кеглем (379236513)
//
// Revision 1.204  2012/06/15 09:43:22  dinishev
// Bug fix: падали тесты.
//
// Revision 1.203  2012/03/26 11:02:45  narry
// В rtf странно экспортируются рисунки (312445572)
//
// Revision 1.202  2012/03/23 10:51:01  narry
// Сломался экспорт в Word (349128521)
//
// Revision 1.201  2012/03/21 13:21:29  lulin
// - bug fix: не компилировалось.
//
// Revision 1.200  2012/03/21 12:37:04  narry
// Изменённый цвет текста некорректно экспортируется в Word (344754072)
//
// Revision 1.199  2012/03/15 07:37:39  narry
// Изменённый цвет текста некорректно экспортируется в Word (344754072)
//
// Revision 1.198  2011/11/18 08:00:57  narry
// Формулы экспортируются без отступа внутри таблицы (235055757)
//
// Revision 1.197  2011/08/12 10:38:50  voba
// - не компилировалось со старым Эверестом
//
// Revision 1.196  2011/07/29 13:27:51  lulin
// {RequestLink:209585097}.
//
// Revision 1.195  2011/07/29 05:25:33  narry
// Таблицы со смешанными ширинами ячеек (276534804)
//
// Revision 1.194  2011/07/12 12:25:01  lulin
// {RequestLink:273591308}.
//
// Revision 1.193  2011/07/11 17:48:15  lulin
// {RequestLink:228688745}.
//
// Revision 1.192  2011/05/18 17:46:03  lulin
// {RequestLink:266409354}.
//
// Revision 1.191  2011/02/07 12:45:20  narry
// К253658596. Не собирается ddHTML_r
//
// Revision 1.190  2010/12/03 16:20:34  lulin
// [$245204883].
//
// Revision 1.189  2010/11/30 11:47:16  lulin
// {RequestLink:228688602}.
// - борьба с предупреждениями.
//
// Revision 1.188  2010/11/29 11:45:29  narry
// 235875772. Криво экспортируются новые таблицы
//
// Revision 1.187  2010/11/01 09:48:54  lulin
// {RequestLink:238421582}.
//
// Revision 1.186  2010/10/12 06:51:23  narry
// K208701604. Утилита сборки постановлений из html
//
// Revision 1.185  2010/09/29 08:45:13  narry
// K208208004. Класс для чтения атрибутов постановления из HTML-карточки
//
// Revision 1.184  2010/09/27 07:41:31  narry
// K235051401. Значения полей задавались текстом
//
// Revision 1.183  2010/09/27 05:54:56  narry
// K235057677. Перенос изменений из ветки (отсутствие отступа таблицы и стиля в таблице)
//
// Revision 1.172.2.5  2010/09/21 07:11:39  narry
// k235054056. Не учитывался отступ таблицы
//
// Revision 1.172.2.4  2010/09/20 15:32:51  narry
// k235052883. Неправильно рассчитывались отступы абзаца
//
// Revision 1.182  2010/09/20 15:18:02  narry
// k235052883. Неправильно рассчитывались отступы абзаца
//
// Revision 1.181  2010/09/16 10:52:52  narry
// k235050823. Неправильно выставлялся шрифт формулам
//
// Revision 1.180  2010/09/08 06:28:38  narry
// K234362214. Чистка от погашенных исключений
//
// Revision 1.179  2010/09/06 10:45:50  lulin
// {RequestLink:233735772}.
// - выводим исключение в лог. Чтобы проще искать было.
//
// Revision 1.178  2010/09/06 10:24:38  lulin
// {RequestLink:233735772}.
// - будем считать, что тесты ДОЛЖНЫ падать.
//
// Revision 1.177  2010/09/06 10:10:19  narry
// K228688401. Чистка лога от мусора, избавление от exception
//
// Revision 1.176  2010/09/03 16:42:23  lulin
// {RequestLink:233735772}.
// - нехрена исключения давить.
//
// Revision 1.175  2010/09/03 13:06:13  narry
// K234358608
//
// Revision 1.174  2010/09/03 12:59:23  narry
// K228688401
//
// Revision 1.173.2.4  2010/09/03 11:23:36  narry
// - промежуточное обновление
//
// Revision 1.173.2.3  2010/09/02 10:40:05  narry
// - промежуточное обновление
//
// Revision 1.173.2.2  2010/08/30 05:59:13  narry
// - промежуточное обновление
//
// Revision 1.173.2.1  2010/08/24 04:38:43  narry
// - промежуточное обновление
//
// Revision 1.173  2010/07/13 12:56:00  narry
// - К121164205
//
// Revision 1.171  2010/04/12 11:39:20  narry
// - масштаб таблицы
// - размер шрифта для печати
//
// Revision 1.170  2010/02/24 18:16:27  lulin
// - избавляемся от ненужного и вредного параметра, доставшегося в наследство от ошибок молодости.
//
// Revision 1.169  2010/02/19 13:34:07  narry
// - неверно вычислялась ширина таблицы для "резиновых" таблиц
//
// Revision 1.168  2010/02/16 06:08:11  narry
// - борьба с пустыми страницами
//
// Revision 1.167  2010/02/03 14:25:56  narry
// - сброс рамки объекта
//
// Revision 1.166  2009/11/13 08:50:58  narry
// - выключение рамок для подписей
//
// Revision 1.165  2009/07/23 13:42:39  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.164  2009/07/03 16:24:18  lulin
// - шаг к переходу от интерфейсов к объектам.
//
// Revision 1.163  2009/04/22 12:03:01  narry
// - сбивались отступы абзаца, примененные напрямую к абзацу
//
// Revision 1.162  2009/04/09 15:08:18  lulin
// [$140280550]. Выкидываем мусор.
//
// Revision 1.161  2009/03/05 17:23:54  lulin
// - <K>: 137470629. Для ветки тоже генерируем ссылки на теги.
//
// Revision 1.160  2009/03/04 13:33:06  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.159  2009/01/26 13:45:44  narry
// - пропускались targets для внутренних ссылок
//
// Revision 1.158  2008/06/26 07:51:23  lulin
// - bug fix: два раза писали картинку.
//
// Revision 1.157  2008/06/26 06:24:14  lulin
// - bug fix: не сохранялись картинки в сегментах.
//
// Revision 1.156  2008/06/25 14:47:55  lulin
// - сделана возможность использовать предопределённые значения для рамок.
//
// Revision 1.155  2008/06/20 14:49:11  lulin
// - используем префиксы элементов.
//
// Revision 1.154  2008/06/07 16:13:57  lulin
// - нарисовал константы на модели.
//
// Revision 1.153  2008/03/21 14:09:21  lulin
// - cleanup.
//
// Revision 1.152  2008/03/20 09:48:29  lulin
// - cleanup.
//
// Revision 1.151  2008/03/13 14:42:08  narry
// - рефакторинг
//
// Revision 1.150  2008/03/03 20:06:00  lulin
// - <K>: 85721135.
//
// Revision 1.149  2008/02/27 15:47:40  narry
// - изменение логики обработки внешних ссылок
//
// Revision 1.148  2008/02/22 09:06:37  lulin
// - упрощаем наследование.
//
// Revision 1.147  2008/02/20 17:22:58  lulin
// - упрощаем строки.
//
// Revision 1.146  2008/02/19 14:58:49  lulin
// - переводим сортировку списков на новые, менее виртуальные, рельсы.
//
// Revision 1.145  2008/02/12 12:53:15  lulin
// - избавляемся от излишнего метода на базовом классе.
//
// Revision 1.144  2008/02/07 14:44:37  lulin
// - класс _Tl3LongintList переехал в собственный модуль.
//
// Revision 1.143  2008/02/05 18:20:36  lulin
// - удалено ненужное свойство строк.
//
// Revision 1.142  2008/02/05 12:49:12  lulin
// - упрощаем базовые объекты.
//
// Revision 1.141  2008/02/05 09:57:59  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.140  2008/02/01 15:14:44  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.139  2008/01/31 20:09:55  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.138  2007/12/10 13:20:01  lulin
// - cleanup.
//
// Revision 1.137  2007/10/29 12:07:56  narry
// - Обновление
//
// Revision 1.136  2007/10/23 05:53:54  narry
// - поддержка экспорта формул. Пока только в RTF
//
// Revision 1.135  2007/09/22 15:36:55  lulin
// - bug fix: падали на сегментах с вложенными объектами (формулами).
//
// Revision 1.134  2007/09/03 12:29:09  lulin
// - переименовываем тег.
//
// Revision 1.133  2007/08/21 12:43:29  lulin
// - избавляемся от предупреждений компилятора.
//
// Revision 1.132  2007/08/09 18:05:21  lulin
// - избавляемся от излишнего использования интерфейсов, т.к. переносимость может быть достигнута другими методами.
//
// Revision 1.131  2007/08/09 11:19:17  lulin
// - cleanup.
//
// Revision 1.130  2007/07/20 06:04:52  oman
// Warning fix
//
// Revision 1.129  2007/07/18 15:07:28  lulin
// - выпрямляем зависимости. Схема документа, теперь не зависит от Эвереста.
//
// Revision 1.128  2007/07/03 16:52:09  lulin
// - тип табуляции переехал в общий модуль.
//
// Revision 1.127  2007/06/13 14:36:19  narry
// - ошибка чтения HTML-файлов
//
// Revision 1.126  2007/06/04 15:06:04  lulin
// - проверяем, что генератор не nil. Связано с <K>-16351268.
//
// Revision 1.125  2007/06/04 12:16:10  narry
// - неправильно экспортировался стиль "Нормальный"
//
// Revision 1.124  2007/03/14 15:14:03  narry
// - при преобразовании в RTF пропадали внутренние ссылки
//
// Revision 1.123  2007/02/27 09:55:00  lulin
// - cleanup.
//
// Revision 1.122  2007/01/30 11:35:58  narry
// - корректная передача оформления в RTF
//
// Revision 1.121  2007/01/29 11:37:00  narry
// - новый режим экспорта внешних ссылок - для документов из списка
//
// Revision 1.120  2006/12/29 13:09:25  lulin
// - реализуем интерфейс расширенного списка строк.
//
// Revision 1.119  2006/11/27 15:57:10  narry
// - экспорт в XML для nalog.ru
//
// Revision 1.118  2006/09/20 16:55:45  narry
// - масштабирование картинки по размеру страницы
//
// Revision 1.117  2006/09/19 11:33:33  narry
// - поддержка "резиновых" таблиц на уровне RTF
//
// Revision 1.116  2006/09/11 14:49:09  narry
// no message
//
// Revision 1.115  2006/09/05 15:52:22  narry
// - фигня с альбомной ориентацией
//
// Revision 1.114  2006/07/18 14:08:42  narry
// - исправление: не закрывались ссылки в оглавлении
//
// Revision 1.113  2006/05/06 13:37:09  narry
// - заточки под Прайм, починка таблиц
//
// Revision 1.112  2006/01/31 14:02:02  fireton
// - bug fix: _TddDocument.CorrectStyles - проверка StyleTable
//
// Revision 1.111  2005/12/26 10:19:24  narry
// - ошибка: неинициализированная переменная
//
// Revision 1.110  2005/12/22 08:26:01  narry
// - ошибка: AV при преобразовании текста в таблицу
//
// Revision 1.109  2005/12/13 11:42:22  narry
// - ошибка: лишний разрыв страницы
//
// Revision 1.108  2005/12/06 14:37:35  narry
// - ошибка: AV при обработке вложенных таблиц
// - заточка: обработка таблицы стилей
//
// Revision 1.107  2005/10/11 08:57:20  narry
// - исправление: неправильно форматировался абзац
//
// Revision 1.106  2005/10/04 09:19:56  lulin
// - new behavior: сделана возможность получать имя записываемго в поток файла.
//
// Revision 1.105  2005/10/03 14:05:43  narry
// - исправление: генерация имени файла картинки не включает путь к файлу
//
// Revision 1.104  2005/09/20 14:14:48  narry
// - исправление: AV при отсутствии в документе таблицы стилей
//
// Revision 1.103  2005/07/21 10:20:06  lulin
// - теперь TextSource не знает как создавать Reader'ы, а про это знает контейнер документа.
//
// Revision 1.102  2005/07/12 14:23:08  narry
// - bug fix: AV во время экспорта таблицы без ячеек
//
// Revision 1.101  2005/06/01 09:16:10  narry
// - bug fix: AV при обработке таблицы без строк
//
// Revision 1.100  2005/05/27 10:14:37  narry
// - bug fix: некорректный экспорт стилей
//
// Revision 1.99  2005/05/20 13:49:56  lulin
// - new unit: evStyleInterfaceEx.
//
// Revision 1.98  2005/03/28 14:30:04  lulin
// - от класса генераторов переходим к интерфейсу.
//
// Revision 1.97  2005/03/28 11:32:17  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.96  2005/03/21 10:04:55  lulin
// - new interface: _Ik2Type.
//
// Revision 1.95  2005/02/16 17:10:41  narry
// - update: Delphi 2005
//
// Revision 1.94  2004/12/01 12:22:16  narry
// - bug fix: Нормальный стиль всегда был размером 10
//
// Revision 1.93  2004/11/30 13:32:56  narry
// - bug fix
//
// Revision 1.92  2004/11/26 14:44:20  demon
// - fix: RangeCheckError в операции AddColor
//
// Revision 1.91  2004/10/20 13:42:42  narry
// - update: задание отступов страницы раздела по умолчанию равными отступам документа
//
// Revision 1.90  2004/10/08 14:44:51  narry
// - update: поддержка "резиновой" SBS-таблицы
//
// Revision 1.89  2004/10/01 08:55:56  narry
// - bug fix: двойное преобразование отступа красной строки
//
// Revision 1.88  2004/09/23 14:05:32  voba
// - исправлено: неверное приведение типа
//
// Revision 1.87  2004/09/21 12:21:04  lulin
// - Release заменил на Cleanup.
//
// Revision 1.86  2004/09/16 14:08:57  narry
// - bug fix: не рисовались рамки у абзацев
//
// Revision 1.85  2004/09/16 12:21:13  narry
// - bug fix
//
// Revision 1.84  2004/09/16 10:19:27  narry
// - update: перенос механизма фильтрации внешних ссылок на предка
//
// Revision 1.83  2004/07/06 10:45:42  narry
// - update
//
// Revision 1.82  2004/07/01 11:28:05  narry
// - update: замена сообщения "Все плохо..." на вывод в лог информации об исключении
//
// Revision 1.81  2004/06/01 16:51:23  law
// - удален конструктор Tl3VList.MakePersistent - пользуйтесь _Tl3ObjectRefList.
//
// Revision 1.80  2004/05/25 13:01:37  narry
// - update: поддержка чтения таблицы стилей из HTML
//
// Revision 1.79  2004/05/18 13:35:11  narry
// - new method: AddStyle
//
// Revision 1.78  2004/05/14 16:08:00  law
// - new units: evFileGenerator, evPlainTextGenerator.
//
// Revision 1.77  2004/05/14 14:48:50  law
// - исправлены префиксы у констант.
//
// Revision 1.76  2004/05/14 14:08:53  law
// - change: TevVariant переименован в Tk2Variant и переехал в k2Types.
//
// Revision 1.75  2004/05/13 06:07:40  demon
// - fix: заменена константа CP_CentralEuropeWin на CP_WesternWin (иначе не компилировалось)
//
// Revision 1.74  2004/05/12 15:10:12  narry
// - new: корректная поддержка уникодного текста
//
// Revision 1.73  2004/05/11 14:09:14  narry
// - bug fix: значение k2_tiVisible всегда воспринималось как Integer, хотя  оно может быть и строковое
// - cleanup
//
// Revision 1.72  2004/04/19 14:57:19  narry
// - update:
//
// Revision 1.71  2004/04/16 08:24:06  narry
// - bug fix: AV при чтении HTML
//
// Revision 1.70  2004/04/15 14:38:39  narry
// - new property: _OneStep - генерация внешних форматов в один проход
//
// Revision 1.69  2004/04/05 11:13:30  narry
// - new: использование параметров ширина и высота (размер в документе) для картинок
//
// Revision 1.68  2004/03/24 14:18:57  narry
// - bug fix: clDefualt содержит странное значение. Игнорируем.
//
// Revision 1.67  2004/02/04 09:34:52  narry
// - bug fix: исчезновение ссылки, заданной без идентификатора документа (внутренняя ссылка документа)
//
// Revision 1.66  2004/01/21 16:14:17  narry
// - bug fix: "мертвые" ссылки
//
// Revision 1.65  2004/01/19 14:44:41  narry
// - bug fix: неправильное выставление стилей абзацам подписи
// - update
// - cleanup
//
// Revision 1.64  2004/01/16 13:01:39  narry
// - bug fix: AV при экспорте пары документ-справка
//
// Revision 1.63  2004/01/16 10:12:28  narry
// - update
//
// Revision 1.62  2004/01/12 11:27:37  narry
// - cleanup
//
// Revision 1.61  2004/01/09 14:59:56  narry
// - cleanup
//
// Revision 1.60  2004/01/05 14:28:58  fireton
// - bug fix: посмертное преобразование единиц измерения - до перехода на твипы
//
// Revision 1.59  2003/12/30 11:33:36  nikitin75
// - bug fix: замена -1 на propUndefined для определения незаданного свойства
//
// Revision 1.58  2003/12/30 10:59:41  narry
// - new property: FilerFileName - имя файла, в который выполняется сохранение документов
//
// Revision 1.57  2003/12/29 12:07:11  narry
// - new: обработка позиций табуляции
//
// Revision 1.56  2003/12/23 17:01:16  narry
// - update: улучшение алгоритма наследования стилей
// - add: сохранение вертикального выравнивания ячеек таблицы
//
// Revision 1.55  2003/12/17 14:44:16  narry
// - bug fix: не закрывались сегменты, длина которых превышала длину абзаца
//
// Revision 1.54  2003/12/04 16:22:43  narry
// - bug fix: неправильное выравнивание стиля Normal
// - bug fix: избыточное и местами неправильное оформление абзаца и текста
//
// Revision 1.53  2003/11/06 15:15:05  narry
// - bug fix: сохранение картинки в RTF. Реализовано для BMP
//
// Revision 1.52  2003/09/26 14:07:04  narry
// - new: преобразование "продолжения ссылки" в ссылку
//
// Revision 1.51  2003/09/16 12:04:24  narry
// - bug fix: Index of bounds при преобразовании текста в таблицу
//
// Revision 1.50  2003/09/10 08:15:10  narry
// - bug fix: по окончании документа не сбрасывался буфер, что приводило к накапливанию в нем информации.
//
// Revision 1.49  2003/08/20 11:15:24  narry
// - new: интерпретация блоков как меток
//
// Revision 1.48  2003/05/13 13:42:03  narry
// no message
//
// Revision 1.47  2003/04/30 12:42:05  narry
// - add: константа rtfTwip
// - change: замена 1440 на rtfTwip
//
// Revision 1.46  2003/04/29 13:38:50  narry
// - bug fix: ссылка без Handle переставала быть ссылкой
//
// Revision 1.45  2003/04/19 12:30:37  law
// - new file: ddDefine.inc.
//
// Revision 1.44  2002/12/17 12:42:47  law
// - change: k2_idTableColumn переименовано в k2_idTableCell для большего соответстия смыслу тега.
//
// Revision 1.43  2002/09/19 13:41:33  law
// - cleanup and comments.
//
// Revision 1.42  2002/09/19 12:52:37  law
// - cleanup.
//
// Revision 1.41  2002/09/18 14:31:35  law
// - change: начата работа по поддержке нотификации об изменении стилей.
// - new unit: evStyleTableTools.
//
// Revision 1.40  2002/09/18 06:03:31  law
// - cleanup: удален параметр IsDefault.
//
// Revision 1.39  2002/07/30 15:58:16  narry
// - new behavior: поддержка Strikeout
//
// Revision 1.38  2002/07/23 11:18:17  narry
// - update: добавление в таблицу шрифтов шрифта по умолчанию
//
// Revision 1.37  2002/07/08 14:12:38  narry
// - bug fix: наличие в документе блоков приводило к неосвобожденным объектам
//
// Revision 1.36  2002/07/03 09:00:57  narry
// - update, cleanup и new behavior
//
// Revision 1.35.2.2  2002/06/21 09:28:08  narry
// - not ready
//
// Revision 1.35.2.1  2002/06/06 15:09:21  narry
// - beta _save.
//
// Revision 1.35  2002/06/06 11:12:22  narry
// - bug fix: Access violation при закрытии блока
//
// Revision 1.34  2002/06/05 13:21:17  narry
// - update: поддержка новой писалки HTML
//
// Revision 1.33  2002/05/29 14:29:31  narry
// - bug fix, update and new behavior
//
// Revision 1.32  2001/10/16 12:19:28  narry
// - bug fix: не очищался буфер по окончании документа
//
// Revision 1.31  2001/09/12 14:44:37  narry
// - new behavior: изменение логики обработки невидимости
//
// Revision 1.30  2001/08/31 09:04:36  law
// - cleanup.
//
// Revision 1.29  2001/08/29 14:39:35  narry
// - bug fix: отсутствовало присвоение признака "в таблице"
//      при добавлении абзаца в таблицу
//
// Revision 1.28  2001/08/29 12:52:39  narry
// - bug fix
//
// Revision 1.27  2001/08/28 13:29:10  narry
// - update
//
// Revision 1.26  2001/08/21 12:26:23  narry
// - new behavior: расширение функциональности для использования в
//     HTMLReader
//
// Revision 1.25  2001/06/27 12:25:56  narry
// -new behavior: независимо от значения свойства Visible всегда
//          выставлялся серый фон текст
//
// Revision 1.24  2001/06/19 07:28:13  narry
// -bug fix:  при записи свойства невидимости инвертировалось
//               его значение
//
// Revision 1.23  2001/05/10 14:20:04  narry
// Update - обработка параметров раздел
//
// Revision 1.22  2001/05/03 13:47:16  narry
// Update - рамки у таблиц
//
// Revision 1.21  2001/04/27 09:18:28  narry
// Bug fix - потерянные объекты, логика обработки некоторых атомо
//
// Revision 1.20  2001/04/25 07:18:01  narry
// Update - очередная итерация по записи-чтению стилей Эверест в РТФ
//
// Revision 1.19  2001/03/14 13:24:53  law
// - some cleaup and tuning.
//
// Revision 1.18  2001/03/02 11:55:02  narry
// Partial fix break load &write
//
// Revision 1.17  2001/01/25 09:08:06  narry
// Fix - wrong page width, lost character format
// Add - write page break
//
// Revision 1.16  2000/12/20 11:56:32  narry
// SBS finally fix
//
// Revision 1.15  2000/12/19 16:05:18  law
// - убраны ненужные директивы компиляции.
//
// Revision 1.14  2000/12/19 14:46:29  narry
// Table write fix
//
// Revision 1.13  2000/12/19 13:49:33  narry
// no message
//
// Revision 1.12  2000/12/18 16:19:29  narry
// Partially bug fix
//
// Revision 1.11  2000/12/15 15:29:53  law
// - вставлены директивы Log и Id.
//

{$Include ddDefine.inc }

interface

uses
  Windows,
  Classes,
  
  l3Base,
  l3Types,
  l3ObjectRefList,
  l3LongintList,
  l3StringList,
  l3ProtoPersistentRefList,

  k2Types,
  k2Interfaces,
  k2TagGen,
  k2FileGenerator,

  ddSub,
  ddBase,
  ddTypes,
  ddBreak,
  ddTable,
  ddTableList,
  ddBorder,
  ddPicture,
  ddSubsList,
  ddDocumentAtom,
  destColorTable,
  ddRTFProperties,
  ddTextParagraph,
  ddDocumentAtomList,

  RTFTypes,

  l3ProtoObject,
  l3ProtoObjectrefList,
  l3Variant,

  ddTableRow,
  ddTableCell,
  ddCellProperty,
  ddDocumentProperty,
  ddParagraphProperty,
  ddCharacterProperty,
  ddTextSegment;

type
  TddDocumentGenerator = class;
  
  TddDocument = class(Tl3ProtoObject)
  private
    f_ColorTable: Tl3ProtoObjectRefList;
    f_DOP: TddDocumentProperty;
    f_FontTable: Tl3StringList;
    f_Generator: TddDocumentGenerator;
    f_Info: TddRTFInfo;
    f_LastPara: TddTextParagraph;
    f_OneStep: Boolean;
    f_Paragraphs: TddDocumentAtomList;
    f_StyleTable: Tl3StringList;
    f_Tables: TddTableList;
    function pm_GetLastAtom: TddDocumentAtom;
    function pm_GetPageHeight: Integer;
    function pm_GetPageWidth: Integer;
    function pm_GetTable: TddTable;
    function pm_GetTextWidth: Integer;
    procedure _AddAtom(aAtom: TddDocumentAtom; aPart: Boolean = False);
    procedure AddAtomWithoutOneStep(aAtom: TddDocumentAtom);
  protected
    procedure Cleanup; override;
    function GetColorCount: Integer;
    function GetColorEntry(No: Longint): TddColorEntry;
    function GetFontCount: Integer;
    function GetFontEntry(Index: Integer): TddFontEntry;
    function GetLastPara: TddTextParagraph;
    function GetStyleCount: Integer;
    function GetStyleSheet(Index: Integer): TddStyleEntry;
    function GetStyleTable(No: Longint): TddStyleEntry;
    procedure SetColorEntry(No: Longint; Value: TddColorEntry);
    procedure SetStyleTable(No: Longint; Value: TddStyleEntry);
    property _ColorTable: Tl3protoObjectRefList read f_ColorTable;
    property _FontTable: Tl3StringList read f_FontTable;
    property _StyleTable: Tl3StringList read f_StyleTable;
  public
    constructor Create(aGenerator: TddDocumentGenerator); reintroduce;
    function AddColor(Value: Longint): Integer;
    function AddDocumentAtom(aAtom: TddDocumentAtom): Boolean; overload;
    function AddFont(FontName: AnsiString; const Charset : Integer = propUndefined): 
        Integer;
    function AddParagraph: Boolean; overload;
    procedure AddStyle(aStyle: TddStyleEntry);
    procedure Assign(aDocument: TddDocument);
    procedure DeleteLastTextPara;
     {* - Удаляет последний текстовый параграф. }
    procedure Clear; virtual;
    procedure CorrectStyles;
    procedure CheckNormalStyle(const aStyle: TddStyleEntry);
    procedure CreateTable;
    procedure CloseTable(aScaleCellWidth: Boolean);
    procedure FinalCorrectStyles;
    function FontNameByIndex(Index: Longint): AnsiString;
    procedure MakeStyleParent(aParent: Integer; var aPAP: TddParagraphProperty; var aCHP:
        TddCharacterProperty);
    procedure ResetToDefault;
    procedure StartTable;
    function StyleByName(const aName: AnsiString): TddStyleEntry; overload;
    function StyleByName(const aName: Tl3PCharLen): TddStyleEntry; overload;
    procedure Write2Generator(const Generator: Ik2TagGenerator; aLiteVersion: TddLiteVersion);
    property ColorCount: Integer read GetColorCount;
    property ColorTable[No: Longint]: TddColorEntry read GetColorEntry write
            SetColorEntry;
    property DOP: TddDocumentProperty read f_DOP write f_DOP;
    property FontCount: Integer read GetFontCount;
    property FontTable[Index: Integer]: TddFontEntry read GetFontEntry;
    property Info: TddRTFInfo read f_Info write f_Info;
    property LastAtom: TddDocumentAtom read pm_GetLastAtom;
    property LastPara: TddTextParagraph read GetLastPara;
    property OneStep: Boolean read f_OneStep write f_OneStep;
    property PageHeight: Integer read pm_GetPageHeight;
    property PageWidth: Integer read pm_GetPageWidth;
    property Paragraphs: TddDocumentAtomList read f_Paragraphs;
    property StyleCount: Integer read GetStyleCount;
    property StyleSheet[Index: Integer]: TddStyleEntry read GetStyleSheet;
    property StyleTable[No: Longint]: TddStyleEntry read GetStyleTable write
            SetStyleTable;
    property Table: TddTable read pm_GetTable;
    property TextWidth: Integer read pm_GetTextWidth;
  end;

  TddDocumentGenerator = class(Tk2CustomFileGenerator)
  private
    FUseExternalLinks: Boolean;
    f_BorderOwner: TddBorderOwner;
    f_ColorEntry: TddColorEntry;
    f_CurFramePart: TddBorderParts;
    f_DocID: LongInt;
    f_Revision: LongInt;
    f_Document: TddDocument;
    f_ExtNumber: LongInt;
    f_FontEntry: TddFontEntry;
    f_HeaderWritten: Boolean;
    f_IntNumber: LongInt;
    f_OneStep: Boolean;
    f_Para: TddTextParagraph;
    f_Picture: TddPicture;
    f_Sect: TddBreak;
    f_Seg: TddTextSegment;
    f_StyleEntry: TddStyleEntry;
    f_SubID: LongInt;
    f_SubList: TddSubsList;
    f_SubRec: TddSub;
    f_ExternalIDList: Tl3LongintList;
    f_Tables: TddTableList;
    f_TypeID: Integer;
  private
    function IsCorrectTypeID: Boolean;
    procedure AddTarget;
    procedure CheckBorderInSBS(const aBorder: TddBorder);
    procedure AddStyleTable;
    procedure CalcJoinedWidth(aEtalonRowIndex: Integer);
    procedure CheckHeader;
    procedure CloseCell;
    procedure CloseDocument;
    procedure CloseParagraph(aDecorPara: Boolean);
    procedure CloseTable;
    procedure CloseTableRow;
    procedure CorrectStyles;
    procedure WriteTablePart(aPart: Boolean);
    procedure FillDefaultValues;
    function GetFilerFileName: AnsiString;
    procedure SetOneStep(Value: Boolean);
    procedure CorrectParaFonts(aPara: TddTextParagraph);
    function FindMergedHead(aRowIndex: Integer; aCellIndex: Integer): TddCellProperty;
    function pm_GetTable: TddTable;
    procedure pm_SetExternalIDList(Value: Tl3LongintList);
    procedure pm_SetTable(Value: TddTable);
    procedure StartAddress;
    procedure StartBlock;
    procedure StartDocument;
    procedure StartPageBreak;
    procedure StartParagraph;
    procedure StartPicture;
    procedure StartSectionBreak;
    procedure StartSegment;
    procedure StartSegmentLayer;
    procedure StartSub;
    procedure StartTable(aSBS: Boolean);
    procedure StartTableCell;
    procedure StartTableRow(aAutoFit: Boolean);
    procedure StartTabStop;
    procedure TryToInitPrintFontSize(const aStyleRt: TddStyleEntry; const aCHP: TddCharacterProperty);
     {* - Корректируем PrintFontSize для моноширинных стилей. (См. http://mdp.garant.ru/pages/viewpage.action?pageId=422512540) }
    function ValidExternalID(aID: Integer): Boolean;
  protected
    function AddEvStyle(evStyle: Long): TddStyleEntry;
    procedure AddSubRec;
    procedure Apply2Address(AtomIndex: Long; const Value: Tk2Variant);
    procedure Apply2Column(AtomIndex: Long; const Value: Tk2Variant);
    procedure Apply2Doc(AtomIndex: Long; const Value: Tk2Variant);
    procedure Apply2Font(AtomIndex: Long; const Value: Tk2Variant);
    procedure Apply2FramePart(AtomIndex: Long; const Value: Tk2Variant);
    procedure Apply2NumAndDate(AtomIndex: Long; const Value: Tk2Variant);
    procedure Apply2Para(AtomIndex: Long; const Value: Tk2Variant);
    procedure Apply2Picture(AtomIndex: Long; const Value: Tk2Variant);
    procedure Apply2Row(AtomIndex: Long; const Value: Tk2Variant);
    procedure Apply2Sect(AtomIndex: Long; const Value: Tk2Variant);
    procedure Apply2Segment(AtomIndex: Long; const Value: Tk2Variant);
    procedure Apply2Style(AtomIndex: Long; const Value: Tk2Variant);
    procedure Apply2Sub(AtomIndex: Long; const Value: Tk2Variant); virtual;
    procedure Apply2Table(AtomIndex: Long; const Value: Tk2Variant);
    procedure Apply2TabStop(AtomIndex: Long; const Value: Tk2Variant);
    function BlockIndent: Integer; virtual;
     {* Ручки "наружу" для Writer'а. Отступ для дочернего параграфа. }
    function IgnoreLeftIndent: Boolean; virtual;
     {-}
    procedure CheckFilterPara(aFromFilter: Boolean); virtual;
    function InBlock: Boolean;
    procedure DoInitPictureWidth; virtual;
    procedure DoStartBlock; virtual;
    procedure DoCloseBlock; virtual;
    procedure DoStartDocument; virtual;
    procedure WriteFormula(aFormula: TddTextSegment; aCHP: TddCharacterProperty; aUseMetaFile: Boolean);
    function IsSeg: Boolean;
    procedure Cleanup; override;
    function NeedWritePara: Boolean; virtual;
      {* Ручки "наружу" для Writer'а. Писать или не писать параграф в зависимости от стиля. }
    procedure WriteBreak(const aBreak: TddBreak); virtual;
    procedure WriteColorTable(aDefault: Boolean = False); virtual;
    procedure WriteDocument; virtual;
    procedure WriteDocumentBody; virtual;
    procedure WriteDocumentEnd; virtual;
    procedure WriteDocumentHeader; virtual;
    procedure WriteDocumentStart; virtual;
    procedure WriteFontTable(aDefault: Boolean = False); virtual;
    procedure WriteHeader(aDefault: Boolean = False); virtual;
    procedure WritePicture(const Picture: TddPicture; aWholePar: Boolean); virtual;
    procedure WriteStyleTable(aDefault: Boolean = False); virtual;
    procedure WriteTable(const aTable: TddTable; aOnlyPart: Boolean); virtual;
    procedure WriteTableRow(const aRow: TddTableRow; anIndex: Integer; const aTableType: TddTableType = dd_ttNone; aRowPos: TddRowPosition = dd_rpNone); virtual;
    procedure WriteTextParagraph(const Para: TddTextParagraph; anOutEOL: Boolean = False); virtual;
    property FilerFileName: AnsiString read GetFilerFileName;
    function NeedFillCell(const aRow: TddTableRow; aTableType: TddTableType; aRowPos: TddRowPosition): TddFillAAC;
    function IsAACPictureRow(const aRow: TddTableRow): Boolean;
    function IsAACInnerTableRow(const aRow: TddTableRow): Boolean;
    property Table: TddTable read pm_GetTable write pm_SetTable;
  public
    constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
    procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
    procedure CloseStructure(NeedUndo: Bool); override;
    procedure OpenStream; override;
    procedure StartChild(TypeID: Tl3VariantDef); override;
    procedure StartTag(TagID: Long); override;
    procedure WriteAtom2Filer(aAtom: TddDocumentAtom; aPart: Boolean);
    property Document: TddDocument read f_Document;
    property ExtNumber: LongInt read f_ExtNumber;
    property IntNumber: LongInt read f_IntNumber;
    property OneStep: Boolean read f_OneStep write SetOneStep;
    property ExternalIDList: Tl3LongintList read f_ExternalIDList write pm_SetExternalIDList;
    property UseExternalLinks: Boolean read FUseExternalLinks write
        FUseExternalLinks;
  end;
  
implementation

Uses
  SysUtils,
  Dialogs,
  Graphics,
  Math,
  StrUtils,

  l3Memory,
  l3Interfaces,
  l3ImageUtils,
  l3InternalInterfaces,

  k2Tags,
  k2Base,
  k2Attributes,

  evdTypes,

  evFont,
  evConst,
  evStyleInterface,
  evStyleInterfaceEx,
  evInternalInterfaces,

  evdStyles,

  l3Chars,
  l3Const,
  l3Math,
  l3Filer,

  ExprDraw,
  ExprMake,

  ddTab,
  ddConst,
  ddRTFConst,
  ddHyperlink,
  ddStyleSegment,
  ddObjectSegment,
  ddPictureSegment,
  ddFormulaSegment,

  l3BitmapContainer,
  l3GraphicContainer,
  l3MetafileContainer,

  Document_Const,
  DecorTextPara_Const,
  Block_Const,
  TextPara_Const,
  BitmapPara_const,
  FramePart_Const,
  TextSegment_Const,
  Address_Const,
  Font_Const,
  Style_Const,
  Table_Const,
  SBS_Const,
  TableRow_Const,
  TableCell_Const,
  PageProperties_Const,
  TabStop_Const,
  NumAndDate_Const,
  Sub_Const,
  DocumentSub_Const,
  SectionBreak_Const,
  SegmentsLayer_Const,
  ObjectSegment_Const,
  ReqRow_Const,
  PageBreak_Const,
  Formula_Const,
  Hyperlink_Const
  , l3Defaults, TypInfo,

  evdAllParaEliminator{,
  jclGraphUtils}, ddParaList, ddTablePrim;

{
********************************* TddDocument **********************************
}
constructor TddDocument.Create(aGenerator: TddDocumentGenerator);
begin
 inherited Create;
 f_Generator := aGenerator;
 f_Info := TddRTFInfo.Create;
 f_DOP := TddDocumentProperty.Create;
 f_FontTable := Tl3StringList.Make;
 f_StyleTable := Tl3StringList.Make;
 f_Paragraphs := TddDocumentAtomList.Make;
 f_ColorTable := Tl3ProtoObjectRefList.Make;
 f_Tables := TddTableList.Make;
 if f_Generator <> nil then
  OneStep := f_Generator.OneStep
 else
  OneStep := False;
end;

type
  TColorRec = packed record
    case Integer of
      0: (Value: Longint);
      1: (Red, Green, Blue: Byte);
      2: (R, G, B, Flag: Byte);
      3: (Index: Word); // GetSysColor, PaletteIndex
  end;

function TddDocument.AddColor(Value: Longint): Integer;
var
 i: Integer;
 l_C: TddColorEntry;
 l_RGBColor: Longint;
 l_ICN : Il3InfoCanvas;
 l_Entry: TPaletteEntry;
begin
 Result:= propUndefined;
 if Value <> clDefault then
 begin
  l_RGBColor := ColorToRGB(Value);
  if l_RGBColor = clDefault then
   l_RGBColor:= Windows.GetSysColor(TColorRec(Value).Index);
  if l_RGBColor <> clDefault then
  begin
   for i:= 0 to f_ColorTable.Hi do
   begin
    l_C:= TddColorEntry(f_ColorTable.Items[i]);
    if l_C.Color = Value then
    begin
     Result:= Succ(i);
     break;
    end;
   end;
   if Result = propUndefined then
   begin
    l_C:= TddColorEntry.Create;
    try
     l_C.Red:= GetRValue(l_RGBColor);
     l_C.Green:= GetGValue(l_RGBColor);
     l_C.Blue:= GetBValue(l_RGBColor);
     Result:= Succ(f_ColorTable.Add(l_C));
    finally
     l3Free(l_C);
    end; // try..finally
   end; // Result = propUndefined
  end; // l_RGBColor <> clDefault
 end; 
end;

function TddDocument.AddDocumentAtom(aAtom: TddDocumentAtom): Boolean;
{ Добавляет ЗАКОНЧЕННЫЙ атом, готовый к записи в генератор }
var
  l_A: TddDocumentAtom;
begin
  Result:= True;
  if aAtom is TddTextParagraph then
  begin
   l_A:= LastAtom;
   if (l_A <> nil) and (l_A.IsTable or l_A.IsRow) and not l_A.Closed then
   begin
    if l_A.IsTable and
      ((TddTable(l_A).LastRow = nil) or (TddTable(l_A).LastRow.LastCell = nil)) then
     Result:= False
    else
    begin
     (aAtom as TddTextParagraph).PAP.InTable:= True;
     if (aAtom as TddTextParagraph).PAP.Style >= 0 then
      (aAtom as TddTextParagraph).PAP.Style:= ev_saNormalTable;
     if l_A.IsRow then
      TddTableRow(l_A).LastCell.Add(aAtom)
     else
      TddTable(l_A).LastRow.LastCell.Add(aAtom);
    end; // if.. else
   end   // table
   else
    if (l_A <> nil) and (l_A is TddParaList) and not l_A.Closed then
     TddParaList(l_A).AddPara
    else
     _AddAtom(aAtom);
  end
  else
   _AddAtom(aAtom);
end;

function TddDocument.AddFont(FontName: AnsiString; const Charset : Integer = propUndefined): Integer;
var
  i: Integer;
  l_F: TddFontEntry;
begin
  Result:= propUndefined;
  for i:= 0 to f_FontTable.Hi do
  begin
    l_F:= TddFontEntry(f_FontTable.Items[i]);
    if (l_F.CharSet = Charset) and AnsiStartsText(l_F.ASString, FontName) then
    begin
      Result:= i;
      break;
    end;
  end; // for i
  if Result = propUndefined then
  begin
   l_F:= TddFontEntry.Create;
   try
    l_F.AsString:= Fontname;
    l_F.Charset:= Charset;
    f_FontTable.Add(l_F);
    l_F.Number:= Pred(f_FontTable.Count);
    Result:= l_F.Number;
   finally
    l3Free(l_F);
   end;
   if Charset = propUndefined then
   begin
    if AnsiEndsText('Cyr', FontName) then
    begin
     FontName:= Copy(FontName, 1, Pred(Pos('Cyr', FontName)));
     AddFont(FontName, 0);
    end; // AnsiEndsText('Cyr', FontName)
   end;
  end;
end;

function TddDocument.AddParagraph: Boolean;
var
  l_P: TddTextParagraph;
begin
  l_P := TddTextParagraph.Create(nil);
  try
   Result := True;
   _AddAtom(l_P);
  finally
   l3Free(l_P);
  end;
end;

procedure TddDocument.AddStyle(aStyle: TddStyleEntry);
var
 l_No: Integer;
begin
 l_No:= 100;
 while StyleTable[l_No] <> nil do
  Inc(l_No);
 aStyle.Number:= l_No;
 StyleTable[l_No]:= aStyle;
end;

procedure TddDocument.Assign(aDocument: TddDocument);
begin
 f_Paragraphs.Assign(aDocument.Paragraphs);
 f_StyleTable.Assign(aDocument._StyleTable);
 f_ColorTable.Assign(aDocument._ColorTable);
 f_FontTable.Assign(aDocument._FontTable);
 f_OneStep:= aDocument.OneStep;
 { TODO -oNarry -cРазвитие : Добавить присвоение DOP и Info }
end;

procedure TddDocument.Cleanup;
begin
  l3Free(f_Tables);
  l3Free(f_Paragraphs);
  l3Free(f_StyleTable);
  l3Free(f_ColorTable);
  l3Free(f_DOP);
  l3Free(f_FontTable);
  l3Free(f_Info);
  l3Free(f_LastPara);
  inherited;
end;

procedure TddDocument.Clear;
begin
  f_Tables.Clear;
  inherited;
  f_FontTable.Clear;
  f_ColorTable.Clear;
  f_StyleTable.Clear;
  f_Paragraphs.Clear;
  l3Free(f_LastPara);
end;

procedure TddDocument.CorrectStyles;
var
 i     : Integer;
 S, S1 : TddStyleEntry;
 l_CHP : TddCharacterProperty;
 l_PAP : TddParagraphProperty;

 procedure _IterateParents(aStyle: TddStyleEntry);
 begin
  if (aStyle.BasedOn <> 0) and (aStyle.BasedOn <> 222) and (StyleTable[aStyle.BasedOn] <> nil) then
     _IterateParents(StyleTable[aStyle.BasedOn]);
  l_CHP.InheriteFrom(aStyle.CHP); //JoinWith(aStyle.CHP);//l_CHP.MergeWith(aStyle.CHP);
  if aStyle.StyleDef = sdParagraph then
   l_PAP.InheriteFrom(aStyle.PAP);//JoinWith(aStyle.PAP); //l_PAP.MergeWith(aStyle.PAP);
 end;

begin
 l_CHP := TddCharacterProperty.Create;
 try
  l_PAP := TddParagraphProperty.Create;
  try
   for i := 0 to f_StyleTable.Hi do
   begin
    S := TddStyleEntry(f_StyleTable.Items[i]);
    if (S.BasedOn <> 0) and (S.BasedOn <> 222) and (StyleTable[S.BasedOn] <> nil) then
    begin
     S1 := S;
     l_CHP.Clear;
     l_PAP.Clear;
     _IterateParents(StyleTable[S1.BasedOn]);
     S.CHP.InheriteFrom(l_CHP);//MergeWith(l_CHP);
     S.PAP.InheriteFrom(l_PAP);//MergeWith(l_PAP);
    end // (S.BasedOn <> 0) and (S.BasedOn <> 222)
    else
     CheckNormalStyle(S);
   end; // for i
  finally
   l3Free(l_PAP);
  end; // l_PAP
 finally
  l3Free(l_CHP);
 end; // l_CHP
end;

procedure TddDocument.FinalCorrectStyles;
var
  i: Integer;
  S: TddStyleEntry;
begin
 for i:= 0 to f_StyleTable.Hi do
 begin
  S:= TddStyleEntry(f_StyleTable.Items[i]);
  if (Abs(S.PAP.xaLeft) <> propUndefined) then
   if Abs(S.PAP.xaFirst) = propUndefined then
    S.PAP.xaFirst:= def_FirstIndent - S.PAP.xaLeft
   else
    S.PAP.xaFirst:= S.PAP.xaFirst - S.PAP.xaLeft;
  if S.StyleDef = sdParagraph then
   S.PAP.Style:= S.Number
  else
   S.CHP.Style:= S.Number;
  S.PAP.IsDefault:= True;
  S.CHP.IsDefault:= True;
 end; // for i
end;

function TddDocument.FontNameByIndex(Index: Longint): AnsiString;
var
  i: Integer;
  l_F: TddFontEntry;
begin
 Result:= '';
 for i:= 0 to f_FontTable.Hi do
 begin
   l_f:= TddFontEntry(f_FontTable.Items[I]);
   if l_F.Number = Index then
   begin
     Result:= l_F.AsString;
     break;
   end;
 end;                                     
end;

function TddDocument.GetColorCount: Integer;
begin
  REsult:= f_ColorTable.Count;
end;

function TddDocument.GetColorEntry(No: Longint): TddColorEntry;
begin
 Result:= TddColorEntry(f_ColorTable.Items[No]);
end;

function TddDocument.GetFontCount: Integer;
begin
  Result:= f_FontTable.Count;
end;

function TddDocument.GetFontEntry(Index: Integer): TddFontEntry;
begin
 Result:= TddFontEntry(f_FontTable.Items[Index]);
end;

function TddDocument.GetLastPara: TddTextParagraph;
var
 l_Atom    : TddDocumentAtom;
 l_Table   : TddTable;
 l_LastRow : TddTableRow;
 l_LastCell: TddTableCell;
 l_LastAtom: TddDocumentAtom;
begin
 Result := nil;
 if f_Paragraphs.Count > 0 then
 begin
  l_Table := Table;
  if l_Table <> nil then
  begin
   l_LastRow := l_Table.LastRow;
   if l_LastRow <> nil then
   begin
    l_LastCell := l_LastRow.GetLastNonClosedCell;
    if l_LastCell <> nil then
     Result := l_LastCell.LastTextPara;
   end; // if l_LastRow <> nil then
  end // if f_Table <> nil then
  else
  begin
   l_Atom := f_Paragraphs.Last;
   l_LastAtom := l_Atom.GetLastPara;
   if (l_LastAtom <> nil) and not l_LastAtom.Closed then
    Result := TddTextParagraph(l_LastAtom);
  end;
 end
 else
 begin
  if (f_LastPara <> nil) and not f_LastPara.Closed then
   Result := f_LastPara;
 end;
end;

function TddDocument.GetStyleCount: Integer;
begin
  Result:= f_StyleTable.Count;
end;

function TddDocument.GetStyleSheet(Index: Integer): TddStyleEntry;
begin
 Result:= TddStyleEntry(f_StyleTable.Items[Index]);
end;

function TddDocument.GetStyleTable(No: Longint): TddStyleEntry;
var
 i: LongInt;
 l_S: TddStyleEntry;
begin
 Result := nil;
 for i := 0 to f_StyleTable.Hi do
 begin
  l_S := TddStyleEntry(f_StyleTable.Items[i]);
  if l_S.Number = No then
  begin
   Result:= l_S;
   Break;
  end;
 end; // for i
 if (Result = nil) and (No = 0) then
  Result:= StyleTable[ev_saTxtNormalAnsi]
end;

procedure TddDocument.MakeStyleParent(aParent: Integer; var aPAP: TddParagraphProperty; var aCHP: TddCharacterProperty);

  procedure lp_IterateParents(aStyle: TddStyleEntry);
  begin
   aCHP.JoinWith(aStyle.CHP);
   if aStyle.StyleDef = sdParagraph then
    aPAP.JoinWith(aStyle.PAP); 
   if (aStyle.BasedOn <> 0) and (aStyle.BasedOn <> 222) and (StyleTable[aStyle.BasedOn] <> nil) then
    lp_IterateParents(StyleTable[aStyle.BasedOn]);
  end;

begin
 aCHP.Clear;
 aPAP.Clear;
 if (aParent <> 222) and (StyleTable[aParent] <> nil) then
  lp_IterateParents(StyleTable[aParent]);
end;

function TddDocument.pm_GetLastAtom: TddDocumentAtom;
begin
 if f_Paragraphs.Count > 0 then
  Result := f_Paragraphs.Last
 else
  Result := nil;
end;

function TddDocument.pm_GetPageHeight: Integer;
begin
 Result := DOP.yaPage - DOP.yaTop - DOP.yaBottom;
end;

function TddDocument.pm_GetPageWidth: Integer;
begin                                                     
 Result := DOP.xaPage - DOP.xaLeft - DOP.xaRight;
end;

function TddDocument.pm_GetTable: TddTable;
begin
 if (f_Tables.Count > 0) and not f_Tables.Last.Closed then
  Result := f_Tables.Last
 else
  Result := nil;
end;

function TddDocument.pm_GetTextWidth: Integer;
begin
 with DOP do
  Result := xaPage - xaLeft - xaRight;
end;

procedure TddDocument.ResetToDefault;
var
  I: Integer;
begin
  Clear;
  AddFont('Arial', 204);
  AddFont(def_ANSIDOSFontName, 204);
  AddFont('Symbol', 2);
  AddFont('Wingdings');
  for i:= 1 to 16 do
   AddColor(HighlightToColor(i));
end;

procedure TddDocument.SetColorEntry(No: Longint; Value: TddColorEntry);
begin
  {}
end;

procedure TddDocument.SetStyleTable(No: Longint; Value: TddStyleEntry);
begin
 // Здесь так нельзя - добавится фейковый Нормальный
 if StyleTable[No] = nil then
  f_StyleTable.Add(Value)
 else
  StyleTable[No].Assign(Value);
end;

procedure TddDocument.StartTable;
var
 l_Table: TddTable;
begin
 l_Table:= TddTable.Create(nil);
 try
  f_Paragraphs.Add(l_Table);
 finally
  FreeAndNil(l_Table);
 end;
end;

function TddDocument.StyleByName(const aName: AnsiString): TddStyleEntry;
var
 l_S: TddStyleEntry;
 i: Integer;
begin
 Result := nil;
 for i := 0 to f_StyleTable.Hi do
 begin
  l_S := StyleSheet[i];
  if l_S.AsString = aName then
  begin
   Result:= l_S;
   Break;
  end;
 end;
end;

procedure TddDocument.Write2Generator(const Generator: Ik2TagGenerator; aLiteVersion: TddLiteVersion);
var
 i: Integer;
begin
 for i := 0 to f_Paragraphs.Hi do
  f_Paragraphs[i].Write2Generator(Generator, False, aLiteVersion);
end;

procedure TddDocument._AddAtom(aAtom: TddDocumentAtom; aPart: Boolean);
begin
 if OneStep and (f_Generator <> nil) then
 begin
  if aAtom.IsTextPara then
   l3Set(f_LastPara, TddTextParagraph(aAtom))
  else
   l3Free(f_LastPara);
  if f_Generator.Generator <> nil then
   aAtom.Write2Generator(f_Generator.Generator, False, dd_lvNone)
  else
   f_Generator.WriteAtom2Filer(aAtom, aPart);
 end//OneStep
 else
  AddAtomWithoutOneStep(aAtom);
end;

{
***************************** TddDocumentGenerator *****************************
}
constructor TddDocumentGenerator.Create;
begin
  inherited Create(nil);
  f_Document:= TddDocument.Create(Self);
  f_SubList:= TddSubsList.make;
  {$IfDef Nemesis}
  FUseExternalLinks:= true;
  {$Else  Nemesis}
  FUseExternalLinks:= False;
  {$EndIf Nemesis}
  f_ExternalIDList:= Tl3LongintList.MakeSorted;
  f_Tables := TddTableList.Make;
  OneStep:= True;
end;

procedure TddDocumentGenerator.AddAtomEx(AtomIndex: Long; const Value:
        Tk2Variant);
var
  TT: Tk2Type;
 l_Frame : Tl3Tag;
begin
  TT:= CurrentType;
  try
    if (AtomIndex = k2_tiFrame) then
    begin
     l_Frame := Value.AsVariant;
     if (l_Frame <> nil) AND l_Frame.IsValid then
     begin
      StartTag(k2_tiFrame);
      try
       l_Frame.WriteTag(Self);
      finally
       Finish;
      end;//try..finally
     end;//l_Frame <> nil
     Exit;
    end;//AtomIndex = k2_tiFrame
     if TT.IsKindOf(k2_typDocument) then
       Apply2Doc(AtomIndex, Value)
     else
     if TT.IsKindOf(k2_typBlock) then
      Apply2Sub(AtomIndex, Value)
     else
     if TT.IsKindOf(k2_typTextPara) then
       Apply2Para(AtomIndex, Value)
     else
     if TT.IsKindOf(k2_typBitmapPara) then
       Apply2Picture(AtomIndex, Value)
     else
     if TT.IsKindOf(k2_typFramePart) then
       Apply2FramePart(AtomIndex, Value)
     else
     if TT.IsKindOf(k2_typTextSegment) then
      Apply2Segment(AtomIndex, Value)
     else
     if TT.IsKindOf(k2_typAddress) then
      Apply2Address(AtomIndex, Value)
     else
     if TT.IsKindOf(k2_typFont) then
       Apply2Font(AtomIndex, Value)
     else
     if TT.IsKindOf(k2_typStyle) then
        Apply2Style(AtomIndex, Value)
     else
     if TT.IsKindOf([k2_typTable, k2_typSBS]) then
       Apply2Table(AtomIndex, Value)
     else
     if TT.IsKindOf(k2_typTableRow) then
       Apply2Row(AtomIndex, Value)
     else
     if TT.IsKindOf(k2_typTableCell) then
       Apply2Column(AtomIndex, Value)
     else
     if TT.IsKindOf(k2_typPageProperties) then
       Apply2Sect(AtomIndex, Value)
     else
     if TT.IsKindOf(k2_typTabStop) then
      Apply2TabStop(AtomIndex, Value)
     else
     if TT.IsKindOf(k2_typNumAndDate) then
      Apply2NumAndDate(AtomIndex, Value)
     else
     if TT.IsKindOf(k2_typSub, [k2_typBlock, k2_typDocumentSub]) then
      Apply2Sub(AtomIndex, Value);
  except
   {$IfDef nsTest}
   raise;
   {$Else  nsTest}
   on E: Exception do
   begin
    l3System.Msg2Log('Ошибка присвоения атрибута %s элементу %s',
                     [
                      Tk2Attributes.Instance.NameByID(AtomIndex),
                      //GetEnumName(TypeInfo(_Tk2TagID), AtomIndex),
                      TT.AsString]);
    l3System.Exception2Log(E);
   end;
   {$EndIf nsTest}
  end;
end;

function TddDocumentGenerator.AddEvStyle(evStyle: Long): TddStyleEntry;
var
  l_StyleEv: TevStyleInterfaceEx;
  CurStyle: Long;
  l_Style: Tl3Variant;
  G : TevdAllParaEliminator;
  l_StyleEntry : TddStyleEntry;
begin
  Result := f_Document.StyleTable[evStyle];
  if (Result = nil) then
  begin
   l_StyleEv := TevStyleInterfaceEx.Create;
   try
    l_StyleEv.ForExport := true;
    l_StyleEv.SelectStyledObjectType(k2_typTextPara);
    CurStyle := evStyle;
    G := TevdAllParaEliminator.Create;
    // !!! SetTo тут нельзя использовать, т.к. там проблемы с FakeStarts и лишним CloseStructure !!!
    try
     G.Start;
     try
      G.Generator := Self;
      try
       while (CurStyle < 0) do
       begin
        {-пока не прервалась цепочка наследования стилей}
        l_StyleEntry := TddStyleEntry.Create;
        try
         l_StyleEntry.CHP.Language:= langRussian;
         l_Style:= l_StyleEv.SelectStyle(CurStyle);              
         CurStyle:= l_Style.IntA[k2_tiHandle];
         if l_StyleEv.Apply2Para then
          l_StyleEntry.StyleDef := sdParagraph
         else
          l_StyleEntry.StyleDef := sdCharacter;
         l_StyleEv.SaveCurrent(G);
         if OneStep then
          if f_Document.StyleTable[CurStyle] <> nil then
           CurStyle := f_Document.StyleTable[CurStyle].BasedOn
          else
           CurStyle := 0
         else
         begin
          f_Document.StyleTable[l_StyleEntry.Number] := l_StyleEntry;
          {!!! Заточка напильником  - по умолчанию все стили наследуются от NormalAnsi }
          if (l_StyleEntry.StyleDef = sdParagraph) and (l_StyleEntry.BasedOn = 222) and (l_StyleEntry.Number <> -1) then
          begin
           l_StyleEntry.BasedOn:= -1;
           CurStyle:= 222;
          end // if (l_StyleEntry.StyleDef = sdParagraph) and (l_StyleEntry.BasedOn = 222) and (l_StyleEntry.Number <> -1) then
          else
          { --- удалить  }
           CurStyle := l_StyleEntry.BasedOn
         end;
        finally
         FreeAndNil(l_StyleEntry);
        end;{try..finally}
       end;{while (CurStyle > 0)}
      finally
       G.Generator := nil;
      end;//try..finally
     finally
      G.Finish;
     end;//try..finally
    finally
     FreeAndNil(G);
    end;//try..finally
    if (l_StyleEv.Tag <> nil) and not l_StyleEv.VisibleToBlock then
     f_Document.CorrectStyles;
    Result := f_Document.StyleTable[evStyle];
   finally
    l3Free(l_StyleEv);
   end;{try..finally}
  end;
end;

procedure TddDocumentGenerator.AddStyleTable;
var
 SI : TevStyleInterfaceEx;
 G : Tk2TagGenerator;
begin
 // пробежаться по всем стилям и добавить их
 SI := TevStyleInterfaceEx.Make;
 try
  SI.ForExport := true;
  G := Self.Use;
  try
   TevdAllParaEliminator.SetTo(G);
   SI.Save(G);
  finally
   FreeAndNil(G);
  end;//try..finally
 finally
  l3Free(SI);
 end;{try..finally}
end;

procedure TddDocumentGenerator.AddSubRec;
begin
 if (f_SubRec <> nil) and (f_SubRec.ID <> 0) then
  f_SubList.Add(f_SubRec);
 l3Free(f_SubRec);
end;

procedure TddDocumentGenerator.Apply2Address(AtomIndex: Long; const Value:
        Tk2Variant);
begin
  case AtomIndex of
   k2Tags.k2_tiDocID : f_DocID := Value.AsInteger;
   k2Tags.k2_tiRevision : f_Revision := Value.AsInteger;
   k2Tags.k2_tiSubID : f_SubID := Value.AsInteger;
   k2Tags.k2_tiType  : f_TypeID := Value.AsInteger;
  end; // case
end;

procedure TddDocumentGenerator.Apply2Column(AtomIndex: Long; const Value:
        Tk2Variant);
begin
  case AtomIndex of
    k2Tags.k2_tiLeftIndent: Table.LastRow.LastCell.Props.LeftPad := Value.AsInteger;
    k2Tags.k2_tiWidth     : Table.LastRow.LastCell.Props.CellOffset := Value.AsInteger;
    k2Tags.k2_tiBackColor : Table.LastRow.LastCell.Props.PatternBackColor := Document.AddColor(VariantAsInteger(AtomIndex, Value));
    k2Tags.k2_tiForeColor : Table.LastRow.LastCell.Props.PatternForeColor := Document.AddColor(VariantAsInteger(AtomIndex, Value));
    k2_tiMergeStatus:
        if VariantAsInteger(AtomIndex, Value) = Ord(ev_msHead) then
         Table.LastRow.SetVMerged2LastCell(True)
        else
        if VariantAsInteger(AtomIndex, Value) = Ord(ev_msContinue) then
         Table.LastRow.SetVMerged2LastCell(False);
    k2_tiVerticalAligment: Table.LastRow.LastCell.Props.CellJust := TddCellJust(VariantAsInteger(AtomIndex, Value));
  end;//case AtomIndex
end;

procedure TddDocumentGenerator.Apply2Doc(AtomIndex: Long; const Value:
        Tk2Variant);
begin
  case AtomIndex of
   k2_tiInternalHandle: f_IntNumber:= Value.AsInteger;
   k2_tiExternalHandle: f_ExtNumber:= Value.AsInteger;
   k2Tags.k2_tiWidth: f_Document.DOP.xaPage:= Value.AsInteger;
   k2Tags.k2_tiHeight: f_Document.DOP.yaPage:= Value.AsInteger;
   k2Tags.k2_tiOrientation :
    if Value.Kind = k2_vkString then
     f_Document.DOP.Landscape := AnsiCompareText(Value.AsString.AsString, 'ev_poLandscape') = 0
    else
     f_Document.DOP.Landscape := Value.AsInteger = 1;
   k2Tags.k2_tiName: f_Document.Info.FullName.Assign(Value.AsString);
   k2Tags.k2_tiShortName: f_Document.Info.Title.Assign(Value.AsString);
   k2Tags.k2_tiLeftIndent: f_Document.DOP.xaLeft:= Value.AsInteger;
   k2Tags.k2_tiRightIndent: f_Document.DOP.xaRight:= Value.AsInteger;
  end;

end;

procedure TddDocumentGenerator.Apply2Font(AtomIndex: Long; const Value:
        Tk2Variant);
var
 tmpC  : LongInt;
 l_CHP : TddCharacterProperty;
 l_IntValue: Integer;
 l_BoolValue: Boolean;
begin
    if (AtomIndex <> k2_tiName) and ((Value.Kind = k2_vkInteger) or (Value.Kind = k2_vkString)) then
    begin
      l_IntValue:= VariantAsInteger(AtomIndex, Value);
      l_BoolValue:= Boolean(VariantAsInteger(AtomIndex, Value))
    end
    else
    begin
     l_BoolValue:= False;
     l_IntValue:= -propUndefined;
    end;

    if (f_StyleEntry <> nil) then
      l_CHP:= f_StyleEntry.CHP
    else
    if IsSeg then
      l_CHP:= f_Seg.CHP
    else
      l_CHP:= f_Para.CHP;
      
    case AtomIndex of
         k2Tags.k2_tiSize :
          if Abs(l_intValue) <> propUndefined then
           l_CHP.FontSize:= l_IntValue*2
          else
           l_CHP.FontSize:= l_IntValue;
         k2Tags.k2_tiIndex :
             begin
               case l_IntValue of
                 1: l_CHP.Pos:= cpSubscript;
                 2: l_CHP.Pos:= cpSuperscript;
               else
                l_CHP.Pos:= cpNotDefined
               end;
             end;
         k2Tags.k2_tiForeColor :
          if l_IntValue = -propUndefined then
           l_CHP.FColor:= l_IntValue
          else
           l_CHP.FColor:= f_Document.AddColor(l_IntValue);
         k2Tags.k2_tiBackColor :
          begin
           if l_IntValue = -propUndefined then
           begin
            l_CHP.Highlight:= l_IntValue;
            l_CHP.BColor:= l_IntValue;
           end
           else
           begin
            tmpC:= ColorToHighLight(l_IntValue);
            if (tmpC <> -1) then
             l_CHP.Highlight:= f_Document.AddColor(l_IntValue)
            else
             l_CHP.BColor:= f_Document.AddColor(l_IntValue);
           end;
          end; // k2_tiBackColor
        k2Tags.k2_tiBold:
             l_CHP.Bold:= l_BoolValue;
        k2Tags.k2_tiItalic:
             l_CHP.Italic:= l_BoolValue;
        k2Tags.k2_tiUnderline: if l_BoolValue then
             l_CHP.Underline:= TUnderline(l_IntValue);
        k2Tags.k2_tiName:
         if Value.Kind <> k2_vkTransparent then
         begin
          l_CHP.FontNumber:= f_Document.AddFont(Value.AsString.AsString, 204{надеюсь не будет проблем});
          l_CHP.FontName:= f_Document.FontNameByIndex(l_CHP.FontNumber);
         end
         else
         begin
          l_CHP.FontName:= '';
          l_CHP.FontNumber:= l_IntValue;
         end;
        k2Tags.k2_tiStrikeout:
         l_CHP.Strikeout:= l_BoolValue;
     end; {case AtomIndex}
end;

procedure TddDocumentGenerator.Apply2FramePart(AtomIndex: Long; const Value:
        Tk2Variant);
var
  l_Border: TddBorder;
begin
  case f_BorderOwner of
   boPara: l_Border:= f_Para.PAP.Border;
   boRow : l_Border:= Table.LastRow.TAP.Border;
   boCell: l_Border:= Table.LastRow.LastCell.Props.Border;
   else
    l_Border := nil;
  end; { f_BorderOwner }
  
  case AtomIndex of
    k2Tags.k2_tiForeColor: l_Border.FrameColor[f_CurFramePart]:= f_Document.AddColor(Value.AsInteger);
    k2Tags.k2_tiWidth    : l_Border.FrameWidth[f_CurFramePart]:= Value.AsInteger;
    k2Tags.k2_tiLineType : l_Border.FrameType[f_CurFramePart] := TddBorderType(Value.AsInteger+1);
  end; {case}
end;

procedure TddDocumentGenerator.Apply2NumAndDate(AtomIndex: Long; const Value: Tk2Variant);
begin
 if AtomIndex = k2_tiStart then
  Document.Info.CreateTime:= StDate2RTFDateTime(Max(Value.AsInteger, RTFDateTime2StDate(Document.Info.CreateTime)));
end;

procedure TddDocumentGenerator.Apply2Para(AtomIndex: Long; const Value: Tk2Variant);
var
 l_PAP     : TddParagraphProperty;
 l_CHP     : TddCharacterProperty;
 l_Para    : TddTextParagraph;
 l_StyleRt : TddStyleEntry;
begin
 if f_StyleEntry <> nil then
 begin
  l_PAP:= f_StyleEntry.PAP;
  l_Para:= nil;
  l_CHP:= f_StyleEntry.CHP;
 end
 else
 begin
  l_PAP := f_Para.PAP;
  l_Para:= f_Para;
  if IsSeg then
  begin
   l_CHP:= f_Seg.CHP;
   if f_Seg.IsObjectSegment then
    l_Para := f_Seg.Data as TddTextParagraph;
  end
  else
   l_CHP:= f_Para.CHP;
 end;

 case AtomIndex of
   k2_tiLeftIndent: l_PAP.xaLeft:= Value.AsInteger;
   k2_tiRightIndent: l_PAP.xaRight:= Value.AsInteger;
   k2_tiFirstIndent: l_PAP.xaFirst:= Value.AsInteger;
   k2_tiSpaceBefore: l_PAP.Before:= Value.AsInteger;
   k2_tiSpaceAfter: l_PAP.After:= Value.AsInteger;
   k2_tiJustification:
    begin
     l_PAP.Just:= k2JustToJust(TEvIndentType(VariantAsInteger(AtomIndex, Value)));
     if (l_PAP.JUST = justP) and (f_StyleEntry <> nil) then
     begin
      { В ближайшем будущем здесь будет описание дурацкого формата }
      f_StyleEntry.CHP.FontName:= def_ANSIDOSFontName;
      f_StyleEntry.PAP.xaLeft:= 0;
      f_StyleEntry.PAP.xaRight:= 0;
      f_StyleEntry.PAP.xaFirst:= 0;
     end; // (l_PAP.JUST := justP) and (f_StyleEntry <> nil)
   end;
   k2_tiVisible:
     begin
      l_CHP.Hidden:= not LongBool(VariantAsInteger(AtomIndex, Value));
      if not LongBool(Value.AsInteger) then
       l_CHP.Highlight := f_Document.AddColor(clLtGray);
     end;
   k2_tiBullet : l_PAP.Bullet := Value.AsInteger;
   k2_tiText :
      begin
        l_Para.Text   := Tl3String(Value.AsString);
        l_Para.Unicode:= (Value.AsString.AsWStr.SCodePage = cp_OEM) or (Value.AsString.AsWStr.SCodePage = cp_OEMLite);
      end;
   k2_tiStyle:
     begin { обработка стиля }
      l_StyleRt := AddEvStyle(Value.AsInteger);
      try
       if l_StyleRt <> nil then
       begin
        if l_Para <> nil then
         l_Para.Unicode := Value.AsInteger = ev_saTxtNormalOEM;
        if l_StyleRt.StyleDef = sdParagraph then
         l_PAP.Style := Value.AsInteger
        else
        if l_StyleRt.StyleDef = sdCharacter then
         l_CHP.Style := Value.AsInteger;
       end; // l_StyleRt <> nil
       TryToInitPrintFontSize(l_StyleRt, l_CHP);
      finally
       l_StyleRt:= nil;
      end;
     end;
   k2_tiPrintFontSize:
    l_CHP.PrintFontSize := Value.AsInteger * 2;
 end;
end;

procedure TddDocumentGenerator.Apply2Picture(AtomIndex: Long; const Value:
        Tk2Variant);
var
 l_Pic : TddPicture;
begin
 l_Pic := f_Picture;
 if (l_Pic = nil) then
  l_Pic := f_Seg.Data As TddPicture;
 Assert(l_Pic <> nil, 'Гарри, АУ!');
 case AtomIndex of
   k2_tiData: { собственно картинка }
     begin
      l_Pic.Stream:= Value.AsStream;
     end;//k2_tiData
   k2_tiWidth : { ширина на экране }
     begin
       l_Pic.GoalX:= Value.AsInteger;
     end;
   k2_tiHeight: { высота на экране }
     begin
       l_Pic.GoalY:= Value.AsInteger;
     end;
 end; { AtomIndex }
end;

procedure TddDocumentGenerator.Apply2Row(AtomIndex: Long; const Value:
        Tk2Variant);
begin
  {}
end;

procedure TddDocumentGenerator.Apply2Sect(AtomIndex: Long; const Value:
        Tk2Variant);
begin
  if f_Sect <> nil then
  case AtomIndex of
    k2_tiHeight: f_Sect.SEP.yaPage:= Value.AsInteger;
    k2_tiWidth: f_Sect.SEP.xaPage:= Value.AsInteger;
    k2_tiLeftIndent: f_Sect.SEP.xaLeft:= Value.AsInteger;
    k2_tiRightIndent: f_Sect.SEP.xaRight:= Value.AsInteger;
    k2_tiOrientation: f_Sect.SEP.Landscape:= VariantAsInteger(AtomIndex, Value) = ord(ev_poLandscape);
  end;
end;

procedure TddDocumentGenerator.Apply2Segment(AtomIndex: Long; const Value:
        Tk2Variant);
var
 l_Seg    : TddTextSegment;
 f_StyleRt: TddStyleEntry;
begin
  if (f_Seg <> nil) then
  begin
    case AtomIndex of
     k2_tiHandle: f_Seg.HLHandle:= Value.AsInteger;
      k2_tiStart: f_Seg.Start:= Value.AsInteger-1;
      k2_tiFinish: f_Seg.Stop:= Value.AsInteger-1;
      k2_tiStyle:
       begin
        f_StyleRt:= AddEvStyle(Value.AsInteger);
        if f_StyleRt <> nil then
        try
         f_Seg.CHP.Style:= Value.AsInteger;
        finally
         f_StyleRt:= nil;
        end;
       end; // k2_tiStyle
      k2_tiVisible:
       if IsSeg then
       begin
        if Value.Kind = k2_vkTransparent then
         f_Seg.CHP.Hidden:= False
         { TODO -oNarry : Предусмотреть установку значния Undefined }
        else
         f_Seg.CHP.Hidden:= not LongBool(VariantAsInteger(AtomIndex, Value));
        if f_Seg.CHP.Hidden then
         f_Seg.CHP.Highlight:= f_Document.AddColor(clLtGray)
        else
         f_Seg.CHP.Highlight:= propUndefined;
       end
       else
       begin
        if Value.Kind = k2_vkTransparent then
         f_Para.CHP.Hidden:= False
         { TODO -oNarry : Предусмотреть установку значния Undefined }
        else
         f_Para.CHP.Hidden:= not LongBool(VariantAsInteger(AtomIndex, Value));
        if f_Para.CHP.Hidden then
         f_Para.CHP.Highlight:= f_Document.AddColor(clLtGray)
        else
         f_Seg.CHP.Highlight:= propUndefined;
       end; // IsSeg
     k2_tiURL: begin
       if not f_Seg.IsHyperlink then
       begin
        l_Seg := TddHyperlink.Create;
        l_Seg.Assign(f_Seg);
        FreeAndNil(f_Seg);
        f_Seg := l_Seg;
       end; // if not (f_Seg is TddHyperlink) then
       f_Seg.URL := (Value.AsString as Tl3String);
      end;
    end; // case
  end
end;

procedure TddDocumentGenerator.Apply2Style(AtomIndex: Long; const Value:
        Tk2Variant);
begin
 if Value.Kind <> k2_vkTransparent then
   case AtomIndex of
     k2_tiHandle:
      begin
       f_StyleEntry.Number := Value.AsInteger;
       { напильник }
       if Value.AsInteger = ev_saTxtNormalANSI then
       begin
        f_StyleEntry.PAP.JUST := justF;
        f_StyleEntry.PAP.xaFirst := 720;
        f_StyleEntry.PAP.IsDefault := True;
        f_StyleEntry.CHP.FontSize := 20;
        f_StyleEntry.CHP.FontNumber := f_Document.AddFont('Arial Cyr', 204);
        f_StyleEntry.CHP.FontName := f_Document.FontNameByIndex(f_StyleEntry.CHP.FontNumber);
        f_StyleEntry.CHP.IsDefault := True;
       end; // Value.AsInteger = ev_saTxtNormalANSI
       { конец напильника }
      end; // k2_tiHandle:
     k2_tiFirstIndent: f_StyleEntry.PAP.xaFirst := Value.AsInteger;
     k2_tiLeftIndent : f_StyleEntry.PAP.xaLeft := Value.AsInteger;
     k2_tiRightIndent : f_StyleEntry.PAP.xaRight := Value.AsInteger;
     k2_tiSpaceBefore: f_StyleEntry.PAP.Before := Value.AsInteger;
     k2_tiSpaceAfter: f_StyleEntry.PAP.After := Value.AsInteger;
     k2_tiJustification:
       begin
         f_StyleEntry.PAP.Just := k2JustToJust(TEvIndentType(Value.AsInteger));
         (* Хакерская заточка напильником *)                
         if TEvIndentType(Value.AsInteger) = ev_itPreformatted then
         begin
           if f_StyleEntry.CHP.IsDefault then
           begin
            f_StyleEntry.CHP.FontName := def_ANSIDOSFontName;
            f_StyleEntry.CHP.FontNumber := f_Document.AddFont(def_ANSIDOSFontName, 204);
           end; // f_StyleEntry.CHP.IsDefault
           if f_StyleEntry.PAP.IsDefault then
           begin
            f_StyleEntry.PAP.xaLeft  := 0;
            f_StyleEntry.PAP.xaRight := 0;
            f_StyleEntry.PAP.xaFirst := 0;
           end; // f_StyleEntry.PAP.IsDefault
         end;
         (* конец заточки *)
       end;
     k2_tiStyle: f_StyleEntry.Basedon := Value.AsInteger;
     k2_tiName : f_StyleEntry.AsString := Value.AsString.AsString;
     k2_tiVisible:
      begin
       f_StyleEntry.CHP.Hidden := not LongBool(VariantAsInteger(AtomIndex, Value));
       if not LongBool(Value.AsInteger) then
         f_StyleEntry.CHP.Highlight := f_Document.AddColor(clLtGray)
       else
         f_StyleEntry.CHP.Highlight := propUndefined;
      end;
     k2_tiAllowHyphen: f_StyleEntry.PAP.Hyph := LongBool(Value.AsInteger);
   end;
end;

procedure TddDocumentGenerator.Apply2Sub(AtomIndex: Long; const Value:
        Tk2Variant);
begin
 if (AtomIndex = k2_tiHandle) then
  if (Value.Kind = k2_vkInteger) then
   f_SubRec.ID := Value.AsInteger
  else
   ConvertErrorEx(Value.Kind)
 else
 if (AtomIndex = k2_tiShortName) then
  if (Value.Kind = k2_vkString) then
  begin
   f_SubRec.Name.Assign(Value.AsString);
   f_SubRec.IsRealName := True;
  end // if (Value.Kind=k2_vkString) then
  else
   ConvertErrorEx(Value.Kind)
end;

procedure TddDocumentGenerator.Apply2Table(AtomIndex: Long; const Value: Tk2Variant);
var
 l_StyleRt : TddStyleEntry;
begin
 case AtomIndex of
  k2_tiLeftIndent:
     Table.LeftIndent := Value.AsInteger;
  k2_tiWidth: ;
  k2_tiZoom:
   Table.Scale := Value.AsInteger;
  k2_tiStyle:
    begin { обработка стиля }
     l_StyleRt := AddEvStyle(Value.AsInteger);
     try
      if (l_StyleRt <> nil) and (l_StyleRt.StyleDef = sdParagraph) then
       Table.Style := Value.AsInteger;
     finally
      l_StyleRt:= nil;
     end;
    end;
 end
end;

procedure TddDocumentGenerator.Apply2TabStop(AtomIndex: Long; const Value:
        Tk2Variant);
var
 l_Tab: TddTab;
begin
 l_Tab := f_Para.PAP.TabList.Last;
 case AtomIndex of
  k2_tiStart: l_Tab.TabPos := Value.AsInteger;
  k2_tiType:
   case Tl3TabStopStyle(Value.AsInteger) of
    l3_tssLeft   : l_Tab.Kind := tkLeft;
    l3_tssRight  : l_Tab.Kind := tkRight;
    l3_tssCenter : l_Tab.Kind := tkCentered;
    l3_tssDecimal: l_Tab.Kind := tkDecimal;
   end;
  k2_tiText:
   case Value.AsString.AsWStr.S[0] of
    '.' : l_Tab.TabLead := tlDots;
    cc_HardSpaceSymbol : l_Tab.TabLead:= tlMiddleDots;
    '-' : l_Tab.TabLead := tlHyphens;
    '_' : l_Tab.TabLead := tlUnderline;
    '=' : l_Tab.TabLead := tlEqualSign;
   end;
 end;
end;

procedure TddDocumentGenerator.CalcJoinedWidth(aEtalonRowIndex: Integer);
var
 i           : Integer;
 j, k        : Integer;
 l_Row       : TddTableRow;
 l_EtalonRow : TddTableRow;
 l_CellProp  : TddCellProperty;
 l_CellProp2 : TddCellProperty;
 l_Delta     : Integer;
 l_Delta2    : Integer;
 l_Index     : Integer;
begin
 l_EtalonRow := Table.Rows[aEtalonRowIndex];
 for i := 0 to Pred(Table.RowCount) do
 begin
  if i <> aEtalonRowIndex then
  begin
   l_Row:= Table.Rows[i];
   for j := 0 to l_Row.CellCount - 1 do
   begin
    l_CellProp := l_Row.Cells[j].Props;
    if j > 0 then
    begin
     l_Delta := 0;
     l_Index := 0;
     for k := 0 to j do
     begin
      Inc(l_Delta, l_Row.Cells[k].Props.CellOffset);
      Inc(l_Index, l_Row.Cells[k].Props.CellSpan);
     end;
     l_Index := Pred(l_Index);
    end
    else
    begin
     l_Delta := l_CellProp.CellOffset;
     l_Index := l_CellProp.Index;
    end;
    if l_CellProp.VMerged then
    begin
     l_CellProp2 := FindMergedHead(i, l_CellProp.Index);
     if l_CellProp2 <> nil then
     begin
      if l_CellProp2.Index > 0 then
      begin
       l_Delta := 0; l_Index := 0;
       for k := 0 to l_CellProp2.Index do
       begin
        Inc(l_Delta, l_Row.Cells[k].Props.CellOffset);
        Inc(l_Index, l_Row.Cells[k].Props.CellSpan);
       end;
       l_Index := Pred(l_Index);
      end
     end
     else
      l_Delta := -1;
    end;
    l_CellProp2 := l_EtalonRow.CellPropByPos[l_Delta];
    if (l_CellProp2 <> nil) and (l_CellProp2.Index > l_Index) then
    begin
     if l_Index > 0 then
     begin
      l_Delta2 := 0;
      for k := 0 to l_Index do
       Inc(l_Delta2, l_EtalonRow.Cells[k].Props.CellOffset);
     end
     else
      l_Delta2 := l_CellProp2.CellOffset;
     if (l_Delta / l_Delta2 * 100) > 105 then
      l_CellProp.CellSpan := l_CellProp2.Index - l_Index + 1;
    end;
   end; // for j
  end; // i <> aEtalonRowIndex
 end; // for i;
end;

procedure TddDocumentGenerator.CheckHeader;
var
 l_CT: Tk2Type;
begin
 if OneStep then
 begin
  l_CT := CurrentType;
  if l_CT.IsKindOf(k2_typDocument) or l_CT.IsKindOf(k2_typTextPara) or
     (l_CT.IsKindOf(k2_typSub) and not l_CT.IsKindOf(k2_typDocumentSub)) or
     l_CT.IsKindOf(k2_typSectionBreak) or l_CT.IsKindOf(k2_typTable) then
  begin
   if not f_HeaderWritten then
    WriteDocumentHeader;
  end;
 end;
end;

procedure TddDocumentGenerator.CloseStructure(NeedUndo: Bool);
var
 TT: Tk2Type;
begin
 CheckHeader;
 TT:= CurrentType;
 if TT <> nil then
 begin
   if TT.IsKindOf(k2_typDocument) then
    CloseDocument
   else
   if TT.IsKindOf(k2_typBlock) then
   begin
    AddSubRec;
    DoCloseBlock;
   end
   else
   if TT.IsKindOf(k2_typTextPara) then
    CloseParagraph(TT.IsKindOf(k2_typDecorTextPara))
   else
   if TT.IsKindOf(k2_typBitmapPara) then
   begin
     { конец картинки }
    if (f_Picture = nil) then
     //Document._AddAtom(f_Seg.Data)
    // - ничего не надо добавлять, т.к. добавится вместе с параграфом
    else
    begin
     if Table <> nil then
      Table.LastRow.LastCell.Add(f_Picture)
     else
     Document._AddAtom(f_Picture);
     l3Free(f_Picture);
     f_BorderOwner := boNone;
    end;//f_Picture = nil
   end
   else
   if TT.IsKindOf(k2_typSegmentsLayer) then
   begin
     { очистка списка сегментов }
   end
   else
   if TT.IsKindOf(k2_typTextSegment) {and not TT.IsKindOf(k2_typHyperlink) }then
   begin
     { добавление сегмента }
     if (f_Para <> nil) then
     // - иначе ломается с сегментами, со вложенными параграфами !!!
      f_Para.AddSegment(f_Seg);
     l3Free(f_Seg);
   end
   else
   if TT.IsKindOf(k2_typTable) then
    { Конец таблицы }
    CloseTable
   else
   if TT.IsKindOf(k2_typTableRow) then
   begin
    CloseTableRow;
   end
   else
   if TT.IsKindOf(k2_typTableCell) then
    CloseCell
   else
   if TT.IsKindOf(k2_typAddress) and (f_Seg <> nil) then
   begin
   { TODO -oДудко Дмитрий -cРазвитие : Предусмотреть добавление информации о мультиссылке, для того, чтобы можно было покрасить текст в зеленый цвет }
    f_DocID := IfThen(f_DocID = 0, f_ExtNumber, f_DocID);
    if IsCorrectTypeID then
     if ValidExternalID(f_DocID) then AddTarget;
   end
   else
   if TT.IsKindOf(k2_typSectionBreak) then
   begin
     Document._AddAtom(f_Sect);
     l3Free(f_Sect);
   end
   else
   If TT.IsKindOf(k2_typSub) and not TT.IsKindOf(k2_typBlock) and
     Not TopType[0].IsKindOf(k2_typDocumentSub) then
    Begin
     If (f_SubRec.ID > 0) then
      AddSubRec;
    end // k2_idSub
    else
    if TT.IsKindOf(k2_typStyle) {and OneStep} then
    begin
     if f_StyleEntry.StyleDef = sdParagraph then
      f_StyleEntry.PAP.Style:= f_StyleEntry.Number;
     Document.StyleTable[f_StyleEntry.Number] := f_StyleEntry;
     l3Free(f_StyleEntry);
    end;
 end;
 inherited;
end;

procedure TddDocumentGenerator.FillDefaultValues;
var
  l_Default: Integer;
  SI: TevStyleInterfaceEx;
  l_StyleEv: TevStyleInterfaceEx;
  l_StyleRt: TddStyleEntry;
  i: Integer;
  G : TevdAllParaEliminator;
begin
 Document.ResetToDefault;
 with k2_typDocument do
 begin
  l_Default := Tk2Prop(Prop[k2_tiLeftIndent]).DefaultValue;
  if (l_Default <> l3NilLong) then
   f_Document.DOP.xaLeft:= l_Default;
  l_Default := Tk2Prop(Prop[k2_tiRightIndent]).DefaultValue;
  if (l_Default <> l3NilLong) then
   f_Document.DOP.xaRight:= l_Default;
  l_Default := Tk2Prop(Prop[k2_tiWidth]).DefaultValue;
  if (l_Default <> l3NilLong) then
   f_Document.DOP.xaPage:= l_Default;
 end;//with k2_typDocument
 SI := TevStyleInterfaceEx.Make;
 try
  SI.ForExport := true;
  G := TevdAllParaEliminator.Create;
  // !!! SetTo тут нельзя использовать, т.к. там проблемы с FakeStarts и лишним CloseStructure !!!
  try
   G.Start;
   try
    G.Generator := Self;
    try
     SI.Save(G);
    finally
     G.Generator := nil;
    end;//try..finally
   finally
    G.Finish;
   end;//try..finally
  finally
   FreeAndNil(G);
  end;//try..finally
  finally                              
   l3Free(SI);
  end;//try..finally
  l_StyleEv := TevStyleInterfaceEx.Create;
  try
   l_StyleEv.ForExport := true; // ?

   l_StyleEv.SelectStyledObjectType(k2_typTextPara);
   for i:= 0 to Pred(Document.StyleCount) do
   begin
    l_StyleRt:= Document.StyleSheet[i];
    l_StyleEv.SelectStyle(l_StyleRt.Number);
    if l_StyleEv.Apply2Para then
    begin
     l_StyleRt.StyleDef:= sdParagraph;
     l_StyleRt.PAP.Style:= l_StyleRt.Number;
    end//l_StyleEv.Apply2Para
    else
    begin
     l_StyleRt.StyleDef:= sdCharacter;
     l_StyleRt.CHP.Style:= l_StyleRt.Number;
    end;//l_StyleEv.Apply2Para
    //  Очередная заточка - общий предок - NormalANsi
    if (l_StyleRt.BasedOn = 222) and
       (l_StyleRt.Number <> ev_saTxtNormalANSI) then
     l_StyleRt.BasedOn:= ev_saTxtNormalANSI;
   end; // for i
   Document.CorrectStyles;
  finally
   l3Free(l_StyleEv);
  end;//try..finally
 CorrectStyles;
end;

function TddDocumentGenerator.GetFilerFileName: AnsiString;
begin
  Result:= '';
  if (Filer <> nil) then
  begin
   if (Filer is Tl3CustomDOSFiler) then
    Result:= Tl3CustomDOSFiler(Filer).FileName
   else
    Result:= Filer.Identifier;
  end;//Filer <> nil
end;

function TddDocumentGenerator.IsSeg: Boolean;
begin
  Result:= f_Seg <> nil;
end;

procedure TddDocumentGenerator.OpenStream;
begin
  inherited;
  f_BorderOwner := boNone;
end;

procedure TddDocumentGenerator.Cleanup;
begin
 FreeAndNil(f_Tables);
 l3Free(f_ExternalIDList);
 l3Free(f_Para);
 l3Free(f_StyleEntry);
 l3Free(f_ColorEntry);
 l3Free(f_FontEntry);
 l3Free(f_SubList);
 l3Free(f_Document);
 inherited;
end;

procedure TddDocumentGenerator.CloseCell;
begin
 f_BorderOwner := boRow;
end;

procedure TddDocumentGenerator.CloseDocument;
begin
 { Конец нового документа }
 if not OneStep then
 begin
  Document.f_DOP.Landscape := Document.f_DOP.xaPage > Document.f_DOP.yaPage;
  f_Document.FinalCorrectStyles;
  WriteDocument;
 end
 else
  WriteDocumentEnd;
 if Generator <> nil then
  Document.Clear;
end;

procedure TddDocumentGenerator.CloseParagraph(aDecorPara: Boolean);
var
 l_Para: TddTextParagraph;
begin
 { Конец нового абзаца }
 if not TopType[1].IsKindOf(k2_typObjectSegment) then
 begin
  f_Para.SubList.Assign(f_SubList);
  l_Para := f_Document.LastPara;
  f_Para.CorrectSegments(l_Para);
  if (Abs(f_Para.PAP.xaFirst) <> propUndefined) and (Abs(f_PARA.PAP.xaLeft) <> propUndefined) then
   f_Para.PAP.xaFirst:= f_Para.PAP.xaFirst - f_Para.PAP.xaLeft;

  CorrectParaFonts(f_Para);
  if Table <> nil then
  begin                                            
   f_Para.PAP.Intable := True;
   if f_Para.PAP.Style >= 0 then
    f_Para.PAP.Style := ev_saNormalTable;
   Table.LastRow.LastCell.Add(f_Para)
  end // if Table <> nil then
  else
  begin
   CheckFilterPara(aDecorPara);
   f_Para.BlockIndent := BlockIndent;
   f_Para.IgnoreLeftIndent := IgnoreLeftIndent;
   Document._AddAtom(f_Para);
  end;
  f_SubList.Clear;
  l3Free(f_Para);
 end;
 f_BorderOwner := boNone;
end;

procedure TddDocumentGenerator.CloseTable;
begin
 if Table.RowCount > 0 then
  Table.LastRow.TAP.IsLastRow := True;
 WriteTablePart(False);
 f_Tables.DeleteLast;
 f_BorderOwner := boNone;
end;

procedure TddDocumentGenerator.CloseTableRow;
const
 cnWritableRowCount = 100;
var
 l_Table  : TddTable;
 l_LastRow: TddTableRow;
begin
 l_Table := Table;
 if (l_Table <> nil) and not l_Table.Nested then
 begin
  l_LastRow := l_Table.LastRow;
  if (l_LastRow <> nil) and not l_LastRow.HasMerged and (l_Table.RowCount > cnWritableRowCount) then
  begin
   WriteTablePart(True);
   l_Table.StartRow := l_Table.RowCount;
   l_Table.ClearRows;
  end; // if (l_LastRow <> nil) and not l_LastRow.HasMerged and (l_Table.RowCount > 100) then
 end; // if (l_Table <> nil) and not l_Table.Nested then
 f_BorderOwner := boNone;
end;

procedure TddDocumentGenerator.CorrectStyles;
begin
 Document.CorrectStyles;
 Document.FinalCorrectStyles;
end;


procedure TddDocumentGenerator.SetOneStep(Value: Boolean);
begin
  if f_OneStep <> Value then
  begin
    f_OneStep := Value;
    Document.OneStep:= OneStep;
  end;
end;

procedure TddDocumentGenerator.StartChild(TypeID: Tl3VariantDef);
var
 TT        : Tk2Type;
begin
  inherited;
  TT:= CurrentType;
  if TT.IsKindOf(k2_typDocument) then
   StartDocument
  else
  if TT.IsKindOf(k2_typBlock) then
   StartBlock
  else
  if TT.IsKindOf(k2_typTextPara) then
   StartParagraph
  else
  if TT.IsKindOf(k2_typBitmapPara) then
   StartPicture
  else
  if TT.IsKindOf(k2_typSegmentsLayer) then
   StartSegmentLayer
  else
  if TT.IsKindOf(k2_typTextSegment) {and not TT.IsKindOf(k2_typHyperlink)} then
   StartSegment
  else
  if TT.IsKindOf(k2_typAddress) then
   StartAddress
  else
  if TT.IsKindOf(k2_typTable) then
   StartTable(TT.IsKindOf(k2_typSBS))
  else
  if TT.IsKindOf(k2_typTableRow) then
   StartTableRow(Table.IsSBS or TT.IsKindOf(k2_typReqRow))
  else
  if TT.IsKindOf(k2_typTableCell) then
   StartTableCell
  else
  if TT.IsKindOf(k2_typPageBreak) and not TT.IsKindOf(k2_typSectionBreak) then
   StartPageBreak
  else
  if TT.IsKindOf(k2_typSectionBreak) then
   StartSectionBreak
  else
  if TT.IsKindOf(k2_typTabStop) then
   StartTabStop
  else
  { TODO -oNarry -cРазвитие : Включить разбор блоков }
  if TT.IsKindOf(k2_typSub, [k2_typBlock, k2_typDocumentSub]) then
   StartSub
  else
  if TT.IsKindOf(k2_typStyle){ and OneStep} then
    f_StyleEntry:= TddStyleEntry.Create;
end;

procedure TddDocumentGenerator.StartTag(TagID: Long);
var
 l_Type: TddBorderType;

 procedure lp_SetBorder(const aBorder: TddBorder);
 begin
  with aBorder do
  begin
   FrameColor[f_CurFramePart] := clBlack;
   FrameWidth[f_CurFramePart] := 10;
   FrameType[f_CurFramePart]  := l_Type;
  end;
 end;

begin
  inherited;
  if TagID in [k2_tiFrame, k2_tiFrameUp, k2_tiFrameLeft, k2_tiFrameDown, k2_tiFrameRight] then
  begin
    l_Type := btSingleThick;
    case TagID of
      k2_tiFrame     :
       begin
        f_CurFramePart := bpBox;
        l_Type := btNone;
       end;
      k2_tiFrameUp   : f_CurFramePart:= bpTop;
      k2_tiFrameLeft : f_CurFramePart:= bpLeft;
      k2_tiFrameDown : f_CurFramePart:= bpBottom;
      k2_tiFrameRight: f_CurFramePart:= bpRight;
    end;
    case f_BorderOwner of
      boNone: if f_StyleEntry <> nil then
               lp_SetBorder(f_StyleEntry.PAP.Border);
      boChar:;
      boPara: lp_SetBorder(f_Para.PAP.Border);
      boRow : lp_SetBorder(Table.LastRow.TAP.Border);
      boCell: lp_SetBorder(Table.LastRow.LastCellproperty.Border);
    end; // case f_BorderOwner of
  end;
end;

procedure TddDocumentGenerator.WriteAtom2Filer(aAtom: TddDocumentAtom; aPart: Boolean);
begin
 if aAtom.IsTextPara then
  WriteTextParagraph(TddTextParagraph(aAtom))
 else
  if aAtom.IsRow then
   WriteTableRow(TddTableRow(aAtom), 0)
  else
   if aAtom.IsTable then
    WriteTable(TddTable(aAtom), aPart)
   else
    if aAtom.IsPicture then
     WritePicture(TddPicture(aAtom), True)
    else
     if aAtom.IsBreak then
      WriteBreak(TddBreak(aAtom));
end;

procedure TddDocumentGenerator.WriteBreak(const aBreak: TddBreak);
begin
end;

procedure TddDocumentGenerator.WriteColorTable(aDefault: Boolean = False);
begin
end;

procedure TddDocumentGenerator.WriteDocument;
begin
  WriteDocumentStart;
  WriteDocumentHeader;
  WriteDocumentBody;
  WriteDocumentEnd;
end;

procedure TddDocumentGenerator.WriteDocumentBody;
var
 i   : Integer;
 l_A : TddDocumentAtom;
begin
 for i:= 0 to Document.Paragraphs.Hi do
 begin
  l_A := Document.Paragraphs[i];
  WriteAtom2Filer(l_A, False);
 end; // for i
end;

procedure TddDocumentGenerator.WriteDocumentEnd;
begin
end;

procedure TddDocumentGenerator.WriteDocumentHeader;
begin
 WriteFontTable;
 WriteColorTable;
 WriteStyleTable;
 WriteHeader;
 f_HeaderWritten := True;
end;

procedure TddDocumentGenerator.WriteDocumentStart;
begin
end;

procedure TddDocumentGenerator.WriteFontTable(aDefault: Boolean = False);
begin
end;

procedure TddDocumentGenerator.WriteHeader(aDefault: Boolean = False);
begin
end;

procedure TddDocumentGenerator.WritePicture(const Picture: TddPicture;
    aWholePar: Boolean);
begin
end;

procedure TddDocumentGenerator.WriteStyleTable(aDefault: Boolean = False);
begin
end;

procedure TddDocumentGenerator.WriteTable(const aTable: TddTable; aOnlyPart: Boolean);
begin
end;

procedure TddDocumentGenerator.WriteTableRow(const aRow: TddTableRow; anIndex: Integer; const aTableType: TddTableType = dd_ttNone; aRowPos: TddRowPosition = dd_rpNone);
begin
end;

procedure TddDocumentGenerator.WriteTextParagraph(const Para: TddTextParagraph; anOutEOL: Boolean = False);
begin
end;

procedure TddDocumentGenerator.CorrectParaFonts(aPara: TddTextParagraph);

 function UnicodeFontNumber(aFontNumber: Integer): Integer;
 var
  l_FontNumber: Integer;
 begin
  if aFontNumber = propUndefined then
   l_FontNumber:= 0
  else
   l_FontNumber:= aFontNumber;
  Result:= Document.AddFont(Document.FontTable[l_FontNumber].AsString, 0)
 end;
 
var
 i: Integer;
begin
 { Проверяем кодировку текста. Если она CP_WesternWin, нужно заменить все шрифты на
   уникодные }
 if aPara.Text.CodePage = CP_WesternWin then
 begin
  aPara.CHP.FontNumber:= UnicodeFontNumber(aPara.CHP.FontNumber);
  for i:= 0 to Pred(aPAra.SegmentCount) do
   aPara.Segments[i].CHP.FontNumber:= UnicodeFontNumber(aPara.Segments[i].CHP.FontNumber);
 end;
end;

function TddDocumentGenerator.FindMergedHead(aRowIndex: Integer; aCellIndex: Integer): TddCellProperty;
var
 i: Integer;
begin
 Result := nil;
 for i:= Pred(aRowIndex) downto 0 do
 begin
  if aCellIndex < Table.Rows[i].CellCount then
   if Table.Rows[i].Cells[aCellIndex].Props.VMergeFirst then
   begin
    Result := Table.Rows[i].Cells[aCellIndex].Props;
    break;
   end;
 end;
end;

function TddDocumentGenerator.pm_GetTable: TddTable;
begin
 if not f_Tables.Empty then
  Result := f_Tables.Last
 else
  Result:= nil;
end;

procedure TddDocumentGenerator.pm_SetExternalIDList(Value: Tl3LongintList);
begin
 if f_ExternalIDList <> Value then
 begin
  f_ExternalIDList.Assign(Value);
 end;
end;

procedure TddDocumentGenerator.pm_SetTable(Value: TddTable);
begin
 f_Tables.Add(Value);
end;

procedure TddDocumentGenerator.StartAddress;
begin
 f_DocID:= 0;
 f_SubID:= 0;
 f_TypeID:= 0;
end;

procedure TddDocumentGenerator.StartBlock;
begin
 if (f_SubRec <> nil) and (f_SubRec.ID > 0) then
  AddSubRec;

 f_SubRec:= TddSub.Create;
 DoStartBlock;
end;

procedure TddDocumentGenerator.StartDocument;
begin
 { Начало нового документа }
 if OneStep then
 begin
  FillDefaultValues;
  WriteDocumentStart;
  f_HeaderWritten := False;
 end
 else
 begin
  Document.ResetToDefault;
  AddStyleTable;
 end;
 DoStartDocument;
end;

procedure TddDocumentGenerator.StartPageBreak;
begin
 f_Sect:= TddBreak.Create(nil);
 try
  f_Sect.BreakType:= breakPage;
  f_Sect.Stored := NeedWritePara;
  Document._AddAtom(f_Sect);
 finally
  l3Free(f_Sect);
 end;
end;

procedure TddDocumentGenerator.StartParagraph;
var
 l_P  : TddTextParagraph;
 l_Seg: TddTextSegment;
begin
 if TopType[1].IsKindOf(k2_typObjectSegment) then
 begin
  l_P := TddTextParagraph.Create(nil);
  try
   if CurrentType.IsKindOf(k2_typFormula) then
   begin
    l_Seg := TddFormulaSegment.Create;
    l_Seg.Assign(f_Seg);
    FreeAndNil(f_Seg);
    f_Seg := l_Seg;
   end; // if CurrentType.IsKindOf(k2_typFormula) then
   f_Seg.Data := l_P;
  finally
   l3Free(l_P);
  end;
 end
 else
 begin
  if f_SubRec <> nil then
   AddSubRec;
    { Начало нового абзаца }
  f_Para := TddTextParagraph.Create(nil);
  f_Para.Stored := NeedWritePara;
 end;
 f_BorderOwner := boPara;
end;

procedure TddDocumentGenerator.StartPicture;
var
 l_Seg  :  TddTextSegment;
 l_Para : TddDocumentAtom;
begin
 { Начало картинки }
 if TopType[1].IsKindOf(k2_typObjectSegment) then
 begin
  l_Para := TddPicture.Create(nil);
  try
   if not (f_Seg is TddPictureSegment) then
   begin
    l_Seg := TddPictureSegment.Create;
    l_Seg.Assign(f_Seg);
    FreeAndNil(f_Seg);
    f_Seg := l_Seg;
   end; // if not (f_Seg is TddPictureSegment) then
   f_Seg.Data:= l_Para;
  finally
   l3Free(l_Para);
  end;
 end // if TopType[1].IsKindOf(k2_typObjectSegment) then
 else
 begin
  f_Picture:= TddPicture.Create(nil);
  f_Picture.Stored := NeedWritePara;
  f_Picture.BlockIndent := Self.BlockIndent;
  f_Picture.IgnoreLeftIndent := Self.IgnoreLeftIndent;
 end;
 f_BorderOwner := boPara;
end;

procedure TddDocumentGenerator.StartSectionBreak;
begin
 f_Sect:= TddBreak.Create(nil);
 f_Sect.BreakType:= breakSection;
 f_Sect.SEP.xaLeft := Document.DOP.xaLeft;
 f_Sect.SEP.xaRight := Document.DOP.xaRight;
end;

procedure TddDocumentGenerator.StartSegment;
var
 l_StyleEntry: TddStyleEntry;
begin
 if CurrentType.IsKindOf(k2_typHyperLink) then
 begin
  f_Seg := TddHyperlink.Create;
  f_Seg.CHP := f_Para.CHP;   
  l_StyleEntry := AddEvStyle(ev_saHyperLink);
  if l_StyleEntry <> nil then
   f_Seg.CHP.MergeWith(l_StyleEntry.CHP);
  f_Seg.CHP.Style := ev_saHyperlink;
 end // if CurrentType.IsKindOf(k2_typHyperLink) then
 else
 if CurrentType.IsKindOf(k2_typObjectSegment) then
 begin
  f_Seg := TddPictureSegment.Create;
  f_Seg.CHP := f_Para.CHP; // наследуем оформление от абзаца
 end // if CurrentType.IsKindOf(k2_typObjectSegment) then
 else
 begin
  f_Seg := TddStyleSegment.Create;
  f_Seg.CHP := f_Para.CHP; // наследуем оформление от абзаца
 end;
end;

procedure TddDocumentGenerator.StartSegmentLayer;
begin
 { очистка списка сегментов }
end;

procedure TddDocumentGenerator.StartSub;
begin
 if (f_SubRec <> nil) and (f_SubRec.ID > 0) then
  AddSubRec;

 f_SubRec:= TddSub.Create;
end;

procedure TddDocumentGenerator.StartTable(aSBS: Boolean);
var
 l_Table      : TddTable;
 l_BlockIndent: Integer;
begin
 l_Table := TddTable.Create(nil);
 try
  l_Table.IsSBS := aSBS;
  l_Table.Stored := NeedWritePara;
  l_BlockIndent := Self.BlockIndent;
  if l_BlockIndent <> propUndefined then
   l_Table.LeftIndent := l_BlockIndent;
  l_Table.Nested := not f_Tables.Empty;
  f_BorderOwner := boRow;
  Table := l_Table;
 finally
  FreeAndNil(l_Table);
 end;
end;

procedure TddDocumentGenerator.StartTableCell;
var
 l_Cell: TddTableCell;
begin
 l_Cell := TddTableCell.Create(nil);
 try
  CheckBorderInSBS(l_Cell.Props.Border);
  Table.LastRow.AddCell(l_Cell);
  f_BorderOwner := boCell;
 finally
  FreeAndNil(l_Cell);
 end;
end;

procedure TddDocumentGenerator.StartTableRow(aAutoFit: Boolean);
var
 l_Row: TddTableRow;
begin
 l_Row := TddTableRow.Create(nil);
 try
  l_Row.TAP.AutoFit := aAutoFit;
  f_BorderOwner := boRow;
  CheckBorderInSBS(l_Row.TAP.Border);
  Table.AddRow(l_Row);
 finally
  FreeAndNil(l_Row);
 end;
end;

procedure TddDocumentGenerator.StartTabStop;
var
 l_Tab: TddTab;
begin
 l_Tab:= TddTab.Create;
 try
  f_Para.PAP.TabList.Add(l_Tab);
 finally
  l3Free(l_Tab);
 end;
end;

function TddDocumentGenerator.ValidExternalID(aID: Integer): Boolean;
begin
 Result := (aID = 0) or ((aID > 0) and ((aID = f_ExtNumber)) or
           UseExternalLinks or (ExternalIDList.IndexOf(aID) <> -1));
end;

procedure TddDocumentGenerator.TryToInitPrintFontSize(const aStyleRt: TddStyleEntry; const aCHP: TddCharacterProperty);
var
 l_Just     : TJust;
 l_FontSize : Integer;

 procedure lp_TryFindJustP(const aStyle: TddStyleEntry);
 begin
  if (aStyle.BasedOn <> 0) and (aStyle.BasedOn <> 222) and (Document.StyleTable[aStyle.BasedOn] <> nil) then
     lp_TryFindJustP(Document.StyleTable[aStyle.BasedOn]);
  if aStyle.PAP.JUST = justP then
   l_Just := justP
  else
   if (l_Just = justP) and (aStyle.PAP.JUST <> justNotDefined) then
    l_Just := aStyle.PAP.JUST;
  if (aStyle.CHP.FontSize <> propUndefined) then
   l_FontSize := aStyle.CHP.FontSize;
 end;

begin
 l_Just := justNotDefined;                          
 l_FontSize := propUndefined;
 lp_TryFindJustP(aStyleRt);
 if (l_Just = justP) then
  aCHP.PrintFontSize := Min(l_FontSize, Tk2Prop(CurrentType.Prop[k2_tiPrintFontSize]).DefaultValue * 2);
end;

procedure TddDocument.CloseTable(aScaleCellWidth: Boolean);
var
 l_Table: TddTable;
begin
 l_Table := Table;
 if (l_Table <> nil) then
 begin
  // Вычисление ширин ячеек
  l_Table.CloseTable(aScaleCellWidth, TextWidth);
  f_Tables.DeleteLast;
 end; // if (l_Table <> nil) then
end;

procedure TddDocument.AddAtomWithoutOneStep(aAtom: TddDocumentAtom);
var
 l_Table   : TddTable;
 l_LastRow : TddTableRow;
 l_LastCell: TddTableCell;
begin
 l_Table := Table;
 if l_Table <> nil then
 begin
  l_LastRow := l_Table.GetLastNotClosedRow;
  if l_LastRow = nil then
  begin
   l_Table.AddRow(True);
   l_LastRow := l_Table.LastRow;
  end; // if l_LastRow = nil then
  l_LastCell := l_LastRow.GetLastNonClosedCell;
  if (l_LastCell = nil) then
  begin
   l_Table.LastRow.AddEmptyCell;
   l_LastCell := l_Table.LastRow.LastCell;
  end; // if l_LastCell = nil then
  l_LastCell.Add(aAtom);
 end // if l_Table <> nil then
 else
  Paragraphs.Add(aAtom);
end;

procedure TddDocument.CreateTable;
var
 l_Table    : TddTable;
 l_Nested   : Boolean;
 l_OuterCell: TddTableCell;
begin
 l_Nested := f_Tables.Count > 0;
 if l_Nested then
  l_OuterCell := f_Tables.Last.LastRow.GetLastNonClosedCellOrAddNew;
 l_Table := TddTable.Create(nil);
 try
  l_Table.Nested := l_Nested;
  if l_Nested then
   l_OuterCell.Add(l_Table)
  else
   Paragraphs.Add(l_Table);
  f_Tables.Add(l_Table);
 finally
  l3Free(l_Table);
 end;
end;

procedure TddDocumentGenerator.CheckBorderInSBS(const aBorder: TddBorder);
begin
 aBorder.IsFramed := not Table.IsSBS;
end;

function TddDocument.StyleByName(const aName: Tl3PCharLen): TddStyleEntry;
var
 l_Index: Integer;
begin
 if f_StyleTable.FindData(aName, l_Index) then
  Result := StyleSheet[l_Index]
 else
  Result := nil;
end;

procedure TddDocumentGenerator.DoInitPictureWidth;
begin

end;

procedure TddDocument.CheckNormalStyle(const aStyle: TddStyleEntry);

 function lp_InitNewStyleID: Integer;
 var
  i: Integer;
 begin
  for i := 0 to f_StyleTable.Count - 1 do
   Result := Min(Result, TddStyleEntry(f_StyleTable.Items[i]).Number);
 end;

var
 l_Style: TddStyleEntry;
begin
 if (aStyle.BasedOn = 222) and not aStyle.IsFake and (aStyle.FakeStyleID = -1) then
 begin
  l_Style := TddStyleEntry.Create;
  try
   l_Style.IsFake := True;
   l_Style.StyleDef := sdCharacter;
   l_Style.BasedOn := aStyle.Number;
   if aStyle.CHP.FColor <> propUndefined then
    l_Style.CHP.FColor := aStyle.CHP.FColor;
   l_Style.CHP.FontSize := aStyle.CHP.FontSize;
   l_Style.Number := lp_InitNewStyleID - 1;
   l_Style.CHP.Style := l_Style.Number;
   l_Style.AsString := 'Цветовое выделение для ' + aStyle.AsString;
   aStyle.FakeStyleID := f_StyleTable.Add(l_Style);
  finally
   l3Free(l_Style);
  end;
 end; // if (S.BasedOn = 222) and (aStyle.CHP.FColor <> propUndefined) then
end;

function TddDocumentGenerator.NeedFillCell(const aRow: TddTableRow;
  aTableType: TddTableType; aRowPos: TddRowPosition): TddFillAAC;
begin
 if (aTableType >= dd_ttAAC) then
  Result := dd_faacWhite
 else
  Result := dd_faacNone;
 if Result > dd_faacNone then
 begin
  if (aRowPos = dd_rpNone) then
   if IsAACInnerTableRow(aRow) then
    Result := dd_faacDefColorWithoutLine
   else
    Result := dd_faacDefColor
  else
  begin
   if (aRow.CellCount = 1) then
   begin
    if IsAACPictureRow(aRow) then
     Result := dd_faacDefColor
   end // Result := dd_faacDefColor;
   else
    Result := dd_faacDefColor;
  end;
 end; // if Result then
end;

function TddDocumentGenerator.IsAACPictureRow(
  const aRow: TddTableRow): Boolean;
begin
 Result := (aRow.CellCount <= 2) and (aRow.Cells[0].Count = 1) and aRow.Cells[0].Items[0].IsPicture; 
end;

function TddDocumentGenerator.IsAACInnerTableRow(
  const aRow: TddTableRow): Boolean;
begin
 Result := (aRow.CellCount > 1) and (aRow.Cells[1].Count = 1) and aRow.Cells[1].Items[0].IsTable;
end;

function TddDocumentGenerator.IsCorrectTypeID: Boolean;
begin
 Result := (f_TypeID = 0) or (f_TypeID = CI_TOPIC) or (f_TypeID = CI_REF) or (f_TypeID = CI_EDITION);
end;

procedure TddDocumentGenerator.AddTarget;
begin
 if f_TypeID = CI_EDITION then
  f_Seg.AddTarget(f_Revision, f_SubID, f_TypeID)  // http://mdp.garant.ru/pages/viewpage.action?pageId=565502288&focusedCommentId=565503183#comment-565503183
 else
  f_Seg.AddTarget(f_DocID, f_SubID, f_TypeID);
end;

procedure TddDocumentGenerator.WriteTablePart(aPart: Boolean);

 procedure lp_ScaleCHP(aCHP: TddCharacterProperty; aScale: Integer);
 var
  l_FontSize: Integer;
 begin
  if Abs(aCHP.FontSize) = propUndefined then
   l_FontSize:= Document.StyleTable[IfThen(aCHP.Style = propUndefined, ev_saNormalTable, aCHP.Style)].CHP.FontSize
  else
   l_FontSize:= aCHP.FontSize;
  if Abs(l_FontSize) = propUndefined then
   l_FontSize:= Document.StyleTable[ev_saTxtNormalANSI].CHP.FontSize;
  aCHP.FontSize:= l3MulDiv(l_FontSize, aScale, 100);
 end;

var
 i               : Integer;
 j               : Integer;
 k               : Integer;
 l_Row           : TddTableRow;
 l_Cell          : TddTableCell;
 l_Delta         : Integer;
 l_TextPara      : TddTextParagraph;
 l_CellProp      : TddCellProperty;
 l_SegIndex      : Integer;
 l_ParaIndex     : Integer;
 l_MaxCellCount  : Integer;
 l_EtalonRowIndex: Integer;
begin
 if Table.RowCount > 0 then
 begin
  l_EtalonRowIndex := -1;
  l_MaxCellCount := 0;
  // вычисляем ширину строк
  for i := 0 to Pred(Table.RowCount) do
  begin
   l_Row := Table.Rows[i];
   if l_Row.CellCount > l_MaxCellCount then
   begin
    l_EtalonRowIndex := i;
    l_MaxCellCount := l_Row.CellCount;
   end; // l_Row.CellCount > l_MaxCellCount
   if not l_Row.TAP.AutoFit then
   begin
    l_Row.TAP.Width := 0;
    for j := 0 to Pred(l_Row.CellCount) do
    begin
     if Table.Scale <> def_Zoom then
     begin
      l_Row.Cells[j].Props.CellOffset := l3MulDiv(l_Row.Cells[j].Props.CellOffset, Table.Scale, 100);
      l_Cell := l_Row.Cells[j];
      for l_ParaIndex := 0 to l_Cell.Hi do
      begin
       if l_Cell.Items[l_ParaIndex].IsTextPara then
       begin
        l_TextPara := TddTextParagraph(l_Cell.Items[l_ParaIndex]);
        lp_ScaleCHP(l_TextPara.CHP, Table.Scale);
        for l_SegIndex := 0 to Pred(l_TextPara.SegmentCount) do
         lp_ScaleCHP(l_TextPara.Segments[l_SegIndex].CHP, Table.Scale)
       end
      end; // for l_ParaIndex := 0 to l_Cell.Hi do
     end; //
     l_Row.TAP.Width := l_Row.TAP.Width + l_Row.Cells[j].Props.CellOffset;
    end;
   end // if not l_Row.TAP.AutoFit then
   else
    l_Row.TAP.Width := Document.DOP.xaPage - Document.DOP.xaLeft - Document.DOP.xaRight;
  end; // for i
  // Вычисляем высоту объединенных ячеек
  for i := 0 to Pred(Table.RowCount) do
  begin
   l_Row := Table.Rows[i];
   if l_Row.HasMerged then
    for j := 0 to l_Row.CellCount - 1 do
     if (l_Row.Cells[j].Props.VMergeFirst) and (l_Row.Cells[j].Props.RowSpan = 1) then
     begin
      if not l_Row.RTFLikeWidth then
      begin
       l_Delta:= 0;
       for k := 0 to j do
        Inc(l_Delta, l_Row.Cells[k].Props.CellOffset);
      end // not l_Row.RTFLikeWidth
      else
       l_Delta := l_Row.Cells[j].Props.CellOffset;
      for k := i + 1 to Pred(Table.RowCount) do
      // Нужно искать по ширине ячейки, потому что могут быть объединенные по горизонтали
      begin
       l_CellProp := Table.Rows[k].CellPropByPos[l_Delta];
       if (l_CellProp <> nil) and l_CellProp.VMerged then
        l_Row.Cells[j].Props.RowSpan := l_Row.Cells[j].Props.RowSpan + 1
       else
        Break;
      end;
     end; // if (l_Row.Cells[j].Props.VMergeFirst) and
  end; // for i:= 0 to Pred(Table.RowCount) do
  // Вычисляем ширину объединенных ячеек
  if l_EtalonRowIndex <> -1 then
   CalcJoinedWidth(l_EtalonRowIndex);
 end; // Table.RowList.Count > 0
 if Table.Nested then
  f_Tables[f_Tables.Hi - 1].LastRow.LastCell.Add(Table)
 else
  Document._AddAtom(Table, aPart);
end;

procedure TddDocumentGenerator.WriteFormula(aFormula: TddTextSegment;
  aCHP: TddCharacterProperty; aUseMetaFile: Boolean);
var
 l_Bitmap  : Tl3GraphicContainer;
 l_Expr    : Tl3Expr;
 l_Picture : TddPicture;
 l_F       : TevFont;
 l_Render  : Il3Renderer;
 l_ColEntry: TddColorEntry;
begin
 if not TddTextParagraph(aFormula.Data).Text.Empty then
 begin
  try
   l_Expr := SafeBuildExpr(TddTextParagraph(aFormula.Data).Text.AsString);
  except
   on E: EIncorrectExpr do
    l_Expr := TExprContainer.Create(TExprCustomText.Create(E.Message));
  end; 
  try
   if aUseMetaFile then
    l_Bitmap := Tl3MetafileContainer.Create
   else
    l_Bitmap := Tl3BitmapContainer.Create;
   try
    l_F := TevFont.Create;
    try
     l_F.Name := l_Expr.Font.Name;
     if Abs(aCHP.FontSize) <> propUndefined then
      l_F.Size := aCHP.FontSize div 2;
     (l_Expr As Il3Renderer).SetForWMF(True);
     l_Bitmap.SetParams(l_Expr As Il3Renderer, l_F);
    finally
     FreeAndNil(l_F);
    end;
    l_Picture := TddPicture.Create(nil);
    try
     if aUseMetaFile then
     begin
      Tl3MetafileContainer(l_Bitmap).Bitmap.SaveToStream(l_Picture.Stream);
      l_Picture.Format := pictWMF;
     end // if aUseMetaFile then
     else
     begin
      l3BitmapToAlphaPNG(Tl3BitmapContainer(l_Bitmap).Bitmap, l_Picture.Stream);
      l_Picture.Stream.Seek(0, 0);
      l_Picture.Format := pictPNG; // Раз уж сохранили в PNG, то указываем это, чтобы не было еще одного преобразования...
     end;
     l_Picture.Width := l_Bitmap.Width;
     l_Picture.Height := l_Bitmap.Height;
     WritePicture(l_Picture, False);
    finally
     l3Free(l_Picture);
    end;
   finally
    l3Free(l_Bitmap);
   end;
  finally
   l3Free(l_Expr);
  end;
 end; // if not TddTextParagraph(aFormula.Data).Text.Empty then
end;

procedure TddDocumentGenerator.DoCloseBlock;
begin

end;

procedure TddDocumentGenerator.DoStartBlock;
begin

end;

procedure TddDocumentGenerator.DoStartDocument;
begin
 DoInitPictureWidth;
end;

function TddDocumentGenerator.InBlock: Boolean;
begin
 Result := CurrentType = k2_typBlock;
end;

function TddDocumentGenerator.BlockIndent: Integer;
begin
 Result := propUndefined;
end;

function TddDocumentGenerator.NeedWritePara: Boolean;
begin
 Result := True;
end;

function TddDocumentGenerator.IgnoreLeftIndent: Boolean;
begin
 Result := False;
end;

procedure TddDocumentGenerator.CheckFilterPara(aFromFilter: Boolean);
begin

end;

procedure TddDocument.DeleteLastTextPara;
var
 l_Atom    : TddDocumentAtom;
 l_Table   : TddTable;
 l_LastRow : TddTableRow;
 l_LastCell: TddTableCell;
begin
 if f_Paragraphs.Count > 0 then
 begin
  l_Table := Table;
  if l_Table <> nil then
  begin
   l_LastRow := l_Table.LastRow;
   if l_LastRow <> nil then
   begin
    l_LastCell := l_LastRow.GetLastNonClosedCell;
    if l_LastCell <> nil then
     if (l_LastCell.LastTextPara <> nil) and (l_LastCell.Count > 0) then
      l_LastCell.Delete(l_LastCell.Count - 1);
   end; // if l_LastRow <> nil then
  end // if f_Table <> nil then
  else
  begin
   l_Atom := f_Paragraphs.Last;
   if (l_Atom <> nil) and l_Atom.IsTextPara then
    f_Paragraphs.DeleteLast;
  end;
 end // if f_Paragraphs.Count > 0 then
 else
  if (f_LastPara <> nil) and not f_LastPara.Closed then
   f_LastPara := nil;
end;

end.
