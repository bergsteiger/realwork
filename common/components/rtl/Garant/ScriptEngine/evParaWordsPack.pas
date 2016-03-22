unit evParaWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\evParaWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "evParaWordsPack" MUID: (54EDDF9700B3)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3Variant
 , l3Types
 , l3Interfaces
 , k2Interfaces
 , nevTools
 , nevBase
 , k2Prim
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , evCustomEditorWindow
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
var l_aPara: InevPara;
var l_aTag: Integer;
begin
 try
  l_aPara := InevPara(aCtx.rEngine.PopIntf(InevPara));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPara: InevPara : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aTag := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTag: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(BoolA(aCtx, l_aPara, l_aTag));
end;//TkwParaBoolA.DoDoIt

function TkwParaBoolA.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwParaBoolA.GetResultTypeInfo

function TkwParaBoolA.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwParaBoolA.GetAllParamsCount

function TkwParaBoolA.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(InevPara), TypeInfo(Integer)]);
end;//TkwParaBoolA.ParamsTypes

class function TkwParaBoolA.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:BoolA';
end;//TkwParaBoolA.GetWordNameForRegister

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
var l_aPara: InevPara;
var l_anEditor: TevCustomEditorWindow;
var l_aValue: Boolean;
var l_aTag: Integer;
begin
 try
  l_aPara := InevPara(aCtx.rEngine.PopIntf(InevPara));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPara: InevPara : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anEditor := TevCustomEditorWindow(aCtx.rEngine.PopObjAs(TevCustomEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anEditor: TevCustomEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aTag := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTag: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 BoolW(aCtx, l_aPara, l_anEditor, l_aValue, l_aTag);
end;//TkwParaBoolW.DoDoIt

function TkwParaBoolW.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwParaBoolW.GetResultTypeInfo

function TkwParaBoolW.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 4;
end;//TkwParaBoolW.GetAllParamsCount

function TkwParaBoolW.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(InevPara), TypeInfo(TevCustomEditorWindow), TypeInfo(Boolean), TypeInfo(Integer)]);
end;//TkwParaBoolW.ParamsTypes

class function TkwParaBoolW.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:BoolW';
end;//TkwParaBoolW.GetWordNameForRegister

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
var l_aPara: InevPara;
begin
 try
  l_aPara := InevPara(aCtx.rEngine.PopIntf(InevPara));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPara: InevPara : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf(GetParent(aCtx, l_aPara), TypeInfo(InevPara));
end;//TkwParaGetParent.DoDoIt

function TkwParaGetParent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(InevPara);
end;//TkwParaGetParent.GetResultTypeInfo

function TkwParaGetParent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwParaGetParent.GetAllParamsCount

function TkwParaGetParent.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(InevPara)]);
end;//TkwParaGetParent.ParamsTypes

class function TkwParaGetParent.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:GetParent';
end;//TkwParaGetParent.GetWordNameForRegister

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
var l_aPara: InevPara;
begin
 try
  l_aPara := InevPara(aCtx.rEngine.PopIntf(InevPara));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPara: InevPara : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetType(aCtx, l_aPara));
end;//TkwParaGetType.DoDoIt

function TkwParaGetType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Tl3VariantDef);
end;//TkwParaGetType.GetResultTypeInfo

function TkwParaGetType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwParaGetType.GetAllParamsCount

function TkwParaGetType.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(InevPara)]);
end;//TkwParaGetType.ParamsTypes

class function TkwParaGetType.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:GetType';
end;//TkwParaGetType.GetWordNameForRegister

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
var l_aPara: InevPara;
var l_aTag: Integer;
begin
 try
  l_aPara := InevPara(aCtx.rEngine.PopIntf(InevPara));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPara: InevPara : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aTag := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTag: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(IntA(aCtx, l_aPara, l_aTag));
end;//TkwParaIntA.DoDoIt

function TkwParaIntA.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwParaIntA.GetResultTypeInfo

function TkwParaIntA.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwParaIntA.GetAllParamsCount

function TkwParaIntA.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(InevPara), TypeInfo(Integer)]);
end;//TkwParaIntA.ParamsTypes

