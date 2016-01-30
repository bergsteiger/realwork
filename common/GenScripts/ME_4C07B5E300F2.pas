unit EVDtoEVDWriterTest;

// Модуль: "w:\common\components\rtl\Garant\Daily\EVDtoEVDWriterTest.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDWriterTest
;

type
 TEVDtoEVDWriterTest = {abstract} class(TEVDWriterTest)
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  public
   procedure DoIt;
 end;//TEVDtoEVDWriterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TEVDtoEVDWriterTest.DoIt;
//#UC START# *4C07B5F90205_4C07B5E300F2_var*
//#UC END# *4C07B5F90205_4C07B5E300F2_var*
begin
//#UC START# *4C07B5F90205_4C07B5E300F2_impl*
 EVDtoEVD(KPage + '.evd');
//#UC END# *4C07B5F90205_4C07B5E300F2_impl*
end;//TEVDtoEVDWriterTest.DoIt

function TEVDtoEVDWriterTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EVD';
end;//TEVDtoEVDWriterTest.GetFolder

function TEVDtoEVDWriterTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C07B5E300F2';
end;//TEVDtoEVDWriterTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
