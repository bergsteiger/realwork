unit csUserDefinedExportTaskPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\csUserDefinedExportTaskPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsUserDefinedExportTaskPrim" MUID: (53B26E1A01A6)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , k2Base
;

type
 TcsUserDefinedExportTaskPrim = class(TddProcessTask)
  protected
   function pm_GetQueryFile: AnsiString;
   procedure pm_SetQueryFile(const aValue: AnsiString);
   function pm_GetTimeToRun: TDateTime;
   procedure pm_SetTimeToRun(aValue: TDateTime);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property QueryFile: AnsiString
    read pm_GetQueryFile
    write pm_SetQueryFile;
   property TimeToRun: TDateTime
    read pm_GetTimeToRun
    write pm_SetTimeToRun;
 end;//TcsUserDefinedExportTaskPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , UserDefinedExportTask_Const
;

function TcsUserDefinedExportTaskPrim.pm_GetQueryFile: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrQueryFile]);
end;//TcsUserDefinedExportTaskPrim.pm_GetQueryFile

procedure TcsUserDefinedExportTaskPrim.pm_SetQueryFile(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrQueryFile, nil] := (aValue);
end;//TcsUserDefinedExportTaskPrim.pm_SetQueryFile

function TcsUserDefinedExportTaskPrim.pm_GetTimeToRun: TDateTime;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.DateTimeA[k2_attrTimeToRun]);
end;//TcsUserDefinedExportTaskPrim.pm_GetTimeToRun

procedure TcsUserDefinedExportTaskPrim.pm_SetTimeToRun(aValue: TDateTime);
begin
 TaggedData.DateTimeW[k2_attrTimeToRun, nil] := (aValue);
end;//TcsUserDefinedExportTaskPrim.pm_SetTimeToRun

class function TcsUserDefinedExportTaskPrim.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typUserDefinedExportTask;
end;//TcsUserDefinedExportTaskPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
