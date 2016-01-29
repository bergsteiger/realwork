unit evNSRWrt;
{* Фильтр для записи текста в формате NSRC. }

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evNSRWrt - генератор текстов в формате NSRC }
{ Начат: 04.10.1999 17:55 }
{ $Id: evNSRWrt.pas,v 1.251 2015/10/22 15:03:42 lulin Exp $ }

// $Log: evNSRWrt.pas,v $
// Revision 1.251  2015/10/22 15:03:42  lulin
// - вычисляем необходимость корректировки.
//
// Revision 1.250  2015/10/22 14:47:27  lulin
// - задаём ID документа снаружи.
//
// Revision 1.249  2015/10/21 16:11:13  lulin
// {RequestLink:605383118}.
// - Добавляем фильтр шрифтов.
// - Пигем список номеров документов.
//
// Revision 1.248  2015/10/21 15:59:17  lulin
// {RequestLink:605383118}.
// - Добавляем фильтр шрифтов.
// - Пигем список номеров документов.
//
// Revision 1.247  2015/10/21 14:51:45  lulin
// {RequestLink:605383118}.
//
// Revision 1.245  2015/10/14 15:42:20  lulin
// {RequestLink:608627000}.
//
// Revision 1.244  2015/10/13 14:43:17  lulin
// {RequestLink:598136171}
//
// Revision 1.243  2015/10/13 14:22:51  lulin
// {RequestLink:598136171}
//
// Revision 1.242  2015/10/13 14:17:47  lulin
// {RequestLink:598136171}
//
// Revision 1.240  2015/10/13 13:57:59  lulin
// {RequestLink:598136171}
//
// Revision 1.239  2015/10/13 13:49:44  lulin
// - заготовочка.
//
// Revision 1.238  2015/08/19 15:05:30  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=604899511&focusedCommentId=605829699#comment-605829699
//
// Revision 1.237  2015/08/19 11:36:52  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=604899511&focusedCommentId=605829699#comment-605829699
//
// Revision 1.236  2015/08/18 14:23:41  lulin
// {RequestLink:604929313}
//
// Revision 1.235  2015/08/18 11:45:46  lulin
// - не пишем видимость.
//
// Revision 1.234  2015/08/17 15:36:46  lulin
// {RequestLink:604929290}
//
// Revision 1.233  2015/08/17 14:05:01  lulin
// - так правильнее.
//
// Revision 1.232  2015/08/17 13:11:29  lulin
// {RequestLink:604929313}.
//
// Revision 1.231  2015/08/17 11:40:55  lulin
// {RequestLink:604929313}.
//
// Revision 1.230  2015/08/17 11:35:10  lulin
// {RequestLink:604929313}.
//
// Revision 1.229  2015/08/17 11:07:31  lulin
// - дотачиваем "корректиовщик формул".
//
// Revision 1.226  2015/08/17 10:44:44  lulin
// - вырезаем начальные пробелы.
//
// Revision 1.223  2015/08/17 10:32:20  lulin
// - убираем концевые пробелы.
//
// Revision 1.220  2015/08/17 10:21:11  lulin
// - пишем оформление.
//
// Revision 1.218  2015/08/17 09:53:37  lulin
// - не фильтруем сегменты со шрифтом.
//
// Revision 1.217  2015/08/17 09:40:04  lulin
// - заготовочка.
//
// Revision 1.214  2015/08/17 09:28:32  lulin
// - заготовочка.
//
// Revision 1.212  2015/06/24 12:01:09  dinishev
// {Requestlink:601992686}
//
// Revision 1.211  2015/03/10 08:28:14  dinishev
// {Requestlink:590512137}. Bug fix: удаляли лишние пробелы.
//
// Revision 1.210  2014/12/17 17:32:27  lulin
// {RequestLink:585129079}
//
// Revision 1.209  2014/12/17 17:05:15  lulin
// {RequestLink:585129079}. Диагностика.
//
// Revision 1.208  2014/12/17 16:29:56  lulin
// {RequestLink:585129079}.
//
// Revision 1.207  2014/09/04 12:07:59  dinishev
// {Requestlink:564750095}. Использование "тестовых" ручек вышло боком.
//
// Revision 1.206  2014/09/04 11:43:50  dinishev
// {Requestlink:564750095}
//
// Revision 1.205  2014/09/01 12:09:28  dinishev
// Assert на отсутствие содержимого картинки.
//
// Revision 1.204  2014/08/29 12:24:43  lulin
// - вычищаем ненужную директиву.
//
// Revision 1.203  2014/05/20 11:53:05  dinishev
// {Requestlink:532634915}. Правлю удалением лишних сегментов.
//
// Revision 1.202  2014/04/10 11:59:50  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.201  2014/04/08 17:13:19  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.200  2014/04/07 09:33:59  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.199  2014/04/07 06:02:21  dinishev
// Bug fix: не компилировались проекты.
//
// Revision 1.198  2014/03/27 14:29:01  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.197  2014/03/03 16:07:47  lulin
// - избавляемся от странностей.
//
// Revision 1.196  2014/02/28 14:54:15  lulin
// - перетряхиваем генераторы.
//
// Revision 1.195  2014/02/25 16:44:11  lulin
// - исправляем плаввающую ошибку записи в NSRC.
//
// Revision 1.194  2014/02/25 15:26:44  lulin
// - вычищаем ненужное.
//
// Revision 1.193  2014/02/25 14:17:37  lulin
// - чистим параметры.
//
// Revision 1.192  2014/02/07 04:46:47  dinishev
// Bug fix: не компилировались исходники.
//
// Revision 1.191  2014/02/06 13:23:09  dinishev
// {Requestlink:509085881}
//
// Revision 1.190  2013/12/26 15:14:20  dinishev
// {Requestlink:511186785}. Последний вариант.
//
// Revision 1.189  2013/12/26 13:00:41  dinishev
// {Requestlink:511186785}
//
// Revision 1.188  2013/12/26 11:46:12  lulin
// {RequestLink:509706011}
//
// Revision 1.187  2013/12/25 08:42:26  dinishev
// Bug fix: при выливке только с номерами стилей оставляли "мордочки"
//
// Revision 1.186  2013/12/17 13:44:01  dinishev
// {Requestlink:508453984}
//
// Revision 1.185  2013/12/13 11:56:39  dinishev
// {Requestlink:508453984}. Директиву добавил. Начались "спецэффекты".
//
// Revision 1.184  2013/10/28 10:07:54  lulin
// - готовимся к смене типа значения по-муоолчанию.
//
// Revision 1.183  2013/10/21 15:42:58  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.182  2013/10/21 10:30:41  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.181  2013/10/18 14:11:23  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.180  2013/05/07 09:25:18  voba
// - K:453164162
//
// Revision 1.179  2013/04/09 07:59:15  dinishev
// Bug fix; устраняем последствия портирования - не проходил тест с выливкой формулы.
//
// Revision 1.178  2013/04/05 12:02:16  lulin
// - портируем.
//
// Revision 1.177  2013/02/19 08:18:53  dinishev
// {Requestlink:338461122}. Проверка создания файла с картинкой.
//
// Revision 1.176  2013/02/18 10:53:15  lulin
// - аккуратнее обращаемся с позицией потока.
//
// Revision 1.175  2013/02/14 10:49:07  narry
// Новые параметры картинки - ширина и высота
//
// Revision 1.174  2012/12/04 12:56:07  lulin
// {RequestLink:398275085}
//
// Revision 1.173  2012/12/04 10:13:22  lulin
// {RequestLink:408654725}
//
// Revision 1.172  2012/07/12 19:17:43  lulin
// {RequestLink:237994598}
//
// Revision 1.171  2012/04/20 14:56:33  lulin
// {RequestLink:283610570}
//
// Revision 1.170  2012/03/28 13:49:29  narry
// Формирование расширения для картинки без расширения
//
// Revision 1.169  2012/03/28 13:25:46  narry
// Формирование расширения для картинки
//
// Revision 1.168  2012/03/15 13:16:29  voba
// - k : 336664105
//
// Revision 1.167  2012/03/05 11:23:24  lulin
// {RequestLink:342865677}
//
// Revision 1.166  2012/02/29 09:09:44  lulin
// {RequestLink:336664105}
//
// Revision 1.165  2012/02/29 08:32:34  lulin
// {RequestLink:336664105}
//
// Revision 1.164  2012/02/29 07:26:17  lulin
// {RequestLink:336664105}.
//
// Revision 1.163  2012/02/28 16:23:48  lulin
// {RequestLink:336664105}
//
// Revision 1.162  2012/02/28 16:15:49  lulin
// {RequestLink:336664105}
//
// Revision 1.161  2012/02/28 13:09:03  lulin
// {RequestLink:336664105}
//
// Revision 1.159  2011/10/05 11:03:07  voba
// - k : 281525254 Борьба с утечками
//
// Revision 1.158  2011/08/31 13:35:59  dinishev
// [$280859299]
//
// Revision 1.157  2011/08/03 10:00:26  dinishev
// [$235058873]
//
// Revision 1.156  2011/07/29 10:42:44  dinishev
// [$276535467]
//
// Revision 1.155  2011/05/27 13:30:46  dinishev
// [$267324701]. Вытираем мусор из текста формулы.
//
// Revision 1.154  2010/11/30 11:47:02  lulin
// {RequestLink:228688602}.
// - борьба с предупреждениями.
//
// Revision 1.153  2010/09/21 10:37:16  lulin
// {RequestLink:235054083}.
//
// Revision 1.152  2010/08/11 09:05:17  dinishev
// [$182452385]. Вернул, т.к. в Немезисе и в модели разъехалось - недоглядел. :-(
//
// Revision 1.16  2010/08/11 06:48:44  dinishev
// [$182452385]
//
// Revision 1.150  2010/06/18 14:14:46  lulin
// {RequestLink:182452717}.
// - меняем способ нумерования версий. Теперь версии нумеруем с шагом 20. 0-е - это Архивариус, 1-е - это F1.
//
// Revision 1.149  2010/05/20 05:15:44  narry
// - K214073721
//
// Revision 1.148  2010/05/13 09:47:50  dinishev
// Cleanup
//
// Revision 1.147  2010/05/12 15:08:41  dinishev
// [$210438308]
//
// Revision 1.146  2010/05/12 11:41:32  narry
// - заточки под конвертер
//
// Revision 1.145  2010/05/06 12:39:40  lulin
// {RequestLink:210043510}.
//
// Revision 1.144  2010/05/05 14:22:44  lulin
// {RequestLink:209584396}.
//
// Revision 1.143  2010/05/05 14:08:07  lulin
// {RequestLink:209584396}.
// - тест подточен под архивариус.
//
// Revision 1.142  2010/05/05 13:48:19  lulin
// {RequestLink:209584396}.
// - добавлен тест.
//
// Revision 1.141  2010/04/29 10:02:49  lulin
// {RequestLink:207389888}.
//                                                          
// Revision 1.140  2010/04/28 14:08:19  lulin
// {RequestLink:207388924}.
//
// Revision 1.139  2010/04/20 12:48:30  lulin
// {RequestLink:180060974}.
// - bug fix: в "Немезисе" NSRC писался не так как в Архивариусе.
//
// Revision 1.137  2010/04/02 13:35:22  lulin
// {RequestLink:200901262}.
//
// Revision 1.136  2010/04/02 09:55:04  fireton
// - удаляем пробелы в формулах при выливке NSRC
//
// Revision 1.135  2010/04/01 13:53:16  lulin
// - комментарий.
//
// Revision 1.134  2010/04/01 13:40:34  lulin
// - комментарий.
//
// Revision 1.133  2010/04/01 13:39:04  lulin
// - ссылка на обсуждение.
//
// Revision 1.132  2010/03/26 13:02:07  lulin
// {RequestLink:199590833}.
// - записываем размер кегля для печати.
//
// Revision 1.131  2010/03/26 11:24:10  lulin
// {RequestLink:199590833}.
// - добавляем тест записи размеря кегля для печати.
//
// Revision 1.130  2010/01/22 19:10:28  lulin
// - в тестах тоже корректно пишем адреса гиперссылок.
//
// Revision 1.129  2010/01/22 18:55:34  lulin
// - упорядочиваем код.
// - пишем тест на проверку того, что стиль при заливке из NSRC меняется.
//
// Revision 1.128  2010/01/22 17:39:37  lulin
// - делаем тест для "бубны".
//
// Revision 1.127  2009/09/11 08:28:57  voba
// - Header формируется один раз. (Экономим память)
//
// Revision 1.126  2009/07/07 09:27:40  lulin
// - правим форматирование.
//
// Revision 1.125  2009/07/03 16:24:02  lulin
// - шаг к переходу от интерфейсов к объектам.
//
// Revision 1.124  2009/05/15 14:17:55  dinishev
// [$147490351]
//
// Revision 1.123  2009/03/04 14:17:42  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.122  2009/01/13 17:00:39  lulin
// - bug fix: не пишем кодировку, если она совпадает с целевой.
//
// Revision 1.121  2009/01/13 16:21:00  narry
// - татары
//
// Revision 1.120  2008/12/23 10:10:24  dinishev
// Bug fix: тормоза при выливке из-за неициализированной переменной.
//
// Revision 1.119  2008/12/18 14:42:47  lulin
// - <K>: 132222370.
//
// Revision 1.118  2008/12/18 13:58:30  lulin
// - <K>: 132222370. Локализуем место выставления целевой кодировки.
//
// Revision 1.117  2008/12/12 19:26:07  lulin
// - <K>: 129762414.
//
// Revision 1.116  2008/09/23 12:17:56  fireton
// - импорт/экспорт номера судебного дела
//
// Revision 1.115  2008/09/10 11:35:55  dinishev
// Bug fix: при анализе забывали об реальном окончании гиперссыкли
//
// Revision 1.114  2008/09/09 08:22:48  dinishev
// Bug fix: не сбрасывали найденные позиции при поиске пробелов
//
// Revision 1.113  2008/08/28 07:02:06  dinishev
// Bug fix: проверяем наличие пробелов перед гиперссылкой
//
// Revision 1.112  2008/06/20 14:48:50  lulin
// - используем префиксы элементов.
//
// Revision 1.111  2008/05/26 15:27:11  lulin
// - <K>: 91850556.
//
// Revision 1.110  2008/05/26 12:03:42  lulin
// - поправлена информация о версии генератора.
//
// Revision 1.109  2008/05/26 08:19:58  lulin
// - работы по <K>: 91848978.
//
// Revision 1.108  2008/05/21 17:05:14  lulin
// - <K>: 90441490.
//
// Revision 1.107  2008/03/03 20:05:45  lulin
// - <K>: 85721135.
//
// Revision 1.106  2007/12/04 13:04:55  lulin
// - объединяем два каталога с исходниками Эвереста.
//
// Revision 1.14  2007/11/22 07:36:10  voba
// - enh. фильтруем _k2_idBookmark
//
// Revision 1.13  2007/10/18 13:08:01  voba
// - откат пред. изменений. Поправили в другом месте
//
// Revision 1.12  2007/10/17 07:21:06  voba
// - bug fix от Шуры
//
// Revision 1.11  2007/10/09 14:17:27  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.10  2007/09/21 12:58:16  lulin
// - сделана выливка формул в NSRC.
//
// Revision 1.9  2007/09/14 13:26:02  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.8.4.1  2007/09/12 19:13:17  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.8  2007/08/29 12:37:06  lulin
// - файл версий переехал в правильную папку.
//
// Revision 1.7  2007/08/29 12:22:43  lulin
// - cleanup.
//
// Revision 1.6  2007/08/14 19:31:27  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.5  2007/08/09 18:18:40  lulin
// - избавляемся от излишнего использования интерфейсов, т.к. переносимость может быть достигнута другими методами.
//
// Revision 1.4  2007/08/09 11:19:10  lulin
// - cleanup.
//
// Revision 1.3  2007/07/19 06:18:11  oman
// - fix: выпрямляем зависимости. Схема документа, теперь не зависит от Эвереста.
// (Не собиралась библиотека)
//
// Revision 1.2  2006/10/12 15:17:37  lulin
// - переехали в общую папку.
//
// Revision 1.1.2.1  2006/10/12 15:15:01  lulin
// - переехали в общую папку.
//
// Revision 1.104  2006/09/21 12:28:42  dinishev
// new class: TevNSRCStringFormatter - для формирования строк с гиперссылками
//
// Revision 1.103  2005/07/21 11:15:04  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.102  2005/06/14 08:31:35  narry
// - update: вывод короткого имени документа
//
// Revision 1.101  2005/05/20 15:15:29  lulin
// - new unit: evStyleInterface.
//
// Revision 1.100  2005/03/29 08:34:47  lulin
// - bug fix: не компилировалось.
//
// Revision 1.99  2005/03/28 11:32:07  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.98  2005/03/24 16:12:49  lulin
// - при валидации строки не отрезались конечные пробелы.
//
// Revision 1.97  2005/03/21 10:04:49  lulin
// - new interface: _Ik2Type.
//
// Revision 1.96  2005/03/19 16:39:51  lulin
// - спрятаны ненужные методы.
//
// Revision 1.95  2005/03/17 16:37:55  lulin
// - bug fix: выливка в NSRC теперь учитывает возможность наличия вложенных документов.
//
// Revision 1.94  2005/03/16 16:30:09  lulin
// - new style: "нормальный для аннотаций".
//
// Revision 1.93  2005/03/04 11:10:03  lulin
// - bug fix: TevCustomNSRCWriter в отсутствии форматтера перед ним не контроллировал кодировку текста.
//
// Revision 1.92  2004/11/22 13:23:13  lulin
// - bug fix: неправильно выливалась команда !Division для параметров, по-умолчанию.
//
// Revision 1.91  2004/09/21 12:55:41  lulin
// - Release заменил на Cleanup.
//
// Revision 1.90  2004/07/21 06:49:14  law
// - добавлены стили для колонтитулов.
//
// Revision 1.89  2004/06/04 10:42:17  law
// - new behavior: если у строки таблицы все символы не вступили силу, то вся строка выливается как не вступившая в силу.
//
// Revision 1.88  2004/06/02 14:45:48  law
// - rename method: Tk2BaseStackGenerator.Atom2String -> VariantAsString.
// - сделан фильтр для сбора информации о документах со строками в кодировке _1252.
//
// Revision 1.87  2004/05/18 13:34:55  law
// - new behavior: берем "букву" от стиля, если не указано какое-то специальное "хакерство".
//
// Revision 1.86  2004/05/14 15:16:53  law
// - remove unit: evTypesE.
//
// Revision 1.85  2004/05/14 14:08:49  law
// - change: TevVariant переименован в Tk2Variant и переехал в k2Types.
//
// Revision 1.84  2004/04/02 09:28:48  law
// - bug fix: после таблицы и команды !Division не выливалась команда !Style.
//
// Revision 1.83  2004/04/01 15:32:42  law
// - bug fix: перед командой !Division не выливалась команда !Style.
//
// Revision 1.82  2004/03/26 16:22:27  law
// - new behavior: выливаем команду !DIVISION.
//
// Revision 1.81  2004/01/21 08:50:59  narry
// - update: реализация задачи OIT500005900
//
// Revision 1.80  2004/01/09 10:39:53  law
// - bug fix: в NSRC неправильно выливались продолжения ссылок, автоматически получаемые из ссылок.
//
// Revision 1.79  2003/12/25 17:19:12  law
// - bug fix: при записи в NSRC выливаем все ссылки, и без Handle тоже.
//
// Revision 1.78  2003/12/08 13:33:46  law
// - new behavior: выливаем стиль ev_saNotApplied.
//
// Revision 1.77  2003/07/31 13:33:35  law
// - bug fix: на стыке блоков пропадала команда !STYLE.
//
// Revision 1.76  2003/06/26 12:55:01  law
// - new bahavior: в режиме SkipPreformated пропускаем SBS-параграфы.
//
// Revision 1.75  2003/06/25 11:53:30  law
// - new prop: TevCustomNSRCWriter.SkipPreformatted.
//
// Revision 1.74  2003/06/10 15:16:03  law
// - new behavior: для автоклассификации убрана выливка технических комментариев и комментариев в заголовке файла.
//
// Revision 1.73  2003/06/10 15:03:08  law
// - new behavior: для автоклассификации убрана выливка команды !Style.
//
// Revision 1.72  2003/04/11 08:24:42  voba
// -new behavior :Теперь  тиль "информация о версии" выливается с трефами и червами
//
// Revision 1.71  2003/01/15 13:53:40  law
// - new style: ev_saVersionInfo - "Информация о версии".
//
// Revision 1.70  2002/12/24 13:02:01  law
// - change: объединил Int64_Seek c основной веткой.
//
// Revision 1.69.2.1  2002/12/23 15:51:26  law
// - bug fix: не работали с хранилищем > 2Гб.
//
// Revision 1.69  2002/11/22 12:38:11  law
// - bug fix: неправильно обрабатывались незакрытые сегменты, утратившие силу.
//
// Revision 1.68  2002/11/21 14:19:55  law
// - new behavior: если у строки таблицы все символы утратили силу, то вся строка выливается как утратившая силу (см. _TestSet\Table\6.evd ).
//
// Revision 1.67  2002/11/15 13:04:26  law
// - new test file: _TestSet\Segments\Hyperlinks\7.evd.
//
// Revision 1.66  2002/11/15 13:02:13  law
// - new behavior: теперь в NSRC выливаются невидимые сегменты (см. _TestSet\Segments\Hyperlinks\7.evd).
//
// Revision 1.65  2002/10/31 13:35:58  law
// - bug fix: неправильно выливались сегменты и ссылки - было пересечение (см. _TestSet\Segments\Hyperlinks\5.evd).
//
// Revision 1.64  2002/10/24 14:13:49  law
// - bug fix: пересечение ссылки и других сегментов.
//
// Revision 1.63  2002/10/23 12:56:53  law
// - cleanup.
//
// Revision 1.62  2002/09/24 15:09:39  law
// - rename unit: evTxtExp -> evTextFormatter.
//
// Revision 1.61  2002/09/19 13:41:34  law
// - cleanup and comments.
//
// Revision 1.60  2002/09/19 12:52:38  law
// - cleanup.
//
// Revision 1.59  2002/09/18 14:31:36  law
// - change: начата работа по поддержке нотификации об изменении стилей.
// - new unit: evStyleTableTools.
//
// Revision 1.58  2002/09/18 07:08:02  law
// - new units: k2StackGenerator, _k2Ver.
// - new behavior: Tk2CustomReader теперь наследуется от Tk2CustomStackGenerator и соответственно наследует его поведение.
//
// Revision 1.57  2002/09/18 06:03:32  law
// - cleanup: удален параметр IsDefault.
//
// Revision 1.56  2002/07/09 12:02:20  law
// - rename unit: evUnits -> l3Units.
//
// Revision 1.55  2002/06/21 12:23:04  law
// - bug fix: после технического комментария не выливалась смена стиля.
//
// Revision 1.54  2002/05/30 15:21:54  law
// - cleanup: удален стиль ev_saWideTable.
//
// Revision 1.53  2002/05/29 12:07:13  law
// - new behavior: учитываем ev_saWideTable при выливке в NSRC.
//
// Revision 1.52  2002/05/22 16:19:58  law
// - bug fix: иногда неправильно выливались длинные технические комментарии.
//
// Revision 1.51  2002/04/11 06:45:47  law
// - new behavior: комментарий теперь не приводит к команде !Style.
//
// Revision 1.50  2002/01/03 14:19:02  law
// - some cosmetics.
//
// Revision 1.49  2001/10/29 14:14:19  law
// - new style: "Технический комментарий".
//
// Revision 1.48  2001/08/31 09:04:36  law
// - cleanup.
//
// Revision 1.47  2001/07/24 12:30:24  law
// - comments: xHelpGen.
//
// Revision 1.46  2001/07/17 14:59:02  law
// - bug fix: в соответствии с задачей №722.
//
// Revision 1.45  2001/05/28 12:26:45  law
// - bug fix: неправильно выливались рамки у сложных таблиц с объединенными ячейками (_TestSet\ComplexTable\4.evd).
//
// Revision 1.44  2001/05/07 06:56:55  law
// - bug fix: доделана выливка таблиц с учетом невидимых символов.
//
// Revision 1.43  2001/05/04 11:30:06  narry
// - new const: ev_NSRCInvisible.
//
// Revision 1.42  2001/05/04 11:03:37  law
// - new version: изменился номер версии генератора, учитывающего спецсимволы.
//
// Revision 1.41  2001/05/04 11:02:12  law
// - new behavior: сделан учет спецсимволов при выливке таблиц в NSRC и txt.
//
// Revision 1.40  2001/05/03 10:20:39  law
// - cleanup: убраны свойство и параметр CheckEmptyFrame.
//
// Revision 1.39  2001/04/23 11:44:54  law
// - new behavior: сегменты, стиль которых совпадает со стилем параграфа, теперь не выливаются в NSRC.
//
// Revision 1.38  2001/04/20 15:22:36  law
// - bug fix: поправлена выливка некоторых таблиц со сложными рамками.
//
// Revision 1.37  2001/04/20 12:22:38  law
// - new version: версия 0.27.
//
// Revision 1.36  2001/04/20 12:21:45  law
// - bug fix: сделан учет рамок головной ячейки, для ячеек объединеных по вертикали.
//
// Revision 1.35  2001/03/21 16:59:43  law
// - bug fix: неправильно выливались таблицы, когда не удавалось разогнать строку по ширине (не было пробелов).
//
// Revision 1.34  2001/03/14 13:24:55  law
// - some cleaup and tuning.
//
// Revision 1.33  2001/02/23 13:44:26  law
// - к текстовому параграфу добавлено свойство AllowHyphen.
//
// Revision 1.32  2001/02/22 09:29:36  law
// - добавлена обработка табличных стилей.
//
// Revision 1.31  2001/02/20 13:28:09  law
// - немного переделал алгоритм нарезки слов по слогам.
//
// Revision 1.30  2001/02/20 10:23:51  law
// - some tuning
//
// Revision 1.29  2001/02/19 13:34:03  law
// - bug fix: поправлена очередная ошибка зависания при сохранении в текст и NSCR.
//
// Revision 1.28  2001/02/02 14:46:47  law
// - версия 0.22 - поправлена выливка ячеек, объединенных по вертикали.
//
// Revision 1.27  2001/01/26 14:24:45  law
// - версия 0.21. bug fix: экспорт сегментов для которых Start > Finish.
//
// Revision 1.26  2000/12/27 13:00:02  law
// - bug fix: выливка отступа для таблицы, следующей сразу же за предыдущей.
//
// Revision 1.25  2000/12/27 09:05:45  law
// - bug fix: выливка тега k2_tiVisible для комментариев и гипертекстовых ссылок в NSRC.
//
// Revision 1.24  2000/12/20 18:19:20  law
// - bug fix: перед комментарием не выводился заголовок.
//
// Revision 1.23  2000/12/20 18:05:32  law
// - изменил версию на 0.18 - для отсечения файлов с ошибкой для SoftEnter'ов.
//
// Revision 1.22  2000/12/19 15:52:40  law
// - убраны ненужные директивы компиляции.
//
// Revision 1.21  2000/12/18 17:30:10  law
// - версия изменена на 0.17 - для отсечения возможных ошибок при переносах по слогам.
//
// Revision 1.20  2000/12/18 14:59:41  law
// - версия изменена на 0.16 - для отсечения возможных ошибок.
//
// Revision 1.19  2000/12/15 15:30:58  law
// - сделана выливка отступов не меньше 0.
//
// Revision 1.18  2000/12/15 15:10:36  law
// - вставлены директивы Log.
//

