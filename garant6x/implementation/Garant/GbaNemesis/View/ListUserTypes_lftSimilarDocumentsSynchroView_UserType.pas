unit ListUserTypes_lftSimilarDocumentsSynchroView_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListUserTypes_lftSimilarDocumentsSynchroView_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ListUserTypes::lftSimilarDocumentsSynchroView
//
// ���������� �������� (������� ���������)
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
  ,
  ListUserTypes_lftSimilarDocuments_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� lftSimilarDocumentsSynchroView }
  lftSimilarDocumentsSynchroViewName = 'lftSimilarDocumentsSynchroView';
   { ��������� ������������� ����������������� ���� "���������� �������� (������� ���������)" }
  lftSimilarDocumentsSynchroView = TvcmUserType(lftSimilarDocuments + 1);
   { ���������� �������� (������� ���������) }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_lftSimilarDocumentsSynchroView = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� lftSimilarDocumentsSynchroView }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_lftSimilarDocumentsSynchroView
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_lftSimilarDocumentsSynchroView

class function Tkw_FormUserType_lftSimilarDocumentsSynchroView.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::lftSimilarDocumentsSynchroView';
end;//Tkw_FormUserType_lftSimilarDocumentsSynchroView.GetWordNameForRegister

function Tkw_FormUserType_lftSimilarDocumentsSynchroView.GetInteger: Integer;
 {-}
begin
 Result := lftSimilarDocumentsSynchroView;
end;//Tkw_FormUserType_lftSimilarDocumentsSynchroView.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_lftSimilarDocumentsSynchroView
 Tkw_FormUserType_lftSimilarDocumentsSynchroView.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.