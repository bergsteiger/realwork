unit vcmBaseTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Модуль: "w:/common/components/gui/Garant/VCM/vcmBaseTypes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<InternalInterfaces::Category>> Shared Delphi::VCM::vcmBaseTypes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  l3Types
  ;

type
 TvcmFormID = {$IfDef XE4}record{$Else}object{$EndIf}
 public
   rName : AnsiString;
   rID : Integer;
 public
    function EQ(const anOther: TvcmFormID): Boolean;
 end;//TvcmFormID

 TvcmZoneType = (
   vcm_ztAny
 , vcm_ztMain
 , vcm_ztNavigator
 , vcm_ztParent
 , vcm_ztChild
 , vcm_ztReminder
 , vcm_ztFloating
 , vcm_ztModal
 , vcm_ztManualModal
 , vcm_ztForToolbarsInfo
 , vcm_ztSimpleFloat
 , vcm_ztMainObjectForm
 , vcm_ztForFocus
 );//TvcmZoneType

 TvcmNeedMakeDS = (
  {* Перечислимый тип определяющий необходимость создания БОФ }
   vcm_nmForce // создавать не взирая ни на что
 , vcm_nmNo // нельзя создавать, например потому, что форма была закрыта пользователем и при обновлении сборки ее создавать не нужно
 , vcm_nmYes // начальное состояние
 );//TvcmNeedMakeDS

const
  { UserTypes }
 vcm_utAny = 31;
  { любой пользовательский тип }

type
 TvcmIteratorAction = l3Types.Tl3IteratorAction;
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
// start class TvcmFormID

function TvcmFormID.EQ(const anOther: TvcmFormID): Boolean;
//#UC START# *528C93AC00EB_528C9354017B_var*
//#UC END# *528C93AC00EB_528C9354017B_var*
begin
//#UC START# *528C93AC00EB_528C9354017B_impl*
 Result := (Self.rName = anOther.rName);
//#UC END# *528C93AC00EB_528C9354017B_impl*
end;//TvcmFormID.EQ
{$IfEnd} //not NoVCM


end.