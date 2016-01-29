unit nsProfilers;

{------------------------------------------------------------------------------}
{ Библиотека : Бизнес слой проекта "Немезис";                                  }
{ Автор      : Морозов М.А.;                                                   }
{ Начат      : 05.07.2006;                                                     }
{ Модуль     : nsProfilers                                                     }
{ Описание   : Модуль содержит реализации профайлеров оболочки;                }
{------------------------------------------------------------------------------}

// $Id: nsProfilers.pas,v 1.10 2009/02/10 13:34:39 lulin Exp $
// $Log: nsProfilers.pas,v $
// Revision 1.10  2009/02/10 13:34:39  lulin
// - <K>: 133891247. Выделяем интерфейсы профайлеров.
//
// Revision 1.9  2007/10/09 12:31:03  mmorozov
// - new behaviour: в замерах открытия документов учитываем, что документ у контейнера могут получать много раз (CQ: OIT5-26941);
//
// Revision 1.8  2006/07/31 15:04:20  mmorozov
// - new: измерения открытия основного меню (CQ: OIT500021555);
//
// Revision 1.7  2006/07/28 14:24:54  mmorozov
// - change: const names;
//
// Revision 1.6  2006/07/27 13:39:22  mmorozov
// - new: замеры открытия списка после поиска (CQ: OIT500021557);
// - rename: интерфейсы профайлеров, некторые методы, константы;
//
// Revision 1.5  2006/07/27 11:20:59  mmorozov
// - new: замеры времени открытия карточки запроса (CQ: OIT500021553);
//
// Revision 1.4  2006/07/20 08:25:50  mmorozov
// - new: оглавление документа учавствует в замерах открытия документа (в рамках работы над CQ: OIT500021533);
//
// Revision 1.3  2006/07/19 17:58:20  mmorozov
// - new: замеры открытия документа - выключаем профайлер после отрисовки текста, раньше после загрузки;
//
// Revision 1.2  2006/07/06 06:56:34  mmorozov
// - new: базовый профайлер прецедентов;
//
// Revision 1.1  2006/07/05 07:51:24  mmorozov
// - new: профайлеры прецедентов;
//

interface

{$Include nsDefine.inc}

{$IfDef vcmUseProfilers}
uses
  vcmBase,

  ProfilersInterfaces
  ;

type
  TnsProfiler = class(TvcmBase, InsProfiler)
  protected
  // InsProfiler
    procedure Start;
      virtual;
      {* - начать замер, вызывается перед созданием сборки. }
    procedure Finish;
      {* - закончить измерение. }
  protected
  // methods
    function Id: Integer;
      virtual;
      abstract;
      {* - идентификатор профайлера. }
    function UseCaseName: String;
      virtual;
      abstract;
      {* - название прецедента. }
    function FinishCount: Integer;
      virtual;
      abstract;
      {* - количество Finish для окончания измерений. }
  public
  // methods
    class function Make: InsProfiler;
      {-}
  end;

  TprMainMenu = class(TnsProfiler, IprMainMenu)
  {* Открытие основного меню. }
  protected
  // methods
    function Id: Integer;
      override;
      {* - идентификатор профайлера. }
    function UseCaseName: String;
      override;
      {* - название прецедента. }
    function FinishCount: Integer;
      override;
      {* - количество Finish для окончания измерений. }
  end;

  TprDocument = class(TnsProfiler, IprDocument)
  private
  // fields
    f_DocumentReceived   : Boolean;
    f_ContentsTreeOpened : Boolean;
  private
  // IprDocument
    procedure FormSetCreated;
      {* - сборка создана. }
    procedure DocumentReceived;
      {* - документ получен с адаптера. }
    procedure DocumentPainted;
      {* - документ отрисован. }
    procedure ContentsTreeOpened;
      {* - открыта структура документа. }
  protected
  // methods
    procedure Start;
      override;
      {* - начать замер, вызывается перед созданием сборки. }
    function Id: Integer;
      override;
      {* - идентификатор профайлера. }
    function FinishCount: Integer;
      override;
      {* - количество Finish для окончания измерений. }
    function UseCaseName: String;
      override;
      {* - название прецедента. }
  end;//TprDocument

  TprQueryCard = class(TnsProfiler, IprQueryCard)
  {* Используется для замеров открытия карточки запросов. }
  protected
  // methods
    function Id: Integer;
      override;
      {* - идентификатор профайлера. }
    function UseCaseName: String;
      override;
      {* - название прецедента. }
    function FinishCount: Integer;
      override;
      {* - количество Finish для окончания измерений. }
  end;

  TprListAfterSearch = class(TnsProfiler, IprListAfterSearch)
  {* Открытие списка после поиска. }
  protected
  // methods
    function Id: Integer;
      override;
      {* - идентификатор профайлера. }
    function UseCaseName: String;
      override;
      {* - название прецедента. }
    function FinishCount: Integer;
      override;
      {* - количество Finish для окончания измерений. }
  end;

  TnsProfilersManager = class(TvcmBase, InsProfilersManager)
  private
  // fields
    f_Document        : IprDocument;
    f_QueryCard       : IprQueryCard;
    f_ListAfterSearch : IprListAfterSearch;
    f_MainMenu        : IprMainMenu;
  private
  // InsProfilerManager
    function pm_GetDocument: IprDocument;
      {* - профайлер документа. }
    function pm_GetQueryCard: IprQueryCard;
      {* - профайлер карточки запроса. }
    function pm_GetListAfterSearch: IprListAfterSearch;
      {* - открытие документа после поиска. }
    function pm_GetMainMenu: IprMainMenu;
      {* - открытие основного меню. }
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
  public
  // methods
    class function Make: InsProfilersManager;
      {-}
  end;
{$EndIf vcmUseProfilers}

