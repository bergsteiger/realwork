unit eeTextSourceExport;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: eeTextSourceExport -  }
{ Начат: 18.02.2003 15:24 }
{ $Id: eeTextSourceExport.pas,v 1.5 2015/01/19 18:36:39 lulin Exp $ }

// $Log: eeTextSourceExport.pas,v $
// Revision 1.5  2015/01/19 18:36:39  lulin
// {RequestLink:580710025}
//
// Revision 1.4  2014/08/21 10:19:04  lulin
// - чиним библиотеки.
//
// Revision 1.3  2014/07/01 12:19:54  lulin
// - пытаемся собрать несобирающееся.
//
// Revision 1.2  2014/03/20 12:23:58  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.1  2010/09/23 11:30:03  lulin
// {RequestLink:235053048}.
//
// Revision 1.65  2010/02/11 13:45:28  lulin
// - выкидываем неудавшийся фасад.
//
// Revision 1.64  2009/03/03 17:42:02  lulin
// - <K>: 137470629. Убран ненужный промежуточный модуль.
//
// Revision 1.63  2008/12/12 19:19:17  lulin
// - <K>: 129762414.
//
// Revision 1.62  2008/10/09 13:37:37  lulin
// - <K>: 121145547.
//
// Revision 1.61  2008/06/20 14:48:54  lulin
// - используем префиксы элементов.
//
// Revision 1.60  2008/06/09 12:16:51  lulin
// - bug fix: не собирался Немезис.
//
// Revision 1.59  2008/04/02 11:35:39  lulin
// - удалена ненужная функциональность связанная с поддержкой оглавления в клиенте Ф1.
//
// Revision 1.58  2008/02/14 17:08:58  lulin
// - cleanup.
//
// Revision 1.57  2007/12/04 12:47:34  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.55.2.34  2007/12/03 15:51:42  lulin
// - cleanup.
//
// Revision 1.55.2.33  2007/09/04 17:27:39  lulin
// - убран ненужный параметр.
//
// Revision 1.55.2.32  2007/08/09 14:55:22  lulin
// - избавляемся от излишнего использования интерфейсов.
//
// Revision 1.55.2.31  2007/08/02 19:41:39  lulin
// - cleanup.
//
// Revision 1.55.2.30  2007/08/02 19:33:19  lulin
// - cleanup.
//
// Revision 1.55.2.29  2007/06/26 10:42:45  lulin
// - cleanup.
//
// Revision 1.55.2.28  2006/12/20 17:49:48  lulin
// - файл с константами переехал в общую папку.
//
// Revision 1.55.2.27  2006/03/30 11:49:24  lulin
// - cleanup: вытираем код для редактирования комментариев не в виде дерева.
//
// Revision 1.55.2.26  2006/02/08 16:13:07  lulin
// - cleanup.
//
// Revision 1.55.2.25  2006/01/24 12:09:49  lulin
// - cleanup.
//
// Revision 1.55.2.24  2005/12/05 09:06:19  lulin
// - валидация генерации документа полностью переехала с TextSource на DocumentContainer.
//
// Revision 1.55.2.23  2005/12/01 08:02:37  lulin
// - cleanup: хитрая обработка добавляемых тегов (в частности формирование оглавления) перенесена с TextSource на DocumentContainer.
//
// Revision 1.55.2.22  2005/12/01 05:59:22  lulin
// - cleanup: избавляемся от транслции свойства HiddenStyles от редактора к котнтейнеру и обратно.
//
// Revision 1.55.2.21  2005/11/18 15:36:02  lulin
// - bug fix: был AV при вставке Конституции в Конституцию - как комментария.
//
// Revision 1.55.2.20  2005/11/18 11:34:27  lulin
// - bug fix: при вставке в комментарий не перемещался курсор.
//
// Revision 1.55.2.19  2005/11/16 11:27:16  lulin
// - bug fix: не даем вставить два подряд комментария, а объединяем их в один.
//
// Revision 1.55.2.18  2005/11/15 13:50:05  lulin
// - cleanup: используем только Reader тегов - не подкладывая под него Pool. Связывание теперь осуществляется раньше.
//
// Revision 1.55.2.17  2005/11/14 19:05:44  lulin
// - bug fix: не компилировалось.
//
// Revision 1.55.2.16  2005/11/14 13:53:09  lulin
// - bug fix: при выделении не вставлялись комментарии (CQ OIT5-18019).
//
// Revision 1.55.2.15  2005/11/05 09:03:17  lulin
// - выделяем у якоря и у курсора общую функциональность.
//
// Revision 1.55.2.14  2005/09/16 10:47:12  lulin
// - вынесен метод для создания контейнера документа.
//
// Revision 1.55.2.13  2005/09/01 16:34:09  lulin
// - оглавление документа переведено на Il3SimpleNode.
//
// Revision 1.55.2.12  2005/07/25 18:09:18  lulin
// - теперь TextSource не знает про реализацию контейнера документа, а только про его интерфейс.
//
// Revision 1.55.2.11  2005/07/20 18:21:17  lulin
// - убран переходный интерфейс.
//
// Revision 1.55.2.10  2005/07/19 12:50:09  lulin
// - часть базовых интерфейсов переехала в модуль nevTools.
//
// Revision 1.55.2.9  2005/07/15 11:29:37  lulin
// - избавляемся от использования самостийной функции преобразования интерфейсов.
//
// Revision 1.55.2.8  2005/07/15 10:14:05  lulin
// - избавляемся от использования самостийной функции преобразования интерфейсов.
//
// Revision 1.55.2.7  2005/07/14 10:24:28  lulin
// - реализация интерфейса IevSubList спущена с TextSource, на DocumentContainer.
//
// Revision 1.55.2.6  2005/07/14 09:07:48  lulin
// - new interface: InevTextSource.
// - new behavior: DocumentContainer теперь не знает напрямую о TextSource, а только через интерфейс InevTextSource - это задел на показ одного документа в нескольких окнах.
//
// Revision 1.55.2.5  2005/07/13 15:48:30  lulin
// - new unit: evEditorWindowTextSource.
//
// Revision 1.55.2.4  2005/07/04 06:51:18  lulin
// - bug fix: в документе, полученном как дерево, не рисовались Sub'ы.
//
// Revision 1.55.2.3  2005/06/22 17:14:54  lulin
// - cleanup.
//
// Revision 1.55.2.2  2005/06/01 16:22:28  lulin
// - remove unit: evIntf.
//
// Revision 1.55.2.1  2005/05/18 12:42:49  lulin
// - отвел новую ветку.
//
// Revision 1.52.2.3  2005/05/18 12:32:12  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.52.2.2  2005/04/28 09:18:32  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.52.2.1  2005/04/11 10:08:50  lulin
// - спрятан мусор, связанный с тем, что TextSource хранил максимальную ширину форматирования.
//
// Revision 1.52.4.1  2005/04/23 16:07:28  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.55  2005/05/16 10:00:23  lulin
// - bug fix: не компилировалось.
//
// Revision 1.54  2005/05/14 08:59:30  lulin
// - реструктурировано добавление элементов в структуру документа.
//
// Revision 1.53  2005/04/28 15:03:40  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.52.4.1  2005/04/23 16:07:28  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.52  2005/03/28 11:32:10  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.51  2005/03/21 06:44:56  lulin
// - убраны ненужные методы.
//
// Revision 1.50  2005/03/17 17:00:51  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.49  2005/03/11 15:48:59  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.48  2005/03/10 11:35:12  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.47  2005/03/10 08:34:11  lulin
// - bug fix: не компилировалось.
//
// Revision 1.46  2005/03/09 12:45:46  lulin
// - bug fix: не компилировалось.
//
// Revision 1.45  2005/02/03 10:08:34  lulin
// - рефакторинг вставки картинок в оглавление.
//
// Revision 1.44  2005/02/01 17:39:34  lulin
// - new behavior: при вставке комментариве отрезаем от параграфов не только ID, но и метки (Sub'ы, закладки и т.п.).
//
// Revision 1.43  2005/02/01 14:12:05  lulin
// - bug fix: при вставке комментарие теперь отрезаем ID параграфов - т.к. иначе на комментарии ставились закладки, ни и прочая...
//
// Revision 1.42  2004/11/26 15:06:12  lulin
// - bug fix: картинки из Clipboard'а не заворачивались в комментарий.
//
// Revision 1.41  2004/11/26 12:41:44  lulin
// - new behavior: избавляемся, от дублирующихся идентификаторов комментариев.
//
// Revision 1.40  2004/11/26 10:14:07  lulin
// - new behavior: при вставке текста "мимо" комментария - "оборачиваем" его в комментарий.
//
// Revision 1.39  2004/11/26 06:53:39  lulin
// - new behavior: запрещаем вставку вложенных комментариев пользователя.
//
// Revision 1.38  2004/11/25 16:42:12  lulin
// - new behavior: в комментарии не даем вставлять разрывы страниц и разделов.
//
// Revision 1.37  2004/11/18 15:58:53  lulin
// - отвязываем библиотеки от VCM без использования inc'ов.
//
// Revision 1.36  2004/11/17 14:01:13  lulin
// - bug fix: в результате перехода на блоки - отьехала синхронизация вставки комментариев.
//
// Revision 1.35  2004/11/16 10:19:20  lulin
// - вернул возможность вставлять в комментарии таблицы - т.к. они теперь корректно сохраняются.
//
// Revision 1.34  2004/10/21 19:35:09  lulin
// - bug fix: не создавали правильный DocumentContainer И из-за этого можно было редактировать текст (CQ OIT5-10544).
//
// Revision 1.33  2004/10/21 19:14:09  lulin
// - new behavior: не даем вставлять структурные элементы (таблицы, блоки и т.п.) - пока пользовательские комментарии это у нас PlainText - потом можно будет переделать (CQ OIT5-10512).
//
// Revision 1.32  2004/10/21 12:20:36  lulin
// - выкинул лишний для define _k2NeedFilterContents код.
//
// Revision 1.31  2004/10/13 10:33:33  lulin
// - new behavior: синхронизируем удаление комментариев.
//
// Revision 1.30  2004/10/12 15:30:28  lulin
// - bug fix: при вставке из буфера обмена не учитывались блоки и соответственно вставлялись не комментарии (CQ OIT5-10223).
//
// Revision 1.29  2004/10/04 16:27:58  lulin
// - список редакторов вернулся на историческую родину (TextSource).
// - bug fix: "двоение" документов в истории при быстром хождении по списку документов.
//
// Revision 1.28  2004/10/04 15:27:31  lulin
// - откат предыдущего коммита.
//
// Revision 1.26  2004/09/28 15:38:20  lulin
// - свойство Processor перенесено с _TevCustomTextSource на _TevDocumentContainerWithProcessor (это для возможности кеширования DocumentContainer'ов).
//
// Revision 1.25  2004/09/28 11:37:01  lulin
// - свойство Editors перенесено с _TevCustomTextSource на TevDocumentContainer (это для возможности кеширования DocumentContainer'ов).
//
// Revision 1.24  2004/09/09 12:14:59  lulin
// - немного подоптимизировал фильтрацию оглавления (на глаз не видно).
//
// Revision 1.23  2004/08/06 13:20:31  law
// - new behavior: не добавляем в оглавление ссылки без имени (CQ OIT5-8564).
//
// Revision 1.22  2004/08/05 10:17:27  law
// - восстановлена функциональность TevMemo в Немезисе.
//
// Revision 1.21  2004/04/28 13:27:10  law
// - bug fix: в оглавление не попадали рисунки (если в документе был блок с именем "Рисунки").
//
// Revision 1.20  2004/03/30 10:20:21  mmorozov
// new: uses Types;
//
// Revision 1.19  2004/03/22 17:32:30  law
// - bug fix: починка сохранения комментариев привела к неосвобождению объектов.
//
// Revision 1.18  2004/03/22 16:06:53  law
// - bug fix: Пользовательские комментарии - обрезаются! (CQ OIT5-5996).
//
// Revision 1.17  2004/03/22 13:37:37  law
// - bug fix: "При редактировании пользовательских комментариев пропадает значок «пользовательского комментария» на полях" (CQ OIT5-5474).
//
// Revision 1.16  2004/01/13 13:29:16  law
// - new unit: evHyperlinkNode.
//
// Revision 1.15  2004/01/12 13:48:20  law
// - new behavior: построение оглавления по ТЗ от юристов (CQ OIT5-5843).
//
// Revision 1.14  2004/01/12 12:59:20  law
// - new behavior: сделан более гибкий механизм фильтрации оглавления.
//
// Revision 1.13  2004/01/06 12:33:47  law
// - new behavior: добавляем ссылки на картинки в папку "Рисунки".
// - new prop: idAddress.tiName.
//
// Revision 1.12  2003/11/29 18:00:38  law
// - bug fix: в историю не сохранялся "второй" TextSource (CQ OIT5-4633).
//
// Revision 1.11  2003/11/29 15:36:21  law
// - new class: _TeeHyperlinkFilter.
// - new proc: eeSetHyperlinkFilter.
//
// Revision 1.10  2003/11/10 14:20:37  law
// - new behavior: добавляем в оглавление ссылки на внешние объекты.
//
// Revision 1.9  2003/10/30 11:51:44  law
// - bug fix: не всегда проверялась возможность вставки параграфа.
//
// Revision 1.8  2003/10/28 11:08:54  law
// - bug fix: CQ OIT500004556.
//
// Revision 1.7  2003/10/20 15:42:20  law
// - new unit: eeProcessor.
// - new method: TevCustomProcessor._DoCheckParaOp (virtual).
//
// Revision 1.6  2003/10/13 15:31:15  law
// - rename unit: evEdWnd -> evEditorWindow.
//
// Revision 1.5  2003/09/24 09:59:08  law
// - bug fix: забыл про стиль ev_saContents.
//
// Revision 1.4  2003/09/24 09:55:54  law
// - new behavior: Sub'ы, которые стоят на комментариях юристов не попадают в оглавление.
//
// Revision 1.3  2003/09/10 15:44:27  law
// - new behavior: не даем редактировать/вставлять пользовательские комментарии, если они отключены.
//
// Revision 1.2  2003/07/16 15:46:01  demon
// - new behavior: если не существует документ, то не отдаем Sub.
//
// Revision 1.1  2003/02/18 13:05:06  law
// - new behavior: при переходе на метку ровняем курсор по верхней границе окна, по заказу коллег из Гарант 6 (задача №2871).
//

