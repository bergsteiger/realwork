unit WordsRTTIPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Axiomatics"
// ������: "WordsRTTIPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine$Axiomatics::Words RTTI::WordsRTTIPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  l3Interfaces,
  tfwDictionary,
  tfwScriptingInterfaces,
  tfwAxiomaticsResNameGetter,
  tfwClassLike,
  tfwPropertyLike
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  seWordsInfo,
  tfwMembersIterator,
  kwForwardDeclaration,
  tfwCodeIterator,
  kwCompiledWordPrim,
  kwCompiledWordContainer,
  kwDualCompiledWordContainer,
  kwRuntimeWordWithCode,
  kwForwardDeclarationHolder,
  kwCompiledWordWorker,
  tfwWordRefList,
  tfwScriptEngineExInterfaces,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator,
  kwCompiledWordWorkerWordRunner,
  kwCompiledWordWorkerWord,
  kwCompiledIfElse
  ;

type
//#UC START# *BD54BA1C4F00ci*
//#UC END# *BD54BA1C4F00ci*
//#UC START# *BD54BA1C4F00cit*
//#UC END# *BD54BA1C4F00cit*
 TWordsRTTIPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
 public
 // realized methods
   class function ResName: AnsiString; override;
//#UC START# *BD54BA1C4F00publ*
//#UC END# *BD54BA1C4F00publ*
 end;//TWordsRTTIPackResNameGetter

// start class TWordsRTTIPackResNameGetter

class function TWordsRTTIPackResNameGetter.ResName: AnsiString;
 {-}
begin
 Result := 'WordsRTTIPack';
end;//TWordsRTTIPackResNameGetter.ResName

 {$R WordsRTTIPack.res}

type
 TkwPopWordGetLeftWordRefValue = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Word:GetLeftWordRefValue
*��� ����������:* TtfwWord
*������:*
[code]
OBJECT VAR l_TtfwWord
 anIndex aWord pop:Word:GetLeftWordRefValue >>> l_TtfwWord
[code]  }
 private
 // private methods
   function GetLeftWordRefValue(const aCtx: TtfwContext;
    aWord: TtfwWord;
    anIndex: Integer): TtfwWord;
     {* ���������� ����� ������� pop:Word:GetLeftWordRefValue }
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
 end;//TkwPopWordGetLeftWordRefValue

// start class TkwPopWordGetLeftWordRefValue

function TkwPopWordGetLeftWordRefValue.GetLeftWordRefValue(const aCtx: TtfwContext;
  aWord: TtfwWord;
  anIndex: Integer): TtfwWord;
//#UC START# *77728EE03A69_082046A8DE7B_var*
//#UC END# *77728EE03A69_082046A8DE7B_var*
begin
//#UC START# *77728EE03A69_082046A8DE7B_impl*
 Result := aWord.GetLeftWordRefValue(aCtx, anIndex);
//#UC END# *77728EE03A69_082046A8DE7B_impl*
end;//TkwPopWordGetLeftWordRefValue.GetLeftWordRefValue

procedure TkwPopWordGetLeftWordRefValue.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWord : TtfwWord;
 l_anIndex : Integer;
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
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((GetLeftWordRefValue(aCtx, l_aWord, l_anIndex)));
end;//TkwPopWordGetLeftWordRefValue.DoDoIt

class function TkwPopWordGetLeftWordRefValue.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:GetLeftWordRefValue';
end;//TkwPopWordGetLeftWordRefValue.GetWordNameForRegister

function TkwPopWordGetLeftWordRefValue.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwWord);
end;//TkwPopWordGetLeftWordRefValue.GetResultTypeInfo

function TkwPopWordGetLeftWordRefValue.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopWordGetLeftWordRefValue.GetAllParamsCount

function TkwPopWordGetLeftWordRefValue.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), TypeInfo(Integer)]);
end;//TkwPopWordGetLeftWordRefValue.ParamsTypes

type
 TkwPopWordGetParam = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Word:GetParam
*��� ����������:* TtfwWord
*������:*
[code]
OBJECT VAR l_TtfwWord
 anIndex aWord pop:Word:GetParam >>> l_TtfwWord
[code]  }
 private
 // private methods
   function GetParam(const aCtx: TtfwContext;
    aWord: TtfwWord;
    anIndex: Integer): TtfwWord;
     {* ���������� ����� ������� pop:Word:GetParam }
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
 end;//TkwPopWordGetParam

// start class TkwPopWordGetParam

function TkwPopWordGetParam.GetParam(const aCtx: TtfwContext;
  aWord: TtfwWord;
  anIndex: Integer): TtfwWord;
//#UC START# *0E50B5B72F85_18E1A6E1AA33_var*
//#UC END# *0E50B5B72F85_18E1A6E1AA33_var*
begin
//#UC START# *0E50B5B72F85_18E1A6E1AA33_impl*
 Result := aWord.GetInParam(aCtx, anIndex);
//#UC END# *0E50B5B72F85_18E1A6E1AA33_impl*
end;//TkwPopWordGetParam.GetParam

procedure TkwPopWordGetParam.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWord : TtfwWord;
 l_anIndex : Integer;
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
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((GetParam(aCtx, l_aWord, l_anIndex)));
end;//TkwPopWordGetParam.DoDoIt

class function TkwPopWordGetParam.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:GetParam';
end;//TkwPopWordGetParam.GetWordNameForRegister

function TkwPopWordGetParam.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwWord);
end;//TkwPopWordGetParam.GetResultTypeInfo

function TkwPopWordGetParam.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopWordGetParam.GetAllParamsCount

function TkwPopWordGetParam.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), TypeInfo(Integer)]);
end;//TkwPopWordGetParam.ParamsTypes

type
 TkwPopWordPublicateInMainDictionary = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Word:PublicateInMainDictionary
[panel]��������� ��������� ����� � �������� �������. ���� ����� ����� ��� ��� ����, �� �������� ��������������� (Redifinition)[panel]
*������:*
[code]
 aWord pop:Word:PublicateInMainDictionary
[code]  }
 private
 // private methods
   procedure PublicateInMainDictionary(const aCtx: TtfwContext;
    aWord: TtfwWord);
     {* ���������� ����� ������� pop:Word:PublicateInMainDictionary }
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
 end;//TkwPopWordPublicateInMainDictionary

// start class TkwPopWordPublicateInMainDictionary

procedure TkwPopWordPublicateInMainDictionary.PublicateInMainDictionary(const aCtx: TtfwContext;
  aWord: TtfwWord);
//#UC START# *9AE555BD5A21_F598008DBB04_var*
var
 l_KW : TtfwKeyword;
 l_Key : TtfwKeyWord;
 l_PrevWord : TtfwWord;
 l_PrevWordKW : TtfwKeyWord;