class function TkwParaIntA.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:IntA';
end;//TkwParaIntA.GetWordNameForRegister

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
var l_aPara: InevPara;
var l_anEditor: TevCustomEditorWindow;
var l_aValue: Integer;
var l_aTag: Integer;
begin
 try
  l_aPara := InevPara(aCtx.rEngine.PopIntf(InevPara));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPara: InevPara : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anEditor := TevCustomEditorWindow(aCtx.rEngine.PopObjAs(TevCustomEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anEditor: TevCustomEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aTag := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTag: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 IntW(aCtx, l_aPara, l_anEditor, l_aValue, l_aTag);
end;//TkwParaIntW.DoDoIt

function TkwParaIntW.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwParaIntW.GetResultTypeInfo

function TkwParaIntW.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 4;
end;//TkwParaIntW.GetAllParamsCount

function TkwParaIntW.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(InevPara), TypeInfo(TevCustomEditorWindow), TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwParaIntW.ParamsTypes

class function TkwParaIntW.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:IntW';
end;//TkwParaIntW.GetWordNameForRegister

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
var l_aPara: InevPara;
var l_anOther: InevPara;
begin
 try
  l_aPara := InevPara(aCtx.rEngine.PopIntf(InevPara));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPara: InevPara : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOther := InevPara(aCtx.rEngine.PopIntf(InevPara));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anOther: InevPara : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsSame(aCtx, l_aPara, l_anOther));
end;//TkwParaIsSame.DoDoIt

function TkwParaIsSame.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwParaIsSame.GetResultTypeInfo

function TkwParaIsSame.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwParaIsSame.GetAllParamsCount

function TkwParaIsSame.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(InevPara), TypeInfo(InevPara)]);
end;//TkwParaIsSame.ParamsTypes

class function TkwParaIsSame.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:IsSame';
end;//TkwParaIsSame.GetWordNameForRegister

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
var l_aPara: InevPara;
var l_aTag: Integer;
begin
 try
  l_aPara := InevPara(aCtx.rEngine.PopIntf(InevPara));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPara: InevPara : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aTag := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTag: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(StrA(aCtx, l_aPara, l_aTag));
end;//TkwParaStrA.DoDoIt

function TkwParaStrA.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwParaStrA.GetResultTypeInfo

function TkwParaStrA.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwParaStrA.GetAllParamsCount

function TkwParaStrA.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(InevPara), TypeInfo(Integer)]);
end;//TkwParaStrA.ParamsTypes

class function TkwParaStrA.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:StrA';
end;//TkwParaStrA.GetWordNameForRegister

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
var l_aPara: InevPara;
begin
 try
  l_aPara := InevPara(aCtx.rEngine.PopIntf(InevPara));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPara: InevPara : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(StyleName(aCtx, l_aPara));
end;//TkwParaStyleName.DoDoIt

function TkwParaStyleName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwParaStyleName.GetResultTypeInfo

function TkwParaStyleName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwParaStyleName.GetAllParamsCount

function TkwParaStyleName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(InevPara)]);
end;//TkwParaStyleName.ParamsTypes

class function TkwParaStyleName.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:StyleName';
end;//TkwParaStyleName.GetWordNameForRegister

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
var l_aPara: InevPara;
begin
 try
  l_aPara := InevPara(aCtx.rEngine.PopIntf(InevPara));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPara: InevPara : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(Text(aCtx, l_aPara));
end;//TkwParaText.DoDoIt

function TkwParaText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwParaText.GetResultTypeInfo

function TkwParaText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwParaText.GetAllParamsCount

function TkwParaText.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(InevPara)]);
end;//TkwParaText.ParamsTypes

class function TkwParaText.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:Text';
end;//TkwParaText.GetWordNameForRegister

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
var l_aPara: InevPara;
var l_aTypeID: Integer;
begin
 try
  l_aPara := InevPara(aCtx.rEngine.PopIntf(InevPara));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPara: InevPara : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aTypeID := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTypeID: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(Type_Inherits(aCtx, l_aPara, l_aTypeID));
end;//TkwParaTypeInherits.DoDoIt

function TkwParaTypeInherits.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwParaTypeInherits.GetResultTypeInfo

function TkwParaTypeInherits.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwParaTypeInherits.GetAllParamsCount

function TkwParaTypeInherits.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(InevPara), TypeInfo(Integer)]);
end;//TkwParaTypeInherits.ParamsTypes

class function TkwParaTypeInherits.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:Type:Inherits';
end;//TkwParaTypeInherits.GetWordNameForRegister

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
