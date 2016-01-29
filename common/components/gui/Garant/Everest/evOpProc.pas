unit evOpProc;
{* Обработчики операций. }

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В.       }
{ Модуль: evOpProc - описание процессора операций }
{ Начат: 07.10.1997 15:22 }
{ $Id: evOpProc.pas,v 1.140 2015/03/02 14:46:01 lulin Exp $ }

// $Log: evOpProc.pas,v $
// Revision 1.140  2015/03/02 14:46:01  lulin
// - перетряхиваем слова.
//
// Revision 1.139  2014/04/10 11:50:05  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.138  2014/04/08 17:13:19  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.137  2014/04/03 17:10:25  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.136  2014/03/28 12:15:23  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.135  2014/03/26 15:51:56  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.134  2014/03/25 13:03:40  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.133  2014/03/25 11:53:27  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.132  2014/03/21 16:24:50  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.131  2014/03/21 12:39:22  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.130  2014/03/18 15:56:59  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.129  2014/03/06 17:23:19  lulin
// - избавляемся от теговых обёрток.
//
// Revision 1.128  2014/02/14 15:58:21  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.127  2014/02/13 16:13:11  lulin
// - рефакторим безликие списки.
//
// Revision 1.126  2013/12/26 14:10:27  lulin
// {RequestLink:509706011}
//
// Revision 1.125  2013/10/21 15:42:58  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.124  2013/10/21 10:30:41  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.123  2012/04/20 14:56:33  lulin
// {RequestLink:283610570}
//
// Revision 1.122  2011/05/19 10:35:57  lulin
// {RequestLink:266409354}.
//
// Revision 1.121  2011/05/18 17:45:15  lulin
// {RequestLink:266409354}.
//
// Revision 1.120  2011/04/04 14:57:09  lulin
// {RequestLink:255980313}.
//
// Revision 1.119  2010/12/17 18:02:31  lulin
// - учитываем, что ребёнка могут удалить.
//
// Revision 1.118  2010/12/17 16:58:08  lulin
// - не считаем одних и тех же детей по нескольку раз.
//
// Revision 1.117  2010/12/17 15:03:39  lulin
// {RequestLink:247302160}.
//
// Revision 1.116  2010/12/14 14:37:53  lulin
// {RequestLink:206079417}.
//
// Revision 1.115  2010/12/13 19:57:21  lulin
// {RequestLink:206079417}.
//
// Revision 1.114  2010/11/24 11:12:20  lulin
// {RequestLink:238945411}.
//
// Revision 1.113  2010/11/22 14:00:38  lulin
// [$242845500].
//
// Revision 1.112  2010/04/20 14:47:09  lulin
// {RequestLink:204114253}.
// - не позволяем отрицательные значения.
//
// Revision 1.111  2009/12/11 15:56:05  lulin
// {RequestLink:172984520}.
//
// Revision 1.110  2009/12/11 14:14:37  lulin
// {RequestLink:172984520}.
//
// Revision 1.109  2009/07/23 18:26:49  lulin
// - убираем ненужный запрос интерфейса.
//
// Revision 1.108  2009/07/23 13:42:11  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.107  2009/07/20 11:21:56  lulin
// - заставляем работать F1 после - {RequestLink:141264340}. №7, 32, 33.
//
// Revision 1.106  2009/07/06 13:32:06  lulin
// - возвращаемся от интерфейсов к объектам.
//
// Revision 1.105  2009/06/02 16:12:53  lulin
// - выделяем внутренние интерфейсы в отдельные модули.
//
// Revision 1.104  2009/06/02 12:26:32  lulin
// [$148572872].
//
// Revision 1.103  2009/04/14 18:11:54  lulin
// [$143396720]. Подготовительная работа.
//
// Revision 1.102  2009/03/04 13:32:46  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.101  2009/01/22 08:25:42  lulin
// - <K>: 135605082.
//
// Revision 1.100  2008/11/11 09:01:44  lulin
// - <K>: 114459503.
// - F1 не собиралась.
//
// Revision 1.99  2008/11/10 15:42:50  lulin
// - <K>: 114459503. Теперь и превью и контейнер документа обладают списком разрывов разделов.
//
// Revision 1.98  2008/10/20 12:32:33  dinishev
// <K> : 121155601
//
// Revision 1.97  2008/08/15 13:13:53  lulin
// - <K>: 108626698.
//
// Revision 1.96  2008/07/02 12:32:21  lulin
// - <K>: 91848911.
//
// Revision 1.95  2008/06/02 11:15:20  lulin
// - <K>: 93259431.
//
// Revision 1.94  2008/05/15 11:28:28  lulin
// - <K>: 90446071.
//
// Revision 1.93  2008/03/21 15:41:37  lulin
// - <K>: 87591144.
//
// Revision 1.92  2008/03/21 14:09:12  lulin
// - cleanup.
//
// Revision 1.91  2008/03/20 09:48:08  lulin
// - cleanup.
//
// Revision 1.90  2008/03/03 13:20:27  lulin
// - nevTools перенесён на модель. Теперь всё компилируется.
//
// Revision 1.89  2008/02/07 14:44:22  lulin
// - класс _Tl3LongintList переехал в собственный модуль.
//
// Revision 1.88  2008/02/07 09:32:56  lulin
// - подготавливаемся к переносу списка целых на модель.
//
// Revision 1.87  2008/01/31 20:09:51  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.86  2007/12/04 12:47:03  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.76.4.61  2007/11/28 15:26:15  dinishev
// Совместимость с Арчи
//
// Revision 1.76.4.60  2007/09/18 16:58:05  lulin
// - cleanup.
//
// Revision 1.76.4.59  2007/09/14 13:26:05  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.76.4.58.2.2  2007/09/12 17:51:48  lulin
// - cleanup.
//
// Revision 1.76.4.58.2.1  2007/09/12 15:23:01  lulin
// - избавляемся от метода, дублирующего функциональность получения атрибута.
//
// Revision 1.76.4.58  2007/09/04 17:27:38  lulin
// - убран ненужный параметр.
//
// Revision 1.76.4.57  2006/11/03 11:00:05  lulin
// - объединил с веткой 6.4.
//
// Revision 1.76.4.56.4.1  2006/10/12 17:45:21  lulin
// - вычищаем все, что связано с дозагрузкой документа.
//
// Revision 1.76.4.56  2006/09/29 07:15:16  oman
// - fix: Исправлено название метода для отражения его сути
//
// Revision 1.76.4.55  2006/04/19 11:18:41  mmorozov
// - new: создан интерфейс InevDocumentLimits для возможности определения пользователем компонента ограничений на работу с документом;
//
// Revision 1.76.4.54  2006/02/20 17:30:08  dinishev
// Обновление состояния кнопок после откатки
//
// Revision 1.76.4.53  2006/01/20 16:28:37  lulin
// - bug fix: при смене документа не очищался Undo-буфер в итоге при Undo были самые разнообразные ошибки, например выхода за границу (CQ OIT5-19095).
//
// Revision 1.76.4.52  2006/01/20 15:53:01  lulin
// - cleanup.
//
// Revision 1.76.4.51  2005/12/26 13:26:48  lulin
// - bug fix: не всегда отображалось изменение комментариев (CQ OIT5-18865).
//
// Revision 1.76.4.50  2005/12/14 15:07:13  lulin
// - bug fix: при установке стиля не сбрасывались собственные параметры параграфа (CQ OIT5-18649).
//
// Revision 1.76.4.49  2005/12/14 09:42:02  lulin
// - убрал лишний параметр, из-за которого не компилировался HEAD.
//
// Revision 1.76.4.48  2005/12/09 16:48:29  lulin
// - убрана лишняя конкретизация типа.
//
// Revision 1.76.4.47  2005/12/09 15:44:08  lulin
// - bug fix: слишком поздно корректировали стиль параграфов в комментарии (CQ OIT5-18487).
//
// Revision 1.76.4.46  2005/12/07 16:36:49  lulin
// - используем Lock/Unlock без неявного приведения интерфейсов.
//
// Revision 1.76.4.45  2005/12/07 06:50:59  lulin
// - new behavior: теперь элементы списка могут вставляться в другие приложения.
//
// Revision 1.76.4.44  2005/12/05 12:41:50  lulin
// - bug fix: при чтении из потока неправильно считалась высота документа.
//
// Revision 1.76.4.43  2005/12/05 12:14:47  lulin
// - cleanup.
//
// Revision 1.76.4.42  2005/12/02 22:38:07  lulin
// - нотификация о добавлении параграфов в процессе загрузки теперь посылается через процессор, а не через обработчики сообщений.
//
// Revision 1.76.4.41  2005/12/02 22:03:45  lulin
// - запрос валидности операции посылается теперь через базовые объекты, а не шаманскими методами.
//
// Revision 1.76.4.40  2005/12/02 18:23:28  lulin
// - обрабока нотфификации об удалении/добавлении параграфа практически полностью перенесена на процессор.
//
// Revision 1.76.4.39  2005/12/01 11:55:18  lulin
// - нотификация об изменении состава детей тега разложена по уровням _Processor -> DocumentContainer.
//
// Revision 1.76.4.38  2005/12/01 05:27:42  lulin
// - нотификация об изменении атрибута тега разложена по уровням _Processor -> DocumentContainer -> TextSource.
//
// Revision 1.76.4.37  2005/11/21 09:33:11  lulin
// - типизируем более конкретно параметр метода _DoCheckParaOp.
//
// Revision 1.76.4.36  2005/11/21 09:29:37  lulin
// - типизируем более конкретно параметр метода _CheckParaOp.
//
// Revision 1.76.4.35  2005/11/21 09:10:28  lulin
// - bug fix: не даем вставить два подряд комментария.
//
// Revision 1.76.4.34  2005/11/21 08:28:36  lulin
// - валидируем тип вставляемого параграфа, и если он не комментарий, то заворачиваем его в комментарий.
//
// Revision 1.76.4.33  2005/11/18 15:13:34  lulin
// - доделано сохранение комментариев.
//
// Revision 1.76.4.32  2005/11/15 12:23:23  lulin
// - cleanup.
//
// Revision 1.76.4.31  2005/11/15 08:02:39  lulin
// - чтение/запись документа практически польностью перенесены с TextSource на контейнер документа.
//
// Revision 1.76.4.30  2005/11/11 22:23:15  lulin
// - избавляемся от управления свойством модифицированности документа путем посылки сообщений.
//
// Revision 1.76.4.29  2005/11/11 21:52:13  lulin
// - bug fix: убраны утечки объектов документа, связанные с неправильным владением Undo-буфером.
//
// Revision 1.76.4.28  2005/11/11 18:04:07  lulin
// - выделен интерфейс Undo-буфера.
//
// Revision 1.76.4.27  2005/11/09 15:28:24  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.76.4.26  2005/11/04 13:09:37  dinishev
// делаем _ParaOp не виртуальным
//
// Revision 1.76.4.25  2005/11/04 12:50:59  dinishev
// делаем _ParaOp виртуальной
//
// Revision 1.76.4.24  2005/10/13 10:41:09  lulin
// - получаем _Loader у контейнера документа, а не через цепочку Parent'ов.
//
// Revision 1.76.4.23  2005/10/13 06:00:24  lulin
// - cleanup.
//
// Revision 1.76.4.22  2005/10/07 11:55:00  lulin
// - bug fix: при редактировании комментариев не обновлялся предварительный просмотр (CQ OIT5-16824).
//
// Revision 1.76.4.21  2005/09/05 14:19:36  lulin
// - bug fix: не рассылались сообщения о смене свойств, а также о удалении/добавлении детей - в результате закладки не попадали в оглавление.
//
// Revision 1.76.4.20  2005/09/01 14:14:55  lulin
// - bug fix: при догрузке комментариев не показывались человечки.
//
// Revision 1.76.4.19  2005/07/25 12:13:14  lulin
// - TextSource теперь знает про базовый контейнер документа, а не про специализированный.
//
// Revision 1.76.4.18  2005/07/25 10:54:36  lulin
// - события нотификации перенесены с контейнера документа и процессора на TextSource.
//
// Revision 1.76.4.17  2005/07/21 15:53:59  lulin
// - выделен шаблон, реализующий интерфес нотификатора - _Il3ChangeNotifier.
//
// Revision 1.76.4.16  2005/07/21 13:57:41  lulin
// - убраны лишние свойства с процессора операций.
//
// Revision 1.76.4.15  2005/07/21 08:58:43  lulin
// - кеш документов практически полность переведен на интерфейсы.
//
// Revision 1.76.4.14  2005/07/19 12:03:20  lulin
// - cleanup: удалены ненужные модули и методы.
//
// Revision 1.76.4.13  2005/07/15 13:09:05  lulin
// - избавляемся от промежуточного интерфейса для View.
//
// Revision 1.76.4.12  2005/07/15 12:41:56  lulin
// - теперь процеесор операций знает не про безликого Owner'а, а про вполне конкретный DocumentContainer.
//
// Revision 1.76.4.11  2005/06/29 13:40:23  lulin
// - bug fix: при догрузке параграфов портилось количество листьевых параграфов.
//
// Revision 1.76.4.10  2005/06/29 09:44:40  lulin
// - удешевляем подсчет вложенных детей, за счет того, что нотификации о вставке параграфов идут вложенные и в правильном порядке.
//
// Revision 1.76.4.9  2005/06/29 09:18:12  lulin
// - убираем проверку на тип родителя - ибо он либо список, либо not IsValid - иначе это нарушение структуры документа.
//
// Revision 1.76.4.8  2005/06/29 08:35:50  lulin
// - убрана еще одна лишняя проверка.
//
// Revision 1.76.4.7  2005/06/29 08:21:18  lulin
// - удешевляем проверки при подсчете числа дочерних параграфов.
//
// Revision 1.76.4.6  2005/06/28 13:20:44  lulin
// - new behavior: подсчитываем только число листьевых параграфов.
//
// Revision 1.76.4.5  2005/06/27 14:16:46  lulin
// - new behavior: для вертикального скроллера используем AllChildrenCount.
//
// Revision 1.76.4.4  2005/06/27 11:58:19  lulin
// - new behavior: считаем AllChildrenCount в процессе загрузки документа.
//
// Revision 1.76.4.3  2005/06/23 11:40:09  lulin
// - bug fix: функция Make не возвращала результат.
//
// Revision 1.76.4.2  2005/06/23 11:19:10  lulin
// - cleanup: убраны лишние зависимости.
//
// Revision 1.76.4.1  2005/05/18 12:42:47  lulin
// - отвел новую ветку.
//
// Revision 1.70.2.5  2005/05/18 12:32:09  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.70.2.4  2005/04/28 09:18:29  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.70.2.3  2005/04/19 12:23:01  lulin
// - cleanup: спрятаны ненужные методы.
//
// Revision 1.70.2.2  2005/04/19 07:18:17  lulin
// - небольшая оптимизация.
//
// Revision 1.70.2.1  2005/04/10 15:33:54  lulin
// - new interface: InevDocumentInfo.
//
// Revision 1.74.2.4  2005/04/26 16:07:07  lulin
// - уменьшаем число лишних вызовов.
//
// Revision 1.74.2.3  2005/04/26 14:30:39  lulin
// - ускоряем l3Free и _l3Use.
//
// Revision 1.74.2.2  2005/04/23 16:07:25  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.74.2.1  2005/04/21 14:46:55  lulin
// - избавляемся от обертки над тегами - теперь объекты посредством шаблонов сами реализуют интерфейс _Ik2Tag.
//
// Revision 1.74  2005/04/19 16:57:27  lulin
// - new interface: IevSimpleView.
//
// Revision 1.73  2005/04/19 16:25:57  lulin
// - cleanup.
//
// Revision 1.72  2005/04/19 09:16:23  lulin
// - убран лишний запрос интерфейса.
//
// Revision 1.71  2005/04/19 07:53:40  lulin
// - небольшая оптимизация.
//
// Revision 1.76  2005/05/14 15:08:00  lulin
// - bug fix: давали редактировать документ в процессе его загрузки.
//
// Revision 1.75  2005/04/28 15:03:38  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.74.2.4  2005/04/26 16:07:07  lulin
// - уменьшаем число лишних вызовов.
//
// Revision 1.74.2.3  2005/04/26 14:30:39  lulin
// - ускоряем l3Free и _l3Use.
//
// Revision 1.74.2.2  2005/04/23 16:07:25  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.74.2.1  2005/04/21 14:46:55  lulin
// - избавляемся от обертки над тегами - теперь объекты посредством шаблонов сами реализуют интерфейс _Ik2Tag.
//
// Revision 1.74  2005/04/19 16:57:27  lulin
// - new interface: IevSimpleView.
//
// Revision 1.73  2005/04/19 16:25:57  lulin
// - cleanup.
//
// Revision 1.72  2005/04/19 09:16:23  lulin
// - убран лишний запрос интерфейса.
//
// Revision 1.71  2005/04/19 07:53:40  lulin
// - небольшая оптимизация.
//
// Revision 1.70  2005/04/01 08:35:29  lulin
// - remove proc: evDir_InsertPara (пользуйтесь инструментом InevParaList).
//
// Revision 1.69  2005/03/28 11:32:07  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.68  2005/03/21 08:04:01  mmorozov
// change: тип свойства DefaultStyle теперь _TevStyleId;
//
// Revision 1.67  2005/03/10 11:35:09  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.66  2005/02/28 12:20:07  lulin
// - выделены константы с сообщениями об Exception'ах.
//
// Revision 1.65  2005/02/03 08:30:19  lulin
// - bug fix: после перехода на шаблон _Unknow_ не все операции попадали в буфер Undo.
//
// Revision 1.64  2005/02/02 18:24:42  lulin
// - класс _Tl3_CBase переведен на шаблон _Unknown_.
//
// Revision 1.63  2005/01/28 14:46:13  lulin
// - new behavior: для Немезиса по-возможности берем форматирование документа из кеша.
//
// Revision 1.62  2004/12/22 18:30:54  lulin
// - bug fix: неправильно рисовался прогресс сохранения файла, который был недозагружен целиком.
//
// Revision 1.61  2004/11/04 14:03:04  lulin
// - bug fix: при Undo была ошибка о невозможности вставить комментарий (CQ OIT5-10709).
//
// Revision 1.60  2004/10/01 08:12:05  lulin
// - bug fix: Interface Not Supported - когда в результате изменения текста  выходили в карточку запроса.
//
// Revision 1.59  2004/09/21 12:55:41  lulin
// - Release заменил на Cleanup.
//
// Revision 1.58  2004/07/19 14:46:13  law
// - bug fix: некорректно работало Undo пользовательских комментариев, а Redo не было доступно вообще.
//
// Revision 1.57  2004/07/08 15:46:07  law
// - ускорена вставка/удаление параграфов в длинных документах.
//
// Revision 1.56  2004/07/01 12:15:52  law
// - bug fix: при смене документа некорректно очищалась статистика (в частности о непрогруженных параграфах).
//
// Revision 1.55  2004/06/28 12:06:13  law
// - remove class: Il3Unknown.
//
// Revision 1.54  2004/06/08 13:38:19  law
// - new interface: IevDocumentInfo.
//
// Revision 1.53  2004/06/08 13:17:52  law
// - new behavior: сделан подсчет недогруженных параграфов.
//
// Revision 1.52  2004/06/01 16:51:19  law
// - удален конструктор Tl3VList.MakePersistent - пользуйтесь _Tl3ObjectRefList.
//
// Revision 1.51  2004/04/02 11:45:33  law
// - new behavior: в TevCustomUndoProcessor сбрасываем флаг InIOProcess.
//
// Revision 1.50  2003/12/27 15:02:17  law
// - new behavior: теперь считаем число картинок в документе.
//
// Revision 1.49  2003/12/03 15:50:48  law
// - bug fix: не вызывалось событие OnUserCommentDelete, не исчезала иконка в SubPanel (CQ OIT5-4675).
//
// Revision 1.48  2003/10/30 11:51:41  law
// - bug fix: не всегда проверялась возможность вставки параграфа.
//
// Revision 1.47  2003/10/20 15:42:17  law
// - new unit: eeProcessor.
// - new method: TevCustomProcessor._DoCheckParaOp (virtual).
//
// Revision 1.46  2003/02/13 18:17:20  law
// - change: у Il3Lock переделать параметр методов Lock/Unlock с Integer на IUnknown (№113).
//
// Revision 1.45  2003/02/13 13:08:56  law
// - cleanup.
//
// Revision 1.44  2003/02/06 14:42:59  law
// - cleanup: переходим от сообщений (message)  к виртуальным функциям.
//
// Revision 1.43  2003/02/06 10:13:24  law
// - change: добавлено значение кода операции по умолчанию.
//
// Revision 1.42  2003/02/05 13:53:11  law
// - cleanup: переходим от сообщений (message)  к виртуальным функциям.
//
// Revision 1.41  2003/01/24 16:12:52  law
// - new interface: Il3OpPackMode.
// - new methods: Il3OpPack.Undo, Redo, Clear.
//
// Revision 1.40  2002/09/23 07:21:22  law
// - new unit: evStyleTableSpy.
// - new interface: IevStyleTableSpy.
// - new behavior: рассылка нотификации об изменении таблицы стилей.
//
// Revision 1.39  2002/07/09 13:57:39  law
// - new unit: evMsgCode.
//
// Revision 1.38  2001/11/16 15:23:32  law
// - bug fix: GPF при удалении строки таблицы (см. задачу 1344, _TestSet\ComplexTable\7.evd).
//
// Revision 1.37  2001/11/09 12:10:24  law
// - new interface: _IevOpTranslator.
//
// Revision 1.36  2001/11/09 10:16:06  law
// - new interface: _IevTextOpProcessor.
//
// Revision 1.35  2001/11/09 09:52:22  law
// - new interface: IevParaOpProcessor.
//
// Revision 1.34  2001/10/17 16:09:31  law
// - bug fix: AV при закрытии большого документа сразу же после выделения всего текста.
//
// Revision 1.33  2001/08/29 07:01:08  law
// - split unit: l3Intf -> l3BaseStream, l3BaseDraw, l3InterfacedComponent.
//
// Revision 1.32  2001/06/18 14:32:49  law
// - cleanup.
//
// Revision 1.31  2001/06/01 08:11:07  law
// - cleanup: убрана работа с ненужными сообщениями, а также ненужные зависимости между модулями.
//
// Revision 1.30  2001/05/31 11:16:51  law
// - cleanup: убрана работа с сообщениями em_* за ненадобностью.
//
// Revision 1.29  2001/03/23 17:45:42  law
// - интерфейсу Il3OpPack добавлено свойство _Processor.
//
// Revision 1.28  2001/03/13 18:44:34  law
// - some cleaning, tuning & comments.
//
// Revision 1.27  2001/03/05 14:08:28  law
// - поменялся порядок у методов _IterateChildren...
//
// Revision 1.26  2001/01/31 10:37:30  law
// - оптимизировано использование QueryInterface.
//
// Revision 1.25  2000/12/19 15:52:40  law
// - убраны ненужные директивы компиляции.
//
// Revision 1.24  2000/12/15 15:10:36  law
// - вставлены директивы Log.
//

