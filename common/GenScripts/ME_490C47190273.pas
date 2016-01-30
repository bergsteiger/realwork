unit mmmReferencePharmaceuticalInformation;
 {* Справочная фармацевтическая информация }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\mmmReferencePharmaceuticalInformation.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , mmmTree
 , l3Tree_TLB
 , l3StringIDEx
;

type
 TmmmReferencePharmaceuticalInformation = class(TmmmTree)
  {* Справочная фармацевтическая информация }
  protected
   function MakeRoot: Il3RootNode; override;
    {* Создаёт корень дерева }
 end;//TmmmReferencePharmaceuticalInformation
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsTypes
 , l3MessageID
;

const
 {* Локализуемые строки Local }
 str_mmmiHelp: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mmmiHelp'; rValue : 'Руководство пользователя');
  {* 'Руководство пользователя' }

function TmmmReferencePharmaceuticalInformation.MakeRoot: Il3RootNode;
 {* Создаёт корень дерева }
//#UC START# *4909EF6E0361_490C47190273_var*
const
 c_Documents: array [0..3] of Longint = (52390025, 52390014, 52390003, 52390001);
//#UC END# *4909EF6E0361_490C47190273_var*
begin
//#UC START# *4909EF6E0361_490C47190273_impl*
 Result := inherited MakeRoot;
 nsAddMainMenuDocumentItem(Result, Ord(ns_mntDocument), c_Documents);
 //AddItem(Result, ns_mntHelp, str_mmmiHelp);
//#UC END# *4909EF6E0361_490C47190273_impl*
end;//TmmmReferencePharmaceuticalInformation.MakeRoot

initialization
 str_mmmiHelp.Init;
 {* Инициализация str_mmmiHelp }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
