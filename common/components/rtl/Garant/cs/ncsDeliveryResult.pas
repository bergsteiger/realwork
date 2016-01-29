unit ncsDeliveryResult;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsDeliveryResult.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ResultDelivery::TncsDeliveryResult
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
  evdNcsTypes,
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsDeliveryResult = class(TncsMessage)
 protected
 // property methods
   function pm_GetTaskID: AnsiString;
   procedure pm_SetTaskID(const aValue: AnsiString);
   function pm_GetResultKind: TncsResultKind;
   procedure pm_SetResultKind(aValue: TncsResultKind);
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property TaskID: AnsiString
     read pm_GetTaskID
     write pm_SetTaskID;
   property ResultKind: TncsResultKind
     read pm_GetResultKind
     write pm_SetResultKind;
 end;//TncsDeliveryResult
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  csDeliveryResult_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsDeliveryResult

function TncsDeliveryResult.pm_GetTaskID: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrTaskID]);
end;//TncsDeliveryResult.pm_GetTaskID

procedure TncsDeliveryResult.pm_SetTaskID(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrTaskID, nil] := (aValue);
end;//TncsDeliveryResult.pm_SetTaskID

function TncsDeliveryResult.pm_GetResultKind: TncsResultKind;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TncsResultKind(TaggedData.IntA[k2_attrResultKind]);
end;//TncsDeliveryResult.pm_GetResultKind

procedure TncsDeliveryResult.pm_SetResultKind(aValue: TncsResultKind);
 {-}
begin
 TaggedData.IntW[k2_attrResultKind, nil] := Ord(aValue);
end;//TncsDeliveryResult.pm_SetResultKind

class function TncsDeliveryResult.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typcsDeliveryResult;
end;//TncsDeliveryResult.GetTaggedDataType

{$IfEnd} //not Nemesis

end.