{$Include evDefine.inc }

interface

uses
  Messages,
  Windows,
  
  Classes,

  l3Interfaces,
  l3IID,
  l3Types,
  l3Msg,
  l3Base,
  l3InternalInterfaces,
  l3LongintList,
  l3NotifyPtrList,
  l3ProtoPersistent,
  l3Variant,

  k2Prim,
  k2Interfaces,
  k2OperationContainer,

  evConst,
  evTypes,
  evInternalInterfaces,
  evMsgCode,
  evDef,

  nevBase,
  nevTools,

  evTextManipulationInterfaces
  ;

type
  TevDocInfo = record
    ReadOnly        : Bool;
    NettoCharCount  : Long;
    BruttoCharCount : Long;
    TextParaCount   : Long;
  end;//TevDocInfo

  _l3Notifier_Parent_ = Tl3Base;
  {$Include l3Notifier.imp.pas}
  TevCustomProcessor = class(_l3Notifier_,
                             IevTextOpProcessor,
                             InevDocumentInfo,
                             InevDocumentLimits)
   {* Обработчик операций. }
    protected
    // property fields
      f_NettoCharCount  : Long;
      f_BruttoCharCount : Long;
      f_BruttoCharLimit : Long;
      f_TextParaCount   : Long;
      f_BitmapParaCount : Long;
      f_TextParaLimit   : Long;
      f_DefaultStyle    : TevStyleId;
      f_Document        : Pointer;
      f_DisableReadOnly : Integer;
      f_ReadOnly        : Boolean;
      f_CheckOff        : Integer;
    protected
    // property methods
      function  pm_GetDefaultStyle: Tl3StyleId;
      procedure pm_SetDefaultStyle(aValue: Tl3StyleId);
        {-}
      function  pm_GetDocument: InevObjectHolder;
        {-}
      function  pm_GetReadOnly: Boolean;
        {-}
      procedure pm_SetReadOnly(aValue: Boolean);
        {-}
   procedure CheckOn;
   procedure CheckOff;
   function IsCheckOff: Boolean;
      function  pm_GetNettoCharCount: Integer;
      procedure pm_SetNettoCharCount(Value: Long);
        {-}
      function pm_GetBruttoCharCount: Integer;
      procedure pm_SetBruttoCharCount(Value: Long);
        {-}
      function pm_GetBruttoCharLimit: Long;
      procedure pm_SetBruttoCharLimit(aValue: Long);
        {* - ограничение на количество введенных символов. }
      function pm_GetTextParaCount: Integer;
      procedure pm_SetTextParaCount(Value: Long);
        {-}
      function pm_GetBitmapParaCount: Integer;
        {-}
      function  pm_GetTextParaLimit: Long;
      procedure pm_SetTextParaLimit(Value: Long);
        {-}
    protected
    // internal methods
      procedure Lock;
        {-}
      procedure Unlock;
        {-}
      procedure BeepOnParaLimit;
        virtual;
        {-}  
      procedure DoCheckParaOp(aParent  : Tl3Variant;
                              var aChild     : Tl3Variant;
                              anOp           : Tl3Operation;
                              anIndex        : TnevParaIndex);
        virtual;
        {* - проверить операцию с параграфом. }
      procedure DoParaOp(Parent : Tl3Variant;
                         Child  : Tl3Variant;
                         Op           : Tl3Operation);
        virtual;
        {* - завершить операцию с параграфом. }
      procedure InitFields;
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
    protected
    // internal properties
      property Document: InevObjectHolder
        read pm_GetDocument;
        {-}
    public
    // public methods
      constructor Create;
        reintroduce;
        {-}
      procedure CheckReadOnly;
        {-}
      procedure DenyModify;
        {-}
      procedure CheckParaOp(aParent  : Tl3Variant;
                            var aChild     : Tl3Variant;
                            anOp           : Tl3Operation;
                            var anIndex    : TnevParaIndex);
        {* - проверить операцию с параграфом. }
      procedure CheckTextOp(Text: Tl3CustomString; Op: Tl3Operation);
        {-}
      procedure ParaOpEx(Parent    : Tl3Variant;
                         aChild    : Tl3Variant;
                         Op              : Tl3Operation;
                         IterateChildren : Boolean);
        {-}
      procedure ParaOp(Parent : Tl3Variant;
                       Child  : Tl3Variant;
                       Op           : Tl3Operation); 
        {* - завершить операцию с параграфом. }
      procedure TextOp(Text: Tl3CustomString; Op: Tl3Operation);
        {-}
      procedure ClearStat;
        virtual;
        {-}
      procedure LinkDocument(const aDocument: InevObjectHolder);
        {-}
      procedure UnlinkDocument(const aDocument: InevObjectHolder);
        {-}
    public
    // public properties
      property ReadOnly: Bool
        read pm_GetReadOnly;
        {* - режим "только для чтения"? }
      property NettoCharCount: Long
        read f_NettoCharCount
        write pm_SetNettoCharCount;
        {* - количество символов в тексте (без концов строк). }
      property BruttoCharCount: Long
        read f_BruttoCharCount
        write pm_SetBruttoCharCount;
        {* - количество символов в тексте. }
      property BruttoCharLimit: Long
        read f_BruttoCharLimit
        write pm_SetBruttoCharLimit
        default 0;
        {* - максимальное разрешенное количество символов. }
      property TextParaCount: Long
        read f_TextParaCount
        write pm_SetTextParaCount;
        {* - число текстовых параграфов. }
      property BitmapParaCount: Long
        read f_BitmapParaCount;
        {-}
      property TextParaLimit: Long
        read f_TextParaLimit
        write pm_SetTextParaLimit
        default 0;
        {* - максимальное разрешенное число текстовых параграфов. }
      property DefaultStyle: TevStyleId
        read f_DefaultStyle
        write f_DefaultStyle
        default def_DefaultStyle;
        {* - стиль параграфов по умолчанию. }
  end;//TevCustomProcessor

  Rl3OperationContainer = class of Tk2OperationContainer;

  TevCustomUndoProcessor = class(TevCustomProcessor, InevProcessor, Il3OpPackMode)
   {* Обработчик операций с возможностью Undo & Redo. }
    private
    // internal fields
      f_LockedContainer : Bool;
    private
    // internal fields
      f_Container       : Tk2OperationContainer;
      f_ContainerClass  : Rl3OperationContainer;
      f_SaveUndo        : Bool;
      f_DeleteMapped    : Bool;
      f_Optimize        : Bool;
      f_InIOProcess     : Bool;
      f_InUndo          : Integer;
      f_UndoBuffer      : Ik2UndoBuffer;
    protected
    // property methods
      function  Get_InUndo: Boolean;
        {-}
      function  Get_SaveUndo: Boolean;
      procedure Set_SaveUndo(Value: Boolean);
        {-}
      function  pm_GetContext: Il3OpPack;
        {-}
      function  pm_GetDeleteMapped: Bool;
      procedure pm_SetDeleteMapped(Value: Boolean);
        {-}
      function  pm_GetOptimize: Boolean;
      procedure pm_SetOptimize(Value: Boolean);
        {-}
      function  pm_GetInIOProcess: Boolean;
      procedure pm_SetInIOProcess(Value: Boolean);
        {-}
      function  Get_UndoBuffer: Ik2UndoBuffer;
        {-}
      function  pm_GetUndoBuffer: Ik2UndoBuffer;
        {-}
      function  pm_GetCanUndo: Bool;
        {-}
      function  pm_GetCanRedo: Bool;
        {-}
      function  pm_GetProcessor: InevProcessor;
        {-}
    protected
    // internal methods
      procedure ClearStat;
        override;
        {-}
      procedure DoAfterUndoRedo;
        virtual;  
        {-}
      procedure CheckInsert(aParent  : Tl3Variant;
                            var aChild     : Tl3Variant;
                            var anIndex    : Integer);
        virtual;
        {* - проверить операцию с параграфом. }
      procedure CheckDelete(aParent  : Tl3Variant;
                            aChild   : Tl3Variant;
                            anIndex        : Integer);
        virtual;
        {* - проверить операцию с параграфом. }
      procedure NotifyCompleted(aList  : Tl3Variant;
                                aChild : Tl3Variant);
        {-}
      procedure NotifyInsert(aList    : Tl3Variant;
                             aProp    : TObject;
                             aChild   : Tl3Variant;
                             anIndex        : Integer;
                             const anOpPack : Il3OpPack);
        virtual;
        {-}
      procedure NotifyDelete(aList    : Tl3Variant;
                             aProp    : TObject;
                             aChild   : Tl3Variant;
                             anIndex        : Integer;
                             const anOpPack : Il3OpPack);
        virtual;
        {-}
   procedure NotifyPropChanged(aProp: TObject;
    const aValues;
    const anOp: Ik2Op);
     {* Сообщает об изменении свойства объекта }
        virtual;
        {-}
   function NeedReplaceQuotes: Boolean;
   function GetNeedReplaceQuotes: Boolean;
     virtual;
      function  InUndo: Boolean;
        {-}
      procedure DisableReadOnly;
        {-}
      procedure EnableReadOnly;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // interface methods
      // InevProcessor
      function  StartOp(OpCode : Integer = 0;
                        DoLock : Boolean = true): Il3OpPack;
        {-}
      function  FinishOp(anOp: TObject): Boolean;
        {-}
      function  LastOp: Il3OpPack;
        {* - предыдущая операция. }  
      function  InOp: Bool;
        {-}
    protected
    // internal properties
      property SaveUndo: Boolean
        read Get_SaveUndo;
        {-}
      property Context: Il3OpPack
        read pm_GetContext;
        {-}
    public
    // public methods
      constructor Create(aContainerClass : Rl3OperationContainer = nil);
        reintroduce;
        {-}
      class function Make(aContainerClass : Rl3OperationContainer = nil): InevProcessor;
        reintroduce;
        {-}
      function  Undo: Bool; virtual;
        {* - отменить предыдущую операцию. }
      function  Redo: Bool; virtual;
        {* - вернуть отмененную операцию. }
      procedure MarkModified(aTarget: Tl3Variant);
        {* - взвести признак модификации. }
      procedure InvertModified;
        {-}
      function  GetModified: Boolean;
        {-}
    public
    // public properties
      property CanUndo: Bool
        read pm_GetCanUndo;
        {* - возможно ли Undo. }
      property CanRedo: Bool
        read pm_GetCanRedo;
        {* - возможно ли Redo. }
      property UndoBuffer: Ik2UndoBuffer
        read pm_GetUndoBuffer;
        {-}
  end;//TevCustomUndoProcessor

