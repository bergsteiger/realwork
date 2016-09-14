unit msmConcreteModels;

// Модуль: "w:\common\components\gui\Garant\msm\msmConcreteModels.pas"
// Стереотип: "Interfaces"
// Элемент модели: "msmConcreteModels" MUID: (57ADC53E00B6)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , msmModelElements
 , msmControllers
 , msmElementViews
 , msmUsualData
 , msmModels
 , msmEvents
;

type
 ImsmElementSelection_ProcessSelectedF_Action = function(const anItem: ImsmModelElement): Boolean;
  {* Тип подитеративной функции для ImsmElementSelection.ProcessSelectedF }

 ImsmElementSelection = interface
  ['{07A764C8-B32C-4DA5-B3D3-1CB8495E2368}']
  function Get_CurrentElement: ImsmModelElement;
  procedure Set_CurrentElement(const aValue: ImsmModelElement);
  procedure SelectElement(const anElement: ImsmModelElement);
  procedure DeselectElement(const anElement: ImsmModelElement);
  procedure InvertElement(const anElement: ImsmModelElement);
  function IsElementSelected(const anElement: ImsmModelElement): Boolean;
  procedure Clear;
  procedure ProcessSelectedF(anAction: ImsmElementSelection_ProcessSelectedF_Action);
  function Empty: Boolean;
  function IsElementSelectedOrCurrent(const anElement: ImsmModelElement): Boolean;
  property CurrentElement: ImsmModelElement
   read Get_CurrentElement
   write Set_CurrentElement;
 end;//ImsmElementSelection

 (*
 MmsmListLike = interface
  function Get_ElementToAction: ImsmModelElement;
  procedure Set_ElementToAction(const aValue: ImsmModelElement);
  function Get_CurrentElement: ImsmModelElement;
  procedure Set_CurrentElement(const aValue: ImsmModelElement);
  function Get_Caption: AnsiString;
  function Get_Selection: ImsmElementSelection;
  property ElementToAction: ImsmModelElement
   read Get_ElementToAction
   write Set_ElementToAction;
  property CurrentElement: ImsmModelElement
   read Get_CurrentElement
   write Set_CurrentElement;
  property Caption: AnsiString
   read Get_Caption;
  property Selection: ImsmElementSelection
   read Get_Selection;
 end;//MmsmListLike
 *)

 ImsmCaptionModel = interface(ImsmModel)
  ['{6EB7EA6F-9066-4F62-985E-950805DD8F72}']
  function Get_Caption: Il3CString;
  procedure Set_Caption(const aValue: Il3CString);
  property Caption: Il3CString
   read Get_Caption
   write Set_Caption;
 end;//ImsmCaptionModel

 ImsmListLikeModel = interface(ImsmModel)
  ['{23235321-6626-4491-B79E-CC6CB840C9DE}']
  function Get_List: ImsmModelElementStringList;
  function Get_ElementToAction: ImsmModelElement;
  procedure Set_ElementToAction(const aValue: ImsmModelElement);
  function Get_CurrentElement: ImsmModelElement;
  procedure Set_CurrentElement(const aValue: ImsmModelElement);
  function Get_Caption: AnsiString;
  function Get_Selection: ImsmElementSelection;
  procedure ShowElementAsList(const anElement: ImsmModelElement);
  property List: ImsmModelElementStringList
   read Get_List;
  property ElementToAction: ImsmModelElement
   read Get_ElementToAction
   write Set_ElementToAction;
  property CurrentElement: ImsmModelElement
   read Get_CurrentElement
   write Set_CurrentElement;
  property Caption: AnsiString
   read Get_Caption;
  property Selection: ImsmElementSelection
   read Get_Selection;
 end;//ImsmListLikeModel

 CaptionChangedEvent = class(TmsmModelEvent)
  public
   class function Instance: CaptionChangedEvent;
    {* Метод получения экземпляра синглетона CaptionChangedEvent }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//CaptionChangedEvent

 ImsmListModel = interface(ImsmListLikeModel)
  ['{6FDB2833-1A88-49C8-9015-D0240B72FBB3}']
  function Get_ElementToAction: ImsmModelElement;
  procedure Set_ElementToAction(const aValue: ImsmModelElement);
  function Get_CurrentElement: ImsmModelElement;
  procedure Set_CurrentElement(const aValue: ImsmModelElement);
  function Get_Caption: AnsiString;
  function Get_Selection: ImsmElementSelection;
  property ElementToAction: ImsmModelElement
   read Get_ElementToAction
   write Set_ElementToAction;
  property CurrentElement: ImsmModelElement
   read Get_CurrentElement
   write Set_CurrentElement;
  property Caption: AnsiString
   read Get_Caption;
  property Selection: ImsmElementSelection
   read Get_Selection;
 end;//ImsmListModel

 ImsmDrawingModel = interface(ImsmListModel)
  ['{6E29F5F1-D00D-4FF4-A55B-50DE59E80BF4}']
 end;//ImsmDrawingModel

 ImsmTreeModel = interface(ImsmListLikeModel)
  ['{D4BC6105-5126-472E-B6F1-C01B4AB7E068}']
  function Get_Tree: ImsmModelElementTree;
  function Get_ElementToAction: ImsmModelElement;
  procedure Set_ElementToAction(const aValue: ImsmModelElement);
  function Get_CurrentElement: ImsmModelElement;
  procedure Set_CurrentElement(const aValue: ImsmModelElement);
  function Get_Caption: AnsiString;
  function Get_Selection: ImsmElementSelection;
  property Tree: ImsmModelElementTree
   read Get_Tree;
  property ElementToAction: ImsmModelElement
   read Get_ElementToAction
   write Set_ElementToAction;
  property CurrentElement: ImsmModelElement
   read Get_CurrentElement
   write Set_CurrentElement;
  property Caption: AnsiString
   read Get_Caption;
  property Selection: ImsmElementSelection
   read Get_Selection;
 end;//ImsmTreeModel

 SelectionChangedEvent = {final} class(TmsmModelEvent)
  public
   class function Instance: SelectionChangedEvent;
    {* Метод получения экземпляра синглетона SelectionChangedEvent }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//SelectionChangedEvent

