unit daGUITypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DA"
// ������: "w:/common/components/rtl/Garant/DA/daGUITypes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi For Archi::DA::daGUITypes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\DA\daDefine.inc}

interface

uses
  ddAppConfig
  ;

type
 TBuildConfigProc = procedure (aConfig: TddAppConfiguration;
  const aProviderKey: AnsiString = '';
  ForInfoOnly: Boolean = False) of object;

implementation

end.