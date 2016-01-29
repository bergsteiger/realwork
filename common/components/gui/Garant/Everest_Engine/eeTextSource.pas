unit eeTextSource;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: eeTextSource -  }
{ Начат: 03.07.2003 13:15 }
{ $Id: eeTextSource.pas,v 1.2 2014/04/21 11:58:14 lulin Exp $ }

// $Log: eeTextSource.pas,v $
// Revision 1.2  2014/04/21 11:58:14  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.1  2010/09/23 11:30:03  lulin
// {RequestLink:235053048}.
//
// Revision 1.15  2009/04/02 13:35:20  lulin
// - делаем возможность отдавать иконки в design-time.
//
// Revision 1.14  2008/04/24 08:15:30  lulin
// - cleanup.
//
// Revision 1.13  2007/12/04 12:47:34  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.10.14.8  2007/12/03 15:51:42  lulin
// - cleanup.
//
// Revision 1.10.14.7  2006/12/11 09:55:23  oman
// - new: HiddenStyles перенесены с DocumentContainer на редактор (cq12564)
// - new: Изменена схема кэширования превью на DocumentContainer
//
// Revision 1.10.14.6  2005/12/09 13:45:21  lulin
// - cleanup.
//
// Revision 1.10.14.5  2005/12/03 20:00:18  lulin
// - удален старый механизм перехода на метки. Теперь все делается через Waiter'ов.
//
// Revision 1.10.14.4  2005/11/14 18:37:00  lulin
// - теперь при заборе в буфер обмена в него кладется контейнер документа, а не TextSource - должно починить ошибку CQ OIT5-17870.
//
// Revision 1.10.14.3  2005/10/20 09:34:36  lulin
// - bug fix: при внутренней записи цеплялись ненужные фильтры.
//
// Revision 1.10.14.2  2005/09/16 10:47:12  lulin
// - вынесен метод для создания контейнера документа.
//
// Revision 1.10.14.1  2005/07/27 13:12:26  lulin
// - поскольку один контейнер документа теперь бывает привязанным к нескольком TextSource, то отвязали событие о создании оглавления от контейнера и перенесли его на TextSource.
//
// Revision 1.10  2004/12/06 13:24:12  lulin
// - от классов переходим к интерфейсам.
//
// Revision 1.9  2004/10/20 12:13:48  lulin
// - new behavior: для печати и экспорта привешен фильтр ddSectionRepair - для расстановки корректных разрывов секций.
//
// Revision 1.8  2004/10/19 12:00:35  lulin
// - new prop: _TevCustomTextSource.OnChangeHiddenStyles (CQ OIT5-10339).
//
// Revision 1.7  2004/04/26 12:18:45  law
// - bug fix: не компилировалось, т.к. в предке была изменена сигнатура метода.
//
// Revision 1.6  2004/01/12 18:20:16  law
// - new method: TeeHiddenFilter.SetTo.
//
// Revision 1.5  2004/01/12 16:27:21  nikitin75
// + TeeTextSource._GetWriter: создаем Writer и цепляем к нему фильтр показываемого;
//
// Revision 1.4  2003/11/20 12:23:07  nikitin75
// + procedure TeeTextSource.SetDocumentWidth(aWidth: Longint);
//
// Revision 1.3  2003/10/14 15:13:31  law
// - change: TeeTextExport.OnStartAtom, OnFinishAtom теперь published.
//
// Revision 1.2  2003/07/03 15:04:36  law
// - new behavior: учитываем Sub на который надо перейти.
// - new event: TeeTextSource.OnAllowGotoSub.
//
// Revision 1.1  2003/07/03 09:41:48  law
// - new event: _OnDocumentChanged - сделана возможность узнавать о смене документа в TextSource.
//

{$I eeDefine.inc }

interface

uses
  Windows,

  l3Types,
  l3Chars,

  k2TagGen,

  evTypes,

  eeTextSourceExport
  ;

type
  TeeTextSource = class(TeeTextSourceExport)
    published
    // published events
      property OnMakeDocumentContainer;
        {-}
      property OnDocumentChanged;
        {-}
      property OnTOCCreated;
        {-}
      property OnGetControlItemImg;
        {-}
  end;//TeeTextSource

implementation

end.

