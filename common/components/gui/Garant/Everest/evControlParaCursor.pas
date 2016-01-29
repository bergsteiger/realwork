unit evControlParaCursor;
{* Курсор, для параграфа, представляющего виджет ввода. }

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: evControlParaCursor - }
{ Начат: 12.11.2004 17:02 }
{ $Id: evControlParaCursor.pas,v 1.83 2015/02/26 10:01:28 kostitsin Exp $ }

// $Log: evControlParaCursor.pas,v $
// Revision 1.83  2015/02/26 10:01:28  kostitsin
// Analy*s -> Analyze
//
// Revision 1.82  2015/02/26 09:28:58  kostitsin
// List*ner -> Listener
//
// Revision 1.81  2015/02/25 13:53:17  kostitsin
// List*ner -> Listener
//
// Revision 1.80  2014/04/08 12:35:09  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.79  2014/04/07 17:56:59  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.78  2014/04/04 17:53:34  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.77  2013/11/05 12:18:00  morozov
// {RequestLink: 290950884}
//
// Revision 1.76  2013/04/24 09:35:36  lulin
// - портируем.
//
// Revision 1.75  2013/04/04 11:18:51  lulin
// - портируем.
//
// Revision 1.74  2012/11/27 11:50:36  dinishev
// {Requestlink:410628348}
//
// Revision 1.73  2012/09/18 11:40:03  dinishev
// {Requestlink:385975073}
//
// Revision 1.72  2011/09/15 18:32:06  lulin
// {RequestLink:278824896}.
//
// Revision 1.71  2011/01/26 11:36:53  lulin
// {RequestLink:251343230}.
//
// Revision 1.70  2010/12/08 11:11:39  lulin
// {RequestLink:228688602}.
// - подружил дерево с внешней кнопкой.
// - поправил размеры новой формы БП.
//
// Revision 1.69  2010/06/11 12:41:33  oman
// - fix: {RequestLink:217688302}
//
// Revision 1.68  2009/07/23 13:42:10  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.67  2009/07/23 08:14:38  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.66  2009/07/11 15:55:09  lulin
// {RequestLink:141264340}. №22.
//
// Revision 1.65  2009/07/10 15:04:43  lulin
// - избавляемся от лишнего дёрганья счётчиков ссылок.
//
// Revision 1.64  2009/07/08 15:51:58  lulin
// {RequestLink:141264340}. №7.
//
// Revision 1.63  2009/06/18 18:35:07  lulin
// {RequestLink:142613457}.
//
// Revision 1.62  2009/06/17 17:38:37  lulin
// {RequestList:142613919}. №5.
//
// Revision 1.61  2009/04/13 17:27:50  lulin
// [$142613919]. Переносим базовый курсор на модель.
//
// Revision 1.60  2009/04/13 16:13:52  lulin
// [$142613919]. Все виртуальные методы переносим на модель.
//
// Revision 1.59  2009/04/13 14:19:54  lulin
// [$142613919]. Выделяем виртуальный метод обработки сообщений.
//
// Revision 1.58  2009/04/13 12:32:48  lulin
// [$142613919].
//
// Revision 1.57  2009/04/06 07:56:44  lulin
// [$140837386]. Убираем старорежимную примесь для тестовых параграфов.
//
// Revision 1.56  2009/04/03 17:51:27  lulin
// [$140837386]. Ликвидируем старорежимную примесь.
//
// Revision 1.55  2008/04/24 15:22:11  lulin
// - изменения в рамках <K>: 89106312.
//
// Revision 1.54  2008/04/14 13:46:35  lulin
// - <K>: 89096854.
//
// Revision 1.53  2008/04/11 11:29:58  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.52  2008/04/09 17:57:07  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.51  2008/04/09 14:14:12  lulin
// - <K>: 89098826.
//
// Revision 1.50  2008/04/07 08:52:18  lulin
// - <K>: 89096358.
//
// Revision 1.49  2008/03/03 20:05:45  lulin
// - <K>: 85721135.
//
// Revision 1.48  2008/02/13 13:51:14  oman
// - fix: В маскируемые поля не даем вставлять слишком длинный текст (cq28439)
//
// Revision 1.47  2008/02/13 12:56:07  oman
// Опечатка
//
// Revision 1.46  2008/01/29 12:03:30  oman
// - new: Новая логика удаления в полях даты (cq10543)
//
// Revision 1.45  2007/12/04 12:46:59  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.42.4.110  2007/09/26 12:25:37  lulin
// - добавлен еще один флаг текстовой операции _misfSetText - для того, чтобы указать, что это установка текст. Починило отвалившуюся валидацию текста, вставляемого из буфера обмена (CQ OIT5-26801).
//
// Revision 1.42.4.109  2007/09/20 13:22:47  lulin
// - bug fix: терялась выбранная нода, в итоге получали список всех документов (CQ OIT5-26772).
//
// Revision 1.42.4.108  2007/09/19 13:30:19  lulin
// - при установке текста успользуем прямую вставку - без всяких пользовательских умничаний.
//
// Revision 1.42.4.107  2007/09/14 13:26:04  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.42.4.106.2.2  2007/09/12 16:14:07  lulin
// - убран ненужный параметр по-умолчанию.
//
// Revision 1.42.4.106.2.1  2007/09/12 15:23:00  lulin
// - избавляемся от метода, дублирующего функциональность получения атрибута.
//
// Revision 1.42.4.106  2007/08/10 19:01:28  lulin
// - cleanup.
//
// Revision 1.42.4.105  2007/07/18 15:07:18  lulin
// - выпрямляем зависимости. Схема документа, теперь не зависит от Эвереста.
//
// Revision 1.42.4.104  2007/06/22 18:59:53  lulin
// - cleanup.
//
// Revision 1.42.4.103  2007/06/15 12:44:16  lulin
// - переименован метод - для читабельности (<K>-19759257).
//
// Revision 1.42.4.102  2007/05/18 15:15:46  lulin
// - убран ненужный параметр.
//
// Revision 1.42.4.101  2007/02/14 14:24:11  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.42.4.100  2007/01/10 11:18:46  oman
// - fix: При вводе поверх выделения в маскированных полях
//  неправильно ставилась каретка (cq24019) - merge
//
// Revision 1.42.4.99  2006/11/20 15:28:31  lulin
// - cleanup: не используем карту форматирования от курсора, т.к. мы можем получить "настоящую".
//
// Revision 1.42.4.98  2006/11/16 11:43:41  oman
// Merge from B_NEMESIS_6_4
//
// Revision 1.42.4.97  2006/11/13 15:11:18  lulin
// - bug fix: не перемещались в конец консультации.
//
// Revision 1.42.4.96  2006/11/10 17:15:54  lulin
// - объединил с веткой.
//
// Revision 1.42.4.95  2006/11/03 11:00:03  lulin
// - объединил с веткой 6.4.
//
// Revision 1.42.4.94.2.1.4.5  2006/11/16 11:41:46  oman
// - fix: Для полей с маской не обрабатывалась ситуация с BackSpace в
//  первой позиции (cq23599)
//
// Revision 1.42.4.94.2.1.4.4  2006/11/13 15:13:34  lulin
// - bug fix: не перемещались в конец консультации.
//
// Revision 1.42.4.94.2.1.4.3  2006/11/09 14:34:08  lulin
// - показываем курсор для контролов типа TextParaLabel.
//
// Revision 1.42.4.94.2.1.4.2  2006/11/09 14:20:07  lulin
// - cleanup.
//
// Revision 1.42.4.94.2.1.4.1  2006/11/09 13:36:51  lulin
// - cleanup.
//
// Revision 1.42.4.94.2.1  2006/10/26 08:53:42  lulin
// - убрано ненужное свойство.
//
// Revision 1.42.4.94  2006/10/10 12:06:12  lulin
// - cleanup.
//
// Revision 1.42.4.93  2006/10/10 11:53:48  oman
// - fix: Более корректно проверяем конец абзаца
//
// Revision 1.42.4.92  2006/10/10 11:35:16  oman
// - fix: Более корректно проверяем конец абзаца
//
// Revision 1.42.4.91  2006/10/02 12:30:05  oman
// - fix: При добавлении параграфа в мемо всегда возвращаем успех
// (cq22817)
//
// Revision 1.42.4.90  2006/09/21 11:38:17  oman
// - fix: Мемо поле в КЗ стало многострочным (cq22635)
// - fix: Не работал Backspace (cq22639)
//
// Revision 1.42.4.89  2006/09/18 09:06:16  oman
// - fix: Корректная проверка правильности ввода
// - fix: Корректное ограничение на длину полей
//
// Revision 1.42.4.88  2006/06/16 08:31:32  dinishev
// В качествке разелителя при вставке из буфера используется пробел
//
// Revision 1.42.4.87  2006/06/15 16:15:58  dinishev
// Bug fix: убиралось разделение на строки при вставке из буфера обмена.
//
// Revision 1.42.4.86  2006/06/09 08:44:03  dinishev
// Использование одной операции для кнопок видимости кнопок и добавления текста
//
// Revision 1.42.4.85  2006/06/08 13:37:48  lulin
// - подготавливаем контролы к обработке числа повторений нажатия клавиши.
//
// Revision 1.42.4.84  2006/06/06 14:40:35  dinishev
// Cleanup
//
// Revision 1.42.4.83  2006/05/24 15:47:08  dinishev
// Bug fix: отъехало нажатие Ctrl+C
//
// Revision 1.42.4.82  2006/05/24 06:23:22  oman
// - fix: глотались символы в поле даты (cq21055)
//
// Revision 1.42.4.81  2006/05/23 16:24:51  dinishev
// Bug fix: застревание курсора в полях дат
//
// Revision 1.42.4.80  2006/05/22 11:58:42  dinishev
// Bug fix: была воможность вводить символы вместо цифр в поля с датами
//
// Revision 1.42.4.79  2006/05/18 13:31:02  dinishev
// Bug fix: в поля дат можно было ввести заглавные буквы
//
// Revision 1.42.4.78  2006/05/17 15:45:49  dinishev
// Возможность перемещения курсора по группам с помощью табуляции
//
// Revision 1.42.4.77  2006/05/15 15:34:15  dinishev
// Bug fix: выходили за пределы многострочного поля
//
// Revision 1.42.4.76  2006/05/06 09:24:52  dinishev
// Общие безопасные функции для получения контрола от параграфа.
//
// Revision 1.42.4.75  2006/05/05 14:03:04  dinishev
// _CleanUp
//
// Revision 1.42.4.74  2006/05/04 14:09:55  dinishev
// _CleanUp
//
// Revision 1.42.4.73  2006/04/20 14:45:24  dinishev
// Bug fix: некорректная вставка года с двумя цифрами
//
// Revision 1.42.4.72  2006/04/18 16:03:05  dinishev
// Новый вид контролов для шаблона консультации
//
// Revision 1.42.4.71  2006/04/14 13:50:44  dinishev
// Cleanup
//
// Revision 1.42.4.70  2006/04/12 15:11:23  dinishev
// Перенос кода из _DoMove в редактор
//
// Revision 1.42.4.69  2006/04/11 14:53:11  dinishev
// Cleanup
//
// Revision 1.42.4.68  2006/04/10 14:49:46  dinishev
// Cleanup
//
// Revision 1.42.4.67  2006/03/29 13:21:38  dinishev
// Bug fix: курсор в контролах с многострочным текстом не перемещался по строчкам стрелками вниз/вверх
//
// Revision 1.42.4.66  2006/03/28 15:22:35  dinishev
// Bug fix: AV в ППР при удалении второго поля в реквизите 'Тип'
//
// Revision 1.42.4.65  2006/03/27 13:35:48  dinishev
// Bug fix: после последней строки в многострочном контроле курсор перехадил на текстовое поле.
//
// Revision 1.42.4.64  2006/03/24 14:56:58  dinishev
// Вставка нескольких строк из буфера в многострочное поле.
//
// Revision 1.42.4.63  2006/03/17 14:29:42  dinishev
// Неправильная реакция на стрелки вниз и вверх
//
// Revision 1.42.4.62  2006/03/15 15:01:50  dinishev
// Обработка вставки большой строки из буфера
//
// Revision 1.42.4.61  2006/03/14 15:42:04  dinishev
// Обработка максимально допустимого числа строк
//
// Revision 1.42.4.60  2006/03/14 15:31:01  dinishev
// Bug fix: перестала копироваться дата
//
// Revision 1.42.4.59  2006/03/03 12:52:46  dinishev
// Comments
//
// Revision 1.42.4.58  2006/02/10 11:12:40  dinishev
// Bug fix: блокировалось снятие выделения в поле с датой
//
// Revision 1.42.4.57  2006/01/13 11:56:03  lulin
// - bug fix: в более корректный момент сбрасываем дюймовые координаты курсора.
//
// Revision 1.42.4.56  2005/12/19 13:57:20  dinishev
// Bug fix: утечка памяти
//
// Revision 1.42.4.55  2005/12/15 15:51:47  dinishev
// Cleanup
//
// Revision 1.42.4.54  2005/12/14 15:54:19  dinishev
// Cleanup
//
// Revision 1.42.4.53  2005/12/13 15:01:50  dinishev
// Cleanup
//
// Revision 1.42.4.52  2005/12/13 14:46:17  dinishev
// Bug fix: некорректная обработка символа '*' для контекстных полей
//
// Revision 1.42.4.51  2005/12/12 18:19:28  dinishev
// Bug fix: ошибка в определении пустого значения даты
//
// Revision 1.42.4.50  2005/12/12 17:15:01  dinishev
// Cleanup
//
// Revision 1.42.4.49  2005/11/28 17:56:45  dinishev
// Cleanup
//
// Revision 1.42.4.48  2005/11/25 15:18:05  lulin
// - bug fix: падали, при исчезании контрола в процессе обработки клавиш.
//
// Revision 1.42.4.47  2005/11/17 13:19:19  dinishev
// _CleanUp
//
// Revision 1.42.4.46  2005/11/09 18:43:56  dinishev
// Bug fix: решение проблемы с AV при откатке (не передавали параграф с правильным _View)
//
// Revision 1.42.4.45  2005/11/09 15:28:23  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.42.4.44  2005/11/04 16:42:08  dinishev
// Подправлено реакция на стрелки вниз и вверх CQ17764
//
// Revision 1.42.4.42  2005/10/28 13:46:28  dinishev
// _CleanUp
//
// Revision 1.42.4.41  2005/10/27 14:21:15  dinishev
// Bug fix: поведение курсора при нажатии на стрелки
//
// Revision 1.42.4.40  2005/10/27 13:47:03  dinishev
// Bug fix: поведение курсора при нажатии на стрелки
//
// Revision 1.42.4.39  2005/10/22 12:40:27  dinishev
// Bug fix: не вводилась первая цифра в календарь
//
// Revision 1.42.4.38  2005/10/21 16:20:08  dinishev
// _CleanUp
//
// Revision 1.42.4.37  2005/10/20 15:18:08  dinishev
// Обработка запятой и точки с запятой в контестных полях
//
// Revision 1.42.4.36  2005/10/20 15:05:31  dinishev
// Обработка запятой и точки с запятой в контестных полях
//
// Revision 1.42.4.35  2005/10/14 13:39:46  dinishev
// "Родное" для КЗ поведение BackSpace
//
// Revision 1.42.4.34  2005/10/12 16:39:14  dinishev
// _CleanUp
//
// Revision 1.42.4.33  2005/10/06 13:04:30  lulin
// - подготавливаем параграфы к тому, чтобы форматирование не хранилось вместе с данными.
//
// Revision 1.42.4.32  2005/09/28 12:22:59  dinishev
// Bug fix: рисовался курсор с рамкой для задизейбленных контролов.
//
// Revision 1.42.4.31  2005/09/23 16:03:54  lulin
// - выделен модуль с общими интерфейсами.
//
// Revision 1.42.4.30  2005/09/21 13:52:54  dinishev
// Поддержка свойства Enabled (текст в контролах не редакторуется, отрисовываются серым цветом (без заливки))
//
// Revision 1.42.4.29  2005/09/20 14:41:40  dinishev
// Управление движением курсора
//
// Revision 1.42.4.28  2005/09/16 15:04:01  dinishev
// Первое приближение обработки гиперссылок + автоматическое формирование значений + проверка E-mail
//
// Revision 1.42.4.27  2005/09/14 13:47:46  dinishev
// Переделано поведение курсора по табуляции - теперь курсор не устанавливается на невидимые элементы + Bug fix: перестали передаваться значения из окна выбора реквизитов.
//
// Revision 1.42.4.26  2005/09/08 09:13:36  dinishev
// Проверка на изменения текста в поле
//
// Revision 1.42.4.25  2005/09/07 09:05:11  dinishev
// Remove interface InevInputListener
//
// Revision 1.42.4.24  2005/08/31 17:25:45  dinishev
// Вернул старую версию преобразования строки.
//
// Revision 1.42.4.23  2005/08/30 11:13:15  lulin
// - bug fix: был неинициализирован результат.
//
// Revision 1.42.4.22  2005/08/30 11:03:02  lulin
// - bug fix: после backspace портилась КЗ.
//
// Revision 1.42.4.21  2005/08/29 15:03:05  lulin
// - cleanup.
//
// Revision 1.42.4.20  2005/08/25 14:08:44  dinishev
// Перехватываем добавление строки с помощью Enter'а
//
// Revision 1.42.4.19  2005/08/23 13:29:45  dinishev
// Cleanup
//
// Revision 1.42.4.18  2005/07/27 19:25:36  lulin
// - избавился от глобальных объектов для КЗ - теперь с каждым редактором связана своя обвязка для карточки запроса.
//
// Revision 1.42.4.17  2005/07/27 16:07:03  lulin
// - переупорядочил наименование и расположение интерфейсов для КЗ.
//
// Revision 1.42.4.16  2005/07/27 14:47:52  lulin
// - вместо безликих констант, для результата перемещения курсора введен перечислимый тип.
//
// Revision 1.42.4.15  2005/07/27 14:29:58  lulin
// - bug fix: пропадали команды движения курсора.
//
// Revision 1.42.4.14  2005/07/26 14:11:18  lulin
// - убраны лишние параметры в методе трансляции сообщений.
//
// Revision 1.42.4.13  2005/07/22 16:00:39  dinishev
// Убраны ссылки на скрипты
//
// Revision 1.42.4.12  2005/07/22 14:59:29  dinishev
// Поддержка промежуточного слоя
//
// Revision 1.42.4.11  2005/07/19 12:03:19  lulin
// - cleanup: удалены ненужные модули и методы.
//
// Revision 1.42.4.10  2005/07/19 11:33:07  lulin
// - окончательно избавился, от функциональности, работающей через посылку сообщений.
//
// Revision 1.42.4.9  2005/07/18 15:10:26  lulin
// - избавляемся от косвенного приведения одного интерфейса к другому.
//
// Revision 1.42.4.8  2005/07/13 13:03:45  lulin
// - спрятан ненужный интерфейс.
//
// Revision 1.42.4.7  2005/07/13 12:55:36  lulin
// - new behavior: при трансляции клавиш передаем _View в операцию трансляции.
//
// Revision 1.42.4.6  2005/06/21 13:13:08  lulin
// - cleanup: удалены ненужные методы.
//
// Revision 1.42.4.5  2005/06/15 17:23:51  lulin
// - remove proc: _evMoveCursor.
//
// Revision 1.42.4.4  2005/06/14 12:38:58  lulin
// - избавился от передачи безликого интерфейса (теперь передается _View).
//
// Revision 1.42.4.3  2005/06/08 10:18:30  lulin
// - вместо объекта используем интерфейс.
//
// Revision 1.42.4.2  2005/05/31 15:57:20  lulin
// - изживаем остатки объектов в качестве курсоров.
//
// Revision 1.42.4.1  2005/05/18 12:42:46  lulin
// - отвел новую ветку.
//
// Revision 1.40.2.2  2005/05/18 12:32:07  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.40.2.1  2005/04/28 09:18:28  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.41.2.2  2005/04/23 16:07:24  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.41.2.1  2005/04/21 14:46:54  lulin
// - избавляемся от обертки над тегами - теперь объекты посредством шаблонов сами реализуют интерфейс _Ik2Tag.
//
// Revision 1.41  2005/04/20 17:40:50  lulin
// - избавился от промежуточного интерфейса Ik2TagBoxQT.
//
// Revision 1.42  2005/04/28 15:03:37  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.41.2.2  2005/04/23 16:07:24  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.41.2.1  2005/04/21 14:46:54  lulin
// - избавляемся от обертки над тегами - теперь объекты посредством шаблонов сами реализуют интерфейс _Ik2Tag.
//
// Revision 1.41  2005/04/20 17:40:50  lulin
// - избавился от промежуточного интерфейса Ik2TagBoxQT.
//
// Revision 1.40  2005/04/06 08:47:17  lulin
// - связываем инструменты в цепочки для более быстрого получения интересующего инструмента.
//
// Revision 1.39  2005/03/30 15:56:23  lulin
// - _TevLocation теперь наследуется от Tk2Tool - базового класса для инструментов тегов.
//
// Revision 1.38  2005/03/23 11:48:03  lulin
// - вызов метода заменен на обращение к свойству.
//
// Revision 1.37  2005/03/23 09:51:58  lulin
// - new prop: _Ik2Tag.BoolA.
//
// Revision 1.36  2005/03/10 17:44:02  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.35  2005/02/25 07:10:10  dinishev
// no message
//
// Revision 1.34  2005/02/11 08:21:29  dinishev
// _CleanUp
//
// Revision 1.33  2005/01/21 08:54:31  dinishev
// Переключение между контролами по Tab и Shift-Tab
//
// Revision 1.32  2005/01/21 08:28:56  dinishev
// Удален лишний код
//
// Revision 1.31  2005/01/20 16:55:02  dinishev
// Небольшая коррекция
//
// Revision 1.30  2005/01/20 11:25:12  dinishev
// Реакция на _button-подобных компонентах на Enter совпадает с щелчком мыши.
//
// Revision 1.29  2005/01/19 17:01:03  lulin
// - в очередной раз вычищен ненужный модуль.
//
// Revision 1.28  2005/01/19 15:29:31  dinishev
// Запрет реакции на Enter в контролах
//
// Revision 1.27  2005/01/18 13:19:56  dinishev
// Отказ от тега IsMasked
//
// Revision 1.26  2005/01/18 09:20:44  dinishev
// Запрет на ввод строки больше маски для редактора с датой.
//
// Revision 1.25  2005/01/17 16:47:42  dinishev
// Подправлена работа редактора с маской ввода даты
//
// Revision 1.24  2005/01/14 10:03:18  dinishev
// Подправлено поведение кнопки на сворачивающей панели. Теперь она себя ведет как реальная Flat-кнопка
//
// Revision 1.23  2005/01/14 09:29:27  dinishev
// Проверка была сделана некорректно, поэтому отъехало движение курсора вообще
//
// Revision 1.22  2005/01/14 09:00:22  dinishev
// В evmsgMove включена проверка на IsMasked
//
// Revision 1.21  2005/01/13 07:53:27  dinishev
// В DoInsertString и DoDeleteString вызывается inherited для не Masked-контрола.
//
// Revision 1.20  2005/01/12 12:00:34  dinishev
// New comment
//
// Revision 1.19  2004/12/29 13:04:02  dinishev
// Отслеживание изменения формата даты
//
// Revision 1.18  2004/12/28 15:54:39  dinishev
// подправлена работа с MaskEdit - более надежный ввод символов,
//
// Revision 1.17  2004/12/27 16:41:36  dinishev
// Немного изменена логика проверки на символ разделителя
//
// Revision 1.16  2004/12/24 15:30:57  dinishev
// Обработка реакции на добавление и удаление символов. Более корректная проверка вводимых данных.
//
// Revision 1.15  2004/12/23 15:20:41  dinishev
// Новый модуль evMaskTools.pas с общими процедурами для MaskEdit.pas
//
// Revision 1.14  2004/12/22 15:11:23  dinishev
// Подправлена фильтрация вводимых с клавиатуры символов.
//
// Revision 1.13  2004/12/21 16:27:24  dinishev
// Фильтрация вводимых данных с клавиатуры для редактора с календарем
//
// Revision 1.12  2004/12/20 16:44:34  dinishev
// проверка свойства IsMasked и методы для проверки даты на корректность при вводе с клавиатуры
//
// Revision 1.11  2004/12/16 14:17:31  lulin
// - bug fix: двоились ShortCut'ы.
//
// Revision 1.10  2004/11/30 17:47:34  dinishev
// Реализация выпадающего дерева для CombobBox'а. Некоторые исправления отображения.
//
// Revision 1.9  2004/11/19 16:33:00  lulin
// - bug fix: съедались двухбуквенные ShortCut'ы.
//
// Revision 1.8  2004/11/16 16:08:57  dinishev
// Изменена прорисовка контролов, в том числе и для тем, включена поддержка свойств
// Enabled и Flat.
//
// Revision 1.7  2004/11/13 16:15:24  lulin
// - new behavior: для нередактируемых контролов особым образом обрабатываем движение курсора.
//
// Revision 1.6  2004/11/13 15:46:01  lulin
// - new behavior: рисуем рамку вокруг параграфа с формулой.
//
// Revision 1.5  2004/11/13 15:15:47  lulin
// - new behavior: для нередактируемых контролов запрещено редактирование текста.
//
// Revision 1.4  2004/11/13 14:28:25  lulin
// - new behavior: для контролов Check и Radio обрабатываем клавиатуру.
//
// Revision 1.3  2004/11/13 14:06:52  lulin
// - new behavior: рисуем рамку вокруг текущего контрола с Check'ом или Radio.
//
// Revision 1.2  2004/11/13 13:49:27  lulin
// - new behavior: рисуем рамку вокруг текущей кнопки.
//
// Revision 1.1  2004/11/12 14:10:47  lulin
// - new unit: evControlParaCursor.
//

