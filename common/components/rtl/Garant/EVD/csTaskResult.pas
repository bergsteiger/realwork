unit csTaskResult;

// Модуль: "w:\common\components\rtl\Garant\EVD\csTaskResult.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsTaskResult" MUID: (53E0D4F50178)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , l3Variant
 , k2Base
 , Classes
;

type
 TcsTaskResultClass = class of TcsTaskResult;

 _evdTagHolder_Parent_ = Tl3Tag;
 {$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}
 TcsTaskResult = class(_evdTagHolder_)
  protected
   function pm_GetTaskID: AnsiString;
   procedure pm_SetTaskID(const aValue: AnsiString);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property TaskID: AnsiString
    read pm_GetTaskID
    write pm_SetTaskID;
 end;//TcsTaskResult

implementation

uses
 l3ImplUses
 , SysUtils
 , evdNativeWriter
 , l3Filer
 , l3Types
 , k2TagGen
 , evdNativeReader
 , k2DocumentBuffer
 , TaskResult_Const
;

{$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}

function TcsTaskResult.pm_GetTaskID: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrTaskID]);
end;//TcsTaskResult.pm_GetTaskID

procedure TcsTaskResult.pm_SetTaskID(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrTaskID, nil] := (aValue);
end;//TcsTaskResult.pm_SetTaskID

class function TcsTaskResult.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typTaskResult;
end;//TcsTaskResult.GetTaggedDataType

end.
