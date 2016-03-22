{$IfNDef l3Unknown_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3Unknown.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "l3Unknown" MUID: (47913F970159)
// Имя типа: "_l3Unknown_"

{$Define l3Unknown_imp}

 _l3UnknownPrim_Parent_ = _l3Unknown_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3UnknownPrim.imp.pas}
 _l3Unknown_ = class(_l3UnknownPrim_)
  {* В этом классе собираем методы, которые запрещено перекрывать и вызывать напрямую. }
  public
   class function NewInstance: TObject;
   class procedure FreeInstance;
   class procedure AfterConstruction;
   class procedure BeforeDestruction;
   destructor Destroy;
 end;//_l3Unknown_

{$Else l3Unknown_imp}

{$IfNDef l3Unknown_imp_impl}

{$Define l3Unknown_imp_impl}

{$Include w:\common\components\rtl\Garant\L3\l3UnknownPrim.imp.pas}

class function _l3Unknown_.NewInstance: TObject;
//#UC START# *47913FE900A2_47913F970159_var*
//#UC END# *47913FE900A2_47913F970159_var*
begin
//#UC START# *47913FE900A2_47913F970159_impl*
 assert(false, 'Unknown.NewInstance not implemented');
//#UC END# *47913FE900A2_47913F970159_impl*
end;//_l3Unknown_.NewInstance

class procedure _l3Unknown_.FreeInstance;
//#UC START# *4791403F035A_47913F970159_var*
//#UC END# *4791403F035A_47913F970159_var*
begin
//#UC START# *4791403F035A_47913F970159_impl*
 assert(false, 'Unknown.FreeInstance not implemented');
//#UC END# *4791403F035A_47913F970159_impl*
end;//_l3Unknown_.FreeInstance

class procedure _l3Unknown_.AfterConstruction;
//#UC START# *479140660154_47913F970159_var*
//#UC END# *479140660154_47913F970159_var*
begin
//#UC START# *479140660154_47913F970159_impl*
 assert(false, 'Unknown.AfterConstruction not implemented');
//#UC END# *479140660154_47913F970159_impl*
end;//_l3Unknown_.AfterConstruction

class procedure _l3Unknown_.BeforeDestruction;
//#UC START# *4791407A034E_47913F970159_var*
//#UC END# *4791407A034E_47913F970159_var*
begin
//#UC START# *4791407A034E_47913F970159_impl*
 assert(false, 'Unknown.BeforeDestruction not implemented');
//#UC END# *4791407A034E_47913F970159_impl*
end;//_l3Unknown_.BeforeDestruction

destructor _l3Unknown_.Destroy;
//#UC START# *4791409000A0_47913F970159_var*
//#UC END# *4791409000A0_47913F970159_var*
begin
//#UC START# *4791409000A0_47913F970159_impl*
 assert(false, 'Unknown.Destroy not implemented');
//#UC END# *4791409000A0_47913F970159_impl*
end;//_l3Unknown_.Destroy

{$EndIf l3Unknown_imp_impl}

{$EndIf l3Unknown_imp}

