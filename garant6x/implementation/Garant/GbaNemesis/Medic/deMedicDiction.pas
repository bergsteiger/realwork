unit deMedicDiction;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Medic"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/deMedicDiction.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ���������� ��������::Inpharm::Medic::Medic::TdeMedicDiction
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
  deCommonDiction,
  DocumentUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdeMedicDiction = class(TdeCommonDiction)
 protected
 // overridden protected methods
   function DefaultDocType: TDocumentType; override;
 end;//TdeMedicDiction
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdeMedicDiction

function TdeMedicDiction.DefaultDocType: TDocumentType;
//#UC START# *4B1E714A0125_492559970076_var*
//#UC END# *4B1E714A0125_492559970076_var*
begin
//#UC START# *4B1E714A0125_492559970076_impl*
 Result := DT_MEDICAL_EXPLANATORY;
//#UC END# *4B1E714A0125_492559970076_impl*
end;//TdeMedicDiction.DefaultDocType

{$IfEnd} //not Admin AND not Monitorings

end.