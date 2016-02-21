unit kwOpenOldSituationCard;
 {* ������� ��� 5.� (�������������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Shell_Words\kwOpenOldSituationCard.pas"
// ���������: "ScriptKeyword"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwOpenOldSituationCard = class(TtfwRegisterableWord)
  {* ������� ��� 5.� (�������������) }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwOpenOldSituationCard
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

procedure TkwOpenOldSituationCard.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F27EB56012C_var*
//#UC END# *4DAEEDE10285_4F27EB56012C_var*
begin
//#UC START# *4DAEEDE10285_4F27EB56012C_impl*
 TdmStdRes.OpenOldSituationCard(nil, nil);
//#UC END# *4DAEEDE10285_4F27EB56012C_impl*
end;//TkwOpenOldSituationCard.DoDoIt

class function TkwOpenOldSituationCard.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�������������_Prim';
end;//TkwOpenOldSituationCard.GetWordNameForRegister

initialization
 TkwOpenOldSituationCard.RegisterInEngine;
 {* ����������� TkwOpenOldSituationCard }
{$IfEnd} // NOT Defined(NoScripts)

end.
