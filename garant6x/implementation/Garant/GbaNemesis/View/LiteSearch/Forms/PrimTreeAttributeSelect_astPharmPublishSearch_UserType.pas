unit PrimTreeAttributeSelect_astPharmPublishSearch_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/Forms/PrimTreeAttributeSelect_astPharmPublishSearch_UserType.pas"
// �����: 27.01.2009 11:56
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ������� ����������� ���������� �������::SearchLite::View::LiteSearch::PrimTreeAttributeSelect::astPharmPublishSearch
//
// ��� �� �������� � ���������������
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
  PrimTreeAttributeSelect_astTaxesPublishSearch_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� astPharmPublishSearch }
  astPharmPublishSearchName = 'astPharmPublishSearch';
   { ��������� ������������� ����������������� ���� "��� �� �������� � ���������������" }
  astPharmPublishSearch = TvcmUserType(astTaxesPublishSearch + 1);
   { ��� �� �������� � ��������������� }

implementation

{$If not defined(NoScripts)}
type
  Tkw_FormUserType_astPharmPublishSearch = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� astPharmPublishSearch }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_astPharmPublishSearch
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_FormUserType_astPharmPublishSearch

class function Tkw_FormUserType_astPharmPublishSearch.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::astPharmPublishSearch';
end;//Tkw_FormUserType_astPharmPublishSearch.GetWordNameForRegister

function Tkw_FormUserType_astPharmPublishSearch.GetInteger: Integer;
 {-}
begin
 Result := astPharmPublishSearch;
end;//Tkw_FormUserType_astPharmPublishSearch.GetInteger

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� Tkw_FormUserType_astPharmPublishSearch
 Tkw_FormUserType_astPharmPublishSearch.RegisterInEngine;
{$IfEnd} //not NoScripts

end.