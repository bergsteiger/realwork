#include "shared/Core/fix/mpcxc.h"
/*
 * cvs id was here
 */

#include <cstdio>
#include <stdio.h>
#include <cstdio>
#include <cstring>
#include <fcntl.h>
#ifndef __USE_HOARD__
	#include <cstdlib>
#endif
#include "deltamerger.h"
#include "deltadef.h"
#include "dhreader.h"
#include "garver.h"
#include "Logger.h"
#include "osdep.h"
#include "dltcomon.h"
#include "garutils.h"
#include "timer.h"
#include "pthread.h"

#include "shared\GCL\alg\set_operations.h"

#define DeltaRead fread
extern Logger logger;

inline int pthread_mutex_lock_log(pthread_mutex_t *a_, FILE *thlog)
{
	int	a = (int)a_;

	if( thlog == 0 )
		printf("real locking: no logger %x\n", a);
	else
	{
		fprintf(thlog, "real locking %x\n", a);
		fflush(thlog);
	}

	return pthread_mutex_lock(a_);
}

inline int pthread_mutex_unlock_log(pthread_mutex_t *a_, FILE *thlog)
{
	int	a = (int)a_;

	if( thlog == 0 )
		printf("real unlocking: no logger %x\n", a);
	else
	{
		fprintf(thlog, "real unlocking %x\n", a);
		fflush(thlog);
	}

	return pthread_mutex_unlock(a_);
}

DeltaMerger::DeltaMerger ( unsigned long mlim, unsigned long dlim ) : m_phsMemLimit(mlim), m_dayLimit(dlim)
{
	delta_version = 0;
}		

DeltaMerger::InDeltas	DeltaMerger::openDeltas ( const SplaySet<SString> &inFiles )
{	
	InDeltas delta;

	for ( Point p = inFiles.first(); p; inFiles.next(p) ) {
		Point		added = delta.addInFile( inFiles(p) );
		
		DHReader	*pHeader = new DHReader ( delta(added).file, 0 );

		switch ( pHeader -> IsOK () )
		{
			case DHRS_BADVER :
				if (delta_version == 0) {
					delta_version = pHeader->Version ();
				} else {
					if (delta_version != pHeader->Version ()) {
						printf ( "Wrong delta version.\n" );
						{
							DeltaMerger::InvalidVersion ex (delta(added).name, DEFINE_DELTA_DATA_VERSION);
							throw ex;
						}
					}
				}
				break;

			case DHRS_BADSIZE :
				printf ( "Wrong delta size.\n" );
				{
					DeltaMerger::InvalidSize ex (delta(added).name);
					throw ex;
				}
			break;

			case DHRS_OK :			
				break;

			default :
				printf ( "Unknown error.\n" );
				{
					DeltaMerger::UnknownError ex (delta(added).name);
					throw ex;
				}
				break;
		}		

		if ( p == inFiles.first() ) {
			delta.period.old_date = pHeader->GetOldRev ();
			delta.period.new_date = pHeader->GetNewRev ();
			delta.classId = pHeader->GetClassId ();
			delta.version = pHeader->Version ();
			delta_version = delta.version;
		} else {
			revision rev;
			if ( CompRevs ( &delta.period.old_date, &(rev=pHeader->GetOldRev ()) ) ) {
				printf ( "Different old revision in two deltas\n" );
				char buf[128];
				printf ( "\tin first delta: %s\n", sprintRev( buf, &delta.period.old_date ) );
				printf ( "\tin %s: %s\n", (char*) delta(added).name, sprintRev( buf, &rev ) );
				
				Period badrev ( delta.period.old_date, rev );
				DeltaMerger::DifferentRev ex (delta(added).name, badrev, 1);
				throw ex;
			}
			if ( CompRevs ( &delta.period.new_date, &(rev=pHeader->GetNewRev ()) ) ) {
				printf ( "Different new revision in two deltas\n" );
				Period badrev ( delta.period.new_date, rev );
				DeltaMerger::DifferentRev ex (delta(added).name, badrev, 0);
				throw ex;
			}
			if ( delta.classId != pHeader->GetClassId () ) {
				printf ( "Different class version in two deltas\n" );
				DeltaMerger::DifferentClass ex (delta(added).name, pHeader->GetClassId ());
				throw ex;
			}
		}

		unsigned short seg;
		{
			short count;
			short * pseg = pHeader->LoadSegs ( count );

			if ( count > 1 )
			{
				printf ( "No multy-segs delta support\n" );
				DeltaMerger::MultySegs ex (delta(added).name);
				throw ex;
			}
			seg = *pseg;
			free ( pseg );
		}
		delta.segs.add ( seg );
		delta(added).seg = seg;
		delta(added).docCount = pHeader->GetDocCount();
		//delta.files.add ( infile );		

		//printf ( "\tDelta %s included\n", (char*)delta(added).name );
		delete pHeader;
	}

	if (delta_version == 0)
		delta_version = DEFINE_DELTA_DATA_VERSION;

	return delta;
}

///////////////////////////////////////////////////////////////////////////////
//
// Здесь мы загружаем дельты в памяти
//

template<class DeltaContainer>
void add_delta_to_cache ( long doc_id, typename DeltaContainer::mapped_type& delta, DeltaContainer& container ) {
	typename DeltaContainer::const_iterator it = container.find (doc_id);

	if (it == container.end ()) {
		std::vector<char> tmp;
		std::swap (tmp, delta.data);
		std::pair<DeltaContainer::iterator, bool> result =
			container.insert (DeltaContainer::value_type (doc_id, delta));
		std::swap (tmp, result.first->second.data);
	} else if (it->second.data != delta.data) {
		throw std::runtime_error ("Same documents delta has different body");
	}
}

