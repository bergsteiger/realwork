unit DefineSearchDateKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы DefineSearchDate }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\DefineSearchDateKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Search_Module
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
 Tkw_Form_DefineSearchDate = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы DefineSearchDate
----
*Пример использования*:
[code]
'aControl' форма::DefineSearchDate TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_DefineSearchDate

 Tkw_DefineSearchDate_Control_Panel1 = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Panel1
----
*Пример использования*:
[code]
контрол::Panel1 TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DefineSearchDate_Control_Panel1

 Tkw_DefineSearchDate_Control_Panel1_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DefineSearchDate_Control_ElLabel1

 Tkw_DefineSearchDate_Control_ElLabel1_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DefineSearchDate_Control_ElLabel2

 Tkw_DefineSearchDate_Control_ElLabel2_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DefineSearchDate_Control_ElLabel3

 Tkw_DefineSearchDate_Control_ElLabel3_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DefineSearchDate_Control_dD1EqD2

 Tkw_DefineSearchDate_Control_dD1EqD2_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DefineSearchDate_Control_rbEq

 Tkw_DefineSearchDate_Control_rbEq_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DefineSearchDate_Control_rbInt

 Tkw_DefineSearchDate_Control_rbInt_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DefineSearchDate_Control_rbD2Only

 Tkw_DefineSearchDate_Control_rbD2Only_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DefineSearchDate_Control_dD1Only

 Tkw_DefineSearchDate_Control_dD1Only_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DefineSearchDate_Control_dD2Only

 Tkw_DefineSearchDate_Control_dD2Only_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DefineSearchDate_Control_dD1

 Tkw_DefineSearchDate_Control_dD1_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DefineSearchDate_Control_rbD1Only

 Tkw_DefineSearchDate_Control_rbD1Only_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DefineSearchDate_Control_dD2

 Tkw_DefineSearchDate_Control_dD2_Push = {final} class(TkwBynameControlPush)
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
  {* Слово скрипта .Ten_DefineSearchDate.Panel1
[panel]Контрол Panel1 формы Ten_DefineSearchDate[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_DefineSearchDate .Ten_DefineSearchDate.Panel1 >>> l_TvtPanel
[code]  }
  private
   function Panel1(const aCtx: TtfwContext;
    aen_DefineSearchDate: Ten_DefineSearchDate): TvtPanel;
    {* Реализация слова скрипта .Ten_DefineSearchDate.Panel1 }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnDefineSearchDatePanel1

 TkwEnDefineSearchDateElLabel1 = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_DefineSearchDate.ElLabel1
[panel]Контрол ElLabel1 формы Ten_DefineSearchDate[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aen_DefineSearchDate .Ten_DefineSearchDate.ElLabel1 >>> l_TvtLabel
[code]  }
  private
   function ElLabel1(const aCtx: TtfwContext;
    aen_DefineSearchDate: Ten_DefineSearchDate): TvtLabel;
    {* Реализация слова скрипта .Ten_DefineSearchDate.ElLabel1 }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnDefineSearchDateElLabel1

 TkwEnDefineSearchDateElLabel2 = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_DefineSearchDate.ElLabel2
[panel]Контрол ElLabel2 формы Ten_DefineSearchDate[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aen_DefineSearchDate .Ten_DefineSearchDate.ElLabel2 >>> l_TvtLabel
[code]  }
  private
   function ElLabel2(const aCtx: TtfwContext;
    aen_DefineSearchDate: Ten_DefineSearchDate): TvtLabel;
    {* Реализация слова скрипта .Ten_DefineSearchDate.ElLabel2 }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnDefineSearchDateElLabel2

 TkwEnDefineSearchDateElLabel3 = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_DefineSearchDate.ElLabel3
[panel]Контрол ElLabel3 формы Ten_DefineSearchDate[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aen_DefineSearchDate .Ten_DefineSearchDate.ElLabel3 >>> l_TvtLabel
[code]  }
  private
   function ElLabel3(const aCtx: TtfwContext;
    aen_DefineSearchDate: Ten_DefineSearchDate): TvtLabel;
    {* Реализация слова скрипта .Ten_DefineSearchDate.ElLabel3 }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnDefineSearchDateElLabel3

 TkwEnDefineSearchDateDD1EqD2 = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_DefineSearchDate.dD1EqD2
[panel]Контрол dD1EqD2 формы Ten_DefineSearchDate[panel]
*Тип результата:* TvtDblClickDateEdit
*Пример:*
[code]
OBJECT VAR l_TvtDblClickDateEdit
 aen_DefineSearchDate .Ten_DefineSearchDate.dD1EqD2 >>> l_TvtDblClickDateEdit
[code]  }
  private
   function dD1EqD2(const aCtx: TtfwContext;
    aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
    {* Реализация слова скрипта .Ten_DefineSearchDate.dD1EqD2 }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnDefineSearchDateDD1EqD2

 TkwEnDefineSearchDateRbEq = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_DefineSearchDate.rbEq
[panel]Контрол rbEq формы Ten_DefineSearchDate[panel]
*Тип результата:* TvtRadioButton
*Пример:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_DefineSearchDate .Ten_DefineSearchDate.rbEq >>> l_TvtRadioButton
[code]  }
  private
   function rbEq(const aCtx: TtfwContext;
    aen_DefineSearchDate: Ten_DefineSearchDate): TvtRadioButton;
    {* Реализация слова скрипта .Ten_DefineSearchDate.rbEq }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnDefineSearchDateRbEq

 TkwEnDefineSearchDateRbInt = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_DefineSearchDate.rbInt
