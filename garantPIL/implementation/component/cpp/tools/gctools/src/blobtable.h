#ifndef _blobtable_h
#define _blobtable_h

void generateBlobTable(ThreadCompileInfo& tcinfo, GCParameters *p);
int readBlobTable(ThreadCompileInfo& tcinfo, GCParameters *p);
void rehashBlobTbl(ThreadCompileInfo& tcinfo);

#endif