int DeltaMerger::loadDeltas (const SplaySet<SString> &inFiles)
{	
	Timer tm ( 0, lt_debug, "loading time" );

	//
	// Сюда мы загружаем дельты
	//
	InDeltas inDelta;

	//
	// Открываем дельты, ложим их в память
	//
	inDelta = openDeltas (inFiles);
		
	//
	// Проверяем не пересекается ли загруженная дельта с дельтами в кэше
	//   по наличию сегментов, если да то ексепшион
	//
	{
		SplaySet<unsigned short>	overlapp = inDelta.segs;
		overlapp &= setSegs (inDelta.period);
		if (overlapp.length ()) {
			printf ( "Can't load overlapping deltas\n" );
			Overlapping ex (overlapp);
			throw ex;
		}
	}

	//
	// Здесь проверяем необходимость выгрузки дельт из памяти и выгружаем периоды
	//
	checkForUnloading ( 0 );
	
	for ( Point p = inDelta.first(); p; inDelta.next(p) ) {
		DeltaCache* cache = &m_mapDelta[inDelta.period];
		cache->classId = inDelta.classId;
		cache->version = inDelta.version;

		printf ( "Loading delta: \"%s\"...", (char*)inDelta(p).name );

		FILE* file = inDelta(p).file;
		unsigned short seg = inDelta(p).seg;
		cache->segs.insert (seg);
				
		// SEGMENTS BASE INFO DIFF
		//printf ( "\n\t loading BaseInfo diff..." );

		char mask;
		DeltaRead ( &mask, sizeof(char), 1, file );
		
		if ( mask ) {
			BaseInfoDiff bid;
			DeltaRead ( bid.Name, BASE_NAME_SIZE, 1, file );
			DeltaRead ( bid.NameEng, BASE_NAME_SIZE, 1, file );
			DeltaRead ( bid.AuthorName, NAME_SIZE, 1, file );
			DeltaRead ( &bid.Weight, sizeof (bid.Weight), 1, file );
			DeltaRead ( &bid.SplashTopic, sizeof (bid.SplashTopic), 1, file );
			DeltaRead ( &bid.BannerTopic, sizeof (bid.BannerTopic), 1, file );
			cache->mapBInfos.insert (std::map<unsigned short, BaseInfoDiff>::value_type ( seg, bid ));
		}

		// VARIBLE PART DIFF
		//printf ( "\t loading var-part diff ..." );

		unsigned short varcount;
		DeltaRead ( &varcount, sizeof (varcount), 1, file );
		for ( unsigned short su=0; su < varcount; su++ ) {
			unsigned short id;
			long size;
			
			DeltaRead ( &id, sizeof (id), 1, file );
			DeltaRead ( &size, sizeof ( size ), 1, file );

			switch (id) {
				case DVAR_GLMAPP :
					{
						int check_same_entry = 1; //!!!
						long key_len;				
						DeltaRead ( &key_len, 1, sizeof(key_len), file );
						std::vector<char> key (key_len);
						if (key_len) {
							DeltaRead ( &key[0], sizeof (char), key_len, file );
						}

						long data_len = size - sizeof(key_len) - key_len;
						if ( !data_len )
							break;

						std::vector<char> data (data_len);
						if (data_len) {
							DeltaRead (&data[0], sizeof (char), data_len, file);
						}
				
						DeltaCache::GLMapContainer::const_iterator mapit_atkey = cache->mapGLMap.find (key);
						if (mapit_atkey == cache->mapGLMap.end ()) {
							cache->mapGLMap.insert (DeltaCache::GLMapContainer::value_type (key, data));
						} else if (check_same_entry) {
							const std::vector<char>& atkey = mapit_atkey->second;
							if (atkey != data) {
								logger.printf ( lt_error, "Same GL map key (%s) delta has different body\n", std::string (&key[0], key.size ()).c_str () );
								unloadSegDelta ( inDelta.period, seg );
								DifferentBody ex ( (char*)inDelta(p).name, 0 );
								throw ex;
							}
						}

						break;
					}

				default:
					DeltaCache::VarsContainer::const_iterator map_it = cache->mapVars.find (id);
					if (map_it == cache->mapVars.end ()) {
						std::vector<char> vd (size);
						if (size) {
							DeltaRead (&vd[0], sizeof (char), size, file);
						}
						cache->mapVars.insert (DeltaCache::VarsContainer::value_type (id, vd));
					} else {
						fseek (file, size, ACE_OS_SEEK_CUR);
					}
			}
		}

		{
			//key6
			if (cache->key6_delcount == -1) {
				int i;
				DeltaRead (&cache->key6_delcount, sizeof (cache->key6_delcount), 1, file);
				if (cache->key6_delcount) {
					cache->key6_keys_to_delete.resize (cache->key6_delcount);
					DeltaRead (&cache->key6_keys_to_delete[0], sizeof (long), cache->key6_delcount, file);
				}

				DeltaRead (&cache->key6_addcount, sizeof (cache->key6_addcount), 1, file);
				for (i = 0; i < cache->key6_addcount; i++) {
					long to_add, str_size;
					DeltaRead (&to_add, sizeof (to_add), 1, file);
					cache->key6_to_add_id.push_back (to_add);
					DeltaRead (&str_size, sizeof (str_size), 1, file);
					char* str = (char*) malloc (str_size);
					DeltaRead (str, str_size, 1, file);
					cache->key6_to_add_key.push_back (str);
					gk_free (str);
				}
			} else {
				long dummy, i;
				DeltaRead (&dummy, sizeof (dummy), 1, file);
				if (dummy)
					fseek (file, sizeof (long) * dummy, ACE_OS_SEEK_CUR);
				DeltaRead (&dummy, sizeof (dummy), 1, file);
				for (i = 0; i < dummy; i++) {
					fseek (file, sizeof (long), SEEK_CUR);
					long str_size;
					DeltaRead (&str_size, sizeof (str_size), 1, file);
					fseek (file, sizeof (char) * str_size, ACE_OS_SEEK_CUR);
				}
			}
		}

		// DOCS DELTA
		//printf ( "\t loading documents diff..." );
		logger.GetPolicy()->SetLogLevel (lt_debug);
		for ( long l = 0; l < inDelta(p).docCount; l++ ) {
			long id;
			DeltaRead (&id, sizeof (id), 1, file);
			cache->docs[seg].push_back (id);

			unsigned long fptDeltaStart = ftell (file);

			long size;
			DeltaRead (&size, sizeof (size), 1, file);

			DocDelta delta;
			char mask;
			if (size < 0) {
				size = -size;
				DeltaRead (&delta.unpacked_size, sizeof (long), 1, file);
				DeltaRead (&delta.mask, 1, 1, file);
				mask = delta.mask;
				size -= sizeof (mask) + sizeof (delta.unpacked_size) + sizeof (long);
			} else {				
				delta.unpacked_size = 0;
				DeltaRead (&mask, 1, 1, file);
				fseek (file, (long)fptDeltaStart, ACE_OS_SEEK_SET);
			}
			delta.type = mask & M_DOC_ORD;

			if (size) {
				delta.data.resize (size);
				DeltaRead (&delta.data[0], sizeof (char), size, file);
			}

			try {
				if (delta.type == O_DOC_NEW) {
					add_delta_to_cache (id, delta, cache->map_new_docs);
				} else {
					add_delta_to_cache (id, delta, cache->map_chg_docs);
				}
				cache->mapDocs[seg].add (id, delta.type);
			} catch (std::runtime_error&) {
				logger.printf ( lt_error, "Same documents (%ld) delta has different body\n", id );
				unloadSegDelta (inDelta.period, seg);
				DifferentBody ex ((char*)inDelta(p).name, id);
				throw ex;
			}
		}

		// DOCKIND'S SECOND STREAM DIFF
		//printf ( "\t loading main menu diff..." );

 		long	lKeyCount = 0;
		DeltaRead (&lKeyCount, sizeof ( lKeyCount ), 1, file);
		while (lKeyCount--) {
			long keyLen = 0, dataLen = 0;

			// XXX todo: чтобы не менять формат дельты читаем левый байт
			DeltaRead (&keyLen, sizeof(keyLen), 1, file);
			std::vector<char> keystr (keyLen - 1);
			if (keyLen - 1) {
				DeltaRead (&keystr[0], sizeof (char), keyLen - 1, file);
			}
			char dummy_char_for_delta_format = 0;
			DeltaRead (&dummy_char_for_delta_format, sizeof (char), 1, file);
			DeltaRead (&dataLen, sizeof(dataLen), 1, file);
				
			std::vector<char> dkDiff (dataLen);
			if (dataLen) {
				DeltaRead (&dkDiff[0], sizeof (char), dataLen, file);
			}

			DeltaCache::DKindsContainer::iterator map_it = cache->mapDKinds.find (seg);
			if (map_it == cache->mapDKinds.end ()) {
				DeltaCache::DKCache dkcache;
				dkcache.insert (DeltaCache::DKCache::value_type (keystr, dkDiff));
				cache->mapDKinds.insert (DeltaCache::DKindsContainer::value_type (seg, dkcache));
			} else {
				map_it->second.insert (DeltaCache::DKCache::value_type (keystr, dkDiff));
			}
		}
			
		// BLOB INDEX DIFF
		//printf ( "\t loading BLOB diff..." );
		long count = 0;
		DeltaRead ( &count, sizeof (count), 1, file );

		while ( count-- ) {
			ObjKey objkey;
			DeltaRead (&objkey, sizeof (ObjKey), 1, file);
			short order;
			DeltaRead (&order, sizeof (order), 1, file);
					
			// calculate full diff length
			long len = 0;
			unsigned long fptDeltaStart = ftell (file);

			if ( order & BO_INFCHG ) {
				len += sizeof (ObjInfo);		
				fseek ( file, sizeof(ObjInfo), ACE_OS_SEEK_CUR );
			}
			if ( order & BO_OBJCHG ) {
				long dataLen;
				DeltaRead ( &dataLen, sizeof(dataLen), 1, file );
				len += sizeof(dataLen) + dataLen;
				fseek ( file, dataLen, ACE_OS_SEEK_CUR );
			}
			if ( order & BO_TALCHG ) {
				long dataLen;
				DeltaRead ( &dataLen, sizeof(dataLen), 1, file );
				len += sizeof(dataLen) + dataLen;
				fseek ( file, dataLen, ACE_OS_SEEK_CUR );
			}
			if ( order & BO_BELCHG ) {
				long dataLen;
				DeltaRead ( &dataLen, sizeof(dataLen), 1, file );
				len += sizeof(dataLen) + dataLen;
				fseek ( file, dataLen, ACE_OS_SEEK_CUR );
			}
			fseek ( file, (long)fptDeltaStart, ACE_OS_SEEK_SET );

			BlobDelta delta;
			delta.type = order;
			if (len) {
				delta.data.resize (len);
				DeltaRead (&delta.data[0], sizeof (char), len, file);
			}

			cache->blobs[seg].push_back (objkey);
			
			try {
				if ((order & BO_ORDER_MASK) == BO_BLBNEW) {
					add_delta_to_cache (objkey.id, delta, cache->map_new_blobs);
				} else {
					add_delta_to_cache (objkey.id, delta, cache->map_chg_blobs);
				}
				cache->mapBlobs[seg].add (objkey.id, order);
			} catch (std::runtime_error&) {
				logger.printf ( lt_error, "Same documents (%ld) delta has different body\n", objkey.id );
				unloadSegDelta (inDelta.period, seg);
				DifferentBody ex ((char*)inDelta(p).name, objkey.id);
				throw ex;
			}
		}
		
		// deleted Blobs
		DeltaRead ( &count, sizeof ( count ), 1, file );
		if (count) {
			cache->del_blobs[seg].resize (count);
			DeltaRead ( &cache->del_blobs[seg][0], sizeof ( ObjKey ), count, file );
		}
			
		// DELETED DOCS
		//printf ( "\t loading deleted documents..." );

		long id;
		DeltaRead (&id, sizeof (id), 1, file);
		while (id != NEW_ID) {
			cache->del_docs[seg].push_back (id);
			DeltaRead (&id, sizeof (id), 1, file);
		}

		// CORRESPONDENT DIFF
		//printf ( "\t loading correspondents diff..." );

		//printf ("seg: %ld\n", (long)seg);
		CorrsContainer& corrs = cache->corrs_by_segment_container[seg];
		DeltaRead ( &count, sizeof (count), 1 , file );
		corrs.reserve (corrs.size () + count);
		while (count--) {
			DeltaRead (&id, sizeof (id), 1 , file);
			CorrDocData corr_doc_data (seg);

			long count2;
			DeltaRead ( &count2, sizeof (count2), 1 , file );
			if (count2) {
				cache->corr_containers.push_back (CorrsRefContainer ());
				u_int32_t index = cache->corr_containers.size () - 1;
				cache->corr_containers[index].resize (count2);
				DeltaRead ( &cache->corr_containers[index][0], sizeof (Ref), count2, file );
				corr_doc_data.delCorrIndex = index;
			} else {
				corr_doc_data.delCorrIndex = 0;
			}

			DeltaRead ( &count2, sizeof (count2), 1 , file );
			if (count2) {
				cache->corr_containers.push_back (CorrsRefContainer ());
				u_int32_t index = cache->corr_containers.size () - 1;
				cache->corr_containers[index].resize (count2);
				DeltaRead ( &cache->corr_containers[index][0], sizeof (Ref), count2, file );
				corr_doc_data.addCorrIndex = index;
			} else {
				corr_doc_data.addCorrIndex = 0;
			}

			if (!corr_doc_data.addCorrIndex && !corr_doc_data.delCorrIndex) {
				continue;
			}

			corrs.push_back (id);
			CorrsByIdContainer::iterator it = cache->corrs_for_doc.find (id);
			if (it != cache->corrs_for_doc.end ()) {
				it->second.push_back (corr_doc_data);
			} else {
				CorrDocDataContainer corr_doc_data_container (1);
				corr_doc_data_container[0] =  corr_doc_data;
				cache->corrs_for_doc.insert (CorrsByIdContainer::value_type (id, corr_doc_data_container));
			}
		}

		// NEWCORR DIFF
		//printf ( "\tloading newcorr diff...\n" );
		NewCorrsContainer& new_corrs = cache->new_corrs_by_segment_container[seg];
		DeltaRead ( &count, sizeof (count), 1 , file );
		new_corrs.reserve (new_corrs.size () + count);
		while (count--) {
			DeltaRead (&id, sizeof (id), 1 , file);
			NewCorrDocData new_corr_doc_data (seg);

			long count2;
			DeltaRead ( &count2, sizeof (count2), 1 , file );
			if (count2) {
				cache->new_corr_containers.push_back (NewCorrsRefContainer ());
				u_int32_t index = cache->new_corr_containers.size () - 1;
				cache->new_corr_containers[index].resize (count2);
				DeltaRead ( &cache->new_corr_containers[index][0], sizeof (CorrRef), count2, file );
				new_corr_doc_data.delCorrIndex = index;
			} else {
				new_corr_doc_data.delCorrIndex = 0;
			}

			DeltaRead ( &count2, sizeof (count2), 1 , file );
			if (count2) {
				cache->new_corr_containers.push_back (NewCorrsRefContainer ());
				u_int32_t index = cache->new_corr_containers.size () - 1;
				cache->new_corr_containers[index].resize (count2);
				DeltaRead ( &cache->new_corr_containers[index][0], sizeof (CorrRef), count2, file );
				new_corr_doc_data.addCorrIndex = index;
			} else {
				new_corr_doc_data.addCorrIndex = 0;
			}

			DeltaRead ( &count2, sizeof (count2), 1 , file );
			if (count2) {
				cache->new_corr_containers.push_back (NewCorrsRefContainer ());
				u_int32_t index = cache->new_corr_containers.size () - 1;
				cache->new_corr_containers[index].resize (count2);
				DeltaRead ( &cache->new_corr_containers[index][0], sizeof (CorrRef), count2, file );
				new_corr_doc_data.andCorrIndex = index;
			} else {
				new_corr_doc_data.andCorrIndex = 0;
			}

			if (!new_corr_doc_data.addCorrIndex && !new_corr_doc_data.delCorrIndex && !new_corr_doc_data.andCorrIndex) {
				continue;
			}

			new_corrs.push_back (id);
			NewCorrsByIdContainer::iterator it = cache->new_corrs_for_doc.find (id);
			if (it != cache->new_corrs_for_doc.end ()) {
				it->second.push_back (new_corr_doc_data);
			} else {
				NewCorrDocDataContainer new_corr_doc_data_container (1);
				new_corr_doc_data_container[0] =  new_corr_doc_data;
				cache->new_corrs_for_doc.insert (NewCorrsByIdContainer::value_type (id, new_corr_doc_data_container));
			}
		}

		//CONTROL DIFF
		DeltaRead (&count, sizeof (count), 1 , file);
		while (count--) {
			date aDate;
			DeltaRead (&aDate, sizeof(aDate), 1, file);
			bool b_found = false;
			for (std::vector<date>::const_iterator date_it = cache->control_dates.begin (); date_it != cache->control_dates.end (); date_it++) {
				date at_it = *date_it;
				b_found |= !memcmp (&at_it, &aDate, sizeof (date));
			}

			long aLength;
			DeltaRead (&aLength, sizeof (aLength), 1, file);
			aLength /= sizeof (Ref);

			if (b_found) {
				_fseeki64 (file, aLength * sizeof (Ref), ACE_OS_SEEK_CUR);
			} else {
				std::vector<Ref> refs;
				while (aLength--) {
					Ref ref;
					DeltaRead (&ref, sizeof (ref), 1, file);
					refs.push_back (ref);
				}

				cache->control_dates.push_back (aDate);
				cache->control_refs.push_back (refs);
			}
		}

		if (cache->synMdelcount == -1 && cache->synMaddcount == -1) {
			DeltaRead (&cache->synMdelcount, sizeof (cache->synMdelcount), 1, file);
			DeltaRead (&cache->synMaddcount, sizeof (cache->synMaddcount), 1, file);
			if (cache->synMdelcount) {
				cache->synMdel = (char*) malloc (cache->synMdelcount);
				DeltaRead (cache->synMdel, cache->synMdelcount, 1, file);
			} else {
				cache->synMdel = 0;
			}
			if (cache->synMaddcount) {
				cache->synMadd = (char*) malloc (cache->synMaddcount);
				DeltaRead (cache->synMadd, cache->synMaddcount, 1, file);
			} else {
				cache->synMadd = 0;
			}
		} else {
			_fseeki64 (file, cache->synMdelcount + cache->synMaddcount + 2 * sizeof (long), ACE_OS_SEEK_CUR);
		}

		if (cache->CVaraddcount == -1 && cache->CVardelcount == -1) {
			DeltaRead (&cache->CVardelcount, sizeof (cache->CVardelcount), 1, file);
			DeltaRead (&cache->CVaraddcount, sizeof (cache->CVaraddcount), 1, file);
			cache->CVardelsize = cache->CVardelcount * sizeof (long);
			if ( cache->CVardelcount ) {
				cache->CVardel = (char*) malloc (cache->CVardelsize);
				DeltaRead (cache->CVardel, cache->CVardelsize, 1, file );
			} else
				cache->CVardel = 0;

			if (cache->CVaraddcount) {
				long size = cache->CVaraddcount * sizeof (long), _size = size;
				char *temp_buffer = (char*) malloc (size);
				//cache->CVaradd = (char*) malloc (size);
				DeltaRead (temp_buffer, 1, size, file);

				std::vector<std::string> add_words;
				for (int i = 0; i < cache->CVaraddcount; i++) {
					char read;
					DeltaRead (&read, 1, sizeof (read), file);
					std::string str;
					while (read) {
						str += read;
						DeltaRead (&read, 1, sizeof (read), file);
					}
					add_words.push_back (str);
					size += str.size () + 1;
				}
				cache->CVaraddsize = size;
				cache->CVaradd = (char*) malloc (cache->CVaraddsize);
				memcpy (cache->CVaradd, temp_buffer, _size);
				free (temp_buffer);
				char* ptr = cache->CVaradd + _size;
				for (std::vector<std::string>::const_iterator it = add_words.begin (); it != add_words.end (); it++) {
					strcpy (ptr, it->c_str ());
					ptr += strlen (ptr) + 1;
				}
			} else {
				cache->CVaradd = 0;
				cache->CVaraddsize = 0;
			}
		} else {
			_fseeki64 (file, cache->CVaraddsize + cache->CVardelsize + sizeof (long) * 2, ACE_OS_SEEK_CUR);
		}

		if (cache->hashaddcount != -1) {
			_fseeki64 (file, cache->hashaddsize + sizeof (long), ACE_OS_SEEK_CUR);
		} else {
			DeltaRead (&cache->hashaddcount, sizeof(cache->hashaddcount), 1, file);
			cache->hashadd = 0;
			cache->hashaddsize = 0;
			if (cache->hashaddcount) {
				unsigned long saved_pos = ftell (file);
				long size = 0;
				for (int i = 0; i < cache->hashaddcount; i++) {
					char read;
					DeltaRead (&read, 1, sizeof (read), file);
					while (read) {
						DeltaRead (&read, 1, sizeof (read), file);
						size++;
					}
					unsigned long hash;
					DeltaRead (&hash, 1, sizeof (hash), file);
					size += 1 + sizeof (hash);
				}
				cache->hashadd = (char*) malloc (size);
				cache->hashaddsize = size;

				fseek (file, (long)saved_pos, ACE_OS_SEEK_SET);
				size = 0;
				for (int i = 0; i < cache->hashaddcount; i++) {
					char read;
					DeltaRead (&read, 1, sizeof (read), file);
					std::string str;
					while (read) {
						str += read;
						DeltaRead (&read, 1, sizeof (read), file);
					}
					unsigned long hash;
					DeltaRead (&hash, 1, sizeof (hash), file);
					strcpy (cache->hashadd + size, str.c_str ());
					size += str.size () + 1;
					*(unsigned long*)(cache->hashadd + size) = hash;
					size += sizeof (hash);
				}
			}
		}

		if (cache->relef_delcount == -1 && cache->relef_addcount == -1) {
			DeltaRead (&cache->relef_delcount, sizeof (cache->relef_delcount), 1, file);
			cache->relef_del = 0;
			if (cache->relef_delcount) {
				cache->relef_delsize = cache->relef_delcount * sizeof (long);
				cache->relef_del = (long*) malloc (cache->relef_delcount * sizeof (long));
				long *ptr = cache->relef_del;
				for (int i = 0; i < cache->relef_delcount; i++, ptr++)
					DeltaRead (ptr, sizeof (long), 1, file);
			}
			DeltaRead (&cache->relef_addcount, sizeof (cache->relef_addcount), 1, file);
			cache->relef_add = 0;
			if (cache->relef_addcount) {
				cache->relef_addsize = cache->relef_addcount * sizeof (long);
				cache->relef_add = (long*) malloc (cache->relef_addcount * sizeof (long));
				long *ptr = cache->relef_add;
				for (int i = 0; i < cache->relef_addcount; i++, ptr++)
					DeltaRead (ptr, sizeof (long), 1, file);
			}
		} else {
			_fseeki64 (file, sizeof (long) * 2 + cache->relef_delcount * sizeof (long) + cache->relef_addcount * sizeof (long), ACE_OS_SEEK_CUR);
		}

		if (cache->typingerrors_delcount == -1 && cache->typingerrors_addcount == -1) {
			DeltaRead (&cache->typingerrors_delcount, sizeof (cache->typingerrors_delcount), 1, file);
			cache->typingerrors_del = 0;
			if (cache->typingerrors_delcount) {
				long size = 0;
				for (int i = 0; i < cache->typingerrors_delcount; i++) {
					char read;
					DeltaRead (&read, 1, sizeof (read), file);
					std::string str;
					while (read) {
						str += read;
						DeltaRead (&read, 1, sizeof (read), file);
					}

					cache->typingerrors_del = (char*) realloc (cache->typingerrors_del, size + str.size () + 1);
					strcpy (cache->typingerrors_del + size, str.c_str ());
					size += str.size () + 1;
				}
				cache->typingerrors_delsize = size;
			} else {
				cache->typingerrors_delsize = 0;
			}
			DeltaRead (&cache->typingerrors_addcount, sizeof (cache->typingerrors_addcount), 1, file);
			cache->typingerrors_add = 0;
			if (cache->typingerrors_addcount) {
				long size = 0;
				for (int i = 0; i < cache->typingerrors_addcount; i++) {
					char read;
					DeltaRead (&read, 1, sizeof (read), file);
					std::string key, value;
					while (read) {
						key += read;
						DeltaRead (&read, 1, sizeof (read), file);
					}
					DeltaRead (&read, 1, sizeof (read), file);
					while (read) {
						value += read;
						DeltaRead (&read, 1, sizeof (read), file);
					}

					cache->typingerrors_add = (char*) realloc (cache->typingerrors_add, size + key.size () + value.size () + 2);
					strcpy (cache->typingerrors_add + size, key.c_str ());
					strcpy (cache->typingerrors_add + size + key.size () + 1, value.c_str ());
					size += key.size () + value.size () + 2;
				}
				cache->typingerrors_addsize = size;
			} else {
				cache->typingerrors_addsize = 0;
			}
		} else {
			_fseeki64 (file, sizeof (long) * 2 + cache->typingerrors_addsize + cache->typingerrors_delsize, ACE_OS_SEEK_CUR);
		}

		if (cache->goodwords_addcount == -1 && cache->goodwords_delcount == -1) {
			DeltaRead (&cache->goodwords_delcount, sizeof (cache->goodwords_delcount), 1, file);
			cache->goodwords_del = 0;
			long size = 0;
			if (cache->goodwords_delcount) {
				std::vector<std::string> del_words;
				for (int i = 0; i < cache->goodwords_delcount; i++) {
					char read;
					DeltaRead (&read, 1, sizeof (read), file);
					std::string str;
					while (read) {
						str += read;
						DeltaRead (&read, 1, sizeof (read), file);
					}
					del_words.push_back (str);
					size += str.size () + 1;
				}

				cache->goodwords_del = (char*) malloc (size);
				char* ptr = cache->goodwords_del;
				for (std::vector<std::string>::const_iterator it = del_words.begin (); it != del_words.end (); it++) {
					strcpy (ptr, it->c_str ());
					ptr += strlen (ptr) + 1;
				}
			}
			cache->goodwords_delsize = size;

			DeltaRead (&cache->goodwords_addcount, sizeof (cache->goodwords_addcount), 1, file);
			size = 0;
			if (cache->goodwords_addcount) {
				std::vector<std::string> add_words;
				for (int i = 0; i < cache->goodwords_addcount; i++) {
					char read;
					DeltaRead (&read, 1, sizeof (read), file);
					std::string str;
					while (read) {
						str += read;
						DeltaRead (&read, 1, sizeof (read), file);
					}
					size += str.size () + 1;
					add_words.push_back (str);
				}
				cache->goodwords_add = (char*) malloc (size);
				char* ptr = cache->goodwords_add;
				for (std::vector<std::string>::const_iterator it = add_words.begin (); it != add_words.end (); it++) {
					strcpy (ptr, it->c_str ());
					ptr += strlen (ptr) + 1;
				}				
			}
			cache->goodwords_addsize = size;
		} else {
			_fseeki64 (file, cache->goodwords_delsize + cache->goodwords_addsize + sizeof (long) * 2, ACE_OS_SEEK_CUR);
		}

		if (cache->kindCorrsize == -1) {
			DeltaRead( &cache->kindCorrsize, sizeof(cache->kindCorrsize), 1, file );
			if (cache->kindCorrsize) {
				cache->kindCorrdiff = (char*) malloc (cache->kindCorrsize);
				DeltaRead( cache->kindCorrdiff, cache->kindCorrsize, 1, file);
			} else
				cache->kindCorrdiff = 0;
		} else {
			_fseeki64 (file, sizeof (long) + cache->kindCorrsize, ACE_OS_SEEK_CUR);
		}

		if (cache->Ssyndelcount == -1 && cache->Ssynaddcount == -1) {
			DeltaRead (&cache->Ssyndelcount, sizeof (cache->Ssyndelcount), 1, file);
			DeltaRead (&cache->Ssynaddcount, sizeof (cache->Ssynaddcount), 1, file);
			if (cache->Ssyndelcount) {
				cache->Ssyndel = (char*) malloc (cache->Ssyndelcount);
				DeltaRead (cache->Ssyndel, cache->Ssyndelcount, 1, file);
			} else {
				cache->Ssyndel = 0;
			}
			if (cache->Ssynaddcount) {
				cache->Ssynadd = (char*) malloc (cache->Ssynaddcount);
				DeltaRead (cache->Ssynadd, cache->Ssynaddcount, 1, file);
			} else {
				cache->Ssynadd = 0;
			}
		} else {
			_fseeki64 (file, cache->Ssyndelcount + cache->Ssynaddcount + 2 * sizeof (long), ACE_OS_SEEK_CUR);
		}

		long seg_count;
		DeltaRead (&seg_count, sizeof (seg_count), 1, file);

		if (seg_count) {
			long seg, size;
			DeltaRead (&seg, sizeof (seg), 1, file);
			DeltaRead (&size, sizeof (size), 1, file);
			void* data = malloc (size);
			DeltaRead (data, size, 1, file);
			cache->map_seg_searchcachesize.insert (std::map<unsigned short, long>::value_type ((unsigned short)(seg & 0x7FFF), size));
			cache->map_seg_searchcachedata.insert (std::map<unsigned short, void*>::value_type ((unsigned short)(seg & 0x7FFF), data));
		}

		printf ( "done\n" );

		// make deltas last used
		SegDelta sd ( inDelta.period, seg );
		m_lastUsed.add ( sd );
	}

	return 1;
}