[panel]Контрол rbInt формы Ten_DefineSearchDate[panel]
*Тип результата:* TvtRadioButton
*Пример:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_DefineSearchDate .Ten_DefineSearchDate.rbInt >>> l_TvtRadioButton
[code]  }
  private
   function rbInt(const aCtx: TtfwContext;
    aen_DefineSearchDate: Ten_DefineSearchDate): TvtRadioButton;
    {* Реализация слова скрипта .Ten_DefineSearchDate.rbInt }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnDefineSearchDateRbInt

 TkwEnDefineSearchDateRbD2Only = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_DefineSearchDate.rbD2Only
[panel]Контрол rbD2Only формы Ten_DefineSearchDate[panel]
*Тип результата:* TvtRadioButton
*Пример:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_DefineSearchDate .Ten_DefineSearchDate.rbD2Only >>> l_TvtRadioButton
[code]  }
  private
   function rbD2Only(const aCtx: TtfwContext;
    aen_DefineSearchDate: Ten_DefineSearchDate): TvtRadioButton;
    {* Реализация слова скрипта .Ten_DefineSearchDate.rbD2Only }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnDefineSearchDateRbD2Only

 TkwEnDefineSearchDateDD1Only = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_DefineSearchDate.dD1Only
[panel]Контрол dD1Only формы Ten_DefineSearchDate[panel]
*Тип результата:* TvtDblClickDateEdit
*Пример:*
[code]
OBJECT VAR l_TvtDblClickDateEdit
 aen_DefineSearchDate .Ten_DefineSearchDate.dD1Only >>> l_TvtDblClickDateEdit
