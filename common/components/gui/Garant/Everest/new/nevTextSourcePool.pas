unit nevTextSourcePool;

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: nevTextSourcePool - }
{ Начат: 14.07.2005 15:26 }
{ $Id: nevTextSourcePool.pas,v 1.29 2014/04/08 12:35:11 lulin Exp $ }

// $Log: nevTextSourcePool.pas,v $
// Revision 1.29  2014/04/08 12:35:11  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.28  2014/04/07 17:57:03  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.27  2014/03/20 09:11:55  lulin
// {RequestLink:522093244}.
//
// Revision 1.26  2013/12/26 13:19:34  lulin
// {RequestLink:509706011}
//
// Revision 1.25  2013/12/19 11:43:45  lulin
// {RequestLink:509115763}
//
// Revision 1.24  2011/07/20 11:15:53  lulin
// {RequestLink:228688745}.
//
// Revision 1.23  2011/02/14 15:15:44  lulin
// {RequestLink:231670346}.
//
// Revision 1.22  2010/06/04 16:05:04  lulin
// {RequestLink:217681540}.
// - добавлен тест.
//
// Revision 1.21  2010/05/26 14:32:00  lulin
// {RequestLink:216072357}.
// - теперь падение при отрисовке неправильного документа считается положительным результатом теста.
//
// Revision 1.20  2010/04/15 13:06:24  lulin
// {RequestLink:201491355}.
//
// Revision 1.19  2009/07/22 12:29:52  lulin
// - пытаемся оптимизировать установку атомарных тегов.
//
// Revision 1.18  2009/07/21 18:23:11  lulin
// - подготавливаемся к уменьшению преобразования типов при записи атрибутов.
//
// Revision 1.17  2009/07/06 17:15:11  lulin
// - возвращаемся от интерфейсов к объектам.
//
// Revision 1.16  2009/04/16 10:47:49  lulin
// [$143396720]. №4. И перетряс взаимное расположение интерфесов.
//
// Revision 1.15  2009/03/05 13:33:39  lulin
// - <K>: 137470629. Удалено ненужное свойство.
//
// Revision 1.14  2008/11/13 13:09:04  dinishev
// <K> : 121156019
//
// Revision 1.13  2008/10/28 09:50:10  dinishev
// <K> : 121156019
//
// Revision 1.12  2008/07/02 12:32:23  lulin
// - <K>: 91848911.
//
// Revision 1.11  2008/06/02 13:18:02  lulin
// - <K>: 89096952.
//
// Revision 1.10  2008/05/07 18:29:52  lulin
// - изменения в рамках <K>: 90441963.
//
// Revision 1.9  2008/04/29 17:24:30  lulin
// - работы по <K>: 89106312.
//
// Revision 1.8  2008/04/02 17:36:15  lulin
// - удалён ненужный метод.
//
// Revision 1.7  2008/04/02 17:03:26  lulin
// - <K>: 88641704.
//
// Revision 1.6  2008/04/02 14:22:07  lulin
// - cleanup.
//
// Revision 1.5  2008/03/27 11:44:55  dinishev
// Борьба с медленным скроллингом длинной таблицы
//
// Revision 1.4  2008/03/20 09:48:15  lulin
// - cleanup.
//
// Revision 1.3  2008/02/07 14:44:25  lulin
// - класс _Tl3LongintList переехал в собственный модуль.
//
// Revision 1.2  2007/12/04 12:47:52  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.1.2.45  2007/09/04 18:06:20  lulin
// - cleanup.
//
// Revision 1.1.2.44  2007/08/02 19:33:21  lulin
// - cleanup.
//
// Revision 1.1.2.43  2006/12/11 09:55:29  oman
// - new: HiddenStyles перенесены с DocumentContainer на редактор (cq12564)
// - new: Изменена схема кэширования превью на DocumentContainer
//
// Revision 1.1.2.42  2006/11/03 11:00:18  lulin
// - объединил с веткой 6.4.
//
// Revision 1.1.2.41.4.1  2006/10/18 13:17:05  lulin
// - cleanup.
//
// Revision 1.1.2.41  2006/10/03 13:15:43  lulin
// - используем более базовый интерфейс.
//
// Revision 1.1.2.40  2006/10/02 11:38:40  lulin
// - объединяем с веткой в которой размеры параграфов подсчитываются методами канвы.
//
// Revision 1.1.2.39.2.1  2006/09/28 17:41:02  lulin
// - не переформатируем списки параграфов, когда это не нужно.
//
// Revision 1.1.2.39  2006/08/02 10:52:00  lulin
// - объединил с веткой в которой боролся со скроллингом.
//
// Revision 1.1.2.38.2.1  2006/07/31 13:31:55  lulin
// - убран ненужный метод.
//
// Revision 1.1.2.38  2006/07/19 14:33:30  lulin
// - теперь для обновления прямоугольника вывода работаем с исходным объектом, а не с формой.
//
// Revision 1.1.2.37  2006/06/23 13:16:28  lulin
// - bg fix: не были сбалансированы скобки открытия/закрытия потока и начала/конца индикатора процесса - в результате в статусной строке оставалась ненужная надпись (CQ OIT5-19445).
//
// Revision 1.1.2.36  2006/03/01 11:28:38  lulin
// - cleanup: избавляемся от устаревшего интерфейса.
//
// Revision 1.1.2.35  2006/02/17 06:25:16  lulin
// - очищаем коллекцию отрисованных параграфов при вставке/удалении параграфов.
//
// Revision 1.1.2.34  2005/12/07 16:36:52  lulin
// - используем Lock/Unlock без неявного приведения интерфейсов.
//
// Revision 1.1.2.33  2005/12/05 09:06:22  lulin
// - валидация генерации документа полностью переехала с TextSource на DocumentContainer.
//
// Revision 1.1.2.32  2005/12/03 19:44:00  lulin
// - удален старый механизм перехода на метки. Теперь все делается через Waiter'ов.
//
// Revision 1.1.2.31  2005/12/02 18:23:33  lulin
// - обрабока нотфификации об удалении/добавлении параграфа практически полностью перенесена на процессор.
//
// Revision 1.1.2.30  2005/12/01 09:42:36  lulin
// - удалены методы, связанные со старым алгоритмом форматирования.
//
// Revision 1.1.2.29  2005/12/01 05:59:24  lulin
// - cleanup: избавляемся от транслции свойства HiddenStyles от редактора к котнтейнеру и обратно.
//
// Revision 1.1.2.28  2005/12/01 05:27:45  lulin
// - нотификация об изменении атрибута тега разложена по уровням Processor -> DocumentContainer -> TextSource.
//
// Revision 1.1.2.27  2005/11/15 09:44:04  lulin
// - убран лишний параметр.
//
// Revision 1.1.2.26  2005/11/15 09:36:45  lulin
// - от реализации переходим к интерфейсам.
//
// Revision 1.1.2.25  2005/11/15 08:02:42  lulin
// - чтение/запись документа практически польностью перенесены с TextSource на контейнер документа.
//
// Revision 1.1.2.24  2005/11/15 05:17:31  lulin
// - восстановлена валидация Writer'а у TextSource.
//
// Revision 1.1.2.23  2005/11/14 18:37:05  lulin
// - теперь при заборе в буфер обмена в него кладется контейнер документа, а не TextSource - должно починить ошибку CQ OIT5-17870.
//
// Revision 1.1.2.22  2005/11/11 22:23:20  lulin
// - избавляемся от управления свойством модифицированности документа путем посылки сообщений.
//
// Revision 1.1.2.21  2005/11/09 15:28:33  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.1.2.20  2005/09/09 15:47:25  lulin
// - при редактировании текста не перерисовываем все окно - если высота параграфа не изменилась - сильно помогло с вводом в КЗ.
//
// Revision 1.1.2.19  2005/09/01 10:29:20  lulin
// - обязанность получения иконок для контролов переехала на TextSource.
//
// Revision 1.1.2.18  2005/07/28 10:54:30  lulin
// - упрощен путь получения пользовательских данных для контрола.
//
// Revision 1.1.2.17  2005/07/27 11:17:25  lulin
// - кеш документов теперь работает практически только с интерфейсом контейнера документа, а не с его реализацией.
//
// Revision 1.1.2.16  2005/07/25 18:09:20  lulin
// - теперь TextSource не знает про реализацию контейнера документа, а только про его интерфейс.
//
// Revision 1.1.2.15  2005/07/25 10:54:39  lulin
// - события нотификации перенесены с контейнера документа и процессора на TextSource.
//
// Revision 1.1.2.14  2005/07/20 15:13:21  lulin
// - убрано косвенное получение инструментов для чтения/записи тега.
//
// Revision 1.1.2.13  2005/07/19 15:32:26  lulin
// - убрана часть обращений к интересующим интерфейсам через цепочку Parent'ов диапазонов и курсоров.
//
// Revision 1.1.2.12  2005/07/18 10:26:15  lulin
// - удален ненужный интерфейс окна.
//
// Revision 1.1.2.11  2005/07/18 09:20:53  lulin
// - убран устаревший интерфейс.
//
// Revision 1.1.2.10  2005/07/15 15:45:33  lulin
// - new behavior: перерисовываем строки параграфов, через _InevSimpleView.
//
// Revision 1.1.2.9  2005/07/15 13:56:07  lulin
// - new behavior: перерисовываем параграфы, через _InevSimpleView.
//
// Revision 1.1.2.8  2005/07/15 13:09:08  lulin
// - избавляемся от промежуточного интерфейса для View.
//
// Revision 1.1.2.7  2005/07/15 11:01:03  lulin
// - избавился от опосредованного получения интерфейса для записи тега.
//
// Revision 1.1.2.6  2005/07/15 10:00:38  lulin
// - bug fix: очередной раз починил вставку комментарие, в этот раз отъехавшую из-за перехода на использование одного документа в разных редакторах.
//
// Revision 1.1.2.5  2005/07/15 09:30:45  lulin
// - теперь параграфы знают про DocumentContainer, DocumentContainer знает про TextSource, а TextSource - знает про редакторы.
//
// Revision 1.1.2.4  2005/07/15 09:05:36  lulin
// - new interface: InevDocumentContainer.
//
// Revision 1.1.2.3  2005/07/15 08:51:34  lulin
// - new behavior: теперь один и тот же документ может показываться в разных окнах - без создания копий и необходимости синхронизации между ними.
//
// Revision 1.1.2.2  2005/07/14 18:04:36  lulin
// - bug fix: в отсутствии "настоящего" TextSource не дочитывался документ при построении _Preview.
//
// Revision 1.1.2.1  2005/07/14 14:17:38  lulin
// - new behavior: теперь один документ может быть привязан к нескольким TextSource - т.е. одна и та же копия документа может быть показана в разных окнах редакторов, расположенных на разных формах.
//

