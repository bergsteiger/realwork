unit tfwWordInfoWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwWordInfoWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptingInterfaces
 , l3Interfaces
 , tfwValueTypes
 , tfwScriptingTypes
 , tfwTypeInfo
 , tfwClassLike
 , TypInfo
 , tfwPropertyLike
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopWordInfoIncludeModifier = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:IncludeModifier
*Тип результата:* TtfwWordInfo
*Пример:*
[code]
OBJECT VAR l_TtfwWordInfo
 aModifier aWordInfo pop:WordInfo:IncludeModifier >>> l_TtfwWordInfo
[code]  }
  private
   function IncludeModifier(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    aModifier: TtfwWordModifier): TtfwWordInfo;
    {* Реализация слова скрипта pop:WordInfo:IncludeModifier }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoIncludeModifier

 TkwPopWordInfoEmpty = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:Empty
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aWordInfo pop:WordInfo:Empty >>> l_Boolean
[code]  }
  private
   function Empty(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo): Boolean;
    {* Реализация слова скрипта pop:WordInfo:Empty }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoEmpty

 TkwPopWordInfoHasWordModifier = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:HasWordModifier
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aModifier aWordInfo pop:WordInfo:HasWordModifier >>> l_Boolean
[code]  }
  private
   function HasWordModifier(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    aModifier: TtfwWordModifier): Boolean;
    {* Реализация слова скрипта pop:WordInfo:HasWordModifier }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoHasWordModifier

 TkwPopWordInfoIncludeTypeModifier = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:IncludeTypeModifier
*Тип результата:* TtfwWordInfo
*Пример:*
[code]
OBJECT VAR l_TtfwWordInfo
 aType aWordInfo pop:WordInfo:IncludeTypeModifier >>> l_TtfwWordInfo
[code]  }
  private
   function IncludeTypeModifier(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    aType: TtfwValueType): TtfwWordInfo;
    {* Реализация слова скрипта pop:WordInfo:IncludeTypeModifier }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoIncludeTypeModifier

 TkwPopWordInfoHasValueType = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:HasValueType
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aType aWordInfo pop:WordInfo:HasValueType >>> l_Boolean
[code]  }
  private
   function HasValueType(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    aType: TtfwValueType): Boolean;
    {* Реализация слова скрипта pop:WordInfo:HasValueType }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoHasValueType

 TkwPopWordInfoAcceptsValue = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:AcceptsValue
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aValue aWordInfo pop:WordInfo:AcceptsValue >>> l_Boolean
[code]  }
  private
   function AcceptsValue(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    const aValue: TtfwStackValue): Boolean;
    {* Реализация слова скрипта pop:WordInfo:AcceptsValue }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoAcceptsValue

 TkwPopWordInfoHasAccessType = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:HasAccessType
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 anAccess aWordInfo pop:WordInfo:HasAccessType >>> l_Boolean
[code]  }
  private
   function HasAccessType(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    anAccess: TtfwAccessType): Boolean;
    {* Реализация слова скрипта pop:WordInfo:HasAccessType }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoHasAccessType

 TkwPopWordInfoIncludeAccesType = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:IncludeAccesType
*Тип результата:* TtfwWordInfo
*Пример:*
[code]
OBJECT VAR l_TtfwWordInfo
 anAccess aWordInfo pop:WordInfo:IncludeAccesType >>> l_TtfwWordInfo
[code]  }
  private
   function IncludeAccesType(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    anAccess: TtfwAccessType): TtfwWordInfo;
    {* Реализация слова скрипта pop:WordInfo:IncludeAccesType }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoIncludeAccesType

 TkwPopWordInfoValueTypes = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:ValueTypes
*Тип результата:* TtfwValueTypes
*Пример:*
[code]
OBJECT VAR l_TtfwValueTypes
 aWordInfo pop:WordInfo:ValueTypes >>> l_TtfwValueTypes
[code]  }
  private
   function ValueTypes(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo): TtfwValueTypes;
    {* Реализация слова скрипта pop:WordInfo:ValueTypes }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoValueTypes

 TkwPopWordInfoIncludeLinkType = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:IncludeLinkType
*Тип результата:* TtfwWordInfo
*Пример:*
[code]
OBJECT VAR l_TtfwWordInfo
 aLinkType aWordInfo pop:WordInfo:IncludeLinkType >>> l_TtfwWordInfo