int DeltaMerger::assemblingDelta (Settings& settings)
{		
	Timer tm ( 0, lt_debug, "assembling time" );
	
	// check cache for deltas presents
	if (m_mapDelta.find (settings.period) == m_mapDelta.end ()) {
		char buf [128];
		printf ( "\nSpecified period dosn't exist in cache\n" );
		printf ( "\told : %s; new : %s\n", sprintRev (buf, &settings.period.old_date), sprintRev (buf + 64, &settings.period.new_date));
		UnexistPeriod ex;
		throw ex;
	}

	// make existing deltas last used
	Point p;
	for ( p = settings.mrg_segs.first(); p; settings.mrg_segs.next(p) )
		m_lastUsed.activate ( settings.period, settings.mrg_segs.contents(p) );	
	
	if (!(settings.mrg_segs <= setSegs(settings.period))) {
		SplaySet<unsigned short> unex = settings.mrg_segs;
		unex -= setSegs (settings.period);
		
		printf ( "\nSpecified segments dosn't exist in cache\n" );
		UnexistSegs ex (unex);
		throw ex;
	}

	DeltaCache* cache = &m_mapDelta[settings.period];

	//
	// Ставим флаг, что эту дельту мы уже использовали, и ее могут выгрузить
	//
	cache->m_used ++;

	char buf[1024];
	strcpy ( buf, settings.out_name );
	FillDeltaName ( buf+strlen(buf), settings.period.old_date, settings.period.new_date, 'D', 1 );

	printf ( "Assembling new delta: \"%s\"...", buf );

	FILE* file = mpcxc_fopen ( buf, "w+b" );
	//FILE* file = mpcxc_fopen ( "nul", "w+b" );
	if (!file) {
		printf ( "\nFile open failure (%s)\n", buf );
		perror ("error is");
		CreateError ex ( buf );
		throw ex;
	}

	//printf ( "\n\t merging documents..." );

	std::vector<long> mrgDocs, mrgDelDocs;
	for (p = settings.mrg_segs.first(); p; settings.mrg_segs.next(p)) {
		unsigned short seg = settings.mrg_segs.contents (p);
		mrgDocs.insert (mrgDocs.end (), cache->docs[seg].begin (), cache->docs[seg].end ());
		mrgDelDocs.insert (mrgDelDocs.end (), cache->del_docs[seg].begin (), cache->del_docs[seg].end ());
	}
	GCL::unique_helper (mrgDocs);
	GCL::unique_helper (mrgDelDocs);
	//printf ( "done\n");

	// DELTA TXT HEADER
	//printf ( "\t writing delta header..." );
	{
		LogFile deltafile ( file );
		deltafile.SelfCode ( cd_dos );
		logtype_t lt_delta ( 0, "DELTA BODY" );
		logger.Devices ( lt_delta ).Add ( &deltafile );
			
		long fpTextEnd = 0;
		unsigned long len = 0;
		fwrite ( &len, sizeof (len) , 1, file );

		struct log_struct lsTxtLog;
		lsTxtLog.pDltName = buf;
		lsTxtLog.pCompName = "пользовательский";
		lsTxtLog.pOldRev = &settings.period.old_date;
		lsTxtLog.pNewRev = &settings.period.new_date;
		lsTxtLog.segs = &settings.mrg_segs;

		fprintLog ( &logger, lt_delta, &lsTxtLog, "\n******************* ФАЙЛ ПАКЕТНОГО ОБНОВЛЕНИЯ СИСТЕМЫ ГАРАНТ *******************\n", 0, delta_version );
		logger.printf ( lt_delta, "********************************************************************************\n" );
	
#ifdef	_WIN64
		fpTextEnd = (unsigned long) _ftelli64 (file);
#else
		fpTextEnd = ftell (file);
#endif
		len = (unsigned long)fpTextEnd;
		rewind ( file );
		fwrite ( &len, sizeof (len) , 1, file );
		fseek ( file, (unsigned long)fpTextEnd, ACE_OS_SEEK_SET );
	}
		
	// DELTA VERSION
	{
		short siDeltaVersion = (short)(delta_version & 0x7FFF)/*DEFINE_DELTA_DATA_VERSION*/;
		fwrite ( &siDeltaVersion, sizeof ( short ), 1, file );
	}
	
	// DUMY BYTES FOR PROTECT
	{
		long crc = 0;
		short isCrypt = 0;
		fwrite ( &crc, sizeof (crc), 1, file );
		fwrite ( &isCrypt, sizeof (isCrypt), 1, file );
	}	
	
	// SEGMENTS LIST
	{
		short len = (short) settings.mrg_segs.length();
		fwrite ( &len, sizeof ( len ), 1, file );
		for ( p = settings.mrg_segs.first(); p; settings.mrg_segs.next(p) )
			fwrite ( settings.mrg_segs[p], sizeof (short), 1, file );
	}
			
	// CLASS ID	AND REVISIONS
	{
		fwrite ( &cache->classId, sizeof ( cache->classId ), 1, file );
		fwrite ( &settings.period.old_date, sizeof ( settings.period.old_date ), 1, file );
		fwrite ( &settings.period.new_date, sizeof ( settings.period.new_date ), 1, file );
	}

	// DOC COUNT
	{
		long count = mrgDocs.size ();
		fwrite (&count, sizeof (count), 1, file);
	}

	// DELTA SIZE CONTROLL DUMMY
	unsigned long ulDeltaSize = 0;
	unsigned long fpSizeDummyPos = ftell (file);
	fwrite ( &ulDeltaSize, sizeof ( ulDeltaSize ), 1, file );

	//printf ( "done\n" );

	// BASE-INFO DIFF FOR ALL SEGMENTS
	//printf ( "\t writing BaseInfo diff..." );
	{
		for ( p = settings.mrg_segs.first(); p; settings.mrg_segs.next(p) ) {
			char mask = cache->mapBInfos.find (settings.mrg_segs(p)) != cache->mapBInfos.end ();
			fwrite ( &mask, sizeof (mask), 1, file );
		}

		for ( p = settings.mrg_segs.first(); p; settings.mrg_segs.next(p) ) {
			std::map <unsigned short, BaseInfoDiff>::const_iterator map_it = cache->mapBInfos.find (settings.mrg_segs(p));
			if (map_it != cache->mapBInfos.end ()) {
				BaseInfoDiff diff = map_it->second;
				fwrite ( &diff, sizeof (BaseInfoDiff), 1, file);
			}
		}
	}
	//printf ( "done\n" );

	// VARIBLE PART DIFF
	//printf ( "\t writing var-part diff..." );
	{
		unsigned short count = (unsigned short) cache->mapVars.size () + cache->mapGLMap.size ();
		fwrite (&count, sizeof (count), 1, file);
		
		// save GL mapiing parts
		for (int cycle = 0; cycle < 2; cycle++) {
			for (DeltaCache::GLMapContainer::const_iterator mapgl_it = cache->mapGLMap.begin (); mapgl_it != cache->mapGLMap.end (); mapgl_it++) {
				unsigned short id = DVAR_GLMAPP;
				const std::vector<char>& key = mapgl_it->first;
				long key_size = key.size ();
				const std::vector<char>& data = mapgl_it->second;
				long data_size = data.size ();
				long var_size = data.size () + sizeof (long) + key_size;

				if ((key [0] == '!' && cycle == 0) || (key [0] != '!' && cycle == 1))
					continue;
				
				fwrite (&id, sizeof (id), 1, file);
				fwrite (&var_size, sizeof (var_size), 1, file);
				fwrite (&key_size, sizeof (key_size), 1, file);
				if (key_size) {
					fwrite (&key[0], sizeof (char), key_size, file);
				}
				if (data_size) {
					fwrite (&data[0], sizeof (char), data_size, file);
				}
			}
		}

		// save other Var parts
		for (DeltaCache::VarsContainer::const_iterator mapvar_it = cache->mapVars.begin (); mapvar_it != cache->mapVars.end (); mapvar_it++) {
			unsigned short id = mapvar_it->first;;
			const std::vector<char>& data = mapvar_it->second;
			long size = data.size ();
						
			fwrite (&id, sizeof (id), 1, file);
			fwrite (&size, sizeof ( size ), 1, file);
			if (!data.empty ()) {
				fwrite (&data[0], sizeof (char), size, file);
			}
		}
	}
	//printf ( "done\n" );

	{
		//key6
		std::vector<long>::const_iterator it;
		std::vector<std::string>::const_iterator str_it;
		fwrite( &cache->key6_delcount, sizeof(cache->key6_delcount), 1, file );
		for (it = cache->key6_keys_to_delete.begin (); it != cache->key6_keys_to_delete.end (); it++) {
			long to_delete = *it;
			fwrite (&to_delete, sizeof (to_delete), 1, file);
		}
		fwrite( &cache->key6_addcount, sizeof(cache->key6_addcount), 1, file );
		for (it = cache->key6_to_add_id.begin (), str_it = cache->key6_to_add_key.begin (); it != cache->key6_to_add_id.end (); it++, str_it++) {
			long to_add = *it, str_len = str_it->size () + 1;
			fwrite (&to_add, sizeof (to_add), 1, file);
			fwrite (&str_len, sizeof (str_len), 1, file);
			fwrite (str_it->c_str (), str_len, 1, file);
		}
	}

	// DOCS DELTA
	//printf ( "\t writing documents delta..." );
	std::vector<long>::const_iterator doc_it;
	for (doc_it = mrgDocs.begin (); doc_it != mrgDocs.end (); doc_it++) {
		long id = *doc_it;
		fwrite (&id, sizeof (long), 1, file);
		
		bool b_chg = false;
		for ( Point p2 = settings.mrg_segs.first(); p2; settings.mrg_segs.next(p2) ) {
			unsigned short seg = settings.mrg_segs(p2); 
			if ( cache->mapDocs[seg].contains(id)) {
				char type = cache->mapDocs[seg][id];
				if (type == O_DOC_CHG) {
					b_chg = true;
					break;
				}
			}
		}

		const DocDelta *delta;
		if (b_chg && (cache->map_chg_docs.find (id) != cache->map_chg_docs.end ())) {
			delta = &cache->map_chg_docs.find (id)->second;
		} else {
			delta = &cache->map_new_docs.find (id)->second;
		}

		unsigned long size = delta->data.size ();		
		if (delta->unpacked_size) {
			//пакованная дельта
			long u_size = -((long)(size + sizeof (char) + sizeof (long) + sizeof (long)));
			fwrite (&u_size, sizeof (long), 1, file);
			fwrite (&delta->unpacked_size, sizeof (long), 1, file);
			fwrite (&delta->mask, sizeof (char), 1, file);
		}
		fwrite (&delta->data[0], sizeof (char), size, file);
	}
	//printf ( "done\n" );

	// DOCKIND'S SECOND STREAM
	//printf ( "\t writing main menu diff..." );
	{
		DeltaCache::DKCache mrgDK;

		for (p = settings.mrg_segs.first(); p; settings.mrg_segs.next(p) ) {
			DeltaCache::DKindsContainer::const_iterator map_it = cache->mapDKinds.find (settings.mrg_segs(p));
			if (map_it != cache->mapDKinds.end ()) {
				const DeltaCache::DKCache* dkc = &map_it->second;
				for (DeltaCache::DKCache::const_iterator dkc_it = dkc->begin (); dkc_it != dkc->end (); dkc_it++)
					mrgDK.insert (DeltaCache::DKCache::value_type (dkc_it->first, dkc_it->second));
			}
		}

 		long count = mrgDK.size ();
		fwrite (&count, sizeof (count), 1, file);
		
		for (DeltaCache::DKCache::const_iterator map_it = mrgDK.begin (); map_it != mrgDK.end (); map_it++) {
			const std::vector<char>& key = map_it->first;
			const std::vector<char>& data = map_it->second;
			// XXX todo: чтобы не менять формат дельты пишем левый байт
			long keyLen = key.size ();
			long dataLen = data.size ();

			fwrite (&keyLen, sizeof (keyLen), 1, file);
			if (keyLen) {
				fwrite (&key[0], sizeof (char), keyLen, file);
			}
			char dummy_char_for_delta_format = 0;
			fwrite (&dummy_char_for_delta_format, sizeof (char), 1, file);

			fwrite (&dataLen, sizeof (dataLen), 1, file);
			if (!data.empty ()) {
				fwrite (&data[0], sizeof (char), dataLen, file);
			}
		}
	}
	//printf ( "done\n" );
		
	// BLOB 
	//printf ( "\t merging BLOBs..." );

	std::vector<ObjKey> mrgBlobs, mrgDelBlobs;
	for (p = settings.mrg_segs.first(); p; settings.mrg_segs.next(p) ) {
		unsigned short seg = settings.mrg_segs.contents(p);
		mrgBlobs.insert (mrgBlobs.begin (), cache->blobs[seg].begin (), cache->blobs[seg].end ());
		mrgDelBlobs.insert (mrgDelBlobs.begin (), cache->del_blobs[seg].begin (), cache->del_blobs[seg].end ());
	}
	GCL::unique_helper (mrgBlobs);
	GCL::unique_helper (mrgDelBlobs);
	//printf ( "done\n" );
	//printf ( "\t writing BLOBs diff..." );

	long count = mrgBlobs.size ();
	fwrite (&count, sizeof (count), 1, file);

	std::vector<ObjKey>::const_iterator blob_it;
	for (blob_it = mrgBlobs. begin (); blob_it != mrgBlobs.end (); blob_it++) {
		ObjKey key = *blob_it;
		fwrite (&key, sizeof (ObjKey), 1, file);
		
		bool b_chg = false;
		for ( Point p2 = settings.mrg_segs.first(); p2; settings.mrg_segs.next(p2) ) {
			unsigned short seg = settings.mrg_segs(p2); 
			if ( cache->mapBlobs[seg].contains(key.id)) {
				short type = cache->mapBlobs[seg][key.id];
				if ((type & BO_ORDER_MASK) != BO_BLBNEW) {
					b_chg = true;
					break;
				}
			}
		}

		const BlobDelta *delta;
		if (b_chg && (cache->map_chg_blobs.find (key.id) != cache->map_chg_blobs.end ()))
			delta = &cache->map_chg_blobs.find (key.id)->second;
		else
			delta = &cache->map_new_blobs.find (key.id)->second;

		fwrite (&delta->type, sizeof (delta->type), 1, file);
		if (!delta->data.empty ()) {
			fwrite (&delta->data[0], sizeof (char), delta->data.size (), file);
		}
	}

	// DELETED BLOBS
	GCL::set_difference (mrgDelBlobs, mrgBlobs);
	count = mrgDelBlobs.size ();
	fwrite (&count, sizeof ( count ), 1, file);
	if (count) {
		fwrite (&mrgDelBlobs[0], sizeof (ObjKey), count, file);
	}

	//printf ( "done\n" );

	// DELETED DOCS
	//printf ( "\t writing deleted documents..." );
	GCL::set_difference (mrgDelDocs, mrgDocs);
	if (!mrgDelDocs.empty ()) {
		fwrite (&mrgDelDocs[0], sizeof (long), mrgDelDocs.size (), file );
	}

	long brk = NEW_ID;
	fwrite ( &brk, sizeof ( long ), 1, file );
	//printf ( "done\n" );

	// CORRESPONDENTS
	//printf ( "\t writing correspondents diff..." );
	std::vector<long> mrgCorrs;
	for ( p = settings.mrg_segs.first(); p; settings.mrg_segs.next(p) ) {
		unsigned short seg = settings.mrg_segs.contents(p);
		const CorrsContainer& corrs = cache->corrs_by_segment_container[seg];
		GCL::set_union (mrgCorrs, corrs);
	}

	count = mrgCorrs.size ();
	unsigned long fpCorrCountPos = ftell (file);
	fwrite (&count, sizeof (count), 1, file);
	count = 0;
	for (std::vector<long>::const_iterator corrs_it = mrgCorrs.begin (); corrs_it != mrgCorrs.end (); corrs_it++) {
		long id = *corrs_it, len;

		std::vector<Ref> radd, rdel;
		CorrsByIdContainer::iterator it = cache->corrs_for_doc.find (id);
		for (Point p2 = settings.mrg_segs.first (); p2; settings.mrg_segs.next (p2)) {
			unsigned short seg = settings.mrg_segs.contents(p2);
			std::vector<CorrDocData>::iterator corr_doc_it = std::find (it->second.begin (), it->second.end (), seg);

			if (corr_doc_it != it->second.end ()) {
				GCL::set_union (radd, cache->corr_containers[corr_doc_it->addCorrIndex]);
				GCL::set_union (rdel, cache->corr_containers[corr_doc_it->delCorrIndex]);
			}
		}

		std::vector<Ref> rand (radd);
		GCL::set_intersection (rand, rdel);
		GCL::set_difference (radd, rand);
		GCL::set_difference (rdel, rand);

		if (radd.empty () && rdel.empty ())
			continue;

		fwrite (&id, sizeof (id), 1, file);
		count++;

		len = rdel.size ();
		fwrite (&len, sizeof (len), 1, file);
		if (len) {
			fwrite (&rdel[0], sizeof (Ref), len, file);
		}

		len = radd.size ();
		fwrite (&len, sizeof (len), 1, file);
		if (len) {
			fwrite (&radd[0], sizeof (Ref), len, file);
		}
	}
	unsigned long fpNewCorrCountPos = ftell (file);
	fseek (file, (long)fpCorrCountPos, ACE_OS_SEEK_SET);
	fwrite (&count, sizeof (count), 1, file);
	fseek (file, (long)fpNewCorrCountPos, ACE_OS_SEEK_SET);

	//NEWCORR
	//printf ( "\t writing newcorrespondents diff..." );
	NewCorrsContainer mrgNewCorrs;
	for ( p = settings.mrg_segs.first(); p; settings.mrg_segs.next(p) ) {
		unsigned short seg = settings.mrg_segs.contents(p);
		const NewCorrsContainer& new_corrs = cache->new_corrs_by_segment_container[seg];
		GCL::set_union (mrgNewCorrs, new_corrs);
	}

	count = mrgNewCorrs.size ();
	fwrite (&count, sizeof (count), 1, file);
	count = 0;
	for (NewCorrsContainer::const_iterator corrs_it = mrgNewCorrs.begin (); corrs_it != mrgNewCorrs.end (); corrs_it++) {
		long id = *corrs_it, len = 0;

		std::vector<CorrRef> addCorr, delCorr, andCorr;
		NewCorrsByIdContainer::iterator it = cache->new_corrs_for_doc.find (id);
		for (Point p2 = settings.mrg_segs.first (); p2; settings.mrg_segs.next (p2)) {
			unsigned short seg = settings.mrg_segs.contents(p2);
			std::vector<NewCorrDocData>::iterator new_corr_doc_it = std::find (it->second.begin (), it->second.end (), seg);

			if (new_corr_doc_it != it->second.end ()) {
				GCL::set_union (addCorr, cache->new_corr_containers[new_corr_doc_it->addCorrIndex]);
				GCL::set_union (delCorr, cache->new_corr_containers[new_corr_doc_it->delCorrIndex]);
				GCL::set_union (andCorr, cache->new_corr_containers[new_corr_doc_it->andCorrIndex]);
			}
		}

		GCL::set_difference (delCorr, andCorr);
		andCorr = addCorr;
		GCL::set_intersection (andCorr, delCorr);
		GCL::set_difference (addCorr, andCorr);
		GCL::set_difference (delCorr, andCorr);

		if (delCorr.empty () && addCorr.empty ())
			continue;

		count++;
		fwrite (&id, sizeof (id), 1, file);

		len = delCorr.size ();
		fwrite (&len, sizeof (len), 1, file);
		if (len) {
			fwrite (&delCorr[0], sizeof (CorrRef), len, file);
		}

		len = addCorr.size ();
		fwrite (&len, sizeof (len), 1, file);
		if (len) {
			fwrite (&addCorr[0], sizeof (CorrRef), len, file);
		}

		len = 0;
		fwrite (&len, sizeof (len), 1, file);
	}
	unsigned long fpControlPos = ftell (file);
	fseek (file, (long)fpNewCorrCountPos, ACE_OS_SEEK_SET);
	fwrite (&count, sizeof (count), 1, file);
	fseek (file, (long)fpControlPos, ACE_OS_SEEK_SET);

	//CONTROL
	count = cache->control_dates.size ();
	fwrite (&count, sizeof (count), 1, file);
	
	std::vector<date>::const_iterator date_it = cache->control_dates.begin ();
	std::vector<std::vector<Ref> >::const_iterator refs_it = cache->control_refs.begin ();
	for (; date_it != cache->control_dates.end (); date_it++, refs_it++) {
		date aDate = *date_it;
		fwrite (&aDate, sizeof (aDate), 1, file);

		std::vector<Ref> refs = *refs_it;

		long aLen = refs.size () * sizeof (Ref);
		fwrite (&aLen, sizeof (aLen), 1, file);

		if (!refs.empty ()) {
			fwrite (&refs[0], sizeof (Ref), refs.size (), file);
		}
	}

	fwrite( &cache->synMdelcount, sizeof(cache->synMdelcount), 1, file );
	fwrite( &cache->synMaddcount, sizeof(cache->synMaddcount), 1, file );
	if ( cache->synMdelcount )
		fwrite( cache->synMdel, cache->synMdelcount, 1, file );
	if ( cache->synMaddcount )
		fwrite( cache->synMadd, cache->synMaddcount, 1, file );

	fwrite (&cache->CVardelcount, sizeof(cache->CVardelcount), 1, file );
	fwrite (&cache->CVaraddcount, sizeof(cache->CVaraddcount), 1, file );
	if ( cache->CVardelcount )
		fwrite( cache->CVardel, cache->CVardelsize, 1, file );
	if ( cache->CVaraddcount )
		fwrite( cache->CVaradd, cache->CVaraddsize, 1, file );

	fwrite (&cache->hashaddcount, sizeof(cache->hashaddcount), 1, file );
	if ( cache->hashaddcount )
		fwrite( cache->hashadd, cache->hashaddsize, 1, file );

	fwrite (&cache->relef_delcount, sizeof(cache->relef_delcount), 1, file );
	if (cache->relef_delcount)
		fwrite (cache->relef_del, cache->relef_delsize, 1, file );
	fwrite (&cache->relef_addcount, sizeof(cache->relef_addcount), 1, file );
	if (cache->relef_addcount)
		fwrite (cache->relef_add, cache->relef_addsize, 1, file );

	fwrite (&cache->typingerrors_delcount, sizeof(cache->typingerrors_delcount), 1, file );
	if (cache->typingerrors_delcount)
		fwrite (cache->typingerrors_del, cache->typingerrors_delsize, 1, file );
	fwrite (&cache->typingerrors_addcount, sizeof(cache->typingerrors_addcount), 1, file );
	if (cache->typingerrors_addcount)
		fwrite (cache->typingerrors_add, cache->typingerrors_addsize, 1, file );

	fwrite (&cache->goodwords_delcount, sizeof(cache->goodwords_delcount), 1, file );
	if (cache->goodwords_delcount)
		fwrite (cache->goodwords_del, cache->goodwords_delsize, 1, file );
	fwrite (&cache->goodwords_addcount, sizeof(cache->goodwords_addcount), 1, file );
	if (cache->goodwords_addcount)
		fwrite (cache->goodwords_add, cache->goodwords_addsize, 1, file );

	fwrite( &cache->kindCorrsize, sizeof(cache->kindCorrsize), 1, file);
	if (cache->kindCorrsize)
		fwrite( cache->kindCorrdiff, cache->kindCorrsize, 1, file );

	fwrite( &cache->Ssyndelcount, sizeof(cache->Ssyndelcount), 1, file );
	fwrite( &cache->Ssynaddcount, sizeof(cache->Ssynaddcount), 1, file );
	if ( cache->Ssyndelcount )
		fwrite( cache->Ssyndel, cache->Ssyndelcount, 1, file );
	if ( cache->Ssynaddcount )
		fwrite( cache->Ssynadd, cache->Ssynaddcount, 1, file );

	long seg_count = settings.mrg_segs.length ();
	fwrite (&seg_count, sizeof (long), 1, file );
	for (Point p = settings.mrg_segs.first(); p; settings.mrg_segs.next(p)) {
		long seg = settings.mrg_segs.contents(p);
		unsigned short shortseg = (unsigned short)(seg & 0x7FFF);
		fwrite (&seg, sizeof (long), 1, file );
		long size = cache->map_seg_searchcachesize.find (shortseg)->second;
		fwrite (&size, sizeof (long), 1, file );
		void* data = cache->map_seg_searchcachedata.find (shortseg)->second;
		fwrite (data, size, 1, file );
	}

	// WRITE CONTROL SIZE
#ifdef	_WIN64
	unsigned long fptCurrentPos = _ftelli64 (file);
#else
	unsigned long fptCurrentPos = ftell (file);
#endif
	unsigned long ulOffset = (unsigned long) fptCurrentPos;
	fwrite ( &ulOffset, sizeof ( ulOffset ), 1, file );
	fptCurrentPos = ftell (file);
	fseek ( file, fpSizeDummyPos, ACE_OS_SEEK_SET );
	fwrite ( &ulOffset, sizeof ( ulOffset ), 1, file );
	fseek ( file, fptCurrentPos, ACE_OS_SEEK_SET );
	fclose ( file );

	return 1;
}

