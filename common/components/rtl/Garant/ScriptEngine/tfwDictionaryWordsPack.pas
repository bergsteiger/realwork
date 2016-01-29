unit tfwDictionaryWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Axiomatics"
// ������: "tfwDictionaryWordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine$Axiomatics::Basics::tfwDictionaryWordsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  l3Interfaces,
  tfwDictionary,
  tfwScriptingInterfaces,
  tfwClassLike
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  tfwMembersIterator,
  tfwScriptEngineExInterfaces,
  tfwKeywordsIterator,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwPopDictionaryWordsIterator = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Dictionary:WordsIterator
*��� ����������:* ItfwValueList
*������:*
[code]
ARRAY VAR l_ItfwValueList
 aDictionary pop:Dictionary:WordsIterator >>> l_ItfwValueList
[code]  }
 private
 // private methods
   function WordsIterator(const aCtx: TtfwContext;
    aDictionary: TtfwDictionary): ItfwValueList;
     {* ���������� ����� ������� pop:Dictionary:WordsIterator }
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
 end;//TkwPopDictionaryWordsIterator

// start class TkwPopDictionaryWordsIterator

function TkwPopDictionaryWordsIterator.WordsIterator(const aCtx: TtfwContext;
  aDictionary: TtfwDictionary): ItfwValueList;
//#UC START# *FD92525AFBF3_D1DB0CBA0A4E_var*
//#UC END# *FD92525AFBF3_D1DB0CBA0A4E_var*
begin
//#UC START# *FD92525AFBF3_D1DB0CBA0A4E_impl*
 Result := TtfwMembersIterator.Make(aDictionary); 
//#UC END# *FD92525AFBF3_D1DB0CBA0A4E_impl*
end;//TkwPopDictionaryWordsIterator.WordsIterator

procedure TkwPopDictionaryWordsIterator.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aDictionary : TtfwDictionary;
begin
 try
  l_aDictionary := TtfwDictionary(aCtx.rEngine.PopObjAs(TtfwDictionary));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDictionary: TtfwDictionary : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushList((WordsIterator(aCtx, l_aDictionary)));
end;//TkwPopDictionaryWordsIterator.DoDoIt

class function TkwPopDictionaryWordsIterator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Dictionary:WordsIterator';
end;//TkwPopDictionaryWordsIterator.GetWordNameForRegister

function TkwPopDictionaryWordsIterator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwPopDictionaryWordsIterator.GetResultTypeInfo

function TkwPopDictionaryWordsIterator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopDictionaryWordsIterator.GetAllParamsCount

function TkwPopDictionaryWordsIterator.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwDictionary)]);
end;//TkwPopDictionaryWordsIterator.ParamsTypes

type
 TkwPopDictionaryKeywordByName = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Dictionary:KeywordByName
*��� ����������:* TtfwKeyWord
*������:*
[code]
OBJECT VAR l_TtfwKeyWord
 aName aDictionary pop:Dictionary:KeywordByName >>> l_TtfwKeyWord
[code]  }
 private
 // private methods
   function KeywordByName(const aCtx: TtfwContext;
    aDictionary: TtfwDictionary;
    const aName: Il3CString): TtfwKeyWord;
     {* ���������� ����� ������� pop:Dictionary:KeywordByName }
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
 end;//TkwPopDictionaryKeywordByName

// start class TkwPopDictionaryKeywordByName

function TkwPopDictionaryKeywordByName.KeywordByName(const aCtx: TtfwContext;
  aDictionary: TtfwDictionary;
  const aName: Il3CString): TtfwKeyWord;
//#UC START# *76C176260330_9E811BEE054C_var*
//#UC END# *76C176260330_9E811BEE054C_var*
begin
//#UC START# *76C176260330_9E811BEE054C_impl*
 Result := aDictionary.DRbyCName[aName];
//#UC END# *76C176260330_9E811BEE054C_impl*
end;//TkwPopDictionaryKeywordByName.KeywordByName

procedure TkwPopDictionaryKeywordByName.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aDictionary : TtfwDictionary;
 l_aName : Il3CString;
begin
 try
  l_aDictionary := TtfwDictionary(aCtx.rEngine.PopObjAs(TtfwDictionary));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDictionary: TtfwDictionary : ' + E.Message, aCtx);
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
 aCtx.rEngine.PushObj((KeywordByName(aCtx, l_aDictionary, l_aName)));
end;//TkwPopDictionaryKeywordByName.DoDoIt

class function TkwPopDictionaryKeywordByName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Dictionary:KeywordByName';
end;//TkwPopDictionaryKeywordByName.GetWordNameForRegister

function TkwPopDictionaryKeywordByName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwKeyWord);
end;//TkwPopDictionaryKeywordByName.GetResultTypeInfo

function TkwPopDictionaryKeywordByName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopDictionaryKeywordByName.GetAllParamsCount

function TkwPopDictionaryKeywordByName.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwDictionary), @tfw_tiString]);
end;//TkwPopDictionaryKeywordByName.ParamsTypes

type
 TkwPopDictionaryKeyWordsIterator = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Dictionary:KeyWordsIterator
