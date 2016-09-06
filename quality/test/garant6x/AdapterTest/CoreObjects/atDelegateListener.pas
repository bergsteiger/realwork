unit atDelegateListener;

// Модуль: "w:\quality\test\garant6x\AdapterTest\CoreObjects\atDelegateListener.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatDelegateListener" MUID: (48078A03039C)

interface

uses
 l3IntfUses
 , atListener
 , atInterfaces
;

type
 TatDelegateListenerProc = procedure(sender: TObject;
  const notification: IatNotification);

 TatDelegateListenerProcOfObject = procedure(sender: TObject;
  const notification: IatNotification) of object;

 TatDelegateListener = class(TatListener)
  private
   f_FireProc: TatDelegateListenerProc;
   f_FireProcOfObject: TatDelegateListenerProcOfObject;
  protected
   procedure DoFire(sender: TObject;
    const notification: IatNotification); override;
  public
   constructor Create(fireProc: TatDelegateListenerProc); reintroduce; overload;
   constructor Create(fireProcOfObject: TatDelegateListenerProcOfObject); reintroduce; overload;
 end;//TatDelegateListener

implementation

uses
 l3ImplUses
 //#UC START# *48078A03039Cimpl_uses*
 //#UC END# *48078A03039Cimpl_uses*
;

constructor TatDelegateListener.Create(fireProc: TatDelegateListenerProc);
//#UC START# *48078AD3036C_48078A03039C_var*
//#UC END# *48078AD3036C_48078A03039C_var*
begin
//#UC START# *48078AD3036C_48078A03039C_impl*
    inherited Create;
    Assert((@fireProc <> nil), 'fireProc <> nil!');
    f_FireProc := fireProc;
//#UC END# *48078AD3036C_48078A03039C_impl*
end;//TatDelegateListener.Create

constructor TatDelegateListener.Create(fireProcOfObject: TatDelegateListenerProcOfObject);
//#UC START# *48078AE001CE_48078A03039C_var*
//#UC END# *48078AE001CE_48078A03039C_var*
begin
//#UC START# *48078AE001CE_48078A03039C_impl*
    inherited Create;
    Assert((@fireProcOfObject <> nil), 'fireProcOfObject <> nil!');
    f_FireProcOfObject := fireProcOfObject;
//#UC END# *48078AE001CE_48078A03039C_impl*
end;//TatDelegateListener.Create

procedure TatDelegateListener.DoFire(sender: TObject;
 const notification: IatNotification);
//#UC START# *480784C30322_48078A03039C_var*
//#UC END# *480784C30322_48078A03039C_var*
begin
//#UC START# *480784C30322_48078A03039C_impl*
    if (@f_FireProc <> nil) then
      f_FireProc(sender, notification)
    else if (@f_FireProcOfObject <> nil) then
      f_FireProcOfObject(sender, notification)
    else
      Assert(false, 'Nothing of all!');
//#UC END# *480784C30322_48078A03039C_impl*
end;//TatDelegateListener.DoFire

end.
