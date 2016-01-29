#if     _MSC_VER > 1000
#pragma once
#endif

#ifndef _GARANT_QMap_
#define _GARANT_QMap_

#define QuickSplayMap_Alloc_MaxDef 128

#include "shared/Core/fix/mpcxc.h"

typedef void* G_Point;

template <class Key, class Data>
class IQuickSplayMap
{
protected:
	Data	def;
	unsigned int	count;	
	bool m_bMyFree;
public:
#pragma pack(1) 
	struct G_SimpleSplayNode {
		G_SimpleSplayNode* lt;
		G_SimpleSplayNode* rt;
		G_SimpleSplayNode* par;
		Key item;
		Data cont;
		G_SimpleSplayNode() 
			:lt(0), rt(0), par(0) {
		}
	};
#pragma pack() 
	G_SimpleSplayNode* leftmost();
	G_SimpleSplayNode* succ(G_SimpleSplayNode* t);
protected:
	G_SimpleSplayNode* root;

	G_SimpleSplayNode* rightmost();
	G_SimpleSplayNode* pred(G_SimpleSplayNode* t);
	G_SimpleSplayNode* _copy(G_SimpleSplayNode* t);
	virtual void set_ppDelNodes(G_SimpleSplayNode**) = 0;
	virtual void set_NextNode(G_SimpleSplayNode*) = 0;
	virtual G_SimpleSplayNode** get_ppNodes() = 0;
	virtual G_SimpleSplayNode** get_ppDelNodes() = 0;
	virtual G_SimpleSplayNode* get_NextNode() = 0;
	virtual int *p_ppDelNodesCount() = 0;
public:
	virtual void set_ppNodes(G_SimpleSplayNode**) = 0;
	virtual int *p_ppNodesCount() = 0;
	void kill_root();
	G_SimpleSplayNode* GetRootG_SimpleSplayNode() const { return root; }
	IQuickSplayMap(const Data& dflt, int reAllocF= 1, int reAllocS= 0) : def(dflt), root(0), count(0) {
		m_bMyFree= true;
		this->QuickSplayMap_Alloc_Max= QuickSplayMap_Alloc_MaxDef;
	}
	//IQuickSplayMap(const IQuickSplayMap&);
	IQuickSplayMap() : root(0), count(0) {
		m_bMyFree= true;
		this->QuickSplayMap_Alloc_Max= QuickSplayMap_Alloc_MaxDef;
	}
	void error(const char* msg)
	{
		throw msg;
	}
	Data& dflt() {
		return this->def;
	}
	virtual int key_cmp (const Key& a, const Key& b) const {
		return memcmp(&a, &b, sizeof(Key));
	}
	unsigned int length() const { 
		return this->count;
	}
	int	empty() const {
		return (int)(this->count == 0);
	}
	inline ~IQuickSplayMap() {
	}
	inline int operator & (IQuickSplayMap& y)
	{
	  if (y.count == 0 || this->count == 0)
		return 0;
	  if (&y == this) return 1;

	  G_SimpleSplayNode* t = leftmost();
	  while (t != 0)
	  {
		  G_SimpleSplayNode* s = succ(t);
		  if (y.seek(t->item) != 0) return 1;
		  t = s;
	  }
	  return 0;
	}
	void operator -=(IQuickSplayMap& y)
	{
	  if (&y == this)
		clear();
	  else if (y.count != 0)
	  {
		G_SimpleSplayNode* t = leftmost();
		while (t != 0)
		{
		  G_SimpleSplayNode* s = succ(t);
		  if (y.seek(t->item) != 0) del(t->item);
		  t = s;
		}
	  }
	}
	void operator &= (IQuickSplayMap& y)
	{
	  if (y.count == 0)
		clear();
	  else if (&y != this && this->count != 0)
	  {
		G_SimpleSplayNode* t = leftmost();
		while (t != 0)
		{
		  G_SimpleSplayNode* s = succ(t);
		  if (y.seek(t->item) == 0) del(t->item);
		  t = s;
		}
	  }
	}
	void operator |=(IQuickSplayMap& y)
	{
	  if (&y == this) return;
	  G_SimpleSplayNode* u = y.leftmost();
	  while (u != 0)
	  {
		add(u->item);
		u = y.succ(u);
	  }
	}
	IQuickSplayMap& operator = (const IQuickSplayMap& b){
		if (this != &b)
		{
			this->kill_root();
			this->count = b.count;
			this->root = this->_copy (b.root);
			this->CloneData( def, b.def );
		}
		return *this;
	}
	Data& operator [] (const Key &key);
	virtual G_Point add(const Key &key);
	Data& get (const Key &key);
	void del(Key  key);
	void del(G_Point i);
	G_Point seek_nearest(const Key &key, bool as_seek);
	G_Point nearest(const Key &key);
	G_Point seek(const Key  &key);

