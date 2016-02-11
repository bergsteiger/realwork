unit SelectedAttributesKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы SelectedAttributes }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\SelectedAttributesKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , LiteSearch_Module
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
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_SelectedAttributes = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы SelectedAttributes
----
*Пример использования*:
[code]
'aControl' форма::SelectedAttributes TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_SelectedAttributes

 Tkw_SelectedAttributes_Control_SelectedTree = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола SelectedTree
----
*Пример использования*:
[code]
контрол::SelectedTree TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelectedAttributes_Control_SelectedTree

 Tkw_SelectedAttributes_Control_SelectedTree_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола SelectedTree
----
*Пример использования*:
[code]
контрол::SelectedTree:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelectedAttributes_Control_SelectedTree_Push

 TkwEnSelectedAttributesSelectedTree = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenSelectedAttributes.SelectedTree
[panel]Контрол SelectedTree формы TenSelectedAttributes[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aenSelectedAttributes .TenSelectedAttributes.SelectedTree >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function SelectedTree(const aCtx: TtfwContext;
    aenSelectedAttributes: TenSelectedAttributes): TnscTreeViewWithAdapterDragDrop;
    {* Реализация слова скрипта .TenSelectedAttributes.SelectedTree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnSelectedAttributesSelectedTree

class function Tkw_Form_SelectedAttributes.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::SelectedAttributes';
end;//Tkw_Form_SelectedAttributes.GetWordNameForRegister

function Tkw_Form_SelectedAttributes.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_A6B6409DB9FB_var*
//#UC END# *4DDFD2EA0116_A6B6409DB9FB_var*
begin
//#UC START# *4DDFD2EA0116_A6B6409DB9FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_A6B6409DB9FB_impl*
end;//Tkw_Form_SelectedAttributes.GetString

class function Tkw_SelectedAttributes_Control_SelectedTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SelectedTree';
end;//Tkw_SelectedAttributes_Control_SelectedTree.GetWordNameForRegister

function Tkw_SelectedAttributes_Control_SelectedTree.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_18C51EA78BA3_var*
//#UC END# *4DDFD2EA0116_18C51EA78BA3_var*
begin
//#UC START# *4DDFD2EA0116_18C51EA78BA3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_18C51EA78BA3_impl*
end;//Tkw_SelectedAttributes_Control_SelectedTree.GetString

class procedure Tkw_SelectedAttributes_Control_SelectedTree.RegisterInEngine;
//#UC START# *52A086150180_18C51EA78BA3_var*
//#UC END# *52A086150180_18C51EA78BA3_var*
begin
//#UC START# *52A086150180_18C51EA78BA3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_18C51EA78BA3_impl*
end;//Tkw_SelectedAttributes_Control_SelectedTree.RegisterInEngine

procedure Tkw_SelectedAttributes_Control_SelectedTree_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_73A3CA945FEC_var*
//#UC END# *4DAEEDE10285_73A3CA945FEC_var*
begin
//#UC START# *4DAEEDE10285_73A3CA945FEC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_73A3CA945FEC_impl*
end;//Tkw_SelectedAttributes_Control_SelectedTree_Push.DoDoIt

class function Tkw_SelectedAttributes_Control_SelectedTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SelectedTree:push';
end;//Tkw_SelectedAttributes_Control_SelectedTree_Push.GetWordNameForRegister

function TkwEnSelectedAttributesSelectedTree.SelectedTree(const aCtx: TtfwContext;
 aenSelectedAttributes: TenSelectedAttributes): TnscTreeViewWithAdapterDragDrop;
 {* Реализация слова скрипта .TenSelectedAttributes.SelectedTree }
//#UC START# *D5909770B483_A201FE36705B_var*
//#UC END# *D5909770B483_A201FE36705B_var*
begin
//#UC START# *D5909770B483_A201FE36705B_impl*
 !!! Needs to be implemented !!!
//#UC END# *D5909770B483_A201FE36705B_impl*
end;//TkwEnSelectedAttributesSelectedTree.SelectedTree

procedure TkwEnSelectedAttributesSelectedTree.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A201FE36705B_var*
//#UC END# *4DAEEDE10285_A201FE36705B_var*
begin
//#UC START# *4DAEEDE10285_A201FE36705B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A201FE36705B_impl*
end;//TkwEnSelectedAttributesSelectedTree.DoDoIt

class function TkwEnSelectedAttributesSelectedTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenSelectedAttributes.SelectedTree';
end;//TkwEnSelectedAttributesSelectedTree.GetWordNameForRegister

procedure TkwEnSelectedAttributesSelectedTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_A201FE36705B_var*
//#UC END# *52D00B00031A_A201FE36705B_var*
begin
//#UC START# *52D00B00031A_A201FE36705B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_A201FE36705B_impl*
end;//TkwEnSelectedAttributesSelectedTree.SetValuePrim

function TkwEnSelectedAttributesSelectedTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnSelectedAttributesSelectedTree.GetResultTypeInfo

function TkwEnSelectedAttributesSelectedTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnSelectedAttributesSelectedTree.GetAllParamsCount

function TkwEnSelectedAttributesSelectedTree.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnSelectedAttributesSelectedTree.ParamsTypes

initialization
 Tkw_Form_SelectedAttributes.RegisterInEngine;
 {* Регистрация Tkw_Form_SelectedAttributes }
 Tkw_SelectedAttributes_Control_SelectedTree.RegisterInEngine;
 {* Регистрация Tkw_SelectedAttributes_Control_SelectedTree }
 Tkw_SelectedAttributes_Control_SelectedTree_Push.RegisterInEngine;
 {* Регистрация Tkw_SelectedAttributes_Control_SelectedTree_Push }
 TkwEnSelectedAttributesSelectedTree.RegisterInEngine;
 {* Регистрация enSelectedAttributes_SelectedTree }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenSelectedAttributes));
 {* Регистрация типа SelectedAttributes }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* Регистрация типа TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(NoScripts)

end.