{$Include nevDefine.inc }

interface

uses
  l3Types,
  l3Interfaces,
  l3Tree_TLB,
  l3InternalInterfaces,
  l3Base,
  l3Filer,
  l3LongintList,
  l3ProtoObject,

  k2Interfaces,
  k2TagGen,
  k2Reader,
  k2Base,
  k2BaseStruct,

  evInternalInterfaces,

  nevBase,
  nevTools,
  nevInternalInterfaces
  ;

type
  TnevTextSourcePool = class(Tl3ProtoObject{_Tl3Base},
                             InevTextSourcePool,
                             IevSubCache,
                             IevSubFlagsSpy,
                             Il3Lock,
                             InevViewArea)
    private
    // internal fields
      f_List       : Tl3LongintList;
      f_Containter : Pointer;
    protected
    // interface methods
      // InevTextSourceInternal
      function  Get_ViewArea: InevViewArea;
        {-}
(*      function  pm_GetTypeTable: Ik2TypeTable;
        {-}*)
      function  Get_Document: Tl3Variant;
        {-}
      function  Get_SubCache: IevSubCache;
        {-}
      procedure NotifyFlagsChange(const aSub: IevSub);
        {-}
      function  pm_GetLock: Il3Lock;
        {-}
      function  pm_GetProgress: Il3Progress;
        {-}
      function  CastAnyEditorTo(const IID : TGUID;
                                out theObj): Boolean;
        {-}
      procedure DocumentChanged(anOldDocument, aNewDocument : Tl3Variant);
        {-}
      procedure MakeCursor;
        {-}
      {$IfNDef Nemesis}
      function  GetSubFlags(aLayer         : Tl3Handle;
                            const aSubList : InevSubList): Boolean;
        {-}
      {$EndIf  Nemesis}  
      function  GetControlData(const aControl: IevControl): IUnknown;
        {* - возвращает данные для контрола. }
      function  GetControlImg(const aControl   : TnevControlInfo;
                              out theImageInfo : TnevControlImageInfo): Boolean;
        {* - возвращает картинки для контрола. }
      procedure PropChanged(Prop      : Tk2Prop;
                            const V         : Tk2Values;
                            const anOpPack  : Ik2Op);
        {-}
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
      // InevTextSourcePool
      procedure LinkTextSource(const aTextSource: InevTextSourceInternal);
        {-}
      procedure UnlinkTextSource(const aTextSource: InevTextSourceInternal);
        {-}
      // InevViewArea  
      procedure Update;
        {-}
      procedure Changed(aPlace: TnevChangePlace);
        {-}
      procedure InvalidateShape(const aShape      : InevObject;
                                aParts : TnevShapeParts);
        {-}
      procedure Invalidate;
        {-}
      // IevSubCache
      procedure ClearSubs;
        {-}
      procedure NotifySubDeleted(const aSub: IevSub);
        {-}
      procedure SetFlag(aFlag: TevUpdateWindowFlag);
        {* - установить флаг aFlag. }
      // Il3Lock  
      procedure Lock(const aLocker: IUnknown);
        {* - закрыть. }
      procedure Unlock(const aLocker: IUnknown);
        {* - открыть. }
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(const aContainter : InevDocumentContainer);
        reintroduce;
        {-}
      class function Make(const aContainter : InevDocumentContainer): InevTextSourcePool;
        {-}
  end;//TnevTextSourcePool

