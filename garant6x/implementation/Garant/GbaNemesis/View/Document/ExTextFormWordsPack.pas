unit ExTextFormWordsPack;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\ExTextFormWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ExTextFormWordsPack" MUID: (571A211F0239)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 //#UC START# *571A211F0239intf_uses*
 //#UC END# *571A211F0239intf_uses*
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , kwFormFromControlWord
 {$IfEnd} // NOT Defined(NoVCL)
 , ExText_Form
 , tfwScriptingInterfaces
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwRegisterableWord
 , kwPopEditorDeleteUserComment
 , afwFacade
 , SysUtils
 , nsConst
 , evDocumentsCache
 , FoldersUnit
 , DataAdapter
 , BaseTreeSupportUnit
 , tfwTypeRegistrator
 , tfwScriptingTypes
 //#UC START# *571A211F0239impl_uses*
 , nsUtils
 , bsTypesNew
 //#UC END# *571A211F0239impl_uses*
;

type
 TExTextFormHack = class(TExTextForm)
 end;//TExTextFormHack

 TkwExTextFormWord = {abstract} class({$If NOT Defined(NoVCL)}
 TkwFormFromControlWord
 {$IfEnd} // NOT Defined(NoVCL)
 )
  protected
   procedure DoTextForm(aForm: TExTextForm;
    const aCtx: TtfwContext); virtual; abstract;
   {$If NOT Defined(NoVCL)}
   procedure DoForm(aForm: TForm;
    const aCtx: TtfwContext); override;
   {$IfEnd} // NOT Defined(NoVCL)
 end;//TkwExTextFormWord

 TkwTextFormGetDocumentID = class(TkwExTextFormWord)
  {* Возвращает идентификатор текущего открытого документа }
  protected
   procedure DoTextForm(aForm: TExTextForm;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwTextFormGetDocumentID

{$If Defined(nsTest)}
 TkwTextFormSetNeedShowIntranetWarning = class(TkwExTextFormWord)
  protected
   procedure DoTextForm(aForm: TExTextForm;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwTextFormSetNeedShowIntranetWarning
{$IfEnd} // Defined(nsTest)

 TkwDocumentLikeState = {final} class(TkwExTextFormWord)
  protected
   procedure DoTextForm(aForm: TExTextForm;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDocumentLikeState

 TkwOpenDocument = {final} class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwOpenDocument

 TkwDocumentsCacheClear = {final} class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDocumentsCacheClear

 TkwIsMyDocumentsEmpty = {final} class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwIsMyDocumentsEmpty

{$If NOT Defined(NoVCL)}
procedure TkwExTextFormWord.DoForm(aForm: TForm;
 const aCtx: TtfwContext);
//#UC START# *4EB25DE00396_4DCA5A94013D_var*
//#UC END# *4EB25DE00396_4DCA5A94013D_var*
begin
//#UC START# *4EB25DE00396_4DCA5A94013D_impl*
 Assert(aForm Is TExTextForm, Format('Форма %s не совместима с %s',
                                   [aForm.ClassName, TExTextForm.ClassName]));
 DoTextForm(aForm As TExTextForm, aCtx);
//#UC END# *4EB25DE00396_4DCA5A94013D_impl*
end;//TkwExTextFormWord.DoForm
{$IfEnd} // NOT Defined(NoVCL)

procedure TkwTextFormGetDocumentID.DoTextForm(aForm: TExTextForm;
 const aCtx: TtfwContext);
//#UC START# *4DCA5B340360_4F1942440116_var*
var
 l_ID : Integer;
//#UC END# *4DCA5B340360_4F1942440116_var*
begin
//#UC START# *4DCA5B340360_4F1942440116_impl*
 l_ID := 0;
 try
  if (TExTextFormHack(aForm).Document <> nil) then
   l_ID := TExTextFormHack(aForm).Document.GetInternalId{ + c_InternalDocShift};
 finally
  aCtx.rEngine.PushInt(l_ID);
 end;//try..finally
//#UC END# *4DCA5B340360_4F1942440116_impl*
end;//TkwTextFormGetDocumentID.DoTextForm

class function TkwTextFormGetDocumentID.GetWordNameForRegister: AnsiString;
begin
 Result := 'textform:GetDocumentID';
end;//TkwTextFormGetDocumentID.GetWordNameForRegister

{$If Defined(nsTest)}
procedure TkwTextFormSetNeedShowIntranetWarning.DoTextForm(aForm: TExTextForm;
 const aCtx: TtfwContext);
//#UC START# *4DCA5B340360_4F183D860083_var*
//#UC END# *4DCA5B340360_4F183D860083_var*
begin
//#UC START# *4DCA5B340360_4F183D860083_impl*
 aForm.NeedShowIntranetWarningHack := aCtx.rEngine.PopBool;
//#UC END# *4DCA5B340360_4F183D860083_impl*
end;//TkwTextFormSetNeedShowIntranetWarning.DoTextForm

class function TkwTextFormSetNeedShowIntranetWarning.GetWordNameForRegister: AnsiString;
begin
 Result := 'textform:SetNeedShowIntranetWarning';
end;//TkwTextFormSetNeedShowIntranetWarning.GetWordNameForRegister
{$IfEnd} // Defined(nsTest)

procedure TkwDocumentLikeState.DoTextForm(aForm: TExTextForm;
 const aCtx: TtfwContext);
//#UC START# *4DCA5B340360_500E876A0208_var*
//#UC END# *4DCA5B340360_500E876A0208_var*
begin
//#UC START# *4DCA5B340360_500E876A0208_impl*
 aCtx.rEngine.PushInt(Ord(TExTextFormHack(aForm).dsDocument.LikeState));
//#UC END# *4DCA5B340360_500E876A0208_impl*
end;//TkwDocumentLikeState.DoTextForm

class function TkwDocumentLikeState.GetWordNameForRegister: AnsiString;
begin
 Result := 'document:LikeState';
end;//TkwDocumentLikeState.GetWordNameForRegister

procedure TkwOpenDocument.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DB00AF302F0_var*
var
 sDoc: string;
 iDoc: Integer;
 l_Result: Boolean;
//#UC END# *4DAEEDE10285_4DB00AF302F0_var*
begin
//#UC START# *4DAEEDE10285_4DB00AF302F0_impl*
 if aCtx.rEngine.IsTopString then
 begin
  sDoc := aCtx.rEngine.PopDelphiString;
  l_Result := nsOpenDocumentByNumber(sDoc, true, false);
 end else
 begin
  if aCtx.rEngine.IsTopBool then
  begin                             
   if not aCtx.rEngine.PopBool then
   begin
    iDoc := aCtx.rEngine.PopInt;
    sDoc := IntToStr(iDoc);
    iDoc := iDoc + c_InternalDocShift;
   end else
   begin
    iDoc := aCtx.rEngine.PopInt;
    sDoc := IntToStr(iDoc);
   end;
  end else
  begin
   iDoc := aCtx.rEngine.PopInt;
   sDoc := IntToStr(iDoc);
   iDoc := iDoc + c_InternalDocShift;
  end;
  l_Result := nsOpenDocumentByNumber(iDoc, 0, dptSub, false);
 end;
 RunnerAssert(l_Result, 'Документ ' + sDoc + ' в базе не найден.', aCtx);
//#UC END# *4DAEEDE10285_4DB00AF302F0_impl*
end;//TkwOpenDocument.DoDoIt

class function TkwOpenDocument.GetWordNameForRegister: AnsiString;
begin
 Result := 'Открыть';
end;//TkwOpenDocument.GetWordNameForRegister

procedure TkwDocumentsCacheClear.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DB82E4D0197_var*
//#UC END# *4DAEEDE10285_4DB82E4D0197_var*
begin
//#UC START# *4DAEEDE10285_4DB82E4D0197_impl*
 TevDocumentsCache.Clear;
//#UC END# *4DAEEDE10285_4DB82E4D0197_impl*
end;//TkwDocumentsCacheClear.DoDoIt

class function TkwDocumentsCacheClear.GetWordNameForRegister: AnsiString;
begin
 Result := 'documentscache:Clear';
end;//TkwDocumentsCacheClear.GetWordNameForRegister

procedure TkwIsMyDocumentsEmpty.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_53B2CAE50115_var*
var
 l_Child,
 l_FoldersRoot: INode;
 I: Integer;
//#UC END# *4DAEEDE10285_53B2CAE50115_var*
begin
//#UC START# *4DAEEDE10285_53B2CAE50115_impl*
 l_FoldersRoot := DefDataAdapter.FoldersRoot;
 try
  for I := 0 to l_FoldersRoot.GetChildCount - 1 do
  begin
   l_FoldersRoot.GetChild(I, l_Child);
   if l_Child.GetFlags and NF_MY_DOCUMENTS = NF_MY_DOCUMENTS then
   begin
    aCtx.rEngine.PushBool(l_Child.GetChildCount = 0);
    Exit;
   end;
  end;
  RunnerAssert(False, 'Мои документы не найдены.', aCtx);
 finally
  l_FoldersRoot := nil;
 end;
//#UC END# *4DAEEDE10285_53B2CAE50115_impl*
end;//TkwIsMyDocumentsEmpty.DoDoIt

class function TkwIsMyDocumentsEmpty.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsMyDocumentsEmpty';
end;//TkwIsMyDocumentsEmpty.GetWordNameForRegister

initialization
 TkwExTextFormWord.RegisterClass;
 {* Регистрация TkwExTextFormWord }
 TkwTextFormGetDocumentID.RegisterInEngine;
 {* Регистрация TkwTextFormGetDocumentID }
{$If Defined(nsTest)}
 TkwTextFormSetNeedShowIntranetWarning.RegisterInEngine;
 {* Регистрация TkwTextFormSetNeedShowIntranetWarning }
{$IfEnd} // Defined(nsTest)
 TkwDocumentLikeState.RegisterInEngine;
 {* Регистрация document_LikeState }
 TkwOpenDocument.RegisterInEngine;
 {* Регистрация OpenDocument }
 TkwDocumentsCacheClear.RegisterInEngine;
 {* Регистрация TkwDocumentsCacheClear }
 TkwIsMyDocumentsEmpty.RegisterInEngine;
 {* Регистрация IsMyDocumentsEmpty }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
