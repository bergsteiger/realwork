Unit Dt_EFltr;

{ $Id: Dt_EFLTR.PAS,v 1.224 2016/08/25 10:14:38 lukyanets Exp $ }

// $Log: Dt_EFLTR.PAS,v $
// Revision 1.224  2016/08/25 10:14:38  lukyanets
// Готовимся запрашивать сервер о получении текста документа.
//
// Revision 1.223  2016/08/11 11:37:47  lukyanets
// Вычищаем поддержку 133 версии
//
// Revision 1.222  2016/07/18 11:58:22  voba
// no message
//
// Revision 1.221  2016/06/16 05:40:06  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.220  2016/03/16 11:00:33  voba
// -k:619568279
//
// Revision 1.219  2015/12/07 15:20:14  voba
// - дотачиваем обработку битых ссылок
//
// Revision 1.218  2015/11/23 11:37:15  lukyanets
// Заготовки Renum
//
// Revision 1.217  2015/10/02 10:31:33  voba
// - bf - большие UserID храним как отрицательные
//
// Revision 1.216  2015/10/02 09:25:18  lukyanets
// Конфликт типов ID пользователя - знаковый vs беззнаковый
//
// Revision 1.215  2015/10/02 08:20:44  dinishev
// Bug fix: не отрывались документы.
//
// Revision 1.214  2015/09/03 05:50:41  lukyanets
// Заготовки синхронизации словарей
//
// Revision 1.213  2015/07/02 11:41:29  lukyanets
// Описываем словари
//
// Revision 1.212  2015/07/02 07:36:07  lukyanets
// Описываем словари
//
// Revision 1.211  2015/03/19 08:48:09  voba
// - bf
//
// Revision 1.210  2015/03/13 11:55:46  voba
// - локальное автосохранение документов
//
// Revision 1.209  2015/01/30 13:30:45  kostitsin
// рисуем l3Nodes
//
// Revision 1.208  2014/07/01 10:42:22  voba
//  k:236721575 (Атрибуты в EVD) Убрал лишнюю загрузку атрибутов
//
// Revision 1.207  2014/06/24 13:20:15  voba
//  k:взводился HasAnno почем зря
//
// Revision 1.206  2014/06/18 16:55:20  voba
// - bugfix Конфликт Анно-Док
//
// Revision 1.205  2014/05/21 14:33:11  voba
// - cc
//
// Revision 1.204  2014/05/08 11:48:17  fireton
// - избавляемся от диапазонов в экспорте
//
// Revision 1.203  2014/04/17 13:04:31  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.202  2014/04/15 08:38:45  voba
// - add настройка MessageLevel
//
// Revision 1.201  2014/04/04 06:58:50  dinishev
// Bug fix: не собирался Арчи.
//
// Revision 1.200  2014/03/28 06:13:29  dinishev
// Bug fix: не собиралось почити ничего.
//
// Revision 1.199  2014/03/20 14:18:42  voba
//  k:236721575 (Атрибуты в EVD)
//
// Revision 1.198  2014/03/03 16:07:48  lulin
// - избавляемся от странностей.
//
// Revision 1.197  2013/11/18 10:46:14  voba
// - переход на 134 версию БД
//
// Revision 1.196  2013/10/30 10:36:40  voba
// - отказ от fSrchList
//
// Revision 1.195  2013/10/21 17:31:08  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.194  2013/10/21 15:43:09  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.193  2013/10/21 10:30:56  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.192  2013/10/18 15:38:58  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.191  2013/07/11 12:44:26  voba
// - K:463114355
//
// Revision 1.190  2013/04/19 13:07:39  lulin
// - портируем.
//
// Revision 1.189  2013/04/17 10:38:13  voba
// - K:450277041
//
// Revision 1.188  2013/02/07 13:20:45  narry
// Фильтрация атрибутов в потоке
//
// Revision 1.187  2013/01/17 10:11:56  voba
// - перенес интерфейсы в отдельный модуль
//
// Revision 1.186  2012/07/16 11:16:50  voba
// no message
//
// Revision 1.185  2012/05/21 13:34:42  narry
// Избавляемся от двойного преобразования атрибутов для справок
//
// Revision 1.184  2012/04/20 15:20:01  lulin
// {RequestLink:283610570}
//
// Revision 1.183  2012/04/06 10:11:39  narry
// Не заполнялась информация "Хронология дела"
//
// Revision 1.182  2012/03/27 09:04:24  voba
// - k : 344753123
//
// Revision 1.181  2012/03/06 13:00:34  fireton
// - Слияние с веткой B_archi_base132
//
// Revision 1.180.2.2  2012/02/17 06:25:32  fireton
// - импорт/экспорт Flags у источников опубликования
//
// Revision 1.180.2.1  2012/02/13 06:24:07  fireton
// - Добавляем Flags к источникам опубликования документа
//
// Revision 1.180  2011/10/05 10:59:43  voba
// - k : 281525254 Борьба с утечками
//
// Revision 1.179  2011/09/08 08:13:56  voba
// - k : 236721575
//
// Revision 1.178  2011/08/11 11:09:34  voba
// - k : 236721575
//
// Revision 1.177  2011/08/08 09:50:49  voba
// - k : 236721575
//
// Revision 1.176  2011/07/28 08:40:28  voba
// - k : 236721575
//
// Revision 1.174  2011/04/18 13:44:44  voba
// - k : 236721575
//
// Revision 1.173  2011/03/23 12:01:50  narry
// K254352041. Цеплять исходный rtf или doc к судебной практике в виде образа
//
// Revision 1.172  2011/03/15 14:35:40  fireton
// - отключаем получение гиперлинков, когда они не нужны
//
// Revision 1.171  2010/11/25 12:04:31  voba
// - K : 236721575
//
// Revision 1.170  2010/11/19 13:45:42  voba
// - K : 236721575
//
// Revision 1.169  2010/11/16 06:48:04  voba
// - K : 236721575
//
// Revision 1.168  2010/11/12 08:48:33  voba
// - K : 236721575
//
// Revision 1.167  2010/09/24 12:11:14  voba
// - k : 235046326
//
// Revision 1.166  2010/01/11 11:30:05  voba
// - вставил сортировку datenum
//
// Revision 1.165  2009/11/30 15:28:02  fireton
// - правка ошибок
//
// Revision 1.164  2009/07/22 11:27:26  narry
// - изменение доступа к DictServer
//
// Revision 1.163  2009/07/21 14:36:08  lulin
// - убираем поддержку IUnknown со строк.
//
// Revision 1.162  2009/07/20 12:38:48  voba
// - Засунул renum в атрибуты
//
// Revision 1.161  2009/06/23 07:32:59  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.160  2009/06/08 13:23:24  voba
// - enh. унификация атрибутов. Избавился от псевдоатрибутов atDateNumsChDate, atRelHLink,
//
// Revision 1.159  2009/05/07 06:29:37  voba
// - cc
//
// Revision 1.158  2009/04/22 15:02:34  voba
// - enh. Включил конвертацию DDocID=0 на CurDocID, Сейчас это не используется потому что такая же стоит в DT_IFltr
//
// Revision 1.157  2009/04/13 07:10:58  narry
// - разделение определения типов и реализации
//
// Revision 1.156  2009/03/31 09:02:58  fireton
// - импорт/экспорт атрибута "Комментарий к документу" [$121164344]
//
// Revision 1.155  2009/03/04 16:26:03  lulin
// - <K>: 137470629. Bug fix: не собирался Архивариус.
//
// Revision 1.154  2009/02/20 13:27:58  fireton
// - команда !CHANGE (K 77235676)
// - 131 версия базы
//
// Revision 1.153  2009/01/14 14:06:53  narry
// - татары
//
// Revision 1.152  2008/12/08 10:26:52  narry
// - документы без текста или PRICELEVEL выливались без атрибутов
//
// Revision 1.151  2008/10/14 10:26:39  narry
// - расхождение в длинах полей
//
// Revision 1.150  2008/09/29 14:36:26  narry
// - заплатка от неинициализированного поля
//
// Revision 1.149  2008/09/23 12:17:54  fireton
// - импорт/экспорт номера судебного дела
//
// Revision 1.148  2008/09/17 14:47:47  fireton
// - новая версия базы (130)
// - срочность документа
//
// Revision 1.147  2008/07/22 07:14:40  narry
// - исправление ошибки (voba)
//
// Revision 1.146  2008/06/10 10:55:25  fireton
// - поддержка Flash-документов
//
// Revision 1.145  2008/05/14 11:53:46  narry
// - уменьшение объема выоводимой в лог инфы для регионов
//
// Revision 1.144  2008/05/08 14:04:12  fireton
// - перенос объектов в потоках из ветки
//
// Revision 1.143  2008/05/07 16:03:23  voba
// - Refact. function .GetRelImportNum и GetINumber убил, вместо нех использовать GetExtDocID
//
// Revision 1.142  2008/05/05 10:41:16  voba
// - избавлялся от старой автоклассификации
//
// Revision 1.141  2008/04/25 11:59:15  voba
// -bug fix
//
// Revision 1.140  2008/03/21 17:31:22  narry
// - ловушка для похитителей атрибутов
//
// Revision 1.139  2008/03/20 10:59:45  lulin
// - cleanup.
//
// Revision 1.138  2008/02/12 13:08:55  voba
// - заточки для быстрой выливки справок без документов
//
// Revision 1.137  2008/02/05 09:58:05  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.136  2008/02/04 08:51:35  lulin
// - класс _Tl3InterfaceList выделен в отдельный модуль.
//
// Revision 1.135  2008/02/01 15:14:48  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.134  2008/01/03 13:29:34  narry
// - AV при отсутствии элемента
//
// Revision 1.133  2007/11/29 09:35:43  narry
// - терялись атрибуты при специальной комбинации выливок
//
// Revision 1.132  2007/11/26 09:40:45  voba
// - use cUndefDictID, cUndefDocID, cUndefSubID
//
// Revision 1.131  2007/11/22 07:34:22  voba
// - enh. фильтруем _k2_idBookmark
//
// Revision 1.130  2007/10/25 11:31:23  voba
// - bug fix
//
// Revision 1.129  2007/10/19 10:54:37  voba
// - bug fix фильтрация субатрибутов
//
// Revision 1.128  2007/10/15 14:21:03  voba
// - изменил логику перенабора словарей
//
// Revision 1.127  2007/10/12 12:32:53  voba
// - add property SingleDocMode, AddedDocID, AddedAttrs
//
// Revision 1.126  2007/10/11 06:16:33  voba
// - cc
//
// Revision 1.125  2007/10/10 13:13:21  voba
// - bug fix
//
// Revision 1.124  2007/10/09 08:53:53  voba
// - merge with b_archi_export_refact2
//
// Revision 1.123.6.7  2007/10/08 10:27:17  voba
// no message
//
// Revision 1.123.6.6  2007/10/08 10:18:43  voba
// - bug fix
//
// Revision 1.123.6.5  2007/09/26 12:15:45  voba
// no message
//
// Revision 1.123.6.4  2007/09/21 13:20:45  voba
// no message
//
// Revision 1.123.6.3  2007/09/20 06:56:53  voba
// no message
//
// Revision 1.123.6.2  2007/09/18 07:44:52  voba
// no message
//
// Revision 1.123.6.1  2007/09/14 15:45:57  voba
// no message
//
// Revision 1.123  2007/08/30 14:20:48  voba
// - update to 128 DB version
//
// Revision 1.122  2007/08/14 20:25:14  lulin
// - bug fix: не собиралася Архивариус.
//
// Revision 1.121  2007/08/14 19:31:56  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.120  2007/08/09 18:05:27  lulin
// - избавляемся от излишнего использования интерфейсов, т.к. переносимость может быть достигнута другими методами.
//
// Revision 1.119  2007/08/09 11:19:23  lulin
// - cleanup.
//
// Revision 1.118.4.12  2007/09/14 14:36:50  voba
// no message
//
// Revision 1.118.4.11  2007/09/04 13:27:28  voba
// - refact
//
// Revision 1.118.4.10  2007/08/30 11:36:36  voba
// no message
//
// Revision 1.118.4.9  2007/08/27 13:12:12  voba
// no message
//
// Revision 1.118.4.8  2007/08/20 13:16:57  voba
// no message
//
// Revision 1.118.4.7  2007/08/20 06:31:29  voba
// no message
//
// Revision 1.118.4.6  2007/08/10 12:07:50  voba
// - marge with head
//
// Revision 1.118.4.5  2007/08/06 12:54:46  voba
// no message
//
// Revision 1.118.4.4  2007/07/30 07:24:01  voba
// no message
//
// Revision 1.118.4.3  2007/07/26 12:25:34  voba
// - перевел словарные списки на l3CString
// - выкинул ненужное преобразование в OEM
// - refact. выкинул  ImportType, все равно он только ietMassive использовался
//
// Revision 1.118.4.2  2007/07/25 15:07:15  voba
// no message
//
// Revision 1.118.4.1  2007/07/25 11:37:06  voba
// no message
//
// Revision 1.118  2007/06/28 11:16:25  voba
// - refact. убрал из function TAbstractList.GetItem второй параметр
//
// Revision 1.117  2007/06/25 12:18:50  narry
// - поддержка команды !SERVICEINFO
//
// Revision 1.116  2007/03/26 09:34:03  fireton
// - изменился формат l3System.FreeLocalMem
//
// Revision 1.115  2007/02/12 16:11:00  voba
// - заменил использование htModifyRecs на вызов TAbsHtTbl.ModifyRecs
// - выделил TdtTable в модуль dt_Table (обертка вокруг функций HyTech по работе с таблицей целиком)
// - выделил функции HyTech по работе с Sab в dt_Sab, потом объект сделаю
//
// Revision 1.114  2007/01/19 14:03:22  voba
// - cc
//
// Revision 1.113  2007/01/16 07:14:44  voba
// - bug fix
//
// Revision 1.112  2007/01/11 10:02:09  voba
// // выливаем LOG
//
// Revision 1.111  2006/12/07 11:21:39  narry
// - AV
//
// Revision 1.110  2006/12/05 13:50:29  voba
// - add !*Log record out
//
// Revision 1.109  2006/06/28 08:36:35  narry
// - исправление: ошибка преобразования номера отсутсвующего документа
//
// Revision 1.108  2006/06/08 15:54:45  fireton
// - подготовка к переходу на большой User ID
//
// Revision 1.107.2.1  2006/06/08 08:52:48  fireton
// - перевод User ID на Longword
//
// Revision 1.107  2006/06/05 08:55:25  narry
// - исправление: добавлены счетчики позиции в списках атрибутов для аннотаций
//
// Revision 1.106  2006/06/02 16:00:45  narry
// - исправление: добавлены счетчики позиции в списках атрибутов для аннотаций
//
// Revision 1.105  2006/04/04 11:12:16  fireton
// - bug fix: при выливке одиночного документа данные набирались два раза и не освобождались
//
// Revision 1.104  2006/04/03 13:58:23  fireton
// - строки вынесены в resourcestring (иначе AQTime не хочет профилировать)
//
// Revision 1.103  2006/03/24 14:41:06  fireton
// - change: одиночная выливка упразднена, теперь фильтр всегда работает в буферизированном режиме (для скорости)
//
// Revision 1.102  2005/10/17 13:25:45  step
// переименование LinkComent --> LinkComment
//
// Revision 1.101  2005/05/06 13:16:47  narry
// - bug fix: не выливались дата и номер регистрации в Минюсте для специальных аннотаций
//
// Revision 1.100  2005/03/30 09:27:15  narry
// - контроль экспорт ANNODATE для документов
//
// Revision 1.99  2005/03/29 15:59:23  narry
// - bug fix: атрибуты документа попадали в таблицу
//
// Revision 1.98  2005/03/28 11:32:25  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.97  2005/03/23 11:02:20  narry
// - bug fix: AV
//
// Revision 1.96  2005/03/22 14:41:56  step
// исправлено название метода у LinkServer
//
// Revision 1.95  2005/03/21 16:30:43  voba
// - replace cfOrdinal to dt_Const.cOrdLogActions
// - replace cfJuror to dt_Const.cJurLogActions
//
// Revision 1.94  2005/03/21 10:05:03  lulin
// - newq interface: _Ik2Type.
//
// Revision 1.93  2005/03/14 17:26:47  narry
// - cleanup
//
// Revision 1.92  2005/03/14 17:02:30  narry
// - Bug fix: выливались лишние даты
//
// Revision 1.91  2005/03/14 16:39:38  narry
// - Bug fix: неправильно выливались Анноклассы
//
// Revision 1.90  2005/03/14 15:02:45  narry
// - Bug fix: выливался только один Аннокласс
//
// Revision 1.89  2005/03/14 14:01:00  narry
// - Bug fix: не выливались Анноклассы
//
// Revision 1.88  2005/03/14 12:14:52  narry
// - update: фильтрация ссылок в аннотациях
//
// Revision 1.87  2005/03/04 15:53:26  narry
// - новинка: реализация импорта Пучин-нср
//
// Revision 1.86  2005/03/02 16:03:16  narry
// - Новые методы для экспорта заголовка Аннтотаций
//
// Revision 1.85  2005/02/25 16:20:28  narry
// - update: поддержка Аннотаций
//
// Revision 1.84  2005/02/25 14:25:26  step
// bug fix
//
// Revision 1.83  2005/02/25 12:54:09  step
// избавление от интервала "dlSources..dlAccGroups"
//
// Revision 1.82  2005/02/25 08:38:19  step
// расширен cfJuror (добавлено acAnnoDate)
//
// Revision 1.81  2005/02/22 11:57:47  step
// добавлена обработка аннотаций
//
// Revision 1.80  2005/02/18 17:43:52  step
// добавлена обработка аннотаций
//
// Revision 1.79  2004/11/23 15:31:25  narry
// - add: Ловушка для восстанавливаемых ссылок
//
// Revision 1.78  2004/09/21 13:16:31  narry
// - update: запись в лог предупреждения о восстановлении ссылок из документа
//
// Revision 1.77  2004/09/21 12:04:20  lulin
// - Release заменил на Cleanup.
//
// Revision 1.76  2004/09/14 15:58:14  lulin
// - удален модуль Str_Man - используйте вместо него - l3String.
//
// Revision 1.75  2004/09/13 12:47:59  narry
// - bug fix: потерянные ссылки при экспорте одного документа
//
// Revision 1.74  2004/09/13 12:10:25  narry
// - bug fix: пропадающие ссылки
//
// Revision 1.70  2004/08/24 14:06:20  step
// заставили писАться BELONGS для словарных статей
//
// Revision 1.69  2004/08/03 08:52:48  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.68  2004/05/14 16:58:47  law
// - new units: k2TagTerminator, k2TagFilter.
//
// Revision 1.67  2004/05/14 14:48:59  law
// - исправлены префиксы у констант.
//
// Revision 1.66  2004/05/14 14:29:05  law
// - change: TevVariant переименован в Tk2Variant и переехал в k2Types.
//
// Revision 1.65  2004/05/06 12:38:16  narry
// - update: поддержка типа документа DictEntry
//
// Revision 1.64  2004/04/14 13:51:12  narry
// - bug fix: вместо последней даты юридического изменения документа возвращалась первая
//
// Revision 1.63  2004/03/26 14:09:41  voba
// no message
//
// Revision 1.62.2.2  2004/03/22 16:56:24  narry
// - bug fix: поле k2_tiPrivate добавлялось в неправильном месте
//
// Revision 1.62.2.1  2004/03/19 17:11:56  step
// Исправления, связанные с добавлением поля DT#A.PRIVATE
//
// Revision 1.62  2004/03/10 11:51:51  step
// учтено добавление поля TYP в табл. FILE
//
// Revision 1.61  2004/03/10 10:41:05  step
// учтено добавление поля TYP в табл. FILE
//
// Revision 1.60  2004/03/05 16:52:23  step
// чистка кода
//
// Revision 1.59  2004/02/27 10:30:56  voba
// - merge with adding_field_shname
//
// Revision 1.58.2.2  2004/02/27 09:37:46  voba
// no message
//
// Revision 1.58.2.1  2004/02/26 12:24:11  step
// изменено получение PUBLISHED данных
//
// Revision 1.58  2004/02/03 12:12:28  narry
// - update
//
// Revision 1.57  2004/02/03 09:07:07  step
// В таблицу DT#B возвращено поле Coment
//
// Revision 1.56  2004/01/30 13:10:20  narry
// - update: новая структура команды !PUBLISHEDIN
//
// Revision 1.55  2004/01/30 09:16:10  step
// изменена TExportFilter.GetSingleHeaderData (учтено изменение структуры LNK#B)
//
// Revision 1.54  2004/01/29 15:16:28  step
// изменена TExportFilter.GetLinkSab (учтено изменение структуры LNK#B)
//
// Revision 1.53  2004/01/29 14:10:15  narry
// - update: новая структура команды !PUBLISHEDIN
//
// Revision 1.52  2003/08/19 18:06:38  step
// В словари добавлено поле NameE и удалено поле NameLen
//
// Revision 1.51  2003/05/20 09:20:24  demon
// - add: поддержка экспорта автоматически созданных классов.
//
// Revision 1.50  2003/03/13 13:01:56  demon
// - new: добавлена поддержка экспорта ActiveInterval и Alarm
//
// Revision 1.49  2003/02/11 10:04:38  voba
// - rename proc: l3NodeActionL2FA -> l3L2IA.
//
// Revision 1.48  2003/01/29 13:54:59  narry
// - bug fix: дублирование ссылок в справках
//
// Revision 1.47  2003/01/17 14:13:08  demon
// - new behavior: изменен принцип нотификации об изменении словарей.
// Теперь все централизовано и сообщение получает только DictServer, а все кому нужна дополнительная
// нотификация должны зарегистрироваться на нем.
//
// Revision 1.46  2003/01/16 15:32:33  demon
// - newr: Описания типов TExpData TSubExpData вынес в DT_Const.
//
// Revision 1.45  2002/10/08 13:46:19  narry
// - update: отключение вывода в лог информации о наборе словарей
//
// Revision 1.44  2002/09/26 13:14:58  narry
// - update: добавлен вызов ProcessMessages во время набора списков
//
// Revision 1.43  2002/09/18 08:06:11  voba
// - cleanup: удален параметр IsDefault.
//
// Revision 1.42  2002/09/03 07:59:30  narry
// - new behavior: support for k2_idDictItem
//
// Revision 1.41  2002/08/01 09:16:57  voba
// -bug fix: приход нотификации об изменении словаря dlNewClasses во время процедуры экспорта приводило к RangeCheckError
//
// Revision 1.40  2002/04/17 08:49:09  narry
// - bug fix: при экспорте одного документа не выливались атрибуты
//
// Revision 1.39  2002/04/16 13:54:21  narry
// - bug fix: range check
//
// Revision 1.38  2002/04/15 13:15:11  narry
// - update
//
// Revision 1.37  2002/04/11 07:03:24  demon
// - add Unnecessary Export Data notifier
//
// Revision 1.36  2002/04/04 13:43:55  narry
// - new behviaor: add export of header for dtGraphic
//
// Revision 1.35  2002/03/12 15:18:52  demon
// - spellchecking
//
// Revision 1.34  2002/03/11 13:46:17  voba
// - fix rel header export bug
//
// Revision 1.33  2002/02/11 14:30:50  voba
// -lib sincro : change some m0 modules to m2
//
// Revision 1.32  2002/02/01 09:37:36  demon
// - bug fix
//
// Revision 1.31  2001/11/21 12:50:31  demon
// - new: add new doc attribute - _dictionary #F (dlAccGroups)
//
// Revision 1.30  2001/08/23 10:27:44  demon
// - add new Type - TDocType its replaced some constants
//
// Revision 1.29  2001/03/14 13:57:37  demon
// - some changes in evTag Generators & Filtres
//
// Revision 1.28  2001/02/01 14:09:02  demon
// - bug fix
//
// Revision 1.27  2001/01/26 07:53:39  demon
// - now TExportFilter inherits from Class TevTagTerminator
//
// Revision 1.26  2001/01/26 07:26:16  demon
// - add filtration of internal data (in text) of HLINK
//
// Revision 1.25  2000/12/26 16:00:22  demon
// fixed bug with OEM Convertion of Norm
//
// Revision 1.24  2000/12/22 10:32:11  demon
// Remove some warnings & hints
//
// Revision 1.23  2000/12/20 16:17:28  demon
// no message
//
// Revision 1.22  2000/12/15 15:36:16  law
// - вставлены директивы Log.
//

