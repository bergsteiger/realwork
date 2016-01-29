unit FormsProcessingPack;

interface

uses
 l3IntfUses
 , Forms
 , Menus
 , ActnList
 , tfwScriptingInterfaces
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , TypInfo
 , tfwGlobalKeyWord
;

implementation

uses
 l3ImplUses
 , l3ObjectList
 , Classes
 , CustomFormProcessingPack
 , Controls
 , ActionListWordsPack
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TFormsProcessingPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TFormsProcessingPackResNameGetter
 
 TkwPopFormActiveMDIChild = class(TtfwClassLike)
  {* Слово скрипта pop:form:ActiveMDIChild
*Тип результата:* TForm
*Пример:*
[code]
OBJECT VAR l_TForm
 aForm pop:form:ActiveMDIChild >>> l_TForm
[code]  }
  function pop_form_ActiveMDIChild(const aCtx: TtfwContext;
   aForm: TForm): TForm;
   {* Реализация слова скрипта pop:form:ActiveMDIChild }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormActiveMDIChild
 
 TkwPopFormClose = class(TtfwClassLike)
  {* Слово скрипта pop:form:Close
*Пример:*
[code]
 aForm pop:form:Close
[code]  }
  procedure pop_form_Close(const aCtx: TtfwContext;
   aForm: TForm);
   {* Реализация слова скрипта pop:form:Close }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormClose
 
 TkwPopFormFindMenuItem = class(TtfwClassLike)
  {* Слово скрипта pop:form:FindMenuItem
*Тип результата:* TMenuItem
*Пример:*
[code]
OBJECT VAR l_TMenuItem
 aName aForm pop:form:FindMenuItem >>> l_TMenuItem
[code]  }
  function pop_form_FindMenuItem(const aCtx: TtfwContext;
   aForm: TForm;
   const aName: AnsiString): TMenuItem;
   {* Реализация слова скрипта pop:form:FindMenuItem }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormFindMenuItem
 
 TkwPopFormGetWindowState = class(TtfwClassLike)
  {* Слово скрипта pop:form:GetWindowState
*Тип результата:* TWindowState
*Пример:*
[code]
TWindowState VAR l_TWindowState
 aForm pop:form:GetWindowState >>> l_TWindowState
[code]  }
  function pop_form_GetWindowState(const aCtx: TtfwContext;
   aForm: TForm): TWindowState;
   {* Реализация слова скрипта pop:form:GetWindowState }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormGetWindowState
 
 TkwPopFormHasControl = class(TtfwClassLike)
  {* Слово скрипта pop:form:HasControl
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aName aForm pop:form:HasControl >>> l_Boolean
[code]  }
  function pop_form_HasControl(const aCtx: TtfwContext;
   aForm: TForm;
   const aName: AnsiString): Boolean;
   {* Реализация слова скрипта pop:form:HasControl }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormHasControl
 
 TkwPopFormMDIChildCount = class(TtfwClassLike)
  {* Слово скрипта pop:form:MDIChildCount
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aForm pop:form:MDIChildCount >>> l_Integer
[code]  }
  function pop_form_MDIChildCount(const aCtx: TtfwContext;
   aForm: TForm): Integer;
   {* Реализация слова скрипта pop:form:MDIChildCount }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormMDIChildCount
 
 TkwPopFormMDIChildren = class(TtfwClassLike)
  {* Слово скрипта pop:form:MDIChildren
*Тип результата:* TForm
*Пример:*
[code]
OBJECT VAR l_TForm
 anIndex aForm pop:form:MDIChildren >>> l_TForm
[code]  }
  function pop_form_MDIChildren(const aCtx: TtfwContext;
   aForm: TForm;
   anIndex: Integer): TForm;
   {* Реализация слова скрипта pop:form:MDIChildren }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormMDIChildren
 
 TkwPopFormModalResult = class(TtfwClassLike)
  {* Слово скрипта pop:form:ModalResult
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aForm pop:form:ModalResult >>> l_Integer
[code]  }
  function pop_form_ModalResult(const aCtx: TtfwContext;
   aForm: TForm): Integer;
   {* Реализация слова скрипта pop:form:ModalResult }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormModalResult
 
 TkwPopFormNext = class(TtfwClassLike)
  {* Слово скрипта pop:form:Next
*Пример:*
[code]
 aForm pop:form:Next
[code]  }
  procedure pop_form_Next(const aCtx: TtfwContext;
   aForm: TForm);
   {* Реализация слова скрипта pop:form:Next }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormNext
 
 TkwPopFormSetWindowState = class(TtfwClassLike)
  {* Слово скрипта pop:form:SetWindowState
*Пример:*
[code]
 aValue aForm pop:form:SetWindowState
[code]  }
  procedure pop_form_SetWindowState(const aCtx: TtfwContext;
   aForm: TForm;
   aValue: TWindowState);
   {* Реализация слова скрипта pop:form:SetWindowState }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormSetWindowState
 
 TkwPopFormFindActionList = class(TtfwClassLike)
  {* Слово скрипта pop:form:FindActionList
*Тип результата:* TActionList
*Пример:*
[code]
OBJECT VAR l_TActionList
 aListName aForm pop:form:FindActionList >>> l_TActionList
[code]  }
  function pop_form_FindActionList(const aCtx: TtfwContext;
   aForm: TForm;
   const aListName: AnsiString): TActionList;
   {* Реализация слова скрипта pop:form:FindActionList }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormFindActionList
 
 TkwIterateForms = class(TtfwGlobalKeyWord)
  {* Слово скрипта IterateForms
*Пример:*
[code]
 aLambda IterateForms
[code]  }
  procedure IterateForms(const aCtx: TtfwContext;
   aLambda: TtfwWord);
   {* Реализация слова скрипта IterateForms }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIterateForms
 
end.