//#UC END# *9AE555BD5A21_F598008DBB04_var*
begin
//#UC START# *9AE555BD5A21_F598008DBB04_impl*
 l_Key := TtfwKeyWord(aWord.Key);
 l_KW := aCtx.rEngine.KeywordFinder(aCtx).CheckWord(l_Key.AsCStr);
 Assert(aWord <> l_KW.Word);
 try
  l_PrevWord := l_KW.Word;
  if (l_PrevWord <> nil) then
   l_PrevWordKW := TtfwKeyWord(l_PrevWord.Key)
  else
   l_PrevWordKW := nil;
  aWord.Redefines := l_PrevWord;
  // - �������, ��� ����� (��������) ����� ���������������
  l_KW.SetWord(aCtx, aWord);
  // - ������������ ����� ����� � �������
  if (l_PrevWord <> nil) then
   l_PrevWord.Key := l_PrevWordKW;
 finally
  aWord.Key := l_Key;
  // - ��������������� ����� ���������� �������� �����
 end;//try..finally
//#UC END# *9AE555BD5A21_F598008DBB04_impl*
end;//TkwPopWordPublicateInMainDictionary.PublicateInMainDictionary

procedure TkwPopWordPublicateInMainDictionary.DoDoIt(const aCtx: TtfwContext);
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
 PublicateInMainDictionary(aCtx, l_aWord);
end;//TkwPopWordPublicateInMainDictionary.DoDoIt

class function TkwPopWordPublicateInMainDictionary.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:PublicateInMainDictionary';
end;//TkwPopWordPublicateInMainDictionary.GetWordNameForRegister

function TkwPopWordPublicateInMainDictionary.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopWordPublicateInMainDictionary.GetResultTypeInfo

function TkwPopWordPublicateInMainDictionary.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordPublicateInMainDictionary.GetAllParamsCount

function TkwPopWordPublicateInMainDictionary.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordPublicateInMainDictionary.ParamsTypes

type
 TkwPopWordSetProducer = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Word:SetProducer
*������:*
[code]
 aProducer aWord pop:Word:SetProducer
[code]  }
 private
 // private methods
   procedure SetProducer(const aCtx: TtfwContext;
    aWord: TtfwWord;
    aProducer: TtfwWord);
     {* ���������� ����� ������� pop:Word:SetProducer }
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
 end;//TkwPopWordSetProducer

// start class TkwPopWordSetProducer

procedure TkwPopWordSetProducer.SetProducer(const aCtx: TtfwContext;
  aWord: TtfwWord;
  aProducer: TtfwWord);
//#UC START# *76D0ECD79670_8EA9132CC57C_var*
//#UC END# *76D0ECD79670_8EA9132CC57C_var*
begin
//#UC START# *76D0ECD79670_8EA9132CC57C_impl*
 aWord.WordProducer := aProducer;
//#UC END# *76D0ECD79670_8EA9132CC57C_impl*
end;//TkwPopWordSetProducer.SetProducer

procedure TkwPopWordSetProducer.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWord : TtfwWord;
 l_aProducer : TtfwWord;
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
  l_aProducer := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord, true));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aProducer: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SetProducer(aCtx, l_aWord, l_aProducer);
end;//TkwPopWordSetProducer.DoDoIt

class function TkwPopWordSetProducer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:SetProducer';
end;//TkwPopWordSetProducer.GetWordNameForRegister

function TkwPopWordSetProducer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopWordSetProducer.GetResultTypeInfo

function TkwPopWordSetProducer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopWordSetProducer.GetAllParamsCount

function TkwPopWordSetProducer.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), TypeInfo(TtfwWord)]);
end;//TkwPopWordSetProducer.ParamsTypes

type
 TkwPopWordFindMember = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Word:FindMember
*��� ����������:* TtfwKeyWord
*������:*
[code]
OBJECT VAR l_TtfwKeyWord
 aName aWord pop:Word:FindMember >>> l_TtfwKeyWord
[code]  }
 private
 // private methods
   function FindMember(const aCtx: TtfwContext;
    aWord: TtfwWord;
    const aName: Il3CString): TtfwKeyWord;
     {* ���������� ����� ������� pop:Word:FindMember }
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
 end;//TkwPopWordFindMember

// start class TkwPopWordFindMember

function TkwPopWordFindMember.FindMember(const aCtx: TtfwContext;
  aWord: TtfwWord;
  const aName: Il3CString): TtfwKeyWord;
//#UC START# *A78847AB9E1F_289A2FC7F4D3_var*
//#UC END# *A78847AB9E1F_289A2FC7F4D3_var*
begin
//#UC START# *A78847AB9E1F_289A2FC7F4D3_impl*
 if (aWord.InnerDictionary <> nil) then
  Result := (aWord.InnerDictionary As TtfwDictionary).DRbyCName[aName]
 else
  Result := nil;
//#UC END# *A78847AB9E1F_289A2FC7F4D3_impl*
end;//TkwPopWordFindMember.FindMember

procedure TkwPopWordFindMember.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWord : TtfwWord;
 l_aName : Il3CString;
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
  l_aName := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aName: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FindMember(aCtx, l_aWord, l_aName)));
end;//TkwPopWordFindMember.DoDoIt

class function TkwPopWordFindMember.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:FindMember';
end;//TkwPopWordFindMember.GetWordNameForRegister

function TkwPopWordFindMember.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwKeyWord);
end;//TkwPopWordFindMember.GetResultTypeInfo

function TkwPopWordFindMember.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopWordFindMember.GetAllParamsCount

function TkwPopWordFindMember.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), @tfw_tiString]);
end;//TkwPopWordFindMember.ParamsTypes

type
 TkwPopWordGetRef = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Word:GetRef
*��� ����������:* TtfwWord
*������:*
[code]
OBJECT VAR l_TtfwWord
 aWord pop:Word:GetRef >>> l_TtfwWord
[code]  }
 private
 // private methods
   function GetRef(const aCtx: TtfwContext;
    aWord: TtfwWord): TtfwWord;
     {* ���������� ����� ������� pop:Word:GetRef }
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
 end;//TkwPopWordGetRef

// start class TkwPopWordGetRef

function TkwPopWordGetRef.GetRef(const aCtx: TtfwContext;
  aWord: TtfwWord): TtfwWord;
//#UC START# *40860C2E9C2E_A74A73E17FB3_var*
//#UC END# *40860C2E9C2E_A74A73E17FB3_var*
begin
//#UC START# *40860C2E9C2E_A74A73E17FB3_impl*
 Result := aWord.GetRef(aCtx);
//#UC END# *40860C2E9C2E_A74A73E17FB3_impl*
end;//TkwPopWordGetRef.GetRef

procedure TkwPopWordGetRef.DoDoIt(const aCtx: TtfwContext);
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
 aCtx.rEngine.PushObj((GetRef(aCtx, l_aWord)));
end;//TkwPopWordGetRef.DoDoIt

class function TkwPopWordGetRef.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:GetRef';
end;//TkwPopWordGetRef.GetWordNameForRegister

function TkwPopWordGetRef.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwWord);
end;//TkwPopWordGetRef.GetResultTypeInfo

function TkwPopWordGetRef.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordGetRef.GetAllParamsCount

