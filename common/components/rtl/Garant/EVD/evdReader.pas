unit evdReader;
{* Читатель тегов в формате evd. }

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evdReader - разборщик текстов в формате evd }
{ Начат: 05.10.1999 13:53 }
{ $Id: evdReader.pas,v 1.94 2015/10/15 11:32:34 lulin Exp $ }

// $Log: evdReader.pas,v $
// Revision 1.94  2015/10/15 11:32:34  lulin
// - при чтении из NSRC преобразуем формулы обратно в юникод.
//
// Revision 1.93  2015/10/14 15:32:24  lulin
// - заготовочка.
//
// Revision 1.92  2015/05/21 11:19:12  lulin
// - развязываем зависимости.
//
// Revision 1.91  2015/05/19 16:09:10  lulin
// - чистим код.
//
// Revision 1.90  2015/05/19 15:57:41  lulin
// - чистим код.
//
// Revision 1.89  2015/05/19 15:45:34  lulin
// - чистим код.
//
// Revision 1.88  2014/07/11 15:24:49  lulin
// - учимся читать задания из EVD.
//
// Revision 1.87  2014/07/11 14:46:45  lulin
// - заворачиваем SourceFiles в теги.
//
// Revision 1.86  2014/05/14 13:11:44  lulin
// {RequestLink:517789752}.
//
// Revision 1.85  2014/04/09 15:45:01  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.84  2014/04/03 17:10:37  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.83  2014/03/27 14:20:05  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.82  2013/10/21 15:43:12  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.81  2013/10/21 10:31:00  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.80  2013/10/18 14:11:31  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.79  2013/04/08 10:16:40  lulin
// - портируем.
//
// Revision 1.78  2013/04/04 11:21:18  lulin
// - портируем.
//
// Revision 1.77  2013/02/18 14:12:05  lulin
// - bug fix: при выливки картинок иногда ездили по памяти.
//
// Revision 1.76  2012/11/01 09:42:50  lulin
// - забыл точку с запятой.
//
// Revision 1.75  2012/11/01 07:44:53  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.74  2012/04/20 14:56:46  lulin
// {RequestLink:283610570}
//
// Revision 1.73  2011/10/06 10:25:46  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=289933137
// - чиним тот случай, когда имя свойства определялось, как ключевое слово.
//
// Revision 1.72  2010/06/28 15:28:13  dinishev
// [$220202662]
//
// Revision 1.71  2010/06/22 09:22:55  oman
// - fix: {RequestLink:219123106}
//
// Revision 1.70  2010/06/21 08:47:12  lulin
// {RequestLink:219121488}.
// - bug fix: в режиме ForceBinary не учитывали, что к нам таки может приехать небинарный заголовок EVD.
//
// Revision 1.69  2010/06/18 14:49:06  lulin
// {RequestLink:182452717}.
// - теперь про версию формата знает любой генератор из цепочки.
//
// Revision 1.68  2010/06/18 14:04:05  lulin
// {RequestLink:182452717}.
// - меняем способ нумерования версий. Теперь версии нумеруем с шагом 20. 0-е - это Архивариус, 1-е - это F1.
//
// Revision 1.67  2010/06/18 11:41:09  lulin
// {RequestLink:219119831}.
// - правим ошибку.
// - добавляем тест.
// - давим вывод в лог.
// - вставляем проверку на корректность длины результирующей строки.
//
// Revision 1.66  2010/06/10 11:35:31  lulin
// {RequestLink:159355611}.
//
// Revision 1.65  2010/01/28 14:12:36  dinishev
// Если не смогли прочитать документ - честно сообщаем об этом, а не пытаемся его перечитать, как текстовый.
//
// Revision 1.64  2010/01/21 06:51:57  dinishev
// [$178324283]
//
// Revision 1.63  2010/01/19 10:37:59  dinishev
// [$178324283]
//
// Revision 1.62  2010/01/18 07:36:38  dinishev
// [$178324283]
//
// Revision 1.61  2009/12/14 11:46:53  lulin
// - готовимся к возврату более простых строк.
//
// Revision 1.60  2009/08/07 10:08:27  lulin
// - ищем и 135-ю версию тоже.
//
// Revision 1.59  2009/08/07 09:48:18  lulin
// {RequestLink:159353531}. Добавляем задание даты.
//
// Revision 1.58  2009/08/07 09:28:16  lulin
// {RequestLink:159353531}.
//
// Revision 1.57  2009/08/07 05:37:38  dinishev
// [$159352877]. Убираем define
//
// Revision 1.56  2009/08/06 11:34:09  dinishev
// http://mdp.garant.ru/pages/viewpage.action?pageId=159352877&focusedCommentId=159353599#comment-159353599
//
// Revision 1.55  2009/08/05 11:46:36  dinishev
// [$159352877]. Упрощаем условие.
//
// Revision 1.54  2009/08/05 11:27:20  dinishev
// [$159352877]. Не сбрасываем флаг.
//
// Revision 1.53  2009/08/05 09:38:58  dinishev
// [$159352877]
//
// Revision 1.52  2009/08/05 08:16:46  dinishev
// Очередные манипуляции с датой и рамками.
//
// Revision 1.51  2009/08/04 08:46:02  dinishev
// Bug fix: не прекращаем загрузку из-за ошибки преобразования даты.
//
// Revision 1.50  2009/07/30 16:43:18  lulin
// - думаем о генерации кусков StdRes.
//
// Revision 1.49  2009/07/30 08:05:56  lulin
// - правим замечания от Вована - [$158795057].
//
// Revision 1.48  2009/07/29 16:09:09  lulin
// {RequestLink:158336759}. Bug fix: портились рамки таблиц в F1.
//
// Revision 1.47  2009/07/29 15:35:22  lulin
// {RequestLink:158336759}.
//
// Revision 1.46  2009/07/22 06:59:54  lulin
// - исправляем SBS на этапе чтения.
//
// Revision 1.45  2009/07/03 16:24:09  lulin
// - шаг к переходу от интерфейсов к объектам.
//
// Revision 1.44  2009/03/04 13:33:09  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.43  2009/01/11 11:19:32  lulin
// - борьба с битыми EVD.
//
// Revision 1.42  2008/06/19 12:55:26  lulin
// - переименованы константы.
//
// Revision 1.41  2008/02/26 12:42:01  lulin
// - <K>: 85168943. Не открывались непакованные файлы, вылитые из F1.
//
// Revision 1.40  2008/02/20 17:23:05  lulin
// - упрощаем строки.
//
// Revision 1.39  2008/02/19 18:48:17  lulin
// - удалены ненужные классы.
//
// Revision 1.38  2008/02/07 19:13:13  lulin
// - избавляемся от излишне универсальных методов базовых списков.
//
// Revision 1.37  2008/02/06 11:44:39  lulin
// - список строк переехал в отдельный файл.
//
// Revision 1.36  2007/09/07 13:07:54  lulin
// - bug fix: была возможность прочитать текстовый EVD в неверной кодировке.
//
// Revision 1.35  2007/09/06 12:46:25  lulin
// - не выводим лишнее вообщение в лог.
//
// Revision 1.34  2007/08/30 15:00:43  lulin
// - bug fix: не проверяли конец файла.
//
// Revision 1.33  2007/08/30 12:19:06  lulin
// - cleanup.
//
// Revision 1.32  2007/08/30 10:46:04  lulin
// - bug fix: Немезис падал на чтении комментариев (CQ OIT5-26547).
//
// Revision 1.31  2007/08/29 18:24:43  lulin
// - bug fix: неверно читали кодировку.
//
// Revision 1.30  2007/08/29 17:05:04  lulin
// - записываем короткую кодировку, если это возможно.
//
// Revision 1.29  2007/08/29 16:51:42  lulin
// - распиливаем чтение строк.
//
// Revision 1.28  2007/08/29 15:04:50  lulin
// - страхуемся от попытки чтнения неверного формата.
//
// Revision 1.27  2007/08/29 14:52:33  lulin
// - не пишем информацию о текстовых скобках.
//
// Revision 1.26  2007/08/29 14:27:02  lulin
// - пакуем EVD-теги - вместо слова, пишем байт.
//
// Revision 1.25  2007/08/29 13:10:24  lulin
// - cleanup.
//
// Revision 1.24  2007/08/29 12:58:05  lulin
// - прячем устаревшую константу.
//
// Revision 1.23  2007/08/29 12:37:08  lulin
// - файл версий переехал в правильную папку.
//
// Revision 1.22  2007/08/29 12:00:33  lulin
// - константы распилены на два файла.
//
// Revision 1.21  2007/08/29 08:57:00  lulin
// - bug fix: AV при чтении бинарного EVD (CQ OIT5-26523).
//
// Revision 1.20  2007/08/28 19:58:51  lulin
// - выделяем метод.
//
// Revision 1.19  2007/08/28 19:52:19  lulin
// - выделяем метод.
//
// Revision 1.18  2007/08/28 19:39:18  lulin
// - не достаем парсер из свойства по нескольку раз.
//
// Revision 1.17  2007/08/28 18:33:16  lulin
// - уменьшаем число передаваемых параметров - чтобы влезали в регистры.
//
// Revision 1.16  2007/08/28 17:56:10  lulin
// - для чтения целых значений используем таблицу переходов.
//
// Revision 1.15  2007/08/28 17:07:10  lulin
// - оптимизируем загрузку строк.
//
// Revision 1.14  2007/08/28 16:25:12  lulin
// - не поддерживаем чтение очень старых версий EVD.
//
// Revision 1.13  2007/08/28 15:27:07  lulin
// - cleanup.
//
// Revision 1.12  2007/08/28 14:27:00  lulin
// - поднимаем исключение, если считано меньше, чем просили.
//
// Revision 1.11  2007/08/28 12:59:02  lulin
// - лишний раз не получаем файлер.
// - оптимизируем процедуру чтения файлера.
//
// Revision 1.10  2007/08/14 13:27:57  lulin
// - убираем лишнюю буферизацию.
//
// Revision 1.9  2007/08/14 13:15:42  lulin
// - cleanup.
//
// Revision 1.8  2007/08/10 19:17:24  lulin
// - cleanup.
//
// Revision 1.7  2007/08/09 18:05:28  lulin
// - избавляемся от излишнего использования интерфейсов, т.к. переносимость может быть достигнута другими методами.
//
// Revision 1.6  2007/08/09 11:19:25  lulin
// - cleanup.
//
// Revision 1.5  2006/11/25 16:50:30  lulin
// - удалена запись,чтение маски заполненных тегов.
//
// Revision 1.4  2006/09/19 12:25:58  lulin
// - переформатировал текст.
//
// Revision 1.3  2006/01/27 11:00:49  lulin
// - bug fix: при выравнивании куска пямяти не читался EVD, т.к. в конце был мусор (CQ OIT5-19345).
//
// Revision 1.2  2006/01/16 16:41:41  lulin
// - сделана возможность работать со строками без теговых оберток (почему-то на производительность не повлияло).
//
// Revision 1.1  2005/07/21 12:21:30  lulin
// - читатель формата EVD переехал в папку EVD.
//
// Revision 1.81.4.6  2005/07/21 11:41:18  lulin
// - убраны лишние зависимости.
//
// Revision 1.81.4.5  2005/07/21 11:34:22  lulin
// - выделена процедура чтения из текстового файла.
//
// Revision 1.81.4.4  2005/06/23 13:08:23  lulin
// - файл с ключевыми словами переехал в папку EVD.
//
// Revision 1.81.4.3  2005/06/23 12:55:33  lulin
// - файл с константами переехал в папку EVD.
//
// Revision 1.81.4.2  2005/06/22 17:14:51  lulin
// - cleanup.
//
// Revision 1.81.4.1  2005/05/18 12:42:46  lulin
// - отвел новую ветку.
//
// Revision 1.80.2.2  2005/05/18 12:32:08  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.80.2.1  2005/04/28 09:18:29  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.80.4.1  2005/04/26 16:07:07  lulin
// - уменьшаем число лишних вызовов.
//
// Revision 1.81  2005/04/28 15:03:37  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.80.4.1  2005/04/26 16:07:07  lulin
// - уменьшаем число лишних вызовов.
//
// Revision 1.80  2005/03/28 11:32:07  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.79  2005/03/21 10:04:49  lulin
// - new interface: _Ik2Type.
//
// Revision 1.78  2004/10/20 10:40:36  lulin
// - new behavior: увеличиваем частоту использования пула объектов.
//
// Revision 1.77  2004/10/14 08:54:57  lulin
// - new behavior: теперь комментарии синхронизируются между различными окнами.
//
// Revision 1.76  2004/09/27 10:58:21  lulin
// - new behavior: пытаемся сосстановить битый файл.
//
// Revision 1.75  2004/09/21 12:55:40  lulin
// - Release заменил на Cleanup.
//
// Revision 1.74  2004/08/03 12:49:30  law
// - bug fix: некорректно читался документ с комментариями (CQ OIT5-8367).
//
// Revision 1.73  2004/06/10 13:04:39  law
// - new property: TevCustomEvdStorageWriter.AccessByIndex.
//
// Revision 1.72  2004/06/02 15:12:07  law
// - конструкторы Make перенесены с _Tl3PVList на _Tl3PtrRecList.
//
// Revision 1.71  2004/05/31 10:31:06  law
// - код вынесен по define.
//
// Revision 1.70  2004/05/14 17:26:59  law
// - remove unit: evStrGen.
//
// Revision 1.69  2004/05/14 16:22:57  law
// - remove class: TevTextObjectGenerator.
// - remove class: TevTextObjectParser.
//
// Revision 1.68  2004/04/26 14:28:16  law
// - new behavior: Tl3Filer теперь при чтении посимвольно учитывает кодировку.
// - bug fix: в свойство TevMemo.Buffer теперь нормально присваиваются строки с кодировкой Unicode.
//
// Revision 1.67  2004/03/31 17:59:26  law
// - bug fix: корректно пишем/читаем Unicode-строки в бинарный EVD.
//
// Revision 1.66  2003/12/26 13:38:26  law
// - bug fix: другая (более успешная попытка) попытка починить ошибку CQ OIT5-4532.
//
// Revision 1.65  2003/12/26 12:49:28  law
// - bug fix: попытка починить ошибку CQ OIT5-4532.
//
// Revision 1.64  2003/12/03 13:16:53  law
// - new method: Tk2TagGenerator.SetTo - для облегчения связывания генераторов в цепочки.
//
// Revision 1.63  2003/12/01 12:39:10  law
// - new method: TeeHyperlinkFilter.SetFilter.
// - new method: TevCustomEvdReader.SetReader.
// - new field: TeeAddress.rRevision.
//
// Revision 1.62  2003/11/29 15:36:17  law
// - new class: TeeHyperlinkFilter.
// - new proc: eeSetHyperlinkFilter.
//
// Revision 1.61  2003/11/17 12:43:32  law
// - new prop: TevCustomEvdReader.NotReadAsText, по умолчанию - false.
//
// Revision 1.60  2003/05/19 15:37:44  law
// - bug fix: неправильно выводилось сообщение о неизвестной версии.
//
// Revision 1.59  2003/04/29 16:08:20  law
// - bug fix: частично починена отрисовка рам таюлиц - изменено представление дюйма.
//
// Revision 1.58  2002/12/24 13:02:01  law
// - change: объединил Int64_Seek c основной веткой.
//
// Revision 1.57.2.1  2002/12/23 15:51:26  law
// - bug fix: не работали с хранилищем > 2Гб.
//
// Revision 1.57  2002/09/18 09:52:54  law
// - cleanup: методы удалены за ненадобностью - все уже есть в предке.
//
// Revision 1.56  2002/09/18 09:33:26  law
// - new behavior: при записи в evd-binary опускаем тип дочернего тега по умолчанию.
//
// Revision 1.55  2002/09/18 09:02:46  law
// - new behavior: при записи в evd-текст опускаем имя типа дочернего тега по умолчанию.
//
// Revision 1.54  2002/09/18 07:33:21  law
// - cleanup.
//
// Revision 1.53  2002/09/18 07:19:16  law
// - change: изменен метод проверки необходимости очистки таблицы шрифтов.
//
// Revision 1.52  2002/09/18 07:08:02  law
// - new units: k2StackGenerator, k2Ver.
// - new behavior: Tk2CustomReader теперь наследуется от Tk2CustomStackGenerator и соответственно наследует его поведение.
//
// Revision 1.51  2002/09/18 06:03:32  law
// - cleanup: удален параметр IsDefault.
//
// Revision 1.50  2002/07/09 12:02:20  law
// - rename unit: evUnits -> l3Units.
//
// Revision 1.49  2002/03/26 16:31:56  law
// - cleanup.
//
// Revision 1.48  2001/10/23 15:22:34  law
// - new behavior: сделано чтение evd из IStream.
//
// Revision 1.47  2001/10/23 10:30:51  law
// - new behavior: затачиваем для чтения из структурированного хранилища.
//
// Revision 1.46  2001/10/23 09:29:10  law
// - bug fix: не читались текстовые evd-файлы.
//
// Revision 1.45  2001/10/23 08:15:15  law
// - cleanup.
//
// Revision 1.44  2001/10/15 14:59:25  law
// - new behavior: сделана обработка директивы endbinary.
//
// Revision 1.43  2001/08/31 08:50:07  law
// - cleanup: первые шаги к кроссплатформенности.
//
// Revision 1.42  2001/08/30 16:34:02  law
// - new version: портировал на Delphi 6.
//
// Revision 1.41  2001/07/05 13:02:56  law
// - bug fix: в соответствии с задачей №593 (см. _TestSet\VerticalMerge\5.evd).
//
// Revision 1.40  2001/05/31 11:55:28  law
// - new behavior: теперь при более старшем формате не поднимается exception.
//
// Revision 1.39  2001/05/31 09:23:40  law
// - cleanup: убрана работа со старой логикой масок тегов.
//
// Revision 1.38  2001/05/30 13:36:34  law
// - new behavior: сделана обработка ошибок чтения.
//
// Revision 1.37  2001/05/30 13:09:54  law
// - del: убрана поддержка старого текстового формата.
//
// Revision 1.36  2001/05/30 12:55:38  law
// - del unit: удален модуль evEvdOldReader (убрана поддержка совсем старой версии формата).
//
// Revision 1.35  2001/05/30 12:17:15  law
// - new behavior: обработка ошибок переехала в модуль k2Reader.
//
// Revision 1.34  2001/05/30 09:11:18  law
// - new behavior: пытаемся централизовать обработку ошибок чтения документов.
//
// Revision 1.33  2001/04/18 13:56:35  law
// - bug fix: AV при поиска TevTextObjectParser.
//
// Revision 1.32  2001/04/18 13:25:23  law
// - comments: добавлены комментарии для xHelpGen.
//
// Revision 1.31  2001/03/28 11:38:49  law
// - bug fix: вывод сообщения о несозданной таблице шрифтов только один раз для документа.
//
// Revision 1.30  2001/03/28 10:21:08  law
// - bug fix: поправлена обработка несозданной таблицы шрифтов.
//
// Revision 1.29  2001/03/27 13:59:43  law
// - bug fix: неправильно выливалась таблица шрифтов.
//
// Revision 1.28  2001/03/14 13:24:54  law
// - some cleaup and tuning.
//
// Revision 1.27  2001/01/24 14:53:43  law
// - сделано более компактное сохранение имен шрифто
//
// Revision 1.26  2000/12/27 09:05:44  law
// - bug fix: выливка тега k2_tiVisible для комментариев и гипертекстовых ссылок в NSRC.
//
// Revision 1.25  2000/12/15 15:10:35  law
// - вставлены директивы Log.
//

