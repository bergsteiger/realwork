unit MemoryUsageKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы MemoryUsage }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MemoryUsageKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , MemoryUsage_Form
 , vtPanel
 , eeTreeView
 , vtSizeablePanel
 , evMemo
 , vtLabel
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
 Tkw_Form_MemoryUsage = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы MemoryUsage
----
*Пример использования*:
[code]
'aControl' форма::MemoryUsage TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_MemoryUsage

 Tkw_MemoryUsage_Control_pnTagTree = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnTagTree
----
*Пример использования*:
[code]
контрол::pnTagTree TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_pnTagTree

 Tkw_MemoryUsage_Control_pnTagTree_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnTagTree
----
*Пример использования*:
[code]
контрол::pnTagTree:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_pnTagTree_Push

 Tkw_MemoryUsage_Control_TagTree = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TagTree
----
*Пример использования*:
[code]
контрол::TagTree TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_TagTree

 Tkw_MemoryUsage_Control_TagTree_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола TagTree
----
*Пример использования*:
[code]
контрол::TagTree:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_TagTree_Push

 Tkw_MemoryUsage_Control_pnMemClasses = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnMemClasses
----
*Пример использования*:
[code]
контрол::pnMemClasses TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_pnMemClasses

 Tkw_MemoryUsage_Control_pnMemClasses_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnMemClasses
----
*Пример использования*:
[code]
контрол::pnMemClasses:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_pnMemClasses_Push

 Tkw_MemoryUsage_Control_memClasses = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола memClasses
----
*Пример использования*:
[code]
контрол::memClasses TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_memClasses

 Tkw_MemoryUsage_Control_memClasses_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола memClasses
----
*Пример использования*:
[code]
контрол::memClasses:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_memClasses_Push

 Tkw_MemoryUsage_Control_pnSummary = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnSummary
----
*Пример использования*:
[code]
контрол::pnSummary TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_pnSummary

 Tkw_MemoryUsage_Control_pnSummary_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnSummary
----
*Пример использования*:
[code]
контрол::pnSummary:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_pnSummary_Push

 Tkw_MemoryUsage_Control_lbLocalMemory = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lbLocalMemory
----
*Пример использования*:
[code]
контрол::lbLocalMemory TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_lbLocalMemory

 Tkw_MemoryUsage_Control_lbLocalMemory_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lbLocalMemory
----
*Пример использования*:
[code]
контрол::lbLocalMemory:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbLocalMemory_Push

 Tkw_MemoryUsage_Control_lbObjectMemory = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lbObjectMemory
----
*Пример использования*:
[code]
контрол::lbObjectMemory TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_lbObjectMemory

 Tkw_MemoryUsage_Control_lbObjectMemory_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lbObjectMemory
----
*Пример использования*:
[code]
контрол::lbObjectMemory:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbObjectMemory_Push

 Tkw_MemoryUsage_Control_lbObjectCount = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lbObjectCount
----
*Пример использования*:
[code]
контрол::lbObjectCount TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_lbObjectCount

 Tkw_MemoryUsage_Control_lbObjectCount_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lbObjectCount
----
*Пример использования*:
[code]
контрол::lbObjectCount:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbObjectCount_Push

 Tkw_MemoryUsage_Control_lbGlobalMemory = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lbGlobalMemory
----
*Пример использования*:
[code]
контрол::lbGlobalMemory TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_lbGlobalMemory

 Tkw_MemoryUsage_Control_lbGlobalMemory_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lbGlobalMemory
----
*Пример использования*:
[code]
контрол::lbGlobalMemory:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbGlobalMemory_Push

 Tkw_MemoryUsage_Control_lbDocumentsInCacheCount = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lbDocumentsInCacheCount
----
*Пример использования*:
[code]
контрол::lbDocumentsInCacheCount TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_lbDocumentsInCacheCount

 Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lbDocumentsInCacheCount
----
*Пример использования*:
[code]
контрол::lbDocumentsInCacheCount:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push

 Tkw_MemoryUsage_Control_lbAllLocalMemory = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lbAllLocalMemory
----
*Пример использования*:
[code]
контрол::lbAllLocalMemory TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_lbAllLocalMemory

 Tkw_MemoryUsage_Control_lbAllLocalMemory_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lbAllLocalMemory
----
*Пример использования*:
[code]
контрол::lbAllLocalMemory:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbAllLocalMemory_Push

 Tkw_MemoryUsage_Control_lbTotalMemory = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lbTotalMemory
----
*Пример использования*:
[code]
контрол::lbTotalMemory TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_lbTotalMemory

 Tkw_MemoryUsage_Control_lbTotalMemory_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lbTotalMemory
----
*Пример использования*:
[code]
контрол::lbTotalMemory:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbTotalMemory_Push

 TkwMemoryUsageFormPnTagTree = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.pnTagTree
