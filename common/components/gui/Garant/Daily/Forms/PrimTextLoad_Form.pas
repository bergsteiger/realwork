unit PrimTextLoad_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Forms"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Daily/Forms/PrimTextLoad_Form.pas"
// Начат: 23.09.2010 13:40
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> Shared Delphi Operations For Tests::TestForms::Forms::Everest::PrimTextLoad
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  evCustomEditor,
  evCustomTextSource,
  vcmEntityForm,
  evLoadDocumentManager,
  vcmExternalInterfaces {a},
  vcmInterfaces {a}
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TPrimTextLoadForm = {form} class(TvcmEntityForm)
 private
 // private fields
   f_LoadManager : TevLoadDocumentManager;
    {* Поле для свойства LoadManager}
 protected
  procedure MakeControls; override;
 protected
 // property methods
   function pm_GetTextSource: TevCustomTextSource; virtual; abstract;
   function pm_GetText: TevCustomEditor; virtual; abstract;
 protected
 // overridden protected methods
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
 public
 // public methods
   procedure AfterLoad; virtual;
 public
 // public properties
   property LoadManager: TevLoadDocumentManager
     read f_LoadManager;
   property TextSource: TevCustomTextSource
     read pm_GetTextSource;
   property Text: TevCustomEditor
     read pm_GetText;
 end;//TPrimTextLoadForm

 TvcmEntityFormRef = TPrimTextLoadForm;
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
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
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

// start class TPrimTextLoadForm

procedure TPrimTextLoadForm.AfterLoad;
//#UC START# *4F15435202B5_4C9B20790302_var*
//#UC END# *4F15435202B5_4C9B20790302_var*
begin
//#UC START# *4F15435202B5_4C9B20790302_impl*
 
//#UC END# *4F15435202B5_4C9B20790302_impl*
end;//TPrimTextLoadForm.AfterLoad

procedure TPrimTextLoadForm.InitControls;
//#UC START# *4A8E8F2E0195_4C9B20790302_var*
//#UC END# *4A8E8F2E0195_4C9B20790302_var*
begin
//#UC START# *4A8E8F2E0195_4C9B20790302_impl*
 inherited;
 WindowState := wsMaximized;
 Text.Align := alClient;
 Text.WebStyle := true;
 Text.TextSource := Self.TextSource;
//#UC END# *4A8E8F2E0195_4C9B20790302_impl*
end;//TPrimTextLoadForm.InitControls

procedure TPrimTextLoadForm.MakeControls;
begin
 inherited;
 f_LoadManager := TevLoadDocumentManager.Create(Self);
 f_LoadManager.Name := 'LoadManager';
end;

{$IfEnd} //nsTest AND not NoVCM

initialization
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация PrimTextLoad
 TtfwClassRef.Register(TPrimTextLoadForm);
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

end.