unit msmWordsByUserNameIndex;

// Модуль: "w:\common\components\gui\Garant\msm\msmWordsByUserNameIndex.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmWordsByUserNameIndex" MUID: (57E50B7A0140)

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
 {$Include w:\common\components\rtl\Garant\L3\l3MultiMap.imp.pas}
 _seCriticalSectionHolder_Parent_ = _l3MultiMap_;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolder.imp.pas}
 TmsmWordsByUserNameIndex = class(_seCriticalSectionHolder_)
  public
   procedure Add(const aKey: Il3CString;
    aValue: TtfwWord);
   function FindWord(const aName: Il3CString): TtfwWord;
   class function CompareNames(const A: Il3CString;
    const B: Il3CString): Integer;
   function FindWords(const aName: Il3CString): ItfwArray;
   class function Instance: TmsmWordsByUserNameIndex;
    {* Метод получения экземпляра синглетона TmsmWordsByUserNameIndex }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TmsmWordsByUserNameIndex

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , msmWordsIndexPack
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57E50B7A0140impl_uses*
 , l3String
 , l3PointerUtils
 , tfwArray
 //#UC END# *57E50B7A0140impl_uses*
;

var g_TmsmWordsByUserNameIndex: TmsmWordsByUserNameIndex = nil;
 {* Экземпляр синглетона TmsmWordsByUserNameIndex }

procedure TmsmWordsByUserNameIndexFree;
 {* Метод освобождения экземпляра синглетона TmsmWordsByUserNameIndex }
begin
 l3Free(g_TmsmWordsByUserNameIndex);
end;//TmsmWordsByUserNameIndexFree

function CompareValues(const aA: _ValueType_;
 const aB: _ValueType_): Integer; forward;

function CompareKeys(const aA: _KeyType_;
 const aB: _KeyType_): Integer;
//#UC START# *5609091B00C0_57E50B7A0140_var*
//#UC END# *5609091B00C0_57E50B7A0140_var*
begin
//#UC START# *5609091B00C0_57E50B7A0140_impl*
 Result := TmsmWordsByUserNameIndex.CompareNames(aA, aB);
//#UC END# *5609091B00C0_57E50B7A0140_impl*
end;//CompareKeys

function CompareValues(const aA: _ValueType_;
 const aB: _ValueType_): Integer;
//#UC START# *57E50D7500A3_57E50B7A0140_var*
//#UC END# *57E50D7500A3_57E50B7A0140_var*
begin
//#UC START# *57E50D7500A3_57E50B7A0140_impl*
 Result := l3ComparePointers(aA.GetRefForCompare, aB.GetRefForCompare);
 Assert(false);
//#UC END# *57E50D7500A3_57E50B7A0140_impl*
end;//CompareValues

type _Instance_R_ = TmsmWordsByUserNameIndex;

{$Include w:\common\components\rtl\Garant\L3\l3MultiMap.imp.pas}

{$Include w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolder.imp.pas}

procedure TmsmWordsByUserNameIndex.Add(const aKey: Il3CString;
 aValue: TtfwWord);
//#UC START# *57E512D20247_57E50B7A0140_var*
//#UC END# *57E512D20247_57E50B7A0140_var*
begin
//#UC START# *57E512D20247_57E50B7A0140_impl*
 Lock;
 try
  inherited Add(aKey, aValue);
 finally
  Unlock;
 end;//try..finally
//#UC END# *57E512D20247_57E50B7A0140_impl*
end;//TmsmWordsByUserNameIndex.Add

function TmsmWordsByUserNameIndex.FindWord(const aName: Il3CString): TtfwWord;
//#UC START# *57E5169B0226_57E50B7A0140_var*
//#UC END# *57E5169B0226_57E50B7A0140_var*
begin
//#UC START# *57E5169B0226_57E50B7A0140_impl*
 Lock;
 try
  if Has(aName) then
   Result := ValueByKey(aName)
  else
   Result := nil; 
 finally
  Unlock;
 end;//try..finally
//#UC END# *57E5169B0226_57E50B7A0140_impl*
end;//TmsmWordsByUserNameIndex.FindWord

class function TmsmWordsByUserNameIndex.CompareNames(const A: Il3CString;
 const B: Il3CString): Integer;
//#UC START# *57E55E8403BB_57E50B7A0140_var*
//#UC END# *57E55E8403BB_57E50B7A0140_var*
begin
//#UC START# *57E55E8403BB_57E50B7A0140_impl*
 Result := l3Compare(l3PCharLen(A), l3PCharLen(B){, l3_siCaseUnsensitive});
//#UC END# *57E55E8403BB_57E50B7A0140_impl*
end;//TmsmWordsByUserNameIndex.CompareNames

function TmsmWordsByUserNameIndex.FindWords(const aName: Il3CString): ItfwArray;
//#UC START# *57E560490040_57E50B7A0140_var*
var
 l_A : TtfwArray;
 l_Index : Integer;
//#UC END# *57E560490040_57E50B7A0140_var*
begin
//#UC START# *57E560490040_57E50B7A0140_impl*
 l_A := TtfwArray.Create;
 try
  Lock;
  try
   l_Index := IndexByKey(aName);
   if (l_Index >= 0) then
   begin
    while true do
    begin
     l_A.Add(TtfwStackValue_C(Items[l_Index].rValue));
     Inc(l_Index);
     if (l_Index >= Count) then
      break;
     if (CompareNames(Items[l_Index].rKey, aName) <> 0) then
      break;
    end;//while true
   end;//l_Index >= 0
  finally
   Unlock;
  end;//try..finally
  Result := l_A;
 finally
  FreeAndNil(l_A);
 end;//try..finally
//#UC END# *57E560490040_57E50B7A0140_impl*
end;//TmsmWordsByUserNameIndex.FindWords

class function TmsmWordsByUserNameIndex.Instance: TmsmWordsByUserNameIndex;
 {* Метод получения экземпляра синглетона TmsmWordsByUserNameIndex }
begin
 if (g_TmsmWordsByUserNameIndex = nil) then
 begin
  l3System.AddExitProc(TmsmWordsByUserNameIndexFree);
  g_TmsmWordsByUserNameIndex := Create;
 end;
 Result := g_TmsmWordsByUserNameIndex;
end;//TmsmWordsByUserNameIndex.Instance

class function TmsmWordsByUserNameIndex.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TmsmWordsByUserNameIndex <> nil;
end;//TmsmWordsByUserNameIndex.Exists

end.