{$I DtDefine.inc}

interface

uses
  Classes,
  l3Base, l3Types, l3DatLst, l3Date, l3Variant,
  l3MarshalledTypes,
  k2Types, k2TagGen, k2TagTerminator,
  k2Prim,
  daTypes,
  HT_Const,
  dtIntf, dt_Sab,
  DT_Const, DT_Types, dt_AttrSchema, dt_ImpExpTypes,
  DT_aTbl, DT_EGen, DT_Renum, DT_Dict, DT_List,
  l3InterfaceList,
  l3ObjectRefList,
  dt_DictTypes;

type
 TDocPartSelector = l3MarshalledTypes.TDocPartSelector;

const
 dpDoc = l3MarshalledTypes.dpDoc;
 dpSpr = l3MarshalledTypes.dpSpr;
 dpAnno = l3MarshalledTypes.dpAnno;

type
 TExpAttrCache     = atDateNums .. atHLink;
   {* - Cписок закешированных данных атрибутов}

 PexpAttrCursor = ^TexpAttrCursor;
 TexpAttrCursor = record
  rList    : ISabCursor;
  rOrgPos  : Longint;
  rLastPos : Longint;
 end;

 //!!!! rDocID всегда первое

 PexpOrdAttr = ^TexpOrdAttr;
 TexpOrdAttr = packed record
  rDocID  : TDocID;
  rDictID : TDictID;
  rSubID  : TSubID;
 end;

 PexpHyperLinkRec = ^TexpHyperLinkRec;
 TexpHyperLinkRec = packed record
  rDocID  : TDocID;
  rID     : LongInt;
  rDDocID : TDocID;
  rDSubID : TSubID;
 end;

 PexpDNDictRec = ^TexpDNDictRec;
 TexpDNDictRec = packed record
  rDocID   : TDocID;
  rDate    : TStDate;
  rNum     : TNumberStr;
  rType    : TDNType;
  rLinkDocID  : TDocID;
  rLinkSubID  : TDocID;
 end;

 PexpPublishDataRec = ^TexpPublishDataRec;
 TexpPublishDataRec = packed record
  rDocId        : TDocID;                  // LNK#B.DocId
  rDictID       : Longword;                // DT#B.Id
  rSourId       : TDictID; // word         // DT#B.Source = DT#A.Id
  rSDate        : TStDate;                 // DT#B.StartDate
  rEDate        : TStDate;                 // DT#B.EndDate
  rNum          : array[1..30] of Char;    // DT#B.Number
  rComment      : array[1..70] of Char;    // DT#B.Coment
  rPages        : array[1..128] of Char;   // LNK#B.Pages
  rLinkComment  : array[1..255] of Char;   // LNK#B.Coment
  rFlags        : Byte;                    // LNK#B.Flags
  rShName       : array[1..50] of Char;    // DT#A.ShName
  rIsPrivate    : TIsPrivate;              // DT#Az.Private
  rIsNonperiodic: TIsNonperiodic;          // DT#A.Nonperiod
 end;

 TTestNeedAttributeRecProc = function(aAttr : TdtAttribute; var aRec) : boolean;

 TFilterMode = (emExport, emLoad);

