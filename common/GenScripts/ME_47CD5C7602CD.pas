unit evQueryCardInt;
 {* интерфейсы для КЗ. }

// Модуль: "w:\common\components\gui\Garant\Everest\qf\evQueryCardInt.pas"
// Стереотип: "Interfaces"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , nevTools
 , l3Interfaces
 , evdTypes
 , nevBase
 , l3PureMixIns
 , l3Variant
 , l3Types
 , k2Interfaces
 , k2Prim
;

type
 InevBase = nevTools.InevBase;

 TevButtonType = (
  ev_btNone
  , ev_btLogical
  , ev_btAdd
  , ev_btDelete
 );//TevButtonType

 TevComboStyle = (
  ev_cbFilterable
  , ev_cbDropDown
 );//TevComboStyle

 IevCustomParaTool = interface(InevBase)
  ['{F96CF4AB-61BA-4F63-9E57-93BF7BCA563C}']
  function Get_Para: InevPara;
  property Para: InevPara
   read Get_Para;
   {* Параграф, соотвествующий объекту. }
 end;//IevCustomParaTool

 IevDescriptionReq = interface(IevCustomParaTool)
  ['{39E4DC89-8746-4B32-8E8C-FD5EF32307A9}']
  function pm_GetReqName: Il3CString;
  function pm_GetCollapsed: Boolean;
  procedure pm_SetCollapsed(aValue: Boolean);
  property ReqName: Il3CString
   read pm_GetReqName;
  property Collapsed: Boolean
   read pm_GetCollapsed
   write pm_SetCollapsed;
 end;//IevDescriptionReq

 IevControlIterator = interface;

 IevCustomEditorControl = interface(IevCustomParaTool)
  {* Базовый интерфес для всех контролов (блоков и конкретных кнопок). Для использования внутри прослойки. }
  ['{8D573C85-19D6-4023-AAA9-40E656222B46}']
  function Get_ControlName: Tl3WString;
  procedure Set_ControlName(const aValue: Tl3WString);
  function Get_ControlType: TevControlType;
  function Get_Visible: Boolean;
  procedure Set_Visible(aValue: Boolean);
  function Get_Upper: Boolean;
  procedure Set_Upper(aValue: Boolean);
  function IsMultiline: Boolean;
   {* Контрол содержит несколько строк и поддерживает перемещение по ним 
          с помощью стрелок (к меткам это не относится). }
  function GetControlIterator: IevControlIterator;
   {* Интерфейс "навигатора" по контролам. }
  procedure InitBoolProperty(aIdent: Integer;
   aValue: Boolean);
   {* Для установки начальных значений (не используется передача данных для 
         процессора операций). }
  procedure UpperChange;
   {* Обработчик изменения состояния кнопок. }
  property ControlName: Tl3WString
   read Get_ControlName
   write Set_ControlName;
   {* Имя контрола (тег - k2_tiName). }
  property ControlType: TevControlType
   read Get_ControlType;
   {* Тип контрола. }
  property Visible: Boolean
   read Get_Visible
   write Set_Visible;
   {* Видимость контрола. }
  property Upper: Boolean
   read Get_Upper
   write Set_Upper;
   {* Состояние для Flat-кнопки. }
 end;//IevCustomEditorControl

 IevControlIterator = interface(InevBase)
  ['{6328C97E-55E5-41E6-A89C-7ACE388C46F2}']
  function GetNextVisible(OnlyFields: Boolean): IevCustomEditorControl;
   {* Возвращает следующий видимый контрол или nil, если такого нет. }
  function GetPrevVisible(OnlyFields: Boolean): IevCustomEditorControl;
   {* Возвращает предыдущий видимый контрол или nil, если такого нет. }
 end;//IevControlIterator

 TevQueryType = (
  {* Тип КЗ. }
  ev_qtAttributeSearch
   {* ППР }
  , ev_qtLegistationReview
   {* Обзор законодательства }
  , ev_qtPostingsOrder
   {* Заказ рассылки }
  , ev_qtSearchWithLawSupport
   {* Поиск с правовой поддержкой (машина Доброва) }
  , ev_qtConsultations
   {* Правовая поддержка }
  , ev_qtInpharm
   {* Поиск лекарственного препарата }
 );//TevQueryType

 IevEditorControl = interface;

 IevModelListener = interface;

 IevEditorFieldWithTree = interface;

 IevReq = interface;

 IevAdapterModel = interface(InevBase)
  ['{8486860A-0D26-4E6E-A10B-300423475B2E}']
  {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
  function Get_HistoryList: Il3StringsEx;
  {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
  procedure FocusStartField;
   {* Устанавливает фокус на первый элемент. }
  procedure LimitCharsReached(const aControl: IevEditorControl);
  function GetTreeFromAdapter(const aReq: Il3CString): InevSimpleTree;
   {* Получает дерево с адаптера. }
  procedure EscPressed(const aField: IevEditorFieldWithTree);
   {* Обработчик закрытия дерева по ESC. }
  function ModelListener(const aReq: IevReq): IevModelListener;
  function GetPromptTreeFromAdapter: InevSimpleTree;
  procedure NotifyContextWrong;
  {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
  property HistoryList: Il3StringsEx
   read Get_HistoryList;
   {* История ввода. }
  {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
 end;//IevAdapterModel

 IevEditorControlField = interface;

 IevEditorControl = interface(IevCustomEditorControl)
  {* От интерфейса InevInputListener }
  ['{E653F6A0-014F-4D03-AFF9-62933425793A}']
  function Get_Enabled: Boolean;
  procedure Set_Enabled(aValue: Boolean);
  function Get_MaxLength: Integer;
  function Get_Caption: Il3CString;
  function Get_Field: IevEditorControlField;
  procedure Set_Field(const aValue: IevEditorControlField);
  function Get_Req: IevReq;
  function LMouseBtnUp(const aView: InevControlView;
   const aPara: InevPara;
   const aPt: TnevPoint;
   const aKeys: TevMouseState;
   anInPara: Boolean): Boolean;
   {* Обработчик нажатия на левую кнопку мыши. }
  function LMouseBtnDown(const aView: InevControlView;
   const aPara: InevPara;
   const aPt: TnevPoint;
   const aKeys: TevMouseState;
   anInPara: Boolean;
   const aMap: InevMap): Boolean;
   {* Обработчик отпускания левой кнопки мыши. }
  function KeyCommand(const aView: InevControlView;
   aCmd: Word;
   const aPara: InevPara): Boolean;
   {* Обработчик комманд от редактора. }
  procedure RememberState;
   {* Запоминание состояния для всплывающего меню. }
  procedure TextChange(const aView: InevView;
   const aPara: InevPara;
   const anOp: InevOp);
   {* Событие изменения текста в параграфе (внешний вызов). }
  function GetHint(var aValue: Il3CString): Boolean;
   {* Вывод хинта на экран. Если данных нет, то возвращается False. }
  procedure InsertRow(const aView: InevView);
   {* Событие добавления строки к таблице по 'Enter'. }
  procedure SetFocus(aChangePara: Boolean = False);
   {* Передать фокус контролу (выделить с помощью фокусной рамки. }
  property Enabled: Boolean
   read Get_Enabled
   write Set_Enabled;
   {* Доступность контрола. }
  property MaxLength: Integer
   read Get_MaxLength;
  property Caption: Il3CString
   read Get_Caption;
  property Field: IevEditorControlField
   read Get_Field
   write Set_Field;
   {* Поле, которому принадлежит контрол. }
  property Req: IevReq
   read Get_Req;
   {* Реквизит, которому принадлежит контрол. }
 end;//IevEditorControl

 IevModelListener = interface(InevBase)
  ['{0F3D9F13-3BA0-42EC-99A7-6D3FDA705548}']
  procedure EnterPressed;
   {* Обработчик нажатия на "Enter". }
  function GetHint(const aValue: IevEditorControl): Il3CString;
   {* Возвращает хинт для поля. }
  function GetImage(Index: Integer;
   var aImages: InevImageList): Integer;
   {* Возвращает номер картинки и массив картинок для отображения. }
  function AnalyzeString(const aValue: Il3CString;
   out aRslt: Il3CString): Boolean;
   {* Анализ добавленной строки, если нужно, то убирает лишние символы или разбивает строку на несколько. }
  function CheckValue(const aField: IevEditorControlField): Boolean;
   {* Проверка значения поля. }
  procedure TextChange;
   {* Обработчик изменения текста в поле. }
  procedure AfterSetText(const aField: IevEditorControlField);
   {* Обработчик присвоения полю нового значения - срабатывает после выбора
          значения в дереве. }
  function IsEditEmpty: Boolean;
   {* Проверяет поле на пустое значение. }
  procedure HyperLinkClick;
   {* Обработка щелчка по ссылки. }
 end;//IevModelListener

 IevEditorControlButton = interface;

 IevEditorControlList = interface;

 IevEditorControlField = interface(IevEditorControl)
  {* Интерфейс поля редактора. }
  ['{C2A60427-E1AA-472A-AC70-0516173258C0}']
  function Get_Text: Il3CString;
  procedure Set_Text(const aValue: Il3CString);
  function Get_ErrorColor: Boolean;
  procedure Set_ErrorColor(aValue: Boolean);
  function Get_Valid: Boolean;
  procedure Set_Valid(aValue: Boolean);
  function Get_ChildList: IevEditorControlList;
  procedure SynchronizeSelectedValueWithText;
  function HasOtherField: Boolean;
  procedure CheckDataText;
   {* Проверяет введенный текст на корректность. }
  function AnalyzeString(const aValue: Il3CString;
   aPos: Integer;
   out aRslt: Il3CString): Boolean;
   {* Анализ добавленной строки, если нужно, то убирает лишние символы или разбивает строку на несколько. }
  function IsClear: Boolean;
   {* Функция возвращает призна того, что поле пустое (вынесено специально 
          для обновления кнопок!). Для реквизитов дат проверяет оба поля дат! }
  procedure InitOtherField(const aValue: IevEditorControl;
   aIsStart: Boolean = True);
   {* Для реквизитов с двумя полями. Используется для полей дат. }
  function IsFieldEmpty: Boolean;
   {* Проверяет является ли поле пустым (или содержит значение по умолчанию). }
  function FindButton(aButtonType: TevButtonType): IevEditorControlButton;
   {* Возвращает кнопку для поля. }
  procedure ClearText;
   {* Очищает поле редактора. }
  function SelectAllOnFocus: Boolean;
   {* Надо ли выделять поле при фокусировании. }
  property Text: Il3CString
   read Get_Text
   write Set_Text;
   {* Текст поля редактора. }
  property ErrorColor: Boolean
   read Get_ErrorColor
   write Set_ErrorColor;
   {* Установлен ли цвет ошибочного текста. }
  property Valid: Boolean
   read Get_Valid
   write Set_Valid;
   {* Проверяет на корректность. }
  property ChildList: IevEditorControlList
   read Get_ChildList;
 end;//IevEditorControlField

 IevEditorFieldWithTree = interface(IevEditorControlField)
  ['{3984A532-F741-4C46-A304-0034BC2FE756}']
  function Get_Value: InevSimpleNode;
  function Get_IsAsterisk: Boolean;
  function Get_DefaultNode: InevSimpleNode;
  function Get_Asterisk: AnsiChar;
  procedure Set_Asterisk(aValue: AnsiChar);
  function Get_IsList: Boolean;
  function Get_SourceTree: InevSimpleTree;
  function Get_ComboStyle: TevComboStyle;
  procedure Set_ComboStyle(aValue: TevComboStyle);
  function Get_LogicalState: Integer;
  procedure Set_LogicalState(aValue: Integer);
  function Get_Down: Boolean;
  procedure Set_Down(aValue: Boolean);
  function Get_IsLogicalStateButtonEnabled: Boolean;
  procedure SetNodeByIndex(aIndex: Integer);
  function GetNodeIndex(const aNode: InevSimpleNode): Integer;
   {* Возвращает номер узла. }
  procedure ShowNode(const aNode: InevSimpleNode);
   {* Отображает узел в поле. }
  procedure CheckTextVersusValue;
   {* Заточка на тот случай когда после Undo текст в контроле не совпадает
        с выбранной нодой - в этом случае очищаем все. }
  function NeedClearOnEscape: Boolean;
  procedure SetMaskText(const aText: Il3CString);
  property Value: InevSimpleNode
   read Get_Value;
   {* Выбранный узел в дереве. }
  property IsAsterisk: Boolean
   read Get_IsAsterisk;
   {* Присутствует ли в тексте символ '*'. }
  property DefaultNode: InevSimpleNode
   read Get_DefaultNode;
   {* Узел с значением по умолчанию. }
  property Asterisk: AnsiChar
   read Get_Asterisk
   write Set_Asterisk;
   {* Символ звездочки. }
  property IsList: Boolean
   read Get_IsList;
   {* Если выставлено в True, то показывается список, а не дерево. }
  property SourceTree: InevSimpleTree
   read Get_SourceTree;
   {* Дерево с данными.
У Димы - Get_Tree. }
  property ComboStyle: TevComboStyle
   read Get_ComboStyle
   write Set_ComboStyle;
   {* Стиль поведения выпадающего списка. }
  property LogicalState: Integer
   read Get_LogicalState
   write Set_LogicalState;
   {* Выставленное логическое значение для поля. }
  property Down: Boolean
   read Get_Down
   write Set_Down;
   {* Нажата ли кнопка в редакторе.
У Димы - Get_Checked/Set_Checked. }
  property IsLogicalStateButtonEnabled: Boolean
   read Get_IsLogicalStateButtonEnabled;
 end;//IevEditorFieldWithTree

 IevQueryGroup = interface;

 IevQueryCard = interface;

 IevReq = interface(IevCustomParaTool)
  ['{520F1943-DE74-4D3E-9AFB-26989C571B12}']
  function Get_ReqName: Il3CString;
  function Get_ReqCaption: Il3CString;
  function Get_ModelListener: IevModelListener;
  function Get_Fields(Index: Integer): IevEditorControlField;
  function Get_Group: IevQueryGroup;
  function Get_QueryCard: IevQueryCard;
  procedure KeyAction(aCmd: Word);
   {* "Внешняя" обработка команды. }
  function AnalyzeString(const aValue: Il3CString;
   out aRslt: Il3CString): Boolean;
  procedure TextChange(const aView: InevView);
   {* Обработчик события изменения текста. }
  procedure RememberState(const aControl: IevCustomEditorControl);
   {* Запомнить состояние контрола для всплывающего меню. }
  function GetNextVisible(const aControl: IevEditorControl;
   OnlyFields: Boolean;
   out anIsLastField: Boolean): IevEditorControl;
   {* Возвращает следующий видимый контрол. }
  function GetFirstVisible(OnlyFields: Boolean): IevEditorControl;
   {* Возвращает первый видимый контрол для реквизита. }
  function GetPrevVisible(const aControl: IevEditorControl;
   OnlyFields: Boolean;
   out anIsFirstField: Boolean): IevEditorControl;
   {* Возвращает следующий видимый контрол. }
  function GetLastVisible(OnlyFields: Boolean): IevEditorControl;
   {* Возвращает последний видимый контрол. }
  function GetHint(var aValue: Il3CString;
   const aControl: IevEditorControl): Boolean;
   {* Получить хинт для контрола. }
  function IsRequired: Boolean;
   {* Обязательное поле (должно обязательно содержать значение). }
  function IsEmpty: Boolean;
   {* Проверяет, является ли реквизит пустым. }
  function FieldsCount: Integer;
   {* Количество контролов (полей редактора) в реквизите. }
  procedure ButtonPressed(const aView: InevView;
   const aControl: IevEditorControl;
   aBtnType: TevButtonType);
   {* Обработка реакции на нажатие кнопки по её типу. }
  procedure AfterSetText(const aField: IevEditorControlField);
  function AddField(const aView: InevView;
   NeedSetFocus: Boolean = False): IevEditorControlField;
   {* Добавление реквизита. }
  function GetItemImage(Index: Integer;
   var aImages: InevImageList): Integer;
   {* Ручка для получения картинки для выпадающего дерева. }
  procedure DeleteField(const aView: InevView;
   const aControl: IevEditorControlField = nil;
   NeedFocus: Boolean = False);
   {* Удаление реквизита. }
  procedure InsertToModel(const aView: InevView;
   const aControl: IevEditorControl;
   aChild: Tl3Variant;
   NeedFocus: Boolean = False;
   anAdd: Boolean = False);
   {* Добавление реквизита только в модель. }
  procedure DeleteFromModel(const aView: InevView;
   const aControl: IevEditorControl;
   NeedFocus: Boolean = False);
   {* Удаление реквизита только из модели. }
  procedure InitModel(const aTag: InevPara;
   AddValues: Boolean;
   anIndexField: Integer;
   anIndexCtrl: Integer);
   {* Инициализация дочерних компонентов. }
  function CheckEdit(const aField: IevEditorControlField): Boolean;
   {* Проверка значения поля. }
  procedure UpdateState(const aField: IevEditorControlField;
   const anOp: InevOp);
   {* Обновить состояния поля и кнопок, вокруг контрола. }
  procedure SetFocus(const aField: IevEditorControlField;
   aAtEnd: Boolean = False);
   {* Установить фокус. }
  function FirstField: IevEditorControlField;
   {* Возвращает первый контрол в списке. }
  function LastField: IevEditorControlField;
   {* Возвращает последний контрол в списке. }
  property ReqName: Il3CString
   read Get_ReqName;
   {* Имя реквизита. }
  property ReqCaption: Il3CString
   read Get_ReqCaption;
   {* Название реквизита (пишется в метке). У Димы - Get_TagCaption. }
  property ModelListener: IevModelListener
   read Get_ModelListener;
   {* Объект с бизнес-слоя. }
  property Fields[Index: Integer]: IevEditorControlField
   read Get_Fields;
   {* Cписок контролов, принадлежащих реквизиту. }
  property Group: IevQueryGroup
   read Get_Group;
   {* Возвращает группу, к которой принадленит реквизит. }
  property QueryCard: IevQueryCard
   read Get_QueryCard;
 end;//IevReq

 IevQueryGroup = interface(IevCustomEditorControl)
  ['{ABDD1ABC-B02D-4FB5-B6B4-1D186DDFB6E6}']
  function Get_ReqCount: Integer;
  function Get_DescriptionReqCount: Integer;
  function Get_GroupName: Il3CString;
  function Get_Expanded: Boolean;
  procedure Set_Expanded(aValue: Boolean);
  function Get_Req(Index: Integer): IevReq;
  function Get_DescriptionReq(Index: Integer): IevDescriptionReq;
  function Get_QueryCard: IevQueryCard;
  procedure ClickOnDisabledLabel;
  procedure AfterCollapsed;
   {* Обработчик события сворачивания группы. }
  function CanCollapsed: Boolean;
   {* Проверка может ли группа свернуться. }
  function LMouseBtnDown(const aView: InevControlView;
   const aTextPara: InevPara;
   const aPt: TnevPoint;
   const Keys: TevMouseState;
   const aMap: InevMap): Boolean;
   {* Обработка нажания на левую кнопку мыши. }
  function LMouseBtnUp(const aView: InevControlView;
   const aTextPara: InevPara;
   const aPt: TnevPoint;
   const Keys: TevMouseState): Boolean;
  function FindDescriptionReq(const aReqName: Tl3WString): IevDescriptionReq;
   {* Возвращает реквизит по имени. }
  procedure InitModel(const aTag: InevPara);
   {* Инициализация модели. }
  function LastReq: IevReq;
   {* Последний реквизт в группе. }
  function FirstReq: IevReq;
   {* Первый реквизит в группе. }
  function GetNextReq(const aReq: IevReq): IevReq;
   {* Возвращает следующий реквизит. }
  function GetPrevReq(const aReq: IevReq): IevReq;
   {* Возвращает предыдущий реквизит. }
  property ReqCount: Integer
   read Get_ReqCount;
   {* Количество реквизитов в группе. }
  property DescriptionReqCount: Integer
   read Get_DescriptionReqCount;
   {* Количество реквизитов в группе. }
  property GroupName: Il3CString
   read Get_GroupName;
   {* Возвращает имя группы (k2_tiShortName). }
  property Expanded: Boolean
   read Get_Expanded
   write Set_Expanded;
   {* Возвращает True, если панель развернута, т.е. видны все реквизиты. }
  property Req[Index: Integer]: IevReq
   read Get_Req;
   {* Список реквизитов, принадлежащих группе. }
  property DescriptionReq[Index: Integer]: IevDescriptionReq
   read Get_DescriptionReq;
   {* Список реквизитов, принадлежащих группе. }
  property QueryCard: IevQueryCard
   read Get_QueryCard;
 end;//IevQueryGroup

 IevQueryCard = interface(InevBase)
  ['{50D656F4-8A1C-464A-85D7-CCB4415849B6}']
  function Get_GroupCount: Integer;
  function Get_InsertRowMode: Boolean;
  procedure Set_InsertRowMode(aValue: Boolean);
  function pm_GetCardType: TevQueryType;
  function Get_QueryGroup(anIndex: Integer): IevQueryGroup;
  function pm_GetEditor: InevControl;
  procedure ChangePara(const aCurPara: InevPara);
   {* Событие смена текуего параграфа. }
  procedure SetCurrPara(const aCurPara: InevPara);
  function GetDocumentContainer: InevQueryDocumentContainer;
   {* Получить контейнер документа. }
  procedure RememberFocusControl(const aValue: IevEditorControl);
   {* Запомнить контрол для установки фокуса. }
  procedure BeforeDelete;
   {* Вызывается перед удалением поля. }
  procedure ClearUpper;
   {* Сбрасывает признак Upper у поля. }
  procedure UpperChange(const aButton: IevCustomEditorControl);
   {* Вызывается после установки Upper у кнопки в True. }
  function GetNode(anIndex: Integer): InevSimpleNode;
   {* Возвращает узел по номеру. }
  procedure CardClear;
   {* Обработчик очистки КЗ. }
  procedure StartLongOperation;
   {* Скобки для блокировки перерисовок в редакторе. }
  procedure EndLongOperation;
   {* Скобки для блокировки перерисовок в редакторе. }
  procedure ChangeStateAll(anExpand: Boolean);
   {* Выставляет признак развернутости/свернутости всем группам. }
  procedure AfterCollapsed(const aGroup: IevQueryGroup);
  procedure LimitCharsReached(const aControl: IevEditorControl);
   {* Обработчик достижения максимального числа символов в параграфе. }
  procedure RememberState(const aControl: IevCustomEditorControl);
   {* Запомнить состояние для контекстного меню. }
  function GetStateControl: IevCustomEditorControl;
   {* Возвращает контрол, который был активным при вызове контекстного меню. }
  function GetFocusedControl(aCurPara: Tl3Variant): IevEditorControl;
   {* Возвращает контрол, имеющий фокус ввода. }
  procedure LinkView(const aQueryContainer: InevQueryDocumentContainer);
   {* Инициализации модели. }
  procedure LinkListener(const aListener: IevAdapterModel);
   {* Подключить объект из внешней модели. }
  function AdapterModel: IevAdapterModel;
  procedure ReleaseListeners;
   {* Отключить объект из внешней модели. }
  function FindDescriptionReq(const aReqName: Tl3WString): IevDescriptionReq;
   {* Получение реквизита по имени. }
  procedure StartSetFocus;
   {* Возвращает первое доступное для редактирования поле в контроле. }
  function GetControlIterator(const aCurrentControl: IevCustomEditorControl): IevControlIterator;
  property GroupCount: Integer
   read Get_GroupCount;
   {* Количество групп в карточке. }
  property InsertRowMode: Boolean
   read Get_InsertRowMode
   write Set_InsertRowMode;
   {* Режим добавления полей. }
  property CardType: TevQueryType
   read pm_GetCardType;
   {* Получить тип загруженной карточки. }
  property QueryGroup[anIndex: Integer]: IevQueryGroup
   read Get_QueryGroup;
   {* Список групп, входящих в КЗ.
У Димы Get_Group. }
  property Editor: InevControl
   read pm_GetEditor;
   {* Ссылка на редактор. }
 end;//IevQueryCard

 IevDatesReq = interface(InevBase)
  ['{B2384BD5-8B98-4A3C-89E8-D1AFB090BBC8}']
  function Get_StartDate: TDateTime;
  procedure Set_StartDate(aValue: TDateTime);
  function Get_EndDate: TDateTime;
  procedure Set_EndDate(aValue: TDateTime);
  property StartDate: TDateTime
   read Get_StartDate
   write Set_StartDate;
   {* Начальная дата интервала. }
  property EndDate: TDateTime
   read Get_EndDate
   write Set_EndDate;
   {* Конечная дата интервала. }
 end;//IevDatesReq

 IevPhoneReq = interface(InevBase)
  ['{B58BF42E-F74B-4F4E-82DC-61A690BC20A1}']
  function Get_Code: Il3CString;
  procedure Set_Code(const aValue: Il3CString);
  function Get_Number: Il3CString;
  procedure Set_Number(const aValue: Il3CString);
  property Code: Il3CString
   read Get_Code
   write Set_Code;
  property Number: Il3CString
   read Get_Number
   write Set_Number;
 end;//IevPhoneReq

 IevEditorControlButton = interface(IevEditorControl)
  {* Интерфейс кнопки. }
  ['{38B36936-ECA7-48CC-92F3-7183292CE360}']
  function GetButtonType: TevButtonType;
 end;//IevEditorControlButton

 //_ItemType_ = IevEditorControl;
 IevEditorControlList = interface(InevBase)
  ['{C5160916-203D-4BF8-AC66-0820F74478C3}']
  function pm_GetEmpty: Boolean;
  function pm_GetFirst: IevEditorControl;
  function pm_GetLast: IevEditorControl;
  function pm_GetItems(anIndex: Integer): IevEditorControl;
  function pm_GetCount: Integer;
  procedure AssignList(const aList: IevEditorControlList);
  property Empty: Boolean
   read pm_GetEmpty;
  property First: IevEditorControl
   read pm_GetFirst;
   {* Первый элемент. }
  property Last: IevEditorControl
   read pm_GetLast;
   {* Последний элемент. }
  property Items[anIndex: Integer]: IevEditorControl
   read pm_GetItems;
   default;
  property Count: Integer
   read pm_GetCount;
   {* Число элементов. }
 end;//IevEditorControlList

 IevComboReq = interface(InevBase)
  ['{40A89677-FACE-4DF8-83EE-4DE875DD7922}']
  function Get_DefStateIndex: Integer;
  procedure Set_DefStateIndex(aValue: Integer);
  function Get_HistoryList: Il3StringsEx;
  procedure ClearLogicValue;
  procedure EscPressed(const aField: IevEditorFieldWithTree);
  function NeedAsterisk: Boolean;
   {* Нужно ли проверять значение '*' в тексте. }
  function GetTreeFromAdapter: InevSimpleTree;
   {* Получает дерево с адаптера. }
  function IsMulti: Boolean;
   {* Признак реквизита с несколькими значениями. }
  procedure HyperLinkClick;
   {* Щелчок по гиперссылке. }
  function IsContext: Boolean;
   {* Признак того, что реквизит является конекстом. }
  function GetNode(anIndex: Integer): InevSimpleNode;
   {* Получить узел выпадающего дерева по номеру поля. }
  function GetPromptTreeFromAdapter: InevSimpleTree;
  procedure NotifyContextWrong;
  property DefStateIndex: Integer
   read Get_DefStateIndex
   write Set_DefStateIndex;
   {* Состояние логической кноки по умолчанию. }
  property HistoryList: Il3StringsEx
   read Get_HistoryList;
   {* Список истории ввода. }
 end;//IevComboReq

 IevEditorStateButton = interface(IevEditorControlButton)
  {* Интерфейс кнопки с изменяемым состоянием. }
  ['{2DDC445D-9825-4749-925A-86FE9131AA78}']
  function Get_StateCount: Integer;
  function Get_CurrentIndex: Integer;
  procedure Set_CurrentIndex(aValue: Integer);
  function Get_ImageIndex: Integer;
  function GetStateIndex: Integer;
   {* Собственно возвращает состояние кнопки от 0 до максимального. }
  property StateCount: Integer
   read Get_StateCount;
   {* Количество состояний. }
  property CurrentIndex: Integer
   read Get_CurrentIndex
   write Set_CurrentIndex;
   {* Текущая картинка для отображения. }
  property ImageIndex: Integer
   read Get_ImageIndex;
   {* Начальный номер картинки. }
 end;//IevEditorStateButton

 IevEditorCalendarField = interface(IevEditorControlField)
  ['{BE859AF1-0BCC-449E-A7F5-17E627BF40A2}']
  function Get_aDate: TDateTime;
  procedure Set_aDate(aValue: TDateTime);
  procedure AnalyzeText;
   {* Расширение даты, если введены только день и месяц. }
  function IsBlank: Boolean;
   {* Поле пустое, т.е. равно шаблону. }
  procedure ClearField;
   {* Очищает только самое поле. ClearText - очищает оба поля сразу. }
  function IsStart: Boolean;
   {* Контрол хранит начальную дату интервала. }
  function GetOtherField: IevEditorCalendarField;
   {* Другой контрол. }
  property aDate: TDateTime
   read Get_aDate
   write Set_aDate;
   {* Дата из контрола.
У Димы - Get_Date/Set_Date. }
 end;//IevEditorCalendarField

 IevEditorPhoneField = interface(IevEditorControlField)
  ['{1770F128-709C-486F-828C-483459F37509}']
  function IsStart: Boolean;
   {* Контрол хранит начальную дату интервала. }
  function GetOtherField: IevEditorPhoneField;
   {* Другой контрол. }
 end;//IevEditorPhoneField

 IevControlFriend = interface(IevCommonControl)
  ['{41C31E9B-8789-491D-8E39-2DD94AE71855}']
  function GetControl: IevEditorControl;
   {* Получить контрол по ссылке. }
 end;//IevControlFriend

 IevEditorControlLabel = interface(IevEditorControl)
  {* Интерфейс Label (в том числе и гиперссылки). }
  ['{7557EE92-FA6A-43FB-8615-F5CFF35A0CAD}']
  function Get_Caption: Il3CString;
  procedure Set_Caption(const aValue: Il3CString);
  procedure RestoreCaption;
   {* Восстанавливает название метки. }
  property Caption: Il3CString
   read Get_Caption
   write Set_Caption;
   {* Текст метки.
У Димы - Get_Text/Set_Text. }
 end;//IevEditorControlLabel

 IevQueryCardEditor = interface(InevBase)
  ['{A119A4B9-2DEB-4649-B89A-1957F9EDB06D}']
  procedure SetCursorToPara(const aPara: InevPara;
   bAtEnd: Boolean;
   aNeedClear: Boolean);
   {* Установить курсор в позицию параграфа }
  procedure NotifyEmptySpace;
   {* Нотификация о попадании в пустое место в редакторе }
  function GetCurrPara: Tl3Variant;
  procedure ClearCardCache;
  function DroppingData: Boolean;
  procedure SignalDisableUnselectAfterDrop;
 end;//IevQueryCardEditor

 IqaReqPrim = interface(InevBase)
  ['{5A2A14D2-4E7B-4D71-A1C1-473F9AC99CA2}']
  function Get_Modified: Boolean;
  procedure Set_Modified(aValue: Boolean);
  property Modified: Boolean
   read Get_Modified
   write Set_Modified;
   {* Атрибут модифицирования пользователем со времени последнего сохранения }
 end;//IqaReqPrim

 IevReqIterator_DoReq_Action = function(const anItem: IevReq): Boolean;
  {* Тип подитеративной функции для IevReqIterator.DoReq }

 IevReqIterator = interface(InevBase)
  ['{EF763092-54E8-4271-8146-192454C64DFC}']
  function DoReq(anAction: IevReqIterator_DoReq_Action): Integer;
  function DoReqF(anAction: IevReqIterator_DoReq_Action): Integer;
 end;//IevReqIterator

function L2IevReqIteratorDoReqAction(anAction: pointer): IevReqIterator_DoReq_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для IevReqIterator.DoReq }

implementation

uses
 l3ImplUses
 , l3Base
;

function L2IevReqIteratorDoReqAction(anAction: pointer): IevReqIterator_DoReq_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для IevReqIterator.DoReq }
asm
 jmp l3LocalStub
end;//L2IevReqIteratorDoReqAction

end.