SplaySet<unsigned short> DeltaMerger::whatForPeriod ( Period& p )
{
	if (m_mapDelta.find (p) != m_mapDelta.end ())
		return setSegs (p);
	else {
		SplaySet<unsigned short> empty;
		return empty;
	}
}

SplaySet<Period> DeltaMerger::getAllPeriods ()
{
	SplaySet<Period> per;

	for (std::map<Period, DeltaCache>::const_iterator p = m_mapDelta.begin (); p != m_mapDelta.end (); p++) {
		Period atp = p->first;
		per.add (atp);
	}

	return per;
}

void DeltaMerger::printCacheInfo ( logtype_t type )
{
	printf ( "*****************  DeltaMerger Cache Info  *******************\n" );
	char buf [128];
	for (std::map<Period, DeltaCache>::const_iterator p = m_mapDelta.begin (); p != m_mapDelta.end (); p++) {
		Period atp = p->first;
		printf ( "* period: %s - %s                            *\n", sprintRev (buf, &atp.old_date, 1), sprintRev (buf+64, &atp.new_date, 1));
		printf ( "*    content: " );
		
		SplaySet<unsigned short> s = setSegs (atp);
		for ( Point p2 = s.first(); p2; s.next(p2) ) 
			printf ( "%d ", s(p2) );
		printf ( "*\n" );
	}
	printf ( "*****************  Last Used Delta List  *********************\n" );
	for (Point p = m_lastUsed.first(); p; m_lastUsed.next(p) )
		printf ( "* %s - %s : %d                               *\n", sprintRev( buf, &m_lastUsed(p).period.old_date, 1 ), sprintRev( buf+64, &m_lastUsed(p).period.new_date, 1 ), m_lastUsed(p).seg );
	printf ( "**************************************************************\n" );
}

