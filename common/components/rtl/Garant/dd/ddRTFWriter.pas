unit ddRTFWriter;

{ $Id: ddRTFWriter.pas,v 1.225 2015/12/02 11:34:20 dinishev Exp $ }
// $Log: ddRTFWriter.pas,v $
// Revision 1.225  2015/12/02 11:34:20  dinishev
// Bug fix: задел RTFWriter
//
// Revision 1.224  2015/08/28 08:14:48  dinishev
// {Requestlink:606129464}
//
// Revision 1.223  2015/08/04 11:29:21  dinishev
// {Requestlink:602505046}. Вложенные отступы.
//
// Revision 1.222  2015/08/03 16:16:53  dinishev
// {Requestlink:602505046}. Отступы.
//
// Revision 1.221  2015/07/31 15:27:21  dinishev
// {Requestlink:602505046}. Реагируем на свернутость блока при выливке.
//
// Revision 1.220  2015/07/31 11:32:01  dinishev
// Cleanup
//
// Revision 1.219  2015/07/31 11:10:13  dinishev
// {Requestlink:602505046}. Экспорт стиля.
//
// Revision 1.218  2015/05/08 12:37:46  dinishev
// {Requestlink:598615356} Чистка кода.
//
// Revision 1.217  2015/05/07 14:22:20  dinishev
// {Requestlink:598615356}
//
// Revision 1.216  2015/03/25 10:54:03  dinishev
// {Requestlink:592251812}
//
// Revision 1.215  2015/02/24 14:55:30  dinishev
// {Requestlink:589529446}. Правки по результатам тестов.
//
// Revision 1.214  2015/02/24 14:07:28  dinishev
// {Requestlink:589529446}
//
// Revision 1.213  2015/02/13 12:45:32  dinishev
// {Requestlink:571653012}
//
// Revision 1.212  2014/10/01 10:01:45  dinishev
// {Requestlink:565856645}
//
// Revision 1.211  2014/09/15 09:55:54  dinishev
// {Requestlink:565008971}
//
// Revision 1.210  2014/09/12 11:42:46  dinishev
// {Requestlink:565008971}. Заливку поправил. Остались вопросы совместимости.
//
// Revision 1.209  2014/07/17 12:48:20  dinishev
// {Requestlink:554581587}. Убрал свои запилы по передаче цвета фона. Просто отрисовываем без фона.
//
// Revision 1.208  2014/07/17 11:27:38  dinishev
// {Requestlink:554581587}. Сохраняем формулы в WMF и для тестов - в PNG.
//
// Revision 1.207  2014/07/17 07:12:19  dinishev
// {Requestlink:554581587}. Выделил отдельны метод по преобразованию в PNG картинки.
//
// Revision 1.206  2014/07/17 07:00:49  dinishev
// {Requestlink:554581587}. Убираем лишнее.
//
// Revision 1.205  2014/07/15 12:29:53  dinishev
// {Requestlink:553919980}. Правим кривизну в LibreOffice.
//
// Revision 1.204  2014/07/15 06:03:40  dinishev
// {Requestlink:553919980}. Прячем невидимые линии для LibreOffice, на сколько это возможно.
//
// Revision 1.203  2014/07/11 11:01:38  dinishev
// {Requestlink:553914086}. Правка по горячим следам - получались испорченные rtf.
//
// Revision 1.202  2014/07/11 09:16:48  dinishev
// {Requestlink:553914086}
//
// Revision 1.201  2014/07/10 10:27:23  dinishev
// {Requestlink:553427148}. Пользуемся тем, что в момент рендеринга формулы фон нам известен. Ибо код выставления альфы смущает.
//
// Revision 1.200  2014/07/10 09:56:35  lulin
// - bug fix: не компилировалось.
//
// Revision 1.199  2014/07/10 07:48:19  dinishev
// Выпилил преобразование картинки.
//
// Revision 1.197  2014/07/08 09:11:45  dinishev
// {Requestlink:552601541}
//
// Revision 1.196  2014/07/07 10:54:07  dinishev
// {Requestlink:552601496}
//
// Revision 1.195  2014/07/02 12:01:30  dinishev
// {Requestlink:390585479}. Общие отступы для одинаковых стилей, правильное оформление стиля 'Формула'
//
// Revision 1.194  2014/07/02 08:05:31  dinishev
// {Requestlink:390585479}
//
// Revision 1.193  2014/07/02 06:40:06  dinishev
// {Requestlink:390585479}
//
// Revision 1.192  2014/07/01 13:22:50  dinishev
// {Requestlink:390585479}
//
// Revision 1.191  2014/07/01 11:12:27  dinishev
// {Requestlink:390585479}
//
// Revision 1.190  2014/07/01 05:30:37  dinishev
// {Requestlink:390585479}
//
// Revision 1.189  2014/04/30 11:49:22  dinishev
// {Requestlink:529957499}
//
// Revision 1.188  2014/04/29 13:05:12  dinishev
// {Requestlink:532632527}
//
// Revision 1.187  2014/04/25 05:24:30  dinishev
// Чистка кода.
//
// Revision 1.186  2014/04/25 05:07:15  dinishev
// Чистка кода.
//
// Revision 1.185  2014/04/24 14:07:29  dinishev
// {Requestlink:529957499}
//
// Revision 1.184  2014/04/24 13:17:05  dinishev
// {Requestlink:529957499}
//
// Revision 1.183  2014/04/21 11:18:00  dinishev
// {Requestlink:530819607}
//
// Revision 1.182  2014/02/14 15:33:53  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.181  2014/01/20 11:34:48  dinishev
// {Requestlink:510620290}. Вычистил код, который теперь на модели.
//
// Revision 1.180  2014/01/20 11:31:29  dinishev
// {Requestlink:510620290}
//
// Revision 1.179  2014/01/14 07:19:08  dinishev
// {Requestlink:509090464}
//
// Revision 1.178  2014/01/13 06:18:15  dinishev
// {Requestlink:510621098}. Перенос на модель.
//
// Revision 1.177  2014/01/10 11:14:36  dinishev
// {Requestlink:510621098}. Перенес TddCellProperty на модель.
//
// Revision 1.176  2013/11/22 13:14:47  dinishev
// Лишний пробел - могли отъехать эталоны.
//
// Revision 1.175  2013/11/20 13:16:37  dinishev
// Bug fix: не компилировался EverestLite
//
// Revision 1.174  2013/11/13 10:42:19  dinishev
// {Requestlink:495138772}. Сбрасываем настройки параграфа после его окончания.
//
// Revision 1.173  2013/10/24 11:03:16  dinishev
// {Requestlink:483394869}
//
// Revision 1.172  2013/10/16 09:23:06  dinishev
// {Requestlink:493324121}
//
// Revision 1.171  2013/10/15 12:59:56  dinishev
// {Requestlink:492616334}
//
// Revision 1.170  2013/09/23 10:07:55  dinishev
// {Requestlink:403079732}
//
// Revision 1.169  2013/09/23 06:22:35  dinishev
// Cleanup
//
// Revision 1.168  2013/09/23 06:21:24  dinishev
// Cleanup
//
// Revision 1.167  2013/09/23 06:19:13  dinishev
// Cleanup
//
// Revision 1.166  2013/09/23 06:00:41  dinishev
// Cleanup
//
// Revision 1.165  2013/09/20 08:40:57  dinishev
// Недоделал объединение кода - часть потерялась, поэтому отъехала выливка в RTF.
//
// Revision 1.164  2013/09/19 14:36:59  dinishev
// Рефакторинг простыни выливки текстового параграфа.
//
// Revision 1.163  2013/09/19 14:14:11  dinishev
// Рефакторинг простыни выливки текстового параграфа.
//
// Revision 1.162  2013/09/19 13:49:06  dinishev
// Рефакторинг простыни выливки текстового параграфа.
//
// Revision 1.161  2013/09/19 13:45:16  dinishev
// Рефакторинг простыни выливки текстового параграфа.
//
// Revision 1.160  2013/09/19 13:20:11  dinishev
// Рефакторинг простыни выливки текстового параграфа.
//
// Revision 1.157  2013/08/26 09:37:34  dinishev
// {Requestlink:479402974}
//
// Revision 1.156  2013/07/31 10:09:22  dinishev
// Cleanup.
//
// Revision 1.155  2013/07/19 13:55:41  dinishev
// {Requestlink:466752604}. Теперь текстовый параграф сам умеет проверять и выливать номер.
//
// Revision 1.154  2013/05/14 11:13:19  dinishev
// {Requestlink:453164226}. Потихоньку переносим логику работы с таблицей из TdestNorm - не место ей там в TddTable.
//
// Revision 1.153  2013/05/08 12:33:00  dinishev
// {Requestlink:453164226}
//
// Revision 1.152  2013/05/06 12:37:11  dinishev
// Откатываем костыли и "рефакторинг" - отъехало чтение таблиц.
//
// Revision 1.151  2013/05/06 08:08:55  dinishev
// Убрал еще одно свойство.
//
// Revision 1.150  2013/04/05 12:04:30  lulin
// - портируем.
//
// Revision 1.149  2013/03/12 08:21:38  narry
// Преформатированный текст экспортируется в Word неверным шрифтом (434754425)
//
// Revision 1.148  2013/02/28 07:52:26  narry
// Маркировка списка после экспорта в Word (431376028)
//
// Revision 1.147  2013/02/27 08:34:43  narry
// Проблемы с кодировкой при открытии наших rtf на IPad (430746304)
//
// Revision 1.146  2013/01/24 06:55:32  narry
// Поддержка нумерованных абзацев (пока не работает)
//
// Revision 1.145  2013/01/22 12:19:52  narry
// Рефакторинг RTFReader
//
// Revision 1.144  2012/04/28 11:46:46  narry
// При экспорте в Word картинка оказывается не в таблице (356075817)
//
// Revision 1.143  2012/03/26 11:02:45  narry
// В rtf странно экспортируются рисунки (312445572)
//
// Revision 1.142  2012/03/21 12:37:04  narry
// Изменённый цвет текста некорректно экспортируется в Word (344754072)
//
// Revision 1.141  2011/12/12 13:01:53  narry
// Формулы экспортируются без отступа (235055684)
//
// Revision 1.140  2011/11/18 08:00:57  narry
// Формулы экспортируются без отступа внутри таблицы (235055757)
//
// Revision 1.139  2011/10/21 12:53:57  narry
// Поддержка экспорта в RTF для родительской задачи (294591744)
//
// Revision 1.138  2010/12/03 07:58:08  narry
// K244195832 Ссылки в экспортированном rtf должны вести на сгенерировавший его хост Интранет
//
// Revision 1.137  2010/11/30 14:51:01  lulin
// {RequestLink:238947629}.
//
// Revision 1.136  2010/11/29 08:31:34  lulin
// - откручиваем хитрую трактовку ссылок на параграфы.
//
// Revision 1.135  2010/11/23 10:52:31  narry
// К241013425. Экспортировать все ссылки в Word (ссылки на параграфы)
//
// Revision 1.121.2.10  2010/11/08 10:12:29  narry
// К236720322. Виснет Word если раздел (division) идет сразу после таблицы
//
// Revision 1.121.2.9  2010/11/03 18:06:29  lulin
// {RequestLink:238947629}.
//
// Revision 1.121.2.8  2010/11/01 08:47:31  narry
// K238421582 Экспортировать внешние ссылки в Word
//
// Revision 1.121.2.7  2010/09/21 06:51:28  narry
// k235053891. Терялся стиль текста абзаца
//
// Revision 1.121.2.6  2010/09/20 15:32:51  narry
// k235052883. Неправильно рассчитывались отступы абзаца
//
// Revision 1.130  2010/09/20 15:18:02  narry
// k235052883. Неправильно рассчитывались отступы абзаца
//
// Revision 1.129  2010/09/16 14:06:53  lulin
// {RequestLink:235050903}.
//
// Revision 1.128  2010/09/16 10:52:52  narry
// k235050823. Неправильно выставлялся шрифт формулам
//
// Revision 1.127  2010/09/03 13:06:13  narry
// K234358608
//
// Revision 1.126  2010/09/03 12:59:23  narry
// K228688401
//
// Revision 1.124.2.5  2010/09/03 11:23:36  narry
// - промежуточное обновление
//
// Revision 1.124.2.4  2010/09/03 09:44:05  narry
// - промежуточное обновление
//
// Revision 1.124.2.3  2010/09/03 05:33:59  narry
// - промежуточное обновление
//
// Revision 1.124.2.2  2010/09/02 10:40:05  narry
// - промежуточное обновление
//
// Revision 1.124.2.1  2010/08/30 05:59:13  narry
// - промежуточное обновление
//
// Revision 1.124  2010/08/20 08:51:18  narry
// - обновление
//
// Revision 1.123  2010/07/13 11:38:13  narry
// - К121164205
//
// Revision 1.121  2010/04/12 11:39:20  narry
// - масштаб таблицы
// - размер шрифта для печати
//
// Revision 1.120  2010/04/01 05:11:51  narry
// - масштабирование формул
//
// Revision 1.119  2010/03/26 17:34:56  lulin
// {RequestLink:199591594}.
// - тесты.
//
// Revision 1.118  2010/03/26 15:30:34  lulin
// {RequestLink:199591594}.
//
// Revision 1.117  2010/03/26 14:43:17  narry
// - масштабирование формулы (пока не работает)
//
// Revision 1.116  2010/02/24 18:16:27  lulin
// - избавляемся от ненужного и вредного параметра, доставшегося в наследство от ошибок молодости.
//
// Revision 1.115  2010/02/24 08:30:17  narry
// - терялось оформление сегментов
//
// Revision 1.114  2010/02/18 08:16:10  narry
// - не закрывался сегмент
//
// Revision 1.113  2010/02/16 10:47:25  narry
// - терялся стиль сегмента
//
// Revision 1.112  2010/02/16 06:08:11  narry
// - борьба с пустыми страницами
//
// Revision 1.111  2010/02/10 15:25:02  narry
// - неправильно передавалась подпись
//
// Revision 1.110  2009/04/22 12:03:01  narry
// - сбивались отступы абзаца, примененные напрямую к абзацу
//
// Revision 1.109  2009/04/09 15:08:19  lulin
// [$140280550]. Выкидываем мусор.
//
// Revision 1.108  2009/02/10 09:54:20  demon
// - для текста после буллета писался некорректный шрифт
//
// Revision 1.107  2008/09/26 18:20:37  lulin
// - <K>: 119475523.
//
// Revision 1.106  2008/08/19 14:17:41  narry
// - текст из заголовка попадал в текст документа
//
// Revision 1.105  2008/08/18 13:57:43  narry
// - заполнение и экспорт полей Автор, Организация, Комментарий
//
// Revision 1.104  2008/07/15 20:23:30  lulin
// - при рисовании формулы учитываем выделение.
//
// Revision 1.103  2008/06/26 12:18:11  lulin
// - выливка формул в метафайлы.
// - неправильно выливалось выравнивание формул.
//
// Revision 1.102  2008/06/26 07:59:16  lulin
// - <K>: 95488573.
//
// Revision 1.101  2008/06/20 14:49:11  lulin
// - используем префиксы элементов.
//
// Revision 1.100  2008/05/14 09:35:06  narry
// - повторное удаление параметра "без проверки орфографии"
//
// Revision 1.99  2008/05/12 11:43:40  narry
// - поиски пропавшего сегмента
// - рсширение списка констант
//
// Revision 1.98  2008/04/23 07:17:31  narry
// - в уникодном тексте не проверялась орфография
//
// Revision 1.97  2008/04/22 14:56:27  narry
// - терялся стиль абзаца, если этот стиль символьный
//
// Revision 1.96  2008/04/22 14:10:25  narry
// - проблемы с отрисовкой формул
//
// Revision 1.95  2008/04/17 14:44:44  narry
// - сноски, списки, картинки
//
// Revision 1.94  2008/04/11 16:07:28  narry
// - защита от падения формулы
//
// Revision 1.93  2007/11/12 14:20:52  narry
// - иногда добавлялся лишний пробел в начало абзаца
//
// Revision 1.92  2007/10/30 15:17:27  narry
// - пробой по памяти
//
// Revision 1.91  2007/10/29 12:03:32  narry
// - Обновление
//
// Revision 1.90  2007/10/23 09:46:55  narry
// - оформление съедало формулу
//
// Revision 1.89  2007/10/23 05:53:54  narry
// - поддержка экспорта формул. Пока только в RTF
//
// Revision 1.88  2007/09/28 07:51:03  narry
// - параметры сегмента "съедали" первое слово сегмента
//
// Revision 1.87  2007/09/12 12:57:59  narry
// - CQ 26512 - пользовательский комментарий не переносился в ворд
//
// Revision 1.86  2007/08/21 10:51:49  narry
// - не сбрасывалось оформление абзаца в сегменте
//
// Revision 1.85  2007/06/13 11:27:41  narry
// - неправильно "вычислялось" оформление сегмента со стилем
//
// Revision 1.84  2007/01/30 11:35:58  narry
// - корректная передача оформления в RTF
//
// Revision 1.83  2006/12/29 13:09:25  lulin
// - реализуем интерфейс расширенного списка строк.
//
// Revision 1.82  2006/12/01 15:04:35  narry
// - борьба с Integer overflow
//
// Revision 1.81  2006/11/17 14:07:03  lulin
// - cleanup.
//
// Revision 1.80  2006/11/17 13:36:11  lulin
// - очищаем ссылки при освобождении объектов.
//
// Revision 1.79  2006/09/20 16:55:45  narry
// - масштабирование картинки по размеру страницы
//
// Revision 1.78  2006/09/19 11:33:33  narry
// - поддержка "резиновых" таблиц на уровне RTF
//
// Revision 1.77  2006/09/11 14:49:09  narry
// no message
//
// Revision 1.76  2006/09/07 13:29:33  narry
// - разрыв строки убивал текст
//
// Revision 1.75  2006/09/05 15:52:22  narry
// - фигня с альбомной ориентацией
//
// Revision 1.74  2006/05/07 09:49:08  narry
// - недокоммит
//
// Revision 1.73  2006/04/12 11:00:03  narry
// - новое: обработка "псевдострелок" в моноширинном тексте
//
// Revision 1.72  2006/02/11 11:13:35  narry
// - исправление: неправильно форматировался стиль "Заголовок статьи"
//
// Revision 1.71  2005/12/13 11:42:22  narry
// - ошибка: лишний разрыв страницы
//
// Revision 1.70  2005/12/01 10:31:08  narry
// - ошибка: двойные открывающие кавычки приводили к исчезновению заключенного в них текста
//
// Revision 1.69  2005/10/11 08:57:20  narry
// - исправление: неправильно форматировался абзац
//
// Revision 1.68  2005/09/20 14:14:48  narry
// - исправление: AV при отсутствии в документе таблицы стилей
//
// Revision 1.67  2005/05/27 10:14:37  narry
// - bug fix: некорректный экспорт стилей
//
// Revision 1.66  2005/05/19 13:18:51  lulin
// - remove unit: evFont.
//
// Revision 1.65  2005/05/12 09:59:19  narry
// - bug fix: преобразование несуществующих картинок
//
// Revision 1.64  2005/05/04 13:46:11  fireton
// - профайлинг и оптимизация по скорости
//
// Revision 1.63  2005/05/04 11:00:07  narry
// - bug fix: в некоторых случаях создавался некорректный RTF-файл
//
// Revision 1.62  2005/04/08 13:51:23  narry
// - bug fix: генерация неправильного RTF
//
// Revision 1.61  2004/10/08 14:44:52  narry
// - update: поддержка "резиновой" SBS-таблицы
//
// Revision 1.60  2004/10/01 08:55:56  narry
// - bug fix: двойное преобразование отступа красной строки
//
// Revision 1.59  2004/09/29 14:40:39  fireton
// - bug fix: неправильно вычислялся отступ красной строки (narry)
//
// Revision 1.58  2004/09/21 12:21:05  lulin
// - Release заменил на Cleanup.
//
// Revision 1.57  2004/09/16 14:08:57  narry
// - bug fix: не рисовались рамки у абзацев
//
// Revision 1.56  2004/09/16 10:19:27  narry
// - update: перенос механизма фильтрации внешних ссылок на предка
//
// Revision 1.55  2004/07/06 10:44:35  narry
// - new property: UseExternalLinks - сохранять или нет ссылки на внешние документы
//
// Revision 1.54  2004/05/28 09:13:14  narry
// - bug fix: неправильный пересчет абзацных отступов
//
// Revision 1.53  2004/05/14 17:27:04  law
// - remove unit: evStrGen.
//
// Revision 1.52  2004/05/14 15:17:01  law
// - remove unit: evTypesE.
//
// Revision 1.51  2004/05/12 15:11:38  narry
// - cleanup
//
// Revision 1.50  2004/05/12 15:10:12  narry
// - new: корректная поддержка уникодного текста
//
// Revision 1.49  2004/05/11 14:09:14  narry
// - bug fix: значение k2_tiVisible всегда воспринималось как Integer, хотя  оно может быть и строковое
// - cleanup
//
// Revision 1.48  2004/04/15 14:38:39  narry
// - new property: _OneStep - генерация внешних форматов в один проход
//
// Revision 1.47  2004/04/09 12:17:35  narry
// - new: преобразование форматов картинок, не поддерживаемых MS Word в png
//
// Revision 1.46  2004/04/05 11:15:05  narry
// - update: подчистка артефактов использования предыдущей графической библиотеки
//
// Revision 1.45  2004/03/24 14:45:30  narry
// - bug fix: склеивание символа табуляции и следующего за ним текста
//
// Revision 1.44  2004/03/22 16:10:45  narry
// - bug fix: добавлялся пробел после спецсимволов
//
// Revision 1.43  2004/03/01 08:19:45  narry
// - bug fix: лишнее выставление шрифта стилю "Цветовое выделение" (CQ 00006329, 00006338, 00006340)
//
// Revision 1.42  2004/01/19 14:44:41  narry
// - bug fix: неправильное выставление стилей абзацам подписи
// - update
// - cleanup
//
// Revision 1.41  2004/01/16 13:02:23  narry
// - update: замена -1 на идентификатор стиля ev_saTxtNormalANSI
//
// Revision 1.40  2003/12/29 12:08:00  narry
// - change: для уменьшения путаницы переименованы методы доступа к сегментам по индексу символа
//
// Revision 1.39  2003/12/23 17:01:16  narry
// - update: улучшение алгоритма наследования стилей
// - add: сохранение вертикального выравнивания ячеек таблицы
//
// Revision 1.38  2003/12/17 14:44:16  narry
// - bug fix: не закрывались сегменты, длина которых превышала длину абзаца
//
// Revision 1.37  2003/12/04 16:22:43  narry
// - bug fix: неправильное выравнивание стиля Normal
// - bug fix: избыточное и местами неправильное оформление абзаца и текста
//
// Revision 1.36  2003/11/11 13:54:01  narry
// - bug fix: не сохранялась картинка в RTF
//
// Revision 1.35  2003/11/06 15:15:05  narry
// - bug fix: сохранение картинки в RTF. Реализовано для BMP
//
// Revision 1.34  2003/09/22 15:21:42  narry
// - bug fix: совпадение начала сегмента и ссылки приводило к генерации неправильного rtf
//
// Revision 1.33  2003/09/16 12:04:24  narry
// - bug fix: Index of bounds при преобразовании текста в таблицу
//
// Revision 1.32  2003/08/20 11:14:29  narry
// - bug fix: использование неправильной константы для закрытия закладки приводило к появлению закладок-фантомов
//
// Revision 1.31  2003/08/19 15:05:04  narry
// - new: запись внутренних ссылок на метки
//
// Revision 1.30  2003/08/19 11:45:07  narry
// - new: преобразование меток в закладки
//
// Revision 1.29  2003/04/19 12:30:38  law
// - new file: ddDefine.inc.
//
// Revision 1.28  2003/01/08 11:15:28  narry
// - update
//
// Revision 1.27  2002/07/30 15:58:16  narry
// - new behavior: поддержка Strikeout
//
// Revision 1.26  2002/07/30 15:05:52  narry
// - bug fix: не задавался шрифт и размер шрифта при изменении оформления
//
// Revision 1.25  2002/07/09 12:02:18  law
// - rename unit: evUnits -> l3Units.
//
// Revision 1.24  2002/07/03 09:00:57  narry
// - update, cleanup и new behavior
//
// Revision 1.23.2.1  2002/07/02 14:30:45  narry
// - alpha release
//
// Revision 1.23  2002/04/23 08:01:59  narry
// - update
//
// Revision 1.22  2001/11/28 16:36:12  narry
// - bug fix: "съедание" таблицей разрыва раздела
//
// Revision 1.21  2001/11/22 13:58:43  narry
// - update : начало реализации Групп доступа
//
// Revision 1.20  2001/09/12 14:46:45  narry
// - update
//
// Revision 1.19  2001/08/29 15:36:27  law
// - cleanup: удалены ненужные зависимости от Orpheus и SysTools.
//
// Revision 1.18  2001/05/08 13:31:51  narry
// Update - запись параметров раздел
//
// Revision 1.17  2001/05/08 07:56:32  narry
// Update - не выливаются лишние пустые абзацы в ячейку таблицы
//
// Revision 1.16  2001/04/27 09:24:05  narry
// Bug fix - незакрытие сегменто
//
// Revision 1.15  2001/04/25 07:18:02  narry
// Update - очередная итерация по записи-чтению стилей Эверест в РТФ
//
// Revision 1.14  2001/04/12 12:58:49  narry
// Update - запись-чтение внутренних стилей в ртф
//
// Revision 1.13  2001/01/25 09:08:06  narry
// Fix - wrong page width, lost character format
// Add - write page break
//
// Revision 1.12  2000/12/20 11:56:32  narry
// SBS finally fix
//
// Revision 1.11  2000/12/19 15:06:27  law
// - #13#10 -> cc_EOL.
//
// Revision 1.10  2000/12/19 13:49:24  narry
// no message
//
// Revision 1.9  2000/12/19 13:47:20  narry
// no message
//
// Revision 1.8  2000/12/18 16:19:29  narry
// Partially bug fix
//
// Revision 1.7  2000/12/15 15:29:55  law
// - вставлены директивы Log и Id.
//

