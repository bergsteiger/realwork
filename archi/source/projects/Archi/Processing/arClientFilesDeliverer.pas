unit arClientFilesDeliverer;

// Модуль: "w:\archi\source\projects\Archi\Processing\arClientFilesDeliverer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarClientFilesDeliverer" MUID: (5811D63A0190)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 {$If NOT Defined(Nemesis)}
 , ncsClientFilesDeliverer
 {$IfEnd} // NOT Defined(Nemesis)
 , arResultDeliveryInterfaces
 {$If NOT Defined(Nemesis)}
 , CsDataPipe
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TarClientFilesDeliverer = class({$If NOT Defined(Nemesis)}
 TncsClientFilesDeliverer
 {$IfEnd} // NOT Defined(Nemesis)
 )
  private
   f_Listener: Pointer;
   f_RequestDeliveryProc: TarRequestDeliveryProc;
  protected
   function pm_GetListener: IarResultDelivererListner; virtual;
   {$If NOT Defined(Nemesis)}
   procedure CheckTaskExistence(const aTaskID: AnsiString); override;
   {$IfEnd} // NOT Defined(Nemesis)
   {$If NOT Defined(Nemesis)}
   procedure RequestSendMessage(const aMessage: AnsiString); override;
   {$IfEnd} // NOT Defined(Nemesis)
   {$If NOT Defined(Nemesis)}
   procedure ChangeResultFolder(const aTaskID: AnsiString;
    const aFolder: AnsiString); override;
   {$IfEnd} // NOT Defined(Nemesis)
   {$If NOT Defined(Nemesis)}
   function RequestNewFolder(var theFolder: AnsiString): Boolean; override;
   {$IfEnd} // NOT Defined(Nemesis)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aPipe: TCsDataPipe;
    const aWeakListener: IarResultDelivererListner;
    aRequestDeliveryProc: TarRequestDeliveryProc); reintroduce;
  protected
   property Listener: IarResultDelivererListner
    read pm_GetListener;
 end;//TarClientFilesDeliverer
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 //#UC START# *5811D63A0190impl_uses*
 //#UC END# *5811D63A0190impl_uses*
;

{$If NOT Defined(Nemesis)}
function TarClientFilesDeliverer.pm_GetListener: IarResultDelivererListner;
//#UC START# *58131F9D00CB_5811D63A0190get_var*
//#UC END# *58131F9D00CB_5811D63A0190get_var*
begin
//#UC START# *58131F9D00CB_5811D63A0190get_impl*
 Result := IarResultDelivererListner(f_Listener);
//#UC END# *58131F9D00CB_5811D63A0190get_impl*
end;//TarClientFilesDeliverer.pm_GetListener

constructor TarClientFilesDeliverer.Create(aPipe: TCsDataPipe;
 const aWeakListener: IarResultDelivererListner;
 aRequestDeliveryProc: TarRequestDeliveryProc);
//#UC START# *58131F3000D0_5811D63A0190_var*
//#UC END# *58131F3000D0_5811D63A0190_var*
begin
//#UC START# *58131F3000D0_5811D63A0190_impl*
 inherited Create(aPipe);
 f_Listener := Pointer(aWeakListener);
 f_RequestDeliveryProc := aRequestDeliveryProc;
 Assert(Assigned(f_RequestDeliveryProc));
//#UC END# *58131F3000D0_5811D63A0190_impl*
end;//TarClientFilesDeliverer.Create

procedure TarClientFilesDeliverer.CheckTaskExistence(const aTaskID: AnsiString);
//#UC START# *58131D6100E4_5811D63A0190_var*
//#UC END# *58131D6100E4_5811D63A0190_var*
begin
//#UC START# *58131D6100E4_5811D63A0190_impl*
 Listener.CheckTaskExistence(aTaskID);
//#UC END# *58131D6100E4_5811D63A0190_impl*
end;//TarClientFilesDeliverer.CheckTaskExistence

procedure TarClientFilesDeliverer.RequestSendMessage(const aMessage: AnsiString);
//#UC START# *5813272603DC_5811D63A0190_var*
//#UC END# *5813272603DC_5811D63A0190_var*
begin
//#UC START# *5813272603DC_5811D63A0190_impl*
 Listener.RequestSendMessage(aMessage);
//#UC END# *5813272603DC_5811D63A0190_impl*
end;//TarClientFilesDeliverer.RequestSendMessage

procedure TarClientFilesDeliverer.ChangeResultFolder(const aTaskID: AnsiString;
 const aFolder: AnsiString);
//#UC START# *5813275F019D_5811D63A0190_var*
//#UC END# *5813275F019D_5811D63A0190_var*
begin
//#UC START# *5813275F019D_5811D63A0190_impl*
 Listener.ChangeResultFolder(aTaskID, aFolder);
 f_RequestDeliveryProc();
//#UC END# *5813275F019D_5811D63A0190_impl*
end;//TarClientFilesDeliverer.ChangeResultFolder

function TarClientFilesDeliverer.RequestNewFolder(var theFolder: AnsiString): Boolean;
//#UC START# *581330B0019D_5811D63A0190_var*
//#UC END# *581330B0019D_5811D63A0190_var*
begin
//#UC START# *581330B0019D_5811D63A0190_impl*
 Result := Listener.RequestNewFolder(theFolder);
//#UC END# *581330B0019D_5811D63A0190_impl*
end;//TarClientFilesDeliverer.RequestNewFolder

procedure TarClientFilesDeliverer.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5811D63A0190_var*
//#UC END# *479731C50290_5811D63A0190_var*
begin
//#UC START# *479731C50290_5811D63A0190_impl*
 f_Listener := nil;
 inherited;
//#UC END# *479731C50290_5811D63A0190_impl*
end;//TarClientFilesDeliverer.Cleanup
{$IfEnd} // NOT Defined(Nemesis)

{$IfEnd} // Defined(AppClientSide)
end.
