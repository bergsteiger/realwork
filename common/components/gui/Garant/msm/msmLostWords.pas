unit msmLostWords;

// Модуль: "w:\common\components\gui\Garant\msm\msmLostWords.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmLostWords" MUID: (57F642A60339)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3StringList
 , l3Interfaces
 , SyncObjs
;

type
 _seCriticalSectionHolder_Parent_ = Tl3StringList;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolder.imp.pas}
 TmsmLostWords = class(_seCriticalSectionHolder_)
  protected
   procedure InitFields; override;
  public
   procedure Add(const aValue: Il3CString);
   function FindData(const anItem: Il3CString;
    var theIndex: Integer): Boolean;
   class function Instance: TmsmLostWords;
    {* Метод получения экземпляра синглетона TmsmLostWords }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TmsmLostWords

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Variant
 , l3Memory
 , l3Base
 //#UC START# *57F642A60339impl_uses*
 , l3Types
 , l3String
 //#UC END# *57F642A60339impl_uses*
;

var g_TmsmLostWords: TmsmLostWords = nil;
 {* Экземпляр синглетона TmsmLostWords }

procedure TmsmLostWordsFree;
 {* Метод освобождения экземпляра синглетона TmsmLostWords }
begin
 l3Free(g_TmsmLostWords);
end;//TmsmLostWordsFree

{$Include w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolder.imp.pas}

procedure TmsmLostWords.Add(const aValue: Il3CString);
//#UC START# *57F642DD00D6_57F642A60339_var*
//#UC END# *57F642DD00D6_57F642A60339_var*
begin
//#UC START# *57F642DD00D6_57F642A60339_impl*
 Lock;
 try
  inherited Add(aValue);
 finally
  Unlock;
 end;//try..finally
//#UC END# *57F642DD00D6_57F642A60339_impl*
end;//TmsmLostWords.Add

function TmsmLostWords.FindData(const anItem: Il3CString;
 var theIndex: Integer): Boolean;
//#UC START# *57F643280126_57F642A60339_var*
//#UC END# *57F643280126_57F642A60339_var*
begin
//#UC START# *57F643280126_57F642A60339_impl*
 Lock;
 try
  Result := inherited FindData(l3PCharLen(anItem), theIndex);
 finally
  Unlock;
 end;//try..finally
//#UC END# *57F643280126_57F642A60339_impl*
end;//TmsmLostWords.FindData

class function TmsmLostWords.Instance: TmsmLostWords;
 {* Метод получения экземпляра синглетона TmsmLostWords }
begin
 if (g_TmsmLostWords = nil) then
 begin
  l3System.AddExitProc(TmsmLostWordsFree);
  g_TmsmLostWords := Create;
 end;
 Result := g_TmsmLostWords;
end;//TmsmLostWords.Instance

class function TmsmLostWords.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TmsmLostWords <> nil;
end;//TmsmLostWords.Exists

procedure TmsmLostWords.InitFields;
//#UC START# *47A042E100E2_57F642A60339_var*
//#UC END# *47A042E100E2_57F642A60339_var*
begin
//#UC START# *47A042E100E2_57F642A60339_impl*
 inherited;
 Sorted := true;
 Duplicates := l3_dupIgnore;
//#UC END# *47A042E100E2_57F642A60339_impl*
end;//TmsmLostWords.InitFields

end.
