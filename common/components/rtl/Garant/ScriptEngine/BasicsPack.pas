unit BasicsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Axiomatics"
// ������: "BasicsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine$Axiomatics::Basics::BasicsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  l3Interfaces,
  tfwScriptingInterfaces,
  kwCompiledWordWorker,
  tfwConstLike,
  tfwParserInterfaces,
  tfwWordWorkerEx,
  tfwAxiomaticsResNameGetter,
  tfwTypeInfo,
  tfwGlobalKeyWord
  ;

type
 TkwCompiledPushWord = class(TkwCompiledWordWorker)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 public
 // overridden public methods
   function GetRef(const aCtx: TtfwContext): TtfwWord; override;
   function WordName: Il3CString; override;
 end;//TkwCompiledPushWord
function CompareValues(const aV1: TtfwStackValue;
  const aV2: TtfwStackValue;
  const aCtx: TtfwContext;
  aCaller: TtfwWord): Boolean;
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  l3String,
  l3Chars,
  kwCompiledWordPrim,
  Windows,
  l3MessagesService,
  tfwClassRef,
  Classes,
  l3Math,
  l3Base,
  kwInteger,
  kwString,
  kwValue,
  kwWordPtrPushWord,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwDefine = {final scriptword} class(TtfwConstLike)
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function AfterWordMaxCount(const aCtx: TtfwContext): Integer; override;
   procedure FinishDefinitionOfNewWord(aWordToFinish: TtfwKeyWord;
     aCompiled: TkwCompiledWordPrim;
     const aContext: TtfwContext); override;
     {* ��������� ����������� ����� ���������� ����� }
   function GetNewWordName(const aContext: TtfwContext): Il3CString; override;
 public
 // overridden public methods
   function IsImmediate(const aCtx: TtfwContext): Boolean; override;
 end;//TkwDefine

// start class TkwDefine

class function TkwDefine.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Define';
end;//TkwDefine.GetWordNameForRegister

function TkwDefine.IsImmediate(const aCtx: TtfwContext): Boolean;
//#UC START# *4DB6D7F70155_55880B6D01A0_var*
//#UC END# *4DB6D7F70155_55880B6D01A0_var*
begin
//#UC START# *4DB6D7F70155_55880B6D01A0_impl*
 Result := false; 
//#UC END# *4DB6D7F70155_55880B6D01A0_impl*
end;//TkwDefine.IsImmediate

function TkwDefine.AfterWordMaxCount(const aCtx: TtfwContext): Integer;
//#UC START# *4DB9B446039A_55880B6D01A0_var*
//#UC END# *4DB9B446039A_55880B6D01A0_var*
begin
//#UC START# *4DB9B446039A_55880B6D01A0_impl*
 Result := 0;
//#UC END# *4DB9B446039A_55880B6D01A0_impl*
end;//TkwDefine.AfterWordMaxCount

procedure TkwDefine.FinishDefinitionOfNewWord(aWordToFinish: TtfwKeyWord;
  aCompiled: TkwCompiledWordPrim;
  const aContext: TtfwContext);
//#UC START# *4F219629036A_55880B6D01A0_var*
var
 l_W : TtfwWord;
 l_Key : TtfwKeyWord;
//#UC END# *4F219629036A_55880B6D01A0_var*
begin
//#UC START# *4F219629036A_55880B6D01A0_impl*
 l_W := aContext.rEngine.PopObj As TtfwWord;
 l_Key := TtfwKeyWord(l_W.Key);
 try
  aWordToFinish.SetWord(aContext, l_W);
 finally
  l_W.Key := l_Key;
 end;//try..finally
//#UC END# *4F219629036A_55880B6D01A0_impl*
end;//TkwDefine.FinishDefinitionOfNewWord

function TkwDefine.GetNewWordName(const aContext: TtfwContext): Il3CString;
//#UC START# *4F37B3F10318_55880B6D01A0_var*
//#UC END# *4F37B3F10318_55880B6D01A0_var*
begin
//#UC START# *4F37B3F10318_55880B6D01A0_impl*
 Result := aContext.rEngine.PopString;
//#UC END# *4F37B3F10318_55880B6D01A0_impl*
end;//TkwDefine.GetNewWordName

type
//#UC START# *94E4F896CE56ci*
//#UC END# *94E4F896CE56ci*
//#UC START# *94E4F896CE56cit*
//#UC END# *94E4F896CE56cit*
 TBasicsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
 public
 // realized methods
   class function ResName: AnsiString; override;
//#UC START# *94E4F896CE56publ*
//#UC END# *94E4F896CE56publ*
 end;//TBasicsPackResNameGetter

// start class TBasicsPackResNameGetter

class function TBasicsPackResNameGetter.ResName: AnsiString;
 {-}
begin
 Result := 'BasicsPack';
end;//TBasicsPackResNameGetter.ResName

 {$R BasicsPack.res}

type
 TkwTrue = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� true
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 true >>> l_Boolean
[code]  }
 private
 // private methods
   function True(const aCtx: TtfwContext): Boolean;
     {* ���������� ����� ������� true }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTrue

// start class TkwTrue

function TkwTrue.True(const aCtx: TtfwContext): Boolean;
//#UC START# *31D2EDD18C66_384521AFEDE4_var*
//#UC END# *31D2EDD18C66_384521AFEDE4_var*
begin
//#UC START# *31D2EDD18C66_384521AFEDE4_impl*
 Result := System.true;
//#UC END# *31D2EDD18C66_384521AFEDE4_impl*
end;//TkwTrue.True

procedure TkwTrue.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushBool((True(aCtx)));
end;//TkwTrue.DoDoIt

class function TkwTrue.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'true';
end;//TkwTrue.GetWordNameForRegister

function TkwTrue.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwTrue.GetResultTypeInfo

function TkwTrue.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwTrue.GetAllParamsCount

function TkwTrue.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwTrue.ParamsTypes

type
 TkwFalse = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� false
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 false >>> l_Boolean
[code]  }
 private
 // private methods
   function False(const aCtx: TtfwContext): Boolean;
     {* ���������� ����� ������� false }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFalse

// start class TkwFalse

function TkwFalse.False(const aCtx: TtfwContext): Boolean;
//#UC START# *CEB83FCC48B0_A3E68B91DEB2_var*
//#UC END# *CEB83FCC48B0_A3E68B91DEB2_var*
begin
//#UC START# *CEB83FCC48B0_A3E68B91DEB2_impl*
 Result := System.false;
//#UC END# *CEB83FCC48B0_A3E68B91DEB2_impl*
end;//TkwFalse.False

procedure TkwFalse.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushBool((False(aCtx)));
end;//TkwFalse.DoDoIt

class function TkwFalse.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'false';
end;//TkwFalse.GetWordNameForRegister

function TkwFalse.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwFalse.GetResultTypeInfo

function TkwFalse.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwFalse.GetAllParamsCount

function TkwFalse.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwFalse.ParamsTypes

type
 TkwMsg = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Msg
*������:*
[code]
 aValue Msg
[code]  }
 private
 // private methods
   procedure Msg(const aCtx: TtfwContext;
    const aValue: TtfwStackValue);
     {* ���������� ����� ������� Msg }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMsg

// start class TkwMsg

procedure TkwMsg.Msg(const aCtx: TtfwContext;
  const aValue: TtfwStackValue);
//#UC START# *420EA6C5993D_8BA2A290A172_var*
var
 l_S : AnsiString;
//#UC END# *420EA6C5993D_8BA2A290A172_var*
begin
//#UC START# *420EA6C5993D_8BA2A290A172_impl*
 l_S := l3Str(aValue.AsPrintable);
 MessageBoxA(0, PAnsiChar(l_S), 'script message', MB_OK);
//#UC END# *420EA6C5993D_8BA2A290A172_impl*
end;//TkwMsg.Msg

procedure TkwMsg.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aValue : TtfwStackValue;
begin
 try
  l_aValue := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Msg(aCtx, l_aValue);
end;//TkwMsg.DoDoIt

class function TkwMsg.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Msg';
end;//TkwMsg.GetWordNameForRegister

function TkwMsg.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwMsg.GetResultTypeInfo

function TkwMsg.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwMsg.GetAllParamsCount

function TkwMsg.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwMsg.ParamsTypes

type
 TkwPrint = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� .
*������:*
[code]
 aValue .
[code]  }
 private
 // private methods
   procedure Print(const aCtx: TtfwContext;
    const aValue: TtfwStackValue);
     {* ���������� ����� ������� . }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPrint

// start class TkwPrint

procedure TkwPrint.Print(const aCtx: TtfwContext;
  const aValue: TtfwStackValue);
//#UC START# *5053122C683A_9AAA1AEFBAE6_var*
//#UC END# *5053122C683A_9AAA1AEFBAE6_var*
begin
//#UC START# *5053122C683A_9AAA1AEFBAE6_impl*
 aCtx.rCaller.Print(aValue.AsPrintable);
//#UC END# *5053122C683A_9AAA1AEFBAE6_impl*
end;//TkwPrint.Print

procedure TkwPrint.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aValue : TtfwStackValue;
begin
 try
  l_aValue := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Print(aCtx, l_aValue);
end;//TkwPrint.DoDoIt

class function TkwPrint.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.';
end;//TkwPrint.GetWordNameForRegister

function TkwPrint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPrint.GetResultTypeInfo

function TkwPrint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwPrint.GetAllParamsCount

function TkwPrint.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwPrint.ParamsTypes

type
 TkwLOOP = {final scriptword} class(TtfwWordWorkerEx)
  {* ����� ������� LOOP
[panel]���� LOOP.
������:
[code]
 10 LOOP ( 'Hello' . )
[code][panel]
*������:*
[code]
 aCount LOOP aWord
[code]  }
 private
 // private methods
   procedure LOOP(const aCtx: TtfwContext;
    aWord: TtfwWord;
    aCount: Integer);
     {* ���������� ����� ������� LOOP }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   procedure DoRun(const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLOOP

// start class TkwLOOP

procedure TkwLOOP.LOOP(const aCtx: TtfwContext;
  aWord: TtfwWord;
  aCount: Integer);
//#UC START# *02D71503A219_A183EE1D2A6D_var*
var
 l_I : Integer;
//#UC END# *02D71503A219_A183EE1D2A6D_var*
begin
//#UC START# *02D71503A219_A183EE1D2A6D_impl*
 for l_I := 0 to Pred(aCount) do
  try
   aWord.DoIt(aCtx);
  except
   on EtfwBreak do
    break;
   on EtfwContinue do
    continue;
  end;//try..except
//#UC END# *02D71503A219_A183EE1D2A6D_impl*
end;//TkwLOOP.LOOP

class function TkwLOOP.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'LOOP';
end;//TkwLOOP.GetWordNameForRegister

function TkwLOOP.RightParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwLOOP.RightParamsCount

procedure TkwLOOP.DoRun(const aCtx: TtfwContext);
 {-}
var
 l_aWord : TtfwWord;
 l_aCount : Integer;
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
 try
  l_aCount := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCount: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 LOOP(aCtx, l_aWord, l_aCount);
end;//TkwLOOP.DoRun

function TkwLOOP.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwLOOP.GetResultTypeInfo

function TkwLOOP.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwLOOP.GetAllParamsCount

function TkwLOOP.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), TypeInfo(Integer)]);
end;//TkwLOOP.ParamsTypes

type
 TkwWHILEDO = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� WHILEDO
[panel]���� While. ����������� ���� ����������� ��������� �������.
������:
[code] 10 @ ( ?DUP !=0 ) @ ( DUP . -- ) WHILEDO [code]
�� ����� ������������ ��������������� ������������ - WHILE[panel]
*������:*
[code]
 aCondition aWord WHILEDO
[code]  }
 private
 // private methods
   procedure WHILEDO(const aCtx: TtfwContext;
    aWord: TtfwWord;
    aCondition: TtfwWord);
     {* ���������� ����� ������� WHILEDO }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWHILEDO

// start class TkwWHILEDO

procedure TkwWHILEDO.WHILEDO(const aCtx: TtfwContext;
  aWord: TtfwWord;
  aCondition: TtfwWord);
//#UC START# *998553D17C4B_B8595935D002_var*
//#UC END# *998553D17C4B_B8595935D002_var*
begin
//#UC START# *998553D17C4B_B8595935D002_impl*
 while true do
 begin
  aCondition.DoIt(aCtx);
  if not aCtx.rEngine.PopBool then
   break;
  try
   aWord.DoIt(aCtx);
  except
   on EtfwBreak do
    break;
   on EtfwContinue do
    continue;
  end;//try..except
 end;//while true
//#UC END# *998553D17C4B_B8595935D002_impl*
end;//TkwWHILEDO.WHILEDO

procedure TkwWHILEDO.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWord : TtfwWord;
 l_aCondition : TtfwWord;
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
 try
  l_aCondition := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord, true));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCondition: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 WHILEDO(aCtx, l_aWord, l_aCondition);
end;//TkwWHILEDO.DoDoIt

class function TkwWHILEDO.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'WHILEDO';
end;//TkwWHILEDO.GetWordNameForRegister

function TkwWHILEDO.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwWHILEDO.GetResultTypeInfo

function TkwWHILEDO.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2;
end;//TkwWHILEDO.GetAllParamsCount

function TkwWHILEDO.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), TypeInfo(TtfwWord)]);
end;//TkwWHILEDO.ParamsTypes

type
 TkwBREAK = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� BREAK
[panel]����� �� �����[panel]
*������:*
[code]
 BREAK
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwBREAK

// start class TkwBREAK

procedure TkwBREAK.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9FA400CD8713_var*
//#UC END# *4DAEEDE10285_9FA400CD8713_var*
begin
//#UC START# *4DAEEDE10285_9FA400CD8713_impl*
 raise EtfwBreak.Instance;
 //raise EtfwBreak.Create('����� �� �����');
//#UC END# *4DAEEDE10285_9FA400CD8713_impl*
end;//TkwBREAK.DoDoIt

class function TkwBREAK.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'BREAK';
end;//TkwBREAK.GetWordNameForRegister

function TkwBREAK.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwBREAK.GetResultTypeInfo

function TkwBREAK.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwBREAK.GetAllParamsCount

type
 TkwCONTINUE = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� CONTINUE
[panel]������� � ������ �����[panel]
*������:*
[code]
 CONTINUE
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwCONTINUE

// start class TkwCONTINUE

procedure TkwCONTINUE.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_816E4F5C3613_var*
//#UC END# *4DAEEDE10285_816E4F5C3613_var*
begin
//#UC START# *4DAEEDE10285_816E4F5C3613_impl*
 raise EtfwContinue.Instance;
 //raise EtfwContinue.Create('����� �� ������ �����');
//#UC END# *4DAEEDE10285_816E4F5C3613_impl*
end;//TkwCONTINUE.DoDoIt

class function TkwCONTINUE.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'CONTINUE';
end;//TkwCONTINUE.GetWordNameForRegister

function TkwCONTINUE.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwCONTINUE.GetResultTypeInfo

function TkwCONTINUE.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwCONTINUE.GetAllParamsCount

type
 TkwEXIT = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� EXIT
[panel]����� �� ���������[panel]
*������:*
[code]
 EXIT
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwEXIT

// start class TkwEXIT

procedure TkwEXIT.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1A0EA325C2BC_var*
//#UC END# *4DAEEDE10285_1A0EA325C2BC_var*
begin
//#UC START# *4DAEEDE10285_1A0EA325C2BC_impl*
 raise EtfwExit.Instance;
 //raise EtfwExit.Create('����� �� ���������');
