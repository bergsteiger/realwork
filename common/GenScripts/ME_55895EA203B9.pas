unit NewWordDefinitorPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\NewWordDefinitorPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptingInterfaces
 , l3Interfaces
 , kwCompiledVar
 , kwCompiledWordPrim
 , tfwTypeInfo
 , tfwClassLike
 , TypInfo
 , tfwPropertyLike
;

type
 TkwGlobalVar = class(TkwCompiledVar)
  public
   function CanClearInRecursiveCalls: Boolean; override;
   function IsForHelp: Boolean; override;
   function IsGlobalVar: Boolean; override;
 end;//TkwGlobalVar

 _kwCompiledVar_Parent_ = TkwCompiledWordPrim;
 {$Include kwCompiledVar.imp.pas}
 TkwRefcountVar = class(_kwCompiledVar_)
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function AcceptMedianBracket(aBracket: TtfwWord;
    var aCtx: TtfwContext): Boolean; override;
   procedure SetValue(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwRefcountVar

 TkwRefcountGlobalVar = class(TkwRefcountVar)
  public
   function CanClearInRecursiveCalls: Boolean; override;
   function IsForHelp: Boolean; override;
   function IsGlobalVar: Boolean; override;
 end;//TkwRefcountGlobalVar
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , l3Base
 , l3String
 , SysUtils
;

type
 TkwPopNewWordDefinitorCheckWord = {final} class(TtfwClassLike)
  {* Слово скрипта pop:NewWordDefinitor:CheckWord
*Тип результата:* TtfwKeyWord
*Пример:*
[code]
OBJECT VAR l_TtfwKeyWord
 aName aNewWordDefinitor pop:NewWordDefinitor:CheckWord >>> l_TtfwKeyWord
[code]  }
  private
   function CheckWord(const aCtx: TtfwContext;
    aNewWordDefinitor: TtfwNewWordDefinitor;
    const aName: Il3CString): TtfwKeyWord;
    {* Реализация слова скрипта pop:NewWordDefinitor:CheckWord }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopNewWordDefinitorCheckWord

 TkwPopNewWordDefinitorCheckVar = {final} class(TtfwClassLike)
  {* Слово скрипта pop:NewWordDefinitor:CheckVar
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 aName aLocal aNewWordDefinitor pop:NewWordDefinitor:CheckVar >>> l_TtfwWord
[code]  }
  private
   function CheckVar(const aCtx: TtfwContext;
    aNewWordDefinitor: TtfwNewWordDefinitor;
    aLocal: Boolean;
    const aName: Il3CString): TtfwWord;
    {* Реализация слова скрипта pop:NewWordDefinitor:CheckVar }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopNewWordDefinitorCheckVar

 TkwPopNewWordDefinitorDefineInParameter = {final} class(TtfwClassLike)
  {* Слово скрипта pop:NewWordDefinitor:DefineInParameter
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 aStereo aParamName aNewWordDefinitor pop:NewWordDefinitor:DefineInParameter >>> l_TtfwWord
[code]  }
  private
   function DefineInParameter(const aCtx: TtfwContext;
    aNewWordDefinitor: TtfwNewWordDefinitor;
    const aParamName: Il3CString;
    aStereo: TtfwWord): TtfwWord;
    {* Реализация слова скрипта pop:NewWordDefinitor:DefineInParameter }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopNewWordDefinitorDefineInParameter

 TkwPopNewWordDefinitorCheckRefcountVar = {final} class(TtfwClassLike)
  {* Слово скрипта pop:NewWordDefinitor:CheckRefcountVar
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 aName aLocal aNewWordDefinitor pop:NewWordDefinitor:CheckRefcountVar >>> l_TtfwWord
[code]  }
  private
   function CheckRefcountVar(const aCtx: TtfwContext;
    aNewWordDefinitor: TtfwNewWordDefinitor;
    aLocal: Boolean;
    const aName: Il3CString): TtfwWord;
    {* Реализация слова скрипта pop:NewWordDefinitor:CheckRefcountVar }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopNewWordDefinitorCheckRefcountVar

 TkwPopNewWordDefinitorKeywordFinder = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:NewWordDefinitor:KeywordFinder
*Тип результата:* TtfwKeywordFinder
*Пример:*
[code]
OBJECT VAR l_TtfwKeywordFinder
 aNewWordDefinitor pop:NewWordDefinitor:KeywordFinder >>> l_TtfwKeywordFinder
[code]  }
  private
   function KeywordFinder(const aCtx: TtfwContext;
    aNewWordDefinitor: TtfwNewWordDefinitor): TtfwKeywordFinder;
    {* Реализация слова скрипта pop:NewWordDefinitor:KeywordFinder }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopNewWordDefinitorKeywordFinder

function TkwGlobalVar.CanClearInRecursiveCalls: Boolean;
//#UC START# *559A470F0288_559A4C070092_var*
//#UC END# *559A470F0288_559A4C070092_var*
begin
//#UC START# *559A470F0288_559A4C070092_impl*
 Result := false;
//#UC END# *559A470F0288_559A4C070092_impl*
end;//TkwGlobalVar.CanClearInRecursiveCalls

function TkwGlobalVar.IsForHelp: Boolean;
//#UC START# *55C399C9009B_559A4C070092_var*
//#UC END# *55C399C9009B_559A4C070092_var*
begin
//#UC START# *55C399C9009B_559A4C070092_impl*
 Result := false;
//#UC END# *55C399C9009B_559A4C070092_impl*
end;//TkwGlobalVar.IsForHelp

function TkwGlobalVar.IsGlobalVar: Boolean;
//#UC START# *56456DDD037D_559A4C070092_var*
//#UC END# *56456DDD037D_559A4C070092_var*
begin
//#UC START# *56456DDD037D_559A4C070092_impl*
 Result := true;
//#UC END# *56456DDD037D_559A4C070092_impl*
end;//TkwGlobalVar.IsGlobalVar

{$Include kwCompiledVar.imp.pas}

procedure TkwRefcountVar.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5673DCB101B4_var*
//#UC END# *479731C50290_5673DCB101B4_var*
begin
//#UC START# *479731C50290_5673DCB101B4_impl*
 if (f_Value.rType = tfw_vtObj) then
 begin
  f_Value.AsObject.Free;
  f_Value.rInteger := 0;
 end;//f_Value.rType = tfw_vtObj
 inherited;
//#UC END# *479731C50290_5673DCB101B4_impl*
end;//TkwRefcountVar.Cleanup

procedure TkwRefcountVar.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_5673DCB101B4_var*
//#UC END# *52D00B00031A_5673DCB101B4_var*
begin
//#UC START# *52D00B00031A_5673DCB101B4_impl*
 if (f_Value.rType = tfw_vtObj) then
 begin
  if (aValue.rType = tfw_vtObj) AND (f_Value.AsObject = aValue.AsObject) then
   Exit;
  f_Value.AsObject.Free;
 end;//f_Value.rType = tfw_vtObj
 f_Value := aValue;
 if (aValue.rType = tfw_vtObj) then
 begin
  l3Use(aValue.AsObject);
 end;//aValue.rType = tfw_vtObj
//#UC END# *52D00B00031A_5673DCB101B4_impl*
end;//TkwRefcountVar.SetValuePrim

function TkwRefcountVar.AcceptMedianBracket(aBracket: TtfwWord;
 var aCtx: TtfwContext): Boolean;
//#UC START# *52D7DC84019E_5673DCB101B4_var*
//#UC END# *52D7DC84019E_5673DCB101B4_var*
begin
//#UC START# *52D7DC84019E_5673DCB101B4_impl*
 Result := false; 
//#UC END# *52D7DC84019E_5673DCB101B4_impl*
end;//TkwRefcountVar.AcceptMedianBracket

