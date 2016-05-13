unit DefineSearchDateKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы DefineSearchDate }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\DefineSearchDateKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "DefineSearchDateKeywordsPack" MUID: (9C20258F4DBF)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtPanel
 , vtLabel
 , vtDblClickDateEdit
 , vtRadioButton
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , DefineSearchDate_Form
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
 Tkw_Form_DefineSearchDate = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы DefineSearchDate
----
*Пример использования*:
[code]
'aControl' форма::DefineSearchDate TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_DefineSearchDate

 Tkw_DefineSearchDate_Control_Panel1 = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Panel1
----
*Пример использования*:
[code]
контрол::Panel1 TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DefineSearchDate_Control_Panel1

 Tkw_DefineSearchDate_Control_Panel1_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола Panel1
----
*Пример использования*:
[code]
контрол::Panel1:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DefineSearchDate_Control_Panel1_Push

 Tkw_DefineSearchDate_Control_ElLabel1 = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ElLabel1
----
*Пример использования*:
[code]
контрол::ElLabel1 TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DefineSearchDate_Control_ElLabel1

 Tkw_DefineSearchDate_Control_ElLabel1_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола ElLabel1
----
*Пример использования*:
[code]
контрол::ElLabel1:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DefineSearchDate_Control_ElLabel1_Push

 Tkw_DefineSearchDate_Control_ElLabel2 = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ElLabel2
----
*Пример использования*:
[code]
контрол::ElLabel2 TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DefineSearchDate_Control_ElLabel2

 Tkw_DefineSearchDate_Control_ElLabel2_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола ElLabel2
----
*Пример использования*:
[code]
контрол::ElLabel2:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DefineSearchDate_Control_ElLabel2_Push

 Tkw_DefineSearchDate_Control_ElLabel3 = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ElLabel3
----
*Пример использования*:
[code]
контрол::ElLabel3 TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DefineSearchDate_Control_ElLabel3

 Tkw_DefineSearchDate_Control_ElLabel3_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола ElLabel3
----
*Пример использования*:
[code]
контрол::ElLabel3:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DefineSearchDate_Control_ElLabel3_Push

 Tkw_DefineSearchDate_Control_dD1EqD2 = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола dD1EqD2
----
*Пример использования*:
[code]
контрол::dD1EqD2 TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DefineSearchDate_Control_dD1EqD2

 Tkw_DefineSearchDate_Control_dD1EqD2_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола dD1EqD2
----
*Пример использования*:
[code]
контрол::dD1EqD2:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DefineSearchDate_Control_dD1EqD2_Push

 Tkw_DefineSearchDate_Control_rbEq = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола rbEq
----
*Пример использования*:
[code]
контрол::rbEq TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DefineSearchDate_Control_rbEq

 Tkw_DefineSearchDate_Control_rbEq_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола rbEq
----
*Пример использования*:
[code]
контрол::rbEq:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DefineSearchDate_Control_rbEq_Push

 Tkw_DefineSearchDate_Control_rbInt = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола rbInt
----
*Пример использования*:
[code]
контрол::rbInt TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DefineSearchDate_Control_rbInt

 Tkw_DefineSearchDate_Control_rbInt_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола rbInt
----
*Пример использования*:
[code]
контрол::rbInt:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DefineSearchDate_Control_rbInt_Push

 Tkw_DefineSearchDate_Control_rbD2Only = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола rbD2Only
----
*Пример использования*:
[code]
контрол::rbD2Only TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DefineSearchDate_Control_rbD2Only

 Tkw_DefineSearchDate_Control_rbD2Only_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола rbD2Only
----
*Пример использования*:
[code]
контрол::rbD2Only:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DefineSearchDate_Control_rbD2Only_Push

 Tkw_DefineSearchDate_Control_dD1Only = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола dD1Only
----
*Пример использования*:
[code]
контрол::dD1Only TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DefineSearchDate_Control_dD1Only

 Tkw_DefineSearchDate_Control_dD1Only_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола dD1Only
----
*Пример использования*:
[code]
контрол::dD1Only:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DefineSearchDate_Control_dD1Only_Push

 Tkw_DefineSearchDate_Control_dD2Only = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола dD2Only
----
*Пример использования*:
[code]
контрол::dD2Only TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DefineSearchDate_Control_dD2Only

 Tkw_DefineSearchDate_Control_dD2Only_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола dD2Only
----
*Пример использования*:
[code]
контрол::dD2Only:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DefineSearchDate_Control_dD2Only_Push

 Tkw_DefineSearchDate_Control_dD1 = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола dD1
----
*Пример использования*:
[code]
контрол::dD1 TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DefineSearchDate_Control_dD1

 Tkw_DefineSearchDate_Control_dD1_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола dD1
----
*Пример использования*:
[code]
контрол::dD1:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DefineSearchDate_Control_dD1_Push

 Tkw_DefineSearchDate_Control_rbD1Only = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола rbD1Only
----
*Пример использования*:
[code]
контрол::rbD1Only TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DefineSearchDate_Control_rbD1Only

 Tkw_DefineSearchDate_Control_rbD1Only_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола rbD1Only
----
*Пример использования*:
[code]
контрол::rbD1Only:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DefineSearchDate_Control_rbD1Only_Push

 Tkw_DefineSearchDate_Control_dD2 = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола dD2
----
*Пример использования*:
[code]
контрол::dD2 TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DefineSearchDate_Control_dD2

 Tkw_DefineSearchDate_Control_dD2_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола dD2
