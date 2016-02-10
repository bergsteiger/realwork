unit TreeAttributeFirstLevelKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы TreeAttributeFirstLevel }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\TreeAttributeFirstLevelKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Search_Module
 , nscTreeViewWithAdapterDragDrop
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_TreeAttributeFirstLevel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы TreeAttributeFirstLevel
----
*Пример использования*:
[code]
'aControl' форма::TreeAttributeFirstLevel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_TreeAttributeFirstLevel

 Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FirstLevelContent
----
*Пример использования*:
[code]
контрол::FirstLevelContent TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent

 Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FirstLevelContent
----
*Пример использования*:
[code]
контрол::FirstLevelContent:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push

 TkwEfTreeAttributeFirstLevelFirstLevelContent = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefTreeAttributeFirstLevel.FirstLevelContent
[panel]Контрол FirstLevelContent формы TefTreeAttributeFirstLevel[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aefTreeAttributeFirstLevel .TefTreeAttributeFirstLevel.FirstLevelContent >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function FirstLevelContent(const aCtx: TtfwContext;
    aefTreeAttributeFirstLevel: TefTreeAttributeFirstLevel): TnscTreeViewWithAdapterDragDrop;
    {* Реализация слова скрипта .TefTreeAttributeFirstLevel.FirstLevelContent }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfTreeAttributeFirstLevelFirstLevelContent

class function Tkw_Form_TreeAttributeFirstLevel.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::TreeAttributeFirstLevel';
end;//Tkw_Form_TreeAttributeFirstLevel.GetWordNameForRegister

function Tkw_Form_TreeAttributeFirstLevel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_62A2CC65156B_var*
//#UC END# *4DDFD2EA0116_62A2CC65156B_var*
begin
//#UC START# *4DDFD2EA0116_62A2CC65156B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_62A2CC65156B_impl*
end;//Tkw_Form_TreeAttributeFirstLevel.GetString

class function Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FirstLevelContent';
end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.GetWordNameForRegister

function Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7E012EE25E53_var*
//#UC END# *4DDFD2EA0116_7E012EE25E53_var*
begin
//#UC START# *4DDFD2EA0116_7E012EE25E53_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7E012EE25E53_impl*
end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.GetString

class procedure Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.RegisterInEngine;
//#UC START# *52A086150180_7E012EE25E53_var*
//#UC END# *52A086150180_7E012EE25E53_var*
begin
//#UC START# *52A086150180_7E012EE25E53_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_7E012EE25E53_impl*
end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.RegisterInEngine

procedure Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_854835E10887_var*
//#UC END# *4DAEEDE10285_854835E10887_var*
begin
//#UC START# *4DAEEDE10285_854835E10887_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_854835E10887_impl*
end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push.DoDoIt

class function Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FirstLevelContent:push';
end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push.GetWordNameForRegister

function TkwEfTreeAttributeFirstLevelFirstLevelContent.FirstLevelContent(const aCtx: TtfwContext;
 aefTreeAttributeFirstLevel: TefTreeAttributeFirstLevel): TnscTreeViewWithAdapterDragDrop;
 {* Реализация слова скрипта .TefTreeAttributeFirstLevel.FirstLevelContent }
//#UC START# *F118BC5C734D_33551677EC80_var*
//#UC END# *F118BC5C734D_33551677EC80_var*
begin
//#UC START# *F118BC5C734D_33551677EC80_impl*
 !!! Needs to be implemented !!!
//#UC END# *F118BC5C734D_33551677EC80_impl*
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.FirstLevelContent

procedure TkwEfTreeAttributeFirstLevelFirstLevelContent.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_33551677EC80_var*
//#UC END# *4DAEEDE10285_33551677EC80_var*
begin
//#UC START# *4DAEEDE10285_33551677EC80_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_33551677EC80_impl*
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.DoDoIt

class function TkwEfTreeAttributeFirstLevelFirstLevelContent.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefTreeAttributeFirstLevel.FirstLevelContent';
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.GetWordNameForRegister

procedure TkwEfTreeAttributeFirstLevelFirstLevelContent.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_33551677EC80_var*
//#UC END# *52D00B00031A_33551677EC80_var*
begin
//#UC START# *52D00B00031A_33551677EC80_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_33551677EC80_impl*
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.SetValuePrim

function TkwEfTreeAttributeFirstLevelFirstLevelContent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.GetResultTypeInfo

function TkwEfTreeAttributeFirstLevelFirstLevelContent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.GetAllParamsCount

function TkwEfTreeAttributeFirstLevelFirstLevelContent.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_33551677EC80_var*
//#UC END# *5617F4D00243_33551677EC80_var*
begin
//#UC START# *5617F4D00243_33551677EC80_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_33551677EC80_impl*
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.ParamsTypes

initialization
 Tkw_Form_TreeAttributeFirstLevel.RegisterInEngine;
 {* Регистрация Tkw_Form_TreeAttributeFirstLevel }
 Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.RegisterInEngine;
 {* Регистрация Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent }
 Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push.RegisterInEngine;
 {* Регистрация Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push }
 TkwEfTreeAttributeFirstLevelFirstLevelContent.RegisterInEngine;
 {* Регистрация efTreeAttributeFirstLevel_FirstLevelContent }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefTreeAttributeFirstLevel));
 {* Регистрация типа TreeAttributeFirstLevel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* Регистрация типа TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
