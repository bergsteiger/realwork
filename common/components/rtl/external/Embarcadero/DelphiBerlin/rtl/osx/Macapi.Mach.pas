{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Macapi.Mach;

{
 This unit represents a set of Mach specific APIs that are brought into scope when
 employing mach.h under OS X.
}

{$WEAKPACKAGEUNIT}

interface

uses Posix.Base;

{$POINTERMATH ON}

type
  clock_res_t = Integer;
  {$EXTERNALSYM clock_res_t}
  natural_t = UInt32;
  {$EXTERNALSYM natural_t}
  uint16_t = UInt16;
  {$EXTERNALSYM uint16_t}
  uint32_t = UInt32;
  {$EXTERNALSYM uint32_t}
  uint64_t = UInt64;
  {$EXTERNALSYM uint64_t}
  mach_port_name_t = natural_t;
  {$EXTERNALSYM mach_port_name_t}
  mach_port_t = mach_port_name_t;
  {$EXTERNALSYM mach_port_t}
  ipc_space_t = mach_port_t;
  {$EXTERNALSYM ipc_space_t}
  mach_port_right_t = natural_t;
  {$EXTERNALSYM mach_port_right_t}
  mach_msg_timeout_t = natural_t;
  {$EXTERNALSYM mach_msg_timeout_t}
  mach_msg_type_number_t = natural_t;
  {$EXTERNALSYM mach_msg_type_number_t}
  exception_type_t = Integer;
  {$EXTERNALSYM exception_type_t}
  exception_mask_t = UInt32;
  {$EXTERNALSYM exception_mask_t}
  exception_handler_t = mach_port_t;
  {$EXTERNALSYM exception_handler_t}
  exception_behavior_t = Integer;
  {$EXTERNALSYM exception_behavior_t}
  exception_mask_array_t = ^exception_mask_t;
  {$EXTERNALSYM exception_mask_array_t}
  exception_handler_array_t = ^exception_handler_t;
  {$EXTERNALSYM exception_handler_array_t}
  exception_behavior_array_t = ^exception_behavior_t;
  {$EXTERNALSYM exception_behavior_array_t}
  exception_flavor_array_t = ^thread_state_flavor_t;
  {$EXTERNALSYM exception_flavor_array_t}
  task_t = mach_port_t;
  {$EXTERNALSYM task_t}
  task_name_t = mach_port_t;
  {$EXTERNALSYM task_name_t}
  semaphore_t = mach_port_t;
  {$EXTERNALSYM semaphore_t}
  processor_set_flavor_t = Integer;
  {$EXTERNALSYM processor_set_flavor_t}
  boolean_t = LongBool;
  {$EXTERNALSYM boolean_t}

  thread_t = mach_port_t;
  {$EXTERNALSYM thread_t}
  thread_state_flavor_t = Integer;
  {$EXTERNALSYM thread_state_flavor_t}
  thread_act_t = mach_port_t;
  {$EXTERNALSYM thread_act_t}
  thread_state_t = ^natural_t;
  {$EXTERNALSYM thread_state_t}
  host_t = mach_port_t;
  {$EXTERNALSYM host_t}
  host_priv_t = Integer;
  {$EXTERNALSYM host_priv_t}
  host_security_t = mach_port_t;
  {$EXTERNALSYM host_security_t}
  kern_return_t = Integer;
  {$EXTERNALSYM kern_return_t}
  mach_msg_return_t = kern_return_t;
  {$EXTERNALSYM mach_msg_return_t}
  mach_msg_option_t = Integer;
  {$EXTERNALSYM mach_msg_option_t}
  mach_msg_bits_t = UInt32;
  {$EXTERNALSYM mach_msg_bits_t}
  mach_msg_size_t = natural_t;
  {$EXTERNALSYM mach_msg_size_t}
  mach_msg_id_t = Integer;
  {$EXTERNALSYM mach_msg_id_t}
  mach_msg_type_name_t = Integer;
  {$EXTERNALSYM mach_msg_type_name_t}
  mach_msg_body_t = record
     msgh_descriptor_count: mach_msg_size_t;
  end;
  {$EXTERNALSYM mach_msg_body_t}
  mach_msg_header_t = record
     msgh_bits: mach_msg_bits_t;
     msgh_size: mach_msg_bits_t;
     msgh_remote_port: mach_port_t;
     msgh_local_port: mach_port_t;
     msgh_reserved: mach_msg_size_t;
     msgh_id: mach_msg_id_t
  end;
  {$EXTERNALSYM mach_msg_header_t}
  exception_data_type_t = Integer;
  {$EXTERNALSYM exception_data_type_t}
  exception_data_t = ^exception_data_type_t;
  {$EXTERNALSYM exception_data_t}

  { machine.h }
  cpu_type_t = Integer;
  {$EXTERNALSYM cpu_type_t}
  cpu_subtype_t = Integer;
  {$EXTERNALSYM cpu_subtype_t}
  cpu_threadtype_t = Integer;
  {$EXTERNALSYM cpu_threadtype_t}

  { host_info.h }
  host_info_t = ^Integer;
  {$EXTERNALSYM host_info_t}
  host_info64_t = ^Integer; { varying array of int. }
  {$EXTERNALSYM host_info64_t}
  host_flavor_t = Integer;
  {$EXTERNALSYM host_flavor_t}

  vm_size_t = UIntPtr;
  {$EXTERNALSYM vm_size_t}
  vm_offset_t = UIntPtr;
  {$EXTERNALSYM vm_offset_t}
  vm_address_t = vm_offset_t;
  {$EXTERNALSYM vm_address_t}
  vm_object_offset_t = UInt64;
  {$EXTERNALSYM vm_object_offset_t}
  vm_object_size_t = UInt64;
  {$EXTERNALSYM vm_object_size_t}
  upl_t = mach_port_t;
  {$EXTERNALSYM upl_t}
  vm_named_entry_t = mach_port_t;
  {$EXTERNALSYM vm_named_entry_t}

  mach_vm_address_t = UInt64;
  {$EXTERNALSYM mach_vm_address_t}
  mach_vm_offset_t = UInt64;
  {$EXTERNALSYM mach_vm_offset_t}
  mach_vm_size_t = UInt64;
  {$EXTERNALSYM mach_vm_size_t}
  vm_map_offset_t = UInt64;
  {$EXTERNALSYM vm_map_offset_t}
  vm_map_address_t = UInt64;
  {$EXTERNALSYM vm_map_address_t}
  vm_map_size_t = UInt64;
  {$EXTERNALSYM vm_map_size_t}

  { vm_prot.h }
  vm_prot_t = Integer;
  {$EXTERNALSYM vm_prot_t}
  { vm_types }
  vm_map_t = mach_port_t;
  {$EXTERNALSYM vm_map_t}

  { memory_object_types.h }
  memory_object_t = mach_port_t;
  {$EXTERNALSYM memory_object_t}

  { mach_host.h }
  clock_id_t = Integer;
  clock_serv_t = mach_port_t;

  { clock_types.h }
  mach_timespec_t = record
     tv_sec: Cardinal;
     tv_nsec: clock_res_t;
  end;
  {$EXTERNALSYM mach_timespec_t}

const
  SYSTEM_CLOCK = 0;
  {$EXTERNALSYM SYSTEM_CLOCK}
  CALENDAR_CLOCK = 1;
  {$EXTERNALSYM CALENDAR_CLOCK}
  REALTIME_CLOCK = 0;
  {$EXTERNALSYM REALTIME_CLOCK}

  MACH_PORT_RIGHT_RECEIVE : mach_port_right_t = 1;
  {$EXTERNALSYM MACH_PORT_RIGHT_RECEIVE}
  MACH_RCV_MSG = $00000002;
  {$EXTERNALSYM MACH_RCV_MSG}
  MACH_SEND_MSG = $00000001;
  {$EXTERNALSYM MACH_SEND_MSG}
  MACH_RCV_LARGE = $00000004;
  {$EXTERNALSYM MACH_RCV_LARGE}
  MACH_RCV_INTERRUPT = $00000400;
  {$EXTERNALSYM MACH_RCV_INTERRUPT}
  MACH_MSG_TIMEOUT_NONE : mach_msg_timeout_t = 0;
  {$EXTERNALSYM MACH_MSG_TIMEOUT_NONE}
  MACH_MSG_SUCCESS = 0;
  {$EXTERNALSYM MACH_MSG_SUCCESS}
  MACH_RCV_INTERRUPTED = $10004005;
  {$EXTERNALSYM MACH_RCV_INTERRUPTED}
  MACH_PORT_NULL = 0; // typing?
  {$EXTERNALSYM MACH_PORT_NULL}
  MACH_MSG_TYPE_MAKE_SEND: mach_msg_type_name_t = 20;
  {$EXTERNALSYM MACH_MSG_TYPE_MAKE_SEND}

  KERN_SUCCESS = 0;
  {$EXTERNALSYM KERN_SUCCESS}
  KERN_INVALID_ARGUMENT = 4;
  {$EXTERNALSYM KERN_INVALID_ARGUMENT}
  KERN_FAILURE = 5;
  {$EXTERNALSYM KERN_FAILURE}

  EXC_BAD_ACCESS = 1;
  {$EXTERNALSYM EXC_BAD_ACCESS}
  EXC_BAD_INSTRUCTION = 2;
  {$EXTERNALSYM EXC_BAD_INSTRUCTION}
  EXC_ARITHMETIC = 3;
  {$EXTERNALSYM EXC_ARITHMETIC}
  EXC_MASK_BAD_ACCESS = 1 shl EXC_BAD_ACCESS;
  {$EXTERNALSYM EXC_MASK_BAD_ACCESS}
  EXC_MASK_BAD_INSTRUCTION = 1 shl EXC_BAD_INSTRUCTION;
  {$EXTERNALSYM EXC_MASK_BAD_INSTRUCTION}
  EXC_MASK_ARITHMETIC = 1 shl EXC_ARITHMETIC;
  {$EXTERNALSYM EXC_MASK_ARITHMETIC}

  EXCEPTION_DEFAULT = 1;
  {$EXTERNALSYM EXCEPTION_DEFAULT}
  EXCEPTION_STATE = 2;
  {$EXTERNALSYM EXCEPTION_STATE}
  EXCEPTION_STATE_IDENTITY = 3;
  {$EXTERNALSYM EXCEPTION_STATE_IDENTITY}
  MACH_EXCEPTION_CODES = $80000000;
  {$EXTERNALSYM MACH_EXCEPTION_CODES}

{$IF     defined(CPUARM32) or defined(CPUARM64)}
// - mach\arm\thread_status.h
  ARM_THREAD_STATE = 1;
  {$EXTERNALSYM ARM_THREAD_STATE}
  ARM_UNIFIED_THREAD_STATE = ARM_THREAD_STATE;
  {$EXTERNALSYM ARM_UNIFIED_THREAD_STATE}
  ARM_VFP_STATE = 2;
  {$EXTERNALSYM ARM_VFP_STATE}
  ARM_EXCEPTION_STATE = 3;
  {$EXTERNALSYM ARM_EXCEPTION_STATE}
  ARM_DEBUG_STATE = 4;
  {$EXTERNALSYM ARM_DEBUG_STATE}
  THREAD_STATE_NONE = 5;
  {$EXTERNALSYM THREAD_STATE_NONE}
  ARM_THREAD_STATE64 = 6;
  {$EXTERNALSYM ARM_THREAD_STATE64}
  ARM_EXCEPTION_STATE64 = 7;
  {$EXTERNALSYM ARM_EXCEPTION_STATE64}
  ARM_THREAD_STATE32 = 9;
  {$EXTERNALSYM ARM_THREAD_STATE32}
  ARM_DEBUG_STATE32 = 14;
  {$EXTERNALSYM ARM_DEBUG_STATE32}
  ARM_DEBUG_STATE64 = 15;
  {$EXTERNALSYM ARM_DEBUG_STATE64}
  ARM_NEON_STATE = 16;
  {$EXTERNALSYM ARM_NEON_STATE}
  ARM_NEON_STATE64 = 17;
  {$EXTERNALSYM ARM_NEON_STATE64}
{$ELSEIF defined(CPUX86) or defined(CPUX64)}
// - mach\i386\thread_status.h
  x86_THREAD_STATE32 = 1;
  {$EXTERNALSYM x86_THREAD_STATE32}
  x86_FLOAT_STATE32 = 2;
  {$EXTERNALSYM x86_FLOAT_STATE32}
  x86_EXCEPTION_STATE32 = 3;
  {$EXTERNALSYM x86_EXCEPTION_STATE32}
  x86_THREAD_STATE64 = 4;
  {$EXTERNALSYM x86_THREAD_STATE64}
  x86_FLOAT_STATE64 = 5;
  {$EXTERNALSYM x86_FLOAT_STATE64}
  x86_EXCEPTION_STATE64 = 6;
  {$EXTERNALSYM x86_EXCEPTION_STATE64}
  x86_THREAD_STATE = 7;
  {$EXTERNALSYM x86_THREAD_STATE}
  x86_FLOAT_STATE = 8;
  {$EXTERNALSYM x86_FLOAT_STATE}
  x86_EXCEPTION_STATE = 9;
  {$EXTERNALSYM x86_EXCEPTION_STATE}
  x86_DEBUG_STATE32= 10;
  {$EXTERNALSYM x86_DEBUG_STATE32}
  x86_DEBUG_STATE64 = 11;
  {$EXTERNALSYM x86_DEBUG_STATE64}
  x86_DEBUG_STATE = 12;
  {$EXTERNALSYM x86_DEBUG_STATE}
  THREAD_STATE_NONE = 13;
  {$EXTERNALSYM THREAD_STATE_NONE}
  x86_AVX_STATE32 = 16;
  {$EXTERNALSYM x86_AVX_STATE32}
  x86_AVX_STATE64 = 17;
  {$EXTERNALSYM x86_AVX_STATE64}
  x86_AVX_STATE = 18;
  {$EXTERNALSYM x86_AVX_STATE}
{$ENDIF }

{$IF     defined(CPUARM32) or defined(CPUARM64)}
  MACHINE_THREAD_STATE = ARM_THREAD_STATE;
{$ELSEIF defined(CPUX86) or defined(CPUX64)}
  MACHINE_THREAD_STATE = x86_THREAD_STATE;
{$ENDIF }
  {$EXTERNALSYM MACHINE_THREAD_STATE}

  KERN_INVALID_ADDRESS = 1;
  {$EXTERNALSYM KERN_INVALID_ADDRESS}

  THREAD_STATE_MAX = 144;
  {$EXTERNALSYM THREAD_STATE_MAX}

  PROCESSOR_INFO_MAX = 1024;  (* max array size *)
  {$EXTERNALSYM PROCESSOR_INFO_MAX}
  PROCESSOR_SET_INFO_MAX = 1024; { max array size }
  {$EXTERNALSYM PROCESSOR_SET_INFO_MAX}

  PROCESSOR__BASIC_INFO         = 1;            (* basic information *)
  {$EXTERNALSYM PROCESSOR__BASIC_INFO}
  PROCESSOR__CPU_LOAD_INFO      = 2;            (* cpu load information *)
  {$EXTERNALSYM PROCESSOR__CPU_LOAD_INFO}
  PROCESSOR__PM_REGS_INFO       = $10000001;    (* performance monitor register info *)
  {$EXTERNALSYM PROCESSOR__PM_REGS_INFO}
  PROCESSOR__TEMPERATURE        = $10000002;    (* Processor core temperature *)
  {$EXTERNALSYM PROCESSOR__TEMPERATURE}

  CPU_STATE_MAX = 4;
  {$EXTERNALSYM CPU_STATE_MAX}

  CPU_STATE_USER = 0;
  {$EXTERNALSYM CPU_STATE_USER}
  CPU_STATE_SYSTEM = 1;
  {$EXTERNALSYM CPU_STATE_SYSTEM}
  CPU_STATE_IDLE = 2;
  {$EXTERNALSYM CPU_STATE_IDLE}
  CPU_STATE_NICE = 3;
  {$EXTERNALSYM CPU_STATE_NICE}

  {
   *    Scaling factor for load_average, mach_factor.
  }
  LOAD_SCALE = 1000;
  {$EXTERNALSYM LOAD_SCALE}

  PROCESSOR__SET_BASIC_INFO = 5;
  {$EXTERNALSYM PROCESSOR__SET_BASIC_INFO}

  PROCESSOR__SET_LOAD_INFO = 4;              (* scheduling statistics *)
  {$EXTERNALSYM PROCESSOR__SET_LOAD_INFO}

  {
  * Capability bits used in the definition of cpu_type.
  }
  CPU_ARCH_MASK = $ff000000;   { mask for architecture bits }
  {$EXTERNALSYM CPU_ARCH_MASK}
  CPU_ARCH_ABI64 = $01000000;  { 64 bit ABI }
  {$EXTERNALSYM CPU_ARCH_ABI64}

  {
  *     Machine types known by all.
  }

  CPU_TYPE_ANY = cpu_type_t(-1);
  {$EXTERNALSYM CPU_TYPE_ANY}

  CPU_TYPE_VAX = cpu_type_t(1);
  {$EXTERNALSYM CPU_TYPE_VAX}
  { skip                                ((cpu_type_t) 2)         }
  { skip                                ((cpu_type_t) 3)         }
  { skip                                ((cpu_type_t) 4)         }
  { skip                                ((cpu_type_t) 5)         }
  CPU_TYPE_MC680x0 = cpu_type_t(6);
  {$EXTERNALSYM CPU_TYPE_MC680x0}
  CPU_TYPE_X86 = cpu_type_t(7);
  {$EXTERNALSYM CPU_TYPE_X86}
  CPU_TYPE_I386 = CPU_TYPE_X86;           { compatibility }
  {$EXTERNALSYM CPU_TYPE_I386}
  CPU_TYPE_X86_64 = CPU_TYPE_X86 or CPU_ARCH_ABI64;
  {$EXTERNALSYM CPU_TYPE_X86_64}

  { skip CPU_TYPE_MIPS          ((cpu_type_t) 8)         }
  { skip                        ((cpu_type_t) 9)         }
  CPU_TYPE_MC98000 = cpu_type_t(10);
  {$EXTERNALSYM CPU_TYPE_MC98000}
  CPU_TYPE_HPPA = cpu_type_t(11);
  {$EXTERNALSYM CPU_TYPE_HPPA}
  CPU_TYPE_ARM = cpu_type_t(12);
  {$EXTERNALSYM CPU_TYPE_ARM}
  CPU_TYPE_ARM64 = cpu_type_t(CPU_TYPE_ARM or CPU_ARCH_ABI64);
  {$EXTERNALSYM CPU_TYPE_ARM64}
  CPU_TYPE_MC88000 = cpu_type_t(13);
  {$EXTERNALSYM CPU_TYPE_MC88000}
  CPU_TYPE_SPARC = cpu_type_t(14);
  {$EXTERNALSYM CPU_TYPE_SPARC}
  CPU_TYPE_I860 = cpu_type_t(15);
  {$EXTERNALSYM CPU_TYPE_I860}
  { skip        CPU_TYPE_ALPHA          ((cpu_type_t) 16)        }
  { skip                                ((cpu_type_t) 17)        }
  CPU_TYPE_POWERPC = cpu_type_t(18);
  {$EXTERNALSYM CPU_TYPE_POWERPC}
  CPU_TYPE_POWERPC64 = CPU_TYPE_POWERPC or CPU_ARCH_ABI64;
  {$EXTERNALSYM CPU_TYPE_POWERPC64}

  {
   *    Machine subtypes (these are defined here, instead of in a machine
   *    dependent directory, so that any program can get all definitions
   *    regardless of where is it compiled).
  }

  {
   * Capability bits used in the definition of cpu_subtype.
  }
  CPU_SUBTYPE_MASK = $ff000000;
  {$EXTERNALSYM CPU_SUBTYPE_MASK}
  CPU_SUBTYPE_LIB64 = $80000000;
  {$EXTERNALSYM CPU_SUBTYPE_LIB64}


  {
   *    Object files that are hand-crafted to run on any
   *    implementation of an architecture are tagged with
   *    CPU_SUBTYPE_MULTIPLE.  This functions essentially the same as
   *    the "ALL" subtype of an architecture except that it allows us
   *    to easily find object files that may need to be modified
   *    whenever a new implementation of an architecture comes out.
   *
   *    It is the responsibility of the implementor to make sure the
   *    software handles unsupported implementations elegantly.
  }
  CPU_SUBTYPE_MULTIPLE = cpu_subtype_t(-1);
  {$EXTERNALSYM CPU_SUBTYPE_MULTIPLE}
  CPU_SUBTYPE_LITTLE_ENDIAN = cpu_subtype_t(0);
  {$EXTERNALSYM CPU_SUBTYPE_LITTLE_ENDIAN}
  CPU_SUBTYPE_BIG_ENDIAN = cpu_subtype_t(1);
  {$EXTERNALSYM CPU_SUBTYPE_BIG_ENDIAN}

  {
   *     Machine threadtypes.
   *     This is none - not defined - for most machine types/subtypes.
  }
  CPU_THREADTYPE_NONE = cpu_threadtype_t(0);
  {$EXTERNALSYM CPU_THREADTYPE_NONE}

  {
   *    VAX subtypes (these do *not* necessary conform to the actual cpu
   *    ID assigned by DEC available via the SID register).
  }

  CPU_SUBTYPE_VAX_ALL = cpu_subtype_t(0);
  {$EXTERNALSYM CPU_SUBTYPE_VAX_ALL}
  CPU_SUBTYPE_VAX780 = cpu_subtype_t(1);
  {$EXTERNALSYM CPU_SUBTYPE_VAX780}
  CPU_SUBTYPE_VAX785 = cpu_subtype_t(2);
  {$EXTERNALSYM CPU_SUBTYPE_VAX785}
  CPU_SUBTYPE_VAX750 = cpu_subtype_t(3);
  {$EXTERNALSYM CPU_SUBTYPE_VAX750}
  CPU_SUBTYPE_VAX730 = cpu_subtype_t(4);
  {$EXTERNALSYM CPU_SUBTYPE_VAX730}
  CPU_SUBTYPE_UVAXI = cpu_subtype_t(5);
  {$EXTERNALSYM CPU_SUBTYPE_UVAXI}
  CPU_SUBTYPE_UVAXII = cpu_subtype_t(6);
  {$EXTERNALSYM CPU_SUBTYPE_UVAXII}
  CPU_SUBTYPE_VAX8200 = cpu_subtype_t(7);
  {$EXTERNALSYM CPU_SUBTYPE_VAX8200}
  CPU_SUBTYPE_VAX8500 = cpu_subtype_t(8);
  {$EXTERNALSYM CPU_SUBTYPE_VAX8500}
  CPU_SUBTYPE_VAX8600 = cpu_subtype_t(9);
  {$EXTERNALSYM CPU_SUBTYPE_VAX8600}
  CPU_SUBTYPE_VAX8650 = cpu_subtype_t(10);
  {$EXTERNALSYM CPU_SUBTYPE_VAX8650}
  CPU_SUBTYPE_VAX8800 = cpu_subtype_t(11);
  {$EXTERNALSYM CPU_SUBTYPE_VAX8800}
  CPU_SUBTYPE_UVAXIII = cpu_subtype_t(12);
  {$EXTERNALSYM CPU_SUBTYPE_UVAXIII}

  {
   *    680x0 subtypes
   *
   * The subtype definitions here are unusual for historical reasons.
   * NeXT used to consider 68030 code as generic 68000 code.  For
   * backwards compatability:
   *
   *    CPU_SUBTYPE_MC68030 symbol has been preserved for source code
   *    compatability.
   *
   *    CPU_SUBTYPE_MC680x0_ALL has been defined to be the same
   *    subtype as CPU_SUBTYPE_MC68030 for binary comatability.
   *
   *    CPU_SUBTYPE_MC68030_ONLY has been added to allow new object
   *    files to be tagged as containing 68030-specific instructions.
  }

  CPU_SUBTYPE_MC680x0_ALL = cpu_subtype_t(1);
  {$EXTERNALSYM CPU_SUBTYPE_MC680x0_ALL}
  CPU_SUBTYPE_MC68030 = cpu_subtype_t(1);
  {$EXTERNALSYM CPU_SUBTYPE_MC68030}
  CPU_SUBTYPE_MC68040 = cpu_subtype_t(2);
  {$EXTERNALSYM CPU_SUBTYPE_MC68040}
  CPU_SUBTYPE_MC68030_ONLY = cpu_subtype_t(3);
  {$EXTERNALSYM CPU_SUBTYPE_MC68030_ONLY}

  {
   *    I386 subtypes
  }

  CPU_SUBTYPE_I386_ALL = 3 + (0 shl 4);
  {$EXTERNALSYM CPU_SUBTYPE_I386_ALL}
  CPU_SUBTYPE_386 = 3 + (0 shl 4);
  {$EXTERNALSYM CPU_SUBTYPE_386}
  CPU_SUBTYPE_486 = 4 + (0 shl 4);
  {$EXTERNALSYM CPU_SUBTYPE_486}
  CPU_SUBTYPE_486SX = 4 + (8 shl 4);
  {$EXTERNALSYM CPU_SUBTYPE_486SX}
  CPU_SUBTYPE_586 = 5 + (0 shl 4);
  {$EXTERNALSYM CPU_SUBTYPE_586}
  CPU_SUBTYPE_PENT = 5 + (0 shl 4);
  {$EXTERNALSYM CPU_SUBTYPE_PENT}
  CPU_SUBTYPE_PENTPRO = 6 + (1 shl 4);
  {$EXTERNALSYM CPU_SUBTYPE_PENTPRO}
  CPU_SUBTYPE_PENTII_M3 = 6 + (3 shl 4);
  {$EXTERNALSYM CPU_SUBTYPE_PENTII_M3}
  CPU_SUBTYPE_PENTII_M5 = 6 + (5 shl 4);
  {$EXTERNALSYM CPU_SUBTYPE_PENTII_M5}
  CPU_SUBTYPE_CELERON = 7 + (6 shl 4);
  {$EXTERNALSYM CPU_SUBTYPE_CELERON}
  CPU_SUBTYPE_CELERON_MOBILE = 7 + (7 shl 4);
  {$EXTERNALSYM CPU_SUBTYPE_CELERON_MOBILE}
  CPU_SUBTYPE_PENTIUM_3 = 8 + (0 shl 4);
  {$EXTERNALSYM CPU_SUBTYPE_PENTIUM_3}
  CPU_SUBTYPE_PENTIUM_3_M = 8 + (1 shl 4);
  {$EXTERNALSYM CPU_SUBTYPE_PENTIUM_3_M}
  CPU_SUBTYPE_PENTIUM_3_XEON = 8 + (2 shl 4);
  {$EXTERNALSYM CPU_SUBTYPE_PENTIUM_3_XEON}
  CPU_SUBTYPE_PENTIUM_M = 9 + (0 shl 4);
  {$EXTERNALSYM CPU_SUBTYPE_PENTIUM_M}
  CPU_SUBTYPE_PENTIUM_4 = 10 + (0 shl 4);
  {$EXTERNALSYM CPU_SUBTYPE_PENTIUM_4}
  CPU_SUBTYPE_PENTIUM_4_M = 10 + (1 shl 4);
  {$EXTERNALSYM CPU_SUBTYPE_PENTIUM_4_M}
  CPU_SUBTYPE_ITANIUM = 11 + (0 shl 4);
  {$EXTERNALSYM CPU_SUBTYPE_ITANIUM}
  CPU_SUBTYPE_ITANIUM_2 = 11 + (1 shl 4);
  {$EXTERNALSYM CPU_SUBTYPE_ITANIUM_2}
  CPU_SUBTYPE_XEON = 12 + (0 shl 4);
  {$EXTERNALSYM CPU_SUBTYPE_XEON}
  CPU_SUBTYPE_XEON_MP = 12 + (1 shl 4);
  {$EXTERNALSYM CPU_SUBTYPE_XEON_MP}

  CPU_SUBTYPE_INTEL_FAMILY_MAX = 15;
  {$EXTERNALSYM CPU_SUBTYPE_INTEL_FAMILY_MAX}

  CPU_SUBTYPE_INTEL_MODEL_ALL = 0;
  {$EXTERNALSYM CPU_SUBTYPE_INTEL_MODEL_ALL}

  {
   *    X86 subtypes.
   }

  CPU_SUBTYPE_X86_ALL = cpu_subtype_t(3);
  {$EXTERNALSYM CPU_SUBTYPE_X86_ALL}
  CPU_SUBTYPE_X86_64_ALL = cpu_subtype_t(3);
  {$EXTERNALSYM CPU_SUBTYPE_X86_64_ALL}
  CPU_SUBTYPE_X86_ARCH1 = cpu_subtype_t(4);
  {$EXTERNALSYM CPU_SUBTYPE_X86_ARCH1}


  CPU_THREADTYPE_INTEL_HTT = cpu_threadtype_t(1);
  {$EXTERNALSYM CPU_THREADTYPE_INTEL_HTT}

  {
   *    Mips subtypes.
  }

  CPU_SUBTYPE_MIPS_ALL = cpu_subtype_t(0);
  {$EXTERNALSYM CPU_SUBTYPE_MIPS_ALL}
  CPU_SUBTYPE_MIPS_R2300 = cpu_subtype_t(1);
  {$EXTERNALSYM CPU_SUBTYPE_MIPS_R2300}
  CPU_SUBTYPE_MIPS_R2600 = cpu_subtype_t(2);
  {$EXTERNALSYM CPU_SUBTYPE_MIPS_R2600}
  CPU_SUBTYPE_MIPS_R2800 = cpu_subtype_t(3);
  {$EXTERNALSYM CPU_SUBTYPE_MIPS_R2800}
  CPU_SUBTYPE_MIPS_R2000a = cpu_subtype_t(4);
  {$EXTERNALSYM CPU_SUBTYPE_MIPS_R2000a}
  CPU_SUBTYPE_MIPS_R2000 = cpu_subtype_t(5);
  {$EXTERNALSYM CPU_SUBTYPE_MIPS_R2000}
  CPU_SUBTYPE_MIPS_R3000a = cpu_subtype_t(6);
  {$EXTERNALSYM CPU_SUBTYPE_MIPS_R3000a}
  CPU_SUBTYPE_MIPS_R3000 = cpu_subtype_t(7);
  {$EXTERNALSYM CPU_SUBTYPE_MIPS_R3000}

  {
   *    MC98000 (PowerPC) subtypes
  }
  CPU_SUBTYPE_MC98000_ALL = cpu_subtype_t(0);
  {$EXTERNALSYM CPU_SUBTYPE_MC98000_ALL}
  CPU_SUBTYPE_MC98601 = cpu_subtype_t(1);
  {$EXTERNALSYM CPU_SUBTYPE_MC98601}

  {
   *    HPPA subtypes for Hewlett-Packard HP-PA family of
   *    risc processors. Port by NeXT to 700 series.
  }

  CPU_SUBTYPE_HPPA_ALL = cpu_subtype_t(0);
  {$EXTERNALSYM CPU_SUBTYPE_HPPA_ALL}
  CPU_SUBTYPE_HPPA_7100 = cpu_subtype_t(0);
  {$EXTERNALSYM CPU_SUBTYPE_HPPA_7100}
  CPU_SUBTYPE_HPPA_7100LC = cpu_subtype_t(1);
  {$EXTERNALSYM CPU_SUBTYPE_HPPA_7100LC}

  {
   *    MC88000 subtypes.
  }
  CPU_SUBTYPE_MC88000_ALL = cpu_subtype_t(0);
  {$EXTERNALSYM CPU_SUBTYPE_MC88000_ALL}
  CPU_SUBTYPE_MC88100 = cpu_subtype_t(1);
  {$EXTERNALSYM CPU_SUBTYPE_MC88100}
  CPU_SUBTYPE_MC88110 = cpu_subtype_t(2);
  {$EXTERNALSYM CPU_SUBTYPE_MC88110}

  {
   *    SPARC subtypes
  }
  CPU_SUBTYPE_SPARC_ALL = cpu_subtype_t(0);
  {$EXTERNALSYM CPU_SUBTYPE_SPARC_ALL}

  {
   *    I860 subtypes
  }
  CPU_SUBTYPE_I860_ALL = cpu_subtype_t(0);
  {$EXTERNALSYM CPU_SUBTYPE_I860_ALL}
  CPU_SUBTYPE_I860_860 = cpu_subtype_t(1);
  {$EXTERNALSYM CPU_SUBTYPE_I860_860}

  {
   *    PowerPC subtypes
  }
  CPU_SUBTYPE_POWERPC_ALL = cpu_subtype_t(0);
  {$EXTERNALSYM CPU_SUBTYPE_POWERPC_ALL}
  CPU_SUBTYPE_POWERPC_601 = cpu_subtype_t(1);
  {$EXTERNALSYM CPU_SUBTYPE_POWERPC_601}
  CPU_SUBTYPE_POWERPC_602 = cpu_subtype_t(2);
  {$EXTERNALSYM CPU_SUBTYPE_POWERPC_602}
  CPU_SUBTYPE_POWERPC_603 = cpu_subtype_t(3);
  {$EXTERNALSYM CPU_SUBTYPE_POWERPC_603}
  CPU_SUBTYPE_POWERPC_603e = cpu_subtype_t(4);
  {$EXTERNALSYM CPU_SUBTYPE_POWERPC_603e}
  CPU_SUBTYPE_POWERPC_603ev = cpu_subtype_t(5);
  {$EXTERNALSYM CPU_SUBTYPE_POWERPC_603ev}
  CPU_SUBTYPE_POWERPC_604 = cpu_subtype_t(6);
  {$EXTERNALSYM CPU_SUBTYPE_POWERPC_604}
  CPU_SUBTYPE_POWERPC_604e = cpu_subtype_t(7);
  {$EXTERNALSYM CPU_SUBTYPE_POWERPC_604e}
  CPU_SUBTYPE_POWERPC_620 = cpu_subtype_t(8);
  {$EXTERNALSYM CPU_SUBTYPE_POWERPC_620}
  CPU_SUBTYPE_POWERPC_750 = cpu_subtype_t(9);
  {$EXTERNALSYM CPU_SUBTYPE_POWERPC_750}
  CPU_SUBTYPE_POWERPC_7400 = cpu_subtype_t(10);
  {$EXTERNALSYM CPU_SUBTYPE_POWERPC_7400}
  CPU_SUBTYPE_POWERPC_7450 = cpu_subtype_t(11);
  {$EXTERNALSYM CPU_SUBTYPE_POWERPC_7450}
  CPU_SUBTYPE_POWERPC_970 = cpu_subtype_t(100);
  {$EXTERNALSYM CPU_SUBTYPE_POWERPC_970}

  {
   *    ARM subtypes
  }
  CPU_SUBTYPE_ARM_ALL = cpu_subtype_t(0);
  {$EXTERNALSYM CPU_SUBTYPE_ARM_ALL}
  CPU_SUBTYPE_ARM_V4T = cpu_subtype_t(5);
  {$EXTERNALSYM CPU_SUBTYPE_ARM_V4T}
  CPU_SUBTYPE_ARM_V6 = cpu_subtype_t(6);
  {$EXTERNALSYM CPU_SUBTYPE_ARM_V6}
  CPU_SUBTYPE_ARM_V5TEJ = cpu_subtype_t(7);
  {$EXTERNALSYM CPU_SUBTYPE_ARM_V5TEJ}
  CPU_SUBTYPE_ARM_XSCALE = cpu_subtype_t(8);
  {$EXTERNALSYM CPU_SUBTYPE_ARM_XSCALE}
  CPU_SUBTYPE_ARM_V7 = cpu_subtype_t(9);
  {$EXTERNALSYM CPU_SUBTYPE_ARM_V7}
  CPU_SUBTYPE_ARM_V7F = cpu_subtype_t(10);
  {$EXTERNALSYM CPU_SUBTYPE_ARM_V7F}
  CPU_SUBTYPE_ARM_V7S = cpu_subtype_t(11);
  {$EXTERNALSYM CPU_SUBTYPE_ARM_V7S}
  CPU_SUBTYPE_ARM_V7K = cpu_subtype_t(12);
  {$EXTERNALSYM CPU_SUBTYPE_ARM_V7K}

  {
   *    CPU families (sysctl hw.cpufamily)
   *
   * These are meant to identify the CPU's marketing name - an
   * application can map these to (possibly) localized strings.
   * NB: the encodings of the CPU families are intentionally arbitrary.
   * There is no ordering, and you should never try to deduce whether
   * or not some feature is available based on the family.
   * Use feature flags (eg, hw.optional.altivec) to test for optional
   * functionality.
  }
  CPUFAMILY_UNKNOWN = 0;
  {$EXTERNALSYM CPUFAMILY_UNKNOWN}
  CPUFAMILY_POWERPC_G3 = $cee41549;
  {$EXTERNALSYM CPUFAMILY_POWERPC_G3}
  CPUFAMILY_POWERPC_G4 = $77c184ae;
  {$EXTERNALSYM CPUFAMILY_POWERPC_G4}
  CPUFAMILY_POWERPC_G5 = $ed76d8aa;
  {$EXTERNALSYM CPUFAMILY_POWERPC_G5}
  CPUFAMILY_INTEL_6_13 = $aa33392b;
  {$EXTERNALSYM CPUFAMILY_INTEL_6_13}
  CPUFAMILY_INTEL_YONAH = $73d67300;
  {$EXTERNALSYM CPUFAMILY_INTEL_YONAH}
  CPUFAMILY_INTEL_MEROM = $426f69ef;
  {$EXTERNALSYM CPUFAMILY_INTEL_MEROM}
  CPUFAMILY_INTEL_PENRYN = $78ea4fbc;
  {$EXTERNALSYM CPUFAMILY_INTEL_PENRYN}
  CPUFAMILY_INTEL_NEHALEM = $6b5a4cd2;
  {$EXTERNALSYM CPUFAMILY_INTEL_NEHALEM}
  CPUFAMILY_INTEL_WESTMERE = $573b5eec;
  {$EXTERNALSYM CPUFAMILY_INTEL_WESTMERE}
  CPUFAMILY_INTEL_SANDYBRIDGE = $5490b78c;
  {$EXTERNALSYM CPUFAMILY_INTEL_SANDYBRIDGE}
  CPUFAMILY_ARM_9 = $e73283ae;
  {$EXTERNALSYM CPUFAMILY_ARM_9}
  CPUFAMILY_ARM_11 = $8ff620d8;
  {$EXTERNALSYM CPUFAMILY_ARM_11}
  CPUFAMILY_ARM_XSCALE = $53b005f5;
  {$EXTERNALSYM CPUFAMILY_ARM_XSCALE}
  CPUFAMILY_ARM_12 = $bd1b0ae9;
  {$EXTERNALSYM CPUFAMILY_ARM_12}
  CPUFAMILY_ARM_13 = $0cc90e64;
  {$EXTERNALSYM CPUFAMILY_ARM_13}
  CPUFAMILY_ARM_14 = $96077ef1;
  {$EXTERNALSYM CPUFAMILY_ARM_14}
  CPUFAMILY_ARM_SWIFT = $1e2d6381;
  {$EXTERNALSYM CPUFAMILY_ARM_SWIFT}

  { The following synonyms are deprecated: }
  CPUFAMILY_INTEL_6_14 = CPUFAMILY_INTEL_YONAH;
  {$EXTERNALSYM CPUFAMILY_INTEL_6_14}
  CPUFAMILY_INTEL_6_15 = CPUFAMILY_INTEL_MEROM;
  {$EXTERNALSYM CPUFAMILY_INTEL_6_15}
  CPUFAMILY_INTEL_6_23 = CPUFAMILY_INTEL_PENRYN;
  {$EXTERNALSYM CPUFAMILY_INTEL_6_23}
  CPUFAMILY_INTEL_6_26 = CPUFAMILY_INTEL_NEHALEM;
  {$EXTERNALSYM CPUFAMILY_INTEL_6_26}

  CPUFAMILY_INTEL_CORE = CPUFAMILY_INTEL_YONAH;
  {$EXTERNALSYM CPUFAMILY_INTEL_CORE}
  CPUFAMILY_INTEL_CORE2 = CPUFAMILY_INTEL_MEROM;
  {$EXTERNALSYM CPUFAMILY_INTEL_CORE2}

  HOST__BASIC_INFO = 1; { basic info }
  {$EXTERNALSYM HOST__BASIC_INFO}
  HOST__SCHED_INFO = 3; { scheduling info }
  {$EXTERNALSYM HOST__SCHED_INFO}
  HOST__RESOURCE_SIZES = 4; { kernel struct sizes }
  {$EXTERNALSYM HOST__RESOURCE_SIZES}
  HOST__PRIORITY_INFO = 5; { priority information }
  {$EXTERNALSYM HOST__PRIORITY_INFO}
  HOST__SEMAPHORE_TRAPS = 7; { Has semaphore traps }
  {$EXTERNALSYM HOST__SEMAPHORE_TRAPS}
  HOST__MACH_MSG_TRAP = 8; { Has mach_msg_trap }
  {$EXTERNALSYM HOST__MACH_MSG_TRAP}

  { host_statistics() }
  HOST__LOAD_INFO = 1;
  {$EXTERNALSYM HOST__LOAD_INFO}
  HOST__VM_INFO = 2;
  {$EXTERNALSYM HOST__VM_INFO}
  HOST__CPU_LOAD_INFO = 3;
  {$EXTERNALSYM HOST__CPU_LOAD_INFO}

  { host_statistics64() }
  HOST_VM_INFO64 = 4;
  {$EXTERNALSYM HOST_VM_INFO64}
  HOST_EXTMOD_INFO64 = 5;
  {$EXTERNALSYM HOST_EXTMOD_INFO64}

  HOST_INFO_MAX = 1024; { max array size }
  {$EXTERNALSYM HOST_INFO_MAX}

  KERNEL_VERSION_MAX = 512;
  {$EXTERNALSYM KERNEL_VERSION_MAX}

  KERNEL_BOOT_INFO_MAX = 4096;
  {$EXTERNALSYM KERNEL_BOOT_INFO_MAX}

  VM_PROT_NONE = vm_prot_t($00);
  {$EXTERNALSYM VM_PROT_NONE}
  VM_PROT_READ = vm_prot_t($01); { read permission }
  {$EXTERNALSYM VM_PROT_READ}
  VM_PROT_WRITE = vm_prot_t($02); { write permission }
  {$EXTERNALSYM VM_PROT_WRITE}
  VM_PROT_EXECUTE = vm_prot_t($04); { execute permission }
  {$EXTERNALSYM VM_PROT_EXECUTE}

  {
   *    The default protection for newly-created virtual memory
  }
  VM_PROT_DEFAULT = VM_PROT_READ or VM_PROT_WRITE;
  {$EXTERNALSYM VM_PROT_DEFAULT}

  {
   *    The maximum privileges possible, for parameter checking.
  }
  VM_PROT_ALL = VM_PROT_READ or VM_PROT_WRITE or VM_PROT_EXECUTE;
  {$EXTERNALSYM VM_PROT_ALL}

  {
   *    An invalid protection value.
   *    Used only by memory_object_lock_request to indicate no change
   *    to page locks.  Using -1 here is a bad idea because it
   *    looks like VM_PROT_ALL and then some.
  }
  VM_PROT_NO_CHANGE = vm_prot_t($08);
  {$EXTERNALSYM VM_PROT_NO_CHANGE}

  {
   *      When a caller finds that he cannot obtain write permission on a
   *      mapped entry, the following flag can be used.  The entry will
   *      be made "needs copy" effectively copying the object (using COW),
   *      and write permission will be added to the maximum protections
   *      for the associated entry.
  }
  VM_PROT_COPY = vm_prot_t($10);
  {$EXTERNALSYM VM_PROT_COPY}

  {
   *    Another invalid protection value.
   *    Used only by memory_object_data_request upon an object
   *    which has specified a copy_call copy strategy. It is used
   *    when the kernel wants a page belonging to a copy of the
   *    object, and is only asking the object as a result of
   *    following a shadow chain. This solves the race between pages
   *    being pushed up by the memory manager and the kernel
   *    walking down the shadow chain.
  }
  VM_PROT_WANTS_COPY = vm_prot_t($10);
  {$EXTERNALSYM VM_PROT_WANTS_COPY}

  {
   *    Another invalid protection value.
   *    Indicates that the other protection bits are to be applied as a mask
   *    against the actual protection bits of the map entry.
  }
  VM_PROT_IS_MASK = vm_prot_t($40);
  {$EXTERNALSYM VM_PROT_IS_MASK}

  UPL_NULL = upl_t(0);
  {$EXTERNALSYM UPL_NULL}
  VM_NAMED_ENTRY_NULL = vm_named_entry_t(0);
  {$EXTERNALSYM VM_NAMED_ENTRY_NULL}

type
   thread_state_data_t = array [0..THREAD_STATE_MAX - 1] of natural_t;
   {$EXTERNALSYM thread_state_data_t}

{$IF     defined(CPUARM32) or defined(CPUARM64)}
// include\mach\arm\_structs.h
// include\mach\arm\thread_status.h - arm_exception_state_t arm_exception_state64_t

   _STRUCT_ARM_EXCEPTION_STATE = record
      __exception: UInt32; // number of arm exception taken
      __fsr: UInt32; // Fault status
      __far: UInt32; // Virtual Fault Address
   end;
   {$EXTERNALSYM _STRUCT_ARM_EXCEPTION_STATE}
   arm_exception_state_t = _STRUCT_ARM_EXCEPTION_STATE;
   {$EXTERNALSYM arm_exception_state_t}
   arm_exception_state32_t = _STRUCT_ARM_EXCEPTION_STATE;
   {$EXTERNALSYM arm_exception_state32_t}

   _STRUCT_ARM_EXCEPTION_STATE64 = record
      __far: UInt64; // Virtual Fault Address
      __esr: UInt32; // Exception syndrome
      __exception: UInt32; // number of arm exception taken
   end;
   {$EXTERNALSYM _STRUCT_ARM_EXCEPTION_STATE64}
   arm_exception_state64_t = _STRUCT_ARM_EXCEPTION_STATE64;
   {$EXTERNALSYM arm_exception_state64_t}

// include\mach\arm\_structs.h
// include\mach\arm\thread_status.h - arm_thread_state_t, arm_thread_state32_t
   _STRUCT_ARM_THREAD_STATE = record
      __r: array[0..12] of UInt32;
      __sp: UInt32;
      __lr: UInt32;
      __pc: UInt32;
      __cpsr: UInt32;
   end;
   {$EXTERNALSYM _STRUCT_ARM_THREAD_STATE}
   arm_thread_state_t = _STRUCT_ARM_THREAD_STATE;
   {$EXTERNALSYM arm_thread_state_t}
   arm_thread_state32_t = _STRUCT_ARM_THREAD_STATE;
   {$EXTERNALSYM arm_thread_state32_t}
   Parm_thread_state_t = ^arm_thread_state_t;
   {$EXTERNALSYM Parm_thread_state_t}
   Parm_thread_state32_t = ^arm_thread_state32_t;
   {$EXTERNALSYM Parm_thread_state32_t}

// include\mach\arm\_structs.h
// include\mach\arm\thread_status.h - arm_thread_state64_t
   _STRUCT_ARM_THREAD_STATE64 = record
      __x: array[0..28] of UInt64;
      __fp: UInt64;
      __lr: UInt64;
      __sp: UInt64;
      __pc: UInt64;
      __cpsr: UInt32;
      __pad: UInt32;
   end;
   {$EXTERNALSYM _STRUCT_ARM_THREAD_STATE64}
   arm_thread_state64_t = _STRUCT_ARM_THREAD_STATE64;
   {$EXTERNALSYM arm_thread_state64_t}
   Parm_thread_state64_t = ^arm_thread_state64_t;
   {$EXTERNALSYM Parm_thread_state64_t}

// include\mach\arm\thread_status.h - arm_state_hdr
   arm_state_hdr = record
      flavor: UInt32;
      count : UInt32;
   end;
   {$EXTERNALSYM arm_state_hdr}
   arm_state_hdr_t = arm_state_hdr;
   {$EXTERNALSYM arm_state_hdr_t}

// include\mach\arm\thread_status.h - arm_unified_thread_state
  arm_unified_thread_state_t = record
    ash: arm_state_hdr_t;
    case integer of
      32: (ts_32: arm_thread_state32_t);
      64: (ts_64: arm_thread_state64_t);
  end;
  {$EXTERNALSYM arm_unified_thread_state_t}
  Parm_unified_thread_state_t = ^arm_unified_thread_state_t;
  {$EXTERNALSYM Parm_unified_thread_state_t}

   arm_vfp_state_t = record
      __r: array[0..63] of UInt32;
      __fpscr: UInt32;
   end;
   {$EXTERNALSYM arm_vfp_state_t}

const
// include\mach\arm\thread_status.h - ARM_THREAD_STATE_COUNT, ARM_THREAD_STATE32_COUNT,
//                                    ARM_THREAD_STATE64_COUNT, ARM_UNIFIED_THREAD_STATE_COUNT
   ARM_THREAD_STATE_COUNT = sizeof(arm_thread_state_t) div sizeof(UInt32);
   {$EXTERNALSYM ARM_THREAD_STATE_COUNT}
   ARM_THREAD_STATE32_COUNT = sizeof(arm_thread_state32_t) div sizeof(UInt32);
   {$EXTERNALSYM ARM_THREAD_STATE32_COUNT}
   ARM_THREAD_STATE64_COUNT = sizeof(arm_thread_state64_t) div sizeof(UInt32);
   {$EXTERNALSYM ARM_THREAD_STATE64_COUNT}
   ARM_UNIFIED_THREAD_STATE_COUNT = sizeof(arm_unified_thread_state_t) div sizeof(UInt32);
   {$EXTERNALSYM ARM_UNIFIED_THREAD_STATE_COUNT}

{$ELSEIF defined(CPUX86) or defined(CPUX64)}
   x86_state_hdr_t = record
      flavor: Integer;
      count: Integer;
   end;
   {$EXTERNALSYM x86_state_hdr_t}
   x86_exception_state32_t = record
      __trapno: UInt16;
      __cpu: UInt16;
      __err: UInt32;
      __faultvaddr: UInt32;
   end;
   {$EXTERNALSYM x86_exception_state32_t}
   x86_exception_state64_t = record
      __trapno: UInt16;
      __cpu: UInt16;
      __err: UInt32;
      __faultvaddr: UInt64;
   end;
   {$EXTERNALSYM x86_exception_state64_t}
   x86_exception_state_t = record
      esh: x86_state_hdr_t;
      case Integer of
        0: (es32: x86_exception_state32_t);
        1: (es64: x86_exception_state64_t);
   end;
   {$EXTERNALSYM x86_exception_state_t}
   xmm_reg = record
      xmm_reg: array[0..15] of Byte;
   end;
   {$EXTERNALSYM xmm_reg}
   mmst_reg = record
      mmst_reg: array[0..9] of Byte;
      mmst_rsrv: array[0..5] of Byte;
   end;
   {$EXTERNALSYM mmst_reg}
   x86_float_state32_t = record
      fpu_reserved: array [0..1] of Integer;
      fpu_fcw: UInt16;
      fpu_fsw: UInt16;
      fpu_ftw: UInt8;
      fpu_rsrv1: UInt8;
      fpu_fop: UInt16;
      fpu_ip: UInt32;
      fpu_cs: UInt16;
      fpu_rsrv2: UInt16;
      fpu_dp: UInt32;
      fpu_ds: UInt16;
      fpu_rsrv3: UInt16;
      fpu_mxcsr: UInt32;
      fpu_mxmask: UInt32;
      fpu_stmm0: mmst_reg;
      fpu_stmm1: mmst_reg;
      fpu_stmm2: mmst_reg;
      fpu_stmm3: mmst_reg;
      fpu_stmm4: mmst_reg;
      fpu_stmm5: mmst_reg;
      fpu_stmm6: mmst_reg;
      fpu_stmm7: mmst_reg;
      fpu_xmm0: xmm_reg;
      fpu_xmm1: xmm_reg;
      fpu_xmm2: xmm_reg;
      fpu_xmm3: xmm_reg;
      fpu_xmm4: xmm_reg;
      fpu_xmm5: xmm_reg;
      fpu_xmm6: xmm_reg;
      fpu_xmm7: xmm_reg;
      fpu_rsrv4: array [0..14*16 - 1] of Byte;
      fpu_reserved1: Integer;
   end;
   {$EXTERNALSYM x86_float_state32_t}
   x86_float_state64_t = record
      fpu_reserved: array [0..1] of Integer;
      fpu_fcw: UInt16;
      fpu_fsw: UInt16;
      fpu_ftw: UInt8;
      fpu_rsrv1: UInt8;
      fpu_fop: UInt16;
      fpu_ip: UInt32;
      fpu_cs: UInt16;
      fpu_rsrv2: UInt16;
      fpu_dp: UInt32;
      fpu_ds: UInt16;
      fpu_rsrv3: UInt16;
      fpu_mxcsr: UInt32;
      fpu_mxmask: UInt32;
      fpu_stmm0: mmst_reg;
      fpu_stmm1: mmst_reg;
      fpu_stmm2: mmst_reg;
      fpu_stmm3: mmst_reg;
      fpu_stmm4: mmst_reg;
      fpu_stmm5: mmst_reg;
      fpu_stmm6: mmst_reg;
      fpu_stmm7: mmst_reg;
      fpu_xmm0: xmm_reg;
      fpu_xmm1: xmm_reg;
      fpu_xmm2: xmm_reg;
      fpu_xmm3: xmm_reg;
      fpu_xmm4: xmm_reg;
      fpu_xmm5: xmm_reg;
      fpu_xmm6: xmm_reg;
      fpu_xmm7: xmm_reg;
      fpu_xmm8: xmm_reg;
      fpu_xmm9: xmm_reg;
      fpu_xmm10:xmm_reg;
      fpu_xmm11:xmm_reg;
      fpu_xmm12:xmm_reg;
      fpu_xmm13:xmm_reg;
      fpu_xmm14:xmm_reg;
      fpu_xmm15:xmm_reg;
      fpu_rsrv4: array [0..6*16 - 1] of Byte;
      fpu_reserved1: Integer;
   end;
   {$EXTERNALSYM x86_float_state64_t}
   x86_float_state_t = record
      fsh: x86_state_hdr_t;
      case Integer of
        0: (fs32: x86_float_state32_t);
        1: (fs64: x86_float_state64_t);
   end;
   {$EXTERNALSYM x86_float_state_t}
   x86_thread_state32_t = record
      eax: UInt32;
      ebx: UInt32;
      ecx: UInt32;
      edx: UInt32;
      edi: UInt32;
      esi: UInt32;
      ebp: UInt32;
      esp: UInt32;
      ss: UInt32;
      eflags: UInt32;
      eip: UInt32;
      cs: UInt32;
      ds: UInt32;
      es: UInt32;
      fs: UInt32;
      gs: UInt32;
   end;
   {$EXTERNALSYM x86_thread_state32_t}
   x86_thread_state64_t = record
      rax: UInt64;
      rbx: UInt64;
      rcx: UInt64;
      rdx: UInt64;
      rdi: UInt64;
      rsi: UInt64;
      rbp: UInt64;
      rsp: UInt64;
      r8:  UInt64;
      r9:  UInt64;
      r10: UInt64;
      r11: UInt64;
      r12: UInt64;
      r13: UInt64;
      r14: UInt64;
      r15: UInt64;
      rip: UInt64;
      rflags: UInt64;
      cs:  UInt64;
      fs:  UInt64;
      gs:  UInt64;
   end;
   {$EXTERNALSYM x86_thread_state64_t}
   x86_thread_state_t = record
      tsh: x86_state_hdr_t;
      case Integer of
        0: (ts32: x86_thread_state32_t);
        1: (ts64: x86_thread_state64_t);
   end;
   {$EXTERNALSYM x86_thread_state_t}
   Px86_thread_state_t = ^x86_thread_state_t;

{$ENDIF }

{$IF     defined(CPUARM32) or defined(CPUARM64)}
   ARM_VFP_STATE_COUNT = SizeOf(arm_vfp_state_t) div SizeOf(UInt32);
   {$EXTERNALSYM ARM_VFP_STATE_COUNT}
   ARM_EXCEPTION_STATE_COUNT = SizeOf(arm_exception_state_t) div SizeOf(UInt32);
   {$EXTERNALSYM ARM_EXCEPTION_STATE_COUNT}
   ARM_EXCEPTION_STATE64_COUNT = SizeOf(arm_exception_state64_t) div SizeOf(UInt32);
   {$EXTERNALSYM ARM_EXCEPTION_STATE64_COUNT}
//   ARM_DEBUG_STATE_COUNT = SizeOf(arm_debug_state_t) div SizeOf(UInt32);
//   {$EXTERNALSYM ARM_DEBUG_STATE_COUNT}
//   ARM_DEBUG_STATE32_COUNT = SizeOf(arm_debug_state32_t) div SizeOf(UInt32);
//   {$EXTERNALSYM ARM_DEBUG_STATE32_COUNT}
//   ARM_DEBUG_STATE64_COUNT = SizeOf(arm_debug_state64_t) div SizeOf(UInt32);
//   {$EXTERNALSYM ARM_DEBUG_STATE64_COUNT}
//   ARM_NEON_STATE_COUNT = SizeOf(arm_neon_state_t) div SizeOf(UInt32);
//   {$EXTERNALSYM ARM_NEON_STATE_COUNT}
//   ARM_NEON_STATE64_COUNT = SizeOf(arm_neon_state64_t) div SizeOf(UInt32);
//   {$EXTERNALSYM ARM_NEON_STATE64_COUNT}

   MACHINE_THREAD_STATE_COUNT = ARM_UNIFIED_THREAD_STATE_COUNT;
   {$EXTERNALSYM MACHINE_THREAD_STATE_COUNT}
{$ELSEIF defined(CPUX86) or defined(CPUX64)}
// - mach\i386\thread_status.h
const
   x86_THREAD_STATE_COUNT = SizeOf(x86_thread_state_t) div SizeOf(UInt32);
   {$EXTERNALSYM x86_THREAD_STATE_COUNT}
   x86_FLOAT_STATE_COUNT = SizeOf(x86_float_state_t) div SizeOf(UInt32);
   {$EXTERNALSYM x86_FLOAT_STATE_COUNT}
   x86_EXCEPTION_STATE_COUNT = SizeOf(x86_exception_state_t) div SizeOf(UInt32);
   {$EXTERNALSYM x86_EXCEPTION_STATE_COUNT}
//   x86_DEBUG_STATE_COUNT = SizeOf(x86_debug_state_t) div SizeOf(UInt32);
//   {$EXTERNALSYM x86_DEBUG_STATE_COUNT}
//   x86_AVX_STATE_COUNT = SizeOf(x86_avx_state_t) div SizeOf(UInt32);
//   {$EXTERNALSYM x86_AVX_STATE_COUNT}

   MACHINE_THREAD_STATE_COUNT = x86_THREAD_STATE_COUNT;
   {$EXTERNALSYM MACHINE_THREAD_STATE_COUNT}
{$ENDIF }

  { processor_info.h }
type
  (*
   *    Generic information structure to allow for expansion.
   *)
  processor_info_t = ^Integer;    (* varying array of int. *)
  {$EXTERNALSYM processor_info_t}
  processor_info_array_t = ^Integer;  (* varying array of int *)
  {$EXTERNALSYM processor_info_array_t}

  processor_info_data_t = array[0.. PROCESSOR_INFO_MAX - 1] of Integer;
  {$EXTERNALSYM processor_info_data_t}

  processor_set_info_t = ^Integer;      (* varying array of int. *)
  {$EXTERNALSYM processor_set_info_t}

  processor_set_info_data_t = array[0..PROCESSOR_SET_INFO_MAX - 1] of Integer;
  {$EXTERNALSYM processor_set_info_data_t}

  (*
   *    Currently defined information.
   *)
  processor_flavor_t = Integer;
  {$EXTERNALSYM processor_flavor_t}

  processor_basic_info = record
    cpu_type: cpu_type_t;               (* type of cpu *)
    cpu_subtype: cpu_subtype_t;         (* subtype of cpu *)
    running: boolean_t;                 (* is processor running *)
    slot_num: Integer;                  (* slot number *)
    is_master: boolean_t;               (* is this the master processor *)
  end;
  {$EXTERNALSYM processor_basic_info}

  processor_basic_info_data_t = processor_basic_info;
  {$EXTERNALSYM processor_basic_info_data_t}
  processor_basic_info_t = ^processor_basic_info;
  {$EXTERNALSYM processor_basic_info_t}

  processor_cpu_load_info = record
    cpu_ticks: array[0..CPU_STATE_MAX-1] of UInt32;
  end;
  {$EXTERNALSYM processor_cpu_load_info}

  processor_cpu_load_info_data_t = processor_cpu_load_info;
  {$EXTERNALSYM processor_cpu_load_info_data_t}
  processor_cpu_load_info_t = ^processor_cpu_load_info;
  {$EXTERNALSYM processor_cpu_load_info_t}

  processor_set_basic_info = record
    processor_count: Integer;                   (* How many processors *)
    default_policy: Integer;                    (* When others not enabled *)
  end;
  {$EXTERNALSYM processor_set_basic_info}

  processor_set_basic_info_data_t = processor_set_basic_info;
  {$EXTERNALSYM processor_set_basic_info_data_t}
  processor_set_basic_info_t = ^processor_set_basic_info;
  {$EXTERNALSYM processor_set_basic_info_t}

  processor_set_load_info = record
    task_count: Integer;                      (* How many tasks *)
    thread_count: Integer;                    (* How many threads *)
    load_average: Integer;                    (* Scaled *)
    mach_factor: Integer;                     (* Scaled *)
  end;
  {$EXTERNALSYM processor_set_load_info}

  processor_set_load_info_data_t = processor_set_load_info;
  {$EXTERNALSYM processor_set_load_info_data_t}
  processor_set_load_info_t = ^processor_set_load_info;
  {$EXTERNALSYM processor_set_load_info_t}

  {$ALIGN 4}
  host_basic_info = record
    max_cpus: Integer;                { max number of CPUs possible }
    avail_cpus: Integer;              { number of CPUs now available }
    memory_size: natural_t;           { size of memory in bytes, capped at 2 GB }
    cpu_type: cpu_type_t;             { cpu type }
    cpu_subtype: cpu_subtype_t;       { cpu subtype }
    cpu_threadtype: cpu_threadtype_t; { cpu threadtype }
    physical_cpu: Integer;            { number of physical CPUs now available }
    physical_cpu_max: Integer;        { max number of physical CPUs possible }
    logical_cpu: Integer;             { number of logical cpu now available }
    logical_cpu_max: Integer;         { max number of physical CPUs possible }
    max_mem: UInt64;                  { actual size of physical memory }
  end;
  {$EXTERNALSYM host_basic_info}
  {$ALIGN ON}
  host_basic_info_data_t = host_basic_info;
  {$EXTERNALSYM host_basic_info_data_t}
  host_basic_info_t = ^host_basic_info;
  {$EXTERNALSYM host_basic_info_t}

  host_sched_info = record
    min_timeout: Integer;           { minimum timeout in milliseconds }
    min_quantum: Integer;           { minimum quantum in milliseconds }
  end;
  {$EXTERNALSYM host_sched_info}
  host_sched_info_data_t = host_sched_info;
  {$EXTERNALSYM host_sched_info_data_t}
  host_sched_info_t = ^host_sched_info;
  {$EXTERNALSYM host_sched_info_t}

  kernel_resource_sizes = record
    task: natural_t;
    thread: natural_t;
    port: natural_t;
    memory_region: natural_t;
    memory_object: natural_t;
  end;
  {$EXTERNALSYM kernel_resource_sizes}
  kernel_resource_sizes_data_t = kernel_resource_sizes;
  {$EXTERNALSYM kernel_resource_sizes_data_t}
  kernel_resource_sizes_t = ^kernel_resource_sizes;
  {$EXTERNALSYM kernel_resource_sizes_t}

  host_priority_info = record
    kernel_priority: Integer;
    system_priority: Integer;
    server_priority: Integer;
    user_priority: Integer;
    depress_priority: Integer;
    idle_priority: Integer;
    minimum_priority: Integer;
    maximum_priority: Integer;
  end;
  {$EXTERNALSYM host_priority_info}
  host_priority_info_data_t = host_priority_info;
  {$EXTERNALSYM host_priority_info_data_t}
  host_priority_info_t = ^host_priority_info;
  {$EXTERNALSYM host_priority_info_t}

  host_load_info = record
    avenrun: array[0..2] of Integer;
    mach_factor: array[0..2] of Integer;
  end;
  {$EXTERNALSYM host_load_info}
  host_load_info_data_t = host_load_info;
  {$EXTERNALSYM host_load_info_data_t}
  host_load_info_t = ^host_load_info;
  {$EXTERNALSYM host_load_info_t}

  host_cpu_load_info = record
    cpu_ticks: array[0..CPU_STATE_MAX-1] of natural_t;
  end;
  {$EXTERNALSYM host_cpu_load_info}
  host_cpu_load_info_data_t = host_cpu_load_info;
  {$EXTERNALSYM host_cpu_load_info_data_t}
  host_cpu_load_info_t = ^host_cpu_load_info;
  {$EXTERNALSYM host_cpu_load_info_t}

  host_info_data_t = array[0..HOST_INFO_MAX-1] of Integer;
  {$EXTERNALSYM host_info_data_t}

  kernel_version_t = array[0..KERNEL_VERSION_MAX-1] of Byte;
  {$EXTERNALSYM kernel_version_t}

  kernel_boot_info_t = array[0..KERNEL_BOOT_INFO_MAX-1] of Byte;
  {$EXTERNALSYM kernel_boot_info_t}

const
  PROCESSOR_BASIC_INFO_COUNT    = mach_msg_type_number_t(SizeOf(processor_basic_info_data_t) div SizeOf(natural_t));
  {$EXTERNALSYM PROCESSOR_BASIC_INFO_COUNT}
  PROCESSOR_CPU_LOAD_INFO_COUNT = mach_msg_type_number_t(SizeOf(processor_cpu_load_info_data_t) div SizeOf(natural_t));
  {$EXTERNALSYM PROCESSOR_CPU_LOAD_INFO_COUNT}
  PROCESSOR_SET_BASIC_INFO_COUNT= mach_msg_type_number_t(SizeOf(processor_set_basic_info_data_t) div SizeOf(natural_t));
  {$EXTERNALSYM PROCESSOR_SET_BASIC_INFO_COUNT}
  PROCESSOR_SET_LOAD_INFO_COUNT = mach_msg_type_number_t(SizeOf(processor_set_load_info_data_t) div SizeOf(natural_t));
  {$EXTERNALSYM PROCESSOR_SET_LOAD_INFO_COUNT}
  HOST_BASIC_INFO_COUNT = mach_msg_type_number_t(SizeOf(host_basic_info_data_t) div SizeOf(Integer));
  {$EXTERNALSYM HOST_BASIC_INFO_COUNT}
  HOST_SCHED_INFO_COUNT = mach_msg_type_number_t(SizeOf(host_sched_info_data_t) div SizeOf(Integer));
  {$EXTERNALSYM HOST_SCHED_INFO_COUNT}
  HOST_RESOURCE_SIZES_COUNT = mach_msg_type_number_t(SizeOf(kernel_resource_sizes_data_t) div SizeOf(Integer));
  {$EXTERNALSYM HOST_RESOURCE_SIZES_COUNT}
  HOST_PRIORITY_INFO_COUNT = mach_msg_type_number_t(SizeOf(host_priority_info_data_t) div SizeOf(Integer));
  {$EXTERNALSYM HOST_PRIORITY_INFO_COUNT}
  HOST_LOAD_INFO_COUNT = mach_msg_type_number_t(SizeOf(host_load_info_data_t) div SizeOf(Integer));
  {$EXTERNALSYM HOST_LOAD_INFO_COUNT}
  HOST_CPU_LOAD_INFO_COUNT = mach_msg_type_number_t(SizeOf(host_cpu_load_info_data_t) div SizeOf(Integer));
  {$EXTERNALSYM HOST_CPU_LOAD_INFO_COUNT}

{$POINTERMATH OFF}

function mach_task_self: mach_port_t; cdecl
  external libc name _PU + 'mach_task_self';
{$EXTERNALSYM mach_task_self}

function mach_port_allocate(task: ipc_space_t; right: mach_port_right_t;
                            var name: mach_port_t): mach_port_t; cdecl
  external libc name _PU + 'mach_port_allocate';
{$EXTERNALSYM mach_port_allocate}

function mach_msg(var msg: mach_msg_header_t;
                  option: mach_msg_option_t;
                  SendSize: mach_msg_size_t;
                  RecvSize: mach_msg_size_t;
                  rcv_name: mach_port_name_t;
                  timeout: mach_msg_timeout_t;
                  notify: mach_port_name_t): mach_msg_return_t; cdecl
  external libc name _PU + 'mach_msg';

function mach_port_insert_right(task: ipc_space_t;
                                name: mach_port_name_t;
                                right: mach_port_t;
                                right_type: mach_msg_type_name_t): kern_return_t; cdecl
  external libc name _PU + 'mach_port_insert_right';
{$EXTERNALSYM mach_msg}

function thread_get_state(target_act: thread_act_t;
                          flavor: thread_state_flavor_t;
                          old_state: thread_state_t;
                          var old_stateCnt: mach_msg_type_number_t): kern_return_t; cdecl
  external libc name _PU + 'thread_get_state';
{$EXTERNALSYM thread_get_state}

function thread_set_state(target_act: thread_act_t;
                          flavor: thread_state_flavor_t;
                          new_state: thread_state_t;
                          new_stateCnt: mach_msg_type_number_t): kern_return_t; cdecl
  external libc name _PU + 'thread_set_state';
{$EXTERNALSYM thread_set_state}

function thread_suspend(target_act: thread_act_t): kern_return_t; cdecl
  external libc name _PU + 'thread_suspend';
{$EXTERNALSYM thread_suspend}

function thread_resume(target_act: thread_act_t): kern_return_t; cdecl
  external libc name _PU + 'thread_resume';
{$EXTERNALSYM thread_resume}

{$IF not defined(CPUARM32)}
function exc_server(var request_msg: mach_msg_header_t;
                    var reply_msg: mach_msg_header_t): Boolean; cdecl
  external libc name _PU + 'exc_server';
{$EXTERNALSYM exc_server}
{$ENDIF !CPUARM32}


function task_get_exception_ports(task: task_t;
                                  exception_types: exception_mask_t;
                                  masks: exception_mask_array_t;
                                  var masksCnt: mach_msg_type_number_t;
                                  old_handlers: exception_handler_array_t;
                                  old_behaviors: exception_behavior_array_t;
                                  old_flavors: exception_flavor_array_t
                                 ): kern_return_t; cdecl
  external libc name _PU + 'task_get_exception_ports';
{$EXTERNALSYM task_get_exception_ports}

function task_set_exception_ports(task: task_t;
                                  exception_types: exception_mask_t;
                                  new_port: mach_port_t;
                                  behavior: exception_behavior_t;
                                  new_flavor: thread_state_flavor_t
                                 ): kern_return_t; cdecl
  external libc name _PU + 'task_set_exception_ports';
{$EXTERNALSYM task_set_exception_ports}

{ vm_map.h }

function vm_allocate(target_task: vm_map_t;
                     out address: vm_address_t;
                     size: vm_size_t;
                     flags: Integer): kern_return_t; cdecl
  external libc name _PU + 'vm_allocate';
{$EXTERNALSYM vm_allocate}

function vm_deallocate(target_task: vm_map_t;
                       address: vm_address_t;
                       size: vm_size_t): kern_return_t; cdecl
  external libc name _PU + 'vm_deallocate';
{$EXTERNALSYM vm_allocate}

{ mach_host.h }
function host_get_clock_service(host: host_t; clock_id: clock_id_t; var clock_serv: clock_serv_t): kern_return_t; cdecl;
  external libc name _PU + 'host_get_clock_service';
{$EXTERNALSYM host_get_clock_service}

{ clock.h }
function clock_get_time(clock_serv: clock_serv_t; var cur_time: mach_timespec_t): kern_return_t; cdecl;
  external libc name _PU + 'clock_get_time';
{$EXTERNALSYM clock_get_time}

{ mach_info.h }

function mach_host_self: mach_port_t; cdecl
  external libc name _PU + 'mach_host_self';
{$EXTERNALSYM mach_host_self}

function mach_thread_self: mach_port_t; cdecl
  external libc name _PU + 'mach_thread_self';
{$EXTERNALSYM mach_thread_self}

function host_page_size(host: host_t; out size: vm_size_t): kern_return_t; cdecl
  external libc name _PU + 'host_page_size';
{$EXTERNALSYM host_page_size}

function host_info(host: host_t;
                   flavor: host_flavor_t;
                   host_info_out: host_info_t;
                   var host_info_outCnt: mach_msg_type_number_t): kern_return_t; cdecl
  external libc name _PU + 'host_info';
{$EXTERNALSYM host_info}

function host_kernel_version(host: host_t;
                             var kernel_version: kernel_version_t): kern_return_t; cdecl
  external libc name _PU + 'host_kernel_version';
{$EXTERNALSYM host_kernel_version}

function _host_page_size(host: host_t;
                         out out_page_size: vm_size_t): kern_return_t; cdecl
  external libc name _PU + '_host_page_size';
{$EXTERNALSYM _host_page_size}

function mach_memory_object_memory_entry(host: host_t;
                                         internal: boolean_t;
                                         size: vm_size_t;
                                         permission: vm_prot_t;
                                         pager: memory_object_t;
                                         var entry_handle: mach_port_t): kern_return_t; cdecl
  external libc name _PU + 'mach_memory_object_memory_entry';
{$EXTERNALSYM mach_memory_object_memory_entry}

function host_processor_info(host: host_t;
                             flavor: processor_flavor_t;
                             out out_processor_count: natural_t;
                             out out_processor_info: processor_info_array_t;
                             out out_processor_infoCnt: mach_msg_type_number_t): kern_return_t; cdecl
  external libc name _PU + 'host_processor_info';
{$EXTERNALSYM host_processor_info}

{
   exception_raise()
   exception_raise_state()
   exception_raise_state_identity()

 _mm_setcsr _MM_MASK_MASK _MM_MASK_OVERFLOW _MM_MASK_INVALID _MM_MASK_DIV_ZERO
}

function semaphore_create(task: task_t; out semaphore: semaphore_t; policy: Integer; value: Integer): kern_return_t; cdecl
  external libc name _PU + 'semaphore_create';
{$EXTERNALSYM semaphore_create}

function semaphore_destroy(task: task_t; semaphore: semaphore_t): kern_return_t; cdecl
  external libc name _PU + 'semaphore_destroy';
{$EXTERNALSYM semaphore_destroy}

function semaphore_signal(semaphore: semaphore_t): kern_return_t; cdecl
  external libc name _PU + 'semaphore_signal';
{$EXTERNALSYM semaphore_signal}

function semaphore_signal_all(semaphore: semaphore_t): kern_return_t; cdecl
  external libc name _PU + 'semaphore_signal_all';
{$EXTERNALSYM semaphore_signal_all}

function semaphore_wait(semaphore: semaphore_t): kern_return_t; cdecl
  external libc name _PU + 'semaphore_wait';
{$EXTERNALSYM semaphore_wait}

function semaphore_timedwait(semaphore: semaphore_t; wait_time: mach_timespec_t): kern_return_t; cdecl
  external libc name _PU + 'semaphore_timedwait';
{$EXTERNALSYM semaphore_timedwait}

function semaphore_timedwait_signal(wait_semaphore, signal_semaphore: semaphore_t; wait_time: mach_timespec_t): kern_return_t; cdecl
  external libc name _PU + 'semaphore_timedwait_signal';
{$EXTERNALSYM semaphore_timedwait_signal}

function semaphore_wait_signal(wait_semaphore, signal_semaphore: semaphore_t): kern_return_t; cdecl
  external libc name _PU + 'semaphore_wait_signal';
{$EXTERNALSYM semaphore_wait_signal}

function semaphore_signal_thread(semaphore: semaphore_t; thread: thread_t): kern_return_t; cdecl
  external libc name _PU + 'semaphore_signal_thread';
{$EXTERNALSYM semaphore_signal_thread}

function CPU_SUBTYPE_INTEL_FAMILY(Value: Integer): Integer; inline;
{$EXTERNALSYM CPU_SUBTYPE_INTEL_FAMILY}

function CPU_SUBTYPE_INTEL_MODEL(Value: Integer): Integer; inline;
{$EXTERNALSYM CPU_SUBTYPE_INTEL_MODEL}

{ mach_time.h }
type
TTimebaseInfoData = record
  Numer: UInt32;
  Denom: UInt32;
end;

function mach_absolute_time: UInt64; cdecl external libc name _PU + 'mach_absolute_time';
{$EXTERNALSYM mach_absolute_time}

function mach_timebase_info(var TimebaseInfoData: TTimebaseInfoData): Integer; cdecl
  external libc name _PU + 'mach_timebase_info';
{$EXTERNALSYM mach_timebase_info}

function mach_port_deallocate(task: ipc_space_t; name: mach_port_name_t): kern_return_t; cdecl
  external libc name _PU + 'mach_port_deallocate';
{$EXTERNALSYM mach_port_deallocate}

function AbsoluteToNanoseconds(AbsoluteTime: UInt64): UInt64;

implementation

function CPU_SUBTYPE_INTEL_FAMILY(Value: Integer): Integer; inline;
begin
  Result := Value and 15;
end;

function CPU_SUBTYPE_INTEL_MODEL(Value: Integer): Integer; inline;
begin
  Result := Value shr 4;
end;

function AbsoluteToNanoseconds(AbsoluteTime: UInt64): UInt64;
var
  Info: TTimebaseInfoData;
begin
  mach_timebase_info(Info);
  Result := AbsoluteTime * Info.Numer;
  Result := Result div Info.Denom;
end;


end.