//#UC END# *4DAEEDE10285_1A0EA325C2BC_impl*
end;//TkwEXIT.DoDoIt

class function TkwEXIT.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'EXIT';
end;//TkwEXIT.GetWordNameForRegister

function TkwEXIT.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwEXIT.GetResultTypeInfo

function TkwEXIT.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwEXIT.GetAllParamsCount

type
 TkwHALT = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� HALT
[panel]�������� ���������� ������[panel]
*������:*
[code]
 HALT
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwHALT

// start class TkwHALT

procedure TkwHALT.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F7BD1ACB2D33_var*
//#UC END# *4DAEEDE10285_F7BD1ACB2D33_var*
begin
//#UC START# *4DAEEDE10285_F7BD1ACB2D33_impl*
 raise EtfwHalt.Instance;
 //raise EtfwHalt.Create('����� �� �������');
//#UC END# *4DAEEDE10285_F7BD1ACB2D33_impl*
end;//TkwHALT.DoDoIt

class function TkwHALT.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'HALT';
end;//TkwHALT.GetWordNameForRegister

function TkwHALT.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwHALT.GetResultTypeInfo

function TkwHALT.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwHALT.GetAllParamsCount

type
 TkwBREAKITERATOR = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� BREAK-ITERATOR
*������:*
[code]
 BREAK-ITERATOR
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwBREAKITERATOR

// start class TkwBREAKITERATOR

procedure TkwBREAKITERATOR.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4A2D97BCAC0E_var*
//#UC END# *4DAEEDE10285_4A2D97BCAC0E_var*
begin
//#UC START# *4DAEEDE10285_4A2D97BCAC0E_impl*
 raise EtfwBreakIterator.Instance;
 //raise EtfwBreakIterator.Create('����� �� ���������');
//#UC END# *4DAEEDE10285_4A2D97BCAC0E_impl*
end;//TkwBREAKITERATOR.DoDoIt

class function TkwBREAKITERATOR.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'BREAK-ITERATOR';
end;//TkwBREAKITERATOR.GetWordNameForRegister

function TkwBREAKITERATOR.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwBREAKITERATOR.GetResultTypeInfo

function TkwBREAKITERATOR.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwBREAKITERATOR.GetAllParamsCount

type
 TkwNOP = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� NOP
*������:*
[code]
 NOP
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwNOP

// start class TkwNOP

procedure TkwNOP.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_143C5B139D7D_var*
//#UC END# *4DAEEDE10285_143C5B139D7D_var*
begin
//#UC START# *4DAEEDE10285_143C5B139D7D_impl*
 // - ��������� ������ �� ������
//#UC END# *4DAEEDE10285_143C5B139D7D_impl*
end;//TkwNOP.DoDoIt

class function TkwNOP.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'NOP';
end;//TkwNOP.GetWordNameForRegister

function TkwNOP.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwNOP.GetResultTypeInfo

function TkwNOP.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwNOP.GetAllParamsCount

type
 TkwSLEEP = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� SLEEP
*������:*
[code]
 aDuration SLEEP
[code]  }
 private
 // private methods
   procedure SLEEP(const aCtx: TtfwContext;
    aDuration: Integer);
     {* ���������� ����� ������� SLEEP }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSLEEP

// start class TkwSLEEP

procedure TkwSLEEP.SLEEP(const aCtx: TtfwContext;
  aDuration: Integer);
//#UC START# *4DB1E11DA389_837DF133349F_var*
//#UC END# *4DB1E11DA389_837DF133349F_var*
begin
//#UC START# *4DB1E11DA389_837DF133349F_impl*
 SysUtils.Sleep(aDuration);
//#UC END# *4DB1E11DA389_837DF133349F_impl*
end;//TkwSLEEP.SLEEP

procedure TkwSLEEP.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aDuration : Integer;
begin
 try
  l_aDuration := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDuration: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SLEEP(aCtx, l_aDuration);
end;//TkwSLEEP.DoDoIt

class function TkwSLEEP.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'SLEEP';
end;//TkwSLEEP.GetWordNameForRegister

function TkwSLEEP.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwSLEEP.GetResultTypeInfo

function TkwSLEEP.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwSLEEP.GetAllParamsCount

function TkwSLEEP.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwSLEEP.ParamsTypes

type
 TkwProcessMessages = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� ProcessMessages
*������:*
[code]
 ProcessMessages
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwProcessMessages

// start class TkwProcessMessages

procedure TkwProcessMessages.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E4C5BF333038_var*
//#UC END# *4DAEEDE10285_E4C5BF333038_var*
begin
//#UC START# *4DAEEDE10285_E4C5BF333038_impl*
 try
  Tl3MessagesService.Instance.ProcessMessages;
 except
  on E: Exception do
  begin
   l3System.Exception2Log(E);
   raise;
  end;//on E: Exception
 end;//try..finally
//#UC END# *4DAEEDE10285_E4C5BF333038_impl*
end;//TkwProcessMessages.DoDoIt

class function TkwProcessMessages.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'ProcessMessages';
end;//TkwProcessMessages.GetWordNameForRegister

function TkwProcessMessages.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwProcessMessages.GetResultTypeInfo

function TkwProcessMessages.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwProcessMessages.GetAllParamsCount

type
 TkwCheckAssert = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� ASSERT
[panel]������� Assert.
������:
[code]
 waited:? ASSERT
[code][panel]
*������:*
[code]
 aCondition ASSERT
[code]  }
 private
 // private methods
   procedure CheckAssert(const aCtx: TtfwContext;
    aCondition: Boolean);
     {* ���������� ����� ������� ASSERT }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCheckAssert

// start class TkwCheckAssert

procedure TkwCheckAssert.CheckAssert(const aCtx: TtfwContext;
  aCondition: Boolean);
//#UC START# *A9F0DE62C340_21B5CB646447_var*
//#UC END# *A9F0DE62C340_21B5CB646447_var*
begin
//#UC START# *A9F0DE62C340_21B5CB646447_impl*
 aCtx.rCaller.Check(aCondition);
//#UC END# *A9F0DE62C340_21B5CB646447_impl*
end;//TkwCheckAssert.CheckAssert

procedure TkwCheckAssert.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCondition : Boolean;
begin
 try
  l_aCondition := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCondition: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CheckAssert(aCtx, l_aCondition);
end;//TkwCheckAssert.DoDoIt

class function TkwCheckAssert.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'ASSERT';
end;//TkwCheckAssert.GetWordNameForRegister

function TkwCheckAssert.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwCheckAssert.GetResultTypeInfo

function TkwCheckAssert.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwCheckAssert.GetAllParamsCount

function TkwCheckAssert.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Boolean)]);
end;//TkwCheckAssert.ParamsTypes

type
 TkwASSERTS = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� ASSERTS
[panel]���������� Assert, �� ��������� �� ������ ������� �� �����[panel]
*������:*
[code]
 aCondition aMsg ASSERTS
[code]  }
 private
 // private methods
   procedure ASSERTS(const aCtx: TtfwContext;
    const aMsg: AnsiString;
    aCondition: Boolean);
     {* ���������� ����� ������� ASSERTS }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwASSERTS

// start class TkwASSERTS

procedure TkwASSERTS.ASSERTS(const aCtx: TtfwContext;
  const aMsg: AnsiString;
  aCondition: Boolean);
//#UC START# *C32D02D46DF5_EC908CD7498C_var*
//#UC END# *C32D02D46DF5_EC908CD7498C_var*
begin
//#UC START# *C32D02D46DF5_EC908CD7498C_impl*
 aCtx.rCaller.Check(aCondition, aMsg);
//#UC END# *C32D02D46DF5_EC908CD7498C_impl*
end;//TkwASSERTS.ASSERTS

procedure TkwASSERTS.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMsg : AnsiString;
 l_aCondition : Boolean;
begin
 try
  l_aMsg := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMsg: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aCondition := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCondition: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 ASSERTS(aCtx, l_aMsg, l_aCondition);
end;//TkwASSERTS.DoDoIt

class function TkwASSERTS.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'ASSERTS';
end;//TkwASSERTS.GetWordNameForRegister

function TkwASSERTS.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwASSERTS.GetResultTypeInfo

function TkwASSERTS.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2;
end;//TkwASSERTS.GetAllParamsCount

function TkwASSERTS.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(AnsiString), TypeInfo(Boolean)]);
end;//TkwASSERTS.ParamsTypes

type
 TkwNil = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� nil
*������:*
[code]
 nil
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwNil

// start class TkwNil

procedure TkwNil.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D498DDF5F479_var*
//#UC END# *4DAEEDE10285_D498DDF5F479_var*
begin
//#UC START# *4DAEEDE10285_D498DDF5F479_impl*
 aCtx.rEngine.Push(TtfwStackValue_NULL);
//#UC END# *4DAEEDE10285_D498DDF5F479_impl*
end;//TkwNil.DoDoIt

class function TkwNil.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'nil';
end;//TkwNil.GetWordNameForRegister

function TkwNil.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwNil.GetResultTypeInfo

function TkwNil.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwNil.GetAllParamsCount

type
 TkwDoWord = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� DO
[panel]��������� ���������������� �����.[panel]
*������:*
[code]
 aWord DO
[code]  }
 private
 // private methods
   procedure DoWord(const aCtx: TtfwContext;
    aWord: TtfwWord);
     {* ���������� ����� ������� DO }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDoWord

// start class TkwDoWord

procedure TkwDoWord.DoWord(const aCtx: TtfwContext;
  aWord: TtfwWord);
//#UC START# *61B2E2983CE5_8756115930CD_var*
//#UC END# *61B2E2983CE5_8756115930CD_var*
begin
//#UC START# *61B2E2983CE5_8756115930CD_impl*
 aWord.DoIt(aCtx);
//#UC END# *61B2E2983CE5_8756115930CD_impl*
end;//TkwDoWord.DoWord

procedure TkwDoWord.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWord : TtfwWord;
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
 DoWord(aCtx, l_aWord);
end;//TkwDoWord.DoDoIt

class function TkwDoWord.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'DO';
end;//TkwDoWord.GetWordNameForRegister

function TkwDoWord.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwDoWord.GetResultTypeInfo

function TkwDoWord.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwDoWord.GetAllParamsCount

function TkwDoWord.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwDoWord.ParamsTypes

type
 TkwSmartEquals = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� ?==
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aV2 aV1 ?== >>> l_Boolean
[code]  }
 private
 // private methods
   function SmartEquals(const aCtx: TtfwContext;
    const aV1: TtfwStackValue;
    const aV2: TtfwStackValue): Boolean;
     {* ���������� ����� ������� ?== }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSmartEquals

// start class TkwSmartEquals

function TkwSmartEquals.SmartEquals(const aCtx: TtfwContext;
  const aV1: TtfwStackValue;
  const aV2: TtfwStackValue): Boolean;
//#UC START# *60743477D321_C3CE906B1F67_var*
//#UC END# *60743477D321_C3CE906B1F67_var*
begin
//#UC START# *60743477D321_C3CE906B1F67_impl*
 Result := CompareValues(aV1, aV2, aCtx, Self);
//#UC END# *60743477D321_C3CE906B1F67_impl*
end;//TkwSmartEquals.SmartEquals

procedure TkwSmartEquals.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aV1 : TtfwStackValue;
 l_aV2 : TtfwStackValue;
begin
 try
  l_aV1 := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aV1: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aV2 := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aV2: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((SmartEquals(aCtx, l_aV1, l_aV2)));
end;//TkwSmartEquals.DoDoIt

class function TkwSmartEquals.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '?==';
end;//TkwSmartEquals.GetWordNameForRegister

function TkwSmartEquals.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwSmartEquals.GetResultTypeInfo

function TkwSmartEquals.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2;
end;//TkwSmartEquals.GetAllParamsCount

function TkwSmartEquals.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiStruct, @tfw_tiStruct]);
end;//TkwSmartEquals.ParamsTypes

type
 TkwSmartNotEquals = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� ?!=
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aV2 aV1 ?!= >>> l_Boolean
[code]  }
 private
 // private methods
   function SmartNotEquals(const aCtx: TtfwContext;
    const aV1: TtfwStackValue;
    const aV2: TtfwStackValue): Boolean;
     {* ���������� ����� ������� ?!= }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSmartNotEquals

// start class TkwSmartNotEquals

function TkwSmartNotEquals.SmartNotEquals(const aCtx: TtfwContext;
  const aV1: TtfwStackValue;
  const aV2: TtfwStackValue): Boolean;
//#UC START# *1E530026939A_CC9B8514F681_var*
//#UC END# *1E530026939A_CC9B8514F681_var*
begin
//#UC START# *1E530026939A_CC9B8514F681_impl*
 Result := not CompareValues(aV1, aV2, aCtx, Self);
//#UC END# *1E530026939A_CC9B8514F681_impl*
end;//TkwSmartNotEquals.SmartNotEquals

procedure TkwSmartNotEquals.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aV1 : TtfwStackValue;
 l_aV2 : TtfwStackValue;
begin
 try
  l_aV1 := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aV1: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aV2 := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aV2: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((SmartNotEquals(aCtx, l_aV1, l_aV2)));
end;//TkwSmartNotEquals.DoDoIt

class function TkwSmartNotEquals.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '?!=';
end;//TkwSmartNotEquals.GetWordNameForRegister

function TkwSmartNotEquals.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwSmartNotEquals.GetResultTypeInfo

function TkwSmartNotEquals.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2;
end;//TkwSmartNotEquals.GetAllParamsCount

function TkwSmartNotEquals.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiStruct, @tfw_tiStruct]);
end;//TkwSmartNotEquals.ParamsTypes

type
 TkwPushWord = {final scriptword} class(TtfwWordWorkerEx)
  {* ����� ������� @
[panel]����� �� ���� ����� ���������� �����[panel]
*��� ����������:* TtfwWord
*������:*
[code]
OBJECT VAR l_TtfwWord
 @ aWord >>> l_TtfwWord
[code]  }
 private
 // private methods
   function PushWord(const aCtx: TtfwContext;
    aWord: TtfwWord): TtfwWord;
     {* ���������� ����� ������� @ }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function SuppressNextImmediate(const aContext: TtfwContext;
     aWordNumber: Integer): TtfwSuppressNextImmediate; override;
 public
 // overridden public methods
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   procedure DoRun(const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPushWord

// start class TkwPushWord

function TkwPushWord.PushWord(const aCtx: TtfwContext;
  aWord: TtfwWord): TtfwWord;
//#UC START# *E64338F25E47_D110B4F78BD0_var*
//#UC END# *E64338F25E47_D110B4F78BD0_var*
begin
//#UC START# *E64338F25E47_D110B4F78BD0_impl*
 Result := aWord;
//#UC END# *E64338F25E47_D110B4F78BD0_impl*
end;//TkwPushWord.PushWord

class function TkwPushWord.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '@';
end;//TkwPushWord.GetWordNameForRegister

function TkwPushWord.SuppressNextImmediate(const aContext: TtfwContext;
  aWordNumber: Integer): TtfwSuppressNextImmediate;
 {-}
begin
 Result := tfw_sniYes;
end;//TkwPushWord.SuppressNextImmediate

function TkwPushWord.RightParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwPushWord.RightParamsCount

procedure TkwPushWord.DoRun(const aCtx: TtfwContext);
 {-}
var
 l_aWord : TtfwWord;
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
 aCtx.rEngine.PushObj((PushWord(aCtx, l_aWord)));
end;//TkwPushWord.DoRun

function TkwPushWord.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwWord);
end;//TkwPushWord.GetResultTypeInfo

