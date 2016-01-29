////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/impl/GardocsImpl/DataConverter.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> MDProcess::ArchiAdapterLib::GardocsImpl::DataConverter
//
// DataConvertor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/DataConverter.h"

//#UC START# *4E9319DF02E4_CUSTOM_INCLUDES*
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemote.h"
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/RemoteBigFileAsStream.h"

#include "boost/date_time/posix_time/posix_time.hpp" //include all types plus i/o
#include "boost/date_time/gregorian/gregorian.hpp"
//#UC END# *4E9319DF02E4_CUSTOM_INCLUDES*

namespace ArchiAdapterLib {
namespace GardocsImpl {

//#UC START# *4E9319DF02E4*

//S2A - Server to Adapter
#define S2A_STRING(A) out.A = GCI::IO::StringFactory::make(in.A.in());
#define S2A_SIMPLE_TYPE(A) out.A = in.A;
#define S2A_STRLIST(A) for (CORBA::ULong S2A_STRLIST_I = 0; S2A_STRLIST_I < in.A.length(); S2A_STRLIST_I++) {out.A.push_back (GCI::IO::StringFactory::make(in.A[S2A_STRLIST_I]));}
#define S2A_DATE_TIME(A) out.A = DataConverter::from_total_second_since_1st_jan_1970(in.A);
#define S2A_ENUM_IF(A,E) if (in.A == ArchiGate::DocCardRemote::E) out.A = Gardocs::E;
#define S2A_ENUM2(A,E1,E2)				S2A_ENUM_IF(A,E1) else S2A_ENUM_IF(A,E2)
#define S2A_ENUM3(A,E1,E2,E3)			S2A_ENUM_IF(A,E1) else S2A_ENUM_IF(A,E2) else S2A_ENUM_IF(A,E3)
#define S2A_ENUM4(A,E1,E2,E3,E4)		S2A_ENUM_IF(A,E1) else S2A_ENUM_IF(A,E2) else S2A_ENUM_IF(A,E3) else S2A_ENUM_IF(A,E4)
#define S2A_ENUM5(A,E1,E2,E3,E4,E5)		S2A_ENUM_IF(A,E1) else S2A_ENUM_IF(A,E2) else S2A_ENUM_IF(A,E3) else S2A_ENUM_IF(A,E4) else S2A_ENUM_IF(A,E5)

#define A2S_STRING(A) out.A = in.A.in()->get_data();
#define A2S_SIMPLE_TYPE(A) out.A = in.A;
//#define A2S_STRLIST(A) gardoc_out.A.replace(gardoc_in.A.size(), gardoc_in.A.size(), &(*gardoc_in.A.begin()), false);
#define A2S_DATE_TIME(A) out.A = total_second_since_1st_jan_1970(in.A);

static void s2a_image (Gardocs::Image& out, const ArchiGate::DocCardRemote::Image& in) {
	S2A_ENUM5(type,giTIF,giZIP,giDOC,giRTF,giNSR);

	if (in.data.length() > 0) {
		if (CORBA::is_nil (in.bigFile.in())) {
			out.data = GCI::IO::StreamFactory::make();
			out.data->write (in.data.get_buffer(), in.data.length());
		} else {
			out.data = new RemoteBigFileAsStream (in.data, in.bigFile.in(), 1024*1024);
		}
		LOG_W(("Image 1: %s %s ", in.src_title.in(), in.src_number.in()));
	} else {
		LOG_W(("%s - EMPTY IMAGE", GDS_CURRENT_FUNCTION));
		LOG_W(("Image 2: %s %s %s", in.src_title.in(), in.src_number.in(), in.src_page.in()));
		out.data = 0;
	}

	S2A_STRING(src_title);
	S2A_DATE_TIME(src_date_start);
	S2A_DATE_TIME(src_date_end);
	S2A_STRING(src_number);
	S2A_STRING(src_page);
	S2A_STRLIST(labels);
}

ArchiGate::DocCardRemote::Gardoc DataConverter::make_remote_gardoc (const Gardocs::Gardoc& in) {
	ArchiGate::DocCardRemote::Gardoc out;
	A2S_STRING(type);
	A2S_SIMPLE_TYPE(topic);
	A2S_STRING(title);
	//A2S_STRLIST(ogv_list);
	A2S_STRING(number);
	A2S_STRING(mu_number);
	A2S_DATE_TIME(mu_date);
	A2S_DATE_TIME(date);
	A2S_STRING(comment);
	//A2S_STRLIST(blocks);

	A2S_DATE_TIME(timestamp);
	A2S_SIMPLE_TYPE(confluence_id);
	//A2S_STRING(src_title);
	//A2S_STRING(src_date);
	//A2S_STRING(src_number );
	//A2S_STRING(src_page);

	//a2s_image (gardoc_out, gardoc_in);
	return out;
}

Gardocs::Gardoc DataConverter::make_adapter_gardoc (const ArchiGate::DocCardRemote::Gardoc& in) {
	Gardocs::Gardoc out;
	S2A_STRING(type);
	S2A_SIMPLE_TYPE(topic);
	S2A_STRING(title);
	S2A_STRLIST(ogv_list);
	S2A_STRING(number);
	S2A_STRING(mu_number);
	S2A_DATE_TIME(mu_date);
	S2A_DATE_TIME(date);
	S2A_STRING(comment);
	S2A_STRLIST(blocks);

	S2A_DATE_TIME(timestamp);
	S2A_SIMPLE_TYPE(confluence_id);
	
	S2A_ENUM2(state,gsNEW,gsUPDATED);

	S2A_ENUM4(urgency,guInVersion,guQuickly,guOrdinary,guUnknown);
	S2A_ENUM2(gardoc_type,gtDoc,gtRelated);
	S2A_SIMPLE_TYPE(related);
	S2A_STRING(text);
	S2A_SIMPLE_TYPE(is_internet);


	for (CORBA::ULong i = 0; i < in.images.length(); i++) {
		Gardocs::Image image;
		s2a_image (image, in.images[i]);
		out.images.push_back (image);
	}

	LOG_W (("INCOMING TOPIC:%d DATE:%d-%d-%d", static_cast<long>(out.topic), out.date.day, out.date.mounth, out.date.year));
	return out;
}

long long DataConverter::total_second_since_1st_jan_1970 (const GCI::IO::DateTimeBox& date) {
	const ::boost::posix_time::ptime ptime_1st_jan_1970 = ::boost::posix_time::ptime (
		::boost::gregorian::date(1970, 1, 1)
		, ::boost::posix_time::time_duration(0, 0, 0)
	);

	::boost::posix_time::ptime in_time = ::boost::posix_time::ptime(
		::boost::gregorian::date(date.year, date.mounth, date.day)
		, ::boost::posix_time::time_duration(date.hour, date.minute, date.second)
	);

	::boost::posix_time::time_duration diff = in_time - ptime_1st_jan_1970;
	return diff.total_seconds();
}

GCI::IO::DateTimeBox DataConverter::from_total_second_since_1st_jan_1970 (long long total_second) {
	GCI::IO::DateTimeBox ret = {0, 0, 0, 0, 0, 0, 0};

	if (total_second != 0) {
		::boost::posix_time::ptime in_time = ::boost::posix_time::from_time_t(static_cast<::time_t>(total_second));
		ret.year = in_time.date().year();
		ret.mounth = in_time.date().month();
		ret.day = in_time.date().day();
		ret.hour = static_cast<short>(in_time.time_of_day().hours());
		ret.minute = static_cast<short>(in_time.time_of_day().minutes());
		ret.second = static_cast<short>(in_time.time_of_day().seconds());
	}

	return ret;
}

Gardocs::GardocList* DataConverter::make_adapter_gardoc_list (const ArchiGate::DocCardRemote::GardocList* gardoc_list_remote) {
	Core::Aptr<Gardocs::GardocList> ret = new Gardocs::GardocList();
	for (CORBA::ULong i = 0; i < gardoc_list_remote->length(); i++) {
		ret->push_back (DataConverter::make_adapter_gardoc (gardoc_list_remote->operator[](i)));
	}
	return ret.forget();
}
//#UC END# *4E9319DF02E4*


} // namespace GardocsImpl
} // namespace ArchiAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

