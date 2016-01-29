unit csTaskResult;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csTaskResult.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EVD::TasksTuning::TcsTaskResult
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  l3Variant,
  Classes,
  k2Base
  ;

type
 TcsTaskResultClass = class of TcsTaskResult;

 _evdTagHolder_Parent_ = Tl3Tag;
 {$Include ..\EVD\evdTagHolder.imp.pas}
 TcsTaskResult = class(_evdTagHolder_)
 protected
 // property methods
   function pm_GetTaskID: AnsiString;
   procedure pm_SetTaskID(const aValue: AnsiString);
 public
 // realized methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property TaskID: AnsiString
     read pm_GetTaskID
     write pm_SetTaskID;
 end;//TcsTaskResult

implementation

uses
  TaskResult_Const,
  evdNativeWriter,
  l3Filer,
  l3Types,
  k2TagGen,
  evdNativeReader,
  k2DocumentBuffer,
  SysUtils
  ;

{$Include ..\EVD\evdTagHolder.imp.pas}

// start class TcsTaskResult

function TcsTaskResult.pm_GetTaskID: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrTaskID]);
end;//TcsTaskResult.pm_GetTaskID

procedure TcsTaskResult.pm_SetTaskID(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrTaskID, nil] := (aValue);
end;//TcsTaskResult.pm_SetTaskID

class function TcsTaskResult.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typTaskResult;
end;//TcsTaskResult.GetTaggedDataType

end.