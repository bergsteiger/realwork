unit ArchiStorageTestWithRename;

// Модуль: "w:\common\components\rtl\Garant\Abstract_Archi_Tests\ArchiStorageTestWithRename.pas"
// Стереотип: "TestCase"
// Элемент модели: "TArchiStorageTestWithRename" MUID: (4FBB6C0D0366)

{$Include w:\common\components\rtl\Garant\Abstract_Archi_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ArchiStorageTest
;

type
 TArchiStorageTestWithRename = {abstract} class(TArchiStorageTest)
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   function NeedTestRenaming: Boolean; override;
 end;//TArchiStorageTestWithRename
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TArchiStorageTestWithRename.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Storage';
end;//TArchiStorageTestWithRename.GetFolder

function TArchiStorageTestWithRename.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FBB6C0D0366';
end;//TArchiStorageTestWithRename.GetModelElementGUID

function TArchiStorageTestWithRename.NeedTestRenaming: Boolean;
//#UC START# *4FBB73390387_4FBB6C0D0366_var*
//#UC END# *4FBB73390387_4FBB6C0D0366_var*
begin
//#UC START# *4FBB73390387_4FBB6C0D0366_impl*
 Result := true;
//#UC END# *4FBB73390387_4FBB6C0D0366_impl*
end;//TArchiStorageTestWithRename.NeedTestRenaming
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