{$I ddDefine.inc }
{$DEFINE DontTranslate}
{.$DEFINE ddWriteGarantAttributes} // для выливки атрибутов Гаранта
interface

uses
  l3Types,
  l3Base,

  k2Tags,
  k2TagGen,
  Windows, Graphics,
  ddBase,
  RTFTypes,
  ddTypes,
  ddRTFProperties,
  ddDocument,
  ddBreak,
  ddBorder,
  ddPicture,
  ddCellProperty,
  ddRowProperty,
  ddCharacterProperty,
  ddParagraphProperty,
  ddTextSegment,
  ddDocumentAtom,
  ddTable,
  ddTableRow,
  ddFillAACStack,
  ddTextParagraph,
  ddRTFExpandedTextWriter,

  l3LongintList,
  l3CustomString;

type
  TCustomRTFObjectGenerator = class(TddRTFExpandedTextWriter)
  private
    f_AACPAP       : TddParagraphProperty;
    f_AACCHP       : TddCharacterProperty;
    f_CellWidth    : Integer;
    f_WasTable     : Boolean;
    f_WhiteIndex   : Integer;
    f_NextFillType : TddFillAAC;
    f_FillTypeStack: TddFillAACStack;
    f_PicWidths    : Tl3LongintList;
    f_CellHasPara  : Boolean;
    f_NestedLevel  : Integer;
    f_PictureWidth : Integer;
  private
    function GetRowHeight4AACSpace(aBefore: Boolean): AnsiString;
    function GetCellFillColor4AAC: AnsiString;
    function GetLeftIndent: Integer;
    function GetRightIndent: Integer;
    function OutputPAP(const Para: TddTextParagraph): TddStyleEntry;
    procedure OutputEOParaWithClearStyle;
    procedure OutputEOPara;
    procedure OutTextAndClearCellHasPara;
    procedure OutputCharacterProperty(const aPara: TddTextParagraph; const aStyle: TddStyleEntry);
    procedure OutputCHPStyle(const aPara: TddTextParagraph; var aStyle: TddStyleEntry);
    function OutputParaFormat(const aPara: TddTextParagraph): TddStyleEntry;
    procedure WorkWithBookmarks(const aPara: TddTextParagraph; anOpen: Boolean);
    function Border2RTF(aBorder: TddBorder; aFillType, aNextFillType: TddFillAAC): AnsiString;
    function Cell2RTF(aCell: TddCellProperty; aFillType, aNextFillType: TddFillAAC): AnsiString; 
    function CHP2RTF(aCHP: TddCharacterProperty; aParentCHP: TddCharacterProperty; const WithStyle: Boolean = True): AnsiString; override;
    function DIffCHP2RTF(aCHP1, aCHP2: TddCharacterProperty): AnsiString; override;
    procedure OutText(aText: Tl3CustomString; anUnicode: Boolean); overload;
    procedure OutText(const aPara: TddTextParagraph; const aStyle: TddStyleEntry); overload;
    procedure OutText(aText: Tl3CustomString; anUnicode: Boolean; const aPara: TddTextParagraph; const aStyle: TddStyleEntry); overload;
    function PAP2RTF(aPAP: TddParagraphProperty; aBlockIndent: Integer; anIgnoreLeftIndent: Boolean;
                     WithStyle: Boolean = True): AnsiString; override;
    function Pixels2Twips(aPixels: Integer; aDPI: Integer = 96): Integer;
    function Style2RTF(aStyle: TddStyleEntry; aBlockIndent: Integer; anIgnoreLeftIndent: Boolean): AnsiString; override;
    function TAP2RTF(aTAP: TddRowProperty; aEmtyBorder: Boolean): AnsiString;
    procedure TranslateChar(C: AnsiChar; out Res: AnsiString);
    procedure CheckAACRow(aStyleID: Integer; const aRow: TddTableRow; aNeedInit: Boolean; aRowType: TddRowType);
    procedure InitAACTableParams(aStyleID: Integer);
    function GetPicWidthStack: Tl3LongintList;
    procedure RememberLastPictureWidth;
    function AnalizePicture(const aPicture: TddPicture; var anOffset: Integer): AnsiString;
    procedure DeinitAACProps;
    function GetWhiteIndex: Integer;
    procedure Try2AddEmtpyPara;
    procedure Convert2Png(const aPicture: TddPicture);
  protected
    procedure Cleanup; override;
    procedure DoInitPictureWidth; override;
    procedure WriteBreak(const aBreak: TddBreak); override;
    procedure WriteColorTable(aDefault: Boolean = False); override;
    procedure WriteDocumentEnd; override;
    procedure WriteDocumentStart; override;
    procedure WriteFontTable(aDefault: Boolean = False); override;
    procedure WriteHeader(aDefault: Boolean = False); override;
    procedure WritePicture(const Picture: TddPicture; aWholePar: Boolean); override;
    procedure WriteStyleTable(aDefault: Boolean = False); override;
    procedure WriteTable(const Table: TddTable; aOnlyPart: Boolean); override;
    procedure WriteTableRow(const aRow: TddTableRow; anIndex: Integer; const aRowType: TddRowType = dd_rtNone; aRowPos: TddRowPosition = dd_rpNone); override;
    procedure WriteTextParagraph(const Para: TddTextParagraph; anOutEOL: Boolean = False); override;
  public
    constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
  end;

  TevRTFObjectGenerator = class(TCustomRTFObjectGenerator)
  end;

