unit nscInterfaces;

// Библиотека : Интерфейсы компонентов проекта "Немезис";                       }
// Автор      : Морозов М.А;                                                    }
// Начат      : 16.02.2005 14.44;                                               }
// Модуль     : nscInterfaces;                                                  }
// Описание   : Бизнес объект формы "fcSynchroView";                            }
// Версия     : $Id: nscInterfaces.pas,v 1.43 2016/03/29 09:16:01 kostitsin Exp $                                                            }

(*-------------------------------------------------------------------------------
  $Log: nscInterfaces.pas,v $
  Revision 1.43  2016/03/29 09:16:01  kostitsin
  {requestlink: 620672440 }

  Revision 1.42  2012/10/26 14:57:56  lulin
  {RequestLink:406489593}

  Revision 1.41  2010/03/10 19:41:58  lulin
  {RequestLink:196445017}.

  Revision 1.40  2010/03/10 17:50:39  lulin
  {RequestLink:196445017}.

  Revision 1.39  2010/03/10 16:46:28  lulin
  {RequestLink:196445017}.

  Revision 1.38  2010/03/10 13:22:16  lulin
  {RequestLink:196445017}.
  - чистка кода.

  Revision 1.37  2009/11/17 10:34:39  oman
  - fix: {RequestLink:171967027}

  Revision 1.36  2009/10/13 15:11:16  lulin
  - даём возможность указывать ячейке минимальную высоту.

  Revision 1.35  2009/10/12 16:35:05  lulin
  - исправляем по результатам [$166428831].

  Revision 1.34  2009/10/12 11:27:13  lulin
  - коммитим после падения CVS.

  Revision 1.34  2009/10/08 09:50:53  lulin
  - показываем скроллеры и максимально подгоняем под макет.

  Revision 1.33  2009/10/06 13:19:01  lulin
  - bug fix: не собиралось.

  Revision 1.32  2009/10/06 13:14:05  lulin
  {RequestLink:162596818}. Добился правильной вёрстки.

  Revision 1.31  2009/04/13 12:54:38  oman
  - new: Локализация текста - [$143392959]

  Revision 1.30  2009/01/28 11:14:12  lulin
  - <K>: 133138664. №26.

  Revision 1.29  2009/01/12 17:38:11  lulin
  - <K>: 133138664. № 24.

  Revision 1.28  2008/10/29 12:04:23  lulin
  - <K>: 121166314.

  Revision 1.27  2008/08/06 16:57:06  mmorozov
  - bugfix: заливаем только область панели задач без детей (K<104435077>);

  Revision 1.26  2008/07/01 12:46:08  oman
  - new: При вставке из клипборда перефильтровываем дерево посимвольно (К-96474339)

  Revision 1.25  2008/06/26 11:18:35  oman
  - fix: Боремся с перетрансляцией ввода (cq11768)

  Revision 1.24  2008/05/15 12:39:55  oman
  - fix: Передаем новое описание для операций в статусбаре (cq28402)

  Revision 1.23  2008/03/19 06:28:30  mmorozov
  - new: использование константной строки при перетаскивании (в рамках CQ: OIT5-28528);

  Revision 1.22  2007/11/02 12:23:22  mmorozov
  - new: при перемещении между столбцами таблицы перехода фокуса учитываем не порядковый номер ячейки в столбце из которого переходим, а координаты ячейки (в рамках работы над CQ: OIT5-27189) + сопутствующий рефакторинг;

  Revision 1.21  2007/10/30 12:36:29  mmorozov
  В рамках работы над CQ: OIT5-27189:
  - TvtHideField теперь компонент с фокусом ввода;
  - Подключаем TvtHideField к обработке ввода с клавиатуры;
  - Подключаем TvtHideField к таблице перехода фокуса;

  Revision 1.20  2007/09/17 10:42:55  mmorozov
  New:
  - выделен интерфейс для получения уведомления о блокировке\разблокировки диспетчера форм на время выполенения операций модуля любым желающим (раньше только IvcmForm);
  - панель задач должна работать побыстрее, посколько перечитываем операции после добавления последней формы прецедента, а не каждой как это было раньше;
  - избавились от анимации в панели задач, при навигации между прецедентами;
  - почищен код;

  В рамках задачи CQ: OIT5-26623;

  Revision 1.19  2007/08/20 09:06:07  mmorozov
  - new: уведомление об изменении активной вкладки (CQ: OIT5-26352);

  Revision 1.18  2007/08/16 06:58:50  mmorozov
  - new behaviour: пишем событие фильтрации дерева также при разрушении компонета фильтрации (CQ: OIT5-26366);

  Revision 1.17  2007/08/03 09:39:49  oman
  - new: Готовимся к пабликации операций на статусбаре (cq25326)

  Revision 1.16  2007/07/26 09:38:38  mmorozov
  - new: возможность подписки на события контекстного фильтра (в рамках CQ: OIT5-25852);

  Revision 1.15  2007/03/30 11:02:53  oman
  Cleanup (ContextParams)

  Revision 1.14  2007/03/28 13:12:09  mmorozov
  - new: очистка таблицы перехода фокуса;

  Revision 1.13  2007/03/28 11:39:38  mmorozov
  - подключаем таблицу перехода фокуса к панели задач;

  Revision 1.12  2007/03/28 11:02:54  mmorozov
  - "таблица перехода фокуса" перенесена в библиотеку визуальных компонентов проекта Немезис;

  Revision 1.11  2007/03/27 13:59:09  mmorozov
  - cleanup;

  Revision 1.10  2007/03/27 07:41:24  mmorozov
  - вставка строки в сетку контролов (начало);

  Revision 1.9  2007/03/23 12:56:11  mmorozov
  - в рамках работы над представлением панели задач, представление обновляет своё содержимое при изменении данных;

-------------------------------------------------------------------------------*)

