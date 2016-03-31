unit SplashTypes;
 {* ���������� ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Splash\SplashTypes.pas"
// ���������: "Interfaces"
// ������� ������: "SplashTypes" MUID: (499C07150302)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Windows
;

const
 {* ��������� }
 cMemFileName = '{FD2B7487-1FEB-40A4-9D66-8532A4BB7C10}';
  {* ��� ����� ������������� � ������ }
 cGuardName = '{36F75AF8-F8E5-4C52-9046-1720F059F9A1}';
  {* ��� �������� ��� ������ ������ }
 cFinishEventName = '{9B07B496-065C-474D-87D6-7FCA7A3184B0}';
  {* ��������� �� ������� � ������� � ���, ��� �������� ��� ������� � ����� ����� ��������� }
 cSplashVersion = 1;
  {* ������ ��������� - ��� ������ �� ������ }

type
 PnsSplashData = ^TnsSplashData;
  {* ��������� �� ��������� }

 TnsSplashData = packed record
  {* ��������� ����� ������������� � ������ }
  Version: Cardinal;
   {* ������ ������ - ��� ������ �� ������ }
  ProcessID: Cardinal;
   {* ID �������� ������� - ��� ������ �� ������ }
  Size: Cardinal;
   {* ������ ������ ������ (� ����������) }
  MinimalShowTime: Cardinal;
   {* ����������� ����� ������ ������ }
  ParentWnd: THandle;
   {* ���� �������, �������� ���� �������� ������� ����� }
  SplashDataOffset: Cardinal;
   {* �������� ��� ������ �����/�������� }
  SplashDataSize: Cardinal;
   {* ������ ������ ������/�������� }
  ApplicationTitleOffset: Cardinal;
  ApplicationTitleSize: Cardinal;
   {* ���������� ��� AnsiChar, �������� �������� ���� }
  UserInfoOffset: Cardinal;
  UserInfoSize: Cardinal;
   {* ���������� ��� WideChar, �������� �������� ���� }
  WarningOffset: Cardinal;
  WarningSize: Cardinal;
   {* ���������� ��� WideChar, �������� �������� ���� }
  LogoOffset: Cardinal;
   {* �������� � ���� - ���� ��������� TvtPngImageList }
  LogoSize: Cardinal;
 end;//TnsSplashData
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
