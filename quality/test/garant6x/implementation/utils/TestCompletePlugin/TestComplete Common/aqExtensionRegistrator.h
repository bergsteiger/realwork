// =============================================================================================
// AutomatedQA SDK - Copyright (c) AutomatedQA Corp.
//
// This file is part of AutomatedQA SDK
//
// =============================================================================================

// aqExtensionRegistrator.h : Declaration of the CaqExtensionRegistrator

#pragma once

typedef HRESULT (*PLUGIN_CREATION_PROC)(IaqBasePlugin * * Value);
typedef std::vector<GUID> GUID_VECTOR;

// CaqExtensionRegistrator

class ATL_NO_VTABLE CaqExtensionRegistrator : 
	public ATL::CComObjectRootEx<ATL::CComSingleThreadModel>,
	public ATL::CComCoClass<CaqExtensionRegistrator>,
	public IaqExtensionRegistrator
{
public:
	BEGIN_COM_MAP(CaqExtensionRegistrator)
		COM_INTERFACE_ENTRY(IaqExtensionRegistrator)
	END_COM_MAP()

	struct CRegPluginInfo
	{
		PLUGIN_CREATION_PROC PluginCreator;
		GUID                 Key;
		ATL::CComBSTR        Name;
		ATL::CComBSTR        Description;
		AQ_PLUGIN_VERSION    Version;
		BOOL                 DefaultSelected;
		GUID_VECTOR          Conflicts;
		GUID_VECTOR          Depends;
	};

	CaqExtensionRegistrator();
	void SetDescription      (const GUID& key, const ATL::CComBSTR& name, const ATL::CComBSTR& copyright);
	void SetTargetIntegration(GUID_VECTOR targets);
	void SetTargetProduct    (GUID_VECTOR targets);
	void AddPlugin           (const CRegPluginInfo* reg_info);
	void AddPlugin           (const PLUGIN_CREATION_PROC PluginCreator,
	                          const GUID&                Key,
	                          const ATL::CComBSTR&       Name,
	                          const ATL::CComBSTR&       Description,
	                          const AQ_PLUGIN_VERSION&   Version,
	                                BOOL                 DefaultSelected = TRUE,
	                          const GUID_VECTOR&         Conflicts = GUID_VECTOR(),
	                          const GUID_VECTOR&         Depends = GUID_VECTOR());

	// IaqExtensionRegistrator Methods
	STDMETHOD(get_Name)(BSTR * Value);
	STDMETHOD(get_Copyright)(BSTR * Value);
	STDMETHOD(get_TargetIntegrationCount)(long * Value);
	STDMETHOD(get_TargetIntegrationKey)(long Index, GUID * Value);
	STDMETHOD(get_TargetProductCount)(long * Value);
	STDMETHOD(get_TargetProductKey)(long Index, GUID * Value);
	STDMETHOD(get_PluginCount)(long * Value);
	STDMETHOD(get_PluginKey)(long Index, GUID * Value);
	STDMETHOD(get_PluginName)(long Index, BSTR * Value);
	STDMETHOD(get_PluginDescription)(long Index, BSTR * Value);
	STDMETHOD(get_PluginVersion)(long Index, AQ_PLUGIN_VERSION * Value);
	STDMETHOD(get_PluginDefaultSelected)(long Index, VARIANT_BOOL * Value);
	STDMETHOD(get_PluginDependencyCount)(long Index, long * Value);
	STDMETHOD(get_PluginDependencies)(long Index, long DependsIndex, GUID * Value);
	STDMETHOD(get_PluginConflictCount)(long Index, long * Value);
	STDMETHOD(get_PluginConflicts)(long Index, long ConflictIndex, GUID * Value);
	STDMETHOD(CreatePlugin)(long Index, IaqBasePlugin * * Value);

	// IaqKeyItem Methods
	STDMETHOD_(void, GetKey)(GUID * Value);

private:
	std::vector<CRegPluginInfo> m_plugins_info;
	GUID_VECTOR                 m_target_integration;
	GUID_VECTOR                 m_target_product;
	GUID                        m_key;
	ATL::CComBSTR               m_name;
	ATL::CComBSTR               m_copyright;
};
