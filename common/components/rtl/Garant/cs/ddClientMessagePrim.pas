unit ddClientMessagePrim;

// Модуль: "w:\common\components\rtl\Garant\cs\ddClientMessagePrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddClientMessagePrim" MUID: (53B24355031B)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csRequestTask
 , evdTaskTypes
 , k2Base
 , daTypes
;

type
 TddClientMessagePrim = class(TddRequestTask)
  protected
   function pm_GetNotifyType: TCsNotificationType;
   procedure pm_SetNotifyType(aValue: TCsNotificationType);
   function pm_GetData: Integer;
   procedure pm_SetData(aValue: Integer);
   function pm_GetText: AnsiString;
   procedure pm_SetText(const aValue: AnsiString);
  public
   constructor Create(aUserID: TdaUserID); override;
   class function GetTaggedDataType: Tk2Type; override;
  public
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
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , ClientMessage_Const
 //#UC START# *53B24355031Bimpl_uses*
 //#UC END# *53B24355031Bimpl_uses*
;

function TddClientMessagePrim.pm_GetNotifyType: TCsNotificationType;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TCsNotificationType(TaggedData.IntA[k2_attrNotifyType]);
end;//TddClientMessagePrim.pm_GetNotifyType

procedure TddClientMessagePrim.pm_SetNotifyType(aValue: TCsNotificationType);
begin
 TaggedData.IntW[k2_attrNotifyType, nil] := Ord(aValue);
end;//TddClientMessagePrim.pm_SetNotifyType

function TddClientMessagePrim.pm_GetData: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrData]);
end;//TddClientMessagePrim.pm_GetData

procedure TddClientMessagePrim.pm_SetData(aValue: Integer);
begin
 TaggedData.IntW[k2_attrData, nil] := (aValue);
end;//TddClientMessagePrim.pm_SetData

function TddClientMessagePrim.pm_GetText: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrText]);
end;//TddClientMessagePrim.pm_GetText

procedure TddClientMessagePrim.pm_SetText(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrText, nil] := (aValue);
end;//TddClientMessagePrim.pm_SetText

constructor TddClientMessagePrim.Create(aUserID: TdaUserID);
//#UC START# *53B3D8A8011F_53B24355031B_var*
//#UC END# *53B3D8A8011F_53B24355031B_var*
begin
//#UC START# *53B3D8A8011F_53B24355031B_impl*
 inherited;
 //TaskType := cs_ttClientMessage;
//#UC END# *53B3D8A8011F_53B24355031B_impl*
end;//TddClientMessagePrim.Create

class function TddClientMessagePrim.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typClientMessage;
end;//TddClientMessagePrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
