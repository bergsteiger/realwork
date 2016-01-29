unit evQueryCardInt;

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
 
 IevCustomParaTool = interface
 end;//IevCustomParaTool
 
 IevDescriptionReq = interface(IevCustomParaTool)
 end;//IevDescriptionReq
 
 IevControlIterator = interface;
 
 IevCustomEditorControl = interface(IevCustomParaTool)
  {* Базовый интерфес для всех контролов (блоков и конкретных кнопок). Для использования внутри прослойки. }
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
 end;//IevCustomEditorControl
 
 IevControlIterator = interface
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
 
 IevAdapterModel = interface
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
 end;//IevAdapterModel
 
 IevEditorControlField = interface;
 
 IevEditorControl = interface(IevCustomEditorControl)
  {* От интерфейса InevInputListener }
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
  procedure SetFocus(aChangePara: Boolean);
   {* Передать фокус контролу (выделить с помощью фокусной рамки. }
 end;//IevEditorControl
 
 IevModelListener = interface
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
   aIsStart: Boolean);
   {* Для реквизитов с двумя полями. Используется для полей дат. }
  function IsFieldEmpty: Boolean;
   {* Проверяет является ли поле пустым (или содержит значение по умолчанию). }
  function FindButton(aButtonType: TevButtonType): IevEditorControlButton;
   {* Возвращает кнопку для поля. }
  procedure ClearText;
   {* Очищает поле редактора. }
  function SelectAllOnFocus: Boolean;
   {* Надо ли выделять поле при фокусировании. }
 end;//IevEditorControlField
 
 IevEditorFieldWithTree = interface(IevEditorControlField)
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
 end;//IevEditorFieldWithTree
 
 IevQueryGroup = interface;
 
 IevQueryCard = interface;
 
 IevReq = interface(IevCustomParaTool)
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
   NeedSetFocus: Boolean): IevEditorControlField;
   {* Добавление реквизита. }
  function GetItemImage(Index: Integer;
   var aImages: InevImageList): Integer;
   {* Ручка для получения картинки для выпадающего дерева. }
  procedure DeleteField(const aView: InevView;
   const aControl: IevEditorControlField;
   NeedFocus: Boolean);
   {* Удаление реквизита. }
  procedure InsertToModel(const aView: InevView;
   const aControl: IevEditorControl;
   aChild: Tl3Variant;
   NeedFocus: Boolean;
   anAdd: Boolean);
   {* Добавление реквизита только в модель. }
  procedure DeleteFromModel(const aView: InevView;
   const aControl: IevEditorControl;
   NeedFocus: Boolean);
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
   aAtEnd: Boolean);
   {* Установить фокус. }
  function FirstField: IevEditorControlField;
   {* Возвращает первый контрол в списке. }
  function LastField: IevEditorControlField;
   {* Возвращает последний контрол в списке. }
 end;//IevReq
 
 IevQueryGroup = interface(IevCustomEditorControl)
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
 end;//IevQueryGroup
 
 IevQueryCard = interface
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
 end;//IevQueryCard
 
 IevDatesReq = interface
 end;//IevDatesReq
 
 IevPhoneReq = interface
 end;//IevPhoneReq
 
 IevEditorControlButton = interface(IevEditorControl)
  {* Интерфейс кнопки. }
  function GetButtonType: TevButtonType;
 end;//IevEditorControlButton
 
 IevEditorControlList = interface
  procedure AssignList(const aList: IevEditorControlList);
 end;//IevEditorControlList
 
 IevComboReq = interface
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
 end;//IevComboReq
 
 IevEditorStateButton = interface(IevEditorControlButton)
  {* Интерфейс кнопки с изменяемым состоянием. }
  function GetStateIndex: Integer;
   {* Собственно возвращает состояние кнопки от 0 до максимального. }
 end;//IevEditorStateButton
 
 IevEditorCalendarField = interface(IevEditorControlField)
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
 end;//IevEditorCalendarField
 
 IevEditorPhoneField = interface(IevEditorControlField)
  function IsStart: Boolean;
   {* Контрол хранит начальную дату интервала. }
  function GetOtherField: IevEditorPhoneField;
   {* Другой контрол. }
 end;//IevEditorPhoneField
 
 IevControlFriend = interface(IevCommonControl)
  function GetControl: IevEditorControl;
   {* Получить контрол по ссылке. }
 end;//IevControlFriend
 
 IevEditorControlLabel = interface(IevEditorControl)
  {* Интерфейс Label (в том числе и гиперссылки). }
  procedure RestoreCaption;
   {* Восстанавливает название метки. }
 end;//IevEditorControlLabel
 
 IevQueryCardEditor = interface
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
 
 IqaReqPrim = interface
 end;//IqaReqPrim
 
 IevReqIterator_DoReq_Action = function(const anItem: IevReq): Boolean;
  {* Тип подитеративной функции для IevReqIterator.DoReq }
 
 IevReqIterator = interface
  procedure DoReq;
 end;//IevReqIterator
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
