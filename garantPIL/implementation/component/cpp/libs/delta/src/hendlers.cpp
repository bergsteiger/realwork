/*
 * $Id: hendlers.cpp,v 2.16 2014/04/08 05:39:33 young Exp $
 */

#include <cstdio>
#include <cstring> // GARANT_GCC
#include "check.h"
#include "elems.h"
#include "hendlers.h"
#include "Logger.h"

extern Logger logger;

//-------------------------------------------------------------------------
LongMass::LongMass(long len)
{
        MassLen = len;

        LMass = (long*) malloc ( sizeof (long) * MassLen );

        PutPoint = GetPoint = 0;
        Reset();
}

long LongMass :: Valid ( long Long )
{
    return Long != LONG_FALSE;
}

void LongMass::Reset()
{
        for (long i=0 ; i<MassLen ; i++) LMass[i]=LONG_FALSE;
}

long LongMass::FindLong(long Long)
{
        if ( Valid ( Long ) )
                for ( long i = 0; i < MassLen; i++ )
                {
                        if ( Long == LMass [i] ) return i;
                }

        return -1;
}

long LongMass::FindNextPut ( long pos )
{
        if ( pos >= 0 && pos < MassLen )
                for ( long i = pos; i < MassLen; i++ )
                {
                        if ( ! Valid ( LMass [i] ) ) return i;
                }

        return -1;
 }

long LongMass::FindNextGet ( long pos )
{
        long	l;
		
		pos++;

        for ( l = pos; l < MassLen; l++ )
                if ( Valid ( LMass [l] ) ) return l;

        for ( l = 0; l < pos; l++ )
                if ( Valid ( LMass [l] ) ) return l;

        return -1;
 }

long LongMass::FindNext ()
{
        for ( long i = FindPoint; i < MassLen; i++ )
                if ( LMass [i] == LongFind )
                {
                        FindPoint = i + 1;
                        GetPoint = FindNextGet ( FindPoint - 1 );

                        //if ( GetPoint == -1 ) GetPoint = FindNextGet ( 0 );
                        SaveGetPoint ();

                        return i;
                }

                return GetNext ();
 }

/*inline long LongMass::GetNext()
{
        if ( GetPoint < 0 ) return -1;

        long tmp = GetPoint;
        GetPoint = FindNextGet ( GetPoint );

        if ( GetPoint == -1 || GetPoint == SavePoint || GetPoint == tmp ) return -1;

        return tmp;
} */

int LongMass::PutLong(long Long)
{
   if(Valid(Long))
   {
       if (PutPoint>=0 && PutPoint<MassLen)
       {
            LMass[PutPoint]=Long;
            PutPoint=FindNextPut(PutPoint);
       }
       else
       {
           logger.printf ( lt_fatal, "LongMass : Attempt to put to wrong possition\n" );
           return 0;
       }
   }
   else
   {
       logger.printf ( lt_fatal, "LongMass : Attempt to put no valid number\n" );
       return 0;
   }
   
   return 1;
}

int LongMass::DelLong(long pos)
{
     if (pos >=0 && pos < MassLen) LMass[pos]=LONG_FALSE;
     else
     {
         logger.printf ( lt_fatal, "LongMass : Attempt to wrire to wrong position %ld (MassLen==%ld)." ,
			pos, MassLen );
         return 0;
     }
     return 1;
}


// -----------------------------------------------------------------------

unsigned strlenE(ELEM* W)
{
        unsigned i=0;
        while (W[i].Wr) i++; //!!!!!
        return i;
};

EList* ElementList::Add(ELEM* elem)
 {
        if(!First) First=Last=(EList *)malloc(sizeof (EList));//new EList;
        else
         {
                Last->Next=(EList *)malloc(sizeof (EList));
                Last=Last->Next;
         }
        Last->Next=0;
        Last->Elem=elem;
        return Last;
 }

ElementList::~ElementList()
 {
        EList* tmp;
        while(First)
         {
                tmp=First->Next;
                free(First);
                First=tmp;
         }
 }


