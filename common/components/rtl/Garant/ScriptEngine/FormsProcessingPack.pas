unit FormsProcessingPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\FormsProcessingPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "FormsProcessingPack" MUID: (50741A1F028C)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Forms
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , TypInfo
 , tfwClassLike
 , Menus
 , ActnList
 , tfwAxiomaticsResNameGetter
 , l3ObjectList
 , Classes
 , CustomFormProcessingPack
 , Controls
 , ActionListWordsPack
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *50741A1F028Cimpl_uses*
 //#UC END# *50741A1F028Cimpl_uses*
;

type
 TkwIterateForms = {final} class(TtfwGlobalKeyWord)
  {* ����� ������� IterateForms }
  private
   procedure IterateForms(const aCtx: TtfwContext;
    aLambda: TtfwWord);
    {* ���������� ����� ������� IterateForms }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIterateForms

 TkwPopFormActiveMDIChild = {final} class(TtfwClassLike)
  {* ����� ������� pop:form:ActiveMDIChild }
  private
   function pop_form_ActiveMDIChild(const aCtx: TtfwContext;
    aForm: TForm): TForm;
    {* ���������� ����� ������� pop:form:ActiveMDIChild }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormActiveMDIChild

 TkwPopFormClose = {final} class(TtfwClassLike)
  {* ����� ������� pop:form:Close }
  private
   procedure pop_form_Close(const aCtx: TtfwContext;
    aForm: TForm);
    {* ���������� ����� ������� pop:form:Close }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormClose

 TkwPopFormFindMenuItem = {final} class(TtfwClassLike)
  {* ����� ������� pop:form:FindMenuItem }
  private
   function pop_form_FindMenuItem(const aCtx: TtfwContext;
    aForm: TForm;
    const aName: AnsiString): TMenuItem;
    {* ���������� ����� ������� pop:form:FindMenuItem }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormFindMenuItem

 TkwPopFormGetWindowState = {final} class(TtfwClassLike)
  {* ����� ������� pop:form:GetWindowState }
  private
   function pop_form_GetWindowState(const aCtx: TtfwContext;
    aForm: TForm): TWindowState;
    {* ���������� ����� ������� pop:form:GetWindowState }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormGetWindowState

 TkwPopFormHasControl = {final} class(TtfwClassLike)
  {* ����� ������� pop:form:HasControl }
  private
   function pop_form_HasControl(const aCtx: TtfwContext;
    aForm: TForm;
    const aName: AnsiString): Boolean;
    {* ���������� ����� ������� pop:form:HasControl }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormHasControl

 TkwPopFormMDIChildCount = {final} class(TtfwClassLike)
  {* ����� ������� pop:form:MDIChildCount }
  private
   function pop_form_MDIChildCount(const aCtx: TtfwContext;
    aForm: TForm): Integer;
    {* ���������� ����� ������� pop:form:MDIChildCount }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormMDIChildCount

 TkwPopFormMDIChildren = {final} class(TtfwClassLike)
  {* ����� ������� pop:form:MDIChildren }
  private
   function pop_form_MDIChildren(const aCtx: TtfwContext;
    aForm: TForm;
    anIndex: Integer): TForm;
    {* ���������� ����� ������� pop:form:MDIChildren }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormMDIChildren

 TkwPopFormModalResult = {final} class(TtfwClassLike)
  {* ����� ������� pop:form:ModalResult }
  private
   function pop_form_ModalResult(const aCtx: TtfwContext;
    aForm: TForm): Integer;
    {* ���������� ����� ������� pop:form:ModalResult }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormModalResult

 TkwPopFormNext = {final} class(TtfwClassLike)
  {* ����� ������� pop:form:Next }
  private
   procedure pop_form_Next(const aCtx: TtfwContext;
    aForm: TForm);
    {* ���������� ����� ������� pop:form:Next }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormNext

 TkwPopFormSetWindowState = {final} class(TtfwClassLike)
  {* ����� ������� pop:form:SetWindowState }
  private
   procedure pop_form_SetWindowState(const aCtx: TtfwContext;
    aForm: TForm;
    aValue: TWindowState);
    {* ���������� ����� ������� pop:form:SetWindowState }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormSetWindowState

 TkwPopFormFindActionList = {final} class(TtfwClassLike)
  {* ����� ������� pop:form:FindActionList }
  private
   function pop_form_FindActionList(const aCtx: TtfwContext;
    aForm: TForm;
    const aListName: AnsiString): TActionList;
    {* ���������� ����� ������� pop:form:FindActionList }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormFindActionList

 TFormsProcessingPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  public
   class function ResName: AnsiString; override;
 end;//TFormsProcessingPackResNameGetter

