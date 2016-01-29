unit SimpleMainMenu_Form;

// Библиотека : Проект Немезис;
// Название   : enSimpleMainMenu
// Автор      : Морозов М.А.
// Назначение : Простое основное меню;
// Версия     : $Id: SimpleMainMenu_Form.pas,v 1.32 2014/08/19 12:04:56 kostitsin Exp $

(*-------------------------------------------------------------------------------
   $Log: SimpleMainMenu_Form.pas,v $
   Revision 1.32  2014/08/19 12:04:56  kostitsin
   {requestlink: 562594400 }

   Revision 1.31  2014/08/19 11:26:51  kostitsin
   {requestlink: 562594400 }

   Revision 1.30  2013/01/22 15:59:55  kostitsin
   [$424399029]

   Revision 1.29  2010/05/26 12:08:23  oman
   Warning fix

   Revision 1.28  2010/04/30 17:43:44  lulin
   {RequestLink:207389954}.

   Revision 1.27  2010/04/30 15:27:06  lulin
   {RequestLink:207389954}.
   - чистка кода.

   Revision 1.26  2010/02/04 16:09:51  lulin
   {RequestLink:185834848}.

   Revision 1.25  2010/02/01 08:46:40  oman
   - fix: {RequestLink:185827991}

   Revision 1.24  2009/12/07 19:13:55  lulin
   - удалил ненужный модуль.

   Revision 1.23  2009/11/18 13:06:32  lulin
   - используем базовые параметры операции.

   Revision 1.22  2009/10/12 11:27:49  lulin
   - коммитим после падения CVS.

   Revision 1.22  2009/10/08 11:37:12  lulin
   - показываем баннеры.

   Revision 1.21  2009/10/07 12:12:18  lulin
   - подготавливаемся к чистке формы основного меню.

   Revision 1.20  2009/10/05 18:42:53  lulin
   {RequestLink:162596818}. Первые штрихи.

   Revision 1.19  2009/10/05 11:15:24  lulin
   {RequestLink:162596818}. Подготавливаем инфраструктуру.

   Revision 1.18  2009/09/30 17:25:14  lulin
   - переименовываем операцию установки текущей формы, чтобы её проще было искать.

   Revision 1.17  2009/09/28 19:36:42  lulin
   - убираем из StdRes константы для операций модулей.

   Revision 1.16  2009/09/28 18:51:08  lulin
   - убираем лишние ручки для вызова операций.

   Revision 1.15  2009/09/24 16:41:20  lulin
   - продолжаем переносить на модель модуль Common.

   Revision 1.90  2009/09/18 12:21:45  lulin
   - невоплощённое убиваем, ошмётки переносим на модель.

   Revision 1.89  2009/09/09 18:55:32  lulin
   - переносим на модель код проектов.

   Revision 1.88  2009/09/03 18:49:28  lulin
   - реструктуризируем поиски и удаляем ненужное.

   Revision 1.87  2009/09/03 13:26:27  lulin
   - делаем прецеденты более изолированными друг от друга.

   Revision 1.86  2009/08/21 12:44:33  lulin
   {RequestLink:159360578}. №8.

   Revision 1.85  2009/08/13 12:16:32  oman
   - new: Более правильная нотификация - {RequestLink:159355458}

   Revision 1.84  2009/08/13 07:13:08  oman
   - new: Более правильная нотификация - {RequestLink:159355458}

   Revision 1.83  2009/08/12 10:48:09  oman
   - new: Первое приближение - {RequestLink:159355458}

   Revision 1.82  2009/08/06 17:18:10  lulin
   - добавляем операцию сравнения редакций в список редакций.

   Revision 1.81  2009/08/06 16:08:33  lulin
   {RequestLink:159352843}.

   Revision 1.80  2009/02/20 10:12:54  lulin
   - чистка комментариев.

   Revision 1.79  2009/02/10 19:03:50  lulin
   - <K>: 133891247. Вычищаем морально устаревший модуль.

   Revision 1.78  2009/02/09 15:51:04  lulin
   - <K>: 133891247. Выделяем интерфейсы основного меню.

   Revision 1.77  2009/01/19 11:22:23  lulin
   - <K>: 135597923.

   Revision 1.76  2009/01/16 12:37:41  lulin
   - bug fix: http://mdp.garant.ru/pages/viewpage.action?pageId=135597923

   Revision 1.75  2009/01/12 15:58:31  lulin
   - <K>: 133138664. № 22.

   Revision 1.74  2008/12/29 16:40:59  lulin
   - <K>: 134316705.

   Revision 1.73  2008/12/29 15:26:39  lulin
   - <K>: 133891773.

   Revision 1.72  2008/12/25 12:20:05  lulin
   - <K>: 121153186.

   Revision 1.71  2008/12/24 19:49:38  lulin
   - <K>: 121153186.

   Revision 1.70  2008/11/07 14:20:09  lulin
   - <K>: 121167570.

   Revision 1.69  2008/11/01 11:19:53  lulin
   - <K>: 121167580.

   Revision 1.68  2008/11/01 10:58:28  lulin
   - <K>: 121167580.

   Revision 1.67  2008/11/01 10:37:54  lulin
   - <K>: 121167580.

   Revision 1.66  2008/11/01 10:08:55  lulin
   - <K>: 121167580.

   Revision 1.65  2008/10/31 11:55:07  lulin
   - <K>: 121167580.

   Revision 1.64  2008/07/07 14:27:06  lulin
   - подготавливаемся к переименованию.

   Revision 1.63  2008/06/18 10:33:00  mmorozov
   - new: последние открытые препараты (CQ: OIT5-29385);

   Revision 1.62  2008/05/22 07:05:59  mmorozov
   - new: основное меню Инфарм.

   Revision 1.61  2008/05/15 18:16:27  lulin
   - вычищаем ненужное.

   Revision 1.60  2008/05/13 16:24:26  lulin
   - изменения в рамках <K>: 90441490.

   Revision 1.59  2008/04/08 08:12:50  oman
   - new: Откручиваем БП для инфарма

   Revision 1.58  2007/12/28 17:49:53  lulin
   - удален ненужный глобальный метод.

   Revision 1.57  2007/12/25 12:27:28  mmorozov
   - new: используем прямо приведение объекта к интерфейсу вместо AS (в рамках CQ: OIT5-27823);

   Revision 1.56  2007/12/25 11:32:20  mmorozov
   - new: подписка на обновление данных приложения (CQ: OIT5-27823);

   Revision 1.55  2007/12/17 12:22:32  mmorozov
   - уведомления о начале редактирования, а также изменения пользовательских настроек + избавляемся от операции enSystem.opConfigUpdated (в рамках CQ: OIT5-27823);

   Revision 1.54  2007/12/12 12:21:23  mmorozov
   - cleanup: вычищаем операции enSystem (opActiveConfigChange, _opSetActive) (в рамках работы над CQ: OIT5-27823);

   Revision 1.53  2007/12/04 12:36:38  oman
   - new: Меняем логику расстановки фокуса для БП (cq27326)

   Revision 1.52  2007/11/13 13:37:55  mmorozov
   - new: прокрутка колесом мыши в простом основном меню (CQ: OIT5-27201);

   Revision 1.51  2007/10/30 12:39:44  mmorozov
   - rename field;

   Revision 1.50  2007/10/22 11:53:26  mmorozov
   - bugfix: не показываем контекстные операции для деревьев (CQ: OIT5-27167);

   Revision 1.49  2007/10/16 12:29:36  mmorozov
   - new behviour: используем TnscTreeView (в рамках работы над CQ: OIT5-26997);

   Revision 1.48  2007/10/10 12:55:27  mmorozov
   - bugfix: обрабатывали событие изменения формы, а нужно было обрабатывать изменение размеров подложки, на которой лежит сетка контролов, ошибка проявлялась при переключении конфигурации (связанно с правками CQ: OIT5-26991);

   Revision 1.47  2007/08/28 10:33:50  oman
   - new: Ссылка на правила работы В ППР (cq26503)

   Revision 1.46  2007/08/28 07:26:04  oman
   - fix: Вызывалась не та страница хелпа (cq26511)

   Revision 1.45  2007/08/13 05:53:47  mmorozov
   - change: группа последних открытых документов сделана несворачиваемой (CQ: OIT5-26279);

   Revision 1.44  2007/08/09 10:05:47  oman
   - new: Успешный БП из ОМ трактуем как ручной вызов БП - т.е. в
    открывшемся списке появиться панель БП (cq26300)

   Revision 1.43  2007/07/30 09:24:32  mmorozov
   - new: используем таблицу стилей для устновки цвета фона заголовка скрываемого поля;

   Revision 1.42  2007/06/14 13:50:15  mmorozov
   - change: порядок модулей;

   Revision 1.41  2007/05/08 11:17:37  oman
   - fix: Для карточки базового поиска  (cq25145)

   Revision 1.40  2007/05/07 14:31:18  mmorozov
   - new: реакция на изменение типа основного меню в настройках (CQ: OIT5-24871);

   Revision 1.39  2007/05/04 10:55:06  oman
   - fix: Терялся фокус - по аналогии с ОМ грязно хачим

   Revision 1.38  2007/05/04 07:45:47  oman
   - fix: Интерфейсы для базового поиска перенесены в проект (cq25145)

   Revision 1.37  2007/05/03 15:01:32  oman
   - fix: Таки переключаем внешний вид при смене фокуса (cq25149)

   Revision 1.36  2007/05/03 14:25:00  oman
   - fix: Пытаемся переключать внешний вид (cq25149)

   Revision 1.35  2007/05/03 09:44:21  mmorozov
   - change: отрезаем заголовок "продвинутого основного меню" (CQ: OIT5-25061);

   Revision 1.34  2007/05/03 08:24:03  oman
   - new: Убрал базовый поиск из простейшего основного меню (cq25149)

   Revision 1.33  2007/05/03 06:57:56  oman
   - new: Окончательный вариант обработки закрытия окна базового
    поиска (cq25145)

   Revision 1.32  2007/05/02 14:23:22  oman
   - fix: Более правильная механика закрытия/автооткрытия окна (cq25145)

   Revision 1.31  2007/05/02 09:07:00  oman
   - new: Механика закрытия/автооткрытия окна (cq25145)

   Revision 1.30  2007/04/28 12:05:54  oman
   - new: Первоначальная поддержка механизма нотификации
    для базового поиска (cq25145)

   Revision 1.29  2007/04/17 12:31:51  mmorozov
   - bugfix: формирование имени;

   Revision 1.28  2007/04/17 12:08:56  mmorozov
   - change: используем правильные функции при подготовке названия формы;

   Revision 1.27  2007/04/17 11:50:00  lulin
   - cleanup.

   Revision 1.26  2007/04/17 10:49:20  mmorozov
   - new: изменяем ОМ (CQ: OIT5-25062);

   Revision 1.25  2007/04/16 10:41:48  oman
   - fix: Переименовываем "Правовая поддержка" в "Правовая
    поддержка онлайн" (cq25059)

   Revision 1.24  2007/04/11 15:15:37  mmorozov
   - new: в простом основном меню показываем полные названия в списке последних открытых (CQ: OIT5-24958);
   - change: фокус перехода;

   Revision 1.23  2007/04/09 13:04:00  mmorozov
   - bugfix: при поиске в основном меню используем правильную функцию поиска (CQ: OIT5-24547);

   Revision 1.22  2007/04/06 08:29:48  mmorozov
   - new: в деревьях включён перенос строк + форма не пишет данные в историю, строим сетку контролов после загрузки (Loaded) (CQ: OIT5-24903);

   Revision 1.21  2007/04/06 07:52:07  mmorozov
   - change: изменены формулировки, положение групп (CQ: OIT5-24602);

   Revision 1.20  2007/04/05 13:42:45  lulin
   - избавляемся от лишних преобразований строк.

   Revision 1.19  2007/03/28 19:43:02  lulin
   - ЭлПаковский редактор переводим на строки с кодировкой.

   Revision 1.18  2007/03/28 11:40:39  mmorozov
   - rename method;

   Revision 1.17  2007/03/28 11:04:56  mmorozov
   - "таблица перехода фокуса" перенесена в библиотеку визуальных компонентов проекта Немезис;

   Revision 1.16  2007/03/22 12:29:34  mmorozov
   - change: ячейка сетки контролов в виде скрываемого поля с деревом перенесена в общее место;

   Revision 1.15  2007/03/20 11:38:15  lulin
   - не теряем кодировку при присваивании заголовков форм и контролов.

   Revision 1.14  2007/03/02 13:15:48  lulin
   - присваимваем строку с кодировкой, без преобразования ее к родной дельфийской.

   Revision 1.13  2007/02/16 19:19:18  lulin
   - в выпадающих списках используем родной список строк.

   Revision 1.12  2007/02/09 15:56:18  mmorozov
   - new: правильно реализуем поиск по контексту в простом основном меню (CQ: OIT5-24353);

   Revision 1.11  2007/02/08 13:36:12  mmorozov
   - new: реакция на поиск по пустому контексту (CQ: OIT5-24293);

   Revision 1.10  2007/02/08 12:39:43  mmorozov
   - change: обобщена и упрощена логика по работе с элементами дерева навигатора (CQ: OIT5-23939);

   Revision 1.9  2007/02/07 14:30:43  lulin
   - переводим на строки с кодировкой.

   Revision 1.8  2007/02/05 12:06:09  mmorozov
   - opt: не строим лишний раз таблицу контролов;

   Revision 1.7  2007/02/05 11:08:29  mmorozov
   - new behaviour: перестраиваем меню после перехода по истории;

   Revision 1.6  2007/02/02 14:55:09  mmorozov
   - new: используем новые типы узлов рубрикатора;

   Revision 1.5  2007/02/02 08:39:11  lulin
   - переводим на строки с кодировкой.

   Revision 1.4  2007/01/29 14:29:23  mmorozov
   - new: введем историю поисков; добавления операция поиска; (в рамках CQ: OIT5-24234);

   Revision 1.3  2007/01/29 10:08:33  mmorozov
   - new: в рамках работы над CQ: OIT5-24234;
   - bugfix: не обновляли деревья после переключения базы;

   Revision 1.2  2007/01/19 14:35:45  mmorozov
   - new: поиск по контексту в простом варианте основного меню (CQ: OIT5-23939);

   Revision 1.1  2007/01/18 12:57:20  mmorozov
   - new: Простое основное меню (CQ: OIT5-23939);
-------------------------------------------------------------------------------*)

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  StdCtrls,

  afwControl,
  afwInputControl,
  afwInterfaces,
  afwCustomCommonControl,

  l3Interfaces,
  l3TreeInterfaces,

  vtLabel,
  vtLister,
  vtOutliner,
  vtOutlinerWithQuickSearch,
  vtOutlinerWithDragDrop,
  vtHideField,

  OvcBase,

  vtPanel,

  ElXPThemedControl,

  AbstractDropDown,
  DropDownTree,

  eeTreeViewExport,
  eeTreeView,

  nscInterfaces,
  nscCombobox,

  vcmInterfaces,
  vcmBase,
  vcmEntityForm,
  vcmEntities,
  vcmComponent,
  vcmBaseEntities,
  vcmExternalInterfaces,

  nscHideField,
  nscTreeView,

  nsMainMenuNew,

  MainMenuNewRes, afwControlPrim, afwBaseControl, afwTextControlPrim,
  afwTextControl,

  bsInterfaces,
  WorkJournalInterfaces,

  PrimSimpleMainMenu_Form, l3InterfacedComponent,

  BaseSearchInterfaces, nscTreeViewHotTruck
  ;