implementation

uses
  Classes,
  SysUtils,
  Math,

  l3Interfaces,
  l3InternalInterfaces,
  l3Chars,
  l3Stream,
  l3Const,
  l3Date,
  l3String,
  l3Units, l3UnitsTools,
  l3Memory, l3TempMemoryStream,
  l3Canvas,
  evdStyles,
  k2Base,

  imageenio,
  imageenproc,

  ddRTFConst,
  ddRTFKeywords,
  destColorTable,
  ddRTFSegmentWriter,
  ddConst,
  {$IFDEF Envision}
  ddPictDetector,
  {$ENDIF}
  ddUtils,

  ExprDraw,
  ExprMake,

  evFont,
  evTypes,
  evParaTools,

  StrUtils,
  l3Defaults,

  evdTypes,

  ddTableCell;

{
***************************** TddDocumentGenerator *****************************
}
constructor TCustomRTFObjectGenerator.Create;
begin
 inherited Create(nil);
 f_WhiteIndex := -1;
 f_CellWidth := 0;
 f_WasTable := False;
 Host:= '';
end;

// start class TCustomRTFObjectGenerator

function TCustomRTFObjectGenerator.Border2RTF(aBorder: TddBorder; aFillType, aNextFillType: TddFillAAC): AnsiString;
const
  Alpha: Array[TddBorderParts] of AnsiChar = ('t', 'l', 'b', 'r', 'v', 'h', #0);
var
 i : TddBorderParts;
begin
 Result:= '';
 with aBorder do
 begin
  if aFillType > dd_faacNone then
   for i := Low(TddBorderParts) to bpRight do
   begin
    if (aFillType = dd_faacDefColorWithoutLine) and (i = bpTop) then Continue;              
    if (aFillType > dd_faacNone) and (aNextFillType = dd_faacDefColorWithoutLine) and (i = bpBottom) then Continue;
    Result := Result + Format('\clbrdr%s\brdrs\brdrw10', [Alpha[i]]);
    if (aFillType >= dd_faacDefColor) and (aFillType <> dd_faacAlignCell) then
     Result := Result + Format('\brdrcf%d', [f_AACCHP.Highlight])
    else
     Result := Result + Format('\brdrcf%d', [GetWhiteIndex])
   end // for i := Low(TddBorderParts) to bpRight do
  else
   if IsFramed then
   begin
    Result := '';
    for i := Low(TddBorderParts) to High(TddBorderParts) do
    begin
     if (Frames[i].FrameType <> btNone) then
     begin
      case BorderOwner of
       boPara : Result := Result + Format('\brdr%s', [Alpha[i]]);
       boRow  : Result := Result + Format('\trbrdr%s', [Alpha[i]]);
       boCell : Result := Result + Format('\clbrdr%s', [Alpha[i]]);
      end; { case BorderOwner }
      Result := Result + '\brdrs'; { тип линии. Желательно сделать преобразование }
      Result := Result + Format('\brdrw%d', [Frames[i].Width]); { толщина линии }
     end; { FrameType <> btNone }
    end; { for i }
   end; { IsFramed }
 end;
end;

function TCustomRTFObjectGenerator.Cell2RTF(aCell: TddCellProperty; aFillType, aNextFillType: TddFillAAC): AnsiString;
begin
  Result:= '';
  with aCell do
  begin
   if (aFillType > dd_faacWhite) and aCell.AlignCell then
    aFillType := dd_faacAlignCell;
   if (aFillType >= dd_faacDefColor) and (aFillType <> dd_faacAlignCell) then
    Result := GetCellFillColor4AAC;
   Result := Result + Border2RTF(Border, aFillType, aNextFillType);
   if VMerged then
    Result := Result + '\clvmrg';
   if VMergeFirst then
     Result := Result + '\clvmgf';
   if PatternBackColor <> propUndefined then
     Result := Result + Format('\clcbpat%d', [PatternBackColor+1]);
   if PatternForeColor <> propUndefined then
     Result := Result + Format('\clcfpat%d', [PatternForeColor+1]);
   case CellJust of
    cellTop    : Result := Result + '\clvertalt';
    cellCenter : Result := Result + '\clvertalc';
    cellBottom : Result := Result + '\clvertalb';
   end;
   Result:= Result + Format('\cellx%d', [CellOffset]);
  end;
end;

function TCustomRTFObjectGenerator.CHP2RTF(aCHP: TddCharacterProperty; aParentCHP: TddCharacterProperty;
                                           const WithStyle: Boolean = True): AnsiString;
begin
 Result:= '';
 if aCHP <> nil then
  with aCHP do
  begin
   if WithStyle then
   begin
    if (Style <> 0) and (Style <> propUndefined) then
     Result := Format('\%s%d', [TSYM(RTFKeywords.DRbyID[valu_cs]).AsString, ConvertStyleNumber(Style)])
   end;
   if (Language <> langRussian) and (Abs(Language) <> propUndefined) then
    Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[valu_Lang]).AsString, Language]);
   if (Abs(FontNumber) <> propUndefined) and (FontNumber <> 0) then
    Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[valu_f]).AsString, FontNumber]);
   if PrintFontSize <> propUndefined then
    FontSize := Min(PrintFontSize, FontSize);
   if (Abs(FontSize) <> propUndefined) then
    Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[valu_fs]).AsString, FontSize]);
   if Bold = True then
    Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[togg_b]).AsString, Ord(True)])
   else
    if (aParentCHP <> nil) and aParentCHP.Bold then
     Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[togg_b]).AsString, Ord(False)]);
   if Italic = True then
    Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[togg_i]).AsString, Ord(True)]);
   if not (Underline in [utNone, utNotDefined]) then
    Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[togg_ul]).AsString, Ord(True)]);
   if Abs(FColor) <> propUndefined then
    Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[valu_cf]).AsString, FColor]);
   if Abs(BColor) <> propUndefined then
    Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[valu_cb]).AsString, BColor]);
   if Abs(Highlight) <> propUndefined then
    Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[valu_chcbpat]).AsString, Highlight]);
   if not (Pos in [cpNone, cpNotDefined]) then
    case Pos of
     cpSuperScript : Result := Result + Format('\%s', [TSYM(RTFKeywords.DRbyID[flag_super]).AsString]);
     cpSubScript   : Result := Result + Format('\%s', [TSYM(RTFKeywords.DRbyID[flag_sub]).AsString]);
    end;
   if Hidden then
    Result := Result + Format('\%s1', [TSYM(RTFKeywords.DRbyID[togg_v]).AsString]);
   if Strikeout then
    Result := Result + Format('\%s', [TSYM(RTFKeywords.DRbyID[togg_strike]).AsString]);
   if CharScale <> propUndefined then
    Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[valu_charscalex]).AsString, CharScale]);
   if Result <> '' then
    Result := Result + ' ';
  end;
