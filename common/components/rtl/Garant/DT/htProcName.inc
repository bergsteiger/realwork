const
{$IFDEF HT_MODE64}
 sHTADDRECORDS             = '_htAddRecords@24'      ;
 sHTANDRESULTS             = '_htAndResults@12'      ;
 sHTAVERAGEOFKEYVALUES     = '_htAverageOfKeyValues@12';
 sHTBUILDINDEXES           = '_htBuildIndexes@20';
 sHTBACKUPTABLE            = '_htBackupTable@12';
 sHTBACKUPTABLEGROUP       = '_htBackupTableGroup@20';
 sHTCHANGECRYPTOKEY        = '_htChangeCryptoKey@24';
 sHTCHANGEKEYTYPE          = '_htChangeKeyType@28';
 sHTCHANGEREADPASSWORD     = '_htChangeReadPassword@16';
 sHTCHANGEWRITEPASSWORD    = '_htChangeWritePassword@16';
 sHTCLOSERESULTS           = '_htCloseResults@4';
 sHTCLUSTERITEMTOLINK      = '_htClusterItemToLink@16';
 sHTCLUSTERRECSTOLINK      = '_htClusterRecsToLink@12';
 sHTCODEDRESULTSTOTABLE    = '_htCodedResultsToTable@36';
 sHTCODERINFO              = '_htCoderInfo@8';
 sHTCOMMITTRANSACTION      = '_htCommitTransaction@4';
 sHTCOMPARETABHANDLES      = '_htCompareTabHandles@8';
 sHTCOPYRESULTS            = '_htCopyResults@8';
 sHTCREATECLUSTERTABLE     = '_htCreateClusterTable@24';
 sHTCREATEEMPTYSAB         = '_htCreateEmptySAB@20';
 sHTCREATEEMPTYJOIN        = '_htCreateEmptyJoin@12';
 sHTDATETOWORD             = '_htDateToWord@4';
 sHTDELETERECORDS          = '_htDeleteRecords@4';
 sHTDISTINCTRESULTS        = '_htDistinctResults@16';
 sHTDISTINCTRESULTSBYCOUNT = '_htDistinctResultsByCount@24';
 sHTDIVISION               = '_htDivision@16';
 sHTDROPINDEXES            = '_htDropIndexes@12';
 sHTDROPTABLE              = '_htDropTable@12';
 sHTDROPTABLECHANGES       = '_htDropTableChanges@12';
 sHTDROPTABLEDATA          = '_htDropTableData@12';
 sHTDUPTABLEHANDLE         = '_htDupTableHandle@8';
 sHTERRORMESSAGE           = '_htErrorMessage@8';
 sHTEXCLUDERESULTSITEM     = '_htExcludeResultsItem@8';
 sHTEXPORT                 = '_htExport@24';
 sHTEXTERROR               = '_htExtError@12';
 sHTFILTERRECORDS          = '_htFilterRecords@24';
 sHTFILTERTABLES           = '_htFilterTables@40';
 sHTFINDCODERKEY           = '_htFindCoderKey@12';
 sHTFINDCODERVALUE         = '_htFindCoderValue@12';
 sHTFLUSHTABLE             = '_htFlushTable@4';
 sHTGETDIFFLENGTH          = '_htGetDiffLength@8';
 sHTGETRESULTSITEM         = '_htGetResultsItem@12';
 sHTGLOBALINIT             = '_htGlobalInit@4';
 sHTGLOBALSHUT             = '_htGlobalShut@0';
 sHTGROUPBYHAVINGTO        = '_htGroupByHavingTo@32';
 sHTGROUPBYUSER            = '_htGroupByUser@40';
 sHTHANDLEADD              = '_htHandleAdd@12';
 sHTHANDLEFROMRECNO        = '_htHandleFromRecNo@16';
 sHTHANDLEMODIFY           = '_htHandleModify@16';
 sHTHISTOGRAMBYCOUNT       = '_htHistogramByCount@20';
 sHTHISTOGRAMOFKEY         = '_htHistogramOfKey@12';
 sHTHOLDFREERECORDS        = '_htHoldFreeRecords@8';
 sHTHOLDREADRECORD         = '_htHoldReadRecord@12';
 sHTHOLDRECORD             = '_htHoldRecord@8';
 sHTHOLDRESULTS            = '_htHoldResults@4';
 sHTHOLDTABLE              = '_htHoldTable@4';
 sHTIMPORT                 = '_htImport@40';
 sHTIMPORTTITLE            = '_htImportTitle@24';
 sHTINCLUDERESULTSBLOCK    = '_htIncludeResultsBlock@16';
 sHTINCLUDERESULTSITEM     = '_htIncludeResultsItem@12';
 sHTINIT                   = '_htInit@8';
 sHTIOMESSAGE              = '_htIOMessage@4';
 sHTISNEEDTOROLL           = '_htIsNeedToRoll@8';
 sHTISRESULTOBSOLETE       = '_htIsResultObsolete@4';
 sHTISRESULTOPEN           = '_htIsResultOpen@4';
 sHTISTRANSACTIONALTABLE   = '_htIsTransactionalTable@4';
 sHTJOINEDRECORDS          = '_htJoinedRecords@16';
 sHTJOINELEMENT            = '_htJoinElement@20';
 sHTKEYMAXIMUM             = '_htKeyMaximum@12';
 sHTKEYMINIMUM             = '_htKeyMinimum@12';
 sHTLOADCODER              = '_htLoadCoder@24';
 sHTLOADRECORDS            = '_htLoadRecords@32';
 sHTLOGCLOSE               = '_htLogClose@4';
 sHTLOGOPEN                = '_htLogOpen@24';
 sHTLOGREAD                = '_htLogRead@16';
 sHTMAKEGROUPPHOTO         = '_htMakeGroupPhoto@12';
 sHTMAKEPHOTO              = '_htMakePhoto@8';
 sHTMARKJOINEDRECORD       = '_htMarkJoinedRecord@12';
 sHTMARKJOINEDRECORDEX     = '_htMarkJoinedRecordEx@8';
 sHTMARKRECORD             = '_htMarkRecord@8';
 sHTMEMOAVAILBYTASK        = '_htMemoAvailByTask@8';
 sHTMESSAGE                = '_htMessage@8';
 sHTMODIFYRECORDS          = '_htModifyRecords@20';
 sHTNOTRESULTS             = '_htNotResults@8';
 sHTNULLFIELD              = '_htNullField@16';
 sHTNULLRECORD             = '_htNullRecord@8';
 sHTOPENCODEDRESULTS       = '_htOpenCodedResults@12';
 sHTOPENRESULTS            = '_htOpenResults@16';
 sHTORRESULTS              = '_htOrResults@12';
 sHTOUTTO                  = '_htOutTo@36';
 sHTPRINTHYTECHHEAP        = '_htPrintHytechHeap@8';
 sHTPUREADDRECORDS         = '_htPureAddRecords@16';
 sHTPUREMODIFYRECORDS      = '_htPureModifyRecords@12';
 sHTREADCODER              = '_htReadCoder@12';
 sHTREADRECORD             = '_htReadRecord@16';
 sHTREADRECORDBYHANDLE     = '_htReadRecordByHandle@12';
 sHTREADRESULTS            = '_htReadResults@12';
 sHTREADSABCHANGES         = '_htReadSABChanges@16';
 sHTREADTABLECHANGES       = '_htReadTableChanges@24';
 sHTRECNOFROMHANDLE        = '_htRecNoFromHandle@8';
 sHTRECORDADD              = '_htRecordAdd@8';
 sHTRECORDBYUNIQ           = '_htRecordByUniq@20';
 sHTRECORDDELETE           = '_htRecordDelete@8';
 sHTRECORDMODIFY           = '_htRecordModify@12';
 sHTRECORDORDINALNUMBER    = '_htRecordOrdinalNumber@8';
 sHTRECORDSBYKEY           = '_htRecordsByKey@8';
 sHTRECORDSFORTWOKEYS      = '_htRecordsForTwoKeys@20';
 sHTRELEASERECORD          = '_htReleaseRecord@8';
 sHTRELEASERESULTS         = '_htReleaseResults@4';
 sHTRELEASETABLE           = '_htReleaseTable@4';
 sHTREPAIRTABLE            = '_htRepairTable@12';
 sHTREPAIRTABLELOG         = '_htRepairTableLog@16';
 sHTREPLACERESULTSITEM     = '_htReplaceResultsItem@12';
 sHTREPLACERESULTSTABLE    = '_htReplaceResultsTable@12';
 sHTRESTORETABLE           = '_htRestoreTable@16';
 sHTRESULTSELEMENT         = '_htResultsElement@8';
 sHTRESULTSITEMCNT         = '_htResultsItemCnt@4';
 sHTRESULTSITEMLEN         = '_htResultsItemLen@8';
 sHTRESULTSITEMPARM        = '_htResultsItemParm@8';
 sHTRESULTSTABLE           = '_htResultsTable@8';
 sHTRESULTSTOHARD          = '_htResultsToHard@4';
 sHTRESULTSTOTABLE         = '_htResultsToTable@36';
 sHTRESULTSTYPE            = '_htResultsType@4';
 sHTROLLBACKTRANSACTION    = '_htRollBackTransaction@4';
 sHTSEARCH                 = '_htSearch@28';
 sHTSEEKMARKEDJOIN         = '_htSeekMarkedJoin@12';
 sHTSEEKMARKEDJOINEX       = '_htSeekMarkedJoinEx@8';
 sHTSEEKMARKEDRECORD       = '_htSeekMarkedRecord@8';
 sHTSEEKRESULTS            = '_htSeekResults@12';
 sHTSORTEDRECORDS          = '_htSortedRecords@8';
 sHTSORTEDRECORDSEX        = '_htSortedRecordsEx@12';
 sHTSORTRESULTS            = '_htSortResults@16';
 sHTSORTRESULTSBYUSER      = '_htSortResultsByUser@24';
 sHTSTARTTIMEDATE          = '_htStartTimeDate@0';
 sHTSTARTTRANSACTION       = '_htStartTransaction@12';
 sHTSUBSEARCH              = '_htSubSearch@28';
 sHTSUMOFKEYVALUES         = '_htSumOfKeyValues@12';
 sHTSYNCRESULTS            = '_htSyncResults@12';
 sHTTABLECLOSE             = '_htTableClose@4';
 sHTTABLECOPY              = '_htTableCopy@16';
 sHTTABLECREATE            = '_htTableCreate@32';
 sHTTABLEELEMENT           = '_htTableElement@16';
 sHTTABLEELEMENTLIST       = '_htTableElementList@8';
 sHTTABLEHANDLEBYNAME      = '_htTableHandleByName@8';
 sHTTABLEINFO              = '_htTableInfo@8';
 sHTTABLEOPEN              = '_htTableOpen@20';
 sHTTABLERENAME            = '_htTableRename@16';
 sHTTABLEVERIFY            = '_htTableVerify@16';
 sHTTELLJOINORDER          = '_htTellJoinOrder@8';
 sHTTOUCHRESULTS           = '_htTouchResults@8';
 sHTTRANSFERTOPHOTO        = '_htTransferToPhoto@12';
 sHTTRANSFERTOTABLE        = '_htTransferToTable@12';
 sHTUPDATETABLE            = '_htUpdateTable@20';
 sHTVALUESBYCOUNT          = '_htValuesByCount@20';
 sHTVALUESFROMGROUP        = '_htValuesFromGroup@16';
 sHTVALUESOFKEY            = '_htValuesOfKey@12';
 sHTXORRESULTS             = '_htXorResults@12';
 sHTBREAK                  = '_htBreak@0';
 sHTCLEARRESULTS           = '_htClearResults@4';
 sHTCLOSEALLTABLES         = '_htCloseAllTables@0';
 sHTNETPATH                = '_htNetPath@4';
 sHTPURGECODER             = '_htPurgeCoder@4';
 sHTPURGEERROR             = '_htPurgeError@0';
 sHTSETLOCKTIMEOUT         = '_htSetLockTimeOut@4';
 sHTSETPOLLDELAY           = '_htSetPollDelay@4';
 sHTSETTRANSTIMEOUT        = '_htSetTransTimeOut@4';
 sHTSHUT                   = '_htShut@0';
 sHTSTRINGTOARRAY          = '_htStringToArray@12';
 sHTSTRINGTOCHARS          = '_htStringToChars@12';
 sHTTABLESABSTAT           = '_htGetSABStat@8';  //????
 sHTTABLEHEADCLOSE         = '_htTableHeadClose@4';
 sHTTABLEHEADOPEN          = '_htTableHeadOpen@24';
 sHTTABLEHEADPSWD          = '_htTableHeadPswd@8';
 sHTTABLEHEADREAD          = '_htTableHeadRead@12';
 sHTTABLEHEADWRITE         = '_htTableHeadWrite@20';
 sHTTABLESJOIN             = '_htTablesJoin@36';
 sHTTABLESLINK             = '_htTablesLink@20';
 sHTTMPPATH                = '_htTmpPath@4';
 sHTWHOLOCKRECORD          = '_htWhoLockRecord@12';
 sHTWHOLOCKSET             = '_htWhoLockSet@8';
 sHTWHOLOCKTABLE           = '_htWhoLockTable@8';
 sHTWILDCMP                = '_htWildCmp@16';
 sHTWORDTODATE             = '_htWordToDate@8';
 sHTTABLESTATE             = '_htTableState@8';
 sHTTABLEAGREGATEAPPEND    = '_htTableAgregateAppend@20';
 sHTTABLEAGREGATEDELETE    = '_htTableAgregateDelete@20';
 sHTTABLEAGREGATEMODIFY    = '_htTableAgregateModify@24';
 sHTISFIELDNULL            = '_htIsFieldNull@12';
 sHTCTRLCTRL               = '_htCtrlCtrl@4';
 sHTCONVERTTABLE           = '_htConvertTable@20';
 shtTableRecordLen         = '_htTableRecordLen@8';
 sHTEXCLUDERESULTS         = '_htExcludeResults@12';
 sHTRECORDSBYVALUES        = '_htRecordsByValues@24';
 sHTLASTERRORTEXT          = '_htLastErrorText@8';
{$ELSE}
 not use!! ///

 sHTADDRECORDS             = 'HTADDRECORDS';
 sHTANDRESULTS             = 'HTANDRESULTS';
 sHTAVERAGEOFKEYVALUES     = 'HTAVERAGEOFKEYVALUES';
 sHTBUILDINDEXES           = 'HTBUILDINDEXES';
 sHTBACKUPTABLE            = 'HTBACKUPTABLE';
 sHTBACKUPTABLEGROUP       = 'HTBACKUPTABLEGROUP';
 sHTCHANGECRYPTOKEY        = 'HTCHANGECRYPTOKEY';
 sHTCHANGEKEYTYPE          = 'HTCHANGEKEYTYPE';
 sHTCHANGEREADPASSWORD     = 'HTCHANGEREADPASSWORD';
 sHTCHANGEWRITEPASSWORD    = 'HTCHANGEWRITEPASSWORD';
 sHTCLOSERESULTS           = 'HTCLOSERESULTS';
 sHTCLUSTERITEMTOLINK      = 'HTCLUSTERITEMTOLINK';
 sHTCLUSTERRECSTOLINK      = 'HTCLUSTERRECSTOLINK';
 sHTCODEDRESULTSTOTABLE    = 'HTCODEDRESULTSTOTABLE';
 sHTCODERINFO              = 'HTCODERINFO';
 sHTCOMMITTRANSACTION      = 'HTCOMMITTRANSACTION';
 sHTCOMPARETABHANDLES      = 'HTCOMPARETABHANDLES';
 sHTCOPYRESULTS            = 'HTCOPYRESULTS';
 sHTCREATECLUSTERTABLE     = 'HTCREATECLUSTERTABLE';
 sHTCREATEEMPTYSAB         = 'HTCREATEEMPTYSAB';
 sHTCREATEEMPTYJOIN        = 'HTCREATEEMPTYJOIN';
 sHTDATETOWORD             = 'HTDATETOWORD';
 sHTDELETERECORDS          = 'HTDELETERECORDS';
 sHTDISTINCTRESULTS        = 'HTDISTINCTRESULTS';
 sHTDISTINCTRESULTSBYCOUNT = 'HTDISTINCTRESULTSBYCOUNT';
 sHTDIVISION               = 'HTDIVISION';
 sHTDROPINDEXES            = 'HTDROPINDEXES';
 sHTDROPTABLE              = 'HTDROPTABLE';
 sHTDROPTABLECHANGES       = 'HTDROPTABLECHANGES';
 sHTDROPTABLEDATA          = 'HTDROPTABLEDATA';
 sHTDUPTABLEHANDLE         = 'HTDUPTABLEHANDLE';
 sHTERRORMESSAGE           = 'HTERRORMESSAGE';
 sHTEXCLUDERESULTSITEM     = 'HTEXCLUDERESULTSITEM';
 sHTEXPORT                 = 'HTEXPORT';
 sHTEXTERROR               = 'HTEXTERROR';
 sHTFILTERRECORDS          = 'HTFILTERRECORDS';
 sHTFILTERTABLES           = 'HTFILTERTABLES';
 sHTFINDCODERKEY           = 'HTFINDCODERKEY';
 sHTFINDCODERVALUE         = 'HTFINDCODERVALUE';
 sHTFLUSHTABLE             = 'HTFLUSHTABLE';
 sHTGETDIFFLENGTH          = 'HTGETDIFFLENGTH';
 sHTGETRESULTSITEM         = 'HTGETRESULTSITEM';
 sHTGLOBALINIT             = 'HTGLOBALINIT';
 sHTGLOBALSHUT             = 'HTGLOBALSHUT';
 sHTGROUPBYHAVINGTO        = 'HTGROUPBYHAVINGTO';
 sHTGROUPBYUSER            = 'HTGROUPBYUSER';
 sHTHANDLEADD              = 'HTHANDLEADD';
 sHTHANDLEFROMRECNO        = 'HTHANDLEFROMRECNO';
 sHTHANDLEMODIFY           = 'HTHANDLEMODIFY';
 sHTHISTOGRAMBYCOUNT       = 'HTHISTOGRAMBYCOUNT';
 sHTHISTOGRAMOFKEY         = 'HTHISTOGRAMOFKEY';
 sHTHOLDFREERECORDS        = 'HTHOLDFREERECORDS';
 sHTHOLDREADRECORD         = 'HTHOLDREADRECORD';
 sHTHOLDRECORD             = 'HTHOLDRECORD';
 sHTHOLDRESULTS            = 'HTHOLDRESULTS';
 sHTHOLDTABLE              = 'HTHOLDTABLE';
 sHTIMPORT                 = 'HTIMPORT';
 sHTIMPORTTITLE            = 'HTIMPORTTITLE';
 sHTINCLUDERESULTSBLOCK    = 'HTINCLUDERESULTSBLOCK';
 sHTINCLUDERESULTSITEM     = 'HTINCLUDERESULTSITEM';
 sHTINIT                   = 'HTINIT';
 sHTIOMESSAGE              = 'HTIOMESSAGE';
 sHTISNEEDTOROLL           = 'HTISNEEDTOROLL';
 sHTISRESULTOBSOLETE       = 'HTISRESULTOBSOLETE';
 sHTISRESULTOPEN           = 'HTISRESULTOPEN';
 sHTISTRANSACTIONALTABLE   = 'HTISTRANSACTIONALTABLE';
 sHTJOINEDRECORDS          = 'HTJOINEDRECORDS';
 sHTJOINELEMENT            = 'HTJOINELEMENT';
 sHTKEYMAXIMUM             = 'HTKEYMAXIMUM';
 sHTKEYMINIMUM             = 'HTKEYMINIMUM';
 sHTLOADCODER              = 'HTLOADCODER';
 sHTLOADRECORDS            = 'HTLOADRECORDS';
 sHTLOGCLOSE               = 'HTLOGCLOSE';
 sHTLOGOPEN                = 'HTLOGOPEN';
 sHTLOGREAD                = 'HTLOGREAD';
 sHTMAKEGROUPPHOTO         = 'HTMAKEGROUPPHOTO';
 sHTMAKEPHOTO              = 'HTMAKEPHOTO';
 sHTMARKJOINEDRECORD       = 'HTMARKJOINEDRECORD';
 sHTMARKJOINEDRECORDEX     = 'HTMARKJOINEDRECORDEX';
 sHTMARKRECORD             = 'HTMARKRECORD';
 sHTMEMOAVAILBYTASK        = 'HTMEMOAVAILBYTASK';
 sHTMESSAGE                = 'HTMESSAGE';
 sHTMODIFYRECORDS          = 'HTMODIFYRECORDS';
 sHTNOTRESULTS             = 'HTNOTRESULTS';
 sHTNULLFIELD              = 'HTNULLFIELD';
 sHTNULLRECORD             = 'HTNULLRECORD';
 sHTOPENCODEDRESULTS       = 'HTOPENCODEDRESULTS';
 sHTOPENRESULTS            = 'HTOPENRESULTS';
 sHTORRESULTS              = 'HTORRESULTS';
 sHTOUTTO                  = 'HTOUTTO';
 sHTPRINTHYTECHHEAP        = 'HTPRINTHYTECHHEAP';
 sHTPUREADDRECORDS         = 'HTPUREADDRECORDS';
 sHTPUREMODIFYRECORDS      = 'HTPUREMODIFYRECORDS';
 sHTREADCODER              = 'HTREADCODER';
 sHTREADRECORD             = 'HTREADRECORD';
 sHTREADRECORDBYHANDLE     = 'HTREADRECORDBYHANDLE';
 sHTREADRESULTS            = 'HTREADRESULTS';
 sHTREADSABCHANGES         = 'HTREADSABCHANGES';
 sHTREADTABLECHANGES       = 'HTREADTABLECHANGES';
 sHTRECNOFROMHANDLE        = 'HTRECNOFROMHANDLE';
 sHTRECORDADD              = 'HTRECORDADD';
 sHTRECORDBYUNIQ           = 'HTRECORDBYUNIQ';
 sHTRECORDDELETE           = 'HTRECORDDELETE';
 sHTRECORDMODIFY           = 'HTRECORDMODIFY';
 sHTRECORDORDINALNUMBER    = 'HTRECORDORDINALNUMBER';
 sHTRECORDSBYKEY           = 'HTRECORDSBYKEY';
 sHTRECORDSFORTWOKEYS      = 'HTRECORDSFORTWOKEYS';
 sHTRELEASERECORD          = 'HTRELEASERECORD';
 sHTRELEASERESULTS         = 'HTRELEASERESULTS';
 sHTRELEASETABLE           = 'HTRELEASETABLE';
 sHTREPAIRTABLE            = 'HTREPAIRTABLE';
 sHTREPAIRTABLELOG         = 'HTREPAIRTABLELOG';
 sHTREPLACERESULTSITEM     = 'HTREPLACERESULTSITEM';
 sHTREPLACERESULTSTABLE    = 'HTREPLACERESULTSTABLE';
 sHTRESTORETABLE           = 'HTRESTORETABLE';
 sHTRESULTSELEMENT         = 'HTRESULTSELEMENT';
 sHTRESULTSITEMCNT         = 'HTRESULTSITEMCNT';
 sHTRESULTSITEMLEN         = 'HTRESULTSITEMLEN';
 sHTRESULTSITEMPARM        = 'HTRESULTSITEMPARM';
 sHTRESULTSTABLE           = 'HTRESULTSTABLE';
 sHTRESULTSTOHARD          = 'HTRESULTSTOHARD';
 sHTRESULTSTOTABLE         = 'HTRESULTSTOTABLE';
 sHTRESULTSTYPE            = 'HTRESULTSTYPE';
 sHTROLLBACKTRANSACTION    = 'HTROLLBACKTRANSACTION';
 sHTSEARCH                 = 'HTSEARCH';
 sHTSEEKMARKEDJOIN         = 'HTSEEKMARKEDJOIN';
 sHTSEEKMARKEDJOINEX       = 'HTSEEKMARKEDJOINEX';
 sHTSEEKMARKEDRECORD       = 'HTSEEKMARKEDRECORD';
 sHTSEEKRESULTS            = 'HTSEEKRESULTS';
 sHTSORTEDRECORDS          = 'HTSORTEDRECORDS';
 sHTSORTEDRECORDSEX        = 'HTSORTEDRECORDSEX';
 sHTSORTRESULTS            = 'HTSORTRESULTS';
 sHTSORTRESULTSBYUSER      = 'HTSORTRESULTSBYUSER';
 sHTSTARTTIMEDATE          = 'HTSTARTTIMEDATE';
 sHTSTARTTRANSACTION       = 'HTSTARTTRANSACTION';
 sHTSUBSEARCH              = 'HTSUBSEARCH';
 sHTSUMOFKEYVALUES         = 'HTSUMOFKEYVALUES';
 sHTSYNCRESULTS            = 'HTSYNCRESULTS';
 sHTTABLECLOSE             = 'HTTABLECLOSE';
 sHTTABLECOPY              = 'HTTABLECOPY';
 sHTTABLECREATE            = 'HTTABLECREATE';
 sHTTABLEELEMENT           = 'HTTABLEELEMENT';
 sHTTABLEELEMENTLIST       = 'HTTABLEELEMENTLIST';
 sHTTABLEHANDLEBYNAME      = 'HTTABLEHANDLEBYNAME';
 sHTTABLEINFO              = 'HTTABLEINFO';
 sHTTABLEOPEN              = 'HTTABLEOPEN';
 sHTTABLERENAME            = 'HTTABLERENAME';
 sHTTABLEVERIFY            = 'HTTABLEVERIFY';
 sHTTELLJOINORDER          = 'HTTELLJOINORDER';
 sHTTOUCHRESULTS           = 'HTTOUCHRESULTS';
 sHTTRANSFERTOPHOTO        = 'HTTRANSFERTOPHOTO';
 sHTTRANSFERTOTABLE        = 'HTTRANSFERTOTABLE';
 sHTUPDATETABLE            = 'HTUPDATETABLE';
 sHTVALUESBYCOUNT          = 'HTVALUESBYCOUNT';
 sHTVALUESFROMGROUP        = 'HTVALUESFROMGROUP';
 sHTVALUESOFKEY            = 'HTVALUESOFKEY';
 sHTXORRESULTS             = 'HTXORRESULTS';
 sHTBREAK                  = 'HTBREAK';
 sHTCLEARRESULTS           = 'HTCLEARRESULTS';
 sHTCLOSEALLTABLES         = 'HTCLOSEALLTABLES';
 sHTNETPATH                = 'HTNETPATH';
 sHTPURGECODER             = 'HTPURGECODER';
 sHTPURGEERROR             = 'HTPURGEERROR';
 sHTSETLOCKTIMEOUT         = 'HTSETLOCKTIMEOUT';
 sHTSETPOLLDELAY           = 'HTSETPOLLDELAY';
 sHTSETTRANSTIMEOUT        = 'HTSETTRANSTIMEOUT';
 sHTSHUT                   = 'HTSHUT';
 sHTSTRINGTOARRAY          = 'HTSTRINGTOARRAY';
 sHTSTRINGTOCHARS          = 'HTSTRINGTOCHARS';
 sHTTABLESABSTAT           = 'HTTABLESABSTAT';
 sHTTABLEHEADCLOSE         = 'HTTABLEHEADCLOSE';
 sHTTABLEHEADOPEN          = 'HTTABLEHEADOPEN';
 sHTTABLEHEADPSWD          = 'HTTABLEHEADPSWD';
 sHTTABLEHEADREAD          = 'HTTABLEHEADREAD';
 sHTTABLEHEADWRITE         = 'HTTABLEHEADWRITE';
 sHTTABLESJOIN             = 'HTTABLESJOIN';
 sHTTABLESLINK             = 'HTTABLESLINK';
 sHTTMPPATH                = 'HTTMPPATH';
 sHTWHOLOCKRECORD          = 'HTWHOLOCKRECORD';
 sHTWHOLOCKSET             = 'HTWHOLOCKSET';
 sHTWHOLOCKTABLE           = 'HTWHOLOCKTABLE';
 sHTWILDCMP                = 'HTWILDCMP';
 sHTWORDTODATE             = 'HTWORDTODATE';
 sHTTABLESTATE             = 'HTTABLESTATE';
 sHTTABLEAGREGATEMODIFY    = 'HTTABLEAGREGATEMODIFY';
 sHTTABLEAGREGATEDELETE    = 'HTTABLEAGREGATEDELETE';
 sHTTABLEAGREGATEAPPEND    = 'HTTABLEAGREGATEAPPEND';
 sHTISFIELDNULL            = 'HTISFIELDNULL';
 sHTCTRLCTRL               = 'AMCTRLCTRL';
{$ENDIF}

(*
_htConvertTable@20

_amGetVersion@0
_amReadSerNo@0
_htAbort@0

_htCanonizeName@8
_htConstRecordByUniq@16
_htConvertTable@20
_htDiffMark@0
_htErrorKey@0
_htGetId@0
_htGetParam@12
_htGetSABStat@8
_htGetSabSize@0
_htKillLckFiles@4
_htLastSurrogate@8
_htModifyHandles@20

_htPureResultsToTable@32
_htSetParam@8
_htSortJoinByPhys@8
_htSqueezeTableList@0
_htStringToArray@12
_htStringToChars@12
_htTableChangesCopy@28
_htTableDiffLength@8
_htTableDiffRead@24
_htTableHeadClose@4
_htTableHeadOpen@24
_htTableHeadPswd@8
_htTableHeadRead@12
_htTableHeadWrite@20
_htTableLogWrite@32
_htTablePack@20
_htTableRecordLen@8
_htTableRecsRead@20
_htTableReplace@12
_htVileLimit@4
_htWhoIam@4

_htAddRecordsSrv@28
_htModifyRecordsSrv@24
_htPureAddRecordsSrv@20
_htPureModifyRecordsSrv@16
_htPureResultsToTableSrv@36
_htResultsToTableSrv@40

*)
