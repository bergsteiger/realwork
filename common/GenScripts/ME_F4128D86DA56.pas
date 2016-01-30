unit UnderControlKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы UnderControl }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\UnderControl\UnderControlKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , UnderControl_Module
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , nscTreeViewWithAdapterDragDrop
 , TtfwClassRef_Proxy
;

type
 Tkw_Form_UnderControl = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы UnderControl
----
*Пример использования*:
[code]
'aControl' форма::UnderControl TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_UnderControl

 Tkw_UnderControl_Control_UnderControlList = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола UnderControlList
----
*Пример использования*:
[code]
контрол::UnderControlList TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UnderControl_Control_UnderControlList

 Tkw_UnderControl_Control_UnderControlList_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола UnderControlList
----
*Пример использования*:
[code]
контрол::UnderControlList:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UnderControl_Control_UnderControlList_Push

class function Tkw_Form_UnderControl.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::UnderControl';
end;//Tkw_Form_UnderControl.GetWordNameForRegister

function Tkw_Form_UnderControl.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_FB556AE39FAA_var*
//#UC END# *4DDFD2EA0116_FB556AE39FAA_var*
begin
//#UC START# *4DDFD2EA0116_FB556AE39FAA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_FB556AE39FAA_impl*
end;//Tkw_Form_UnderControl.GetString

class function Tkw_UnderControl_Control_UnderControlList.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::UnderControlList';
end;//Tkw_UnderControl_Control_UnderControlList.GetWordNameForRegister

function Tkw_UnderControl_Control_UnderControlList.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_1B916B997821_var*
//#UC END# *4DDFD2EA0116_1B916B997821_var*
begin
//#UC START# *4DDFD2EA0116_1B916B997821_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_1B916B997821_impl*
end;//Tkw_UnderControl_Control_UnderControlList.GetString

class procedure Tkw_UnderControl_Control_UnderControlList.RegisterInEngine;
//#UC START# *52A086150180_1B916B997821_var*
//#UC END# *52A086150180_1B916B997821_var*
begin
//#UC START# *52A086150180_1B916B997821_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_1B916B997821_impl*
end;//Tkw_UnderControl_Control_UnderControlList.RegisterInEngine

procedure Tkw_UnderControl_Control_UnderControlList_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D9AD25D19806_var*
//#UC END# *4DAEEDE10285_D9AD25D19806_var*
begin
//#UC START# *4DAEEDE10285_D9AD25D19806_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D9AD25D19806_impl*
end;//Tkw_UnderControl_Control_UnderControlList_Push.DoDoIt

class function Tkw_UnderControl_Control_UnderControlList_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::UnderControlList:push';
end;//Tkw_UnderControl_Control_UnderControlList_Push.GetWordNameForRegister

initialization
 Tkw_Form_UnderControl.RegisterInEngine;
 {* Регистрация Tkw_Form_UnderControl }
 Tkw_UnderControl_Control_UnderControlList.RegisterInEngine;
 {* Регистрация Tkw_UnderControl_Control_UnderControlList }
 Tkw_UnderControl_Control_UnderControlList_Push.RegisterInEngine;
 {* Регистрация Tkw_UnderControl_Control_UnderControlList_Push }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
