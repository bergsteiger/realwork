unit MemoryUsageKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� MemoryUsage }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\MemoryUsageKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

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
  {* ����� ������� ��� �������������� ����� MemoryUsage
----
*������ �������������*:
[code]
'aControl' �����::MemoryUsage TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_MemoryUsage

 Tkw_MemoryUsage_Control_pnTagTree = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnTagTree
----
*������ �������������*:
[code]
�������::pnTagTree TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_pnTagTree

 Tkw_MemoryUsage_Control_pnTagTree_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnTagTree
----
*������ �������������*:
[code]
�������::pnTagTree:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_pnTagTree_Push

 Tkw_MemoryUsage_Control_TagTree = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TagTree
----
*������ �������������*:
[code]
�������::TagTree TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_TagTree

 Tkw_MemoryUsage_Control_TagTree_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� TagTree
----
*������ �������������*:
[code]
�������::TagTree:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_TagTree_Push

 Tkw_MemoryUsage_Control_pnMemClasses = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnMemClasses
----
*������ �������������*:
[code]
�������::pnMemClasses TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_pnMemClasses

 Tkw_MemoryUsage_Control_pnMemClasses_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnMemClasses
----
*������ �������������*:
[code]
�������::pnMemClasses:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_pnMemClasses_Push

 Tkw_MemoryUsage_Control_memClasses = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� memClasses
----
*������ �������������*:
[code]
�������::memClasses TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_memClasses

 Tkw_MemoryUsage_Control_memClasses_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� memClasses
----
*������ �������������*:
[code]
�������::memClasses:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_memClasses_Push

 Tkw_MemoryUsage_Control_pnSummary = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnSummary
----
*������ �������������*:
[code]
�������::pnSummary TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_pnSummary

 Tkw_MemoryUsage_Control_pnSummary_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnSummary
----
*������ �������������*:
[code]
�������::pnSummary:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_pnSummary_Push

 Tkw_MemoryUsage_Control_lbLocalMemory = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lbLocalMemory
----
*������ �������������*:
[code]
�������::lbLocalMemory TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_lbLocalMemory

 Tkw_MemoryUsage_Control_lbLocalMemory_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lbLocalMemory
----
*������ �������������*:
[code]
�������::lbLocalMemory:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbLocalMemory_Push

 Tkw_MemoryUsage_Control_lbObjectMemory = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lbObjectMemory
----
*������ �������������*:
[code]
�������::lbObjectMemory TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_lbObjectMemory

 Tkw_MemoryUsage_Control_lbObjectMemory_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lbObjectMemory
----
*������ �������������*:
[code]
�������::lbObjectMemory:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbObjectMemory_Push

 Tkw_MemoryUsage_Control_lbObjectCount = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lbObjectCount
----
*������ �������������*:
[code]
�������::lbObjectCount TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_lbObjectCount

 Tkw_MemoryUsage_Control_lbObjectCount_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lbObjectCount
----
*������ �������������*:
[code]
�������::lbObjectCount:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbObjectCount_Push

 Tkw_MemoryUsage_Control_lbGlobalMemory = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lbGlobalMemory
----
*������ �������������*:
[code]
�������::lbGlobalMemory TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_lbGlobalMemory

 Tkw_MemoryUsage_Control_lbGlobalMemory_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lbGlobalMemory
----
*������ �������������*:
[code]
�������::lbGlobalMemory:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbGlobalMemory_Push

 Tkw_MemoryUsage_Control_lbDocumentsInCacheCount = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lbDocumentsInCacheCount
----
*������ �������������*:
[code]
�������::lbDocumentsInCacheCount TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_lbDocumentsInCacheCount

 Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lbDocumentsInCacheCount
----
*������ �������������*:
[code]
�������::lbDocumentsInCacheCount:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push

 Tkw_MemoryUsage_Control_lbAllLocalMemory = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lbAllLocalMemory
----
*������ �������������*:
[code]
�������::lbAllLocalMemory TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_lbAllLocalMemory

 Tkw_MemoryUsage_Control_lbAllLocalMemory_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lbAllLocalMemory
----
*������ �������������*:
[code]
�������::lbAllLocalMemory:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbAllLocalMemory_Push

 Tkw_MemoryUsage_Control_lbTotalMemory = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lbTotalMemory
----
*������ �������������*:
[code]
�������::lbTotalMemory TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_lbTotalMemory

 Tkw_MemoryUsage_Control_lbTotalMemory_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lbTotalMemory
----
*������ �������������*:
[code]
�������::lbTotalMemory:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbTotalMemory_Push

 TkwMemoryUsageFormPnTagTree = {final} class(TtfwPropertyLike)
  {* ����� ������� .TMemoryUsageForm.pnTagTree
[panel]������� pnTagTree ����� TMemoryUsageForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aMemoryUsageForm .TMemoryUsageForm.pnTagTree >>> l_TvtPanel
[code]  }
  private
   function pnTagTree(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtPanel;
    {* ���������� ����� ������� .TMemoryUsageForm.pnTagTree }
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
  {* ����� ������� .TMemoryUsageForm.TagTree
[panel]������� TagTree ����� TMemoryUsageForm[panel]
*��� ����������:* TeeTreeView
*������:*
[code]
OBJECT VAR l_TeeTreeView
 aMemoryUsageForm .TMemoryUsageForm.TagTree >>> l_TeeTreeView
[code]  }
  private
   function TagTree(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TeeTreeView;
    {* ���������� ����� ������� .TMemoryUsageForm.TagTree }
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
  {* ����� ������� .TMemoryUsageForm.pnMemClasses
[panel]������� pnMemClasses ����� TMemoryUsageForm[panel]
*��� ����������:* TvtSizeablePanel
*������:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aMemoryUsageForm .TMemoryUsageForm.pnMemClasses >>> l_TvtSizeablePanel
[code]  }
  private
   function pnMemClasses(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtSizeablePanel;
    {* ���������� ����� ������� .TMemoryUsageForm.pnMemClasses }
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
  {* ����� ������� .TMemoryUsageForm.memClasses
[panel]������� memClasses ����� TMemoryUsageForm[panel]
*��� ����������:* TevMemo
*������:*
[code]
OBJECT VAR l_TevMemo
 aMemoryUsageForm .TMemoryUsageForm.memClasses >>> l_TevMemo
[code]  }
  private
   function memClasses(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TevMemo;
    {* ���������� ����� ������� .TMemoryUsageForm.memClasses }
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
  {* ����� ������� .TMemoryUsageForm.pnSummary
[panel]������� pnSummary ����� TMemoryUsageForm[panel]
*��� ����������:* TvtSizeablePanel
*������:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aMemoryUsageForm .TMemoryUsageForm.pnSummary >>> l_TvtSizeablePanel
[code]  }
  private
   function pnSummary(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtSizeablePanel;
    {* ���������� ����� ������� .TMemoryUsageForm.pnSummary }
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
  {* ����� ������� .TMemoryUsageForm.lbLocalMemory
[panel]������� lbLocalMemory ����� TMemoryUsageForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbLocalMemory >>> l_TvtLabel
[code]  }
  private
   function lbLocalMemory(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
    {* ���������� ����� ������� .TMemoryUsageForm.lbLocalMemory }
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
  {* ����� ������� .TMemoryUsageForm.lbObjectMemory
[panel]������� lbObjectMemory ����� TMemoryUsageForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbObjectMemory >>> l_TvtLabel
[code]  }
  private
   function lbObjectMemory(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
    {* ���������� ����� ������� .TMemoryUsageForm.lbObjectMemory }
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
  {* ����� ������� .TMemoryUsageForm.lbObjectCount
[panel]������� lbObjectCount ����� TMemoryUsageForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbObjectCount >>> l_TvtLabel
[code]  }
  private
   function lbObjectCount(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
    {* ���������� ����� ������� .TMemoryUsageForm.lbObjectCount }
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
  {* ����� ������� .TMemoryUsageForm.lbGlobalMemory
[panel]������� lbGlobalMemory ����� TMemoryUsageForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbGlobalMemory >>> l_TvtLabel
[code]  }
  private
   function lbGlobalMemory(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
    {* ���������� ����� ������� .TMemoryUsageForm.lbGlobalMemory }
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
  {* ����� ������� .TMemoryUsageForm.lbDocumentsInCacheCount
[panel]������� lbDocumentsInCacheCount ����� TMemoryUsageForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbDocumentsInCacheCount >>> l_TvtLabel
[code]  }
  private
   function lbDocumentsInCacheCount(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
    {* ���������� ����� ������� .TMemoryUsageForm.lbDocumentsInCacheCount }
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
  {* ����� ������� .TMemoryUsageForm.lbAllLocalMemory
[panel]������� lbAllLocalMemory ����� TMemoryUsageForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbAllLocalMemory >>> l_TvtLabel
[code]  }
  private
   function lbAllLocalMemory(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
    {* ���������� ����� ������� .TMemoryUsageForm.lbAllLocalMemory }
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
  {* ����� ������� .TMemoryUsageForm.lbTotalMemory
[panel]������� lbTotalMemory ����� TMemoryUsageForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbTotalMemory >>> l_TvtLabel
[code]  }
  private
   function lbTotalMemory(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
    {* ���������� ����� ������� .TMemoryUsageForm.lbTotalMemory }
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
 Result := '�����::MemoryUsage';
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
 Result := '�������::pnTagTree';
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
 Result := '�������::pnTagTree:push';
end;//Tkw_MemoryUsage_Control_pnTagTree_Push.GetWordNameForRegister

class function Tkw_MemoryUsage_Control_TagTree.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::TagTree';
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
 Result := '�������::TagTree:push';
end;//Tkw_MemoryUsage_Control_TagTree_Push.GetWordNameForRegister

class function Tkw_MemoryUsage_Control_pnMemClasses.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnMemClasses';
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
 Result := '�������::pnMemClasses:push';
end;//Tkw_MemoryUsage_Control_pnMemClasses_Push.GetWordNameForRegister

class function Tkw_MemoryUsage_Control_memClasses.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::memClasses';
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
 Result := '�������::memClasses:push';
end;//Tkw_MemoryUsage_Control_memClasses_Push.GetWordNameForRegister

class function Tkw_MemoryUsage_Control_pnSummary.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnSummary';
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
 Result := '�������::pnSummary:push';
end;//Tkw_MemoryUsage_Control_pnSummary_Push.GetWordNameForRegister

class function Tkw_MemoryUsage_Control_lbLocalMemory.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lbLocalMemory';
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
 Result := '�������::lbLocalMemory:push';
end;//Tkw_MemoryUsage_Control_lbLocalMemory_Push.GetWordNameForRegister

class function Tkw_MemoryUsage_Control_lbObjectMemory.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lbObjectMemory';
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
 Result := '�������::lbObjectMemory:push';
end;//Tkw_MemoryUsage_Control_lbObjectMemory_Push.GetWordNameForRegister

class function Tkw_MemoryUsage_Control_lbObjectCount.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lbObjectCount';
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
 Result := '�������::lbObjectCount:push';
end;//Tkw_MemoryUsage_Control_lbObjectCount_Push.GetWordNameForRegister

class function Tkw_MemoryUsage_Control_lbGlobalMemory.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lbGlobalMemory';
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
 Result := '�������::lbGlobalMemory:push';
end;//Tkw_MemoryUsage_Control_lbGlobalMemory_Push.GetWordNameForRegister

class function Tkw_MemoryUsage_Control_lbDocumentsInCacheCount.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lbDocumentsInCacheCount';
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
 Result := '�������::lbDocumentsInCacheCount:push';
end;//Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push.GetWordNameForRegister

class function Tkw_MemoryUsage_Control_lbAllLocalMemory.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lbAllLocalMemory';
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
 Result := '�������::lbAllLocalMemory:push';
end;//Tkw_MemoryUsage_Control_lbAllLocalMemory_Push.GetWordNameForRegister

class function Tkw_MemoryUsage_Control_lbTotalMemory.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lbTotalMemory';
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
 Result := '�������::lbTotalMemory:push';
end;//Tkw_MemoryUsage_Control_lbTotalMemory_Push.GetWordNameForRegister

function TkwMemoryUsageFormPnTagTree.pnTagTree(const aCtx: TtfwContext;
 aMemoryUsageForm: TMemoryUsageForm): TvtPanel;
 {* ���������� ����� ������� .TMemoryUsageForm.pnTagTree }
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
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
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
 {* ���������� ����� ������� .TMemoryUsageForm.TagTree }
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
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
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
 {* ���������� ����� ������� .TMemoryUsageForm.pnMemClasses }
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
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
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
 {* ���������� ����� ������� .TMemoryUsageForm.memClasses }
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
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
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
 {* ���������� ����� ������� .TMemoryUsageForm.pnSummary }
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
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
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
 {* ���������� ����� ������� .TMemoryUsageForm.lbLocalMemory }
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
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
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
 {* ���������� ����� ������� .TMemoryUsageForm.lbObjectMemory }
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
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
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
 {* ���������� ����� ������� .TMemoryUsageForm.lbObjectCount }
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
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
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
 {* ���������� ����� ������� .TMemoryUsageForm.lbGlobalMemory }
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
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
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
 {* ���������� ����� ������� .TMemoryUsageForm.lbDocumentsInCacheCount }
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
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
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
 {* ���������� ����� ������� .TMemoryUsageForm.lbAllLocalMemory }
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
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
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
 {* ���������� ����� ������� .TMemoryUsageForm.lbTotalMemory }
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
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
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
 {* ����������� Tkw_Form_MemoryUsage }
 Tkw_MemoryUsage_Control_pnTagTree.RegisterInEngine;
 {* ����������� Tkw_MemoryUsage_Control_pnTagTree }
 Tkw_MemoryUsage_Control_pnTagTree_Push.RegisterInEngine;
 {* ����������� Tkw_MemoryUsage_Control_pnTagTree_Push }
 Tkw_MemoryUsage_Control_TagTree.RegisterInEngine;
 {* ����������� Tkw_MemoryUsage_Control_TagTree }
 Tkw_MemoryUsage_Control_TagTree_Push.RegisterInEngine;
 {* ����������� Tkw_MemoryUsage_Control_TagTree_Push }
 Tkw_MemoryUsage_Control_pnMemClasses.RegisterInEngine;
 {* ����������� Tkw_MemoryUsage_Control_pnMemClasses }
 Tkw_MemoryUsage_Control_pnMemClasses_Push.RegisterInEngine;
 {* ����������� Tkw_MemoryUsage_Control_pnMemClasses_Push }
 Tkw_MemoryUsage_Control_memClasses.RegisterInEngine;
 {* ����������� Tkw_MemoryUsage_Control_memClasses }
 Tkw_MemoryUsage_Control_memClasses_Push.RegisterInEngine;
 {* ����������� Tkw_MemoryUsage_Control_memClasses_Push }
 Tkw_MemoryUsage_Control_pnSummary.RegisterInEngine;
 {* ����������� Tkw_MemoryUsage_Control_pnSummary }
 Tkw_MemoryUsage_Control_pnSummary_Push.RegisterInEngine;
 {* ����������� Tkw_MemoryUsage_Control_pnSummary_Push }
 Tkw_MemoryUsage_Control_lbLocalMemory.RegisterInEngine;
 {* ����������� Tkw_MemoryUsage_Control_lbLocalMemory }
 Tkw_MemoryUsage_Control_lbLocalMemory_Push.RegisterInEngine;
 {* ����������� Tkw_MemoryUsage_Control_lbLocalMemory_Push }
 Tkw_MemoryUsage_Control_lbObjectMemory.RegisterInEngine;
 {* ����������� Tkw_MemoryUsage_Control_lbObjectMemory }
 Tkw_MemoryUsage_Control_lbObjectMemory_Push.RegisterInEngine;
 {* ����������� Tkw_MemoryUsage_Control_lbObjectMemory_Push }
 Tkw_MemoryUsage_Control_lbObjectCount.RegisterInEngine;
 {* ����������� Tkw_MemoryUsage_Control_lbObjectCount }
 Tkw_MemoryUsage_Control_lbObjectCount_Push.RegisterInEngine;
 {* ����������� Tkw_MemoryUsage_Control_lbObjectCount_Push }
 Tkw_MemoryUsage_Control_lbGlobalMemory.RegisterInEngine;
 {* ����������� Tkw_MemoryUsage_Control_lbGlobalMemory }
 Tkw_MemoryUsage_Control_lbGlobalMemory_Push.RegisterInEngine;
 {* ����������� Tkw_MemoryUsage_Control_lbGlobalMemory_Push }
 Tkw_MemoryUsage_Control_lbDocumentsInCacheCount.RegisterInEngine;
 {* ����������� Tkw_MemoryUsage_Control_lbDocumentsInCacheCount }
 Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push.RegisterInEngine;
 {* ����������� Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push }
 Tkw_MemoryUsage_Control_lbAllLocalMemory.RegisterInEngine;
 {* ����������� Tkw_MemoryUsage_Control_lbAllLocalMemory }
 Tkw_MemoryUsage_Control_lbAllLocalMemory_Push.RegisterInEngine;
 {* ����������� Tkw_MemoryUsage_Control_lbAllLocalMemory_Push }
 Tkw_MemoryUsage_Control_lbTotalMemory.RegisterInEngine;
 {* ����������� Tkw_MemoryUsage_Control_lbTotalMemory }
 Tkw_MemoryUsage_Control_lbTotalMemory_Push.RegisterInEngine;
 {* ����������� Tkw_MemoryUsage_Control_lbTotalMemory_Push }
 TkwMemoryUsageFormPnTagTree.RegisterInEngine;
 {* ����������� MemoryUsageForm_pnTagTree }
 TkwMemoryUsageFormTagTree.RegisterInEngine;
 {* ����������� MemoryUsageForm_TagTree }
 TkwMemoryUsageFormPnMemClasses.RegisterInEngine;
 {* ����������� MemoryUsageForm_pnMemClasses }
 TkwMemoryUsageFormMemClasses.RegisterInEngine;
 {* ����������� MemoryUsageForm_memClasses }
 TkwMemoryUsageFormPnSummary.RegisterInEngine;
 {* ����������� MemoryUsageForm_pnSummary }
 TkwMemoryUsageFormLbLocalMemory.RegisterInEngine;
 {* ����������� MemoryUsageForm_lbLocalMemory }
 TkwMemoryUsageFormLbObjectMemory.RegisterInEngine;
 {* ����������� MemoryUsageForm_lbObjectMemory }
 TkwMemoryUsageFormLbObjectCount.RegisterInEngine;
 {* ����������� MemoryUsageForm_lbObjectCount }
 TkwMemoryUsageFormLbGlobalMemory.RegisterInEngine;
 {* ����������� MemoryUsageForm_lbGlobalMemory }
 TkwMemoryUsageFormLbDocumentsInCacheCount.RegisterInEngine;
 {* ����������� MemoryUsageForm_lbDocumentsInCacheCount }
 TkwMemoryUsageFormLbAllLocalMemory.RegisterInEngine;
 {* ����������� MemoryUsageForm_lbAllLocalMemory }
 TkwMemoryUsageFormLbTotalMemory.RegisterInEngine;
 {* ����������� MemoryUsageForm_lbTotalMemory }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMemoryUsageForm));
 {* ����������� ���� MemoryUsage }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTreeView));
 {* ����������� ���� TeeTreeView }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* ����������� ���� TvtSizeablePanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevMemo));
 {* ����������� ���� TevMemo }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* ����������� ���� TvtLabel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
