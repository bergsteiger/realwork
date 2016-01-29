//..........................................................................................................................................................................................................................................................
Unit evAutoBlock;
{* Автоматическая расстановка блоков в документе }

// $Id: evAutoBlock.pas,v 1.86 2015/05/07 10:50:00 dinishev Exp $

// $Log: evAutoBlock.pas,v $
// Revision 1.86  2015/05/07 10:50:00  dinishev
// {Requestlink:598614369}
//
// Revision 1.85  2015/02/17 08:59:44  dinishev
// {Requestlink:588810794}
//
// Revision 1.84  2015/02/02 12:41:44  dinishev
// Bug fix: разнес автопростановку блоков.
//
// Revision 1.83  2015/02/02 08:07:21  dinishev
// Обновление эталона.
//
// Revision 1.82  2015/01/30 11:18:13  dinishev
// {Requestlink:565841763}
//
// Revision 1.81  2014/04/21 11:45:02  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.80  2014/04/11 15:30:33  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.79  2014/04/08 14:16:57  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.78  2014/04/07 06:02:18  dinishev
// Bug fix: не компилировались проекты.
//
// Revision 1.77  2014/03/28 12:15:24  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.76  2014/03/18 15:57:01  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.75  2014/03/13 09:47:26  dinishev
// Вспомнил про FillChar.
//
// Revision 1.74  2014/03/04 13:16:51  lulin
// - переводим идентификаторы Sub'ов и сегментов на нормальные Enum'ы.
//
// Revision 1.73  2014/01/23 09:02:13  dinishev
// Чистка кода.
//
// Revision 1.72  2014/01/23 08:41:19  dinishev
// {Requestlink:513876130}. Выкинул Шурину отладочную переменную.
//
// Revision 1.71  2014/01/23 08:36:00  dinishev
// {Requestlink:513876130}. Честно выдаем сообщение об ошибке.
//
// Revision 1.70  2013/10/21 17:31:01  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.69  2013/10/21 15:43:00  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.68  2013/10/21 10:30:44  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.67  2013/04/19 13:05:40  lulin
// - портируем.
//
// Revision 1.66  2013/04/12 11:45:04  lulin
// - Дима Инишев поправил падения в тестах.
//
// Revision 1.65  2013/04/11 16:45:17  lulin
// - отлаживаем под XE3.
//
// Revision 1.64  2013/04/11 11:49:37  dinishev
// {Requestlink:449024991}
//
// Revision 1.63  2012/08/22 12:45:16  dinishev
// {Requestlink:382408222}
//
// Revision 1.62  2012/08/22 11:34:32  dinishev
// Новые скриптовые слова для RadioGroup
//
// Revision 1.61  2012/08/15 12:47:20  narry
// Разбивка и формулы (382408375)
//
// Revision 1.60  2012/08/15 10:25:08  narry
// Игнорирование названия блока (382408687)
//
// Revision 1.59  2012/08/10 14:25:05  lulin
// - bug fix: не собирались библиотеки.
//
// Revision 1.58  2012/08/10 09:45:54  dinishev
// {Requestlink:382408648}. Тест.
//
// Revision 1.57  2012/06/28 08:29:31  narry
// Архивариус ставит номера блоков больше, чем поддерживает компилятор (372649129)
//
// Revision 1.56  2011/11/22 11:52:26  narry
// Авторасстановка блоков. Неправильно проставляются имена блоков (300028708)
//
// Revision 1.55  2011/11/09 09:33:43  dinishev
// {Requestlink:297698187}
//
// Revision 1.54  2011/10/31 08:10:38  narry
// Открутить вычисление ID блока по тексту (главы, пункты и тд) (296099215)
//
// Revision 1.53  2011/05/19 12:18:01  lulin
// {RequestLink:266409354}.
//
// Revision 1.52  2010/12/14 12:30:42  narry
// K247300520. Левая часть подписи выдергивается в блок
//
// Revision 1.51  2010/12/13 14:26:54  lulin
// {RequestLink:246939696}.
//
// Revision 1.50  2010/12/13 10:44:39  lulin
// {RequestLink:245761265}.
//
// Revision 1.49  2010/12/13 08:48:42  narry
// K172363407. Расстановка блоков на пункты со скобками
//
// Revision 1.48  2010/12/10 18:28:09  lulin
// {RequestLink:245761273}.
//
// Revision 1.47  2010/12/10 17:58:11  lulin
// {RequestLink:245761273}.
//
// Revision 1.46  2010/07/14 10:12:26  dinishev
// [$210436837]
//
// Revision 1.45  2010/02/24 18:22:22  lulin
// - избавляемся от ненужного и вредного параметра, доставшегося в наследство от ошибок молодости.
//
// Revision 1.44  2009/07/23 13:42:15  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.43  2009/07/14 14:56:35  lulin
// {RequestLink:141264340}. №25.
//
// Revision 1.42  2009/07/13 12:31:42  lulin
// {RequestLink:141264340}. №23ac.
//
// Revision 1.41  2009/07/11 15:55:13  lulin
// {RequestLink:141264340}. №22.
//
// Revision 1.40  2009/06/25 12:57:35  lulin
// - вычищаем ненужный контекст.
//
// Revision 1.39  2009/06/23 08:04:54  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.38  2009/04/01 11:45:34  lulin
// [$141262980]. Вкладываем интерфейсы друг в друга. Утилиты переносим в отдельный модуль.
//
// Revision 1.37  2009/03/04 14:17:44  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.36  2008/11/11 11:09:25  lulin
// - <K>: 122672539.
//
// Revision 1.35  2008/10/01 11:13:31  lulin
// - <K>: 120718563.
//
// Revision 1.34  2008/09/10 15:35:18  lulin
// - <K>: 114950837.
//
// Revision 1.33  2008/09/10 13:07:19  narry
// - уменьшение константы максимального номера блока
//
// Revision 1.32  2008/06/20 14:48:57  lulin
// - используем префиксы элементов.
//
// Revision 1.31  2008/06/11 10:48:03  narry
// - поддержка стиля  Заголовок приложения
//
// Revision 1.30  2008/06/09 12:19:05  dinishev
// <K> : 93263280
//
// Revision 1.29  2008/05/28 13:53:00  voba
// - bug fix от Шуры : не собиралось после исправления CQ 29146
//
// Revision 1.28  2008/05/20 12:03:57  lulin
// - <K>: 90448469.
//
// Revision 1.27  2008/04/17 15:15:07  narry
// - блокиратор распознает буквы вначале абзаца и нумерацию до шестого уровня включительно
//
// Revision 1.26  2008/04/15 08:23:51  lulin
// - передаём вью в качестве параметра.
//
// Revision 1.25  2008/04/11 12:01:33  lulin
// - <K>: 89100701.
//
// Revision 1.24  2008/04/11 11:30:01  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.23  2008/04/10 17:34:26  lulin
// - <K>: 89097983.
//
// Revision 1.22  2008/04/09 17:57:12  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.21  2008/04/09 11:20:26  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.20  2008/04/09 08:04:48  lulin
// - передаём вью в рамках <K>: 89096854.
// - не компилировался Архивариус.
//
// Revision 1.19  2008/03/26 17:17:51  lulin
// - cleanup.
//
// Revision 1.18  2008/02/14 09:40:25  lulin
// - удалён ненужный класс.
//
// Revision 1.17  2008/02/13 20:20:02  lulin
// - <TDN>: 73.
//
// Revision 1.16  2008/02/06 15:36:54  lulin
// - каждому базовому объекту по собственному модулю.
//
// Revision 1.15  2008/02/05 09:57:40  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.14  2008/02/01 15:14:31  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.13  2007/12/26 14:10:31  lulin
// - модуль l3Interfaces полностью переведен на модель.
//
// Revision 1.12  2007/12/24 15:25:24  lulin
// - удалены ненужные файлы.
//
// Revision 1.11  2007/12/04 12:47:41  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.1.2.11  2007/09/14 13:26:11  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.1.2.10.2.1  2007/09/12 19:13:21  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.1.2.10  2007/08/14 19:31:32  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.1.2.9  2007/08/02 16:08:48  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.1.2.8  2007/03/27 07:42:54  dinishev
// Bug fix: не собирался Everest в ветке
//
// Revision 1.1.2.7  2007/01/19 16:21:10  dinishev
// Bug fix: Everest в ветке не компилировался
//
// Revision 1.1.2.6  2006/12/21 10:25:54  oman
// - fix: При выделении точки (nevSelection._SelectPoint) сбрасываем
//  выделение, если оно не постоянно и выбираемая точка в него не
//  попадает (cq23931)
//
// Revision 1.1.2.5  2006/11/23 10:45:14  dinishev
// Bug fix: не компилировался Everest
//
// Revision 1.1.2.4  2006/10/20 14:51:38  dinishev
// Cleanup - убрана ненужная ссылка IevRange
//
// Revision 1.1.2.3  2006/10/12 15:40:03  lulin
// - bug fix: не компилировался проект Эверест.
//
// Revision 1.1.2.2  2006/02/08 14:08:28  lulin
// - собрал EverestLite в ветке.
//
// Revision 1.1.2.1  2006/02/08 11:50:26  lulin
// - утилитные файлы для Эвереста переехали в ветку.
//
// Revision 1.125.16.1  2006/02/07 15:16:28  lulin
// - попытка доточить под ветку (пока неудачно).
//
// Revision 1.125  2005/05/31 08:14:23  lulin
// - bug fix: не компилировалось.
//
// Revision 1.124  2005/05/20 11:52:33  lulin
// - bug fix: был AV при разбивке на блоки.
//
// Revision 1.123  2005/05/20 11:27:39  lulin
// - класс TevBlock вынесен в отдельный модуль.
//
// Revision 1.122  2005/05/19 14:43:56  lulin
// - от объектов переходим к интерфейсам.
//
// Revision 1.121  2005/05/19 13:18:51  lulin
// - remove unit: evFont.
//
// Revision 1.120  2005/05/16 16:26:41  lulin
// - реструктурированы интерфейсы.
//
// Revision 1.119  2005/05/16 15:31:16  lulin
// - cleanup: прямое использование объекта заменено на использование интерфейса.
//
// Revision 1.118  2005/05/16 11:42:12  lulin
// - cleanup: прямое использование объекта заменено на использование интерфейса.
//
// Revision 1.117  2005/04/28 15:04:04  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.116.2.1  2005/04/25 14:05:02  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.116  2005/04/21 05:11:45  lulin
// - используем _Box (пока из-за постоянных преобразований туда и обратно - по скорости стало только хуже).
//
// Revision 1.115  2005/04/19 15:41:42  lulin
// - переходим на "правильный" ProcessMessages.
//
// Revision 1.114  2005/04/08 15:10:33  narry
// - update: учет "пишки"
//
// Revision 1.113  2005/03/28 11:32:17  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.112  2005/03/16 12:17:00  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.111  2005/03/11 16:26:44  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.110  2005/03/11 11:43:53  lulin
// - bug fix: не компилировалось.
//
// Revision 1.109  2005/02/16 17:10:41  narry
// - update: Delphi 2005
//
// Revision 1.108  2004/12/23 11:13:42  lulin
// - rename prop: TvtCustomOutliner.TreeSource -> TreeStruct.
//
// Revision 1.107  2004/12/07 10:18:05  narry
// - bug fix: редактирование структуры разрушало структуру
//
// Revision 1.106  2004/11/25 07:37:45  lulin
// - new unit: TevCustomEditor.
//
// Revision 1.105  2004/10/08 13:35:56  narry
// - bug fix: не распознавалась статья, на которой стояла ссылка
//
// Revision 1.104  2004/09/21 12:21:04  lulin
// - Release заменил на Cleanup.
//
// Revision 1.103  2004/08/30 13:21:59  narry
// - bug fix: range check при формировании номера блока
//
// Revision 1.102  2004/07/01 12:51:25  narry
// - bug fix: Floating point overflow
//
// Revision 1.101  2004/06/22 12:43:53  law
// - new behavior: поиск теперь использует IevTagSelection, а не TevBlock.
//
// Revision 1.100  2004/06/18 11:10:41  narry
// - bug fix: неосвобожденные объекты
//
// Revision 1.99  2004/06/17 15:38:26  narry
// -cleanup
//
// Revision 1.98  2004/06/17 08:22:28  law
// - bug fix: в одной ветке забыли присвоить Result.
//
// Revision 1.97  2004/06/11 07:54:21  narry
// - update: замена веткой Switch_for_l3Tree
//
// Revision 1.93.2.6  2004/06/11 07:44:36  narry
// - update: перед слиянием с основной веткой
//
// Revision 1.93.2.5  2004/06/09 08:04:07  narry
// - update: обработка сносок, отработка Ctrl-Click
//
// Revision 1.93.2.4  2004/06/03 12:27:10  narry
// - update: новая идеология окна конфигурации
//
// Revision 1.93.2.3  2004/05/28 14:57:55  narry
// - update: не работает
//
// Revision 1.93.2.2  2004/05/21 15:06:02  narry
// - update: комплируется, почти работает правильно
//
// Revision 1.93.2.1  2004/05/21 13:01:13  narry
// - update: комплируется, но работает неправильно
//
// Revision 1.93  2004/05/20 11:38:18  narry
// - update
//
// Revision 1.92  2004/05/06 17:02:36  law
// - cleanup: у _ReplaceFunc удален ненужный и непонятный параметр Sender.
//
// Revision 1.91  2004/05/05 12:52:42  law
// - rename method: TevBaseSearcher.Search -> TevBaseSearcher.DoCheckText.
//
// Revision 1.90  2004/05/05 12:32:37  law
// - rename method: TevBaseSearcher.CheckEx -> TevBaseSearcher.DoCheck.
//
// Revision 1.89  2004/03/10 14:24:17  narry
// - bug fix: неправильно формировалось имя для блоков на нумерованных абзацах
//
// Revision 1.88  2004/03/10 14:02:32  narry
// - bug fix: неправильно разбивался документ с пустой левой частью в подписи
//
// Revision 1.87  2004/01/15 11:17:30  narry
// - update: ограничение максимальной глубины вложенности блоков - 9 уровней
//
// Revision 1.86  2004/01/15 10:38:20  narry
// - bug fix: деление на ноль
//
// Revision 1.85  2004/01/09 14:30:37  narry
// - bug fix: пропал запрос на подтверждение спорных блоков
//
// Revision 1.84  2003/12/01 15:20:34  narry
// - cleanup
// - bug fix: Integer overflow при формировании номера блока глубокой вложенности
// -change: переименование пункта "Произвольно" в "Больше пяти уровней" и перенос его в конец списка
//
// Revision 1.83  2003/11/28 14:11:11  law
// - new unit: evSegmentsListConst.
//
// Revision 1.82  2003/11/19 15:44:14  narry
// - bug fix: AV при перемещении узла на место удаленного
// - add: операции с несколькими выделенными узлами
//
// Revision 1.81  2003/11/10 13:08:49  narry
// - bug fix: разбиение документа, содержащего блоки
//
// Revision 1.80  2003/11/05 12:20:32  narry
// - bug fix and update
//
// Revision 1.79  2003/11/03 17:29:55  law
// - bug fix: убрал Abort, который забыл убрать Narry.
//
// Revision 1.78  2003/11/03 17:16:11  narry
// - bug fix: неверно разбивался документ, содержащий в себе блоки и пустые абзацы между последним блоком и подписью
//
// Revision 1.77  2003/10/31 15:59:13  law
// - bug fix: неправильно разбивался на блоки документ с уже стоящими блоками.
//
// Revision 1.76  2003/10/24 10:43:47  narry
// - bug fix: Примечания поглощали все блоки до конца документа
//
// Revision 1.75  2003/10/20 12:32:09  narry
// - новая версия автомата разбивки на блоки
//
// Revision 1.71.2.9  2003/10/20 07:12:54  narry
// - update
//
// Revision 1.71.2.8  2003/10/15 11:13:02  narry
// RC - изменение механизма нумерации блоков
//
// Revision 1.71.2.7  2003/10/06 10:12:06  narry
// - change: переименование модуля evBseCur в evBaseCursor
//
// Revision 1.71.2.6  2003/09/26 14:04:12  narry
// - update
//
// Revision 1.71.2.5  2003/09/24 15:29:49  narry
// - update
//
// Revision 1.71.2.4  2003/06/19 15:43:00  narry
// - update: совершенствование настройки дерева блоков документа
//
// Revision 1.71.2.3  2003/06/18 13:58:10  narry
// - update:
//
// Revision 1.71.2.2  2003/06/04 15:40:52  narry
// - not work: съезжают границы блоков, не у всех блоков есть имена
//
// Revision 1.71.2.1  2003/06/04 11:59:51  narry
// - cleanup
//
// Revision 1.71  2003/05/05 09:22:03  narry
// - add: в качестве комментария рассматривется Информация о версии, Тех. комментарий и Польз. комментарий
//
// Revision 1.70  2003/04/19 12:30:36  law
// - new file: ddDefine.inc.
//
// Revision 1.69  2003/02/25 15:41:46  narry
// - bug fix: приложения вкладывались друг в друга
//
// Revision 1.68  2003/02/18 12:41:20  narry
// - bug fix: подпись с пустой левой частью не распознавалась как подпись
//
// Revision 1.67  2003/02/14 11:25:25  narry
// - new behavior: отключение выделения сносок в отдельный блок
//
// Revision 1.66  2003/02/13 13:59:34  narry
// - bug fix: неверно определялись границы сносок
//
// Revision 1.65  2003/02/05 11:07:33  narry
// - bug fix
//
// Revision 1.64  2003/02/05 09:43:32  narry
// - update: распознавание неоформленной подписи, вложенность приложений
//
// Revision 1.63  2003/02/05 09:22:33  narry
// - new behavior: запрет поиска в таблицах
//
// Revision 1.62  2003/02/05 08:44:38  narry
// - update: изменение типа TddBlockType с Integer на набор, определение неоформленной подписи
//
// Revision 1.61  2002/12/27 13:34:55  narry
// - bug fix: комментарий между началом приложения и его заголовком порождал лишний блок
//
// Revision 1.60  2002/12/26 10:17:44  narry
// - bug fix: пробел в конце абзаца сбивал определение статьи
//
// Revision 1.59  2002/12/25 12:32:12  narry
// - bug fix & update
//
// Revision 1.58  2002/12/23 12:26:47  narry
// - bug fix: название приложения порождало дополнительный блок
//
// Revision 1.57  2002/12/23 12:04:23  narry
// - bug fix: не учитывалась метка на пустом абзаце перед двумя и более абзацами с комментариями
//
// Revision 1.56  2002/12/20 15:18:40  law
// - new param: TevSearchToo.Finish - aBlock.
//
// Revision 1.55  2002/12/20 14:03:31  narry
// - new behavior: подтверждение слияния идущих друг за другом заголовков
//
// Revision 1.54  2002/12/20 13:44:43  law
// - new param: TevSearchToo.Finish - aCancel.
//
// Revision 1.53  2002/12/15 13:35:51  narry
// - update
//
// Revision 1.52  2002/12/06 16:24:33  narry
// - bug fix & update
//
// Revision 1.51  2002/12/05 12:01:17  law
// - bug fix: не компилировалось при включенной директиве evNotArchi.
//
// Revision 1.50  2002/12/04 13:31:39  narry
// - bug fix & update
//
// Revision 1.49  2002/12/04 10:32:16  narry
// - cleanup
//
// Revision 1.48  2002/12/04 10:22:57  narry
// - new behavior: сноски попадают в блок первого уровня, а не сосздают такой блок сами
//
// Revision 1.47  2002/12/03 15:27:53  narry
// - bug fix: более жесткая проверка блока "Вопрос-ответ"
//
// Revision 1.46  2002/12/03 10:26:22  narry
// - update: передача номера семейства и номера документа в процедуру расстановки блоков
//
// Revision 1.45  2002/12/02 15:27:37  narry
// - bug fix & update: комментарии, разделенные пустыми строками и многое другое
//
// Revision 1.44  2002/11/28 12:11:36  narry
// - update
//
// Revision 1.43  2002/11/27 08:38:31  narry
// - update
//
// Revision 1.42  2002/11/26 16:28:32  narry
// - update
//
// Revision 1.41  2002/11/21 14:24:00  narry
// - bug fix: стиль "Утративший силу" у нумерованных абзацев порождал лишний блок
//
// Revision 1.40  2002/11/21 12:39:48  narry
// - bug fix: Документ, состоящий только из Приложения теряет блок первого уровня
//
// Revision 1.39  2002/11/19 15:59:14  narry
// - new behavior: двухуровневые пункты
//
// Revision 1.38  2002/11/19 13:53:32  narry
// - bug fix: подписи в основном докумнте, части документа, оформленные стилем "Утратил силу"
//
// Revision 1.37  2002/11/19 10:19:15  narry
// - bug fix: наличие цветного выделения в нумерованном абзаце порождало появление дополнительного блока
//
// Revision 1.36  2002/11/19 08:26:07  narry
// - bug fix: неправильно учитывался заданный пользователем уровень вложенности
//
// Revision 1.35  2002/11/15 16:18:36  narry
// - update
//
// Revision 1.34  2002/11/15 15:38:11  narry
// - bug fix
//
// Revision 1.33  2002/11/14 16:24:48  narry
// - bug fix & update
//
// Revision 1.32  2002/11/13 12:58:01  narry
// - new behavior: существующие в документе блоки пропускаются при анализе
//
// Revision 1.31  2002/11/13 10:23:47  narry
// - update: обработка сложных Приложений
//
// Revision 1.30  2002/11/13 09:56:37  narry
// - bug fix: пропало разбиение на пункты
//
// Revision 1.29  2002/11/13 08:51:56  narry
// - bug fix
//
// Revision 1.28  2002/11/12 10:46:59  narry
// - bug fix: текст на одной строке с Приложением не позволяет распознать приложение
//
// Revision 1.27  2002/11/12 09:38:51  narry
// - bug fix: комментарий, состоящий из нескольких абзацев считался несколькими комментариями
//
// Revision 1.26  2002/11/11 14:54:23  narry
// - bug fix: Приложение, начинающееся без подписи нарушает структуру блоков
//
// Revision 1.25  2002/11/11 11:58:14  law
// - remove prop: TevStyleSearcher.WholeParaOnly.
// - new prop: TevStyleSearcher.SearchPlace.
//
// Revision 1.24  2002/11/11 11:28:27  narry
// - bug fix: теряются приложения, заголовки которых содержат ссылки
//
// Revision 1.23  2002/11/06 14:40:00  narry
// - update
//
// Revision 1.22  2002/11/04 16:00:52  narry
// - bug fix
//
// Revision 1.21  2002/10/31 12:06:58  narry
// - new behavior: оглавление остается в блоке первого уровня или в приложении, если это подоглавление
//
// Revision 1.20  2002/10/31 09:40:34  narry
// - update: сохраняются существующие блоки Приложений, перед которыми стоит комментари про ObjTopic
//
// Revision 1.19  2002/10/30 16:28:28  narry
// - bug fix: заголовок приложения отрывается от содержимого. Update: корректно отрабатывается составное приложние
//
// Revision 1.18  2002/10/30 12:47:26  narry
// - bug fix: пропадает первый блок в приложении
//
// Revision 1.17  2002/10/29 17:04:12  narry
// - new behavior: начало обработки комментариев на границах блоков
//
// Revision 1.16  2002/10/29 15:21:59  narry
// - bug fix & update
//
// Revision 1.15  2002/10/28 16:39:51  narry
// - bug fix & update
//
// Revision 1.14  2002/10/23 10:48:53  narry
// - bug fix: нумерованные абзацы нарушают структуру вложенности
//
// Revision 1.13  2002/10/22 12:44:23  narry
// - new behavior: расстановка блоков на заданный уровень вложенности
//
// Revision 1.12  2002/10/22 11:27:25  narry
// - update: Составные номера (5.1) не являются началом блока
//
// Revision 1.11  2002/10/15 06:49:36  narry
// - update: обновление информации о метках после расстановки блоков
//
// Revision 1.10  2002/10/10 13:58:53  narry
// - new behavior: вместо целой преамбулы будет разритая на пункты
//
// Revision 1.9  2002/10/09 07:47:32  narry
// - update: возврат преамбулы и "всего документа"
//
// Revision 1.8  2002/10/08 14:26:07  narry
// - bug fix & update: подпись порождала неправильный блок, отключено создание преамбулы
//
// Revision 1.7  2002/10/08 08:34:11  narry
// - update: корректная обработка подписи
//
// Revision 1.6  2002/10/04 12:41:44  narry
// - update: реализация проверки на уникальность номеров блоков
//
// Revision 1.5  2002/10/03 16:23:42  narry
// - update: первый вариант реализации алгоритма нумерации блоков. Без проверки уникальности номеров
//
// Revision 1.4  2002/10/01 13:08:13  narry
// - update
//
// Revision 1.3  2002/09/19 13:09:15  narry
// - remove unit: ddHTML.
//
// Revision 1.2  2002/09/17 12:29:43  narry
// - update
//
// Revision 1.1  2002/09/13 14:52:16  narry
// - new unit: классы для автоматической расстановки блоков в документе
//

