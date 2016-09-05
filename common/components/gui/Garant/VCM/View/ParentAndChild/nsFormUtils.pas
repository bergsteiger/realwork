unit nsFormUtils;

// ћодуль: "w:\common\components\gui\Garant\VCM\View\ParentAndChild\nsFormUtils.pas"
// —тереотип: "UtilityPack"
// Ёлемент модели: "nsFormUtils" MUID: (4F71E93E00EA)

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

procedure nsSetPageIcon(const aForm: IvcmEntityForm);

implementation

uses
 l3ImplUses
 , ElPgCtl
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4F71E93E00EAimpl_uses*
 //#UC END# *4F71E93E00EAimpl_uses*
;

procedure nsSetPageIcon(const aForm: IvcmEntityForm);
//#UC START# *4F71E957012F_4F71E93E00EA_var*
var
 l_Index : Integer;
//#UC END# *4F71E957012F_4F71E93E00EA_var*
begin
//#UC START# *4F71E957012F_4F71E93E00EA_impl*
 if (aForm <> nil) and (aForm.VCLWinControl <> nil) then
 begin
  // ”правл€ть иконкой может только документ наход€щийс€ непосредственно в
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
end;//nsSetPageIcon

end.
