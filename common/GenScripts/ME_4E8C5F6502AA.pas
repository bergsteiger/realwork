unit K289933137;
 {* [RequestLink:289933137] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K289933137.pas"
// Стереотип: "TestCase"
// Элемент модели: "K289933137" MUID: (4E8C5F6502AA)
// Имя типа: "TK289933137"

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
 TK289933137 = class({$If NOT Defined(NotTunedDUnit)}
 TBaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 )
  {* [RequestLink:289933137] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  published
   procedure DoIt;
 end;//TK289933137
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3KeyWrd
 , l3Except
 , SysUtils
 , TestFrameWork
;

{$If NOT Defined(NotTunedDUnit)}
procedure TK289933137.DoIt;
//#UC START# *4E8C5F96027B_4E8C5F6502AA_var*
var
 l_KW : Tl3KeyWords;
 l_Raised : Boolean;
//#UC END# *4E8C5F96027B_4E8C5F6502AA_var*
begin
//#UC START# *4E8C5F96027B_4E8C5F6502AA_impl*
 l_KW := Tl3KeyWords.Create;
 try
  l_KW.AddKeyWord('a', 1);
  l_KW.AddKeyWord('b', 2);
  l_Raised := false;
  try
   l_KW.AddKeyWord('B', 3);
  except
   on El3DuplicateItem do
    l_Raised := true;
  end;//try..except
  Assert(l_Raised);
  Check(l_KW.DRbyName['A'] <> nil);
 finally
  FreeAndNil(l_KW);
 end;//try..finally
//#UC END# *4E8C5F96027B_4E8C5F6502AA_impl*
end;//TK289933137.DoIt

function TK289933137.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7 Lulin';
end;//TK289933137.GetFolder

function TK289933137.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E8C5F6502AA';
end;//TK289933137.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK289933137.Suite);
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
