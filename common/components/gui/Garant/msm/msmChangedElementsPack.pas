unit msmChangedElementsPack;

// ������: "w:\common\components\gui\Garant\msm\msmChangedElementsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "msmChangedElementsPack" MUID: (57E323D500C6)

{$Include w:\common\components\msm.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , TypInfo
 , msmChangedElements
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *57E323D500C6impl_uses*
 //#UC END# *57E323D500C6impl_uses*
;

type
 TkwMsmAddChangedElement = {final} class(TtfwGlobalKeyWord)
  {* ����� ������� msm:AddChangedElement }
  private
   procedure msm_AddChangedElement(const aCtx: TtfwContext;
    aWord: TtfwWord);
    {* ���������� ����� ������� msm:AddChangedElement }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMsmAddChangedElement

procedure TkwMsmAddChangedElement.msm_AddChangedElement(const aCtx: TtfwContext;
 aWord: TtfwWord);
 {* ���������� ����� ������� msm:AddChangedElement }
//#UC START# *57E2AB6700A6_57E2AB6700A6_Word_var*
//#UC END# *57E2AB6700A6_57E2AB6700A6_Word_var*
begin
//#UC START# *57E2AB6700A6_57E2AB6700A6_Word_impl*
 TmsmChangedElements.Instance.Add(aWord);
//#UC END# *57E2AB6700A6_57E2AB6700A6_Word_impl*
end;//TkwMsmAddChangedElement.msm_AddChangedElement

class function TkwMsmAddChangedElement.GetWordNameForRegister: AnsiString;
begin
 Result := 'msm:AddChangedElement';
end;//TkwMsmAddChangedElement.GetWordNameForRegister

function TkwMsmAddChangedElement.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwMsmAddChangedElement.GetResultTypeInfo

function TkwMsmAddChangedElement.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMsmAddChangedElement.GetAllParamsCount

function TkwMsmAddChangedElement.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwMsmAddChangedElement.ParamsTypes

procedure TkwMsmAddChangedElement.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 msm_AddChangedElement(aCtx, l_aWord);
end;//TkwMsmAddChangedElement.DoDoIt

initialization
 TkwMsmAddChangedElement.RegisterInEngine;
 {* ����������� msm_AddChangedElement }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* ����������� ���� TtfwWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
