{$IfNDef atNamedParametersList_imp}

// Модуль: "w:\quality\test\garant6x\AdapterTest\CoreObjects\atNamedParametersList.imp.pas"
// Стереотип: "Impurity"

{$Define atNamedParametersList_imp}

type
 EParameterNotExists = class(Exception)
 end;//EParameterNotExists

 CNamedParameter = class of _NamedParameter_;

 _atNamedParametersList_ = class(_atNamedParametersList_Parent_)
  private
   f_Parameters: TatStringListWithOwn;
  protected
   function pm_GetCount: Integer;
   function pm_GetParamType: CNamedParameter; virtual;
   function pm_GetParamByName(const aName: AnsiString): _NamedParameter_;
   function pm_GetParamByIndex(anIndex: Integer): _NamedParameter_;
  public
   destructor destroy; override;
   procedure Add(const aParam: _NamedParameter_);
   constructor Create; reintroduce;
   procedure AddAlias(const aParamName: AnsiString;
    const anAliasName: AnsiString); virtual;
  public
   property Count: Integer
    read pm_GetCount;
   property ParamType: CNamedParameter
    read pm_GetParamType;
   property ParamByName[const aName: AnsiString]: _NamedParameter_
    read pm_GetParamByName;
   property ParamByIndex[anIndex: Integer]: _NamedParameter_
    read pm_GetParamByIndex;
 end;//_atNamedParametersList_

{$Else atNamedParametersList_imp}

{$IfNDef atNamedParametersList_imp_impl}

{$Define atNamedParametersList_imp_impl}

function _atNamedParametersList_.pm_GetCount: Integer;
//#UC START# *4807787D0165_4807779F01CAget_var*
//#UC END# *4807787D0165_4807779F01CAget_var*
begin
//#UC START# *4807787D0165_4807779F01CAget_impl*
  Result := f_Parameters.Count;
//#UC END# *4807787D0165_4807779F01CAget_impl*
end;//_atNamedParametersList_.pm_GetCount

function _atNamedParametersList_.pm_GetParamType: CNamedParameter;
//#UC START# *483D5AEF0060_4807779F01CAget_var*
//#UC END# *483D5AEF0060_4807779F01CAget_var*
begin
//#UC START# *483D5AEF0060_4807779F01CAget_impl*
  Result := _NamedParameter_;
//#UC END# *483D5AEF0060_4807779F01CAget_impl*
end;//_atNamedParametersList_.pm_GetParamType

function _atNamedParametersList_.pm_GetParamByName(const aName: AnsiString): _NamedParameter_;
//#UC START# *480777E80008_4807779F01CAget_var*
  var
    i : integer;
//#UC END# *480777E80008_4807779F01CAget_var*
begin
//#UC START# *480777E80008_4807779F01CAget_impl*
  i := f_Parameters.IndexOf(aName);
  if (i = -1) then
    Raise EParameterNotExists.CreateFmt('Параметр с именем %s отсутствует!', [aName]);
  Result := (f_Parameters.Objects[i] as _NamedParameter_);
//#UC END# *480777E80008_4807779F01CAget_impl*
end;//_atNamedParametersList_.pm_GetParamByName

function _atNamedParametersList_.pm_GetParamByIndex(anIndex: Integer): _NamedParameter_;
//#UC START# *480778200358_4807779F01CAget_var*
//#UC END# *480778200358_4807779F01CAget_var*
begin
//#UC START# *480778200358_4807779F01CAget_impl*
  Result := (f_Parameters.Objects[anIndex] as _NamedParameter_);
//#UC END# *480778200358_4807779F01CAget_impl*
end;//_atNamedParametersList_.pm_GetParamByIndex

destructor _atNamedParametersList_.destroy;
//#UC START# *48077863002D_4807779F01CA_var*
//#UC END# *48077863002D_4807779F01CA_var*
begin
//#UC START# *48077863002D_4807779F01CA_impl*
  FreeAndNil(f_Parameters);
  inherited;
//#UC END# *48077863002D_4807779F01CA_impl*
end;//_atNamedParametersList_.destroy

procedure _atNamedParametersList_.Add(const aParam: _NamedParameter_);
//#UC START# *480778A700B7_4807779F01CA_var*
//#UC END# *480778A700B7_4807779F01CA_var*
begin
//#UC START# *480778A700B7_4807779F01CA_impl*
  f_Parameters.AddObject(aParam.Name, aParam);
//#UC END# *480778A700B7_4807779F01CA_impl*
end;//_atNamedParametersList_.Add

constructor _atNamedParametersList_.Create;
//#UC START# *48077A750096_4807779F01CA_var*
//#UC END# *48077A750096_4807779F01CA_var*
begin
//#UC START# *48077A750096_4807779F01CA_impl*
  inherited;
  f_Parameters := TatStringListWithOwn.Create(true);
  f_Parameters.CaseSensitive := true;
  f_Parameters.Duplicates := dupError;
//#UC END# *48077A750096_4807779F01CA_impl*
end;//_atNamedParametersList_.Create

procedure _atNamedParametersList_.AddAlias(const aParamName: AnsiString;
 const anAliasName: AnsiString);
//#UC START# *50363C5402FA_4807779F01CA_var*
//#UC END# *50363C5402FA_4807779F01CA_var*
begin
//#UC START# *50363C5402FA_4807779F01CA_impl*
  f_Parameters.AddObject(anAliasName, ParamByName[aParamName].Use);
//#UC END# *50363C5402FA_4807779F01CA_impl*
end;//_atNamedParametersList_.AddAlias

{$EndIf atNamedParametersList_imp_impl}

{$EndIf atNamedParametersList_imp}