----
*Пример использования*:
[code]
контрол::dD2:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DefineSearchDate_Control_dD2_Push

 TkwEnDefineSearchDatePanel1 = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_DefineSearchDate.Panel1 }
  private
   function Panel1(const aCtx: TtfwContext;
    aen_DefineSearchDate: Ten_DefineSearchDate): TvtPanel;
    {* Реализация слова скрипта .Ten_DefineSearchDate.Panel1 }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnDefineSearchDatePanel1

 TkwEnDefineSearchDateElLabel1 = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_DefineSearchDate.ElLabel1 }
  private
   function ElLabel1(const aCtx: TtfwContext;
    aen_DefineSearchDate: Ten_DefineSearchDate): TvtLabel;
    {* Реализация слова скрипта .Ten_DefineSearchDate.ElLabel1 }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnDefineSearchDateElLabel1

 TkwEnDefineSearchDateElLabel2 = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_DefineSearchDate.ElLabel2 }
  private
   function ElLabel2(const aCtx: TtfwContext;
    aen_DefineSearchDate: Ten_DefineSearchDate): TvtLabel;
    {* Реализация слова скрипта .Ten_DefineSearchDate.ElLabel2 }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnDefineSearchDateElLabel2

 TkwEnDefineSearchDateElLabel3 = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_DefineSearchDate.ElLabel3 }
  private
   function ElLabel3(const aCtx: TtfwContext;
    aen_DefineSearchDate: Ten_DefineSearchDate): TvtLabel;
    {* Реализация слова скрипта .Ten_DefineSearchDate.ElLabel3 }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnDefineSearchDateElLabel3

 TkwEnDefineSearchDateDD1EqD2 = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_DefineSearchDate.dD1EqD2 }
  private
   function dD1EqD2(const aCtx: TtfwContext;
    aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
    {* Реализация слова скрипта .Ten_DefineSearchDate.dD1EqD2 }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnDefineSearchDateDD1EqD2

 TkwEnDefineSearchDateRbEq = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_DefineSearchDate.rbEq }
  private
   function rbEq(const aCtx: TtfwContext;
    aen_DefineSearchDate: Ten_DefineSearchDate): TvtRadioButton;
    {* Реализация слова скрипта .Ten_DefineSearchDate.rbEq }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnDefineSearchDateRbEq

 TkwEnDefineSearchDateRbInt = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_DefineSearchDate.rbInt }
  private
   function rbInt(const aCtx: TtfwContext;
    aen_DefineSearchDate: Ten_DefineSearchDate): TvtRadioButton;
    {* Реализация слова скрипта .Ten_DefineSearchDate.rbInt }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnDefineSearchDateRbInt

 TkwEnDefineSearchDateRbD2Only = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_DefineSearchDate.rbD2Only }
  private
   function rbD2Only(const aCtx: TtfwContext;
    aen_DefineSearchDate: Ten_DefineSearchDate): TvtRadioButton;
    {* Реализация слова скрипта .Ten_DefineSearchDate.rbD2Only }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnDefineSearchDateRbD2Only

 TkwEnDefineSearchDateDD1Only = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_DefineSearchDate.dD1Only }
  private
   function dD1Only(const aCtx: TtfwContext;
    aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
    {* Реализация слова скрипта .Ten_DefineSearchDate.dD1Only }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnDefineSearchDateDD1Only

 TkwEnDefineSearchDateDD2Only = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_DefineSearchDate.dD2Only }
  private
   function dD2Only(const aCtx: TtfwContext;
    aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
    {* Реализация слова скрипта .Ten_DefineSearchDate.dD2Only }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnDefineSearchDateDD2Only

 TkwEnDefineSearchDateDD1 = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_DefineSearchDate.dD1 }
  private
   function dD1(const aCtx: TtfwContext;
    aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
    {* Реализация слова скрипта .Ten_DefineSearchDate.dD1 }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnDefineSearchDateDD1

 TkwEnDefineSearchDateRbD1Only = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_DefineSearchDate.rbD1Only }
  private
   function rbD1Only(const aCtx: TtfwContext;
    aen_DefineSearchDate: Ten_DefineSearchDate): TvtRadioButton;
    {* Реализация слова скрипта .Ten_DefineSearchDate.rbD1Only }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnDefineSearchDateRbD1Only

 TkwEnDefineSearchDateDD2 = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_DefineSearchDate.dD2 }
  private
   function dD2(const aCtx: TtfwContext;
    aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
    {* Реализация слова скрипта .Ten_DefineSearchDate.dD2 }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnDefineSearchDateDD2

function Tkw_Form_DefineSearchDate.GetString: AnsiString;
begin
 Result := 'en_DefineSearchDate';
end;//Tkw_Form_DefineSearchDate.GetString

class function Tkw_Form_DefineSearchDate.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::DefineSearchDate';
end;//Tkw_Form_DefineSearchDate.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_Panel1.GetString: AnsiString;
begin
 Result := 'Panel1';
end;//Tkw_DefineSearchDate_Control_Panel1.GetString

class procedure Tkw_DefineSearchDate_Control_Panel1.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_DefineSearchDate_Control_Panel1.RegisterInEngine

class function Tkw_DefineSearchDate_Control_Panel1.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Panel1';
end;//Tkw_DefineSearchDate_Control_Panel1.GetWordNameForRegister

procedure Tkw_DefineSearchDate_Control_Panel1_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Panel1');
 inherited;
end;//Tkw_DefineSearchDate_Control_Panel1_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_Panel1_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Panel1:push';
end;//Tkw_DefineSearchDate_Control_Panel1_Push.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_ElLabel1.GetString: AnsiString;
begin
 Result := 'ElLabel1';
end;//Tkw_DefineSearchDate_Control_ElLabel1.GetString

class procedure Tkw_DefineSearchDate_Control_ElLabel1.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_DefineSearchDate_Control_ElLabel1.RegisterInEngine

class function Tkw_DefineSearchDate_Control_ElLabel1.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ElLabel1';
end;//Tkw_DefineSearchDate_Control_ElLabel1.GetWordNameForRegister

procedure Tkw_DefineSearchDate_Control_ElLabel1_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ElLabel1');
 inherited;
end;//Tkw_DefineSearchDate_Control_ElLabel1_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_ElLabel1_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ElLabel1:push';
end;//Tkw_DefineSearchDate_Control_ElLabel1_Push.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_ElLabel2.GetString: AnsiString;
begin
 Result := 'ElLabel2';
end;//Tkw_DefineSearchDate_Control_ElLabel2.GetString

class procedure Tkw_DefineSearchDate_Control_ElLabel2.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_DefineSearchDate_Control_ElLabel2.RegisterInEngine

class function Tkw_DefineSearchDate_Control_ElLabel2.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ElLabel2';
end;//Tkw_DefineSearchDate_Control_ElLabel2.GetWordNameForRegister

procedure Tkw_DefineSearchDate_Control_ElLabel2_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ElLabel2');
 inherited;
end;//Tkw_DefineSearchDate_Control_ElLabel2_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_ElLabel2_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ElLabel2:push';
end;//Tkw_DefineSearchDate_Control_ElLabel2_Push.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_ElLabel3.GetString: AnsiString;
begin
 Result := 'ElLabel3';
end;//Tkw_DefineSearchDate_Control_ElLabel3.GetString

class procedure Tkw_DefineSearchDate_Control_ElLabel3.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_DefineSearchDate_Control_ElLabel3.RegisterInEngine

class function Tkw_DefineSearchDate_Control_ElLabel3.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ElLabel3';
end;//Tkw_DefineSearchDate_Control_ElLabel3.GetWordNameForRegister

procedure Tkw_DefineSearchDate_Control_ElLabel3_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ElLabel3');
 inherited;
end;//Tkw_DefineSearchDate_Control_ElLabel3_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_ElLabel3_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ElLabel3:push';
end;//Tkw_DefineSearchDate_Control_ElLabel3_Push.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_dD1EqD2.GetString: AnsiString;
begin
 Result := 'dD1EqD2';
end;//Tkw_DefineSearchDate_Control_dD1EqD2.GetString

class procedure Tkw_DefineSearchDate_Control_dD1EqD2.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtDblClickDateEdit);
end;//Tkw_DefineSearchDate_Control_dD1EqD2.RegisterInEngine

