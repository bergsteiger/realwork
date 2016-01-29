// dllmain.h : Declaration of module class.

class CQCFileComponentsModule : public CAtlDllModuleT< CQCFileComponentsModule >
{
public :
	DECLARE_LIBID(LIBID_QCFileComponentsLib)
	DECLARE_REGISTRY_APPID_RESOURCEID(IDR_QCFILECOMPONENTS, "{5F075226-3484-4A6E-B0BD-FC644936AFFF}")
};

extern class CQCFileComponentsModule _AtlModule;