function TkwPushWord.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPushWord.GetAllParamsCount

function TkwPushWord.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPushWord.ParamsTypes

type
 TkwCurrentException = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� current:exception
*��� ����������:* TObject
*������:*
[code]
OBJECT VAR l_TObject
 current:exception >>> l_TObject
[code]  }
 private
 // private methods
   function CurrentException(const aCtx: TtfwContext): TObject;
     {* ���������� ����� ������� current:exception }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCurrentException

// start class TkwCurrentException

function TkwCurrentException.CurrentException(const aCtx: TtfwContext): TObject;
//#UC START# *6715463935A1_FC4619680919_var*
//#UC END# *6715463935A1_FC4619680919_var*
begin
//#UC START# *6715463935A1_FC4619680919_impl*
 Result := aCtx.rException;
//#UC END# *6715463935A1_FC4619680919_impl*
end;//TkwCurrentException.CurrentException

procedure TkwCurrentException.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushObj((CurrentException(aCtx)));
end;//TkwCurrentException.DoDoIt

class function TkwCurrentException.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'current:exception';
end;//TkwCurrentException.GetWordNameForRegister

function TkwCurrentException.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TObject);
end;//TkwCurrentException.GetResultTypeInfo

function TkwCurrentException.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwCurrentException.GetAllParamsCount

function TkwCurrentException.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwCurrentException.ParamsTypes

type
 TkwCurrentExceptionClass = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� current:exception:class
*��� ����������:* TClass
*������:*
[code]
CLASS VAR l_TClass
 current:exception:class >>> l_TClass
[code]  }
 private
 // private methods
   function CurrentExceptionClass(const aCtx: TtfwContext): TClass;
     {* ���������� ����� ������� current:exception:class }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCurrentExceptionClass

// start class TkwCurrentExceptionClass

function TkwCurrentExceptionClass.CurrentExceptionClass(const aCtx: TtfwContext): TClass;
//#UC START# *E3D187DF3985_1AF5C18788F4_var*
//#UC END# *E3D187DF3985_1AF5C18788F4_var*
begin
//#UC START# *E3D187DF3985_1AF5C18788F4_impl*
 if (aCtx.rException = nil) then
  Result := nil
 else
  Result := aCtx.rException.ClassType;
//#UC END# *E3D187DF3985_1AF5C18788F4_impl*
end;//TkwCurrentExceptionClass.CurrentExceptionClass

procedure TkwCurrentExceptionClass.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushClass((CurrentExceptionClass(aCtx)));
end;//TkwCurrentExceptionClass.DoDoIt

class function TkwCurrentExceptionClass.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'current:exception:class';
end;//TkwCurrentExceptionClass.GetWordNameForRegister

function TkwCurrentExceptionClass.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiClassRef;
end;//TkwCurrentExceptionClass.GetResultTypeInfo

function TkwCurrentExceptionClass.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwCurrentExceptionClass.GetAllParamsCount

function TkwCurrentExceptionClass.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwCurrentExceptionClass.ParamsTypes

type
 TkwCurrentExceptionClassName = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� current:exception:ClassName
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 current:exception:ClassName >>> l_String
[code]  }
 private
 // private methods
   function CurrentExceptionClassName(const aCtx: TtfwContext): AnsiString;
     {* ���������� ����� ������� current:exception:ClassName }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCurrentExceptionClassName

// start class TkwCurrentExceptionClassName

function TkwCurrentExceptionClassName.CurrentExceptionClassName(const aCtx: TtfwContext): AnsiString;
//#UC START# *4B72A5BBE511_884F3012E3E7_var*
//#UC END# *4B72A5BBE511_884F3012E3E7_var*
begin
//#UC START# *4B72A5BBE511_884F3012E3E7_impl*
 if (aCtx.rException = nil) then
  Result := ''
 else
  Result := aCtx.rException.ClassName;
//#UC END# *4B72A5BBE511_884F3012E3E7_impl*
end;//TkwCurrentExceptionClassName.CurrentExceptionClassName

procedure TkwCurrentExceptionClassName.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString((CurrentExceptionClassName(aCtx)));
end;//TkwCurrentExceptionClassName.DoDoIt

class function TkwCurrentExceptionClassName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'current:exception:ClassName';
end;//TkwCurrentExceptionClassName.GetWordNameForRegister

function TkwCurrentExceptionClassName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(AnsiString);
end;//TkwCurrentExceptionClassName.GetResultTypeInfo

function TkwCurrentExceptionClassName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwCurrentExceptionClassName.GetAllParamsCount

function TkwCurrentExceptionClassName.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwCurrentExceptionClassName.ParamsTypes

type
 TkwCurrentExceptionMessage = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� current:exception:Message
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 current:exception:Message >>> l_String
[code]  }
 private
 // private methods
   function CurrentExceptionMessage(const aCtx: TtfwContext): AnsiString;
     {* ���������� ����� ������� current:exception:Message }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCurrentExceptionMessage

// start class TkwCurrentExceptionMessage

function TkwCurrentExceptionMessage.CurrentExceptionMessage(const aCtx: TtfwContext): AnsiString;
//#UC START# *51C60F25F7F2_700EDDB5F050_var*
//#UC END# *51C60F25F7F2_700EDDB5F050_var*
begin
//#UC START# *51C60F25F7F2_700EDDB5F050_impl*
 if (aCtx.rException = nil) then
  Result := ''
 else
  Result := aCtx.rException.Message;
//#UC END# *51C60F25F7F2_700EDDB5F050_impl*
end;//TkwCurrentExceptionMessage.CurrentExceptionMessage

procedure TkwCurrentExceptionMessage.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString((CurrentExceptionMessage(aCtx)));
end;//TkwCurrentExceptionMessage.DoDoIt

class function TkwCurrentExceptionMessage.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'current:exception:Message';
end;//TkwCurrentExceptionMessage.GetWordNameForRegister

function TkwCurrentExceptionMessage.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(AnsiString);
end;//TkwCurrentExceptionMessage.GetResultTypeInfo

function TkwCurrentExceptionMessage.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwCurrentExceptionMessage.GetAllParamsCount

function TkwCurrentExceptionMessage.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwCurrentExceptionMessage.ParamsTypes

type
 TkwInc = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� ++
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aValue ++ >>> l_Integer
[code]  }
 private
 // private methods
   function Inc(const aCtx: TtfwContext;
    aValue: Integer): Integer;
     {* ���������� ����� ������� ++ }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwInc

// start class TkwInc

function TkwInc.Inc(const aCtx: TtfwContext;
  aValue: Integer): Integer;
//#UC START# *D77DFD505D71_EC8ABDF1263C_var*
//#UC END# *D77DFD505D71_EC8ABDF1263C_var*
begin
//#UC START# *D77DFD505D71_EC8ABDF1263C_impl*
 Result := aValue + 1;
//#UC END# *D77DFD505D71_EC8ABDF1263C_impl*
end;//TkwInc.Inc

procedure TkwInc.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aValue : Integer;
begin
 try
  l_aValue := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((Inc(aCtx, l_aValue)));
end;//TkwInc.DoDoIt

class function TkwInc.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '++';
end;//TkwInc.GetWordNameForRegister

function TkwInc.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwInc.GetResultTypeInfo

function TkwInc.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwInc.GetAllParamsCount

function TkwInc.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwInc.ParamsTypes

type
 TkwDec = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� --
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aValue -- >>> l_Integer
[code]  }
 private
 // private methods
   function Dec(const aCtx: TtfwContext;
    aValue: Integer): Integer;
     {* ���������� ����� ������� -- }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDec

// start class TkwDec

function TkwDec.Dec(const aCtx: TtfwContext;
  aValue: Integer): Integer;
//#UC START# *953F49C35391_B2F2C7D2DE77_var*
//#UC END# *953F49C35391_B2F2C7D2DE77_var*
begin
//#UC START# *953F49C35391_B2F2C7D2DE77_impl*
 Result := aValue - 1;
//#UC END# *953F49C35391_B2F2C7D2DE77_impl*
end;//TkwDec.Dec

procedure TkwDec.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aValue : Integer;
begin
 try
  l_aValue := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((Dec(aCtx, l_aValue)));
end;//TkwDec.DoDoIt

class function TkwDec.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '--';
end;//TkwDec.GetWordNameForRegister

function TkwDec.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwDec.GetResultTypeInfo

function TkwDec.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwDec.GetAllParamsCount

function TkwDec.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwDec.ParamsTypes

type
 TkwAdd = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� +
*��� ����������:* TtfwStackValue
*������:*
[code]
VAR l_TtfwStackValue
 aA aB + >>> l_TtfwStackValue
[code]  }
 private
 // private methods
   function Add(const aCtx: TtfwContext;
    const aB: TtfwStackValue;
    const aA: TtfwStackValue): TtfwStackValue;
     {* ���������� ����� ������� + }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAdd

// start class TkwAdd

function TkwAdd.Add(const aCtx: TtfwContext;
  const aB: TtfwStackValue;
  const aA: TtfwStackValue): TtfwStackValue;
//#UC START# *4A2B2E436561_9C21970CCFB0_var*
//#UC END# *4A2B2E436561_9C21970CCFB0_var*
begin
//#UC START# *4A2B2E436561_9C21970CCFB0_impl*
 Case aA.rType of
  tfw_vtInt:
   Result := TtfwStackValue_C(aA.AsInt + aB.AsInt);
  tfw_vtStr:
   Result := TtfwStackValue_C(TtfwCStringFactory.Cat(aA.AsString, aB.AsString));
  else
  begin
   Result := TtfwStackValue_E;
   BadValueType(aA.rType, aCtx);
  end;//else
 end;//Case aA.rType
//#UC END# *4A2B2E436561_9C21970CCFB0_impl*
end;//TkwAdd.Add

procedure TkwAdd.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aB : TtfwStackValue;
 l_aA : TtfwStackValue;
begin
 try
  l_aB := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aB: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aA: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.Push((Add(aCtx, l_aB, l_aA)));
end;//TkwAdd.DoDoIt

class function TkwAdd.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '+';
end;//TkwAdd.GetWordNameForRegister

function TkwAdd.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiStruct;
end;//TkwAdd.GetResultTypeInfo

function TkwAdd.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2;
end;//TkwAdd.GetAllParamsCount

function TkwAdd.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiStruct, @tfw_tiStruct]);
end;//TkwAdd.ParamsTypes

type
 TkwSub = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� -
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aA aB - >>> l_Integer
[code]  }
 private
 // private methods
   function Sub(const aCtx: TtfwContext;
    aB: Integer;
    aA: Integer): Integer;
     {* ���������� ����� ������� - }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSub

// start class TkwSub

function TkwSub.Sub(const aCtx: TtfwContext;
  aB: Integer;
  aA: Integer): Integer;
//#UC START# *48DD1F61327A_07CF656336AF_var*
//#UC END# *48DD1F61327A_07CF656336AF_var*
begin
//#UC START# *48DD1F61327A_07CF656336AF_impl*
 Result := aA - aB;
//#UC END# *48DD1F61327A_07CF656336AF_impl*
end;//TkwSub.Sub

procedure TkwSub.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aB : Integer;
 l_aA : Integer;
begin
 try
  l_aB := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aB: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aA: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((Sub(aCtx, l_aB, l_aA)));
end;//TkwSub.DoDoIt

class function TkwSub.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '-';
end;//TkwSub.GetWordNameForRegister

function TkwSub.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwSub.GetResultTypeInfo

function TkwSub.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2;
end;//TkwSub.GetAllParamsCount

function TkwSub.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwSub.ParamsTypes

type
 TkwDivision = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� DIV
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aA aB DIV >>> l_Integer
[code]  }
 private
 // private methods
   function Division(const aCtx: TtfwContext;
    aB: Integer;
    aA: Integer): Integer;
     {* ���������� ����� ������� DIV }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDivision

// start class TkwDivision

function TkwDivision.Division(const aCtx: TtfwContext;
  aB: Integer;
  aA: Integer): Integer;
//#UC START# *88D113F4B496_E81F1590332D_var*
//#UC END# *88D113F4B496_E81F1590332D_var*
begin
//#UC START# *88D113F4B496_E81F1590332D_impl*
 Result := aA div aB;
//#UC END# *88D113F4B496_E81F1590332D_impl*
end;//TkwDivision.Division

procedure TkwDivision.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aB : Integer;
 l_aA : Integer;
begin
 try
  l_aB := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aB: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aA: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((Division(aCtx, l_aB, l_aA)));
end;//TkwDivision.DoDoIt

class function TkwDivision.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'DIV';
end;//TkwDivision.GetWordNameForRegister

function TkwDivision.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwDivision.GetResultTypeInfo

function TkwDivision.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2;
end;//TkwDivision.GetAllParamsCount

function TkwDivision.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwDivision.ParamsTypes

type
 TkwMul = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� *
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aA aB * >>> l_Integer
[code]  }
 private
 // private methods
   function Mul(const aCtx: TtfwContext;
    aB: Integer;
    aA: Integer): Integer;
     {* ���������� ����� ������� * }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMul

// start class TkwMul

function TkwMul.Mul(const aCtx: TtfwContext;
  aB: Integer;
  aA: Integer): Integer;
//#UC START# *5AE4AB3CE60E_0B21BAF8C4D4_var*
//#UC END# *5AE4AB3CE60E_0B21BAF8C4D4_var*
begin
//#UC START# *5AE4AB3CE60E_0B21BAF8C4D4_impl*
 Result := aA * aB;
//#UC END# *5AE4AB3CE60E_0B21BAF8C4D4_impl*
end;//TkwMul.Mul

procedure TkwMul.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aB : Integer;
 l_aA : Integer;
begin
 try
  l_aB := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aB: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aA: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((Mul(aCtx, l_aB, l_aA)));
end;//TkwMul.DoDoIt

class function TkwMul.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '*';
end;//TkwMul.GetWordNameForRegister

function TkwMul.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwMul.GetResultTypeInfo

function TkwMul.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2;
end;//TkwMul.GetAllParamsCount

function TkwMul.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwMul.ParamsTypes

type
 TkwDivide = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� /
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aA aB / >>> l_Integer
[code]  }
 private
 // private methods
   function Divide(const aCtx: TtfwContext;
    aB: Integer;
    aA: Integer): Integer;
     {* ���������� ����� ������� / }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDivide

// start class TkwDivide

function TkwDivide.Divide(const aCtx: TtfwContext;
  aB: Integer;
  aA: Integer): Integer;
//#UC START# *736A69199423_3396B991D47C_var*
//#UC END# *736A69199423_3396B991D47C_var*
begin
//#UC START# *736A69199423_3396B991D47C_impl*
 Result := aA div aB;
//#UC END# *736A69199423_3396B991D47C_impl*
end;//TkwDivide.Divide

procedure TkwDivide.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aB : Integer;
 l_aA : Integer;
begin
 try
  l_aB := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aB: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aA: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((Divide(aCtx, l_aB, l_aA)));
end;//TkwDivide.DoDoIt

class function TkwDivide.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '/';
end;//TkwDivide.GetWordNameForRegister

function TkwDivide.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwDivide.GetResultTypeInfo

function TkwDivide.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2;
end;//TkwDivide.GetAllParamsCount

function TkwDivide.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwDivide.ParamsTypes

type
 TkwMul2 = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� 2*
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aA 2* >>> l_Integer
[code]  }
 private
 // private methods
   function Mul2(const aCtx: TtfwContext;
    aA: Integer): Integer;
     {* ���������� ����� ������� 2* }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMul2

// start class TkwMul2

