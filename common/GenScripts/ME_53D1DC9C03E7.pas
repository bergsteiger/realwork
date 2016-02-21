unit vcmEntityFormsIterable;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmEntityFormsIterable.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmIEntityFormPtrList
 , vcmInterfaces
 , vcmBaseTypes
;

type
 TvcmEntityFormsIterable = class(TvcmIEntityFormPtrList, IvcmEntityFormsIterable)
  protected
   function pm_GetFormsCount: Integer;
   procedure IterateFormsF(anAction: TvcmIteratorAction);
   procedure AddForm(const aForm: IvcmEntityForm);
  public
   class function Make: IvcmEntityFormsIterable; reintroduce;
 end;//TvcmEntityFormsIterable
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;

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
end;//TvcmEntityFormsIterable.Make

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
{$IfEnd} // NOT Defined(NoVCM)

end.