implementation

uses
  SysUtils,
  
  k2Facade
  ;

// start class TnevTextSourcePool

constructor TnevTextSourcePool.Create(const aContainter : InevDocumentContainer);
  //reintroduce;
  {-}
begin
 inherited Create;
 f_Containter := Pointer(aContainter);
end;

class function TnevTextSourcePool.Make(const aContainter : InevDocumentContainer): InevTextSourcePool;
  {-}
var
 l_Pool : TnevTextSourcePool;
begin
 l_Pool := Create(aContainter);
 try
  Result := l_Pool;
 finally
  l3Free(l_Pool);
 end;//try..finally
end;

procedure TnevTextSourcePool.Cleanup;
  //override;
  {-}
begin
 f_Containter := nil;
 l3Free(f_List);
 inherited;
end;

function TnevTextSourcePool.Get_ViewArea: InevViewArea;
  {-}
begin
 Result := Self;
end;

(*function TnevTextSourcePool.pm_GetTypeTable: Ik2TypeTable;
  {-}
begin
 if (f_Containter = nil) then
  Result := k2.TypeTable
 else
  Result := InevDocumentContainer(f_Containter).Document.Para.TagType.TypeTable;
end;*)

function TnevTextSourcePool.Get_Document: Tl3Variant;
  {-}