end; 

procedure TCustomRTFObjectGenerator.OutText(aText       : Tl3CustomString;
                                            anUnicode   : Boolean;
                                            const aPara : TddTextParagraph;
                                            const aStyle: TddStyleEntry);
var
 i            : Integer;
 l_Code       : Word;
 l_Text       : AnsiString;
 l_Char       : AnsiChar;
 l_HasSegment : Boolean;
 l_MemUnicode : Tl3String;
begin
 l_HasSegment := (aPara <> nil) and (aPara.SegmentCount > 0);
 if l_HasSegment then
  Init4Segments;
 try
  if anUnicode then
  begin
   if l_HasSegment then
    IncBracesCount(1, False);
   l_MemUnicode := Tl3String.Create;
   OutString(Format('{\f%d\uc1 ',[Document.AddFont(def_ANSIDOSFontName, 204)]));
   l_MemUnicode.Len := aText.Len * 2;
   MultiByteToWideChar(CP_RussianDOS, 0{mb_Composite}, aText.St, aText.Len, PWideChar(l_MemUnicode.St), l_MemUnicode.Len)
  end; // if anUnicode then

  for i := 0 to Pred(aText.Len) do
  begin
   if l_HasSegment then
    CheckStartSegments(aPara, i);

   if not CheckObjectSegment(aPara, i, aStyle) then
   begin
    if anUnicode then
    begin
     try
      WordRec(l_Code).Hi := Ord(l_MemUnicode.Ch[(i + 1) * 2 - 1]);
      WordRec(l_Code).Lo := Ord(l_MemUnicode.Ch[(i + 1) * 2 - 2]);
      case l_Code of
       {cc_TriUp}    30: l_Code := $25B2;
       {cc_TriDown}  31: l_Code := $25BC;
       {cc_TriLeft}  17: l_Code := $25C4;
       {cc_TriRight} 16: l_Code := $25BA;
      end;
      l_Text := Format('\u%d\''3F', [l_Code])
     except
      Msg2Log('Ошибка преобразования в Unicode');
     end; // try..except
    end
    else
    begin
     l_Char := aText.Ch[i];
     TranslateChar(l_Char, l_Text);
    end;
    OutString(l_Text);
   end;
   if l_HasSegment then
    CheckFinishSegments(aPara, i);
  end; //for i
  if anUnicode then
  begin
   if l_HasSegment then
    DecBracesCount(1)
   else
    WriteCloseBarket;
   l3Free(l_MemUnicode);
  end; // Unicode {or (aText.CodePage = CP_CentralEuropeWin)}
 finally
  DeInit4Segments;
 end;
end;

function TCustomRTFObjectGenerator.PAP2RTF(aPAP: TddParagraphProperty; aBlockIndent: Integer; anIgnoreLeftIndent: Boolean;
                                           WithStyle: Boolean = True): AnsiString;

 procedure lp_CheckIndent(var anIndent: Integer; aFirstIndent: Boolean);
 begin
  if aFirstIndent then
   anIndent := aPAP.xaFirst
  else
   anIndent := aPAP.xaLeft;
  if anIgnoreLeftIndent then
  begin
   if aFirstIndent then
    anIndent := 0
   else
    anIndent := aBlockIndent;
  end // if anIgnoreLeftIndent then
  else
   if (aBlockIndent = propUndefined) then
   begin
    if anIndent = 0 then // Раньше было условие: (xaLeft <> 0) или (xaFirst <> 0)
     anIndent := propUndefined
   end // if (aBlockIndent = propUndefined) then
   else
    if anIndent = propUndefined then
     anIndent := aBlockIndent
    else
     if not aFirstIndent then
      anIndent := anIndent + aBlockIndent;
 end;

var
 i            : Integer;
 l_LeftIndent : Integer;
 l_FirstIndent: Integer;
begin
 Result:= '';
 if aPAP <> nil then
  with aPAP do
  begin
   if WithStyle then
    if (Style <> propUndefined) and (Style <> 0) and (Style <> ev_saTxtNormalANSI) then
     Result := Format('\%s%d', [TSYM(RTFKeywords.DRbyID[valu_s]).AsString, ConvertStyleNumber(Style)]);
   lp_CheckIndent(l_LeftIndent, False);
   if (Abs(l_LeftIndent) <> propUndefined) then
    Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[valu_li]).AsString, l_LeftIndent]);
   if (Abs(xaRight) <> propUndefined) and (xaRight <> 0) then
    Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[valu_ri]).AsString, xaRight]);
   lp_CheckIndent(l_FirstIndent, True);
   if (Abs(l_FirstIndent) <> propUndefined) then
    Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[valu_fi]).AsString, l_FirstIndent]);
   case JUST of
    justL: Result := Result + Format('\%s', [TSYM(RTFKeywords.DRbyID[flag_ql]).AsString]);
    justR: Result := Result + Format('\%s', [TSYM(RTFKeywords.DRbyID[flag_qr]).AsString]);
    justC: Result := Result + Format('\%s', [TSYM(RTFKeywords.DRbyID[flag_qc]).AsString]);
    justF: Result := Result + Format('\%s', [TSYM(RTFKeywords.DRbyID[flag_qj]).AsString]);
   end;
   if (Param[dd_Hyph] <> propUndefined) and Hyph then
    Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[togg_HyphPar]).AsString, 1]);
   if (Abs(Before) <> propUndefined) and (Before <> 0) then
    Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[valu_sb]).AsString, Before]);
   if (Abs(After) <> propUndefined) and (After <> 0) then
    Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[valu_sa]).AsString, After]);
   Result := Result + Border2RTF(Border, dd_faacNone, dd_faacNone);
   for i := 0 to TabList.Hi do
    Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[valu_tx]).AsString, Longint(TabList.Items[i])]);
   if Result <> '' then
    Result := Result + ' ';
  end;
end;

