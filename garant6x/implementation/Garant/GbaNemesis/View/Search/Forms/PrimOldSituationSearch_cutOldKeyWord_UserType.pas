unit PrimOldSituationSearch_cutOldKeyWord_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimOldSituationSearch_cutOldKeyWord_UserType.pas"
// �����: 28.10.2009 20:45
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 �������� ����������::Search::View::Search::PrimOldSituationSearch::cutOldKeyWord
//
// ����� �� ��������
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
   { ��������� ��� ���� ����� cutOldKeyWord }
  cutOldKeyWordName = 'cutOldKeyWord';
   { ��������� ������������� ����������������� ���� "����� �� ��������" }
  cutOldKeyWord = TvcmUserType(0);
   { ����� �� �������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_cutOldKeyWord = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� cutOldKeyWord }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_cutOldKeyWord
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_cutOldKeyWord

class function Tkw_FormUserType_cutOldKeyWord.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::cutOldKeyWord';
end;//Tkw_FormUserType_cutOldKeyWord.GetWordNameForRegister

function Tkw_FormUserType_cutOldKeyWord.GetInteger: Integer;
 {-}
begin
 Result := cutOldKeyWord;
end;//Tkw_FormUserType_cutOldKeyWord.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_cutOldKeyWord
 Tkw_FormUserType_cutOldKeyWord.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.