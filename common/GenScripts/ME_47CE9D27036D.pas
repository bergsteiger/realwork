unit evQueryCardDropControlsInt;

interface

uses
 l3IntfUses
 , nevTools
 , Messages
 , nevBase
 , l3Interfaces
 , Controls
 , Types
;

type
 InevBase = nevTools.InevBase;
 
 IevDropControl = interface
  procedure AfterHideControl;
  procedure EscPressed;
   {* Обработчик закрытия дерева по ESC. }
  procedure HideControl;
   {* Прячет выпадающий контрол. }
  function MouseWheel(aDown: Boolean): Boolean;
   {* Обработчик прокрутки колеса мыши. }
  function KeyDown(const aView: InevView;
   var Msg: TWMKeyDown): Boolean;
  procedure CloseTree;
   {* Прячет дерево как по нажатию Esc - с посылкой сообщения редактору. }
  function DropDown(const aView: InevView;
   const aTextPara: InevPara;
   ByUser: Boolean): Boolean;
   {* Реализует выпадение дерева или календаря. }
  procedure DropDownCurrentChanged(const aNode: InevSimpleNode);
 end;//IevDropControl
 
 IevDropCombo = interface
  function GetNode(anIndex: Integer): InevSimpleNode;
   {* Возвращает узел. }
  procedure ChooseNode(const Value: InevSimpleNode;
   NeedHide: Boolean);
   {* Обработчик выбора узла в дереве при его закрытии. }
 end;//IevDropCombo
 
 IevDropCalendar = interface
  procedure ApplyDate(Value: TDateTime);
   {* Передаёт выбранную дату в календарь. }
  procedure ChooseDate(Sender: TObject);
  procedure CancelDate(Sender: TObject);
 end;//IevDropCalendar
 
 IevDropContainer = interface
  {* Контейнер для выпадающих контролов. }
  function EditMask: AnsiString;
   {* Шаблон маски. }
  function DateFormat: AnsiString;
   {* Формат даты. }
  procedure SetDropTree(const ATreeDrop: IevDropControl;
   const ATagWrap: InevPara);
   {* Показывает/закрывает выпадающее дерево. }
  function IsDropTreeVisible: Boolean;
   {* Проверяет отображается ли окно календаря или дерева. }
  procedure ApplyDate(Value: TDateTime);
   {* Передаёт выбранную дату в календарь. }
  procedure ChooseDate(Sender: TObject);
   {* Обработчик выбора текущей даты. }
  procedure DoDrop(const aPoint: TPoint;
   AInvert: Boolean;
   AWidth: Integer;
   ByUser: Boolean);
   {* Вываливает выпадающий контрол по указанным координатам. }
  procedure ShowControl(const aPoint: TPoint;
   AInvert: Boolean;
   AWnd: hWnd;
   AWidth: Integer;
   AHeight: Integer);
   {* Вывод контрола на экран. }
  function DropControlHeigth: Integer;
   {* Высота выпадающего контрола. }
  procedure HideControl(NeedFocus: Boolean);
   {* Прячет выпадающий котрол. }
  function GetDropTreeNode(anIndex: Integer): InevSimpleNode;
  function CheckControl(const aDropControl: IevDropControl): Boolean;
  function GetControl: TControl;
   {* Возвращает контрол. }
  function KeyDown(const aView: InevView;
   var Msg: TWMKeyDown;
   aCurPara: Tl3Variant): Boolean;
   {* Обработка нажатия на клавиатуру. }
  function IsSameTreeRoot(const aRoot: InevNode): Boolean;
  procedure DropControlChanging;
  procedure DropControlChanged;
  function GetCurrentNode: InevSimpleNode;
  function IsSimpleTree: Boolean;
 end;//IevDropContainer
 
implementation

uses
 l3ImplUses
;

end.
