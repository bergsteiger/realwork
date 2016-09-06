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

 (*
 MmsmListLike = interface
  function Get_ElementToAction: ImsmModelElement;
  procedure Set_ElementToAction(const aValue: ImsmModelElement);
  function Get_CurrentElement: ImsmModelElement;
  procedure Set_CurrentElement(const aValue: ImsmModelElement);
  function Get_Caption: AnsiString;
  property ElementToAction: ImsmModelElement
   read Get_ElementToAction
   write Set_ElementToAction;
  property CurrentElement: ImsmModelElement
   read Get_CurrentElement
   write Set_CurrentElement;
  property Caption: AnsiString
   read Get_Caption;
 end;//MmsmListLike
 *)

type
 ImsmListLikeModel = interface(ImsmModel)
  ['{23235321-6626-4491-B79E-CC6CB840C9DE}']
  function Get_ElementToAction: ImsmModelElement;
  procedure Set_ElementToAction(const aValue: ImsmModelElement);
  function Get_CurrentElement: ImsmModelElement;
  procedure Set_CurrentElement(const aValue: ImsmModelElement);
  function Get_Caption: AnsiString;
  property ElementToAction: ImsmModelElement
   read Get_ElementToAction
   write Set_ElementToAction;
  property CurrentElement: ImsmModelElement
   read Get_CurrentElement
   write Set_CurrentElement;
  property Caption: AnsiString
   read Get_Caption;
 end;//ImsmListLikeModel

 ImsmCaptionModel = interface(ImsmModel)
  ['{6EB7EA6F-9066-4F62-985E-950805DD8F72}']
  function Get_Caption: Il3CString;
  procedure Set_Caption(const aValue: Il3CString);
  property Caption: Il3CString
   read Get_Caption
   write Set_Caption;
 end;//ImsmCaptionModel

 ImsmListModel = interface(ImsmModel)
  ['{6FDB2833-1A88-49C8-9015-D0240B72FBB3}']
  function Get_List: ImsmModelElementStringList;
  procedure Set_List(const aValue: ImsmModelElementStringList);
  function Get_ElementToAction: ImsmModelElement;
  procedure Set_ElementToAction(const aValue: ImsmModelElement);
  function Get_CurrentElement: ImsmModelElement;
  procedure Set_CurrentElement(const aValue: ImsmModelElement);
  function Get_Caption: AnsiString;
  procedure ShowElementAsDir(const aList: ImsmModelElement);
   {* Показывает элемент в виде "директории" }
  procedure ShowElementRelationList(const anElement: ImsmModelElement);
   {* Показывает дочерний список элемента }
  function As_ImsmListLikeModel: ImsmListLikeModel;
   {* Метод приведения нашего интерфейса к ImsmListLikeModel }
  property List: ImsmModelElementStringList
   read Get_List
   write Set_List;
  property ElementToAction: ImsmModelElement
   read Get_ElementToAction
   write Set_ElementToAction;
  property CurrentElement: ImsmModelElement
   read Get_CurrentElement
   write Set_CurrentElement;
  property Caption: AnsiString
   read Get_Caption;
 end;//ImsmListModel

 CaptionChangedEvent = class(TmsmModelEvent)
  public
   class function Instance: CaptionChangedEvent;
    {* Метод получения экземпляра синглетона CaptionChangedEvent }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//CaptionChangedEvent

 ImsmTreeModel = interface(ImsmModel)
  ['{D4BC6105-5126-472E-B6F1-C01B4AB7E068}']
  function Get_Tree: ImsmModelElementTree;
  function Get_List: ImsmModelElementStringList;
  function Get_ElementToAction: ImsmModelElement;
  procedure Set_ElementToAction(const aValue: ImsmModelElement);
  function Get_CurrentElement: ImsmModelElement;
  procedure Set_CurrentElement(const aValue: ImsmModelElement);
  function Get_Caption: AnsiString;
  function As_ImsmListLikeModel: ImsmListLikeModel;
   {* Метод приведения нашего интерфейса к ImsmListLikeModel }
  property Tree: ImsmModelElementTree
   read Get_Tree;
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
 end;//ImsmTreeModel

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_CaptionChangedEvent: CaptionChangedEvent = nil;
 {* Экземпляр синглетона CaptionChangedEvent }

procedure CaptionChangedEventFree;
 {* Метод освобождения экземпляра синглетона CaptionChangedEvent }
begin
 l3Free(g_CaptionChangedEvent);
end;//CaptionChangedEventFree

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

end.
