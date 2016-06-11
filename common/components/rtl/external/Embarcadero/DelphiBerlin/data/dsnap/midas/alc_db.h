/********************************************************
*                                                       *
*                Delphi Runtime Library                 *
*                                                       *
* Copyright(c) 2016 Embarcadero Technologies, Inc.      *
*               All rights reserved                     *
*                                                       *
*   Copyright and license exceptions noted in source    *
*                                                       *
********************************************************/

#ifndef ALC_DB_H
#define ALC_DB_H


class DSDATABASE
{
   class DSBASE * pDs; // List of DS on this database
public:
   DSDBDesc    DbDesc;
   DSDATABASE::DSDATABASE();
   DSDATABASE::~DSDATABASE();
   DBIResult OpenDs(pCHAR pszName, class DSBASE **ppDs); // Find existing dataset, keeps track of use count
   DBIResult CloseDs(class DSBASE *pDs);
   DBIResult SetDatabaseParams(pCHAR pszDbName, pCHAR pszDbType, pCHAR pszPassword, DSOpenMode eDbOpenMode, pCHAR pszDbCurrentDir);
};

#endif
