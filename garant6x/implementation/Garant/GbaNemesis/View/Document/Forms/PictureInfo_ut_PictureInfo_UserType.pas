unit PictureInfo_ut_PictureInfo_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: �������� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/Forms/PictureInfo_ut_PictureInfo_UserType.pas"
// �����: 11 ���� 2007
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ������ � ���������� � ������� ����������::Document::View::Document::Document::PictureInfo::ut_PictureInfo
//
// ���������� � ��������
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
    { ��������� ��� ���� ����� ut_PictureInfo }
   ut_PictureInfoName = 'ut_PictureInfo';
    { ��������� ������������� ����������������� ���� "���������� � ��������" }
   ut_PictureInfo = TvcmUserType(0);
    { ���������� � �������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
   Tkw_FormUserType_ut_PictureInfo = {final scriptword} class(TtfwInteger)
    {* ����� ������� ��� ���� ����� ut_PictureInfo }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_PictureInfo
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ut_PictureInfo

class function Tkw_FormUserType_ut_PictureInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::ut_PictureInfo';
end;//Tkw_FormUserType_ut_PictureInfo.GetWordNameForRegister

function Tkw_FormUserType_ut_PictureInfo.GetInteger: Integer;
 {-}
begin
 Result := ut_PictureInfo;
end;//Tkw_FormUserType_ut_PictureInfo.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_ut_PictureInfo
 Tkw_FormUserType_ut_PictureInfo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.