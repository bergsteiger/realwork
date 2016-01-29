unit PrimBaseSearchOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaseSearch/Forms/PrimBaseSearchOptions_Form.pas"
// Начат: 27.10.2010 13:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Основные прецеденты::BaseSearch::View::BaseSearch$Module::PrimBaseSearchOptions
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
  Classes
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Text_Controls
  {$IfEnd} //not NoVCM
  ,
  PrimBaseSearch_Form,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimBaseSearchOptionsForm = {form} class(TPrimBaseSearchForm)
 protected
  procedure InitEntities; override;
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure Edit_FindNext_Test(const aParams: IvcmTestParamsPrim);
     {* Найти далее }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_FindNext_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Найти далее }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_FindPrev_Test(const aParams: IvcmTestParamsPrim);
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_FindPrev_Execute(const aParams: IvcmExecuteParamsPrim);
   {$IfEnd} //not NoVCM
 end;//TPrimBaseSearchOptionsForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TPrimBaseSearchOptionsForm

{$If not defined(NoVCM)}
procedure TPrimBaseSearchOptionsForm.Edit_FindNext_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *495130C40123_4CC7F0CE0267test_var*
//#UC END# *495130C40123_4CC7F0CE0267test_var*
begin
//#UC START# *495130C40123_4CC7F0CE0267test_impl*
 // - ничего не делаем
//#UC END# *495130C40123_4CC7F0CE0267test_impl*
end;//TPrimBaseSearchOptionsForm.Edit_FindNext_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimBaseSearchOptionsForm.Edit_FindNext_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495130C40123_4CC7F0CE0267exec_var*
//#UC END# *495130C40123_4CC7F0CE0267exec_var*
begin
//#UC START# *495130C40123_4CC7F0CE0267exec_impl*
 DoFindBtnClick;
//#UC END# *495130C40123_4CC7F0CE0267exec_impl*
end;//TPrimBaseSearchOptionsForm.Edit_FindNext_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimBaseSearchOptionsForm.Edit_FindPrev_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49FEDE4703B8_4CC7F0CE0267test_var*
//#UC END# *49FEDE4703B8_4CC7F0CE0267test_var*
begin
//#UC START# *49FEDE4703B8_4CC7F0CE0267test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Assigned(f_BaseSearcher) and f_BaseSearcher.WindowData.FindBackEnabled;
//#UC END# *49FEDE4703B8_4CC7F0CE0267test_impl*
end;//TPrimBaseSearchOptionsForm.Edit_FindPrev_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimBaseSearchOptionsForm.Edit_FindPrev_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49FEDE4703B8_4CC7F0CE0267exec_var*
//#UC END# *49FEDE4703B8_4CC7F0CE0267exec_var*
begin
//#UC START# *49FEDE4703B8_4CC7F0CE0267exec_impl*
 DoFindBackBtnClick;
//#UC END# *49FEDE4703B8_4CC7F0CE0267exec_impl*
end;//TPrimBaseSearchOptionsForm.Edit_FindPrev_Execute
{$IfEnd} //not NoVCM

procedure TPrimBaseSearchOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_FindNext, Edit_FindNext_Execute, Edit_FindNext_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Undo, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Undo, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Redo, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Redo, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_FindPrev, Edit_FindPrev_Execute, Edit_FindPrev_Test, nil);
  {$IfEnd} //not NoVCM

 end;//with Entities.Entities
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimBaseSearchOptions
 TtfwClassRef.Register(TPrimBaseSearchOptionsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.