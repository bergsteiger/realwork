unit evHyperlink;
{* Модуль с классом TevHyperlink для реализации интерфейса
   IevHyperlink для текстовых параграфов. }

{ Библиотека "Эверест"       }
{ Автор: Люлин А.В. ©        }
{ Модуль: evHyperlink -      }
{ Начат: 10.06.1999 12:38    }
{ $Id: evHyperlink.pas,v 1.105 2015/09/17 11:40:28 dinishev Exp $ }

// $Log: evHyperlink.pas,v $
// Revision 1.105  2015/09/17 11:40:28  dinishev
// {Requestlink:606128916}
//
// Revision 1.104  2015/09/14 14:29:14  dinishev
// {Requestlink:606410627}
//
// Revision 1.103  2015/03/31 13:17:37  morozov
// {RequestLink: 594881807}
//
// Revision 1.102  2015/01/19 18:36:35  lulin
// {RequestLink:580710025}
//
// Revision 1.101  2015/01/19 16:50:45  lulin
// {RequestLink:580710025}
//
// Revision 1.100  2014/04/30 11:23:52  lulin
// - выпрямляем зависимости.
//
// Revision 1.99  2014/04/11 15:30:29  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.98  2014/04/10 16:32:21  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.97  2014/04/10 13:09:44  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.96  2014/04/10 11:50:05  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.95  2014/04/08 12:35:09  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.94  2014/04/07 17:56:59  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.93  2014/04/04 17:53:34  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.92  2014/04/03 17:10:25  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.91  2014/03/25 11:53:27  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.90  2014/03/24 09:06:09  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.89  2014/03/21 16:24:50  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.88  2014/03/20 08:07:36  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.87  2014/03/06 17:23:19  lulin
// - избавляемся от теговых обёрток.
//
// Revision 1.86  2014/03/04 13:08:19  lulin
// - переводим идентификаторы Sub'ов и сегментов на нормальные Enum'ы.
//
// Revision 1.85  2013/10/21 15:42:58  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.84  2013/10/21 10:30:41  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.83  2013/05/31 04:58:21  lulin
// - портируем под XE4.
//
// Revision 1.82  2013/04/04 11:18:51  lulin
// - портируем.
//
// Revision 1.81  2012/09/27 09:33:38  dinishev
// {Requestlink:397289578}
//
// Revision 1.80  2011/08/23 18:40:57  lulin
// {RequestLink:279774229}.
// - не падаем при отсутствии адреса у ссылки.
//
// Revision 1.79  2010/07/02 14:48:12  lulin
// {RequestLink:222758020}.
//
// Revision 1.78  2010/02/18 13:55:28  lulin
// {RequestLink:160006538}.
//
// Revision 1.77  2009/08/11 09:23:05  oman
// - fix:  {RequestLink:159356236}
//
// Revision 1.76  2009/07/31 09:42:20  oman
// - new: {RequestLink:158795599}
//
// Revision 1.75  2009/07/23 13:42:11  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.74  2009/07/23 08:14:38  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.73  2009/07/20 16:44:04  lulin
// - убираем из некоторых листьевых параграфов хранение типа конкретного тега, вместо этого "плодим" под каждый тип тега свой тип класса.
//
// Revision 1.72  2009/07/20 12:49:31  lulin
// - подготавливаемся к переносу изменений в ветку.
//
// Revision 1.71  2009/07/14 14:56:26  lulin
// {RequestLink:141264340}. №25.
//
// Revision 1.70  2009/07/13 12:31:36  lulin
// {RequestLink:141264340}. №23ac.
//
// Revision 1.69  2009/07/11 09:24:41  lulin
// - избавляемся от лишнего дёрганья счётчиков ссылок.
//
// Revision 1.68  2009/07/06 13:32:06  lulin
// - возвращаемся от интерфейсов к объектам.
//
// Revision 1.67  2009/06/25 12:57:30  lulin
// - вычищаем ненужный контекст.
//
// Revision 1.66  2009/06/02 16:12:53  lulin
// - выделяем внутренние интерфейсы в отдельные модули.
//
// Revision 1.65  2009/06/02 13:48:01  lulin
// [$148574526].
//
// Revision 1.64  2009/06/01 11:13:28  lulin
// [$148572848].
//
// Revision 1.63  2009/04/16 15:55:28  lulin
// [$143396720]. №5. Убираем доступ к ненужному свойству.
//
// Revision 1.62  2009/04/15 18:49:30  lulin
// [$143396720]. Основательно перетрясаем модель.
//
// Revision 1.61  2009/03/05 13:09:36  lulin
// - <K>: 137470629. Используем ссылки на типы.
//
// Revision 1.60  2009/03/04 13:32:46  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.59  2008/12/12 19:19:14  lulin
// - <K>: 129762414.
//
// Revision 1.58  2008/11/19 08:34:00  dinishev
// <K> : 124453077
//
// Revision 1.57  2008/08/14 13:08:45  lulin
// - переносим метод в рамках <K>: 108626698.
//
// Revision 1.56  2008/06/20 14:48:50  lulin
// - используем префиксы элементов.
//
// Revision 1.55  2008/06/20 14:02:44  lulin
// - используем префиксы элементов.
//
// Revision 1.54  2008/06/07 16:13:53  lulin
// - нарисовал константы на модели.
//
// Revision 1.53  2008/05/08 07:03:13  lulin
// - <K>: 90441963.
//
// Revision 1.52  2008/05/07 18:29:48  lulin
// - изменения в рамках <K>: 90441963.
//
// Revision 1.51  2008/04/15 08:23:45  lulin
// - передаём вью в качестве параметра.
//
// Revision 1.50  2008/04/14 13:46:35  lulin
// - <K>: 89096854.
//
// Revision 1.49  2008/04/07 06:18:37  lulin
// - cleanup.
//
// Revision 1.48  2008/02/11 14:06:20  oman
// - new: Информация о типе гиперссылки (cq20760)
//
// Revision 1.47  2007/12/24 15:25:22  lulin
// - удалены ненужные файлы.
//
// Revision 1.46  2007/12/04 12:47:02  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.37.4.26  2007/09/14 13:26:05  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.37.4.25.2.4  2007/09/13 12:35:57  lulin
// - переименовано свойство.
//
// Revision 1.37.4.25.2.3  2007/09/12 17:51:48  lulin
// - cleanup.
//
// Revision 1.37.4.25.2.2  2007/09/12 16:14:07  lulin
// - убран ненужный параметр по-умолчанию.
//
// Revision 1.37.4.25.2.1  2007/09/12 15:23:01  lulin
// - избавляемся от метода, дублирующего функциональность получения атрибута.
//
// Revision 1.37.4.25  2007/09/11 18:49:58  lulin
// - удален ненужный параметр.
//
// Revision 1.37.4.24  2007/09/06 09:37:36  lulin
// - переименовано свойство.
//
// Revision 1.37.4.23  2007/09/04 17:06:00  lulin
// - cleanup.
//
// Revision 1.37.4.22  2007/07/23 05:20:46  oman
// warning fix
//
// Revision 1.37.4.21  2007/06/20 09:15:37  dinishev
// merge с веткой
//
// Revision 1.37.4.20  2007/04/11 09:20:59  oman
// warning fix                                                          
//
// Revision 1.37.4.19  2006/12/20 17:49:45  lulin
// - файл с константами переехал в общую папку.
//
// Revision 1.37.4.18  2006/12/20 12:42:27  lulin
// - cleanup.
//
// Revision 1.37.4.17  2006/11/10 17:15:54  lulin
// - объединил с веткой.
//
// Revision 1.37.4.16  2006/11/03 11:00:05  lulin
// - объединил с веткой 6.4.
//
// Revision 1.37.4.15.4.1  2006/10/26 12:23:46  lulin
// - cleanup.
//
// Revision 1.37.4.15  2006/10/03 08:12:27  oman
// - fix: Из-за кэширования ID могли получить его рассинхронизацию
//  с деревом документа.
//
// Revision 1.37.4.14  2006/08/02 10:51:52  lulin
// - объединил с веткой в которой боролся со скроллингом.
//
// Revision 1.37.4.13.14.1  2006/07/28 14:11:13  lulin
// - убрана функция переформатирования параграфа.
//
// Revision 1.37.4.13  2005/12/26 13:26:48  lulin
// - bug fix: не всегда отображалось изменение комментариев (CQ OIT5-18865).
//
// Revision 1.37.4.12  2005/11/21 10:11:26  lulin
// - удален ненужный глобальный метод.
//
// Revision 1.37.4.11  2005/11/09 15:28:24  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.37.4.10  2005/11/04 11:22:09  lulin
// - cleanup: с параграфа убран метод переформатирования - он оставлен только на форме отображения объекта.
//
// Revision 1.37.4.9  2005/07/18 17:37:42  lulin
// - упорядочена интерфейсная модель редактора - для удобства чтения и эффективности использования, а также для избавления от посылки сообщений.
//
// Revision 1.37.4.8  2005/07/18 11:22:37  lulin
// - методу, возвращаещему выделение на параграфе дано более подходящее название.
//
// Revision 1.37.4.7  2005/07/07 16:54:02  lulin
// - cleanup.
//
// Revision 1.37.4.6  2005/06/15 11:45:21  lulin
// - cleanup.
//
// Revision 1.37.4.5  2005/06/11 11:13:20  lulin
// - избавился от использования "устаревших" интерфейсов.
//
// Revision 1.37.4.4  2005/06/07 09:29:23  lulin
// - cleanup: избавляемся от ссылки на нетипизированного Owner'а.
//
// Revision 1.37.4.3  2005/06/07 08:49:37  lulin
// - cleanup.
//
// Revision 1.37.4.2  2005/06/06 16:30:26  lulin
// - cleanup.
//
// Revision 1.37.4.1  2005/05/18 12:42:46  lulin
// - отвел новую ветку.
//
// Revision 1.34.2.4  2005/05/18 12:32:09  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.34.2.3  2005/04/28 09:18:29  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.34.2.2  2005/04/18 16:43:25  lulin
// - используем _Box, а не _Ik2Tag (пока выигрыша в производительности не дало).
//
// Revision 1.34.2.1  2005/04/13 14:31:51  lulin
// - вместо безликих тегов используем параграфы.
//
// Revision 1.36.2.3  2005/04/27 06:34:49  lulin
// - cleanup.
//
// Revision 1.36.2.2  2005/04/23 16:07:25  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.36.2.1  2005/04/21 14:46:54  lulin
// - избавляемся от обертки над тегами - теперь объекты посредством шаблонов сами реализуют интерфейс _Ik2Tag.
//
// Revision 1.36  2005/04/21 05:11:38  lulin
// - используем _Box (пока из-за постоянных преобразований туда и обратно - по скорости стало только хуже).
//
// Revision 1.35  2005/04/18 17:18:22  lulin
// - используем _Box, а не _Ik2Tag (пока выигрыша в производительности не дало).
//
// Revision 1.37  2005/04/28 15:03:38  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.36.2.3  2005/04/27 06:34:49  lulin
// - cleanup.
//
// Revision 1.36.2.2  2005/04/23 16:07:25  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.36.2.1  2005/04/21 14:46:54  lulin
// - избавляемся от обертки над тегами - теперь объекты посредством шаблонов сами реализуют интерфейс _Ik2Tag.
//
// Revision 1.36  2005/04/21 05:11:38  lulin
// - используем _Box (пока из-за постоянных преобразований туда и обратно - по скорости стало только хуже).
//
// Revision 1.35  2005/04/18 17:18:22  lulin
// - используем _Box, а не _Ik2Tag (пока выигрыша в производительности не дало).
//
// Revision 1.34  2005/03/28 11:32:07  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.33  2005/03/28 06:37:08  lulin
// - remove object: Tk2AtomW.
//
// Revision 1.32  2005/03/25 17:09:01  lulin
// - избавляемся от метода Tk2AtomW.sLong.
//
// Revision 1.31  2005/03/24 14:10:31  lulin
// - удалены ненужные методы.
//
// Revision 1.30  2005/03/23 14:14:12  lulin
// - убран ненужный утилитный класс.
//
// Revision 1.29  2005/03/23 12:42:23  lulin
// - вместо вызова метода ссылаемся на свойство.
//
// Revision 1.28  2005/03/21 16:28:16  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.27  2005/03/19 16:39:51  lulin
// - спрятаны ненужные методы.
//
// Revision 1.26  2005/03/15 15:30:02  lulin
// - cleanup.
//
// Revision 1.25  2005/03/15 10:30:18  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.24  2005/03/11 17:13:05  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.23  2005/03/10 11:35:09  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.22  2005/03/10 07:05:11  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.21  2005/03/09 18:40:19  lulin
// - remove method: Tk2AtomR.DeleteChild.
// - new method: _Ik2Tag.DeleteChild.
//
// Revision 1.20  2005/03/09 17:05:20  lulin
// - remove method: Tk2AtomR._InsertChild.
// - new method: _Ik2Tag._InsertChild.
//
// Revision 1.19  2005/03/04 19:43:33  lulin
// - remove method: Tk2AtomR.Assign.
//
// Revision 1.18  2005/03/04 15:49:02  lulin
// - спрятана процедура Tk2Type.New.
//
// Revision 1.17  2005/03/04 13:59:17  lulin
// - remove method: Tk2AtomR._AddChild.
//
// Revision 1.16  2005/03/01 09:42:42  lulin
// - new prop: IevHyperlink.FromDocument.
//
// Revision 1.15  2005/01/11 13:04:10  lulin
// - rename interface: _Il3String -> Il3WordsSeq.
//
// Revision 1.14  2004/11/29 12:34:03  lulin
// - bug fix: при удалении адреса ссылки неправильно учитывался TypeID.
//
// Revision 1.13  2004/11/29 10:57:51  lulin
// - new behavior: при изменении параметров ссылки сбрасываем ее Hint.
//
// Revision 1.12  2004/11/10 12:13:25  lulin
// - cleanup: перевел параграфы с реализации интерфейсов на реализацию инструментов.
//
// Revision 1.11  2004/10/18 16:18:56  lulin
// - remove unit: evTagTools.
//
// Revision 1.10  2004/10/18 15:41:42  lulin
// - remove method: TevTag.Unformat.
// - new proc: evUnformatPara.
//
// Revision 1.9  2004/09/16 15:39:06  lulin
// - у гиперссылки теперь можно записывать свойство Hint.
//
// Revision 1.8  2004/09/08 11:41:17  lulin
// - new behavior: интерфейс доступа к гиперссылке проверяет свойство ReadOnly и поднимает EevReadOnly в случае если оно true.
//
// Revision 1.7  2004/09/03 14:52:15  voba
// - new behavior: при добавлении адреса гиперссылке - проверяем, что такой уже есть.
//
// Revision 1.6  2004/07/27 14:53:03  voba
// - убран Assert.
//
// Revision 1.5  2004/06/18 12:00:11  law
// - remove unit: evTextPara.
//
// Revision 1.4  2004/06/18 11:19:16  law
// - cleanup.
//
// Revision 1.3  2004/06/17 15:05:35  law
// - еще пачка методов уехала из класса _TevTextPara.
//
// Revision 1.2  2004/05/25 13:08:49  law
// - change: Tk2AtomR.ArrayProp - теперь property, а не функция.
// - bug fix: при вставке из буфера вставлялись "левые" элементы оглавления.
//
// Revision 1.1  2004/05/06 09:04:30  law
// - rename unit: evHyperlink_Impl -> evHyperlink.
//
// Revision 1.51  2004/05/06 08:49:09  law
// - rename class: TevHyperlinkImplementation -> TevHyperlink.
//
// Revision 1.50  2004/03/26 14:41:39  law
// - new behavior: для Немезиса генерируем ID живой ссылки, если его не было.
//
// Revision 1.49  2004/02/03 15:04:07  law
// - bug fix: некорректно отдавался интерфейс IevHyperlink.
//
// Revision 1.48  2004/02/03 13:44:47  law
// - new prop: IevHyperlink._Para.
//
// Revision 1.47  2004/02/03 13:32:46  law
// - new param: TevHyperlink.Make -> aPara.
//
// Revision 1.46  2004/01/13 13:29:14  law
// - new unit: evHyperlinkNode.
//
// Revision 1.45  2003/11/28 14:11:06  law
// - new unit: evSegmentsListConst.
//
// Revision 1.44  2003/09/23 08:37:56  law
// - new prop: IevHyperlink.Hint.
// - rename proc: ev_plAssignNil -> l3AssignNil.
//
// Revision 1.43  2003/09/23 08:23:52  law
// - new interface: IevAddressHolder.
//
// Revision 1.42  2003/09/18 14:35:41  law
// - new prop: IeeHyperlink.RevisionID.
//
// Revision 1.41  2003/06/30 16:16:26  law
// - new: расширен интерфейс IeeHyperlink.
//
// Revision 1.40  2003/04/25 12:53:45  law
// - new behavior: документу сделан тег k2_tiMaxHyperlinkHandle - максимальное значение идентификатора ссылки в документе, на основании него теперь можно распределять новые номера ссылок.
//
// Revision 1.39  2003/02/06 10:23:48  law
// - cleanup: используем код операции по умолчанию.
//
// Revision 1.38  2002/11/19 10:09:25  law
// - remove unit: evBseSeg.
// - new unit: evSegment.
//
// Revision 1.37  2002/11/19 09:22:40  law
// - cleanup.
//
// Revision 1.36  2002/09/26 14:30:05  law
// - cleanup.
//
// Revision 1.35  2002/09/26 11:33:53  law
// - new behavior: обрабатываем переход по ссылке без ID.
//
// Revision 1.34  2002/07/09 13:57:39  law
// - new unit: evMsgCode.
//
// Revision 1.33  2002/02/08 15:31:51  law
// - rename unit: evTxtPar -> evTextPara.
//
// Revision 1.32  2002/02/05 08:18:15  law
// - remove proc: ev_plPas (остался ее аналог l3PCharLen2String).
//
// Revision 1.31  2001/12/27 15:03:29  law
// - new constructors: добавлены два конструктора Tl3String.Make.
//
// Revision 1.30  2001/08/29 07:01:08  law
// - split unit: l3Intf -> l3BaseStream, l3BaseDraw, l3InterfacedComponent.
//
// Revision 1.29  2001/06/18 14:32:49  law
// - cleanup.
//
// Revision 1.28  2001/05/07 08:54:01  law
// - new behavior: _Tl3Tree ->Il3RootNode.
//
// Revision 1.27  2001/03/11 10:26:07  law
// - к интерфейсу IevAddressList добавлено свойство Items.
//
// Revision 1.26  2001/03/05 14:33:57  law
// - к интерфейсу IevAddressList добавлен метод Modify.
//
// Revision 1.25  2001/03/05 14:08:28  law
// - поменялся порядок у методов _IterateChildren...
//
// Revision 1.24  2001/01/31 10:37:30  law
// - оптимизировано использование QueryInterface.
//
// Revision 1.23  2001/01/23 13:13:28  voba
// - bug fix: добавление нового адреса.
//
// Revision 1.22  2001/01/23 12:56:23  law
// - добавлена функция evAddress и TevAddress преобразован в объект.
//
// Revision 1.21  2001/01/22 15:29:15  law
// - добавлен интерфейс IevAddressList.
//
// Revision 1.20  2000/12/18 12:01:40  voba
// - bug fix: переход по ссылке.
//
// Revision 1.19  2000/12/15 15:10:36  law
// - вставлены директивы Log.
//