type
 TExportFilter = Class(Tk2TagTerminator, IDictChangeNotifyRecipient)
  private
   fDocPart : TDocPartSelector;
   FSpecialAnnotation: Boolean;
   fDocList : ISab;
   fExtDocList : ISab; //fDocList + AddedDocID, только для SingleDocMode
   f_CurHL: Integer;
   f_HeaderDone: Boolean;
   f_HLAdded: Boolean;
   f_HLAddresses: Tl3ObjectRefList; // накапливает адреса приезжающие из дока, если в базе не окажется используем их.
   f_RestoredLinks: Integer;
   f_TotalLinks: Integer;

   fAttributes : TdtAttributeSet;
   fTestAttrProc : TTestNeedAttributeRecProc;
   f_AnsiCodePage: Integer;

   procedure FilterDocHeader(AtomIndex : Long; const Value : Tk2Variant);
   function  GetHLAddresses : Tl3ObjectRefList;

  protected
   fFamily         : TdaFamilyID;
   fDocGenerator   : TDocExportGenerator;
   fReNum          : Boolean;
   fReNumTbl       : TReNumTbl;
   fLevelSlash     : Char;
   fOEMConvert     : Boolean;

   fAddedDocID     : TDocID;
   fAddedAttr      : TdtAttributeSet;

   fPrevDocID,
   fCurDocID       : TDocID;
   //fCardRec        : TExpCardRec;

   fDictLists      : Array[TdaDictionaryType] of Tl3InterfaceList;
   fDictLoaded     : Array[TdaDictionaryType] of Boolean;
   fNeedDictReload : Array[TdaDictionaryType] of Boolean;

   //fAttrCacheDocID : TDocID;
   fAttrDataArr    : array[TExpAttrCache] of TexpAttrCursor;
   fRelHLinkData   : TexpAttrCursor;

   fFiltredFlag    : Boolean;

   fExportUnnecessaryData : TExportUnnecessaryData;

   fNeedHeaderMainRec : Boolean;
   fNeedHeaderAttr    : Boolean;
   fNeedDictNames     : Boolean;

   fMode              : TFilterMode;

   function    ConvertArrayToStr(aStr : PAnsiChar; aArrayLen : Integer) : Tl3PCharLen;

   procedure   SetNeedHeaderMainRec(aVal : Boolean);
   procedure   SetReNum(aVal : Boolean);
   procedure   SetOEMConvert(aVal : Boolean);
   function    GetSingleDocMode : Boolean;

   procedure   SetAttributes(aValue : TdtAttributeSet);

   procedure   FreeDictLists;
   procedure   LoadDictList(aListID : TdaDictionaryType);
   function    GetDictList(aListID : TdaDictionaryType) : Tl3InterfaceList;
   //procedure   LoadDictLists;

   function    GetSortDocID : TDocID;
   {* - выдает номер топика использованный при сортировке данных - реальный DocID для доков и DocID дока для справки}

   function    GetLinkData(aAttrID : TExpDictData) : ISabCursor;

   function    GetHLSab        : ISabCursor;
   function    GetRelatedHLSab : ISabCursor;
   function    GetLogSab(aAttr :TdtAttribute) : ISabCursor;
   function    GetStageSab     : ISabCursor;
   function    GetActiveSab    : ISabCursor;
   function    GetAlarmSab     : ISabCursor;
   function    GetPublishedSab : ISabCursor;
   function    GetDoc2DocSab   : ISabCursor;

   procedure   FreeAttrData;
   function    GetAttrData(aAttr : TExpAttrCache) : PexpAttrCursor;

   procedure   NextDocument;
   //procedure   InitAttrCache;

   procedure   WriteLinkData(aDict : TExpDictData; aSubID : TSubID);
   procedure   WriteCurStage(StageRec : PAnsiChar);
   procedure   WriteCurActive(ActiveRec : PAnsiChar);
   procedure   WriteCurAlarm(AlarmRec : PAnsiChar);
   procedure   WriteCurCheck(CheckRec : PAnsiChar);
   procedure   WriteCurPublish(PublishRec : PAnsiChar);
   procedure   WriteCurDoc2DocLink(aD2DRec : PAnsiChar);

   procedure   WriteHeaderData;

   //procedure   CheckCurDataPosition(const aCurData  : ISabCursor;
   //                                 var CurDataPos : LongInt;
   //                                 DataType : TAllExpData);

   procedure   WriteAttributes(aDocPartSel : TDocPartSelector);

   procedure   WriteAttrOfSub(aSubID : TSubID);
   procedure   WriteHLAddr(aHLinkID : LongInt);

   procedure   CheckRefreshDicts;

   procedure   dcn_DictionaryChange(const Info : TDictMessageRec);

   procedure   Cleanup; override;

   procedure   SetCurDocID(aValue : TDocID);

  public
   constructor Create(aFamily : TdaFamilyID); reintroduce;
   procedure   Init(aFamily : TdaFamilyID; aNeedHeaderMainRec : Boolean = false);

   {main Data Initialization}
   procedure   OpenStream; override;
   procedure   CloseStream(NeedUndo : Boolean); override;

   procedure AddAtomEx(AtomIndex : Long; const Value : Tk2Variant); override;

   procedure   StartTag(TagID : Long); override;
   procedure   StartChild(TypeID : Tl3VariantDef); override;
   procedure   CloseStructure(NeedUndo : Boolean); override;

   class function SetTo(var theGenerator : Tk2TagGenerator;
                            aDocFamily   : TdaFamilyID;
                            aDocID       : TDocID;
                            aNeedHeaderMainRec : Boolean = false;
                            aNeedDictNames : Boolean = True;
                            aMode : TFilterMode = emExport;
                            aDocPart : TDocPartSelector = dpDoc): TExportFilter;
      overload;
   class procedure SetTo(var theGenerator : Ik2TagGenerator;
                            aDocFamily   : TdaFamilyID;
                            aDocID       : TDocID;
                            aNeedHeaderMainRec : Boolean = false;
                            aNeedDictNames : Boolean = True;
                            aMode : TFilterMode = emExport);
      overload;

   { Свойство регулирует состав атрибутов, которые будут прочитаны из базы для
     текущего документа.
     По умолчанию из базы можно читать любые атрибуты - AllAttributes. }
   property Attributes : TdtAttributeSet
     read  fAttributes
     write SetAttributes;

   property TestAttrProc : TTestNeedAttributeRecProc write fTestAttrProc;

   { Свойство регулирует необходимость получения атрибутов, расположенных в заголовке
     текущего документа (header'а). Эта информация вставляется в поток данных сразу после
     InternalHandle.
     Этот флаг имеет больший приоритет, чем свойство Attributes. Т.е. даже если в
     Attributes перечислены атрибуты заголовка, а этот флаг не установлен - ни один
     атрибут заголовка читаться не будет.
     По умолчанию получение всех атрибутов header'а включено - true.
     Выключает Clipboard Filter. }

   property DocPart : TDocPartSelector
     read  fDocPart
     write fDocPart;


   property NeedHeaderAttr : Boolean
     read  fNeedHeaderAttr
     write fNeedHeaderAttr;

   { Свойство регулирует необходимость получения атрибутов таблицы File
     Сейчас при экспорте используется Dt_EGen.TDocExportGenerator, который сам этим занимается
     по умолчанию выключено, что бы не изметь логику экспортного фильтра. }
   property NeedHeaderMainRec : Boolean
     read  fNeedHeaderMainRec
     write SetNeedHeaderMainRec;

   { Свойство регулирует возможность получения имен словарных атрибутов.
     По умолчанию включено - True. }
   property NeedDictNames : Boolean
     read  fNeedDictNames
     write fNeedDictNames;

   {Object DocGenerator,
         Required for Massive export,
         Unable modified between Start - Finish. }
   property DocGenerator : TDocExportGenerator
     read  fDocGenerator
     write fDocGenerator;

   {Renumerate, from Internal IDs to External IDs,
    default True. }
   property ReNum : Boolean
     read  fReNum
     write SetReNum;

   {Convert all AnsiString data to OEM,
    default False. }
   property OEMConvertion : Boolean
     read  fOEMConvert
     write SetOEMConvert;

   {Default breaker in trees line}
   property LevelSlash : Char
     read  fLevelSlash
     write fLevelSlash;

   {Notifier for Unnecessary Export Data}
   property ExportUnnecessaryDataNotifier : TExportUnnecessaryData
     read  fExportUnnecessaryData
     write fExportUnnecessaryData;

   property DictLists[ListID : TdaDictionaryType] : Tl3InterfaceList
     read GetDictList;

   property SpecialAnnotation: Boolean
   { SpecialAnnotation - если установлен, то для аннотаций дополнительно выливаются
                         Имя документа, Важность и Информация о регистрации в Минюсте }
     read  fSpecialAnnotation
     write fSpecialAnnotation;

   property SingleDocMode : Boolean
   { - специальный режим выливки, считаем что в кеше атрибутов лежат только атрибуты
       одного документа и не проверяем DocID (хотя там еще могут лежать атрибуты добавочного дока AddedDocID) }
     read GetSingleDocMode;

   property AddedDocID : TDocID
   { - ID добавочного дока, с которого копируются атрибуты указанные в AddedAttrs}
     read fAddedDocID
     write fAddedDocID;

   property AddedAttrs  : TdtAttributeSet
   { - см. AddedDocID}
     read fAddedAttr
     write fAddedAttr;
   property AnsiCodePage: Integer read f_AnsiCodePage write f_AnsiCodePage;

   property Mode : TFilterMode read fMode write fMode;

   property HLAddresses : Tl3ObjectRefList read GetHLAddresses;
 end;

function  L2TestNeedAttributeRecProc(Action: Pointer): TTestNeedAttributeRecProc; register;
procedure FreeTestNeedAttributeRecProc(var Stub: TTestNeedAttributeRecProc); register;

implementation

uses
 vtDebug,
 SysUtils, Windows, TypInfo, Forms,
 l3Nodes, l3Tree_TLB, l3String, l3Chars, l3Interfaces,
 m2xltlib,
 k2Tags, k2Interfaces, k2Base,
 daInterfaces,
 HT_Dll,
 Dt_err, dt_Misc,
 DT_Table,
 dt_Record,
 Dt_Serv, DT_Hyper, Dt_Link, Dt_LinkServ, Dt_Doc, Dt_Log, Dt_Stage, Dt_Active, Dt_Alarm,
 dt_DictIntf,

 Stage_Const,
 ActiveInterval_Const,
 Alarm_Const,
 Check_Const,
 PIRec_Const,
 NumAndDate_Const,
 LogRecord_Const,
 DictItem_Const,
 Address_Const,
 Hyperlink_Const,
 Document_Const,
 DictEntry_Const,
 Sub_Const,
 DocumentSub_Const,
 Para_Const,
 AnnoTopic_Const,
 Bookmark_Const
 , dt_DictConst,
 l3InterfacedString
 ;

resourcestring
 rsRestoredLink        = 'IID %d: восстановлена ссылка #%d (%d.%d)';
 rsRestoredLinksReport = 'IID %d: всего cсылок %d, из них восстановлено %d';
 rsWrongDocID          = 'Неправильный адрес ссылки: DocID = #%d HLinkID = %d';

type
 THLA = class(Tl3Base)
 public
  rDocID: TDocID;
  rSubID: TSubID;
 end;

function gDocComp(A, B: Pointer): Long;
begin
 //!!!! rDocID всегда первое
 Result := PDocID(A)^ - PDocID(B)^;
end;

function gIDHLComp(A, B: Pointer): Long;
begin
 Result := PexpHyperLinkRec(A).rID - PLongint(B)^;
end;

function gSubIDComp(A, B: Pointer): Long;
begin
 Result := PexpOrdAttr(A).rSubID - PSubID(B)^;
end;

Constructor TExportFilter.Create(aFamily : TdaFamilyID);
begin
 Inherited Create;
 Init(aFamily);
end;

procedure TExportFilter.Init(aFamily : TdaFamilyID; aNeedHeaderMainRec : Boolean = false);
begin
 fFamily := aFamily;
 fLevelSlash:='\';

 fAttributes := CdtAllAttributes;
 NeedHeaderMainRec := aNeedHeaderMainRec;
 fNeedHeaderAttr := True;
 fNeedDictNames := True;
 fMode := emExport;
 fCurDocID := cUndefDocID;
end;

procedure TExportFilter.Cleanup;
var
 I : TdaDictionaryType;
begin
 fTestAttrProc := nil;
 for I := Low(TdaDictionaryType) to High(TdaDictionaryType) do
  l3Free(fDictLists[I]);
 l3Free(f_HLAddresses);
 Inherited;
end;

procedure TExportFilter.SetReNum(aVal : Boolean);
begin
 if aVal and Not fReNum then
  fReNumTbl := LinkServer(fFamily).Renum;
 fReNum := aVal;
end;

procedure TExportFilter.SetNeedHeaderMainRec(aVal : Boolean);
begin
 fNeedHeaderMainRec := aVal;
end;

procedure TExportFilter.SetOEMConvert(aVal : Boolean);
begin
 Assert(not StreamOpened,'TExportFilter.SetOEMConvert: Попытка настроить кодировку во время экспорта');
 if aVal <> fOEMConvert then
 begin
  fOEMConvert := aVal;
  FreeDictLists;
 end;
end;

procedure TExportFilter.SetAttributes(aValue : TdtAttributeSet);
begin
 fAttributes := aValue;
end;

function TExportFilter.GetSingleDocMode : Boolean;
begin
 Result := fDocGenerator = nil;
end;

procedure TExportFilter.FreeDictLists;
var
 I : TdaDictionaryType;
begin
 for I := Low(TdaDictionaryType) to High(TdaDictionaryType) do
 begin
  if fDictLists[I] <> nil then
   fDictLists[I].Clear;
  fDictLoaded[I] := False;
  fNeedDictReload[I] := False;
 end;
end;

procedure TExportFilter.LoadDictList(aListID : TdaDictionaryType);
const
 cCodePageSel : array[False..True] of Longint = (cp_ANSI, cp_OEM);
var
 lCurTree : TDictRootNode;

 function IterHandler(CurNode : Il3Node) : Boolean; far;
 var
  lCStr :  Il3CString;
  lDictItem : IDictItem;
 begin
  if Supports(CurNode, IDictItem, lDictItem) then
  begin
   lCStr := l3GetFullPathCStr(lCurTree, CurNode, cCodePageSel[fOEMConvert]);
   if lDictItem.Handle < fDictLists[aListID].Count then
    fDictLists[aListID].Items[lDictItem.Handle] := lCStr;
  end;
  Result := False;
 end;

 procedure lGetIndexDictList;
  var
   lRec       : PAnsiChar;
   lID        : TDictID;
   lName      : PAnsiChar;
   lNameLen   : Word;

   lSab       : ISab;

   lIDFldSize : Integer;
   lNameFldSize : Integer;
   lDictMaxID   : TDictID;

   ll3String : Tl3InterfacedString;
   lFldArr : TFieldArray;

   I : Integer;
 begin
  //if Not IsTableOpened then raise EHtErrors.CreateInt(ecTblNotOpen);

  if aListID in [da_dlBases, da_dlAccGroups] then
    lFldArr := MakeFieldArray([dtIDFld, dtShNameFld])
   else
    lFldArr := MakeFieldArray([dtIDFld, dtNameRFld]);

  with DictServer(fFamily).DictTbl[aListID] do
  begin
   lIDFldSize := fldLength[lFldArr[0]];
   lNameFldSize := fldLength[lFldArr[1]];
   lDictMaxID := GetMaxID;
  end;

  with fDictLists[aListID] do
  begin
   Clear;
   Count := lDictMaxID + 1;

   lSab := MakeSab(DictServer(fFamily).DictTbl[aListID]);
   lSab.SelectAll;

   with lSab.MakeSabCursor(lFldArr, cmForward, ROPEN_READ) do
   for I := 0 to Pred(Count) do
   begin
    lRec := GetItem(I);
    lID := 0;
    System.Move(lRec[0], lID, lIDFldSize);

    lNameLen := l3SizeOfTextArray(@lRec[lIDFldSize], lNameFldSize);

    lName := l3NativeAllocPChar(lRec[lIDFldSize], lNameLen);

    ll3String := Tl3InterfacedString.Make(l3PCharLen(lName, lNameLen), True);
    try
     ll3String.CodePage := cCodePageSel[fOEMConvert];
     Items[lID] := Il3CString(ll3String);
    finally
     l3Free(ll3String);
    end;
   end;
  end;
 end;

begin
 if not fNeedDictNames then Exit;
 if not (aListID in [da_dlSources..da_dlAccGroups] + [da_dlAnnoClasses, da_dlServiceInfo]) then
  Exit;

 if fDictLists[aListID] = nil then
  fDictLists[aListID] := Tl3InterfaceList.Create;

 if (aListID in [da_dlBases, da_dlNorms, da_dlAccGroups]) then
  lGetIndexDictList
 else
 begin
  fDictLists[aListID].Clear;
  fDictLists[aListID].Count := DictServer(fFamily).DictTbl[aListID].GetMaxID + 1;
  lCurTree := DictServer(fFamily).DictRootNode[aListID].Use;
  try
   Il3Node(lCurTree).IterateF(l3L2NA(@IterHandler), 0);
  finally
   l3Free(lCurTree);
  end;
 end;
 fDictLoaded[aListID] := True;
 fNeedDictReload[aListID] := False;
end;

function TExportFilter.GetDictList(aListID : TdaDictionaryType) : Tl3InterfaceList;
begin
 if Not (aListID in sNotExportedNames) then
 begin
  if Not fDictLoaded[aListID] then
   LoadDictList(aListID);
  Result := fDictLists[aListID];
 end
 else
  Result := nil;
end;

function  TExportFilter.GetSortDocID : TDocID;
begin
 if not SingleDocMode and (fDocPart = dpSpr) then
 begin
  if DocGenerator = nil then
   Result := fPrevDocID
  else
   Result := DocGenerator.CurDocID;
 end
 else
  Result := fCurDocID;
end;

function  TExportFilter.GetLinkData(aAttrID : TExpDictData) : ISabCursor;
var
 lLinkSab  : ISab;
 lDictSab  : ISab;
 lJoinLinkSab : IJoinSab;

 lDictType  : TdaDictionaryType;

 lLinkTbl   : TdtTable;
 lDictTbl   : TdtTable;

 lResult    : ISabCursor;
 I : Integer;
begin
 lDictType := AttrID2DLType(aAttrID);

 if lDictType = da_dlPublisheds then
  Result := GetPublishedSab
 else
 begin
  if (lDictType = da_dlDateNums) or (lDictType = da_dlCorrects) then
  begin
   lLinkTbl := LinkServer(fFamily).Links[lDictType].Table;
   lDictTbl := DictServer(fFamily).Tbl[lDictType];

   if SingleDocMode and (aAttrID in AddedAttrs) then
    lLinkSab := MakeSabCopy(fExtDocList)
   else
    lLinkSab := MakeSabCopy(fDocList);

   lLinkSab.RecordsByKey(lnkDocIDFld, MakePhoto(lLinkTbl));

   lDictSab := MakeSabCopy(lLinkSab);
   lDictSab.ValuesOfKey(lnkDictIDFld);
   lDictSab.TransferToPhoto(dtIDFld, lDictTbl);
   lDictSab.RecordsByKey;

   lJoinLinkSab := MakeJoinSab(lLinkSab, lnkDictIDFld,
                               lDictSab, dtIDFld);

   if not SingleDocMode then
    lJoinLinkSab.SortJoin([JFRec(lLinkTbl, lnkDocIDFld)]);
   lJoinLinkSab.Flush;

   case lDictType of
    da_dlDateNums :
     begin
      if not SingleDocMode then
       lJoinLinkSab.SortJoin([JFRec(lLinkTbl, lnkDocIDFld), JFRec(lDictTbl, -dnDateFld)]);
      lJoinLinkSab.Flush;

      Result := lJoinLinkSab.MakeJoinSabCursor([JFRec(lLinkTbl, lnkDocIDFld),
                                                JFRec(lDictTbl, dnDateFld),
                                                JFRec(lDictTbl, dnNumFld),
                                                JFRec(lDictTbl, dnTypFld),
                                                JFRec(lDictTbl, dnLinkDocIDFld),
                                                JFRec(lDictTbl, dnLinkSubIDFld)
                                                ],
                                               cmForward, ROPEN_READ);
     end;
    da_dlCorrects :
     begin
      if not SingleDocMode then
      lJoinLinkSab.SortJoin([JFRec(lLinkTbl, lnkDocIDFld)]);
      lJoinLinkSab.Flush;

      Result := lJoinLinkSab.MakeJoinSabCursor([JFRec(lLinkTbl, lnkDocIDFld),
                                                JFRec(lDictTbl, crDateFld),
                                                JFRec(lDictTbl, crPSourFld),
                                                JFRec(lDictTbl, crTypFld),
                                                JFRec(lDictTbl, crAuthorFld),
                                                JFRec(lDictTbl, crCommentFld)],
                                               cmForward, ROPEN_READ);
     end;
   end; // case lDictType of
  end
  else // if (lDictType = da_dlDateNums)
  begin
   if SingleDocMode and (aAttrID in AddedAttrs) then
    lLinkSab := MakeSabCopy(fExtDocList)
   else
    lLinkSab := MakeSabCopy(fDocList);

   lLinkSab.RecordsByKey(lnkDocIDFld, MakePhoto(LinkServer(fFamily).Links[lDictType]));


   if aAttrID in cSubDictExpData then
   begin
    if SingleDocMode then
     lLinkSab.Sort([lnkSubIDfld])
    else
     lLinkSab.Sort([lnkDocIDFld, lnkSubIDfld]);
   end
   else
    if not SingleDocMode then
     lLinkSab.Sort([lnkDocIDFld]);

   lLinkSab.Flush;

   case lDictType of
    da_dlSources,
    da_dlBases,
    da_dlWarnings,
    da_dlTerritories,
    da_dlNorms,
    da_dlAnnoClasses,
    da_dlAccGroups :
     Result := lLinkSab.MakeSabCursor([lnkDocIDFld, lnkDictIDFld], cmForward, ROPEN_READ);

    da_dlTypes,
    da_dlClasses,
    da_dlKeyWords,
    da_dlPrefixes,
    da_dlServiceInfo :
     Result := lLinkSab.MakeSabCursor([lnkDocIDFld, lnkDictIDfld, lnkSubIDfld], cmForward, ROPEN_READ);

    else
     Assert(False, format('TExportFilter.GetLinkData: неизвестный атрибут %s', [GetEnumName(TypeInfo(TdaDictionaryType), Ord(lDictType))]));
   end;
  end;
 end;

 {if lDictType = da_dlClasses then
  for i := 0 to Pred(Result.Count) do
   with PexpOrdAttr(Result.GetItem(I))^ do
    dbgAppendToLogLN(format('%8d %8d %8d',[rDocID, rSubID, rDictID]));
  }
end;

function TExportFilter.GetHLSab : ISabCursor;
var
 lSab : ISab;
begin
 lSab := MakeSabCopy(fDocList);
 lSab.RecordsByKey(hlSourD_fld, MakePhoto(LinkServer(fFamily)[atHLink]));

 lSab.Sort([hlSourD_fld, hlID_fld]);

 lSab.Flush;
 Result := lSab.MakeSabCursor([hlSourD_fld, hlID_fld, hlDestD_fld, hlDestS_fld], cmForward, ROPEN_READ);
end;

(*function TExportFilter.GetRelatedHLSab : ISabCursor;
var
 lMainSab  : ISab;
 lHLSab    : ISab;
 lJoinSab  : IJoinSab;

 lMainTbl  : TdtTable;
 lHLinkTbl : TdtTable;

begin
 lMainTbl := DocumentServer(fFamily).FileTbl;
 lHLinkTbl := LinkServer(fFamily)[atHLink].Table;

 lMainSab := MakeSabCopy(fDocList);
 lMainSab.RecordsByKey(fID_fld, MakePhoto(lMainTbl));

 lJoinSab := MakeJoinSab(lMainSab, fRelated_fld,
                         MakeAllRecords(lHLinkTbl), hlSourD_fld);

 lJoinSab.SortJoin([JFRec(lMainTbl,  fId_Fld),
                    JFRec(lHLinkTbl, hlID_fld)]);
 lJoinSab.Flush;

 Result := lJoinSab.MakeJoinSabCursor([JFRec(lMainTbl,  fId_Fld),
                                       //JFRec(lMainTbl,  fRelated_fld),
                                       // вместо настоящего ID справки используем ID документа,
                                       // т к справка выливается сразу за доком и удобно сортировать по ID документа
                                       JFRec(lHLinkTbl, hlID_fld),
                                       JFRec(lHLinkTbl, hlDestD_fld),
                                       JFRec(lHLinkTbl, hlDestS_fld)],
                                      cmForward, ROPEN_READ);
end;*)

function TExportFilter.GetRelatedHLSab : ISabCursor;
var
 lMainSab  : ISab;
 lHLSab    : ISab;
 lJoinSab  : IJoinSab;

 lMainTbl  : TdtTable;
 lHLinkTbl : TdtTable;

begin
 lMainTbl := DocumentServer(fFamily).FileTbl;
 lHLinkTbl := LinkServer(fFamily)[atHLink].Table;

 lMainSab := MakeSabCopy(fDocList);
 lMainSab.RecordsByKey(fID_fld, MakePhoto(lMainTbl));

 lHLSab := MakeSabCopy(lMainSab);
 lHLSab.ValuesOfKey(fRelated_fld);
 lHLSab.TransferToPhoto(hlSourD_fld, lHLinkTbl);
 lHLSab.RecordsByKey;

 lJoinSab := MakeJoinSab(lMainSab, fRelated_fld,
                         lHLSab, hlSourD_fld);

 lJoinSab.SortJoin([JFRec(lMainTbl,  fId_Fld),
                    JFRec(lHLinkTbl, hlID_fld)]);
 lJoinSab.Flush;

 Result := lJoinSab.MakeJoinSabCursor([JFRec(lMainTbl,  fId_Fld),
                                       //JFRec(lMainTbl,  fRelated_fld),
                                       // вместо настоящего ID справки используем ID документа,
                                       // т к справка выливается сразу за доком и удобно сортировать по ID документа
                                       JFRec(lHLinkTbl, hlID_fld),
                                       JFRec(lHLinkTbl, hlDestD_fld),
                                       JFRec(lHLinkTbl, hlDestS_fld)],
                                      cmForward, ROPEN_READ);
end;

function TExportFilter.GetLogSab(aAttr : TdtAttribute) : ISabCursor;
var
 lSab : ISab;
 lActFlag : Byte;
begin
 Assert(aAttr in [atOrdLogRecords, atJurLogRecords]);
 if aAttr = atJurLogRecords then
  lActFlag := Byte(acfJuror)
 else
  lActFlag := Byte(acfOrdinal);

 if SingleDocMode and (aAttr in AddedAttrs) then
  lSab := MakeSabCopy(fExtDocList)
 else
  lSab := MakeSabCopy(fDocList);

 lSab.RecordsByKey(lgDocID_Key, MakePhoto(LinkServer(fFamily)[aAttr]));
 lSab.SubSelect(lgActionFlag_Key, lActFlag);

 //lSab.Sort([lgDocID_Key, -lgActionFlag_Key, lgAction_Key, lgDate_Key, lgTime_Key]);
 lSab.Sort([lgDocID_Key]);

 lSab.Flush;
 Result := lSab.MakeSabCursor([lgDocID_Key, lgAction_Key, lgDate_Key, lgTime_Key, lgAuthor_Key], cmForward, ROPEN_READ);
end;

function TExportFilter.GetStageSab : ISabCursor;
var
 lSab : ISab;
begin
 if SingleDocMode and (atStages in AddedAttrs) then
  lSab := MakeSabCopy(fExtDocList)
 else
  lSab := MakeSabCopy(fDocList);

 lSab.RecordsByKey(stDocID_Key, MakePhoto(LinkServer(fFamily)[atStages]));

 lSab.Sort([stDocID_Key, stType_Key]);
 lSab.Flush;
 Result := lSab.MakeSabCursor([stDocID_Key, stType_Key, stBDate_Key, stEDate_Key, stAuthor_Key], cmForward, ROPEN_READ);
end;

function TExportFilter.GetActiveSab: ISabCursor;
var
 lSab : ISab;
begin
 if SingleDocMode and (atActiveIntervals in AddedAttrs) then
  lSab := MakeSabCopy(fExtDocList)
 else
  lSab := MakeSabCopy(fDocList);

 lSab.RecordsByKey(actDocID, MakePhoto(LinkServer(fFamily)[atActiveIntervals]));

 lSab.Sort([actDocID, actRecID]);
 lSab.Flush;
 Result := lSab.MakeSabCursor([actDocID, actRecID, actTyp, actStart, actFinish, actComment], cmForward, ROPEN_READ);
end;

function TExportFilter.GetAlarmSab : ISabCursor;
var
 lSab : ISab;
begin
 if SingleDocMode and (atAlarms in AddedAttrs) then
  lSab := MakeSabCopy(fExtDocList)
 else
  lSab := MakeSabCopy(fDocList);

 lSab.RecordsByKey(alDocID, MakePhoto(LinkServer(fFamily)[atAlarms]));

 lSab.Sort([alDocID, alRecID]);
 lSab.Flush;
 Result := lSab.MakeSabCursor([alDocID, alRecID, alStart, alComment], cmForward, ROPEN_READ);
end;

function TExportFilter.GetPublishedSab : ISabCursor;
var
 lDictSab     : ISab;
 lLinkSab     : ISab;
 lJoinLinkSab : IJoinSab;
 lJoinPublSab : IJoinSab;
 lAllSab      : IJoinSab;

 lLinkTbl     : TdtTable;
 lPublTbl     : TdtTable;
 lCSrcTbl     : TdtTable;

begin
 DictServer(fFamily).Family := fFamily;
 lLinkTbl := LinkServer(fFamily).Links[da_dlPublisheds].Table;
 lPublTbl := DictServer(fFamily).Tbl[da_dlPublisheds];
 lCSrcTbl := DictServer(fFamily).Tbl[da_dlCorSources];

 if SingleDocMode and (atPublisheds in AddedAttrs) then
  lLinkSab := MakeSabCopy(fExtDocList)
 else
  lLinkSab := MakeSabCopy(fDocList);

 lLinkSab.RecordsByKey(lnkDocIDFld, MakePhoto(lLinkTbl));

 //lPublPhoto := MakeAllRecords(lPublTbl);

 lDictSab := MakeSabCopy(lLinkSab);
 lDictSab.ValuesOfKey(lnkDictIDFld);
 lDictSab.TransferToPhoto(dtIDFld, lPublTbl);
 lDictSab.RecordsByKey;

 lJoinLinkSab := MakeJoinSab(lLinkSab, lnkDictIDFld,
                             lDictSab, dtIDFld);

 lJoinPublSab := MakeJoinSab(lDictSab, piSourFld,
                             MakeAllRecords(lCSrcTbl), dtIDFld);

 lAllSab := MakeJoinSab(lJoinLinkSab, lJoinPublSab);

 lAllSab.SortJoin([JFRec(lLinkTbl, lnkDocIDFld)]); // сортировка по полю LNK#B.DocId

 lAllSab.Flush;

 Result := lAllSab.MakeJoinSabCursor([JFRec(lLinkTbl, lnkDocIDFld),        // LNK#B.DocId
                                      JFRec(lPublTbl, piIDFld),            // DT#B.Id  (см. Dt_Types.TPublishDataRec)
                                      JFRec(lPublTbl, piSourFld),          // DT#B.Source = DT#A.Id
                                      JFRec(lPublTbl, piSDateFld),         // DT#B.StartDate
                                      JFRec(lPublTbl, piEDateFld),         // DT#B.EndDate
                                      JFRec(lPublTbl, piNumberFld),        // DT#B.Number
                                      JFRec(lPublTbl, piCommentFld),       // DT#B.Coment
                                      JFRec(lLinkTbl, lnkPublihedsPages),  // LNK#B.Pages
                                      JFRec(lLinkTbl, lnkPublihedsComent), // LNK#B.Coment
                                      JFRec(lLinkTbl, lnkPublihedsFlags),  // LNK#B.Flags
                                      JFRec(lCSrcTbl, dtShNameFld),        // DT#A.ShName
                                      JFRec(lCSrcTbl, dtIsPrivate),        // DT#A.Private
                                      JFRec(lCSrcTbl, dtIsNonperiodic)],   // DT#A.Nonperiod
                                     cmForward, ROPEN_READ);

end;

function  TExportFilter.GetAttrData(aAttr : TExpAttrCache) : PexpAttrCursor;
begin
 if (aAttr = atHLink) and (fDocPart = dpSpr) then
  Result := @fRelHLinkData
 else
  Result := @fAttrDataArr[aAttr];

 if Result.rList = nil then
 //InitAttrData
 begin
   //{*} dbgAppendToLogLN('    TExportFilter.GetLinkLists:');
  with Result^ do
  begin
   //if I in lAttributes then
   begin
    //{*}lTimer2 := dbgStartTimeCounter;

    l3System.Msg2Log('EFltr: A:%s (%s) - получаем данные', [GetEnumName(TypeInfo(TExpAttrCache), ord(aAttr)),
                                                            GetEnumName(TypeInfo(TDocPartSelector), ord(fDocPart))], l3_msgLevel2);
    if AttrID2DLType(aAttr) <> da_dlNone then
     rList := GetLinkData(aAttr)
    else
     case aAttr of
      atOrdLogRecords,
      atJurLogRecords   : rList := GetLogSab(aAttr);
      atStages          : rList := GetStageSab;
      atActiveIntervals : rList := GetActiveSab;
      atAlarms          : rList := GetAlarmSab;

      atHLink           :
       Case fDocPart of
        dpDoc : rList := GetHLSab;
        dpSpr : rList := GetRelatedHLSab;
       end;

      atDoc2DocLink     : rList := GetDoc2DocSab;
     end; // case I of ...
    l3System.Msg2Log('EFltr: A:%s Получено %d записей', [GetEnumName(TypeInfo(TExpAttrCache), ord(aAttr)), rList.Count], l3_msgLevel2);
    //{*} dbgAppendToLogLN(format('     [%s] %s',[GetEnumName(TypeInfo(TExpAttrCache), ord(I)), dbgFinishTimeCounter(lTimer2)]));
   end;
   rOrgPos  := -1;
   rLastPos := -1;
  end;

  //{*}lTimer2 := dbgStartTimeCounter;
  //{*} dbgAppendToLogLN(format('     [%s] %s',['atHLink_for_Related', dbgFinishTimeCounter(lTimer2)]));
 end;  //InitAttrData
end;

procedure TExportFilter.FreeAttrData;
var
 I : TExpAttrCache;
begin
 for I := Low(TExpAttrCache) to High(TExpAttrCache) do
  with fAttrDataArr[I] do
  begin
   rList := nil;
   rOrgPos  := -1;
   rLastPos := -1;
  end;

 with fRelHLinkData do
 begin
  rList := nil;
  rOrgPos  := -1;
  rLastPos := -1;
 end;
end;

procedure TExportFilter.NextDocument;
begin
 fPrevDocID  := fCurDocID;
 //fCurDocID   := BlankLI;

 fDocPart := dpDoc;
end;

function TExportFilter.ConvertArrayToStr(aStr : PAnsiChar; aArrayLen : Integer) : Tl3PCharLen;
var
 lSize : Long;
begin
 lSize := l3GetFilledArrayLength(aStr, aArrayLen);
 (*
 if fOEMConvert then
 begin
  m2XLTConvertBuff(aStr, lSize, Cm2XLTANSI2OEM);
  Result := l3PCharLen(aStr, lSize, CP_OEM);
 end
 else
 *)
  Result := l3PCharLen(aStr, lSize, CP_ANSI);
end;

procedure TExportFilter.WriteCurStage(StageRec : PAnsiChar);
Const
 stTypeOffset  = 4;
 stBDateOffset = 5;
 stEDateOffset = 9;
 stUserOffset  = 13;
begin
 Generator.StartChild(k2_typStage);
 try
  Generator.AddIntegerAtom(k2_tiType,PByte(StageRec+stTypeOffset)^);
  Generator.StartTag(k2_tiUser);
  try
   Generator.AddIntegerAtom(k2_tiHandle,Integer(PdaUserID(StageRec+stUserOffset)^));
  finally
   Generator.Finish;
  end;
  if PStDate(StageRec+stBDateOffset)^<>0 then
   Generator.AddIntegerAtom(k2_tiStart,PStDate(StageRec+stBDateOffset)^);
  if PStDate(StageRec+stEDateOffset)^<>0 then
   Generator.AddIntegerAtom(k2_tiFinish,PStDate(StageRec+stEDateOffset)^);
 finally
  Generator.Finish;
 end;
end;

procedure TExportFilter.WriteCurActive(ActiveRec : PAnsiChar);
const
 actRecIDOffset   = 4;
 actTypOffset     = 5;
 actStartOffset   = 6;
 actFinishOffset  = 10;
 actCommentOffset = 14;
 actCommentSize   = 1000;
var
 TmpPChar : PAnsiChar;
 TmpSize  : Word;
begin
 Generator.StartChild(k2_typActiveInterval);
 try
  Generator.AddIntegerAtom(k2_tiHandle,PByte(ActiveRec+actRecIDOffset)^);
  if PByte(ActiveRec+actTypOffset)^<>0 then
   Generator.AddIntegerAtom(k2_tiType,PByte(ActiveRec+actTypOffset)^);
  if PStDate(ActiveRec+actStartOffset)^<>0 then
   Generator.AddIntegerAtom(k2_tiStart,PStDate(ActiveRec+actStartOffset)^);
  if PStDate(ActiveRec+actFinishOffset)^<>0 then
   Generator.AddIntegerAtom(k2_tiFinish,PStDate(ActiveRec+actFinishOffset)^);
  TmpPChar:=ActiveRec+actCommentOffset;
  if TmpPChar[0] <> ' ' then
   Generator.AddStringAtom(k2_tiComment, ConvertArrayToStr(TmpPChar, actCommentSize));
 finally
  Generator.Finish;
 end;
end;

procedure TExportFilter.WriteCurAlarm(AlarmRec : PAnsiChar);
const
 alRecIDOffset   = 4;
 alStartOffset   = 5;
 alCommentOffset = 9;
 alCommentSize   = 1000;
var
 TmpPChar : PAnsiChar;
 TmpSize  : Word;
begin
 Generator.StartChild(k2_typAlarm);
 try
  Generator.AddIntegerAtom(k2_tiHandle,PByte(AlarmRec+alRecIDOffset)^);
  if PStDate(AlarmRec+alStartOffset)^<>0 then
   Generator.AddIntegerAtom(k2_tiStart,PStDate(AlarmRec+alStartOffset)^);
  TmpPChar:=AlarmRec+alCommentOffset;
  if TmpPChar[0] <> ' ' then
   Generator.AddStringAtom(k2_tiComment, ConvertArrayToStr(TmpPChar,alCommentSize));
 finally
  Generator.Finish;
 end;
end;

procedure TExportFilter.WriteCurCheck(CheckRec : PAnsiChar);
Const
 chDateOffset  = 4;
 chPSourOffset = 8;
 chTypeOffset  = 12;
 chUserOffset  = 13;
 chCommOffset  = chUserOffset + SizeOf(TdaUserID);
 chCommSize    = 70;
var
 TmpPChar : PAnsiChar;
 TmpSize  : Word;
begin
 Generator.StartChild(k2_typCheck);
 try
  if PStDate(CheckRec+chDateOffset)^<>0 then
   Generator.AddIntegerAtom(k2_tiStart,PStDate(CheckRec+chDateOffset)^);
  Generator.AddIntegerAtom(k2_tiSource,PLongInt(CheckRec+chPSourOffset)^);
  Generator.AddIntegerAtom(k2_tiType,PByte(CheckRec+chTypeOffset)^);
  Generator.StartTag(k2_tiUser);
  try
   Generator.AddIntegerAtom(k2_tiHandle,PdaUserID(CheckRec+chUserOffset)^);
  finally
   Generator.Finish;
  end;
  TmpPChar:=CheckRec+chCommOffset;
  if TmpPChar[0] <> ' ' then
   Generator.AddStringAtom(k2_tiComment, ConvertArrayToStr(TmpPChar, chCommSize));
 finally
  Generator.Finish;
 end;
end;

procedure TExportFilter.WriteCurPublish(PublishRec : PAnsiChar);
var
 lRec: PexpPublishDataRec absolute PublishRec;
begin
 Generator.StartChild(k2_typPIRec);
 try
  Generator.AddIntegerAtom(k2_tiHandle, lRec.rDictID);

  //if l_Rec^.SourId <> 0 then
   begin
    Generator.StartTag(k2_tiSource);
    try
     Generator.AddBoolAtom(k2_tiPrivate, (lRec^.rIsPrivate <> 0));
     Generator.AddIntegerAtom(k2_tiHandle, lRec^.rSourId);

     if fNeedDictNames then
      with Il3CString(DictLists[da_dlCorSources].Items[lRec^.rSourId]) do
       if AsWStr.SLen > 0 then
        Generator.AddStringAtom(k2_tiName, AsWStr);

    finally
     Generator.Finish;
    end;
   end;
  if lRec^.rSDate <> 0 then
   Generator.AddIntegerAtom(k2_tiStart, lRec^.rSDate);
  if lRec^.rEDate <> 0 then
   Generator.AddIntegerAtom(k2_tiFinish, lRec^.rEDate);

  if lRec^.rNum[1] <> ' ' then
   Generator.AddStringAtom(k2_tiNumber, ConvertArrayToStr(@lRec^.rNum, SizeOf(lRec^.rNum)));

  if lRec^.rIsNonPeriodic = 1 then
   Generator.AddBoolAtom(k2_tiIsPeriodic, False);

  if lRec^.rComment[1] <> ' ' then
   Generator.AddStringAtom(k2_tiComment, ConvertArrayToStr(@lRec^.rComment, SizeOf(lRec^.rComment)));

  if lRec^.rPages[1] <> ' ' then
   Generator.AddStringAtom(k2_tiPages, ConvertArrayToStr(@lRec^.rPages, SizeOf(lRec^.rPages)));

  if lRec^.rLinkComment[1] <> ' ' then
   Generator.AddStringAtom(k2_tiLinkComment, ConvertArrayToStr(@lRec^.rLinkComment, SizeOf(lRec^.rLinkComment)));

  if lRec^.rFlags <> 0 then
   Generator.AddIntegerAtom(k2_tiFlags, lRec^.rFlags);
 finally
  Generator.Finish;
 end;
end;

procedure TExportFilter.WriteHeaderData;

 procedure lLoadAttrData;
 var
  lTwoID     : array[0..1] of TDocID;
 begin
  fDocList := MakeValueSet(DocumentServer(fFamily).FileTbl, fId_Fld, @fCurDocID, 1);

  Assert((AddedDocID = 0) or (AddedAttrs <> []), 'TExportFilter.AddedDocID не задан');

  if AddedDocID > 0 then
  begin
   lTwoID[0] := fCurDocID;
   lTwoID[1] := AddedDocID;

   fExtDocList := MakeValueSet(DocumentServer(fFamily).FileTbl, fId_Fld, @lTwoID, 2);
  end
  else
   fExtDocList := fDocList;

  FreeAttrData;
  //GetLinkLists; //on demand 
 end;

begin
 if f_HeaderDone then Exit;     

 //Это если экспорт НЕ кучи документов,
 //ID каждого дока берем из потока и набираем для него атрибуты
 if SingleDocMode then
  lLoadAttrData;

 WriteAttributes(fDocPart);
 f_HeaderDone := True;
end;

procedure TExportFilter.WriteAttributes(aDocPartSel : TDocPartSelector);
var
 lExpDataSet : TdtAttributeSet;
 lPriority   : integer;

 procedure lAjustAttrCacheCursor;
 var
  lDocID      : TDocID;
  lRes        : Integer;
  lAttrCursor : PexpAttrCursor;
  I           : TExpAttrCache;
  lRec        : PAnsiChar;
 begin
  lDocID := GetSortDocID;

  if (lDocID = cUndefDocID) {or (lDocID = fAttrCacheDocID)} then Exit;
  //fAttrCacheDocID := lDocID;

  for I := Low(TExpAttrCache) to High(TExpAttrCache) do
   if (I in lExpDataSet) then
    with GetAttrData(I)^ do
    if rList <> nil then
    begin
     if SingleDocMode then //Это если экспорт НЕ кучи документов
     begin
      rOrgPos  := 0;
      rLastPos := Pred(rList.Count);
     end
     else
     begin
      if (rOrgPos >= 0) then
      begin
       lRec := rList.GetItem(rOrgPos);
       if (lRec <> nil) and (gDocComp(lRec, @lDocID) = 0) then
        // Курсор уже выставлен на lDocID, оставляем как есть
        Continue;
      end;

      lRec := rList.GetItem(Succ(rLastPos));
      if lRec <> nil then
       lRes := gDocComp(lRec, @lDocID)
      else
       lRes := -1;

      if lRes > 0 then //пустой список
       rOrgPos := -1
      else
      begin
       if lRes = 0 then
        rOrgPos := Succ(rLastPos)
       else
       begin
        // !! лишние fHLOrgPos - Succ(fHLLastPos) ссылок
        if not rList.Find(@gDocComp, @lDocID, Succ(rOrgPos), High(Longint), rOrgPos) then
        begin
         rOrgPos := -1;
         Continue;
        end;
       end;
       // последний для не SubAttr не считаем
       if (I in cSubDictExpData) or (I = atHLink) then
        rList.Find(@gDocComp, @lDocID, rOrgPos, High(Longint), rLastPos, True {aNeedLast});
      end;
     end;
    end; //with GetAttrData(I) do...
 end; //procedure lAjustAttrCacheCursor;

 procedure lWriteDocHeader; //(const aCardRec : TExpCardRec);
 var
  lStatusMask : Cardinal;
  lID         : TDocID;
  lDocRec     : TdtRecord;
 begin
  //Generator.AddIntegerAtom(k2_tiInternalHandle, fCurDocID);

  lDocRec := InitRecord(DocumentServer(fFamily).FileTbl);
  if not lDocRec.FindByUniq(fId_Fld, fCurDocID) then Exit;

  lID := LinkServer(fFamily).Renum.GetExtDocID(fCurDocID);
  if lID <> cUndefDocID then
   Generator.AddIntegerAtom(k2_tiExternalHandle, lID);

  Generator.AddIntegerAtom(k2_tiType, lDocRec.GetIntField(fType_Fld));
  //fCurDocType:=TDocType(lDocRec.InternalType);

  Generator.AddIntegerAtom(k2_tiUserType, lDocRec.GetIntField(fUserType_Fld));

  if (atShortName in lExpDataSet) then
   Generator.AddStringAtom(k2_tiShortName, lDocRec.GetStrField(fSName_Fld), AnsiCodePage);

  if (atFullName in lExpDataSet) then
   Generator.AddStringAtom(k2_tiName, lDocRec.GetStrField(fFName_Fld), AnsiCodepage);

  lStatusMask := High(lStatusMask) and not (dstatChargeFree or dstatNotTM);
  // - флагов много, но настраивается выливка только первых двух. Потому что недоделано
  if atPriceLevel in lExpDataSet then
   lStatusMask := lStatusMask or dstatChargeFree;
  if atNotTM in lExpDataSet then
   lStatusMask := lStatusMask or dstatNotTM;

  Generator.AddIntegerAtom(k2_tiPriceLevel, lDocRec.GetIntField(fStatus_Fld) and lStatusMask);

  if (atPriority in lExpDataSet) then
  begin
   lPriority := lDocRec.GetIntField(fPriority_Fld);
   if lDocRec.GetIntField(fPriorFlag_fld) = 0 then
    lPriority := -lPriority;
   Generator.AddIntegerAtom(k2_tiPriority, lPriority);
  end;

  if (atSortDate in lExpDataSet) then
   Generator.AddIntegerAtom(k2_tiSortDate, lDocRec.GetIntField(fSDate_Fld));

  if (atRelated in lExpDataSet) then
  begin
   lID := lDocRec.GetIntField(fRelated_Fld);
   if lID > 0 then
   begin
    Generator.AddIntegerAtom(k2_tiRelInternalHandle, lID);

    lID := LinkServer(fFamily).Renum.GetExtDocID(lID);
    if lID <> cUndefDocID then
     Generator.AddIntegerAtom(k2_tiRelExternalHandle, lID);
   end;
  end;

  if (atVerLink in lExpDataSet) then
  begin
   lID := lDocRec.GetIntField(fVerLink_Fld);
   if lID > 0 then
   begin
    Generator.AddIntegerAtom(k2_tiInternalVerLink, lID);

    lID := LinkServer(fFamily).Renum.GetExtDocID(lID);
    if lID <> cUndefDocID then
     Generator.AddIntegerAtom(k2_tiExternalVerLink, lID);
   end;
  end;

  if (atUrgency in lExpDataSet) then
   Generator.AddIntegerAtom(k2_tiUrgency, lDocRec.GetIntField(fUrgency_Fld));

  Generator.AddBoolAtom(k2_tiHasAnno, lDocRec.GetIntField(fHasAnno_Fld) > 0);

  if (atComment in lExpDataSet) then
   Generator.AddStringAtom(k2_tiNameComment, lDocRec.GetStrField(fComment_Fld), AnsiCodepage);
 end;

type
 TWriteAttrProc = procedure (aRec : PAnsiChar) of object;
var
 lDict         : TExpExtData;
 lRevisionDate : TStDate;

 lFullDateNum  : Boolean;
 lLogSet       : TLogActionSet;

 lPos          : LongInt;
 lRec          : PAnsiChar;
 lDocID        : TDocID;

 lWriteAttrProc : TWriteAttrProc;
begin
 case aDocPartSel of
  dpDoc :
   lExpDataSet := cDocExpData;
  dpSpr :
   lExpDataSet := cSprExpData;
  dpAnno :
   if SpecialAnnotation then
    lExpDataSet := cExtAnnoExpData
   else
    lExpDataSet := cAnnoExpData
 end;

 lExpDataSet := lExpDataSet * fAttributes;

 if NeedHeaderMainRec then
  lWriteDocHeader; //(fCardRec);

 lAjustAttrCacheCursor;

 lRevisionDate := 0;
 for lDict := Low(TExpExtData) to High(TExpExtData) do
 if //(fMode = emLoad) or // если emLoad валим все в main поток
    (lDict in lExpDataSet) then
  if lDict in cDictExpData then
   WriteLinkData(lDict, 0)
  else
  if lDict = atDateNums then
  begin
   with GetAttrData(atDateNums)^ do
   begin
    lPos := rOrgPos;
    if lPos < 0 then Continue;
    lRec := rList.GetItem(lPos);

    if Assigned(fTestAttrProc) then // смещаем rPos на первый подходящий
     while (lRec <> nil) and (SingleDocMode or (PexpDNDictRec(lRec)^.rDocID = GetSortDocID)) and
           not fTestAttrProc(atDateNums, lRec^) do
     begin
      if rLastPos < lPos then  // корректируем rLastPos для атрибутов, которым не выставили верхнюю границу
       rLastPos := lPos;
      Inc(lPos);
      lRec := rList.GetItem(lPos);
     end;

    if (lRec = nil) or not (SingleDocMode or (PexpDNDictRec(lRec)^.rDocID = GetSortDocID)) then Continue;

    Generator.StartTag(cAttr2k2Tag[atDateNums]);
    try
     Repeat
      if not Assigned(fTestAttrProc) or fTestAttrProc(atDateNums, lRec^) then
      begin
       Generator.StartChild(k2_typNumANDDate);
       try
        Generator.AddIntegerAtom(k2_tiType, Byte(PexpDNDictRec(lRec)^.rType));
        if PexpDNDictRec(lRec)^.rDate <> BlankDate then
         Generator.AddIntegerAtom(k2_tiStart, PexpDNDictRec(lRec)^.rDate);
        if PexpDNDictRec(lRec)^.rNum[1] <> ' ' then
         Generator.AddStringAtom(k2_tiNumber, ConvertArrayToStr(@PexpDNDictRec(lRec)^.rNum, SizeOf(TNumberStr)));


        if (PexpDNDictRec(lRec)^.rType = dnChangerDate) and (PexpDNDictRec(lRec)^.rLinkDocID <> cBlankDocID) then
        begin
         Generator.StartTag(k2_tiLinkAddress);
         try
          lDocID := PexpDNDictRec(lRec)^.rLinkDocID;
          if fReNum then
           lDocID := LinkServer(fFamily).Renum.GetExtDocID(lDocID);

          Generator.AddIntegerAtom(k2_tiDocID, lDocID);
          if PexpDNDictRec(lRec)^.rLinkSubID > 0 then
           Generator.AddIntegerAtom(k2_tiSubID, PexpDNDictRec(lRec)^.rLinkSubID);
         finally
          Generator.Finish;
         end;
        end;
       finally
        Generator.Finish;
       end;
      end;

      if rLastPos < lPos then  // корректируем rLastPos для атрибутов, которым не выставили верхнюю границу
       rLastPos := lPos;
      Inc(lPos);
      lRec := rList.GetItem(lPos);
     until (lRec = nil) or not (SingleDocMode or (PexpDNDictRec(lRec)^.rDocID = GetSortDocID));
    finally
     Generator.Finish;
    end;
   end; //with GetAttrData(atDateNums) do
  end
  else
  if lDict in [atOrdLogRecords, atJurLogRecords, atStages, atActiveIntervals, atAlarms, atCorrects, atPublisheds, atDoc2DocLink] then
  begin
   with GetAttrData(lDict)^ do
   begin
    lPos := rOrgPos;
    if lPos < 0 then Continue;
    lRec := rList.GetItem(lPos);

    if (lRec = nil) or not (SingleDocMode or (PDocID(lRec)^ = GetSortDocID)) then Continue;

    Generator.StartTag(cAttr2k2Tag[lDict]);
    try
     if lDict in [atOrdLogRecords, atJurLogRecords] then
     begin
      lRevisionDate := 0;
      case  aDocPartSel of
       dpDoc  : lLogSet := cDocLogActions;
       dpAnno : lLogSet := cAnnoLogActions;
      end;

      repeat
       with PImpExLogRec(lRec)^ do
       begin
        if lRevisionDate < rDate then
         lRevisionDate := rDate;
        //*Log
        if //(fMode = emLoad) or // если emLoad валим все логи в main поток
           (rAction in lLogSet) then
        begin
        Generator.StartChild(k2_typLogRecord);
        try
         Generator.AddIntegerAtom(k2_tiType, Byte(rAction));
         Generator.AddIntegerAtom(k2_tiStart, rDate);

         //if aDocPartSel = dpDoc then
         begin
          Generator.AddIntegerAtom(k2_tiTime, rTime);
          Generator.StartTag(k2_tiUser);
          try
           Generator.AddIntegerAtom(k2_tiHandle, Integer(rAuthor));
          finally
           Generator.Finish;
          end;
         end;
        finally
         Generator.Finish;
        end;
       end;
       end; //*Log

       if rLastPos < lPos then  // корректируем rLastPos для атрибутов, которым не выставили верхнюю границу
        rLastPos := lPos;
       Inc(lPos);
       lRec := rList.GetItem(lPos);
      until (lRec = nil) or not (SingleDocMode or (PDocID(lRec)^ = GetSortDocID));

      if (lDict = atOrdLogRecords) and (fMode = emExport) and (aDocPartSel = dpDoc) and (lRevisionDate <> 0) then
      begin
       Generator.StartChild(k2_typLogRecord);
       try
        Generator.AddIntegerAtom(k2_tiType, Byte(acRevision));
        Generator.AddIntegerAtom(k2_tiStart, lRevisionDate);
        Generator.AddIntegerAtom(k2_tiTime, MaxTime); //влияет на сортировку
       finally
        Generator.Finish;
       end;
      end;
     end
     else // if lDict = atLogRecords then...
     begin
      case lDict of
       atStages          : lWriteAttrProc := WriteCurStage;
       atActiveIntervals : lWriteAttrProc := WriteCurActive;
       atAlarms          : lWriteAttrProc := WriteCurAlarm;
       atCorrects        : lWriteAttrProc := WriteCurCheck;
       atPublisheds      : lWriteAttrProc := WriteCurPublish;
       atDoc2DocLink     : lWriteAttrProc := WriteCurDoc2DocLink;
      end; //case lDict of
      repeat
       lWriteAttrProc(lRec);
       if rLastPos < lPos then  // корректируем rLastPos для атрибутов, которым не выставили верхнюю границу
        rLastPos := lPos;
       Inc(lPos);
       lRec := rList.GetItem(lPos);
      until (lRec = nil) or not (SingleDocMode or (PDocID(lRec)^ = GetSortDocID));

     end; // if lDict = atLogRecords...
    finally
     Generator.Finish;
    end;
   end;
  end;
end;

procedure TExportFilter.WriteLinkData(aDict : TExpDictData; aSubID : TSubID);
var
 lRec        : PexpOrdAttr;
 lPos        : LongInt;

 lIsSubAttr  : Boolean;
 lDictList   : Tl3InterfaceList;
begin
 lIsSubAttr := (aDict in cSubDictExpData);

 with GetAttrData(aDict)^ do
 begin
  if rOrgPos < 0 then Exit;

  lPos := rOrgPos;
  if lIsSubAttr and (aSubID <> 0) then
   if not rList.Find(@gSubIDComp, @aSubID, rOrgPos, rLastPos, lPos) then
    lPos := -1;

  if lPos < 0 then Exit;
  lRec := rList.GetItem(lPos);

  if (lRec <> nil) and
     (
     (SingleDocMode or (lRec.rDocID = fCurDocID)) and (not lIsSubAttr or (lRec.rSubID = aSubID))
     or
     ((fDocPart = dpSpr) and (lRec.rDocID = GetSortDocID))
     ) then
  begin
   Generator.StartTag(cAttr2k2Tag[aDict]);
   try
    lDictList := DictLists[AttrID2DLType(aDict)];
    repeat
     Generator.StartChild(k2_typDictItem);
     try
      Generator.AddIntegerAtom(k2_tiHandle, lRec.rDictID);
      if fNeedDictNames then
      begin
       // Не уверен, что это правильно, но лучше, чем ничего (Д. Дудко)
       if lRec.rDictID < lDictList.Count then
       begin
        if lDictList.Items[lRec.rDictID] <> nil then
        begin
         if (aDict in [atBases, atAccGroups]) then
          Generator.AddStringAtom(k2_tiShortName, Il3CString(lDictList.Items[lRec.rDictID]).AsWStr)
         else
          Generator.AddStringAtom(k2_tiName, Il3CString(lDictList.Items[lRec.rDictID]).AsWStr);
        end
        else
         l3System.Msg2Log('Отсутствует имя у элемента %d словаря %s', [lRec.rDictID, GetEnumName(TypeInfo(TdaDictionaryType), Ord(AttrID2DLType(aDict)))], l3_msgLevel2);
       end
       else
        l3System.Msg2Log('Несуществующий элемент %d из %d словаря %s', [lRec.rDictID, lDictList.Count, GetEnumName(TypeInfo(TdaDictionaryType), Ord(AttrID2DLType(aDict)))], l3_msgLevel2);
      end;
     finally
      Generator.Finish;
     end;

     if rLastPos < lPos then  // корректируем rLastPos для атрибутов, которым не выставили верхнюю границу
      rLastPos := lPos;

     Inc(lPos);
     lRec := rList.GetItem(lPos);
    until not ((lRec <> nil) and
              (
               (SingleDocMode or (lRec.rDocID = fCurDocID)) and (not lIsSubAttr or (lRec.rSubID = aSubID))
               or
               ((fDocPart = dpSpr) and (lRec.rDocID = GetSortDocID))
              ));
   finally
    Generator.Finish;
   end;
  end;
 end;
end;

procedure TExportFilter.WriteAttrOfSub(aSubID : TSubID);
var
 lDict : TExpExtData;
 lExpDataSet : TdtAttributeSet;
begin
 if (aSubID <> 0) and (fDocPart <> dpDoc) then Exit;

 lExpDataSet := cSubDictExpData * fAttributes;

 for lDict := Low(TExpExtData) to High(TExpExtData) do
  if lDict in lExpDataSet then
   WriteLinkData(lDict, aSubID);
end;

procedure TExportFilter.WriteHLAddr(aHLinkID : LongInt);
var
 lRec        : PexpHyperLinkRec;
 lPos        : Longint;

 lAttrCursor : PexpAttrCursor;
 lDocID      : TDocID;
 lOutDocID   : TDocID;

begin
 if not (fDocPart in [dpDoc, dpSpr]) then Exit;

 lAttrCursor := GetAttrData(atHLink);

 if lAttrCursor.rList = nil then
  Exit;

 lDocID := GetSortDocID;

 with lAttrCursor^ do
  if (rOrgPos >= 0) and
     rList.Find(@gIDHLComp, @aHLinkID, rOrgPos, rLastPos, lPos) then
  begin
   lRec := rList.GetItem(lPos);
   while (lRec <> nil) and (lRec.rDocID = lDocID) and (lRec.rID = aHLinkID) do
   begin
    if (lRec.rDDocID <> cUndefDocID) then
    begin
     f_HLAdded := True;
     Generator.StartChild(k2_typAddress);
     try
      lOutDocID := lRec.rDDocID;
      if lOutDocID = 0 then
       lOutDocID := fCurDocID;

      if fReNum then lOutDocID := fReNumTbl.GetExtDocID(lOutDocID);

      Generator.AddIntegerAtom(k2_tiDocID, lOutDocID);
      Generator.AddIntegerAtom(k2_tiSubID, lRec.rDSubID);
     finally
      Generator.Finish;
     end;
    end
    else
     l3System.Msg2Log(rsWrongDocID, [lRec.rDocID, aHLinkID], l3_msgLevel2);
    Inc(lPos);
    lRec := rList.GetItem(lPos);
   end;
  end;
end;

procedure TExportFilter.SetCurDocID(aValue : TDocID);
begin
 if fCurDocID <> aValue then
 begin
  fCurDocID := aValue;
  //LoadHeaderData;

  // MainRecord грузим сразу т к InternalType нужен
  (*
  if (fCurDocID <> cUndefDocID) and NeedHeaderMainRec and (fDocPart <> dpSpr) then
  begin
   DocumentServer(fFamily).FileTbl.GetExpCard(fCurDocID, @fCardRec);
   {$IFDEF Debug}
   l3System.Msg2Log('%s', [ClassName]);
   {$ENDIF}
  end
  {$IFDEF Debug}
  else
   l3System.Msg2Log('%s - skipped', [ClassName]);
  {$ENDIF}
  *)
 end;
end;

procedure TExportFilter.AddAtomEx(AtomIndex : Long; const Value : Tk2Variant);
var
 TmpHL      : LongInt;
 TmpSub     : TSubID;
 CurTopType : Tk2Type;
 lTwoID     : array[0..1] of TDocID;
begin
 if Not fFiltredFlag then
  begin
   FilterDocHeader(AtomIndex, Value);
   //Generator.AddAtomEx(AtomIndex,Value);
   Case AtomIndex of
    k2_tiInternalHandle :
     if TopType[0].IsKindOf(k2_typDocument) then
     begin
      if (Value.Kind = k2_vkInteger) then
       SetCurDocID(TDocID(Value.AsInteger))
      else
       ConvertErrorEx(Value.Kind);
     end;

    k2_tiType :
     if TopType[0].IsKindOf(k2_typDocument) or TopType[0].IsKindOf(k2_typDictEntry) then
     begin
      if (Value.Kind=k2_vkInteger) then
      begin
       //TDocType(fCardRec.InternalType) := TDocType(Value.AsInteger);
       case  TDocType(Value.AsInteger) of
        dtRelText     : DocPart := dpSpr;
        dtAnnotation  : DocPart := dpAnno;
        //else            DocPart := dpDoc;
       end; //case
      end
      else
       ConvertErrorEx(Value.Kind)
     end;
    //k2_tiPriceLevel :;
    k2_tiHandle :
     if TopType[0].IsKindOf(k2_typHyperLink) then
     begin
      if (Value.Kind = k2_vkInteger) then
       begin
        f_CurHL := Longint(Value.AsInteger);
        if fDocPart <> dpAnno then  //ссылки в аннотации в таблицах не хранятся
         WriteHLAddr(f_CurHL);
       end
      else
       ConvertErrorEx(Value.Kind);
     end
     else
     begin
      CurTopType := TopType[0];
      if CurTopType.IsKindOf(k2_typSub) and
         not CurTopType.IsKindOf(k2_typDocumentSub) and
         not CurTopType.IsKindOf(k2_typDocument) and
         not CurTopType.IsKindOf(k2_typBookmark) then
       begin
        if (Value.Kind = k2_vkInteger) then
         begin
          TmpSub := TSubID(Value.AsInteger);
          WriteAttrOfSub(TmpSub);
         end
        else
         ConvertErrorEx(Value.Kind);
       end;
     end;
   end;
  end
 else
 if not f_HLAdded and TopType[0].IsKindOf(k2_typAddress) and TopType[1].IsKindOf(k2_typHyperlink) then
  case AtomIndex of
   k2_tiDocID:
    begin
     if (Value.Kind = k2_vkInteger) then
      THLA(HLAddresses.Last).rDocID := TDocID(Value.AsInteger)
     else
      ConvertErrorEx(Value.Kind);
    end;
   k2_tiSubID:
    begin
     if (Value.Kind = k2_vkInteger) then
      THLA(HLAddresses.Last).rSubID := TDocID(Value.AsInteger)
     else
      ConvertErrorEx(Value.Kind);
    end;
  end;
end;

procedure TExportFilter.StartTag(TagID : Long);
begin
 Inherited;
 Generator.StartTag(TagID);
end;

procedure TExportFilter.StartChild(TypeID : Tl3VariantDef);
var
 l_A: THLA;
begin
 Inherited;

 //Первый параграф или блок/саб
 //пора сливать атрибуты заголовка
 if not f_HeaderDone and
   (CurrentType.IsKindOf(k2_typSub, [k2_typDocument, k2_typDocumentSub])
   or
   CurrentType.IsKindOf(k2_typPara, [k2_typDocument])) then
 begin
  WriteHeaderData;
 end;

 if TopType[0].IsKindOf(k2_typDocument) then
 begin
  f_TotalLinks := 0;
  f_RestoredLinks := 0;
  f_HeaderDone := False;
  {!!!!}
  (*
  if TopType[0].IsKindOf(k2_typDictEntry) then
   fDocPart := dpDoc // dtDictEntry
  else
  if TopType[0].IsKindOf(k2_typAnnoTopic) then
   fDocPart := dpAnno;
  {!!!!}
  *)
 end; // TopType[0].IsKindOf(k2_typDocument) or TopType[0].IsKindOf(k2_typDictEntry)

 if TopType[0].IsKindOf(k2_typHyperLink) then
 begin
  f_HLAdded := False;
  HLAddresses.Clear;
  f_CurHL := -1;
 end;

 if TopType[0].IsKindOf(k2_typAddress) and
    TopType[1].IsKindOf(k2_typHyperLink) then
 begin
  fFiltredFlag:=True;

  if not f_HLAdded then
  begin
   l_A := THLA.Create;
   try
    HLAddresses.Add(l_A);
   finally
    l3Free(l_A);
   end;
  end;
 end;

 if Not fFiltredFlag then Generator.StartChild(TypeID);
end;

procedure TExportFilter.CloseStructure(NeedUndo : Boolean);
var
 i: Integer;
begin
 try
  // это на случай если ни одного параграфа/саба/блока в доке нет
  if TopType[0].IsKindOf(k2_typDocument) or TopType[0].IsKindOf(k2_typDictEntry) then
   begin
     // это на случай если ни одного параграфа/саба/блока в доке нет
     WriteHeaderData;

    if (f_RestoredLinks > 0) and (fDocPart <> dpAnno) then
     l3System.Msg2Log(rsRestoredLinksReport, [fCurDocID, f_TotalLinks, f_RestoredLinks], l3_msgLevel2);
    NextDocument;
    Generator.Finish;
   end
  else
  if TopType[0].IsKindOf(k2_typHyperlink) then
  begin
   Inc(f_TotalLinks);
   if not f_HLAdded then
   begin
    Inc(f_RestoredLinks);
    // Добавляем накопленные адреса
    for i:= 0 to HLAddresses.Hi do
     with THLA(HLAddresses.Items[i]) do
     begin
      if fReNum then rDocID := fReNumTbl.GetExtDocID(rDocID);
      if rDocID <> cUndefDocID then
      begin
       Generator.StartChild(k2_typAddress);
       try
        Generator.AddIntegerAtom(k2_tiDocID, rDocID);
        Generator.AddIntegerAtom(k2_tiSubID, rSubID);
       finally
        Generator.Finish;
       end; // try..finally
      end
      else
       l3System.Msg2Log(rsWrongDocID, [fCurDocID, f_CurHL], l3_msgLevel2);

      if fDocPart = dpAnno then
       l3System.Msg2Log(SysUtils.Format(rsRestoredLink, [fCurDocID, f_CurHL, rDocID, rSubID]), l3_msgLevel2);
     end; // with THLA(HLAddresses.Items[i]) do
   end;
   Generator.Finish;
   HLAddresses.Clear;
   f_HLAdded := False;
  end
  else
   if TopType[0].IsKindOf(k2_typAddress) and
      TopType[1].IsKindOf(k2_typHyperLink) then
    fFiltredFlag:=False
   else
    Generator.Finish;
 finally
  Inherited;
 end;
end;

procedure TExportFilter.OpenStream;
begin
 inherited;
 //Это если экспорт кучи документов
 if not SingleDocMode then
 begin
  DocumentServer(fFamily).Family := fFamily;
  fDocList := fDocGenerator.DocIDList;
  //fDocList.ValuesOfKey(docIdFld);

  fExtDocList := nil;
  //GetLinkLists;
 end;

 CheckRefreshDicts;

 if fReNum then
  fReNumTbl.Buffered := True;
 fFiltredFlag := False;
 f_HLAdded := False;
end;

procedure TExportFilter.CloseStream(NeedUndo : Boolean);
begin
 FreeAttrData;
 if fReNum then fReNumTbl.Buffered := False;
 CheckRefreshDicts;
 inherited;
 SetCurDocID(cUndefDocID);
end;

procedure TExportFilter.dcn_DictionaryChange(const Info : TDictMessageRec);
begin
 if (Info.DictType in sNotExportedNames) then Exit;

 if (Info.Operation in [atAdd,atDelete,atEdit]) then
  if fDictLoaded[Info.DictType] then
   fNeedDictReload[Info.DictType] := True;
end;

procedure TExportFilter.CheckRefreshDicts;
var
 lID : TdaDictionaryType;
begin
 for lID := Low(TdaDictionaryType) to High(TdaDictionaryType) do
  if fNeedDictReload[lID] and fDictLoaded[lID] then
  begin
   fDictLists[lID].Clear;
   fDictLoaded[lID] := False;
   fNeedDictReload[lID] := False;
  end;
end;

function TExportFilter.GetDoc2DocSab: ISabCursor;
var
 lSab : ISab;
begin
 if SingleDocMode and (atDoc2DocLink in AddedAttrs) then
  lSab := MakeSabCopy(fExtDocList)
 else
  lSab := MakeSabCopy(fDocList);

 lSab.RecordsByKey(lnkDocIDFld, MakePhoto(LinkServer(fFamily)[atDoc2DocLink]));

 lSab.Sort([lnkDocIDFld, lddLinkTypeFld]);
 lSab.Flush;
 Result := lSab.MakeSabCursor([lnkDocIDFld, lddLinkTypeFld, lddLinkedDocFld], cmForward, ROPEN_READ);
end;

procedure TExportFilter.FilterDocHeader(AtomIndex : Long; const Value :
    Tk2Variant);
var
 l_TranslateAtom: Boolean;
 lStatusMask: long;
begin
 l_TranslateAtom:= True;
 if CurrentType.IsKindOf(k2_typDocument) then
  case AtomIndex of
   k2_tiShortName : l_TranslateAtom:= (atShortName in Attributes);
   k2_tiName      : l_TranslateAtom:= (atFullName in Attributes);
   k2_tiPriceLevel:
    begin
     // Битовые игры
     lStatusMask := Value.AsInteger;
     if not (atPriceLevel in Attributes) then
      lStatusMask := lStatusMask and not dstatChargeFree;
     if not (atNotTM in Attributes) then
      lStatusMask := lStatusMask and not dstatNotTM;
     l_TranslateAtom := false; //сами вызовем Generator.AddAtomEx

     if lStatusMask <> 0 then
      Generator.AddIntegerAtom(AtomIndex, lStatusMask);
    end;
   k2_tiPriority: l_TranslateAtom:= (atPriority in Attributes);
   k2_tiSortDate: l_TranslateAtom:= (atSortDate in Attributes);
   k2_tiRelInternalHandle: l_TranslateAtom:= (atRelated in Attributes);
   k2_tiRelExternalHandle: l_TranslateAtom:= (atRelated in Attributes);
   k2_tiInternalVerLink: l_TranslateAtom:= (atVerLink in Attributes);
   k2_tiExternalVerLink: l_TranslateAtom:= (atVerLink in Attributes);
   k2_tiUrgency: l_TranslateAtom:=  (atUrgency in Attributes);
   k2_tiNameComment: l_TranslateAtom:=  (atComment in Attributes);
  end;
 if l_TranslateAtom then
  Generator.AddAtomEx(AtomIndex, Value);
end;

function  TExportFilter.GetHLAddresses : Tl3ObjectRefList;
begin
 if f_HLAddresses = nil then
  f_HLAddresses := Tl3ObjectRefList.Make;
 Result := f_HLAddresses;
end;

procedure TExportFilter.WriteCurDoc2DocLink(aD2DRec : PAnsiChar);
var
 l_D2DRec : PDoc2DocRec;
begin
 l_D2DRec :=PDoc2DocRec(aD2DRec);
 Generator.StartChild(k2_typAddress);
 try
  Generator.AddIntegerAtom(k2_tiType,  l_D2DRec^.rLinkType);
  Generator.AddIntegerAtom(k2_tiDocID, LinkServer(fFamily).Renum.GetExtDocID(l_D2DRec^.rLinkedDocID));
 finally
  Generator.Finish;
 end;
end;

class function TExportFilter.SetTo(var theGenerator : Tk2TagGenerator;
                                   aDocFamily   : TdaFamilyID;
                                   aDocID       : TDocID;
                                   aNeedHeaderMainRec : Boolean = false;
                                   aNeedDictNames : Boolean = True;
                                   aMode : TFilterMode = emExport;
                                   aDocPart : TDocPartSelector = dpDoc): TExportFilter;
begin
 Result := TExportFilter(inherited SetTo(theGenerator));
 with (TExportFilter(Result)) do
 begin
  Init(aDocFamily,  aNeedHeaderMainRec);
  SetCurDocID(aDocID);
  NeedDictNames := aNeedDictNames;
  Mode := aMode;
  DocPart := aDocPart;
 end;
end;

class procedure TExportFilter.SetTo(var theGenerator : Ik2TagGenerator;
                                   aDocFamily   : TdaFamilyID;
                                   aDocID       : TDocID;
                                   aNeedHeaderMainRec : Boolean = false;
                                   aNeedDictNames : Boolean = True;
                                   aMode : TFilterMode = emExport);
var
 lFilter : TExportFilter;
begin
 lFilter := Create(aDocFamily);
 try
  lFilter.Generator := theGenerator;
  theGenerator := lFilter;

  with lFilter do
  begin
   Init(aDocFamily,  aNeedHeaderMainRec);
   SetCurDocID(aDocID);
   NeedDictNames := aNeedDictNames;
   Mode := aMode;
  end;
 finally
  l3Free(lFilter);
 end;//try..finally
end;

function  L2TestNeedAttributeRecProc(Action: Pointer): TTestNeedAttributeRecProc; register;
asm
          jmp  l3LocalStub
end;{asm}

procedure FreeTestNeedAttributeRecProc(var Stub: TTestNeedAttributeRecProc); register;
asm
          jmp  l3FreeLocalStub
end;{asm}

end.