{$Include evDefine.inc }

interface

uses
  Messages,

  l3IID,
  l3Types,
  l3Base,
  l3Interfaces,
  l3InternalInterfaces,

  k2Interfaces,

  evdTypes,

  evInternalInterfaces,
  evQueryCardInt,
  evMsgCode,
  evTextParaCursor,

  nevBase,
  nevTools
  ;

type
  TevSeparatorType = (stNotSeparator,
                      stSeparator,
                      stOutOfLine);

  TevControlParaCursor = class(TevTextParaCursor)
  private
   f_DateFormat : string;
    {-}
   f_EditMask   : string;
    {-}
   function GetIsValid: Boolean;
    {-}
   procedure SetIsValid(const Value: Boolean);
    {-}
   procedure UpdateMask;
    {* - Обновляет маску. }
   function CheckedDateFormat: string;
    {-}
  protected
    // internal methods
   function DoMovePrim(const aView : InevView;
                       aCode      : Long;
                       const anOp : InevOp;
                       aCount     : Integer): TnevMoveResult;
    override;
     {-}
   function Validate(const Value: Il3CString): Boolean;
     {* - Проверяет введенную строку. }
   procedure CompareWithDateFormat(Value: Tl3String; const aPos: Integer);
     {* - Подгоняет строку под дату. }
   function IsSeparatorChar(Value: Integer): TevSeparatorType;
     {* - Проверяет символ в позиции Value на признак разделителя. }
   procedure ExtractFormatChars(aStr: Tl3String; const aPos: Integer);
     {-}
   procedure AppendToFormatChars(aStr: Tl3String; const aPos: Integer);
     {-}
   function DoInsertBreak(const aView : InevView;
                        aDrawLines     : Boolean = false;
                         const anOp : InevOp = nil): Boolean;
    override;
     {-}
   function DoJoinWithNext(const aView : InevView;
                           const anOp : InevOp = nil): Boolean;
     override;
     {-}
  public
   function DoDeleteString(const aView : InevView;
                           aCount     : Long;
                           const anOp : InevOp = nil;
                           aFlags     : TnevInsertStringFlags = []): Boolean;
     override;
     {-}
   function DoInsertString(const aView : InevView;
                           const aString    : Il3CString;
                           const anOp : InevOp = nil;
                           InsertMode : Boolean = true;
                           aFlags     : TnevInsertStringFlags = []): Boolean;
    override;
     {-}
    // public methods
   function ControlType: TevControlType;
     {-}
   function Enabled: Boolean;
     {-}
   function IsMasked: Boolean;
     {-}
   function Checked: Boolean;
     {-}
   function GetReadOnly: Boolean;
     override;
     {-}
   function GetNeedWindowsCaret: Boolean;
     override;
     {-}
   function DoProcessMessage(const aView    : InevControlView;
                           var   aMessage : TMessage;
                           aTime          : Cardinal): Boolean;
     override;
     {-}
   function EditMask: string;
     {* - Шаблон маски. }
   property Valid: Boolean read GetIsValid write SetIsValid;
     {* - Признак корректности данных. Выставляется процедурой Validate. }
  end;//TevControlParaCursor