type
  Ten_SimpleMainMenu = class(TvcmEntityFormRef)
    Entities : TvcmEntities;
    pnlMain: TvtPanel;
    hfSearch: TnscHideField;
    hfLawNews: TnscHideField;
    hfLawSupport: TnscHideField;
    hfReferences: TnscHideField;
    hfLastOpenDocs: TnscHideField;
    tvSearch: TnscTreeView;
    tvLawSupport: TnscTreeView;
    tvLastOpenDocs: TnscTreeViewHotTruck;
    tvReferences: TnscTreeViewHotTruck;
    tvLawNews: TnscTreeViewHotTruck;
    procedure lblCompNameClick(Sender: TObject);
  protected
  // methods
    procedure DoInitKeyboardNavigation(const aTable : InscTabTable); override;
      {-}
    procedure LoadLastOpenDocs; override;
      {* - загрузить список последних открытых документов. }
    function DoBuildGrid: InscArrangeGrid; override;
      {* - построить сетку контролов. }
    procedure LoadTrees; override;
      {-}
  end;//Ten_SimpleMainMenu

implementation

uses
  l3Base,
  l3String,
  l3Chars,
  
  afwFacade,

  lgTypes,

  vcmStringList,

  nscArrangeGrid,
  nscArrangeGridCell,

  StartUnit,

  nsTypes,
  nsUtils,
  nsSettings,
  nsConst,
  nscTabTable,
  nscTabTableCell,
  nsOpenUtils,

  DataAdapter,

  StdRes,
  nsLastOpenDocTree,
  smSearchTree,
  smLawNewsTree,
  smLawSupport,
  smReferencesTree,

  MainMenuDomainInterfaces
  ;