implementation

uses
  SysUtils,
  
  l3Chars,
  l3MinMax,
  l3InterfacesMisc,

  k2Tags,
  k2Base,

  evOp,
  evExcept,
  evUndoB,

  LeafPara_Const,
  BitmapPara_Const,
  ParaList_Const,
  Table_Const,
  TableRow_Const
  ;

{$Include l3Notifier.imp.pas}  

resourcestring
  c_excReadOnlyMode = 'Read Only Mode';
  c_excParaLimitReached = 'Лимит количества параграфов достигнут.';
  c_excCharLimitReached = 'Лимит количества символов достигнут.';

// start class TevCustomProcessor

constructor TevCustomProcessor.Create;
  {override;}
  {-}
begin
 inherited Create;
end;

procedure TevCustomProcessor.Cleanup;
  //override;
  {-}
begin
 f_Document := nil;
 inherited;
end;

procedure TevCustomProcessor.InitFields;
  //override;
  {-}
begin
 inherited;
 f_DefaultStyle := def_DefaultStyle;
end;

function TevCustomProcessor.pm_GetDocument: InevObjectHolder;
  {-}
begin
 Result := InevObjectHolder(f_Document);
end;

function TevCustomProcessor.pm_GetDefaultStyle: Tl3StyleId;
  {-}