	inline G_Point first() {
		return (G_Point)leftmost();
	}
	inline void next(G_Point& i) {
		if (i != 0) i = (G_Point)(succ((G_SimpleSplayNode*)i));
	}
	inline Key& key(G_Point i) {
		if (i == 0) this->error("null G_Point");
		return ((G_SimpleSplayNode*)i)->item;
	}
	inline void* pkey(G_Point i) {
		if (i == 0) this->error("null G_Point");
		return &(((G_SimpleSplayNode*)i)->item);
	}
	inline Key& operator () (G_Point i) {
		return key(i);
	}
	inline Data& contents(G_Point i) {
		if (i == 0) this->error("null G_Point");
		return ((G_SimpleSplayNode*)i)->cont;
	}	
	inline int contains(const Key  &key) {
		return seek(key) != 0;
	}
	inline void clear() {
		kill_root();
		this->count = 0;
		root = 0;
	}	
	G_Point last() {
		return (G_Point)(rightmost());
	}
	void prev(G_Point& i) {
		if (i != 0) i = (G_Point)(pred((G_SimpleSplayNode*)i));
	}
	int QuickSplayMap_Alloc_Max;
	void reAlloc()
	{
		G_SimpleSplayNode **ppNodes= get_ppNodes();
		int *pNodesCount= p_ppNodesCount();

		if(!((*pNodesCount)%QuickSplayMap_Alloc_Max)){
			ppNodes= (G_SimpleSplayNode	**)realloc(ppNodes, ((*pNodesCount)+QuickSplayMap_Alloc_Max)*sizeof(G_SimpleSplayNode*));
			set_ppNodes(ppNodes);
		}
		set_NextNode((ppNodes[(*pNodesCount)++]= new G_SimpleSplayNode[QuickSplayMap_Alloc_Max]));
	}
protected:
	virtual inline void CloneData(Data& a, const Data& b) {
		a = b;
	}
	virtual inline void CloneData(IQuickSplayMap& a, const IQuickSplayMap& b) {
		if (&a != &b)
		{
			a.kill_root();
			a.count = b.count;
			a.root = a._copy (b.root);
		}
	}
private:
	virtual inline G_SimpleSplayNode* new_splay_node (const Key &h, const Data& c, G_SimpleSplayNode* l=0, G_SimpleSplayNode* r=0) {
		G_SimpleSplayNode* pRet= 0;
		int *pNodesCount= p_ppNodesCount();
		int *pNodesDelCount= p_ppDelNodesCount();

		if((*pNodesDelCount) > -1){
			pRet= get_ppDelNodes()[(*pNodesDelCount)--];
		}else{
			G_SimpleSplayNode **ppNodes= get_ppNodes();
			G_SimpleSplayNode *NextNode= get_NextNode();
			if(NextNode - (ppNodes[(*pNodesCount)-1]) == QuickSplayMap_Alloc_Max){
				reAlloc();
				NextNode= get_NextNode();
			}
			pRet= NextNode++;
			set_NextNode(NextNode);
		}
		pRet->lt= l;
		pRet->rt= r;
		pRet->par= 0;
		pRet->item= h;

		CloneData(pRet->cont, c);

		return pRet;
	}
	virtual inline void delete_splay_node (G_SimpleSplayNode* p) {
		int *pNodesDelCount= p_ppDelNodesCount();
		if(pNodesDelCount){
			if(!((++(pNodesDelCount[0]))%QuickSplayMap_Alloc_Max) && ((pNodesDelCount[0])+QuickSplayMap_Alloc_Max) != pNodesDelCount[1]){
				G_SimpleSplayNode	**ppDelNodes= get_ppDelNodes();
				ppDelNodes= (G_SimpleSplayNode	**)realloc(ppDelNodes
					, (pNodesDelCount[1]= ((pNodesDelCount[0])+QuickSplayMap_Alloc_Max))*sizeof(G_SimpleSplayNode*));
				set_ppDelNodes(ppDelNodes);
			}
			p->lt= p->rt= p->par = 0;
			get_ppDelNodes()[(*pNodesDelCount)]= p;
		}
	}
};

