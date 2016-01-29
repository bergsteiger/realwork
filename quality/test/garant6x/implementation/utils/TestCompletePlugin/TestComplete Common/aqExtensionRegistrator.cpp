// =============================================================================================
// AutomatedQA SDK - Copyright (c) AutomatedQA Corp.
//
// This file is part of AutomatedQA SDK
//
// =============================================================================================

// CaqExtensionRegistrator.cpp : Implementation of CaqExtensionRegistrator

#include "stdafx.h"
#include "aqExtensionRegistrator.h"

// CaqExtensionRegistrator

CaqExtensionRegistrator::CaqExtensionRegistrator()
{
	int i;
	for (i = 0; i < (sizeof(cAllIntegrationType) / sizeof(cAllIntegrationType[0])); i++)
		m_target_integration.push_back( *(cAllIntegrationType[i]) );
	for (i = 0; i < (sizeof(cAllProduct) / sizeof(cAllProduct[0])); i++)
		m_target_product.push_back( *(cAllProduct[i]) );
	m_key = CLSID_NULL;
}

void CaqExtensionRegistrator::SetDescription(const GUID& key, const ATL::CComBSTR& name, const ATL::CComBSTR& copyright)
{
	_ASSERT( key != CLSID_NULL );
	m_key       = key;
	m_name      = name;
	m_copyright = copyright;
}

void CaqExtensionRegistrator::AddPlugin(const CRegPluginInfo* reg_info)
{
	_ASSERT( reg_info != NULL );
	_ASSERT( reg_info->PluginCreator != NULL );
	m_plugins_info.push_back(*reg_info);
}

void CaqExtensionRegistrator::AddPlugin(const PLUGIN_CREATION_PROC PluginCreator,
                                        const GUID&                Key,
                                        const ATL::CComBSTR&       Name,
                                        const ATL::CComBSTR&       Description,
                                        const AQ_PLUGIN_VERSION&   Version,
                                              BOOL                 DefaultSelected,
                                        const GUID_VECTOR&         Conflicts,
                                        const GUID_VECTOR&         Depends)
{
	CRegPluginInfo reg_info;
	reg_info.PluginCreator   = PluginCreator;
	reg_info.Key             = Key;
	reg_info.Name            = Name;
	reg_info.Description     = Description;
	reg_info.Version         = Version;
	reg_info.DefaultSelected = DefaultSelected;
	reg_info.Conflicts       = Conflicts;
	reg_info.Depends         = Depends;

	AddPlugin(&reg_info);
}

void CaqExtensionRegistrator::SetTargetIntegration(std::vector<GUID> targets)
{
	_ASSERT( targets.size() > 0 );
	m_target_integration = targets;
}

void CaqExtensionRegistrator::SetTargetProduct(std::vector<GUID> targets)
{
	_ASSERT( targets.size() > 0 );
	m_target_product = targets;
}


// IaqExtensionRegistrator Methods

HRESULT STDMETHODCALLTYPE CaqExtensionRegistrator::get_Name(BSTR * Value)
{
	_ASSERT( Value != NULL );
	return m_name.CopyTo(Value);
}

HRESULT STDMETHODCALLTYPE CaqExtensionRegistrator::get_Copyright(BSTR * Value)
{
	_ASSERT( Value != NULL );
	return m_copyright.CopyTo(Value);
}

HRESULT STDMETHODCALLTYPE CaqExtensionRegistrator::get_TargetIntegrationCount(long * Value)
{
	_ASSERT( Value != NULL );
	*Value = (long)m_target_integration.size();
	return S_OK;
}

HRESULT STDMETHODCALLTYPE CaqExtensionRegistrator::get_TargetIntegrationKey(long Index, GUID * Value)
{
	_ASSERT( Value != NULL );
	if ((Index < 0) || (Index >= (long)m_target_integration.size())) return E_INVALIDARG;
	*Value = m_target_integration[Index];
	return S_OK;
}

HRESULT STDMETHODCALLTYPE CaqExtensionRegistrator::get_TargetProductCount(long * Value)
{
	_ASSERT( Value != NULL );
	*Value = (long)m_target_product.size();
	return S_OK;
}

HRESULT STDMETHODCALLTYPE CaqExtensionRegistrator::get_TargetProductKey(long Index, GUID * Value)
{
	_ASSERT( Value != NULL );
	if ((Index < 0) || (Index >= (long)m_target_product.size())) return E_INVALIDARG;
	*Value = m_target_product[Index];
	return S_OK;
}

