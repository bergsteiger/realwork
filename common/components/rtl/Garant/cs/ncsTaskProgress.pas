unit ncsTaskProgress;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsTaskProgress.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ResultDelivery::TncsTaskProgress
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
  ncsMessage,
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsTaskProgress = class(TncsMessage)
 protected
 // property methods
   function pm_GetTaskID: AnsiString;
   procedure pm_SetTaskID(const aValue: AnsiString);
   function pm_GetDescription: AnsiString;
   procedure pm_SetDescription(const aValue: AnsiString);
   function pm_GetPercent: Integer;
   procedure pm_SetPercent(aValue: Integer);
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property TaskID: AnsiString
     read pm_GetTaskID
     write pm_SetTaskID;
   property Description: AnsiString
     read pm_GetDescription
     write pm_SetDescription;
   property Percent: Integer
     read pm_GetPercent
     write pm_SetPercent;
 end;//TncsTaskProgress
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  csTaskProgress_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsTaskProgress

function TncsTaskProgress.pm_GetTaskID: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrTaskID]);
end;//TncsTaskProgress.pm_GetTaskID

procedure TncsTaskProgress.pm_SetTaskID(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrTaskID, nil] := (aValue);
end;//TncsTaskProgress.pm_SetTaskID

function TncsTaskProgress.pm_GetDescription: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrDescription]);
end;//TncsTaskProgress.pm_GetDescription

procedure TncsTaskProgress.pm_SetDescription(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrDescription, nil] := (aValue);
end;//TncsTaskProgress.pm_SetDescription

function TncsTaskProgress.pm_GetPercent: Integer;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrPercent]);
end;//TncsTaskProgress.pm_GetPercent

procedure TncsTaskProgress.pm_SetPercent(aValue: Integer);
 {-}
begin
 TaggedData.IntW[k2_attrPercent, nil] := (aValue);
end;//TncsTaskProgress.pm_SetPercent

class function TncsTaskProgress.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typcsTaskProgress;
end;//TncsTaskProgress.GetTaggedDataType

{$IfEnd} //not Nemesis

end.