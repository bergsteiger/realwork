unit nsNodeDataObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Components"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Components/nsNodeDataObject.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ������� ����������� ���������� �������::LegalDomain::Components::Tree$WithDnD::TnsNodeDataObject
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  evNodeDataObject
  ;

type
 TnsNodeDataObject = class(TevNodeDataObject)
 protected
 // overridden protected methods
   function DataClass: RStorable; override;
 end;//TnsNodeDataObject

implementation

uses
  nsNodeStorable
  ;

// start class TnsNodeDataObject

function TnsNodeDataObject.DataClass: RStorable;
//#UC START# *48F8CD5401AD_468270DC0341_var*
//#UC END# *48F8CD5401AD_468270DC0341_var*
begin
//#UC START# *48F8CD5401AD_468270DC0341_impl*
 Result := TnsNodeStorable;
//#UC END# *48F8CD5401AD_468270DC0341_impl*
end;//TnsNodeDataObject.DataClass

end.