interface

uses
  Controls,
  Classes,
  Windows,

  l3Interfaces,

  afwInterfaces

  {$IfNDef NoVCM}
  ,
  vcmExternalInterfaces
  {$EndIf  NoVCM}
  ;

type
  {----------------------------------------------------------------------------}
  { ArrangeGrid - сетка контролов.                                             }
  {----------------------------------------------------------------------------}
  IagRow = interface;
  IagColumn = interface;

  IagBaseCell = interface(IUnknown)
   {* Ячейка с компонентом. }
    ['{71868E30-C9ED-43C9-9ECD-63B1FE8E14FB}']
    // property methods
      function pm_GetMinWidth: Integer;
      procedure pm_SetMinWidth(const aValue: Integer);
        {* - минимальная ширина, до которой можно уменьшать компонент. }
      function pm_GetFullWidth: Integer;
        {* - ширина, при которой компонент будет показан полностью. }
      function pm_GetMinHeight: Integer;
      procedure pm_SetMinHeight(const aValue: Integer);
        {* - минимальная высота, до которой можно уменьшать компонент. }
      function pm_GetFullHeight: Integer;
        {* - высота, при которой компонент будет показан полностью. }
      function pm_GetStartColumn: IagColumn;
      procedure pm_SetStartColumn(const Value: IagColumn);
        {-}
      function pm_GetEndColumn: IagColumn;
      procedure pm_SetEndColumn(const Value: IagColumn);
        {-}
      function pm_GetStartRow: IagRow;
      procedure pm_SetStartRow(const Value: IagRow);
        {-}
      function pm_GetEndRow: IagRow;
      procedure pm_SetEndRow(const Value: IagRow);
        {-}
    // public methods
      procedure ArrangeContent;
        {* - разместить содержимое ячейки. }
      procedure Constraints(const aMinWidth   : Integer;
                            const aFullWidth  : Integer;
                            const aMinHeight  : Integer;
                            const aFullHeight : Integer);
        {* - ограничения на размер ячейки. }
      procedure Attached;
        {* - вызывается при присоединении ячейки к таблице. }
      procedure RecalcConstraints;
        {* - пересчитать ограничения ячейки. }
      function TwoStageBuild: Boolean;
        {-}
    // properties
      property MinWidth: Integer
        read pm_GetMinWidth
        write pm_SetMinWidth;
        {* - минимальная ширина, до которой можно уменьшать компонент. }
      property FullWidth: Integer
        read pm_GetFullWidth;
        {* - ширина, при которой компонент будет показан полностью. }
      property MinHeight: Integer
        read pm_GetMinHeight
        write pm_SetMinHeight;
        {* - минимальная высота, до которой можно уменьшать компонент. }
      property FullHeight: Integer
        read pm_GetFullHeight;
        {* - высота, при которой компонент будет показан полностью. }
      property StartColumn: IagColumn
        read pm_GetStartColumn
        write pm_SetStartColumn;
        {-}
      property EndColumn: IagColumn
        read pm_GetEndColumn
        write pm_SetEndColumn;
        {-}
      property StartRow: IagRow
        read pm_GetStartRow
        write pm_SetStartRow;
        {-}
      property EndRow: IagRow
        read pm_GetEndRow
        write pm_SetEndRow;
        {-}
  end;//IagBaseCell

  IagControlCell = interface(IagBaseCell)
  {* Ячейка содержащая компонент. }
   ['{7E9F2C03-6B50-4CBF-B05B-D10C222EE60B}']
   // property methods
     function pm_GetControl: TControl;
     procedure pm_SetControl(const aValue: TControl);
       {* - компонент ячейки. }
   // properties
     property Control: TControl
       read pm_GetControl
       write pm_SetControl;
       {* - компонент ячейки. }
  end;//IagControlCell

  IagCellsOwner = interface(IUnknown)
   {* Владелец ячеек. }
    ['{08D9593E-872C-4EEB-983B-FAEBB7825A87}']
    // property methods
      function pm_GetCell(const aIndex: Integer): IagBaseCell;
      procedure pm_SetCell(const aIndex : Integer;
                           const Value  : IagBaseCell);
        {-}
      function pm_GetCellCount: Integer;
        {-}
    // public methods
      procedure AddCell(const aCell: IagBaseCell);
        {-}
      procedure DeleteCell(const aIndex: Integer);
        {-}
      procedure CellChanged;
        {-}
      procedure RecalcCells;
        {* - пересчитать размеры ячеек. }
      procedure ResetConstraints;
        {-}
      procedure Delete;
        {-}
    // properties
      property Cell[const aIndex: Integer]: IagBaseCell
        read pm_GetCell
        write pm_SetCell;
        {-}
      property CellCount: Integer
        read pm_GetCellCount;
        {-}
  end;//IagCellsOwner

  IagRow = interface(IagCellsOwner)
   {* Строка компонентов. }
    ['{7E071A62-DBAF-495E-9C98-BAA2C406F104}']
    // property methods
      function pm_GetHeight: Integer;
        {-}
      function pm_GetTop: Integer;
        {-}
      function pm_GetBottom: Integer;
        {-}
      function pm_GetMinHeight: Integer;
      procedure pm_SetMinHeight(const aValue: Integer);
        {-}
      function pm_GetFullHeight: Integer;
        {-}
      function pm_GetFixedHeight: Integer;
      procedure pm_SetFixedHeight(const aValue: Integer);
        {* - строка имеет высоту фиксированного размера. }
    // public methods
      procedure SetBounds(const aTop, aBottom: Integer);
        {-}
      function TwoStageBuild: Boolean;
        {-}
    // properties
      property Top: Integer
        read pm_GetTop;
        {-}
      property Bottom: Integer
        read pm_GetBottom;
        {-}
      property MinHeight: Integer
        read pm_GetMinHeight
        write pm_SetMinHeight;
        {-}
      property FullHeight: Integer
        read pm_GetFullHeight;
        {-}
      property FixedHeight: Integer
        read pm_GetFixedHeight
        write pm_SetFixedHeight;
        {* - строка имеет высоту фиксированного размера. }
      property Height: Integer
        read pm_GetHeight;
        {-}
  end;//IagRow

  IagColumn = interface(IagCellsOwner)
   {* Столбец компонентов. }
    ['{36ECB62C-4D85-491D-A97C-1EC677AC03B9}']
    // property methods
      function pm_GetLeft: Integer;
        {-}
      function pm_GetRight: Integer;
        {-}
      function pm_GetMinWidth: Integer;
      procedure pm_SetMinWidth(const aValue: Integer);
        {-}
      function pm_GetFullWidth: Integer;
        {-}
      function pm_GetWidth: Integer;
        {* - реальная ширина столбца. }
      function pm_GetFixedWidth: Integer;
      procedure pm_SetFixedWidth(const aValue: Integer);
        {* - строка имеет высоту фиксированного размера. }
    // public methods
      procedure SetBounds(const aLeft, aRight: Integer);
        {-}
    // properties
      property Left: Integer
        read pm_GetLeft;
        {-}
      property Right: Integer
        read pm_GetRight;
        {-}
      property MinWidth: Integer
        read pm_GetMinWidth
        write pm_SetMinWidth;
        {* - минимальная ширина для отображения содержимого столбца. }
      property FullWidth: Integer
        read pm_GetFullWidth;
        {* - ширина при которой отображается всё содержимое. }
      property Width: Integer
        read pm_GetWidth;
        {* - реальная ширина столбца. }
      property FixedWidth: Integer
        read pm_GetFixedWidth
        write pm_SetFixedWidth;
        {* - строка имеет высоту фиксированного размера. }
  end;//IagColumn

  InscArrangeGrid = interface(IUnknown)
   {* Сетка компонентов. }
    ['{80C2D058-A990-4CBA-8576-AAC95BF4C47D}']
    // property methods
      function pm_GetIsEmpty: Boolean;
        {* - является ли таблица пустой. }
      function pm_GetColumn(const aIndex: Integer): IagColumn;
        {-}
      function pm_GetRow(const aIndex: Integer): IagRow;
        {-}
      function pm_GetHeight: Integer;
        {* - высота таблицы. }
      function pm_GetWidth: Integer;
        {* - ширина таблицы. }
      function pm_GetRowCount: Integer;
        {-}
      function pm_GetColumnCount: Integer;
        {-}
      function pm_GetCell(const aRow : Integer;
                          const aCol : Integer): IagBaseCell;
      procedure pm_SetCell(const aRow  : Integer;
                           const aCol  : Integer;
                           const Value : IagBaseCell);
        {-}
      function pm_GetMinHeight: Integer;
        {-}
      function pm_GetMinWidth: Integer;
        {-}
      function pm_GetFullWidth: Integer;
        {* - ширина при которой содержимое ячейки показывается полностью. }
      function pm_GetFullHeight: Integer;
        {* - высота при которой содержимое ячейки показывается полностью. }
      function pm_GetLeft: Integer;
        {-}
      function pm_GetTop: Integer;
        {-}
      function pm_GetLastColumn: IagColumn;
        {-}
      function pm_GetLastRow: IagRow;
        {-}
    // property of events
      function pm_GetOnSizeChanged: TNotifyEvent;
      procedure pm_SetOnSizeChanged(const aValue: TNotifyEvent);
        {* - измененился размер таблицы. }
    // public methods
      function AddRow: IagRow;
        {* - добавить строку. }
      function AddColumn: IagColumn;
        {* - добавить столбец. }
      procedure SetBounds(const aLeft   : Integer;
                          const aTop    : Integer;
                          const aWidth  : Integer;
                          const aHeight : Integer);
        {-}
      procedure Recalc;
        {* - пересчитать размеры ячеек. }
      procedure MergeCells(const aRow  : Integer;
                           const aFrom : Integer;
                           const aTo   : Integer;
                           const aCell : IagBaseCell);
        {* - объединить ячейки. }
      procedure BeginUpdate;
        {* - начата процедура обновления, в этот момент перестроения делать не
             нужно. }
      procedure EndUpdate;
        {* - закончена процедура обновления, нужно перестроить сетку, если до
             этого были запросы на перестроение. }
      function TwoStageBuild: Boolean;
        {-}
    // properties
      property Left: Integer
        read pm_GetLeft;
        {-}
      property Top: Integer
        read pm_GetTop;
        {-}
      property Height: Integer
        read pm_GetHeight;
        {* - высота таблицы. }
      property Width: Integer
        read pm_GetWidth;
        {* - ширина таблицы. }
      property MinHeight: Integer
        read pm_GetMinHeight;
        {-}
      property MinWidth: Integer
        read pm_GetMinWidth;
        {-}
      property FullWidth: Integer
        read pm_GetFullWidth;
        {* - ширина при которой содержимое ячейки показывается полностью. }
      property FullHeight: Integer
        read pm_GetFullHeight;
        {* - высота при которой содержимое ячейки показывается полностью. }
      property Cell[const aRow: Integer;
                    const aCol: Integer]: IagBaseCell
        read pm_GetCell
        write pm_SetCell;
        {-}
      property Row[const aIndex: Integer]: IagRow
        read pm_GetRow;
        {-}
      property RowCount: Integer
        read pm_GetRowCount;
        {-}
      property Column[const aIndex: Integer]: IagColumn
        read pm_GetColumn;
        {-}
      property ColumnCount: Integer
        read pm_GetColumnCount;
        {-}
      property LastColumn: IagColumn
        read pm_GetLastColumn;
        {-}
      property LastRow: IagRow
        read pm_GetLastRow;
        {-}
      property IsEmpty: Boolean
        read pm_GetIsEmpty;
        {* - является ли таблица пустой. }
    // events
      property OnSizeChanged: TNotifyEvent
        read pm_GetOnSizeChanged
        write pm_SetOnSizeChanged;
        {* - измененился размер таблицы. }
  end;//InscArrangeGrid
  {----------------------------------------------------------------------------}
  { TabTable - таблица перехода фокуса.                                        }
  {----------------------------------------------------------------------------}

  TnscTabTableKey = (
  {* Команды нажатия на клавиши. }
    ns_kLeft,
    ns_kRight,
    ns_kUp,
    ns_kDown,
    ns_kNone
  );//TnscTabTableKey

  TnscOnProcessKey = procedure (const aKey : TnscTabTableKey) of Object;
   {* Событие нажатия на кнопку в компоненте, если False, то компоненту не нужно
      обрабатывать нажатие. }

  InscTabTableCell = interface(IUnknown)
   {* Элемент таблицы с деревьями. }
    ['{CCF8B348-7903-4874-9498-59D4A4C25AC5}']
    // private methods
      function pm_GetBounds: TRect;
        {* - размеры ячейки в координатах экрана. }
      function pm_GetCurrent: Integer;
      procedure pm_SetCurrent(const aValue : Integer);
        {-}
      function pm_GetCount : Integer;
        {-}
      function pm_GetOnProcessKey : TnscOnProcessKey;
        {-}
      procedure pm_SetOnProcessKey(const aValue : TnscOnProcessKey);
        {-}
      function pm_GetControl: TWinControl;
        {-}
    // public methods
      procedure SetFocus(const aFromNext: Boolean = True);
        {* - установить фокус, который был у следующего элемента. Это нужно для
             установки на первый\последний элемент деревьев. }
    // public properties
      property Current : Integer
        read pm_GetCurrent
        write pm_SetCurrent;
        {-}
      property Count : Integer
        read pm_GetCount;
        {-}
      property Bounds: TRect
        read pm_GetBounds;
        {* - размеры ячейки в координатах экрана. }
    // public events
      property OnProcessKey : TnscOnProcessKey
        read pm_GetOnProcessKey
        write pm_SetOnProcessKey;
        {* - обработчик события нажатия на клавишу в компоненте. }
      property Control : TWinControl
        read pm_GetControl;
        {-}
  end;//InscTabTableCell

  InscTabTableColumn = interface(IUnknown)
   {* Столбец таблицы с деревьями. }
    ['{516A139E-15C7-465E-AC19-D9AA8596B555}']
    // public methods
      procedure AddItem(const aItem: InscTabTableCell);
        {* - добавляет элемент в список. }
  end;//InscTabTableColumn

  InscTabTable = interface(IUnknown)
   {* Таблица с деревьями для переключения фокуса между деревьями с
      клавиатуры. }
    ['{33052648-30B9-4718-9F30-99AE85313C61}']
    // property methods
      function pm_GetColumnCount: Integer;
        {-}
      function pm_GetColumn(const aIndex: Integer): InscTabTableColumn;
        {-}
    // public methods
      function AddColumn : InscTabTableColumn;
        {* - добавляет новый столбец. }
      procedure Clear;
        {-}
    // properties
      property ColumnCount: Integer
        read pm_GetColumnCount;
        {-}
      property Column[const aIndex: Integer]: InscTabTableColumn
        read pm_GetColumn;
        {-}
  end;//InscTabTable

implementation

end.