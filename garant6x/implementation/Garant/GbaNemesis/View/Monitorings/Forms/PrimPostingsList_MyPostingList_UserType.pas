unit PrimPostingsList_MyPostingList_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Monitorings/Forms/PrimPostingsList_MyPostingList_UserType.pas"
// �����: 15.09.2009 18:14
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Common For Shell And Monitoring::PostingOrder::View::Monitorings::PrimPostingsList::MyPostingList
//
// �����. ��� ��������� �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
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
   { ��������� ��� ���� ����� MyPostingList }
  MyPostingListName = 'MyPostingList';
   { ��������� ������������� ����������������� ���� "�����. ��� ��������� �����" }
  MyPostingList = TvcmUserType(0);
   { �����. ��� ��������� ����� }
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
{$If not defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_MyPostingList = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� MyPostingList }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_MyPostingList
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_MyPostingList

class function Tkw_FormUserType_MyPostingList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::MyPostingList';
end;//Tkw_FormUserType_MyPostingList.GetWordNameForRegister

function Tkw_FormUserType_MyPostingList.GetInteger: Integer;
 {-}
begin
 Result := MyPostingList;
end;//Tkw_FormUserType_MyPostingList.GetInteger

{$IfEnd} //not Admin AND not NoScripts
{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_MyPostingList
 Tkw_FormUserType_MyPostingList.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.