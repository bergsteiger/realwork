unit msmWordsByName;

// Модуль: "w:\common\components\gui\Garant\msm\msmWordsByName.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmWordsByName" MUID: (57D6771E001F)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Core
 , l3Except
 , Classes
 , SyncObjs
;

type
 _KeyType_ = Il3CString;
 _ValueType_ = TtfwWord;
 {$Include w:\common\components\rtl\Garant\L3\l3Map.imp.pas}
 _seCriticalSectionHolder_Parent_ = _l3Map_;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolder.imp.pas}
 TmsmWordsByName = {final} class(_seCriticalSectionHolder_)
  public
   class function Instance: TmsmWordsByName;
    {* Метод получения экземпляра синглетона TmsmWordsByName }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TmsmWordsByName

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57D6771E001Fimpl_uses*
 , l3String
 //#UC END# *57D6771E001Fimpl_uses*
;

var g_TmsmWordsByName: TmsmWordsByName = nil;
 {* Экземпляр синглетона TmsmWordsByName }

procedure TmsmWordsByNameFree;
 {* Метод освобождения экземпляра синглетона TmsmWordsByName }
begin
 l3Free(g_TmsmWordsByName);
end;//TmsmWordsByNameFree

function CompareKeys(const aA: _KeyType_;
 const aB: _KeyType_): Integer;
//#UC START# *5609091B00C0_57D6771E001F_var*
//#UC END# *5609091B00C0_57D6771E001F_var*
begin
//#UC START# *5609091B00C0_57D6771E001F_impl*
 Result := l3Compare(l3PCharLen(aA), l3PCharLen(aB));
//#UC END# *5609091B00C0_57D6771E001F_impl*
end;//CompareKeys

type _Instance_R_ = TmsmWordsByName;

{$Include w:\common\components\rtl\Garant\L3\l3Map.imp.pas}

{$Include w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolder.imp.pas}

class function TmsmWordsByName.Instance: TmsmWordsByName;
 {* Метод получения экземпляра синглетона TmsmWordsByName }
begin
 if (g_TmsmWordsByName = nil) then
 begin
  l3System.AddExitProc(TmsmWordsByNameFree);
  g_TmsmWordsByName := Create;
 end;
 Result := g_TmsmWordsByName;
end;//TmsmWordsByName.Instance

class function TmsmWordsByName.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TmsmWordsByName <> nil;
end;//TmsmWordsByName.Exists

end.
