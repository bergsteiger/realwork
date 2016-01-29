unit TreeInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tree"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Tree/TreeInterfaces.pas"
// Начат: 14.11.2008 22^23
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ControllerInterfaces::Category>> F1 Базовые определения предметной области::LegalDomain::Tree::TreeInterfaces
//
// Интерфейсы для работы с деревьями
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  l3InternalInterfaces,
  l3TreeInterfaces
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  ,
  vcmInterfaces {a},
  vcmControllers {a}
  ;

(*
 InsContextFilter = PureMixIn
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

end.