[code]  }
  private
   function dD1Only(const aCtx: TtfwContext;
    aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
    {* Реализация слова скрипта .Ten_DefineSearchDate.dD1Only }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnDefineSearchDateDD1Only

 TkwEnDefineSearchDateDD2Only = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_DefineSearchDate.dD2Only
[panel]Контрол dD2Only формы Ten_DefineSearchDate[panel]
*Тип результата:* TvtDblClickDateEdit
*Пример:*
[code]
OBJECT VAR l_TvtDblClickDateEdit
 aen_DefineSearchDate .Ten_DefineSearchDate.dD2Only >>> l_TvtDblClickDateEdit
[code]  }
  private
   function dD2Only(const aCtx: TtfwContext;
    aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
    {* Реализация слова скрипта .Ten_DefineSearchDate.dD2Only }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnDefineSearchDateDD2Only

 TkwEnDefineSearchDateDD1 = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_DefineSearchDate.dD1
[panel]Контрол dD1 формы Ten_DefineSearchDate[panel]
*Тип результата:* TvtDblClickDateEdit
*Пример:*
[code]
OBJECT VAR l_TvtDblClickDateEdit
 aen_DefineSearchDate .Ten_DefineSearchDate.dD1 >>> l_TvtDblClickDateEdit
[code]  }
  private
   function dD1(const aCtx: TtfwContext;
    aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
    {* Реализация слова скрипта .Ten_DefineSearchDate.dD1 }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnDefineSearchDateDD1

 TkwEnDefineSearchDateRbD1Only = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_DefineSearchDate.rbD1Only
[panel]Контрол rbD1Only формы Ten_DefineSearchDate[panel]
*Тип результата:* TvtRadioButton
*Пример:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_DefineSearchDate .Ten_DefineSearchDate.rbD1Only >>> l_TvtRadioButton
[code]  }
  private
   function rbD1Only(const aCtx: TtfwContext;
    aen_DefineSearchDate: Ten_DefineSearchDate): TvtRadioButton;
    {* Реализация слова скрипта .Ten_DefineSearchDate.rbD1Only }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnDefineSearchDateRbD1Only

 TkwEnDefineSearchDateDD2 = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_DefineSearchDate.dD2
[panel]Контрол dD2 формы Ten_DefineSearchDate[panel]
*Тип результата:* TvtDblClickDateEdit
*Пример:*
[code]
OBJECT VAR l_TvtDblClickDateEdit
 aen_DefineSearchDate .Ten_DefineSearchDate.dD2 >>> l_TvtDblClickDateEdit