procedure TkwIterateForms.IterateForms(const aCtx: TtfwContext;
 aLambda: TtfwWord);
 {* ���������� ����� ������� IterateForms }
//#UC START# *5532520C033E_5532520C033E_Word_var*
var
 l_Obj: TObject;
 I: Integer;
 l_FormsList: Tl3ObjectList;
//#UC END# *5532520C033E_5532520C033E_Word_var*
begin
//#UC START# *5532520C033E_5532520C033E_Word_impl*
 l_FormsList := Tl3ObjectList.Create;
 try
  for I := 0 to Screen.CustomFormCount - 1 do
   l_FormsList.Add(Screen.CustomForms[I]);

  for I := 0 to l_FormsList.Count - 1 do
  try
   aCtx.rEngine.PushObj(l_FormsList[I]);
   aLambda.DoIt(aCtx);
  except
   on EtfwBreakIterator do
    Exit;
  end;//try..except
 finally
  l_FormsList.Free;
 end;
//#UC END# *5532520C033E_5532520C033E_Word_impl*
end;//TkwIterateForms.IterateForms

class function TkwIterateForms.GetWordNameForRegister: AnsiString;
begin
 Result := 'IterateForms';
end;//TkwIterateForms.GetWordNameForRegister

function TkwIterateForms.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwIterateForms.GetResultTypeInfo

function TkwIterateForms.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwIterateForms.GetAllParamsCount

function TkwIterateForms.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwIterateForms.ParamsTypes

procedure TkwIterateForms.DoDoIt(const aCtx: TtfwContext);
var l_aLambda: TtfwWord;
begin
 try
  l_aLambda := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLambda: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 IterateForms(aCtx, l_aLambda);
end;//TkwIterateForms.DoDoIt

function TkwPopFormActiveMDIChild.pop_form_ActiveMDIChild(const aCtx: TtfwContext;
 aForm: TForm): TForm;
 {* ���������� ����� ������� pop:form:ActiveMDIChild }
//#UC START# *55324FF900D2_55324FF900D2_4952591E0263_Word_var*
//#UC END# *55324FF900D2_55324FF900D2_4952591E0263_Word_var*
begin
//#UC START# *55324FF900D2_55324FF900D2_4952591E0263_Word_impl*
 Result := aForm.ActiveMDIChild;
//#UC END# *55324FF900D2_55324FF900D2_4952591E0263_Word_impl*
end;//TkwPopFormActiveMDIChild.pop_form_ActiveMDIChild

class function TkwPopFormActiveMDIChild.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:ActiveMDIChild';
end;//TkwPopFormActiveMDIChild.GetWordNameForRegister

function TkwPopFormActiveMDIChild.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TForm);
end;//TkwPopFormActiveMDIChild.GetResultTypeInfo

function TkwPopFormActiveMDIChild.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopFormActiveMDIChild.GetAllParamsCount

function TkwPopFormActiveMDIChild.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TForm)]);
end;//TkwPopFormActiveMDIChild.ParamsTypes

