unit tfwWordInfoWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwWordInfoWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "tfwWordInfoWordsPack" MUID: (55C3729D0212)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3Interfaces
 , tfwScriptingInterfaces
 , tfwScriptingTypes
 , tfwValueTypes
 , tfwTypeInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwClassLike
 , TypInfo
 , tfwPropertyLike
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 //#UC START# *55C3729D0212impl_uses*
 //#UC END# *55C3729D0212impl_uses*
;

type
 TkwPopWordInfoIncludeModifier = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:IncludeModifier }
  private
   function IncludeModifier(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    aModifier: TtfwWordModifier): TtfwWordInfo;
    {* Реализация слова скрипта pop:WordInfo:IncludeModifier }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoIncludeModifier

 TkwPopWordInfoEmpty = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:Empty }
  private
   function Empty(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo): Boolean;
    {* Реализация слова скрипта pop:WordInfo:Empty }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoEmpty

 TkwPopWordInfoHasWordModifier = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:HasWordModifier }
  private
   function HasWordModifier(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    aModifier: TtfwWordModifier): Boolean;
    {* Реализация слова скрипта pop:WordInfo:HasWordModifier }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoHasWordModifier

 TkwPopWordInfoIncludeTypeModifier = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:IncludeTypeModifier }
  private
   function IncludeTypeModifier(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    aType: TtfwValueType): TtfwWordInfo;
    {* Реализация слова скрипта pop:WordInfo:IncludeTypeModifier }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoIncludeTypeModifier

 TkwPopWordInfoHasValueType = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:HasValueType }
  private
   function HasValueType(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    aType: TtfwValueType): Boolean;
    {* Реализация слова скрипта pop:WordInfo:HasValueType }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoHasValueType

 TkwPopWordInfoAcceptsValue = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:AcceptsValue }
  private
   function AcceptsValue(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    const aValue: TtfwStackValue): Boolean;
    {* Реализация слова скрипта pop:WordInfo:AcceptsValue }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoAcceptsValue

 TkwPopWordInfoHasAccessType = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:HasAccessType }
  private
   function HasAccessType(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    anAccess: TtfwAccessType): Boolean;
    {* Реализация слова скрипта pop:WordInfo:HasAccessType }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoHasAccessType

 TkwPopWordInfoIncludeAccesType = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:IncludeAccesType }
  private
   function IncludeAccesType(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    anAccess: TtfwAccessType): TtfwWordInfo;
    {* Реализация слова скрипта pop:WordInfo:IncludeAccesType }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoIncludeAccesType

 TkwPopWordInfoValueTypes = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:ValueTypes }
  private
   function ValueTypes(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo): TtfwValueTypes;
    {* Реализация слова скрипта pop:WordInfo:ValueTypes }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoValueTypes

 TkwPopWordInfoIncludeLinkType = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:IncludeLinkType }
  private
   function IncludeLinkType(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    aLinkType: TtfwLinkType): TtfwWordInfo;
    {* Реализация слова скрипта pop:WordInfo:IncludeLinkType }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoIncludeLinkType

 TkwPopWordInfoHasLinkType = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:HasLinkType }
  private
   function HasLinkType(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    aLinkType: TtfwLinkType): Boolean;
    {* Реализация слова скрипта pop:WordInfo:HasLinkType }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoHasLinkType

 TkwPopWordInfoCompare = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:Compare }
  private
   function Compare(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    anOther: TtfwWordInfo): Integer;
    {* Реализация слова скрипта pop:WordInfo:Compare }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoCompare

 TkwPopWordInfoToString = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:ToString }
  private
   function ToString(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo): Il3CString;
    {* Реализация слова скрипта pop:WordInfo:ToString }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoToString

 TkwPopWordInfoTypeName = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:WordInfo:TypeName }
  private
   function TypeName(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo): Il3CString;
    {* Реализация слова скрипта pop:WordInfo:TypeName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopWordInfoTypeName

 TkwPopWordInfoLinkType = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:WordInfo:LinkType }
  private
   function LinkType(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo): TtfwLinkType;
    {* Реализация слова скрипта pop:WordInfo:LinkType }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopWordInfoLinkType

 TkwPopWordInfoAccessType = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:WordInfo:AccessType }
  private
   function AccessType(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo): TtfwAccessType;
    {* Реализация слова скрипта pop:WordInfo:AccessType }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopWordInfoAccessType

function TkwPopWordInfoIncludeModifier.IncludeModifier(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo;
 aModifier: TtfwWordModifier): TtfwWordInfo;
 {* Реализация слова скрипта pop:WordInfo:IncludeModifier }
begin
 Result := aWordInfo.IncludeModifier(aModifier);
end;//TkwPopWordInfoIncludeModifier.IncludeModifier

class function TkwPopWordInfoIncludeModifier.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:IncludeModifier';
end;//TkwPopWordInfoIncludeModifier.GetWordNameForRegister

function TkwPopWordInfoIncludeModifier.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwWordInfo);
end;//TkwPopWordInfoIncludeModifier.GetResultTypeInfo

function TkwPopWordInfoIncludeModifier.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordInfoIncludeModifier.GetAllParamsCount

function TkwPopWordInfoIncludeModifier.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo), TypeInfo(TtfwWordModifier)]);
end;//TkwPopWordInfoIncludeModifier.ParamsTypes

procedure TkwPopWordInfoIncludeModifier.DoDoIt(const aCtx: TtfwContext);
var l_aWordInfo: TtfwWordInfo;
var l_aModifier: TtfwWordModifier;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aModifier := TtfwWordModifier(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aModifier: TtfwWordModifier : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(IncludeModifier(aCtx, l_aWordInfo, l_aModifier));
end;//TkwPopWordInfoIncludeModifier.DoDoIt

function TkwPopWordInfoEmpty.Empty(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo): Boolean;
 {* Реализация слова скрипта pop:WordInfo:Empty }
begin
 Result := aWordInfo.Empty;
end;//TkwPopWordInfoEmpty.Empty

class function TkwPopWordInfoEmpty.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:Empty';
end;//TkwPopWordInfoEmpty.GetWordNameForRegister

function TkwPopWordInfoEmpty.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopWordInfoEmpty.GetResultTypeInfo

function TkwPopWordInfoEmpty.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordInfoEmpty.GetAllParamsCount

function TkwPopWordInfoEmpty.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo)]);
end;//TkwPopWordInfoEmpty.ParamsTypes

procedure TkwPopWordInfoEmpty.DoDoIt(const aCtx: TtfwContext);
var l_aWordInfo: TtfwWordInfo;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(Empty(aCtx, l_aWordInfo));
end;//TkwPopWordInfoEmpty.DoDoIt

function TkwPopWordInfoHasWordModifier.HasWordModifier(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo;
 aModifier: TtfwWordModifier): Boolean;
 {* Реализация слова скрипта pop:WordInfo:HasWordModifier }
//#UC START# *55C373250327_55C373250327_559D504A0081_Word_var*
//#UC END# *55C373250327_55C373250327_559D504A0081_Word_var*
begin
//#UC START# *55C373250327_55C373250327_559D504A0081_Word_impl*
 Result := aWordInfo.Has(aModifier);
//#UC END# *55C373250327_55C373250327_559D504A0081_Word_impl*
end;//TkwPopWordInfoHasWordModifier.HasWordModifier

class function TkwPopWordInfoHasWordModifier.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:HasWordModifier';
end;//TkwPopWordInfoHasWordModifier.GetWordNameForRegister

function TkwPopWordInfoHasWordModifier.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopWordInfoHasWordModifier.GetResultTypeInfo

function TkwPopWordInfoHasWordModifier.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordInfoHasWordModifier.GetAllParamsCount

function TkwPopWordInfoHasWordModifier.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo), TypeInfo(TtfwWordModifier)]);
end;//TkwPopWordInfoHasWordModifier.ParamsTypes

