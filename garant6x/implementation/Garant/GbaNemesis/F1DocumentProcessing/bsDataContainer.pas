unit bsDataContainer;
{* Модуль содержит реализации контейнеров данных. Получение данных с адаптера
   может занимать длительное время, поэтому вводятся контейнеры данных, которые
   возвращают данные по первому требованию. }

// Библиотека : Бизнес слой проекта "Немезис";
// Автор      : Морозов М.А.
// Начат      : 20.04.2007;
// Версия     : $Id: bsDataContainer.pas,v 1.2 2014/07/16 12:45:37 kostitsin Exp $

(*-----------------------------------------------------------------------------
  $Log: bsDataContainer.pas,v $
  Revision 1.2  2014/07/16 12:45:37  kostitsin
  {requestlink: 513880934 }

  Revision 1.1  2010/08/17 17:34:11  lulin
  {RequestLink:232100720}.
  - рисуем скелет реализации.

  Revision 1.9  2009/12/09 17:59:12  lulin
  - рисуем контейнер документа на модели и правим зависимости.

  Revision 1.8  2009/12/07 19:04:40  lulin
  - удалил ненужный модуль.

  Revision 1.7  2009/12/07 15:58:45  lulin
  - переносим "интерфейсы обмена данными" в правильные места.

  Revision 1.6  2009/12/04 11:53:03  lulin
  - перенесли на модель и добились собираемости.

  Revision 1.5  2009/12/02 17:34:04  lulin
  - убираем комментарии а-ля Морозофф.

  Revision 1.4  2009/12/02 17:21:36  lulin
  {RequestLink:172984885}.

  Revision 1.1  2009/12/01 20:13:11  lulin
  - перекладываем модули в правильное место.

  Revision 1.2  2009/11/30 19:06:58  lulin
  - вычищен ненужный интерфейс.

  Revision 1.1  2009/09/14 11:28:44  lulin
  - выводим пути и для незавершённых модулей.

  Revision 1.10  2009/05/14 08:07:46  oman
  - new: Откручиваем вывод информации для списков - [$136939327]

  Revision 1.9  2009/05/07 07:45:13  oman
  - new: Выводим количество фрагментов - [$136939327]
  Committed on the Free edition of March Hare Software CVSNT Server.
  Upgrade to CVS Suite for more features and support:
  http://march-hare.com/cvsnt/

  Revision 1.8  2009/05/06 11:12:31  oman
  - new: Пытаемся интеллектуальней выводить количество фрагментов - [$136939327]
  Committed on the Free edition of March Hare Software CVSNT Server.
  Upgrade to CVS Suite for more features and support:
  http://march-hare.com/cvsnt/

  Revision 1.7  2009/05/05 08:13:45  oman
  - new: Показываем заглушечно количество найденных - [$136939327]

  Revision 1.6  2008/03/26 11:59:15  oman
  - new: Учимся извлекать DocInfo для фирм-производителей

  Revision 1.5  2008/01/10 07:23:00  oman
  Переход на новый адаптер

  Revision 1.4.4.1  2007/11/21 10:26:15  oman
  Перепиливаем на новый адаптер

  Revision 1.4  2007/09/05 05:34:27  mmorozov
  - bugfix: проверяем наличие документа перед тем, как спрашивать его у сервера (CQ: OIT5-26602);

  Revision 1.3  2007/05/30 10:34:18  oman
  - fix: Если спросили подчиненный документ, а такого не оказалось -
   обрабатываем исключение и возвращаем Nil (cq25471)

  Revision 1.2  2007/05/14 10:51:46  oman
  Warning fix

  Revision 1.1  2007/05/03 05:51:52  mmorozov
  - opt: оптимизация скролирования в списке (CQ: OIT5-24996; OIT5-24543);

-------------------------------------------------------------------------------*)

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Interfaces,
  l3Base,
  
  DocumentUnit,
  DynamicDocListUnit,
  DynamicTreeUnit,
  PharmFirmListUnit,
  
  bsBase,
  bsTypes,
  DocumentInterfaces,
  DocumentAndListInterfaces
  ;

