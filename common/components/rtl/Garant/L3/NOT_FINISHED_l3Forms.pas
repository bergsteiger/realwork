unit NOT_FINISHED_l3Forms;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3$Visual"
// ������: "w:/common/components/rtl/Garant/L3/NOT_FINISHED_l3Forms.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::L3$Visual::VCL::l3Forms
//
// ������� ����� ����, �������������� ������� ������ � ��������� IUnknown
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3PureMixIns,
  l3IID,
  l3Interfaces
  ;

type
 _l3Unknown_Parent_ = TForm;
 {$Include ..\L3\l3Unknown.imp.pas}
 _l3COMQueryInterface_Parent_ = _l3Unknown_;
 {$Include ..\L3\l3COMQueryInterface.imp.pas}
 Tl3Form = class(_l3COMQueryInterface_)
  {* ������� ����� ����, �������������� ������� ������ � ��������� IUnknown }
 end;//Tl3Form

implementation

uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3Base,
  l3Core,
  Windows,
  l3MemUtils,
  l3Interlocked,
  l3InterfacesMisc
  ;

{$Include ..\L3\l3Unknown.imp.pas}

{$Include ..\L3\l3COMQueryInterface.imp.pas}


initialization
{$If not defined(NoScripts)}
// ����������� Tl3Form
 TtfwClassRef.Register(Tl3Form);
{$IfEnd} //not NoScripts

end.