procedure TkwPopWordInfoHasWordModifier.DoDoIt(const aCtx: TtfwContext);
var l_aWordInfo: TtfwWordInfo;
var l_aModifier: TtfwWordModifier;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aModifier := TtfwWordModifier(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aModifier: TtfwWordModifier : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(HasWordModifier(aCtx, l_aWordInfo, l_aModifier));
end;//TkwPopWordInfoHasWordModifier.DoDoIt

function TkwPopWordInfoIncludeTypeModifier.IncludeTypeModifier(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo;
 aType: TtfwValueType): TtfwWordInfo;
 {* Реализация слова скрипта pop:WordInfo:IncludeTypeModifier }
begin
 Result := aWordInfo.IncludeTypeModifier(aType);
end;//TkwPopWordInfoIncludeTypeModifier.IncludeTypeModifier

class function TkwPopWordInfoIncludeTypeModifier.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:IncludeTypeModifier';
end;//TkwPopWordInfoIncludeTypeModifier.GetWordNameForRegister

function TkwPopWordInfoIncludeTypeModifier.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwWordInfo);
end;//TkwPopWordInfoIncludeTypeModifier.GetResultTypeInfo

function TkwPopWordInfoIncludeTypeModifier.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordInfoIncludeTypeModifier.GetAllParamsCount

function TkwPopWordInfoIncludeTypeModifier.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo), TypeInfo(TtfwValueType)]);
end;//TkwPopWordInfoIncludeTypeModifier.ParamsTypes

procedure TkwPopWordInfoIncludeTypeModifier.DoDoIt(const aCtx: TtfwContext);
var l_aWordInfo: TtfwWordInfo;
var l_aType: TtfwValueType;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aType := TtfwValueType(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aType: TtfwValueType : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(IncludeTypeModifier(aCtx, l_aWordInfo, l_aType));
end;//TkwPopWordInfoIncludeTypeModifier.DoDoIt

function TkwPopWordInfoHasValueType.HasValueType(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo;
 aType: TtfwValueType): Boolean;
 {* Реализация слова скрипта pop:WordInfo:HasValueType }
//#UC START# *55C373600196_55C373600196_559D504A0081_Word_var*
//#UC END# *55C373600196_55C373600196_559D504A0081_Word_var*
begin
//#UC START# *55C373600196_55C373600196_559D504A0081_Word_impl*
 Result := aWordInfo.Has(aType);
//#UC END# *55C373600196_55C373600196_559D504A0081_Word_impl*
end;//TkwPopWordInfoHasValueType.HasValueType

class function TkwPopWordInfoHasValueType.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:HasValueType';
end;//TkwPopWordInfoHasValueType.GetWordNameForRegister

function TkwPopWordInfoHasValueType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopWordInfoHasValueType.GetResultTypeInfo

function TkwPopWordInfoHasValueType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordInfoHasValueType.GetAllParamsCount

function TkwPopWordInfoHasValueType.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo), TypeInfo(TtfwValueType)]);
end;//TkwPopWordInfoHasValueType.ParamsTypes

procedure TkwPopWordInfoHasValueType.DoDoIt(const aCtx: TtfwContext);
var l_aWordInfo: TtfwWordInfo;
var l_aType: TtfwValueType;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aType := TtfwValueType(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aType: TtfwValueType : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(HasValueType(aCtx, l_aWordInfo, l_aType));
end;//TkwPopWordInfoHasValueType.DoDoIt

function TkwPopWordInfoAcceptsValue.AcceptsValue(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo;
 const aValue: TtfwStackValue): Boolean;
 {* Реализация слова скрипта pop:WordInfo:AcceptsValue }
begin
 Result := aWordInfo.AcceptsValue(aValue);
end;//TkwPopWordInfoAcceptsValue.AcceptsValue

class function TkwPopWordInfoAcceptsValue.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:AcceptsValue';
end;//TkwPopWordInfoAcceptsValue.GetWordNameForRegister

function TkwPopWordInfoAcceptsValue.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopWordInfoAcceptsValue.GetResultTypeInfo

function TkwPopWordInfoAcceptsValue.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordInfoAcceptsValue.GetAllParamsCount

function TkwPopWordInfoAcceptsValue.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo), @tfw_tiStruct]);
end;//TkwPopWordInfoAcceptsValue.ParamsTypes

