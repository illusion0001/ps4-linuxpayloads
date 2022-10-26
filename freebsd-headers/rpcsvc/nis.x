%/*
% * Sun RPC is a product of Sun Microsystems, Inc. and is provided for
% * unrestricted use provided that this legend is included on all tape
% * media and as a part of the software program in whole or part.  Users
% * may copy or modify Sun RPC without charge, but are not authorized
% * to license or distribute it to anyone else except as part of a product or
% * program developed by the user or with the express written consent of
% * Sun Microsystems, Inc.
% *
% * SUN RPC IS PROVIDED AS IS WITH NO WARRANTIES OF ANY KIND INCLUDING THE
% * WARRANTIES OF DESIGN, MERCHANTIBILITY AND FITNESS FOR A PARTICULAR
% * PURPOSE, OR ARISING FROM A COURSE OF DEALING, USAGE OR TRADE PRACTICE.
% *
% * Sun RPC is provided with no support and without any obligation on the
% * part of Sun Microsystems, Inc. to assist in its use, correction,
% * modification or enhancement.
% *
% * SUN MICROSYSTEMS, INC. SHALL HAVE NO LIABILITY WITH RESPECT TO THE
% * INFRINGEMENT OF COPYRIGHTS, TRADE SECRETS OR ANY PATENTS BY SUN RPC
% * OR ANY PART THEREOF.
% *
% * In no event will Sun Microsystems, Inc. be liable for any lost revenue
% * or profits or other special, indirect and consequential damages, even if
% * Sun has been advised of the possibility of such damages.
% *
% * Sun Microsystems, Inc.
% * 2550 Garcia Avenue
% * Mountain View, California  94043
% */

#ifndef RPC_HDR
%#include <sys/cdefs.h>
%__FBSDID("$FreeBSD: release/9.0.0/include/rpcsvc/nis.x 114629 2003-05-04 02:51:42Z obrien $");
#endif

/* 
 * From 4.1 : @(#)nis.x	1.61 Copyright 1989 Sun Microsystems
 *
 * RPC Language Protocol description file for NIS Plus
 * This version : 1.61
 * Last Modified : 3/19/91
 */
#ifdef RPC_HDR
%/*
% *	nis.h
% *
% *	This file is the main include file for NIS clients. It contains
% *	both the client library function defines and the various data
% * 	structures used by the NIS service. It includes the file nis_tags.h
% *	which defines the tag values. This allows the tags to change without
% *	having to change the nis.x file.
% * 	
% *	NOTE : DO NOT EDIT THIS FILE! It is automatically generated when
% *	       rpcgen is run on the nis.x file. Note that there is a 
% *	       simple sed script to remove some unneeded lines. (See the
% *	       Makefile target nis.h)
% *
% */
%#include <rpcsvc/nis_tags.h>
#endif

/* This gets stuffed into the source files. */
#if RPC_HDR
%#include <rpc/xdr.h>
#endif
/*
 * This is just pointless.
 */
#ifdef SUN_STUPIDITY
#if RPC_SVC
%#include "nis_svc.h"
#endif
#endif

/* Include the RPC Language description of NIS objects */
#include "nis_object.x"

