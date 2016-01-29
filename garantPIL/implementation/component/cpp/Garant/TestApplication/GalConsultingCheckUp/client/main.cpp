
#include "shared/Core/sys/std_inc.h"
#include "ace/ACE.h"
#include "ConsultingCheckUp.h"
#include <fstream>

struct AceAutoInit {
	AceAutoInit () {
		ACE::init ();
		LOG_D (("ACE::init"));
	}
	~AceAutoInit () {
		ACE::fini ();
		LOG_D (("ACE::fini"));
	}
};
int main (int argc, char* argv []) {
	AceAutoInit ace_init; // это делать обязательно, если используется ACE
	srand ((unsigned)time (0));
	
	GalConsultingCheckUp::ConsultingCheckUp consulting_client;
	try {
		consulting_client.init (argc, argv);
		consulting_client.execute ();
	} catch (Core::DataNotCorrect&) {
	} catch (Core::DataNotFound&) {
	}
	
	return 0;
}