function TkwMul2.Mul2(const aCtx: TtfwContext;
  aA: Integer): Integer;
//#UC START# *344C0B9A5E91_2281645E0EB6_var*
//#UC END# *344C0B9A5E91_2281645E0EB6_var*
begin
//#UC START# *344C0B9A5E91_2281645E0EB6_impl*
 Result := aA shl 1;
//#UC END# *344C0B9A5E91_2281645E0EB6_impl*
end;//TkwMul2.Mul2

procedure TkwMul2.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aA : Integer;
begin
 try
  l_aA := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aA: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((Mul2(aCtx, l_aA)));
end;//TkwMul2.DoDoIt

class function TkwMul2.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '2*';
end;//TkwMul2.GetWordNameForRegister

function TkwMul2.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwMul2.GetResultTypeInfo

function TkwMul2.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwMul2.GetAllParamsCount

function TkwMul2.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwMul2.ParamsTypes

type
 TkwDiv2 = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� 2/
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aA 2/ >>> l_Integer
[code]  }
 private
 // private methods
   function Div2(const aCtx: TtfwContext;
    aA: Integer): Integer;
     {* ���������� ����� ������� 2/ }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDiv2

// start class TkwDiv2

function TkwDiv2.Div2(const aCtx: TtfwContext;
  aA: Integer): Integer;
//#UC START# *FEC2D095F55C_F236BCF7B4F7_var*
//#UC END# *FEC2D095F55C_F236BCF7B4F7_var*
begin
//#UC START# *FEC2D095F55C_F236BCF7B4F7_impl*
 Result := aA shr 1;
//#UC END# *FEC2D095F55C_F236BCF7B4F7_impl*
end;//TkwDiv2.Div2

procedure TkwDiv2.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aA : Integer;
begin
 try
  l_aA := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aA: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((Div2(aCtx, l_aA)));
end;//TkwDiv2.DoDoIt

class function TkwDiv2.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '2/';
end;//TkwDiv2.GetWordNameForRegister

function TkwDiv2.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwDiv2.GetResultTypeInfo

function TkwDiv2.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwDiv2.GetAllParamsCount

function TkwDiv2.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwDiv2.ParamsTypes

type
 TkwMulDiv = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� */
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aA aB aC */ >>> l_Integer
[code]  }
 private
 // private methods
   function MulDiv(const aCtx: TtfwContext;
    aC: Integer;
    aB: Integer;
    aA: Integer): Integer;
     {* ���������� ����� ������� */ }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMulDiv

// start class TkwMulDiv

function TkwMulDiv.MulDiv(const aCtx: TtfwContext;
  aC: Integer;
  aB: Integer;
  aA: Integer): Integer;
//#UC START# *1D630924D3F3_DD076C655ECA_var*
//#UC END# *1D630924D3F3_DD076C655ECA_var*
begin
//#UC START# *1D630924D3F3_DD076C655ECA_impl*
 Result := l3MulDiv(aA, aB, aC);
//#UC END# *1D630924D3F3_DD076C655ECA_impl*
end;//TkwMulDiv.MulDiv

procedure TkwMulDiv.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aC : Integer;
 l_aB : Integer;
 l_aA : Integer;
begin
 try
  l_aC := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aC: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aB := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aB: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aA: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((MulDiv(aCtx, l_aC, l_aB, l_aA)));
end;//TkwMulDiv.DoDoIt

class function TkwMulDiv.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '*/';
end;//TkwMulDiv.GetWordNameForRegister

function TkwMulDiv.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwMulDiv.GetResultTypeInfo

function TkwMulDiv.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 3;
end;//TkwMulDiv.GetAllParamsCount

function TkwMulDiv.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer), TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwMulDiv.ParamsTypes

type
 TkwBoolNot = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� !
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aA ! >>> l_Boolean
[code]  }
 private
 // private methods
   function BoolNot(const aCtx: TtfwContext;
    aA: Boolean): Boolean;
     {* ���������� ����� ������� ! }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBoolNot

// start class TkwBoolNot

function TkwBoolNot.BoolNot(const aCtx: TtfwContext;
  aA: Boolean): Boolean;
//#UC START# *CAC63578DC71_DE39DE30D615_var*
//#UC END# *CAC63578DC71_DE39DE30D615_var*
begin
//#UC START# *CAC63578DC71_DE39DE30D615_impl*
 Result := not aA;
//#UC END# *CAC63578DC71_DE39DE30D615_impl*
end;//TkwBoolNot.BoolNot

procedure TkwBoolNot.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aA : Boolean;
begin
 try
  l_aA := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aA: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((BoolNot(aCtx, l_aA)));
end;//TkwBoolNot.DoDoIt

class function TkwBoolNot.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '!';
end;//TkwBoolNot.GetWordNameForRegister

function TkwBoolNot.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwBoolNot.GetResultTypeInfo

function TkwBoolNot.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwBoolNot.GetAllParamsCount

function TkwBoolNot.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Boolean)]);
end;//TkwBoolNot.ParamsTypes

type
 TkwModFromDiv = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� MOD
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aA aB MOD >>> l_Integer
[code]  }
 private
 // private methods
   function ModFromDiv(const aCtx: TtfwContext;
    aB: Integer;
    aA: Integer): Integer;
     {* ���������� ����� ������� MOD }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwModFromDiv

// start class TkwModFromDiv

function TkwModFromDiv.ModFromDiv(const aCtx: TtfwContext;
  aB: Integer;
  aA: Integer): Integer;
//#UC START# *6F1D80D40414_6CA2C2693736_var*
//#UC END# *6F1D80D40414_6CA2C2693736_var*
begin
//#UC START# *6F1D80D40414_6CA2C2693736_impl*
 Result := aA mod aB;
//#UC END# *6F1D80D40414_6CA2C2693736_impl*
end;//TkwModFromDiv.ModFromDiv

procedure TkwModFromDiv.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aB : Integer;
 l_aA : Integer;
begin
 try
  l_aB := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aB: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aA: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((ModFromDiv(aCtx, l_aB, l_aA)));
end;//TkwModFromDiv.DoDoIt

class function TkwModFromDiv.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'MOD';
end;//TkwModFromDiv.GetWordNameForRegister

function TkwModFromDiv.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwModFromDiv.GetResultTypeInfo

function TkwModFromDiv.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2;
end;//TkwModFromDiv.GetAllParamsCount

function TkwModFromDiv.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwModFromDiv.ParamsTypes

type
 TkwBoolAnd = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� &&
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aA aB && >>> l_Boolean
[code]  }
 private
 // private methods
   function BoolAnd(const aCtx: TtfwContext;
    aB: Boolean;
    aA: Boolean): Boolean;
     {* ���������� ����� ������� && }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBoolAnd

// start class TkwBoolAnd

function TkwBoolAnd.BoolAnd(const aCtx: TtfwContext;
  aB: Boolean;
  aA: Boolean): Boolean;
//#UC START# *B5F366B3195C_B473FE645DEA_var*
//#UC END# *B5F366B3195C_B473FE645DEA_var*
begin
//#UC START# *B5F366B3195C_B473FE645DEA_impl*
 Result := aA AND aB;
//#UC END# *B5F366B3195C_B473FE645DEA_impl*
end;//TkwBoolAnd.BoolAnd

procedure TkwBoolAnd.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aB : Boolean;
 l_aA : Boolean;
begin
 try
  l_aB := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aB: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aA: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((BoolAnd(aCtx, l_aB, l_aA)));
end;//TkwBoolAnd.DoDoIt

class function TkwBoolAnd.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '&&';
end;//TkwBoolAnd.GetWordNameForRegister

function TkwBoolAnd.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwBoolAnd.GetResultTypeInfo

function TkwBoolAnd.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2;
end;//TkwBoolAnd.GetAllParamsCount

function TkwBoolAnd.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Boolean), TypeInfo(Boolean)]);
end;//TkwBoolAnd.ParamsTypes

type
 TkwBoolOr = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� ||
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aA aB || >>> l_Boolean
[code]  }
 private
 // private methods
   function BoolOr(const aCtx: TtfwContext;
    aB: Boolean;
    aA: Boolean): Boolean;
     {* ���������� ����� ������� || }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBoolOr

// start class TkwBoolOr

function TkwBoolOr.BoolOr(const aCtx: TtfwContext;
  aB: Boolean;
  aA: Boolean): Boolean;
//#UC START# *A7F5B8B75EED_26485F660013_var*
//#UC END# *A7F5B8B75EED_26485F660013_var*
begin
//#UC START# *A7F5B8B75EED_26485F660013_impl*
 Result := aA OR aB;
//#UC END# *A7F5B8B75EED_26485F660013_impl*
end;//TkwBoolOr.BoolOr

procedure TkwBoolOr.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aB : Boolean;
 l_aA : Boolean;
begin
 try
  l_aB := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aB: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aA: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((BoolOr(aCtx, l_aB, l_aA)));
end;//TkwBoolOr.DoDoIt

class function TkwBoolOr.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '||';
end;//TkwBoolOr.GetWordNameForRegister

function TkwBoolOr.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwBoolOr.GetResultTypeInfo

function TkwBoolOr.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2;
end;//TkwBoolOr.GetAllParamsCount

function TkwBoolOr.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Boolean), TypeInfo(Boolean)]);
end;//TkwBoolOr.ParamsTypes

type
 TkwNotZero = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� !=0
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aA !=0 >>> l_Boolean
[code]  }
 private
 // private methods
   function NotZero(const aCtx: TtfwContext;
    aA: Integer): Boolean;
     {* ���������� ����� ������� !=0 }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNotZero

// start class TkwNotZero

function TkwNotZero.NotZero(const aCtx: TtfwContext;
  aA: Integer): Boolean;
//#UC START# *4C0DDFEB9207_904983DADEB2_var*
//#UC END# *4C0DDFEB9207_904983DADEB2_var*
begin
//#UC START# *4C0DDFEB9207_904983DADEB2_impl*
 Result := (aA <> 0);
//#UC END# *4C0DDFEB9207_904983DADEB2_impl*
end;//TkwNotZero.NotZero

procedure TkwNotZero.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aA : Integer;
begin
 try
  l_aA := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aA: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((NotZero(aCtx, l_aA)));
end;//TkwNotZero.DoDoIt

class function TkwNotZero.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '!=0';
end;//TkwNotZero.GetWordNameForRegister

function TkwNotZero.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwNotZero.GetResultTypeInfo

function TkwNotZero.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwNotZero.GetAllParamsCount

function TkwNotZero.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwNotZero.ParamsTypes

type
 TkwEqualZero = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� =0
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aA =0 >>> l_Boolean
[code]  }
 private
 // private methods
   function EqualZero(const aCtx: TtfwContext;
    aA: Integer): Boolean;
     {* ���������� ����� ������� =0 }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEqualZero

// start class TkwEqualZero

function TkwEqualZero.EqualZero(const aCtx: TtfwContext;
  aA: Integer): Boolean;
//#UC START# *7F71955C78B0_41CE11D9C1A2_var*
//#UC END# *7F71955C78B0_41CE11D9C1A2_var*
begin
//#UC START# *7F71955C78B0_41CE11D9C1A2_impl*
 Result := (aA = 0);
//#UC END# *7F71955C78B0_41CE11D9C1A2_impl*
end;//TkwEqualZero.EqualZero

procedure TkwEqualZero.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aA : Integer;
begin
 try
  l_aA := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aA: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((EqualZero(aCtx, l_aA)));
end;//TkwEqualZero.DoDoIt

class function TkwEqualZero.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '=0';
end;//TkwEqualZero.GetWordNameForRegister

function TkwEqualZero.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwEqualZero.GetResultTypeInfo

function TkwEqualZero.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwEqualZero.GetAllParamsCount

function TkwEqualZero.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwEqualZero.ParamsTypes

type
 TkwSWAP = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� SWAP
*������:*
[code]
 SWAP
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwSWAP

// start class TkwSWAP

procedure TkwSWAP.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FABB1CF992DE_var*
//#UC END# *4DAEEDE10285_FABB1CF992DE_var*
begin
//#UC START# *4DAEEDE10285_FABB1CF992DE_impl*
 aCtx.rEngine.SWAP;
//#UC END# *4DAEEDE10285_FABB1CF992DE_impl*
end;//TkwSWAP.DoDoIt

class function TkwSWAP.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'SWAP';
end;//TkwSWAP.GetWordNameForRegister

function TkwSWAP.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwSWAP.GetResultTypeInfo

function TkwSWAP.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwSWAP.GetAllParamsCount

type
 TkwDROP = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� DROP
*������:*
[code]
 DROP
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwDROP

// start class TkwDROP

procedure TkwDROP.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_58414ABA5048_var*
//#UC END# *4DAEEDE10285_58414ABA5048_var*
begin
//#UC START# *4DAEEDE10285_58414ABA5048_impl*
 aCtx.rEngine.DROP;
//#UC END# *4DAEEDE10285_58414ABA5048_impl*
end;//TkwDROP.DoDoIt

class function TkwDROP.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'DROP';
end;//TkwDROP.GetWordNameForRegister

function TkwDROP.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwDROP.GetResultTypeInfo

function TkwDROP.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwDROP.GetAllParamsCount

type
 TkwDUP = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� DUP
*������:*
[code]
 DUP
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwDUP

// start class TkwDUP

procedure TkwDUP.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1B275E59B185_var*
//#UC END# *4DAEEDE10285_1B275E59B185_var*
begin
//#UC START# *4DAEEDE10285_1B275E59B185_impl*
 aCtx.rEngine.Dup;
//#UC END# *4DAEEDE10285_1B275E59B185_impl*
end;//TkwDUP.DoDoIt

class function TkwDUP.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'DUP';
end;//TkwDUP.GetWordNameForRegister

function TkwDUP.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwDUP.GetResultTypeInfo

function TkwDUP.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwDUP.GetAllParamsCount

type
 TkwDUPIfNotZero = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� ?DUP
*������:*
[code]
 ?DUP
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwDUPIfNotZero

// start class TkwDUPIfNotZero

procedure TkwDUPIfNotZero.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7E5F590E5C48_var*
//#UC END# *4DAEEDE10285_7E5F590E5C48_var*
begin
//#UC START# *4DAEEDE10285_7E5F590E5C48_impl*
 aCtx.rEngine.DupIfNotZero;
//#UC END# *4DAEEDE10285_7E5F590E5C48_impl*
end;//TkwDUPIfNotZero.DoDoIt

class function TkwDUPIfNotZero.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '?DUP';
end;//TkwDUPIfNotZero.GetWordNameForRegister

function TkwDUPIfNotZero.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwDUPIfNotZero.GetResultTypeInfo

function TkwDUPIfNotZero.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwDUPIfNotZero.GetAllParamsCount

type
 TkwROT = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� ROT
[panel]���������� ��� ������� �������� �����: ( x1 x2 x3 -- x2 x3 x1 )[panel]
*������:*
[code]
 ROT
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwROT

// start class TkwROT

procedure TkwROT.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E1E6ADB3161D_var*
//#UC END# *4DAEEDE10285_E1E6ADB3161D_var*
begin
//#UC START# *4DAEEDE10285_E1E6ADB3161D_impl*
 aCtx.rEngine.ROT;
//#UC END# *4DAEEDE10285_E1E6ADB3161D_impl*
end;//TkwROT.DoDoIt

class function TkwROT.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'ROT';
end;//TkwROT.GetWordNameForRegister

function TkwROT.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwROT.GetResultTypeInfo

function TkwROT.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwROT.GetAllParamsCount

type
 TkwPICK = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� PICK
