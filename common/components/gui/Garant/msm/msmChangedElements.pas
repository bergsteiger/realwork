unit msmChangedElements;

// Модуль: "w:\common\components\gui\Garant\msm\msmChangedElements.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmChangedElements" MUID: (57F7BA1703A5)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmChangedElementsPrim
;

type
 TmsmChangedElements = class(TmsmChangedElementsPrim)
  public
   procedure Save;
   class function Instance: TmsmChangedElements;
    {* Метод получения экземпляра синглетона TmsmChangedElements }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TmsmChangedElements

implementation

uses
 l3ImplUses
 , msmModelElementMethodCaller
 {$If NOT Defined(NoScripts)}
 , msmChangedElementsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwWordRefList
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwWordsIterator
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
 //#UC START# *57F7BA1703A5impl_uses*
 , tfwScriptingInterfaces
 //#UC END# *57F7BA1703A5impl_uses*
;

var g_TmsmChangedElements: TmsmChangedElements = nil;
 {* Экземпляр синглетона TmsmChangedElements }

procedure TmsmChangedElementsFree;
 {* Метод освобождения экземпляра синглетона TmsmChangedElements }
begin
 l3Free(g_TmsmChangedElements);
end;//TmsmChangedElementsFree

procedure TmsmChangedElements.Save;
//#UC START# *57E105510123_57F7BA1703A5_var*
var
 l_List : TtfwWordRefList;
 l_Index : Integer;
//#UC END# *57E105510123_57F7BA1703A5_var*
begin
//#UC START# *57E105510123_57F7BA1703A5_impl*
 if Self.Empty then
  Exit;
 Lock;
 try
  l_List := TtfwWordRefList.Create;
  try
   for l_Index := 0 to Pred(Self.Count) do
    l_List.Add(Self.Items[l_Index]);
   TmsmModelElementMethodCaller.Call([TtfwStackValue_C(TtfwWordsIterator.Make(l_List))], 'SaveElements'); 
  finally
   FreeAndNil(l_List);
  end;//try..finally
  Self.Clear;
 finally
  Unlock;
 end;//try..finally
//#UC END# *57E105510123_57F7BA1703A5_impl*
end;//TmsmChangedElements.Save

class function TmsmChangedElements.Instance: TmsmChangedElements;
 {* Метод получения экземпляра синглетона TmsmChangedElements }
begin
 if (g_TmsmChangedElements = nil) then
 begin
  l3System.AddExitProc(TmsmChangedElementsFree);
  g_TmsmChangedElements := Create;
 end;
 Result := g_TmsmChangedElements;
end;//TmsmChangedElements.Instance

class function TmsmChangedElements.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TmsmChangedElements <> nil;
end;//TmsmChangedElements.Exists

end.
