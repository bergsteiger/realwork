////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/Gardocs/Gardocs_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::ArchiAdapterLib::Gardocs
//
// Gardoc
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIADAPTERLIB_GARDOCS_TIE_H__
#define __MDPROCESS_ARCHIADAPTERLIB_GARDOCS_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "MDProcess/ArchiAdapterLib/Gardocs/Gardocs.h"
#include "shared/GCI/IO/IO_tie.h"

namespace ArchiAdapterLib {
namespace Gardocs {

class StringList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (StringList_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	StringList_tie ();

	typedef ::Core::PoolObjectManager<StringList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<StringList_tie> Pool;
	friend class ::Core::PoolObjectManager<StringList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const StringList_tie* obj, StringList*& ret_);

	static void make_tie (StringList* obj, StringList_tie*& ret_);
	
	static void make_tie (const StringList& obj, StringList_tie*& ret_);

	static void make_tie (const StringList& obj, StringList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (StringList* obj, StringList_tie*& ret_);

	StringList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, GCI::IO::IString_tie*& ret_);
	virtual void __stdcall set_item (size_t index, const GCI::IO::IString_tie* item);
	virtual size_t __stdcall add (const GCI::IO::IString_tie* item);
	virtual size_t __stdcall insert (size_t index, const GCI::IO::IString_tie* item);
};

#pragma pack (push, 1)

struct Image_tie {
	GCI::IO::IStream_tie* data;
	ImageType type;
	GCI::IO::IString_tie* src_title;
	GCI::IO::IString_tie* src_page;
	GCI::IO::IString_tie* src_number;
	GCI::IO::DateTimeBox src_date_start;
	GCI::IO::DateTimeBox src_date_end;
	StringList_tie* labels;
	
	static void make_cpp (const Image_tie& obj, Image& ret_);

	static void make_tie (const Image& obj, Image_tie& ret_);
};

#pragma pack (pop)

class ImageList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (ImageList_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	ImageList_tie ();

	typedef ::Core::PoolObjectManager<ImageList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ImageList_tie> Pool;
	friend class ::Core::PoolObjectManager<ImageList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const ImageList_tie* obj, ImageList*& ret_);

	static void make_tie (ImageList* obj, ImageList_tie*& ret_);
	
	static void make_tie (const ImageList& obj, ImageList_tie*& ret_);

	static void make_tie (const ImageList& obj, ImageList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (ImageList* obj, ImageList_tie*& ret_);

	ImageList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, Image_tie& ret_);
	virtual void __stdcall set_item (size_t index, const Image_tie& item);
	virtual size_t __stdcall add (const Image_tie& item);
	virtual size_t __stdcall insert (size_t index, const Image_tie& item);
};

#pragma pack (push, 1)

struct Gardoc_tie {
	GCI::IO::IString_tie* type;
	GCI::IO::IString_tie* number;
	GCI::IO::DateTimeBox date;
	StringList_tie* ogv_list;
	GCI::IO::IString_tie* title;
	GCI::IO::IString_tie* mu_number;
	GCI::IO::DateTimeBox mu_date;
	StringList_tie* blocks;
	long long topic;
	GCI::IO::IString_tie* comment;
	ImageList_tie* images;
	long long confluence_id;
	GCI::IO::DateTimeBox timestamp;
	GardocStatus state;
	GCI::IO::IString_tie* text;
	long long related;
	GarDocType gardoc_type;
	GarDocUrgency urgency;
	bool is_internet;
	
	static void make_cpp (const Gardoc_tie& obj, Gardoc& ret_);

	static void make_tie (const Gardoc& obj, Gardoc_tie& ret_);
};

#pragma pack (pop)

#pragma pack (push, 1)

struct ArchiEvent_tie {
	GCI::IO::IString_tie* type;
	Gardoc_tie doc;
	
	static void make_cpp (const ArchiEvent_tie& obj, ArchiEvent& ret_);

	static void make_tie (const ArchiEvent& obj, ArchiEvent_tie& ret_);
};

#pragma pack (pop)

class GardocList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (GardocList_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	GardocList_tie ();

	typedef ::Core::PoolObjectManager<GardocList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<GardocList_tie> Pool;
	friend class ::Core::PoolObjectManager<GardocList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const GardocList_tie* obj, GardocList*& ret_);

	static void make_tie (GardocList* obj, GardocList_tie*& ret_);
	
	static void make_tie (const GardocList& obj, GardocList_tie*& ret_);

	static void make_tie (const GardocList& obj, GardocList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (GardocList* obj, GardocList_tie*& ret_);

	GardocList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, Gardoc_tie& ret_);
	virtual void __stdcall set_item (size_t index, const Gardoc_tie& item);
	virtual size_t __stdcall add (const Gardoc_tie& item);
	virtual size_t __stdcall insert (size_t index, const Gardoc_tie& item);
};

