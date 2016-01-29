unit PrimGroupList_admGroupList_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/PrimGroupList_admGroupList_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 �������������::Admin::View::Admin::PrimGroupList::admGroupList
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
   { ��������� ��� ���� ����� admGroupList }
  admGroupListName = 'admGroupList';
   { ��������� ������������� ����������������� ���� "������ �������������" }
  admGroupList = TvcmUserType(0);
   { ������ ������������� }
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
{$If defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_admGroupList = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� admGroupList }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_admGroupList
{$IfEnd} //Admin AND not NoScripts

{$If defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_admGroupList

class function Tkw_FormUserType_admGroupList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::admGroupList';
end;//Tkw_FormUserType_admGroupList.GetWordNameForRegister

function Tkw_FormUserType_admGroupList.GetInteger: Integer;
 {-}
begin
 Result := admGroupList;
end;//Tkw_FormUserType_admGroupList.GetInteger

{$IfEnd} //Admin AND not NoScripts
{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_admGroupList
 Tkw_FormUserType_admGroupList.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts

end.