procedure TkwPopWordInfoAcceptsValue.DoDoIt(const aCtx: TtfwContext);
var l_aWordInfo: TtfwWordInfo;
var l_aValue: TtfwStackValue;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
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
 aCtx.rEngine.PushBool(AcceptsValue(aCtx, l_aWordInfo, l_aValue));
end;//TkwPopWordInfoAcceptsValue.DoDoIt

function TkwPopWordInfoHasAccessType.HasAccessType(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo;
 anAccess: TtfwAccessType): Boolean;
 {* Реализация слова скрипта pop:WordInfo:HasAccessType }
//#UC START# *55C3739302E9_55C3739302E9_559D504A0081_Word_var*
//#UC END# *55C3739302E9_55C3739302E9_559D504A0081_Word_var*
begin
//#UC START# *55C3739302E9_55C3739302E9_559D504A0081_Word_impl*
 Result := aWordInfo.Has(anAccess);
//#UC END# *55C3739302E9_55C3739302E9_559D504A0081_Word_impl*
end;//TkwPopWordInfoHasAccessType.HasAccessType

class function TkwPopWordInfoHasAccessType.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:HasAccessType';
end;//TkwPopWordInfoHasAccessType.GetWordNameForRegister

function TkwPopWordInfoHasAccessType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopWordInfoHasAccessType.GetResultTypeInfo

function TkwPopWordInfoHasAccessType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordInfoHasAccessType.GetAllParamsCount

function TkwPopWordInfoHasAccessType.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo), TypeInfo(TtfwAccessType)]);
end;//TkwPopWordInfoHasAccessType.ParamsTypes

procedure TkwPopWordInfoHasAccessType.DoDoIt(const aCtx: TtfwContext);
var l_aWordInfo: TtfwWordInfo;
var l_anAccess: TtfwAccessType;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anAccess := TtfwAccessType(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anAccess: TtfwAccessType : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(HasAccessType(aCtx, l_aWordInfo, l_anAccess));
end;//TkwPopWordInfoHasAccessType.DoDoIt

function TkwPopWordInfoIncludeAccesType.IncludeAccesType(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo;
 anAccess: TtfwAccessType): TtfwWordInfo;
 {* Реализация слова скрипта pop:WordInfo:IncludeAccesType }
begin
 Result := aWordInfo.IncludeAccesType(anAccess);
end;//TkwPopWordInfoIncludeAccesType.IncludeAccesType

class function TkwPopWordInfoIncludeAccesType.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:IncludeAccesType';
end;//TkwPopWordInfoIncludeAccesType.GetWordNameForRegister

function TkwPopWordInfoIncludeAccesType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwWordInfo);
end;//TkwPopWordInfoIncludeAccesType.GetResultTypeInfo

function TkwPopWordInfoIncludeAccesType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordInfoIncludeAccesType.GetAllParamsCount

function TkwPopWordInfoIncludeAccesType.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo), TypeInfo(TtfwAccessType)]);
end;//TkwPopWordInfoIncludeAccesType.ParamsTypes

procedure TkwPopWordInfoIncludeAccesType.DoDoIt(const aCtx: TtfwContext);
var l_aWordInfo: TtfwWordInfo;
var l_anAccess: TtfwAccessType;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anAccess := TtfwAccessType(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anAccess: TtfwAccessType : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(IncludeAccesType(aCtx, l_aWordInfo, l_anAccess));
end;//TkwPopWordInfoIncludeAccesType.DoDoIt

function TkwPopWordInfoValueTypes.ValueTypes(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo): TtfwValueTypes;
 {* Реализация слова скрипта pop:WordInfo:ValueTypes }
begin
 Result := aWordInfo.ValueTypes;
end;//TkwPopWordInfoValueTypes.ValueTypes

class function TkwPopWordInfoValueTypes.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:ValueTypes';
end;//TkwPopWordInfoValueTypes.GetWordNameForRegister

function TkwPopWordInfoValueTypes.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwValueTypes);
end;//TkwPopWordInfoValueTypes.GetResultTypeInfo

