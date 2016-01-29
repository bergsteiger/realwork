unit evTextSource;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: ev - }
{ Начат: 16.09.2004 14:02 }
{ $Id: evTextSource.pas,v 1.459 2013/12/19 11:43:44 lulin Exp $ }

// $Log: evTextSource.pas,v $
// Revision 1.459  2013/12/19 11:43:44  lulin
// {RequestLink:509115763}
//
// Revision 1.458  2008/11/13 13:09:06  dinishev
// <K> : 121156019
//
// Revision 1.457  2008/10/28 09:50:12  dinishev
// <K> : 121156019
//
// Revision 1.456  2008/10/09 13:37:34  lulin
// - <K>: 121145547.
//
// Revision 1.455  2008/05/16 15:54:57  lulin
// - cleanup.
//
// Revision 1.4  2007/12/04 12:47:06  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.3.14.8  2005/12/09 13:45:18  lulin
// - cleanup.
//
// Revision 1.3.14.7  2005/12/03 20:00:16  lulin
// - удален старый механизм перехода на метки. Теперь все делается через Waiter'ов.
//
// Revision 1.3.14.6  2005/10/05 09:18:46  lulin
// - cleanup.
//
// Revision 1.3.14.5  2005/07/27 19:25:37  lulin
// - избавился от глобальных объектов для КЗ - теперь с каждым редактором связана своя обвязка для карточки запроса.
//
// Revision 1.3.14.4  2005/07/27 13:12:24  lulin
// - поскольку один контейнер документа теперь бывает привязанным к нескольком TextSource, то отвязали событие о создании оглавления от контейнера и перенесли его на TextSource.
//
// Revision 1.3.14.3  2005/07/25 10:54:36  lulin
// - события нотификации перенесены с контейнера документа и процессора на TextSource.
//
// Revision 1.3.14.2  2005/07/21 13:57:42  lulin
// - убраны лишние свойства с процессора операций.
//
// Revision 1.3.14.1  2005/07/13 15:36:29  lulin
// - new unit: evEditorWindowTextSource.
//
// Revision 1.3  2004/12/15 16:35:19  dinishev
// реализация получения картинки для кнопки
//
// Revision 1.2  2004/11/15 16:44:38  lulin
// - свойство OnGetControlData сделано published на классе TevTextSource.
//
// Revision 1.1  2004/09/16 11:30:50  lulin
// - навел подобие порядка с регистрацией компонент библиотеки.
//

{$Include evDefine.inc }

interface

uses
  evEditorWindowTextSource
  ;

type
  TevTextSource = class(TevEditorWindowTextSource)
    published
      property Processor;
        {-}
      property DocumentContainer;
        {-}
      property Indicator;
        {-}
      property Next;
        {-}
      property PrintDialog;
        {-}
      property ReadOnly;
        {-}
      property NeedProcessMessages;
        {-}
      property OnChangeModified;
        {-признак изменения документа}
      property OnGetReader;
        {-}
      property OnGetFileReader;
        {-}
      property OnGetWriter;
        {-}
      property OnGetControlData;
        {-}
      property OnGetControlItemImg;
        {-}
      property OnNettoCharCountChange;
        {-}
      property OnBruttoCharCountChange;
        {-}
      property OnTextParaCountChange;
        {-}
      property OnTOCCreated;
        {-}
      {$IfNDef Nemesis}
      property OnGetSubFlagsIterator;
        {-}
      {$EndIf  Nemesis}  
      property OnDocumentChanged;
        {-}
  end;//TevTextSource

implementation

end.

