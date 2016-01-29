unit ncsServiceProviderParams;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "cs"
// ������: "w:/common/components/rtl/Garant/cs/ncsServiceProviderParams.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ClientSide::TncsServiceProviderParams
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3ProtoObject
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsServiceProviderParams = class(Tl3ProtoObject)
 private
 // private fields
   f_ServerHostName : AnsiString;
    {* ���� ��� �������� ServerHostName}
   f_ServerPort : Integer;
    {* ���� ��� �������� ServerPort}
   f_Login : AnsiString;
    {* ���� ��� �������� Login}
   f_Password : AnsiString;
    {* ���� ��� �������� Password}
   f_IsDeveloper : Boolean;
    {* ���� ��� �������� IsDeveloper}
   f_StandAlone : Boolean;
    {* ���� ��� �������� StandAlone}
 public
 // public properties
   property ServerHostName: AnsiString
     read f_ServerHostName
     write f_ServerHostName;
   property ServerPort: Integer
     read f_ServerPort
     write f_ServerPort;
   property Login: AnsiString
     read f_Login
     write f_Login;
   property Password: AnsiString
     read f_Password
     write f_Password;
   property IsDeveloper: Boolean
     read f_IsDeveloper
     write f_IsDeveloper;
   property StandAlone: Boolean
     read f_StandAlone
     write f_StandAlone;
 end;//TncsServiceProviderParams
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}


{$IfEnd} //not Nemesis
end.