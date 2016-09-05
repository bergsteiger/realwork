unit NOT_FINISHED_evCustomNSRCWriter;
 {* Фильтр для записи текста в формате NSRC. }

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evCustomNSRCWriter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevCustomNSRCWriter" MUID: (4836C0A201C1)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evCustomTextPainter
;

type
 TevCustomNSRCWriter = class(TevCustomTextPainter)
  {* Фильтр для записи текста в формате NSRC. }
  protected
   procedure CheckDigitalSeparatorAlignment; virtual;
    {* Корректировка стиля на наличие выравнивания по разделителю. }
 end;//TevCustomNSRCWriter

implementation

uses
 l3ImplUses
 , evNSRWrt
 //#UC START# *4836C0A201C1impl_uses*
 //#UC END# *4836C0A201C1impl_uses*
;

procedure TevCustomNSRCWriter.CheckDigitalSeparatorAlignment;
 {* Корректировка стиля на наличие выравнивания по разделителю. }
//#UC START# *4E3924CE03A3_4836C0A201C1_var*
//#UC END# *4E3924CE03A3_4836C0A201C1_var*
begin
//#UC START# *4E3924CE03A3_4836C0A201C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E3924CE03A3_4836C0A201C1_impl*
end;//TevCustomNSRCWriter.CheckDigitalSeparatorAlignment

end.
