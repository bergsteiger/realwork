unit moRubricator;
 {* Правовой навигатор }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moRubricator.pas"
// Стереотип: "VCMUseCaseRealization"
// Элемент модели: "Rubricator" MUID: (4AA6778D0357)
// Имя типа: "Tmo_Rubricator"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Rubricator_Module
;

type
 Tmo_Rubricator = {final} class(TRubricatorModule)
  {* Правовой навигатор }
 end;//Tmo_Rubricator
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
