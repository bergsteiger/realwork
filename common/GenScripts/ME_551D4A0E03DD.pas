unit VGSceneAndWinControlPack;

interface

uses
 l3IntfUses
 , Controls
 , vgObject
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;

implementation

uses
 l3ImplUses
 , vg_controls
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopControlFindVGControlByName = class(TtfwClassLike)
  {* Слово скрипта pop:Control:FindVGControlByName
*Тип результата:* TvgObject
*Пример:*
[code]
OBJECT VAR l_TvgObject
 aName aControl pop:Control:FindVGControlByName >>> l_TvgObject
[code]  }
  function FindVGControlByName(const aCtx: TtfwContext;
   aControl: TWinControl;
   const aName: AnsiString): TvgObject;
   {* Реализация слова скрипта pop:Control:FindVGControlByName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlFindVGControlByName
 
end.