procedure TkwRefcountVar.SetValue(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *56096688024A_5673DCB101B4_var*
//#UC END# *56096688024A_5673DCB101B4_var*
begin
//#UC START# *56096688024A_5673DCB101B4_impl*
 inherited;
//#UC END# *56096688024A_5673DCB101B4_impl*
end;//TkwRefcountVar.SetValue

function TkwRefcountGlobalVar.CanClearInRecursiveCalls: Boolean;
//#UC START# *559A470F0288_5673DD44029E_var*
//#UC END# *559A470F0288_5673DD44029E_var*
begin
//#UC START# *559A470F0288_5673DD44029E_impl*
 Result := false;
//#UC END# *559A470F0288_5673DD44029E_impl*
end;//TkwRefcountGlobalVar.CanClearInRecursiveCalls

function TkwRefcountGlobalVar.IsForHelp: Boolean;
//#UC START# *55C399C9009B_5673DD44029E_var*
//#UC END# *55C399C9009B_5673DD44029E_var*
begin
//#UC START# *55C399C9009B_5673DD44029E_impl*
 Result := false;
//#UC END# *55C399C9009B_5673DD44029E_impl*
end;//TkwRefcountGlobalVar.IsForHelp

function TkwRefcountGlobalVar.IsGlobalVar: Boolean;
//#UC START# *56456DDD037D_5673DD44029E_var*
//#UC END# *56456DDD037D_5673DD44029E_var*
begin
//#UC START# *56456DDD037D_5673DD44029E_impl*
 Result := true;
//#UC END# *56456DDD037D_5673DD44029E_impl*
end;//TkwRefcountGlobalVar.IsGlobalVar

function TkwPopNewWordDefinitorCheckWord.CheckWord(const aCtx: TtfwContext;
 aNewWordDefinitor: TtfwNewWordDefinitor;
 const aName: Il3CString): TtfwKeyWord;
 {* Реализация слова скрипта pop:NewWordDefinitor:CheckWord }
//#UC START# *49B168237E12_B46B312AFA96_var*
//#UC END# *49B168237E12_B46B312AFA96_var*
begin
//#UC START# *49B168237E12_B46B312AFA96_impl*
 !!! Needs to be implemented !!!
//#UC END# *49B168237E12_B46B312AFA96_impl*
end;//TkwPopNewWordDefinitorCheckWord.CheckWord

procedure TkwPopNewWordDefinitorCheckWord.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B46B312AFA96_var*
//#UC END# *4DAEEDE10285_B46B312AFA96_var*
begin
//#UC START# *4DAEEDE10285_B46B312AFA96_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B46B312AFA96_impl*
end;//TkwPopNewWordDefinitorCheckWord.DoDoIt

class function TkwPopNewWordDefinitorCheckWord.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:NewWordDefinitor:CheckWord';
end;//TkwPopNewWordDefinitorCheckWord.GetWordNameForRegister

function TkwPopNewWordDefinitorCheckWord.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_B46B312AFA96_var*
//#UC END# *551544E2001A_B46B312AFA96_var*
begin
//#UC START# *551544E2001A_B46B312AFA96_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_B46B312AFA96_impl*
end;//TkwPopNewWordDefinitorCheckWord.GetResultTypeInfo

function TkwPopNewWordDefinitorCheckWord.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopNewWordDefinitorCheckWord.GetAllParamsCount

function TkwPopNewWordDefinitorCheckWord.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_B46B312AFA96_var*
//#UC END# *5617F4D00243_B46B312AFA96_var*
begin
//#UC START# *5617F4D00243_B46B312AFA96_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_B46B312AFA96_impl*
end;//TkwPopNewWordDefinitorCheckWord.ParamsTypes

function TkwPopNewWordDefinitorCheckVar.CheckVar(const aCtx: TtfwContext;
 aNewWordDefinitor: TtfwNewWordDefinitor;
 aLocal: Boolean;
 const aName: Il3CString): TtfwWord;
 {* Реализация слова скрипта pop:NewWordDefinitor:CheckVar }
//#UC START# *D57528D8717B_0518A66C4F49_var*
var
 l_KW : TtfwKeyWord;
 l_W : TtfwWord;
//#UC END# *D57528D8717B_0518A66C4F49_var*
begin
//#UC START# *D57528D8717B_0518A66C4F49_impl*
 l_KW := aNewWordDefinitor.CheckWord(aName);
 l_W := l_KW.Word;
 if (l_W = nil) then
 begin
  if aLocal then
   l_W := TkwCompiledVar.Create(Self,
                                aNewWordDefinitor.KeywordFinder(aCtx){PrevFinder},
                                aCtx.rTypeInfo,
                                aCtx,
                                l_KW)
  else
   l_W := TkwGlobalVar.Create(Self,
                              aNewWordDefinitor.KeywordFinder(aCtx){PrevFinder},
                              aCtx.rTypeInfo,
                              aCtx,
                              l_KW);
  try
   l_KW.SetWord(aCtx, l_W);
   Result := l_W;
  finally
   FreeAndNil(l_W);
  end;//try..finally
 end//l_W = nil
 else
  Result := l_W;
//#UC END# *D57528D8717B_0518A66C4F49_impl*
end;//TkwPopNewWordDefinitorCheckVar.CheckVar

procedure TkwPopNewWordDefinitorCheckVar.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0518A66C4F49_var*
//#UC END# *4DAEEDE10285_0518A66C4F49_var*
begin
//#UC START# *4DAEEDE10285_0518A66C4F49_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0518A66C4F49_impl*
end;//TkwPopNewWordDefinitorCheckVar.DoDoIt

class function TkwPopNewWordDefinitorCheckVar.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:NewWordDefinitor:CheckVar';
end;//TkwPopNewWordDefinitorCheckVar.GetWordNameForRegister

function TkwPopNewWordDefinitorCheckVar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_0518A66C4F49_var*
//#UC END# *551544E2001A_0518A66C4F49_var*
begin
//#UC START# *551544E2001A_0518A66C4F49_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_0518A66C4F49_impl*
end;//TkwPopNewWordDefinitorCheckVar.GetResultTypeInfo

function TkwPopNewWordDefinitorCheckVar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopNewWordDefinitorCheckVar.GetAllParamsCount

function TkwPopNewWordDefinitorCheckVar.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0518A66C4F49_var*
//#UC END# *5617F4D00243_0518A66C4F49_var*
begin
//#UC START# *5617F4D00243_0518A66C4F49_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0518A66C4F49_impl*
end;//TkwPopNewWordDefinitorCheckVar.ParamsTypes

function TkwPopNewWordDefinitorDefineInParameter.DefineInParameter(const aCtx: TtfwContext;
 aNewWordDefinitor: TtfwNewWordDefinitor;
 const aParamName: Il3CString;
 aStereo: TtfwWord): TtfwWord;
 {* Реализация слова скрипта pop:NewWordDefinitor:DefineInParameter }
//#UC START# *B2F36CF00AB7_CDFCC0A90AF7_var*
//#UC END# *B2F36CF00AB7_CDFCC0A90AF7_var*
begin
//#UC START# *B2F36CF00AB7_CDFCC0A90AF7_impl*
 Result := aNewWordDefinitor.DefineInParameter(aCtx, aParamName, aStereo, aCtx.rTypeInfo);
//#UC END# *B2F36CF00AB7_CDFCC0A90AF7_impl*
end;//TkwPopNewWordDefinitorDefineInParameter.DefineInParameter

procedure TkwPopNewWordDefinitorDefineInParameter.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CDFCC0A90AF7_var*
//#UC END# *4DAEEDE10285_CDFCC0A90AF7_var*
begin
//#UC START# *4DAEEDE10285_CDFCC0A90AF7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CDFCC0A90AF7_impl*
end;//TkwPopNewWordDefinitorDefineInParameter.DoDoIt

class function TkwPopNewWordDefinitorDefineInParameter.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:NewWordDefinitor:DefineInParameter';
end;//TkwPopNewWordDefinitorDefineInParameter.GetWordNameForRegister

function TkwPopNewWordDefinitorDefineInParameter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_CDFCC0A90AF7_var*
//#UC END# *551544E2001A_CDFCC0A90AF7_var*
begin
//#UC START# *551544E2001A_CDFCC0A90AF7_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_CDFCC0A90AF7_impl*
end;//TkwPopNewWordDefinitorDefineInParameter.GetResultTypeInfo

function TkwPopNewWordDefinitorDefineInParameter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopNewWordDefinitorDefineInParameter.GetAllParamsCount

function TkwPopNewWordDefinitorDefineInParameter.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_CDFCC0A90AF7_var*
//#UC END# *5617F4D00243_CDFCC0A90AF7_var*
begin
//#UC START# *5617F4D00243_CDFCC0A90AF7_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_CDFCC0A90AF7_impl*
end;//TkwPopNewWordDefinitorDefineInParameter.ParamsTypes

function TkwPopNewWordDefinitorCheckRefcountVar.CheckRefcountVar(const aCtx: TtfwContext;
 aNewWordDefinitor: TtfwNewWordDefinitor;
 aLocal: Boolean;
 const aName: Il3CString): TtfwWord;
 {* Реализация слова скрипта pop:NewWordDefinitor:CheckRefcountVar }
//#UC START# *FB5BD5AE3D3A_61662B3659A7_var*
var
 l_KW : TtfwKeyWord;
 l_W : TtfwWord;
//#UC END# *FB5BD5AE3D3A_61662B3659A7_var*
begin
//#UC START# *FB5BD5AE3D3A_61662B3659A7_impl*
 l_KW := aNewWordDefinitor.CheckWord(aName);
 l_W := l_KW.Word;
 if (l_W = nil) then
 begin
  if aLocal then
   l_W := TkwRefcountVar.Create(Self,
                                aNewWordDefinitor.KeywordFinder(aCtx){PrevFinder},
                                aCtx.rTypeInfo,
                                aCtx,
                                l_KW)
  else
   l_W := TkwRefcountGlobalVar.Create(Self,
                              aNewWordDefinitor.KeywordFinder(aCtx){PrevFinder},
                              aCtx.rTypeInfo,
                              aCtx,
                              l_KW);
  try
   l_KW.SetWord(aCtx, l_W);
   Result := l_W;
  finally
   FreeAndNil(l_W);
  end;//try..finally
 end//l_W = nil
 else
  Result := l_W;
//#UC END# *FB5BD5AE3D3A_61662B3659A7_impl*
end;//TkwPopNewWordDefinitorCheckRefcountVar.CheckRefcountVar

procedure TkwPopNewWordDefinitorCheckRefcountVar.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_61662B3659A7_var*
//#UC END# *4DAEEDE10285_61662B3659A7_var*
begin
//#UC START# *4DAEEDE10285_61662B3659A7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_61662B3659A7_impl*
end;//TkwPopNewWordDefinitorCheckRefcountVar.DoDoIt

class function TkwPopNewWordDefinitorCheckRefcountVar.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:NewWordDefinitor:CheckRefcountVar';
end;//TkwPopNewWordDefinitorCheckRefcountVar.GetWordNameForRegister

function TkwPopNewWordDefinitorCheckRefcountVar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_61662B3659A7_var*
//#UC END# *551544E2001A_61662B3659A7_var*
begin
//#UC START# *551544E2001A_61662B3659A7_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_61662B3659A7_impl*
end;//TkwPopNewWordDefinitorCheckRefcountVar.GetResultTypeInfo

function TkwPopNewWordDefinitorCheckRefcountVar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopNewWordDefinitorCheckRefcountVar.GetAllParamsCount

function TkwPopNewWordDefinitorCheckRefcountVar.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_61662B3659A7_var*
//#UC END# *5617F4D00243_61662B3659A7_var*
begin
//#UC START# *5617F4D00243_61662B3659A7_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_61662B3659A7_impl*
end;//TkwPopNewWordDefinitorCheckRefcountVar.ParamsTypes

function TkwPopNewWordDefinitorKeywordFinder.KeywordFinder(const aCtx: TtfwContext;
 aNewWordDefinitor: TtfwNewWordDefinitor): TtfwKeywordFinder;
 {* Реализация слова скрипта pop:NewWordDefinitor:KeywordFinder }
//#UC START# *2EA08C0CC8B4_C919B8A4B92C_var*
//#UC END# *2EA08C0CC8B4_C919B8A4B92C_var*
begin
//#UC START# *2EA08C0CC8B4_C919B8A4B92C_impl*
 Result := aNewWordDefinitor.KeywordFinder(aCtx);
//#UC END# *2EA08C0CC8B4_C919B8A4B92C_impl*
end;//TkwPopNewWordDefinitorKeywordFinder.KeywordFinder

procedure TkwPopNewWordDefinitorKeywordFinder.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C919B8A4B92C_var*
//#UC END# *4DAEEDE10285_C919B8A4B92C_var*
begin
//#UC START# *4DAEEDE10285_C919B8A4B92C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C919B8A4B92C_impl*
end;//TkwPopNewWordDefinitorKeywordFinder.DoDoIt

class function TkwPopNewWordDefinitorKeywordFinder.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:NewWordDefinitor:KeywordFinder';
end;//TkwPopNewWordDefinitorKeywordFinder.GetWordNameForRegister

procedure TkwPopNewWordDefinitorKeywordFinder.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_C919B8A4B92C_var*
//#UC END# *52D00B00031A_C919B8A4B92C_var*
begin
//#UC START# *52D00B00031A_C919B8A4B92C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_C919B8A4B92C_impl*
end;//TkwPopNewWordDefinitorKeywordFinder.SetValuePrim

function TkwPopNewWordDefinitorKeywordFinder.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_C919B8A4B92C_var*
//#UC END# *551544E2001A_C919B8A4B92C_var*
begin
//#UC START# *551544E2001A_C919B8A4B92C_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_C919B8A4B92C_impl*
end;//TkwPopNewWordDefinitorKeywordFinder.GetResultTypeInfo

function TkwPopNewWordDefinitorKeywordFinder.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwPopNewWordDefinitorKeywordFinder.GetAllParamsCount

function TkwPopNewWordDefinitorKeywordFinder.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_C919B8A4B92C_var*
//#UC END# *5617F4D00243_C919B8A4B92C_var*
begin
//#UC START# *5617F4D00243_C919B8A4B92C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C919B8A4B92C_impl*
end;//TkwPopNewWordDefinitorKeywordFinder.ParamsTypes

initialization
 TkwGlobalVar.RegisterClass;
 {* Регистрация TkwGlobalVar }
 TkwRefcountVar.RegisterClass;
 {* Регистрация TkwRefcountVar }
 TkwRefcountGlobalVar.RegisterClass;
 {* Регистрация TkwRefcountGlobalVar }
 TkwPopNewWordDefinitorCheckWord.RegisterInEngine;
 {* Регистрация pop_NewWordDefinitor_CheckWord }
 TkwPopNewWordDefinitorCheckVar.RegisterInEngine;
 {* Регистрация pop_NewWordDefinitor_CheckVar }
 TkwPopNewWordDefinitorDefineInParameter.RegisterInEngine;
 {* Регистрация pop_NewWordDefinitor_DefineInParameter }
 TkwPopNewWordDefinitorCheckRefcountVar.RegisterInEngine;
 {* Регистрация pop_NewWordDefinitor_CheckRefcountVar }
 TkwPopNewWordDefinitorKeywordFinder.RegisterInEngine;
 {* Регистрация pop_NewWordDefinitor_KeywordFinder }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwNewWordDefinitor));
 {* Регистрация типа TtfwNewWordDefinitor }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeyWord));
 {* Регистрация типа TtfwKeyWord }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeywordFinder));
 {* Регистрация типа TtfwKeywordFinder }
{$IfEnd} // NOT Defined(NoScripts)

end.
