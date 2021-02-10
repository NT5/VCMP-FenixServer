#include "SQFuncs.h"
#include <stdio.h>
#include <GeoIP.h>

extern SQAPI sq;
extern GeoIP * gi;

_SQUIRRELDEF(SQ_geoip_num_countries) {
    sq->pushinteger(v, (SQInteger) GeoIP_num_countries());
	return 1;
}

_SQUIRRELDEF(SQ_geoip_database_info) {
    const char * result;
    result = GeoIP_database_info(gi);
    if (result != NULL) {
        sq->pushstring(v, _SC(result), -1);
        return 1;
    }
    sq->pushnull(v);
	return 1;
}

_SQUIRRELDEF(SQ_geoip_lib_version) {
    const char * result;
    result = GeoIP_lib_version();
    if (result != NULL) {
        sq->pushstring(v, _SC(result), -1);
        return 1;
    }
    sq->pushnull(v);
	return 1;
}

_SQUIRRELDEF(SQ_geoip_database_edition) {
    sq->pushinteger(v, (SQInteger) GeoIP_database_edition(gi));
	return 1;
}

_SQUIRRELDEF(SQ_geoip_charset) {
    sq->pushinteger(v, (SQInteger) GeoIP_charset(gi));
	return 1;
}

_SQUIRRELDEF(SQ_geoip_set_charset) {
	SQInteger iArgCount = sq->gettop(v);
	if (iArgCount == 2) {
        SQInteger charset;
        sq->getinteger(v, 2, &charset);
        if (charset == GEOIP_CHARSET_UTF8 || charset == GEOIP_CHARSET_ISO_8859_1) {
            GeoIP_set_charset(gi, charset);
            sq->pushbool(v, SQTrue);
            return 1;
        }
    }
    sq->pushbool(v, SQFalse);
    return 1;
}

_SQUIRRELDEF(SQ_geoip_addr_to_num) {
	SQInteger iArgCount = sq->gettop(v);
	if (iArgCount == 2) {
        const SQChar * ipAddress;
        sq->getstring(v, 2, &ipAddress);
        unsigned long result = GeoIP_addr_to_num(ipAddress);
        if (result >= 0) {
            sq->pushinteger(v, (SQInteger) result);
            return 1;
        }
    }
    sq->pushnull(v);
	return 1;
}

_SQUIRRELDEF(SQ_geoip_num_to_addr) {
	SQInteger iArgCount = sq->gettop(v);
	if (iArgCount == 2) {
        SQInteger longip;
        sq->getinteger(v, 2, &longip);
        const char * result = GeoIP_num_to_addr(longip);
        if (result != NULL) {
            sq->pushstring(v, _SC(result), -1);
            return 1;
        }
    }
    sq->pushnull(v);
	return 1;
}

_SQUIRRELDEF(SQ_geoip_country_code_by_addr) {
	SQInteger iArgCount = sq->gettop(v);
	if (iArgCount == 2) {
        const char * returnedCountry;
        const SQChar * ipAddress;
        sq->getstring(v, 2, &ipAddress);
        returnedCountry = GeoIP_country_code_by_addr(gi, ipAddress);
        if (returnedCountry != NULL) {
            sq->pushstring(v, _SC(returnedCountry), -1);
            return 1;
        }
    }
    sq->pushnull(v);
	return 1;
}

_SQUIRRELDEF(SQ_geoip_country_code_by_name) {
	SQInteger iArgCount = sq->gettop(v);
	if (iArgCount == 2) {
        const char * returnedCountry;
        const SQChar * ipAddress;
        sq->getstring(v, 2, &ipAddress);
        returnedCountry = GeoIP_country_code_by_name(gi, ipAddress);
        if (returnedCountry != NULL) {
            sq->pushstring(v, _SC(returnedCountry), -1);
            return 1;
        }
    }
    sq->pushnull(v);
	return 1;
}

_SQUIRRELDEF(SQ_geoip_country_code3_by_addr) {
	SQInteger iArgCount = sq->gettop(v);
	if (iArgCount == 2) {
        const char * returnedCountry;
        const SQChar * ipAddress;
        sq->getstring(v, 2, &ipAddress);
        returnedCountry = GeoIP_country_code3_by_addr(gi, ipAddress);
        if (returnedCountry != NULL) {
            sq->pushstring(v, _SC(returnedCountry), -1);
            return 1;
        }
    }
    sq->pushnull(v);
	return 1;
}

_SQUIRRELDEF(SQ_geoip_country_code3_by_name) {
	SQInteger iArgCount = sq->gettop(v);
	if (iArgCount == 2) {
        const char * returnedCountry;
        const SQChar * ipAddress;
        sq->getstring(v, 2, &ipAddress);
        returnedCountry = GeoIP_country_code3_by_name(gi, ipAddress);
        if (returnedCountry != NULL) {
            sq->pushstring(v, _SC(returnedCountry), -1);
            return 1;
        }
    }
    sq->pushnull(v);
	return 1;
}

_SQUIRRELDEF(SQ_geoip_country_name_by_addr) {
	SQInteger iArgCount = sq->gettop(v);
	if (iArgCount == 2) {
        const char * returnedCountry;
        const SQChar * ipAddress;
        sq->getstring(v, 2, &ipAddress);
        returnedCountry = GeoIP_country_name_by_addr(gi, ipAddress);
        if (returnedCountry != NULL) {
            sq->pushstring(v, _SC(returnedCountry), -1);
            return 1;
        }
    }
    sq->pushnull(v);
	return 1;
}