class function Tkw_DefineSearchDate_Control_dD1EqD2.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::dD1EqD2';
end;//Tkw_DefineSearchDate_Control_dD1EqD2.GetWordNameForRegister

procedure Tkw_DefineSearchDate_Control_dD1EqD2_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('dD1EqD2');
 inherited;
end;//Tkw_DefineSearchDate_Control_dD1EqD2_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_dD1EqD2_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::dD1EqD2:push';
end;//Tkw_DefineSearchDate_Control_dD1EqD2_Push.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_rbEq.GetString: AnsiString;
begin
 Result := 'rbEq';
end;//Tkw_DefineSearchDate_Control_rbEq.GetString

class procedure Tkw_DefineSearchDate_Control_rbEq.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_DefineSearchDate_Control_rbEq.RegisterInEngine

class function Tkw_DefineSearchDate_Control_rbEq.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rbEq';
end;//Tkw_DefineSearchDate_Control_rbEq.GetWordNameForRegister

procedure Tkw_DefineSearchDate_Control_rbEq_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('rbEq');
 inherited;
end;//Tkw_DefineSearchDate_Control_rbEq_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_rbEq_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rbEq:push';
end;//Tkw_DefineSearchDate_Control_rbEq_Push.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_rbInt.GetString: AnsiString;
begin
 Result := 'rbInt';
end;//Tkw_DefineSearchDate_Control_rbInt.GetString

class procedure Tkw_DefineSearchDate_Control_rbInt.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_DefineSearchDate_Control_rbInt.RegisterInEngine

class function Tkw_DefineSearchDate_Control_rbInt.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rbInt';
end;//Tkw_DefineSearchDate_Control_rbInt.GetWordNameForRegister

procedure Tkw_DefineSearchDate_Control_rbInt_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('rbInt');
 inherited;
end;//Tkw_DefineSearchDate_Control_rbInt_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_rbInt_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rbInt:push';
end;//Tkw_DefineSearchDate_Control_rbInt_Push.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_rbD2Only.GetString: AnsiString;
begin
 Result := 'rbD2Only';
end;//Tkw_DefineSearchDate_Control_rbD2Only.GetString

class procedure Tkw_DefineSearchDate_Control_rbD2Only.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_DefineSearchDate_Control_rbD2Only.RegisterInEngine

class function Tkw_DefineSearchDate_Control_rbD2Only.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rbD2Only';
end;//Tkw_DefineSearchDate_Control_rbD2Only.GetWordNameForRegister

procedure Tkw_DefineSearchDate_Control_rbD2Only_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('rbD2Only');
 inherited;
end;//Tkw_DefineSearchDate_Control_rbD2Only_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_rbD2Only_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rbD2Only:push';
end;//Tkw_DefineSearchDate_Control_rbD2Only_Push.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_dD1Only.GetString: AnsiString;
begin
 Result := 'dD1Only';
end;//Tkw_DefineSearchDate_Control_dD1Only.GetString

class procedure Tkw_DefineSearchDate_Control_dD1Only.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtDblClickDateEdit);
end;//Tkw_DefineSearchDate_Control_dD1Only.RegisterInEngine

class function Tkw_DefineSearchDate_Control_dD1Only.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::dD1Only';
end;//Tkw_DefineSearchDate_Control_dD1Only.GetWordNameForRegister

procedure Tkw_DefineSearchDate_Control_dD1Only_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('dD1Only');
 inherited;
end;//Tkw_DefineSearchDate_Control_dD1Only_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_dD1Only_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::dD1Only:push';
end;//Tkw_DefineSearchDate_Control_dD1Only_Push.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_dD2Only.GetString: AnsiString;
begin
 Result := 'dD2Only';
end;//Tkw_DefineSearchDate_Control_dD2Only.GetString

class procedure Tkw_DefineSearchDate_Control_dD2Only.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtDblClickDateEdit);
end;//Tkw_DefineSearchDate_Control_dD2Only.RegisterInEngine

class function Tkw_DefineSearchDate_Control_dD2Only.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::dD2Only';
end;//Tkw_DefineSearchDate_Control_dD2Only.GetWordNameForRegister

procedure Tkw_DefineSearchDate_Control_dD2Only_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('dD2Only');
 inherited;
end;//Tkw_DefineSearchDate_Control_dD2Only_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_dD2Only_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::dD2Only:push';
end;//Tkw_DefineSearchDate_Control_dD2Only_Push.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_dD1.GetString: AnsiString;
begin
 Result := 'dD1';
end;//Tkw_DefineSearchDate_Control_dD1.GetString

