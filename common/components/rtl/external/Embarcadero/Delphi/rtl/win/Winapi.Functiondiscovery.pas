{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Winapi.Functiondiscovery;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

{$HPPEMIT ''}
{$HPPEMIT '#include <functiondiscoverycategories.h>'}
{$HPPEMIT '#include <functiondiscoveryerror.h>'}
{$HPPEMIT '#include <functiondiscoverykeys.h>'}
{$HPPEMIT '#include <functiondiscoveryserviceids.h>'}
{.$HPPEMIT '#include <functiondiscoveryconstraints.h>'}
{$HPPEMIT '#include <functiondiscoveryapi.h>'}
{$HPPEMIT '#include <functiondiscovery.h>'}
{$HPPEMIT ''}

interface

uses Winapi.ActiveX, Winapi.Propkey, Winapi.Propsys, Winapi.Windows;

// functiondiscoverycategories.h

//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

// *****************************************************************************
// Important:  Anything added here should also be added to FunctionDiscoveryManagedKeys.h
// *****************************************************************************

const
  FD_SUBKEY = 'SOFTWARE\Microsoft\Function Discovery\';
  {$EXTERNALSYM FD_SUBKEY}
  FD_SUBKEY_CATEGORIES = FD_SUBKEY + 'Categories\';
  {$EXTERNALSYM FD_SUBKEY_CATEGORIES}

// *****************************************************************************
// Function Discovery Categories
// *****************************************************************************
// Important:  Anything added here should also be added to FunctionDiscoveryManagedKeys.h
// *****************************************************************************

// Provider Categories
// Windows Vista
  FCTN_CATEGORY_PNP = 'Provider\Microsoft.Base.PnP';
  {$EXTERNALSYM FCTN_CATEGORY_PNP}
  FCTN_CATEGORY_REGISTRY = 'Provider\Microsoft.Base.Registry';
  {$EXTERNALSYM FCTN_CATEGORY_REGISTRY}
  FCTN_CATEGORY_SSDP = 'Provider\Microsoft.Networking.SSDP';
  {$EXTERNALSYM FCTN_CATEGORY_SSDP}
  FCTN_CATEGORY_WSDISCOVERY = 'Provider\Microsoft.Networking.WSD';
  {$EXTERNALSYM FCTN_CATEGORY_WSDISCOVERY}
  FCTN_CATEGORY_NETBIOS = 'Provider\Microsoft.Networking.Netbios';
  {$EXTERNALSYM FCTN_CATEGORY_NETBIOS}
  FCTN_CATEGORY_WCN = 'Provider\Microsoft.Networking.WCN';
  {$EXTERNALSYM FCTN_CATEGORY_WCN}
  FCTN_CATEGORY_PUBLICATION = 'Provider\Microsoft.Base.Publication';
  {$EXTERNALSYM FCTN_CATEGORY_PUBLICATION}
  FCTN_CATEGORY_PNPXASSOCIATION = 'Provider\Microsoft.PnPX.Association';
  {$EXTERNALSYM FCTN_CATEGORY_PNPXASSOCIATION}
// Wireless Update Release
  FCTN_CATEGORY_BT = 'Provider\Microsoft.Devices.Bluetooth';
  {$EXTERNALSYM FCTN_CATEGORY_BT}
  FCTN_CATEGORY_WUSB = 'Provider\Microsoft.Devices.WirelessUSB';
  {$EXTERNALSYM FCTN_CATEGORY_WUSB}
  FCTN_CATEGORY_DEVICEDISPLAYOBJECTS = 'Provider\Microsoft.Base.DeviceDisplayObjects';
  {$EXTERNALSYM FCTN_CATEGORY_DEVICEDISPLAYOBJECTS}

// Layered Categories
// Windows Vista
  FCTN_CATEGORY_NETWORKDEVICES = 'Layered\Microsoft.Networking.Devices';
  {$EXTERNALSYM FCTN_CATEGORY_NETWORKDEVICES}
  FCTN_CATEGORY_DEVICES = 'Layered\Microsoft.Base.Devices';
  {$EXTERNALSYM FCTN_CATEGORY_DEVICES}
  FCTN_CATEGORY_DEVICEFUNCTIONENUMERATORS = 'Layered\Microsoft.Devices.FunctionEnumerators';
  {$EXTERNALSYM FCTN_CATEGORY_DEVICEFUNCTIONENUMERATORS}
  FCTN_CATEGORY_DEVICEPAIRING = 'Layered\Microsoft.Base.DevicePairing';
  {$EXTERNALSYM FCTN_CATEGORY_DEVICEPAIRING}

// *****************************************************************************
// Function Discovery SubCategories
// *****************************************************************************
// Important:  Anything added here should also be added to FunctionDiscoveryManagedKeys.h
// *****************************************************************************

// Subcategories of Devices FCTN_CATEGORY_DEVICES
  FCTN_SUBCAT_DEVICES_WSDPRINTERS = 'WSDPrinters';
  {$EXTERNALSYM FCTN_SUBCAT_DEVICES_WSDPRINTERS}

// Subcategories of Devices FCTN_CATEGORY_NETWORKDEVICES
  FCTN_SUBCAT_NETWORKDEVICES_SSDP = 'SSDP';
  {$EXTERNALSYM FCTN_SUBCAT_NETWORKDEVICES_SSDP}
  FCTN_SUBCAT_NETWORKDEVICES_WSD = 'WSD';
  {$EXTERNALSYM FCTN_SUBCAT_NETWORKDEVICES_WSD}

// Subcategories of Registry
  FCTN_SUBCAT_REG_PUBLICATION = 'Publication';
  {$EXTERNALSYM FCTN_SUBCAT_REG_PUBLICATION}
  FCTN_SUBCAT_REG_DIRECTED = 'Directed';
  {$EXTERNALSYM FCTN_SUBCAT_REG_DIRECTED}

// *****************************************************************************
// Important:  Anything added here should also be added to FunctionDiscoveryManagedKeys.h
// *****************************************************************************


// functiondiscoveryerror.h

// Error codes
//
//

const
  // MessageId: E_FDPAIRING_NOCONNECTION
  //
  // MessageText:
  //
  // The device has rejected the connection.
  //
  E_FDPAIRING_NOCONNECTION = HRESULT($8FD00001);
  {$EXTERNALSYM E_FDPAIRING_NOCONNECTION}

  // MessageId: E_FDPAIRING_NOCONNECTION
  //
  // MessageText:
  //
  // The device has indicated a hardware failure.
  //
  E_FDPAIRING_HWFAILURE = HRESULT($8FD00002);
  {$EXTERNALSYM E_FDPAIRING_HWFAILURE}

  // MessageId: E_FDPAIRING_AUTHFAILURE
  //
  // MessageText:
  //
  // The device authentication has failed.  Either the device has rejected the authentication or you rejected the authentication.
  //
  E_FDPAIRING_AUTHFAILURE = HRESULT($8FD00003);
  {$EXTERNALSYM E_FDPAIRING_AUTHFAILURE}

  // MessageId: E_FDPAIRING_CONNECTTIMEOUT
  //
  // MessageText:
  //
  // The time to finish the authentication has expired on the device.
  //
  E_FDPAIRING_CONNECTTIMEOUT = HRESULT($8FD00004);
  {$EXTERNALSYM E_FDPAIRING_CONNECTTIMEOUT}

  // MessageId: E_FDPAIRING_TOOMANYCONNECTIONS
  //
  // MessageText:
  //
  // The device has indicated that it cannot accept more incoming connections.
  //
  E_FDPAIRING_TOOMANYCONNECTIONS = HRESULT($8FD00005);
  {$EXTERNALSYM E_FDPAIRING_TOOMANYCONNECTIONS}

  // MessageId: E_FDPAIRING_AUTHNOTALLOWED
  //
  // MessageText:
  //
  // The device has indicated that the authentication is not allowed.
  //
  E_FDPAIRING_AUTHNOTALLOWED = HRESULT($8FD00006);
  {$EXTERNALSYM E_FDPAIRING_AUTHNOTALLOWED}

  // MessageId: E_FDPAIRING_AUTHNOTALLOWED
  //
  // MessageText:
  //
  // The Pnp-X Bus Enumerator service is disabled.
  //
  E_FDPAIRING_IPBUSDISABLED = HRESULT($8FD00007);
  {$EXTERNALSYM E_FDPAIRING_IPBUSDISABLED}

  // MessageId: E_FDPAIRING_NOPROFILES
  //
  // MessageText:
  //
  // Windows does not have any network profiles for this device to use.
  //
  E_FDPAIRING_NOPROFILES = HRESULT($8FD00008);
  {$EXTERNALSYM E_FDPAIRING_NOPROFILES}

// functiondiscoverykeys_devpkey.h

{ ++
Copyright (c) Microsoft Corporation.  All rights reserved.

Module Name:

    devpkey.h

Abstract:

    Defines property keys for the Plug and Play Device Property API.

Author:

    Jim Cavalaris (jamesca) 10-14-2003

Environment:

    User-mode only.

Revision History:

    14-October-2003     jamesca

        Creation and initial implementation.

    20-June-2006        dougb

        Copied Jim's version replaced "DEFINE_DEVPROPKEY(DEVPKEY_" with "DEFINE_PROPERTYKEY(PKEY_"

-- }

const
  PKEY_NAME: TPropertyKey = (
    fmtid: '{B725F130-47EF-101A-A5F1-02608C9EEBAC}'; pid: 10);
  {$EXTERNALSYM PKEY_NAME}

{ Device properties }
{ These PKEYs correspond to the old setupapi SPDRP_XXX properties }

  PKEY_Device_DeviceDesc: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 2);
  {$EXTERNALSYM PKEY_Device_DeviceDesc}
  PKEY_Device_HardwareIds: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 3);
  {$EXTERNALSYM PKEY_Device_HardwareIds}
  PKEY_Device_CompatibleIds: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 4);
  {$EXTERNALSYM PKEY_Device_CompatibleIds}
  PKEY_Device_Service: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 6);
  {$EXTERNALSYM PKEY_Device_Service}
  PKEY_Device_Class: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 9);
  {$EXTERNALSYM PKEY_Device_Class}
  PKEY_Device_ClassGuid: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 10);
  {$EXTERNALSYM PKEY_Device_ClassGuid}
  PKEY_Device_Driver: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 11);
  {$EXTERNALSYM PKEY_Device_Driver}
  PKEY_Device_ConfigFlags: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 12);
  {$EXTERNALSYM PKEY_Device_ConfigFlags}
  PKEY_Device_Manufacturer: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 13);
  {$EXTERNALSYM PKEY_Device_Manufacturer}
  PKEY_Device_FriendlyName: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 14);
  {$EXTERNALSYM PKEY_Device_FriendlyName}
  PKEY_Device_LocationInfo: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 15);
  {$EXTERNALSYM PKEY_Device_LocationInfo}
  PKEY_Device_PDOName: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 16);
  {$EXTERNALSYM PKEY_Device_PDOName}
  PKEY_Device_Capabilities: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 17);
  {$EXTERNALSYM PKEY_Device_Capabilities}
  PKEY_Device_UINumber: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 18);
  {$EXTERNALSYM PKEY_Device_UINumber}
  PKEY_Device_UpperFilters: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 19);
  {$EXTERNALSYM PKEY_Device_UpperFilters}
  PKEY_Device_LowerFilters: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 20);
  {$EXTERNALSYM PKEY_Device_LowerFilters}
  PKEY_Device_BusTypeGuid: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 21);
  {$EXTERNALSYM PKEY_Device_BusTypeGuid}
  PKEY_Device_LegacyBusType: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 22);
  {$EXTERNALSYM PKEY_Device_LegacyBusType}
  PKEY_Device_BusNumber: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 23);
  {$EXTERNALSYM PKEY_Device_BusNumber}
  PKEY_Device_EnumeratorName: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 24);
  {$EXTERNALSYM PKEY_Device_EnumeratorName}
  PKEY_Device_Security: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 25);
  {$EXTERNALSYM PKEY_Device_Security}
  PKEY_Device_SecuritySDS: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 26);
  {$EXTERNALSYM PKEY_Device_SecuritySDS}
  PKEY_Device_DevType: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 27);
  {$EXTERNALSYM PKEY_Device_DevType}
  PKEY_Device_Exclusive: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 28);
  {$EXTERNALSYM PKEY_Device_Exclusive}
  PKEY_Device_Characteristics: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 29);
  {$EXTERNALSYM PKEY_Device_Characteristics}
  PKEY_Device_Address: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 30);
  {$EXTERNALSYM PKEY_Device_Address}
  PKEY_Device_UINumberDescFormat: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 31);
  {$EXTERNALSYM PKEY_Device_UINumberDescFormat}
  PKEY_Device_PowerData: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 32);
  {$EXTERNALSYM PKEY_Device_PowerData}
  PKEY_Device_RemovalPolicy: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 33);
  {$EXTERNALSYM PKEY_Device_RemovalPolicy}
  PKEY_Device_RemovalPolicyDefault: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 34);
  {$EXTERNALSYM PKEY_Device_RemovalPolicyDefault}
  PKEY_Device_RemovalPolicyOverride: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 35);
  {$EXTERNALSYM PKEY_Device_RemovalPolicyOverride}
  PKEY_Device_InstallState: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 36);
  {$EXTERNALSYM PKEY_Device_InstallState}
  PKEY_Device_LocationPaths: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 37);
  {$EXTERNALSYM PKEY_Device_LocationPaths}
  PKEY_Device_BaseContainerId: TPropertyKey = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 38);
  {$EXTERNALSYM PKEY_Device_BaseContainerId}


