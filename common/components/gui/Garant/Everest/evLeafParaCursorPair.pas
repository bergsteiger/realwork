unit evLeafParaCursorPair;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evLeafParaCursorPair - }
{ Начат: 16.10.2003 19:36 }
{ $Id: evLeafParaCursorPair.pas,v 1.22 2016/09/08 11:19:50 dinishev Exp $ }

// $Log: evLeafParaCursorPair.pas,v $
// Revision 1.22  2016/09/08 11:19:50  dinishev
// {Requestlink:629346150}. Вторая попытка.
//
// Revision 1.21  2014/04/08 12:35:09  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.20  2009/07/14 14:56:26  lulin
// {RequestLink:141264340}. №25.
//
// Revision 1.19  2009/07/10 15:04:43  lulin
// - избавляемся от лишнего дёрганья счётчиков ссылок.
//
// Revision 1.18  2009/04/03 17:51:27  lulin
// [$140837386]. Ликвидируем старорежимную примесь.
//
// Revision 1.17  2008/04/10 17:34:24  lulin
// - <K>: 89097983.
//
// Revision 1.16  2008/04/02 14:22:01  lulin
// - cleanup.
//
// Revision 1.15  2008/02/28 15:12:01  lulin
// - переносим nevTools на модель.
//
// Revision 1.14  2007/12/04 12:47:02  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.12.2.21  2007/06/22 20:18:31  lulin
// - cleanup.
//
// Revision 1.12.2.20  2007/01/05 14:37:19  lulin
// - cleanup.
//
// Revision 1.12.2.19  2006/11/03 11:00:05  lulin
// - объединил с веткой 6.4.
//
// Revision 1.12.2.18.6.1  2006/10/12 17:45:21  lulin
// - вычищаем все, что связано с дозагрузкой документа.
//
// Revision 1.12.2.18  2006/09/18 16:44:32  lulin
// - сделан переход по гиперссылкам назад (CQ OIT5-21613).
//
// Revision 1.12.2.17  2006/09/18 07:20:37  lulin
// - убран ненужный параметр.
//
// Revision 1.12.2.16  2006/07/10 14:55:45  lulin
// - убрана инициализация ссылки на родительский объект выделения.
//
// Revision 1.12.2.15  2005/09/23 16:03:55  lulin
// - выделен модуль с общими интерфейсами.
//
// Revision 1.12.2.14  2005/07/21 06:05:47  lulin
// - в процедуре поиска модифицируемый курсор заменен на немодифицируемый.
//
// Revision 1.12.2.13  2005/07/20 18:21:14  lulin
// - убран переходный интерфейс.
//
// Revision 1.12.2.12  2005/07/20 15:13:18  lulin
// - убрано косвенное получение инструментов для чтения/записи тега.
//
// Revision 1.12.2.11  2005/07/19 15:32:23  lulin
// - убрана часть обращений к интересующим интерфейсам через цепочку Parent'ов диапазонов и курсоров.
//
// Revision 1.12.2.10  2005/07/18 11:22:37  lulin
// - методу, возвращаещему выделение на параграфе дано более подходящее название.
//
// Revision 1.12.2.9  2005/06/15 13:06:00  lulin
// - убрана инициализация блоков выделения в явном виде.
//
// Revision 1.12.2.8  2005/06/07 13:43:47  lulin
// - удален ненужный модуль.
//
// Revision 1.12.2.7  2005/06/03 12:08:19  lulin
// - cleanup: убраны ненужные зависимости.
//
// Revision 1.12.2.6  2005/06/02 12:33:08  lulin
// - вчерне заменил прямое создание блока выделения на его получение от фабрики.
//
// Revision 1.12.2.5  2005/06/01 16:22:25  lulin
// - remove unit: evIntf.
//
// Revision 1.12.2.4  2005/05/31 17:09:19  lulin
// - изживаем остатки объектов в качестве курсоров.
//
// Revision 1.12.2.3  2005/05/20 11:27:35  lulin
// - класс TevBlock вынесен в отдельный модуль.
//
// Revision 1.12.2.2  2005/05/19 14:52:38  lulin
// - rename unit: evBlock -> evCursorPair.
//
// Revision 1.12.2.1  2005/05/18 12:42:47  lulin
// - отвел новую ветку.
//
// Revision 1.11.2.1  2005/05/18 12:32:09  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.12  2005/05/16 15:31:11  lulin
// - cleanup: прямое использование объекта заменено на использование интерфейса.
//
// Revision 1.11  2005/03/19 16:39:51  lulin
// - спрятаны ненужные методы.
//
// Revision 1.10  2005/03/16 12:16:52  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.9  2004/12/22 15:24:29  lulin
// - при построении _preview теперь документ зачитывается целиком, а не кусочками.
//
// Revision 1.8  2004/10/20 15:52:05  lulin
// - new behavior: не прогружаем весь документ при позиционировании на параграф.
//
// Revision 1.7  2004/10/19 13:37:44  lulin
// - bug fix: сбивался Top в редакторе, при синхронизации установки закладки.
//
// Revision 1.6  2004/06/23 09:41:45  law
// - догрузка параграфов при поиске перенесена с Searcher'а на выделение.
//
// Revision 1.5  2004/06/22 16:51:35  law
// - bug fix: не печатался (не сохранялся) первый догруженный текстовый параграф.
//
// Revision 1.4  2004/06/22 15:18:26  law
// - проведена подготовка для догрузки документа при печати, заборе в буфер обмена и т.п.
//
// Revision 1.3  2004/05/27 15:31:31  fireton
// - change: в Check searcher'a теперь передается предыдущий блок
// - bug fix: нормальный поиск по словосочетаниям с морфологией
//
// Revision 1.2  2004/05/06 09:19:21  law
// - change: функциональность TevTextParaCursorPair.SearchPrim перенесена в _TevLeafParaCursorPair.SearchPrim.
//
// Revision 1.1  2003/10/16 15:46:57  law
// - new unit: evLeafParaCursorPair.
//