procedure TkwPopFormActiveMDIChild.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TForm;
begin
 try
  l_aForm := TForm(aCtx.rEngine.PopObjAs(TForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aForm: TForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pop_form_ActiveMDIChild(aCtx, l_aForm));
end;//TkwPopFormActiveMDIChild.DoDoIt

procedure TkwPopFormClose.pop_form_Close(const aCtx: TtfwContext;
 aForm: TForm);
 {* ���������� ����� ������� pop:form:Close }
//#UC START# *5532502900D6_5532502900D6_4952591E0263_Word_var*
//#UC END# *5532502900D6_5532502900D6_4952591E0263_Word_var*
begin
//#UC START# *5532502900D6_5532502900D6_4952591E0263_Word_impl*
 aForm.Close;
//#UC END# *5532502900D6_5532502900D6_4952591E0263_Word_impl*
end;//TkwPopFormClose.pop_form_Close

class function TkwPopFormClose.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:Close';
end;//TkwPopFormClose.GetWordNameForRegister

function TkwPopFormClose.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopFormClose.GetResultTypeInfo

function TkwPopFormClose.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopFormClose.GetAllParamsCount

function TkwPopFormClose.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TForm)]);
end;//TkwPopFormClose.ParamsTypes

procedure TkwPopFormClose.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TForm;
begin
 try
  l_aForm := TForm(aCtx.rEngine.PopObjAs(TForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aForm: TForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 pop_form_Close(aCtx, l_aForm);
end;//TkwPopFormClose.DoDoIt

function TkwPopFormFindMenuItem.pop_form_FindMenuItem(const aCtx: TtfwContext;
 aForm: TForm;
 const aName: AnsiString): TMenuItem;
 {* ���������� ����� ������� pop:form:FindMenuItem }
//#UC START# *5532506100DC_5532506100DC_4952591E0263_Word_var*
const
 cDelimiter = '/';

 function FindMainMenu(aComponent: TComponent): TMainMenu;
 var
  I: Integer;
 begin
  Result := nil;
  for I := 0 to aComponent.ComponentCount - 1 do
   if aComponent.Components[I] is TMainMenu then
   begin
    Result := aComponent.Components[I] as TMainMenu;
    Exit;
   end;    
  for I := 0 to aComponent.ComponentCount - 1 do
  begin
   Result := FindMainMenu(aComponent.Components[I]);
   if Assigned(Result) then
    Exit;
  end;
 end;

 function GetNextItem(var anItem: TMenuItem; var aPath: AnsiString): Boolean;
 var
  I: Integer;
  l_DelimiterIndex: Integer;
  l_Name: AnsiString;
  l_FindItem: TMenuItem;
 begin
  l_DelimiterIndex := Pos(cDelimiter, aPath);
  if l_DelimiterIndex = 0 then
   l_Name := aPath
  else
  begin
   l_Name := Copy(aPath, 1, l_DelimiterIndex - 1);
   aPath := Copy(aPath, l_DelimiterIndex + 1, MaxInt);
  end;
  l_FindItem := anItem.Find(l_Name);
  Result := Assigned(l_FindItem);
  if Result then
   anItem := l_FindItem;
 end;
               
var
 l_Path: AnsiString;
 l_Menu: TMainMenu;
 l_Item: TMenuItem;
//#UC END# *5532506100DC_5532506100DC_4952591E0263_Word_var*
begin
//#UC START# *5532506100DC_5532506100DC_4952591E0263_Word_impl*
 l_Menu := FindMainMenu(aForm);
 RunnerAssert(Assigned(l_Menu), '�� ����� ��� ����', aCtx);
 {$IfDef l3HackedVCL}
 l_Menu.Items.CallInitiateActions;
 {$EndIf l3HackedVCL}
 l_Menu.Items.RethinkHotkeys;
 l_Menu.Items.RethinkLines;
 l_Path := aName;
 l_Item := l_Menu.Items;
 {$IfDef l3HackedVCL}
 while GetNextItem(l_Item, l_Path) do
  l_Item.CallInitiateActions;
 {$EndIf l3HackedVCL}
 l_Item.RethinkHotkeys;
 l_Item.RethinkLines;
 Result := l_Item;
//#UC END# *5532506100DC_5532506100DC_4952591E0263_Word_impl*
end;//TkwPopFormFindMenuItem.pop_form_FindMenuItem

class function TkwPopFormFindMenuItem.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:FindMenuItem';
end;//TkwPopFormFindMenuItem.GetWordNameForRegister

function TkwPopFormFindMenuItem.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TMenuItem);
end;//TkwPopFormFindMenuItem.GetResultTypeInfo

function TkwPopFormFindMenuItem.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopFormFindMenuItem.GetAllParamsCount

function TkwPopFormFindMenuItem.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TForm), @tfw_tiString]);
end;//TkwPopFormFindMenuItem.ParamsTypes