_SQUIRRELDEF(SQ_geoip_country_name_by_name) {
	SQInteger iArgCount = sq->gettop(v);
	if (iArgCount == 2) {
        const char * returnedCountry;
        const SQChar * ipAddress;
        sq->getstring(v, 2, &ipAddress);
        returnedCountry = GeoIP_country_name_by_name(gi, ipAddress);
        if (returnedCountry != NULL) {
            sq->pushstring(v, _SC(returnedCountry), -1);
            return 1;
        }
    }
    sq->pushnull(v);
	return 1;
}

_SQUIRRELDEF(SQ_geoip_country_name_by_ipnum) {
	SQInteger iArgCount = sq->gettop(v);
	if (iArgCount == 2) {
        const char * returnedCountry;
        SQInteger ipnum;
        sq->getinteger(v, 2, &ipnum);
        returnedCountry = GeoIP_country_name_by_ipnum(gi, ipnum);
        if (returnedCountry != NULL) {
            sq->pushstring(v, _SC(returnedCountry), -1);
            return 1;
        }
    }
    sq->pushnull(v);
	return 1;
}

_SQUIRRELDEF(SQ_geoip_country_code_by_ipnum) {
	SQInteger iArgCount = sq->gettop(v);
	if (iArgCount == 2) {
        const char * returnedCountry;
        SQInteger ipnum;
        sq->getinteger(v, 2, &ipnum);
        returnedCountry = GeoIP_country_code_by_ipnum(gi, ipnum);
        if (returnedCountry != NULL) {
            sq->pushstring(v, _SC(returnedCountry), -1);
            return 1;
        }
    }
    sq->pushnull(v);
	return 1;
}

_SQUIRRELDEF(SQ_geoip_country_code3_by_ipnum) {
	SQInteger iArgCount = sq->gettop(v);
	if (iArgCount == 2) {
        const char * returnedCountry;
        SQInteger ipnum;
        sq->getinteger(v, 2, &ipnum);
        returnedCountry = GeoIP_country_code3_by_ipnum(gi, ipnum);
        if (returnedCountry != NULL) {
            sq->pushstring(v, _SC(returnedCountry), -1);
            return 1;
        }
    }
    sq->pushnull(v);
	return 1;
}

SQInteger RegisterSquirrelFunc(HSQUIRRELVM v, SQFUNCTION f, const SQChar* fname, unsigned char ucParams, const SQChar* szParams) {
	char szNewParams[32];

	sq->pushroottable(v);
	sq->pushstring(v, fname, -1);
	sq->newclosure(v, f, 0); /* create a new function */

	if (ucParams > 0) {
		ucParams++; /* This is to compensate for the root table */
		sprintf(szNewParams, "t%s", szParams);
		sq->setparamscheck(v, ucParams, szNewParams); /* Add a param type check */
	}

	sq->setnativeclosurename(v, -1, fname);
	sq->newslot(v, -3, SQFalse);
	sq->pop(v, 1);

	return 0;
}

void RegisterFuncs(HSQUIRRELVM v) {
	RegisterSquirrelFunc(v, SQ_geoip_num_countries, "geoip_num_countries", 0, 0);
	RegisterSquirrelFunc(v, SQ_geoip_database_info, "geoip_database_info", 0, 0);
	RegisterSquirrelFunc(v, SQ_geoip_lib_version, "geoip_lib_version", 0, 0);
	RegisterSquirrelFunc(v, SQ_geoip_database_edition, "geoip_database_edition", 0, 0);

	RegisterSquirrelFunc(v, SQ_geoip_charset, "geoip_charset", 0, 0);
	RegisterSquirrelFunc(v, SQ_geoip_set_charset, "geoip_set_charset", 1, "i");

	RegisterSquirrelFunc(v, SQ_geoip_addr_to_num, "geoip_addr_to_num", 1, "s");
	RegisterSquirrelFunc(v, SQ_geoip_num_to_addr, "geoip_num_to_addr", 1, "i");

	RegisterSquirrelFunc(v, SQ_geoip_country_code_by_addr, "geoip_country_code_by_addr", 1, "s");
	RegisterSquirrelFunc(v, SQ_geoip_country_code_by_name, "geoip_country_code_by_name", 1, "s");
	RegisterSquirrelFunc(v, SQ_geoip_country_code_by_ipnum, "geoip_country_code_by_ipnum", 1, "i");

	RegisterSquirrelFunc(v, SQ_geoip_country_code3_by_addr, "geoip_country_code3_by_addr", 1, "s");
	RegisterSquirrelFunc(v, SQ_geoip_country_code3_by_name, "geoip_country_code3_by_name", 1, "s");
	RegisterSquirrelFunc(v, SQ_geoip_country_code3_by_ipnum, "geoip_country_code3_by_ipnum", 1, "i");

	RegisterSquirrelFunc(v, SQ_geoip_country_name_by_addr, "geoip_country_name_by_addr", 1, "s");
	RegisterSquirrelFunc(v, SQ_geoip_country_name_by_name, "geoip_country_name_by_name", 1, "s");
	RegisterSquirrelFunc(v, SQ_geoip_country_name_by_ipnum, "geoip_country_name_by_ipnum", 1, "i");
}