FList* FragmentList::Create(FList *par)
 {
         FList* tmp=(FList *)malloc(sizeof(FList));//new FList;
         if (!tmp) return 0;
         tmp->Next = 0;
         tmp->FEnd = tmp->FBegin = 0;
         tmp->Prev=par;
         if (par)
          {
                  if(par->Next)par->Next->Prev=tmp;
                  tmp->Next=par->Next;
                  par->Next=tmp;
          }
         return tmp;
};

FList* FragmentList::Insert(ELEM* beg , ELEM* end)
{
  Last=Create(Last);
  if (!First) First=Last;
  Last->FBegin=beg;
  Last->FEnd=end;
  return Last;
};

FList* FragmentList::Insert(FList* pred, ELEM* beg , ELEM* end)
 {
        if (beg>=end)
         {
           return pred->Next;
         }
        FList* newl = Create(pred);
        if (!First) First=Last=newl;
        newl->FBegin=beg;
        newl->FEnd=end;
        return newl;
 };

int FragmentList::Delete(FList* del)
{
        if (!del) return 0;
        if (del->Prev) del->Prev->Next = del->Next;
                else First = del->Next;
        if (del->Next) del->Next->Prev = del->Prev;
                else Last = del->Prev;
                
        free(del);
        return 1;
 }

void FragmentList::DelAll()
 {
        while(First)Delete(First);
 }

FragmentList::~FragmentList()
 {
        DelAll();
 }

/*ELEM* FragmentHandler::MovCurrentBeg(int step)
 {
        Current->FBegin+=step;
        if (Current->FEnd==Current->FBegin)
         {
                FList* tmpN=Current->Next;
                FList* tmpP=Current->Prev;
                Delete(Current);

                Current=First;
                if (tmpN)Current=tmpN;
                else if(tmpP)Current=tmpP;
         }
        if( !Current ) return 0;
        else return Current->FBegin;
 }
*/
ELEM* FragmentHandler::MovCurrentEnd(int step)
 {
        Current->FEnd+=step;
        if (Current->FEnd==Current->FBegin)
         {
                FList* tmpN=Current->Next;
                FList* tmpP=Current->Prev;
                Delete(Current);

                Current=First;
                if (tmpN)Current=tmpN;
                else if(tmpP)Current=tmpP;
         }
        if ( !Current ) return 0;
        else return Current->FEnd;
 }

ELEM* FragmentHandler::SetCurrentEnd(ELEM* pos)
{
        if ( !Current ) return 0;

        Current->FEnd=pos;
        return Current->FEnd;
}

ELEM* FragmentHandler::SetCurrentEnd()
 {
        if ( !Current ) return 0;

        Current->FEnd=Current->FBegin;
        Current->FEnd++;
        return Current->FEnd;
 }

FList* FragmentHandler::MovCurrent(int movOrder,int step)
 {
        if ( !Current ) return 0;

        if (step>0)
         for (int i=step;( (movOrder==MO_PROTECT ? Current->Next : Current)&& i);i--)
          Current=Current->Next;
        else
         for (int i=step;((movOrder==MO_PROTECT ? Current->Prev : Current) && i);i++)
          Current=Current->Prev;
        return Current;
 }

FList* FragmentHandler::DivCurrent()
 {
        if ( !Current ) return 0;

        ELEM* newFBegin = Current->FEnd;
        FList* newCurrent = Insert(Current,++newFBegin,EndBak);
        Current=newCurrent;
        return Current;
 }

void FragmentHandler::BackupCurrentEnd()
{
        if ( !Current ) EndBak = 0;
        else EndBak=Current->FEnd;
}

FList* FragmentHandler::Cur2First()
 {
        Current=First;
        return Current;
 }

FList* FragmentHandler::GetCurrent()
 {
        return Current;
 }

FList* FragmentHandler::GetFirst()
 {
        return First;
 }

FragmentHandler::FragmentHandler(ELEM* str)
{
        Current=Insert(str,str+strlenE(str));
}

FragmentHandler::FragmentHandler(ELEM* str,unsigned len)
 {
        Current=Insert(str,str+len*sizeof(ELEM));
 }