[code]  }
  private
   function dD2(const aCtx: TtfwContext;
    aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
    {* Реализация слова скрипта .Ten_DefineSearchDate.dD2 }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnDefineSearchDateDD2

class function Tkw_Form_DefineSearchDate.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::DefineSearchDate';
end;//Tkw_Form_DefineSearchDate.GetWordNameForRegister

function Tkw_Form_DefineSearchDate.GetString: AnsiString;
begin
 Result := 'en_DefineSearchDate';
end;//Tkw_Form_DefineSearchDate.GetString

class function Tkw_DefineSearchDate_Control_Panel1.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Panel1';
end;//Tkw_DefineSearchDate_Control_Panel1.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_Panel1.GetString: AnsiString;
begin
 Result := 'Panel1';
end;//Tkw_DefineSearchDate_Control_Panel1.GetString

class procedure Tkw_DefineSearchDate_Control_Panel1.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_DefineSearchDate_Control_Panel1.RegisterInEngine

procedure Tkw_DefineSearchDate_Control_Panel1_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A509485B3049_var*
//#UC END# *4DAEEDE10285_A509485B3049_var*
begin
//#UC START# *4DAEEDE10285_A509485B3049_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A509485B3049_impl*
end;//Tkw_DefineSearchDate_Control_Panel1_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_Panel1_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Panel1:push';
end;//Tkw_DefineSearchDate_Control_Panel1_Push.GetWordNameForRegister

class function Tkw_DefineSearchDate_Control_ElLabel1.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ElLabel1';
end;//Tkw_DefineSearchDate_Control_ElLabel1.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_ElLabel1.GetString: AnsiString;
begin
 Result := 'ElLabel1';
end;//Tkw_DefineSearchDate_Control_ElLabel1.GetString

class procedure Tkw_DefineSearchDate_Control_ElLabel1.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_DefineSearchDate_Control_ElLabel1.RegisterInEngine

procedure Tkw_DefineSearchDate_Control_ElLabel1_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6137E3B10823_var*
//#UC END# *4DAEEDE10285_6137E3B10823_var*
begin
//#UC START# *4DAEEDE10285_6137E3B10823_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6137E3B10823_impl*
end;//Tkw_DefineSearchDate_Control_ElLabel1_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_ElLabel1_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ElLabel1:push';
end;//Tkw_DefineSearchDate_Control_ElLabel1_Push.GetWordNameForRegister

class function Tkw_DefineSearchDate_Control_ElLabel2.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ElLabel2';
end;//Tkw_DefineSearchDate_Control_ElLabel2.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_ElLabel2.GetString: AnsiString;
begin
 Result := 'ElLabel2';
end;//Tkw_DefineSearchDate_Control_ElLabel2.GetString

class procedure Tkw_DefineSearchDate_Control_ElLabel2.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_DefineSearchDate_Control_ElLabel2.RegisterInEngine

procedure Tkw_DefineSearchDate_Control_ElLabel2_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_61066262B557_var*
//#UC END# *4DAEEDE10285_61066262B557_var*
begin
//#UC START# *4DAEEDE10285_61066262B557_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_61066262B557_impl*
end;//Tkw_DefineSearchDate_Control_ElLabel2_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_ElLabel2_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ElLabel2:push';
end;//Tkw_DefineSearchDate_Control_ElLabel2_Push.GetWordNameForRegister

class function Tkw_DefineSearchDate_Control_ElLabel3.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ElLabel3';
end;//Tkw_DefineSearchDate_Control_ElLabel3.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_ElLabel3.GetString: AnsiString;
begin
 Result := 'ElLabel3';
end;//Tkw_DefineSearchDate_Control_ElLabel3.GetString

class procedure Tkw_DefineSearchDate_Control_ElLabel3.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_DefineSearchDate_Control_ElLabel3.RegisterInEngine

procedure Tkw_DefineSearchDate_Control_ElLabel3_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0B9E629060DA_var*
//#UC END# *4DAEEDE10285_0B9E629060DA_var*
begin
//#UC START# *4DAEEDE10285_0B9E629060DA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0B9E629060DA_impl*
end;//Tkw_DefineSearchDate_Control_ElLabel3_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_ElLabel3_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ElLabel3:push';
end;//Tkw_DefineSearchDate_Control_ElLabel3_Push.GetWordNameForRegister

class function Tkw_DefineSearchDate_Control_dD1EqD2.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::dD1EqD2';
end;//Tkw_DefineSearchDate_Control_dD1EqD2.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_dD1EqD2.GetString: AnsiString;
begin
 Result := 'dD1EqD2';
end;//Tkw_DefineSearchDate_Control_dD1EqD2.GetString

class procedure Tkw_DefineSearchDate_Control_dD1EqD2.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtDblClickDateEdit);
end;//Tkw_DefineSearchDate_Control_dD1EqD2.RegisterInEngine

procedure Tkw_DefineSearchDate_Control_dD1EqD2_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_11F270D3BC7F_var*
//#UC END# *4DAEEDE10285_11F270D3BC7F_var*
begin
//#UC START# *4DAEEDE10285_11F270D3BC7F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_11F270D3BC7F_impl*
end;//Tkw_DefineSearchDate_Control_dD1EqD2_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_dD1EqD2_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::dD1EqD2:push';
end;//Tkw_DefineSearchDate_Control_dD1EqD2_Push.GetWordNameForRegister

class function Tkw_DefineSearchDate_Control_rbEq.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rbEq';
end;//Tkw_DefineSearchDate_Control_rbEq.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_rbEq.GetString: AnsiString;
begin
 Result := 'rbEq';
end;//Tkw_DefineSearchDate_Control_rbEq.GetString

class procedure Tkw_DefineSearchDate_Control_rbEq.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_DefineSearchDate_Control_rbEq.RegisterInEngine

procedure Tkw_DefineSearchDate_Control_rbEq_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4389194AF7B2_var*
//#UC END# *4DAEEDE10285_4389194AF7B2_var*
begin
//#UC START# *4DAEEDE10285_4389194AF7B2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4389194AF7B2_impl*
end;//Tkw_DefineSearchDate_Control_rbEq_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_rbEq_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rbEq:push';
end;//Tkw_DefineSearchDate_Control_rbEq_Push.GetWordNameForRegister