procedure TkwPopFormFindMenuItem.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TForm;
var l_aName: AnsiString;
begin
 try
  l_aForm := TForm(aCtx.rEngine.PopObjAs(TForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aForm: TForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pop_form_FindMenuItem(aCtx, l_aForm, l_aName));
end;//TkwPopFormFindMenuItem.DoDoIt

function TkwPopFormGetWindowState.pop_form_GetWindowState(const aCtx: TtfwContext;
 aForm: TForm): TWindowState;
 {* ���������� ����� ������� pop:form:GetWindowState }
//#UC START# *55325098003C_55325098003C_4952591E0263_Word_var*
//#UC END# *55325098003C_55325098003C_4952591E0263_Word_var*
begin
//#UC START# *55325098003C_55325098003C_4952591E0263_Word_impl*
 Result := aForm.WindowState;
//#UC END# *55325098003C_55325098003C_4952591E0263_Word_impl*
end;//TkwPopFormGetWindowState.pop_form_GetWindowState

class function TkwPopFormGetWindowState.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:GetWindowState';
end;//TkwPopFormGetWindowState.GetWordNameForRegister

function TkwPopFormGetWindowState.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TWindowState);
end;//TkwPopFormGetWindowState.GetResultTypeInfo

function TkwPopFormGetWindowState.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopFormGetWindowState.GetAllParamsCount

function TkwPopFormGetWindowState.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TForm)]);
end;//TkwPopFormGetWindowState.ParamsTypes

procedure TkwPopFormGetWindowState.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TForm;
begin
 try
  l_aForm := TForm(aCtx.rEngine.PopObjAs(TForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aForm: TForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Ord(pop_form_GetWindowState(aCtx, l_aForm)));
end;//TkwPopFormGetWindowState.DoDoIt

function TkwPopFormHasControl.pop_form_HasControl(const aCtx: TtfwContext;
 aForm: TForm;
 const aName: AnsiString): Boolean;
 {* ���������� ����� ������� pop:form:HasControl }
//#UC START# *553250E10218_553250E10218_4952591E0263_Word_var*
//#UC END# *553250E10218_553250E10218_4952591E0263_Word_var*
begin
//#UC START# *553250E10218_553250E10218_4952591E0263_Word_impl*
 Result := (aForm.FindChildControl(aName) <> nil);
//#UC END# *553250E10218_553250E10218_4952591E0263_Word_impl*
end;//TkwPopFormHasControl.pop_form_HasControl

class function TkwPopFormHasControl.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:HasControl';
end;//TkwPopFormHasControl.GetWordNameForRegister

function TkwPopFormHasControl.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopFormHasControl.GetResultTypeInfo

function TkwPopFormHasControl.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopFormHasControl.GetAllParamsCount

function TkwPopFormHasControl.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TForm), @tfw_tiString]);
end;//TkwPopFormHasControl.ParamsTypes

