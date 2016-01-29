unit csUserDefinedExportTaskPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "cs"
// ������: "w:/common/components/rtl/Garant/cs/csUserDefinedExportTaskPrim.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Tasks::TcsUserDefinedExportTaskPrim
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
  csProcessTask,
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TcsUserDefinedExportTaskPrim = class(TddProcessTask)
 protected
 // property methods
   function pm_GetQueryFile: AnsiString;
   procedure pm_SetQueryFile(const aValue: AnsiString);
   function pm_GetTimeToRun: TDateTime;
   procedure pm_SetTimeToRun(aValue: TDateTime);
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property QueryFile: AnsiString
     read pm_GetQueryFile
     write pm_SetQueryFile;
   property TimeToRun: TDateTime
     read pm_GetTimeToRun
     write pm_SetTimeToRun;
 end;//TcsUserDefinedExportTaskPrim
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  UserDefinedExportTask_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TcsUserDefinedExportTaskPrim

function TcsUserDefinedExportTaskPrim.pm_GetQueryFile: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrQueryFile]);
end;//TcsUserDefinedExportTaskPrim.pm_GetQueryFile

procedure TcsUserDefinedExportTaskPrim.pm_SetQueryFile(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrQueryFile, nil] := (aValue);
end;//TcsUserDefinedExportTaskPrim.pm_SetQueryFile

function TcsUserDefinedExportTaskPrim.pm_GetTimeToRun: TDateTime;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.DateTimeA[k2_attrTimeToRun]);
end;//TcsUserDefinedExportTaskPrim.pm_GetTimeToRun

procedure TcsUserDefinedExportTaskPrim.pm_SetTimeToRun(aValue: TDateTime);
 {-}
begin
 TaggedData.DateTimeW[k2_attrTimeToRun, nil] := (aValue);
end;//TcsUserDefinedExportTaskPrim.pm_SetTimeToRun

class function TcsUserDefinedExportTaskPrim.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typUserDefinedExportTask;
end;//TcsUserDefinedExportTaskPrim.GetTaggedDataType

{$IfEnd} //not Nemesis

end.