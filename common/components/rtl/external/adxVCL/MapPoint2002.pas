{*********************************************************************}
{                                                                     }
{             Add-In Express Component Library                        }
{                  Add-in Express for VCL                             }
{                                                                     }
{             Copyright (C) Add-in Express Ltd.                       }
{             ALL RIGHTS RESERVED                                     }
{                                                                     }
{    The entire contents of this file is protected by U.S. and        }
{    International Copyright Laws. Unauthorized reproduction,         }
{    reverse-engineering, and distribution of all or any portion of   } 
{    the code contained in this file is strictly prohibited and may   }
{    result in severe civil and criminal penalties and will be        }
{    prosecuted to the maximum extent possible under the law.         }
{                                                                     }
{    RESTRICTIONS                                                     }
{                                                                     }
{    THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES ARE        }
{    CONFIDENTIAL AND PROPRIETARY TRADE SECRETS OF ADD-IN EXPRESS     }
{    LTD.                                                             }
{    THE REGISTERED DEVELOPER IS LICENSED TO DISTRIBUTE THE Add-in    }
{    Express VCL AND ALL ACCOMPANYING VCL COMPONENTS AS PART          }
{    OF AN EXECUTABLE PROGRAM ONLY.                                   }
{                                                                     }
{    THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{    FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{    COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{    AVAILABLE TO OTHER INDIVIDUALS WITHOUT WRITTEN CONSENT           }
{    AND PERMISSION FROM ADD-IN EXPRESS LTD.                          }
{                                                                     }
{    CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{    ADDITIONAL RESTRICTIONS.                                         }
{                                                                     }
{*********************************************************************}

unit MapPoint2002;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 4/25/2003 4:28:19 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Program Files\Microsoft MapPoint\MPNA81.TLB (1)
// LIBID: {31851F80-AFE6-11D2-A3C9-00C04F72F340}
// LCID: 0
// Helpfile: D:\Program Files\Microsoft MapPoint\mappoint.chm
// HelpString: Microsoft MapPoint 9.0 Object Library (North America)
// DepndLst: 
//   (1) v2.0 stdole, (D:\WINDOWS\System32\stdole2.tlb)
// Errors:
//   Hint: Member 'GoTo' of 'Location' changed to 'GoTo_'
//   Hint: Member 'Location' of 'Location' changed to 'Location_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Member 'GoTo' of 'Pushpin' changed to 'GoTo_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of Shapes.AddShape changed to 'Type_'
//   Hint: Member 'GoTo' of 'Location80' changed to 'GoTo_'
//   Hint: Member 'GoTo' of 'Pushpin80' changed to 'GoTo_'
//   Hint: Symbol 'Type' renamed to 'type_'
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
interface

{$I adxDefs.inc}

uses Windows, ActiveX, Classes, Graphics, OleServer,
{$IFNDEF ADX_VCL5}
  Variants,
{$ENDIF}
  StdVCL;


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  MapPointMajorVersion = 8;
  MapPointMinorVersion = 1;

  LIBID_MapPoint: TGUID = '{31851F80-AFE6-11D2-A3C9-00C04F72F340}';

  IID__Application: TGUID = '{D6D389CE-1781-47A0-8984-4349687F65D6}';
  IID__Map: TGUID = '{52BEC548-B6B1-4434-9783-D44863E7AF3B}';
  IID_Location: TGUID = '{C23AFD16-D9AF-447E-B5F4-358D19036393}';
  IID_PlaceCategory: TGUID = '{61CD43DD-8484-4177-A294-AB00B71F7F6E}';
  IID_PlaceCategories: TGUID = '{92749A3A-053D-4C1A-B785-36AB5226AC3C}';
  IID_FindResults: TGUID = '{188084CF-DB96-482B-97A6-2571DF9BEF81}';
  IID_StreetAddress: TGUID = '{0D2E1D77-574E-4723-9AB8-E00917168187}';
  IID_Route: TGUID = '{103A1FE8-639E-4020-8150-1B9B91DC91A7}';
  IID_Waypoints: TGUID = '{31851F93-AFE6-11D2-A3C9-00C04F72F340}';
  IID_Waypoint: TGUID = '{25EFD1D9-B3A1-4778-A019-A42112372B79}';
  IID_Directions: TGUID = '{9EE7CB66-2A15-4CFF-9DEC-A9D162DCD38D}';
  IID_Direction: TGUID = '{C49898CB-A475-4E87-9822-57FC1729C6D8}';
  IID_DriverProfile: TGUID = '{7049C92B-C653-46D0-AADA-6C4B0CEC96D7}';
  IID_DataSets: TGUID = '{CE5B074B-6D34-4DE1-9C7F-5562F33899BE}';
  IID_DataSet: TGUID = '{9A3776C3-6F62-4DDA-81BB-4C92DA35A169}';
  IID_Fields: TGUID = '{31851F96-AFE6-11D2-A3C9-00C04F72F340}';
  IID_Field: TGUID = '{0B91C4E8-6541-4C6E-A69E-AD8B65F9CBF3}';
  IID_Recordset: TGUID = '{BF5745A2-65B9-464E-8BC6-24AD5B3953A5}';
  IID_Pushpin: TGUID = '{34B0F619-37E1-4C76-A6DA-69BF75A5D3DE}';
  IID_Hyperlink: TGUID = '{2DB7D89E-D474-49C9-9D1D-3C18EDC05D3C}';
  IID_DataMap: TGUID = '{3F469C6D-AC65-4864-9BDE-CB38CD44362C}';
  IID_DataRanges: TGUID = '{31851F99-AFE6-11D2-A3C9-00C04F72F340}';
  IID_DataRange: TGUID = '{C383611E-1319-4019-895D-F0AE3FCA67FA}';
  IID_Shape: TGUID = '{EF3817E9-A8F6-4EA6-8CFD-3F2D97A35644}';
  IID_Shapes: TGUID = '{FD1FC959-8A2F-43A6-9F5A-FE68B9E78F4D}';
  IID_Adjustments: TGUID = '{E23B1D46-B358-4F18-A396-153CE0E3F26E}';
  IID_LineFormat: TGUID = '{3A43DDF9-4E58-49E5-9779-8C97052DEA73}';
  IID_FillFormat: TGUID = '{85A310EA-F134-47D7-B186-4C10314A626F}';
  IID_SelectedArea: TGUID = '{B87D4AE6-A827-488F-A40F-8A399F316D3A}';
  IID_PageSetup: TGUID = '{8AA806BB-4F9F-44FF-A139-B766361403BA}';
  IID_SavedWebPages: TGUID = '{C08F15C8-F3FD-45AF-AEA4-1019983CCF42}';
  IID_SavedWebPage: TGUID = '{C674DC89-7FCA-4AB0-8906-950C32520F6B}';
  IID_Symbols: TGUID = '{BA556839-86AF-4995-A52D-D1CCE8009E20}';
  IID_Symbol: TGUID = '{28C5D50F-6A13-4931-B25B-C4A84AD59C70}';
  IID_Toolbars: TGUID = '{95621048-6F1C-46CB-AE15-16991D4869BE}';
  IID_Toolbar: TGUID = '{B870697B-4295-46FB-B97C-C9E3FA5DF55A}';
  IID_AddIns: TGUID = '{0A9247B4-02BD-4F12-B79E-681D6405A848}';
  IID__Application80: TGUID = '{31851F81-AFE6-11D2-A3C9-00C04F72F340}';
  IID__Map80: TGUID = '{31851F83-AFE6-11D2-A3C9-00C04F72F340}';
  DIID__MapEvents: TGUID = '{1C7E3C54-DC9B-4714-90FD-0AB297E1D2E5}';
  DIID__ApplicationEvents: TGUID = '{91848759-5033-4956-8E9C-B840F11C6045}';
  IID_Location80: TGUID = '{31851F85-AFE6-11D2-A3C9-00C04F72F340}';
  IID_Route80: TGUID = '{31851F91-AFE6-11D2-A3C9-00C04F72F340}';
  IID_Waypoint80: TGUID = '{31851F92-AFE6-11D2-A3C9-00C04F72F340}';
  IID_DataSet80: TGUID = '{31851F90-AFE6-11D2-A3C9-00C04F72F340}';
  IID_DataMap80: TGUID = '{31851F97-AFE6-11D2-A3C9-00C04F72F340}';
  IID_DataRange80: TGUID = '{31851F98-AFE6-11D2-A3C9-00C04F72F340}';
  IID__MapPointUtilities: TGUID = '{33A1C7CE-9E37-4A11-8213-0413A20C66BA}';
  CLASS_MapPointUtilities: TGUID = '{520DA2E0-BDE7-4AE2-A8D1-8FDFE5E8A305}';
  CLASS_Application: TGUID = '{31851F82-AFE6-11D2-A3C9-00C04F72F340}';
  CLASS_Map: TGUID = '{31851F84-AFE6-11D2-A3C9-00C04F72F340}';
  IID_DataSets80: TGUID = '{31851F89-AFE6-11D2-A3C9-00C04F72F340}';
  IID_Pushpin80: TGUID = '{31851F87-AFE6-11D2-A3C9-00C04F72F340}';
  IID_Recordset80: TGUID = '{31851F94-AFE6-11D2-A3C9-00C04F72F340}';
  IID_Field80: TGUID = '{31851F95-AFE6-11D2-A3C9-00C04F72F340}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum GeoFieldType
type
  GeoFieldType = TOleEnum;
const
  geoFieldSkipped = $00000000;
  geoFieldName = $00000001;
  geoFieldName2 = $00000002;
  geoFieldAddress1 = $00000003;
  geoFieldAddress2 = $00000004;
  geoFieldAddress3 = $00000005;
  geoFieldCity = $00000006;
  geoFieldOtherCity = $00000007;
  geoFieldRegion3 = $00000008;
  geoFieldRegion2 = $00000009;
  geoFieldRegion1 = $0000000A;
  geoFieldPostal1 = $0000000B;
  geoFieldPostal2 = $0000000C;
  geoFieldPostal3 = $0000000D;
  geoFieldPostal4 = $0000000E;
  geoFieldCountry = $0000000F;
  geoFieldCensus1 = $00000010;
  geoFieldCensus2 = $00000011;
  geoFieldOSGridRef = $00000013;
  geoFieldLatitude = $00000014;
  geoFieldLongitude = $00000015;
  geoFieldInformation = $00000016;
  geoFieldData = $00000017;
  geoFieldTerritory = $00000019;

// Constants for enum GeoCountry
type
  GeoCountry = TOleEnum;
const
  geoCountryDefault = $00000000;
  geoCountryAlbania = $00000006;
  geoCountryArgentina = $0000000B;
  geoCountryAustralia = $0000000C;
  geoCountryAustria = $0000000E;
  geoCountryBangladesh = $00000017;
  geoCountryBelarus = $0000001D;
  geoCountryBelgium = $00000015;
  geoCountryBolivia = $0000001A;
  geoCountryBrazil = $00000020;
  geoCountryBulgaria = $00000023;
  geoCountryCanada = $00000027;
  geoCountryChile = $0000002E;
  geoCountryChina = $0000002D;
  geoCountryColombia = $00000033;
  geoCountryCzechRepublic = $0000004B;
  geoCountryDenmark = $0000003D;
  geoCountryEcuador = $00000042;
  geoCountryEstonia = $00000046;
  geoCountryFinland = $0000004D;
  geoCountryFrance = $00000054;
  geoCountryFrenchGuiana = $0000004C;
  geoCountryGeorgia = $00000058;
  geoCountryGermany = $0000005E;
  geoCountryGreece = $00000062;
  geoCountryHungary = $0000006D;
  geoCountryIceland = $0000006E;
  geoCountryIndia = $00000071;
  geoCountryIndonesia = $0000006F;
  geoCountryIreland = $00000044;
  geoCountryItaly = $00000076;
  geoCountryJapan = $0000007A;
  geoCountryLatvia = $0000008C;
  geoCountryLiechtenstein = $00000091;
  geoCountryLithuania = $0000008D;
  geoCountryLuxembourg = $00000093;
  geoCountryMalaysia = $000000A7;
  geoCountryMexico = $000000A6;
  geoCountryNorthKorea = $00000083;
  geoCountryNorway = $000000B1;
  geoCountryParaguay = $000000B9;
  geoCountryPeru = $000000BB;
  geoCountryPoland = $000000BF;
  geoCountryPortugal = $000000C1;
  geoCountryRomania = $000000C8;
  geoCountryRussia = $000000CB;
  geoCountrySlovakia = $0000008F;
  geoCountrySlovenia = $000000D4;
  geoCountrySouthAfrica = $000000D1;
  geoCountrySouthKorea = $00000086;
  geoCountrySpain = $000000D9;
  geoCountrySuriname = $000000B5;
  geoCountrySweden = $000000DD;
  geoCountrySwitzerland = $000000DF;
  geoCountryTheNetherlands = $000000B0;
  geoCountryTurkey = $000000EB;
  geoCountryUkraine = $000000F1;
  geoCountryUnitedKingdom = $000000F2;
  geoCountryUnitedStates = $000000F4;
  geoCountryUruguay = $000000F6;
  geoCountryVenezuela = $000000F9;
  geoCountryMultiCountry = $0000989E;

// Constants for enum GeoZOrderCmd
type
  GeoZOrderCmd = TOleEnum;
const
  geoBringToFront = $00000000;
  geoSendToBack = $00000001;
  geoBringForward = $00000002;
  geoSendBackward = $00000003;
  geoBringInFrontOfRoads = $00000004;
  geoSendBehindRoads = $00000005;

// Constants for enum GeoDirectionType
type
  GeoDirectionType = TOleEnum;
const
  geoDirectionOther = $00000000;
  geoDirectionDriving = $00000001;
  geoDirectionBorder = $00000002;
  geoDirectionStartOfDay = $00000003;
  geoDirectionEndOfDay = $00000004;
  geoDirectionFuel = $00000005;
  geoDirectionConstruction = $00000006;
  geoDirectionRestBreak = $00000007;
  geoDirectionWarning = $00000008;
  geoDirectionWaypoint = $00000009;

// Constants for enum GeoDirectionAction
type
  GeoDirectionAction = TOleEnum;
const
  geoActionOther = $00000000;
  geoActionDepart = $00000001;
  geoActionArrive = $00000002;
  geoActionTurnLeft = $00000003;
  geoActionTurnRight = $00000004;
  geoActionBearLeft = $00000005;
  geoActionBearRight = $00000006;
  geoActionMerge = $00000007;
  geoActionContinue = $00000008;
  geoActionCrossBorder = $00000009;
  geoActionTurnBack = $0000000A;
  geoActionEnterRoundabout = $0000000B;
  geoActionExitRoundabout = $0000000C;

// Constants for enum GeoShapeType
type
  GeoShapeType = TOleEnum;
const
  geoAutoShape = $00000001;
  geoFreeform = $00000005;
  geoLine = $00000009;
  geoTextBox = $00000011;

// Constants for enum GeoAutoShapeType
type
  GeoAutoShapeType = TOleEnum;
const
  geoShapeRadius = $000003F1;
  geoShapeOval = $00000009;
  geoShapeRectangle = $00000001;

// Constants for enum GeoDelimiter
type
  GeoDelimiter = TOleEnum;
const
  geoDelimiterDefault = $00000000;
  geoDelimiterTab = $00000009;
  geoDelimiterSemicolon = $0000003B;
  geoDelimiterComma = $0000002C;

// Constants for enum DataTypeEnum
type
  DataTypeEnum = TOleEnum;
const
  adEmpty = $00000000;
  adTinyInt = $00000010;
  adSmallInt = $00000002;
  adInteger = $00000003;
  adBigInt = $00000014;
  adUnsignedTinyInt = $00000011;
  adUnsignedSmallInt = $00000012;
  adUnsignedInt = $00000013;
  adUnsignedBigInt = $00000015;
  adSingle = $00000004;
  adDouble = $00000005;
  adCurrency = $00000006;
  adDecimal = $0000000E;
  adNumeric = $00000083;
  adBoolean = $0000000B;
  adError = $0000000A;
  adUserDefined = $00000084;
  adVariant = $0000000C;
  adIDispatch = $00000009;
  adIUnknown = $0000000D;
  adGUID = $00000048;
  adDate = $00000007;
  adDBDate = $00000085;
  adDBTime = $00000086;
  adDBTimeStamp = $00000087;
  adBSTR = $00000008;
  adChar = $00000081;
  adVarChar = $000000C8;
  adLongVarChar = $000000C9;
  adWChar = $00000082;
  adVarWChar = $000000CA;
  adLongVarWChar = $000000CB;
  adBinary = $00000080;
  adVarBinary = $000000CC;
  adLongVarBinary = $000000CD;
  adChapter = $00000088;
  adFileTime = $00000040;
  adDBFileTime = $00000089;
  adPropVariant = $0000008A;
  adVarNumeric = $0000008B;

// Constants for enum GeoMapRegion
type
  GeoMapRegion = TOleEnum;
const
  geoMapNorthAmerica = $00000001;
  geoMapEurope = $00000002;

// Constants for enum GeoOrderCmd
type
  GeoOrderCmd = TOleEnum;
const
  geoMoveToTop = $00000000;
  geoMoveToBottom = $00000001;
  geoMoveUp = $00000002;
  geoMoveDown = $00000003;

// Constants for enum GeoUnits
type
  GeoUnits = TOleEnum;
const
  geoMiles = $00000000;
  geoKm = $00000001;

// Constants for enum GeoSaveFormat
type
  GeoSaveFormat = TOleEnum;
const
  geoFormatMap = $00000000;
  geoFormatTemplate = $00000001;
  geoFormatHTMLMap = $00000002;
  geoFormatHTMLDirections = $00000003;
  geoFormatHTMLMapAndDirections = $00000004;

// Constants for enum GeoWindowState
type
  GeoWindowState = TOleEnum;
const
  geoWindowStateMaximize = $00000000;
  geoWindowStateMinimize = $00000001;
  geoWindowStateNormal = $00000002;

// Constants for enum GeoMapStyle
type
  GeoMapStyle = TOleEnum;
const
  geoMapStyleRoad = $00000000;
  geoMapStyleRoadData = $00000001;
  geoMapStyleData = $00000002;
  geoMapStyleTerrain = $00000003;
  geoMapStylePolitical = $00000004;

// Constants for enum GeoMapFont
type
  GeoMapFont = TOleEnum;
const
  geoMapFontLargest = $00000000;
  geoMapFontLarger = $00000001;
  geoMapFontMedium = $00000002;
  geoMapFontSmaller = $00000003;
  geoMapFontSmallest = $00000004;

// Constants for enum GeoMapProjection
type
  GeoMapProjection = TOleEnum;
const
  geoGlobeViewWhenZoomedOut = $00000000;
  geoFlatViewWhenZoomedOut = $00000001;

// Constants for enum GeoBalloonState
type
  GeoBalloonState = TOleEnum;
const
  geoDisplayNone = $00000000;
  geoDisplayName = $00000001;
  geoDisplayBalloon = $00000002;

// Constants for enum GeoSegmentPreferences
type
  GeoSegmentPreferences = TOleEnum;
const
  geoSegmentQuickest = $00000000;
  geoSegmentShortest = $00000001;
  geoSegmentPreferred = $00000002;

// Constants for enum GeoDataMapType
type
  GeoDataMapType = TOleEnum;
const
  geoDataMapTypeDefault = $FFFFFFFF;
  geoDataMapTypeNone = $00000000;
  geoDataMapTypeShadedArea = $00000001;
  geoDataMapTypeSizedCircle = $00000002;
  geoDataMapTypeShadedCircle = $00000003;
  geoDataMapTypePushpin = $00000004;
  geoDataMapTypeMultipleSymbol = $00000005;
  geoDataMapTypeSizedPie = $00000006;
  geoDataMapTypeUnsizedPie = $00000007;
  geoDataMapTypeCategoricalColumn = $00000008;
  geoDataMapTypeSeriesColumn = $00000009;
  geoDataMapTypeTerritory = $0000000A;

// Constants for enum GeoShowDataBy
type
  GeoShowDataBy = TOleEnum;
const
  geoShowByZoomLevel = $FFFFFFFE;
  geoShowByDefault = $FFFFFFFF;
  geoShowByTerritory = $00000004;
  geoShowByLatLong = $00000005;
  geoShowByOSGridRef = $00000006;
  geoShowByStreetAddress = $00000007;
  geoShowByCity = $00000008;
  geoShowByCensus1 = $00000009;
  geoShowByCensus2 = $0000000A;
  geoShowByPostal1 = $0000000C;
  geoShowByPostal2 = $0000000D;
  geoShowByPostal3 = $0000000E;
  geoShowByPostal4 = $0000000F;
  geoShowByRegion3 = $00000010;
  geoShowByRegion2 = $00000011;
  geoShowByRegion1 = $00000012;
  geoShowByCountry = $00000013;

// Constants for enum GeoMatchingMethod
type
  GeoMatchingMethod = TOleEnum;
const
  geoByNone = $00000001;
  geoByHand = $00000002;
  geoByFindAddress = $00000003;
  geoByTerritory = $00000004;
  geoByLatLong = $00000005;
  geoByOSGridRef = $00000006;
  geoByStreetAddress = $00000007;
  geoByCity = $00000008;
  geoByCensus1 = $00000009;
  geoByCensus2 = $0000000A;
  geoByPostal1 = $0000000C;
  geoByPostal2 = $0000000D;
  geoByPostal3 = $0000000E;
  geoByPostal4 = $0000000F;
  geoByRegion3 = $00000010;
  geoByRegion2 = $00000011;
  geoByRegion1 = $00000012;
  geoByCountry = $00000013;
  geoByOtherCity = $00000014;

// Constants for enum GeoCombineDataBy
type
  GeoCombineDataBy = TOleEnum;
const
  geoCombineByDefault = $FFFFFFFF;
  geoCombineByNone = $00000000;
  geoCombineByAdd = $00000001;
  geoCombineByAverage = $00000002;
  geoCombineByCount = $00000003;

// Constants for enum GeoDataRangeType
type
  GeoDataRangeType = TOleEnum;
const
  geoRangeTypeDefault = $FFFFFFFF;
  geoRangeTypeContinuous = $00000001;
  geoRangeTypeContinuousLog = $00000002;
  geoRangeTypeDiscreteEqualRanges = $00000003;
  geoRangeTypeEqualDataPoints = $00000004;
  geoRangeTypeDiscreteLogRanges = $00000005;
  geoRangeTypeUniqueValues = $00000006;
  geoRangeTypeNone = $00000007;

// Constants for enum GeoDataRangeOrder
type
  GeoDataRangeOrder = TOleEnum;
const
  geoRangeOrderDefault = $FFFFFFFF;
  geoRangeOrderLowToHigh = $00000001;
  geoRangeOrderHighToLow = $00000002;

// Constants for enum GeoPrintArea
type
  GeoPrintArea = TOleEnum;
const
  geoPrintMap = $00000000;
  geoPrintDirections = $00000001;
  geoPrintTurnByTurn = $00000002;
  geoPrintStripMaps = $00000003;
  geoPrintSelectedArea = $00000004;
  geoPrintHighlightedPlaces = $00000005;

// Constants for enum GeoPrintQuality
type
  GeoPrintQuality = TOleEnum;
const
  geoPrintQualityNormal = $00000000;
  geoPrintQualityDraft = $00000001;
  geoPrintQualityPresentation = $00000002;

// Constants for enum GeoPrintOrientation
type
  GeoPrintOrientation = TOleEnum;
const
  geoPrintPortrait = $00000000;
  geoPrintLandscape = $00000001;
  geoPrintAuto = $00000002;

// Constants for enum GeoPaneState
type
  GeoPaneState = TOleEnum;
const
  geoPaneLegend = $00000000;
  geoPaneRoutePlanner = $00000001;
  geoPaneNearbyPlaces = $00000002;
  geoPaneNone = $00000003;
  geoPaneTerritory = $00000004;

// Constants for enum GeoFindState
type
  GeoFindState = TOleEnum;
const
  geoFindDefault = $00000000;
  geoFindAddress = $00000001;
  geoFindPlace = $00000002;
  geoFindLatLong = $00000003;
  geoFindOSGrid = $00000004;

// Constants for enum GeoPanCmd
type
  GeoPanCmd = TOleEnum;
const
  geoSouthWest = $00000001;
  geoSouth = $00000002;
  geoSouthEast = $00000003;
  geoWest = $00000004;
  geoEast = $00000006;
  geoNorthWest = $00000007;
  geoNorth = $00000008;
  geoNorthEast = $00000009;

// Constants for enum GeoTriState
type
  GeoTriState = TOleEnum;
const
  geoTriStateToggle = $FFFFFFFD;
  geoTriStateMixed = $FFFFFFFE;
  geoTrue = $FFFFFFFF;
  geoFalse = $00000000;

// Constants for enum GeoWaypointType
type
  GeoWaypointType = TOleEnum;
const
  geoWaypointStart = $00000001;
  geoWaypointStop = $00000002;
  geoWaypointEnd = $00000003;

// Constants for enum GeoPointer
type
  GeoPointer = TOleEnum;
const
  geoPointerDefault = $00000000;
  geoPointerArrow = $00000001;
  geoPointerCrosshair = $00000002;
  geoPointerIbeam = $00000003;
  geoPointerSizeNESW = $00000006;
  geoPointerSizeNS = $00000007;
  geoPointerSizeNWSE = $00000008;
  geoPointerSizeWE = $00000009;
  geoPointerUpArrow = $0000000A;
  geoPointerHourglass = $0000000B;
  geoPointerNoDrop = $0000000C;
  geoPointerArrowHourglass = $0000000D;
  geoPointerArrowQuestion = $0000000E;
  geoPointerSizeAll = $0000000F;
  geoPointerHand = $00000017;

// Constants for enum GeoDataSetHowCreated
type
  GeoDataSetHowCreated = TOleEnum;
const
  geoDataSetManual = $00000001;
  geoDataSetImport = $00000002;
  geoDataSetLink = $00000003;
  geoDataSetDemographic = $00000005;

// Constants for enum GeoDataSetHyperlinkType
type
  GeoDataSetHyperlinkType = TOleEnum;
const
  geoHyperlinkNone = $00000000;
  geoHyperlinkNotes = $00000001;
  geoHyperlinkField = $00000002;
  geoHyperlinkCalculated = $00000003;

// Constants for enum GeoDataMappingPage
type
  GeoDataMappingPage = TOleEnum;
const
  geoMapTypePage = $00000000;
  geoDataSetPage = $00000001;
  geoDataFieldsPage = $00000002;
  geoLegendPage = $00000003;
  geoChartLegendPage = $00000004;
  geoPushpinSetPage = $00000005;

// Constants for enum GeoVolumeUnits
type
  GeoVolumeUnits = TOleEnum;
const
  geoLiters = $00000001;
  geoUSGallons = $00000002;
  geoUKGallons = $00000003;

// Constants for enum GeoDrivingCostUnits
type
  GeoDrivingCostUnits = TOleEnum;
const
  geoCostBasedOnDistance = $00000000;
  geoCostBasedOnLiters = $00000001;
  geoCostBasedOnUSGallons = $00000002;
  geoCostBasedOnUKGallons = $00000003;

// Constants for enum GeoFuelConsumptionUnits
type
  GeoFuelConsumptionUnits = TOleEnum;
const
  geoLitersPer100Kilometers = $00000001;
  geoLitersPer10Kilometers = $00000002;
  geoMilesPerGallonUS = $00000003;
  geoMilesPerGallonUK = $00000004;

// Constants for enum GeoDragBehavior
type
  GeoDragBehavior = TOleEnum;
const
  geoDragNone = $00000000;
  geoDragHand = $00000001;
  geoDragBox = $00000002;
  geoDragOther = $00000003;

// Constants for enum GeoRoadType
type
  GeoRoadType = TOleEnum;
const
  geoRoadInterstate = $00000001;
  geoRoadLimitedAccess = $00000002;
  geoRoadOtherHighway = $00000003;
  geoRoadArterial = $00000004;
  geoRoadStreet = $00000005;
  geoRoadToll = $00000006;
  geoRoadFerry = $00000007;

// Constants for enum GeoFindResultsQuality
type
  GeoFindResultsQuality = TOleEnum;
const
  geoAllResultsValid = $00000000;
  geoFirstResultGood = $00000001;
  geoAmbiguousResults = $00000002;
  geoNoGoodResult = $00000003;
  geoNoResults = $00000004;

// Constants for enum GeoPaperSize
type
  GeoPaperSize = TOleEnum;
const
  geoPaper10x14 = $00000010;
  geoPaper11x17 = $00000011;
  geoPaperA3 = $00000008;
  geoPaperA4 = $00000009;
  geoPaperA4Small = $0000000A;
  geoPaperA5 = $0000000B;
  geoPaperB4 = $0000000C;
  geoPaperB5 = $0000000D;
  geoPaperCSheet = $00000018;
  geoPaperDSheet = $00000019;
  geoPaperEnvelope9 = $00000013;
  geoPaperEnvelope10 = $00000014;
  geoPaperEnvelope11 = $00000015;
  geoPaperEnvelope12 = $00000016;
  geoPaperEnvelope14 = $00000017;
  geoPaperEnvelopeB4 = $00000021;
  geoPaperEnvelopeB5 = $00000022;
  geoPaperEnvelopeB6 = $00000023;
  geoPaperEnvelopeC3 = $0000001D;
  geoPaperEnvelopeC4 = $0000001E;
  geoPaperEnvelopeC5 = $0000001C;
  geoPaperEnvelopeC6 = $0000001F;
  geoPaperEnvelopeC65 = $00000020;
  geoPaperEnvelopeDL = $0000001B;
  geoPaperEnvelopeItaly = $00000024;
  geoPaperEnvelopeMonarch = $00000025;
  geoPaperEnvelopePersonal = $00000026;
  geoPaperESheet = $0000001A;
  geoPaperExecutive = $00000007;
  geoPaperFanfoldLglGerman = $00000029;
  geoPaperFanfoldStdGerman = $00000028;
  geoPaperFanfoldUS = $00000027;
  geoPaperFolio = $0000000E;
  geoPaperLedger = $00000004;
  geoPaperLegal = $00000005;
  geoPaperLetter = $00000001;
  geoPaperLetterSmall = $00000002;
  geoPaperNote = $00000012;
  geoPaperQuarto = $0000000F;
  geoPaperStatement = $00000006;
  geoPaperTabloid = $00000003;
  geoPaperUser = $00000100;

// Constants for enum GeoPageBreakFrequency
type
  GeoPageBreakFrequency = TOleEnum;
const
  geoPageBreakMinimum = $00000001;
  geoPageBreakMore = $00000002;
  geoPageBreakStop = $00000003;
  geoPageBreakDay = $00000004;
  geoPageBreakDistance = $00000005;
  geoPageBreakTime = $00000006;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _Application = interface;
  _ApplicationDisp = dispinterface;
  _Map = interface;
  _MapDisp = dispinterface;
  Location = interface;
  LocationDisp = dispinterface;
  PlaceCategory = interface;
  PlaceCategoryDisp = dispinterface;
  PlaceCategories = interface;
  PlaceCategoriesDisp = dispinterface;
  FindResults = interface;
  FindResultsDisp = dispinterface;
  StreetAddress = interface;
  StreetAddressDisp = dispinterface;
  Route = interface;
  RouteDisp = dispinterface;
  Waypoints = interface;
  WaypointsDisp = dispinterface;
  Waypoint = interface;
  WaypointDisp = dispinterface;
  Directions = interface;
  DirectionsDisp = dispinterface;
  Direction = interface;
  DirectionDisp = dispinterface;
  DriverProfile = interface;
  DriverProfileDisp = dispinterface;
  DataSets = interface;
  DataSetsDisp = dispinterface;
  DataSet = interface;
  DataSetDisp = dispinterface;
  Fields = interface;
  FieldsDisp = dispinterface;
  Field = interface;
  FieldDisp = dispinterface;
  Recordset = interface;
  RecordsetDisp = dispinterface;
  Pushpin = interface;
  PushpinDisp = dispinterface;
  Hyperlink = interface;
  HyperlinkDisp = dispinterface;
  DataMap = interface;
  DataMapDisp = dispinterface;
  DataRanges = interface;
  DataRangesDisp = dispinterface;
  DataRange = interface;
  DataRangeDisp = dispinterface;
  Shape = interface;
  ShapeDisp = dispinterface;
  Shapes = interface;
  ShapesDisp = dispinterface;
  Adjustments = interface;
  AdjustmentsDisp = dispinterface;
  LineFormat = interface;
  LineFormatDisp = dispinterface;
  FillFormat = interface;
  FillFormatDisp = dispinterface;
  SelectedArea = interface;
  SelectedAreaDisp = dispinterface;
  PageSetup = interface;
  PageSetupDisp = dispinterface;
  SavedWebPages = interface;
  SavedWebPagesDisp = dispinterface;
  SavedWebPage = interface;
  SavedWebPageDisp = dispinterface;
  Symbols = interface;
  SymbolsDisp = dispinterface;
  Symbol = interface;
  SymbolDisp = dispinterface;
  Toolbars = interface;
  ToolbarsDisp = dispinterface;
  Toolbar = interface;
  ToolbarDisp = dispinterface;
  AddIns = interface;
  AddInsDisp = dispinterface;
  _Application80 = interface;
  _Application80Disp = dispinterface;
  _Map80 = interface;
  _Map80Disp = dispinterface;
  _MapEvents = dispinterface;
  _ApplicationEvents = dispinterface;
  Location80 = interface;
  Location80Disp = dispinterface;
  Route80 = interface;
  Route80Disp = dispinterface;
  Waypoint80 = interface;
  Waypoint80Disp = dispinterface;
  DataSet80 = interface;
  DataSet80Disp = dispinterface;
  DataMap80 = interface;
  DataMap80Disp = dispinterface;
  DataRange80 = interface;
  DataRange80Disp = dispinterface;
  _MapPointUtilities = interface;
  _MapPointUtilitiesDisp = dispinterface;
  DataSets80 = interface;
  DataSets80Disp = dispinterface;
  Pushpin80 = interface;
  Pushpin80Disp = dispinterface;
  Recordset80 = interface;
  Recordset80Disp = dispinterface;
  Field80 = interface;
  Field80Disp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  MapPointUtilities = _MapPointUtilities;
  Application = _Application;
  Map = _Map;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PPSafeArray1 = ^PSafeArray; {*}
  POleVariant1 = ^OleVariant; {*}
  PPSafeArray2 = ^PSafeArray; {*}

  GeoRGBType = Integer; 

// *********************************************************************//
// Interface: _Application
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {D6D389CE-1781-47A0-8984-4349687F65D6}
// *********************************************************************//
  _Application = interface(IDispatch)
    ['{D6D389CE-1781-47A0-8984-4349687F65D6}']
    function Get_Application: _Application; safecall;
    function Get_Parent: _Application; safecall;
    function Get_Name: WideString; safecall;
    function Get_ActiveMap: _Map; safecall;
    function OpenMap(const FileName: WideString; AddToRecentFiles: WordBool): _Map; safecall;
    function NewMap(const Template: WideString): _Map; safecall;
    function Get_Caption: WideString; safecall;
    procedure Set_Caption(const pVal: WideString); safecall;
    function Get_Path: WideString; safecall;
    function Get_DefaultFilePath: WideString; safecall;
    function Get_FullName: WideString; safecall;
    function Get_Version: WideString; safecall;
    function Get_Build: WideString; safecall;
    procedure Activate; safecall;
    function Get_Height: Integer; safecall;
    procedure Set_Height(pVal: Integer); safecall;
    function Get_Left: Integer; safecall;
    procedure Set_Left(pVal: Integer); safecall;
    function Get_Width: Integer; safecall;
    procedure Set_Width(pVal: Integer); safecall;
    function Get_Top: Integer; safecall;
    procedure Set_Top(pVal: Integer); safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(pVal: WordBool); safecall;
    function Get_WindowState: GeoWindowState; safecall;
    procedure Set_WindowState(pVal: GeoWindowState); safecall;
    procedure AddCommand(const DisplayName: WideString; const MethodName: WideString; 
                         const Target: IDispatch); safecall;
    procedure RemoveCommands(const Target: IDispatch); safecall;
    function Get_Units: GeoUnits; safecall;
    procedure Set_Units(pVal: GeoUnits); safecall;
    function Get_PaneState: GeoPaneState; safecall;
    procedure Set_PaneState(pVal: GeoPaneState); safecall;
    function Get_Region: GeoMapRegion; safecall;
    procedure Quit; safecall;
    function Get_UserControl: WordBool; safecall;
    procedure Set_UserControl(pVal: WordBool); safecall;
    function Get_ItineraryVisible: WordBool; safecall;
    procedure Set_ItineraryVisible(pVal: WordBool); safecall;
    function Get_Toolbars: Toolbars; safecall;
    function Get_ActivePrinter: WideString; safecall;
    procedure Set_ActivePrinter(const pVal: WideString); safecall;
    function Get_MousePointer: GeoPointer; safecall;
    procedure Set_MousePointer(pVal: GeoPointer); safecall;
    function Get_AddIns: AddIns; safecall;
    property Application: _Application read Get_Application;
    property Parent: _Application read Get_Parent;
    property Name: WideString read Get_Name;
    property ActiveMap: _Map read Get_ActiveMap;
    property Caption: WideString read Get_Caption write Set_Caption;
    property Path: WideString read Get_Path;
    property DefaultFilePath: WideString read Get_DefaultFilePath;
    property FullName: WideString read Get_FullName;
    property Version: WideString read Get_Version;
    property Build: WideString read Get_Build;
    property Height: Integer read Get_Height write Set_Height;
    property Left: Integer read Get_Left write Set_Left;
    property Width: Integer read Get_Width write Set_Width;
    property Top: Integer read Get_Top write Set_Top;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property WindowState: GeoWindowState read Get_WindowState write Set_WindowState;
    property Units: GeoUnits read Get_Units write Set_Units;
    property PaneState: GeoPaneState read Get_PaneState write Set_PaneState;
    property Region: GeoMapRegion read Get_Region;
    property UserControl: WordBool read Get_UserControl write Set_UserControl;
    property ItineraryVisible: WordBool read Get_ItineraryVisible write Set_ItineraryVisible;
    property Toolbars: Toolbars read Get_Toolbars;
    property ActivePrinter: WideString read Get_ActivePrinter write Set_ActivePrinter;
    property MousePointer: GeoPointer read Get_MousePointer write Set_MousePointer;
    property AddIns: AddIns read Get_AddIns;
  end;

// *********************************************************************//
// DispIntf:  _ApplicationDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {D6D389CE-1781-47A0-8984-4349687F65D6}
// *********************************************************************//
  _ApplicationDisp = dispinterface
    ['{D6D389CE-1781-47A0-8984-4349687F65D6}']
    property Application: _Application readonly dispid 100663313;
    property Parent: _Application readonly dispid -803;
    property Name: WideString readonly dispid -800;
    property ActiveMap: _Map readonly dispid 100663553;
    function OpenMap(const FileName: WideString; AddToRecentFiles: WordBool): _Map; dispid 100794627;
    function NewMap(const Template: WideString): _Map; dispid 100794628;
    property Caption: WideString dispid 100663558;
    property Path: WideString readonly dispid 100663317;
    property DefaultFilePath: WideString readonly dispid 100663559;
    property FullName: WideString readonly dispid 100663316;
    property Version: WideString readonly dispid 100663560;
    property Build: WideString readonly dispid 100663561;
    procedure Activate; dispid 100794649;
    property Height: Integer dispid 100663570;
    property Left: Integer dispid 100663571;
    property Width: Integer dispid 100663572;
    property Top: Integer dispid 100663573;
    property Visible: WordBool dispid 100663574;
    property WindowState: GeoWindowState dispid 100663575;
    procedure AddCommand(const DisplayName: WideString; const MethodName: WideString; 
                         const Target: IDispatch); dispid 100794656;
    procedure RemoveCommands(const Target: IDispatch); dispid 100794657;
    property Units: GeoUnits dispid 100663554;
    property PaneState: GeoPaneState dispid 100663576;
    property Region: GeoMapRegion readonly dispid 100663569;
    procedure Quit; dispid 100794629;
    property UserControl: WordBool dispid 100663562;
    property ItineraryVisible: WordBool dispid 100663563;
    property Toolbars: Toolbars readonly dispid 100663564;
    property ActivePrinter: WideString dispid 100663565;
    property MousePointer: GeoPointer dispid 100663852;
    property AddIns: AddIns readonly dispid 100663566;
  end;

// *********************************************************************//
// Interface: _Map
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {52BEC548-B6B1-4434-9783-D44863E7AF3B}
// *********************************************************************//
  _Map = interface(IDispatch)
    ['{52BEC548-B6B1-4434-9783-D44863E7AF3B}']
    function Get_Application: _Application; safecall;
    function Get_Parent: _Application; safecall;
    function Get_Name: WideString; safecall;
    function Get_Container: IDispatch; safecall;
    function Get_Saved: WordBool; safecall;
    procedure Set_Saved(pVal: WordBool); safecall;
    function Get_FullName: WideString; safecall;
    function Get_Path: WideString; safecall;
    procedure _Set_Location(const ppVal: Location); safecall;
    function Get_Location: Location; safecall;
    function Get_Altitude: Double; safecall;
    procedure Set_Altitude(pVal: Double); safecall;
    function Get_ActiveRoute: Route; safecall;
    function Get_DataSets: DataSets; safecall;
    function Get_MapStyle: GeoMapStyle; safecall;
    procedure Set_MapStyle(pVal: GeoMapStyle); safecall;
    function Get_MapFont: GeoMapFont; safecall;
    procedure Set_MapFont(pVal: GeoMapFont); safecall;
    procedure Save; safecall;
    procedure SaveAs(const FileName: WideString; SaveFormat: GeoSaveFormat; 
                     AddToRecentFiles: WordBool); safecall;
    procedure PrintOut(const OutputFileName: WideString; const Title: WideString; Copies: Integer; 
                       PrintArea: GeoPrintArea; PrintQuality: GeoPrintQuality; 
                       PrintOrientation: GeoPrintOrientation; Collate: WordBool; 
                       IncludeLegend: WordBool; IncludeOverview: WordBool; Faxable: WordBool); safecall;
    function Find(const Name: WideString): IDispatch; safecall;
    function ShowFindDialog80(const Name: WideString; FindState: GeoFindState; HWndParent: Integer): IDispatch; safecall;
    function FindAddress(const Street: WideString; var AddressStrings: PSafeArray): Location; safecall;
    function FindPushpin(const Name: WideString): Pushpin; safecall;
    function AddPushpin(const AtLocation: Location; const Name: WideString): Pushpin; safecall;
    procedure CopyMap; safecall;
    procedure CopyDirections; safecall;
    function Distance(const StartLocation: Location; const EndLocation: Location): Double; safecall;
    procedure GoToLatLong(Latitude: Double; Longitude: Double; Altitude: Double); safecall;
    function GetLocation(Latitude: Double; Longitude: Double; Altitude: Double): Location; safecall;
    function Get_Selection: IDispatch; safecall;
    function Get_Shapes: Shapes; safecall;
    function Get_PlaceCategories: PlaceCategories; safecall;
    function FindResults(const Name: WideString): FindResults; safecall;
    function FindAddressResults(const Street: WideString; const City: WideString; 
                                const OtherCity: WideString; const Region: WideString; 
                                const PostalCode: WideString; Country: OleVariant): FindResults; safecall;
    function ShowFindDialog(const Name: WideString; FindState: GeoFindState; HWndParent: Integer; 
                            AutoConfirmExactMatch: WordBool): IDispatch; safecall;
    function Get_Top: Integer; safecall;
    function Get_Left: Integer; safecall;
    function Get_Height: Integer; safecall;
    function Get_Width: Integer; safecall;
    function XYToLocation(X: Integer; Y: Integer): Location; safecall;
    function LocationToX(const Where: Location): Integer; safecall;
    function LocationToY(const Where: Location): Integer; safecall;
    function Get_PixelSize: Double; safecall;
    procedure Pan(PanDirection: GeoPanCmd; PanFactor: Double); safecall;
    function Get_SelectedArea: SelectedArea; safecall;
    function Union(ArrayOfLocations: OleVariant): Location; safecall;
    function ObjectsFromPoint(X: Integer; Y: Integer): FindResults; safecall;
    procedure ZoomIn; safecall;
    procedure ZoomOut; safecall;
    procedure GoBack; safecall;
    procedure GoForward; safecall;
    procedure Paste; safecall;
    function Get_Projection: GeoMapProjection; safecall;
    procedure Set_Projection(pVal: GeoMapProjection); safecall;
    function Get_PageSetup: PageSetup; safecall;
    function Get_AllowEdgePan: WordBool; safecall;
    procedure Set_AllowEdgePan(pVal: WordBool); safecall;
    function Get_DragBehavior: GeoDragBehavior; safecall;
    procedure Set_DragBehavior(pVal: GeoDragBehavior); safecall;
    function Get_SavedWebPages: SavedWebPages; safecall;
    function ParseStreetAddress(const Address: WideString): StreetAddress; safecall;
    function Get_Symbols: Symbols; safecall;
    function FindPlaceResults(const Name: WideString): FindResults; safecall;
    property Application: _Application read Get_Application;
    property Parent: _Application read Get_Parent;
    property Name: WideString read Get_Name;
    property Container: IDispatch read Get_Container;
    property Saved: WordBool read Get_Saved write Set_Saved;
    property FullName: WideString read Get_FullName;
    property Path: WideString read Get_Path;
    property Location: Location read Get_Location write _Set_Location;
    property Altitude: Double read Get_Altitude write Set_Altitude;
    property ActiveRoute: Route read Get_ActiveRoute;
    property DataSets: DataSets read Get_DataSets;
    property MapStyle: GeoMapStyle read Get_MapStyle write Set_MapStyle;
    property MapFont: GeoMapFont read Get_MapFont write Set_MapFont;
    property Selection: IDispatch read Get_Selection;
    property Shapes: Shapes read Get_Shapes;
    property PlaceCategories: PlaceCategories read Get_PlaceCategories;
    property Top: Integer read Get_Top;
    property Left: Integer read Get_Left;
    property Height: Integer read Get_Height;
    property Width: Integer read Get_Width;
    property PixelSize: Double read Get_PixelSize;
    property SelectedArea: SelectedArea read Get_SelectedArea;
    property Projection: GeoMapProjection read Get_Projection write Set_Projection;
    property PageSetup: PageSetup read Get_PageSetup;
    property AllowEdgePan: WordBool read Get_AllowEdgePan write Set_AllowEdgePan;
    property DragBehavior: GeoDragBehavior read Get_DragBehavior write Set_DragBehavior;
    property SavedWebPages: SavedWebPages read Get_SavedWebPages;
    property Symbols: Symbols read Get_Symbols;
  end;

// *********************************************************************//
// DispIntf:  _MapDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {52BEC548-B6B1-4434-9783-D44863E7AF3B}
// *********************************************************************//
  _MapDisp = dispinterface
    ['{52BEC548-B6B1-4434-9783-D44863E7AF3B}']
    property Application: _Application readonly dispid 100663313;
    property Parent: _Application readonly dispid -803;
    property Name: WideString readonly dispid -800;
    property Container: IDispatch readonly dispid 100663825;
    property Saved: WordBool dispid 100663809;
    property FullName: WideString readonly dispid 100663316;
    property Path: WideString readonly dispid 100663317;
    property Location: Location dispid 100663318;
    property Altitude: Double dispid 100663826;
    property ActiveRoute: Route readonly dispid 100663828;
    property DataSets: DataSets readonly dispid 100663829;
    property MapStyle: GeoMapStyle dispid 100663830;
    property MapFont: GeoMapFont dispid 100663831;
    procedure Save; dispid 100794889;
    procedure SaveAs(const FileName: WideString; SaveFormat: GeoSaveFormat; 
                     AddToRecentFiles: WordBool); dispid 100794896;
    procedure PrintOut(const OutputFileName: WideString; const Title: WideString; Copies: Integer; 
                       PrintArea: GeoPrintArea; PrintQuality: GeoPrintQuality; 
                       PrintOrientation: GeoPrintOrientation; Collate: WordBool; 
                       IncludeLegend: WordBool; IncludeOverview: WordBool; Faxable: WordBool); dispid 100794888;
    function Find(const Name: WideString): IDispatch; dispid 100794884;
    function ShowFindDialog80(const Name: WideString; FindState: GeoFindState; HWndParent: Integer): IDispatch; dispid 100794905;
    function FindAddress(const Street: WideString; var AddressStrings: {??PSafeArray}OleVariant): Location; dispid 100794885;
    function FindPushpin(const Name: WideString): Pushpin; dispid 100794886;
    function AddPushpin(const AtLocation: Location; const Name: WideString): Pushpin; dispid 100794912;
    procedure CopyMap; dispid 100794882;
    procedure CopyDirections; dispid 100794904;
    function Distance(const StartLocation: Location; const EndLocation: Location): Double; dispid 100794883;
    procedure GoToLatLong(Latitude: Double; Longitude: Double; Altitude: Double); dispid 100794887;
    function GetLocation(Latitude: Double; Longitude: Double; Altitude: Double): Location; dispid 100794914;
    property Selection: IDispatch readonly dispid 100663827;
    property Shapes: Shapes readonly dispid 100663818;
    property PlaceCategories: PlaceCategories readonly dispid 100663819;
    function FindResults(const Name: WideString): FindResults; dispid 100794892;
    function FindAddressResults(const Street: WideString; const City: WideString; 
                                const OtherCity: WideString; const Region: WideString; 
                                const PostalCode: WideString; Country: OleVariant): FindResults; dispid 100794893;
    function ShowFindDialog(const Name: WideString; FindState: GeoFindState; HWndParent: Integer; 
                            AutoConfirmExactMatch: WordBool): IDispatch; dispid 100794920;
    property Top: Integer readonly dispid 100663573;
    property Left: Integer readonly dispid 100663571;
    property Height: Integer readonly dispid 100663570;
    property Width: Integer readonly dispid 100663572;
    function XYToLocation(X: Integer; Y: Integer): Location; dispid 100794894;
    function LocationToX(const Where: Location): Integer; dispid 100794895;
    function LocationToY(const Where: Location): Integer; dispid 100794906;
    property PixelSize: Double readonly dispid 100663845;
    procedure Pan(PanDirection: GeoPanCmd; PanFactor: Double); dispid 100794907;
    property SelectedArea: SelectedArea readonly dispid 100663853;
    function Union(ArrayOfLocations: OleVariant): Location; dispid 100794909;
    function ObjectsFromPoint(X: Integer; Y: Integer): FindResults; dispid 100794918;
    procedure ZoomIn; dispid 100794910;
    procedure ZoomOut; dispid 100794911;
    procedure GoBack; dispid 100794916;
    procedure GoForward; dispid 100794915;
    procedure Paste; dispid 100794412;
    property Projection: GeoMapProjection dispid 100663847;
    property PageSetup: PageSetup readonly dispid 100663849;
    property AllowEdgePan: WordBool dispid 100663850;
    property DragBehavior: GeoDragBehavior dispid 100663851;
    property SavedWebPages: SavedWebPages readonly dispid 100663854;
    function ParseStreetAddress(const Address: WideString): StreetAddress; dispid 100663855;
    property Symbols: Symbols readonly dispid 100663856;
    function FindPlaceResults(const Name: WideString): FindResults; dispid 100794929;
  end;

// *********************************************************************//
// Interface: Location
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C23AFD16-D9AF-447E-B5F4-358D19036393}
// *********************************************************************//
  Location = interface(IDispatch)
    ['{C23AFD16-D9AF-447E-B5F4-358D19036393}']
    function Get_Application: _Application; safecall;
    function Get_Parent: _Map; safecall;
    function Get_Name: WideString; safecall;
    procedure GoTo_; safecall;
    function Get_Location_: Location; safecall;
    function Get_PlaceCategory: PlaceCategory; safecall;
    function FindNearby(Distance: Double): FindResults; safecall;
    function Get_Highlight: WordBool; safecall;
    procedure Set_Highlight(pVal: WordBool); safecall;
    function Get_IsHighlightable: WordBool; safecall;
    function DistanceTo(const From: Location): Double; safecall;
    procedure Select; safecall;
    procedure Copy; safecall;
    function Get_StreetAddress: StreetAddress; safecall;
    function Get_type_: GeoShowDataBy; safecall;
    property Application: _Application read Get_Application;
    property Parent: _Map read Get_Parent;
    property Name: WideString read Get_Name;
    property Location_: Location read Get_Location_;
    property PlaceCategory: PlaceCategory read Get_PlaceCategory;
    property Highlight: WordBool read Get_Highlight write Set_Highlight;
    property IsHighlightable: WordBool read Get_IsHighlightable;
    property StreetAddress: StreetAddress read Get_StreetAddress;
    property type_: GeoShowDataBy read Get_type_;
  end;

// *********************************************************************//
// DispIntf:  LocationDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C23AFD16-D9AF-447E-B5F4-358D19036393}
// *********************************************************************//
  LocationDisp = dispinterface
    ['{C23AFD16-D9AF-447E-B5F4-358D19036393}']
    property Application: _Application readonly dispid 100663313;
    property Parent: _Map readonly dispid -803;
    property Name: WideString readonly dispid -800;
    procedure GoTo_; dispid 100794392;
    property Location_: Location readonly dispid 100663318;
    property PlaceCategory: PlaceCategory readonly dispid 100665601;
    function FindNearby(Distance: Double): FindResults; dispid 100794395;
    property Highlight: WordBool dispid 100665345;
    property IsHighlightable: WordBool readonly dispid 100663324;
    function DistanceTo(const From: Location): Double; dispid 100794397;
    procedure Select; dispid 100794399;
    procedure Copy; dispid 100794411;
    property StreetAddress: StreetAddress readonly dispid 100665602;
    property type_: GeoShowDataBy readonly dispid 100665089;
  end;

// *********************************************************************//
// Interface: PlaceCategory
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {61CD43DD-8484-4177-A294-AB00B71F7F6E}
// *********************************************************************//
  PlaceCategory = interface(IDispatch)
    ['{61CD43DD-8484-4177-A294-AB00B71F7F6E}']
    function Get_Application: _Application; safecall;
    function Get_Parent: PlaceCategories; safecall;
    function Get_Name: WideString; safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(pVal: WordBool); safecall;
    function Get_Index: Integer; safecall;
    property Application: _Application read Get_Application;
    property Parent: PlaceCategories read Get_Parent;
    property Name: WideString read Get_Name;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property Index: Integer read Get_Index;
  end;

// *********************************************************************//
// DispIntf:  PlaceCategoryDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {61CD43DD-8484-4177-A294-AB00B71F7F6E}
// *********************************************************************//
  PlaceCategoryDisp = dispinterface
    ['{61CD43DD-8484-4177-A294-AB00B71F7F6E}']
    property Application: _Application readonly dispid 100663313;
    property Parent: PlaceCategories readonly dispid -803;
    property Name: WideString readonly dispid -800;
    property Visible: WordBool dispid 100663574;
    property Index: Integer readonly dispid 100663326;
  end;

// *********************************************************************//
// Interface: PlaceCategories
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {92749A3A-053D-4C1A-B785-36AB5226AC3C}
// *********************************************************************//
  PlaceCategories = interface(IDispatch)
    ['{92749A3A-053D-4C1A-B785-36AB5226AC3C}']
    function Get_Application: _Application; safecall;
    function Get_Parent: _Map; safecall;
    function Get_Count: Integer; safecall;
    function Get__NewEnum: IUnknown; safecall;
    function Get_Item(var Index: OleVariant): PlaceCategory; safecall;
    procedure Set_Visible(val: GeoTriState); safecall;
    function Get_Visible: GeoTriState; safecall;
    property Application: _Application read Get_Application;
    property Parent: _Map read Get_Parent;
    property Count: Integer read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[var Index: OleVariant]: PlaceCategory read Get_Item; default;
    property Visible: GeoTriState read Get_Visible write Set_Visible;
  end;

// *********************************************************************//
// DispIntf:  PlaceCategoriesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {92749A3A-053D-4C1A-B785-36AB5226AC3C}
// *********************************************************************//
  PlaceCategoriesDisp = dispinterface
    ['{92749A3A-053D-4C1A-B785-36AB5226AC3C}']
    property Application: _Application readonly dispid 100663313;
    property Parent: _Map readonly dispid -803;
    property Count: Integer readonly dispid 100663321;
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[var Index: OleVariant]: PlaceCategory readonly dispid 0; default;
    property Visible: GeoTriState dispid 100663574;
  end;

// *********************************************************************//
// Interface: FindResults
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {188084CF-DB96-482B-97A6-2571DF9BEF81}
// *********************************************************************//
  FindResults = interface(IDispatch)
    ['{188084CF-DB96-482B-97A6-2571DF9BEF81}']
    function Get_Application: _Application; safecall;
    function Get_Parent: _Map; safecall;
    function Get_Count: Integer; safecall;
    function Get__NewEnum: IUnknown; safecall;
    function Get_Item(var Index: OleVariant): IDispatch; safecall;
    function Get_ResultsQuality: GeoFindResultsQuality; safecall;
    property Application: _Application read Get_Application;
    property Parent: _Map read Get_Parent;
    property Count: Integer read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[var Index: OleVariant]: IDispatch read Get_Item; default;
    property ResultsQuality: GeoFindResultsQuality read Get_ResultsQuality;
  end;

// *********************************************************************//
// DispIntf:  FindResultsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {188084CF-DB96-482B-97A6-2571DF9BEF81}
// *********************************************************************//
  FindResultsDisp = dispinterface
    ['{188084CF-DB96-482B-97A6-2571DF9BEF81}']
    property Application: _Application readonly dispid 100663313;
    property Parent: _Map readonly dispid -803;
    property Count: Integer readonly dispid 100663321;
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[var Index: OleVariant]: IDispatch readonly dispid 0; default;
    property ResultsQuality: GeoFindResultsQuality readonly dispid 100672001;
  end;

// *********************************************************************//
// Interface: StreetAddress
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0D2E1D77-574E-4723-9AB8-E00917168187}
// *********************************************************************//
  StreetAddress = interface(IDispatch)
    ['{0D2E1D77-574E-4723-9AB8-E00917168187}']
    function Get_Application: _Application; safecall;
    function Get_Parent: _Map; safecall;
    function Get_Street: WideString; safecall;
    function Get_City: WideString; safecall;
    function Get_OtherCity: WideString; safecall;
    function Get_Region: WideString; safecall;
    function Get_PostalCode: WideString; safecall;
    function Get_Country: GeoCountry; safecall;
    function Get_Value: WideString; safecall;
    property Application: _Application read Get_Application;
    property Parent: _Map read Get_Parent;
    property Street: WideString read Get_Street;
    property City: WideString read Get_City;
    property OtherCity: WideString read Get_OtherCity;
    property Region: WideString read Get_Region;
    property PostalCode: WideString read Get_PostalCode;
    property Country: GeoCountry read Get_Country;
    property Value: WideString read Get_Value;
  end;

// *********************************************************************//
// DispIntf:  StreetAddressDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0D2E1D77-574E-4723-9AB8-E00917168187}
// *********************************************************************//
  StreetAddressDisp = dispinterface
    ['{0D2E1D77-574E-4723-9AB8-E00917168187}']
    property Application: _Application readonly dispid 100663313;
    property Parent: _Map readonly dispid -803;
    property Street: WideString readonly dispid 100673025;
    property City: WideString readonly dispid 100673026;
    property OtherCity: WideString readonly dispid 100673027;
    property Region: WideString readonly dispid 100673028;
    property PostalCode: WideString readonly dispid 100673029;
    property Country: GeoCountry readonly dispid 100664409;
    property Value: WideString readonly dispid 0;
  end;

// *********************************************************************//
// Interface: Route
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {103A1FE8-639E-4020-8150-1B9B91DC91A7}
// *********************************************************************//
  Route = interface(IDispatch)
    ['{103A1FE8-639E-4020-8150-1B9B91DC91A7}']
    function Get_Application: _Application; safecall;
    function Get_Parent: _Map; safecall;
    function Get_Waypoints: Waypoints; safecall;
    function Get_IsCalculated: WordBool; safecall;
    procedure Calculate; safecall;
    procedure Clear; safecall;
    function Get_Cost80: Double; safecall;
    function Get_Distance: Double; safecall;
    function Get_DrivingTime: Double; safecall;
    function Get_TripTime: Double; safecall;
    function Get_Cost: Currency; safecall;
    function Get_Directions: Directions; safecall;
    function Get_DriverProfile: DriverProfile; safecall;
    property Application: _Application read Get_Application;
    property Parent: _Map read Get_Parent;
    property Waypoints: Waypoints read Get_Waypoints;
    property IsCalculated: WordBool read Get_IsCalculated;
    property Cost80: Double read Get_Cost80;
    property Distance: Double read Get_Distance;
    property DrivingTime: Double read Get_DrivingTime;
    property TripTime: Double read Get_TripTime;
    property Cost: Currency read Get_Cost;
    property Directions: Directions read Get_Directions;
    property DriverProfile: DriverProfile read Get_DriverProfile;
  end;

// *********************************************************************//
// DispIntf:  RouteDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {103A1FE8-639E-4020-8150-1B9B91DC91A7}
// *********************************************************************//
  RouteDisp = dispinterface
    ['{103A1FE8-639E-4020-8150-1B9B91DC91A7}']
    property Application: _Application readonly dispid 100663313;
    property Parent: _Map readonly dispid -803;
    property Waypoints: Waypoints readonly dispid 100665857;
    property IsCalculated: WordBool readonly dispid 100665858;
    procedure Calculate; dispid 100796935;
    procedure Clear; dispid 100796936;
    property Cost80: Double readonly dispid 100665859;
    property Distance: Double readonly dispid 100665860;
    property DrivingTime: Double readonly dispid 100665861;
    property TripTime: Double readonly dispid 100665862;
    property Cost: Currency readonly dispid 100665865;
    property Directions: Directions readonly dispid 100670210;
    property DriverProfile: DriverProfile readonly dispid 100665866;
  end;

// *********************************************************************//
// Interface: Waypoints
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F93-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  Waypoints = interface(IDispatch)
    ['{31851F93-AFE6-11D2-A3C9-00C04F72F340}']
    function Get_Application: _Application; safecall;
    function Get_Parent: Route; safecall;
    function Get_Count: Integer; safecall;
    function Get_Item(var Index: OleVariant): Waypoint; safecall;
    function Get__NewEnum: IUnknown; safecall;
    function Add(const Anchor: IDispatch; const Name: WideString): Waypoint; safecall;
    function Get_IsOptimized: WordBool; safecall;
    procedure Optimize; safecall;
    property Application: _Application read Get_Application;
    property Parent: Route read Get_Parent;
    property Count: Integer read Get_Count;
    property Item[var Index: OleVariant]: Waypoint read Get_Item; default;
    property _NewEnum: IUnknown read Get__NewEnum;
    property IsOptimized: WordBool read Get_IsOptimized;
  end;

// *********************************************************************//
// DispIntf:  WaypointsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F93-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  WaypointsDisp = dispinterface
    ['{31851F93-AFE6-11D2-A3C9-00C04F72F340}']
    property Application: _Application readonly dispid 100663313;
    property Parent: Route readonly dispid -803;
    property Count: Integer readonly dispid 100663321;
    property Item[var Index: OleVariant]: Waypoint readonly dispid 0; default;
    property _NewEnum: IUnknown readonly dispid -4;
    function Add(const Anchor: IDispatch; const Name: WideString): Waypoint; dispid 100794404;
    property IsOptimized: WordBool readonly dispid 100797185;
    procedure Optimize; dispid 100797186;
  end;

// *********************************************************************//
// Interface: Waypoint
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {25EFD1D9-B3A1-4778-A019-A42112372B79}
// *********************************************************************//
  Waypoint = interface(IDispatch)
    ['{25EFD1D9-B3A1-4778-A019-A42112372B79}']
    function Get_Application: _Application; safecall;
    function Get_Parent: Waypoints; safecall;
    function Get_Name: WideString; safecall;
    procedure Delete; safecall;
    function Get_Location: Location; safecall;
    function Get_Anchor: IDispatch; safecall;
    procedure _Set_Anchor(const ppVal: IDispatch); safecall;
    function Get_PreferredArrival: TDateTime; safecall;
    procedure Set_PreferredArrival(pVal: TDateTime); safecall;
    function Get_PreferredDeparture: TDateTime; safecall;
    procedure Set_PreferredDeparture(pVal: TDateTime); safecall;
    function Get_StopTime: Double; safecall;
    procedure Set_StopTime(pVal: Double); safecall;
    function Get_Overnights: Integer; safecall;
    procedure Set_Overnights(pVal: Integer); safecall;
    function Get_SegmentPreferences: GeoSegmentPreferences; safecall;
    procedure Set_SegmentPreferences(pVal: GeoSegmentPreferences); safecall;
    procedure Set_ListPosition(dPos: Integer); safecall;
    function Get_ListPosition: Integer; safecall;
    procedure Reorder(Order: GeoOrderCmd); safecall;
    function Get_SegmentDirections: Directions; safecall;
    procedure Select; safecall;
    procedure Copy; safecall;
    procedure Cut; safecall;
    function Get_type_: GeoWaypointType; safecall;
    property Application: _Application read Get_Application;
    property Parent: Waypoints read Get_Parent;
    property Name: WideString read Get_Name;
    property Location: Location read Get_Location;
    property Anchor: IDispatch read Get_Anchor write _Set_Anchor;
    property PreferredArrival: TDateTime read Get_PreferredArrival write Set_PreferredArrival;
    property PreferredDeparture: TDateTime read Get_PreferredDeparture write Set_PreferredDeparture;
    property StopTime: Double read Get_StopTime write Set_StopTime;
    property Overnights: Integer read Get_Overnights write Set_Overnights;
    property SegmentPreferences: GeoSegmentPreferences read Get_SegmentPreferences write Set_SegmentPreferences;
    property ListPosition: Integer read Get_ListPosition write Set_ListPosition;
    property SegmentDirections: Directions read Get_SegmentDirections;
    property type_: GeoWaypointType read Get_type_;
  end;

// *********************************************************************//
// DispIntf:  WaypointDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {25EFD1D9-B3A1-4778-A019-A42112372B79}
// *********************************************************************//
  WaypointDisp = dispinterface
    ['{25EFD1D9-B3A1-4778-A019-A42112372B79}']
    property Application: _Application readonly dispid 100663313;
    property Parent: Waypoints readonly dispid -803;
    property Name: WideString readonly dispid -800;
    procedure Delete; dispid -801;
    property Location: Location readonly dispid 100663318;
    property Anchor: IDispatch dispid 100666369;
    property PreferredArrival: TDateTime dispid 100666370;
    property PreferredDeparture: TDateTime dispid 100666371;
    property StopTime: Double dispid 100666372;
    property Overnights: Integer dispid 100666373;
    property SegmentPreferences: GeoSegmentPreferences dispid 100666374;
    property ListPosition: Integer dispid 100666375;
    procedure Reorder(Order: GeoOrderCmd); dispid 100797448;
    property SegmentDirections: Directions readonly dispid 100666377;
    procedure Select; dispid 100794399;
    procedure Copy; dispid 100794411;
    procedure Cut; dispid 100794410;
    property type_: GeoWaypointType readonly dispid 100665089;
  end;

// *********************************************************************//
// Interface: Directions
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9EE7CB66-2A15-4CFF-9DEC-A9D162DCD38D}
// *********************************************************************//
  Directions = interface(IDispatch)
    ['{9EE7CB66-2A15-4CFF-9DEC-A9D162DCD38D}']
    function Get_Application: _Application; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Count: Integer; safecall;
    function Get__NewEnum: IUnknown; safecall;
    function Get_Item(var Index: OleVariant): Direction; safecall;
    procedure Set_Expanded(val: GeoTriState); safecall;
    function Get_Expanded: GeoTriState; safecall;
    function FindNearby(Distance: Double): FindResults; safecall;
    function DistanceTo(const From: Location): Double; safecall;
    function Get_Location: Location; safecall;
    property Application: _Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: Integer read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[var Index: OleVariant]: Direction read Get_Item; default;
    property Expanded: GeoTriState read Get_Expanded write Set_Expanded;
    property Location: Location read Get_Location;
  end;

// *********************************************************************//
// DispIntf:  DirectionsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9EE7CB66-2A15-4CFF-9DEC-A9D162DCD38D}
// *********************************************************************//
  DirectionsDisp = dispinterface
    ['{9EE7CB66-2A15-4CFF-9DEC-A9D162DCD38D}']
    property Application: _Application readonly dispid 100663313;
    property Parent: IDispatch readonly dispid -803;
    property Count: Integer readonly dispid 100663321;
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[var Index: OleVariant]: Direction readonly dispid 0; default;
    property Expanded: GeoTriState dispid 100669953;
    function FindNearby(Distance: Double): FindResults; dispid 100794395;
    function DistanceTo(const From: Location): Double; dispid 100794397;
    property Location: Location readonly dispid 100663318;
  end;

// *********************************************************************//
// Interface: Direction
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C49898CB-A475-4E87-9822-57FC1729C6D8}
// *********************************************************************//
  Direction = interface(IDispatch)
    ['{C49898CB-A475-4E87-9822-57FC1729C6D8}']
    function Get_Application: _Application; safecall;
    function Get_Parent: Directions; safecall;
    function Get_Instruction: WideString; safecall;
    function Get_Index: Integer; safecall;
    function Get_Waypoint: Waypoint; safecall;
    function Get_type_: GeoDirectionType; safecall;
    function Get_Directions: Directions; safecall;
    function Get_Toward: WideString; safecall;
    function Get_Action: GeoDirectionAction; safecall;
    function Get_Distance: Double; safecall;
    function Get_StartTime: TDateTime; safecall;
    function Get_ElapsedDistance: Double; safecall;
    function FindNearby(Distance: Double): FindResults; safecall;
    function DistanceTo(const From: Location): Double; safecall;
    function Get_Location: Location; safecall;
    procedure Select; safecall;
    property Application: _Application read Get_Application;
    property Parent: Directions read Get_Parent;
    property Instruction: WideString read Get_Instruction;
    property Index: Integer read Get_Index;
    property Waypoint: Waypoint read Get_Waypoint;
    property type_: GeoDirectionType read Get_type_;
    property Directions: Directions read Get_Directions;
    property Toward: WideString read Get_Toward;
    property Action: GeoDirectionAction read Get_Action;
    property Distance: Double read Get_Distance;
    property StartTime: TDateTime read Get_StartTime;
    property ElapsedDistance: Double read Get_ElapsedDistance;
    property Location: Location read Get_Location;
  end;