class procedure Tkw_DefineSearchDate_Control_dD1.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtDblClickDateEdit);
end;//Tkw_DefineSearchDate_Control_dD1.RegisterInEngine

class function Tkw_DefineSearchDate_Control_dD1.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::dD1';
end;//Tkw_DefineSearchDate_Control_dD1.GetWordNameForRegister

procedure Tkw_DefineSearchDate_Control_dD1_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('dD1');
 inherited;
end;//Tkw_DefineSearchDate_Control_dD1_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_dD1_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::dD1:push';
end;//Tkw_DefineSearchDate_Control_dD1_Push.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_rbD1Only.GetString: AnsiString;
begin
 Result := 'rbD1Only';
end;//Tkw_DefineSearchDate_Control_rbD1Only.GetString

class procedure Tkw_DefineSearchDate_Control_rbD1Only.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_DefineSearchDate_Control_rbD1Only.RegisterInEngine

class function Tkw_DefineSearchDate_Control_rbD1Only.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rbD1Only';
end;//Tkw_DefineSearchDate_Control_rbD1Only.GetWordNameForRegister

procedure Tkw_DefineSearchDate_Control_rbD1Only_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('rbD1Only');
 inherited;
end;//Tkw_DefineSearchDate_Control_rbD1Only_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_rbD1Only_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rbD1Only:push';
end;//Tkw_DefineSearchDate_Control_rbD1Only_Push.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_dD2.GetString: AnsiString;
begin
 Result := 'dD2';
end;//Tkw_DefineSearchDate_Control_dD2.GetString

class procedure Tkw_DefineSearchDate_Control_dD2.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtDblClickDateEdit);
end;//Tkw_DefineSearchDate_Control_dD2.RegisterInEngine

class function Tkw_DefineSearchDate_Control_dD2.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::dD2';
end;//Tkw_DefineSearchDate_Control_dD2.GetWordNameForRegister

procedure Tkw_DefineSearchDate_Control_dD2_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('dD2');
 inherited;
end;//Tkw_DefineSearchDate_Control_dD2_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_dD2_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::dD2:push';
end;//Tkw_DefineSearchDate_Control_dD2_Push.GetWordNameForRegister

function TkwEnDefineSearchDatePanel1.Panel1(const aCtx: TtfwContext;
 aen_DefineSearchDate: Ten_DefineSearchDate): TvtPanel;
 {* Реализация слова скрипта .Ten_DefineSearchDate.Panel1 }
begin
 Result := aen_DefineSearchDate.Panel1;
end;//TkwEnDefineSearchDatePanel1.Panel1

class function TkwEnDefineSearchDatePanel1.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_DefineSearchDate.Panel1';
end;//TkwEnDefineSearchDatePanel1.GetWordNameForRegister

function TkwEnDefineSearchDatePanel1.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnDefineSearchDatePanel1.GetResultTypeInfo

function TkwEnDefineSearchDatePanel1.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnDefineSearchDatePanel1.GetAllParamsCount

function TkwEnDefineSearchDatePanel1.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_DefineSearchDate)]);
end;//TkwEnDefineSearchDatePanel1.ParamsTypes

procedure TkwEnDefineSearchDatePanel1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Panel1', aCtx);
end;//TkwEnDefineSearchDatePanel1.SetValuePrim

procedure TkwEnDefineSearchDatePanel1.DoDoIt(const aCtx: TtfwContext);
var l_aen_DefineSearchDate: Ten_DefineSearchDate;
begin
 try
  l_aen_DefineSearchDate := Ten_DefineSearchDate(aCtx.rEngine.PopObjAs(Ten_DefineSearchDate));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_DefineSearchDate: Ten_DefineSearchDate : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Panel1(aCtx, l_aen_DefineSearchDate));
end;//TkwEnDefineSearchDatePanel1.DoDoIt

function TkwEnDefineSearchDateElLabel1.ElLabel1(const aCtx: TtfwContext;
 aen_DefineSearchDate: Ten_DefineSearchDate): TvtLabel;
 {* Реализация слова скрипта .Ten_DefineSearchDate.ElLabel1 }
begin
 Result := aen_DefineSearchDate.ElLabel1;
end;//TkwEnDefineSearchDateElLabel1.ElLabel1

class function TkwEnDefineSearchDateElLabel1.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_DefineSearchDate.ElLabel1';
end;//TkwEnDefineSearchDateElLabel1.GetWordNameForRegister

function TkwEnDefineSearchDateElLabel1.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEnDefineSearchDateElLabel1.GetResultTypeInfo

function TkwEnDefineSearchDateElLabel1.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnDefineSearchDateElLabel1.GetAllParamsCount

function TkwEnDefineSearchDateElLabel1.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_DefineSearchDate)]);
end;//TkwEnDefineSearchDateElLabel1.ParamsTypes

procedure TkwEnDefineSearchDateElLabel1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ElLabel1', aCtx);
end;//TkwEnDefineSearchDateElLabel1.SetValuePrim

procedure TkwEnDefineSearchDateElLabel1.DoDoIt(const aCtx: TtfwContext);
var l_aen_DefineSearchDate: Ten_DefineSearchDate;
begin
 try
  l_aen_DefineSearchDate := Ten_DefineSearchDate(aCtx.rEngine.PopObjAs(Ten_DefineSearchDate));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_DefineSearchDate: Ten_DefineSearchDate : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ElLabel1(aCtx, l_aen_DefineSearchDate));
end;//TkwEnDefineSearchDateElLabel1.DoDoIt

function TkwEnDefineSearchDateElLabel2.ElLabel2(const aCtx: TtfwContext;
 aen_DefineSearchDate: Ten_DefineSearchDate): TvtLabel;
 {* Реализация слова скрипта .Ten_DefineSearchDate.ElLabel2 }
begin
 Result := aen_DefineSearchDate.ElLabel2;
end;//TkwEnDefineSearchDateElLabel2.ElLabel2

class function TkwEnDefineSearchDateElLabel2.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_DefineSearchDate.ElLabel2';
end;//TkwEnDefineSearchDateElLabel2.GetWordNameForRegister