begin
 Result := f_DefaultStyle;
end;

function TevCustomProcessor.pm_GetReadOnly: Bool;
  {-}
begin
 Result := f_ReadOnly;
end;

procedure TevCustomProcessor.pm_SetReadOnly(aValue: Boolean);
  {-}
begin
 f_ReadOnly := aValue;
end;

procedure TevCustomProcessor.CheckOn;
begin
 Dec(f_CheckOff);
end;

procedure TevCustomProcessor.CheckOff;
begin
 Inc(f_CheckOff);
end;

function TevCustomProcessor.IsCheckOff: Boolean;
begin
 Result := (f_CheckOff> 0);
end;

function TevCustomProcessor.pm_GetNettoCharCount: Integer;
  {-}
begin
 Result := f_NettoCharCount;
end;

procedure TevCustomProcessor.pm_SetNettoCharCount(Value: Long);
  {-}
begin
 if (f_NettoCharCount <> Value) then
 begin
  f_NettoCharCount := Max(Value, 0);
  CallNotify(Ord(nev_deNettoCharCountChange), 0);
 end;{f_NettoCharCount <> Value}
end;

function TevCustomProcessor.pm_GetBruttoCharCount: Integer;
  {-}
begin
 Result := f_BruttoCharCount;
end;

procedure TevCustomProcessor.pm_SetBruttoCharCount(Value: Long);
  {-}
