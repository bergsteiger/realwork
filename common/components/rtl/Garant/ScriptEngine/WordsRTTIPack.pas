unit WordsRTTIPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\WordsRTTIPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "WordsRTTIPack" MUID: (550C25D70182)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3Interfaces
 , tfwScriptingInterfaces
 , l3CProtoObject
;

type
 ItfwWordBox = interface
  ['{16F9981D-A4AE-47B8-940F-7ED27AF34B87}']
  function Get_Boxed: TtfwWord;
  property Boxed: TtfwWord
   read Get_Boxed;
 end;//ItfwWordBox

 TtfwWordBox = class(Tl3CProtoObject, ItfwWordBox)
  private
   f_Boxed: TtfwWord;
  protected
   function Get_Boxed: TtfwWord;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aWord: TtfwWord); reintroduce;
   class function Make(aWord: TtfwWord): ItfwWordBox; reintroduce;
 end;//TtfwWordBox
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwClassLike
 , TypInfo
 , tfwDictionary
 , tfwPropertyLike
 , tfwTypeInfo
 , tfwAxiomaticsResNameGetter
 , seWordsInfo
 , tfwMembersIterator
 , kwForwardDeclaration
 , tfwCodeIterator
 , kwCompiledWordPrim
 , kwCompiledWordContainer
 , kwDualCompiledWordContainer
 , kwRuntimeWordWithCode
 , kwForwardDeclarationHolder
 , kwCompiledWordWorker
 , tfwWordRefList
 , tfwScriptEngineExInterfaces
 , kwCompiledWordWorkerWordRunner
 , kwCompiledWordWorkerWord
 , kwCompiledIfElse
 , SysUtils
 , tfwWordBoxPack
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopWordGetLeftWordRefValue = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:GetLeftWordRefValue }
  private
   function GetLeftWordRefValue(const aCtx: TtfwContext;
    aWord: TtfwWord;
    anIndex: Integer): TtfwWord;
    {* Реализация слова скрипта pop:Word:GetLeftWordRefValue }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordGetLeftWordRefValue

 TkwPopWordGetParam = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:GetParam }
  private
   function GetParam(const aCtx: TtfwContext;
    aWord: TtfwWord;
    anIndex: Integer): TtfwWord;
    {* Реализация слова скрипта pop:Word:GetParam }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordGetParam

 TkwPopWordSetProducer = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:SetProducer }
  private
   procedure SetProducer(const aCtx: TtfwContext;
    aWord: TtfwWord;
    aProducer: TtfwWord);
    {* Реализация слова скрипта pop:Word:SetProducer }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordSetProducer

 TkwPopWordFindMember = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:FindMember }
  private
   function FindMember(const aCtx: TtfwContext;
    aWord: TtfwWord;
    const aName: Il3CString): TtfwKeyWord;
    {* Реализация слова скрипта pop:Word:FindMember }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordFindMember

 TkwPopWordGetRef = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:GetRef }
  private
   function GetRef(const aCtx: TtfwContext;
    aWord: TtfwWord): TtfwWord;
    {* Реализация слова скрипта pop:Word:GetRef }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordGetRef

 TkwPopWordSourcePointString = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:SourcePointString }
  private
   function SourcePointString(const aCtx: TtfwContext;
    aWord: TtfwWord): AnsiString;
    {* Реализация слова скрипта pop:Word:SourcePointString }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordSourcePointString

 TkwPopWordIsVarLike = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:IsVarLike }
  private
   function IsVarLike(const aCtx: TtfwContext;
    aWord: TtfwWord): Boolean;
    {* Реализация слова скрипта pop:Word:IsVarLike }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordIsVarLike

 TkwPopWordIsInParam = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:IsInParam }
  private
   function IsInParam(const aCtx: TtfwContext;
    aWord: TtfwWord): Boolean;
    {* Реализация слова скрипта pop:Word:IsInParam }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordIsInParam

 TkwPopWordSetValue = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:SetValue }
  private
   procedure SetValue(const aCtx: TtfwContext;
    aWord: TtfwWord;
    const aValue: TtfwStackValue);
    {* Реализация слова скрипта pop:Word:SetValue }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordSetValue

 TkwPopWordInfo = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:Info }
  private
   function Info(const aCtx: TtfwContext;
    aWord: TtfwWord): TtfwWordInfo;
    {* Реализация слова скрипта pop:Word:Info }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfo

 TkwPopWordIsForHelp = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:IsForHelp }
  private
   function IsForHelp(const aCtx: TtfwContext;
    aWord: TtfwWord): Boolean;
    {* Реализация слова скрипта pop:Word:IsForHelp }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordIsForHelp

 TkwPopWordIsImmediate = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:IsImmediate }
  private
   function IsImmediate(const aCtx: TtfwContext;
    aWord: TtfwWord): Boolean;
    {* Реализация слова скрипта pop:Word:IsImmediate }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordIsImmediate

 TkwPopWordIncRef = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:IncRef }
  private
   procedure IncRef(const aCtx: TtfwContext;
    aWord: TtfwWord);
    {* Реализация слова скрипта pop:Word:IncRef }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordIncRef

 TkwPopWordDecRef = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:DecRef }
  private
   procedure DecRef(const aCtx: TtfwContext;
    aWord: TtfwWord);
    {* Реализация слова скрипта pop:Word:DecRef }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordDecRef

 TkwPopWordMembersIterator = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:MembersIterator }
  private
   function MembersIterator(const aCtx: TtfwContext;
    aWord: TtfwWord): ItfwValueList;
    {* Реализация слова скрипта pop:Word:MembersIterator }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordMembersIterator

 TkwPopWordInnerDictionary = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:InnerDictionary }
  private
   function InnerDictionary(const aCtx: TtfwContext;
    aWord: TtfwWord): TtfwDictionary;
    {* Реализация слова скрипта pop:Word:InnerDictionary }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInnerDictionary

 TkwPopWordCodeIterator = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:CodeIterator }
  private
   function CodeIterator(const aCtx: TtfwContext;
    aWord: TtfwWord): ItfwValueList;
    {* Реализация слова скрипта pop:Word:CodeIterator }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordCodeIterator

 TkwPopWordSetValuePrim = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:SetValuePrim }
  private
   procedure SetValuePrim(const aCtx: TtfwContext;
    aWord: TtfwWord;
    const aValue: TtfwStackValue);
    {* Реализация слова скрипта pop:Word:SetValuePrim }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordSetValuePrim

 TkwPopWordKeyWord = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:KeyWord }
  private
   function KeyWord(const aCtx: TtfwContext;
    aWord: TtfwWord): TtfwKeyWord;
    {* Реализация слова скрипта pop:Word:KeyWord }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordKeyWord

 TkwPopWordSetParent = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:SetParent }
  private
   procedure SetParent(const aCtx: TtfwContext;
    aWord: TtfwWord;
    aParent: TtfwWord);
    {* Реализация слова скрипта pop:Word:SetParent }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordSetParent

 TkwPopWordSetKey = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:SetKey }
  private
   procedure SetKey(const aCtx: TtfwContext;
    aWord: TtfwWord;
    aKey: TtfwKeyWord);
    {* Реализация слова скрипта pop:Word:SetKey }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordSetKey

 TkwPopWordBox = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:Box }
  private
   function Box(const aCtx: TtfwContext;
    aWord: TtfwWord): ItfwWordBox;
    {* Реализация слова скрипта pop:Word:Box }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordBox

 TkwPopWordGetRefForCompare = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:GetRefForCompare }
  private
   function GetRefForCompare(const aCtx: TtfwContext;
    aWord: TtfwWord): TtfwWord;
    {* Реализация слова скрипта pop:Word:GetRefForCompare }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordGetRefForCompare

 TkwPopWordDirectives = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Word:Directives }
  private
   function Directives(const aCtx: TtfwContext;
    aWord: TtfwWord): Il3CString;
    {* Реализация слова скрипта pop:Word:Directives }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopWordDirectives

 TkwPopWordEndBracket = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Word:EndBracket }
  private
   function EndBracket(const aCtx: TtfwContext;
    aWord: TtfwWord): AnsiString;
    {* Реализация слова скрипта pop:Word:EndBracket }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopWordEndBracket

 TkwPopWordLeftWordRefValuesCount = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Word:LeftWordRefValuesCount }
  private
   function LeftWordRefValuesCount(const aCtx: TtfwContext;
    aWord: TtfwWord): Integer;
    {* Реализация слова скрипта pop:Word:LeftWordRefValuesCount }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopWordLeftWordRefValuesCount

 TkwPopWordName = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Word:Name }
  private
   function Name(const aCtx: TtfwContext;
    aWord: TtfwWord): Il3CString;
    {* Реализация слова скрипта pop:Word:Name }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopWordName

 TkwPopWordParent = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Word:Parent }
  private
   function Parent(const aCtx: TtfwContext;
    aWord: TtfwWord): TtfwWord;
    {* Реализация слова скрипта pop:Word:Parent }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopWordParent

 TkwPopWordProducer = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Word:Producer }
  private
   function Producer(const aCtx: TtfwContext;
    aWord: TtfwWord): TtfwWord;
    {* Реализация слова скрипта pop:Word:Producer }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopWordProducer

 TkwPopWordRedefines = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Word:Redefines }
  private
   function Redefines(const aCtx: TtfwContext;
    aWord: TtfwWord): TtfwWord;
    {* Реализация слова скрипта pop:Word:Redefines }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopWordRedefines

 TWordsRTTIPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TWordsRTTIPackResNameGetter

