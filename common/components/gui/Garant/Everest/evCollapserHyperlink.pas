unit evCollapserHyperlink;
 {* Сворачивающая гиперссылка. }

// Модуль: "w:\common\components\gui\Garant\Everest\evCollapserHyperlink.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevCollapserHyperlink" MUID: (55F6C74B033E)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , evDecorHyperlink
 , evdTypes
;

type
 TevCollapserHyperlink = class(TevDecorHyperlink)
  {* Сворачивающая гиперссылка. }
  protected
   function DoGetKind: TevLinkViewKind; override;
 end;//TevCollapserHyperlink
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
;

function TevCollapserHyperlink.DoGetKind: TevLinkViewKind;
//#UC START# *55F6C6DC018B_55F6C74B033E_var*
//#UC END# *55F6C6DC018B_55F6C74B033E_var*
begin
//#UC START# *55F6C6DC018B_55F6C74B033E_impl*
 Result := ev_lvkShellInternal;
//#UC END# *55F6C6DC018B_55F6C74B033E_impl*
end;//TevCollapserHyperlink.DoGetKind
{$IfEnd} // Defined(evNeedHotSpot)

end.