{$Include evDefine.inc }

interface

uses
  l3Interfaces,
  l3IID,
  l3Types,
  l3Variant,
  l3Base,

  afwNavigation,

  k2Interfaces,  
  k2InternalInterfaces,
  k2ProcTagTool,

  evdTypes,

  evInternalInterfaces,

  nevTools,
  nevNavigation
  ;

type
  TevHyperlink = class(Tk2ProcTagTool,
                       IevHyperlink,
                       IevMoniker,
                       IevURLMoniker,
                       IevIDMoniker,
                       IevAddressMoniker,
                       IevHyperlinkMoniker,
                       IevAddressList,
                       IevAddressHolder)
    {* Класс для реализации интерфейса IevHyperlink для текстового параграфа. }
    private
    // property fields
      f_ID        : Long;
      f_Hyperlink : Tl3Tag;
      f_URL       : Tl3String;
      f_Para      : InevPara;
      f_Loc       : InevLocation;
    protected
    // property methods
      // IevHyperlink
      function  pm_GetID: Long;
        {-}
      function  Get_ID: Integer;
      procedure Set_ID(Value: Integer);
        {-}
      function  pm_GetAddress: TevAddress;
      procedure pm_SetAddress(const Value: TevAddress);
        {-}
      function  IevAddressHolder_pm_GetAddress: Tl3Variant;
      function  IevAddressHolder.pm_GetAddress = IevAddressHolder_pm_GetAddress;
        {-}
      function  pm_GetHint: Tl3PCharLen;
      procedure pm_SetHint(const aValue: Tl3PCharLen);
        {-}
      function  pm_GetAddressList: IevAddressList;
        {* - Метод для чтения свойства AddressList. }
      function  pm_GetURL: Tl3PCharLen;
      procedure pm_SetURL(const Value: Tl3PCharLen);
        {-}
      function  pm_GetPara: InevPara;
        {-}
      function  pm_GetKind: TevLinkViewKind;
      procedure pm_SetKind(aValue: TevLinkViewKind);
        {-}
      // IevAddressList
      function pm_GetCount: Long;
        {* - Метод для чтения свойства Count. }
      function  pm_GetItem(anIndex: Long): TevAddress;
        {* - Метод для чтения свойства Items. }
      procedure pm_SetItem(anIndex: Long; const Value: TevAddress);
        {* - Метод для записи свойства Items. }
      function Get_FromDocumentExternalHandle: Integer;
        {-}
      function Get_TargetDocumentID: Integer;
        {-}
      function  Get_Name: Tl3PCharLen;
        {-}
      function  IevAddressList.pm_GetName = IevAddressList_pm_GetName;
      function  IevAddressList_pm_GetName(anIndex: Long): Tl3PCharLen;
      procedure IevAddressList.pm_SetName = IevAddressList_pm_SetName;
      procedure IevAddressList_pm_SetName(anIndex: Long; const Value: Tl3PCharLen);
        {-}
      // IevURLMoniker
      function  IevURLMoniker_pm_GetURL: AnsiString;
        {-}
      function  IevURLMoniker.pm_GetURL = IevURLMoniker_pm_GetURL;
        {-}
      function GetHyperlink: Tl3Variant;
       {-}
    protected
    // internal methods
      procedure ResetInfo;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(const aLoc       : InevLocation;
                         aPara      : Tl3Variant);
        reintroduce;
        {-}
      class function Make(const aLoc       : InevLocation;
                          aHyperlink : Tl3Variant;
                          aPara      : Tl3Variant): IevHyperlink;
        reintroduce;
        overload;
        {-}
      class function Make(aPara      : Tl3Variant;
                          aHyperlink : Tl3Variant): IevHyperlink;
        reintroduce;
        overload;
        {-}
      procedure Init(aSeg: Tl3Variant);
        {-}
      function  Exists: Bool;
        {* - Проверяет существование данной ссылки в документе. }
      function  MakeID: Integer;
        {-}
      procedure Insert;
        {* - Вставляет новую ссылку. }
      procedure Delete;
        {* - удаляет гипертекстовую ссылку. }
      function COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
        override;
        {-}
      // IevAddressList 
      function Add(const anAddress: TevAddress): Long;
        {* - Добавляет еще один адрес. }
      procedure Clear;
        reintroduce;
        {* - Счищает список адресов. }
      procedure AddressList_Delete(const anAddress: TevAddress);
        {* - Удаляет адрес }
      procedure IevAddressList.Delete = AddressList_Delete;
        {-}
      procedure Modify(const anOldAddress, aNewAddress: TevAddress);
        {* - Модифицирует адрес. }
    public
    // public properties
      property ID: Long
        read f_ID;
        {-}
      property Hyperlink: Tl3Tag
        read f_Hyperlink;
        {-}
      property Hint: Tl3PCharLen
        read pm_GetHint
        write pm_SetHint;
        {* - Подсказка к ссылке. }
      property Para: InevPara
        read f_Para;
        {* - Параграф, на котором стоит ссылка. }    
      property Kind: TevLinkViewKind
        read pm_GetKind
        write pm_SetKind;
        {* - NbgДокумент из которого ведет ссылка. }
  end;//TevHyperlink

