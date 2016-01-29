{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{   Copyright (c) 2002, Elizabeth Krivonos,          }
{                       Alexander Hramov             }
{                                                    }
{====================================================}
{$INCLUDE elpack2.inc}
{$IFDEF ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$ELSE}
{$IFDEF LINUX}
{$I ../ElPack.inc}
{$ELSE}
{$I ..\ElPack.inc}
{$ENDIF}
{$ENDIF}

(*

Version History

*)

unit ElDBConst;

interface

type

    TElDBUnicodeMode = (umFieldType, umForceUTF8);

resourcestring
  SMasterDetailIncompatible = 'Warning! MasterField and DetailField have different data types. When building the tree an attempt will be taken to cast them to one type.';
  SOnErrorInRelation = 'Failed to build relationship in relation %d. Check MasterField and DetailField fields data type and size.';
  SNoSetInstall = 'DataSource undefined. Can'#39't edit.';
  SNoDSetInstall = 'DataSet in DataSource undefined. Can'#39't edit.';
  SOnMoveError = 'Can'#39't move';
  SOnGoToBookmark = 'Can''t find a record in the dataset %s. If you use a parametrised query as a dataset, set DenyLookSetPosition for corresponding relationship to True.';
  SErrorInPattern = 'Error in pattern! Check names of data fields and syntax.';
  SErrorPrebuildLevel = 'Minimum possible value of this parameter is 2';
  SNoColumnSetAssigned = 'DataSet for TreeGrid columns undefined.';
  SNoValidDataSetName = 'The name %s for DataSet for TreeGrid columns is not valid.'#39'Check that this DataSet participates in building of tree';
  SIncorrectColumnIndex = 'Incorrect column index';
  SIncorrectFieldName = 'Name %s id incorrect';

implementation

end.
