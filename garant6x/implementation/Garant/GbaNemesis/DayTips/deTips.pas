unit deTips;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DayTips"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/DayTips/deTips.pas"
// �����: 08.12.2009 18:37
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ������������ ��������::DayTips::DayTips::DayTips::TdeTips
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
 TdeTips = class(TdeCommonDiction)
 protected
 // overridden protected methods
   function DefaultDocType: TDocumentType; override;
 end;//TdeTips
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdeTips

function TdeTips.DefaultDocType: TDocumentType;
//#UC START# *4B1E714A0125_49254B6F0325_var*
//#UC END# *4B1E714A0125_49254B6F0325_var*
begin
//#UC START# *4B1E714A0125_49254B6F0325_impl*
 Result := DT_TIP;
//#UC END# *4B1E714A0125_49254B6F0325_impl*
end;//TdeTips.DefaultDocType

{$IfEnd} //not Admin AND not Monitorings

end.