begin
 if (f_BruttoCharCount <> Value) then
 begin
  f_BruttoCharCount := Max(Value, 0);
  CallNotify(Ord(nev_deBruttoCharCountChange), 0);
 end;{f_BruttoCharCount <> Value}
end;

function TevCustomProcessor.pm_GetBruttoCharLimit: Long;
  {-}
begin
 Result := f_BruttoCharLimit;
end;

procedure TevCustomProcessor.pm_SetBruttoCharLimit(aValue: Long);
  {-}
begin
 if (f_BruttoCharLimit <> aValue) then
  f_BruttoCharLimit := aValue;
end;

function TevCustomProcessor.pm_GetTextParaCount: Integer;
  {-}
begin
 Result := f_TextParaCount;
end;

procedure TevCustomProcessor.pm_SetTextParaCount(Value: Long);
  {-}
begin
 if (f_TextParaCount <> Value) then
 begin
  f_TextParaCount := Value;
  CallNotify(Ord(nev_deTextParaCountChange), 0);
 end;{f_TextParaCount <> Value}
end;

function TevCustomProcessor.pm_GetBitmapParaCount: Integer;
  {-}
begin
 Result := f_BitmapParaCount;
end;

function TevCustomProcessor.pm_GetTextParaLimit: Long;
  {-}