// *********************************************************************//
// DispIntf:  DirectionDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C49898CB-A475-4E87-9822-57FC1729C6D8}
// *********************************************************************//
  DirectionDisp = dispinterface
    ['{C49898CB-A475-4E87-9822-57FC1729C6D8}']
    property Application: _Application readonly dispid 100663313;
    property Parent: Directions readonly dispid -803;
    property Instruction: WideString readonly dispid 0;
    property Index: Integer readonly dispid 100663326;
    property Waypoint: Waypoint readonly dispid 100670215;
    property type_: GeoDirectionType readonly dispid 100665089;
    property Directions: Directions readonly dispid 100670210;
    property Toward: WideString readonly dispid 100670211;
    property Action: GeoDirectionAction readonly dispid 100670212;
    property Distance: Double readonly dispid 100665860;
    property StartTime: TDateTime readonly dispid 100670213;
    property ElapsedDistance: Double readonly dispid 100670214;
    function FindNearby(Distance: Double): FindResults; dispid 100794395;
    function DistanceTo(const From: Location): Double; dispid 100794397;
    property Location: Location readonly dispid 100663318;
    procedure Select; dispid 100794399;
  end;

// *********************************************************************//
// Interface: DriverProfile
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {7049C92B-C653-46D0-AADA-6C4B0CEC96D7}
// *********************************************************************//
  DriverProfile = interface(IDispatch)
    ['{7049C92B-C653-46D0-AADA-6C4B0CEC96D7}']
    function Get_Application: _Application; safecall;
    function Get_Parent: Route; safecall;
    function Get_StartTime: TDateTime; safecall;
    procedure Set_StartTime(pVal: TDateTime); safecall;
    function Get_EndTime: TDateTime; safecall;
    procedure Set_EndTime(pVal: TDateTime); safecall;
    function Get_TimeFlexibility: Double; safecall;
    procedure Set_TimeFlexibility(pVal: Double); safecall;
    function Get_ShowConstruction: WordBool; safecall;
    procedure Set_ShowConstruction(pVal: WordBool); safecall;
    function Get_FuelTankCapacity: Single; safecall;
    procedure Set_FuelTankCapacity(pVal: Single); safecall;
    function Get_FuelTankUnits: GeoVolumeUnits; safecall;
    procedure Set_FuelTankUnits(pVal: GeoVolumeUnits); safecall;
    function Get_DrivingCost: Currency; safecall;
    procedure Set_DrivingCost(pVal: Currency); safecall;
    function Get_DrivingCostUnits: GeoDrivingCostUnits; safecall;
    procedure Set_DrivingCostUnits(pVal: GeoDrivingCostUnits); safecall;
    function Get_IncludeRefuelWarnings: WordBool; safecall;
    procedure Set_IncludeRefuelWarnings(pVal: WordBool); safecall;
    function Get_FuelConsumptionUnits: GeoFuelConsumptionUnits; safecall;
    procedure Set_FuelConsumptionUnits(pVal: GeoFuelConsumptionUnits); safecall;
    function Get_TankStartLevel: Double; safecall;
    procedure Set_TankStartLevel(pVal: Double); safecall;
    function Get_TankWarnLevel: Double; safecall;
    procedure Set_TankWarnLevel(pVal: Double); safecall;
    function Get_FuelConsumptionCity: Double; safecall;
    procedure Set_FuelConsumptionCity(pVal: Double); safecall;
    function Get_FuelConsumptionHighway: Double; safecall;
    procedure Set_FuelConsumptionHighway(pVal: Double); safecall;
    function Get_IncludeRestStops: WordBool; safecall;
    procedure Set_IncludeRestStops(pVal: WordBool); safecall;
    function Get_TimeBetweenRests: Double; safecall;
    procedure Set_TimeBetweenRests(pVal: Double); safecall;
    function Get_RestStopDuration: Double; safecall;
    procedure Set_RestStopDuration(pVal: Double); safecall;
    procedure ResetSpeeds; safecall;
    procedure ResetPreferredRoads; safecall;
    function Get_Speed(RoadType: GeoRoadType): Integer; safecall;
    procedure Set_Speed(RoadType: GeoRoadType; p_pVal: Integer); safecall;
    function Get_PreferredRoads(RoadClass: GeoRoadType): Double; safecall;
    procedure Set_PreferredRoads(RoadClass: GeoRoadType; p_pVal: Double); safecall;
    property Application: _Application read Get_Application;
    property Parent: Route read Get_Parent;
    property StartTime: TDateTime read Get_StartTime write Set_StartTime;
    property EndTime: TDateTime read Get_EndTime write Set_EndTime;
    property TimeFlexibility: Double read Get_TimeFlexibility write Set_TimeFlexibility;
    property ShowConstruction: WordBool read Get_ShowConstruction write Set_ShowConstruction;
    property FuelTankCapacity: Single read Get_FuelTankCapacity write Set_FuelTankCapacity;
    property FuelTankUnits: GeoVolumeUnits read Get_FuelTankUnits write Set_FuelTankUnits;
    property DrivingCost: Currency read Get_DrivingCost write Set_DrivingCost;
    property DrivingCostUnits: GeoDrivingCostUnits read Get_DrivingCostUnits write Set_DrivingCostUnits;
    property IncludeRefuelWarnings: WordBool read Get_IncludeRefuelWarnings write Set_IncludeRefuelWarnings;
    property FuelConsumptionUnits: GeoFuelConsumptionUnits read Get_FuelConsumptionUnits write Set_FuelConsumptionUnits;
    property TankStartLevel: Double read Get_TankStartLevel write Set_TankStartLevel;
    property TankWarnLevel: Double read Get_TankWarnLevel write Set_TankWarnLevel;
    property FuelConsumptionCity: Double read Get_FuelConsumptionCity write Set_FuelConsumptionCity;
    property FuelConsumptionHighway: Double read Get_FuelConsumptionHighway write Set_FuelConsumptionHighway;
    property IncludeRestStops: WordBool read Get_IncludeRestStops write Set_IncludeRestStops;
    property TimeBetweenRests: Double read Get_TimeBetweenRests write Set_TimeBetweenRests;
    property RestStopDuration: Double read Get_RestStopDuration write Set_RestStopDuration;
    property Speed[RoadType: GeoRoadType]: Integer read Get_Speed write Set_Speed;
    property PreferredRoads[RoadClass: GeoRoadType]: Double read Get_PreferredRoads write Set_PreferredRoads;
  end;

