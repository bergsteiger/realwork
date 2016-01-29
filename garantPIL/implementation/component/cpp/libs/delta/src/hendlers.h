/*
 * $Id: hendlers.h,v 2.9 2014/04/08 05:39:33 young Exp $
 */

#ifndef __HANDLERS_H
#define __HANDLERS_H

#define do_NEW          0
#define do_NEXT         1
#define do_MOVE         2

#define MO_PROTECT      1
#define MO_FULLMOVE     0

#define MD_ELEL         1
#define MD_ELMEM        2

#include "elems.h"
#include "deltadef.h"

typedef Word ELEM;

class LongMass
{
    public :
         long* LMass;
         LongMass(long len) ;
         ~LongMass() { if(LMass)free(LMass); }
         void Reset();
         void ResetGetPoint() { GetPoint=0; }
         void ResetPutPoint() { PutPoint=0; }
         void ResetFindPoint() { FindPoint=0; }
         void SetLongFind(long fLong) { LongFind=fLong; }
         void SaveGetPoint() { SavePoint=GetPoint; }
         long FindLong(long Long);
         long FindNext();
         long FindNextPut(long pos);
         long FindNextGet(long pos);
         long Valid(long Long); // GARANT_GCC no inline
         void PutLongTo(long Long,long pos) { if (Valid(Long)) LMass[pos]=Long; }
         int PutLong(long Long);
         inline long GetNext()
	 {
        	if ( GetPoint < 0 ) return -1;

	        long tmp = GetPoint;
        	GetPoint = FindNextGet ( GetPoint );

	        if ( GetPoint == -1 || GetPoint == SavePoint || GetPoint == tmp ) return -1;

        	return tmp;
	 }
         inline long GetLong()
	 {
	     if (GetPoint==-1) return LONG_FALSE;
	     long tmp=LMass[GetPoint];
	     GetPoint=FindNextGet(GetPoint);
	     return tmp;
	 }
         int DelLong(long pos);
        protected :
          long MassLen;
          long PutPoint;
          long GetPoint;
          long FindPoint;
          long SavePoint;
          long LongFind;

};

struct EList{
                  ELEM* Elem;
                  EList* Next;
                  };

class ElementList {
        public:
                ElementList() { First=0; Last=First;};
                ~ElementList();
                EList* Add(ELEM* elem);
                EList* First;
                EList* Last;
 };


struct FList{
                  ELEM* FBegin;
                  ELEM* FEnd;
                  FList* Next;
                  FList* Prev;
                  };

class FragmentList {
        public:
                FragmentList() { First=0; Last=First;};
                ~FragmentList();
                FList* Insert(ELEM* beg , ELEM* end);
                FList* Insert(FList* pred, ELEM* beg , ELEM* end);
                int Delete(FList* del);
        protected:
                FList* First;
                FList* Last;
                FList* Create(FList* par);
                void DelAll();
 };

class FragmentHandler : protected FragmentList {
        public:
                FragmentHandler(ELEM* str);
                FragmentHandler(ELEM* str,unsigned len);
        protected:
                FList* Current;
                ELEM* EndBak;
                //ELEM* MovCurrentBeg(int step=1);
				inline void MovCurrentBeg(int step =1)
				{
					Current->FBegin+=step;
					if (Current->FEnd==Current->FBegin) {
						FList* tmpN=Current->Next;
						FList* tmpP=Current->Prev;
						Delete(Current);

						Current=First;
						if (tmpN)Current=tmpN;
						else if(tmpP)Current=tmpP;
					}
					//if( !Current ) return 0;
					//else return Current->FBegin;
				}
                ELEM* MovCurrentEnd(int step=1);
                ELEM* SetCurrentEnd();
                ELEM* SetCurrentEnd(ELEM* pos);
                FList* MovCurrent(int movOrder=MO_FULLMOVE,int step=1);
                FList* DivCurrent();
                void BackupCurrentEnd();
                FList* Cur2First();
                FList* GetCurrent();
                FList* GetFirst();
         };

class StringHandler : protected FragmentHandler {
        public:
                StringHandler(ELEM* str,unsigned len);
                StringHandler(ELEM* str);
                ELEM* GetOrder(ELEM* elem,unsigned &newOrder);
        protected:
                ElementList NewList;
                ELEM* Stream;
                unsigned Length;
        private:
                int offset(ELEM* pos);

};

class DiffHandler : protected StringHandler {
public:
	DiffHandler(ELEM* oldstr,ELEM* newstr, int thread);
	float MakeDiff(FILE* df1,FILE* df2);
	float MakeDP();
	ELEM* MakeUnDiff(FILE* df1,FILE* df2);
	ELEM* MakeUnDiff(char* &);

protected:
	int	m_thread;
	ELEM* NewStr;
	int AddHeader(FILE* F);

};

int SkipUnDiff ( FILE* df1, FILE* df2, FILE* skipFile, int bSaveSkip, int thread );

#endif
