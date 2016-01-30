unit kwIterateSubDecriptorsOnSubPanelEX;
 {* Перебирает все SubDescriptot на SubPanel, которые *могут быть* отрисованы (!). Т.е. проверка на Visible не производится. Если это нужно, то можно реализвать в скриптах. 
Формат:
[code]
@ aWord aLayerID aSubPanel IterateSubDecriptorsOnSubPanelEX
[code]
aLayerID - слой, в котором производится итерация
aSubPanel - контрол сабпанели.
aWord - функция для обработки вида:
[code]
PROCEDURE CheckDescription OBJECT IN aSubDescription OBJECT IN aSubPanelSub
 // А здесь обрабатываем полученный aSubDescription
;
[code]
Для извлечения нужной инфорации из aSubDescription есть набор функций: subdescriptor:GetDrawType и т.п.
aSubPanelSub - визуальное представление метки. }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwIterateSubDecriptorsOnSubPanelEX.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwIterateSubDecriptorsOnSubPanel
 , tfwScriptingInterfaces
 , evSubPn
 , evSubPanelSub
;

type
 TkwIterateSubDecriptorsOnSubPanelEX = {final} class(TkwIterateSubDecriptorsOnSubPanel)
  {* Перебирает все SubDescriptot на SubPanel, которые *могут быть* отрисованы (!). Т.е. проверка на Visible не производится. Если это нужно, то можно реализвать в скриптах. 
Формат:
[code]
@ aWord aLayerID aSubPanel IterateSubDecriptorsOnSubPanelEX
[code]
aLayerID - слой, в котором производится итерация
aSubPanel - контрол сабпанели.
aWord - функция для обработки вида:
[code]
PROCEDURE CheckDescription OBJECT IN aSubDescription OBJECT IN aSubPanelSub
 // А здесь обрабатываем полученный aSubDescription
;
[code]
Для извлечения нужной инфорации из aSubDescription есть набор функций: subdescriptor:GetDrawType и т.п.
aSubPanelSub - визуальное представление метки. }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure PushObjData(const aCtx: TtfwContext;
    aSubDescription: TevSubDescriptor;
    aSubPanelSub: TevSubPanelSub); override;
 end;//TkwIterateSubDecriptorsOnSubPanelEX
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evSubPanelSubArray
 , evSubPanelSubCollection
;

class function TkwIterateSubDecriptorsOnSubPanelEX.GetWordNameForRegister: AnsiString;
begin
 Result := 'IterateSubDecriptorsOnSubPanelEX';
end;//TkwIterateSubDecriptorsOnSubPanelEX.GetWordNameForRegister

procedure TkwIterateSubDecriptorsOnSubPanelEX.PushObjData(const aCtx: TtfwContext;
 aSubDescription: TevSubDescriptor;
 aSubPanelSub: TevSubPanelSub);
//#UC START# *53EDFA0401B8_53EDF0A20129_var*
//#UC END# *53EDFA0401B8_53EDF0A20129_var*
begin
//#UC START# *53EDFA0401B8_53EDF0A20129_impl*
 aCtx.rEngine.PushObj(aSubDescription);
 aCtx.rEngine.PushObj(aSubPanelSub);
//#UC END# *53EDFA0401B8_53EDF0A20129_impl*
end;//TkwIterateSubDecriptorsOnSubPanelEX.PushObjData

initialization
 TkwIterateSubDecriptorsOnSubPanelEX.RegisterInEngine;
 {* Регистрация IterateSubDecriptorsOnSubPanelEX }
{$IfEnd} // NOT Defined(NoScripts)

end.
