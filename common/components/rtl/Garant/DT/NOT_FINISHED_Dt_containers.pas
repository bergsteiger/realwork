unit NOT_FINISHED_Dt_containers;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DT"
// ������: "w:/common/components/rtl/Garant/DT/NOT_FINISHED_Dt_containers.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::DT::Containers::Dt_containers
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\DT\DtDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3ProtoObject,
  dtNumRangeList
  ;

type
 TNumSet = class(Tl3ProtoObject)
 private
 // private fields
   f_Ranges : TdtNumRangeList;
 end;//TNumSet
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
{$IfEnd} //not Nemesis
end.