class function Tkw_DefineSearchDate_Control_rbInt.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rbInt';
end;//Tkw_DefineSearchDate_Control_rbInt.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_rbInt.GetString: AnsiString;
begin
 Result := 'rbInt';
end;//Tkw_DefineSearchDate_Control_rbInt.GetString

class procedure Tkw_DefineSearchDate_Control_rbInt.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_DefineSearchDate_Control_rbInt.RegisterInEngine

procedure Tkw_DefineSearchDate_Control_rbInt_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_25A3E40B4FD7_var*
//#UC END# *4DAEEDE10285_25A3E40B4FD7_var*
begin
//#UC START# *4DAEEDE10285_25A3E40B4FD7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_25A3E40B4FD7_impl*
end;//Tkw_DefineSearchDate_Control_rbInt_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_rbInt_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rbInt:push';
end;//Tkw_DefineSearchDate_Control_rbInt_Push.GetWordNameForRegister

class function Tkw_DefineSearchDate_Control_rbD2Only.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rbD2Only';
end;//Tkw_DefineSearchDate_Control_rbD2Only.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_rbD2Only.GetString: AnsiString;
begin
 Result := 'rbD2Only';
end;//Tkw_DefineSearchDate_Control_rbD2Only.GetString

class procedure Tkw_DefineSearchDate_Control_rbD2Only.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_DefineSearchDate_Control_rbD2Only.RegisterInEngine

procedure Tkw_DefineSearchDate_Control_rbD2Only_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7789E33A7A3E_var*
//#UC END# *4DAEEDE10285_7789E33A7A3E_var*
begin
//#UC START# *4DAEEDE10285_7789E33A7A3E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7789E33A7A3E_impl*
end;//Tkw_DefineSearchDate_Control_rbD2Only_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_rbD2Only_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rbD2Only:push';
end;//Tkw_DefineSearchDate_Control_rbD2Only_Push.GetWordNameForRegister

class function Tkw_DefineSearchDate_Control_dD1Only.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::dD1Only';
end;//Tkw_DefineSearchDate_Control_dD1Only.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_dD1Only.GetString: AnsiString;
begin
 Result := 'dD1Only';
end;//Tkw_DefineSearchDate_Control_dD1Only.GetString

class procedure Tkw_DefineSearchDate_Control_dD1Only.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtDblClickDateEdit);
end;//Tkw_DefineSearchDate_Control_dD1Only.RegisterInEngine

procedure Tkw_DefineSearchDate_Control_dD1Only_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_97CB6EE725F2_var*
//#UC END# *4DAEEDE10285_97CB6EE725F2_var*
begin
//#UC START# *4DAEEDE10285_97CB6EE725F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_97CB6EE725F2_impl*
end;//Tkw_DefineSearchDate_Control_dD1Only_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_dD1Only_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::dD1Only:push';
end;//Tkw_DefineSearchDate_Control_dD1Only_Push.GetWordNameForRegister

class function Tkw_DefineSearchDate_Control_dD2Only.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::dD2Only';
end;//Tkw_DefineSearchDate_Control_dD2Only.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_dD2Only.GetString: AnsiString;
begin
 Result := 'dD2Only';
end;//Tkw_DefineSearchDate_Control_dD2Only.GetString

class procedure Tkw_DefineSearchDate_Control_dD2Only.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtDblClickDateEdit);
end;//Tkw_DefineSearchDate_Control_dD2Only.RegisterInEngine

procedure Tkw_DefineSearchDate_Control_dD2Only_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_83BD94DA746B_var*
//#UC END# *4DAEEDE10285_83BD94DA746B_var*
begin
//#UC START# *4DAEEDE10285_83BD94DA746B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_83BD94DA746B_impl*
end;//Tkw_DefineSearchDate_Control_dD2Only_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_dD2Only_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::dD2Only:push';
end;//Tkw_DefineSearchDate_Control_dD2Only_Push.GetWordNameForRegister