{$Include evdDefine.inc }

interface

uses
  l3Types,
  l3Chars,
  l3Base,
  l3Filer,
  l3StringList,
  l3Variant,

  k2Prim,
  k2TagGen,
  k2InternalInterfaces,
  k2Reader,

  evdConst
  ;

type
  TevdNewAtomID = record
   rID   : Byte;
   rType : TevTypeID;
  end;//TevdNewAtomID

  TevdAtomID = record
   rID   : Word;
   rType : TevTypeID;
  end;//TevdAtomID

  TevdNativeReader = class(Tk2CustomFileParser)
   {* Читатель тегов в формате evd. }
    private
    // internal fields
      f_FontNames           : Tl3StringList;
      f_WasFontNamesWarning : Bool;
      f_DocumentWasOpened   : Bool;
    private
    // property fields
      f_ObjectBrackets : Bool;
      f_OpenBracket    : AnsiString;
      f_CloseBracket   : AnsiString;
      f_Binary         : Bool;
      f_NotReadAsText  : Bool;
      f_ReadOnlyOneRoot : Boolean;
    protected
    // property fields
      f_ForceBinary    : Bool;
    protected
    // protected properties
      property Binary: Bool
        read f_Binary
        write f_Binary;
        {* - данные идут в бинарном формате? }
    protected
    // internal methods
      procedure ReadFontID(aFiler : Tl3CustomFiler;
                           TagID  : Long);
        {-}
      procedure OpenStream;
        override;
        {-}
      procedure CloseStream(NeedUndo: Bool);
        override;
        {-вызывается один раз в конце генерации}
      procedure CloseStructure(NeedUndo: Bool);
        override;
        {-вызывается на закрывающуюся скобку}
      procedure Cleanup;
        override;
        {-}  
      procedure _DoAddIntegerAtom(aTagID: Long; aValue: Long);
        {-}
      procedure ConvertValue(const Name: AnsiString; Child: Bool);
        {-}
      procedure ConvertAfterSymbol(const Name: AnsiString; Child: Bool);
        virtual;
        {-}
      function  CheckOpenBracket: Bool;
        {-}
      function  PreProcessTypeID(const aTypeID: TevdAtomID): Bool;
        virtual;
        {-}
      function  PreProcessNewTypeID(const aTypeID: TevdNewAtomID): Bool;
        virtual;
        {-}
      procedure ReadText;
        virtual;
        {-}
    public
    // public methods
      constructor Create(anOwner: Tk2TagGeneratorOwner = nil);
        override;
        {-}
      procedure Read;
        override;
        {-}
      procedure StartChild(TypeID: Tl3VariantDef);
        override;
        {-}
      procedure SafeFinish(NeedUndo: Bool = false);
        {-}
    public
    // public properties
      property ForceBinary: Bool
        read f_ForceBinary
        write f_ForceBinary;
        {-}
      property ObjectBrackets: Bool
        read f_ObjectBrackets
        write f_ObjectBrackets
        default false;
        {-}
      property OpenBracket: AnsiString
        read f_OpenBracket
        write f_OpenBracket;
        {-}
      property CloseBracket: AnsiString
        read f_CloseBracket
        write f_CloseBracket;
        {-}
      property CurrentVersion;
        {-}
      property NotReadAsText: Bool
        read f_NotReadAsText
        write f_NotReadAsText
        default true;
        {-}
      property ReadOnlyOneRoot: Boolean
        read f_ReadOnlyOneRoot
        write f_ReadOnlyOneRoot
        default false;
        {-}
  end;//TevdNativeReader