implementation

uses
  Windows,

  Classes,
  SysUtils,
  MaskUtils,

  Forms,

  l3Chars,
  l3String,
  l3Date,
  l3MinMax,
  l3InterfacedString,

  OvcCmd,
  OvcConst,

  k2Base,
  k2Tags,
  k2TagGen,

  evOp,
  evExcept,
  evMaskTools,
  evHotSpotMisc,
  evParaTools,
  evTextParaTools,
  evCursorTools,

  evCursorConst,
  evControlParaTools,
  evControlParaConst  
  ;

// start class TevControlParaCursor

function TevControlParaCursor.DoMovePrim(const aView : InevView;
                                         aCode      : Long;
                                         const anOp : InevOp;
                                         aCount     : Integer): TnevMoveResult;
  //override;
  {-}
var
 l_Pos    : Integer;  
 l_Length : Integer;
begin 
 if NeedWindowsCaret then
 begin
  if IsMasked then
  begin
   l_Pos := Position;
   l_Length := evTextLength(GetRedirect);
   case aCode of
    ev_ocCharLeft:
    begin
     if (l_Pos > 1) then
      if (IsSeparatorChar(l_Pos) = stSeparator) then
      begin
       SetEntryPoint(l_Pos - 2, anOp);
       Result := ev_dcDoneOk;
      end//IsSeparatorChar(l_Pos) = evSeparator
      else                                                   
       Result := inherited DoMovePrim(aView, aCode, anOp, aCount)
     else
      if GetAtStart then
       Result := ev_dcDoneFail
      else
       Result := inherited DoMovePrim(aView, aCode, anOp, aCount);
    end;//ev_ocCharLeft
    ev_ocCharRight:
    begin
     if ((l_Pos + 1) < l_Length) then
      if (IsSeparatorChar(l_Pos + 2) = stSeparator) then
      begin
       SetEntryPoint(l_Pos + 2, anOp);
       Result := ev_dcDoneOk;
      end//if IsSeparatorChar(l_Pos + 2) = stSeparator then
      else
       Result := inherited DoMovePrim(aView, aCode, anOp, aCount)
     else
      if GetAtEnd(aView) then
       Result := ev_dcDoneFail
      else
       Result := inherited DoMovePrim(aView, aCode, anOp, aCount);
    end;//ev_ocCharRight
    else
     Result := inherited DoMovePrim(aView, aCode, anOp, aCount);
   end;//case aCode of
  end//if IsMasked then
  else
  case aCode of
   ev_ocCharLeft:
    if GetAtStart then
     Result := ev_dcDoneFail
    else
     Result := inherited DoMovePrim(aView, aCode, anOp, aCount);
   ev_ocCharRight:
    if GetAtEnd(aView) then
     Result := ev_dcDoneFail
    else
     Result := inherited DoMovePrim(aView, aCode, anOp, aCount);
   else
    Result := inherited DoMovePrim(aView, aCode, anOp, aCount);
  end;
 end//NeedWindowsCaret
 else
 begin
  case aCode of
   ev_ocBottomRight, ev_ocBottomRightIgnoreMergedCell:
    Result := inherited DoMovePrim(aView, aCode, anOp, aCount);
   else
    Result := ev_dcNotDone;
  end;//case aCode
 end;//NeedWindowsCaret