constructor TtfwWordBox.Create(aWord: TtfwWord);
//#UC START# *567A8DFB0357_567A8DB002B6_var*
//#UC END# *567A8DFB0357_567A8DB002B6_var*
begin
//#UC START# *567A8DFB0357_567A8DB002B6_impl*
 inherited Create;
 aWord.SetrefTo(f_Boxed);
//#UC END# *567A8DFB0357_567A8DB002B6_impl*
end;//TtfwWordBox.Create

class function TtfwWordBox.Make(aWord: TtfwWord): ItfwWordBox;
var
 l_Inst : TtfwWordBox;
begin
 l_Inst := Create(aWord);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TtfwWordBox.Make

function TtfwWordBox.Get_Boxed: TtfwWord;
//#UC START# *567A8D840243_567A8DB002B6get_var*
//#UC END# *567A8D840243_567A8DB002B6get_var*
begin
//#UC START# *567A8D840243_567A8DB002B6get_impl*
 Result := f_Boxed;
//#UC END# *567A8D840243_567A8DB002B6get_impl*
end;//TtfwWordBox.Get_Boxed

procedure TtfwWordBox.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_567A8DB002B6_var*
//#UC END# *479731C50290_567A8DB002B6_var*
begin
//#UC START# *479731C50290_567A8DB002B6_impl*
 FreeAndNil(f_Boxed);
 inherited;
//#UC END# *479731C50290_567A8DB002B6_impl*
end;//TtfwWordBox.Cleanup

function TkwPopWordGetLeftWordRefValue.GetLeftWordRefValue(const aCtx: TtfwContext;
 aWord: TtfwWord;
 anIndex: Integer): TtfwWord;
 {* Реализация слова скрипта pop:Word:GetLeftWordRefValue }
//#UC START# *550C278901A4_550C278901A4_4DAEED140007_Word_var*
//#UC END# *550C278901A4_550C278901A4_4DAEED140007_Word_var*
begin
//#UC START# *550C278901A4_550C278901A4_4DAEED140007_Word_impl*
 Result := aWord.GetLeftWordRefValue(aCtx, anIndex);
//#UC END# *550C278901A4_550C278901A4_4DAEED140007_Word_impl*
end;//TkwPopWordGetLeftWordRefValue.GetLeftWordRefValue

class function TkwPopWordGetLeftWordRefValue.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:GetLeftWordRefValue';
end;//TkwPopWordGetLeftWordRefValue.GetWordNameForRegister

function TkwPopWordGetLeftWordRefValue.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwWord);
end;//TkwPopWordGetLeftWordRefValue.GetResultTypeInfo

function TkwPopWordGetLeftWordRefValue.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordGetLeftWordRefValue.GetAllParamsCount

function TkwPopWordGetLeftWordRefValue.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), TypeInfo(Integer)]);
end;//TkwPopWordGetLeftWordRefValue.ParamsTypes

procedure TkwPopWordGetLeftWordRefValue.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
var l_anIndex: Integer;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetLeftWordRefValue(aCtx, l_aWord, l_anIndex));
end;//TkwPopWordGetLeftWordRefValue.DoDoIt

function TkwPopWordGetParam.GetParam(const aCtx: TtfwContext;
 aWord: TtfwWord;
 anIndex: Integer): TtfwWord;
 {* Реализация слова скрипта pop:Word:GetParam }
//#UC START# *550C27BB0382_550C27BB0382_4DAEED140007_Word_var*
//#UC END# *550C27BB0382_550C27BB0382_4DAEED140007_Word_var*
begin
//#UC START# *550C27BB0382_550C27BB0382_4DAEED140007_Word_impl*
 Result := aWord.GetInParam(aCtx, anIndex);
