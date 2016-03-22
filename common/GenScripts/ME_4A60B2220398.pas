{$IfNDef l3COMQueryInterface_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3COMQueryInterface.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "l3COMQueryInterface" MUID: (4A60B2220398)
// Имя типа: "_l3COMQueryInterface_"

{$Define l3COMQueryInterface_imp}

 _l3COMQueryInterface_ = class(_l3COMQueryInterface_Parent_)
  protected
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; virtual;
    {* Реализация запроса интерфейса }
  public
   function QueryInterface(const IID: TGUID;
    out Obj): HResult; override;
    {* Приводит базовый интерфейс к запрашиваемуму, если это возможно. }
 end;//_l3COMQueryInterface_

{$Else l3COMQueryInterface_imp}

{$IfNDef l3COMQueryInterface_imp_impl}

{$Define l3COMQueryInterface_imp_impl}

function _l3COMQueryInterface_.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_4A60B2220398_var*
//#UC END# *4A60B23E00C3_4A60B2220398_var*
begin
//#UC START# *4A60B23E00C3_4A60B2220398_impl*
 Result.SetNoInterface;
//#UC END# *4A60B23E00C3_4A60B2220398_impl*
end;//_l3COMQueryInterface_.COMQueryInterface

function _l3COMQueryInterface_.QueryInterface(const IID: TGUID;
 out Obj): HResult;
 {* Приводит базовый интерфейс к запрашиваемуму, если это возможно. }
//#UC START# *47A0AD3A01F7_4A60B2220398_var*
var
 l_Res : Tl3HResult;
//#UC END# *47A0AD3A01F7_4A60B2220398_var*
begin
//#UC START# *47A0AD3A01F7_4A60B2220398_impl*
 Result := inherited QueryInterface(IID, Obj);
 if l3IFail(Result) then
 begin
  l_Res := COMQueryInterface(Tl3GUID_C(IID), Obj);
  Result := l_Res.Res;
 end;//l3IFail(Result)
//#UC END# *47A0AD3A01F7_4A60B2220398_impl*
end;//_l3COMQueryInterface_.QueryInterface

{$EndIf l3COMQueryInterface_imp_impl}

{$EndIf l3COMQueryInterface_imp}

