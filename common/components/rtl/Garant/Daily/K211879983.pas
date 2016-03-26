unit K211879983;
 {* [RequestLink:211879983] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K211879983.pas"
// Стереотип: "TestCase"
// Элемент модели: "K211879983" MUID: (4BED2BFE0092)
// Имя типа: "TK211879983"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TK211879983 = class(TBaseTest)
  {* [RequestLink:211879983] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  published
   procedure DoIt;
 end;//TK211879983
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3String
 , l3Base
 , TestFrameWork
;

{$If NOT Defined(NotTunedDUnit)}
procedure TK211879983.DoIt;
//#UC START# *4BED2C510339_4BED2BFE0092_var*
const
 S = 'ааабббввв';
 SS = 'ббб';
const
 WS : WideString = 'ааабббввв';
 WSS : WideString = 'ббб';
//#UC END# *4BED2C510339_4BED2BFE0092_var*
begin
//#UC START# *4BED2C510339_4BED2BFE0092_impl*
 StartTimer;
 try
  Check(l3Pos(l3PCharLen(AnsiString(S)), l3PCharLen(AnsiString(SS))) = 3);
  Check(l3Pos(l3PCharLen(WS), l3PCharLen(WSS)) = 3);
  Check(l3Pos(l3PCharLen(WS), l3PCharLen(AnsiString(SS))) = 3);
  Check(l3Pos(l3PCharLen(AnsiString(S)), l3PCharLen(WSS)) = 3);
 finally
  StopTimer;
 end;//try..finally
//#UC END# *4BED2C510339_4BED2BFE0092_impl*
end;//TK211879983.DoIt

function TK211879983.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK211879983.GetFolder

function TK211879983.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BED2BFE0092';
end;//TK211879983.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK211879983.Suite);
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
