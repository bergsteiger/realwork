	SearchBase *base = new CachedBaseRO (argv [1]);
	base->IsOk ();
	base->check_version ();

	Search::SearchProp prop;
	prop.show_short_list = false;
	prop.remove_editions = true;

	revision rev;
	gk_bzero (&rev, sizeof (rev));
	rev.RevisionDate.da_day = 1;
	rev.RevisionDate.da_mon = 1;
	rev.RevisionDate.da_year = 2014;	
	
	Search::ISearcher_var searcher = Search::Factory::make_searcher (base);

	std::map<long,date> map_doc_rev;
	std::set<long> dups;
	while (rev.RevisionDate.da_year < 2015) {
		revision rev_plus_1 = rev;
		localrev_adddays (rev_plus_1, 1);
		char query_str [256];
		sprintf (query_str, "VAnonced(%ld-%ld-%ld;%ld-%ld-%ld) | BOOL(VIncluded(%ld-%ld-%ld;%ld-%ld-%ld) ~ VAnonced(;%ld-%ld-%ld))", rev.RevisionDate.da_day, rev.RevisionDate.da_mon, rev.RevisionDate.da_year, rev.RevisionDate.da_day, rev.RevisionDate.da_mon, rev.RevisionDate.da_year, rev_plus_1.RevisionDate.da_day, rev_plus_1.RevisionDate.da_mon, rev_plus_1.RevisionDate.da_year, rev_plus_1.RevisionDate.da_day, rev_plus_1.RevisionDate.da_mon, rev_plus_1.RevisionDate.da_year, rev.RevisionDate.da_day, rev.RevisionDate.da_mon, rev.RevisionDate.da_year);
		Core::Aptr <Search::SearchResult> ret = searcher->execute (query_str, prop);
		if (0 == ret.is_nil ()) {
			if (0 == ret.in()->list.is_nil ()) {
				printf ("%ld-%ld-%ld : ", rev.RevisionDate.da_day, rev.RevisionDate.da_mon, rev.RevisionDate.da_year);
				DocCollection *docs = (DocCollection*) ret.in()->list.in ();
				for (int i = 0; i < docs->ItemCount; i++) {
					long id = (*docs)[i];
					if (map_doc_rev.find (id) == map_doc_rev.end ()) {
						map_doc_rev.insert (std::map<long,date>::value_type (id, rev.RevisionDate));
					} else {
						dups.insert (id);
					}
					if (i) printf (",");
					printf ("%ld", id);
				}
				printf ("\n");
			}
		}
		rev = rev_plus_1;
	}
	printf ("total:%ld, dups:%ld\n", map_doc_rev.size (), dups.size ());
	for (std::set<long>::const_iterator it = dups.begin (); it != dups.end (); it++)
		printf ("%ld ", *it);

	delete base;
	return 0;
