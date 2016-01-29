unit vtFlashWordsPack;

interface

uses
 l3IntfUses
 , vtShockwaveFlashEx
 , tfwClassLike
 , tfwScriptingInterfaces
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
 TkwPopFlashGetFrame = class(TtfwClassLike)
  {* Слово скрипта pop:flash:GetFrame
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aFlash pop:flash:GetFrame >>> l_Integer
[code]  }
  function GetFrame(const aCtx: TtfwContext;
   aFlash: TvtShockwaveFlashEx): Integer;
   {* Реализация слова скрипта pop:flash:GetFrame }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFlashGetFrame
 
end.
