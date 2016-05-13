unit SearchModuleWordsPack;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\SearchModuleWordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "SearchModuleWordsPack" MUID: (571A254F038A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 //#UC START# *571A254F038Aintf_uses*
 //#UC END# *571A254F038Aintf_uses*
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
 , ContextHistoryInterfaces
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , BaseSearchInterfaces
 , nsContextHistory
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *571A254F038Aimpl_uses*
 //#UC END# *571A254F038Aimpl_uses*
;

type
 TkwOpenSituationCard = class(TtfwRegisterableWord)
  {* ������� ��� 6.� (�����������) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwOpenSituationCard

 TkwOpenOldSituationCard = class(TtfwRegisterableWord)
  {* ������� ��� 5.� (�������������) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwOpenOldSituationCard

 TkwAttributeSearch = {final} class(TtfwRegisterableWord)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwAttributeSearch

 TkwClearContextSearchHistory = {abstract} class(TtfwRegisterableWord)
  protected
   function GetContextHistoryKind: TnsContextHistoryKind; virtual; abstract;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwClearContextSearchHistory

 TkwClearDocumentContextSearchHistory = {final} class(TkwClearContextSearchHistory)
  protected
   function GetContextHistoryKind: TnsContextHistoryKind; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwClearDocumentContextSearchHistory

 TkwClearPharmContextSearchHistory = {final} class(TkwClearContextSearchHistory)
  protected
   function GetContextHistoryKind: TnsContextHistoryKind; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwClearPharmContextSearchHistory

class function TkwOpenSituationCard.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����������_Prim';
end;//TkwOpenSituationCard.GetWordNameForRegister

procedure TkwOpenSituationCard.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F27EAF200E5_var*
//#UC END# *4DAEEDE10285_4F27EAF200E5_var*
begin
//#UC START# *4DAEEDE10285_4F27EAF200E5_impl*
 TdmStdRes.OpenSituationCard(nil);
//#UC END# *4DAEEDE10285_4F27EAF200E5_impl*
end;//TkwOpenSituationCard.DoDoIt

class function TkwOpenOldSituationCard.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�������������_Prim';
end;//TkwOpenOldSituationCard.GetWordNameForRegister

procedure TkwOpenOldSituationCard.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F27EB56012C_var*
//#UC END# *4DAEEDE10285_4F27EB56012C_var*
begin
//#UC START# *4DAEEDE10285_4F27EB56012C_impl*
 TdmStdRes.OpenOldSituationCard(nil, nil);
//#UC END# *4DAEEDE10285_4F27EB56012C_impl*
end;//TkwOpenOldSituationCard.DoDoIt

class function TkwAttributeSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '���_Prim';
end;//TkwAttributeSearch.GetWordNameForRegister

procedure TkwAttributeSearch.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DAF069D0072_var*
//#UC END# *4DAEEDE10285_4DAF069D0072_var*
begin
//#UC START# *4DAEEDE10285_4DAF069D0072_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4DAF069D0072_impl*
end;//TkwAttributeSearch.DoDoIt

procedure TkwClearContextSearchHistory.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_53B12A56032C_var*
//#UC END# *4DAEEDE10285_53B12A56032C_var*
begin
//#UC START# *4DAEEDE10285_53B12A56032C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_53B12A56032C_impl*
end;//TkwClearContextSearchHistory.DoDoIt

function TkwClearDocumentContextSearchHistory.GetContextHistoryKind: TnsContextHistoryKind;
//#UC START# *53B12AEE01A2_53B12B8A03DC_var*
//#UC END# *53B12AEE01A2_53B12B8A03DC_var*
begin
//#UC START# *53B12AEE01A2_53B12B8A03DC_impl*
 !!! Needs to be implemented !!!
//#UC END# *53B12AEE01A2_53B12B8A03DC_impl*
end;//TkwClearDocumentContextSearchHistory.GetContextHistoryKind

class function TkwClearDocumentContextSearchHistory.GetWordNameForRegister: AnsiString;
begin
 Result := 'ClearDocumentContextSearchHistory';
end;//TkwClearDocumentContextSearchHistory.GetWordNameForRegister

function TkwClearPharmContextSearchHistory.GetContextHistoryKind: TnsContextHistoryKind;
//#UC START# *53B12AEE01A2_53B12BB200FE_var*
//#UC END# *53B12AEE01A2_53B12BB200FE_var*
begin
//#UC START# *53B12AEE01A2_53B12BB200FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *53B12AEE01A2_53B12BB200FE_impl*
end;//TkwClearPharmContextSearchHistory.GetContextHistoryKind

class function TkwClearPharmContextSearchHistory.GetWordNameForRegister: AnsiString;
begin
 Result := 'ClearPharmContextSearchHistory';
end;//TkwClearPharmContextSearchHistory.GetWordNameForRegister

initialization
 TkwOpenSituationCard.RegisterInEngine;
 {* ����������� TkwOpenSituationCard }
 TkwOpenOldSituationCard.RegisterInEngine;
 {* ����������� TkwOpenOldSituationCard }
 TkwAttributeSearch.RegisterInEngine;
 {* ����������� AttributeSearch }
 TkwClearContextSearchHistory.RegisterClass;
 {* ����������� ClearContextSearchHistory }
 TkwClearDocumentContextSearchHistory.RegisterInEngine;
 {* ����������� ClearDocumentContextSearchHistory }
 TkwClearPharmContextSearchHistory.RegisterInEngine;
 {* ����������� ClearPharmContextSearchHistory }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