{$Include evDefine.inc }

interface

uses
  Types,
  Classes,
  
  l3Types,
  l3IID,
  l3Tree_TLB,
  l3Base,

  k2Interfaces,
  k2TagGen,

  evdTypes,
  
  evInternalInterfaces,
  evEditorWindowTextSource,
  evOpProc,

  nevTools,

  vcmExternalInterfaces
  ;


type
  TeeMakeDocumentContainerEvent = procedure (Sender: TObject;
                                             var aMade : InevDocumentContainer) of object;
    {-}                                         
  TeeTextSourceExport = class(TevEditorWindowTextSource{$IfNDef NoVCM}, IvcmState{$EndIf NoVCM})
    private
    // event fields
      f_OnMakeDocumentContainer : TeeMakeDocumentContainerEvent;                          
    private
    // interface methods
      {$IfNDef NoVCM}
      // IvcmState
      function  IvcmState_SaveState(out aState : IUnknown;
                                    aStateType : TvcmStateType): Boolean;
      function  IvcmState_LoadState(const aState : IUnknown;
                                    aStateType   : TvcmStateType): Boolean;
        {-}
      function  IvcmState.SaveState = IvcmState_SaveState;
      function  IvcmState.LoadState = IvcmState_LoadState;
        {-}
      {$EndIf NoVCM}
    protected
    // internal methods
      function DoMakeDocumentContainer: InevDocumentContainer;
        override;
        {-}
    public
    // public methods
      function COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
        override;
        {-}
    public
    // public properties
      property OnMakeDocumentContainer: TeeMakeDocumentContainerEvent
        read f_OnMakeDocumentContainer
        write f_OnMakeDocumentContainer;
        {-}
  end;//TeeTextSourceExport

