unit PrimAttributeSelect_utSingleSearch_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/Forms/PrimAttributeSelect_utSingleSearch_UserType.pas"
// �����: 27.01.2009 15:22
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ������� ����������� ���������� �������::SearchLite::View::LiteSearch::PrimAttributeSelect::utSingleSearch
//
// ��������� �����
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
  PrimAttributeSelect_utAttributeSelect_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� utSingleSearch }
  utSingleSearchName = 'utSingleSearch';
   { ��������� ������������� ����������������� ���� "��������� �����" }
  utSingleSearch = TvcmUserType(utAttributeSelect + 1);
   { ��������� ����� }

implementation

{$If not defined(NoScripts)}
type
  Tkw_FormUserType_utSingleSearch = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utSingleSearch }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utSingleSearch
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_FormUserType_utSingleSearch

class function Tkw_FormUserType_utSingleSearch.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utSingleSearch';
end;//Tkw_FormUserType_utSingleSearch.GetWordNameForRegister

function Tkw_FormUserType_utSingleSearch.GetInteger: Integer;
 {-}
begin
 Result := utSingleSearch;
end;//Tkw_FormUserType_utSingleSearch.GetInteger

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� Tkw_FormUserType_utSingleSearch
 Tkw_FormUserType_utSingleSearch.RegisterInEngine;
{$IfEnd} //not NoScripts

end.