*��� ����������:* ItfwValueList
*������:*
[code]
ARRAY VAR l_ItfwValueList
 aDictionary pop:Dictionary:KeyWordsIterator >>> l_ItfwValueList
[code]  }
 private
 // private methods
   function KeyWordsIterator(const aCtx: TtfwContext;
    aDictionary: TtfwDictionary): ItfwValueList;
     {* ���������� ����� ������� pop:Dictionary:KeyWordsIterator }
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
 end;//TkwPopDictionaryKeyWordsIterator

// start class TkwPopDictionaryKeyWordsIterator

function TkwPopDictionaryKeyWordsIterator.KeyWordsIterator(const aCtx: TtfwContext;
  aDictionary: TtfwDictionary): ItfwValueList;
//#UC START# *96DE91D549EC_7A25B6D5DC06_var*
//#UC END# *96DE91D549EC_7A25B6D5DC06_var*
begin
//#UC START# *96DE91D549EC_7A25B6D5DC06_impl*
 Result := TtfwKeywordsIterator.Make(aDictionary);
//#UC END# *96DE91D549EC_7A25B6D5DC06_impl*
end;//TkwPopDictionaryKeyWordsIterator.KeyWordsIterator

procedure TkwPopDictionaryKeyWordsIterator.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aDictionary : TtfwDictionary;
begin
 try
  l_aDictionary := TtfwDictionary(aCtx.rEngine.PopObjAs(TtfwDictionary));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDictionary: TtfwDictionary : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushList((KeyWordsIterator(aCtx, l_aDictionary)));
end;//TkwPopDictionaryKeyWordsIterator.DoDoIt

class function TkwPopDictionaryKeyWordsIterator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Dictionary:KeyWordsIterator';
end;//TkwPopDictionaryKeyWordsIterator.GetWordNameForRegister

function TkwPopDictionaryKeyWordsIterator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwPopDictionaryKeyWordsIterator.GetResultTypeInfo

function TkwPopDictionaryKeyWordsIterator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopDictionaryKeyWordsIterator.GetAllParamsCount

function TkwPopDictionaryKeyWordsIterator.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwDictionary)]);
end;//TkwPopDictionaryKeyWordsIterator.ParamsTypes

type
 TkwPopDictionaryOwnKeywordByName = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Dictionary:OwnKeywordByName
*��� ����������:* TtfwKeyWord
*������:*
[code]
OBJECT VAR l_TtfwKeyWord
 aName aDictionary pop:Dictionary:OwnKeywordByName >>> l_TtfwKeyWord
[code]  }
 private
 // private methods
   function OwnKeywordByName(const aCtx: TtfwContext;
    aDictionary: TtfwDictionary;
    const aName: Il3CString): TtfwKeyWord;
     {* ���������� ����� ������� pop:Dictionary:OwnKeywordByName }
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
 end;//TkwPopDictionaryOwnKeywordByName

// start class TkwPopDictionaryOwnKeywordByName

function TkwPopDictionaryOwnKeywordByName.OwnKeywordByName(const aCtx: TtfwContext;
  aDictionary: TtfwDictionary;
  const aName: Il3CString): TtfwKeyWord;
//#UC START# *A9DAF1057D09_5D0B14C07C4C_var*
//#UC END# *A9DAF1057D09_5D0B14C07C4C_var*
begin
//#UC START# *A9DAF1057D09_5D0B14C07C4C_impl*
 Result := aDictionary.OwnDRbyCName(aName);
//#UC END# *A9DAF1057D09_5D0B14C07C4C_impl*
end;//TkwPopDictionaryOwnKeywordByName.OwnKeywordByName

procedure TkwPopDictionaryOwnKeywordByName.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aDictionary : TtfwDictionary;
 l_aName : Il3CString;
begin
 try
  l_aDictionary := TtfwDictionary(aCtx.rEngine.PopObjAs(TtfwDictionary));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDictionary: TtfwDictionary : ' + E.Message, aCtx);
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
 aCtx.rEngine.PushObj((OwnKeywordByName(aCtx, l_aDictionary, l_aName)));
end;//TkwPopDictionaryOwnKeywordByName.DoDoIt

class function TkwPopDictionaryOwnKeywordByName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Dictionary:OwnKeywordByName';
end;//TkwPopDictionaryOwnKeywordByName.GetWordNameForRegister

function TkwPopDictionaryOwnKeywordByName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwKeyWord);
end;//TkwPopDictionaryOwnKeywordByName.GetResultTypeInfo

function TkwPopDictionaryOwnKeywordByName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopDictionaryOwnKeywordByName.GetAllParamsCount

function TkwPopDictionaryOwnKeywordByName.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwDictionary), @tfw_tiString]);
end;//TkwPopDictionaryOwnKeywordByName.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� pop_Dictionary_WordsIterator
 TkwPopDictionaryWordsIterator.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Dictionary_KeywordByName
 TkwPopDictionaryKeywordByName.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Dictionary_KeyWordsIterator
 TkwPopDictionaryKeyWordsIterator.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Dictionary_OwnKeywordByName
 TkwPopDictionaryOwnKeywordByName.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwDictionary
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwDictionary));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� ItfwValueList
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwValueList));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Il3CString
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwKeyWord
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeyWord));
{$IfEnd} //not NoScripts

end.