//#UC END# *550C27BB0382_550C27BB0382_4DAEED140007_Word_impl*
end;//TkwPopWordGetParam.GetParam

class function TkwPopWordGetParam.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:GetParam';
end;//TkwPopWordGetParam.GetWordNameForRegister

function TkwPopWordGetParam.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwWord);
end;//TkwPopWordGetParam.GetResultTypeInfo

function TkwPopWordGetParam.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordGetParam.GetAllParamsCount

function TkwPopWordGetParam.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), TypeInfo(Integer)]);
end;//TkwPopWordGetParam.ParamsTypes

procedure TkwPopWordGetParam.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
var l_anIndex: Integer;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetParam(aCtx, l_aWord, l_anIndex));
end;//TkwPopWordGetParam.DoDoIt

procedure TkwPopWordSetProducer.SetProducer(const aCtx: TtfwContext;
 aWord: TtfwWord;
 aProducer: TtfwWord);
 {* Реализация слова скрипта pop:Word:SetProducer }
//#UC START# *558ABFC70287_558ABFC70287_4DAEED140007_Word_var*
//#UC END# *558ABFC70287_558ABFC70287_4DAEED140007_Word_var*
begin
//#UC START# *558ABFC70287_558ABFC70287_4DAEED140007_Word_impl*
 aWord.WordProducer := aProducer;
//#UC END# *558ABFC70287_558ABFC70287_4DAEED140007_Word_impl*
end;//TkwPopWordSetProducer.SetProducer

class function TkwPopWordSetProducer.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:SetProducer';
end;//TkwPopWordSetProducer.GetWordNameForRegister

function TkwPopWordSetProducer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopWordSetProducer.GetResultTypeInfo

function TkwPopWordSetProducer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordSetProducer.GetAllParamsCount

function TkwPopWordSetProducer.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), TypeInfo(TtfwWord)]);
end;//TkwPopWordSetProducer.ParamsTypes

procedure TkwPopWordSetProducer.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
var l_aProducer: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aProducer := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aProducer: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SetProducer(aCtx, l_aWord, l_aProducer);
end;//TkwPopWordSetProducer.DoDoIt

function TkwPopWordFindMember.FindMember(const aCtx: TtfwContext;
 aWord: TtfwWord;
 const aName: Il3CString): TtfwKeyWord;
 {* Реализация слова скрипта pop:Word:FindMember }
//#UC START# *558D53EF03DB_558D53EF03DB_4DAEED140007_Word_var*
//#UC END# *558D53EF03DB_558D53EF03DB_4DAEED140007_Word_var*
begin
//#UC START# *558D53EF03DB_558D53EF03DB_4DAEED140007_Word_impl*
 if (aWord.InnerDictionary <> nil) then
  Result := (aWord.InnerDictionary As TtfwDictionary).DRbyCName[aName]
 else
  Result := nil;
//#UC END# *558D53EF03DB_558D53EF03DB_4DAEED140007_Word_impl*
end;//TkwPopWordFindMember.FindMember

class function TkwPopWordFindMember.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:FindMember';
end;//TkwPopWordFindMember.GetWordNameForRegister

function TkwPopWordFindMember.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwKeyWord);
end;//TkwPopWordFindMember.GetResultTypeInfo

function TkwPopWordFindMember.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordFindMember.GetAllParamsCount

function TkwPopWordFindMember.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), @tfw_tiString]);
end;//TkwPopWordFindMember.ParamsTypes

procedure TkwPopWordFindMember.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
var l_aName: Il3CString;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FindMember(aCtx, l_aWord, l_aName));
end;//TkwPopWordFindMember.DoDoIt

function TkwPopWordGetRef.GetRef(const aCtx: TtfwContext;
 aWord: TtfwWord): TtfwWord;
 {* Реализация слова скрипта pop:Word:GetRef }
//#UC START# *558D76DE02E9_558D76DE02E9_4DAEED140007_Word_var*
//#UC END# *558D76DE02E9_558D76DE02E9_4DAEED140007_Word_var*
begin
//#UC START# *558D76DE02E9_558D76DE02E9_4DAEED140007_Word_impl*
 Result := aWord.GetRef(aCtx);
//#UC END# *558D76DE02E9_558D76DE02E9_4DAEED140007_Word_impl*
end;//TkwPopWordGetRef.GetRef

class function TkwPopWordGetRef.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:GetRef';
end;//TkwPopWordGetRef.GetWordNameForRegister

function TkwPopWordGetRef.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwWord);
end;//TkwPopWordGetRef.GetResultTypeInfo

function TkwPopWordGetRef.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordGetRef.GetAllParamsCount

function TkwPopWordGetRef.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordGetRef.ParamsTypes

procedure TkwPopWordGetRef.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetRef(aCtx, l_aWord));
end;//TkwPopWordGetRef.DoDoIt

function TkwPopWordSourcePointString.SourcePointString(const aCtx: TtfwContext;
 aWord: TtfwWord): AnsiString;
 {* Реализация слова скрипта pop:Word:SourcePointString }
//#UC START# *559BDE5C03AB_559BDE5C03AB_4DAEED140007_Word_var*
//#UC END# *559BDE5C03AB_559BDE5C03AB_4DAEED140007_Word_var*
begin
//#UC START# *559BDE5C03AB_559BDE5C03AB_4DAEED140007_Word_impl*
 Result := aWord.SourcePoint.ToString;
//#UC END# *559BDE5C03AB_559BDE5C03AB_4DAEED140007_Word_impl*
end;//TkwPopWordSourcePointString.SourcePointString

class function TkwPopWordSourcePointString.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:SourcePointString';
end;//TkwPopWordSourcePointString.GetWordNameForRegister

function TkwPopWordSourcePointString.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopWordSourcePointString.GetResultTypeInfo

function TkwPopWordSourcePointString.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordSourcePointString.GetAllParamsCount

function TkwPopWordSourcePointString.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordSourcePointString.ParamsTypes

procedure TkwPopWordSourcePointString.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(SourcePointString(aCtx, l_aWord));
end;//TkwPopWordSourcePointString.DoDoIt

function TkwPopWordIsVarLike.IsVarLike(const aCtx: TtfwContext;
 aWord: TtfwWord): Boolean;
 {* Реализация слова скрипта pop:Word:IsVarLike }
//#UC START# *559D45FC0043_559D45FC0043_4DAEED140007_Word_var*
//#UC END# *559D45FC0043_559D45FC0043_4DAEED140007_Word_var*
begin
//#UC START# *559D45FC0043_559D45FC0043_4DAEED140007_Word_impl*
 Result := aWord.IsVarLike;