begin
 Result := f_TextParaLimit;
end;

procedure TevCustomProcessor.pm_SetTextParaLimit(Value: Long);
  {-}
begin
 if (f_TextParaLimit <> Value) then
  f_TextParaLimit := Value;
end;

procedure TevCustomProcessor.Lock;
  {-}
begin
 if (Document <> nil) then
  if (Document.Lock <> nil) then
   Document.Lock.Lock(Self);
end;

procedure TevCustomProcessor.Unlock;
  {-}
begin
 if (Document <> nil) then
  if (Document.Lock <> nil) then
   Document.Lock.Unlock(Self);
end;

procedure TevCustomProcessor.CheckReadOnly;
  {-}
begin
 if (Self <> nil) AND ReadOnly AND (f_DisableReadOnly <= 0) then
  DenyModify;
end;

procedure TevCustomProcessor.DenyModify;
  {-}
begin
 raise EevReadOnly.Create(c_excReadOnlyMode);
 {&&& exception $$$}
end;

procedure TevCustomProcessor.BeepOnParaLimit;
  //virtual;
  {-}
begin
 l3System.Beep;
end;

procedure TevCustomProcessor.DoCheckParaOp(aParent  : Tl3Variant;
                                           var aChild     : Tl3Variant;
                                           anOp           : Tl3Operation;
                                           anIndex        : TnevParaIndex);
  //virtual;
  {* - проверить операцию с параграфом. }
var
 DCC : Long;
begin
 CheckReadOnly;
 if (anOp = l3_opInsert) AND Tk2Type(aChild.TagType).HasProperty[k2_tiText] then
 begin
  if (TextParaLimit > 0) then
  begin
   if (TextParaLimit - TextParaCount <= 0) then
   begin
    BeepOnParaLimit;
    raise EevLimitReached.Create(c_excParaLimitReached);
    {&&& exception $$$}
   end;{TextParaLimit - TextParaCount <= 0}
  end;{TextParaLimit > 0}
  if (BruttoCharLimit > 0) then
  begin
   DCC := aChild.PCharLenA[k2_tiText].SLen;
   Inc(DCC, cc_EOL_Len);
   if (DCC > BruttoCharLimit - BruttoCharCount) then
   begin
    l3System.Beep;
    raise EevLimitReached.Create(c_excCharLimitReached);
    {&&& exception $$$}
   end;//DCC > BruttoCharLimit - BruttoCharCount
  end;//BruttoCharLimit > 0
 end;//..k2_tiText..
end;

procedure TevCustomProcessor.CheckParaOp(aParent  : Tl3Variant;
                                         var aChild     : Tl3Variant;
                                         anOp           : Tl3Operation;
                                         var anIndex    : TnevParaIndex);
  {-}
begin
 if (Self <> nil) then
  DoCheckParaOp(aParent, aChild, anOp, anIndex);
end;

procedure TevCustomProcessor.CheckTextOp(Text: Tl3CustomString; Op: Tl3Operation);
  {-}
var
 D : Long;
begin
 if (Self <> nil) then
 begin
  CheckReadOnly;
  if (BruttoCharLimit > 0) AND (Op = l3_opInsert) then
  begin
   D := BruttoCharLimit - BruttoCharCount;
   if (Text.Len > D) then
   begin
    Text.Len := D;
    l3System.Beep;
   end;//Text.Len > D
  end;//BruttoCharLimit > 0..
 end;//Self <> nil
end;

procedure TevCustomProcessor.ParaOpEx(Parent    : Tl3Variant;
                                      aChild    : Tl3Variant;
                                      Op              : Tl3Operation;
                                      IterateChildren : Boolean);
  {-}
  
 function ParaOpPrim(Child     : Tl3Variant;
                     Op              : Tl3Operation;
                     IterateChildren : Boolean): Boolean;
   {-}

  procedure DoLeaf(aLeaf : Tl3Variant);
  var
   l_DCC : Long;
  begin//DoLeaf
   if aLeaf.IsKindOf(k2_typBitmapPara) then
   begin
    Case Op of
     l3_opDelete:
     begin
      Dec(f_BitmapParaCount);
     end;//l3_opDelete
     l3_opInsert:
     begin
      Inc(f_BitmapParaCount);
     end;//l3_opInsert
    end;//Case Op
   end;//aLeaf.IsKindOf(k2_typBitmapPara)
   if Tk2Type(aLeaf.TagType).HasProperty[k2_tiText] then
   begin
    if true{aWasText} then
     l_DCC := aLeaf.PCharLenA[k2_tiText].SLen
    else
     l_DCC := 0;
    Case Op of
     l3_opDelete:
     begin
      NettoCharCount := NettoCharCount - l_DCC;
      BruttoCharCount := BruttoCharCount - l_DCC - cc_EOL_Len;
      TextParaCount := TextParaCount - 1;
     end;//l3_opDelete
     l3_opInsert:
     begin
      NettoCharCount := NettoCharCount + l_DCC;
      BruttoCharCount := BruttoCharCount + l_DCC + cc_EOL_Len;
      TextParaCount := TextParaCount + 1;
     end;//l3_opInsert
    end;//Case Op
   end;//aLeaf.TagType.HasProperty[k2_tiText]
  end;//DoLeaf

  procedure DoList(aList : Tl3Variant);
 
   function SubParaOp(aSubChild: Tl3Variant; Index: Long): Bool;
   var
    l_Inc : Integer; 
   begin//SubParaOp
    Result := true;
    if aSubChild.IsKindOf(k2_typLeafPara) then
    begin
     DoLeaf(aSubChild.AsObject);
     l_Inc := 1;
    end//aSubChild.IsKindOf(k2_typLeafPara)
    else
    begin
     DoList(aSubChild.AsObject);
     l_Inc := aSubChild.IntA[k2_tiAllChildrenCount];
    end;//aSubChild.IsKindOf(k2_typLeafPara)
    if (Op = l3_opInsert) then
     with aList do
      IntA[k2_tiAllChildrenCount] := IntA[k2_tiAllChildrenCount] + l_Inc;
   end;//SubParaOp

  var
   l_Max: Integer;

   function TableRowSubParaOp(aSubChild: Tl3Variant; Index: Long): Bool;
   begin//TableRowSubParaOp
    Result := true;
    Assert(aSubChild.IsKindOf(k2_typParaList));
    DoList(aSubChild.AsObject);
    l_Max := Max(l_Max, aSubChild.IntA[k2_tiAllChildrenCount]);
   end;//TableRowSubParaOp

  begin//DoList
   if aList.IsKindOf(k2_typTableRow) then
   begin
    l_Max := 0;
    aList.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@TableRowSubParaOp));
    aList.IntA[k2_tiAllChildrenCount] := l_Max;
   end//aList.IsKindOf(k2_typTableRow)
   else
    aList.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@SubParaOp));
  end;//DoList

 begin//ParaOpPrim
  Result := false;
  if Child.IsKindOf(k2_typLeafPara) then
  begin
   Result := true;
   DoLeaf(Child);
  end//Child.IsKindOf(k2_typLeafPara)
  else
  if IterateChildren then
   if Child.IsKindOf(k2_typParaList) then
    DoList(Child);
 end;//ParaOpPrim

