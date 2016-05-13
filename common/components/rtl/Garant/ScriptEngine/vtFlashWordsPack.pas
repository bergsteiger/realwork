unit vtFlashWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\vtFlashWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "vtFlashWordsPack" MUID: (54EC8F930357)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(NoFlash)}
 , vtShockwaveFlashEx
 {$IfEnd} // NOT Defined(NoFlash)
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopFlashGetFrame = {final} class(TtfwClassLike)
  {* Слово скрипта pop:flash:GetFrame }
  private
   function GetFrame(const aCtx: TtfwContext;
    aFlash: TvtShockwaveFlashEx): Integer;
    {* Реализация слова скрипта pop:flash:GetFrame }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFlashGetFrame

function TkwPopFlashGetFrame.GetFrame(const aCtx: TtfwContext;
 aFlash: TvtShockwaveFlashEx): Integer;
 {* Реализация слова скрипта pop:flash:GetFrame }
//#UC START# *552FAF500391_4E9CC5473030_var*
//#UC END# *552FAF500391_4E9CC5473030_var*
begin
//#UC START# *552FAF500391_4E9CC5473030_impl*
 Result := aFlash.FrameNum;
//#UC END# *552FAF500391_4E9CC5473030_impl*
end;//TkwPopFlashGetFrame.GetFrame

procedure TkwPopFlashGetFrame.DoDoIt(const aCtx: TtfwContext);
var l_aFlash: TvtShockwaveFlashEx;
begin
 try
  l_aFlash := TvtShockwaveFlashEx(aCtx.rEngine.PopObjAs(TvtShockwaveFlashEx));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFlash: TvtShockwaveFlashEx : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(GetFrame(aCtx, l_aFlash));
end;//TkwPopFlashGetFrame.DoDoIt

class function TkwPopFlashGetFrame.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:flash:GetFrame';
end;//TkwPopFlashGetFrame.GetWordNameForRegister

function TkwPopFlashGetFrame.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopFlashGetFrame.GetResultTypeInfo

function TkwPopFlashGetFrame.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopFlashGetFrame.GetAllParamsCount

function TkwPopFlashGetFrame.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtShockwaveFlashEx)]);
end;//TkwPopFlashGetFrame.ParamsTypes

initialization
 TkwPopFlashGetFrame.RegisterInEngine;
 {* Регистрация pop_Flash_GetFrame }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtShockwaveFlashEx));
 {* Регистрация типа TvtShockwaveFlashEx }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
{$IfEnd} // NOT Defined(NoScripts)

end.