function TkwEnDefineSearchDateElLabel2.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEnDefineSearchDateElLabel2.GetResultTypeInfo

function TkwEnDefineSearchDateElLabel2.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnDefineSearchDateElLabel2.GetAllParamsCount

function TkwEnDefineSearchDateElLabel2.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_DefineSearchDate)]);
end;//TkwEnDefineSearchDateElLabel2.ParamsTypes

procedure TkwEnDefineSearchDateElLabel2.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ElLabel2', aCtx);
end;//TkwEnDefineSearchDateElLabel2.SetValuePrim

procedure TkwEnDefineSearchDateElLabel2.DoDoIt(const aCtx: TtfwContext);
var l_aen_DefineSearchDate: Ten_DefineSearchDate;
begin
 try
  l_aen_DefineSearchDate := Ten_DefineSearchDate(aCtx.rEngine.PopObjAs(Ten_DefineSearchDate));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_DefineSearchDate: Ten_DefineSearchDate : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ElLabel2(aCtx, l_aen_DefineSearchDate));
end;//TkwEnDefineSearchDateElLabel2.DoDoIt

function TkwEnDefineSearchDateElLabel3.ElLabel3(const aCtx: TtfwContext;
 aen_DefineSearchDate: Ten_DefineSearchDate): TvtLabel;
 {* Реализация слова скрипта .Ten_DefineSearchDate.ElLabel3 }
begin
 Result := aen_DefineSearchDate.ElLabel3;
end;//TkwEnDefineSearchDateElLabel3.ElLabel3

class function TkwEnDefineSearchDateElLabel3.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_DefineSearchDate.ElLabel3';
end;//TkwEnDefineSearchDateElLabel3.GetWordNameForRegister

function TkwEnDefineSearchDateElLabel3.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEnDefineSearchDateElLabel3.GetResultTypeInfo

function TkwEnDefineSearchDateElLabel3.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnDefineSearchDateElLabel3.GetAllParamsCount

function TkwEnDefineSearchDateElLabel3.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_DefineSearchDate)]);
end;//TkwEnDefineSearchDateElLabel3.ParamsTypes

procedure TkwEnDefineSearchDateElLabel3.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ElLabel3', aCtx);
end;//TkwEnDefineSearchDateElLabel3.SetValuePrim

procedure TkwEnDefineSearchDateElLabel3.DoDoIt(const aCtx: TtfwContext);
var l_aen_DefineSearchDate: Ten_DefineSearchDate;
begin
 try
  l_aen_DefineSearchDate := Ten_DefineSearchDate(aCtx.rEngine.PopObjAs(Ten_DefineSearchDate));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_DefineSearchDate: Ten_DefineSearchDate : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ElLabel3(aCtx, l_aen_DefineSearchDate));
end;//TkwEnDefineSearchDateElLabel3.DoDoIt

function TkwEnDefineSearchDateDD1EqD2.dD1EqD2(const aCtx: TtfwContext;
 aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
 {* Реализация слова скрипта .Ten_DefineSearchDate.dD1EqD2 }
begin
 Result := aen_DefineSearchDate.dD1EqD2;
end;//TkwEnDefineSearchDateDD1EqD2.dD1EqD2

class function TkwEnDefineSearchDateDD1EqD2.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_DefineSearchDate.dD1EqD2';
end;//TkwEnDefineSearchDateDD1EqD2.GetWordNameForRegister

function TkwEnDefineSearchDateDD1EqD2.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtDblClickDateEdit);
end;//TkwEnDefineSearchDateDD1EqD2.GetResultTypeInfo

function TkwEnDefineSearchDateDD1EqD2.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnDefineSearchDateDD1EqD2.GetAllParamsCount

function TkwEnDefineSearchDateDD1EqD2.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_DefineSearchDate)]);
end;//TkwEnDefineSearchDateDD1EqD2.ParamsTypes

procedure TkwEnDefineSearchDateDD1EqD2.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству dD1EqD2', aCtx);
end;//TkwEnDefineSearchDateDD1EqD2.SetValuePrim

procedure TkwEnDefineSearchDateDD1EqD2.DoDoIt(const aCtx: TtfwContext);
var l_aen_DefineSearchDate: Ten_DefineSearchDate;
begin
 try
  l_aen_DefineSearchDate := Ten_DefineSearchDate(aCtx.rEngine.PopObjAs(Ten_DefineSearchDate));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_DefineSearchDate: Ten_DefineSearchDate : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(dD1EqD2(aCtx, l_aen_DefineSearchDate));
end;//TkwEnDefineSearchDateDD1EqD2.DoDoIt

function TkwEnDefineSearchDateRbEq.rbEq(const aCtx: TtfwContext;
 aen_DefineSearchDate: Ten_DefineSearchDate): TvtRadioButton;
 {* Реализация слова скрипта .Ten_DefineSearchDate.rbEq }
begin
 Result := aen_DefineSearchDate.rbEq;
end;//TkwEnDefineSearchDateRbEq.rbEq

class function TkwEnDefineSearchDateRbEq.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_DefineSearchDate.rbEq';
end;//TkwEnDefineSearchDateRbEq.GetWordNameForRegister

function TkwEnDefineSearchDateRbEq.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnDefineSearchDateRbEq.GetResultTypeInfo

function TkwEnDefineSearchDateRbEq.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnDefineSearchDateRbEq.GetAllParamsCount

function TkwEnDefineSearchDateRbEq.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_DefineSearchDate)]);
end;//TkwEnDefineSearchDateRbEq.ParamsTypes

procedure TkwEnDefineSearchDateRbEq.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству rbEq', aCtx);
end;//TkwEnDefineSearchDateRbEq.SetValuePrim

procedure TkwEnDefineSearchDateRbEq.DoDoIt(const aCtx: TtfwContext);
var l_aen_DefineSearchDate: Ten_DefineSearchDate;
begin
 try
  l_aen_DefineSearchDate := Ten_DefineSearchDate(aCtx.rEngine.PopObjAs(Ten_DefineSearchDate));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_DefineSearchDate: Ten_DefineSearchDate : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(rbEq(aCtx, l_aen_DefineSearchDate));
