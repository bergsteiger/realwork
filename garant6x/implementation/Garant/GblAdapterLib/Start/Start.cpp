////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/Start/Start.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Start
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Start/Start.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Start/StartFactories.h"

namespace GblAdapterLib {


const char* IPAddressNotFound::uid () const /*throw ()*/ {
	return "F2BB45BE-4533-476D-95CF-D7E121A195D5";
}

const char* IPAddressNotFound::what () const throw () {
	//#UC START# *45EEE02203CE_WHAT_IMPL*
	return "IPAddressNotFound (������������, ����� �� ������ �� ������ IP ������ ��� ������ ������� (��������� �������: ��� �������� ������� ����������).)";
	//#UC END# *45EEE02203CE_WHAT_IMPL*
}


const char* InvalidBase::uid () const /*throw ()*/ {
	return "96670BC0-148F-4D2D-BDDC-15AE7D32FFAC";
}

const char* InvalidBase::what () const throw () {
	//#UC START# *45EEE02203D8_WHAT_IMPL*
	return "InvalidBase (����������� ��� �������� ����.)";
	//#UC END# *45EEE02203D8_WHAT_IMPL*
}


const char* NoServer::uid () const /*throw ()*/ {
	return "303D9557-8EC2-400C-BF9C-BADEE422A49C";
}

const char* NoServer::what () const throw () {
	//#UC START# *45EEE02203DA_WHAT_IMPL*
	return "NoServer (������������ � ������, ����� �� �����-�� �������� ������ �������� �����������.)";
	//#UC END# *45EEE02203DA_WHAT_IMPL*
}


const char* BadNetworkConfig::uid () const /*throw ()*/ {
	return "1D13BCD4-1DFF-4300-B58D-F7890BAAA58F";
}

const char* BadNetworkConfig::what () const throw () {
	//#UC START# *45EEE02203DC_WHAT_IMPL*
	return "BadNetworkConfig (������������, ���� � ������� 10 ������ �� ������ ����� �� ������� �� �� ���� �� IP �������� �� ������-������� (��������� �������: firewall ��������� `incoming connection` �� �����, ������� ���������� ACE/TAO ��� �������� ������).)";
	//#UC END# *45EEE02203DC_WHAT_IMPL*
}


const char* SMTPServerAddressNotDefined::uid () const /*throw ()*/ {
	return "C5A7C6C4-5834-4B8E-A5A2-4ECC471713C1";
}

const char* SMTPServerAddressNotDefined::what () const throw () {
	//#UC START# *45EEE02203DE_WHAT_IMPL*
	return "SMTPServerAddressNotDefined (�� ����� ����� SMTP �������)";
	//#UC END# *45EEE02203DE_WHAT_IMPL*
}


const char* SMTPServerNotFound::uid () const /*throw ()*/ {
	return "1DA675AE-50AF-474F-8022-1BDEEE14E50B";
}

const char* SMTPServerNotFound::what () const throw () {
	//#UC START# *45EEE02203E0_WHAT_IMPL*
	return "SMTPServerNotFound (���������� �� ����� ����������� c SMTP ��������. �������� ���� �������� ������ � ��� ����� ������ �������.)";
	//#UC END# *45EEE02203E0_WHAT_IMPL*
}


const char* UserNotFound::uid () const /*throw ()*/ {
	return "61872E6E-6284-40DF-B866-6BCAEC608893";
}

const char* UserNotFound::what () const throw () {
	//#UC START# *45EEE02203E2_WHAT_IMPL*
	return "UserNotFound (������������ �� ������)";
	//#UC END# *45EEE02203E2_WHAT_IMPL*
}


const char* ServerVersionNotValid::uid () const /*throw ()*/ {
	return "8FB9BB5A-04F2-4EC2-B183-9AC1347EE390";
}

const char* ServerVersionNotValid::what () const throw () {
	//#UC START# *45EEE02203E4_WHAT_IMPL*
	return "ServerVersionNotValid ()";
	//#UC END# *45EEE02203E4_WHAT_IMPL*
}


const char* InternalServerError::uid () const /*throw ()*/ {
	return "6A6215CF-78F3-49EC-BF9F-50BB4CB9293D";
}

const char* InternalServerError::what () const throw () {
	//#UC START# *45EEE0230000_WHAT_IMPL*
	return "InternalServerError (���������� ������ �������)";
	//#UC END# *45EEE0230000_WHAT_IMPL*
}


const char* WorkingParamsNotFound::uid () const /*throw ()*/ {
	return "085E10E6-7A2A-4F1A-ABF6-AC9A6B700D74";
}

const char* WorkingParamsNotFound::what () const throw () {
	//#UC START# *45EEE0230002_WHAT_IMPL*
	return "WorkingParamsNotFound (�� ������� ���������, ����������� ��� ������ ����������.)";
	//#UC END# *45EEE0230002_WHAT_IMPL*
}


const char* BadSMTPReply::uid () const /*throw ()*/ {
	return "BC028BE4-26A7-4936-B0E9-56AD866D0C05";
}

const char* BadSMTPReply::what () const throw () {
	//#UC START# *45EEE0230004_WHAT_IMPL*
	return "BadSMTPReply ()";
	//#UC END# *45EEE0230004_WHAT_IMPL*
}


const char* SettingsRestoreFails::uid () const /*throw ()*/ {
	return "6ABA3BD8-676F-471F-85F7-604C3270212D";
}

const char* SettingsRestoreFails::what () const throw () {
	//#UC START# *45EEE0230006_WHAT_IMPL*
	return "SettingsRestoreFails ()";
	//#UC END# *45EEE0230006_WHAT_IMPL*
}


const char* ExternalApplicationError::uid () const /*throw ()*/ {
	return "9D512BC1-E36B-425C-94E9-EC550ED838F7";
}

const char* ExternalApplicationError::what () const throw () {
	//#UC START# *45EEE0230008_WHAT_IMPL*
	return "ExternalApplicationError (������ ��� ������ �������� ����������)";
	//#UC END# *45EEE0230008_WHAT_IMPL*
}


const char* AlreadyLogged::uid () const /*throw ()*/ {
	return "8A31DA0B-1697-4FA3-949D-01DC71BE4E18";
}

const char* AlreadyLogged::what () const throw () {
	//#UC START# *46092B23000F_WHAT_IMPL*
	return "AlreadyLogged ()";
	//#UC END# *46092B23000F_WHAT_IMPL*
}


const char* AccountDisabled::uid () const /*throw ()*/ {
	return "9E554518-D746-4CDE-8C5D-847E73A44C74";
}

const char* AccountDisabled::what () const throw () {
	//#UC START# *46092B7B035B_WHAT_IMPL*
	return "AccountDisabled ()";
	//#UC END# *46092B7B035B_WHAT_IMPL*
}


const char* NoMoreConnections::uid () const /*throw ()*/ {
	return "1EBCB8C2-D652-4497-88B7-B6F6DEFC8C86";
}

const char* NoMoreConnections::what () const throw () {
	//#UC START# *4628DED80157_WHAT_IMPL*
	return "NoMoreConnections ()";
	//#UC END# *4628DED80157_WHAT_IMPL*
}


const char* SMTPAuthorizationFailed::uid () const /*throw ()*/ {
	return "78893262-7052-47BD-A3ED-646A5A7B4B1E";
}

const char* SMTPAuthorizationFailed::what () const throw () {
	//#UC START# *480C8B04039B_WHAT_IMPL*
	return "SMTPAuthorizationFailed (��������� ����������� �� �������� �������)";
	//#UC END# *480C8B04039B_WHAT_IMPL*
}


const char* MorphoNotExists::uid () const /*throw ()*/ {
	return "2FC04D3B-B292-420C-B225-71B7ACE65770";
}

const char* MorphoNotExists::what () const throw () {
	//#UC START# *4669565D00FA_WHAT_IMPL*
	return "MorphoNotExists (����������� �����������.)";
	//#UC END# *4669565D00FA_WHAT_IMPL*
}


const char* InternalApplicationError::uid () const /*throw ()*/ {
	return "82E6F745-353D-4022-BE27-AE22DCD2FB3E";
}

const char* InternalApplicationError::what () const throw () {
	//#UC START# *4726F93503AA_WHAT_IMPL*
	return "InternalApplicationError (������ � ��������� gcm)";
	//#UC END# *4726F93503AA_WHAT_IMPL*
}


const char* InvalidUserDatastore::uid () const /*throw ()*/ {
	return "55650D62-B1A8-4834-B197-FC50EF727F69";
}

const char* InvalidUserDatastore::what () const throw () {
	//#UC START# *4815D1ED03B0_WHAT_IMPL*
	return "InvalidUserDatastore (����� ���� ������� ������ �� desktop ������ - ������������� � ����� ���� ������������ (���-�� �� ����������� �������� settings))";
	//#UC END# *4815D1ED03B0_WHAT_IMPL*
}

// factory interface wrapper for Authorization
Authorization* AuthorizationFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, XMLImportRunning)*/ {
	return AuthorizationFactoryManager::Singleton::instance ()->make ();
}


const char* ServerIsStarting::uid () const /*throw ()*/ {
	return "FC547407-1744-4A16-B4B3-6CF86EB0E8C7";
}

const char* ServerIsStarting::what () const throw () {
	//#UC START# *4A93B0F00377_WHAT_IMPL*
	return "ServerIsStarting (������ �������, ��������� � �������� �������)";
	//#UC END# *4A93B0F00377_WHAT_IMPL*
}

// factory interface wrapper for Common
Common* CommonFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return CommonFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for ComponentManager
ComponentManager& ComponentManagerFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ComponentManagerFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for AssemblyInfo
AssemblyInfo* AssemblyInfoFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return AssemblyInfoFactoryManager::Singleton::instance ()->make ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

