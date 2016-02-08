unit kwBynameControlPush;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwBynameControlPush.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , kwControlWord
 , Controls
 , tfwScriptingInterfaces
 , Classes
 , TypInfo
;

type
 TkwBynameControlPush = class(TkwControlWord)
  protected
   procedure DoControl(aControl: TControl;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoComponent(aControl: TComponent;
    const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
 end;//TkwBynameControlPush
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , l3Except
 , Windows
 , Forms
;

procedure TkwBynameControlPush.DoControl(aControl: TControl;
 const aCtx: TtfwContext);
//#UC START# *4DB98B990054_4F2141AD0203_var*
//#UC END# *4DB98B990054_4F2141AD0203_var*
begin
//#UC START# *4DB98B990054_4F2141AD0203_impl*
 aCtx.rEngine.PushObj(aControl);
//#UC END# *4DB98B990054_4F2141AD0203_impl*
end;//TkwBynameControlPush.DoControl

class function TkwBynameControlPush.GetWordNameForRegister: AnsiString;
begin
 Result := 'byname:control:push';
end;//TkwBynameControlPush.GetWordNameForRegister

procedure TkwBynameControlPush.DoComponent(aControl: TComponent;
 const aCtx: TtfwContext);
//#UC START# *5357B6FB0024_4F2141AD0203_var*
//#UC END# *5357B6FB0024_4F2141AD0203_var*
begin
//#UC START# *5357B6FB0024_4F2141AD0203_impl*
 aCtx.rEngine.PushObj(aControl);
//#UC END# *5357B6FB0024_4F2141AD0203_impl*
end;//TkwBynameControlPush.DoComponent

function TkwBynameControlPush.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_4F2141AD0203_var*
//#UC END# *551544E2001A_4F2141AD0203_var*
begin
//#UC START# *551544E2001A_4F2141AD0203_impl*
 Result := TypeInfo(TComponent);
//#UC END# *551544E2001A_4F2141AD0203_impl*
end;//TkwBynameControlPush.GetResultTypeInfo

initialization
 TkwBynameControlPush.RegisterInEngine;
 {* Регистрация byname_control_push }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