end;//TkwEnDefineSearchDateRbEq.DoDoIt

function TkwEnDefineSearchDateRbInt.rbInt(const aCtx: TtfwContext;
 aen_DefineSearchDate: Ten_DefineSearchDate): TvtRadioButton;
 {* Реализация слова скрипта .Ten_DefineSearchDate.rbInt }
begin
 Result := aen_DefineSearchDate.rbInt;
end;//TkwEnDefineSearchDateRbInt.rbInt

class function TkwEnDefineSearchDateRbInt.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_DefineSearchDate.rbInt';
end;//TkwEnDefineSearchDateRbInt.GetWordNameForRegister

function TkwEnDefineSearchDateRbInt.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnDefineSearchDateRbInt.GetResultTypeInfo

function TkwEnDefineSearchDateRbInt.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnDefineSearchDateRbInt.GetAllParamsCount

function TkwEnDefineSearchDateRbInt.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_DefineSearchDate)]);
end;//TkwEnDefineSearchDateRbInt.ParamsTypes

procedure TkwEnDefineSearchDateRbInt.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству rbInt', aCtx);
end;//TkwEnDefineSearchDateRbInt.SetValuePrim

procedure TkwEnDefineSearchDateRbInt.DoDoIt(const aCtx: TtfwContext);
var l_aen_DefineSearchDate: Ten_DefineSearchDate;
begin
 try
  l_aen_DefineSearchDate := Ten_DefineSearchDate(aCtx.rEngine.PopObjAs(Ten_DefineSearchDate));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_DefineSearchDate: Ten_DefineSearchDate : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(rbInt(aCtx, l_aen_DefineSearchDate));
end;//TkwEnDefineSearchDateRbInt.DoDoIt

function TkwEnDefineSearchDateRbD2Only.rbD2Only(const aCtx: TtfwContext;
 aen_DefineSearchDate: Ten_DefineSearchDate): TvtRadioButton;
 {* Реализация слова скрипта .Ten_DefineSearchDate.rbD2Only }
begin
 Result := aen_DefineSearchDate.rbD2Only;
end;//TkwEnDefineSearchDateRbD2Only.rbD2Only

class function TkwEnDefineSearchDateRbD2Only.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_DefineSearchDate.rbD2Only';
end;//TkwEnDefineSearchDateRbD2Only.GetWordNameForRegister

function TkwEnDefineSearchDateRbD2Only.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnDefineSearchDateRbD2Only.GetResultTypeInfo

function TkwEnDefineSearchDateRbD2Only.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnDefineSearchDateRbD2Only.GetAllParamsCount

function TkwEnDefineSearchDateRbD2Only.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_DefineSearchDate)]);
end;//TkwEnDefineSearchDateRbD2Only.ParamsTypes

procedure TkwEnDefineSearchDateRbD2Only.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству rbD2Only', aCtx);
end;//TkwEnDefineSearchDateRbD2Only.SetValuePrim

procedure TkwEnDefineSearchDateRbD2Only.DoDoIt(const aCtx: TtfwContext);
var l_aen_DefineSearchDate: Ten_DefineSearchDate;
begin
 try
  l_aen_DefineSearchDate := Ten_DefineSearchDate(aCtx.rEngine.PopObjAs(Ten_DefineSearchDate));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_DefineSearchDate: Ten_DefineSearchDate : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(rbD2Only(aCtx, l_aen_DefineSearchDate));
end;//TkwEnDefineSearchDateRbD2Only.DoDoIt

function TkwEnDefineSearchDateDD1Only.dD1Only(const aCtx: TtfwContext;
 aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
 {* Реализация слова скрипта .Ten_DefineSearchDate.dD1Only }
begin
 Result := aen_DefineSearchDate.dD1Only;
end;//TkwEnDefineSearchDateDD1Only.dD1Only

class function TkwEnDefineSearchDateDD1Only.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_DefineSearchDate.dD1Only';
end;//TkwEnDefineSearchDateDD1Only.GetWordNameForRegister

function TkwEnDefineSearchDateDD1Only.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtDblClickDateEdit);
end;//TkwEnDefineSearchDateDD1Only.GetResultTypeInfo

function TkwEnDefineSearchDateDD1Only.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnDefineSearchDateDD1Only.GetAllParamsCount

function TkwEnDefineSearchDateDD1Only.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_DefineSearchDate)]);
end;//TkwEnDefineSearchDateDD1Only.ParamsTypes

procedure TkwEnDefineSearchDateDD1Only.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству dD1Only', aCtx);
end;//TkwEnDefineSearchDateDD1Only.SetValuePrim

procedure TkwEnDefineSearchDateDD1Only.DoDoIt(const aCtx: TtfwContext);
var l_aen_DefineSearchDate: Ten_DefineSearchDate;
begin
 try
  l_aen_DefineSearchDate := Ten_DefineSearchDate(aCtx.rEngine.PopObjAs(Ten_DefineSearchDate));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_DefineSearchDate: Ten_DefineSearchDate : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(dD1Only(aCtx, l_aen_DefineSearchDate));
end;//TkwEnDefineSearchDateDD1Only.DoDoIt

function TkwEnDefineSearchDateDD2Only.dD2Only(const aCtx: TtfwContext;
 aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
 {* Реализация слова скрипта .Ten_DefineSearchDate.dD2Only }
begin
 Result := aen_DefineSearchDate.dD2Only;
end;//TkwEnDefineSearchDateDD2Only.dD2Only

class function TkwEnDefineSearchDateDD2Only.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_DefineSearchDate.dD2Only';
end;//TkwEnDefineSearchDateDD2Only.GetWordNameForRegister

function TkwEnDefineSearchDateDD2Only.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtDblClickDateEdit);
end;//TkwEnDefineSearchDateDD2Only.GetResultTypeInfo

function TkwEnDefineSearchDateDD2Only.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnDefineSearchDateDD2Only.GetAllParamsCount

function TkwEnDefineSearchDateDD2Only.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_DefineSearchDate)]);
end;//TkwEnDefineSearchDateDD2Only.ParamsTypes