{ Device properties }
{ These PKEYs correspond to a device's status and problem code }

  PKEY_Device_DevNodeStatus: TPropertyKey = (
    fmtid: '{4340A6C5-93FA-4706-972C-7B648008A5A7}'; pid: 2);
  {$EXTERNALSYM PKEY_Device_DevNodeStatus}
  PKEY_Device_ProblemCode: TPropertyKey = (
    fmtid: '{4340A6C5-93FA-4706-972C-7B648008A5A7}'; pid: 3);
  {$EXTERNALSYM PKEY_Device_ProblemCode}


{ Device properties }
{ These PKEYs correspond to device relations }

  PKEY_Device_EjectionRelations: TPropertyKey = (
    fmtid: '{4340A6C5-93FA-4706-972C-7B648008A5A7}'; pid: 4);
  {$EXTERNALSYM PKEY_Device_EjectionRelations}
  PKEY_Device_RemovalRelations: TPropertyKey = (
    fmtid: '{4340A6C5-93FA-4706-972C-7B648008A5A7}'; pid: 5);
  {$EXTERNALSYM PKEY_Device_RemovalRelations}
  PKEY_Device_PowerRelations: TPropertyKey = (
    fmtid: '{4340A6C5-93FA-4706-972C-7B648008A5A7}'; pid: 6);
  {$EXTERNALSYM PKEY_Device_PowerRelations}
  PKEY_Device_BusRelations: TPropertyKey = (
    fmtid: '{4340A6C5-93FA-4706-972C-7B648008A5A7}'; pid: 7);
  {$EXTERNALSYM PKEY_Device_BusRelations}
  PKEY_Device_Parent: TPropertyKey = (
    fmtid: '{4340A6C5-93FA-4706-972C-7B648008A5A7}'; pid: 8);
  {$EXTERNALSYM PKEY_Device_Parent}
  PKEY_Device_Children: TPropertyKey = (
    fmtid: '{4340A6C5-93FA-4706-972C-7B648008A5A7}'; pid: 9);
  {$EXTERNALSYM PKEY_Device_Children}
  PKEY_Device_Siblings: TPropertyKey = (
    fmtid: '{4340A6C5-93FA-4706-972C-7B648008A5A7}'; pid: 10);
  {$EXTERNALSYM PKEY_Device_Siblings}
  PKEY_Device_TransportRelations: TPropertyKey = (
    fmtid: '{4340A6C5-93FA-4706-972C-7B648008A5A7}'; pid: 11);
  {$EXTERNALSYM PKEY_Device_TransportRelations}

{ Other Device properties }

  PKEY_Device_Reported: TPropertyKey = (
    fmtid: '{80497100-8C73-48B9-AAD9-CE387E19C56E}'; pid: 2);
  {$EXTERNALSYM PKEY_Device_Reported}
  PKEY_Device_Legacy: TPropertyKey = (
    fmtid: '{80497100-8C73-48B9-AAD9-CE387E19C56E}'; pid: 3);
  {$EXTERNALSYM PKEY_Device_Legacy}
  PKEY_Device_InstanceId: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 256);
  {$EXTERNALSYM PKEY_Device_InstanceId}

  PKEY_Device_ContainerId: TPropertyKey = (
    fmtid: '{8C7ED206-3F8A-4827-B3AB-AE9E1FAEFC6C}'; pid: 2);
  {$EXTERNALSYM PKEY_Device_ContainerId}

  PKEY_Device_ModelId: TPropertyKey = (
    fmtid: '{80D81EA6-7473-4B0C-8216-EFC11A2C4C8B}'; pid: 2);
  {$EXTERNALSYM PKEY_Device_ModelId}

  PKEY_Device_FriendlyNameAttributes: TPropertyKey = (
    fmtid: '{80D81EA6-7473-4B0C-8216-EFC11A2C4C8B}'; pid: 3);
  {$EXTERNALSYM PKEY_Device_FriendlyNameAttributes}
  PKEY_Device_ManufacturerAttributes: TPropertyKey = (
    fmtid: '{80D81EA6-7473-4B0C-8216-EFC11A2C4C8B}'; pid: 4);
  {$EXTERNALSYM PKEY_Device_ManufacturerAttributes}

  PKEY_Device_PresenceNotForDevice: TPropertyKey = (
    fmtid: '{80D81EA6-7473-4B0C-8216-EFC11A2C4C8B}'; pid: 5);
  {$EXTERNALSYM PKEY_Device_PresenceNotForDevice}

  PKEY_Numa_Proximity_Domain: TPropertyKey = (
    fmtid: '{540B947E-8B40-45BC-A8A2-6A0B894CBDA2}'; pid: 1);
  {$EXTERNALSYM PKEY_Numa_Proximity_Domain}
  PKEY_Device_DHP_Rebalance_Policy: TPropertyKey = (
    fmtid: '{540B947E-8B40-45BC-A8A2-6A0B894CBDA2}'; pid: 2);
  {$EXTERNALSYM PKEY_Device_DHP_Rebalance_Policy}
  PKEY_Device_Numa_Node: TPropertyKey = (
    fmtid: '{540B947E-8B40-45BC-A8A2-6A0B894CBDA2}'; pid: 3);
  {$EXTERNALSYM PKEY_Device_Numa_Node}
  PKEY_Device_BusReportedDeviceDesc: TPropertyKey = (
    fmtid: '{540B947E-8B40-45BC-A8A2-6A0B894CBDA2}'; pid: 4);
  {$EXTERNALSYM PKEY_Device_BusReportedDeviceDesc}

  PKEY_Device_InstallInProgress: TPropertyKey = (
    fmtid: '{83DA6326-97A6-4088-9453-A1923F573B29}'; pid: 9);
  {$EXTERNALSYM PKEY_Device_InstallInProgress}

{ Device driver properties }

  PKEY_Device_DriverDate: TPropertyKey = (
    fmtid: '{A8B865DD-2E3D-4094-AD97-E593A70C75D6}'; pid: 2);
  {$EXTERNALSYM PKEY_Device_DriverDate}
  PKEY_Device_DriverVersion: TPropertyKey = (
    fmtid: '{A8B865DD-2E3D-4094-AD97-E593A70C75D6}'; pid: 3);
  {$EXTERNALSYM PKEY_Device_DriverVersion}
  PKEY_Device_DriverDesc: TPropertyKey = (
    fmtid: '{A8B865DD-2E3D-4094-AD97-E593A70C75D6}'; pid: 4);
  {$EXTERNALSYM PKEY_Device_DriverDesc}
  PKEY_Device_DriverInfPath: TPropertyKey = (
    fmtid: '{A8B865DD-2E3D-4094-AD97-E593A70C75D6}'; pid: 5);
  {$EXTERNALSYM PKEY_Device_DriverInfPath}
  PKEY_Device_DriverInfSection: TPropertyKey = (
    fmtid: '{A8B865DD-2E3D-4094-AD97-E593A70C75D6}'; pid: 6);
  {$EXTERNALSYM PKEY_Device_DriverInfSection}
  PKEY_Device_DriverInfSectionExt: TPropertyKey = (
    fmtid: '{A8B865DD-2E3D-4094-AD97-E593A70C75D6}'; pid: 7);
  {$EXTERNALSYM PKEY_Device_DriverInfSectionExt}
  PKEY_Device_MatchingDeviceId: TPropertyKey = (
    fmtid: '{A8B865DD-2E3D-4094-AD97-E593A70C75D6}'; pid: 8);
  {$EXTERNALSYM PKEY_Device_MatchingDeviceId}
  PKEY_Device_DriverProvider: TPropertyKey = (
    fmtid: '{A8B865DD-2E3D-4094-AD97-E593A70C75D6}'; pid: 9);
  {$EXTERNALSYM PKEY_Device_DriverProvider}
  PKEY_Device_DriverPropPageProvider: TPropertyKey = (
    fmtid: '{A8B865DD-2E3D-4094-AD97-E593A70C75D6}'; pid: 10);
  {$EXTERNALSYM PKEY_Device_DriverPropPageProvider}
  PKEY_Device_DriverCoInstallers: TPropertyKey = (
    fmtid: '{A8B865DD-2E3D-4094-AD97-E593A70C75D6}'; pid: 11);
  {$EXTERNALSYM PKEY_Device_DriverCoInstallers}
  PKEY_Device_ResourcePickerTags: TPropertyKey = (
    fmtid: '{A8B865DD-2E3D-4094-AD97-E593A70C75D6}'; pid: 12);
  {$EXTERNALSYM PKEY_Device_ResourcePickerTags}
  PKEY_Device_ResourcePickerExceptions: TPropertyKey = (
    fmtid: '{A8B865DD-2E3D-4094-AD97-E593A70C75D6}'; pid: 13);
  {$EXTERNALSYM PKEY_Device_ResourcePickerExceptions}
  PKEY_Device_DriverRank: TPropertyKey = (
    fmtid: '{A8B865DD-2E3D-4094-AD97-E593A70C75D6}'; pid: 14);
  {$EXTERNALSYM PKEY_Device_DriverRank}
  PKEY_Device_DriverLogoLevel: TPropertyKey = (
    fmtid: '{A8B865DD-2E3D-4094-AD97-E593A70C75D6}'; pid: 15);
  {$EXTERNALSYM PKEY_Device_DriverLogoLevel}
  PKEY_Device_NoConnectSound: TPropertyKey = (
    fmtid: '{A8B865DD-2E3D-4094-AD97-E593A70C75D6}'; pid: 17);
  {$EXTERNALSYM PKEY_Device_NoConnectSound}
  PKEY_Device_GenericDriverInstalled: TPropertyKey = (
    fmtid: '{A8B865DD-2E3D-4094-AD97-E593A70C75D6}'; pid: 18);
  {$EXTERNALSYM PKEY_Device_GenericDriverInstalled}
  PKEY_Device_AdditionalSoftwareRequested: TPropertyKey = (
    fmtid: '{A8B865DD-2E3D-4094-AD97-E593A70C75D6}'; pid: 19);
  {$EXTERNALSYM PKEY_Device_AdditionalSoftwareRequested}

{ Device safe-removal properties }

  PKEY_Device_SafeRemovalRequired: TPropertyKey = (
    fmtid: '{AFD97640-86A3-4210-B67C-289C41AABE55}'; pid: 2);
  {$EXTERNALSYM PKEY_Device_SafeRemovalRequired}
  PKEY_Device_SafeRemovalRequiredOverride: TPropertyKey = (
    fmtid: '{AFD97640-86A3-4210-B67C-289C41AABE55}'; pid: 3);
  {$EXTERNALSYM PKEY_Device_SafeRemovalRequiredOverride}

{ Device properties that were set by the driver package that was installed }
{ on the device. }

  PKEY_DrvPkg_Model: TPropertyKey = (
    fmtid: '{CF73BB51-3ABF-44A2-85E0-9A3DC7A12132}'; pid: 2);
  {$EXTERNALSYM PKEY_DrvPkg_Model}
  PKEY_DrvPkg_VendorWebSite: TPropertyKey = (
    fmtid: '{CF73BB51-3ABF-44A2-85E0-9A3DC7A12132}'; pid: 3);
  {$EXTERNALSYM PKEY_DrvPkg_VendorWebSite}
  PKEY_DrvPkg_DetailedDescription: TPropertyKey = (
    fmtid: '{CF73BB51-3ABF-44A2-85E0-9A3DC7A12132}'; pid: 4);
  {$EXTERNALSYM PKEY_DrvPkg_DetailedDescription}
  PKEY_DrvPkg_DocumentationLink: TPropertyKey = (
    fmtid: '{CF73BB51-3ABF-44A2-85E0-9A3DC7A12132}'; pid: 5);
  {$EXTERNALSYM PKEY_DrvPkg_DocumentationLink}
  PKEY_DrvPkg_Icon: TPropertyKey = (
    fmtid: '{CF73BB51-3ABF-44A2-85E0-9A3DC7A12132}'; pid: 6);
  {$EXTERNALSYM PKEY_DrvPkg_Icon}
  PKEY_DrvPkg_BrandingIcon: TPropertyKey = (
    fmtid: '{CF73BB51-3ABF-44A2-85E0-9A3DC7A12132}'; pid: 7);
  {$EXTERNALSYM PKEY_DrvPkg_BrandingIcon}

{ Device setup class properties }
{ These PKEYs correspond to the old setupapi SPCRP_XXX properties }

  PKEY_DeviceClass_UpperFilters: TPropertyKey = (
    fmtid: '{4321918B-F69E-470D-A5DE-4D88C75AD24B}'; pid: 19);
  {$EXTERNALSYM PKEY_DeviceClass_UpperFilters}
  PKEY_DeviceClass_LowerFilters: TPropertyKey = (
    fmtid: '{4321918B-F69E-470D-A5DE-4D88C75AD24B}'; pid: 20);
  {$EXTERNALSYM PKEY_DeviceClass_LowerFilters}
  PKEY_DeviceClass_Security: TPropertyKey = (
    fmtid: '{4321918B-F69E-470D-A5DE-4D88C75AD24B}'; pid: 25);
  {$EXTERNALSYM PKEY_DeviceClass_Security}
  PKEY_DeviceClass_SecuritySDS: TPropertyKey = (
    fmtid: '{4321918B-F69E-470D-A5DE-4D88C75AD24B}'; pid: 26);
  {$EXTERNALSYM PKEY_DeviceClass_SecuritySDS}
  PKEY_DeviceClass_DevType: TPropertyKey = (
    fmtid: '{4321918B-F69E-470D-A5DE-4D88C75AD24B}'; pid: 27);
  {$EXTERNALSYM PKEY_DeviceClass_DevType}
  PKEY_DeviceClass_Exclusive: TPropertyKey = (
    fmtid: '{4321918B-F69E-470D-A5DE-4D88C75AD24B}'; pid: 28);
  {$EXTERNALSYM PKEY_DeviceClass_Exclusive}
  PKEY_DeviceClass_Characteristics: TPropertyKey = (
    fmtid: '{4321918B-F69E-470D-A5DE-4D88C75AD24B}'; pid: 29);
  {$EXTERNALSYM PKEY_DeviceClass_Characteristics}

