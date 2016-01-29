unit ncsGetTaskDescription;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsGetTaskDescription.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ResultDelivery::TncsGetTaskDescription
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
 TncsGetTaskDescription = class(TncsMessage)
 protected
 // property methods
   function pm_GetTaskID: AnsiString;
   procedure pm_SetTaskID(const aValue: AnsiString);
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property TaskID: AnsiString
     read pm_GetTaskID
     write pm_SetTaskID;
 end;//TncsGetTaskDescription
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  csGetTaskDescription_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsGetTaskDescription

function TncsGetTaskDescription.pm_GetTaskID: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrTaskID]);
end;//TncsGetTaskDescription.pm_GetTaskID

procedure TncsGetTaskDescription.pm_SetTaskID(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrTaskID, nil] := (aValue);
end;//TncsGetTaskDescription.pm_SetTaskID

class function TncsGetTaskDescription.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typcsGetTaskDescription;
end;//TncsGetTaskDescription.GetTaggedDataType

{$IfEnd} //not Nemesis

end.