procedure TkwEnDefineSearchDateDD2Only.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству dD2Only', aCtx);
end;//TkwEnDefineSearchDateDD2Only.SetValuePrim

procedure TkwEnDefineSearchDateDD2Only.DoDoIt(const aCtx: TtfwContext);
var l_aen_DefineSearchDate: Ten_DefineSearchDate;
begin
 try
  l_aen_DefineSearchDate := Ten_DefineSearchDate(aCtx.rEngine.PopObjAs(Ten_DefineSearchDate));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_DefineSearchDate: Ten_DefineSearchDate : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(dD2Only(aCtx, l_aen_DefineSearchDate));
end;//TkwEnDefineSearchDateDD2Only.DoDoIt

function TkwEnDefineSearchDateDD1.dD1(const aCtx: TtfwContext;
 aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
 {* Реализация слова скрипта .Ten_DefineSearchDate.dD1 }
begin
 Result := aen_DefineSearchDate.dD1;
end;//TkwEnDefineSearchDateDD1.dD1

class function TkwEnDefineSearchDateDD1.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_DefineSearchDate.dD1';
end;//TkwEnDefineSearchDateDD1.GetWordNameForRegister

function TkwEnDefineSearchDateDD1.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtDblClickDateEdit);
end;//TkwEnDefineSearchDateDD1.GetResultTypeInfo

function TkwEnDefineSearchDateDD1.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnDefineSearchDateDD1.GetAllParamsCount

function TkwEnDefineSearchDateDD1.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_DefineSearchDate)]);
end;//TkwEnDefineSearchDateDD1.ParamsTypes

procedure TkwEnDefineSearchDateDD1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству dD1', aCtx);
end;//TkwEnDefineSearchDateDD1.SetValuePrim

procedure TkwEnDefineSearchDateDD1.DoDoIt(const aCtx: TtfwContext);
var l_aen_DefineSearchDate: Ten_DefineSearchDate;
begin
 try
  l_aen_DefineSearchDate := Ten_DefineSearchDate(aCtx.rEngine.PopObjAs(Ten_DefineSearchDate));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_DefineSearchDate: Ten_DefineSearchDate : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(dD1(aCtx, l_aen_DefineSearchDate));
end;//TkwEnDefineSearchDateDD1.DoDoIt

function TkwEnDefineSearchDateRbD1Only.rbD1Only(const aCtx: TtfwContext;
 aen_DefineSearchDate: Ten_DefineSearchDate): TvtRadioButton;
 {* Реализация слова скрипта .Ten_DefineSearchDate.rbD1Only }
begin
 Result := aen_DefineSearchDate.rbD1Only;
end;//TkwEnDefineSearchDateRbD1Only.rbD1Only

class function TkwEnDefineSearchDateRbD1Only.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_DefineSearchDate.rbD1Only';
end;//TkwEnDefineSearchDateRbD1Only.GetWordNameForRegister

function TkwEnDefineSearchDateRbD1Only.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnDefineSearchDateRbD1Only.GetResultTypeInfo

function TkwEnDefineSearchDateRbD1Only.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnDefineSearchDateRbD1Only.GetAllParamsCount

function TkwEnDefineSearchDateRbD1Only.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_DefineSearchDate)]);
end;//TkwEnDefineSearchDateRbD1Only.ParamsTypes

procedure TkwEnDefineSearchDateRbD1Only.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству rbD1Only', aCtx);
end;//TkwEnDefineSearchDateRbD1Only.SetValuePrim

procedure TkwEnDefineSearchDateRbD1Only.DoDoIt(const aCtx: TtfwContext);
var l_aen_DefineSearchDate: Ten_DefineSearchDate;
begin
 try
  l_aen_DefineSearchDate := Ten_DefineSearchDate(aCtx.rEngine.PopObjAs(Ten_DefineSearchDate));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_DefineSearchDate: Ten_DefineSearchDate : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(rbD1Only(aCtx, l_aen_DefineSearchDate));
end;//TkwEnDefineSearchDateRbD1Only.DoDoIt

function TkwEnDefineSearchDateDD2.dD2(const aCtx: TtfwContext;
 aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
 {* Реализация слова скрипта .Ten_DefineSearchDate.dD2 }
begin
 Result := aen_DefineSearchDate.dD2;
end;//TkwEnDefineSearchDateDD2.dD2

class function TkwEnDefineSearchDateDD2.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_DefineSearchDate.dD2';
end;//TkwEnDefineSearchDateDD2.GetWordNameForRegister

function TkwEnDefineSearchDateDD2.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtDblClickDateEdit);
end;//TkwEnDefineSearchDateDD2.GetResultTypeInfo

function TkwEnDefineSearchDateDD2.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnDefineSearchDateDD2.GetAllParamsCount

function TkwEnDefineSearchDateDD2.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_DefineSearchDate)]);
end;//TkwEnDefineSearchDateDD2.ParamsTypes

procedure TkwEnDefineSearchDateDD2.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству dD2', aCtx);
end;//TkwEnDefineSearchDateDD2.SetValuePrim

procedure TkwEnDefineSearchDateDD2.DoDoIt(const aCtx: TtfwContext);
var l_aen_DefineSearchDate: Ten_DefineSearchDate;
begin
 try
  l_aen_DefineSearchDate := Ten_DefineSearchDate(aCtx.rEngine.PopObjAs(Ten_DefineSearchDate));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_DefineSearchDate: Ten_DefineSearchDate : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(dD2(aCtx, l_aen_DefineSearchDate));
end;//TkwEnDefineSearchDateDD2.DoDoIt

