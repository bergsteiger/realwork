unit PrimGroupProperty_admRenameGroup_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/PrimGroupProperty_admRenameGroup_UserType.pas"
// �����: 01.10.2009 21:57
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 �������������::Admin::View::Admin::PrimGroupProperty::admRenameGroup
//
// ������������� ������
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
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  PrimGroupProperty_admCreateGroup_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� admRenameGroup }
  admRenameGroupName = 'admRenameGroup';
   { ��������� ������������� ����������������� ���� "������������� ������" }
  admRenameGroup = TvcmUserType(admCreateGroup + 1);
   { ������������� ������ }
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
{$If defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_admRenameGroup = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� admRenameGroup }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_admRenameGroup
{$IfEnd} //Admin AND not NoScripts

{$If defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_admRenameGroup

class function Tkw_FormUserType_admRenameGroup.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::admRenameGroup';
end;//Tkw_FormUserType_admRenameGroup.GetWordNameForRegister

function Tkw_FormUserType_admRenameGroup.GetInteger: Integer;
 {-}
begin
 Result := admRenameGroup;
end;//Tkw_FormUserType_admRenameGroup.GetInteger

{$IfEnd} //Admin AND not NoScripts
{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_admRenameGroup
 Tkw_FormUserType_admRenameGroup.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts

end.