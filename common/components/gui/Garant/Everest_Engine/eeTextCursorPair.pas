unit eeTextCursorPair;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest Engine"
// Модуль: "w:/common/components/gui/Garant/Everest_Engine/eeTextCursorPair.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Everest Engine::Cursors::TeeTextCursorPair
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

uses
  Classes
  {$If defined(evUseVisibleCursors)}
  ,
  evTextCursorPair
  {$IfEnd} //evUseVisibleCursors
  ,
  nevBase,
  l3Core,
  nevTools
  ;

type
 TeeTextCursorPair = class(TevTextCursorPair)
 protected
 // overridden protected methods
   {$If defined(evUseVisibleCursors)}
   function DoGetFont(const aView: InevView;
    aMap: TnevFormatInfoPrim;
    Stop: PInteger): InevFontPrim; override;
   {$IfEnd} //evUseVisibleCursors
   {$If defined(evUseVisibleCursors)}
   function GetInevDataFormattingModify(const aView: InevView): InevDataFormattingModify; override;
   {$IfEnd} //evUseVisibleCursors
 end;//TeeTextCursorPair

implementation

uses
  eeCursorTools
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  
  ;

// start class TeeTextCursorPair

{$If defined(evUseVisibleCursors)}
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
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}
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
{$IfEnd} //evUseVisibleCursors

end.