function TkwPopWordGetRef.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordGetRef.ParamsTypes

type
 TkwPopWordSourcePointString = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Word:SourcePointString
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aWord pop:Word:SourcePointString >>> l_String
[code]  }
 private
 // private methods
   function SourcePointString(const aCtx: TtfwContext;
    aWord: TtfwWord): AnsiString;
     {* ���������� ����� ������� pop:Word:SourcePointString }
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
 end;//TkwPopWordSourcePointString

// start class TkwPopWordSourcePointString

function TkwPopWordSourcePointString.SourcePointString(const aCtx: TtfwContext;
  aWord: TtfwWord): AnsiString;
//#UC START# *D90ED7F34B68_023E8C15D57F_var*
//#UC END# *D90ED7F34B68_023E8C15D57F_var*
begin
//#UC START# *D90ED7F34B68_023E8C15D57F_impl*
 Result := aWord.SourcePoint.ToString;
//#UC END# *D90ED7F34B68_023E8C15D57F_impl*
end;//TkwPopWordSourcePointString.SourcePointString

procedure TkwPopWordSourcePointString.DoDoIt(const aCtx: TtfwContext);
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
 aCtx.rEngine.PushString((SourcePointString(aCtx, l_aWord)));
end;//TkwPopWordSourcePointString.DoDoIt

class function TkwPopWordSourcePointString.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:SourcePointString';
end;//TkwPopWordSourcePointString.GetWordNameForRegister

function TkwPopWordSourcePointString.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(AnsiString);
end;//TkwPopWordSourcePointString.GetResultTypeInfo

function TkwPopWordSourcePointString.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordSourcePointString.GetAllParamsCount

function TkwPopWordSourcePointString.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordSourcePointString.ParamsTypes

type
 TkwPopWordIsVarLike = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Word:IsVarLike
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aWord pop:Word:IsVarLike >>> l_Boolean
[code]  }
 private
 // private methods
   function IsVarLike(const aCtx: TtfwContext;
    aWord: TtfwWord): Boolean;
     {* ���������� ����� ������� pop:Word:IsVarLike }
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
 end;//TkwPopWordIsVarLike

// start class TkwPopWordIsVarLike

function TkwPopWordIsVarLike.IsVarLike(const aCtx: TtfwContext;
  aWord: TtfwWord): Boolean;
//#UC START# *2E59A9A784D4_D3A8B5A317FE_var*
//#UC END# *2E59A9A784D4_D3A8B5A317FE_var*
begin
//#UC START# *2E59A9A784D4_D3A8B5A317FE_impl*
 Result := aWord.IsVarLike;
//#UC END# *2E59A9A784D4_D3A8B5A317FE_impl*
end;//TkwPopWordIsVarLike.IsVarLike

procedure TkwPopWordIsVarLike.DoDoIt(const aCtx: TtfwContext);
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
 aCtx.rEngine.PushBool((IsVarLike(aCtx, l_aWord)));
end;//TkwPopWordIsVarLike.DoDoIt

class function TkwPopWordIsVarLike.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:IsVarLike';
end;//TkwPopWordIsVarLike.GetWordNameForRegister

function TkwPopWordIsVarLike.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopWordIsVarLike.GetResultTypeInfo

function TkwPopWordIsVarLike.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordIsVarLike.GetAllParamsCount

function TkwPopWordIsVarLike.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordIsVarLike.ParamsTypes

type
 TkwPopWordIsInParam = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Word:IsInParam
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aWord pop:Word:IsInParam >>> l_Boolean
[code]  }
 private
 // private methods
   function IsInParam(const aCtx: TtfwContext;
    aWord: TtfwWord): Boolean;
     {* ���������� ����� ������� pop:Word:IsInParam }
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
 end;//TkwPopWordIsInParam

// start class TkwPopWordIsInParam

function TkwPopWordIsInParam.IsInParam(const aCtx: TtfwContext;
  aWord: TtfwWord): Boolean;
//#UC START# *A3681005727A_252F9E4AEA1C_var*
//#UC END# *A3681005727A_252F9E4AEA1C_var*
begin
//#UC START# *A3681005727A_252F9E4AEA1C_impl*
 Result := aWord.IsInParam;
//#UC END# *A3681005727A_252F9E4AEA1C_impl*
end;//TkwPopWordIsInParam.IsInParam

procedure TkwPopWordIsInParam.DoDoIt(const aCtx: TtfwContext);
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
 aCtx.rEngine.PushBool((IsInParam(aCtx, l_aWord)));
end;//TkwPopWordIsInParam.DoDoIt

class function TkwPopWordIsInParam.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:IsInParam';
end;//TkwPopWordIsInParam.GetWordNameForRegister

function TkwPopWordIsInParam.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopWordIsInParam.GetResultTypeInfo

function TkwPopWordIsInParam.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordIsInParam.GetAllParamsCount

function TkwPopWordIsInParam.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordIsInParam.ParamsTypes

type
 TkwPopWordSetValue = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Word:SetValue
*������:*
[code]
 aValue aWord pop:Word:SetValue
[code]  }
 private
 // private methods
   procedure SetValue(const aCtx: TtfwContext;
    aWord: TtfwWord;
    const aValue: TtfwStackValue);
     {* ���������� ����� ������� pop:Word:SetValue }
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
 end;//TkwPopWordSetValue

// start class TkwPopWordSetValue

procedure TkwPopWordSetValue.SetValue(const aCtx: TtfwContext;
  aWord: TtfwWord;
  const aValue: TtfwStackValue);
//#UC START# *80E6106682BF_FF9BD5F0BEBA_var*
//#UC END# *80E6106682BF_FF9BD5F0BEBA_var*
begin
//#UC START# *80E6106682BF_FF9BD5F0BEBA_impl*
 aWord.SetValue(aValue, aCtx);
//#UC END# *80E6106682BF_FF9BD5F0BEBA_impl*
end;//TkwPopWordSetValue.SetValue

procedure TkwPopWordSetValue.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWord : TtfwWord;
 l_aValue : TtfwStackValue;
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
  l_aValue := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SetValue(aCtx, l_aWord, l_aValue);
end;//TkwPopWordSetValue.DoDoIt

class function TkwPopWordSetValue.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:SetValue';
end;//TkwPopWordSetValue.GetWordNameForRegister

function TkwPopWordSetValue.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopWordSetValue.GetResultTypeInfo

function TkwPopWordSetValue.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopWordSetValue.GetAllParamsCount

function TkwPopWordSetValue.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), @tfw_tiStruct]);
end;//TkwPopWordSetValue.ParamsTypes

type
 TkwPopWordInfo = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Word:Info
*��� ����������:* TtfwWordInfo
*������:*
[code]
OBJECT VAR l_TtfwWordInfo
 aWord pop:Word:Info >>> l_TtfwWordInfo
[code]  }
 private
 // private methods
   function Info(const aCtx: TtfwContext;
    aWord: TtfwWord): TtfwWordInfo;
     {* ���������� ����� ������� pop:Word:Info }
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
 end;//TkwPopWordInfo