implementation

uses
  SysUtils,

  l3Nodes,
  l3InterfacesMisc,
  l3Units,
  l3CacheableBase,

  k2InternalInterfaces,
  k2TagFilter,

  evdStyles,
  evParaNode,
  evTextSource,
  evOp,

  evParaTools,

  nevInternalInterfaces,

  eeInterfaces,
  eeInterfacesEx,
  eeDocumentContainer
  ;

type
  IeeTextSourceState = interface(IUnknown)
    ['{94FD0226-9512-442F-813C-84EB488F965B}']
    // public methods
      function  GetContainer: InevDocumentContainer;
        {-}
      procedure SetAll(const aContainer : InevDocumentContainer);
        {-}
  end;//IeeTextSourceState

  TeeTextSourceState = class(Tl3CacheableBase, IeeTextSourceState)
    private
    // internal fields
      f_Container : InevDocumentContainer;
    private
    // interface methods
      // IeeTextSourceState
      function GetContainer: InevDocumentContainer;
        {-}
      procedure SetAll(const aContainer : InevDocumentContainer);
        {-}
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(const aContainer : InevDocumentContainer);
        reintroduce;
        {-}
      class function Make(const aContainer : InevDocumentContainer): IeeTextSourceState;
        {-}
  end;//TeeTextSourceState