// *********************************************************************//
// DispIntf:  DriverProfileDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {7049C92B-C653-46D0-AADA-6C4B0CEC96D7}
// *********************************************************************//
  DriverProfileDisp = dispinterface
    ['{7049C92B-C653-46D0-AADA-6C4B0CEC96D7}']
    property Application: _Application readonly dispid 100663313;
    property Parent: Route readonly dispid -803;
    property StartTime: TDateTime dispid 100670213;
    property EndTime: TDateTime dispid 100670978;
    property TimeFlexibility: Double dispid 100670979;
    property ShowConstruction: WordBool dispid 100670980;
    property FuelTankCapacity: Single dispid 100670981;
    property FuelTankUnits: GeoVolumeUnits dispid 100670982;
    property DrivingCost: Currency dispid 100670983;
    property DrivingCostUnits: GeoDrivingCostUnits dispid 100670984;
    property IncludeRefuelWarnings: WordBool dispid 100670985;
    property FuelConsumptionUnits: GeoFuelConsumptionUnits dispid 100670986;
    property TankStartLevel: Double dispid 100670987;
    property TankWarnLevel: Double dispid 100670988;
    property FuelConsumptionCity: Double dispid 100670989;
    property FuelConsumptionHighway: Double dispid 100670990;
    property IncludeRestStops: WordBool dispid 100670991;
    property TimeBetweenRests: Double dispid 100670992;
    property RestStopDuration: Double dispid 100670993;
    procedure ResetSpeeds; dispid 100802068;
    procedure ResetPreferredRoads; dispid 100802069;
    property Speed[RoadType: GeoRoadType]: Integer dispid 100670994;
    property PreferredRoads[RoadClass: GeoRoadType]: Double dispid 100670995;
  end;

// *********************************************************************//
// Interface: DataSets
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {CE5B074B-6D34-4DE1-9C7F-5562F33899BE}
// *********************************************************************//
  DataSets = interface(IDispatch)
    ['{CE5B074B-6D34-4DE1-9C7F-5562F33899BE}']
    function Get_Application: _Application; safecall;
    function Get_Parent: _Map; safecall;
    function Get_Count: Integer; safecall;
    function Get_Item(var Index: OleVariant): DataSet; safecall;
    function Get__NewEnum: IUnknown; safecall;
    function ShowImportWizard80(HWndParent: Integer): DataSet; safecall;
    function ShowLinkWizard80(HWndParent: Integer): DataSet; safecall;
    function ImportData(const DataSourceMoniker: WideString; ArrayOfFields: OleVariant; 
                        Country: GeoCountry; Delimiter: GeoDelimiter; ImportFlags: Integer): DataSet; safecall;
    function LinkData(const DataSourceMoniker: WideString; PrimaryKeyField: OleVariant; 
                      ArrayOfFields: OleVariant; Country: GeoCountry; Delimiter: GeoDelimiter; 
                      ImportFlags: Integer): DataSet; safecall;
    procedure ZoomTo; safecall;
    function GetDemographics(Country: GeoCountry): DataSet; safecall;
    function ShowImportWizard(HWndParent: Integer; const DataSourceMoniker: WideString; 
                              Delimiter: GeoDelimiter; ImportFlags: Integer): DataSet; safecall;
    function ShowImportTerritoriesWizard(HWndParent: Integer; const DataSourceMoniker: WideString; 
                                         Delimiter: GeoDelimiter; ImportFlags: Integer): DataSet; safecall;
    function ShowLinkWizard(HWndParent: Integer; const DataSourceMoniker: WideString; 
                            Delimiter: GeoDelimiter; ImportFlags: Integer): DataSet; safecall;
    function ShowLinkTerritoriesWizard(HWndParent: Integer; const DataSourceMoniker: WideString; 
                                       Delimiter: GeoDelimiter; ImportFlags: Integer): DataSet; safecall;
    function ShowDataMappingWizard(HWndParent: Integer; const DataSetToUse: DataSet; 
                                   StartPage: GeoDataMappingPage): DataMap; safecall;
    function ImportTerritories(const DataSourceMoniker: WideString; ArrayOfFields: OleVariant; 
                               Country: GeoCountry; Delimiter: GeoDelimiter; ImportFlags: Integer): DataSet; safecall;
    function LinkTerritories(const DataSourceMoniker: WideString; PrimaryKeyField: OleVariant; 
                             ArrayOfFields: OleVariant; Country: GeoCountry; 
                             Delimiter: GeoDelimiter; ImportFlags: Integer): DataSet; safecall;
    function AddPushpinSet(const Name: WideString): DataSet; safecall;
    property Application: _Application read Get_Application;
    property Parent: _Map read Get_Parent;
    property Count: Integer read Get_Count;
    property Item[var Index: OleVariant]: DataSet read Get_Item; default;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  DataSetsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {CE5B074B-6D34-4DE1-9C7F-5562F33899BE}
// *********************************************************************//
  DataSetsDisp = dispinterface
    ['{CE5B074B-6D34-4DE1-9C7F-5562F33899BE}']
    property Application: _Application readonly dispid 100663313;
    property Parent: _Map readonly dispid -803;
    property Count: Integer readonly dispid 100663321;
    property Item[var Index: OleVariant]: DataSet readonly dispid 0; default;
    property _NewEnum: IUnknown readonly dispid -4;
    function ShowImportWizard80(HWndParent: Integer): DataSet; dispid 100795137;
    function ShowLinkWizard80(HWndParent: Integer): DataSet; dispid 100795138;
    function ImportData(const DataSourceMoniker: WideString; ArrayOfFields: OleVariant; 
                        Country: GeoCountry; Delimiter: GeoDelimiter; ImportFlags: Integer): DataSet; dispid 100795139;
    function LinkData(const DataSourceMoniker: WideString; PrimaryKeyField: OleVariant; 
                      ArrayOfFields: OleVariant; Country: GeoCountry; Delimiter: GeoDelimiter; 
                      ImportFlags: Integer): DataSet; dispid 100795140;
    procedure ZoomTo; dispid 100795410;
    function GetDemographics(Country: GeoCountry): DataSet; dispid 100795141;
    function ShowImportWizard(HWndParent: Integer; const DataSourceMoniker: WideString; 
                              Delimiter: GeoDelimiter; ImportFlags: Integer): DataSet; dispid 100795142;
    function ShowImportTerritoriesWizard(HWndParent: Integer; const DataSourceMoniker: WideString; 
                                         Delimiter: GeoDelimiter; ImportFlags: Integer): DataSet; dispid 100795147;
    function ShowLinkWizard(HWndParent: Integer; const DataSourceMoniker: WideString; 
                            Delimiter: GeoDelimiter; ImportFlags: Integer): DataSet; dispid 100795143;
    function ShowLinkTerritoriesWizard(HWndParent: Integer; const DataSourceMoniker: WideString; 
                                       Delimiter: GeoDelimiter; ImportFlags: Integer): DataSet; dispid 100795148;
    function ShowDataMappingWizard(HWndParent: Integer; const DataSetToUse: DataSet; 
                                   StartPage: GeoDataMappingPage): DataMap; dispid 100795144;
    function ImportTerritories(const DataSourceMoniker: WideString; ArrayOfFields: OleVariant; 
                               Country: GeoCountry; Delimiter: GeoDelimiter; ImportFlags: Integer): DataSet; dispid 100795145;
    function LinkTerritories(const DataSourceMoniker: WideString; PrimaryKeyField: OleVariant; 
                             ArrayOfFields: OleVariant; Country: GeoCountry; 
                             Delimiter: GeoDelimiter; ImportFlags: Integer): DataSet; dispid 100795146;
    function AddPushpinSet(const Name: WideString): DataSet; dispid 100795149;
  end;

