unit PrimTreeAttributeSelect_astTaxesPublishSearch_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/Forms/PrimTreeAttributeSelect_astTaxesPublishSearch_UserType.pas"
// �����: 27.01.2009 11:56
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ������� ����������� ���������� �������::SearchLite::View::LiteSearch::PrimTreeAttributeSelect::astTaxesPublishSearch
//
// ��� �� ������� � ��������
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
  PrimTreeAttributeSelect_astNone_UserType,
  PrimTreeAttributeSelect_astFirstLevel_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� astTaxesPublishSearch }
  astTaxesPublishSearchName = 'astTaxesPublishSearch';
   { ��������� ������������� ����������������� ���� "��� �� ������� � ��������" }
  astTaxesPublishSearch = TvcmUserType(astFirstLevel + 1);
   { ��� �� ������� � �������� }

implementation

{$If not defined(NoScripts)}
type
  Tkw_FormUserType_astTaxesPublishSearch = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� astTaxesPublishSearch }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_astTaxesPublishSearch
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_FormUserType_astTaxesPublishSearch

class function Tkw_FormUserType_astTaxesPublishSearch.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::astTaxesPublishSearch';
end;//Tkw_FormUserType_astTaxesPublishSearch.GetWordNameForRegister

function Tkw_FormUserType_astTaxesPublishSearch.GetInteger: Integer;
 {-}
begin
 Result := astTaxesPublishSearch;
end;//Tkw_FormUserType_astTaxesPublishSearch.GetInteger

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� Tkw_FormUserType_astTaxesPublishSearch
 Tkw_FormUserType_astTaxesPublishSearch.RegisterInEngine;
{$IfEnd} //not NoScripts

end.