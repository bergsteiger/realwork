{$IfNDef l3FakeImpurity_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3FakeImpurity.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "l3FakeImpurity" MUID: (MSMA75ED92E7AC6)
// Имя типа: "_l3FakeImpurity_"

{$Define l3FakeImpurity_imp}

 _l3FakeImpurity_ = class(_l3FakeImpurity_Parent_)
  private
   f_Prop: Integer;
  protected
   procedure pm_SetProp(aValue: Integer); virtual;
   function pm_GetIndexedProp(anIndex: Integer): TObject; virtual;
   procedure pm_SetIndexedProp(anIndex: Integer;
    aValue: TObject); virtual;
   function pm_GetPropWithStored: AnsiString; virtual;
   procedure pm_SetPropWithStored(const aValue: AnsiString); virtual;
   function PropWithStoredStored: Boolean;
    {* Функция определяющая, что свойство PropWithStored сохраняется }
  public
   function MixInAbstractMethod: AnsiString; virtual; abstract;
  public
   property Prop: Integer
    read f_Prop
    write pm_SetProp
    default 0;
   property IndexedProp[anIndex: Integer]: TObject
    read pm_GetIndexedProp
    write pm_SetIndexedProp;
   property PropWithStored: AnsiString
    read pm_GetPropWithStored
    write pm_SetPropWithStored
    stored PropWithStoredStored;
 end;//_l3FakeImpurity_

{$Else l3FakeImpurity_imp}

{$IfNDef l3FakeImpurity_imp_impl}

{$Define l3FakeImpurity_imp_impl}

procedure _l3FakeImpurity_.pm_SetProp(aValue: Integer);
//#UC START# *MSMF6124F0CF051_MSMA75ED92E7AC6set_var*
//#UC END# *MSMF6124F0CF051_MSMA75ED92E7AC6set_var*
begin
//#UC START# *MSMF6124F0CF051_MSMA75ED92E7AC6set_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSMF6124F0CF051_MSMA75ED92E7AC6set_impl*
end;//_l3FakeImpurity_.pm_SetProp

function _l3FakeImpurity_.pm_GetIndexedProp(anIndex: Integer): TObject;
//#UC START# *MSM3C90672D7081_MSMA75ED92E7AC6get_var*
//#UC END# *MSM3C90672D7081_MSMA75ED92E7AC6get_var*
begin
//#UC START# *MSM3C90672D7081_MSMA75ED92E7AC6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSM3C90672D7081_MSMA75ED92E7AC6get_impl*
end;//_l3FakeImpurity_.pm_GetIndexedProp

procedure _l3FakeImpurity_.pm_SetIndexedProp(anIndex: Integer;
 aValue: TObject);
//#UC START# *MSM3C90672D7081_MSMA75ED92E7AC6set_var*
//#UC END# *MSM3C90672D7081_MSMA75ED92E7AC6set_var*
begin
//#UC START# *MSM3C90672D7081_MSMA75ED92E7AC6set_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSM3C90672D7081_MSMA75ED92E7AC6set_impl*
end;//_l3FakeImpurity_.pm_SetIndexedProp

function _l3FakeImpurity_.pm_GetPropWithStored: AnsiString;
//#UC START# *MSMBF1358461D90_MSMA75ED92E7AC6get_var*
//#UC END# *MSMBF1358461D90_MSMA75ED92E7AC6get_var*
begin
//#UC START# *MSMBF1358461D90_MSMA75ED92E7AC6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSMBF1358461D90_MSMA75ED92E7AC6get_impl*
end;//_l3FakeImpurity_.pm_GetPropWithStored

procedure _l3FakeImpurity_.pm_SetPropWithStored(const aValue: AnsiString);
//#UC START# *MSMBF1358461D90_MSMA75ED92E7AC6set_var*
//#UC END# *MSMBF1358461D90_MSMA75ED92E7AC6set_var*
begin
//#UC START# *MSMBF1358461D90_MSMA75ED92E7AC6set_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSMBF1358461D90_MSMA75ED92E7AC6set_impl*
end;//_l3FakeImpurity_.pm_SetPropWithStored

function _l3FakeImpurity_.PropWithStoredStored: Boolean;
 {* Функция определяющая, что свойство PropWithStored сохраняется }
//#UC START# *MSMBF1358461D90Stored_MSMA75ED92E7AC6_var*
//#UC END# *MSMBF1358461D90Stored_MSMA75ED92E7AC6_var*
begin
//#UC START# *MSMBF1358461D90Stored_MSMA75ED92E7AC6_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSMBF1358461D90Stored_MSMA75ED92E7AC6_impl*
end;//_l3FakeImpurity_.PropWithStoredStored

{$EndIf l3FakeImpurity_imp_impl}

{$EndIf l3FakeImpurity_imp}