// *********************************************************************//
// Interface: DataSet
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9A3776C3-6F62-4DDA-81BB-4C92DA35A169}
// *********************************************************************//
  DataSet = interface(IDispatch)
    ['{9A3776C3-6F62-4DDA-81BB-4C92DA35A169}']
    function Get_Application: _Application; safecall;
    function Get_Parent: DataSets; safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const pVal: WideString); safecall;
    procedure Delete; safecall;
    function Get_IsLinked: WordBool; safecall;
    function Get_SourceFullName: WideString; safecall;
    function Get_Symbol: Smallint; safecall;
    procedure Set_Symbol(pVal: Smallint); safecall;
    function Get_RecordCount: Integer; safecall;
    function Get_MatchedRecordCount: Integer; safecall;
    function Get_UnmatchedRecordCount: Integer; safecall;
    function Get_SkippedRecordCount: Integer; safecall;
    function Get_Fields: Fields; safecall;
    function QueryAllRecords: Recordset; safecall;
    function QueryPolygon80(var ArrayOfLocations: PSafeArray): Recordset; safecall;
    function QueryCircle(const Center: Location; Radius: Double): Recordset; safecall;
    function Get_DataMapType: GeoDataMapType; safecall;
    function DisplayDataMap80(DataMapType: GeoDataMapType; const DataField: Field; 
                              ShowDataBy: GeoShowDataBy; CombineDataBy: GeoCombineDataBy; 
                              DataRangeType: GeoDataRangeType; DataRangeOrder: GeoDataRangeOrder; 
                              ColorScheme: Integer; DataRangeCount: Integer; 
                              ArrayOfCustomValues: OleVariant; ArrayOfCustomNames: OleVariant; 
                              DivideByField: OleVariant): DataMap; safecall;
    procedure DisplayPushpinMap; safecall;
    function Get_DataMap: DataMap; safecall;
    procedure UpdateLink; safecall;
    procedure ZoomTo; safecall;
    function QueryPolygon(ArrayOfLocations: OleVariant): Recordset; safecall;
    function QueryShape(const Shape: Shape): Recordset; safecall;
    function DisplayDataMap(DataMapType: GeoDataMapType; DataField: OleVariant; 
                            ShowDataBy: GeoShowDataBy; CombineDataBy: GeoCombineDataBy; 
                            DataRangeType: GeoDataRangeType; DataRangeOrder: GeoDataRangeOrder; 
                            ColorScheme: Integer; DataRangeCount: Integer; 
                            ArrayOfCustomValues: OleVariant; ArrayOfCustomNames: OleVariant; 
                            DivideByField: OleVariant; ArrayOfDataFieldLabels: OleVariant; 
                            ArrayOfPushpinSymbols: OleVariant): DataMap; safecall;
    procedure Select; safecall;
    procedure Copy; safecall;
    procedure Cut; safecall;
    function Get_HyperlinkType: GeoDataSetHyperlinkType; safecall;
    procedure Set_HyperlinkType(pVal: GeoDataSetHyperlinkType); safecall;
    function Get_HyperlinkCalculated: WideString; safecall;
    procedure Set_HyperlinkCalculated(const pVal: WideString); safecall;
    function Get_HyperlinkField: Field; safecall;
    procedure Set_HyperlinkField(const ppVal: Field); safecall;
    function Get_FieldNamesVisibleInBalloon: WordBool; safecall;
    procedure Set_FieldNamesVisibleInBalloon(pVal: WordBool); safecall;
    procedure SetFieldsVisibleInBalloon(ArrayOfFields: OleVariant); safecall;
    function Get_HowCreated: GeoDataSetHowCreated; safecall;
    function Get_MatchingMethod: GeoMatchingMethod; safecall;
    function Get_Country: GeoCountry; safecall;
    function Paste: WordBool; safecall;
    property Application: _Application read Get_Application;
    property Parent: DataSets read Get_Parent;
    property Name: WideString read Get_Name write Set_Name;
    property IsLinked: WordBool read Get_IsLinked;
    property SourceFullName: WideString read Get_SourceFullName;
    property Symbol: Smallint read Get_Symbol write Set_Symbol;
    property RecordCount: Integer read Get_RecordCount;
    property MatchedRecordCount: Integer read Get_MatchedRecordCount;
    property UnmatchedRecordCount: Integer read Get_UnmatchedRecordCount;
    property SkippedRecordCount: Integer read Get_SkippedRecordCount;
    property Fields: Fields read Get_Fields;
    property DataMapType: GeoDataMapType read Get_DataMapType;
    property DataMap: DataMap read Get_DataMap;
    property HyperlinkType: GeoDataSetHyperlinkType read Get_HyperlinkType write Set_HyperlinkType;
    property HyperlinkCalculated: WideString read Get_HyperlinkCalculated write Set_HyperlinkCalculated;
    property HyperlinkField: Field read Get_HyperlinkField write Set_HyperlinkField;
    property FieldNamesVisibleInBalloon: WordBool read Get_FieldNamesVisibleInBalloon write Set_FieldNamesVisibleInBalloon;
    property HowCreated: GeoDataSetHowCreated read Get_HowCreated;
    property MatchingMethod: GeoMatchingMethod read Get_MatchingMethod;
    property Country: GeoCountry read Get_Country;
  end;

// *********************************************************************//
// DispIntf:  DataSetDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9A3776C3-6F62-4DDA-81BB-4C92DA35A169}
// *********************************************************************//
  DataSetDisp = dispinterface
    ['{9A3776C3-6F62-4DDA-81BB-4C92DA35A169}']
    property Application: _Application readonly dispid 100663313;
    property Parent: DataSets readonly dispid -803;
    property Name: WideString dispid -800;
    procedure Delete; dispid -801;
    property IsLinked: WordBool readonly dispid 100664321;
    property SourceFullName: WideString readonly dispid 100664322;
    property Symbol: Smallint dispid 100663330;
    property RecordCount: Integer readonly dispid 100663331;
    property MatchedRecordCount: Integer readonly dispid 100664323;
    property UnmatchedRecordCount: Integer readonly dispid 100664324;
    property SkippedRecordCount: Integer readonly dispid 100664325;
    property Fields: Fields readonly dispid 100663329;
    function QueryAllRecords: Recordset; dispid 100795400;
    function QueryPolygon80(var ArrayOfLocations: {??PSafeArray}OleVariant): Recordset; dispid 100795401;
    function QueryCircle(const Center: Location; Radius: Double): Recordset; dispid 100795408;
    property DataMapType: GeoDataMapType readonly dispid 100664326;
    function DisplayDataMap80(DataMapType: GeoDataMapType; const DataField: Field; 
                              ShowDataBy: GeoShowDataBy; CombineDataBy: GeoCombineDataBy; 
                              DataRangeType: GeoDataRangeType; DataRangeOrder: GeoDataRangeOrder; 
                              ColorScheme: Integer; DataRangeCount: Integer; 
                              ArrayOfCustomValues: OleVariant; ArrayOfCustomNames: OleVariant; 
                              DivideByField: OleVariant): DataMap; dispid 100795411;
    procedure DisplayPushpinMap; dispid 100795412;
    property DataMap: DataMap readonly dispid 100664341;
    procedure UpdateLink; dispid 100795409;
    procedure ZoomTo; dispid 100795410;
    function QueryPolygon(ArrayOfLocations: OleVariant): Recordset; dispid 100795472;
    function QueryShape(const Shape: Shape): Recordset; dispid 100795473;
    function DisplayDataMap(DataMapType: GeoDataMapType; DataField: OleVariant; 
                            ShowDataBy: GeoShowDataBy; CombineDataBy: GeoCombineDataBy; 
                            DataRangeType: GeoDataRangeType; DataRangeOrder: GeoDataRangeOrder; 
                            ColorScheme: Integer; DataRangeCount: Integer; 
                            ArrayOfCustomValues: OleVariant; ArrayOfCustomNames: OleVariant; 
                            DivideByField: OleVariant; ArrayOfDataFieldLabels: OleVariant; 
                            ArrayOfPushpinSymbols: OleVariant): DataMap; dispid 100795474;
    procedure Select; dispid 100794399;
    procedure Copy; dispid 100794411;
    procedure Cut; dispid 100794410;
    property HyperlinkType: GeoDataSetHyperlinkType dispid 100664403;
    property HyperlinkCalculated: WideString dispid 100664404;
    property HyperlinkField: Field dispid 100664405;
    property FieldNamesVisibleInBalloon: WordBool dispid 100664406;
    procedure SetFieldsVisibleInBalloon(ArrayOfFields: OleVariant); dispid 100795479;
    property HowCreated: GeoDataSetHowCreated readonly dispid 100664408;
    property MatchingMethod: GeoMatchingMethod readonly dispid 100663341;
    property Country: GeoCountry readonly dispid 100664409;
    function Paste: WordBool; dispid 100794412;
  end;

// *********************************************************************//
// Interface: Fields
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F96-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  Fields = interface(IDispatch)
    ['{31851F96-AFE6-11D2-A3C9-00C04F72F340}']
    function Get_Application: _Application; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Count: Integer; safecall;
    function Get__NewEnum: IUnknown; safecall;
    function Get_Item(var Index: OleVariant): Field; safecall;
    property Application: _Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: Integer read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[var Index: OleVariant]: Field read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  FieldsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F96-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  FieldsDisp = dispinterface
    ['{31851F96-AFE6-11D2-A3C9-00C04F72F340}']
    property Application: _Application readonly dispid 100663313;
    property Parent: IDispatch readonly dispid -803;
    property Count: Integer readonly dispid 100663321;
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[var Index: OleVariant]: Field readonly dispid 0; default;
  end;

// *********************************************************************//
// Interface: Field
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0B91C4E8-6541-4C6E-A69E-AD8B65F9CBF3}
// *********************************************************************//
  Field = interface(IDispatch)
    ['{0B91C4E8-6541-4C6E-A69E-AD8B65F9CBF3}']
    function Get_Application: _Application; safecall;
    function Get_Parent: Fields; safecall;
    function Get_Name: WideString; safecall;
    function Get_Value: OleVariant; safecall;
    function Get_type_: DataTypeEnum; safecall;
    function Get_GeographicFieldType: GeoFieldType; safecall;
    function Get_IsPrimaryKey: WordBool; safecall;
    function Get_VisibleInBalloon: WordBool; safecall;
    property Application: _Application read Get_Application;
    property Parent: Fields read Get_Parent;
    property Name: WideString read Get_Name;
    property Value: OleVariant read Get_Value;
    property type_: DataTypeEnum read Get_type_;
    property GeographicFieldType: GeoFieldType read Get_GeographicFieldType;
    property IsPrimaryKey: WordBool read Get_IsPrimaryKey;
    property VisibleInBalloon: WordBool read Get_VisibleInBalloon;
  end;

// *********************************************************************//
// DispIntf:  FieldDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0B91C4E8-6541-4C6E-A69E-AD8B65F9CBF3}
// *********************************************************************//
  FieldDisp = dispinterface
    ['{0B91C4E8-6541-4C6E-A69E-AD8B65F9CBF3}']
    property Application: _Application readonly dispid 100663313;
    property Parent: Fields readonly dispid -803;
    property Name: WideString readonly dispid -800;
    property Value: OleVariant readonly dispid 0;
    property type_: DataTypeEnum readonly dispid 100665089;
    property GeographicFieldType: GeoFieldType readonly dispid 100665090;
    property IsPrimaryKey: WordBool readonly dispid 100665092;
    property VisibleInBalloon: WordBool readonly dispid 100665093;
  end;

// *********************************************************************//
// Interface: Recordset
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BF5745A2-65B9-464E-8BC6-24AD5B3953A5}
// *********************************************************************//
  Recordset = interface(IDispatch)
    ['{BF5745A2-65B9-464E-8BC6-24AD5B3953A5}']
    function Get_Application: _Application; safecall;
    function Get_Parent: DataSet; safecall;
    function Get_Pushpin: Pushpin; safecall;
    function Get_Location: Location; safecall;
    function Get_Fields: Fields; safecall;
    function Get_BOF: WordBool; safecall;
    function Get_EOF: WordBool; safecall;
    procedure MoveFirst; safecall;
    procedure MoveNext; safecall;
    procedure MoveToPushpin(const Pushpin: Pushpin); safecall;
    function Get_IsMatched: WordBool; safecall;
    procedure MatchRecord(ShowDialogIfAmbiguous: WordBool; HWndParent: Integer); safecall;
    function Get_MatchingMethod: GeoMatchingMethod; safecall;
    function CallMatchMethod(const MethodName: WideString; const MethodObject: IDispatch): WordBool; safecall;
    property Application: _Application read Get_Application;
    property Parent: DataSet read Get_Parent;
    property Pushpin: Pushpin read Get_Pushpin;
    property Location: Location read Get_Location;
    property Fields: Fields read Get_Fields;
    property BOF: WordBool read Get_BOF;
    property EOF: WordBool read Get_EOF;
    property IsMatched: WordBool read Get_IsMatched;
    property MatchingMethod: GeoMatchingMethod read Get_MatchingMethod;
  end;

// *********************************************************************//
// DispIntf:  RecordsetDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BF5745A2-65B9-464E-8BC6-24AD5B3953A5}
// *********************************************************************//
  RecordsetDisp = dispinterface
    ['{BF5745A2-65B9-464E-8BC6-24AD5B3953A5}']
    property Application: _Application readonly dispid 100663313;
    property Parent: DataSet readonly dispid -803;
    property Pushpin: Pushpin readonly dispid 100664577;
    property Location: Location readonly dispid 100663318;
    property Fields: Fields readonly dispid 100663329;
    property BOF: WordBool readonly dispid 100664578;
    property EOF: WordBool readonly dispid 100664579;
    procedure MoveFirst; dispid 100795653;
    procedure MoveNext; dispid 100795654;
    procedure MoveToPushpin(const Pushpin: Pushpin); dispid 100795655;
    property IsMatched: WordBool readonly dispid 100664580;
    procedure MatchRecord(ShowDialogIfAmbiguous: WordBool; HWndParent: Integer); dispid 100795399;
    property MatchingMethod: GeoMatchingMethod readonly dispid 100663341;
    function CallMatchMethod(const MethodName: WideString; const MethodObject: IDispatch): WordBool; dispid 100795656;
  end;

// *********************************************************************//
// Interface: Pushpin
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {34B0F619-37E1-4C76-A6DA-69BF75A5D3DE}
// *********************************************************************//
  Pushpin = interface(IDispatch)
    ['{34B0F619-37E1-4C76-A6DA-69BF75A5D3DE}']
    function Get_Application: _Application; safecall;
    function Get_Parent: DataSet; safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const pVal: WideString); safecall;
    procedure Delete; safecall;
    function Get_Location: Location; safecall;
    procedure _Set_Location(const ppVal: Location); safecall;
    function Get_Note: WideString; safecall;
    procedure Set_Note(const pVal: WideString); safecall;
    function Get_Highlight: WordBool; safecall;
    procedure Set_Highlight(pVal: WordBool); safecall;
    function Get_Symbol: Smallint; safecall;
    procedure Set_Symbol(pVal: Smallint); safecall;
    function Get_BalloonState: GeoBalloonState; safecall;
    procedure Set_BalloonState(pVal: GeoBalloonState); safecall;
    procedure GoTo_; safecall;
    procedure Select; safecall;
    procedure Copy; safecall;
    procedure Cut; safecall;
    function Get_Hyperlink: Hyperlink; safecall;
    function MoveTo(const NewDataSet: DataSet): WordBool; safecall;
    property Application: _Application read Get_Application;
    property Parent: DataSet read Get_Parent;
    property Name: WideString read Get_Name write Set_Name;
    property Location: Location read Get_Location write _Set_Location;
    property Note: WideString read Get_Note write Set_Note;
    property Highlight: WordBool read Get_Highlight write Set_Highlight;
    property Symbol: Smallint read Get_Symbol write Set_Symbol;
    property BalloonState: GeoBalloonState read Get_BalloonState write Set_BalloonState;
    property Hyperlink: Hyperlink read Get_Hyperlink;
  end;

// *********************************************************************//
// DispIntf:  PushpinDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {34B0F619-37E1-4C76-A6DA-69BF75A5D3DE}
// *********************************************************************//
  PushpinDisp = dispinterface
    ['{34B0F619-37E1-4C76-A6DA-69BF75A5D3DE}']
    property Application: _Application readonly dispid 100663313;
    property Parent: DataSet readonly dispid -803;
    property Name: WideString dispid -800;
    procedure Delete; dispid -801;
    property Location: Location dispid 100663318;
    property Note: WideString dispid 100665346;
    property Highlight: WordBool dispid 100665345;
    property Symbol: Smallint dispid 100663330;
    property BalloonState: GeoBalloonState dispid 100665347;
    procedure GoTo_; dispid 100794392;
    procedure Select; dispid 100794399;
    procedure Copy; dispid 100794411;
    procedure Cut; dispid 100794410;
    property Hyperlink: Hyperlink readonly dispid 100665348;
    function MoveTo(const NewDataSet: DataSet): WordBool; dispid 100796421;
  end;

// *********************************************************************//
// Interface: Hyperlink
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2DB7D89E-D474-49C9-9D1D-3C18EDC05D3C}
// *********************************************************************//
  Hyperlink = interface(IDispatch)
    ['{2DB7D89E-D474-49C9-9D1D-3C18EDC05D3C}']
    function Get_Application: _Application; safecall;
    function Get_Parent: Pushpin; safecall;
    function Get_Address: WideString; safecall;
    function Get_ScreenTip: WideString; safecall;
    function Get_Subaddress: WideString; safecall;
    function Get_TextToDisplay: WideString; safecall;
    procedure Follow; safecall;
    property Application: _Application read Get_Application;
    property Parent: Pushpin read Get_Parent;
    property Address: WideString read Get_Address;
    property ScreenTip: WideString read Get_ScreenTip;
    property Subaddress: WideString read Get_Subaddress;
    property TextToDisplay: WideString read Get_TextToDisplay;
  end;

// *********************************************************************//
// DispIntf:  HyperlinkDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2DB7D89E-D474-49C9-9D1D-3C18EDC05D3C}
// *********************************************************************//
  HyperlinkDisp = dispinterface
    ['{2DB7D89E-D474-49C9-9D1D-3C18EDC05D3C}']
    property Application: _Application readonly dispid 100663313;
    property Parent: Pushpin readonly dispid 100663314;
    property Address: WideString readonly dispid 100671745;
    property ScreenTip: WideString readonly dispid 100671746;
    property Subaddress: WideString readonly dispid 100671747;
    property TextToDisplay: WideString readonly dispid 100671748;
    procedure Follow; dispid 100802821;
  end;

// *********************************************************************//
// Interface: DataMap
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3F469C6D-AC65-4864-9BDE-CB38CD44362C}
// *********************************************************************//
  DataMap = interface(IDispatch)
    ['{3F469C6D-AC65-4864-9BDE-CB38CD44362C}']
    function Get_Application: _Application; safecall;
    function Get_Parent: DataSet; safecall;
    function Get_RecordCount: Integer; safecall;
    function Get_LegendTitle: WideString; safecall;
    procedure Set_LegendTitle(const pVal: WideString); safecall;
    function Get_DataField: Field; safecall;
    function Get_ShowDataBy: GeoShowDataBy; safecall;
    function Get_CombineDataBy: GeoCombineDataBy; safecall;
    function Get_DataRanges: DataRanges; safecall;
    function Get_DivideByField: Field; safecall;
    function Get_IsGeographyForEveryZoomLevel: WordBool; safecall;
    function Get_DataFields: OleVariant; safecall;
    function Get_DataFieldLabels: OleVariant; safecall;
    property Application: _Application read Get_Application;
    property Parent: DataSet read Get_Parent;
    property RecordCount: Integer read Get_RecordCount;
    property LegendTitle: WideString read Get_LegendTitle write Set_LegendTitle;
    property DataField: Field read Get_DataField;
    property ShowDataBy: GeoShowDataBy read Get_ShowDataBy;
    property CombineDataBy: GeoCombineDataBy read Get_CombineDataBy;
    property DataRanges: DataRanges read Get_DataRanges;
    property DivideByField: Field read Get_DivideByField;
    property IsGeographyForEveryZoomLevel: WordBool read Get_IsGeographyForEveryZoomLevel;
    property DataFields: OleVariant read Get_DataFields;
    property DataFieldLabels: OleVariant read Get_DataFieldLabels;
  end;

// *********************************************************************//
// DispIntf:  DataMapDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3F469C6D-AC65-4864-9BDE-CB38CD44362C}
// *********************************************************************//
  DataMapDisp = dispinterface
    ['{3F469C6D-AC65-4864-9BDE-CB38CD44362C}']
    property Application: _Application readonly dispid 100663313;
    property Parent: DataSet readonly dispid -803;
    property RecordCount: Integer readonly dispid 100663331;
    property LegendTitle: WideString dispid 100666625;
    property DataField: Field readonly dispid 100666626;
    property ShowDataBy: GeoShowDataBy readonly dispid 100666627;
    property CombineDataBy: GeoCombineDataBy readonly dispid 100666628;
    property DataRanges: DataRanges readonly dispid 100666629;
    property DivideByField: Field readonly dispid 100666630;
    property IsGeographyForEveryZoomLevel: WordBool readonly dispid 100666631;
    property DataFields: OleVariant readonly dispid 100666632;
    property DataFieldLabels: OleVariant readonly dispid 100666633;
  end;

// *********************************************************************//
// Interface: DataRanges
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F99-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  DataRanges = interface(IDispatch)
    ['{31851F99-AFE6-11D2-A3C9-00C04F72F340}']
    function Get_Application: _Application; safecall;
    function Get_Parent: DataMap; safecall;
    function Get_Count: Integer; safecall;
    function Get_Item(var Index: OleVariant): DataRange; safecall;
    function Get__NewEnum: IUnknown; safecall;
    function Get_DataRangeType: GeoDataRangeType; safecall;
    function Get_DataRangeOrder: GeoDataRangeOrder; safecall;
    function Get_ColorScheme: Integer; safecall;
    function Get_IsCustomized: WordBool; safecall;
    property Application: _Application read Get_Application;
    property Parent: DataMap read Get_Parent;
    property Count: Integer read Get_Count;
    property Item[var Index: OleVariant]: DataRange read Get_Item; default;
    property _NewEnum: IUnknown read Get__NewEnum;
    property DataRangeType: GeoDataRangeType read Get_DataRangeType;
    property DataRangeOrder: GeoDataRangeOrder read Get_DataRangeOrder;
    property ColorScheme: Integer read Get_ColorScheme;
    property IsCustomized: WordBool read Get_IsCustomized;
  end;

// *********************************************************************//
// DispIntf:  DataRangesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F99-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  DataRangesDisp = dispinterface
    ['{31851F99-AFE6-11D2-A3C9-00C04F72F340}']
    property Application: _Application readonly dispid 100663313;
    property Parent: DataMap readonly dispid -803;
    property Count: Integer readonly dispid 100663321;
    property Item[var Index: OleVariant]: DataRange readonly dispid 0; default;
    property _NewEnum: IUnknown readonly dispid -4;
    property DataRangeType: GeoDataRangeType readonly dispid 100667137;
    property DataRangeOrder: GeoDataRangeOrder readonly dispid 100667138;
    property ColorScheme: Integer readonly dispid 100667139;
    property IsCustomized: WordBool readonly dispid 100667140;
  end;

// *********************************************************************//
// Interface: DataRange
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C383611E-1319-4019-895D-F0AE3FCA67FA}
// *********************************************************************//
  DataRange = interface(IDispatch)
    ['{C383611E-1319-4019-895D-F0AE3FCA67FA}']
    function Get_Application: _Application; safecall;
    function Get_Parent: DataRanges; safecall;
    function Get_Name: WideString; safecall;
    function Get_LowValue: OleVariant; safecall;
    function Get_HighValue: OleVariant; safecall;
    function Get_RecordCount: Integer; safecall;
    function Get_ValueCount: Integer; safecall;
    function Get_Symbol: Smallint; safecall;
    property Application: _Application read Get_Application;
    property Parent: DataRanges read Get_Parent;
    property Name: WideString read Get_Name;
    property LowValue: OleVariant read Get_LowValue;
    property HighValue: OleVariant read Get_HighValue;
    property RecordCount: Integer read Get_RecordCount;
    property ValueCount: Integer read Get_ValueCount;
    property Symbol: Smallint read Get_Symbol;
  end;

// *********************************************************************//
// DispIntf:  DataRangeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C383611E-1319-4019-895D-F0AE3FCA67FA}
// *********************************************************************//
  DataRangeDisp = dispinterface
    ['{C383611E-1319-4019-895D-F0AE3FCA67FA}']
    property Application: _Application readonly dispid 100663313;
    property Parent: DataRanges readonly dispid -803;
    property Name: WideString readonly dispid -800;
    property LowValue: OleVariant readonly dispid 100666881;
    property HighValue: OleVariant readonly dispid 100666882;
    property RecordCount: Integer readonly dispid 100663331;
    property ValueCount: Integer readonly dispid 100666883;
    property Symbol: Smallint readonly dispid 100663330;
  end;

// *********************************************************************//
// Interface: Shape
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {EF3817E9-A8F6-4EA6-8CFD-3F2D97A35644}
// *********************************************************************//
  Shape = interface(IDispatch)
    ['{EF3817E9-A8F6-4EA6-8CFD-3F2D97A35644}']
    function Get_Application: _Application; safecall;
    function Get_Parent: Shapes; safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const pVal: WideString); safecall;
    procedure Delete; safecall;
    function Get_Location: Location; safecall;
    procedure _Set_Location(const ppVal: Location); safecall;
    function Get_Vertices: OleVariant; safecall;
    procedure Set_Vertices(pVal: OleVariant); safecall;
    function Get_Adjustments: Adjustments; safecall;
    function Get_Height: Double; safecall;
    procedure Set_Height(pVal: Double); safecall;
    function Get_Width: Double; safecall;
    procedure Set_Width(pVal: Double); safecall;
    procedure ZOrder(ZOrderCmd: GeoZOrderCmd); safecall;
    function Get_ZOrderPosition: Integer; safecall;
    procedure Set_ZOrderPosition(pVal: Integer); safecall;
    function Get_Line: LineFormat; safecall;
    function Get_Fill: FillFormat; safecall;
    function Get_type_: GeoShapeType; safecall;
    function Get_AutoShapeType: GeoAutoShapeType; safecall;
    function Get_SizeVisible: WordBool; safecall;
    procedure Set_SizeVisible(pVal: WordBool); safecall;
    function Get_Text: WideString; safecall;
    procedure Set_Text(const pVal: WideString); safecall;
    function Get_FontColor: GeoRGBType; safecall;
    procedure Set_FontColor(pVal: GeoRGBType); safecall;
    function Get_Avoided: WordBool; safecall;
    procedure Set_Avoided(pVal: WordBool); safecall;
    procedure Select; safecall;
    procedure Copy; safecall;
    procedure Cut; safecall;
    property Application: _Application read Get_Application;
    property Parent: Shapes read Get_Parent;
    property Name: WideString read Get_Name write Set_Name;
    property Location: Location read Get_Location write _Set_Location;
    property Vertices: OleVariant read Get_Vertices write Set_Vertices;
    property Adjustments: Adjustments read Get_Adjustments;
    property Height: Double read Get_Height write Set_Height;
    property Width: Double read Get_Width write Set_Width;
    property ZOrderPosition: Integer read Get_ZOrderPosition write Set_ZOrderPosition;
    property Line: LineFormat read Get_Line;
    property Fill: FillFormat read Get_Fill;
    property type_: GeoShapeType read Get_type_;
    property AutoShapeType: GeoAutoShapeType read Get_AutoShapeType;
    property SizeVisible: WordBool read Get_SizeVisible write Set_SizeVisible;
    property Text: WideString read Get_Text write Set_Text;
    property FontColor: GeoRGBType read Get_FontColor write Set_FontColor;
    property Avoided: WordBool read Get_Avoided write Set_Avoided;
  end;