implementation

{$IfDef vcmUseProfilers}
uses
  SysUtils,

  vcmProfilersCollection,

  bsTypes,
  bsConst,

  DebugStr
  ;

const
  c_fcDocument = 4;
   // - количество Finish вызываемые при замере открытия документа:
   //   - FormSetCreated;
   //   - DocumentReceived;
   //   - DocumentPainted;
   //   - ContentsTreeOpened;
  c_fcQueryCard = 1;
   // - количество Finish при открытии карточки запроса;
  c_fcListAfterSearch = 1;
   // - количество Finish при открытии списка после поиска;
  c_fcMainMenu = 1;
   // - количество Finish при открытии основного меню;

{ TprDocument }

procedure TprDocument.Start;
  // override;
  {* - начать замер, вызывается перед созданием сборки. }
begin
 inherited;
 f_DocumentReceived := False;
 f_ContentsTreeOpened := False;
end;//Start

function TprDocument.Id: Integer;
  // override;
  {* - идентификатор профайлера. }
begin
 Result := Ord(ucpDocument);
end;

procedure TprDocument.ContentsTreeOpened;
  {* - открыта структура документа. }
begin
 if not f_ContentsTreeOpened then
 begin
  Finish;
  f_ContentsTreeOpened := True;
 end;//if not f_ContentsTreeOpened then
end;//ContentsTreeOpened

procedure TprDocument.DocumentPainted;
  {* - документ отрисован. }
begin
 Finish;
end;

procedure TprDocument.DocumentReceived;
  {* - документ получен с адаптера. }
begin
 if not f_DocumentReceived then
 begin
  Finish;
  f_DocumentReceived := True;
 end;//if not f_DocumentReceived then
end;//DocumentReceived

procedure TprDocument.FormSetCreated;
  {* - сборка создана. }
begin
 Finish;
end;

function TprDocument.FinishCount: Integer;
begin
 Result := c_fcDocument;
end;

function TprDocument.UseCaseName: String;
begin
 Result := c_prDocument;
end;

{ TnsProfiler }

procedure TnsProfiler.Start;
  {* - начать замер, вызывается перед созданием сборки. }
begin
 vcmProfilers.StartProfile(UseCaseName, Id, FinishCount);
end;

procedure TnsProfiler.Finish;
  {* - закончить измерение. }
begin
 vcmProfilers.FinishProfile(Id);
end;

class function TnsProfiler.Make: InsProfiler;
var
 l_Class: TnsProfiler;
begin
 l_Class := Create;
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;
end;

{ TnsProfilersManager }

procedure TnsProfilersManager.Cleanup;
begin
 f_MainMenu := nil;
 f_QueryCard := nil;
 f_ListAfterSearch := nil;
 f_Document := nil;
 inherited;
end;

class function TnsProfilersManager.Make: InsProfilersManager;
var
 l_Class: TnsProfilersManager;
begin
 l_Class := TnsProfilersManager.Create;
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;
end;

function TnsProfilersManager.pm_GetMainMenu: IprMainMenu;
  {* - открытие основного меню. }
begin
 if not Assigned(f_MainMenu) then
  Supports(TprMainMenu.Make, IprMainMenu, f_MainMenu);
 Result := f_MainMenu;
end;

function TnsProfilersManager.pm_GetListAfterSearch: IprListAfterSearch;
  {* - открытие документа после поиска. }
begin
 if not Assigned(f_ListAfterSearch) then
  Supports(TprListAfterSearch.Make, IprListAfterSearch, f_ListAfterSearch);
 Result := f_ListAfterSearch;
end;

function TnsProfilersManager.pm_GetQueryCard: IprQueryCard;
  {* - профайлер карточки запроса. }
begin
 if not Assigned(f_QueryCard) then
  Supports(TprQueryCard.Make, IprQueryCard, f_QueryCard);
 Result := f_QueryCard;
end;

function TnsProfilersManager.pm_GetDocument: IprDocument;
  {* - профайлер документа. }
begin
 if not Assigned(f_Document) then
  Supports(TprDocument.Make, IprDocument, f_Document);
 Result := f_Document;
end;

{ TprQueryCard }

function TprQueryCard.FinishCount: Integer;
  {* - количество Finish для окончания измерений. }
begin
 Result := c_fcQueryCard;
end;

function TprQueryCard.Id: Integer;
  {* - идентификатор профайлера. }
begin
 Result := Ord(ucpQueryCard);
end;

function TprQueryCard.UseCaseName: String;
  {* - название прецедента. }
begin
 Result := c_prQueryCard;
end;
{$EndIf vcmUseProfilers}

{ TprListAfterSearch }

function TprListAfterSearch.FinishCount: Integer;
begin
 Result := c_fcListAfterSearch;
end;

function TprListAfterSearch.Id: Integer;
begin
 Result := Ord(ucpOpenListAfterSearch);
end;

function TprListAfterSearch.UseCaseName: String;
begin
 Result := c_prListAfterSearch;
end;

{ TprMainMenu }

function TprMainMenu.FinishCount: Integer;
begin
 Result := c_fcMainMenu;
end;

function TprMainMenu.Id: Integer;
begin
 Result := Ord(ucpMainMenu);
end;

function TprMainMenu.UseCaseName: String;
begin
 Result := c_prMainMenu;
end;

end.