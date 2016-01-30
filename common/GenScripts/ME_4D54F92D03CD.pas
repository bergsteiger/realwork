unit K177963847;
 {* [$177963847] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K177963847.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoRTFWriterTest
;

type
 TK177963847 = class(TEVDtoRTFWriterTest)
  {* [$177963847] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$If NOT Defined(NotTunedDUnit)}
   function EtalonCanHaveDiff: Boolean; override;
    {* Эталон может иметь эталонную разницу для конкретного компьютера. Например как в [RequestLink:234362304] }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK177963847
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK177963847.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK177963847.GetFolder

{$If NOT Defined(NotTunedDUnit)}
function TK177963847.EtalonCanHaveDiff: Boolean;
 {* Эталон может иметь эталонную разницу для конкретного компьютера. Например как в [RequestLink:234362304] }
//#UC START# *4CAEE13D00E1_4D54F92D03CD_var*
//#UC END# *4CAEE13D00E1_4D54F92D03CD_var*
begin
//#UC START# *4CAEE13D00E1_4D54F92D03CD_impl*
 Result := True;
//#UC END# *4CAEE13D00E1_4D54F92D03CD_impl*
end;//TK177963847.EtalonCanHaveDiff
{$IfEnd} // NOT Defined(NotTunedDUnit)

function TK177963847.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D54F92D03CD';
end;//TK177963847.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK177963847.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
