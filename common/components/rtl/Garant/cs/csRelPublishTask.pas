unit csRelPublishTask;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "cs"
// ������: "w:/common/components/rtl/Garant/cs/csRelPublishTask.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Tasks::TcsRelPublishTask
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
  csImport,
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TcsRelPublishTask = class(TcsImportTaskItem)
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 end;//TcsRelPublishTask
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  RelPublishTask_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TcsRelPublishTask

class function TcsRelPublishTask.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typRelPublishTask;
end;//TcsRelPublishTask.GetTaggedDataType

{$IfEnd} //not Nemesis

end.