implementation

uses
  Classes,
  {$IfDef Delphi6}
  RTLConsts,
  {$Else  Delphi6}
  Consts,
  {$EndIf Delphi6}
  SysUtils,

  l3Const,
  l3Stream,
  l3Parser,
  l3Memory,
  l3Math,
  l3Except,
  l3DateSt,

  k2Const,
  k2Tags,
  k2Base,
  k2Except,
  k2Interfaces,

  evdVer,
  evdTxtConst,
  evdKW,

  k2Inch_Const,
  TextPara_Const,
  Document_Const,
  Table_Const,
  TableRow_Const,
  TableCell_Const,
  SBS_Const,
  SBSRow_Const,
  SBSCell_Const,

  evdNativeReaderServices
  ;

const
  ev_msgInvalidDirective = 'Invalid format directive %s';

  evdOldInchMul = 1000;
    {-}

// start class TevdNativeReader 

constructor TevdNativeReader.Create(anOwner: Tk2TagGeneratorOwner = nil);
  {override;}
  {-}
begin
 inherited;
 CurrentVersion := evFormatCurVersionI;
 Parser.KeyWords := EvdKeyWords;
 f_ObjectBrackets := false;
 f_OpenBracket := evdOpenBracket;
 f_CloseBracket := evdCloseBracket;
 f_NotReadAsText := true;
 f_ReadOnlyOneRoot := false;
