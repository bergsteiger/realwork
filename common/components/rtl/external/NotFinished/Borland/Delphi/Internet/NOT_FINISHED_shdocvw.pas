unit NOT_FINISHED_shdocvw;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Internet"
// ������: "w:/common/components/rtl/external/NotFinished/Borland/Delphi/Internet/NOT_FINISHED_shdocvw.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Core::Internet::Web::shdocvw
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

interface

uses
  Classes
  {$If not defined(NoVCL)}
  ,
  OleCtrls
  {$IfEnd} //not NoVCL
  
  ;

type
 TWebBrowser = class(TOleControl)
 end;//TWebBrowser

implementation

uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;


initialization
{$If not defined(NoScripts)}
// ����������� TWebBrowser
 TtfwClassRef.Register(TWebBrowser);
{$IfEnd} //not NoScripts

end.