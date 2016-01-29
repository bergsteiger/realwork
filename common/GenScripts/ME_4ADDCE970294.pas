unit OfficeLikeRes;

interface

uses
 l3IntfUses
 , vcmApplication
 , vcmMainForm
 , OfficeLike_Usual_Controls
 , vcmExternalInterfaces
 , Classes
;

type
 TOfficeLikeMainForm = class(TvcmMainForm, Common, History)
  procedure DoBack(const aParams: IvcmExecuteParamsPrim);
  procedure DoForward(const aParams: IvcmExecuteParamsPrim);
  function NeedTerminateOnExit: Boolean;
  function AskMayExit: Boolean;
  procedure Exit;
  procedure Back;
   {* Назад }
  procedure Forward;
   {* Вперёд }
 end;//TOfficeLikeMainForm
 
 TOfficeLikeRes = class(TvcmApplication)
 end;//TOfficeLikeRes
 
implementation

uses
 l3ImplUses
 , moToolbarMenu
 , vcmBaseOperationsCollectionItem
 , vcmUserControls
 , Windows
 , TtfwClassRef_Proxy
;

end.
