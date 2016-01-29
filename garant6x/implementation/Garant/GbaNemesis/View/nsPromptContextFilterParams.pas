unit nsPromptContextFilterParams;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsPromptContextFilterParams.pas"
// Начат: 2008/06/25 08:04:46
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::BaseSearch::TnsPromptContextFilterParams
//
// Коллеги, это что?
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  l3CacheableBase,
  l3TreeInterfaces,
  Il3ContextFilterParamsNotifierPtrList,
  l3Interfaces
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 TnsPromptContextFilterParams = class(Tl3CacheableBase, Il3ContextFilterParamsNotifySource, Il3ContextFilterParams)
  {* Коллеги, это что? }
 private
 // private fields
   f_Subscribers : TIl3ContextFilterParamsNotifierPtrList;
 private
 // private methods
   procedure NotifySubscribers;
     {* Уведомляет подписчиков, о чём? }
 protected
 // realized methods
   function WordPosition: Tl3WordPosition;
   function WordOrder: Tl3WordOrder;
   function TreeLevelDist: Tl3TreeLevelDist;
   procedure Subscribe(const aSubscriber: Il3ContextFilterParamsNotifier);
   procedure UnSubscribe(const aSubscriber: Il3ContextFilterParamsNotifier);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   class function Make: Il3ContextFilterParams; reintroduce;
     {* Создаёт дерево }
 end;//TnsPromptContextFilterParams
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  SysUtils
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

// start class TnsPromptContextFilterParams

class function TnsPromptContextFilterParams.Make: Il3ContextFilterParams;
var
 l_Inst : TnsPromptContextFilterParams;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TnsPromptContextFilterParams.NotifySubscribers;
//#UC START# *49089FF80356_4906D40F0363_var*
var
 l_Index : Integer;
//#UC END# *49089FF80356_4906D40F0363_var*
begin
//#UC START# *49089FF80356_4906D40F0363_impl*
 if (f_Subscribers <> nil) then
  for l_Index := 0 to Pred(f_Subscribers.Count) do
   f_Subscribers[l_Index].ParamsChanged;
//#UC END# *49089FF80356_4906D40F0363_impl*
end;//TnsPromptContextFilterParams.NotifySubscribers

function TnsPromptContextFilterParams.WordPosition: Tl3WordPosition;
//#UC START# *47724E930100_4906D40F0363_var*
//#UC END# *47724E930100_4906D40F0363_var*
begin
//#UC START# *47724E930100_4906D40F0363_impl*
 Result := wpAtBeginWord;
//#UC END# *47724E930100_4906D40F0363_impl*
end;//TnsPromptContextFilterParams.WordPosition

function TnsPromptContextFilterParams.WordOrder: Tl3WordOrder;
//#UC START# *47724E9D014D_4906D40F0363_var*
//#UC END# *47724E9D014D_4906D40F0363_var*
begin
//#UC START# *47724E9D014D_4906D40F0363_impl*
 Result := woAnyOrder;
//#UC END# *47724E9D014D_4906D40F0363_impl*
end;//TnsPromptContextFilterParams.WordOrder

function TnsPromptContextFilterParams.TreeLevelDist: Tl3TreeLevelDist;
//#UC START# *47724EA70354_4906D40F0363_var*
//#UC END# *47724EA70354_4906D40F0363_var*
begin
//#UC START# *47724EA70354_4906D40F0363_impl*
 Result := tldAllLevels;
//#UC END# *47724EA70354_4906D40F0363_impl*
end;//TnsPromptContextFilterParams.TreeLevelDist

procedure TnsPromptContextFilterParams.Subscribe(const aSubscriber: Il3ContextFilterParamsNotifier);
//#UC START# *47724F120028_4906D40F0363_var*
//#UC END# *47724F120028_4906D40F0363_var*
begin
//#UC START# *47724F120028_4906D40F0363_impl*
 if (f_Subscribers = nil) then
  f_Subscribers := TIl3ContextFilterParamsNotifierPtrList.Make;
 if f_Subscribers.IndexOf(aSubscriber) = -1 then
  f_Subscribers.Add(aSubscriber);
//#UC END# *47724F120028_4906D40F0363_impl*
end;//TnsPromptContextFilterParams.Subscribe

procedure TnsPromptContextFilterParams.UnSubscribe(const aSubscriber: Il3ContextFilterParamsNotifier);
//#UC START# *47724F1E0180_4906D40F0363_var*
//#UC END# *47724F1E0180_4906D40F0363_var*
begin
//#UC START# *47724F1E0180_4906D40F0363_impl*
 if (f_Subscribers <> nil) then
  f_Subscribers.Remove(aSubscriber);
//#UC END# *47724F1E0180_4906D40F0363_impl*
end;//TnsPromptContextFilterParams.UnSubscribe

procedure TnsPromptContextFilterParams.Cleanup;
//#UC START# *479731C50290_4906D40F0363_var*
//#UC END# *479731C50290_4906D40F0363_var*
begin
//#UC START# *479731C50290_4906D40F0363_impl*
 FreeAndNil(f_Subscribers);
 inherited;
//#UC END# *479731C50290_4906D40F0363_impl*
end;//TnsPromptContextFilterParams.Cleanup

{$IfEnd} //not Admin

end.