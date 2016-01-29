unit evControlContainer;

interface

uses
 l3IntfUses
 , evCustomControlTool
 , nevTools
 , evQueryCardInt
 , evQueryGroupList
 , nevBase
 , l3Variant
 , Messages
 , l3Interfaces
 , l3CProtoObject
;

type
 TevControlContainer = class(TevCustomControlTool, InevControlListener, IevQueryCard)
  function Make: IevQueryCard;
  procedure DoHideDroppedControl(CanSetFocus: Boolean);
  function DoMouseWheel(aDown: Boolean): Boolean;
  procedure Create;
  function GetFirstVisible(const aGroup: IevQueryGroup;
   anOnlyFields: Boolean;
   anExpanedeOnly: Boolean): IevCustomEditorControl;
  function GetLastVisible(const aGroup: IevQueryGroup;
   anOnlyFields: Boolean;
   anExpanedeOnly: Boolean): IevCustomEditorControl;
  function GetFirstControl(const aReq: IevReq;
   anOnlyFields: Boolean): IevCustomEditorControl;
  function GetLastControl(const aReq: IevReq;
   anOnlyFields: Boolean): IevCustomEditorControl;
  function GetNextReq(const aReq: IevReq;
   anExpandedOnly: Boolean;
   out aFirstReq: Boolean): IevReq;
   {* Возвращает следующий реквизит или nil, если такого нет. }
  function GetPrevReq(const aReq: IevReq;
   anExpandedOnly: Boolean;
   out aLastReq: Boolean): IevReq;
   {* Возвращает предыдущий реквизит. }
  function DoGetNode(anIndex: Integer): InevSimpleNode;
  procedure DoDeleteOnUndo(aTag: Tl3Tag);
  procedure DoChangePara(const aCurPara: InevPara);
  function DoKeyDown(const aView: InevView;
   var Msg: TWMKeyDown;
   aCurPara: Tl3Tag): Boolean;
   {* Посылка сообщений о нажатии клавиш. }
  function CanInsertPara: Boolean;
   {* Разрешено ли вставлять параграф. }
  procedure InsertOnUndo(aPrev: Tl3Variant;
   aChild: Tl3Variant;
   anAdd: Boolean);
   {* Реакция на вставку при откатке. }
  procedure DeleteOnUndo(aTag: Tl3Variant);
   {* Реакция удаления при откатке. }
  procedure HideDroppedControl(CanSetFocus: Boolean);
   {* Обработчик изменения события состояния редактора (нужно для выпадающего контрола). }
  function MouseWheel(aDown: Boolean): Boolean;
   {* Событие прокрутки мыши. }
  function KeyDown(const aView: InevView;
   var Msg: TWMKeyDown;
   aCurPara: Tl3Variant): Boolean;
   {* Посылка сообщений о нажатии клавиш. }
  procedure ChangePara(const aCurPara: InevPara);
   {* Событие смена текуего параграфа. }
  procedure BeforeRMouseClick;
   {* Событие, вызываемое перед обработкой мыши. }
  procedure ClearUpper;
  function NeedKey(aPara: Tl3Variant;
   var aKeyCode: Word): Boolean;
   {* Контрол/Поле перехватывает курсор. }
  procedure CursorCreate;
   {* Обновить курсор после создания. }
  procedure UpdateState;
  function IsLastField(aPara: Tl3Variant): Boolean;
   {* Проверяет является ли параграф последним для передачи фокуса. }
  function IsFirstField(aPara: Tl3Variant): Boolean;
   {* Проверяет является ли параграф первым для передачи фокуса. }
  procedure StartPaste;
   {* Скобки для операции вставки. }
  procedure FinishPaste;
   {* Скобки для операции вставки. }
  function IsPasting: Boolean;
   {* Внутри скобок для операции вставки. }
  function GetFirstPara(OnlyFields: Boolean): InevPara;
   {* Получить первый параграф, в который может получить фокус. }
  function GetLastPara(OnlyFields: Boolean): InevPara;
   {* Получить последний параграф, в который может получить фокус. }
  procedure SetCurrPara(const aCurPara: InevPara);
  function GetDocumentContainer: InevQueryDocumentContainer;
   {* Получить контейнер документа. }
  procedure RememberFocusControl(const aValue: IevEditorControl);
   {* Запомнить контрол для установки фокуса. }
  procedure BeforeDelete;
   {* Вызывается перед удалением поля. }
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
  function QueryGroup: IevQueryGroup;
   {* Список групп, входящих в КЗ.
У Димы Get_Group. }
  function GroupCount: Integer;
   {* Количество групп в карточке. }
  function Editor: InevControl;
   {* Ссылка на редактор. }
  function InsertRowMode: Boolean;
   {* Режим добавления полей. }
  function CardType: TevQueryType;
   {* Получить тип загруженной карточки. }
  function GetControlIterator(const aCurrentControl: IevCustomEditorControl): IevControlIterator;
 end;//TevControlContainer
 
implementation

uses
 l3ImplUses
 , k2Tags
 , evControlParaTools
 , evControlParaConst
 , SysUtils
 , evdTypes
 , l3Base
 , Windows
 , evQueryCardConst
 , nevFacade
 , ControlPara_Const
 , ControlsBlock_Const
 , evControlGroup
;

type
 TevControlIterator = class(Tl3CProtoObject, IevControlIterator)
  procedure Make(const aControl: IevCustomEditorControl;
   aQueryCard: TevControlContainer);
  procedure Create(const aControl: IevCustomEditorControl;
   aQueryCard: TevControlContainer);
  function GetNextVisible(OnlyFields: Boolean): IevCustomEditorControl;
   {* Возвращает следующий видимый контрол или nil, если такого нет. }
  function GetPrevVisible(OnlyFields: Boolean): IevCustomEditorControl;
   {* Возвращает предыдущий видимый контрол или nil, если такого нет. }
 end;//TevControlIterator
 
end.
