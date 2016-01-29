unit afwApplication;

interface

uses
 l3IntfUses
 , l3CacheableBase
 , afwInterfaces
 , l3Core
 , afwFacade
;

type
 TafwApplication = class(Tl3CacheableBase, IafwSettingsSource, IafwApplication)
  {* "�����������" ���������� ���������� AFW. }
  function DoGetIsTrialMode: Boolean;
  function DoGetTabInterfaceType: TafwTabInterfaceType;
  function MakeApplicationData: IafwApplicationData;
  function MakeSettings: IafwSettings;
  function DoGetIsInternal: Boolean;
  function MakeLocaleInfo: IafwLocaleInfo;
  procedure DefineLocaleInfo;
  procedure DoApplyActiveLanguage(const aTarget: IafwResources);
  function MakePermanentSettings: IafwSettingsPrim;
  procedure DoLockKeyboard;
  procedure DoUnLockKeyboard;
  procedure GetAskClearClipboardProc(out aProc: TafwAskClearClipboardProc);
  function BaseId: AnsiString;
   {* ������� ������������� ���������. ������������ ��� ������ ����� ���� ��� ��������������� ��������. }
  procedure ApplyActiveLanguage(const aTarget: IafwResources);
  function CurrentMainForm: IafwMainForm;
   {* ������� �������� �����. }
  function Settings: IafwSettings;
   {* ��������� �������� ������������ �������. }
  function PrintManager: IafwPrintManager;
   {* �������� ������. }
  function UserQuery: IafwUserQuery;
   {* "������" ��� ������� ������������. }
  function IsInternal: Boolean;
   {* ���������� ������ ���������� (����������, ������������). ���� ���� ����������, �� ������ ������������ ������ �������� � ����� ��������� ������� � ���������.
��������� ������������ ��������: OIT500019874. }
  function LocaleInfo: IafwLocaleInfo;
   {* ���������� � ������. }
  function Data: IafwApplicationData;
   {* - ������ ����������. }
  function MakeLongProcessVisualizer(const aCaption: IafwCString;
   anAttachWnd: THandle;
   anInitialTimeout: Cardinal;
   anImageList: TafwCustomImageList;
   anImageIndex: Integer): IafwLongProcessVisualizer;
  function PermanentSettings: IafwSettingsPrim;
  procedure LockKeyBoard;
  procedure UnlockKeyBoard;
  function AskClearClipboardProc: TafwAskClearClipboardProc;
  function IsTrialMode: Boolean;
  function TabInterfaceType: TafwTabInterfaceType;
 end;//TafwApplication
 
 TafwApplicationClass = class of TafwApplication;
  {* ������ �� TafwApplication. }
 
 TafwImplementation = class(Tafw)
  {* ���������, ����������� "�����������" ������� ����� ����� � ���������� ���������� AFW. }
  function GetApplicationClass: TafwApplicationClass;
   {* ����� ���������� ����������. }
 end;//TafwImplementation
 
implementation

uses
 l3ImplUses
 , l3LocaleInfo
 , afwLongProcessVisualizer
 , SysUtils
 , l3Base
 , Forms
 , afwSettingsImplSing
 , afwSettingsImplemented
 , Classes
;

end.
