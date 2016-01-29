unit nsSingleAttributeDataObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Common$Lib"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Common/nsSingleAttributeDataObject.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Common$Lib::DocumentDataObjects::TnsSingleAttributeDataObject
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  evNodeDataObject
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsSingleAttributeDataObject = class(TevNodeDataObject)
 protected
 // overridden protected methods
   function DataClass: RStorable; override;
 end;//TnsSingleAttributeDataObject
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsSingleAttributeStorable
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsSingleAttributeDataObject

function TnsSingleAttributeDataObject.DataClass: RStorable;
//#UC START# *48F8CD5401AD_4682706F038A_var*
//#UC END# *48F8CD5401AD_4682706F038A_var*
begin
//#UC START# *48F8CD5401AD_4682706F038A_impl*
 Result := TnsSingleAttributeStorable;
//#UC END# *48F8CD5401AD_4682706F038A_impl*
end;//TnsSingleAttributeDataObject.DataClass

{$IfEnd} //not Admin AND not Monitorings

end.