{ Device setup class properties }
{ These PKEYs correspond to registry values under the device class GUID key }

  PKEY_DeviceClass_Name: TPropertyKey = (
    fmtid: '{259ABFFC-50A7-47CE-AF08-68C9A7D73366}'; pid: 2);
  {$EXTERNALSYM PKEY_DeviceClass_Name}
  PKEY_DeviceClass_ClassName: TPropertyKey = (
    fmtid: '{259ABFFC-50A7-47CE-AF08-68C9A7D73366}'; pid: 3);
  {$EXTERNALSYM PKEY_DeviceClass_ClassName}
  PKEY_DeviceClass_Icon: TPropertyKey = (
    fmtid: '{259ABFFC-50A7-47CE-AF08-68C9A7D73366}'; pid: 4);
  {$EXTERNALSYM PKEY_DeviceClass_Icon}
  PKEY_DeviceClass_ClassInstaller: TPropertyKey = (
    fmtid: '{259ABFFC-50A7-47CE-AF08-68C9A7D73366}'; pid: 5);
  {$EXTERNALSYM PKEY_DeviceClass_ClassInstaller}
  PKEY_DeviceClass_PropPageProvider: TPropertyKey = (
    fmtid: '{259ABFFC-50A7-47CE-AF08-68C9A7D73366}'; pid: 6);
  {$EXTERNALSYM PKEY_DeviceClass_PropPageProvider}
  PKEY_DeviceClass_NoInstallClass: TPropertyKey = (
    fmtid: '{259ABFFC-50A7-47CE-AF08-68C9A7D73366}'; pid: 7);
  {$EXTERNALSYM PKEY_DeviceClass_NoInstallClass}
  PKEY_DeviceClass_NoDisplayClass: TPropertyKey = (
    fmtid: '{259ABFFC-50A7-47CE-AF08-68C9A7D73366}'; pid: 8);
  {$EXTERNALSYM PKEY_DeviceClass_NoDisplayClass}
  PKEY_DeviceClass_SilentInstall: TPropertyKey = (
    fmtid: '{259ABFFC-50A7-47CE-AF08-68C9A7D73366}'; pid: 9);
  {$EXTERNALSYM PKEY_DeviceClass_SilentInstall}
  PKEY_DeviceClass_NoUseClass: TPropertyKey = (
    fmtid: '{259ABFFC-50A7-47CE-AF08-68C9A7D73366}'; pid: 10);
  {$EXTERNALSYM PKEY_DeviceClass_NoUseClass}
  PKEY_DeviceClass_DefaultService: TPropertyKey = (
    fmtid: '{259ABFFC-50A7-47CE-AF08-68C9A7D73366}'; pid: 11);
  {$EXTERNALSYM PKEY_DeviceClass_DefaultService}
  PKEY_DeviceClass_IconPath: TPropertyKey = (
    fmtid: '{259ABFFC-50A7-47CE-AF08-68C9A7D73366}'; pid: 12);
  {$EXTERNALSYM PKEY_DeviceClass_IconPath}

{ Other Device setup class properties }

  PKEY_DeviceClass_ClassCoInstallers: TPropertyKey = (
    fmtid: '{713D1703-A2E2-49F5-9214-56472EF3DA5C}'; pid: 2);
  {$EXTERNALSYM PKEY_DeviceClass_ClassCoInstallers}

{ Device interface properties }

  PKEY_DeviceInterface_FriendlyName: TPropertyKey = (
    fmtid: '{026E516E-B814-414B-83CD-856D6FEF4822}'; pid: 2);
  {$EXTERNALSYM PKEY_DeviceInterface_FriendlyName}
  PKEY_DeviceInterface_Enabled: TPropertyKey = (
    fmtid: '{026E516E-B814-414B-83CD-856D6FEF4822}'; pid: 3);
  {$EXTERNALSYM PKEY_DeviceInterface_Enabled}
  PKEY_DeviceInterface_ClassGuid: TPropertyKey = (
    fmtid: '{026E516E-B814-414B-83CD-856D6FEF4822}'; pid: 4);
  {$EXTERNALSYM PKEY_DeviceInterface_ClassGuid}

{ Device interface class properties }

  PKEY_DeviceInterfaceClass_DefaultInterface: TPropertyKey = (
    fmtid: '{14C83A99-0B3F-44B7-BE4C-A178D3990564}'; pid: 2);
  {$EXTERNALSYM PKEY_DeviceInterfaceClass_DefaultInterface}

// functiondiscoverykeys.h

{  Copyright (c) Microsoft Corporation. All rights reserved. }

{ 08c0c253-a154-4746-9005-82de5317148b }
const
  PKEY_FunctionInstance: TPropertyKey = (
    fmtid: '{08C0C253-A154-4746-9005-82DE5317148B}'; pid: 1);
  {$EXTERNALSYM PKEY_FunctionInstance}

  FMTID_FD: TGUID = '{904B03A2-471D-423C-A584-F3483238A146}';
  {$EXTERNALSYM FMTID_FD}
  PKEY_FD_Visibility: TPropertyKey = (
    fmtid: '{904B03A2-471D-423C-A584-F3483238A146}'; pid: 1);
  {$EXTERNALSYM PKEY_FD_Visibility}
  FD_Visibility_Default = 0;
  {$EXTERNALSYM FD_Visibility_Default}
  FD_Visibility_Hidden = 1;
  {$EXTERNALSYM FD_Visibility_Hidden}

  FMTID_Device: TGUID = '{78C34FC8-104A-4ACA-9EA4-524D52996E57}';
  {$EXTERNALSYM FMTID_Device}

  PKEY_Device_NotPresent: TPropertyKey = (
    fmtid: '{904B03A2-471D-423C-A584-F3483238A146}'; pid: 2);
  {$EXTERNALSYM PKEY_Device_NotPresent}
  PKEY_Device_QueueSize: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 36);
  {$EXTERNALSYM PKEY_Device_QueueSize}
  PKEY_Device_Status: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 37);
  {$EXTERNALSYM PKEY_Device_Status}
  PKEY_Device_Comment: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 38);
  {$EXTERNALSYM PKEY_Device_Comment}
  PKEY_Device_Model: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 39);
  {$EXTERNALSYM PKEY_Device_Model}

  FMTID_DeviceInterface: TGUID = '{53808008-07BB-4661-BC3C-B5953E708560}';
  {$EXTERNALSYM FMTID_DeviceInterface}

  PKEY_DeviceInterface_DevicePath: TPropertyKey = (
    fmtid: '{53808008-07BB-4661-BC3C-B5953E708560}'; pid: 1);
  {$EXTERNALSYM PKEY_DeviceInterface_DevicePath}

  PKEY_DeviceDisplay_Address: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 51);
  {$EXTERNALSYM PKEY_DeviceDisplay_Address}
  PKEY_DeviceDisplay_DiscoveryMethod: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 52);
  {$EXTERNALSYM PKEY_DeviceDisplay_DiscoveryMethod}
  PKEY_DeviceDisplay_IsEncrypted: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 53);
  {$EXTERNALSYM PKEY_DeviceDisplay_IsEncrypted}
  PKEY_DeviceDisplay_IsAuthenticated: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 54);
  {$EXTERNALSYM PKEY_DeviceDisplay_IsAuthenticated}
  PKEY_DeviceDisplay_IsConnected: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 55);
  {$EXTERNALSYM PKEY_DeviceDisplay_IsConnected}
  PKEY_DeviceDisplay_IsPaired: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 56);
  {$EXTERNALSYM PKEY_DeviceDisplay_IsPaired}
  PKEY_DeviceDisplay_Icon: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 57);
  {$EXTERNALSYM PKEY_DeviceDisplay_Icon}
  PKEY_DeviceDisplay_Version: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 65);
  {$EXTERNALSYM PKEY_DeviceDisplay_Version}
  PKEY_DeviceDisplay_Last_Seen: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 66);
  {$EXTERNALSYM PKEY_DeviceDisplay_Last_Seen}
  PKEY_DeviceDisplay_Last_Connected: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 67);
  {$EXTERNALSYM PKEY_DeviceDisplay_Last_Connected}
  PKEY_DeviceDisplay_IsShowInDisconnectedState: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 68);
  {$EXTERNALSYM PKEY_DeviceDisplay_IsShowInDisconnectedState}
  PKEY_DeviceDisplay_IsLocalMachine: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 70);
  {$EXTERNALSYM PKEY_DeviceDisplay_IsLocalMachine}
  PKEY_DeviceDisplay_MetadataPath: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 71);
  {$EXTERNALSYM PKEY_DeviceDisplay_MetadataPath}
  PKEY_DeviceDisplay_IsMetadataSearchInProgress: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 72);
  {$EXTERNALSYM PKEY_DeviceDisplay_IsMetadataSearchInProgress}
  PKEY_DeviceDisplay_MetadataChecksum: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 73);
  {$EXTERNALSYM PKEY_DeviceDisplay_MetadataChecksum}
  PKEY_DeviceDisplay_IsNotInterestingForDisplay: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 74);
  {$EXTERNALSYM PKEY_DeviceDisplay_IsNotInterestingForDisplay}
  PKEY_DeviceDisplay_LaunchDeviceStageOnDeviceConnect: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 76);
  {$EXTERNALSYM PKEY_DeviceDisplay_LaunchDeviceStageOnDeviceConnect}
  PKEY_DeviceDisplay_LaunchDeviceStageFromExplorer: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 77);
  {$EXTERNALSYM PKEY_DeviceDisplay_LaunchDeviceStageFromExplorer}
  PKEY_DeviceDisplay_BaselineExperienceId: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 78);
  {$EXTERNALSYM PKEY_DeviceDisplay_BaselineExperienceId}
  PKEY_DeviceDisplay_IsDeviceUniquelyIdentifiable: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 79);
  {$EXTERNALSYM PKEY_DeviceDisplay_IsDeviceUniquelyIdentifiable}
  PKEY_DeviceDisplay_AssociationArray: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 80);
  {$EXTERNALSYM PKEY_DeviceDisplay_AssociationArray}
  PKEY_DeviceDisplay_DeviceDescription1: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 81);
  {$EXTERNALSYM PKEY_DeviceDisplay_DeviceDescription1}
  PKEY_DeviceDisplay_DeviceDescription2: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 82);
  {$EXTERNALSYM PKEY_DeviceDisplay_DeviceDescription2}
  PKEY_DeviceDisplay_IsNotWorkingProperly: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 83);
  {$EXTERNALSYM PKEY_DeviceDisplay_IsNotWorkingProperly}
  PKEY_DeviceDisplay_IsSharedDevice: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 84);
  {$EXTERNALSYM PKEY_DeviceDisplay_IsSharedDevice}
  PKEY_DeviceDisplay_IsNetworkDevice: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 85);
  {$EXTERNALSYM PKEY_DeviceDisplay_IsNetworkDevice}
  PKEY_DeviceDisplay_IsDefaultDevice: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 86);
  {$EXTERNALSYM PKEY_DeviceDisplay_IsDefaultDevice}
  PKEY_DeviceDisplay_MetadataCabinet: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 87);
  {$EXTERNALSYM PKEY_DeviceDisplay_MetadataCabinet}
  PKEY_DeviceDisplay_RequiresPairingElevation: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 88);
  {$EXTERNALSYM PKEY_DeviceDisplay_RequiresPairingElevation}
  PKEY_DeviceDisplay_ExperienceId: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 89);
  {$EXTERNALSYM PKEY_DeviceDisplay_ExperienceId}
  PKEY_DeviceDisplay_Category: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 90);
  {$EXTERNALSYM PKEY_DeviceDisplay_Category}
  PKEY_DeviceDisplay_Category_Desc_Singular: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 91);
  {$EXTERNALSYM PKEY_DeviceDisplay_Category_Desc_Singular}
  PKEY_DeviceDisplay_Category_Desc_Plural: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 92);
  {$EXTERNALSYM PKEY_DeviceDisplay_Category_Desc_Plural}
  PKEY_DeviceDisplay_Category_Icon: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 93);
  {$EXTERNALSYM PKEY_DeviceDisplay_Category_Icon}
  PKEY_DeviceDisplay_CategoryGroup_Desc: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 94);
  {$EXTERNALSYM PKEY_DeviceDisplay_CategoryGroup_Desc}
  PKEY_DeviceDisplay_CategoryGroup_Icon: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 95);
  {$EXTERNALSYM PKEY_DeviceDisplay_CategoryGroup_Icon}
  PKEY_DeviceDisplay_PrimaryCategory: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 97);
  {$EXTERNALSYM PKEY_DeviceDisplay_PrimaryCategory}
  PKEY_DeviceDisplay_UnpairUninstall: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 98);
  {$EXTERNALSYM PKEY_DeviceDisplay_UnpairUninstall}
  PKEY_DeviceDisplay_RequiresUninstallElevation: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 99);
  {$EXTERNALSYM PKEY_DeviceDisplay_RequiresUninstallElevation}
  PKEY_DeviceDisplay_DeviceFunctionSubRank: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 100);
  {$EXTERNALSYM PKEY_DeviceDisplay_DeviceFunctionSubRank}
  PKEY_DeviceDisplay_AlwaysShowDeviceAsConnected: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 101);
  {$EXTERNALSYM PKEY_DeviceDisplay_AlwaysShowDeviceAsConnected}

  PKEY_DeviceDisplay_FriendlyName: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 12288);
  {$EXTERNALSYM PKEY_DeviceDisplay_FriendlyName}
  PKEY_DeviceDisplay_Manufacturer: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 8192);
  {$EXTERNALSYM PKEY_DeviceDisplay_Manufacturer}
  PKEY_DeviceDisplay_ModelName: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 8194);
  {$EXTERNALSYM PKEY_DeviceDisplay_ModelName}
  PKEY_DeviceDisplay_ModelNumber: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 8195);
  {$EXTERNALSYM PKEY_DeviceDisplay_ModelNumber}

  PKEY_DeviceDisplay_InstallInProgress: TPropertyKey = (
    fmtid: '{83DA6326-97A6-4088-9453-A1923F573B29}'; pid: 9);
  {$EXTERNALSYM PKEY_DeviceDisplay_InstallInProgress}

  FMTID_Pairing: TGUID = '{8807CAE6-7DB6-4F10-8EE4-435EAA1392BC}';
  {$EXTERNALSYM FMTID_Pairing}
  PKEY_Pairing_ListItemText: TPropertyKey = (
    fmtid: '{8807CAE6-7DB6-4F10-8EE4-435EAA1392BC}'; pid: 1);
  {$EXTERNALSYM PKEY_Pairing_ListItemText}
  PKEY_Pairing_ListItemDescription: TPropertyKey = (
    fmtid: '{8807CAE6-7DB6-4F10-8EE4-435EAA1392BC}'; pid: 2);
  {$EXTERNALSYM PKEY_Pairing_ListItemDescription}
  PKEY_Pairing_ListItemIcon: TPropertyKey = (
    fmtid: '{8807CAE6-7DB6-4F10-8EE4-435EAA1392BC}'; pid: 3);
  {$EXTERNALSYM PKEY_Pairing_ListItemIcon}
  PKEY_Pairing_ListItemDefault: TPropertyKey = (
    fmtid: '{8807CAE6-7DB6-4F10-8EE4-435EAA1392BC}'; pid: 4);
  {$EXTERNALSYM PKEY_Pairing_ListItemDefault}
  PKEY_Pairing_IsWifiOnlyDevice: TPropertyKey = (
    fmtid: '{8807CAE6-7DB6-4F10-8EE4-435EAA1392BC}'; pid: 16);
  {$EXTERNALSYM PKEY_Pairing_IsWifiOnlyDevice}

