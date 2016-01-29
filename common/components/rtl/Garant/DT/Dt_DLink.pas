Unit Dt_DLink;

{ $Id: Dt_DLink.pas,v 1.4 2004/08/03 08:52:51 step Exp $ }

// $Log: Dt_DLink.pas,v $
// Revision 1.4  2004/08/03 08:52:51  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.3  2000/12/15 15:36:16  law
// - вставлены директивы Log.
//

{$I DtDefine.inc}

Interface
Const
 lnkDocIDFld  = 1;
 lnkSubIDFld  = 2;
 lnkDictIDFld = 3;
 lnkDocKey    = 4;
 lnkUniKey    = 5;

Type
 PDLinkRec = ^TDLinkRec;
 TDLinkRec = Record
              DocID  : TDocID;
              SubID  : TSubID;
              DictID : TDictID;
            end;

 TDictLinkTbl = Class(TArchiTbl)
  protected
   fNewDictID : TDictID;
   function    ModifyDictID(gRecNo : LongInt;fpRecord : Pointer) : Boolean; Pascal;
   function    ModifySub(gRecNo : LongInt;fpRecord : Pointer) : Boolean; Pascal;
  public
   Constructor Create(aFamily : TFamilyID;aPrefName  : TPrefName); Reintroduce;

   Procedure   AddNode(DictLinkRec : TDLinkRec); virtual;

   Procedure   DelNode(DictLinkRec : TDLinkRec); virtual;
   Procedure   DelAllNodesOnDocID(aID : TDocID);
   Procedure   DelAllNodesOnDocIDs(aIDs : Sab);
   Procedure   DelAllNodesOnDictID(aID : TDictID); virtual;
   Procedure   ModifyAllNodesOnDictID(oldID, newID : TDictID);

   Function    GetNodes(aDocID : TDocID;aSubID : TSubID;WithRefresh : Boolean) : SAB;

   Function    SrchDocIDsOnDictID(aDictID : TDictID;WithRefresh : Boolean) : SAB;

   Procedure   SrchOnDictIDs(DictIDs : SAB;Var DocIDs : SAB;LinkSab : LPSab;
                             WithTransfer : Boolean);

   Function    GetAssignedSubs(aDoc : TDocID) : SAB;
   Function    GetAssignedSubsOnDictID(aDoc : TDocID;aDict : TDictID) : SAB;

   Procedure   SetEmptyDestSub(aDoc : TDocID;aSub : TSubID);
 end;

 Function GetDictLinkRec(aDoc : TDocID; aSub : TSubID; aDict : TDictID) : TDLinkRec;

Implementation

end.