function TkwPopWordInfoValueTypes.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordInfoValueTypes.GetAllParamsCount

function TkwPopWordInfoValueTypes.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo)]);
end;//TkwPopWordInfoValueTypes.ParamsTypes

procedure TkwPopWordInfoValueTypes.DoDoIt(const aCtx: TtfwContext);
var l_aWordInfo: TtfwWordInfo;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ValueTypes(aCtx, l_aWordInfo));
end;//TkwPopWordInfoValueTypes.DoDoIt

function TkwPopWordInfoIncludeLinkType.IncludeLinkType(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo;
 aLinkType: TtfwLinkType): TtfwWordInfo;
 {* Реализация слова скрипта pop:WordInfo:IncludeLinkType }
begin
 Result := aWordInfo.IncludeLinkType(aLinkType);
end;//TkwPopWordInfoIncludeLinkType.IncludeLinkType

class function TkwPopWordInfoIncludeLinkType.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:IncludeLinkType';
end;//TkwPopWordInfoIncludeLinkType.GetWordNameForRegister

function TkwPopWordInfoIncludeLinkType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwWordInfo);
end;//TkwPopWordInfoIncludeLinkType.GetResultTypeInfo

function TkwPopWordInfoIncludeLinkType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordInfoIncludeLinkType.GetAllParamsCount

function TkwPopWordInfoIncludeLinkType.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo), TypeInfo(TtfwLinkType)]);
end;//TkwPopWordInfoIncludeLinkType.ParamsTypes

procedure TkwPopWordInfoIncludeLinkType.DoDoIt(const aCtx: TtfwContext);
var l_aWordInfo: TtfwWordInfo;
var l_aLinkType: TtfwLinkType;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aLinkType := TtfwLinkType(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLinkType: TtfwLinkType : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(IncludeLinkType(aCtx, l_aWordInfo, l_aLinkType));
end;//TkwPopWordInfoIncludeLinkType.DoDoIt

function TkwPopWordInfoHasLinkType.HasLinkType(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo;
 aLinkType: TtfwLinkType): Boolean;
 {* Реализация слова скрипта pop:WordInfo:HasLinkType }
//#UC START# *55C374500185_55C374500185_559D504A0081_Word_var*
//#UC END# *55C374500185_55C374500185_559D504A0081_Word_var*
begin
//#UC START# *55C374500185_55C374500185_559D504A0081_Word_impl*
 Result := aWordInfo.Has(aLinkType);
//#UC END# *55C374500185_55C374500185_559D504A0081_Word_impl*
end;//TkwPopWordInfoHasLinkType.HasLinkType

class function TkwPopWordInfoHasLinkType.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:HasLinkType';
end;//TkwPopWordInfoHasLinkType.GetWordNameForRegister

function TkwPopWordInfoHasLinkType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopWordInfoHasLinkType.GetResultTypeInfo

function TkwPopWordInfoHasLinkType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordInfoHasLinkType.GetAllParamsCount

function TkwPopWordInfoHasLinkType.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo), TypeInfo(TtfwLinkType)]);
end;//TkwPopWordInfoHasLinkType.ParamsTypes