procedure TkwPopFormHasControl.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TForm;
var l_aName: AnsiString;
begin
 try
  l_aForm := TForm(aCtx.rEngine.PopObjAs(TForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aForm: TForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(pop_form_HasControl(aCtx, l_aForm, l_aName));
end;//TkwPopFormHasControl.DoDoIt

function TkwPopFormMDIChildCount.pop_form_MDIChildCount(const aCtx: TtfwContext;
 aForm: TForm): Integer;
 {* ���������� ����� ������� pop:form:MDIChildCount }
//#UC START# *553251110023_553251110023_4952591E0263_Word_var*
//#UC END# *553251110023_553251110023_4952591E0263_Word_var*
begin
//#UC START# *553251110023_553251110023_4952591E0263_Word_impl*
 Result := aForm.MDIChildCount;
//#UC END# *553251110023_553251110023_4952591E0263_Word_impl*
end;//TkwPopFormMDIChildCount.pop_form_MDIChildCount

class function TkwPopFormMDIChildCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:MDIChildCount';
end;//TkwPopFormMDIChildCount.GetWordNameForRegister

function TkwPopFormMDIChildCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopFormMDIChildCount.GetResultTypeInfo

function TkwPopFormMDIChildCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopFormMDIChildCount.GetAllParamsCount

function TkwPopFormMDIChildCount.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TForm)]);
end;//TkwPopFormMDIChildCount.ParamsTypes

procedure TkwPopFormMDIChildCount.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TForm;
begin
 try
  l_aForm := TForm(aCtx.rEngine.PopObjAs(TForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aForm: TForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(pop_form_MDIChildCount(aCtx, l_aForm));
end;//TkwPopFormMDIChildCount.DoDoIt

function TkwPopFormMDIChildren.pop_form_MDIChildren(const aCtx: TtfwContext;
 aForm: TForm;
 anIndex: Integer): TForm;
 {* ���������� ����� ������� pop:form:MDIChildren }
//#UC START# *5532513202C9_5532513202C9_4952591E0263_Word_var*
//#UC END# *5532513202C9_5532513202C9_4952591E0263_Word_var*
begin
//#UC START# *5532513202C9_5532513202C9_4952591E0263_Word_impl*
 Result := aForm.MDIChildren[anIndex];
//#UC END# *5532513202C9_5532513202C9_4952591E0263_Word_impl*
end;//TkwPopFormMDIChildren.pop_form_MDIChildren

class function TkwPopFormMDIChildren.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:MDIChildren';
end;//TkwPopFormMDIChildren.GetWordNameForRegister

function TkwPopFormMDIChildren.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TForm);
end;//TkwPopFormMDIChildren.GetResultTypeInfo

function TkwPopFormMDIChildren.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopFormMDIChildren.GetAllParamsCount

function TkwPopFormMDIChildren.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TForm), TypeInfo(Integer)]);
end;//TkwPopFormMDIChildren.ParamsTypes

procedure TkwPopFormMDIChildren.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TForm;
var l_anIndex: Integer;
begin
 try
  l_aForm := TForm(aCtx.rEngine.PopObjAs(TForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aForm: TForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pop_form_MDIChildren(aCtx, l_aForm, l_anIndex));
end;//TkwPopFormMDIChildren.DoDoIt

function TkwPopFormModalResult.pop_form_ModalResult(const aCtx: TtfwContext;
 aForm: TForm): Integer;
 {* ���������� ����� ������� pop:form:ModalResult }
//#UC START# *5532516A0153_5532516A0153_4952591E0263_Word_var*
//#UC END# *5532516A0153_5532516A0153_4952591E0263_Word_var*
begin
//#UC START# *5532516A0153_5532516A0153_4952591E0263_Word_impl*
 RunnerAssert(fsModal in aForm.FormState, '��� �� ��������� �����!', aCtx);
 Result := aForm.ModalResult;
//#UC END# *5532516A0153_5532516A0153_4952591E0263_Word_impl*
end;//TkwPopFormModalResult.pop_form_ModalResult

class function TkwPopFormModalResult.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:ModalResult';
end;//TkwPopFormModalResult.GetWordNameForRegister

function TkwPopFormModalResult.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopFormModalResult.GetResultTypeInfo

function TkwPopFormModalResult.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopFormModalResult.GetAllParamsCount

function TkwPopFormModalResult.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TForm)]);
end;//TkwPopFormModalResult.ParamsTypes