begin
 if (f_Containter = nil) then
  Result := nil
 else
  Result := InevDocumentContainer(f_Containter).Document.Para;
end;

function TnevTextSourcePool.Get_SubCache: IevSubCache;
  {-}
begin
 Result := Self;
end;

procedure TnevTextSourcePool.NotifyFlagsChange(const aSub: IevSub);
  {* флаги метки изменились }
var
 l_Index : Integer;
 l_Spy   : IevSubFlagsSpy;
begin
 if (f_List <> nil) then
  with f_List do
   for l_Index := Lo to Hi do
    if Supports(InevTextSource(Items[l_Index]), IevSubFlagsSpy, l_Spy) then
     try
      l_Spy.NotifyFlagsChange(aSub);
     finally
      l_Spy := nil;
     end;//try..finally
end;
  
function TnevTextSourcePool.pm_GetLock: Il3Lock;
  {-}
begin
 Result := Self;
end;

function TnevTextSourcePool.pm_GetProgress: Il3Progress;
  {-}
begin
 if f_List.Empty then
  Result := nil
 else
  Result := InevTextSourceInternal(f_List.First).Progress;
end;

function TnevTextSourcePool.CastAnyEditorTo(const IID : TGUID;
                                            out theObj): Boolean;
  {-}
var
 l_Index : Integer;
begin
 Result := false;
 if (f_List <> nil) then
  with f_List do
   for l_Index := Lo to Hi do
    if InevTextSource(Items[l_Index]).CastAnyEditorTo(IID, theObj) then
    begin
     Result := true;
     break;
    end;//InevTextSource(Items[l_Index]).CastAnyEditorTo
end;

procedure TnevTextSourcePool.DocumentChanged(anOldDocument, aNewDocument : Tl3Variant);
  {-}
var
 l_Index : Integer;