// *********************************************************************//
// DispIntf:  ShapeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {EF3817E9-A8F6-4EA6-8CFD-3F2D97A35644}
// *********************************************************************//
  ShapeDisp = dispinterface
    ['{EF3817E9-A8F6-4EA6-8CFD-3F2D97A35644}']
    property Application: _Application readonly dispid 100663313;
    property Parent: Shapes readonly dispid -803;
    property Name: WideString dispid -800;
    procedure Delete; dispid -801;
    property Location: Location dispid 100663318;
    property Vertices: OleVariant dispid 100667909;
    property Adjustments: Adjustments readonly dispid 100667910;
    property Height: Double dispid 100663570;
    property Width: Double dispid 100663572;
    procedure ZOrder(ZOrderCmd: GeoZOrderCmd); dispid 100798977;
    property ZOrderPosition: Integer dispid 100667906;
    property Line: LineFormat readonly dispid 100667907;
    property Fill: FillFormat readonly dispid 100667908;
    property type_: GeoShapeType readonly dispid 100665089;
    property AutoShapeType: GeoAutoShapeType readonly dispid 100667911;
    property SizeVisible: WordBool dispid 100667912;
    property Text: WideString dispid 100667914;
    property FontColor: GeoRGBType dispid 100667913;
    property Avoided: WordBool dispid 100667915;
    procedure Select; dispid 100794399;
    procedure Copy; dispid 100794411;
    procedure Cut; dispid 100794410;
  end;

// *********************************************************************//
// Interface: Shapes
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {FD1FC959-8A2F-43A6-9F5A-FE68B9E78F4D}
// *********************************************************************//
  Shapes = interface(IDispatch)
    ['{FD1FC959-8A2F-43A6-9F5A-FE68B9E78F4D}']
    function Get_Application: _Application; safecall;
    function Get_Parent: _Map; safecall;
    function Get_Count: Integer; safecall;
    function Get__NewEnum: IUnknown; safecall;
    function Get_Item(var Index: OleVariant): Shape; safecall;
    function AddLine(const BeginLocation: Location; const EndLocation: Location): Shape; safecall;
    function AddPolyline(ArrayOfLocations: OleVariant): Shape; safecall;
    function AddShape(Type_: GeoAutoShapeType; const Center: Location; Width: Double; Height: Double): Shape; safecall;
    function AddDrivetimeZone(const Center: Location; Time: Double): Shape; safecall;
    function AddTextbox(const Center: Location; Width: Double; Height: Double): Shape; safecall;
    property Application: _Application read Get_Application;
    property Parent: _Map read Get_Parent;
    property Count: Integer read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[var Index: OleVariant]: Shape read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  ShapesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {FD1FC959-8A2F-43A6-9F5A-FE68B9E78F4D}
// *********************************************************************//
  ShapesDisp = dispinterface
    ['{FD1FC959-8A2F-43A6-9F5A-FE68B9E78F4D}']
    property Application: _Application readonly dispid 100663313;
    property Parent: _Map readonly dispid -803;
    property Count: Integer readonly dispid 100663321;
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[var Index: OleVariant]: Shape readonly dispid 0; default;
    function AddLine(const BeginLocation: Location; const EndLocation: Location): Shape; dispid 100798721;
    function AddPolyline(ArrayOfLocations: OleVariant): Shape; dispid 100798722;
    function AddShape(Type_: GeoAutoShapeType; const Center: Location; Width: Double; Height: Double): Shape; dispid 100798723;
    function AddDrivetimeZone(const Center: Location; Time: Double): Shape; dispid 100798724;
    function AddTextbox(const Center: Location; Width: Double; Height: Double): Shape; dispid 100798725;
  end;

// *********************************************************************//
// Interface: Adjustments
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {E23B1D46-B358-4F18-A396-153CE0E3F26E}
// *********************************************************************//
  Adjustments = interface(IDispatch)
    ['{E23B1D46-B358-4F18-A396-153CE0E3F26E}']
    function Get_Application: _Application; safecall;
    function Get_Parent: Shape; safecall;
    function Get_Count: Integer; safecall;
    function Get_Item(var Index: OleVariant): Double; safecall;
    procedure Set_Item(var Index: OleVariant; pVal: Double); safecall;
    property Application: _Application read Get_Application;
    property Parent: Shape read Get_Parent;
    property Count: Integer read Get_Count;
    property Item[var Index: OleVariant]: Double read Get_Item write Set_Item; default;
  end;

// *********************************************************************//
// DispIntf:  AdjustmentsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {E23B1D46-B358-4F18-A396-153CE0E3F26E}
// *********************************************************************//
  AdjustmentsDisp = dispinterface
    ['{E23B1D46-B358-4F18-A396-153CE0E3F26E}']
    property Application: _Application readonly dispid 100663313;
    property Parent: Shape readonly dispid -803;
    property Count: Integer readonly dispid 100663321;
    property Item[var Index: OleVariant]: Double dispid 0; default;
  end;

// *********************************************************************//
// Interface: LineFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3A43DDF9-4E58-49E5-9779-8C97052DEA73}
// *********************************************************************//
  LineFormat = interface(IDispatch)
    ['{3A43DDF9-4E58-49E5-9779-8C97052DEA73}']
    function Get_Application: _Application; safecall;
    function Get_Parent: Shape; safecall;
    function Get_ForeColor: GeoRGBType; safecall;
    procedure Set_ForeColor(pVal: GeoRGBType); safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(pVal: WordBool); safecall;
    function Get_Weight: Integer; safecall;
    procedure Set_Weight(pVal: Integer); safecall;
    function Get_BeginArrowhead: WordBool; safecall;
    procedure Set_BeginArrowhead(pVal: WordBool); safecall;
    function Get_EndArrowhead: WordBool; safecall;
    procedure Set_EndArrowhead(pVal: WordBool); safecall;
    property Application: _Application read Get_Application;
    property Parent: Shape read Get_Parent;
    property ForeColor: GeoRGBType read Get_ForeColor write Set_ForeColor;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property Weight: Integer read Get_Weight write Set_Weight;
    property BeginArrowhead: WordBool read Get_BeginArrowhead write Set_BeginArrowhead;
    property EndArrowhead: WordBool read Get_EndArrowhead write Set_EndArrowhead;
  end;

// *********************************************************************//
// DispIntf:  LineFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3A43DDF9-4E58-49E5-9779-8C97052DEA73}
// *********************************************************************//
  LineFormatDisp = dispinterface
    ['{3A43DDF9-4E58-49E5-9779-8C97052DEA73}']
    property Application: _Application readonly dispid 100663313;
    property Parent: Shape readonly dispid -803;
    property ForeColor: GeoRGBType dispid 100663322;
    property Visible: WordBool dispid 100663574;
    property Weight: Integer dispid 100668163;
    property BeginArrowhead: WordBool dispid 100668161;
    property EndArrowhead: WordBool dispid 100668162;
  end;

// *********************************************************************//
// Interface: FillFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {85A310EA-F134-47D7-B186-4C10314A626F}
// *********************************************************************//
  FillFormat = interface(IDispatch)
    ['{85A310EA-F134-47D7-B186-4C10314A626F}']
    function Get_Application: _Application; safecall;
    function Get_Parent: Shape; safecall;
    function Get_ForeColor: GeoRGBType; safecall;
    procedure Set_ForeColor(pclrForeground: GeoRGBType); safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(pVal: WordBool); safecall;
    property Application: _Application read Get_Application;
    property Parent: Shape read Get_Parent;
    property ForeColor: GeoRGBType read Get_ForeColor write Set_ForeColor;
    property Visible: WordBool read Get_Visible write Set_Visible;
  end;

// *********************************************************************//
// DispIntf:  FillFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {85A310EA-F134-47D7-B186-4C10314A626F}
// *********************************************************************//
  FillFormatDisp = dispinterface
    ['{85A310EA-F134-47D7-B186-4C10314A626F}']
    property Application: _Application readonly dispid 100663313;
    property Parent: Shape readonly dispid -803;
    property ForeColor: GeoRGBType dispid 100663322;
    property Visible: WordBool dispid 100663574;
  end;

// *********************************************************************//
// Interface: SelectedArea
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {B87D4AE6-A827-488F-A40F-8A399F316D3A}
// *********************************************************************//
  SelectedArea = interface(IDispatch)
    ['{B87D4AE6-A827-488F-A40F-8A399F316D3A}']
    function Get_Application: _Application; safecall;
    function Get_Parent: _Map; safecall;
    function Get_Top: Integer; safecall;
    function Get_Left: Integer; safecall;
    function Get_Width: Integer; safecall;
    function Get_Height: Integer; safecall;
    function Get_Location: Location; safecall;
    procedure Copy; safecall;
    procedure SelectArea(Top: Integer; Left: Integer; Width: Integer; Height: Integer); safecall;
    property Application: _Application read Get_Application;
    property Parent: _Map read Get_Parent;
    property Top: Integer read Get_Top;
    property Left: Integer read Get_Left;
    property Width: Integer read Get_Width;
    property Height: Integer read Get_Height;
    property Location: Location read Get_Location;
  end;

// *********************************************************************//
// DispIntf:  SelectedAreaDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {B87D4AE6-A827-488F-A40F-8A399F316D3A}
// *********************************************************************//
  SelectedAreaDisp = dispinterface
    ['{B87D4AE6-A827-488F-A40F-8A399F316D3A}']
    property Application: _Application readonly dispid 100663313;
    property Parent: _Map readonly dispid -803;
    property Top: Integer readonly dispid 100663573;
    property Left: Integer readonly dispid 100663571;
    property Width: Integer readonly dispid 100663572;
    property Height: Integer readonly dispid 100663570;
    property Location: Location readonly dispid 100663318;
    procedure Copy; dispid 100794411;
    procedure SelectArea(Top: Integer; Left: Integer; Width: Integer; Height: Integer); dispid 100794908;
  end;

// *********************************************************************//
// Interface: PageSetup
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8AA806BB-4F9F-44FF-A139-B766361403BA}
// *********************************************************************//
  PageSetup = interface(IDispatch)
    ['{8AA806BB-4F9F-44FF-A139-B766361403BA}']
    function Get_Application: _Application; safecall;
    function Get_Parent: _Map; safecall;
    function Get_PaperSize: GeoPaperSize; safecall;
    procedure Set_PaperSize(pVal: GeoPaperSize); safecall;
    function Get_RightMargin: Double; safecall;
    procedure Set_RightMargin(pVal: Double); safecall;
    function Get_LeftMargin: Double; safecall;
    procedure Set_LeftMargin(pVal: Double); safecall;
    function Get_TopMargin: Double; safecall;
    procedure Set_TopMargin(pVal: Double); safecall;
    function Get_BottomMargin: Double; safecall;
    procedure Set_BottomMargin(pVal: Double); safecall;
    function Get_IncludeRouteSummary: WordBool; safecall;
    procedure Set_IncludeRouteSummary(pVal: WordBool); safecall;
    function Get_RoutePageBreakFrequency: GeoPageBreakFrequency; safecall;
    procedure Set_RoutePageBreakFrequency(pVal: GeoPageBreakFrequency); safecall;
    function Get_RoutePageBreakDistance: Double; safecall;
    procedure Set_RoutePageBreakDistance(pVal: Double); safecall;
    function Get_RoutePageBreakTime: Double; safecall;
    procedure Set_RoutePageBreakTime(pVal: Double); safecall;
    property Application: _Application read Get_Application;
    property Parent: _Map read Get_Parent;
    property PaperSize: GeoPaperSize read Get_PaperSize write Set_PaperSize;
    property RightMargin: Double read Get_RightMargin write Set_RightMargin;
    property LeftMargin: Double read Get_LeftMargin write Set_LeftMargin;
    property TopMargin: Double read Get_TopMargin write Set_TopMargin;
    property BottomMargin: Double read Get_BottomMargin write Set_BottomMargin;
    property IncludeRouteSummary: WordBool read Get_IncludeRouteSummary write Set_IncludeRouteSummary;
    property RoutePageBreakFrequency: GeoPageBreakFrequency read Get_RoutePageBreakFrequency write Set_RoutePageBreakFrequency;
    property RoutePageBreakDistance: Double read Get_RoutePageBreakDistance write Set_RoutePageBreakDistance;
    property RoutePageBreakTime: Double read Get_RoutePageBreakTime write Set_RoutePageBreakTime;
  end;

// *********************************************************************//
// DispIntf:  PageSetupDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8AA806BB-4F9F-44FF-A139-B766361403BA}
// *********************************************************************//
  PageSetupDisp = dispinterface
    ['{8AA806BB-4F9F-44FF-A139-B766361403BA}']
    property Application: _Application readonly dispid 100663313;
    property Parent: _Map readonly dispid -803;
    property PaperSize: GeoPaperSize dispid 100671489;
    property RightMargin: Double dispid 100671491;
    property LeftMargin: Double dispid 100671492;
    property TopMargin: Double dispid 100671493;
    property BottomMargin: Double dispid 100671494;
    property IncludeRouteSummary: WordBool dispid 100671496;
    property RoutePageBreakFrequency: GeoPageBreakFrequency dispid 100671497;
    property RoutePageBreakDistance: Double dispid 100671498;
    property RoutePageBreakTime: Double dispid 100671499;
  end;

// *********************************************************************//
// Interface: SavedWebPages
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C08F15C8-F3FD-45AF-AEA4-1019983CCF42}
// *********************************************************************//
  SavedWebPages = interface(IDispatch)
    ['{C08F15C8-F3FD-45AF-AEA4-1019983CCF42}']
    function Get_Application: _Application; safecall;
    function Get_Parent: _Map; safecall;
    function Get_Count: Integer; safecall;
    function Get_Item(var Index: OleVariant): SavedWebPage; safecall;
    procedure Save; safecall;
    procedure Delete; safecall;
    function Add(const FileName: WideString; const Location: Location; const Title: WideString; 
                 IncludeMap: WordBool; IncludeThumbnail: WordBool; IncludeHyperlinks: WordBool; 
                 Width: Integer; Height: Integer; IncludeDirections: WordBool; 
                 IncludeLegend: WordBool; IncludeOverview: WordBool; IncludeSourceFile: WordBool): SavedWebPage; safecall;
    function Get__NewEnum: IUnknown; safecall;
    property Application: _Application read Get_Application;
    property Parent: _Map read Get_Parent;
    property Count: Integer read Get_Count;
    property Item[var Index: OleVariant]: SavedWebPage read Get_Item; default;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  SavedWebPagesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C08F15C8-F3FD-45AF-AEA4-1019983CCF42}
// *********************************************************************//
  SavedWebPagesDisp = dispinterface
    ['{C08F15C8-F3FD-45AF-AEA4-1019983CCF42}']
    property Application: _Application readonly dispid 100663313;
    property Parent: _Map readonly dispid -803;
    property Count: Integer readonly dispid 100663321;
    property Item[var Index: OleVariant]: SavedWebPage readonly dispid 0; default;
    procedure Save; dispid 100794889;
    procedure Delete; dispid 100794391;
    function Add(const FileName: WideString; const Location: Location; const Title: WideString; 
                 IncludeMap: WordBool; IncludeThumbnail: WordBool; IncludeHyperlinks: WordBool; 
                 Width: Integer; Height: Integer; IncludeDirections: WordBool; 
                 IncludeLegend: WordBool; IncludeOverview: WordBool; IncludeSourceFile: WordBool): SavedWebPage; dispid 100794404;
    property _NewEnum: IUnknown readonly dispid -4;
  end;

// *********************************************************************//
// Interface: SavedWebPage
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C674DC89-7FCA-4AB0-8906-950C32520F6B}
// *********************************************************************//
  SavedWebPage = interface(IDispatch)
    ['{C674DC89-7FCA-4AB0-8906-950C32520F6B}']
    function Get_Application: _Application; safecall;
    function Get_Parent: SavedWebPages; safecall;
    function Get_FileName: WideString; safecall;
    procedure Set_FileName(const pVal: WideString); safecall;
    function Get_Location: Location; safecall;
    procedure Set_Location(const ppVal: Location); safecall;
    function Get_IncludeMap: WordBool; safecall;
    procedure Set_IncludeMap(pVal: WordBool); safecall;
    function Get_IncludeDirections: WordBool; safecall;
    procedure Set_IncludeDirections(pVal: WordBool); safecall;
    function Get_IncludeLegend: WordBool; safecall;
    procedure Set_IncludeLegend(pVal: WordBool); safecall;
    function Get_IncludeOverview: WordBool; safecall;
    procedure Set_IncludeOverview(pVal: WordBool); safecall;
    function Get_IncludeHyperlinks: WordBool; safecall;
    procedure Set_IncludeHyperlinks(pVal: WordBool); safecall;
    function Get_IncludeThumbnail: WordBool; safecall;
    procedure Set_IncludeThumbnail(pVal: WordBool); safecall;
    function Get_Title: WideString; safecall;
    procedure Set_Title(const pVal: WideString); safecall;
    function Get_IncludeSourceFile: WordBool; safecall;
    procedure Set_IncludeSourceFile(pVal: WordBool); safecall;
    function Get_Width: Integer; safecall;
    procedure Set_Width(pVal: Integer); safecall;
    function Get_Height: Integer; safecall;
    procedure Set_Height(pVal: Integer); safecall;
    procedure Delete; safecall;
    procedure Set_AutoResave(pVal: WordBool); safecall;
    function Get_AutoResave: WordBool; safecall;
    procedure Save; safecall;
    property Application: _Application read Get_Application;
    property Parent: SavedWebPages read Get_Parent;
    property FileName: WideString read Get_FileName write Set_FileName;
    property Location: Location read Get_Location write Set_Location;
    property IncludeMap: WordBool read Get_IncludeMap write Set_IncludeMap;
    property IncludeDirections: WordBool read Get_IncludeDirections write Set_IncludeDirections;
    property IncludeLegend: WordBool read Get_IncludeLegend write Set_IncludeLegend;
    property IncludeOverview: WordBool read Get_IncludeOverview write Set_IncludeOverview;
    property IncludeHyperlinks: WordBool read Get_IncludeHyperlinks write Set_IncludeHyperlinks;
    property IncludeThumbnail: WordBool read Get_IncludeThumbnail write Set_IncludeThumbnail;
    property Title: WideString read Get_Title write Set_Title;
    property IncludeSourceFile: WordBool read Get_IncludeSourceFile write Set_IncludeSourceFile;
    property Width: Integer read Get_Width write Set_Width;
    property Height: Integer read Get_Height write Set_Height;
    property AutoResave: WordBool read Get_AutoResave write Set_AutoResave;
  end;

// *********************************************************************//
// DispIntf:  SavedWebPageDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C674DC89-7FCA-4AB0-8906-950C32520F6B}
// *********************************************************************//
  SavedWebPageDisp = dispinterface
    ['{C674DC89-7FCA-4AB0-8906-950C32520F6B}']
    property Application: _Application readonly dispid 100663313;
    property Parent: SavedWebPages readonly dispid -803;
    property FileName: WideString dispid 100672769;
    property Location: Location dispid 100663318;
    property IncludeMap: WordBool dispid 100672770;
    property IncludeDirections: WordBool dispid 100672771;
    property IncludeLegend: WordBool dispid 100672772;
    property IncludeOverview: WordBool dispid 100672773;
    property IncludeHyperlinks: WordBool dispid 100672774;
    property IncludeThumbnail: WordBool dispid 100672777;
    property Title: WideString dispid 100672775;
    property IncludeSourceFile: WordBool dispid 100672776;
    property Width: Integer dispid 100663572;
    property Height: Integer dispid 100663570;
    procedure Delete; dispid -801;
    property AutoResave: WordBool dispid 100672778;
    procedure Save; dispid 100794889;
  end;

// *********************************************************************//
// Interface: Symbols
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BA556839-86AF-4995-A52D-D1CCE8009E20}
// *********************************************************************//
  Symbols = interface(IDispatch)
    ['{BA556839-86AF-4995-A52D-D1CCE8009E20}']
    function Get_Application: _Application; safecall;
    function Get_Parent: _Map; safecall;
    function Get_Count: Integer; safecall;
    function Get__NewEnum: IUnknown; safecall;
    function Get_Item(var Index: OleVariant): Symbol; safecall;
    function Add(const FileName: WideString): Symbol; safecall;
    function ItemByID(ID: Smallint): Symbol; safecall;
    property Application: _Application read Get_Application;
    property Parent: _Map read Get_Parent;
    property Count: Integer read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[var Index: OleVariant]: Symbol read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  SymbolsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BA556839-86AF-4995-A52D-D1CCE8009E20}
// *********************************************************************//
  SymbolsDisp = dispinterface
    ['{BA556839-86AF-4995-A52D-D1CCE8009E20}']
    property Application: _Application readonly dispid 100663313;
    property Parent: _Map readonly dispid -803;
    property Count: Integer readonly dispid 100663321;
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[var Index: OleVariant]: Symbol readonly dispid 0; default;
    function Add(const FileName: WideString): Symbol; dispid 100794404;
    function ItemByID(ID: Smallint): Symbol; dispid 100804353;
  end;

// *********************************************************************//
// Interface: Symbol
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {28C5D50F-6A13-4931-B25B-C4A84AD59C70}
// *********************************************************************//
  Symbol = interface(IDispatch)
    ['{28C5D50F-6A13-4931-B25B-C4A84AD59C70}']
    function Get_Application: _Application; safecall;
    function Get_Parent: Symbols; safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const pVal: WideString); safecall;
    function Get_ID: Smallint; safecall;
    procedure Delete; safecall;
    function Get_IsCustom: WordBool; safecall;
    procedure Set_UseTransparency(pVal: WordBool); safecall;
    function Get_UseTransparency: WordBool; safecall;
    property Application: _Application read Get_Application;
    property Parent: Symbols read Get_Parent;
    property Name: WideString read Get_Name write Set_Name;
    property ID: Smallint read Get_ID;
    property IsCustom: WordBool read Get_IsCustom;
    property UseTransparency: WordBool read Get_UseTransparency write Set_UseTransparency;
  end;

// *********************************************************************//
// DispIntf:  SymbolDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {28C5D50F-6A13-4931-B25B-C4A84AD59C70}
// *********************************************************************//
  SymbolDisp = dispinterface
    ['{28C5D50F-6A13-4931-B25B-C4A84AD59C70}']
    property Application: _Application readonly dispid 100663313;
    property Parent: Symbols readonly dispid -803;
    property Name: WideString dispid -800;
    property ID: Smallint readonly dispid 0;
    procedure Delete; dispid -801;
    property IsCustom: WordBool readonly dispid 100673538;
    property UseTransparency: WordBool dispid 100673539;
  end;

// *********************************************************************//
// Interface: Toolbars
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {95621048-6F1C-46CB-AE15-16991D4869BE}
// *********************************************************************//
  Toolbars = interface(IDispatch)
    ['{95621048-6F1C-46CB-AE15-16991D4869BE}']
    function Get_Application: _Application; safecall;
    function Get_Parent: _Application; safecall;
    function Get_Count: Integer; safecall;
    function Get__NewEnum: IUnknown; safecall;
    function Get_Item(var Index: OleVariant): Toolbar; safecall;
    property Application: _Application read Get_Application;
    property Parent: _Application read Get_Parent;
    property Count: Integer read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[var Index: OleVariant]: Toolbar read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  ToolbarsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {95621048-6F1C-46CB-AE15-16991D4869BE}
// *********************************************************************//
  ToolbarsDisp = dispinterface
    ['{95621048-6F1C-46CB-AE15-16991D4869BE}']
    property Application: _Application readonly dispid 100663313;
    property Parent: _Application readonly dispid -803;
    property Count: Integer readonly dispid 100663321;
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[var Index: OleVariant]: Toolbar readonly dispid 0; default;
  end;

// *********************************************************************//
// Interface: Toolbar
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {B870697B-4295-46FB-B97C-C9E3FA5DF55A}
// *********************************************************************//
  Toolbar = interface(IDispatch)
    ['{B870697B-4295-46FB-B97C-C9E3FA5DF55A}']
    function Get_Application: _Application; safecall;
    function Get_Parent: Toolbars; safecall;
    function Get_Name: WideString; safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(pVal: WordBool); safecall;
    function Get_Index: Integer; safecall;
    property Application: _Application read Get_Application;
    property Parent: Toolbars read Get_Parent;
    property Name: WideString read Get_Name;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property Index: Integer read Get_Index;
  end;

// *********************************************************************//
// DispIntf:  ToolbarDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {B870697B-4295-46FB-B97C-C9E3FA5DF55A}
// *********************************************************************//
  ToolbarDisp = dispinterface
    ['{B870697B-4295-46FB-B97C-C9E3FA5DF55A}']
    property Application: _Application readonly dispid 100663313;
    property Parent: Toolbars readonly dispid -803;
    property Name: WideString readonly dispid -800;
    property Visible: WordBool dispid 100663574;
    property Index: Integer readonly dispid 100663326;
  end;

// *********************************************************************//
// Interface: AddIns
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0A9247B4-02BD-4F12-B79E-681D6405A848}
// *********************************************************************//
  AddIns = interface(IDispatch)
    ['{0A9247B4-02BD-4F12-B79E-681D6405A848}']
    function Get_Application: _Application; safecall;
    function Get_Parent: _Application; safecall;
    function Get_Count: Integer; safecall;
    function Get__NewEnum: IUnknown; safecall;
    function Get_Item(var Index: OleVariant): IDispatch; safecall;
    function Connect(const ProgId: WideString): IDispatch; safecall;
    procedure Disconnect(ObjectOrProgId: OleVariant); safecall;
    property Application: _Application read Get_Application;
    property Parent: _Application read Get_Parent;
    property Count: Integer read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[var Index: OleVariant]: IDispatch read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  AddInsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0A9247B4-02BD-4F12-B79E-681D6405A848}
// *********************************************************************//
  AddInsDisp = dispinterface
    ['{0A9247B4-02BD-4F12-B79E-681D6405A848}']
    property Application: _Application readonly dispid 100663313;
    property Parent: _Application readonly dispid -803;
    property Count: Integer readonly dispid 100663321;
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[var Index: OleVariant]: IDispatch readonly dispid 0; default;
    function Connect(const ProgId: WideString): IDispatch; dispid 100804865;
    procedure Disconnect(ObjectOrProgId: OleVariant); dispid 100804866;
  end;

// *********************************************************************//
// Interface: _Application80
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F81-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  _Application80 = interface(IDispatch)
    ['{31851F81-AFE6-11D2-A3C9-00C04F72F340}']
    function Get_Application: _Application; safecall;
    function Get_Parent: _Application; safecall;
    function Get_Name: WideString; safecall;
    function Get_ActiveMap: _Map; safecall;
    function OpenMap(const FileName: WideString; AddToRecentFiles: WordBool): _Map; safecall;
    function NewMap(const Template: WideString): _Map; safecall;
    function Get_Caption: WideString; safecall;
    procedure Set_Caption(const pVal: WideString); safecall;
    function Get_Path: WideString; safecall;
    function Get_DefaultFilePath: WideString; safecall;
    function Get_FullName: WideString; safecall;
    function Get_Version: WideString; safecall;
    function Get_Build: WideString; safecall;
    procedure Activate; safecall;
    function Get_Height: Integer; safecall;
    procedure Set_Height(pVal: Integer); safecall;
    function Get_Left: Integer; safecall;
    procedure Set_Left(pVal: Integer); safecall;
    function Get_Width: Integer; safecall;
    procedure Set_Width(pVal: Integer); safecall;
    function Get_Top: Integer; safecall;
    procedure Set_Top(pVal: Integer); safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(pVal: WordBool); safecall;
    function Get_WindowState: GeoWindowState; safecall;
    procedure Set_WindowState(pVal: GeoWindowState); safecall;
    procedure AddCommand(const DisplayName: WideString; const MethodName: WideString; 
                         const Target: IDispatch); safecall;
    procedure RemoveCommands(const Target: IDispatch); safecall;
    function Get_Units: GeoUnits; safecall;
    procedure Set_Units(pVal: GeoUnits); safecall;
    function Get_PaneState: GeoPaneState; safecall;
    procedure Set_PaneState(pVal: GeoPaneState); safecall;
    function Get_Region: GeoMapRegion; safecall;
    procedure Quit; safecall;
    property Application: _Application read Get_Application;
    property Parent: _Application read Get_Parent;
    property Name: WideString read Get_Name;
    property ActiveMap: _Map read Get_ActiveMap;
    property Caption: WideString read Get_Caption write Set_Caption;
    property Path: WideString read Get_Path;
    property DefaultFilePath: WideString read Get_DefaultFilePath;
    property FullName: WideString read Get_FullName;
    property Version: WideString read Get_Version;
    property Build: WideString read Get_Build;
    property Height: Integer read Get_Height write Set_Height;
    property Left: Integer read Get_Left write Set_Left;
    property Width: Integer read Get_Width write Set_Width;
    property Top: Integer read Get_Top write Set_Top;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property WindowState: GeoWindowState read Get_WindowState write Set_WindowState;
    property Units: GeoUnits read Get_Units write Set_Units;
    property PaneState: GeoPaneState read Get_PaneState write Set_PaneState;
    property Region: GeoMapRegion read Get_Region;
  end;

