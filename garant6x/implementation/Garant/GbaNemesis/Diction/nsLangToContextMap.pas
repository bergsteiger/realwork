unit nsLangToContextMap;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Diction\nsLangToContextMap.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsLangToContextMap" MUID: (490837B901D4)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3CProtoObject
 , l3TreeInterfaces
 , DictionInterfaces
 , nsLangList
 {$If Defined(Nemesis)}
 , InscContextFilterStateList
 {$IfEnd} // Defined(Nemesis)
 , bsTypes
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
;

type
 TnsLangToContextMap = class(Tl3CProtoObject, Il3ContextFilterNotifier, InsLangToContextMap)
  private
   f_Langs: TnsLangList;
   f_Contexts: TInscContextFilterStateList;
   f_NotifySource: Pointer;
  private
   function Add(aLang: TbsLanguage;
    const aContextState: InscContextFilterState): Integer;
  protected
   procedure RequestReapply;
    {* Желательно переприменить фильтр. }
   procedure RequestClearAndTurnOff;
    {* Дерево выключило на себе фильтр. }
   procedure RequestCheckValid;
    {* Дерево поменялось - нужно проверить валидность фильтра. }
   function pm_GetByLang(aLang: TbsLanguage): InscContextFilterState;
   procedure pm_SetByLang(aLang: TbsLanguage;
    const aValue: InscContextFilterState);
   procedure Subscribe(const aNotifySource: Il3ContextFilterNotifySource);
   procedure Unsubscribe(const aNotifySource: Il3ContextFilterNotifySource);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   class function Make(const aNotifySource: Il3ContextFilterNotifySource): InsLangToContextMap;
   constructor Create(const aNotifySource: Il3ContextFilterNotifySource); reintroduce;
 end;//TnsLangToContextMap
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 {$If Defined(Nemesis)}
 , nscContextFilterState
 {$IfEnd} // Defined(Nemesis)
;

class function TnsLangToContextMap.Make(const aNotifySource: Il3ContextFilterNotifySource): InsLangToContextMap;
//#UC START# *52D3E220005C_490837B901D4_var*
var
 l_Class: TnsLangToContextMap;
//#UC END# *52D3E220005C_490837B901D4_var*
begin
//#UC START# *52D3E220005C_490837B901D4_impl*
 l_Class := Create(aNotifySource);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;
//#UC END# *52D3E220005C_490837B901D4_impl*
end;//TnsLangToContextMap.Make

constructor TnsLangToContextMap.Create(const aNotifySource: Il3ContextFilterNotifySource);
//#UC START# *490843AA003A_490837B901D4_var*
//#UC END# *490843AA003A_490837B901D4_var*
begin
//#UC START# *490843AA003A_490837B901D4_impl*
 inherited Create;
 f_Langs := TnsLangList.Create;
 f_Contexts := TInscContextFilterStateList.Make;
 if Assigned(aNotifySource) then
  Subscribe(aNotifySource);
//#UC END# *490843AA003A_490837B901D4_impl*
end;//TnsLangToContextMap.Create

function TnsLangToContextMap.Add(aLang: TbsLanguage;
 const aContextState: InscContextFilterState): Integer;
//#UC START# *490844660228_490837B901D4_var*
//#UC END# *490844660228_490837B901D4_var*
begin
//#UC START# *490844660228_490837B901D4_impl*
 Result := f_Langs.IndexOf(aLang);
 if Result = -1 then
 begin
  Result := f_Langs.Add(aLang);
  f_Contexts.Add(aContextState);
 end;//if f_Langs.IndexOf(aLang) = -1 then
//#UC END# *490844660228_490837B901D4_impl*
end;//TnsLangToContextMap.Add

procedure TnsLangToContextMap.RequestReapply;
 {* Желательно переприменить фильтр. }
//#UC START# *477250FC0040_490837B901D4_var*
//#UC END# *477250FC0040_490837B901D4_var*
begin
//#UC START# *477250FC0040_490837B901D4_impl*
 // DoNothing
//#UC END# *477250FC0040_490837B901D4_impl*
end;//TnsLangToContextMap.RequestReapply

procedure TnsLangToContextMap.RequestClearAndTurnOff;
 {* Дерево выключило на себе фильтр. }