implementation

uses
  Messages,
  
  SysUtils,
  
  l3Chars,
  l3InternalInterfaces,
  l3String,
  l3Tree_TLB,

  k2Const,
  k2Base,
  k2Tags,

  evMsgCode, {-for ev_msgAddHyperlink}

  evTextParaTools,
  evdStyles,  {-for ev_saHyperLink}
  evSegLst,

  evParaTools,
  evSubImplementation,

  Hyperlink_Const,
  Document_Const
  ;

// start class TevHyperlink

constructor TevHyperlink.Create(const aLoc  : InevLocation;
                                aPara : Tl3Variant);
  //reintroduce;
  {-}
var
 l_Para : InevPara;
 l_Proc : InevProcessor;
begin
 if not aPara.QT(InevPara, l_Para) then
  Assert(false);
 if (l_Para.DocumentContainer <> nil) then
  l_Proc := l_Para.DocumentContainer.Processor
 else
  l_Proc := nil;
 inherited Create(nil, l_Proc);
 f_Loc := aLoc;
 f_Para := l_Para;
end;

class function TevHyperlink.Make(const aLoc       : InevLocation;
                                 aHyperlink : Tl3Variant;
                                 aPara      : Tl3Variant): IevHyperlink;
  {-}
var
 l_Link  : TevHyperlink;