// start class TkwPopWordInfo

function TkwPopWordInfo.Info(const aCtx: TtfwContext;
  aWord: TtfwWord): TtfwWordInfo;
//#UC START# *51983D6F5E34_729F2B05F10B_var*
//#UC END# *51983D6F5E34_729F2B05F10B_var*
begin
//#UC START# *51983D6F5E34_729F2B05F10B_impl*
 Result := aWord.ResultTypeInfo[aCtx];
//#UC END# *51983D6F5E34_729F2B05F10B_impl*
end;//TkwPopWordInfo.Info

procedure TkwPopWordInfo.DoDoIt(const aCtx: TtfwContext);
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
 aCtx.rEngine.PushObj((Info(aCtx, l_aWord)));
end;//TkwPopWordInfo.DoDoIt

class function TkwPopWordInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:Info';
end;//TkwPopWordInfo.GetWordNameForRegister

function TkwPopWordInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwWordInfo);
end;//TkwPopWordInfo.GetResultTypeInfo

function TkwPopWordInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordInfo.GetAllParamsCount

function TkwPopWordInfo.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordInfo.ParamsTypes

type
 TkwPopWordIsForHelp = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Word:IsForHelp
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aWord pop:Word:IsForHelp >>> l_Boolean
[code]  }
 private
 // private methods
   function IsForHelp(const aCtx: TtfwContext;
    aWord: TtfwWord): Boolean;
     {* ���������� ����� ������� pop:Word:IsForHelp }
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
 end;//TkwPopWordIsForHelp

// start class TkwPopWordIsForHelp

function TkwPopWordIsForHelp.IsForHelp(const aCtx: TtfwContext;
  aWord: TtfwWord): Boolean;
 {-}
begin
 Result := aWord.IsForHelp;
end;//TkwPopWordIsForHelp.IsForHelp

procedure TkwPopWordIsForHelp.DoDoIt(const aCtx: TtfwContext);
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
 aCtx.rEngine.PushBool((IsForHelp(aCtx, l_aWord)));
end;//TkwPopWordIsForHelp.DoDoIt

class function TkwPopWordIsForHelp.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:IsForHelp';
end;//TkwPopWordIsForHelp.GetWordNameForRegister

function TkwPopWordIsForHelp.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopWordIsForHelp.GetResultTypeInfo

function TkwPopWordIsForHelp.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordIsForHelp.GetAllParamsCount

function TkwPopWordIsForHelp.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordIsForHelp.ParamsTypes

type
 TkwPopWordIsImmediate = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Word:IsImmediate
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aWord pop:Word:IsImmediate >>> l_Boolean
[code]  }
 private
 // private methods
   function IsImmediate(const aCtx: TtfwContext;
    aWord: TtfwWord): Boolean;
     {* ���������� ����� ������� pop:Word:IsImmediate }
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
 end;//TkwPopWordIsImmediate

// start class TkwPopWordIsImmediate

function TkwPopWordIsImmediate.IsImmediate(const aCtx: TtfwContext;
  aWord: TtfwWord): Boolean;
//#UC START# *2FA551E3AF7E_0D83B83BE222_var*
//#UC END# *2FA551E3AF7E_0D83B83BE222_var*
begin
//#UC START# *2FA551E3AF7E_0D83B83BE222_impl*
 Result := aWord.IsImmediate(aCtx);
//#UC END# *2FA551E3AF7E_0D83B83BE222_impl*
end;//TkwPopWordIsImmediate.IsImmediate

procedure TkwPopWordIsImmediate.DoDoIt(const aCtx: TtfwContext);
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
 aCtx.rEngine.PushBool((IsImmediate(aCtx, l_aWord)));
end;//TkwPopWordIsImmediate.DoDoIt

class function TkwPopWordIsImmediate.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:IsImmediate';
end;//TkwPopWordIsImmediate.GetWordNameForRegister

function TkwPopWordIsImmediate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopWordIsImmediate.GetResultTypeInfo

function TkwPopWordIsImmediate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordIsImmediate.GetAllParamsCount

function TkwPopWordIsImmediate.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordIsImmediate.ParamsTypes

type
 TkwPopWordIncRef = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Word:IncRef
[panel]����������� ������� ������[panel]
*������:*
[code]
 aWord pop:Word:IncRef
[code]  }
 private
 // private methods
   procedure IncRef(const aCtx: TtfwContext;
    aWord: TtfwWord);
     {* ���������� ����� ������� pop:Word:IncRef }
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
 end;//TkwPopWordIncRef

// start class TkwPopWordIncRef

procedure TkwPopWordIncRef.IncRef(const aCtx: TtfwContext;
  aWord: TtfwWord);
//#UC START# *E571552281D4_76CDD4A4EF99_var*
//#UC END# *E571552281D4_76CDD4A4EF99_var*
begin
//#UC START# *E571552281D4_76CDD4A4EF99_impl*
 aWord.Use;
//#UC END# *E571552281D4_76CDD4A4EF99_impl*
end;//TkwPopWordIncRef.IncRef

procedure TkwPopWordIncRef.DoDoIt(const aCtx: TtfwContext);
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
 IncRef(aCtx, l_aWord);
end;//TkwPopWordIncRef.DoDoIt

class function TkwPopWordIncRef.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:IncRef';
end;//TkwPopWordIncRef.GetWordNameForRegister

function TkwPopWordIncRef.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopWordIncRef.GetResultTypeInfo

function TkwPopWordIncRef.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordIncRef.GetAllParamsCount

function TkwPopWordIncRef.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordIncRef.ParamsTypes

type
 TkwPopWordDecRef = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Word:DecRef
[panel]��������� ������� ������[panel]
*������:*
[code]
 aWord pop:Word:DecRef
[code]  }
 private
 // private methods
   procedure DecRef(const aCtx: TtfwContext;
    aWord: TtfwWord);
     {* ���������� ����� ������� pop:Word:DecRef }
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
 end;//TkwPopWordDecRef

// start class TkwPopWordDecRef

procedure TkwPopWordDecRef.DecRef(const aCtx: TtfwContext;
  aWord: TtfwWord);
//#UC START# *0F1AAC70C4E6_E5CE67CA0A33_var*
//#UC END# *0F1AAC70C4E6_E5CE67CA0A33_var*
begin
//#UC START# *0F1AAC70C4E6_E5CE67CA0A33_impl*
 aWord.Free;
//#UC END# *0F1AAC70C4E6_E5CE67CA0A33_impl*
end;//TkwPopWordDecRef.DecRef

procedure TkwPopWordDecRef.DoDoIt(const aCtx: TtfwContext);
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
 DecRef(aCtx, l_aWord);
end;//TkwPopWordDecRef.DoDoIt

class function TkwPopWordDecRef.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:DecRef';
end;//TkwPopWordDecRef.GetWordNameForRegister

function TkwPopWordDecRef.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopWordDecRef.GetResultTypeInfo

