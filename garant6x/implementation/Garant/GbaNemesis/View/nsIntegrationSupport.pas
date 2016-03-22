unit nsIntegrationSupport;

interface

type
 TIntergationDataKind = (idkCommand, idkLink, idkCheckIntegrationKey);

 TnsLinkDataArray = array [0..0] of byte;
 PnsLinkDataArray = ^TnsLinkDataArray;

 PIntegrationData = ^TIntegrationData;
 TIntegrationData = packed record
  OpenInNewWindow: Boolean;
  case Kind: TIntergationDataKind of
   idkCommand: (Command: Integer);
   idkLink: (LinkLength: Integer; Link: TnsLinkDataArray);
   idkCheckIntegrationKey: (KeyLength: Integer; Key: TnsLinkDataArray);
 end;

const
 c_IntegrationMessageName = '{394AC4BC-9BC4-4A75-BE21-40CC58511CD6}';
 c_IntergationMutexName = '{BC46C623-DBC9-473E-B8CC-9E7CBD8ACBC3}';
 c_LastMainWindowMessageName = '{1CDEED58-DDBF-4AC9-B86F-8D957B46E59C}';

 // ���� ������
 GI_OK = 0; // ��� ������
 GI_NOTFOUND = 1; // ������� ������ �� �������
 GI_INVALIDLINKFORMAT = 2; // �������� ������ ������
 GI_BUSY = 3; // ������� ������ ������ (���������� ��������� ������, �������� � �.�.)
              // � �� ����� ���������� ������
 GI_TIMEOUT = 4; // ����-��� ��� ��������� ������ �� ������� ���� �������
 GI_ALREADYRUNNING = 5; // ������� ������ ��� ��������
 GI_SYSTEMERROR = 6; // ������������� ������ (��� xml-�������, ����� ���� � ��.)
 GI_QUERYPARAMSHASABSENTVALUES = 7; // ������-������ �������� �������, ������� ���
                                    // ������� ��������� ������ �� �������
                                    // ���� ����� ������������
 GI_USERDENYLOGIN = 8; // ��� ������� ������� ������������ ��������� �� �����������
 GI_TRYTOFINDEMPTYCONTEXT = 9; // ������� ������ ������� ���������
 GI_TOOMANYOPENWINDOWS = 10; // ������� ����� �������� ����

 // �������
 GC_ACTIVATE              = 0; // ������ ���������/������������ ������� ����
 GC_MAIN_MENU             = 1; // �������� ����
 GC_NAVIGATOR             = 2; // �������� ���������
 GC_SITUATION_SEARCH      = 3; // ������ �� ��������,
 GC_ATTRIBUTES_SEARCH     = 4; // ������ �� ����������,
 GC_PUBLISH_SOURCE_SEARCH = 5; // ������ �� ��������� �������������,
 GC_REVIEW                = 7; // ����� ��������� � ����������������
 GC_DICTION               = 8; // �������� �������
 GC_NEW_DOCS              = 9; // ����� ��������� �� ���������� ����������
 GC_INPHARM_SEARCH        = 10; // ����� �������������� ���������
 GC_DRUG_LIST             = 11; // ������ ������������� ����������
 GC_INPHARM_MAIN_MENU     = 12; // �������� ���� ������
 GC_IMPHARM_DICTION       = 13; // ������� ���. ��������
 GC_INTERNET_AGENT        = 14; // ������� ������
 GC_OPEN_CONSULT          = 15; // ������ ������ ��������
 GC_PRIME                 = 16; // ��� ��������� �����

 GC_FIRST = GC_ACTIVATE;
 GC_LAST  = GC_PRIME;

implementation

end.