class ISearcher_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall get_notop_created_since_521C88540333 (
		const GCI::IO::DateTimeBox& date
		, long count
		, GardocList_tie*& ret_
	) const /*throw (CommunicationFailure_tie)*/ = 0;

	virtual void __stdcall get_recently_created_since_4E14476B01C7 (
		const GCI::IO::DateTimeBox& date
		, const char* partnerId
		, GardocList_tie*& ret_
	) const /*throw (CommunicationFailure_tie)*/ = 0;

	virtual void __stdcall get_top_created_since_521C8837021D (
		const GCI::IO::DateTimeBox& date
		, long count
		, GardocList_tie*& ret_
	) const /*throw (CommunicationFailure_tie)*/ = 0;
};

class __declspec (dllexport) Searcher_tie: public ISearcher_tie {
	SET_OBJECT_COUNTER (Searcher_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

	virtual ::Core::IObject* get_impl () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	Searcher_tie ();

	typedef ::Core::PoolObjectManager<Searcher_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Searcher_tie> Pool;
	friend class ::Core::PoolObjectManager<Searcher_tie>;
	typedef ::Core::IidMapRegistrator<Searcher_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const ISearcher_tie* obj, Searcher*& ret_, bool interface_addref = false);

	static void make_tie (const Searcher* obj, ISearcher_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Searcher& obj, ISearcher_tie*& ret_, const Core::TIEBase* owner);

	Searcher* m_impl;

protected:
	virtual void __stdcall get_notop_created_since_521C88540333 (
		const GCI::IO::DateTimeBox& date
		, long count
		, GardocList_tie*& ret_
	) const /*throw (CommunicationFailure_tie)*/;

	virtual void __stdcall get_recently_created_since_4E14476B01C7 (
		const GCI::IO::DateTimeBox& date
		, const char* partnerId
		, GardocList_tie*& ret_
	) const /*throw (CommunicationFailure_tie)*/;

	virtual void __stdcall get_top_created_since_521C8837021D (
		const GCI::IO::DateTimeBox& date
		, long count
		, GardocList_tie*& ret_
	) const /*throw (CommunicationFailure_tie)*/;
};

class IArchiEventsListener_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall on_event_4E8F2EDD0294 (
		const ArchiEvent_tie& event
	) const /*throw (CommunicationFailure_tie)*/ = 0;
};

class __declspec (dllexport) ArchiEventsListener_tie: public IArchiEventsListener_tie {
	SET_OBJECT_COUNTER (ArchiEventsListener_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

	virtual ::Core::IObject* get_impl () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	ArchiEventsListener_tie ();

	typedef ::Core::PoolObjectManager<ArchiEventsListener_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ArchiEventsListener_tie> Pool;
	friend class ::Core::PoolObjectManager<ArchiEventsListener_tie>;
	typedef ::Core::IidMapRegistrator<ArchiEventsListener_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IArchiEventsListener_tie* obj, ArchiEventsListener*& ret_, bool interface_addref = false);

	static void make_tie (const ArchiEventsListener* obj, IArchiEventsListener_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const ArchiEventsListener& obj, IArchiEventsListener_tie*& ret_, const Core::TIEBase* owner);

	ArchiEventsListener* m_impl;

protected:
	virtual void __stdcall on_event_4E8F2EDD0294 (
		const ArchiEvent_tie& event
	) const /*throw (CommunicationFailure_tie)*/;
};

class ISearcher2_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall get_notop_created_since_541AB396009A (
		const GCI::IO::DateTimeBox& date
		, long count
		, const char* partnerId
		, GardocList_tie*& ret_
	) const /*throw (CommunicationFailure_tie)*/ = 0;

	virtual void __stdcall get_top_created_since_541AB38E025D (
		const GCI::IO::DateTimeBox& date
		, long count
		, const char* partnerId
		, GardocList_tie*& ret_
	) const /*throw (CommunicationFailure_tie)*/ = 0;
};

class __declspec (dllexport) Searcher2_tie: public ISearcher2_tie {
	SET_OBJECT_COUNTER (Searcher2_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

	virtual ::Core::IObject* get_impl () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	Searcher2_tie ();

	typedef ::Core::PoolObjectManager<Searcher2_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Searcher2_tie> Pool;
	friend class ::Core::PoolObjectManager<Searcher2_tie>;
	typedef ::Core::IidMapRegistrator<Searcher2_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const ISearcher2_tie* obj, Searcher2*& ret_, bool interface_addref = false);

