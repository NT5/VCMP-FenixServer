#include <stdio.h>
#include "SQMain.h"
#include "SQConsts.h"
#include "SQFuncs.h"
#include <GeoIP.h>

SQAPI sq;
GeoIP * gi;
int refcount = 0;

/*
 * SQLoad() is called when the script requests loading this module. This is where module
 * initialization and native function/constant registering is done.
 */
LU_EXPORT SQRESULT SQLoad( HSQUIRRELVM v, SQAPI api )
{
    if(refcount > 0)
    {
        refcount++;
    }
    else
    {
        printf( "[GeoIP] Crys' GeoIP module is initializing... " );
        
        sq = api;
        gi = GeoIP_open("GeoIP.dat", GEOIP_STANDARD | GEOIP_CHECK_CACHE);
    
        if (gi == NULL) {
            printf( "failed. :( Make sure that GeoIP.dat is in the server's root directory.\n" );
            return SQ_ERROR;
        }
        
        refcount = 1;
        
        printf( "done.\n" );
    }
    RegisterConsts( v );
    RegisterFuncs( v );
    return SQ_OK;
}

/*
 * SQUnload() gets called when a script calls UnloadModule() or the script using this module
 * is being unloaded. Usually nothing is required to do here, if the module allocates memory
 * for its own usage this memory should be freed.
 */
LU_EXPORT SQRESULT SQUnload( void )
{
    if(--refcount > 0)
    {
        return SQ_OK;
    }
    if (gi != NULL)
    {
        GeoIP_delete(gi);
        gi = NULL;
    }
    return SQ_OK;
}

/*
 * SQCallback is reserved for possible future callbacks.
 * For a list of callbacks, check enum eSquirrelCallback in SQModule.h
 */
LU_EXPORT SQRESULT SQCallback( unsigned int uiCallback, void* pData )
{
    return SQ_OK;
}

/*
 * SQPulse() is a function which gets called on every server cycle.
 */
LU_EXPORT SQRESULT SQPulse( void )
{
    return SQ_OK;
}
