unit kwModifier;
 {* ��������� �������������. }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwModifier.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Modifier" MUID: (4DCACE1201A3)
// ��� ����: "TkwModifier"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwTypeInfo
 , tfwScriptingInterfaces
;

type
 TkwModifier = {abstract} class(TtfwRegisterableWord)
  {* ��������� �������������. }
  protected
   function pm_GetModifier: TtfwTypeInfo; virtual; abstract;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function IsImmediate(const aCtx: TtfwContext): Boolean; override;
  protected
   property Modifier: TtfwTypeInfo
    read pm_GetModifier;
 end;//TkwModifier
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 //#UC START# *4DCACE1201A3impl_uses*
 //#UC END# *4DCACE1201A3impl_uses*
;

procedure TkwModifier.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DCACE1201A3_var*
//#UC END# *4DAEEDE10285_4DCACE1201A3_var*
begin
//#UC START# *4DAEEDE10285_4DCACE1201A3_impl*
 aCtx.SetWordInfo(aCtx.rTypeInfo.IncludeType(Self.Modifier));
//#UC END# *4DAEEDE10285_4DCACE1201A3_impl*
end;//TkwModifier.DoDoIt

function TkwModifier.IsImmediate(const aCtx: TtfwContext): Boolean;
begin
 Result := True;
end;//TkwModifier.IsImmediate

initialization
 TkwModifier.RegisterClass;
 {* ����������� Modifier }
{$IfEnd} // NOT Defined(NoScripts)

end.
