unit evEditorWindowTextSource;

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: evEditorWindowTextSource - }
{ Начат: 13.07.2005 19:10 }
{ $Id: evEditorWindowTextSource.pas,v 1.9 2012/11/01 14:39:29 kostitsin Exp $ }

// $Log: evEditorWindowTextSource.pas,v $
// Revision 1.9  2012/11/01 14:39:29  kostitsin
// [$407743861]
//
// Revision 1.8  2012/08/08 13:07:44  dinishev
// {Requestlink:380623516}
//
// Revision 1.7  2012/08/08 11:04:56  dinishev
// {Requestlink:380623516}
//
// Revision 1.6  2008/10/09 13:37:34  lulin
// - <K>: 121145547.
//
// Revision 1.5  2008/05/16 15:20:35  lulin
// - переносим на модель.
//
// Revision 1.4  2007/12/25 23:55:50  lulin
// - модуль l3Tree_TLB полностью перенесен на модель.
//
// Revision 1.3  2007/12/04 12:47:01  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.1.2.20  2007/11/28 13:28:27  dinishev
// Bug fix: Не обновляли дерево документа в Арчи и Эвересте
//
// Revision 1.1.2.19  2005/12/15 14:29:20  lulin
// - cleanup.
//
// Revision 1.1.2.18  2005/12/15 14:22:13  lulin
// - cleanup.
//
// Revision 1.1.2.17  2005/12/09 14:12:45  lulin
// - bug fix: не вызывалась нотификация об изменении содержимого контейнера.
//
// Revision 1.1.2.16  2005/12/08 13:48:42  lulin
// - cleanup.
//
// Revision 1.1.2.15  2005/12/05 09:06:15  lulin
// - валидация генерации документа полностью переехала с TextSource на DocumentContainer.
//
// Revision 1.1.2.14  2005/12/03 14:46:53  lulin
// - избавляемся от хитросплетений методов TextSource и контейнера документа.
//
// Revision 1.1.2.13  2005/11/14 18:36:57  lulin
// - теперь при заборе в буфер обмена в него кладется контейнер документа, а не TextSource - должно починить ошибку CQ OIT5-17870.
//
// Revision 1.1.2.12  2005/10/18 07:19:40  lulin
// - new behavior: теперь методы вставки и добавления дочерних тегов могут подменять вставляемые теги.
//
// Revision 1.1.2.11  2005/09/01 17:46:22  lulin
// - теперь стало показываться оглавление в виде нового дерева.
//
// Revision 1.1.2.10  2005/09/01 16:34:06  lulin
// - оглавление документа переведено на Il3SimpleNode.
//
// Revision 1.1.2.9  2005/07/28 15:37:05  lulin
// - правки в соответствии с изменениями Вована в интерфейсах нотификаторов.
//
// Revision 1.1.2.8  2005/07/27 13:12:23  lulin
// - поскольку один контейнер документа теперь бывает привязанным к нескольком TextSource, то отвязали событие о создании оглавления от контейнера и перенесли его на TextSource.
//
// Revision 1.1.2.7  2005/07/25 18:09:15  lulin
// - теперь TextSource не знает про реализацию контейнера документа, а только про его интерфейс.
//
// Revision 1.1.2.6  2005/07/25 10:54:36  lulin
// - события нотификации перенесены с контейнера документа и процессора на TextSource.
//
// Revision 1.1.2.5  2005/07/21 05:05:03  lulin
// - распилил модуль с TextSource на несколько.
//
// Revision 1.1.2.4  2005/07/15 12:41:56  lulin
// - теперь процеесор операций знает не про безликого Owner'а, а про вполне конкретный DocumentContainer.
//
// Revision 1.1.2.3  2005/07/15 10:14:03  lulin
// - избавляемся от использования самостийной функции преобразования интерфейсов.
//
// Revision 1.1.2.2  2005/07/14 09:07:46  lulin
// - new interface: InevTextSource.
// - new behavior: DocumentContainer теперь не знает напрямую о TextSource, а только через интерфейс InevTextSource - это задел на показ одного документа в нескольких окнах.
//
// Revision 1.1.2.1  2005/07/13 15:36:29  lulin
// - new unit: evEditorWindowTextSource.
//

{$Include evDefine.inc }

interface

uses
  Classes,

  l3Interfaces,
  l3TreeInterfaces,
  l3Tree_TLB,
  l3Tree,

  k2Interfaces,
  k2DocumentGenerator,

  evInternalInterfaces,
  evCustomTextSource,

  nevTools
  ;

