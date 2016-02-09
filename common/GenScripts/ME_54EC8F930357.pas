unit vtFlashWordsPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\vtFlashWordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoFlash)}
 , vtShockwaveFlashEx
 {$IfEnd} // NOT Defined(NoFlash)
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopFlashGetFrame = {final} class(TtfwClassLike)
  {* ����� ������� pop:flash:GetFrame
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aFlash pop:flash:GetFrame >>> l_Integer
[code]  }
  private
   function GetFrame(const aCtx: TtfwContext;
    aFlash: TvtShockwaveFlashEx): Integer;
    {* ���������� ����� ������� pop:flash:GetFrame }
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
 {* ���������� ����� ������� pop:flash:GetFrame }
//#UC START# *974085042BA3_4E9CC5473030_var*
//#UC END# *974085042BA3_4E9CC5473030_var*
begin
//#UC START# *974085042BA3_4E9CC5473030_impl*
 Result := aFlash.FrameNum;
//#UC END# *974085042BA3_4E9CC5473030_impl*
end;//TkwPopFlashGetFrame.GetFrame

procedure TkwPopFlashGetFrame.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E9CC5473030_var*
//#UC END# *4DAEEDE10285_4E9CC5473030_var*
begin
//#UC START# *4DAEEDE10285_4E9CC5473030_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4E9CC5473030_impl*
end;//TkwPopFlashGetFrame.DoDoIt

class function TkwPopFlashGetFrame.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:flash:GetFrame';
end;//TkwPopFlashGetFrame.GetWordNameForRegister

function TkwPopFlashGetFrame.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_4E9CC5473030_var*
//#UC END# *551544E2001A_4E9CC5473030_var*
begin
//#UC START# *551544E2001A_4E9CC5473030_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_4E9CC5473030_impl*
end;//TkwPopFlashGetFrame.GetResultTypeInfo

function TkwPopFlashGetFrame.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopFlashGetFrame.GetAllParamsCount

function TkwPopFlashGetFrame.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_4E9CC5473030_var*
//#UC END# *5617F4D00243_4E9CC5473030_var*
begin
//#UC START# *5617F4D00243_4E9CC5473030_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_4E9CC5473030_impl*
end;//TkwPopFlashGetFrame.ParamsTypes

initialization
 TkwPopFlashGetFrame.RegisterInEngine;
 {* ����������� pop_Flash_GetFrame }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtShockwaveFlashEx));
 {* ����������� ���� TvtShockwaveFlashEx }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* ����������� ���� Integer }
{$IfEnd} // NOT Defined(NoScripts)

end.