begin
 Assert(aPara <> nil);
 l_Link := Create(aLoc, aPara);
 try
  if (aHyperlink <> nil) then
   l_Link.Init(aHyperlink);
  Result := l_Link;
 finally
  l3Free(l_Link);
 end;//try..finally
end;

class function TevHyperlink.Make(aPara      : Tl3Variant;
                                 aHyperlink : Tl3Variant): IevHyperlink;
  //overload;
  {-}
begin
 Result := Make(nil, aHyperlink, aPara);
end;

procedure TevHyperlink.Cleanup;
  {override;}
  {-}
begin
 f_Loc := nil;
 f_Para := nil;
 l3Free(f_URL);
 f_ID := 0;
 FreeAndNil(f_Hyperlink);
 inherited;
end;

procedure TevHyperlink.ResetInfo;
  {-}
begin
 Hint := l3PCharLen('');
 Kind := ev_lvkUnknown;
end;
  
procedure TevHyperlink.Init(aSeg: Tl3Variant);
  {-}
begin
 aSeg.SetRef(f_Hyperlink);
 with aSeg do
  if IsValid then
   f_ID := IntA[k2_tiHandle]
  else
  begin
   f_ID := 0;
   FreeAndNil(f_Hyperlink);
  end;//aSeg.IsValid