var
 l_Max : Integer;

 function GetMax(aTag: Tl3Variant; anIndex: Long): Boolean;
 begin//
  l_Max := Max(l_Max, aTag.IntA[k2_tiAllChildrenCount]);
  Result := True;
 end;//GetMax

var
 l_Delta  : Integer;
 l_Parent : Tl3Variant;
begin
 if ParaOpPrim(aChild, Op, IterateChildren) then
  l_Delta := 1
 else
  l_Delta := aChild.IntA[k2_tiAllChildrenCount];
 if (Op = l3_opDelete) then
  l_Delta := -l_Delta;
 l_Parent := Parent;
 // Цикл по родителям верх:
 while (l_Parent <> nil) AND l_Parent.IsValid AND
       l_Parent.IsKindOf(k2_typParaList) do
 begin
  with l_Parent do
   if IsKindOf(k2_typTableRow) then
   begin
    l_Max := 0;
    IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@GetMax));
    l_Delta := (l_Max - IntA[k2_tiAllChildrenCount]);
    IntA[k2_tiAllChildrenCount] := l_Max;
   end//IsKindOf(k2_typTableRow)
   else
    IntA[k2_tiAllChildrenCount] := IntA[k2_tiAllChildrenCount] + l_Delta;
  if not IterateChildren then
   break;  
  l_Parent := l_Parent.Owner;
 end;//l_Parent <> nil
end;

procedure TevCustomProcessor.DoParaOp(Parent : Tl3Variant;
                                      Child  : Tl3Variant;
                                      Op           : Tl3Operation);
  //virtual;
  {* - завершить операцию с параграфом. }
begin
 ParaOpEx(Parent, Child, Op, true);
 if (Document <> nil) then
  Document.UpdatePreview;
end;

procedure TevCustomProcessor.ParaOp(Parent : Tl3Variant;
                                    Child  : Tl3Variant;
                                    Op           : Tl3Operation);
  {-}
begin
 if (Self <> nil) then
  DoParaOp(Parent, Child, Op);
end;

procedure TevCustomProcessor.TextOp(Text: Tl3CustomString; Op: Tl3Operation);
  {-}
var
 DCC : Long;
begin
 if (Self <> nil) then
 begin
  DCC := Text.Len;
  Case Op of
   l3_opDelete:
   begin
    BruttoCharCount := BruttoCharCount - DCC;
    NettoCharCount := NettoCharCount - DCC;
   end;//l3_opDelete
   l3_opInsert:
   begin
    BruttoCharCount := BruttoCharCount + DCC;
    NettoCharCount := NettoCharCount + DCC;
   end;//l3_opInsert
  end;//Case Op..
  if (DCC <> 0) AND (Document <> nil) then
   Document.ViewArea.Changed(nev_cpText); 
 end;//Self <> nil
end;

procedure TevCustomProcessor.ClearStat;
  {-}
begin
 NettoCharCount := 0;
 BruttoCharCount := 0;
 TextParaCount := 0;
 f_BitmapParaCount := 0;
end;

procedure TevCustomProcessor.LinkDocument(const aDocument: InevObjectHolder);
  {-}
begin
 f_Document := Pointer(aDocument);
end;

procedure TevCustomProcessor.UnlinkDocument(const aDocument: InevObjectHolder);
  {-}
begin
 Assert(InevObjectHolder(f_Document) = aDocument);
 f_Document := nil;
end;

// start class TevCustomUndoProcessor

constructor TevCustomUndoProcessor.Create(aContainerClass : Rl3OperationContainer = nil);
  {reintroduce;}
  {-}
begin
 inherited Create;
 if (aContainerClass = nil) then
  f_ContainerClass := Tk2OperationContainer
 else
  f_ContainerClass := aContainerClass;
end;

class function TevCustomUndoProcessor.Make(aContainerClass : Rl3OperationContainer = nil): InevProcessor;
  //reintroduce;
  {-}
var
 l_Proc : TevCustomUndoProcessor;
begin
 l_Proc := Create(aContainerClass);
 try
  Result := l_Proc;
 finally
  l3Free(l_Proc);
 end;//try..finally
end;

type
  Tk2OperationContainerHack = class(Tk2OperationContainer);
  
procedure TevCustomUndoProcessor.Cleanup;
  {override;}
  {-}
begin
 if (f_Container <> nil) then
  Tk2OperationContainerHack(f_Container).DoSetOwner(nil);
 f_Container := nil;
 f_UndoBuffer := nil;
 inherited;
end;

function TevCustomUndoProcessor.Undo: Bool;
  {-}
begin
 if (Self <> nil) AND CanUndo then
 begin
  Inc(f_InUndo);
  try
   Lock;
   try
    l3Set(f_Container, UndoBuffer.GetActiveObject(false));
    try
     Result := UndoBuffer.Undo(Self);
     DoAfterUndoRedo;
    finally
     l3Free(f_Container);
    end;{try..finally}
   finally
    Unlock;
   end;//try..finally
  finally
   Dec(f_InUndo);
  end;{try..finally}
 end//Self <> nil
 else
  Result := false;
end;

function TevCustomUndoProcessor.Redo: Bool;
  {-}
begin
 if (Self <> nil) AND CanRedo then
 begin
  Inc(f_InUndo);
  try
   Lock;
   try
    l3Set(f_Container, UndoBuffer.GetActiveObject(true));
    try
     Result := UndoBuffer.Redo(Self);
     DoAfterUndoRedo;
    finally
     l3Free(f_Container);
    end;{try..finally}
   finally
    Unlock;
   end;//try..finally
  finally
   Dec(f_InUndo);
  end;{try..finally}
 end//(Self <> nil) AND CanRedo
 else
  Result := false;
end;

function TevCustomUndoProcessor.FinishOp(anOp: TObject): Boolean;
  {-}
begin
 Result := true;
 if (anOp = f_Container) then
 begin
  if (f_Container.RefCount = 1) then
  begin
   f_ReadOnly := false;
   f_Container := nil;
   if (f_InUndo = 0) AND SaveUndo then
   begin
    Tk2OperationContainer(anOp).Use;
    try
     if (UndoBuffer <> nil) then
      UndoBuffer.ExecutedOperation(Tk2OperationContainer(anOp));
    finally
     Tk2OperationContainer(anOp).Free;
    end;//try..finally
   end;//(f_InUndo = 0) AND SaveUndo
   Result := false;
   if f_LockedContainer then
   begin
    f_LockedContainer := false;
    Unlock;
   end;//f_LockedContainer
   if (Document <> nil) AND (Document.ViewArea <> nil) then
    try
     Document.ViewArea.Update;
    except
     on EAssertionFailed do
      raise EevUnstableProcessWhileInsertUserComment.Create('Переходные процессы http://mdp.garant.ru/pages/viewpage.action?pageId=255980313');
    end;//try..except
   f_InIOProcess := false;
   // - все типа закончили операцию ввода/вывода.
  end;//(f_Container.RefCount <= 1) then
 end;//anOp = f_Container..