//#UC END# *559D45FC0043_559D45FC0043_4DAEED140007_Word_impl*
end;//TkwPopWordIsVarLike.IsVarLike

class function TkwPopWordIsVarLike.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:IsVarLike';
end;//TkwPopWordIsVarLike.GetWordNameForRegister

function TkwPopWordIsVarLike.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopWordIsVarLike.GetResultTypeInfo

function TkwPopWordIsVarLike.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordIsVarLike.GetAllParamsCount

function TkwPopWordIsVarLike.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordIsVarLike.ParamsTypes

procedure TkwPopWordIsVarLike.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsVarLike(aCtx, l_aWord));
end;//TkwPopWordIsVarLike.DoDoIt

function TkwPopWordIsInParam.IsInParam(const aCtx: TtfwContext;
 aWord: TtfwWord): Boolean;
 {* Реализация слова скрипта pop:Word:IsInParam }
//#UC START# *559D46110368_559D46110368_4DAEED140007_Word_var*
//#UC END# *559D46110368_559D46110368_4DAEED140007_Word_var*
begin
//#UC START# *559D46110368_559D46110368_4DAEED140007_Word_impl*
 Result := aWord.IsInParam;
//#UC END# *559D46110368_559D46110368_4DAEED140007_Word_impl*
end;//TkwPopWordIsInParam.IsInParam

class function TkwPopWordIsInParam.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:IsInParam';
end;//TkwPopWordIsInParam.GetWordNameForRegister

function TkwPopWordIsInParam.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopWordIsInParam.GetResultTypeInfo

function TkwPopWordIsInParam.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordIsInParam.GetAllParamsCount

function TkwPopWordIsInParam.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordIsInParam.ParamsTypes

procedure TkwPopWordIsInParam.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsInParam(aCtx, l_aWord));
end;//TkwPopWordIsInParam.DoDoIt

procedure TkwPopWordSetValue.SetValue(const aCtx: TtfwContext;
 aWord: TtfwWord;
 const aValue: TtfwStackValue);
 {* Реализация слова скрипта pop:Word:SetValue }
//#UC START# *55C2043A0132_55C2043A0132_4DAEED140007_Word_var*
//#UC END# *55C2043A0132_55C2043A0132_4DAEED140007_Word_var*
begin
//#UC START# *55C2043A0132_55C2043A0132_4DAEED140007_Word_impl*
 aWord.SetValue(aValue, aCtx);
//#UC END# *55C2043A0132_55C2043A0132_4DAEED140007_Word_impl*
end;//TkwPopWordSetValue.SetValue

class function TkwPopWordSetValue.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:SetValue';
end;//TkwPopWordSetValue.GetWordNameForRegister

function TkwPopWordSetValue.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopWordSetValue.GetResultTypeInfo

function TkwPopWordSetValue.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordSetValue.GetAllParamsCount

function TkwPopWordSetValue.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), @tfw_tiStruct]);
end;//TkwPopWordSetValue.ParamsTypes

procedure TkwPopWordSetValue.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
var l_aValue: TtfwStackValue;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SetValue(aCtx, l_aWord, l_aValue);
end;//TkwPopWordSetValue.DoDoIt

function TkwPopWordInfo.Info(const aCtx: TtfwContext;
 aWord: TtfwWord): TtfwWordInfo;
 {* Реализация слова скрипта pop:Word:Info }
//#UC START# *55C385720214_55C385720214_4DAEED140007_Word_var*
//#UC END# *55C385720214_55C385720214_4DAEED140007_Word_var*
begin
//#UC START# *55C385720214_55C385720214_4DAEED140007_Word_impl*
 Result := aWord.ResultTypeInfo[aCtx];
//#UC END# *55C385720214_55C385720214_4DAEED140007_Word_impl*
end;//TkwPopWordInfo.Info

class function TkwPopWordInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:Info';
end;//TkwPopWordInfo.GetWordNameForRegister

function TkwPopWordInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwWordInfo);
end;//TkwPopWordInfo.GetResultTypeInfo

function TkwPopWordInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordInfo.GetAllParamsCount

function TkwPopWordInfo.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordInfo.ParamsTypes

procedure TkwPopWordInfo.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Info(aCtx, l_aWord));
end;//TkwPopWordInfo.DoDoIt

function TkwPopWordIsForHelp.IsForHelp(const aCtx: TtfwContext;
 aWord: TtfwWord): Boolean;
 {* Реализация слова скрипта pop:Word:IsForHelp }
begin
 Result := aWord.IsForHelp;
end;//TkwPopWordIsForHelp.IsForHelp

class function TkwPopWordIsForHelp.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:IsForHelp';
end;//TkwPopWordIsForHelp.GetWordNameForRegister

function TkwPopWordIsForHelp.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopWordIsForHelp.GetResultTypeInfo

function TkwPopWordIsForHelp.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordIsForHelp.GetAllParamsCount

function TkwPopWordIsForHelp.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordIsForHelp.ParamsTypes

procedure TkwPopWordIsForHelp.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsForHelp(aCtx, l_aWord));
end;//TkwPopWordIsForHelp.DoDoIt

function TkwPopWordIsImmediate.IsImmediate(const aCtx: TtfwContext;
 aWord: TtfwWord): Boolean;
 {* Реализация слова скрипта pop:Word:IsImmediate }
//#UC START# *55CDED9E02BF_55CDED9E02BF_4DAEED140007_Word_var*
//#UC END# *55CDED9E02BF_55CDED9E02BF_4DAEED140007_Word_var*
begin
//#UC START# *55CDED9E02BF_55CDED9E02BF_4DAEED140007_Word_impl*
 Result := aWord.IsImmediate(aCtx);
//#UC END# *55CDED9E02BF_55CDED9E02BF_4DAEED140007_Word_impl*
end;//TkwPopWordIsImmediate.IsImmediate

class function TkwPopWordIsImmediate.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:IsImmediate';
end;//TkwPopWordIsImmediate.GetWordNameForRegister

function TkwPopWordIsImmediate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopWordIsImmediate.GetResultTypeInfo

function TkwPopWordIsImmediate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordIsImmediate.GetAllParamsCount

function TkwPopWordIsImmediate.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordIsImmediate.ParamsTypes

procedure TkwPopWordIsImmediate.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsImmediate(aCtx, l_aWord));
end;//TkwPopWordIsImmediate.DoDoIt

procedure TkwPopWordIncRef.IncRef(const aCtx: TtfwContext;
 aWord: TtfwWord);
 {* Реализация слова скрипта pop:Word:IncRef }
//#UC START# *55E08D220146_55E08D220146_4DAEED140007_Word_var*
//#UC END# *55E08D220146_55E08D220146_4DAEED140007_Word_var*
begin
//#UC START# *55E08D220146_55E08D220146_4DAEED140007_Word_impl*
 aWord.Use;
