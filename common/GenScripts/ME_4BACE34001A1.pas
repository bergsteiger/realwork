unit K199591594;
 {* [$199591594] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K199591594.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFWriterTest
;

type
 TK199591594 = class(TRTFWriterTest)
  {* [$199591594] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$If NOT Defined(NotTunedDUnit)}
   function EtalonNeedsComputerName: Boolean; override;
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  public
   procedure DoIt;
 end;//TK199591594
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TK199591594.DoIt;
//#UC START# *4BACE4A50338_4BACE34001A1_var*
//#UC END# *4BACE4A50338_4BACE34001A1_var*
begin
//#UC START# *4BACE4A50338_4BACE34001A1_impl*
 EVDtoRTF('199591594.evd', true{false});
//#UC END# *4BACE4A50338_4BACE34001A1_impl*
end;//TK199591594.DoIt

function TK199591594.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK199591594.GetFolder

{$If NOT Defined(NotTunedDUnit)}
function TK199591594.EtalonNeedsComputerName: Boolean;
//#UC START# *4CA45DAA01BA_4BACE34001A1_var*
//#UC END# *4CA45DAA01BA_4BACE34001A1_var*
begin
//#UC START# *4CA45DAA01BA_4BACE34001A1_impl*
 Result := true;
//#UC END# *4CA45DAA01BA_4BACE34001A1_impl*
end;//TK199591594.EtalonNeedsComputerName
{$IfEnd} // NOT Defined(NotTunedDUnit)

function TK199591594.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BACE34001A1';
end;//TK199591594.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK199591594.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