procedure TCustomRTFObjectGenerator.Cleanup;
begin
 l3Free(f_FillTypeStack);
 f_WhiteIndex := -1;
 f_CellWidth := 0;
 f_WasTable := False;
 l3Free(f_PicWidths);
 DeinitAACProps;
 inherited;
end;

function TCustomRTFObjectGenerator.TAP2RTF(aTAP: TddRowProperty; aEmtyBorder: Boolean): AnsiString;
begin
 with aTAP do
 begin
  { Параметры строки таблицы }
  Result := Format('\%s%d', [TSYM(RTFKeywords.DRbyID[valu_trgaph]).AsString, Gaph]) + 
            Format('\%s%d', [TSYM(RTFKeywords.DRbyID[valu_trleft]).AsString, Left]);
  if aEmtyBorder then
   Result := Result + cc_EOL
  else
   Result := Result + Border2RTF(Border, dd_faacNone, dd_faacNone) + cc_EOL;
 end;  
end;

procedure TCustomRTFObjectGenerator.TranslateChar(C: AnsiChar; out Res: AnsiString);
const
 HSymbols = '0123456789abcdef';
var
 Code: Byte absolute C;
begin
  if (C > #128) or ((C < #32) and (C <> #9)) then
  { // not printable and not tab}
  begin
    case C of
      #10 : Res:= Format('\%s ',[TSYM(RTFKeywords.DRbyID[symb_line]).AsString]);
      #145: Res:= Format('\%s ',[TSYM(RTFKeywords.DRbyID[Symb_lquote]).AsString]);
      #146: Res:= Format('\%s ',[TSYM(RTFKeywords.DRbyID[Symb_lquote]).AsString]);
      #132, {                                //„//«}
      #171: Res:= Format('\%s ',[TSYM(RTFKeywords.DRbyID[Symb_ldblquote]).AsString]);
      #147: Res:= Format('\%s ',[TSYM(RTFKeywords.DRbyID[Symb_ldblquote]).AsString]);
      #187, {/ for ruSSian document               //»}
      #148: Res:= Format('\%s',[TSYM(RTFKeywords.DRbyID[Symb_rdblquote]).AsString]);
      #149: Res:= Format('\%s',[TSYM(RTFKeywords.DRbyID[Symb_bullet]).AsString]);
      #150: Res:= Format('\%s',[TSYM(RTFKeywords.DRbyID[Symb_endaSh]).AsString]);
      #151: Res:= Format('\%s',[TSYM(RTFKeywords.DRbyID[Symb_emdaSh]).AsString]);
      #160: Res:= Format('\%s',[TSYM(RTFKeywords.DRbyID[symb_tilda]).AsString]);{  soft space}
      #1: ;
      #2: ;
    else
      {$IFDEF DontTranslate}
      Res:= C;
      {$ELSE}
      // быстрое преобразование числа в hex
      // раньше здесь было узкое место
      SetLength(Res, 4);
      Res[1] := '\';
      Res[2] := '''';
      Res[3] := HSymbols[((Code and $F0) shr 4) + 1];
      Res[4] := HSymbols[(Code and $0F) + 1];
      {$ENDIF}
    end; { case }
  end
  else
  begin
    case C of
      #9 : Res:= Format('\%s ', [TSym(rtfKeywords.DRbyID[symb_tab]).AsString]);
      '{': Res:= '\{';
      '}': Res:= '\}';
      '\': Res:= '\\';
      else
      begin
       SetLength(Res, 1);
       Res[1] := C;
      end;
    end;
  end;
end;

procedure TCustomRTFObjectGenerator.WriteBreak(const aBreak: TddBreak);
begin
  case aBreak.BreakType of
    breakPage: OutString('\page');
    breakColumn: ;
    breakSection:
      begin
        OutString('\sect\sectd');
        // Выливаем параметры раздела
         with aBreak.SEP do
         begin
           if Landscape then
           begin
             OutString(Format('\%s ',[TSYM(RTFKeywords.DRbyID[flag_lndscpsxn]).AsString]));{ альбомная ориентация  }
             OutString(Format('\%s%d',[TSYM(RTFKeywords.DRbyID[valu_pgwsxn]).AsString, yaPage]));  { page width in twips  }
             OutString(Format('\%s%d ',[TSYM(RTFKeywords.DRbyID[valu_pghsxn]).AsString, xaPage])); { page height in twips }
           end
           else
           begin
             OutString(Format('\%s%d',[TSYM(RTFKeywords.DRbyID[valu_pgwsxn]).AsString, xaPage]));  { page width in twips  }
             OutString(Format('\%s%d ',[TSYM(RTFKeywords.DRbyID[valu_pghsxn]).AsString, yaPage])); { page height in twips }
           end;
           OutString(Format('\%s%d ',[TSYM(RTFKeywords.DRbyID[valu_marglsxn]).AsString, xaLeft]));  { left margin in twips }
           OutString(Format('\%s%d ',[TSYM(RTFKeywords.DRbyID[valu_margtsxn]).AsString, yaTop]));   { top margin in twips  }
           OutString(Format('\%s%d ',[TSYM(RTFKeywords.DRbyID[valu_margrsxn]).AsString, xaRight])); { right margin in twips }
           OutString(Format('\%s%d ',[TSYM(RTFKeywords.DRbyID[valu_margbsxn]).AsString, yaBottom]));{ bottom margin in twips }
         end;
      end;
  end;
end;

procedure TCustomRTFObjectGenerator.WriteColorTable(aDefault: Boolean = False);
var
  i: Integer;
begin
  OutString('{\colortbl;');
  for i := 0 to Pred(Document.ColorCount) do
  begin
    with TddColorEntry(Document.ColorTable[i]) do
      OutString(Format('\red%d\green%d\blue%d;', [Red, Green, Blue]));
  end;
  OutString('}');  
end;

procedure TCustomRTFObjectGenerator.WriteDocumentEnd;
begin
  OutString('}');
end;

procedure TCustomRTFObjectGenerator.WriteDocumentStart;
begin
  OutString('{\rtf1\ansi\ansicpg1251\deff0\deflang1049\deflangfe1049 ');
  f_NestedLevel:= 0;
end;

procedure TCustomRTFObjectGenerator.WriteFontTable(aDefault: Boolean = False);
var
 i: Integer;
 l_F: TddFontEntry;
 l_St: AnsiString;
begin
 OutString('{' + Format('\%s',[TSYM(RTFKeywords.DRbyID[dest_fonttbl]).AsString]));

 for i:= 0 to Pred(Document.FontCount) do
 begin
   l_F := Document.FontTable[i];
   l_St := '{'+Format('\%s%d',[TSYM(RTFKeywords.DRbyID[valu_f]).AsString, l_F.Number]);
   case l_F.Family of
     ffNil   : l_St:= l_St + Format('\%s',[TSYM(RTFKeywords.DRbyID[flag_fnil]).AsString]);
     ffRoman : l_St:= l_St + Format('\%s',[TSYM(RTFKeywords.DRbyID[flag_froman]).AsString]);
     ffSwiss : l_St:= l_St + Format('\%s',[TSYM(RTFKeywords.DRbyID[flag_fswiss]).AsString]);
     ffModern: l_St:= l_St + Format('\%s',[TSYM(RTFKeywords.DRbyID[flag_fmodern]).AsString]);
     ffScript: l_St:= l_St + Format('\%s',[TSYM(RTFKeywords.DRbyID[flag_fscript]).AsString]);
     ffDecor : l_St:= l_St + Format('\%s',[TSYM(RTFKeywords.DRbyID[flag_fdecor]).AsString]);
     ffTech  : l_St:= l_St + Format('\%s',[TSYM(RTFKeywords.DRbyID[flag_ftech]).AsString]);
     ffBidi  : l_St:= l_St + Format('\%s',[TSYM(RTFKeywords.DRbyID[flag_fbidi]).AsString]);
   end;
   if l_F.Charset <> propUndefined then
    l_St:= l_St + Format('\%s%d',[TSYM(RTFKeywords.DRbyID[valu_fcharset]).AsString, l_F.CharSet]);
   l_St:= l_St + ' ' + l_F.AsString + ';}';
   OutString(l_St)
 end;
 OutStringLn('}');
end;

procedure TCustomRTFObjectGenerator.WriteHeader(aDefault: Boolean = False);
procedure _OutInfo(keyword: AnsiString; aInfo: Tl3String);
begin
 if not aInfo.Empty then
 begin
  OutString('{\'+keyword+' ');
  OutText(aInfo, False);
  OutString('}');
 end;
end;

begin
  {$IfNDef nsTest}
  OutString(Format('{\*\generator %s}', [GetProgramVersion]));
  {$EndIf  nsTest}

  with Document.Info do
  begin
   OutString('{\info ');
   _OutInfo('title', Title);
   _OutInfo('subject', Subject);
   _OutInfo('author', Author);
   _OutInfo('manager', Manager);
   _OutInfo('company', Company);
   _OutInfo('operator', Operator);
   _OutInfo('category', Category);
   _OutInfo('keywords', Keywords);
   _OutInfo('comment', Comment);
   _OutInfo('doccomm', Doccomm);
   OutString('}');
  end;

  with Document.DOP do
  begin
   Landscape:= xaPage > yaPage;

   OutString(Format('\%s%d', [TSYM(RTFKeywords.DRbyID[valu_paperw]).AsString, xaPage{IfThen(fLandscape, yaPage, xaPage)}]));  { page width in twips  }
   OutString(Format('\%s%d ', [TSYM(RTFKeywords.DRbyID[valu_paperh]).AsString, yaPage{IfThen(fLandscape, xaPage, yaPage)}])); { page height in twips }
   OutString(Format('\%s%d ', [TSYM(RTFKeywords.DRbyID[valu_margl]).AsString, xaLeft]));  { left margin in twips }
   OutString(Format('\%s%d ', [TSYM(RTFKeywords.DRbyID[valu_margt]).AsString, yaTop]));   { top margin in twips  }
   OutString(Format('\%s%d ', [TSYM(RTFKeywords.DRbyID[valu_margr]).AsString, xaRight])); { right margin in twips }
   OutString(Format('\%s%d ', [TSYM(RTFKeywords.DRbyID[valu_margb]).AsString, yaBottom]));{ bottom margin in twips }
   if Landscape then
    OutString(Format('\%s ', [TSYM(RTFKeywords.DRbyID[flag_landscape]).AsString])); { landscape or portrait??        }
 end;
end;

function TCustomRTFObjectGenerator.DIffCHP2RTF(aCHP1, aCHP2: TddCharacterProperty): AnsiString;
begin
 Result:= '';
 if (aCHP1 <> nil) and (aCHP2 <> nil) then
  with aCHP1 do
  begin
   if (Language <> langRussian) and (Language <> propUndefined) then
    Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[valu_Lang]).AsString, Language]);
   if (FontNumber <> propUndefined) and (FontNumber <> 0) then
    Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[valu_f]).AsString, FontNumber]);
   if (FontSize <> propUndefined) then
    Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[valu_fs]).AsString, FontSize]);
   if Bold = True then
    Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[togg_b]).AsString, Ord(True)])
   else
    if aCHP2.Bold then
     Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[togg_b]).AsString, Ord(False)]);
   if Italic = True then
    Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[togg_i]).AsString, Ord(True)])
   else
    if aCHP2.Italic then
     Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[togg_i]).AsString, Ord(False)]);
   if not (Underline in [utNone, utNotDefined]) then
    Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[togg_ul]).AsString, Ord(True)])
   else
    if not (aCHP2.Underline in [utNone, utNotDefined]) then
     Result:= Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[togg_ul]).AsString, Ord(False)]);
   if FColor <> propUndefined then
    Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[valu_cf]).AsString, FColor]);
   if BColor <> propUndefined then
    Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[valu_cb]).AsString, BColor]);
   if Highlight <> propUndefined then
    Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[valu_highlight]).AsString, Highlight]);
   if not (Pos in [cpNone, cpNotDefined]) then
    case Pos of
     cpSuperScript : Result := Result + Format('\%s', [TSYM(RTFKeywords.DRbyID[flag_super]).AsString]);
     cpSubScript   : Result := Result + Format('\%s', [TSYM(RTFKeywords.DRbyID[flag_sub]).AsString]);
    end;
   if Hidden then
    Result := Result + Format('\%s1', [TSYM(RTFKeywords.DRbyID[togg_v]).AsString]);
   if Strikeout then
    Result := Result + Format('\%s', [TSYM(RTFKeywords.DRbyID[togg_strike]).AsString]);
  end;
  if Result <> '' then
   Result := Result + ' ';
end;

function TCustomRTFObjectGenerator.Pixels2Twips(aPixels: Integer; aDPI: Integer = 96): Integer;
begin
 Result := MulDiv(aPixels, l3Inch, aDPI);
end;

function TCustomRTFObjectGenerator.Style2RTF(aStyle: TddStyleEntry; aBlockIndent: Integer; anIgnoreLeftIndent: Boolean): AnsiString;
var
 l_DiffCHP: TddCharacterProperty;

 procedure lp_Correct4K530819607;
 begin
  if (aStyle.FakeStyleID > -1) then
  begin
   if l_DiffCHP.FColor <> propUndefined then
    l_DiffCHP.FColor := propUndefined;
  end; // if (aStyle.FakeStyleID > -1) then
 end;

var
 l_PAP     : TddParagraphProperty;
 l_CHP     : TddCharacterProperty;
 l_DiffPAP : TddParagraphProperty;
begin
 Result := '';
 l_PAP := TddParagraphProperty.Create;
 try
  l_CHP := TddCharacterProperty.Create;
  try
   Document.MakeStyleParent(aStyle.BasedOn, l_PAP, l_CHP); // Это только предки
   l_DiffPAP := aStyle.PAP.Clone;
   try
    l_DiffPAP.JoinWith(l_PAP);
    l_DiffCHP := aStyle.CHP.Clone;
    try
     l_DiffCHP.JoinWith(l_CHP);
     if aStyle.StyleDef = sdParagraph then
      Result := PAP2RTF(l_DiffPAP, aBlockIndent, anIgnoreLeftIndent, True);
     lp_Correct4K530819607;
     Result := Result + CHP2RTF(l_DiffCHP, l_CHP);
    finally
     FreeAndNil(l_DiffCHP);
    end;
   finally
    FreeAndNil(l_DiffPAP);
   end;
  finally
   FreeAndNil(l_CHP);
  end;
 finally
  FreeAndNil(l_PAP);
 end;
end;    

procedure TCustomRTFObjectGenerator.WritePicture(const Picture: TddPicture;
    aWholePar: Boolean);
var
 l_Format: AnsiString;
 l_PicStr: AnsiString;
 l_Offset: Integer;
 l_Scale : Integer;
 l_Width : Integer;
 l_Height: Integer;
begin
 if not Picture.Stored then Exit;
 OutTextAndClearCellHasPara;
 if aWholePar and (Table <> nil) then
 begin
  OutString('\pard\plain ');
  OutString(Format('\intbl\itap%d', [f_NestedLevel]));
 end; // if aWholePar and (Table <> nil) then
 if (Table = nil) then
 begin
  f_CellWidth := 0;
  f_WasTable := False;
 end; // if (Table = nil) then
 l_Height := Picture.Height;
 l_Width := Picture.Width;
 l_Offset := 0;
 l_Format := AnalizePicture(Picture, l_Offset);
 if l_Format = '' then Exit;
 if aWholePar then
  l_PicStr := PAP2RTF(Picture.PAP, Picture.BlockIndent, Picture.IgnoreLeftIndent)
 else
  l_PicStr := '';
 l_PicStr := l_PicStr + '{\*\shppict{\pict' + l_Format;

 if (l_Width <= 0) then
  l_Width := Pixels2Twips(Picture.Width)
 else
  l_Width := Pixels2Twips(l_Width);
 if (l_Height <= 0) then
  l_Height := Pixels2Twips(Picture.Height)
 else
  l_Height := Pixels2Twips(l_Height);
 if (l_Width > 0) and (l_Height > 0) then
  l_PicStr := Format('%s\picw%d\pich%d ', [l_PicStr, l_Width, l_Height]) ;
 if (l_Width > f_PictureWidth) or (l_Height > Document.PageHeight) then
 begin
  l_Scale := Min(MulDiv(f_PictureWidth, 100, l_Width),
                 MulDiv(Document.PageHeight, 100, l_Height));
  // Вот это странно - нам УЖЕ присвоили GoalXY
  Picture.GoalX := (MulDiv(l_Width, l_Scale, 100));
  Picture.GoalY := (MulDiv(l_Height, l_Scale, 100));
 end // (l_Width > Document.PageWidth) or (l_Height <= Document.PageHeight)
 else
 begin
  Picture.GoalX := l_Width;
  Picture.GoalY := l_Height;
 end;
 // Было выключено. Почему?
 if (Picture.GoalX > 0) and (Picture.GoalY > 0) then
  l_PicStr := Format('%s\picwgoal%d\pichgoal%d ', [l_PicStr, Picture.GoalX, Picture.GoalY]);
 if (Picture.ScaleX <> 100) and (Picture.ScaleY <> 100) then
  l_PicStr := Format('%s\picscalex%d\picscaley%d ', [l_PicStr, MulDiv(Picture.ScaleX, 72, 96), MulDiv(Picture.ScaleY, 72, 96)]);
 OutString(l_PicStr);
 try
  Picture.IsBinary := False;
  OutString(Picture.Picture.Offset(l_Offset * 2));
 finally
  OutString('}}');
 end;
end;

procedure TCustomRTFObjectGenerator.WriteStyleTable(aDefault: Boolean = False);
var
 l_St: AnsiString;
 l_Style: TddStyleEntry;
 i, j: Integer;
 MemUnicode: Tl3String;
 W: Word;

 function lp_Style2RTF(aStyle: TddStyleEntry): AnsiString;
 var
  l_BasedOn    : Integer;
  l_ParentStyle: TddStyleEntry;
 begin
  Result := '{';
  if aStyle.StyleDef = sdCharacter then
   Result := Result + '\*';
  Result := Result + Style2RTF(aStyle, propUndefined, False) + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[valu_snext]).AsString, 0]);
  if (aStyle.BasedOn <> 0) and (aStyle.BasedOn <> 222) then
  begin
   l_BasedOn := ConvertStyleNumber(aStyle.BasedOn);
   if aStyle.StyleDef = sdCharacter then
   begin
    l_ParentStyle := Document.StyleTable[l_BasedOn];
    if (l_ParentStyle <> nil) and (l_ParentStyle.FakeStyleID > -1) then
    begin
     l_ParentStyle := Document.StyleSheet[l_ParentStyle.FakeStyleID];
     l_BasedOn := ConvertStyleNumber(l_ParentStyle.Number);
    end;
   end; // if aStyle.StyleDef = sdCharacter then
   Result := Result + Format('\%s%d', [TSYM(RTFKeywords.DRbyID[valu_sbasedon]).AsString, l_BasedOn]);
  end;
 end; // lp_Style2RTF

 function lp_OutStyleName(aStyle: TddStyleEntry): Boolean;
 begin
  Result := True;
  OutString(cc_HardSpace);
  if ConvertStyleNumber(aStyle.Number) = 0 then
   OutString('Normal')
  else
  if ConvertStyleNumber(aStyle.Number) in [1..5] then
   OutString(Format('heading %d', [ConvertStyleNumber(aStyle.Number)]))
  else
   Result := False;
 end; //lp_OutStyleName

begin
 if Document.StyleCount > 0 then
 begin
  { нужно вылить два раза - обычно и в уникоде }
  OutStringLn('');
  OutString('{\upr');
  // Ansi
  OutString('{' + Format('\%s', [TSYM(RTFKeywords.DRbyID[dest_stylesheet]).AsString]));
  for i := 0 to Pred(Document.StyleCount) do
  begin
   l_Style:= Document.StyleSheet[i];
   Outstring(lp_Style2RTF(l_Style));
   // Добавляем имя стиля
   if not lp_OutStyleName(l_Style) then
    OutText(l_Style, False);
   OutStringLn(';}');
  end; // for i
  OutStringLn('}'); // StyleSheet

  OutString('{\*\ud\uc0 ');
  OutString('{' + Format('\%s', [TSYM(RTFKeywords.DRbyID[dest_stylesheet]).AsString]));
  for i := 0 to Pred(Document.StyleCount) do
  begin
   l_Style := Document.StyleSheet[i];
   Outstring(lp_Style2RTF(l_Style));
   OutString(cc_HardSpace);
   OutString('{');
   MemUnicode := Tl3String.Create;
   try
    l_St := '\uc1';
    OutString(l_St);
    MemUnicode.Len := l_Style.Len * 2;
    MultiByteToWideChar({866}Cp_acp, 0{mb_Composite}, l_Style.St, l_Style.Len, PWideChar(MemUnicode.St), MemUnicode.Len);

    if not lp_OutStyleName(l_Style) then
     for j := 0 to Pred(l_Style.Len) do
     begin
      try
       WordRec(W).Hi := Ord(MemUnicode.ch[(j + 1) * 2 - 1]);
       WordRec(W).Lo := Ord(MemUnicode.ch[(j + 1) * 2 - 2]);
       l_St := Format('\u%d ?', [W])
      except
       Msg2Log('Ошибка преобразования в Unicode');
      end;
      OutString(l_St);
     end; // for j
   finally
    FreeAndNil(MemUnicode);
   end;
   OutStringLn('};}');
  end; // for i
  OutStringLn('}}'); // \ud\stylesheet
  OutString('}'); // {\upr
 end;
end;

procedure TCustomRTFObjectGenerator.WriteTable(const Table: TddTable; aOnlyPart: Boolean);
var
 l_IsAAC : Boolean;
 l_Count : Integer;

 function lp_Index2RowPos(anIndex: Integer): TddRowPosition;
 begin
  if anIndex = 0 then
   Result := dd_rpFirst
  else
   if anIndex = l_Count then
    Result := dd_rpLast
   else
    Result := dd_rpNone;
 end;

 function lp_InitRowType: TddRowType;
 begin
  Result := TddRowType(Table.IsSBS);
  if Result = dd_rtNone then
   if Table.Nested then
    if evAACStyle(Table.Style) then
    begin
     Result := dd_rtNestedAAC;
     l_IsAAC := True;
    end // if evAACStyle(Table.Style) then
    else
     Result := dd_rtNested
   else
    if evAACStyle(Table.Style) then
    begin
     Result := dd_rtAAC;
     l_IsAAC := True;
    end;
 end;

var
 l_Row     : TddTableRow;
 l_RowPos  : TddRowPosition;
 l_NextPos : TddRowPosition;
 l_RowType : TddRowType;

 procedure lp_InitFillType(anIndex: Integer);
 var
  l_FillType: TddFillAAC;
 begin
  l_FillType := dd_faacNone;
  if anIndex = 0 then
  begin
   l_RowPos := lp_Index2RowPos(anIndex);
   l_FillType := NeedFillCell(l_Row, l_RowType, l_RowPos);
  end // if anIndex = 0 then
  else
  begin
   l_RowPos := l_NextPos;
   l_FillType := f_NextFillType;
  end;
  if anIndex < l_Count then
  begin
   l_NextPos := lp_Index2RowPos(anIndex + 1);
   f_NextFillType := NeedFillCell(Table.Rows[anIndex + 1], l_RowType, l_NextPos);
  end; // if i < l_Count then
  f_FillTypeStack.Push(l_FillType);
 end;

 procedure lp_InitFillRowTypeAndRowPos(anIndex: Integer);
 begin
  if l_RowType >= dd_rtAAC then
  begin
   CheckAACRow(Table.Style, l_Row, anIndex = 0, l_RowType);
   lp_InitFillType(anIndex);
  end // if l_RowType >= dd_rtAAC then
  else
  begin
   l_RowPos := lp_Index2RowPos(anIndex);
   f_FillTypeStack.Push(dd_faacNone);
  end;
 end;

var
 i : Integer;
begin
 if not Table.Stored then Exit;
 Inc(f_NestedLevel);
 l_IsAAC := False;
 l_RowType := lp_InitRowType;
 if l_RowType = dd_rtAAC then
  Try2AddEmtpyPara;
 if f_FillTypeStack = nil then
  f_FillTypeStack := TddFillAACStack.Create;
 l_Count := Table.RowCount - 1;
 try
  for i := 0 to l_Count do
  begin
   l_Row := Table.Rows[i];
   lp_InitFillRowTypeAndRowPos(Table.StartRow + i);
   WriteTableRow(l_Row, Table.StartRow + i, l_RowType, l_RowPos);
   f_FillTypeStack.Pop;
  end; // for i := 0 to Pred(Table.RowCount) do
  Dec(f_NestedLevel);
  if not aOnlyPart then
  begin
   OutString('\pard\plain ');
   if (f_NestedLevel = 0) and (l_RowType <> dd_rtAAC) then
    f_WasTable := True;
  end; // if not aOnlyPart then
  if f_FillTypeStack.Count = 0 then
   l3Free(f_FillTypeStack);
 finally
  if l_IsAAC and not aOnlyPart then
   DeinitAACProps;
 end;
end;

procedure TCustomRTFObjectGenerator.WriteTableRow(const aRow: TddTableRow;
                                                  anIndex: Integer;
                                                  const aRowType: TddRowType = dd_rtNone;
                                                  aRowPos: TddRowPosition = dd_rpNone);

 function lp_RowProps: AnsiString;
 const
  csRowProps = '\trowd \irow%d\irowband%d';
 begin
  Result := Format(csRowProps, [anIndex, anIndex]);
  if aRow.TAP.IsLastRow and (anIndex > 0) then
   Result := Result + '\lastrow';
 end;

var
 l_Cell: TddTableCell;

 function lp_NeedEOL: Boolean;
 begin
  Result := (aRowType >= dd_rtAAC) and (aRowPos = dd_rpNone) and (l_Cell.anIndex = 1);
 end;

const
 csetNestedRow = [dd_rtNested, dd_rtNestedAAC];
var
 i, j        : Integer;
 l_Atom      : TddDocumentAtom;
 l_Width     : Integer;
 l_Picture   : TddPicture;
 l_OldWidth  : Tl3LongintList;
 l_RowProps  : AnsiString;
 l_CellCount : Integer;
begin
 l_RowProps := lp_RowProps;
 if (aRowType >= dd_rtAAC) and (aRowPos > dd_rpNone) then
  l_RowProps := l_RowProps + GetRowHeight4AACSpace(aRowPos = dd_rpFirst);
 if aRow.TAP.Autofit then
 begin
  l_RowProps := l_RowProps + '\trautofit1';
  // Нужно подогнать ширину ячеек
  l_Width := 0;
  for i := 0 to Pred(aRow.CellCount) do
   Inc(l_Width, aRow[i].Props.CellOffset);
  if l_Width > 0 then
   for i := 0 to Pred(aRow.CellCount) do
    aRow[i].Props.CellOffset := aRow[i].Props.CellOffset * aRow.TAP.Width div l_Width;
 end; // aTAP.Autofit
 l_RowProps := l_RowProps + TAP2RTF(aRow.TAP, aRowType >= dd_rtAAC);
 l_OldWidth := Tl3LongintList.Create;
 try
  l_CellCount := aRow.CellCount - 1;
  for i := 0 to l_CellCount do
  begin
   l_Cell := aRow[i];
   l_OldWidth.Add(l_Cell.Props.CellOffset - l_Cell.Props.LeftPad);
   if i > 0 then
    l_Cell.Props.CellOffset := l_Cell.Props.CellOffset + aRow[(i - 1)].Props.CellOffset
   else
    l_Cell.Props.CellOffset := l_Cell.Props.CellOffset + aRow.TAP.Left;
   l_RowProps := l_RowProps + Cell2RTF(l_Cell.Props, f_FillTypeStack.Peek, f_NextFillType);
  end; // for i:= 0 to aRow.CellCount - 1 do
  if not (aRowType in csetNestedRow) then
   OutString(l_RowProps);
  RememberLastPictureWidth;
  try
   for i := 0 to l_CellCount do
   begin
    l_Cell := aRow.Cells[i];
    f_CellHasPara := False;
    f_PictureWidth := l_OldWidth[i];
    for j := 0 to l_Cell.Hi do
    begin
     l_Atom := l_Cell.Items[j];
     if l_Atom.IsTextPara then
      WriteTextParagraph(TddTextParagraph(l_Atom), lp_NeedEOL)
     else
      if l_Atom.IsPicture then
      begin
       l_Picture := TddPicture(l_Atom);
       l_Picture.PAP.InTable := True;
       l_Picture.ScaleX := Table.Scale;
       l_Picture.ScaleY := Table.Scale;
       WritePicture(l_Picture, True);
       if aRowType < dd_rtAAC then
        OutputEOPara;
      end // if l_Atom.IsPicture then
      else
       if l_Atom.IsTable then
       begin
        if f_CellHasPara then
         OutputEOPara;
        WriteTable(TddTable(l_Atom), False);
        OutString(l_RowProps);
       end; // dd_docTable
    end; // for j
    OutStringLn(IfThen(aRowType in csetNestedRow, '\nestcell{\nonesttables\par}', '\cell'));
    f_CellHasPara := False;
   end; // for i
  finally
   DoInitPictureWidth;
  end;
 finally
  l3Free(l_OldWidth);
 end;
 if aRowType in csetNestedRow then
  OutStringLn('{\*\nesttableprops' + l_RowProps + '\nestrow}{\nonesttables\par}')
 else
  OutStringLn(l_RowProps + '\row');
end;

procedure TCustomRTFObjectGenerator.WriteTextParagraph(const Para: TddTextParagraph; anOutEOL: Boolean = False);
var
 l_Style: TddStyleEntry;
begin // WriteTextParagraph
 if not Para.Stored then Exit;
 with Filer do
 begin
  OutTextAndClearCellHasPara;
  WorkWithBookmarks(Para, True);
  // Собственно абзац
  l_Style := OutputPAP(Para);
  OutputCHPStyle(Para, l_Style);
  OutputCharacterProperty(Para, l_Style);
  OutText(Para, l_Style);
  if Para.PAP.InTable then
   if anOutEOL then
    OutputEOPara
   else
    f_CellHasPara := True
  else
  begin
   f_CellWidth := 0;
   f_WasTable := False;
   OutputEOParaWithClearStyle;
  end;
  WorkWithBookmarks(Para, False);
 end;
end;

procedure TCustomRTFObjectGenerator.OutTextAndClearCellHasPara;
begin
 if f_CellHasPara then
 begin
  f_CellHasPara:= False;
  OutputEOPara;
 end;
end;

procedure TCustomRTFObjectGenerator.WorkWithBookmarks(const aPara: TddTextParagraph; anOpen: Boolean);
var
 i       : Integer;
 l_SubID : Integer;
begin
 if anOpen then
   // Открываем закладки
  for i := 0 to aPara.SubList.Hi do
  begin
   l_SubID := aPara.SubList[i].ID;
   OutString(Format('{\*\bkmkstart %s%d}', [SubAlias, l_SubID]));
  end // for i := 0 to Para.SubList.Hi do
 else
  // Закрываем закладки
  for i := aPara.SubList.Hi downto 0 do
  begin
   l_SubID := aPara.SubList[i].ID;
   OutString(Format('{\*\bkmkend %s%d}', [SubAlias, l_SubID]));
  end;
end;

function TCustomRTFObjectGenerator.OutputParaFormat(
  const aPara: TddTextParagraph): TddStyleEntry;
var
 l_PAP        : TddParagraphProperty;
 l_StylePAP   : TddParagraphProperty;
 l_StyleCHP   : TddCharacterProperty;
 l_ParaFormat : AnsiString;
begin
 Result := nil;
 l_ParaFormat := '\pard\plain ';
 if aPara.PAP.InTable then
  l_ParaFormat := l_ParaFormat + (Format('\intbl\itap%d', [f_NestedLevel]));
 if aPara.PAP.Bullet <> propUndefined then
  l_ParaFormat := l_ParaFormat + (Format('{\f%d\fs20\''B7}\tab', [Document.AddFont('Symbol', 2)]));
 l_ParaFormat := l_ParaFormat + Border2RTF(aPara.PAP.Border, dd_faacNone, dd_faacNone);

 if aPara.PAP.Style <> propUndefined then
 begin
  Result := Document.StyleTable[aPara.PAP.Style];
  if Result <> nil then
   l_ParaFormat := l_ParaFormat + Style2RTF(Result, aPara.BlockIndent, aPara.IgnoreLeftIndent);
 end; // if aPara.PAP.Style <> propUndefined then
 if not aPara.PAP.IsDefault then
 try
  if Result <> nil then
  begin
   l_StylePAP := TddParagraphProperty.Create;
   try
    l_StyleCHP := TddCharacterProperty.Create;
    try
     Document.MakeStyleParent(aPara.PAP.Style, l_StylePAP, l_StyleCHP);
     l_PAP := TddParagraphProperty(aPara.PAP.Diff(l_StylePAP, False));
     if l_PAP <> nil then
      l_ParaFormat := l_ParaFormat + PAP2RTF(l_PAP, aPara.BlockIndent, aPara.IgnoreLeftIndent, False);
    finally
     FreeAndNil(l_StyleCHP);
    end;
   finally
    FreeAndNil(l_StylePAP);
   end;
  end // if Result <> nil then
  else
   l_ParaFormat := l_ParaFormat + PAP2RTF(aPara.PAP, aPara.BlockIndent, aPara.IgnoreLeftIndent, False);
 finally
  FreeAndNil(l_PAP);
 end;
 OutString(l_ParaFormat);
end;

procedure TCustomRTFObjectGenerator.OutputCHPStyle(
  const aPara: TddTextParagraph; var aStyle: TddStyleEntry);
begin
 if aPara.CHP.Style <> propUndefined then
 begin
  aStyle := Document.StyleTable[aPara.CHP.Style];
  if aStyle <> nil then
  begin
   if aPara.PAP.Style = propUndefined then
    OutString(Style2RTF(Document.StyleTable[ev_saTxtNormalANSI], propUndefined, False));
   OutString(Style2RTF(aStyle, propUndefined, False));
  end; // if aStyle <> nil then
 end; // if aPara.CHP.Style <> propUndefined then
end;

procedure TCustomRTFObjectGenerator.OutputCharacterProperty(
  const aPara: TddTextParagraph; const aStyle: TddStyleEntry);
var
 l_CHP  : TddCharacterProperty;
 l_Style: TddStyleEntry;
begin
 if aPara.CHP.IsDefault then
 begin
  if (aStyle.FakeStyleID > -1) then
  begin
   l_Style := Document.StyleSheet[aStyle.FakeStyleID];
   OutString(Style2RTF(l_Style, propUndefined, False));
  end; // if aStyle.FakeStyleID <> propUndefined then
 end // if aPara.CHP.IsDefault then
 else
 begin
  if aStyle <> nil then
  begin
   l_CHP := TddCharacterProperty(aStyle.CHP.Diff(aPara.CHP, False));
   try
    if l_CHP <> nil then
     OutString(CHP2RTF(l_CHP, nil, False));
   finally
    l3Free(l_CHP);
   end;
  end // if aStyle <> nil then
  else
   OutString(CHP2RTF(aPara.CHP, nil, False));
 end; // if not aPara.CHP.IsDefault thens
end;

procedure TCustomRTFObjectGenerator.OutText(aText: Tl3CustomString;
  anUnicode: Boolean);
begin
 OutText(aText, anUnicode, nil, nil);
end;

procedure TCustomRTFObjectGenerator.OutText(const aPara: TddTextParagraph;
  const aStyle: TddStyleEntry);
begin
 OutText(aPara.Text, aPara.Unicode, aPara, aStyle);
end;

procedure TCustomRTFObjectGenerator.DoInitPictureWidth;
begin
 if (f_PicWidths <> nil) and (f_PicWidths.Count > 0) then
 begin
  f_PictureWidth := f_PicWidths.Last;
  GetPicWidthStack.DeleteLast;
 end // if (f_PicWidths <> nil) or (f_PicWidths.Count > 0) then
 else
  f_PictureWidth := Document.PageWidth;
end;

function TCustomRTFObjectGenerator.OutputPAP(const Para: TddTextParagraph): TddStyleEntry;
begin
 Result := OutputParaFormat(Para);
end;

procedure TCustomRTFObjectGenerator.OutputEOParaWithClearStyle;
begin
 OutStringLn('\par\pard');
end;

procedure TCustomRTFObjectGenerator.OutputEOPara;
begin
 OutString('\par');
end;

procedure TCustomRTFObjectGenerator.CheckAACRow(aStyleID: Integer; const aRow: TddTableRow; aNeedInit: Boolean; aRowType: TddRowType);
const
 cnWidthDelta = 50;

 function lp_RecalcWidth: Integer;
 begin
  if aRowType = dd_rtNestedAAC then
   Result := f_PictureWidth
  else
   Result := Document.PageWidth;
  if aRow.CellCount > 1 then
   Dec(Result, GetLeftIndent);
  if aRow.CellCount > 2 then
   Dec(Result, GetRightIndent);
 end;

 function lp_CalcInnerWidth: Integer;
 var
  i      : Integer;
  l_Row  : TddTableRow;
  l_Count: Integer;
  l_Table: TddTable;
 begin
  Result := 0;
  if IsAACInnerTableRow(aRow) then
  begin
   Result := cnWidthDelta + aRow.TAP.Gaph + aRow.TAP.Left;
   l_Table := aRow.Cells[1].Items[0] as TddTable;
   l_Row := l_Table.Rows[0];
   l_Count := l_Row.CellCount - 1;
   for i := 0 to l_Count do
    Inc(Result, l_Row.Cells[i].Props.CellOffset);
   f_CellWidth := Result - lp_RecalcWidth;
  end; // if aRow.Cells[1].Items[0].IsTable then
 end;

 procedure lp_AddAlignCell;
 var
  l_Cell: TddTableCell;
 begin
  l_Cell := TddTableCell.Create(nil);
  try
   l_Cell.Props.CellOffset := f_CellWidth;
   l_Cell.Props.AlignCell := True;
   aRow.AddCell(l_Cell);
  finally
   FreeAndNil(l_Cell);
  end;
 end;

var
 l_CellWidth: Integer;
begin
 if aNeedInit then
  InitAACTableParams(aStyleID);
 if aRow.CellCount = 1 then
 begin
  l_CellWidth := lp_RecalcWidth;
  if f_CellWidth > 0 then
   if IsAACPictureRow(aRow) then
    lp_AddAlignCell
   else
    Inc(l_CellWidth, f_CellWidth);
  aRow.Cells[0].Props.CellOffset := l_CellWidth;
  Exit;
 end; // if aRow.CellCount = 1 then
 aRow.Cells[0].Props.CellOffset := GetLeftIndent;
 if aRow.CellCount > 2 then
  aRow.Cells[2].Props.CellOffset := GetRightIndent;
 l_CellWidth := lp_CalcInnerWidth;
 if l_CellWidth = 0 then
  aRow.Cells[1].Props.CellOffset := lp_RecalcWidth
 else
  aRow.Cells[1].Props.CellOffset := l_CellWidth;
 if not IsAACInnerTableRow(aRow) and (f_CellWidth > 0) then
  lp_AddAlignCell;
end;

procedure TCustomRTFObjectGenerator.InitAACTableParams(aStyleID: Integer);
var
 l_PAP   : TddParagraphProperty;
 l_CHP   : TddCharacterProperty;
 l_Style : TddStyleEntry;
begin
 l_Style := Document.StyleTable[aStyleID];
 l_PAP := TddParagraphProperty.Create;
 try
  l_CHP := TddCharacterProperty.Create;
  try
   Document.MakeStyleParent(l_Style.BasedOn, l_PAP, l_CHP); // Это только предки
   if f_AACPAP <> nil then
    FreeAndNil(f_AACPAP);
   if f_AACCHP <> nil then
    FreeAndNil(f_AACCHP); 
   f_AACPAP := l_Style.PAP.Clone;
   f_AACCHP := l_Style.CHP.Clone;
   f_AACPAP.JoinWith(l_PAP);
   f_AACCHP.JoinWith(l_CHP);
  finally
   FreeAndNil(l_CHP);
  end;
 finally
  FreeAndNil(l_PAP);
 end;
end;

function TCustomRTFObjectGenerator.GetRowHeight4AACSpace(
  aBefore: Boolean): AnsiString;
const
 csRowHeightTag = '\trrh%d';
var
 l_Height: Integer;
begin
 if aBefore then
  l_Height := f_AACPAP.Before
 else
  l_Height := f_AACPAP.After;
 Result := Format(csRowHeightTag, [l_Height]);
end;

function TCustomRTFObjectGenerator.GetCellFillColor4AAC: AnsiString;
const
 csCellFillColorTag = '\clcbpat%d';
begin
 Result := Format(csCellFillColorTag, [f_AACCHP.Highlight]);
end;

function TCustomRTFObjectGenerator.GetLeftIndent: Integer;
begin
 Result := f_AACPAP.xaLeft;
end;

function TCustomRTFObjectGenerator.GetRightIndent: Integer;
begin
 Result := f_AACPAP.xaRight;
end;

function TCustomRTFObjectGenerator.GetPicWidthStack: Tl3LongintList;
begin
 if f_PicWidths = nil then
  f_PicWidths := Tl3LongintList.Create;
 Result := f_PicWidths; 
end;

procedure TCustomRTFObjectGenerator.RememberLastPictureWidth;
begin
 GetPicWidthStack.Add(f_PictureWidth);
end;

function TCustomRTFObjectGenerator.AnalizePicture(
  const aPicture: TddPicture; var anOffset: Integer): AnsiString;
begin
 Result := '';
 case aPicture.Format of
  -1 : Exit;
  pictBMP  :
   begin
    {$IfNDef Archi}
    Result := '\pngblip ';
    Convert2Png(aPicture);
    {$Else   Archi}
    Result := Format('\dibitmap0\wbmbitspixel%d\wbmplanes1\wbmwidthbytes%d ',
               [aPicture.BPP, (aPicture.Width div 8 + 1) * 8]);
    anOffset := SizeOf(BitmapFileHeader)
    {$EndIf  Archi}
   end; // pictBMP
  pictNONE,
  pictWMF  : Result := '\emfblip ';//'\wmetafile ';
  pictPNG  : Result := '\pngblip ';
  pictJPG  : Result := '\jpegblip ';
 else // преобразование форматов, неподдерживаемых MS Word
  begin
   Result := '\pngblip ';
   Convert2Png(aPicture);
  end
 end; { aPicture.Format }
end;

procedure TCustomRTFObjectGenerator.DeinitAACProps;
begin
 FreeAndNil(f_AACPAP);
 FreeAndNil(f_AACCHP);
end;

function TCustomRTFObjectGenerator.GetWhiteIndex: Integer;
var
 i: Integer;
begin
 if f_WhiteIndex = -1 then
  for i := 0 to Document.ColorCount - 1 do
   with Document.ColorTable[i] do
    if (Red = 255) and (Blue = 255) and (Green = 255) then
    begin
     f_WhiteIndex := i + 1;
     Break;
    end; // if (Red = 255) and (Blue = 255) and (Green = 255) then
 Assert(f_WhiteIndex > 0);
 Result := f_WhiteIndex;
end;

procedure TCustomRTFObjectGenerator.Try2AddEmtpyPara;
begin
 if f_WasTable then
 begin
  OutputEOParaWithClearStyle;
  f_WasTable := False;
 end;
end;

procedure TCustomRTFObjectGenerator.Convert2Png(
  const aPicture: TddPicture);
var
 l_ImageIO: TImageEnIO;
begin
 l_ImageIO := TImageEnIO.Create(nil);
 with l_ImageIO do
 try
  LoadFromStream(aPicture.Stream);
  aPicture.Stream.Seek(0, 0);
  SaveToStreamPNG(aPicture.Stream);
 finally
  Free;
 end;
end;

end.
