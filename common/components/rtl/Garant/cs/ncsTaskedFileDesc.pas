unit ncsTaskedFileDesc;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsTaskedFileDesc.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ResultDelivery::TncsTaskedFileDesc
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  ncsFileDesc,
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsTaskedFileDesc = class(TncsFileDesc)
 protected
 // property methods
   function pm_GetTaskID: AnsiString;
   procedure pm_SetTaskID(const aValue: AnsiString);
   function pm_GetCopiedSize: Int64;
   procedure pm_SetCopiedSize(aValue: Int64);
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property TaskID: AnsiString
     read pm_GetTaskID
     write pm_SetTaskID;
   property CopiedSize: Int64
     read pm_GetCopiedSize
     write pm_SetCopiedSize;
 end;//TncsTaskedFileDesc
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  TaskedFileDesc_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsTaskedFileDesc

function TncsTaskedFileDesc.pm_GetTaskID: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrTaskID]);
end;//TncsTaskedFileDesc.pm_GetTaskID

procedure TncsTaskedFileDesc.pm_SetTaskID(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrTaskID, nil] := (aValue);
end;//TncsTaskedFileDesc.pm_SetTaskID

function TncsTaskedFileDesc.pm_GetCopiedSize: Int64;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.Int64A[k2_attrCopiedSize]);
end;//TncsTaskedFileDesc.pm_GetCopiedSize

procedure TncsTaskedFileDesc.pm_SetCopiedSize(aValue: Int64);
 {-}
begin
 TaggedData.Int64W[k2_attrCopiedSize, nil] := (aValue);
end;//TncsTaskedFileDesc.pm_SetCopiedSize

class function TncsTaskedFileDesc.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typTaskedFileDesc;
end;//TncsTaskedFileDesc.GetTaggedDataType

{$IfEnd} //not Nemesis

end.