{$Include ddDefine.inc }

{$DEFINE FloatPointNumbers} // Дробные номера пунктов
{.$DEFINE StopBlocks}
interface

Uses
 l3Base, l3Types, l3Nodes, l3Tree_TLB,
 l3ProtoObject,
 l3ProtoObjectRefList,
 l3Interfaces,
 k2Interfaces,
 evCustomEditor, evSearch, evTextSource, evInternalInterfaces,
 evCustomTextSource,

 nevTools,
 
 {$IFNDEF evNotArchi}
 dt_Types,
 {$ENDIF}
 evTuneBlocksDlg,
 Classes,
 l3ObjectRefList
 , DT_Const;

type
 TddCommentBlock = (dd_cbNone, dd_cbSub, dd_cbBlock, dd_cbOutSide);
 TddBlockType = (
  dd_btNone,             // обычный абзац
  { Основные блоки }
  dd_btPart,              // часть
  dd_btSection,           // раздел
  dd_btSubSection,        // подраздел
  dd_btChapter,           // глава
  dd_btReport,            // протокол
  dd_btRegulations,       // регламент
  dd_btIndex,             // перечень
  dd_btArticleChapter,    // статья
  { Дополнительные блоки }
  dd_btTitle,             // название документа
  dd_btArticle,           // статья
  dd_btPreamble,          // преамбула
  dd_btAppendix,          // приложение
  dd_btHeader1,           // просто заголовок
  dd_btParagraphArabic,   // пункт с арабской нумерацией X.
  dd_btParagraphRoman,    // пункт с римской нумерацией  X.
  dd_btDocument,          // Документ от преамбулы до конца
  dd_btSBS,               // подпись - конец блока
  dd_btRemark,            // Примечание - до конца текущего блока не ставить пункты
  dd_btPseudoDocument,    // Приложение без номера
  dd_btComment,           // Встретился комментарий - закрывает пункты
  dd_btSubAppendix,       // Часть приложения
  dd_btContentTable,      // Оглавление - закрывает пункты
  dd_btSectionArabic,     // Арабские цифры
  dd_btSectionRoman,      // Римские цифры
  dd_btSectionLatin,      // Латинские буквы
  dd_btSectionCyr,        // Русские буквы
  dd_btSubSectionArabic,  // подраздел
  dd_btStartFootnote,     // горизонтальная линия (по ней запоминается курсор)
  dd_btFootnoteBody,      // тело сноски
  dd_btAskReply,          // Вопрос-ответ
  dd_btSubOnEmpty,        // метка на пустом абзаце для использования с комментарием
  dd_btAppendixOrHeader1, // либо Приложение, либо Заголовок
  dd_btMayBeSBS,          // Спорная подпись
  dd_btParagraphSign,     // Символ абзаца
  dd_btParagraphXX,       // пункт с арабской нумерацией X.X.
  dd_btParagraphXXX,      // пункт с арабской нумерацией X.X.X.
  dd_btParagraphXXXX,     // пункт с арабской нумерацией X.X.X.X.
  dd_btParagraphXXXXX,    // пункт с арабской нумерацией X.X.X.X.X.
  dd_btParagraphXXXXXX,   // пункт с арабской нумерацией X.X.X.X.X.X.
  dd_btParagraphLatin,    // Латинские буквы
  dd_btParagraphCyr,      // Русские буквы
  dd_btParagraphBracket   // пункт со скобкой
  );

  IddBlockInfo = interface(IUnknown)
  ['{96BDB37D-FAEC-45F3-B530-81B0AFEF1CDF}']
    procedure AdjustBorders;
    procedure AdjustFinish(const aFinish: InevBasePoint);
    function GetBlockName: AnsiString;
    function GetBlockType: TddBlockType;
    function GetClosed: Boolean;
    function GetFinish: InevBasePoint;
    function GetNumber: Integer;
    function GetRealType: TddCommentBlock;
    function GetStart: InevBasePoint;
    function GetVisible: Boolean;
    function GetWasBlock: Boolean;
    procedure SetBlockName(Value: AnsiString);
    procedure SetBlockType(Value: TddBlockType);
    procedure SetClosed(Value: Boolean);
    procedure SetFinish(const Value: InevBasePoint);
    procedure SetNumber(Value: Integer);
    procedure SetRealType(Value: TddCommentBlock);
    procedure SetStart(const Value: InevBasePoint);
    procedure SetVisible(const Value: Boolean);
    procedure SetWasBlock(Value: Boolean);
    function CloneFinish: InevBasePoint;
    property BlockName: AnsiString read GetBlockName write SetBlockName;
    property BlockType: TddBlockType read GetBlockType write SetBlockType;
    property Closed: Boolean read GetClosed write SetClosed;
    property Finish: InevBasePoint read GetFinish write SetFinish;
    property Number: Integer read GetNumber write SetNumber;
    property RealType: TddCommentBlock read GetRealType write SetRealType;
    property Start: InevBasePoint read GetStart write SetStart;
    property Visible: Boolean read GetVisible write SetVisible;
    property WasBlock: Boolean read GetWasBlock write SetWasBlock;
  end;

  TddBlockInfo = class(Tl3UsualNode, IddBlockInfo)
  private
   FBlockName: AnsiString;
   FBlockType: TddBlockType;
   FClosed: Boolean;
   FFinish: InevBasePoint;
   FNumber: Integer;
   FRealType: TddCommentBlock;
   FStart: InevBasePoint;
   FVisible: Boolean;
   FWasBlock: Boolean;
   f_IsReal: TddCommentBlock;
   f_Editor : TevCustomEditor;
    function CloneFinish: InevBasePoint;
   function GetBlockName: AnsiString;
   function GetBlockType: TddBlockType;
   function GetClosed: Boolean;
   function GetFinish: InevBasePoint;
   function GetNumber: Integer;
   function GetRealType: TddCommentBlock;
   function GetStart: InevBasePoint;
   function GetVisible: Boolean;
   function GetWasBlock: Boolean;
   procedure SetBlockName(Value: AnsiString);
   procedure SetBlockType(Value: TddBlockType);
   procedure SetClosed(Value: Boolean);
   procedure SetFinish(const Value: InevBasePoint);
   procedure SetNumber(Value: Integer);
   procedure SetRealType(Value: TddCommentBlock);
   procedure SetStart(const Value: InevBasePoint);
   procedure SetVisible(const Value: Boolean);
   procedure SetWasBlock(Value: Boolean);
  protected
   procedure Cleanup; override;
  public
   constructor Create(anEditor : TevCustomEditor);
   procedure AdjustBorders;
   procedure AdjustFinish(const aFinish: InevBasePoint);
   procedure Assign(P: TPersistent); override;
   procedure Clear; override;
   function HasBlockWithNumber(aNumber: Integer): Boolean;
   function UniqueNumber(aNumber: Longint): Boolean;
   property BlockName: AnsiString read GetBlockName write SetBlockName;
   property BlockType: TddBlockType read GetBlockType write SetBlockType;
   property Closed: Boolean read GetClosed write SetClosed;
   property Finish: InevBasePoint read GetFinish write SetFinish;
   property Number: Integer read GetNumber write SetNumber;
   property RealType: TddCommentBlock read GetRealType write SetRealType;
   property Start: InevBasePoint read GetStart write SetStart;
   property Visible: Boolean read GetVisible write SetVisible;
   property WasBlock: Boolean read GetWasBlock write SetWasBlock;
  end;

  TddBlockID = class(Tl3ProtoObject)
  private
  f_BlockType: TddBlockType;
  f_IDName: ShortString;
  public
  property BlockType: TddBlockType
   read f_BlockType
   write f_BlockType;
  property IDName: ShortString
   read f_IDName
   write f_IDName;
  end;

 TddBlockNotify = procedure (const WasText : Boolean;
                             const Cursor  : InevBasePoint = nil) of object;

  TddBlockStructureSearcher = class(TevStyleSearcher)
  private
  f_ArticleNumber    : Longint;
  f_BlockIDList      : Tl3ProtoObjectRefList;
  f_BlockName        : ShortString;
  f_BlockText        : AnsiString;
  f_BlockType        : TddBlockType;
  f_CommentText      : Tl3String;
  f_FirstHeaderFound : Boolean;
  f_FromStartDocument: Boolean;
  f_OnNotFound       : TddBlockNotify;
  f_PreambleFound    : Byte;
  f_PrevBlockType    : TddBlockType;
  f_SBSFound         : Boolean;
  f_SBSIndex         : Byte;
  f_SearchParagraphs : Boolean;
  f_WaitForFootnote  : Boolean;
  protected
  procedure AddID(const aName: ShortString; aBlockID: TddBlockType);
  function CheckColorSelection(aStyle: Long; Sender : Tl3Variant; S :
      Tl3CustomString; const aSel  : TevPair; aText : AnsiString; out theSel  :
      TevPair): Bool;
  function CheckComment(Sender : Tl3Variant; S: Tl3CustomString; aSel:
      TevPair; out theSel: TevPair): Bool;
  function CheckContentTable(Sender : Tl3Variant; S: Tl3CustomString; aSel:
      TevPair; out theSel: TevPair): Bool;
  function CheckDigits(aText: Tl3CustomString; var Num: Integer): TddBlockType;
  function CheckFootnote(Sender : Tl3Variant; S: Tl3CustomString; aSel:
      TevPair; out theSel: TevPair): Bool;
  function CheckHeader(Sender : Tl3Variant; S: Tl3CustomString; aSel: TevPair;
      const aText: AnsiString; out theSel: TevPair): Bool;
  function CheckParagraph(Sender : Tl3Variant; S: Tl3CustomString; aSel:
      TevPair; out theSel: TevPair): Bool;
  procedure InitBlockIDList;
  procedure MakeBlockName(const aSt: AnsiString);
  procedure Cleanup; override;
  public
  constructor Create(aOwner: TevSearchToolOwner); override;
  function DoCheck(const aView : InevView;
                   const aTag        : InevObject;
                   const aStart      : InevBasePoint;
                   const aFinish     : InevBasePoint;
                   const aStartPrev  : InevBasePoint;
                   const aFinishPrev : InevBasePoint;
                   out theSel        : TevPair): Bool; override;
  function DoCheckText(Sender : Tl3Variant; S            : Tl3CustomString;
      const aSel  : TevPair; out theSel  : TevPair): Bool; override;
  procedure DoStart; override;
  property ArticleNumber: Integer
   read f_ArticleNumber;
  property BlockName: ShortString
   read f_BlockName;
  property BlockText: AnsiString
   read f_BlockText;
  property BlockType: TddBlockType
   read f_BlockType
   write f_BlockType;
  property CommentText      : Tl3String
   read f_CommentText;
  property FromStartDocument: Boolean
   read f_FromStartDocument
   write f_FromStartDocument;
  property OnNotFound       : TddBlockNotify
   read f_OnNotFound
   write f_OnNotFound;
  property PreambleFound    : Byte
   read f_PreambleFound;
  property SearchParagraphs: Boolean
   read f_SearchParagraphs
   write f_SearchParagraphs;
  end;