{ DiscoveryMethod values }
  DEVICEDISPLAY_DISCOVERYMETHOD_BLUETOOTH = 'Bluetooth';
  {$EXTERNALSYM DEVICEDISPLAY_DISCOVERYMETHOD_BLUETOOTH}
  DEVICEDISPLAY_DISCOVERYMETHOD_NETBIOS = 'NetBIOS';
  {$EXTERNALSYM DEVICEDISPLAY_DISCOVERYMETHOD_NETBIOS}
  DEVICEDISPLAY_DISCOVERYMETHOD_PNP = 'PnP';
  {$EXTERNALSYM DEVICEDISPLAY_DISCOVERYMETHOD_PNP}
  DEVICEDISPLAY_DISCOVERYMETHOD_UPNP = 'UPnP';
  {$EXTERNALSYM DEVICEDISPLAY_DISCOVERYMETHOD_UPNP}
  DEVICEDISPLAY_DISCOVERYMETHOD_WSD = 'WSD';
  {$EXTERNALSYM DEVICEDISPLAY_DISCOVERYMETHOD_WSD}
  DEVICEDISPLAY_DISCOVERYMETHOD_WUSB = 'WUSB';
  {$EXTERNALSYM DEVICEDISPLAY_DISCOVERYMETHOD_WUSB}

{  Name:     System.Device.BIOSVersion -- PKEY_Device_BIOSVersion }
{  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)  Legacy code may treat this as VT_BSTR. }
{  FormatID: EAEE7F1D-6A33-44D1-9441-5F46DEF23198, 9 }
  PKEY_Device_BIOSVersion: TPropertyKey = (
    fmtid: '{EAEE7F1D-6A33-44D1-9441-5F46DEF23198}'; pid: 9);
  {$EXTERNALSYM PKEY_Device_BIOSVersion}

  PKEY_Write_Time: TPropertyKey = (
    fmtid: '{F53B7E1C-77E0-4450-8C5F-A76CC7FDE058}'; pid: 256);
  {$EXTERNALSYM PKEY_Write_Time}
  PKEY_Create_Time: TPropertyKey = (
    fmtid: '{F53B7E1C-77E0-4450-8C5F-A76CC7FDE058}'; pid: 257);
  {$EXTERNALSYM PKEY_Create_Time}

