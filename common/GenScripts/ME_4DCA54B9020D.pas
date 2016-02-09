unit F1ShellWordsPack;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Shell_Words\F1ShellWordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3Interfaces
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwF1ImportConsultation
 , kwConfigRestore
 , kwStyleTableRestore
 , kwDiffIteratorHasNext
 , kwDiffIteratorNext
 , kwDiffIteratorHasPrev
 , kwDiffIteratorPrev
 {$If Defined(nsTest)}
 , kwTextFormSetNeedShowIntranetWarning
 {$IfEnd} // Defined(nsTest)
 , kwTextFormGetDocumentID
 , kwOpenSituationCard
 , kwOpenOldSituationCard
 , kwQueryCardSetCanSaveState
 , kwDocumentLikeState
 , kwGetEncryptedComplectId
 , kwOpenPrimeForm
 , nsExternalObjectPrim
 , nsUtils
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwBrowse = {final} class(TtfwGlobalKeyWord)
  {* ����� ������� browse
*������:*
[code]
 aStr browse
[code]  }
  private
   procedure browse(const aCtx: TtfwContext;
    const aStr: Il3CString);
    {* ���������� ����� ������� browse }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBrowse

 TkwF1_WasBeep = {final} class(TtfwGlobalKeyWord)
  {* ����� ������� f1::WasBeep
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 f1::WasBeep >>> l_Boolean
[code]  }
  private
   function f1_WasBeep(const aCtx: TtfwContext): Boolean;
    {* ���������� ����� ������� f1::WasBeep }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwF1_WasBeep

procedure TkwBrowse.browse(const aCtx: TtfwContext;
 const aStr: Il3CString);
 {* ���������� ����� ������� browse }
//#UC START# *ADC7C02D00B5_3223F9BFFE72_var*
//#UC END# *ADC7C02D00B5_3223F9BFFE72_var*
begin
//#UC START# *ADC7C02D00B5_3223F9BFFE72_impl*
 nsDoShellExecute(aStr, False, nil, True);
//#UC END# *ADC7C02D00B5_3223F9BFFE72_impl*
end;//TkwBrowse.browse

procedure TkwBrowse.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3223F9BFFE72_var*
//#UC END# *4DAEEDE10285_3223F9BFFE72_var*
begin
//#UC START# *4DAEEDE10285_3223F9BFFE72_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3223F9BFFE72_impl*
end;//TkwBrowse.DoDoIt

class function TkwBrowse.GetWordNameForRegister: AnsiString;
begin
 Result := 'browse';
end;//TkwBrowse.GetWordNameForRegister

function TkwBrowse.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_3223F9BFFE72_var*
//#UC END# *551544E2001A_3223F9BFFE72_var*
begin
//#UC START# *551544E2001A_3223F9BFFE72_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_3223F9BFFE72_impl*
end;//TkwBrowse.GetResultTypeInfo

function TkwBrowse.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_3223F9BFFE72_var*
//#UC END# *559687E6025A_3223F9BFFE72_var*
begin
//#UC START# *559687E6025A_3223F9BFFE72_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_3223F9BFFE72_impl*
end;//TkwBrowse.GetAllParamsCount

function TkwBrowse.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_3223F9BFFE72_var*
//#UC END# *5617F4D00243_3223F9BFFE72_var*
begin
//#UC START# *5617F4D00243_3223F9BFFE72_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_3223F9BFFE72_impl*
end;//TkwBrowse.ParamsTypes

function TkwF1_WasBeep.f1_WasBeep(const aCtx: TtfwContext): Boolean;
 {* ���������� ����� ������� f1::WasBeep }
//#UC START# *3C50E0D2B358_5888E53B751F_var*
//#UC END# *3C50E0D2B358_5888E53B751F_var*
begin
//#UC START# *3C50E0D2B358_5888E53B751F_impl*
 {$IfDef InsiderTest}
 Result := g_WasBeep;
 g_WasBeep := false;
 {$Else  InsiderTest}
 Result := false;
 {$EndIf InsiderTest}
//#UC END# *3C50E0D2B358_5888E53B751F_impl*
end;//TkwF1_WasBeep.f1_WasBeep

procedure TkwF1_WasBeep.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5888E53B751F_var*
//#UC END# *4DAEEDE10285_5888E53B751F_var*
begin
//#UC START# *4DAEEDE10285_5888E53B751F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5888E53B751F_impl*
end;//TkwF1_WasBeep.DoDoIt

class function TkwF1_WasBeep.GetWordNameForRegister: AnsiString;
begin
 Result := 'f1::WasBeep';
end;//TkwF1_WasBeep.GetWordNameForRegister

function TkwF1_WasBeep.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_5888E53B751F_var*
//#UC END# *551544E2001A_5888E53B751F_var*
begin
//#UC START# *551544E2001A_5888E53B751F_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_5888E53B751F_impl*
end;//TkwF1_WasBeep.GetResultTypeInfo

function TkwF1_WasBeep.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_5888E53B751F_var*
//#UC END# *559687E6025A_5888E53B751F_var*
begin
//#UC START# *559687E6025A_5888E53B751F_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_5888E53B751F_impl*
end;//TkwF1_WasBeep.GetAllParamsCount

function TkwF1_WasBeep.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_5888E53B751F_var*
//#UC END# *5617F4D00243_5888E53B751F_var*
begin
//#UC START# *5617F4D00243_5888E53B751F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_5888E53B751F_impl*
end;//TkwF1_WasBeep.ParamsTypes

initialization
 TkwBrowse.RegisterInEngine;
 {* ����������� browse }
 TkwF1_WasBeep.RegisterInEngine;
 {* ����������� f1__WasBeep }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* ����������� ���� Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* ����������� ���� Boolean }
{$IfEnd} // NOT Defined(NoScripts)

end.