StringHandler::StringHandler(ELEM* str):FragmentHandler(str)
{
        Stream = str;
        Length = strlenE ( str );
}

StringHandler::StringHandler(ELEM* str,unsigned len):FragmentHandler(str,len)
 {
        Stream=str;
        Length=len;
 }


ELEM* StringHandler::GetOrder(ELEM* elem,unsigned &newOrder)
 {
  newOrder=0;
  FList* curBak=Current;
  if(!First) goto M1;
  if(*elem==*Current->FBegin)
        {
          ELEM* ofs=Current->FBegin;
          MovCurrentBeg();
          return ofs;
        };
  Cur2First();
  while (Current)
         {
                if(*elem==*Current->FBegin)
                 {
                        ELEM* ofs=Current->FBegin;
                        MovCurrentBeg();
                        return ofs;
                 };
          BackupCurrentEnd();
          SetCurrentEnd();
          while (Current->FEnd<EndBak)
                {
                        if (*elem==*Current->FEnd)
                        {
                                ELEM* ofs = Current->FEnd;
                                if(ofs+1/*ELEMSize*/<EndBak) DivCurrent();
                                else if (ofs+1/*ELEMSize*/==EndBak) MovCurrent(MO_PROTECT);
                                return ofs;
                        };
                  MovCurrentEnd();
                }
          MovCurrent();
        }
        Current=curBak;
M1:
        EList* tmp=NewList.First;
        while (tmp)
         {
                newOrder++;
                if (*elem==*tmp->Elem) return 0;
                tmp=tmp->Next;
         }

        NewList.Add(elem);
        newOrder=0;
        return 0;
 }

int StringHandler::offset(ELEM* pos)
{
	int ofs = (int)(pos-Stream);
	return ofs;
}

DiffHandler::DiffHandler(ELEM* oldstr,ELEM* newstr, int thread):StringHandler(oldstr)
{
	m_thread = thread;
	NewStr=newstr;
}

/*DiffHandler::DiffHandler(ELEM* oldstr,char* newmem):StringHandler(oldstr)
 {
  Mode=MD_ELMEM;
  NewMem=newmem;
  NewStr=0;
 }
 */

int DiffHandler::AddHeader(FILE* F)
 {
  unsigned l=strlenE(NewStr);
  return fputi(l,F);
 }

float DiffHandler::MakeDiff(FILE* df1,FILE* df2)
{
        ELEM* difPos;
        ELEM* lastPos=Stream;
        unsigned movCount=0;
        unsigned newCount=0;
        int movPos;
        int lastMovPos=2;
        int eqOrderCount=0;
        unsigned newOrder=0;
        unsigned lastNewOrder=0;
//      int dOrder;

        AddHeader(df1);
        lastPos--;
        unsigned strLen = strlenE(NewStr);
        for (unsigned int i = 0 ; i < strLen ; i++)
         {
                difPos=GetOrder(&NewStr[i],newOrder);

                if(!difPos) {movPos=0;newCount++;}
                else
                 {
                        movPos=int(difPos-lastPos);
                        if (movPos>1)
                         {
                                if (!Current)movPos=1;
                                else
                                 {
                                        if((!Current->Next)&&(lastPos>=Current->FEnd)&&(difPos>lastPos))
                                                movPos=1; else
                                        if (!Current->Prev)
                                                {if ((lastPos<difPos)&&(difPos<Current->FBegin))
                                                        movPos=1;}
                                        else
                                                if ((difPos<Current->FBegin)&&(lastPos>=Current->Prev->FEnd))
                                                        movPos=1;
                                }
                         }
                         lastPos=difPos;
                 }
                if( (lastMovPos != movPos) || newOrder || lastNewOrder )
                {
                        if ((lastMovPos==1)||!lastMovPos)
			{
                                fputi(lastMovPos,df1);
                                fputi(eqOrderCount,df1);
			}
			fflush(df1);
			fflush(df2);
			eqOrderCount = 1;
                }
                else
			eqOrderCount++;
                if ( (movPos > 1) || (movPos < 0) )
		{
			fputi(movPos,df1);
			movCount++;
		}
                else if( !movPos )
                {
                        if(newOrder) 
				eqOrderCount =- newOrder; // it's looks like error
                        else 
				fputc(NewStr[i],df2);
                }
                lastNewOrder=newOrder;
                lastMovPos=movPos;
         }

        if ((lastMovPos>=0)&&(lastMovPos<=1))
         {
                fputi(lastMovPos,df1);
                fputi(eqOrderCount,df1);
         }
        fflush(df1);
        fflush(df2);

        if (strLen==newCount) return 1.0;
        float newP=((float)newCount/(float)strLen);
        float movP=((float)movCount/float(strLen-newCount));
        newP=newP/2+newP*newP/2;
        movP=movP*2-movP*movP;
        float difP=newP+movP-newP*movP;
        return difP;
 }



