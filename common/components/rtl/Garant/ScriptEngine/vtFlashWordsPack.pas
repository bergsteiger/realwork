unit vtFlashWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$VT"
// ������: "vtFlashWordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi::ScriptEngine$VT::vtFlashWords::vtFlashWordsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  Classes
  {$If not defined(NoFlash)}
  ,
  vtShockwaveFlashEx
  {$IfEnd} //not NoFlash
  ,
  tfwScriptingInterfaces,
  tfwClassLike
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwPopFlashGetFrame = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:flash:GetFrame
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aFlash pop:flash:GetFrame >>> l_Integer
[code]  }
 private
 // private methods
   function GetFrame(const aCtx: TtfwContext;
    aFlash: TvtShockwaveFlashEx): Integer;
     {* ���������� ����� ������� pop:flash:GetFrame }
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
 end;//TkwPopFlashGetFrame

// start class TkwPopFlashGetFrame

function TkwPopFlashGetFrame.GetFrame(const aCtx: TtfwContext;
  aFlash: TvtShockwaveFlashEx): Integer;
//#UC START# *974085042BA3_4E9CC5473030_var*
//#UC END# *974085042BA3_4E9CC5473030_var*
begin
//#UC START# *974085042BA3_4E9CC5473030_impl*
 Result := aFlash.FrameNum;
//#UC END# *974085042BA3_4E9CC5473030_impl*
end;//TkwPopFlashGetFrame.GetFrame

procedure TkwPopFlashGetFrame.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aFlash : TvtShockwaveFlashEx;
begin
 try
  l_aFlash := TvtShockwaveFlashEx(aCtx.rEngine.PopObjAs(TvtShockwaveFlashEx));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFlash: TvtShockwaveFlashEx : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((GetFrame(aCtx, l_aFlash)));
end;//TkwPopFlashGetFrame.DoDoIt

class function TkwPopFlashGetFrame.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:flash:GetFrame';
end;//TkwPopFlashGetFrame.GetWordNameForRegister

function TkwPopFlashGetFrame.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwPopFlashGetFrame.GetResultTypeInfo

function TkwPopFlashGetFrame.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopFlashGetFrame.GetAllParamsCount

function TkwPopFlashGetFrame.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvtShockwaveFlashEx)]);
end;//TkwPopFlashGetFrame.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� pop_Flash_GetFrame
 TkwPopFlashGetFrame.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TvtShockwaveFlashEx
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtShockwaveFlashEx));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Integer
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
{$IfEnd} //not NoScripts

end.