// *********************************************************************//
// DispIntf:  _Application80Disp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F81-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  _Application80Disp = dispinterface
    ['{31851F81-AFE6-11D2-A3C9-00C04F72F340}']
    property Application: _Application readonly dispid 100663313;
    property Parent: _Application readonly dispid -803;
    property Name: WideString readonly dispid -800;
    property ActiveMap: _Map readonly dispid 100663553;
    function OpenMap(const FileName: WideString; AddToRecentFiles: WordBool): _Map; dispid 100794627;
    function NewMap(const Template: WideString): _Map; dispid 100794628;
    property Caption: WideString dispid 100663558;
    property Path: WideString readonly dispid 100663317;
    property DefaultFilePath: WideString readonly dispid 100663559;
    property FullName: WideString readonly dispid 100663316;
    property Version: WideString readonly dispid 100663560;
    property Build: WideString readonly dispid 100663561;
    procedure Activate; dispid 100794649;
    property Height: Integer dispid 100663570;
    property Left: Integer dispid 100663571;
    property Width: Integer dispid 100663572;
    property Top: Integer dispid 100663573;
    property Visible: WordBool dispid 100663574;
    property WindowState: GeoWindowState dispid 100663575;
    procedure AddCommand(const DisplayName: WideString; const MethodName: WideString; 
                         const Target: IDispatch); dispid 100794656;
    procedure RemoveCommands(const Target: IDispatch); dispid 100794657;
    property Units: GeoUnits dispid 100663554;
    property PaneState: GeoPaneState dispid 100663576;
    property Region: GeoMapRegion readonly dispid 100663569;
    procedure Quit; dispid 100794629;
  end;

// *********************************************************************//
// Interface: _Map80
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F83-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  _Map80 = interface(IDispatch)
    ['{31851F83-AFE6-11D2-A3C9-00C04F72F340}']
    function Get_Application: _Application; safecall;
    function Get_Parent: _Application; safecall;
    function Get_Name: WideString; safecall;
    function Get_Container: IDispatch; safecall;
    function Get_Saved: WordBool; safecall;
    procedure Set_Saved(pVal: WordBool); safecall;
    function Get_FullName: WideString; safecall;
    function Get_Path: WideString; safecall;
    procedure _Set_Location(const ppVal: Location); safecall;
    function Get_Location: Location; safecall;
    function Get_Altitude: Double; safecall;
    procedure Set_Altitude(pVal: Double); safecall;
    function Get_ActiveRoute: Route; safecall;
    function Get_DataSets: DataSets; safecall;
    function Get_MapStyle: GeoMapStyle; safecall;
    procedure Set_MapStyle(pVal: GeoMapStyle); safecall;
    function Get_MapFont: GeoMapFont; safecall;
    procedure Set_MapFont(pVal: GeoMapFont); safecall;
    procedure Save; safecall;
    procedure SaveAs(const FileName: WideString; SaveFormat: GeoSaveFormat; 
                     AddToRecentFiles: WordBool); safecall;
    procedure PrintOut(const OutputFileName: WideString; const Title: WideString; Copies: Integer; 
                       PrintArea: GeoPrintArea; PrintQuality: GeoPrintQuality; 
                       PrintOrientation: GeoPrintOrientation; Collate: WordBool; 
                       IncludeLegend: WordBool; IncludeOverview: WordBool; Faxable: WordBool); safecall;
    function Find(const Name: WideString): IDispatch; safecall;
    function ShowFindDialog80(const Name: WideString; FindState: GeoFindState; HWndParent: Integer): IDispatch; safecall;
    function FindAddress(const Street: WideString; var AddressStrings: PSafeArray): Location; safecall;
    function FindPushpin(const Name: WideString): Pushpin; safecall;
    function AddPushpin(const AtLocation: Location; const Name: WideString): Pushpin; safecall;
    procedure CopyMap; safecall;
    procedure CopyDirections; safecall;
    function Distance(const StartLocation: Location; const EndLocation: Location): Double; safecall;
    procedure GoToLatLong(Latitude: Double; Longitude: Double; Altitude: Double); safecall;
    function GetLocation(Latitude: Double; Longitude: Double; Altitude: Double): Location; safecall;
    function Get_Selection: IDispatch; safecall;
    property Application: _Application read Get_Application;
    property Parent: _Application read Get_Parent;
    property Name: WideString read Get_Name;
    property Container: IDispatch read Get_Container;
    property Saved: WordBool read Get_Saved write Set_Saved;
    property FullName: WideString read Get_FullName;
    property Path: WideString read Get_Path;
    property Location: Location read Get_Location write _Set_Location;
    property Altitude: Double read Get_Altitude write Set_Altitude;
    property ActiveRoute: Route read Get_ActiveRoute;
    property DataSets: DataSets read Get_DataSets;
    property MapStyle: GeoMapStyle read Get_MapStyle write Set_MapStyle;
    property MapFont: GeoMapFont read Get_MapFont write Set_MapFont;
    property Selection: IDispatch read Get_Selection;
  end;

// *********************************************************************//
// DispIntf:  _Map80Disp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F83-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  _Map80Disp = dispinterface
    ['{31851F83-AFE6-11D2-A3C9-00C04F72F340}']
    property Application: _Application readonly dispid 100663313;
    property Parent: _Application readonly dispid -803;
    property Name: WideString readonly dispid -800;
    property Container: IDispatch readonly dispid 100663825;
    property Saved: WordBool dispid 100663809;
    property FullName: WideString readonly dispid 100663316;
    property Path: WideString readonly dispid 100663317;
    property Location: Location dispid 100663318;
    property Altitude: Double dispid 100663826;
    property ActiveRoute: Route readonly dispid 100663828;
    property DataSets: DataSets readonly dispid 100663829;
    property MapStyle: GeoMapStyle dispid 100663830;
    property MapFont: GeoMapFont dispid 100663831;
    procedure Save; dispid 100794889;
    procedure SaveAs(const FileName: WideString; SaveFormat: GeoSaveFormat; 
                     AddToRecentFiles: WordBool); dispid 100794896;
    procedure PrintOut(const OutputFileName: WideString; const Title: WideString; Copies: Integer; 
                       PrintArea: GeoPrintArea; PrintQuality: GeoPrintQuality; 
                       PrintOrientation: GeoPrintOrientation; Collate: WordBool; 
                       IncludeLegend: WordBool; IncludeOverview: WordBool; Faxable: WordBool); dispid 100794888;
    function Find(const Name: WideString): IDispatch; dispid 100794884;
    function ShowFindDialog80(const Name: WideString; FindState: GeoFindState; HWndParent: Integer): IDispatch; dispid 100794905;
    function FindAddress(const Street: WideString; var AddressStrings: {??PSafeArray}OleVariant): Location; dispid 100794885;
    function FindPushpin(const Name: WideString): Pushpin; dispid 100794886;
    function AddPushpin(const AtLocation: Location; const Name: WideString): Pushpin; dispid 100794912;
    procedure CopyMap; dispid 100794882;
    procedure CopyDirections; dispid 100794904;
    function Distance(const StartLocation: Location; const EndLocation: Location): Double; dispid 100794883;
    procedure GoToLatLong(Latitude: Double; Longitude: Double; Altitude: Double); dispid 100794887;
    function GetLocation(Latitude: Double; Longitude: Double; Altitude: Double): Location; dispid 100794914;
    property Selection: IDispatch readonly dispid 100663827;
  end;

// *********************************************************************//
// DispIntf:  _MapEvents
// Flags:     (4096) Dispatchable
// GUID:      {1C7E3C54-DC9B-4714-90FD-0AB297E1D2E5}
// *********************************************************************//
  _MapEvents = dispinterface
    ['{1C7E3C54-DC9B-4714-90FD-0AB297E1D2E5}']
    procedure AfterViewChange; dispid 100931073;
    procedure AfterRedraw; dispid 100931074;
    procedure RouteAfterCalculate(const Rte: Route); dispid 100931075;
    procedure RouteAfterOptimize(const Rte: Route); dispid 100931076;
    procedure NewDataSet(const NewDataSet: DataSet); dispid 100931077;
    procedure DataMapChange(const ChangedDataSet: DataSet); dispid 100931078;
    procedure SelectionChange(const NewSelection: IDispatch; const OldSelection: IDispatch); dispid 100931079;
    procedure BeforeDblClick(Button: Integer; Shift: Integer; X: Integer; Y: Integer; 
                             out Cancel: WordBool); dispid 100931080;
    procedure BeforeClick(Button: Integer; Shift: Integer; X: Integer; Y: Integer; 
                          out Cancel: WordBool); dispid 100931081;
    procedure MouseDown(Button: Integer; Shift: Integer; X: Integer; Y: Integer); dispid 100931082;
    procedure MouseMove(Button: Integer; Shift: Integer; X: Integer; Y: Integer); dispid 100931083;
    procedure MouseUp(Button: Integer; Shift: Integer; X: Integer; Y: Integer); dispid 100931084;
  end;

// *********************************************************************//
// DispIntf:  _ApplicationEvents
// Flags:     (4096) Dispatchable
// GUID:      {91848759-5033-4956-8E9C-B840F11C6045}
// *********************************************************************//
  _ApplicationEvents = dispinterface
    ['{91848759-5033-4956-8E9C-B840F11C6045}']
    procedure New; dispid 100930817;
    procedure Open; dispid 100930818;
    procedure Quit; dispid 100930819;
    procedure BeforeSave(SaveAsUI: WordBool; out Cancel: WordBool); dispid 100930820;
    procedure BeforeClose(out Cancel: WordBool); dispid 100930821;
  end;

// *********************************************************************//
// Interface: Location80
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F85-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  Location80 = interface(IDispatch)
    ['{31851F85-AFE6-11D2-A3C9-00C04F72F340}']
    function Get_Application: _Application; safecall;
    function Get_Parent: _Map; safecall;
    function Get_Name: WideString; safecall;
    procedure GoTo_; safecall;
    function Get_Location: Location; safecall;
    property Application: _Application read Get_Application;
    property Parent: _Map read Get_Parent;
    property Name: WideString read Get_Name;
    property Location: Location read Get_Location;
  end;

// *********************************************************************//
// DispIntf:  Location80Disp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F85-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  Location80Disp = dispinterface
    ['{31851F85-AFE6-11D2-A3C9-00C04F72F340}']
    property Application: _Application readonly dispid 100663313;
    property Parent: _Map readonly dispid -803;
    property Name: WideString readonly dispid -800;
    procedure GoTo_; dispid 100794392;
    property Location: Location readonly dispid 100663318;
  end;

// *********************************************************************//
// Interface: Route80
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F91-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  Route80 = interface(IDispatch)
    ['{31851F91-AFE6-11D2-A3C9-00C04F72F340}']
    function Get_Application: _Application; safecall;
    function Get_Parent: _Map; safecall;
    function Get_Waypoints: Waypoints; safecall;
    function Get_IsCalculated: WordBool; safecall;
    procedure Calculate; safecall;
    procedure Clear; safecall;
    function Get_Cost80: Double; safecall;
    function Get_Distance: Double; safecall;
    function Get_DrivingTime: Double; safecall;
    function Get_TripTime: Double; safecall;
    property Application: _Application read Get_Application;
    property Parent: _Map read Get_Parent;
    property Waypoints: Waypoints read Get_Waypoints;
    property IsCalculated: WordBool read Get_IsCalculated;
    property Cost80: Double read Get_Cost80;
    property Distance: Double read Get_Distance;
    property DrivingTime: Double read Get_DrivingTime;
    property TripTime: Double read Get_TripTime;
  end;

// *********************************************************************//
// DispIntf:  Route80Disp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F91-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  Route80Disp = dispinterface
    ['{31851F91-AFE6-11D2-A3C9-00C04F72F340}']
    property Application: _Application readonly dispid 100663313;
    property Parent: _Map readonly dispid -803;
    property Waypoints: Waypoints readonly dispid 100665857;
    property IsCalculated: WordBool readonly dispid 100665858;
    procedure Calculate; dispid 100796935;
    procedure Clear; dispid 100796936;
    property Cost80: Double readonly dispid 100665859;
    property Distance: Double readonly dispid 100665860;
    property DrivingTime: Double readonly dispid 100665861;
    property TripTime: Double readonly dispid 100665862;
  end;

// *********************************************************************//
// Interface: Waypoint80
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F92-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  Waypoint80 = interface(IDispatch)
    ['{31851F92-AFE6-11D2-A3C9-00C04F72F340}']
    function Get_Application: _Application; safecall;
    function Get_Parent: Waypoints; safecall;
    function Get_Name: WideString; safecall;
    procedure Delete; safecall;
    function Get_Location: Location; safecall;
    function Get_Anchor: IDispatch; safecall;
    procedure _Set_Anchor(const ppVal: IDispatch); safecall;
    function Get_PreferredArrival: TDateTime; safecall;
    procedure Set_PreferredArrival(pVal: TDateTime); safecall;
    function Get_PreferredDeparture: TDateTime; safecall;
    procedure Set_PreferredDeparture(pVal: TDateTime); safecall;
    function Get_StopTime: Double; safecall;
    procedure Set_StopTime(pVal: Double); safecall;
    function Get_Overnights: Integer; safecall;
    procedure Set_Overnights(pVal: Integer); safecall;
    function Get_SegmentPreferences: GeoSegmentPreferences; safecall;
    procedure Set_SegmentPreferences(pVal: GeoSegmentPreferences); safecall;
    procedure Set_ListPosition(dPos: Integer); safecall;
    function Get_ListPosition: Integer; safecall;
    procedure Reorder(Order: GeoOrderCmd); safecall;
    property Application: _Application read Get_Application;
    property Parent: Waypoints read Get_Parent;
    property Name: WideString read Get_Name;
    property Location: Location read Get_Location;
    property Anchor: IDispatch read Get_Anchor write _Set_Anchor;
    property PreferredArrival: TDateTime read Get_PreferredArrival write Set_PreferredArrival;
    property PreferredDeparture: TDateTime read Get_PreferredDeparture write Set_PreferredDeparture;
    property StopTime: Double read Get_StopTime write Set_StopTime;
    property Overnights: Integer read Get_Overnights write Set_Overnights;
    property SegmentPreferences: GeoSegmentPreferences read Get_SegmentPreferences write Set_SegmentPreferences;
    property ListPosition: Integer read Get_ListPosition write Set_ListPosition;
  end;

// *********************************************************************//
// DispIntf:  Waypoint80Disp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F92-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  Waypoint80Disp = dispinterface
    ['{31851F92-AFE6-11D2-A3C9-00C04F72F340}']
    property Application: _Application readonly dispid 100663313;
    property Parent: Waypoints readonly dispid -803;
    property Name: WideString readonly dispid -800;
    procedure Delete; dispid -801;
    property Location: Location readonly dispid 100663318;
    property Anchor: IDispatch dispid 100666369;
    property PreferredArrival: TDateTime dispid 100666370;
    property PreferredDeparture: TDateTime dispid 100666371;
    property StopTime: Double dispid 100666372;
    property Overnights: Integer dispid 100666373;
    property SegmentPreferences: GeoSegmentPreferences dispid 100666374;
    property ListPosition: Integer dispid 100666375;
    procedure Reorder(Order: GeoOrderCmd); dispid 100797448;
  end;

// *********************************************************************//
// Interface: DataSet80
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F90-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  DataSet80 = interface(IDispatch)
    ['{31851F90-AFE6-11D2-A3C9-00C04F72F340}']
    function Get_Application: _Application; safecall;
    function Get_Parent: DataSets; safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const pVal: WideString); safecall;
    procedure Delete; safecall;
    function Get_IsLinked: WordBool; safecall;
    function Get_SourceFullName: WideString; safecall;
    function Get_Symbol: Smallint; safecall;
    procedure Set_Symbol(pVal: Smallint); safecall;
    function Get_RecordCount: Integer; safecall;
    function Get_MatchedRecordCount: Integer; safecall;
    function Get_UnmatchedRecordCount: Integer; safecall;
    function Get_SkippedRecordCount: Integer; safecall;
    function Get_Fields: Fields; safecall;
    function QueryAllRecords: Recordset; safecall;
    function QueryPolygon80(var ArrayOfLocations: PSafeArray): Recordset; safecall;
    function QueryCircle(const Center: Location; Radius: Double): Recordset; safecall;
    function Get_DataMapType: GeoDataMapType; safecall;
    function DisplayDataMap80(DataMapType: GeoDataMapType; const DataField: Field; 
                              ShowDataBy: GeoShowDataBy; CombineDataBy: GeoCombineDataBy; 
                              DataRangeType: GeoDataRangeType; DataRangeOrder: GeoDataRangeOrder; 
                              ColorScheme: Integer; DataRangeCount: Integer; 
                              ArrayOfCustomValues: OleVariant; ArrayOfCustomNames: OleVariant; 
                              DivideByField: OleVariant): DataMap; safecall;
    procedure DisplayPushpinMap; safecall;
    function Get_DataMap: DataMap; safecall;
    procedure UpdateLink; safecall;
    procedure ZoomTo; safecall;
    property Application: _Application read Get_Application;
    property Parent: DataSets read Get_Parent;
    property Name: WideString read Get_Name write Set_Name;
    property IsLinked: WordBool read Get_IsLinked;
    property SourceFullName: WideString read Get_SourceFullName;
    property Symbol: Smallint read Get_Symbol write Set_Symbol;
    property RecordCount: Integer read Get_RecordCount;
    property MatchedRecordCount: Integer read Get_MatchedRecordCount;
    property UnmatchedRecordCount: Integer read Get_UnmatchedRecordCount;
    property SkippedRecordCount: Integer read Get_SkippedRecordCount;
    property Fields: Fields read Get_Fields;
    property DataMapType: GeoDataMapType read Get_DataMapType;
    property DataMap: DataMap read Get_DataMap;
  end;

// *********************************************************************//
// DispIntf:  DataSet80Disp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F90-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  DataSet80Disp = dispinterface
    ['{31851F90-AFE6-11D2-A3C9-00C04F72F340}']
    property Application: _Application readonly dispid 100663313;
    property Parent: DataSets readonly dispid -803;
    property Name: WideString dispid -800;
    procedure Delete; dispid -801;
    property IsLinked: WordBool readonly dispid 100664321;
    property SourceFullName: WideString readonly dispid 100664322;
    property Symbol: Smallint dispid 100663330;
    property RecordCount: Integer readonly dispid 100663331;
    property MatchedRecordCount: Integer readonly dispid 100664323;
    property UnmatchedRecordCount: Integer readonly dispid 100664324;
    property SkippedRecordCount: Integer readonly dispid 100664325;
    property Fields: Fields readonly dispid 100663329;
    function QueryAllRecords: Recordset; dispid 100795400;
    function QueryPolygon80(var ArrayOfLocations: {??PSafeArray}OleVariant): Recordset; dispid 100795401;
    function QueryCircle(const Center: Location; Radius: Double): Recordset; dispid 100795408;
    property DataMapType: GeoDataMapType readonly dispid 100664326;
    function DisplayDataMap80(DataMapType: GeoDataMapType; const DataField: Field; 
                              ShowDataBy: GeoShowDataBy; CombineDataBy: GeoCombineDataBy; 
                              DataRangeType: GeoDataRangeType; DataRangeOrder: GeoDataRangeOrder; 
                              ColorScheme: Integer; DataRangeCount: Integer; 
                              ArrayOfCustomValues: OleVariant; ArrayOfCustomNames: OleVariant; 
                              DivideByField: OleVariant): DataMap; dispid 100795411;
    procedure DisplayPushpinMap; dispid 100795412;
    property DataMap: DataMap readonly dispid 100664341;
    procedure UpdateLink; dispid 100795409;
    procedure ZoomTo; dispid 100795410;
  end;

// *********************************************************************//
// Interface: DataMap80
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F97-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  DataMap80 = interface(IDispatch)
    ['{31851F97-AFE6-11D2-A3C9-00C04F72F340}']
    function Get_Application: _Application; safecall;
    function Get_Parent: DataSet; safecall;
    function Get_RecordCount: Integer; safecall;
    function Get_LegendTitle: WideString; safecall;
    procedure Set_LegendTitle(const pVal: WideString); safecall;
    function Get_DataField: Field; safecall;
    function Get_ShowDataBy: GeoShowDataBy; safecall;
    function Get_CombineDataBy: GeoCombineDataBy; safecall;
    function Get_DataRanges: DataRanges; safecall;
    function Get_DivideByField: Field; safecall;
    function Get_IsGeographyForEveryZoomLevel: WordBool; safecall;
    property Application: _Application read Get_Application;
    property Parent: DataSet read Get_Parent;
    property RecordCount: Integer read Get_RecordCount;
    property LegendTitle: WideString read Get_LegendTitle write Set_LegendTitle;
    property DataField: Field read Get_DataField;
    property ShowDataBy: GeoShowDataBy read Get_ShowDataBy;
    property CombineDataBy: GeoCombineDataBy read Get_CombineDataBy;
    property DataRanges: DataRanges read Get_DataRanges;
    property DivideByField: Field read Get_DivideByField;
    property IsGeographyForEveryZoomLevel: WordBool read Get_IsGeographyForEveryZoomLevel;
  end;

// *********************************************************************//
// DispIntf:  DataMap80Disp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F97-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  DataMap80Disp = dispinterface
    ['{31851F97-AFE6-11D2-A3C9-00C04F72F340}']
    property Application: _Application readonly dispid 100663313;
    property Parent: DataSet readonly dispid -803;
    property RecordCount: Integer readonly dispid 100663331;
    property LegendTitle: WideString dispid 100666625;
    property DataField: Field readonly dispid 100666626;
    property ShowDataBy: GeoShowDataBy readonly dispid 100666627;
    property CombineDataBy: GeoCombineDataBy readonly dispid 100666628;
    property DataRanges: DataRanges readonly dispid 100666629;
    property DivideByField: Field readonly dispid 100666630;
    property IsGeographyForEveryZoomLevel: WordBool readonly dispid 100666631;
  end;

// *********************************************************************//
// Interface: DataRange80
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F98-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  DataRange80 = interface(IDispatch)
    ['{31851F98-AFE6-11D2-A3C9-00C04F72F340}']
    function Get_Application: _Application; safecall;
    function Get_Parent: DataRanges; safecall;
    function Get_Name: WideString; safecall;
    function Get_LowValue: OleVariant; safecall;
    function Get_HighValue: OleVariant; safecall;
    function Get_RecordCount: Integer; safecall;
    property Application: _Application read Get_Application;
    property Parent: DataRanges read Get_Parent;
    property Name: WideString read Get_Name;
    property LowValue: OleVariant read Get_LowValue;
    property HighValue: OleVariant read Get_HighValue;
    property RecordCount: Integer read Get_RecordCount;
  end;

// *********************************************************************//
// DispIntf:  DataRange80Disp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F98-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  DataRange80Disp = dispinterface
    ['{31851F98-AFE6-11D2-A3C9-00C04F72F340}']
    property Application: _Application readonly dispid 100663313;
    property Parent: DataRanges readonly dispid -803;
    property Name: WideString readonly dispid -800;
    property LowValue: OleVariant readonly dispid 100666881;
    property HighValue: OleVariant readonly dispid 100666882;
    property RecordCount: Integer readonly dispid 100663331;
  end;

// *********************************************************************//
// Interface: _MapPointUtilities
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {33A1C7CE-9E37-4A11-8213-0413A20C66BA}
// *********************************************************************//
  _MapPointUtilities = interface(IDispatch)
    ['{33A1C7CE-9E37-4A11-8213-0413A20C66BA}']
    function GetPictureFromObject(const Source: IUnknown; Width: Integer; Height: Integer): IDispatch; safecall;
    function GetProgIDFromObject(const Source: IUnknown): WideString; safecall;
  end;

// *********************************************************************//
// DispIntf:  _MapPointUtilitiesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {33A1C7CE-9E37-4A11-8213-0413A20C66BA}
// *********************************************************************//
  _MapPointUtilitiesDisp = dispinterface
    ['{33A1C7CE-9E37-4A11-8213-0413A20C66BA}']
    function GetPictureFromObject(const Source: IUnknown; Width: Integer; Height: Integer): IDispatch; dispid 100803329;
    function GetProgIDFromObject(const Source: IUnknown): WideString; dispid 100803330;
  end;

// *********************************************************************//
// Interface: DataSets80
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F89-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  DataSets80 = interface(IDispatch)
    ['{31851F89-AFE6-11D2-A3C9-00C04F72F340}']
    function Get_Application: _Application; safecall;
    function Get_Parent: _Map; safecall;
    function Get_Count: Integer; safecall;
    function Get_Item(var Index: OleVariant): DataSet; safecall;
    function Get__NewEnum: IUnknown; safecall;
    function ShowImportWizard80(HWndParent: Integer): DataSet; safecall;
    function ShowLinkWizard80(HWndParent: Integer): DataSet; safecall;
    function ImportData(const DataSourceMoniker: WideString; ArrayOfFields: OleVariant; 
                        Country: GeoCountry; Delimiter: GeoDelimiter; ImportFlags: Integer): DataSet; safecall;
    function LinkData(const DataSourceMoniker: WideString; PrimaryKeyField: OleVariant; 
                      ArrayOfFields: OleVariant; Country: GeoCountry; Delimiter: GeoDelimiter; 
                      ImportFlags: Integer): DataSet; safecall;
    procedure ZoomTo; safecall;
    property Application: _Application read Get_Application;
    property Parent: _Map read Get_Parent;
    property Count: Integer read Get_Count;
    property Item[var Index: OleVariant]: DataSet read Get_Item; default;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  DataSets80Disp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F89-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  DataSets80Disp = dispinterface
    ['{31851F89-AFE6-11D2-A3C9-00C04F72F340}']
    property Application: _Application readonly dispid 100663313;
    property Parent: _Map readonly dispid -803;
    property Count: Integer readonly dispid 100663321;
    property Item[var Index: OleVariant]: DataSet readonly dispid 0; default;
    property _NewEnum: IUnknown readonly dispid -4;
    function ShowImportWizard80(HWndParent: Integer): DataSet; dispid 100795137;
    function ShowLinkWizard80(HWndParent: Integer): DataSet; dispid 100795138;
    function ImportData(const DataSourceMoniker: WideString; ArrayOfFields: OleVariant; 
                        Country: GeoCountry; Delimiter: GeoDelimiter; ImportFlags: Integer): DataSet; dispid 100795139;
    function LinkData(const DataSourceMoniker: WideString; PrimaryKeyField: OleVariant; 
                      ArrayOfFields: OleVariant; Country: GeoCountry; Delimiter: GeoDelimiter; 
                      ImportFlags: Integer): DataSet; dispid 100795140;
    procedure ZoomTo; dispid 100795410;
  end;

// *********************************************************************//
// Interface: Pushpin80
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F87-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  Pushpin80 = interface(IDispatch)
    ['{31851F87-AFE6-11D2-A3C9-00C04F72F340}']
    function Get_Application: _Application; safecall;
    function Get_Parent: DataSet; safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const pVal: WideString); safecall;
    procedure Delete; safecall;
    function Get_Location: Location; safecall;
    procedure _Set_Location(const ppVal: Location); safecall;
    function Get_Note: WideString; safecall;
    procedure Set_Note(const pVal: WideString); safecall;
    function Get_Highlight: WordBool; safecall;
    procedure Set_Highlight(pVal: WordBool); safecall;
    function Get_Symbol: Smallint; safecall;
    procedure Set_Symbol(pVal: Smallint); safecall;
    function Get_BalloonState: GeoBalloonState; safecall;
    procedure Set_BalloonState(pVal: GeoBalloonState); safecall;
    procedure GoTo_; safecall;
    property Application: _Application read Get_Application;
    property Parent: DataSet read Get_Parent;
    property Name: WideString read Get_Name write Set_Name;
    property Location: Location read Get_Location write _Set_Location;
    property Note: WideString read Get_Note write Set_Note;
    property Highlight: WordBool read Get_Highlight write Set_Highlight;
    property Symbol: Smallint read Get_Symbol write Set_Symbol;
    property BalloonState: GeoBalloonState read Get_BalloonState write Set_BalloonState;
  end;

