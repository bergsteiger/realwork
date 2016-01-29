////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/impl/GardocsImpl/SearcherImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiAdapterLib::GardocsImpl::SearcherImpl
//
// SearcherImpl - Сишный адаптер
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiAdapterLib/LibHome.h"
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/SearcherImpl.h"
// by <<uses>> dependencies
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemote.h"
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/DataConverter.h"

//#UC START# *4E1447E0018C_CUSTOM_INCLUDES*
//#UC END# *4E1447E0018C_CUSTOM_INCLUDES*

namespace ArchiAdapterLib {
namespace GardocsImpl {

//#UC START# *4E1447E0018C*
static ArchiGate::DocCardRemote::Gardoc make_server_gardoc1 () {
	ArchiGate::DocCardRemote::Gardoc ret;
	ret.type = "ПРИКАЗ";
	ret.date = 1305072020;
	ret.number = "210";
	ret.title = "Об отказе от проведения...";

	ret.ogv_list.length(1);
	ret.ogv_list[0] = "Федеральные министерства и ведомства\\Минэкономразвития России (Министерство экономического развития РФ)";

	ret.blocks.length(1);
	ret.blocks[0]="ARH";

	ret.comment = "Поставить Hang";

	ret.confluence_id = 2;
	ret.topic = 12;
	ret.related = 13;


	const size_t FILE_LENGTH = 42410;
	ret.images.length(2);
	{
		ArchiGate::DocCardRemote::Image image;

		image.data.length (0);
		image.type = ArchiGate::DocCardRemote::giTIF;

		image.src_title = "Бюллетень международных договоров";
		image.src_number = "10";
		image.src_date_start = 1317412800000;
		image.src_date_end = 1320008400000;
		image.src_page = "1";
		ret.images[0] = image;
	}

	{
		ArchiGate::DocCardRemote::Image image;

		image.data.length (FILE_LENGTH);
		FILE* f = fopen("\\\\DEVELOPER\\public\\4ses\\archi-test\\1\\1.tif", "rb");
		fread(image.data.get_buffer(), 1, FILE_LENGTH, f);
		fclose(f);

		image.type = ArchiGate::DocCardRemote::giTIF;

		image.src_title = "[Получено по рассылке]";
		image.src_number = "1";
		image.src_date_start = 0;
		image.src_date_end = 0;
		image.src_page = "";
		ret.images[1] = image;
	}

	ret.timestamp = 1324297320;
	ret.urgency = ArchiGate::DocCardRemote::guOrdinary;
	ret.is_internet = false;
	ret.state =ArchiGate::DocCardRemote::gsNEW;
	return ret;
}

static ArchiGate::DocCardRemote::Gardoc make_server_gardoc2 () {
	ArchiGate::DocCardRemote::Gardoc ret;
	ret.type = "ОПРЕДЕЛЕНИЕ";
	ret.date = 1303344020;
	ret.number = "592-О-О";

	ret.ogv_list.length(1);
	ret.ogv_list[0] = "Органы судебной власти РФ и СССР\\Конституционный Суд России (КС РФ)";

	ret.blocks.length(1);
	ret.blocks[0]="ARB";

	ret.comment = "В ВЕРСИЮ!";

	ret.confluence_id = 3;
	ret.topic = 14;
	ret.related = 15;

	const size_t FILE_LENGTH = 116925;
	ArchiGate::DocCardRemote::Image image;
	image.type = ArchiGate::DocCardRemote::giZIP;

	image.data.length (FILE_LENGTH);
	FILE* f = fopen("\\\\DEVELOPER\\public\\4ses\\archi-test\\2\\2.zip", "rb");
	fread(image.data.get_buffer(), 1, FILE_LENGTH, f);
	fclose(f);

	image.src_title = "[Получено по рассылке]";
	image.src_number = "1";
	image.src_date_start = 0;
	image.src_date_end = 0;
	image.src_page = "";

	ret.timestamp = 1324297330;
	ret.urgency = ArchiGate::DocCardRemote::guInVersion;

	ret.images.length(1);
	ret.images[0] = image;

	ret.is_internet = true;
	ret.state =ArchiGate::DocCardRemote::gsNEW;
	return ret;
}

static ArchiGate::DocCardRemote::GardocList* get_recently_created_since_mock () {
	ArchiGate::DocCardRemote::GardocList_var ret = new ArchiGate::DocCardRemote::GardocList();
	ret->length(2);
	ret->operator[](0) = make_server_gardoc1();
	ret->operator[](1) = make_server_gardoc2();
	return ret._retn();
}
//#UC END# *4E1447E0018C*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SearcherImpl::SearcherImpl ()
//#UC START# *4E1446C9001D_4E1446DD013E_4E1447E0018C_BASE_INIT*
//#UC END# *4E1446C9001D_4E1446DD013E_4E1447E0018C_BASE_INIT*
{
	//#UC START# *4E1446C9001D_4E1446DD013E_4E1447E0018C_BODY*
	//#UC END# *4E1446C9001D_4E1446DD013E_4E1447E0018C_BODY*
}

SearcherImpl::~SearcherImpl () {
	//#UC START# *4E1447E0018C_DESTR_BODY*
	//#UC END# *4E1447E0018C_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Gardocs::Searcher
Gardocs::GardocList* SearcherImpl::get_notop_created_since (
	const GCI::IO::DateTimeBox& date
	, long count
) const /*throw (
	Gardocs::CommunicationFailure
)*/ {
	//#UC START# *521C88540333_4E1447E0018C*
	Core::Aptr<Gardocs::GardocList> ret = new Gardocs::GardocList();
	LOG_D(("%s - START", GDS_CURRENT_FUNCTION));
	try {
		InvocationAspect<ArchiGate::DocCardRemote::Searcher> action;

		ArchiGate::DocCardRemote::GardocList_var response = action.impl->get_notop_created_since (
			DataConverter::total_second_since_1st_jan_1970 (date)
			, count
		);

		//для тестов
		//ArchiGate::DocCardRemote::GardocList_var response = get_recently_created_since_mock();

		for (CORBA::ULong i = 0; i < response->length(); i++) {
			ret->push_back (DataConverter::make_adapter_gardoc (response->operator[](i)));
		}
		LOG_D(("%s - FINISH", GDS_CURRENT_FUNCTION));
		return ret.forget();
	} catch (...) {
		LOG_D(("%s - EXCEPTION", GDS_CURRENT_FUNCTION));
		throw Gardocs::CommunicationFailure();
	}
	//#UC END# *521C88540333_4E1447E0018C*
}

// implemented method from Gardocs::Searcher
// возвращает список новых документов, зарегистрированных в К после date (date - время в
// миллисекундах после 1 января 1970 года, т.е. стандартное)
Gardocs::GardocList* SearcherImpl::get_recently_created_since (
	const GCI::IO::DateTimeBox& date
	, const char* partnerId
) const /*throw (
	Gardocs::CommunicationFailure
)*/ {
	//#UC START# *4E14476B01C7_4E1447E0018C*
	Core::Aptr<Gardocs::GardocList> ret = new Gardocs::GardocList();
	LOG_D(("%s - START", GDS_CURRENT_FUNCTION));
	try {
		InvocationAspect<ArchiGate::DocCardRemote::Searcher> action;

		ArchiGate::DocCardRemote::GardocList_var response = action.impl->get_recently_created_since (
			DataConverter::total_second_since_1st_jan_1970 (date)
		);

		//для тестов
		//ArchiGate::DocCardRemote::GardocList_var response = get_recently_created_since_mock();

		for (CORBA::ULong i = 0; i < response->length(); i++) {
			ret->push_back (DataConverter::make_adapter_gardoc (response->operator[](i)));
		}
		LOG_D(("%s - FINISH", GDS_CURRENT_FUNCTION));
		return ret.forget();
	} catch (...) {
		LOG_D(("%s - EXCEPTION", GDS_CURRENT_FUNCTION));
		throw Gardocs::CommunicationFailure();
	}
	//#UC END# *4E14476B01C7_4E1447E0018C*
}

// implemented method from Gardocs::Searcher
Gardocs::GardocList* SearcherImpl::get_top_created_since (
	const GCI::IO::DateTimeBox& date
	, long count
) const /*throw (
	Gardocs::CommunicationFailure
)*/ {
	//#UC START# *521C8837021D_4E1447E0018C*
	Core::Aptr<Gardocs::GardocList> ret = new Gardocs::GardocList();
	LOG_D(("%s - START", GDS_CURRENT_FUNCTION));
	try {
		InvocationAspect<ArchiGate::DocCardRemote::Searcher> action;

		ArchiGate::DocCardRemote::GardocList_var response = action.impl->get_top_created_since (
			DataConverter::total_second_since_1st_jan_1970 (date)
			, count
		);

		//для тестов
		//ArchiGate::DocCardRemote::GardocList_var response = get_recently_created_since_mock();

		for (CORBA::ULong i = 0; i < response->length(); i++) {
			ret->push_back (DataConverter::make_adapter_gardoc (response->operator[](i)));
		}
		LOG_D(("%s - FINISH", GDS_CURRENT_FUNCTION));
		return ret.forget();
	} catch (...) {
		LOG_D(("%s - EXCEPTION", GDS_CURRENT_FUNCTION));
		throw Gardocs::CommunicationFailure();
	}
	//#UC END# *521C8837021D_4E1447E0018C*
}
} // namespace GardocsImpl
} // namespace ArchiAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