/* Errors  that can be returned by the service */
enum nis_error {
	NIS_SUCCESS = 0,	/* A-ok, let's rock n roll 	*/
	NIS_S_SUCCESS = 1,	/* Name found (maybe)	   	*/
	NIS_NOTFOUND = 2,	/* Name definitely not found 	*/
	NIS_S_NOTFOUND = 3,	/* Name maybe not found 	*/
	NIS_CACHEEXPIRED = 4,	/* Name exists but cache out of date */
	NIS_NAMEUNREACHABLE = 5, /* Can't get there from here */
	NIS_UNKNOWNOBJ = 6,	/* Object type is bogus */
	NIS_TRYAGAIN = 7,	/* I'm busy, call back */
	NIS_SYSTEMERROR = 8,	/* Out of band failure */
	NIS_CHAINBROKEN = 9,	/* First/Next warning */
	NIS_PERMISSION = 10,	/* Not enough permission to access */
	NIS_NOTOWNER = 11,	/* You don't own it, sorry */
	NIS_NOT_ME = 12,	/* I don't serve this name */
	NIS_NOMEMORY = 13,	/* Outta VM! Help! */
	NIS_NAMEEXISTS = 14,	/* Can't create over another name */
	NIS_NOTMASTER = 15,	/* I'm justa secondaray, don't ask me */
	NIS_INVALIDOBJ = 16,	/* Object is broken somehow */
	NIS_BADNAME = 17,	/* Unparsable name */
	NIS_NOCALLBACK = 18,	/* Couldn't talk to call back proc */
	NIS_CBRESULTS = 19,	/* Results being called back to you */
	NIS_NOSUCHNAME = 20,	/* Name unknown */
	NIS_NOTUNIQUE = 21,	/* Value is not uniques (entry) */
	NIS_IBMODERROR = 22,	/* Inf. Base. Modify error. */
	NIS_NOSUCHTABLE = 23,	/* Name for table was wrong */
	NIS_TYPEMISMATCH = 24, 	/* Entry and table type mismatch */
	NIS_LINKNAMEERROR = 25,	/* Link points to bogus name */
	NIS_PARTIAL = 26,	/* Partial success, found table */
	NIS_TOOMANYATTRS = 27,	/* Too many attributes */
	NIS_RPCERROR = 28,	/* RPC error encountered */
	NIS_BADATTRIBUTE = 29,	/* Bad or invalid attribute */
	NIS_NOTSEARCHABLE = 30,	/* Non-searchable object searched */
	NIS_CBERROR = 31,	/* Error during callback (svc crash) */
	NIS_FOREIGNNS = 32,	/* Foreign Namespace */
	NIS_BADOBJECT = 33,	/* Malformed object structure */
	NIS_NOTSAMEOBJ = 34,	/* Object swapped during deletion */
	NIS_MODFAIL = 35,	/* Failure during a Modify. */
	NIS_BADREQUEST = 36,	/* Illegal query for table */
	NIS_NOTEMPTY = 37,	/* Attempt to remove a non-empty tbl */
	NIS_COLDSTART_ERR = 38, /* Error accesing the cold start file */
	NIS_RESYNC = 39,	/* Transaction log too far out of date */
	NIS_FAIL = 40,		/* NIS operation failed. */
	NIS_UNAVAIL = 41,	/* NIS+ service is unavailable (client) */
	NIS_RES2BIG = 42,	/* NIS+ result too big for datagram */
	NIS_SRVAUTH = 43,	/* NIS+ server wasn't authenticated. */
	NIS_CLNTAUTH = 44,	/* NIS+ Client wasn't authenticated. */
	NIS_NOFILESPACE = 45,	/* NIS+ server ran out of disk space */
	NIS_NOPROC = 46,	/* NIS+ server couldn't create new proc */
	NIS_DUMPLATER = 47	/* NIS+ server already has dump child */
};


/* 
 * Structure definitions for the parameters and results of the actual
 * NIS RPC calls.
 *
 * This is the standard result (in the protocol) of most of the nis 
 * requests.
 */

struct nis_result {
	nis_error	status;		/* Status of the response */
	nis_object	objects<>;	/* objects found 	  */
	netobj		cookie;		/* Cookie Data 		  */
	u_long		zticks;		/* server ticks	 	  */
	u_long		dticks;		/* DBM ticks.		  */
	u_long		aticks;		/* Cache (accel) ticks	  */
	u_long		cticks;		/* Client ticks		  */
};

/* 
 * A Name Service request 
 * This request is used to access the name space, ns_name is the name 
 * of the object within the namespace and the object is it's value, for
 * add/modify, a copy of the original for remove. 
 */

struct ns_request {
	nis_name	ns_name;	/* Name in the NIS name space	*/
	nis_object	ns_object<1>;	/* Optional Object (add/remove)	*/
};