end;

procedure TevdNativeReader.Cleanup;
  //override;
  {-}
begin
 l3Free(f_FontNames);
 inherited;
end;

function LS8(aFiler: Tl3CustomFiler): sInt32;
var
 V : sInt8;
begin
 aFiler.Read(@V, SizeOf(V));
 Result := V;
end;

function LU8(aFiler: Tl3CustomFiler): sInt32;
var
 V : uInt8;
begin
 aFiler.Read(@V, SizeOf(V));
 Result := V;
end;

function LS16(aFiler: Tl3CustomFiler): sInt32;
var
 V : sInt16;
begin
 aFiler.Read(@V, SizeOf(V));
 Result := V;
end;

function LU16(aFiler: Tl3CustomFiler): sInt32;
var
 V : uInt16;
begin
 aFiler.Read(@V, SizeOf(V));
 Result := V;
end;

function LS32(aFiler: Tl3CustomFiler): sInt32;
begin
 aFiler.Read(@Result, SizeOf(Result));
end;

function LU32(aFiler: Tl3CustomFiler): sInt32;
var
 V : uInt32;
begin
 aFiler.Read(@V, SizeOf(V));
 Result := V;
end;

type
  TevdLIntProc = function (aFiler: Tl3CustomFiler): sInt32;

const
  LIntProcs : array [ev_idSInt8..ev_idUInt32] of TevdLIntProc =
   (LS8, LU8, LS16, LU16, LS32, LU32);

{$IfOpt R+}
 {$R-}
 {$Define _Range_}
{$EndIf}

function ReadOrd(aFiler : Tl3CustomFiler;
                 ID     : TevTypeID): sInt32;
  {-}
begin
 Result := LIntProcs[ID](aFiler);
end;

{$IfDef _Range_}
 {$R+}
 {$Undef _Range_}
{$EndIf _Range_}

procedure TevdNativeReader.ReadFontID(aFiler : Tl3CustomFiler;
                                      TagID  : Long);
  {-}

 function CheckFontNames: Bool;
 begin//CheckFontNames
  if (f_FontNames = nil) then
  begin
   if not f_WasFontNamesWarning then
   begin
    Error('Таблица шрифтов не создана.', false);
    f_WasFontNamesWarning := true;
   end;//not f_WasFontNamesWarning
   Result := false;
  end else
   Result := true;
 end;//CheckFontNames

var
 CurType : TevTypeID;
 l_ID    : Long;
begin
 with aFiler do
 begin
  Byte(CurType) := ReadByte;
  Case CurType of
   ev_idLong  :
   begin
    l_ID := ReadLong;
    if CheckFontNames then
     AddStringAtom(TagID, f_FontNames.Items[l_ID].AsWStr);
   end;//ev_idLong
   ev_idSInt8 .. ev_idUInt32:
   begin
    l_ID := ReadOrd(aFiler, CurType);
    if CheckFontNames then
     AddStringAtom(TagID, f_FontNames.Items[l_ID].AsWStr);
   end;//ev_idSInt8 ..
   else
    Error('Неверный тип идентификатора шрифта.', false);
  end;//Case CurType
 end;//with aFiler
end;

procedure TevdNativeReader.OpenStream;
  //override;
  {-}
begin
 inherited;
end;

procedure TevdNativeReader.CloseStream(NeedUndo: Bool);
  //override;
  {-вызывается один раз в конце генерации}
begin
 if (f_FontNames <> nil) then
  f_FontNames.Clear;
 f_WasFontNamesWarning := false;
 f_DocumentWasOpened := false;
 inherited;
end;

type
  EevOneRootReaded = class(EAbort)
  end;//EevOneRootReaded

procedure TevdNativeReader.CloseStructure(NeedUndo: Bool);
  //override;
  {-вызывается на закрывающуюся скобку}
begin
 inherited;
 if f_DocumentWasOpened AND (Level <= 1) then
 begin
  if (f_FontNames <> nil) then
  begin
   f_FontNames.Clear;
   f_WasFontNamesWarning := false;
  end;//f_FontNames <> nil
  f_DocumentWasOpened := false;
 end;//Level <= 1..
 if ReadOnlyOneRoot then
  if (CurrentType = nil) then
   raise EevOneRootReaded.Create('Прочитали один элемент верхнего уровня');
end;

procedure TevdNativeReader._DoAddIntegerAtom(aTagID: Long; aValue: Long);
begin
 AddIntegerAtom(aTagID, aValue);
end;

procedure TevdNativeReader.ConvertValue(const Name: AnsiString; Child: Bool);
  {-}

var
 ID         : Long;
 l_String   : Tl3String;
 l_Pos      : Long;
 l_P        : Tl3CustomParser;
begin
 l_P := Parser;
 if (SkipLevel = 0) then
 begin
  try
   ID := GetObjectID(Name, Child);
   case l_P.TokenType of
     l3_ttSingleChar:
      if (l_P.TokenChar = evTransparentToken) then
       AddTransparentAtom(ID)
      else
       Error(SInvalidProperty, false);
     l3_ttSymbol: AddStringAtom(ID, l_P.TokenString);
     l3_ttString:
     begin
      l_String := l_P.TokenLongString.Use;
      try
       l_Pos := l_P.Filer.Pos;
       if (l_P.NextTokenChar = cc_Comma) AND (l_P.NextToken = l3_ttInteger) then
        l_String._CodePage := l_P.TokenInt
       else
        l_P.Filer.Seek(l_Pos, soBeginning);
       AddStringAtom(ID, l_String.AsWStr);
      finally
       l3Free(l_String);
      end;//try..finally
     end;//l3_ttString
     l3_ttInteger: _DoAddIntegerAtom(ID, l_P.TokenInt);
{      toFloat:
       Writer.WriteFloat(TokenFloat);}
(*      '[':
       begin
         NextToken;
         Writer.WriteValue(vaSet);
         if Token <> ']' then
           while True do
           begin
             l_P.CheckToken(toSymbol);
             Writer.WriteStr(TokenString);
             if NextToken = ']' then Break;
             CheckToken(',');
             NextToken;
           end;
         Writer.WriteStr('');
       end;*)
(*      '(':
       begin
         NextToken;
         Writer.WriteListBegin;
         while Token <> ')' do ConvertValue;
         Writer.WriteListEnd;
       end;
     '{':
{        Writer.WriteBinary(l_P.HexToBinary);}*)
{&&&}
    else
     Error(SInvalidProperty, false);
   end;
  except
   on E: Ek2NotFound do
    Error(E.Message, false);
  end;{try..except}
 end;{SkipLevel = 0}
 l_P.NextToken;
end;

procedure TevdNativeReader.ConvertAfterSymbol(const Name: AnsiString; Child: Bool);
  {-}
var
 l_P : Tl3CustomParser;
begin
 l_P := Parser;
 l_P.CheckTokenChar('=');
 l_P.NextToken;
 if CheckOpenBracket then
 begin
  l_P.NextToken;
  StartObject(GetObjectID(Name, Child));
 end
 else
  ConvertValue(Name, Child);
end;

function TevdNativeReader.CheckOpenBracket: Bool;
  {-}
begin
 Result := (ObjectBrackets AND Parser.TokenSymbolIs(OpenBracket)) OR
           (not ObjectBrackets AND (Parser.TokenChar = OpenBracket[1]));
end;

function TevdNativeReader.PreProcessTypeID(const aTypeID: TevdAtomID): Bool;
  //virtual;
  {-}
begin
 Result := false;
end;

function TevdNativeReader.PreProcessNewTypeID(const aTypeID: TevdNewAtomID): Bool;
  //virtual;
  {-}
begin
 Result := false;
end;

procedure TevdNativeReader.ReadText;
  {-}
begin
end;

procedure DoMask(aFiler: Tl3CustomFiler);
begin
 aFiler.Seek(aFiler.ReadByte * SizeOf(Long), soCurrent);
end;

procedure DoMaskEx(aFiler: Tl3CustomFiler);
var
 l_MaskSize : Byte;
begin
 l_MaskSize := aFiler.ReadByte;
 aFiler.ReadByte;
 aFiler.Seek(l_MaskSize * SizeOf(Long), soCurrent);
end;

