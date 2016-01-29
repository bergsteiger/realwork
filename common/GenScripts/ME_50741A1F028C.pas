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
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//TFormsProcessingPackResNameGetter
 
 TkwPopFormActiveMDIChild = class(TtfwClassLike)
  {* ����� ������� pop:form:ActiveMDIChild
*��� ����������:* TForm
*������:*
[code]
OBJECT VAR l_TForm
 aForm pop:form:ActiveMDIChild >>> l_TForm
[code]  }
  function pop_form_ActiveMDIChild(const aCtx: TtfwContext;
   aForm: TForm): TForm;
   {* ���������� ����� ������� pop:form:ActiveMDIChild }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormActiveMDIChild
 
 TkwPopFormClose = class(TtfwClassLike)
  {* ����� ������� pop:form:Close
*������:*
[code]
 aForm pop:form:Close
[code]  }
  procedure pop_form_Close(const aCtx: TtfwContext;
   aForm: TForm);
   {* ���������� ����� ������� pop:form:Close }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormClose
 
 TkwPopFormFindMenuItem = class(TtfwClassLike)
  {* ����� ������� pop:form:FindMenuItem
*��� ����������:* TMenuItem
*������:*
[code]
OBJECT VAR l_TMenuItem
 aName aForm pop:form:FindMenuItem >>> l_TMenuItem
[code]  }
  function pop_form_FindMenuItem(const aCtx: TtfwContext;
   aForm: TForm;
   const aName: AnsiString): TMenuItem;
   {* ���������� ����� ������� pop:form:FindMenuItem }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormFindMenuItem
 
 TkwPopFormGetWindowState = class(TtfwClassLike)
  {* ����� ������� pop:form:GetWindowState
*��� ����������:* TWindowState
*������:*
[code]
TWindowState VAR l_TWindowState
 aForm pop:form:GetWindowState >>> l_TWindowState
[code]  }
  function pop_form_GetWindowState(const aCtx: TtfwContext;
   aForm: TForm): TWindowState;
   {* ���������� ����� ������� pop:form:GetWindowState }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormGetWindowState
 
 TkwPopFormHasControl = class(TtfwClassLike)
  {* ����� ������� pop:form:HasControl
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aName aForm pop:form:HasControl >>> l_Boolean
[code]  }
  function pop_form_HasControl(const aCtx: TtfwContext;
   aForm: TForm;
   const aName: AnsiString): Boolean;
   {* ���������� ����� ������� pop:form:HasControl }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormHasControl
 
 TkwPopFormMDIChildCount = class(TtfwClassLike)
  {* ����� ������� pop:form:MDIChildCount
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aForm pop:form:MDIChildCount >>> l_Integer
[code]  }
  function pop_form_MDIChildCount(const aCtx: TtfwContext;
   aForm: TForm): Integer;
   {* ���������� ����� ������� pop:form:MDIChildCount }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormMDIChildCount
 
 TkwPopFormMDIChildren = class(TtfwClassLike)
  {* ����� ������� pop:form:MDIChildren
*��� ����������:* TForm
*������:*
[code]
OBJECT VAR l_TForm
 anIndex aForm pop:form:MDIChildren >>> l_TForm
[code]  }
  function pop_form_MDIChildren(const aCtx: TtfwContext;
   aForm: TForm;
   anIndex: Integer): TForm;
   {* ���������� ����� ������� pop:form:MDIChildren }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormMDIChildren
 
 TkwPopFormModalResult = class(TtfwClassLike)
  {* ����� ������� pop:form:ModalResult
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aForm pop:form:ModalResult >>> l_Integer
[code]  }
  function pop_form_ModalResult(const aCtx: TtfwContext;
   aForm: TForm): Integer;
   {* ���������� ����� ������� pop:form:ModalResult }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormModalResult
 
 TkwPopFormNext = class(TtfwClassLike)
  {* ����� ������� pop:form:Next
*������:*
[code]
 aForm pop:form:Next
[code]  }
  procedure pop_form_Next(const aCtx: TtfwContext;
   aForm: TForm);
   {* ���������� ����� ������� pop:form:Next }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormNext
 
 TkwPopFormSetWindowState = class(TtfwClassLike)
  {* ����� ������� pop:form:SetWindowState
*������:*
[code]
 aValue aForm pop:form:SetWindowState
[code]  }
  procedure pop_form_SetWindowState(const aCtx: TtfwContext;
   aForm: TForm;
   aValue: TWindowState);
   {* ���������� ����� ������� pop:form:SetWindowState }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormSetWindowState
 
 TkwPopFormFindActionList = class(TtfwClassLike)
  {* ����� ������� pop:form:FindActionList
*��� ����������:* TActionList
*������:*
[code]
OBJECT VAR l_TActionList
 aListName aForm pop:form:FindActionList >>> l_TActionList
[code]  }
  function pop_form_FindActionList(const aCtx: TtfwContext;
   aForm: TForm;
   const aListName: AnsiString): TActionList;
   {* ���������� ����� ������� pop:form:FindActionList }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormFindActionList
 
 TkwIterateForms = class(TtfwGlobalKeyWord)
  {* ����� ������� IterateForms
*������:*
[code]
 aLambda IterateForms
[code]  }
  procedure IterateForms(const aCtx: TtfwContext;
   aLambda: TtfwWord);
   {* ���������� ����� ������� IterateForms }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIterateForms
 
end.
