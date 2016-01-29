unit evControl;

interface

uses
 l3IntfUses
 , evCustomControlTool
 , evQueryCardInt
 , nevTools
 , nevBase
 , l3Interfaces
 , evdTypes
;

type
 TevControl = class(TevCustomControlTool, IevCustomEditorControl, IevEditorControl)
  {* Базовый класс для всех контролов }
  function GetIsMultiline: Boolean;
  function Make(const aValue: InevPara): IevEditorControl;
  procedure SetChecked(aValue: Boolean);
  function DoKeyCommand(const aView: InevControlView;
   aCmd: Word;
   const aTextPara: InevPara): Boolean;
  function DoLMouseBtnUp(const aView: InevControlView;
   const aTextPara: InevPara;
   const aPt: TnevPoint;
   const Keys: TevMouseState;
   anInPara: Boolean): Boolean;
  function DoLMouseBtnDown(const aView: InevControlView;
   const aTextPara: InevPara;
   const aPt: TnevPoint;
   const Keys: TevMouseState;
   anInPara: Boolean;
   const aMap: InevMap): Boolean;
  procedure DoUpperChange;
  procedure SetText(const Value: Il3CString);
  function GetChecked: Boolean;
  procedure DoTextChange(const aView: InevView;
   const aPara: InevPara;
   const anOp: InevOp);
  procedure DoInsertRow(const aView: InevView);
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
  function ControlName: Tl3WString;
   {* Имя контрола (тег - k2_tiName). }
  function ControlType: TevControlType;
   {* Тип контрола. }
  function Visible: Boolean;
   {* Видимость контрола. }
  function Upper: Boolean;
   {* Состояние для Flat-кнопки. }
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
  function Field: IevEditorControlField;
   {* Поле, которому принадлежит контрол. }
  function Req: IevReq;
   {* Реквизит, которому принадлежит контрол. }
  function Enabled: Boolean;
   {* Доступность контрола. }
  function MaxLength: Integer;
  function Caption: Il3CString;
 end;//TevControl
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3Base
 , l3Types
 , evParaTools
 , SysUtils
 , l3InterfacedString
 , l3String
 , ReqRow_Const
 , l3CEmptyStringPrim
 , l3CEmptyString
;

end.
