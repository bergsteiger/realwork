unit PrimPictureInfoOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimPictureInfoOptions_Form.pas"
// Начат: 07.09.2010 16:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Работа с документом и списком документов::Document::View::Picture::PrimPictureInfoOptions
//
// Информация о картинке
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
  PrimPictureInfo_Form,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimPictureInfoOptionsForm = {form} class(TPrimPictureInfoForm)
  {* Информация о картинке }
 protected
  procedure InitEntities; override;
 protected
 // realized methods
 end;//TPrimPictureInfoOptionsForm

 TvcmEntityFormRef = TPrimPictureInfoOptionsForm;
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
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TPrimPictureInfoOptionsForm

procedure TPrimPictureInfoOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Cut, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Cut, true);
  ShowInToolbar(en_Edit, op_Cut, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Paste, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Paste, true);
  ShowInToolbar(en_Edit, op_Paste, false);
  {$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
  
  ShowInContextMenu(en_Result, op_Cancel, false);
  ShowInToolbar(en_Result, op_Cancel, true);
  {$IfEnd} //not NoVCM

 end;//with Entities.Entities
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimPictureInfoOptions
 TtfwClassRef.Register(TPrimPictureInfoOptionsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.