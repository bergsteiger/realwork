unit PrimSelectedAttributes_utSelectedAttributes_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/Forms/PrimSelectedAttributes_utSelectedAttributes_UserType.pas"
// �����: 27.01.2009 11:20
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ������� ����������� ���������� �������::SearchLite::View::LiteSearch::PrimSelectedAttributes::utSelectedAttributes
//
// �����: ��������� �������� ���������
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
   { ��������� ��� ���� ����� utSelectedAttributes }
  utSelectedAttributesName = 'utSelectedAttributes';
   { ��������� ������������� ����������������� ���� "�����: ��������� �������� ���������" }
  utSelectedAttributes = TvcmUserType(0);
   { �����: ��������� �������� ��������� }

implementation

{$If not defined(NoScripts)}
type
  Tkw_FormUserType_utSelectedAttributes = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utSelectedAttributes }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utSelectedAttributes
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_FormUserType_utSelectedAttributes

class function Tkw_FormUserType_utSelectedAttributes.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utSelectedAttributes';
end;//Tkw_FormUserType_utSelectedAttributes.GetWordNameForRegister

function Tkw_FormUserType_utSelectedAttributes.GetInteger: Integer;
 {-}
begin
 Result := utSelectedAttributes;
end;//Tkw_FormUserType_utSelectedAttributes.GetInteger

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� Tkw_FormUserType_utSelectedAttributes
 Tkw_FormUserType_utSelectedAttributes.RegisterInEngine;
{$IfEnd} //not NoScripts

end.