function L2ImsmElementSelectionProcessSelectedFAction(anAction: Pointer): ImsmElementSelection_ProcessSelectedF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для ImsmElementSelection.ProcessSelectedF }

implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
;

var g_CaptionChangedEvent: CaptionChangedEvent = nil;
 {* Экземпляр синглетона CaptionChangedEvent }
var g_SelectionChangedEvent: SelectionChangedEvent = nil;
 {* Экземпляр синглетона SelectionChangedEvent }

function L2ImsmElementSelectionProcessSelectedFAction(anAction: Pointer): ImsmElementSelection_ProcessSelectedF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для ImsmElementSelection.ProcessSelectedF }
asm
 jmp l3LocalStub
end;//L2ImsmElementSelectionProcessSelectedFAction

procedure CaptionChangedEventFree;
 {* Метод освобождения экземпляра синглетона CaptionChangedEvent }
begin
 l3Free(g_CaptionChangedEvent);
end;//CaptionChangedEventFree

procedure SelectionChangedEventFree;
 {* Метод освобождения экземпляра синглетона SelectionChangedEvent }
begin
 l3Free(g_SelectionChangedEvent);
end;//SelectionChangedEventFree

class function CaptionChangedEvent.Instance: CaptionChangedEvent;
 {* Метод получения экземпляра синглетона CaptionChangedEvent }
begin
 if (g_CaptionChangedEvent = nil) then
 begin
  l3System.AddExitProc(CaptionChangedEventFree);
  g_CaptionChangedEvent := Create;
 end;
 Result := g_CaptionChangedEvent;
end;//CaptionChangedEvent.Instance

class function CaptionChangedEvent.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_CaptionChangedEvent <> nil;
end;//CaptionChangedEvent.Exists

class function SelectionChangedEvent.Instance: SelectionChangedEvent;
 {* Метод получения экземпляра синглетона SelectionChangedEvent }
begin
 if (g_SelectionChangedEvent = nil) then
 begin
  l3System.AddExitProc(SelectionChangedEventFree);
  g_SelectionChangedEvent := Create;
 end;
 Result := g_SelectionChangedEvent;
end;//SelectionChangedEvent.Instance

class function SelectionChangedEvent.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_SelectionChangedEvent <> nil;
end;//SelectionChangedEvent.Exists

end.