initialization
 Tkw_Form_DefineSearchDate.RegisterInEngine;
 {* Регистрация Tkw_Form_DefineSearchDate }
 Tkw_DefineSearchDate_Control_Panel1.RegisterInEngine;
 {* Регистрация Tkw_DefineSearchDate_Control_Panel1 }
 Tkw_DefineSearchDate_Control_Panel1_Push.RegisterInEngine;
 {* Регистрация Tkw_DefineSearchDate_Control_Panel1_Push }
 Tkw_DefineSearchDate_Control_ElLabel1.RegisterInEngine;
 {* Регистрация Tkw_DefineSearchDate_Control_ElLabel1 }
 Tkw_DefineSearchDate_Control_ElLabel1_Push.RegisterInEngine;
 {* Регистрация Tkw_DefineSearchDate_Control_ElLabel1_Push }
 Tkw_DefineSearchDate_Control_ElLabel2.RegisterInEngine;
 {* Регистрация Tkw_DefineSearchDate_Control_ElLabel2 }
 Tkw_DefineSearchDate_Control_ElLabel2_Push.RegisterInEngine;
 {* Регистрация Tkw_DefineSearchDate_Control_ElLabel2_Push }
 Tkw_DefineSearchDate_Control_ElLabel3.RegisterInEngine;
 {* Регистрация Tkw_DefineSearchDate_Control_ElLabel3 }
 Tkw_DefineSearchDate_Control_ElLabel3_Push.RegisterInEngine;
 {* Регистрация Tkw_DefineSearchDate_Control_ElLabel3_Push }
 Tkw_DefineSearchDate_Control_dD1EqD2.RegisterInEngine;
 {* Регистрация Tkw_DefineSearchDate_Control_dD1EqD2 }
 Tkw_DefineSearchDate_Control_dD1EqD2_Push.RegisterInEngine;
 {* Регистрация Tkw_DefineSearchDate_Control_dD1EqD2_Push }
 Tkw_DefineSearchDate_Control_rbEq.RegisterInEngine;
 {* Регистрация Tkw_DefineSearchDate_Control_rbEq }
 Tkw_DefineSearchDate_Control_rbEq_Push.RegisterInEngine;
 {* Регистрация Tkw_DefineSearchDate_Control_rbEq_Push }
 Tkw_DefineSearchDate_Control_rbInt.RegisterInEngine;
 {* Регистрация Tkw_DefineSearchDate_Control_rbInt }
 Tkw_DefineSearchDate_Control_rbInt_Push.RegisterInEngine;
 {* Регистрация Tkw_DefineSearchDate_Control_rbInt_Push }
 Tkw_DefineSearchDate_Control_rbD2Only.RegisterInEngine;
 {* Регистрация Tkw_DefineSearchDate_Control_rbD2Only }
 Tkw_DefineSearchDate_Control_rbD2Only_Push.RegisterInEngine;
 {* Регистрация Tkw_DefineSearchDate_Control_rbD2Only_Push }
 Tkw_DefineSearchDate_Control_dD1Only.RegisterInEngine;
 {* Регистрация Tkw_DefineSearchDate_Control_dD1Only }
 Tkw_DefineSearchDate_Control_dD1Only_Push.RegisterInEngine;
 {* Регистрация Tkw_DefineSearchDate_Control_dD1Only_Push }
 Tkw_DefineSearchDate_Control_dD2Only.RegisterInEngine;
 {* Регистрация Tkw_DefineSearchDate_Control_dD2Only }
 Tkw_DefineSearchDate_Control_dD2Only_Push.RegisterInEngine;
 {* Регистрация Tkw_DefineSearchDate_Control_dD2Only_Push }
 Tkw_DefineSearchDate_Control_dD1.RegisterInEngine;
 {* Регистрация Tkw_DefineSearchDate_Control_dD1 }
 Tkw_DefineSearchDate_Control_dD1_Push.RegisterInEngine;
 {* Регистрация Tkw_DefineSearchDate_Control_dD1_Push }
 Tkw_DefineSearchDate_Control_rbD1Only.RegisterInEngine;
 {* Регистрация Tkw_DefineSearchDate_Control_rbD1Only }
 Tkw_DefineSearchDate_Control_rbD1Only_Push.RegisterInEngine;
 {* Регистрация Tkw_DefineSearchDate_Control_rbD1Only_Push }
 Tkw_DefineSearchDate_Control_dD2.RegisterInEngine;
 {* Регистрация Tkw_DefineSearchDate_Control_dD2 }
 Tkw_DefineSearchDate_Control_dD2_Push.RegisterInEngine;
 {* Регистрация Tkw_DefineSearchDate_Control_dD2_Push }
 TkwEnDefineSearchDatePanel1.RegisterInEngine;
 {* Регистрация en_DefineSearchDate_Panel1 }
 TkwEnDefineSearchDateElLabel1.RegisterInEngine;
 {* Регистрация en_DefineSearchDate_ElLabel1 }
 TkwEnDefineSearchDateElLabel2.RegisterInEngine;
 {* Регистрация en_DefineSearchDate_ElLabel2 }
 TkwEnDefineSearchDateElLabel3.RegisterInEngine;
 {* Регистрация en_DefineSearchDate_ElLabel3 }
 TkwEnDefineSearchDateDD1EqD2.RegisterInEngine;
 {* Регистрация en_DefineSearchDate_dD1EqD2 }
 TkwEnDefineSearchDateRbEq.RegisterInEngine;
 {* Регистрация en_DefineSearchDate_rbEq }
 TkwEnDefineSearchDateRbInt.RegisterInEngine;
 {* Регистрация en_DefineSearchDate_rbInt }
 TkwEnDefineSearchDateRbD2Only.RegisterInEngine;
 {* Регистрация en_DefineSearchDate_rbD2Only }
 TkwEnDefineSearchDateDD1Only.RegisterInEngine;
 {* Регистрация en_DefineSearchDate_dD1Only }
 TkwEnDefineSearchDateDD2Only.RegisterInEngine;
 {* Регистрация en_DefineSearchDate_dD2Only }
 TkwEnDefineSearchDateDD1.RegisterInEngine;
 {* Регистрация en_DefineSearchDate_dD1 }
 TkwEnDefineSearchDateRbD1Only.RegisterInEngine;
 {* Регистрация en_DefineSearchDate_rbD1Only }
 TkwEnDefineSearchDateDD2.RegisterInEngine;
 {* Регистрация en_DefineSearchDate_dD2 }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_DefineSearchDate));
 {* Регистрация типа Ten_DefineSearchDate }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* Регистрация типа TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtDblClickDateEdit));
 {* Регистрация типа TvtDblClickDateEdit }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtRadioButton));
 {* Регистрация типа TvtRadioButton }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