// *********************************************************************//
// DispIntf:  Pushpin80Disp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F87-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  Pushpin80Disp = dispinterface
    ['{31851F87-AFE6-11D2-A3C9-00C04F72F340}']
    property Application: _Application readonly dispid 100663313;
    property Parent: DataSet readonly dispid -803;
    property Name: WideString dispid -800;
    procedure Delete; dispid -801;
    property Location: Location dispid 100663318;
    property Note: WideString dispid 100665346;
    property Highlight: WordBool dispid 100665345;
    property Symbol: Smallint dispid 100663330;
    property BalloonState: GeoBalloonState dispid 100665347;
    procedure GoTo_; dispid 100794392;
  end;

// *********************************************************************//
// Interface: Recordset80
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F94-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  Recordset80 = interface(IDispatch)
    ['{31851F94-AFE6-11D2-A3C9-00C04F72F340}']
    function Get_Application: _Application; safecall;
    function Get_Parent: DataSet; safecall;
    function Get_Pushpin: Pushpin; safecall;
    function Get_Location: Location; safecall;
    function Get_Fields: Fields; safecall;
    function Get_BOF: WordBool; safecall;
    function Get_EOF: WordBool; safecall;
    procedure MoveFirst; safecall;
    procedure MoveNext; safecall;
    procedure MoveToPushpin(const Pushpin: Pushpin); safecall;
    function Get_IsMatched: WordBool; safecall;
    procedure MatchRecord(ShowDialogIfAmbiguous: WordBool; HWndParent: Integer); safecall;
    property Application: _Application read Get_Application;
    property Parent: DataSet read Get_Parent;
    property Pushpin: Pushpin read Get_Pushpin;
    property Location: Location read Get_Location;
    property Fields: Fields read Get_Fields;
    property BOF: WordBool read Get_BOF;
    property EOF: WordBool read Get_EOF;
    property IsMatched: WordBool read Get_IsMatched;
  end;

// *********************************************************************//
// DispIntf:  Recordset80Disp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F94-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  Recordset80Disp = dispinterface
    ['{31851F94-AFE6-11D2-A3C9-00C04F72F340}']
    property Application: _Application readonly dispid 100663313;
    property Parent: DataSet readonly dispid -803;
    property Pushpin: Pushpin readonly dispid 100664577;
    property Location: Location readonly dispid 100663318;
    property Fields: Fields readonly dispid 100663329;
    property BOF: WordBool readonly dispid 100664578;
    property EOF: WordBool readonly dispid 100664579;
    procedure MoveFirst; dispid 100795653;
    procedure MoveNext; dispid 100795654;
    procedure MoveToPushpin(const Pushpin: Pushpin); dispid 100795655;
    property IsMatched: WordBool readonly dispid 100664580;
    procedure MatchRecord(ShowDialogIfAmbiguous: WordBool; HWndParent: Integer); dispid 100795399;
  end;

// *********************************************************************//
// Interface: Field80
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F95-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  Field80 = interface(IDispatch)
    ['{31851F95-AFE6-11D2-A3C9-00C04F72F340}']
    function Get_Application: _Application; safecall;
    function Get_Parent: Fields; safecall;
    function Get_Name: WideString; safecall;
    function Get_Value: OleVariant; safecall;
    function Get_type_: DataTypeEnum; safecall;
    function Get_GeographicFieldType: GeoFieldType; safecall;
    function Get_IsPrimaryKey: WordBool; safecall;
    property Application: _Application read Get_Application;
    property Parent: Fields read Get_Parent;
    property Name: WideString read Get_Name;
    property Value: OleVariant read Get_Value;
    property type_: DataTypeEnum read Get_type_;
    property GeographicFieldType: GeoFieldType read Get_GeographicFieldType;
    property IsPrimaryKey: WordBool read Get_IsPrimaryKey;
  end;

// *********************************************************************//
// DispIntf:  Field80Disp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {31851F95-AFE6-11D2-A3C9-00C04F72F340}
// *********************************************************************//
  Field80Disp = dispinterface
    ['{31851F95-AFE6-11D2-A3C9-00C04F72F340}']
    property Application: _Application readonly dispid 100663313;
    property Parent: Fields readonly dispid -803;
    property Name: WideString readonly dispid -800;
    property Value: OleVariant readonly dispid 0;
    property type_: DataTypeEnum readonly dispid 100665089;
    property GeographicFieldType: GeoFieldType readonly dispid 100665090;
    property IsPrimaryKey: WordBool readonly dispid 100665092;
  end;

// *********************************************************************//
// The Class CoMapPointUtilities provides a Create and CreateRemote method to          
// create instances of the default interface _MapPointUtilities exposed by              
// the CoClass MapPointUtilities. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMapPointUtilities = class
    class function Create: _MapPointUtilities;
    class function CreateRemote(const MachineName: string): _MapPointUtilities;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TMapPointUtilities
// Help String      : Used to create picture objects or return programmatic identifiers that can be used in Visual Basic.
// Default Interface: _MapPointUtilities
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMapPointUtilitiesProperties= class;
{$ENDIF}
  TMapPointUtilities = class(TOleServer)
  private
    FIntf:        _MapPointUtilities;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TMapPointUtilitiesProperties;
    function      GetServerProperties: TMapPointUtilitiesProperties;
{$ENDIF}
    function      GetDefaultInterface: _MapPointUtilities;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _MapPointUtilities);
    procedure Disconnect; override;
    function GetPictureFromObject(const Source: IUnknown; Width: Integer; Height: Integer): IDispatch;
    function GetProgIDFromObject(const Source: IUnknown): WideString;
    property DefaultInterface: _MapPointUtilities read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMapPointUtilitiesProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TMapPointUtilities
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TMapPointUtilitiesProperties = class(TPersistent)
  private
    FServer:    TMapPointUtilities;
    function    GetDefaultInterface: _MapPointUtilities;
    constructor Create(AServer: TMapPointUtilities);
  protected
  public
    property DefaultInterface: _MapPointUtilities read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoApplication provides a Create and CreateRemote method to          
// create instances of the default interface _Application exposed by              
// the CoClass Application. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoApplication = class
    class function Create: _Application;
    class function CreateRemote(const MachineName: string): _Application;
  end;

  TApplicationBeforeSave = procedure(ASender: TObject; SaveAsUI: WordBool; out Cancel: WordBool) of object;
  TApplicationBeforeClose = procedure(ASender: TObject; out Cancel: WordBool) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TMapPointApplication
// Help String      : Represents the MapPoint application and allows access to the application window, opening map files, allowing COM add-ins to add or remove commands, and quitting the application.
// Default Interface: _Application
// Def. Intf. DISP? : No
// Event   Interface: _ApplicationEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TApplicationProperties= class;
{$ENDIF}
  TMapPointApplication = class(TOleServer)
  private
    FOnNew: TNotifyEvent;
    FOnOpen: TNotifyEvent;
    FOnQuit: TNotifyEvent;
    FOnBeforeSave: TApplicationBeforeSave;
    FOnBeforeClose: TApplicationBeforeClose;
    FAutoQuit:    Boolean;
    FIntf:        _Application;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TApplicationProperties;
    function      GetServerProperties: TApplicationProperties;
{$ENDIF}
    function      GetDefaultInterface: _Application;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_Application: _Application;
    function Get_Parent: _Application;
    function Get_Name: WideString;
    function Get_ActiveMap: _Map;
    function Get_Caption: WideString;
    procedure Set_Caption(const pVal: WideString);
    function Get_Path: WideString;
    function Get_DefaultFilePath: WideString;
    function Get_FullName: WideString;
    function Get_Version: WideString;
    function Get_Build: WideString;
    function Get_Height: Integer;
    procedure Set_Height(pVal: Integer);
    function Get_Left: Integer;
    procedure Set_Left(pVal: Integer);
    function Get_Width: Integer;
    procedure Set_Width(pVal: Integer);
    function Get_Top: Integer;
    procedure Set_Top(pVal: Integer);
    function Get_Visible: WordBool;
    procedure Set_Visible(pVal: WordBool);
    function Get_WindowState: GeoWindowState;
    procedure Set_WindowState(pVal: GeoWindowState);
    function Get_Units: GeoUnits;
    procedure Set_Units(pVal: GeoUnits);
    function Get_PaneState: GeoPaneState;
    procedure Set_PaneState(pVal: GeoPaneState);
    function Get_Region: GeoMapRegion;
    function Get_UserControl: WordBool;
    procedure Set_UserControl(pVal: WordBool);
    function Get_ItineraryVisible: WordBool;
    procedure Set_ItineraryVisible(pVal: WordBool);
    function Get_Toolbars: Toolbars;
    function Get_ActivePrinter: WideString;
    procedure Set_ActivePrinter(const pVal: WideString);
    function Get_MousePointer: GeoPointer;
    procedure Set_MousePointer(pVal: GeoPointer);
    function Get_AddIns: AddIns;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _Application);
    procedure Disconnect; override;
    function OpenMap(const FileName: WideString; AddToRecentFiles: WordBool): _Map;
    function NewMap(const Template: WideString): _Map;
    procedure Activate;
    procedure AddCommand(const DisplayName: WideString; const MethodName: WideString; 
                         const Target: IDispatch);
    procedure RemoveCommands(const Target: IDispatch);
    procedure Quit;
    property DefaultInterface: _Application read GetDefaultInterface;
    property Application: _Application read Get_Application;
    property Parent: _Application read Get_Parent;
    property Name: WideString read Get_Name;
    property ActiveMap: _Map read Get_ActiveMap;
    property Path: WideString read Get_Path;
    property DefaultFilePath: WideString read Get_DefaultFilePath;
    property FullName: WideString read Get_FullName;
    property Version: WideString read Get_Version;
    property Build: WideString read Get_Build;
    property Region: GeoMapRegion read Get_Region;
    property Toolbars: Toolbars read Get_Toolbars;
    property AddIns: AddIns read Get_AddIns;
    property Caption: WideString read Get_Caption write Set_Caption;
    property Height: Integer read Get_Height write Set_Height;
    property Left: Integer read Get_Left write Set_Left;
    property Width: Integer read Get_Width write Set_Width;
    property Top: Integer read Get_Top write Set_Top;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property WindowState: GeoWindowState read Get_WindowState write Set_WindowState;
    property Units: GeoUnits read Get_Units write Set_Units;
    property PaneState: GeoPaneState read Get_PaneState write Set_PaneState;
    property UserControl: WordBool read Get_UserControl write Set_UserControl;
    property ItineraryVisible: WordBool read Get_ItineraryVisible write Set_ItineraryVisible;
    property ActivePrinter: WideString read Get_ActivePrinter write Set_ActivePrinter;
    property MousePointer: GeoPointer read Get_MousePointer write Set_MousePointer;
  published
    property AutoQuit: Boolean read FAutoQuit write FAutoQuit; 
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TApplicationProperties read GetServerProperties;
{$ENDIF}
    property OnNew: TNotifyEvent read FOnNew write FOnNew;
    property OnOpen: TNotifyEvent read FOnOpen write FOnOpen;
    property OnQuit: TNotifyEvent read FOnQuit write FOnQuit;
    property OnBeforeSave: TApplicationBeforeSave read FOnBeforeSave write FOnBeforeSave;
    property OnBeforeClose: TApplicationBeforeClose read FOnBeforeClose write FOnBeforeClose;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TApplication
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TApplicationProperties = class(TPersistent)
  private
    FServer:    TApplication;
    function    GetDefaultInterface: _Application;
    constructor Create(AServer: TApplication);
  protected
    function Get_Application: _Application;
    function Get_Parent: _Application;
    function Get_Name: WideString;
    function Get_ActiveMap: _Map;
    function Get_Caption: WideString;
    procedure Set_Caption(const pVal: WideString);
    function Get_Path: WideString;
    function Get_DefaultFilePath: WideString;
    function Get_FullName: WideString;
    function Get_Version: WideString;
    function Get_Build: WideString;
    function Get_Height: Integer;
    procedure Set_Height(pVal: Integer);
    function Get_Left: Integer;
    procedure Set_Left(pVal: Integer);
    function Get_Width: Integer;
    procedure Set_Width(pVal: Integer);
    function Get_Top: Integer;
    procedure Set_Top(pVal: Integer);
    function Get_Visible: WordBool;
    procedure Set_Visible(pVal: WordBool);
    function Get_WindowState: GeoWindowState;
    procedure Set_WindowState(pVal: GeoWindowState);
    function Get_Units: GeoUnits;
    procedure Set_Units(pVal: GeoUnits);
    function Get_PaneState: GeoPaneState;
    procedure Set_PaneState(pVal: GeoPaneState);
    function Get_Region: GeoMapRegion;
    function Get_UserControl: WordBool;
    procedure Set_UserControl(pVal: WordBool);
    function Get_ItineraryVisible: WordBool;
    procedure Set_ItineraryVisible(pVal: WordBool);
    function Get_Toolbars: Toolbars;
    function Get_ActivePrinter: WideString;
    procedure Set_ActivePrinter(const pVal: WideString);
    function Get_MousePointer: GeoPointer;
    procedure Set_MousePointer(pVal: GeoPointer);
    function Get_AddIns: AddIns;
  public
    property DefaultInterface: _Application read GetDefaultInterface;
  published
    property Caption: WideString read Get_Caption write Set_Caption;
    property Height: Integer read Get_Height write Set_Height;
    property Left: Integer read Get_Left write Set_Left;
    property Width: Integer read Get_Width write Set_Width;
    property Top: Integer read Get_Top write Set_Top;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property WindowState: GeoWindowState read Get_WindowState write Set_WindowState;
    property Units: GeoUnits read Get_Units write Set_Units;
    property PaneState: GeoPaneState read Get_PaneState write Set_PaneState;
    property UserControl: WordBool read Get_UserControl write Set_UserControl;
    property ItineraryVisible: WordBool read Get_ItineraryVisible write Set_ItineraryVisible;
    property ActivePrinter: WideString read Get_ActivePrinter write Set_ActivePrinter;
    property MousePointer: GeoPointer read Get_MousePointer write Set_MousePointer;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoMap provides a Create and CreateRemote method to          
// create instances of the default interface _Map exposed by              
// the CoClass Map. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMap = class
    class function Create: _Map;
    class function CreateRemote(const MachineName: string): _Map;
  end;

  TMapRouteAfterCalculate = procedure(ASender: TObject; const Rte: Route) of object;
  TMapRouteAfterOptimize = procedure(ASender: TObject; const Rte: Route) of object;
  TMapNewDataSet = procedure(ASender: TObject; const NewDataSet: DataSet) of object;
  TMapDataMapChange = procedure(ASender: TObject; const ChangedDataSet: DataSet) of object;
  TMapSelectionChange = procedure(ASender: TObject; const NewSelection: IDispatch; 
                                                    const OldSelection: IDispatch) of object;
  TMapBeforeDblClick = procedure(ASender: TObject; Button: Integer; Shift: Integer; X: Integer; 
                                                   Y: Integer; out Cancel: WordBool) of object;
  TMapBeforeClick = procedure(ASender: TObject; Button: Integer; Shift: Integer; X: Integer; 
                                                Y: Integer; out Cancel: WordBool) of object;
  TMapMouseDown = procedure(ASender: TObject; Button: Integer; Shift: Integer; X: Integer; 
                                              Y: Integer) of object;
  TMapMouseMove = procedure(ASender: TObject; Button: Integer; Shift: Integer; X: Integer; 
                                              Y: Integer) of object;
  TMapMouseUp = procedure(ASender: TObject; Button: Integer; Shift: Integer; X: Integer; Y: Integer) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TMap
// Help String      : The document object of MapPoint.
// Default Interface: _Map
// Def. Intf. DISP? : No
// Event   Interface: _MapEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMapProperties= class;
{$ENDIF}
  TMap = class(TOleServer)
  private
    FOnAfterViewChange: TNotifyEvent;
    FOnAfterRedraw: TNotifyEvent;
    FOnRouteAfterCalculate: TMapRouteAfterCalculate;
    FOnRouteAfterOptimize: TMapRouteAfterOptimize;
    FOnNewDataSet: TMapNewDataSet;
    FOnDataMapChange: TMapDataMapChange;
    FOnSelectionChange: TMapSelectionChange;
    FOnBeforeDblClick: TMapBeforeDblClick;
    FOnBeforeClick: TMapBeforeClick;
    FOnMouseDown: TMapMouseDown;
    FOnMouseMove: TMapMouseMove;
    FOnMouseUp: TMapMouseUp;
    FIntf:        _Map;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TMapProperties;
    function      GetServerProperties: TMapProperties;
{$ENDIF}
    function      GetDefaultInterface: _Map;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_Application: _Application;
    function Get_Parent: _Application;
    function Get_Name: WideString;
    function Get_Container: IDispatch;
    function Get_Saved: WordBool;
    procedure Set_Saved(pVal: WordBool);
    function Get_FullName: WideString;
    function Get_Path: WideString;
    procedure _Set_Location(const ppVal: Location);
    function Get_Location: Location;
    function Get_Altitude: Double;
    procedure Set_Altitude(pVal: Double);
    function Get_ActiveRoute: Route;
    function Get_DataSets: DataSets;
    function Get_MapStyle: GeoMapStyle;
    procedure Set_MapStyle(pVal: GeoMapStyle);
    function Get_MapFont: GeoMapFont;
    procedure Set_MapFont(pVal: GeoMapFont);
    function Get_Selection: IDispatch;
    function Get_Shapes: Shapes;
    function Get_PlaceCategories: PlaceCategories;
    function Get_Top: Integer;
    function Get_Left: Integer;
    function Get_Height: Integer;
    function Get_Width: Integer;
    function Get_PixelSize: Double;
    function Get_SelectedArea: SelectedArea;
    function Get_Projection: GeoMapProjection;
    procedure Set_Projection(pVal: GeoMapProjection);
    function Get_PageSetup: PageSetup;
    function Get_AllowEdgePan: WordBool;
    procedure Set_AllowEdgePan(pVal: WordBool);
    function Get_DragBehavior: GeoDragBehavior;
    procedure Set_DragBehavior(pVal: GeoDragBehavior);
    function Get_SavedWebPages: SavedWebPages;
    function Get_Symbols: Symbols;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _Map);
    procedure Disconnect; override;
    procedure Save;
    procedure SaveAs(const FileName: WideString; SaveFormat: GeoSaveFormat; 
                     AddToRecentFiles: WordBool);
    procedure PrintOut(const OutputFileName: WideString; const Title: WideString; Copies: Integer; 
                       PrintArea: GeoPrintArea; PrintQuality: GeoPrintQuality; 
                       PrintOrientation: GeoPrintOrientation; Collate: WordBool; 
                       IncludeLegend: WordBool; IncludeOverview: WordBool; Faxable: WordBool);
    function Find(const Name: WideString): IDispatch;
    function ShowFindDialog80(const Name: WideString; FindState: GeoFindState; HWndParent: Integer): IDispatch;
    function FindAddress(const Street: WideString; var AddressStrings: PSafeArray): Location;
    function FindPushpin(const Name: WideString): Pushpin;
    function AddPushpin(const AtLocation: Location; const Name: WideString): Pushpin;
    procedure CopyMap;
    procedure CopyDirections;
    function Distance(const StartLocation: Location; const EndLocation: Location): Double;
    procedure GoToLatLong(Latitude: Double; Longitude: Double; Altitude: Double);
    function GetLocation(Latitude: Double; Longitude: Double; Altitude: Double): Location;
    function FindResults(const Name: WideString): FindResults;
    function FindAddressResults(const Street: WideString; const City: WideString; 
                                const OtherCity: WideString; const Region: WideString; 
                                const PostalCode: WideString): FindResults; overload;
    function FindAddressResults(const Street: WideString; const City: WideString; 
                                const OtherCity: WideString; const Region: WideString; 
                                const PostalCode: WideString; Country: OleVariant): FindResults; overload;
    function ShowFindDialog(const Name: WideString; FindState: GeoFindState; HWndParent: Integer; 
                            AutoConfirmExactMatch: WordBool): IDispatch;
    function XYToLocation(X: Integer; Y: Integer): Location;
    function LocationToX(const Where: Location): Integer;
    function LocationToY(const Where: Location): Integer;
    procedure Pan(PanDirection: GeoPanCmd; PanFactor: Double);
    function Union(ArrayOfLocations: OleVariant): Location;
    function ObjectsFromPoint(X: Integer; Y: Integer): FindResults;
    procedure ZoomIn;
    procedure ZoomOut;
    procedure GoBack;
    procedure GoForward;
    procedure Paste;
    function ParseStreetAddress(const Address: WideString): StreetAddress;
    function FindPlaceResults(const Name: WideString): FindResults;
    property DefaultInterface: _Map read GetDefaultInterface;
    property Application: _Application read Get_Application;
    property Parent: _Application read Get_Parent;
    property Name: WideString read Get_Name;
    property Container: IDispatch read Get_Container;
    property FullName: WideString read Get_FullName;
    property Path: WideString read Get_Path;
    property Location: Location read Get_Location write _Set_Location;
    property ActiveRoute: Route read Get_ActiveRoute;
    property DataSets: DataSets read Get_DataSets;
    property Selection: IDispatch read Get_Selection;
    property Shapes: Shapes read Get_Shapes;
    property PlaceCategories: PlaceCategories read Get_PlaceCategories;
    property Top: Integer read Get_Top;
    property Left: Integer read Get_Left;
    property Height: Integer read Get_Height;
    property Width: Integer read Get_Width;
    property PixelSize: Double read Get_PixelSize;
    property SelectedArea: SelectedArea read Get_SelectedArea;
    property PageSetup: PageSetup read Get_PageSetup;
    property SavedWebPages: SavedWebPages read Get_SavedWebPages;
    property Symbols: Symbols read Get_Symbols;
    property Saved: WordBool read Get_Saved write Set_Saved;
    property Altitude: Double read Get_Altitude write Set_Altitude;
    property MapStyle: GeoMapStyle read Get_MapStyle write Set_MapStyle;
    property MapFont: GeoMapFont read Get_MapFont write Set_MapFont;
    property Projection: GeoMapProjection read Get_Projection write Set_Projection;
    property AllowEdgePan: WordBool read Get_AllowEdgePan write Set_AllowEdgePan;
    property DragBehavior: GeoDragBehavior read Get_DragBehavior write Set_DragBehavior;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMapProperties read GetServerProperties;
{$ENDIF}
    property OnAfterViewChange: TNotifyEvent read FOnAfterViewChange write FOnAfterViewChange;
    property OnAfterRedraw: TNotifyEvent read FOnAfterRedraw write FOnAfterRedraw;
    property OnRouteAfterCalculate: TMapRouteAfterCalculate read FOnRouteAfterCalculate write FOnRouteAfterCalculate;
    property OnRouteAfterOptimize: TMapRouteAfterOptimize read FOnRouteAfterOptimize write FOnRouteAfterOptimize;
    property OnNewDataSet: TMapNewDataSet read FOnNewDataSet write FOnNewDataSet;
    property OnDataMapChange: TMapDataMapChange read FOnDataMapChange write FOnDataMapChange;
    property OnSelectionChange: TMapSelectionChange read FOnSelectionChange write FOnSelectionChange;
    property OnBeforeDblClick: TMapBeforeDblClick read FOnBeforeDblClick write FOnBeforeDblClick;
    property OnBeforeClick: TMapBeforeClick read FOnBeforeClick write FOnBeforeClick;
    property OnMouseDown: TMapMouseDown read FOnMouseDown write FOnMouseDown;
    property OnMouseMove: TMapMouseMove read FOnMouseMove write FOnMouseMove;
    property OnMouseUp: TMapMouseUp read FOnMouseUp write FOnMouseUp;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TMap
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TMapProperties = class(TPersistent)
  private
    FServer:    TMap;
    function    GetDefaultInterface: _Map;
    constructor Create(AServer: TMap);
  protected
    function Get_Application: _Application;
    function Get_Parent: _Application;
    function Get_Name: WideString;
    function Get_Container: IDispatch;
    function Get_Saved: WordBool;
    procedure Set_Saved(pVal: WordBool);
    function Get_FullName: WideString;
    function Get_Path: WideString;
    procedure _Set_Location(const ppVal: Location);
    function Get_Location: Location;
    function Get_Altitude: Double;
    procedure Set_Altitude(pVal: Double);
    function Get_ActiveRoute: Route;
    function Get_DataSets: DataSets;
    function Get_MapStyle: GeoMapStyle;
    procedure Set_MapStyle(pVal: GeoMapStyle);
    function Get_MapFont: GeoMapFont;
    procedure Set_MapFont(pVal: GeoMapFont);
    function Get_Selection: IDispatch;
    function Get_Shapes: Shapes;
    function Get_PlaceCategories: PlaceCategories;
    function Get_Top: Integer;
    function Get_Left: Integer;
    function Get_Height: Integer;
    function Get_Width: Integer;
    function Get_PixelSize: Double;
    function Get_SelectedArea: SelectedArea;
    function Get_Projection: GeoMapProjection;
    procedure Set_Projection(pVal: GeoMapProjection);
    function Get_PageSetup: PageSetup;
    function Get_AllowEdgePan: WordBool;
    procedure Set_AllowEdgePan(pVal: WordBool);
    function Get_DragBehavior: GeoDragBehavior;
    procedure Set_DragBehavior(pVal: GeoDragBehavior);
    function Get_SavedWebPages: SavedWebPages;
    function Get_Symbols: Symbols;
  public
    property DefaultInterface: _Map read GetDefaultInterface;
  published
    property Saved: WordBool read Get_Saved write Set_Saved;
    property Altitude: Double read Get_Altitude write Set_Altitude;
    property MapStyle: GeoMapStyle read Get_MapStyle write Set_MapStyle;
    property MapFont: GeoMapFont read Get_MapFont write Set_MapFont;
    property Projection: GeoMapProjection read Get_Projection write Set_Projection;
    property AllowEdgePan: WordBool read Get_AllowEdgePan write Set_AllowEdgePan;
    property DragBehavior: GeoDragBehavior read Get_DragBehavior write Set_DragBehavior;
  end;
{$ENDIF}


resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

class function CoMapPointUtilities.Create: _MapPointUtilities;
begin
  Result := CreateComObject(CLASS_MapPointUtilities) as _MapPointUtilities;
end;

class function CoMapPointUtilities.CreateRemote(const MachineName: string): _MapPointUtilities;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MapPointUtilities) as _MapPointUtilities;
end;

procedure TMapPointUtilities.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{520DA2E0-BDE7-4AE2-A8D1-8FDFE5E8A305}';
    IntfIID:   '{33A1C7CE-9E37-4A11-8213-0413A20C66BA}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMapPointUtilities.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _MapPointUtilities;
  end;
end;

procedure TMapPointUtilities.ConnectTo(svrIntf: _MapPointUtilities);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMapPointUtilities.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TMapPointUtilities.GetDefaultInterface: _MapPointUtilities;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TMapPointUtilities.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMapPointUtilitiesProperties.Create(Self);
{$ENDIF}
end;

destructor TMapPointUtilities.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMapPointUtilities.GetServerProperties: TMapPointUtilitiesProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TMapPointUtilities.GetPictureFromObject(const Source: IUnknown; Width: Integer; 
                                                 Height: Integer): IDispatch;
begin
  Result := DefaultInterface.GetPictureFromObject(Source, Width, Height);
end;

function TMapPointUtilities.GetProgIDFromObject(const Source: IUnknown): WideString;
begin
  Result := DefaultInterface.GetProgIDFromObject(Source);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMapPointUtilitiesProperties.Create(AServer: TMapPointUtilities);
begin
  inherited Create;
  FServer := AServer;
end;

function TMapPointUtilitiesProperties.GetDefaultInterface: _MapPointUtilities;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoApplication.Create: _Application;
begin
  Result := CreateComObject(CLASS_Application) as _Application;
end;

class function CoApplication.CreateRemote(const MachineName: string): _Application;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Application) as _Application;
end;

procedure TMapPointApplication.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{31851F82-AFE6-11D2-A3C9-00C04F72F340}';
    IntfIID:   '{D6D389CE-1781-47A0-8984-4349687F65D6}';
    EventIID:  '{91848759-5033-4956-8E9C-B840F11C6045}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMapPointApplication.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as _Application;
  end;
end;

procedure TMapPointApplication.ConnectTo(svrIntf: _Application);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TMapPointApplication.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    if FAutoQuit then
      Quit();
    FIntf := nil;
  end;