procedure DoNewStream(aReader    : TevdNativeReader;
                      aFiler     : Tl3CustomFiler;
                      const Atom : TevdNewAtomID);
var
 l_FilerStream : TStream;
 l_Stream      : TStream;
 l_StreamSize  : Long;
begin
 l_StreamSize := aFiler.ReadLong;
 l_FilerStream := Tl3FilerStream.Create(aFiler);
 try
  l_Stream := Tl3SubStream.Create(l_FilerStream, l_FilerStream.Position, l_StreamSize);
  try
   try
    aReader.AddStreamAtom(Atom.rID, l_Stream);
   except
    on Ek2NotFound do ;
    on Ek2ConversionError do ;
   end;{try..except}
   l_Stream.Seek(0, soEnd);
  finally
   l3Free(l_Stream);
  end;//try..finally
 finally
  l3Free(l_FilerStream);
 end;//try..finally
end;//ev_idStream

procedure DoStream(aReader    : TevdNativeReader;
                   aFiler     : Tl3CustomFiler;
                   const Atom : TevdAtomID);
var
 l_FilerStream : TStream;
 l_Stream      : TStream;
 l_StreamSize  : Long;
begin
 l_StreamSize := aFiler.ReadLong;
 l_FilerStream := Tl3FilerStream.Create(aFiler);
 try
  l_Stream := Tl3SubStream.Create(l_FilerStream, l_FilerStream.Position, l_StreamSize);
  try
   try
    aReader.AddStreamAtom(Atom.rID, l_Stream);
   except
    on Ek2NotFound do ;
    on Ek2ConversionError do ;
   end;{try..except}
   l_Stream.Seek(0, soEnd);
  finally
   l3Free(l_Stream);
  end;//try..finally
 finally
  l3Free(l_FilerStream);
 end;//try..finally
end;//ev_idStream

procedure ReadNewString32(aReader  : TevdNativeReader;
                          aFiler   : Tl3CustomFiler;
                          var Atom : TevdNewAtomID);
  {-}
var
 l_Line : Tl3String;
begin
 with aFiler do
 begin
  l_Line := MakeReadString(ReadLong, CP_ANSI);
  try
   aReader.AddStringAtom(Atom.rID, l_Line.AsWStr);
  finally
   l3Free(l_Line);
  end;//try..finally
 end;//with aFiler
end;

procedure ReadNewString16(aReader  : TevdNativeReader;
                        aFiler   : Tl3CustomFiler;
                        var Atom : TevdNewAtomID);
  {-}
var
 l_Line : Tl3String;
begin
 with aFiler do
 begin
  l_Line := MakeReadString(ReadWord, CP_ANSI);
  try
   aReader.AddStringAtom(Atom.rID, l_Line.AsWStr);
  finally
   l3Free(l_Line);
  end;//try..finally
 end;//with aFiler
end;

procedure ReadNewString8(aReader  : TevdNativeReader;
                         aFiler   : Tl3CustomFiler;
                         var Atom : TevdNewAtomID);
  {-}
var
 l_Line : Tl3String;
begin
 with aFiler do
 begin
  l_Line := MakeReadString(ReadByte, CP_ANSI);
  try
   aReader.AddStringAtom(Atom.rID, l_Line.AsWStr);
  finally
   l3Free(l_Line);
  end;//try..finally
 end;//with aFiler
end;

procedure ReadNewCodePageString(aReader  : TevdNativeReader;
                                aFiler   : Tl3CustomFiler;
                                var Atom : TevdNewAtomID);
  {-}
var
 l_Line     : Tl3String;
 l_CodePage : Long;
begin
 with aFiler do
 begin
  l_CodePage := ReadLong;
  Byte(Atom.rType) := ReadByte;
  l_Line := nil;
  try
   Case Atom.rType of
    ev_idString32:
     l_Line := MakeReadString(ReadLong, l_CodePage);
    ev_idString16:
     l_Line := MakeReadString(ReadWord, l_CodePage);
    ev_idString8  :
     l_Line := MakeReadString(ReadByte, l_CodePage);
    else
     Assert(false);
   end;//Case Atom.r.Type
   aReader.AddStringAtom(Atom.rID, l_Line.AsWStr);
  finally
   l3Free(l_Line);
  end;//try..finally
 end;//with aFiler
end;

procedure ReadShortCodePageString(aReader  : TevdNativeReader;
                                  aFiler   : Tl3CustomFiler;
                                  var Atom : TevdNewAtomID);
  {-}
var
 l_Line     : Tl3String;
 l_CodePage : Long;
begin
 with aFiler do
 begin
  l_CodePage := ReadByte;
  Byte(Atom.rType) := ReadByte;
  l_Line := nil;
  try
   Case Atom.rType of
    ev_idString32:
     l_Line := MakeReadString(ReadLong, l_CodePage);
    ev_idString16:
     l_Line := MakeReadString(ReadWord, l_CodePage);
    ev_idString8  :
     l_Line := MakeReadString(ReadByte, l_CodePage);
    else
     Assert(false);
   end;//Case Atom.r.Type
   aReader.AddStringAtom(Atom.rID, l_Line.AsWStr);
  finally
   l3Free(l_Line);
  end;//try..finally
 end;//with aFiler
end;

(*procedure ReadShortCodePageStringOld(aReader  : TevdNativeReader;
                                  aFiler   : Tl3CustomFiler;
                                  var Atom : TevdAtomID);
  {-}
var
 l_Line     : Tl3String;
 l_CodePage : Long;
begin
 with aFiler do
 begin
  l_CodePage := ReadByte;
  Byte(Atom.rType) := ReadByte;
  l_Line := nil;
  try
   Case Atom.rType of
    ev_idString32:
     l_Line := MakeReadString(ReadLong, l_CodePage);
    ev_idString16:
     l_Line := MakeReadString(ReadWord, l_CodePage);
    ev_idString8  :
     l_Line := MakeReadString(ReadByte, l_CodePage);
    else
     Assert(false);
   end;//Case Atom.r.Type
   aReader.AddStringAtom(Atom.rID, l_Line);
  finally
   l3Free(l_Line);
  end;//try..finally
 end;//with aFiler
end;*)

procedure ReadStringEx(aReader  : TevdNativeReader;
                       aFiler   : Tl3CustomFiler;
                       var Atom : TevdAtomID);
  {-}
var
 l_Line : Tl3String;
begin
 with aFiler do
 begin
  l_Line := nil;
  try
   Case Atom.rType of
    ev_idString32:
     l_Line := MakeReadString(ReadLong, CP_ANSI);
    ev_idString16:
     l_Line := MakeReadString(ReadWord, CP_ANSI);
    ev_idString8  :
     l_Line := MakeReadString(ReadByte, CP_ANSI);
    else
     Assert(false);
   end;//Case Atom.r.Type
   aReader.AddStringAtom(Atom.rID, l_Line.AsWStr);
  finally
   l3Free(l_Line);
  end;//try..finally
 end;//with aFiler
end;

procedure ReadCodePageString(aReader  : TevdNativeReader;
                             aFiler   : Tl3CustomFiler;
                             var Atom : TevdAtomID);
  {-}
var
 l_Line     : Tl3String;
 l_CodePage : Long;
begin
 with aFiler do
 begin
  l_CodePage := ReadLong;
  Byte(Atom.rType) := ReadByte;
  l_Line := nil;
  try
   Case Atom.rType of
    ev_idString32:
     l_Line := MakeReadString(ReadLong, l_CodePage);
    ev_idString16:
     l_Line := MakeReadString(ReadWord, l_CodePage);
    ev_idString8  :
     l_Line := MakeReadString(ReadByte, l_CodePage);
    else
     Assert(false);
   end;//Case Atom.r.Type
   aReader.AddStringAtom(Atom.rID, l_Line.AsWStr);
  finally
   l3Free(l_Line);
  end;//try..finally
 end;//with aFiler
end;

procedure ReadNewFontName(aReader  : TevdNativeReader;
                          aFiler   : Tl3CustomFiler;
                          var Atom : TevdNewAtomID);
  {-}
var
 l_Line     : Tl3String;
 l_CodePage : Long;
