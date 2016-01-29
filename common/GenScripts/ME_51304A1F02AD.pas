unit kwKeyWordsPack;

interface

uses
 l3IntfUses
 , GUITestRunner
 , TestFrameWork
 , ComCtrls
 , tfwAxiomaticsResNameGetter
 , tfwRegisterableWord
 , tfwScriptingInterfaces
 , TypInfo
 , tfwClassLike
 , tfwGlobalKeyWord
;

implementation

uses
 l3ImplUses
 , ITestWordsPack
 , TTreeNodeForTestsWordsPack
 , TestForm4Scripts
 , KTestRunner
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwKeyWordsPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//TkwKeyWordsPackResNameGetter
 
 TkwGUITestRunnerPushDUnitForm = class(TtfwRegisterableWord)
  {* ����� ������� GUITestRunner:push:DUnitForm
*��� ����������:* TGUITestRunner
*������:*
[code]
OBJECT VAR l_TGUITestRunner
 GUITestRunner:push:DUnitForm >>> l_TGUITestRunner
[code]  }
  function push_DUnitForm(const aCtx: TtfwContext): TGUITestRunner;
   {* ���������� ����� ������� GUITestRunner:push:DUnitForm }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwGUITestRunnerPushDUnitForm
 
 TkwPopGUITestRunnerNodeToTest = class(TtfwClassLike)
  {* ����� ������� pop:GUITestRunner:NodeToTest
*��� ����������:* ITest
*������:*
[code]
INTERFACE VAR l_ITest
 aNode aGUITestRunner pop:GUITestRunner:NodeToTest >>> l_ITest
[code]  }
  function NodeToTest(const aCtx: TtfwContext;
   aGUITestRunner: TGUITestRunner;
   aNode: TTreeNode): ITest;
   {* ���������� ����� ������� pop:GUITestRunner:NodeToTest }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopGUITestRunnerNodeToTest
 
 TkwDeleteEtalons = class(TtfwGlobalKeyWord)
  {* ����� ������� DeleteEtalons
*������:*
[code]
 anIsScript aSubFolder aName DeleteEtalons
[code]  }
  procedure DeleteEtalons(const aCtx: TtfwContext;
   const aName: AnsiString;
   const aSubFolder: AnsiString;
   anIsScript: Boolean);
   {* ���������� ����� ������� DeleteEtalons }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDeleteEtalons
 
end.