template <class Key, class Data>
G_Point IQuickSplayMap<Key,Data>::seek_nearest(const Key &key, bool as_seek)
{
  G_SimpleSplayNode* t = root;
  if (t == 0)
    return 0;

  int comp = key_cmp ( key, t->item );
  
  if (comp == 0)
    return (G_Point)(t);

  G_SimpleSplayNode* dummy = (G_SimpleSplayNode*)alloca( 3 * sizeof(G_SimpleSplayNode*));
  G_SimpleSplayNode* l = dummy;
  G_SimpleSplayNode* r = dummy;
  dummy->rt = dummy->lt = dummy->par = 0;

  while (comp != 0)
  {
    if (comp > 0)
    {
      G_SimpleSplayNode* tr = t->rt;
      if (tr == 0)
        break;
      else
      {
        comp = key_cmp(key, tr->item);
        if (comp <= 0 || tr->rt == 0)
        {
          l->rt = t; t->par = l;
          l = t;
          t = tr;
          if (comp >= 0)
            break;
        }
        else
        {
          if ((t->rt = tr->lt) != 0) t->rt->par = t;
          tr->lt = t; t->par = tr;
          l->rt = tr; tr->par = l;
          l = tr;
          t = tr->rt;
          comp = key_cmp(key, t->item);
        }
      }
    }
    else
    {
      G_SimpleSplayNode* tl = t->lt;
      if (tl == 0)
        break;
      else
      {
        comp = key_cmp(key, tl->item);
        if (comp >= 0 || tl->lt == 0)
        {
          r->lt = t; t->par = r;
          r = t;
          t = tl;
          if (comp <= 0)
            break;
        }
        else
        {
          if ((t->lt = tl->rt) != 0) t->lt->par = t;
          tl->rt = t; t->par = tl;
          r->lt = tl; tl->par = r;
          r = tl;
          t = tl->lt;
          comp = key_cmp(key, t->item);
        }
      }
    }
  }
  if ((r->lt = t->rt) != 0) r->lt->par = r;
  if ((l->rt = t->lt) != 0) l->rt->par = l;
  if ((t->lt = dummy->rt) != 0) t->lt->par = t;
  if ((t->rt = dummy->lt) != 0) t->rt->par = t;
  t->par = 0;
  root = t;
  if(as_seek)
	return (comp == 0) ? G_Point(t) : 0;
  return (key_cmp(key,root->item)<=0) ? G_Point(root) : G_Point(r) ;
}

template <class Key, class Data>
G_Point IQuickSplayMap<Key,Data>::nearest(const Key &key)
{
	return this->seek_nearest(key, false);
}

template <class Key, class Data>
G_Point IQuickSplayMap<Key,Data>::seek(const Key &key)
{
	return this->seek_nearest(key, true);
}

template <class Key, class Data>
void IQuickSplayMap<Key,Data>::del(Key key)
{
  del(seek(key));
}