begin
 with aFiler do
 begin
  Byte(Atom.rType) := aFiler.ReadByte;
  Case Atom.rType of
   ev_idCodePage:
   begin
    l_CodePage := ReadLong;
    Byte(Atom.rType) := ReadByte;
   end;//ev_idCodePage
   ev_idShortCodePage:
   begin
    l_CodePage := ReadByte;
    Byte(Atom.rType) := ReadByte;
   end;//ev_idShortCodePage
   else
    l_CodePage := CP_ANSI;
  end;//Case Atom.rType
  l_Line := nil;
  try
   Case Atom.rType of
    ev_idString32:
     l_Line := MakeReadString(ReadLong, l_CodePage);
    ev_idString16:
     l_Line := MakeReadString(ReadWord, l_CodePage);
    ev_idString8  :
     l_Line := MakeReadString(ReadByte, l_CodePage);
    else
     Assert(false);
   end;//Case Atom.r.Type
   with aReader do
   begin
    AddStringAtom(Atom.rID, l_Line.AsWStr);
    if (f_FontNames = nil) then
     f_FontNames := Tl3StringList.Make;
    f_FontNames.Add(l_Line);
   end;//with aReader
  finally
   l3Free(l_Line);
  end;//try..finally
 end;//with aFiler
end;

procedure ReadFontName(aReader  : TevdNativeReader;
                       aFiler   : Tl3CustomFiler;
                       var Atom : TevdAtomID);
  {-}
var
 l_Line     : Tl3String;
 l_CodePage : Long;
begin
 with aFiler do
 begin
  Byte(Atom.rType) := aFiler.ReadByte;
  if (Atom.rType = ev_idCodePage) then
  begin
   l_CodePage := ReadLong;
   Byte(Atom.rType) := ReadByte;
  end//Atom.rType = ev_idCodePage
  else
   l_CodePage := CP_ANSI;
  l_Line := nil;
  try
   Case Atom.rType of
    ev_idString32:
     l_Line := MakeReadString(ReadLong, l_CodePage);
    ev_idString16:
     l_Line := MakeReadString(ReadWord, l_CodePage);
    ev_idString8  :
     l_Line := MakeReadString(ReadByte, l_CodePage);
    else
     Assert(false);
   end;//Case Atom.r.Type
   with aReader do
   begin
    AddStringAtom(Atom.rID, l_Line.AsWStr);
    if (f_FontNames = nil) then
     f_FontNames := Tl3StringList.Make;
    f_FontNames.Add(l_Line);
   end;//with aReader
  finally
   l3Free(l_Line);
  end;//try..finally
 end;//with aFiler
end;

procedure TevdNativeReader.Read;
  {override;}
  {-}
var
 l_Filer  : Tl3CustomFiler;
 l_Parser : Tl3CustomParser;
 l_WasVer : Boolean;

  procedure ConvertBinary;       
  var
   l_Atom         : TevdNewAtomID;
   CheckEndBinary : Bool;
  begin//ConvertBinary
   CheckEndBinary := false;
   while not l_Filer.EOF do
   begin
    {$If Defined(Nemesis) AND not Defined(nsTest)}
    try
     l_Atom.rID := l_Filer.ReadByte;
    except
     on El3ReadError do
      break;
    end;//try..except
    {$Else}
    l_Atom.rID := l_Filer.ReadByte;
    {$IfEnd}
    if not PreProcessNewTypeID(l_Atom) then
     Case l_Atom.rID of
      evd_pack_idPercent:
      begin
       l_Atom.rID := l_Filer.ReadByte;
       Case l_Atom.rID of
        evd_pack_idSmallE,
        evd_pack_idCapitalE:
        begin
         CheckEndBinary := true;
         break;
        end;//evd_idSmallE
        evd_pack_idSmallB,
        evd_pack_idCapitalB:
        begin
         Binary := false;
         l_Parser.NextToken;
         l_Parser.CheckTokenKeyWord(evd_kwInary);
         Binary := true;
         l_Filer.SkipEOL;
        end;//evd_idSmallB
        evd_pack_idSmallP,
        evd_pack_idCapitalP:
        begin
         Binary := false;
         l_Parser.NextToken;
         l_Parser.CheckTokenKeyWord(evd_kwBinary);
         Binary := true;
         l_Filer.SkipEOL;
        end;//evd_idSmallB
        else
         Assert(false);
       end;//l_Atom.rID
      end;//evd_idPercent
      evd_pack_idRollback :
       SafeFinish(true);
      evd_pack_idFinish :
       SafeFinish;
      evd_pack_idDefaultChild :
       StartDefaultChild;
      else
      begin
       if (l_Atom.rID = evd_pack_idChildren) then
        l_Atom.rID := k2_tiChildren;
       Byte(l_Atom.rType) := l_Filer.ReadByte;
       Case l_Atom.rType of
        ev_idChild:
         if (l_Atom.rID = unpack_idFill) then
          break
         else
          StartChild(TypeTable.TypeByHandle[l_Atom.rID]);
        ev_idAtom:
         StartTag(l_Atom.rID);
        ev_idLong:
         AddIntegerAtom(l_Atom.rID, l_Filer.ReadLong);
        ev_idComponent:
         Assert(false); 
        ev_idString32:
         ReadNewString32(Self, l_Filer, l_Atom);
        ev_idString16:
         ReadNewString16(Self, l_Filer, l_Atom);
        ev_idString8:
         ReadNewString8(Self, l_Filer, l_Atom);
        ev_idCodePage:
         ReadNewCodePageString(Self, l_Filer, l_Atom);
        ev_idSInt8:
         AddIntegerAtom(l_Atom.rID, LS8(l_Filer));
        ev_idUInt8:
         AddIntegerAtom(l_Atom.rID, LU8(l_Filer));
        ev_idSInt16:
         AddIntegerAtom(l_Atom.rID, LS16(l_Filer));
        ev_idUInt16:
         AddIntegerAtom(l_Atom.rID, LU16(l_Filer));
        ev_idSInt32:
         AddIntegerAtom(l_Atom.rID, LS32(l_Filer));
        ev_idUInt32:
         AddIntegerAtom(l_Atom.rID, LU32(l_Filer));
        ev_idSInt64,
        ev_idUInt64:
         Assert(false);
        ev_idStream :
         DoNewStream(Self, l_Filer, l_Atom);
        ev_idTransparent:
         AddTransparentAtom(l_Atom.rID);
        ev_idFontName:
         ReadNewFontName(Self, l_Filer, l_Atom);
        ev_idFontID:
         ReadFontID(l_Filer, l_Atom.rID);
        ev_idShortCodePage:
         ReadShortCodePageString(Self, l_Filer, l_Atom);
        else
        begin
         Error(Format('Invalid type ID: %d', [Ord(l_Atom.rType)]), false);
         l3System.Msg2Log('Trying to recover');
         Finish;
        end;//else
       end;//Case l_Atom.rType
      end;//else
     end;//Case l_Atom.rID
   end;//while
   Binary := false;
   l_Parser.NextToken;
   if CheckEndBinary then
   begin
    l_Parser.CheckTokenKeyWord(evd_kwNdBinary);
    l_Parser.NextToken;
   end;//CheckEndBinary
  end;//ConvertBinary

  procedure ConvertBinaryObject;

  var
   l_Atom          : TevdAtomID;
   CheckEndBinary  : Bool;
  begin//ConvertBinaryObject
   CheckEndBinary := false;
   while not l_Filer.EOF do
   begin
    {$If Defined(Nemesis) AND not Defined(nsTest)}
    try
     l_Atom.rID := l_Filer.ReadWord;
    except
     on El3ReadError do
      break;
    end;//try..except
    {$Else}
    l_Atom.rID := l_Filer.ReadWord;
    {$IfEnd}
    if not PreProcessTypeID(l_Atom) then
     Case l_Atom.rID of
      unpack_idKey1, unpack_idKey2:
      begin
       CheckEndBinary := true;
       break;
      end;//idKey1, idKey2
      unpack_idKey3, unpack_idKey4:
      begin
       Binary := false;
       l_Parser.NextToken;
       l_Parser.CheckTokenKeyWord(evd_kwInary);
       Binary := true;
       l_Filer.SkipEOL;
      end;//idKey3, idKey4
      unpack_idMask:
       DoMask(l_Filer);
      unpack_idMaskEx:
       DoMaskEx(l_Filer);
      unpack_idRollback :
       SafeFinish(true);
      unpack_idFinish :
       SafeFinish;
      unpack_idDefaultChild :
       StartDefaultChild;
      else
      begin
       if (l_Atom.rID = unpack_idChildren) then
        l_Atom.rID := k2_tiChildren;
       Byte(l_Atom.rType) := l_Filer.ReadByte;
       Case l_Atom.rType of
        ev_idChild:
         if (l_Atom.rID = unpack_idFill) then
          break
         else
          StartChild(TypeTable.TypeByHandle[l_Atom.rID]);
        ev_idAtom:
         StartTag(l_Atom.rID);
        ev_idLong:
         _DoAddIntegerAtom(l_Atom.rID, l_Filer.ReadLong);
        ev_idComponent:
         Assert(false); 
        ev_idString32,
        ev_idString16,
        ev_idString8:
         ReadStringEx(Self, l_Filer, l_Atom);
        ev_idCodePage:
         ReadCodePageString(Self, l_Filer, l_Atom);
        ev_idSInt8 .. ev_idUInt32:
         _DoAddIntegerAtom(l_Atom.rID, ReadOrd(l_Filer, l_Atom.rType));
        ev_idSInt64,
        ev_idUInt64:
         Assert(false);
        ev_idStream :
         DoStream(Self, l_Filer, l_Atom);
        ev_idTransparent:
         AddTransparentAtom(l_Atom.rID);
        ev_idFontName:
         ReadFontName(Self, l_Filer, l_Atom);
        ev_idFontID:
         ReadFontID(l_Filer, l_Atom.rID);
        ev_idShortCodePage:
         Assert(false);
         //ReadShortCodePageStringOld(Self, l_Filer, l_Atom);
        else
        begin
         Error(Format('Invalid type ID: %d', [Ord(l_Atom.rType)]), false);
         l3System.Msg2Log('Trying to recover');
         Finish;
        end;//else
       end;//Case l_Atom.rType
      end;//else
     end;//Case l_Atom.rID
   end;//while
   Binary := false;
   l_Parser.NextToken;
   if CheckEndBinary then
   begin
    l_Parser.CheckTokenKeyWord(evd_kwNdBinary);
    l_Parser.NextToken;
   end;//CheckEndBinary
  end;//ConvertBinaryObject

  procedure InvalidDirective;
  begin{InvalidDirective}
   Error(Format(ev_msgInvalidDirective, [l_Parser.TokenString]));
  end;{InvalidDirective}

  procedure ConvertProperty;
  var
   l_PropName : AnsiString;
   Child      : Bool;
  begin
   l_Parser.CheckKeyWords := false;
   try
    Child := (l_Parser.TokenChar = cc_Colon);
    if Child then
     l_Parser.NextToken;
    if (l_Parser.TokenType = l3_ttSymbol) OR
       (l_Parser.TokenType = l3_ttKeyWord)
       // Это из-за http://mdp.garant.ru/pages/viewpage.action?pageId=289933137
       then
    begin
     l_PropName := l_Parser.TokenString;
     l_Parser.NextToken;
     while (l_Parser.TokenChar = cc_Dot) do
     begin
      l_Parser.NextToken;
      l_Parser.CheckToken(l3_ttSymbol);
      l_PropName := l_PropName + cc_Dot + l_Parser.TokenString;
      l_Parser.NextToken;
     end;//while (l_Parser.TokenChar = cc_Dot)
    end//l_Parser.TokenType = l3_ttSymbol
    else
     l_PropName := ''; 
    ConvertAfterSymbol(l_PropName, Child);
   finally
    l_Parser.CheckKeyWords := true;
   end;//try..finally
  end;
  
  function CheckNextDirective: Bool;
  begin
   Result := (l_Parser.TokenChar = evDirectivePrefix);
  end;


  procedure ReadPlainText;
  var
   l_Stream   : Tl3StringStream;
   l_SFiler   : Tl3CustomFiler;
   l_OldFiler : Tl3CustomFiler;
   l_S        : Tl3String;
  begin
   l_Filer.SkipEOL;
   l_OldFiler := l_Filer.Use;
   try
    l_SFiler := Tl3CustomFiler.Create;
    try
     Filer := l_SFiler;
     try
      l_Stream := Tl3StringStream.Create;
      try
       while not l_OldFiler.EOF do
       begin
        l_S := Tl3String.Make(l_OldFiler.ReadLn);
        try
         l_Stream._String := l_S;
         try
          l_SFiler.Stream := l_Stream;
          try
           l_Parser.NextToken;
           if CheckNextDirective then
           begin
            l_Parser.NextToken;
            l_Parser.CheckTokenKeyWord(evd_kwEndPlainText);
            Read;
            break;
           end//CheckNextDirective
           else
           begin
            StartChild(k2_typTextPara);
            try
             AddStringAtom(k2_tiText, l_Stream._String.AsWStr);
            finally
             SafeFinish;
            end;//try..finally
           end;
          finally
           l_SFiler.Stream := nil;
          end;//try..finaly
         finally
          l_Stream._String := nil;
         end;//try..finally
        finally
         FreeAndNil(l_S);
        end;//try..finally
       end;//while not l_OldFiler.EOF
      finally
       l3Free(l_Stream);
      end;//try..finally
     finally
      Filer := l_OldFiler;
     end;//try..finally
     l_Parser.NextToken;
    finally
     l3Free(l_SFiler);
    end;//try..finally
   finally
    l3Free(l_OldFiler);
   end;//try..finally
  end;//ReadPlainText

