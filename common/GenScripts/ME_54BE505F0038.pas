unit eeTextCursorPair;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\eeTextCursorPair.pas"
// Стереотип: "SimpleClass"

{$Include eeDefine.inc}

interface

uses
 l3IntfUses
 {$If Defined(evUseVisibleCursors)}
 , evTextCursorPair
 {$IfEnd} // Defined(evUseVisibleCursors)
 , nevTools
 , nevBase
 , l3Core
;

type
 TeeTextCursorPair = class(TevTextCursorPair)
  protected
   {$If Defined(evUseVisibleCursors)}
   function DoGetFont(const aView: InevView;
    aMap: TnevFormatInfoPrim;
    Stop: PInteger): InevFontPrim; override;
   {$IfEnd} // Defined(evUseVisibleCursors)
   {$If Defined(evUseVisibleCursors)}
   function GetInevDataFormattingModify(const aView: InevView): InevDataFormattingModify; override;
   {$IfEnd} // Defined(evUseVisibleCursors)
 end;//TeeTextCursorPair

implementation

uses
 l3ImplUses
 , eeCursorTools
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
;

{$If Defined(evUseVisibleCursors)}
function TeeTextCursorPair.DoGetFont(const aView: InevView;
 aMap: TnevFormatInfoPrim;
 Stop: PInteger): InevFontPrim;
//#UC START# *4A29477801BF_54BE505F0038_var*
//#UC END# *4A29477801BF_54BE505F0038_var*
begin
//#UC START# *4A29477801BF_54BE505F0038_impl*
 if eeIsReadOnlyPara(aView, ParaX) OR evIsInReadOnlyPara(ParaX) then
  Result := nil
 else
  Result := inherited DoGetFont(aView, aMap, Stop);
//#UC END# *4A29477801BF_54BE505F0038_impl*
end;//TeeTextCursorPair.DoGetFont
{$IfEnd} // Defined(evUseVisibleCursors)

{$If Defined(evUseVisibleCursors)}
function TeeTextCursorPair.GetInevDataFormattingModify(const aView: InevView): InevDataFormattingModify;
//#UC START# *4A3A61DC00AB_54BE505F0038_var*
//#UC END# *4A3A61DC00AB_54BE505F0038_var*
begin
//#UC START# *4A3A61DC00AB_54BE505F0038_impl*
 if eeIsReadOnlyPara(aView, ParaX) OR evIsInReadOnlyPara(ParaX)  then
  Result := nil
 else
  Result := inherited GetInevDataFormattingModify(aView);
//#UC END# *4A3A61DC00AB_54BE505F0038_impl*
end;//TeeTextCursorPair.GetInevDataFormattingModify
{$IfEnd} // Defined(evUseVisibleCursors)

end.
