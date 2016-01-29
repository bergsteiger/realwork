unit mmmRegulatoryInformation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Medic"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/mmmRegulatoryInformation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Inpharm::Medic::MedicMainMenu::TmmmRegulatoryInformation
//
// Нормативная информация
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
 TmmmRegulatoryInformation = class(TmmmTree)
  {* Нормативная информация }
 protected
 // overridden protected methods
   function MakeRoot: Il3RootNode; override;
     {* Создаёт корень дерева }
 end;//TmmmRegulatoryInformation
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  nsTypes,
  nsConst,
  l3MessageID
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки Regulatory Information }
  str_LegislationReview : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'LegislationReview'; rValue : 'Обзор изменений законодательства');
   { 'Обзор изменений законодательства' }

// start class TmmmRegulatoryInformation

function TmmmRegulatoryInformation.MakeRoot: Il3RootNode;
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

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_LegislationReview
 str_LegislationReview.Init;
{$IfEnd} //not Admin AND not Monitorings

end.