end;
  
function TevHyperlink.pm_GetID: Long;
  {-}
begin
 Result := Get_ID;
end;

function TevHyperlink.IevURLMoniker_pm_GetURL: AnsiString;
  {-}
begin
 Result := l3PCharLen2String(pm_GetURL, CP_ANSI);
end;

function TevHyperlink.Get_ID: Integer;
  {-}
{$IfDef evMakeHyperlinkID}
var
 l_Handle : Integer;
 l_LinkKind: TevLinkViewKind;
{$EndIf evMakeHyperlinkID}
begin
 Result := f_ID;
 {$IfDef evMakeHyperlinkID}
 if (Result = 0) AND Exists then
 begin
  with f_Hyperlink.Attr[k2_tiHandle] do
   if IsValid then
   begin
    f_ID := AsLong;
    l_Handle := 0;
   end
   else
    l_Handle := MakeID;
  if (l_Handle > 0) then
  begin
   // Сохраняем kind ссылки, потому что из Set_ID могут позвать ResetInfo,
   // и kind будет потерян
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=594881807
   l_LinkKind := pm_GetKind;
   Set_ID(l_Handle);
   pm_SetKind(l_LinkKind);
  end;
  Result := f_ID;
 end;//Result = 0
 {$EndIf evMakeHyperlinkID}
end;

procedure TevHyperlink.Set_ID(Value: Integer);
  {-}
var
 l_OpPack    : InevOp;        // - пачка операций 
 ANHTS       : Tl3Variant;
 ATextPara   : InevTextPara;
 l_B         : TevPair;
 Position    : Integer;                          
 Seg         : Tl3Variant;
 ASegs       : Tl3Variant;
 Si          : Long;
 l_String    : Il3WordsSeq;    
 LayerHandle : TevSegmentHandle;
begin
 if (Value > 0) then 
 begin
  l_OpPack := Processor.StartOp(ev_msgAddHyperlink);
  {* - Открываем пачку операций}
  try
   if Exists then
   begin
    f_Hyperlink.IntW[k2_tiHandle, l_OpPack] := Value;
    l_OpPack.MarkModified(Para.AsObject);
    ResetInfo;
   end//Exists
   else
   begin
    {* - Надо подумать о том что делать, если ссылка уже есть. }
    if not f_Loc.Obj.AsObject.QT(InevTextPara, ATextPara) then
     Assert(false);
    try
     if (f_Loc.AsPoint <> nil) then
     begin
      {* - Ветка логики для курсора. }
      Position := f_Loc.AsPoint.Position;
      with ATextPara do
      begin
       ASegs := Attr[k2_tiSegments];
       if ASegs.IsValid then 
       begin
        LayerHandle := ev_slHyperlinks;
        Seg := evSegments_GetSegmentOnPos(ASegs, LayerHandle, Position, Si);
        if not Seg.IsValid then 
        begin
         LayerHandle := ev_slView;
         Seg := evSegments_GetSegmentOnPos(ASegs, LayerHandle, Position, Si);
         if Seg.IsValid AND (Seg.IntA[k2_tiStyle] <> ev_saHyperlink) then
          Seg := k2NullTag;
        end;{Seg = nil}
        if Seg.IsValid then 
        begin
         if Seg.IsKindOf(k2_typHyperlink) then
          Seg.IntW[k2_tiHandle, l_OpPack] := Value
         else 
         begin
          ANHTS := k2_typHyperlink.MakeTag.AsObject;
          try
           ANHTS.AssignTag(Seg);
           evSegments_DeleteSegment(ATextPara, LayerHandle, Si, l_OpPack);
           ANHTS.IntA[k2_tiHandle] := Value;
           evTextParaAddSegment(ATextPara, ev_slHyperlinks, ANHTS, l_OpPack);
           ANHTS.SetRef(f_Hyperlink);
           //ATextPara.Shape.Unformat; // <stub>
          finally
           ANHTS := nil;
          end;{try..finally}
         end;{..k2_idHyperlink..}
         Exit; // - ссылка поставлена
        end;{Seg.IsValid}
       end;//ASegs.IsValid
       if QT(Il3WordsSeq, l_String) then
        try
         l_B.rStart := l_String.WordStart(Position);
         l_B.rFinish := l_String.WordFinish(Position);
         if (l_B.Len > 0) then
         begin
          ANHTS := k2_typHyperlink.MakeTag.AsObject;
          try
           with ANHTS do 
           begin
            IntA[k2_tiStart] := Succ(l_B.rStart);
            IntA[k2_tiFinish] := l_B.rFinish;
            IntA[k2_tiStyle] := ev_saHyperLink;
            IntA[k2_tiHandle] := Value;
           end;{with ANHTS}
           evTextParaAddSegment(ATextPara, ev_slHyperLinks, ANHTS, l_OpPack);
           ANHTS.SetRef(f_Hyperlink);
           //ATextPara.Shape.Unformat; // <stub>
          finally
           ANHTS := nil;
          end;{try..finally}
         end;
        finally
         l_String := nil; {* - Строка больше не нужна. }
        end;{try..finally}
      end;{with ATextPara}
      //..Il3EntryPoint..
     end
     else
     if (f_Loc.Range <> nil) then
     begin
      {-ветка логики для выделения}
      l_B := f_Loc.Range.Borders;
      if (l_B.Len > 0) then
      begin
       ANHTS := k2_typHyperlink.MakeTag.AsObject;
       try
        with ANHTS do 
        begin
         IntA[k2_tiStart] := Succ(l_B.rStart);
         IntA[k2_tiFinish] := l_B.rFinish;
         IntA[k2_tiHandle] := Value;
         IntA[k2_tiStyle] := ev_saHyperLink;
        end;{with ANHTS}
        evTextParaAddSegment(ATextPara, ev_slHyperlinks, ANHTS, l_OpPack);
        ANHTS.SetRef(f_Hyperlink);
        //ATextPara.Shape.Unformat; // <stub>
       finally
        ANHTS := nil;
       end;{try..finally}
      end;//BS < BF
     end;//..Il3Range..
    finally
     if (f_Hyperlink <> nil) AND not f_URL.Empty then
      f_Hyperlink.PCharLenW[k2_tiURL, l_OpPack] := f_URL.AsPCharLen;
    end;//try..finally
   end;//Exists
   if (f_Hyperlink <> nil) then
    f_ID := f_Hyperlink.IntA[k2_tiHandle];
  finally
   l_OpPack := nil; {* - Закрываем пачку операций. }
  end;//try..finally
 end;//Value > 0  