class function Tkw_DefineSearchDate_Control_dD1.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::dD1';
end;//Tkw_DefineSearchDate_Control_dD1.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_dD1.GetString: AnsiString;
begin
 Result := 'dD1';
end;//Tkw_DefineSearchDate_Control_dD1.GetString

class procedure Tkw_DefineSearchDate_Control_dD1.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtDblClickDateEdit);
end;//Tkw_DefineSearchDate_Control_dD1.RegisterInEngine

procedure Tkw_DefineSearchDate_Control_dD1_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3DF444DAA12A_var*
//#UC END# *4DAEEDE10285_3DF444DAA12A_var*
begin
//#UC START# *4DAEEDE10285_3DF444DAA12A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3DF444DAA12A_impl*
end;//Tkw_DefineSearchDate_Control_dD1_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_dD1_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::dD1:push';
end;//Tkw_DefineSearchDate_Control_dD1_Push.GetWordNameForRegister

class function Tkw_DefineSearchDate_Control_rbD1Only.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rbD1Only';
end;//Tkw_DefineSearchDate_Control_rbD1Only.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_rbD1Only.GetString: AnsiString;
begin
 Result := 'rbD1Only';
end;//Tkw_DefineSearchDate_Control_rbD1Only.GetString

class procedure Tkw_DefineSearchDate_Control_rbD1Only.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_DefineSearchDate_Control_rbD1Only.RegisterInEngine

procedure Tkw_DefineSearchDate_Control_rbD1Only_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_77C7EA25878D_var*
//#UC END# *4DAEEDE10285_77C7EA25878D_var*
begin
//#UC START# *4DAEEDE10285_77C7EA25878D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_77C7EA25878D_impl*
end;//Tkw_DefineSearchDate_Control_rbD1Only_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_rbD1Only_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rbD1Only:push';
end;//Tkw_DefineSearchDate_Control_rbD1Only_Push.GetWordNameForRegister

class function Tkw_DefineSearchDate_Control_dD2.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::dD2';
end;//Tkw_DefineSearchDate_Control_dD2.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_dD2.GetString: AnsiString;
begin
 Result := 'dD2';
end;//Tkw_DefineSearchDate_Control_dD2.GetString

class procedure Tkw_DefineSearchDate_Control_dD2.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtDblClickDateEdit);
end;//Tkw_DefineSearchDate_Control_dD2.RegisterInEngine

procedure Tkw_DefineSearchDate_Control_dD2_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D3900DCEB73F_var*
//#UC END# *4DAEEDE10285_D3900DCEB73F_var*
begin
//#UC START# *4DAEEDE10285_D3900DCEB73F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D3900DCEB73F_impl*
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

class function TkwEnDefineSearchDatePanel1.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_DefineSearchDate.Panel1';
end;//TkwEnDefineSearchDatePanel1.GetWordNameForRegister

procedure TkwEnDefineSearchDatePanel1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Panel1', aCtx);
end;//TkwEnDefineSearchDatePanel1.SetValuePrim

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

function TkwEnDefineSearchDateElLabel1.ElLabel1(const aCtx: TtfwContext;
 aen_DefineSearchDate: Ten_DefineSearchDate): TvtLabel;
 {* Реализация слова скрипта .Ten_DefineSearchDate.ElLabel1 }
begin
 Result := aen_DefineSearchDate.ElLabel1;
end;//TkwEnDefineSearchDateElLabel1.ElLabel1

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

class function TkwEnDefineSearchDateElLabel1.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_DefineSearchDate.ElLabel1';
end;//TkwEnDefineSearchDateElLabel1.GetWordNameForRegister

procedure TkwEnDefineSearchDateElLabel1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ElLabel1', aCtx);
end;//TkwEnDefineSearchDateElLabel1.SetValuePrim

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

function TkwEnDefineSearchDateElLabel2.ElLabel2(const aCtx: TtfwContext;
 aen_DefineSearchDate: Ten_DefineSearchDate): TvtLabel;
 {* Реализация слова скрипта .Ten_DefineSearchDate.ElLabel2 }
