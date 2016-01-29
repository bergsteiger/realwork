unit LostNodeAppConfigTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/LostNodeAppConfigTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::AppConfig::LostNodeAppConfigTest
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  EmptyFormTest
  {$IfEnd} //nsTest AND not NoVCM
  ,
  ddConfigStorages,
  ddAppConfigTypes,
  Types
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _AppConfigTestMixin_Parent_ = TEmptyFormTest;
 {$Include ..\Daily\AppConfigTestMixin.imp.pas}
 TLostNodeAppConfigTest = {abstract} class(_AppConfigTestMixin_)
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   {$If defined(nsTest) AND not defined(NoVCM)}
   function FormExtent: TPoint; override;
     {* ������� ����� }
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure FormMade(const aForm: _FormClass_); override;
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
    {$If defined(nsTest) AND not defined(NoVCM)}
   procedure CheckControl; override;
    {$IfEnd} //nsTest AND not NoVCM
 end;//TLostNodeAppConfigTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  ddAppConfigLists,
  ddAppConfigDates,
  ddAppConfigConst,
  ddAppConfigStrings,
  ddAppConfigDataAdapters,
  TestFrameWork,
  ddAppConfigUtils,
  Windows,
  ConfigStorageStub,
  SysUtils,
  ddAppConfig
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

{$Include ..\Daily\AppConfigTestMixin.imp.pas}

// start class TLostNodeAppConfigTest

procedure TLostNodeAppConfigTest.Cleanup;
//#UC START# *479731C50290_523831AC00C6_var*
//#UC END# *479731C50290_523831AC00C6_var*
begin
//#UC START# *479731C50290_523831AC00C6_impl*
 FreeAndNil(ddAppConfiguration);
//#UC END# *479731C50290_523831AC00C6_impl*
end;//TLostNodeAppConfigTest.Cleanup

{$If defined(nsTest) AND not defined(NoVCM)}
function TLostNodeAppConfigTest.FormExtent: TPoint;
//#UC START# *4C08CF700318_523831AC00C6_var*
//#UC END# *4C08CF700318_523831AC00C6_var*
begin
//#UC START# *4C08CF700318_523831AC00C6_impl*
 Result.X := 400;
 Result.Y := 200;
//#UC END# *4C08CF700318_523831AC00C6_impl*
end;//TLostNodeAppConfigTest.FormExtent
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
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
{$IfEnd} //nsTest AND not NoVCM

function TLostNodeAppConfigTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'AppConfig';
end;//TLostNodeAppConfigTest.GetFolder

function TLostNodeAppConfigTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '523831AC00C6';
end;//TLostNodeAppConfigTest.GetModelElementGUID

{$If defined(nsTest) AND not defined(NoVCM)}
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
{$IfEnd} //nsTest AND not NoVCM

{$IfEnd} //nsTest AND not NoScripts

end.