[code]  }
  private
   function IncludeLinkType(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    aLinkType: TtfwLinkType): TtfwWordInfo;
    {* Реализация слова скрипта pop:WordInfo:IncludeLinkType }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoIncludeLinkType

 TkwPopWordInfoHasLinkType = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:HasLinkType
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aLinkType aWordInfo pop:WordInfo:HasLinkType >>> l_Boolean
[code]  }
  private
   function HasLinkType(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    aLinkType: TtfwLinkType): Boolean;
    {* Реализация слова скрипта pop:WordInfo:HasLinkType }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoHasLinkType

 TkwPopWordInfoCompare = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:Compare
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 anOther aWordInfo pop:WordInfo:Compare >>> l_Integer
[code]  }
  private
   function Compare(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    anOther: TtfwWordInfo): Integer;
    {* Реализация слова скрипта pop:WordInfo:Compare }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoCompare

 TkwPopWordInfoToString = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:ToString
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aWordInfo pop:WordInfo:ToString >>> l_Il3CString
[code]  }
  private
   function ToString(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo): Il3CString;
    {* Реализация слова скрипта pop:WordInfo:ToString }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoToString

 TkwPopWordInfoTypeName = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:WordInfo:TypeName
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aWordInfo pop:WordInfo:TypeName >>> l_Il3CString
[code]  }
  private
   function TypeName(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo): Il3CString;
    {* Реализация слова скрипта pop:WordInfo:TypeName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoTypeName

 TkwPopWordInfoLinkType = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:WordInfo:LinkType
*Тип результата:* TtfwLinkType
*Пример:*
[code]
TtfwLinkType VAR l_TtfwLinkType
 aWordInfo pop:WordInfo:LinkType >>> l_TtfwLinkType
[code]  }
  private
   function LinkType(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo): TtfwLinkType;
    {* Реализация слова скрипта pop:WordInfo:LinkType }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoLinkType

 TkwPopWordInfoAccessType = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:WordInfo:AccessType
*Тип результата:* TtfwAccessType
*Пример:*
[code]
TtfwAccessType VAR l_TtfwAccessType
 aWordInfo pop:WordInfo:AccessType >>> l_TtfwAccessType
[code]  }
  private
   function AccessType(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo): TtfwAccessType;
    {* Реализация слова скрипта pop:WordInfo:AccessType }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoAccessType

function TkwPopWordInfoIncludeModifier.IncludeModifier(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo;
 aModifier: TtfwWordModifier): TtfwWordInfo;
 {* Реализация слова скрипта pop:WordInfo:IncludeModifier }
//#UC START# *196CCED78325_14934B24DEE4_var*
//#UC END# *196CCED78325_14934B24DEE4_var*
begin
//#UC START# *196CCED78325_14934B24DEE4_impl*
 !!! Needs to be implemented !!!
//#UC END# *196CCED78325_14934B24DEE4_impl*
end;//TkwPopWordInfoIncludeModifier.IncludeModifier

procedure TkwPopWordInfoIncludeModifier.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_14934B24DEE4_var*
//#UC END# *4DAEEDE10285_14934B24DEE4_var*
begin
//#UC START# *4DAEEDE10285_14934B24DEE4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_14934B24DEE4_impl*
end;//TkwPopWordInfoIncludeModifier.DoDoIt

class function TkwPopWordInfoIncludeModifier.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:IncludeModifier';
end;//TkwPopWordInfoIncludeModifier.GetWordNameForRegister

function TkwPopWordInfoIncludeModifier.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_14934B24DEE4_var*
//#UC END# *551544E2001A_14934B24DEE4_var*
begin
//#UC START# *551544E2001A_14934B24DEE4_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_14934B24DEE4_impl*
end;//TkwPopWordInfoIncludeModifier.GetResultTypeInfo

function TkwPopWordInfoIncludeModifier.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordInfoIncludeModifier.GetAllParamsCount

function TkwPopWordInfoIncludeModifier.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_14934B24DEE4_var*
//#UC END# *5617F4D00243_14934B24DEE4_var*
begin
//#UC START# *5617F4D00243_14934B24DEE4_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_14934B24DEE4_impl*
end;//TkwPopWordInfoIncludeModifier.ParamsTypes

function TkwPopWordInfoEmpty.Empty(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo): Boolean;
 {* Реализация слова скрипта pop:WordInfo:Empty }
//#UC START# *DE7D56B67062_9E29B763689D_var*
//#UC END# *DE7D56B67062_9E29B763689D_var*
begin
//#UC START# *DE7D56B67062_9E29B763689D_impl*
 !!! Needs to be implemented !!!
//#UC END# *DE7D56B67062_9E29B763689D_impl*
end;//TkwPopWordInfoEmpty.Empty

procedure TkwPopWordInfoEmpty.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9E29B763689D_var*
//#UC END# *4DAEEDE10285_9E29B763689D_var*
begin
//#UC START# *4DAEEDE10285_9E29B763689D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9E29B763689D_impl*
end;//TkwPopWordInfoEmpty.DoDoIt