function TkwPopWordDecRef.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordDecRef.GetAllParamsCount

function TkwPopWordDecRef.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordDecRef.ParamsTypes

type
 TkwPopWordMembersIterator = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Word:MembersIterator
*��� ����������:* ItfwValueList
*������:*
[code]
ARRAY VAR l_ItfwValueList
 aWord pop:Word:MembersIterator >>> l_ItfwValueList
[code]  }
 private
 // private methods
   function MembersIterator(const aCtx: TtfwContext;
    aWord: TtfwWord): ItfwValueList;
     {* ���������� ����� ������� pop:Word:MembersIterator }
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
 end;//TkwPopWordMembersIterator

// start class TkwPopWordMembersIterator

function TkwPopWordMembersIterator.MembersIterator(const aCtx: TtfwContext;
  aWord: TtfwWord): ItfwValueList;
//#UC START# *092BBE4CCE0C_44A52B9145D9_var*
//#UC END# *092BBE4CCE0C_44A52B9145D9_var*
begin
//#UC START# *092BBE4CCE0C_44A52B9145D9_impl*
 if (aWord = nil) then
  Result := TtfwMembersIterator.Make(nil)
 else
 if (aWord Is TkwForwardDeclaration) then
  Result := TtfwMembersIterator.Make(TkwForwardDeclaration(aWord).RealWord.InnerDictionary)
 else
  Result := TtfwMembersIterator.Make(aWord.InnerDictionary);
//#UC END# *092BBE4CCE0C_44A52B9145D9_impl*
end;//TkwPopWordMembersIterator.MembersIterator

procedure TkwPopWordMembersIterator.DoDoIt(const aCtx: TtfwContext);
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
 aCtx.rEngine.PushList((MembersIterator(aCtx, l_aWord)));
end;//TkwPopWordMembersIterator.DoDoIt

class function TkwPopWordMembersIterator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:MembersIterator';
end;//TkwPopWordMembersIterator.GetWordNameForRegister

function TkwPopWordMembersIterator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwPopWordMembersIterator.GetResultTypeInfo

function TkwPopWordMembersIterator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordMembersIterator.GetAllParamsCount

function TkwPopWordMembersIterator.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordMembersIterator.ParamsTypes

type
 TkwPopWordInnerDictionary = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Word:InnerDictionary
*��� ����������:* TtfwDictionary
*������:*
[code]
OBJECT VAR l_TtfwDictionary
 aWord pop:Word:InnerDictionary >>> l_TtfwDictionary
[code]  }
 private
 // private methods
   function InnerDictionary(const aCtx: TtfwContext;
    aWord: TtfwWord): TtfwDictionary;
     {* ���������� ����� ������� pop:Word:InnerDictionary }
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
 end;//TkwPopWordInnerDictionary

// start class TkwPopWordInnerDictionary

function TkwPopWordInnerDictionary.InnerDictionary(const aCtx: TtfwContext;
  aWord: TtfwWord): TtfwDictionary;
//#UC START# *5F29394A3B0F_3B0F200560B8_var*
//#UC END# *5F29394A3B0F_3B0F200560B8_var*
begin
//#UC START# *5F29394A3B0F_3B0F200560B8_impl*
 Result := aWord.InnerDictionary As TtfwDictionary;
//#UC END# *5F29394A3B0F_3B0F200560B8_impl*
end;//TkwPopWordInnerDictionary.InnerDictionary

procedure TkwPopWordInnerDictionary.DoDoIt(const aCtx: TtfwContext);
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
 aCtx.rEngine.PushObj((InnerDictionary(aCtx, l_aWord)));
end;//TkwPopWordInnerDictionary.DoDoIt

class function TkwPopWordInnerDictionary.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:InnerDictionary';
end;//TkwPopWordInnerDictionary.GetWordNameForRegister

function TkwPopWordInnerDictionary.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwDictionary);
end;//TkwPopWordInnerDictionary.GetResultTypeInfo

function TkwPopWordInnerDictionary.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordInnerDictionary.GetAllParamsCount

function TkwPopWordInnerDictionary.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordInnerDictionary.ParamsTypes

type
 TkwPopWordCodeIterator = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Word:CodeIterator
*��� ����������:* ItfwValueList
*������:*
[code]
ARRAY VAR l_ItfwValueList
 aWord pop:Word:CodeIterator >>> l_ItfwValueList
[code]  }
 private
 // private methods
   function CodeIterator(const aCtx: TtfwContext;
    aWord: TtfwWord): ItfwValueList;
     {* ���������� ����� ������� pop:Word:CodeIterator }
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
 end;//TkwPopWordCodeIterator

// start class TkwPopWordCodeIterator

function TkwPopWordCodeIterator.CodeIterator(const aCtx: TtfwContext;
  aWord: TtfwWord): ItfwValueList;
//#UC START# *C4C77155D94B_368F6A08F367_var*

 function DoWord(aWord : TtfwWord) : ItfwValueList;
 var
  l_List : TtfwWordRefList;
  l_RightParamsCount : Integer;
  l_Index : Integer;
 begin//DoWord
  if (aWord Is TkwForwardDeclaration) then
   Result := DoWord(TkwForwardDeclaration(aWord).RealWord)
  else
  if (aWord is TkwCompiledWordWorkerWord) then
   Result := DoWord(TkwCompiledWordWorkerWord(aWord).Compiled)
  else
  if (aWord is TkwForwardDeclarationHolder) then
  begin
   l_List := TtfwWordRefList.Create;
   try
    l_List.Add(TkwForwardDeclarationHolder(aWord).Holded);
    Result := TtfwCodeIterator.Make(l_List);
   finally
    FreeAndNil(l_List);
   end;//try..finally
  end//aWord is TkwForwardDeclarationHolder
  else
  if (aWord is TkwCompiledIfElse) then
  begin
   l_List := TtfwWordRefList.Create;
   try
    l_List.Add(TkwCompiledIfElse(aWord).Condition);
    l_List.Add(TkwCompiledIfElse(aWord).WordToWork);
    if (TkwCompiledIfElse(aWord).ElseBranch <> nil) then
     l_List.Add(TkwCompiledIfElse(aWord).ElseBranch);
    Result := TtfwCodeIterator.Make(l_List);
   finally
    FreeAndNil(l_List);
   end;//try..finally
  end//aWord is TkwCompiledIfElse
  else
  if (aWord is TkwDualCompiledWordContainer) then
  begin
   l_List := TtfwWordRefList.Create;
   try
    l_List.Add(TkwDualCompiledWordContainer(aWord).WordToWork);
    if (TkwDualCompiledWordContainer(aWord).ElseBranch <> nil) then
     l_List.Add(TkwDualCompiledWordContainer(aWord).ElseBranch);
    Result := TtfwCodeIterator.Make(l_List);
   finally
    FreeAndNil(l_List);
   end;//try..finally
  end//aWord is TkwDualCompiledWordContainer
  else
  if (aWord is TkwCompiledWordContainer) then
  begin
   l_List := TtfwWordRefList.Create;
   try
    l_List.Add(TkwCompiledWordContainer(aWord).WordToWork);
    Result := TtfwCodeIterator.Make(l_List);
   finally
    FreeAndNil(l_List);
   end;//try..finally
  end//aWord is TkwCompiledWordContainer
  else
  if (aWord is TkwCompiledWordWorkerWordRunner) then
  begin
   l_List := TtfwWordRefList.Create;
   try
    l_RightParamsCount := TkwCompiledWordWorkerWordRunner(aWord).WordToRun.RightParamsCount(aCtx);
    if (l_RightParamsCount = 1) then
     l_List.Add(TkwCompiledWordWorkerWordRunner(aWord).WordToWork)
    else
    begin
     for l_Index := 0 to Pred(l_RightParamsCount) do
      l_List.Add((TkwCompiledWordWorkerWordRunner(aWord).WordToWork As TkwRuntimeWordWithCode).Code[l_Index]);
    end;//l_RightParamsCount = 1
    Result := TtfwCodeIterator.Make(l_List);
   finally
    FreeAndNil(l_List);
   end;//try..finally
  end//aWord is TkwCompiledWordWorkerWordRunner
  else
  if (aWord is TkwCompiledWordWorker) then
  begin
   l_List := TtfwWordRefList.Create;
   try
    l_List.Add(TkwCompiledWordWorker(aWord).WordToWork);
    Result := TtfwCodeIterator.Make(l_List);
   finally
    FreeAndNil(l_List);
   end;//try..finally
  end//aWord is TkwCompiledWordWorker
  else
  if (aWord = nil) OR not (aWord Is TkwRuntimeWordWithCode) then
   Result := TtfwCodeIterator.Make(nil)
  else
   Result := TtfwCodeIterator.Make(TkwCompiledWordPrim(aWord).GetCode(aCtx));
 end;//DoWord

