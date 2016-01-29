unit nsSingleAttributeData;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Common$Lib"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Common/nsSingleAttributeData.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Common$Lib::DocumentDataObjects::TnsSingleAttributeData
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
  evNodeData
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsSingleAttributeData = class(TevNodeData)
 protected
 // overridden protected methods
   function ExtDataClass: RDataClass; override;
 end;//TnsSingleAttributeData
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsSingleAttributeDataObject
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsSingleAttributeData

function TnsSingleAttributeData.ExtDataClass: RDataClass;
//#UC START# *48F8D47302FD_48F72B630069_var*
//#UC END# *48F8D47302FD_48F72B630069_var*
begin
//#UC START# *48F8D47302FD_48F72B630069_impl*
 Result := TnsSingleAttributeDataObject;
//#UC END# *48F8D47302FD_48F72B630069_impl*
end;//TnsSingleAttributeData.ExtDataClass

{$IfEnd} //not Admin AND not Monitorings

end.