[panel]Контрол pnTagTree формы TMemoryUsageForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aMemoryUsageForm .TMemoryUsageForm.pnTagTree >>> l_TvtPanel
[code]  }
  private
   function pnTagTree(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtPanel;
    {* Реализация слова скрипта .TMemoryUsageForm.pnTagTree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMemoryUsageFormPnTagTree

 TkwMemoryUsageFormTagTree = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.TagTree
[panel]Контрол TagTree формы TMemoryUsageForm[panel]
*Тип результата:* TeeTreeView
*Пример:*
[code]
OBJECT VAR l_TeeTreeView
 aMemoryUsageForm .TMemoryUsageForm.TagTree >>> l_TeeTreeView
[code]  }
  private
   function TagTree(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TeeTreeView;
    {* Реализация слова скрипта .TMemoryUsageForm.TagTree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMemoryUsageFormTagTree

 TkwMemoryUsageFormPnMemClasses = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.pnMemClasses
[panel]Контрол pnMemClasses формы TMemoryUsageForm[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aMemoryUsageForm .TMemoryUsageForm.pnMemClasses >>> l_TvtSizeablePanel
[code]  }
  private
   function pnMemClasses(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtSizeablePanel;
    {* Реализация слова скрипта .TMemoryUsageForm.pnMemClasses }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMemoryUsageFormPnMemClasses

 TkwMemoryUsageFormMemClasses = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.memClasses
[panel]Контрол memClasses формы TMemoryUsageForm[panel]
*Тип результата:* TevMemo
*Пример:*
[code]
OBJECT VAR l_TevMemo
 aMemoryUsageForm .TMemoryUsageForm.memClasses >>> l_TevMemo
[code]  }
  private
   function memClasses(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TevMemo;
    {* Реализация слова скрипта .TMemoryUsageForm.memClasses }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMemoryUsageFormMemClasses

 TkwMemoryUsageFormPnSummary = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.pnSummary
[panel]Контрол pnSummary формы TMemoryUsageForm[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aMemoryUsageForm .TMemoryUsageForm.pnSummary >>> l_TvtSizeablePanel
[code]  }
  private
   function pnSummary(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtSizeablePanel;
    {* Реализация слова скрипта .TMemoryUsageForm.pnSummary }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMemoryUsageFormPnSummary

 TkwMemoryUsageFormLbLocalMemory = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.lbLocalMemory
[panel]Контрол lbLocalMemory формы TMemoryUsageForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbLocalMemory >>> l_TvtLabel
[code]  }
  private
   function lbLocalMemory(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
    {* Реализация слова скрипта .TMemoryUsageForm.lbLocalMemory }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMemoryUsageFormLbLocalMemory

 TkwMemoryUsageFormLbObjectMemory = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.lbObjectMemory
[panel]Контрол lbObjectMemory формы TMemoryUsageForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbObjectMemory >>> l_TvtLabel
[code]  }
  private
   function lbObjectMemory(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
    {* Реализация слова скрипта .TMemoryUsageForm.lbObjectMemory }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMemoryUsageFormLbObjectMemory

 TkwMemoryUsageFormLbObjectCount = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.lbObjectCount
[panel]Контрол lbObjectCount формы TMemoryUsageForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbObjectCount >>> l_TvtLabel
[code]  }
  private
   function lbObjectCount(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
    {* Реализация слова скрипта .TMemoryUsageForm.lbObjectCount }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMemoryUsageFormLbObjectCount

 TkwMemoryUsageFormLbGlobalMemory = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.lbGlobalMemory
[panel]Контрол lbGlobalMemory формы TMemoryUsageForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbGlobalMemory >>> l_TvtLabel
[code]  }
  private
   function lbGlobalMemory(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
    {* Реализация слова скрипта .TMemoryUsageForm.lbGlobalMemory }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMemoryUsageFormLbGlobalMemory

 TkwMemoryUsageFormLbDocumentsInCacheCount = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.lbDocumentsInCacheCount
[panel]Контрол lbDocumentsInCacheCount формы TMemoryUsageForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbDocumentsInCacheCount >>> l_TvtLabel
[code]  }
  private
   function lbDocumentsInCacheCount(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
    {* Реализация слова скрипта .TMemoryUsageForm.lbDocumentsInCacheCount }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMemoryUsageFormLbDocumentsInCacheCount

 TkwMemoryUsageFormLbAllLocalMemory = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.lbAllLocalMemory
[panel]Контрол lbAllLocalMemory формы TMemoryUsageForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbAllLocalMemory >>> l_TvtLabel
[code]  }
  private
   function lbAllLocalMemory(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
    {* Реализация слова скрипта .TMemoryUsageForm.lbAllLocalMemory }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMemoryUsageFormLbAllLocalMemory

 TkwMemoryUsageFormLbTotalMemory = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.lbTotalMemory
[panel]Контрол lbTotalMemory формы TMemoryUsageForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbTotalMemory >>> l_TvtLabel
[code]  }
  private
   function lbTotalMemory(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
    {* Реализация слова скрипта .TMemoryUsageForm.lbTotalMemory }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMemoryUsageFormLbTotalMemory

class function Tkw_Form_MemoryUsage.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::MemoryUsage';
end;//Tkw_Form_MemoryUsage.GetWordNameForRegister

function Tkw_Form_MemoryUsage.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_C46273F3DE85_var*
//#UC END# *4DDFD2EA0116_C46273F3DE85_var*
begin
//#UC START# *4DDFD2EA0116_C46273F3DE85_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_C46273F3DE85_impl*
end;//Tkw_Form_MemoryUsage.GetString

class function Tkw_MemoryUsage_Control_pnTagTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnTagTree';
end;//Tkw_MemoryUsage_Control_pnTagTree.GetWordNameForRegister

function Tkw_MemoryUsage_Control_pnTagTree.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B8B8234D479D_var*
//#UC END# *4DDFD2EA0116_B8B8234D479D_var*
begin
//#UC START# *4DDFD2EA0116_B8B8234D479D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B8B8234D479D_impl*
end;//Tkw_MemoryUsage_Control_pnTagTree.GetString

class procedure Tkw_MemoryUsage_Control_pnTagTree.RegisterInEngine;
//#UC START# *52A086150180_B8B8234D479D_var*
//#UC END# *52A086150180_B8B8234D479D_var*
begin
//#UC START# *52A086150180_B8B8234D479D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_B8B8234D479D_impl*
end;//Tkw_MemoryUsage_Control_pnTagTree.RegisterInEngine

procedure Tkw_MemoryUsage_Control_pnTagTree_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2B8ADB3E4BAB_var*
//#UC END# *4DAEEDE10285_2B8ADB3E4BAB_var*
begin
//#UC START# *4DAEEDE10285_2B8ADB3E4BAB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2B8ADB3E4BAB_impl*
end;//Tkw_MemoryUsage_Control_pnTagTree_Push.DoDoIt

class function Tkw_MemoryUsage_Control_pnTagTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnTagTree:push';
end;//Tkw_MemoryUsage_Control_pnTagTree_Push.GetWordNameForRegister

class function Tkw_MemoryUsage_Control_TagTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TagTree';
end;//Tkw_MemoryUsage_Control_TagTree.GetWordNameForRegister

function Tkw_MemoryUsage_Control_TagTree.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_966B7A575E65_var*
//#UC END# *4DDFD2EA0116_966B7A575E65_var*
begin
//#UC START# *4DDFD2EA0116_966B7A575E65_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_966B7A575E65_impl*
end;//Tkw_MemoryUsage_Control_TagTree.GetString

class procedure Tkw_MemoryUsage_Control_TagTree.RegisterInEngine;
//#UC START# *52A086150180_966B7A575E65_var*
//#UC END# *52A086150180_966B7A575E65_var*
begin
//#UC START# *52A086150180_966B7A575E65_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_966B7A575E65_impl*
end;//Tkw_MemoryUsage_Control_TagTree.RegisterInEngine

procedure Tkw_MemoryUsage_Control_TagTree_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1A6D88D07C3A_var*
//#UC END# *4DAEEDE10285_1A6D88D07C3A_var*
begin
//#UC START# *4DAEEDE10285_1A6D88D07C3A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1A6D88D07C3A_impl*
end;//Tkw_MemoryUsage_Control_TagTree_Push.DoDoIt

class function Tkw_MemoryUsage_Control_TagTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TagTree:push';
end;//Tkw_MemoryUsage_Control_TagTree_Push.GetWordNameForRegister

class function Tkw_MemoryUsage_Control_pnMemClasses.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnMemClasses';
end;//Tkw_MemoryUsage_Control_pnMemClasses.GetWordNameForRegister

function Tkw_MemoryUsage_Control_pnMemClasses.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_F54377FF64A3_var*
//#UC END# *4DDFD2EA0116_F54377FF64A3_var*
begin
//#UC START# *4DDFD2EA0116_F54377FF64A3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_F54377FF64A3_impl*
end;//Tkw_MemoryUsage_Control_pnMemClasses.GetString

class procedure Tkw_MemoryUsage_Control_pnMemClasses.RegisterInEngine;
//#UC START# *52A086150180_F54377FF64A3_var*
//#UC END# *52A086150180_F54377FF64A3_var*
begin
//#UC START# *52A086150180_F54377FF64A3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_F54377FF64A3_impl*
end;//Tkw_MemoryUsage_Control_pnMemClasses.RegisterInEngine

procedure Tkw_MemoryUsage_Control_pnMemClasses_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E6BD5B751F50_var*
//#UC END# *4DAEEDE10285_E6BD5B751F50_var*
begin
//#UC START# *4DAEEDE10285_E6BD5B751F50_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E6BD5B751F50_impl*
end;//Tkw_MemoryUsage_Control_pnMemClasses_Push.DoDoIt

class function Tkw_MemoryUsage_Control_pnMemClasses_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnMemClasses:push';
end;//Tkw_MemoryUsage_Control_pnMemClasses_Push.GetWordNameForRegister

class function Tkw_MemoryUsage_Control_memClasses.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::memClasses';
end;//Tkw_MemoryUsage_Control_memClasses.GetWordNameForRegister

function Tkw_MemoryUsage_Control_memClasses.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_03B456A538C5_var*
//#UC END# *4DDFD2EA0116_03B456A538C5_var*
begin
//#UC START# *4DDFD2EA0116_03B456A538C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_03B456A538C5_impl*
end;//Tkw_MemoryUsage_Control_memClasses.GetString

class procedure Tkw_MemoryUsage_Control_memClasses.RegisterInEngine;
//#UC START# *52A086150180_03B456A538C5_var*
//#UC END# *52A086150180_03B456A538C5_var*
begin
//#UC START# *52A086150180_03B456A538C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_03B456A538C5_impl*
end;//Tkw_MemoryUsage_Control_memClasses.RegisterInEngine

procedure Tkw_MemoryUsage_Control_memClasses_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7231EC8B5254_var*
//#UC END# *4DAEEDE10285_7231EC8B5254_var*
begin
//#UC START# *4DAEEDE10285_7231EC8B5254_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7231EC8B5254_impl*
end;//Tkw_MemoryUsage_Control_memClasses_Push.DoDoIt

class function Tkw_MemoryUsage_Control_memClasses_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::memClasses:push';
end;//Tkw_MemoryUsage_Control_memClasses_Push.GetWordNameForRegister

class function Tkw_MemoryUsage_Control_pnSummary.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnSummary';
end;//Tkw_MemoryUsage_Control_pnSummary.GetWordNameForRegister

function Tkw_MemoryUsage_Control_pnSummary.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_F2E3848B2168_var*
//#UC END# *4DDFD2EA0116_F2E3848B2168_var*
begin
//#UC START# *4DDFD2EA0116_F2E3848B2168_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_F2E3848B2168_impl*
end;//Tkw_MemoryUsage_Control_pnSummary.GetString

class procedure Tkw_MemoryUsage_Control_pnSummary.RegisterInEngine;
//#UC START# *52A086150180_F2E3848B2168_var*
//#UC END# *52A086150180_F2E3848B2168_var*
begin
//#UC START# *52A086150180_F2E3848B2168_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_F2E3848B2168_impl*
end;//Tkw_MemoryUsage_Control_pnSummary.RegisterInEngine

procedure Tkw_MemoryUsage_Control_pnSummary_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_66C015F95443_var*
//#UC END# *4DAEEDE10285_66C015F95443_var*
begin
//#UC START# *4DAEEDE10285_66C015F95443_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_66C015F95443_impl*
end;//Tkw_MemoryUsage_Control_pnSummary_Push.DoDoIt

class function Tkw_MemoryUsage_Control_pnSummary_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnSummary:push';
end;//Tkw_MemoryUsage_Control_pnSummary_Push.GetWordNameForRegister

class function Tkw_MemoryUsage_Control_lbLocalMemory.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbLocalMemory';
end;//Tkw_MemoryUsage_Control_lbLocalMemory.GetWordNameForRegister

function Tkw_MemoryUsage_Control_lbLocalMemory.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7AC0162D5AE6_var*
//#UC END# *4DDFD2EA0116_7AC0162D5AE6_var*
begin
//#UC START# *4DDFD2EA0116_7AC0162D5AE6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7AC0162D5AE6_impl*
end;//Tkw_MemoryUsage_Control_lbLocalMemory.GetString

class procedure Tkw_MemoryUsage_Control_lbLocalMemory.RegisterInEngine;
//#UC START# *52A086150180_7AC0162D5AE6_var*
//#UC END# *52A086150180_7AC0162D5AE6_var*
begin
//#UC START# *52A086150180_7AC0162D5AE6_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_7AC0162D5AE6_impl*
end;//Tkw_MemoryUsage_Control_lbLocalMemory.RegisterInEngine

procedure Tkw_MemoryUsage_Control_lbLocalMemory_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0149117F15F3_var*
//#UC END# *4DAEEDE10285_0149117F15F3_var*
begin
//#UC START# *4DAEEDE10285_0149117F15F3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0149117F15F3_impl*
end;//Tkw_MemoryUsage_Control_lbLocalMemory_Push.DoDoIt

class function Tkw_MemoryUsage_Control_lbLocalMemory_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbLocalMemory:push';
end;//Tkw_MemoryUsage_Control_lbLocalMemory_Push.GetWordNameForRegister

class function Tkw_MemoryUsage_Control_lbObjectMemory.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbObjectMemory';
end;//Tkw_MemoryUsage_Control_lbObjectMemory.GetWordNameForRegister

function Tkw_MemoryUsage_Control_lbObjectMemory.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_F4598BFCA9FD_var*
//#UC END# *4DDFD2EA0116_F4598BFCA9FD_var*
begin
//#UC START# *4DDFD2EA0116_F4598BFCA9FD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_F4598BFCA9FD_impl*
end;//Tkw_MemoryUsage_Control_lbObjectMemory.GetString

class procedure Tkw_MemoryUsage_Control_lbObjectMemory.RegisterInEngine;
//#UC START# *52A086150180_F4598BFCA9FD_var*
//#UC END# *52A086150180_F4598BFCA9FD_var*
begin
//#UC START# *52A086150180_F4598BFCA9FD_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_F4598BFCA9FD_impl*
end;//Tkw_MemoryUsage_Control_lbObjectMemory.RegisterInEngine

procedure Tkw_MemoryUsage_Control_lbObjectMemory_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E4784471AEA_var*
//#UC END# *4DAEEDE10285_4E4784471AEA_var*
begin
//#UC START# *4DAEEDE10285_4E4784471AEA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4E4784471AEA_impl*
end;//Tkw_MemoryUsage_Control_lbObjectMemory_Push.DoDoIt

class function Tkw_MemoryUsage_Control_lbObjectMemory_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbObjectMemory:push';
end;//Tkw_MemoryUsage_Control_lbObjectMemory_Push.GetWordNameForRegister

class function Tkw_MemoryUsage_Control_lbObjectCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbObjectCount';
end;//Tkw_MemoryUsage_Control_lbObjectCount.GetWordNameForRegister

function Tkw_MemoryUsage_Control_lbObjectCount.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_2F0028625D3B_var*
//#UC END# *4DDFD2EA0116_2F0028625D3B_var*
begin
//#UC START# *4DDFD2EA0116_2F0028625D3B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_2F0028625D3B_impl*
end;//Tkw_MemoryUsage_Control_lbObjectCount.GetString

class procedure Tkw_MemoryUsage_Control_lbObjectCount.RegisterInEngine;
//#UC START# *52A086150180_2F0028625D3B_var*
//#UC END# *52A086150180_2F0028625D3B_var*
begin
//#UC START# *52A086150180_2F0028625D3B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_2F0028625D3B_impl*
end;//Tkw_MemoryUsage_Control_lbObjectCount.RegisterInEngine

procedure Tkw_MemoryUsage_Control_lbObjectCount_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FBA0A0069B48_var*
//#UC END# *4DAEEDE10285_FBA0A0069B48_var*
begin
//#UC START# *4DAEEDE10285_FBA0A0069B48_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FBA0A0069B48_impl*
end;//Tkw_MemoryUsage_Control_lbObjectCount_Push.DoDoIt

class function Tkw_MemoryUsage_Control_lbObjectCount_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbObjectCount:push';
end;//Tkw_MemoryUsage_Control_lbObjectCount_Push.GetWordNameForRegister

class function Tkw_MemoryUsage_Control_lbGlobalMemory.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbGlobalMemory';
end;//Tkw_MemoryUsage_Control_lbGlobalMemory.GetWordNameForRegister

function Tkw_MemoryUsage_Control_lbGlobalMemory.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_A8C4FF78BAC2_var*
//#UC END# *4DDFD2EA0116_A8C4FF78BAC2_var*
begin
//#UC START# *4DDFD2EA0116_A8C4FF78BAC2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_A8C4FF78BAC2_impl*
end;//Tkw_MemoryUsage_Control_lbGlobalMemory.GetString

class procedure Tkw_MemoryUsage_Control_lbGlobalMemory.RegisterInEngine;
//#UC START# *52A086150180_A8C4FF78BAC2_var*
//#UC END# *52A086150180_A8C4FF78BAC2_var*
begin
//#UC START# *52A086150180_A8C4FF78BAC2_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_A8C4FF78BAC2_impl*
end;//Tkw_MemoryUsage_Control_lbGlobalMemory.RegisterInEngine

procedure Tkw_MemoryUsage_Control_lbGlobalMemory_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E7B3A380F8CB_var*
//#UC END# *4DAEEDE10285_E7B3A380F8CB_var*
begin
//#UC START# *4DAEEDE10285_E7B3A380F8CB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E7B3A380F8CB_impl*
end;//Tkw_MemoryUsage_Control_lbGlobalMemory_Push.DoDoIt

class function Tkw_MemoryUsage_Control_lbGlobalMemory_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbGlobalMemory:push';
end;//Tkw_MemoryUsage_Control_lbGlobalMemory_Push.GetWordNameForRegister

class function Tkw_MemoryUsage_Control_lbDocumentsInCacheCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbDocumentsInCacheCount';
end;//Tkw_MemoryUsage_Control_lbDocumentsInCacheCount.GetWordNameForRegister

function Tkw_MemoryUsage_Control_lbDocumentsInCacheCount.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_A18DEA0CC219_var*
//#UC END# *4DDFD2EA0116_A18DEA0CC219_var*
begin
//#UC START# *4DDFD2EA0116_A18DEA0CC219_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_A18DEA0CC219_impl*
end;//Tkw_MemoryUsage_Control_lbDocumentsInCacheCount.GetString

class procedure Tkw_MemoryUsage_Control_lbDocumentsInCacheCount.RegisterInEngine;
//#UC START# *52A086150180_A18DEA0CC219_var*
//#UC END# *52A086150180_A18DEA0CC219_var*
begin
//#UC START# *52A086150180_A18DEA0CC219_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_A18DEA0CC219_impl*
end;//Tkw_MemoryUsage_Control_lbDocumentsInCacheCount.RegisterInEngine

procedure Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2DF09D01B920_var*
//#UC END# *4DAEEDE10285_2DF09D01B920_var*
begin
//#UC START# *4DAEEDE10285_2DF09D01B920_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2DF09D01B920_impl*
end;//Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push.DoDoIt

class function Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbDocumentsInCacheCount:push';
end;//Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push.GetWordNameForRegister

class function Tkw_MemoryUsage_Control_lbAllLocalMemory.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbAllLocalMemory';
end;//Tkw_MemoryUsage_Control_lbAllLocalMemory.GetWordNameForRegister

function Tkw_MemoryUsage_Control_lbAllLocalMemory.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_08E90BBD2FC7_var*
//#UC END# *4DDFD2EA0116_08E90BBD2FC7_var*
begin
//#UC START# *4DDFD2EA0116_08E90BBD2FC7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_08E90BBD2FC7_impl*
end;//Tkw_MemoryUsage_Control_lbAllLocalMemory.GetString

class procedure Tkw_MemoryUsage_Control_lbAllLocalMemory.RegisterInEngine;
//#UC START# *52A086150180_08E90BBD2FC7_var*
//#UC END# *52A086150180_08E90BBD2FC7_var*
begin
//#UC START# *52A086150180_08E90BBD2FC7_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_08E90BBD2FC7_impl*
end;//Tkw_MemoryUsage_Control_lbAllLocalMemory.RegisterInEngine

procedure Tkw_MemoryUsage_Control_lbAllLocalMemory_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2114340BE91E_var*
//#UC END# *4DAEEDE10285_2114340BE91E_var*
begin
//#UC START# *4DAEEDE10285_2114340BE91E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2114340BE91E_impl*
end;//Tkw_MemoryUsage_Control_lbAllLocalMemory_Push.DoDoIt

class function Tkw_MemoryUsage_Control_lbAllLocalMemory_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbAllLocalMemory:push';
end;//Tkw_MemoryUsage_Control_lbAllLocalMemory_Push.GetWordNameForRegister

class function Tkw_MemoryUsage_Control_lbTotalMemory.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbTotalMemory';
end;//Tkw_MemoryUsage_Control_lbTotalMemory.GetWordNameForRegister

function Tkw_MemoryUsage_Control_lbTotalMemory.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_91937EDCF2D0_var*
//#UC END# *4DDFD2EA0116_91937EDCF2D0_var*
begin
//#UC START# *4DDFD2EA0116_91937EDCF2D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_91937EDCF2D0_impl*
end;//Tkw_MemoryUsage_Control_lbTotalMemory.GetString

class procedure Tkw_MemoryUsage_Control_lbTotalMemory.RegisterInEngine;
//#UC START# *52A086150180_91937EDCF2D0_var*
//#UC END# *52A086150180_91937EDCF2D0_var*
begin
//#UC START# *52A086150180_91937EDCF2D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_91937EDCF2D0_impl*
end;//Tkw_MemoryUsage_Control_lbTotalMemory.RegisterInEngine

procedure Tkw_MemoryUsage_Control_lbTotalMemory_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1960238DD758_var*
//#UC END# *4DAEEDE10285_1960238DD758_var*
begin
//#UC START# *4DAEEDE10285_1960238DD758_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1960238DD758_impl*
end;//Tkw_MemoryUsage_Control_lbTotalMemory_Push.DoDoIt

class function Tkw_MemoryUsage_Control_lbTotalMemory_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbTotalMemory:push';
end;//Tkw_MemoryUsage_Control_lbTotalMemory_Push.GetWordNameForRegister

function TkwMemoryUsageFormPnTagTree.pnTagTree(const aCtx: TtfwContext;
 aMemoryUsageForm: TMemoryUsageForm): TvtPanel;
 {* Реализация слова скрипта .TMemoryUsageForm.pnTagTree }
//#UC START# *FB899715DA26_EB9FBD616CB1_var*
//#UC END# *FB899715DA26_EB9FBD616CB1_var*
begin
//#UC START# *FB899715DA26_EB9FBD616CB1_impl*
 !!! Needs to be implemented !!!
//#UC END# *FB899715DA26_EB9FBD616CB1_impl*
end;//TkwMemoryUsageFormPnTagTree.pnTagTree

procedure TkwMemoryUsageFormPnTagTree.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_EB9FBD616CB1_var*
//#UC END# *4DAEEDE10285_EB9FBD616CB1_var*
begin
//#UC START# *4DAEEDE10285_EB9FBD616CB1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_EB9FBD616CB1_impl*
end;//TkwMemoryUsageFormPnTagTree.DoDoIt

class function TkwMemoryUsageFormPnTagTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMemoryUsageForm.pnTagTree';
end;//TkwMemoryUsageFormPnTagTree.GetWordNameForRegister

procedure TkwMemoryUsageFormPnTagTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwMemoryUsageFormPnTagTree.SetValuePrim

function TkwMemoryUsageFormPnTagTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwMemoryUsageFormPnTagTree.GetResultTypeInfo

function TkwMemoryUsageFormPnTagTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMemoryUsageFormPnTagTree.GetAllParamsCount

function TkwMemoryUsageFormPnTagTree.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwMemoryUsageFormPnTagTree.ParamsTypes

function TkwMemoryUsageFormTagTree.TagTree(const aCtx: TtfwContext;
 aMemoryUsageForm: TMemoryUsageForm): TeeTreeView;
 {* Реализация слова скрипта .TMemoryUsageForm.TagTree }
//#UC START# *DEF0323103B0_6187FA2B989D_var*
//#UC END# *DEF0323103B0_6187FA2B989D_var*
begin
//#UC START# *DEF0323103B0_6187FA2B989D_impl*
 !!! Needs to be implemented !!!
//#UC END# *DEF0323103B0_6187FA2B989D_impl*
end;//TkwMemoryUsageFormTagTree.TagTree

procedure TkwMemoryUsageFormTagTree.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6187FA2B989D_var*
//#UC END# *4DAEEDE10285_6187FA2B989D_var*
begin
//#UC START# *4DAEEDE10285_6187FA2B989D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6187FA2B989D_impl*
end;//TkwMemoryUsageFormTagTree.DoDoIt

class function TkwMemoryUsageFormTagTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMemoryUsageForm.TagTree';
end;//TkwMemoryUsageFormTagTree.GetWordNameForRegister

procedure TkwMemoryUsageFormTagTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwMemoryUsageFormTagTree.SetValuePrim

function TkwMemoryUsageFormTagTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeTreeView);
end;//TkwMemoryUsageFormTagTree.GetResultTypeInfo

function TkwMemoryUsageFormTagTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMemoryUsageFormTagTree.GetAllParamsCount

function TkwMemoryUsageFormTagTree.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwMemoryUsageFormTagTree.ParamsTypes

function TkwMemoryUsageFormPnMemClasses.pnMemClasses(const aCtx: TtfwContext;
 aMemoryUsageForm: TMemoryUsageForm): TvtSizeablePanel;
 {* Реализация слова скрипта .TMemoryUsageForm.pnMemClasses }
//#UC START# *F9E00C7D83AD_0A1F937A1E8B_var*
//#UC END# *F9E00C7D83AD_0A1F937A1E8B_var*
begin
//#UC START# *F9E00C7D83AD_0A1F937A1E8B_impl*
 !!! Needs to be implemented !!!
//#UC END# *F9E00C7D83AD_0A1F937A1E8B_impl*
end;//TkwMemoryUsageFormPnMemClasses.pnMemClasses

procedure TkwMemoryUsageFormPnMemClasses.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0A1F937A1E8B_var*
//#UC END# *4DAEEDE10285_0A1F937A1E8B_var*
begin
//#UC START# *4DAEEDE10285_0A1F937A1E8B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0A1F937A1E8B_impl*
end;//TkwMemoryUsageFormPnMemClasses.DoDoIt

class function TkwMemoryUsageFormPnMemClasses.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMemoryUsageForm.pnMemClasses';
end;//TkwMemoryUsageFormPnMemClasses.GetWordNameForRegister

procedure TkwMemoryUsageFormPnMemClasses.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwMemoryUsageFormPnMemClasses.SetValuePrim

function TkwMemoryUsageFormPnMemClasses.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwMemoryUsageFormPnMemClasses.GetResultTypeInfo

function TkwMemoryUsageFormPnMemClasses.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMemoryUsageFormPnMemClasses.GetAllParamsCount

function TkwMemoryUsageFormPnMemClasses.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwMemoryUsageFormPnMemClasses.ParamsTypes

function TkwMemoryUsageFormMemClasses.memClasses(const aCtx: TtfwContext;
 aMemoryUsageForm: TMemoryUsageForm): TevMemo;
 {* Реализация слова скрипта .TMemoryUsageForm.memClasses }
//#UC START# *E85CF669A112_C31096E13498_var*
//#UC END# *E85CF669A112_C31096E13498_var*
begin
//#UC START# *E85CF669A112_C31096E13498_impl*
 !!! Needs to be implemented !!!
//#UC END# *E85CF669A112_C31096E13498_impl*
end;//TkwMemoryUsageFormMemClasses.memClasses

procedure TkwMemoryUsageFormMemClasses.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C31096E13498_var*
//#UC END# *4DAEEDE10285_C31096E13498_var*
begin
//#UC START# *4DAEEDE10285_C31096E13498_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C31096E13498_impl*
end;//TkwMemoryUsageFormMemClasses.DoDoIt

class function TkwMemoryUsageFormMemClasses.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMemoryUsageForm.memClasses';
end;//TkwMemoryUsageFormMemClasses.GetWordNameForRegister

procedure TkwMemoryUsageFormMemClasses.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwMemoryUsageFormMemClasses.SetValuePrim

function TkwMemoryUsageFormMemClasses.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TevMemo);
end;//TkwMemoryUsageFormMemClasses.GetResultTypeInfo

function TkwMemoryUsageFormMemClasses.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMemoryUsageFormMemClasses.GetAllParamsCount

function TkwMemoryUsageFormMemClasses.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwMemoryUsageFormMemClasses.ParamsTypes

function TkwMemoryUsageFormPnSummary.pnSummary(const aCtx: TtfwContext;
 aMemoryUsageForm: TMemoryUsageForm): TvtSizeablePanel;
 {* Реализация слова скрипта .TMemoryUsageForm.pnSummary }
//#UC START# *28694A4D0DF1_9F88B97A0726_var*
//#UC END# *28694A4D0DF1_9F88B97A0726_var*
begin
//#UC START# *28694A4D0DF1_9F88B97A0726_impl*
 !!! Needs to be implemented !!!
//#UC END# *28694A4D0DF1_9F88B97A0726_impl*
end;//TkwMemoryUsageFormPnSummary.pnSummary

procedure TkwMemoryUsageFormPnSummary.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9F88B97A0726_var*
//#UC END# *4DAEEDE10285_9F88B97A0726_var*
begin
//#UC START# *4DAEEDE10285_9F88B97A0726_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9F88B97A0726_impl*
end;//TkwMemoryUsageFormPnSummary.DoDoIt

class function TkwMemoryUsageFormPnSummary.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMemoryUsageForm.pnSummary';
end;//TkwMemoryUsageFormPnSummary.GetWordNameForRegister

procedure TkwMemoryUsageFormPnSummary.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwMemoryUsageFormPnSummary.SetValuePrim

function TkwMemoryUsageFormPnSummary.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwMemoryUsageFormPnSummary.GetResultTypeInfo

function TkwMemoryUsageFormPnSummary.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMemoryUsageFormPnSummary.GetAllParamsCount

function TkwMemoryUsageFormPnSummary.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwMemoryUsageFormPnSummary.ParamsTypes

function TkwMemoryUsageFormLbLocalMemory.lbLocalMemory(const aCtx: TtfwContext;
 aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
 {* Реализация слова скрипта .TMemoryUsageForm.lbLocalMemory }
//#UC START# *0DCB95CB8FF3_67E3D725FC3F_var*
//#UC END# *0DCB95CB8FF3_67E3D725FC3F_var*
begin
//#UC START# *0DCB95CB8FF3_67E3D725FC3F_impl*
 !!! Needs to be implemented !!!
//#UC END# *0DCB95CB8FF3_67E3D725FC3F_impl*
end;//TkwMemoryUsageFormLbLocalMemory.lbLocalMemory

procedure TkwMemoryUsageFormLbLocalMemory.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_67E3D725FC3F_var*
//#UC END# *4DAEEDE10285_67E3D725FC3F_var*
begin
//#UC START# *4DAEEDE10285_67E3D725FC3F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_67E3D725FC3F_impl*
end;//TkwMemoryUsageFormLbLocalMemory.DoDoIt

class function TkwMemoryUsageFormLbLocalMemory.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMemoryUsageForm.lbLocalMemory';
end;//TkwMemoryUsageFormLbLocalMemory.GetWordNameForRegister

procedure TkwMemoryUsageFormLbLocalMemory.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwMemoryUsageFormLbLocalMemory.SetValuePrim

function TkwMemoryUsageFormLbLocalMemory.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwMemoryUsageFormLbLocalMemory.GetResultTypeInfo

function TkwMemoryUsageFormLbLocalMemory.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMemoryUsageFormLbLocalMemory.GetAllParamsCount

function TkwMemoryUsageFormLbLocalMemory.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwMemoryUsageFormLbLocalMemory.ParamsTypes

function TkwMemoryUsageFormLbObjectMemory.lbObjectMemory(const aCtx: TtfwContext;
 aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
 {* Реализация слова скрипта .TMemoryUsageForm.lbObjectMemory }
//#UC START# *D2A96F2A0A03_C36040A1C157_var*
//#UC END# *D2A96F2A0A03_C36040A1C157_var*
begin
//#UC START# *D2A96F2A0A03_C36040A1C157_impl*
 !!! Needs to be implemented !!!
//#UC END# *D2A96F2A0A03_C36040A1C157_impl*
end;//TkwMemoryUsageFormLbObjectMemory.lbObjectMemory

procedure TkwMemoryUsageFormLbObjectMemory.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C36040A1C157_var*
//#UC END# *4DAEEDE10285_C36040A1C157_var*
begin
//#UC START# *4DAEEDE10285_C36040A1C157_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C36040A1C157_impl*
end;//TkwMemoryUsageFormLbObjectMemory.DoDoIt

class function TkwMemoryUsageFormLbObjectMemory.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMemoryUsageForm.lbObjectMemory';
end;//TkwMemoryUsageFormLbObjectMemory.GetWordNameForRegister

procedure TkwMemoryUsageFormLbObjectMemory.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwMemoryUsageFormLbObjectMemory.SetValuePrim

function TkwMemoryUsageFormLbObjectMemory.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwMemoryUsageFormLbObjectMemory.GetResultTypeInfo

function TkwMemoryUsageFormLbObjectMemory.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMemoryUsageFormLbObjectMemory.GetAllParamsCount

function TkwMemoryUsageFormLbObjectMemory.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwMemoryUsageFormLbObjectMemory.ParamsTypes

function TkwMemoryUsageFormLbObjectCount.lbObjectCount(const aCtx: TtfwContext;
 aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
 {* Реализация слова скрипта .TMemoryUsageForm.lbObjectCount }
//#UC START# *5A594FFE9B2A_DD2F688CA4C3_var*
//#UC END# *5A594FFE9B2A_DD2F688CA4C3_var*
begin
//#UC START# *5A594FFE9B2A_DD2F688CA4C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *5A594FFE9B2A_DD2F688CA4C3_impl*
end;//TkwMemoryUsageFormLbObjectCount.lbObjectCount

procedure TkwMemoryUsageFormLbObjectCount.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DD2F688CA4C3_var*
//#UC END# *4DAEEDE10285_DD2F688CA4C3_var*
begin
//#UC START# *4DAEEDE10285_DD2F688CA4C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DD2F688CA4C3_impl*
end;//TkwMemoryUsageFormLbObjectCount.DoDoIt

class function TkwMemoryUsageFormLbObjectCount.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMemoryUsageForm.lbObjectCount';
end;//TkwMemoryUsageFormLbObjectCount.GetWordNameForRegister

procedure TkwMemoryUsageFormLbObjectCount.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwMemoryUsageFormLbObjectCount.SetValuePrim

function TkwMemoryUsageFormLbObjectCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwMemoryUsageFormLbObjectCount.GetResultTypeInfo

function TkwMemoryUsageFormLbObjectCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMemoryUsageFormLbObjectCount.GetAllParamsCount

function TkwMemoryUsageFormLbObjectCount.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwMemoryUsageFormLbObjectCount.ParamsTypes

function TkwMemoryUsageFormLbGlobalMemory.lbGlobalMemory(const aCtx: TtfwContext;
 aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
 {* Реализация слова скрипта .TMemoryUsageForm.lbGlobalMemory }
//#UC START# *248498A409BE_E1C674926073_var*
//#UC END# *248498A409BE_E1C674926073_var*
begin
//#UC START# *248498A409BE_E1C674926073_impl*
 !!! Needs to be implemented !!!
//#UC END# *248498A409BE_E1C674926073_impl*
end;//TkwMemoryUsageFormLbGlobalMemory.lbGlobalMemory

procedure TkwMemoryUsageFormLbGlobalMemory.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E1C674926073_var*
//#UC END# *4DAEEDE10285_E1C674926073_var*
begin
//#UC START# *4DAEEDE10285_E1C674926073_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E1C674926073_impl*
end;//TkwMemoryUsageFormLbGlobalMemory.DoDoIt

class function TkwMemoryUsageFormLbGlobalMemory.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMemoryUsageForm.lbGlobalMemory';
end;//TkwMemoryUsageFormLbGlobalMemory.GetWordNameForRegister

procedure TkwMemoryUsageFormLbGlobalMemory.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwMemoryUsageFormLbGlobalMemory.SetValuePrim

function TkwMemoryUsageFormLbGlobalMemory.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwMemoryUsageFormLbGlobalMemory.GetResultTypeInfo

function TkwMemoryUsageFormLbGlobalMemory.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMemoryUsageFormLbGlobalMemory.GetAllParamsCount

function TkwMemoryUsageFormLbGlobalMemory.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwMemoryUsageFormLbGlobalMemory.ParamsTypes

function TkwMemoryUsageFormLbDocumentsInCacheCount.lbDocumentsInCacheCount(const aCtx: TtfwContext;
 aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
 {* Реализация слова скрипта .TMemoryUsageForm.lbDocumentsInCacheCount }
//#UC START# *21E829CB9338_AF077E188BE6_var*
//#UC END# *21E829CB9338_AF077E188BE6_var*
begin
//#UC START# *21E829CB9338_AF077E188BE6_impl*
 !!! Needs to be implemented !!!
//#UC END# *21E829CB9338_AF077E188BE6_impl*
end;//TkwMemoryUsageFormLbDocumentsInCacheCount.lbDocumentsInCacheCount

procedure TkwMemoryUsageFormLbDocumentsInCacheCount.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_AF077E188BE6_var*
//#UC END# *4DAEEDE10285_AF077E188BE6_var*
begin
//#UC START# *4DAEEDE10285_AF077E188BE6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_AF077E188BE6_impl*
end;//TkwMemoryUsageFormLbDocumentsInCacheCount.DoDoIt

class function TkwMemoryUsageFormLbDocumentsInCacheCount.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMemoryUsageForm.lbDocumentsInCacheCount';
end;//TkwMemoryUsageFormLbDocumentsInCacheCount.GetWordNameForRegister

procedure TkwMemoryUsageFormLbDocumentsInCacheCount.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwMemoryUsageFormLbDocumentsInCacheCount.SetValuePrim

function TkwMemoryUsageFormLbDocumentsInCacheCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwMemoryUsageFormLbDocumentsInCacheCount.GetResultTypeInfo

function TkwMemoryUsageFormLbDocumentsInCacheCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMemoryUsageFormLbDocumentsInCacheCount.GetAllParamsCount

function TkwMemoryUsageFormLbDocumentsInCacheCount.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwMemoryUsageFormLbDocumentsInCacheCount.ParamsTypes

function TkwMemoryUsageFormLbAllLocalMemory.lbAllLocalMemory(const aCtx: TtfwContext;
 aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
 {* Реализация слова скрипта .TMemoryUsageForm.lbAllLocalMemory }
//#UC START# *B9F9A5B26A78_BCDCCCE325BD_var*
//#UC END# *B9F9A5B26A78_BCDCCCE325BD_var*
begin
//#UC START# *B9F9A5B26A78_BCDCCCE325BD_impl*
 !!! Needs to be implemented !!!
//#UC END# *B9F9A5B26A78_BCDCCCE325BD_impl*
end;//TkwMemoryUsageFormLbAllLocalMemory.lbAllLocalMemory

procedure TkwMemoryUsageFormLbAllLocalMemory.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BCDCCCE325BD_var*
//#UC END# *4DAEEDE10285_BCDCCCE325BD_var*
begin
//#UC START# *4DAEEDE10285_BCDCCCE325BD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BCDCCCE325BD_impl*
end;//TkwMemoryUsageFormLbAllLocalMemory.DoDoIt

class function TkwMemoryUsageFormLbAllLocalMemory.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMemoryUsageForm.lbAllLocalMemory';
end;//TkwMemoryUsageFormLbAllLocalMemory.GetWordNameForRegister

procedure TkwMemoryUsageFormLbAllLocalMemory.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwMemoryUsageFormLbAllLocalMemory.SetValuePrim

function TkwMemoryUsageFormLbAllLocalMemory.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwMemoryUsageFormLbAllLocalMemory.GetResultTypeInfo

function TkwMemoryUsageFormLbAllLocalMemory.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMemoryUsageFormLbAllLocalMemory.GetAllParamsCount

function TkwMemoryUsageFormLbAllLocalMemory.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwMemoryUsageFormLbAllLocalMemory.ParamsTypes

function TkwMemoryUsageFormLbTotalMemory.lbTotalMemory(const aCtx: TtfwContext;
 aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
 {* Реализация слова скрипта .TMemoryUsageForm.lbTotalMemory }
//#UC START# *565E905EC89D_E93F88B4464E_var*
//#UC END# *565E905EC89D_E93F88B4464E_var*
begin
//#UC START# *565E905EC89D_E93F88B4464E_impl*
 !!! Needs to be implemented !!!
//#UC END# *565E905EC89D_E93F88B4464E_impl*
end;//TkwMemoryUsageFormLbTotalMemory.lbTotalMemory

procedure TkwMemoryUsageFormLbTotalMemory.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E93F88B4464E_var*
//#UC END# *4DAEEDE10285_E93F88B4464E_var*
begin
//#UC START# *4DAEEDE10285_E93F88B4464E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E93F88B4464E_impl*
end;//TkwMemoryUsageFormLbTotalMemory.DoDoIt

class function TkwMemoryUsageFormLbTotalMemory.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMemoryUsageForm.lbTotalMemory';
end;//TkwMemoryUsageFormLbTotalMemory.GetWordNameForRegister

procedure TkwMemoryUsageFormLbTotalMemory.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwMemoryUsageFormLbTotalMemory.SetValuePrim

function TkwMemoryUsageFormLbTotalMemory.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwMemoryUsageFormLbTotalMemory.GetResultTypeInfo

function TkwMemoryUsageFormLbTotalMemory.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMemoryUsageFormLbTotalMemory.GetAllParamsCount

function TkwMemoryUsageFormLbTotalMemory.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwMemoryUsageFormLbTotalMemory.ParamsTypes

initialization
 Tkw_Form_MemoryUsage.RegisterInEngine;
 {* Регистрация Tkw_Form_MemoryUsage }
 Tkw_MemoryUsage_Control_pnTagTree.RegisterInEngine;
 {* Регистрация Tkw_MemoryUsage_Control_pnTagTree }
 Tkw_MemoryUsage_Control_pnTagTree_Push.RegisterInEngine;
 {* Регистрация Tkw_MemoryUsage_Control_pnTagTree_Push }
 Tkw_MemoryUsage_Control_TagTree.RegisterInEngine;
 {* Регистрация Tkw_MemoryUsage_Control_TagTree }
 Tkw_MemoryUsage_Control_TagTree_Push.RegisterInEngine;
 {* Регистрация Tkw_MemoryUsage_Control_TagTree_Push }
 Tkw_MemoryUsage_Control_pnMemClasses.RegisterInEngine;
 {* Регистрация Tkw_MemoryUsage_Control_pnMemClasses }
 Tkw_MemoryUsage_Control_pnMemClasses_Push.RegisterInEngine;
 {* Регистрация Tkw_MemoryUsage_Control_pnMemClasses_Push }
 Tkw_MemoryUsage_Control_memClasses.RegisterInEngine;
 {* Регистрация Tkw_MemoryUsage_Control_memClasses }
 Tkw_MemoryUsage_Control_memClasses_Push.RegisterInEngine;
 {* Регистрация Tkw_MemoryUsage_Control_memClasses_Push }
 Tkw_MemoryUsage_Control_pnSummary.RegisterInEngine;
 {* Регистрация Tkw_MemoryUsage_Control_pnSummary }
 Tkw_MemoryUsage_Control_pnSummary_Push.RegisterInEngine;
 {* Регистрация Tkw_MemoryUsage_Control_pnSummary_Push }
 Tkw_MemoryUsage_Control_lbLocalMemory.RegisterInEngine;
 {* Регистрация Tkw_MemoryUsage_Control_lbLocalMemory }
 Tkw_MemoryUsage_Control_lbLocalMemory_Push.RegisterInEngine;
 {* Регистрация Tkw_MemoryUsage_Control_lbLocalMemory_Push }
 Tkw_MemoryUsage_Control_lbObjectMemory.RegisterInEngine;
 {* Регистрация Tkw_MemoryUsage_Control_lbObjectMemory }
 Tkw_MemoryUsage_Control_lbObjectMemory_Push.RegisterInEngine;
 {* Регистрация Tkw_MemoryUsage_Control_lbObjectMemory_Push }
 Tkw_MemoryUsage_Control_lbObjectCount.RegisterInEngine;
 {* Регистрация Tkw_MemoryUsage_Control_lbObjectCount }
 Tkw_MemoryUsage_Control_lbObjectCount_Push.RegisterInEngine;
 {* Регистрация Tkw_MemoryUsage_Control_lbObjectCount_Push }
 Tkw_MemoryUsage_Control_lbGlobalMemory.RegisterInEngine;
 {* Регистрация Tkw_MemoryUsage_Control_lbGlobalMemory }
 Tkw_MemoryUsage_Control_lbGlobalMemory_Push.RegisterInEngine;
 {* Регистрация Tkw_MemoryUsage_Control_lbGlobalMemory_Push }
 Tkw_MemoryUsage_Control_lbDocumentsInCacheCount.RegisterInEngine;
 {* Регистрация Tkw_MemoryUsage_Control_lbDocumentsInCacheCount }
 Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push.RegisterInEngine;
 {* Регистрация Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push }
 Tkw_MemoryUsage_Control_lbAllLocalMemory.RegisterInEngine;
 {* Регистрация Tkw_MemoryUsage_Control_lbAllLocalMemory }
 Tkw_MemoryUsage_Control_lbAllLocalMemory_Push.RegisterInEngine;
 {* Регистрация Tkw_MemoryUsage_Control_lbAllLocalMemory_Push }
 Tkw_MemoryUsage_Control_lbTotalMemory.RegisterInEngine;
 {* Регистрация Tkw_MemoryUsage_Control_lbTotalMemory }
 Tkw_MemoryUsage_Control_lbTotalMemory_Push.RegisterInEngine;
 {* Регистрация Tkw_MemoryUsage_Control_lbTotalMemory_Push }
 TkwMemoryUsageFormPnTagTree.RegisterInEngine;
 {* Регистрация MemoryUsageForm_pnTagTree }
 TkwMemoryUsageFormTagTree.RegisterInEngine;
 {* Регистрация MemoryUsageForm_TagTree }
 TkwMemoryUsageFormPnMemClasses.RegisterInEngine;
 {* Регистрация MemoryUsageForm_pnMemClasses }
 TkwMemoryUsageFormMemClasses.RegisterInEngine;
 {* Регистрация MemoryUsageForm_memClasses }
 TkwMemoryUsageFormPnSummary.RegisterInEngine;
 {* Регистрация MemoryUsageForm_pnSummary }
 TkwMemoryUsageFormLbLocalMemory.RegisterInEngine;
 {* Регистрация MemoryUsageForm_lbLocalMemory }
 TkwMemoryUsageFormLbObjectMemory.RegisterInEngine;
 {* Регистрация MemoryUsageForm_lbObjectMemory }
 TkwMemoryUsageFormLbObjectCount.RegisterInEngine;
 {* Регистрация MemoryUsageForm_lbObjectCount }
 TkwMemoryUsageFormLbGlobalMemory.RegisterInEngine;
 {* Регистрация MemoryUsageForm_lbGlobalMemory }
 TkwMemoryUsageFormLbDocumentsInCacheCount.RegisterInEngine;
 {* Регистрация MemoryUsageForm_lbDocumentsInCacheCount }
 TkwMemoryUsageFormLbAllLocalMemory.RegisterInEngine;
 {* Регистрация MemoryUsageForm_lbAllLocalMemory }
 TkwMemoryUsageFormLbTotalMemory.RegisterInEngine;
 {* Регистрация MemoryUsageForm_lbTotalMemory }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMemoryUsageForm));
 {* Регистрация типа MemoryUsage }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTreeView));
 {* Регистрация типа TeeTreeView }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* Регистрация типа TvtSizeablePanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevMemo));
 {* Регистрация типа TevMemo }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* Регистрация типа TvtLabel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