end;

function TMapPointApplication.GetDefaultInterface: _Application;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TMapPointApplication.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TApplicationProperties.Create(Self);
{$ENDIF}
end;

destructor TMapPointApplication.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMapPointApplication.GetServerProperties: TApplicationProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TMapPointApplication.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    100930817: if Assigned(FOnNew) then
         FOnNew(Self);
    100930818: if Assigned(FOnOpen) then
         FOnOpen(Self);
    100930819: if Assigned(FOnQuit) then
         FOnQuit(Self);
    100930820: if Assigned(FOnBeforeSave) then
         FOnBeforeSave(Self,
                       Params[0] {WordBool},
                       WordBool((TVarData(Params[1]).VPointer)^) {out WordBool});
    100930821: if Assigned(FOnBeforeClose) then
         FOnBeforeClose(Self, WordBool((TVarData(Params[0]).VPointer)^) {out WordBool});
  end; {case DispID}
end;

function TMapPointApplication.Get_Application: _Application;
begin
    Result := DefaultInterface.Application;
end;

function TMapPointApplication.Get_Parent: _Application;
begin
    Result := DefaultInterface.Parent;
end;

function TMapPointApplication.Get_Name: WideString;
begin
    Result := DefaultInterface.Name;
end;

function TMapPointApplication.Get_ActiveMap: _Map;
begin
    Result := DefaultInterface.ActiveMap;
end;

function TMapPointApplication.Get_Caption: WideString;
begin
    Result := DefaultInterface.Caption;
end;

procedure TMapPointApplication.Set_Caption(const pVal: WideString);
  { Warning: The property Caption has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Caption := pVal;
end;

function TMapPointApplication.Get_Path: WideString;
begin
    Result := DefaultInterface.Path;
end;

function TMapPointApplication.Get_DefaultFilePath: WideString;
begin
    Result := DefaultInterface.DefaultFilePath;
end;

function TMapPointApplication.Get_FullName: WideString;
begin
    Result := DefaultInterface.FullName;
end;

function TMapPointApplication.Get_Version: WideString;
begin
    Result := DefaultInterface.Version;
end;

function TMapPointApplication.Get_Build: WideString;
begin
    Result := DefaultInterface.Build;
end;

function TMapPointApplication.Get_Height: Integer;
begin
    Result := DefaultInterface.Height;
end;

procedure TMapPointApplication.Set_Height(pVal: Integer);
begin
  DefaultInterface.Set_Height(pVal);
end;

function TMapPointApplication.Get_Left: Integer;
begin
    Result := DefaultInterface.Left;
end;

procedure TMapPointApplication.Set_Left(pVal: Integer);
begin
  DefaultInterface.Set_Left(pVal);
end;

function TMapPointApplication.Get_Width: Integer;
begin
    Result := DefaultInterface.Width;
end;

procedure TMapPointApplication.Set_Width(pVal: Integer);
begin
  DefaultInterface.Set_Width(pVal);
end;

function TMapPointApplication.Get_Top: Integer;
begin
    Result := DefaultInterface.Top;
end;

procedure TMapPointApplication.Set_Top(pVal: Integer);
begin
  DefaultInterface.Set_Top(pVal);
end;

function TMapPointApplication.Get_Visible: WordBool;
begin
    Result := DefaultInterface.Visible;
end;

procedure TMapPointApplication.Set_Visible(pVal: WordBool);
begin
  DefaultInterface.Set_Visible(pVal);
end;

function TMapPointApplication.Get_WindowState: GeoWindowState;
begin
    Result := DefaultInterface.WindowState;
end;

procedure TMapPointApplication.Set_WindowState(pVal: GeoWindowState);
begin
  DefaultInterface.Set_WindowState(pVal);
end;

function TMapPointApplication.Get_Units: GeoUnits;
begin
    Result := DefaultInterface.Units;
end;

procedure TMapPointApplication.Set_Units(pVal: GeoUnits);
begin
  DefaultInterface.Set_Units(pVal);
end;

function TMapPointApplication.Get_PaneState: GeoPaneState;
begin
    Result := DefaultInterface.PaneState;
end;

procedure TMapPointApplication.Set_PaneState(pVal: GeoPaneState);
begin
  DefaultInterface.Set_PaneState(pVal);
end;

function TMapPointApplication.Get_Region: GeoMapRegion;
begin
    Result := DefaultInterface.Region;
end;

function TMapPointApplication.Get_UserControl: WordBool;
begin
    Result := DefaultInterface.UserControl;
end;

procedure TMapPointApplication.Set_UserControl(pVal: WordBool);
begin
  DefaultInterface.Set_UserControl(pVal);
end;

function TMapPointApplication.Get_ItineraryVisible: WordBool;
begin
    Result := DefaultInterface.ItineraryVisible;
end;

procedure TMapPointApplication.Set_ItineraryVisible(pVal: WordBool);
begin
  DefaultInterface.Set_ItineraryVisible(pVal);
end;

function TMapPointApplication.Get_Toolbars: Toolbars;
begin
    Result := DefaultInterface.Toolbars;
end;

function TMapPointApplication.Get_ActivePrinter: WideString;
begin
    Result := DefaultInterface.ActivePrinter;
end;

procedure TMapPointApplication.Set_ActivePrinter(const pVal: WideString);
  { Warning: The property ActivePrinter has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ActivePrinter := pVal;
end;

function TMapPointApplication.Get_MousePointer: GeoPointer;
begin
    Result := DefaultInterface.MousePointer;
end;

procedure TMapPointApplication.Set_MousePointer(pVal: GeoPointer);
begin
  DefaultInterface.Set_MousePointer(pVal);
end;

function TMapPointApplication.Get_AddIns: AddIns;
begin
    Result := DefaultInterface.AddIns;
end;

function TMapPointApplication.OpenMap(const FileName: WideString; AddToRecentFiles: WordBool): _Map;
begin
  Result := DefaultInterface.OpenMap(FileName, AddToRecentFiles);
end;

function TMapPointApplication.NewMap(const Template: WideString): _Map;
begin
  Result := DefaultInterface.NewMap(Template);
end;

procedure TMapPointApplication.Activate;
begin
  DefaultInterface.Activate;
end;

procedure TMapPointApplication.AddCommand(const DisplayName: WideString; const MethodName: WideString; 
                                  const Target: IDispatch);
begin
  DefaultInterface.AddCommand(DisplayName, MethodName, Target);
end;

procedure TMapPointApplication.RemoveCommands(const Target: IDispatch);
begin
  DefaultInterface.RemoveCommands(Target);
end;

procedure TMapPointApplication.Quit;
begin
  DefaultInterface.Quit;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TApplicationProperties.Create(AServer: TApplication);
begin
  inherited Create;
  FServer := AServer;
end;

function TApplicationProperties.GetDefaultInterface: _Application;
begin
  Result := FServer.DefaultInterface;
end;

function TApplicationProperties.Get_Application: _Application;
begin
    Result := DefaultInterface.Application;
end;

function TApplicationProperties.Get_Parent: _Application;
begin
    Result := DefaultInterface.Parent;
end;

function TApplicationProperties.Get_Name: WideString;
begin
    Result := DefaultInterface.Name;
end;

function TApplicationProperties.Get_ActiveMap: _Map;
begin
    Result := DefaultInterface.ActiveMap;
end;

function TApplicationProperties.Get_Caption: WideString;
begin
    Result := DefaultInterface.Caption;
end;

procedure TApplicationProperties.Set_Caption(const pVal: WideString);
  { Warning: The property Caption has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Caption := pVal;
end;

function TApplicationProperties.Get_Path: WideString;
begin
    Result := DefaultInterface.Path;
end;

function TApplicationProperties.Get_DefaultFilePath: WideString;
begin
    Result := DefaultInterface.DefaultFilePath;
end;

function TApplicationProperties.Get_FullName: WideString;
begin
    Result := DefaultInterface.FullName;
end;

function TApplicationProperties.Get_Version: WideString;
begin
    Result := DefaultInterface.Version;
end;

function TApplicationProperties.Get_Build: WideString;
begin
    Result := DefaultInterface.Build;
end;

function TApplicationProperties.Get_Height: Integer;
begin
    Result := DefaultInterface.Height;
end;

procedure TApplicationProperties.Set_Height(pVal: Integer);
begin
  DefaultInterface.Set_Height(pVal);
end;

function TApplicationProperties.Get_Left: Integer;
begin
    Result := DefaultInterface.Left;
end;

procedure TApplicationProperties.Set_Left(pVal: Integer);
begin
  DefaultInterface.Set_Left(pVal);
end;

function TApplicationProperties.Get_Width: Integer;
begin
    Result := DefaultInterface.Width;
end;

procedure TApplicationProperties.Set_Width(pVal: Integer);
begin
  DefaultInterface.Set_Width(pVal);
end;

function TApplicationProperties.Get_Top: Integer;
begin
    Result := DefaultInterface.Top;
end;

procedure TApplicationProperties.Set_Top(pVal: Integer);
begin
  DefaultInterface.Set_Top(pVal);
end;

function TApplicationProperties.Get_Visible: WordBool;
begin
    Result := DefaultInterface.Visible;
end;

procedure TApplicationProperties.Set_Visible(pVal: WordBool);
begin
  DefaultInterface.Set_Visible(pVal);
end;

function TApplicationProperties.Get_WindowState: GeoWindowState;
begin
    Result := DefaultInterface.WindowState;
end;

procedure TApplicationProperties.Set_WindowState(pVal: GeoWindowState);
begin
  DefaultInterface.Set_WindowState(pVal);
end;

function TApplicationProperties.Get_Units: GeoUnits;
begin
    Result := DefaultInterface.Units;
end;

procedure TApplicationProperties.Set_Units(pVal: GeoUnits);
begin
  DefaultInterface.Set_Units(pVal);
end;

function TApplicationProperties.Get_PaneState: GeoPaneState;
begin
    Result := DefaultInterface.PaneState;
end;

procedure TApplicationProperties.Set_PaneState(pVal: GeoPaneState);
begin
  DefaultInterface.Set_PaneState(pVal);
end;

function TApplicationProperties.Get_Region: GeoMapRegion;
begin
    Result := DefaultInterface.Region;
end;

function TApplicationProperties.Get_UserControl: WordBool;
begin
    Result := DefaultInterface.UserControl;
end;

procedure TApplicationProperties.Set_UserControl(pVal: WordBool);
begin
  DefaultInterface.Set_UserControl(pVal);
end;

function TApplicationProperties.Get_ItineraryVisible: WordBool;
begin
    Result := DefaultInterface.ItineraryVisible;
end;

procedure TApplicationProperties.Set_ItineraryVisible(pVal: WordBool);
begin
  DefaultInterface.Set_ItineraryVisible(pVal);
end;

function TApplicationProperties.Get_Toolbars: Toolbars;
begin
    Result := DefaultInterface.Toolbars;
end;

function TApplicationProperties.Get_ActivePrinter: WideString;
begin
    Result := DefaultInterface.ActivePrinter;
end;

procedure TApplicationProperties.Set_ActivePrinter(const pVal: WideString);
  { Warning: The property ActivePrinter has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ActivePrinter := pVal;
end;

function TApplicationProperties.Get_MousePointer: GeoPointer;
begin
    Result := DefaultInterface.MousePointer;
end;

procedure TApplicationProperties.Set_MousePointer(pVal: GeoPointer);
begin
  DefaultInterface.Set_MousePointer(pVal);
end;

function TApplicationProperties.Get_AddIns: AddIns;
begin
    Result := DefaultInterface.AddIns;
end;

{$ENDIF}

class function CoMap.Create: _Map;
begin
  Result := CreateComObject(CLASS_Map) as _Map;
end;

class function CoMap.CreateRemote(const MachineName: string): _Map;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Map) as _Map;
end;

procedure TMap.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{31851F84-AFE6-11D2-A3C9-00C04F72F340}';
    IntfIID:   '{52BEC548-B6B1-4434-9783-D44863E7AF3B}';
    EventIID:  '{1C7E3C54-DC9B-4714-90FD-0AB297E1D2E5}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMap.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as _Map;
  end;
end;

procedure TMap.ConnectTo(svrIntf: _Map);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TMap.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TMap.GetDefaultInterface: _Map;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TMap.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMapProperties.Create(Self);
{$ENDIF}
end;

destructor TMap.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMap.GetServerProperties: TMapProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TMap.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    100931073: if Assigned(FOnAfterViewChange) then
         FOnAfterViewChange(Self);
    100931074: if Assigned(FOnAfterRedraw) then
         FOnAfterRedraw(Self);
    100931075: if Assigned(FOnRouteAfterCalculate) then
         FOnRouteAfterCalculate(Self, IUnknown(TVarData(Params[0]).VPointer) as Route {const Route});
    100931076: if Assigned(FOnRouteAfterOptimize) then
         FOnRouteAfterOptimize(Self, IUnknown(TVarData(Params[0]).VPointer) as Route {const Route});
    100931077: if Assigned(FOnNewDataSet) then
         FOnNewDataSet(Self, IUnknown(TVarData(Params[0]).VPointer) as DataSet {const DataSet});
    100931078: if Assigned(FOnDataMapChange) then
         FOnDataMapChange(Self, IUnknown(TVarData(Params[0]).VPointer) as DataSet {const DataSet});
    100931079: if Assigned(FOnSelectionChange) then
         FOnSelectionChange(Self,
                            Params[0] {const IDispatch},
                            Params[1] {const IDispatch});
    100931080: if Assigned(FOnBeforeDblClick) then
         FOnBeforeDblClick(Self,
                           Params[0] {Integer},
                           Params[1] {Integer},
                           Params[2] {Integer},
                           Params[3] {Integer},
                           WordBool((TVarData(Params[4]).VPointer)^) {out WordBool});
    100931081: if Assigned(FOnBeforeClick) then
         FOnBeforeClick(Self,
                        Params[0] {Integer},
                        Params[1] {Integer},
                        Params[2] {Integer},
                        Params[3] {Integer},
                        WordBool((TVarData(Params[4]).VPointer)^) {out WordBool});
    100931082: if Assigned(FOnMouseDown) then
         FOnMouseDown(Self,
                      Params[0] {Integer},
                      Params[1] {Integer},
                      Params[2] {Integer},
                      Params[3] {Integer});
    100931083: if Assigned(FOnMouseMove) then
         FOnMouseMove(Self,
                      Params[0] {Integer},
                      Params[1] {Integer},
                      Params[2] {Integer},
                      Params[3] {Integer});
    100931084: if Assigned(FOnMouseUp) then
         FOnMouseUp(Self,
                    Params[0] {Integer},
                    Params[1] {Integer},
                    Params[2] {Integer},
                    Params[3] {Integer});
  end; {case DispID}
end;

function TMap.Get_Application: _Application;
begin
    Result := DefaultInterface.Application;
end;

function TMap.Get_Parent: _Application;
begin
    Result := DefaultInterface.Parent;
end;

function TMap.Get_Name: WideString;
begin
    Result := DefaultInterface.Name;
end;

function TMap.Get_Container: IDispatch;
begin
    Result := DefaultInterface.Container;
end;

function TMap.Get_Saved: WordBool;
begin
    Result := DefaultInterface.Saved;
end;

procedure TMap.Set_Saved(pVal: WordBool);
begin
  DefaultInterface.Set_Saved(pVal);
end;

function TMap.Get_FullName: WideString;
begin
    Result := DefaultInterface.FullName;
end;

function TMap.Get_Path: WideString;
begin
    Result := DefaultInterface.Path;
end;

procedure TMap._Set_Location(const ppVal: Location);
  { Warning: The property Location has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Location := ppVal;
end;

function TMap.Get_Location: Location;
begin
    Result := DefaultInterface.Location;
end;

function TMap.Get_Altitude: Double;
begin
    Result := DefaultInterface.Altitude;
end;

procedure TMap.Set_Altitude(pVal: Double);
begin
  DefaultInterface.Set_Altitude(pVal);
end;

function TMap.Get_ActiveRoute: Route;
begin
    Result := DefaultInterface.ActiveRoute;
end;

function TMap.Get_DataSets: DataSets;
begin
    Result := DefaultInterface.DataSets;
end;

function TMap.Get_MapStyle: GeoMapStyle;
begin
    Result := DefaultInterface.MapStyle;
end;

procedure TMap.Set_MapStyle(pVal: GeoMapStyle);
begin
  DefaultInterface.Set_MapStyle(pVal);
end;

function TMap.Get_MapFont: GeoMapFont;
begin
    Result := DefaultInterface.MapFont;
end;

procedure TMap.Set_MapFont(pVal: GeoMapFont);
begin
  DefaultInterface.Set_MapFont(pVal);
end;

function TMap.Get_Selection: IDispatch;
begin
    Result := DefaultInterface.Selection;
end;

function TMap.Get_Shapes: Shapes;
begin
    Result := DefaultInterface.Shapes;
end;

function TMap.Get_PlaceCategories: PlaceCategories;
begin
    Result := DefaultInterface.PlaceCategories;
end;

function TMap.Get_Top: Integer;
begin
    Result := DefaultInterface.Top;
end;

function TMap.Get_Left: Integer;
begin
    Result := DefaultInterface.Left;
end;

function TMap.Get_Height: Integer;
begin
    Result := DefaultInterface.Height;
end;

function TMap.Get_Width: Integer;
begin
    Result := DefaultInterface.Width;
end;

function TMap.Get_PixelSize: Double;
begin
    Result := DefaultInterface.PixelSize;
end;

function TMap.Get_SelectedArea: SelectedArea;
begin
    Result := DefaultInterface.SelectedArea;
end;

function TMap.Get_Projection: GeoMapProjection;
begin
    Result := DefaultInterface.Projection;
end;

procedure TMap.Set_Projection(pVal: GeoMapProjection);
begin
  DefaultInterface.Set_Projection(pVal);
end;

function TMap.Get_PageSetup: PageSetup;
begin
    Result := DefaultInterface.PageSetup;
end;

function TMap.Get_AllowEdgePan: WordBool;
begin
    Result := DefaultInterface.AllowEdgePan;
end;

procedure TMap.Set_AllowEdgePan(pVal: WordBool);
begin
  DefaultInterface.Set_AllowEdgePan(pVal);
end;

function TMap.Get_DragBehavior: GeoDragBehavior;
begin
    Result := DefaultInterface.DragBehavior;
end;

procedure TMap.Set_DragBehavior(pVal: GeoDragBehavior);
begin
  DefaultInterface.Set_DragBehavior(pVal);
end;

function TMap.Get_SavedWebPages: SavedWebPages;
begin
    Result := DefaultInterface.SavedWebPages;
end;

function TMap.Get_Symbols: Symbols;
begin
    Result := DefaultInterface.Symbols;
end;

procedure TMap.Save;
begin
  DefaultInterface.Save;
end;

procedure TMap.SaveAs(const FileName: WideString; SaveFormat: GeoSaveFormat; 
                      AddToRecentFiles: WordBool);
begin
  DefaultInterface.SaveAs(FileName, SaveFormat, AddToRecentFiles);
end;

procedure TMap.PrintOut(const OutputFileName: WideString; const Title: WideString; Copies: Integer; 
                        PrintArea: GeoPrintArea; PrintQuality: GeoPrintQuality; 
                        PrintOrientation: GeoPrintOrientation; Collate: WordBool; 
                        IncludeLegend: WordBool; IncludeOverview: WordBool; Faxable: WordBool);
begin
  DefaultInterface.PrintOut(OutputFileName, Title, Copies, PrintArea, PrintQuality, 
                            PrintOrientation, Collate, IncludeLegend, IncludeOverview, Faxable);
end;

function TMap.Find(const Name: WideString): IDispatch;
begin
  Result := DefaultInterface.Find(Name);
end;

function TMap.ShowFindDialog80(const Name: WideString; FindState: GeoFindState; HWndParent: Integer): IDispatch;
begin
  Result := DefaultInterface.ShowFindDialog80(Name, FindState, HWndParent);
end;

function TMap.FindAddress(const Street: WideString; var AddressStrings: PSafeArray): Location;
begin
  Result := DefaultInterface.FindAddress(Street, AddressStrings);
end;

function TMap.FindPushpin(const Name: WideString): Pushpin;
begin
  Result := DefaultInterface.FindPushpin(Name);
end;

function TMap.AddPushpin(const AtLocation: Location; const Name: WideString): Pushpin;
begin
  Result := DefaultInterface.AddPushpin(AtLocation, Name);
end;

procedure TMap.CopyMap;
begin
  DefaultInterface.CopyMap;
end;

procedure TMap.CopyDirections;
begin
  DefaultInterface.CopyDirections;
end;

function TMap.Distance(const StartLocation: Location; const EndLocation: Location): Double;
begin
  Result := DefaultInterface.Distance(StartLocation, EndLocation);
end;

procedure TMap.GoToLatLong(Latitude: Double; Longitude: Double; Altitude: Double);
begin
  DefaultInterface.GoToLatLong(Latitude, Longitude, Altitude);
end;

function TMap.GetLocation(Latitude: Double; Longitude: Double; Altitude: Double): Location;
begin
  Result := DefaultInterface.GetLocation(Latitude, Longitude, Altitude);
end;

function TMap.FindResults(const Name: WideString): FindResults;
begin
  Result := DefaultInterface.FindResults(Name);
end;

function TMap.FindAddressResults(const Street: WideString; const City: WideString; 
                                 const OtherCity: WideString; const Region: WideString; 
                                 const PostalCode: WideString): FindResults;
begin
  Result := DefaultInterface.FindAddressResults(Street, City, OtherCity, Region, PostalCode, 
                                                EmptyParam);
end;

function TMap.FindAddressResults(const Street: WideString; const City: WideString; 
                                 const OtherCity: WideString; const Region: WideString; 
                                 const PostalCode: WideString; Country: OleVariant): FindResults;
begin
  Result := DefaultInterface.FindAddressResults(Street, City, OtherCity, Region, PostalCode, Country);
end;

function TMap.ShowFindDialog(const Name: WideString; FindState: GeoFindState; HWndParent: Integer; 
                             AutoConfirmExactMatch: WordBool): IDispatch;
begin
  Result := DefaultInterface.ShowFindDialog(Name, FindState, HWndParent, AutoConfirmExactMatch);
end;

function TMap.XYToLocation(X: Integer; Y: Integer): Location;
begin
  Result := DefaultInterface.XYToLocation(X, Y);
end;

function TMap.LocationToX(const Where: Location): Integer;
begin
  Result := DefaultInterface.LocationToX(Where);
end;

function TMap.LocationToY(const Where: Location): Integer;
begin
  Result := DefaultInterface.LocationToY(Where);
end;

procedure TMap.Pan(PanDirection: GeoPanCmd; PanFactor: Double);
begin
  DefaultInterface.Pan(PanDirection, PanFactor);
end;

function TMap.Union(ArrayOfLocations: OleVariant): Location;
begin
  Result := DefaultInterface.Union(ArrayOfLocations);
end;

function TMap.ObjectsFromPoint(X: Integer; Y: Integer): FindResults;
begin
  Result := DefaultInterface.ObjectsFromPoint(X, Y);
end;

procedure TMap.ZoomIn;
begin
  DefaultInterface.ZoomIn;
end;

procedure TMap.ZoomOut;
begin
  DefaultInterface.ZoomOut;
end;

procedure TMap.GoBack;
begin
  DefaultInterface.GoBack;
end;

procedure TMap.GoForward;
begin
  DefaultInterface.GoForward;
end;

procedure TMap.Paste;
begin
  DefaultInterface.Paste;
end;

function TMap.ParseStreetAddress(const Address: WideString): StreetAddress;
begin
  Result := DefaultInterface.ParseStreetAddress(Address);
end;

function TMap.FindPlaceResults(const Name: WideString): FindResults;
begin
  Result := DefaultInterface.FindPlaceResults(Name);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMapProperties.Create(AServer: TMap);
begin
  inherited Create;
  FServer := AServer;
end;

function TMapProperties.GetDefaultInterface: _Map;
begin
  Result := FServer.DefaultInterface;
end;

function TMapProperties.Get_Application: _Application;
begin
    Result := DefaultInterface.Application;
end;

function TMapProperties.Get_Parent: _Application;
begin
    Result := DefaultInterface.Parent;
end;

function TMapProperties.Get_Name: WideString;
begin
    Result := DefaultInterface.Name;
end;

function TMapProperties.Get_Container: IDispatch;
begin
    Result := DefaultInterface.Container;
end;

function TMapProperties.Get_Saved: WordBool;
begin
    Result := DefaultInterface.Saved;
end;

procedure TMapProperties.Set_Saved(pVal: WordBool);
begin
  DefaultInterface.Set_Saved(pVal);
end;

function TMapProperties.Get_FullName: WideString;
begin
    Result := DefaultInterface.FullName;
end;

function TMapProperties.Get_Path: WideString;
begin
    Result := DefaultInterface.Path;
end;

procedure TMapProperties._Set_Location(const ppVal: Location);
  { Warning: The property Location has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Location := ppVal;
end;

function TMapProperties.Get_Location: Location;
begin
    Result := DefaultInterface.Location;
end;

function TMapProperties.Get_Altitude: Double;
begin
    Result := DefaultInterface.Altitude;
end;

procedure TMapProperties.Set_Altitude(pVal: Double);
begin
  DefaultInterface.Set_Altitude(pVal);
end;

function TMapProperties.Get_ActiveRoute: Route;
begin
    Result := DefaultInterface.ActiveRoute;
end;

function TMapProperties.Get_DataSets: DataSets;
begin
    Result := DefaultInterface.DataSets;
end;

function TMapProperties.Get_MapStyle: GeoMapStyle;
begin
    Result := DefaultInterface.MapStyle;
end;

procedure TMapProperties.Set_MapStyle(pVal: GeoMapStyle);
begin
  DefaultInterface.Set_MapStyle(pVal);
end;

function TMapProperties.Get_MapFont: GeoMapFont;
begin
    Result := DefaultInterface.MapFont;
end;

procedure TMapProperties.Set_MapFont(pVal: GeoMapFont);
begin
  DefaultInterface.Set_MapFont(pVal);
end;

function TMapProperties.Get_Selection: IDispatch;
begin
    Result := DefaultInterface.Selection;
end;

function TMapProperties.Get_Shapes: Shapes;
begin
    Result := DefaultInterface.Shapes;
end;

function TMapProperties.Get_PlaceCategories: PlaceCategories;
begin
    Result := DefaultInterface.PlaceCategories;
end;

function TMapProperties.Get_Top: Integer;
begin
    Result := DefaultInterface.Top;
end;

function TMapProperties.Get_Left: Integer;
begin
    Result := DefaultInterface.Left;
end;

function TMapProperties.Get_Height: Integer;
begin
    Result := DefaultInterface.Height;
end;

function TMapProperties.Get_Width: Integer;
begin
    Result := DefaultInterface.Width;
end;

function TMapProperties.Get_PixelSize: Double;
begin
    Result := DefaultInterface.PixelSize;
end;

function TMapProperties.Get_SelectedArea: SelectedArea;
begin
    Result := DefaultInterface.SelectedArea;
end;

function TMapProperties.Get_Projection: GeoMapProjection;
begin
    Result := DefaultInterface.Projection;
end;

procedure TMapProperties.Set_Projection(pVal: GeoMapProjection);
begin
  DefaultInterface.Set_Projection(pVal);
end;

function TMapProperties.Get_PageSetup: PageSetup;
begin
    Result := DefaultInterface.PageSetup;
end;

function TMapProperties.Get_AllowEdgePan: WordBool;
begin
    Result := DefaultInterface.AllowEdgePan;
end;

procedure TMapProperties.Set_AllowEdgePan(pVal: WordBool);
begin
  DefaultInterface.Set_AllowEdgePan(pVal);
end;

function TMapProperties.Get_DragBehavior: GeoDragBehavior;
begin
    Result := DefaultInterface.DragBehavior;
end;

procedure TMapProperties.Set_DragBehavior(pVal: GeoDragBehavior);
begin
  DefaultInterface.Set_DragBehavior(pVal);
end;

function TMapProperties.Get_SavedWebPages: SavedWebPages;
begin
    Result := DefaultInterface.SavedWebPages;
end;

function TMapProperties.Get_Symbols: Symbols;
begin
    Result := DefaultInterface.Symbols;
end;

{$ENDIF}

end.
