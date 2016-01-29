unit PrimNewsLineOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimNewsLineOptions_Form.pas"
// Начат: 08.09.2010 20:37
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Пользовательские сервисы::Autoreferat::View::Search::PrimNewsLineOptions
//
// ПРАЙМ. Моя новостная лента
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  PrimNewsLine_Form,
  Autoreferat_InternalOperations_Controls,
  PrimNewsLine_nltMain_UserType
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Tree_Controls
  {$IfEnd} //not NoVCM
  ,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimNewsLineOptionsForm = {form} class(TPrimNewsLineForm)
  {* ПРАЙМ. Моя новостная лента }
 protected
  procedure InitEntities; override;
 protected
 // realized methods
   procedure NewsThemes_SelectCurrent_Test(const aParams: IvcmTestParamsPrim);
   procedure NewsThemes_SelectCurrent_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure DateInterval_Open_Test(const aParams: IvcmTestParamsPrim);
   procedure DateInterval_Open_Execute(const aParams: IvcmExecuteParamsPrim);
 end;//TPrimNewsLineOptionsForm

 TvcmEntityFormRef = TPrimNewsLineOptionsForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3String,
  nsNewsLine,
  Windows
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TPrimNewsLineOptionsForm

procedure TPrimNewsLineOptionsForm.NewsThemes_SelectCurrent_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C87BBFF0313_4C87BB9C0143test_var*
var
 l_Strings: IvcmStrings;
 l_NeedUpdateCaption: Boolean;
//#UC END# *4C87BBFF0313_4C87BB9C0143test_var*
begin
//#UC START# *4C87BBFF0313_4C87BB9C0143test_impl*
 l_Strings := aParams.Op.SubItems;
 try
  l_NeedUpdateCaption := (aParams.Op.SubItems.Count = 0) OR f_UpdateFlag;
  if f_UpdateFlag then
  begin
   if (l_Strings <> nil) then
    l_Strings.Clear;
   f_UpdateFlag := false;
  end;//f_UpdateFlag
  if (TnsNewsLine.Make.ThemeList.Count > 0) then
  begin
   aParams.Op.Flag[vcm_ofEnabled] := TnsNewsLine.Make.ThemeList.Count > 1;
   if (TnsNewsLine.Make.ThemeList.Count = 1) and l3IsNil(TnsNewsLine.Make.ThemeList[0]) then
   begin
    l_Strings.Clear;
    aParams.Op.SelectedString := aParams.Op.Caption;
    Exit;
   end;
   if (l_Strings <> nil) then
   begin
    if (l_Strings.Count = 0) then
    begin
     l_Strings.Clear;
     l_Strings.Assign(TnsNewsLine.Make.ThemeList);
    end;//l_Strings.Count = 0
    aParams.Op.SelectedString := TnsNewsLine.Make.CurrentTheme;
   end;//l_Strings <> nil
  end//TnsNewsLine.Make.ThemeList.Count > 0
  else
  begin
   aParams.Op.SelectedString := aParams.Op.Caption;
   aParams.Op.Flag[vcm_ofEnabled] := false;
  end;
 finally
  l_Strings := nil;
 end;//try..finally
 if l_NeedUpdateCaption then
 begin
  UpdateTabCaption(TnsNewsLine.Make.CurrentTheme);
 end;
//#UC END# *4C87BBFF0313_4C87BB9C0143test_impl*
end;//TPrimNewsLineOptionsForm.NewsThemes_SelectCurrent_Test

procedure TPrimNewsLineOptionsForm.NewsThemes_SelectCurrent_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C87BBFF0313_4C87BB9C0143exec_var*
//#UC END# *4C87BBFF0313_4C87BB9C0143exec_var*
begin
//#UC START# *4C87BBFF0313_4C87BB9C0143exec_impl*
 TnsNewsLine.Make.CurrentTheme := aParams.SelectedString;
 UpdateNewsLineTree;
 OpenAutoreferat(DateList.GetCurrentNode);
//#UC END# *4C87BBFF0313_4C87BB9C0143exec_impl*
end;//TPrimNewsLineOptionsForm.NewsThemes_SelectCurrent_Execute

procedure TPrimNewsLineOptionsForm.DateInterval_Open_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C87BC6502B9_4C87BB9C0143test_var*
//#UC END# *4C87BC6502B9_4C87BB9C0143test_var*
begin
//#UC START# *4C87BC6502B9_4C87BB9C0143test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := DateList.Current >= 0;
//#UC END# *4C87BC6502B9_4C87BB9C0143test_impl*
end;//TPrimNewsLineOptionsForm.DateInterval_Open_Test

procedure TPrimNewsLineOptionsForm.DateInterval_Open_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C87BC6502B9_4C87BB9C0143exec_var*
//#UC END# *4C87BC6502B9_4C87BB9C0143exec_var*
begin
//#UC START# *4C87BC6502B9_4C87BB9C0143exec_impl*
 OpenAutoreferat(DateList.GetCurrentNode);
//#UC END# *4C87BC6502B9_4C87BB9C0143exec_impl*
end;//TPrimNewsLineOptionsForm.DateInterval_Open_Execute

procedure TPrimNewsLineOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Tree, nil);
  PublishFormEntity(en_NewsThemes, nil);
  PublishFormEntity(en_DateInterval, nil);
  ContextMenuWeight(en_DateInterval, 1);
  ContextMenuWeight(en_Tree, 10);
  {$If not defined(NoVCM)}
  PublishOp(en_Tree, op_ExpandAll, nil, nil, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Tree, op_CollapseAll, nil, nil, nil);
  {$IfEnd} //not NoVCM

  PublishOp(en_NewsThemes, op_SelectCurrent, NewsThemes_SelectCurrent_Execute, NewsThemes_SelectCurrent_Test, nil);
  ShowInContextMenu(en_NewsThemes, op_SelectCurrent, false);
  ShowInToolbar(en_NewsThemes, op_SelectCurrent, true);
  PublishOp(en_DateInterval, op_Open, DateInterval_Open_Execute, DateInterval_Open_Test, nil);
  ShowInContextMenu(en_DateInterval, op_Open, true);
  ShowInToolbar(en_DateInterval, op_Open, false);
  ContextMenuWeight(en_DateInterval, op_Open, 1);
 end;//with Entities.Entities
 {$If not defined(NoVCM)}
 AddUserTypeExclude(nltMainName, en_Tree, op_ExpandAll, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(nltMainName, en_Tree, op_CollapseAll, false);
 {$IfEnd} //not NoVCM
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimNewsLineOptions
 TtfwClassRef.Register(TPrimNewsLineOptionsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.