class function TkwPopWordInfoEmpty.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:Empty';
end;//TkwPopWordInfoEmpty.GetWordNameForRegister

function TkwPopWordInfoEmpty.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_9E29B763689D_var*
//#UC END# *551544E2001A_9E29B763689D_var*
begin
//#UC START# *551544E2001A_9E29B763689D_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_9E29B763689D_impl*
end;//TkwPopWordInfoEmpty.GetResultTypeInfo

function TkwPopWordInfoEmpty.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordInfoEmpty.GetAllParamsCount

function TkwPopWordInfoEmpty.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_9E29B763689D_var*
//#UC END# *5617F4D00243_9E29B763689D_var*
begin
//#UC START# *5617F4D00243_9E29B763689D_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_9E29B763689D_impl*
end;//TkwPopWordInfoEmpty.ParamsTypes

function TkwPopWordInfoHasWordModifier.HasWordModifier(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo;
 aModifier: TtfwWordModifier): Boolean;
 {* Реализация слова скрипта pop:WordInfo:HasWordModifier }
//#UC START# *6F1830859A21_4280F4A50B03_var*
//#UC END# *6F1830859A21_4280F4A50B03_var*
begin
//#UC START# *6F1830859A21_4280F4A50B03_impl*
 Result := aWordInfo.Has(aModifier);
//#UC END# *6F1830859A21_4280F4A50B03_impl*
end;//TkwPopWordInfoHasWordModifier.HasWordModifier

procedure TkwPopWordInfoHasWordModifier.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4280F4A50B03_var*
//#UC END# *4DAEEDE10285_4280F4A50B03_var*
begin
//#UC START# *4DAEEDE10285_4280F4A50B03_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4280F4A50B03_impl*
end;//TkwPopWordInfoHasWordModifier.DoDoIt

class function TkwPopWordInfoHasWordModifier.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:HasWordModifier';
end;//TkwPopWordInfoHasWordModifier.GetWordNameForRegister

function TkwPopWordInfoHasWordModifier.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_4280F4A50B03_var*
//#UC END# *551544E2001A_4280F4A50B03_var*
begin
//#UC START# *551544E2001A_4280F4A50B03_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_4280F4A50B03_impl*
end;//TkwPopWordInfoHasWordModifier.GetResultTypeInfo

function TkwPopWordInfoHasWordModifier.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordInfoHasWordModifier.GetAllParamsCount

function TkwPopWordInfoHasWordModifier.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_4280F4A50B03_var*
//#UC END# *5617F4D00243_4280F4A50B03_var*
begin
//#UC START# *5617F4D00243_4280F4A50B03_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_4280F4A50B03_impl*
end;//TkwPopWordInfoHasWordModifier.ParamsTypes

function TkwPopWordInfoIncludeTypeModifier.IncludeTypeModifier(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo;
 aType: TtfwValueType): TtfwWordInfo;
 {* Реализация слова скрипта pop:WordInfo:IncludeTypeModifier }
//#UC START# *DE1E3B21A195_D286CB4FCDB1_var*
//#UC END# *DE1E3B21A195_D286CB4FCDB1_var*
begin
//#UC START# *DE1E3B21A195_D286CB4FCDB1_impl*
 !!! Needs to be implemented !!!
//#UC END# *DE1E3B21A195_D286CB4FCDB1_impl*
end;//TkwPopWordInfoIncludeTypeModifier.IncludeTypeModifier

procedure TkwPopWordInfoIncludeTypeModifier.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D286CB4FCDB1_var*
//#UC END# *4DAEEDE10285_D286CB4FCDB1_var*
begin
//#UC START# *4DAEEDE10285_D286CB4FCDB1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D286CB4FCDB1_impl*
end;//TkwPopWordInfoIncludeTypeModifier.DoDoIt

class function TkwPopWordInfoIncludeTypeModifier.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:IncludeTypeModifier';
end;//TkwPopWordInfoIncludeTypeModifier.GetWordNameForRegister

function TkwPopWordInfoIncludeTypeModifier.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_D286CB4FCDB1_var*
//#UC END# *551544E2001A_D286CB4FCDB1_var*
begin
//#UC START# *551544E2001A_D286CB4FCDB1_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_D286CB4FCDB1_impl*
end;//TkwPopWordInfoIncludeTypeModifier.GetResultTypeInfo

function TkwPopWordInfoIncludeTypeModifier.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordInfoIncludeTypeModifier.GetAllParamsCount

function TkwPopWordInfoIncludeTypeModifier.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D286CB4FCDB1_var*
//#UC END# *5617F4D00243_D286CB4FCDB1_var*
begin
//#UC START# *5617F4D00243_D286CB4FCDB1_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D286CB4FCDB1_impl*
end;//TkwPopWordInfoIncludeTypeModifier.ParamsTypes

