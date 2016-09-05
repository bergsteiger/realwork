unit kwKeyWordsPack;

// Модуль: "w:\common\components\rtl\Garant\DUnit_Script_Support\kwKeyWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "kwKeyWordsPack" MUID: (51304A1F02AD)

{$Include w:\common\components\rtl\Garant\DUnit_Script_Support\dsDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , GUITestRunner
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , TypInfo
 , tfwClassLike
 , TestFrameWork
 , ComCtrls
 , tfwAxiomaticsResNameGetter
 , ITestWordsPack
 , TTreeNodeForTestsWordsPack
 , TestForm4Scripts
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *51304A1F02ADimpl_uses*
 //#UC END# *51304A1F02ADimpl_uses*
;

type
 TkwDeleteEtalons = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта DeleteEtalons }
  private
   procedure DeleteEtalons(const aCtx: TtfwContext;
    const aName: AnsiString;
    const aSubFolder: AnsiString;
    anIsScript: Boolean);
    {* Реализация слова скрипта DeleteEtalons }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDeleteEtalons

 TkwGUITestRunnerPushDUnitForm = {final} class(TtfwClassLike)
  {* Слово скрипта GUITestRunner:push:DUnitForm }
  private
   function push_DUnitForm(const aCtx: TtfwContext): TGUITestRunner;
    {* Реализация слова скрипта GUITestRunner:push:DUnitForm }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGUITestRunnerPushDUnitForm

 TkwPopGUITestRunnerNodeToTest = {final} class(TtfwClassLike)
  {* Слово скрипта pop:GUITestRunner:NodeToTest }
  private
   function NodeToTest(const aCtx: TtfwContext;
    aGUITestRunner: TGUITestRunner;
    aNode: TTreeNode): ITest;
    {* Реализация слова скрипта pop:GUITestRunner:NodeToTest }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopGUITestRunnerNodeToTest

 TkwKeyWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TkwKeyWordsPackResNameGetter

procedure TkwDeleteEtalons.DeleteEtalons(const aCtx: TtfwContext;
 const aName: AnsiString;
 const aSubFolder: AnsiString;
 anIsScript: Boolean);
 {* Реализация слова скрипта DeleteEtalons }
//#UC START# *55C9F4AC003F_55C9F4AC003F_Word_var*
//#UC END# *55C9F4AC003F_55C9F4AC003F_Word_var*
begin
//#UC START# *55C9F4AC003F_55C9F4AC003F_Word_impl*
 KTestRunner.DeleteEtalons(aName, aSubFolder, anIsScript);
//#UC END# *55C9F4AC003F_55C9F4AC003F_Word_impl*
end;//TkwDeleteEtalons.DeleteEtalons

class function TkwDeleteEtalons.GetWordNameForRegister: AnsiString;
begin
 Result := 'DeleteEtalons';
end;//TkwDeleteEtalons.GetWordNameForRegister

function TkwDeleteEtalons.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwDeleteEtalons.GetResultTypeInfo

function TkwDeleteEtalons.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwDeleteEtalons.GetAllParamsCount

function TkwDeleteEtalons.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString, TypeInfo(Boolean)]);
end;//TkwDeleteEtalons.ParamsTypes

procedure TkwDeleteEtalons.DoDoIt(const aCtx: TtfwContext);
var l_aName: AnsiString;
var l_aSubFolder: AnsiString;
var l_anIsScript: Boolean;
begin
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aSubFolder := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSubFolder: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIsScript := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anIsScript: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 DeleteEtalons(aCtx, l_aName, l_aSubFolder, l_anIsScript);
end;//TkwDeleteEtalons.DoDoIt

function TkwGUITestRunnerPushDUnitForm.push_DUnitForm(const aCtx: TtfwContext): TGUITestRunner;
 {* Реализация слова скрипта GUITestRunner:push:DUnitForm }
//#UC START# *55C9F42D0261_55C9F42D0261_4DA30F0F02C1_Word_var*
//#UC END# *55C9F42D0261_55C9F42D0261_4DA30F0F02C1_Word_var*
begin
//#UC START# *55C9F42D0261_55C9F42D0261_4DA30F0F02C1_Word_impl*
 Result := TestForm4Scripts.GetTestForm;