HRESULT STDMETHODCALLTYPE CaqExtensionRegistrator::get_PluginCount(long * Value)
{
	_ASSERT( Value != NULL );
	*Value = (long)m_plugins_info.size();
	return S_OK;
}

HRESULT STDMETHODCALLTYPE CaqExtensionRegistrator::get_PluginKey(long Index, GUID * Value)
{
	_ASSERT( Value != NULL );
	if ((Index < 0) || (Index >= (long)m_plugins_info.size())) return E_INVALIDARG;
	*Value = m_plugins_info[Index].Key;
	return S_OK;
}

HRESULT STDMETHODCALLTYPE CaqExtensionRegistrator::get_PluginName(long Index, BSTR * Value)
{
	_ASSERT( Value != NULL );
	if ((Index < 0) || (Index >= (long)m_plugins_info.size())) return E_INVALIDARG;
	return m_plugins_info[Index].Name.CopyTo(Value);
}

HRESULT STDMETHODCALLTYPE CaqExtensionRegistrator::get_PluginDescription(long Index, BSTR * Value)
{
	_ASSERT( Value != NULL );
	if ((Index < 0) || (Index >= (long)m_plugins_info.size())) return E_INVALIDARG;
	return m_plugins_info[Index].Description.CopyTo(Value);
}

HRESULT STDMETHODCALLTYPE CaqExtensionRegistrator::get_PluginVersion(long Index, AQ_PLUGIN_VERSION * Value)
{
	_ASSERT( Value != NULL );
	if ((Index < 0) || (Index >= (long)m_plugins_info.size())) return E_INVALIDARG;
	*Value = m_plugins_info[Index].Version;
	return S_OK;
}

HRESULT STDMETHODCALLTYPE CaqExtensionRegistrator::get_PluginDefaultSelected(long Index, VARIANT_BOOL * Value)
{
	_ASSERT( Value != NULL );
	if ((Index < 0) || (Index >= (long)m_plugins_info.size())) return E_INVALIDARG;
	*Value = (m_plugins_info[Index].DefaultSelected) ? VARIANT_TRUE : VARIANT_FALSE;
	return S_OK;
}

HRESULT STDMETHODCALLTYPE CaqExtensionRegistrator::get_PluginDependencyCount(long Index, long * Value)
{
	_ASSERT( Value != NULL );
	if ((Index < 0) || (Index >= (long)m_plugins_info.size())) return E_INVALIDARG;
	*Value = (long)m_plugins_info[Index].Depends.size();
	return S_OK;
}

HRESULT STDMETHODCALLTYPE CaqExtensionRegistrator::get_PluginDependencies(long Index, long DependsIndex, GUID * Value)
{
	_ASSERT( Value != NULL );
	if ((Index < 0) || (Index >= (long)m_plugins_info.size())) return E_INVALIDARG;
	if ((DependsIndex < 0) || (DependsIndex >= (long)m_plugins_info[Index].Depends.size())) return E_INVALIDARG;
	*Value = m_plugins_info[Index].Depends[DependsIndex];
	return S_OK;
}

HRESULT STDMETHODCALLTYPE CaqExtensionRegistrator::get_PluginConflictCount(long Index, long * Value)
{
	_ASSERT( Value != NULL );
	if ((Index < 0) || (Index >= (long)m_plugins_info.size())) return E_INVALIDARG;
	*Value = (long)m_plugins_info[Index].Conflicts.size();
	return S_OK;
}

HRESULT STDMETHODCALLTYPE CaqExtensionRegistrator::get_PluginConflicts(long Index, long ConflictIndex, GUID * Value)
{
	_ASSERT( Value != NULL );
	if ((Index < 0) || (Index >= (long)m_plugins_info.size())) return E_INVALIDARG;
	if ((ConflictIndex < 0) || (ConflictIndex >= (long)m_plugins_info[Index].Conflicts.size())) return E_INVALIDARG;
	*Value = m_plugins_info[Index].Conflicts[ConflictIndex];
	return S_OK;
}

HRESULT STDMETHODCALLTYPE CaqExtensionRegistrator::CreatePlugin(long Index, IaqBasePlugin * * Value)
{
	_ASSERT( Value != NULL );
	if ((Index < 0) || (Index >= (long)m_plugins_info.size())) return E_INVALIDARG;

	return m_plugins_info[Index].PluginCreator(Value);
}


// IaqKeyItem Methods

void STDMETHODCALLTYPE CaqExtensionRegistrator::GetKey(GUID * Value)
{
	_ASSERT( Value != NULL );
	_ASSERT( m_key != CLSID_NULL ); // SetDescription must be called
	*Value = m_key;
}
