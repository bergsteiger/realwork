unit PrimAttributeSelect_utAttributeSelect_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/Forms/PrimAttributeSelect_utAttributeSelect_UserType.pas"
// �����: 27.01.2009 15:22
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ������� ����������� ���������� �������::SearchLite::View::LiteSearch::PrimAttributeSelect::utAttributeSelect
//
// ����� �������� ��������
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
   { ��������� ��� ���� ����� utAttributeSelect }
  utAttributeSelectName = 'utAttributeSelect';
   { ��������� ������������� ����������������� ���� "����� �������� ��������" }
  utAttributeSelect = TvcmUserType(0);
   { ����� �������� �������� }

implementation

{$If not defined(NoScripts)}
type
  Tkw_FormUserType_utAttributeSelect = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utAttributeSelect }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utAttributeSelect
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_FormUserType_utAttributeSelect

class function Tkw_FormUserType_utAttributeSelect.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utAttributeSelect';
end;//Tkw_FormUserType_utAttributeSelect.GetWordNameForRegister

function Tkw_FormUserType_utAttributeSelect.GetInteger: Integer;
 {-}
begin
 Result := utAttributeSelect;
end;//Tkw_FormUserType_utAttributeSelect.GetInteger

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� Tkw_FormUserType_utAttributeSelect
 Tkw_FormUserType_utAttributeSelect.RegisterInEngine;
{$IfEnd} //not NoScripts

end.