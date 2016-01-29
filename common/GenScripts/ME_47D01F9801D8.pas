unit evControlContainerEX;

interface

uses
 l3IntfUses
 , evControlContainer
 , evQueryCardDropControlsInt
 , evDropCalendar
 , evDropTree
 , l3Core
 , ImgList
 , nevBase
 , Controls
 , l3Interfaces
 , nevTools
 , Types
 , l3Variant
 , Messages
;

type
 TevControlContainerEX = class(TevControlContainer, IevDropContainer)
  procedure UpdateMask;
   {* Обновляет маску. }
  function FormatSettingsChange(var Message: TMessage): Boolean;
   {* Обработчик изменения формата даты. }
  procedure UpdateFormat;
   {* Обновляет формат даты. }
  procedure NeedCloseTree(Sender: TObject);
  procedure CancelDate(Sender: TObject);
   {* Обработчик отказа от выбора даты. }
  function DoGetItemImage(Sender: TObject;
   Index: Integer;
   var aImages: TCustomImageList): Integer;
  procedure ChooseNode(Sender: TObject;
   const Value: InevSimpleNode);
  procedure StartSize(Sender: TObject);
  procedure EndSize(Sender: TObject);
  function OwnerAssigned: Boolean;
  procedure TreeCurrentChanged(Sender: TObject;
   aNewCurrent: Integer;
   aOldCurrent: Integer);
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
  function Tree: InevSimpleTree;
  function Current: Integer;
  function IsSameTreeRoot(const aRoot: InevNode): Boolean;
  procedure DropControlChanging;
  procedure DropControlChanged;
  function GetCurrentNode: InevSimpleNode;
  function IsSimpleTree: Boolean;
  function ESCPressed: Boolean;
   {* Флаг, выставляемый для необходимости закрытия дерева без выбора узла. }
  procedure DoHideDroppedControl(CanSetFocus: Boolean);
  function DoMouseWheel(aDown: Boolean): Boolean;
  function DropTextStyle: Tl3StyleId;
  function AllowEmptyCurrent: Boolean;
 end;//TevControlContainerEX
 
implementation

uses
 l3ImplUses
 , l3Date
 , Forms
 , SysUtils
 , l3ImageList
 , evQueryCardInt
 , l3Base
 , l3ControlsTypes
 , k2Tags
 , Classes
 , evdTypes
 , Windows
 , l3String
 , LeafPara_Const
 , l3Defaults
 , Graphics
;

end.
