unit mmmRegulatoryInformation;
 {* Нормативная информация }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\mmmRegulatoryInformation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmmmRegulatoryInformation" MUID: (490C4DB100E4)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , mmmTree
 , l3Tree_TLB
;

type
 TmmmRegulatoryInformation = class(TmmmTree)
  {* Нормативная информация }
  protected
   function MakeRoot: Il3RootNode; override;
    {* Создаёт корень дерева }
 end;//TmmmRegulatoryInformation
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsTypes
 , nsConst
 //#UC START# *490C4DB100E4impl_uses*
 //#UC END# *490C4DB100E4impl_uses*
;

const
 {* Локализуемые строки Regulatory Information }
 str_LegislationReview: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'LegislationReview'; rValue : 'Обзор изменений законодательства');
  {* 'Обзор изменений законодательства' }

function TmmmRegulatoryInformation.MakeRoot: Il3RootNode;
 {* Создаёт корень дерева }
//#UC START# *4909EF6E0361_490C4DB100E4_var*
const
 c_Documents: array [0..2] of Longint = (52390005, 52390029, 52390030);
//#UC END# *4909EF6E0361_490C4DB100E4_var*
begin
//#UC START# *4909EF6E0361_490C4DB100E4_impl*
 Result := inherited MakeRoot;
 nsAddMainMenuItem(Result,
                   Ord(ns_mntLegislationReview),
                   str_LegislationReview.AsCStr);
 nsAddMainMenuDocumentItem(Result, Ord(ns_mntDocument), c_Documents);
//#UC END# *4909EF6E0361_490C4DB100E4_impl*
end;//TmmmRegulatoryInformation.MakeRoot

initialization
 str_LegislationReview.Init;
 {* Инициализация str_LegislationReview }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
