unit ncsTaskProgress;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsTaskProgress.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsTaskProgress" MUID: (54746A670337)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , k2Base
;

type
 TncsTaskProgress = class(TncsMessage)
  protected
   function pm_GetTaskID: AnsiString;
   procedure pm_SetTaskID(const aValue: AnsiString);
   function pm_GetDescription: AnsiString;
   procedure pm_SetDescription(const aValue: AnsiString);
   function pm_GetPercent: Integer;
   procedure pm_SetPercent(aValue: Integer);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
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
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csTaskProgress_Const
 //#UC START# *54746A670337impl_uses*
 //#UC END# *54746A670337impl_uses*
;

function TncsTaskProgress.pm_GetTaskID: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrTaskID]);
end;//TncsTaskProgress.pm_GetTaskID

procedure TncsTaskProgress.pm_SetTaskID(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrTaskID, nil] := (aValue);
end;//TncsTaskProgress.pm_SetTaskID

function TncsTaskProgress.pm_GetDescription: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrDescription]);
end;//TncsTaskProgress.pm_GetDescription

procedure TncsTaskProgress.pm_SetDescription(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrDescription, nil] := (aValue);
end;//TncsTaskProgress.pm_SetDescription

function TncsTaskProgress.pm_GetPercent: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrPercent]);
end;//TncsTaskProgress.pm_GetPercent

procedure TncsTaskProgress.pm_SetPercent(aValue: Integer);
begin
 TaggedData.IntW[k2_attrPercent, nil] := (aValue);
end;//TncsTaskProgress.pm_SetPercent

class function TncsTaskProgress.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsTaskProgress;
end;//TncsTaskProgress.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