const
 MaxDeepLevel = 9;

type

 TddBlockStructureReplacer = class(TevBaseReplacer)
 private
  FDeepLevel: Integer;
  f_Searcher         : TddBlockStructureSearcher;
  f_BlockRoot        : TddBlockInfo;
  f_Current: Il3Node;
  f_Editor           : TevCustomEditor;
  f_FirstLevel       : TddBlockType;
  f_UniqueNumber     : Longint;
  f_FirstLevelIndex  : Integer;
  f_BlockNumbers     : Array[1..MaxDeepLevel] of Longint;
  f_ConfirmJoin      : Boolean;
  f_ConfirmSBSRes    : Word;
  f_ConfirmJoinRes   : Word;
  f_RemarkInBlock    : TddBlockType;
  f_FirstBlock       : Boolean;
  f_CommentStart     : InevBasePoint;
  f_CommentBlock     : TddCommentBlock;
  f_CommentGap       : Integer;
  f_TextAfterComment : Boolean;
  f_FootnoteCursor   : InevBasePoint;
  f_EmptyParaCursor  : InevBasePoint;
  f_WasText          : Boolean;
  f_WasEmpty         : Boolean;
  f_InAppendix       : Boolean;
  f_UseFootnotes     : Boolean;
  f_InsertedCount    : Integer;
  f_TuneBlocks       : Boolean;
  f_Dialog           : TddTuneBlocksDialog;
  f_AllDone          : Boolean;
  f_OldReadOnly      : Boolean;
  {$IFNDEF evNotARCHI}
  f_Family           : TFamilyID;
  f_DocID            : TDocID;
  {$ENDIF}
 private
  function CalcMaxLevel(const aNode: Il3Node): Integer;
  function IsEnableClose(aBlockType: TddBlockType;
                         var DeepLevel: Integer): Boolean;
  procedure InsertBlockInDocument(const aView : InevView;const BlockInfo: IddBlockInfo);
  function InsertBlock(const aBlockInfo: IddBlockInfo): Boolean;
  procedure _InsertBlock(const aView : InevView;const aBlock: Il3Node);
  procedure StartBlock(const aView : InevView;const aStart: InevBasePoint);
  function MakeBlockNumber(const aBlockInfo: IddBlockInfo): Longint;
  procedure ProcessComment(const aCursor: InevBasePoint);
  function GetTextSource: TevCustomTextSource;
  function CheckType(const aCursor: InevBasePoint; var aNumber: Longint): TddCommentBlock;
  procedure WhatNotFound(const aText: Boolean; const aCursor: InevBasePoint = nil);
  function LastBlock: IddBlockInfo;
  function _ReplaceConfirm(Sender       : TObject;
                           const aBlock : InevRange): ShortInt;
  procedure FinalTune(aInsert: Boolean);
  procedure OutBlockDescript;
  procedure CheckComment(const aStart: InevBasePoint);
  function CheckFootnote(const aStart: InevBasePoint): Boolean;
  function CheckEmptyPara(const aStart: InevBasePoint): Boolean;
  procedure CloseOpenBlocks(const aView : InevView;const aStart, aFinish: InevBasePoint; ForDeepLevel: Integer);
  procedure pm_SetEditor(aValue: TevCustomEditor);
 protected

  function  ReplaceFunc(const aView : InevView;
                        const Container : InevOp;
                        const aBlock    : InevRange): Bool; override;
  procedure Cleanup; override;
 public
  constructor Create(aOwner: TevSearchToolOwner); override;
  procedure DoStart; override;
  procedure DoFinish(aCancel: Bool; const aBlock: InevRange);
    override;
  function TuneBlockStructure: Boolean;
  procedure InsertBlockStructure;
 public
  property AllDone: Boolean
   read f_AllDone;
  property Searcher : TddBlockStructureSearcher
   read  f_Searcher
   write f_Searcher;
  property BlockRoot: TddBlockInfo
   read f_BlockRoot;
  property Editor: TevCustomEditor
   read f_Editor
   write pm_SetEditor;
  property TextSource: TevCustomTextSource
   read GetTextSource;
  property DeepLevel: Integer read FDeepLevel write FDeepLevel;
  property ConfirmJoin: Boolean // Подтверждать слияние блоков из заголовков
   read f_ConfirmJoin
   write f_ConfirmJoin;
  property UniqueNumber: Longint
    read f_UniqueNumber
    write f_UniqueNumber;
  property UseFootnotes: Boolean
   read f_UseFootnotes
   write f_UseFootnotes;
  property TuneBlocks: Boolean
   read f_TuneBlocks
   write f_TuneBlocks;
  {$IFNDEF evNotArchi}
  property Family: TFamilyID
   read f_Family
   write f_Family;
  property DocID: TDocID
   read f_DocID
   write f_DocID;
  {$ENDIF}
 end;

const
 ddMaxUniqueNumber = dt_Const.cMaxBlockID;//High(Longint) div 10;

 dd_btParagraphs = [dd_btParagraphArabic, dd_btParagraphRoman, dd_btParagraphLatin, dd_btParagraphCyr,
                    dd_btParagraphXX, dd_btParagraphXXX, dd_btParagraphXXXX,
                    dd_btParagraphXXXXX, dd_btParagraphXXXXXX, dd_btParagraphBracket];
 dd_btAppendixes = [dd_btAppendix];

 dd_btHighPriority = [dd_btAppendix, dd_btSBS];

 dd_btPoints =  dd_btParagraphs + [dd_btArticle];

procedure CreateBlockStructure(DocEditor: TevCustomEditor
                               {$IFNDEF evNotArchi};
                               aFamily: TFamilyID; aDocID: TDocID
                               {$EndIF  evNotArchi});

implementation

uses
 Controls,
 Dialogs,
 Forms,
 ComCtrls,

 Math,
 TypInfo,
 StrUtils,
 SysUtils,

 l3Variant,
 
 ddBlockDeepLevelDlg,

 evdTypes,
 evdStyles,

 evOp,
 evSegLst,
 evExcept,
 evEditorInterfaces,
 evCursorTools,
 evTypes,
 evCursorConst,
 evParaTools,
 evTableCellUtils,

 evFacadeSub,

 l3Chars,
 l3InterfacedComponent,
 l3TreeInterfaces,
 l3String,
 l3InterfacesMisc,
 l3Const,

 {$IfDef Nemesis}
 {$Else  Nemesis}
 vtDialogs,
 {$EndIf Nemesis}

 afwFacade,

 {$IFNDEF evNotArchi}
 dt_Hyper,
 dt_LinkServ,
 {$ENDIF}
 k2Tags,

 Block_Const,
 Document_Const,
 TextPara_Const,
 SBS_Const,
 Table_Const;

procedure CreateBlockStructure(DocEditor: TevCustomEditor
                               {$IFNDEF evNotArchi};
                               aFamily: TFamilyID; aDocID: TDocID
                               {$EndIF  evNotArchi});
var
 Searcher: TddBlockStructureSearcher;
 Replacer: TddBlockStructureReplacer;
 l_Cursor: InevBasePoint;
 l_DeepLevel: Byte;
 l_Confirm: Boolean;
 l_Footnotes: Boolean;
 l_TuneBlocks: Boolean;
 l_InBlock: Boolean;
