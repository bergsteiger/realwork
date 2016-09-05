unit K622402617;
 {* [RequestLink:622402617] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K622402617.pas"
// Стереотип: "TestCase"
// Элемент модели: "K622402617" MUID: (5720F28E0343)
// Имя типа: "TK622402617"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDWriterTest
 , l3Variant
 , evdLeafParaFilter
 , k2Base
;

type
 TevdTextCodePageChanger = class(TevdLeafParaFilter)
  protected
   function ParaTypeForFiltering: Tk2Type; override;
    {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
   procedure DoWritePara(aLeaf: Tl3Variant); override;
    {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
 end;//TevdTextCodePageChanger

 TK622402617 = class(TEVDtoEVDWriterTest)
  {* [RequestLink:622402617] }
  protected
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK622402617
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , k2Tags
 , l3String
 , l3Chars
 , TextPara_Const
 //#UC START# *5720F28E0343impl_uses*
 //#UC END# *5720F28E0343impl_uses*
;

function TevdTextCodePageChanger.ParaTypeForFiltering: Tk2Type;
 {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
//#UC START# *49E488070386_5720F31301A0_var*
//#UC END# *49E488070386_5720F31301A0_var*
begin
//#UC START# *49E488070386_5720F31301A0_impl*
 Result := k2_typTextPara;
//#UC END# *49E488070386_5720F31301A0_impl*
end;//TevdTextCodePageChanger.ParaTypeForFiltering

procedure TevdTextCodePageChanger.DoWritePara(aLeaf: Tl3Variant);
 {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
//#UC START# *49E4883E0176_5720F31301A0_var*
//#UC END# *49E4883E0176_5720F31301A0_var*
begin
//#UC START# *49E4883E0176_5720F31301A0_impl*
 if (aLeaf.PCharLenA[k2_tiText].SCodePage = CP_RussianDOS)
    OR (aLeaf.PCharLenA[k2_tiText].SCodePage = CP_OEM) then
  aLeaf.StrA[k2_tiText] := l3PCharLen2String(aLeaf.PCharLenA[k2_tiText], CP_ANSI);
 inherited;
//#UC END# *49E4883E0176_5720F31301A0_impl*
end;//TevdTextCodePageChanger.DoWritePara

procedure TK622402617.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_5720F28E0343_var*
//#UC END# *4C07BCBE01F2_5720F28E0343_var*
begin
//#UC START# *4C07BCBE01F2_5720F28E0343_impl*
 inherited;
 TevdTextCodePageChanger.SetTo(theGenerator);
//#UC END# *4C07BCBE01F2_5720F28E0343_impl*
end;//TK622402617.SetFilters

function TK622402617.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '8.0';
end;//TK622402617.GetFolder

function TK622402617.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5720F28E0343';
end;//TK622402617.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK622402617.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