{$Include evDefine.inc }

interface

uses
  l3Types,
  l3Interfaces,
  l3Base,

  evInternalInterfaces,
  evCursorPair,

  nevBase,
  nevTools
  ;

type
  TevLeafParaCursorPair = class(TevCursorPair)
    protected
    // internal methods
      function  SearchPrim(const aView : InevView;
                           const aSearcher : IevSearcher;
                           const Progress  : Il3Progress;
                           const aStart    : InevBasePoint;
                           const aContext  : TevSearchContext;
                           out cFStart     : InevBasePoint;
                           out cFFinish    : InevBasePoint): Boolean;
        override;
        {-ищет подстроку и возвращает найденную позицию в (cFStart, cFFinish)}
  end;//TevLeafParaCursorPair

implementation

uses
  k2Tags,

  evOp,
  evTypes
  ;

// start class TevLeafParaCursorPair

function TevLeafParaCursorPair.SearchPrim(const aView : InevView;
                                          const aSearcher : IevSearcher;
                                          const Progress  : Il3Progress;
                                          const aStart    : InevBasePoint;
                                          const aContext  : TevSearchContext;
                                          out cFStart     : InevBasePoint;
                                          out cFFinish    : InevBasePoint): Boolean;

   function lp_GetRange: InevRange;
   var
    l_Start : InevBasePoint;
    l_Finish: InevBasePoint;
   begin
    if (ev_soBackward in aSearcher.Options) then
    begin
     l_Start := f_Start;
     l_Finish := aStart;
    end // if (ev_soBackward in aSearcher.Options) then
    else
    begin
     l_Start := aStart;
     l_Finish := f_Finish;
    end;
    if aContext.rSelectCellType = ev_spWholeCell then
    begin
     if (l_Start <> nil) then
      l_Start.Move(aView, ev_ocTopLeft);
     if (l_Finish <> nil) then
      l_Finish.Move(aView, ev_ocBottomRight);
    end; // if aContext.rSelectCellType = ev_spWholeCell then
    Result := ParaX.Range(l_Start, l_Finish);
   end;
  {override;}
  {-ищет подстроку и возвращает найденную позицию в (cFStart, cFFinish)}
begin
 Result := aSearcher.Check(aView, lp_GetRange, cFStart, cFFinish, nil)
end;

end.

