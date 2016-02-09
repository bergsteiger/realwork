unit ScrollBackByLineWithCheckTopAnchoTest;
 {* Тест прокрутки документа вверх с проверкой TopAnchor }

// Модуль: "w:\common\components\gui\Garant\Daily\ScrollBackByLineWithCheckTopAnchoTest.pas"
// Стереотип: "TestCase"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , ScrollBackByLineTest
 , nevTools
;

type
 TScrollBackByLineWithCheckTopAnchoTest = {abstract} class(TScrollBackByLineTest)
  {* Тест прокрутки документа вверх с проверкой TopAnchor }
  private
   f_PrevTopAnchor: InevBasePoint;
  protected
   procedure Cleanup; override;
   procedure CheckTopAnchor(const aView: InevInputView); override;
    {* проверить якорь начала отрисовки после окончания прокрутки }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TScrollBackByLineWithCheckTopAnchoTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , TestFrameWork
 , vcmBase
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

procedure TScrollBackByLineWithCheckTopAnchoTest.Cleanup;
//#UC START# *4B2F40FD0088_4C46BB2A02BD_var*
//#UC END# *4B2F40FD0088_4C46BB2A02BD_var*
begin
//#UC START# *4B2F40FD0088_4C46BB2A02BD_impl*
 f_PrevTopAnchor := nil;
 inherited;
//#UC END# *4B2F40FD0088_4C46BB2A02BD_impl*
end;//TScrollBackByLineWithCheckTopAnchoTest.Cleanup

procedure TScrollBackByLineWithCheckTopAnchoTest.CheckTopAnchor(const aView: InevInputView);
 {* проверить якорь начала отрисовки после окончания прокрутки }
//#UC START# *4C1F0A260192_4C46BB2A02BD_var*
//#UC END# *4C1F0A260192_4C46BB2A02BD_var*
begin
//#UC START# *4C1F0A260192_4C46BB2A02BD_impl*
 if f_PrevTopAnchor = nil then
 begin
  f_PrevTopAnchor := aView.TopAnchor.ClonePoint(aView);
  Exit;
 end; // if f_PrevTopAnchor then
 CheckFalse(aView.TopAnchor.Diff(aView, f_PrevTopAnchor, aView.RootFormatInfo) = 0, 'Неправильное сравнение TopAnchor!');
 f_PrevTopAnchor := aView.TopAnchor.ClonePoint(aView)
//#UC END# *4C1F0A260192_4C46BB2A02BD_impl*
end;//TScrollBackByLineWithCheckTopAnchoTest.CheckTopAnchor

function TScrollBackByLineWithCheckTopAnchoTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Everest';
end;//TScrollBackByLineWithCheckTopAnchoTest.GetFolder

function TScrollBackByLineWithCheckTopAnchoTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C46BB2A02BD';
end;//TScrollBackByLineWithCheckTopAnchoTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
