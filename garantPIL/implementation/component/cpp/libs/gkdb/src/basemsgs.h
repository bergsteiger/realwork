#if defined(_MSC_VER)
	#define BSMES_OK				"���� � �������"

	#define BSMES_FILESNULL			"���� �� ������ ���� �� ��������"

	#define BSMES_FILESLOCKED		"���� ������� ������ ���������"

	#define BSMES_CANNOTOPENFILES	"���� �� ������ ���� �� ��������"

	#define BSMES_INVALIDSIGN		"������ ������ �� ���������"

	#define BSMES_NOTOK				"���� �� ������ ���� �� � �������"

	#define BSMES_DOCINDERROR		"������ � ������� ����������"

	#define BSMES_STREAMERROR		"������ � STR-�����"

#elif defined(unix) && !defined(__GO32__) && !defined(__CYGWIN32__)

	#define BSMES_OK				"Base OK"

	#define BSMES_FILESNULL			"One of the files is 0"

	#define BSMES_FILESLOCKED		"Base's file locked"

	#define BSMES_CANNOTOPENFILES	"One of the files was not opened"

	#define BSMES_INVALIDSIGN		"Data version is invalid"

	#define BSMES_NOTOK				"One of the files is not Ok"

	#define BSMES_DOCINDERROR		"Error in docIndex"

	#define BSMES_STREAMERROR		"Error in stream file"

#else // I hope it's meen DOS

	#define BSMES_OK				"���� � ���浪�"
	#define BSMES_FILESNULL			"���� �� 䠩��� ���� �� ᮧ�����"
	#define BSMES_FILESLOCKED		"���� ����� ��㣮� �����窮�"
	#define BSMES_CANNOTOPENFILES	"���� �� 䠩��� ���� �� ������"
	#define BSMES_INVALIDSIGN		"����� ������ �� ᮢ������"
	#define BSMES_NOTOK				"���� �� 䠩��� ���� �� � ���浪�"
	#define BSMES_DOCINDERROR		"�訡�� � ������ ���㬥�⮢"
	#define BSMES_STREAMERROR		"�訡�� � STR-䠩��"
#endif // OS/compiler type