//#UC END# *55C9F42D0261_55C9F42D0261_4DA30F0F02C1_Word_impl*
end;//TkwGUITestRunnerPushDUnitForm.push_DUnitForm

class function TkwGUITestRunnerPushDUnitForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'GUITestRunner:push:DUnitForm';
end;//TkwGUITestRunnerPushDUnitForm.GetWordNameForRegister

function TkwGUITestRunnerPushDUnitForm.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TGUITestRunner);
end;//TkwGUITestRunnerPushDUnitForm.GetResultTypeInfo

function TkwGUITestRunnerPushDUnitForm.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwGUITestRunnerPushDUnitForm.GetAllParamsCount

function TkwGUITestRunnerPushDUnitForm.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TGUITestRunner)]);
end;//TkwGUITestRunnerPushDUnitForm.ParamsTypes

procedure TkwGUITestRunnerPushDUnitForm.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushObj(push_DUnitForm(aCtx));
end;//TkwGUITestRunnerPushDUnitForm.DoDoIt

function TkwPopGUITestRunnerNodeToTest.NodeToTest(const aCtx: TtfwContext;
 aGUITestRunner: TGUITestRunner;
 aNode: TTreeNode): ITest;
 {* Реализация слова скрипта pop:GUITestRunner:NodeToTest }
//#UC START# *55C9F44A003C_55C9F44A003C_4DA30F0F02C1_Word_var*
//#UC END# *55C9F44A003C_55C9F44A003C_4DA30F0F02C1_Word_var*
begin
//#UC START# *55C9F44A003C_55C9F44A003C_4DA30F0F02C1_Word_impl*
 Result := aGUITestRunner.NodeToTest(aNode)
//#UC END# *55C9F44A003C_55C9F44A003C_4DA30F0F02C1_Word_impl*
end;//TkwPopGUITestRunnerNodeToTest.NodeToTest

class function TkwPopGUITestRunnerNodeToTest.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:GUITestRunner:NodeToTest';
end;//TkwPopGUITestRunnerNodeToTest.GetWordNameForRegister

function TkwPopGUITestRunnerNodeToTest.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ITest);
end;//TkwPopGUITestRunnerNodeToTest.GetResultTypeInfo

function TkwPopGUITestRunnerNodeToTest.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopGUITestRunnerNodeToTest.GetAllParamsCount

function TkwPopGUITestRunnerNodeToTest.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TGUITestRunner), TypeInfo(TTreeNode)]);
end;//TkwPopGUITestRunnerNodeToTest.ParamsTypes

procedure TkwPopGUITestRunnerNodeToTest.DoDoIt(const aCtx: TtfwContext);
var l_aGUITestRunner: TGUITestRunner;
var l_aNode: TTreeNode;
begin
 try
  l_aGUITestRunner := TGUITestRunner(aCtx.rEngine.PopObjAs(TGUITestRunner));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aGUITestRunner: TGUITestRunner : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aNode := TTreeNode(aCtx.rEngine.PopObjAs(TTreeNode));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNode: TTreeNode : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf(NodeToTest(aCtx, l_aGUITestRunner, l_aNode), TypeInfo(ITest));
end;//TkwPopGUITestRunnerNodeToTest.DoDoIt

class function TkwKeyWordsPackResNameGetter.ResName: AnsiString;
begin
 Result := 'kwKeyWordsPack';
end;//TkwKeyWordsPackResNameGetter.ResName

{$R kwKeyWordsPack.res}

initialization
 TkwDeleteEtalons.RegisterInEngine;
 {* Регистрация DeleteEtalons }
 TkwGUITestRunnerPushDUnitForm.RegisterInEngine;
 {* Регистрация GUITestRunner_push_DUnitForm }
 TkwPopGUITestRunnerNodeToTest.RegisterInEngine;
 {* Регистрация pop_GUITestRunner_NodeToTest }
 TkwKeyWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TGUITestRunner));
 {* Регистрация типа TGUITestRunner }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ITest));
 {* Регистрация типа ITest }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTreeNode));
 {* Регистрация типа TTreeNode }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
