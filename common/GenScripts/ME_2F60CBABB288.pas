unit SelectedAttributesKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы SelectedAttributes }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\SelectedAttributesKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , LiteSearch_Module
 , nscTreeViewWithAdapterDragDrop
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
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
begin
 Result := 'enSelectedAttributes';
end;//Tkw_Form_SelectedAttributes.GetString

class function Tkw_SelectedAttributes_Control_SelectedTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SelectedTree';
end;//Tkw_SelectedAttributes_Control_SelectedTree.GetWordNameForRegister

function Tkw_SelectedAttributes_Control_SelectedTree.GetString: AnsiString;
begin
 Result := 'SelectedTree';
end;//Tkw_SelectedAttributes_Control_SelectedTree.GetString

class procedure Tkw_SelectedAttributes_Control_SelectedTree.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
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
begin
 Result := aenSelectedAttributes.SelectedTree;
end;//TkwEnSelectedAttributesSelectedTree.SelectedTree

procedure TkwEnSelectedAttributesSelectedTree.DoDoIt(const aCtx: TtfwContext);
var l_aenSelectedAttributes: TenSelectedAttributes;
begin
 try
  l_aenSelectedAttributes := TenSelectedAttributes(aCtx.rEngine.PopObjAs(TenSelectedAttributes));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenSelectedAttributes: TenSelectedAttributes : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(SelectedTree(aCtx, l_aenSelectedAttributes));
end;//TkwEnSelectedAttributesSelectedTree.DoDoIt

class function TkwEnSelectedAttributesSelectedTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenSelectedAttributes.SelectedTree';
end;//TkwEnSelectedAttributesSelectedTree.GetWordNameForRegister

procedure TkwEnSelectedAttributesSelectedTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству SelectedTree', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TenSelectedAttributes)]);
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