procedure TkwPopFormModalResult.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TForm;
begin
 try
  l_aForm := TForm(aCtx.rEngine.PopObjAs(TForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aForm: TForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(pop_form_ModalResult(aCtx, l_aForm));
end;//TkwPopFormModalResult.DoDoIt

procedure TkwPopFormNext.pop_form_Next(const aCtx: TtfwContext;
 aForm: TForm);
 {* ���������� ����� ������� pop:form:Next }
//#UC START# *5532518700A2_5532518700A2_4952591E0263_Word_var*
//#UC END# *5532518700A2_5532518700A2_4952591E0263_Word_var*
begin
//#UC START# *5532518700A2_5532518700A2_4952591E0263_Word_impl*
 aForm.Next;
//#UC END# *5532518700A2_5532518700A2_4952591E0263_Word_impl*
end;//TkwPopFormNext.pop_form_Next

class function TkwPopFormNext.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:Next';
end;//TkwPopFormNext.GetWordNameForRegister

function TkwPopFormNext.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopFormNext.GetResultTypeInfo

function TkwPopFormNext.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopFormNext.GetAllParamsCount

function TkwPopFormNext.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TForm)]);
end;//TkwPopFormNext.ParamsTypes

procedure TkwPopFormNext.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TForm;
begin
 try
  l_aForm := TForm(aCtx.rEngine.PopObjAs(TForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aForm: TForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 pop_form_Next(aCtx, l_aForm);
end;//TkwPopFormNext.DoDoIt

procedure TkwPopFormSetWindowState.pop_form_SetWindowState(const aCtx: TtfwContext;
 aForm: TForm;
 aValue: TWindowState);
 {* ���������� ����� ������� pop:form:SetWindowState }
//#UC START# *553251B101E3_553251B101E3_4952591E0263_Word_var*
//#UC END# *553251B101E3_553251B101E3_4952591E0263_Word_var*
begin
//#UC START# *553251B101E3_553251B101E3_4952591E0263_Word_impl*
 aForm.WindowState := aValue;
//#UC END# *553251B101E3_553251B101E3_4952591E0263_Word_impl*
end;//TkwPopFormSetWindowState.pop_form_SetWindowState

class function TkwPopFormSetWindowState.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:SetWindowState';
end;//TkwPopFormSetWindowState.GetWordNameForRegister

function TkwPopFormSetWindowState.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopFormSetWindowState.GetResultTypeInfo

function TkwPopFormSetWindowState.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopFormSetWindowState.GetAllParamsCount

function TkwPopFormSetWindowState.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TForm), TypeInfo(TWindowState)]);
end;//TkwPopFormSetWindowState.ParamsTypes

