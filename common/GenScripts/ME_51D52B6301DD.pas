unit AppConfigBaseTest;
 {* Тесты на работу конфигурации }

// Модуль: "w:\common\components\rtl\Garant\Daily\AppConfigBaseTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "TAppConfigBaseTest" MUID: (51D52B6301DD)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , EmptyFormTest
 {$IfEnd} // NOT Defined(NoVCM)
 , Types
 , ddAppConfigTypes
 , ddConfigStorages
;

type
 _AppConfigTestMixin_Parent_ = TEmptyFormTest;
 {$Include w:\common\components\rtl\Garant\Daily\AppConfigTestMixin.imp.pas}
 TAppConfigBaseTest = {abstract} class(_AppConfigTestMixin_)
  {* Тесты на работу конфигурации }
  protected
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* Размеры формы }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure FormMade(const aForm: _FormClass_); override;
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   {$If NOT Defined(NoVCM)}
   procedure CheckControl; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TAppConfigBaseTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , Windows
 , Messages
 , vtCheckBox
 , ddAppConfigUtils
 , ConfigStorageStub
 , ddAppConfig
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , FromWithPanel_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

{$If NOT Defined(NoVCM)}
{$Include w:\common\components\rtl\Garant\Daily\AppConfigTestMixin.imp.pas}

function TAppConfigBaseTest.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_51D52B6301DD_var*
//#UC END# *4C08CF700318_51D52B6301DD_var*
begin
//#UC START# *4C08CF700318_51D52B6301DD_impl*
 Result.X := 400;
 Result.Y := 200;
//#UC END# *4C08CF700318_51D52B6301DD_impl*
end;//TAppConfigBaseTest.FormExtent

procedure TAppConfigBaseTest.FormMade(const aForm: _FormClass_);
//#UC START# *4C08D61F0231_51D52B6301DD_var*
//#UC END# *4C08D61F0231_51D52B6301DD_var*
begin
//#UC START# *4C08D61F0231_51D52B6301DD_impl*
 inherited;
 f_ConfigStorage := TConfigStorageStub.Make;
 f_Config := MakeNode('Config', 'Настройки', False,
              MakeBoolean('CheckBoolean', 'Проверочное булевское значение', False,
              nil));
 f_Config.LabelTop := False;
 IddConfigNode(f_Config).CreateFrame(aForm.WorkSpace, 0);
 f_Config.Load(f_ConfigStorage);
 IddConfigNode(f_Config).SetControlValues(False);
//#UC END# *4C08D61F0231_51D52B6301DD_impl*
end;//TAppConfigBaseTest.FormMade

function TAppConfigBaseTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'AppConfig';
end;//TAppConfigBaseTest.GetFolder

function TAppConfigBaseTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '51D52B6301DD';
end;//TAppConfigBaseTest.GetModelElementGUID

procedure TAppConfigBaseTest.CheckControl;
//#UC START# *51D5464D033C_51D52B6301DD_var*
var
 l_CheckBox: TvtCheckBox;
//#UC END# *51D5464D033C_51D52B6301DD_var*
begin
//#UC START# *51D5464D033C_51D52B6301DD_impl*
 l_CheckBox := (f_Config.Items[0].Control as TvtCheckBox);
 Check(SendMessage(l_CheckBox.Handle, BM_GETCHECK, 0, 0) = BST_CHECKED);
//#UC END# *51D5464D033C_51D52B6301DD_impl*
end;//TAppConfigBaseTest.CheckControl
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
