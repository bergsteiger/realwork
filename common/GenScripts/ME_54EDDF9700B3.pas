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
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , evCustomEditorWindow
 , tfwAxiomaticsResNameGetter
 , k2Tags
 , l3Base
 , l3String
 , k2OpMisc
 , k2Facade
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwParaBoolA = {final} class(TtfwClassLike)
  {* Слово скрипта Para:BoolA }
  private
   function BoolA(const aCtx: TtfwContext;
    const aPara: InevPara;
    aTag: Integer): Boolean;
    {* Реализация слова скрипта Para:BoolA }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwParaBoolA

 TkwParaBoolW = {final} class(TtfwClassLike)
  {* Слово скрипта Para:BoolW }
  private
   procedure BoolW(const aCtx: TtfwContext;
    const aPara: InevPara;
    anEditor: TevCustomEditorWindow;
    aValue: Boolean;
    aTag: Integer);
    {* Реализация слова скрипта Para:BoolW }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwParaBoolW

 TkwParaGetParent = {final} class(TtfwClassLike)
  {* Слово скрипта Para:GetParent }
  private
   function GetParent(const aCtx: TtfwContext;
    const aPara: InevPara): InevPara;
    {* Реализация слова скрипта Para:GetParent }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwParaGetParent

 TkwParaGetType = {final} class(TtfwClassLike)
  {* Слово скрипта Para:GetType }
  private
   function GetType(const aCtx: TtfwContext;
    const aPara: InevPara): Tl3VariantDef;
    {* Реализация слова скрипта Para:GetType }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwParaGetType

 TkwParaIntA = {final} class(TtfwClassLike)
  {* Слово скрипта Para:IntA }
  private
   function IntA(const aCtx: TtfwContext;
    const aPara: InevPara;
    aTag: Integer): Integer;
    {* Реализация слова скрипта Para:IntA }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwParaIntA

 TkwParaIntW = {final} class(TtfwClassLike)
  {* Слово скрипта Para:IntW }
  private
   procedure IntW(const aCtx: TtfwContext;
    const aPara: InevPara;
    anEditor: TevCustomEditorWindow;
    aValue: Integer;
    aTag: Integer);
    {* Реализация слова скрипта Para:IntW }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwParaIntW

 TkwParaIsSame = {final} class(TtfwClassLike)
  {* Слово скрипта Para:IsSame }
  private
   function IsSame(const aCtx: TtfwContext;
    const aPara: InevPara;
    const anOther: InevPara): Boolean;
    {* Реализация слова скрипта Para:IsSame }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwParaIsSame

 TkwParaStrA = {final} class(TtfwClassLike)
  {* Слово скрипта Para:StrA }
  private
   function StrA(const aCtx: TtfwContext;
    const aPara: InevPara;
    aTag: Integer): Tl3WString;
    {* Реализация слова скрипта Para:StrA }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwParaStrA

 TkwParaStyleName = {final} class(TtfwClassLike)
  {* Слово скрипта Para:StyleName }
  private
   function StyleName(const aCtx: TtfwContext;
    const aPara: InevPara): Tl3WString;
    {* Реализация слова скрипта Para:StyleName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwParaStyleName

 TkwParaText = {final} class(TtfwClassLike)
  {* Слово скрипта Para:Text }
  private
   function Text(const aCtx: TtfwContext;
    const aPara: InevPara): Tl3WString;
    {* Реализация слова скрипта Para:Text }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwParaText

 TkwParaTypeInherits = {final} class(TtfwClassLike)
  {* Слово скрипта Para:Type:Inherits }
  private
   function Type_Inherits(const aCtx: TtfwContext;
    const aPara: InevPara;
    aTypeID: Integer): Boolean;
    {* Реализация слова скрипта Para:Type:Inherits }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwParaTypeInherits

 TevParaWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TevParaWordsPackResNameGetter

function TkwParaBoolA.BoolA(const aCtx: TtfwContext;
 const aPara: InevPara;
 aTag: Integer): Boolean;
 {* Реализация слова скрипта Para:BoolA }
//#UC START# *5530ED2E028D_5530ED2E028D_47C520D80305_Word_var*
//#UC END# *5530ED2E028D_5530ED2E028D_47C520D80305_Word_var*
begin
//#UC START# *5530ED2E028D_5530ED2E028D_47C520D80305_Word_impl*
 Result := aPara.AsObject.BoolA[aTag];
//#UC END# *5530ED2E028D_5530ED2E028D_47C520D80305_Word_impl*
end;//TkwParaBoolA.BoolA

class function TkwParaBoolA.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:BoolA';
end;//TkwParaBoolA.GetWordNameForRegister

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

procedure TkwParaBoolW.BoolW(const aCtx: TtfwContext;
 const aPara: InevPara;
 anEditor: TevCustomEditorWindow;
 aValue: Boolean;
 aTag: Integer);
 {* Реализация слова скрипта Para:BoolW }
//#UC START# *5530ED5401C7_5530ED5401C7_47C520D80305_Word_var*
//#UC END# *5530ED5401C7_5530ED5401C7_47C520D80305_Word_var*
begin
//#UC START# *5530ED5401C7_5530ED5401C7_47C520D80305_Word_impl*
 aPara.AsObject.BoolW[aTag, k2StartOp(anEditor.View.Processor)] := aValue;
//#UC END# *5530ED5401C7_5530ED5401C7_47C520D80305_Word_impl*
end;//TkwParaBoolW.BoolW

class function TkwParaBoolW.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:BoolW';
end;//TkwParaBoolW.GetWordNameForRegister

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

function TkwParaGetParent.GetParent(const aCtx: TtfwContext;
 const aPara: InevPara): InevPara;
 {* Реализация слова скрипта Para:GetParent }
//#UC START# *5530EDE9010F_5530EDE9010F_47C520D80305_Word_var*
//#UC END# *5530EDE9010F_5530EDE9010F_47C520D80305_Word_var*
begin
//#UC START# *5530EDE9010F_5530EDE9010F_47C520D80305_Word_impl*
 Result := aPara.OwnerObj.AsPara;
//#UC END# *5530EDE9010F_5530EDE9010F_47C520D80305_Word_impl*
end;//TkwParaGetParent.GetParent

class function TkwParaGetParent.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:GetParent';
end;//TkwParaGetParent.GetWordNameForRegister

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

function TkwParaGetType.GetType(const aCtx: TtfwContext;
 const aPara: InevPara): Tl3VariantDef;
 {* Реализация слова скрипта Para:GetType }
//#UC START# *5530EE040111_5530EE040111_47C520D80305_Word_var*
//#UC END# *5530EE040111_5530EE040111_47C520D80305_Word_var*
begin
//#UC START# *5530EE040111_5530EE040111_47C520D80305_Word_impl*
 Result := aPara.AsObject.TagType;
//#UC END# *5530EE040111_5530EE040111_47C520D80305_Word_impl*
end;//TkwParaGetType.GetType

class function TkwParaGetType.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:GetType';
end;//TkwParaGetType.GetWordNameForRegister

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

function TkwParaIntA.IntA(const aCtx: TtfwContext;
 const aPara: InevPara;
 aTag: Integer): Integer;
 {* Реализация слова скрипта Para:IntA }
//#UC START# *5530EE3D0010_5530EE3D0010_47C520D80305_Word_var*
//#UC END# *5530EE3D0010_5530EE3D0010_47C520D80305_Word_var*
begin
//#UC START# *5530EE3D0010_5530EE3D0010_47C520D80305_Word_impl*
 Result := aPara.AsObject.IntA[aTag];
//#UC END# *5530EE3D0010_5530EE3D0010_47C520D80305_Word_impl*
end;//TkwParaIntA.IntA

class function TkwParaIntA.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:IntA';
end;//TkwParaIntA.GetWordNameForRegister

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

procedure TkwParaIntW.IntW(const aCtx: TtfwContext;
 const aPara: InevPara;
 anEditor: TevCustomEditorWindow;
 aValue: Integer;
 aTag: Integer);
 {* Реализация слова скрипта Para:IntW }
//#UC START# *5530EE75004D_5530EE75004D_47C520D80305_Word_var*
//#UC END# *5530EE75004D_5530EE75004D_47C520D80305_Word_var*
begin
//#UC START# *5530EE75004D_5530EE75004D_47C520D80305_Word_impl*
 aPara.AsObject.IntW[aTag, k2StartOp(anEditor.View.Processor)] := aValue;
//#UC END# *5530EE75004D_5530EE75004D_47C520D80305_Word_impl*
end;//TkwParaIntW.IntW

class function TkwParaIntW.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:IntW';
end;//TkwParaIntW.GetWordNameForRegister

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

function TkwParaIsSame.IsSame(const aCtx: TtfwContext;
 const aPara: InevPara;
 const anOther: InevPara): Boolean;
 {* Реализация слова скрипта Para:IsSame }
//#UC START# *5530EE9C03D7_5530EE9C03D7_47C520D80305_Word_var*
//#UC END# *5530EE9C03D7_5530EE9C03D7_47C520D80305_Word_var*
begin
//#UC START# *5530EE9C03D7_5530EE9C03D7_47C520D80305_Word_impl*
 Result := anOther.AsObject.IsSame(aPara.AsObject);
//#UC END# *5530EE9C03D7_5530EE9C03D7_47C520D80305_Word_impl*
end;//TkwParaIsSame.IsSame

class function TkwParaIsSame.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:IsSame';
end;//TkwParaIsSame.GetWordNameForRegister

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

function TkwParaStrA.StrA(const aCtx: TtfwContext;
 const aPara: InevPara;
 aTag: Integer): Tl3WString;
 {* Реализация слова скрипта Para:StrA }
//#UC START# *5530EECD0214_5530EECD0214_47C520D80305_Word_var*
//#UC END# *5530EECD0214_5530EECD0214_47C520D80305_Word_var*
begin
//#UC START# *5530EECD0214_5530EECD0214_47C520D80305_Word_impl*
 Result := aPara.AsObject.PCharLenA[aTag];
//#UC END# *5530EECD0214_5530EECD0214_47C520D80305_Word_impl*
end;//TkwParaStrA.StrA

class function TkwParaStrA.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:StrA';
end;//TkwParaStrA.GetWordNameForRegister

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

function TkwParaStyleName.StyleName(const aCtx: TtfwContext;
 const aPara: InevPara): Tl3WString;
 {* Реализация слова скрипта Para:StyleName }
//#UC START# *5530EF10025B_5530EF10025B_47C520D80305_Word_var*
//#UC END# *5530EF10025B_5530EF10025B_47C520D80305_Word_var*
begin
//#UC START# *5530EF10025B_5530EF10025B_47C520D80305_Word_impl*
 Result := aPara.AsObject.PCharLenA[k2_tiStyle];
//#UC END# *5530EF10025B_5530EF10025B_47C520D80305_Word_impl*
end;//TkwParaStyleName.StyleName

class function TkwParaStyleName.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:StyleName';
end;//TkwParaStyleName.GetWordNameForRegister

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

function TkwParaText.Text(const aCtx: TtfwContext;
 const aPara: InevPara): Tl3WString;
 {* Реализация слова скрипта Para:Text }
//#UC START# *5530EF280204_5530EF280204_47C520D80305_Word_var*
//#UC END# *5530EF280204_5530EF280204_47C520D80305_Word_var*
begin
//#UC START# *5530EF280204_5530EF280204_47C520D80305_Word_impl*
 Result := aPara.AsObject.PCharLenA[k2_tiText];
//#UC END# *5530EF280204_5530EF280204_47C520D80305_Word_impl*
end;//TkwParaText.Text

class function TkwParaText.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:Text';
end;//TkwParaText.GetWordNameForRegister

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

function TkwParaTypeInherits.Type_Inherits(const aCtx: TtfwContext;
 const aPara: InevPara;
 aTypeID: Integer): Boolean;
 {* Реализация слова скрипта Para:Type:Inherits }
//#UC START# *5530EF480281_5530EF480281_47C520D80305_Word_var*
//#UC END# *5530EF480281_5530EF480281_47C520D80305_Word_var*
begin
//#UC START# *5530EF480281_5530EF480281_47C520D80305_Word_impl*
 Result := aPara.AsObject.IsKindOf(k2.TypeTable.TypeByHandle[aTypeID]);
//#UC END# *5530EF480281_5530EF480281_47C520D80305_Word_impl*
end;//TkwParaTypeInherits.Type_Inherits

class function TkwParaTypeInherits.GetWordNameForRegister: AnsiString;
begin
 Result := 'Para:Type:Inherits';
end;//TkwParaTypeInherits.GetWordNameForRegister

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

class function TevParaWordsPackResNameGetter.ResName: AnsiString;
begin
 Result := 'evParaWordsPack';
end;//TevParaWordsPackResNameGetter.ResName

 {$R evParaWordsPack.res}

initialization
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
 TevParaWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(TypeInfo(InevPara));
 {* Регистрация типа InevPara }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Tl3VariantDef));
 {* Регистрация типа Tl3VariantDef }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Tl3WString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevCustomEditorWindow));
 {* Регистрация типа TevCustomEditorWindow }
{$IfEnd} // NOT Defined(NoScripts)

end.