function TkwPopWordInfoHasValueType.HasValueType(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo;
 aType: TtfwValueType): Boolean;
 {* Реализация слова скрипта pop:WordInfo:HasValueType }
//#UC START# *AEC40CE6A30A_E77A7D4C22A1_var*
//#UC END# *AEC40CE6A30A_E77A7D4C22A1_var*
begin
//#UC START# *AEC40CE6A30A_E77A7D4C22A1_impl*
 Result := aWordInfo.Has(aType);
//#UC END# *AEC40CE6A30A_E77A7D4C22A1_impl*
end;//TkwPopWordInfoHasValueType.HasValueType

procedure TkwPopWordInfoHasValueType.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E77A7D4C22A1_var*
//#UC END# *4DAEEDE10285_E77A7D4C22A1_var*
begin
//#UC START# *4DAEEDE10285_E77A7D4C22A1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E77A7D4C22A1_impl*
end;//TkwPopWordInfoHasValueType.DoDoIt

class function TkwPopWordInfoHasValueType.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:HasValueType';
end;//TkwPopWordInfoHasValueType.GetWordNameForRegister

function TkwPopWordInfoHasValueType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_E77A7D4C22A1_var*
//#UC END# *551544E2001A_E77A7D4C22A1_var*
begin
//#UC START# *551544E2001A_E77A7D4C22A1_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_E77A7D4C22A1_impl*
end;//TkwPopWordInfoHasValueType.GetResultTypeInfo

function TkwPopWordInfoHasValueType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordInfoHasValueType.GetAllParamsCount

function TkwPopWordInfoHasValueType.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_E77A7D4C22A1_var*
//#UC END# *5617F4D00243_E77A7D4C22A1_var*
begin
//#UC START# *5617F4D00243_E77A7D4C22A1_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E77A7D4C22A1_impl*
end;//TkwPopWordInfoHasValueType.ParamsTypes

function TkwPopWordInfoAcceptsValue.AcceptsValue(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo;
 const aValue: TtfwStackValue): Boolean;
 {* Реализация слова скрипта pop:WordInfo:AcceptsValue }
//#UC START# *0A2D02F701A4_FA9440B232C5_var*
//#UC END# *0A2D02F701A4_FA9440B232C5_var*
begin
//#UC START# *0A2D02F701A4_FA9440B232C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *0A2D02F701A4_FA9440B232C5_impl*
end;//TkwPopWordInfoAcceptsValue.AcceptsValue

procedure TkwPopWordInfoAcceptsValue.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FA9440B232C5_var*
//#UC END# *4DAEEDE10285_FA9440B232C5_var*
begin
//#UC START# *4DAEEDE10285_FA9440B232C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FA9440B232C5_impl*
end;//TkwPopWordInfoAcceptsValue.DoDoIt

class function TkwPopWordInfoAcceptsValue.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:AcceptsValue';
end;//TkwPopWordInfoAcceptsValue.GetWordNameForRegister

function TkwPopWordInfoAcceptsValue.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_FA9440B232C5_var*
//#UC END# *551544E2001A_FA9440B232C5_var*
begin
//#UC START# *551544E2001A_FA9440B232C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_FA9440B232C5_impl*
end;//TkwPopWordInfoAcceptsValue.GetResultTypeInfo

function TkwPopWordInfoAcceptsValue.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordInfoAcceptsValue.GetAllParamsCount

function TkwPopWordInfoAcceptsValue.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_FA9440B232C5_var*
//#UC END# *5617F4D00243_FA9440B232C5_var*
begin
//#UC START# *5617F4D00243_FA9440B232C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_FA9440B232C5_impl*
end;//TkwPopWordInfoAcceptsValue.ParamsTypes

function TkwPopWordInfoHasAccessType.HasAccessType(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo;
 anAccess: TtfwAccessType): Boolean;
 {* Реализация слова скрипта pop:WordInfo:HasAccessType }
//#UC START# *DE32097D5418_E7485F00A9C9_var*
//#UC END# *DE32097D5418_E7485F00A9C9_var*
begin
//#UC START# *DE32097D5418_E7485F00A9C9_impl*
 Result := aWordInfo.Has(anAccess);
//#UC END# *DE32097D5418_E7485F00A9C9_impl*
end;//TkwPopWordInfoHasAccessType.HasAccessType

procedure TkwPopWordInfoHasAccessType.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E7485F00A9C9_var*
//#UC END# *4DAEEDE10285_E7485F00A9C9_var*
begin
//#UC START# *4DAEEDE10285_E7485F00A9C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E7485F00A9C9_impl*
end;//TkwPopWordInfoHasAccessType.DoDoIt

