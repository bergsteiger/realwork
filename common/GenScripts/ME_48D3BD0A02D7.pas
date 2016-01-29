unit evReq;

interface

uses
 l3IntfUses
 , evCustomControlTool
 , evQueryCardInt
 , evEditorControlFieldList
 , evEditorControlList
 , l3Base
 , l3Variant
 , nevTools
 , evdTypes
 , l3Interfaces
 , nevBase
 , evControl
;

type
 RevControlClass = class of TevControl;
 
 TevReq = class(TevCustomControlTool, IevReq, IevComboReq, IevDatesReq, IevPhoneReq)
  {* Класс реквизита (одельная строка в таблице) }
  function Make(const aValue: InevPara): IevReq;
  function AddValue(const aView: InevView;
   const aControl: IevEditorControl;
   const aPara: InevPara;
   ToModel: Boolean;
   anAdd: Boolean): Boolean;
   {* Добавление нового поля в реквизит. aControl - виджет (поле или любой
         виджет возле поля), ToModel: только добавляем в модель aPara }
  function DeleteValue(const aView: InevView;
   const aControl: IevEditorControl;
   ToModel: Boolean): Integer;
   {* Удаление поля из реквизита. Возвращает индекс поля вставшего вместо удаленного }
  function GetControlClass(aControlType: TevControlType): RevControlClass;
  function CanVisibleLogicBtn: Boolean;
  function LogicBtnEnabled: Boolean;
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
  function ModelListener: IevModelListener;
   {* Объект с бизнес-слоя. }
  function Fields: IevEditorControlField;
   {* Cписок контролов, принадлежащих реквизиту. }
  function ReqName: Il3CString;
   {* Имя реквизита. }
  function ReqCaption: Il3CString;
   {* Название реквизита (пишется в метке). У Димы - Get_TagCaption. }
  procedure SetFocus(const aField: IevEditorControlField;
   aAtEnd: Boolean);
   {* Установить фокус. }
  function FirstField: IevEditorControlField;
   {* Возвращает первый контрол в списке. }
  function LastField: IevEditorControlField;
   {* Возвращает последний контрол в списке. }
  function Group: IevQueryGroup;
   {* Возвращает группу, к которой принадленит реквизит. }
  function QueryCard: IevQueryCard;
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
  function DefStateIndex: Integer;
   {* Состояние логической кноки по умолчанию. }
  function IsContext: Boolean;
   {* Признак того, что реквизит является конекстом. }
  function GetNode(anIndex: Integer): InevSimpleNode;
   {* Получить узел выпадающего дерева по номеру поля. }
  function HistoryList: Il3StringsEx;
   {* Список истории ввода. }
  function StartDate: TDateTime;
   {* Начальная дата интервала. }
  function EndDate: TDateTime;
   {* Конечная дата интервала. }
  function Code: Il3CString;
  function Number: Il3CString;
  function GetPromptTreeFromAdapter: InevSimpleTree;
  procedure NotifyContextWrong;
 end;//TevReq
 
implementation

uses
 l3ImplUses
 , OvcConst
 , evControlParaConst
 , l3String
 , k2Tags
 , evButtonControl
 , evDropCalendarControl
 , evDropCombo
 , evLabel
 , evSimpleEdit
 , evMemoEdit
 , evEmailEdit
 , evPhoneEdit
 , SysUtils
 , nevFacade
 , evControlParaTools
 , evParaTools
 , l3InterfacesMisc
 , l3Date
 , l3Bits
 , Table_Const
 , ReqRow_Const
 , ControlPara_Const
 , ControlsBlock_Const
 , evReqRowImplementation
;

end.
