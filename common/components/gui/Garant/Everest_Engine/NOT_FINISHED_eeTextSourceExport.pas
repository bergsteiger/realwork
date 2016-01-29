unit NOT_FINISHED_eeTextSourceExport;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest Engine"
// Модуль: "w:/common/components/gui/Garant/Everest_Engine/NOT_FINISHED_eeTextSourceExport.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Everest Engine::eeTextSource::TeeTextSourceExport
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

{$If defined(Nemesis)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  ,
  nevTools
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TeeMakeDocumentContainerEvent = procedure (Sender: TObject;
  var aMade: InevDocumentContainer) of object;

 TeeTextSourceExport = class( {$If not defined(NoVCM)}, IvcmState{$IfEnd} //not NoVCM
 )
 protected
 // realized methods
   {$If not defined(NoVCM)}
   function SaveState(out theState: IUnknown;
    aStateType: TvcmStateType): Boolean;
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function LoadState(const theState: IUnknown;
    aStateType: TvcmStateType): Boolean;
   {$IfEnd} //not NoVCM
 end;//TeeTextSourceExport
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}

// start class TeeTextSourceExport

{$If not defined(NoVCM)}
function TeeTextSourceExport.SaveState(out theState: IUnknown;
  aStateType: TvcmStateType): Boolean;
//#UC START# *4683E75B01D8_47542EDE038A_var*
//#UC END# *4683E75B01D8_47542EDE038A_var*
begin
//#UC START# *4683E75B01D8_47542EDE038A_impl*
 assert(false, 'TeeTextSourceExport.SaveState not implemented');
//#UC END# *4683E75B01D8_47542EDE038A_impl*
end;//TeeTextSourceExport.SaveState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TeeTextSourceExport.LoadState(const theState: IUnknown;
  aStateType: TvcmStateType): Boolean;
//#UC START# *4683E79D0331_47542EDE038A_var*
//#UC END# *4683E79D0331_47542EDE038A_var*
begin
//#UC START# *4683E79D0331_47542EDE038A_impl*
 assert(false, 'TeeTextSourceExport.LoadState not implemented');
//#UC END# *4683E79D0331_47542EDE038A_impl*
end;//TeeTextSourceExport.LoadState
{$IfEnd} //not NoVCM

{$IfEnd} //Nemesis

end.