class function TkwPopWordInfoHasAccessType.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:HasAccessType';
end;//TkwPopWordInfoHasAccessType.GetWordNameForRegister

function TkwPopWordInfoHasAccessType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_E7485F00A9C9_var*
//#UC END# *551544E2001A_E7485F00A9C9_var*
begin
//#UC START# *551544E2001A_E7485F00A9C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_E7485F00A9C9_impl*
end;//TkwPopWordInfoHasAccessType.GetResultTypeInfo

function TkwPopWordInfoHasAccessType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordInfoHasAccessType.GetAllParamsCount

function TkwPopWordInfoHasAccessType.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_E7485F00A9C9_var*
//#UC END# *5617F4D00243_E7485F00A9C9_var*
begin
//#UC START# *5617F4D00243_E7485F00A9C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E7485F00A9C9_impl*
end;//TkwPopWordInfoHasAccessType.ParamsTypes

function TkwPopWordInfoIncludeAccesType.IncludeAccesType(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo;
 anAccess: TtfwAccessType): TtfwWordInfo;
 {* Реализация слова скрипта pop:WordInfo:IncludeAccesType }
//#UC START# *D15A2C77F385_C7CED070DA03_var*
//#UC END# *D15A2C77F385_C7CED070DA03_var*
begin
//#UC START# *D15A2C77F385_C7CED070DA03_impl*
 !!! Needs to be implemented !!!
//#UC END# *D15A2C77F385_C7CED070DA03_impl*
end;//TkwPopWordInfoIncludeAccesType.IncludeAccesType

procedure TkwPopWordInfoIncludeAccesType.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C7CED070DA03_var*
//#UC END# *4DAEEDE10285_C7CED070DA03_var*
begin
//#UC START# *4DAEEDE10285_C7CED070DA03_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C7CED070DA03_impl*
end;//TkwPopWordInfoIncludeAccesType.DoDoIt

class function TkwPopWordInfoIncludeAccesType.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:IncludeAccesType';
end;//TkwPopWordInfoIncludeAccesType.GetWordNameForRegister

function TkwPopWordInfoIncludeAccesType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_C7CED070DA03_var*
//#UC END# *551544E2001A_C7CED070DA03_var*
begin
//#UC START# *551544E2001A_C7CED070DA03_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_C7CED070DA03_impl*
end;//TkwPopWordInfoIncludeAccesType.GetResultTypeInfo

function TkwPopWordInfoIncludeAccesType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordInfoIncludeAccesType.GetAllParamsCount

function TkwPopWordInfoIncludeAccesType.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_C7CED070DA03_var*
//#UC END# *5617F4D00243_C7CED070DA03_var*
begin
//#UC START# *5617F4D00243_C7CED070DA03_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C7CED070DA03_impl*
end;//TkwPopWordInfoIncludeAccesType.ParamsTypes

function TkwPopWordInfoValueTypes.ValueTypes(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo): TtfwValueTypes;
 {* Реализация слова скрипта pop:WordInfo:ValueTypes }
//#UC START# *3716941F3DF2_2DC3823CA5CC_var*
//#UC END# *3716941F3DF2_2DC3823CA5CC_var*
begin
//#UC START# *3716941F3DF2_2DC3823CA5CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *3716941F3DF2_2DC3823CA5CC_impl*
end;//TkwPopWordInfoValueTypes.ValueTypes

procedure TkwPopWordInfoValueTypes.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2DC3823CA5CC_var*
//#UC END# *4DAEEDE10285_2DC3823CA5CC_var*
begin
//#UC START# *4DAEEDE10285_2DC3823CA5CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2DC3823CA5CC_impl*
end;//TkwPopWordInfoValueTypes.DoDoIt

class function TkwPopWordInfoValueTypes.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:ValueTypes';
end;//TkwPopWordInfoValueTypes.GetWordNameForRegister

function TkwPopWordInfoValueTypes.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_2DC3823CA5CC_var*
//#UC END# *551544E2001A_2DC3823CA5CC_var*
begin
//#UC START# *551544E2001A_2DC3823CA5CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_2DC3823CA5CC_impl*
end;//TkwPopWordInfoValueTypes.GetResultTypeInfo

function TkwPopWordInfoValueTypes.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordInfoValueTypes.GetAllParamsCount

function TkwPopWordInfoValueTypes.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_2DC3823CA5CC_var*
//#UC END# *5617F4D00243_2DC3823CA5CC_var*
begin
//#UC START# *5617F4D00243_2DC3823CA5CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_2DC3823CA5CC_impl*
end;//TkwPopWordInfoValueTypes.ParamsTypes