{$Include evDefine.inc }

{$IfDef evdNeedNSRCWriter}
{$IfDef evExternalProduct}
 !!! Данный модуль не может использоваться в сторонних продуктах !!!
{$EndIf evExternalProduct}
{$EndIf evdNeedNSRCWriter}

interface

{$IfDef evdNeedNSRCWriter}
uses
  l3Chars,
  l3Types,
  l3IID,
  l3InternalInterfaces,
  l3Base,
  l3Filer,
  l3Units,

  k2Types,
  k2Interfaces,
  k2TagGen,

  evdTypes,

  evTypes,
  evNSRCConst,
  evInternalInterfaces,
  evTextFormatter,
  evStyleInterface,
  evNSRCWriterTypes,
  evGeneratorsInterfaces
  ;

const
  evAllLineBrackets : array [0..1] of AnsiChar = (ev_NSRCOutOfDate, ev_NSRCNotApplied);
type
  TevNSRCDivision = record
   Heavy       : Boolean;
   Orientation : TevPageOrientation;
   Extent      : Tl3Point;
  end;//TevNSRCDivision

  TevCustomNSRCWriter = class(TevCustomTextPainter, Il3ObjectWrap)
   {* Фильтр для записи текста в формате NSRC. }
    public
     SilentErrors : Boolean;
     NeedOutDecorInfo : Boolean;
    private
    {internal fields}
      f_PrevParaStyle        : TevNSRCParaStyle;
      f_SubCount             : Long;
      f_StringFiler          : Tl3CustomFiler;
      f_String               : Tl3String;
      f_StyleInterface       : TevStyleInterface;
      f_WasShortname         : Bool;
      f_AddBlocks            : Bool;
      f_BeforeCommentLetter  : AnsiChar;
      f_CodePage             : Long;
      f_OutStyle             : Bool;
      f_PlainText            : Bool;
      f_SkipPreformatted     : Bool;
      f_Division             : TevNSRCDivision;
      fHeaderString          : AnsiString;
      f_CheckChar            : AnsiChar; // Символ для проверки в ValidateLine
      f_ExternalDocHandle    : Integer;
    protected
     f_Handle                : Long;                {  }
     f_CurParaParas          : TevNSRCParaParas;
    public 
     InternalHandle        : Long;                {  }
     NeedCorrect : Boolean;
    private
    //event fields
      f_OnOutSub       : Tl3OutExtLongEvent;
      f_OnOutBlock     : Tl3OutExtLongEvent;
      f_OnOutHyperlink : Tl3OutExtLongEvent;
      f_OnOutShortname : TevOutExtStringEvent;
    {$IFDEF evUseEvdStyleOnly}
    private
      function NeedEmptyPara: Boolean;
       {* - Проверяет нужно ли пустому параграфу присваивать стиль. }
      function IsTechComment(aPrevStyle: Boolean): Boolean;
       {-}
    {$ENDIF evUseEvdStyleOnly}  
    protected
    {property methods}
      function  pm_GetStringFiler: Tl3CustomFiler;
        {-}
    protected
    {internal methods}
      procedure SaveObjFileName(const aFileName: AnsiString); virtual;
      procedure SetExternalDocHandle(anID: Integer);
      procedure CheckDigitalSeparatorAlignment; virtual;
        {-}
      procedure CheckNeed2AddBlock; virtual;
        {-}
      function  GetObject: TObject;
        {* - получить объект из обертки. }
      procedure OutText(S: Tl3CustomString);
        override;
        {-}
      procedure OutTextStyle(anEmpty   : Boolean;
                             aCodePage : Integer;
                             out anInsertSemeColon: Boolean);
      procedure AnalizeStyle(StHandle: Long);
        {-}
      procedure OutSub(SubHandle: Long);
        {-}
      function NeedOutSub: Boolean;
       virtual;
        {-}
      procedure OutStyle4Cell;
       virtual;
        {-}
      procedure OutSubInt(SubHandle: Long);
       {-}
      procedure OpenBlock(BlockHandle: Long);
        {-}
      procedure CloseBlock;
        {-}
      procedure DoOutSub(SubHandle: Long);
        virtual;
        {* - процедура записи Sub'а. Может быть перекрыта в потомках. }
      procedure DoOutBlock(BlockHandle: Long);
        virtual;
        {* - процедура записи блока. Может быть перекрыта в потомках. }
      procedure DoOutShortName(Name: Tl3CustomString);
        virtual;
        {* - процедура записи короткого названия документа. Может быть перекрыта в потомках. }
      procedure OutShortName(Name: Tl3CustomString);
        {-}
      procedure _Msg2Log(Msg: AnsiString);
        virtual;
      procedure DoOutHyperlinkEx(Ob: Tl3Variant; var S: AnsiString);
        virtual;
        {* - процедура записи гиперссылки. Может быть перекрыта в потомках. }
      procedure DoOutHyperlink(Ob: Tl3Variant; var S: AnsiString);
        virtual;
        {* - процедура записи гиперссылки. Проверяет наличие Handle и вызывает DoOutHyperlinkEx. Может быть перекрыта в потомках. }
      function  IsMarkStyle(aParaVisible        : Bool;
                            aParaStyle          : Long;
                            aStyledObject : Tl3Variant;
                            aText: Tl3String;
                            out Open, Close     : AnsiString;
                            var DeleteText      : Boolean): Bool;
        override;
        {-}
      function IsStyleEqual(aParaStyle: Integer; aSegmentStyle: Integer): Boolean;
        override;
        {-}
      procedure ValidateLine(aLine : Tl3String; aCodePage : Integer);
        override;
        {* - процедура для проверки корректности строки. }
      function GetHeader : AnsiString;
        {* - Генерит строку - заголовок. }
      procedure OutHeader;
        {* - записывает шапку NSRC файла. }
      procedure Cleanup;
        override;
        {-}
      procedure CloseStream(NeedUndo: Bool);
        override;
        {-вызывается один раз в конце генерации}
      procedure CloseStructure(NeedUndo: Bool);
        override;
        {-вызывается на закрывающуюся скобку}
      procedure ClearPrevPara;
        {-}
      procedure ClearCurParaParam;
        {-}
      procedure ClearCurPara;
        {-}
      procedure ClearBothParas;
        {-}
      procedure OutPageBreak;
      procedure SetOutCodePage(aString: Tl3CustomString; aCodePage: Integer);
        {-}
     procedure ValidateText(aText: Tl3String; aValidateText: Tl3String = nil);
      override;
       {-}
    protected
    {properted properties}
      property StringFiler: Tl3CustomFiler
        read pm_GetStringFiler;
        {* - временный поток для записи параметров разлицных тегов. }
    public
    {public methods}
        {-}
      constructor Create(AOwner: Tk2TagGeneratorOwner = nil);
        override;
        {-}
      procedure StartChild(TypeID: Tl3Type);
        override;
        {-}
      procedure StartTag(TagID: Long);
        override;
        {-}
      procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
        override;
      procedure ClearPP;
      procedure ClearPPBetweenDoc;
        {-}
      function COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
        override;
        {-}
    public
    {public properties}
      property AddBlocks: Bool
        read f_AddBlocks
        write f_AddBlocks
        default false;
        {* - записывть блоки? }
      property CodePage: Long
        read f_CodePage
        write f_CodePage
        default CP_OEM;
        {* - кодировка в которой записывать строки. }
      property OutStyle: Bool
        read f_OutStyle
        write f_OutStyle
        default true;
        {-}
      property PlainText: Bool
        read f_PlainText
        write f_PlainText
        default false;
        {-}
      property SkipPreformatted: Bool
        read f_SkipPreformatted
        write f_SkipPreformatted
        default false;
        {-}
    public
    {public events}
      property OnOutSub: Tl3OutExtLongEvent
        read f_OnOutSub
        write f_OnOutSub;
        {* - событие для записи Sub'а. }
      property OnOutBlock: Tl3OutExtLongEvent
        read f_OnOutBlock
        write f_OnOutBlock;
        {* - событие для записи блока. }
      property OnOutHyperlink: Tl3OutExtLongEvent
        read f_OnOutHyperlink
        write f_OnOutHyperlink;
        {* - событие для записи гиперссылки. }
      property OnOutShortname: TevOutExtStringEvent
        read f_OnOutShortname
        write f_OnOutShortname;
        {* - событие для записи короткого названия документа. }
  end;{TevCustomNSRCWriter}
  {* Фильтр для записи текста в формате NSRC. Предполагает перед собой наличие фильтра TevCustomTextFormatter. }

  TevNSRCGenerator = class(TevCustomNSRCWriter)
   {*! Фильтр для записи текста в формате NSRC. Для конечного использования. }
    published
    {published properties}
      property Filer;
        {-}
      property AddBlocks;
        {-}
      property CodePage;
        {-}
    published
    {published events}
      property OnOutSub;
        {-}
      property OnOutBlock;
        {-}
      property OnOutHyperlink;
        {-}
      property OnOutShortname;
        {-}
  end;{TevNSRCGenerator}

  TevNSRCWriter = class(TevNSRCGenerator);
  
const
                                 {'0.11';}
                                 {'04/10/1999'; {-TevCustomNSRCGenerator перенесен в этот
                                                  модуль из evTxtExp и переименован в
                                                  TevCustomNSRCWriter}
                                 {'23/12/1999'; {-добавлена выливка текущей даты
                                                  в шапке файла}
                                 {'27/01/2000'; {-добавлена выливка ev_saArticleHeader}
                                 {'25/02/2000'; {-добавлена выливка k2_tiComment}
                                 {'0.13' '08/06/2000'; {-Pixel2Char(evCm2Pixel(def_cmParaWidth)) -> 73}
  {'0.14' '26/07/2000'; {-добавлена выливка ev_saToLeft}
  evNSRCGeneratorCurVersion    =  '0.34';
   {* - текущая версия NSRC генератора. }
  evNSRCGeneratorRevisionDate  =  '26/05/2008';
   {* - дата текущей ревизии NSRC генератора. }
{$EndIf evdNeedNSRCWriter}

implementation

{$IfDef evdNeedNSRCWriter}
uses
  Classes,
  SysUtils,

  l3Variant,
  l3Except,
  l3MinMax,
  l3Const,
  l3String,
  l3Memory,
  l3Interfaces,
  l3BaseStream,
  l3Stream,
  l3FileUtils,
  
  k2Tags,
  k2Base,

  evdVer,
  evdConst,
  
  evDef,
  evdStyles,

  evSectionPara,
  
  evNSRCCharSkipper,
  evNSRStringFormatter,

  Para_Const,
  Document_Const,
  Block_Const,
  TextPara_Const,
  DecorTextPara_Const,
  PageBreak_Const,
  SectionBreak_Const,
  PageProperties_Const,
  Hyperlink_Const,
  Segment_Const,
  ObjectSegment_Const,
  Formula_Const,
  Bookmark_Const,
  Sub_Const,
  DocumentSub_Const,
  BitmapPara_Const,
  ddConst,
  imageenio,
  evdNativeWriter,
  k2BaseTypes,
  evdTxtConst,

  l3StringEx,

  vtDebug
  ;

// start class TevCustomNSRCWriter

const
 PreformattedLetter = 'P';
 SBSLetter          = 'S';
 TechCommentLetter  = cc_SemiColon;
 VersionInfoLetter  = 'V';
 NilLetter          = cc_Null;
 NewSchoolStyleLetter = '#';

procedure TevCustomNSRCWriter.Cleanup;
  {override;}
  {-}
begin
 l3Free(f_StyleInterface);
 inherited;
end;

function TevCustomNSRCWriter.GetHeader : AnsiString;
var
 lTitle : Tl3String;
begin
 if Length(fHeaderString) = 0 then
 begin
  lTitle := Tl3String.Create;
   try
    lTitle.AsString := l3System.AppTitle;
    SetOutCodePage(lTitle, CodePage);
    Assert(evFormatCurVersionS <> '');
    fHeaderString := ';%Producer ' + cc_SingleQuote + lTitle.AsString + cc_SingleQuote + cc_EOL +
                     ';%NSRC generator version ' + evNSRCGeneratorCurVersion + ' revision date ' +
                      evNSRCGeneratorRevisionDate + cc_EOL +
                     ';%Everest format version ' + evFormatCurVersionS + cc_EOL +
                     ';%Generation date ' + DateToStr(Date);
   finally
    l3Free(lTitle);
   end;{try..finally}
 end;
 Result := fHeaderString;
end;

procedure TevCustomNSRCWriter.OutHeader;
  {-}
var
 Title : Tl3String;
begin
 if (Filer.Pos = 0) then
 begin
  OutEOL;
  if not PlainText then
   OutString(GetHeader);
 end;
end;

constructor TevCustomNSRCWriter.Create(AOwner: Tk2TagGeneratorOwner = nil);
  {override;}
  {-}
begin
 inherited;
 CodePage := CP_OEM;
 OutStyle := true;
 SilentErrors := false;
 NeedOutDecorInfo := false;
end;

procedure TevCustomNSRCWriter.StartChild(TypeID: Tl3Type);
  {override;}
  {-}
var
 CT : Tk2TypePrim;
begin
 inherited;
 CT := CurrentType;
 if CT.IsKindOf(k2_typPara) then
 begin
  if CT.IsKindOf(k2_typDocument) then
  begin
   if (TopType[1] = nil) then
    // - учитываем вложенные документы
    f_WasShortname := false;
   f_BeforeCommentLetter := NilLetter;
   ClearBothParas;
  end//CT.IsKindOf(k2_typDocument)
  else
  if CT.IsKindOf(k2_typBlock) then
  begin
   OutShortname(nil);
   ClearBothParas;
  end//CT.IsKindOf(k2_typBlock)
  else
  if CT.IsKindOf(k2_typTextPara) then
  begin
   OutShortname(nil);
   f_BeforeCommentLetter := f_PrevParaStyle.Letter;
   f_PrevParaStyle := f_CurParaParas.Style;
   ClearCurPara;
   { TODO -oЖучков А. -cРазвитие : Проверить правильность! }
   f_CurParaParas.Style.IsDecorPara := CT.IsKindOf(k2_typDecorTextPara);
  end//CT.IsKindOf(k2_typTextPara)
  else
  if CT.IsKindOf(k2_typPageBreak) then
  begin
   OutShortname(nil);
   with f_Division do
   begin
    Heavy := CT.IsKindOf(k2_typSectionBreak);
    if Heavy then
    begin
     with Tk2TypePrim(CT.Prop[k2_tiParas].AtomType) do
     begin
      Orientation := TevPageOrientation(Tk2Prop(Prop[k2_tiOrientation]).DefaultValue);
      Extent.X := Tk2Prop(Prop[k2_tiWidth]).DefaultValue;
      Extent.Y := Tk2Prop(Prop[k2_tiHeight]).DefaultValue;
     end;//with CT.Prop[k2_tiParas]
    end;//Heavy
   end;//with f_Division
   ClearBothParas;
  end;//..k2_idPageBreak..
 end;//..k2_idPara..
end;

procedure TevCustomNSRCWriter.StartTag(TagID: Long);
  //override;
  {-}
var
 CT : Tk2TypePrim;
begin
 inherited;
 CT := CurrentType;
 if CT.IsKindOf(k2_typPageProperties) then
 begin
  with f_Division do
  begin
   with CT do
   begin
    Orientation := TevPageOrientation(Tk2Prop(Prop[k2_tiOrientation]).DefaultValue);
    Extent.X := Tk2Prop(Prop[k2_tiWidth]).DefaultValue;
    Extent.Y := Tk2Prop(Prop[k2_tiHeight]).DefaultValue;
   end;//with CT
  end;//with f_Division
 end;//..k2_idPageProperties..
end;

procedure TevCustomNSRCWriter.CloseStream(NeedUndo: Bool);
  {override;}
  {-вызывается один раз в конце генерации}
begin
 l3Free(f_String);
 l3Free(f_StringFiler);
 inherited;
end;

procedure TevCustomNSRCWriter.CloseStructure(NeedUndo: Bool);
  {override;}
  {-вызывается на закрывающуюся скобку}
var
 CT : Tk2TypePrim;  
begin
 CT := CurrentType;
 if CT.IsKindOf(k2_typPara) then
 begin
  if CT.IsKindOf(k2_typDocument) then
  begin
   if (TopType[1] = nil) then
   begin
    // - учитываем вложенные документы
    OutShortname(nil);
    f_ExternalDocHandle := 0;
    ClearPPBetweenDoc;
   end;//TopType[1] = nil
  end//k2_idDocument
  else
  if CT.IsKindOf(k2_typBlock) then
  begin
   ClearBothParas;
   CloseBlock;
  end//..k2_idBlock..
  else
  if CT.IsKindOf(k2_typTextPara) then
   ClearCurParaParam
   {..k2_idTextPara..}
  else
  if CT.IsKindOf(k2_typPageBreak) then
  begin
   OutPageBreak;
  end;//..k2_idPageBreak..
 end;{k2_idPara..}
 inherited;
end;

procedure TevCustomNSRCWriter.ClearPrevPara;
  {-}
begin
 f_PrevParaStyle.Clear;
end;

procedure TevCustomNSRCWriter.ClearCurParaParam;
  {-}
begin
 f_CurParaParas.Clear;
 f_SubCount := 0;
end;

procedure TevCustomNSRCWriter.ClearCurPara;
  {-}
begin
 f_CurParaParas.Style.Clear;
 ClearCurParaParam;
end;

procedure TevCustomNSRCWriter.ClearBothParas;
  {-}
begin
 ClearPrevPara;
 ClearCurPara;
end;

procedure TevCustomNSRCWriter.OutPageBreak;
  {-}
var
 l_PaperSizeName : AnsiString;
begin
 OutEOL;
 OutString('!DIVISION');
 with f_Division do
 begin
  if Heavy then
  begin
   case Orientation of
    ev_poPortrait:
     OutString(' P');
    ev_poLandscape:
     OutString(' L');
    else
     Assert(false); 
   end;//Case rOrientation
   l_PaperSizeName := evGetPaperSizeName(Extent);
   if (l_PaperSizeName = 'Custom') then
    l_PaperSizeName := 'A4';
   OutString(' ');
   OutString(l_PaperSizeName);
  end;//Heavy
 end;//with f_Division
end;
  
function  TevCustomNSRCWriter.pm_GetStringFiler: Tl3CustomFiler;
  {-}
var
 l_Stream : Tl3StringStream;
begin
 if (f_StringFiler = nil) then
 begin
  f_String := Tl3String.Create;
  l_Stream := Tl3StringStream.Create(f_String);
  try
   f_StringFiler := Tl3CustomFiler.Create{$IfDef k2GeneratorIsComponent}(Self){$EndIf};
   f_StringFiler.Stream := l_Stream;
  finally
   FreeAndNil(l_Stream);
  end;//try..finally
 end;//f_StringFiler = nil
 Result := f_StringFiler;
end;

procedure TevCustomNSRCWriter.OutText(S: Tl3CustomString);
  {override;}
  {-}
var
 {$IFDEF evUseEvdStyleOnly}
 l_CodePage      : Integer;
 l_EmptyText     : Boolean;
 l_InsertSemiCol : Boolean;
 {$ELSE}
 l_Suffix        : AnsiString;
 l_OutStyle      : Bool;
 l_CodePage      : AnsiString;
 l_PrintFontSize : AnsiString;
 {$ENDIF evUseEvdStyleOnly}
begin
 CheckDigitalSeparatorAlignment;
 {$IFDEF evUseEvdStyleOnly}
 l_EmptyText := S.Empty;
 l_CodePage := S.CodePage;
 OutTextStyle(l_EmptyText, l_CodePage, l_InsertSemiCol);
 if l_InsertSemiCol then
  S.Insert(cc_SemiColon, 0);
 {$ELSE}
 with f_CurParaParas.Style do
 begin
  if S.Empty
     and (Letter <> TechCommentLetter)
     and (Letter <> NewSchoolStyleLetter)
     then
   Letter := NilLetter
  else
  begin
   Case Letter of
    NilLetter:
    begin
     l_OutStyle := false;
     if (f_PrevParaStyle.Letter = TechCommentLetter) AND not S.Empty then
     begin
      S.Insert(cc_SemiColon, 0);
      Letter := TechCommentLetter;
     end;//f_PrevParaStyle.Letter = TechCommentLetter
    end;//NilLetter
    PreformattedLetter:
    begin
     if (S Is TevSBSString) then
     begin
      Letter := SBSLetter;
      ParaLI := 0;
      ParaFI := 0;
      ParaWC := 73; // 08.06.2000 Pixel2Char(evCm2Pixel(def_cmParaWidth));
     end;{S Is TevSBSString}
     if (f_SubCount > 0) OR (Letter = SBSLetter) then
      l_OutStyle := true
     else
     begin
      if (f_PrevParaStyle.Letter = TechCommentLetter) AND
         (Letter = f_BeforeCommentLetter) then
      begin
       l_OutStyle := true;
       // - тут вообще говоря был пустой код
       //Assert(false, 'А попадаем ли мы сюда?');
       // http://mdp.garant.ru/pages/viewpage.action?pageId=336664105&focusedCommentId=342337450#comment-342337450
       // ПОПАДАЕМ - http://mdp.garant.ru/pages/viewpage.action?pageId=342865677
      end//f_PrevParaStyle.Letter = TechCommentLetter
      else
      if not EQ(f_PrevParaStyle) then
       l_OutStyle := true
      else
      begin
       l_OutStyle := false;
       // - тут вообще говоря был пустой код
       //Assert(false, 'А попадаем ли мы сюда?');
       // http://mdp.garant.ru/pages/viewpage.action?pageId=336664105&focusedCommentId=342337450#comment-342337450
       // - тестами выяснилось, что попадаем и что похоже, что эта ветка про то,
       //   что стиль текущего параграфа совпадает со стилем предыдущего и значит
       //   его - не нужно писать
      end;//not EQ(f_PrevParaStyle)
     end;//f_SubCount > 0
    end;//PreformattedLetter
    TechCommentLetter:
    begin
     l_OutStyle := false;
     //if not S.Empty then
      S.Insert(cc_SemiColon, 0);
    end;//TechCommentLetter
    else
     l_OutStyle := true;
   end;//Case Letter
   l_CodePage := '';
   if S.Empty then
   begin
    if (Letter <> NewSchoolStyleLetter) then
    begin
     l_OutStyle := false;
     Letter := NilLetter;
    end;//Letter <> NewSchoolStyleLetter
   end//S.Empty
   else
   if (Letter <> NilLetter) and (CodePage = CP_KeepExisting) then
   begin
     if ((S.CodePage = CP_TatarOEM) OR (S.CodePage = CP_Tatar)) then
     begin
      Assert(S.CodePage <> CP_Tatar, 'Как-то странно тут говорить про OEM или мы директивно к OEM потом приводим?');
      l_OutStyle := true;
      l_CodePage := ' CP_TatarOEM';
    end//S.CodePage = CP_TatarOEM
    else
    if l3IsOEMEx(S.CodePage) then
    begin
     // - ничего не делаем
    end//l3IsOEMEx(S.CodePage)
    else
    if l3IsANSI(S.CodePage) then
    begin
     // - ничего не делаем
    end//l3IsANSI(S.CodePage)
    else
    if (S.CodePage = CP_EastEurope) then
    begin
     l_OutStyle := true;
     l_CodePage := ' CP_EastEurope';
    end//S.CodePage = CP_EastEurope
    else
     Assert(false, 'Кодировка параграфа: ' + IntToStr(S.CodePage));
   end;//(Letter <> NilLetter) and (CodePage = CP_KeepExisting)
   if SkipPreformatted AND
     ((Letter = PreformattedLetter) OR (Letter = SBSLetter)) then
    Exit;
   if OutStyle AND l_OutStyle then
   begin
    OutEOL;
    if IsDecorPara then
     l_Suffix := 'A'
    else
     l_Suffix := '';
    if (PrintFontSize > 0) AND
       (PrintFontSize <> 12) AND
       (Letter = PreformattedLetter) then
     l_PrintFontSize := ' H' + IntToStr(PrintFontSize)
    else
     l_PrintFontSize := '';
    if (Letter = NewSchoolStyleLetter) then
     OutString(Format('!STYLE%s %s%d%s%s', [l_Suffix,
                                             Letter,
                                             StyleID,
                                             l_CodePage,
                                             l_PrintFontSize]))
    else
     OutString(Format('!STYLE%s %s %d %d %d%s%s', [l_Suffix,
                                             Letter,
                                             Max(0, ParaLI),
                                             Min(ParaWC, 73),
                                             Max(0, ParaFI),
                                             l_CodePage,
                                             l_PrintFontSize]));
   end;//l_OutStyle
  end;//not S.Empty
 end;//with f_CurParaParas.Style
 if PlainText then
 begin
  if (f_CurParaParas.Style.Letter = TechCommentLetter) then
   Exit;
 end;//PlainText
 SetOutCodePage(S, CodePage);
 if (CodePage = CP_KeepExisting) then
  Assert(S.IsOEMEx OR (S.CodePage = CP_EastEurope));
 {$ENDIF evUseEvdStyleOnly}
 inherited;
end;

function TevCustomNSRCWriter.GetObject: TObject;
  {* - получить объект из обертки. }
begin
 Result := Self;
end;

procedure TevCustomNSRCWriter.AnalizeStyle(StHandle: Long);
  {-}
var
 St : Tl3Variant;
 IT : TevIndentType;
begin
 with f_CurParaParas.Style do
 begin
  if (Letter = NilLetter) then
  begin
   if (f_StyleInterface = nil) then
    f_StyleInterface := TevStyleInterface.Create;
   f_StyleInterface.SelectStyledObjectType(CurrentType);
   St := f_StyleInterface.SelectStyle(StHandle);
   {$IFDEF evUseEvdStyleOnly}
   if (f_CurParaParas.LeftIndent <> l3NilLong) and (f_CurParaParas.LeftIndent <> Pixel2Char(St.IntA[k2_tiLeftIndent])) then
    ParaLI := f_CurParaParas.LeftIndent
   else
    ParaLI := l3NilLong;
   {$ELSE}
   if (f_CurParaParas.FirstIndent = l3NilLong) then
    ParaFI := Pixel2Char(St.IntA[k2_tiFirstIndent])
   else
    ParaFI := f_CurParaParas.FirstIndent;
   if (f_CurParaParas.LeftIndent = l3NilLong) then
    ParaLI := Pixel2Char(St.IntA[k2_tiLeftIndent])
   else
    ParaLI := f_CurParaParas.LeftIndent;
   if (f_CurParaParas.Width = l3NilLong) then
    ParaWC := Pixel2Char(St.IntA[k2_tiWidth])
   else
    ParaWC := f_CurParaParas.Width;
   {$ENDIF evUseEvdStyleOnly}
   StyleID := 0; 
   Case StHandle of
    ev_saTxtHeader1 {$IFDEF evUseEvdStyleOnly},
    {$ELSE}:
     IT := ev_itCenter;
   {$ENDIF evUseEvdStyleOnly}
    ev_saTxtHeader2,
    ev_saTxtHeader3, ev_saTxtHeader4:
    begin
     ParaLI := 0;
     StyleID := -StHandle;
     ParaWC := 0;
     ParaFI := 0;
     Letter := NewSchoolStyleLetter;
     Exit;
    end;//ev_saTxtHeader2..
    ev_saTxtNormalOEM, ev_saANSIDOS:
    begin
     {$IFDEF evUseEvdStyleOnly}
     StyleID := -StHandle;
     ParaWC := 0;
     ParaFI := 0;
     ParaLI := 0;
     Letter := NewSchoolStyleLetter;
     {$ELSE}
     IT := ev_itPreformatted;
     ParaLI := 0;
     ParaWC := 73; // 08.06.2000 Pixel2Char(evCm2Pixel(def_cmParaWidth)); {!!! 22.12.1998 255->73}
     {$ENDIF evUseEvdStyleOnly}
     ParaFI := 0;
    end;{ev_saTxtNormalOEM, ev_saANSIDOS}
    {$IFNDEF evUseEvdStyleOnly}
    ev_saTechComment :
    begin
     Letter := TechCommentLetter;
     Exit;
    end;//ev_saTechComment
    ev_saVersionInfo :
    begin
     Letter := VersionInfoLetter;
     Exit;
    end;//ev_saVersionInfo
    {$ENDIF evUseEvdStyleOnly}
    else
    begin
     {$IFNDEF evUseEvdStyleOnly}
     if (StHandle <= ev_saHLE1) then
     {$ENDIF evUseEvdStyleOnly}
     begin
     {$IFNDEF evUseEvdStyleOnly}
      if (StHandle <= ev_saHLE1) then ParaLI := 0;
     {$ENDIF evUseEvdStyleOnly}
      StyleID := -StHandle;
      ParaWC := 0;
      ParaFI := 0;
      Letter := NewSchoolStyleLetter;
     {$IFNDEF evUseEvdStyleOnly}
      Exit;
     {$ENDIF evUseEvdStyleOnly}
     end//StHandle <= ev_saHLE1
     {$IFNDEF evUseEvdStyleOnly}
     else
     begin
      if (f_CurParaParas.Justification = ev_itNone) then
       IT := TevIndentType(St.IntA[k2_tiJustification])
      else
       IT := f_CurParaParas.Justification;
     end;//StHandle <= ev_saHLE1
     {$ENDIF evUseEvdStyleOnly}
    end;//else
   end;//Case StHandle
   {$IFDEF evUseEvdStyleOnly}
   if (TevIndentType(St.IntA[k2_tiJustification]) = f_CurParaParas.Justification) then
    IT := ev_itNone
   else
    IT := f_CurParaParas.Justification;
   {$ENDIF evUseEvdStyleOnly}
   Case IT of
    ev_itLeft         : Letter := 'L';
    ev_itRight        : Letter := 'R';
    ev_itWidth        : Letter := 'J';
    ev_itCenter       : Letter := 'C';
   {$IFNDEF evUseEvdStyleOnly}
    ev_itPreformatted : Letter := PreformattedLetter;
    ev_itNone         : Letter := PreformattedLetter;
   {$ENDIF evUseEvdStyleOnly}
   end;{Case IT}
  end;{Letter = NilLetter}
 end;
end;

procedure TevCustomNSRCWriter.OutSub(SubHandle: Long);
  {-}
begin
 Inc(f_SubCount);
 if NeedOutSub then
 begin
  OutEOL;
  OutSubInt(SubHandle);
 end;
end;

procedure TevCustomNSRCWriter.OpenBlock(BlockHandle: Long);
  {-}
begin
 if AddBlocks then begin
  OutEOL;
  OutString(Format('!BLOCK %d', [BlockHandle]));
  ClearPrevPara;
  DoOutBlock(BlockHandle);
 end;{AddBlocks}
end;

procedure TevCustomNSRCWriter.CloseBlock;
  {-}
begin
 if AddBlocks then begin
  OutEOL;
  OutString('!BLOCKEND');
  ClearPrevPara;
 end;{AddBlocks}
end;

procedure TevCustomNSRCWriter.DoOutSub(SubHandle: Long);
  {virtual;}
  {-}
begin
 if Assigned(f_OnOutSub) then f_OnOutSub(Self, SubHandle, Filer);
end;

procedure TevCustomNSRCWriter.DoOutBlock(BlockHandle: Long);
  {virtual;}
  {-}
begin
 if Assigned(f_OnOutBlock) then f_OnOutBlock(Self, BlockHandle, Filer);
end;

procedure TevCustomNSRCWriter.DoOutShortName(Name: Tl3CustomString);
  {virtual;}
  {-}
begin
 if Assigned(f_OnOutShortname) then f_OnOutShortname(Self, Name, Filer);
end;

procedure TevCustomNSRCWriter.OutShortName(Name: Tl3CustomString);
  {-}
begin
 if not f_WasShortname then begin
  OutHeader;
  f_WasShortname := true;
  DoOutShortname(Name);
 end;
end;

const
  NSRCBrackets : array [TevStandardStylesNSRC] of AnsiChar =
   (
     #0,                    { ev_saTxtNormalANSI  - 'Нормальный (ANSI)'                   }
     #0,                    { ev_saTxtNormalOEM   - 'Нормальный (OEM)'                    }
     ev_NSRCHeader,         { ev_saTxtHeader1     - 'Заголовок 1'                         }
     #0{ev_NSRCHeader},         { ev_saTxtHeader2     - 'Заголовок 2'                         }
     #0{ev_NSRCHeader},         { ev_saTxtHeader3     - 'Заголовок 3'                         }
     #0{ev_NSRCHeader},         { ev_saTxtHeader4     - 'Заголовок 4'                         }
     ev_NSRCOutOfDate,      { ev_saTxtOutOfDate   - 'Утратил силу'                        }
     ev_NSRCHyperlink,      { ev_saHyperLink      - 'Гипертекстовая ссылка'               }
     ev_NSRCComment,        { ev_saTxtComment     - 'Комментарий'                         }
     ev_NSRCColorSelection, { ev_saColorSelection - 'Цветовое выделение'                  }
     ev_NSRCHyperlinkCont,  { ev_saHyperLinkCont  - 'Продолжение ссылки'                  }
     #0,                    { ev_saANSIDOS        - 'Моноширинный (ANSI)'                 }
     #0,                    {ev_saFoundWords      - Найденные слова.                      }
     #0,                    {ev_saNormalNote      - Нормальный (справка).                 }
     #0,                    {ev_saArticleHeader   - Заголовок статьи.                     }
     #0,                    {ev_saToLeft          - Прижатый влево.                       }
     #0,                    {ev_saNormalTable     - Нормальный для таблиц.                }
     #0,                    {ev_saNormalSBSLeft   - Нормальный для левых частей SBS.      }
     #0,                    {ev_saNormalSBSRight  - Нормальный для правых частей SBS.     }
     #0,                    {ev_saNormalTableList - нормальный для списков в виде таблиц. }
     #0,                    {ev_saTechComment     - технический комментарий.              }
     ev_NSRCComment,        {ev_saVersionInfo     - информация о версии.                  }
     #0,                    {ev_saUserComment     - комментарий пользователя (для Гаранта 6х). }
     #0,                    {ev_saContents        - оглавление (для Гаранта 6х).          }
     ev_NSRCNotApplied,     {ev_saNotApplied      - не вступил в силу.                    }
     #0,                    {ev_saDictEntry       - Словарная статья.                     }
     #0,                    {ev_saHFLeft          - колонтитул (левый).                   }
     #0,                    {ev_saHFRight         - колонтитул (правый).                  }
     #0,
     #0,                    {ev_saNormalAnno      - нормальный для аннотаций.             }
     #0,                    // ev_saMainMenuConstPath
     #0,                    // ev_saMainMenuChangePath
     #0,                    // ev_saMainMenuHeader
     #0,                    // ev_saMainMenuInteractiveHeader
     ev_NSRCFormula,        // ev_saObject        - псевдо-стиль, для объектных сегментов
     #0,                    // ev_saMistake       - Слово с опечаткой.
     ev_NSRCColorSelection  // ev_saEnclosureHeader - Заголовок приложения.
   );
const
 cDecor = evNSRCConst.cDecor;
 cDecorEx = evNSRCConst.cDecorEx;

procedure TevCustomNSRCWriter._Msg2Log(Msg: AnsiString);
begin
end;

procedure TevCustomNSRCWriter.DoOutHyperlinkEx(Ob: Tl3Variant; var S: AnsiString);
  {virtual;}
  {-}

var
 OutComma : Bool;

 function OutAddress(anAddress: Tl3Variant; Index: Long): Bool; far;
 var
  DocID, SubID : Long;
 begin
  if OutComma then
   S := S + {cc_Comma + }cc_HardSpace
  else
   OutComma := true;
  with anAddress do begin
   with Attr[k2_tiDocID] do
    if IsValid then
     DocID := AsLong
    else
     DocID := 0;
   with Attr[k2_tiSubID] do
    if IsValid then
     SubID := AsLong
    else
     SubID := 0;
  end;//with anAddress
  S := S + IntToStr(DocID);
  if (SubID <> 0) then
   S := S + cc_Dot + IntToStr(SubID);
  Result := true;
 end;

var
 SF       : Tl3CustomFiler;
 l_Handle : Long;
begin
 if Assigned(f_OnOutHyperlink) then
 begin
  with Ob.Attr[k2_tiHandle] do
   if IsValid then
    l_Handle := AsLong
   else
    l_Handle := 0;
  if Assigned(f_OnOutHyperlink) then
  begin
   SF := StringFiler;
   with SF.Stream do
   begin
    Seek(0, soBeginning);
    Size := 0;
   end;//with SF.Stream
   f_OnOutHyperlink(Self, l_Handle, SF);
   S := S + f_String.AsString;
  end//Assigned(f_OnOutHyperlink)
  else
   {S := S + IntToStr(l_Handle)};
   // - так нельзя, т.к. l_Handle это не адрес !
 end//Assigned(f_OnOutHyperlink)
 else
 begin
  OutComma := false;
  with Ob.Attr[k2_tiChildren] do
   if IsValid then
    IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@OutAddress))
   else with Ob.Attr[k2_tiHandle] do
    if IsValid then
     _Msg2Log(Format('Topic #%d > Пустая ссылка %d', [f_Handle, AsLong]))
    else
     _Msg2Log('Совсем плохо - ссылка без Handle');
 end;//Assigned(f_OnOutHyperlink)
end;

procedure TevCustomNSRCWriter.DoOutHyperlink(Ob: Tl3Variant; var S: AnsiString);
  {virtual;}
  {-}
begin
 if Ob.IsKindOf(k2_typHyperlink) AND
    (not Ob.HasSubAtom(k2_tiStyle) OR (Ob.IntA[k2_tiStyle] = ev_saHyperLink))  
    {AND Ob.HasSubAtom(k2_tiHandle)} then
 begin
  DoOutHyperlinkEx(Ob, S);
  S := S + NSRCBrackets[-ev_saHyperlink];
 end;{..k2_idHyperlink..}
end;

function TevCustomNSRCWriter.IsMarkStyle(aParaVisible        : Bool;
                                         aParaStyle          : Long;
                                         aStyledObject       : Tl3Variant;
                                         aText: Tl3String;
                                         out Open, Close     : AnsiString;
                                         var DeleteText      : Boolean): Bool;
  {override;}
  {-}

 {$IfDef evOutDecorToNSRC}
 function OutDecor: String;
 var
  l_W : TevdNativeWriter;
  l_F : Tl3CustomFiler;
  l_Stream : Tl3StringStream;
  l_Pos : Integer;
  l_S : Tl3WString;
 begin//OutDecor
  Result := '';
  l_F := Tl3CustomFiler.Create;
  try
   l_Stream := Tl3StringStream.Create;
   try
    l_F.Mode := l3_fmWrite;
    l_F.Stream := l_Stream;
    try
     l_W := TevdNativeWriter.Create;
     try
      l_W.Filer := l_F;
      l_W.NeedOutHeader := false;
      {$IfDef evdNeedEverestTxt}
      l_W.Binary := false;
      {$Else}
      !!! нужен TevdNativeWriter с поддержкой текстового формата
      {$EndIf evdNeedEverestTxt}
      l_W.Start;
      try
       l_W.StartChild(aStyledObject.TagType);
       try
        aStyledObject.WriteTag(l_W, l3_spfAll, [k2_tiStart, k2_tiFinish, k2_tiVisible]);
       finally
        l_W.Finish;
       end;//try..finally
      finally
       l_W.Finish;
      end;//try..finally
      Result := l_Stream._String.AsString;
      Result := l3ReplaceNonReadable(Result);
      Result := l3DeleteDoubleSpace(Result);
      Result := l3RTrim(Result);
      l_S := l3PCharLen(Result);
      l_Pos := l3Pos(l_S, l3PCharLen('='));
      if (l_Pos > 0) then
       Result := l3PCharLen2String(l3PCharLen(l_S.S + l_Pos + 1, l_S.SLen - l_Pos - 1, l_S.SCodePage));
      Result := TrimLeft(Result);
      if (Result = evdOpenBracket + evdCloseBracket) OR
         (Result = evdOpenBracket + cc_HardSpace + evdCloseBracket) then
       Result := '';
     finally
      FreeAndNil(l_W);
     end;//try..finally
    finally
     l_F.Stream := nil;
    end;//try..finally
   finally
    FreeAndNil(l_Stream);
   end;//try..finally
  finally
   FreeAndNil(l_F);
  end;//try..finally
 end;//OutDecor
 {$EndIf evOutDecorToNSRC}

var
 l_IsPara : Bool;
 V        : Bool;

 procedure OutVisible;
 begin//OutVisible
  if l_IsPara then
  begin
   if not V then
   begin
    Open := ev_NSRCInvisible + Open;
    Close := Close + ev_NSRCInvisible;
    Result := true;
   end;//not V
  end//l_IsPara
  else
  if (aParaVisible <> V) then
  begin
   Open := ev_NSRCInvisible + Open;
   Close := Close + ev_NSRCInvisible;
   Result := true;
  end;//aParaVisible <> V
 end;//OutVisible

var
 l_EndTextPos  : Long;
 l_FormulaText : AnsiString;
 C             : AnsiChar;
 ID            : Long;
 l_EP          : AnsiString;
 l_EH          : Integer;
 l_DPI         : Integer;
 l_IStream     : IStream;
 l_Stream      : Tl3Stream;
 l_OutStream   : Tl3NamedFileStream;
 l_Path        : AnsiString;
 l_Pos         : Int64;
 l_BL          : Integer;
 l_H: Integer;
 l_W: Integer;
 l_ValidPicture : Boolean;
 l_TextToOut : Tl3CustomString;
begin
 f_CheckChar := #0;
 Result := inherited IsMarkStyle(aParaVisible, aParaStyle, aStyledObject, aText, Open, Close, DeleteText);
 with aStyledObject do
 begin
  ID := IntA[k2_tiStyle];
  l_IsPara := IsKindOf(k2_typPara);
  if l_IsPara then
   V := aParaVisible
  else
  if (ID = ev_saTxtComment)
     // - иначе не работали тесты для http://mdp.garant.ru/pages/viewpage.action?pageId=180060974
     OR (ID = ev_saVersionInfo) then
     // - иначе не работали тесты для http://mdp.garant.ru/pages/viewpage.action?pageId=209584396
   V := false
  else
  if HasSubAtom(k2_tiVisible)
     AND Attr[k2_tiVisible].IsValid then
     // http://mdp.garant.ru/pages/viewpage.action?pageId=210043510
     // - забыли, что бывает прозрачность
   V := BoolA[k2_tiVisible]
  else
   V := aParaVisible;
(*   with Attr[k2_tiVisible] do
    if IsValid then
     V := AsBool
    else
     V := aParaVisible;*)
//  if ((ID >= Low(TevStandardStyle)) AND (ID <= High(TevStandardStyle))) then
  // - закомментировал, т.к. http://mdp.garant.ru/pages/viewpage.action?pageId=604929313
  // - будем писать кусок EVD-оформления в NSRC
  begin
   if not l_IsPara AND (ID = aParaStyle) then
   begin
    if not aStyledObject.HasSubAtom(k2_tiFont) then
    begin
     OutVisible;
     Exit;
    end;//not aStyledObject.HasSubAtom(k2_tiFont)
   end;//not l_IsPara..
   if (ID = ev_saHyperlink) then
   begin
    if not IsKindOf(k2_typHyperlink) then
     Exit;
   end//ID = ev_saHyperlink
   {$IFDEF evUseEvdStyleOnly}
   else
   if l_IsPara then
    Exit
   {$ENDIF evUseEvdStyleOnly}
   else
(*   if ((ID >= ev_saTxtHeader4) AND (ID <= ev_saTxtHeader1)) then
   begin
    if IsKindOf(k2_typSegment) then
     Exit;
   end*)
   ;
   // - закомментировал, т.к. http://mdp.garant.ru/pages/viewpage.action?pageId=604929313
   // - будем писать кусок EVD-оформления в NSRC
   C := #0;
   if ((ID >= Low(TevStandardStyle)) AND (ID <= High(TevStandardStyle))) then
   begin
    C := NSRCBrackets[-ID];
    if ((ID >= ev_saTxtHeader4) AND (ID <= ev_saTxtHeader1)) then
    begin
     if IsKindOf(k2_typSegment) then
      C := #0;
    end;//((ID >= ev_saTxtHeader4) AND (ID <= ev_saTxtHeader1))
    {$IfNDef evUseEvdStyleOnly}
    {$IfDef evOutDecorToNSRC}
    if (C <> #0) then
     if aStyledObject.IsKindOf(k2_typSegment) then
      if aStyledObject.HasSubAtom(k2_tiFont) then
      // - чтобы записать и стиль и шрифт по-новому
       if not aStyledObject.IsKindOf(k2_typObjectSegment) then
        if not aStyledObject.IsKindOf(k2_typHyperlink) then
         C := #0;
    {$EndIf  evOutDecorToNSRC}     
    {$EndIf  evUseEvdStyleOnly}
   end//((ID >= Low(TevStandardStyle)) AND (ID <= High(TevStandardStyle)))
   else
    C := #0; 
   if (C <> #0) then
   begin
    Close := C;
{    if (ID >= ev_saTxtHeader4) AND (ID < ev_saTxtHeader1) then
     Open := C + ev_psFixLen('', ev_saTxtHeader1 - ID, cc_Tab)
    else}
     Open := C;
   end//C <> #0
   else
   begin
    {$IfNDef evUseEvdStyleOnly}
    {$IfDef evOutDecorToNSRC}
    if aStyledObject.IsKindOf(k2_typSegment) then
     if not aStyledObject.IsKindOf(k2_typObjectSegment) then
      if not aStyledObject.IsKindOf(k2_typHyperlink) then
      begin
       Open := OutDecor;
       if (Open <> '') then
       begin
        if NeedOutDecorInfo then
        begin
         NeedCorrect := true;
         dbgAppendToLogLn(ChangeFileExt(ParamStr(0), '.num'), IntToStr(InternalHandle));
         l3System.Msg2Log('Decor: ' + Open);
         l3System.Msg2Log('DocID: ' + IntToStr(InternalHandle));
         l_TextToOut := aText;
         l3System.Msg2Log('Text part: ' + l3PCharLen2String(l_TextToOut.AsWStr, CP_ANSI));
         if (aText Is TevSubString) then
          if (TevSubString(aText).TP <> nil) then
          begin
           l_TextToOut := TevSubString(aText).TP.AsObject.Attr[k2_tiText] As Tl3CustomString;
           l3System.Msg2Log('Text: ' + l3PCharLen2String(l_TextToOut.AsWStr, CP_ANSI));
          end;//aText Is TevSubString
        end;//NeedOutDecorInfo
        C := cDecorBracket;
        Close := C;
        Open := cDecorEx + Open;
       end;//Open <> ''
      end;//IsKindOf(k2_typSegment)
    {$EndIf  evOutDecorToNSRC}  
    {$EndIf  evUseEvdStyleOnly}
   end;//C <> #0
   
   if (C <> #0) then
   begin
    f_CheckChar := C;
    Result := true;
    if (ID = ev_saObject) AND aStyledObject.IsKindOf(k2_typObjectSegment) then
     with aStyledObject.Child[0] do
      if IsKindOf(k2_typFormula) then
      begin
       l_FormulaText := StrA[k2_tiText];
       l_EndTextPos := Pos(cc_Null, l_FormulaText);
       if l_EndTextPos > 0 then
        l_FormulaText := Copy(l_FormulaText, 1, l_EndTextPos - 1);
       Close := l_FormulaText + Close;
       DeleteText := true;
      end//IsKindOf(k2_typFormula)
      else
      if IsKindOf(k2_typBitmapPara) then
      begin
//       if not Supports(Attr[k2_tiData].AsObject, IStream, l_IStream) then
       l_EH := IntA[k2_tiExternalHandle];
       l_ValidPicture := true;
       try
        if not Attr[k2_tiData].IsValid then
         raise El3BadDataInPara.Create(Format('Нет содержимого картинки. External handle = %d', [l_EH]));
        if not Attr[k2_tiData].IsStream(l_IStream) then
         raise El3BadDataInPara.Create(Format('Не получили поток картинки. External handle = %d', [l_EH]));
       except
        on E : Exception do
         if SilentErrors then
         begin
          l_ValidPicture := false;
          _Msg2Log(E.Message);
         end//SilentErrors
         else
          raise;
       end;//try..except
       if l_ValidPicture then
       begin
        l3IStream2Stream(l_IStream, TStream(l_Stream));
        try
         l_Path := ExtractFilePath(Filer.Identifier);
         l_EP := StrA[k2_tiExternalPath];
         l_DPI := IntA[k2_tiDPI];
         l_BL := aStyledObject.IntA[k2_tiBaseLine];
         l_H:= IntA[k2_tiHeight];
         l_W:= IntA[k2_tiWidth];
         if l_EP = '' then
          l_EP := IntToStr(l_EH);
         if (ExtractFileExt(l_EP) = '') then
         begin
          l_Pos := l_Stream.Position;
          try
           l_Stream.Seek(0, soBeginning);
           l_EP := l_EP + PictExt[FindStreamFormat(l_Stream)];
          finally
           l_Stream.Seek(l_Pos, soBeginning);
           // - восстанавливем указатель ОСНОВНОГО потока
          end;//try..finally
         end;//ExtractFileExt(l_EP) = ''
         //Assert(l_EP <> '');
         Assert(f_ExternalDocHandle <> 0);
         l_Path := l_Path + IntToStr(f_ExternalDocHandle);
         MakeDir(l_Path);
         l_OutStream := Tl3NamedFileStream.Create(l_Path + '\' + l_EP, l3_fmWrite);
         try
          l_Pos := l_Stream.Position;
          try
           l_Stream.Seek(0, soBeginning);
           {$IfDef nsTest}
           Dec(g_IStreamCopyTo_Guard);
           try
           {$EndIf nsTest}
            l3CopyStream(l_Stream, l_OutStream);
           {$IfDef nsTest}
           finally
            Inc(g_IStreamCopyTo_Guard);
           end;//try..finally
           {$EndIf nsTest}
          finally
           l_Stream.Seek(l_Pos, soBeginning);
           // - восстанавливем указатель ОСНОВНОГО потока
          end;//try..finally
         finally
          FreeAndNil(l_OutStream);
         end;//try..finally
         SaveObjFileName(l_Path + '\' + l_EP);
         l_FormulaText := 'pic:' + IntToStr(f_ExternalDocHandle) + '\' + l_EP + ';' +
                          'topic:' + IntToStr(l_EH);
         if (l_DPI > 0) then
          l_FormulaText := l_FormulaText + ';' +
                           'res:' + IntToStr(l_DPI);
         if (l_BL > 0) then
          l_FormulaText := l_FormulaText + ';' +
                           'bloffs:' + IntToStr(l_BL);
         if l_H > 0 then
          l_FormulaText := l_FormulaText + ';' +
                           'height:' + IntToStr(l_H);
         if l_W > 0 then
          l_FormulaText := l_FormulaText + ';' +
                           'width:' + IntToStr(l_W);
         l_EndTextPos := Pos(cc_Null, l_FormulaText);
         if (l_EndTextPos > 0) then
          l_FormulaText := Copy(l_FormulaText, 1, l_EndTextPos - 1);
         Close := l_FormulaText + Close;
         DeleteText := true;
        finally
         FreeAndNil(l_Stream);
        end;//try..finally
       end;//l_ValidPicture
      end;//IsKindOf(k2_typBitmapPara)
    try
     DoOutHyperLink(aStyledObject, Close);
    except
     on EevHyperlinkNotFound do
     begin
      Result := false;
      Open := ''; Close := '';
     end;{EevHyperlinkNotFound}
    end;{try..except}
    OutVisible;
   end//C <> #0
   else
    OutVisible;
  end;//ID >= Low(TevStandardStyle)..
 end;//with aStyledObject
end;

procedure TevCustomNSRCWriter.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
  {override;}
  {-}
var
 S  : Tl3CustomString;
 CT : Tk2Type;
begin
 CT := CurrentType;
 if CT.IsKindOf(k2_typPageProperties) then
 begin
  Case AtomIndex of
   k2_tiOrientation:
    f_Division.Orientation := TevPageOrientation(VariantAsInteger(AtomIndex, Value));
   k2_tiHeight:
    f_Division.Extent.Y := Value.AsInteger;
   k2_tiWidth:
    f_Division.Extent.X := Value.AsInteger;
   else
    inherited;
  end;//Case AtomIndex
 end//CT.IsKindOf(k2_typPageProperties)
 else
 begin
  Case AtomIndex of
   k2_tiExternalHandle:
    if CT.IsKindOf(k2_typDocument) then
     if (TopType[1] = nil) then
     // - учитываем вложенные документы
      f_ExternalDocHandle := Value.AsInteger;
   k2_tiStyle:
    AnalizeStyle(Value.AsInteger);
   k2_tiHandle:
    begin
     if CT.IsKindOf(k2_typBlock) then
      OpenBlock(Value.AsInteger)
     else
     if CT.IsKindOf(k2_typSub) AND
        not CT.IsKindOf(k2_typDocumentSub) and
        not CT.IsKindOf(k2_typBookmark) then
      OutSub(Value.AsInteger);
    end;//AtomIndex = k2_tiHandle
   k2_tiJustification:
     if (f_CurParaParas.Justification = ev_itNone) then
      f_CurParaParas.Justification := TevIndentType(Value.AsInteger);
   k2_tiFirstIndent:
     if (f_CurParaParas.FirstIndent = l3NilLong) then
      f_CurParaParas.FirstIndent := Pixel2Char(Value.AsInteger);
   k2_tiWidth:
     if (f_CurParaParas.Width = l3NilLong) then
      f_CurParaParas.Width := Pixel2Char(Value.AsInteger);
   k2_tiLeftIndent:
     if (f_CurParaParas.LeftIndent = l3NilLong) then
      f_CurParaParas.LeftIndent := Pixel2Char(Value.AsInteger);
   k2_tiShortName:
    begin
     if CT.IsKindOf(k2_typDocument) then
     begin
      if (TopType[1] = nil) then
      begin
       S := VariantAsString(Value);
       try
        OutShortname(S);
       finally
        l3Free(S);
       end;{try..finally}
      end; // (TopType[1] = nil)
     end; // CT.IsKindOf(k2_typDocument)
    end;//AtomIndex = k2_tiShortName
   k2_tiComment:
    begin
     if CT.IsKindOf(k2_typDocument) then
     begin
      if (TopType[1] = nil) then
      begin
        // - учитываем вложенные документы
       S := VariantAsString(Value);
       try
        OutHeader;
        OutEOL;
        OutString(cc_SemiColon);
        SetOutCodePage(S, CodePage);
        OutString(S);
       finally
        l3Free(S);
       end;{try..finally}
      end;//TopType[1] = nil
     end//CT.IsKindOf(k2_typDocument)
     else
      inherited;
    end;//k2_tiComment
   k2_tiPrintFontSize: 
    if (f_CurParaParas.Style.PrintFontSize = 0) then
     f_CurParaParas.Style.PrintFontSize := Value.AsInteger;
   else
    inherited;
  end;//Case AtomIndex  
 end;//CT.IsKindOf(k2_typPageProperties)
end;

function TevCustomNSRCWriter.COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
  //override;
  {-}
begin
 if IID.EQ(Il3CharSkipper) then 
 begin
  Result.SetOk;
  Pointer(Obj) := Pointer(Il3CharSkipper(TevNSRCCharSkipper.Create));
 end
 else
 if IID.EQ(Il3StringFormatter) then
 begin
  Result.SetOk;
  Pointer(Obj) := Pointer(Il3StringFormatter(TevNSRCStringFormatter.Create));
 end
 else
  Result := inherited COMQueryInterface(IID, Obj);
end;

procedure TevCustomNSRCWriter.SetOutCodePage(aString: Tl3CustomString; aCodePage: Integer);
begin
 if (aCodePage = CP_KeepExisting) then
 begin
  if (aString.CodePage = CP_TatarOEM) then
  begin
   // - ничего не делаем
  end//aString.CodePage = CP_TatarOEM
  else
  if (aString.CodePage = CP_Tatar) then
  begin
   aString.CodePage := CP_TatarOEM;
  end//aString.CodePage = CP_Tatar
  else
  if l3IsOEMEx(aString.CodePage) then
   aString.CodePage := CP_OEMLite
  else
  if l3IsANSI(aString.CodePage) then
   aString.CodePage := CP_OEMLite
  else
  if (aString.CodePage = CP_EastEurope) then
  begin
   // - ничего не делаем
  end//aString.CodePage = CP_EastEurope
  else
   Assert(false, 'Кодировка параграфа: ' + IntToStr(aString.CodePage));
 end//aCodePage = CP_KeepExisting
 else
  aString.CodePage := aCodePage;
end;

procedure TevCustomNSRCWriter.ValidateLine(aLine : Tl3String; aCodePage : Integer);
  //override;
  {* - процедура для проверки корректности строки. }

  procedure CorrectFormulas; // удаляем пробелы в формулах (K 200088144)
  var
   I: Integer;
   l_InQuote: Boolean;
   l_SubStr: Tl3WString;
   l_ParCount: Integer;
   l_S : Tl3WString;
  begin
   I := 0;
   while I < aLine.Len do
   begin
    if aLine.Ch[I] = ev_NSRCFormula then
    begin
     Inc(I);
     l_S := aLine.AsWStr;
     l_S.S := l_S.S + I;
     l_S.SLen := l_S.SLen - I;
     if l3Starts(cDecor, l_S) then
     begin
      Inc(I, Length(cDecor) - 1);
      while (I < aLine.Len) do
      begin
       Inc(I);
       if (aLine.Ch[I] = ev_NSRCFormula) then
       begin
        Inc(I);
        break;
       end;//aLine.Ch[I] = ev_NSRCFormula
      end;//I
     end//l3Starts(cDecor, l_S)
     else
     while I < aLine.Len do
     begin
      case aLine.Ch[I] of
       ev_NSRCFormula: begin
                        Inc(I);
                        Break;
                       end;
       cc_HardSpace: aLine.Delete(I, 1);
       's','S': begin
                 l_SubStr := l3Copy(aLine.AsWStr, I, 7);
                 if l3Same(l_SubStr, 'String(', True) then
                 begin
                  Inc(I, l_SubStr.SLen);
                  l_InQuote := False;
                  l_ParCount := 1;
                  while I < aLine.Len do
                  begin
                   case aLine.Ch[I] of
                    '"' : l_InQuote := not l_InQuote;
                    '(' : if not l_InQuote then
                           Inc(l_ParCount);
                    ')' : if not l_InQuote then
                          begin
                           Dec(l_ParCount);
                           if l_ParCount = 0 then
                           begin
                            Inc(I);
                            Break;
                           end;
                          end;
                   end;//case aLine.Ch[I]
                   Inc(I);
                  end;//I < aLine.Len
                 end//l3Same(l_SubStr, 'String(', True)
                 else
                  Inc(I);
                end;//'s','S'
      else
       Inc(I);
      end;//case aLine.Ch[I]
     end;//while I < aLine.Len
    end;//aLine.Ch[I] = ev_NSRCFormula
    if aLine.Ch[I] <> ev_NSRCFormula then
     Inc(I);
   end;//I < aLine.Len
  end;//CorrectFormulas

  procedure CorrectSwappedBrackets;
  // http://mdp.garant.ru/pages/viewpage.action?pageId=207388924
  var
   l_Len : Integer;
  begin//CorrectSwappedBrackets
   l_Len := aLine.Len;
   if (l_Len >= 4) then
   begin
    if (aLine[0] = ev_NSRCInvisible) AND (aLine[1] = ev_NSRCComment) AND
       (aLine[l_Len-2] = ev_NSRCInvisible) AND (aLine[l_Len-1] = ev_NSRCComment) then
    begin
     aLine[l_Len-1] := ev_NSRCInvisible;
     aLine[l_Len-2] := ev_NSRCComment;
    end;//(aLine[0] = ev_NSRCInvisible) AND (aLine[0] = ev_NSRCComment)
   end;//aLine.Len >= 4
  end;//CorrectSwappedBrackets

  procedure lp_CheckStyle;
  var
   l_Str: Tl3String;         
  begin
   if (f_CheckChar <> #0) then
   begin
    l_Str := Tl3String.Make(aLine);
    try
     if l_Str.Trim.Len = 1 then
      aLine.DeleteAllChars(f_CheckChar);
    finally
     l3Free(l_Str);
    end;
   end; // if (f_CheckChar <> #0) then
  end;

var
 l_Count: Long;

  procedure lp_CheckIntersectionWithHyperlink;
  var
   i             : Integer;
   l_Char        : AnsiChar;
   l_OpenIndex   : Integer;
   l_HyperCount  : Integer;
   l_HyperStart  : Integer;
   l_PrevNSRCChar: AnsiChar;
  begin
   i := 0;
   l_PrevNSRCChar := #0;
   l_HyperCount := 0;
   l_HyperStart := -1;
   l_OpenIndex := -1;
   with aLine do
    while (i <= l_Count) do
    begin
     l_Char := Ch[i];
     if (l_Char in ev_NSRCSimple) then
     begin
      if (l_PrevNSRCChar = l_Char) then
       if (l_HyperCount = 1) and (l_OpenIndex > -1) and (l_OpenIndex < l_HyperStart) then
       begin
        Ch[l_OpenIndex] := ev_NSRCHyperlink;
        Ch[l_HyperStart] := l_PrevNSRCChar;
        l_PrevNSRCChar := #0;
        l_OpenIndex := -1;
       end // if (l_HyperCount > 0) and (l_PrevNSRCChar = l_Char) then
       else
       begin
        l_PrevNSRCChar := #0;
        l_OpenIndex := -1
       end
      else
      begin
       l_PrevNSRCChar := l_Char;
       l_OpenIndex := i;
      end;
     end; // if (l_Char in ev_NSRCSimple) then
     if (l_Char = ev_NSRCHyperlink) then
     begin
      if l_HyperCount = 0 then
       l_HyperStart := i;
      if l_HyperCount = 2 then
       l_HyperCount := 0
      else
       Inc(l_HyperCount);
     end; // if (l_Char in [ev_NSRCHyperlink, ev_NSRCHyperlinkCont]) then
     Inc(i);
    end; // while (i <= l_Count) do
  end; // lp_CheckIntersectionWithHyperlink

 procedure ValidateCodePage;
 var
  l_Index : Integer;
  l_W : WideChar;
  l_WS : Tl3PCharLen;
  l_NS : Tl3Str;
  l_S : Tl3String;
  l_InsString : AnsiString;
 begin
  if (aLine.CodePage = aCodePage) then
   Exit;
  if aLine.Empty then
   Exit;
  if (aLine.CodePage <> CP_Unicode) then
  begin
   if l3IsANSI(aLine.CodePage) then
    Exit;
   if l3IsOEM(aLine.CodePage) then
    Exit;
   aLine.CodePage := CP_Unicode;
  end;//aLine.CodePage <> CP_Unicode
  if (aLine.CodePage = CP_Unicode) then
  begin
   l_S := Tl3String.Create;
   try
    for l_Index := 0 to Pred(aLine.Len) do
    begin
     l_W := PWideChar(aLine.St)[l_Index];
     l_WS := l3PCharLen(PWideChar(@l_W), 1);
     l_NS.Init(l_WS, aCodePage);
     try
      if not l3Same(l_NS, l_WS) then
      begin
       l_InsString := ev_NSRCFormula + 'String(#@' + IntToStr(Integer(l_W)) + ')' + ev_NSRCFormula;
       l_WS := l3PCharLen(l_InsString, aCodePage)
      end;//l3Same(l_NS, l_WS)
     finally
      l_NS.Clear;
     end;//try..finally
     l_S.Append(l_WS);
    end;//for l_Index
    aLine.AsWStr := l_S.AsWStr;
   finally
    FreeAndNil(l_S);
   end;//try..finally
  end;//aLine.CodePage = CP_Unicode
 end;

var
 l_Index   : Long;
 l_Open    : TevNSRCSymbolStatus;
 l_FChar   : AnsiChar;
 l_Char    : AnsiChar;
 l_HIndex  : Long;
 l_HChar   : AnsiChar;
 l_Gap     : AnsiString;
 l_HlSymbS : Long;
 l_HlSymbF : Long;
 i         : Long;
begin
 ValidateCodePage;
 aLine.CodePage := aCodePage;
 inherited;
 if not aLine.Empty then
 begin
  // Дальше, если я правильно понимаю, удаляются дублирующиеся символы.
  // - bug fix: неправильно выливались сегменты и ссылки - было пересечение (см. _TestSet\Segments\Hyperlinks\5.evd).
  with aLine do
  begin
   l_Char := #0;
   l_Count := RTrimLen - 1;
   l_Index := l_Count;
   while (l_Index >= 0) do
   begin
    l_FChar := Ch[l_Index];
    if (l_FChar in [ev_NSRCHyperlink, ev_NSRCHyperlinkCont]) then
    begin
     l3FillChar(l_Open, SizeOf(l_Open), 0);
     Dec(l_Index);
     if (l_FChar = ev_NSRCHyperlink) then
      // - если бывает номер
      while (l_Index >= 0) do
      begin
       // - пропускаем номер
       if (Ch[l_Index] = ev_NSRCHyperlink) then
       begin
        Dec(l_Index);
        Break
       end//Ch[l_Index] = ev_NSRCHyperlink
       else
        Dec(l_Index);
      end;//while (l_Index >= 0)
     l_Gap := '';
     while (l_Index >= 0) do
     begin
      l_Char := Ch[l_Index];
      if (l_Char = l_FChar) then
      begin
       if (l_Gap <> '') then
        Append(l3PCharLen(l_Gap, CodePage));
       Break;
      end;//l_Char = l_FChar
      if (l_Char in ev_NSRCSimple) then
      begin
       l_Open[l_Char] := not l_Open[l_Char];
       if (l_Open[l_Char]) then begin
        // - обрабатываем открывающий символ
        l_HIndex := Pred(l_Index);
        while (l_HIndex >= 0) do
        begin
         l_HChar := Ch[l_HIndex];
         if (l_HChar = l_Char) then
          // - нашли пару
          Break;
         if (l_HChar = l_FChar) then
         begin
          Delete(l_Index, 1);
          l_Gap := l_Char + l_Gap;
          Break;
         end;//l_Char = l_FChar
         Dec(l_HIndex);
        end;//while (l_HIndex >= 0)
       end;//l_Open[l_Char]
      end;//l_Char in ev_NSRCSimple
      Dec(l_Index);
     end;//while (l_Index >= 0)
     Break;
    end//l_Char = ev_NSCRHyperLink
    else
    if (l_Char in ev_NSRCSimple) then
     Break;
    Dec(l_Index);
   end;//while (l_Index >= 0)
  end;//with aLine

  CorrectSwappedBrackets;
  CorrectFormulas;
  lp_CheckStyle;
  lp_CheckIntersectionWithHyperlink;

  // Дальше идет проверка на включение пробелов в гиперссылку - будет перенос, а он не нужен...
  // http://mdp.garant.ru/pages/viewpage.action?pageId=200088144&focusedCommentId=200088151#comment-200088151
  l_HlSymbS := -1;
  l_HlSymbF := -1;
  l_Count := aLine.RTrimLen - 1; // A количество символов уже могло измениться...
  for l_Index := 0 to l_Count - 1 do
  begin
   if (aLine.Ch[l_Index] = ev_NSRCHyperlink) then
    if (l_HlSymbS = -1) and (l_HlSymbF > -1) then
     l_HlSymbF := -1
    else
     if l_HlSymbS = -1 then
      l_HlSymbS := l_Index
     else
      if l_HlSymbF = -1 then
       l_HlSymbF := l_Index
      else
       begin
        l_HlSymbS := -1;
        l_HlSymbF := -1;
       end;
   if (l_HlSymbS <> -1) and (l_HlSymbF <> -1) then
   begin
    i := 0;
    for i := l_HlSymbS + 1 to l_HlSymbF - 1 do
     if aLine.Ch[i] <> cc_HardSpace then Break;
    if i > l_HlSymbS + 1 then
    begin
     aLine.Ch[i - 1] := ev_NSRCHyperlink;
     aLine.Ch[l_HlSymbS] := cc_HardSpace;
    end; //if i > l_HlSymbS + 1 then
    l_HlSymbS := -1;
   end; //if (l_HlSymbS <> -1) and (l_HlSymbF <> -1) then
  end; //for l_Index := 0 to l_Count - 1 do

  if not aLine.Empty then
   if (aLine.Ch[0] = '!') then
    aLine.Insert('!', 0);
 end; //if not aLine.Empty then
end;

(*
procedure TevCustomNSRCWriter.ValidateLine(aLine : Tl3String);
  //override;
  {* - процедура для проверки корректности строки. Для перекрытия в потомках. }
var
 l_Open   : TevNSRCSymbolStatus;
 l_SIndex : Long;
 l_SChar  : AnsiChar;
 l_HIndex : Long;
 l_HChar  : AnsiChar;
begin
 inherited;
 if not aLine.Empty then begin
  l3FillChar(l_Open, SizeOf(l_Open), 0);
  l_SIndex := 0;
  with aLine do
   while (l_SIndex < Len) do begin
    l_SChar := Ch[l_SIndex];
    if (l_SChar in ev_NSRCAll) then begin
     // - это спецсимвол
     l_Open[l_SChar] := not l_Open[l_SChar];
     if l_Open[l_SChar] then begin
      // - это открывающий символ
      if (l_SChar <> ev_NSRCHyperlink) then begin
       // - это не ссылка
       // - теперь надо проверить пересечение со ссылкой:
       l_HIndex := Succ(l_SIndex);
       while (l_HIndex < Len) do begin
        l_HChar := Ch[l_HIndex];
        if (l_HChar = l_SChar) then
         // - скобка закрылась
         break
        else begin
         if (l_HChar = ev_NSRCHyperlink) then begin
          // - ба! да это же ссылка
          Insert(l_SChar, l_HIndex);
          Inc(l_HIndex);
          Insert(l_SChar, Succ(l_HIndex));
         end;//l_HChar = ev_NSCRHyperLink
        end;//l_HChar = l_SChar
        Inc(l_HIndex);
       end;//while (l_HIndex < Len)
       //l_SChar <> ev_NSRCHyperlink
      end else begin
       // - гиперссылку надо обработать особым образом
      end;//l_SChar <> ev_NSRCHyperlink
     end;//l_Open[l_SChar]
    end;//l_SChar in ev_NSRCSimple
    Inc(l_SIndex);
   end;//while (l_SIndex < Len)
 end;//not aLine.Empty
end;
*)
procedure TevCustomNSRCWriter.CheckNeed2AddBlock;
begin

end;

procedure TevCustomNSRCWriter.ValidateText(aText: Tl3String;
  aValidateText: Tl3String = nil);
var
 l_BracketIndex  : Integer;
 
  procedure lp_CheckText;
  begin
   with aText do
   begin
    DeleteAllChars(evAllLineBrackets[l_BracketIndex]);
    LPad(evAllLineBrackets[l_BracketIndex]);
    Append(evAllLineBrackets[l_BracketIndex]);
   end;//l_Open
  end; // lp_CheckText

const
 l_FrameCriteria = cc_Graph_Criteria +
                   [cc_SoftEnter, cc_HardSpace, cc_OEMSoftSpace, cc_Tab];
 l_Criteria = cc_AllChars - l_FrameCriteria;
var
 l_Pos           : Integer;
 l_Char          : AnsiChar;
 l_Open          : Bool;
 l_Index         : Long;
 l_ContinueOuter : Boolean;
 l_CheckString   : Tl3String;
begin
 if aValidateText = nil then
  l_CheckString := aText
 else
  l_CheckString := aValidateText;
 for l_BracketIndex := Low(evAllLineBrackets) to High(evAllLineBrackets) do
 begin
  if l_CheckString.IsOEM then
  begin
    l_Pos := l_CheckString.FindChar(0, evAllLineBrackets[l_BracketIndex]);
    if (l_Pos > 0) then
    begin
     l_Open := false;
     with l_CheckString do
     begin
      l_ContinueOuter := false;
      for l_Index := 0 to Pred(Len) do
      begin
       l_Char := Ch[l_Index];
       if (l_Char = evAllLineBrackets[l_BracketIndex]) then
        l_Open := not l_Open
       else
       if not l_Open then
       begin
        if (l_Char in l_Criteria) then
        begin
         l_ContinueOuter := True;
         // - надо переместиться на конец внешнего цикла
         Break;
        end;//l_Char in l_Criteria
       end;//l_Char = evAllLineBrackets[l_BracketIndex]
      end;//for l_Index
     end;//with l_CheckString
     if l_ContinueOuter then
      Continue;
     if not l_Open then lp_CheckText;
     Continue;
    end // l_Pos > 0
    else
     if (l_Pos = 0) and (aValidateText <> nil) then lp_CheckText;
  end;//aText.IsOEM
 end;//for l_BracketIndex
end;

procedure TevCustomNSRCWriter.ClearPP;
{ Вспомогательные процедуры для конвертера NSRC+ в NSRC }
begin
 ClearBothParas;
end;

procedure TevCustomNSRCWriter.ClearPPBetweenDoc;
{ Вспомогательные процедуры для конвертера NSRC+ в NSRC }
begin
 ClearPP;
 f_BeforeCommentLetter:= NilLetter;
 l3FillChar(f_Division, SizeOf(f_Division), 0);
end;

procedure TevCustomNSRCWriter.CheckDigitalSeparatorAlignment;
begin
end;

procedure TevCustomNSRCWriter.SaveObjFileName(const aFileName: AnsiString);
begin

end;

{$IFDEF evUseEvdStyleOnly}
function TevCustomNSRCWriter.NeedEmptyPara: Boolean;
begin
 with f_CurParaParas.Style do
  Result := (StyleID >= Abs(ev_saHLE1)){ or (StyleID = -ev_saTechComment)};
end;
{$ENDIF evUseEvdStyleOnly}

procedure TevCustomNSRCWriter.OutTextStyle(anEmpty: Boolean;
                                           aCodePage : Integer;
                                           out anInsertSemeColon: Boolean);
{$IFDEF evUseEvdStyleOnly}
var
 l_Suffix        : AnsiString;
 l_OutStyle      : Boolean;
 l_WasEmpty      : Boolean;
 l_CodePage      : AnsiString;
 l_LeftIndent    : AnsiString;
 l_Justification : AnsiString;
 l_PrintFontSize : AnsiString;
{$ENDIF evUseEvdStyleOnly}
begin
{$IFDEF evUseEvdStyleOnly}
 with f_CurParaParas.Style do
 begin
  l_OutStyle := False;
  l_WasEmpty := False;
  anInsertSemeColon := False;
  if (StyleID = ev_saEmpty) and IsTechComment(True) then
   f_CurParaParas.Style.StyleID := -ev_saTechComment;
  if (StyleID <> ev_saEmpty) then
  begin
   l_OutStyle := not EQ(f_PrevParaStyle) or (f_SubCount > 0);
   l_CodePage := '';
   if IsTechComment(False) then
   begin
    l_OutStyle := False;
    l_WasEmpty := False;
    anInsertSemeColon := True;
   end // if IsTechComment then
   else
    if anEmpty then
    begin
     l_OutStyle := NeedEmptyPara;
     l_WasEmpty := not l_OutStyle;
    end // if S.Empty then
    else
     if (CodePage = CP_KeepExisting) then
     begin
      if ((aCodePage = CP_TatarOEM) OR (aCodePage = CP_Tatar)) then
      begin
       l_OutStyle := True;
       l_CodePage := ' CP_TatarOEM';
      end//S.CodePage = CP_TatarOEM
      else
       Assert(false, 'Нехорошо заниматься copy/paste');
     end;//CodePage = CP_KeepExisting
  end; // if (StyleID <> ev_saEmpty) and (f_PrevParaStyle.StyleID <> ev_saEmpty) then
  if OutStyle AND l_OutStyle then
  begin
   OutEOL;
   if IsDecorPara then
    l_Suffix := 'A'
   else
    l_Suffix := '';
   if (PrintFontSize > 0) AND
      (PrintFontSize <> 12) AND
      ((StyleID = ev_saTxtNormalOEM) or (StyleID = ev_saANSIDOS)) then
    l_PrintFontSize := ' H' + IntToStr(PrintFontSize)
   else
    l_PrintFontSize := '';
   if (ParaLI <> 0) and (ParaLI <> l3NilLong) then
    l_LeftIndent := ' L' + IntToStr(ParaLI)
   else
    l_LeftIndent := '';
   if Letter <> NewSchoolStyleLetter then
    l_Justification := ' J' + Letter
   else
    l_Justification := '';
   OutString(Format('!STYLE%s #%d%s%s%s%s', [l_Suffix,
                                             StyleID,
                                             l_CodePage,
                                             l_PrintFontSize,
                                             l_LeftIndent,
                                             l_Justification]));
  end // l_OutStyle
  else
   if l_WasEmpty then
    f_CurParaParas.Style.StyleID := ev_saEmpty;
 end; // with f_CurParaParas.Style do
{$ENDIF evUseEvdStyleOnly}
end;

{$IFDEF evUseEvdStyleOnly}
function TevCustomNSRCWriter.IsTechComment(aPrevStyle: Boolean): Boolean;
begin
 if aPrevStyle then
  Result := (f_PrevParaStyle.StyleID = -ev_saTechComment)
 else
  Result := (f_CurParaParas.Style.StyleID = -ev_saTechComment)
end;
{$ENDIF evUseEvdStyleOnly}

procedure TevCustomNSRCWriter.OutSubInt(SubHandle: Long);
begin
 OutString(Format('!SUB %d', [SubHandle]));
 DoOutSub(SubHandle);
end;

function TevCustomNSRCWriter.NeedOutSub: Boolean;
begin
 Result := True;
end;

procedure TevCustomNSRCWriter.OutStyle4Cell;
begin

end;

procedure TevCustomNSRCWriter.SetExternalDocHandle(anID: Integer);
begin
 f_ExternalDocHandle := anID;
end;

function TevCustomNSRCWriter.IsStyleEqual(aParaStyle,
  aSegmentStyle: Integer): Boolean;
begin
 Result := inherited IsStyleEqual(aParaStyle, aSegmentStyle);
 if not Result then
  if ((aParaStyle >= Low(TevStandardStyle)) and (aParaStyle <= High(TevStandardStyle))) and
     ((aSegmentStyle >= Low(TevStandardStyle)) and (aSegmentStyle <= High(TevStandardStyle))) then
   Result := NSRCBrackets[-aParaStyle] = NSRCBrackets[-aSegmentStyle];
end;
{$EndIf evdNeedNSRCWriter}

end.

