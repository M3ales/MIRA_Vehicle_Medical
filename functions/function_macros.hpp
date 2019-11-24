#include "..\config_macros.hpp"
#define LOG_BASE(level,msg) diag_log (QUOTE(ADDON[level]: )  + msg)
#define LOG(msg) LOG_BASE(DEBUG,msg)
#define LOG_ERROR(msg) LOG_BASE(ERR,msg)