template <class Key, class Data>
void IQuickSplayMap<Key,Data>::del(G_Point i)
{
  G_SimpleSplayNode* t = (G_SimpleSplayNode*)(i);
  if (t == 0) return;

  G_SimpleSplayNode* p = t->par;

  --this->count;
  if (t->rt == 0)
  {
    if (t == root)
    {
      if ((root = t->lt) != 0) root->par = 0;
    }
    else if (t == p->lt)
    {
      if ((p->lt = t->lt) != 0) p->lt->par = p;
    }
    else
      if ((p->rt = t->lt) != 0) p->rt->par = p;
  }
  else
  {
    G_SimpleSplayNode* r = t->rt;
    G_SimpleSplayNode* l = r->lt;
    for(;;)
    {
      if (l == 0)
      {
        if (t == root)
        {
          root = r;
          r->par = 0;
        }
        else if (t == p->lt) 
        {
          p->lt = r;
          r->par = p;
        }
        else
        {
          p->rt = r;
          r->par = p;
        }
        if ((r->lt = t->lt) != 0) r->lt->par = r;
        break;
      }
      else
      {
        if ((r->lt = l->rt) != 0) r->lt->par = r;
        l->rt = r; r->par = l;
        r = l;
        l = l->lt;
      }
    }
  }
  this->delete_splay_node (t);
}

/*template <class Key, class Data>
IQuickSplayMap<Key,Data>::IQuickSplayMap(const IQuickSplayMap& b)
{
	this->count = b.count;
	this->root = this->_copy (b.root);
}*/

template <class Key, class Data>
Data& IQuickSplayMap<Key,Data>::operator [] (const Key  &item)
{
	return get ( item );
}

template <class Key, class Data>
G_Point IQuickSplayMap<Key,Data>::add(const Key &key)
{
	this->get(key);
	return this->root;
}

template <class Key, class Data>
Data& IQuickSplayMap<Key,Data>::get (const Key &item)
{
  G_SimpleSplayNode* t = root;
  if (t == 0)
  {
    ++this->count;
    root = this->new_splay_node(item, this->def);
    return root->cont;
  }
  int comp = key_cmp(item, t->item);
  if (comp == 0)
    return t->cont;

  G_SimpleSplayNode* dummy = (G_SimpleSplayNode*)alloca( 3 * sizeof(G_SimpleSplayNode*));
  G_SimpleSplayNode* l = dummy;
  G_SimpleSplayNode* r = dummy;
  dummy->rt = dummy->lt = dummy->par = 0;

  while (comp != 0)
  {
    if (comp > 0)
    {
      G_SimpleSplayNode* tr = t->rt;
      if (tr == 0)
      {
        ++this->count;
        tr = this->new_splay_node (item, this->def);
        comp = 0;
      }
      else
        comp = key_cmp(item, tr->item);
        
      if (comp <= 0)
      {
        l->rt = t; t->par = l;
        l = t;
        t = tr;
      }
      else 
      {
        G_SimpleSplayNode* trr = tr->rt;
        if (trr == 0)
        {
          ++this->count;
          trr =  this->new_splay_node(item, this->def);
          comp = 0;
        }
        else
          comp = key_cmp(item, trr->item);

        if ((t->rt = tr->lt) != 0) t->rt->par = t;
        tr->lt = t; t->par = tr;
        l->rt = tr; tr->par = l;
        l = tr;
        t = trr;
      }
    }
    else
    {
      G_SimpleSplayNode* tl = t->lt;
      if (tl == 0)
      {
        ++this->count;
        tl = this->new_splay_node(item, this->def);
        comp = 0;
      }
      else
        comp = key_cmp(item, tl->item);

      if (comp >= 0)
      {
        r->lt = t; t->par = r;
        r = t;
        t = tl;
      }
      else
      {
        G_SimpleSplayNode* tll = tl->lt;
        if (tll == 0)
        {
          ++this->count;
          tll = this->new_splay_node(item, this->def);
          comp = 0;
        }
        else
          comp = key_cmp(item, tll->item);

        if ((t->lt = tl->rt) != 0) t->lt->par = t;
        tl->rt = t; t->par = tl;
        r->lt = tl; tl->par = r;
        r = tl;
        t = tll;
      }
    }
  }
  if ((r->lt = t->rt) != 0) r->lt->par = r;
  if ((l->rt = t->lt) != 0) l->rt->par = l;
  if ((t->lt = dummy->rt) != 0) t->lt->par = t;
  if ((t->rt = dummy->lt) != 0) t->rt->par = t;
  t->par = 0;
  root = t;
  return root->cont;
}

template <class Key, class Data>
void IQuickSplayMap<Key,Data>::kill_root() {
	while (root) {
		this->del(root);
	}
}