type
  TevTOCCreatedEvent = procedure(aSender    : TObject;
                                 const aTOC : Il3SimpleTree) of object;
  
  TevEditorWindowTextSource = class(TevCustomTextSource)
   {* Источник документа, привязанный к окну (см. TevCustomEditorWindow). }
    private
    // property fields
      f_OnNettoCharCountChange  : TNotifyEvent;
      f_OnBruttoCharCountChange : TNotifyEvent;
      f_OnTextParaCountChange   : TNotifyEvent;
      f_OnTOCCreated            : TevTOCCreatedEvent;
      f_OnChangeModified        : TNotifyEvent;
    protected
    // internal methods
      procedure SignalDocumentLoaded;
        override;
        {-}
      procedure TOCCreated;
        {-}
      procedure InitAACLikeCursor;
        {-}
      procedure Notify(const aNotifier  : Il3ChangeNotifier;
                       aOperation       : Integer;
                       aIndex           : Integer);
        override;
        {-}
    protected
    // internal methods
      function  DoMakeDocumentContainer: InevDocumentContainer;
        override;
        {-}
    public
    // public events
      property OnChangeModified: TNotifyEvent
        read f_OnChangeModified
        write f_OnChangeModified;
        {* - нотификация об изменении свойства Modified. }
      property OnNettoCharCountChange: TNotifyEvent
        read f_OnNettoCharCountChange
        write f_OnNettoCharCountChange;
        {* - изменилось свойство NettoCharCount. }
      property OnBruttoCharCountChange : TNotifyEvent
        read f_OnBruttoCharCountChange
        write f_OnBruttoCharCountChange;
        {* - изменилось свойство BruttoCharCount. }
      property OnTextParaCountChange : TNotifyEvent
        read f_OnTextParaCountChange
        write f_OnTextParaCountChange;
        {* - изменилось свойство TextParaCount. }
      property OnTOCCreated: TevTOCCreatedEvent
        read f_OnTOCCreated
        write f_OnTOCCreated;
        {-}  
  end;//TevEditorWindowTextSource

implementation

uses
  SysUtils,

  l3Base,
  l3Types,
  l3InterfacesMisc,
  
  k2Tags,
  
  evEditorWindowProcessor,

  nevPrintableDocumentContainer
  ;

// start class TevCustomEditorTextSource

function TevEditorWindowTextSource.DoMakeDocumentContainer: InevDocumentContainer;
  {override;}
  {-}
begin
 Result := TnevPrintableDocumentContainer.Make;
end;

procedure TevEditorWindowTextSource.Notify(const aNotifier  : Il3ChangeNotifier;
                                                                  aOperation       : Integer;
                                                                  aIndex           : Integer);
  //override;
  {-}
begin
 inherited;
 Case aOperation of
  Ord(nev_deNettoCharCountChange) :
   if Assigned(f_OnNettoCharCountChange) then
    f_OnNettoCharCountChange(Self);
  Ord(nev_deBruttoCharCountChange) :
   if Assigned(f_OnBruttoCharCountChange) then
    f_OnBruttoCharCountChange(Self);
  Ord(nev_deTextParaCountChange) :
   if Assigned(f_OnTextParaCountChange) then
    f_OnTextParaCountChange(Self);
  Ord(nev_deTOCCreated) :
   TOCCreated;
  Ord(nev_deChangeModified) :
   if Assigned(f_OnChangeModified) then
    f_OnChangeModified(Self);
 end;//Case aOperation
end;

procedure TevEditorWindowTextSource.SignalDocumentLoaded;
  //override;
  {-}
begin
 TOCCreated;
 inherited;
end;

procedure TevEditorWindowTextSource.TOCCreated;
  {-}
var
 l_Explorer : Il3SimpleTree;
begin
 if Assigned(f_OnTOCCreated) then
 begin
  l_Explorer := ContentsTree;
  if (l_Explorer <> nil) AND (l_Explorer.CountView <= 0) then
   l_Explorer := nil;
  f_OnTOCCreated(Self, l_Explorer);
 end;//Assigned(f_OnTOCCreated)
 InitAACLikeCursor;
end;

procedure TevEditorWindowTextSource.InitAACLikeCursor;

 function lp_InitAACLikeCursor(pO: PObject; Index: Long): Bool;
 var
  l_CS : IevCursorSource;
 begin
  if Supports(pO^, IevCursorSource, l_CS) then
   l_CS.InitAACLikeCursor;
  Result := True;
 end;

begin
 if HasEditors then
  Editors.IterateAllF(l3L2IA(@lp_InitAACLikeCursor));
end;

end.

