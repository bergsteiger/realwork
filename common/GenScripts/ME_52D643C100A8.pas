unit kwIterateSubDescriptors;
 {* Перебирает все SubDescriptot на SubPanel, которые могут быть использованы (!). Такой список задается на этапе проектирвоания/изменения компонета. И не зависит от вида отображения.
Формат:
[code]
@ aWord aLayerID aSubPanel ItarateSubDescriptors
[code]
aLayerID - слой, в котором производится итерация
aSubPanel - контрол сабпанели.
aWord - функция для обработки вида:
[code]
PROCEDURE CheckDescription OBJECT IN aSubDescription
 // А здесь обрабатываем полученный aSubDescription
;
[code]
Для извлечения нужной инфорации из aSubDescription есть набор функций: subdescriptor:GetDrawType и т.п. }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwIterateSubDescriptors.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwSubPanelFromStackWord
 , evSubPn
 , tfwScriptingInterfaces
;

type
 TkwIterateSubDescriptors = {final} class(TkwSubPanelFromStackWord)
  {* Перебирает все SubDescriptot на SubPanel, которые могут быть использованы (!). Такой список задается на этапе проектирвоания/изменения компонета. И не зависит от вида отображения.
Формат:
[code]
@ aWord aLayerID aSubPanel ItarateSubDescriptors
[code]
aLayerID - слой, в котором производится итерация
aSubPanel - контрол сабпанели.
aWord - функция для обработки вида:
[code]
PROCEDURE CheckDescription OBJECT IN aSubDescription
 // А здесь обрабатываем полученный aSubDescription
;
[code]
Для извлечения нужной инфорации из aSubDescription есть набор функций: subdescriptor:GetDrawType и т.п. }
  protected
   procedure DoWithSubPanel(aControl: TevCustomSubPanel;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwIterateSubDescriptors
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

procedure TkwIterateSubDescriptors.DoWithSubPanel(aControl: TevCustomSubPanel;
 const aCtx: TtfwContext);
//#UC START# *52D6471802DC_52D643C100A8_var*
var
 i        : Integer;
 l_Obj    : TObject;
 l_Layer  : TevSubLayerDescriptor;
 l_Lambda : TtfwWord;
 l_LayerID: Integer;
//#UC END# *52D6471802DC_52D643C100A8_var*
begin
//#UC START# *52D6471802DC_52D643C100A8_impl*
 RunnerAssert(aCtx.rEngine.IsTopInt, 'Слой меток не задан.', aCtx);
 l_LayerID := aCtx.rEngine.PopInt;
 RunnerAssert(l_LayerID = 0, 'Не существующее слово.', aCtx);
 
 RunnerAssert(aCtx.rEngine.IsTopObj, 'В итератор не передано слово.', aCtx);
 l_Obj := aCtx.rEngine.PopObj;
 RunnerAssert(l_Obj is TtfwWord, 'В итератор не передано слово.', aCtx);

 l_Lambda := l_Obj as TtfwWord;
 l_Layer := TevSubLayerDescriptor(aControl.SubDescriptors[l_LayerID]);
 RunnerAssert(l_Layer <> nil, 'Нет такого слоя меток.', aCtx);
 for i := 0 to 7 do
 try
  aCtx.rEngine.PushObj(l_Layer.Flags[i]);
  l_Lambda.DoIt(aCtx);
 except
  on EtfwBreakIterator do
   Exit;
 end;//try..except
//#UC END# *52D6471802DC_52D643C100A8_impl*
end;//TkwIterateSubDescriptors.DoWithSubPanel

class function TkwIterateSubDescriptors.GetWordNameForRegister: AnsiString;
begin
 Result := 'IterateSubDescriptors';
end;//TkwIterateSubDescriptors.GetWordNameForRegister

initialization
 TkwIterateSubDescriptors.RegisterInEngine;
 {* Регистрация IterateSubDescriptors }
{$IfEnd} // NOT Defined(NoScripts)

end.
