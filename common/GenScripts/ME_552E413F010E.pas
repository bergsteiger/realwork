unit SpinEditWordsPack;

interface

uses
 l3IntfUses
 , vtSpinEdit
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , TypInfo
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopSpinEditValue = class(TtfwPropertyLike)
  {* Слово скрипта pop:SpinEdit:Value
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aSpinEdit pop:SpinEdit:Value >>> l_Integer
[code]  }
  function Value(const aCtx: TtfwContext;
   aSpinEdit: TvtSpinEdit): Integer;
   {* Реализация слова скрипта pop:SpinEdit:Value }
  procedure DoSetValue(aSpinEdit: TvtSpinEdit;
   aValue: Integer);
   {* Метод установки значения свойства Value }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopSpinEditValue
 
end.
