unit nevCloakFormatInfo;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevCloakFormatInfo.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevCloakFormatInfo" MUID: (4E5F550D0032)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , nevControlsBlockFormatInfo
 , l3Variant
;

type
 TnevCloakFormatInfo = class(TnevControlsBlockFormatInfo)
  protected
   procedure TuneFrameText(aText: Tl3Variant); override;
 end;//TnevCloakFormatInfo

implementation

uses
 l3ImplUses
 , evdStyles
 , k2Tags
 , Graphics
 , evTextStyle_Const
;

procedure TnevCloakFormatInfo.TuneFrameText(aText: Tl3Variant);
//#UC START# *4E5F8B2601DC_4E5F550D0032_var*
//#UC END# *4E5F8B2601DC_4E5F550D0032_var*
begin
//#UC START# *4E5F8B2601DC_4E5F550D0032_impl*
 aText.IntA[k2_tiStyle] := ev_saCloakHeader;
//#UC END# *4E5F8B2601DC_4E5F550D0032_impl*
end;//TnevCloakFormatInfo.TuneFrameText

end.
