unit tfwParserServiceFileNameToFileNameMap;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwParserServiceFileNameToFileNameMap.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwParserServiceFileNameToFileNameMap" MUID: (580934E0010C)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
 , SyncObjs
;

type
 _KeyType_ = AnsiString;
 _ValueType_ = AnsiString;
 {$Include w:\common\components\rtl\Garant\L3\l3Map.imp.pas}
 _seCriticalSectionHolder_Parent_ = _l3Map_;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolder.imp.pas}
 TtfwParserServiceFileNameToFileNameMap = class(_seCriticalSectionHolder_)
 end;//TtfwParserServiceFileNameToFileNameMap

implementation

uses
 l3ImplUses
 , SysUtils
 , StrUtils
 , l3Base
 , l3MinMax
 , RTLConsts
 //#UC START# *580934E0010Cimpl_uses*
 //#UC END# *580934E0010Cimpl_uses*
;

function CompareKeys(const aA: _KeyType_;
 const aB: _KeyType_): Integer;
//#UC START# *5609091B00C0_580934E0010C_var*
//#UC END# *5609091B00C0_580934E0010C_var*
begin
//#UC START# *5609091B00C0_580934E0010C_impl*
 Result := AnsiCompareText(aA, aB);
//#UC END# *5609091B00C0_580934E0010C_impl*
end;//CompareKeys

type _Instance_R_ = TtfwParserServiceFileNameToFileNameMap;

{$Include w:\common\components\rtl\Garant\L3\l3Map.imp.pas}

{$Include w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolder.imp.pas}

end.