constructor TeeTextSourceState.Create(const aContainer : InevDocumentContainer);
  //reintroduce;
  {-}
begin
 inherited Create;
 f_Container := aContainer;
end;

class function TeeTextSourceState.Make(const aContainer : InevDocumentContainer): IeeTextSourceState;
  {-}
var
 l_State : TeeTextSourceState;
begin
 l_State := Create(aContainer);
 try
  Result := l_State;
 finally
  l3Free(l_State);
 end;//try..finally
end;

procedure TeeTextSourceState.Cleanup;
  //override;
  {-}
begin
 f_Container := nil;
 inherited;
end;

function TeeTextSourceState.GetContainer: InevDocumentContainer;
  {-}
begin
 Result := f_Container;
end;

procedure TeeTextSourceState.SetAll(const aContainer : InevDocumentContainer);
  {-}
begin
 f_Container := aContainer;
end;

// start class TeeTextSourceExport

{$IfNDef NoVCM}
function TeeTextSourceExport.IvcmState_SaveState(out aState : IUnknown;
                                                 aStateType : TvcmStateType): Boolean;
  {-}
begin
 Case aStateType of
  vcm_stContent :
  begin
   if (f_DocumentContainer <> nil) AND (not HasEditors OR (Editors.Count = 0)) then
   begin
    Result := true;
    aState := TeeTextSourceState.Make(DocumentContainer);
    DocumentContainer := nil;
   end//HasDocument..
   else
    Result := false;
  end;//vcm_stContent
  else
   Result := false;
 end;//Case aStateType
