unit NOT_FINISHED_vtShockwaveFlashEx;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VT"
// �����: ������� �.�.
// ������: "w:/common/components/gui/Garant/VT/NOT_FINISHED_vtShockwaveFlashEx.pas"
// �����: 2005/09/29 10:12:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VT::Flash::TvtShockwaveFlashEx
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\VT\vtDefine.inc}

interface

{$If not defined(NoFlash)}
type
 TvtShockwaveFlashEx = class
 end;//TvtShockwaveFlashEx
{$IfEnd} //not NoFlash

implementation

{$If not defined(NoFlash)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  vtFlashWordsPack
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not NoFlash

{$If not defined(NoFlash)}


{$IfEnd} //not NoFlash

initialization
{$If not defined(NoFlash) AND not defined(NoScripts)}
// ����������� TvtShockwaveFlashEx
 TtfwClassRef.Register(TvtShockwaveFlashEx);
{$IfEnd} //not NoFlash AND not NoScripts

end.