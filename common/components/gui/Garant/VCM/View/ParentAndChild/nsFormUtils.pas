unit nsFormUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/common/components/gui/Garant/VCM/View/ParentAndChild/nsFormUtils.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi F1 Like Application::F1Like::View::ParentAndChild::nsFormUtils
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  ;

procedure NsSetPageIcon(const aForm: IvcmEntityForm);

implementation

uses
  ElPgCtl
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  
  ;

// unit methods

procedure NsSetPageIcon(const aForm: IvcmEntityForm);
//#UC START# *4F71E957012F_4F71E93E00EA_var*
var
 l_Index : Integer;
//#UC END# *4F71E957012F_4F71E93E00EA_var*
begin
//#UC START# *4F71E957012F_4F71E93E00EA_impl*
 if (aForm <> nil) and (aForm.VCLWinControl <> nil) then
 begin
  // Управлять иконкой может только документ находящийся непосредственно в
  // закладке
  if not (aForm.VCLWinControl.Parent is TElTabSheet) then
   Exit;
  with (aForm.VCLWinControl As TvcmEntityForm) do
   if (CurUserType = nil) then
    l_Index := -1
   else
    l_Index := CurUserType.ImageIndex;
  TElTabSheet(aForm.VCLWinControl.Parent).ImageIndex := l_Index;
 end;//if (aParams.Count >= 1)
//#UC END# *4F71E957012F_4F71E93E00EA_impl*
end;//NsSetPageIcon

end.