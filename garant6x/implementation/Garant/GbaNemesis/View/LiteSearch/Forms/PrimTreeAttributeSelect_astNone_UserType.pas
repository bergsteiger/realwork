unit PrimTreeAttributeSelect_astNone_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/Forms/PrimTreeAttributeSelect_astNone_UserType.pas"
// �����: 27.01.2009 11:56
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ������� ����������� ���������� �������::SearchLite::View::LiteSearch::PrimTreeAttributeSelect::astNone
//
// �����: ����� ���������
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
   { ��������� ��� ���� ����� astNone }
  astNoneName = 'astNone';
   { ��������� ������������� ����������������� ���� "�����: ����� ���������" }
  astNone = TvcmUserType(0);
   { �����: ����� ��������� }

implementation

{$If not defined(NoScripts)}
type
  Tkw_FormUserType_astNone = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� astNone }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_astNone
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_FormUserType_astNone

class function Tkw_FormUserType_astNone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::astNone';
end;//Tkw_FormUserType_astNone.GetWordNameForRegister

function Tkw_FormUserType_astNone.GetInteger: Integer;
 {-}
begin
 Result := astNone;
end;//Tkw_FormUserType_astNone.GetInteger

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� Tkw_FormUserType_astNone
 Tkw_FormUserType_astNone.RegisterInEngine;
{$IfEnd} //not NoScripts

end.