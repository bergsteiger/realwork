unit nevInternalInterfaces;

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: nevInternalInterfaces - }
{ Начат: 13.07.2005 20:13 }
{ $Id: nevInternalInterfaces.pas,v 1.10 2014/04/21 14:37:57 lulin Exp $ }

// $Log: nevInternalInterfaces.pas,v $
// Revision 1.10  2014/04/21 14:37:57  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.9  2008/11/13 13:09:04  dinishev
// <K> : 121156019
//
// Revision 1.8  2008/11/10 14:17:24  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=114459503&focusedCommentId=122672040#comment-122672040
//
// Revision 1.7  2008/10/28 09:50:10  dinishev
// <K> : 121156019
//
// Revision 1.6  2008/06/20 14:49:04  lulin
// - используем префиксы элементов.
//
// Revision 1.5  2008/04/02 17:03:26  lulin
// - <K>: 88641704.
//
// Revision 1.4  2008/04/02 14:22:07  lulin
// - cleanup.
//
// Revision 1.3  2008/03/31 12:16:18  lulin
// - рисуем контейнер документа.
//
// Revision 1.2  2007/12/04 12:47:51  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.1.2.42  2007/11/28 15:52:13  dinishev
// Совместимость с Арчи
//
// Revision 1.1.2.41  2006/12/12 09:54:35  oman
// - fix: Перенос HiddenStyles c DocumentContainer на редактор.
//   Поддержка экспорта/клипборда/d'n'd (cq12564)
//
// Revision 1.1.2.40  2006/12/11 09:55:29  oman
// - new: HiddenStyles перенесены с DocumentContainer на редактор (cq12564)
// - new: Изменена схема кэширования превью на DocumentContainer
//
// Revision 1.1.2.39  2006/06/23 13:16:28  lulin
// - bg fix: не были сбалансированы скобки открытия/закрытия потока и начала/конца индикатора процесса - в результате в статусной строке оставалась ненужная надпись (CQ OIT5-19445).
//
// Revision 1.1.2.38  2006/03/01 11:28:38  lulin
// - cleanup: избавляемся от устаревшего интерфейса.
//
// Revision 1.1.2.37  2005/12/05 09:06:22  lulin
// - валидация генерации документа полностью переехала с TextSource на DocumentContainer.
//
// Revision 1.1.2.36  2005/12/03 19:44:00  lulin
// - удален старый механизм перехода на метки. Теперь все делается через Waiter'ов.
//
// Revision 1.1.2.35  2005/12/03 15:58:48  lulin
// - bug fix: отвалился переход на метку.
// - убрана шаманская обработка невалидных документов.
//
// Revision 1.1.2.34  2005/12/03 14:46:56  lulin
// - избавляемся от хитросплетений методов TextSource и контейнера документа.
//
// Revision 1.1.2.33  2005/12/02 22:56:26  lulin
// - запрещаем присваивать документ контейнеру.
//
// Revision 1.1.2.32  2005/12/02 22:50:30  lulin
// - запретил напрямую присваивать TextSource документ - присваивать можно только контейнер.
//
// Revision 1.1.2.31  2005/12/02 22:38:10  lulin
// - нотификация о добавлении параграфов в процессе загрузки теперь посылается через процессор, а не через обработчики сообщений.
//
// Revision 1.1.2.30  2005/12/02 18:23:33  lulin
// - обрабока нотфификации об удалении/добавлении параграфа практически полностью перенесена на процессор.
//
// Revision 1.1.2.29  2005/12/01 09:42:36  lulin
// - удалены методы, связанные со старым алгоритмом форматирования.
//
// Revision 1.1.2.28  2005/12/01 08:02:40  lulin
// - cleanup: хитрая обработка добавляемых тегов (в частности формирование оглавления) перенесена с TextSource на DocumentContainer.
//
// Revision 1.1.2.27  2005/12/01 06:10:40  lulin
// - интерфейс _preview перенесен в более общую библиотеку.
//
// Revision 1.1.2.26  2005/12/01 05:59:24  lulin
// - cleanup: избавляемся от транслции свойства HiddenStyles от редактора к котнтейнеру и обратно.
//
// Revision 1.1.2.25  2005/12/01 05:27:45  lulin
// - нотификация об изменении атрибута тега разложена по уровням Processor -> DocumentContainer -> TextSource.
//
// Revision 1.1.2.24  2005/11/15 13:50:11  lulin
// - cleanup: используем только Reader тегов - не подкладывая под него Pool. Связывание теперь осуществляется раньше.
//
// Revision 1.1.2.23  2005/11/15 09:44:04  lulin
// - убран лишний параметр.
//
// Revision 1.1.2.22  2005/11/15 09:36:45  lulin
// - от реализации переходим к интерфейсам.
//
// Revision 1.1.2.21  2005/11/15 08:02:42  lulin
// - чтение/запись документа практически польностью перенесены с TextSource на контейнер документа.
//
// Revision 1.1.2.20  2005/11/15 05:17:31  lulin
// - восстановлена валидация Writer'а у TextSource.
//
// Revision 1.1.2.19  2005/11/14 19:05:49  lulin
// - bug fix: не компилировалось.
//
// Revision 1.1.2.18  2005/11/14 18:37:05  lulin
// - теперь при заборе в буфер обмена в него кладется контейнер документа, а не TextSource - должно починить ошибку CQ OIT5-17870.
//
// Revision 1.1.2.17  2005/11/09 15:28:33  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.1.2.16  2005/10/18 07:19:43  lulin
// - new behavior: теперь методы вставки и добавления дочерних тегов могут подменять вставляемые теги.
//
// Revision 1.1.2.15  2005/10/10 11:43:22  lulin
// - cleanup: используем интерфейсы из правильной библиотеки.
//
// Revision 1.1.2.14  2005/10/07 09:22:16  lulin
// - bug fix: при рисовании документа совершенно бесцельно дергался поиск параграфа с Sub'ом.
//
// Revision 1.1.2.13  2005/09/23 16:04:04  lulin
// - выделен модуль с общими интерфейсами.
//
// Revision 1.1.2.12  2005/07/27 11:17:25  lulin
// - кеш документов теперь работает практически только с интерфейсом контейнера документа, а не с его реализацией.
//
// Revision 1.1.2.11  2005/07/25 18:09:20  lulin
// - теперь TextSource не знает про реализацию контейнера документа, а только про его интерфейс.
//
// Revision 1.1.2.10  2005/07/18 10:26:15  lulin
// - удален ненужный интерфейс окна.
//
// Revision 1.1.2.9  2005/07/15 12:42:01  lulin
// - теперь процеесор операций знает не про безликого Owner'а, а про вполне конкретный DocumentContainer.
//
// Revision 1.1.2.8  2005/07/15 09:30:45  lulin
// - теперь параграфы знают про DocumentContainer, DocumentContainer знает про TextSource, а TextSource - знает про редакторы.
//
// Revision 1.1.2.7  2005/07/15 09:05:36  lulin
// - new interface: InevDocumentContainer.
//
// Revision 1.1.2.6  2005/07/15 08:51:34  lulin
// - new behavior: теперь один и тот же документ может показываться в разных окнах - без создания копий и необходимости синхронизации между ними.
//
// Revision 1.1.2.5  2005/07/14 14:17:38  lulin
// - new behavior: теперь один документ может быть привязан к нескольким TextSource - т.е. одна и та же копия документа может быть показана в разных окнах редакторов, расположенных на разных формах.
//
// Revision 1.1.2.4  2005/07/14 11:20:37  lulin
// - new interface: InevTextSourcePool.
//
// Revision 1.1.2.3  2005/07/14 10:41:52  lulin
// - cleanup.
//
// Revision 1.1.2.2  2005/07/14 10:24:30  lulin
// - реализация интерфейса IevSubList спущена с TextSource, на DocumentContainer.
//
// Revision 1.1.2.1  2005/07/14 09:07:51  lulin
// - new interface: InevTextSource.
// - new behavior: DocumentContainer теперь не знает напрямую о TextSource, а только через интерфейс InevTextSource - это задел на показ одного документа в нескольких окнах.
//