type
  TbsDocumentContainer = class(TbsBase, IbsDocumentContainer)
  {* Контейнер документа. Обеспечивает отложенное получение документа. }
  private
  // private fields
    f_Document: IDocument;
  protected
  // IbsDataContainer
    function IbsDocumentContainer.Clone = DataContainer_Clone;
    function DataContainer_Clone: IbsDocumentContainer;
      virtual;
      {-}
    function pm_GetIsInited: Boolean;
      virtual;
      {-}
    function IsSame(const aContainer : IbsDocumentContainer;
                    aView      : Boolean = True): Boolean;
      {-}
  // IbsDocumentContainer
    function pm_GetDocument: IDocument;
    procedure pm_SetDocument(const aValue: IDocument);
      {-}
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
    function MakeDocument: IDocument;
      virtual;
      {-}
  protected
  // properties
    property Document: IDocument
      read f_Document
      write f_Document;
      {-}
    property IsInited: Boolean
      read pm_GetIsInited;
      {-}
  public
  // methods
    constructor Create(const aDocument: IDocument = nil);
      reintroduce;
      {-}
    class function Make(const aDocument: IDocument): IbsDocumentContainer;
      {-}
  end;//TbsDocumentContainer

  TbsListNodeContainer = class(TbsDocumentContainer)
  private
  // private fields
    f_ListNode      : INodeBase;
    f_ListEntryInfo : IListEntryInfo;
  protected
  // IbsDataContainer
    function DataContainer_Clone: IbsDocumentContainer;
      override;
      {-}
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
    function MakeDocument: IDocument;
      override;
      {-}
  public
  // public methods
    constructor Create(const aListNode      : INodeBase;
                       const aListEntryInfo : IListEntryInfo);
      reintroduce;
      {-}
    class function Make(const aListNode      : INodeBase;
                        const aListEntryInfo : IListEntryInfo): IbsDocumentContainer;
      {-}
  end;//TbsListNodeContainer

  TbsMedicFirmNodeContainer = class(TbsDocumentContainer)
  private
  // private fields
    f_ListNode      : INodeBase;
    f_MedicFirmListEntryInfo : IPharmFirmListEntry;
  protected
  // IbsDataContainer
    function DataContainer_Clone: IbsDocumentContainer;
      override;
      {-}
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
    function MakeDocument: IDocument;
      override;
      {-}
  public
  // public methods
    constructor Create(const aListNode      : INodeBase;
                       const aListEntryInfo : IPharmFirmListEntry);
      reintroduce;
      {-}
    class function Make(const aListNode      : INodeBase;
                        const aListEntryInfo : IPharmFirmListEntry): IbsDocumentContainer;
      {-}
  end;//TbsMedicFirmNodeContainer

  TbsNestedDocumentContainer = class(TbsDocumentContainer)
  {* - контейнер для получения документов являющихся составной частью
       IDocument. }
  private
  // private fields
    f_Container    : IbsDocumentContainer;
    f_DocumentType : TbsNestedDocumentType;
    f_HasDocument  : Boolean;
  protected
  // IbsDataContainer
    function pm_GetIsInited: Boolean;
      override;
      {-}
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
    function MakeDocument: IDocument;
      override;
      {-}
  protected
  // properties
    property Container: IbsDocumentContainer
      read f_Container
      write f_Container;
      {-}
    property DocumentType: TbsNestedDocumentType
      read f_DocumentType
      write f_DocumentType;
      {-}
    property HasDocument: Boolean
      read f_HasDocument
      write f_HasDocument;
      {-}
  public
  // methods
    constructor Create(const aContainer    : IbsDocumentContainer;
                       const aDocumentType : TbsNestedDocumentType;
                       const aHasDocument  : Boolean);
      reintroduce;
      {* - HasDocument: для зоны синхронного просмотра списка возможена ситуация
           когда выбрана справка к документу, дальше мы переключаемся в документ
           без справки, чтобы не обращатся к серверу за справкой, которой нет,
           в контейнер передается информация о налиции документа (CQ: OIT5-26602). }
    class function Make(const aContainer    : IbsDocumentContainer;
                        const aDocumentType : TbsNestedDocumentType;
                        const aHasDocument  : Boolean): IbsDocumentContainer;
      {-}
  end;//TbsNestedDocumentContainer
{$IfEnd}  

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils,
  
  BaseTypesUnit,

  bsUtils,
  bsConst
  ;

{ TbsDocumentContainer }

procedure TbsDocumentContainer.Cleanup;
begin
 f_Document := nil;
 inherited;
end;//Cleanup

function TbsDocumentContainer.pm_GetDocument: IDocument;
begin
 if f_Document = nil then
  f_Document := MakeDocument;
 Result := f_Document;
end;//pm_GetDocument

procedure TbsDocumentContainer.pm_SetDocument(const aValue: IDocument);
begin
 f_Document := aValue;
end;//pm_SetDocument

constructor TbsDocumentContainer.Create(const aDocument: IDocument);
begin
 inherited Create;
 f_Document := aDocument;
end;//Create

class function TbsDocumentContainer.Make(
  const aDocument: IDocument): IbsDocumentContainer;
var
 l_Class: TbsDocumentContainer;
begin
 l_Class := Create(aDocument);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;//Make

function TbsDocumentContainer.MakeDocument: IDocument;
begin
 Result := nil;
end;//MakeDocument

function TbsDocumentContainer.DataContainer_Clone: IbsDocumentContainer;
begin
 Result := TbsDocumentContainer.Make(f_Document);
end;

function TbsDocumentContainer.pm_GetIsInited: Boolean;
begin
 Result := f_Document <> nil;
