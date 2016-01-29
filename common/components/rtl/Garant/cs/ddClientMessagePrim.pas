unit ddClientMessagePrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ddClientMessagePrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Tasks::TddClientMessagePrim
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
  csRequestTask,
  evdTaskTypes,
  k2Base,
  dt_Types
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TddClientMessagePrim = class(TddRequestTask)
 protected
 // property methods
   function pm_GetNotifyType: TCsNotificationType;
   procedure pm_SetNotifyType(aValue: TCsNotificationType);
   function pm_GetData: Integer;
   procedure pm_SetData(aValue: Integer);
   function pm_GetText: AnsiString;
   procedure pm_SetText(const aValue: AnsiString);
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // overridden public methods
   constructor Create(aUserID: TUserID); override;
 public
 // public properties
   property NotifyType: TCsNotificationType
     read pm_GetNotifyType
     write pm_SetNotifyType;
   property Data: Integer
     read pm_GetData
     write pm_SetData;
   property Text: AnsiString
     read pm_GetText
     write pm_SetText;
 end;//TddClientMessagePrim
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  ClientMessage_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TddClientMessagePrim

function TddClientMessagePrim.pm_GetNotifyType: TCsNotificationType;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TCsNotificationType(TaggedData.IntA[k2_attrNotifyType]);
end;//TddClientMessagePrim.pm_GetNotifyType

procedure TddClientMessagePrim.pm_SetNotifyType(aValue: TCsNotificationType);
 {-}
begin
 TaggedData.IntW[k2_attrNotifyType, nil] := Ord(aValue);
end;//TddClientMessagePrim.pm_SetNotifyType

function TddClientMessagePrim.pm_GetData: Integer;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrData]);
end;//TddClientMessagePrim.pm_GetData

procedure TddClientMessagePrim.pm_SetData(aValue: Integer);
 {-}
begin
 TaggedData.IntW[k2_attrData, nil] := (aValue);
end;//TddClientMessagePrim.pm_SetData

function TddClientMessagePrim.pm_GetText: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrText]);
end;//TddClientMessagePrim.pm_GetText

procedure TddClientMessagePrim.pm_SetText(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrText, nil] := (aValue);
end;//TddClientMessagePrim.pm_SetText

class function TddClientMessagePrim.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typClientMessage;
end;//TddClientMessagePrim.GetTaggedDataType

constructor TddClientMessagePrim.Create(aUserID: TUserID);
//#UC START# *53B3D8A8011F_53B24355031B_var*
//#UC END# *53B3D8A8011F_53B24355031B_var*
begin
//#UC START# *53B3D8A8011F_53B24355031B_impl*
 inherited;
 //TaskType := cs_ttClientMessage;
//#UC END# *53B3D8A8011F_53B24355031B_impl*
end;//TddClientMessagePrim.Create

{$IfEnd} //not Nemesis

end.