//#UC END# *55E08D220146_55E08D220146_4DAEED140007_Word_impl*
end;//TkwPopWordIncRef.IncRef

class function TkwPopWordIncRef.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:IncRef';
end;//TkwPopWordIncRef.GetWordNameForRegister

function TkwPopWordIncRef.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopWordIncRef.GetResultTypeInfo

function TkwPopWordIncRef.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordIncRef.GetAllParamsCount

function TkwPopWordIncRef.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordIncRef.ParamsTypes

procedure TkwPopWordIncRef.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 IncRef(aCtx, l_aWord);
end;//TkwPopWordIncRef.DoDoIt

procedure TkwPopWordDecRef.DecRef(const aCtx: TtfwContext;
 aWord: TtfwWord);
 {* Реализация слова скрипта pop:Word:DecRef }
//#UC START# *55E08D570094_55E08D570094_4DAEED140007_Word_var*
//#UC END# *55E08D570094_55E08D570094_4DAEED140007_Word_var*
begin
//#UC START# *55E08D570094_55E08D570094_4DAEED140007_Word_impl*
 aWord.Free;
//#UC END# *55E08D570094_55E08D570094_4DAEED140007_Word_impl*
end;//TkwPopWordDecRef.DecRef

class function TkwPopWordDecRef.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:DecRef';
end;//TkwPopWordDecRef.GetWordNameForRegister

function TkwPopWordDecRef.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopWordDecRef.GetResultTypeInfo

function TkwPopWordDecRef.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordDecRef.GetAllParamsCount

function TkwPopWordDecRef.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordDecRef.ParamsTypes

procedure TkwPopWordDecRef.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 DecRef(aCtx, l_aWord);
end;//TkwPopWordDecRef.DoDoIt

function TkwPopWordMembersIterator.MembersIterator(const aCtx: TtfwContext;
 aWord: TtfwWord): ItfwValueList;
 {* Реализация слова скрипта pop:Word:MembersIterator }
//#UC START# *55E708220353_55E708220353_4DAEED140007_Word_var*
//#UC END# *55E708220353_55E708220353_4DAEED140007_Word_var*
begin
//#UC START# *55E708220353_55E708220353_4DAEED140007_Word_impl*
 if (aWord = nil) then
  Result := TtfwMembersIterator.Make(nil)
 else
 if (aWord Is TkwForwardDeclaration) then
  Result := TtfwMembersIterator.Make(TkwForwardDeclaration(aWord).RealWord.InnerDictionary)
 else
  Result := TtfwMembersIterator.Make(aWord.InnerDictionary);
//#UC END# *55E708220353_55E708220353_4DAEED140007_Word_impl*
end;//TkwPopWordMembersIterator.MembersIterator

class function TkwPopWordMembersIterator.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:MembersIterator';
end;//TkwPopWordMembersIterator.GetWordNameForRegister

function TkwPopWordMembersIterator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwPopWordMembersIterator.GetResultTypeInfo

function TkwPopWordMembersIterator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordMembersIterator.GetAllParamsCount

function TkwPopWordMembersIterator.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordMembersIterator.ParamsTypes

procedure TkwPopWordMembersIterator.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushList(MembersIterator(aCtx, l_aWord));
end;//TkwPopWordMembersIterator.DoDoIt

function TkwPopWordInnerDictionary.InnerDictionary(const aCtx: TtfwContext;
 aWord: TtfwWord): TtfwDictionary;
 {* Реализация слова скрипта pop:Word:InnerDictionary }
//#UC START# *55E727A202B7_55E727A202B7_4DAEED140007_Word_var*
//#UC END# *55E727A202B7_55E727A202B7_4DAEED140007_Word_var*
begin
//#UC START# *55E727A202B7_55E727A202B7_4DAEED140007_Word_impl*
 Result := aWord.InnerDictionary As TtfwDictionary;
//#UC END# *55E727A202B7_55E727A202B7_4DAEED140007_Word_impl*
end;//TkwPopWordInnerDictionary.InnerDictionary

class function TkwPopWordInnerDictionary.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:InnerDictionary';
end;//TkwPopWordInnerDictionary.GetWordNameForRegister

function TkwPopWordInnerDictionary.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwDictionary);
end;//TkwPopWordInnerDictionary.GetResultTypeInfo

function TkwPopWordInnerDictionary.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordInnerDictionary.GetAllParamsCount

function TkwPopWordInnerDictionary.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordInnerDictionary.ParamsTypes

procedure TkwPopWordInnerDictionary.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(InnerDictionary(aCtx, l_aWord));
end;//TkwPopWordInnerDictionary.DoDoIt

function TkwPopWordCodeIterator.CodeIterator(const aCtx: TtfwContext;
 aWord: TtfwWord): ItfwValueList;
 {* Реализация слова скрипта pop:Word:CodeIterator }
//#UC START# *55E8430C020E_55E8430C020E_4DAEED140007_Word_var*

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

//#UC END# *55E8430C020E_55E8430C020E_4DAEED140007_Word_var*
begin
//#UC START# *55E8430C020E_55E8430C020E_4DAEED140007_Word_impl*
 Result := DoWord(aWord);
//#UC END# *55E8430C020E_55E8430C020E_4DAEED140007_Word_impl*
end;//TkwPopWordCodeIterator.CodeIterator

class function TkwPopWordCodeIterator.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:CodeIterator';
end;//TkwPopWordCodeIterator.GetWordNameForRegister

function TkwPopWordCodeIterator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwPopWordCodeIterator.GetResultTypeInfo

function TkwPopWordCodeIterator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordCodeIterator.GetAllParamsCount

function TkwPopWordCodeIterator.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordCodeIterator.ParamsTypes

procedure TkwPopWordCodeIterator.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushList(CodeIterator(aCtx, l_aWord));
end;//TkwPopWordCodeIterator.DoDoIt

procedure TkwPopWordSetValuePrim.SetValuePrim(const aCtx: TtfwContext;
 aWord: TtfwWord;
 const aValue: TtfwStackValue);
 {* Реализация слова скрипта pop:Word:SetValuePrim }
//#UC START# *5609675401ED_5609675401ED_4DAEED140007_Word_var*
//#UC END# *5609675401ED_5609675401ED_4DAEED140007_Word_var*
begin
//#UC START# *5609675401ED_5609675401ED_4DAEED140007_Word_impl*
 aWord.SetValuePrim(aValue, aCtx);
//#UC END# *5609675401ED_5609675401ED_4DAEED140007_Word_impl*
end;//TkwPopWordSetValuePrim.SetValuePrim