{$ifdef FD_XP}
  PKEY_Device_InstanceId: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 256);
  {$EXTERNALSYM PKEY_Device_InstanceId}
{$endif}
  PKEY_Device_Interface: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 257);
  {$EXTERNALSYM PKEY_Device_Interface}

  PKEY_ExposedIIDs: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 12290);
  {$EXTERNALSYM PKEY_ExposedIIDs}
  PKEY_ExposedCLSIDs: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 12291);
  {$EXTERNALSYM PKEY_ExposedCLSIDs}
  PKEY_InstanceValidatorClsid: TPropertyKey = (
    fmtid: '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid: 12292);
  {$EXTERNALSYM PKEY_InstanceValidatorClsid}

  FMTID_WSD: TGUID = '{92506491-FF95-4724-A05A-5B81885A7C92}';
  {$EXTERNALSYM FMTID_WSD}

  PKEY_WSD_AddressURI: TPropertyKey = (
    fmtid: '{92506491-FF95-4724-A05A-5B81885A7C92}'; pid: 4096);
  {$EXTERNALSYM PKEY_WSD_AddressURI}
  PKEY_WSD_Types: TPropertyKey = (
    fmtid: '{92506491-FF95-4724-A05A-5B81885A7C92}'; pid: 4097);
  {$EXTERNALSYM PKEY_WSD_Types}
  PKEY_WSD_Scopes: TPropertyKey = (
    fmtid: '{92506491-FF95-4724-A05A-5B81885A7C92}'; pid: 4098);
  {$EXTERNALSYM PKEY_WSD_Scopes}
  PKEY_WSD_MetadataVersion: TPropertyKey = (
    fmtid: '{92506491-FF95-4724-A05A-5B81885A7C92}'; pid: 4099);
  {$EXTERNALSYM PKEY_WSD_MetadataVersion}
  PKEY_WSD_AppSeqInstanceID: TPropertyKey = (
    fmtid: '{92506491-FF95-4724-A05A-5B81885A7C92}'; pid: 4100);
  {$EXTERNALSYM PKEY_WSD_AppSeqInstanceID}
  PKEY_WSD_AppSeqSessionID: TPropertyKey = (
    fmtid: '{92506491-FF95-4724-A05A-5B81885A7C92}'; pid: 4101);
  {$EXTERNALSYM PKEY_WSD_AppSeqSessionID}
  PKEY_WSD_AppSeqMessageNumber: TPropertyKey = (
    fmtid: '{92506491-FF95-4724-A05A-5B81885A7C92}'; pid: 4102);
  {$EXTERNALSYM PKEY_WSD_AppSeqMessageNumber}
  PKEY_WSD_XAddrs: TPropertyKey = (
    fmtid: '{92506491-FF95-4724-A05A-5B81885A7C92}'; pid: 8192);
  {$EXTERNALSYM PKEY_WSD_XAddrs}

  PKEY_WSD_MetadataClean: TPropertyKey = (
    fmtid: '{92506491-FF95-4724-A05A-5B81885A7C92}'; pid: 1);
  {$EXTERNALSYM PKEY_WSD_MetadataClean}
  PKEY_WSD_ServiceInfo: TPropertyKey = (
    fmtid: '{92506491-FF95-4724-A05A-5B81885A7C92}'; pid: 2);
  {$EXTERNALSYM PKEY_WSD_ServiceInfo}

  PKEY_PUBSVCS_TYPE: TPropertyKey = (
    fmtid: '{F1B88AD3-109C-4FD2-BA3F-535A765F82F4}'; pid: 20481);
  {$EXTERNALSYM PKEY_PUBSVCS_TYPE}
  PKEY_PUBSVCS_SCOPE: TPropertyKey = (
    fmtid: '{2AE2B567-EECB-4A3E-B753-54C725494366}'; pid: 20482);
  {$EXTERNALSYM PKEY_PUBSVCS_SCOPE}
  PKEY_PUBSVCS_METADATA: TPropertyKey = (
    fmtid: '{63C6D5B8-F73A-4ACA-967E-0CC787E0B559}'; pid: 20483);
  {$EXTERNALSYM PKEY_PUBSVCS_METADATA}
  PKEY_PUBSVCS_METADATA_VERSION: TPropertyKey = (
    fmtid: '{C0C96C15-1823-4E5B-9348-E82519923F04}'; pid: 20484);
  {$EXTERNALSYM PKEY_PUBSVCS_METADATA_VERSION}
  PKEY_PUBSVCS_NETWORK_PROFILES_ALLOWED: TPropertyKey = (
    fmtid: '{63C6D5B8-F73A-4ACA-967E-0CC787E0B559}'; pid: 20485);
  {$EXTERNALSYM PKEY_PUBSVCS_NETWORK_PROFILES_ALLOWED}
  PKEY_PUBSVCS_NETWORK_PROFILES_DENIED: TPropertyKey = (
    fmtid: '{63C6D5B8-F73A-4ACA-967E-0CC787E0B559}'; pid: 20486);
  {$EXTERNALSYM PKEY_PUBSVCS_NETWORK_PROFILES_DENIED}
  PKEY_PUBSVCS_NETWORK_PROFILES_DEFAULT: TPropertyKey = (
    fmtid: '{63C6D5B8-F73A-4ACA-967E-0CC787E0B559}'; pid: 20487);
  {$EXTERNALSYM PKEY_PUBSVCS_NETWORK_PROFILES_DEFAULT}

  FMTID_PNPX: TGUID = '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}';
  {$EXTERNALSYM FMTID_PNPX}
        { from Discovery messages }
  PKEY_PNPX_GlobalIdentity: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 4096);
  {$EXTERNALSYM PKEY_PNPX_GlobalIdentity}
  PKEY_PNPX_Types: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 4097);
  {$EXTERNALSYM PKEY_PNPX_Types}
  PKEY_PNPX_Scopes: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 4098);
  {$EXTERNALSYM PKEY_PNPX_Scopes}
  PKEY_PNPX_XAddrs: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 4099);
  {$EXTERNALSYM PKEY_PNPX_XAddrs}
  PKEY_PNPX_MetadataVersion: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 4100);
  {$EXTERNALSYM PKEY_PNPX_MetadataVersion}
  PKEY_PNPX_ID: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 4101);
  {$EXTERNALSYM PKEY_PNPX_ID}

        { for Directed Discovery }
  PKEY_PNPX_RemoteAddress: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 4102);
  {$EXTERNALSYM PKEY_PNPX_RemoteAddress}
        { for installable ssdp root devices }
  PKEY_PNPX_RootProxy: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 4103);
  {$EXTERNALSYM PKEY_PNPX_RootProxy}

        { from ThisModel metadata }
  PKEY_PNPX_Manufacturer: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 8192) deprecated 'Please use PKEY_DeviceDisplay_Manufacturer';{ Deprecated! Please use PKEY_DeviceDisplay_Manufacturer }
  {$EXTERNALSYM PKEY_PNPX_Manufacturer}
  PKEY_PNPX_ManufacturerUrl: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 8193);
  {$EXTERNALSYM PKEY_PNPX_ManufacturerUrl}
  PKEY_PNPX_ModelName: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 8194) deprecated 'Please use PKEY_DeviceDisplay_ModelName'; { Deprecated! Please use PKEY_DeviceDisplay_ModelName }
  {$EXTERNALSYM PKEY_PNPX_ModelName}
  PKEY_PNPX_ModelNumber: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 8195) deprecated 'Please use PKEY_DeviceDisplayModelNumber'; { Depricated! Please use PKEY_DeviceDisplayModelNumber }
  {$EXTERNALSYM PKEY_PNPX_ModelNumber}
  PKEY_PNPX_ModelUrl: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 8196);
  {$EXTERNALSYM PKEY_PNPX_ModelUrl}
  PKEY_PNPX_Upc: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 8197);
  {$EXTERNALSYM PKEY_PNPX_Upc}
  PKEY_PNPX_PresentationUrl: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 8198);
  {$EXTERNALSYM PKEY_PNPX_PresentationUrl}
        { from ThisDevice metadata }
  PKEY_PNPX_FriendlyName: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 12288) deprecated 'Please use PKEY_DeviceDisplay_Name'; { Deprecated! Please use PKEY_DeviceDisplay_Name }
  {$EXTERNALSYM PKEY_PNPX_FriendlyName}
  PKEY_PNPX_FirmwareVersion: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 12289);
  {$EXTERNALSYM PKEY_PNPX_FirmwareVersion}
  PKEY_PNPX_SerialNumber: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 12290);
  {$EXTERNALSYM PKEY_PNPX_SerialNumber}
  PKEY_PNPX_DeviceCategory: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 12292);
  {$EXTERNALSYM PKEY_PNPX_DeviceCategory}

    { for secure devices }
  PKEY_PNPX_SecureChannel: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 28673);
  {$EXTERNALSYM PKEY_PNPX_SecureChannel}
  PKEY_PNPX_CompactSignature: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 28674);
  {$EXTERNALSYM PKEY_PNPX_CompactSignature}


        { DeviceCategory values }
  PNPX_DEVICECATEGORY_COMPUTER = 'Computers';
  {$EXTERNALSYM PNPX_DEVICECATEGORY_COMPUTER}
  PNPX_DEVICECATEGORY_INPUTDEVICE = 'Input';
  {$EXTERNALSYM PNPX_DEVICECATEGORY_INPUTDEVICE}
  PNPX_DEVICECATEGORY_PRINTER = 'Printers';
  {$EXTERNALSYM PNPX_DEVICECATEGORY_PRINTER}
  PNPX_DEVICECATEGORY_SCANNER = 'Scanners';
  {$EXTERNALSYM PNPX_DEVICECATEGORY_SCANNER}
  PNPX_DEVICECATEGORY_FAX = 'FAX';
  {$EXTERNALSYM PNPX_DEVICECATEGORY_FAX}
  PNPX_DEVICECATEGORY_MFP = 'MFP';
  {$EXTERNALSYM PNPX_DEVICECATEGORY_MFP}
  PNPX_DEVICECATEGORY_CAMERA = 'Cameras';
  {$EXTERNALSYM PNPX_DEVICECATEGORY_CAMERA}
  PNPX_DEVICECATEGORY_STORAGE = 'Storage';
  {$EXTERNALSYM PNPX_DEVICECATEGORY_STORAGE}
  PNPX_DEVICECATEGORY_NETWORK_INFRASTRUCTURE = 'NetworkInfrastructure';
  {$EXTERNALSYM PNPX_DEVICECATEGORY_NETWORK_INFRASTRUCTURE}
  PNPX_DEVICECATEGORY_DISPLAYS = 'Displays';
  {$EXTERNALSYM PNPX_DEVICECATEGORY_DISPLAYS}
  PNPX_DEVICECATEGORY_MULTIMEDIA_DEVICE = 'MediaDevices';
  {$EXTERNALSYM PNPX_DEVICECATEGORY_MULTIMEDIA_DEVICE}
  PNPX_DEVICECATEGORY_GAMING_DEVICE = 'Gaming';
  {$EXTERNALSYM PNPX_DEVICECATEGORY_GAMING_DEVICE}
  PNPX_DEVICECATEGORY_TELEPHONE = 'Phones';
  {$EXTERNALSYM PNPX_DEVICECATEGORY_TELEPHONE}
  PNPX_DEVICECATEGORY_HOME_AUTOMATION_SYSTEM = 'HomeAutomation';
  {$EXTERNALSYM PNPX_DEVICECATEGORY_HOME_AUTOMATION_SYSTEM}
  PNPX_DEVICECATEGORY_HOME_SECURITY_SYSTEM = 'HomeSecurity';
  {$EXTERNALSYM PNPX_DEVICECATEGORY_HOME_SECURITY_SYSTEM}
  PNPX_DEVICECATEGORY_OTHER = 'Other';
  {$EXTERNALSYM PNPX_DEVICECATEGORY_OTHER}

  PKEY_PNPX_DeviceCategory_Desc: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 12293);
  {$EXTERNALSYM PKEY_PNPX_DeviceCategory_Desc}
  PKEY_PNPX_Category_Desc_NonPlural: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 12304);
  {$EXTERNALSYM PKEY_PNPX_Category_Desc_NonPlural}

  PKEY_PNPX_PhysicalAddress: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 12294);
  {$EXTERNALSYM PKEY_PNPX_PhysicalAddress}
  PKEY_PNPX_NetworkInterfaceLuid: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 12295);
  {$EXTERNALSYM PKEY_PNPX_NetworkInterfaceLuid}
  PKEY_PNPX_NetworkInterfaceGuid: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 12296);
  {$EXTERNALSYM PKEY_PNPX_NetworkInterfaceGuid}
  PKEY_PNPX_IpAddress: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 12297);
  {$EXTERNALSYM PKEY_PNPX_IpAddress}
        { from Relationship metadata }
  PKEY_PNPX_ServiceAddress: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 16384);
  {$EXTERNALSYM PKEY_PNPX_ServiceAddress}
  PKEY_PNPX_ServiceId: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 16385);
  {$EXTERNALSYM PKEY_PNPX_ServiceId}
  PKEY_PNPX_ServiceTypes: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 16386);
  {$EXTERNALSYM PKEY_PNPX_ServiceTypes}
        { Association DB PKEYs }
  PKEY_PNPX_Devnode: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 1);
  {$EXTERNALSYM PKEY_PNPX_Devnode}
  PKEY_PNPX_AssociationState: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 2);
  {$EXTERNALSYM PKEY_PNPX_AssociationState}
  PKEY_PNPX_AssociatedInstanceId: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 3);
  {$EXTERNALSYM PKEY_PNPX_AssociatedInstanceId}
  PKEY_PNPX_LastNotificationTime: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 4);
  {$EXTERNALSYM PKEY_PNPX_LastNotificationTime}
        { for Computer Discovery }
  PKEY_PNPX_DomainName: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 20480);
  {$EXTERNALSYM PKEY_PNPX_DomainName}
{ Use PKEY_ComputerName (propkey.h) DEFINE_PROPERTYKEY(PKEY_PNPX_MachineName, 0x656A3BB3, 0xECC0, 0x43FD, 0x84, 0x77, 0x4A, 0xE0, 0x40, 0x4A, 0x96, 0xCD, 0x00005001);   // VT_LPWSTR }
  PKEY_PNPX_ShareName: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 20482);
  {$EXTERNALSYM PKEY_PNPX_ShareName}

    { SSDP Provider custom properties }
  PKEY_SSDP_AltLocationInfo: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 24576);
  {$EXTERNALSYM PKEY_SSDP_AltLocationInfo}
  PKEY_SSDP_DevLifeTime: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 24577);
  {$EXTERNALSYM PKEY_SSDP_DevLifeTime}
  PKEY_SSDP_NetworkInterface: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 24578);
  {$EXTERNALSYM PKEY_SSDP_NetworkInterface}

  FMTID_PNPXDynamicProperty: TGUID = '{4FC5077E-B686-44BE-93E3-86CAFE368CCD}';
  {$EXTERNALSYM FMTID_PNPXDynamicProperty}

  PKEY_PNPX_Installable: TPropertyKey = (
    fmtid: '{4FC5077E-B686-44BE-93E3-86CAFE368CCD}'; pid: 1);
  {$EXTERNALSYM PKEY_PNPX_Installable}
  PKEY_PNPX_Associated: TPropertyKey = (
    fmtid: '{4FC5077E-B686-44BE-93E3-86CAFE368CCD}'; pid: 2);
  {$EXTERNALSYM PKEY_PNPX_Associated}
{ PKEY_PNPX_Installed is deprecated this PKEY really represents Associated state }
  PKEY_PNPX_Installed: TPropertyKey = (
    fmtid: '{4FC5077E-B686-44BE-93E3-86CAFE368CCD}'; pid: 2) deprecated 'Please use PKEY_PNPX_Associated';   { Deprecated! Please use PKEY_PNPX_Associated }
  {$EXTERNALSYM PKEY_PNPX_Installed}
  PKEY_PNPX_CompatibleTypes: TPropertyKey = (
    fmtid: '{4FC5077E-B686-44BE-93E3-86CAFE368CCD}'; pid: 3);
  {$EXTERNALSYM PKEY_PNPX_CompatibleTypes}
  PKEY_PNPX_InstallState: TPropertyKey = (
    fmtid: '{4FC5077E-B686-44BE-93E3-86CAFE368CCD}'; pid: 4);
  {$EXTERNALSYM PKEY_PNPX_InstallState}
  PNPX_INSTALLSTATE_NOTINSTALLED = 0;   { vector length = 1 }
  {$EXTERNALSYM PNPX_INSTALLSTATE_NOTINSTALLED}
  PNPX_INSTALLSTATE_INSTALLED = 1;      { vector length = 3, CM_Get_DevNode_Status in 2nd and 3rd elements }
  {$EXTERNALSYM PNPX_INSTALLSTATE_INSTALLED}
  PNPX_INSTALLSTATE_INSTALLING = 2;     { vector length = 1 or 3, CM_Get_DevNode_Status in 2nd and 3rd elements if available }
  {$EXTERNALSYM PNPX_INSTALLSTATE_INSTALLING}
  PNPX_INSTALLSTATE_FAILED = 3;         { vector length = 3, CM_Get_DevNode_Status in 2nd and 3rd elements }
  {$EXTERNALSYM PNPX_INSTALLSTATE_FAILED}

