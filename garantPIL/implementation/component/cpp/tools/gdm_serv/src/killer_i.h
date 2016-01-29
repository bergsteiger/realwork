#ifndef __ORB_KILLER_H__
#define __ORB_KILLER_H__ 1

#include "killer.h"
#include "OrbServer.h"

class OrbKiller_i : public POA_OrbKiller, public PortableServer::RefCountServantBase
{
	ORBServer* m_pServer;
public:
	OrbKiller_i ( ORBServer* server ) : m_pServer(server) {};
	virtual ~OrbKiller_i() {};

	void kill() {
		m_pServer->stopServer();		
	};
};

#endif