void DeltaMerger::checkCache ( const char* mess )
{
	Point p;
	char buf [128];
	int ret = 1;
	int first = 0;
	
	for ( p = m_lastUsed.first(); p; m_lastUsed.next(p) ) {
		if ( m_mapDelta.find  (m_lastUsed (p).period) != m_mapDelta.end ()) {
			if ( !setSegs(m_lastUsed(p).period).contains(m_lastUsed(p).seg) ) {
				if ( !first ) {
					printf ( "CheckCache failed in: %s\n", mess );
					first = 1;
				}
				printf ( "ERROR in cache: %s - %s unexist seg %d\n",
					sprintRev( buf, &m_lastUsed(p).period.old_date, 1 ), 
					sprintRev( buf+64, &m_lastUsed(p).period.new_date, 1 ), 
					m_lastUsed(p).seg );
				ret = 0;
			}
		} else {
			if ( !first ) {
				printf ( "CheckCache failed in: %s\n", mess );
				first = 1;
			}
			printf ( "ERROR in cache: unexist period %s - %s\n",
				sprintRev( buf, &m_lastUsed(p).period.old_date, 1 ), 
				sprintRev( buf+64, &m_lastUsed(p).period.new_date, 1 ));
			ret = 0;
		}
	}
	
	if ( !ret ) printCacheInfo( lt_debug );	
}