begin
 if (f_List <> nil) then
  with f_List do
   for l_Index := Lo to Hi do
    InevTextSource(Items[l_Index]).DocumentChanged(anOldDocument, aNewDocument);
end;

{$IfNDef Nemesis}
function TnevTextSourcePool.GetSubFlags(aLayer         : Tl3Handle;
                                        const aSubList : InevSubList): Boolean;
  {-}
var
 l_Index : Integer;
begin
 Result := false;
 if (f_List <> nil) then
  with f_List do
   for l_Index := Lo to Hi do
    if InevTextSource(Items[l_Index]).GetSubFlags(aLayer, aSubList) then
    begin
     Result := true;
     break;
    end;//InevTextSource(Items[l_Index]).GetSubFlags(aLayer, aSubList)
end;
{$EndIf Nemesis}

function TnevTextSourcePool.GetControlData(const aControl: IevControl): IUnknown;
  {* - возвращает данные для контрола. }
var
 l_Index : Integer;
begin
 Result := nil;
 if (f_List <> nil) then
  with f_List do
   for l_Index := Lo to Hi do
   begin
    Result := InevTextSource(Items[l_Index]).GetControlData(aControl);
    if (Result <> nil) then
     break;
   end;//for l_Index
end;

function TnevTextSourcePool.GetControlImg(const aControl   : TnevControlInfo;
                                          out theImageInfo : TnevControlImageInfo): Boolean;
  {* - возвращает картинки для контрола. }
var
 l_Index : Integer;
begin
 Result := false;
 if (f_List <> nil) then
  with f_List do
   for l_Index := Lo to Hi do
   begin
    if InevTextSource(Items[l_Index]).GetControlImg(aControl, theImageInfo) then
    begin
     Result := true;
     break;
    end;//InevTextSource(Items[l_Index]).GetControlImg
   end;//for l_Index
end;

procedure TnevTextSourcePool.PropChanged(Prop      : Tk2Prop;
                                         const V         : Tk2Values;
                                         const anOpPack  : Ik2Op);
  {-}
var
 l_Index : Integer;
begin
 if (f_List <> nil) then
  with f_List do
   for l_Index := Lo to Hi do
    InevTextSource(Items[l_Index]).PropChanged(Prop, V, anOpPack);
end;

procedure TnevTextSourcePool.LinkDocumentContainer(const aContainer: InevDocumentContainer);
  {-}
var
 l_Index : Integer;
begin
 if (f_List <> nil) then
  with f_List do
   for l_Index := Lo to Hi do
    InevTextSourceInternal(Items[l_Index]).LinkDocumentContainer(aContainer);
end;

procedure TnevTextSourcePool.MakeCursor;
  {-}
var
 l_Index : Integer;
begin
 if (f_List <> nil) then
  with f_List do
   for l_Index := Lo to Hi do
    InevTextSourceInternal(Items[l_Index]).MakeCursor;
end;

procedure TnevTextSourcePool.Update;
  {-}
var
 l_Index : Integer;
begin
 if (f_List <> nil) then
  with f_List do
   for l_Index := Lo to Hi do
    InevTextSourceInternal(Items[l_Index]).ViewArea.Update;
end;

procedure TnevTextSourcePool.Changed(aPlace: TnevChangePlace);
  {-}
var
 l_Index : Integer;
begin
 if (f_List <> nil) then
  with f_List do
   for l_Index := Lo to Hi do
    InevTextSourceInternal(Items[l_Index]).ViewArea.Changed(aPlace);
end;

procedure TnevTextSourcePool.InvalidateShape(const aShape      : InevObject;
                                             aParts : TnevShapeParts);
  {-}
var
 l_Index : Integer;
begin
 if (f_List <> nil) then
  with f_List do
   for l_Index := Lo to Hi do
    InevTextSourceInternal(Items[l_Index]).ViewArea.InvalidateShape(aShape, aParts);
end;

procedure TnevTextSourcePool.Invalidate;
  {-}
var
 l_Index : Integer;
begin
 if (f_List <> nil) then
  with f_List do
   for l_Index := Lo to Hi do
    InevTextSourceInternal(Items[l_Index]).ViewArea.Invalidate;
end;

procedure TnevTextSourcePool.ClearSubs;
  {-}
var
 l_Index : Integer;
begin
 if (f_List <> nil) then
  with f_List do
   for l_Index := Lo to Hi do
    InevTextSourceInternal(Items[l_Index]).SubCache.ClearSubs;
end;

