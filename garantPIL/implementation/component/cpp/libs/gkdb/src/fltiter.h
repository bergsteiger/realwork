#ifndef __GARANT_SHELL_FILTERED_ITERATOR__
#define __GARANT_SHELL_FILTERED_ITERATOR__


class FilteredIterator : public BTIterator {
	protected:
		char ** m_pKeys;
		int m_nKeyCount;
		virtual int CheckCurrentKey(void);
	public:
		FilteredIterator(const BTree * pBTree, BTKEY key=0, char **pfilter =0, int fltsize =0);
		~FilteredIterator();
		virtual void next();
		virtual void prev();
		int Set(BTKEY);
		void SetFilter(char **, int);
		int CheckKey(BTKEY);
};

#endif  // __GARANT_SHELL_FILTERED_ITERATOR__
