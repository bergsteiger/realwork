unit nsPromptContextFilterParams;
 {* Коллеги, это что? }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsPromptContextFilterParams.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsPromptContextFilterParams" MUID: (4906D40F0363)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , l3CacheableBase
 , l3TreeInterfaces
 , Il3ContextFilterParamsNotifierPtrList
 , l3Interfaces
;

type
 TnsPromptContextFilterParams = class(Tl3CacheableBase, Il3ContextFilterParamsNotifySource, Il3ContextFilterParams)
  {* Коллеги, это что? }
  private
   f_Subscribers: TIl3ContextFilterParamsNotifierPtrList;
  private
   procedure NotifySubscribers;
    {* Уведомляет подписчиков, о чём? }
  protected
   function WordPosition: Tl3WordPosition;
   function WordOrder: Tl3WordOrder;
   function TreeLevelDist: Tl3TreeLevelDist;
   procedure Subscribe(const aSubscriber: Il3ContextFilterParamsNotifier);
   procedure UnSubscribe(const aSubscriber: Il3ContextFilterParamsNotifier);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   class function Make: Il3ContextFilterParams; reintroduce;
    {* Создаёт дерево }
 end;//TnsPromptContextFilterParams
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , SysUtils
 //#UC START# *4906D40F0363impl_uses*
 //#UC END# *4906D40F0363impl_uses*
;

class function TnsPromptContextFilterParams.Make: Il3ContextFilterParams;
 {* Создаёт дерево }
var
 l_Inst : TnsPromptContextFilterParams;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsPromptContextFilterParams.Make

procedure TnsPromptContextFilterParams.NotifySubscribers;
 {* Уведомляет подписчиков, о чём? }
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
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4906D40F0363_var*
//#UC END# *479731C50290_4906D40F0363_var*
begin
//#UC START# *479731C50290_4906D40F0363_impl*
 FreeAndNil(f_Subscribers);
 inherited;
//#UC END# *479731C50290_4906D40F0363_impl*
end;//TnsPromptContextFilterParams.Cleanup
{$IfEnd} // NOT Defined(Admin)

end.