template <class Key, class Data>
typename IQuickSplayMap<Key,Data>::G_SimpleSplayNode* IQuickSplayMap<Key,Data>::leftmost()
{
  G_SimpleSplayNode* t = root;
  if (t != 0) while (t->lt != 0) t = t->lt;
  return t;
}

template <class Key, class Data>
typename IQuickSplayMap<Key,Data>::G_SimpleSplayNode* IQuickSplayMap<Key,Data>::succ(typename IQuickSplayMap<Key,Data>::G_SimpleSplayNode* t)
{
  if (t == 0)
    return 0;
  if (t->rt != 0)
  {
    t = t->rt;
    while (t->lt != 0) t = t->lt;
    return t;
  }
  else
  {
    for (;;)
    {
      if (t->par == 0 || t == t->par->lt)
        return t->par;
      else
        t = t->par;
    }
  }
}

template <class Key, class Data>
typename IQuickSplayMap<Key,Data>::G_SimpleSplayNode* IQuickSplayMap<Key,Data>::rightmost()
{
  G_SimpleSplayNode* t = root;
  if (t != 0) while (t->rt != 0) t = t->rt;
  return t;
}


template <class Key, class Data>
typename IQuickSplayMap<Key,Data>::G_SimpleSplayNode* IQuickSplayMap<Key,Data>::pred(typename IQuickSplayMap<Key,Data>::G_SimpleSplayNode* t)
{
  if (t == 0)
    return 0;
  else if (t->lt != 0)
  {
    t = t->lt;
    while (t->rt != 0) t = t->rt;
    return t;
  }
  else
  {
    for (;;)
    {
      if (t->par == 0 || t == t->par->rt)
        return t->par;
      else
        t = t->par;
    }
  }
}

template <class Key, class Data>
typename IQuickSplayMap<Key,Data>::G_SimpleSplayNode* IQuickSplayMap<Key,Data>::_copy(typename IQuickSplayMap<Key,Data>::G_SimpleSplayNode* t)
{
  if (t != 0)
  {
    G_SimpleSplayNode* l = _copy(t->lt);
    G_SimpleSplayNode* r = _copy(t->rt);
    G_SimpleSplayNode* x = this->new_splay_node(t->item, t->cont, l, r);
    if (l != 0) l->par = x;
    if (r != 0) r->par = x;
    return x;
  }
  else 
    return 0;
}

template <class Key, class Data>
class QuickSplayMap: public IQuickSplayMap<Key, Data> {
private:
	int m_ppNodesCount;
	int m_ppDelNodesCount[2];
	typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode	*m_NextNode;
	typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode	**m_ppNodes;
	typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode	**m_ppDelNodes;
protected:
	void set_ppDelNodes(typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode **ppNew)	{
		m_ppDelNodes = ppNew;
	}
	void set_NextNode(typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode *pNew)		{
		m_NextNode = pNew;
	}
	typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode** get_ppNodes()			{
		return m_ppNodes;
	}
	typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode** get_ppDelNodes()		{
		return m_ppDelNodes;
	}
	typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode* get_NextNode()			{
		return m_NextNode;
	}
	int *p_ppDelNodesCount()	{
		return m_ppDelNodesCount;
	}
public:
	virtual void set_ppNodes(typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode **ppNew)		{
		m_ppNodes = ppNew;
	}
	virtual int *p_ppNodesCount()		{
		return &m_ppNodesCount;
	}
	void InitArrays(){
		//set_ppNodes(0);
		m_ppNodes				= 0;
		//set_ppDelNodes(0);
		m_ppDelNodes			= 0;
	}
	void directAlloc(int reAllocS, void *pNodePointers, void* pNewNedes, bool bMyFree= true)
	{
			this->m_bMyFree= bMyFree;

			this->QuickSplayMap_Alloc_Max= reAllocS;

			typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode** ppNodes= get_ppNodes();

			ppNodes= (typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode	**)pNodePointers;
			set_NextNode((ppNodes[(*p_ppNodesCount())++]= (typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode *)pNewNedes));

			set_ppNodes(ppNodes);
	}
	QuickSplayMap(const Data& dflt, int reAllocF= 1, int reAllocS= 0) : IQuickSplayMap<Key,Data>(dflt, reAllocF, reAllocS){
		//////////////////////////////
		m_NextNode = 0;
		//////////////////////////////
		//	for stupid Purify		//
		//////////////////////////////
		m_ppNodesCount			= 0;
		m_ppDelNodesCount[0]	= -1;
		m_ppDelNodesCount[1]	= 0;
		InitArrays();
		//////////////////////////////
		if(reAllocF){
			if(!reAllocS){
				this->reAlloc();
			}else{
				typedef typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode QuickSplayMap_G_SimpleSplayNode_tmptypedefmsvc6;
				directAlloc(	reAllocS
								, malloc(sizeof(typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode*))
								, new QuickSplayMap_G_SimpleSplayNode_tmptypedefmsvc6[reAllocS]);
			}
		}
	}
	inline ~QuickSplayMap() {
		typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode	**ppNodes= this->get_ppNodes();
		if(this->m_bMyFree){
			if(ppNodes){
				int *pNodesCount= this->p_ppNodesCount();
				while((*pNodesCount)--){
					delete []ppNodes[(*pNodesCount)];
				}
				free(ppNodes);
			}
			typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode	**ppDelNodes= this->get_ppDelNodes();
			if(ppDelNodes)
				free(ppDelNodes);
		}
		InitArrays();
	}
};