float DiffHandler::MakeDP()
 {
        ELEM* difPos;
        ELEM* lastPos=Stream;
        unsigned movCount=0;
        unsigned newCount=0;
        unsigned newOrder=0;
        int movPos;

        lastPos--;
        unsigned strLen = strlenE(NewStr);
        for (unsigned int i = 0 ; i<strLen ; i++)
         {
                difPos=GetOrder(&NewStr[i],newOrder);

                if(!difPos) {movPos=0;newCount++;}
                else
                 {
                        movPos=int(difPos-lastPos);
                        if (movPos>1)
                         {
                                if (!Current)movPos=1;
                                else
                                 {
                                        if((!Current->Next)&&(lastPos>=Current->FEnd)&&(difPos>lastPos))
                                                movPos=1; else
                                        if (!Current->Prev)
                                                {if ((lastPos<difPos)&&(difPos<Current->FBegin))
                                                        movPos=1;}
                                        else
                                                if ((difPos<Current->FBegin)&&(lastPos>=Current->Prev->FEnd))
                                                        movPos=1;
                                }
                         }
                         lastPos=difPos;
                 }

                if ((movPos>1)||(movPos<0)) movCount++;
         }

        if ((strLen==Length)&&(!strLen)) return 0.0;
        if (strLen==newCount) return 1.0;
        if (!strLen) return 1.0;
#ifdef	VERSION56
        float delP= float(Length+newCount-strLen)/(float)(Length*2);
        if(delP<0)delP = 0;
        float newP=((float)newCount/(float)(strLen*2));
        float movP=((float)movCount/float(2*(strLen-newCount)));
#else
        float delP= float(Length+newCount-strLen)/(float)(Length);
        if(delP<0)delP = 0;
        float newP=((float)newCount/(float)(strLen));
        float movP=((float)movCount/float(strLen-newCount));
#endif
        newP=newP/2+newP*newP/2;
        movP=movP*2-movP*movP;
        float difP=delP+newP+movP-newP*delP-movP*delP-newP*movP+delP*newP*movP;

        return difP;
 }

ELEM* DiffHandler::MakeUnDiff(FILE* df1, FILE* df2)
{
	int movPos, eqOrderCount=0, i = 0, wordNum = -1;
	ELEM* jP = Stream;
	fgeti (wordNum,df1);
	NewStr = new Word[wordNum+1];
	for (int t = 0; t < wordNum + 1; t++)
		NewStr [t].m_thread = m_thread;

	while(i < wordNum) {
		fgeti(movPos,df1);

		if(!movPos) {
			fgeti(eqOrderCount,df1);
			if (eqOrderCount>0) {
				fgets(&NewStr[i],eqOrderCount,df2);

				for(int ii=i;i<ii+eqOrderCount;i++)
					NewList.Add(&NewStr[i]);
			} else {
				EList* tmp=NewList.First;

				for(int ii=1;ii<(-eqOrderCount);ii++) 
					tmp=tmp->Next;

				NewStr[i]=*tmp->Elem;
				i++;
			}
		} else if(movPos==1) {
			fgeti(eqOrderCount,df1);
			for (int ii=1;ii<eqOrderCount;ii++) {
				NewStr[i]=*Current->FBegin;

				MovCurrentBeg();
				i++;
			}
			NewStr[i]=*Current->FBegin;

			jP=Current->FBegin;
			MovCurrentBeg();
			i++;
			jP++;
		} else {
			jP+=(movPos-1);//*ELEMSize;
			Cur2First();
			while ( (jP<Current->FBegin) || (jP>Current->FEnd))
				MovCurrent();
			if (jP==Current->FBegin)
				MovCurrentBeg();
		 	else {
				BackupCurrentEnd();
				SetCurrentEnd(jP);
				DivCurrent();
			}
			NewStr[i]=*jP;

			jP++;
			i++;
		}
	}
	return NewStr;
}

