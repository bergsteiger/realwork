unit dtFamilyInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DT"
// ������: "w:/common/components/rtl/Garant/DT/dtFamilyInfo.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::DT::DbInfo::TdtFamilyInfo
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\DT\DtDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3ProtoObject
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TdtFamilyInfo = class(Tl3ProtoObject)
 public
 // public fields
   Number : Integer;
   Name : AnsiString;
   Path : AnsiString;
   DocGroup : Integer;
   Attributes : Integer;
 end;//TdtFamilyInfo
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}


{$IfEnd} //not Nemesis
end.