template <class Key, class Data>
class QuickValSplayMap: public QuickSplayMap<Key, Data> {
public:
	QuickValSplayMap(const Data dflt, int reAllocF= 1, int reAllocS= 0) : QuickSplayMap<Key,Data>(dflt, reAllocF, reAllocS)
	{
	}
	virtual int key_cmp (const Key& a, const Key& b) const {
		return ((*(Key *)&a) > (*(Key *)&b)) ? (int)1 : -(int)((*(Key *)&a) < (*(Key *)&b));
	}
};

#define QuickValSplayMapOnStackPerSize(inst10,inst20,nmeMp,szeMp,nZZ)\
	QuickValSplayMap<inst10,inst20> nmeMp(0,0);\
	struct hackMapNodeTypeZZ##nZZ {\
		void* ltZZ;\
		void* rtZZ;\
		void* parZZ;\
		inst10 itemZZ;\
		inst20 contZZ;\
	};\
	unsigned int complex64ZZ##nZZ[2];\
	complex64ZZ##nZZ[0]= (szeMp);\
	hackMapNodeTypeZZ##nZZ *phackMapNode##nZZ= (hackMapNodeTypeZZ##nZZ *)alloca(complex64ZZ##nZZ[0]*sizeof(hackMapNodeTypeZZ##nZZ));\
	for(complex64ZZ##nZZ[1]= 0;complex64ZZ##nZZ[1] < complex64ZZ##nZZ[0]; complex64ZZ##nZZ[1]++){\
		phackMapNode##nZZ[complex64ZZ##nZZ[1]].ltZZ= phackMapNode##nZZ[complex64ZZ##nZZ[1]].rtZZ= phackMapNode##nZZ[complex64ZZ##nZZ[1]].parZZ= 0;\
	}\
	nmeMp.directAlloc(complex64ZZ##nZZ[0], alloca(sizeof(void*)), phackMapNode##nZZ, false);
	

template <class Key, class Data>
class QuickSplayMapG: public IQuickSplayMap<Key, Data> {
protected:
	static int m_ppNodesCount;
	static int m_ppDelNodesCount[2];
	static typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode	*m_NextNode;
	static typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode	**m_ppNodes;
	static typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode	**m_ppDelNodes;

	void set_ppDelNodes(typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode **ppNew)	{ m_ppDelNodes = ppNew; };
	void set_NextNode(typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode *pNew)		{ m_NextNode = pNew; };

	typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode** get_ppNodes()			{ return m_ppNodes; }
	typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode** get_ppDelNodes()		{ return m_ppDelNodes; }
	typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode* get_NextNode()			{ return m_NextNode; }
	int *p_ppDelNodesCount()	{ return m_ppDelNodesCount; }
public:
	virtual void set_ppNodes(typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode **ppNew)		{ m_ppNodes = ppNew; }
	virtual int *p_ppNodesCount()		{ return &m_ppNodesCount; }
	void InitArrays(){
	}
	QuickSplayMapG(const Data& dflt, int reAllocF= 1, int reAllocS= 0) : IQuickSplayMap<Key,Data>(dflt, reAllocF, reAllocS){
		if(!get_ppNodes() && reAllocF){
			if(!reAllocS){
				this->reAlloc();
			}else{
				this->QuickSplayMap_Alloc_Max= reAllocS;

				typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode* NextNode= get_NextNode();
				typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode** ppNodes= get_ppNodes();
				int *pNodesCount= p_ppNodesCount();

				ppNodes= (typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode	**)malloc(sizeof(typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode*));
				typedef typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode QuickSplayMapG_IQuickSplayMap_tmptypedefmsvc6;
				NextNode= ppNodes[(*pNodesCount)++]= new QuickSplayMapG_IQuickSplayMap_tmptypedefmsvc6[reAllocS];

				set_NextNode(NextNode);
				set_ppNodes(ppNodes);
			}
		}
	}
	void free_global()
	{
		typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode** ppNodes= get_ppNodes();
		delete ppNodes[0];
		free(ppNodes);
		set_NextNode(0);
		set_ppNodes(0);
		(*p_ppNodesCount())= 0;
		int *pNodesDelCount= p_ppDelNodesCount();
		if(pNodesDelCount){
			free(get_ppDelNodes());
			set_ppDelNodes(0);
		}
		(*p_ppDelNodesCount())= -1;
	}
	QuickSplayMapG() : IQuickSplayMap<Key,Data>(){
		if(!get_ppNodes())
			this->reAlloc();
	}
};

template <class Key, class Data>
int QuickSplayMapG<Key, Data>::m_ppNodesCount= 0;
template <class Key, class Data>
int QuickSplayMapG<Key, Data>::m_ppDelNodesCount[2]= { -1, 0 };

template <class Key, class Data>
typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode** QuickSplayMapG<Key, Data>::m_ppNodes= 0;
template <class Key, class Data>
typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode** QuickSplayMapG<Key, Data>::m_ppDelNodes= 0;
template <class Key, class Data>
typename IQuickSplayMap<Key, Data>::G_SimpleSplayNode* QuickSplayMapG<Key, Data>::m_NextNode= 0;

/*
template <class Key>
class QuickSplaySetG: public QuickValSplayMap<Key, char> {
public:
	QuickSplaySetG() : QuickValSplayMap<Key,char>(0, 1, 0){
	}
	Key& contents(G_Point i) {
		if (i == 0) this->error("null G_Point");
		return ((G_SimpleSplayNode*)i)->item;
	}	
};
*/

template <class Key, class Data>
class QuickValSplayMapL: public QuickSplayMap<Key, Data> {
public:
	QuickValSplayMapL(const Data dflt) : QuickSplayMap<Key,Data>(dflt, 1, 0){
	}
	virtual int key_cmp (const Key& a, const Key& b) const {
		return ((*(Key *)&a) > (*(Key *)&b)) ? (int)1 : -(int)((*(Key *)&a) < (*(Key *)&b));
	}
};

template <class Key, class Data>
class QuickValSplayMapG: public QuickSplayMapG<Key, Data> {
public:
	QuickValSplayMapG(const Data dflt) : QuickSplayMapG<Key,Data>(dflt, 1, 0){
	}
	virtual int key_cmp (const Key& a, const Key& b) const {
		return ((*(Key *)&a) > (*(Key *)&b)) ? (int)1 : -(int)((*(Key *)&a) < (*(Key *)&b));
	}
};

template <class Key>
class QuickValSplaySetL: public QuickValSplayMapL<Key, char> {
public:
	QuickValSplaySetL() : QuickValSplayMapL<Key,char>(0){
	}
};

template <class Key>
class QuickValSplaySetG: public QuickValSplayMapG<Key, char> {
public:
	QuickValSplaySetG() : QuickValSplayMapG<Key,char>(0){
	}
};
#endif
