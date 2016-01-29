unit SplashServerInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Splash"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Splash/SplashServerInterfaces.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Core::Splash::Splash::SplashServerInterfaces
//
// ���������� ��� �������
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
  l3Interfaces
  ;

type
 InsSplashWaiter = interface(IUnknown)
  {* ������ ��������� ����������� � ���, ��� ������ ����� �������� ����� }
   ['{3551107A-2BC6-4CC3-94EA-7F5455557CB0}']
   procedure CanCloseSplash;
     {* ������ �������� ������� ����� }
 end;//InsSplashWaiter

 InsSplashInfo = interface(IUnknown)
  {* ���������� � ��������� ������, ������� ���� �������� }
   ['{CBECD569-DD17-4BFB-8FAA-F16E652356A4}']
   function Get_Waiter: InsSplashWaiter;
   procedure Set_Waiter(const aValue: InsSplashWaiter);
   function Get_IsValid: Boolean;
   function Get_MinimalShowTime: Cardinal;
   function Get_Warning: Il3CString;
   function Get_UserInfo: Il3CString;
   function Get_ApplicationTitle: PAnsiChar;
   procedure SwitchToParent;
     {* ������������� �� ���� ������� (� ����� ������) }
   function MakeSplashDataStream: IStream;
   function MakeLogoStream: IStream;
     {* ������� ����� ��� ����������� TvtPngImageList � ������� ����� ���� }
   property Waiter: InsSplashWaiter
     read Get_Waiter
     write Set_Waiter;
     {* �����������, �������� ���� �������, ��� ������ ����� ������� �����.
�� ���� ���������� �����, � �� ������������ Publisher/Subscriber }
   property IsValid: Boolean
     read Get_IsValid;
     {* ������ ������� �������� � ����� ���������� ����� }
   property MinimalShowTime: Cardinal
     read Get_MinimalShowTime;
     {* ����������� ����� ������ ������ }
   property Warning: Il3CString
     read Get_Warning;
     {* �������������� � ��������� ��������� ����. }
   property UserInfo: Il3CString
     read Get_UserInfo;
     {* ������ � ����������� � ������������ }
   property ApplicationTitle: PAnsiChar
     read Get_ApplicationTitle;
     {* ��������� ����������� ���������� }
 end;//InsSplashInfo
{$IfEnd} //not Admin AND not Monitorings

implementation

end.