{$R *.DFM}

function Ten_SimpleMainMenu.DoBuildGrid: InscArrangeGrid;
begin
 Result := TnscArrangeGrid.Make(False);
 with Result do
 begin
  AddColumn;
  AddColumn;
  AddRow;
  AddRow;
  Cell[0, 0] := TnscHideFieldCell.Make(hfSearch, True);
  Cell[0, 1] := TnscHideFieldCell.Make(hfReferences, True);
  Cell[1, 0] := TnscHideFieldCell.Make(hfLawNews, True);
  Cell[1, 1] := TnscHideFieldCell.Make(hfLawSupport, True);
  MergeCells(2, 0, 1, TnscHideFieldCell.Make(hfLastOpenDocs));
 end;//with Result do
end;//BuildGrid

procedure Ten_SimpleMainMenu.LoadTrees;
begin
 inherited;
 tvSearch.TreeStruct := TsmSearchTree.Make;
 tvLawSupport.TreeStruct := TsmLawSupport.Make;
end;

procedure Ten_SimpleMainMenu.DoInitKeyboardNavigation(const aTable : InscTabTable);
begin
 // Навигация с помощью клавиатуры
 with aTable.AddColumn do
 begin
  AddItem(TnscTreeViewTabCell.Make(tvSearch));
  AddItem(TnscTreeViewTabCell.Make(tvLawNews));
  AddItem(TnscTreeViewTabCell.Make(tvLastOpenDocs));
 end;//with aTable.AddItem do
 with aTable.AddColumn do
 begin
  AddItem(TnscTreeViewTabCell.Make(tvReferences));
  AddItem(TnscTreeViewTabCell.Make(tvLawSupport));
 end;//with aTable.AddItem do
end;//KeyboardNavigation

procedure Ten_SimpleMainMenu.lblCompNameClick(Sender: TObject);
begin
 Dispatcher.ModuleOperation(TdmStdRes.mod_opcode_Common_ComplectInfo);
end;//lblCompNameClick

procedure Ten_SimpleMainMenu.LoadLastOpenDocs;
begin
 tvLastOpenDocs.TreeStruct := TnsLastOpenDocTree.Make(afw.Settings.LoadInteger(
  pi_RecentlyOpenDocumentsCount, dv_RecentlyOpenDocumentsCount),
  False,
  True);
end;//LoadLastOpenDocs

end.