unit NOT_FINISHED_DT_DbInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DT"
// ������: "w:/common/components/rtl/Garant/DT/NOT_FINISHED_DT_DbInfo.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::DT::DbInfo::DT_DbInfo
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
  dtFamilyInfoList
  ;

type
 TDbInfo = class(Tl3ProtoObject)
 private
 // private fields
   f_FamiliesData : TdtFamilyInfoList;
 end;//TDbInfo
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
{$IfEnd} //not Nemesis
end.