{ Other }
  PKEY_PNPX_Removable: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 28672);
  {$EXTERNALSYM PKEY_PNPX_Removable}
  PKEY_PNPX_IPBusEnumerated: TPropertyKey = (
    fmtid: '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid: 28688);
  {$EXTERNALSYM PKEY_PNPX_IPBusEnumerated}

    { WNET Provider properties }
  PKEY_WNET_Scope: TPropertyKey = (
    fmtid: '{DEBDA43A-37B3-4383-91E7-4498DA2995AB}'; pid: 1);
  {$EXTERNALSYM PKEY_WNET_Scope}
  PKEY_WNET_Type: TPropertyKey = (
    fmtid: '{DEBDA43A-37B3-4383-91E7-4498DA2995AB}'; pid: 2);
  {$EXTERNALSYM PKEY_WNET_Type}
  PKEY_WNET_DisplayType: TPropertyKey = (
    fmtid: '{DEBDA43A-37B3-4383-91E7-4498DA2995AB}'; pid: 3);
  {$EXTERNALSYM PKEY_WNET_DisplayType}
  PKEY_WNET_Usage: TPropertyKey = (
    fmtid: '{DEBDA43A-37B3-4383-91E7-4498DA2995AB}'; pid: 4);
  {$EXTERNALSYM PKEY_WNET_Usage}
  PKEY_WNET_LocalName: TPropertyKey = (
    fmtid: '{DEBDA43A-37B3-4383-91E7-4498DA2995AB}'; pid: 5);
  {$EXTERNALSYM PKEY_WNET_LocalName}
  PKEY_WNET_RemoteName: TPropertyKey = (
    fmtid: '{DEBDA43A-37B3-4383-91E7-4498DA2995AB}'; pid: 6);
  {$EXTERNALSYM PKEY_WNET_RemoteName}
  PKEY_WNET_Comment: TPropertyKey = (
    fmtid: '{DEBDA43A-37B3-4383-91E7-4498DA2995AB}'; pid: 7);
  {$EXTERNALSYM PKEY_WNET_Comment}
  PKEY_WNET_Provider: TPropertyKey = (
    fmtid: '{DEBDA43A-37B3-4383-91E7-4498DA2995AB}'; pid: 8);
  {$EXTERNALSYM PKEY_WNET_Provider}


    { WCN Provider properties }

  PKEY_WCN_Version: TPropertyKey = (
    fmtid: '{88190B80-4684-11DA-A26A-0002B3988E81}'; pid: 1);
  {$EXTERNALSYM PKEY_WCN_Version}
  PKEY_WCN_RequestType: TPropertyKey = (
    fmtid: '{88190B81-4684-11DA-A26A-0002B3988E81}'; pid: 2);
  {$EXTERNALSYM PKEY_WCN_RequestType}
  PKEY_WCN_AuthType: TPropertyKey = (
    fmtid: '{88190B82-4684-11DA-A26A-0002B3988E81}'; pid: 3);
  {$EXTERNALSYM PKEY_WCN_AuthType}
  PKEY_WCN_EncryptType: TPropertyKey = (
    fmtid: '{88190B83-4684-11DA-A26A-0002B3988E81}'; pid: 4);
  {$EXTERNALSYM PKEY_WCN_EncryptType}
  PKEY_WCN_ConnType: TPropertyKey = (
    fmtid: '{88190B84-4684-11DA-A26A-0002B3988E81}'; pid: 5);
  {$EXTERNALSYM PKEY_WCN_ConnType}
  PKEY_WCN_ConfigMethods: TPropertyKey = (
    fmtid: '{88190B85-4684-11DA-A26A-0002B3988E81}'; pid: 6);
  {$EXTERNALSYM PKEY_WCN_ConfigMethods}
{ map WCN DeviceType to PKEY_PNPX_DeviceCategory }
{ DEFINE_PROPERTYKEY(PKEY_WCN_DeviceType, 0x88190b86, 0x4684, 0x11da, 0xa2, 0x6a, 0x00, 0x02, 0xb3, 0x98, 0x8e, 0x81, 0x00000007); // VT_INT }
  PKEY_WCN_RfBand: TPropertyKey = (
    fmtid: '{88190B87-4684-11DA-A26A-0002B3988E81}'; pid: 8);
  {$EXTERNALSYM PKEY_WCN_RfBand}
  PKEY_WCN_AssocState: TPropertyKey = (
    fmtid: '{88190B88-4684-11DA-A26A-0002B3988E81}'; pid: 9);
  {$EXTERNALSYM PKEY_WCN_AssocState}
  PKEY_WCN_ConfigError: TPropertyKey = (
    fmtid: '{88190B89-4684-11DA-A26A-0002B3988E81}'; pid: 10);
  {$EXTERNALSYM PKEY_WCN_ConfigError}
  PKEY_WCN_ConfigState: TPropertyKey = (
    fmtid: '{88190B89-4684-11DA-A26A-0002B3988E81}'; pid: 11);
  {$EXTERNALSYM PKEY_WCN_ConfigState}
  PKEY_WCN_DevicePasswordId: TPropertyKey = (
    fmtid: '{88190B89-4684-11DA-A26A-0002B3988E81}'; pid: 12);
  {$EXTERNALSYM PKEY_WCN_DevicePasswordId}
  PKEY_WCN_OSVersion: TPropertyKey = (
    fmtid: '{88190B89-4684-11DA-A26A-0002B3988E81}'; pid: 13);
  {$EXTERNALSYM PKEY_WCN_OSVersion}
  PKEY_WCN_VendorExtension: TPropertyKey = (
    fmtid: '{88190B8A-4684-11DA-A26A-0002B3988E81}'; pid: 14);
  {$EXTERNALSYM PKEY_WCN_VendorExtension}
  PKEY_WCN_RegistrarType: TPropertyKey = (
    fmtid: '{88190B8B-4684-11DA-A26A-0002B3988E81}'; pid: 15);
  {$EXTERNALSYM PKEY_WCN_RegistrarType}

{ ----------------------------------------------------------------------------- }
{ DriverPackage properties }

  PKEY_DriverPackage_Model: TPropertyKey = (
    fmtid: '{CF73BB51-3ABF-44A2-85E0-9A3DC7A12132}'; pid: 2);
  {$EXTERNALSYM PKEY_DriverPackage_Model}
  PKEY_DriverPackage_VendorWebSite: TPropertyKey = (
    fmtid: '{CF73BB51-3ABF-44A2-85E0-9A3DC7A12132}'; pid: 3);
  {$EXTERNALSYM PKEY_DriverPackage_VendorWebSite}
  PKEY_DriverPackage_DetailedDescription: TPropertyKey = (
    fmtid: '{CF73BB51-3ABF-44A2-85E0-9A3DC7A12132}'; pid: 4);
  {$EXTERNALSYM PKEY_DriverPackage_DetailedDescription}
  PKEY_DriverPackage_DocumentationLink: TPropertyKey = (
    fmtid: '{CF73BB51-3ABF-44A2-85E0-9A3DC7A12132}'; pid: 5);
  {$EXTERNALSYM PKEY_DriverPackage_DocumentationLink}
  PKEY_DriverPackage_Icon: TPropertyKey = (
    fmtid: '{CF73BB51-3ABF-44A2-85E0-9A3DC7A12132}'; pid: 6);
  {$EXTERNALSYM PKEY_DriverPackage_Icon}
  PKEY_DriverPackage_BrandingIcon: TPropertyKey = (
    fmtid: '{CF73BB51-3ABF-44A2-85E0-9A3DC7A12132}'; pid: 7);
  {$EXTERNALSYM PKEY_DriverPackage_BrandingIcon}

{ ----------------------------------------------------------------------------- }
{ Hardware properties }

  PKEY_Hardware_Devinst: TPropertyKey = (
    fmtid: '{5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953}'; pid: 4097);
  {$EXTERNALSYM PKEY_Hardware_Devinst}

{  Name:     System.Hardware.DisplayAttribute -- PKEY_Hardware_DisplayAttribute }
{  Type:     Unspecified -- VT_NULL }
{  FormatID: 5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953, 5 }
  PKEY_Hardware_DisplayAttribute: TPropertyKey = (
    fmtid: '{5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953}'; pid: 5);
  {$EXTERNALSYM PKEY_Hardware_DisplayAttribute}

{  Name:     System.Hardware.DriverDate -- PKEY_Hardware_DriverDate }
{  Type:     Unspecified -- VT_NULL }
{  FormatID: 5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953, 11 }
  PKEY_Hardware_DriverDate: TPropertyKey = (
    fmtid: '{5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953}'; pid: 11);
  {$EXTERNALSYM PKEY_Hardware_DriverDate}

{  Name:     System.Hardware.DriverProvider -- PKEY_Hardware_DriverProvider }
{  Type:     Unspecified -- VT_NULL }
{  FormatID: 5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953, 10 }
  PKEY_Hardware_DriverProvider: TPropertyKey = (
    fmtid: '{5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953}'; pid: 10);
  {$EXTERNALSYM PKEY_Hardware_DriverProvider}

{  Name:     System.Hardware.DriverVersion -- PKEY_Hardware_DriverVersion }
{  Type:     Unspecified -- VT_NULL }
{  FormatID: 5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953, 9 }
  PKEY_Hardware_DriverVersion: TPropertyKey = (
    fmtid: '{5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953}'; pid: 9);
  {$EXTERNALSYM PKEY_Hardware_DriverVersion}

{  Name:     System.Hardware.Function -- PKEY_Hardware_Function }
{  Type:     Unspecified -- VT_NULL }
{  FormatID: 5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953, 4099 }
  PKEY_Hardware_Function: TPropertyKey = (
    fmtid: '{5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953}'; pid: 4099);
  {$EXTERNALSYM PKEY_Hardware_Function}

{  Name:     System.Hardware.Icon -- PKEY_Hardware_Icon }
{  Type:     Unspecified -- VT_NULL }
{  FormatID: 5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953, 3 }
  PKEY_Hardware_Icon: TPropertyKey = (
    fmtid: '{5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953}'; pid: 3);
  {$EXTERNALSYM PKEY_Hardware_Icon}

{  Name:     System.Hardware.Image -- PKEY_Hardware_Image }
{  Type:     Unspecified -- VT_NULL }
{  FormatID: 5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953, 4098 }
  PKEY_Hardware_Image: TPropertyKey = (
    fmtid: '{5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953}'; pid: 4098);
  {$EXTERNALSYM PKEY_Hardware_Image}

{  Name:     System.Hardware.Manufacturer -- PKEY_Hardware_Manufacturer }
{  Type:     Unspecified -- VT_NULL }
{  FormatID: 5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953, 6 }
  PKEY_Hardware_Manufacturer: TPropertyKey = (
    fmtid: '{5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953}'; pid: 6);
  {$EXTERNALSYM PKEY_Hardware_Manufacturer}

{  Name:     System.Hardware.Model -- PKEY_Hardware_Model }
{  Type:     Unspecified -- VT_NULL }
{  FormatID: 5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953, 7 }
  PKEY_Hardware_Model: TPropertyKey = (
    fmtid: '{5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953}'; pid: 7);
  {$EXTERNALSYM PKEY_Hardware_Model}

{  Name:     System.Hardware.Name -- PKEY_Hardware_Name }
{  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR) }
{  FormatID: 5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953, 2 }
  PKEY_Hardware_Name: TPropertyKey = (
    fmtid: '{5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953}'; pid: 2);
  {$EXTERNALSYM PKEY_Hardware_Name}

{  Name:     System.Hardware.SerialNumber -- PKEY_Hardware_SerialNumber }
{  Type:     Unspecified -- VT_NULL }
{  FormatID: 5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953, 8 }
  PKEY_Hardware_SerialNumber: TPropertyKey = (
    fmtid: '{5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953}'; pid: 8);
  {$EXTERNALSYM PKEY_Hardware_SerialNumber}

{  Name:     System.Hardware.ShellAttributes -- PKEY_Hardware_ShellAttributes }
{  Type:     Unspecified -- VT_NULL }
{  FormatID: 5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953, 4100 }
  PKEY_Hardware_ShellAttributes: TPropertyKey = (
    fmtid: '{5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953}'; pid: 4100);
  {$EXTERNALSYM PKEY_Hardware_ShellAttributes}

{  Name:     System.Hardware.Status -- PKEY_Hardware_Status }
{  Type:     Unspecified -- VT_NULL }
{  FormatID: 5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953, 4096 }
  PKEY_Hardware_Status: TPropertyKey = (
    fmtid: '{5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953}'; pid: 4096);
  {$EXTERNALSYM PKEY_Hardware_Status}

// functiondiscoveryserviceids.h

//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

const
  SID_PnpProvider: TGUID = '{8101368E-CABB-4426-ACFF-96C410812000}';
  {$EXTERNALSYM SID_PnpProvider}
  SID_UPnPActivator: TGUID = '{0D0D66EB-CF74-4164-B52F-08344672DD46}';
  {$EXTERNALSYM SID_UPnPActivator}
  SID_EnumInterface: TGUID = '{40EAB0B9-4D7F-4B53-A334-1581DD9041F4}';
  {$EXTERNALSYM SID_EnumInterface}
  SID_PNPXPropertyStore: TGUID = '{A86530B1-542F-439F-B71C-B0756B13677A}';
  {$EXTERNALSYM SID_PNPXPropertyStore}
  SID_PNPXAssociation: TGUID = '{CEE8CCC9-4F6B-4469-A235-5A22869EEF03}';
  {$EXTERNALSYM SID_PNPXAssociation}
  SID_PNPXServiceCollection: TGUID = '{439E80EE-A217-4712-9FA6-DEABD9C2A727}';
  {$EXTERNALSYM SID_PNPXServiceCollection}
  SID_FDPairingHandler: TGUID = '{383B69FA-5486-49DA-91F5-D63C24C8E9D0}';
  {$EXTERNALSYM SID_FDPairingHandler}
  SID_EnumDeviceFunction: TGUID = '{13E0E9E2-C3FA-4E3C-906E-64502FA4DC95}';
  {$EXTERNALSYM SID_EnumDeviceFunction}
  SID_UnpairProvider: TGUID = '{89A502FC-857B-4698-A0B7-027192002F9E}';
  {$EXTERNALSYM SID_UnpairProvider}
  SID_DeviceDisplayStatusManager: TGUID = '{F59AA553-8309-46CA-9736-1AC3C62D6031}';
  {$EXTERNALSYM SID_DeviceDisplayStatusManager}
  SID_FunctionDiscoveryProviderRefresh: TGUID = '{2B4CBDC9-31C4-40D4-A62D-772AA174ED52}';
  {$EXTERNALSYM SID_FunctionDiscoveryProviderRefresh}
  SID_UninstallDeviceFunction: TGUID = '{C920566E-5671-4496-8025-BF0B89BD44CD}';
  {$EXTERNALSYM SID_UninstallDeviceFunction}

// functiondiscoveryconstraints.h

//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

// /////////////////////////////////////////////////////////////////////////////
// QUERY Constraint defines
// /////////////////////////////////////////////////////////////////////////////

const
  MAX_FDCONSTRAINTNAME_LENGTH = 100;
  {$EXTERNALSYM MAX_FDCONSTRAINTNAME_LENGTH}
  MAX_FDCONSTRAINTVALUE_LENGTH = 1000;
  {$EXTERNALSYM MAX_FDCONSTRAINTVALUE_LENGTH}

// Common Provider specific Constraints
  FD_QUERYCONSTRAINT_PROVIDERINSTANCEID = 'ProviderInstanceID';
  {$EXTERNALSYM FD_QUERYCONSTRAINT_PROVIDERINSTANCEID}
  FD_QUERYCONSTRAINT_SUBCATEGORY = 'Subcategory';
  {$EXTERNALSYM FD_QUERYCONSTRAINT_SUBCATEGORY}
  FD_QUERYCONSTRAINT_RECURSESUBCATEGORY = 'RecurseSubcategory';
  {$EXTERNALSYM FD_QUERYCONSTRAINT_RECURSESUBCATEGORY}
  FD_QUERYCONSTRAINT_VISIBILITY = 'Visibility';
  {$EXTERNALSYM FD_QUERYCONSTRAINT_VISIBILITY}
    // FD_CONSTRAINTVALUE_VISIBILITY_DEFAULT you want just default instances (visible as defined by the provider)
    // FD_CONSTRAINTVALUE_VISIBILITY_ALL (default) you want both visible and not visible/hidden instances (as defined by the provider)
  FD_QUERYCONSTRAINT_COMCLSCONTEXT = 'COMClsContext';
  {$EXTERNALSYM FD_QUERYCONSTRAINT_COMCLSCONTEXT}
  FD_QUERYCONSTRAINT_ROUTINGSCOPE = 'RoutingScope';
  {$EXTERNALSYM FD_QUERYCONSTRAINT_ROUTINGSCOPE}

// Common Provider specific Constraints values
  FD_CONSTRAINTVALUE_TRUE = 'TRUE';
  {$EXTERNALSYM FD_CONSTRAINTVALUE_TRUE}
  FD_CONSTRAINTVALUE_FALSE = 'FALSE';
  {$EXTERNALSYM FD_CONSTRAINTVALUE_FALSE}
  FD_CONSTRAINTVALUE_RECURSESUBCATEGORY_TRUE = FD_CONSTRAINTVALUE_TRUE;
  {$EXTERNALSYM FD_CONSTRAINTVALUE_RECURSESUBCATEGORY_TRUE}
  FD_CONSTRAINTVALUE_VISIBILITY_DEFAULT = '0';
  {$EXTERNALSYM FD_CONSTRAINTVALUE_VISIBILITY_DEFAULT}
  FD_CONSTRAINTVALUE_VISIBILITY_ALL = '1';
  {$EXTERNALSYM FD_CONSTRAINTVALUE_VISIBILITY_ALL}
  FD_CONSTRAINTVALUE_COMCLSCONTEXT_INPROC_SERVER = '1';
  {$EXTERNALSYM FD_CONSTRAINTVALUE_COMCLSCONTEXT_INPROC_SERVER}
  FD_CONSTRAINTVALUE_COMCLSCONTEXT_LOCAL_SERVER = '4';
  {$EXTERNALSYM FD_CONSTRAINTVALUE_COMCLSCONTEXT_LOCAL_SERVER}

  FD_CONSTRAINTVALUE_PAIRED = 'Paired';
  {$EXTERNALSYM FD_CONSTRAINTVALUE_PAIRED}
  FD_CONSTRAINTVALUE_UNPAIRED = 'UnPaired';
  {$EXTERNALSYM FD_CONSTRAINTVALUE_UNPAIRED}
  FD_CONSTRAINTVALUE_ALL = 'All';
  {$EXTERNALSYM FD_CONSTRAINTVALUE_ALL}

  FD_CONSTRAINTVALUE_ROUTINGSCOPE_ALL = 'All';
  {$EXTERNALSYM FD_CONSTRAINTVALUE_ROUTINGSCOPE_ALL}
  FD_CONSTRAINTVALUE_ROUTINGSCOPE_DIRECT = 'Direct';
  {$EXTERNALSYM FD_CONSTRAINTVALUE_ROUTINGSCOPE_DIRECT}

// /////////////////////////////////////////////////////////////////////////////
// Provider inquiry constraints
  FD_QUERYCONSTRAINT_PAIRING_STATE = 'PairingState';
  {$EXTERNALSYM FD_QUERYCONSTRAINT_PAIRING_STATE}
    // if unset, provider default is FD_CONSTRAINTVALUE_PAIRED
    // FD_CONSTRAINTVALUE_PAIRED will return all paired devices
    // FD_CONSTRAINTVALUE_UNPAIRED will return all unpaired devices within wireless or wired range
    // FD_CONSTRAINTVALUE_ALL will return all devices cached and within wireless or wired range
  FD_QUERYCONSTRAINT_INQUIRY_TIMEOUT = 'InquiryModeTimeout';
  {$EXTERNALSYM FD_QUERYCONSTRAINT_INQUIRY_TIMEOUT}

// /////////////////////////////////////////////////////////////////////////////
// PNP Provider specific Constraints
  PROVIDERPNP_QUERYCONSTRAINT_INTERFACECLASS = 'InterfaceClass';
  {$EXTERNALSYM PROVIDERPNP_QUERYCONSTRAINT_INTERFACECLASS}
  PROVIDERPNP_QUERYCONSTRAINT_NOTPRESENT = 'NotPresent';
  {$EXTERNALSYM PROVIDERPNP_QUERYCONSTRAINT_NOTPRESENT}
  PROVIDERPNP_QUERYCONSTRAINT_NOTIFICATIONSONLY = 'NotifyOnly';
  {$EXTERNALSYM PROVIDERPNP_QUERYCONSTRAINT_NOTIFICATIONSONLY}
    // PNP_CONSTRAINTVALUE_NOTPRESENT you want "not present" instances as well
    // "FALSE" (default) you want only DIGCF_PRESENT instances.
// PNP Provider specific Constraints values
  PNP_CONSTRAINTVALUE_NOTPRESENT = FD_CONSTRAINTVALUE_TRUE;
  {$EXTERNALSYM PNP_CONSTRAINTVALUE_NOTPRESENT}
  PNP_CONSTRAINTVALUE_NOTIFICATIONSONLY = FD_CONSTRAINTVALUE_TRUE;
  {$EXTERNALSYM PNP_CONSTRAINTVALUE_NOTIFICATIONSONLY}

// /////////////////////////////////////////////////////////////////////////////
// SSDP Provider specific Constraints
  PROVIDERSSDP_QUERYCONSTRAINT_TYPE = 'Type';
  {$EXTERNALSYM PROVIDERSSDP_QUERYCONSTRAINT_TYPE}
  PROVIDERSSDP_QUERYCONSTRAINT_CUSTOMXMLPROPERTY = 'CustomXmlProperty';
  {$EXTERNALSYM PROVIDERSSDP_QUERYCONSTRAINT_CUSTOMXMLPROPERTY}

// SSDP Provider specific Constraints values
  SSDP_CONSTRAINTVALUE_TYPE_ALL = 'ssdp:all';
  {$EXTERNALSYM SSDP_CONSTRAINTVALUE_TYPE_ALL}
  SSDP_CONSTRAINTVALUE_TYPE_ROOT = 'upnp:rootdevice';
  {$EXTERNALSYM SSDP_CONSTRAINTVALUE_TYPE_ROOT}
  SSDP_CONSTRAINTVALUE_TYPE_DEVICE_PREFIX = 'urn:schemas-upnp-org:device:';
  {$EXTERNALSYM SSDP_CONSTRAINTVALUE_TYPE_DEVICE_PREFIX}
  SSDP_CONSTRAINTVALUE_TYPE_SVC_PREFIX = 'urn:schemas-upnp-org:service:';
  {$EXTERNALSYM SSDP_CONSTRAINTVALUE_TYPE_SVC_PREFIX}

  SSDP_CONSTRAINTVALUE_TYPE_DEV_LIGHTING = SSDP_CONSTRAINTVALUE_TYPE_DEVICE_PREFIX + 'Lighting:1';
  {$EXTERNALSYM SSDP_CONSTRAINTVALUE_TYPE_DEV_LIGHTING}
  SSDP_CONSTRAINTVALUE_TYPE_DEV_REMINDER = SSDP_CONSTRAINTVALUE_TYPE_DEVICE_PREFIX + 'Reminder:1';
  {$EXTERNALSYM SSDP_CONSTRAINTVALUE_TYPE_DEV_REMINDER}
  SSDP_CONSTRAINTVALUE_TYPE_DEV_POWERDEVICE = SSDP_CONSTRAINTVALUE_TYPE_DEVICE_PREFIX + 'PowerDevice:1';
  {$EXTERNALSYM SSDP_CONSTRAINTVALUE_TYPE_DEV_POWERDEVICE}
  SSDP_CONSTRAINTVALUE_TYPE_DEV_IGD = SSDP_CONSTRAINTVALUE_TYPE_DEVICE_PREFIX + 'InternetGatewayDevice:1';
  {$EXTERNALSYM SSDP_CONSTRAINTVALUE_TYPE_DEV_IGD}
  SSDP_CONSTRAINTVALUE_TYPE_DEV_WANDEVICE = SSDP_CONSTRAINTVALUE_TYPE_DEVICE_PREFIX + 'WANDevice:1';
  {$EXTERNALSYM SSDP_CONSTRAINTVALUE_TYPE_DEV_WANDEVICE}
  SSDP_CONSTRAINTVALUE_TYPE_DEV_LANDEVICE = SSDP_CONSTRAINTVALUE_TYPE_DEVICE_PREFIX + 'LANDevice:1';
  {$EXTERNALSYM SSDP_CONSTRAINTVALUE_TYPE_DEV_LANDEVICE}
  SSDP_CONSTRAINTVALUE_TYPE_DEV_WANCONNDEVICE = SSDP_CONSTRAINTVALUE_TYPE_DEVICE_PREFIX + 'WANConnectionDevice:1';
  {$EXTERNALSYM SSDP_CONSTRAINTVALUE_TYPE_DEV_WANCONNDEVICE}
  SSDP_CONSTRAINTVALUE_TYPE_DEV_LUXMETER = SSDP_CONSTRAINTVALUE_TYPE_DEVICE_PREFIX + 'Luxmeter:1';
  {$EXTERNALSYM SSDP_CONSTRAINTVALUE_TYPE_DEV_LUXMETER}
  SSDP_CONSTRAINTVALUE_TYPE_DEV_MDARNDR = SSDP_CONSTRAINTVALUE_TYPE_DEVICE_PREFIX + 'MediaRenderer:1';
  {$EXTERNALSYM SSDP_CONSTRAINTVALUE_TYPE_DEV_MDARNDR}
  SSDP_CONSTRAINTVALUE_TYPE_DEV_MDASRVR = SSDP_CONSTRAINTVALUE_TYPE_DEVICE_PREFIX + 'MediaServer:1';
  {$EXTERNALSYM SSDP_CONSTRAINTVALUE_TYPE_DEV_MDASRVR}

  SSDP_CONSTRAINTVALUE_TYPE_SVC_SCANNER = SSDP_CONSTRAINTVALUE_TYPE_SVC_PREFIX + 'Scanner:1';
  {$EXTERNALSYM SSDP_CONSTRAINTVALUE_TYPE_SVC_SCANNER}
  SSDP_CONSTRAINTVALUE_TYPE_SVC_DIMMING = SSDP_CONSTRAINTVALUE_TYPE_SVC_PREFIX + 'DimmingService:1';
  {$EXTERNALSYM SSDP_CONSTRAINTVALUE_TYPE_SVC_DIMMING}

// /////////////////////////////////////////////////////////////////////////////
// WSD Provider specific Constraints
  PROVIDERWSD_QUERYCONSTRAINT_DIRECTEDADDRESS = 'RemoteAddress';
  {$EXTERNALSYM PROVIDERWSD_QUERYCONSTRAINT_DIRECTEDADDRESS}
  PROVIDERWSD_QUERYCONSTRAINT_TYPE = 'Type';
  {$EXTERNALSYM PROVIDERWSD_QUERYCONSTRAINT_TYPE}
  PROVIDERWSD_QUERYCONSTRAINT_SCOPE = 'Scope';
  {$EXTERNALSYM PROVIDERWSD_QUERYCONSTRAINT_SCOPE}
  PROVIDERWSD_QUERYCONSTRAINT_SECURITY_REQUIREMENTS = 'SecurityRequirements';
  {$EXTERNALSYM PROVIDERWSD_QUERYCONSTRAINT_SECURITY_REQUIREMENTS}
  PROVIDERWSD_QUERYCONSTRAINT_SSL_CERT_FOR_CLIENT_AUTH = 'SSLClientAuthCert';
  {$EXTERNALSYM PROVIDERWSD_QUERYCONSTRAINT_SSL_CERT_FOR_CLIENT_AUTH}

// WSD provider specific Constraint values
  WSD_CONSTRAINTVALUE_REQUIRE_SECURECHANNEL = '1';
  {$EXTERNALSYM WSD_CONSTRAINTVALUE_REQUIRE_SECURECHANNEL}
  WSD_CONSTRAINTVALUE_REQUIRE_SECURECHANNEL_AND_COMPACTSIGNATURE = '2';
  {$EXTERNALSYM WSD_CONSTRAINTVALUE_REQUIRE_SECURECHANNEL_AND_COMPACTSIGNATURE}
  WSD_CONSTRAINTVALUE_NO_TRUST_VERIFICATION = '3';
  {$EXTERNALSYM WSD_CONSTRAINTVALUE_NO_TRUST_VERIFICATION}

// /////////////////////////////////////////////////////////////////////////////
// NetBios Provider specific Constraints
  PROVIDERWNET_QUERYCONSTRAINT_TYPE = 'Type';
  {$EXTERNALSYM PROVIDERWNET_QUERYCONSTRAINT_TYPE}
  PROVIDERWNET_QUERYCONSTRAINT_PROPERTIES = 'Properties';
  {$EXTERNALSYM PROVIDERWNET_QUERYCONSTRAINT_PROPERTIES}
  PROVIDERWNET_QUERYCONSTRAINT_RESOURCETYPE = 'ResourceType';
  {$EXTERNALSYM PROVIDERWNET_QUERYCONSTRAINT_RESOURCETYPE}

  WNET_CONSTRAINTVALUE_TYPE_ALL = 'All';
  {$EXTERNALSYM WNET_CONSTRAINTVALUE_TYPE_ALL}
  WNET_CONSTRAINTVALUE_TYPE_SERVER = 'Server';
  {$EXTERNALSYM WNET_CONSTRAINTVALUE_TYPE_SERVER}
  WNET_CONSTRAINTVALUE_TYPE_DOMAIN = 'Domain';
  {$EXTERNALSYM WNET_CONSTRAINTVALUE_TYPE_DOMAIN}

  WNET_CONSTRAINTVALUE_PROPERTIES_ALL = 'All';
  {$EXTERNALSYM WNET_CONSTRAINTVALUE_PROPERTIES_ALL}
  WNET_CONSTRAINTVALUE_PROPERTIES_LIMITED = 'Limited';
  {$EXTERNALSYM WNET_CONSTRAINTVALUE_PROPERTIES_LIMITED}

  WNET_CONSTRAINTVALUE_RESOURCETYPE_DISK = 'Disk';
  {$EXTERNALSYM WNET_CONSTRAINTVALUE_RESOURCETYPE_DISK}
  WNET_CONSTRAINTVALUE_RESOURCETYPE_PRINTER = 'Printer';
  {$EXTERNALSYM WNET_CONSTRAINTVALUE_RESOURCETYPE_PRINTER}
  WNET_CONSTRAINTVALUE_RESOURCETYPE_DISKORPRINTER = 'DiskOrPrinter';
  {$EXTERNALSYM WNET_CONSTRAINTVALUE_RESOURCETYPE_DISKORPRINTER}

  ONLINE_PROVIDER_DEVICES_QUERYCONSTRAINT_OWNERNAME = 'OwnerName';
  {$EXTERNALSYM ONLINE_PROVIDER_DEVICES_QUERYCONSTRAINT_OWNERNAME}

// /////////////////////////////////////////////////////////////////////////////
// Device Display Object Provider specific Constraints
  PROVIDERDDO_QUERYCONSTRAINT_DEVICEFUNCTIONDISPLAYOBJECTS = 'DeviceFunctionDisplayObjects';
  {$EXTERNALSYM PROVIDERDDO_QUERYCONSTRAINT_DEVICEFUNCTIONDISPLAYOBJECTS}
  PROVIDERDDO_QUERYCONSTRAINT_ONLYCONNECTEDDEVICES = 'OnlyConnectedDevices';
  {$EXTERNALSYM PROVIDERDDO_QUERYCONSTRAINT_ONLYCONNECTEDDEVICES}
  PROVIDERDDO_QUERYCONSTRAINT_DEVICEINTERFACES = 'DeviceInterfaces';
  {$EXTERNALSYM PROVIDERDDO_QUERYCONSTRAINT_DEVICEINTERFACES}

// /////////////////////////////////////////////////////////////////////////////
// PROPERTY Constraint defines
// /////////////////////////////////////////////////////////////////////////////

type
  PropertyConstraint = type Integer;
  {$EXTERNALSYM PropertyConstraint}

const
  QC_EQUALS             = 0;
  {$EXTERNALSYM QC_EQUALS}
  QC_NOTEQUAL           = 1;
  {$EXTERNALSYM QC_NOTEQUAL}
  QC_LESSTHAN           = 2;
  {$EXTERNALSYM QC_LESSTHAN}
  QC_LESSTHANOREQUAL    = 3;
  {$EXTERNALSYM QC_LESSTHANOREQUAL}
  QC_GREATERTHAN        = 4;
  {$EXTERNALSYM QC_GREATERTHAN}
  QC_GREATERTHANOREQUAL = 5;
  {$EXTERNALSYM QC_GREATERTHANOREQUAL}
  QC_STARTSWITH         = 6;
  {$EXTERNALSYM QC_STARTSWITH}
  QC_EXISTS             = 7;
  {$EXTERNALSYM QC_EXISTS}
  QC_DOESNOTEXIST       = 8;
  {$EXTERNALSYM QC_DOESNOTEXIST}
  QC_CONTAINS           = 9;
  {$EXTERNALSYM QC_CONTAINS}

  FD_LONGHORN = 1;
  {$EXTERNALSYM FD_LONGHORN}

  SVF_SYSTEM = 0;
  {$EXTERNALSYM SVF_SYSTEM}
  SVF_USER   = 1;
  {$EXTERNALSYM SVF_USER}
  QUA_ADD    = 0;
  {$EXTERNALSYM QUA_ADD}
  QUA_REMOVE = 1;
  {$EXTERNALSYM QUA_REMOVE}
  QUA_CHANGE = 2;
  {$EXTERNALSYM QUA_CHANGE}
  QCT_PROVIDER = 0;
  {$EXTERNALSYM QCT_PROVIDER}
  QCT_LAYERED  = 1;
  {$EXTERNALSYM QCT_LAYERED}

  SID_IFunctionDiscoveryNotification = '{5f6c1ba8-5330-422e-a368-572b244d3f87}';
  {$EXTERNALSYM SID_IFunctionDiscoveryNotification}
  IID_IFunctionDiscoveryNotification: TGUID = '{5f6c1ba8-5330-422e-a368-572b244d3f87}';
  {$EXTERNALSYM IID_IFunctionDiscoveryNotification}
  SID_IFunctionDiscovery = '{4df99b70-e148-4432-b004-4c9eeb535a5e}';
  {$EXTERNALSYM SID_IFunctionDiscovery}
  IID_IFunctionDiscovery: TGUID = '{4df99b70-e148-4432-b004-4c9eeb535a5e}';
  {$EXTERNALSYM IID_IFunctionDiscovery}
  SID_IFunctionInstance = '{33591c10-0bed-4f02-b0ab-1530d5533ee9}';
  {$EXTERNALSYM SID_IFunctionInstance}
  IID_IFunctionInstance: TGUID = '{33591c10-0bed-4f02-b0ab-1530d5533ee9}';
  {$EXTERNALSYM IID_IFunctionInstance}
  SID_IFunctionInstanceCollection = '{f0a3d895-855c-42a2-948d-2f97d450ecb1}';
  {$EXTERNALSYM SID_IFunctionInstanceCollection}
  IID_IFunctionInstanceCollection: TGUID = '{f0a3d895-855c-42a2-948d-2f97d450ecb1}';
  {$EXTERNALSYM IID_IFunctionInstanceCollection}
  SID_IPropertyStoreCollection = '{D14D9C30-12D2-42d8-BCE4-C60C2BB226FA}';
  {$EXTERNALSYM SID_IPropertyStoreCollection}
  IID_IPropertyStoreCollection: TGUID = '{D14D9C30-12D2-42d8-BCE4-C60C2BB226FA}';
  {$EXTERNALSYM IID_IPropertyStoreCollection}
  SID_IFunctionInstanceQuery = '{6242bc6b-90ec-4b37-bb46-e229fd84ed95}';
  {$EXTERNALSYM SID_IFunctionInstanceQuery}
  IID_IFunctionInstanceQuery: TGUID = '{6242bc6b-90ec-4b37-bb46-e229fd84ed95}';
  {$EXTERNALSYM IID_IFunctionInstanceQuery}
  SID_IFunctionInstanceCollectionQuery = '{57cc6fd2-c09a-4289-bb72-25f04142058e}';
  {$EXTERNALSYM SID_IFunctionInstanceCollectionQuery}
  IID_IFunctionInstanceCollectionQuery: TGUID = '{57cc6fd2-c09a-4289-bb72-25f04142058e}';
  {$EXTERNALSYM IID_IFunctionInstanceCollectionQuery}
  CLSID_FunctionDiscovery: TGUID = '{C72BE2EC-8E90-452c-B29A-AB8FF1C071FC}';
  {$EXTERNALSYM CLSID_FunctionDiscovery}
  CLSID_PropertyStore: TGUID = '{e4796550-df61-448b-9193-13fc1341b163}';
  {$EXTERNALSYM CLSID_PropertyStore}
  CLSID_FunctionInstanceCollection: TGUID = '{ba818ce5-b55f-443f-ad39-2fe89be6191f}';
  {$EXTERNALSYM CLSID_FunctionInstanceCollection}
  CLSID_PropertyStoreCollection: TGUID = '{EDD36029-D753-4862-AA5B-5BCCAD2A4D29}';
  {$EXTERNALSYM CLSID_PropertyStoreCollection}

{ Forward Declarations }

type
  IFunctionDiscoveryNotification = interface;
  IFunctionDiscovery = interface;
  IFunctionInstance = interface;
  IFunctionInstanceCollection = interface;
  IPropertyStoreCollection = interface;
  IFunctionInstanceQuery = interface;
  IFunctionInstanceCollectionQuery = interface;

  PFDQUERYCONTEXT = ^FDQUERYCONTEXT;
  FDQUERYCONTEXT = DWORDLONG;
  {$EXTERNALSYM FDQUERYCONTEXT}

  SystemVisibilityFlags = type Integer;
  {$EXTERNALSYM SystemVisibilityFlags}
  QueryUpdateAction = type Integer;
  {$EXTERNALSYM QueryUpdateAction}
  QueryCategoryType = type Integer;
  {$EXTERNALSYM QueryCategoryType}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IFunctionDiscoveryNotification);'}
  IFunctionDiscoveryNotification = interface(IUnknown)
    [SID_IFunctionDiscoveryNotification]
    function OnUpdate(enumQueryUpdateAction: QueryUpdateAction; fdqcQueryContext: FDQUERYCONTEXT;
      pIFunctionInstance: IFunctionInstance): HRESULT; stdcall;
    function OnError(hr: HRESULT; fdqcQueryContext: FDQUERYCONTEXT; pszProvider: PWCHAR): HRESULT; stdcall;
    function OnEvent(dwEventID: DWORD; fdqcQueryContext: FDQUERYCONTEXT; pszProvider: PWCHAR): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IFunctionDiscoveryNotification}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IFunctionDiscovery);'}
  IFunctionDiscovery = interface(IUnknown)
    [SID_IFunctionDiscovery]
    function GetInstanceCollection(pszCategory: PWCHAR; pszSubCategory: PWCHAR; fIncludeAllSubCategories: BOOL;
      out ppIFunctionInstanceCollection: IFunctionInstanceCollection): HRESULT; stdcall;
    function GetInstance(pszFunctionInstanceIdentity: PWCHAR; out ppIFunctionInstance: IFunctionInstance): HRESULT; stdcall;
    function CreateInstanceCollectionQuery(pszCategory: PWCHAR; pszSubCategory: PWCHAR; fIncludeAllSubCategories: BOOL;
      const pIFunctionDiscoveryNotification: IFunctionDiscoveryNotification;
      pfdqcQueryContext: PFDQUERYCONTEXT; out ppIFunctionInstanceCollectionQuery: IFunctionInstanceCollectionQuery): HRESULT; stdcall;
    function CreateInstanceQuery(pszFunctionInstanceIdentity: PWCHAR;
      const pIFunctionDiscoveryNotification: IFunctionDiscoveryNotification;
      pfdqcQueryContext: PFDQUERYCONTEXT; out ppIFunctionInstanceQuery: IFunctionInstanceQuery): HRESULT; stdcall;
    function AddInstance(enumSystemVisibility: SystemVisibilityFlags;
      pszCategory: PWCHAR; pszSubCategory: PWCHAR; pszCategoryIdentity: PWCHAR;
      out ppIFunctionInstance: IFunctionInstance): HRESULT; stdcall;
    function RemoveInstance(enumSystemVisibility: SystemVisibilityFlags;
      pszCategory: PWCHAR; pszSubCategory: PWCHAR; pszCategoryIdentity: PWCHAR): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IFunctionDiscovery}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IFunctionInstance);'}
  IFunctionInstance = interface(IServiceProvider)
    [SID_IFunctionInstance]
    function GetID(out ppszCoMemIdentity: PWCHAR): HRESULT; stdcall;
    function GetProviderInstanceID(out ppszCoMemProviderInstanceIdentity: PWCHAR): HRESULT; stdcall;
    function OpenPropertyStore(dwStgAccess: DWORD; out ppIPropertyStore: IPropertyStore): HRESULT; stdcall;
    function GetCategory(out ppszCoMemCategory: PWCHAR; out ppszCoMemSubCategory: PWCHAR): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IFunctionInstance}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IFunctionInstanceCollection);'}
  IFunctionInstanceCollection = interface(IUnknown)
    [SID_IFunctionInstanceCollection]
    function GetCount(out pdwCount: DWORD): HRESULT; stdcall;
    function Get(pszInstanceIdentity: PWCHAR; out pdwIndex: DWORD; out ppIFunctionInstance: IFunctionInstance): HRESULT; stdcall;
    function Item(dwIndex: DWORD; out ppIFunctionInstance: IFunctionInstance): HRESULT; stdcall;
    function Add(const pIFunctionInstance: IFunctionInstance): HRESULT; stdcall;
    function Remove(dwIndex: DWORD; out ppIFunctionInstance: IFunctionInstance): HRESULT; stdcall;
    function Delete(dwIndex: DWORD): HRESULT; stdcall;
    function DeleteAll: HRESULT; stdcall;
  end;
  {$EXTERNALSYM IFunctionInstanceCollection}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IPropertyStoreCollection);'}
  IPropertyStoreCollection = interface(IUnknown)
    [SID_IPropertyStoreCollection]
    function GetCount(out pdwCount: DWORD): HRESULT; stdcall;
    function Get(pszInstanceIdentity: PWCHAR; out pdwIndex: DWORD; out ppIPropertyStore: IPropertyStore): HRESULT; stdcall;
    function Item(dwIndex: DWORD; out ppIPropertyStore: IPropertyStore): HRESULT; stdcall;
    function Add(const pIPropertyStore: IPropertyStore): HRESULT; stdcall;
    function Remove(dwIndex: DWORD; out pIPropertyStore: IPropertyStore): HRESULT; stdcall;
    function Delete(dwIndex: DWORD): HRESULT; stdcall;
    function DeleteAll: HRESULT; stdcall;
  end;
  {$EXTERNALSYM IPropertyStoreCollection}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IFunctionInstanceQuery);'}
  IFunctionInstanceQuery = interface(IUnknown)
    [SID_IFunctionInstanceQuery]
    function Execute(out ppIFunctionInstance: IFunctionInstance): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IFunctionInstanceQuery}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IFunctionInstanceCollectionQuery);'}
  IFunctionInstanceCollectionQuery = interface(IUnknown)
    [SID_IFunctionInstanceCollectionQuery]
    function AddQueryConstraint(pszConstraintName: PWCHAR; pszConstraintValue: PWCHAR): HRESULT; stdcall;
    function AddPropertyConstraint(const Key: PROPERTYKEY; const pv: PROPVARIANT; enumPropertyConstraint: PropertyConstraint): HRESULT; stdcall;
    function Execute(out ppIFunctionInstanceCollection: IFunctionInstanceCollection): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IFunctionInstanceCollectionQuery}

implementation

end.
