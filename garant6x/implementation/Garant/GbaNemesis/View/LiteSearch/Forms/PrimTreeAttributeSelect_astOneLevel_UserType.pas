unit PrimTreeAttributeSelect_astOneLevel_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/Forms/PrimTreeAttributeSelect_astOneLevel_UserType.pas"
// �����: 27.01.2009 11:56
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ������� ����������� ���������� �������::SearchLite::View::LiteSearch::PrimTreeAttributeSelect::astOneLevel
//
// �������� ������� ������
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
  ,
  PrimTreeAttributeSelect_astNone_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� astOneLevel }
  astOneLevelName = 'astOneLevel';
   { ��������� ������������� ����������������� ���� "�������� ������� ������" }
  astOneLevel = TvcmUserType(astNone + 1);
   { �������� ������� ������ }

implementation

{$If not defined(NoScripts)}
type
  Tkw_FormUserType_astOneLevel = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� astOneLevel }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_astOneLevel
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_FormUserType_astOneLevel

class function Tkw_FormUserType_astOneLevel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::astOneLevel';
end;//Tkw_FormUserType_astOneLevel.GetWordNameForRegister

function Tkw_FormUserType_astOneLevel.GetInteger: Integer;
 {-}
begin
 Result := astOneLevel;
end;//Tkw_FormUserType_astOneLevel.GetInteger

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� Tkw_FormUserType_astOneLevel
 Tkw_FormUserType_astOneLevel.RegisterInEngine;
{$IfEnd} //not NoScripts

end.