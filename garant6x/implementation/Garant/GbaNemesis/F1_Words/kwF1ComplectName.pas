unit kwF1ComplectName;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwF1ComplectName.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "f1_ComplectName" MUID: (50237E1C0249)
// Имя типа: "TkwF1ComplectName"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwF1ComplectName = {final} class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwF1ComplectName
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , bsUtils
;

procedure TkwF1ComplectName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_50237E1C0249_var*
//#UC END# *4DAEEDE10285_50237E1C0249_var*
begin
//#UC START# *4DAEEDE10285_50237E1C0249_impl*
 aCtx.rEngine.PushString(bsComplectName);
//#UC END# *4DAEEDE10285_50237E1C0249_impl*
end;//TkwF1ComplectName.DoDoIt

class function TkwF1ComplectName.GetWordNameForRegister: AnsiString;
begin
 Result := 'f1:ComplectName';
end;//TkwF1ComplectName.GetWordNameForRegister

initialization
 TkwF1ComplectName.RegisterInEngine;
 {* Регистрация f1_ComplectName }
{$IfEnd} // NOT Defined(NoScripts)

end.
