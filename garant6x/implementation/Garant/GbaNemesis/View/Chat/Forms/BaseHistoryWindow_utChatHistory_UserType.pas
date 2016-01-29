unit BaseHistoryWindow_utChatHistory_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: �������� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Chat/Forms/BaseHistoryWindow_utChatHistory_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ���������� ��������::Chat::View::Chat::BaseHistoryWindow::utChatHistory
//
// ������� ���������
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
   { ��������� ��� ���� ����� utChatHistory }
  utChatHistoryName = 'utChatHistory';
   { ��������� ������������� ����������������� ���� "������� ���������" }
  utChatHistory = TvcmUserType(0);
   { ������� ��������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utChatHistory = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utChatHistory }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utChatHistory
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utChatHistory

class function Tkw_FormUserType_utChatHistory.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utChatHistory';
end;//Tkw_FormUserType_utChatHistory.GetWordNameForRegister

function Tkw_FormUserType_utChatHistory.GetInteger: Integer;
 {-}
begin
 Result := utChatHistory;
end;//Tkw_FormUserType_utChatHistory.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_utChatHistory
 Tkw_FormUserType_utChatHistory.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.