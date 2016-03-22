unit kwClearConfig;

// ������: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwClearConfig.pas"
// ���������: "ScriptKeyword"
// ������� ������: "ClearConfig" MUID: (56A09E250064)
// ��� ����: "TkwClearConfig"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwClearConfig = {final} class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwClearConfig
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestAdapter2
;

procedure TkwClearConfig.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_56A09E250064_var*
//#UC END# *4DAEEDE10285_56A09E250064_var*
begin
//#UC START# *4DAEEDE10285_56A09E250064_impl*

//#UC END# *4DAEEDE10285_56A09E250064_impl*
end;//TkwClearConfig.DoDoIt

class function TkwClearConfig.GetWordNameForRegister: AnsiString;
begin
 Result := 'ClearConfig';
end;//TkwClearConfig.GetWordNameForRegister

initialization
 TkwClearConfig.RegisterInEngine;
 {* ����������� ClearConfig }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

end.