end;

function TbsDocumentContainer.IsSame(const aContainer : IbsDocumentContainer;
                                     aView      : Boolean = True): Boolean;
begin
 Result := (aContainer <> nil) and
  (aContainer.IsInited and IsInited) and (Document <> nil) and
  ((not aView and Document.IsSameDocument(aContainer.Document)) or
   (aView and Document.IsSameView(aContainer.Document)));
end;//IsSame

{ TbsListNodeContainer }

procedure TbsListNodeContainer.Cleanup;
begin
 f_ListNode := nil;
 f_ListEntryInfo := nil;
 inherited;
end;

function TbsListNodeContainer.DataContainer_Clone: IbsDocumentContainer;
begin
 if Document <> nil then
  Result := TbsDocumentContainer.Make(Document)
 else
  Result := TbsListNodeContainer.Make(f_ListNode, f_ListEntryInfo);
end;

constructor TbsListNodeContainer.Create(const aListNode      : INodeBase;
                                            const aListEntryInfo : IListEntryInfo);
begin
 inherited Create;
 f_ListNode := aListNode;
 f_ListEntryInfo := aListEntryInfo;
end;//Create

class function TbsListNodeContainer.Make(const aListNode      : INodeBase;
                                             const aListEntryInfo : IListEntryInfo): IbsDocumentContainer;
var
 l_Class: TbsListNodeContainer;
begin
 l_Class := Create(aListNode, aListEntryInfo);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;//Make

function TbsListNodeContainer.MakeDocument: IDocument;
begin
 if f_ListEntryInfo <> nil then
  f_ListEntryInfo.GetDoc(Result)
 else
  Result := bsExtractDocument(f_ListNode);
end;//MakeDocument

{ TbsNestedDocumentContainer }

procedure TbsNestedDocumentContainer.Cleanup;
begin
 f_Container := nil;
 inherited;
end;//Cleanup

constructor TbsNestedDocumentContainer.Create(const aContainer    : IbsDocumentContainer;
                                              const aDocumentType : TbsNestedDocumentType;
                                              const aHasDocument  : Boolean);
begin
 inherited Create;
 Container := aContainer;
 DocumentType := aDocumentType;
 HasDocument := aHasDocument;
end;//Create

class function TbsNestedDocumentContainer.Make(const aContainer    : IbsDocumentContainer;
                                               const aDocumentType : TbsNestedDocumentType;
                                               const aHasDocument  : Boolean): IbsDocumentContainer;
var
 l_Class: TbsNestedDocumentContainer;
begin
 l_Class := Create(aContainer, aDocumentType, aHasDocument);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;//Make

function TbsNestedDocumentContainer.MakeDocument: IDocument;
begin
 if HasDocument and (Container.Document <> nil) then
  with Container.Document do
   try
    case DocumentType of
     ndtAnnotation:
      GetAnnotation(Result);
     ndtRelatedDoc,
     ndtChronology:
      GetRelatedDoc(Result);
     ndtTranslation:
      GetTranslation(Result);
    else
     Assert(False);
    end//case DocumentType of
   except
    on ECanNotFindData do
     Result := nil;
   end
 else
  Result := nil;
end;//MakeDocument

function TbsNestedDocumentContainer.pm_GetIsInited: Boolean;
begin
 Result := f_Container.IsInited and inherited pm_GetIsInited;
end;

{ TbsMedicFirmNodeContainer }

procedure TbsMedicFirmNodeContainer.Cleanup;
begin
 f_ListNode := nil;
 f_MedicFirmListEntryInfo := nil;
 inherited;
end;

constructor TbsMedicFirmNodeContainer.Create(const aListNode: INodeBase;
  const aListEntryInfo: IPharmFirmListEntry);
begin
 inherited Create;
 f_ListNode := aListNode;
 f_MedicFirmListEntryInfo := aListEntryInfo;
end;

function TbsMedicFirmNodeContainer.DataContainer_Clone: IbsDocumentContainer;
begin
 if Document <> nil then
  Result := TbsDocumentContainer.Make(Document)
 else
  Result := TbsMedicFirmNodeContainer.Make(f_ListNode, f_MedicFirmListEntryInfo);
end;

class function TbsMedicFirmNodeContainer.Make(const aListNode: INodeBase;
  const aListEntryInfo: IPharmFirmListEntry): IbsDocumentContainer;
var
 l_Class: TbsMedicFirmNodeContainer;
begin
 l_Class := Create(aListNode, aListEntryInfo);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;

function TbsMedicFirmNodeContainer.MakeDocument: IDocument;
begin
 if f_MedicFirmListEntryInfo <> nil then
  f_MedicFirmListEntryInfo.GetDocument(Result)
 else
  Result := bsExtractDocument(f_ListNode);
end;
{$IfEnd}

end.