procedure TkwPopFormSetWindowState.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TForm;
var l_aValue: TWindowState;
begin
 try
  l_aForm := TForm(aCtx.rEngine.PopObjAs(TForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aForm: TForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := TWindowState(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: TWindowState : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 pop_form_SetWindowState(aCtx, l_aForm, l_aValue);
end;//TkwPopFormSetWindowState.DoDoIt

function TkwPopFormFindActionList.pop_form_FindActionList(const aCtx: TtfwContext;
 aForm: TForm;
 const aListName: AnsiString): TActionList;
 {* ���������� ����� ������� pop:form:FindActionList }
//#UC START# *55B8E3B403B6_55B8E3B403B6_4952591E0263_Word_var*
var
 l_Component : TComponent;
 i : Integer;
 l_Control : TControl;
//#UC END# *55B8E3B403B6_55B8E3B403B6_4952591E0263_Word_var*
begin
//#UC START# *55B8E3B403B6_55B8E3B403B6_4952591E0263_Word_impl*
 Result := nil;
 l_Component := aForm.FindComponent(aListName);
 if (l_Component = nil) then
 // ��������� �������� � �������� �������...
 begin
  for i := 0 to aForm.ControlCount - 1 do
  begin
   l_Control := aForm.Controls[i];
   if (l_Control is TFrame) then
   begin
    l_Component := l_Control.FindComponent(aListName);
    if (l_Component <> nil) then
     Break;
   end // if l_Control is TFrame then
  end; // for i := 0 to aForm.ControlCount - 1 do
 end; // if l_Component = nil then
 Result := l_Component As TActionList;
//#UC END# *55B8E3B403B6_55B8E3B403B6_4952591E0263_Word_impl*
end;//TkwPopFormFindActionList.pop_form_FindActionList

class function TkwPopFormFindActionList.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:FindActionList';
end;//TkwPopFormFindActionList.GetWordNameForRegister

function TkwPopFormFindActionList.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TActionList);
end;//TkwPopFormFindActionList.GetResultTypeInfo

function TkwPopFormFindActionList.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopFormFindActionList.GetAllParamsCount

function TkwPopFormFindActionList.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TForm), @tfw_tiString]);
end;//TkwPopFormFindActionList.ParamsTypes

procedure TkwPopFormFindActionList.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TForm;
var l_aListName: AnsiString;
begin
 try
  l_aForm := TForm(aCtx.rEngine.PopObjAs(TForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aForm: TForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aListName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aListName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pop_form_FindActionList(aCtx, l_aForm, l_aListName));
end;//TkwPopFormFindActionList.DoDoIt

class function TFormsProcessingPackResNameGetter.ResName: AnsiString;
begin
 Result := 'FormsProcessingPack';
end;//TFormsProcessingPackResNameGetter.ResName

{$R FormsProcessingPack.res}

initialization
 TkwIterateForms.RegisterInEngine;
 {* ����������� IterateForms }
 TkwPopFormActiveMDIChild.RegisterInEngine;
 {* ����������� pop_form_ActiveMDIChild }
 TkwPopFormClose.RegisterInEngine;
 {* ����������� pop_form_Close }
 TkwPopFormFindMenuItem.RegisterInEngine;
 {* ����������� pop_form_FindMenuItem }
 TkwPopFormGetWindowState.RegisterInEngine;
 {* ����������� pop_form_GetWindowState }
 TkwPopFormHasControl.RegisterInEngine;
 {* ����������� pop_form_HasControl }
 TkwPopFormMDIChildCount.RegisterInEngine;
 {* ����������� pop_form_MDIChildCount }
 TkwPopFormMDIChildren.RegisterInEngine;
 {* ����������� pop_form_MDIChildren }
 TkwPopFormModalResult.RegisterInEngine;
 {* ����������� pop_form_ModalResult }
 TkwPopFormNext.RegisterInEngine;
 {* ����������� pop_form_Next }
 TkwPopFormSetWindowState.RegisterInEngine;
 {* ����������� pop_form_SetWindowState }
 TkwPopFormFindActionList.RegisterInEngine;
 {* ����������� pop_form_FindActionList }
 TFormsProcessingPackResNameGetter.Register;
 {* ����������� ������������ ����������� }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TForm));
 {* ����������� ���� TForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMenuItem));
 {* ����������� ���� TMenuItem }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TWindowState));
 {* ����������� ���� TWindowState }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* ����������� ���� Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* ����������� ���� Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TActionList));
 {* ����������� ���� TActionList }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* ����������� ���� AnsiString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* ����������� ���� TtfwWord }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