end;

function TevControlParaCursor.GetReadOnly: Boolean;
  {-}
begin
 Result := (ControlType in evNotEditableControls);
end;

function TevControlParaCursor.ControlType: TevControlType;
  {-}
begin
 Result := TevControlType(GetRedirect.IntA[k2_tiType]);
end;

function TevControlParaCursor.GetNeedWindowsCaret: Boolean;
  //override;
  {-}
begin
 Result := not ReadOnly and Enabled;
 if not Result AND (ControlType = ev_ctTextParaLabel) then
  Result := true;
end;

function TevControlParaCursor.DoProcessMessage(const aView    : InevControlView;
                                             var   aMessage : TMessage;
                                             aTime          : Cardinal): Boolean;
  //override;
  {-}
var
 l_Cmd        : Word;
 l_SkipChar   : Boolean;
 l_Control    : IevEditorControl;
 l_Field      : IevEditorControlField;
 l_Text       : string;
 l_Pos        : Integer;
 l_Char       : Char;
 l_RsltSep    : TevSeparatorType;
 l_ShiftState : TShiftState;
 l_Map        : TnevFormatInfoPrim; 
begin
 Result := False;
 if (aView = nil) or (aView.Control = nil) then
  Exit;
 if IsMasked then
  if not (Checked and IsCmdKey(aMessage, ControlType)) then
  begin
   l_Text := l3PCharLen2String(GetRedirect.PCharLenA[k2_tiText], CP_ANSI);
   l_Pos := Position + 1;
   with TWMKey(aMessage) do
   begin
    l_ShiftState := KeyDataToShiftState(KeyData);
    if (l_ShiftState = []) or (l_ShiftState = [ssShift]) then
    begin
     if ((CharCode > VK_HELP) and (CharCode < VK_MULTIPLY)) or
      ((CharCode > VK_RMENU) and (CharCode < VK_PROCESSKEY)) then
     begin
      if not IsNumPad(CharCode, l_Char) then
       l_Char := Char(CharCode);
      l_RsltSep := IsSeparatorChar(l_Pos);
      l_SkipChar := l_RsltSep <> stNotSeparator;
      l_Field := evGetField(GetRedirect);
      if not l_SkipChar then
       if Valid and (l_Field <> nil) and (not l_Field.IsFieldEmpty) then
       begin
        if (Length(l_Text) > l_Pos) then
         l_Text[l_Pos] := l_Char;
       end
       else
        if not l_SkipChar then
         l_SkipChar := not InputChar(l_Text, EditMask, l_Char, l_Pos - 1)
        else 
         l_SkipChar := False
      else 
       l_SkipChar := False;
      if not l_SkipChar and (l_ShiftState = [ssShift]) then 
       l_SkipChar := True; 
     end//if CharCode > 47 then
     else 
      l_SkipChar := False;
    end//if KeyDataToShiftState(KeyData) = [] then
    else
      l_SkipChar := False;
   end 
  end//if not (Checked or IsCmdKey(aMessage, ControlType)) then
  else 
   l_SkipChar := False
 else 
  l_SkipChar := False;
 if l_SkipChar then
  Result := true
 else
 begin
  l_Cmd := aView.Control.CommandProcessor.TranslateUsing(ovcListCommands, aMessage, aTime);
  case l_Cmd of
   ccNewLine: Result := True;
   ccExtendDown:
   begin
    l_Map := aView.FormatInfoByPoint(Self);
    Result := (GetLine(l_Map) >= evTextParaLineCount(l_Map));
   end;//ccExtendDown
   ccExtendRight, ccExtWordRight, ccRight:
     Result := Position >= GetRedirect.PCharLenA[k2_tiText].SLen;
   ccLeft, ccExtendLeft, ccExtWordLeft:
     Result := GetAtStart;
   ccFastFindNext, ccSelect, ccActionItem:
    begin //Перехват операции
     l_Control := evGetEditorControl(GetRedirect);
     if l_Control <> nil then
      try
       Result := l_Control.KeyCommand(aView, l_Cmd, ParaX);
      finally
       l_Control := nil;
      end
     else
      Result := False;
    end;//ccFastFindNext
   ccShortCut:
    Result := True;
  end;//Case l_Cmd
 end;//l_SkipChar
 if not Result then
  Result := inherited DoProcessMessage(aView, aMessage, aTime);