begin
 Result := aen_DefineSearchDate.ElLabel2;
end;//TkwEnDefineSearchDateElLabel2.ElLabel2

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

class function TkwEnDefineSearchDateElLabel2.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_DefineSearchDate.ElLabel2';
end;//TkwEnDefineSearchDateElLabel2.GetWordNameForRegister

procedure TkwEnDefineSearchDateElLabel2.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ElLabel2', aCtx);
end;//TkwEnDefineSearchDateElLabel2.SetValuePrim

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

function TkwEnDefineSearchDateElLabel3.ElLabel3(const aCtx: TtfwContext;
 aen_DefineSearchDate: Ten_DefineSearchDate): TvtLabel;
 {* Реализация слова скрипта .Ten_DefineSearchDate.ElLabel3 }
begin
 Result := aen_DefineSearchDate.ElLabel3;
end;//TkwEnDefineSearchDateElLabel3.ElLabel3

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

class function TkwEnDefineSearchDateElLabel3.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_DefineSearchDate.ElLabel3';
end;//TkwEnDefineSearchDateElLabel3.GetWordNameForRegister

procedure TkwEnDefineSearchDateElLabel3.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ElLabel3', aCtx);
end;//TkwEnDefineSearchDateElLabel3.SetValuePrim

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

function TkwEnDefineSearchDateDD1EqD2.dD1EqD2(const aCtx: TtfwContext;
 aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
 {* Реализация слова скрипта .Ten_DefineSearchDate.dD1EqD2 }
begin
 Result := aen_DefineSearchDate.dD1EqD2;
end;//TkwEnDefineSearchDateDD1EqD2.dD1EqD2

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

class function TkwEnDefineSearchDateDD1EqD2.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_DefineSearchDate.dD1EqD2';
end;//TkwEnDefineSearchDateDD1EqD2.GetWordNameForRegister

procedure TkwEnDefineSearchDateDD1EqD2.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству dD1EqD2', aCtx);
end;//TkwEnDefineSearchDateDD1EqD2.SetValuePrim

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

function TkwEnDefineSearchDateRbEq.rbEq(const aCtx: TtfwContext;
 aen_DefineSearchDate: Ten_DefineSearchDate): TvtRadioButton;
 {* Реализация слова скрипта .Ten_DefineSearchDate.rbEq }
begin
 Result := aen_DefineSearchDate.rbEq;
end;//TkwEnDefineSearchDateRbEq.rbEq

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

class function TkwEnDefineSearchDateRbEq.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_DefineSearchDate.rbEq';
end;//TkwEnDefineSearchDateRbEq.GetWordNameForRegister

procedure TkwEnDefineSearchDateRbEq.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству rbEq', aCtx);
end;//TkwEnDefineSearchDateRbEq.SetValuePrim

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

function TkwEnDefineSearchDateRbInt.rbInt(const aCtx: TtfwContext;
 aen_DefineSearchDate: Ten_DefineSearchDate): TvtRadioButton;
 {* Реализация слова скрипта .Ten_DefineSearchDate.rbInt }
begin
 Result := aen_DefineSearchDate.rbInt;
end;//TkwEnDefineSearchDateRbInt.rbInt

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

class function TkwEnDefineSearchDateRbInt.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_DefineSearchDate.rbInt';
end;//TkwEnDefineSearchDateRbInt.GetWordNameForRegister

procedure TkwEnDefineSearchDateRbInt.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству rbInt', aCtx);
end;//TkwEnDefineSearchDateRbInt.SetValuePrim

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

function TkwEnDefineSearchDateRbD2Only.rbD2Only(const aCtx: TtfwContext;
 aen_DefineSearchDate: Ten_DefineSearchDate): TvtRadioButton;
 {* Реализация слова скрипта .Ten_DefineSearchDate.rbD2Only }
begin
 Result := aen_DefineSearchDate.rbD2Only;
end;//TkwEnDefineSearchDateRbD2Only.rbD2Only

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

class function TkwEnDefineSearchDateRbD2Only.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_DefineSearchDate.rbD2Only';
end;//TkwEnDefineSearchDateRbD2Only.GetWordNameForRegister

procedure TkwEnDefineSearchDateRbD2Only.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству rbD2Only', aCtx);
end;//TkwEnDefineSearchDateRbD2Only.SetValuePrim

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

function TkwEnDefineSearchDateDD1Only.dD1Only(const aCtx: TtfwContext;
 aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
 {* Реализация слова скрипта .Ten_DefineSearchDate.dD1Only }
begin
 Result := aen_DefineSearchDate.dD1Only;
end;//TkwEnDefineSearchDateDD1Only.dD1Only

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

class function TkwEnDefineSearchDateDD1Only.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_DefineSearchDate.dD1Only';
end;//TkwEnDefineSearchDateDD1Only.GetWordNameForRegister

procedure TkwEnDefineSearchDateDD1Only.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству dD1Only', aCtx);
end;//TkwEnDefineSearchDateDD1Only.SetValuePrim

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

function TkwEnDefineSearchDateDD2Only.dD2Only(const aCtx: TtfwContext;
 aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
 {* Реализация слова скрипта .Ten_DefineSearchDate.dD2Only }
begin
 Result := aen_DefineSearchDate.dD2Only;
end;//TkwEnDefineSearchDateDD2Only.dD2Only

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

class function TkwEnDefineSearchDateDD2Only.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_DefineSearchDate.dD2Only';
end;//TkwEnDefineSearchDateDD2Only.GetWordNameForRegister

procedure TkwEnDefineSearchDateDD2Only.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству dD2Only', aCtx);
end;//TkwEnDefineSearchDateDD2Only.SetValuePrim

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

function TkwEnDefineSearchDateDD1.dD1(const aCtx: TtfwContext;
 aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
 {* Реализация слова скрипта .Ten_DefineSearchDate.dD1 }
begin
 Result := aen_DefineSearchDate.dD1;
end;//TkwEnDefineSearchDateDD1.dD1

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

class function TkwEnDefineSearchDateDD1.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_DefineSearchDate.dD1';
end;//TkwEnDefineSearchDateDD1.GetWordNameForRegister

procedure TkwEnDefineSearchDateDD1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству dD1', aCtx);
end;//TkwEnDefineSearchDateDD1.SetValuePrim

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

function TkwEnDefineSearchDateRbD1Only.rbD1Only(const aCtx: TtfwContext;
 aen_DefineSearchDate: Ten_DefineSearchDate): TvtRadioButton;
 {* Реализация слова скрипта .Ten_DefineSearchDate.rbD1Only }
begin
 Result := aen_DefineSearchDate.rbD1Only;
end;//TkwEnDefineSearchDateRbD1Only.rbD1Only

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

class function TkwEnDefineSearchDateRbD1Only.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_DefineSearchDate.rbD1Only';
end;//TkwEnDefineSearchDateRbD1Only.GetWordNameForRegister

procedure TkwEnDefineSearchDateRbD1Only.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству rbD1Only', aCtx);
end;//TkwEnDefineSearchDateRbD1Only.SetValuePrim

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

function TkwEnDefineSearchDateDD2.dD2(const aCtx: TtfwContext;
 aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
 {* Реализация слова скрипта .Ten_DefineSearchDate.dD2 }
begin
 Result := aen_DefineSearchDate.dD2;
end;//TkwEnDefineSearchDateDD2.dD2

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

class function TkwEnDefineSearchDateDD2.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_DefineSearchDate.dD2';
end;//TkwEnDefineSearchDateDD2.GetWordNameForRegister

procedure TkwEnDefineSearchDateDD2.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству dD2', aCtx);
end;//TkwEnDefineSearchDateDD2.SetValuePrim

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
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_DefineSearchDate));
 {* Регистрация типа DefineSearchDate }
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