class function TkwPopWordSetValuePrim.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:SetValuePrim';
end;//TkwPopWordSetValuePrim.GetWordNameForRegister

function TkwPopWordSetValuePrim.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopWordSetValuePrim.GetResultTypeInfo

function TkwPopWordSetValuePrim.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordSetValuePrim.GetAllParamsCount

function TkwPopWordSetValuePrim.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), @tfw_tiStruct]);
end;//TkwPopWordSetValuePrim.ParamsTypes

procedure TkwPopWordSetValuePrim.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
var l_aValue: TtfwStackValue;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SetValuePrim(aCtx, l_aWord, l_aValue);
end;//TkwPopWordSetValuePrim.DoDoIt

function TkwPopWordKeyWord.KeyWord(const aCtx: TtfwContext;
 aWord: TtfwWord): TtfwKeyWord;
 {* Реализация слова скрипта pop:Word:KeyWord }
//#UC START# *5613CB150380_5613CB150380_4DAEED140007_Word_var*
//#UC END# *5613CB150380_5613CB150380_4DAEED140007_Word_var*
begin
//#UC START# *5613CB150380_5613CB150380_4DAEED140007_Word_impl*
 Result := aWord.Key As TtfwKeyWord;
//#UC END# *5613CB150380_5613CB150380_4DAEED140007_Word_impl*
end;//TkwPopWordKeyWord.KeyWord

class function TkwPopWordKeyWord.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:KeyWord';
end;//TkwPopWordKeyWord.GetWordNameForRegister

function TkwPopWordKeyWord.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwKeyWord);
end;//TkwPopWordKeyWord.GetResultTypeInfo

function TkwPopWordKeyWord.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordKeyWord.GetAllParamsCount

function TkwPopWordKeyWord.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordKeyWord.ParamsTypes

procedure TkwPopWordKeyWord.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(KeyWord(aCtx, l_aWord));
end;//TkwPopWordKeyWord.DoDoIt

procedure TkwPopWordSetParent.SetParent(const aCtx: TtfwContext;
 aWord: TtfwWord;
 aParent: TtfwWord);
 {* Реализация слова скрипта pop:Word:SetParent }
//#UC START# *5673E6BA0364_5673E6BA0364_4DAEED140007_Word_var*
//#UC END# *5673E6BA0364_5673E6BA0364_4DAEED140007_Word_var*
begin
//#UC START# *5673E6BA0364_5673E6BA0364_4DAEED140007_Word_impl*
 aWord.SetParent(aParent);
//#UC END# *5673E6BA0364_5673E6BA0364_4DAEED140007_Word_impl*
end;//TkwPopWordSetParent.SetParent

class function TkwPopWordSetParent.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:SetParent';
end;//TkwPopWordSetParent.GetWordNameForRegister

function TkwPopWordSetParent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopWordSetParent.GetResultTypeInfo

function TkwPopWordSetParent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordSetParent.GetAllParamsCount

function TkwPopWordSetParent.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), TypeInfo(TtfwWord)]);
end;//TkwPopWordSetParent.ParamsTypes

procedure TkwPopWordSetParent.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
var l_aParent: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aParent := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aParent: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SetParent(aCtx, l_aWord, l_aParent);
end;//TkwPopWordSetParent.DoDoIt

procedure TkwPopWordSetKey.SetKey(const aCtx: TtfwContext;
 aWord: TtfwWord;
 aKey: TtfwKeyWord);
 {* Реализация слова скрипта pop:Word:SetKey }
//#UC START# *5673F2E60341_5673F2E60341_4DAEED140007_Word_var*
//#UC END# *5673F2E60341_5673F2E60341_4DAEED140007_Word_var*
begin
//#UC START# *5673F2E60341_5673F2E60341_4DAEED140007_Word_impl*
 aWord.Key := aKey;
//#UC END# *5673F2E60341_5673F2E60341_4DAEED140007_Word_impl*
end;//TkwPopWordSetKey.SetKey

class function TkwPopWordSetKey.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:SetKey';
end;//TkwPopWordSetKey.GetWordNameForRegister

function TkwPopWordSetKey.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopWordSetKey.GetResultTypeInfo

function TkwPopWordSetKey.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordSetKey.GetAllParamsCount

function TkwPopWordSetKey.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), TypeInfo(TtfwKeyWord)]);
end;//TkwPopWordSetKey.ParamsTypes

procedure TkwPopWordSetKey.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
var l_aKey: TtfwKeyWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aKey := TtfwKeyWord(aCtx.rEngine.PopObjAs(TtfwKeyWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aKey: TtfwKeyWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SetKey(aCtx, l_aWord, l_aKey);
end;//TkwPopWordSetKey.DoDoIt

function TkwPopWordBox.Box(const aCtx: TtfwContext;
 aWord: TtfwWord): ItfwWordBox;
 {* Реализация слова скрипта pop:Word:Box }
//#UC START# *567A8D980275_567A8D980275_4DAEED140007_Word_var*
//#UC END# *567A8D980275_567A8D980275_4DAEED140007_Word_var*
begin
//#UC START# *567A8D980275_567A8D980275_4DAEED140007_Word_impl*
 Result := TtfwWordBox.Make(aWord);
//#UC END# *567A8D980275_567A8D980275_4DAEED140007_Word_impl*
end;//TkwPopWordBox.Box

class function TkwPopWordBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:Box';
end;//TkwPopWordBox.GetWordNameForRegister

function TkwPopWordBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwWordBox);
end;//TkwPopWordBox.GetResultTypeInfo

function TkwPopWordBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordBox.GetAllParamsCount

function TkwPopWordBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordBox.ParamsTypes

procedure TkwPopWordBox.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf(Box(aCtx, l_aWord), TypeInfo(ItfwWordBox));
end;//TkwPopWordBox.DoDoIt

function TkwPopWordGetRefForCompare.GetRefForCompare(const aCtx: TtfwContext;
 aWord: TtfwWord): TtfwWord;
 {* Реализация слова скрипта pop:Word:GetRefForCompare }
//#UC START# *57500AC802FC_57500AC802FC_4DAEED140007_Word_var*
//#UC END# *57500AC802FC_57500AC802FC_4DAEED140007_Word_var*
begin
//#UC START# *57500AC802FC_57500AC802FC_4DAEED140007_Word_impl*
 !!! Needs to be implemented !!!
//#UC END# *57500AC802FC_57500AC802FC_4DAEED140007_Word_impl*
end;//TkwPopWordGetRefForCompare.GetRefForCompare

class function TkwPopWordGetRefForCompare.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:GetRefForCompare';
end;//TkwPopWordGetRefForCompare.GetWordNameForRegister

function TkwPopWordGetRefForCompare.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwWord);
end;//TkwPopWordGetRefForCompare.GetResultTypeInfo