function TkwPopWordInfoIncludeLinkType.IncludeLinkType(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo;
 aLinkType: TtfwLinkType): TtfwWordInfo;
 {* Реализация слова скрипта pop:WordInfo:IncludeLinkType }
//#UC START# *883B22654478_ECDA96443339_var*
//#UC END# *883B22654478_ECDA96443339_var*
begin
//#UC START# *883B22654478_ECDA96443339_impl*
 !!! Needs to be implemented !!!
//#UC END# *883B22654478_ECDA96443339_impl*
end;//TkwPopWordInfoIncludeLinkType.IncludeLinkType

procedure TkwPopWordInfoIncludeLinkType.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_ECDA96443339_var*
//#UC END# *4DAEEDE10285_ECDA96443339_var*
begin
//#UC START# *4DAEEDE10285_ECDA96443339_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_ECDA96443339_impl*
end;//TkwPopWordInfoIncludeLinkType.DoDoIt

class function TkwPopWordInfoIncludeLinkType.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:IncludeLinkType';
end;//TkwPopWordInfoIncludeLinkType.GetWordNameForRegister

function TkwPopWordInfoIncludeLinkType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_ECDA96443339_var*
//#UC END# *551544E2001A_ECDA96443339_var*
begin
//#UC START# *551544E2001A_ECDA96443339_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_ECDA96443339_impl*
end;//TkwPopWordInfoIncludeLinkType.GetResultTypeInfo

function TkwPopWordInfoIncludeLinkType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordInfoIncludeLinkType.GetAllParamsCount

function TkwPopWordInfoIncludeLinkType.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_ECDA96443339_var*
//#UC END# *5617F4D00243_ECDA96443339_var*
begin
//#UC START# *5617F4D00243_ECDA96443339_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_ECDA96443339_impl*
end;//TkwPopWordInfoIncludeLinkType.ParamsTypes

function TkwPopWordInfoHasLinkType.HasLinkType(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo;
 aLinkType: TtfwLinkType): Boolean;
 {* Реализация слова скрипта pop:WordInfo:HasLinkType }
//#UC START# *C3E1AB4AA1BE_1B2BFB318FE4_var*
//#UC END# *C3E1AB4AA1BE_1B2BFB318FE4_var*
begin
//#UC START# *C3E1AB4AA1BE_1B2BFB318FE4_impl*
 Result := aWordInfo.Has(aLinkType);
//#UC END# *C3E1AB4AA1BE_1B2BFB318FE4_impl*
end;//TkwPopWordInfoHasLinkType.HasLinkType

procedure TkwPopWordInfoHasLinkType.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1B2BFB318FE4_var*
//#UC END# *4DAEEDE10285_1B2BFB318FE4_var*
begin
//#UC START# *4DAEEDE10285_1B2BFB318FE4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1B2BFB318FE4_impl*
end;//TkwPopWordInfoHasLinkType.DoDoIt

class function TkwPopWordInfoHasLinkType.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:HasLinkType';
end;//TkwPopWordInfoHasLinkType.GetWordNameForRegister

function TkwPopWordInfoHasLinkType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_1B2BFB318FE4_var*
//#UC END# *551544E2001A_1B2BFB318FE4_var*
begin
//#UC START# *551544E2001A_1B2BFB318FE4_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_1B2BFB318FE4_impl*
end;//TkwPopWordInfoHasLinkType.GetResultTypeInfo

function TkwPopWordInfoHasLinkType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordInfoHasLinkType.GetAllParamsCount

function TkwPopWordInfoHasLinkType.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_1B2BFB318FE4_var*
//#UC END# *5617F4D00243_1B2BFB318FE4_var*
begin
//#UC START# *5617F4D00243_1B2BFB318FE4_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_1B2BFB318FE4_impl*
end;//TkwPopWordInfoHasLinkType.ParamsTypes

function TkwPopWordInfoCompare.Compare(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo;
 anOther: TtfwWordInfo): Integer;
 {* Реализация слова скрипта pop:WordInfo:Compare }
//#UC START# *B3545BF94A1B_3A178A402C19_var*
//#UC END# *B3545BF94A1B_3A178A402C19_var*
begin
//#UC START# *B3545BF94A1B_3A178A402C19_impl*
 !!! Needs to be implemented !!!
//#UC END# *B3545BF94A1B_3A178A402C19_impl*
end;//TkwPopWordInfoCompare.Compare

procedure TkwPopWordInfoCompare.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3A178A402C19_var*
//#UC END# *4DAEEDE10285_3A178A402C19_var*
begin
//#UC START# *4DAEEDE10285_3A178A402C19_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3A178A402C19_impl*
end;//TkwPopWordInfoCompare.DoDoIt

