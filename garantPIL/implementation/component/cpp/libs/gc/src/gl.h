//
// GARLINK module for GARANT System
// Copyright (C) Alex Bachin, Garant-Service, 1996
// Garant-Service, sawa@mtu-net.ru, 18/VI/2003
//
#ifndef __GARLINK_H__
#define __GARLINK_H__

#include <stdio.h>

#include "gardefs.h"
#include "pscreen.h"

class Base;
//class ostream;

//
// this function creates a number of special topics for
// mainmenu, chronology, comments, forms, newdosc, etc.
//
// void garlink ( Base *b , int, int, ostream * );
int garlink(Base *b_, ProgressScreen *screen, int baseType, int bCheckInfo, int bBreeder, int bWWW, int bClass6, FILE *el, DBCore::RelevancyTuneData* chg_rel_data, int b_only_class6);
//
// these functions are called from garlink ()
//

#endif // __GARLINK_H__