/* 
 * An information base request
 * This request includes the NIS name of the table we wish to search, the
 * search criteria in the form of attribute/value pairs and an optional
 * callback program number. If the callback program number is provided
 * the server will send back objects one at a time, otherwise it will
 * return them all in the response.
 */

struct ib_request {
	nis_name  	ibr_name;	/* The name of the Table 	*/
	nis_attr  	ibr_srch<>; 	/* The search critereia 	*/
	u_long		ibr_flags;	/* Optional flags 		*/
	nis_object	ibr_obj<1>;	/* optional object (add/modify) */
	nis_server	ibr_cbhost<1>;	/* Optional callback info	*/
	u_long		ibr_bufsize;	/* Optional first/next bufsize	*/
	netobj		ibr_cookie;	/* The first/next cookie	*/
};

/*
 * This argument to the PING call notifies the replicas that something in 
 * a directory has changed and this is it's timestamp. The replica will use
 * the timestamp to determine if its resync operation was successful.
 */
struct ping_args {
	nis_name	dir;	/* Directory that had the change */
	u_long		stamp;	/* timestamp of the transaction  */
};

/* 
 * These are the type of entries that are stored in the transaction log, 
 * note that modifications will appear as two entries, for names, they have
 * an "OLD" entry followed by a "NEW" entry. For entries in tables, there
 * is a remove followed by an add. It is done this way so that we can read
 * the log backwards to back out transactions and forwards to propogate
 * updated.
 */
enum log_entry_t {
	LOG_NOP = 0,
	ADD_NAME = 1,		/* Name Added to name space 		  */
	REM_NAME = 2,		/* Name removed from name space 	  */
	MOD_NAME_OLD = 3,	/* Name was modified in the name space 	  */
	MOD_NAME_NEW = 4,	/* Name was modified in the name space 	  */
	ADD_IBASE = 5,		/* Entry added to information base 	  */
	REM_IBASE = 6,		/* Entry removed from information base    */
	MOD_IBASE = 7,		/* Entry was modified in information base */
	UPD_STAMP = 8		/* Update timestamp (used as fenceposts)  */
};
	
/*
 * This result is returned from the name service when it is requested to 
 * dump logged entries from its transaction log. Information base updates
 * will have the name of the information base in the le_name field and
 * a canonical set of attribute/value pairs to fully specify the entry's
 * 'name'. 
 */
struct log_entry {
	u_long		le_time;	/* Time in seconds 		*/
	log_entry_t	le_type;	/* Type of log entry 		*/
	nis_name	le_princp;	/* Principal making the change	*/
	nis_name	le_name;	/* Name of table/dir involved 	*/
	nis_attr	le_attrs<>;	/* List of AV pairs.		*/
	nis_object	le_object;	/* Actual object value 		*/
};

struct log_result {
	nis_error 	lr_status;	/* The status itself 	 	*/
	netobj		lr_cookie;	/* Used by the dump callback	*/
	log_entry	lr_entries<>;	/* zero or more entries 	*/
};
	
struct cp_result {
	nis_error	cp_status;	/* Status of the checkpoint 	*/
	u_long		cp_zticks;	/* Service 'ticks' 	    	*/
	u_long		cp_dticks;	/* Database 'ticks'	    	*/
};

/*
 * This structure defines a generic NIS tag list. The taglist contains
 * zero or tags, each of which is a type and a value. (u_long). 
 * These are used to report statistics (see tag definitions below)
 * and to set or reset state variables.
 */
struct nis_tag {
	u_long	tag_type;	/* Statistic tag (may vary) 	 */
	string	tag_val<1024>;	/* Statistic value may also vary */
};

struct nis_taglist {
	nis_tag tags<>;		/* List of tags */
};

struct dump_args {
	nis_name	da_dir;		/* Directory to dump 	*/
	u_long		da_time;	/* From this timestamp	*/
	nis_server	da_cbhost<1>;	/* Callback to use.	*/
};

struct fd_args {
	nis_name	dir_name;  /* The directory we're looking for */
	nis_name	requester; /* Host principal name for signature */
};

