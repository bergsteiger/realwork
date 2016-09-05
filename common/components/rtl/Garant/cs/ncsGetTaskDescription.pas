unit ncsGetTaskDescription;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsGetTaskDescription.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsGetTaskDescription" MUID: (546B444D012F)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , k2Base
;

type
 TncsGetTaskDescription = class(TncsMessage)
  protected
   function pm_GetTaskID: AnsiString;
   procedure pm_SetTaskID(const aValue: AnsiString);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property TaskID: AnsiString
    read pm_GetTaskID
    write pm_SetTaskID;
 end;//TncsGetTaskDescription
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csGetTaskDescription_Const
 //#UC START# *546B444D012Fimpl_uses*
 //#UC END# *546B444D012Fimpl_uses*
;

function TncsGetTaskDescription.pm_GetTaskID: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrTaskID]);
end;//TncsGetTaskDescription.pm_GetTaskID

procedure TncsGetTaskDescription.pm_SetTaskID(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrTaskID, nil] := (aValue);
end;//TncsGetTaskDescription.pm_SetTaskID

class function TncsGetTaskDescription.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsGetTaskDescription;
end;//TncsGetTaskDescription.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
