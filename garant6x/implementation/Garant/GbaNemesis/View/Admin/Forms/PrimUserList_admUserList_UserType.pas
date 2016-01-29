unit PrimUserList_admUserList_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ������ �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/PrimUserList_admUserList_UserType.pas"
// �����: 15.08.2005 19.00
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 �������������::Admin::View::Admin::PrimUserList::admUserList
//
// ������ �������������
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
   { ��������� ��� ���� ����� admUserList }
  admUserListName = 'admUserList';
   { ��������� ������������� ����������������� ���� "������ �������������" }
  admUserList = TvcmUserType(0);
   { ������ ������������� }
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
{$If defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_admUserList = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� admUserList }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_admUserList
{$IfEnd} //Admin AND not NoScripts

{$If defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_admUserList

class function Tkw_FormUserType_admUserList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::admUserList';
end;//Tkw_FormUserType_admUserList.GetWordNameForRegister

function Tkw_FormUserType_admUserList.GetInteger: Integer;
 {-}
begin
 Result := admUserList;
end;//Tkw_FormUserType_admUserList.GetInteger

{$IfEnd} //Admin AND not NoScripts
{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_admUserList
 Tkw_FormUserType_admUserList.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts

end.