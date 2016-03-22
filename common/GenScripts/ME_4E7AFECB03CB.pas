unit RubricatorInterfaces;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Rubricator\RubricatorInterfaces.pas"
// Стереотип: "Interfaces"
// Элемент модели: "RubricatorInterfaces" MUID: (4E7AFECB03CB)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3TreeInterfaces
 , DynamicTreeUnit
 , MainMenuUnit
 , l3Interfaces
;

type
 InsRubricatorTree = interface(Il3SimpleTree)
  ['{10D96B1D-DD61-4441-94CF-CE8EE3C1546E}']
  function Get_RootToKeep: INodeBase;
  function Get_MenuSectionItemToKeep: ISectionItem;
  property RootToKeep: INodeBase
   read Get_RootToKeep;
  property MenuSectionItemToKeep: ISectionItem
   read Get_MenuSectionItemToKeep;
 end;//InsRubricatorTree
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