(*  procedure ConvertDirective;

  begin
   while CheckNextDirective do begin
    l_Parser.NextToken;
    if CheckPlainText then
     continue
    else
     InvalidDirective;
   end;{CheckNextDirective}
  end;*)

  function CheckCloseBracket: Bool;
  begin
   Result := (ObjectBrackets AND l_Parser.TokenSymbolIs(CloseBracket)) OR
             (not ObjectBrackets AND (l_Parser.TokenChar = CloseBracket[1]));
   if Result then
    l_Parser.NextToken;          
  end;

  function CheckRollbackPrefix: Bool;
  begin
   Result := (l_Parser.TokenChar = evRollbackPrefix);
  end;

  procedure DoVersion;
  var
   l_CVf : Extended;
   l_CVa : array [0..1] of Word;
  begin
   l_Parser.NextToken;
   l_CVf := l_Parser.TokenFloat;
   l_CVa[1] := Trunc(l_CVf);
   l_CVa[0] := Trunc((l_CVf - l_CVa[1]) * 1000);
   CurrentVersion := Long(l_CVa);
   l_WasVer := true;
   if (CurrentVersion <> evPackedVer) then
   begin
    if (CurrentVersion div evFormatCurVersionStep >
        evFormatCurVersionI div evFormatCurVersionStep) then
     Error(Format('Warning: Unknown evd-version %8.3f', [l_CVf]), false)
    else
    if (CurrentVersion <= 30) OR (CurrentVersion = 100) then
     Error(Format('Warning: Too old evd-version %8.3f', [l_CVf]), false);
   end;//CurrentVersion <> evPackedVer
   l_Parser.NextToken;
  end;

  procedure DoRevision;
  begin
   l_Parser.NextToken;
   l_Parser.CheckTokenKeyWord(evd_kwDate);
   l_Parser.NextToken;
   l_Parser.CheckToken(l3_ttString);
   l_Parser.NextToken;
  end;

  procedure DoBrackets;
  begin
   l_Parser.NextToken;
   ObjectBrackets := (l_Parser.TokenType = l3_ttSymbol);
   if ObjectBrackets then
   begin
    OpenBracket := l_Parser.TokenString;
    l_Parser.NextToken;
    CloseBracket := l_Parser.TokenString;
   end//ObjectBrackets
   else
   begin
    OpenBracket := l_Parser.TokenChar;
    l_Parser.NextToken;
    CloseBracket := l_Parser.TokenChar;
   end;//ObjectBrackets
   l_Parser.NextToken;
  end;

  procedure DoComment;
  begin
   l_Parser.NextTokenPrim(l3NextTokenAllFlags - [l3_ntfSkipComment]);
   l_Parser.OpenComment := l_Parser.TokenChar;
   l_Parser.NextTokenPrim(l3NextTokenAllFlags - [l3_ntfSkipBlanks, l3_ntfSkipComment]);
   if not (l_Parser.TokenChar in l_Parser.WhiteSpace) then
    l_Parser.OpenComment := l_Parser.OpenComment + l_Parser.TokenChar;
   l_Parser.NextTokenPrim(l3NextTokenAllFlags - [l3_ntfSkipComment]);
   l_Parser.CloseComment := l_Parser.TokenChar;
   l_Parser.NextTokenPrim(l3NextTokenAllFlags - [l3_ntfSkipBlanks, l3_ntfSkipComment]);
   if not (l_Parser.TokenChar in l_Parser.WhiteSpace) then
    l_Parser.CloseComment := l_Parser.CloseComment + l_Parser.TokenChar;
   l_Parser.NextToken;
  end;{DoComment}

  procedure DoLineComment;
  begin
   l_Parser.NextTokenPrim(l3NextTokenAllFlags - [l3_ntfSkipComment]);
   l_Parser.LineComment := l_Parser.TokenChar;
   l_Parser.NextTokenPrim(l3NextTokenAllFlags - [l3_ntfSkipBlanks, l3_ntfSkipComment]);
   if not (l_Parser.TokenChar in l_Parser.WhiteSpace) then
    l_Parser.LineComment := l_Parser.LineComment + l_Parser.TokenChar;
   l_Parser.NextToken;
  end;{DoLineComment}

  procedure DoBinary;
  begin//DoBinary
   Binary := true;
   l_Filer.SkipEOL;
   if (CurrentVersion < evPackedVer) then
    ConvertBinaryObject
   else
    ConvertBinary;
  end;//DoBinary

  procedure DoFormat;
  var
   WS : TCharSet;
  begin
   WS := l_Parser.WhiteSpace;
   try
    l_Parser.WhiteSpace := WS - [cc_SoftEnter, cc_HardEnter];
    l_Parser.NextToken;
    while not (CheckNextDirective OR CheckOpenBracket OR l_Filer.EOF) do
    begin
     Case l_Parser.TokenType of
      l3_ttEOF:
       break;
      l3_ttEOL:
      begin
       while (l_Parser.NextToken = l3_ttEOL) do ;
       break;
      end;{l3_ttEOL}
      l3_ttKeyWord:
      begin
       Case l_Parser.KeyWord.StringID of
        evd_kwVersion:
         DoVersion;
        evd_kwRevision:
         DoRevision;
        evd_kwBrackets:
         DoBrackets;
        evd_kwPBinary: 
        begin
         if not l_WasVer then
          CurrentVersion := evPackedVer;
         l_Parser.WhiteSpace := WS;
         DoBinary;
        end;//evd_kwBinary
        evd_kwBinary:
        begin
         if not l_WasVer then
          CurrentVersion := evNonPackedVer;
         l_Parser.WhiteSpace := WS;
         DoBinary;
        end;//evd_kwBinary
        evd_kwComment     : DoComment;
        evd_kwLineComment : DoLineComment;
        else
         InvalidDirective;
       end;//Case l_Parser.KeyWord.Handle
      end;//l3_ttKeyWord
      else
       InvalidDirective;
     end;//Case l_Parser.TokenType
    end;//while not (CheckNextDirective ..
   finally
    l_Parser.WhiteSpace := WS;
   end;//try..finally
  end;