end;

function TevControlParaCursor.Enabled: Boolean;
begin
 Result := GetRedirect.BoolA[k2_tiEnabled];
end;

function TevControlParaCursor.IsMasked: Boolean;
begin
 Result := ControlType in evMaskedControls;
end;

function TevControlParaCursor.Checked: Boolean;
begin
 Result := GetRedirect.BoolA[k2_tiChecked];
end;

function TevControlParaCursor.Validate(const Value: Il3CString): Boolean;
var
 l_Date : TDateTime;
begin
 Result := TryStrToDate(l3Str(Value), l_Date);
 Valid := Result;
end;

function TevControlParaCursor.EditMask: string;
begin
 if f_EditMask = '' then 
  UpdateMask;
 Result := f_EditMask;
end;

function TevControlParaCursor.DoDeleteString(const aView : InevView;
                                             aCount     : Long;
                                             const anOp : InevOp;
                                             aFlags     : TnevInsertStringFlags): Boolean;

type
 PevTextParaCursor = ^TevTextParaCursor;                                             
var
 l_Pos         : Integer;

 function _ModifyCursor(C: PevTextParaCursor; Index: Long): Boolean;
 var
  oPos : Long;
 begin{_ModifyCursor}
  Result := true;
  oPos := C^.Position;

  if (l_Pos = oPos) then
   C^.Refresh
  else
  begin
   C^.SetEntryPoint(l_Pos, anOp);
   IevTagLine(C^).LineEnd := false;
  end;
 end;{_ModifyCursor}

