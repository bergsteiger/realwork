unit ddTaskResultRequestPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "cs"
// ������: "w:/common/components/rtl/Garant/cs/ddTaskResultRequestPrim.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Tasks::TddTaskResultRequestPrim
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
  askRequest,
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TddTaskResultRequestPrim = class(TaskRequest)
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 end;//TddTaskResultRequestPrim
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  TaskResultRequest_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TddTaskResultRequestPrim

class function TddTaskResultRequestPrim.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typTaskResultRequest;
end;//TddTaskResultRequestPrim.GetTaggedDataType

{$IfEnd} //not Nemesis

end.