[panel]������: u PICK. 
������� u. �������� xu �� ������� �����. ( xu ... x1 x0 u -- xu ... x1 x0 xu )[panel]
*������:*
[code]
 PICK
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwPICK

// start class TkwPICK

procedure TkwPICK.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_75F53535698F_var*
//#UC END# *4DAEEDE10285_75F53535698F_var*
begin
//#UC START# *4DAEEDE10285_75F53535698F_impl*
 aCtx.rEngine.PICK;
//#UC END# *4DAEEDE10285_75F53535698F_impl*
end;//TkwPICK.DoDoIt

class function TkwPICK.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'PICK';
end;//TkwPICK.GetWordNameForRegister

function TkwPICK.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPICK.GetResultTypeInfo

function TkwPICK.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwPICK.GetAllParamsCount

type
 TkwInvertROT = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� -ROT
[panel]���������� ��� ������� �������� �����: ( x1 x2 x3 -- x3 x1 x2 )[panel]
*������:*
[code]
 -ROT
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwInvertROT

// start class TkwInvertROT

procedure TkwInvertROT.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F07D92F8E519_var*
//#UC END# *4DAEEDE10285_F07D92F8E519_var*
begin
//#UC START# *4DAEEDE10285_F07D92F8E519_impl*
 aCtx.rEngine.InvertROT;
//#UC END# *4DAEEDE10285_F07D92F8E519_impl*
end;//TkwInvertROT.DoDoIt

class function TkwInvertROT.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '-ROT';
end;//TkwInvertROT.GetWordNameForRegister

function TkwInvertROT.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwInvertROT.GetResultTypeInfo

function TkwInvertROT.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwInvertROT.GetAllParamsCount

type
 TkwSWAP2 = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� 2SWAP
[panel]������ ������� ��� ������� ����-�����. ( x1 x2 x3 x4 -- x3 x4 x1 x2 )[panel]
*������:*
[code]
 2SWAP
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwSWAP2

// start class TkwSWAP2

procedure TkwSWAP2.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F7F6BAC82E0F_var*
//#UC END# *4DAEEDE10285_F7F6BAC82E0F_var*
begin
//#UC START# *4DAEEDE10285_F7F6BAC82E0F_impl*
 aCtx.rEngine.Swap2;
//#UC END# *4DAEEDE10285_F7F6BAC82E0F_impl*
end;//TkwSWAP2.DoDoIt

class function TkwSWAP2.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '2SWAP';
end;//TkwSWAP2.GetWordNameForRegister

function TkwSWAP2.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwSWAP2.GetResultTypeInfo

function TkwSWAP2.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwSWAP2.GetAllParamsCount

type
 TkwOVER2 = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� 2OVER
[panel]�������� ����-����� x1 x2 �� ������� �����. ( x1 x2 x3 x4 -- x1 x2 x3 x4 x1 x2 )[panel]
*������:*
[code]
 2OVER
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwOVER2

// start class TkwOVER2

procedure TkwOVER2.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9918552ECDEB_var*
//#UC END# *4DAEEDE10285_9918552ECDEB_var*
begin
//#UC START# *4DAEEDE10285_9918552ECDEB_impl*
 aCtx.rEngine.Over2;
//#UC END# *4DAEEDE10285_9918552ECDEB_impl*
end;//TkwOVER2.DoDoIt

class function TkwOVER2.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '2OVER';
end;//TkwOVER2.GetWordNameForRegister

function TkwOVER2.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwOVER2.GetResultTypeInfo

function TkwOVER2.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwOVER2.GetAllParamsCount

type
 TkwDUP2 = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� 2DUP
[panel]��������� ����-����� x1 x2. ( x1 x2 -- x1 x2 x1 x2 )[panel]
*������:*
[code]
 2DUP
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwDUP2

// start class TkwDUP2

procedure TkwDUP2.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B22DDB43B438_var*
//#UC END# *4DAEEDE10285_B22DDB43B438_var*
begin
//#UC START# *4DAEEDE10285_B22DDB43B438_impl*
 aCtx.rEngine.Dup2;
//#UC END# *4DAEEDE10285_B22DDB43B438_impl*
end;//TkwDUP2.DoDoIt

class function TkwDUP2.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '2DUP';
end;//TkwDUP2.GetWordNameForRegister

function TkwDUP2.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwDUP2.GetResultTypeInfo

function TkwDUP2.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwDUP2.GetAllParamsCount

type
 TkwDROP2 = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� 2DROP
[panel]������� ����-����� x1 x2 �� �����. ( x1 x2 -- )[panel]
*������:*
[code]
 2DROP
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwDROP2

// start class TkwDROP2

procedure TkwDROP2.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_79D7140F1BCC_var*
//#UC END# *4DAEEDE10285_79D7140F1BCC_var*
begin
//#UC START# *4DAEEDE10285_79D7140F1BCC_impl*
 aCtx.rEngine.Drop2;
//#UC END# *4DAEEDE10285_79D7140F1BCC_impl*
end;//TkwDROP2.DoDoIt

class function TkwDROP2.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '2DROP';
end;//TkwDROP2.GetWordNameForRegister

function TkwDROP2.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwDROP2.GetResultTypeInfo

function TkwDROP2.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwDROP2.GetAllParamsCount

type
 TkwNIP = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� NIP
[panel]������� ������ ������� ���� ������� �����. ( x1 x2 -- x2 )[panel]
*������:*
[code]
 NIP
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwNIP

// start class TkwNIP

procedure TkwNIP.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_58C1120D11ED_var*
//#UC END# *4DAEEDE10285_58C1120D11ED_var*
begin
//#UC START# *4DAEEDE10285_58C1120D11ED_impl*
 aCtx.rEngine.NIP;
//#UC END# *4DAEEDE10285_58C1120D11ED_impl*
end;//TkwNIP.DoDoIt

class function TkwNIP.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'NIP';
end;//TkwNIP.GetWordNameForRegister

function TkwNIP.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwNIP.GetResultTypeInfo

function TkwNIP.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwNIP.GetAllParamsCount

type
 TkwTUCK = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� TUCK
[panel]�������� ������� ������� ����� ���� ������� �������� �����. ( x1 x2 -- x2 x1 x2 )[panel]
*������:*
[code]
 TUCK
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwTUCK

// start class TkwTUCK

procedure TkwTUCK.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_17D731E639BC_var*
//#UC END# *4DAEEDE10285_17D731E639BC_var*
begin
//#UC START# *4DAEEDE10285_17D731E639BC_impl*
 aCtx.rEngine.TUCK;
//#UC END# *4DAEEDE10285_17D731E639BC_impl*
end;//TkwTUCK.DoDoIt

class function TkwTUCK.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'TUCK';
end;//TkwTUCK.GetWordNameForRegister

function TkwTUCK.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwTUCK.GetResultTypeInfo

function TkwTUCK.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwTUCK.GetAllParamsCount

type
 TkwOVER = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� OVER
[panel]�������� ����� x1 �� ������� �����. ( x1 x2 -- x1 x2 x1 )[panel]
*������:*
[code]
 OVER
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwOVER

// start class TkwOVER

procedure TkwOVER.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3113FD88EFFC_var*
//#UC END# *4DAEEDE10285_3113FD88EFFC_var*
begin
//#UC START# *4DAEEDE10285_3113FD88EFFC_impl*
 aCtx.rEngine.OVER;
//#UC END# *4DAEEDE10285_3113FD88EFFC_impl*
end;//TkwOVER.DoDoIt

class function TkwOVER.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'OVER';
end;//TkwOVER.GetWordNameForRegister

function TkwOVER.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwOVER.GetResultTypeInfo

function TkwOVER.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwOVER.GetAllParamsCount

type
 TkwROLL = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� ROLL
[panel]������: u ROLL. 
������ u. ��������� u+1 ������� �� ������� �����. ( xu xu-1 ... x0 u -- xu-1 ... x0 xu )[panel]
*������:*
[code]
 ROLL
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwROLL

// start class TkwROLL

procedure TkwROLL.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7A5418ADBC12_var*
//#UC END# *4DAEEDE10285_7A5418ADBC12_var*
begin
//#UC START# *4DAEEDE10285_7A5418ADBC12_impl*
 aCtx.rEngine.ROLL;
//#UC END# *4DAEEDE10285_7A5418ADBC12_impl*
end;//TkwROLL.DoDoIt

class function TkwROLL.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'ROLL';
end;//TkwROLL.GetWordNameForRegister

function TkwROLL.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwROLL.GetResultTypeInfo

function TkwROLL.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwROLL.GetAllParamsCount

type
 TkwNotEquals = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� !=
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aA aB != >>> l_Boolean
[code]  }
 private
 // private methods
   function NotEquals(const aCtx: TtfwContext;
    const aB: TtfwStackValue;
    const aA: TtfwStackValue): Boolean;
     {* ���������� ����� ������� != }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNotEquals

// start class TkwNotEquals

function TkwNotEquals.NotEquals(const aCtx: TtfwContext;
  const aB: TtfwStackValue;
  const aA: TtfwStackValue): Boolean;
//#UC START# *DAC93FA73644_121F11B3416F_var*
//#UC END# *DAC93FA73644_121F11B3416F_var*
begin
//#UC START# *DAC93FA73644_121F11B3416F_impl*
 Case aA.rType of
  tfw_vtInt:
   Result := aA.AsInt <> aB.AsInt;
  tfw_vtBool:
   Result := aA.AsBoolean <> aB.AsBoolean;
  tfw_vtStr:
   Result := not l3Same(aA.AsString, aB.AsString);
  tfw_vtObj:
   Result := aA.AsObject <> aB.AsObject;
  else
  begin
   Result := false;
   BadValueType(aA.rType, aCtx);
  end;//else
 end;//Case aA.rType
//#UC END# *DAC93FA73644_121F11B3416F_impl*
end;//TkwNotEquals.NotEquals

procedure TkwNotEquals.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aB : TtfwStackValue;
 l_aA : TtfwStackValue;
begin
 try
  l_aB := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aB: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aA: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((NotEquals(aCtx, l_aB, l_aA)));
end;//TkwNotEquals.DoDoIt

class function TkwNotEquals.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '!=';
end;//TkwNotEquals.GetWordNameForRegister

function TkwNotEquals.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwNotEquals.GetResultTypeInfo

function TkwNotEquals.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2;
end;//TkwNotEquals.GetAllParamsCount

function TkwNotEquals.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiStruct, @tfw_tiStruct]);
end;//TkwNotEquals.ParamsTypes

type
 TkwGREATER = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� GREATER
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aA aB GREATER >>> l_Boolean
[code]  }
 private
 // private methods
   function GREATER(const aCtx: TtfwContext;
    const aB: TtfwStackValue;
    const aA: TtfwStackValue): Boolean;
     {* ���������� ����� ������� GREATER }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGREATER

// start class TkwGREATER

function TkwGREATER.GREATER(const aCtx: TtfwContext;
  const aB: TtfwStackValue;
  const aA: TtfwStackValue): Boolean;
//#UC START# *907965538A11_0863B7ED4B56_var*
//#UC END# *907965538A11_0863B7ED4B56_var*
begin
//#UC START# *907965538A11_0863B7ED4B56_impl*
 Case aA.rType of
  tfw_vtInt:
   Result := aA.AsInt > aB.AsInt;
  tfw_vtBool:
   Result := aA.AsBoolean > aB.AsBoolean;
  tfw_vtStr:
   Result := l3Compare(l3PCharLen(aA.AsString), l3PCharLen(aB.AsString)) > 0;
  else
  begin
   Result := false;
   BadValueType(aA.rType, aCtx);
  end;//else
 end;//Case aA.rType
//#UC END# *907965538A11_0863B7ED4B56_impl*
end;//TkwGREATER.GREATER

procedure TkwGREATER.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aB : TtfwStackValue;
 l_aA : TtfwStackValue;
begin
 try
  l_aB := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aB: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aA: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((GREATER(aCtx, l_aB, l_aA)));
end;//TkwGREATER.DoDoIt

class function TkwGREATER.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'GREATER';
end;//TkwGREATER.GetWordNameForRegister

function TkwGREATER.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwGREATER.GetResultTypeInfo

function TkwGREATER.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2;
end;//TkwGREATER.GetAllParamsCount

function TkwGREATER.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiStruct, @tfw_tiStruct]);
end;//TkwGREATER.ParamsTypes

type
 TkwLESS = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� LESS
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aA aB LESS >>> l_Boolean
[code]  }
 private
 // private methods
   function LESS(const aCtx: TtfwContext;
    const aB: TtfwStackValue;
    const aA: TtfwStackValue): Boolean;
     {* ���������� ����� ������� LESS }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLESS

// start class TkwLESS

function TkwLESS.LESS(const aCtx: TtfwContext;
  const aB: TtfwStackValue;
  const aA: TtfwStackValue): Boolean;
//#UC START# *EAAF403E752C_2AFA590B937B_var*
//#UC END# *EAAF403E752C_2AFA590B937B_var*
begin
//#UC START# *EAAF403E752C_2AFA590B937B_impl*
 Case aA.rType of
  tfw_vtInt:
   Result := aA.AsInt < aB.AsInt;
  tfw_vtBool:
   Result := aA.AsBoolean < aB.AsBoolean;
  tfw_vtStr:
   Result := l3Compare(l3PCharLen(aA.AsString), l3PCharLen(aB.AsString)) < 0;
  else
  begin
   Result := false;
   BadValueType(aA.rType, aCtx);
  end;//else
 end;//Case aA.rType
//#UC END# *EAAF403E752C_2AFA590B937B_impl*
end;//TkwLESS.LESS

procedure TkwLESS.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aB : TtfwStackValue;
 l_aA : TtfwStackValue;
begin
 try
  l_aB := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aB: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aA: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((LESS(aCtx, l_aB, l_aA)));
end;//TkwLESS.DoDoIt

class function TkwLESS.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'LESS';
end;//TkwLESS.GetWordNameForRegister

function TkwLESS.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwLESS.GetResultTypeInfo

function TkwLESS.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2;
end;//TkwLESS.GetAllParamsCount

function TkwLESS.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiStruct, @tfw_tiStruct]);
end;//TkwLESS.ParamsTypes

type
 TkwEquals = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� ==
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aA aB == >>> l_Boolean
[code]  }
 private
 // private methods
   function Equals(const aCtx: TtfwContext;
    const aB: TtfwStackValue;
    const aA: TtfwStackValue): Boolean;
     {* ���������� ����� ������� == }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEquals

// start class TkwEquals

function TkwEquals.Equals(const aCtx: TtfwContext;
  const aB: TtfwStackValue;
  const aA: TtfwStackValue): Boolean;
//#UC START# *7E71F9CCB18C_1A66A4BEC1B0_var*
//#UC END# *7E71F9CCB18C_1A66A4BEC1B0_var*
begin
//#UC START# *7E71F9CCB18C_1A66A4BEC1B0_impl*
 Case aA.rType of
  tfw_vtInt:
   Result := aA.AsInt = aB.AsInt;
  tfw_vtBool:
   Result := aA.AsBoolean = aB.AsBoolean;
  tfw_vtStr:
   Result := l3Same(aA.AsString, aB.AsString);
  tfw_vtObj:
   Result := aA.AsObject = aB.AsObject;
  else
  begin
   Result := false;
   BadValueType(aA.rType, aCtx);
  end;//else
 end;//Case aA.rType
//#UC END# *7E71F9CCB18C_1A66A4BEC1B0_impl*
end;//TkwEquals.Equals

procedure TkwEquals.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aB : TtfwStackValue;
 l_aA : TtfwStackValue;