end;

function TeeTextSourceExport.IvcmState_LoadState(const aState : IUnknown;
                                                 aStateType   : TvcmStateType): Boolean;
  {-}
var
 l_Container : InevDocumentContainer;
begin
 Case aStateType of
  vcm_stContent :
  begin
   Result := true;
   with (aState As IeeTextSourceState) do
   begin
    l_Container := GetContainer;
    try
     SetAll(DocumentContainer);
     SetDocumentContainerFromHistory(l_Container);
    finally
     l_Container := nil;
    end;//try..finally
   end;//with (aState As IeeTextSourceState) do
  end;//vcm_stContent
  else
   Result := false;
 end;//Case aStateType
end;
{$EndIf NoVCM}

function TeeTextSourceExport.DoMakeDocumentContainer: InevDocumentContainer;
  //override;
  {-}
begin
 {$IfDef Nemesis}
 Result := TeeDocumentContainer.Make;
 {$Else  Nemesis}
 Result := nil;
 {$EndIf Nemesis}
 if Assigned(f_OnMakeDocumentContainer) then
  f_OnMakeDocumentContainer(Self, Result);
end;

function TeeTextSourceExport.COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
  //override;
  {-}
begin
 if IID.SomeOf([IeeEditor, IeeDocument, IeeDocumentEx]) then
 begin
  if HasEditors AND // - это ОБЯЗАТЕЛЬНАЯ проверка - иначе остаются неосвобожденные объекты
     not Editors.Empty then
  begin
   if Supports(TObject(Editors.First), IID.IID, Obj) then
    Result.SetOk
   else
    Result.SetNoInterface;
  end//HasEditors
  else
   Result.SetNoInterface;
 end
 else
  Result := inherited COMQueryInterface(IID, Obj);
end;
  
end.

