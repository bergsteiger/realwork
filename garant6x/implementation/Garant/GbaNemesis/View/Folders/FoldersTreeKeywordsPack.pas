unit FoldersTreeKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Folders/FoldersTreeKeywordsPack.pas"
// Начат: 27.08.2009 20:37
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Основные прецеденты::Folders::View::Folders::PrimFolders$UC::FoldersTreeKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы FoldersTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  FoldersTree_Form,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  nscTreeViewWithAdapterDragDrop,
  tfwPropertyLike
  ;

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_FoldersTree = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы FoldersTree
----
*Пример использования*:
[code]
'aControl' форма::FoldersTree TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_FoldersTree

// start class Tkw_Form_FoldersTree

class function Tkw_Form_FoldersTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::FoldersTree';
end;//Tkw_Form_FoldersTree.GetWordNameForRegister

function Tkw_Form_FoldersTree.GetString: AnsiString;
 {-}
begin
 Result := 'enFoldersTree';
end;//Tkw_Form_FoldersTree.GetString

type
  Tkw_FoldersTree_Control_FoldersTree = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FoldersTree
----
*Пример использования*:
[code]
контрол::FoldersTree TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_FoldersTree_Control_FoldersTree

// start class Tkw_FoldersTree_Control_FoldersTree

class function Tkw_FoldersTree_Control_FoldersTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FoldersTree';
end;//Tkw_FoldersTree_Control_FoldersTree.GetWordNameForRegister

function Tkw_FoldersTree_Control_FoldersTree.GetString: AnsiString;
 {-}
begin
 Result := 'FoldersTree';
end;//Tkw_FoldersTree_Control_FoldersTree.GetString

class procedure Tkw_FoldersTree_Control_FoldersTree.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_FoldersTree_Control_FoldersTree.RegisterInEngine

type
  Tkw_FoldersTree_Control_FoldersTree_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FoldersTree
----
*Пример использования*:
[code]
контрол::FoldersTree:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_FoldersTree_Control_FoldersTree_Push

// start class Tkw_FoldersTree_Control_FoldersTree_Push

procedure Tkw_FoldersTree_Control_FoldersTree_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FoldersTree');
 inherited;
end;//Tkw_FoldersTree_Control_FoldersTree_Push.DoDoIt

class function Tkw_FoldersTree_Control_FoldersTree_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FoldersTree:push';
end;//Tkw_FoldersTree_Control_FoldersTree_Push.GetWordNameForRegister

type
  TkwEnFoldersTreeFoldersTree = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TenFoldersTree.FoldersTree
[panel]Контрол FoldersTree формы TenFoldersTree[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aenFoldersTree .TenFoldersTree.FoldersTree >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
  // private methods
   function FoldersTree(const aCtx: TtfwContext;
     aenFoldersTree: TenFoldersTree): TnscTreeViewWithAdapterDragDrop;
     {* Реализация слова скрипта .TenFoldersTree.FoldersTree }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEnFoldersTreeFoldersTree

// start class TkwEnFoldersTreeFoldersTree

function TkwEnFoldersTreeFoldersTree.FoldersTree(const aCtx: TtfwContext;
  aenFoldersTree: TenFoldersTree): TnscTreeViewWithAdapterDragDrop;
 {-}
begin
 Result := aenFoldersTree.FoldersTree;
end;//TkwEnFoldersTreeFoldersTree.FoldersTree

procedure TkwEnFoldersTreeFoldersTree.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenFoldersTree : TenFoldersTree;
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
 aCtx.rEngine.PushObj((FoldersTree(aCtx, l_aenFoldersTree)));
end;//TkwEnFoldersTreeFoldersTree.DoDoIt

class function TkwEnFoldersTreeFoldersTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenFoldersTree.FoldersTree';
end;//TkwEnFoldersTreeFoldersTree.GetWordNameForRegister

procedure TkwEnFoldersTreeFoldersTree.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FoldersTree', aCtx);
end;//TkwEnFoldersTreeFoldersTree.SetValuePrim

function TkwEnFoldersTreeFoldersTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnFoldersTreeFoldersTree.GetResultTypeInfo

function TkwEnFoldersTreeFoldersTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnFoldersTreeFoldersTree.GetAllParamsCount

function TkwEnFoldersTreeFoldersTree.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenFoldersTree)]);
end;//TkwEnFoldersTreeFoldersTree.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_FoldersTree
 Tkw_Form_FoldersTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FoldersTree_Control_FoldersTree
 Tkw_FoldersTree_Control_FoldersTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FoldersTree_Control_FoldersTree_Push
 Tkw_FoldersTree_Control_FoldersTree_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация enFoldersTree_FoldersTree
 TkwEnFoldersTreeFoldersTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа FoldersTree
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenFoldersTree));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscTreeViewWithAdapterDragDrop
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.