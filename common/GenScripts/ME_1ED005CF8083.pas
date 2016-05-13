unit FoldersTreeKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы FoldersTree }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\FoldersTreeKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "FoldersTreeKeywordsPack" MUID: (1ED005CF8083)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , nscTreeViewWithAdapterDragDrop
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , FoldersTree_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , TypInfo
 , tfwTypeInfo
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 Tkw_Form_FoldersTree = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы FoldersTree
----
*Пример использования*:
[code]
'aControl' форма::FoldersTree TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_FoldersTree

 Tkw_FoldersTree_Control_FoldersTree = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FoldersTree
----
*Пример использования*:
[code]
контрол::FoldersTree TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersTree_Control_FoldersTree

 Tkw_FoldersTree_Control_FoldersTree_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола FoldersTree
----
*Пример использования*:
[code]
контрол::FoldersTree:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersTree_Control_FoldersTree_Push

 TkwEnFoldersTreeFoldersTree = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenFoldersTree.FoldersTree }
  private
   function FoldersTree(const aCtx: TtfwContext;
    aenFoldersTree: TenFoldersTree): TnscTreeViewWithAdapterDragDrop;
    {* Реализация слова скрипта .TenFoldersTree.FoldersTree }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnFoldersTreeFoldersTree

function Tkw_Form_FoldersTree.GetString: AnsiString;
begin
 Result := 'enFoldersTree';
end;//Tkw_Form_FoldersTree.GetString

class function Tkw_Form_FoldersTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::FoldersTree';
end;//Tkw_Form_FoldersTree.GetWordNameForRegister

function Tkw_FoldersTree_Control_FoldersTree.GetString: AnsiString;
begin
 Result := 'FoldersTree';
end;//Tkw_FoldersTree_Control_FoldersTree.GetString

class procedure Tkw_FoldersTree_Control_FoldersTree.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_FoldersTree_Control_FoldersTree.RegisterInEngine

class function Tkw_FoldersTree_Control_FoldersTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FoldersTree';
end;//Tkw_FoldersTree_Control_FoldersTree.GetWordNameForRegister

procedure Tkw_FoldersTree_Control_FoldersTree_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FoldersTree');
 inherited;
end;//Tkw_FoldersTree_Control_FoldersTree_Push.DoDoIt

class function Tkw_FoldersTree_Control_FoldersTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FoldersTree:push';
end;//Tkw_FoldersTree_Control_FoldersTree_Push.GetWordNameForRegister

function TkwEnFoldersTreeFoldersTree.FoldersTree(const aCtx: TtfwContext;
 aenFoldersTree: TenFoldersTree): TnscTreeViewWithAdapterDragDrop;
 {* Реализация слова скрипта .TenFoldersTree.FoldersTree }
begin
 Result := aenFoldersTree.FoldersTree;
end;//TkwEnFoldersTreeFoldersTree.FoldersTree

class function TkwEnFoldersTreeFoldersTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenFoldersTree.FoldersTree';
end;//TkwEnFoldersTreeFoldersTree.GetWordNameForRegister

function TkwEnFoldersTreeFoldersTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnFoldersTreeFoldersTree.GetResultTypeInfo

function TkwEnFoldersTreeFoldersTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnFoldersTreeFoldersTree.GetAllParamsCount

function TkwEnFoldersTreeFoldersTree.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TenFoldersTree)]);
end;//TkwEnFoldersTreeFoldersTree.ParamsTypes

procedure TkwEnFoldersTreeFoldersTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FoldersTree', aCtx);
end;//TkwEnFoldersTreeFoldersTree.SetValuePrim

procedure TkwEnFoldersTreeFoldersTree.DoDoIt(const aCtx: TtfwContext);
var l_aenFoldersTree: TenFoldersTree;
begin
 try
  l_aenFoldersTree := TenFoldersTree(aCtx.rEngine.PopObjAs(TenFoldersTree));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenFoldersTree: TenFoldersTree : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FoldersTree(aCtx, l_aenFoldersTree));
end;//TkwEnFoldersTreeFoldersTree.DoDoIt

initialization
 Tkw_Form_FoldersTree.RegisterInEngine;
 {* Регистрация Tkw_Form_FoldersTree }
 Tkw_FoldersTree_Control_FoldersTree.RegisterInEngine;
 {* Регистрация Tkw_FoldersTree_Control_FoldersTree }
 Tkw_FoldersTree_Control_FoldersTree_Push.RegisterInEngine;
 {* Регистрация Tkw_FoldersTree_Control_FoldersTree_Push }
 TkwEnFoldersTreeFoldersTree.RegisterInEngine;
 {* Регистрация enFoldersTree_FoldersTree }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenFoldersTree));
 {* Регистрация типа TenFoldersTree }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* Регистрация типа TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