var
 l_DeleteString : Tl3InterfacedString;
 l_String      : Il3CString;
 l_Control     : IevEditorControl;
 l_Count: Integer;
 l_IDX: Integer;
begin
(* if (misfDirect in aFlags) then
  Result := inherited DoDeleteString(aCount, anOp, aFlags)
 else*)
 begin
  //http://mdp.garant.ru/pages/viewpage.action?pageId=290950884
  if (not (misfSetText in aFlags)) AND
      (not (misfDirect in aFlags)) then
    if not Enabled then
  begin
   Result := False;
   Exit;
  end;
  if IsMasked then
  begin
   l_DeleteString := Tl3InterfacedString.Make(GetRedirect.PCharLenA[k2_tiText]);
   try
    l_Pos := Position;
    ExtractFormatChars(l_DeleteString, l_Pos);
    l_Count := aCount;
    if l_Count > 1 then
     for l_IDX := 1 to aCount do
      if IsSeparatorChar(l_Pos + l_IDX) = stSeparator then
       Dec(l_Count);
    l_DeleteString.Delete(l_Pos, l_Count);
    AppendToFormatChars(l_DeleteString, l_Pos);
    l_DeleteString.Delete(0, l_Pos);
    Result := inherited DoInsertString(aView, l_DeleteString, anOp, False, aFlags);
    l_String := l3CStr(GetRedirect.PCharLenA[k2_tiText]);
    Validate(l_String);
    SetEntryPoint(l_Pos, anOp);
    l_Pos := Position;
    if IsSeparatorChar(l_Pos + 1) = stSeparator then
     SetEntryPoint(l_Pos + 1, anOp);
    l_Pos := Position;
    if not (misfLockCursors in aFlags) then
     evIterateCursorsF(ParaX.AsObject, l3L2IA(@_ModifyCursor));
   finally
    l3Free(l_DeleteString);
   end;//try..finally
  end//if IsMasked then
  else
   Result := inherited DoDeleteString(aView, aCount, anOp, aFlags);
  if Result AND not (misfSetText in aFlags) then
  begin
   l_Control := evGetEditorControl(GetRedirect);
   if l_Control <> nil then
    try
     l_Control.TextChange(aView, ParaX, anOp);
    finally
     l_Control := nil;
    end;//try..finally
  end;//Result
 end;//misfDirect in aFlags