ELEM* DiffHandler::MakeUnDiff(char* &ptr)
{
	int movPos;
	int eqOrderCount=0;
	int i = 0;
	ELEM* jP = Stream;

	int wordNum = -1;
	fgeti (wordNum, ptr);
	NewStr = new Word[wordNum+1];
	for (int t = 0; t < wordNum + 1; t++)
		NewStr [t].m_thread = m_thread;

	while(i < wordNum) {
		fgeti (movPos,ptr);

		if(!movPos) {
			fgeti (eqOrderCount, ptr);
			if (eqOrderCount>0) {
				fgets(&NewStr[i],eqOrderCount,ptr);

				for(int ii=i;i<ii+eqOrderCount;i++)
					NewList.Add(&NewStr[i]);
			} else {
				EList* tmp=NewList.First;

				for(int ii=1;ii<(-eqOrderCount);ii++) 
					tmp=tmp->Next;

				NewStr[i]=*tmp->Elem;
				i++;
			}
		} else if(movPos==1) {
			fgeti(eqOrderCount,ptr);
			for (int ii=1;ii<eqOrderCount;ii++) {
				NewStr[i]=*Current->FBegin;

				MovCurrentBeg();
				i++;
			}
			NewStr[i]=*Current->FBegin;

			jP=Current->FBegin;
			MovCurrentBeg();
			i++;
			jP++;
		} else {
			jP+=(movPos-1);//*ELEMSize;
			Cur2First();
			while ( (jP<Current->FBegin) || (jP>Current->FEnd))
				MovCurrent();
			if (jP==Current->FBegin)
				MovCurrentBeg();
		 	else {
				BackupCurrentEnd();
				SetCurrentEnd(jP);
				DivCurrent();
			}
			NewStr[i]=*jP;

			jP++;
			i++;
		}
	}
	return NewStr;
}

int SkipUnDiff ( FILE* df1, FILE* df2, FILE* skipFile, int bSaveSkip, int thread)
{
	int iPrevCCr = CCr [thread];
	CCr [thread] = 1;
 
	int movPos, eqOrderCount = 0, i = 0, wordNum=-1;
	fgeti ( wordNum, df1 );
	if ( bSaveSkip ) fputi ( wordNum, skipFile );

	Word* NewStr = new Word [wordNum+1];
	for (int t = 0; t < wordNum + 1; t++)
		NewStr [t].m_thread = thread;

	while(i<wordNum) {
		fgeti(movPos,df1);
		if ( bSaveSkip ) fputi ( movPos, skipFile );

		if(!movPos) {
			fgeti(eqOrderCount,df1);
			if ( bSaveSkip )
				fputi ( eqOrderCount, skipFile );

			if (eqOrderCount>0) {
				fgets(&NewStr[i],eqOrderCount,df2);
				if ( bSaveSkip )
					fputs ( &NewStr[i], eqOrderCount, skipFile );

				for(int ii=i;i<ii+eqOrderCount;i++) {
					;
				}
			} else {
				i++;
			}
		} else if(movPos==1) {
			fgeti(eqOrderCount,df1);
			if ( bSaveSkip )
				fputi ( eqOrderCount, skipFile );

			for (int ii=1;ii<eqOrderCount;ii++) {
				i++;
			}
			i++;
		} else {
			i++;
		}
	}
    delete [] NewStr;
    CCr [thread] = iPrevCCr; 
	return 1;
 }
