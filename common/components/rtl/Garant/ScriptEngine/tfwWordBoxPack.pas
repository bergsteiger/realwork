unit tfwWordBoxPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\tfwWordBoxPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "tfwWordBoxPack" MUID: (567A8EB00176)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptingInterfaces
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , WordsRTTIPack
 , tfwClassLike
 , TypInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopWordBoxBoxed = {final} class(TtfwClassLike)
  {* ����� ������� pop:WordBox:Boxed }
  private
   function Boxed(const aCtx: TtfwContext;
    const aWordBox: ItfwWordBox): TtfwWord;
    {* ���������� ����� ������� pop:WordBox:Boxed }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordBoxBoxed

function TkwPopWordBoxBoxed.Boxed(const aCtx: TtfwContext;
 const aWordBox: ItfwWordBox): TtfwWord;
 {* ���������� ����� ������� pop:WordBox:Boxed }
//#UC START# *567A8EC50138_72ECED106E06_var*
//#UC END# *567A8EC50138_72ECED106E06_var*
begin
//#UC START# *567A8EC50138_72ECED106E06_impl*
 Result := aWordBox.Boxed;
//#UC END# *567A8EC50138_72ECED106E06_impl*
end;//TkwPopWordBoxBoxed.Boxed

procedure TkwPopWordBoxBoxed.DoDoIt(const aCtx: TtfwContext);
var l_aWordBox: ItfwWordBox;
begin
 try
  l_aWordBox := ItfwWordBox(aCtx.rEngine.PopIntf(ItfwWordBox));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWordBox: ItfwWordBox : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Boxed(aCtx, l_aWordBox));
end;//TkwPopWordBoxBoxed.DoDoIt

class function TkwPopWordBoxBoxed.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordBox:Boxed';
end;//TkwPopWordBoxBoxed.GetWordNameForRegister

function TkwPopWordBoxBoxed.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwWord);
end;//TkwPopWordBoxBoxed.GetResultTypeInfo

function TkwPopWordBoxBoxed.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordBoxBoxed.GetAllParamsCount

function TkwPopWordBoxBoxed.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwWordBox)]);
end;//TkwPopWordBoxBoxed.ParamsTypes

initialization
 TkwPopWordBoxBoxed.RegisterInEngine;
 {* ����������� pop_WordBox_Boxed }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwWordBox));
 {* ����������� ���� ItfwWordBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* ����������� ���� TtfwWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
