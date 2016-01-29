unit ddCaseCodeTaskPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "cs"
// ������: "w:/common/components/rtl/Garant/cs/ddCaseCodeTaskPrim.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Tasks::TddCaseCodeTaskPrim
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
  csExport,
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TddCaseCodeTaskPrim = class(TcsExport)
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 end;//TddCaseCodeTaskPrim
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  CaseCodeTask_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TddCaseCodeTaskPrim

class function TddCaseCodeTaskPrim.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typCaseCodeTask;
end;//TddCaseCodeTaskPrim.GetTaggedDataType

{$IfEnd} //not Nemesis

end.