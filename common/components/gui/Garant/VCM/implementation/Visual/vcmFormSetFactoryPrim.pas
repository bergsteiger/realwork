unit vcmFormSetFactoryPrim;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFactoryPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmFormSetFactoryPrim" MUID: (4FFE84F00388)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoObject
 , l3Interfaces
;

type
 TvcmFormSetFactoryPrim = class(Tl3ProtoObject)
  private
   f_Caption: Il3CString;
  protected
   class function GetInstance: TvcmFormSetFactoryPrim; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   property Caption: Il3CString
    read f_Caption
    write f_Caption;
 end;//TvcmFormSetFactoryPrim
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 //#UC START# *4FFE84F00388impl_uses*
 //#UC END# *4FFE84F00388impl_uses*
;

class function TvcmFormSetFactoryPrim.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4FFE84F00388_var*
//#UC END# *4FFE854A009B_4FFE84F00388_var*
begin
//#UC START# *4FFE854A009B_4FFE84F00388_impl*
 Result := nil;
 Assert(false, Format('Экземпляр сборки %s не определён', [ClassName]));
//#UC END# *4FFE854A009B_4FFE84F00388_impl*
end;//TvcmFormSetFactoryPrim.GetInstance

procedure TvcmFormSetFactoryPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4FFE84F00388_var*
//#UC END# *479731C50290_4FFE84F00388_var*
begin
//#UC START# *479731C50290_4FFE84F00388_impl*
 f_Caption := nil;
 inherited;
//#UC END# *479731C50290_4FFE84F00388_impl*
end;//TvcmFormSetFactoryPrim.Cleanup

procedure TvcmFormSetFactoryPrim.ClearFields;
begin
 Caption := nil;
 inherited;
end;//TvcmFormSetFactoryPrim.ClearFields
{$IfEnd} // NOT Defined(NoVCM)

end.
