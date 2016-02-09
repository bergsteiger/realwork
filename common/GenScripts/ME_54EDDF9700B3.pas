unit evParaWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\evParaWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , nevTools
 , l3Variant
 , l3Interfaces
 , evCustomEditorWindow
 , l3Types
 , k2Interfaces
 , nevBase
 , k2Prim
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , k2Tags
 , l3Base
 , l3String
 , k2OpMisc
 , k2Facade
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 //#UC START# *B6DC8B9D2ADEci*
 //#UC END# *B6DC8B9D2ADEci*
 //#UC START# *B6DC8B9D2ADEcit*
 //#UC END# *B6DC8B9D2ADEcit*
 TevParaWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 //#UC START# *B6DC8B9D2ADEpubl*
 //#UC END# *B6DC8B9D2ADEpubl*
 end;//TevParaWordsPackResNameGetter

 TkwParaBoolA = {final} class(TtfwClassLike)
  {* Слово скрипта Para:BoolA
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTag aPara Para:BoolA >>> l_Boolean
[code]  }
  private
   function BoolA(const aCtx: TtfwContext;
    const aPara: InevPara;
    aTag: Integer): Boolean;
    {* Реализация слова скрипта Para:BoolA }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwParaBoolA

 TkwParaBoolW = {final} class(TtfwClassLike)
  {* Слово скрипта Para:BoolW
*Пример:*
[code]
 aTag aValue anEditor aPara Para:BoolW
[code]  }
  private
   procedure BoolW(const aCtx: TtfwContext;
    const aPara: InevPara;
    anEditor: TevCustomEditorWindow;
    aValue: Boolean;
    aTag: Integer);
    {* Реализация слова скрипта Para:BoolW }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwParaBoolW

 TkwParaGetParent = {final} class(TtfwClassLike)
  {* Слово скрипта Para:GetParent
*Тип результата:* InevPara
*Пример:*
[code]
INTERFACE VAR l_InevPara
 aPara Para:GetParent >>> l_InevPara
[code]  }
  private
   function GetParent(const aCtx: TtfwContext;
    const aPara: InevPara): InevPara;
    {* Реализация слова скрипта Para:GetParent }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwParaGetParent

 TkwParaGetType = {final} class(TtfwClassLike)
  {* Слово скрипта Para:GetType
*Тип результата:* Tl3VariantDef
*Пример:*
[code]
OBJECT VAR l_Tl3VariantDef
 aPara Para:GetType >>> l_Tl3VariantDef
[code]  }
  private
   function GetType(const aCtx: TtfwContext;
    const aPara: InevPara): Tl3VariantDef;
    {* Реализация слова скрипта Para:GetType }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwParaGetType

 TkwParaIntA = {final} class(TtfwClassLike)
  {* Слово скрипта Para:IntA
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aTag aPara Para:IntA >>> l_Integer
[code]  }
  private
   function IntA(const aCtx: TtfwContext;
    const aPara: InevPara;
    aTag: Integer): Integer;
    {* Реализация слова скрипта Para:IntA }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwParaIntA

 TkwParaIntW = {final} class(TtfwClassLike)
  {* Слово скрипта Para:IntW
*Пример:*
[code]
 aTag aValue anEditor aPara Para:IntW
[code]  }
  private
   procedure IntW(const aCtx: TtfwContext;
    const aPara: InevPara;
    anEditor: TevCustomEditorWindow;
    aValue: Integer;
    aTag: Integer);
    {* Реализация слова скрипта Para:IntW }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwParaIntW

 TkwParaIsSame = {final} class(TtfwClassLike)
  {* Слово скрипта Para:IsSame
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 anOther aPara Para:IsSame >>> l_Boolean
[code]  }
  private
   function IsSame(const aCtx: TtfwContext;
    const aPara: InevPara;
    const anOther: InevPara): Boolean;
    {* Реализация слова скрипта Para:IsSame }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwParaIsSame

 TkwParaStrA = {final} class(TtfwClassLike)
  {* Слово скрипта Para:StrA
*Тип результата:* Tl3WString
*Пример:*
[code]
STRING VAR l_Tl3WString
 aTag aPara Para:StrA >>> l_Tl3WString
[code]  }
  private
   function StrA(const aCtx: TtfwContext;
    const aPara: InevPara;
    aTag: Integer): Tl3WString;
    {* Реализация слова скрипта Para:StrA }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwParaStrA

 TkwParaStyleName = {final} class(TtfwClassLike)
  {* Слово скрипта Para:StyleName
*Тип результата:* Tl3WString
*Пример:*
[code]
STRING VAR l_Tl3WString
 aPara Para:StyleName >>> l_Tl3WString
[code]  }
  private
   function StyleName(const aCtx: TtfwContext;
    const aPara: InevPara): Tl3WString;
    {* Реализация слова скрипта Para:StyleName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwParaStyleName

 TkwParaText = {final} class(TtfwClassLike)
  {* Слово скрипта Para:Text
*Тип результата:* Tl3WString
*Пример:*
[code]
STRING VAR l_Tl3WString
 aPara Para:Text >>> l_Tl3WString
[code]  }
  private
   function Text(const aCtx: TtfwContext;
    const aPara: InevPara): Tl3WString;
    {* Реализация слова скрипта Para:Text }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwParaText

 TkwParaTypeInherits = {final} class(TtfwClassLike)
  {* Слово скрипта Para:Type:Inherits
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTypeID aPara Para:Type:Inherits >>> l_Boolean
[code]  }
  private
   function Type_Inherits(const aCtx: TtfwContext;
    const aPara: InevPara;
    aTypeID: Integer): Boolean;
    {* Реализация слова скрипта Para:Type:Inherits }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwParaTypeInherits

class function TevParaWordsPackResNameGetter.ResName: AnsiString;
begin
  Result := 'evParaWordsPack';
end;//TevParaWordsPackResNameGetter.ResName

 {$R evParaWordsPack.res}

function TkwParaBoolA.BoolA(const aCtx: TtfwContext;
 const aPara: InevPara;
 aTag: Integer): Boolean;
 {* Реализация слова скрипта Para:BoolA }
//#UC START# *813358A7CF85_73A41501B720_var*
//#UC END# *813358A7CF85_73A41501B720_var*
begin
//#UC START# *813358A7CF85_73A41501B720_impl*
 Result := aPara.AsObject.BoolA[aTag];
//#UC END# *813358A7CF85_73A41501B720_impl*
end;//TkwParaBoolA.BoolA

procedure TkwParaBoolA.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_73A41501B720_var*
//#UC END# *4DAEEDE10285_73A41501B720_var*
begin
//#UC START# *4DAEEDE10285_73A41501B720_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_73A41501B720_impl*
end;//TkwParaBoolA.DoDoIt

class function TkwParaBoolA.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:BoolA';
end;//TkwParaBoolA.GetWordNameForRegister

function TkwParaBoolA.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_73A41501B720_var*
//#UC END# *551544E2001A_73A41501B720_var*
begin
//#UC START# *551544E2001A_73A41501B720_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_73A41501B720_impl*
end;//TkwParaBoolA.GetResultTypeInfo

function TkwParaBoolA.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwParaBoolA.GetAllParamsCount

function TkwParaBoolA.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_73A41501B720_var*
//#UC END# *5617F4D00243_73A41501B720_var*
begin
//#UC START# *5617F4D00243_73A41501B720_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_73A41501B720_impl*
end;//TkwParaBoolA.ParamsTypes

procedure TkwParaBoolW.BoolW(const aCtx: TtfwContext;
 const aPara: InevPara;
 anEditor: TevCustomEditorWindow;
 aValue: Boolean;
 aTag: Integer);
 {* Реализация слова скрипта Para:BoolW }
//#UC START# *FA63F0F0EFEE_7DB044DC9B24_var*
//#UC END# *FA63F0F0EFEE_7DB044DC9B24_var*
begin
//#UC START# *FA63F0F0EFEE_7DB044DC9B24_impl*
 aPara.AsObject.BoolW[aTag, k2StartOp(anEditor.View.Processor)] := aValue;
//#UC END# *FA63F0F0EFEE_7DB044DC9B24_impl*
end;//TkwParaBoolW.BoolW

procedure TkwParaBoolW.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7DB044DC9B24_var*
//#UC END# *4DAEEDE10285_7DB044DC9B24_var*
begin
//#UC START# *4DAEEDE10285_7DB044DC9B24_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7DB044DC9B24_impl*
end;//TkwParaBoolW.DoDoIt

class function TkwParaBoolW.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:BoolW';
end;//TkwParaBoolW.GetWordNameForRegister

function TkwParaBoolW.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_7DB044DC9B24_var*
//#UC END# *551544E2001A_7DB044DC9B24_var*
begin
//#UC START# *551544E2001A_7DB044DC9B24_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_7DB044DC9B24_impl*
end;//TkwParaBoolW.GetResultTypeInfo

function TkwParaBoolW.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 4;
end;//TkwParaBoolW.GetAllParamsCount

function TkwParaBoolW.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_7DB044DC9B24_var*
//#UC END# *5617F4D00243_7DB044DC9B24_var*
begin
//#UC START# *5617F4D00243_7DB044DC9B24_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_7DB044DC9B24_impl*
end;//TkwParaBoolW.ParamsTypes

function TkwParaGetParent.GetParent(const aCtx: TtfwContext;
 const aPara: InevPara): InevPara;
 {* Реализация слова скрипта Para:GetParent }
//#UC START# *CDCE3FA90D6B_8E4CB03D8918_var*
//#UC END# *CDCE3FA90D6B_8E4CB03D8918_var*
begin
//#UC START# *CDCE3FA90D6B_8E4CB03D8918_impl*
 Result := aPara.OwnerObj.AsPara;
//#UC END# *CDCE3FA90D6B_8E4CB03D8918_impl*
end;//TkwParaGetParent.GetParent

procedure TkwParaGetParent.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8E4CB03D8918_var*
//#UC END# *4DAEEDE10285_8E4CB03D8918_var*
begin
//#UC START# *4DAEEDE10285_8E4CB03D8918_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8E4CB03D8918_impl*
end;//TkwParaGetParent.DoDoIt

class function TkwParaGetParent.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:GetParent';
end;//TkwParaGetParent.GetWordNameForRegister

function TkwParaGetParent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_8E4CB03D8918_var*
//#UC END# *551544E2001A_8E4CB03D8918_var*
begin
//#UC START# *551544E2001A_8E4CB03D8918_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_8E4CB03D8918_impl*
end;//TkwParaGetParent.GetResultTypeInfo

function TkwParaGetParent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwParaGetParent.GetAllParamsCount

function TkwParaGetParent.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_8E4CB03D8918_var*
//#UC END# *5617F4D00243_8E4CB03D8918_var*
begin
//#UC START# *5617F4D00243_8E4CB03D8918_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_8E4CB03D8918_impl*
end;//TkwParaGetParent.ParamsTypes

function TkwParaGetType.GetType(const aCtx: TtfwContext;
 const aPara: InevPara): Tl3VariantDef;
 {* Реализация слова скрипта Para:GetType }
//#UC START# *45DC1815EB7A_1F1556695E5E_var*
//#UC END# *45DC1815EB7A_1F1556695E5E_var*
begin
//#UC START# *45DC1815EB7A_1F1556695E5E_impl*
 Result := aPara.AsObject.TagType;
//#UC END# *45DC1815EB7A_1F1556695E5E_impl*
end;//TkwParaGetType.GetType

procedure TkwParaGetType.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1F1556695E5E_var*
//#UC END# *4DAEEDE10285_1F1556695E5E_var*
begin
//#UC START# *4DAEEDE10285_1F1556695E5E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1F1556695E5E_impl*
end;//TkwParaGetType.DoDoIt

class function TkwParaGetType.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:GetType';
end;//TkwParaGetType.GetWordNameForRegister

function TkwParaGetType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_1F1556695E5E_var*
//#UC END# *551544E2001A_1F1556695E5E_var*
begin
//#UC START# *551544E2001A_1F1556695E5E_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_1F1556695E5E_impl*
end;//TkwParaGetType.GetResultTypeInfo

function TkwParaGetType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwParaGetType.GetAllParamsCount

function TkwParaGetType.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_1F1556695E5E_var*
//#UC END# *5617F4D00243_1F1556695E5E_var*
begin
//#UC START# *5617F4D00243_1F1556695E5E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_1F1556695E5E_impl*
end;//TkwParaGetType.ParamsTypes

function TkwParaIntA.IntA(const aCtx: TtfwContext;
 const aPara: InevPara;
 aTag: Integer): Integer;
 {* Реализация слова скрипта Para:IntA }
//#UC START# *F1D0FBBB4A2A_87CE9706F506_var*
//#UC END# *F1D0FBBB4A2A_87CE9706F506_var*
begin
//#UC START# *F1D0FBBB4A2A_87CE9706F506_impl*
 Result := aPara.AsObject.IntA[aTag];
//#UC END# *F1D0FBBB4A2A_87CE9706F506_impl*
end;//TkwParaIntA.IntA

procedure TkwParaIntA.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_87CE9706F506_var*
//#UC END# *4DAEEDE10285_87CE9706F506_var*
begin
//#UC START# *4DAEEDE10285_87CE9706F506_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_87CE9706F506_impl*
end;//TkwParaIntA.DoDoIt

class function TkwParaIntA.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:IntA';
end;//TkwParaIntA.GetWordNameForRegister

function TkwParaIntA.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_87CE9706F506_var*
//#UC END# *551544E2001A_87CE9706F506_var*
begin
//#UC START# *551544E2001A_87CE9706F506_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_87CE9706F506_impl*
end;//TkwParaIntA.GetResultTypeInfo

function TkwParaIntA.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwParaIntA.GetAllParamsCount

function TkwParaIntA.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_87CE9706F506_var*
//#UC END# *5617F4D00243_87CE9706F506_var*
begin
//#UC START# *5617F4D00243_87CE9706F506_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_87CE9706F506_impl*
end;//TkwParaIntA.ParamsTypes

procedure TkwParaIntW.IntW(const aCtx: TtfwContext;
 const aPara: InevPara;
 anEditor: TevCustomEditorWindow;
 aValue: Integer;
 aTag: Integer);
 {* Реализация слова скрипта Para:IntW }
//#UC START# *79467BAD33FB_9C157259C948_var*
//#UC END# *79467BAD33FB_9C157259C948_var*
begin
//#UC START# *79467BAD33FB_9C157259C948_impl*
 aPara.AsObject.IntW[aTag, k2StartOp(anEditor.View.Processor)] := aValue;
//#UC END# *79467BAD33FB_9C157259C948_impl*
end;//TkwParaIntW.IntW

procedure TkwParaIntW.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9C157259C948_var*
//#UC END# *4DAEEDE10285_9C157259C948_var*
begin
//#UC START# *4DAEEDE10285_9C157259C948_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9C157259C948_impl*
end;//TkwParaIntW.DoDoIt

class function TkwParaIntW.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:IntW';
end;//TkwParaIntW.GetWordNameForRegister

function TkwParaIntW.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_9C157259C948_var*
//#UC END# *551544E2001A_9C157259C948_var*
begin
//#UC START# *551544E2001A_9C157259C948_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_9C157259C948_impl*
end;//TkwParaIntW.GetResultTypeInfo

function TkwParaIntW.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 4;
end;//TkwParaIntW.GetAllParamsCount

function TkwParaIntW.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_9C157259C948_var*
//#UC END# *5617F4D00243_9C157259C948_var*
begin
//#UC START# *5617F4D00243_9C157259C948_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_9C157259C948_impl*
end;//TkwParaIntW.ParamsTypes

function TkwParaIsSame.IsSame(const aCtx: TtfwContext;
 const aPara: InevPara;
 const anOther: InevPara): Boolean;
 {* Реализация слова скрипта Para:IsSame }
//#UC START# *135EE191EC2B_FD4CFCA9A1DA_var*
//#UC END# *135EE191EC2B_FD4CFCA9A1DA_var*
begin
//#UC START# *135EE191EC2B_FD4CFCA9A1DA_impl*
 Result := anOther.AsObject.IsSame(aPara.AsObject);
//#UC END# *135EE191EC2B_FD4CFCA9A1DA_impl*
end;//TkwParaIsSame.IsSame

procedure TkwParaIsSame.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FD4CFCA9A1DA_var*
//#UC END# *4DAEEDE10285_FD4CFCA9A1DA_var*
begin
//#UC START# *4DAEEDE10285_FD4CFCA9A1DA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FD4CFCA9A1DA_impl*
end;//TkwParaIsSame.DoDoIt

class function TkwParaIsSame.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:IsSame';
end;//TkwParaIsSame.GetWordNameForRegister

function TkwParaIsSame.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_FD4CFCA9A1DA_var*
//#UC END# *551544E2001A_FD4CFCA9A1DA_var*
begin
//#UC START# *551544E2001A_FD4CFCA9A1DA_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_FD4CFCA9A1DA_impl*
end;//TkwParaIsSame.GetResultTypeInfo

function TkwParaIsSame.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwParaIsSame.GetAllParamsCount

function TkwParaIsSame.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_FD4CFCA9A1DA_var*
//#UC END# *5617F4D00243_FD4CFCA9A1DA_var*
begin
//#UC START# *5617F4D00243_FD4CFCA9A1DA_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_FD4CFCA9A1DA_impl*
end;//TkwParaIsSame.ParamsTypes

function TkwParaStrA.StrA(const aCtx: TtfwContext;
 const aPara: InevPara;
 aTag: Integer): Tl3WString;
 {* Реализация слова скрипта Para:StrA }
//#UC START# *B475DB5CB51E_A38F9F2F9E00_var*
//#UC END# *B475DB5CB51E_A38F9F2F9E00_var*
begin
//#UC START# *B475DB5CB51E_A38F9F2F9E00_impl*
 Result := aPara.AsObject.PCharLenA[aTag];
//#UC END# *B475DB5CB51E_A38F9F2F9E00_impl*
end;//TkwParaStrA.StrA

procedure TkwParaStrA.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A38F9F2F9E00_var*
//#UC END# *4DAEEDE10285_A38F9F2F9E00_var*
begin
//#UC START# *4DAEEDE10285_A38F9F2F9E00_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A38F9F2F9E00_impl*
end;//TkwParaStrA.DoDoIt

class function TkwParaStrA.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:StrA';
end;//TkwParaStrA.GetWordNameForRegister

function TkwParaStrA.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_A38F9F2F9E00_var*
//#UC END# *551544E2001A_A38F9F2F9E00_var*
begin
//#UC START# *551544E2001A_A38F9F2F9E00_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_A38F9F2F9E00_impl*
end;//TkwParaStrA.GetResultTypeInfo

function TkwParaStrA.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwParaStrA.GetAllParamsCount

function TkwParaStrA.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_A38F9F2F9E00_var*
//#UC END# *5617F4D00243_A38F9F2F9E00_var*
begin
//#UC START# *5617F4D00243_A38F9F2F9E00_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_A38F9F2F9E00_impl*
end;//TkwParaStrA.ParamsTypes

function TkwParaStyleName.StyleName(const aCtx: TtfwContext;
 const aPara: InevPara): Tl3WString;
 {* Реализация слова скрипта Para:StyleName }
//#UC START# *6DC250CE244B_6834305B1C71_var*
//#UC END# *6DC250CE244B_6834305B1C71_var*
begin
//#UC START# *6DC250CE244B_6834305B1C71_impl*
 Result := aPara.AsObject.PCharLenA[k2_tiStyle];
//#UC END# *6DC250CE244B_6834305B1C71_impl*
end;//TkwParaStyleName.StyleName

procedure TkwParaStyleName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6834305B1C71_var*
//#UC END# *4DAEEDE10285_6834305B1C71_var*
begin
//#UC START# *4DAEEDE10285_6834305B1C71_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6834305B1C71_impl*
end;//TkwParaStyleName.DoDoIt

class function TkwParaStyleName.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:StyleName';
end;//TkwParaStyleName.GetWordNameForRegister

function TkwParaStyleName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_6834305B1C71_var*
//#UC END# *551544E2001A_6834305B1C71_var*
begin
//#UC START# *551544E2001A_6834305B1C71_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_6834305B1C71_impl*
end;//TkwParaStyleName.GetResultTypeInfo

function TkwParaStyleName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwParaStyleName.GetAllParamsCount

function TkwParaStyleName.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_6834305B1C71_var*
//#UC END# *5617F4D00243_6834305B1C71_var*
begin
//#UC START# *5617F4D00243_6834305B1C71_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_6834305B1C71_impl*
end;//TkwParaStyleName.ParamsTypes

function TkwParaText.Text(const aCtx: TtfwContext;
 const aPara: InevPara): Tl3WString;
 {* Реализация слова скрипта Para:Text }
//#UC START# *AF0DB87C1E22_742EC299532F_var*
//#UC END# *AF0DB87C1E22_742EC299532F_var*
begin
//#UC START# *AF0DB87C1E22_742EC299532F_impl*
 Result := aPara.AsObject.PCharLenA[k2_tiText];
//#UC END# *AF0DB87C1E22_742EC299532F_impl*
end;//TkwParaText.Text

procedure TkwParaText.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_742EC299532F_var*
//#UC END# *4DAEEDE10285_742EC299532F_var*
begin
//#UC START# *4DAEEDE10285_742EC299532F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_742EC299532F_impl*
end;//TkwParaText.DoDoIt

class function TkwParaText.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:Text';
end;//TkwParaText.GetWordNameForRegister

function TkwParaText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_742EC299532F_var*
//#UC END# *551544E2001A_742EC299532F_var*
begin
//#UC START# *551544E2001A_742EC299532F_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_742EC299532F_impl*
end;//TkwParaText.GetResultTypeInfo

function TkwParaText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwParaText.GetAllParamsCount

function TkwParaText.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_742EC299532F_var*
//#UC END# *5617F4D00243_742EC299532F_var*
begin
//#UC START# *5617F4D00243_742EC299532F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_742EC299532F_impl*
end;//TkwParaText.ParamsTypes

function TkwParaTypeInherits.Type_Inherits(const aCtx: TtfwContext;
 const aPara: InevPara;
 aTypeID: Integer): Boolean;
 {* Реализация слова скрипта Para:Type:Inherits }
//#UC START# *E7A7AF07EE52_E16D3A553EA8_var*
//#UC END# *E7A7AF07EE52_E16D3A553EA8_var*
begin
//#UC START# *E7A7AF07EE52_E16D3A553EA8_impl*
 Result := aPara.AsObject.IsKindOf(k2.TypeTable.TypeByHandle[aTypeID]);
//#UC END# *E7A7AF07EE52_E16D3A553EA8_impl*
end;//TkwParaTypeInherits.Type_Inherits

procedure TkwParaTypeInherits.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E16D3A553EA8_var*
//#UC END# *4DAEEDE10285_E16D3A553EA8_var*
begin
//#UC START# *4DAEEDE10285_E16D3A553EA8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E16D3A553EA8_impl*
end;//TkwParaTypeInherits.DoDoIt

class function TkwParaTypeInherits.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:Type:Inherits';
end;//TkwParaTypeInherits.GetWordNameForRegister

function TkwParaTypeInherits.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_E16D3A553EA8_var*
//#UC END# *551544E2001A_E16D3A553EA8_var*
begin
//#UC START# *551544E2001A_E16D3A553EA8_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_E16D3A553EA8_impl*
end;//TkwParaTypeInherits.GetResultTypeInfo

function TkwParaTypeInherits.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwParaTypeInherits.GetAllParamsCount

function TkwParaTypeInherits.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_E16D3A553EA8_var*
//#UC END# *5617F4D00243_E16D3A553EA8_var*
begin
//#UC START# *5617F4D00243_E16D3A553EA8_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E16D3A553EA8_impl*
end;//TkwParaTypeInherits.ParamsTypes

initialization
 TevParaWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TkwParaBoolA.RegisterInEngine;
 {* Регистрация Para_BoolA }
 TkwParaBoolW.RegisterInEngine;
 {* Регистрация Para_BoolW }
 TkwParaGetParent.RegisterInEngine;
 {* Регистрация Para_GetParent }
 TkwParaGetType.RegisterInEngine;
 {* Регистрация Para_GetType }
 TkwParaIntA.RegisterInEngine;
 {* Регистрация Para_IntA }
 TkwParaIntW.RegisterInEngine;
 {* Регистрация Para_IntW }
 TkwParaIsSame.RegisterInEngine;
 {* Регистрация Para_IsSame }
 TkwParaStrA.RegisterInEngine;
 {* Регистрация Para_StrA }
 TkwParaStyleName.RegisterInEngine;
 {* Регистрация Para_StyleName }
 TkwParaText.RegisterInEngine;
 {* Регистрация Para_Text }
 TkwParaTypeInherits.RegisterInEngine;
 {* Регистрация Para_Type_Inherits }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(InevPara));
 {* Регистрация типа InevPara }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevCustomEditorWindow));
 {* Регистрация типа TevCustomEditorWindow }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Tl3VariantDef));
 {* Регистрация типа Tl3VariantDef }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Tl3WString }
{$IfEnd} // NOT Defined(NoScripts)

end.