begin
 try
  l_aB := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aB: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aA: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((Equals(aCtx, l_aB, l_aA)));
end;//TkwEquals.DoDoIt

class function TkwEquals.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '==';
end;//TkwEquals.GetWordNameForRegister

function TkwEquals.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwEquals.GetResultTypeInfo

function TkwEquals.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2;
end;//TkwEquals.GetAllParamsCount

function TkwEquals.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiStruct, @tfw_tiStruct]);
end;//TkwEquals.ParamsTypes

type
 TkwLessThanZero = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� <0
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aB <0 >>> l_Boolean
[code]  }
 private
 // private methods
   function LessThanZero(const aCtx: TtfwContext;
    aB: Integer): Boolean;
     {* ���������� ����� ������� <0 }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLessThanZero

// start class TkwLessThanZero

function TkwLessThanZero.LessThanZero(const aCtx: TtfwContext;
  aB: Integer): Boolean;
//#UC START# *76343505B981_AD14C7183370_var*
//#UC END# *76343505B981_AD14C7183370_var*
begin
//#UC START# *76343505B981_AD14C7183370_impl*
 Result := (aB < 0);
//#UC END# *76343505B981_AD14C7183370_impl*
end;//TkwLessThanZero.LessThanZero

procedure TkwLessThanZero.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aB : Integer;
begin
 try
  l_aB := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aB: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((LessThanZero(aCtx, l_aB)));
end;//TkwLessThanZero.DoDoIt

class function TkwLessThanZero.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '<0';
end;//TkwLessThanZero.GetWordNameForRegister

function TkwLessThanZero.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwLessThanZero.GetResultTypeInfo

function TkwLessThanZero.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwLessThanZero.GetAllParamsCount

function TkwLessThanZero.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwLessThanZero.ParamsTypes

type
 TkwGreaterThanZero = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� >0
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aB >0 >>> l_Boolean
[code]  }
 private
 // private methods
   function GreaterThanZero(const aCtx: TtfwContext;
    aB: Integer): Boolean;
     {* ���������� ����� ������� >0 }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGreaterThanZero

// start class TkwGreaterThanZero

function TkwGreaterThanZero.GreaterThanZero(const aCtx: TtfwContext;
  aB: Integer): Boolean;
//#UC START# *1832AF7A2450_CC7B740D2755_var*
//#UC END# *1832AF7A2450_CC7B740D2755_var*
begin
//#UC START# *1832AF7A2450_CC7B740D2755_impl*
 Result := (aB > 0);
//#UC END# *1832AF7A2450_CC7B740D2755_impl*
end;//TkwGreaterThanZero.GreaterThanZero

procedure TkwGreaterThanZero.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aB : Integer;
begin
 try
  l_aB := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aB: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((GreaterThanZero(aCtx, l_aB)));
end;//TkwGreaterThanZero.DoDoIt

class function TkwGreaterThanZero.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '>0';
end;//TkwGreaterThanZero.GetWordNameForRegister

function TkwGreaterThanZero.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwGreaterThanZero.GetResultTypeInfo

function TkwGreaterThanZero.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwGreaterThanZero.GetAllParamsCount

function TkwGreaterThanZero.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwGreaterThanZero.ParamsTypes

type
 TkwBitAnd = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� &
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aA aB & >>> l_Integer
[code]  }
 private
 // private methods
   function BitAnd(const aCtx: TtfwContext;
    aB: Integer;
    aA: Integer): Integer;
     {* ���������� ����� ������� & }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBitAnd

// start class TkwBitAnd

function TkwBitAnd.BitAnd(const aCtx: TtfwContext;
  aB: Integer;
  aA: Integer): Integer;
//#UC START# *B61F439AC566_0E401EC02EF4_var*
//#UC END# *B61F439AC566_0E401EC02EF4_var*
begin
//#UC START# *B61F439AC566_0E401EC02EF4_impl*
 Result := aA AND aB;
//#UC END# *B61F439AC566_0E401EC02EF4_impl*
end;//TkwBitAnd.BitAnd

procedure TkwBitAnd.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aB : Integer;
 l_aA : Integer;
begin
 try
  l_aB := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aB: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aA: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((BitAnd(aCtx, l_aB, l_aA)));
end;//TkwBitAnd.DoDoIt

class function TkwBitAnd.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '&';
end;//TkwBitAnd.GetWordNameForRegister

function TkwBitAnd.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwBitAnd.GetResultTypeInfo

function TkwBitAnd.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2;
end;//TkwBitAnd.GetAllParamsCount

function TkwBitAnd.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwBitAnd.ParamsTypes

type
 TkwBitOR = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� |
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aA aB | >>> l_Integer
[code]  }
 private
 // private methods
   function BitOR(const aCtx: TtfwContext;
    aB: Integer;
    aA: Integer): Integer;
     {* ���������� ����� ������� | }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBitOR

// start class TkwBitOR

function TkwBitOR.BitOR(const aCtx: TtfwContext;
  aB: Integer;
  aA: Integer): Integer;
//#UC START# *13EB96AAB427_69326D5123FC_var*
//#UC END# *13EB96AAB427_69326D5123FC_var*
begin
//#UC START# *13EB96AAB427_69326D5123FC_impl*
 Result := aA OR aB;
//#UC END# *13EB96AAB427_69326D5123FC_impl*
end;//TkwBitOR.BitOR

procedure TkwBitOR.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aB : Integer;
 l_aA : Integer;
begin
 try
  l_aB := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aB: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aA: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((BitOR(aCtx, l_aB, l_aA)));
end;//TkwBitOR.DoDoIt

class function TkwBitOR.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '|';
end;//TkwBitOR.GetWordNameForRegister

function TkwBitOR.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwBitOR.GetResultTypeInfo

function TkwBitOR.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2;
end;//TkwBitOR.GetAllParamsCount

function TkwBitOR.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwBitOR.ParamsTypes

type
 TkwBitNot = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� ~
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aB ~ >>> l_Integer
[code]  }
 private
 // private methods
   function BitNot(const aCtx: TtfwContext;
    aB: Integer): Integer;
     {* ���������� ����� ������� ~ }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBitNot

// start class TkwBitNot

function TkwBitNot.BitNot(const aCtx: TtfwContext;
  aB: Integer): Integer;
//#UC START# *B69DB28A46FE_7DACF7561AEE_var*
//#UC END# *B69DB28A46FE_7DACF7561AEE_var*
begin
//#UC START# *B69DB28A46FE_7DACF7561AEE_impl*
 Result := not aB;
//#UC END# *B69DB28A46FE_7DACF7561AEE_impl*
end;//TkwBitNot.BitNot

procedure TkwBitNot.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aB : Integer;
begin
 try
  l_aB := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aB: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((BitNot(aCtx, l_aB)));
end;//TkwBitNot.DoDoIt

class function TkwBitNot.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '~';
end;//TkwBitNot.GetWordNameForRegister

function TkwBitNot.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwBitNot.GetResultTypeInfo

function TkwBitNot.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwBitNot.GetAllParamsCount

function TkwBitNot.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwBitNot.ParamsTypes

type
 TkwStackLevel = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� StackLevel
[panel]������� ������� �����[panel]
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 StackLevel >>> l_Integer
[code]  }
 private
 // private methods
   function StackLevel(const aCtx: TtfwContext): Integer;
     {* ���������� ����� ������� StackLevel }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStackLevel

// start class TkwStackLevel

function TkwStackLevel.StackLevel(const aCtx: TtfwContext): Integer;
//#UC START# *42FCDB4340A7_3C430AEBDFB3_var*
//#UC END# *42FCDB4340A7_3C430AEBDFB3_var*
begin
//#UC START# *42FCDB4340A7_3C430AEBDFB3_impl*
 Result := aCtx.rEngine.ValuesCount;
//#UC END# *42FCDB4340A7_3C430AEBDFB3_impl*
end;//TkwStackLevel.StackLevel

procedure TkwStackLevel.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushInt((StackLevel(aCtx)));
end;//TkwStackLevel.DoDoIt

class function TkwStackLevel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'StackLevel';
end;//TkwStackLevel.GetWordNameForRegister

function TkwStackLevel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwStackLevel.GetResultTypeInfo

function TkwStackLevel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwStackLevel.GetAllParamsCount

function TkwStackLevel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwStackLevel.ParamsTypes

type
 TkwReduceStackLevel = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� ReduceStackLevel
*������:*
[code]
 aValue ReduceStackLevel
[code]  }
 private
 // private methods
   procedure ReduceStackLevel(const aCtx: TtfwContext;
    aValue: Integer);
     {* ���������� ����� ������� ReduceStackLevel }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwReduceStackLevel

// start class TkwReduceStackLevel

procedure TkwReduceStackLevel.ReduceStackLevel(const aCtx: TtfwContext;
  aValue: Integer);
//#UC START# *8AD57442466F_50820082E666_var*
//#UC END# *8AD57442466F_50820082E666_var*
begin
//#UC START# *8AD57442466F_50820082E666_impl*
 while (aCtx.rEngine.ValuesCount > aValue) do
  aCtx.rEngine.Drop;
//#UC END# *8AD57442466F_50820082E666_impl*
end;//TkwReduceStackLevel.ReduceStackLevel

procedure TkwReduceStackLevel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aValue : Integer;
begin
 try
  l_aValue := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 ReduceStackLevel(aCtx, l_aValue);
end;//TkwReduceStackLevel.DoDoIt

class function TkwReduceStackLevel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'ReduceStackLevel';
end;//TkwReduceStackLevel.GetWordNameForRegister

function TkwReduceStackLevel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwReduceStackLevel.GetResultTypeInfo

function TkwReduceStackLevel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwReduceStackLevel.GetAllParamsCount

function TkwReduceStackLevel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwReduceStackLevel.ParamsTypes

type
 TkwCtxParserPushString = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:Parser:PushString
*������:*
[code]
 aValue Ctx:Parser:PushString
[code]  }
 private
 // private methods
   procedure CtxParserPushString(const aCtx: TtfwContext;
    const aValue: Il3CString);
     {* ���������� ����� ������� Ctx:Parser:PushString }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxParserPushString

// start class TkwCtxParserPushString

procedure TkwCtxParserPushString.CtxParserPushString(const aCtx: TtfwContext;
  const aValue: Il3CString);
//#UC START# *8E726023F8EB_D8442EFB554F_var*
//#UC END# *8E726023F8EB_D8442EFB554F_var*
begin
//#UC START# *8E726023F8EB_D8442EFB554F_impl*
 aCtx.rParser.PushString(aValue);
//#UC END# *8E726023F8EB_D8442EFB554F_impl*
end;//TkwCtxParserPushString.CtxParserPushString

procedure TkwCtxParserPushString.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aValue : Il3CString;
begin
 try
  l_aValue := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CtxParserPushString(aCtx, l_aValue);
end;//TkwCtxParserPushString.DoDoIt

class function TkwCtxParserPushString.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:Parser:PushString';
end;//TkwCtxParserPushString.GetWordNameForRegister

function TkwCtxParserPushString.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwCtxParserPushString.GetResultTypeInfo

function TkwCtxParserPushString.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwCtxParserPushString.GetAllParamsCount

function TkwCtxParserPushString.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwCtxParserPushString.ParamsTypes

type
 TkwCtxParserPushSymbol = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:Parser:PushSymbol
*������:*
[code]
 aValue Ctx:Parser:PushSymbol
[code]  }
 private
 // private methods
   procedure CtxParserPushSymbol(const aCtx: TtfwContext;
    const aValue: Il3CString);
     {* ���������� ����� ������� Ctx:Parser:PushSymbol }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxParserPushSymbol

// start class TkwCtxParserPushSymbol

procedure TkwCtxParserPushSymbol.CtxParserPushSymbol(const aCtx: TtfwContext;
  const aValue: Il3CString);
//#UC START# *4FE75C990836_7CF3976BA94E_var*
//#UC END# *4FE75C990836_7CF3976BA94E_var*
begin
//#UC START# *4FE75C990836_7CF3976BA94E_impl*
 aCtx.rParser.PushSymbol(aValue);
//#UC END# *4FE75C990836_7CF3976BA94E_impl*
end;//TkwCtxParserPushSymbol.CtxParserPushSymbol

procedure TkwCtxParserPushSymbol.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aValue : Il3CString;
begin
 try
  l_aValue := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CtxParserPushSymbol(aCtx, l_aValue);
end;//TkwCtxParserPushSymbol.DoDoIt

class function TkwCtxParserPushSymbol.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:Parser:PushSymbol';
end;//TkwCtxParserPushSymbol.GetWordNameForRegister

function TkwCtxParserPushSymbol.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwCtxParserPushSymbol.GetResultTypeInfo

function TkwCtxParserPushSymbol.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwCtxParserPushSymbol.GetAllParamsCount

function TkwCtxParserPushSymbol.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwCtxParserPushSymbol.ParamsTypes

type
 TkwCtxParserPushInt = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:Parser:PushInt
*������:*
[code]
 aValue Ctx:Parser:PushInt
[code]  }
 private
 // private methods
   procedure CtxParserPushInt(const aCtx: TtfwContext;
    aValue: Integer);
     {* ���������� ����� ������� Ctx:Parser:PushInt }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxParserPushInt

// start class TkwCtxParserPushInt

procedure TkwCtxParserPushInt.CtxParserPushInt(const aCtx: TtfwContext;
  aValue: Integer);
//#UC START# *281A6BDFE308_6506A524A1D6_var*
//#UC END# *281A6BDFE308_6506A524A1D6_var*
begin
//#UC START# *281A6BDFE308_6506A524A1D6_impl*
 aCtx.rParser.PushInt(aValue);
//#UC END# *281A6BDFE308_6506A524A1D6_impl*
end;//TkwCtxParserPushInt.CtxParserPushInt

procedure TkwCtxParserPushInt.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aValue : Integer;
begin
 try
  l_aValue := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CtxParserPushInt(aCtx, l_aValue);
end;//TkwCtxParserPushInt.DoDoIt

class function TkwCtxParserPushInt.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:Parser:PushInt';
end;//TkwCtxParserPushInt.GetWordNameForRegister

function TkwCtxParserPushInt.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwCtxParserPushInt.GetResultTypeInfo

function TkwCtxParserPushInt.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwCtxParserPushInt.GetAllParamsCount

function TkwCtxParserPushInt.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwCtxParserPushInt.ParamsTypes

type
 TkwCtxParser = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:Parser
*��� ����������:* ItfwParserEx
*������:*
[code]
INTERFACE VAR l_ItfwParserEx
 Ctx:Parser >>> l_ItfwParserEx
[code]  }
 private
 // private methods
   function CtxParser(const aCtx: TtfwContext): ItfwParserEx;
     {* ���������� ����� ������� Ctx:Parser }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxParser

// start class TkwCtxParser

function TkwCtxParser.CtxParser(const aCtx: TtfwContext): ItfwParserEx;
//#UC START# *E7656563CEDD_31E4D21646AB_var*
//#UC END# *E7656563CEDD_31E4D21646AB_var*
begin
//#UC START# *E7656563CEDD_31E4D21646AB_impl*
 Result := aCtx.rParser;
//#UC END# *E7656563CEDD_31E4D21646AB_impl*
end;//TkwCtxParser.CtxParser

procedure TkwCtxParser.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushIntf((CtxParser(aCtx)), TypeInfo(ItfwParserEx));
end;//TkwCtxParser.DoDoIt

class function TkwCtxParser.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:Parser';
end;//TkwCtxParser.GetWordNameForRegister

