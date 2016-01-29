{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.Touch.GestureConsts;

interface

resourcestring
  // RTS engine
  SAddIStylusAsyncPluginError = 'Unable to add IStylusAsyncPlugin: %s';
  SAddIStylusSyncPluginError = 'Unable to add IStylusSyncPlugin: %s';
  SRemoveIStylusAsyncPluginError = 'Unable to remove IStylusAsyncPlugin: %s';
  SRemoveIStylusSyncPluginError = 'Unable to remove IStylusSyncPlugin: %s';
  SStylusHandleError = 'Unable to get or set window handle: %s';
  SStylusEnableError = 'Unable to enable or disable IRealTimeStylus: %s';
  SEnableRecognizerError = 'Unable to enable or disable IGestureRecognizer: %s';
  SInitialGesturePointError = 'Unable to retrieve initial gesture point';
  SSetStylusGestureError = 'Unable to set stylus gestures: %s';

  // TGesturePreview
  SStartPoint = 'Start point';
  SStartPoints = 'Start points';

  // TGestureListView
  SNameColumn = 'Name';

  // TGestureManager
  SInvalidStreamFormat = 'Invalid stream format';
  SControlNotFound = 'Control not found';
  STooManyRegisteredGestures = 'Too many registered gestures';
  SRegisteredGestureNotFound = 'The following registered gestures were not found:'#13#10#13#10'%s';
  SDuplicateRegisteredGestureName = 'A registered gesture named %s already exists';
  SDuplicateRecordedGestureName = 'A recorded gesture named %s already exists';
  SInvalidGestureID = 'Invalid gesture ID (%d)';
  SInvalidGestureName = 'Invalid gesture name (%s)';

  // TGestureCollectionItem
  SDuplicateGestureName = 'Duplicate gesture name: %s';

implementation

end.