struct fd_result {
	nis_error	status;		/* Status returned by function	*/
	nis_name	source;		/* Source of this answer   	*/
	opaque		dir_data<>;	/* Directory Data (XDR'ed) 	*/ 
	opaque		signature<>;	/* Signature of the source 	*/
};


/* 
 * What's going on here? Well, it's like this. When the service
 * is being compiled it wants to have the service definition specific
 * info included, and when the client is being compiled it wants that
 * info. This includes the appropriate file which was generated by
 * make in the protocols directory (probably /usr/include/rpcsvc).
 *
 * Uhm... guys? With RPC, you aren't supposed to have separate
 * server-specific and client-specific header files. You have one header
 * file that's suitable for both. If your code doesn't work using just
 * the one header file, I submit to you that it's broken.
 *							-Bill
 */
#ifdef SUN_STUPIDITY
#ifdef RPC_SVC
%#include "nis_svc.h"
#endif
#ifdef RPC_CLNT
%#include "nis_clnt.h"
#endif
#endif

program  NIS_PROG {

	/* RPC Language description of the NIS+ protocol */
	version NIS_VERSION {
		/* The name service functions */
		nis_result  NIS_LOOKUP(ns_request) = 1;
		nis_result  NIS_ADD(ns_request) = 2;
		nis_result  NIS_MODIFY(ns_request) = 3;
		nis_result  NIS_REMOVE(ns_request) = 4;

		/* The information base functions */
		nis_result  NIS_IBLIST(ib_request) = 5;
		nis_result  NIS_IBADD(ib_request) = 6;
		nis_result  NIS_IBMODIFY(ib_request) = 7;
		nis_result  NIS_IBREMOVE(ib_request) = 8;
		nis_result  NIS_IBFIRST(ib_request) = 9;
		nis_result  NIS_IBNEXT(ib_request) = 10;

		/* NIS Administrative functions */
		fd_result   NIS_FINDDIRECTORY(fd_args) = 12;

		/* If fetch and optionally reset statistics */
		nis_taglist  NIS_STATUS(nis_taglist) = 14;
		
		/* Dump changes to directory since time in da_time */
		log_result  NIS_DUMPLOG(dump_args) = 15;
		
		/* Dump contents of directory named */
		log_result  NIS_DUMP(dump_args) = 16;

		/* Check status of callback thread */
		bool	    NIS_CALLBACK(netobj) = 17;

		/* Return last update time for named dir */
		u_long      NIS_CPTIME(nis_name) = 18;

		/* Checkpoint directory or table named */
		cp_result   NIS_CHECKPOINT(nis_name) = 19;

		/* Send 'status changed' ping to replicates */
		void	    NIS_PING(ping_args) = 20;
	
		/* Modify server behaviour (such as debugging) */
		nis_taglist NIS_SERVSTATE(nis_taglist) = 21;
	
		/* Create a Directory */
		nis_error   NIS_MKDIR(nis_name) = 22;
	
		/* Remove a Directory */
		nis_error   NIS_RMDIR(nis_name) = 23;
		
		/* Update public keys of a directory object */
		nis_error   NIS_UPDKEYS(nis_name) = 24;
	} = 3;
} = 100300;

/*
 * Included below are the defines that become part of nis.h,
 * they are technically not part of the protocol, but do define
 * key aspects of the implementation and are therefore useful
 * in building a conforming server or client.
 */