	static void make_tie (const Searcher2* obj, ISearcher2_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Searcher2& obj, ISearcher2_tie*& ret_, const Core::TIEBase* owner);

	Searcher2* m_impl;

protected:
	virtual void __stdcall get_notop_created_since_541AB396009A (
		const GCI::IO::DateTimeBox& date
		, long count
		, const char* partnerId
		, GardocList_tie*& ret_
	) const /*throw (CommunicationFailure_tie)*/;

	virtual void __stdcall get_top_created_since_541AB38E025D (
		const GCI::IO::DateTimeBox& date
		, long count
		, const char* partnerId
		, GardocList_tie*& ret_
	) const /*throw (CommunicationFailure_tie)*/;
};

class IUtils_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall update_old_last_created_time_54999FCF0337 (
		const GCI::IO::DateTimeBox& date
		, GCI::IO::DateTimeBox& ret_
	) const /*throw (CommunicationFailure_tie)*/ = 0;
};

class __declspec (dllexport) Utils_tie: public IUtils_tie {
	SET_OBJECT_COUNTER (Utils_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

	virtual ::Core::IObject* get_impl () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	Utils_tie ();

	typedef ::Core::PoolObjectManager<Utils_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Utils_tie> Pool;
	friend class ::Core::PoolObjectManager<Utils_tie>;
	typedef ::Core::IidMapRegistrator<Utils_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IUtils_tie* obj, Utils*& ret_, bool interface_addref = false);

	static void make_tie (const Utils* obj, IUtils_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Utils& obj, IUtils_tie*& ret_, const Core::TIEBase* owner);

	Utils* m_impl;

protected:
	virtual void __stdcall update_old_last_created_time_54999FCF0337 (
		const GCI::IO::DateTimeBox& date
		, GCI::IO::DateTimeBox& ret_
	) const /*throw (CommunicationFailure_tie)*/;
};

class LongList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (LongList_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	LongList_tie ();

	typedef ::Core::PoolObjectManager<LongList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<LongList_tie> Pool;
	friend class ::Core::PoolObjectManager<LongList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const LongList_tie* obj, LongList*& ret_);

	static void make_tie (LongList* obj, LongList_tie*& ret_);
	
	static void make_tie (const LongList& obj, LongList_tie*& ret_);

	static void make_tie (const LongList& obj, LongList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (LongList* obj, LongList_tie*& ret_);

	LongList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual long long __stdcall get_item (size_t index);
	virtual void __stdcall set_item (size_t index, long long item);
	virtual size_t __stdcall add (long long item);
	virtual size_t __stdcall insert (size_t index, long long item);
};

class IGardocGetter_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall gardocs_by_confluenceid_list_5499A01C011F (
		const LongList_tie* confluenceidList
		, GardocList_tie*& ret_
	) const /*throw (CommunicationFailure_tie)*/ = 0;

	virtual void __stdcall gardocs_by_topic_list_5499A01B0069 (
		const LongList_tie* topicList
		, GardocList_tie*& ret_
	) const /*throw (CommunicationFailure_tie)*/ = 0;
};

class __declspec (dllexport) GardocGetter_tie: public IGardocGetter_tie {
	SET_OBJECT_COUNTER (GardocGetter_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

	virtual ::Core::IObject* get_impl () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	GardocGetter_tie ();

	typedef ::Core::PoolObjectManager<GardocGetter_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<GardocGetter_tie> Pool;
	friend class ::Core::PoolObjectManager<GardocGetter_tie>;
	typedef ::Core::IidMapRegistrator<GardocGetter_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IGardocGetter_tie* obj, GardocGetter*& ret_, bool interface_addref = false);

	static void make_tie (const GardocGetter* obj, IGardocGetter_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const GardocGetter& obj, IGardocGetter_tie*& ret_, const Core::TIEBase* owner);

	GardocGetter* m_impl;

protected:
	virtual void __stdcall gardocs_by_confluenceid_list_5499A01C011F (
		const LongList_tie* confluenceidList
		, GardocList_tie*& ret_
	) const /*throw (CommunicationFailure_tie)*/;

	virtual void __stdcall gardocs_by_topic_list_5499A01B0069 (
		const LongList_tie* topicList
		, GardocList_tie*& ret_
	) const /*throw (CommunicationFailure_tie)*/;
};

} // namespace Gardocs
} // namespace ArchiAdapterLib
	

#endif //__MDPROCESS_ARCHIADAPTERLIB_GARDOCS_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