function TkwPopWordGetRefForCompare.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordGetRefForCompare.GetAllParamsCount

function TkwPopWordGetRefForCompare.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordGetRefForCompare.ParamsTypes

procedure TkwPopWordGetRefForCompare.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetRefForCompare(aCtx, l_aWord));
end;//TkwPopWordGetRefForCompare.DoDoIt

function TkwPopWordDirectives.Directives(const aCtx: TtfwContext;
 aWord: TtfwWord): Il3CString;
 {* Реализация слова скрипта pop:Word:Directives }
//#UC START# *550C26A10073_550C26A10073_4DAEED140007_Word_var*
//#UC END# *550C26A10073_550C26A10073_4DAEED140007_Word_var*
begin
//#UC START# *550C26A10073_550C26A10073_4DAEED140007_Word_impl*
 !!! Needs to be implemented !!!
//#UC END# *550C26A10073_550C26A10073_4DAEED140007_Word_impl*
end;//TkwPopWordDirectives.Directives

class function TkwPopWordDirectives.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:Directives';
end;//TkwPopWordDirectives.GetWordNameForRegister

function TkwPopWordDirectives.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopWordDirectives.GetResultTypeInfo

function TkwPopWordDirectives.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordDirectives.GetAllParamsCount

function TkwPopWordDirectives.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordDirectives.ParamsTypes

procedure TkwPopWordDirectives.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Directives', aCtx);
end;//TkwPopWordDirectives.SetValuePrim

procedure TkwPopWordDirectives.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(Directives(aCtx, l_aWord));
end;//TkwPopWordDirectives.DoDoIt

function TkwPopWordEndBracket.EndBracket(const aCtx: TtfwContext;
 aWord: TtfwWord): AnsiString;
 {* Реализация слова скрипта pop:Word:EndBracket }
//#UC START# *550C274E00CA_550C274E00CA_4DAEED140007_Word_var*
//#UC END# *550C274E00CA_550C274E00CA_4DAEED140007_Word_var*
begin
//#UC START# *550C274E00CA_550C274E00CA_4DAEED140007_Word_impl*
 !!! Needs to be implemented !!!
//#UC END# *550C274E00CA_550C274E00CA_4DAEED140007_Word_impl*
end;//TkwPopWordEndBracket.EndBracket

class function TkwPopWordEndBracket.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:EndBracket';
end;//TkwPopWordEndBracket.GetWordNameForRegister

function TkwPopWordEndBracket.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopWordEndBracket.GetResultTypeInfo

function TkwPopWordEndBracket.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordEndBracket.GetAllParamsCount

function TkwPopWordEndBracket.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordEndBracket.ParamsTypes

procedure TkwPopWordEndBracket.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству EndBracket', aCtx);
end;//TkwPopWordEndBracket.SetValuePrim

procedure TkwPopWordEndBracket.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(EndBracket(aCtx, l_aWord));
end;//TkwPopWordEndBracket.DoDoIt

function TkwPopWordLeftWordRefValuesCount.LeftWordRefValuesCount(const aCtx: TtfwContext;
 aWord: TtfwWord): Integer;
 {* Реализация слова скрипта pop:Word:LeftWordRefValuesCount }
//#UC START# *550C27EA0141_550C27EA0141_4DAEED140007_Word_var*
//#UC END# *550C27EA0141_550C27EA0141_4DAEED140007_Word_var*
begin
//#UC START# *550C27EA0141_550C27EA0141_4DAEED140007_Word_impl*
 !!! Needs to be implemented !!!
//#UC END# *550C27EA0141_550C27EA0141_4DAEED140007_Word_impl*
end;//TkwPopWordLeftWordRefValuesCount.LeftWordRefValuesCount

class function TkwPopWordLeftWordRefValuesCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:LeftWordRefValuesCount';
end;//TkwPopWordLeftWordRefValuesCount.GetWordNameForRegister

function TkwPopWordLeftWordRefValuesCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopWordLeftWordRefValuesCount.GetResultTypeInfo

function TkwPopWordLeftWordRefValuesCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordLeftWordRefValuesCount.GetAllParamsCount

function TkwPopWordLeftWordRefValuesCount.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordLeftWordRefValuesCount.ParamsTypes

procedure TkwPopWordLeftWordRefValuesCount.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству LeftWordRefValuesCount', aCtx);
end;//TkwPopWordLeftWordRefValuesCount.SetValuePrim

procedure TkwPopWordLeftWordRefValuesCount.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(LeftWordRefValuesCount(aCtx, l_aWord));
end;//TkwPopWordLeftWordRefValuesCount.DoDoIt

function TkwPopWordName.Name(const aCtx: TtfwContext;
 aWord: TtfwWord): Il3CString;
 {* Реализация слова скрипта pop:Word:Name }
//#UC START# *550C28100270_550C28100270_4DAEED140007_Word_var*
//#UC END# *550C28100270_550C28100270_4DAEED140007_Word_var*
begin
//#UC START# *550C28100270_550C28100270_4DAEED140007_Word_impl*
 !!! Needs to be implemented !!!
//#UC END# *550C28100270_550C28100270_4DAEED140007_Word_impl*
end;//TkwPopWordName.Name

class function TkwPopWordName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:Name';
end;//TkwPopWordName.GetWordNameForRegister

function TkwPopWordName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopWordName.GetResultTypeInfo

function TkwPopWordName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordName.GetAllParamsCount

function TkwPopWordName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordName.ParamsTypes

procedure TkwPopWordName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Name', aCtx);
end;//TkwPopWordName.SetValuePrim

procedure TkwPopWordName.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(Name(aCtx, l_aWord));
end;//TkwPopWordName.DoDoIt

function TkwPopWordParent.Parent(const aCtx: TtfwContext;
 aWord: TtfwWord): TtfwWord;
 {* Реализация слова скрипта pop:Word:Parent }
//#UC START# *550C283B01A0_550C283B01A0_4DAEED140007_Word_var*
//#UC END# *550C283B01A0_550C283B01A0_4DAEED140007_Word_var*
begin
//#UC START# *550C283B01A0_550C283B01A0_4DAEED140007_Word_impl*
 !!! Needs to be implemented !!!
//#UC END# *550C283B01A0_550C283B01A0_4DAEED140007_Word_impl*
end;//TkwPopWordParent.Parent

class function TkwPopWordParent.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:Parent';
end;//TkwPopWordParent.GetWordNameForRegister

