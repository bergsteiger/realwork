unit vcmToolbarMenuRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/VCM/implementation/vcmToolbarMenuRes.pas"
// �����: 10.03.2010 13:40
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM::vcmL10nImpl::vcmToolbarMenuRes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  l3Interfaces,
  afwInterfaces,
  l3StringIDEx
  ;

type
 TvcmGlyphSize = (
   vcm_gsAutomatic
 , vcm_gs16x16
 , vcm_gs24x24
 , vcm_gs32x32
 );//TvcmGlyphSize

var
  { ������������ ������ vcmIconSize }
 str_vcmgsAutomatic : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmgsAutomatic'; rValue : '�������������');
  { '�������������' }
 str_vcmgs16x16 : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmgs16x16'; rValue : '���������');
  { '���������' }
 str_vcmgs24x24 : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmgs24x24'; rValue : '�������');
  { '�������' }
 str_vcmgs32x32 : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmgs32x32'; rValue : '�������');
  { '�������' }

const
  { ����� �������������� �������������� ����� vcmIconSize }
 vcmIconSizeMap : array [TvcmGlyphSize] of Pl3StringIDEx = (
  @str_vcmgsAutomatic
  , @str_vcmgs16x16
  , @str_vcmgs24x24
  , @str_vcmgs32x32
 );//vcmIconSizeMap

type
 vcmIconSizeMapHelper = {final} class
  {* ��������� ����� ��� �������������� �������� vcmIconSizeMap }
 public
 // public methods
   class procedure FillStrings(const aStrings: IafwStrings);
     {* ���������� ������ ����� ���������� }
   class function DisplayNameToValue(const aDisplayName: Il3CString): TvcmGlyphSize;
     {* �������������� ���������� �������� � ����������� }
 end;//vcmIconSizeMapHelper
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3MessageID,
  l3String,
  SysUtils
  ;

// start class vcmIconSizeMapHelper

class procedure vcmIconSizeMapHelper.FillStrings(const aStrings: IafwStrings);
var
 l_Index: TvcmGlyphSize;
begin
 aStrings.Clear;
 for l_Index := Low(l_Index) to High(l_Index) do
  aStrings.Add(vcmIconSizeMap[l_Index].AsCStr);
end;//vcmIconSizeMapHelper.FillStrings

class function vcmIconSizeMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): TvcmGlyphSize;
var
 l_Index: TvcmGlyphSize;
begin
 for l_Index := Low(l_Index) to High(l_Index) do
  if l3Same(aDisplayName, vcmIconSizeMap[l_Index].AsCStr) then
  begin
   Result := l_Index;
   Exit;
  end;//l3Same..
 raise Exception.CreateFmt('Display name "%s" not found in map "vcmIconSizeMap"', [l3Str(aDisplayName)]);
end;//vcmIconSizeMapHelper.DisplayNameToValue
{$IfEnd} //not NoVCM

initialization
{$If not defined(NoVCM)}
// ������������� str_vcmgsAutomatic
 str_vcmgsAutomatic.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// ������������� str_vcmgs16x16
 str_vcmgs16x16.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// ������������� str_vcmgs24x24
 str_vcmgs24x24.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// ������������� str_vcmgs32x32
 str_vcmgs32x32.Init;
{$IfEnd} //not NoVCM

end.