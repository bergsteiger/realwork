unit ITestWordsPack;

interface

uses
 l3IntfUses
 , TestFrameWork
 , tfwAxiomaticsResNameGetter
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , TypInfo
 , tfwGlobalKeyWord
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TITestWordsPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//TITestWordsPackResNameGetter
 
 TkwPopTestName = class(TtfwPropertyLike)
  {* ����� ������� pop:Test:Name
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aTest pop:Test:Name >>> l_String
[code]  }
  function Name(const aCtx: TtfwContext;
   const aTest: ITest): AnsiString;
   {* ���������� ����� ������� pop:Test:Name }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTestName
 
 TkwPopTestEnabled = class(TtfwPropertyLike)
  {* ����� ������� pop:Test:Enabled
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aTest pop:Test:Enabled >>> l_Boolean
[code]  }
  function Enabled(const aCtx: TtfwContext;
   const aTest: ITest): Boolean;
   {* ���������� ����� ������� pop:Test:Enabled }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTestEnabled
 
 TkwPopTestSubFolder = class(TtfwPropertyLike)
  {* ����� ������� pop:Test:SubFolder
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aTest pop:Test:SubFolder >>> l_String
[code]  }
  function SubFolder(const aCtx: TtfwContext;
   const aTest: ITest): AnsiString;
   {* ���������� ����� ������� pop:Test:SubFolder }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTestSubFolder
 
 TkwPopTestHasScriptChildren = class(TtfwPropertyLike)
  {* ����� ������� pop:Test:HasScriptChildren
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aTest pop:Test:HasScriptChildren >>> l_Boolean
[code]  }
  function HasScriptChildren(const aCtx: TtfwContext;
   const aTest: ITest): Boolean;
   {* ���������� ����� ������� pop:Test:HasScriptChildren }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTestHasScriptChildren
 
 TkwTestShouldStop = class(TtfwGlobalKeyWord)
  {* ����� ������� test:ShouldStop
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 test:ShouldStop >>> l_Boolean
[code]  }
  function test_ShouldStop(const aCtx: TtfwContext): Boolean;
   {* ���������� ����� ������� test:ShouldStop }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTestShouldStop
 
end.
