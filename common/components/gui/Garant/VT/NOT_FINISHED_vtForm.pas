unit NOT_FINISHED_vtForm;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VT"
// ������: "w:/common/components/gui/Garant/VT/NOT_FINISHED_vtForm.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VT::vtCommon::vtForm
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\VT\vtDefine.inc}

interface

uses
  l3Forms
  ;

type
 TvtForm = class(Tl3Form)
 end;//TvtForm

implementation

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;


initialization
{$If not defined(NoScripts)}
// ����������� TvtForm
 TtfwClassRef.Register(TvtForm);
{$IfEnd} //not NoScripts

end.