begin
 if DocEditor.ReadOnly then
  Exit;

 with TddBlockDeepLevelDialog.Create(Application) do
 try
  if ShowModal = mrOk then
  begin
   l_DeepLevel:= comboDeepLevel.ItemIndex;
   l_Confirm:= checkConfirmJoin.Checked;
   l_Footnotes:= cbUseFootnotes.Checked;
   l_TuneBlocks:= cbTuneStructure.Checked;
  end//ShowModal = mrOk
  else
   l_DeepLevel:= 255;
 finally
  Free;
 end;//try..finally
 if l_DeepLevel <> 255 then
 begin
  l_InBlock:= DocEditor.InPara(k2_typBlock, k2_typDocument) and not DocEditor.HasSelection;
  Searcher:= TddBlockStructureSearcher.Create(nil);
  try
   Searcher.SearchParagraphs:= False;
   Searcher.Options:= Searcher.Options + [ev_soGlobal];
   if DocEditor.HasSelection then
    Searcher.Options:= Searcher.Options + [ev_soSelText];
   if l_InBlock then
    Searcher.Options:= Searcher.Options + [ev_soDocumentPart];
   Replacer:= TddBlockStructureReplacer.Create(nil);
   try
    Replacer.UniqueNumber:= Succ(DocEditor.Document.IntA[k2_tiMaxSubID]);
    Replacer.Options := Searcher.Options;
    if l_Confirm then
    begin
     Replacer.Options := Replacer.Options + [ev_soConfirm];
     Searcher.Options := Searcher.Options + [ev_soConfirm];
    end; // l_Confirm
    Replacer.Searcher:= Searcher;
    Replacer.Editor:= DocEditor;
    Inc(l_DeepLevel);
    if l_DeepLevel = 6 then
     l_DeepLevel:= MaxDeepLevel;
    Replacer.DeepLevel:= l_DeepLevel;
    Replacer.ConfirmJoin:= l_Confirm;
    Replacer.UseFootnotes:= l_Footnotes;
    Replacer.TuneBlocks:= l_TuneBlocks;
    {$IFNDEF evNotArchi}
    Replacer.Family:= aFamily;
    Replacer.DocID := aDocID;
    {$ENDIF}
    with DocEditor do
    begin
     try
      if HasSelection then
       l_Cursor := Selection.Start.ClonePoint(DocEditor.View)
      else
       l_Cursor := Selection.Cursor.ClonePoint(DocEditor.View);
      Searcher.FromStartDocument:= Selection.Cursor.TopParentPoint.Position = 1;
      try
       Find(Searcher, Replacer, Searcher.Options);
       if Replacer.BlockRoot.Child <> nil then
       begin
        Replacer.TuneBLockStructure;
        while not Replacer.AllDone do
         afw.ProcessMessages;
       end
       else
        {$IfNDef nsTest}
        MessageDlg('Структура блоков в документе не найдена', mtInformation, [mbOk], 0)
        {$EndIf  nsTest}
        ;
      except
       {$IfDef nsTest}
       on EevSearchFailed do
        ;
       else
        raise;
       {$Else  nsTest}
       on EevSearchFailed do
        MessageDlg('Структура блоков в документе не найдена', mtInformation, [mbOk], 0);
       else
        MessageDlg('Возникла непредвиденная ошибка при расстановке блоков!', mtError, [mbOk], 0);
       {$EndIf nsTest}
      end;//try..ecxept
      InevSelection(Selection).SelectPoint(l_Cursor, false);
      // <STUB> не понятно зачем Selection.SelectPoint сам снимает выделение
      // с учетом его постоянности и попадания каретки в выделение
      InevSelection(Selection).UnSelect;
     finally
      l_Cursor := nil;
     end;
    end
   finally
    l3Free(Replacer);
   end;
  finally
   l3FRee(Searcher);
  end;
  { Структура создана. Нужно проанализировать получившееся:
     - сравнить оглавление и структуру блоков }
 end; // l_DeepLevel <> 255
end;

function ddMovePBC(const aView : InevView;
                   const aCursor : InevBasePoint;
                   anOp          : Long): Bool;
  //overload;
  {* - перемещает курсор. }
begin
 if (aCursor = nil) then
  Result := false
 else
  if aCursor.MostInner.ParentPoint = nil then
   Result := false
  else
   Result := aCursor.MostInner.ParentPoint.Move(aView, anOp);
end;

function AtomHasSub(const Atom: InevObject): Boolean;
var
 l_Cursor : InevBasePoint;
 l_Sub    : IevSub;
begin
 l_Cursor := Atom.MakePoint;
 try
  Result:= Supports(l_Cursor, IevSub, l_Sub) and l_Sub.Exists;
  l_Sub:= nil;
 finally
  l_Cursor := nil;
 end;//try..finally
end;

function EnableAppendix(Atom: Tl3Variant): Boolean;
begin
 if Atom.IsKindOf(k2_typTextPara) then
 begin
   with Atom.Attr[k2_tiStyle] do
    if IsValid and (AsLong = ev_saTxtNormalANSI) then
    begin
     with Atom.Attr[k2_tiJustification] do
      Result:=  IsValid and (AsLong = ord(ev_itRight));
    end
    else
     Result:= True;
 end//Atom.IsKindOf(k2_typTextPara)
 else
  Result:= False;
end;

function IsAtomInSBS(Atom: Tl3Variant): Boolean;
var
 R: Tl3Variant;
begin
 R:= Atom.Owner;
 while (R.IsValid) and not (R.IsKindOf(k2_typSBS) or R.IsKindOf(k2_typDocument)) do
  R:= R.Owner;

 if not (R.IsValid) or R.IsKindOf(k2_typDocument) then
  Result:= False
 else
  Result:= True;
end;

(*function IsAtomInBlock(Atom: Tl3Tag): Boolean;
var
 R: Tl3Variant;
begin
 R:= Atom.Owner;
 while (R.IsValid) and not (R.IsKindOf(k2_typBlock) or R.IsKindOf(k2_typDocument)) do
  R:= R.Owner;

 if not (R.IsValid) or R.IsKindOf(k2_typDocument) then
  Result:= False
 else
  Result:= True;
end;*)

function IsAtomInTable(Atom: Tl3Variant): Boolean;
var
 R: Tl3Variant;
begin
 if not IsAtomInSBS(Atom) then
 begin
  R:= Atom.Owner;
  while (R.IsValid) and not (R.IsKindOf(k2_typTable) or R.IsKindOf(k2_typDocument)) do
   R:= R.Owner;

  if not (R.IsValid) or R.IsKindOf(k2_typDocument) then
   Result:= False
  else
   Result:= True;
 end//not IsAtomInSBS(Atom)
 else
  Result:= False;
end;


constructor TddBlockInfo.Create(anEditor : TevCustomEditor);
begin
 inherited Create;
 f_Editor := anEditor;
 f_IsReal:= dd_cbNone;
end;

procedure TddBlockInfo.AdjustBorders;

procedure _Adjust(const aNode: Il3Node);
var
 l_BI: IddBlockInfo;
begin
 if Supports(aNode, IddBlockInfo, l_BI) then
 begin
  if Finish.Compare(l_BI.Finish) < 0 then
   l_BI.Finish:= Finish;
  l_BI:= nil; 
 end;//Supports(aNode, IddBlockInfo, l_BI)
end;
begin
 if Finish <> nil then // Физический блок
  IterateF(l3L2NA(@_Adjust), imOneLevel)
end;

procedure TddBlockInfo.AdjustFinish(const aFinish: InevBasePoint);
var
 l_BI: IddBlockInfo;
begin
 Finish:= aFinish;
 if HasChild then
  if Supports(ChildNode.PrevNode, IddBlockInfo, l_BI) then
  begin
   l_BI.Finish:= aFinish;
   l_BI:= nil;
  end;//Supports(ChildNode.PrevNode, IddBlockInfo, l_BI) 
end;

procedure TddBlockInfo.Assign(P: TPersistent);
var
 l_BI: TddBlockInfo;
begin
 if P is TddBlockInfo then
 begin
  l_BI:= TddBlockInfo(P);
  BlockType := l_BI.BlockType;
  BlockName := l_BI.BlockName;
  Start := l_BI.Start;
  Finish := l_BI.Finish;
  fNumber     := l_BI.Number;
  Closed    := l_BI.Closed;
  f_IsReal    := l_BI.RealType;
  Visible:= l_BI.Visible;
 end//P is TddBlockInfo
 else
  inherited;
end;

procedure TddBlockInfo.Clear;
begin
 f_IsReal:= dd_cbNone;
 inherited;
end;

function TddBlockInfo.CloneFinish: InevBasePoint;
begin
 if Finish <> nil then
  Result := Finish.ClonePoint(f_Editor.View)
 else
  Result := nil;
end;

function TddBlockInfo.GetBlockName: AnsiString;
begin
  Result := FBlockName;
end;

function TddBlockInfo.GetBlockType: TddBlockType;
begin
  Result := FBlockType;
end;

function TddBlockInfo.GetClosed: Boolean;
begin
  Result := FClosed;
end;

function TddBlockInfo.GetFinish: InevBasePoint;
begin
  Result := FFinish;
end;

function TddBlockInfo.GetNumber: Integer;
begin
  Result := FNumber;
end;

function TddBlockInfo.GetRealType: TddCommentBlock;
begin
  Result := FRealType;
end;

function TddBlockInfo.GetStart: InevBasePoint;
begin
  Result := FStart;
end;

function TddBlockInfo.GetVisible: Boolean;
begin
 Result:= FVisible
end;

function TddBlockInfo.GetWasBlock: Boolean;
begin
  Result := FWasBlock;
end;

function TddBlockInfo.HasBlockWithNumber(aNumber: Integer): Boolean;
 function FindNode(const aNode: Il3Node): Boolean;
 var
  l_BI: IddBlockInfo;
 begin//SetNodeVisible
//  aNode - вложенный узел
  Result:= False;
  if Supports(aNode, IddBlockInfo, l_BI) then
  begin
   Result:= l_BI.Number = aNumber;
   l_BI:= nil;
  end;//Supports(aNode, IddBlockInfo, l_BI)
 end;//SetNodeVisible
begin
 Result:= False;
 if Number = aNumber then
  Result:= True
 else
 begin
  Result:= IterateF(l3L2NA(@FindNode), imOneLevel or imCheckResult) <> nil;
 end;//Number = Number
end;

procedure TddBlockInfo.Cleanup;
begin
 FStart := nil;
 FFinish := nil;
 inherited;
end;

procedure TddBlockInfo.SetBlockName(Value: AnsiString);
begin
  FBlockName := Value;
end;

procedure TddBlockInfo.SetBlockType(Value: TddBlockType);
begin
  if FBlockType <> Value then
  begin
    FBlockType := Value;
  end;
end;

procedure TddBlockInfo.SetClosed(Value: Boolean);
begin
  FClosed := Value;
end;

procedure TddBlockInfo.SetFinish(const Value: InevBasePoint);
begin
 fFinish := nil;
 if Value <> nil then
  fFinish:= Value.ClonePoint(f_Editor.View);
end;

procedure TddBlockInfo.SetNumber(Value: Integer);
begin
  if FNumber <> Value then
  begin
    FNumber := Value;
  end;//FNumber <> Value
end;

procedure TddBlockInfo.SetRealType(Value: TddCommentBlock);
begin
  if FRealType <> Value then
  begin
    FRealType := Value;
  end;//FRealType <> Value
end;

procedure TddBlockInfo.SetStart(const Value: InevBasePoint);
begin
 FStart := nil;
 if Value <> nil then
  FStart:= Value.ClonePoint(f_Editor.View);
end;

procedure TddBlockInfo.SetVisible(const Value: Boolean);
begin
 FVisible:= Value;
end;

procedure TddBlockInfo.SetWasBlock(Value: Boolean);
begin
  if FWasBlock <> Value then
  begin
    FWasBlock := Value;
  end;//FWasBlock <> Value
end;

function TddBlockInfo.UniqueNumber(aNumber: Longint): Boolean;
 function FindNode(const aNode: Il3Node): Boolean;
 var
  l_BI: IddBlockInfo;
 begin//SetNodeVisible
//  aNode - вложенный узел
  Result:= False;
  if Supports(aNode, IddBlockInfo, l_BI) then
  begin
   Result:= l_BI.Number = aNumber;
   l_BI:= nil;
  end;
 end;//SetNodeVisible
var
 l_Node: Il3Node;
begin
 Result:= True;
 if Number = aNumber then
  Result:= False
 else
 begin
  l_Node:= IterateF(l3L2NA(@FindNode), imOneLevel or imCheckResult);
  if l_Node <> nil then
  begin
   Result:= False;
   l_Node:= nil;
  end; // l_Node <> nil
 end;//Number = aNumber
end;

function GetAppendix(aBlockInfo: IddBlockInfo): IddBlockInfo;
var
 l_Parent: Il3Node;
 l_BI: IddBlockInfo;
begin
 Result:= nil;
 if aBlockInfo.BlockType in dd_btAppendixes then
  Result:= aBlockInfo
 else
 begin
  if Supports(aBlockInfo, Il3Node, l_Parent) then
  begin
   l_Parent:= l_Parent.ParentNode;
   while l_Parent <> nil do
   begin
    if Supports(l_Parent, IddBlockInfo, l_BI) then
     if (l_BI.BlockType in dd_btAppendixes) then
     begin
      Result:= l_BI;
      break
     end//l_BI.BlockType in dd_btAppendixes
     else
      l_Parent:= l_Parent.ParentNode;
   end; // while l_Parent <> nil
   l_Parent:= nil;
  end; // Supports
 end; // not Result
end;

function InAppendix(aBlockInfo: IddBlockInfo): Boolean;
begin
 Result:= GetAppendix(aBlockInfo) <> nil;
end;

{ Searcher and Replacer }

constructor TddBlockStructureSearcher.Create(aOwner: TevSearchToolOwner);
begin
 inherited;
 Layer  := l3NilLong;
 Options:= [ev_soReplace, ev_soReplaceAll];
 f_SearchParagraphs:= False;
 f_BlockIDList:= Tl3ProtoObjectRefList.Make;
 InitBlockIDList;
 f_CommentText:= Tl3String.Create;
end;

procedure TddBlockStructureSearcher.AddID(const aName: ShortString; aBlockID: TddBlockType);
var
 l_ID: TddBlockID;
begin
 l_ID:= TddBlockID.Create;
 try
  l_ID.IDName:= aName;
  l_ID.BlockType:= aBlockID;
  f_BlockIDList.Add(l_ID);
 finally
  l3Free(l_ID);
 end;//try..finally
end;

function TddBlockStructureSearcher.CheckColorSelection(aStyle: Long; 
    Sender : Tl3Variant; S : Tl3CustomString; const aSel  : TevPair; aText :
    AnsiString; out theSel  : TevPair): Bool;
var
 l_Found: Boolean;
 l_St: AnsiString;
 l_N: Integer;
begin
 Layer  := Ord(ev_slView);
 Handle:= aStyle;//ev_saColorSelection;
 SearchPlace := ev_spAll;
 if inherited DoCheckText(Sender, S, aSel, theSel) then
 begin
  l_St:= TrimLeft(aText);
  if Sender.IsKindOf(k2_typTextPara) then
   with Sender.Attr[k2_tiStyle] do
    if IsValid and (AsLong = ev_saANSIDOS) then
    begin
     // Отрезаем все до theSel.rStart
     l_St:= System.Copy(aText, theSel.rStart+1, aSel.rFinish);
     theSel.rStart:= 0;
     Dec(theSel.rFinish, theSel.rStart);
    end;//IsValid
  if (theSel.rStart = 0) and ((theSel.rFinish = S.Len) or (theSel.rFinish = Length(l_St)))then
   l_Found:= True
  else
   l_Found:= l_Found or ((S.Len - Length(l_St)) = theSel.rStart);
  if l_Found then
  begin
   theSel.rStart:= 0;
   aText:= Trim(l_St{aText});
   if AnsiStartsText('ПРИЛОЖЕНИЕ', aText) and EnableAppendix(Sender) then
   begin
    if f_FirstHeaderFound then
    begin
     if Length(aText) > Length('Приложение ') then
     begin
      if aText[Length('Приложение ')+1] in (cc_Digits+['N','№']) then
       f_BlockType:= dd_btAppendix
      else
       f_BlockType:= dd_btPseudoDocument
     end
     else
      f_BlockType:= dd_btPseudoDocument;
     if f_PreambleFound < 2 then
      f_PreambleFound:= 2;
