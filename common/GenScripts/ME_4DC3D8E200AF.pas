unit kwTimeMachineSetDate;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwTimeMachineSetDate.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwTimeMachineSetDate = class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwTimeMachineSetDate
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , DataAdapter
 , l3DateSt
 , bsConvert
;

procedure TkwTimeMachineSetDate.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DC3D8E200AF_var*
//#UC END# *4DAEEDE10285_4DC3D8E200AF_var*
begin
//#UC START# *4DAEEDE10285_4DC3D8E200AF_impl*
 DefDataAdapter.TimeMachine.Date := bsBusinessToAdapter(FlexStr2Date(aCtx.rEngine.PopDelphiString));
//#UC END# *4DAEEDE10285_4DC3D8E200AF_impl*
end;//TkwTimeMachineSetDate.DoDoIt

class function TkwTimeMachineSetDate.GetWordNameForRegister: AnsiString;
begin
 Result := 'timemachine:SetDate';
end;//TkwTimeMachineSetDate.GetWordNameForRegister

initialization
 TkwTimeMachineSetDate.RegisterInEngine;
 {* Регистрация TkwTimeMachineSetDate }
{$IfEnd} // NOT Defined(NoScripts)

end.
