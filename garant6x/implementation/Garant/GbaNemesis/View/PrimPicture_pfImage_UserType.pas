unit PrimPicture_pfImage_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimPicture_pfImage_UserType.pas"
// �����: 15.09.2009 21:32
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ������ � ���������� � ������� ����������::Document::View::Picture::PrimPicture::pfImage
//
// �������� ������������ �������
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
   { ��������� ��� ���� ����� pfImage }
  pfImageName = 'pfImage';
   { ��������� ������������� ����������������� ���� "�������� ������������ �������" }
  pfImage = TvcmUserType(0);
   { �������� ������������ ������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_pfImage = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� pfImage }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_pfImage
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_pfImage

class function Tkw_FormUserType_pfImage.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::pfImage';
end;//Tkw_FormUserType_pfImage.GetWordNameForRegister

function Tkw_FormUserType_pfImage.GetInteger: Integer;
 {-}
begin
 Result := pfImage;
end;//Tkw_FormUserType_pfImage.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_pfImage
 Tkw_FormUserType_pfImage.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.