//     f_WaitForEmpty:= True;
    end//f_FirstHeaderFound
    else
    begin
     //f_FirstHeaderFound:= True;
     f_PreambleFound:= 0;
     Result:= False;
     exit;
    end;//f_FirstHeaderFound
   end//AnsiStartsText('ПРИЛОЖЕНИЕ', aText)
   else // not Приложение
   if AnsiStartsText('УТВЕРЖДЕНО', aText) then
    f_BlockType:= dd_btSubAppendix
   else
   if AnsiStartsText('ТАБЛИЦА', aText) then
    f_BlockType:= dd_btSubAppendix
   else
   if AnsiStartsText('ФОРМА', aText) then
    f_BlockType:= dd_btSubAppendix
   else
   if AnsiStartsText('ПРОЕКТ', aText) then
    f_BlockType:= dd_btSubAppendix
   else
   if (S.First in cc_Digits) and (CheckDigits(S, l_N) <> dd_btNone) then
    f_BlockType:= dd_btArticle
   else
   if AnsiStartsText('СТАТЬЯ', aText) then
    f_BlockType:= dd_btArticle
   else
   if AnsiStartsText('ПУНКТ', aText) then
    f_BlockType:= dd_btArticle
   else
   if AnsiStartsText('ПРИМЕЧАНИЯ', aText) then
    f_BlockType:= dd_btRemark;
   if (f_BlockType in [dd_btAppendix, dd_btSubAppendix]) and
      (f_PrevBlockType in [dd_btAppendix, dd_btSubAppendix]) {and not WasText} then
    f_BlockType:= dd_btNone;
  end;// l_Found
 end;//inherited DoCheckText(Sender, S, aSel, theSel)
 Result:= f_BlockType <> dd_btNone;
 Layer  := l3NilLong;
end;

function TddBlockStructureSearcher.CheckComment(Sender : Tl3Variant; S:
    Tl3CustomString; aSel: TevPair; out theSel: TevPair): Bool;
    
 function _CheckStyle(StyleID: Long): Boolean;
 { TODO -oДудко -cРазвитие : На будущее - просмотреть аналогичные места.
                      Может быть нужно будет вынести в отдельную функцию }
 begin
  Handle:= StyleID;
  Result:= inherited DoCheckText(Sender, S, aSel, theSel);
 end;

begin
 // Ищем комментарий
 if _CheckStyle(ev_saTxtComment) or _CheckStyle(ev_saTechComment) or
    _CheckStyle(ev_saVersionInfo) or _CheckStyle(ev_saUserComment) then
 begin
  f_BlockType:= dd_btComment;
  f_CommentText.Assign(S);
 end;//_CheckStyle(ev_saTxtComment)..
 Result:= f_BlockType <> dd_btNone;
end;

function TddBlockStructureSearcher.CheckContentTable(Sender : Tl3Variant;
    S: Tl3CustomString; aSel: TevPair; out theSel: TevPair): Bool;
begin
 Handle:= ev_saANSIDOS;
 if inherited DoCheckText(Sender, S, aSel, theSel) then
 begin
  // проверить на видимость
  if Sender.IsKindOf(k2_typTextPara) then
   with Sender.Attr[k2_tiVisible] do
    if IsValid and not AsBool then
     f_BlockType:= dd_btContentTable;
 end; // Search(Sender, S, aSel, theSel)
 Result:= f_BlockType <> dd_btNone;
end;

function TddBlockStructureSearcher.CheckDigits(aText: Tl3CustomString;
                                               var Num: Integer): TddBlockType;
var
 index: Integer;
 l_DotCount: Integer;
 l_Bracket: Boolean;
begin
 index:= 0;
 l_DotCount:= 0;
 l_Bracket:= False;
 Result:= dd_btNone;
 while (aText.Ch[index] in (cc_Digits+cc_RomeDigits+['.', ')'])) and (index < aText.Len) do
 begin
  if aText.Ch[index] = '.' then
   Inc(l_DotCount)
  else
  if aText.Ch[index] = ')' then
   l_Bracket:= True;
  Inc(index);
 end; //while
 // Дробные номера пунктов - не нужно проверять наличие цифры после точки
 // рассматриваются только номера не глубже X.X.X.
 case l_DotCount of
  0: if l_Bracket then
   Result:= dd_btParagraphBracket;
  1:
   if aText.Ch[Pred(index)] in cc_Digits then
    Result:= dd_btParagraphArabic
   else
    Result:= dd_btParagraphRoman;
  2: Result:= dd_btParagraphXX;
  3: Result:= dd_btParagraphXXX;
  4: Result:= dd_btParagraphXXXX;
  5: Result:= dd_btParagraphXXXXX;
  6: Result:= dd_btParagraphXXXXXX;
 else
  Result:= dd_btNone;
 end; // case
 if Result = dd_btParagraphArabic then
  Num:= StrToIntDef(System.Copy(aText.AsString, 1, index), 0)
 else
  Num:= -1;
end;

function TddBlockStructureSearcher.CheckFootnote(Sender : Tl3Variant; S:
    Tl3CustomString; aSel: TevPair; out theSel: TevPair): Bool;
begin
 if f_WaitForFootnote then
 begin
  // тут может быть формула!
  if (S.First = '*') and not EvIsParaFormula(Sender.AsObject) then       
  begin
   f_WaitForFootnote:= False;
   f_BlockType:= dd_btFootnoteBody;
  end;//S.First = '*'
 end//f_WaitForFootnote
 else
 if (S.IsOEM) and l3AllCharsInCharSet(S.St, S.Len, [cc_HLine]) then
 begin
  f_WaitForFootnote:= True;
  f_BlockType:= dd_btStartFootnote;
 end//S.IsOEM
 else
 if not S.IsOEM and l3AllCharsInCharSet(S.St, S.Len, ['-', '_']) then
 begin
  f_WaitForFootnote:= True;
  f_BlockType:= dd_btStartFootnote;
 end;//not S.IsOEM
 Result:= f_BlockType <> dd_btNone;
 if Result then
 begin
  theSel.rStart:= aSel.rStart;
  theSel.rFinish:= aSel.rFinish;
 end;//Result
end;

function TddBlockStructureSearcher.CheckHeader(Sender : Tl3Variant; S:
    Tl3CustomString; aSel: TevPair; const aText: AnsiString; out theSel: TevPair):
    Bool;
var
 i: Integer;
 l_PrevType: TddBlockType;
 l_Num: Integer;
begin
 if f_SearchParagraphs then
  Handle:= ev_saTxtNormalANSI
 else
  Handle:= ev_saTxtHeader1;
 if inherited DoCheckText(Sender, S, aSel, theSel) then
 begin
  if f_FirstHeaderFound then
  begin
   if (f_PreambleFound > 1){ or (not f_SBSFound)}then
    f_BlockType:= dd_btHeader1
   else
   begin
    f_BlockType:= dd_btDocument;
    f_PreambleFound:= 2;
   end;
  end//f_FirstHeaderFound
  else
  begin
   f_FirstHeaderFound:= True;
   f_PreambleFound:= 0;
   Result:= False;
   exit;
  end;//f_FirstHeaderFound

  if f_SearchParagraphs or not ByteBool(f_PreambleFound) then
  begin
   if S.First in cc_Digits then
   begin
    f_BlockType:= CheckDigits(S, l_Num);
   end;//S.First in cc_Digits
  end//f_SearchParagraphs or not ByteBool(f_PreambleFound)
  else
  if S.First = cc_ParagraphSign then
   f_BlockType:= dd_btParagraphSign//dd_btSection
  else
  if S.First in cc_RomeDigits then
   f_BlockType:= dd_btSectionRoman
  else
  if S.First in cc_Digits then
  begin
   if CheckDigits(S, l_Num) <> dd_btNone then
    f_BlockType:= dd_btSectionArabic
   else
    f_BlockType:= dd_btSubSectionArabic;
  end//S.First in cc_Digits
  else
  if (Upcase(S.First) in ['A'..'Z']) and (S.Len > 1) and (S.Ch[1] in ['.', ')']) then
   f_BlockType:= dd_btSectionLatin
  else
  if (Upcase(S.First) in ['А'..'Я']) and (S.Len > 1) and (S.Ch[1] in ['.', ')']) then
   f_BlockType:= dd_btSectionCyr
  else
  if Pos('(утв.', aText) <> 0 then
   f_BlockType:= dd_btAppendixOrHeader1
  else
  for i:= 0 to f_BlockIDList.Hi do
   if AnsiStartsText(TddBlockID(f_BlockIDList.Items[i]).IDName, aText) then
   begin
    f_BlockType:= TddBlockID(f_BlockIDList.Items[i]).BlockType;
    break;
   end;//AnsiStartsText(TddBlockID(f_BlockIDList.Items[i]).IDName, aText)
 end;//inherited DoCheckText(Sender, S, aSel, theSel)
 Result:= f_BlockType <> dd_btNone;
end;

function TddBlockStructureSearcher.CheckParagraph(Sender : Tl3Variant; S:
    Tl3CustomString; aSel: TevPair; out theSel: TevPair): Bool;
var
 l_Num: Integer;
 i: Integer;
begin
 Handle:= ev_saTxtNormalANSI;
 if inherited DoCheckText(Sender, S, aSel, theSel) then
 begin
  if S.First in (cc_Digits + cc_RomeDigits) then
   f_BlockType:= CheckDigits(S, l_Num)
  else
  if (Upcase(S.First) in ['A'..'Z']) and (S.Len > 1) and (S.Ch[1] in ['.', ')']) then
   f_BlockType:= dd_btParagraphLatin
  else
  if (AnsiUpperCase(S.First)[1] in ['А'..'Я']) and (S.Len > 1) and (S.Ch[1] in ['.', ')']) then
   f_BlockType:= dd_btParagraphCyr
 end // Search(Sender, S, aSel, theSel)
 else
 begin
  Handle:= ev_saANSIDOS;
  if inherited DoCheckText(Sender, S, aSel, theSel) then
  begin
   if S.Len > 40 then
   begin
    i:= 32;
    l_Num:= 0;
    while (S.Ch[i] = ' ') and (i <> 42) do
    begin
     Inc(i);
     Inc(l_Num);
    end; // while
    if (l_Num = 10) and (f_PrevBlockType <> dd_btSBS) then
    begin
     f_BlockType:= dd_btMayBeSBS;
     { DONE -oДудко -cРазвитие : Нужно пропускать идущие вплотную за этим моноширинные абзацы }
    end;
   end; // S.Len > 40
  end
  else
  begin
   Handle:= ev_saToLeft;
   if inherited DoCheckText(Sender, S, aSel, theSel) then
   begin
    if (S.Len < 50) and (f_PrevBlockType <> dd_btSBS) then
     f_BlockType:= dd_btMayBeSBS;
     { DONE -oДудко -cРазвитие : Нужно пропускать идущие вплотную за этим моноширинные абзацы }
   end
   else
   begin
    Handle:= ev_saEnclosureHeader;
    if inherited DoCheckText(Sender, S, aSel, theSel) then
    begin
     f_BlockType:= dd_btAppendix;
     if f_PreambleFound < 2 then
      f_PreambleFound:= 2;
    end; // inherited DoCheckText(Sender, S, aSel, theSel)
   end;
  end;
 end;
 Result:= f_BlockType <> dd_btNone;
end;

function TddBlockStructureSearcher.DoCheck(const aView : InevView;
                                           const aTag        : InevObject;
                                           const aStart      : InevBasePoint;
                                           const aFinish     : InevBasePoint;
                                           const aStartPrev  : InevBasePoint;
                                           const aFinishPrev : InevBasePoint;
                                           out theSel        : TevPair): Bool;
var
 l_Sub    : IevSub;
begin
 if (aStart <> nil) and aStart.AtEnd(aView) then
 begin
  Result:= False;
 end//aStart <> nil
 else
 if not evHasText(aTag.AsObject) then
 begin
  if AtomHasSub(aTag) then
  begin
   f_BlockType:= dd_btSubOnEmpty;
   Result:= True;
  end//AtomHasSub(aTag)
  else
  if IsAtomInSBS(aTag.AsObject) then
  begin
   theSel.rStart:= 0;
   theSel.rFinish:= ev_cpBottom;
   Result:= inherited DoCheck(aView, aTag, aStart, aFinish, aStartPrev, aFinishPrev, theSel)
  end//IsAtomInSBS(aTag)
  else
  begin
   Result:= False;
   if Assigned(f_OnNotFound) then
    f_OnNotFound(False, aStart);
  end;//IsAtomInSBS(aTag)
  l_Sub:= nil;
  theSel.rStart:= 0;
  theSel.rFinish:= ev_cpBottom;
 end//not evHasText(aTag)
 else
  Result:= inherited DoCheck(aView, aTag, aStart, aFinish, aStartPrev, aFinishPrev, theSel);
end;

function TddBlockStructureSearcher.DoCheckText(Sender : Tl3Variant; S
    : Tl3CustomString; const aSel  : TevPair; out theSel  : TevPair): Bool;

var
 l_Text, l_St: AnsiString;
 i, l_AskPosition: Integer;
 l_Found: Boolean;