class function TkwPopWordInfoCompare.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:Compare';
end;//TkwPopWordInfoCompare.GetWordNameForRegister

function TkwPopWordInfoCompare.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_3A178A402C19_var*
//#UC END# *551544E2001A_3A178A402C19_var*
begin
//#UC START# *551544E2001A_3A178A402C19_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_3A178A402C19_impl*
end;//TkwPopWordInfoCompare.GetResultTypeInfo

function TkwPopWordInfoCompare.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopWordInfoCompare.GetAllParamsCount

function TkwPopWordInfoCompare.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_3A178A402C19_var*
//#UC END# *5617F4D00243_3A178A402C19_var*
begin
//#UC START# *5617F4D00243_3A178A402C19_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_3A178A402C19_impl*
end;//TkwPopWordInfoCompare.ParamsTypes

function TkwPopWordInfoToString.ToString(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo): Il3CString;
 {* Реализация слова скрипта pop:WordInfo:ToString }
//#UC START# *370E27C51EFF_507247595622_var*
//#UC END# *370E27C51EFF_507247595622_var*
begin
//#UC START# *370E27C51EFF_507247595622_impl*
 !!! Needs to be implemented !!!
//#UC END# *370E27C51EFF_507247595622_impl*
end;//TkwPopWordInfoToString.ToString

procedure TkwPopWordInfoToString.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_507247595622_var*
//#UC END# *4DAEEDE10285_507247595622_var*
begin
//#UC START# *4DAEEDE10285_507247595622_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_507247595622_impl*
end;//TkwPopWordInfoToString.DoDoIt

class function TkwPopWordInfoToString.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:ToString';
end;//TkwPopWordInfoToString.GetWordNameForRegister

function TkwPopWordInfoToString.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_507247595622_var*
//#UC END# *551544E2001A_507247595622_var*
begin
//#UC START# *551544E2001A_507247595622_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_507247595622_impl*
end;//TkwPopWordInfoToString.GetResultTypeInfo

function TkwPopWordInfoToString.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordInfoToString.GetAllParamsCount

function TkwPopWordInfoToString.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_507247595622_var*
//#UC END# *5617F4D00243_507247595622_var*
begin
//#UC START# *5617F4D00243_507247595622_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_507247595622_impl*
end;//TkwPopWordInfoToString.ParamsTypes

function TkwPopWordInfoTypeName.TypeName(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo): Il3CString;
 {* Реализация слова скрипта pop:WordInfo:TypeName }
//#UC START# *21E60E61B55F_B1E1BB0DD574_var*
//#UC END# *21E60E61B55F_B1E1BB0DD574_var*
begin
//#UC START# *21E60E61B55F_B1E1BB0DD574_impl*
 !!! Needs to be implemented !!!
//#UC END# *21E60E61B55F_B1E1BB0DD574_impl*
end;//TkwPopWordInfoTypeName.TypeName

procedure TkwPopWordInfoTypeName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B1E1BB0DD574_var*
//#UC END# *4DAEEDE10285_B1E1BB0DD574_var*
begin
//#UC START# *4DAEEDE10285_B1E1BB0DD574_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B1E1BB0DD574_impl*
end;//TkwPopWordInfoTypeName.DoDoIt

class function TkwPopWordInfoTypeName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:TypeName';
end;//TkwPopWordInfoTypeName.GetWordNameForRegister

procedure TkwPopWordInfoTypeName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_B1E1BB0DD574_var*
//#UC END# *52D00B00031A_B1E1BB0DD574_var*
begin
//#UC START# *52D00B00031A_B1E1BB0DD574_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_B1E1BB0DD574_impl*
end;//TkwPopWordInfoTypeName.SetValuePrim

function TkwPopWordInfoTypeName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_B1E1BB0DD574_var*
//#UC END# *551544E2001A_B1E1BB0DD574_var*
begin
//#UC START# *551544E2001A_B1E1BB0DD574_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_B1E1BB0DD574_impl*
end;//TkwPopWordInfoTypeName.GetResultTypeInfo

function TkwPopWordInfoTypeName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordInfoTypeName.GetAllParamsCount

function TkwPopWordInfoTypeName.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_B1E1BB0DD574_var*
//#UC END# *5617F4D00243_B1E1BB0DD574_var*
begin
//#UC START# *5617F4D00243_B1E1BB0DD574_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_B1E1BB0DD574_impl*
end;//TkwPopWordInfoTypeName.ParamsTypes

function TkwPopWordInfoLinkType.LinkType(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo): TtfwLinkType;
 {* Реализация слова скрипта pop:WordInfo:LinkType }
