unit csAutolinkerTask;

// Модуль: "w:\common\components\rtl\Garant\cs\csAutolinkerTask.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsAutolinkerTask" MUID: (57FF551D0028)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , k2Base
;

type
 TcsAutolinkerTask = class(TddProcessTask)
  protected
   function pm_GetClearLinksBeforeRun: Boolean;
   procedure pm_SetClearLinksBeforeRun(aValue: Boolean);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property ClearLinksBeforeRun: Boolean
    read pm_GetClearLinksBeforeRun
    write pm_SetClearLinksBeforeRun;
 end;//TcsAutolinkerTask
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , AutolinkerTask_Const
 //#UC START# *57FF551D0028impl_uses*
 //#UC END# *57FF551D0028impl_uses*
;

function TcsAutolinkerTask.pm_GetClearLinksBeforeRun: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrClearLinksBeforeRun]);
end;//TcsAutolinkerTask.pm_GetClearLinksBeforeRun

procedure TcsAutolinkerTask.pm_SetClearLinksBeforeRun(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrClearLinksBeforeRun, nil] := (aValue);
end;//TcsAutolinkerTask.pm_SetClearLinksBeforeRun

class function TcsAutolinkerTask.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typAutolinkerTask;
end;//TcsAutolinkerTask.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
