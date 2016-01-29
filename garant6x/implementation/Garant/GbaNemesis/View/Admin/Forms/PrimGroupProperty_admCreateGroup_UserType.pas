unit PrimGroupProperty_admCreateGroup_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/PrimGroupProperty_admCreateGroup_UserType.pas"
// �����: 01.10.2009 21:57
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 �������������::Admin::View::Admin::PrimGroupProperty::admCreateGroup
//
// ����� ������
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
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� admCreateGroup }
  admCreateGroupName = 'admCreateGroup';
   { ��������� ������������� ����������������� ���� "����� ������" }
  admCreateGroup = TvcmUserType(0);
   { ����� ������ }
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
{$If defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_admCreateGroup = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� admCreateGroup }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_admCreateGroup
{$IfEnd} //Admin AND not NoScripts

{$If defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_admCreateGroup

class function Tkw_FormUserType_admCreateGroup.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::admCreateGroup';
end;//Tkw_FormUserType_admCreateGroup.GetWordNameForRegister

function Tkw_FormUserType_admCreateGroup.GetInteger: Integer;
 {-}
begin
 Result := admCreateGroup;
end;//Tkw_FormUserType_admCreateGroup.GetInteger

{$IfEnd} //Admin AND not NoScripts
{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_admCreateGroup
 Tkw_FormUserType_admCreateGroup.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts

end.