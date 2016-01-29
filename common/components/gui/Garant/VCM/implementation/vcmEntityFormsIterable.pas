unit vcmEntityFormsIterable;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmEntityFormsIterable.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM::Containers::TvcmEntityFormsIterable
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmInterfaces,
  vcmIEntityFormPtrList,
  vcmBaseTypes
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmEntityFormsIterable = class(TvcmIEntityFormPtrList, IvcmEntityFormsIterable)
 protected
 // realized methods
   function pm_GetFormsCount: Integer;
   procedure IterateFormsF(anAction: TvcmIteratorAction);
   procedure AddForm(const aForm: IvcmEntityForm);
 public
 // public methods
   class function Make: IvcmEntityFormsIterable; reintroduce;
 end;//TvcmEntityFormsIterable
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}

// start class TvcmEntityFormsIterable

class function TvcmEntityFormsIterable.Make: IvcmEntityFormsIterable;
var
 l_Inst : TvcmEntityFormsIterable;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TvcmEntityFormsIterable.pm_GetFormsCount: Integer;
//#UC START# *53D1DB0203E2_53D1DC9C03E7get_var*
//#UC END# *53D1DB0203E2_53D1DC9C03E7get_var*
begin
//#UC START# *53D1DB0203E2_53D1DC9C03E7get_impl*
 Result := Count;
//#UC END# *53D1DB0203E2_53D1DC9C03E7get_impl*
end;//TvcmEntityFormsIterable.pm_GetFormsCount

procedure TvcmEntityFormsIterable.IterateFormsF(anAction: TvcmIteratorAction);
//#UC START# *53D1DB1A0349_53D1DC9C03E7_var*
//#UC END# *53D1DB1A0349_53D1DC9C03E7_var*
begin
//#UC START# *53D1DB1A0349_53D1DC9C03E7_impl*
 IterateAllF(anAction);
//#UC END# *53D1DB1A0349_53D1DC9C03E7_impl*
end;//TvcmEntityFormsIterable.IterateFormsF

procedure TvcmEntityFormsIterable.AddForm(const aForm: IvcmEntityForm);
//#UC START# *53D1EB8703D2_53D1DC9C03E7_var*
//#UC END# *53D1EB8703D2_53D1DC9C03E7_var*
begin
//#UC START# *53D1EB8703D2_53D1DC9C03E7_impl*
 Add(aForm);
//#UC END# *53D1EB8703D2_53D1DC9C03E7_impl*
end;//TvcmEntityFormsIterable.AddForm

{$IfEnd} //not NoVCM

end.