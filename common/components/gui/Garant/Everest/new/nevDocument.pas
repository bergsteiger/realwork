unit nevDocument;

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: nevDocument -   }
{ Начат: 10.04.2005 19:04 }
{ $Id: nevDocument.pas,v 1.18 2014/03/18 15:57:02 lulin Exp $ }

// $Log: nevDocument.pas,v $
// Revision 1.18  2014/03/18 15:57:02  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.17  2011/09/01 13:44:30  lulin
// {RequestLink:280006084}.
//
// Revision 1.16  2011/07/08 17:05:53  lulin
// {RequestLink:228688745}.
//
// Revision 1.15  2009/03/30 09:54:27  lulin
// [$140286312]. Заплатка для Архивариуса.
//
// Revision 1.14  2008/09/17 11:48:51  lulin
// - переносим TnevNullPara на модель.
//
// Revision 1.13  2008/09/17 08:54:21  lulin
// - переносим TnevPara на модель.
//
// Revision 1.12  2008/09/15 08:39:31  lulin
// - <K>: 115344011.
//
// Revision 1.11  2008/04/30 13:00:35  lulin
// - <CQ>: 28980.
//
// Revision 1.10  2008/04/29 16:56:54  lulin
// - работы по <K>: 89106312.
//
// Revision 1.9  2008/04/16 17:24:29  lulin
// - <K>: 88641746.
//
// Revision 1.8  2008/04/07 11:59:59  lulin
// - <K>: 89096763.
//
// Revision 1.7  2008/02/27 18:19:52  lulin
// - подгоняем код под модель.
//
// Revision 1.6  2007/12/29 12:24:03  oman
// - fix: Правильная отрисовка полей - опечетки в названиях (cq23109, c79303231)
//
// Revision 1.5  2007/12/29 11:50:25  oman
// - fix: Правильная отрисовка полей (cq23109, c79303231)
//
// Revision 1.4  2007/12/17 15:10:36  lulin
// - при выводе в стиле Web не используем правый отступ документа.
//
// Revision 1.3  2007/12/04 12:47:51  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.1.4.20  2006/08/02 12:50:03  lulin
// - убрано лишнее свойство.
//
// Revision 1.1.4.19  2006/08/02 10:52:00  lulin
// - объединил с веткой в которой боролся со скроллингом.
//
// Revision 1.1.4.18.2.2  2006/08/01 14:56:04  lulin
// - у отображаемых объектов убрано свойство "высота", ее надо брать из карты форматирования.
//
// Revision 1.1.4.18.2.1  2006/07/27 13:54:17  lulin
// - убрано ненужное свойство.
//
// Revision 1.1.4.18  2006/07/17 15:14:48  lulin
// - из комментариев убрано название метода - чтобы не искался контекстным поиском.
//
// Revision 1.1.4.17  2006/07/17 14:52:13  lulin
// - из комментариев убрано название метода - чтобы не искался контекстным поиском.
//
// Revision 1.1.4.16  2006/05/03 12:43:14  lulin
// - bug fix: в новостной ленте был паразитный горизонтальный скроллер (CQ OIT5-19525).
//
// Revision 1.1.4.15  2006/03/02 13:25:05  lulin
// - теперь View не хранит ссылку на Shape, а получает его у контрола.
//
// Revision 1.1.4.14  2005/11/28 14:53:52  lulin
// - убрано излишнее кеширование.
//
// Revision 1.1.4.13  2005/11/11 21:52:16  lulin
// - bug fix: убраны утечки объектов документа, связанные с неправильным владением Undo-буфером.
//
// Revision 1.1.4.12  2005/11/04 12:45:59  lulin
// - optimization: избавился от необходимости расчета _AbsIndex если якорь документа находится в самом начале или в самом конце.
//
// Revision 1.1.4.11  2005/10/05 11:06:27  lulin
// - коррекция отступов для блоков перенесена в более правильное место.
//
// Revision 1.1.4.10  2005/09/23 16:04:04  lulin
// - выделен модуль с общими интерфейсами.
//
// Revision 1.1.4.9  2005/07/21 16:03:59  lulin
// - теперь контейнер документа обладает статистикой о документе.
//
// Revision 1.1.4.8  2005/07/19 09:54:33  lulin
// - приводим родителя к контейнеру документа более дешевым способом.
//
// Revision 1.1.4.7  2005/07/15 09:30:45  lulin
// - теперь параграфы знают про DocumentContainer, DocumentContainer знает про TextSource, а TextSource - знает про редакторы.
//
// Revision 1.1.4.6  2005/06/30 16:38:19  lulin
// - выключено кеширование атрибутов тегов, как вредное и приводящее к лишней нотификации и в силу этого к замедлению при загрузке документа.
//
// Revision 1.1.4.5  2005/06/29 12:21:26  lulin
// - new prop: InevROParaList._AlmostLinear.
//
// Revision 1.1.4.4  2005/06/29 05:56:17  lulin
// - убрана очевидная тавтология.
//
// Revision 1.1.4.3  2005/06/27 14:16:49  lulin
// - new behavior: для вертикального скроллера используем AllChildrenCount.
//
// Revision 1.1.4.2  2005/06/25 14:25:01  lulin
// - new behavior: View теперь умеет контроллировать изменение размеров скроллера и сообщать об этом контролу.
//
// Revision 1.1.4.1  2005/05/18 12:42:59  lulin
// - отвел новую ветку.
//
// Revision 1.1.2.1  2005/04/12 10:18:46  lulin
// - новые файлы переехали в новый каталог.
//
// Revision 1.1.2.7  2005/04/11 16:52:28  lulin
// - new interface: InevScroller.
//
// Revision 1.1.2.6  2005/04/11 16:31:34  lulin
// - new methods: IevScrollView.LinkShape, UnlinkShape.
//
// Revision 1.1.2.5  2005/04/11 11:30:09  lulin
// - выделен метод LookAtView.
//
// Revision 1.1.2.4  2005/04/11 11:24:49  lulin
// - new interface: InevViewMetrics.
//
// Revision 1.1.2.3  2005/04/10 16:09:44  lulin
// - new behavior: кешируем число текстовых параграфов.
//
// Revision 1.1.2.2  2005/04/10 15:42:55  lulin
// - new behavior: рассчитываем приблизительную высоту документа исходя из общего количества текстовых параграфов.
//
// Revision 1.1.2.1  2005/04/10 15:20:04  lulin
// - new unit: nevDocument.
//