function TkwCtxParser.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(ItfwParserEx);
end;//TkwCtxParser.GetResultTypeInfo

function TkwCtxParser.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwCtxParser.GetAllParamsCount

function TkwCtxParser.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxParser.ParamsTypes

type
 TkwAtomicIf = {final scriptword} class(TtfwWordWorkerEx)
  {* ����� ������� ?
*������:*
[code]
 aCondition ? aWord
[code]  }
 private
 // private methods
   procedure AtomicIf(const aCtx: TtfwContext;
    aWord: TtfwWord;
    aCondition: Boolean);
     {* ���������� ����� ������� ? }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   procedure DoRun(const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAtomicIf

// start class TkwAtomicIf

procedure TkwAtomicIf.AtomicIf(const aCtx: TtfwContext;
  aWord: TtfwWord;
  aCondition: Boolean);
//#UC START# *EC03275D308E_0DAE5A00538B_var*
//#UC END# *EC03275D308E_0DAE5A00538B_var*
begin
//#UC START# *EC03275D308E_0DAE5A00538B_impl*
 if aCondition then
  aWord.DoIt(aCtx);
//#UC END# *EC03275D308E_0DAE5A00538B_impl*
end;//TkwAtomicIf.AtomicIf

class function TkwAtomicIf.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '?';
end;//TkwAtomicIf.GetWordNameForRegister

function TkwAtomicIf.RightParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwAtomicIf.RightParamsCount

procedure TkwAtomicIf.DoRun(const aCtx: TtfwContext);
 {-}
var
 l_aWord : TtfwWord;
 l_aCondition : Boolean;
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
 try
  l_aCondition := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCondition: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 AtomicIf(aCtx, l_aWord, l_aCondition);
end;//TkwAtomicIf.DoRun

function TkwAtomicIf.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwAtomicIf.GetResultTypeInfo

function TkwAtomicIf.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwAtomicIf.GetAllParamsCount

function TkwAtomicIf.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), TypeInfo(Boolean)]);
end;//TkwAtomicIf.ParamsTypes

type
 TkwCompileValue = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� CompileValue
*������:*
[code]
 aValue CompileValue
[code]  }
 private
 // private methods
   procedure CompileValue(const aCtx: TtfwContext;
    const aValue: TtfwStackValue);
     {* ���������� ����� ������� CompileValue }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCompileValue

// start class TkwCompileValue

procedure TkwCompileValue.CompileValue(const aCtx: TtfwContext;
  const aValue: TtfwStackValue);
//#UC START# *749E10496472_C02DF9F9363F_var*
var
 l_W : TtfwWord;
//#UC END# *749E10496472_C02DF9F9363F_var*
begin
//#UC START# *749E10496472_C02DF9F9363F_impl*
 if (aValue.rType = tfw_vtObj) AND (aValue.AsObject Is TtfwWord) then
  l_W := TtfwWord(aValue.AsObject).Use
 else
  l_W := TkwValue.Create(aValue);
 try
  RunnerAssert(l_W <> nil, '��� ����� ��� ����������', aCtx);
  aCtx.rCompiler.AddCodePart(l_W, aCtx, tfw_sniNo);
 finally
  FreeAndNil(l_W);
 end;//try..finally
//#UC END# *749E10496472_C02DF9F9363F_impl*
end;//TkwCompileValue.CompileValue

procedure TkwCompileValue.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aValue : TtfwStackValue;
begin
 try
  l_aValue := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CompileValue(aCtx, l_aValue);
end;//TkwCompileValue.DoDoIt

class function TkwCompileValue.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'CompileValue';
end;//TkwCompileValue.GetWordNameForRegister

function TkwCompileValue.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwCompileValue.GetResultTypeInfo

function TkwCompileValue.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwCompileValue.GetAllParamsCount

function TkwCompileValue.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwCompileValue.ParamsTypes

type
 TkwIMMEDIATE = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� IMMEDIATE
*������:*
[code]
 IMMEDIATE
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function IsImmediate(const aCtx: TtfwContext): Boolean; override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwIMMEDIATE

// start class TkwIMMEDIATE

procedure TkwIMMEDIATE.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6EC672F8FA27_var*
//#UC END# *4DAEEDE10285_6EC672F8FA27_var*
begin
//#UC START# *4DAEEDE10285_6EC672F8FA27_impl*
 aCtx.SetWordInfo(aCtx.rTypeInfo.IncludeModifier(tfw_wmImmediate));
//#UC END# *4DAEEDE10285_6EC672F8FA27_impl*
end;//TkwIMMEDIATE.DoDoIt

class function TkwIMMEDIATE.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'IMMEDIATE';
end;//TkwIMMEDIATE.GetWordNameForRegister

function TkwIMMEDIATE.IsImmediate(const aCtx: TtfwContext): Boolean;
 {-}
begin
 Result := true;
end;//TkwIMMEDIATE.IsImmediate

function TkwIMMEDIATE.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwIMMEDIATE.GetResultTypeInfo

function TkwIMMEDIATE.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwIMMEDIATE.GetAllParamsCount

type
 TkwCtxScriptCaller = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:ScriptCaller
*��� ����������:* ItfwScriptCaller
*������:*
[code]
INTERFACE VAR l_ItfwScriptCaller
 Ctx:ScriptCaller >>> l_ItfwScriptCaller
[code]  }
 private
 // private methods
   function CtxScriptCaller(const aCtx: TtfwContext): ItfwScriptCaller;
     {* ���������� ����� ������� Ctx:ScriptCaller }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxScriptCaller

// start class TkwCtxScriptCaller

function TkwCtxScriptCaller.CtxScriptCaller(const aCtx: TtfwContext): ItfwScriptCaller;
//#UC START# *7E032295C1C9_F308C4778C99_var*
//#UC END# *7E032295C1C9_F308C4778C99_var*
begin
//#UC START# *7E032295C1C9_F308C4778C99_impl*
 Result := aCtx.rCaller;
//#UC END# *7E032295C1C9_F308C4778C99_impl*
end;//TkwCtxScriptCaller.CtxScriptCaller

procedure TkwCtxScriptCaller.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushIntf((CtxScriptCaller(aCtx)), TypeInfo(ItfwScriptCaller));
end;//TkwCtxScriptCaller.DoDoIt

class function TkwCtxScriptCaller.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:ScriptCaller';
end;//TkwCtxScriptCaller.GetWordNameForRegister

function TkwCtxScriptCaller.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(ItfwScriptCaller);
end;//TkwCtxScriptCaller.GetResultTypeInfo

function TkwCtxScriptCaller.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwCtxScriptCaller.GetAllParamsCount

function TkwCtxScriptCaller.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxScriptCaller.ParamsTypes

type
 TkwCtxEngine = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:Engine
*��� ����������:* ItfwScriptEngine
*������:*
[code]
INTERFACE VAR l_ItfwScriptEngine
 Ctx:Engine >>> l_ItfwScriptEngine
[code]  }
 private
 // private methods
   function CtxEngine(const aCtx: TtfwContext): ItfwScriptEngine;
     {* ���������� ����� ������� Ctx:Engine }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxEngine

// start class TkwCtxEngine

function TkwCtxEngine.CtxEngine(const aCtx: TtfwContext): ItfwScriptEngine;
//#UC START# *E94F373360E6_42CA0C676D88_var*
//#UC END# *E94F373360E6_42CA0C676D88_var*
begin
//#UC START# *E94F373360E6_42CA0C676D88_impl*
 Result := aCtx.rEngine;
//#UC END# *E94F373360E6_42CA0C676D88_impl*
end;//TkwCtxEngine.CtxEngine

procedure TkwCtxEngine.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushIntf((CtxEngine(aCtx)), TypeInfo(ItfwScriptEngine));
end;//TkwCtxEngine.DoDoIt

class function TkwCtxEngine.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:Engine';
end;//TkwCtxEngine.GetWordNameForRegister

function TkwCtxEngine.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(ItfwScriptEngine);
end;//TkwCtxEngine.GetResultTypeInfo

function TkwCtxEngine.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwCtxEngine.GetAllParamsCount

function TkwCtxEngine.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxEngine.ParamsTypes

type
 TkwCtxStoredValuesStack = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:StoredValuesStack
*��� ����������:* ItfwStoredValuesStack
*������:*
[code]
INTERFACE VAR l_ItfwStoredValuesStack
 Ctx:StoredValuesStack >>> l_ItfwStoredValuesStack
[code]  }
 private
 // private methods
   function CtxStoredValuesStack(const aCtx: TtfwContext): ItfwStoredValuesStack;
     {* ���������� ����� ������� Ctx:StoredValuesStack }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxStoredValuesStack

// start class TkwCtxStoredValuesStack

function TkwCtxStoredValuesStack.CtxStoredValuesStack(const aCtx: TtfwContext): ItfwStoredValuesStack;
//#UC START# *6EA47AE2D452_089904B15389_var*
//#UC END# *6EA47AE2D452_089904B15389_var*
begin
//#UC START# *6EA47AE2D452_089904B15389_impl*
 Result := aCtx.rStoredValuesStack;
//#UC END# *6EA47AE2D452_089904B15389_impl*
end;//TkwCtxStoredValuesStack.CtxStoredValuesStack

procedure TkwCtxStoredValuesStack.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushIntf((CtxStoredValuesStack(aCtx)), TypeInfo(ItfwStoredValuesStack));
end;//TkwCtxStoredValuesStack.DoDoIt

class function TkwCtxStoredValuesStack.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:StoredValuesStack';
end;//TkwCtxStoredValuesStack.GetWordNameForRegister

function TkwCtxStoredValuesStack.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(ItfwStoredValuesStack);
end;//TkwCtxStoredValuesStack.GetResultTypeInfo

function TkwCtxStoredValuesStack.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwCtxStoredValuesStack.GetAllParamsCount

function TkwCtxStoredValuesStack.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxStoredValuesStack.ParamsTypes

type
 TkwCreateAndRaise = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� CreateAndRaise
[panel]���������� ���������� ��������� ������ aClass � ���������� aMessage[panel]
*������:*
[code]
 aMessage aClass CreateAndRaise
[code]  }
 private
 // private methods
   procedure CreateAndRaise(const aCtx: TtfwContext;
    aClass: TClass;
    const aMessage: AnsiString);
     {* ���������� ����� ������� CreateAndRaise }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCreateAndRaise

// start class TkwCreateAndRaise

procedure TkwCreateAndRaise.CreateAndRaise(const aCtx: TtfwContext;
  aClass: TClass;
  const aMessage: AnsiString);
//#UC START# *28A55B6DB9FC_19AF75640AE2_var*
type
 RException = class of Exception;
//#UC END# *28A55B6DB9FC_19AF75640AE2_var*
begin
//#UC START# *28A55B6DB9FC_19AF75640AE2_impl*
 if aClass.InheritsFrom(Exception) then
  raise RException(aClass).Create(aMessage)
 else
  RunnerError('������� �� ����� ����������, � ' + aClass.ClassName, aCtx); 
//#UC END# *28A55B6DB9FC_19AF75640AE2_impl*
end;//TkwCreateAndRaise.CreateAndRaise

procedure TkwCreateAndRaise.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aClass : TClass;
 l_aMessage : AnsiString;
begin
 try
  l_aClass := aCtx.rEngine.PopClass;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aClass: TClass : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aMessage := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMessage: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CreateAndRaise(aCtx, l_aClass, l_aMessage);
end;//TkwCreateAndRaise.DoDoIt

class function TkwCreateAndRaise.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'CreateAndRaise';
end;//TkwCreateAndRaise.GetWordNameForRegister

function TkwCreateAndRaise.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwCreateAndRaise.GetResultTypeInfo

function TkwCreateAndRaise.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2;
end;//TkwCreateAndRaise.GetAllParamsCount

function TkwCreateAndRaise.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiClassRef, TypeInfo(AnsiString)]);
end;//TkwCreateAndRaise.ParamsTypes

type
 TkwCompileRef = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� CompileRef
*������:*
[code]
 aValue CompileRef
[code]  }
 private
 // private methods
   procedure CompileRef(const aCtx: TtfwContext;
    const aValue: TtfwStackValue);
     {* ���������� ����� ������� CompileRef }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCompileRef

// start class TkwCompileRef

procedure TkwCompileRef.CompileRef(const aCtx: TtfwContext;
  const aValue: TtfwStackValue);
//#UC START# *D7798F759F29_C0A961058CA4_var*
var
 l_W : TtfwWord;
 l_PW : TkwCompiledPushWord;
//#UC END# *D7798F759F29_C0A961058CA4_var*
begin
//#UC START# *D7798F759F29_C0A961058CA4_impl*
 if (aValue.rType = tfw_vtObj) AND (aValue.AsObject Is TtfwWord) then
  l_W := TtfwWord(aValue.AsObject).Use
 else
  l_W := TkwValue.Create(aValue);
 try
  RunnerAssert(l_W <> nil, '��� ����� ��� ����������', aCtx);
  l_PW := TkwCompiledPushWord.Create(l_W, nil, aCtx);
  try
   aCtx.rCompiler.AddCodePart(l_PW, aCtx, tfw_sniNo);
  finally
   FreeAndNil(l_PW);
  end;//try..finally
 finally
  FreeAndNil(l_W);
 end;//try..finally
//#UC END# *D7798F759F29_C0A961058CA4_impl*
end;//TkwCompileRef.CompileRef

procedure TkwCompileRef.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aValue : TtfwStackValue;
begin
 try
  l_aValue := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CompileRef(aCtx, l_aValue);
end;//TkwCompileRef.DoDoIt

class function TkwCompileRef.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'CompileRef';
end;//TkwCompileRef.GetWordNameForRegister

function TkwCompileRef.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwCompileRef.GetResultTypeInfo

function TkwCompileRef.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwCompileRef.GetAllParamsCount

function TkwCompileRef.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwCompileRef.ParamsTypes

type
 TkwCompileWeakRef = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� CompileWeakRef
*������:*
[code]
 aValue CompileWeakRef
[code]  }
 private
 // private methods
   procedure CompileWeakRef(const aCtx: TtfwContext;
    const aValue: TtfwStackValue);
     {* ���������� ����� ������� CompileWeakRef }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCompileWeakRef

// start class TkwCompileWeakRef

procedure TkwCompileWeakRef.CompileWeakRef(const aCtx: TtfwContext;
  const aValue: TtfwStackValue);
//#UC START# *854CA0D04456_896B70A80D41_var*
var
 l_W : TtfwWord;
//#UC END# *854CA0D04456_896B70A80D41_var*
begin
//#UC START# *854CA0D04456_896B70A80D41_impl*
 if (aValue.rType = tfw_vtObj) AND (aValue.AsObject Is TtfwWord) then
  l_W := TkwWordPtrPushWord.Create(aValue.AsObject As TtfwWord)
 else
  l_W := nil;
 try
  RunnerAssert(l_W <> nil, '��� ����� ��� ����������', aCtx);
  aCtx.rCompiler.AddCodePart(l_W, aCtx, tfw_sniNo);
 finally
  FreeAndNil(l_W);
 end;//try..finally
//#UC END# *854CA0D04456_896B70A80D41_impl*
end;//TkwCompileWeakRef.CompileWeakRef

procedure TkwCompileWeakRef.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aValue : TtfwStackValue;
begin
 try
  l_aValue := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CompileWeakRef(aCtx, l_aValue);
end;//TkwCompileWeakRef.DoDoIt

class function TkwCompileWeakRef.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'CompileWeakRef';
end;//TkwCompileWeakRef.GetWordNameForRegister