var
 l_Starts : Integer;
 l_WasException : Boolean;  
begin
 try
 l_Filer := Filer;
 l_Parser := Parser;
 l_WasVer := false;
 {$IfDef Nemesis}
 if (CurrentVersion <> evNonPackedVer) then
 {$EndIf Nemesis}
  CurrentVersion := evFormatCurVersionI;
 l_Starts := f_Starts;
 l_WasException := false;
 try
  try
   if f_ForceBinary and not l_Filer.EOF then
   begin
    if (l_Filer.GetC.rAC = evDirectivePrefix) then
     f_ForceBinary := false;
    l_Filer.UngetC;
   end;//f_ForceBinary
   if f_ForceBinary then
   begin
    if (CurrentVersion < evPackedVer) then
     ConvertBinaryObject
    else
     ConvertBinary;
   end//f_ForceBinary
   else
   if (l_Filer = nil) OR l_Filer.EOF then
    ReadText
   else
   if (l_Filer.GetC.rAC = cc_Null) then
   begin
    ;
   end
   else
   begin
    l_Filer.CodePage := CP_ANSI;
    l_Filer.UngetC;
    l_Parser.NullAsEOF := true;
    l_Parser.NextToken;
    while true do
    begin
     try
      if (l_Parser.TokenType = l3_ttEOF) then
       break
      else
      if CheckNextDirective then
      begin
       l_Parser.NextToken;
       if (l_Parser.TokenType = l3_ttKeyWord) then
       begin
        Case l_Parser.KeyWord.StringID of
         evd_kwProducer:
         begin
          l_Parser.NextToken;
          if not CheckNextDirective then
           l_Parser.NextToken;
          if l_Parser.TokenType = l3_ttKeyWord then
          begin
           Case l_Parser.KeyWord.StringID of
            evd_kwDate:
            begin
             l_Parser.NextToken;
             l_Parser.CheckToken(l3_ttString);
             l_Parser.NextToken;
            end;//evd_kwDate
            else InvalidDirective;
           end;
          end;//l_Parser.TokenType = l3_ttKeyWord
         end;//evd_kwProducer
         evd_kwVersion:
          DoVersion;
         evd_kwFormat:
          DoFormat;
         evd_kwBrackets:
          DoBrackets;
         evd_kwPBinary:
         begin
          if not l_WasVer then
           CurrentVersion := evPackedVer;
          DoBinary;
         end;//evd_kwBinary
         evd_kwBinary:
         begin
          if not l_WasVer then
           CurrentVersion := evNonPackedVer;
          DoBinary;
         end;//evd_kwBinary
         evd_kwPlainText : ReadPlainText;
         evd_kwEndBinary : l_Parser.NextToken; // - просто пропускаем директиву
         else InvalidDirective;
        end;//Case l_Parser.KeyWord.Handle
       end//l_Parser.TokenType = l3_ttKeyWord
       else
        InvalidDirective;
      end//CheckNextDirective
      else
      if CheckRollbackPrefix then
      begin
       l_Parser.NextToken;
       if CheckCloseBracket then
        SafeFinish(true)
       else
        Error('Rollback prefix without closing bracket');
      end//CheckRollbackPrefix
      else
      if CheckCloseBracket then
       SafeFinish
      else
       ConvertProperty;
     except
      on EParserError do
      begin
       if NotReadAsText then
        raise
       else
       begin
        Error('Файл не в evd-формате, читаем как текстовый', false);
        ReadText;
        break;
       end;//NotReadAsText
      end;//EParserError
     end;//try..except
    end;//while true
   end;//l_Filer.GetC = cc_Null
  except
   on EevOneRootReaded do
   begin
   end;
   else
   begin
    l_WasException := true;
    raise;
   end;//else 
  end;//try..finally
 finally
  while (f_Starts > l_Starts) do
   Finish(l_WasException);
 end;//try..finally
 except
  on EevOneRootReaded do
  begin
  end;
  else
   raise;
 end;//try..except
end;

procedure TevdNativeReader.StartChild(TypeID: Tl3VariantDef);
  //override;
  {-}
var
 l_CT : Tk2Type;
begin
 if (CurrentVersion <= evPackedVer + 1) then
 begin
  l_CT := CurrentType;
  if (l_CT <> nil) then
  begin
   if (TypeID = k2_typTableRow) AND (l_CT = k2_typSBS) then
    TypeID := k2_typSBSRow
   else
   if (TypeID = k2_typTableCell) AND (l_CT = k2_typSBSRow) then
    TypeID := k2_typSBSCell;
  end;//l_CT <> nil
 end;//CurrentVersion <= evPackedVer
 inherited;
 if not f_DocumentWasOpened AND CurrentType.IsKindOf(k2_typDocument) then
  f_DocumentWasOpened := true;
end;

procedure TevdNativeReader.SafeFinish(NeedUndo: Bool = false);
  {-}
begin
 try
  Finish(NeedUndo);
 except
  on E: Ek2NotFound do Error(E.Message, false);
  on E: Ek2ConversionError do Error(E.Message, false);
 end;{try..except}
end;

end.