end;

function TevHyperlink.Exists: Bool;
  {-}
begin
 Result := (f_ID >= 0) AND (Hyperlink <> nil);
 if Result and (f_Loc <> nil) then
  Result := not EvHeaderTextPara(f_Loc.Obj^);
end;

function TevHyperlink.MakeID: Integer;
  {-}
var
 l_Document : Tl3Variant;
begin
 if evInPara(f_Loc.Obj^.AsObject, k2_typDocument, l_Document) then
 begin
  Result := l_Document.IntA[k2_tiMaxHyperlinkHandle];
  Inc(Result);
  l_Document.IntA[k2_tiMaxHyperlinkHandle] := Result;
 end//evSomeParentInherits 
 else
  Result := 0; 
end;

procedure TevHyperlink.Insert;
  {* - Вставляет новую ссылку. }
var
 l_Handle : Long;
 l_OpPack : InevOp;
begin
 if not Exists then
 begin
  l_OpPack := Processor.StartOp(ev_msgAddHyperlink);
  try
   if (l_OpPack <> nil) then
    l_OpPack.CheckReadonly;
   l_Handle := MakeID;
   if (l_Handle > 0) then
    Set_ID(l_Handle);
  finally
   l_OpPack := nil;
  end;//try..finally
 end;//evSomeParentInherits(
end;

procedure TevHyperlink.Delete;
  {* - Удаляет гипертекстовую ссылку. }
var
 l_OpPack : InevOp;
begin
 if Exists then
 begin
  l_OpPack := Processor.StartOp(ev_msgDeleteHyperlink);
  try
   f_Loc.Formatting.Modify(nil).DeleteHyperlink(l_OpPack);
   l_OpPack.MarkModified(f_Loc.AsObject);
  finally
   l_OpPack := nil;
  end;//try..finally
  FreeAndNil(f_Hyperlink);
  f_ID := 0;
 end;//Exists
end;
  
function TevHyperlink.COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
  //override;
  {-}
begin
 if IID.SomeOf([IevSub, IevDocumentPart]) then
  Result.SetNoInterface
 else
 if IID.SomeOf([Il3RootNode, Il3Node]) then
  Result := Tl3HResult_C(Processor.QueryInterface(IID.IID, Obj))
 else
  Result := inherited COMQueryInterface(IID, Obj);
end;

function TevHyperlink.Add(const anAddress: TevAddress): Long;
  {* - Добавляет еще один адрес }

 function AddressExists : Boolean;
 var
  l_Index : Integer;
 begin//AddressExists
  Result := False;
  with IevAddressList(Self) do
   for l_Index := 0 to Pred(Count) do
    if anAddress.EQ(Item[l_Index]{$IfDef XE4}.rTafwAddress{$EndIf}) then
    begin
     Result := True;
     Break;
    end;//anAddress.EQ(Items[l_Index])
 end;//AddressExists

var
 l_OpPack     : InevOp;
 l_NewAddress : Tl3Variant;
begin
 Result := -1;
 if Exists and not AddressExists then
 begin
  l_OpPack := Processor.StartOp;
  try
   l_OpPack.CheckReadonly;
   with Hyperlink do
   begin
    l_NewAddress := Tk2Type(TagType).ArrayProp[k2_tiChildren].ChildType.MakeTag.AsObject;
    try
     with l_NewAddress do
     begin
      IntA[k2_tiDocID] := anAddress.{$IfDef XE4}rTafwAddress.{$EndIf}DocID;
      IntA[k2_tiSubID] := anAddress.{$IfDef XE4}rTafwAddress.{$EndIf}SubID;
      IntA[k2_tiType] := anAddress.{$IfDef XE4}rTafwAddress.{$EndIf}TypeID;
     end;//with l_NewAddress
     Result := AddChild(l_NewAddress, l_OpPack);
    finally
     l_NewAddress := nil;
    end;//try..finally
   end;//with Hyperlink...
   l_OpPack.MarkModified(Para.AsObject);
   ResetInfo;
  finally
   l_OpPack := nil;
  end;//try..finally
 end;//Exists
end;

procedure TevHyperlink.Modify(const anOldAddress, aNewAddress: TevAddress);
  {* - модифицирует адрес. }

 function CheckModify(theAddress: Tl3Variant; anIndex: Long): Bool;
 var
  l_OpPack  : InevOp;
  l_Address : TevAddress;
 begin//CheckModify
  with theAddress do begin
   l_Address.{$IfDef XE4}rTafwAddress.{$EndIf}DocID := IntA[k2_tiDocID];
   l_Address.{$IfDef XE4}rTafwAddress.{$EndIf}SubID := IntA[k2_tiSubID];
   if l_Address.EQ(anOldAddress{$IfDef XE4}.rTafwAddress{$EndIf}) then
   begin
    Result := false;
    l_OpPack := Processor.StartOp;
    try
     IntW[k2_tiDocID, l_OpPack] := aNewAddress.{$IfDef XE4}rTafwAddress.{$EndIf}DocID;
     IntW[k2_tiSubID, l_OpPack] := aNewAddress.{$IfDef XE4}rTafwAddress.{$EndIf}SubID;
     l_OpPack.MarkModified(Para.AsObject);
     ResetInfo;
    finally
     l_OpPack := nil;
    end;//try..finally
   end else
    Result := true;
  end;//with theAddress
 end;//CheckModify

