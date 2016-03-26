unit LostNodeAppConfigTest;

// ������: "w:\common\components\rtl\Garant\Daily\LostNodeAppConfigTest.pas"
// ���������: "TestCase"
// ������� ������: "LostNodeAppConfigTest" MUID: (523831AC00C6)
// ��� ����: "TLostNodeAppConfigTest"

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
 TLostNodeAppConfigTest = {abstract} class(_AppConfigTestMixin_)
  protected
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* ������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure FormMade(const aForm: _FormClass_); override;
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
   {$If NOT Defined(NoVCM)}
   procedure CheckControl; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TLostNodeAppConfigTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , ddAppConfigLists
 , ddAppConfigDates
 , ddAppConfigConst
 , ddAppConfigStrings
 , ddAppConfigDataAdapters
 , ddAppConfigUtils
 , Windows
 , ConfigStorageStub
 , SysUtils
 , ddAppConfig
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , FromWithPanel_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

{$If NOT Defined(NoVCM)}
{$Include w:\common\components\rtl\Garant\Daily\AppConfigTestMixin.imp.pas}

procedure TLostNodeAppConfigTest.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_523831AC00C6_var*
//#UC END# *479731C50290_523831AC00C6_var*
begin
//#UC START# *479731C50290_523831AC00C6_impl*
 FreeAndNil(ddAppConfiguration);
//#UC END# *479731C50290_523831AC00C6_impl*
end;//TLostNodeAppConfigTest.Cleanup

function TLostNodeAppConfigTest.FormExtent: TPoint;
 {* ������� ����� }
//#UC START# *4C08CF700318_523831AC00C6_var*
//#UC END# *4C08CF700318_523831AC00C6_var*
begin
//#UC START# *4C08CF700318_523831AC00C6_impl*
 Result.X := 400;
 Result.Y := 200;
//#UC END# *4C08CF700318_523831AC00C6_impl*
end;//TLostNodeAppConfigTest.FormExtent

procedure TLostNodeAppConfigTest.FormMade(const aForm: _FormClass_);
//#UC START# *4C08D61F0231_523831AC00C6_var*
var
 l_File: TddFileNameConfigItem;
//#UC END# *4C08D61F0231_523831AC00C6_var*
begin
//#UC START# *4C08D61F0231_523831AC00C6_impl*
 inherited;
 f_ConfigStorage := TConfigStorageStub.Make;
 ddAppConfiguration := TddAppConfiguration.Create(f_ConfigStorage);
 with ddAppConfiguration do
 begin
  with TddSimpleListConfigItem(AddSimpleListItem('LogoList', '������ ������� �����������')).Config do
  begin
   l_File:= TddFileNameConfigItem.Make('logo_File', '���� �����������');
   l_File.FilterMask:= '��� ����� ����������� (*.jpg, *.png, *.bmp)|*.jpg;*.png;*.bmp|JPG (*.jpg)|*.jpg|PNG (*.png)|*.png|BMP (*.bmp)|*.bmp';
   AddItem(l_File);
   AddItem(TddDateConfigItem.Create('Logo_Start', '������ ��������', ddEmptyDateValue));
   AddItem(TddDateConfigItem.Create('Logo_Finish', '��������� ��������', ddEmptyDateValue));
   AddItem(TddBooleanConfigItem.Create('Logo_Once', '���� ���', ddEmptyValue));
  end;
 end;
//#UC END# *4C08D61F0231_523831AC00C6_impl*
end;//TLostNodeAppConfigTest.FormMade

function TLostNodeAppConfigTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'AppConfig';
end;//TLostNodeAppConfigTest.GetFolder

function TLostNodeAppConfigTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '523831AC00C6';
end;//TLostNodeAppConfigTest.GetModelElementGUID

procedure TLostNodeAppConfigTest.CheckControl;
//#UC START# *51D5464D033C_523831AC00C6_var*
var
 l_DA : TddSimpleListDataAdapter;
 l_Idx: Integer;
 l_Value: Boolean;
//#UC END# *51D5464D033C_523831AC00C6_var*
begin
//#UC START# *51D5464D033C_523831AC00C6_impl*
 l_DA := ddAppConfiguration.AsObject['LogoList'] as TddSimpleListDataAdapter;
 Check(l_DA <> nil);
 l_Idx := l_DA.AddItem;
 l_DA.Values[l_Idx, 'Logo_Once'] := MakeBoolValue(True);
 l_Value := l_DA.Values[l_Idx, 'Logo_Once'].AsBoolean;
//#UC END# *51D5464D033C_523831AC00C6_impl*
end;//TLostNodeAppConfigTest.CheckControl
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
