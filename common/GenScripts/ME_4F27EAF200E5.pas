unit kwOpenSituationCard;
 {* ������� ��� 6.� (�����������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Shell_Words\kwOpenSituationCard.pas"
// ���������: "ScriptKeyword"

{$Include nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwOpenSituationCard = class(TtfwRegisterableWord)
  {* ������� ��� 6.� (�����������) }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwOpenSituationCard
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

procedure TkwOpenSituationCard.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F27EAF200E5_var*
//#UC END# *4DAEEDE10285_4F27EAF200E5_var*
begin
//#UC START# *4DAEEDE10285_4F27EAF200E5_impl*
 TdmStdRes.OpenSituationCard(nil);
//#UC END# *4DAEEDE10285_4F27EAF200E5_impl*
end;//TkwOpenSituationCard.DoDoIt

class function TkwOpenSituationCard.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����������_Prim';
end;//TkwOpenSituationCard.GetWordNameForRegister

initialization
 TkwOpenSituationCard.RegisterInEngine;
 {* ����������� TkwOpenSituationCard }
{$IfEnd} // NOT Defined(NoScripts)

end.