//#UC END# *C4C77155D94B_368F6A08F367_var*
begin
//#UC START# *C4C77155D94B_368F6A08F367_impl*
 Result := DoWord(aWord);
//#UC END# *C4C77155D94B_368F6A08F367_impl*
end;//TkwPopWordCodeIterator.CodeIterator

procedure TkwPopWordCodeIterator.DoDoIt(const aCtx: TtfwContext);
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
 aCtx.rEngine.PushList((CodeIterator(aCtx, l_aWord)));
end;//TkwPopWordCodeIterator.DoDoIt

class function TkwPopWordCodeIterator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:CodeIterator';
end;//TkwPopWordCodeIterator.GetWordNameForRegister

function TkwPopWordCodeIterator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwPopWordCodeIterator.GetResultTypeInfo

function TkwPopWordCodeIterator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordCodeIterator.GetAllParamsCount

function TkwPopWordCodeIterator.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordCodeIterator.ParamsTypes

type
 TkwPopWordSetValuePrim = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Word:SetValuePrim
*������:*
[code]
 aValue aWord pop:Word:SetValuePrim
[code]  }
 private
 // private methods
   procedure SetValuePrim(const aCtx: TtfwContext;
    aWord: TtfwWord;
    const aValue: TtfwStackValue);
     {* ���������� ����� ������� pop:Word:SetValuePrim }
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
 end;//TkwPopWordSetValuePrim

// start class TkwPopWordSetValuePrim

procedure TkwPopWordSetValuePrim.SetValuePrim(const aCtx: TtfwContext;
  aWord: TtfwWord;
  const aValue: TtfwStackValue);
//#UC START# *81B1B00AB03E_B103AAB7CCE4_var*
//#UC END# *81B1B00AB03E_B103AAB7CCE4_var*
begin
//#UC START# *81B1B00AB03E_B103AAB7CCE4_impl*
 aWord.SetValuePrim(aValue, aCtx);
//#UC END# *81B1B00AB03E_B103AAB7CCE4_impl*
end;//TkwPopWordSetValuePrim.SetValuePrim

procedure TkwPopWordSetValuePrim.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWord : TtfwWord;
 l_aValue : TtfwStackValue;
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
  l_aValue := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SetValuePrim(aCtx, l_aWord, l_aValue);
end;//TkwPopWordSetValuePrim.DoDoIt

class function TkwPopWordSetValuePrim.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:SetValuePrim';
end;//TkwPopWordSetValuePrim.GetWordNameForRegister

function TkwPopWordSetValuePrim.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopWordSetValuePrim.GetResultTypeInfo

function TkwPopWordSetValuePrim.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopWordSetValuePrim.GetAllParamsCount

function TkwPopWordSetValuePrim.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), @tfw_tiStruct]);
end;//TkwPopWordSetValuePrim.ParamsTypes

type
 TkwPopWordKeyWord = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Word:KeyWord
*��� ����������:* TtfwKeyWord
*������:*
[code]
OBJECT VAR l_TtfwKeyWord
 aWord pop:Word:KeyWord >>> l_TtfwKeyWord
[code]  }
 private
 // private methods
   function KeyWord(const aCtx: TtfwContext;
    aWord: TtfwWord): TtfwKeyWord;
     {* ���������� ����� ������� pop:Word:KeyWord }
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
 end;//TkwPopWordKeyWord

// start class TkwPopWordKeyWord

function TkwPopWordKeyWord.KeyWord(const aCtx: TtfwContext;
  aWord: TtfwWord): TtfwKeyWord;
//#UC START# *34F1730D1DCE_E6AF38361418_var*
//#UC END# *34F1730D1DCE_E6AF38361418_var*
begin
//#UC START# *34F1730D1DCE_E6AF38361418_impl*
 Result := aWord.Key As TtfwKeyWord;
//#UC END# *34F1730D1DCE_E6AF38361418_impl*
end;//TkwPopWordKeyWord.KeyWord

procedure TkwPopWordKeyWord.DoDoIt(const aCtx: TtfwContext);
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
 aCtx.rEngine.PushObj((KeyWord(aCtx, l_aWord)));
end;//TkwPopWordKeyWord.DoDoIt

class function TkwPopWordKeyWord.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:KeyWord';
end;//TkwPopWordKeyWord.GetWordNameForRegister

function TkwPopWordKeyWord.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwKeyWord);
end;//TkwPopWordKeyWord.GetResultTypeInfo

function TkwPopWordKeyWord.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordKeyWord.GetAllParamsCount

function TkwPopWordKeyWord.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordKeyWord.ParamsTypes

type
 TkwPopWordDirectives = {final scriptword} class(TtfwPropertyLike)
  {* ����� ������� pop:Word:Directives
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aWord pop:Word:Directives >>> l_Il3CString
[code]  }
 private
 // private methods
   function Directives(const aCtx: TtfwContext;
    aWord: TtfwWord): Il3CString;
     {* ���������� ����� ������� pop:Word:Directives }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordDirectives

// start class TkwPopWordDirectives

function TkwPopWordDirectives.Directives(const aCtx: TtfwContext;
  aWord: TtfwWord): Il3CString;