function TkwPopWordParent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwWord);
end;//TkwPopWordParent.GetResultTypeInfo

function TkwPopWordParent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordParent.GetAllParamsCount

function TkwPopWordParent.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordParent.ParamsTypes

procedure TkwPopWordParent.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Parent', aCtx);
end;//TkwPopWordParent.SetValuePrim

procedure TkwPopWordParent.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Parent(aCtx, l_aWord));
end;//TkwPopWordParent.DoDoIt

function TkwPopWordProducer.Producer(const aCtx: TtfwContext;
 aWord: TtfwWord): TtfwWord;
 {* Реализация слова скрипта pop:Word:Producer }
//#UC START# *550C286D0202_550C286D0202_4DAEED140007_Word_var*
//#UC END# *550C286D0202_550C286D0202_4DAEED140007_Word_var*
begin
//#UC START# *550C286D0202_550C286D0202_4DAEED140007_Word_impl*
 !!! Needs to be implemented !!!
//#UC END# *550C286D0202_550C286D0202_4DAEED140007_Word_impl*
end;//TkwPopWordProducer.Producer

class function TkwPopWordProducer.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:Producer';
end;//TkwPopWordProducer.GetWordNameForRegister

function TkwPopWordProducer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwWord);
end;//TkwPopWordProducer.GetResultTypeInfo

function TkwPopWordProducer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordProducer.GetAllParamsCount

function TkwPopWordProducer.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordProducer.ParamsTypes

procedure TkwPopWordProducer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Producer', aCtx);
end;//TkwPopWordProducer.SetValuePrim

procedure TkwPopWordProducer.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Producer(aCtx, l_aWord));
end;//TkwPopWordProducer.DoDoIt

function TkwPopWordRedefines.Redefines(const aCtx: TtfwContext;
 aWord: TtfwWord): TtfwWord;
 {* Реализация слова скрипта pop:Word:Redefines }
begin
 Result := aWord.Redefines;
end;//TkwPopWordRedefines.Redefines

class function TkwPopWordRedefines.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:Redefines';
end;//TkwPopWordRedefines.GetWordNameForRegister

function TkwPopWordRedefines.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwWord);
end;//TkwPopWordRedefines.GetResultTypeInfo

function TkwPopWordRedefines.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordRedefines.GetAllParamsCount

function TkwPopWordRedefines.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwPopWordRedefines.ParamsTypes

procedure TkwPopWordRedefines.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Redefines', aCtx);
end;//TkwPopWordRedefines.SetValuePrim

procedure TkwPopWordRedefines.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Redefines(aCtx, l_aWord));
end;//TkwPopWordRedefines.DoDoIt

class function TWordsRTTIPackResNameGetter.ResName: AnsiString;
begin
 Result := 'WordsRTTIPack';
end;//TWordsRTTIPackResNameGetter.ResName

{$R WordsRTTIPack.res}

initialization
 TkwPopWordGetLeftWordRefValue.RegisterInEngine;
 {* Регистрация pop_Word_GetLeftWordRefValue }
 TkwPopWordGetParam.RegisterInEngine;
 {* Регистрация pop_Word_GetParam }
 TkwPopWordSetProducer.RegisterInEngine;
 {* Регистрация pop_Word_SetProducer }
 TkwPopWordFindMember.RegisterInEngine;
 {* Регистрация pop_Word_FindMember }
 TkwPopWordGetRef.RegisterInEngine;
 {* Регистрация pop_Word_GetRef }
 TkwPopWordSourcePointString.RegisterInEngine;
 {* Регистрация pop_Word_SourcePointString }
 TkwPopWordIsVarLike.RegisterInEngine;
 {* Регистрация pop_Word_IsVarLike }
 TkwPopWordIsInParam.RegisterInEngine;
 {* Регистрация pop_Word_IsInParam }
 TkwPopWordSetValue.RegisterInEngine;
 {* Регистрация pop_Word_SetValue }
 TkwPopWordInfo.RegisterInEngine;
 {* Регистрация pop_Word_Info }
 TkwPopWordIsForHelp.RegisterInEngine;
 {* Регистрация pop_Word_IsForHelp }
 TkwPopWordIsImmediate.RegisterInEngine;
 {* Регистрация pop_Word_IsImmediate }
 TkwPopWordIncRef.RegisterInEngine;
 {* Регистрация pop_Word_IncRef }
 TkwPopWordDecRef.RegisterInEngine;
 {* Регистрация pop_Word_DecRef }
 TkwPopWordMembersIterator.RegisterInEngine;
 {* Регистрация pop_Word_MembersIterator }
 TkwPopWordInnerDictionary.RegisterInEngine;
 {* Регистрация pop_Word_InnerDictionary }
 TkwPopWordCodeIterator.RegisterInEngine;
 {* Регистрация pop_Word_CodeIterator }
 TkwPopWordSetValuePrim.RegisterInEngine;
 {* Регистрация pop_Word_SetValuePrim }
 TkwPopWordKeyWord.RegisterInEngine;
 {* Регистрация pop_Word_KeyWord }
 TkwPopWordSetParent.RegisterInEngine;
 {* Регистрация pop_Word_SetParent }
 TkwPopWordSetKey.RegisterInEngine;
 {* Регистрация pop_Word_SetKey }
 TkwPopWordBox.RegisterInEngine;
 {* Регистрация pop_Word_Box }
 TkwPopWordGetRefForCompare.RegisterInEngine;
 {* Регистрация pop_Word_GetRefForCompare }
 TkwPopWordDirectives.RegisterInEngine;
 {* Регистрация pop_Word_Directives }
 TkwPopWordEndBracket.RegisterInEngine;
 {* Регистрация pop_Word_EndBracket }
 TkwPopWordLeftWordRefValuesCount.RegisterInEngine;
 {* Регистрация pop_Word_LeftWordRefValuesCount }
 TkwPopWordName.RegisterInEngine;
 {* Регистрация pop_Word_Name }
 TkwPopWordParent.RegisterInEngine;
 {* Регистрация pop_Word_Parent }
 TkwPopWordProducer.RegisterInEngine;
 {* Регистрация pop_Word_Producer }
 TkwPopWordRedefines.RegisterInEngine;
 {* Регистрация pop_Word_Redefines }
 TWordsRTTIPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeyWord));
 {* Регистрация типа TtfwKeyWord }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWordInfo));
 {* Регистрация типа TtfwWordInfo }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwValueList));
 {* Регистрация типа ItfwValueList }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwDictionary));
 {* Регистрация типа TtfwDictionary }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwWordBox));
 {* Регистрация типа ItfwWordBox }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwStackValue }
{$IfEnd} // NOT Defined(NoScripts)

end.
