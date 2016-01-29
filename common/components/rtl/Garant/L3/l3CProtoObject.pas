unit l3CProtoObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3CProtoObject.pas"
// �����: 26.10.2009 19:11
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3CProtoObject
//
// ���������� Tl3ProtoObject
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3ProtoObject
  ;

type
 Tl3CProtoObject = {abstract} class(Tl3ProtoObject)
  {* ���������� Tl3ProtoObject }
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
   {$IfEnd} //not DesignTimeLibrary
   function NeedCleanupFields: Boolean; override;
 end;//Tl3CProtoObject

implementation

// start class Tl3CProtoObject

{$If not defined(DesignTimeLibrary)}
class function Tl3CProtoObject.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_4AE5CA2D0034_var*
//#UC END# *47A6FEE600FC_4AE5CA2D0034_var*
begin
//#UC START# *47A6FEE600FC_4AE5CA2D0034_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4AE5CA2D0034_impl*
end;//Tl3CProtoObject.IsCacheable
{$IfEnd} //not DesignTimeLibrary

function Tl3CProtoObject.NeedCleanupFields: Boolean;
//#UC START# *4AF44EC401EE_4AE5CA2D0034_var*
//#UC END# *4AF44EC401EE_4AE5CA2D0034_var*
begin
//#UC START# *4AF44EC401EE_4AE5CA2D0034_impl*
 Result := false;
//#UC END# *4AF44EC401EE_4AE5CA2D0034_impl*
end;//Tl3CProtoObject.NeedCleanupFields

end.