begin
 Result:= False;
  if IsAtomInTable(Sender) then
   Exit
  else
  if ((aSel.rStart = aSel.rFinish) or (aSel.rFinish = ev_cpAtEnd)) and (aSel.rStart > 0) then
   Exit
  else
  begin
   f_PrevBlockType:= f_BlockType;
   f_BlockType:= dd_btNone;
   l_Text:= l3PCharLen2String(S.AsPCharLen);
   if IsAtomInSBS(Sender) then
   begin
   { TODO -oNarry -cРазвитие : Нужно переделать определение правой половины подписи. }
    if f_PrevBlockType = dd_btSBS then
     exit;
    f_PreambleFound:= 1;
    f_BlockType:= dd_btSBS;
    f_SBSFound:= True;
    f_SBSIndex:= 2;
   end
   else
   if (l_Text <> '') and (aSel.rStart <> aSel.rFinish) then
   begin
    SearchPlace := ev_spPara;
    l_AskPosition:= Pos('Вопрос', l_Text);
    if not CheckHeader(Sender, S, aSel, l_Text, theSel) then
     if not CheckContentTable(Sender, S, aSel, theSel) then
      if not CheckComment(Sender, S, aSel, theSel) then
       if not CheckFootnote(Sender, S, aSel, theSel) then
        if (l_Text[1] in cc_Digits) and
           ((l_AskPosition = 0) or (l_AskPosition > 10)) then
        begin
         if not CheckParagraph(Sender, S, aSel, theSel) then
          if not CheckColorSelection(ev_saColorSelection, Sender, S, aSel, l_Text, theSel) then
           if not CheckColorSelection(ev_saArticleHeader, Sender, S, aSel, l_Text, theSel) then
            CheckColorSelection(ev_saTxtOutOfDate, Sender, S, aSel, l_Text, theSel)
        end
        else
        begin
         if not CheckColorSelection(ev_saColorSelection, Sender, S, aSel, l_Text, theSel) then
          if not CheckColorSelection(ev_saTxtOutOfDate, Sender, S, aSel, l_Text, theSel) then
           if not CheckColorSelection(ev_saArticleHeader, Sender, S, aSel, l_Text, theSel) then
            CheckParagraph(Sender, S, aSel, theSel);
        end; // not S.Fisrt in cc_Digits
   end; // l_Text <> ''
   Result:= f_BlockType <> dd_btNone;

   if Result then
   begin
    if not (f_BlockType in [dd_btSBS, dd_btComment, dd_btContentTable, dd_btSubOnEmpty]) then
     MakeBlockName(l_Text);
    if S <> nil then
     theSel.rFinish:= S.Len
    else
     theSel.rFinish:= ev_cpBottom;
   end
   else
   if (l_Text = '') or (aSel.rStart = aSel.rFinish) then
    f_BlockType:= f_PrevBlockType;

   if not Result and Assigned(f_OnNotFound) then
    f_OnNotFound((l_Text <> '') and (aSel.rStart < aSel.rFinish));
  end; // not isBlock
end;

procedure TddBlockStructureSearcher.DoStart;
begin
 inherited;
 f_PreambleFound:= 0;
 f_BlockType:= dd_btNone;
 f_FirstHeaderFound:= (ev_soSelText in Options) or (ev_soDocumentPart in Options); //False;
 if f_FirstHeaderFound then
 begin
  f_PreambleFound:= 2;
 end;
 f_SBSIndex:= 0;
 f_SBSFound:= False;
 f_CommentText.Clear;
// f_WasEmpty:= False;
// f_WasText:= False;
end;

procedure TddBlockStructureSearcher.InitBlockIDList;
begin
 AddID('ЧАСТЬ', dd_btPart);
 AddID('РАЗДЕЛ', dd_btSection);
 AddID('ПОДРАЗДЕЛ', dd_btSubSection);
 AddID('ГЛАВА', dd_btChapter);
 AddID('СТАТЬЯ', dd_btArticleChapter);

 AddID('PART', dd_btPart);
 AddID('SECTION', dd_btSection);
 AddID('SUBSECTION', dd_btSubSection);
 AddID('CHAPTER', dd_btChapter);
 AddID('ARTICLE', dd_btArticleChapter);

// AddID('ПРОТОКОЛ', dd_btReport);
// AddID('РЕГЛАМЕНТ', dd_btRegulations);
// AddID('ПЕРЕЧЕНЬ', dd_btIndex);
end;

procedure TddBlockStructureSearcher.MakeBlockName(const aSt: AnsiString);
var
 lNameStrLen : Integer;
 I,j         : Integer;
 l_Num       : ShortString;