//#UC START# *136782AFAE6C_CB22BA2EDEAC_var*
//#UC END# *136782AFAE6C_CB22BA2EDEAC_var*
begin
//#UC START# *136782AFAE6C_CB22BA2EDEAC_impl*
 !!! Needs to be implemented !!!
//#UC END# *136782AFAE6C_CB22BA2EDEAC_impl*
end;//TkwPopWordInfoLinkType.LinkType

procedure TkwPopWordInfoLinkType.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CB22BA2EDEAC_var*
//#UC END# *4DAEEDE10285_CB22BA2EDEAC_var*
begin
//#UC START# *4DAEEDE10285_CB22BA2EDEAC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CB22BA2EDEAC_impl*
end;//TkwPopWordInfoLinkType.DoDoIt

class function TkwPopWordInfoLinkType.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:LinkType';
end;//TkwPopWordInfoLinkType.GetWordNameForRegister

procedure TkwPopWordInfoLinkType.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_CB22BA2EDEAC_var*
//#UC END# *52D00B00031A_CB22BA2EDEAC_var*
begin
//#UC START# *52D00B00031A_CB22BA2EDEAC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_CB22BA2EDEAC_impl*
end;//TkwPopWordInfoLinkType.SetValuePrim

function TkwPopWordInfoLinkType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_CB22BA2EDEAC_var*
//#UC END# *551544E2001A_CB22BA2EDEAC_var*
begin
//#UC START# *551544E2001A_CB22BA2EDEAC_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_CB22BA2EDEAC_impl*
end;//TkwPopWordInfoLinkType.GetResultTypeInfo

function TkwPopWordInfoLinkType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordInfoLinkType.GetAllParamsCount

function TkwPopWordInfoLinkType.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_CB22BA2EDEAC_var*
//#UC END# *5617F4D00243_CB22BA2EDEAC_var*
begin
//#UC START# *5617F4D00243_CB22BA2EDEAC_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_CB22BA2EDEAC_impl*
end;//TkwPopWordInfoLinkType.ParamsTypes

function TkwPopWordInfoAccessType.AccessType(const aCtx: TtfwContext;
 aWordInfo: TtfwWordInfo): TtfwAccessType;
 {* Реализация слова скрипта pop:WordInfo:AccessType }
//#UC START# *4AA112FDE63E_4F04BAA3E2A4_var*
//#UC END# *4AA112FDE63E_4F04BAA3E2A4_var*
begin
//#UC START# *4AA112FDE63E_4F04BAA3E2A4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AA112FDE63E_4F04BAA3E2A4_impl*
end;//TkwPopWordInfoAccessType.AccessType

procedure TkwPopWordInfoAccessType.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F04BAA3E2A4_var*
//#UC END# *4DAEEDE10285_4F04BAA3E2A4_var*
begin
//#UC START# *4DAEEDE10285_4F04BAA3E2A4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4F04BAA3E2A4_impl*
end;//TkwPopWordInfoAccessType.DoDoIt

class function TkwPopWordInfoAccessType.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordInfo:AccessType';
end;//TkwPopWordInfoAccessType.GetWordNameForRegister

procedure TkwPopWordInfoAccessType.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_4F04BAA3E2A4_var*
//#UC END# *52D00B00031A_4F04BAA3E2A4_var*
begin
//#UC START# *52D00B00031A_4F04BAA3E2A4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_4F04BAA3E2A4_impl*
end;//TkwPopWordInfoAccessType.SetValuePrim

function TkwPopWordInfoAccessType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_4F04BAA3E2A4_var*
//#UC END# *551544E2001A_4F04BAA3E2A4_var*
begin
//#UC START# *551544E2001A_4F04BAA3E2A4_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_4F04BAA3E2A4_impl*
end;//TkwPopWordInfoAccessType.GetResultTypeInfo

function TkwPopWordInfoAccessType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordInfoAccessType.GetAllParamsCount

function TkwPopWordInfoAccessType.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_4F04BAA3E2A4_var*
//#UC END# *5617F4D00243_4F04BAA3E2A4_var*
begin
//#UC START# *5617F4D00243_4F04BAA3E2A4_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_4F04BAA3E2A4_impl*
end;//TkwPopWordInfoAccessType.ParamsTypes

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
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWordInfo));
 {* Регистрация типа TtfwWordInfo }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWordModifier));
 {* Регистрация типа TtfwWordModifier }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwValueType));
 {* Регистрация типа TtfwValueType }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwStackValue }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwAccessType));
 {* Регистрация типа TtfwAccessType }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwValueTypes));
 {* Регистрация типа TtfwValueTypes }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwLinkType));
 {* Регистрация типа TtfwLinkType }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
{$IfEnd} // NOT Defined(NoScripts)

end.