end;

function TevControlParaCursor.DoInsertString(const aView : InevView;
                                             const aString    : Il3CString;
                                             const anOp : InevOp;
                                             InsertMode : Boolean;
                                             aFlags     : TnevInsertStringFlags): Boolean;
var
 l_EmptyString      : Tl3InterfacedString;
 l_String           : Il3CString;
 l_Insert           : Boolean;
 l_Control          : IevEditorControl;
 l_Field            : IevEditorFieldWithTree;
 l_Pos              : Integer;
 l_Text             : Tl3PCharLen;
 l_MaxCountControl  : IevEditorControl;
 l_InsString        : Tl3InterfacedString;
begin
 l_InsString := Tl3InterfacedString.Make(l3PCharLen(aString));
 try
 (* if (misfDirect in aFlags) then
   Result := inherited DoInsertString(l_InsString, anOp, InsertMode, aFlags)
  else*)
  begin
   l_Control := evGetEditorControl(GetRedirect);
   Result := False;
   if (not (misfSetText in aFlags)) AND
      (not (misfDirect in aFlags)) then
    if not Enabled then Exit;
   l_Text := GetRedirect.PCharLenA[k2_tiText];
   l_MaxCountControl := nil;
   if Assigned(l_Control) and ((l_Text.SLen + l_InsString.Len) > l_Control.MaxLength) then
   begin
    if (l_Control.MaxLength - l_Text.SLen) > 1  then
    begin
     l_InsString.Len := l_Control.MaxLength - l_Text.SLen;
     l_MaxCountControl := l_Control;
    end 
    else 
     begin
      Result := False;
      if (l_Control <> nil) then
       l_Control.Req.QueryCard.LimitCharsReached(l_Control);
      Exit;
     end;
   end;
   if IsMasked then
   begin
    l_EmptyString := Tl3InterfacedString.Make(l_InsString);
    try
     l_Pos := Position;
     CompareWithDateFormat(l_EmptyString, l_Pos);
     l_String := l3CStr(l_Text);
     l_Insert := l3Len(l_String) <= l_Pos;
     if (l_Pos + l_EmptyString.Len) > Length(CheckedDateFormat) then
      l_EmptyString.Len := Length(CheckedDateFormat) - l_Pos;
     {$IfDef XE}
     assert(false);
     {$Else}
     if not IsEmptyStr(l_EmptyString.AsString, [' ', DateSeparator]) OR
       ((misfSetText in aFlags) and (l_EmptyString.LTrimLen > 0)) then
       // ^ - Продолжаем поддерживать костыли: ^ - http://mdp.garant.ru/pages/viewpage.action?pageId=385975073
      if IsSeparatorChar(l_Pos + 1) <> stOutOfLine then //Проверка с учетом увеличения строки
      begin
       Result := inherited DoInsertString(aView, l_EmptyString, anOp, l_Insert, aFlags);
       Validate(l_String);
       l_Pos := Position;
       if IsSeparatorChar(l_Pos + 1) = stSeparator then
        SetEntryPoint(l_Pos + 1, anOp);
      end//if IsSeparatorChar(l_Pos) <> stOutOfLine then
      else
      {$EndIf}
       Result := false;
    finally
     l3Free(l_EmptyString);
    end;//try..finally
   end//if IsMasked then
   else 
    begin
     if (l_Control <> nil) and l3IOk(l_Control.QueryInterface(IevEditorFieldWithTree, l_Field))
       and l_Field.AnalyzeString(l_InsString, Position - 1, l_String) then     
     begin  
      if not l3IsNil(l_String) then
      begin
       l_EmptyString := Tl3InterfacedString.Make(l_String.AsWStr);
       try
        Result := inherited DoInsertString(aView, l_EmptyString, anOp, InsertMode, aFlags);
       finally
        l3Free(l_EmptyString);
       end;//try..finally
      end
      else
       Result := True;//Это для того, чтобы отработало добавление
     end
     else
      Result := inherited DoInsertString(aView, l_InsString, anOp, InsertMode, aFlags);
    end;
   if Assigned(l_MaxCountControl) then
    l_Control.Req.QueryCard.LimitCharsReached(l_MaxCountControl);
   if Result AND not (misfSetText in aFlags) then
   begin
    if l_Control <> nil then
     try
      l_Control.TextChange(aView, ParaX, anOp);
     finally
      l_Control := nil;
     end;//try..finally
   end;//Result AND not (misfSetText in aFlags)
  end;//misfDirect in aFlags
 finally
  l3Free(l_InsString);
 end;//try..finally
