unit dsBasesAccess;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Admin"
// �����: ������� �.�
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Admin/dsBasesAccess.pas"
// �����: 2008/06/23 09:26:00
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 �������������::Admin::Admin::Admin::TdsBasesAccess
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
uses
  dsTreeAttributeSelect,
  SearchDomainInterfaces
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
 TdsBasesAccess = {vac} class(TdsTreeAttributeSelect)
 protected
 // overridden protected methods
   function GetOperations: TLogicOperationSet; override;
 end;//TdsBasesAccess
{$IfEnd} //Admin

implementation

{$If defined(Admin)}

// start class TdsBasesAccess

function TdsBasesAccess.GetOperations: TLogicOperationSet;
//#UC START# *492406340209_495504A000F2_var*
//#UC END# *492406340209_495504A000F2_var*
begin
//#UC START# *492406340209_495504A000F2_impl*
 Result := [loNot];
//#UC END# *492406340209_495504A000F2_impl*
end;//TdsBasesAccess.GetOperations

{$IfEnd} //Admin

end.