procedure TkwPopWordInfoHasLinkType.DoDoIt(const aCtx: TtfwContext);
var l_aWordInfo: TtfwWordInfo;
var l_aLinkType: TtfwLinkType;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aLinkType := TtfwLinkType(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLinkType: TtfwLinkType : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(HasLinkType(aCtx, l_aWordInfo, l_aLinkType));
end;//TkwPopWordInfoHasLinkType.DoDoIt

function TkwPopWordInfoCompare.Compare(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo;
 anOther: TtfwWordInfo): Integer;
 {* Реализация слова скрипта pop:WordInfo:Compare }
begin
 Result := aWordInfo.Compare(anOther);
end;//TkwPopWordInfoCompare.Compare

class function TkwPopWordInfoCompare.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:Compare';
end;//TkwPopWordInfoCompare.GetWordNameForRegister

function TkwPopWordInfoCompare.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopWordInfoCompare.GetResultTypeInfo

function TkwPopWordInfoCompare.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordInfoCompare.GetAllParamsCount

function TkwPopWordInfoCompare.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo), TypeInfo(TtfwWordInfo)]);
end;//TkwPopWordInfoCompare.ParamsTypes

procedure TkwPopWordInfoCompare.DoDoIt(const aCtx: TtfwContext);
var l_aWordInfo: TtfwWordInfo;
var l_anOther: TtfwWordInfo;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOther := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anOther: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Compare(aCtx, l_aWordInfo, l_anOther));
end;//TkwPopWordInfoCompare.DoDoIt

function TkwPopWordInfoToString.ToString(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo): Il3CString;
 {* Реализация слова скрипта pop:WordInfo:ToString }
begin
 Result := aWordInfo.ToString;
end;//TkwPopWordInfoToString.ToString

class function TkwPopWordInfoToString.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:ToString';
end;//TkwPopWordInfoToString.GetWordNameForRegister

function TkwPopWordInfoToString.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopWordInfoToString.GetResultTypeInfo

function TkwPopWordInfoToString.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordInfoToString.GetAllParamsCount

function TkwPopWordInfoToString.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo)]);
end;//TkwPopWordInfoToString.ParamsTypes

procedure TkwPopWordInfoToString.DoDoIt(const aCtx: TtfwContext);
var l_aWordInfo: TtfwWordInfo;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(ToString(aCtx, l_aWordInfo));
end;//TkwPopWordInfoToString.DoDoIt

function TkwPopWordInfoTypeName.TypeName(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo): Il3CString;
 {* Реализация слова скрипта pop:WordInfo:TypeName }
begin
 Result := aWordInfo.TypeName;
end;//TkwPopWordInfoTypeName.TypeName

class function TkwPopWordInfoTypeName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:TypeName';
end;//TkwPopWordInfoTypeName.GetWordNameForRegister

function TkwPopWordInfoTypeName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopWordInfoTypeName.GetResultTypeInfo

function TkwPopWordInfoTypeName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordInfoTypeName.GetAllParamsCount

function TkwPopWordInfoTypeName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo)]);
end;//TkwPopWordInfoTypeName.ParamsTypes

procedure TkwPopWordInfoTypeName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству TypeName', aCtx);
end;//TkwPopWordInfoTypeName.SetValuePrim

procedure TkwPopWordInfoTypeName.DoDoIt(const aCtx: TtfwContext);
var l_aWordInfo: TtfwWordInfo;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(TypeName(aCtx, l_aWordInfo));
end;//TkwPopWordInfoTypeName.DoDoIt

function TkwPopWordInfoLinkType.LinkType(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo): TtfwLinkType;
 {* Реализация слова скрипта pop:WordInfo:LinkType }
begin
 Result := aWordInfo.LinkType;
end;//TkwPopWordInfoLinkType.LinkType

class function TkwPopWordInfoLinkType.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:LinkType';
end;//TkwPopWordInfoLinkType.GetWordNameForRegister

function TkwPopWordInfoLinkType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwLinkType);
end;//TkwPopWordInfoLinkType.GetResultTypeInfo

function TkwPopWordInfoLinkType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordInfoLinkType.GetAllParamsCount

function TkwPopWordInfoLinkType.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo)]);
end;//TkwPopWordInfoLinkType.ParamsTypes

procedure TkwPopWordInfoLinkType.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству LinkType', aCtx);
end;//TkwPopWordInfoLinkType.SetValuePrim

