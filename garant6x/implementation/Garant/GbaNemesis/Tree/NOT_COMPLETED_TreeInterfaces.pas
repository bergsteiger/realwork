unit NOT_COMPLETED_TreeInterfaces;
 {* Интерфейсы для работы с деревьями }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Tree\NOT_COMPLETED_TreeInterfaces.pas"
// Стереотип: "ControllerInterfaces"
// Элемент модели: "TreeInterfaces" MUID: (491DD2830110)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3InternalInterfaces
 , l3TreeInterfaces
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
;

 (*
 InsContextFilter = interface
  function pm_GetCurrentContextFilter: InscContextFilterState;
  function FiltrateByContext(const aTreeSource: Il3SimpleTree;
   const aCurrentNode: Il3SimpleNode;
   const aFilter: InscContextFilterState;
   out aCurrent: Integer): Il3SimpleTree;
  property CurrentContextFilter: InscContextFilterState
   read pm_GetCurrentContextFilter;
 end;//InsContextFilter
 *)

type
 IdsSimpleTree = interface(IvcmViewAreaController)
  {* Бизнес объекта формы с деревом. }
  ['{05B327B7-32D5-4BF3-A7C2-463B5813E61F}']
  function pm_GetImageList: Il3ImageList;
  function pm_GetSimpleTree: Il3SimpleTree;
  procedure pm_SetSimpleTree(const aValue: Il3SimpleTree);
  procedure CurrentChanged(const aNode: Il3SimpleNode;
   aUpdateWithDelay: Boolean = True);
   {* изменился текущий узел дерева. По умолчанию включён режим отложенного
           обновления текущего, чтобы не обновлялось свзянное представление при
           быстром перемещении. Когда пользователь в дереве открывает элемент
           отложенное обновление нужно выключать }
  property ImageList: Il3ImageList
   read pm_GetImageList;
   {* иконки для дерева }
  property SimpleTree: Il3SimpleTree
   read pm_GetSimpleTree
   write pm_SetSimpleTree;
   {* дерево. Почему не readonly? }
 end;//IdsSimpleTree

implementation

uses
 l3ImplUses
;

end.
