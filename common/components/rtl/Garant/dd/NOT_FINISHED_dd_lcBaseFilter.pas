unit NOT_FINISHED_dd_lcBaseFilter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "dd"
// ������: "w:/common/components/rtl/Garant/dd/NOT_FINISHED_dd_lcBaseFilter.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::dd::Filters::dd_lcBaseFilter
//
// ������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  evdLeafParaFilter,
  k2TagFilter,
  ddHeaderFilter
  ;

type
 Tdd_lcParaFilter = class(TevdLeafParaFilter)
 end;//Tdd_lcParaFilter

 Tdd_lcBaseFilter = class(Tk2TagFilter)
 end;//Tdd_lcBaseFilter

 Tdd_lcSynoFilter = class(Tdd_lcBaseFilter)
 end;//Tdd_lcSynoFilter

 Tdd_lcBaseHeaderFilter = class(TddHeaderFilter)
 end;//Tdd_lcBaseHeaderFilter

implementation

end.