begin
 lNameStrLen := Length(aSt);
 f_BlockName:= '';
 if (lNameStrLen > 0) then
 begin
  f_BlockText:= AnsiReplaceStr(Copy(Trim(aSt), 1, 73), #10, #32);
  j:= 1;
  if not (aSt[1] in (cc_Digits+cc_RomeDigits)) then
   while (j <= lNameStrLen) and not (aSt[j] in (cc_Digits+cc_RomeDigits)) do
    Inc(j);
  i:= j;
  while (I <= lNameStrLen) and (aSt[I] in (cc_Digits+cc_RomeDigits+[cc_Dot])) do
   Inc(I);
  Dec(I);

  if aSt[I] = cc_Dot then Dec(I);

  l_Num:= Copy(aSt, j, i-j+1);
  if l_Num <> '' then
  begin
   if j = 1 then
   begin
    if BlockType in dd_btPoints then
    begin
     f_BlockName:= 'Пункт ' + l_Num;
     f_ArticleNumber:= StrToIntDef(l_Num, -1);
    end
    else
     f_BlockName:= 'Раздел '+ l_Num;
   end//j = 1
   else
   begin
    if BlockType = dd_btArticle then
    begin
     f_BlockName:= 'Статья ' + l_Num;
     f_ArticleNumber:= StrToIntDef(l_Num, -1);
    end//BlockType = dd_btArticle
    else
     f_BlockName:= Copy(aSt, 1, i);
   end;//j = 1
  end//l_Num <> ''
  else
   f_BlockName:= aSt;
 end;//lNameStrLen > 0
end;

procedure TddBlockStructureSearcher.Cleanup;
begin
 l3Free(f_CommentText);

 l3Free(f_BlockIDList);
 inherited;
end;

procedure TddBlockStructureReplacer.Cleanup;
begin
 l3Free(f_Dialog);
 l3Free(f_BlockRoot);
 f_EmptyParaCursor := nil;
// l3Free(f_BlockStack);
 f_CommentStart := nil;
 f_FootnoteCursor := nil;
 inherited;
end;

procedure TddBlockStructureReplacer.DoStart;
begin
 inherited;
 l3FillChar(f_BlockNumbers, SizeOf(f_BlockNumbers), 0);
 //f_UniqueNumber:= 100000;
 f_FirstLevelIndex:= 0;
 f_RemarkInBlock:= dd_btNone;
 f_FirstBlock:= True;
 f_FirstLevel:= dd_btNone;
 f_WasText:= False;
 f_WasEmpty:= False;
 f_InAppendix:= False;
 f_ConfirmSBSRes:= mrOk;
 f_ConfirmJoinRes:= mrOk;
 f_Searcher.OnNotFound:= WhatNotFound;
 f_CommentStart := nil;
 f_EmptyParaCursor := nil;
end;


procedure TddBlockStructureReplacer.DoFinish(aCancel: Bool; const aBlock: InevRange);
var
 l_S, l_F: InevBasePoint;
 l_N: Il3Node;
 l_BI: IddBlockInfo;
begin
 inherited;
 if not aCancel then
 begin
  aBlock.GetBorderPoints(l_S, l_F);
  { Присваиваем конечные позиции блокам }
  l_N:= f_Current;
  while not f_BlockRoot.IsSame(l_N) do
  begin
   if Supports(l_N, IddBlockInfo, l_BI) then
   begin
    l_BI.Finish:= l_F;
    l_BI:= nil;
   end;
   l_N:= l_N.ParentNode;
  end; // while
 end;//not aCancel
end;

procedure TddBlockStructureReplacer._InsertBlock(const aView : InevView;const aBlock: Il3Node);

 procedure _InsertOneBlock(const aNode: Il3Node);
 begin//SetNodeVisible
  _InsertBlock(aView,aNode);
 end;//SetNodeVisible
var
 l_B: IddBlockInfo;
begin
 afw.ProcessMessages;
 if Supports(aBlock, IddBlockInfo, l_B) then
 begin
  aBlock.IterateF(l3L2NA(@_InsertOneBlock), imOneLevel);
  if aBlock.ParentNode <> nil then
  begin
   InsertBlockInDocument(aView, l_B);
   TextSource.Indicator.Progress(f_InsertedCount);
   Inc(f_InsertedCount);
  end; // aBlock.ParentNode <> nil
  l_B:= nil;
 end; // aBlock.QueryInterface(IddBlockInfo, l_B) = 0
end;

constructor TddBlockStructureReplacer.Create(aOwner: TevSearchToolOwner);
begin
 inherited;
// f_BlockStack:= Tl3VList.MakePersistent;
 fDeepLevel:= 0;                                                         
 OnReplaceConfirm:= _ReplaceConfirm;
 f_BlockRoot:= TddBlockInfo.Create(nil);
 f_BlockRoot.Text:= l3PCharLen('Документ');
 f_Current:= f_BlockRoot;
 f_Dialog:= TddTuneBlocksDialog.Create(Application);
 f_Dialog.OnInsertBlocks:= FinalTune;
end;

function TddBlockStructureReplacer.CalcMaxLevel(const aNode: Il3Node): Integer;

 procedure _CalcLevel(const aN: Il3Node);
 var
  l_BI: IddBlockInfo;
 begin
  if Supports(aN, IddBlockInfo, l_BI) then
  begin
   if l_BI.Visible then
    Result:= Max(Result, aN.GetLevelFor(aNode));
   l_BI:= nil; 
  end;
 end;
 
begin
 Result:= 0;
 aNode.IterateF(l3L2NA(@_CalcLevel));
end;

function TddBlockStructureReplacer._ReplaceConfirm(Sender       : TObject;
                                                   const aBlock : InevRange): ShortInt;
var
 l_BI: IddBlockInfo;
begin
 if Supports(f_Current, IddBlockInfo, l_BI) then
 begin
  if (f_Searcher.BlockType = dd_btHeader1) and
     (l_BI.BlockType in [dd_btHeader1, dd_btAppendixOrHeader1]) and
      not f_WasText then
  begin
   if f_ConfirmJoinRes = mrYesToAll then
    Result := mrOk
   else
   if f_ConfirmJoinRes = mrNoToAll then
    Result := mrNo
   else
   begin
    Result :={$IFDEF InsiderTest}
                vtMessageDlg(l3CStr('Является ли данный заголовок началом блока?'),
                             mtConfirmation, mbYesAllNoAllCancel, 0)
              {$ELSE}
              mrYes
              {$ENDIF};
    f_ConfirmJoinRes := Result;
    if f_ConfirmJoinRes = mrYesToAll then
     Result := mrOk;
   end;
  end
  else
  if (f_Searcher.BlockType = dd_btMayBeSBS) then
  begin
   if f_ConfirmSBSRes = mrYesToAll then
    Result:= mrOk
   else
   if f_ConfirmSBSRes = mrNoToAll then
    Result:= mrNo
   else
   begin
    Result:= {$IFDEF InsiderTest}
               vtMessageDlg(l3CStr('Является ли данный текст подписью?'),
                            mtConfirmation, mbYesAllNoAllCancel, 0)
              {$ELSE}
               mrYes
              {$ENDIF};
    if Result in [mrYes, mrYesToAll] then
     f_Searcher.BlockType:= dd_btSBS;
    f_ConfirmSBSRes := Result;
    if f_ConfirmJoinRes = mrYesToAll then
     Result := mrOk;
   end;
  end
  else
   Result:= mrOk;
  l_BI:= nil;
 end
 else
  Result:= mrNo;
end;

function TddBlockStructureReplacer.CheckType(const aCursor: InevBasePoint;
                                          var aNumber: Longint): TddCommentBlock;
var
 l_Sub    : IevSub;
begin
 Result:= dd_cbNone;
 aNumber:= -1;
 if Supports(aCursor.MostInner, IevSub, l_Sub) then
 try
  if l_Sub.Exists then
  begin
   Result:= dd_cbSub;
   aNumber:= l_Sub.ID;
  end//l_Sub.Exists
  else
   if Supports(aCursor.MostInner, IevDocumentPart, l_Sub) then
   try
    Result:= dd_cbBlock;
    aNumber:= l_Sub.ID;
   finally
    l_Sub := nil;
   end;//try..finally
 finally
  l_Sub := nil;
 end;//try..finally
end; // CheckType


procedure TddBlockStructureReplacer.ProcessComment(const aCursor: InevBasePoint);
var
 l_NewType: TddCommentBlock;
 l_ID: Longint;
begin
 l_NewType:= CheckType(aCursor, l_ID);
 if (f_CommentStart = nil) and (l_NewType = dd_cbNone) then
 begin
  if f_EmptyParaCursor = nil then
   exit
  else
  begin
   f_CommentStart:= f_EmptyParaCursor.ClonePoint(Editor.View);
   f_CommentGap:= aCursor.Position-f_EmptyParaCursor.Position+1;
   f_EmptyParaCursor := nil;
   f_CommentBlock:= dd_cbSub;
  end;//f_EmptyParaCursor = nil
 end//f_CommentStart = nil
 else
 if (f_CommentStart = nil) or
    ((aCursor.Position-f_CommentStart.Position > f_CommentGap) or
     ((l_NewType <> f_CommentBlock) and (l_NewType <> dd_cbNone))) then
 begin
  if f_WasEmpty and (f_CommentStart <> nil) then
   f_CommentGap:= aCursor.Position-f_CommentStart.Position
  else
  begin
   f_CommentBlock:= l_NewType;
   f_CommentGap:= 1;
   f_CommentStart := aCursor.ClonePoint(Editor.View);
   f_CommentGap:= 1;
  end;//f_WasEmpty and (f_CommentStart <> nil)
 end//f_CommentStart = nil
 else
 begin
  Inc(f_CommentGap);
 end;//f_CommentStart = nil
 f_WasText:= False;//not (f_Searcher.BlockType in [dd_btContentTable]);
end;

function TddBlockStructureReplacer.ReplaceFunc(const aView : InevView;
                                               const Container : InevOp;
                                               const aBlock    : InevRange): Bool;
var
 l_DL: Integer;
 l_S, l_F: InevBasePoint;
 l_CBI: IddBlockInfo;
 l_Block : InevRange;
begin
 {$IFDEF Write2Log}
 OutBlockDescript;
 {$ENDIF}
 Result:= True;
 l_Block := aBlock.ParentRange;
 l_Block.GetBorderPoints(l_S, l_F);
 try
  CheckComment(l_S);
  if CheckFootnote(l_S) or CheckEmptyPara(l_S) then
   Exit;

  if not f_Current.IsSame(f_BlockRoot) then
  begin
   if Supports(f_Current, IddBlockInfo, l_CBI) then
   try
    if not ConfirmJoin and (f_Searcher.BlockType = dd_btHeader1) and not f_WasText
       and (l_CBI.BlockType in [dd_btHeader1,  dd_btAppendixOrHeader1]) then
     Exit;

    if f_Searcher.BlockType = dd_btRemark then
    begin
     f_RemarkInBlock:= l_CBI.BlockType;
     Exit;
    end; // f_Searcher.BlockType = dd_btRemark
    // Текущий открытый блок
    if IsEnableClose(f_Searcher.BlockType, l_DL) then
    begin
     CloseOpenBlocks(aView, l_S, l_F, l_DL);
    end // IsEnableClose
    else
     StartBlock(aView,l_S);
   finally
    l_CBI:= nil; 
   end; // Supports
  end // f_Start
  else
   StartBlock(aView,l_S); // not f_Start
 finally
  l_Block := nil;
 end;//try..finally
end;

function TddBlockStructureReplacer.IsEnableClose(aBlockType: TddBlockType; var DeepLevel: Integer): Boolean;
var
 i: Integer;
 l_NewBlockType,
 l_TmpBlockType: TddBlockType;
 l_Cur: Il3Node;
 l_Current: IddBlockInfo;
begin
 Result:= False;
 DeepLevel:= 0;
 if f_BlockRoot.IsSame(f_Current) then
  exit
 else
 if (aBlockType = dd_btComment) then
 begin
  if AnsiStartsText(SysUtils.Format('См. комментарий к статье %d', [f_Searcher.ArticleNumber]), f_Searcher.CommentText.AsString) then
  begin
   Result:= True;
   if Supports(f_Current, IddBlockInfo, l_Current) then
   try
    l_Cur:= f_Current;
    while l_Current.BlockType <> dd_btArticle do
    begin
     l_Cur:= l_Cur.ParentNode;
     l_Current:= nil;
     if not Supports(l_Cur, IddBlockInfo, l_Current) then
      exit;
     Inc(DeepLevel);
    end;
   finally
    l_Current:= nil;
   end;
  end
  else
   exit
 end
 else
 begin
  DeepLevel:= 1;
  if Supports(f_Current, IddBlockInfo, l_Current) then
  try
   l_TmpBlockType:= l_Current.BlockType;//LastBlock.BlockType;
   if l_TmpBlockType = dd_btFootnoteBody then
   begin
    if f_FirstLevel = dd_btNone then // Преамбула
    begin
     DeepLevel:= f_Current.GetLevelFor(f_BlockRoot);
     Result:= True;
     exit;
    end
   end;
  finally
   l_Current:= nil;
  end
  else
   exit;

  if (aBlockType in [dd_btSBS, dd_btFootnoteBody]) and (f_FirstLevel = dd_btNone) then
  begin
   Result:= True;
   DeepLevel:= f_Current.GetLevelFor(f_BlockRoot);
  end
  else
  if not (l_TmpBlockType in dd_btParagraphs) and (aBlockType in dd_btParagraphs)
     {and (aBlockType <> l_TmpBlockType)} then
  begin
   Result:= False;
  end
  else
  begin
   Result:= False;
   if (aBlockType = dd_btContentTable) and f_WasText and (f_FirstLevel <> dd_btNone) and
    not (l_TmpBlockType in [f_FirstLevel, dd_btAppendix]) then
    l_NewBlockType := f_FirstLevel
   else
   if (aBlockType in [dd_btAppendix, dd_btSBS, dd_btFootnoteBody]) then
   begin
    if (f_FirstLevel <> dd_btNone) then
     l_NewBlockType:= f_FirstLevel
    else
     l_NewBlockType:= aBlockType;//l_TmpBlockType;
    //DeepLevel:= 0;
   end
   else
    l_NewBlockType:= aBlockType;
   l_Cur:= f_Current;
   while not f_BlockRoot.IsSame(l_Cur) do
   begin
    if Supports(l_Cur, IddBlockInfo, l_Current) then
    begin
     l_TmpBlockType:= l_Current.BlockType;
     if not (l_TmpBlockType in [l_NewBlockType]) {or (l_TmpBlockType <> dd_btFootnoteBody)} then
     begin
      l_Cur:= l_Cur.ParentNode;
      Inc(DeepLevel);
     end
     else
     begin
      if (aBlockType in [dd_btAppendix, dd_btPseudoDocument, dd_btContentTable, dd_btFootnoteBody]) and
         (f_FirstLevel <> aBlockType) and (f_FirstLevel <> dd_btNone) then
       Dec(DeepLevel);
      Result:= DeepLevel > 0;
      break;
     end;
    end
    else
     exit;
   end; // while i >= 0
  end;
  if Supports(f_Current, IddBlockInfo, l_Current) then
   if not Result and not (aBlockType in dd_btParagraphs) and
     (l_Current.BlockType in dd_btParagraphs) then
   begin
    Result:= True;
    // нужно закрывать все блоки до чего-то вразумительного
    DeepLevel:= 0;

    l_Cur:= f_Current;
    if Supports(l_Cur, IddBlockInfo, l_Current) then
     while l_Current.BlockType in (dd_btParagraphs+[dd_btRemark]) do
     begin
      Inc(Deeplevel);
      l_Cur:= l_Cur.ParentNode;
      if not Supports(l_Cur, IddBlockInfo, l_Current) then
       exit;
     end;
    if (aBlockType = dd_btAppendix) and (f_FirstLevel = dd_btNone) then
     while not f_BlockRoot.IsSame(l_Cur) do
     begin
      Inc(Deeplevel);
      l_Cur:= l_Cur.ParentNode;
     end;
   end;
 end; // f_BlockStack.Count <> 0
end;

procedure TddBlockStructureReplacer.StartBlock(const aView : InevView;
const aStart: InevBasePoint);
// Добавление блока в список
var
 l_BlockInfo: TddBlockInfo;
 l_BlockType: TddBlockType;
 l_IBI: IddBlockInfo;
 l_Combine: Boolean;
 l_Number: Longint;
 l_Current: IddBlockInfo;
begin
 if f_Searcher.BlockType in [dd_btSBS, dd_btComment, dd_btContentTable] then
 begin
  if Supports(f_Current, IddBlockInfo, l_Current) then
   if not (l_Current.BlockType in [dd_btAppendix, dd_btPseudoDocument]) then
    l_Current.WasBlock:= True;
  Exit;
 end;

 if f_FirstBlock and (f_Searcher.BlockType = dd_btHeader1) then
  l_BlockType:= dd_btDocument
 else
  l_BlockType:= f_Searcher.BlockType;

 if f_BlockRoot.IsSame(f_Current) then
 begin
  if ByteBool(f_Searcher.PreambleFound) and (f_Searcher.BlockType in dd_btParagraphs) then
   exit;
  if f_Searcher.f_SBSFound and (f_Searcher.BlockType in [dd_btHeader1, dd_btDocument, dd_btPseudoDocument, dd_btAppendixOrHeader1]) then
  begin
   f_FirstLevel:= l_BlockType;
  end;
  if f_Searcher.BlockType = dd_btHeader1 then
   f_FirstLevelIndex:= 1;
 end
 else
 begin
  if (f_RemarkInBlock <> dd_btNone) and (f_Searcher.BlockType in dd_btParagraphs) then
   Exit;

  l_IBI:= LastBlock;
  if not l_IBI.WasBlock and
    (l_IBI.BlockType in [dd_btAppendix, dd_btPseudoDocument, dd_btSubAppendix])
     and (f_Searcher.BlockType in [dd_btHeader1, dd_btAppendixOrHeader1]) then
  begin
   if not l_IBI.Closed then
   begin
    l_IBI.Closed:= True;
    if l_IBI.RealType = dd_cbNone then
     l_IBI.BlockName:= l_IBI.BlockName + ' ' + f_Searcher.BlockName;
    f_WasText:= False;
    f_WasEmpty:= False;
   end // not l_BlockInfo.Closed
   else
    l_IBI.WasBlock:= True;
   Exit;
  end; // Проверка на соединение блоков
  l_IBI.WasBlock:= True;
 end; //
 begin
  f_FirstBlock:= False;
  l_BlockInfo:= TddBlockInfo.Create(Editor);
  try
   l_BlockInfo.BlockType:= l_BlockType;
   l_BlockInfo.BlockName:= f_Searcher.BlockName;
   { TODO -oДудко -cОшибка : Нужно присвоить текст }
   l_BlockInfo.Text:= l3PCharLen(f_Searcher.BlockText);
   l_BlockInfo.Closed:= False;

   if (f_CommentStart <> nil)
      and (f_CommentBlock <> dd_cbNone) and not f_WasText then
   begin
    l_BlockInfo.Start:= f_CommentStart;
   end
   else
   if (f_Searcher.BlockType = dd_btFootnoteBody) and (f_FootnoteCursor <> nil)  then
   begin
    l_BlockInfo.Start:= f_FootnoteCursor;
   end
   else
   begin
    l_BlockInfo.Start:= aStart;
   end;
   // Выяснить, а не блок ли здесь?
   l_BlockInfo.RealType:= CheckType(l_BlockInfo.Start, l_Number);
   if l_BlockInfo.RealType = dd_cbNone then
   begin
    if TuneBlocks then
     l_BlockInfo.Number:= -1{Номера блокам присвоятся после настройки  MakeBlockNumber(l_BlockInfo)}
    else
     l_BlockInfo.Number:= MakeBlockNumber(l_BlockInfo)
   end
   else
   begin
    l_BlockInfo.Number:= l_Number;
    l_BlockInfo.BlockName:= '';
    if l_BlockInfo.RealType = dd_cbBlock then
    begin
     l_BlockInfo.Finish:= l_BlockInfo.Start;
     ddMovePBC(aView,l_BlockInfo.Finish, ev_ocBottomRight);
    end;
   end;
   if (f_Searcher.BlockType = dd_btFootnoteBody) and not f_UseFootnotes then
    l_BlockInfo.RealType:= dd_cbOutSide;
   if l_BlockInfo.BlockType in [dd_btAppendix] then
    f_InAppendix:= True;
   if InsertBlock(l_BlockInfo) then
   begin
    f_Current:= l_BlockInfo;
    f_WasText:= False;
    f_WasEMpty:= False;
   end;
  finally
   l3Free(l_BlockInfo);
  end;
 end; // (f_DeepLevel = 0) or ((f_DeepLevel > 0) and (f_BlockStack.Count <= f_DeepLevel))
 if f_CommentStart <> nil then
 begin
  f_CommentStart := nil;
  f_TextAfterComment:= False;
  f_CommentBlock:= dd_cbNone;
 end;
 if f_FootnoteCursor <> nil then
  f_FootnoteCursor := nil;
end;



function TddBlockStructureReplacer.MakeBlockNumber(const aBlockInfo:
    IddBlockInfo): Longint;
begin
(* if (aBlockInfo.Visible) then
 begin*)
  Result := aBlockInfo.Number;
(*  if Result = -1 then
  begin
   Result:= f_UniqueNumber;
   Inc(f_UniqueNumber);
  end; //result = -1
  {$IFDEF Write2Log}
  l3System.Msg2Log('Имя блока - '+ aBlockInfo.BlockName);
  l3System.Msg2Log('Номер блока - '+ IntToStr(Result));
  {$ENDIF}
 end
 else
  Result:= -1;*)
end;

procedure TddBlockStructureReplacer.InsertBlockInDocument(const aView : InevView;
                                                          const BlockInfo: IddBlockInfo);


 procedure lp_CheckTable;
 var
  l_RowPoint: InevBasePoint;
 begin
  l_RowPoint := BlockInfo.Finish.MostInner;
  if (l_RowPoint <> nil) and evIsPointTextInCell(l_RowPoint) then
  begin
   l_RowPoint := l_RowPoint.ParentPoint;
   l_RowPoint := l_RowPoint.ParentPoint;
   l_RowPoint := l_RowPoint.ParentPoint;
   if not l_RowPoint.AtEnd(aView) then
    l_RowPoint.SetAtEnd(aView, True);
  end; // if evIsPointTextInCell(l_RowPoint) then
 end;

var
 l_Obj          : InevObject;
 l_Move         : Boolean;
 l_Point        : InevBasePoint;
 l_Block        : InevRange;
 l_NewBlock     : IevDocumentPart;
 l_AddBlock     : Boolean;
 l_BlockIntf    : IevDocumentPart;
 l_ParaCount    : Longint;
 l_AddToBase    : Boolean;
 l_BlockParent  : Il3Node;
 l_ddBlockParent: IddBlockInfo;
begin
 l_AddBlock := not (BlockInfo.RealType in [dd_cbBlock, dd_cbOutSide]);
 if not BlockInfo.Visible then
  l_AddBlock := False;
 if l_AddBlock then
 begin
  if BlockInfo.BlockType in [dd_btAppendix] then
   f_InAppendix := False;
  if (BlockInfo.Number = -1) then // проверка существования
  begin
   BlockInfo.Number := evGetSubList(TextSource).NewSub.ID;  // получение свободного
   l_AddToBase := True;
  end // (BlockInfo.Number = -1)
  else
   l_AddToBase := False;

  BlockInfo.QueryInterface(Il3Node, l_BlockParent);
  try
   l_BlockParent.QueryInterface(IddBlockInfo, l_ddBlockParent);
   try
    if (l_ddBlockParent.Finish <> nil) and (BlockInfo.Finish <> nil) and
       (l_ddBlockParent.RealType = dd_cbBlock) then
     l_Move := (l_ddBlockParent.Finish.Compare(BlockInfo.Finish) <> 0)
    else
     l_Move := True;
   finally
    l_ddBlockParent := nil;
   end;//try..finally
  finally
   l_BlockParent := nil;
  end;//try..finally
  if l_Move then // - перемещаемся на предыдущий параграф
  begin
   ddMovePBC(aView, BlockInfo.Finish, ev_ocPrevParaBottomRight);
   if BlockInfo.Finish <> nil then
   begin
    lp_CheckTable;
    l_Point := BlockInfo.Finish;
    if not l_Point.Obj.IsSame(BlockInfo.Start.Obj.AsObject) and l_Point.Obj.IsKindOf(k2_typBlock) and not l_Point.AtEnd(aView) then
    begin
     l_Point := l_Point.PointToParentByLevel;
     l_Point.Move(aView, ev_ocPrevParaBottomRight);
     if l_Point <> nil then
      BlockInfo.Finish := l_Point;
    end; // if l_Pos.Obj.IsKindOf(k2_typBlock) then*)
   end; // if BlockInfo.Finish <> nil then
  end; // if l_Move then
  l_Obj := BlockInfo.Start.Obj^;
  if (BlockInfo.Finish <> nil) then
   l_Block := l_Obj.Range(BlockInfo.Start, BlockInfo.Finish.PointToParent(l_Obj))
  else
   l_Block := l_Obj.Range(BlockInfo.Start, nil);
  try
   try
    l_NewBlock:= TextSource.InsertDocumentPart(Editor.View, l_Block as IevRange, BlockInfo.Number, ev_ibInAutoBlock);
    {$IFDEF StopBlocks}
    Abort;
    {$ENDIF}
    if (l_NewBlock <> nil) and (BlockInfo.BlockName <> '') then
     l_NewBlock.Name:= l3PCharLen(BlockInfo.BlockName);
    {$IFNDEF evNotArchi}
    if l_AddToBase then
     LinkServer(Self.Family).SubTbl.AddDocSub(Self.DocID, BlockInfo.Number, PAnsiChar(BlockInfo.BlockName),
                        Length(BlockInfo.BlockName) > 0); // ДОБАВЛЕНИЕ
    {$ENDIF}
   except
    on EAbort do
     raise;
    on E: Exception do
     l3System.Exception2Log(E);
   end;//try..except
  finally
   l_Block := nil;
  end; // try..finally
 end; // BlockInfo.RealType <> dd_ctBlock
end;

function TddBlockStructureReplacer.GetTextSource: TevCustomTextSource;
begin
 if f_Editor <> nil then
  Result:= f_Editor.TextSource
 else
  Result:= nil;
end;

procedure TddBlockStructureReplacer.WhatNotFound(const aText: Boolean; const aCursor: InevBasePoint = nil);
var
 l_LB: IddBlockInfo;
begin
 if aText then
 begin
  f_WasText:= True;
  if f_CommentStart <> nil then
   f_CommentStart := nil;
 end // aText
 else
  f_WasEmpty:= True;
 begin
  l_LB:= LastBlock;
  if aText and l_LB.Closed then
   l_LB.WasBlock:= True
  else
  if not aText and not (l_LB.Closed and l_LB.WasBlock) then
   l_LB.Closed:= True;

  if (not aText) and (l_LB.BlockType = dd_btFootnoteBody) and (aCursor <> nil) then
  begin // Пустая строка заканчивает сноски
   L_LB.Finish:= aCursor;
   InsertBlock(l_LB);
  end;//not aText..
 end; // (not aText) and (l_LB.BlockType = dd_btFootnoteBody) and (aCursor <> nil)
end;

function TddBlockStructureReplacer.LastBlock: IddBlockInfo;
begin
 if f_Current.HasChild then
  f_Current.ChildNode.PrevNode.QueryInterface(IddBlockInfo, Result)
 else
  f_Current.QueryInterface(IddBlockInfo, Result);
end;

function TddBlockStructureReplacer.InsertBlock(const aBlockInfo: IddBlockInfo):
    Boolean;
var
 l_N: Il3Node;
 l_Level: Integer;
begin
 if (aBlockInfo.BlockType = dd_btFootnoteBody) and not UseFootnotes then
  Result:= False
 else
 begin
  aBlockInfo.QueryInterface(Il3Node, l_N);
  Result:= f_Current.InsertChild(l_N) <> nil;
  l_Level:= l_N.GetLevelFor(f_BlockRoot);
  aBlockInfo.Visible:= l_Level <= DeepLevel;
  if aBlockInfo.BlockType = dd_btFootnoteBody then
   aBlockInfo.Visible:= aBlockInfo.Visible and UseFootnotes;
 end;//aBlockInfo.BlockType = dd_btFootnoteBody
end;


procedure TddBlockStructureReplacer.InsertBlockStructure;
var
 l_Pack  : InevOp;
begin
 Screen.Cursor:= crHourGlass;
 try
  with TextSource.Indicator do
  begin
   Start(f_BlockRoot.AllChildrenCount, l3CStr('Расстановка блоков'));
   f_InsertedCount:= 0;
   l_Pack := Editor.StartOp(ev_ocUser + 100);
   try
    _InsertBlock(Editor.View, f_BlockRoot);
   finally
    l_Pack:= nil;
   end;//try..finally
   Finish;
  end;//with TextSource.Indicator
  {$IfNDef Nemesis}
  TextSource.ReloadSubFlags;
  {$EndIf  Nemesis}
 finally
  Screen.Cursor:= crDefault;
 end;//try..finally
end;

function TddBlockStructureReplacer.TuneBlockStructure: Boolean;
{$IFDEF ShowBlockInfo}
procedure ChangeText(const aNode: Il3Node);
var
 l_BI: IddBlockInfo;
 l_S, l_F: Integer;
 l_Level: Integer;
begin
 if aNode.QueryInterface(IddBlockInfo, l_BI) = 0 then
 begin
  if l_BI.Start <> nil then
   l_S:= l_BI.Start.Position
  else
   l_S:= 0;
  if l_BI.Finish <> nil then
   l_F:= l_BI.Finish.Position
  else
   l_F:= 0;
  l_Level:= aNode.GetLevelFor(f_BlockRoot);
  aNode.Text:= PAnsiChar(Format('(Start:%d-Finish:%d) Level:%d', [l_S, l_F, l_Level]))
 end;//aNode.QueryInterface(IddBlockInfo, l_BI) = 0
end;
{$ENDIF ShowBlockInfo}
var
 l_TmpBlock: TddBlockInfo;
 l_Ok: Boolean;
begin
 f_AllDone:= False;
  if f_BlockRoot.HasChild then
  begin
   if TuneBlocks then
   begin
    f_OldReadOnly:= Editor.ReadOnly;
    Editor.ReadOnly:= True;
    with f_Dialog do
    begin
     {$IFDEF ShowBlockInfo}
     f_BlockRoot.IterateF(l3L2NA(@ChangeText));
     {$ENDIF ShowBlockInfo}
     BlockTree.TreeStruct.RootNode:= f_BlockRoot;
     BlockTree.TreeStruct.ExpandSubDir(f_BlockRoot, True, DeepLevel);
     Show;
    end//with f_Dialog
   end//TuneBlocks
   else
    FinalTune(True);
  end//f_BlockRoot.HasChild
  else
   f_AllDone:= True;
end;

procedure TddBlockStructureReplacer.FinalTune(aInsert: Boolean);

 procedure _CorrectBlockNumbers(const aNode: Il3Node);
 var
  l_BI: IddBlockInfo;
  l_N: Longint;
 begin
  if Supports(aNode, IddBlockInfo, l_BI) then
  try
   if l_BI.RealType = dd_cbNone then
   begin
    l_N:= MakeBlockNumber(l_BI);
    l_BI.Number:= l_N;
   end;//l_BI.RealType = dd_cbNone
  finally
   l_BI:= nil;
  end; // Supports
 end;
 
var
 l_TmpBlock: TddBlockInfo;
begin
 { расстановка блоков }
 if aInsert then
 begin
  if TuneBlocks then
  begin
   F_Dialog.Hide;
   l3FillChar(f_BlockNumbers, SizeOf(f_BlockNumbers), 0);
   DeepLevel:= CalcMaxLevel(f_BlockRoot);
   f_BlockRoot.IterateF(l3L2NA(@_CorrectBlockNumbers));
   Editor.ReadOnly:= f_OldReadOnly;
  end;//TuneBlocks
  InsertBlockStructure;
 end//aInsert
 else
 if TuneBlocks then
  Editor.ReadOnly:= f_OldReadOnly;
 f_AllDone:= True;
end;

procedure TddBlockStructureReplacer.OutBlockDescript;
var
 l_String: AnsiString;
begin
(*
  case f_Searcher.BlockType of
   dd_btPart             : l_String:= '  часть';
   dd_btSection          : l_String:= '  раздел';
   dd_btSubSection       : l_String:= '  подраздел';
   dd_btChapter          : l_String:= '  глава';
   dd_btReport           : l_String:= '  протокол';
   dd_btRegulations      : l_String:= '  регламент';
   dd_btIndex            : l_String:= '  перечень';

   dd_btTitle            : l_String:= '  название документа';
   dd_btArticle          : l_String:= '  статья';
   dd_btPreamble         : l_String:= '  преамбула';
   dd_btAppendix         : l_String:= '  приложение';
   dd_btHeader1          : l_String:= '  просто заголовок';
   dd_btParagraphArabic  : l_String:= '  пункт с арабской нумерацией';
   dd_btParagraphRoman   : l_String:= '  пункт с римской нумерацией';
   dd_btDocument         : l_String:= '  Документ от преамбулы до конца';
   dd_btSBS              : l_String:= '  подпись - конец блока';
   dd_btRemark           : l_String:= '  Примечание - до конца текущего блока не ставить пункты';
   dd_btPseudoDocument   : l_String:= '  Приложение без номера';
   dd_btComment          : l_String:= '  Встретился комментарий - закрывает пункты';
   dd_btSubAppendix      : l_String:= '  Часть приложения';
   dd_btContentTable     : l_String:= '  Оглавление - закрывает пункты';
   dd_btSectionArabic    : l_String:= '  Арабские цифры';
   dd_btSectionRoman     : l_String:= '  Римские цифры';
   dd_btSectionLatin     : l_String:= '  Латинские буквы';
   dd_btSectionCyr       : l_String:= '  Русские буквы';
   dd_btSubSectionArabic : l_String:= '  подраздел';
   dd_btStartFootnote    : l_String:= '  горизонтальная линия (по ней запоминается курсор)';
   dd_btFootnoteBody     : l_String:= '  тело сноски';
   dd_btAskReply         : l_String:= '  Вопрос-ответ';
   dd_btSubOnEmpty        : l_String:= ' метка на пустом абзаце для использования с комментарием';
   dd_btAppendixOrHeader1 : l_String:= ' либо Приложение, либо Заголовок';
   dd_btMayBeSBS          : l_String:= ' Спорная подпись';
   dd_btParagraphSign     : l_String:= ' Символ абзаца';
   dd_btParagraphXX       : l_String:= ' пункт с арабской нумерацией X.X.';
   dd_btParagraphXXX      : l_String:= ' пункт с арабской нумерацией X.X.X.';
   dd_btParagraphXXXX     : l_String:= ' пункт с арабской нумерацией X.X.X.X.';
   dd_btParagraphXXXXX    : l_String:= ' пункт с арабской нумерацией X.X.X.X.X';
   dd_btParagraphXXXXXX   : l_String:= ' пункт с арабской нумерацией X.X.X.X.X.X';
   dd_btParagraphLatin    : l_String:= ' пункт с нумерацией латиницей';
   dd_btParagraphCyr      : l_String:= ' пункт с нумерацией кириллицей';
  else
   l_String:= 'Просто абзац. Вернее, полный';
  end; // Case
  l3System.Msg2Log(l_String);
*)
  l3System.Msg2Log(' '+GetEnumName(TypeInfo(TddBlockType),Ord(f_Searcher.BlockType)));
end;

procedure TddBlockStructureReplacer.CheckComment(const aStart: InevBasePoint);
begin
  if f_Searcher.BlockType = dd_btComment then
   ProcessComment(aStart)
  else
  begin
   f_EmptyParaCursor := nil;
   if f_CommentStart <> nil then
   begin
    if f_Searcher.BlockType = dd_btContentTable then
     f_CommentStart := nil
    else
     f_TextAfterComment:= f_WasText {or not f_Searcher.WasEmpty};
   end;//f_CommentStart <> nil
  end;//f_Searcher.BlockType = dd_btComment
end;

function TddBlockStructureReplacer.CheckFootnote(const aStart: InevBasePoint): Boolean;
begin
  Result := False;
  if f_Searcher.BlockType = dd_btStartFootnote then
  begin
   if f_FootnoteCursor <> nil then
    f_FootnoteCursor := nil;
   f_FootnoteCursor:= aStart.ClonePoint(Editor.View);
   Result:= True;
  end//f_Searcher.BlockType = dd_btStartFootnote
  else
  if (f_Searcher.BlockType  <> dd_btFootnoteBody) and (f_FootnoteCursor <> nil) then
  begin
   f_FootnoteCursor := nil;
   Result:= False;
  end;//f_Searcher.BlockType  <> dd_btFootnoteBody..
end;

function TddBlockStructureReplacer.CheckEmptyPara(const aStart: InevBasePoint): Boolean;
begin
  if f_Searcher.BlockType  = dd_btSubOnEmpty then
  begin
   f_EmptyParaCursor := nil;
   f_EmptyParaCursor:= aStart.ClonePoint(Editor.View);
   Result:= True;
  end//f_Searcher.BlockType  = dd_btSubOnEmpty
  else
   Result := False;
end;

procedure TddBlockStructureReplacer.CloseOpenBlocks(const aView : InevView;const aStart, aFinish: InevBasePoint; 
    ForDeepLevel: Integer);
var
 //l_MoveCursorNext: Boolean;
 l_Pos: InevBasePoint;
 l_BI: IddBlockInfo;
begin
  if (f_CommentStart <> nil) and (f_CommentBlock <> dd_cbNone) and
      not f_TextAfterComment then
   l_Pos:= f_CommentStart.ClonePoint(Editor.View)
  else
  if f_FootnoteCursor <> nil then
   l_Pos:= f_FootnoteCursor.ClonePoint(Editor.View)
  else
  begin
   if (Searcher.BlockType = dd_btSBS) then
   begin
    l_Pos := EvPrevOverallPara(aStart.MostInner.Obj.AsPara).MakePoint;
    l_Pos.Move(aView, ev_ocBottomRight);
    l_Pos := l_Pos.PointToParentByLevel(MaxInt);
    Assert(l_Pos <> nil);
   end // if (Searcher.BlockType = dd_btSBS) or (l_Pos.Obj.IsKindOf(k2_typBlock)) then
   else
    l_Pos := aFinish.ClonePoint(Editor.View);
  end;//f_FootnoteCursor <> nil
  try
   f_Current.QueryInterface(IddBlockInfo, l_BI);
   while ForDeepLevel <> 0 do
   begin
    if l_BI.BlockType = f_RemarkInBlock then
     f_RemarkInBlock:= dd_btNone;
    if l_BI.RealType <> dd_cbBlock then
     l_BI.Finish:= l_Pos;
    //l_MoveCursorNext:= False;
    if (f_CommentStart <> nil) and
       (Pred(l_BI.Finish.Position) > f_CommentStart.Position) then
    begin
     f_CommentStart := nil;
     f_TextAfterComment:= False;
     f_CommentBlock:= dd_cbNone;
    end; // (f_CommentStart <> nil) and (Pred(aBlock.Finish.Position) > f_CommentStart.Position)
    Dec(ForDeepLevel);
    f_Current:= f_Current.ParentNode;
    f_Current.QueryInterface(IddBlockInfo, l_BI);
    l_BI.AdjustBorders;
   end; // while
   if not (f_Searcher.BlockType in [dd_btSBS, dd_btComment, dd_btContentTable]) then
   begin
    if f_Searcher.BlockType = dd_btFootnoteBody then
     StartBlock(aView,l_Pos)
    else
     StartBlock(aView,aStart)
   end//not (f_Searcher.BlockType in [dd_btSBS, dd_btComment, dd_btContentTable])
   //else
   //if l_MoveCursorNext then
   // ddMovePBC(aView,aFinish, ev_ocNextParaTopLeft);
  finally
   l_Pos := nil;
  end;//try..finally
end;

procedure TddBlockStructureReplacer.pm_SetEditor(aValue: TevCustomEditor);
begin
 f_Editor := aValue;
 if (f_BlockRoot <> nil) then
  f_BlockRoot.f_Editor := aValue;
end;

end.
