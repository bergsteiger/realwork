unit nevNodeGroupFormatInfo;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevNodeGroupFormatInfo.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , nevControlsBlockFormatInfo
 , nevBase
 , l3Variant
;

type
 TnevNodeGroupFormatInfo = class(TnevControlsBlockFormatInfo)
  protected
   function pm_GetlocSpacing: TnevRect; override;
   procedure TuneFrameText(aText: Tl3Variant); override;
 end;//TnevNodeGroupFormatInfo

implementation

uses
 l3ImplUses
 , evTextStyle_Const
 , Graphics
 , k2Tags
 , evdStyles
;

function TnevNodeGroupFormatInfo.pm_GetlocSpacing: TnevRect;
//#UC START# *4E5F3D1102B8_4ED4EA8B0364get_var*
//#UC END# *4E5F3D1102B8_4ED4EA8B0364get_var*
begin
//#UC START# *4E5F3D1102B8_4ED4EA8B0364get_impl*
 Result := inherited pm_GetLocSpacing;
 Result.Left := 0;
 Result.Right := 0;
//#UC END# *4E5F3D1102B8_4ED4EA8B0364get_impl*
end;//TnevNodeGroupFormatInfo.pm_GetlocSpacing

procedure TnevNodeGroupFormatInfo.TuneFrameText(aText: Tl3Variant);
//#UC START# *4E5F8B2601DC_4ED4EA8B0364_var*
//#UC END# *4E5F8B2601DC_4ED4EA8B0364_var*
begin
//#UC START# *4E5F8B2601DC_4ED4EA8B0364_impl*
 aText.IntA[k2_tiStyle] := ev_saNodeGroupHeader;
//#UC END# *4E5F8B2601DC_4ED4EA8B0364_impl*
end;//TnevNodeGroupFormatInfo.TuneFrameText

end.
