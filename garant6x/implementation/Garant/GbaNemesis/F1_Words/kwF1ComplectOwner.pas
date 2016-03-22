unit kwF1ComplectOwner;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwF1ComplectOwner.pas"
// ���������: "ScriptKeyword"
// ������� ������: "f1_ComplectOwner" MUID: (50237E3A03A5)
// ��� ����: "TkwF1ComplectOwner"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwF1ComplectOwner = {final} class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwF1ComplectOwner
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , bsUtils
;

procedure TkwF1ComplectOwner.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_50237E3A03A5_var*
//#UC END# *4DAEEDE10285_50237E3A03A5_var*
begin
//#UC START# *4DAEEDE10285_50237E3A03A5_impl*
 aCtx.rEngine.PushString(bsComplectOwner);
//#UC END# *4DAEEDE10285_50237E3A03A5_impl*
end;//TkwF1ComplectOwner.DoDoIt

class function TkwF1ComplectOwner.GetWordNameForRegister: AnsiString;
begin
 Result := 'f1:ComplectOwner';
end;//TkwF1ComplectOwner.GetWordNameForRegister

initialization
 TkwF1ComplectOwner.RegisterInEngine;
 {* ����������� f1_ComplectOwner }
{$IfEnd} // NOT Defined(NoScripts)

end.