{$Include nevDefine.inc }

interface

uses
  k2Interfaces,

  nevBase,
  nevTools,

  nevParaList
  ;

type
  TnevDocument = class(TnevParaList)
    protected
    // internal methods
      function  GetDocumentContainer: InevDocumentContainer;
        override;
        {-}
      function  GetHolder: InevObjectHolder;
        override;
        {-}
      function  CanCacheTagState: Boolean;
        override;
        {-}
      function  GetAppliesToMaxWidth: Boolean;
        override;
        {-}
  end;//TnevDocument

implementation

// start class TnevDocument

function TnevDocument.CanCacheTagState: Boolean;
  //override;
  {-}
begin
 Result := false;
end;

function TnevDocument.GetAppliesToMaxWidth: Boolean;
  //override;
  {-}
begin
 Result := false;
end;

function TnevDocument.GetDocumentContainer: InevDocumentContainer;
  //override;
  {-}
begin
 if not OwnerTag.GetOwnInterface(InevDocumentContainer, Result) then
  Result := inherited GetDocumentContainer;
end;

function TnevDocument.GetHolder: InevObjectHolder;
  //override;
  {-}
begin
 if not OwnerTag.GetOwnInterface(InevObjectHolder, Result) then
  Result := pm_GetDocumentContainer;
end;

end.