int DeltaMerger::unloadSegDelta ( Period& per, unsigned short seg )
{
	int ret = 0;
	if (m_mapDelta.find (per) != m_mapDelta.end ()) {
		ret = 1;
		DeltaCache* cache = &m_mapDelta [per];

		cache->mapBInfos.erase (seg);
		cache->mapDKinds.erase (seg);
		cache->docs.erase (seg);
		cache->del_docs.erase (seg);
		cache->blobs.erase (seg);
		cache->del_blobs.erase (seg);
		cache->mapDocs.del (seg);
		cache->mapBlobs.del (seg);

		std::map <unsigned short, CorrsContainer>::iterator corrs_docs_it = cache->corrs_by_segment_container.find (seg);
		if (corrs_docs_it != cache->corrs_by_segment_container.end ()) {
			const CorrsContainer& corrs_nums = corrs_docs_it->second;
			for (CorrsContainer::const_iterator corrs_nums_it = corrs_nums.begin (); corrs_nums_it != corrs_nums.end (); ++corrs_nums_it) {
				long doc_id = *corrs_nums_it;
				CorrsByIdContainer::iterator corrs_by_id_it = cache->corrs_for_doc.find (doc_id);
				if (corrs_by_id_it == cache->corrs_for_doc.end ()) {
					continue;
				}
				CorrDocDataContainer& corrs_container = corrs_by_id_it->second;
				CorrDocDataContainer::iterator corrs_it = std::find (corrs_container.begin (), corrs_container.end (), seg);
				if (corrs_it != corrs_container.end ()) {
					if (corrs_it->addCorrIndex)  {
						cache->corr_containers[corrs_it->addCorrIndex].swap (CorrsRefContainer ());
					}
					if (corrs_it->delCorrIndex)  {
						cache->corr_containers[corrs_it->delCorrIndex].swap (CorrsRefContainer ());
					}
					corrs_container.erase (corrs_it);
				}
			}
		}
		cache->corrs_by_segment_container.erase (corrs_docs_it);

		std::map <unsigned short, NewCorrsContainer>::iterator new_corrs_docs_it = cache->new_corrs_by_segment_container.find (seg);
		if (new_corrs_docs_it != cache->new_corrs_by_segment_container.end ()) {
			const NewCorrsContainer& new_corrs_nums = new_corrs_docs_it->second;
			for (NewCorrsContainer::const_iterator new_corrs_nums_it = new_corrs_nums.begin (); new_corrs_nums_it != new_corrs_nums.end (); ++new_corrs_nums_it) {
				long doc_id = *new_corrs_nums_it;
				NewCorrsByIdContainer::iterator new_corrs_by_id_it = cache->new_corrs_for_doc.find (doc_id);
				if (new_corrs_by_id_it == cache->new_corrs_for_doc.end ()) {
					continue;
				}
				NewCorrDocDataContainer& new_corrs_container = new_corrs_by_id_it->second;
				NewCorrDocDataContainer::iterator new_corrs_it = std::find (new_corrs_container.begin (), new_corrs_container.end (), seg);
				if (new_corrs_it != new_corrs_container.end ()) {
					// честно вычистить вектора из new_corr_containers нельзя,
					// так как поплывут все индексы (add, and, del)CorrIndex.
					// todo если будут проблемы с new_corr_containers,
					// нужно будет или избавляться от вектора или честно перещёлкивать все индексы в кеше					
					if (new_corrs_it->addCorrIndex)  {
						cache->new_corr_containers[new_corrs_it->addCorrIndex].swap (NewCorrsRefContainer ());
					}
					if (new_corrs_it->andCorrIndex)  {
						cache->new_corr_containers[new_corrs_it->andCorrIndex].swap (NewCorrsRefContainer ());
					}
					if (new_corrs_it->delCorrIndex)  {
						cache->new_corr_containers[new_corrs_it->delCorrIndex].swap (NewCorrsRefContainer ());
					}
					new_corrs_container.erase (new_corrs_it);
				}
			}
		}
		cache->new_corrs_by_segment_container.erase (new_corrs_docs_it);

		if (cache->map_seg_searchcachedata.find (seg) != cache->map_seg_searchcachedata.end ()) {
			free (cache->map_seg_searchcachedata.find (seg)->second);
			cache->map_seg_searchcachesize.erase (cache->map_seg_searchcachesize.find (seg));
			cache->map_seg_searchcachedata.erase (cache->map_seg_searchcachedata.find (seg));
		}

		SegDelta sd ( per, seg );
		m_lastUsed.del ( sd );		

		cache->segs.erase (seg);
		if (cache->segs.size () == 0)
			m_mapDelta.erase (per);
	} 

	return ret;
}

