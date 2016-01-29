unit mmmReferencePharmaceuticalInformation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Medic"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/mmmReferencePharmaceuticalInformation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Inpharm::Medic::MedicMainMenu::TmmmReferencePharmaceuticalInformation
//
// Справочная фармацевтическая информация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  mmmTree,
  l3StringIDEx,
  l3Tree_TLB
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TmmmReferencePharmaceuticalInformation = class(TmmmTree)
  {* Справочная фармацевтическая информация }
 protected
 // overridden protected methods
   function MakeRoot: Il3RootNode; override;
     {* Создаёт корень дерева }
 end;//TmmmReferencePharmaceuticalInformation
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsTypes,
  l3MessageID
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки Local }
  str_mmmiHelp : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mmmiHelp'; rValue : 'Руководство пользователя');
   { 'Руководство пользователя' }

// start class TmmmReferencePharmaceuticalInformation

function TmmmReferencePharmaceuticalInformation.MakeRoot: Il3RootNode;
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

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_mmmiHelp
 str_mmmiHelp.Init;
{$IfEnd} //not Admin AND not Monitorings

end.