begin
 if Exists then
  Hyperlink.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@CheckModify));
end;

procedure TevHyperlink.Clear;
  {* - очищает список адресов }
var
 l_OpPack : InevOp;
begin
 if Exists then
 begin
  l_OpPack := Processor.StartOp;
  try
   Hyperlink.AttrW[k2_tiChildren, nil] := nil;
   l_OpPack.MarkModified(Para.AsObject);
   ResetInfo;
  finally
   l_OpPack := nil;
  end;//try..finally
 end;//Exists
end;

procedure TevHyperlink.AddressList_Delete(const anAddress: TevAddress);
  {* - удаляет адрес }

 function CheckDelete(theAddress: Tl3Variant; anIndex: Long): Bool;
 var
  l_OpPack  : InevOp;
  l_Address : TevAddress;
 begin//CheckDelete
  with theAddress do begin
   with Attr[k2_tiDocID] do
    if IsValid then
     l_Address.{$IfDef XE4}rTafwAddress.{$EndIf}DocID := AsLong
    else
     l_Address.{$IfDef XE4}rTafwAddress.{$EndIf}DocID := 0;
   with Attr[k2_tiSubID] do
    if IsValid then
     l_Address.{$IfDef XE4}rTafwAddress.{$EndIf}SubID := AsLong
    else
     l_Address.{$IfDef XE4}rTafwAddress.{$EndIf}SubID := 0;
   with Attr[k2_tiType] do
    if IsValid then
     l_Address.{$IfDef XE4}rTafwAddress.{$EndIf}TypeID := AsLong
    else
     l_Address.{$IfDef XE4}rTafwAddress.{$EndIf}TypeID := ev_defAddressType;
   if l_Address.EQ(anAddress{$IfDef XE4}.rTafwAddress{$EndIf}) then
   begin
    Result := false;
    l_OpPack := Processor.StartOp;
    try
     Hyperlink.DeleteChild(anIndex, l_OpPack);
     l_OpPack.MarkModified(Para.AsObject);
     ResetInfo;
    finally
     l_OpPack := nil;
    end;//try..finally
   end else
    Result := true;
  end;//with theAddress
 end;//CheckDelete

begin
 if Exists then
  Hyperlink.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@CheckDelete));
end;

function TevHyperlink.IevAddressHolder_pm_GetAddress: Tl3Variant;
  {-}
begin
 if Exists then
  Result := Hyperlink.rAtomEx([k2_tiChildren, k2_tiByIndex, 0])
 else
  Result := nil;
end;

function TevHyperlink.pm_GetHint: Tl3PCharLen;
  {-}
var
 l_Address : Tl3Variant;
begin
 l3AssignNil(Result);                                        
 l_Address := IevAddressHolder_pm_GetAddress;
 if (l_Address <> nil) then
    with l_Address.Attr[k2_tiShortName] do
     if IsValid then
      Tl3WString(Result) := AsWStr;
end;

procedure TevHyperlink.pm_SetHint(const aValue: Tl3PCharLen);
var
 l_Address : Tl3Variant;
begin
 l_Address := IevAddressHolder_pm_GetAddress;
 if (l_Address <> nil) AND l_Address.IsValid then
  l_Address.PCharLenA[k2_tiShortName] := aValue;
end;

function TevHyperlink.pm_GetAddress: TevAddress;
  {-}
const
  evNullAddress : {$IfDef XE4}TafwAddress{$Else}TevAddress{$EndIf} = (DocID : -1; SubID : -1);
   {* - "пустой" адрес. }
begin
 Result{$IfDef XE4}.rTafwAddress{$EndIf} := evNullAddress;
 if Exists then begin
  with Hyperlink.rAtomEx([k2_tiChildren, k2_tiByIndex, 0]) do
   if IsValid then begin
    with Attr[k2_tiDocID] do
     if IsValid then
      Result.{$IfDef XE4}rTafwAddress.{$EndIf}DocID := AsLong
     else
      Result.{$IfDef XE4}rTafwAddress.{$EndIf}DocID := 0;
    with Attr[k2_tiSubID] do
     if IsValid then
      Result.{$IfDef XE4}rTafwAddress.{$EndIf}SubID := AsLong
     else
      Result.{$IfDef XE4}rTafwAddress.{$EndIf}SubID := 0;
    with Attr[k2_tiType] do
     if IsValid then
      Result.{$IfDef XE4}rTafwAddress.{$EndIf}TypeID := AsLong
     else
      Result.{$IfDef XE4}rTafwAddress.{$EndIf}TypeID := ev_defAddressType;
    with Attr[k2_tiRevision] do
     if IsValid then
      Result.{$IfDef XE4}rTafwAddress.{$EndIf}RevisionID := AsLong
     else
      Result.{$IfDef XE4}rTafwAddress.{$EndIf}RevisionID := 0;
   end;//IsValid
 end;//Exists
end;

procedure TevHyperlink.pm_SetAddress(const Value: TevAddress);
  {-}
var
 l_OpPack : InevOp;  
begin
 if Exists then
 begin
  l_OpPack := Processor.StartOp;
  try
   with Hyperlink.cAtomEx([k2_tiChildren, k2_tiByIndex, 0], l_OpPack) do
   begin
    IntW[k2_tiDocID, l_OpPack] := Value.{$IfDef XE4}rTafwAddress.{$EndIf}DocID;
    IntW[k2_tiSubID, l_OpPack] := Value.{$IfDef XE4}rTafwAddress.{$EndIf}SubID;
    IntW[k2_tiType, l_OpPack] := Value.{$IfDef XE4}rTafwAddress.{$EndIf}TypeID;
    IntW[k2_tiRevision, l_OpPack] := Value.{$IfDef XE4}rTafwAddress.{$EndIf}RevisionID;
   end;//with Hyperlink...
   l_OpPack.MarkModified(Para.AsObject);
   ResetInfo;
  finally
   l_OpPack := nil;
  end;//try..finally
 end;//Exists
end;

function TevHyperlink.pm_GetAddressList: IevAddressList;
  {* - метод для чтения свойства AddressList. }
begin
 Result := Self;
end;

function TevHyperlink.pm_GetURL: Tl3PCharLen;
  {-}