//#UC START# *FB7C52FA2B52_3D48CC7059CD_var*
//#UC END# *FB7C52FA2B52_3D48CC7059CD_var*
begin
//#UC START# *FB7C52FA2B52_3D48CC7059CD_impl*
 Result := GetWordDirectives(aCtx, aWord);
//#UC END# *FB7C52FA2B52_3D48CC7059CD_impl*
end;//TkwPopWordDirectives.Directives

procedure TkwPopWordDirectives.DoDoIt(const aCtx: TtfwContext);
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
 aCtx.rEngine.PushString((Directives(aCtx, l_aWord)));
end;//TkwPopWordDirectives.DoDoIt

class function TkwPopWordDirectives.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:Directives';
end;//TkwPopWordDirectives.GetWordNameForRegister

procedure TkwPopWordDirectives.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� Directives', aCtx);
end;//TkwPopWordDirectives.SetValuePrim

function TkwPopWordDirectives.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiString;
end;//TkwPopWordDirectives.GetResultTypeInfo

function TkwPopWordDirectives.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordDirectives.GetAllParamsCount

function TkwPopWordDirectives.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordDirectives.ParamsTypes

type
 TkwPopWordEndBracket = {final scriptword} class(TtfwPropertyLike)
  {* ����� ������� pop:Word:EndBracket
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aWord pop:Word:EndBracket >>> l_String
[code]  }
 private
 // private methods
   function EndBracket(const aCtx: TtfwContext;
    aWord: TtfwWord): AnsiString;
     {* ���������� ����� ������� pop:Word:EndBracket }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordEndBracket

// start class TkwPopWordEndBracket

function TkwPopWordEndBracket.EndBracket(const aCtx: TtfwContext;
  aWord: TtfwWord): AnsiString;
//#UC START# *A2984E82225C_035A954E5F92_var*
var
 l_B : RtfwWord;
//#UC END# *A2984E82225C_035A954E5F92_var*
begin
//#UC START# *A2984E82225C_035A954E5F92_impl*
 try
  if (aWord = nil) then
   l_B := nil
  else
   l_B := aWord.GetEndBracket(aCtx, true);
 except
  l_B := nil;
 end;//try..except
 if (l_B = nil) then
  Result := ''
 else
  Result := aCtx.rEngine.KeywordByName(TtfwCStringFactory.C(l_B.NameForRegister)).AsString;
//#UC END# *A2984E82225C_035A954E5F92_impl*
end;//TkwPopWordEndBracket.EndBracket

procedure TkwPopWordEndBracket.DoDoIt(const aCtx: TtfwContext);
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
 aCtx.rEngine.PushString((EndBracket(aCtx, l_aWord)));
end;//TkwPopWordEndBracket.DoDoIt

class function TkwPopWordEndBracket.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:EndBracket';
end;//TkwPopWordEndBracket.GetWordNameForRegister

procedure TkwPopWordEndBracket.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� EndBracket', aCtx);
end;//TkwPopWordEndBracket.SetValuePrim

function TkwPopWordEndBracket.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(AnsiString);
end;//TkwPopWordEndBracket.GetResultTypeInfo

function TkwPopWordEndBracket.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordEndBracket.GetAllParamsCount

function TkwPopWordEndBracket.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordEndBracket.ParamsTypes

type
 TkwPopWordLeftWordRefValuesCount = {final scriptword} class(TtfwPropertyLike)
  {* ����� ������� pop:Word:LeftWordRefValuesCount
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aWord pop:Word:LeftWordRefValuesCount >>> l_Integer
[code]  }
 private
 // private methods
   function LeftWordRefValuesCount(const aCtx: TtfwContext;
    aWord: TtfwWord): Integer;
     {* ���������� ����� ������� pop:Word:LeftWordRefValuesCount }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordLeftWordRefValuesCount

// start class TkwPopWordLeftWordRefValuesCount

function TkwPopWordLeftWordRefValuesCount.LeftWordRefValuesCount(const aCtx: TtfwContext;
  aWord: TtfwWord): Integer;
//#UC START# *506A313D6D93_699E423B4C87_var*
//#UC END# *506A313D6D93_699E423B4C87_var*
begin
//#UC START# *506A313D6D93_699E423B4C87_impl*
 Result := aWord.LeftWordRefValuesCount(aCtx);
//#UC END# *506A313D6D93_699E423B4C87_impl*
end;//TkwPopWordLeftWordRefValuesCount.LeftWordRefValuesCount

procedure TkwPopWordLeftWordRefValuesCount.DoDoIt(const aCtx: TtfwContext);
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
 aCtx.rEngine.PushInt((LeftWordRefValuesCount(aCtx, l_aWord)));
end;//TkwPopWordLeftWordRefValuesCount.DoDoIt

class function TkwPopWordLeftWordRefValuesCount.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:LeftWordRefValuesCount';
end;//TkwPopWordLeftWordRefValuesCount.GetWordNameForRegister

procedure TkwPopWordLeftWordRefValuesCount.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� LeftWordRefValuesCount', aCtx);
end;//TkwPopWordLeftWordRefValuesCount.SetValuePrim

function TkwPopWordLeftWordRefValuesCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwPopWordLeftWordRefValuesCount.GetResultTypeInfo

function TkwPopWordLeftWordRefValuesCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordLeftWordRefValuesCount.GetAllParamsCount

function TkwPopWordLeftWordRefValuesCount.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordLeftWordRefValuesCount.ParamsTypes

type
 TkwPopWordName = {final scriptword} class(TtfwPropertyLike)
  {* ����� ������� pop:Word:Name
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aWord pop:Word:Name >>> l_Il3CString
[code]  }
 private
 // private methods
   function Name(const aCtx: TtfwContext;
    aWord: TtfwWord): Il3CString;
     {* ���������� ����� ������� pop:Word:Name }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordName

// start class TkwPopWordName

function TkwPopWordName.Name(const aCtx: TtfwContext;
  aWord: TtfwWord): Il3CString;
//#UC START# *88F83475097B_F6AEFC7115C2_var*
//#UC END# *88F83475097B_F6AEFC7115C2_var*
begin
//#UC START# *88F83475097B_F6AEFC7115C2_impl*
 if (aWord = nil) then
  Result := TtfwCStringFactory.C('??? Unexisting word ???')
 else
  Result := aWord.WordName;
//#UC END# *88F83475097B_F6AEFC7115C2_impl*
end;//TkwPopWordName.Name

procedure TkwPopWordName.DoDoIt(const aCtx: TtfwContext);
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
 aCtx.rEngine.PushString((Name(aCtx, l_aWord)));
end;//TkwPopWordName.DoDoIt

class function TkwPopWordName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:Name';
end;//TkwPopWordName.GetWordNameForRegister

procedure TkwPopWordName.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� Name', aCtx);
end;//TkwPopWordName.SetValuePrim

function TkwPopWordName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiString;
end;//TkwPopWordName.GetResultTypeInfo

function TkwPopWordName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordName.GetAllParamsCount