end;

procedure TevControlParaCursor.CompareWithDateFormat(Value: Tl3String; const aPos: Integer);
var
 i : Integer;
begin
 {$IfDef XE}
 assert(false);
 {$Else}
 for i := 0 to Value.Len - 1 do
  if IsSeparatorChar(aPos + i + 1) = stSeparator then
   Value[i] := DateSeparator;
 {$EndIf}
end;

function TevControlParaCursor.GetIsValid: Boolean;
begin
 Result := GetRedirect.BoolA[k2_tiValid];
end;

procedure TevControlParaCursor.SetIsValid(const Value: Boolean);
begin
 GetRedirect.BoolA[k2_tiValid] := Value;
end;

function TevControlParaCursor.IsSeparatorChar(Value: Integer): TevSeparatorType;
begin
 if (Value > Length(CheckedDateFormat)) or (Value < 1) then
   Result := stOutOfLine
 else
  if CheckedDateFormat[Value] = '/' then
   Result := stSeparator
  else
   Result := stNotSeparator;
end;

procedure TevControlParaCursor.UpdateMask;
begin
 f_EditMask := DefDateMask(' ', l3Date.FourDigitYear);
end;

function TevControlParaCursor.DoInsertBreak(const aView : InevView;
                                          aDrawLines: Boolean;
  const anOp: InevOp): Boolean;
var
 l_Control: IevEditorControl;
 l_String: Tl3InterfacedString;
begin
 Result := True;
 if ControlType = ev_ctMemoEdit then
 begin
  l_String := Tl3InterfacedString.Create;
  try
   l_String.Append(cc_SoftEnter);
   DoInsertString(aView, l_String, anOp, True, [misfDirect]);
  finally
   l3Free(l_String);
  end;
 end
 else
 begin
  l_Control := evGetEditorControl(GetRedirect);
  if l_Control <> nil then
   try
    l_Control.InsertRow(aView);
   finally
    l_Control := nil;
   end;
 end;  
end;

function TevControlParaCursor.DoJoinWithNext(const aView : InevView;
                                             const anOp : InevOp = nil): Boolean;
  //override;
  {-}
begin
 Result := False;
end;

procedure TevControlParaCursor.AppendToFormatChars(aStr: Tl3String;
  const aPos: Integer);
var
 l_IDX: Integer;
 l_Lo: Integer;
 l_Hi: Integer;
begin
 l_Hi := Length(CheckedDateFormat);
 l_Lo := Min(aStr.Len, aPos);
 for l_IDX := l_Lo to l_Hi - 1 do
  if l_IDX > (aStr.Len - 1) then
  begin
   {$IfDef XE}
   assert(false);
   {$Else}
   if IsSeparatorChar(l_IDX + 1) = stSeparator then
    aStr.Append(DateSeparator,1);
   {$EndIf}
   aStr.Append(' ',1);
  end
  else
   {$IfDef XE}
   assert(false);
   {$Else}
   if IsSeparatorChar(l_IDX + 1) = stSeparator then
    aStr.Insert(DateSeparator,l_IDX);
   {$EndIf}
end;

procedure TevControlParaCursor.ExtractFormatChars(aStr: Tl3String;
  const aPos: Integer);
var
 l_IDX: Integer;
 l_Lo: Integer;
 l_Hi: Integer;
begin
 l_Hi := Min(aStr.Len, Length(CheckedDateFormat));
 l_Lo := Min(aStr.Len, aPos);
 for l_IDX := l_Hi - 1 downto l_Lo do
  if IsSeparatorChar(l_IDX + 1) = stSeparator then
   aStr.Delete(l_Idx,1);
end;

function TevControlParaCursor.CheckedDateFormat: string;
begin
 if f_DateFormat = '' then
  f_DateFormat := DefDateFormat(FourDigitYear);
 Result := f_DateFormat;
end;

end.
