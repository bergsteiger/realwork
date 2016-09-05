unit NOT_FINISHED_eeTextSourceExport;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\NOT_FINISHED_eeTextSourceExport.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TeeTextSourceExport" MUID: (47542EDE038A)

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , nevTools
;

type
 TeeMakeDocumentContainerEvent = procedure(Sender: TObject;
  var aMade: InevDocumentContainer) of object;

 TeeTextSourceExport = class({$If NOT Defined(NoVCM)}
 IvcmState
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   {$If NOT Defined(NoVCM)}
   function SaveState(out theState: IUnknown;
    aStateType: TvcmStateType): Boolean;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function LoadState(const theState: IUnknown;
    aStateType: TvcmStateType;
    aClone: Boolean): Boolean;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TeeTextSourceExport
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *47542EDE038Aimpl_uses*
 //#UC END# *47542EDE038Aimpl_uses*
;

{$If NOT Defined(NoVCM)}
function TeeTextSourceExport.SaveState(out theState: IUnknown;
 aStateType: TvcmStateType): Boolean;
//#UC START# *4683E75B01D8_47542EDE038A_var*
//#UC END# *4683E75B01D8_47542EDE038A_var*
begin
//#UC START# *4683E75B01D8_47542EDE038A_impl*
 assert(false, 'TeeTextSourceExport.SaveState not implemented');
//#UC END# *4683E75B01D8_47542EDE038A_impl*
end;//TeeTextSourceExport.SaveState
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TeeTextSourceExport.LoadState(const theState: IUnknown;
 aStateType: TvcmStateType;
 aClone: Boolean): Boolean;
//#UC START# *4683E79D0331_47542EDE038A_var*
//#UC END# *4683E79D0331_47542EDE038A_var*
begin
//#UC START# *4683E79D0331_47542EDE038A_impl*
 assert(false, 'TeeTextSourceExport.LoadState not implemented');
//#UC END# *4683E79D0331_47542EDE038A_impl*
end;//TeeTextSourceExport.LoadState
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(Nemesis)
end.