{$Include nevDefine.inc }

interface

uses
  l3Types,
  l3Interfaces,
  l3Variant,
  l3Tree_TLB,
  l3InternalInterfaces,
  l3Filer,

  k2Types,
  k2Interfaces,
  k2TagGen,
  k2Reader,
  k2DocumentGenerator,

  evdStyles,
  evInternalInterfaces,

  nevBase,
  nevTools
  ;

type
  TnevFilerEvents = record
    rInd : TObject;
  end;//TnevFilerEvents

  InevTextSourceInternal = interface(InevTextSource)
    ['{44A1934F-5893-47D4-AB47-8AD1465D18EF}']
    // property methods
      function  pm_GetProgress: Il3Progress;
        {-}
    // public methods
      procedure LinkDocumentContainer(const aContainer: InevDocumentContainer);
        {-}
      procedure CheckReader(aFormat       : TnevFormat;
                            anInternal    : Boolean;
                            var theReader : Tk2CustomReader);
        {-}
      procedure CheckWriter(aFormat       : TnevFormat;
                            anInternal    : Boolean;
                            var theWriter : Tk2TagGenerator;
                            aCodePage     : Integer = CP_DefaultValue);
        {-}
      function  CheckCloseWindow: Boolean;
        {-}
      function  HandleAbortLoad: Boolean;
        {* - Обрабатывает прерывание загрузки документа. }
      procedure Events2Filer(aFiler        : Tl3CustomFiler;
                             var theEvents : TnevFilerEvents);
        {-}
      procedure RestoreEvents(aFiler        : Tl3CustomFiler;
                              var theEvents : TnevFilerEvents);
        {-}
      procedure SetFlag(aFlag: TevUpdateWindowFlag);
        {* - установить флаг aFlag. }
    // public properties
      property Progress: Il3Progress
        read pm_GetProgress;
        {-}
  end;//InevTextSourceInternal

  InevTextSourcePool = interface(InevTextSourceInternal)
    ['{C6DB2F03-6977-4695-9E3E-F0BA42E82E27}']
    // public methods
      procedure LinkTextSource(const aTextSource: InevTextSourceInternal);
        {-}
      procedure UnlinkTextSource(const aTextSource: InevTextSourceInternal);
        {-}
  end;//InevTextSourcePool

  Tk2CustomReader = k2Reader.Tk2CustomReader;
  Tk2TagGenerator = k2TagGen.Tk2TagGenerator;

  InevDocumentContainerInternal = interface(InevBase)
    ['{4FA49A5A-21E1-48BB-8B8F-6B8BF8894C1F}']
    // property methods
      function  Get_InternalDocument: Tl3Tag;
        {-}
    // public methods
      procedure GetReader(aFormat        : TnevFormat;
                          const aPool    : IStream;
                          out theReader  : Tk2CustomReader;
                          anInternal     : Boolean = true;
                          aCodePage      : Integer = CP_DefaultValue;
                          const aBlock   : IUnknown = nil);
        {-}
      procedure GetWriter(aFormat             : TnevFormat;
                          anInternal          : Boolean;
                          out theWriter       : Tk2TagGenerator;
                          const aFilters      : Ik2TagGenerator;
                          aCodePage           : Integer = CP_DefaultValue);
        {-}
    // public properties
      property Document: Tl3Tag
        read Get_InternalDocument;
        {* - документ. }
  end;//InevDocumentContainerInternal

implementation

end.