begin
 if Exists then begin
  with Hyperlink.Attr[k2_tiURL] do
   if IsValid then
    Tl3WString(Result) := AsWStr
   else
    l3AssignNil(Result);
 end else begin
  if (f_URL = nil) then
   l3AssignNil(Result)
  else
   Result := f_URL.AsPCharLen;
 end;//Exists
end;

procedure TevHyperlink.pm_SetURL(const Value: Tl3PCharLen);
  {-}
var
 l_OpPack : InevOp;
begin
 if Exists then
 begin
  l_OpPack := Processor.StartOp;
  try
   Hyperlink.PCharLenW[k2_tiURL, l_OpPack] := Value;
   l_OpPack.MarkModified(Para.AsObject);
   ResetInfo;
  finally
   l_OpPack := nil;
  end;//try..finally
 end//Exists
 else
 begin
  if (f_URL = nil) then
   f_URL := Tl3String.Make(Value)
  else
   f_URL.AsPCharLen := Value; 
 end;//Exists
end;

function TevHyperlink.pm_GetCount: Long;
  {* - Метод для чтения свойства Count }
begin
 if Exists then
  Result := Hyperlink.ChildrenCount
 else
  Result := 0;
end;

function TevHyperlink.pm_GetItem(anIndex: Long): TevAddress;
  {* - Метод для чтения свойства Items }
begin
 if Exists then 
 begin
  with Hyperlink.Child[anIndex] do 
  begin
   with Attr[k2_tiDocID] do
    if IsValid then
     Result.{$IfDef XE4}rTafwAddress.{$EndIf}DocID := AsLong
    else
     Result.{$IfDef XE4}rTafwAddress.{$EndIf}DocID := 0;
   with Attr[k2_tiSubID] do
    if IsValid then
     Result.{$IfDef XE4}rTafwAddress.{$EndIf}SubID := AsLong
    else
     Result.{$IfDef XE4}rTafwAddress.{$EndIf}SubID := 0;
   with Attr[k2_tiType] do
    if IsValid then
     Result.{$IfDef XE4}rTafwAddress.{$EndIf}TypeID := AsLong
    else
     Result.{$IfDef XE4}rTafwAddress.{$EndIf}TypeID := ev_defAddressType;
  end;//with Hyperlink.Child[anIndex]
 end else
  k2ListError(anIndex);
end;

procedure TevHyperlink.pm_SetItem(anIndex: Long; const Value: TevAddress);
  {* - метод для записи свойства Items }
var
 l_OpPack : InevOp;
begin
 if Exists then
 begin
  with Hyperlink.Child[anIndex] do
  begin
   l_OpPack := Processor.StartOp;
   try
    IntW[k2_tiDocID, l_OpPack] := Value.{$IfDef XE4}rTafwAddress.{$EndIf}DocID;
    IntW[k2_tiSubID, l_OpPack] := Value.{$IfDef XE4}rTafwAddress.{$EndIf}SubID;
    IntW[k2_tiType, l_OpPack] := Value.{$IfDef XE4}rTafwAddress.{$EndIf}TypeID;
    l_OpPack.MarkModified(Para.AsObject);
    ResetInfo;
   finally
    l_OpPack := nil;
   end;//try..finally
  end;//with Hyperlink.Child[anIndex]
 end//Exists
 else
  k2ListError(anIndex);
end;

function TevHyperlink.pm_GetPara: InevPara;
  {-}
begin
 Result := f_Para;
end;

function TevHyperlink.IevAddressList_pm_GetName(anIndex: Long): Tl3PCharLen;
  {-}
begin
 if Exists then
  Result := Hyperlink.Child[anIndex].PCharLenA[k2_tiName]
 else
  k2ListError(anIndex);
end;

procedure TevHyperlink.IevAddressList_pm_SetName(anIndex: Long; const Value: Tl3PCharLen);
  {-}
var
 l_OpPack : InevOp;
begin
 if Exists then
 begin
  l_OpPack := Processor.StartOp;
  try
   Hyperlink.Child[anIndex].PCharLenW[k2_tiName, l_OpPack] := Value;
  finally
   l_OpPack := nil;
  end;//try..finally
 end//Exists
 else
  k2ListError(anIndex);
end;

function TevHyperlink.pm_GetKind: TevLinkViewKind;
var
 l_Address : Tl3Variant;
begin
 l_Address := IevAddressHolder_pm_GetAddress;
 if (l_Address <> nil) then
  Result := TevLinkViewKind(l_Address.IntA[k2_tiViewKind])
 else
  Result := ev_lvkUnknown;
end;

procedure TevHyperlink.pm_SetKind(aValue: TevLinkViewKind);
var
 l_Address : Tl3Variant;
begin
 l_Address := IevAddressHolder_pm_GetAddress;
 if (l_Address <> nil) AND l_Address.IsValid then
  l_Address.IntA[k2_tiViewKind] := Ord(aValue);
end;

function TevHyperlink.Get_FromDocumentExternalHandle: Integer;
var
 l_Doc : Tl3Variant;
begin
 Result := -1;
 if (Para <> nil) then
 begin
  if evInPara(Para.AsObject, k2_typDocument, l_Doc) then
   Result := l_Doc.rLong(k2_tiExternalHandle, -1);
 end;//Para <> nil
end;

function TevHyperlink.Get_TargetDocumentID: Integer;
const
 c_UndefenedParaID = -1;
begin
 Result := pm_GetAddress.{$IfDef XE4}rTafwAddress.{$EndIf}DocID;
 if (Result = 0) AND
    (f_Para <> nil) AND
    ((pm_GetAddress.{$IfDef XE4}rTafwAddress.{$EndIf}TypeID = CI_MULT) or
     (pm_GetAddress.{$IfDef XE4}rTafwAddress.{$EndIf}TypeID = CI_PHARM_MULTI)) then
  with f_Para.AsObject.Attr[k2_tiHandle] do
  if IsValid then
   Result := AsLong
  else
   Result := c_UndefenedParaID;
end;

function TevHyperlink.Get_Name: Tl3PCharLen;
var
 l_Address       : Tl3Variant;
begin
 l3AssignNil(Result);
 l_Address := IevAddressHolder_pm_GetAddress;
 if (l_Address <> nil) then
    with l_Address.Attr[k2_tiName] do
     if IsValid then
      Tl3WString(Result) := AsWStr;
end;

function TevHyperlink.GetHyperlink: Tl3Variant;
begin
 Result := f_Hyperlink;
end;

end.

