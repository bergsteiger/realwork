unit PrimTreeAttributeSelect_astFirstLevel_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/Forms/PrimTreeAttributeSelect_astFirstLevel_UserType.pas"
// �����: 27.01.2009 11:56
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ������� ����������� ���������� �������::SearchLite::View::LiteSearch::PrimTreeAttributeSelect::astFirstLevel
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
  PrimTreeAttributeSelect_astOneLevel_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� astFirstLevel }
  astFirstLevelName = 'astFirstLevel';
   { ��������� ������������� ����������������� ���� "�������� ������� ������" }
  astFirstLevel = TvcmUserType(astOneLevel + 1);
   { �������� ������� ������ }

implementation

{$If not defined(NoScripts)}
type
  Tkw_FormUserType_astFirstLevel = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� astFirstLevel }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_astFirstLevel
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_FormUserType_astFirstLevel

class function Tkw_FormUserType_astFirstLevel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::astFirstLevel';
end;//Tkw_FormUserType_astFirstLevel.GetWordNameForRegister

function Tkw_FormUserType_astFirstLevel.GetInteger: Integer;
 {-}
begin
 Result := astFirstLevel;
end;//Tkw_FormUserType_astFirstLevel.GetInteger

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� Tkw_FormUserType_astFirstLevel
 Tkw_FormUserType_astFirstLevel.RegisterInEngine;
{$IfEnd} //not NoScripts

end.