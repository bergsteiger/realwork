unit atNotifier;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/CoreObjects/atNotifier.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::CoreObjects::TatNotifier
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  SysUtils,
  Classes,
  atInterfaces
  ;

type
 TatNotifier = class(TInterfacedObject, IatNotifier)
 private
 // private fields
   f_Listeners : TInterfaceList;
   f_MREWS : TMultiReadExclusiveWriteSynchronizer;
 private
 // private methods
   function IsNotify(const listener: IatListener): Boolean;
 protected
 // realized methods
   procedure StartNotify(const listener: IatListener);
   procedure StopNotify; overload; 
   procedure StopNotify(const listener: IatListener); overload; 
   procedure Trigger(sender: TObject;
    const notification: IatNotification);
 public
 // overridden public methods
   destructor Destroy; override;
 public
 // public methods
   constructor Create; reintroduce;
 end;//TatNotifier

implementation

// start class TatNotifier

function TatNotifier.IsNotify(const listener: IatListener): Boolean;
//#UC START# *480787C7033C_4807877801B7_var*
//#UC END# *480787C7033C_4807877801B7_var*
begin
//#UC START# *480787C7033C_4807877801B7_impl*
    Result := (f_Listeners.IndexOf(listener) <> -1);
//#UC END# *480787C7033C_4807877801B7_impl*
end;//TatNotifier.IsNotify

constructor TatNotifier.Create;
//#UC START# *480787E20035_4807877801B7_var*
//#UC END# *480787E20035_4807877801B7_var*
begin
//#UC START# *480787E20035_4807877801B7_impl*
    inherited;
    //
    f_Listeners := TInterfaceList.Create;
    f_MREWS := TMultiReadExclusiveWriteSynchronizer.Create;
//#UC END# *480787E20035_4807877801B7_impl*
end;//TatNotifier.Create

procedure TatNotifier.StartNotify(const listener: IatListener);
//#UC START# *48077F83039B_4807877801B7_var*
//#UC END# *48077F83039B_4807877801B7_var*
begin
//#UC START# *48077F83039B_4807877801B7_impl*
    f_MREWS.BeginWrite;
    try
      if IsNotify(listener) then Exit;
      f_Listeners.Add(listener);
      listener.StartListen(Self);
    finally
      f_MREWS.EndWrite;
    end;
//#UC END# *48077F83039B_4807877801B7_impl*
end;//TatNotifier.StartNotify

procedure TatNotifier.StopNotify;
//#UC START# *48077F8E00B6_4807877801B7_var*
    var
      listener : IatListener;
//#UC END# *48077F8E00B6_4807877801B7_var*
begin
//#UC START# *48077F8E00B6_4807877801B7_impl*
    f_MREWS.BeginWrite;
    try
      while (true) do begin
        if (f_Listeners.Count = 0) then Exit; // и так никого не слушаем
        listener := f_Listeners.First as IatListener;
        StopNotify(listener);
      end;
    finally
      f_MREWS.EndWrite;
    end;
//#UC END# *48077F8E00B6_4807877801B7_impl*
end;//TatNotifier.StopNotify

procedure TatNotifier.StopNotify(const listener: IatListener);
//#UC START# *48077F9601A1_4807877801B7_var*
//#UC END# *48077F9601A1_4807877801B7_var*
begin
//#UC START# *48077F9601A1_4807877801B7_impl*
    f_MREWS.BeginWrite;
    try
      if NOT IsNotify(listener) then Exit;
      f_Listeners.Remove(listener);
      listener.StopListen(Self);
    finally
      f_MREWS.EndWrite;
    end;
//#UC END# *48077F9601A1_4807877801B7_impl*
end;//TatNotifier.StopNotify

procedure TatNotifier.Trigger(sender: TObject;
  const notification: IatNotification);
//#UC START# *48077FA2038C_4807877801B7_var*
    var
      i : integer;
      listener : IatListener;
//#UC END# *48077FA2038C_4807877801B7_var*
begin
//#UC START# *48077FA2038C_4807877801B7_impl*
    f_MREWS.BeginRead;
    try
      for i := 0 to f_Listeners.Count-1 do
      begin
        listener := f_Listeners.Items[i] as IatListener;
        listener.Fire(sender, notification);
      end;
    finally
      f_MREWS.EndRead;
    end;
//#UC END# *48077FA2038C_4807877801B7_impl*
end;//TatNotifier.Trigger

destructor TatNotifier.Destroy;
//#UC START# *48077504027E_4807877801B7_var*
//#UC END# *48077504027E_4807877801B7_var*
begin
//#UC START# *48077504027E_4807877801B7_impl*
    StopNotify;
    FreeAndNil(f_Listeners);
    FreeAndNil(f_MREWS);
    //
    inherited;
//#UC END# *48077504027E_4807877801B7_impl*
end;//TatNotifier.Destroy

end.