function TkwPopWordName.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordName.ParamsTypes

type
 TkwPopWordParent = {final scriptword} class(TtfwPropertyLike)
  {* ����� ������� pop:Word:Parent
*��� ����������:* TtfwWord
*������:*
[code]
OBJECT VAR l_TtfwWord
 aWord pop:Word:Parent >>> l_TtfwWord
[code]  }
 private
 // private methods
   function Parent(const aCtx: TtfwContext;
    aWord: TtfwWord): TtfwWord;
     {* ���������� ����� ������� pop:Word:Parent }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordParent

// start class TkwPopWordParent

function TkwPopWordParent.Parent(const aCtx: TtfwContext;
  aWord: TtfwWord): TtfwWord;
//#UC START# *D6565DAC49E7_5AA39503403C_var*
//#UC END# *D6565DAC49E7_5AA39503403C_var*
begin
//#UC START# *D6565DAC49E7_5AA39503403C_impl*
 Result := aWord.ParentWord;
//#UC END# *D6565DAC49E7_5AA39503403C_impl*
end;//TkwPopWordParent.Parent

procedure TkwPopWordParent.DoDoIt(const aCtx: TtfwContext);
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
 aCtx.rEngine.PushObj((Parent(aCtx, l_aWord)));
end;//TkwPopWordParent.DoDoIt

class function TkwPopWordParent.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:Parent';
end;//TkwPopWordParent.GetWordNameForRegister

procedure TkwPopWordParent.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� Parent', aCtx);
end;//TkwPopWordParent.SetValuePrim

function TkwPopWordParent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwWord);
end;//TkwPopWordParent.GetResultTypeInfo

function TkwPopWordParent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordParent.GetAllParamsCount

function TkwPopWordParent.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordParent.ParamsTypes

type
 TkwPopWordProducer = {final scriptword} class(TtfwPropertyLike)
  {* ����� ������� pop:Word:Producer
*��� ����������:* TtfwWord
*������:*
[code]
OBJECT VAR l_TtfwWord
 aWord pop:Word:Producer >>> l_TtfwWord
[code]  }
 private
 // private methods
   function Producer(const aCtx: TtfwContext;
    aWord: TtfwWord): TtfwWord;
     {* ���������� ����� ������� pop:Word:Producer }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordProducer

// start class TkwPopWordProducer

function TkwPopWordProducer.Producer(const aCtx: TtfwContext;
  aWord: TtfwWord): TtfwWord;
//#UC START# *8C360D05017B_2979371FE619_var*
//#UC END# *8C360D05017B_2979371FE619_var*
begin
//#UC START# *8C360D05017B_2979371FE619_impl*
 Result := aWord.WordProducer;
//#UC END# *8C360D05017B_2979371FE619_impl*
end;//TkwPopWordProducer.Producer

procedure TkwPopWordProducer.DoDoIt(const aCtx: TtfwContext);
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
 aCtx.rEngine.PushObj((Producer(aCtx, l_aWord)));
end;//TkwPopWordProducer.DoDoIt

class function TkwPopWordProducer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:Producer';
end;//TkwPopWordProducer.GetWordNameForRegister

procedure TkwPopWordProducer.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� Producer', aCtx);
end;//TkwPopWordProducer.SetValuePrim

function TkwPopWordProducer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwWord);
end;//TkwPopWordProducer.GetResultTypeInfo

function TkwPopWordProducer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordProducer.GetAllParamsCount

function TkwPopWordProducer.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordProducer.ParamsTypes

type
 TkwPopWordRedefines = {final scriptword} class(TtfwPropertyLike)
  {* ����� ������� pop:Word:Redefines
*��� ����������:* TtfwWord
*������:*
[code]
OBJECT VAR l_TtfwWord
 aWord pop:Word:Redefines >>> l_TtfwWord
[code]  }
 private
 // private methods
   function Redefines(const aCtx: TtfwContext;
    aWord: TtfwWord): TtfwWord;
     {* ���������� ����� ������� pop:Word:Redefines }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordRedefines

// start class TkwPopWordRedefines

function TkwPopWordRedefines.Redefines(const aCtx: TtfwContext;
  aWord: TtfwWord): TtfwWord;
 {-}
begin
 Result := aWord.Redefines;
end;//TkwPopWordRedefines.Redefines

procedure TkwPopWordRedefines.DoDoIt(const aCtx: TtfwContext);
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
 aCtx.rEngine.PushObj((Redefines(aCtx, l_aWord)));
end;//TkwPopWordRedefines.DoDoIt

class function TkwPopWordRedefines.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Word:Redefines';
end;//TkwPopWordRedefines.GetWordNameForRegister

procedure TkwPopWordRedefines.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� Redefines', aCtx);
end;//TkwPopWordRedefines.SetValuePrim

function TkwPopWordRedefines.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwWord);
end;//TkwPopWordRedefines.GetResultTypeInfo

function TkwPopWordRedefines.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordRedefines.GetAllParamsCount

function TkwPopWordRedefines.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordRedefines.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� ������������ �����������
 TWordsRTTIPackResNameGetter.Register;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_GetLeftWordRefValue
 TkwPopWordGetLeftWordRefValue.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_GetParam
 TkwPopWordGetParam.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_PublicateInMainDictionary
 TkwPopWordPublicateInMainDictionary.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_SetProducer
 TkwPopWordSetProducer.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_FindMember
 TkwPopWordFindMember.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_GetRef
 TkwPopWordGetRef.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_SourcePointString
 TkwPopWordSourcePointString.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_IsVarLike
 TkwPopWordIsVarLike.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_IsInParam
 TkwPopWordIsInParam.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_SetValue
 TkwPopWordSetValue.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_Info
 TkwPopWordInfo.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_IsForHelp
 TkwPopWordIsForHelp.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_IsImmediate
 TkwPopWordIsImmediate.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_IncRef
 TkwPopWordIncRef.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_DecRef
 TkwPopWordDecRef.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_MembersIterator
 TkwPopWordMembersIterator.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_InnerDictionary
 TkwPopWordInnerDictionary.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_CodeIterator
 TkwPopWordCodeIterator.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_SetValuePrim
 TkwPopWordSetValuePrim.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_KeyWord
 TkwPopWordKeyWord.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_Directives
 TkwPopWordDirectives.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_EndBracket
 TkwPopWordEndBracket.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_LeftWordRefValuesCount
 TkwPopWordLeftWordRefValuesCount.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_Name
 TkwPopWordName.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_Parent
 TkwPopWordParent.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_Producer
 TkwPopWordProducer.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Word_Redefines
 TkwPopWordRedefines.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
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
// ����������� ���� Il3CString
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwKeyWord
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeyWord));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� String
 TtfwTypeRegistrator.RegisterType(TypeInfo(AnsiString));
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
// ����������� ���� TtfwWordInfo
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWordInfo));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� ItfwValueList
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwValueList));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwDictionary
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwDictionary));
{$IfEnd} //not NoScripts

end.