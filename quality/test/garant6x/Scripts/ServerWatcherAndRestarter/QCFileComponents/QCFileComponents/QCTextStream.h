// QCTextStream.h : Declaration of the CQCTextStream

#pragma once
#include "resource.h"       // main symbols

#include "QCFileComponents_i.h"

#include "Windows.h"

#include "convutil.h"

#if defined(_WIN32_WCE) && !defined(_CE_DCOM) && !defined(_CE_ALLOW_SINGLE_THREADED_OBJECTS_IN_MTA)
#error "Single-threaded COM objects are not properly supported on Windows CE platform, such as the Windows Mobile platforms that do not include full DCOM support. Define _CE_ALLOW_SINGLE_THREADED_OBJECTS_IN_MTA to force ATL to support creating single-thread COM object's and allow use of it's single-threaded COM object implementations. The threading model in your rgs file was set to 'Free' as that is the only threading model supported in non DCOM Windows CE platforms."
#endif


// CQCTextStream

class ATL_NO_VTABLE CQCTextStream :
	public CComObjectRootEx<CComSingleThreadModel>,
	public CComCoClass<CQCTextStream, &CLSID_QCTextStream>,
	public ISupportErrorInfo,
	public IDispatchImpl<IQCTextStream, &IID_IQCTextStream, &LIBID_QCFileComponentsLib, /*wMajor =*/ 1, /*wMinor =*/ 0>,
	public IDispatchImpl<ITextStream, &__uuidof(ITextStream), &LIBID_Scripting, /* wMajor = */ 1>
{
public:
	CQCTextStream()
		: m_file(INVALID_HANDLE_VALUE)
	{
		m_saved_pos.QuadPart = 0;
		m_num_of_opens = 0;
	}

	//DECLARE_REGISTRY_RESOURCEID(IDR_QCTEXTSTREAM)

	DECLARE_NOT_AGGREGATABLE(CQCTextStream)

	BEGIN_COM_MAP(CQCTextStream)
		COM_INTERFACE_ENTRY(IQCTextStream)
		COM_INTERFACE_ENTRY2(IDispatch, ITextStream)
		COM_INTERFACE_ENTRY(ISupportErrorInfo)
		COM_INTERFACE_ENTRY(ITextStream)
	END_COM_MAP()

	// ISupportsErrorInfo
	STDMETHOD(InterfaceSupportsErrorInfo)(REFIID riid);


	DECLARE_PROTECT_FINAL_CONSTRUCT()

	HRESULT FinalConstruct()
	{
		return S_OK;
	}

	void FinalRelease();
	
	HRESULT Initialize(
		BSTR in_path_to_file,
		IOMode in_iomode,
		VARIANT_BOOL in_is_create
	);
	
public:


	// ITextStream Methods
public:
	// Данный метод всегда возвращает -1, потому что стиль работы с потоком предполагаемый мной не поддерживает вычитку файла с самого начала
	STDMETHOD(get_Line)(long * Line);
	
	// Данный метод всегда возвращает -1, потому что стиль работы с потоком предполагаемый мной не поддерживает вычитку файла с самого начала
	STDMETHOD(get_Column)(long * Column);

	STDMETHOD(get_AtEndOfStream)(VARIANT_BOOL * EOS);

	STDMETHOD(get_AtEndOfLine)(VARIANT_BOOL * EOL);

	STDMETHOD(Read)(long Characters, BSTR * Text);

	STDMETHOD(ReadLine)(BSTR * Text);

	STDMETHOD(ReadAll)(BSTR * Text);

	STDMETHOD(Write)(BSTR Text);

	STDMETHOD(WriteLine)(BSTR Text);

	STDMETHOD(WriteBlankLines)(long Lines);

	STDMETHOD(Skip)(long Characters);

	STDMETHOD(SkipLine)();

	STDMETHOD(Close)();
private:
	// полный путь к открываемому файлу
	std::wstring m_path_to_file;
	// режим доступа к открываемому файлу
	IOMode m_iomode;
	// создавать ли файл если он не создан
	VARIANT_BOOL m_is_create;
	//
	HANDLE m_file;	 
	LARGE_INTEGER m_saved_pos;
	int m_num_of_opens;
	//
	LARGE_INTEGER GetCurrPos();
	LARGE_INTEGER GetFileSize();
	void SetCurrPos(LARGE_INTEGER new_pos, DWORD move_method);	
	bool IsEOF();
	bool OpenFile();
	void CloseFile();
	void WriteToFile(const std::string& str);
};

//OBJECT_ENTRY_AUTO(__uuidof(QCTextStream), CQCTextStream)