//#UC START# *4772510D0043_490837B901D4_var*
var
 l_IDX: Integer;
//#UC END# *4772510D0043_490837B901D4_var*
begin
//#UC START# *4772510D0043_490837B901D4_impl*
 for l_IDX := 0 to f_Contexts.Count - 1 do
  if Assigned(f_Contexts.Items[l_IDX]) then
   //with InscContextFilterState(f_Contexts.Items[l_IDX]) do
   f_Contexts.Items[l_IDX] := TnscContextFilterState.Make(False, nil, 0);
//#UC END# *4772510D0043_490837B901D4_impl*
end;//TnsLangToContextMap.RequestClearAndTurnOff

procedure TnsLangToContextMap.RequestCheckValid;
 {* Дерево поменялось - нужно проверить валидность фильтра. }
//#UC START# *4772511D0316_490837B901D4_var*
//#UC END# *4772511D0316_490837B901D4_var*
begin
//#UC START# *4772511D0316_490837B901D4_impl*
 // DoNothing
//#UC END# *4772511D0316_490837B901D4_impl*
end;//TnsLangToContextMap.RequestCheckValid

function TnsLangToContextMap.pm_GetByLang(aLang: TbsLanguage): InscContextFilterState;
//#UC START# *52D3BE04039D_490837B901D4get_var*
var
 l_Index : Integer;
//#UC END# *52D3BE04039D_490837B901D4get_var*
begin
//#UC START# *52D3BE04039D_490837B901D4get_impl*
 l_Index := f_Langs.IndexOf(aLang);
 if l_Index = -1 then
  l_Index := Add(aLang, TnscContextFilterState.Make(False, nil, 0));
 Result := f_Contexts[l_Index];
//#UC END# *52D3BE04039D_490837B901D4get_impl*
end;//TnsLangToContextMap.pm_GetByLang

procedure TnsLangToContextMap.pm_SetByLang(aLang: TbsLanguage;
 const aValue: InscContextFilterState);
//#UC START# *52D3BE04039D_490837B901D4set_var*
var
 l_Index : Integer;
//#UC END# *52D3BE04039D_490837B901D4set_var*
begin
//#UC START# *52D3BE04039D_490837B901D4set_impl*
 l_Index := f_Langs.IndexOf(aLang);
 if l_Index = -1 then
  Add(aLang, aValue)
 else
  f_Contexts[l_Index] := aValue;
//#UC END# *52D3BE04039D_490837B901D4set_impl*
end;//TnsLangToContextMap.pm_SetByLang

procedure TnsLangToContextMap.Subscribe(const aNotifySource: Il3ContextFilterNotifySource);
//#UC START# *52D3D7D60242_490837B901D4_var*
//#UC END# *52D3D7D60242_490837B901D4_var*
begin
//#UC START# *52D3D7D60242_490837B901D4_impl*
 Assert(aNotifySource <> nil);
 f_NotifySource := Pointer(aNotifySource);
 aNotifySource.SubscribeToContextFilter(Self);
//#UC END# *52D3D7D60242_490837B901D4_impl*
end;//TnsLangToContextMap.Subscribe

procedure TnsLangToContextMap.Unsubscribe(const aNotifySource: Il3ContextFilterNotifySource);
//#UC START# *52D4E4D40318_490837B901D4_var*
//#UC END# *52D4E4D40318_490837B901D4_var*
begin
//#UC START# *52D4E4D40318_490837B901D4_impl*
 Assert(Pointer(aNotifySource) = f_NotifySource);
 if Assigned(aNotifySource) then
  aNotifySource.UnSubscribeFromContextFilter(Self);
 f_NotifySource := nil;
//#UC END# *52D4E4D40318_490837B901D4_impl*
end;//TnsLangToContextMap.Unsubscribe

procedure TnsLangToContextMap.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_490837B901D4_var*
//#UC END# *479731C50290_490837B901D4_var*
begin
//#UC START# *479731C50290_490837B901D4_impl*
 FreeAndNil(f_Langs);
 FreeAndNil(f_Contexts);
 inherited;
//#UC END# *479731C50290_490837B901D4_impl*
end;//TnsLangToContextMap.Cleanup
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