#if RPC_HDR
%/*
% * Generic "hash" datastructures, used by all types of hashed data.
% */
%struct nis_hash_data {
%	nis_name		name;	   /* NIS name of hashed item      */
%	int			keychain;  /* It's hash key (for pop)      */
%	struct nis_hash_data	*next;	   /* Hash collision pointer       */
%	struct nis_hash_data	*prv_item; /* A serial, doubly linked list */
%	struct nis_hash_data	*nxt_item; /* of items in the hash table   */
%};
%typedef struct nis_hash_data NIS_HASH_ITEM;
%
%struct nis_hash_table {
%	NIS_HASH_ITEM	*keys[64];	/* A hash table of items           */
%	NIS_HASH_ITEM	*first;		/* The first "item" in serial list */
%};
%typedef struct nis_hash_table NIS_HASH_TABLE;
%
%/* Structure for storing dynamically allocated static data */
%struct nis_sdata {
%	void	*buf;	/* Memory allocation pointer 	*/
%	u_long	size;	/* Buffer size			*/
%};
%
%/* Generic client creating flags */
%#define ZMH_VC		1
%#define ZMH_DG		2
%#define ZMH_AUTH	4
%
%/* Testing Access rights for objects */
%
%#define NIS_READ_ACC		1
%#define NIS_MODIFY_ACC		2
%#define NIS_CREATE_ACC		4
%#define NIS_DESTROY_ACC	8
%/* Test macros. a == access rights, m == desired rights. */
%#define WORLD(a, m)	(((a) & (m)) != 0)
%#define GROUP(a, m)	(((a) & ((m) << 8)) != 0)
%#define OWNER(a, m)	(((a) & ((m) << 16)) != 0)
%#define NOBODY(a, m)	(((a) & ((m) << 24)) != 0)
%
%#define OATYPE(d, n) (((d)->do_armask.do_armask_val+n)->oa_otype)
%#define OARIGHTS(d, n) (((d)->do_armask.do_armask_val+n)->oa_rights)
%#define WORLD_DEFAULT (NIS_READ_ACC)
%#define GROUP_DEFAULT (NIS_READ_ACC << 8)
%#define OWNER_DEFAULT ((NIS_READ_ACC +\
			 NIS_MODIFY_ACC +\
			 NIS_CREATE_ACC +\
			 NIS_DESTROY_ACC) << 16)
%#define DEFAULT_RIGHTS (WORLD_DEFAULT | GROUP_DEFAULT | OWNER_DEFAULT)
%
%/* Result manipulation defines ... */
%#define NIS_RES_NUMOBJ(x)	((x)->objects.objects_len)
%#define NIS_RES_OBJECT(x)	((x)->objects.objects_val)
%#define NIS_RES_COOKIE(x)	((x)->cookie)
%#define NIS_RES_STATUS(x)	((x)->status)
%
%/* These defines make getting at the variant part of the object easier. */
%#define TA_data zo_data.objdata_u.ta_data
%#define EN_data zo_data.objdata_u.en_data
%#define DI_data zo_data.objdata_u.di_data
%#define LI_data zo_data.objdata_u.li_data
%#define GR_data zo_data.objdata_u.gr_data
%
%#define __type_of(o) ((o)->zo_data.zo_type)
%
%/* Declarations for the internal subroutines in nislib.c */
%enum name_pos {SAME_NAME, HIGHER_NAME, LOWER_NAME, NOT_SEQUENTIAL, BAD_NAME};
%typedef enum name_pos name_pos;
%
%/*
% * Defines for getting at column data in entry objects. Because RPCGEN
% * generates some rather wordy structures, we create some defines that
% * collapse the needed keystrokes to access a particular value using
% * these definitions they take an nis_object *, and an int and return
% * a u_char * for Value, and an int for length.
% */
%#define ENTRY_VAL(obj, col) \
	(obj)->EN_data.en_cols.en_cols_val[col].ec_value.ec_value_val
%#define ENTRY_LEN(obj, col) \
	(obj)->EN_data.en_cols.en_cols_val[col].ec_value.ec_value_len
%
%#ifdef __cplusplus
%}
%#endif
%
%/* Prototypes, and extern declarations for the NIS library functions. */
%#include <rpcsvc/nislib.h>
%#endif /* __NIS_RPCGEN_H */
%/* EDIT_START */
%
%/*
% * nis_3.h
% * 
% * This file contains definitions that are only of interest to the actual
% * service daemon and client stubs. Normal users of NIS will not include
% * this file.
% *
% * NOTE : This include file is automatically created by a combination 
% * of rpcgen and sed. DO NOT EDIT IT, change the nis.x file instead
% * and then remake this file.
% */
%#ifndef __nis_3_h
%#define __nis_3_h
%#ifdef __cplusplus
%extern "C" {
%#endif
#endif