procedure TkwPopWordInfoLinkType.DoDoIt(const aCtx: TtfwContext);
var l_aWordInfo: TtfwWordInfo;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Ord(LinkType(aCtx, l_aWordInfo)));
end;//TkwPopWordInfoLinkType.DoDoIt

function TkwPopWordInfoAccessType.AccessType(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo): TtfwAccessType;
 {* Реализация слова скрипта pop:WordInfo:AccessType }
begin
 Result := aWordInfo.AccessType;
end;//TkwPopWordInfoAccessType.AccessType

class function TkwPopWordInfoAccessType.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:AccessType';
end;//TkwPopWordInfoAccessType.GetWordNameForRegister

function TkwPopWordInfoAccessType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwAccessType);
end;//TkwPopWordInfoAccessType.GetResultTypeInfo

function TkwPopWordInfoAccessType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordInfoAccessType.GetAllParamsCount

function TkwPopWordInfoAccessType.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo)]);
end;//TkwPopWordInfoAccessType.ParamsTypes

procedure TkwPopWordInfoAccessType.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству AccessType', aCtx);
end;//TkwPopWordInfoAccessType.SetValuePrim

procedure TkwPopWordInfoAccessType.DoDoIt(const aCtx: TtfwContext);
var l_aWordInfo: TtfwWordInfo;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Ord(AccessType(aCtx, l_aWordInfo)));
end;//TkwPopWordInfoAccessType.DoDoIt

initialization
 TkwPopWordInfoIncludeModifier.RegisterInEngine;
 {* Регистрация pop_WordInfo_IncludeModifier }
 TkwPopWordInfoEmpty.RegisterInEngine;
 {* Регистрация pop_WordInfo_Empty }
 TkwPopWordInfoHasWordModifier.RegisterInEngine;
 {* Регистрация pop_WordInfo_HasWordModifier }
 TkwPopWordInfoIncludeTypeModifier.RegisterInEngine;
 {* Регистрация pop_WordInfo_IncludeTypeModifier }
 TkwPopWordInfoHasValueType.RegisterInEngine;
 {* Регистрация pop_WordInfo_HasValueType }
 TkwPopWordInfoAcceptsValue.RegisterInEngine;
 {* Регистрация pop_WordInfo_AcceptsValue }
 TkwPopWordInfoHasAccessType.RegisterInEngine;
 {* Регистрация pop_WordInfo_HasAccessType }
 TkwPopWordInfoIncludeAccesType.RegisterInEngine;
 {* Регистрация pop_WordInfo_IncludeAccesType }
 TkwPopWordInfoValueTypes.RegisterInEngine;
 {* Регистрация pop_WordInfo_ValueTypes }
 TkwPopWordInfoIncludeLinkType.RegisterInEngine;
 {* Регистрация pop_WordInfo_IncludeLinkType }
 TkwPopWordInfoHasLinkType.RegisterInEngine;
 {* Регистрация pop_WordInfo_HasLinkType }
 TkwPopWordInfoCompare.RegisterInEngine;
 {* Регистрация pop_WordInfo_Compare }
 TkwPopWordInfoToString.RegisterInEngine;
 {* Регистрация pop_WordInfo_ToString }
 TkwPopWordInfoTypeName.RegisterInEngine;
 {* Регистрация pop_WordInfo_TypeName }
 TkwPopWordInfoLinkType.RegisterInEngine;
 {* Регистрация pop_WordInfo_LinkType }
 TkwPopWordInfoAccessType.RegisterInEngine;
 {* Регистрация pop_WordInfo_AccessType }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWordInfo));
 {* Регистрация типа TtfwWordInfo }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwValueTypes));
 {* Регистрация типа TtfwValueTypes }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwLinkType));
 {* Регистрация типа TtfwLinkType }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwAccessType));
 {* Регистрация типа TtfwAccessType }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWordModifier));
 {* Регистрация типа TtfwWordModifier }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwValueType));
 {* Регистрация типа TtfwValueType }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwStackValue }
{$IfEnd} // NOT Defined(NoScripts)

end.