function TkwCompileWeakRef.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwCompileWeakRef.GetResultTypeInfo

function TkwCompileWeakRef.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwCompileWeakRef.GetAllParamsCount

function TkwCompileWeakRef.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwCompileWeakRef.ParamsTypes

type
 TkwDUPN = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� DUPN
*������:*
[code]
 aN DUPN
[code]  }
 private
 // private methods
   procedure DUPN(const aCtx: TtfwContext;
    aN: Integer);
     {* ���������� ����� ������� DUPN }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDUPN

// start class TkwDUPN

procedure TkwDUPN.DUPN(const aCtx: TtfwContext;
  aN: Integer);
//#UC START# *90BD7A4A66F6_9A75B00E3D0A_var*
//#UC END# *90BD7A4A66F6_9A75B00E3D0A_var*
begin
//#UC START# *90BD7A4A66F6_9A75B00E3D0A_impl*
 aCtx.rEngine.DupN(aN);
//#UC END# *90BD7A4A66F6_9A75B00E3D0A_impl*
end;//TkwDUPN.DUPN

procedure TkwDUPN.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aN : Integer;
begin
 try
  l_aN := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aN: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 DUPN(aCtx, l_aN);
end;//TkwDUPN.DoDoIt

class function TkwDUPN.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'DUPN';
end;//TkwDUPN.GetWordNameForRegister

function TkwDUPN.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwDUPN.GetResultTypeInfo

function TkwDUPN.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwDUPN.GetAllParamsCount

function TkwDUPN.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwDUPN.ParamsTypes

type
 TkwDROPN = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� DROPN
*������:*
[code]
 aN DROPN
[code]  }
 private
 // private methods
   procedure DROPN(const aCtx: TtfwContext;
    aN: Integer);
     {* ���������� ����� ������� DROPN }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDROPN

// start class TkwDROPN

procedure TkwDROPN.DROPN(const aCtx: TtfwContext;
  aN: Integer);
//#UC START# *F080EC8A46A5_938A8F1CB0B1_var*
//#UC END# *F080EC8A46A5_938A8F1CB0B1_var*
begin
//#UC START# *F080EC8A46A5_938A8F1CB0B1_impl*
 aCtx.rEngine.DropN(aN);
//#UC END# *F080EC8A46A5_938A8F1CB0B1_impl*
end;//TkwDROPN.DROPN

procedure TkwDROPN.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aN : Integer;
begin
 try
  l_aN := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aN: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 DROPN(aCtx, l_aN);
end;//TkwDROPN.DoDoIt

class function TkwDROPN.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'DROPN';
end;//TkwDROPN.GetWordNameForRegister

function TkwDROPN.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwDROPN.GetResultTypeInfo

function TkwDROPN.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwDROPN.GetAllParamsCount

function TkwDROPN.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwDROPN.ParamsTypes

function CompareValues(const aV1: TtfwStackValue;
  const aV2: TtfwStackValue;
  const aCtx: TtfwContext;
  aCaller: TtfwWord): Boolean;
//#UC START# *4F51EE02033C_4F43A128007E_var*

 procedure CompareAsPrintable;
 begin//CompareAsPrintable
  Result := l3Same(aV1.AsPrintable, aV2.AsPrintable);
 end;//CompareAsPrintable

var
 l_C : AnsiChar;
//#UC END# *4F51EE02033C_4F43A128007E_var*
begin
//#UC START# *4F51EE02033C_4F43A128007E_impl*
 Result := false;
 if (aV1.rType = aV2.rType) then
 begin
  Case aV1.rType of
   tfw_vtVoid:
    Result := true;
   tfw_vtInt:
    Result := (aV1.rInteger = aV2.rInteger);
   tfw_vtBool:
    Result := (aV1.AsBoolean = aV2.AsBoolean);
   tfw_vtStr:
    Result := l3Same(aV1.AsString, aV2.AsString);
   tfw_vtObj:
    Result := (aV1.AsObject = aV2.AsObject);
   tfw_vtList:
    Result := (aV1.AsIntf = aV2.AsIntf);
   tfw_vtIntf:
    Result := (aV1.AsIntf = aV2.AsIntf);
   tfw_vtNil:
    Result := true;
   tfw_vtFile:
    Result := (aV1.AsIntf = aV2.AsIntf);
   tfw_vtChar:
    Result := (aV1.AsChar = aV2.AsChar);
(*   tfw_vtWStr:
    Result := l3Same(aV1.AsWString, aV2.AsWString);*)
(*   tfw_vtBracket:
    Result := true;*)
   else
    aCaller.RunnerError('����������� ��� ��� ���������', aCtx);
  end;//aV1.rType
 end//aV1.rType = aV2.rType
 else
 begin
  Case aV1.rType of
(*   tfw_svtVoid:
    Result := true;
   tfw_svtInt:
    Result := (aV1.rInteger = aV2.rInteger);
   tfw_svtBool:
    Result := (aV1.AsBoolean = aV2.AsBoolean);*)
   tfw_vtStr:
   begin
    Case aV2.rType of
(*     tfw_vtWStr:
      Result := l3Same(aV1.AsString.AsWStr, aV2.AsWString);*)
     tfw_vtChar:
     begin
      l_C := aV2.AsChar;
      Result := l3Same(aV1.AsString.AsWStr, l3PCharLen(@l_C, 1, CP_ANSI));
     end;//tfw_svtChar
     else
      CompareAsPrintable;
    end;//Case aV2.rType
   end;//tfw_svtStr
   tfw_vtObj:
    Case aV2.rType of
     tfw_vtNil:
      Result := (aV1.AsObject = nil);
     else
      CompareAsPrintable;
    end;//Case aV2.rType
   tfw_vtIntf:
    Case aV2.rType of
     tfw_vtNil:
      Result := (aV1.AsIntf = nil);
     else
      CompareAsPrintable;
    end;//Case aV2.rType
   tfw_vtNil:
    Case aV2.rType of
     tfw_vtIntf:
      Result := (aV2.AsIntf = nil);
     tfw_vtObj:
      Result := (aV2.AsObject = nil);
     else
      CompareAsPrintable;
    end;//Case aV2.rType
(*   tfw_svtFile:
    Result := (aV1.AsIntf = aV2.AsIntf);*)
   tfw_vtChar:
   begin
    l_C := aV1.AsChar;
    Case aV2.rType of
     tfw_vtStr:
      Result := l3Same(l3PCharLen(@l_C, 1, CP_ANSI), aV2.AsString.AsWStr);
(*     tfw_vtWStr:
      Result := l3Same(l3PCharLen(@l_C, 1, CP_ANSI), aV2.AsWString);*)
     else
      CompareAsPrintable;
    end;//Case aV2.rType
   end;//tfw_svtChar
(*   tfw_vtWStr:
    Case aV2.rType of
     tfw_vtStr:
      Result := l3Same(aV1.AsWString, aV2.AsString.AsWStr);
     tfw_vtChar:
     begin
      l_C := aV2.AsChar;
      Result := l3Same(aV1.AsWString, l3PCharLen(@l_C, 1, CP_ANSI));
     end;//tfw_svtChar
     else
      CompareAsPrintable;
    end;//Case aV2.rType*)
(*   tfw_svtBracket:
    Result := true;*)
   else
    CompareAsPrintable;
  end;//aV1.rType
 end;//aV1.rType = aV2.rType
//#UC END# *4F51EE02033C_4F43A128007E_impl*
end;//CompareValues
// start class TkwCompiledPushWord

procedure TkwCompiledPushWord.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_55A50F960186_var*
//#UC END# *4DAEEDE10285_55A50F960186_var*
begin
//#UC START# *4DAEEDE10285_55A50F960186_impl*
 aCtx.rEngine.PushObj(WordToWork);
//#UC END# *4DAEEDE10285_55A50F960186_impl*
end;//TkwCompiledPushWord.DoDoIt

function TkwCompiledPushWord.GetRef(const aCtx: TtfwContext): TtfwWord;
//#UC START# *558D2BCA0324_55A50F960186_var*
//#UC END# *558D2BCA0324_55A50F960186_var*
begin
//#UC START# *558D2BCA0324_55A50F960186_impl*
 Result := WordToWork;
 Result := Result.GetRef(aCtx); 
//#UC END# *558D2BCA0324_55A50F960186_impl*
end;//TkwCompiledPushWord.GetRef

function TkwCompiledPushWord.WordName: Il3CString;
//#UC START# *55AFD7DA0258_55A50F960186_var*
//#UC END# *55AFD7DA0258_55A50F960186_var*
begin
//#UC START# *55AFD7DA0258_55A50F960186_impl*
 Result := WordToWork.WordName;
//#UC END# *55AFD7DA0258_55A50F960186_impl*
end;//TkwCompiledPushWord.WordName
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� Define
 TkwDefine.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� TkwCompiledPushWord
 TkwCompiledPushWord.RegisterClass;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
//#UC START# *551588F90151*
 TtfwClassRef.Register(EStreamError);
 TtfwClassRef.Register(EFileStreamError);
 TtfwClassRef.Register(EFCreateError);
 TtfwClassRef.Register(EFOpenError);
 TtfwClassRef.Register(EFilerError);
 TtfwClassRef.Register(EReadError);
 TtfwClassRef.Register(EWriteError);
 TtfwClassRef.Register(EClassNotFound);
 TtfwClassRef.Register(EMethodNotFound);
 TtfwClassRef.Register(EInvalidImage);
 TtfwClassRef.Register(EResNotFound);
 TtfwClassRef.Register(EListError);
 TtfwClassRef.Register(EBitsError);
 TtfwClassRef.Register(EStringListError);
 TtfwClassRef.Register(EComponentError);
 TtfwClassRef.Register(EParserError);
 TtfwClassRef.Register(EOutOfResources);
 TtfwClassRef.Register(EInvalidOperation);

 TtfwClassRef.Register(EAssertionFailed);
 TtfwClassRef.Register(EAccessViolation);
 
 TtfwClassRef.Register(ERangeError);

 TtfwClassRef.Register(EZeroDivide);
 
 TtfwClassRef.Register(EExternalException);
 TtfwClassRef.Register(EIntError);
 TtfwClassRef.Register(EDivByZero);
 TtfwClassRef.Register(EIntOverflow);

 TtfwClassRef.Register(EInvalidOp);
 TtfwClassRef.Register(EOverflow);
 TtfwClassRef.Register(EUnderflow);
 TtfwClassRef.Register(EInvalidPointer);
 TtfwClassRef.Register(EInvalidCast);
 
 TtfwClassRef.Register(EConvertError);
 TtfwClassRef.Register(EPrivilege);
 TtfwClassRef.Register(EStackOverflow);
 
 TtfwClassRef.Register(EControlC);
 
 TtfwClassRef.Register(EIntfCastError);
 
 TtfwClassRef.Register(EOSError);

 TtfwClassRef.Register(EtfwCompiler);
 TtfwClassRef.Register(EtfwRunner);
 TtfwClassRef.Register(EtfwScriptException);
 
 TtfwClassRef.Register(EtfwContinue);
 TtfwClassRef.Register(EtfwBreak);
 TtfwClassRef.Register(EtfwBreakIterator);
 TtfwClassRef.Register(EtfwExit);
 TtfwClassRef.Register(EtfwHalt);

 TtfwClassRef.Register(EtfwFail);
 TtfwClassRef.Register(EtfwManualBreak);
//#UC END# *551588F90151*
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ������������ �����������
 TBasicsPackResNameGetter.Register;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� True
 TkwTrue.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� False
 TkwFalse.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Msg
 TkwMsg.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Print
 TkwPrint.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� LOOP
 TkwLOOP.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� WHILEDO
 TkwWHILEDO.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� BREAK
 TkwBREAK.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� CONTINUE
 TkwCONTINUE.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� EXIT
 TkwEXIT.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� HALT
 TkwHALT.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� BREAKITERATOR
 TkwBREAKITERATOR.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� NOP
 TkwNOP.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� SLEEP
 TkwSLEEP.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ProcessMessages
 TkwProcessMessages.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� CheckAssert
 TkwCheckAssert.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ASSERTS
 TkwASSERTS.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Nil
 TkwNil.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� DoWord
 TkwDoWord.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� SmartEquals
 TkwSmartEquals.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� SmartNotEquals
 TkwSmartNotEquals.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� PushWord
 TkwPushWord.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� current_exception
 TkwCurrentException.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� current_exception_class
 TkwCurrentExceptionClass.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� current_exception_ClassName
 TkwCurrentExceptionClassName.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� current_exception_Message
 TkwCurrentExceptionMessage.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Inc
 TkwInc.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Dec
 TkwDec.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Add
 TkwAdd.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Sub
 TkwSub.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Division
 TkwDivision.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Mul
 TkwMul.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Divide
 TkwDivide.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Mul2
 TkwMul2.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Div2
 TkwDiv2.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� MulDiv
 TkwMulDiv.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� BoolNot
 TkwBoolNot.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ModFromDiv
 TkwModFromDiv.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� BoolAnd
 TkwBoolAnd.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� BoolOr
 TkwBoolOr.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� NotZero
 TkwNotZero.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� EqualZero
 TkwEqualZero.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� SWAP
 TkwSWAP.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� DROP
 TkwDROP.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� DUP
 TkwDUP.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� DUPIfNotZero
 TkwDUPIfNotZero.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ROT
 TkwROT.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� PICK
 TkwPICK.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� InvertROT
 TkwInvertROT.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� SWAP2
 TkwSWAP2.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� OVER2
 TkwOVER2.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� DUP2
 TkwDUP2.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� DROP2
 TkwDROP2.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� NIP
 TkwNIP.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� TUCK
 TkwTUCK.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� OVER
 TkwOVER.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ROLL
 TkwROLL.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� NotEquals
 TkwNotEquals.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� GREATER
 TkwGREATER.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� LESS
 TkwLESS.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Equals
 TkwEquals.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� LessThanZero
 TkwLessThanZero.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� GreaterThanZero
 TkwGreaterThanZero.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� BitAnd
 TkwBitAnd.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� BitOR
 TkwBitOR.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� BitNot
 TkwBitNot.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� StackLevel
 TkwStackLevel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ReduceStackLevel
 TkwReduceStackLevel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_Parser_PushString
 TkwCtxParserPushString.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_Parser_PushSymbol
 TkwCtxParserPushSymbol.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_Parser_PushInt
 TkwCtxParserPushInt.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_Parser
 TkwCtxParser.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� AtomicIf
 TkwAtomicIf.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� CompileValue
 TkwCompileValue.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� IMMEDIATE
 TkwIMMEDIATE.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_ScriptCaller
 TkwCtxScriptCaller.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_Engine
 TkwCtxEngine.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_StoredValuesStack
 TkwCtxStoredValuesStack.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� CreateAndRaise
 TkwCreateAndRaise.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� CompileRef
 TkwCompileRef.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� CompileWeakRef
 TkwCompileWeakRef.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� DUPN
 TkwDUPN.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� DROPN
 TkwDROPN.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwStackValue
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwWord
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Integer
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� String
 TtfwTypeRegistrator.RegisterType(TypeInfo(AnsiString));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TObject
 TtfwTypeRegistrator.RegisterType(TypeInfo(TObject));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TClass
 TtfwTypeRegistrator.RegisterType(@tfw_tiClassRef);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Il3CString
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� ItfwParserEx
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwParserEx));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� ItfwScriptCaller
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwScriptCaller));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� ItfwScriptEngine
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwScriptEngine));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� ItfwStoredValuesStack
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwStoredValuesStack));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwStackValue
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts

end.