int DeltaMerger::unloadPeriodDelta ( Period& per )
{
	if (m_mapDelta.find (per) != m_mapDelta.end ()) {
		DeltaCache* cache = &m_mapDelta[per];

		SegDelta sd ( per, 0 );
		SplaySet<unsigned short> s = setSegs(per);
		for ( Point p = s.first(); p; s.next(p) ) {
			sd.seg = s(p);
			m_lastUsed.del ( sd );
		}
		free (cache->synMadd);
		free (cache->synMdel);
		free (cache->CVaradd);
		free (cache->CVardel);
		free (cache->hashadd);
		free (cache->relef_add);
		free (cache->relef_del);
		free (cache->typingerrors_add);
		free (cache->typingerrors_del);
		free (cache->goodwords_add);
		free (cache->goodwords_del);
		free (cache->Ssynadd);
		free (cache->Ssyndel);
		if (cache->kindCorrdiff) free (cache->kindCorrdiff);

		cache->map_chg_docs.clear ();
		cache->map_new_docs.clear ();
		cache->map_chg_blobs.clear ();
		cache->map_new_blobs.clear ();

		m_mapDelta.erase (per);	
		return 1;
	} 
	return 0;
}

#ifdef _WIN32
 void _checkForUnloading (void* pMess)
#elif defined (unix)
 void* _checkForUnloading (void* pMess)
