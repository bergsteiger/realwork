{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.Configuration;

interface

uses Androidapi.AssetManager;

(*$HPPEMIT '#include <android/configuration.h>' *)

{$I Androidapi.inc}

type
  AConfiguration = record end;
  {$EXTERNALSYM AConfiguration}
  PAConfiguration = ^AConfiguration;

const
  ACONFIGURATION_ORIENTATION_ANY = $0000;
  {$EXTERNALSYM ACONFIGURATION_ORIENTATION_ANY}
  
  ACONFIGURATION_ORIENTATION_PORT = $0001;
  {$EXTERNALSYM ACONFIGURATION_ORIENTATION_PORT}
  
  ACONFIGURATION_ORIENTATION_LAND = $0002;
  {$EXTERNALSYM ACONFIGURATION_ORIENTATION_LAND}
  
  ACONFIGURATION_ORIENTATION_SQUARE = $0003;
  {$EXTERNALSYM ACONFIGURATION_ORIENTATION_SQUARE}
  
  ACONFIGURATION_TOUCHSCREEN_ANY = $0000;
  {$EXTERNALSYM ACONFIGURATION_TOUCHSCREEN_ANY}
  
  ACONFIGURATION_TOUCHSCREEN_NOTOUCH = $0001;
  {$EXTERNALSYM ACONFIGURATION_TOUCHSCREEN_NOTOUCH}
  
  ACONFIGURATION_TOUCHSCREEN_STYLUS = $0002;
  {$EXTERNALSYM ACONFIGURATION_TOUCHSCREEN_STYLUS}
  
  ACONFIGURATION_TOUCHSCREEN_FINGER = $0003;
  {$EXTERNALSYM ACONFIGURATION_TOUCHSCREEN_FINGER}
  
  ACONFIGURATION_DENSITY_DEFAULT = 0;
  {$EXTERNALSYM ACONFIGURATION_DENSITY_DEFAULT}
  
  ACONFIGURATION_DENSITY_LOW = 120;
  {$EXTERNALSYM ACONFIGURATION_DENSITY_LOW}
  
  ACONFIGURATION_DENSITY_MEDIUM = 160;
  {$EXTERNALSYM ACONFIGURATION_DENSITY_MEDIUM}
  
  ACONFIGURATION_DENSITY_HIGH = 240;
  {$EXTERNALSYM ACONFIGURATION_DENSITY_HIGH}
  
  ACONFIGURATION_DENSITY_NONE = $ffff;
  {$EXTERNALSYM ACONFIGURATION_DENSITY_NONE}
  
  ACONFIGURATION_KEYBOARD_ANY = $0000;
  {$EXTERNALSYM ACONFIGURATION_KEYBOARD_ANY}
  
  ACONFIGURATION_KEYBOARD_NOKEYS = $0001;
  {$EXTERNALSYM ACONFIGURATION_KEYBOARD_NOKEYS}
  
  ACONFIGURATION_KEYBOARD_QWERTY = $0002;
  {$EXTERNALSYM ACONFIGURATION_KEYBOARD_QWERTY}
  
  ACONFIGURATION_KEYBOARD_12KEY = $0003;
  {$EXTERNALSYM ACONFIGURATION_KEYBOARD_12KEY}
  
  ACONFIGURATION_NAVIGATION_ANY = $0000;
  {$EXTERNALSYM ACONFIGURATION_NAVIGATION_ANY}
  
  ACONFIGURATION_NAVIGATION_NONAV = $0001;
  {$EXTERNALSYM ACONFIGURATION_NAVIGATION_NONAV}
  
  ACONFIGURATION_NAVIGATION_DPAD = $0002;
  {$EXTERNALSYM ACONFIGURATION_NAVIGATION_DPAD}
  
  ACONFIGURATION_NAVIGATION_TRACKBALL = $0003;
  {$EXTERNALSYM ACONFIGURATION_NAVIGATION_TRACKBALL}
  
  ACONFIGURATION_NAVIGATION_WHEEL = $0004;
  {$EXTERNALSYM ACONFIGURATION_NAVIGATION_WHEEL}
  
  ACONFIGURATION_KEYSHIDDEN_ANY = $0000;
  {$EXTERNALSYM ACONFIGURATION_KEYSHIDDEN_ANY}
  
  ACONFIGURATION_KEYSHIDDEN_NO = $0001;
  {$EXTERNALSYM ACONFIGURATION_KEYSHIDDEN_NO}
  
  ACONFIGURATION_KEYSHIDDEN_YES = $0002;
  {$EXTERNALSYM ACONFIGURATION_KEYSHIDDEN_YES}
  
  ACONFIGURATION_KEYSHIDDEN_SOFT = $0003;
  {$EXTERNALSYM ACONFIGURATION_KEYSHIDDEN_SOFT}
  
  ACONFIGURATION_NAVHIDDEN_ANY = $0000;
  {$EXTERNALSYM ACONFIGURATION_NAVHIDDEN_ANY}
  
  ACONFIGURATION_NAVHIDDEN_NO = $0001;
  {$EXTERNALSYM ACONFIGURATION_NAVHIDDEN_NO}
  
  ACONFIGURATION_NAVHIDDEN_YES = $0002;
  {$EXTERNALSYM ACONFIGURATION_NAVHIDDEN_YES}
  
  ACONFIGURATION_SCREENSIZE_ANY = $00;
  {$EXTERNALSYM ACONFIGURATION_SCREENSIZE_ANY}
  
  ACONFIGURATION_SCREENSIZE_SMALL = $01;
  {$EXTERNALSYM ACONFIGURATION_SCREENSIZE_SMALL}
  
  ACONFIGURATION_SCREENSIZE_NORMAL = $02;
  {$EXTERNALSYM ACONFIGURATION_SCREENSIZE_NORMAL}
  
  ACONFIGURATION_SCREENSIZE_LARGE = $03;
  {$EXTERNALSYM ACONFIGURATION_SCREENSIZE_LARGE}
  
  ACONFIGURATION_SCREENSIZE_XLARGE = $04;
  {$EXTERNALSYM ACONFIGURATION_SCREENSIZE_XLARGE}
  
  ACONFIGURATION_SCREENLONG_ANY = $00;
  {$EXTERNALSYM ACONFIGURATION_SCREENLONG_ANY}
  
  ACONFIGURATION_SCREENLONG_NO = $1;
  {$EXTERNALSYM ACONFIGURATION_SCREENLONG_NO}
  
  ACONFIGURATION_SCREENLONG_YES = $2;
  {$EXTERNALSYM ACONFIGURATION_SCREENLONG_YES}
  
  ACONFIGURATION_UI_MODE_TYPE_ANY = $00;
  {$EXTERNALSYM ACONFIGURATION_UI_MODE_TYPE_ANY}
  
  ACONFIGURATION_UI_MODE_TYPE_NORMAL = $01;
  {$EXTERNALSYM ACONFIGURATION_UI_MODE_TYPE_NORMAL}
  
  ACONFIGURATION_UI_MODE_TYPE_DESK = $02;
  {$EXTERNALSYM ACONFIGURATION_UI_MODE_TYPE_DESK}
  
  ACONFIGURATION_UI_MODE_TYPE_CAR = $03;
  {$EXTERNALSYM ACONFIGURATION_UI_MODE_TYPE_CAR}
  
  ACONFIGURATION_UI_MODE_NIGHT_ANY = $00;
  {$EXTERNALSYM ACONFIGURATION_UI_MODE_NIGHT_ANY}
  
  ACONFIGURATION_UI_MODE_NIGHT_NO = $1;
  {$EXTERNALSYM ACONFIGURATION_UI_MODE_NIGHT_NO}
  
  ACONFIGURATION_UI_MODE_NIGHT_YES = $2;
  {$EXTERNALSYM ACONFIGURATION_UI_MODE_NIGHT_YES}
  
  ACONFIGURATION_Mcc = $0001;
  {$EXTERNALSYM ACONFIGURATION_Mcc}
  
  ACONFIGURATION_Mnc = $0002;
  {$EXTERNALSYM ACONFIGURATION_Mnc}
  
  ACONFIGURATION_LOCALE = $0004;
  {$EXTERNALSYM ACONFIGURATION_LOCALE}
  
  ACONFIGURATION_TOUCHSCREEN = $0008;
  {$EXTERNALSYM ACONFIGURATION_TOUCHSCREEN}
  
  ACONFIGURATION_KEYBOARD = $0010;
  {$EXTERNALSYM ACONFIGURATION_KEYBOARD}
  
  ACONFIGURATION_KEYBOARD_HIDDEN = $0020;
  {$EXTERNALSYM ACONFIGURATION_KEYBOARD_HIDDEN}
  
  ACONFIGURATION_NAVIGATION = $0040;
  {$EXTERNALSYM ACONFIGURATION_NAVIGATION}
  
  ACONFIGURATION_ORIENTATION = $0080;
  {$EXTERNALSYM ACONFIGURATION_ORIENTATION}
  
  ACONFIGURATION_DENSITY = $0100;
  {$EXTERNALSYM ACONFIGURATION_DENSITY}
  
  ACONFIGURATION_SCREEN_SIZE = $0200;
  {$EXTERNALSYM ACONFIGURATION_SCREEN_SIZE}
  
  ACONFIGURATION_VERSION = $0400;
  {$EXTERNALSYM ACONFIGURATION_VERSION}
  
  ACONFIGURATION_SCREEN_LAYOUT = $0800;
  {$EXTERNALSYM ACONFIGURATION_SCREEN_LAYOUT}
  
  ACONFIGURATION_UI_MODE = $1000;
  {$EXTERNALSYM ACONFIGURATION_UI_MODE}
  

{ Create a new AConfiguration, initialized with no values set.
}
function AConfiguration_new: PAConfiguration; cdecl;
  external AndroidLib name 'AConfiguration_new'
{$EXTERNALSYM AConfiguration_new}

{ Free an AConfiguration that was previously created with
  AConfiguration_new().
}
procedure AConfiguration_delete(Config: PAConfiguration); cdecl;
  external AndroidLib name 'AConfiguration_delete'
{$EXTERNALSYM AConfiguration_delete}

{ Create and return a new AConfiguration based on the current configuration in
  use in the given AssetManager.
}
procedure AConfiguration_fromAssetManager(OutConfig: PAConfiguration;AssetManager: PAAssetManager); cdecl;
  external AndroidLib name 'AConfiguration_fromAssetManager'
{$EXTERNALSYM AConfiguration_fromAssetManager}

{ Copy the contents of 'src' to 'dest'.
}
procedure AConfiguration_copy(DestConfig, SrcConfig: PAConfiguration); cdecl;
  external AndroidLib name 'AConfiguration_copy'
{$EXTERNALSYM AConfiguration_copy}

{ Return the current Mcc set in the configuration.  0 if not set.
}
function AConfiguration_getMcc(Config: PAConfiguration): Int32; cdecl;
  external AndroidLib name 'AConfiguration_getMcc'
{$EXTERNALSYM AConfiguration_getMcc}

{ Set the current Mcc in the configuration.  0 to clear.
}
procedure AConfiguration_setMcc(Config: PAConfiguration; Mcc: Int32); cdecl;
  external AndroidLib name 'AConfiguration_setMcc'
{$EXTERNALSYM AConfiguration_setMcc}

{ Return the current Mnc set in the configuration.  0 if not set.
}
function AConfiguration_getMnc(Config: PAConfiguration): Int32; cdecl;
  external AndroidLib name 'AConfiguration_getMnc'
{$EXTERNALSYM AConfiguration_getMnc}

{ Set the current Mnc in the configuration.  0 to clear.
}
procedure AConfiguration_setMnc(Config: PAConfiguration; Mnc: Int32); cdecl;
  external AndroidLib name 'AConfiguration_setMnc'
{$EXTERNALSYM AConfiguration_setMnc}

{ Return the current language code set in the configuration.  The output will
  be filled with an array of two characters.  They are not 0-terminated.  If
  a language is not set, they will be 0.
}
procedure AConfiguration_getLanguage(Config: PAConfiguration; OutLanguage: MarshaledAString); cdecl;
  external AndroidLib name 'AConfiguration_getLanguage'
{$EXTERNALSYM AConfiguration_getLanguage}

{ Set the current language code in the configuration, from the first two
  characters in the string.
}
procedure AConfiguration_setLanguage(Config: PAConfiguration; const Language:  MarshaledAString); cdecl;
  external AndroidLib name 'AConfiguration_setLanguage'
{$EXTERNALSYM AConfiguration_setLanguage}

{ Return the current country code set in the configuration.  The output will
  be filled with an array of two characters.  They are not 0-terminated.  If
  a country is not set, they will be 0.
}
procedure AConfiguration_getCountry(Config: PAConfiguration; OutCountry:  MarshaledAString); cdecl;
  external AndroidLib name 'AConfiguration_getCountry'
{$EXTERNALSYM AConfiguration_getCountry}

{ Set the current country code in the configuration, from the first two
  characters in the string.
}
procedure AConfiguration_setCountry(Config: PAConfiguration; const Country:  MarshaledAString); cdecl;
  external AndroidLib name 'AConfiguration_setCountry'
{$EXTERNALSYM AConfiguration_setCountry}

{ Return the current ACONFIGURATION_ORIENTATION_* set in the configuration.
}
function AConfiguration_getOrientation(Config: PAConfiguration): Int32; cdecl;
  external AndroidLib name 'AConfiguration_getOrientation'
{$EXTERNALSYM AConfiguration_getOrientation}

{ Set the current orientation in the configuration.
}
procedure AConfiguration_setOrientation(Config: PAConfiguration; Orientation: Int32); cdecl;
  external AndroidLib name 'AConfiguration_setOrientation'
{$EXTERNALSYM AConfiguration_setOrientation}

{ Return the current ACONFIGURATION_TOUCHSCREEN_* set in the configuration.
}
function AConfiguration_getTouchscreen(Config: PAConfiguration): Int32; cdecl;
  external AndroidLib name 'AConfiguration_getTouchscreen'
{$EXTERNALSYM AConfiguration_getTouchscreen}

{ Set the current touchscreen in the configuration.
}
procedure AConfiguration_setTouchscreen(Config: PAConfiguration; TouchScreen: Int32); cdecl;
  external AndroidLib name 'AConfiguration_setTouchscreen'
{$EXTERNALSYM AConfiguration_setTouchscreen}

{ Return the current ACONFIGURATION_DENSITY_* set in the configuration.
}
function AConfiguration_getDensity(Config: PAConfiguration): Int32; cdecl;
  external AndroidLib name 'AConfiguration_getDensity'
{$EXTERNALSYM AConfiguration_getDensity}

{ Set the current density in the configuration.
}
procedure AConfiguration_setDensity(Config: PAConfiguration; density: Int32); cdecl;
  external AndroidLib name 'AConfiguration_setDensity'
{$EXTERNALSYM AConfiguration_setDensity}

{ Return the current ACONFIGURATION_KEYBOARD_* set in the configuration.
}
function AConfiguration_getKeyboard(Config: PAConfiguration): Int32; cdecl;
  external AndroidLib name 'AConfiguration_getKeyboard'
{$EXTERNALSYM AConfiguration_getKeyboard}

{ Set the current keyboard in the configuration.
}
procedure AConfiguration_setKeyboard(Config: PAConfiguration; keyboard: Int32); cdecl;
  external AndroidLib name 'AConfiguration_setKeyboard'
{$EXTERNALSYM AConfiguration_setKeyboard}

{ Return the current ACONFIGURATION_NAVIGATION_* set in the configuration.
}
function AConfiguration_getNavigation(Config: PAConfiguration): Int32; cdecl;
  external AndroidLib name 'AConfiguration_getNavigation'
{$EXTERNALSYM AConfiguration_getNavigation}

{ Set the current navigation in the configuration.
}
procedure AConfiguration_setNavigation(Config: PAConfiguration; navigation: Int32); cdecl;
  external AndroidLib name 'AConfiguration_setNavigation'
{$EXTERNALSYM AConfiguration_setNavigation}

{ Return the current ACONFIGURATION_KEYSHIDDEN_* set in the configuration.
}
function AConfiguration_getKeysHidden(Config: PAConfiguration): Int32; cdecl;
  external AndroidLib name 'AConfiguration_getKeysHidden'
{$EXTERNALSYM AConfiguration_getKeysHidden}

{ Set the current keys hidden in the configuration.
}
procedure AConfiguration_setKeysHidden(Config: PAConfiguration; keysHidden: Int32); cdecl;
  external AndroidLib name 'AConfiguration_setKeysHidden'
{$EXTERNALSYM AConfiguration_setKeysHidden}

{ Return the current ACONFIGURATION_NAVHIDDEN_* set in the configuration.
}
function AConfiguration_getNavHidden(Config: PAConfiguration): Int32; cdecl;
  external AndroidLib name 'AConfiguration_getNavHidden'
{$EXTERNALSYM AConfiguration_getNavHidden}

{ Set the current nav hidden in the configuration.
}
procedure AConfiguration_setNavHidden(Config: PAConfiguration; navHidden: Int32); cdecl;
  external AndroidLib name 'AConfiguration_setNavHidden'
{$EXTERNALSYM AConfiguration_setNavHidden}

{ Return the current SDK (API) version set in the configuration.
}
function AConfiguration_getSdkVersion(Config: PAConfiguration): Int32; cdecl;
  external AndroidLib name 'AConfiguration_getSdkVersion'
{$EXTERNALSYM AConfiguration_getSdkVersion}

{ Set the current SDK version in the configuration.
}
procedure AConfiguration_setSdkVersion(Config: PAConfiguration; sdkVersion: Int32); cdecl;
  external AndroidLib name 'AConfiguration_setSdkVersion'
{$EXTERNALSYM AConfiguration_setSdkVersion}

{ Return the current ACONFIGURATION_SCREENSIZE_* set in the configuration.
}
function AConfiguration_getScreenSize(Config: PAConfiguration): Int32; cdecl;
  external AndroidLib name 'AConfiguration_getScreenSize'
{$EXTERNALSYM AConfiguration_getScreenSize}

{ Set the current screen size in the configuration.
}
procedure AConfiguration_setScreenSize(Config: PAConfiguration; screenSize: Int32); cdecl;
  external AndroidLib name 'AConfiguration_setScreenSize'
{$EXTERNALSYM AConfiguration_setScreenSize}

{ Return the current ACONFIGURATION_SCREENLONG_* set in the configuration.
}
function AConfiguration_getScreenLong(Config: PAConfiguration): Int32; cdecl;
  external AndroidLib name 'AConfiguration_getScreenLong'
{$EXTERNALSYM AConfiguration_getScreenLong}

{ Set the current screen long in the configuration.
}
procedure AConfiguration_setScreenLong(Config: PAConfiguration; screenLong: Int32); cdecl;
  external AndroidLib name 'AConfiguration_setScreenLong'
{$EXTERNALSYM AConfiguration_setScreenLong}

{ Return the current ACONFIGURATION_UI_MODE_TYPE_* set in the configuration.
}
function AConfiguration_getUiModeType(Config: PAConfiguration): Int32; cdecl;
  external AndroidLib name 'AConfiguration_getUiModeType'
{$EXTERNALSYM AConfiguration_getUiModeType}

{ Set the current UI mode type in the configuration.
}
procedure AConfiguration_setUiModeType(Config: PAConfiguration; uiModeType: Int32); cdecl;
  external AndroidLib name 'AConfiguration_setUiModeType'
{$EXTERNALSYM AConfiguration_setUiModeType}

{ Return the current ACONFIGURATION_UI_MODE_NIGHT_* set in the configuration.
}
function AConfiguration_getUiModeNight(Config: PAConfiguration): Int32; cdecl;
  external AndroidLib name 'AConfiguration_getUiModeNight'
{$EXTERNALSYM AConfiguration_getUiModeNight}

{ Set the current UI mode night in the configuration.
}
procedure AConfiguration_setUiModeNight(Config: PAConfiguration; uiModeNight: Int32); cdecl;
  external AndroidLib name 'AConfiguration_setUiModeNight'
{$EXTERNALSYM AConfiguration_setUiModeNight}

{ Perform a diff between two configurations.  Returns a bit mask of
  ACONFIGURATION_* constants, each bit set meaning that configuration element
  is different between them.
}
function AConfiguration_diff(Config1, Config2: PAConfiguration): Int32; cdecl;
  external AndroidLib name 'AConfiguration_diff'
{$EXTERNALSYM AConfiguration_diff}

{ Determine whether 'base' is a valid configuration for use within the
  environment 'requested'.  Returns 0 if there are any values in 'base'
  that conflict with 'requested'.  Returns 1 if it does not conflict.
}
function AConfiguration_match(BaseConfig, RequestedConfig: PAConfiguration): Int32; cdecl;
  external AndroidLib name 'AConfiguration_match'
{$EXTERNALSYM AConfiguration_match}

{ Determine whether the configuration in 'test' is better than the existing
  configuration in 'base'.  If 'requested' is non-NULL, this decision is based
  on the overall configuration given there.  If it is NULL, this decision is
  simply based on which configuration is more specific.  Returns non-0 if
  'test' is better than 'base'.
  
  This assumes you have already filtered the configurations with
  AConfiguration_match().
}
function AConfiguration_isBetterThan(BaseConfig, TestConfig, RequestedConfig: PAConfiguration) : Int32; cdecl;
  external AndroidLib name 'AConfiguration_isBetterThan'
{$EXTERNALSYM AConfiguration_isBetterThan}

implementation

end.

