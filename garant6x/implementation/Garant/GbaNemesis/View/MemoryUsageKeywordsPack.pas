unit MemoryUsageKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы MemoryUsage }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MemoryUsageKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "MemoryUsageKeywordsPack" MUID: (88265B7C3032)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtPanel
 , eeTreeView
 , vtSizeablePanel
 , evMemo
 , vtLabel
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , MemoryUsage_Form
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
 Tkw_Form_MemoryUsage = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы MemoryUsage
----
*Пример использования*:
[code]
'aControl' форма::MemoryUsage TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_MemoryUsage

 Tkw_MemoryUsage_Control_pnTagTree = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnTagTree
----
*Пример использования*:
[code]
контрол::pnTagTree TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_pnTagTree

 Tkw_MemoryUsage_Control_pnTagTree_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_TagTree

 Tkw_MemoryUsage_Control_TagTree_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_pnMemClasses

 Tkw_MemoryUsage_Control_pnMemClasses_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_memClasses

 Tkw_MemoryUsage_Control_memClasses_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_pnSummary

 Tkw_MemoryUsage_Control_pnSummary_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbLocalMemory

 Tkw_MemoryUsage_Control_lbLocalMemory_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbObjectMemory

 Tkw_MemoryUsage_Control_lbObjectMemory_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbObjectCount

 Tkw_MemoryUsage_Control_lbObjectCount_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbGlobalMemory

 Tkw_MemoryUsage_Control_lbGlobalMemory_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbDocumentsInCacheCount

 Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbAllLocalMemory

 Tkw_MemoryUsage_Control_lbAllLocalMemory_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbTotalMemory

 Tkw_MemoryUsage_Control_lbTotalMemory_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
  {* Слово скрипта .TMemoryUsageForm.pnTagTree }
  private
   function pnTagTree(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtPanel;
    {* Реализация слова скрипта .TMemoryUsageForm.pnTagTree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMemoryUsageFormPnTagTree

 TkwMemoryUsageFormTagTree = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.TagTree }
  private
   function TagTree(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TeeTreeView;
    {* Реализация слова скрипта .TMemoryUsageForm.TagTree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMemoryUsageFormTagTree

 TkwMemoryUsageFormPnMemClasses = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.pnMemClasses }
  private
   function pnMemClasses(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtSizeablePanel;
    {* Реализация слова скрипта .TMemoryUsageForm.pnMemClasses }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMemoryUsageFormPnMemClasses

 TkwMemoryUsageFormMemClasses = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.memClasses }
  private
   function memClasses(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TevMemo;
    {* Реализация слова скрипта .TMemoryUsageForm.memClasses }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMemoryUsageFormMemClasses

 TkwMemoryUsageFormPnSummary = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.pnSummary }
  private
   function pnSummary(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtSizeablePanel;
    {* Реализация слова скрипта .TMemoryUsageForm.pnSummary }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMemoryUsageFormPnSummary

 TkwMemoryUsageFormLbLocalMemory = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.lbLocalMemory }
  private
   function lbLocalMemory(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
    {* Реализация слова скрипта .TMemoryUsageForm.lbLocalMemory }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMemoryUsageFormLbLocalMemory

 TkwMemoryUsageFormLbObjectMemory = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.lbObjectMemory }
  private
   function lbObjectMemory(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
    {* Реализация слова скрипта .TMemoryUsageForm.lbObjectMemory }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMemoryUsageFormLbObjectMemory

 TkwMemoryUsageFormLbObjectCount = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.lbObjectCount }
  private
   function lbObjectCount(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
    {* Реализация слова скрипта .TMemoryUsageForm.lbObjectCount }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMemoryUsageFormLbObjectCount

 TkwMemoryUsageFormLbGlobalMemory = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.lbGlobalMemory }
  private
   function lbGlobalMemory(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
    {* Реализация слова скрипта .TMemoryUsageForm.lbGlobalMemory }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMemoryUsageFormLbGlobalMemory

 TkwMemoryUsageFormLbDocumentsInCacheCount = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.lbDocumentsInCacheCount }
  private
   function lbDocumentsInCacheCount(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
    {* Реализация слова скрипта .TMemoryUsageForm.lbDocumentsInCacheCount }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMemoryUsageFormLbDocumentsInCacheCount

 TkwMemoryUsageFormLbAllLocalMemory = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.lbAllLocalMemory }
  private
   function lbAllLocalMemory(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
    {* Реализация слова скрипта .TMemoryUsageForm.lbAllLocalMemory }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMemoryUsageFormLbAllLocalMemory

 TkwMemoryUsageFormLbTotalMemory = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.lbTotalMemory }
  private
   function lbTotalMemory(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
    {* Реализация слова скрипта .TMemoryUsageForm.lbTotalMemory }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMemoryUsageFormLbTotalMemory

function Tkw_Form_MemoryUsage.GetString: AnsiString;
begin
 Result := 'MemoryUsageForm';
end;//Tkw_Form_MemoryUsage.GetString

class function Tkw_Form_MemoryUsage.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::MemoryUsage';
end;//Tkw_Form_MemoryUsage.GetWordNameForRegister

function Tkw_MemoryUsage_Control_pnTagTree.GetString: AnsiString;
begin
 Result := 'pnTagTree';
end;//Tkw_MemoryUsage_Control_pnTagTree.GetString

class procedure Tkw_MemoryUsage_Control_pnTagTree.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MemoryUsage_Control_pnTagTree.RegisterInEngine

class function Tkw_MemoryUsage_Control_pnTagTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnTagTree';
end;//Tkw_MemoryUsage_Control_pnTagTree.GetWordNameForRegister

procedure Tkw_MemoryUsage_Control_pnTagTree_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnTagTree');
 inherited;
end;//Tkw_MemoryUsage_Control_pnTagTree_Push.DoDoIt

class function Tkw_MemoryUsage_Control_pnTagTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnTagTree:push';
end;//Tkw_MemoryUsage_Control_pnTagTree_Push.GetWordNameForRegister

function Tkw_MemoryUsage_Control_TagTree.GetString: AnsiString;
begin
 Result := 'TagTree';
end;//Tkw_MemoryUsage_Control_TagTree.GetString

class procedure Tkw_MemoryUsage_Control_TagTree.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeTreeView);
end;//Tkw_MemoryUsage_Control_TagTree.RegisterInEngine

class function Tkw_MemoryUsage_Control_TagTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TagTree';
end;//Tkw_MemoryUsage_Control_TagTree.GetWordNameForRegister

procedure Tkw_MemoryUsage_Control_TagTree_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('TagTree');
 inherited;
end;//Tkw_MemoryUsage_Control_TagTree_Push.DoDoIt

class function Tkw_MemoryUsage_Control_TagTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TagTree:push';
end;//Tkw_MemoryUsage_Control_TagTree_Push.GetWordNameForRegister

function Tkw_MemoryUsage_Control_pnMemClasses.GetString: AnsiString;
begin
 Result := 'pnMemClasses';
end;//Tkw_MemoryUsage_Control_pnMemClasses.GetString

class procedure Tkw_MemoryUsage_Control_pnMemClasses.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_MemoryUsage_Control_pnMemClasses.RegisterInEngine

class function Tkw_MemoryUsage_Control_pnMemClasses.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnMemClasses';
end;//Tkw_MemoryUsage_Control_pnMemClasses.GetWordNameForRegister

procedure Tkw_MemoryUsage_Control_pnMemClasses_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnMemClasses');
 inherited;
end;//Tkw_MemoryUsage_Control_pnMemClasses_Push.DoDoIt

class function Tkw_MemoryUsage_Control_pnMemClasses_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnMemClasses:push';
end;//Tkw_MemoryUsage_Control_pnMemClasses_Push.GetWordNameForRegister

function Tkw_MemoryUsage_Control_memClasses.GetString: AnsiString;
begin
 Result := 'memClasses';
end;//Tkw_MemoryUsage_Control_memClasses.GetString

class procedure Tkw_MemoryUsage_Control_memClasses.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TevMemo);
end;//Tkw_MemoryUsage_Control_memClasses.RegisterInEngine

class function Tkw_MemoryUsage_Control_memClasses.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::memClasses';
end;//Tkw_MemoryUsage_Control_memClasses.GetWordNameForRegister

procedure Tkw_MemoryUsage_Control_memClasses_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('memClasses');
 inherited;
end;//Tkw_MemoryUsage_Control_memClasses_Push.DoDoIt

class function Tkw_MemoryUsage_Control_memClasses_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::memClasses:push';
end;//Tkw_MemoryUsage_Control_memClasses_Push.GetWordNameForRegister

function Tkw_MemoryUsage_Control_pnSummary.GetString: AnsiString;
begin
 Result := 'pnSummary';
end;//Tkw_MemoryUsage_Control_pnSummary.GetString

class procedure Tkw_MemoryUsage_Control_pnSummary.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_MemoryUsage_Control_pnSummary.RegisterInEngine

class function Tkw_MemoryUsage_Control_pnSummary.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnSummary';
end;//Tkw_MemoryUsage_Control_pnSummary.GetWordNameForRegister

procedure Tkw_MemoryUsage_Control_pnSummary_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnSummary');
 inherited;
end;//Tkw_MemoryUsage_Control_pnSummary_Push.DoDoIt

class function Tkw_MemoryUsage_Control_pnSummary_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnSummary:push';
end;//Tkw_MemoryUsage_Control_pnSummary_Push.GetWordNameForRegister

function Tkw_MemoryUsage_Control_lbLocalMemory.GetString: AnsiString;
begin
 Result := 'lbLocalMemory';
end;//Tkw_MemoryUsage_Control_lbLocalMemory.GetString

class procedure Tkw_MemoryUsage_Control_lbLocalMemory.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_MemoryUsage_Control_lbLocalMemory.RegisterInEngine

class function Tkw_MemoryUsage_Control_lbLocalMemory.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbLocalMemory';
end;//Tkw_MemoryUsage_Control_lbLocalMemory.GetWordNameForRegister

procedure Tkw_MemoryUsage_Control_lbLocalMemory_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lbLocalMemory');
 inherited;
end;//Tkw_MemoryUsage_Control_lbLocalMemory_Push.DoDoIt

class function Tkw_MemoryUsage_Control_lbLocalMemory_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbLocalMemory:push';
end;//Tkw_MemoryUsage_Control_lbLocalMemory_Push.GetWordNameForRegister

function Tkw_MemoryUsage_Control_lbObjectMemory.GetString: AnsiString;
begin
 Result := 'lbObjectMemory';
end;//Tkw_MemoryUsage_Control_lbObjectMemory.GetString

class procedure Tkw_MemoryUsage_Control_lbObjectMemory.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_MemoryUsage_Control_lbObjectMemory.RegisterInEngine

class function Tkw_MemoryUsage_Control_lbObjectMemory.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbObjectMemory';
end;//Tkw_MemoryUsage_Control_lbObjectMemory.GetWordNameForRegister

procedure Tkw_MemoryUsage_Control_lbObjectMemory_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lbObjectMemory');
 inherited;
end;//Tkw_MemoryUsage_Control_lbObjectMemory_Push.DoDoIt

class function Tkw_MemoryUsage_Control_lbObjectMemory_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbObjectMemory:push';
end;//Tkw_MemoryUsage_Control_lbObjectMemory_Push.GetWordNameForRegister

function Tkw_MemoryUsage_Control_lbObjectCount.GetString: AnsiString;
begin
 Result := 'lbObjectCount';
end;//Tkw_MemoryUsage_Control_lbObjectCount.GetString

class procedure Tkw_MemoryUsage_Control_lbObjectCount.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_MemoryUsage_Control_lbObjectCount.RegisterInEngine

class function Tkw_MemoryUsage_Control_lbObjectCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbObjectCount';
end;//Tkw_MemoryUsage_Control_lbObjectCount.GetWordNameForRegister

procedure Tkw_MemoryUsage_Control_lbObjectCount_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lbObjectCount');
 inherited;
end;//Tkw_MemoryUsage_Control_lbObjectCount_Push.DoDoIt

class function Tkw_MemoryUsage_Control_lbObjectCount_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbObjectCount:push';
end;//Tkw_MemoryUsage_Control_lbObjectCount_Push.GetWordNameForRegister

function Tkw_MemoryUsage_Control_lbGlobalMemory.GetString: AnsiString;
begin
 Result := 'lbGlobalMemory';
end;//Tkw_MemoryUsage_Control_lbGlobalMemory.GetString

class procedure Tkw_MemoryUsage_Control_lbGlobalMemory.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_MemoryUsage_Control_lbGlobalMemory.RegisterInEngine

class function Tkw_MemoryUsage_Control_lbGlobalMemory.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbGlobalMemory';
end;//Tkw_MemoryUsage_Control_lbGlobalMemory.GetWordNameForRegister

procedure Tkw_MemoryUsage_Control_lbGlobalMemory_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lbGlobalMemory');
 inherited;
end;//Tkw_MemoryUsage_Control_lbGlobalMemory_Push.DoDoIt

class function Tkw_MemoryUsage_Control_lbGlobalMemory_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbGlobalMemory:push';
end;//Tkw_MemoryUsage_Control_lbGlobalMemory_Push.GetWordNameForRegister

function Tkw_MemoryUsage_Control_lbDocumentsInCacheCount.GetString: AnsiString;
begin
 Result := 'lbDocumentsInCacheCount';
end;//Tkw_MemoryUsage_Control_lbDocumentsInCacheCount.GetString

class procedure Tkw_MemoryUsage_Control_lbDocumentsInCacheCount.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_MemoryUsage_Control_lbDocumentsInCacheCount.RegisterInEngine

class function Tkw_MemoryUsage_Control_lbDocumentsInCacheCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbDocumentsInCacheCount';
end;//Tkw_MemoryUsage_Control_lbDocumentsInCacheCount.GetWordNameForRegister

procedure Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lbDocumentsInCacheCount');
 inherited;
end;//Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push.DoDoIt

class function Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbDocumentsInCacheCount:push';
end;//Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push.GetWordNameForRegister

function Tkw_MemoryUsage_Control_lbAllLocalMemory.GetString: AnsiString;
begin
 Result := 'lbAllLocalMemory';
end;//Tkw_MemoryUsage_Control_lbAllLocalMemory.GetString

class procedure Tkw_MemoryUsage_Control_lbAllLocalMemory.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_MemoryUsage_Control_lbAllLocalMemory.RegisterInEngine

class function Tkw_MemoryUsage_Control_lbAllLocalMemory.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbAllLocalMemory';
end;//Tkw_MemoryUsage_Control_lbAllLocalMemory.GetWordNameForRegister

procedure Tkw_MemoryUsage_Control_lbAllLocalMemory_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lbAllLocalMemory');
 inherited;
end;//Tkw_MemoryUsage_Control_lbAllLocalMemory_Push.DoDoIt

class function Tkw_MemoryUsage_Control_lbAllLocalMemory_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbAllLocalMemory:push';
end;//Tkw_MemoryUsage_Control_lbAllLocalMemory_Push.GetWordNameForRegister

function Tkw_MemoryUsage_Control_lbTotalMemory.GetString: AnsiString;
begin
 Result := 'lbTotalMemory';
end;//Tkw_MemoryUsage_Control_lbTotalMemory.GetString

class procedure Tkw_MemoryUsage_Control_lbTotalMemory.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_MemoryUsage_Control_lbTotalMemory.RegisterInEngine

class function Tkw_MemoryUsage_Control_lbTotalMemory.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbTotalMemory';
end;//Tkw_MemoryUsage_Control_lbTotalMemory.GetWordNameForRegister

procedure Tkw_MemoryUsage_Control_lbTotalMemory_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lbTotalMemory');
 inherited;
end;//Tkw_MemoryUsage_Control_lbTotalMemory_Push.DoDoIt

class function Tkw_MemoryUsage_Control_lbTotalMemory_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbTotalMemory:push';
end;//Tkw_MemoryUsage_Control_lbTotalMemory_Push.GetWordNameForRegister

function TkwMemoryUsageFormPnTagTree.pnTagTree(const aCtx: TtfwContext;
 aMemoryUsageForm: TMemoryUsageForm): TvtPanel;
 {* Реализация слова скрипта .TMemoryUsageForm.pnTagTree }
begin
 Result := aMemoryUsageForm.pnTagTree;
end;//TkwMemoryUsageFormPnTagTree.pnTagTree

procedure TkwMemoryUsageFormPnTagTree.DoDoIt(const aCtx: TtfwContext);
var l_aMemoryUsageForm: TMemoryUsageForm;
begin
 try
  l_aMemoryUsageForm := TMemoryUsageForm(aCtx.rEngine.PopObjAs(TMemoryUsageForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnTagTree(aCtx, l_aMemoryUsageForm));
end;//TkwMemoryUsageFormPnTagTree.DoDoIt

class function TkwMemoryUsageFormPnTagTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMemoryUsageForm.pnTagTree';
end;//TkwMemoryUsageFormPnTagTree.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TMemoryUsageForm)]);
end;//TkwMemoryUsageFormPnTagTree.ParamsTypes

procedure TkwMemoryUsageFormPnTagTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnTagTree', aCtx);
end;//TkwMemoryUsageFormPnTagTree.SetValuePrim

function TkwMemoryUsageFormTagTree.TagTree(const aCtx: TtfwContext;
 aMemoryUsageForm: TMemoryUsageForm): TeeTreeView;
 {* Реализация слова скрипта .TMemoryUsageForm.TagTree }
begin
 Result := aMemoryUsageForm.TagTree;
end;//TkwMemoryUsageFormTagTree.TagTree

procedure TkwMemoryUsageFormTagTree.DoDoIt(const aCtx: TtfwContext);
var l_aMemoryUsageForm: TMemoryUsageForm;
begin
 try
  l_aMemoryUsageForm := TMemoryUsageForm(aCtx.rEngine.PopObjAs(TMemoryUsageForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(TagTree(aCtx, l_aMemoryUsageForm));
end;//TkwMemoryUsageFormTagTree.DoDoIt

class function TkwMemoryUsageFormTagTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMemoryUsageForm.TagTree';
end;//TkwMemoryUsageFormTagTree.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TMemoryUsageForm)]);
end;//TkwMemoryUsageFormTagTree.ParamsTypes

procedure TkwMemoryUsageFormTagTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству TagTree', aCtx);
end;//TkwMemoryUsageFormTagTree.SetValuePrim

function TkwMemoryUsageFormPnMemClasses.pnMemClasses(const aCtx: TtfwContext;
 aMemoryUsageForm: TMemoryUsageForm): TvtSizeablePanel;
 {* Реализация слова скрипта .TMemoryUsageForm.pnMemClasses }
begin
 Result := aMemoryUsageForm.pnMemClasses;
end;//TkwMemoryUsageFormPnMemClasses.pnMemClasses

procedure TkwMemoryUsageFormPnMemClasses.DoDoIt(const aCtx: TtfwContext);
var l_aMemoryUsageForm: TMemoryUsageForm;
begin
 try
  l_aMemoryUsageForm := TMemoryUsageForm(aCtx.rEngine.PopObjAs(TMemoryUsageForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnMemClasses(aCtx, l_aMemoryUsageForm));
end;//TkwMemoryUsageFormPnMemClasses.DoDoIt

class function TkwMemoryUsageFormPnMemClasses.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMemoryUsageForm.pnMemClasses';
end;//TkwMemoryUsageFormPnMemClasses.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TMemoryUsageForm)]);
end;//TkwMemoryUsageFormPnMemClasses.ParamsTypes

procedure TkwMemoryUsageFormPnMemClasses.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnMemClasses', aCtx);
end;//TkwMemoryUsageFormPnMemClasses.SetValuePrim

function TkwMemoryUsageFormMemClasses.memClasses(const aCtx: TtfwContext;
 aMemoryUsageForm: TMemoryUsageForm): TevMemo;
 {* Реализация слова скрипта .TMemoryUsageForm.memClasses }
begin
 Result := aMemoryUsageForm.memClasses;
end;//TkwMemoryUsageFormMemClasses.memClasses

procedure TkwMemoryUsageFormMemClasses.DoDoIt(const aCtx: TtfwContext);
var l_aMemoryUsageForm: TMemoryUsageForm;
begin
 try
  l_aMemoryUsageForm := TMemoryUsageForm(aCtx.rEngine.PopObjAs(TMemoryUsageForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(memClasses(aCtx, l_aMemoryUsageForm));
end;//TkwMemoryUsageFormMemClasses.DoDoIt

class function TkwMemoryUsageFormMemClasses.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMemoryUsageForm.memClasses';
end;//TkwMemoryUsageFormMemClasses.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TMemoryUsageForm)]);
end;//TkwMemoryUsageFormMemClasses.ParamsTypes

procedure TkwMemoryUsageFormMemClasses.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству memClasses', aCtx);
end;//TkwMemoryUsageFormMemClasses.SetValuePrim

function TkwMemoryUsageFormPnSummary.pnSummary(const aCtx: TtfwContext;
 aMemoryUsageForm: TMemoryUsageForm): TvtSizeablePanel;
 {* Реализация слова скрипта .TMemoryUsageForm.pnSummary }
begin
 Result := aMemoryUsageForm.pnSummary;
end;//TkwMemoryUsageFormPnSummary.pnSummary

procedure TkwMemoryUsageFormPnSummary.DoDoIt(const aCtx: TtfwContext);
var l_aMemoryUsageForm: TMemoryUsageForm;
begin
 try
  l_aMemoryUsageForm := TMemoryUsageForm(aCtx.rEngine.PopObjAs(TMemoryUsageForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnSummary(aCtx, l_aMemoryUsageForm));
end;//TkwMemoryUsageFormPnSummary.DoDoIt

class function TkwMemoryUsageFormPnSummary.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMemoryUsageForm.pnSummary';
end;//TkwMemoryUsageFormPnSummary.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TMemoryUsageForm)]);
end;//TkwMemoryUsageFormPnSummary.ParamsTypes

procedure TkwMemoryUsageFormPnSummary.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnSummary', aCtx);
end;//TkwMemoryUsageFormPnSummary.SetValuePrim

function TkwMemoryUsageFormLbLocalMemory.lbLocalMemory(const aCtx: TtfwContext;
 aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
 {* Реализация слова скрипта .TMemoryUsageForm.lbLocalMemory }
begin
 Result := aMemoryUsageForm.lbLocalMemory;
end;//TkwMemoryUsageFormLbLocalMemory.lbLocalMemory

procedure TkwMemoryUsageFormLbLocalMemory.DoDoIt(const aCtx: TtfwContext);
var l_aMemoryUsageForm: TMemoryUsageForm;
begin
 try
  l_aMemoryUsageForm := TMemoryUsageForm(aCtx.rEngine.PopObjAs(TMemoryUsageForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lbLocalMemory(aCtx, l_aMemoryUsageForm));
end;//TkwMemoryUsageFormLbLocalMemory.DoDoIt

class function TkwMemoryUsageFormLbLocalMemory.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMemoryUsageForm.lbLocalMemory';
end;//TkwMemoryUsageFormLbLocalMemory.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TMemoryUsageForm)]);
end;//TkwMemoryUsageFormLbLocalMemory.ParamsTypes

procedure TkwMemoryUsageFormLbLocalMemory.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lbLocalMemory', aCtx);
end;//TkwMemoryUsageFormLbLocalMemory.SetValuePrim

function TkwMemoryUsageFormLbObjectMemory.lbObjectMemory(const aCtx: TtfwContext;
 aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
 {* Реализация слова скрипта .TMemoryUsageForm.lbObjectMemory }
begin
 Result := aMemoryUsageForm.lbObjectMemory;
end;//TkwMemoryUsageFormLbObjectMemory.lbObjectMemory

procedure TkwMemoryUsageFormLbObjectMemory.DoDoIt(const aCtx: TtfwContext);
var l_aMemoryUsageForm: TMemoryUsageForm;
begin
 try
  l_aMemoryUsageForm := TMemoryUsageForm(aCtx.rEngine.PopObjAs(TMemoryUsageForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lbObjectMemory(aCtx, l_aMemoryUsageForm));
end;//TkwMemoryUsageFormLbObjectMemory.DoDoIt

class function TkwMemoryUsageFormLbObjectMemory.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMemoryUsageForm.lbObjectMemory';
end;//TkwMemoryUsageFormLbObjectMemory.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TMemoryUsageForm)]);
end;//TkwMemoryUsageFormLbObjectMemory.ParamsTypes

procedure TkwMemoryUsageFormLbObjectMemory.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lbObjectMemory', aCtx);
end;//TkwMemoryUsageFormLbObjectMemory.SetValuePrim

function TkwMemoryUsageFormLbObjectCount.lbObjectCount(const aCtx: TtfwContext;
 aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
 {* Реализация слова скрипта .TMemoryUsageForm.lbObjectCount }
begin
 Result := aMemoryUsageForm.lbObjectCount;
end;//TkwMemoryUsageFormLbObjectCount.lbObjectCount

procedure TkwMemoryUsageFormLbObjectCount.DoDoIt(const aCtx: TtfwContext);
var l_aMemoryUsageForm: TMemoryUsageForm;
begin
 try
  l_aMemoryUsageForm := TMemoryUsageForm(aCtx.rEngine.PopObjAs(TMemoryUsageForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lbObjectCount(aCtx, l_aMemoryUsageForm));
end;//TkwMemoryUsageFormLbObjectCount.DoDoIt

class function TkwMemoryUsageFormLbObjectCount.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMemoryUsageForm.lbObjectCount';
end;//TkwMemoryUsageFormLbObjectCount.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TMemoryUsageForm)]);
end;//TkwMemoryUsageFormLbObjectCount.ParamsTypes

procedure TkwMemoryUsageFormLbObjectCount.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lbObjectCount', aCtx);
end;//TkwMemoryUsageFormLbObjectCount.SetValuePrim

function TkwMemoryUsageFormLbGlobalMemory.lbGlobalMemory(const aCtx: TtfwContext;
 aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
 {* Реализация слова скрипта .TMemoryUsageForm.lbGlobalMemory }
begin
 Result := aMemoryUsageForm.lbGlobalMemory;
end;//TkwMemoryUsageFormLbGlobalMemory.lbGlobalMemory

procedure TkwMemoryUsageFormLbGlobalMemory.DoDoIt(const aCtx: TtfwContext);
var l_aMemoryUsageForm: TMemoryUsageForm;
begin
 try
  l_aMemoryUsageForm := TMemoryUsageForm(aCtx.rEngine.PopObjAs(TMemoryUsageForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lbGlobalMemory(aCtx, l_aMemoryUsageForm));
end;//TkwMemoryUsageFormLbGlobalMemory.DoDoIt

class function TkwMemoryUsageFormLbGlobalMemory.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMemoryUsageForm.lbGlobalMemory';
end;//TkwMemoryUsageFormLbGlobalMemory.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TMemoryUsageForm)]);
end;//TkwMemoryUsageFormLbGlobalMemory.ParamsTypes

procedure TkwMemoryUsageFormLbGlobalMemory.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lbGlobalMemory', aCtx);
end;//TkwMemoryUsageFormLbGlobalMemory.SetValuePrim

function TkwMemoryUsageFormLbDocumentsInCacheCount.lbDocumentsInCacheCount(const aCtx: TtfwContext;
 aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
 {* Реализация слова скрипта .TMemoryUsageForm.lbDocumentsInCacheCount }
begin
 Result := aMemoryUsageForm.lbDocumentsInCacheCount;
end;//TkwMemoryUsageFormLbDocumentsInCacheCount.lbDocumentsInCacheCount

procedure TkwMemoryUsageFormLbDocumentsInCacheCount.DoDoIt(const aCtx: TtfwContext);
var l_aMemoryUsageForm: TMemoryUsageForm;
begin
 try
  l_aMemoryUsageForm := TMemoryUsageForm(aCtx.rEngine.PopObjAs(TMemoryUsageForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lbDocumentsInCacheCount(aCtx, l_aMemoryUsageForm));
end;//TkwMemoryUsageFormLbDocumentsInCacheCount.DoDoIt

class function TkwMemoryUsageFormLbDocumentsInCacheCount.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMemoryUsageForm.lbDocumentsInCacheCount';
end;//TkwMemoryUsageFormLbDocumentsInCacheCount.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TMemoryUsageForm)]);
end;//TkwMemoryUsageFormLbDocumentsInCacheCount.ParamsTypes

procedure TkwMemoryUsageFormLbDocumentsInCacheCount.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lbDocumentsInCacheCount', aCtx);
end;//TkwMemoryUsageFormLbDocumentsInCacheCount.SetValuePrim

function TkwMemoryUsageFormLbAllLocalMemory.lbAllLocalMemory(const aCtx: TtfwContext;
 aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
 {* Реализация слова скрипта .TMemoryUsageForm.lbAllLocalMemory }
begin
 Result := aMemoryUsageForm.lbAllLocalMemory;
end;//TkwMemoryUsageFormLbAllLocalMemory.lbAllLocalMemory

procedure TkwMemoryUsageFormLbAllLocalMemory.DoDoIt(const aCtx: TtfwContext);
var l_aMemoryUsageForm: TMemoryUsageForm;
begin
 try
  l_aMemoryUsageForm := TMemoryUsageForm(aCtx.rEngine.PopObjAs(TMemoryUsageForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lbAllLocalMemory(aCtx, l_aMemoryUsageForm));
end;//TkwMemoryUsageFormLbAllLocalMemory.DoDoIt

class function TkwMemoryUsageFormLbAllLocalMemory.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMemoryUsageForm.lbAllLocalMemory';
end;//TkwMemoryUsageFormLbAllLocalMemory.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TMemoryUsageForm)]);
end;//TkwMemoryUsageFormLbAllLocalMemory.ParamsTypes

procedure TkwMemoryUsageFormLbAllLocalMemory.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lbAllLocalMemory', aCtx);
end;//TkwMemoryUsageFormLbAllLocalMemory.SetValuePrim

function TkwMemoryUsageFormLbTotalMemory.lbTotalMemory(const aCtx: TtfwContext;
 aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
 {* Реализация слова скрипта .TMemoryUsageForm.lbTotalMemory }
begin
 Result := aMemoryUsageForm.lbTotalMemory;
end;//TkwMemoryUsageFormLbTotalMemory.lbTotalMemory

procedure TkwMemoryUsageFormLbTotalMemory.DoDoIt(const aCtx: TtfwContext);
var l_aMemoryUsageForm: TMemoryUsageForm;
begin
 try
  l_aMemoryUsageForm := TMemoryUsageForm(aCtx.rEngine.PopObjAs(TMemoryUsageForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lbTotalMemory(aCtx, l_aMemoryUsageForm));
end;//TkwMemoryUsageFormLbTotalMemory.DoDoIt

class function TkwMemoryUsageFormLbTotalMemory.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMemoryUsageForm.lbTotalMemory';
end;//TkwMemoryUsageFormLbTotalMemory.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TMemoryUsageForm)]);
end;//TkwMemoryUsageFormLbTotalMemory.ParamsTypes

procedure TkwMemoryUsageFormLbTotalMemory.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lbTotalMemory', aCtx);
end;//TkwMemoryUsageFormLbTotalMemory.SetValuePrim

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
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMemoryUsageForm));
 {* Регистрация типа TMemoryUsageForm }
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