procedure TnevTextSourcePool.NotifySubDeleted(const aSub: IevSub);
  {-}
var
 l_Index : Integer;
begin
 if (f_List <> nil) then
  with f_List do
   for l_Index := Lo to Hi do
    InevTextSourceInternal(Items[l_Index]).SubCache.NotifySubDeleted(aSub);
end;

procedure TnevTextSourcePool.SetFlag(aFlag: TevUpdateWindowFlag);
  {* - установить флаг aFlag. }
var
 l_Index : Integer;
begin
 if (f_List <> nil) then
  with f_List do
   for l_Index := Lo to Hi do
    InevTextSourceInternal(Items[l_Index]).SetFlag(aFlag);
end;

procedure TnevTextSourcePool.Lock(const aLocker: IUnknown);
  {* - закрыть. }
var
 l_Index : Integer;
begin
 if (f_List <> nil) then
  with f_List do
   for l_Index := Lo to Hi do
    try
     InevTextSourceInternal(Items[l_Index]).Lock.Lock(aLocker);
    except
     on EAssertionFailed do
      raise;
     else
      ;
     // - это чтобы не прервать процесс нотификации других клиентов, если один сломался
    end;//try..except
end;

procedure TnevTextSourcePool.Unlock(const aLocker: IUnknown);
  {* - открыть. }
var
 l_Index : Integer;
begin
 if (f_List <> nil) then
  with f_List do
   for l_Index := Lo to Hi do
   begin
    try
     InevTextSourceInternal(Items[l_Index]).Lock.Unlock(aLocker);
    except
     on EAssertionFailed do
      raise;
     else
      ;
     // - это чтобы не прервать процесс нотификации других клиентов, если один сломался
    end;//try..except
   end;//for l_Index
end;

procedure TnevTextSourcePool.CheckReader(aFormat       : TnevFormat;
                                         anInternal    : Boolean;
                                         var theReader : Tk2CustomReader);
  {-}
begin
 if not f_List.Empty then
  InevTextSourceInternal(f_List.First).CheckReader(aFormat, anInternal, theReader);
end;

procedure TnevTextSourcePool.CheckWriter(aFormat       : TnevFormat;
                                         anInternal    : Boolean;
                                         var theWriter : Tk2TagGenerator;
                                         aCodePage     : Integer = CP_DefaultValue);
  {-}
begin
 if not f_List.Empty then
  InevTextSourceInternal(f_List.First).CheckWriter(aFormat, anInternal, theWriter, aCodePage);
end;

function TnevTextSourcePool.CheckCloseWindow: Boolean;
  {-}
var
 l_Index : Integer;
begin
 Result := false;
 if (f_List <> nil) then
  with f_List do
   for l_Index := Lo to Hi do
    if InevTextSourceInternal(Items[l_Index]).CheckCloseWindow then
     Result := true;
end;

function TnevTextSourcePool.HandleAbortLoad: Boolean;
  {* - Обрабатывает прерывание загрузки документа. }
var
 l_Index : Integer;
begin
 Result := true;
 if (f_List <> nil) then
  with f_List do
   for l_Index := Lo to Hi do
    if not InevTextSourceInternal(Items[l_Index]).HandleAbortLoad then
     Result := false;
end;

procedure TnevTextSourcePool.Events2Filer(aFiler        : Tl3CustomFiler;
                                          var theEvents : TnevFilerEvents);
  {-}
begin
 if not f_List.Empty then
  InevTextSourceInternal(f_List.First).Events2Filer(aFiler, theEvents);
end;

procedure TnevTextSourcePool.RestoreEvents(aFiler        : Tl3CustomFiler;
                                           var theEvents : TnevFilerEvents);
  {-}
begin
 if not f_List.Empty then
  InevTextSourceInternal(f_List.First).RestoreEvents(aFiler, theEvents);
end;

procedure TnevTextSourcePool.LinkTextSource(const aTextSource: InevTextSourceInternal);
  {-}
begin
 if (aTextSource <> nil) then
 begin
  if (f_List = nil) then
   f_List := Tl3LongintList.MakeSorted;
  f_List.Add(Integer(aTextSource));
 end;//aTextSource <> nil
end;

procedure TnevTextSourcePool.UnlinkTextSource(const aTextSource: InevTextSourceInternal);
  {-}
begin
 if (f_List <> nil) then
  f_List.Remove(Integer(aTextSource));
end;
  
end.

