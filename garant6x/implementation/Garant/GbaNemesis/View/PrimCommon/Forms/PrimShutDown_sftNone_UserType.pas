unit PrimShutDown_sftNone_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimCommon/Forms/PrimShutDown_sftNone_UserType.pas"
// �����: 21.08.2009 21:18
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ������� ����������� ���������� �������::F1 Application Template::View::PrimCommon::PrimShutDown::sftNone
//
// �������������� � �������� ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

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
   { ��������� ��� ���� ����� sftNone }
  sftNoneName = 'sftNone';
   { ��������� ������������� ����������������� ���� "�������������� � �������� ����������" }
  sftNone = TvcmUserType(0);
   { �������������� � �������� ���������� }

implementation

{$If not defined(NoScripts)}
type
  Tkw_FormUserType_sftNone = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� sftNone }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_sftNone
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_FormUserType_sftNone

class function Tkw_FormUserType_sftNone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::sftNone';
end;//Tkw_FormUserType_sftNone.GetWordNameForRegister

function Tkw_FormUserType_sftNone.GetInteger: Integer;
 {-}
begin
 Result := sftNone;
end;//Tkw_FormUserType_sftNone.GetInteger

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� Tkw_FormUserType_sftNone
 Tkw_FormUserType_sftNone.RegisterInEngine;
{$IfEnd} //not NoScripts

end.