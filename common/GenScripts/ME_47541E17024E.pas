unit l3InterfacedComponent;
 {* Базовый класс компонентов, поддерживающих счетчик ссылок и интерфейсы IUnknown. }

// Модуль: "w:\common\components\rtl\Garant\L3\l3InterfacedComponent.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3InterfacedComponent" MUID: (47541E17024E)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , Classes
 , l3IID
 , l3PureMixIns
 //#UC START# *47541E17024Eintf_uses*
 //#UC END# *47541E17024Eintf_uses*
;

type
 //#UC START# *47541E17024Eci*
 {$Define _UnknownIsBaseComponent}
 //#UC END# *47541E17024Eci*
 _l3Unknown_Parent_ = TComponent;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 //#UC START# *47541E17024Ecit*
 //#UC END# *47541E17024Ecit*
 Tl3InterfacedComponent = class(_l3Unknown_)
  {* Базовый класс компонентов, поддерживающих счетчик ссылок и интерфейсы IUnknown. }
  protected
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; virtual;
    {* метод для реализации QueryInterface (Для перекрытия в потомках). }
   function QueryInterface(const IID: TGUID;
    out Obj): HResult; override;
  public
   constructor CreateX; reintroduce;
 //#UC START# *47541E17024Epubl*
 //#UC END# *47541E17024Epubl*
 end;//Tl3InterfacedComponent

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , l3MemUtils
 , l3Interlocked
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *47541E17024Eimpl_uses*
 //#UC END# *47541E17024Eimpl_uses*
;

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

function Tl3InterfacedComponent.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* метод для реализации QueryInterface (Для перекрытия в потомках). }
//#UC START# *47D16038003C_47541E17024E_var*
//#UC END# *47D16038003C_47541E17024E_var*
begin
//#UC START# *47D16038003C_47541E17024E_impl*
 Pointer(Obj) := nil;
 Result.SetNOINTERFACE;
//#UC END# *47D16038003C_47541E17024E_impl*
end;//Tl3InterfacedComponent.COMQueryInterface

constructor Tl3InterfacedComponent.CreateX;
//#UC START# *47D16214006E_47541E17024E_var*
//#UC END# *47D16214006E_47541E17024E_var*
begin
//#UC START# *47D16214006E_47541E17024E_impl*
 Create(nil);
//#UC END# *47D16214006E_47541E17024E_impl*
end;//Tl3InterfacedComponent.CreateX

function Tl3InterfacedComponent.QueryInterface(const IID: TGUID;
 out Obj): HResult;
//#UC START# *47D160620295_47541E17024E_var*
var
 l_Res : Tl3HResult;
//#UC END# *47D160620295_47541E17024E_var*
begin
//#UC START# *47D160620295_47541E17024E_impl*
 Result := inherited QueryInterface(IID, Obj);
 if l3IFail(Result) then
 begin
  l_Res := COMQueryInterface(Tl3GUID_C(IID), Obj);
  Result := l_Res.Res
 end;//l3IFail(Result)
//#UC END# *47D160620295_47541E17024E_impl*
end;//Tl3InterfacedComponent.QueryInterface

//#UC START# *47541E17024Eimpl*
//#UC END# *47541E17024Eimpl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Tl3InterfacedComponent);
 {* Регистрация Tl3InterfacedComponent }
{$IfEnd} // NOT Defined(NoScripts)

end.