#endif
{
	 //printf ( "checkForUnloading successfully started in thread\n" );
	 		 
	 try {
		((DeltaMerger*)pMess)->checkForUnloading ( 0 );
	 } catch (...) {
		 printf ( "checkForUnloading thread stoped by exception\n" );
	 }

#if defined (unix)
	return 0;
#endif	
}

void DeltaMerger::checkForUnloading ( int inThread )
{
	if ( inThread ) {
#ifdef _WIN32
		if ( _beginthread ( _checkForUnloading, 4, this ) == -1 ) {
#elif defined (unix)
		pthread_t tid;
		pthread_create(&tid, 0, _checkForUnloading, this );
		if ( tid == 0 ) {
#else
 		#error "Don't know how to create thread"
#endif
			printf ( "Can't fork a checkForUnloading thread\n" );
		} 
	} else {
		//int unloadingPolicy = 1; // !!!
		if ( m_phsMemLimit ) unloadingByUsedMem();
		if ( m_dayLimit ) unloadingByPeriod();
		//else printf ( "Unknown unloading policy\n" );
	}	
}

void DeltaMerger::unloadingByUsedMem ()
{
	unsigned long totUsed;
	while ( (totUsed = getUsedPhsMem (&logger, lt_debug)) > m_phsMemLimit ) {		
		Period lp;
		unsigned short ls (0);
		printf ( "Memory is low, total used: %ld, limit: %ld\n",
			totUsed, m_phsMemLimit );
		
		Timer tm ( 0, lt_debug, "unloading time" );
		
		if ( m_lastUsed.getLastUsed ( lp, ls ) ) {
			if ( unloadSegDelta ( lp, ls ) ) {
				char buf [128];
				printf ( "Unloading delta for seg %d, period %s - %s\n",
					ls, sprintRev( buf, &lp.old_date ), sprintRev( buf+64, &lp.new_date ) );
			} else {					
				char buf [128];
				printf ( "Cant find delta in cache for unloading (seg %d, period %s - %s)\n",
					ls, sprintRev( buf, &lp.old_date ), sprintRev( buf+64, &lp.new_date ) );						
				checkCache ( "unloading" );
				DeltaMerger::UnknownError ex ("Cant unload delta");
				throw ex;
			}
		} else {
			printf ( "Cant get a last used delta\n" );				
			checkCache ( "unloading" );
			DeltaMerger::UnknownError ex ("Cant get a last used delta");
			throw ex;
		}
	}
}

///////////////////////////////////////////////////////////////////////////////
//
// Здесь мы выгружаем дельты которые использовались, если это необходимо
//

void DeltaMerger::unloadingByPeriod ()
{	
	while ( 1 ) {
		Timer tm ( 0, lt_debug, "unloading time" );
			
		long dif = m_mapDelta.size ();
		if (dif == 0) {
			printf ( "Nothing to unload: cache is empty\n" );
			return;
		}

		//
		// Выясняем количество периодов в кэше
		//
		printf ( "full periods is: %ld\n", dif );
		printf ( "They are:\n");

		Period	firstPeriod;
		int	i = 0;
		char	buf [128];

		for (std::map<Period, DeltaCache>::const_iterator p = m_mapDelta.begin (); p != m_mapDelta.end (); p++) {
			i ++;
			firstPeriod = p->first;
			printf ( "\t%d: %s - %s, %d\n", i, sprintRev( buf, &firstPeriod.old_date ), sprintRev( buf + 64, &firstPeriod.new_date ), m_mapDelta[firstPeriod].m_used);
		}
		
		//
		// Если превышем максимальное количество периодов в кэше
		//   то выгружаем те которые были использованы
		//
		if ( dif > (long)m_dayLimit ) {
			{
			Timer tm (0, lt_debug, "dif > (long)m_dayLimit");
			}
			Period	curPeriod;
			int	have, curUsed, iUsed;

			//
			// Проверяем был ли период использавным, если не был то не выгружаем
			//
			have  = 0;
			iUsed = 10000;
			for (std::map<Period, DeltaCache>::const_iterator p = m_mapDelta.begin (); p != m_mapDelta.end (); p++) {
				curPeriod = p->first;
				curUsed   = m_mapDelta[curPeriod].m_used;
				if( (curUsed > 0) && (curUsed < iUsed) ) {
					iUsed = curUsed;
					have  = 1;
					firstPeriod = curPeriod;
				}
			}

			//
			// Если нашли что-то для загрузки
			//
			if( have ) {
				char buf1 [128], buf2 [128];
				sprintRev( buf1, &firstPeriod.old_date );
				sprintRev( buf2, &firstPeriod.new_date );
				char buf [256];
				printf ("have %s - %s", buf1, buf2);
				{
				Timer tm (0, lt_debug, buf);
				}
				//
				// Выгружаем дельту
				//
				if( unloadPeriodDelta ( firstPeriod ) ) {
					printf ( "Unloading all deltas for period %s - %s\n", buf1, buf2);
				} else {
					printf ( "Cant find deltas in cache for unloading (period %s - %s)\n", buf1, buf2 );					
					DeltaMerger::UnknownError ex ("Cant unload delta");
					throw ex;
				}
			}

			return;
		}
		else
			return;
	}
}
