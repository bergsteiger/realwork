unit SplashTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Splash"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Splash/SplashTypes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Core::Splash::Splash::SplashTypes
//
// ���������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Windows
  ;

const
  { ��������� }
 cMemFileName = '{FD2B7487-1FEB-40A4-9D66-8532A4BB7C10}';
  { ��� ����� ������������� � ������ }
 cGuardName = '{36F75AF8-F8E5-4C52-9046-1720F059F9A1}';
  { ��� �������� ��� ������ ������ }
 cFinishEventName = '{9B07B496-065C-474D-87D6-7FCA7A3184B0}';
  { ��������� �� ������� � ������� � ���, ��� �������� ��� ������� � ����� ����� ��������� }
 cSplashVersion = 1;
  { ������ ��������� - ��� ������ �� ������ }

type
 TnsSplashData = packed record
  {* ��������� ����� ������������� � ������ }
   Version : Cardinal; // ������ ������ - ��� ������ �� ������
   ProcessID : Cardinal; // ID �������� ������� - ��� ������ �� ������
   Size : Cardinal; // ������ ������ ������ (� ����������)
   MinimalShowTime : Cardinal; // ����������� ����� ������ ������
   ParentWnd : THandle; // ���� �������, �������� ���� �������� ������� �����
   SplashDataOffset : Cardinal; // �������� ��� ������ �����/��������
   SplashDataSize : Cardinal; // ������ ������ ������/��������
   ApplicationTitleOffset : Cardinal;
   ApplicationTitleSize : Cardinal; // ���������� ��� AnsiChar, �������� �������� ����
   UserInfoOffset : Cardinal;
   UserInfoSize : Cardinal; // ���������� ��� WideChar, �������� �������� ����
   WarningOffset : Cardinal;
   WarningSize : Cardinal; // ���������� ��� WideChar, �������� �������� ����
   LogoOffset : Cardinal; // �������� � ���� - ���� ��������� TvtPngImageList
   LogoSize : Cardinal;
 end;//TnsSplashData

 PnsSplashData = ^TnsSplashData;
  {* ��������� �� ��������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

end.