end;

function TevCustomUndoProcessor.InOp: Bool;
  {-}
begin
 Result := (Self <> nil) AND (f_Container <> nil);
end;

function  TevCustomUndoProcessor.Get_InUndo: Boolean;
  {-}
begin
 Result := InUndo;
end;

function  TevCustomUndoProcessor.Get_SaveUndo: Boolean;
  {-}
begin
 Result := f_SaveUndo AND not f_InIOProcess AND not InUndo;
end;

procedure TevCustomUndoProcessor.Set_SaveUndo(Value: Boolean);
  {-}
begin
 f_SaveUndo := Value;
end;

function TevCustomUndoProcessor.pm_GetContext: Il3OpPack;
  {-}
begin
 Result := f_Container;
end;

function TevCustomUndoProcessor.pm_GetDeleteMapped: Bool;
  {-}
begin
 Result := f_DeleteMapped;
end;

procedure TevCustomUndoProcessor.pm_SetDeleteMapped(Value: Boolean);
  {-}
begin
 f_DeleteMapped := Value;
end;

function  TevCustomUndoProcessor.pm_GetOptimize: Bool;
  {-}
begin
 Result := f_Optimize;
end;

procedure TevCustomUndoProcessor.pm_SetOptimize(Value: Boolean);
  {-}
begin
 f_Optimize := Value;
end;

function TevCustomUndoProcessor.pm_GetInIOProcess: Boolean;
  {-}
begin
 Result := f_InIOProcess;
end;

procedure TevCustomUndoProcessor.pm_SetInIOProcess(Value: Boolean);
  {-}
begin
 f_InIOProcess := Value;
end;

function TevCustomUndoProcessor.Get_UndoBuffer: Ik2UndoBuffer;
  {-}
begin
 Result := UndoBuffer;
end;

function TevCustomUndoProcessor.pm_GetUndoBuffer: Ik2UndoBuffer;
  {-}
begin
 if (f_UndoBuffer = nil) then
  f_UndoBuffer := TevCustomUndoBuffer.Make;
 Result := f_UndoBuffer;
end;

function TevCustomUndoProcessor.pm_GetCanUndo: Bool;
  {-}
begin
 if (UndoBuffer = nil) then
  Result := false
 else
  Result := UndoBuffer.CanUndo;
end;

function TevCustomUndoProcessor.pm_GetCanRedo: Bool;
  {-}
begin
 if (UndoBuffer = nil) then
  Result := false
 else
  Result := UndoBuffer.CanRedo;
end;

function TevCustomUndoProcessor.pm_GetProcessor: InevProcessor;
  {-}
begin
 Result := Self;
end;

procedure TevCustomUndoProcessor.MarkModified(aTarget: Tl3Variant);
  {-}
begin
 {$IfDef Nemesis}
 if aTarget.MarkModified then
  Exit;
 {$EndIf Nemesis}
 if (Self <> nil) then
 begin
  if (Document <> nil) then
   Document.Modified := true;
 end;//Self <> nil
end;

procedure TevCustomUndoProcessor.InvertModified;
  {-}
begin
 if (Self <> nil) then
  if (Document <> nil) then
   Document.Modified := not Document.Modified;
end;

function TevCustomUndoProcessor.GetModified: Boolean;
  {-}
begin
 if (Document = nil) then
  Result := false
 else
  Result := Document.Modified;
end;

function TevCustomUndoProcessor.StartOp(OpCode : Integer = 0;
                                        DoLock : Boolean = true): Il3OpPack;
  {-}
begin
 if (f_Container = nil) then
 begin
  f_InIOProcess := false;
  f_SaveUndo := true;
  if DoLock then
  begin
   Lock;
   f_LockedContainer := true;
  end
  else
   f_LockedContainer := false;
  f_Container := f_ContainerClass.Create(Self);
  try
   if (OpCode = 0) then
    f_Container.Code := ev_msgSetAtom
   else
    f_Container.Code := OpCode;
   Result := f_Container;
  finally
   f_Container := f_Container.Free;
  end;//try..finally
 end else
  Result := f_Container;
end;

function TevCustomUndoProcessor.LastOp: Il3OpPack;
  {* - предыдущая операция. }
begin
 if (UndoBuffer = nil) OR UndoBuffer.Empty then
  Result := nil
 else
  Supports(UndoBuffer.Last, Il3OpPack, Result);
end;
  
function TevCustomUndoProcessor.InUndo: Boolean;
  {-}
begin
 Result := (f_InUndo > 0);
end;

procedure TevCustomUndoProcessor.DisableReadOnly;
  {-}
begin
 Inc(f_DisableReadOnly);
end;

procedure TevCustomUndoProcessor.EnableReadOnly;
  {-}
begin
 Dec(f_DisableReadOnly);
end;

procedure TevCustomUndoProcessor.ClearStat;
  //override;
  {-}
begin
 inherited;
 if (f_UndoBuffer <> nil) then
  f_UndoBuffer.Clear;
end;

procedure TevCustomUndoProcessor.CheckInsert(aParent  : Tl3Variant;
                                             var aChild     : Tl3Variant;
                                             var anIndex    : Integer);
  //virtual;
  {* - проверить операцию с параграфом. }
begin
 if aParent.IsKindOf(k2_typParaList) then
  CheckParaOp(aParent, aChild, l3_opInsert, TnevParaIndex(anIndex));
end;

procedure TevCustomUndoProcessor.CheckDelete(aParent  : Tl3Variant;
                                             aChild   : Tl3Variant;
                                             anIndex        : Integer);
  //virtual;
  {* - проверить операцию с параграфом. }
begin
 if aParent.IsKindOf(k2_typParaList) then
  CheckParaOp(aParent, aChild, l3_opDelete, TnevParaIndex(anIndex));
end;

procedure TevCustomUndoProcessor.NotifyCompleted(aList  : Tl3Variant;
                                                 aChild : Tl3Variant);
  {-}
begin
 if aList.IsKindOf(k2_typParaList) then
  ParaOpEx(aList, aChild, l3_opInsert, false);
end;
   
procedure TevCustomUndoProcessor.NotifyInsert(aList    : Tl3Variant;
                                              aProp    : TObject;
                                              aChild   : Tl3Variant;
                                              anIndex        : Integer;
                                              const anOpPack : Il3OpPack);
  //virtual;
  {-}
begin
end;

procedure TevCustomUndoProcessor.NotifyDelete(aList    : Tl3Variant;
                                              aProp    : TObject;
                                              aChild   : Tl3Variant;
                                              anIndex        : Integer;
                                              const anOpPack : Il3OpPack);
  //virtual;
  {-}
begin
end;

procedure TevCustomUndoProcessor.NotifyPropChanged(aProp: TObject;
 const aValues;
 const anOp: Ik2Op);
  {* Сообщает об изменении свойства объекта }
     //virtual;
     {-}
begin
end;

function TevCustomUndoProcessor.NeedReplaceQuotes: Boolean;
begin
 Result := GetNeedReplaceQuotes;
end;

function TevCustomUndoProcessor.GetNeedReplaceQuotes: Boolean;
  //virtual;
begin
 Result := true;
end;

procedure TevCustomUndoProcessor.DoAfterUndoRedo;
begin

end;

procedure TevCustomProcessor.pm_SetDefaultStyle(aValue: Tl3StyleId);
begin
 f_DefaultStyle := aValue;
end;

end.

